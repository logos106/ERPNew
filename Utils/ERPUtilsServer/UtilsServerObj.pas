unit UtilsServerObj;

{$I ErpUtilsService.inc}
interface

uses
  JsonRpcTcpServer, JsonRpcBase, JSONObject,
//  ModuleControl,
  LogThreadLib, LogThreadBase, LogMessageTypes, classes, IpRangeListObj, sysutils,
//  IdHttpServer, IdContext, IdCustomHTTPServer, IdSSLOpenSSL, IdSSL, HTTPServerConfigObj,
  SyncObjs, ModuleConst, UtilsServerConfigObj,
  ServerModuleStubObj, ThreadProperty, ServerModuleList, IdContext;

type

  TLogEvent = procedure (aMsg: string) of object;

//  THTTPServerConfigSvr = class(THTTPServerConfig)
//  private
//    fHTTPServer: TIdHTTPServer;
//    fLoading: boolean;
//    fLock: TCriticalSection;
//    FLogger: TLoggerBase;
//    procedure SetHTTPServer(const Value: TIdHTTPServer);
//    procedure AddPortToBindings(aPort: word);
//    procedure RemovePortFromBindings(aPort: word);
//  protected
//    procedure SetActive(const Value: boolean); override;
//    procedure SetDefaultPort(const Value: integer); override;
//    procedure SetDefaultSSLPort(const Value: integer); override;
//    procedure SetMaxConnections(const Value: integer); override;
//    procedure SetUseSSL(const Value: boolean); override;
//    procedure SetWebUserName(const Value: string); override;
//    procedure SetLoggingLevel(const Value: TLoggingLevel); override;
//  public
//    constructor Create(aLogger: TLoggerBase);
//    destructor Destroy; override;
//    property HTTPServer: TIdHTTPServer read fHTTPServer write SetHTTPServer;
//    procedure Lock;
//    procedure Unlock;
//  end;

  TUtilsServerConfigSvr = class(TUtilsServerConfig)
  private
    FLogger: TLogger;
    procedure SetLogger(const Value: TLogger);
  protected
    procedure SetLoggingLevel(const Value: TLoggingLevel); override;
  published
  public
    property Logger: TLogger read FLogger write SetLogger;
  end;

  TUpdateCheckThread = class;

  {$M+}

  TUtilsServer = class
  private
//    ModuleList: TModuleList;
    ServerModuleList: TERPServerModuleList;
    RPCServer: TJsonRpcTcpServer;
//    HTTPServer: TIdHttpServer;
//    HTTPServerConfig: THTTPServerConfigSvr;
    fActive: Boolean;
    fLogger: TLogger;
    UpdateCheckThread: TUpdateCheckThread;
    fConfig: TJsonObject;
    fConfigFileName: string;
    IpRangeList: TIpRangeList;
    ConfigClientList: TThreadList;
    fLock: TCriticalSection;
    fLoggingLevelProp: TThreadProperty;
    fNextUpdateCheckTimeProp: TThreadProperty;
    ClientNotificationList: TThreadList;
    fMySQLServer: string;
    CommonConfig: TJsonObject;
    procedure Log(msg: string; const LogMessageType: TLogMessageType = ltInfo);
    procedure DoServerOnConnect(Server: TJsonRpcTcpServer; Client: TJsonRpcTcpServerClient);
    procedure DoServerOnDisconnect(Server: TJsonRpcTcpServer; Client: TJsonRpcTcpServerClient);
    procedure DoRPCRequest(Client: TJsonRpcBase; ReqJson: TJSONObject; ResJson: TJSONObject = nil);
    procedure DoOnServerError(AContext: TIdContext; AException: Exception);
    procedure DoModuleNotification(Sender: TServerModuleStub; aClientId: integer; aNotificationName, aNotificationData: string);
    procedure DoModuleCommandRequest(Sender: TServerModuleStub; aRequest: string; var aResponse: string);
//    procedure DoOnCommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
//    procedure DoOnConnect(AContext: TIdContext);
//    procedure DoServerThreadException(AContext:TIdContext; AException: Exception);

    function GetVersion: string;
    function GetActive: Boolean;
    function GetLoggingLevel: TLoggingLevel;
    function GetNextUpdateCheckTime: TDateTime;
    function GetSoftwareReleaseType: string;

    procedure SetActive(const Value: Boolean);
    procedure SetLoggingLevel(const Value: TLoggingLevel);
    procedure LogEventHandler(Sender: TObject; const Event, Value: string);
    procedure SetLogger(const Value: TLogger);
    procedure SetNextUpdateCheckTime(const Value: TDateTime);

  public
//    UtilsServerConfig: TUtilsServerConfigSvr;
    constructor Create(aLogger: TLogger = nil);
    destructor Destroy; override;
    procedure SaveConfig;
    procedure LoadConfig;
    property Active: Boolean read GetActive write SetActive;
    property Logger: TLogger read fLogger write SetLogger;
    property SoftwareReleaseType: string read GetSoftwareReleaseType;
    property Config: TJsonObject read fConfig;
    procedure Lock;
    procedure Unlock;
    property MySQLServer: string read fMySQLServer write fMySQLServer;

  published
    property LoggingLevel: TLoggingLevel read GetLoggingLevel write SetLoggingLevel;
    property NextUpdateCheckTime: TDateTime read GetNextUpdateCheckTime write SetNextUpdateCheckTime;
    property Version: string read GetVersion;
  end;
  {$M-}

  TUpdateCheckThread = class(TThread)
  private
    fIsTerminated: boolean;
    UtilsServer: TUtilsServer;
    fRestartUpdateCheckDone: boolean;
    Logger: TLogger;
    fStartDateTime: TDateTime;
    fNextMemCheck: TDateTime;
    fDoBatchUpdate: boolean;
    procedure CheckForUpdates;
    procedure Log(msg: string; const LogMessageType: TLogMessageType = ltInfo);
    function SoftwareReleaseType: string;

  protected
    procedure Execute; override;

  public
    constructor Create(aUtilsServer: TUtilsServer); reintroduce;
    destructor Destroy; override;
    property IsTerminated: boolean read fIsTerminated;
  end;

implementation

uses
  Forms, Windows, JsonToObject, ModuleUtils,
//  ModuleInfoObj,
  ModuleBaseServerObj, TypInfo, UpdaterCallUtils, InstallConst,
  MySQLUtils, AppRunUtils, JsonRPCConst, Types, StrUtils, WebApiConst,
  SystemLib, UpdaterConst, ModuleBaseObj, NotificationItem, JsonRPCUtils,
  JsonObjectUtils, ClientConfigObj, ModulePortObj, ModuleFileNameUtils,
  ConfigDbObj, CipherUtils, utDbServerThreadTaskList;

const
  DEFAULT_SERVER_VERSION = '11.0.0.0';


{ TUtilsServer }

constructor TUtilsServer.Create(aLogger: TLogger = nil);
var
  ConfigChanged: Boolean;
  CommonConfigFileName: string;
begin
  fMySQLServer := '127.0.0.1';

  CommonConfig := JO;
  CommonConfigFileName := GetCurrentModulePath + 'Modules\ERPModCommon_Config.cfg';
  if FileExists(CommonConfigFileName) then begin
    CommonConfig.LoadFromFile(CommonConfigFileName);
    if CommonConfig.StringExists('MySQLServer') and (CommonConfig.S['MySQLServer'] <> '') then
      fMySQLServer := CommonConfig.S['MySQLServer'];
  end;
  fLoggingLevelProp := TThreadProperty.Create('llDetail');
  fNextUpdateCheckTimeProp := TThreadProperty.Create('0');
  fActive := False;
  Logger := aLogger;
  ClientNotificationList := TThreadList.Create;
  fLock := TCriticalSection.Create;
  ConfigClientList := TThreadList.Create;
  ConfigChanged := fNextUpdateCheckTimeProp.AsBoolean;
  fConfigFileName := ChangeFileExt(GetModuleNameStr, '_Config.cfg');
  fConfig := TJsonObject.Create;
  IpRangeList := TIpRangeList.Create;
  LoadConfig;

  Sleep(10);
  Application.ProcessMessages;

  try
    ServerModuleList := TERPServerModuleList.Create(MySQLServer);
    ServerModuleList.Logger := Logger;
    ServerModuleList.OnNotification := DoModuleNotification;
    ServerModuleList.OnCommandRequest := DoModuleCommandRequest;
  except
    on e: exception do begin
      Log('Error creating ServerModuleList: ' + e.Message, ltError);
    end;
  end;

  try
    RPCServer := TJsonRpcTcpServer.Create;
    RPCServer.OnConnect := DoServerOnConnect;
    RPCServer.OnDisconnect := DoServerOnDisconnect;
    RPCServer.OnException := DoOnServerError;
    RPCServer.Config.AsString := fConfig.O['Server'].AsString;

    DbThreadTaskList.Server := Self.MySQLServer;
  except
    on e: exception do begin
      Log('Error creating RPC Server: ' + e.Message, ltError);
    end;
  end;

  if ConfigChanged then
    SaveConfig;

  try
    UpdateCheckThread := TUpdateCheckThread.Create(self);
  except
    on e: exception do begin
      Log('Error creating UpdateCheckThread: ' + e.Message, ltError);
    end;
  end;
end;

destructor TUtilsServer.Destroy;
const
  OneSecond = 1/24/60/60;
begin
  if Assigned(fLogger) then
    fLogger.Events.RemoveMultiEvent(LogEventHandler);
  Log('Shutting down', ltInfo);
  if Assigned(UpdateCheckThread) then begin
    UpdateCheckThread.Terminate;
    while not UpdateCheckThread.IsTerminated do
      sleep(10);
    UpdateCheckThread.Free;
  end;
  try
    RPCServer.Active:= false;
  except
  end;

  try
    TModulePort.ClearPortList(MySQLServer);
  except
  end;

  SaveConfig;
  RPCServer.Free;
  ServerModuleList.Free;
  fConfig.Free;
  IpRangeList.Free;
  ConfigClientList.Free;
  fLock.Free;
  Log('All Done', ltInfo);
  Sleep(50);
  fLoggingLevelProp.Free;
  fNextUpdateCheckTimeProp.Free;
  ClientNotificationList.Free;
  CommonConfig.Free;
  inherited;
end;

function SplitURI(const URI: string): TStringDynArray;
var
  SplitPoints: Integer;
  i: Integer;
  s: string;
  InSingleQuote,
  inDoubleQuote: boolean;

  function IsQuoteEnd(CurrPos: integer): boolean;
  var
    x: integer;
  begin
    result:= true;
    for x := CurrPos + 1 to Length(URI) do begin
      if URI[x] = '/' then
        exit
      else if URI[x] <> ' ' then begin
        result:= false;
        exit;
      end;
    end;
  end;

begin
  Result := nil;

  if URI <> '' then
  begin
    s:= '';
    InSingleQuote:= false;
    InDoubleQuote:= false;
    SplitPoints := 0;
    SetLength(Result, SplitPoints + 1);
    for i := 1 to Length(URI) do begin
      if URI[i] = '/' then begin
        if InSingleQuote or InDoubleQuote then
          s:= s + URI[i]
        else begin
          if (s <> '') and (Result[SplitPoints] = '') then
            Result[SplitPoints]:= s;
          Inc(SplitPoints);
          SetLength(Result, SplitPoints + 1);
          s:= '';
        end;

      end
      else if URI[i] = '''' then begin
        s:= s + URI[i];
        if InSingleQuote then begin
          if IsQuoteEnd(i) then begin
            InSingleQuote:= false;
            Result[SplitPoints]:= s;
            s:= '';
          end;
        end
        else begin
          { not in single quote }
          if not InDoubleQuote then
            InSingleQuote:= true;
        end;
      end
      else if URI[i] = '"' then begin
        s:= s + URI[i];
        if InDoubleQuote then begin
          if IsQuoteEnd(i) then begin
            InDoubleQuote:= false;
            Result[SplitPoints]:= s;
            s:= '';
          end;
        end
        else begin
          { not in double quote }
          if not InSingleQuote then
            InDoubleQuote:= true;
        end;
      end
      else
        s:= s + URI[i];

    end;
    if (s <> '') and (Result[SplitPoints] = '') then
      Result[SplitPoints]:= s;



//    { Determine the length of the resulting array }
//    SplitPoints := 0;
//    for i := 1 to Length(S) do
//      if IsDelimiter(Delimiters, S, i) then
//        Inc(SplitPoints);
//
//    SetLength(Result, SplitPoints + 1);
//
//    { Split the string and fill the resulting array }
//    StartIdx := 1;
//    CurrentSplit := 0;
//    repeat
//      FoundIdx := FindDelimiter(Delimiters, S, StartIdx);
//      if FoundIdx <> 0 then
//      begin
//        Result[CurrentSplit] := Copy(S, StartIdx, FoundIdx - StartIdx);
//        Inc(CurrentSplit);
//        StartIdx := FoundIdx + 1;
//      end;
//    until CurrentSplit = SplitPoints;
//
//    // copy the remaining part in case the string does not end in a delimiter
//    Result[SplitPoints] := Copy(S, StartIdx, Length(S) - StartIdx + 1);
  end;
end;


procedure TUtilsServer.DoModuleCommandRequest(Sender: TServerModuleStub;
  aRequest: string; var aResponse: string);
begin
  aResponse := '';
  if SameText(aRequest, 'GetServerVersion') then begin
    aResponse := GetFileVersion(Application.ExeName);
    if aResponse = '' then
      aResponse := DEFAULT_SERVER_VERSION;
  end;
end;

procedure TUtilsServer.DoModuleNotification(Sender: TServerModuleStub; aClientId: integer; aNotificationName, aNotificationData: string);
var
  Client: TJsonRpcBase;
  json, event, task: TJsonObject;
  I: integer;
begin
  if SameText(aNotificationName, 'event') then begin
    event := JO;
    try
      event.AsString := aNotificationData;
      if SameText(event.S['eventname'], 'ServerTask') then begin
        task := event.O['value'];
        if task.B['Complete'] then begin
          DbThreadTaskList.Write(task.S['TaskId'], task.S['ModuleName'], task.B['Complete']);
          DbThreadTaskList.DeleteComplete;
        end
        else begin
          DbThreadTaskList.Write(
            task.S['TaskId'],
            task.S['ModuleName'],
            task.S['TaskName'],
            task.S['StatusMessage'],
            task.DT['StartTime'],
            task.B['Complete']);
        end;
        exit;
      end
      else if SameText(event.S['eventname'], 'TaskListEmpty') then begin
        DbThreadTaskList.DeleteAllForModule(event.S['value']);
        exit;
      end;
    finally
      event.Free;
    end;
//    end;

//    { send to all connected clients ... }
//    I := 0;
//    repeat
//      Client := self.Server.ClientByIndex(I);
//      if Assigned(Client) then begin
//        json:= JO;
//        json.AsString := aNotificationData;
//        Client.SendNotification(aNotificationName,json);
//      end;
//    until not Assigned(Client);
//    exit;
  end;
  { else a single client }
  Client := RPCServer.ClientByID(aClientId);
  if Assigned(Client) then begin
    //Client.SendNotification('event',JO('{"eventname":"'+Event+'","value":"' + str +'"}'));
    json := JO;
    try
      json.AsString := aNotificationData;
      Client.SendNotification(aNotificationName, json);
    finally
//      json.Free;
    end;
  end
  else begin
    { client not found (disconnected) .. remove from notification list }
    json:= JO;
    try
      json.S['method'] := 'DeregisterForNotification';
      json.O['params'].I['ClientId'] :=  aClientID;
      json.O['params'].S['NotificationType'] := ''; { remove all types for this client id }

      Sender.SendRequest(aClientID,Json);
    finally
      json.Free;
    end;
  end;
end;

procedure TUtilsServer.DoOnServerError(AContext: TIdContext;
  AException: Exception);
begin
  Log('Server error: ' + AException.Message, ltError);
end;

(*
procedure TUtilsServer.DoOnCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
//  stream: TStringStream;
  URIParts: TStringDynArray;
  RequestJson, ResultJson: TJsonObject;
  x, i: integer;
//  s: string;
//  MemStart, MemEnd: Cardinal;
begin

//  MemStart:= SystemLib.CurrentMemoryUsage;
  if ltDetail in Logger.LogMessageTypes then begin
    Log('---------------------------------------------',ltDetail);
    Logger.Log('HTTP Request >>>>>', ltDetail);
    Logger.Log('  Command: ' + ARequestInfo.Command, ltDetail);
    Logger.Log('  URI: ' + ARequestInfo.URI, ltDetail);
    Logger.Log('  Params: ' + ARequestInfo.Params.CommaText, ltDetail);
    Logger.Log('  Form Params: ' + ARequestInfo.FormParams, ltDetail);
    Logger.Log('  Query Params: ' + ARequestInfo.QueryParams, ltDetail);
    Logger.Log('  Version: ' + ARequestInfo.Version, ltDetail);
    Logger.Log('  Accept: ' + ARequestInfo.Accept, ltDetail);
    Logger.Log('  Accept Char Set: ' + ARequestInfo.AcceptCharSet, ltDetail);
    Logger.Log('  Accept Encoding: ' + ARequestInfo.AcceptEncoding, ltDetail);
    Logger.Log('  Accept Language: ' + ARequestInfo.AcceptLanguage, ltDetail);
    Logger.Log('  Host: ' + ARequestInfo.Host, ltDetail);
    Logger.Log('  Content Type: ' + ARequestInfo.ContentType, ltDetail);
//    Logger.Log('  User Name: ' + ARequestInfo.Username, ltDetail);
//    Logger.Log('  Password: ' + ARequestInfo.Password, ltDetail);
    Logger.Log('  Auth User Name: ' + ARequestInfo.AuthUsername, ltDetail);
    Logger.Log('  Auth Password: ' + ARequestInfo.AuthPassword, ltDetail);
//    Logger.Log('  Custom headers: ' + ARequestInfo.CustomHeaders.Text, ltDetail);
    Logger.Log('  Database: ' + ARequestInfo.RawHeaders.Values['database'], ltDetail);
    Logger.Log('  Raw headers:', ltDetail);
    for x:= 0 to ARequestInfo.RawHeaders.Count -1 do begin
      Logger.Log('    [Name] ' + ARequestInfo.RawHeaders.Names[x] + '  [Value] ' +
        ARequestInfo.RawHeaders.Values[ARequestInfo.RawHeaders.Names[x]], ltDetail);
    end;
  end;
//  Logger.Log('  URI: ' + ARequestInfo.URI, ltInfo);

  AResponseInfo.ResponseNo:= 204; { "No Content" }
//  AResponseInfo.ContentType:= 'application/json';
  AResponseInfo.ContentType:= 'text/plain';
  AResponseInfo.CharSet := 'UTF-8';
  try

    URIParts:= SplitURI(Lowercase(ARequestInfo.URI));

    if (High(URIParts) >= 2) then  begin
      if (URIParts[1] = ERP_API_Res) then begin
        { this is an ERP WebAPI request  }
        { We will now turn this into a request that can be passed to the WebAPI module }
        RequestJson:= TJsonObject.Create;
        ResultJson:= TJsonObject.Create;
        try
          { Add relevent data to Json request object  }
          RequestJson.S['method']:= 'webapi.webrequest';
          RequestJson.S['Host']:= ARequestInfo.Host;
          RequestJson.S['URI']:= ARequestInfo.URI;
//          s := '';
          for i := 0 to High(URIParts) do begin
            RequestJson.A['URIParts'].Add(URIParts[i]);
//            if s <> '' then s := s + ' ';
//            s:= s + '[' + URIParts[i] + ']';
          end;
          //Logger.Log('  URI Parts: ' + s,ltInfo);
//          s := '';
          for i:= 0 to ARequestInfo.Params.Count -1 do begin
            RequestJson.O['Params'].S[ARequestInfo.Params.Names[i]]:= ARequestInfo.Params.ValueFromIndex[i];
//            if s <> '' then s:= s + ' ';
//            s := s + ARequestInfo.Params.Names[i] + '=[' + ARequestInfo.Params.ValueFromIndex[i] + ']';
          end;
//          Logger.Log('  Params: ' + s,ltInfo);
          RequestJson.S['ContentType']:= AResponseInfo.ContentType;
          RequestJson.S['ERPDatabase']:= ARequestInfo.RawHeaders.Values['database'];
          RequestJson.S['ERPUserName']:= ARequestInfo.AuthUserName;
          RequestJson.S['ERPPassword']:= ARequestInfo.AuthPassword;
          RequestJson.S['ERPWebUserName']:= HTTPServerConfig.WebUserName;
          RequestJson.I['CommandType']:= Ord(ARequestInfo.CommandType); {(hcUnknown, hcHEAD, hcGET, hcPOST, hcDELETE, hcPUT, hcTRACE, hcOPTION)}
          RequestJson.S['Command']:= ARequestInfo.Command;
          if Assigned(ARequestInfo.PostStream) then begin
            try
              RequestJson.O['JsonIn'].ReadFromStream(ARequestInfo.PostStream);
            except
              on e: exception do begin
                AResponseInfo.ResponseNo:= 400; { "Bad Request" }
                AResponseInfo.CustomHeaders.Values['errormessage']:= 'Bad Request - Error reading JSON data';
                exit;
              end;
            end;
          end;

          { Pass Request to module }
          if ModuleList.DoRequest(nil,RequestJson,ResultJson) then begin
            { Populate HTTP Response with data }
            AResponseInfo.ResponseNo:= ResultJson.I['ResponseNo'];
            if ResultJson.StringExists('ContentType') and (ResultJson.S['ContentType'] <> '') then
              AResponseInfo.ContentType:= ResultJson.S['ContentType'];
            if ResultJson.StringExists('CharSet') and (ResultJson.S['CharSet'] <> '') then
              AResponseInfo.CharSet:= ResultJson.S['CharSet'];
            if ResultJson.StringExists('ErrorMessage') then
              AResponseInfo.CustomHeaders.Values['errormessage']:= ResultJson.S['ErrorMessage']
            else begin
              if ResultJson.ObjectExists('JsonOut') then
                AResponseInfo.ContentText:= ResultJson.O['JsonOut'].AsString;
            end;
          end
          else begin
            { error - no module found to process request }
            AResponseInfo.ResponseNo:= 501; { "Not Implemented" }
            AResponseInfo.CustomHeaders.Values['errormessage']:= 'No module found to process WebAPI request.';
          end;
        finally
          RequestJson.Free;
          ResultJson.Free;
        end;
      end
      else begin
        AResponseInfo.ResponseNo:= 400; { "Bad Request" }
        AResponseInfo.CustomHeaders.Values['errormessage']:= 'Bad Request - Unknown URI command';
      end;
    end
    else begin
      AResponseInfo.ResponseNo:= 400; { "Bad Request" }
      AResponseInfo.CustomHeaders.Values['errormessage']:= 'Bad Request - Invalid URI';
    end;


  finally
    if ltDetail in Logger.LogMessageTypes then begin
      Logger.Log('', ltDetail);
      Logger.Log('HTTP Response >>>>', ltDetail);
      Logger.Log('  Code: ' + AResponseInfo.ResponseText, ltDetail);
      Logger.Log('  Content Type: ' + AResponseInfo.ContentType, ltDetail);
  //    Logger.Log('Content:' + #13#10 + AResponceInfo.ContentText, ltDetail);
    end;
      if (AResponseInfo.CustomHeaders.Values['errormessage'] <> '') then begin
        if (AResponseInfo.ResponseNo = 404) and (Pos('Instance not found', AResponseInfo.CustomHeaders.Values['errormessage']) > 0) then begin
          Logger.Log('HTTP Response ' + IntToStr(AResponseInfo.ResponseNo)+
            ' message: ' + AResponseInfo.CustomHeaders.Values['errormessage'],ltDetail);

        end
        else begin
          Logger.Log('HTTP Response error ' + IntToStr(AResponseInfo.ResponseNo)+
            ' message: ' + AResponseInfo.CustomHeaders.Values['errormessage'],ltError);
        end;
      end;
      if ltDetail in Logger.LogMessageTypes then begin
         Log('---------------------------------------------',ltDetail);
    end;
  end;
//  MemEnd:= SystemLib.CurrentMemoryUsage;
//  MemLog.Log('Memory: ' + IntToStr(MemStart) + '  Change: ' + IntToStr(MemEnd - MemStart) + '  Method: ' + ARequestInfo.URI);
end;
*)

(*
procedure TUtilsServer.DoOnConnect(AContext: TIdContext);
begin
  if HTTPServerConfig.UseSSL then begin
    if AContext.Binding.Port = HTTPServerConfig.DefaultSSLPort then
      TIdSSLIOHandlerSocketBase(AContext.Connection.IOHandler).passThrough:= false;
  end;
end;
*)
procedure TUtilsServer.DoRPCRequest(Client: TJsonRpcBase; ReqJson: TJSONObject; ResJson: TJSONObject = nil);
var
  methodName: string;
  remoteIp: string;
//  ModuleInfo: TModuleInfo;
  List: TList;
//  RequestHandled: boolean;
  ClientNotificationItem: TClientNotificationItem;
  lst: TList;
  NotificationType: string;
  x, I: Integer;
  ModTaskList, TaskItem: TJsonObject;
  data: string;
begin
  Log('Start ---------------------------------------------', ltDetail);

  try
    methodName := Lowercase(ReqJson.S['method']);
  except
    on e: exception do begin
      Log('Error reading request method: ' + e.Message, ltError);
    end;
  end;
  Log('Utils Request Start: ' + methodName, ltDetail);

  if (Pos('clientserver.', methodname) > 0) or (methodname = 'getversion') then begin
    { we allow requests from outside the local network for this module only }

  end
  else begin
    if Assigned(Client) then begin
      remoteIp := TJsonRpcTcpServerClient(Client).Context.Connection.Socket.Binding.PeerIP;
      if not IpRangeList.IpInRange(remoteIP) then begin
        Log('Rejecting request from outside local network: ' + remoteIp, ltWarning);
        exit;
      end;
    end;
  end;

  if Pos('.', methodName) > 0 then begin
    Log('    Passing request to module', ltDetail);
    if ServerModuleList.DoRequest(Client, ReqJson, ResJson) then begin
      Exit;
    end
    else begin
      Log('    No module found to process request', ltDetail);
      if Assigned(ResJson) then begin
        ResJson.O['error'] := JO('{"code": ' + IntToStr(RPC_INVALID_REQUEST) + ', "message": "Invalid request"}');
      end;
      Exit;
    end;
  end
  else begin
    { not for a module ... so handle it here }
    if SameText(methodName, 'startconfigsession') then begin
      List:= ConfigClientList.LockList;
      try
        List.Add(Client);
      finally
        ConfigClientList.UnlockList;
      end;
      ResJson.S['result']:= 'ok';
    end
    else if SameText(methodName, 'getmodules') then begin
      ServerModuleList.GetAsJson(ResJson.O['result']);
    end
    else if SameText(methodName, 'getversion') then begin
      resJson.S['result']:= self.Version;
    end
    else if SameText(methodName, 'GetConfig') then begin
      Self.Lock;
      try
        ObjToJson(self, ResJson.O['result']);
      finally
        Self.Unlock;
      end;
    end
    else if SameText(methodName, 'SetConfig') then begin
      if ReqJson.ObjectExists('params') then begin

        Self.Lock;
        try
          JsonToObj(ReqJson.O['params'],self);
        finally
          Self.Unlock;
        end;
        SaveConfig;
        ResJson.S['result']:= 'ok';
      end
      else begin
        ResJson.O['error']:=
          JO('{"code": '+ IntToStr(RPC_INVALID_REQUEST) +
        ', "message": "Invalid request, params object missing from request"}');
      end;
    end
    else if SameText(methodName, 'RegisterForNotification') then begin

      if ReqJson.ObjectExists('params') and ReqJson.O['params'].StringExists('NotificationType') then
        NotificationType := ReqJson.O['params'].S['NotificationType']
      else
        NotificationType := '';

      lst := ClientNotificationList.LockList;
      try
        ClientNotificationItem := TClientNotificationItem.Create;
        ClientNotificationItem.ClientId := Integer(Client);
        ClientNotificationItem.NotificationName:= NotificationType;
        lst.Add(ClientNotificationItem);
        JsonRPCUtils.AddResultOk(ResJson);
      finally
        ClientNotificationList.UnlockList;
      end;
    end
    else if SameText(methodName, 'DeregisterForNotification') then begin
      if ReqJson.ObjectExists('params') and ReqJson.O['params'].StringExists('NotificationType') then
        NotificationType := ReqJson.O['params'].S['NotificationType']
      else
        NotificationType := '';
      Log('Removing notification list item, ClientId: ' + IntToStr(Integer(Client)) + ', Type: ' + NotificationType, ltDetail);
      lst := ClientNotificationList.LockList;
      try
        x:= 0;
        while x < lst.Count do begin
          ClientNotificationItem := TClientNotificationItem(lst[x]);
          if (ClientNotificationItem.ClientId = Integer(Client)) and
            ((NotificationType = '') or
             (SameText(NotificationType,ClientNotificationItem.NotificationName))) then begin
            ClientNotificationItem.Free;
            lst.Delete(x);
          end
          else
            Inc(x);
        end;
        JsonRPCUtils.AddResultOk(ResJson);
      finally
        ClientNotificationList.UnlockList;
      end;
    end
    else if SameText(methodName, 'GetTaskList') then begin
      lst := ServerModuleList.List.LockList;
      try
        ModTaskList := JO;
        try
          for x := 0 to Lst.Count -1 do begin
            try
              if TServerModuleStub(Lst[x]).SendCommandRequest('GetTaskList', data) then begin
                ModTaskList.AsString := data;
                for I := 0 to ModTaskList.A['TaskList'].Count -1 do begin
                  TaskItem := JO;
                  TaskItem.Assign(ModTaskList.A['TaskList'][I].AsObject);
                  TaskItem.S['ModuleName'] := ModTaskList.S['ModuleName'];
                  ResJson.O['result'].A['TaskList'].Add(TaskItem);
                end;
              end;
            except

            end;
          end;
        finally
          ModTaskList.Free;
        end;
      finally
        ServerModuleList.List.UnlockList;
      end;
    end;
  end;
  if Assigned(ResJson) then begin
    Log('    Sending Response:', ltDetail);
//    Log(ResJson.AsString, ltDetail);
  end;
  Log('Request processing complete', ltDetail);
  Log('End ---------------------------------------------', ltDetail);
//  MemEnd:= SystemLib.CurrentMemoryUsage;
//  MemLog.Log('Memory: ' + IntToStr(MemStart) + '  Change: ' + IntToStr(MemEnd - MemStart) + '  Method: ' + methodName);
end;

procedure TUtilsServer.DoServerOnConnect(Server: TJsonRpcTcpServer; Client: TJsonRpcTcpServerClient);
begin
  Log('Client connected: ' + client.Context.Connection.Socket.Binding.PeerIP + '  ' + IntToStr(Integer(Client)), ltDetail);
  Client.OnRequest := DoRPCRequest;
end;

procedure TUtilsServer.DoServerOnDisconnect(Server: TJsonRpcTcpServer; Client: TJsonRpcTcpServerClient);
var
  List: TList;
  idx: integer;
begin
  Log('Client disconnected: ' + client.Context.Connection.Socket.Binding.PeerIP + '  ' + IntToStr(Integer(Client)), ltDetail);

//  ModuleList.DoDisconnect(Client);
  ServerModuleList.DoDisconnect(Client);

  List:= ConfigClientList.LockList;
  try
    idx:= List.IndexOf(Client);
    if idx >= 0 then
      LIst.Delete(idx);
  finally
    ConfigClientList.UnlockList;
  end;
end;

//procedure TUtilsServer.DoServerThreadException(AContext: TIdContext;
//  AException: Exception);
//begin
//  Logger.Log('Thread Exception - ' + AException.ClassName + ' with message: ' + AException.Message, ltError);
//end;

function TUtilsServer.GetActive: boolean;
begin
  Result:= RPCServer.Active;
end;

function TUtilsServer.GetLoggingLevel: TLoggingLevel;
begin
  Result := StrToLoggingLevel(fLoggingLevelProp.AsString);
end;

function TUtilsServer.GetNextUpdateCheckTime: TDateTime;
begin
  Result := fNextUpdateCheckTimeProp.AsDateTime;
end;

//function TUtilsServer.GetNextUpdateCheckTime: TDateTime;
//begin
//  result := fConfig.DT['NextUpdateCheckTime'];
//end;

function TUtilsServer.GetSoftwareReleaseType: string;
var
//  ModuleInfo: TModuleInfo;
//  s: string;
//  ReqJson, ResJson: TJSONObject;
  UtilsConfigFile: string;
  j,cfg: TJsonObject;
  ClientConfig: TClientConfig;
  ConfigDb: TConfigDb;
begin
  result := '';
  if CommonConfig.StringExists('SoftwareReleaseType') and (CommonConfig.S['SoftwareReleaseType'] <> '') then begin
    Log('Geting Software Release Type from Common Config.', ltDetail);
    result := CommonConfig.S['SoftwareReleaseType'];
    exit;
  end;

  Log('Geting Software Release Type from Licence.', ltDetail);
  try
    ConfigDb := TConfigDb.Create('ClientConfig',MySQLServer);
    try
      cfg := JO;
      ClientConfig := TClientConfig.Create;
      try
        cfg.AsString := DecryptString(ConfigDb.Value);
//        Log('Server: ' + MySQLServer, ltDetail);
//        Log(cfg.Asstring, ltDetail);
        JsonToObj(cfg.O['ClientConfig'], ClientConfig);
        result := ClientConfig.SoftwareReleaseType;
        Log('Software Release Type: ' + result,ltDetail);
      finally
        cfg.Free;
        ClientConfig.Free;
      end;
    finally
      ConfigDb.Free;
    end;
  except
    on e: exception do begin
      Log('Error Geting Software Release Type from Licence: ' + e.Message, ltError);
    end;
  end;

//  result:= '';
//
//  UtilsConfigFile := ExtractFilePath(Application.ExeName) + 'Modules\ERPModUserUtils_Config.cfg';
//  if not FileExists(UtilsConfigFile) then
//    { try old module file name }
//    UtilsConfigFile := ExtractFilePath(Application.ExeName) + 'Modules\UserUtils_Config.cfg';
//
//  if FileExists(UtilsConfigFile) then begin
//    j:= JO;
//    cfg:= JO;
//    try
//      LoadFromEncrypedFile(j,UtilsConfigFile);
//      ClientConfig := TClientConfig.Create;
//      try
//        cfg.AsString := J.S['configtext'];
//        JsonToObj(cfg.O['clientconfig'],ClientConfig);
//        result := ClientConfig.SoftwareReleaseType;
//
//      finally
//        ClientConfig.Free;
//      end;
//    finally
//      j.Free;
//      cfg.Free;
//    end;
//  end;
end;

function TUtilsServer.GetVersion: string;
begin
  result := GetFileVersion(Application.ExeName);
  if Result = '' then
    Result := '11.0.0.0';
end;

procedure TUtilsServer.LoadConfig;
var
  configChanged: boolean;
begin
  configChanged := False;
  try
    fConfig.LoadFromFile(fConfigFileName);

    if not fConfig.O['UtilsServer'].Exists('NextUpdateCheckTime') then begin
      Randomize;
      { check between midnight and 00:45
        Utils module will check for database updates between 1 and 2 am }

      fConfig.O['UtilsServer'].ItemByName['NextUpdateCheckTime'].Value.AsDateTime :=
        (Trunc(now) + 1) + (Random(45) * (1/24/60));
      ConfigChanged:= true;
    end;

    JsonToObj(fConfig.O['UtilsServer'], Self);

    if fConfig.ObjectExists('acceptiprangelist') then begin
      try
        IpRangeList.LoadFromJson(fConfig.O['acceptiprangelist']);
      except
        Log('Error reading IP Range from config info.', ltError);
      end;
    end
    else begin
      IpRangeList.AddRange('127.0.0.1','127.0.0.1');
      IpRangeList.AddRange('10.0.0.0','10.255.255.255');
      IpRangeList.AddRange('172.16.0.0','172.31.255.255');
      IpRangeList.AddRange('192.168.0.0','192.168.255.255');
      IpRangeList.SaveToJson(fConfig.O['acceptiprangelist']);
      ConfigChanged := True;
    end;

    if ConfigChanged then
      SaveConfig;
  except
    on e: exception do begin
      Log('Error loading configfile: ' + fConfigFileName, ltError);
    end;
  end;

end;

procedure TUtilsServer.Lock;
begin
  fLOck.Acquire;
end;

procedure TUtilsServer.Log(msg: string; const LogMessageType: TLogMessageType = ltInfo);
begin
  if Assigned(fLogger) then
    fLogger.Log(msg, LogMessageType);
end;

procedure TUtilsServer.LogEventHandler(Sender: TObject; const Event, Value: string);
var
  List: TList;
  x: integer;
  ClientNotificationItem: TClientNotificationItem;
  Client: TJsonRpcBase;
  j: TJsonObject;
begin
//  List:= ConfigClientList.LockList;
//  try
//    for x:= 0 to List.Count -1 do begin
//      Client:= TJsonRpcBase(List[x]);
//      Client.SendNotification('event',JO('{"eventname":"'+Event+'","value":"' + Value +'"}'));
//    end;
//  finally
//    ConfigClientList.UnlockList;
//  end;
  List := ClientNotificationList.LockList;
  try
    x := 0;
    while x < List.Count do begin
      ClientNotificationItem := List[x];

      Client := RPCServer.ClientByID(ClientNotificationItem.ClientId);
      if Assigned(Client) then begin
        j := JO;
        j.S['eventname'] := Event;
        j.S['value'] := Value;
        Client.SendNotification('event', j);
        Inc(x);
      end
      else begin
        { client not found (disconnected) .. remove from notification list }
        ClientNotificationItem.Free;
        List.Delete(x);
      end;
    end;
  finally
    ClientNotificationList.UnlockList;
  end;
end;

procedure TUtilsServer.SaveConfig;
begin
//  HTTPServerConfig.Lock;
//  try
//    ObjToJson(HTTPServerConfig,fConfig.O['HTTPServer']);
//  finally
//    HTTPServerConfig.Unlock;
//  end;

  ObjToJson(self, fConfig.O['UtilsServer']);
  fConfig.O['server'].AsString:= RPCServer.Config.AsString;
  fConfig.SaveToFile(fConfigFileName);
end;

procedure TUtilsServer.SetActive(const Value: Boolean);
begin
  if Value then begin
    { we are getting a MySQL error on some machines .. so wait 10 secs to give MySQL a bit of time to start }
    Sleep(10000);

    ServerModuleList.LoadModules(ExtractFilePath(Application.ExeName) + 'Modules\');

    RPCServer.Active := True;
  end
  else begin
    RPCServer.Active := False;
    ServerModuleList.Clear;
  end;

  fActive := Value;
end;

procedure TUtilsServer.SetLogger(const Value: TLogger);
begin
  if Assigned(fLogger) then
    fLogger.Events.RemoveMultiEvent(LogEventHandler);
  fLogger := Value;
  fLogger.Events.AddMultiEvent(LogEventHandler);
end;

procedure TUtilsServer.SetLoggingLevel(const Value: TLoggingLevel);
begin
  fLoggingLevelProp.AsString := LoggingLevelToStr(Value);
  if Assigned(Logger) then
    Logger.SetLoggingLevel(Value);
end;

procedure TUtilsServer.SetNextUpdateCheckTime(const Value: TDateTime);
begin
  fNextUpdateCheckTimeProp.AsDateTime := Value;
end;

procedure TUtilsServer.Unlock;
begin
  fLock.Release;
end;

{ TUpdateCheckThread }

constructor TUpdateCheckThread.Create(aUtilsServer: TUtilsServer);
var
  json: TJSONObject;
begin
  UtilsServer := aUtilsServer;
  Logger := UtilsServer.Logger;
  fIsTerminated := False;
  fStartDateTime := Now;
  fRestartUpdateCheckDone := False;
//  {$ifdef DebugMode}
//  fNextUpdateTime:= now + (1/24/60/60 * 20); { in 20 seconds }
//  {$else}
//  fNextUpdateTime:= now + (1/24/60 * 1);   { in one minute }
//  {$endif}
//  fUpdateCheckCount:= 0;
  inherited Create(False);
  Priority := tpLower;
  FreeOnTerminate := False;
  fNextMemCheck := Now + (1/24/60) * 3;
  if UtilsServer.CommonConfig.BooleanExists('DoBatchUpdate') and (not UtilsServer.CommonConfig.B['DoBatchUpdate']) then begin
    { skip batch update }
  end
  else begin
    { do batch update }
    try
      json := JO;
      try
        json.LoadFromFile(ExtractFilePath(GetModuleNameStr) + UpdateControllFileName);
        fDoBatchUpdate := False;
        if json.BooleanExists('DoBatchUpdate') then
          fDoBatchUpdate := json.B['DoBatchUpdate'];
      finally
        json.Free;
      end;
    except
      on e: exception do begin
        Log('TUpdateCheckThread - Error reading Update Controll File: ' + e.Message, ltError);
      end;
    end;
  end;
end;

destructor TUpdateCheckThread.Destroy;
begin
  inherited;
end;

procedure TUpdateCheckThread.Execute;
begin
  inherited;
  while not Terminated do begin
    try
//      {$ifdef CheckForUpdated}
      CheckForUpdates;
//      {$endif}
      Sleep(10000);
    except
      on e: Exception do begin
        Log('UtilsServer - UpdateCheckThread execute exception: ' + e.Message, ltError);
      end;
    end;
  end;
  fIsTerminated := True;
end;

procedure TUpdateCheckThread.Log(msg: string; const LogMessageType: TLogMessageType);
begin
  if Assigned(Logger) then
    Logger.Log(msg, LogMessageType);
end;

procedure TUpdateCheckThread.CheckForUpdates;
var
  config, Item: TJsonObject;
  modulefileName, updateItemName: string;
  msg: string;
  x: integer;
  sl: TStringList;
  MemStat: TMemoryStatus;
  ForceRestart: boolean;
  DoCheck: boolean;
  RequestJson, ResultJson: TJsonObject;
  Lst: TList;
  s: string;

const
  OneMin = 1/24/60;

begin
  ForceRestart := False;
  DoCheck := (not fRestartUpdateCheckDone) and (Now >= (fStartDateTime + (1/24/60/60 * 20)));  { 20 Secs after restart }
  if not DoCheck then begin
    UtilsServer.Lock;
    try
      if Now >= UtilsServer.NextUpdateCheckTime then begin
        DoCheck := True;
        ForceRestart := True;
        UtilsServer.NextUpdateCheckTime := Trunc(Now) + 1 + Frac(UtilsServer.NextUpdateCheckTime);
        UtilsServer.SaveConfig;
        Log('Next check time will be: ' +
          FormatDateTime('dd/mm/yyyy hh:nn:ss', UtilsServer.NextUpdateCheckTime) + '.', ltInfo);
      end;
    finally
      UtilsServer.Unlock;
    end;
  end;

  if DoCheck then begin
    fRestartUpdateCheckDone := True;

    Log('Starting process to check for updates.', ltInfo);
    s := SoftwareReleaseType;
    if s = '' then begin
      Log('Unable to retreive Software Release Type, aborting update check.', ltError);
      Exit;
    end;

    config := TJsonObject.Create;
    config.B['displayprogress'] := False;
    config.S['softwarereleasetype'] := s;

    Log('Building update info ... ', ltInfo);

    { now add components to be updated }
    { main exe / service }
    modulefileName := GetModuleNameStr;
    updateItemName := ChangeFileExt(ExtractFileName(modulefileName),'');
    Item := config.O['updatelist'].O[updateItemName];
    Item.S['modulefilename']:= modulefileName;
    Item.S['ServiceName']:= 'ERPUtils';

    Log('  Added Utils Service', ltInfo);

    if ForceRestart then begin
      Item.B['ForceRestart'] := True;
      config.B['DoBatchUpdate'] := True;
    end
    else begin
      config.B['DoBatchUpdate'] := False;
    end;

    { add the utils config gui (services menu) }
    Item := config.O['updatelist'].O['ERPWebService'];
    Item.S['modulefilename'] := ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR + 'ERPWebService.exe';
    Item.S['ServiceName'] := 'ERPWeb';
    Item.B['installifnotfound'] := True;

    Log('  Added Web Service', ltInfo);

    Log('  Getting module list', ltInfo);

    { module dll's }
//    UtilsServer.ModuleList.LockList;
//    try
//      for x:= 0 to UtilsServer.ModuleList.Count -1 do begin
//        modulefileName:= UtilsServer.ModuleList.ModuleInfoItem[x].Module.ModuleFileName;
//        updateItemName:= ChangeFileExt(ExtractFileName(modulefileName),'');
//        Item:= config.O['updatelist'].O[updateItemName];
//        Item.S['modulefilename']:= modulefileName;
//      end;
//    finally
//      UtilsServer.ModuleList.UnlockList;
//    end;

    lst := UtilsServer.ServerModuleList.List.LockList;
    try
      for x := 0 to Lst.Count - 1 do begin
        modulefileName := TServerModuleStub(Lst[x]).ModuleFileName;
        if modulefileName = 'ERPWebService' then Continue;        
        updateItemName := ChangeFileExt(ExtractFileName(modulefileName), '');
        Item := config.O['updatelist'].O[updateItemName];
        Item.S['modulefilename']:= ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR + 'modules\' + modulefileName + '.exe';
      end;
    finally
      UtilsServer.ServerModuleList.List.UnlockList;
    end;

    Log('  Added modules', ltInfo);

    { add the utils config gui (services menu) }
    Item := config.O['updatelist'].O['ERPServiceMenu'];
    Item.S['modulefilename'] := ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR + 'ERPServiceMenu.exe';
    Item.B['installifnotfound'] := True;

    Log('  Added Service Menu', ltInfo);

    { add the file uploader }
    { in case it is old version }
    if FileExists(ERP_SERVER_ROOT_DIR + ERP_FILE_UPLOADER_DIR + 'ClientUploads.exe') and
      (not FileExists(ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR + 'ClientUploads.exe')) then begin
      Item := config.O['updatelist'].O['FileUploaderOld'];
      Item.S['modulefilename']:= ERP_SERVER_ROOT_DIR + ERP_FILE_UPLOADER_DIR + 'ClientUploads.exe';
    end;
    { now should be in utils dir }
    if FileExists(ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR + 'ClientUploads.exe') then begin
      Item := config.O['updatelist'].O['FileUploader'];
      Item.S['modulefilename'] := ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR + 'ClientUploads.exe';
    end;

    Log('  Added File Uploader', ltInfo);

    { now MySQL server ... }
    if UtilsServer.MySQLServer = '127.0.0.1' then begin
      sl := TStringList.Create;
      try
  //      sl.CommaText:= AppRunUtils.GetServiceExecutablePath('','MySQL_ERP');
        sl.CommaText := AppRunUtils.GetServiceExecutablePath('', MySQL_ERP_SERVICE);
        if sl.Count > 0 then begin
          Item:= config.O['updatelist'].O['MySQLServer'];
          Item.S['version'] := GetMySQLServerVersion(UtilsServer.MySQLServer); // '127.0.0.1');
          Item.S['modulefilename'] := sl[0];
        end
        else
          Log('UtilsServer - UpdateCheckThread, unable to read executable path information for MySQL Server, excluding from update.', ltError);
      finally
        sl.Free;
      end;

      Log('  Added MySQL', ltInfo);
    end;

    Log('Calling ERP Updater ...', ltInfo);
    if not ((SameText(ExtractFileName(Application.ExeName), 'ErpUtilsServer.exe')) or
       SameText(ExtractFileName(Application.ExeName), 'ErpUtilsServerConsole.exe')) then begin
      if not StartUpdateCheck(msg, config) then begin
        Log('Software Update error: ' + msg, ltError);
      end;
    end
    else
      config.SaveToFile(ExtractFilePath(GetModuleNameStr) + UpdateControllFileName);
    Log('Update check finished.', ltInfo);
  end;

  if Now > fNextMemCheck then begin
//    Log('Trimming memory ********.',ltError);
    MemStat.dwLength := SizeOf(TMemoryStatus);
    GlobalMemoryStatus(MemStat);
    if (CurrentMemoryUsage / MemStat.dwTotalPhys) > 0.2 then begin
      Log('Memory usage has reached: ' + FormatFloat('#,##0', CurrentMemoryUsage) + ' trimming memory ..', ltInfo);
      TrimWorkingSet;
//      UtilsServer.Lock;
//      try
//        if Assigned(UtilsServer.ModuleList.ItemByName['ClientServer']) then begin
//
//          UtilsServer.ModuleList.UnloadModule('ClientServer');
//          Sleep(2000);
//          UtilsServer.ModuleList.LoadModule(ExtractFilePath(Application.ExeName) + 'Modules\ClientServer.dll');
//
//        end;
//      finally
//        UtilsServer.Unlock;
//      end;

      Sleep(1000);
//      GlobalMemoryStatus(MemStat);
      Log('  Memory size is now: ' + FormatFloat('#,##0', CurrentMemoryUsage), ltInfo);
    end;


    fNextMemCheck := Now + (1/24/60) * 5;
  end;

  { wait a bit to ensure modules are loaded before calling batch update }
  if fDoBatchUpdate and (Now >= (fStartDateTime + (1/24/60/60 * 40))) then begin
    fDoBatchUpdate := False;
    Log('Sending BatchUpdate command to UserUtils Module.', ltInfo);
    RequestJson := JO;
    ResultJson := JO;
    try
      RequestJson.S['method'] := 'UserUtils.BatchUpdate';
      UtilsServer.DoRPCRequest(nil, RequestJson, ResultJson);
      //UtilsServer.ModuleList.DoRequest(nil,RequestJson,ResultJson);
    finally
      RequestJson.Free;
      ResultJson.Free;
    end;
  end;
end;

function TUpdateCheckThread.SoftwareReleaseType: string;
begin
  Result := UtilsServer.SoftwareReleaseType;
end;

{ TUtilsServerConfigSvr }

procedure TUtilsServerConfigSvr.SetLogger(const Value: TLogger);
begin
  FLogger := Value;
  if Assigned(fLogger) then begin
    case LoggingLevel of
      llError:   Logger.LogMessageTypes:= [ltError];
      llWarning: Logger.LogMessageTypes:= [ltError, ltWarning];
      llInfo:    Logger.LogMessageTypes:= [ltError, ltWarning, ltInfo];
      llDetail:  Logger.LogAllTypes;
    end;
  end;
end;

procedure TUtilsServerConfigSvr.SetLoggingLevel(const Value: TLoggingLevel);
begin
  inherited;
  if Assigned(fLogger) then begin
    case Value of
      llError:   Logger.LogMessageTypes:= [ltError];
      llWarning: Logger.LogMessageTypes:= [ltError, ltWarning];
      llInfo:    Logger.LogMessageTypes:= [ltError, ltWarning, ltInfo];
      llDetail:  Logger.LogAllTypes;
    end;
  end;
end;

end.
