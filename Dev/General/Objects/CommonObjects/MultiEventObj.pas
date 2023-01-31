unit MultiEventObj;

interface

uses
  classes, SyncObjs;

type
  PMethod = ^TMethod;

  TMutliEvent = procedure(Sender: TObject; const Event, Value : string) of object;

  TMultiEventClass = class
  private
    fMultiEventHandlers : TList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddMultiEvent(const Value: TMutliEvent);
    procedure RemoveMultiEvent(const Value: TMutliEvent);
    procedure FireEvent(Sender: TObject; const Event, Value : string);
  end;

  TMultiEventItem = class(TObject)
  public
    Sender: TObject;
    Event,
    Value: string;
  end;

  { thread safe version that also uses a separate thread to call the
    event handlers }
  TEventSenderThread = class;
  TQueuedMultiEventClass = class
  private
    fHandlerList : TThreadList;
    fEventQueueList : TThreadList;
    fWorkerThread: TEventSenderThread;
//    fLock: TCriticalSection;
    fThreadTerminated: boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddMultiEvent(const Value: TMutliEvent);
    procedure RemoveMultiEvent(const Value: TMutliEvent);
    procedure FireEvent(Sender: TObject; const Event, Value : string);
    property EventQueueList: TThreadList read fEventQueueList;
    property HandlerList: TThreadList read fHandlerList;
  end;

  TEventSenderThread = class(TThread)
  private
    fQueuedMultiEventClass: TQueuedMultiEventClass;
    fIsTerminated: boolean;
    procedure Process;
  protected
    constructor Create(QueuedMultiEventClass: TQueuedMultiEventClass);
    procedure Execute; override;
  public
    property IsTerminated: boolean read fIsTerminated;
  end;


implementation
uses

  {$IfDef VER220}
  Forms,
  SysUtils
  {$Else}
  System.SysUtils
  {$EndIf}
  ;


{ TMultiEventClass }

procedure TMultiEventClass.AddMultiEvent(const Value: TMutliEvent);
var
  h: PMethod;
begin
  h := New(PMethod);
  h^.Code := TMethod(Value).Code;
  h^.Data := TMethod(Value).Data;
  fMultiEventHandlers.Add(h);
end;

constructor TMultiEventClass.Create;
begin
  inherited;
  fMultiEventHandlers:= TList.Create;
end;

destructor TMultiEventClass.Destroy;
var cnt: integer;
begin
  for cnt := 0 to fMultiEventHandlers.Count -1 do
    Dispose(fMultiEventHandlers[cnt]);
  fMultiEventHandlers.Free;
  inherited;
end;

procedure TMultiEventClass.FireEvent(Sender: TObject; const Event, Value: string);
var
  cnt: Integer;
begin
  for cnt := 0 to -1 + fMultiEventHandlers.Count do
  begin
    TMutliEvent(fMultiEventHandlers[cnt]^)(Sender,Event,Value);
  end;
end;

procedure TMultiEventClass.RemoveMultiEvent(const Value: TMutliEvent);
var
  cnt: Integer;
begin
  for cnt := 0 to -1 + fMultiEventHandlers.Count  do
  begin
    if (TMethod(Value).Code =
        TMethod(fMultiEventHandlers[cnt]^).Code) and
       (TMethod(Value).Data =
        TMethod(fMultiEventHandlers[cnt]^).Data) then begin
      Dispose(fMultiEventHandlers[cnt]);
      fMultiEventHandlers.Delete(cnt);
      Break;
    end;
  end;
end;

{ TQueuedMultiEventClass }

constructor TQueuedMultiEventClass.Create;
begin
  inherited;
  fHandlerList:= TThreadList.Create;
  fEventQueueList:= TThreadList.Create;
  fThreadTerminated:= false;
  { thread will execute on create }
  fWorkerThread:= TEventSenderThread.Create(self);
end;

destructor TQueuedMultiEventClass.Destroy;
var
  list: TList;
  count: integer;
begin
  fWorkerThread.Terminate;
  count:= 0;
  while (not fWorkerThread.IsTerminated) and (count < 100) do begin
    Sleep(10);
    Inc(count);
  end;
  try
    fWorkerThread.Free;
  except;
  end;
  list:= fEventQueueList.LockList;
  try
    while list.Count > 0 do begin
      TObject(list.Items[0]).Free;
      list.Delete(0);
    end;
  finally
    fEventQueueList.UnlockList;
  end;
  fEventQueueList.Free;
  fHandlerList.Free;
  inherited;
end;

procedure TQueuedMultiEventClass.AddMultiEvent(const Value: TMutliEvent);
var
  list: TList;
  h: PMethod;
begin
  list:= fHandlerList.LockList;
  try
    h := New(PMethod);
    h^.Code := TMethod(Value).Code;
    h^.Data := TMethod(Value).Data;
    list.Add(h);
  finally
    fHandlerList.UnlockList;
  end;
end;

procedure TQueuedMultiEventClass.FireEvent(Sender: TObject; const Event,
  Value: string);
var
  list: TList;
  item: TMultiEventItem;
begin
  list:= fEventQueueList.LockList;
  try
    item:= TMultiEventItem.Create;
    item.Sender:= Sender;
    item.Event:= Event;
    item.Value:= Value;
    list.Add(item);
  finally
    fEventQueueList.UnlockList;
  end;
end;

procedure TQueuedMultiEventClass.RemoveMultiEvent(
  const Value: TMutliEvent);
var
  list: TList;
  cnt: Integer;
begin
  list:= fHandlerList.LockList;
  try
    for cnt := 0 to -1 + list.Count  do
    begin
      if (TMethod(Value).Code =
          TMethod(list[cnt]^).Code) and
         (TMethod(Value).Data =
          TMethod(list[cnt]^).Data) then begin
        Dispose(list[cnt]);
        list.Delete(cnt);
        Break;
      end;
    end;
  finally
    fHandlerList.UnlockList;
  end;
end;

{ TEventSenderThread }

constructor TEventSenderThread.Create(
  QueuedMultiEventClass: TQueuedMultiEventClass);
begin
  inherited Create(false);
  self.fQueuedMultiEventClass:= QueuedMultiEventClass;
  self.FreeOnTerminate:= false;
  fIsTerminated:= false;
  self.Priority:= tpLower;
end;

procedure TEventSenderThread.Execute;
begin
  inherited;
  fIsTerminated:= false;
  while not Terminated do begin
    try
      if (not Terminated) then
        Process;
    except
    end;
  end;
  fIsTerminated:= true;
end;

procedure TEventSenderThread.Process;
var
  QueueList, HandlerList: TList;
  item: TMultiEventItem;
  cnt: integer;
  found: boolean;
  aValue, aEvent: string;
  aSender: TObject;
begin
  QueueList:= fQueuedMultiEventClass.EventQueueList.LockList;
  aSender:= nil;
  found:= false;
  try
    if QueueList.Count > 0 then begin
      found:= true;
      item:= TMultiEventItem(QueueList[0]);
      aValue:= item.Value;
      aEvent:= item.Event;
      aSender:= item.Sender;
      TMultiEventItem(QueueList[0]).Free;
      QueueList.Delete(0);
    end;
  finally
    fQueuedMultiEventClass.EventQueueList.UnlockList;
  end;

  if found then begin
    HandlerList:= fQueuedMultiEventClass.HandlerList.LockList;
    try
      for cnt := 0 to -1 + HandlerList.Count do
      begin
        TMutliEvent(HandlerList[cnt]^)(aSender,aEvent,aValue);
      end;
    finally
      fQueuedMultiEventClass.HandlerList.UnlockList;
    end;
  end;
  if not found then
    Sleep(10);
end;

end.
