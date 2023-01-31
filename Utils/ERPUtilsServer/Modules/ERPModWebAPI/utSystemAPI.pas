unit utSystemAPI;

interface

uses
  Classes, JsonObject, ERPDbComponents, LogThreadBase, LogMessageTypes,
  ModuleFileNameUtils, utServerTask , WebAPIThreadObj,utAPIBaseObj, WebAPILib;

type

  TSystemAPI = class(TAPIBaseObj)
  private
    //APIOutJson: TJsonObject;
    class
    procedure GetDatabaseStatus(const aDatabaseName: string; OutJson: TJsonObject);
    class procedure RunDbQuery(const aDatabaseName, aSQL: string; OutJson: TJsonObject);
    class procedure AddUser(Params: TJsonObject);
    class procedure GetDatabaseList(OutJson: TJsonObject);
    class procedure GetToken(Params, OutJson: TJsonObject);

  public
    { returns true if request type is handled }
    class function DoCloudRequest(InJson, OutJson: TJsonObject; var OutStream: TStream; DbConn: TERPConnection; aLogger: TLoggerBase = nil; aTaskRecID: Integer = 0): Boolean;

  end;

  TApiServerTaskThread = class(TWebAPIThreadBase)
  private
    fCommand,
    fServer,
    fParams: string;
    TaskRec: TServerTaskRec;
    fOutJson :TJsonObject;
    procedure CreateDatabase;
    procedure DropDatabase;
    Procedure DoApiServerTaskThreadTest;

  protected
    procedure Execute; override;
  public
    constructor Create(aCommand, aServer: string;aOutJson :TJsonObject; aOnEvent:TEventProc; params: string = ''; aLogger: TLoggerBase = nil );
    destructor Destroy; override;
  end;

implementation

uses
  AuthUtilsObj, SysUtils, ERPServerInfoObj, ObjectSerialiser, RandomUtils,
  DateTimeUtils, MyAccess, MySQLUtils, ConfigDbObj, MyDump, AppEnvironment,
  SystemLib,  DNMLIB, JsonToDatasetFuncs, DbConst, ModuleConst,
  utTokenList,ActiveX, utVS1Const, WebApiConst, utCloudconst;


{ TSystemAPI }

class procedure TSystemAPI.AddUser(Params: TJsonObject);
var
  conn: TMyConnection;
  qry: TMyQuery;
  EmpID: integer;
begin
  conn := TMyConnection.Create(nil);
  qry := TMyQuery.Create(nil);
  try
    if (Params.O['Person'].O['fields'].S[VS1_TAG_FirstName] = '') and
        (Params.O['Person'].O['fields'].S[VS1_TAG_LastName] = '') then
      raise Exception.Create('Error - Cant create ERP Employee, First and Last Names are missing');
    if Params.O['Person'].O['fields'].S['Email'] = '' then
      raise Exception.Create('Error - Cant create ERP Employee, Email is missing');
    if Params.O['Person'].O['fields'].S['Password'] = '' then
      raise Exception.Create('Error - Cant create ERP Employee, Password is missing');


    SetConnectionProps(conn,Params.S['DatabaseDirectory'],AppEnv.AppDb.Server);
    conn.Connect;
    qry.Connection := conn;

    { create an employee record }
    qry.SQL.Text := 'select * from tblEmployees where EmployeeID = 0';
    qry.Open;
    qry.Insert;
    qry.FieldByName('Title').AsString := Params.O['Person'].O['fields'].S['Title'];
    qry.FieldByName(VS1_TAG_FirstName).AsString := Params.O['Person'].O['fields'].S[VS1_TAG_FirstName];
    qry.FieldByName(VS1_TAG_LastName).AsString := Params.O['Person'].O['fields'].S[VS1_TAG_LastName];
    qry.FieldByName('Sex').AsString := Params.O['Person'].O['fields'].S['Gender'];
    qry.FieldByName('Mobile').AsString := Params.O['Person'].O['fields'].S['Mobile'];
    qry.FieldByName('Phone').AsString := Params.O['Person'].O['fields'].S[VS1_TAG_PhoneNumber];
    qry.FieldByName('Email').AsString := Params.O['Person'].O['fields'].S['Email'];
    qry.FieldByName('DateStarted').AsDateTime := Date;
    qry.FieldByName('DOB').AsDateTime := Date;
    qry.Post;
    EmpID := qry.FieldByName('EmployeeID').AsInteger;

    { User login record }
    qry.Close;
    qry.SQL.Text := 'select * from tblpassword where Pswd_ID = 0';
    qry.Open;
    qry.Insert;
    qry.FieldByName('EmployeeID').AsInteger := EmpID;
    qry.FieldByName('Logon_Name').AsString := Params.O['Person'].O['fields'].S['Email'];
    qry.FieldByName('Logon_Password').AsString := DNMLIB.EnCrypt(Params.O['Person'].O['fields'].S['Password'],'z');
    qry.Post;

    { Give access to everthing }
    qry.Close;
    qry.SQL.Text := 'insert into tblemployeeformsaccess (EmployeeID, FormID, Access) ' +
      '(select ' + IntToStr(EmpID) + ', FormID, 1 from tblForms)';
    qry.Execute;

  finally
    qry.Free;
    conn.Free;
  end;
end;

(*constructor TSystemAPI.Create(aAPIOutJson: TJsonObject);
begin
   APIOutjson := aAPIOutJson;
end;*)

class function TSystemAPI.DoCloudRequest(InJson, OutJson: TJsonObject; var OutStream: TStream; DbConn: TERPConnection; aLogger: TLoggerBase = nil; aTaskRecID: Integer = 0): Boolean;
var
  SvrInfo: TERPServerInfo;
  MethodJson: TJsonObject;
//  DatabaseDirectory: string;
  ServerTask: TServerTaskRec;

  function IsAuthRequest: boolean;
  begin
    result :=
      SameText(InJson.S[TAG_ERPUserName], ModuleConst.ERP_ADMIN_USER) and
      SameText(InJson.S[TAG_ERPPassword], ModuleConst.ERP_ADMIN_TOKEN);
  end;

  procedure SerialiseObject(aObject: TObject);
  var
    JSONSerialiser: TJSONSerialiser;
  begin
    JSONSerialiser := TJSONSerialiser.Create;
    try
      OutJson.O['JsonOut']:= JSONSerialiser.SerialiseObject(aObject);
    finally
      JSONSerialiser.Free;
    end;
  end;

begin
  Result := False;

  with TSystemAPI.Create(*(OutJson)*) do try
    TaskRecID := aTaskRecID;
    fLogger := aLogger;
    if (InJson.A['URIParts'].Count >= 3) then begin
      if SameText(InJson.A['URIParts'][2].AsString, 'system') then begin
        Result := True;
        if not IsAuthRequest then begin
          OutJson.I[TAG_ResponseNo] := VS1_HTTP_Failed_Code; { "Unauthorized" }
          Exit;
        end;
        OutJson.I[TAG_ResponseNo] := VS1_HTTP_Success_Code; { "OK" }
        try
          if (InJson.A['URIParts'].Count >= 4) then begin
            if SameText(InJson.A['URIParts'][3].AsString, 'TERPServerInfo') then begin
              SvrInfo := TERPServerInfo.Create(nil);
              try
                SerialiseObject(SvrInfo);
              finally
                SvrInfo.Free;
              end;
            end else if SameText(InJson.A['URIParts'][3].AsString, 'ServerTask') then begin
              ServerTask := TServerTaskRec.Get(InJson.A['URIParts'][4].AsInteger);
              try
                OutJson.O['JsonOut'].AsString := ServerTask.AsJson;
              finally
                ServerTask.Free;
              end;
            end else if SameText(InJson.A['URIParts'][3].AsString, TAG_Method) then begin
              MethodJson := JO(InJson.O['JsonIn'].AsString);
              try
                if SameText(MethodJson.S['Name'], 'ApiServerTaskThreadTest') then begin
                  OutJson.O['JsonOut'].I['ServerTaskID'] :=
                    TApiServerTaskThread.Create('ApiServerTaskThreadTest', AppEnv.AppDb.Server, OutJson, DOEvent, MethodJson.AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do;
                end else if SameText(MethodJson.S['Name'], 'CreateDatabase') then begin
                  OutJson.O['JsonOut'].I['ServerTaskID'] :=
                    TApiServerTaskThread.Create('CreateDatabase', AppEnv.AppDb.Server, OutJson, DOEvent, MethodJson.AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do;
                end else if SameText(MethodJson.S['Name'], 'DropDatabase') then begin
                  OutJson.O['JsonOut'].I['ServerTaskID'] :=
                    TApiServerTaskThread.Create('DropDatabase', AppEnv.AppDb.Server, OutJson ,DOEvent, MethodJson.O[TAG_CLOUD_Params].AsString, fLogger).TaskRec.ID;
                  While ThreadRunning do;
                end  else if SameText(MethodJson.S['Name'], 'GetDatabaseStatus') then begin
                  GetDatabaseStatus(MethodJson.O[TAG_CLOUD_Params].S['DatabaseDirectory'],OutJson.O['JsonOut']);
                end else if SameText(MethodJson.S['Name'], 'RunDbQuery') then begin
                  RunDbQuery(MethodJson.O[TAG_CLOUD_Params].S['DatabaseDirectory'], MethodJson.O[TAG_CLOUD_Params].S['SQL'],OutJson.O['JsonOut']);
                end else if SameText(MethodJson.S['Name'], 'AddUser') then begin
                  AddUser(MethodJson.O[TAG_CLOUD_Params]);
                end else if SameText(MethodJson.S['Name'], 'GetDatabaseList') then begin
                  GetDatabaseList(OutJson.O['JsonOut']);
                end else if SameText(MethodJson.S['Name'], 'GetToken') then begin
                  GetToken(MethodJson.O[TAG_CLOUD_Params],OutJson.O['JsonOut']);
                end
              finally
                MethodJson.Free;
              end;
            end;
          end;
        except
          on e: exception do begin
            raise;
          end;
        end;
      end;
    end;
  Finally
    Free;
  end;

end;

(*Function TSystemAPI.GetThreadRunning(aProcessname:String):Boolean;
begin
  Result := true;
  if not(APIOutjson.Exists('ProcessStatus')) or
    not(APIOutjson.O['ProcessStatus'].Exists(aProcessname)) or
    not(APIOutjson.O['ProcessStatus'].O[aProcessname].B['Completed']) then begin
    sleep(1000);
  end else Result := False;
end;*)

class procedure TSystemAPI.GetDatabaseList(OutJson: TJsonObject);
var
  conn: TMyConnection;
  sl: TStringList;
  I: integer;
begin
  conn := TMyConnection.Create(nil);
  sl := TStringList.Create;
  try
    SetConnectionProps(conn,MYSQL_DATABASE,AppEnv.AppDb.Server);
    conn.Connect;
    conn.GetDatabaseNames(sl);
    for I := 0 to sl.Count -1 do
      OutJson.A['DatabaseList'].Add(sl[I]);
  finally
    sl.Free;
    conn.Free;
  end;

end;

class procedure TSystemAPI.GetDatabaseStatus(const aDatabaseName: string;
  OutJson: TJsonObject);
var
  cfg: TConfigDb;
begin
  cfg := TConfigDb.Create(aDatabaseName, AppEnv.AppDb.Server);
  try
    OutJson.AsString := cfg.Value;
  finally
    cfg.Free;
  end;
end;

class procedure TSystemAPI.GetToken(Params, OutJson: TJsonObject);
var
  ExpireMinutes: integer;
begin
  ExpireMinutes := -1;
  if Params.IntegerExists('ExpireMinutes') then
    ExpireMinutes := Params.I['ExpireMinutes'];
  if ExpireMinutes > -1 then begin
    OutJson.S['Token'] :=
      TokenList.NewToken(Params.S['DatabaseDirectory'], Params.S['Username'], Params.S['Password'], ExpireMinutes);
    OutJson.I['ExpireMinutes'] := ExpireMinutes;
  end
  else begin
    OutJson.S['Token'] :=
      TokenList.NewToken(Params.S['DatabaseDirectory'], Params.S['Username'], Params.S['Password']);
    OutJson.I['ExpireMinutes'] := DEFAULT_TOKEN_EXPIRE_MINUTES;
  end;
end;

class procedure TSystemAPI.RunDbQuery(const aDatabaseName, aSQL: string;
  OutJson: TJsonObject);
var
  conn: TMyConnection;
  qry: TMyQuery;
  Json: TJsonObject;
begin
  conn := TMyConnection.Create(nil);
  qry := TMyQuery.Create(nil);
  try
    SetConnectionProps(conn,aDatabaseName,AppEnv.AppDb.Server);
    conn.Connect;
    qry.Connection := conn;
    qry.SQL.Text := aSQL;
    qry.Open;
    while not qry.Eof do begin
      Json := JO;
      DatasetToJson(qry,Json);
      OutJson.A['Data'].Add(Json);
      qry.Next;
    end;
  finally
    qry.Free;
    conn.Free;
  end;
end;


(*procedure TSystemAPI.setThreadRunning(aProcessname: String; const Value: Boolean);
begin
  APIOutjson.O['ProcessStatus'].O[aProcessname].B['Completed']:= Value;
end;*)

{ TApiServerTaskThread }

constructor TApiServerTaskThread.Create(aCommand, aServer: string; aOutJson :TJsonObject; aOnEvent:TEventProc; params: string = ''; aLogger: TLoggerBase = nil);
begin
  fCommand := aCommand;
  fServer := aServer;
  fParams := params;
  TaskRec := TServerTaskRec.New(fCommand, fServer);
  TaskRec.TaskStatus := 'Unknown';
  TaskRec.Save;
  FreeOnTerminate := True;
  fOnEvent := aOnEvent;
  inherited Create(aLogger, False);
  fOutJson := aOutJson;
  fOnEvent('Log8', 'TApiServerTaskThread.Create', True); { "Extra Log" }
//  Priority := tpLower;
end;

destructor TApiServerTaskThread.Destroy;
begin
  TaskRec.Free;
  inherited;
end;

procedure TApiServerTaskThread.Execute;
begin
//  inherited;

  CoInitialize(nil);

  fOnEvent('Log9', 'Command=' + fCommand, True); { "Extra Log" }

  if SameText(fCommand, 'ApiServerTaskThreadTest') then
    DoApiServerTaskThreadTest
  else if SameText(fCommand, 'CreateDatabase') then
    CreateDatabase
  else if SameText(fCommand, 'DropDatabase') then
    DropDatabase;

  if not TaskRec.Complete then begin
    TaskRec.Complete := True;
    TaskRec.Save;
  end;
end;

procedure TApiServerTaskThread.DoApiServerTaskThreadTest;
begin
  Log('DoApiServerTaskThreadTest', ltInfo);
  if Assigned(fOnEvent) then fOnEvent('ThreadEvent', 'Oncomplete');
end;

procedure TApiServerTaskThread.CreateDatabase;
begin
  fOnEvent('Log10', 'CreateDatabase', True); { "Extra Log" }
  WebAPILib.CreateDatabase(TaskRec, fParams, fServer, fOnEvent);
  if Assigned(fOnEvent) then fOnEvent('ThreadEvent', 'Oncomplete');
end;

procedure TApiServerTaskThread.DropDatabase;
var
  conn: TMyConnection;
  params: TJsonObject;
begin
  try
    TaskRec.TaskStatus := 'Working';
    TaskRec.Save;

    conn := TMyConnection.Create(nil);
    params := JO(fParams);
    try
      if not (params.Exists(VS1_TAG_DatabaseName)) or (trim(params.S[VS1_TAG_DatabaseName]) ='') then begin
        fOnEvent('Drop Database Error', 'Database Name not Provided for Deleting',true); { "Extra Log" }
        Exit;
      end;

      SetConnectionProps(conn,'erpnewdb',fServer);
      conn.Connect;

      //conn.ExecSQL('drop database ' + params.S['DatabaseDirectory'], []);
      conn.ExecSQL('drop database ' + params.S[VS1_TAG_DatabaseName], []);
      While Appenv.appdb.DatabaseExists(params.S[VS1_TAG_DatabaseName]) do begin
        fOnEvent('Response', 'Droping Database ' + params.S[VS1_TAG_DatabaseName],true); { "Extra Log" }
        sleep(50);
      end;

    finally
      params.Free;
      conn.Free;
    end;
    TaskRec.Complete := true;
    TaskRec.TaskStatus := 'Done';
    TaskRec.StatusMessage := 'Database dropped';
    TaskRec.Save;
  except
    on e: exception do begin
      TaskRec.Complete := true;
      TaskRec.TaskStatus := TAG_ResponseError;
      TaskRec.StatusMessage := e.Message;
      TaskRec.Save;
    end;
  end;
  if assigned(fOnEvent) then fOnEvent('ThreadEvent','Oncomplete');
end;

end.
