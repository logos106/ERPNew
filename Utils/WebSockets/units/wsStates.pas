unit wsStates;

interface
uses
  contnrs, classes, sysutils,
  wsConsts, sgcWebSocket, sgcWebSocket_Classes;

type

  TwsConnectionState = class
  private
    fPassword: string;
    fUser: string;
    fSentRequest: TwsCommand;
    fLastCommand: TwsCommand;
  public
    property User : string read fUser write fUser;
    property Password : string read fPassword write fPassword;
    property LastCommand : TwsCommand read fLastCommand write fLastCommand;
    property SendRequest : TwsCommand read fSentRequest write fSentRequest;
  end;

  TwsClientRecord = class
  private
    fState: TwsConnectionState;
    fClient: TsgcWebSocketClient;
  public
    constructor Create(aClient : TsgcWebSocketClient; aState : TwsConnectionState);overload;
    destructor Destroy; override;
    property Client : TsgcWebSocketClient read fClient write fClient;
    property State : TwsConnectionState read fState write fState;
  end;

  TwsClientList = class(TObjectList)
  private
    function GetClient(idx: TsgcWSConnection): TwsClientRecord;
  public
    procedure DeleteClient(Connection : TsgcWSConnection);
    property Client[idx : TsgcWSConnection] : TwsClientRecord read GetClient;
  end;

  TwsQueueRecord = class
  private
    fConnection: TsgcWSConnection;
    fCommand: string;
    fDone: boolean;
    fStream: TMemoryStream;
  public
    constructor Create(aConnection : TsgcWSConnection; const aCommand : string);overload;
    constructor Create(aConnection : TsgcWSConnection; const aStream : TMemoryStream);overload;
    property Connection : TsgcWSConnection read fConnection write fConnection;
    property Command : string read fCommand write fCommand;
    property Stream : TMemoryStream read fStream write fStream;
    property Done : boolean read fDone write fDone;
  end;

  TwsQueue = class(TThreadList)
  private
    fCallBack: TMessageProc;
    fBlocked: boolean;

    procedure DoCallBack(const aStr : string);
  public
    destructor Destroy; override;
    procedure Execute(AConnection : TsgcWSConnection = nil);
    procedure Add(aConnection : TsgcWSConnection; const aCommand : string); overload;
    procedure Add(aConnection : TsgcWSConnection; AStream : TMemoryStream);overload;
    procedure Append(aQueue : TwsQueue; Unblock : boolean = true);
    function IsEmpty : boolean;
    function Count : integer;
    procedure Clear;
    // set to TRUE when created from Waiter - we cannot send messages until Tunnel is ready
    property Blocked : boolean read fBlocked write fBlocked;
    property OnCallBack : TMessageProc read fCallBack write fCallBack;
  end;

  TWaiterRecord = class
  private
    fConnection: TsgcWSConnection;
    fQueue: TwsQueue;
    function GetQueue: TwsQueue;
  public
    constructor Create(aConnection : TsgcWSConnection);
    destructor Destroy;override;
    property Connection : TsgcWSConnection read fConnection write fConnection;
    property Queue : TwsQueue read GetQueue write fQueue;
  end;

  TWaiterQueue = class//(TStringList)
  private
    fOnCallBack: TMessageProc;
    fList: TStringList;
    function GetWaiter(aConnection : TsgcWSConnection): TWaiterRecord;
    procedure SetWaiter(aConnection : TsgcWSConnection; const Value: TWaiterRecord);
    procedure DoCallBack(const aStr : string);
  protected
    property List : TStringList read fList write fList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Delete(aWaiter : TWaiterRecord);
    function Add(aConnection : TsgcWSConnection) : TWaiterRecord;overload;
    function WaiterByName(const aParam : string) : TWaiterRecord;
    property Waiter[aConnection : TsgcWSConnection] : TWaiterRecord read GetWaiter write SetWaiter;
    property OnCallBack : TMessageProc read fOnCallBack write fOnCallBack;
  end;

implementation

{ TwsClientRecord }

constructor TwsClientRecord.Create(aClient: TsgcWebSocketClient;
  aState: TwsConnectionState);
begin
  inherited Create;
  State := aSTate;
  Client := aClient;
end;

destructor TwsClientRecord.Destroy;
begin
  State.Free;
  inherited;
end;

{ TwsClientList }

procedure TwsClientList.DeleteClient(Connection: TsgcWSConnection);
var
  idx : integer;
begin
  for idx := 0 to Count - 1 do
    if TwsClientRecord(Items[idx]).Client.Connection.Guid = connection.Guid  then
    begin
    (*
      Result := TwsClientRecord(Items[i]);
      exit;
    *)
      Delete(idx);
      exit;
    end;
end;

function TwsClientList.GetClient(idx: TsgcWSConnection): TwsClientRecord;
var
  i : integer;
begin
  Result := nil;
  if (not assigned(idx)) or (Count = 0) then
    exit;

  for I := 0 to Count - 1 do
    if TwsClientRecord(Items[i]).Client.Connection.Guid = idx.Guid  then
    begin
      Result := TwsClientRecord(Items[i]);
      exit;
    end;
end;

{ TwsQueue }

procedure TwsQueue.Add(aConnection: TsgcWSConnection; const aCommand: string);
begin
  Add(TwsQueueRecord.Create(aConnection, aCommand));
  DoCallBack(Format('[QUEUE] Adding "%s" for %s', [aCommand, aConnection.Guid]));
  Execute;
end;

procedure TwsQueue.Add(aConnection: TsgcWSConnection; AStream: TMemoryStream);
begin
  Add(TwsQueueRecord.Create(aConnection, aStream));
  DoCallBack('[QUEUE] Adding Stream');
  Execute;
end;

procedure TwsQueue.Append(aQueue: TwsQueue; Unblock : boolean = true);
var
  lExtra,
  lMine : TList;
  idx : integer;
begin
  if not assigned(aQueue) then
    exit;
  lExtra := aQueue.LockList;
  try
    if lExtra.Count = 0 then
      exit;
    lMine := LockList;
    try
    (*
      while lExtra.Count > 0  do
      begin
        lMine.Add(lExtra[lExtra.Count - 1]);
        lExtra.Delete(lExtra.Count - 1);
      end;
    *)
      for idx := 0 to lExtra.Count - 1 do
        lMine.Add(lExtra[idx]);
      lExtra.Clear;
    finally
      UnlockList;
    end;
  finally
    aQueue.UnlockList;
  end;

end;

procedure TwsQueue.Clear;
var
  lList : TList;
  idx : integer;
begin
  lList := LockList;
  try
    for idx := lList.Count - 1 downto 0 do
      TwsQueueRecord(lList.Items[idx]).Free;
    lList.Clear;
  finally
    UnlockList;
  end;
end;

function TwsQueue.Count: integer;
begin
  with LockList do
    Result := Count;
  UnlockList;
end;

destructor TwsQueue.Destroy;
begin
  Clear;
  inherited;
end;

procedure TwsQueue.DoCallBack(const aStr: string);
begin
  if assigned(OnCallBack) then
    OnCallBack(aStr);
end;

procedure TwsQueue.Execute(AConnection : TsgcWSConnection = nil);
var
  idx : integer;
  lConnection : TsgcWSConnection;
  lRec : TwsQueueRecord;
  lList : TList;
begin
  if Blocked then
  begin
    OnCallBack('[QUEUE] : Queue blocked on Execution');
    exit;
  end;
  lList := LockList;
  try
    if lList.Count > 0 then
      DoCallBack('[QUEUE] Executing with ' + IntToStr(lList.Count) + ' messages');
    for idx := 0 to lList.Count - 1 do
    begin
      lRec := TwsQueueRecord(lList.Items[idx]);
      if lRec.Done then
        Continue;
      if not assigned(AConnection) then
        lConnection := lRec.Connection
      else
        lConnection := AConnection;
      if not assigned(lConnection) then
        lRec.Done := true
      else if (lConnection.Enabled) then
      begin
        if lRec.Stream <> nil then
        begin
          DoCallBack('[QUEUE] Sending stream');
          lConnection.WriteData(lRec.Stream)
        end
        else
        begin
          DoCallBack(Format('[QUEUE] Sending Message "%s" to %s', [lRec.Command, lConnection.Guid]));
          lConnection.WriteData(lRec.Command);
        end;
        lRec.Done := true;
      end;
    end;

    for idx := lList.Count - 1 downto 0 do
      if TwsQueueRecord(lList.Items[idx]).Done then
      begin
        TwsQueueRecord(lList.Items[idx]).Free;
        lList.Delete(idx);
      end;
  finally
    UnlockList;
  end;
end;

function TwsQueue.IsEmpty: boolean;
begin
  with LockList do
    Result := Count = 0;
  unlocklist;
end;

{ TwsQueueRecord }

constructor TwsQueueRecord.Create(aConnection: TsgcWSConnection;
  const aCommand: string);
begin
  inherited Create;
  Connection := aConnection;
  Command := aCommand;
  Stream := nil;
  Done := false;
end;

constructor TwsQueueRecord.Create(aConnection: TsgcWSConnection;
  const aStream: TMemoryStream);
begin
  inherited Create;
  Connection := aConnection;
  Command := '';
  Stream := aStream;
  Done := false;
end;

{ TWaiterQueue }

function TWaiterQueue.Add(aConnection: TsgcWSConnection) : TWaiterRecord;
var
  idx : integer;
begin
  idx := List.AddObject(AConnection.Guid, TWaiterRecord.Create(AConnection));
  Result := TWaiterRecord(List.Objects[idx]);
  Result.Queue.OnCallBack := OnCallBack;
  Result.Queue.Blocked := true;
  DoCallBack('[WAITER] Added ' + aConnection.GUID);
end;

constructor TWaiterQueue.Create;
begin
  inherited;
  List := TStringList.Create;
  List.CaseSensitive := false;
  List.Sorted := true;
end;

procedure TWaiterQueue.Delete(aWaiter: TWaiterRecord);
var
  idx : integer;
begin
  for idx := 0 to List.Count - 1 do
  begin
    if TWaiterRecord(List.Objects[idx]).Connection.Guid = aWaiter.Connection.Guid then
    begin
      List.Delete(idx);
      exit;
    end;

  end;
end;

destructor TWaiterQueue.Destroy;
//var
//  idx : integer;
begin
//  for idx := 0 to Count - 1 do
  List.Free;
  inherited;
end;

procedure TWaiterQueue.DoCallBack(const aStr: string);
begin
  if assigned(OnCallBack) then
    OnCallBack(aStr);
end;

function TWaiterQueue.GetWaiter(aConnection : TsgcWSConnection): TWaiterRecord;
var
  idx : integer;
  s : string;
begin
  Result := nil;
  s := '[WAITER] Asking for ' + AConnection.Guid;
  idx := List.IndexOf(aConnection.guid);
  if idx >= 0  then
  begin
    Result := TWaiterRecord(List.Objects[idx]);
    DoCallBack(s + ' - found');
  end
  else
    DoCallBack(s + ' - not found');
end;

procedure TWaiterQueue.SetWaiter(aConnection : TsgcWSConnection; const Value: TWaiterRecord);
begin
// ??
end;

function TWaiterQueue.WaiterByName(const aParam: string): TWaiterRecord;
var
  idx : integer;
begin
  idx  := List.IndexOf(aParam);
  if idx >= 0 then
    Result := TWaiterRecord(List.Objects[idx])
  else
    Result := nil;
end;

{ TWaiterRecord }

constructor TWaiterRecord.Create(aConnection: TsgcWSConnection);
begin
  inherited Create;
  Connection := aConnection;
end;

destructor TWaiterRecord.Destroy;
begin
  fQueue.Free;
  inherited;
end;

function TWaiterRecord.GetQueue: TwsQueue;
begin
  if not assigned(fQueue) then
    fQueue := TwsQueue.Create;
  Result := fQueue;
end;

end.
