unit PromptWithPopupObj;

interface

uses
   Classes, AdvAlertWindow, Windows, Messages, Menus, AdvMenus, ExtCtrls,
   MessageInterface;

type
  TPopupMessageType = (mtNone, mtMarketing, mtToDo, mtMessage);

  TRemindOption = (roNone, ro5Min, ro10Min, ro15Min, ro30Min, ro1Hour, ro2Hour, ro1Day, ro1Week);
  TRemindOptionInfo = array[Low(TRemindOption)..High(TRemindOption)] of string;

  TPopupMessage = class
    PopupMessageType: TPopupMessageType;
    ID: Integer;
    ReminderDate: TDateTime;
  end;

const
  RemindCaption: TRemindOptionInfo = ('','5 minutes','10 minutes','15 minutes','30 minutes','1 Hour','2 Hours','1 Day','1 Week');

type
  TPromptPopup = class(TComponent)
  private
    MsgStrLst: TStringList;
    CloseTimer: TTimer;
    PopupWindow: TAdvAlertWindow;
    PopupWindowPopupMenu: TAdvPopupMenu;
    mnuRemindedAgainIn: TMenuItem;
    mnu5minutes: TMenuItem;
    mnu10minutes: TMenuItem;
    mnu15minutes: TMenuItem;
    mnu30minutes: TMenuItem;
    mnu1Hour: TMenuItem;
    mnu2Hours: TMenuItem;
    mnu1Day: TMenuItem;
    mnu1Week: TMenuItem;
    FMsgHandler: TMsgHandler;

    procedure PopupWindowClose(Sender: TObject);
    procedure PopupWindowDeleteMessage(Sender: TObject; index: Integer);
    procedure PopupWindowAlertClick(Sender: TObject);
    procedure PopupMenuClick(Sender: TObject);
    procedure TimerTriggered(Sender: TObject);

    // Internal
    function CheckForPrompts: Integer;
    procedure AddPromptMessages(Const MsgList: TStringList);
    procedure GetMarketingPrompts(Const MsgList: TStringList);
    procedure GetMessagePrompts(Const MsgList: TStringList);
    procedure GetToDoPrompts(Const MsgList: TStringList);
    function ChangeRemindInTime(Const RemindInCaption: String; const Time: TDateTime): TDateTime;

    function RemindCaptionToRemindOption(const RemindCaptionStr: string): TRemindOption;

    procedure ExecuteSql(Const SqlStr: String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    procedure DoCheckForPrompts(MsgObj: TMsgObj; out ResponseObj: TMsgObj);
  end;

implementation
  uses FastFuncs, MyAccess,ERPdbComponents, CommonLib, CommonDBLib, Sysutils,  BaseInputForm,
        DateUtils, Forms, AppEnvironment, Dialogs, MySQLConst;

{ TPromptPopup }

procedure TPromptPopup.TimerTriggered(Sender: TObject);
begin
  CloseTimer.Enabled := False;
  PopupWindow.CloseAlert;
end;

procedure TPromptPopup.PopupWindowClose(Sender: TObject);
begin

end;

procedure TPromptPopup.AddPromptMessages(const MsgList: TStringList);
var
  MsgItem: TMsgCollectionItem;
  MsgStr: string;
  I: Integer;
begin
  PopupWindow.MaxHeight := TForm(FindExistingComponent('TMainForm')).Height - 120;
  PopupWindow.AlertMessages.Clear;
  for I := 0 to MsgList.Count -1 do Begin
    MsgItem := PopupWindow.AlertMessages.Add;
    MsgStr := MsgList[I];
    if char_length(MsgStr) > 0 then begin
      MsgItem.Text.AddObject(MsgStr,MsgList.Objects[I]);
    end;
  end;
end;

constructor TPromptPopup.Create(AOwner: TComponent);
begin
  inherited;
  CloseTimer := TTimer.Create(Self);
  CloseTimer.Enabled := False;
  CloseTimer.Interval := 1000;
  CloseTimer.OnTimer := TimerTriggered;

  MsgStrLst := TStringList.Create;

  //Popup Menu
  PopupWindowPopupMenu := TAdvPopupMenu.Create(Self);
  PopupWindowPopupMenu.AutoHotkeys := maManual; 
  mnuRemindedAgainIn := TMenuItem.Create(Self);
  mnu5minutes := TMenuItem.Create(Self);
  mnu10minutes := TMenuItem.Create(Self);
  mnu15minutes := TMenuItem.Create(Self);
  mnu30minutes := TMenuItem.Create(Self);
  mnu1Hour := TMenuItem.Create(Self);
  mnu2Hours := TMenuItem.Create(Self);
  mnu1Day := TMenuItem.Create(Self);
  mnu1Week := TMenuItem.Create(Self);
  PopupWindowPopupMenu.Items.Add(mnuRemindedAgainIn);
  mnuRemindedAgainIn.Caption := 'Remind In';
  mnuRemindedAgainIn.Add(mnu5minutes);
  mnuRemindedAgainIn.Add(mnu10minutes);
  mnuRemindedAgainIn.Add(mnu15minutes);
  mnuRemindedAgainIn.Add(mnu30minutes);
  mnuRemindedAgainIn.Add(mnu1Hour);
  mnuRemindedAgainIn.Add(mnu2Hours);
  mnuRemindedAgainIn.Add(mnu1Day);
  mnuRemindedAgainIn.Add(mnu1Week);
  mnu5minutes.OnClick := PopupMenuClick;
  mnu10minutes.OnClick := PopupMenuClick;
  mnu15minutes.OnClick := PopupMenuClick;
  mnu30minutes.OnClick := PopupMenuClick;
  mnu1Hour.OnClick := PopupMenuClick;
  mnu2Hours.OnClick := PopupMenuClick;
  mnu1Day.OnClick := PopupMenuClick;
  mnu1Week.OnClick := PopupMenuClick;
  mnu5minutes.Caption := RemindCaption[ro5Min];
  mnu10minutes.Caption := RemindCaption[ro10Min];
  mnu15minutes.Caption := RemindCaption[ro15Min];
  mnu30minutes.Caption := RemindCaption[ro30Min];
  mnu1Hour.Caption := RemindCaption[ro1Hour];
  mnu2Hours.Caption := RemindCaption[ro2Hour];
  mnu1Day.Caption := RemindCaption[ro1Day];
  mnu1Week.Caption := RemindCaption[ro1Week];


  // Popup Window
  PopupWindow := TAdvAlertWindow.Create(Application.MainForm);
  PopupWindow.OnClose := PopupWindowClose;
  PopupWindow.OnDeleteMessage  := PopupWindowDeleteMessage;
  PopupWindow.OnAlertClick := PopupWindowAlertClick;
  PopupWindow.AlwaysOnTop := True;
  PopupWindow.Style := asOffice2003Silver;
  PopupWindow.ShowScrollers := True;
  PopupWindow.ShowDelete := True;
  PopupWindow.AutoHide := False;
  PopupWindow.PositionFormat := 'Reminder %d of %d';
  PopupWindow.ShowPopup := True;
  PopupWindow.PopupMenu := PopupWindowPopupMenu;
  FMsgHandler := TMsgHandler.Create(Self);
end;

destructor TPromptPopup.Destroy;
begin
  PopupWindow.AlertMessages.Clear;
  PopupWindow.CloseAlert;
  try
    { getting AV here sometimes, maybe mainform close has already Destroyed PopupWindow }
    FreeAndNil(PopupWindow);
  except
  end;
  FreeAndNil(MsgStrLst);
  FreeAndNil(FMsgHandler);
  inherited;
end;

function TPromptPopup.CheckForPrompts: Integer;
begin
  MsgStrLst.Clear;

  // Get Prompts
  If AppEnv.Employee.PopRemindersToDo then GetToDoPrompts(MsgStrLst);
  If AppEnv.Employee.PopRemindersMFollowup then GetMarketingPrompts(MsgStrLst);
  If AppEnv.Employee.PopRemindersMessages then GetMessagePrompts(MsgStrLst);
  //

  If (MsgStrLst.Count > 0) then begin
    AddPromptMessages(MsgStrLst);
    If PopupWindow.AlertMessages.Count=1 then
     PopupWindow.ShowDelete := False;
    PopupWindow.Show;
    PopupWindow.First;
  end;

  Result := MsgStrLst.Count;
end;

procedure TPromptPopup.GetToDoPrompts(const MsgList: TStringList);
var
  qry: TERPQuery;
  tmpPopupMsg: TPopupMessage;
  msg:String;
begin
  qry := TERPQuery.Create(Self);
  qry.Options.FlatBuffers := True;
  try
    with qry do begin
      Connection := GetSharedMyDacConnection;
      SQL.Add('SELECT ');
      SQL.Add('tbltodo.ToDoID, ');
      SQL.Add('tbltodo.Description, ');
      SQL.Add('tbltodo.ToDoByDate ');
      SQL.Add('FROM tbltodo ');
      SQL.Add('WHERE tbltodo.EmployeeID = '+IntToStr(AppEnv.Employee.EmployeeID)+' ');
      SQL.Add('AND tbltodo.Completed <> "T" ');
      SQL.Add('AND tbltodo.ToDoByDate Between "2006-01-01" AND Now() ');
      SQL.Add('ORDER BY tbltodo.ToDoByDate ASC; ');
      Open;
      if (RecordCount>0) then begin
        First;
        While Not EOF do Begin
          tmpPopupMsg := TPopupMessage.Create;
          tmpPopupMsg.PopupMessageType := mtToDo;
          tmpPopupMsg.ReminderDate := FieldByName('ToDoByDate').AsDateTime;
          tmpPopupMsg.ID := FieldByName('ToDoID').asInteger;
          msg := ' <B><SHAD>To Do</SHAD></B> :- '+ #13#10#13#10+
                 #9+'<SHAD>When:</SHAD>'+'<IND x="90">'+DateTimeToStr(FieldByName('ToDoByDate').AsDateTime)+ #13#10+
                 #9+'<SHAD>What:</SHAD>'+'<IND x="90">'+FieldByName('Description').AsString;
          MsgList.AddObject(msg,tmpPopupMsg);
          Next;
        end;
      end
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TPromptPopup.GetMarketingPrompts(const MsgList: TStringList);
var
  qry: TERPQuery;
  tmpPopupMsg: TPopupMessage;
  msg:String;
begin
  qry := TERPQuery.Create(Self);
  qry.Options.FlatBuffers := True;
  try
    with qry do begin
      Connection := GetSharedMyDacConnection;
      SQL.Add('SELECT ');
      SQL.Add('tblmarketingcontacts.ID, ');
      SQL.Add('tblMarketingleadlines.FollowUpDate, ');
      SQL.Add('tblmarketingcontacts.COMPANY, ');
      SQL.Add('tblMarketingleadlines.EmployeeName ');
      SQL.Add('FROM tblMarketingleadlines ');
      SQL.Add('inner join tblMarketingleads on tblMarketingleads.LeadId = tblMarketingleadlines.LeadID');
      SQL.Add('Inner Join tblmarketingcontacts ON tblmarketingcontacts.ID = tblMarketingleads.MArketingcontactID');
      SQL.Add('WHERE tblMarketingleadlines.EmployeeID = '+IntToStr(AppEnv.Employee.EmployeeID)+' ');
      SQL.Add('AND tblMarketingleadlines.ResultTypeName = "Follow-up" ');
      SQL.Add('AND tblMarketingleadlines.Done <> "T" ');
      SQL.Add('AND tblMarketingleadlines.FollowUpDate Between "2006-01-01" AND Now() ');
      SQL.Add('ORDER BY tblMarketingleadlines.FollowUpDate ASC; ');
      Open;
      if (RecordCount>0) then begin
        First;
        While Not EOF do Begin
          tmpPopupMsg := TPopupMessage.Create;
          tmpPopupMsg.PopupMessageType := mtMarketing;
          tmpPopupMsg.ReminderDate := FieldByName('FollowUpDate').AsDateTime;
          tmpPopupMsg.ID := FieldByName('ID').asInteger;
          msg := ' <B><SHAD>Marketing Follow-up</SHAD></B> :- '+ #13#10#13#10+
                 #9+'<SHAD>When:</SHAD>'+'<IND x="90">'+ DateTimeToStr(FieldByName('FollowUpDate').AsDateTime)+ #13#10+
                 #9+'<SHAD>Lead:</SHAD>'+'<IND x="90">'+FieldByName('COMPANY').AsString;
          MsgList.AddObject(msg,tmpPopupMsg);
          Next;
        end;
      end
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TPromptPopup.GetMessagePrompts(const MsgList: TStringList);
var
  qry: TERPQuery;
  tmpPopupMsg: TPopupMessage;
  msg:String;
  ActionMsg:String;
begin
  qry := TERPQuery.Create(Self);
  qry.Options.FlatBuffers := True;
  try
    with qry do begin
      Connection := GetSharedMyDacConnection;
      SQL.Add('SELECT');
      SQL.Add('M.MessagesID,');
      SQL.Add('ML.ResponsedueOn,');
(*      SQL.Add('ML.Telephoned,');
      SQL.Add('ML.WillRingBack,');
      SQL.Add('ML.PleaseRing,');
      SQL.Add('ML.CalledIn,');*)
      SQL.add('DateAndTime,');
      SQL.Add('ML.Messagetype,');
      SQL.Add('ML.Actiontype,');
      SQL.Add('SUBSTRING(ML.Details,1,50) as ShortMessage,');
      SQL.Add('M.Phone,');
      SQL.Add('M.Company,');
      SQL.Add('M.Mobile,');
      SQL.Add('M.Email');
      SQL.Add('FROM tblMessages M  inner join tblMessagelines ML on M.MessagesID = ML.MessagesID');
      SQL.Add('WHERE ML.employeeId ='+IntToStr(AppEnv.Employee.EmployeeID)+'  AND ML.Done = "F"');
      SQL.Add('and DateAndTime<=Now()');
      (*      SQL.Add('SELECT ');
      SQL.Add('M.MessagesID, ');
      SQL.Add('M.CreateDateAndTime as DateAndTime, ');
      SQL.Add('M.Telephoned, ');
      SQL.Add('M.WillRingBack, ');
      SQL.Add('M.PleaseRing, ');
      SQL.Add('M.CalledIn, ');
      SQL.Add('SUBSTRING(M.Details,1,50) as ShortMessage, ');
      SQL.Add('C.Company, ');
      SQL.Add('C.Phone, ');
      SQL.Add('C.Mobile, ');
      SQL.Add('C.Email ');
      SQL.Add('FROM tblMessages M ');
      SQL.Add('LEFT JOIN tblClients C ON C.ClientID = M.FromId ');
      SQL.Add('WHERE M.ToId ='+IntToStr(AppEnv.Employee.EmployeeID)+' AND M.Done = "F"');
      SQL.add(' and DateAndTime<=Now()');*)
      Open;
      if (RecordCount>0) then begin
        First;
        While Not EOF do Begin
          tmpPopupMsg := TPopupMessage.Create;
          tmpPopupMsg.PopupMessageType := mtMessage;
          tmpPopupMsg.ReminderDate := FieldByName('DateAndTime').AsDateTime;
          tmpPopupMsg.ID := FieldByName('MessagesID').asInteger;
          ActionMsg := '';
          (*If FieldByName('Telephoned').AsBoolean then Begin*)
          if fieldbyname('MessageType').asString = 'T' then begin
            ActionMsg := ActionMsg + 'Telephoned';
          (*end else If FieldByName('WillRingBack').AsBoolean then Begin*)
          end else if fieldbyname('ActionType').asString = 'B' then begin
            If (ActionMsg <> '') then  ActionMsg := ActionMsg + ' / ';
            ActionMsg := ActionMsg + 'WillRingBack';
          (*end else If FieldByName('PleaseRing').AsBoolean then Begin*)
          end else if fieldbyname('Actiontype').asString = 'R' then begin
            If (ActionMsg <> '') then ActionMsg := ActionMsg + ' / ';
            ActionMsg := ActionMsg + 'PleaseRing';
          (*end else If FieldByName('CalledIn').AsBoolean then Begin*)
          end else if fieldbyname('MessageType').asString = 'C' then begin
            If (ActionMsg <> '') then ActionMsg := ActionMsg + ' / ';
            ActionMsg := ActionMsg + 'CalledIn';
          end;
          ActionMsg := '(' +ActionMsg + ')';

          msg := ' <B><SHAD>Messages</SHAD></B> :- '+ #13#10#13#10+
                 #9+'<SHAD>When:</SHAD>'+'<IND x="90">'+DateTimeToStr(FieldByName('DateAndTime').AsDateTime)+ #13#10+
                 #9+'<SHAD>From:</SHAD>'+'<IND x="90">'+FieldByName('Company').AsString+ #13#10+
                 #9+'<SHAD>Action:</SHAD>'+'<IND x="90">'+ActionMsg+ #13#10+
                 #9+'<SHAD>Details:</SHAD>'+'<IND x="90">'+FieldByName('ShortMessage').AsString;
          MsgList.AddObject(msg,tmpPopupMsg);
          Next;
        end;
      end
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TPromptPopup.PopupWindowDeleteMessage(Sender: TObject; index: Integer);
begin
  If (TAdvAlertWindow(Sender).AlertMessages.Count=0) then Exit;
  If (TAdvAlertWindow(Sender).AlertMessages.Count=1) then
    TAdvAlertWindow(Sender).ShowDelete := False;
end;

procedure TPromptPopup.PopupWindowAlertClick(Sender: TObject);
var
  tmpPopupMsg: TPopupMessage;
  tmpForm: TForm;
  idx: integer;
begin
  TAdvAlertWindow(Sender).OnAlertClick := nil;
  Try
    idx:= PopupWindow.ActiveMessage-1;
    if idx > (PopupWindow.AlertMessages.Count -1) then
      exit;
    tmpPopupMsg := TPopupMessage(PopupWindow.AlertMessages.Items[idx].Text.Objects[0]);
    if Assigned(tmpPopupMsg) then begin
      // Open Marketing Contacts
      If (tmpPopupMsg.PopupMessageType = mtMarketing) then Begin
        tmpForm := TForm(FindExistingComponent('TfmMarketing'));
        if Assigned(tmpForm) then tmpForm.Close;
        Application.ProcessMessages;
        tmpForm := TForm(GetComponentByClassName('TfmMarketing'));
        if Assigned(tmpForm) then begin
          TBaseInputGUI(tmpForm).KeyID := tmpPopupMsg.ID;
          tmpForm.FormStyle := fsMDIChild;
          tmpForm.BringToFront;
        end;
      end;
      // Open ToDo
      If (tmpPopupMsg.PopupMessageType = mtToDo) then Begin
        tmpForm := TForm(FindExistingComponent('TfrmToDo'));
        if Assigned(tmpForm) then tmpForm.Close;
        Application.ProcessMessages;
        tmpForm := TForm(GetComponentByClassName('TfrmToDo'));
        if Assigned(tmpForm) then begin
          TBaseInputGUI(tmpForm).KeyID := tmpPopupMsg.ID;
          tmpForm.FormStyle := fsMDIChild;
          tmpForm.BringToFront;
        end;
      end;

      // Open Message
      If (tmpPopupMsg.PopupMessageType = mtMessage) then Begin
        tmpForm := TForm(FindExistingComponent('TfrmMessagesGUI'));
        if Assigned(tmpForm) then tmpForm.Close;
        Application.ProcessMessages;
        tmpForm := TForm(GetComponentByClassName('TfrmMessagesGUI'));
        if Assigned(tmpForm) then begin
          TBaseInputGUI(tmpForm).KeyID := tmpPopupMsg.ID;
          tmpForm.FormStyle := fsMDIChild;
          tmpForm.BringToFront;
        end;
      end;
    end;
    If (PopupWindow.AlertMessages.Count=2) then
      PopupWindow.ShowDelete := False;
    If (PopupWindow.AlertMessages.Count>1) then
      PopupWindow.AlertMessages.Delete(PopupWindow.ActiveMessage-1)
  finally
    TAdvAlertWindow(Sender).OnAlertClick := PopupWindowAlertClick;
  end;
end;

procedure TPromptPopup.PopupMenuClick(Sender: TObject);
var
  tmpPopupMsg: TPopupMessage;
  DateTimeStr: String;
begin
  TMenuItem(Sender).OnClick := nil;
  Try
    tmpPopupMsg:= nil;
    try
      tmpPopupMsg := TPopupMessage(PopupWindow.AlertMessages.Items[PopupWindow.ActiveMessage-1].Text.Objects[0]);
    except
      { to catch "List index out of bounds" exceptiom }
    end;

    if Assigned(tmpPopupMsg) then begin
      // update Time
      If (tmpPopupMsg.PopupMessageType = mtMarketing) then Begin
        DateTimeStr := FormatDateTime(MysqlDateTimeFormat, ChangeRemindInTime(TMenuItem(Sender).Caption,Now()));
        ExecuteSql('UPDATE tblMarketingleadlines '+
        ' inner join tblMarketingleads on tblMarketingleads.LeadId = tblMarketingleadlines.LeadID ' +
        'Inner Join tblmarketingcontacts ON tblmarketingcontacts.ID = tblMarketingleads.MarketingcontactID'+
        'SET tblMarketingleadlines.FollowUpDate = '+QuotedStr(DateTimeStr)+' '+
        'WHERE tblMarketingleadlines.EmployeeID = '+ IntToStr(AppEnv.Employee.EmployeeID) + ' '+
        'AND tblMarketingleadlines.ResultTypeName = "Follow-up" '+
        'AND tblMarketingleadlines.Done <> "T" '+
        'AND tblMarketingleadlines.FollowUpDate = '+QuotedStr(FormatDateTime(MysqlDateTimeFormat,tmpPopupMsg.ReminderDate))+' '+
        'AND tblmarketingcontacts.ID = '+IntToStr(tmpPopupMsg.ID)+';');
      end;
      If (tmpPopupMsg.PopupMessageType = mtToDo) then Begin
        DateTimeStr := FormatDateTime(MysqlDateTimeFormat, ChangeRemindInTime(TMenuItem(Sender).Caption,Now()));
        ExecuteSql('UPDATE tbltodo SET ToDoByDate= '+QuotedStr(DateTimeStr)+' WHERE ToDoID='+IntToStr(tmpPopupMsg.ID)+';');
      end;

      If (tmpPopupMsg.PopupMessageType = mtMessage) then Begin
        DateTimeStr := FormatDateTime(MysqlDateTimeFormat, ChangeRemindInTime(TMenuItem(Sender).Caption,Now()));
        ExecuteSql('update tblmessages Set DateAndtime   = '+QuotedStr(DateTimeStr)+' '+
                ' where  MessagesID  = '+IntToStr(tmpPopupMsg.ID)+';');
        (*CommonLib.MessageDlgXP_Vista('Cannot Delay Messages', mtInformation, [mbOK], 0);*)
      end;

      If (PopupWindow.AlertMessages.Count=2) then
        PopupWindow.ShowDelete := False;
      If (PopupWindow.AlertMessages.Count>1) then
        PopupWindow.AlertMessages.Delete(PopupWindow.ActiveMessage-1)
      else
        CloseTimer.Enabled := True;
    end;    
  finally
    TMenuItem(Sender).OnClick := PopupMenuClick;
  end;
end;


function TPromptPopup.ChangeRemindInTime(Const RemindInCaption: String; const Time: TDateTime): TDateTime;
begin
  Case RemindCaptionToRemindOption(RemindInCaption) of
    roNone : Result := Time;
    ro5Min : Result := IncMinute(Time,5);
    ro10Min: Result := IncMinute(Time,10);
    ro15Min: Result := IncMinute(Time,15);
    ro30Min: Result := IncMinute(Time,30);
    ro1Hour: Result := IncHour(Time,1);
    ro2Hour: Result := IncHour(Time,2);
    ro1Day : Result := IncDay(Time,1);
    ro1Week: Result := IncDay(Time,7);
  else
   result := Time;
  end;
end;

procedure TPromptPopup.ExecuteSql(const SqlStr: String);
var
  qry: TERPCommand;
begin
  qry := TERPCommand.Create(Self);
  try
    with qry do begin
      Connection := GetSharedMyDacConnection;
      qry.SQL.Add(SqlStr);
      Try
        qry.Execute;
      Except
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TPromptPopup.RemindCaptionToRemindOption(const RemindCaptionStr: string): TRemindOption;
var
  i: TRemindOption;
begin
  Result := roNone;
  for i := Low(TRemindOption) to High(TRemindOption) do begin
    if Sysutils.SameText(Trim(RemindCaptionStr),RemindCaption[i]) then begin
      Result := i;
      Break;
    end;
  end;
end;

procedure TPromptPopup.DoCheckForPrompts(MsgObj: TMsgObj; out ResponseObj: TMsgObj);
begin
  ResponseObj := MsgObj;
  ResponseObj.IntValue := CheckForPrompts;
end;

initialization
  RegisterClassOnce(TPromptPopup);
end.
