unit JsonRpcTcpServer;

interface

uses
  JsonRpcBase, IdTcpServer, IdCustomTCPServer, IdContext, sysutils, classes;

type

//  TJsonRpcTcpServerConfig = class(TJsonRpcServerConfig)
//  private
//    fPort: integer;
//  public
//    constructor Create; override;
//  published
//    property Port: integer read fPort write fPort;
//  end;

  TJsonRpcTcpServer = class;
  TJsonRpcTcpServerClient = class;

  TJsonRpcTcpServerClientEvent = procedure (Server: TJsonRpcTcpServer;
             Client: TJsonRpcTcpServerClient) of object;

  TJsonRpcTcpServerException = procedure(AContext: TIdContext; AException: Exception) of object;

  TJsonRpcTcpServer = class(TJsonRpcServer)
  private
    TCPServer: TIdTcpServer;
    fOnConnect: TJsonRpcTcpServerClientEvent;
    fOnDisconnect: TJsonRpcTcpServerClientEvent;
    fOnServerException: TJsonRpcTcpServerException;
    procedure DoOnConnect(AContext: TIdContext);
    procedure DoOnDisconnect(AContext: TIdContext);
    procedure DoOnExecute(AContext: TIdContext);
    procedure DoOnException(AContext: TIdContext; AException: Exception);
  protected
    function GetActive: boolean; override;
    procedure SetActive(const Value: boolean); override;
  public
    constructor Create; override;
    destructor Destroy; override;
    property OnConnect: TJsonRpcTcpServerClientEvent read fOnConnect write fOnConnect;
    property OnDisconnect: TJsonRpcTcpServerClientEvent read fOnDisconnect write fOnDisconnect;
    function ClientByID(aClientId: integer): TJsonRpcTcpServerClient;
    function ClientByIndex(aIndex: integer): TJsonRpcTcpServerClient;
    property OnException: TJsonRpcTcpServerException read fOnServerException write fOnServerException;
  end;

  TJsonRpcTcpServerClient = class(TJsonRpcBase)
  private
//    fPeerThread: TIdPeerThread;
    fContext: TIdContext;
  protected
    procedure SendStream(stream: TStream); override;
    function CheckForData: boolean; override;
  public
    InStream: TMemoryStream;
    constructor Create; override;
    destructor Destroy; override;
//    property PeerThread: TIdPeerThread read fPeerThread write fPeerThread;
    property Context: TIdContext read fContext write fContext;
  end;

implementation

uses
  JsonRpcConst, LogThreadLib, forms;

{ TJsonRpcTcpServer }

function TJsonRpcTcpServer.ClientByID(
  aClientId: integer): TJsonRpcTcpServerClient;
var
  lst: TList;
  x: integer;
begin
  result:= nil;
  lst := TCPServer.Contexts.LockList;
  try
    for x := 0 to lst.Count -1 do begin
      if Integer(TIdContext(lst[x]).Data) = aClientId then begin
        result := TJsonRpcTcpServerClient(TIdContext(lst[x]).Data);
        break;
      end;
    end;
  finally
    TCPServer.Contexts.UnlockList;
  end;
end;

function TJsonRpcTcpServer.ClientByIndex(
  aIndex: integer): TJsonRpcTcpServerClient;
var
  lst: TList;
begin
  result := nil;
  lst := TCPServer.Contexts.LockList;
  try
    if aIndex < lst.Count then
      result := TJsonRpcTcpServerClient(TIdContext(lst[aIndex]).Data);
  finally
    TCPServer.Contexts.UnlockList;
  end;
end;

constructor TJsonRpcTcpServer.Create;
begin
  inherited;
  TCPServer:= TIdTcpServer.Create(nil);
  TCPServer.OnConnect:= DoOnConnect;
  TCPServer.OnDisconnect:= DoOnDisconnect;
  TCPServer.OnException:= DoOnException;
  TCPServer.OnExecute:= DoOnExecute;
end;

destructor TJsonRpcTcpServer.Destroy;
begin
  TCPServer.Free;
  inherited;
end;

procedure TJsonRpcTcpServer.DoOnConnect(AContext: TIdContext);
var
  client: TJsonRpcTcpServerClient;
begin
  client:= TJsonRpcTcpServerClient.Create;
  client.Context:= AContext;;
  AContext.Data:= client;
  if Assigned(fOnConnect) then
    fOnConnect(self, client);
  if Assigned(Client.OnConnect) then
    Client.OnConnect(client);
end;

procedure TJsonRpcTcpServer.DoOnDisconnect(AContext: TIdContext);
begin
  if Assigned(TJsonRpcTcpServerClient(AContext.Data).OnDisconnect) then
    TJsonRpcTcpServerClient(AContext.Data).OnDisconnect(TJsonRpcTcpServerClient(AContext.Data));
  if Assigned(fOnDisconnect) then
    fOnDisconnect(self,TJsonRpcTcpServerClient(AContext.Data));
end;

procedure TJsonRpcTcpServer.DoOnException(AContext: TIdContext;
  AException: Exception);
begin
  if Assigned(fOnServerException) then
    fOnServerException(AContext, AException);
end;

procedure TJsonRpcTcpServer.DoOnExecute(AContext: TIdContext);
var
  client: TJsonRpcTcpServerClient;
begin
  if AContext.Connection.Connected then begin
    if AContext.Connection.IOHandler.InputBufferIsEmpty then
      AContext.Connection.IOHandler.CheckForDataOnSource(10);
    if not AContext.Connection.IOHandler.InputBufferIsEmpty then begin

      client:= TJsonRpcTcpServerClient(AContext.Data);
      Client.InStream.Clear;
      AContext.Connection.IOHandler.ReadStream(Client.InStream);
      client.ReceiveStream(Client.InStream);
    end;
  end;
end;

function TJsonRpcTcpServer.GetActive: boolean;
begin
  result:= TCPServer.Active;
end;

procedure TJsonRpcTcpServer.SetActive(const Value: boolean);
begin
  inherited;
  if Value then begin
    if not Config.IntegerExists('Port') then Config.I['Port']:= DEFAULT_TCP_PORT;
    if not Config.IntegerExists('MaxConnectionCount') then Config.I['MaxConnectionCount']:= 0;

    TCPServer.DefaultPort:= Config.I['Port'];
    TCPServer.MaxConnections:= Config.I['MaxConnectionCount'];
  end;
  TCPServer.Active:= Value;
end;

{ TJsonRpcTcpServerClient }

function TJsonRpcTcpServerClient.CheckForData: boolean;
begin
  result:= false;
  if not Context.Connection.IOHandler.InputBufferIsEmpty then begin
    Context.Connection.IOHandler.ReadStream(InStream);
    if InStream.Size > 0 then begin
      ReceiveStream(InStream);
      result:= true;
    end;
  end;  
end;

constructor TJsonRpcTcpServerClient.Create;
begin
  inherited;
  InStream:= TMemoryStream.Create;
end;

destructor TJsonRpcTcpServerClient.Destroy;
begin
  InStream.Free;
  inherited;
end;

procedure TJsonRpcTcpServerClient.SendStream(stream: TStream);
begin
  inherited;
  Context.Connection.IOHandler.write(stream,0,true);
end;

end.

