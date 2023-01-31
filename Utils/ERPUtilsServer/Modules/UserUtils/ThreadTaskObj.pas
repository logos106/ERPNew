unit ThreadTaskObj;

interface

uses
  Classes, SyncObjs, ModuleBaseServerObj, JsonObject, LogMessageTypes;

type
  TTaskStatus = (tsRunning, tsStopping, tsStopped);

  TThreadTaskList = class
  private
    fLastTaskID: integer;
    fServerModule: TModuleBaseServer;
  public
    ThreadList: TThreadList;
    constructor Create(ServerModule: TModuleBaseServer);
    destructor Destroy; override;
    { returns ID of created task }
    function StartTask(aThreadTaskName, Params: string; Session: TModuleSession = nil): integer;
    procedure RemoveTask(aTaskId: integer);
    procedure TerminateTasks;
    function GetTaskStatus(const aTaskId: integer; var aFinished, aWasError: boolean; var aStartTime, aFinishTime: TDateTime; var aStatusMessage: string): boolean;
  end;

  TThreadTaskBase = class(TThread)
  private
    fTaskStatus: TTaskStatus;
    function GetFinished: boolean;
    function GetTaskStatus: TTaskStatus;
    procedure SetTaskStatus(const Value: TTaskStatus);
  protected
    fLock: TCriticalSection;
    fTaskID: integer;
    fParams: TJsonObject;
    fStartTime: TDateTime;
    fWasError: boolean;
    fStatusMessage: string;
    fFinishTime: TDateTime;
    fSession: TModuleSession;
    fServerModule: TModuleBaseServer;
    procedure DoWork; virtual;
    procedure Execute; override;
    procedure UpdateStatus(aMessage: string);
    procedure Log(msg: string; LogType: TLogMessageType);
  public
    constructor Create(ParamsStr: string; aTaskID: integer; aSession: TModuleSession; aServerModule: TModuleBaseServer);
    destructor Destroy; override;
    procedure Lock;
    procedure Unlock;
    property TaskId: integer read fTaskId;
    property StartTime: TDateTime read fStartTime;
    property FinishTime: TDateTime read fFinishTime;
    property Finished: boolean read GetFinished;
    property WasError: boolean read fWasError;
    property StatusMessage: string read fStatusMessage;
    property TaskStatus: TTaskStatus read GetTaskStatus write SetTaskStatus;
    procedure TerminateTask;
  end;

const
  DB_BACKUP_TASK = 'DbBackupTask';
  BATCH_UPDATE_TASK = 'BatchUpdateTaskTask';
  EMAIL_TASK = 'EmailTask';

implementation

uses
  sysutils, BackupThreadTaskObj, BatchUpdateThreadTAskObj;

{ TThreadTaskList }

constructor TThreadTaskList.Create(ServerModule: TModuleBaseServer);
begin
  fLastTaskID:= 0;
  fServerModule:= ServerModule;
  ThreadList:= TThreadList.Create;
end;

destructor TThreadTaskList.Destroy;
begin
  ThreadList.Free;
  inherited;
end;

function TThreadTaskList.GetTaskStatus(const aTaskId: integer; var aFinished,
  aWasError: boolean; var aStartTime, aFinishTime: TDateTime;
  var aStatusMessage: string): boolean;
var
  Task: TThreadTaskBase;
  Lst: TList;
  x: integer;
begin
  result:= false;
  aFinished:= true;
  aWasError:= false;
  aStartTime:= 0;
  aFinishTime:= 0;
  aStatusMessage:= '';
  Lst:= ThreadList.LockList;
  try
    for x := 0 to Lst.Count -1 do begin
      Task:= Lst.Items[x];
      if Task.TaskId = aTaskID then begin
        Task.Lock;
        try
          aFinished:= Task.Finished;
          aWasError:= Task.WasError;
          aStartTime:= Task.StartTime;
          aFinishTime:= Task.FinishTime;
          aStatusMessage:= Task.StatusMessage;
        finally
          Task.Unlock;
        end;
        result:= true;
        exit;
      end;
    end;
  finally
    ThreadList.UnlockList;
  end;
end;

procedure TThreadTaskList.RemoveTask(aTaskId: integer);
var
  Task: TThreadTaskBase;
  Lst: TList;
  x: integer;
begin
  Lst:= ThreadList.LockList;
  try
    for x := 0 to Lst.Count -1 do begin
      Task:= Lst.Items[x];
      if Task.TaskId = aTaskID then begin
        Task.Free;
        Lst.Delete(x);
        exit;
      end;
    end;
  finally
    ThreadList.UnlockList;
  end;
end;

function TThreadTaskList.StartTask(aThreadTaskName, Params: string;
  Session: TModuleSession): integer;
var
  Task: TThreadTaskBase;
  Lst: TList;
begin
  result:= 0;
  if (aThreadTaskName = DB_BACKUP_TASK) or (aThreadTaskName = BATCH_UPDATE_TASK) then begin
    Lst:= ThreadList.LockList;
    try
      Inc(fLastTaskID);
      Task := nil;
      if aThreadTaskName = DB_BACKUP_TASK then
        Task:= TBackupThreadTask.Create(Params,fLastTaskID,Session,fServerModule)
      else if aThreadTaskName = BATCH_UPDATE_TASK then
        Task:= TBatchUpdateThreadTask.Create(Params,fLastTaskID,Session,fServerModule);
      if Assigned(Task) then
        Lst.Add(Task);
      result:= fLastTaskID;
    finally
      ThreadList.UnlockList;
    end;
  end;
end;

procedure TThreadTaskList.TerminateTasks;
var
  Task: TThreadTaskBase;
  Lst: TList;
  x: integer;
  dt: TDateTime;
const
  OneSec = 1/24/60/60;
begin
  Lst:= ThreadList.LockList;
  try
    for x := 0 to Lst.Count -1 do begin
      Task:= Lst.Items[x];
      Task.TerminateTask;
    end;
    x := 0;
    while x < Lst.Count do begin
      dt := now + (30 * OneSec);
      Task:= Lst.Items[x];
      while (Task.TaskStatus <> tsStopped) and (now  <= dt) do
        Sleep(20);
      if Task.TaskStatus = tsStopped then
        Lst.Delete(x)
      else
        Inc(x);
    end;
  finally
    ThreadList.UnlockList;
  end;
end;

{ TThreadTaskBase }

constructor TThreadTaskBase.Create(ParamsStr: string; aTaskID: integer;
  aSession: TModuleSession; aServerModule: TModuleBaseServer);
begin
  inherited Create(true);
  fTaskStatus := tsRunning;
  FreeOnTerminate:= false;
  fLock:= TCriticalSection.Create;
  fTaskID:= aTaskId;
  fParams:= TJsonObject.Create;
  fParams.AsString:= ParamsStr;
  fFinishTime:= 0;
  fStartTime:= now;
  fWasError:= false;
  fStatusMessage:= '';
  fSession:= aSession;
  fServerModule:= aServerModule;
  Priority:= tpLower;
  {$WARNINGS OFF}
  Resume;
  {$WARNINGS ON}
end;

destructor TThreadTaskBase.Destroy;
begin
  fParams.Free;
  fLock.Free;
  inherited;
end;

procedure TThreadTaskBase.DoWork;
begin
end;

procedure TThreadTaskBase.Execute;
begin
  try
    inherited;
    if not Terminated then begin
      try
        DoWork;
      except
        on e: Exception do begin
        Lock;
        fWasError:= true;
        UnLock;
          if Assigned(fServerModule) then
            fServerModule.Logger.Log(self.ClassName + ' Exception: ' + e.Message,ltError);
        end;
      end;
    end;
  except
    on e: Exception do begin
      Lock;
      fWasError:= true;
      UnLock;
      if Assigned(fServerModule) then
        fServerModule.Logger.Log(self.ClassName + ' Exception: ' + e.Message,ltError);
    end;
  end;
  Lock;
  fFinishTime:= now;
  fTaskStatus := tsStopped;
  UnLock;
end;

function TThreadTaskBase.GetFinished: boolean;
begin
  result:= FinishTime >= StartTime;
end;

function TThreadTaskBase.GetTaskStatus: TTaskStatus;
begin
  Lock;
  try
    result := fTaskStatus;
  finally
    Unlock;
  end;
end;

procedure TThreadTaskBase.Lock;
begin
  fLock.Acquire;
end;

procedure TThreadTaskBase.Log(msg: string; LogType: TLogMessageType);
begin
  if Assigned(fServerModule) then
    fServerModule.Logger.Log(msg, LogType);
end;

procedure TThreadTaskBase.SetTaskStatus(const Value: TTaskStatus);
begin
  Lock;
  try
    fTaskStatus:= value;
  finally
    Unlock;
  end;
end;

procedure TThreadTaskBase.TerminateTask;
begin
  Lock;
  try
    if fTaskStatus = tsRunning then
      fTaskStatus := tsStopping;
  finally
    Unlock;
  end;
end;

procedure TThreadTaskBase.Unlock;
begin
  fLock.Release;
end;

procedure TThreadTaskBase.UpdateStatus(aMessage: string);
var
  json: TJsonObject;
begin
  Lock;
  self.fStatusMessage:= aMessage;
  Unlock;
  try
    if Assigned(fServerModule) and Assigned(fSession) then begin
      json:= TJsonObject.Create;
      json.AsString:= aMessage;
      json.I['TaskId']:= fTaskID;
      fServerModule.SendEvent('Progress',json.AsString);
    end;
  except

  end;
end;

end.
