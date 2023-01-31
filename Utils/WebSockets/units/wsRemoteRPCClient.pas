unit wsRemoteRPCClient;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sgcWebSocket_Classes, sgcWebSocket, Buttons,
  StdCtrls, sgcWebSocket_Client, wsConsts, wsUtils, wsStates, ExtCtrls,
  sgcWebSocket_Types, wsComboProtocol, sgcWebSocket_Protocol_sgc_Server,
  sgcWebSocket_Protocol_sgc_Client;

type
  TState = (tsNone, tsWaitingStatus);

  TwsRemoteRPCClient = class(TComponent)
  private
    ftmrRelay: TTimer;
    ftmrWakeUp: TTimer;
    fwsClient: TsgcWebSocketClient;
    FOnConnect: TsgcWSConnectEvent;
    FOnDisconnect: TsgcWSDisconnectEvent;
    FOnBinary: TsgcWSBinaryEvent;
    FOnMessage: TsgcWSMessageEvent;
    fQueue: TwsQueue;
    fOnLog: TMessageProc;
    fState: TState;
    fStatus: TwsConnectionStatus;
    fOnError: TsgcWSErrorEvent;
    fOnHandshake: TsgcWSHandshakeEvent;
    fwsProtocol: TErpRpcComboProtocol_Client;
    fOnProtocolRPC: TsgcWSRPCEvent;
    fOnProtocolException: TsgcExceptionEvent;
    fOnProtocolRPCResult: TsgcWSRPCResultEvent;
    fOnProtocolEvent: TsgcWSCustomEvent;
    fOnProtocolError: TsgcWSErrorEvent;
    fOnProtocolBinary: TsgcWSBinaryEvent;
    fOnProtocolConnect: TsgcWSConnectEvent;
    fOnProtocolMessage: TsgcWSMessageEvent;
    FOnProtocolNotification: TsgcWSNotificationEvent;
    fOnProtocolDisconnect: TsgcWSDisconnectEvent;
    fOnProtocolRPCError: TsgcWSRPCErrorEvent;
    function getQueue: TwsQueue;
    procedure SetStatus(const Value: TwsConnectionStatus);
    function GetConnected: boolean;
    function getHost: string;
    function GetPort: integer;
    procedure SetConnected(const Value: boolean);
    procedure SetHost(const Value: string);
    procedure SetPort(const Value: integer);
    function GetTLS: boolean;
    procedure SetTLS(const Value: boolean);
  protected
    procedure Log(const aMsg : string);
    procedure tmrRelayTimer(Sender: TObject);
    procedure tmrWakeUpTimer(Sender: TObject);

    function ActivateConnection : boolean;
    procedure ProcessCommandStatus(const aStatus : string);
//    procedure ProcessCommandSend(const aCommand : string);
    procedure SendData(const aData : string);

    procedure WSClientConnect(Connection: TsgcWSConnection);
    procedure WSClientBinary(Connection: TsgcWSConnection; const Data: TMemoryStream);
    procedure WSClientMessage(Connection: TsgcWSConnection; const Text: string);
    procedure wsClientDisconnect(Connection: TsgcWSConnection; Code: Integer);
    procedure wsClientError(Connection: TsgcWSConnection; const Error: string);
    procedure wsClientHandshake(Connection: TsgcWSConnection; var Headers: TStringList);

    // protocol events
    procedure wsProtocolError(Connection: TsgcWSConnection; const Error: string);
    procedure wsProtocolException(Connection: TsgcWSConnection; E: Exception);
    procedure wsProtocolConnect(Connection: TsgcWSConnection);
    procedure wsProtocolDisconnect(Connection: TsgcWSConnection; Code: Integer);
    procedure wsProtocolMessage(Connection: TsgcWSConnection; const Text: string);
    procedure wsProtocolBinary(Connection: TsgcWSConnection; const Data: TMemoryStream);
    procedure wsProtocolRPCResult(Connection: TsgcWSConnection; Id, Result: string);
    procedure wsProtocolEvent(Connection: TsgcWSConnection; const Channel, Text: string);
    procedure wsProtocolRPCError(Connection: TsgcWSConnection; Id: string; ErrorCode: Integer; ErrorMessage, ErrorData: string);
    procedure wsProtocolNotification(Connection: TsgcWSConnection; const Method,Params: string);
    procedure wsProtocolRPC(Connection: TsgcWSConnection; const ID, Method, Params: string);


    property wsClient: TsgcWebSocketClient  read fwsClient write fwsClient;
    property wsProtocol : TErpRpcComboProtocol_Client read fwsProtocol write fwsProtocol;
    property tmrRelay: TTimer read ftmrRelay write ftmrRelay;
    property tmrWakeUp: TTimer read ftmrWakeUp write ftmrWakeup;
    property Queue : TwsQueue read getQueue write fQueue;
    property Status : TwsConnectionStatus read fStatus write SetStatus;
    property State : TState read fState write fState;
  public
    Constructor Create(AOwner : TComponent);override;
    destructor Destroy; override;

    procedure WriteData(const aData : string);overload;
    procedure WriteData(aStream : TMemoryStream); overload;

  published
    property OnLog : TMessageProc read fOnLog write fOnLog;

    property OnConnect: TsgcWSConnectEvent read FOnConnect write FOnConnect;
    property OnDisconnect: TsgcWSDisconnectEvent read FOnDisconnect write FOnDisconnect;
    property OnMessage: TsgcWSMessageEvent read FOnMessage write FOnMessage;
    property OnBinary: TsgcWSBinaryEvent read FOnBinary write FOnBinary;
    property OnError : TsgcWSErrorEvent read fOnError write fOnError;
    property OnHandshake : TsgcWSHandshakeEvent read fOnHandshake write fOnHandshake;

    property Host : string read getHost write SetHost;
    property Port : integer read GetPort write SetPort;
    property TLS : boolean read GetTLS write SetTLS;
    property Connected : boolean read GetConnected write SetConnected;

//    property OnNotification;
//    property OnRPC;
    property OnProtocolError : TsgcWSErrorEvent read fOnProtocolError write fOnProtocolError;
    property OnProtocolBinary : TsgcWSBinaryEvent read fOnProtocolBinary write fOnProtocolBinary;
    property OnProtocolMessage: TsgcWSMessageEvent read fOnProtocolMessage write fOnProtocolMessage;
    property OnProtocolConnect: TsgcWSConnectEvent read fOnProtocolConnect write fOnProtocolConnect;
    property OnProtocolDisconnect: TsgcWSDisconnectEvent read fOnProtocolDisconnect write fOnProtocolDisconnect;
    property OnProtocolEvent : TsgcWSCustomEvent read fOnProtocolEvent write fOnProtocolEvent;
    property OnProtocolRPCError: TsgcWSRPCErrorEvent read fOnProtocolRPCError write fOnProtocolRPCError;
    property OnProtocolRPCResult: TsgcWSRPCResultEvent read fOnProtocolRPCResult write fOnProtocolRPCResult;
    property OnProtocolException: TsgcExceptionEvent read fOnProtocolException write fOnProtocolException;
    property OnProtocolNotification: TsgcWSNotificationEvent read FOnProtocolNotification write fOnProtocolNotification;
    property OnProtocolRPC : TsgcWSRPCEvent read fOnProtocolRPC write FOnProtocolRPC;
  end;

implementation

{ TwsRemoteRPCClient }

function TwsRemoteRPCClient.ActivateConnection: boolean;
const
  TimeOut = 2000;
var
  idx : integer;
begin
  Result := wsClient.Active;
  try
    if not Result then
      Result := ActivateRemoteClient(wsClient);

    // If server not found, connection = nil
    if not assigned(wsClient.Connection) then
      exit;
    if not wsClient.Connection.Enabled  then
    begin
      for idx := 0 to TimeOut div 100 do
      begin
        Sleep(100);
        Result := wsClient.Connection.Enabled;
        if Result then
          exit;
      end;
    end;
  finally
    if not Result then
      Log('((Cannot activate connection))');
    if Result then
      Status := csConnected;
  end;
end;

constructor TwsRemoteRPCClient.Create(AOwner : TComponent);
begin
(*
  wsClient: TsgcWebSocketClient;
  tmrRelay: TTimer;
  tmrWakeUp: TTimer;
*)
  wsClient := TsgcWebSocketClient.Create(nil);
  wsClient.Name := 'wsClient';
  wsClient.Host := '127.0.0.1';
  wsClient.Port := 80;
  wsClient.TLS := False;
  wsClient.Proxy.Enabled := False;
  wsClient.Proxy.Port := 8080;
  wsClient.HeartBeat.Enabled := False;
  wsClient.HeartBeat.Interval := 300;
  wsClient.HeartBeat.Timeout := 0;
  wsClient.OnConnect := WSClientConnect;
  wsClient.OnMessage := WSClientMessage;
  wsClient.OnBinary := WSClientBinary;
  wsClient.OnDisconnect := wsClientDisconnect;
  wsClient.OnError := wsClientError;
  wsClient.OnHandshake := wsClientHandshake;
  wsClient.Authentication.Enabled := False;
  wsClient.Authentication.URL.Enabled := True;
  wsClient.Authentication.Session.Enabled := True;
  wsClient.Extensions.DeflateFrame.Enabled := False;
  wsClient.Extensions.DeflateFrame.WindowBits := 15;
  wsClient.Options.Parameters := '/';
  wsClient.Options.ValidateUTF8 := False;
  wsClient.Specifications.Drafts.Hixie76 := False;
  wsClient.Specifications.RFC6455 := True;
  wsClient.NotifyEvents := neAsynchronous;

  wsProtocol:= TErpRpcComboProtocol_Client.Create(nil);
  wsProtocol.OnConnect := wsProtocolConnect;
  wsProtocol.OnDisconnect := wsProtocolDisconnect;
  wsProtocol.OnMessage := wsProtocolMessage;
  wsProtocol.OnError := wsProtocolError;
  wsProtocol.OnRPCResult := wsProtocolRPCResult;
  wsProtocol.OnRPCError := wsProtocolRPCError;
  wsProtocol.OnEvent := wsProtocolEvent;
  wsProtocol.OnNotification := wsProtocolNotification;
  wsProtocol.OnRPC := wsProtocolRPC;
  wsProtocol.Client := wsClient;

  LoadRemoteRPCConfig(wsClient);

  tmrRelay := TTimer.Create(nil);
  if csDesigning in ComponentState then
    tmrRelay.Enabled := false;
  tmrRelay.Name := 'tmrRelay';
  tmrRelay.OnTimer := tmrRelayTimer;
  tmrRelay.Interval := 100;

  tmrWakeUp := TTimer.Create(nil);
  if csDesigning in ComponentState then
    tmrWakeUp.Enabled := false;
  tmrWakeup.Name := 'tmrWakeup';
  tmrWakeUp.Interval := 1000;
  tmrWakeUp.OnTimer := tmrWakeUpTimer;
end;

destructor TwsRemoteRPCClient.Destroy;
begin

  inherited;
end;

function TwsRemoteRPCClient.GetConnected: boolean;
begin
  Result := wsClient.Active and wsClient.Connection.Enabled;
end;

function TwsRemoteRPCClient.getHost: string;
begin
  Result := wsClient.Host;
end;

function TwsRemoteRPCClient.GetPort: integer;
begin
  Result := wsClient.Port;
end;

function TwsRemoteRPCClient.getQueue: TwsQueue;
begin
  if not assigned(fQueue) then
  begin
   fQueue := TwsQueue.Create;
   fQueue.OnCallBack := OnLog;
  end;
  Result := fQueue;
end;

function TwsRemoteRPCClient.GetTLS: boolean;
begin
  Result := wsClient.TLS;
end;

procedure TwsRemoteRPCClient.Log(const aMsg: string);
begin
  if assigned(OnLog) then
    OnLog(aMsg);
end;

procedure TwsRemoteRPCClient.WriteData(const aData: string);
begin
  Log('WriteData: Status ' + csStatuses[Status]);
  Log('Data: ' + aData);
  case Status of
    csNone,
    csConnected,
    csTunnel : SendData(aData);
    else
      Queue.Blocked := true;
      Queue.Add(wsClient.Connection, aData);
  end;

  if (Status = csConnected) and (ExtractCommand(aData) = cmdOpen) then
  begin
    Status := csWaitingForTunnel;
    State := tsWaitingSTatus;
  end;
end;

procedure TwsRemoteRPCClient.ProcessCommandStatus(const aStatus: string);
var
  Code,
  Value : integer;
  lPos : integer;
begin
  // Format is <nn>: text
//  Val(aStatus, Value, Code);
  lPos := pos(':', aStatus);
  if lPos > 0 then
  begin
    Val(Trim(copy(aStatus, 1, lPos - 1)), Value, Code);
    if Value = ord(csNone) then
      Status := csNone
    else if Value = ord(csConnected) then
      Status := csConnected
    else if Value = ord(csWaitingForTunnel) then
      Status := csWaitingForTunnel
    else if Value = ord(csTunnel) then
      Status := csTunnel
    else
    begin
      // Error - unknown status
      Status := csConnected;
    end;

  end;
end;

procedure TwsRemoteRPCClient.SetConnected(const Value: boolean);
begin
  if Value = Connected then
    exit;
  wsClient.Active := Value;
end;

procedure TwsRemoteRPCClient.SetHost(const Value: string);
begin
  if wsClient.Active then
    exit;
  wsClient.Host := Value;
end;

procedure TwsRemoteRPCClient.SetPort(const Value: integer);
begin
  if wsClient.Active  then
    exit;
  wsClient.Port := Value;
end;

procedure TwsRemoteRPCClient.SetStatus(const Value: TwsConnectionStatus);
begin
  case Status of
    csNone: fStatus := Value;
    csConnected: fStatus := Value;
    csWaitingForTunnel:
      begin
        fStatus := csTunnel;
        if Value = csTunnel then
          Queue.Execute(wsClient.Connection);
      end;
    csTunnel:fStatus := Value;
  end;
end;

procedure TwsRemoteRPCClient.SetTLS(const Value: boolean);
begin
  if wsClient.Active then
    exit;
  wsClient.TLS := Value;
end;

procedure TwsRemoteRPCClient.tmrRelayTimer(Sender: TObject);
begin
  tmrRelay.Enabled := false;
  if assigned(fQueue) then
    if (Status in  [csTunnel, csConnected]) then
    begin
      Queue.Blocked := false;
      Queue.Execute;
    end;
  tmrRelay.Enabled := true;
end;

procedure TwsRemoteRPCClient.tmrWakeUpTimer(Sender: TObject);
begin
  tmrWakeup.Enabled := false;
  if Status = csNone then
    Connected := true;
//    ActivateConnection;
  tmrWakeUp.Enabled := true;
end;

procedure TwsRemoteRPCClient.SendData(const aData: string);
begin

  Log('[WRITE] ' + aData);
  if Status = csNone then
    Connected := true;

  if Status in [csConnected, csTunnel] then
  begin
    if Queue.IsEmpty then
      wsProtocol.WriteData(aData)
    else
    begin
        Queue.Add(wsClient.Connection, aData);
        Queue.Blocked := false;
        queue.Execute;
    end;
  end;

//  wsProtocol.WriteData(aData);
end;

procedure TwsRemoteRPCClient.WriteData(aStream: TMemoryStream);
begin
(*
  wsClient.WriteData(aStream);
  *)
  Log('[WRITE BINARY]');
  if Status in [csConnected, csTunnel] then
  begin
    if Queue.IsEmpty then
      wsClient.WriteData(aStream)
    else
    begin
        Queue.Add(wsClient.Connection, aStream);
        Queue.Blocked := false;
        queue.Execute;
    end;
  end;
end;

procedure TwsRemoteRPCClient.WSClientBinary(Connection: TsgcWSConnection;
  const Data: TMemoryStream);
begin
  Log('[Binary] : Data received');
  if assigned(OnBinary) then
    OnBinary(Connection, Data);
end;

procedure TwsRemoteRPCClient.WSClientConnect(Connection: TsgcWSConnection);
begin
  Log('[CONNECTED]: ' + Connection.Guid);
  Status := csConnected;
  if assigned(OnConnect) then
    OnConnect(Connection);

end;

procedure TwsRemoteRPCClient.wsClientDisconnect(Connection: TsgcWSConnection;
  Code: Integer);
begin
  Log('[DISCONNECT] Code ' + IntToStr(Code));
  if assigned(OnDisconnect) then
    OnDisconnect(Connection, Code);
end;

procedure TwsRemoteRPCClient.wsClientError(Connection: TsgcWSConnection;
  const Error: string);
begin
  Log('[ERROR] ' + Error);
  if Assigned(OnError) then
    OnError(Connection, Error);
end;

procedure TwsRemoteRPCClient.wsClientHandshake(Connection: TsgcWSConnection;
  var Headers: TStringList);
begin
  if Assigned(OnHandShake) then
    OnHandshake(Connection, Headers);
end;

procedure TwsRemoteRPCClient.WSClientMessage(Connection: TsgcWSConnection;
  const Text: string);
begin
  Log('[Recieved]: ' + Text);

  if (Status=csWaitingForTunnel) and (State=tsWaitingStatus) then
  begin
    if (pos(cswsCommands[cmdError], Text) = 1) then
    begin
      Log(' --- Cleaning queue - tunnel does not exist');
      fQueue.Clear;
      if Connected then
        fStatus := csConnected   // bypass machine
      else
        Status := csNone;
      State := tsNone;
    end
    else
      ProcessCommandStatus(Text);
  end;
end;

procedure TwsRemoteRPCClient.wsProtocolBinary(Connection: TsgcWSConnection;
  const Data: TMemoryStream);
begin
  Log('[PROTOCOL BINARY]');
end;

procedure TwsRemoteRPCClient.wsProtocolConnect(Connection: TsgcWSConnection);
begin
  Log('[PROTOCOL CONNECT] ' + Connection.Guid);
  Status := csConnected;
end;

procedure TwsRemoteRPCClient.wsProtocolDisconnect(Connection: TsgcWSConnection;
  Code: Integer);
begin
  Log(Format('[PROTOCOL DISCONNECT] %s, code %d', [Connection.Guid, code]));
end;

procedure TwsRemoteRPCClient.wsProtocolError(Connection: TsgcWSConnection;
  const Error: string);
begin
  Log('[PROTOCOL ERROR] ' + Error);
  if assigned(OnProtocolError) then
    OnProtocolError(Connection, Error);
end;

procedure TwsRemoteRPCClient.wsProtocolEvent(Connection: TsgcWSConnection;
  const Channel, Text: string);
begin
  Log(Format('[PROTOCOL EVENT] Channel %s, Text %s',[Channel, Text]));
  if assigned(OnProtocolEvent) then
    OnProtocolEvent(Connection, Channel, Text);
end;

procedure TwsRemoteRPCClient.wsProtocolException(Connection: TsgcWSConnection;
  E: Exception);
begin
  Log('[PROTOCOL EXCEPTION] ' + E.Message);
  if assigned(OnProtocolException) then
    OnProtocolException(Connection, E);
end;

procedure TwsRemoteRPCClient.wsProtocolMessage(Connection: TsgcWSConnection;
  const Text: string);
begin
  Log('[PROTOCOL MESSAGE] ' + Text);
  if assigned(OnProtocolMessage) then
    OnProtocolMessage(Connection, Text);
end;

procedure TwsRemoteRPCClient.wsProtocolNotification(
  Connection: TsgcWSConnection; const Method, Params: string);
begin
  Log('[PROTOCOL NOTIFICATION] : Method ' + Method + ' Params=' + Params);
  if assigned(OnProtocolNotification) then
    OnProtocolNotification(Connection, Method, Params);
end;

procedure TwsRemoteRPCClient.wsProtocolRPC(Connection: TsgcWSConnection;
  const ID, Method, Params: string);
begin
  LOG(Format('[RPC RPC] Id=%s, Method=%s, Params=%s',[id, method, params]));
  if assigned(OnProtocolRPC) then
    OnProtocolRPC(Connection, ID, Method, Params);
end;

procedure TwsRemoteRPCClient.wsProtocolRPCError(Connection: TsgcWSConnection;
  Id: string; ErrorCode: Integer; ErrorMessage, ErrorData: string);
begin
  Log(Format('[RPC ERROR] id %s, Code %d, Message %s, data %s', [id, errorcode, errormessage, errordata]));
  if assigned(OnProtocolRPCError) then
    OnProtocolRPCError(Connection, Id, ErrorCode, ErrorMessage, ErrorData);
end;

procedure TwsRemoteRPCClient.wsProtocolRPCResult(Connection: TsgcWSConnection;
  Id, Result: string);
begin
  Log(Format('[RPC RESULT] Id %s, Result %s', [id, Result]));
  if assigned(OnProtocolRPCResult) then
    OnProtocolRPCResult(Connection, Id, Result);
end;

end.
