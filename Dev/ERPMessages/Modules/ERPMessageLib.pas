unit ERPMessageLib;

interface

uses
  ERPMessageTypes;

  function NextERPMessage(fERPMessageType : TERPMessageType; var HyperlinkText :String; UpdateasViewed:Boolean =True;ShowViewed:Boolean =True;PopupID:Integer =0;TimerInterval:Integer=0):String;
  function Check4PurgeReminderPopup: String;
  function Check4ToDoPopup(UpdateasViewed: Boolean): String;

var
  fbcheckedforAuditPurge:Boolean;
  dtcheckedforAuditPurge :TDateTime;
  LastToDoTime: TDateTime;

implementation

uses ERPdbComponents,DbSharedObjectsObj, CommonDbLib, sysutils, AppEnvironment,
  CommonLib, dateutils, SystemLib, MAIN;

function Check4PurgeReminderPopup:String;
var
  Qry: TERPQuery;
begin
  REsult := '';
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    Qry.SQL.text := 'Select count( * ) ctr from tblaudittriallines';
    Qry.open;
    if Qry.fieldbyname('ctr').asInteger > 1000000 then
      Result := 'Please Purge the Audit Trail Immediatley.'
    else if Qry.fieldbyname('ctr').asInteger > 600000 then
      Result := 'The Audit Trail is getting bigger, Please Consider Purging it.'
    else if Qry.fieldbyname('ctr').asInteger > 400000 then
      Result := 'Please Consider Purging the Audit Trail.';
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

function Check4ToDoPopup(UpdateasViewed: Boolean): String;
var
  qry: TERPQuery;
  x: integer;
begin
  result := '';
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    Qry.SQL.text :=
      'Select * from tbltodo' +
      ' where ToDoByDate > ' + QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss',LastToDoTime)) +
      ' and Completed = "F"' +
      ' and Active = "T"' +
      ' and  EmployeeID = ' + IntToStr(AppEnv.Employee.EmployeeID);
    Qry.open;
    x := 1;
    while not qry.Eof do begin
      if x <= 10 then begin
        if result <> '' then result := result + #13#10;
        result := result + qry.FieldByName('Description').AsString;
      end;
      if UpdateasViewed then
        LastToDoTime := qry.FieldByName('ToDoByDate').AsDateTime;
      Inc(x);
      qry.Next;
    end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
  if result <> '' then
    MainForm.StatusBar.Panels[7].Text := '<FONT COLOR="#800000" size=10><B><Blink>New To Do Item</Blink></B></FONT>';
end;

function NextERPMessage(fERPMessageType : TERPMessageType; var HyperlinkText :String;
  UpdateasViewed: Boolean =True; ShowViewed:Boolean = True;
  PopupID:Integer =0; TimerInterval: Integer=0):String;
var
  Qry:TERPQuery;
  TaskID:Integer;
  Function checkedforAuditPurge:Boolean;
  begin
    if (DebugHook <> 0) then  // Ignore purge if in IDE **GH** 2022.03.24
      Exit(True);
    REsult := false;
    if not (fbcheckedforAuditPurge) then exit;
    if TimerInterval <> 0 then
      if dtcheckedforAuditPurge < IncMilliSecond(now ,0-TimerInterval) then exit;
    Result := true;
  end;
begin
  result := '';
  Qry := DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    closeDB(Qry);
    Qry.SQL.Text := 'Select ' +
                    ' T.ID,T.Subject,T.Details , T.HyperlinkText ' +
                    ' From erpdocumentaion.tbltasks T ' +
                    ' left join tbluserviewedtasks UT on T.ID = UT.TasksID and UserID =' +   inttostr(appenv.employee.EmployeeID)+
                    iif(PopupID <>0 , ' Where T.ID = ' +inttostr(PopupID) ,
                    ' Where T.active ="T" and T.TaskType ='+ Quotedstr(ERPMessageTypeToStr(fERPMessageType)) +
                    iif(ShowViewed , iif(TimerInterval<>0 , 'and ((ifnull(UT.ID,0) =0) or (UT.ViewedOn < DATE_Sub(NOW(),INTERVAL ' + inttostr(trunc(TimerInterval/1000))+' SECOND)  )) ' , '') , ' and ifnull(UT.ID,0) =0')) +
                    ' Order by UT.ViewedOn, T.CreatedOn '+
                    ' Limit 1';
    Qry.Open;
    if qry.recordcount =0 then begin
      result := Check4ToDoPopup(UpdateasViewed);
      if result <> '' then begin
        if AppEnv.CompanyPrefs.ShowToDoNotifications then
          exit
        else
          result := '';
      end;
      if (fERPMessageType = mtpopup) and  not(checkedforAuditPurge) then begin
        result := Check4PurgeReminderPopup;
        if UpdateasViewed then begin
          fbcheckedforAuditPurge:= true;
          dtcheckedforAuditPurge := now;
        end;
      end;
      exit;
    end;

    Result := Qry.fieldbyname('Details').asString;

    HyperlinkText := Qry.fieldbyname('HyperlinkText').asString;
    if UpdateasViewed then begin
      TaskID:=Qry.fieldbyname('ID').asInteger;
      closeDB(Qry);
      Qry.SQL.text := 'insert into tbluserviewedtasks (TasksID, UserID, ViewedOn) ' +
                    ' select ID,' +inttostr(appenv.employee.EmployeeID)+' , Now()  from erpdocumentaion.tbltasks Where ID = '+ inttostr(TaskID) +' ON DUPLICATE KEY UPDATE ViewedOn = Now();';
      Qry.Execute;
    end;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;

initialization
  fbcheckedforAuditPurge:=False;
  dtcheckedforAuditPurge := 0;
  LastToDoTime := Date -1;
end.
