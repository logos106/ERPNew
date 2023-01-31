unit wsLocalRPCClient;
{$M+}
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sgcWebSocket_Classes, sgcWebSocket_Client, sgcWebSocket, ExtCtrls,
  sgcWebSocket_Protocol_sgc_Client, sgcWebSocket_Protocols,
  wsUtils, StdCtrls, wsConsts, contnrs, wsStates, sgcWebSocket_Types,
  wsComboProtocol, sgcWebSocket_Protocol_sgc_Server, sgcWebSocket_Const;

type
  TwsLocalRPCClient = class
  private
    fwsProtocol: TErpRpcComboProtocol_Client;
    fOnProtocolError: TsgcWSErrorEvent;
    fOnProtocolBinary: TsgcWSBinaryEvent;
    FOnConnect: TsgcWSConnectEvent;
    FOnProtocolMessage: TsgcWSMessageEvent;
    FOnDisconnect: TsgcWSDisconnectEvent;
    fWsClient: TsgcWebSocketClient;
    fOnProtocolEvent: TsgcWSCustomEvent;
    FOnRPCError: TsgcWSRPCErrorEvent;
    FOnRPCResult: TsgcWSRPCResultEvent;
    FOnException: TsgcExceptionEvent;
    fOnLog: TMessageProc;
    ftmrRelay: TTimer;
    ftmrWakeUp: TTimer;
    fRegistered: boolean;
    fQueue: TwsQueue;
    fClients: TObjectList;
    fSecondary: boolean;
    FOnNotification: TsgcWSNotificationEvent;
    fOnProtocolRPC: TsgcWSRPCEvent;
    fOnSecondaryConnect: TsgcWSConnectEvent;
    fOnSecondaryMessage: TsgcWSMessageEvent;
    FOnSecondaryNotification: TsgcWSNotificationEvent;
    fOnSecondaryDisconnect: TsgcWSDisconnectEvent;
    fOnSecondaryRPCError: TsgcWSRPCErrorEvent;
    fOnSecondaryException: TsgcExceptionEvent;
    fOnSecondaryRPCResult: TsgcWSRPCResultEvent;
    fOnSecondaryEvent: TsgcWSCustomEvent;
    fOnSecondaryError: TsgcWSErrorEvent;
    fOnSecondaryBinary: TsgcWSBinaryEvent;
    fOnSecondaryRPC: TsgcWSRPCEvent;
    fPassword: string;
    fUser: string;
    fOnSignIn: TSignInEvent;
//    fOnSecondaryMethodAuthorised: TMethodAuthorisation;
    fOnProtocolMethodAuthorisation: TMethodAuthorisation;
    fOnMethodAuthorisation: TMethodAuthorisationUser;
    fEnabled: boolean;
//???    fList: TwsClientList;
    procedure SetHost(const Value: string);
    procedure setPort(const Value: integer);
    function GetActive: boolean;
    function GetConnected: boolean;
    function GetHost: string;
    function GetPort: integer;
    function GetTLS: boolean;
    procedure SetActive(const Value: boolean);
    procedure SetConnected(const Value: boolean);
    procedure SetTLS(const Value: boolean);
    function GetQueue: TwsQueue;
    procedure SetOnMethodAuthorisation(const Value: TMethodAuthorisationUser);
    function getRemoteClient(const aRemoteName: string): TwsLocalRPCClient;
  protected
    procedure tmrWakeUpTimer(Sender: TObject);
    procedure tmrRelayTimer(Sender : TObject);


    procedure wsProtocolError(Connection: TsgcWSConnection; const Error: string);
    procedure wsProtocolException(Connection: TsgcWSConnection; E: Exception);
    procedure wsProtocolConnect(Connection: TsgcWSConnection);
    procedure wsProtocolDisconnect(Connection: TsgcWSConnection; Code: Integer);
    procedure wsProtocolMessage(Connection: TsgcWSConnection; const Text: string);
    procedure wsProtocolBinary(Connection: TsgcWSConnection; const Data: TMemoryStream);
    procedure wsProtocolRPCResult(Connection: TsgcWSConnection; Id, Result: string);
    procedure wsProtocolEvent(Connection: TsgcWSConnection; const Channel, Text: string);
    procedure wsProtocolRPCError(Connection: TsgcWSConnection; Id: string; ErrorCode: Integer; ErrorMessage, ErrorData: string);
    procedure wsProtocolNotification(Connection: TsgcWSConnection; const Method, Params: string);
    procedure wsProtocolRPC(Connection: TsgcWSConnection; const ID, Method, Params: string);
    function  wsProtocolMethodAuthorisation(Connection : TsgcWSConnection; const aMethodName : string) : integer;

    // secondary (tunnel) events
    procedure ChildProtocolError(Connection: TsgcWSConnection; const Error: string);
    procedure ChildProtocolException(Connection: TsgcWSConnection; E: Exception);
    procedure ChildProtocolConnect(Connection: TsgcWSConnection);
    procedure ChildProtocolDisconnect(Connection: TsgcWSConnection; Code: Integer);
    // Perform $Open and $sign, all other stuff is passed to OnSecondaryMessage
    procedure ChildProtocolMessage(Connection: TsgcWSConnection; const Text: string);
    procedure ChildProtocolBinary(Connection: TsgcWSConnection; const Data: TMemoryStream);
    procedure ChildProtocolRPCResult(Connection: TsgcWSConnection; Id, Result: string);
    procedure ChildProtocolEvent(Connection: TsgcWSConnection; const Channel, Text: string);
    procedure ChildProtocolRPCError(Connection: TsgcWSConnection; Id: string; ErrorCode: Integer; ErrorMessage, ErrorData: string);
    procedure ChildProtocolNotification(Connection: TsgcWSConnection; const Method, Params: string);
    procedure ChildProtocolRPC(Connection: TsgcWSConnection; const ID, Method, Params: string);
    function  ChildMethodAuthorisation(Connection : TsgcWSConnection; const aMethodName : string) : integer;


    procedure Log(const aMsg : string);

    // Command processing
    procedure OpenConnection(const aCommand : string);
    procedure ProcessTunnelSignIn(AClient : TwsLocalRPCClient; Connection: TsgcWSConnection; const Text: string);

    function ClientByConnection(const Connection: TsgcWSConnection) : TwsLocalRPCClient;

    property tmrWakeUp: TTimer read ftmrWakeUp write ftmrWakeUp;
    property tmrRelay: TTimer read ftmrRelay write ftmrRelay;
//???    property List : TwsClientList read fList write fList;
    property Queue : TwsQueue read GetQueue write fQueue;
    property Registered : boolean read fRegistered write fRegistered;

    // Properties are used on secondary connections
    property Secondary : boolean read fSecondary write fSecondary;
    property User : string read fUser write fuser;
    property Password : string read fPassword write fPassword;

  public
    constructor Create(aOwner : TComponent; aSecondary : boolean = false);
    destructor Destroy; override;

    property Clients : TObjectList read fClients write fClients;
    property wsProtocol : TErpRpcComboProtocol_Client read fwsProtocol write fwsProtocol;
    property wsClient : TsgcWebSocketClient read fWsClient write fWsClient;
    // Write data in the main connection - destination is the server
    procedure WriteData(const aData : string); overload;
    procedure WriteData(AStream : TMemoryStream); overload;
    procedure WriteRPCData(const aData : string); overload;
    procedure WriteRPCData(AStream : TMemoryStream); overload;
    // Write data in the child connection - destination is the remote (tunneled) client
    procedure WriteData(const Connection : TsgcWSConnection; const aData : string); overload;
    procedure WriteData(const Connection : TsgcWSConnection; AStream : TMemoryStream); overload;
    procedure WriteRPCData(const Connection : TsgcWSConnection; const aData : string); overload;
    procedure WriteRPCData(const Connection : TsgcWSConnection; AStream : TMemoryStream); overload;
    procedure WriteRPCResult(const Connection : TsgcWSConnection; const Id, Value : string);overload;
    procedure WriteRPCError(const Connection : TsgcWSConnection; const aId: String;
         const aCode: Integer; const aMessage: String; const aData: String = '');


    procedure Flush;

    property Client[const aRemoteName : string] : TwsLocalRPCClient read getRemoteClient;default;
    property Client[const aConnection : TsgcWSConnection] : TwsLocalRPCClient read ClientByConnection;default;

  published
    property Enabled : boolean read fEnabled write fEnabled;
    // External Protocol Links
    property OnProtocolError : TsgcWSErrorEvent read fOnProtocolError write fOnProtocolError;
    property OnProtocolBinary : TsgcWSBinaryEvent read fOnProtocolBinary write fOnProtocolBinary;
    property OnProtocolMessage: TsgcWSMessageEvent read FOnProtocolMessage write FOnProtocolMessage;
    property OnProtocolConnect: TsgcWSConnectEvent read FOnConnect write FOnConnect;
    property OnProtocolDisconnect: TsgcWSDisconnectEvent read FOnDisconnect write FOnDisconnect;
    property OnProtocolEvent : TsgcWSCustomEvent read fOnProtocolEvent write fOnProtocolEvent;
    property OnProtocolRPCError: TsgcWSRPCErrorEvent read FOnRPCError write FOnRPCError;
    property OnProtocolRPCResult: TsgcWSRPCResultEvent read FOnRPCResult write FOnRPCResult;
    property OnProtocolException: TsgcExceptionEvent read FOnException write FOnException;
    property OnProtocolNotification: TsgcWSNotificationEvent read FOnNotification write fOnNotification;
    property OnProtocolRPC : TsgcWSRPCEvent read fOnProtocolRPC write FOnProtocolRPC;
    property OnProtocolMethodAuthorisation: TMethodAuthorisation read fOnProtocolMethodAuthorisation write fOnProtocolMethodAuthorisation;
    // Secondary connections handlers
    property OnSecondaryError : TsgcWSErrorEvent read fOnSecondaryError write fOnSecondaryError;
    property OnSecondaryBinary : TsgcWSBinaryEvent read fOnSecondaryBinary write fOnSecondaryBinary;
    property OnSecondaryMessage: TsgcWSMessageEvent read fOnSecondaryMessage write fOnSecondaryMessage;
    property OnSecondaryConnect: TsgcWSConnectEvent read fOnSecondaryConnect write fOnSecondaryConnect;
    property OnSecondaryDisconnect: TsgcWSDisconnectEvent read fOnSecondaryDisconnect write fOnSecondaryDisconnect;
    property OnSecondaryEvent : TsgcWSCustomEvent read fOnSecondaryEvent write fOnSecondaryEvent;
    property OnSecondaryRPCError: TsgcWSRPCErrorEvent read fOnSecondaryRPCError write fOnSecondaryRPCError;
    property OnSecondaryRPCResult: TsgcWSRPCResultEvent read fOnSecondaryRPCResult write fOnSecondaryRPCResult;
    property OnSecondaryException: TsgcExceptionEvent read fOnSecondaryException write fOnSecondaryException;
    property OnSecondaryNotification: TsgcWSNotificationEvent read FOnSecondaryNotification write fOnSecondaryNotification;
    property OnSecondaryRPC : TsgcWSRPCEvent read fOnSecondaryRPC write FOnSecondaryRPC;

    property OnLog : TMessageProc read fOnLog write fOnLog;

    //
    property OnMethodAuthorisation : TMethodAuthorisationUser read fOnMethodAuthorisation write SetOnMethodAuthorisation;

    // Connection properties
    property Active : boolean read GetActive write SetActive;
    property Connected : boolean read GetConnected write SetConnected;
    property Host : string read GetHost write SetHost;
    property Port : integer read GetPort write setPort;
    property TLS : boolean read GetTLS write SetTLS;

    // ERP Internal stuff
    property OnSignIn : TSignInEvent read fOnSignIn write fOnSignIn;

  end;

implementation
uses
  IdException, IdStack;

{ TwsLocalRPCClient }

function TwsLocalRPCClient.ChildMethodAuthorisation(
  Connection: TsgcWSConnection; const aMethodName: string): integer;
var
  lClient : TwsLocalRPCClient;
  lUser : string;
begin
  Log('[CHILD METHOD Auth]: Method= ' + aMethodName);
  if not Secondary then
  begin
    lClient := ClientByConnection(Connection);
    lUser := lClient.User;
  end
  else
    lUser := Self.User;
  if lUser = '' then
  begin
    Result := csNoUser;
    exit;
  end;

  if assigned(OnMethodAuthorisation) then
    Result := OnMethodAuthorisation(lUser, aMethodName)
  else
    Result := csNoMethod;
end;

procedure TwsLocalRPCClient.ChildProtocolBinary(Connection: TsgcWSConnection;
  const Data: TMemoryStream);
var
  lClient : TwsLocalRPCClient;
begin
  lClient := ClientByConnection(Connection);
  if not Assigned(lClient) then
    lClient := Self;
  Log('[CHILD RPC] Binary Data for ' + lClient.User);
//  if assigned(lClient.wsProtocol.OnBinary) then
//    lClient.wsProtocol.OnBinary(Connection, Data);
  if assigned(lClient.OnSecondaryBinary) then
    lClient.OnSecondaryBinary(Connection, Data);
end;

procedure TwsLocalRPCClient.ChildProtocolConnect(Connection: TsgcWSConnection);
begin
  Log('[CHILD RPC Connect] ' + Connection.Guid);
  if assigned(OnSecondaryConnect) then
    OnSecondaryConnect(Connection);
end;

procedure TwsLocalRPCClient.ChildProtocolDisconnect(
  Connection: TsgcWSConnection; Code: Integer);
var
  lClient : TwsLocalRPCClient;
begin
  Log('[CHILD RPC] Disconnect Code ' + IntToStr(Code));
//  lClient := Client[Connection];
  if assigned(OnSecondaryDisconnect) then
    OnSecondaryDisconnect(Connection, Code);
  lClient := Client[Connection];
  Clients.Remove(lClient);  // Should be destroyed
end;

procedure TwsLocalRPCClient.ChildProtocolError(Connection: TsgcWSConnection;
  const Error: string);
begin
  Log('[CHILD RPC ERROR] ' + Error);
end;

procedure TwsLocalRPCClient.ChildProtocolEvent(Connection: TsgcWSConnection;
  const Channel, Text: string);
begin
    Log(Format('[CHILD RPC EVENT] Channel %s, Text %s',[Channel, Text]));
end;

procedure TwsLocalRPCClient.ChildProtocolException(Connection: TsgcWSConnection;
  E: Exception);
begin
  Log('[CHILD RPC EXCEPTION] ' + E.Message);
end;

procedure TwsLocalRPCClient.ChildProtocolMessage(Connection: TsgcWSConnection;
  const Text: string);
var
  lClient : TwsLocalRPCClient;
begin
  Log('[CHILD RPC MESSAGE] ' + Text);

  lClient := ClientByConnection(Connection);
  if not assigned(lClient) then
    raise Exception.Create('Unexpected Error: Received message without client connection');

  if (Text<> '') and (Text[1]='$') then
  begin
    case ExtractCommand(Text) of
      cmdOpen : exit;  // Already opened??
      cmdSignIn : ProcessTunnelSignIn(lClient, Connection, Text);
      else
      begin
        log('[COMMAND] "' + Text + '" - UNKNOWN');
      //  if assigned(OnProtocolMessage) then
      //    OnProtocolMessage(Connection, Text);
        if assigned(OnSecondaryMessage) then
          OnSecondaryMessage(Connection, Text);
      end;
    end;
  end
  else
    if assigned(OnSecondaryMessage) then
      OnSecondaryMessage(Connection, Text);
end;

procedure TwsLocalRPCClient.ChildProtocolNotification(
  Connection: TsgcWSConnection; const Method, Params: string);
begin
  Log('[CHILD RPC NOTIFICATION] Method: ' + Method + ', Params=' + Params);
  if assigned(OnSecondaryNotification) then
    OnSecondaryNotification(Connection, Method, Params);
end;

procedure TwsLocalRPCClient.ChildProtocolRPC(Connection: TsgcWSConnection;
  const ID, Method, Params: string);
begin
  Log(Format('[CHILD RPC]: ID %s, Method %s, Params %s Connection %s', [ID, Method, Params, Connection.Guid]));
  if assigned(OnSecondaryRPC) then
    OnSecondaryRPC(Connection, ID, Method, Params);

end;

procedure TwsLocalRPCClient.ChildProtocolRPCError(Connection: TsgcWSConnection;
  Id: string; ErrorCode: Integer; ErrorMessage, ErrorData: string);
begin
  Log(Format('[CHILD RPC RPCERROR]: Id %s, Code %d, Message %s, Data %s', [id, errorcode, errormessage, errordata]));
end;

procedure TwsLocalRPCClient.ChildProtocolRPCResult(Connection: TsgcWSConnection;
  Id, Result: string);
begin
  Log(Format('[CHILD RPC RESULT] Id=%s, Result=%s', [Id, Result]));
end;

function TwsLocalRPCClient.ClientByConnection(
  const Connection: TsgcWSConnection): TwsLocalRPCClient;
var
  idx : integer;
begin
  for idx := 0 to Clients.Count - 1 do
    if TwsLocalRPCClient(Clients[idx]).wsClient.Connection = Connection then
    begin
      Result := TwsLocalRPCClient(Clients[idx]);
      exit;
    end;
  Result := nil;
end;

constructor TwsLocalRPCClient.Create(aOwner: TComponent; aSecondary : boolean = false);
begin
  inherited Create;
  Secondary := aSecondary;
  wsClient := TsgcWebSocketClient.Create(nil);
  wsClient.Name := 'wsClientwsClient';
  wsClient.Port := 80;
  wsClient.TLS := False;
  wsClient.Proxy.Enabled := False;
  wsClient.Proxy.Port := 8080;
  wsClient.HeartBeat.Enabled := False;
  wsClient.HeartBeat.Interval := 300;
  wsClient.HeartBeat.Timeout := 0;
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
  wsClient.OnException := wsProtocolException;

  wsClient.OnMessage := wsProtocolMessage; // ???

//  Log('[RPC] Creating Client');
  wsProtocol:= TErpRpcComboProtocol_Client.Create(nil);
  wsProtocol.OnConnect := wsProtocolConnect;
  wsProtocol.OnDisconnect := wsProtocolDisconnect;
  wsProtocol.OnMessage := wsProtocolMessage;
  wsProtocol.OnBinary := wsProtocolBinary;
  wsProtocol.OnError := wsProtocolError;
  wsProtocol.OnRPCResult := wsProtocolRPCResult;
  wsProtocol.OnRPCError := wsProtocolRPCError;
  wsProtocol.OnRPC := wsProtocolRPC;
  wsProtocol.OnEvent := wsProtocolEvent;
  wsProtocol.OnNotification := wsProtocolNotification;
  wsProtocol.OnMethodAuthorised := wsProtocolMethodAuthorisation;
  wsProtocol.Client := wsClient;

  // Checking for remote server
  tmrWakeUp := TTimer.Create(nil);
  tmrWakeUp.Name := 'tmrWakeUp';
  tmrWakeUp.Interval := 1000;
  tmrWakeUp.OnTimer := tmrWakeUpTimer;

  tmrRelay := TTimer.Create(nil);
  tmrRelay.Name := 'tmrRelay';
  tmrRelay.Interval := 100;
  tmrRelay.OnTimer := tmrRelayTimer;

//???  List := TwsClientList.Create;
  Clients := TObjectList.Create(true);
//  LoadLocalRPCConfig(wsClient);
end;

destructor TwsLocalRPCClient.Destroy;
begin
  tmrwakeup.Enabled := false;
  tmrRelay.Enabled := false;
  Active := false;
  tmrWakeup.Free;
  tmrRelay.Free;
  Queue.Free;
  Clients.Free;
  wsProtocol.Free;
  inherited;
end;

procedure TwsLocalRPCClient.Flush;
begin
  Self.Queue.Execute();
end;

function TwsLocalRPCClient.GetActive: boolean;
begin
  Result := wsClient.Active;
end;

function TwsLocalRPCClient.GetConnected: boolean;
begin
//  Result := Active and wsClient.Connection.Enabled;
  Result := Active;
  if Result then
    Result := wsClient.Connection.Enabled;
end;

function TwsLocalRPCClient.GetHost: string;
begin
  Result := wsClient.Host;
end;

function TwsLocalRPCClient.GetPort: integer;
begin
  Result := wsClient.Port;
end;

function TwsLocalRPCClient.GetQueue: TwsQueue;
begin
  if not assigned(fQueue) then
  begin
    fQueue := TwsQueue.Create;
    Queue.OnCallBack := OnLog;
  end;
  Result := fQueue;
end;

function TwsLocalRPCClient.getRemoteClient(
  const aRemoteName: string): TwsLocalRPCClient;
begin

end;

function TwsLocalRPCClient.GetTLS: boolean;
begin
  Result := wsClient.TLS;
end;

procedure TwsLocalRPCClient.Log(const aMsg: string);
begin
  if assigned(OnLog) then
    OnLog(aMsg);
end;

procedure TwsLocalRPCClient.OpenConnection(const aCommand: string);
var
  lClient : TwsLocalRPCClient; //TsgcWebSocketClient;
  lState : TwsConnectionState;
  lParam : string;
begin

  lParam := ExtractParam('/t', aCommand);
  if lParam = '' then
  begin
    Log('[OPEN SECONDARY]: incorrect request "' + aCommand + '"');
    exit;
  end;
  lClient := TwsLocalRPCClient.Create(nil, true);
  try
    (*
    if not ActivateLocalClient(lClient) then
    begin
      Log('>>Failed to open');
      lClient.Free;
      Exit;
    end;
    *)
    lClient.Port := Port;
    lClient.Host := Host;
    lClient.TLS := TLS;
    lState := TwsConnectionState.Create;
    lState.SendRequest := cmdRegister;
    lClient.wsClient.OnMessage := ChildProtocolMessage;
    lClient.OnProtocolMessage := ChildProtocolMessage;
    lClient.OnSecondaryBinary := OnProtocolBinary;
    lClient.OnProtocolBinary := ChildProtocolBinary;
    lClient.OnProtocolDisconnect := ChildProtocolDisconnect;
    lClient.OnProtocolError := ChildProtocolError;
    lClient.OnProtocolConnect := ChildProtocolConnect;
    lClient.OnProtocolEvent := ChildProtocolEvent;
    lClient.OnProtocolRPCError := ChildProtocolRPCError;
    lClient.OnProtocolRPCResult := ChildProtocolRPCResult;
    lClient.OnProtocolException := ChildProtocolException;
    lClient.OnProtocolNotification := ChildProtocolNotification;
    lClient.OnProtocolMethodAuthorisation := ChildMethodAuthorisation;
    lClient.OnProtocolRPC := ChildProtocolRPC;
    lClient.OnMethodAuthorisation := Self.OnMethodAuthorisation;
    lClient.Active := true;
    Log('[OPEN SECONDARY] ' + lClient.wsClient.Connection.Guid);
//????    List.Add(TwsClientRecord.Create(lClient.wsClient.Connection, lState));
    // Response is to wait until connection established
//????    Queue.Add(lClient.Connection, cswsCommands[cmdRegister] + ' /t' + lParam);

    Queue.Add(lClient.wsClient.Connection, cswsCommands[cmdRegister] + ' /t' + lParam);
//    List.Add(lClient);
    Clients.Add(lClient);
  finally

  end;
end;

procedure TwsLocalRPCClient.ProcessTunnelSignIn(AClient : TwsLocalRPCClient; Connection: TsgcWSConnection;
  const Text: string);
var
  lUser,
  lPassword : string;
begin
// received SignIn in tunnel
  lUser := ExtractParam('/u', Text);
  lPassword := ExtractParam('/p', Text);

  if (AClient.User <> '') then
    if not SameText(AClient.User, lUser) then
    begin
    // Received $Sign with a user different from already signed  in
//      Connection.WSMsg.
    end
    else if AClient.Password <> '' then
    begin
      if (AClient.Password <> lPassword) then
      begin
        // secondary $SIGN: the same user, different password

      end;
      exit;  // Second attempt to sign in, user and password are the same as for already signed in user
             // => everything OK
    end;

  //
  if Assigned(OnSignIn) then
  begin
    if OnSignIn(lUser, lPassword) then
    begin
      AClient.User := lUser;
      AClient.Password := lPassword;
    end;
  end
  else
  begin
      AClient.User := lUser;
      AClient.Password := lPassword;
  end;


end;

procedure TwsLocalRPCClient.SetActive(const Value: boolean);
begin
  if Active = Value then
    Exit;
(*
  if Active and not(Value) then
    wsClient.Active := Value
  else if (not (Active)) and Value then
    wsClient.Active := Value;
*)
  Registered := false;
  if Value then
    LoadLocalRPCConfig(wsClient);
  wsClient.Active := Value;
  if wsClient.Active {Value} and not Secondary then
    Queue.Add(wsClient.Connection, cswsCommands[cmdRegister] + ' /iLocal');
//@@@@    Queue.Add(wsClient.Connection, cswsCommands[cmdRegister] + ' /i"' + GetComputerName() + '"');
end;

procedure TwsLocalRPCClient.SetConnected(const Value: boolean);
begin
//  wsClient.Active := Value;
  Active := Value;
end;

procedure TwsLocalRPCClient.SetHost(const Value: string);
begin
  if Active then
    exit;
  wsClient.Host := Value;
end;

procedure TwsLocalRPCClient.SetOnMethodAuthorisation(
  const Value: TMethodAuthorisationUser);
var
  idx : integer;
begin
  fOnMethodAuthorisation := Value;
  if Secondary then
    exit;
  for idx := 0 to Clients.Count - 1 do
     TwsLocalRPCClient(Clients[idx]).OnMethodAuthorisation := Value;
end;

procedure TwsLocalRPCClient.setPort(const Value: integer);
begin
  if Active then
    exit;
  wsClient.Port := Value;
end;

procedure TwsLocalRPCClient.SetTLS(const Value: boolean);
begin
  if Active then
    exit;
  wsClient.TLS := Value;
end;

procedure TwsLocalRPCClient.tmrRelayTimer(Sender: TObject);
begin
  tmrRelay.Enabled := false;
  try
    if not enabled then
      exit;
    Queue.Execute;
  finally
    tmrRelay.Enabled := true;
  end;
end;

procedure TwsLocalRPCClient.tmrWakeUpTimer(Sender: TObject);
begin
  // Kind of KeepAlive
  tmrWakeUp.Enabled := false;
  try
    if not enabled then
      exit;
    if not Active then
    begin
      Active := true;
      Registered := false;
    end;
  finally
    tmrWakeUp.Enabled := true;
  end;
end;

procedure TwsLocalRPCClient.WriteData(AStream: TMemoryStream);
begin
  wsClient.WriteData(AStream);
end;

procedure TwsLocalRPCClient.WriteData(const aData: string);
begin
  wsClient.WriteData(aData);
end;

procedure TwsLocalRPCClient.WriteRPCData(AStream: TMemoryStream);
begin
//  wsProtocol.WriteData(aStream);
end;

procedure TwsLocalRPCClient.WriteRPCData(const aData: string);
begin
  wsProtocol.WriteData(aData);
end;

procedure TwsLocalRPCClient.wsProtocolBinary(Connection: TsgcWSConnection;
  const Data: TMemoryStream);
begin
  if assigned(OnProtocolBinary) then
    OnProtocolBinary(Connection, Data);
end;

procedure TwsLocalRPCClient.wsProtocolConnect(Connection: TsgcWSConnection);
var
  idx : integer;
  lName : string;
begin
  Log('[RPC Connect] Connected ' + Connection.Guid);
  for idx := 0 to TCrackedConnection(Connection).HeadersRequest.Count - 1 do
  begin
    lName := TCrackedConnection(Connection).HeadersRequest.Names[idx];
    Log('[Connect] ' + lName + ' = ' + TCrackedConnection(Connection).HeadersRequest.Values[lName]);
  end;
  if assigned(OnProtocolConnect) then
    OnProtocolConnect(Connection);
end;

procedure TwsLocalRPCClient.wsProtocolDisconnect(Connection: TsgcWSConnection;
  Code: Integer);
begin
  Log('[RPC DISCONNECT] ' + Connection.guid);
  if assigned(onProtocolDisconnect) then
    OnProtocolDisconnect(Connection, Code);
end;

procedure TwsLocalRPCClient.wsProtocolError(Connection: TsgcWSConnection;
  const Error: string);
begin
  Log('[RPC ERROR] ' + Error);
  if assigned(OnProtocolError) then
    OnProtocolError(Connection, Error);
end;

procedure TwsLocalRPCClient.wsProtocolEvent(Connection: TsgcWSConnection;
  const Channel, Text: string);
begin
  Log(Format('[RPC EVENT] Channel %s, Text %s', [Channel, Text]));
  if assigned(OnProtocolEvent) then
    OnProtocolEvent(Connection, Channel, Text);
end;

procedure TwsLocalRPCClient.wsProtocolException(Connection: TsgcWSConnection;
  E: Exception);
begin
  Log('[RPC EXCEPTION] ' + E.Message);
  if assigned(OnProtocolException) then
    OnProtocolException(Connection, E);
  if E is EIdConnClosedGracefully then
  begin
    Self.Queue.Clear;
    Connected := false;
  end
  else if E is EIdSocketError then
  begin
    // message looks like "Socket Error # 10061"#$D#$A"Connection refused."
    Self.Queue.Clear;
  end;

end;


procedure TwsLocalRPCClient.wsProtocolMessage(Connection: TsgcWSConnection;
  const Text: string);
begin
  LOG('[RPC MESSAGE] ' + Connection.Guid + ', Text ' + Text);

  case ExtractCommand(Text) of
    cmdOpen : OpenConnection(Text);
    else
    begin
      log('[COMMAND] "' + Text + '" - UNKNOWN');
      if assigned(OnProtocolMessage) then
        OnProtocolMessage(Connection, Text);
    end;
  end;
end;

function TwsLocalRPCClient.wsProtocolMethodAuthorisation(
  Connection: TsgcWSConnection; const aMethodName: string): integer;
begin
  Log('[Protocol Auth]: Method ' + aMethodName);
  if Secondary then
    Result := ChildMethodAuthorisation(Connection, aMethodName)
  else
    result := csInternalError;
end;

procedure TwsLocalRPCClient.wsProtocolNotification(Connection: TsgcWSConnection;
  const Method, Params: string);
begin
  Log('[RPC NOTIFICATION]: Method ' + Method + ', Params=' + Params);
  if assigned(OnProtocolNotification) then
    OnProtocolNotification(Connection, Method, Params);
end;

procedure TwsLocalRPCClient.wsProtocolRPC(Connection: TsgcWSConnection;
  const ID, Method, Params: string);
begin
  Log('[PROTOCOL RPC]');
  if assigned(OnProtocolRPC) then
    OnProtocolRPC(Connection, ID, Method, Params);
end;

procedure TwsLocalRPCClient.wsProtocolRPCError(Connection: TsgcWSConnection;
  Id: string; ErrorCode: Integer; ErrorMessage, ErrorData: string);
begin
  LOG(Format('[RPC ERROR]: ID %s, Code %d, Message %s, Data %s', [id, ErrorCode, ErrorMessage, ErrorData]));
  if assigned(onProtocolRPCError) then
    OnProtocolRPCError(Connection, id, ErrorCode, ErrorMessage, ErrorData);
end;

procedure TwsLocalRPCClient.wsProtocolRPCResult(Connection: TsgcWSConnection;
  Id, Result: string);
begin
  Log(Format('[RPC RESULT] Id %s, Result %s', [Id, Result]));
  if assigned(OnProtocolRPCResult) then
    OnProtocolRPCResult(Connection, Id, Result);
end;

procedure TwsLocalRPCClient.WriteData(const Connection: TsgcWSConnection;
  AStream: TMemoryStream);
var
  lClient : TwsLocalRPCClient;
begin
  lClient := ClientByConnection(Connection);
  if assigned(lClient) then
    Connection.WriteData(aStream);
end;

procedure TwsLocalRPCClient.WriteData(const Connection: TsgcWSConnection;
  const aData: string);
var
  lClient : TwsLocalRPCClient;
begin
  lClient := ClientByConnection(Connection);
  if assigned(lClient) then
    Connection.WriteData(aData);
end;

procedure TwsLocalRPCClient.WriteRPCData(const Connection: TsgcWSConnection;
  AStream: TMemoryStream);
var
  lClient : TwsLocalRPCClient;
begin
  lClient := ClientByConnection(Connection);
  if assigned(lClient) then
    Connection.WriteData(aStream);
end;

procedure TwsLocalRPCClient.WriteRPCError(const Connection: TsgcWSConnection;
  const aId: String; const aCode: Integer; const aMessage, aData: String);
var
  lClient : TwsLocalRPCClient;
begin
  lClient := ClientByConnection(Connection);
  if assigned(lClient) then
  begin
    lClient.wsProtocol.RPCError(aId, aCode, aMessage, aData);
  end;

end;

procedure TwsLocalRPCClient.WriteRPCResult(const Connection: TsgcWSConnection;
  const Id, Value: string);
var
  lClient : TwsLocalRPCClient;
begin
  lClient := ClientByConnection(Connection);
  if assigned(lClient) then
  begin
//    Connection.WriteData('{"jsonrpc": "2.0", "result": "' + Value + '", "id":' + id + '}');
    Connection.WriteData('{"jsonrpc": "2.0", "result": ' + Value + ', "id":' + id + '}');
  end;
end;

procedure TwsLocalRPCClient.WriteRPCData(const Connection: TsgcWSConnection;
  const aData: string);
var
  lClient : TwsLocalRPCClient;
begin
  lClient := ClientByConnection(Connection);
  if assigned(lClient) then
    Connection.WriteData(aData);
end;

end.
