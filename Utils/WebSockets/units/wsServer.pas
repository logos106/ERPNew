unit wsServer;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sgcWebSocket_Classes, sgcWebSocket_Server, sgcWebSocket, Buttons,
  StdCtrls, idssl, IdContext, IdHttp, IdCustomHTTPServer, wsUtils, wsConsts, wsTunnel,
  contnrs, ExtCtrls, wsStates, sgcWebSocket_Types, wsLocals;

type
  TwsServer = class(TComponent)
  private
    FServer: TsgcWebSocketHTTPServer;
    FOnBinary: TsgcWSBinaryEvent;
    FOnConnect: TsgcWSConnectEvent;
    FOnMessage: TsgcWSMessageEvent;
    FOnConnectionData: TsgcWSConnectionDataEvent;
    FOnDisconnect: TsgcWSDisconnectEvent;
    FOnException: TsgcExceptionEvent;
    FOnError: TsgcWSErrorEvent;
    fOnLog: TMessageProc;
    fWaiters: TWaiterQueue;
    fTunnels: TwsTunnelsList;
    fQueue: TwsQueue;
    fLocals: TwsLocals;
    fOnTunnelClose: TTunnelEvent;
    fOnHandshake: TsgcWSHandshakeEvent;
    FOnAuthentication: TsgcWSAuthenticationEvent;
    FOnCommandOther: TIdHTTPCommandEvent;
    FOnSessionEnd: TIdHTTPSessionEndEvent;
    FOnCommandGet: TIdHTTPCommandEvent;
    FOnSessionStart: TIdHTTPSessionStartEvent;
    fSSL: boolean;
    fEnabled: boolean;
    procedure SetServer(const Value: TsgcWebSocketHTTPServer);
    function GetLocals: TwsLocals;
    function GetQueue: TwsQueue;
    function getWaiters: TWaiterQueue;

  protected
    // Server events
    procedure ServerConnect(Connection: TsgcWSConnection);
    procedure ServerBinary(Connection: TsgcWSConnection; const Data: TMemoryStream);
    procedure ServerMessage(Connection: TsgcWSConnection; const Text: string);
    procedure ServerDisconnect(Connection: TsgcWSConnection; Code: Integer);
    procedure ServerError(Connection: TsgcWSConnection; const Error: string);
    procedure ServerHandshake(Connection: TsgcWSConnection; var Headers: TStringList);
    procedure ServerException(Connection: TsgcWSConnection; E: Exception);
    procedure ServerConnectionData(Connection: TsgcWSConnection; var aData: TObject);
    procedure ServerAuthentication(Connection: TsgcWSConnection; aUser, aPassword: string; var Authenticated: Boolean);
    // HTTP
    procedure ServerCommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure ServerCommandOther(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure ServerSessionStart(Sender: TIdHTTPSession);
    procedure ServerSessionEnd(Sender: TIdHTTPSession);

    procedure Log(const aMessage : string);

    // Processing
    procedure CommandProcessor(Connection: TsgcWSConnection; const Text: string);
    procedure BinaryProcessor(Connection : TsgcWSConnection; aStream : TMemoryStream);
    // Start processing of the "Open /i<client>
    procedure OpenTunnel(AConnection : TsgcWSConnection; const aCommand : string);
    procedure CloseTunnel(AConnection : TsgcWSConnection);
    // Register <local>
    // Main switch
    procedure RegisterConnection(AConnection : TsgcWSConnection; const aCommand : string);
    // request for connection /i
    procedure RegisterConnectionRequest(AConnection : TsgcWSConnection; const aParam : string);
    // response for the request /t
    procedure RegisterConnectionResponse(AConnection : TsgcWSConnection; const aParam : string);

    procedure ReturnStatus(AConnection : TsgcWSConnection);
//    function LocalConnections(const aName : string) : TsgcWSConnection;

    property Server : TsgcWebSocketHTTPServer read FServer write SetServer;
        // Tunnels
    property Tunnels : TwsTunnelsList read fTunnels write fTunnels;
    // List of Local connections
    property Locals : TwsLocals read GetLocals write fLocals;
    // queue of connection that are waiting for tunnels
    property Waiters: TWaiterQueue read getWaiters write fWaiters;
    property Queue : TwsQueue read GetQueue write fQueue;

  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy;override;

    procedure Start;
  published
    property Enabled : boolean read fEnabled write fEnabled;
    property SSL : boolean read fSSL write fSSL;
    property OnConnect: TsgcWSConnectEvent read FOnConnect write FOnConnect;
    property OnDisconnect: TsgcWSDisconnectEvent read FOnDisconnect write FOnDisconnect;
    // is called when the message was not processed by the server
    property OnMessage: TsgcWSMessageEvent read FOnMessage write FOnMessage;
    property OnBinary: TsgcWSBinaryEvent read FOnBinary write FOnBinary;
    property OnError: TsgcWSErrorEvent read FOnError write FOnError;
    property OnException: TsgcExceptionEvent read FOnException write FOnException;
    property OnConnectionData: TsgcWSConnectionDataEvent read FOnConnectionData write FOnConnectionData;
    property OnHandshake : TsgcWSHandshakeEvent read fOnHandshake write fOnHandshake;
    property OnAuthentication : TsgcWSAuthenticationEvent read FOnAuthentication write FOnAuthentication;

    // HTTP
    property OnCommandGet : TIdHTTPCommandEvent read FOnCommandGet write FOnCommandGet;
    property OnCommandOther : TIdHTTPCommandEvent read FOnCommandOther write FOnCommandOther;
    property OnSessionEnd: TIdHTTPSessionEndEvent read FOnSessionEnd write FOnSessionEnd;
    property OnSessionStart: TIdHTTPSessionStartEvent read FOnSessionStart write FOnSessionStart;

    property OnLog : TMessageProc read fOnLog write fOnLog;
    property OnTunnelClose : TTunnelEvent read fOnTunnelClose write fOnTunnelClose;
  end;

implementation

procedure TwsServer.BinaryProcessor(Connection: TsgcWSConnection;
  aStream: TMemoryStream);
begin
  Log('[Received] Binary Data');

  if assigned(fOnBinary) then
    OnBinary(Connection, aStream);

end;

procedure TwsServer.CloseTunnel(AConnection: TsgcWSConnection);
begin

end;

procedure TwsServer.CommandProcessor(Connection: TsgcWSConnection;
  const Text: string);
begin
  case ExtractCommand(Text) of
    cmdOpen : OpenTunnel(Connection, Text);
    cmdClose: CloseTunnel(Connection);
    cmdRegister: RegisterConnection(Connection, Text);
    cmdStatus : ReturnStatus(Connection);
    else
    begin
      Log('[COMMAND] Unprocessed command "' + Text + '"');
      if Assigned(OnMessage) then
        OnMessage(Connection, Text);
    end;
  end;
end;

constructor TwsServer.Create(AOwner : TComponent);
begin
  inherited;
  Server := TsgcWebSocketHTTPServer.Create(nil);
  Server.Name := 'wsServer1';
  Server.Port := 443;
  Server.OnConnect := ServerConnect;
  Server.OnMessage := ServerMessage;
  Server.OnBinary := serverBinary;
  Server.OnDisconnect := ServerDisconnect;
  Server.OnError := ServerError;
  Server.OnHandshake := ServerHandshake;
  Server.OnCommandGet := ServerCommandGet;
  Server.OnCommandOther := ServerCommandOther;
  Server.OnSessionStart := ServerSessionStart;
  Server.OnSessionEnd := ServerSessionEnd;
  Server.OnException := ServerException;
  Server.OnConnectionData := ServerConnectionData;
  Server.Authentication.Enabled := False;
  Server.Authentication.URL.Enabled := True;
  Server.Authentication.Session.Enabled := True;
  Server.OnAuthentication := ServerAuthentication;
  Server.AutoStartSession := False;
//  Bindings := <>
  Server.DocumentRoot := 'c:\Resources';
  Server.KeepAlive := True;
  Server.MaxConnections := 0;
  Server.SessionTimeOut := 0;
  Server.SSLOptions.CertFile := 'sgc.pem';
  Server.SSLOptions.KeyFile := 'sgc.pem';
  Server.SSLOptions.Port := 0;
  Server.SSLOptions.RootCertFile := 'sgc.pem';
  Server.ThreadPool := False;
  Server.ThreadPoolOptions.MaxThreads := 0;
  Server.ThreadPoolOptions.PoolSize := 32;
  Server.Extensions.DeflateFrame.Enabled := False;
  Server.Extensions.DeflateFrame.WindowBits := 15;
  Server.Options.HTMLFiles := True;
  Server.Options.JavascriptFiles := True;
  Server.Options.ValidateUTF8 := False;
  Server.Specifications.Drafts.Hixie76 := True;
  Server.Specifications.RFC6455 := True;
  Server.NotifyEvents := neAsynchronous;

  //
  Tunnels := TwsTunnelsList.Create;
end;


destructor TwsServer.Destroy;
begin
  Tunnels.Free;
  Server.Free;
  fWaiters.Free;
  fLocals.Free;
  fQueue.Free;
  inherited;
end;

function TwsServer.GetLocals: TwsLocals;
begin
  if not assigned(fLocals) then
  begin
    fLocals := TwsLocals.Create;
  end;

  Result := fLocals;
end;

function TwsServer.GetQueue: TwsQueue;
begin
  if not assigned(fQueue) then
  begin
    fQueue := TwsQueue.Create;
    fQueue.OnCallBack := Log;
  end;
  Result := fQueue;
end;

function TwsServer.getWaiters: TWaiterQueue;
begin
  if not assigned(fWaiters) then
  begin
    fWaiters := TWaiterQueue.Create;
    fWaiters.OnCallBack := Log;
  end;
  Result := fWaiters;
end;

(*
function TwsServer.LocalConnections(const aName: string): TsgcWSConnection;
var
  idx : integer;
begin
  idx := Locals.IndexOf(aName);
  if idx >= 0 then
    Result := TsgcWSConnection(Locals.Objects[idx])
  else
    Result := nil;
end;
*)
procedure TwsServer.Log(const aMessage: string);
begin
  if assigned(OnLog) then
    OnLog(aMessage);
end;

procedure TwsServer.OpenTunnel(AConnection: TsgcWSConnection;
  const aCommand: string);
var
  lConn : TsgcWSConnection;
  lParam : string;
begin
  if not SameText(TCrackedConnection(AConnection).HeadersRequest.Values['Origin'], csRemoteClient) then
  begin
    Log('<OpenTunnel> request is not from the remote client');
  end;
  lParam := ExtractParam('/i', aCommand);
//  lConn := LocalConnections(lParam);
  lConn := Locals.ByName[lParam];
  if lConn = nil then
  begin
    Log('<OpenTunnel> Installation ' + lParam + ' not connected');
    AConnection.WriteData('Error ' + lParam + ' Service not running. Please try again later');
    Exit;
  end;
  // Connection is waiting for the response from Local
  Waiters.Add(AConnection);

  // Request to the Local to create a new connection
  // Response is to be the Register /tGUID
  lConn.WriteData(cswsCommands[cmdOpen] + ' /t' + AConnection.Guid);
end;

procedure TwsServer.RegisterConnection(AConnection: TsgcWSConnection;
  const aCommand: string);
var
  lStr : string;
//  idx : integer;
begin
  lStr := ExtractParam('/i', aCommand);
  if lStr <> '' then
  begin
    RegisterConnectionRequest(AConnection, lStr);
    Exit;
  end;

  lStr := ExtractParam('/t', aCommand);
  if lStr <> '' then
  begin
    RegisterConnectionResponse(AConnection, lStr);
    Exit;
  end;

  Log('[Register]: invalid request for registration, "' + aCommand + '"');
end;

procedure TwsServer.RegisterConnectionRequest(AConnection: TsgcWSConnection;
  const aParam: string);
//var
//  idx : integer;
begin


//  idx := Locals.IndexOf(aParam);
//  if idx > 0 then
  if Locals.ByName[aParam] <> nil then
  begin
    AConnection.WriteData('Warn: already registered by name');
    Log('[Register]: Second attempt to register location "' + aParam + '"');
    Exit;
  end;

  Locals.Add(aParam, AConnection);
  Log('[LOCALS] : Registered ' + AConnection.Guid);

end;

procedure TwsServer.RegisterConnectionResponse(AConnection: TsgcWSConnection;
  const aParam: string);
var
//  idx : integer;
  lTunnel : TwsTunnel;
  lWaiter : TWaiterRecord;
begin
  // AConnection - is a connection from Local received in responce on Open /t
//  idx  := Waiters.IndexOf(aParam);
//  lWaiter := TWaiterRecord(Waiters.Objects[idx]);
  lWaiter := Waiters.WaiterByName(aParam);
  lTunnel := TwsTunnel.Create;
  lTunnel.ExternalClient := lWaiter.Connection; //lConn;
  lTunnel.LocalClient := AConnection;
  Tunnels.AddTunnel(lTunnel);
  Log('[TUNNEL READY] : writing ' + IntToStr(lWaiter.Queue.Count) + ' queued messages');
  // Return Status to the Source
  lWaiter.Connection.WriteData(csStatuses[csTunnel]);
  // Unblock queue
  lWaiter.Queue.Blocked := false;
  // Waiter's queue keeps messages from SRC, we need to send them to the newly established Dest
  lWaiter.Queue.Execute(AConnection);
  //Waiters.Delete(idx);
  Waiters.Delete(lWaiter);
  lWaiter.Free;

end;

procedure TwsServer.ReturnStatus(AConnection: TsgcWSConnection);
var
  lStatus : TwsConnectionStatus;
begin
  if Waiters.Waiter[AConnection] <> nil then
    lStatus := csWaitingForTunnel
  else if Tunnels.Destination(AConnection) <> nil then
    lStatus := csTunnel
  else
    lStatus := csConnected;

  AConnection.WriteData(csStatuses[lStatus]);
end;

procedure TwsServer.ServerAuthentication(Connection: TsgcWSConnection; aUser,
  aPassword: string; var Authenticated: Boolean);
begin
  if assigned(OnAuthentication) then
    OnAuthentication(Connection, aUser, aPassword, Authenticated)
  else
  begin
    if SameText(aUser, 'user') and sametext(aPassword, '1234') then
      Authenticated := true
    else
      Authenticated := false;
  end;
end;

procedure TwsServer.ServerBinary(Connection: TsgcWSConnection;
  const Data: TMemoryStream);
var
  lWaiter : TWaiterRecord;
begin
  Log('[Received] BINARY STREAM');

  // If connection waits for tunnel, queue message
  lWaiter := Waiters.Waiter[Connection];
  if assigned(lWaiter) then
  begin
    lWaiter.Queue.Add(Connection, Data);
    exit;
  end;
  // if tunnel exists, forward message
  if Tunnels.ForwardBinary(Connection, Data) then
    exit;
  // data for the server
  BinaryProcessor(Connection, Data);
end;

procedure TwsServer.ServerCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
//var
//  fs : TFileStream;
begin
//
  Log('[HTTP GET]');
  (*
  fs := TFileStream.Create('c:\resources\esegece.com.html', fmOpenRead);
  AResponseInfo.ContentStream := fs;
  AResponseInfo.WriteContent;
  *)
  if assigned(OnCommandGet) then
    OnCommandGet(AContext, ARequestInfo, AResponseInfo);
end;

procedure TwsServer.ServerCommandOther(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  Log('[OnCommandOther]');
  if assigned(OnCommandOther) then
    OnCommandOther(AContext, ARequestInfo, AResponseInfo);
end;

procedure TwsServer.serverConnect(Connection: TsgcWSConnection);
begin
  Log('[Connected] ' + Connection.Guid + ' FROM ' + ConnectionOrigin(Connection));
  if assigned(OnConnect) then
    OnConnect(Connection);
end;

procedure TwsServer.ServerConnectionData(Connection: TsgcWSConnection;
  var aData: TObject);
begin
  Log('[Received] [DATA]');
  if assigned(OnConnectionData) then
    OnConnectionData(Connection, aData);
end;

procedure TwsServer.ServerDisconnect(Connection: TsgcWSConnection;
  Code: Integer);
var
//  lTunnel : TwsTunnel;
  lWaiter : TWaiterRecord;
//  idx : integer;
begin
  Log('[Disconnection] Closed connection ' + Connection.GUID + ' Code ' + IntToStr(Code));
  (*
  idx  := Waiters.IndexOf(Connection.GUID);
  if idx >= 0 then
  begin
    lWaiter := TWaiterRecord(Waiters.Objects[idx]);
    Waiters.Delete(idx);
    lWaiter.Free;
    Exit;
  end;
  *)
  lWaiter := Waiters.Waiter[Connection];
  if assigned(lWaiter) then
  begin
    Waiters.Delete(lWaiter);
    lWaiter.Free;
  end;

  (*
  idx := Locals.IndexOf(Connection.Guid);
  if idx >= 0 then
    Locals.Delete(idx);
  *)
  Locals.DeleteByGUID(Connection.Guid);

  Tunnels.CloseTunnel(Connection);
end;

procedure TwsServer.ServerError(Connection: TsgcWSConnection;
  const Error: string);
begin
  Log('[ERROR] ' + Error + ' on ' + Connection.Guid);
  if assigned(OnError) then
    OnError(Connection, Error);
end;

procedure TwsServer.ServerException(Connection: TsgcWSConnection; E: Exception);
begin
  Log('[EXCEPTION] ' + Connection.GUID + ' : ' + E.Message);
  if assigned(OnException) then
    OnException(Connection, E);
end;

procedure TwsServer.ServerHandshake(Connection: TsgcWSConnection;
  var Headers: TStringList);
var
  idx : integer;
begin
//
  Log('[Handshake]');
  if (assigned(fOnLog)) and (assigned(Headers)) then
    for idx := 0 to headers.Count - 1 do
      Log(IntToStr(idx + 1) + ' ) ' + Headers[idx]);

  if assigned(OnHandShake) then
    OnHandShake(Connection, Headers);
end;

procedure TwsServer.ServerMessage(Connection: TsgcWSConnection;
  const Text: string);
var
  lWaiter : TWaiterRecord;
begin
  Log('[Received] "' + Text + '" FROM ' + Connection.guid);

  // If connection waits for tunnel, queue message
  lWaiter := Waiters.Waiter[Connection];
  if assigned(lWaiter) then
  begin
    lWaiter.Queue.Add(Connection, Text);
    exit;
  end;
  // if tunnel exists, forward message
  if Tunnels.ForwardMessage(Connection, Text) then
    exit;
  // Command for the server
  CommandProcessor(Connection, Text);
end;

procedure TwsServer.ServerSessionEnd(Sender: TIdHTTPSession);
begin
  Log('[SESSION] End: ' + Sender.SessionID);
  if assigned(OnSessionEnd) then
    OnSessionEnd(Sender);
end;

procedure TwsServer.ServerSessionStart(Sender: TIdHTTPSession);
begin
  Log('[SESSION] Start ' + Sender.SessionID);
  if assigned(OnSessionStart) then
    OnSessionStart(Sender);
end;

procedure TwsServer.SetServer(const Value: TsgcWebSocketHTTPServer);
begin
  FServer := Value;
end;

procedure TwsServer.Start;
begin
  if not Enabled then
    exit;

  if not ActivateServer(Server) then
    Log('[Server Start] : Failed to start server')
  else
  begin
    if Server.SSL then
      Log('[Server Started]: Port ' + IntToStr(Server.Port) + ', SSL Enabled')
    else
      Log('[Server Started]: Port ' + IntToStr(Server.Port));
  end;
end;

end.
