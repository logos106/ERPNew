unit SessionListObj;

interface

uses
  classes, JsonRpcBase, JsonObject, LogThreadLib, SyncObjs;

type

  TSession = class(TObject)
  private
    fClient: TJsonRpcBase;
    fLogger: TLogger;
  public
    property Client: TJsonRpcBase read fClient write fClient;
    procedure DoRequest(RequestJson: TJsonObject; ResultJson: TJsonObject = nil); virtual;
    property Logger: TLogger read fLogger write fLogger;
  end;

  TSessionList = class(TObject)
  private
    fLogger: TLogger;
    fList: TList;
    fLock: TCriticalSection;
  public
    constructor Create(aLogger: TLogger = nil); virtual;
    destructor Destroy; override;
    function LockList: TList;
    procedure UnlockList;
    property Logger: TLogger read fLogger write fLogger;
    procedure AddSession(aSession: TSession);
    procedure DeleteSession(aClient: TJsonRpcBase);
    function Count: integer;
    function Session(aClient: TJsonRpcBase): TSession; virtual;
    procedure Clear;
  end;

implementation

{ TSession }

procedure TSession.DoRequest(RequestJson: TJsonObject; ResultJson: TJsonObject = nil);
begin
//  Logger.Log('TSession.DoRequest:');
//  Logger.Log(RequestJson.AsString);

end;

{ TSessionList }

procedure TSessionList.AddSession(aSession: TSession);
var lst: TList;
begin
  lst:= LockList;
  try
    lst.Add(aSession);
    if not Assigned(aSession.Logger) then
      aSession.Logger:= self.fLogger;
  finally
    UnlockList;
  end
end;

procedure TSessionList.Clear;
var lst: TList;
begin
  lst:= LockList;
  try
    while lst.Count > 0 do begin
      TSession(lst[0]).Free;
      lst.Delete(0);
    end;
  finally
    UnlockList;
  end
end;

function TSessionList.Count: integer;
var lst: TList;
begin
  lst:= LockList;
  try
    result:= lst.Count;
  finally
    UnlockList;
  end
end;

constructor TSessionList.Create(aLogger: TLogger);
begin
  fLock:= TCriticalSection.Create;
  fLogger:= aLogger;
  fList:= TList.Create;
end;

procedure TSessionList.DeleteSession(aClient: TJsonRpcBase);
var
  lst: TList;
  x: integer;
begin
  lst:= LockList;
  try
    for x:= 0 to lst.Count -1 do begin
      if Tsession(lst[x]).Client = aClient then begin
        Tsession(lst[x]).Free;
        lst.Delete(x);
        break;
      end;
    end;
  finally
    UnlockList;
  end
end;

destructor TSessionList.Destroy;
begin
  Clear;
  fLock.Free;
  fList.Free;
  inherited;
end;

function TSessionList.LockList: TList;
begin
  fLock.Acquire;
  result:= fList;
end;

function TSessionList.Session(aClient: TJsonRpcBase): TSession;
var
  lst: TList;
  x: integer;
begin
  result:= nil;
  lst:= LockList;
  try
    for x:= 0 to lst.Count -1 do begin
      if Tsession(lst[x]).Client = aClient then begin
        result:= Tsession(lst[x]);
        break;
      end;
    end;
  finally
    UnlockList;
  end
end;

procedure TSessionList.UnlockList;
begin
  fLock.Release;
end;

end.
