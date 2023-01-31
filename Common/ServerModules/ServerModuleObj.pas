unit ServerModuleObj;

interface

uses
  LogThreadBase, LogThreadLib, LogMessageTypes, ModuleComms3, JsonObject,
  ThreadProperty, Classes, ServerModuleThreadTask;

type

  {$M+}
  TServerModule = class
  private
    fLogger: TLoggerBase;
    fOwnedLogger: TLoggerBase;
    TerminatedProp: TThreadProperty;
    RestartProp: TThreadProperty;
    ActiveProp: TThreadProperty;
    LoggingLevelProp: TThreadProperty;
    fServerVersion: string;
    fMySQLServer: string;
    procedure SetTerminated(const Value: boolean);
    function GetLogger: TLoggerBase;
    procedure SetLogger(const Value: TLoggerBase);
    procedure DoOnCommsMessage(aClientId: integer; aData: string);
    procedure DoOnCommsRequest(aClientId: integer; aRequest: string; var aResponse: string);
    function GetTerminated: boolean;
    function GetModuleName: string;
    function GetRestart: boolean;
    procedure SetRestart(const Value: boolean);
    function GetModuleFileName: string;
    function GetServerVersion: string;
    function GetLoggerClass: string;
    (*procedure LogintoDB(var nextnum :Integer; titles, Values : array of String);*)

  protected
    SleepTime: Integer;
    ClientNotificationList: TThreadList;
    ThreadTaskList: TServerModuleTaskList;
    CommsServer: TModuleComms;
    fNextTaskListCheckTime: TDateTime;
    CommonConfig: TJsonObject;

    procedure LogEventHandler(Sender: TObject; const Event, Value : string);
    procedure SetActive(const Value: boolean); virtual;
    function GetActive: boolean; virtual;
    function GetLoggingLevel: TLoggingLevel; virtual;
    procedure SetLoggingLevel(const Value: TLoggingLevel); virtual;
    property ServerVersion: string read GetServerVersion;
    function CreateNewLogger: TLoggerBase; virtual;

    { override in desendents }
    function GetModuleDescription: string; virtual; abstract;
    function GetModuleVersion: string; virtual;
    procedure AfterLoadConfig; virtual;
    procedure ConfigNotFound; virtual;

    procedure DoOnMessage(aClientId: integer; aData: string; ctx: TJsonObject); overload; virtual;
    procedure DoOnMessage(aClientId: integer; aData: TJsonObject; ctx: TJsonObject); overload; virtual; abstract;
    procedure DoOnCommandMessage(aData: string; ctx: TJsonObject); virtual;

    procedure DoOnRequest(aClientId: integer; aRequest: string; ctx: TJsonObject; var aResponse: string); overload; virtual; abstract;
    procedure DoOnRequest(aClientId: integer; aRequest: TJsonObject; ctx: TJsonObject; aResponse: TJsonObject = nil); overload; virtual;
    procedure DoOnCommandRequest(aRequest: string; var aResponse: string); virtual;

    procedure DoWork; virtual; abstract;
    function ERPDatabaseList(IncludeNewDb: boolean = false): string;

    function GetGuiInERP: boolean; virtual;
    function GetGuiInServiceMenu: boolean; virtual;
    function EncryptConfig: boolean; virtual;
    Procedure LogProc(Const Value:String);

  public
    constructor Create(aLogger: TLoggerBase = nil); virtual;
    destructor Destroy; override;
    procedure Execute;
    property Terminated: boolean read GetTerminated write SetTerminated;
    property Logger: TLoggerBase read GetLogger write SetLogger;
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank); overload;
    property Restart: boolean read GetRestart write SetRestart;
    procedure LoadConfig; virtual;
    procedure SaveConfig; virtual;

    function SendMessage(aClientId: integer; aMessage: string): boolean; overload;
    function SendMessage(aClientId: integer; aMessage: TJsonObject): boolean; overload;

    function SendRequest(aClientId: integer; aRequest: string; var aResponse: string): boolean; overload;
    function SendRequest(aClientId: integer; aRequest: TJsonObject; aResponse: TJsonObject = nil): boolean; overload;

    function SendCommandMessage(aMessage: string): boolean;
    function SendCommandRequest(aRequest: string; var aResponse: string): boolean;

    function SendNotificationMessage(aClientId: integer; aNotificationName, aNotificationData: string): boolean; overload;
    function SendNotificationMessage(aNotificationName, aNotificationData: string): boolean; overload;
    property MySQLServer: string read fMySQLServer write fMySQLServer;

  published
    property ModuleName: string read GetModuleName;
    property ModuleFileName: string read GetModuleFileName;
    property ModuleDescription: string read GetModuleDescription;
    property ModuleVersion: string read GetModuleVersion;
    property Active: boolean read GetActive write SetActive;
    property LoggingLevel: TLoggingLevel read GetLoggingLevel write SetLoggingLevel;
    property LoggerClassName: string read GetLoggerClass;
    property GuiInServiceMenu: boolean read GetGuiInServiceMenu;
    property GuiInERP: boolean read GetGuiInERP;
  end;
  {$M-}

implementation

uses
  {$IfDef VER220}
  SysUtils,
  Windows,
  Dialogs,
  {$Else}
  System.SysUtils,
  WinApi.Windows,
  Vcl.Dialogs,
  {$EndIf}
  ModuleFileNameUtils, JsonToObject, IntegerListObj, {SystemLib,}
  ServerModuleConst, JsonRPCUtils, NotificationItem, StrUtils, {Windows,}
  {DBUtils,} TypInfo, FileVersion, DbGen, CipherUtils, AppEnvironmentVirtual,
  ConfigDbObj , MyAccess, utCloudconst;

const
  TaskListCheckInterval = (1/24/60/60) * 15;


procedure ExecNewProcess(const ProgramName: string; const Wait: boolean);
var
  StartInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CreateOK: boolean;
begin
  { fill with known state }
  FillChar(StartInfo, SizeOf(TStartupInfo), #0);
  FillChar(ProcInfo, SizeOf(TProcessInformation), #0);
  StartInfo.cb := SizeOf(TStartupInfo);
  CreateOK := CreateProcess(nil, PChar(ProgramName), nil, nil, false, CREATE_NEW_PROCESS_GROUP + NORMAL_PRIORITY_CLASS,
    nil, nil, StartInfo, ProcInfo);
  { check to see if successful }
  if CreateOK then begin
    //may or may not be needed. Usually wait for child processes
    if Wait then WaitForSingleObject(ProcInfo.hProcess, INFINITE);
  end else begin
    MessageDlg('Unable to run ' + ProgramName, mtInformation , [mbOK], 0);
  end;
  CloseHandle(ProcInfo.hProcess);
  CloseHandle(ProcInfo.hThread);
end;


{ TServerModule }

//function TServerModule.AddThreadTask(aThreadTask: TServerModuleThreadTask;
//  aClientId: integer; aParams: TJsonObject): integer;
//begin
//  result := 0;
//  try
//    result := self.ThreadTaskList.AddTask(aThreadTask, aClientId, aParams);
//  except
//
//  end;
//end;

procedure TServerModule.AfterLoadConfig;
begin

end;

procedure TServerModule.ConfigNotFound;
begin

end;

constructor TServerModule.Create(aLogger: TLoggerBase);
var
  CommonConfigFileName: string;
  ChannelName: String;
begin
  CommonConfig := JO;
  fLogger := aLogger;
  FOwnedLogger := nil;
  Log(Self.ModuleName + ' Starting ..', ltInfo);

  try
    fMySQLServer := '127.0.0.1';
    CommonConfigFileName := ExtractFilePath(ModuleFileName) + 'ERPModCommon_Config.cfg';

    if FileExists(CommonConfigFileName) then begin
      CommonConfig.LoadFromFile(CommonConfigFileName);
      if CommonConfig.StringExists('MySQLServer') then
        fMySQLServer := CommonConfig.S['MySQLServer']
    end;

    TerminatedProp := TThreadProperty.Create('false');
    RestartProp := TThreadProperty.Create('false');
    ActiveProp := TThreadProperty.Create('true');
    LoggingLevelProp := TThreadProperty.Create('0');
    ClientNotificationList := TThreadList.Create;

    SleepTime := 20;

    ChannelName := GetModuleName;
    if SameText(ChannelName, 'ERPModWebAPI') or SameText(ChannelName, 'ERPWebServerConsole') then
      ChannelName := 'ERPWebService';

    CommsServer := TModuleComms.Create(ChannelName, True, MySQLServer, Logger);
    CommsServer.OnMessage := Self.DoOnCommsMessage;
    CommsServer.OnRequest := Self.DoOnCommsRequest;

    ThreadTaskList := TServerModuleTaskList.Create(Self);
    fNextTaskListCheckTime := Now + TaskListCheckInterval;

  except
    on e: exception do begin
      Log('Create error: ' + e.Message, ltError);
      raise;
    end;
  end;
end;

function TServerModule.CreateNewLogger: TLoggerBase;
var
  s: string;
begin
  Result := TLogger.Create(nil);
  s := Lowercase(TLogger(Result).LogPath);
  if pos('modules\log', s) > 0 then begin
    s := StrUtils.ReplaceStr(s, 'modules\log', 'log');
    TLogger(Result).LogPath := s;
  end;
end;

destructor TServerModule.Destroy;
var
  DoRestart: boolean;
  sl: TStringList;
  lst: TList;
begin
  Log(Self.ModuleName + ' Shutting down.', ltInfo);
  if Assigned(Logger) then begin
    while not Logger.Buffer.Empty do
      Sleep(10);
  end;
  ThreadTaskList.Free;
  CommsServer.Free;
  FOwnedLogger.Free;
  TerminatedProp.Free;
  DoRestart := Restart;
  RestartProp.Free;
  ActiveProp.Free;
  LoggingLevelProp.Free;

  lst := ClientNotificationList.LockList;
  try
    while lst.Count > 0 do begin
      TClientNotificationItem(lst[0]).Free;
      lst.Delete(0);
    end;
  finally
    ClientNotificationList.UnlockList;
  end;
  ClientNotificationList.Free;
  CommonConfig.Free;
  if DoRestart then begin
    { http://ss64.com/nt/start.html }
    sl:= TStringList.Create;
    try
      sl.Add('SLEEP 5');
      sl.Add('START "' + ModuleFileNameUtils.GetCurrentModuleName + '" "' + ModuleFileNameUtils.GetCurrentModuleName + '"');
      sl.SaveToFile(ChangeFileExt(ModuleFileNameUtils.GetCurrentModuleName,'_Restart.bat'));
    finally
      sl.Free;
    end;
    ExecNewProcess(ChangeFileExt(ModuleFileNameUtils.GetCurrentModuleName,'_Restart.bat'),false);
  end;
  inherited;
end;

procedure TServerModule.DoOnCommandMessage(aData: string; ctx: TJsonObject);
var
  x: integer;
  cmd, val: string;
begin
  x := Pos(MSG_SEP_STR, aData);
  if x > 0 then begin
    cmd := Copy(aData,1,x-1);
    val := Copy(aData,x+Length(MSG_SEP_STR),MaxInt);
  end
  else
    cmd := aData;

  if SameText(cmd,'Terminate') then
    Terminated := true
  else if SameText(cmd,'Restart') then
    Restart := true
  else if SameText(cmd,'SetActive') then begin
    Active := SameText(val,'true');
  end
  else if SameText(cmd,'SetLoggingLevel') then begin
    self.LoggingLevel := StrToLoggingLevel(val);
  end;
end;

procedure TServerModule.DoOnCommandRequest(aRequest: string; var aResponse: string);
var
  json: TJsonObject;
begin
  if SameText(aRequest,'GetActive') then begin
    if Active then
      aResponse := 'true'
    else
      aResponse := 'false';
  end
  else if SameText(aRequest, 'GetLoggingLevel') then begin
    aResponse := LoggingLevelToStr(self.LoggingLevel);
  end
  else if SameText(aRequest, 'GetLoggerClassName') then begin
    aResponse := self.LoggerClassName;
  end
  else if SameText(aRequest, 'GetModuleDescription') then begin
    aResponse := ModuleDescription;
  end
  else if SameText(aRequest, 'GetModuleVersion') then begin
    aResponse := ModuleVersion;
  end
  else if SameText(aRequest, 'GetGuiInERP') then begin
    if GuiInERP then aResponse := 'true'
    else aResponse := 'false';
  end
  else if SameText(aRequest, 'GetGuiInServiceMenu') then begin
    if GuiInServiceMenu then aResponse := 'true'
    else aResponse := 'false';
  end
  else if SameText(aRequest, 'GetTaskList') then begin
    json := JO;
    try
      Self.ThreadTaskList.GetTaskListAsJson(Json);
      json.S['ModuleName'] := self.ModuleName;
      aResponse := json.AsString;
    finally
      Json.Free;
    end;
  end;
end;

procedure TServerModule.DoOnCommsMessage(aClientId: integer; aData: string);
var
  typeStr: string;
  dataJson: TJsonObject;
  ctx: TJsonObject;
begin
  if Length(aData) < 1 then exit;
  ctx := JO;
  try
    typeStr := Copy(aData,1,1);
    if SameText(typeStr,IntToStr(Ord(mtString))) then
      DoOnMessage(aClientId,Copy(aData,2,MaxInt),ctx)
    else if SameText(typeStr,IntToStr(Ord(mtJson))) then begin
      dataJson := JO;
      try
        dataJson.AsString := Copy(aData,2,MaxInt);
        DoOnMessage(aClientID, dataJson, ctx);
      finally
        dataJson.Free;
      end;
    end
    else if SameText(typeStr,IntToStr(Ord(mtCommand))) then begin
      DoOnCommandMessage(Copy(aData,2,MaxInt),ctx)
    end;
  finally
    ctx.Free;
  end;
end;

{binny}
(*procedure TServerModule.LogintoDB(var nextnum :Integer; titles, Values : array of String);
var
  Qry :TMyQuery;
  x:Integer;
begin
    try
      if length(Values)=0 then exit;
      qry := TMyQuery.create(nil);
      try
        qry.Connection := TMyconnection.Create(Qry);
        TMyconnection(qry.Connection).LoginPrompt := false;
        TMyconnection(qry.Connection).Port := 3309;
        TMyconnection(qry.Connection).Username := 'P_One';
        TMyconnection(qry.Connection).Password := '1w$p&LD07';
        TMyconnection(qry.Connection).Server := 'localhost';
        TMyconnection(qry.Connection).Connected := True;
        qry.SQL.Text := ' CREATE DATABASE IF NOT EXISTS erpserverlog ; '+
                        ' CREATE TABLE IF NOT EXISTS erpserverlog.tblerpserverlog ('+
                        '   ID int(11) NOT NULL AUTO_INCREMENT,'+
                        '   LogTimeStamp timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,'+
                        '   Groupctr int(11) DEFAULT NULL,'+
                        '   Caption varchar(255) DEFAULT NULL,'+
                        '   LogData text,'+
                        '   PRIMARY KEY (ID)'+
                        ' ) ENGINE=MyISAM DEFAULT CHARSET=utf8;';

        qry.Execute;
        TMyconnection(qry.Connection).Connected := False;
        TMyconnection(qry.Connection).Database := 'erpserverlog';
        TMyconnection(qry.Connection).Connected := True;

        if nextnum =0 then begin
          qry.SQL.Text := 'Select max(GroupCtr) groupctr from tblerpserverlog ';
          qry.open;
          nextnum := qry.Fieldbyname('groupctr').AsInteger+1;
          qry.close;
        end;
        qry.SQL.Text := 'select * from tblerpserverlog limit 1';
        qry.open;
        for x := low(values) to high(Values) do begin
          qry.append;
          qry.Fieldbyname('Groupctr').AsInteger := nextnum;
          try qry.Fieldbyname('Caption').AsString := titles[x]; Except end;
          try qry.Fieldbyname('LogData').AsString := values[x]; Except end;
          qry.Post;
        end;
      finally
        Freeandnil(Qry);
      end;
    Except
      on E:Exception do begin
        Log(E.Message);
      end;
    end;
end;*)
procedure TServerModule.DoOnCommsRequest(aClientId: integer; aRequest: string;
  var aResponse: string);
var
  typeStr: string;
  jsonRequest,
  jsonResponse: TJsonObject;
  ctx: TJsonObject;
  nextnum:Integer;
begin
  nextnum :=0;

  {binny}
  //// Log('LogintoDB-1');
  //// try LogintoDB(nextnum,['Request'],[aRequest]); Except on E:Exception do begin Log(E.Message);  end; end;

  if Length(aRequest) < 1 then exit;
  ctx := JO;
  try
    typeStr := Copy(aRequest,1,1);
    //Log('DoOnCommsRequest - Type: ' + typeStr + ' Request: ' + aRequest + ' Response: ' + aResponse);
    {binny}
    //// Log('LogintoDB-2');
    //// try LogintoDB(nextnum,['DoOnCommsRequest - Type',' Request','Response'] , [typeStr,aRequest,aResponse]); Except on E:Exception do begin Log(E.Message);  end; end;

    if SameText(typeStr,IntToStr(Ord(mtString))) then
      DoOnRequest(aClientId,Copy(aRequest,2,MaxInt),ctx,aResponse)
    else if SameText(typeStr,IntToStr(Ord(mtJson))) then begin
      jsonRequest := JO;
      jsonRequest.AsString := Copy(aRequest,2,MaxInt);
      {binny}
      //// try LogintoDB(nextnum,['Name'],[jsonRequest.O[TAG_CLOUD_Params].S['Name']]); Except on E:Exception do begin Log(E.Message);  end; end;

      {binny}
      //// try LogintoDB(nextnum,['Server Name'],[TJsonObject(jsonRequest.O[TAG_CLOUD_Params].O['ServerList'].A['Items'].Items[0]).S['ComputerName']]); Except on E:Exception do begin Log(E.Message);  end; end;

      jsonResponse := nil;
      if aResponse <> '' then begin
        jsonResponse := JO;
        jsonResponse.AsString := aResponse;
      end;
      try
        DoOnRequest(aClientId,jsonRequest,ctx,jsonResponse);
        if Assigned(jsonResponse) then
          aResponse := jsonResponse.AsString;
      finally
        jsonRequest.Free;
        jsonResponse.Free;
      end;
    end
    else if SameText(typeStr,IntToStr(Ord(mtCommand))) then begin
      DoOnCommandRequest(Copy(aRequest,2,MaxInt), aResponse);
    end;
  finally
    ctx.Free;
  end;
end;

procedure TServerModule.DoOnMessage(aClientId: integer; aData: string;
  ctx: TJsonObject);
begin

end;

procedure TServerModule.DoOnRequest(aClientId: Integer; aRequest: TJsonObject;
  ctx: TJsonObject; aResponse: TJsonObject);
var
  methodName: String;
  idx: Integer;
  lst: TList;
  ClientNotificationItem: TClientNotificationItem;
  NotificationType: String;
  x: Integer;
  pair: TJSONValuePair;
  PropInfo: PPropInfo;
  props: TJsonObject;
begin
  props := nil;
  methodName := Lowercase(aRequest.S['method']);
  idx := Pos('.', methodName);
  if idx > 0 then
    methodName := Copy(methodName, idx + 1, Length(methodName));
  if SameText(methodName, 'RegisterForNotification') then begin
    ctx.B['Handled'] := True;

    if aRequest.ObjectExists(TAG_CLOUD_Params) and aRequest.O[TAG_CLOUD_Params].StringExists('NotificationType') then
      NotificationType := aRequest.O[TAG_CLOUD_Params].S['NotificationType']
    else
      NotificationType := '';

    lst := ClientNotificationList.LockList;
    try
      ClientNotificationItem := TClientNotificationItem.Create;
      ClientNotificationItem.ClientId := aClientID;
      ClientNotificationItem.NotificationName:= NotificationType;
      lst.Add(ClientNotificationItem);
      AddResultOk(aResponse);
    finally
      ClientNotificationList.UnlockList;
    end;
  end
  else if SameText(methodName, 'DeregisterForNotification') then begin
    ctx.B['Handled'] := True;
    if aRequest.ObjectExists(TAG_CLOUD_Params) and aRequest.O[TAG_CLOUD_Params].StringExists('NotificationType') then
      NotificationType := aRequest.O[TAG_CLOUD_Params].S['NotificationType']
    else
      NotificationType := '';
    Log('Removing notification list item, ClientId: ' + IntToStr(aClientId) + ', Type: ' + NotificationType, ltDetail);

    lst := ClientNotificationList.LockList;
    try
      x := 0;
      while x < lst.Count do begin
        ClientNotificationItem := TClientNotificationItem(lst[x]);
        if (ClientNotificationItem.ClientId = aClientID) and
          ((NotificationType = '') or
           (SameText(NotificationType,ClientNotificationItem.NotificationName))) then begin
          ClientNotificationItem.Free;
          lst.Delete(x);
        end
        else
          Inc(x);
      end;
      AddResultOk(aResponse);
    finally
      ClientNotificationList.UnlockList;
    end;
  end
  else if SameText(methodName, 'SetModuleProperty') then begin
    ctx.B['Handled'] := true;
    if aRequest.ObjectExists(TAG_CLOUD_Params) then begin
      try
        props := JO;
        try
          if aRequest.O[TAG_CLOUD_Params].BooleanExists('Encrypted') and aRequest.O[TAG_CLOUD_Params].B['Encrypted'] then
            props.AsString := CipherUtils.DecryptString(aRequest.O[TAG_CLOUD_Params].S['Data'])
          else
            props.Assign(aRequest.O[TAG_CLOUD_Params]);
          for x := 0 to props.Count -1 do begin
            { should contain one or more simple json value pairs }
            pair := props.Items[x];
            case pair.ValueType of
              TJSONValueType.valNone: {ignore};
              TJSONValueType.valString:
                begin
                  PropInfo := GetPropInfo(self,pair.Name);
                  case PropInfo^.PropType^.Kind of
                    tkString: TypInfo.SetStrProp(self,PropInfo,pair.Value.AsString);
                    tkWString: TypInfo.SetWideStrProp(self,PropInfo,pair.Value.AsString);
                    tkLString: TypInfo.SetAnsiStrProp(self,PropInfo,AnsiString(pair.Value.AsString));
                  end;
                  //self.SaveConfig(EncryptConfig);
                  self.SaveConfig;
                end;
              TJSONValueType.valNumber:
                begin
                  PropInfo := GetPropInfo(self,pair.Name);
                  case PropInfo^.PropType^.Kind of
                    tkInteger: TypInfo.SetOrdProp(self,PropInfo,pair.Value.AsInteger);
                    tkInt64: TypInfo.SetInt64Prop(self,PropInfo,pair.Value.AsInteger);
                    tkFloat: TypInfo.SetFloatProp(self,PropInfo,pair.Value.AsFloat);
                  end;
                  //self.SaveConfig(EncryptConfig);
                  self.SaveConfig;
                end;
              TJSONValueType.valObject: {ignore};
              TJSONValueType.valArray: {ignore};
              TJSONValueType.valNull: {ignore};
              TJSONValueType.valBoolean:
                begin
                  if Pair.VAlue.AsBoolean then
                    TypInfo.SetEnumProp(self,Pair.Name,'True')
                  else
                    TypInfo.SetEnumProp(self,Pair.Name,'False');
                  //self.SaveConfig(EncryptConfig);
                  self.SaveConfig;
                end;
            end;
          end;
          JsonRPCUtils.AddResultOk(aResponse);
        except
          on e: exception do begin
            AddResultError(aResponse,'Error setting configuration property: ' + e.Message);
          end;
        end;
      finally
        props.Free;
      end;
    end;
  end;
end;

function TServerModule.EncryptConfig: boolean;
begin
  result := false;
end;

function TServerModule.ERPDatabaseList(IncludeNewDb: boolean): string;
var
  sl: TStringList;
begin
  result := TDbGen.GetDatabaseList(MySQLServer,true);
  if not IncludeNewDb then begin
    sl := TStringList.Create;
    try
      sl.CaseSensitive := false;
      sl.CommaText := result;
      if sl.IndexOf('erpnewdb') > -1 then
        sl.Delete(sl.IndexOf('erpnewdb'));
      result := sl.CommaText;
    finally
      sl.Free;
    end;
  end;
end;

procedure TServerModule.Execute;
begin
  while not Terminated do begin
    try
      DoWork;
    except
      on e: exception do begin
        Logger.Log('Exception during DoWork: ' + e.Message, ltError);
      end;
    end;

    if Now > fNextTaskListCheckTime then begin
      try
        ThreadTaskList.RemoveCompleteTasks;
      except
      end;

      fNextTaskListCheckTime := Now + TaskListCheckInterval;
    end;

    if not Terminated then begin
      Sleep(SleepTime);
    end;
  end;

  Logger.Log('Set Terminated to true.', ltInfo);
end;

function TServerModule.GetActive: boolean;
begin
  result := ActiveProp.AsBoolean;
end;

function TServerModule.GetGuiInERP: boolean;
begin
  result := true;
end;

function TServerModule.GetGuiInServiceMenu: boolean;
begin
  result := true;
end;

function TServerModule.GetLogger: TLoggerBase;
begin
  if Assigned(fLogger) then
    Result := fLogger
  else if Assigned(FOwnedLogger) then
    Result := FOwnedLogger
  else begin
    FOwnedLogger := CreateNewLogger;
    Result := FOwnedLogger;
    Result.Events.AddMultiEvent(LogEventHandler);
  end;
end;

function TServerModule.GetLoggerClass: string;
begin
  result := '';
  if Assigned(self.Logger) then
    result := self.Logger.ClassName;
end;

function TServerModule.GetLoggingLevel: TLoggingLevel;
begin
  result := TLoggingLevel(LoggingLevelProp.AsInteger);
end;

function TServerModule.GetModuleFileName: string;
begin
  Result := ModuleFileNameUtils.GetCurrentModuleName;
end;

function TServerModule.GetModuleName: string;
begin
  Result := ChangeFileExt(ExtractFileName(ModuleFileNameUtils.GetCurrentModuleName), '');
end;

function TServerModule.GetModuleVersion: string;
begin
  result := FileVersion.GetFileVersion(ModuleFileName);
end;

function TServerModule.GetRestart: boolean;
begin
  result := RestartProp.AsBoolean;
end;

function TServerModule.GetServerVersion: string;
begin
  if fServerVersion = '' then begin
    SendCommandRequest('GetServerVersion',fServerVersion);
  end;
  result := fServerVersion;
end;

function TServerModule.GetTerminated: boolean;
begin
  result:= TerminatedProp.AsBoolean;
end;

//function TServerModule.GetThreadTaskStatus(const aTaskId: integer;
//  var aFinished: boolean; var aStartTime: TDateTime;
//  var aStatusMessage: string): boolean;
//begin
//
//end;

procedure TServerModule.LoadConfig; //(encrypt: boolean);
var
  configFileName: string;
  ConfigDb: TConfigDb;
begin
  try
    ConfigDb := TConfigDb.Create(Self.ModuleName + '_Config', Self.MySQLServer);
    try
      if not ConfigDb.Exists then begin
        { virtual methods for decendents to inherit }
        ConfigNotFound;
        { check to see if we have old style config file on disk .. }
        configFileName := ChangeFileExt(Self.ModuleFileName, '_Config.cfg');
        if FileExists(configFileName) then begin
          try
            try
              FileToObj(configFileName, Self, Self.EncryptConfig);
            except
              try
                FileToObj(configFileName, Self, True);
              except
                on e: exception do begin
                  Log('Error reading old config file: ' + e.Message, ltError);
                end;
              end;
            end;
          except
            on e: exception do begin
              Log('Error reading old config file: ' + e.Message, ltError);
            end;
          end;
          SaveConfig;
          SysUtils.DeleteFile(configFileName);
        end;
      end;
      { load config }
      try
        StrToObj(ConfigDb.Value, Self, Self.EncryptConfig);
      except
        on e: exception do begin
          Log('Error reading config data drom database: ' + e.Message, ltError);
          Log('Dataread: ' + ConfigDb.Value, ltError);
        end;
      end;
    finally
      ConfigDb.Free;
    end;

    AfterLoadConfig;
  except
    on e: exception do begin
      Log('Error reading config file: ' + e.Message,ltError);
      raise;
    end;
  end;
end;

procedure TServerModule.SaveConfig; //(encrypt: boolean);
var
//  configFileName: string;
  ConfigDb: TConfigDb;
begin
  try
    ConfigDb := TConfigDb.Create(self.ModuleName + '_Config',self.MySQLServer);
    try
      ConfigDb.Value := ObjToStr(self,self.EncryptConfig);
    finally
      ConfigDb.Free;
    end;
  except
    on e: exception do begin
      Log('Error saving config data to database: ' + e.Message, ltError);
    end;
  end;
//  try
//    configFileName:= ChangeFileExt(self.ModuleFileName, '_Config.cfg');
//    ObjToFile(self, configFileName, self.EncryptConfig  {encrypt});
//  finally
//  end;
end;

procedure TServerModule.Log(const msg: string; const LogMessageType: TLogMessageType);
begin
  if Assigned(Logger) then
    Logger.Log(msg, LogMessageType);
end;

(*procedure TServerModule.Log(const aText: string);
begin
  if Assigned(Logger) then
    Logger.Log(aText, ltInfo);
end;*)

procedure TServerModule.LogEventHandler(Sender: TObject; const Event, Value: String);
var
  str: string;
begin
  str := EncodeString(Value);
  SendNotificationMessage('event', '{"eventname": "' + Event + '", "value": "' + str + '"}');
end;

procedure TServerModule.LogProc(const Value: String);
begin
  Log(Value,ltError);
end;

//procedure TServerModule.RemoveCompleteThreadTasks;
//begin
//
//end;

//procedure TServerModule.RemoveThreadTask(aTaskId: integer);
//begin
//
//end;

function TServerModule.SendMessage(aClientId: Integer;  aMessage: String): Boolean;
begin
  Result := CommsServer.SendMessage(aClientId, IntToStr(Ord(mtString)) + aMessage);
end;

function TServerModule.SendRequest(aClientId: Integer; aRequest: String; var aResponse: string): Boolean;
begin
  Result := CommsServer.SendRequest(aClientId, IntToStr(Ord(mtString)) + aRequest, aResponse);
end;

procedure TServerModule.SetActive(const Value: boolean);
begin
  ActiveProp.AsBoolean := Value;
end;

procedure TServerModule.SetLogger(const Value: TLoggerBase);
begin
  fLogger := Value;
  if Assigned(fLogger) then begin
    fLogger.Events.RemoveMultiEvent(LogEventHandler);
    fLogger.Events.AddMultiEvent(LogEventHandler);
  end;
end;

procedure TServerModule.SetLoggingLevel(const Value: TLoggingLevel);
begin
  LoggingLevelProp.AsInteger := Ord(Value);
  Logger.SetLoggingLevel(Value);
end;

procedure TServerModule.SetRestart(const Value: boolean);
begin
  RestartProp.AsBoolean := Value;
  if Value then
    Terminated := true;
end;

procedure TServerModule.SetTerminated(const Value: boolean);
begin
  TerminatedProp.AsBoolean := Value;
end;

//function TServerModule.StartThreadTaskTask(
//  ThreadTaskClass: TServerModuleThreadTaskClass; aClientId: integer;
//  aParams: TJsonObject; NewInstance: boolean): integer;
//begin
//
//end;

function TServerModule.SendCommandMessage(aMessage: string): boolean;
begin
  Result := CommsServer.SendMessage(0, IntToStr(Ord(mtCommand)) +  aMessage);
end;

function TServerModule.SendCommandRequest(aRequest: string; var aResponse: string): boolean;
begin
  Result := CommsServer.SendRequest(0, IntToStr(Ord(mtCommand)) +  aRequest,aResponse);
end;

function TServerModule.SendNotificationMessage(aClientId: Integer; aNotificationName,
  aNotificationData: String): Boolean;
begin
  Result := CommsServer.SendMessage(aClientId, IntToStr(Ord(mtNotification)) + aNotificationName + MSG_SEP_STR + aNotificationData);
end;

function TServerModule.SendMessage(aClientId: integer;
  aMessage: TJsonObject): boolean;
begin
  Result := CommsServer.SendMessage(aClientId, IntToStr(Ord(mtJson)) +  aMessage.AsString);
end;

function TServerModule.SendNotificationMessage(aNotificationName, aNotificationData: String): Boolean;
var
  lst: TList;
  x: integer;
  item: TClientNotificationItem;
  ClientIdList: TIntegerList;
begin
  Result := True;
  { send notification to all clients registered for this notification type }
  ClientIdList := TIntegerList.Create;
  try
    { don't want to keep list locked while sending notifications so just get
      a list of Client id's to send to .. }
    lst := ClientNotificationList.LockList;
    try
      for x := 0 to lst.Count - 1 do begin
        item := lst[x];
        { blank NotificationName means send all types of notification }
        if SameText(item.NotificationName, aNotificationName) or (item.NotificationName = '') then
          ClientIdList.Add(item.ClientId);
      end;
    finally
      ClientNotificationList.UnlockList;
    end;

    { now send notification to clients }
    for x := 0 to ClientIdList.Count - 1 do
      Self.SendNotificationMessage(ClientIdList[x], aNotificationName, aNotificationData);

  finally
    ClientIdList.Free;;
  end;
end;

function TServerModule.SendRequest(aClientId: integer; aRequest,
  aResponse: TJsonObject): boolean;
var
  outStr: string;
begin
  result := CommsServer.SendRequest(aClientId, IntToStr(Ord(mtJson)) +  aRequest.AsString, outStr);
  if result then begin
    if outStr <> '' then begin
      if not Assigned(aResponse) then
        aResponse := TJsonObject.Create;
      aResponse.AsString := outStr;
    end
    else begin
      if Assigned(aResponse) then begin
        FreeAndNil(aResponse);
      end;
    end;
  end;
end;


end.

