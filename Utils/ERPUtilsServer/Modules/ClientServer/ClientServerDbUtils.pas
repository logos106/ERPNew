unit ClientServerDbUtils;

interface

uses
  MyAccess, IntegerListObj, ClientConfigObj, LogMessageTypes, LogThreadBase;

type

  TLicenceUtils = class(TObject)
  private
    fOnLog: TOnLogEvent;
    fConn: TMyConnection;
    fDirty: boolean;
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank); overload;
  public
    class procedure ProcessLicence(ClientConfig: TClientConfig; Conn: TMyConnection; OnLogEvent: TOnLogEvent);
    procedure DoProcessLicence(ClientConfig: TClientConfig);
    property OnLog: TOnLogEvent read fOnLog write fOnLog;
    property Connection: TMyConnection read fConn write fConn;
    property Dirty: boolean read fDirty write fDirty;
  end;



  procedure SaveToDb(obj: TObject; Conn: TMyConnection);
  procedure DeleteFromDb(obj: TObject; Conn: TMyConnection);
  procedure LoadFromDb(obj: TObject; Conn: TMyConnection; aId: integer = 0);
  function SavedObjIsNewer(obj: TObject; Conn: TMyConnection): boolean;
  function ReleaseTypesMatch(ClientConfig: TObject; Conn: TMyConnection): boolean;
  function GetChildIdList( Conn: TMyConnection;
    tableName, parentIdFieldName: string;
    ParentId: integer;
    IdFieldName: string = 'id'): TIntegerList;
  function IdExists(obj: TObject; Conn: TMyConnection): boolean;
  procedure TrimOldComputerConfigs(ComputerID: integer; Conn: TMyConnection);
  procedure UpdateExpired(Conn: TMyConnection);


var
  DBUpdateUser: string = 'ERP';

implementation

uses
  sysutils, TypInfo, DB, DateTimeUtils, MySQLConst, JsonObject, Types, StrUtils,
  Classes;

function GetChildIdList( Conn: TMyConnection;
  tableName, parentIdFieldName: string;
  ParentId: integer;
  IdFieldName: string = 'id'): TIntegerList;
var
  qry: TMyQuery;
begin
  result:= TIntegerList.Create;
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection:= Conn;
    qry.SQL.Add('select ' + IdFieldName + ' from ' + tableName);
    qry.SQL.Add('where ' + parentIdFieldName + ' = ' + IntToStr(ParentId));
    qry.SQL.Add('order by ' + IdFieldName);
    qry.Open;
    while not qry.Eof do begin
      result.Add(qry.Fields[0].AsInteger);
      qry.Next;
    end;
  finally
    qry.Free;
  end;
end;


function SavedObjIsNewer(obj: TObject; Conn: TMyConnection): boolean;
var
  aUser: string;
  aDateTime: TDateTime;
  aId: integer;
  qry: TMyQuery;
begin
  result:= false;
  aUser:= GetStrProp(obj,'user');
  aDateTime:= GetFloatProp(obj,'datetime');
  aId:= GetInt64Prop(obj,'id');
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection:= Conn;
    qry.SQL.Add('select user,datetime');
    qry.SQL.Add('from ' + obj.ClassName);
    qry.SQL.Add(' where id = ' + IntToStr(aId));
    qry.Open;
    if qry.RecordCount > 0 then begin
      if ((qry.FieldByName('user').AsString <> aUser) and
        (qry.FieldByName('datetime').AsDateTime >= aDateTime)) or
        (qry.FieldByName('datetime').AsDateTime > aDateTime) then
        result:= true;

    end;
  finally
    qry.Free;
  end;
end;

function IdExists(obj: TObject; Conn: TMyConnection): boolean;
var
  aId: integer;
  qry: TMyQuery;
begin
  aId:= GetInt64Prop(obj,'id');
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection:= Conn;
    qry.SQL.Add('select id');
    qry.SQL.Add('from ' + obj.ClassName);
    qry.SQL.Add(' where id = ' + IntToStr(aId));
    qry.Open;
    result:= qry.RecordCount = 1;
  finally
    qry.Free;
  end;
end;

procedure DeleteFromDb(obj: TObject; Conn: TMyConnection);
var
  currentId: integer;
  qry: TMyQuery;
begin
  currentId:= GetInt64Prop(obj,'id');
  if currentId > 0 then begin
    qry:= TMyQuery.Create(nil);
    try
      qry.Connection:= Conn;
      qry.SQL.Text:= 'delete from ' + obj.ClassName + ' where id = ' + IntToStr(currentId);
      qry.Execute;
    finally
      qry.Free;
    end;
  end;
end;

procedure SaveToDb(obj: TObject; Conn: TMyConnection);
var
  currentId: integer;
  count, x: integer;
  PropList: PPropList;
  FieldName: string;
  Val: Variant;
  qry: TMyQuery;
  fld: TField;
begin
  currentId := GetInt64Prop(obj, 'id');
  SetStrProp(obj, 'user', DBUpdateUser);
  SetFloatProp(obj, 'datetime', nowUTC);

  qry:= TMyQuery.Create(nil);
  try
    qry.Connection:= Conn;
    qry.SQL.Text:= 'SELECT * FROM ' + obj.ClassName + ' WHERE id = ' + IntToStr(currentId);
    qry.Open;
    if currentId < 1 then begin
      qry.Insert;
    end
    else begin
      if qry.RecordCount = 1 then
        qry.Edit
      else
        raise exception.Create('Error loading record no ' + IntToStr(currentId) + ' for "' + obj.ClassName + '"');
    end;

    Count := GetPropList(obj.ClassInfo, tkProperties, nil);
    GetMem(PropList, Count * SizeOf(PPropInfo));
    try
      GetPropList(obj.ClassInfo, tkProperties, PropList);
      for x := 0 to Count -1 do begin

        FieldName:= string(PropList[x].Name);

        if LowerCase(FieldName) = 'id' then
          Continue;
        fld:= qry.FindField(FieldName);
        if Assigned(fld) then begin
          case PropList[x].PropType^.Kind of
            tkInt64,
            tkInteger:
              fld.AsInteger:= GetInt64Prop(obj,FieldName);
            tkEnumeration:
              begin
                val:= GetPropValue(obj, FieldName);
                if Val = 'True' then fld.AsBoolean:= true
                else if Val = 'False' then fld.AsBoolean:= false
                else fld.AsString:= val;
              end;
            tkFloat:
              fld.AsFloat:= GetFloatProp(obj,FieldName);
            tkChar,
            tkString,
            tkLString,
            tkUString:
              fld.AsString:= GetStrProp(obj,FieldName);
            tkWChar,
            tkWString:
              fld.AsString:= GetWideStrProp(obj,FieldName);
            tkVariant:
              fld.AsVariant:= GetVariantProp(obj,FieldName);
            tkArray,
            tkUnknown,
            tkSet,
            tkInterface,
            tkDynArray,
            tkRecord,
            tkClass,
            tkMethod: { do nothing };
          end;
        end;
      end;
    finally
      FreeMem(PropList, Count * SizeOf(PPropInfo));
    end;
    qry.Post;
    if currentId < 1 then
      SetOrdProp(obj,'id',qry.FieldByName('id').AsInteger);
  finally
    qry.Free;
  end;
end;

procedure LoadFromDb(obj: TObject; Conn: TMyConnection; aId: integer = 0);
var
  count, x: integer;
  PropList: PPropList;
  FieldName: string;
  qry: TMyQuery;
  fld: TField;
  currentId: integer;
begin
  currentId:= aId;
  if currentId = 0 then
    currentId:= GetInt64Prop(obj,'id');
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection:= Conn;
    qry.SQL.Text:= 'SELECT * FROM ' + obj.ClassName + ' WHERE id = ' + IntToStr(currentId);
    qry.Open;
    if qry.RecordCount <> 1 then
      raise exception.Create('Error loading record no ' + IntToStr(currentId) + ' for "' + obj.ClassName + '"');

    Count := GetPropList(obj.ClassInfo, tkProperties, nil);
    GetMem(PropList, Count * SizeOf(PPropInfo));
    try
      GetPropList(obj.ClassInfo, tkProperties, PropList);
      for x := 0 to Count -1 do begin

        FieldName:= string(PropList[x].Name);

        if LowerCase(FieldName) = 'id' then
          Continue;
        fld:= qry.FindField(FieldName);
        if Assigned(fld) then begin
          case PropList[x].PropType^.Kind of
            tkInt64,
            tkInteger:
              SetOrdProp(obj,FieldName,fld.AsInteger);
            tkEnumeration:
              begin
                if (fld is TStringField) and (fld.Size = 1) then begin
                  if fld.AsBoolean then SetPropValue(obj, FieldName, 'True')
                  else SetPropValue(obj, FieldName, 'False');
                end
                else
                  SetPropValue(obj, FieldName, fld.AsVariant);
              end;
            tkFloat:
              SetFloatProp(obj,FieldName,fld.AsFloat);
            tkChar,
            tkString,
            tkLString,
            tkUString:
              SetStrProp(obj,FieldName,fld.AsString);
            tkWChar,
            tkWString:
              SetWideStrProp(obj,FieldName,fld.AsString);
            tkVariant:
              SetVariantProp(obj,FieldName,fld.AsVariant);
            tkArray,
            tkUnknown,
            tkSet,
            tkInterface,
            tkDynArray,
            tkRecord,
            tkClass,
            tkMethod: { do nothing };
          end;
        end;
      end;
    finally
      FreeMem(PropList, Count * SizeOf(PPropInfo));
    end;
  finally
    qry.Free;
  end;
end;

procedure TrimOldComputerConfigs(ComputerID: integer; Conn: TMyConnection);
const
  max_condig_count = 5;
var
  qry: TMyQuery;
  id: integer;
begin
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection := Conn;
    qry.SQL.Add('select id from tcomputerconfig');
    qry.SQL.Add('where computerid = ' + IntToStr(ComputerId));
    qry.SQL.Add('order by id desc limit ' + IntToStr(max_condig_count -1) + ',1');
    qry.Open;
    if not qry.IsEmpty then begin
      id := qry.FieldByName('id').AsInteger;
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('delete from tcomputerconfig');
      qry.SQL.Add('where computerid = ' + IntToStr(ComputerId));
      qry.SQL.Add('and id < ' + IntToStr(id));
      qry.Execute;
    end;
  finally
    qry.Free;
  end;
end;

procedure UpdateExpired(Conn: TMyConnection);
var
  cmd: TMyCommand;
begin
  cmd := TMyCommand.Create(nil);
  try
    cmd.Connection := Conn;
    cmd.SQL.Add('update tsoftwarelicence');
    cmd.SQL.Add('set `status` = "lsExpired",');
    cmd.SQL.Add('`user` = ' + QuotedStr(DBUpdateUser)+ ',');
    cmd.SQL.Add('`statusreason` = ' + QuotedStr('Licence Expired')+ ',');
    cmd.SQL.Add('`datetime` = "' + FormatDateTime(MysqlDateTimeFormat,NowUTC) + '"');
    cmd.SQL.Add('where utc_timestamp() > expiredate and status in ("lsLicenced","lsHold","lsReview")');
    cmd.Execute;
  finally
    cmd.Free;
  end;
end;

function ReleaseTypesMatch(ClientConfig: TObject; Conn: TMyConnection): boolean;
var
  qry: TMyQuery;
begin
  result := false;
  if not (ClientConfig is TClientConfig) then exit;
  qry:= TMyQuery.Create(nil);
  try
    qry.Connection := Conn;
    qry.SQL.Text := 'select * from tclientconfig where id = ' + IntToStr(TClientConfig(ClientConfig).Id);
    qry.Open;
    if SameText(TClientConfig(ClientConfig).SoftwareReleaseType,qry.FieldByName('softwarereleasetype').AsString) then
      result := true;
  finally
    qry.Free;
  end;
end;

{ TLicenceUtils }

procedure TLicenceUtils.DoProcessLicence(ClientConfig: TClientConfig);
var
  qry: TMyQuery;
  ServerCount: integer;
  Computer: TComputer;
  ComputerNameChanged: boolean;
  ComputerConfig: TComputerConfig;
  ComputerConfigCount: integer;
  NewCompuerConfigSent: boolean;
  Json: TJsonObject;
  MacAddress: string;
  MacAddressChanged: boolean;
  Id: integer;
  Licence: TSoftwareLicence;
  LicenceCount: integer;
  LicenceChanged: boolean;
  LicenceMultiplesFound: boolean;
  I: Integer;
  sourcePair, destPair: TJsonValuePair;
  cnt: integer;
  LicenceTypeList: TStringList;

  function CommonMacAddress(MacList1, MacList2: string): boolean;
  var
    List1, List2: TStringDynArray;
    x1, x2: integer;
  begin
    result := false;
    List1 := SplitString(MacList1,',');
    List2 := SplitString(MacList2,',');
    for x1 := Low(List1) to High(List1) do begin
      for x2 := Low(List2) to High(List2) do begin
        if List1[x1] = List2[x2] then begin
          result := true;
          exit;
        end;
      end;
    end;
  end;

begin
  qry := TMyQuery.Create(nil);
  LicenceTypeList := TStringList.Create;
  try
    LicenceTypeList.CaseSensitive := false;
    { ***** Client ***** }
    qry.Connection := Connection;
    qry.SQL.Text := 'SELECT * FROM tclientconfig WHERE id = ' + IntToStr(ClientConfig.Id);
    qry.Open;
    try
      if qry.IsEmpty then begin
        if ClientConfig.Id < 1 then
          Log('Creating new Client Record', ltInfo)
        else
          Log('Creating new Client Record - Existing Client Id not found in database', ltWarning);

        ClientConfig.Id := 0;
        Dirty := true;
        SaveToDb(ClientConfig, Connection);
      end;
    finally
      qry.Close;
    end;
    LoadFromDb(ClientConfig, Connection);

    { ***** Computer ***** }
    for ServerCount := 0 to ClientConfig.ServerList.Count - 1 do begin
      ComputerNameChanged := False;
      Computer := TComputer(ClientConfig.ServerList.Items[ServerCount]);
      qry.SQL.Text := 'SELECT * FROM tcomputer WHERE id = ' + IntToStr(Computer.Id);
      qry.Open;
      try
        if qry.IsEmpty or (Computer.ClientId <> ClientConfig.Id)  then begin
          if Computer.Id < 1 then
            Log('Creating new Computer Record', ltInfo)
          else if Computer.Id > 0 then
            Log('Creating new Computer Record - Existing Id not found in database', ltWarning)
          else
            Log('Updating Computer Record - Existing ClientId in database does not match Client', ltWarning);
          if qry.IsEmpty then
            Computer.Id := 0;
          Computer.ClientId := ClientConfig.Id;
          Dirty := True;
          SaveToDb(Computer, Connection);
        end;
        if not SameText(Computer.ComputerName, qry.FieldByName('computername').AsString)  then begin
          ComputerNameChanged := true;
          Log('Server Name has Changed', ltInfo);
        end;
      finally
        qry.Close;
      end;

      LoadFromDb(Computer, Connection);

      { ***** Computer Config ***** }
      NewCompuerConfigSent := False;
      for ComputerConfigCount := 0 to Computer.ConfigList.Count - 1 do begin
        ComputerConfig := TComputerConfig(Computer.ConfigList.Items[ComputerConfigCount]);
        { save any new config records .. }
        if ComputerConfig.Id < 1 then begin
          Dirty := True;
          ComputerConfig.ComputerId := Computer.Id;
          SaveToDb(ComputerConfig, Connection);
          NewCompuerConfigSent := True;
        end;
      end;
      MacAddressChanged := False;
      if NewCompuerConfigSent then begin
        qry.SQL.Text := 'SELECT * FROM tcomputerconfig WHERE computerid = ' + IntToStr(Computer.Id) + ' ORDER BY id DESC';
        qry.Open;
        Json := JO;
        try
          if qry.RecordCount > 1 then begin
            MacAddress := '';
            MacAddressChanged := True;
            Id := 0;
            cnt := 0;
            while not qry.Eof do begin
              Inc(cnt);
              if (Id = 0) and (cnt = 5) then
                Id := qry.FieldByName('id').AsInteger;
              Json.ASString := qry.FieldByName('Text').AsString;
              if MacAddress = '' then
                MacAddress := Json.O['network'].S['macaddress']
              else begin
                if MacAddressChanged and (MacAddress <> '') and (Json.O['network'].S['macaddress'] <> '') and CommonMacAddress(MacAddress, Json.O['network'].S['macaddress']) then begin
                  MacAddressChanged := false;
                end;
//                MacAddress := Json.O['network'].S['macaddress'];
              end;
              qry.Next;
            end;

            if Id > 0 then begin
              { only keep last x records }
              qry.Close;
              qry.SQL.Text :=
                'DELETE FROM tcomputerconfig WHERE computerid = ' + IntToStr(Computer.Id) + ' AND id < ' + IntToStr(Id);
              qry.Execute;
              Computer.ConfigList.Clear;
              qry.Close;
              qry.SQL.Text := 'SELECT * FROM tcomputerconfig WHERE computerid = ' + IntToStr(Computer.Id) + ' ORDER BY id';
              qry.Open;
              while not qry.Eof do begin
                ComputerConfig:= Computer.ConfigList.Add;
                ComputerConfig.Id:= qry.FieldByName('id').AsInteger;
                LoadFromDb(ComputerConfig, Connection);
                qry.Next;
              end;
            end;
          end;
        finally
          qry.Close;
          Json.Free;
        end;

//        qry.SQL.Text := 'select * from tcomputerconfig where computerid = ' + IntToStr(Computer.Id) + ' order by id';
//        qry.Open;
//        Json := JO;
//        try
//          if qry.RecordCount > 1 then begin
//            MacAddress := '';
//            Id := 0;
//            while not qry.Eof do begin
//              Json.ASString := qry.FieldByName('Text').AsString;
//              if MacAddress = '' then
//                MacAddress := Json.O['network'].S['macaddress']
//              else begin
//                if (MacAddress <> '') and (Json.O['network'].S['macaddress'] <> '') and (not CommonMacAddress(MacAddress, Json.O['network'].S['macaddress'])) then begin
//                  MacAddressChanged := true;
//                  Log('Mac Address of Server has Changed', ltInfo);
//                end;
//                MacAddress := Json.O['network'].S['macaddress'];
//              end;
//              Id := qry.FieldByName('id').AsInteger;
//              qry.Next;
//            end;
//            if Id > 0 then begin
//              { only keep last record }
//              qry.Close;
//              qry.SQL.Text :=
//                'delete from tcomputerconfig where computerid = ' + IntToStr(Computer.Id) + ' and id <> ' + IntToStr(Id);
//              qry.Execute;
//              Computer.ConfigList.Clear;
//              ComputerConfig:= Computer.ConfigList.Add;
//              ComputerConfig.Id:= Id;
//              LoadFromDb(ComputerConfig, Connection);
//            end;
//          end;
//        finally
//          qry.Close;
//          Json.Free;
//        end;
      end;
      { ***** Licence ***** }
      LicenceTypeList.Clear;
      LicenceCount := 0;
      LicenceMultiplesFound := false;
//      for LicenceCount := 0 to Computer.LicenceList.Count -1 do begin
      while LicenceCount < Computer.LicenceList.Count do begin
        Licence := TSoftwareLicence(Computer.LicenceList.Items[LicenceCount]);

        if LicenceTypeList.IndexOf(Licence.SoftwareName) > -1 then begin
          { we already have an instance of this licence type .. delete all others }
          Log('Multiple licences found of same type - Deleting', ltWarning);
          Dirty := True;
          LicenceMultiplesFound := True;
          DeleteFromDb(Licence, connection);
          Computer.LicenceList.Delete(LicenceCount);
          Continue;
        end;

        qry.SQL.Text := 'SELECT * FROM tsoftwarelicence WHERE id = ' + IntToStr(Licence.Id);
        qry.Open;
        try
          if qry.IsEmpty then begin
            Log('Adding new Licence for Server', ltInfo);
            Dirty := true;
            Licence.Id := 0;
            Licence.ComputerId := Computer.Id;
            SaveToDb(Licence, Connection);
          end
          else begin
            { updating }
            LicenceChanged := False;
            if Licence.ComputerId <> Computer.Id then begin
              Log('Updating Licence for Server - Wrong Server Id', ltWarning);
              Licence.ComputerId := Computer.Id;
              LicenceChanged := True;
            end;
            if SameText(Licence.SoftwareName, 'ERP') and (not SameText(qry.FieldByName('datatext').AsString, Licence.DataText)) then begin
              { somthing has changed }
              LicenceChanged := True;
              Json := JO;
              try
                Json.AsString := qry.FieldByName('datatext').AsString;
                for I := 0 to Json.O['erpinfo'].Count - 1 do begin
                  { update client with SMS config info from database .. }
                  sourcePair := Json.O['erpinfo'].Items[I];
                  if Licence.Data.O['erpinfo'].ObjectExists(sourcePair.Name) then begin
                    destPair := Licence.Data.O['erpinfo'].ItemByName[sourcePair.Name];
                    destPair.Value.AsObject.O['SMSConfig'].Assign(sourcePair.Value.AsObject.O['SMSConfig']);
                  end;
                end;

                { update client with licence options from database }
                Licence.Data.O['Options'].Assign(Json.O['Options']);
              finally
                Json.Free;
              end;
            end;
            if Licence.Active <> qry.FieldByName('active').AsBoolean then begin
              Licence.Active := qry.FieldByName('active').AsBoolean;
              LicenceChanged := True;
              Log('We have changed the licence Active State', ltInfo);
            end;
            if Licence.StartDate <> qry.FieldByName('startdate').AsDateTime then begin
              Licence.StartDate := qry.FieldByName('startdate').AsDateTime;
              LicenceChanged := True;
              Log('We have changed the licence Start Date', ltInfo);
            end;
            if Licence.ExpireDate <> qry.FieldByName('expiredate').AsDateTime then begin
              Licence.ExpireDate := qry.FieldByName('expiredate').AsDateTime;
              LicenceChanged := True;
              Log('We have changed the licence Expire Date', ltInfo);
            end;
            if Licence.ConcurrentUsers <> qry.FieldByName('concurrentusers').AsInteger then begin
              Licence.ConcurrentUsers := qry.FieldByName('concurrentusers').AsInteger;
              LicenceChanged := True;
              Log('We have changed the licence Concurrent Users', ltInfo);
            end;
            if Licence.Notes <> qry.FieldByName('notes').AsString then begin
              Licence.Notes := qry.FieldByName('notes').AsString;
              LicenceChanged := True;
              Log('We have changed the licence Notes', ltInfo);
            end;
            if SoftwareLicenceStatusToStr(Licence.Status) <> qry.FieldByName('status').AsString then begin
              Licence.Status := StrToSoftwareLicenceStatus(qry.FieldByName('status').AsString);
              LicenceChanged := True;
              Log('We have changed the licence Status', ltInfo);
            end;
            if (Licence.Status = lsLicenced) or (Licence.Status = lsReview) then begin
              if ComputerNameChanged then begin
                Licence.Status := lsHold;
                Licence.StatusReason := 'Server Name Changed';
                LicenceChanged := True;
                Log('Licence Status changed to Hold - Server Name Changed', ltInfo);
              end
              else if MacAddressChanged then begin
                Licence.Status := lsHold;
                Licence.StatusReason := 'Server Mac Address Changed';
                LicenceChanged := True;
                Log('Licence Status changed to Hold - Server Mac Address Changed', ltInfo);
              end
              else begin
                if Trunc(NowUTC) > Trunc(Licence.ExpireDate) then begin
                  Licence.Status := lsExpired;
                  Licence.StatusReason := 'Licence Expired';
                  LicenceChanged := True;
                  Log('Licence Status changed to Expired', ltInfo);
                end;
              end;
            end;
            if LicenceChanged then begin
              Dirty := True;
              SaveToDb(Licence, Connection);
            end;
          end;
        finally
          qry.Close;
        end;
        LoadFromDb(Licence,Connection);

        if LicenceTypeList.IndexOf(Licence.SoftwareName) > -1 then begin

        end
        else begin
          { first time just add to list .. }
          LicenceTypeList.AddObject(Licence.SoftwareName, TObject(Licence.Id));
        end;

        Inc(LicenceCount);
      end;
      if LicenceMultiplesFound then begin
        { make sure we only have one licence type per server in our db .. }
        for LicenceCount := 0 to LicenceTypeList.Count - 1 do begin
          qry.SQL.Clear;
          qry.SQL.Add('DELETE FROM tsoftwarelicence');
          qry.SQL.Add('WHERE softwarename = ' + QuotedStr(LicenceTypeList[LicenceCount]));
          qry.SQL.Add('AND id <> ' + IntToStr(Integer(LicenceTypeList.Objects[LicenceCount])));
          qry.SQL.Add('AND computer id = ' + IntToStr(Computer.Id));
          qry.Execute;
        end;
      end;
    end;
  finally
    LicenceTypeList.Free;
    qry.Free;
  end;
end;

procedure TLicenceUtils.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  if Assigned(fOnLog) then
    fOnLog(msg, LogMessageType);
end;

class procedure TLicenceUtils.ProcessLicence(ClientConfig: TClientConfig;
  Conn: TMyConnection; OnLogEvent: TOnLogEvent);
var
  Inst: TLicenceUtils;
begin
  Inst := TLicenceUtils.Create;
  try
    Inst.Connection := Conn;
    Inst.OnLog := OnLogEvent;
    Inst.Dirty := false;
    if not Conn.InTransaction then
      Conn.StartTransaction;
    try
      Inst.DoProcessLicence(ClientConfig);
      if Inst.Dirty then
        Conn.Commit;
    finally

    end;
  finally
    Inst.Free;
  end;
end;

end.
