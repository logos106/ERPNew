unit WebAPILib;

interface

uses MyAccess ,ERPDbComponents,JsonObject,utServerTask;

type
    TEventProc = Procedure(Const Eventtype, EventValue:String; WriteToOutjson:Boolean =False;objname:String ='') of Object;


procedure CreateDatabase(TaskRec: TServerTaskRec;fParams: string; fServer :String;aOnEvent:TEventProc; IsVS1Database :Boolean = False);
procedure AddEventdata(aOnEvent: TEventProc; const Eventtype,      EventValue: String; WriteToOutjson:Boolean =False;objname:String ='');
Function CharDate:String;
Procedure OnNewDatabase(aOnEvent:TEventProc;params: TJsonObject; fDatabase, fserver:String;conn: TMyConnection; IsVS1Database:Boolean);Overload;
Procedure OnNewDatabase(aOnEvent:TEventProc;                     fDatabase, fserver:String;                     IsVS1Database:Boolean; Vs1_RegoJson:String);Overload;

implementation

uses MyDump,  classes,sysutils,DateTimeUtils , RandomUtils,MySQLUtils,
  SystemLib, utNewDBUtils, CommonLib, busobjcompinfo, utVS1Const, utCloudconst,
  StoredProcedures;

Procedure OnNewDatabase(aOnEvent:TEventProc;fDatabase, fserver:String;IsVS1Database:Boolean; Vs1_RegoJson:String);
var
  params: TJsonObject;
begin
  AddEventdata(aOnEvent,'Progress', 'Initialising '+fServer +'.' +fDatabase);
  params:= Jo(Vs1_RegoJson);
  try
    params.S['Name']:= 'OnNewDatabase';
    params.S[VS1_TAG_DatabaseName]:= fDatabase;
    params.S[VS1_TAG_ServerName]:= fserver;
    params.B[VS1_TAG_IsVS1Database]:= True;
    OnNewDatabase(aOnEvent,params,fDatabase, fserver, nil, IsVS1Database);
  finally
    params.Free;
  end;

end;

Procedure OnNewDatabase(aOnEvent: TEventProc; params: TJsonObject; fDatabase, fserver: String; conn: TMyConnection; IsVS1Database: Boolean);
var
  aERPRegionName:String;
  aconn: TMyConnection;
begin
  AddEventdata(aOnEvent, 'Progress', 'Initialising Defaults in the New Database');
  if (conn <> nil) and (conn.Connected) then aconn := conn
  else begin
    try
      aConn := TMyConnection.Create(nil);
      SetConnectionProps(aConn, fDatabase, fServer);
      aConn.Connect;
      AddEventdata(aOnEvent, 'Progress', 'Connected to ' + fServer + '.' + fDatabase);
    except
      on E:Exception do begin
        AddEventdata(aOnEvent, 'Connecting to the Server', E.message);
        Exit;
      end;
    end;
  end;

  try
    AddEventdata(aOnEvent, 'Progress', 'Setting company defaults');

    if params.Exists(VS1_TAG_RegionName) then aERPRegionName := params.S[VS1_TAG_RegionName]
    else aERPRegionName := '';
    if aERPRegionName = '' then aERPRegionName := 'Australia';

    TNewDbUtils.SetNewCompanyDefaultValues(fDatabase, aERPRegionName, False, True, aConn, aOnEvent, IsVS1Database);

    AddEventdata(aOnEvent, 'Progress', 'Checking for Employees');
    if params.Exists('ClientName') then begin
      AddEventdata(aOnEvent, 'Progress', 'Checking for Employees - Params Exists');
      if not(params.Exists('MakingExtraDB')) or (params.B['MakingExtraDB'] = False) then begin
        AddEventdata(aOnEvent, 'Progress', 'update companyinfo');
        try
          TNewDbUtils.InitCompInfo(aConn, params.S['ClientName'], aOnEvent);
        Except
          on E:Exception do begin
            AddEventdata(aOnEvent, 'Progress Error1', E.message);
          end;
        end;
      end;

      AddEventdata(aOnEvent, 'Progress', 'update employee');
      try
        TNewDbUtils.InitEmployee(aConn, params.AsString, aOnEvent);
      Except
        on E:Exception do begin
          AddEventdata(aOnEvent, 'Progress Error2', E.message);
        end;
      end;

      AddEventdata(aOnEvent, 'EmployeeId', IntToStr(params.I['VS1EmployeeId']), True);

    end else begin
      AddEventdata(aOnEvent, 'Progress', 'Vs1_Reg doesnt exists');
      AddEventdata(aOnEvent, 'Progress', Params.AsString);
    end;

    if params.S['OrganisationName'] <> '' then begin
      aConn.ExecSQL('UPDATE tblcompanyinformation SET CompanyName = ' + QuotedStr(params.S['OrganisationName']), []);
    end;
    aConn.ExecSQL('UPDATE tbldbpreferences SET FieldValue = "T" WHERE Name = "CompanyDefaultsSelected";', []);
  finally
    if (conn<>nil) and (conn.connected) then
    else FreeAndNil(aConn);
  end;
end;

Function CharDate:String;
begin
  REsult := FormatDateTime('yyyy_mm_dd', NowUTC);
  Result := Replacestr(Result,'0','a');
  Result := Replacestr(Result,'1','b');
  Result := Replacestr(Result,'2','c');
  Result := Replacestr(Result,'3','d');
  Result := Replacestr(Result,'4','e');
  Result := Replacestr(Result,'5','f');
  Result := Replacestr(Result,'6','g');
  Result := Replacestr(Result,'7','h');
  Result := Replacestr(Result,'8','i');
  Result := Replacestr(Result,'9','j');
end;

procedure AddEventdata(aOnEvent: TEventProc; const Eventtype, EventValue: String; WriteToOutjson: Boolean = False; objname: String = '');
begin
  try
    if Assigned(aOnEvent) then
      aOnEvent(Eventtype, EventValue, WriteToOutjson, objname);
  Except
    // ignore for the time being
  end;
end;

procedure CreateDatabase(TaskRec: TServerTaskRec; fParams: String; fServer: String; aOnEvent: TEventProc; IsVS1Database: Boolean = False);
var
  conn: TMyConnection;
  params: TJsonObject;
  dump: TMyDump;
  aTempFileName: string;
  fDatabase: string;
  sl: TStringList;
  //aERPRegionName:String;

  procedure LogToStatus(const aMsg: string);
  begin
    TaskRec.Data.A['Log'].Add(aMsg);
    TaskRec.Save;
  end;

  function MakeNewDbName: string;
  begin
    Result := 'TrueERP_Cloud_' + FormatDateTime('yyyy_mm_dd', NowUTC) + '_' + MakeRandomString(6);
  end;

begin
  try
    LogToStatus('Start');
    TaskRec.TaskStatus := 'Working';
    TaskRec.Save;
    params := JO(fParams);

    {check for the remote Calls}
    if IsVS1Database = False then
      if params.Exists(VS1_TAG_IsVS1Database) then
        if params.B[VS1_TAG_IsVS1Database] then
          IsVS1Database := True;

    conn := TMyConnection.Create(nil);
    dump := TMyDump.Create(nil);
    sl := TStringList.Create;
    try
      sl.CaseSensitive := False;
      SetConnectionProps(conn, 'erpnewdb', fServer);
      conn.Connect;
      if params.Exists(VS1_TAG_DatabaseName) and (Trim(params.S[VS1_TAG_DatabaseName]) <> '') then begin
        fDatabase := Trim(params.S[VS1_TAG_DatabaseName]);
      end else begin
        fDatabase := MakeNewDbName;
      end;

      conn.GetDatabaseNames(sl);
      while True do begin
        if sl.IndexOf(fDatabase) < 0 then
          Break;
        fDatabase := MakeNewDbName;
      end;

      AddEventdata(aOnEvent, 'Creating Database', fDatabase);

      TaskRec.Data.S['DatabaseDirectory'] := fDatabase;
      TaskRec.Save;
      dump.Connection := conn;
      aTempFileName :=  GetTempFileName('', '.tmp', True);
      try
        ForceDirectories(aTempFileName);
        dump.Options.AddLock := False;
        dump.Options.DisableKeys := False;
        dump.Options.HexBlob := True; //false;
        dump.Options.UseExtSyntax := True;
        dump.Options.UseDelayedIns := False;
        dump.Options.InsertType := itInsert;
        dump.Options.GenerateHeader := False;
        dump.Options.AddDrop := False;
        dump.Options.QuoteNames := True;
        dump.Options.CompleteInsert := False;
        dump.Objects := [doTables, doViews, doData];

        AddEventdata(aOnEvent, 'Progress', 'Making a copy of Blank Database');
        dump.BackupToFile(aTempFileName);

        AddEventdata(aOnEvent, 'Progress', 'Creating the New database');

        conn.ExecSQL('CREATE DATABASE `' + fDatabase + '`', []);
        conn.Disconnect;
        conn.Database := fDatabase;
        conn.Connect;

        AddEventdata(aOnEvent, 'Progress', 'Creating database ');
        dump.RestoreFromFile(aTempFileName);
        AddEventdata(aOnEvent, 'Progress', 'Database Created');

        try CreateSPs(nil, conn);except end;

      finally
        DeleteFile(aTempFileName);
      end;

      OnNewDatabase(aOnEvent, params, fDatabase, fserver, conn, IsVS1Database);

    finally
      sl.Free;
      dump.Free;
      conn.Free;
      params.Free;
    end;
    TaskRec.Complete := true;
    TaskRec.TaskStatus := 'Done';
    TaskRec.StatusMessage := 'Database Created ' + fDatabase;
    TaskRec.Save;
    AddEventdata(aOnEvent,'Progress', 'Database Created');

  except
    on e: exception do begin
      TaskRec.Complete := true;
      TaskRec.TaskStatus := TAG_ResponseError;
      TaskRec.StatusMessage := e.Message;
      TaskRec.Save;
    end;
  end;
end;

end.
