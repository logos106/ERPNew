unit ObjDataSync;

interface

uses
  MyAccess, SyncObj, db, UserLockBaseObj, classes, JSONObject, contnrs,
  LogMessageTypes;

type

  TSyncObjectResult = (srOk, {srDestIsNewer,} srTempFail, srPermFail);

  TSyncUserLock = class
  private
    fUserLock: TUserLockBase;
    fLocked: boolean;
    function GetConnection: TMyConnection;
    function GetLocked: boolean;
    procedure SetConnection(const Value: TMyConnection);
  public
    constructor Create;
    destructor Destroy; override;
    property Connection: TMyConnection read GetConnection write SetConnection;
    function Lock(Obj: TSyncObj; GlobalRef: string; var msg: string): boolean;
    procedure Unlock;
    property Locked: boolean read GetLocked;
    procedure DumpLocksToFile(fileName: string);
  end;

  TDataSyncList = class;
  TDataSyncItem = class(TObject)
  private
    SourceLock: TSyncUserLock;
    DestLock: TSyncUserLock;
    SourceObj, DestObj: TSyncObj;
    fList: TDataSyncList;
    SourceGlobalRef: string;
    MySQLZeroTimeStamp: TDateTime;
    function GetDataset(sql: string; dbConn: TMyConnection): TDataSet;
    procedure LoadObj(Obj: TSyncObj; GlobalRef: string; dbConn: TMyConnection); overload;
    procedure LoadObj(Obj: TSyncObj; ds: TDataset; dbConn: TMyConnection); overload;
    function DoSync(const source, dest: TSyncObj; var msg: string): boolean;
    function ItemByGlobalRef(aObj: TSyncObj; aGlobalRef: string): TSyncObj;
    procedure SaveOrDelete(obj: TSyncObj; deleteObject: boolean = false);
    procedure Delete(Obj: TSyncObj; dbConn: TMyConnection);
    procedure SaveObj(Obj: TSyncObj; GlobalRef: string; dbConn: TMyConnection);
  public
    constructor Create(aList: TDataSyncList; aSourceGlobalRef: string);
    destructor Destroy; override;
    property List: TDataSyncList read fList;
    function Lock(var msg: string): TSyncObjectResult;
    procedure Unlock;
    function Load(var msg: string): TSyncObjectResult;
    function SyncObject(var msg: string): TSyncObjectResult;
    procedure Save;
  end;

  TSendNotificationEvent = procedure (msg: string; msgType: TLogMessageType) of object;

  TDataSyncList = class(TObject)
  private
    fList: TObjectList;
//    fDestTimeDiffToAdd: TDateTime;
    fSchema: TJSONObject;
    fSourceConn: TMyConnection;
    fDestConn: TMyConnection;
    fSyncObjClassName: string;
//    fDestTimeZoneMins: integer;
    fOnSendNotification: TSendNotificationEvent;
    procedure SetDestConn(const Value: TMyConnection);
    procedure SetSourceConn(const Value: TMyConnection);
    function GetItem(index: integer): TDataSyncItem;
    function GetCount: integer;
  protected
    property Items[index: integer]: TDataSyncItem read GetItem;
    property Count: integer read GetCount;
  public
    constructor Create;
    destructor Destroy; override;
    property SourceConn: TMyConnection read fSourceConn write SetSourceConn;
    property DestConn: TMyConnection read fDestConn write SetDestConn;
    function SyncObjects(aClassName, aSourceGlobalRefList: string;
                        var msg: string): TSyncObjectResult;
//    property DestTimeDiffToAdd: TDateTime read fDestTimeDiffToAdd write fDestTimeDiffToAdd;
//    property DestTimeZoneMins: integer read fDestTimeZoneMins write fDestTimeZoneMins;
    property Schema: TJSONObject read fSchema write fSchema;
    function GetSyncObj(aClassName: string; aParent: TSyncObj = nil; LoadSubObjects: boolean = true): TSyncObj;
    property SyncObjClassName: string read fSyncObjClassName;
    procedure SendNotification(msg: string; msgType: TLogMessageType);
    property OnSendNotification: TSendNotificationEvent read fOnSendNotification write fOnSendNotification;
  end;

implementation

uses
  SysUtils, ValueFields, LogThreadLib, DbConst, MultisiteConst;

Const
  ObjectType_Full = 'Full';
  ObjectType_Lookup = 'Lookup';
  ObjectType_MappingList = 'MappingList';
  ObjectType_ObjectList = 'ObjectList';
  ObjectType_DetailList = 'DetailList';

  SyncStatus_Updated = 'Updated';
  SyncStatus_Deleted = 'Deleted';

  Sync_User = 'Multisite';


{ TSyncUserLock }

constructor TSyncUserLock.Create;
begin
  fLocked:= false;
  fUserLock:= TUserLockBase.Create(nil);
  fUserLock.UserName:= Sync_User;
  fUserLock.LockOwnerUserName:= Sync_User;
end;

destructor TSyncUserLock.Destroy;
begin
  fUserLock.Free;
  inherited;
end;

procedure TSyncUserLock.DumpLocksToFile(fileName: string);
var
  sl: TStringList;
  qry: TMyQuery;
  s: string;
  x: integer;
begin
  sl:= TStringList.Create;
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection:= Connection;
    qry.SQL.Text:= 'select * from tblinuse';
    qry.Open;
    while not qry.Eof do begin
      s:= '';
      for x:= 0 to qry.Fields.Count -1 do begin
        if x > 0 then s:= s + ',';
        s:= s + qry.Fields[x].FieldName + '=' + qry.Fields[x].AsString;
      end;
      sl.Add(s);
      qry.Next;
    end;
    sl.SaveToFile(fileName);
  finally
    sl.Free;
    qry.Free;
  end;

end;

function TSyncUserLock.GetConnection: TMyConnection;
begin
  result:= fUserLock.Connection;
end;

function TSyncUserLock.GetLocked: boolean;
begin
  result:= fLocked;
end;

function TSyncUserLock.Lock(Obj: TSyncObj; GlobalRef: string; var msg: string): boolean;
var
  qry: TMyQuery;
  id: integer;
begin
  fLocked:= false;
  { need table id }
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection:= Connection;
    qry.SQL.Text:=
      'SELECT ' + obj.Struct.StringByName['IdFieldName'] + ' FROM ' +
      obj.Struct.StringByName['TableName'] + ' WHERE GlobalRef = ' +
      QuotedStr(GlobalRef);
    qry.Open;
    id:= qry.Fields[0].AsInteger;
  finally
    qry.Free;
  end;

  if id > 0 then begin
    fUserLock.LockOwnerClassName:= obj.Struct.StringByName['ClassName'];
    result:= fUserLock.Lock(obj.Struct.StringByName['TableName'], Id, obj.Name);
    msg:= fUserLock.LockMessage;
    if result then
      fLocked:= true;
  end
  else begin
    { no id so must be a new record - does not need to be locked }
    result:= true;
  end;
end;

procedure TSyncUserLock.SetConnection(const Value: TMyConnection);
begin
  fUserLock.Connection:= Value;
end;

procedure TSyncUserLock.Unlock;
begin
  if fLocked then
    fUserLock.Unlock();
  fLocked:= false;
end;

{ TDataSyncItem }

constructor TDataSyncItem.Create(aList: TDataSyncList;
  aSourceGlobalRef: string);
begin
  fList:= aList;
  MySQLZeroTimeStamp:= EncodeDAte(1970,1,1) + EncodeTime(0,0,1,0); // +
//    (List.DestTimeZoneMins * (1/24/60)) ;
  SourceGlobalRef:= aSourceGlobalRef;
  SourceLock:= TSyncUserLock.Create;
  SourceLock.Connection:= fList.SourceConn;
  DestLock:= TSyncUserLock.Create;
  DestLock.Connection:= fList.DestConn;
end;

procedure TDataSyncItem.Delete(Obj: TSyncObj; dbConn: TMyConnection);
var
  cmd: TMyCommand;
  sql: string;
begin
  if obj.Fields.Count = 0 then exit; { no data so nothing to delete }
  cmd:= TMyCommand.Create(nil);
  try
    cmd.Connection:= dbConn;
    sql:= 'DELETE FROM ' + obj.Struct.StringByName['TableName'] +
    ' WHERE GlobalRef = ' + QuotedStr(obj.Fields.FieldByName['globalref'].Data.AsString);
    cmd.SQL.Text:= sql;
    cmd.Execute;
  finally
    cmd.Free;
  end;
end;

destructor TDataSyncItem.Destroy;
begin
  SourceObj.Free;
  DestObj.Free;
  SourceLock.Free;
  DestLock.Free;
  inherited;
end;

function TDataSyncItem.DoSync(const source, dest: TSyncObj; var msg: string): boolean;
type
  TDoMappedFieldResult = (mfUnknown, mfNonMappedField, mfMappedOk, mfDestMapObjNotFound, mfNoMappings);

var
  x, y: integer;
  fieldName: string;
  SrcMappings, srcObjects, srcObj, srcLine: TSyncObj;
  DstMappings, dstObjects, dstObj, dstLine: TSyncObj;
  GlobalRef: string;
  GlobalRefList, IgnoreFields: TStringList;

  function DoMappedField(FldName: string): TDoMappedFieldResult;
  var
    srcMapObj, dstMapObj: TSyncObj;
  begin
    try
      if Assigned(srcMappings) then begin
        srcMapObj:= srcMappings.ItemByName[FldName];
        if Assigned(srcMapObj) then begin
          { this field uses a lookup object }
          dstMapObj:= DstMappings.ItemByName[FldName];
          if dstMapObj.IsRefObject then begin
            { this is a reference to a parent object field ...  }
            { if the parent is new and the field is id field it will not have a
              value yet so will need to be updated again after parent is saved }
            Dest.Fields.FieldByName[FldName].Data.Assign(dstMapObj.RefObj.Fields.FieldByName[dstMapObj.Struct.StringByName['Field']].Data);
            result:= mfMappedOk;
          end
          else begin
            if srcMapObj.Fields.Count > 0 then begin
              { needs mapping }
              if (dstMapObj.Fields.Count = 0) or
                (dstMapObj.Fields.FieldByName['globalref'].Data.AsString <>
                  srcMapObj.Fields.FieldByName['globalref'].Data.AsString) then begin

                LoadObj(dstMapObj,srcMapObj.Fields.FieldByName['globalref'].Data.AsString, List.DestConn);
                if dstMapObj.Fields.Count = 0 then begin
                  { FAILED - lookup object not found on dest system }
                  result:= mfDestMapObjNotFound;
                  msg:= 'Mapping failed - Destination object "' + dstMapObj.Name +
                    '" not found for GlobalRef "' +
                    srcMapObj.Fields.FieldByName['globalref'].Data.AsString + '".';
                  exit;
                end;
              end;
              Dest.Fields.FieldByName[FldName].Data.Assign(dstMapObj.Fields.FieldByName[dstMapObj.Struct.StringByName['Field']].Data);
              result:= mfMappedOk;
            end
            else begin
              { source lookup object is empty so clear map }
              Dest.Fields.FieldByName[FldName].Data.Clear;
              result:= mfMappedOk;
            end;
          end;
        end
        else begin
          result:= mfNonMappedField;
        end;
      end
      else
        result:= mfNoMappings;
    except
      on e: Exception do begin
        raise Exception.Create('Error mapping field "'+ FldName + '" with exception: ' + E.Classname + ' ' + E.Message);
      end;
    end;
  end;

begin
  result:= true;
//  TLogger.Inst.Log('Source: ' + source.Name + '  Destinaltion: ' + dest.Name);
  IgnoreFields:= TStringList.Create;
  try
    SrcMappings:= source.ItemByName['Mappings'];
    DstMappings:= dest.ItemByName['Mappings'];
    if source.Struct.Exists('IgnoreFields') then
      IgnoreFields.CommaText:= source.Struct.StringByName['IgnoreFields'];
    if source.Fields.Count > 0 then begin
      for x:= 0 to source.Fields.Count -1 do begin
        fieldName:= source.Fields[x].Name;
        { make sure field exists }
        dest.Fields.Add(fieldName,source.Fields);
        if not (fieldName = Lowercase(source.Struct.StringByName['IdFieldName'])) then begin
          case DoMappedField(fieldName) of
            mfNonMappedField,
            mfNoMappings:
              begin
                { non-mapped fields }
                if fieldName = 'mstimestamp' then begin
//                  dest.Fields.FieldByName[fieldName].Data.AsFloat:=
//                    source.Fields.FieldByName[fieldName].Data.AsFloat + List.DestTimeDiffToAdd;
                  if dest.Fields.FieldByName[fieldName].Data.AsFloat = 0 then
                    dest.Fields.FieldByName[fieldName].Data.AsFloat:= MySQLZeroTimeStamp;
                end
                else begin
                  dest.Fields.FieldByName[fieldName].Data.Assign(source.Fields.FieldByName[fieldName].Data);
                end;
              end;
            mfMappedOk: { all good };
            mfDestMapObjNotFound:
              begin
                result:= false;
                exit;
              end;
            mfUnknown:
              begin
                result:= false;
                msg:= 'Unknown mapping error for field "' +
                  fieldName +  '" for object "' +  dest.name + '".';
                exit;
              end;
          end;
        end;
      end;
      dest.Struct.StringByName['SyncStatus']:= SyncStatus_Updated;
      { sub objects }
      srcObjects:= source.ItemByName['Objects'];
      dstObjects:= dest.ItemByName['Objects'];
      if Assigned(srcObjects) then begin
        if not Assigned(dstObjects) then begin
          dstObjects:= TSyncObj.Create;
          dstObjects.Parent:= dest;
          dstObjects.Name:= 'Objects';
          dstObjects.Struct.StringByName['ObjectType']:= ObjectType_ObjectList;
          dest.Add(dstObjects);
        end;
        for x:= 0 to srcObjects.Count -1 do begin
          srcObj:= srcObjects.Items[x];
          dstObj:= dstObjects.ItemByName[srcObj.Name];
          if not Assigned(dstObj) then
            raise Exception.Create('DoSync - Can not find destination sub object: "' + srcObj.Name + '"' );
          if srcObj.Struct.StringByName['ObjectType'] = ObjectType_DetailList then begin
            { list of detail objects eg sales lines }
            GlobalRefList:= TStringList.Create;
            try
              for y:= 0 to srcObj.Count -1 do begin
                srcLine:= srcObj.Items[y];
                GlobalRef:= srcLine.Fields.FieldByName['globalref'].Data.AsString;
                dstLine:= ItemByGlobalRef(dstObj,GlobalRef);
                if not Assigned(dstLine) then begin
                  { no destination object found ... create one }
                  dstLine:= List.GetSyncObj(srcLine.Struct.StringByName['ClassName'],dstObj,true);
                  dstObj.Add(dstLine);
                end;
                { sync the objects }
                result:= DoSync(srcLine, dstLine, msg);
                if not result then
                  exit;
                { keep a list of globalrefs that have been updated }
                GlobalRefList.Add(GlobalRef);
              end;
              { flag any dest objects that are not in global ref list for deletion }
              for y:= 0 to dstObj.Count -1 do begin
                dstLine:= dstObj.Items[y];
                if GlobalRefList.IndexOf(dstLine.Fields.FieldByName['globalref'].Data.AsString) < 0 then
                  dstLine.Struct.StringByName['SyncStatus']:= SyncStatus_Deleted;
              end;
            finally
              GlobalRefList.Free;
            end;
          end
          else begin
            { single sub object }
            result:= DoSync(srcObj,dstObj, msg);
            if not result then
              exit;
          end;
        end;
      end
      else begin
        { source has no sub object list ... }
        if Assigned(dstObjects) then begin
          { dest does ... so delete all }
          for x:= 0 to dstObjects.Count -1 do begin
            dstObj:= dstObjects.Items[x];
            if dest.Fields.Count > 0 then
              dstObj.Struct.StringByName['SyncStatus']:= SyncStatus_Deleted;
          end;
        end;
      end;
    end
    else begin
      { source has no objects }
      if dest.Fields.Count > 0 then
        dest.Struct.StringByName['SyncStatus']:= SyncStatus_Deleted;
    end;
  finally
    IgnoreFields.Free;
  end;
end;

function TDataSyncItem.GetDataset(sql: string; dbConn: TMyConnection): TDataSet;
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
//  qry.Options.RequiredFields:= true;
  qry.Connection:= dbConn;
  qry.SQL.Text:= sql;
  qry.Open;
  result:= qry;
end;

function TDataSyncItem.ItemByGlobalRef(aObj: TSyncObj;
  aGlobalRef: string): TSyncObj;
var
  x: integer;
  o: TSyncObj;
  fld: TValueField;
begin
  result:= nil;
  for x:= 0 to aObj.Count -1 do begin
    o:= aObj.Items[x];
    fld:= o.Fields.FieldByName['globalref'];
    if Assigned(fld) and (fld.Data.AsString = aGlobalRef) then begin
      result:= o;
      break;
    end;
  end;
end;

function TDataSyncItem.Load(var msg: string): TSyncObjectResult;
begin
  result:= srOk;
  FreeAndNil(SourceObj);
  FreeAndNil(DestObj);
  SourceObj:= List.GetSyncObj(List.SyncObjClassName);
  SourceObj.Name:= List.SyncObjClassName;
  DestObj:= List.GetSyncObj(List.SyncObjClassName);
  DestObj.Name:= List.SyncObjClassName;
  if (not Assigned(SourceObj)) or (not Assigned(destObj)) then begin
    { fatal ... all objects should be in schema }
    result:= srPermFail;
    msg:= 'Fatal error - Could not load object "' + List.SyncObjClassName + '" from schema.';
    exit;
  end;
  LoadObj(SourceObj,SourceGlobalRef,List.SourceConn);
  LoadObj(DestObj,SourceGlobalRef,List.DestConn);
  if SourceObj.Fields.Count = 0 then begin
    msg:= 'Fatal error - source object is empty';
    result:= srPermFail;
    exit;
  end;
end;

procedure TDataSyncItem.LoadObj(Obj: TSyncObj; GlobalRef: string;
  dbConn: TMyConnection);
var
  sql: string;
  ds: TDataSet;
begin
  if obj.Struct.StringByName['ObjectType'] = ObjectType_Full then begin
    if obj.Struct.Exists('SelectFields')  then
      sql:= 'SELECT ' + obj.Struct.StringByName['SelectFields']
    else
      sql:= 'SELECT *';
  end
  else
    sql:= 'SELECT ' + obj.Struct.StringByName['LookupFields'];
  sql:= sql + ' FROM ' + obj.Struct.StringByName['TableName'] +
    ' WHERE GlobalRef = '  + QuotedStr(GlobalRef);
  if obj.Struct.Exists('Filter') then
    sql:= sql + ' and ' + obj.Struct.StringByName['Filter'];
  ds:= GetDataset(sql,dbConn);
  try
    LoadObj(Obj, ds, dbConn);
  finally
    ds.Free;
  end;
end;

procedure TDataSyncItem.LoadObj(Obj: TSyncObj; ds: TDataset; dbConn: TMyConnection);
var
  ChildObj, ObjList: TSyncObj;
  LoadSubItems: boolean;
  x: integer;
  subDs: TDataset;
  sql, ParentFieldName: string;
begin
  LoadSubItems:= obj.Struct.StringByName['ObjectType'] <> ObjectType_Lookup;
  if obj.Struct.StringByName['ObjectType'] = ObjectType_DetailList then begin
    { multiple lines }
    Obj.Clear;
    ds.First;
    while not ds.Eof do begin
      ChildObj:= List.GetSyncObj(obj.Struct.StringByName['ClassName'],Obj,LoadSubItems);
      obj.Add(ChildObj);
      LoadObj(ChildObj,ds,dbConn);
      ds.Next;
    end;
  end
  else begin
    { single object }
    obj.Fields.Clear;
    if not ds.IsEmpty then begin
      obj.Fields.LoadFromDataset(ds);
    end;
  end;
  if LoadSubItems and (not ds.IsEmpty) then begin
    ObjList:= obj.ItemByName['Mappings'];
    if Assigned(objList) then begin
      for x:= 0 to objList.Count -1 do begin
        if not objList.Items[x].IsRefObject then begin
          sql:= 'SELECT ' + objList.Items[x].Struct.StringByName['LookupFields'] +
            ' FROM ' + objList.Items[x].Struct.StringByName['TableName'] +
            ' WHERE ' + objList.Items[x].Struct.StringByName['Field'] + ' = ';
          ParentFieldName:= objList.Items[x].Name;
          if Obj.Fields.FieldByName[ParentFieldName].Data is TStringValue then
            sql:= sql + QuotedStr(Obj.Fields.FieldByName[ParentFieldName].Data.AsString)
          else
            sql:= sql + Obj.Fields.FieldByName[ParentFieldName].Data.AsString;

          if objList.Items[x].Struct.Exists('Filter') then
            sql:= sql + ' and ' + objList.Items[x].Struct.StringByName['Filter'];
          sql:= sql + ' order by ' + objList.Items[x].Struct.StringByName['IdFieldName'];

          subDS:= GetDataset(sql, dbConn);
          try
            objList.Items[x].Fields.Clear;
            if not subDs.IsEmpty then begin
              objList.Items[x].Fields.LoadFromDataset(subDS);
            end;
          finally
            subDS.Free;
          end;
        end;
      end;
    end;
    ObjList:= obj.ItemByName['Objects'];
    if Assigned(objList) then begin
      for x:= 0 to objList.Count -1 do begin
        sql:= 'SELECT * FROM ' + objList.Items[x].Struct.StringByName['TableName'] +
          ' WHERE ' + objList.Items[x].Struct.ObjectByName['Link'].StringByName['LinkField'];
        ParentFieldName:= objList.Items[x].Struct.ObjectByName['Link'].StringByName['ParentField'];
        if Obj.Fields.FieldByName[ParentFieldName].Data is TStringValue then
          sql:= sql + ' = ' + QuotedStr(Obj.Fields.FieldByName[ParentFieldName].Data.AsString)
        else
          sql:= sql + ' = ' + Obj.Fields.FieldByName[ParentFieldName].Data.AsString;

        if objList.Items[x].Struct.Exists('Filter') then
          sql:= sql + ' and ' + objList.Items[x].Struct.StringByName['Filter'];
        sql:= sql + ' order by ' + objList.Items[x].Struct.StringByName['IdFieldName'];

        subDs:= GetDataset(sql, dbConn);
        try
          LoadObj(objList.Items[x],subDS, dbConn);
        finally
          subDS.Free;
        end;
      end;
    end;
  end;
end;

function TDataSyncItem.Lock(var msg: string): TSyncObjectResult;
begin
  result:= srTempFail;
  if SourceLock.Lock(SourceObj,SourceGlobalRef,msg) and
    DestLock.Lock(DestObj,SourceGlobalRef,msg) then
      result:= srOk;
end;

procedure TDataSyncItem.Save;
begin
  self.SaveOrDelete(DestObj);
end;

procedure SetRequiredFields(ds: TDataSet; aTableName: string; conn: TMyConnection);
var
  qry: TMyQuery;
begin
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection:= conn;
    qry.SQL.Text:= 'describe ' + aTableName;
    qry.Open;
    while not qry.Eof do begin
      if (qry.FieldByName('Null').AsString = 'NO') and
         (qry.FieldByName('Extra').AsString <> 'auto_increment') then begin
        ds.FieldByName(qry.FieldByName('Field').AsString).Required:= true;
      end;
      qry.Next;
    end;
  finally
    qry.Free;
  end;
end;

procedure ClearRequiredFields(ds: TDataSet);
var
  x: integer;
begin
  for x:= 0 to ds.FieldCount -1 do
    ds.Fields[x].Required:= false;
end;

{ Save the data contained in the objects fields list back to database and get
  the new autoinc field value }
procedure TDataSyncItem.SaveObj(Obj: TSyncObj; GlobalRef: string;
  dbConn: TMyConnection);
var
  sql, baseSQL, IdFieldName: string;
  ds: TDataSet;
  IsNew: boolean;
  s: string;

  procedure UpdateChangeLog;
  var
    cmd: TMyCommand;
    qry: TMyQuery;
  begin
    try
      cmd:= TMyCommand.Create(nil);
      qry:= TMyQuery.Create(nil);
      try
        cmd.Connection:= dbConn;
        qry.Connection:= dbConn;

//        cmd.SQL.Add('update ' + MS_Change_Log_Table + ',' + Remote_MS_Change_Log_Table);
//        cmd.SQL.Add(' set ' + MS_Change_Log_Table + '.UTCTimeStamp = ' +  Remote_MS_Change_Log_Table + '.UTCTimeStamp,');
//        cmd.SQL.Add(MS_Change_Log_Table + '.EditVersion = ' +  Remote_MS_Change_Log_Table + '.EditVersion,');
//        cmd.SQL.Add(MS_Change_Log_Table + '.SiteCode = ' +  Remote_MS_Change_Log_Table + '.SiteCode,');
//        cmd.SQL.Add(MS_Change_Log_Table + '.GlobalRef = ' +  Remote_MS_Change_Log_Table + '.GlobalRef');
//        cmd.SQL.Add(' where ' + Remote_MS_Change_Log_Table + '.TableName = ' + QuotedStr(obj.Struct.StringByName['TableName']));
//        cmd.SQL.Add(' and ' + Remote_MS_Change_Log_Table + '.GlobalRef = ' + QuotedStr(GlobalRef));
//        cmd.SQL.Add(' and ' + MS_Change_Log_Table + '.TableName = ' + QuotedStr(obj.Struct.StringByName['TableName']));
//        cmd.SQL.Add(' and ' + MS_Change_Log_Table + '.TableId = ' +
//          obj.fields.fieldByName[obj.Struct.StringByName['IdFieldName']].data.AsString);

        qry.SQL.Add('select * from ' + Remote_MS_Change_Log_Table);
        qry.SQL.Add('where TableName = ' + QuotedStr(obj.Struct.StringByName['TableName']));
        qry.SQL.Add('and GlobalRef = ' + QuotedStr(GlobalRef));
        qry.Open;
        if qry.IsEmpty then
          raise exception.Create('Error - no record found on remote site change log table for ' +
            obj.Struct.StringByName['TableName'] + '  ' + Globalref);

        cmd.SQL.Add('insert into ' +  MS_Change_Log_Table + ' (TableName,TableId,GlobalRef,SiteCode,EditVersion,UTCTimeStamp)');
        cmd.SQL.Add('values (' + QuotedStr(obj.Struct.StringByName['TableName']) + ',');
        cmd.SQL.Add(obj.fields.fieldByName[obj.Struct.StringByName['IdFieldName']].data.AsString +',');
        cmd.SQL.Add(QuotedStr(GlobalRef) + ',');
        cmd.SQL.Add(QuotedStr(qry.FieldByName('SiteCode').AsString) + ',');
        cmd.SQL.Add(IntToStr(qry.FieldByName('EditVersion').AsInteger) + ',');
        cmd.SQL.Add(QuotedStr(qry.FieldByName('UTCTimeStamp').AsString)+ ')');
        cmd.SQL.Add('on duplicate key update');
        cmd.SQL.Add('GlobalRef = ' + QuotedStr(GlobalRef) + ',');
        cmd.SQL.Add('SiteCode = ' + QuotedStr(qry.FieldByName('SiteCode').AsString) + ',');
        cmd.SQL.Add('EditVersion = ' + IntToStr(qry.FieldByName('EditVersion').AsInteger) + ',');
        cmd.SQL.Add('UTCTimeStamp = ' + QuotedStr(qry.FieldByName('UTCTimeStamp').AsString));
        cmd.execute;
      finally
        cmd.Free;
        qry.Free;
      end;
    except
      raise;
    end;
  end;

begin
  IsNew:= false;
  if obj.Fields.Dirty then begin
    try
      if obj.Struct.StringByName['ObjectType'] = ObjectType_Full then
        baseSql:= 'SELECT *'
      else
        baseSql:= 'SELECT ' + obj.Struct.StringByName['LookupFields'];
      baseSql:= baseSql + ' FROM ' + obj.Struct.StringByName['TableName'];
      Sql:= baseSQL + ' WHERE GlobalRef = '  + QuotedStr(GlobalRef);
      ds:= GetDataset(sql,dbConn);
      try
        SetRequiredFields(ds,obj.Struct.StringByName['TableName'],dbConn);
        if ds.IsEmpty then begin
          IsNew:= true;
          ds.Insert;
        end
        else begin
          ds.Edit;
        end;
        TMyQuery(ds).Options.RequiredFields:= true;
        try
          Obj.Fields.SaveToDataset(ds);
        finally
          TMyQuery(ds).Options.RequiredFields:= false;
        end;
        ClearRequiredFields(ds);
        ds.Post;
        { get the new id field value }
        IdFieldName:= obj.Struct.StringByName['IdFieldName'];
        obj.Fields.FieldByName[IdFieldName].Data.LoadFromField(ds.FieldByName(IdFieldName));
//        cmd:= TMyCommand.Create(nil);
//        try
//          cmd.Connection:= dbConn;
//          cmd.SQL.Add('update ' + MS_Change_Log_Table + ',' + Remote_MS_Change_Log_Table);
//          cmd.SQL.Add(' set ' + MS_Change_Log_Table + '.UTCTimeStamp = ' +  Remote_MS_Change_Log_Table + '.UTCTimeStamp,');
//          cmd.SQL.Add(MS_Change_Log_Table + '.EditVersion = ' +  Remote_MS_Change_Log_Table + '.EditVersion,');
//          cmd.SQL.Add(MS_Change_Log_Table + '.SiteCode = ' +  Remote_MS_Change_Log_Table + '.SiteCode,');
//          cmd.SQL.Add(MS_Change_Log_Table + '.GlobalRef = ' +  Remote_MS_Change_Log_Table + '.GlobalRef');
//          cmd.SQL.Add(' where ' + Remote_MS_Change_Log_Table + '.TableName = ' + QuotedStr(obj.Struct.StringByName['TableName']));
//          cmd.SQL.Add(' and ' + Remote_MS_Change_Log_Table + '.GlobalRef = ' + QuotedStr(GlobalRef));
//          cmd.SQL.Add(' and ' + MS_Change_Log_Table + '.TableName = ' + QuotedStr(obj.Struct.StringByName['TableName']));
//          cmd.SQL.Add(' and ' + MS_Change_Log_Table + '.TableId = ' + ds.FieldByName(IdFieldName).AsString);
//          cmd.execute;
//        finally
//          cmd.Free;
//        end;
      finally
        ds.Free;
      end;
      obj.Fields.Dirty:= false;
    except
      on e: exception do begin
        if Pos('Duplicate entry',e.Message) > 0 then begin
          sql:= 'show index from ' + obj.Struct.StringByName['TableName'];
          ds:= GetDataset(sql,dbConn);
          try
            ds.Open;
            sql:= '';
            while not ds.Eof do begin
              if (ds.FieldByName('Non_unique').AsInteger = 0) and
                 (ds.FieldByName('Key_name').AsString <> 'PRIMARY') and
                 (Lowercase(ds.FieldByName('Column_name').AsString) <> 'globalref')  then begin
                if sql = '' then sql:= ' where '
                else sql:= sql + ' and ';
                sql:= sql + ds.FieldByName('Column_name').AsString + ' = ' +
                  QuotedStr(obj.Fields.FieldByName[ds.FieldByName('Column_name').AsString].Data.AsString);
              end;
              ds.Next;
            end;
          finally
            ds.Free;
          end;
          s:=
            'An attempt to add a new item to the database failed '+
            'because an item with the same key values already exists.' + #13#10 +
            '  Source server/database: ' + List.SourceConn.Server + '/' + List.SourceConn.Database + #13#10 +
            '  Destination server/database: ' + List.DestConn.Server + '/' + List.DestConn.Database + #13#10 +
            '  Source Item/GlobalRef: ' + Obj.Name + '/' + GlobalRef + #13#10 +
            '  Data selection: ' + sql;
          try
            ds:= GetDataset(baseSQL + sql,dbConn);
            try
              if ds.IsEmpty then begin
                //ds.Insert;
                raise exception.Create('Existing record not found ' + sql);
              end
              else begin
                ds.Edit;
              end;
              SetRequiredFields(ds,obj.Struct.StringByName['TableName'],dbConn);
              TMyQuery(ds).Options.RequiredFields:= true;
              try
                Obj.Fields.Dirty:= true;
                Obj.Fields.SaveToDataset(ds);
              finally
                TMyQuery(ds).Options.RequiredFields:= false;
              end;
              ClearRequiredFields(ds);
              ds.Post;
              { get the new id field value }
              IdFieldName:= obj.Struct.StringByName['IdFieldName'];
              obj.Fields.FieldByName[IdFieldName].Data.LoadFromField(ds.FieldByName(IdFieldName));
//              cmd:= TMyCommand.Create(nil);
//              try
//                cmd.Connection:= dbConn;
//                cmd.SQL.Add('update ' + MS_Change_Log_Table + ',' + Remote_MS_Change_Log_Table);
//                cmd.SQL.Add(' set ' + MS_Change_Log_Table + '.UTCTimeStamp = ' +  Remote_MS_Change_Log_Table + '.UTCTimeStamp,');
//                cmd.SQL.Add(MS_Change_Log_Table + '.EditVersion = ' +  Remote_MS_Change_Log_Table + '.EditVersion,');
//                cmd.SQL.Add(MS_Change_Log_Table + '.SiteCode = ' +  Remote_MS_Change_Log_Table + '.SiteCode,');
//                cmd.SQL.Add(MS_Change_Log_Table + '.GlobalRef = ' +  Remote_MS_Change_Log_Table + '.GlobalRef');
//                cmd.SQL.Add(' where ' + Remote_MS_Change_Log_Table + '.TableName = ' + QuotedStr(obj.Struct.StringByName['TableName']));
//                cmd.SQL.Add(' and ' + Remote_MS_Change_Log_Table + '.GlobalRef = ' + QuotedStr(GlobalRef));
//                cmd.SQL.Add(' and ' + MS_Change_Log_Table + '.TableName = ' + QuotedStr(obj.Struct.StringByName['TableName']));
//                cmd.SQL.Add(' and ' + MS_Change_Log_Table + '.TableId = ' + ds.FieldByName(IdFieldName).AsString);
//                cmd.execute;
//              finally
//                cmd.Free;
//              end;
            finally
              ds.Free;
            end;
            obj.Fields.Dirty:= false;
            s:= 'WARNING' + #13#10 + s + #13#10 +
              'The destination item with the matching key values has been updated to match the source item values.';
            List.SendNotification(s,ltWarning);
          except
            on e: exception do begin
              s:= 'ERROR' + #13#10 + s + #13#10 +
                'An attempt to up date destination item with the matching key values has failed with message:' +
                #13#10 + e.Message;
              List.SendNotification(s,ltError);
              s:= 'Failed while Updating existing object with matching keys ';
              s:= s + Obj.Name + ' ['+ GlobalRef + ']: ' + e.Message;
              raise exception.Create(s);
            end;
          end;
        end
        else begin
          if IsNew then
            s:= 'Failed while Adding object '
          else
            s:= 'Failed while Updating object ';
          s:= s + Obj.Name + ' ['+ GlobalRef + ']: ' + e.Message;
          raise exception.Create(s);
        end;
      end;
    end;
  end;
  UpdateChangeLog;
end;

procedure TDataSyncItem.SaveOrDelete(obj: TSyncObj; deleteObject: boolean);
var
  Mappings, MapObj, ObjList, ObjListItem, lstObj: TSyncObj;
  x, y: integer;
begin
  if (obj.Struct.StringByName['SyncStatus'] = SyncStatus_Deleted) or deleteObject then begin
    {  delete sub objects first }
    ObjList:= obj.ItemByName['Objects'];
    if assigned(ObjList) then begin
      for x:= 0 to ObjList.Count -1 do begin
        ObjListItem:= ObjList.Items[x];
        if ObjListItem.Struct.StringByName['ObjectType'] = ObjectType_DetailList then begin
          for y:= 0 to ObjListItem.Count -1 do begin
            lstObj:= ObjListItem.Items[y];
            SaveOrDelete(lstObj, true);
          end;
          ObjListItem.Clear; { remove lines from list }
        end
        else
          SaveOrDelete(ObjListItem, true);
      end;
    end;
    { deleted this object instance }
    if (obj.Struct.StringByName['ObjectType'] = ObjectType_Full) then
      Delete(obj,List.DestConn);
  end
  else if (obj.Struct.StringByName['SyncStatus'] = SyncStatus_Updated) then begin
    if Assigned(obj.Parent) then begin
      { check for parent map fields ... these need to be updated after parent
        has been saved and autoinc id fields assigned }
      Mappings:= obj.ItemByName['Mappings'];
      if Assigned(Mappings) then begin
        for x:= 0 to Mappings.Count -1 do begin
          MapObj:= Mappings.Items[x];
          { only interested in parent/ref type mappings eg sales line needs
            saleid from parent sale object }
          if MapObj.IsRefObject then begin
            obj.Fields.FieldByName[MapObj.Name].Data.Assign(MapObj.RefObj.Fields.FieldByName[MapObj.Struct.StringByName['Field']].Data);
          end;
        end;
      end;
    end;

    { save this object }
    SaveObj(Obj,obj.Fields.FieldByName['globalref'].Data.AsString, List.DestConn);

    { save sub objects }
    ObjList:= obj.ItemByName['Objects'];
    if assigned(ObjList) then begin
      x:= 0;
      while x < ObjList.Count do begin
        ObjListItem:= ObjList.Items[x];
        if ObjListItem.Struct.StringByName['ObjectType'] = ObjectType_DetailList then begin
          for y:= 0 to ObjListItem.Count -1 do begin
            lstObj:= ObjListItem.Items[y];
            SaveOrDelete(lstObj);
          end;
          Inc(x);
        end
        else begin
          if ObjListItem.Struct.StringByName['SyncStatus'] = SyncStatus_Deleted then begin
            SaveOrDelete(ObjListItem);
            ObjList.Delete(x);
          end
          else begin
            SaveOrDelete(ObjListItem);
            Inc(x);
          end;
        end;
      end;
    end;
  end
end;

function TDataSyncItem.SyncObject(var msg: string): TSyncObjectResult;
begin
  result:= srOk;
  if not DoSync(SourceObj,DestObj,msg) then begin
    result:= srTempFail;
    exit;
  end;
end;

procedure TDataSyncItem.Unlock;
begin
  SourceLock.Unlock;
  DestLock.Unlock
end;

{ TDataSyncList }

constructor TDataSyncList.Create;
begin
  fList:= TObjectList.Create(true);
end;

destructor TDataSyncList.Destroy;
begin
  fList.Free;
  inherited;
end;

function TDataSyncList.GetCount: integer;
begin
  result:= fList.Count;
end;

function TDataSyncList.GetItem(index: integer): TDataSyncItem;
begin
  result:= TDataSyncItem(fList[index]);
end;

function TDataSyncList.GetSyncObj(aClassName: string; aParent: TSyncObj;
  LoadSubObjects: boolean): TSyncObj;
var
  ObjStruct, MappingStruct, MappStruct, ObjListStruct, SubObjStruct: TJSONObject;
  x: integer;
  Mappings, Objects: TSyncObj;
  obj, objParent: TSyncObj;
  aSubClassName: string;
begin
  result:= nil;
  if not Schema.Exists(aClassName) then exit;
  ObjStruct:= Schema.ObjectByName[aClassName];
  if Assigned(ObjStruct) then begin
    if ObjStruct.Exists('InheritsFrom') then begin
      result:= GetSyncObj(ObjStruct.StringByName['InheritsFrom'],aParent);
      result.Struct.StringByName['ClassName']:= aClassName;
    end
    else begin
      result:= TSyncObj.Create;
      result.Parent:= aParent;
      result.Struct.Assign(ObjStruct);
      if result.Struct.Exists('IdFieldName') then
        result.Fields.IdFieldName:= Lowercase(result.Struct.StringByName['IdFieldName']);
      result.Struct.StringByName['ClassName']:= aClassName;
      result.Struct.StringByName['ObjectType']:= ObjectType_Full;
      if LoadSubObjects then begin
        MappingStruct:= ObjStruct.ObjectByName['Mappings'];
        if MappingStruct.Count > 0 then begin
          { create the mapp objects }
          Mappings:= TSyncObj.Create;
          Mappings.Parent:= result;
          Mappings.Name:= 'Mappings';
          Mappings.Struct.Assign(MappingStruct);
          Mappings.Struct.StringByName['ObjectType']:= ObjectType_MappingList;
          result.Add(Mappings);
          for x:= 0 to MappingStruct.Count -1 do begin
            MappStruct:= TJSONObject(MappingStruct.Items[x].Value);
            aSubClassName:= MappStruct.StringByName['ClassName'];
            if aSubClassName = 'parent' then begin
              obj:= TSyncObj.Create;
              obj.Parent:= Mappings;
              obj.Struct.Assign(MappStruct);
              objParent := result;
              while Assigned(objParent.parent) do begin
                objParent:= objParent.parent;
                if (objParent.Struct.StringByName['ObjectType'] = ObjectType_Full) or
                 (objParent.Struct.StringByName['ObjectType'] = ObjectType_Lookup) then
                  break;
              end;
              obj.RefObj:= objParent;
            end
            else begin
              obj:= GetSyncObj(aSubClassName,Mappings,false);
            end;
            if Assigned(obj) then begin
              obj.Name:= MappingStruct.Items[x].Name;
              obj.Struct.StringByName['Field']:= MappStruct.StringByName['Field'];
              obj.Struct.StringByName['ObjectType']:= ObjectType_Lookup;
              Mappings.Add(obj);
            end;
          end;
        end;
        ObjListStruct:= ObjStruct.ObjectByName['Objects'];
        if ObjListStruct.Count > 0 then begin
          { create the sub objects }
          Objects:= TSyncObj.Create;
          Objects.Parent:= result;
          Objects.Name:= 'Objects';
          Objects.Struct.Assign(ObjListStruct);
          Objects.Struct.StringByName['ObjectType']:= ObjectType_ObjectList;
          result.Add(Objects);
          for x:= 0 to ObjListStruct.Count -1 do begin
            SubObjStruct:= TJSONObject(ObjListStruct.Items[x].Value);
            aSubClassName:= SubObjStruct.StringByName['ClassName'];
            if aSubClassName <> 'parent' then begin
              if SubObjStruct.BooleanByName['IsList'] then
                obj:= GetSyncObj(aSubClassName,Objects,false)
              else
                obj:= GetSyncObj(aSubClassName,Objects,true);
              if Assigned(obj) then begin
                obj.Name:= ObjListStruct.Items[x].Name;
                if SubObjStruct.BooleanByName['IsList'] then
                  obj.Struct.StringByName['ObjectType']:= ObjectType_DetailList;
                obj.Struct.ObjectByName['Link'].Assign(SubObjStruct.ObjectByName['Link']);
                Objects.Add(obj);
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TDataSyncList.SendNotification(msg: string; msgType: TLogMessageType);
begin
  if Assigned(fOnSendNotification) then
    fOnSendNotification(msg,msgType);
end;

procedure TDataSyncList.SetDestConn(const Value: TMyConnection);
begin
  fDestConn := Value;
end;

procedure TDataSyncList.SetSourceConn(const Value: TMyConnection);
begin
  fSourceConn := Value;
end;

function TDataSyncList.SyncObjects(aClassName, aSourceGlobalRefList: string;
                                   var msg: string): TSyncObjectResult;
var
  SL: TStringList;
  x: integer;
  item: TDataSyncItem;
begin
  fSyncObjClassName:= aClassName;
  result:= srOk;
  msg:= '';
  flist.Clear;  
  if not SourceConn.Connected then begin
    result:= srTempFail;
    msg:= 'Error - Source database not connected.';
    exit;
  end;
  if not DestConn.Connected then begin
    result:= srTempFail;
    msg:= 'Error - Destination database not connected.';
    exit;
  end;

  { add a sync item for each global ref to be processed }
  SL:= TStringList.Create;
  try
    SL.CommaText:= aSourceGlobalRefList;
    for x:= 0 to SL.Count -1 do begin
      item:= TDataSyncItem.Create(self,SL[x]);
      fList.Add(item);
    end;
  finally
    SL.Free;
  end;
  try
    { Get objects based on GlobalRef and load then lock them }
    for x:= 0 to Count -1 do begin
      result:= Items[x].Load(msg);
      if result <> srOk then exit;
      result:= Items[x].Lock(msg);
      if result <> srOk then exit;
    end;

    { start dest trans }
    DestConn.StartTransaction;
    try
      { Note: must sync and save each object in case one obj referens another. }
      for x:= 0 to Count -1 do begin
        { Do synch }
        result:= Items[x].SyncObject(msg);
        if result <> srOk then exit;

        { save }
        Items[x].Save;

      end;

      { commit }
      DestConn.Commit;

    finally
      if DestConn.InTransaction then
        DestConn.Rollback;
    end;

  finally
    { unlock all }
    for x:= 0 to Count -1 do
      Items[x].Unlock;
    flist.Clear;
  end;
end;

end.
