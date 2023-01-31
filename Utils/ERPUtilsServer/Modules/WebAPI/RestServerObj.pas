unit RestServerObj;

interface

uses
  IdHttpServer, IdCustomHttpServer, IdContext, JsonObject,
  IdSSLOpenSSL, LogThreadLib, sysutils, Classes,
  IdSchedulerOfThreadDefault, IdYarn, IdThread, IdSchedulerOfThread,
  RestServerConfigObj;

type

  { NOTE:
      The following 2 classes are used to prevent hang on destroy ...
      the thread WaitFor was never returning!  }

  TERPSchedulerOfThreadDefault = class(TIdSchedulerOfThreadDefault)
  public
    procedure ReleaseYarn(AYarn: TIdYarn); override;
  end;

  TERPHTTPServer = class(TIdHttpServer)
  private
    procedure StopListening;
  protected
    procedure Shutdown; override;
  public
    constructor Create(AOwner: TComponent);
  end;

  TRestServer = class(TObject)
  private
    Server: TERPHTTPServer;
    fServerConfig: TRestServerConfig;
    Logger: TLogger;
    fActive: boolean;
    fDefaultPort: integer;
    fDefaultSSLPort: integer;
    fUseSSL: boolean;
    fMaxConnections: integer;
    fCreating: boolean;
    procedure DoOnCommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponceInfo: TIdHTTPResponseInfo);
    procedure DoOnConnect(AContext: TIdContext);
    procedure DoServerThreadException(AContext:TIdContext; AException: Exception);
    procedure AddPortToBindings(aPort: word);
    procedure RemovePortFromBindings(aPort: word);
    function GetActive: boolean;
    procedure SetActive(const Value: boolean);
    procedure SetServerConfig(const Value: TRestServerConfig);
  public
    constructor Create(aConfig: TRestServerConfig; aLogger: TLogger);
    destructor Destroy; override;
    property ServerConfig: TRestServerConfig read fServerConfig write SetServerConfig;
    property Active: boolean read GetActive write SetActive;

  end;

(*

   NOTE:
     For SSL need TIdServerIOHandlerSSLOpenSSL component (don't need
     dll's). ... yes it does!

    http://forums2.atozed.com/viewtopic.php?f=7&t=15416

*)



implementation

uses
  ErpRestApiObj, windows, IdSSL, LogMessageTypes, IdCustomTCPServer; //IdSchedulerOfThread;

function GetModuleNameStr: String;
var
  szFileName: array[0..MAX_PATH] of Char;
begin
  GetModuleFileName(hInstance, szFileName, MAX_PATH);
  Result := szFileName;
end;


{ TRestServer }

procedure TRestServer.AddPortToBindings(aPort: word);
var
  x: integer;
begin
  for x:= 0 to Server.Bindings.Count -1 do begin
    if Server.Bindings.Items[x].Port = aPort then
      exit;
  end;
  Server.Bindings.Add.Port:= aPort;
end;

constructor TRestServer.Create(aConfig: TRestServerConfig; aLogger: TLogger);
var
  SSLIOHandler: TIdServerIOHandlerSSLOpenSSL;
  path: string;
  cfg: TRestServerConfigValues;
begin
  fCreating:= true;
  try
    try
      Logger:= aLogger;
      Server:= TERPHttpServer.Create(nil);
      Server.Active:= false;
      Server.DefaultPort:= 0;
      Server.Bindings.Clear;
      Server.OnCommandGet:= DoOnCommandGet;
      Server.OnConnect:= DoOnConnect;
      Server.OnException:= DoServerThreadException;
      ServerConfig:= aConfig;
      if fUseSSL then begin
        SSLIOHandler:= TIdServerIOHandlerSSLOpenSSL.Create(Server);
        Server.IOHandler:= SSLIOHandler;
        path:= ExtractFilePath(GetModuleNameStr);
        SSLIOHandler.SSLOptions.CertFile:= path + 'localhost.cer';
        SSLIOHandler.SSLOptions.KeyFile:= path + 'localhost.key';
        SSLIOHandler.SSLOptions.RootCertFile:= path + 'localhost.cer';
      end;
      try
        cfg:= ServerConfig.Lock;
        try
          Server.Active:= cfg.Active;
        finally
          ServerConfig.Unlock;
        end;
      except
        on e: exception do begin
          Logger.Log('Error setting server active with message: ' + e.Message, ltError);
        end;
      end;
    except
        on e: exception do begin
          Logger.Log('Error creating RestServer with message: ' + e.Message, ltError);
        end;
    end;
  finally
    fCreating:= false;
  end;
end;

destructor TRestServer.Destroy;
begin
  Server.Free;
  inherited;
end;

procedure TRestServer.DoOnCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponceInfo: TIdHTTPResponseInfo);
var
  stream: TStringStream;
  api: TErpRestApi;
begin
  if ltDetail in Logger.LogMessageTypes then begin
    Logger.Log('----------------------------------------------------------------------------------------------');
    Logger.Log('Request >>>>', ltDetail);
    Logger.Log('Command: ' + ARequestInfo.Command, ltDetail);
    Logger.Log('URI: ' + ARequestInfo.URI, ltDetail);
    Logger.Log('Params: ' + ARequestInfo.Params.CommaText, ltDetail);
    Logger.Log('Form Params: ' + ARequestInfo.FormParams, ltDetail);
    Logger.Log('Query Params: ' + ARequestInfo.QueryParams, ltDetail);
    Logger.Log('Version: ' + ARequestInfo.Version, ltDetail);
    Logger.Log('Accept: ' + ARequestInfo.Accept, ltDetail);
    Logger.Log('Accept Char Set: ' + ARequestInfo.AcceptCharSet, ltDetail);
    Logger.Log('Accept Encoding: ' + ARequestInfo.AcceptEncoding, ltDetail);
    Logger.Log('Accept Language: ' + ARequestInfo.AcceptLanguage, ltDetail);
    Logger.Log('Host: ' + ARequestInfo.Host, ltDetail);
    Logger.Log('Content Type: ' + ARequestInfo.ContentType, ltDetail);
    Logger.Log('User Name: ' + ARequestInfo.Username, ltDetail);
    Logger.Log('Password: ' + ARequestInfo.Password, ltDetail);
    Logger.Log('Auth User Name: ' + ARequestInfo.AuthUsername, ltDetail);
    Logger.Log('Auth Password: ' + ARequestInfo.AuthPassword, ltDetail);
//    Logger.Log('Custom headers: ' + ARequestInfo.CustomHeaders.Text, ltDetail);
//    Logger.Log('Raw headers: ' + ARequestInfo.RawHeaders.Text, ltDetail);
    Logger.Log('Database: ' + ARequestInfo.RawHeaders.Values['database'], ltDetail);
//    if Assigned(ARequestInfo.PostStream) then begin
//      stream:= TStringStream.Create;
//      try
//        stream.LoadFromStream(ARequestInfo.PostStream);
//        ARequestInfo.PostStream.Position:= 0;
//        Logger.Log('Request Data:', ltDetail);
//        Logger.Log(stream.DataString, ltDetail);
//      finally
//        stream.Free;
//      end;
//    end;
  end;

  AResponceInfo.ResponseNo:= 200;

  api:= TErpRestApi.Create(Logger);
  try
    api.Config.Assign(ServerConfig.Lock);
    ServerConfig.Unlock;
    api.DoHTTPRequest(AContext, ArequestInfo, AResponceInfo);
  finally
    api.Free;
  end;

  if ltDetail in Logger.LogMessageTypes then begin
    Logger.Log('', ltDetail);
    Logger.Log('Responce >>>>', ltDetail);
    Logger.Log('Code: ' + AResponceInfo.ResponseText, ltDetail);
    Logger.Log('Content Type: ' + AResponceInfo.ContentType, ltDetail);
//    Logger.Log('Content:' + #13#10 + AResponceInfo.ContentText, ltDetail);
  end;
    if AResponceInfo.CustomHeaders.Values['errormessage'] <> '' then
      Logger.Log('Responce error message: ' + AResponceInfo.CustomHeaders.Values['errormessage'],ltError);
  if ltDetail in Logger.LogMessageTypes then begin
    Logger.Log('----------------------------------------------------------------------------------------------',ltDetail);
  end;
end;

procedure TRestServer.DoOnConnect(AContext: TIdContext);
begin
  if fUseSSL then begin
    if AContext.Binding.Port = fDefaultSSLPort then
      TIdSSLIOHandlerSocketBase(AContext.Connection.IOHandler).passThrough:= false;
  end;
end;

procedure TRestServer.DoServerThreadException(AContext: TIdContext;
  AException: Exception);
begin
  TLogger.Inst.Log('Thread Exception - ' + AException.ClassName + ' with message: ' + AException.Message, ltError);
end;

function TRestServer.GetActive: boolean;
begin
//  result:= Server.Active;
  result:= fActive;
end;

procedure TRestServer.RemovePortFromBindings(aPort: word);
var
  x: integer;
begin
  for x:= 0 to Server.Bindings.Count -1 do begin
    if Server.Bindings.Items[x].Port = aPort then begin
      Server.Bindings.Delete(x);
      break;
    end;
  end;
end;

procedure TRestServer.SetActive(const Value: boolean);
begin
  if fActive = Value then exit;
//  Logger.Log('Setting server active to: ' + BoolToStr(Value,true));
  fActive:= Value;
  try
    if Assigned(Server) then begin
      Server.Active:= Value;
      fActive:= Server.Active;
    end;
  except
    on e: exception do begin
      Logger.Log('Error occured while changing server active status with message: ' + e.Message, ltError);
    end;
  end;
end;

procedure TRestServer.SetServerConfig(const Value: TRestServerConfig);
var
  cfg: TRestServerConfigValues;
  SaveServerActive: boolean;
begin
  fServerConfig := Value;
  cfg:= fServerConfig.Lock;
  try
    SaveServerActive:= Active;
    try
      if (fDefaultPort <> cfg.DefaultPort) or (fDefaultSSLPort <> cfg.DefaultSSLPort) then begin
        Active:= false;
        if (fDefaultPort <> cfg.DefaultPort) then begin
          RemovePortFromBindings(fDefaultPort);
          AddPortToBindings(cfg.DefaultPort);
          fDefaultPort:= cfg.DefaultPort;
        end;
        if (fDefaultSSLPort <> cfg.DefaultSSLPort) then begin
          RemovePortFromBindings(fDefaultSSLPort);
          AddPortToBindings(cfg.DefaultSSLPort);
          fDefaultSSLPort:= cfg.DefaultSSLPort;
        end;
      end;
      fMaxConnections:= cfg.MaxConnections;
      Server.MaxConnections:= fMaxConnections;
      if fUseSSL <> cfg.UseSSL then begin
        Active:= false;
        fUseSSL:= cfg.UseSSL;
      end;
      SaveServerActive:= cfg.Active;
    finally
      Active:= SaveServerActive and (not fCreating);
    end;
  finally
    fServerConfig.Unlock;
  end;
end;

{ TERPHTTPServer }

constructor TERPHTTPServer.Create(AOwner: TComponent);
begin
  inherited;
  Scheduler:= TERPSchedulerOfThreadDefault.Create(self);
end;

procedure TERPHTTPServer.Shutdown;
begin
  // Must set to False here. SetScheduler checks this
  FActive := False;

  // tear down listening threads
  StopListening;

  // Tear down ThreadMgr
  try
    TerminateAllThreads;
  finally
    {//bgo TODO: fix this: and TIdThreadSafeList(Threads).IsCountLessThan(1)}

    if ImplicitScheduler then begin
      Scheduler := nil;
    end;
  end;

  if IOHandler <> nil then begin
    IOHandler.Shutdown;
  end;
end;

procedure TERPHTTPServer.StopListening;
var
  LListenerThreads: TList;
begin
  LListenerThreads := FListenerThreads.LockList;
  try
    while LListenerThreads.Count > 0 do begin
      with TIdListenerThread(LListenerThreads[0]) do begin
        // Stop listening
        FreeOnTerminate:= true;
        Terminate;
//        Binding.CloseSocket;
//        // Tear down Listener thread
//        WaitFor;
//        Free;
      end;
      LListenerThreads.Delete(0); // RLebeau 2/17/2006
    end;
  finally
    FListenerThreads.UnlockList;
  end;
end;

{ TERPSchedulerOfThreadDefault }

type
  TIdYarnOfThreadAccess = class(TIdYarnOfThread)
  end;

function IsCurrentThread(AThread: TThread): Boolean;
begin
  Result := AThread.ThreadID = GetCurrentThreadID;
end;


procedure TERPSchedulerOfThreadDefault.ReleaseYarn(AYarn: TIdYarn);
//only gets called from YarnOf(Fiber/Thread).Destroy
var
  LThread: TIdThreadWithTask;
begin
  //take posession of the thread
  LThread := TIdYarnOfThread(AYarn).Thread;
  TIdYarnOfThreadAccess(AYarn).FThread := nil;
  //Currently LThread can =nil. Is that a valid condition?
  //Assert(LThread<>nil);

  // inherited removes from ActiveYarns list
  inherited ReleaseYarn(AYarn);

  if LThread <> nil then begin
    // need to destroy the thread
    LThread.Yarn := nil; // Yarn is being destroyed, de-couple it from the thread
    LThread.Terminate;
    // RLebeau - ReleaseYarn() can be called in the context of
    // the yarn's thread (when TIdThread.Cleanup() destroys the
    // yarn between connnections), so have to check which context
    // we're in here so as not to deadlock the thread!
    if IsCurrentThread(LThread) then begin
      LThread.FreeOnTerminate := True;
    end else begin

      if LThread.Task = nil then begin
        LThread.FreeOnTerminate := True;
      end
      else begin
        LThread.Suspended := False;
        LThread.WaitFor;
        LThread.Free;
      end;
    end;
  end;
end;

end.
