unit GoogleSynchObj;

interface

uses
  LogThreadBase, ERPDbComponents, LogMessageTypes;

type
  TGoogleSynchProgress = procedure (var Abort: boolean) of object;

  TGoogleSynchType = (gsCalendar, gsTask, gsAll, gsERPCalandar);

  TGoogleSynch = class(TObject)
  private
    fOnProgress: TGoogleSynchProgress;
    fConnection: TERPConnection;
    fLastSynchTime: TDateTime;
    fOnLog: LogThreadBase.TOnLogEvent;
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);
    function AbortProcessing: boolean;
  public
    Logger: TLoggerBase;
    constructor Create;
    destructor Destroy; override;
    property Connection: TERPConnection read fConnection write fConnection;
    property OnProgress: TGoogleSynchProgress read fOnProgress write fOnProgress;
    property LastSynchTime: TDateTime read fLastSynchTime write fLastSynchTime;
    function DoSynch(SynchType: TGoogleSynchType): boolean;
    property OnLog: LogThreadBase.TOnLogEvent read fOnLog write fOnLog;
  end;

implementation

uses
  {GoogleAPI,} SysUtils, MySQLConst, GoogleConfigObj, DateTimeUtils,
  DbSharedObjectsObj, GoogleConst, ibgGCalendar, GoogleAuth, URILib,
  JsonObject;

{ TGoogleSynch }

function TGoogleSynch.AbortProcessing: boolean;
var
  Abort: boolean;
begin
  Abort := false;
  if Assigned(fOnProgress) then
    fOnProgress(Abort);
  result := Abort;
end;

constructor TGoogleSynch.Create;
begin
  Logger := nil;
end;

destructor TGoogleSynch.Destroy;
begin

  inherited;
end;

Function TGoogleSynch.DoSynch(SynchType: TGoogleSynchType): boolean;
var
  qryEmp, qryApp, qryCust, qryToDo: TERPQuery;
  cmdCust, cmdApp, cmdToDo: TERPCommand;
  userCalendar, globalCalendar: TibgGCalendar;
  s: string;
  IsNewAppointment: boolean;
  globalGoogleConfig: TGoogleConfig;
  refreshKey, authKey: string;
  found: boolean;
  x: integer;
  processEmployee: boolean;
  StatusDesc: string;

  function EventERPNotes(Cal: TibgGCalendar): string;
  var posNotes: integer;
  begin
    result := '';
    posNotes := Pos(NOTES_DELIM, JsonObject.DecodeString(Cal.EventDescription));
    if posNotes > 0 then begin
      result := Trim(Copy(JsonObject.DecodeString(Cal.EventDescription), posNotes + Length(NOTES_DELIM),Length(JsonObject.DecodeString(Cal.EventDescription))));
      posNotes:=  pos(NOTES_COMMENT, Cal.EventDescription);
      if posNotes > 0 then begin
        result := Trim(Copy(JsonObject.DecodeString(Cal.EventDescription),posNotes + Length(NOTES_Comment),Length(JsonObject.DecodeString(Cal.EventDescription))));
      end;
    end;
  end;

  procedure AddNote(Cal: TibgGCalendar; aNote: string);
  begin
    if Pos(NOTES_DELIM, JsonObject.DecodeString(Cal.EventDescription)) > 0 then begin
      Cal.EventDescription := JsonObject.EncodeString(JsonObject.DecodeString(Cal.EventDescription) + #13 + aNote);
    end
    else begin
      if Cal.EventDescription <> '' then Cal.EventDescription := JsonObject.EncodeString(JsonObject.DecodeString(Cal.EventDescription) + #13);
      Cal.EventDescription := JsonObject.EncodeString(NOTES_DELIM + ' ' + NOTES_COMMENT + #13 + aNote);
    end;
  end;

  function DefaultCompanyTypeId: integer;
  var
    qryType: TERPQuery;
    cmdType: TERPCommand;
  begin
    qryType := DbSharedObj.GetQuery(Connection);
    cmdType := DbSharedObj.GetCommand(Connection);
    try
      qryType.SQL.Text := 'select * from tblclienttype where TypeName = "Default"';
      qryType.Open;
      if qryType.IsEmpty then begin
        qryType.Insert;
        qryType.FieldByName('TypeName').AsString := 'Default';
        qryType.FieldByName('TypeDescription').AsString := 'Default';
        qryType.Post;
        cmdType.SQL.Add('update tblclienttype set');
        cmdType.SQL.Add('GlobalRef = Concat((select SiteCode from tblmsbackendid where BEDefault = "T" limit 1),ClientTypeId),');
        cmdType.SQL.Add('msUpdateSiteCode = (select SiteCode from tblmsbackendid where BEDefault = "T" limit 1)');
        cmdType.SQL.Add('where ClientTypeID = ' + IntToStr(qryType.FieldByName('ClientTypeId').AsInteger));
        cmdType.Execute;
      end;
      result := qryType.FieldByName('ClientTypeId').AsInteger;
    finally
      DbSharedObj.ReleaseObj(qryType);
      DbSharedObj.ReleaseObj(cmdType);
    end;
  end;

begin
  result := true;
  try
    userCalendar := TibgGCalendar.Create(nil);
    globalGoogleConfig := TGoogleConfig.Create;
    globalCalendar := nil;
    qryEmp := DbSharedObj.GetQuery(Connection);
    qryApp := DbSharedObj.GetQuery(Connection);
    try
      globalGoogleConfig.Load(Connection);
      if globalGoogleConfig.SynchWithGoogle then begin
        globalCalendar := TibgGCalendar.Create(nil);
        globalCalendar.Authorization := globalGoogleConfig.Password;
        try
          globalCalendar.ListCalendars;
        except
          on e: exception do begin
            if Pos('Invalid Credentials',e.Message) > 0 then begin
              if globalGoogleConfig.RefreshToken <> '' then begin
                { try to get new auth using the refresh token }
                refreshKey := globalGoogleConfig.RefreshToken;
                authKey := GetAuthorization(refreshKey);
                if authKey <> '' then begin
                  globalCalendar.Authorization := authKey;
                  globalCalendar.ListCalendars;
                  try
                    { save this new auth key }
                    globalGoogleConfig.Password := authKey;
                    globalGoogleConfig.Save(Connection);
                  except

                  end;
                end
                else begin
                  result := false;
                  Log('Credentials not set for global calendar ' + globalGoogleConfig.Email,ltError);
                  exit;
                end;
              end
              else begin
                result := false;
                Log('Invalid credentials for global calendar ' + globalGoogleConfig.Email, ltError);
                exit;
              end;
            end;
          end;
        end;
        { check for email account .. to make sure user has auth'ed correct account }

        found := false;
        for x := 0 to globalCalendar.CalendarCount -1 do begin
          globalCalendar.CalendarIndex := x;
          if SameText(globalCalendar.CalendarID, globalGoogleConfig.Email) then begin
            found := true;
            break;
          end;
        end;
        if not found then begin
          result := false;
          Log('Global calendar email (' + globalGoogleConfig.Email + ') not found for authorization provided.',ltError);
          exit;
        end;
      end;

      qryEmp.SQL.Text := 'select * from tblemployees where SynchWithGoogle = "T"';
      qryEmp.Open;
      Log('Found ' + IntToStr(qryEmp.RecordCount) + ' employees enabled for Google synch.',ltDetail);
      while not qryEmp.Eof do begin
        try
          processEmployee := true;
          Log('Checking employee ' + qryEmp.FieldByName('EmployeeName').AsString, ltDetail);
          if AbortProcessing then begin
            result := false;
            exit;
          end;
          if (qryEmp.FieldByName('GoogleEmail').AsString <> '') and (qryEmp.FieldByName('GooglePassword').AsString <> '') then begin
            userCalendar.EventIndex := -1;
            userCalendar.Authorization := qryEmp.FieldByName('GooglePassword').AsString;
            try
              userCalendar.ListCalendars;
            except
              on e: exception do begin
                if Pos('Invalid Credentials',e.Message) > 0 then begin
                  if qryEmp.FieldByName('GoogleRefreshPassword').AsString <> '' then begin
                    { try to get new auth using the refresh token }
                    refreshKey := qryEmp.FieldByName('GoogleRefreshPassword').AsString;
                    authKey := GetAuthorization(refreshKey);
                    if authKey <> '' then begin
                      userCalendar.Authorization := authKey;
                      userCalendar.ListCalendars;
                      try
                        { save this new auth key }
                        qryEmp.Edit;
                        qryEmp.FieldByName('GooglePassword').AsString := authKey;
                        qryEmp.Post;
                      except

                      end;
                    end
                    else begin
                      processEmployee := false;
                      Log('Credentials not set for user calendar ' + qryEmp.FieldByName('GoogleEmail').AsString,ltError);
                    end;
                  end
                  else begin
                    processEmployee := false;
                    Log('Invalid credentials for user calendar ' + qryEmp.FieldByName('GoogleEmail').AsString, ltError);
                  end;
                end;
              end;
            end;

            if processEmployee then
            try

              if SynchType in [gsCalendar, gsAll] then begin

                { synch calander events }
                userCalendar.QueryParamsCount := 2;
                userCalendar.QueryParamsName[0] := 'updatedMin';
                userCalendar.QueryParamsValue[0] := DateTimeLocalToRFC3339Str(self.LastSynchTime); //URILib.PercentEncode(DateTimeLocalToRFC3339Str(self.LastSynchTime));
                userCalendar.QueryParamsName[1] := 'showDeleted';
                userCalendar.QueryParamsValue[1] := 'true';
                userCalendar.ListEvents;

                for x := 0 to userCalendar.EventCount -1 do begin
                  userCalendar.EventIndex := x;
                 if AbortProcessing then begin
                    result := false;
                    exit;
                  end;
                  qryApp.Close;
                  qryApp.SQL.Text := 'select * from tblappointments where GoogleID = ' +  QuotedStr(userCalendar.EventId);
                  qryApp.Open;
                  IsNewAppointment := false;
                  if qryApp.IsEmpty then begin
                    { no linked appointment in ERP so create one }
                    qryCust := TERPQuery.Create(nil);
                    try
                      qryCust.Connection := Connection;
                      qryCust.SQL.Text := 'select * from  tblclients where Company = ' +
                        QuotedStr(userCalendar.EventSummary); // + ' and Customer = "T"';
                      qryCust.Open;
                      if qryCust.IsEmpty then begin
                        { not found  }
                        qryCust.Close;
                        qryCust.SQL.Text := 'select * from  tblclients where Company = "Unknown"';
                        qryCust.Open;
                        if qryCust.IsEmpty then begin
                          { create unknown customer }
                          qryCust.insert;
                          qryCust.FieldByName('Company').AsString := 'Unknown';
                          qryCust.FieldByName('Customer').AsBoolean := true;
                          qryCust.FieldByName('ClientTypeID').AsInteger := DefaultCompanyTypeId;
                          qryCust.Post;
                          cmdCust := TERPCommand.Create(nil);
                          try
                            cmdCust.Connection := Connection;
                            cmdCust.SQL.Add('update tblclients set');
                            cmdCust.SQL.Add('GlobalRef = Concat((select SiteCode from tblmsbackendid where BEDefault = "T" limit 1),ClientTypeId),');
                            cmdCust.SQL.Add('msUpdateSiteCode = (select SiteCode from tblmsbackendid where BEDefault = "T" limit 1)');
                            cmdCust.SQL.Add('where ClientID = ' + IntToStr(qryCust.FieldByName('ClientId').AsInteger));
                            cmdCust.Execute;
                          finally
                            cmdCust.Free;
                          end;
                          Log('Created "Unknown" customer',ltDetail);
                        end;
                        if not qryCust.FieldByName('Customer').AsBoolean then begin
                          qryCust.Edit;
                          qryCust.FieldByName('Customer').AsBoolean := true;
                          qryCust.FieldByName('ClientTypeID').AsInteger := DefaultCompanyTypeId;
                          qryCust.Post;
                        end;
                      end;

                      { create the appointment }
                      qryApp.Insert;
                      qryApp.FieldByName('CusId').AsInteger := qryCust.FieldByName('ClientId').AsInteger;
                      qryApp.FieldByName('ClientName').AsString := qryCust.FieldByName('Company').AsString;
                      qryApp.FieldByName('TrainerId').AsInteger := qryEmp.FieldByName('EmployeeId').AsInteger;
                      qryApp.FieldByName('LastTrainerId').AsInteger := qryEmp.FieldByName('EmployeeId').AsInteger;
                      qryApp.FieldByName('EnteredByEmployeeId').AsInteger := qryEmp.FieldByName('EmployeeId').AsInteger;
                      qryApp.FieldByName('EnteredByEmployeeName').AsString := qryEmp.FieldByName('EmployeeName').AsString;
                      qryApp.FieldByName('Status').AsString := 'Waiting';
                      qryApp.FieldByName('GoogleID').AsString := userCalendar.EventID;
                      qryApp.FieldByName('SynchWithGoogle').AsBoolean := true;
                      qryApp.FieldByName('Actual_AppDate').AsDateTime := Trunc(RFC3339StrToDateTime(userCalendar.EventStartDateTime));//   Trunc(calEvent.startTime.dateTime);
                      qryApp.FieldByName('CreationDate').AsDateTime := Trunc(RFC3339StrToDateTime(userCalendar.EventDateUpdated)); //Trunc(calEvent.updated);
                      qryApp.FieldByName('UpdateDate').AsDateTime := Trunc(RFC3339StrToDateTime(userCalendar.EventDateUpdated)); //Trunc(calEvent.updated);
                      qryApp.FieldByName('Actual_Start_time').AsString := FormatDateTime(MysqlTimeFormat12hr, RFC3339StrToDateTime(userCalendar.EventStartDateTime));
                      qryApp.FieldByName('Actual_End_time').AsString := FormatDateTime(MysqlTimeFormat12hr, RFC3339StrToDateTime(userCalendar.EventEndDateTime));
                      qryApp.FieldByName('Actual_StartTime').AsDateTime := RFC3339StrToDateTime(userCalendar.EventStartDateTime);
                      qryApp.FieldByName('Actual_EndTime').AsDateTime := RFC3339StrToDateTime(userCalendar.EventEndDateTime);
                      qryApp.FieldByName('GoogleUpdated').AsDateTime := RFC3339StrToDateTime(userCalendar.EventDateUpdated);
                      qryApp.Post;
                      cmdApp := TERPCommand.Create(nil);
                      try
                        cmdApp.Connection := Connection;
                        cmdApp.SQL.Add('update tblAppointments set');
                        cmdApp.SQL.Add('GlobalRef = Concat((select SiteCode from tblmsbackendid where BEDefault = "T" limit 1),AppointId),');
                        cmdApp.SQL.Add('msUpdateSiteCode = (select SiteCode from tblmsbackendid where BEDefault = "T" limit 1)');
                        cmdApp.SQL.Add('where AppointID = ' + IntToStr(qryApp.FieldByName('AppointId').AsInteger));
                        cmdApp.Execute;
                      finally
                        cmdApp.Free;
                      end;
                      Log('Found new Event on calander '+ qryEmp.FieldByName('GoogleEmail').AsString +
                        ', created appointment for ' + qryCust.FieldByName('Company').AsString,ltDetail);
                    finally
                      qryCust.Free;
                    end;
                    IsNewAppointment := true;
                  end;


                  if IsNewAppointment or (CompareDateTimeNoMS(RFC3339StrToDateTime(userCalendar.EventDateUpdated), qryApp.FieldByName('GoogleUpdated').AsDateTime) > 0) then begin
                    { .. has been updated on the web so update ERP record }
  //                  Log('      Start ' + FormatDateTime('dd/mm/yyyy hh:nn:ss.zzz',calEvent.updated) + '    ' +
  //                    FormatDateTime('dd/mm/yyyy hh:nn:ss.zzz',qryApp.FieldByName('GoogleUpdated').AsDateTime), ltDetail);
                      qryApp.Edit;
                      qryApp.FieldByName('StartTime').AsDateTime := RFC3339StrToDateTime(userCalendar.EventStartDateTime);
                      qryApp.FieldByName('EndTime').AsDateTime := RFC3339StrToDateTime(userCalendar.EventEndDateTime);
                      qryApp.FieldByName('Start_time').AsString := FormatDateTime(MysqlTimeFormat12hr, RFC3339StrToDateTime(userCalendar.EventStartDateTime));
                      qryApp.FieldByName('End_time').AsString := FormatDateTime(MysqlTimeFormat12hr, RFC3339StrToDateTime(userCalendar.EventEndDateTime));
                      qryApp.FieldByName('AppDate').AsDateTime := Trunc(RFC3339StrToDateTime(userCalendar.EventStartDateTime));

                      qryApp.FieldByName('Notes').AsString := EventERPNotes(userCalendar);
                      qryApp.FieldByName('Active').AsBoolean := userCalendar.EventStatus <> gcsCanceled;
(*
                      if not SameText(calEvent.summary, qryApp.FieldByName('ClientName').AsString) then begin
                        AddNote(calEvent,'Created for unknown customer: "' + calEvent.summary + '"');
                        calEvent.summary := qryApp.FieldByName('ClientName').AsString;
                        userGoogle.PrimaryCalendarEvents.update(calEvent);
                      end;
*)
                      qryApp.FieldByName('GoogleUpdated').AsDateTime := RFC3339StrToDateTime(userCalendar.EventDateUpdated);
                      qryApp.Post;
                      case
                        userCalendar.EventStatus of
                        gcsConfirmed: StatusDesc := 'Confirmed';
                        gcsTentative: StatusDesc := 'Tentative';
                        gcsCanceled: StatusDesc := 'Canceled';
                        else StatusDesc := 'Unknown';
                      end;
                      Log('User has updated item on calander (' + qryEmp.FieldByName('GoogleEmail').AsString +
                        ') for ' + userCalendar.EventSummary + ' date ' + qryApp.FieldByName('StartTime').AsString +
                        ' Status ' + StatusDesc + ' Id ' + userCalendar.EventId, ltDetail);
                  end;
                end;
              end;

              if SynchType in [gsERPCalandar, gsAll] then begin
                { check every (future) appointment in ERP Calander }

                qryApp.Close;
                qryApp.SQL.Text := 'select * from tblappointments where SynchWithGoogle = "T" ' +
                  'and TrainerId = ' + IntToStr(qryEmp.FieldByName('EmployeeId').AsInteger) + ' ' +
                  'and msTimeStamp >= "' + FormatDateTime(MysqlDateTimeFormat,LastSynchTime) + '"';

                qryApp.Open;
                while not qryApp.Eof do  begin
                  if AbortProcessing then begin
                    result := false;
                    exit;
                  end;

                  if (qryApp.FieldByName('GoogleId').AsString = '') then begin
                    { not found on google .. so add it }
                    if not qryApp.FieldByName('Active').AsBoolean then begin
                      qryApp.Next;
                      continue;
                    end;

                    { else create it }
                    userCalendar.eventIndex := -1;
                    userCalendar.EventStatus := gcsConfirmed;
                    userCalendar.EventStartDateTime := DateTimeLocalToRFC3339Str(qryApp.FieldByName('StartTime').AsDateTime);
                    userCalendar.EventEndDateTime := DateTimeLocalToRFC3339Str(qryApp.FieldByName('EndTime').AsDateTime);

                    if not qryApp.FieldByName('Unavailable').AsBoolean then
                      userCalendar.EventSummary := qryApp.FieldByName('ClientName').AsString
                    else
                      userCalendar.EventSummary := 'Unavailable';
                    userCalendar.EventDescription := JsonObject.EncodeString(qryApp.FieldByName('CustomerDetails').AsString + #13 +
                      NOTES_DELIM + ' ' + NOTES_Comment + #13 + Trim(qryApp.FieldByName('Notes').AsString));
                    userCalendar.CreateEvent;

                    if (qryApp.FieldByName('GoogleId').AsString <> userCalendar.EventId) or
                      (CompareDateTimeNoMS(qryApp.FieldByName('GoogleUpdated').AsDateTime, RFC3339StrToDateTime(userCalendar.EventDateUpdated)) <>0) then begin
                      qryApp.Edit;
                      qryApp.FieldByName('GoogleId').AsString := userCalendar.EventId;
                      qryApp.FieldByName('GoogleUpdated').AsDateTime := RFC3339StrToDateTime(userCalendar.EventDateUpdated);
                      qryApp.Post;
                    end;
                    case
                      userCalendar.EventStatus of
                      gcsConfirmed: StatusDesc := 'Confirmed';
                      gcsTentative: StatusDesc := 'Tentative';
                      gcsCanceled: StatusDesc := 'Canceled';
                      else StatusDesc := 'Unknown';
                    end;
                    Log('Added appointment to calander (' + qryEmp.FieldByName('GoogleEmail').AsString +
                      ') for ' + userCalendar.EventSummary + ' date ' + qryApp.FieldByName('StartTime').AsString +
                      ' Status ' + StatusDesc + ' Id ' + userCalendar.EventId, ltDetail);


                  end
                  else begin

                    userCalendar.EventIndex := -1;
                    userCalendar.GetEvent(qryApp.FieldByName('GoogleId').AsString);
                    if userCalendar.EventIndex < 0 then begin
                      qryApp.Next;
                      continue;
                    end;
                    case CompareDateTimeNoMS(RFC3339StrToDateTime(userCalendar.EventDateUpdated), qryApp.FieldByName('GoogleUpdated').AsDateTime) of
                      1: begin
                           { google is newer }
                          qryApp.Edit;
                          qryApp.FieldByName('StartTime').AsDateTime := RFC3339StrToDateTime(userCalendar.EventStartDateTime);
                          qryApp.FieldByName('EndTime').AsDateTime := RFC3339StrToDateTime(userCalendar.EventEndDateTime);
                          qryApp.FieldByName('Start_time').AsString := FormatDateTime(MysqlTimeFormat12hr, RFC3339StrToDateTime(userCalendar.EventStartDateTime));
                          qryApp.FieldByName('End_time').AsString := FormatDateTime(MysqlTimeFormat12hr, RFC3339StrToDateTime(userCalendar.EventEndDateTime));
                          qryApp.FieldByName('AppDate').AsDateTime := Trunc(RFC3339StrToDateTime(userCalendar.EventStartDateTime));

                          qryApp.FieldByName('Notes').AsString := EventERPNotes(userCalendar);
                          qryApp.FieldByName('Active').AsBoolean := userCalendar.EventStatus <> gcsCanceled;
                          qryApp.FieldByName('GoogleUpdated').AsDateTime := RFC3339StrToDateTime(userCalendar.EventDateUpdated);
                          qryApp.Post;
                          case
                            userCalendar.EventStatus of
                            gcsConfirmed: StatusDesc := 'Confirmed';
                            gcsTentative: StatusDesc := 'Tentative';
                            gcsCanceled: StatusDesc := 'Canceled';
                            else StatusDesc := 'Unknown';
                          end;
                          Log('User has updated item on calander (' + qryEmp.FieldByName('GoogleEmail').AsString +
                            ') for ' + userCalendar.EventSummary + ' date ' + qryApp.FieldByName('StartTime').AsString +
                            ' Status ' + StatusDesc + ' Id ' + userCalendar.EventId, ltDetail);
                         end;
                      -1: begin
                          { appointment is newer }
                          userCalendar.EventStartDateTime := DateTimeLocalToRFC3339Str(qryApp.FieldByName('StartTime').AsDateTime);
                          userCalendar.EventEndDateTime := DateTimeLocalToRFC3339Str(qryApp.FieldByName('EndTime').AsDateTime);

                          if not qryApp.FieldByName('Unavailable').AsBoolean then
                            userCalendar.EventSummary := qryApp.FieldByName('ClientName').AsString
                          else
                            userCalendar.EventSummary := 'Unavailable';
                          userCalendar.EventDescription := JsonObject.EncodeString(qryApp.FieldByName('CustomerDetails').AsString + #13 +
                            NOTES_DELIM + ' ' + NOTES_Comment + #13 + Trim(qryApp.FieldByName('Notes').AsString));

                          if not qryApp.FieldByName('Active').AsBoolean then begin
                            { delete it }
//                            globalGoogle.PrimaryCalendarEvents.delete(calEvent.id);
                            userCalendar.DeleteEvent;
                          end
                          else begin
                            { update it }
                            userCalendar.EventStatus := gcsConfirmed;
                            userCalendar.UpdateEvent;
                          end;

                          if not qryApp.FieldByName('Active').AsBoolean then begin
                            qryApp.Next;
                            continue;
                          end;

                          if (qryApp.FieldByName('GoogleId').AsString <> userCalendar.EventId) or
                            (CompareDateTimeNoMS(qryApp.FieldByName('GoogleUpdated').AsDateTime, RFC3339StrToDateTime(userCalendar.EventDateUpdated)) <>0) then begin
                            qryApp.Edit;
                            qryApp.FieldByName('GoogleId').AsString := userCalendar.EventId;
                            qryApp.FieldByName('GoogleUpdated').AsDateTime := RFC3339StrToDateTime(userCalendar.EventDateUpdated);
                            qryApp.Post;
                          end;
                          case
                            userCalendar.EventStatus of
                            gcsConfirmed: StatusDesc := 'Confirmed';
                            gcsTentative: StatusDesc := 'Tentative';
                            gcsCanceled: StatusDesc := 'Canceled';
                            else StatusDesc := 'Unknown';
                          end;
                          Log('User has updated appointment in ERP (' + qryEmp.FieldByName('GoogleEmail').AsString +
                            ') for ' + userCalendar.EventSummary + ' date ' + qryApp.FieldByName('StartTime').AsString +
                            ' Status ' + StatusDesc + ' Id ' + userCalendar.EventId, ltDetail);

                         end;
                    end;

                  end;

                  qryApp.Next;
                end;

              end;

              if SynchType in [gsTask, gsAll] then begin

                { NOTE: we are currently not synching tasks so just exit }
                exit;

                { synch tasks }
//                try
//                  globalGoogle.TaskLists.DefaultList.Tasks.ShowCompleted := true;
//                except
//                  on e: exception do begin
//                    Log('Error getting shared Default Task List for ' + globalGoogleConfig.Email + ' with error: ' + e.Message, ltError);
//                    FreeAndNil(globalGoogle);
//                  end;
//                end;
//                if Assigned(globalGoogle) then begin
//                  globalGoogle.TaskLists.DefaultList.Tasks.ShowHidden := true;
//                  globalGoogle.TaskLists.DefaultList.Tasks.ShowDeleted := true;
//                  globalGoogle.TaskLists.DefaultList.Tasks.UpdatedMin := self.LastSynchTime;
//                  try
//                    globalGoogle.TaskLists.DefaultList.Tasks.list; { force loading of list }
//                  except
//                    on e: exception do begin
//                      Log('Error getting shared Task List for ' + globalGoogleConfig.Email + ' with error: ' + e.Message, ltError);
//                      FreeAndNil(globalGoogle);
//                    end;
//                  end
//                end;
//
//                userGoogle.TaskLists.DefaultList.Tasks.ShowCompleted := true;
//                userGoogle.TaskLists.DefaultList.Tasks.ShowHidden := true;
//                userGoogle.TaskLists.DefaultList.Tasks.ShowDeleted := true;
//                userGoogle.TaskLists.DefaultList.Tasks.UpdatedMin := self.LastSynchTime;
//                qryToDo := TERPQuery.Create(nil);
//                cmdToDo := TERPCommand.Create(nil);
//                try
//                  qryToDo.Connection := Connection;
//                  cmdToDo.Connection := Connection;
//                  for task in userGoogle.TaskLists.DefaultList.Tasks.list do begin
//                    if AbortProcessing then begin
//                      result := false;
//                      exit;
//                    end;
//                    globalTask := nil;
//                    qryToDo.SQL.Text := 'select * from tbltodo where GoogleID = ' + QuotedStr(task.id);
//                    qryToDo.Open;
//                    if qryToDo.IsEmpty then begin
//                      if task.deleted then
//                        continue; { it has been deleted so we don't need to add it to erp }
//                      globalTask := nil;
//                      if Assigned(globalGoogle) then begin
//                        { add task to shared task list }
//                        globalTask := TTAsk.Create(globalGoogle.Connection);
//                        globalTask.AsString := task.AsString;
//                        globalTask.id := '';
//                        globalGoogle.TaskLists.DefaultList.Tasks.insert(globalTask);
//                      end;
//
//
//                      { ToDo not in ERP .. so create it }
//                      qryToDo.Insert;
//                      qryToDo.FieldByName('Type').AsString := 'ToDo';
//                      qryToDo.FieldByName('CreatedDate').AsDateTime := task.updated;
//                      qryToDo.FieldByName('EmployeeID').AsInteger := qryEmp.FieldByName('EmployeeId').AsInteger;
//                      qryToDo.FieldByName('Description').AsString := task.title + #13 + task.notes;
//                      qryToDo.FieldByName('ToDoByDate').AsDateTime := task.due;
//                      qryToDo.FieldByName('CreatedByEmployeeID').AsInteger := qryEmp.FieldByName('EmployeeId').AsInteger;
//                      qryToDo.FieldByName('GoogleID').AsString := task.id;
//                      qryToDo.FieldByName('GoogleUpdated').AsDateTime := task.updated;
//                      if assigned(globalTask) then begin
//                        qryToDo.FieldByName('MasterGoogleID').AsString := globalTask.id;
//                        qryToDo.FieldByName('MasterGoogleUpdated').AsDateTime := globalTask.updated;
//                      end;
//                      qryToDo.Post;
//                      cmdToDo.SQL.Add('update tbltodo set');
//                      cmdToDo.SQL.Add('GlobalRef = Concat((select SiteCode from tblmsbackendid where BEDefault = "T" limit 1),ToDoId),');
//                      cmdToDo.SQL.Add('msUpdateSiteCode = (select SiteCode from tblmsbackendid where BEDefault = "T" limit 1)');
//                      cmdToDo.SQL.Add('where ToDoID = ' + IntToStr(qryToDo.FieldByName('ToDoId').AsInteger));
//                      cmdToDo.Execute;
//                    end
//                    else begin
//                      { todo exists in in erp }
//                      { see if we have a task on the shared task list .. }
//                      if Assigned(globalGoogle) and (qryToDo.FieldByName('MasterGoogleId').AsString <> '') then begin
//                        globalTask := globalGoogle.TaskLists.DefaultList.Tasks.get(qryToDo.FieldByName('MasterGoogleId').AsString);
//                      end;
//
//                      {  which data is newer ..}
//                      if (CompareDateTimeNoMS(task.updated, qryToDo.FieldByName('GoogleUpdated').AsDateTime) > 0) or
//                         (Assigned(globalTask) and  (CompareDateTimeNoMS(globalTask.updated, qryToDo.FieldByName('MasterGoogleUpdated').AsDateTime)>0)) then begin
//                        { one of both tasks are newer than todo }
//                        if Assigned(globalTask) then begin //  and (globalTask.updated > qryToDo.FieldByName('MasterGoogleUpdated').AsDateTime) then begin
//                          //{ both tasks have been updated }
//                          if CompareDateTimeNoMS(task.updated, globalTask.updated) > 0 then begin
//                            globalTask.title := task.title;
//                            globalTask.notes := task.notes;
//                            globalTask.status := task.status;
//                            globalTask.due := task.due;
//                            if task.completed > 0 then
//                              globalTask.completed := task.completed
//                            else
//                              globalTask.Data.Delete('completed');
//                            globalTask.deleted := task.deleted;
//                            globalTask.hidden := task.hidden;
//                            globalTask.Data.A['Links'].AsString := task.Data.A['Links'].AsString;
//                            globalGoogle.TaskLists.DefaultList.Tasks.update(globalTask);
//                          end
//                          else begin
//                            task.title := globalTask.title;
//                            task.notes := globalTask.notes;
//                            task.status := globalTask.status;
//                            task.due := globalTask.due;
//                            if globalTask.completed > 0 then
//                              task.completed := globalTask.completed
//                            else
//                              task.Data.Delete('completed');
//                            task.deleted := globalTask.deleted;
//                            task.hidden := globalTask.hidden;
//                            task.Data.A['Links'].AsString := globalTask.Data.A['Links'].AsString;
//                            userGoogle.TaskLists.DefaultList.Tasks.update(task);
//                          end;
//                        end;
//
//                        { update the todo .. }
//                        qryToDo.Edit;
//                        qryToDo.FieldByName('Description').AsString := task.title + #13 + task.notes;
//                        qryToDo.FieldByName('ToDoByDate').AsDateTime := task.due;
//                        qryToDo.FieldByName('GoogleUpdated').AsDateTime := task.updated;
//                        qryToDo.FieldByName('Completed').AsBoolean := task.status = 'completed';
//                        if Assigned(globalTask) then begin
//                          qryToDo.FieldByName('MasterGoogleUpdated').AsDateTime := globalTask.updated;
//                        end;
//                        qryToDo.Post;
//                      end
//                    end;
//                  end;
//                  if Assigned(globalGoogle) then begin
//                    { check for changes in shared task list }
//                    for globalTask in globalGoogle.TaskLists.DefaultList.Tasks.list do begin
//                      if AbortProcessing then begin
//                        result := false;
//                        exit;
//                      end;
//                      qryToDo.SQL.Text := 'select * from tbltodo where MasterGoogleID = ' + QuotedStr(globalTask.id);
//                      qryToDo.Open;
//                      if qryToDo.IsEmpty then begin
//                        { ignore this .. we are not creating todo's when someone adds a
//                          task to the shared list because we do not know who added it
//                          and we don't want it appearing on everyones private task lists }
//                      end
//                      else begin
//                        { found .. get the users task }
//                        task := userGoogle.TaskLists.DefaultList.Tasks.get(qryToDo.FieldByName('GoogleID').AsString);
//
//                        { found .. does it need updating }
//                        {  which data is newer ..}
//                        if (Assigned(task) and (CompareDateTimeNoMS(task.updated, qryToDo.FieldByName('GoogleUpdated').AsDateTime)>0)) or
//                           (CompareDateTimeNoMS(globalTask.updated, qryToDo.FieldByName('MasterGoogleUpdated').AsDateTime)>0) then begin
//                          { one of both tasks are newer than todo }
//                          if Assigned(task) then begin // and (task.updated > qryToDo.FieldByName('GoogleUpdated').AsDateTime) then begin
//                            //{ both tasks have been updated }
//                            if CompareDateTimeNoMS(task.updated, globalTask.updated) > 0 then begin
//                              task.title := globalTask.title;
//                              task.notes := globalTask.notes;
//                              task.status := globalTask.status;
//                              task.due := globalTask.due;
//                              if task.completed > 0 then
//                                globalTask.completed := task.completed
//                              else
//                                globalTask.Data.Delete('completed');
//                              task.deleted := globalTask.deleted;
//                              task.hidden := globalTask.hidden;
//                              task.Data.A['Links'].AsString := globalTask.Data.A['Links'].AsString;
//                              userGoogle.TaskLists.DefaultList.Tasks.update(task);
//                            end
//                            else begin
//                              globalTask.title := task.title;
//                              globalTask.notes := task.notes;
//                              globalTask.status := task.status;
//                              globalTask.due := task.due;
//                              if task.completed > 0 then
//                                globalTask.completed := task.completed
//                              else
//                                globalTask.Data.Delete('completed');
//                              globalTask.deleted := task.deleted;
//                              globalTask.hidden := task.hidden;
//                              globalTask.Data.A['Links'].AsString := task.Data.A['Links'].AsString;
//                              globalGoogle.TaskLists.DefaultList.Tasks.update(globalTask);
//                            end;
//                          end;
//                          { update the todo .. }
//                          qryToDo.Edit;
//                          qryToDo.FieldByName('Description').AsString := globalTask.title + #13 + task.notes;
//                          qryToDo.FieldByName('ToDoByDateDate').AsDateTime := globalTask.due;
//                          qryToDo.FieldByName('Completed').AsBoolean := globalTask.status = 'completed';
//                          if Assigned(task) then begin
//                            qryToDo.FieldByName('GoogleUpdated').AsDateTime := task.updated;
//                          end;
//                          qryToDo.FieldByName('MasterGoogleUpdated').AsDateTime := globalTask.updated;
//                          qryToDo.Post;
//                        end;
//
//
//                      end;
//                    end;
//                  end;
//                finally
//                  qryToDo.Free;
//                  cmdToDo.Free;
//                end;
              end;  { end of tasks }

            finally
//              userGoogle.Connection.Disconnect;
            end;
          end;
        except
          on e: exception do begin
            result := false;
            Log('Error synching with Google for ' +  Connection.Database + ' ' +
              qryEmp.FieldByName('EmployeeName').AsString + ': ' + e.Message, ltError);
          end;
        end;
        qryEmp.Next;
      end;
    finally
      DbSharedObj.ReleaseObj(qryEmp);
      DbSharedObj.ReleaseObj(qryApp);
      userCalendar.Free;
      globalCalendar.Free;
      globalGoogleConfig.Free;
    end;
  except
    on e: exception do begin
      result := false;
      Log('Error synching with Google for ' +
        Connection.Database + ': ' + e.Message, ltError);
    end;
  end;
end;

procedure TGoogleSynch.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  if Assigned(Logger) then
    Logger.Log(msg,LogMessageType);
  if Assigned(fOnLog) then
    fOnLog(msg, LogMessageType);
end;

end.
