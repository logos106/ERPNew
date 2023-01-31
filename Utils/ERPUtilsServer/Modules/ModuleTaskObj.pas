unit ModuleTaskObj;

interface

uses
  classes, JsonObject, SyncObjs;

type

  TModuleTaskStatus = (tsNone, tsWaiting, tsStarted, tsComplete, tsFailed);

  TModuleTask = class(TCollectionItem)
  private
    FTaskName: string;
    FStartTime: TDateTime;
    FEndTime: TDateTime;
    FDueTime: TDateTime;
    FStatus: TModuleTaskStatus;
//    FClient: TObject;
    fLock: TCriticalSection;
    FMaxDuration: TDateTime;
//    procedure SetClient(const Value: TObject);
    procedure SetDueTime(const Value: TDateTime);
    procedure SetEndTime(const Value: TDateTime);
    procedure SetMessageText(const Value: string);
    procedure SetParamsText(const Value: string);
    procedure SetStartTime(const Value: TDateTime);
    procedure SetStatus(const Value: TModuleTaskStatus);
    procedure SetTaskName(const Value: string);
    function GetMessageText: string;
    function GetParamsText: string;
    procedure SetMaxDuration(const Value: TDateTime);
  public
    MessageList: TStringList;
    Params: TJsonObject;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Lock;
    procedure Unlock;
    function Duration: TDateTime;
    function OverTime: boolean;
  published
    TaskThread: TThread;
    property TaskName: string read FTaskName write SetTaskName;
//    property Client: TObject read FClient write SetClient;
    property Status: TModuleTaskStatus read FStatus write SetStatus;
    property DueTime: TDateTime read FDueTime write SetDueTime;
    property StartTime: TDateTime read FStartTime write SetStartTime;
    property EndTime: TDateTime read FEndTime write SetEndTime;
    property MessageText: string read GetMessageText write SetMessageText;
    property ParamsText: string read GetParamsText write SetParamsText;
    property MaxDuration: TDateTime read FMaxDuration write SetMaxDuration;
  end;

  TModuleTaskList = class(TCollection)
  private
    Module: TObject;
    fLock: TCriticalSection;
    function GetItem(idx: integer): TModuleTask;
  public
    constructor Create(aModule: TObject);
    destructor Destroy; override;
    function Add: TModuleTask;
    property Items[idx: integer]: TModuleTask read GetItem; default;
    procedure Lock;
    procedure UnLock;
  end;


implementation

uses
  sysutils;

{ TModuleTask }

constructor TModuleTask.Create(Collection: TCollection);
begin
  inherited;
  fLock:= TCriticalSection.Create;
  MessageList:= TStringList.Create;
  Params:= TJsonObject.Create;
  FStatus:= tsNone;
  FMaxDuration:= (1/24/60) * 30; { default to 30 mins }
  FStartTime:= 0;
  FEndTime:= 0;
  FDueTime:= 0;
end;

destructor TModuleTask.Destroy;
begin
  TaskThread.Free;
  MessageList.Free;
  Params.Free;
  fLock.Free;
  inherited;
end;

function TModuleTask.Duration: TDateTime;
begin
  result:= 0;
  if FStartTime > 0 then begin
    if fEndTime > 0 then
      result:= fEndTime - fStartTime
    else
      result:= now - fStartTime;  
  end;
end;

function TModuleTask.GetMessageText: string;
begin
  result:= MessageList.Text;
end;

function TModuleTask.GetParamsText: string;
begin
  result:= Params.AsString;
end;

procedure TModuleTask.Lock;
begin
 fLock.Acquire;
end;

function TModuleTask.OverTime: boolean;
begin
  result:= false;
  if (fMaxDuration > 0) and (Duration > 0) then
    result:= Duration > (fStartTime + fMaxDuration);
end;

//procedure TModuleTask.SetClient(const Value: TObject);
//begin
//  FClient := Value;
//end;

procedure TModuleTask.SetDueTime(const Value: TDateTime);
begin
  FDueTime := Value;
end;

procedure TModuleTask.SetEndTime(const Value: TDateTime);
begin
  FEndTime := Value;
end;

procedure TModuleTask.SetMaxDuration(const Value: TDateTime);
begin
  FMaxDuration := Value;
end;

procedure TModuleTask.SetMessageText(const Value: string);
begin
  MessageList.Text := Value;
end;

procedure TModuleTask.SetParamsText(const Value: string);
begin
  Params.AsString := Value;
end;

procedure TModuleTask.SetStartTime(const Value: TDateTime);
begin
  FStartTime := Value;
end;

procedure TModuleTask.SetStatus(const Value: TModuleTaskStatus);
begin
  FStatus := Value;
end;

procedure TModuleTask.SetTaskName(const Value: string);
begin
  FTaskName := Value;
end;

procedure TModuleTask.Unlock;
begin
  fLock.Release;
end;

{ TModuleTaskList }

function TModuleTaskList.Add: TModuleTask;
begin
  result:= TModuleTask(inherited Add);
end;

constructor TModuleTaskList.Create(aModule: TObject);
begin
  inherited Create(TModuleTask);
  Module:= aModule;
  fLock:= TCriticalSection.Create;
end;

destructor TModuleTaskList.Destroy;
begin
  fLock.Free;
  inherited;
end;

function TModuleTaskList.GetItem(idx: integer): TModuleTask;
begin
  result:= TModuleTask(inherited Items[idx]);
end;

procedure TModuleTaskList.Lock;
begin
  fLock.Acquire;
end;

procedure TModuleTaskList.UnLock;
begin
  fLock.Release;
end;

end.
