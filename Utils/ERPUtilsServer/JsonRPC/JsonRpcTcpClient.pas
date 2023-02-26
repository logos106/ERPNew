unit JsonRpcTcpClient;

interface

uses
  JsonRpcBase, IdTcpClient, extctrls, classes, JsonObject,
  sysutils, IdComponent;

type

  TJsonRpcTcpClient = class(TJsonRpcClient)
  private
    TCPClient: TIdTcpClient;
    Timer: TTimer;
    InStream: TMemoryStream;
    fTimerDisableCount: integer;
    procedure DoOnTimer(Sender: TObject);
    procedure DoOnConnected(Sender: TObject);
    procedure DoOnDisconnected(Sender: TObject);
    procedure DoOnStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
    function GetPort: integer;
    function GetServerName: string;
    procedure SetPort(const Value: integer);
    procedure SetServerName(const Value: string);
    procedure DisableTimer;
    procedure EnableTimer;
  protected
    function GetConnected: boolean; override;
    procedure SetConnected(const Value: boolean); override;
    procedure SendStream(stream: TStream); override;
    procedure DoRequest(obj: TJsonObject); override;
    function WaitOnResult: TJsonObject; override;
    function CheckForData: boolean; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    property ServerName: string read GetServerName write SetServerName;
    property Port: integer read GetPort write SetPort;
    function SendRequest(aMethodName: string; obj: TJsonObject; id: Integer = 0): TJsonObject;  override;
    function SendRequestRetry(aMethodName: string; obj: TJsonObject; id: integer = 0; RetryCount: integer = 3): TJsonObject;
  end;


implementation

uses
  JsonRpcConst{, LogThreadLib};

{ TJsonRpcTcpClient }

function TJsonRpcTcpClient.CheckForData: boolean;
begin
  result:= false;
  if (not self.Connected) and TCPClient.IOHandler.InputBufferIsEmpty then begin
    exit;
  end;

  try
    while not TCPClient.IOHandler.InputBufferIsEmpty do begin
      InStream.Clear;
      TCPClient.IOHandler.ReadStream(InStream);
      ReceiveStream(InStream);
    end;
  except
    on e: Exception do begin
      TCPClient.IOHandler.InputBuffer.Clear;
    end;
  end;
  result:= true;
end;

constructor TJsonRpcTcpClient.Create;
begin
  inherited;
  fTimerDisableCount := 0;
  TCPClient:= TIdTcpClient.Create(nil);
  TCPClient.OnConnected:= DoOnConnected;
  TCPClient.OnDisconnected:= DoOnDisconnected;
  TCPClient.OnStatus:= DoOnStatus;
  Timer:= TTimer.Create(nil);
  Timer.Enabled:= false;
  { NOTE: Do not make this to small (10ms was to small) else the timer
          adds messages to the windows message queue faster than they
          are processed!  }
  Timer.Interval:= 200;
  Timer.OnTimer:= DoOnTimer;
  InStream:= TMemoryStream.Create;
end;

destructor TJsonRpcTcpClient.Destroy;
begin
  Timer.Enabled:= false;
  Timer.Free;
  TCPClient.Free;
  InStream.Free;
  inherited;
end;

procedure TJsonRpcTcpClient.DisableTimer;
begin
  Inc(fTimerDisableCount);
//  if Assigned(Timer) then
//    Timer.Enabled:= fTimerDisableCount = 0;
end;

procedure TJsonRpcTcpClient.DoOnConnected(Sender: TObject);
begin
  if Assigned(fOnConnect) then
    fOnConnect(self);
  EnableTimer;
end;

procedure TJsonRpcTcpClient.DoOnDisconnected(Sender: TObject);
begin
  DisableTimer;
  if Assigned(fOnDisconnect) then
    fOnDisconnect(self);
end;

procedure TJsonRpcTcpClient.DoOnStatus(ASender: TObject;
  const AStatus: TIdStatus; const AStatusText: string);
begin
  if (fTimerDisableCount = 0) and (AStatus = hsDisconnected) then begin
    DoOnDisconnected(self);
  end;
//  with TStringList.Create do begin
//    try
//      if fileexists('c:\ERP Software\Utilities\Log\ConnectionStatus_Client.txt') then
//        LoadFromFile('c:\ERP Software\Utilities\Log\ConnectionStatus_Client.txt');
//      Add(AStatusText);
//
//      SaveToFile('c:\ERP Software\Utilities\Log\ConnectionStatus_Client.txt');
//    finally
//      Free;
//    end;
//  end;
end;

procedure TJsonRpcTcpClient.DoOnTimer(Sender: TObject);
begin
  if self.fTimerDisableCount > 0 then
    exit;
  DisableTimer;
  if not Connected then begin
    if Assigned(fOnDisconnect) then
      fOnDisconnect(self);
    exit;
  end;
  try
    CheckForData;
  finally
    if Connected then
      EnableTimer;
  end;
end;

procedure TJsonRpcTcpClient.DoRequest(obj: TJsonObject);
begin
  inherited;

end;

procedure TJsonRpcTcpClient.EnableTimer;
begin
  if fTimerDisableCount > 0 then
    Dec(fTimerDisableCount);
  if (fTimerDisableCount = 0) and Assigned(Timer) then begin
    if not Timer.Enabled then
      Timer.Enabled:= true;
  end;

//  if Assigned(Timer) then
//    Timer.Enabled:= fTimerDisableCount = 0;
end;

function TJsonRpcTcpClient.GetConnected: boolean;
begin
  try
    result:= TCPClient.Connected;
  except
    result:= false;
  end;
end;

function TJsonRpcTcpClient.GetPort: integer;
begin
  result:= Config.I['Port'];
end;

function TJsonRpcTcpClient.GetServerName: string;
begin
  result:= Config.S['ServerName'];
end;

function TJsonRpcTcpClient.SendRequest(aMethodName: String;
  obj: TJsonObject; id: integer = 0): TJsonObject;
begin
  DisableTimer;
  try
    Result := inherited SendRequest(aMethodName, obj, id);
  finally
    if Connected then
      EnableTimer;
  end;
end;

function TJsonRpcTcpClient.SendRequestRetry(aMethodName: string;
  obj: TJsonObject; id, RetryCount: integer): TJsonObject;
var
  x: integer;
begin
  result:= nil;
  for x := 0 to RetryCount -1 do begin
    result:= SendRequest(aMethodName,obj,id);
    if Assigned(result) then
      break;
  end;
end;

procedure TJsonRpcTcpClient.SendStream(stream: TStream);
begin
  inherited;
  TCPClient.IOHandler.Write(stream,0,true);
end;

procedure TJsonRpcTcpClient.SetConnected(const Value: boolean);
begin
  inherited;
  if Value then begin
    if TCPClient.Connected then exit;
    if Config.IntegerExists('Port') then
      TCPClient.Port:= Config.I['Port']
    else
      TCPClient.Port:= DEFAULT_TCP_PORT;
    if Config.StringExists('ServerName') then
      TCPClient.Host:= Config.S['ServerName']
    else
      TCPClient.Host:= '127.0.0.1';
    try
      TCPClient.Connect();
    except
    end;
  end
  else begin
    if not TCPClient.Connected then exit;
    TCPClient.Disconnect;
  end;
end;

procedure TJsonRpcTcpClient.SetPort(const Value: integer);
begin
  Config.I['Port']:= Value;
end;

procedure TJsonRpcTcpClient.SetServerName(const Value: string);
begin
  Config.S['ServerName']:= Value;
end;

function TJsonRpcTcpClient.WaitOnResult: TJsonObject;
begin
  DisableTimer;
  try
    result:= Inherited WaitOnResult;
  finally
    if self.Connected then
      EnableTimer;
  end;    
end;

end.
