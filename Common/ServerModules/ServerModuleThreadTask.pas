unit ServerModuleThreadTask;

interface

uses
  classes, ThreadProperty, JsonObject, LogMessageTypes, SyncObjs,
  utDbServerThreadTaskList;

type
{$M+}

  TServerModuleThreadTask = class;
  TServerModuleThreadTaskClass = class of TServerModuleThreadTask;
  TServerModuleTaskList = class
  private
    fList: TThreadList;
    fLastTaskID: integer;
    fServerModule: TObject;
    Lock: TCriticalSection;
    procedure DoOnTreadTerminate(Sender: TObject);
    procedure DoOnThreadNotification(aClientId: integer; aNotificationName, aNotificationData: string);
    procedure DoOnThreadLog(const msg: string; const LogMessageType: TLogMessageType);
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltNone);
    function GetCount: integer;
    procedure LogCurrentTasks;
  public
    constructor Create(aServerModule: TObject);
    destructor Destroy; override;
    function AddTask(aThreadTask: TServerModuleThreadTask; aClientId: integer; aParams: TJsonObject; aMySQLServer: string): string; { returns task Id }
    function StartTask(ThreadTaskClass: TServerModuleThreadTaskClass;
      aClientId: integer; aParams: TJsonObject; aMySQLServer: string; NewInstance: boolean = false;
      aSingleInstance: boolean = false): string; { returns task Id }
    procedure RemoveTask(aTaskId: string); overload;
//    procedure RemoveTask(aTaskClassName: string); overload;
    procedure RemoveCompleteTasks;
    function GetTaskStatus(const aTaskId: string; var aFinished: boolean; var aStartTime: TDateTime; var aStatusMessage: string): boolean;
    procedure GetTaskListAsJson(json: TJsonObject);
    function ListContainsTask(const aTaskClassName: string): boolean;
    property Count: integer read GetCount;
  end;

  TThreadTaskNotificationEvent = procedure (aClientId: integer; aNotificationName, aNotificationData: string) of object;
  TThreadTaskLogEvent = procedure (const msg: string; const LogMessageType: TLogMessageType) of object;

  TServerModuleThreadTask = class(TThread)
  private
    TaskIdProp: TThreadProperty;
    StartTimeProp: TThreadProperty;
    ProgressTimeProp: TThreadProperty;
    StatusMessageProp: TThreadProperty;
    ClientIdProp: TThreadProperty;
    MySQLServerProp: TThreadProperty;
    fCompleteProp: TThreadProperty;
    fRemoveWhenCompleteProp: TThreadProperty;
    fParams: TJsonObject;
    fOnNotification: TThreadTaskNotificationEvent;
    fOnLog: TThreadTaskLogEvent;
    fName: string;

//    DbTaskList: TDBServerThreadTaskList;
    function GetStartTime: TDateTime;
    function GetStatusMessage: string;
    function GetTaskId: string;
    procedure SetStartTime(const Value: TDateTime);
    procedure SetStatusMessage(const Value: string);
    procedure SetTaskId(const Value: string);
    function GetClientId: integer;
    procedure SetClientId(const Value: integer);
    function GetComplete: boolean;
    procedure SetComplete(const Value: boolean);
    function GetRemoveWhenComplete: boolean;
    procedure SetRemoveWhenComplete(const Value: boolean);
    function GetProgressTime: TDateTime;
    procedure SetProgressTime(const Value: TDateTime);
    function GetMySQLServer: string;
    procedure SetMySQLServer(const Value: string);
  protected
    CommonConfig: TJsonObject;
    procedure SetParams(const Value: TJsonObject); virtual;
    procedure SendNotification(aNotificationName, aNotificationData: string);
    procedure NotifyTask;
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltNone); virtual;
    procedure UpdateStatus(aJsonMessage: string);
    procedure DoWork; virtual; abstract;
    procedure Execute; override;
  public
    ServerModule: TObject;
    constructor Create; virtual;
    destructor Destroy; override;
    property Params: TJsonObject read fParams write SetParams;
    //property FinishTime: TDateTime read fFinishTime;
    //property Finished: boolean read GetFinished;
    //property WasError: boolean read fWasError;
    //property TaskStatus: TTaskStatus read GetTaskStatus write SetTaskStatus;
    property OnNotification: TThreadTaskNotificationEvent read fOnNotification write fOnNotification;
    property OnLog: TThreadTaskLogEvent read fOnLog write fOnLog;
  published
    property Name: string read fName write fName;
    property StatusMessage: string read GetStatusMessage write SetStatusMessage;
    property RemoveWhenComplete: boolean read GetRemoveWhenComplete write SetRemoveWhenComplete;
    property ProgressTime: TDateTime read GetProgressTime write SetProgressTime;
    property Complete: boolean read GetComplete write SetComplete;
    property TaskId: string read GetTaskId write SetTaskId;
    property ClientID: integer read GetClientId write SetClientId;
    property StartTime: TDateTime read GetStartTime write SetStartTime;
    property MySQLServer: string read GetMySQLServer write SetMySQLServer;
  end;

//  TEventNotificationSender = class(TThread)
//  private
//  public
//    constructor Create(aTask: TServerModuleThreadTask);
//  end;

{$M-}

implementation

uses
  {$IfDef VER220}
  SysUtils,
  Windows,
  {$Else}
  System.SysUtils,
  WinApi.Windows,
  {$EndIf}
  ServerModuleObj, Character, JsonToObject, ModuleFileNameUtils;

{ TServerModuleTaskList }
function TServerModuleTaskList.AddTask(aThreadTask: TServerModuleThreadTask;
  aClientId: integer; aParams: TJsonObject; aMySQLServer: string): string;
//var
//  lst: TList;
begin
  Log('Server Module Task List - Creating task: ' + aThreadTask.Name,ltDetail);
//  lst := fList.LockList;
//  try
    Inc(fLastTaskID);
    aThreadTask.TaskId := IntToStr(integer(self.fServerModule)) + '-' + IntToStr(fLastTaskID);
    aThreadTask.ClientID := aClientId;
    aThreadTask.MySQLServer := aMySQLServer;
    aThreadTask.Params := aParams;
    aThreadTask.StartTime := now;
    aThreadTask.OnNotification := DoOnThreadNotification;
    aThreadTask.OnLog := DoOnThreadLog;
    aThreadTask.OnTerminate := DoOnTreadTerminate;
    aThreadTask.ServerModule := fServerModule;
//    lst.Add(aThreadTask);
    fList.Add(aThreadTask);
    result:= aThreadTask.TaskId;
    aThreadTask.Start;
    LogCurrentTasks;
//  finally
//    fList.UnlockList;
//  end;
end;

function TServerModuleTaskList.StartTask(ThreadTaskClass: TServerModuleThreadTaskClass;
  aClientId: integer; aParams: TJsonObject; aMySQLServer: string; NewInstance: boolean;
  aSingleInstance: boolean): string;
var
  aThreadTask, task: TServerModuleThreadTask;
  lst: TList;
  x: integer;
begin
  result := '';
  if aSingleInstance then begin
    { try and find existing task .. }
    lst := fList.LockList;
    try
      for x := 0 to lst.Count - 1 do begin
        task := lst[x];
        if SameText(task.ClassName, ThreadTaskClass.ClassName) then begin
          { task already in list }
          exit;
        end;
      end;
    finally
      fList.UnlockList;
    end;
  end;
  if NewInstance then begin
    aThreadTask := ThreadTaskClass.Create;
    Log('Server Module Task List - Starting task: ' + aThreadTask.Name,ltDetail);
    result := AddTask(aThreadTask, aClientId, aParams, aMySQLServer);
  end
  else begin
    aThreadTask := nil;
    { try and find existing task .. }
    lst := fList.LockList;
    try
      for x := 0 to lst.Count -1 do begin
        task := lst[x];
        if SameText(task.ClassName, ThreadTaskClass.ClassName) and task.Complete and (not task.RemoveWhenComplete) then begin
          aThreadTask := task;
          aThreadTask.ClientID := aClientId;
          aThreadTask.Params := aParams;
          aThreadTask.StartTime := now;
          result := aThreadTask.TaskId;
          Log('Server Module Task List - Starting task: ' + aThreadTask.Name,ltDetail);
          aThreadTask.Complete := false; { this will continue processing loop }
          break;
        end;
      end;
    finally
      fList.UnlockList;
    end;
    if not Assigned(aThreadTask) then begin
      { not found so create new }
      aThreadTask := ThreadTaskClass.Create;
      Log('Server Module Task List - Starting task: ' + aThreadTask.Name,ltDetail);
      result := AddTask(aThreadTask, aClientId, aParams, aMySQLServer);
    end;
  end;
  LogCurrentTasks;
end;

constructor TServerModuleTaskList.Create(aServerModule: TObject);
begin
  Lock := TCriticalSection.Create;
  fServerModule := aServerModule;
  fList:= TThreadList.Create;
  fLastTaskID := 0;
end;

destructor TServerModuleTaskList.Destroy;
var
  lst: TList;
  x: integer;
begin
  Log(self.ClassName + ' Destroying Server Module Task List', ltDetail);
  lst := fList.LockList;
  try
    for x := 0 to lst.Count -1 do begin
      { we are destroying the list so stop the threads from trying to access it! }
      TServerModuleThreadTask(lst[x]).OnNotification := nil;
      TThread(lst[x]).OnTerminate := nil;
      TThread(lst[x]).Terminate;
    end;
  finally
    fList.UnlockList;
  end;
  fList.Free;
  Lock.Free;
  inherited;
end;

procedure TServerModuleTaskList.DoOnThreadLog(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  TServerModule(fServerModule).Log(msg,LogMessageType);
end;

procedure TServerModuleTaskList.DoOnThreadNotification(aClientId: Integer; aNotificationName, aNotificationData: string);
begin
  Lock.Acquire;
  try
    TServerModule(fServerModule).SendNotificationMessage(aClientId, aNotificationName, aNotificationData);
  finally
    Lock.Release;
  end;
end;

procedure TServerModuleTaskList.DoOnTreadTerminate(Sender: TObject);
var
  lst: TList;
begin
  lst := fList.LockList;
  try
    Log('Server Module Task List - Removing task from list: ' + Sender.ClassName,ltDetail);
    lst.Delete(lst.IndexOf(Sender));
  finally
    fList.UnlockList;
  end;
end;

function TServerModuleTaskList.GetCount: integer;
var
  lst: TList;
begin
  lst := fList.LockList;
  try
    result := lst.Count;
  finally
    fList.UnlockList;
  end;
end;

procedure TServerModuleTaskList.GetTaskListAsJson(json: TJsonObject);
var
  lst: TList;
  x: integer;
  task: TServerModuleThreadTask;
  O: TJsonObject;
begin
  json.A['TaskList'];
  lst := fList.LockList;
  try
    for x := 0 to lst.Count -1 do begin
      task := lst[x];
      O := JO;
      ObjToJson(task,O);
      O.S['ClassName'] := task.ClassName;
      json.A['TaskList'].Add(O);
    end;
  finally
    fList.UnlockList;
  end;
end;

function TServerModuleTaskList.GetTaskStatus(const aTaskId: string;
  var aFinished: boolean; var aStartTime: TDateTime;
  var aStatusMessage: string): boolean;
var
  lst: TList;
  x: integer;
  task: TServerModuleThreadTask;
begin
  result:= false;
  aFinished:= true;
  aStartTime:= 0;
  aStatusMessage:= '';
  lst := fList.LockList;
  try
    for x := 0 to lst.Count -1 do begin
      task := lst[x];
      if task.TaskId = aTaskId then begin
        result := true;
        aFinished:= false;
        aStartTime := task.StartTime;
        aStatusMessage := task.StatusMessage;
        break;
      end;
    end;
  finally
    fList.UnlockList;
  end;
end;

function TServerModuleTaskList.ListContainsTask(
  const aTaskClassName: string): boolean;
var
  lst: TList;
  x: integer;
  task: TServerModuleThreadTask;
begin
  result := false;
  lst := fList.LockList;
  try
    for x := 0 to lst.Count -1 do begin
      task := lst[x];
      if task.ClassNameIs(aTaskClassName) then begin
        result := true;
        break;
      end;
    end;
  finally
    fList.UnlockList;
  end;
end;

procedure TServerModuleTaskList.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  TServerModule(fServerModule).Log(msg,LogMessageType);
end;

procedure TServerModuleTaskList.LogCurrentTasks;
var
  task: TServerModuleThreadTask;
  lst: TList;
  x: integer;
  s: string;
begin
  lst := fList.LockList;
  try
    s := 'Current Server Task Count: ' + IntToStr(lst.Count);

    for x := 0 to lst.Count -1 do begin
      task := lst[x];
      s := s + #13#10 + '    ' + task.Name +
        '  Started: ' + DateTimeToStr(task.StartTime) +
        '  Complete: ' + BoolToStr(task.Complete);
    end;
  finally
    fList.UnlockList;
  end;
  Log(s,ltDetail);
end;

procedure TServerModuleTaskList.RemoveCompleteTasks;
var
  lst: TList;
  x: integer;
  task: TServerModuleThreadTask;
  killResult: DWORD;
  LiveList: string;
  ListCount: integer;
const
  OneMin = 1/24/60;
begin
  LiveList := '';
  killResult := 0;
  lst := fList.LockList;
  try
    x := 0;
    while x < lst.count do begin
      task := lst[x];
      if task.Complete and task.RemoveWhenComplete then begin
        Log('Server Module Task List - Removing completed task: ' + task.Name, ltDetail);
        try
          task.NotifyTask;
          task.OnTerminate := nil;
          task.Terminate;
        except

        end;
        lst.Delete(x);
      end
      { check for stalled (ie SaveToStream has "gone away") where there has been
        nothing happen for 3 mins  .. if not kill it }
      else if SameText(task.ClassName, 'TEmailCheckThreadTask') and (not task.Complete) and
        (task.ProgressTime > 0) and ((now - task.ProgressTime) > (OneMin * 3)) then begin
        Log('Server Module Task List - Removing stalled Email Check task: ' + task.Name, ltDetail);
        try
          task.RemoveWhenComplete := true;
          task.OnTerminate := nil;
          TerminateThread(task.ThreadID,killResult);
        except
        end;

        lst.Delete(x);
      end
      else begin
        Inc(x);
        if LiveList <> '' then LiveList := LiveList + ',';
        LiveList := LiveList + '"' + task.TaskId + '"';
      end;
    end;
    ListCount := lst.Count;
  finally
    fList.UnlockList;
  end;

  if ListCount = 0 then begin
    DoOnThreadNotification(0, 'event', '{"eventname": "TaskListEmpty", "value":"' + TServerModule(fServerModule).ModuleName + '"}');
  end;

end;

//procedure TServerModuleTaskList.RemoveTask(aTaskClassName: string);
//var
//  lst: TList;
//  x: integer;
//  task: TServerModuleThreadTask;
//begin
//  lst := fList.LockList;
//  try
//    for x := 0 to lst.Count -1 do begin
//      task := lst[x];
//      if task.ClassNameIs(aTaskClassName) then begin
//        Log('TServerModuleTaskList - Removing task: ' + task.ClassName,ltDetail);
//        task.Terminate;
//      end;
//    end;
//  finally
//    fList.UnlockList;
//  end;
//end;

procedure TServerModuleTaskList.RemoveTask(aTaskId: string);
var
  lst: TList;
  x: integer;
  task: TServerModuleThreadTask;
begin
  lst := fList.LockList;
  try
    for x := 0 to lst.Count -1 do begin
      task := lst[x];
      if task.TaskId = aTaskId then begin
        Log('TServerModuleTaskList - Removing task: ' + task.ClassName,ltDetail);
        task.Terminate;
        break;
      end;
    end;
  finally
    fList.UnlockList;
  end;
  LogCurrentTasks;
end;

{ TServerModuleThreadTask }

constructor TServerModuleThreadTask.Create;
var
  x: integer;
  s: string;
  CommonConfigFileName: string;
begin
  inherited Create(true);
  CommonConfig := JO;
  try
    CommonConfigFileName:= ExtractFilePath(ModuleFileNameUtils.GetCurrentModuleName) + 'ERPModCommon_Config.cfg';
    if FileExists(CommonConfigFileName) then begin
      CommonConfig.LoadFromFile(CommonConfigFileName);
    end;
  except
  end;
  ServerModule := nil;
  FreeOnTerminate := true;
  TaskIdProp := TThreadProperty.Create('0');
  StartTimeProp := TThreadProperty.Create;
  ProgressTimeProp := TThreadProperty.Create;
  StatusMessageProp := TThreadProperty.Create('');
  ClientIdProp := TThreadProperty.Create('0');
  MySQLServerProp := TThreadProperty.Create('127.0.0.1');
  fCompleteProp := TThreadProperty.Create('false');
  fRemoveWhenCompleteProp := TThreadProperty.Create('true');
  fParams := TJsonObject.Create;
  s := Copy(self.ClassName, 2, Length(self.ClassName));
  x := Pos('ModuleThreadTask', s);
  if x > 0 then
    s := Copy(s,1,x-1)
  else begin
    x := Pos('ThreadTask', s);
    if x > 0 then
      s := Copy(s,1,x-1)
  end;
  fName:= '';
  for x := 1 to Length(s) do begin
    if TCharacter.IsUpper(s[x]) then begin
      if fName <> '' then
        fName := fName + ' ';
    end;
   fName := fName + s[x];
  end;
//  DbTaskList := TDBServerThreadTaskList.Create;
end;

destructor TServerModuleThreadTask.Destroy;
begin
//  DbThreadTaskList.Server := TServerModule(ServerModule).MySQLServer;
//  DbThreadTaskList.Delete(TaskId, TServerModule(ServerModule).ModuleName);
  TaskIdProp.Free;
  StartTimeProp.Free;
  ProgressTimeProp.Free;
  StatusMessageProp.Free;
  ClientIdProp.Free;
  MySQLServerProp.Free;
  fCompleteProp.Free;
  fRemoveWhenCompleteProp.Free;
  fParams.Free;
  CommonConfig.Free;
  inherited;
end;

procedure TServerModuleThreadTask.Execute;
begin
  inherited;
  try
    Complete := false;
    self.ProgressTime := now;
//    DbThreadTaskList.Server := TServerModule(ServerModule).MySQLServer;
//    DbThreadTaskList.Write(
//      TaskId,
//      TServerModule(ServerModule).ModuleName,
//      Name,
//      StatusMessage,
//      StartTime,
//      Complete);
    NotifyTask;
    if self.RemoveWhenComplete then begin
      DoWork;
    end
    else begin
      { we are going to use this thread multiple times }
      while not Terminated do begin
        while not Complete do begin
          DoWork;
          Complete := true;
        end;
        Sleep(50);

      end;
    end;
  except
    on e: exception do begin
      Log('Module thread task ' +  self.ClassName + ' error: ' + e.Message, ltError);
    end;
  end;
  Complete := true;
//  DbThreadTaskList.DeleteComplete;
end;

function TServerModuleThreadTask.GetClientId: integer;
begin
  result := ClientIdProp.AsInteger;
end;

function TServerModuleThreadTask.GetComplete: boolean;
begin
  result := fCompleteProp.AsString = 'true';
end;

function TServerModuleThreadTask.GetMySQLServer: string;
begin
  result := MySQLServerProp.AsString;
end;

function TServerModuleThreadTask.GetProgressTime: TDateTime;
begin
  result := ProgressTimeProp.AsDateTime;
end;

function TServerModuleThreadTask.GetRemoveWhenComplete: boolean;
begin
  result := fRemoveWhenCompleteProp.AsString = 'true';
end;

function TServerModuleThreadTask.GetStartTime: TDateTime;
begin
  result := StartTimeProp.AsDateTime;
end;

function TServerModuleThreadTask.GetStatusMessage: string;
begin
  result := StatusMessageProp.AsString;
end;

function TServerModuleThreadTask.GetTaskId: string;
begin
  result := TaskIdProp.AsString;
end;

procedure TServerModuleThreadTask.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  if Assigned(fOnLog) then
    fOnLog(msg,LogMessageType);
end;

procedure TServerModuleThreadTask.SetMySQLServer(const Value: string);
begin
  MySQLServerProp.AsString := Value;
//  DbThreadTaskList.Server := Value;
end;

procedure TServerModuleThreadTask.SendNotification(aNotificationName,
  aNotificationData: string);
begin
  if Assigned(fOnNotification) then
    fOnNotification(ClientId, aNotificationName, aNotificationData);
end;

procedure TServerModuleThreadTask.SetClientId(const Value: integer);
begin
  ClientIdProp.AsInteger := Value;
end;

procedure TServerModuleThreadTask.SetComplete(const Value: boolean);
begin
  if Value then begin
    fCompleteProp.AsString := 'true';
//    DbThreadTaskList.Write(TaskId, TServerModule(ServerModule).ModuleName, Value);
    NotifyTask;
  end
  else begin
    fCompleteProp.AsString := 'false';
//    DbThreadTaskList.Write(TaskId, TServerModule(ServerModule).ModuleName, Value);
  end;
end;

procedure TServerModuleThreadTask.SetParams(const Value: TJsonObject);
begin
  if Assigned(Value) then
    fParams.Assign(Value)
  else
    fParams.Clear;
end;

procedure TServerModuleThreadTask.SetProgressTime(const Value: TDateTime);
begin
  ProgressTimeProp.AsDateTime := Value;
end;

procedure TServerModuleThreadTask.SetRemoveWhenComplete(const Value: boolean);
begin
  if Value then
    fRemoveWhenCompleteProp.AsString := 'true'
  else
    fRemoveWhenCompleteProp.AsString := 'false';
end;

procedure TServerModuleThreadTask.SetStartTime(const Value: TDateTime);
begin
  StartTimeProp.AsDateTime := Value;
//  NotifyTask;
end;

procedure TServerModuleThreadTask.SetStatusMessage(const Value: string);
begin
  StatusMessageProp.AsString := Value;
  if Pos('{', Trim(Value)) = 0 then begin
    { dont send json data }
//    DbThreadTaskList.Write(TaskId, TServerModule(ServerModule).ModuleName, Value);
    NotifyTask;
  end;
end;

procedure TServerModuleThreadTask.SetTaskId(const Value: string);
begin
  TaskIdProp.AsString := Value;
end;

procedure TServerModuleThreadTask.UpdateStatus(aJsonMessage: string);
var
  json: TJsonObject;
begin
  StatusMessage:= aJsonMessage;
  try
    json:= TJsonObject.Create;
    try
      json.S['eventname'] := 'Progress';
      json.S['value'] :=  aJsonMessage;
      SendNotification('event',json.AsString);
    finally
      json.Free;
    end;
  except
  end;
end;

procedure TServerModuleThreadTask.NotifyTask;

  function BoolToString(val: boolean): string;
  begin
    if val then  result := 'true'
    else result := 'false';
  end;

begin
  // to many events sent
  if self.TaskId = '' then Exit;
//  SendNotification('event', '{"eventname":"ServerTask","value":"Update"}');
  SendNotification('event', '{"eventname":"ServerTask","value":{' +
    '"TaskId":"' + TaskId + '",' +
    '"ModuleName":"' + JsonObject.EncodeString(TServerModule(ServerModule).ModuleName) + '",' +
    '"TaskName":"' + JsonObject.EncodeString(Name) + '",' +
    '"StatusMessage":"' + JsonObject.EncodeString(StatusMessage) + '",' +
    '"StartTime":"' + FormatDateTime(JsonObject.JsonDateTimeFormat,StartTime) + '",' +
    '"Complete":' + BoolToString(Complete) +
  '}}');

end;



end.
