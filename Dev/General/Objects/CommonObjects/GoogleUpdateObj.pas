unit GoogleUpdateObj;

interface

uses
  classes, {GoogleApi,} ERPDbComponents, LogThreadBase, LogMessageTypes,
  ibgGCalendar;

type
  TGoogleUpdateType = (utCalendarEvent, utTask);

  {$M+}
  TGoogleUpdateRec = class
  private
    fUpdateType: TGoogleUpdateType;
    fObjectId: integer;
    fCreated: TDateTime;
    fSent: boolean;
    fServerID: string;
  public
    constructor Create;
  published
    property ObjectId: integer read fObjectId write fObjectId;
    property UpdateType: TGoogleUpdateType read fUpdateType write fUpdateType;
    property Created: TDateTime read fCreated write fCreated;
    property Sent: boolean read fSent write fSent;
    property ServerId: string read fServerID write fServerID;
  end;
  {$M-}

  TGoogleUpdaterThread = class;

  TGoogleUpdater = class(TObject)
  private
    fList: TThreadList;
    fServer: string;
    fDatabase: string;
    fWorkerThread: TGoogleUpdaterThread;
  public
    constructor Create(aServer, aDatabase: string);
    destructor Destroy; override;
    procedure UpdateCalendar(AppointmentId: integer; ServerID: string);
    { not using task synch at the moment }
    procedure UpdateToDo(ToDoId: integer; ServerID: string);
    property Server: string read fServer;
    property Database: string read fDatabase;
  end;

  TGoogleUpdaterThread = class(TThread)
  private
    fSleepMs: integer;
//    Google: TGoogle;
    Calendar: TibgGCalendar;
    fConn: TErpConnection;
    function DoSynchCalEvent(rec: TGoogleUpdateRec): boolean;
//    function DoSynchTask(rec: TGoogleUpdateRec): boolean;
    procedure AddToDbQueue(rec: TGoogleUpdateRec);
    procedure DoOnError(Sender: TObject; ErrorCode: Integer; const Description: String);
  protected
    fList: TThreadList;
    procedure DoWork;
    procedure Execute; override;
  public
    constructor Create(aList: TThreadList; aServer, aDatabase: string);
    destructor Destroy; override;
  end;

  TContinueCheckProc = procedure (var Abort: boolean) of object;

  TGoogleUpdateDbQueue = class(TObject)
  private
//    Google: TGoogle;
    fOnContinueCheck: TContinueCheckProc;
    fOnLog: LogThreadBase.TOnLogEvent;
    Calendar: TibgGCalendar;
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);
    //function Aborted: boolean;
  public
    Logger: TLoggerBase;
    constructor Create;
    destructor Destroy; override;
    property OnContinueCheck: TContinueCheckProc read fOnContinueCheck write fOnContinueCheck;
    procedure ProcessDbQueue(Conn: TERPConnection);
    property OnLog: LogThreadBase.TOnLogEvent read fOnLog write fOnLog;
  end;

implementation

uses
  SysUtils, MySQLUtils, GoogleConfigObj, Types, StrUtils, DateTimeUtils,
  TypInfo, MySQLConst, GoogleCalendarConfigObj, LogThreadLib, JsonObject,
  GoogleAuth, GoogleConst;

const
  MAX_SEND_RETRY_TIME = (1/24) * 2; // 2 hours


function GoogleUpdateTypeToStr(aType: TGoogleUpdateType): string; overload;
begin
  case aType of
    utCalendarEvent: result := 'Google Calendar Event';
    utTask: result := 'Google Task';
  end;
end;

function GoogleUpdateTypeToStr(aType: String): string; overload;
begin
  if SameText(aType, 'utCalendarEvent') then result := 'Google Calendar Event'
  else if SameText(aType, 'utTask') then result := 'Google Task';
end;


//function SynchCalEvent(rec: TGoogleUpdateRec; fConn: TERPConnection; Google: TGoogle): boolean; overload;
//var
//  qryApp: TERPQuery;
//  qryEmp: TERPQuery;
//  calEvent : TCalendarEvent;
//begin
//  result := true;
//  qryApp := TERPQuery.Create(nil);
//  qryEmp := TERPQuery.Create(nil);
//  try
//    qryApp.Connection := fConn;
//    qryEmp.Connection := fConn;
//    qryApp.SQL.Text := 'select * from tblAppointments where AppointID = ' + IntToStr(rec.ObjectId);
//    qryApp.Open;
//    if qryApp.IsEmpty then exit;
//    qryEmp.SQL.Text := 'select * from tblEmployees where EmployeeID = ' + qryApp.FieldByName('TrainerID').AsString;
//    qryEmp.Open;
//    if qryEmp.IsEmpty then exit;
//
//    if not qryApp.FieldByName('SynchWithGoogle').AsBoolean then exit;
//    if not qryEmp.FieldByName('SynchWithGoogle').AsBoolean then exit;
//
//    try
//      Google.Connection.Connect(qryEmp.FieldByName('GoogleEmail').AsString,
//        qryEmp.FieldByName('GooglePassword').AsString);
//      calEvent := nil;
//      try
//        if qryApp.FieldByName('GoogleId').AsString <> '' then begin
//          { an existing calendar event }
//          calEvent := Google.PrimaryCalendarEvents.get(qryApp.FieldByName('GoogleId').AsString);
//        end;
//        if not Assigned(calEvent) then begin
//          if not qryApp.FieldByName('Active').AsBoolean then
//            exit;  { appointment deleted and does not exist in Calendar so do nothing }
//          calEvent := TCalendarEvent.Create(Google.Connection); { else create it }
//          calEvent.status := 'confirmed';
//        end;
//        calEvent.startTime.dateTime := qryApp.FieldByName('StartTime').AsDateTime;
////        calEvent.startTime.timeZone := Google.CalendarList.PrimaryCalendarListEntry.timeZone;
//        calEvent.endTime.dateTime := qryApp.FieldByName('EndTime').AsDateTime;
////        calEvent.endTime.timeZone := Google.CalendarList.PrimaryCalendarListEntry.timeZone;
//
//        if not qryApp.FieldByName('Unavailable').AsBoolean then
//          calEvent.summary := qryApp.FieldByName('ClientName').AsString
//        else
//          calEvent.summary := 'Unavailable';
//        calEvent.description := qryApp.FieldByName('CustomerDetails').AsString + #13 +
//          NOTES_DELIM + ' ' + NOTES_Comment + #13 + Trim(qryApp.FieldByName('Notes').AsString);
//
//        if calEvent.id = '' then
//          Google.PrimaryCalendarEvents.insert(calEvent)
//        else begin
//          if not qryApp.FieldByName('Active').AsBoolean then begin
//            { delete it }
//            Google.PrimaryCalendarEvents.delete(calEvent.id);
//            exit; { done }
//          end
//          else begin
//            { update it }
//            calEvent.status := 'confirmed';
//            Google.PrimaryCalendarEvents.update(calEvent);
//          end;
//        end;
//
//        if (qryApp.FieldByName('GoogleId').AsString <> calEvent.id) or
//          (CompareDateTimeNoMS(qryApp.FieldByName('GoogleUpdated').AsDateTime, calEvent.updated) <>0) then begin
//          qryApp.Edit;
//          qryApp.FieldByName('GoogleId').AsString := calEvent.id;
//          qryApp.FieldByName('GoogleUpdated').AsDateTime := calEvent.updated;
//          qryApp.Post;
//        end;
//      finally
//        Google.Connection.Disconnect;
//      end;
//    except
//      on e: exception do begin
//        result := false;
//      end;
//    end;
//  finally
//    qryApp.Free;
//    qryEmp.Free;
//  end;
//end;

function SynchCalEvent(rec: TGoogleUpdateRec; fConn: TERPConnection; Calendar: TibgGCalendar; var msg: string): boolean; overload;
var
  qryApp: TERPQuery;
  qryEmp: TERPQuery;
//  calEvent : TCalendarEvent;
  x: integer;
  found: boolean;
  EventId: string;
  authKey, refreshKey: string;
begin
  result := true;
  qryApp := TERPQuery.Create(nil);
  qryEmp := TERPQuery.Create(nil);
  try
    qryApp.Connection := fConn;
    qryEmp.Connection := fConn;
    qryApp.SQL.Text := 'select * from tblAppointments where AppointID = ' + IntToStr(rec.ObjectId);
    qryApp.Open;
    if qryApp.IsEmpty then exit;
    qryEmp.SQL.Text := 'select * from tblEmployees where EmployeeID = ' + qryApp.FieldByName('TrainerID').AsString;
    qryEmp.Open;
    if qryEmp.IsEmpty then exit;

    if not qryApp.FieldByName('SynchWithGoogle').AsBoolean then exit;
    if not qryEmp.FieldByName('SynchWithGoogle').AsBoolean then exit;

    try
//      Google.Connection.Connect(qryEmp.FieldByName('GoogleEmail').AsString,
//        qryEmp.FieldByName('GooglePassword').AsString);
      Calendar.EventIndex := -1;
      Calendar.Authorization := qryEmp.FieldByName('GooglePassword').AsString;
      try
        Calendar.ListCalendars;
      except
        on e: exception do begin
          if Pos('Invalid Credentials',e.Message) > 0 then begin
            if qryEmp.FieldByName('GoogleRefreshPassword').AsString <> '' then begin
              { try to get new auth using the refresh token }
              refreshKey := qryEmp.FieldByName('GoogleRefreshPassword').AsString;
              authKey := GetAuthorization(refreshKey);
              if authKey <> '' then begin
                Calendar.Authorization := authKey;
                Calendar.ListCalendars;
                try
                  { save this new auth key }
                  qryEmp.Edit;
                  qryEmp.FieldByName('GooglePassword').AsString := authKey;
                  qryEmp.Post;
                except

                end;
              end
              else begin
                result := false;
                msg := 'Credentials not set for ' + qryEmp.FieldByName('GoogleEmail').AsString;
                exit;
              end;
            end
            else begin
              result := false;
              msg := 'Invalid credentials for ' + qryEmp.FieldByName('GoogleEmail').AsString;
              exit;
            end;


          end;

        end;
      end;
      found := false;
      for x := 0 to Calendar.CalendarCount -1 do begin
        Calendar.CalendarIndex := x;
        if SameText(Calendar.CalendarID, qryEmp.FieldByName('GoogleEmail').AsString) then begin
          found := true;
          break;
        end;
      end;
      if not found then begin
        result := false;
        msg := 'Calendar (' + qryEmp.FieldByName('GoogleEmail').AsString + ') not found.';
        exit;
      end;

//      calEvent := nil;
      try

        EventId := '';
        if qryApp.FieldByName('GoogleId').AsString <> '' then begin
          { an existing calendar event }
//          calEvent := Google.PrimaryCalendarEvents.get(qryApp.FieldByName('GoogleId').AsString);
          Calendar.GetEvent(qryApp.FieldByName('GoogleId').AsString);
          EventId := Calendar.EventId;
        end
//        if not Assigned(calEvent) then begin
        else begin
          if not qryApp.FieldByName('Active').AsBoolean then
            exit;  { appointment deleted and does not exist in Calendar so do nothing }
//          calEvent := TCalendarEvent.Create(Google.Connection); { else create it }
//          calEvent.status := 'confirmed';
          //EventId := Calendar.CreateEvent;
          Calendar.EventStatus := gcsConfirmed;
//          Calendar.EventAttendeeCount := 1;
//          Calendar.EventAttendeeEmail[0] := qryEmp.FieldByName('GoogleEmail').AsString;
          Calendar.EventIndex := -1;
        end;
//        calEvent.startTime.dateTime := qryApp.FieldByName('StartTime').AsDateTime;
//        calEvent.endTime.dateTime := qryApp.FieldByName('EndTime').AsDateTime;
        Calendar.EventStartDateTime :=  DateTimeLocalToRFC3339Str(qryApp.FieldByName('StartTime').AsDateTime);
        Calendar.EventEndDateTime :=  DateTimeLocalToRFC3339Str(qryApp.FieldByName('EndTime').AsDateTime);

        if not qryApp.FieldByName('Unavailable').AsBoolean then
//          calEvent.summary := qryApp.FieldByName('ClientName').AsString
          Calendar.EventSummary := JsonObject.EncodeString(qryApp.FieldByName('ClientName').AsString)
        else
//          calEvent.summary := 'Unavailable';
          Calendar.EventSummary := 'Unavailable';
//        calEvent.description := qryApp.FieldByName('CustomerDetails').AsString + #13 +
//          NOTES_DELIM + ' ' + NOTES_Comment + #13 + Trim(qryApp.FieldByName('Notes').AsString);
        Calendar.EventDescription := JsonObject.EncodeString(qryApp.FieldByName('CustomerDetails').AsString + #13 +
          NOTES_DELIM + ' ' + NOTES_Comment + #13 + Trim(qryApp.FieldByName('Notes').AsString));

//       Calendar.EventDescription := 'test';

//        if calEvent.id = '' then
//          Google.PrimaryCalendarEvents.insert(calEvent)
//        else begin
//          if not qryApp.FieldByName('Active').AsBoolean then begin
//            { delete it }
//            Google.PrimaryCalendarEvents.delete(calEvent.id);
//            exit; { done }
//          end
//          else begin
//            { update it }
//            calEvent.status := 'confirmed';
//            Google.PrimaryCalendarEvents.update(calEvent);
//          end;
//        end;



        if not qryApp.FieldByName('Active').AsBoolean then begin
          { delete it }
//          Google.PrimaryCalendarEvents.delete(calEvent.id);

          if Calendar.EventId <> '' then
            Calendar.DeleteEvent;
          exit; { done }
        end
        else begin
          { update it }
//          calEvent.status := 'confirmed';
//          Google.PrimaryCalendarEvents.update(calEvent);
          Calendar.EventStatus := gcsConfirmed;
//          with TStringList.Create do begin
//            Add('EventStatus=' + IntToStr(Ord(Calendar.EventStatus)));
//            Add('EventStartDateTime=' +Calendar.EventStartDateTime);
//            Add('EventEndDateTime=' +Calendar.EventEndDateTime);
//            Add('EventSummary='+ Calendar.EventSummary);
//            Add('EventDescription=' + Calendar.EventDescription);
//
//            SaveToFile('c:\temp\temp.txt');
//            Free;
//          end;

          if EventId <> ''  then
            Calendar.UpdateEvent
          else
            EventId := Calendar.CreateEvent;
        end;

//        if (qryApp.FieldByName('GoogleId').AsString <> calEvent.id) or
//          (CompareDateTimeNoMS(qryApp.FieldByName('GoogleUpdated').AsDateTime, calEvent.updated) <>0) then begin
//          qryApp.Edit;
//          qryApp.FieldByName('GoogleId').AsString := calEvent.id;
//          qryApp.FieldByName('GoogleUpdated').AsDateTime := calEvent.updated;
        if (qryApp.FieldByName('GoogleId').AsString <> Calendar.EventId) or
          (CompareDateTimeNoMS(qryApp.FieldByName('GoogleUpdated').AsDateTime, RFC3339StrToDateTime(Calendar.EventDateUpdated)) <>0) then begin
          qryApp.Edit;
          qryApp.FieldByName('GoogleId').AsString := Calendar.EventId;
          qryApp.FieldByName('GoogleUpdated').AsDateTime := RFC3339StrToDateTime(Calendar.EventDateUpdated);
          qryApp.Post;
        end;
      finally
//        Google.Connection.Disconnect;
        Calendar.EventIndex := -1;
      end;
    except
      on e: exception do begin
        result := false;
        msg := e.Message;
      end;
    end;
  finally
    qryApp.Free;
    qryEmp.Free;
  end;
end;

//function SynchTask(rec: TGoogleUpdateRec; fConn: TERPConnection; Google: TGoogle): boolean;
//var
//  qryToDo: TERPQuery;
//  qryEmp: TERPQuery;
//  cfg: TGoogleConfig;
//  taskList: TTaskList;
//  task: TTask;
//  sl: TStringDynArray;
//  s: string;
//  x: integer;
//begin
//  result := true;
//  try
//    cfg := TGoogleConfig.Create;
//    try
//      cfg.Load(fConn);
//
//      qryToDo := TERPQuery.Create(nil);
//      qryEmp := TERPQuery.Create(nil);
//      try
//        qryToDo.Connection := fConn;
//        qryEmp.Connection := fConn;
//        qryToDo.SQL.Text := 'select * from tbltodo where ToDoID = ' + IntToStr(rec.ObjectId);
//        qryToDo.Open;
//        if qryToDo.IsEmpty then exit;
//        if not qryToDo.FieldByName('SynchWithGoogle').AsBoolean then exit;
//        qryEmp.SQL.Text := 'select * from tblemployees where EmployeeID = ' +
//          IntToStr(qryToDo.FieldByName('EmployeeID').ASInteger);
//        qryEmp.Open;
//        if qryEmp.IsEmpty then exit;
//        if not qryEmp.FieldByName('SynchWithGoogle').AsBoolean then exit;
//
//        { update user task list }
//        Google.Connection.Connect(qryEmp.FieldByName('GoogleEmail').AsString,
//          qryEmp.FieldByName('GooglePassword').AsString);
//        try
//          taskList := Google.TaskLists.DefaultList;
//          task := nil;
//          if qryToDo.FieldByName('GoogleId').AsString <> '' then
//            task := taskList.Tasks.get(qryToDo.FieldByName('GoogleId').AsString);
//          if not Assigned(task) then
//            task := TTask.Create(Google.Connection);
//          sl := StrUtils.SplitString(qryToDo.FieldByName('Description').AsString, #13);
//  //        task.title := qryToDo.FieldByName('Description').AsString;
//  //        task.notes := '';
//          task.title := Trim(sl[0]);
//          s:= '';
//          for x := 1 to High(sl) do begin
//            if x > 1 then s := s + #13;
//            s:= s + Trim(sl[x]);
//          end;
//          task.notes := s;
//          task.due := qryToDo.FieldByName('ToDoByDate').AsDateTime;
//          if qryToDo.FieldByName('Completed').AsBoolean then begin
//            task.completed := qryToDo.FieldByName('ToDoByDate').AsDateTime;
//            task.status := 'completed';
//          end
//          else begin
//            task.status := 'needsAction';
//          end;
//          if task.id = '' then
//            taskList.Tasks.insert(task)
//          else
//            taskList.Tasks.update(task);
//  //        if qryToDo.FieldByName('GoogleId').AsString <> task.id then begin
//          qryToDo.Edit;
//          qryToDo.FieldByName('GoogleId').AsString := task.id;
//          qryToDo.FieldByName('GoogleUpdated').AsDateTime := task.updated;
//          qryToDo.Post;
//  //        end;
//
//        finally
//          Google.Connection.Disconnect;
//        end;
//
//        { now update master task list }
//        if not cfg.SynchWithGoogle then exit;
//        Google.Connection.Connect(cfg.Email, cfg.Password);
//        try
//          task := nil;
//          taskList := Google.TaskLists.DefaultList;
//          if qryToDo.FieldByName('MasterGoogleId').AsString <> '' then
//            task := taskList.Tasks.get(qryToDo.FieldByName('MasterGoogleId').AsString);
//          if not Assigned(task) then
//            task := TTask.Create(Google.Connection);
//          sl := StrUtils.SplitString(qryToDo.FieldByName('Description').AsString, #13);
//  //        task.title := qryToDo.FieldByName('Description').AsString;
//  //        task.notes := '';
//          task.title := Trim(sl[0]);
//          s:= '';
//          for x := 1 to High(sl) do begin
//            if x > 1 then s := s + #13;
//            s:= s + Trim(sl[x]);
//          end;
//          task.notes := s;
//          task.due := qryToDo.FieldByName('ToDoByDate').AsDateTime;
//          if qryToDo.FieldByName('Completed').AsBoolean then begin
//            task.completed := qryToDo.FieldByName('ToDoByDate').AsDateTime;
//            task.status := 'completed';
//          end
//          else begin
//            task.status := 'needsAction';
//          end;
//          if task.id = '' then
//            taskList.Tasks.insert(task)
//          else
//            taskList.Tasks.update(task);
//  //        if qryToDo.FieldByName('MasterGoogleId').AsString <> task.id then begin
//          qryToDo.Edit;
//          qryToDo.FieldByName('MasterGoogleId').AsString := task.id;
//          qryToDo.FieldByName('MasterGoogleUpdated').AsDateTime := task.updated;
//          qryToDo.Post;
//  //        end;
//
//        finally
//          Google.Connection.Disconnect;
//        end;
//      finally
//        qryToDo.Free;
//        qryEmp.Free;
//      end;
//    finally
//      cfg.Free;
//    end;
//  except
//    result := false;
//  end;
//end;


{ TGoogleUpdater }

constructor TGoogleUpdater.Create(aServer, aDatabase: string);
begin
  fServer := aServer;
  fDatabase := aDatabase;
  fList := TThreadList.Create;
  fList.Duplicates := dupAccept;
  fWorkerThread := TGoogleUpdaterThread.Create(fList, aServer, aDatabase);
end;

destructor TGoogleUpdater.Destroy;
var
  list: TList;
begin
  list := fList.LockList;
  try
    while list.Count > 0 do begin
      TGoogleUpdateRec(list[0]).Free;
      list.Delete(0);
    end;
  finally
    fList.UnlockList;
  end;
  fWorkerThread.Terminate;
  Sleep(20);
  FreeAndNil(fList);
  inherited;
end;

procedure TGoogleUpdater.UpdateCalendar(AppointmentId: integer; ServerID: string);
var
  rec: TGoogleUpdateRec;
  list: TList;
begin
  list  := fList.LockList;
  try
    rec := TGoogleUpdateRec.Create;
    rec.ObjectId := AppointmentId;
    rec.UpdateType := utCalendarEvent;
    rec.ServerId := ServerID;
    list.Add(rec);
  finally
    fList.UnlockList;
  end;

end;

procedure TGoogleUpdater.UpdateToDo(ToDoId: integer; ServerID: string);
(*
var
  rec: TGoogleUpdateRec;
  list: TList;
*)
begin
  { not using tasks at the moment so just exit }
  exit;
  (*
  list  := fList.LockList;
  try
    rec := TGoogleUpdateRec.Create;
    rec.ObjectId := ToDoId;
    rec.UpdateType := utTask;
    list.Add(rec);
  finally
    fList.UnlockList;
  end;
  *)
end;

{ TGoogleUpdaterThread }

constructor TGoogleUpdaterThread.Create(aList: TThreadList; aServer, aDatabase: string);
begin
  fList:= aList;
  fConn := TERPConnection.Create(nil);
  MySQLUtils.SetConnectionProps(fConn, aDatabase,aServer);
  fSleepMs := 10;
//  Google := TGoogle.Create;
  Calendar := TibgGCalendar.Create(nil);
  Calendar.OnError := DoOnError;
  inherited Create(false);
  self.FreeOnTerminate:= true;
end;

destructor TGoogleUpdaterThread.Destroy;
begin
//  Google.Free;
  fConn.Free;
  Calendar.Free;
  inherited;
end;

procedure TGoogleUpdaterThread.DoOnError(Sender: TObject; ErrorCode: Integer;
  const Description: String);
begin
  TLogger.Inst.Log('Error: ' + IntToStr(ErrorCode) + '  ' +  Description, ltError);
end;

function TGoogleUpdaterThread.DoSynchCalEvent(rec: TGoogleUpdateRec): boolean;
var
  cfg: TGoogleCalendarConfig;
  msg: string;
begin
  result := true;
  { only synch if enabled .. and db has not been restored to different server }
  cfg := TGoogleCalendarConfig.Create;
  try
    cfg.Load(self.fConn);
    if (not cfg.SynchWithGoogleCalendar) or
     ((cfg.LastServerId <> '') and (rec.ServerID <> '') and (cfg.LastServerId <> rec.ServerID)) then
      exit;
  finally
    cfg.Free;
  end;
//  result := SynchCalEvent(rec,fConn,Google);
  result := SynchCalEvent(rec,fConn,Calendar,msg);
  if not result then
    TLogger.Inst.Log('Error synchronizing calendar: ' + msg, ltError);
end;

//function TGoogleUpdaterThread.DoSynchTask(rec: TGoogleUpdateRec): boolean;
//begin
//  result := SynchTask(rec, fConn, Google);
//end;

procedure TGoogleUpdaterThread.DoWork;
var
  list: TList;
  rec: TGoogleUpdateRec;
begin
  if not Assigned(fList) then exit;
  fSleepMs := 500;
  rec := nil;
  list := fList.LockList;
  try
    if list.Count > 1 then fSleepMs := 10
    else fSleepMs := 500;
    if list.Count > 0 then begin
      { extract the record }
      rec := list[0];
      list.Delete(0);
    end;
  finally
    fList.UnlockList;
  end;
  if Assigned(rec) then begin
    try
    { process the record }
      case rec.UpdateType of
        utCalendarEvent:
          begin
            if not DoSynchCalEvent(rec) then
              self.AddToDbQueue(rec);
          end;
        utTask:
          begin
            { not supported }
//            if not DoSynchTask(rec) then
//              self.AddToDbQueue(rec);
          end;
      end;
    finally
      rec.free;
    end;
  end;
end;

procedure TGoogleUpdaterThread.Execute;
begin
  inherited;
  while not Terminated do begin
    try
      Sleep(fSleepMs);
      DoWork;
    except
    end;
  end;
end;

// Que record to retry send by UserUtils
procedure TGoogleUpdaterThread.AddToDbQueue(rec: TGoogleUpdateRec);
var
  cmd: TERPCommand;
begin
  try
    cmd := TERPCommand.Create(nil);
    try
      cmd.Connection := fConn;
      cmd.SQL.Add('insert into tblGoogleQueue');
      cmd.SQL.Add('Set ObjectId = ' + IntToStr(rec.ObjectId));
      cmd.SQL.Add(',UpdateType = "' + TypInfo.GetEnumProp(rec, 'UpdateType') + '"');
      cmd.SQL.Add(',Created = "' + FormatDateTime(MySQLConst.MysqlDateTimeFormat,rec.Created) + '"');
      if rec.Sent then cmd.SQL.Add(',Sent = "T"')
      else cmd.SQL.Add(',Sent = "F"');
      cmd.Execute;
    finally
      cmd.Free;
    end;
  except

  end;
end;

{ TGoogleUpdateRec }

constructor TGoogleUpdateRec.Create;
begin
  fCreated := now;
  fSent := false;
end;

{ TGoogleUpdateDbQueue }

(*function TGoogleUpdateDbQueue.Aborted: boolean;
var
  Abort: boolean;
begin
  Abort := false;
  if Assigned(self.fOnContinueCheck) then
    self.fOnContinueCheck(Abort);
  result := Abort;
end;*)

constructor TGoogleUpdateDbQueue.Create;
begin
//  Google := nil;
  Calendar := TibgGCalendar.Create(nil);
end;

destructor TGoogleUpdateDbQueue.Destroy;
begin
//  Google.Free;
  Calendar.Free;
  inherited;
end;

procedure TGoogleUpdateDbQueue.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  if Assigned(Logger) then
    Logger.Log(msg, LogMessageType);
  if Assigned(fOnLog) then
    fOnLog(msg, LogMessageType);
end;

procedure TGoogleUpdateDbQueue.ProcessDbQueue(Conn: TERPConnection);
var
  qry: TERPQuery;
  rec: TGoogleUpdateRec;
  msg: string;
begin
  try
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := Conn;
      qry.SQL.Text := 'select * from tblGoogleQueue where Sent = "F"';
      qry.Open;
      if not qry.IsEmpty then begin
        while not qry.Eof do begin
          try
            // give up trying to send if it has been to long
            if qry.FieldByName('Created').AsDateTime + MAX_SEND_RETRY_TIME < now then begin
              qry.Edit;
              qry.FieldByName('Sent').AsBoolean := true;
              qry.Post;
              Log('Unable to send ' + GoogleUpdateTypeToStr(qry.FieldByName('UpdateType').AsString) +
                ' with Id ' + qry.FieldByName('ObjectId').AsString + ' after trying for ' +
                FormatDateTime('hh:nn', MAX_SEND_RETRY_TIME), ltError);
            end
            else begin
              // try and send it again
//              if not Assigned(Google) then Google := TGoogle.Create;
              rec := TGoogleUpdateRec.Create;
              try
                rec.ObjectId := qry.FieldByName('ObjectId').AsInteger;
                TypInfo.SetEnumProp(rec,'UpdateType',qry.FieldByName('UpdateType').AsString);
                rec.Created := qry.FieldByName('Created').AsDateTime;
                rec.Sent := qry.FieldByName('Sent').AsBoolean;
                case rec.UpdateType of
                  utCalendarEvent:
                    begin
                      if SynchCalEvent(rec,Conn,Calendar,msg) then begin
                        qry.Edit;
                        qry.FieldByName('Sent').AsBoolean := true;
                        qry.Post;
                        Log('Just sent ' + GoogleUpdateTypeToStr(qry.FieldByName('UpdateType').AsString) +
                          ' with Id ' + qry.FieldByName('ObjectId').AsString + ' after trying for ' +
                          FormatDateTime('hh:nn', MAX_SEND_RETRY_TIME), ltInfo);
                      end
                      else begin
                        Log('Error sending calendar event ('+qry.Connection.Database+'): ' + msg, ltError);
                      end;
                    end;
                  utTask:
                    begin
                      { not currently supported }
//                      if SynchTask(rec,Conn,Calendar) then begin
//                        qry.Edit;
//                        qry.FieldByName('Sent').AsBoolean := true;
//                        qry.Post;
//                      end;
//                      Log('Just sent ' + GoogleUpdateTypeToStr(qry.FieldByName('UpdateType').AsString) +
//                        ' with Id ' + qry.FieldByName('ObjectId').AsString + ' after trying for ' +
//                        FormatDateTime('hh:nn', MAX_SEND_RETRY_TIME), ltInfo);
                    end;
                end;
              finally
                rec.Free;
              end;
            end;
          except
            on e: exception do begin
              Log('Error processing record so continuing with next. Error: ' + e.Message, ltError);
            end;
          end;
        qry.Next;
        end;
        // delete sent items
        qry.SQL.Text := 'delete from tblGoogleQueue where Sent = "T"';
        qry.Execute;
      end;
    finally
      qry.Free;
    end;
  except
    on e: exception do begin
      Log('Error processing database "' + Conn.Database + '": ' + e.Message,ltError);
    end;
  end;
end;

end.
