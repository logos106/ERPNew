unit BusObjNDSGenDb;

{ This is a base business object that can be used to store data from different
  business objects into a single table by storing each object property into
  a separate table record.}

interface

uses
  Classes, BusObjNDSBase;


type
  TOnChangeData = Procedure (const aPropName, acleanValue, aNewValue:String) of object;

  TBusObjNDSGenDb = class(TBusObjNDS)
  private
    fOnChangeData: TOnChangeData;
    function GetSQL :STring;
  protected
    function GetStorer: TBusObjStorer; override;
    Procedure DoOnChangeData(const aPropName, acleanValue, aNewValue:String);virtual;
  public
    ObjTableName,
    ObjIdFieldName,
    ObjTypeFieldName,
    ObjPropNameFieldName,
    ObjPropTypeFieldName,
    ObjPropSizeFieldName,
    ObjPropValueFieldName,
    ObjInstGlobalrefFieldName ,
    ObjPropDefaultValueFieldName: string;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    Procedure New; Override;
    Property OnChangeData : TOnChangeData read fOnChangeData write fOnChangeData;
  published
  end;


  TBusObjGEnDbStorer = class(TBusObjStorer)
  private
//    function NextId(obj: TBusObjNDSGenDb): integer;

  public
    procedure Load(Const obj: TBusObjNDS; Const SelectSql: string = ''); override;
    procedure LoadTree(Const obj: TBusObjNDSTree; Const SubTreeOnly: boolean = false; PartsourceStock:boolean = False);  override;
    procedure LoadList(Const List: TBusObjNDSList); override;
    procedure Save(Const obj: TBusObjNDS); override;
    procedure Delete(Const obj: TBusObjNDS); override;

  end;


implementation

uses
  BusObjBase, MyAccess,ERPdbComponents, SysUtils, TypInfo, CommonLib,
  AppEnvironment, MySQLConst;

{ TBusObjNDSGenDb }

constructor TBusObjNDSGenDb.Create(AOwner: TComponent);
begin
  inherited;
  fOnChangeData := nil;
end;

destructor TBusObjNDSGenDb.Destroy;
begin

  inherited;
end;
procedure TBusObjNDSGenDb.DoOnChangeData(const aPropName, acleanValue, aNewValue: String);
begin
  if Assigned(fOnChangeData) then
    fOnChangeData( aPropName, acleanValue, aNewValue);
end;

Procedure TBusobjNDSGenDB.new;
begin
    inherited;
    if ObjInstGlobalrefFieldName <> '' then
        ObjInstGlobalRef   := AppEnv.Branch.SiteCode + IntToStr(Id);

end;
function TBusObjNDSGenDb.GetStorer: TBusObjStorer;
begin
  if Assigned(fAssignedStorer) then
    result:= fAssignedStorer
  else begin
    if Assigned(Owner) and (Owner is TBusObjNDSGenDb) then
      result:= TBusObjNDS(Owner).Storer
    else begin
      if not Assigned(fPrivateStorer) then begin
        fPrivateStorer:= TBusObjGEnDbStorer.Create;
        if Assigned(Owner) and (Owner is TDatasetBusObj) then
          fPrivateStorer.Connection:= TERPConnection(TDatasetBusObj(Owner).Connection.Connection);
      end;
      result:= fPrivateStorer;
    end;
  end;
end;

{ TBusObjGEnDbStorer }

procedure TBusObjGEnDbStorer.Delete(Const obj: TBusObjNDS);
var
  GObj: TBusObjNDSGenDb;
  s: string;
begin
  if obj is TBusObjNDSGenDb then begin
    GObj:= TBusObjNDSGenDb(Obj);
    s:= 'DELETE FROM `' + GObj.ObjTableName + '` WHERE `' + GObj.ObjTypeFieldName + '` = "' + GObj.ClassName + '"';
    if GObj.ObjIdFieldName <> '' then
      s:= s  + ' AND `' + GObj.ObjIdFieldName + '` = ' +IntToStr(GObj.Id);
  end;
end;

procedure TBusObjGEnDbStorer.LoadList(Const List: TBusObjNDSList);
begin
  { not implemented }
end;

procedure TBusObjGEnDbStorer.LoadTree(Const obj: TBusObjNDSTree; Const SubTreeOnly: boolean = false; PartsourceStock:boolean = False);
begin
  { not implemented }
end;

//function TBusObjGEnDbStorer.NextId(obj: TBusObjNDSGenDb): integer;
//begin
//  result:= 0;
//  { lock the table and get the next Id for this object type }
//  { not implemented }
//end;
function TBusObjNDSGenDb.GetSQL :STring;
begin
    Result:= 'SELECT * FROM `' + ObjTableName +
            '` WHERE `' + ObjTypeFieldName + '` = ' + QuotedStr(ClassName)  ;
    if (ObjInstGlobalrefFieldName <> '' )  then begin
        Result:= Result + ' AND ' +   ObjInstGlobalrefFieldName + ' = ' + quotedStr(ObjInstGlobalRef);
    end else if (ObjIdFieldName <> '')  then begin
        Result:= Result + ' AND ' +   ObjIdFieldName + ' = ' + IntToStr(ID);
    end ;
end;
procedure TBusObjGenDbStorer.Load(Const obj: TBusObjNDS; Const SelectSql: string);
var
  GObj: TBusObjNDSGenDb;
  s: string;
  qry: TERPQuery;
  count, x: integer;
  PropList: PPropList;
begin
    if obj is TBusObjNDSGenDb then begin
        GObj:= TBusObjNDSGenDb(Obj);

        s := GObj.GetSQL;
        if s <> '' then begin
            qry:= TERPQuery.Create(nil);
            try
                qry.Connection := self.Connection;
                qry.SQL.Text:= s;
                qry.Open;
                if qry.Recordcount > 0 then begin
                    if GObj.ObjInstGlobalrefFieldName <> '' then GObj.ObjInstGlobalRef  := Qry.fieldByname(GObj.ObjInstGlobalrefFieldName).asString;
                    if GObj.ObjIdFieldName <> ''            then GObj.ID                := Qry.fieldByname(GObj.ObjIdFieldName).asInteger;
                    GObj.Dirty := False;
                end else begin
                    GObj.New;
                end;
                Count := GetPropList(GObj.ClassInfo, tkProperties, nil);
                GetMem(PropList, Count * SizeOf(PPropInfo));
                try
                    GetPropList(GObj.ClassInfo, tkProperties, PropList);
                    for x := 0 to Count -1 do begin
                        if (PropList[x].SetProc <> nil) and qry.Locate(GObj.ObjPropNameFieldName,PropList[x].Name, []) then begin
                            if (PropList[x].PropType^ = TypeInfo(TDateTime)) then
                                SetFloatProp(Obj, string(PropList[x].Name), MysqlDateStrToDate(qry.FieldByName(GObj.ObjPropValueFieldName).asString))
                            else if qry.FieldByName(GObj.ObjPropTypeFieldName).AsString = 'ftBoolean' then begin
                                if qry.FieldByName(GObj.ObjPropValueFieldName).AsString = 'T' then
                                    SetEnumProp(GObj,string(PropList[x].Name),'True')
                                else if qry.FieldByName(GObj.ObjPropValueFieldName).AsString = 'F' then
                                    SetEnumProp(GObj,string(PropList[x].Name),'False');
                            end else begin
                                SetPropValue(Obj, string(PropList[x].Name), qry.FieldByName(GObj.ObjPropValueFieldName).AsVariant);
                            end;
                        end;

                    end;
                finally
                    FreeMem(PropList, Count * SizeOf(PPropInfo));
                end;
            finally
                FreeAndNil(qry);
            end;
        end;
//        if qry.Recordcount > 0 then GObj.Dirty := False;
    end;
end;

procedure TBusObjGEnDbStorer.Save(Const obj: TBusObjNDS);
var
  GObj: TBusObjNDSGenDb;
  s: string;
  qry: TERPQuery;
  count, x: integer;
  PropList: PPropList;
  Val: Variant;
  ValStr: string;
  FieldType: string;
begin
  if obj is TBusObjNDSGenDb then begin
    GObj:= TBusObjNDSGenDb(Obj);

    { Note: the following is for a single instance of object type per table
            eg a preference object }

    s := GObj.GetSQL;
    if s <> '' then begin
      qry:= TERPQuery.Create(nil);
      try
        qry.Connection := self.Connection;
        qry.SQL.Text:= s;
        qry.Open;
        Count := GetPropList(GObj.ClassInfo, tkProperties, nil);
        GetMem(PropList, Count * SizeOf(PPropInfo));
        try
          GetPropList(GObj.ClassInfo, tkProperties, PropList);
          for x := 0 to Count -1 do begin
            if not (Assigned( PropList[x].SetProc)) then continue;
            FieldType:= 'ftString';
            val:= GetPropValue(obj, string(PropList[x].Name));
            if (PropList[x].PropType^ = TypeInfo(TDateTime)) then begin
              valStr:= FormatDateTime(MysqlDateTimeFormat, val);
              FieldType:= 'ftDateTime';
            end
            else begin
              if PropList[x].PropType^.Kind = tkEnumeration then begin
                if Val = 'True' then begin
                  ValStr:= 'T';
                  FieldType:= 'ftBoolean';
                end
                else if Val = 'False' then begin
                  ValStr:= 'F';
                  FieldType:= 'ftBoolean';
                end
                else ValStr:= val;
              end
              else
                valStr:= val;
            end;

            if qry.Locate(GObj.ObjPropNameFieldName,PropList[x].Name, []) then begin
                TBusObjNDSGenDb(Obj).DoOnChangeData(PropList[x].Name , qry.FieldByName('FieldValue').AsString ,ValStr);
                qry.Edit;
                qry.FieldByName(GObj.ObjPropValueFieldName).AsString:= ValStr;
                qry.Post;
            end else begin
                TBusObjNDSGenDb(Obj).DoOnChangeData(PropList[x].Name, '' ,ValStr);
                s:= 'INSERT INTO `' + GObj.ObjTableName + '` SET ' +
                    '`' + GObj.ObjTypeFieldName         + '` = ' + QuotedStr(GObj.ClassName) + ', ' +
                    '`' + GObj.ObjPropNameFieldName     + '` = ' + QuotedStr(string(PropList[x].Name)) + ', ' +
                    '`' + GObj.ObjPropTypeFieldName     + '` = ' + QuotedStr(FieldType) + ', ' +
                    '`' + GObj.ObjPropSizeFieldName     + '` = 0, ' +
                    '`' + GObj.ObjPropValueFieldName    + '` = ' + QuotedStr(ValStr);
                if GObj.ObjInstGlobalrefFieldName <> '' then
                  s:= s +
                    ', `' + GObj.ObjInstGlobalrefFieldName+ '` = ' + QuotedStr(GObj.ObjInstGlobalRef);
                self.RunSQLCommand(s);
            end;

          end;
        finally
          FreeMem(PropList, Count * SizeOf(PPropInfo));
        end;
      finally
        FreeAndNil(qry);
      end;
    end;
    GObj.Dirty := False;
  end;
end;

end.
