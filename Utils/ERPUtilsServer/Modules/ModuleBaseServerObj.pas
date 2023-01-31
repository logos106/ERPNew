unit ModuleBaseServerObj;

interface

uses
  classes, ModuleBaseObj, syncobjs, JsonRpcBase, LogThreadLib, JsonObject;

type
  TModuleSessionType = (mstConfig, mstClient);
  TServerModuleStatus = (msStopped, msRunning, msStopping);

  TModuleSessionList = class;
  TRequestCount = class;
  TModuleBaseServer = class(TModuleBase)
  private
    fLock: TCriticalSection;
    fSessionList: TModuleSessionList;
    fStatus: TServerModuleStatus;
    function GetStatus: TServerModuleStatus;
  protected
    LoadingConfig: boolean;
    SavingConfig: boolean;
    RequestCount: TRequestCount;
    procedure SetModuleFileName(const Value: string); override;
    procedure SetStatus(Value: TServerModuleStatus);
  public
    constructor Create; override;
    destructor Destroy; override;
    property SessionList: TModuleSessionList read fSessionList write fSessionList;
    procedure Lock;
    procedure Unlock;
    procedure LoadConfig(encrypt: boolean = false); virtual;
    procedure SaveConfig(encrypt: boolean = false); virtual;
    procedure DoDisconnect(Client: TJsonRpcBase); override;
    procedure SendStatus(statusMessage: string);
    procedure SendEvent(const EventName, EventValue: string);
    function ServerBasePath: string;
    procedure Terminate; virtual;
    property Status: TServerModuleStatus read GetStatus write SetStatus;
  published
  end;

  TModuleSession = class(TObject)
  private
    fClient: TJsonRpcBase;
    FSessionList: TModuleSessionList;
    fSessionType: TModuleSessionType;
    procedure SetSessionList(const Value: TModuleSessionList);
  public
    property SessionList: TModuleSessionList read FSessionList write SetSessionList;
    property Client: TJsonRpcBase read fClient write fClient;
    property SessionType: TModuleSessionType read fSessionType write fSessionType;
    procedure DoRequest(RequestJson: TJsonObject; ResultJson: TJsonObject = nil); virtual;
  end;

  TModuleSessionList = class(TObject)
  private
    fList: TList;
    fLock: TCriticalSection;
    fModule: TModuleBaseServer;
    fConfigSessionCount,
    fClientSessionCount: integer;
  public
    constructor Create(aModule: TModuleBaseServer); virtual;
    destructor Destroy; override;
    property Module: TModuleBaseServer read fModule;
    function LockList: TList;
    procedure UnlockList;
    procedure AddSession(aSession: TModuleSession);
    procedure DeleteSession(aClient: TJsonRpcBase);
    function Count: integer;
    function Session(aClient: TJsonRpcBase): TModuleSession; virtual;
    procedure Clear;
    procedure LogEventHandler(Sender: TObject; const Event, Value: string);
//    procedure SendEvent(EventName, EventValue: string; ExcludeSession: TModuleSession = nil);
    function SendNotification(aSession: TModuleSession; MethodName: string; json: TJsonObject): boolean;
  end;

  TRequestCount = class
  private
    fLock: TCriticalSection;
    fCount: integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Inc;
    procedure Dec;
    function Count: integer;
  end;


implementation

uses
  sysutils, JsonToObject, windows, ModuleUtils, LogMessageTypes;

function GetModuleName: string;
var
  szFileName: array[0..MAX_PATH] of Char;
begin
  FillChar(szFileName, SizeOf(szFileName), #0);
  GetModuleFileName(hInstance, szFileName, MAX_PATH);
  Result := szFileName;
end;



{ TModuleBaseServer }

constructor TModuleBaseServer.Create;
begin
  inherited;
  fStatus:= msRunning;
  LoadingConfig:= false;
  SavingConfig:= false;
  fLock:= TCriticalSection.Create;
  fSessionList:= TModuleSessionList.Create(self);
  fModuleFileName:= GetModuleName;
  fModuleVersion:= GetFileVersion(fModuleFileName);
  RequestCount := TRequestCount.Create;
end;

destructor TModuleBaseServer.Destroy;
begin
  fSessionList.Free;
  fLock.Free;
  RequestCount.Free;
  inherited;
end;

procedure TModuleBaseServer.DoDisconnect(Client: TJsonRpcBase);
begin
  inherited;
  SessionList.DeleteSession(Client);
end;

function TModuleBaseServer.GetStatus: TServerModuleStatus;
begin
  fLock.Acquire;
  try
    result := fStatus;
  finally
    fLock.Release;
  end;
end;

procedure TModuleBaseServer.LoadConfig(encrypt: boolean = false);
var
  configFileName: string;
begin
  LoadingConfig:= true;
  try
    try
      configFileName:= ChangeFileExt(self.ModuleFileName, '_Config.cfg');
      FileToObj(configFileName, self, encrypt);
    except
      on e: exception do begin
        self.Logger.Log('Error reading config file: ' + e.Message,ltError);
        raise;
      end;
    end;
  finally
    LoadingConfig:= false;
  end;
end;

procedure TModuleBaseServer.Lock;
begin
  fLock.Acquire;
//  Logger.Log('Module: ' + self.ModuleName + ' Instance: ' + IntToStr(Integer(self)) + ' - Locked');
end;

procedure TModuleBaseServer.SaveConfig(encrypt: boolean = false);
var
  configFileName: string;
begin
  SavingConfig:= true;
  try
    configFileName:= ChangeFileExt(self.ModuleFileName, '_Config.cfg');
    ObjToFile(self, configFileName, encrypt);
  finally
    SavingConfig:= false;
  end;
end;

procedure TModuleBaseServer.SendEvent(const EventName, EventValue: string);
begin
  Logger.Events.FireEvent(nil,EventName,EventValue);
end;

procedure TModuleBaseServer.SendStatus(statusMessage: string);
begin
  Logger.Events.FireEvent(nil,'Status',statusMessage);
end;

function TModuleBaseServer.ServerBasePath: string;
begin
  result:= ExtractFileDrive(self.ModulePath) + '\ERP Software';
end;

procedure TModuleBaseServer.SetModuleFileName(const Value: string);
begin
  { overriden here to stop setting of fModuleFileName
    eg when loading self from config.
    fModuleFileName is set during self create. }

end;

procedure TModuleBaseServer.SetStatus(Value: TServerModuleStatus);
begin
  fLock.Acquire;
  try
    fStatus := Value;
  finally
    fLock.Release;
  end;
end;

procedure TModuleBaseServer.Terminate;
begin
  fLock.Acquire;
  try
    if not (fStatus in [msStopped,msStopping]) then
      fStatus := msStopping;
  finally
    fLock.Release;
  end;
end;

procedure TModuleBaseServer.Unlock;
begin
  fLock.Release;
//  Logger.Log('Module: ' + self.ModuleName + ' Instance: ' + IntToStr(Integer(self)) + ' - Unlocked');
end;

{ TModuleSession }

procedure TModuleSession.DoRequest(RequestJson, ResultJson: TJsonObject);
begin

end;

procedure TModuleSession.SetSessionList(const Value: TModuleSessionList);
begin
  FSessionList := Value;
end;

{ TModuleSessionList }

procedure TModuleSessionList.AddSession(aSession: TModuleSession);
var lst: TList;
begin
  lst:= LockList;
  try
    aSession.SessionList:= self;
    lst.Add(aSession);
    if aSession.SessionType = mstConfig then
      Inc(fConfigSessionCount)
    else
      Inc(fClientSessionCount);
  finally
    UnlockList;
  end
end;

procedure TModuleSessionList.Clear;
var lst: TList;
begin
  lst:= LockList;
  try
    while lst.Count > 0 do begin
      TModuleSession(lst[0]).Free;
      lst.Delete(0);
    end;
    fConfigSessionCount:= 0;
    fClientSessionCount:= 0;
  finally
    UnlockList;
  end
end;

function TModuleSessionList.Count: integer;
begin
  result:= fConfigSessionCount + fClientSessionCount;
end;

constructor TModuleSessionList.Create(aModule: TModuleBaseServer);
begin
  fLock:= TCriticalSection.Create;
  fModule:= aModule;
  fList:= TList.Create;
  fConfigSessionCount:= 0;
  fClientSessionCount:= 0;
  self.Module.Logger.Events.AddMultiEvent(LogEventHandler);
end;

procedure TModuleSessionList.DeleteSession(aClient: TJsonRpcBase);
var
  lst: TList;
  x: integer;
begin
  lst:= LockList;
  try
    for x:= 0 to lst.Count -1 do begin
      if TModuleSession(lst[x]).Client = aClient then begin
        if TModuleSession(lst[x]).SessionType = mstConfig then
          Dec(fConfigSessionCount)
        else
          Dec(fClientSessionCount);
        TModuleSession(lst[x]).Free;
        lst.Delete(x);
        break;
      end;
    end;
  finally
    UnlockList;
  end
end;

destructor TModuleSessionList.Destroy;
begin
  Module.Logger.Events.RemoveMultiEvent(LogEventHandler);
  Clear;
  fList.Free;
  fLock.Free;
  inherited;
end;

function TModuleSessionList.LockList: TList;
begin
  fLock.Acquire;
  result:= fList;
end;

procedure TModuleSessionList.LogEventHandler(Sender: TObject; const Event,
  Value: string);
var
  lst: TList;
  x: integer;
  Ses: TModuleSession;
  str: string;
begin
//  if fConfigSessionCount > 0 then begin
    str:= EncodeString(Value);
    lst:= LockList;
    try
      for x:= 0 to lst.Count -1 do begin
        ses:= TModuleSession(lst[x]);
//        if ses.SessionType = mstConfig then
          ses.Client.SendNotification('event',JO('{"eventname":"'+Event+'","value":"' + str +'"}'));
      end;
    finally
      UnlockList;
    end;
//  end;
end;

function TModuleSessionList.SendNotification(aSession: TModuleSession;
  MethodName: string; json: TJsonObject): boolean;
var
  lst: TList;
  x: integer;
begin
  result:= false;
  lst:= LockList;
  try
    for x:= 0 to lst.Count -1 do begin
      if TModuleSession(lst[x]) = aSession then begin
        try
          TModuleSession(lst[x]).Client.SendNotification(MethodName, json);
        except

        end;
        result:= true;
        break;
      end;
    end;
  finally
    UnlockList;
  end
end;

function TModuleSessionList.Session(aClient: TJsonRpcBase): TModuleSession;
var
  lst: TList;
  x: integer;
begin
  result:= nil;
  lst:= LockList;
  try
    for x:= 0 to lst.Count -1 do begin
      if TModuleSession(lst[x]).Client = aClient then begin
        result:= TModuleSession(lst[x]);
        break;
      end;
    end;
  finally
    UnlockList;
  end
end;

procedure TModuleSessionList.UnlockList;
begin
  fLock.Release;
end;

{ TRequestCount }

function TRequestCount.Count: integer;
begin
  fLock.Acquire;
  try
    result := fCount;
  finally
    fLock.Release;
  end;
end;

constructor TRequestCount.Create;
begin
  fLock := TCriticalSection.Create;
  fCount := 0;
end;

procedure TRequestCount.Dec;
begin
  fLock.Acquire;
  try
    System.Dec(fCount);
    if fCount < 0 then
      fCount := 0;
  finally
    fLock.Release;
  end;
end;

destructor TRequestCount.Destroy;
begin
  fLock.Free;
  inherited;
end;

procedure TRequestCount.Inc;
begin
  fLock.Acquire;
  try
    System.Inc(fCount);
  finally
    fLock.Release;
  end;
end;

end.
