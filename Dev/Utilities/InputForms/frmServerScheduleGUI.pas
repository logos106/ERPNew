unit frmServerScheduleGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts,
  DB,  ExtCtrls, MemDS, StdCtrls, wwcheckbox, DBCtrls, Mask, DNMPanel,
  Buttons, DNMSpeedButton, wwdbdatetimepicker, Spin,   XMLDoc,
   wwdbedit, Wwdotdot, Wwdbcomb, wwclearbuttongroup, wwradiogroup,
  DataState, Menus, AdvMenus, Shader, ImgList;

type
  TServerScheduleGUI = class(TBaseInputGUI)
    qryServerSchedule: TERPQuery;
    qryServerScheduleID: TIntegerField;
    qryServerScheduleDatabaseName: TWideStringField;
    qryServerSchedulerepeatalarmID: TIntegerField;
    qryServerScheduleDue: TDateTimeField;
    qryServerScheduleDescription: TWideStringField;
    qryServerScheduleXml: TWideMemoField;
    qryServerScheduleLogWhenDone: TWideStringField;
    qryServerScheduleLogWhenDropped: TWideStringField;
    dsServerSchedule: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    cbLogWhenDone: TwwCheckBox;
    cbLogWhenDropped: TwwCheckBox;
    cmdOK: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    edDue: TwwDBDateTimePicker;
    cbRepeatAlarm: TwwCheckBox;
    btnRepeatForm: TDNMSpeedButton;
    MyCommand: TERPCommand;
    edDescription: TEdit;
    memXml: TMemo;
    qryRepeatAlarms: TERPQuery;
    Label1: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    qryRepeatAlarmsID: TIntegerField;
    qryRepeatAlarmsDatabaseName: TWideStringField;
    qryRepeatAlarmsDescription: TWideStringField;
    qryRepeatAlarmsXml: TWideMemoField;
    qryRepeatAlarmsEvery: TIntegerField;
    qryRepeatAlarmsDayOfWeek: TWideStringField;
    qryRepeatAlarmsOfPeriod: TWideStringField;
    qryRepeatAlarmsMonthOffset: TIntegerField;
    qryRepeatAlarmsOnSaturday: TWideStringField;
    qryRepeatAlarmsOnSunday: TWideStringField;
    qryRepeatAlarmsOnHoliday: TWideStringField;
    qryRepeatAlarmsDueTime: TTimeField;
    qryRepeatAlarmsActiveFirst: TDateField;
    qryRepeatAlarmsActiveLast: TDateField;
    qryRepeatAlarmsDropAfterMinutes: TIntegerField;
    qryRepeatAlarmsLogWhenDone: TWideStringField;
    qryRepeatAlarmsLogWhenDropped: TWideStringField;
    pnlDrop: TDNMPanel;
    Label7: TLabel;
    seDropAfterMinutes: TSpinEdit;
    XMLDocument: TXMLDocument;
    cbAlarmSelector: TwwDBComboBox;
    Label8: TLabel;
    rgDropTime: TwwRadioGroup;
    cboMode: TwwDBComboBox;
    Label9: TLabel;
    qryServerScheduleMode: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure qryServerScheduleNewRecord(DataSet: TDataSet);
    procedure cbRepeatAlarmClick(Sender: TObject);
    procedure btnRepeatFormClick(Sender: TObject);
    procedure memXmlExit(Sender: TObject);
    function VerifyXml: boolean;
    procedure cbAlarmSelectorChange(Sender: TObject);
    procedure cboModeChange(Sender: TObject);
  private
    plannedDates: array of TDateTime;
    RepeatCalcOnly: boolean;
    function AssignChangedFields: boolean;
  public
    
  end;

//var
//  ServerScheduleGUI: TServerScheduleGUI;

implementation

uses FastFuncs,DNMExceptions, AuditObj, FormFactory, CommonDbLib, frmRepeat, DateUtils,
   CommonLib, AppEnvironment, tcConst;
{$R *.dfm}

  // prepare StringFields for embedding into a MySQL-command (insert / update)
function escapeForMySQL(const s: string): string;
const
  thechar        = '\"'''#13#10#9;
  thereplacement = '\"''rnt';
var 
  i, p: integer;
begin
  Result := '';
  for i := 1 to char_length(s) do begin
    p := FastFuncs.PosEx(s[i], thechar);
    if p > 0 then Result := Result + '\' + thereplacement[p]
    else Result := Result + s[i];
  end;
end;

procedure TServerScheduleGUI.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      MyConnection.Database := 'Services';
      if qryServerSchedule.Active then begin
        if not (qryServerSchedule.State in [dsBrowse]) then begin
          qryServerSchedule.Post;
          Notify;
        end;
        qryServerSchedule.Close;
      end;

  //    MyConnection.StartTransaction;
      qryServerSchedule.Close;
      qryServerSchedule.Params.ParamByName('ID').asInteger := KeyID;
      qryServerSchedule.Open;

      if KeyID = 0 then begin
        //      qryServerSchedule.Insert;
        edDue.DateTime := Now + 1;
        cbRepeatAlarm.Checked := false;
      end else begin
        //      qryServerSchedule.Edit;
        cbRepeatAlarm.Enabled := false;
        cbRepeatAlarm.Checked := qryServerSchedulerepeatAlarmID.AsInteger > 0;
        edDue.DateTime := qryServerScheduleDue.AsDateTime;
        edDescription.Text := qryServerScheduleDescription.AsString;
        memXml.Lines.Text := qryServerScheduleXml.AsString;
        cbLogWhenDone.Checked := qryServerScheduleLogWhenDone.AsBoolean;
        cbLogWhenDropped.Checked := qryServerScheduleLogWhenDropped.AsBoolean;
        cboMode.Text := qryServerScheduleMode.AsString;


        if cbRepeatAlarm.Checked then begin
          qryRepeatAlarms.ParamByName('ID').AsInteger := qryServerSchedulerepeatAlarmID.AsInteger;
          qryRepeatAlarms.Open;
          seDropAfterMinutes.Value := qryRepeatAlarmsDropAfterMinutes.AsInteger;
          rgDropTime.ItemIndex := 0;
        end;
      end;
      cbRepeatAlarmClick(nil);
      //  //   chkActive.Enabled := (AccessLevel <> 2) and (AccessLevel <> 3);
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
    SetControlFocus(edDue);
  finally
    EnableForm;
  end;  
end;

procedure TServerScheduleGUI.cmdOKClick(Sender: TObject);
var
  repeatAlarmID: integer;
  i: integer;
  logDone, logDropped: char;
  DropMinutes: integer;
begin
  if AssignChangedFields() then try
      if qryServerSchedule.State in [dsEdit, dsInsert] then qryServerSchedule.Post;
      if qryServerSchedulerepeatAlarmID.AsInteger > 0 then begin
        qryRepeatAlarms.Close;
        repeatAlarmID := qryServerSchedulerepeatAlarmID.AsInteger;
        qryRepeatAlarms.ParamByName('ID').AsInteger := repeatAlarmID;
        qryRepeatAlarms.Open;
      
        MyCommand.SQL.Text := 'DELETE FROM tblschedule WHERE repeatAlarmID = ' + IntToStr(repeatAlarmID);
        MyCommand.Execute;
        RepeatCalcOnly := true;
        btnRepeatFormClick(nil);    // using frmRepeat to ReCalc planneddates
        RepeatCalcOnly := false;
        if cbLogWhenDone.Checked then logDone := 'T'
        else logDone := 'F';
        if cbLogWhenDropped.Checked then logDropped := 'T'
        else logDropped := 'F';
        for i := 0 to High(plannedDates) do
          //        if (plannedDates[i] + edDue.Time > now) and (plannedDates[i] + edDue.Time < now + 14) then
          //         (we need to show all future alarms
          if (plannedDates[i] + edDue.Time > Now) then begin
            MyCommand.SQL.Text := 'INSERT tblschedule SET ' + 'DatabaseName="' +
              qryRepeatAlarmsDatabaseName.AsString + '", ' + 'repeatalarmID=' + IntToStr(repeatAlarmID) + ', ' +
              'Due="' + FormatDateTime(MysqlDateTimeFormat, plannedDates[i] + edDue.Time) + '", ' + 'Xml="' +
              escapeForMySql(memXml.Text) + '", ' + 'Description="' + escapeForMySql(edDescription.Text) +
              '", ' + 'LogWhenDone="' + logDone + '", ' + 'LogWhenDropped="' + logDropped + '", ' + 'Mode="' + cboMode.Text + '";';
            MyCommand.Execute;
          end;
        qryRepeatAlarms.Edit;
        qryRepeatAlarmsDescription.AsString := escapeForMySql(edDescription.Text);
        qryRepeatAlarmsXml.AsString := escapeForMySql(memXml.Text);
        qryRepeatAlarmsLogWhenDone.AsString := logDone;
        qryRepeatAlarmsLogWhenDropped.AsString := logDropped;
        qryRepeatAlarmsDueTime.AsDateTime := DateUtils.TimeOf(edDue.Time);

        DropMinutes := seDropAfterMinutes.Value;
        if rgDropTime.ItemIndex = 1 then DropMinutes := DropMinutes * 24 * 60;
        qryRepeatAlarmsDropAfterMinutes.AsInteger := DropMinutes;

        qryRepeatAlarms.Post;
      end;

      // update tblrepeatalarms
      // and update all tblschedule entries with identical repeatalarmID

//      MyConnection.Commit;
      Notify;
      Self.Close;
    except
      on e: Exception do begin
        Audit.AddEntry(e, Self);
        CommonLib.MessageDlgXP_Vista(e.Message + Chr(13) + 'Errors occured in ' + Self.ClassName, mtWarning, [mbOK], 0);
        Self.Close; {Don't open the form if errors occur, too risky!!}
      end;
    end;
end;

procedure TServerScheduleGUI.cmdCancelClick(Sender: TObject);
begin
  if qryServerSchedule.State in [dsEdit, dsInsert] then qryServerSchedule.Cancel;
  //MyConnection.Rollback;
  Self.Close;
end;

function TServerScheduleGUI.AssignChangedFields: boolean;
begin
  Result := false;
  if not (dsServerSchedule.State in [dsEdit, dsInsert]) then begin
    if KeyID = 0 then qryServerSchedule.Insert
    else qryServerSchedule.Edit;
  end;
  try
    if edDue.DateTime <> qryServerScheduleDue.AsDateTime then qryServerScheduleDue.AsDateTime := edDue.DateTime;
    if edDescription.Text <> qryServerScheduleDescription.AsString then
      qryServerScheduleDescription.AsString := edDescription.Text;
    if memXml.Lines.Text <> qryServerScheduleXml.AsString then qryServerScheduleXml.AsString := memXml.Lines.Text;
    if cbLogWhenDone.Checked <> qryServerScheduleLogWhenDone.AsBoolean then
      qryServerScheduleLogWhenDone.AsBoolean := cbLogWhenDone.Checked;
    if cbLogWhenDropped.Checked <> qryServerScheduleLogWhenDropped.AsBoolean then
      qryServerScheduleLogWhenDropped.AsBoolean := cbLogWhenDropped.Checked;
    if Trim(cboMode.Text) <> qryServerScheduleMode.AsString then qryServerScheduleMode.AsString := Trim(cboMode.Text);

    if VerifyXml then Result := true;
  except 
    on Exception do end;
end;


procedure TServerScheduleGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
// ServerScheduleGUI := nil;
end;
                          
procedure TServerScheduleGUI.FormCreate(Sender: TObject);
begin
  inherited;
  MyConnection.Database := 'Services';
end;

procedure TServerScheduleGUI.qryServerScheduleNewRecord(DataSet: TDataSet);
begin
  inherited;
  qryServerSchedule.FieldByName('DatabaseName').AsString := CommonDbLib.GetSharedMyDacConnection.Database;
end;

procedure TServerScheduleGUI.cbRepeatAlarmClick(Sender: TObject);
begin
  if cbRepeatAlarm.Checked then cboMode.ItemIndex := 0;
  btnRepeatForm.Enabled := cbRepeatAlarm.Checked;
  pnlDrop.Visible := cbRepeatAlarm.Checked;
end;

procedure TServerScheduleGUI.btnRepeatFormClick(Sender: TObject);
var 
  ofPeriod: string;
  Every: string;
  DayOfWeek: string;
  MonthDays: string;
  Sat, Sun, Hol: string;
  RepeatAlarmId: integer;
  DropMinutes: integer;
  i: integer;
begin
  inherited;
  DropMinutes := 0;
  with TRepeatFrm.Create(self, CommonDbLib.GetSharedMyDacConnection.Database) do begin
    try
      TitleLabel.Caption := 'Repeat Alarm ' + qryServerScheduleDescription.AsString;

      if qryServerSchedulerepeatalarmID.AsInteger > 0 then with qryRepeatAlarms do begin
          Close;
          ParamByName('ID').AsInteger := qryServerSchedulerepeatalarmID.AsInteger;
          Open;

          dtBaseDate.Date := FieldByName('ActiveFirst').AsDateTime - 1;
          dtFinalDate.Date := FieldByName('ActiveLast').AsDateTime;

          DropMinutes := seDropAfterMinutes.Value;
          if rgDropTime.ItemIndex = 1 then DropMinutes := DropMinutes * 24 * 60;

          if FieldByName('OnSaturday').AsString = 'Post' then rgSaturday.ItemIndex := 0
          else if FieldByName('OnSaturday').AsString = 'Drop' then rgSaturday.ItemIndex := 1
          else if FieldByName('OnSaturday').AsString = 'After' then rgSaturday.ItemIndex := 2
          else if FieldByName('OnSaturday').AsString = 'Before' then rgSaturday.ItemIndex := 3;

          if FieldByName('OnSunday').AsString = 'Post' then rgSunday.ItemIndex := 0
          else if FieldByName('OnSunday').AsString = 'Drop' then rgSunday.ItemIndex := 1
          else if FieldByName('OnSunday').AsString = 'After' then rgSunday.ItemIndex := 2
          else if FieldByName('OnSunday').AsString = 'Before' then rgSunday.ItemIndex := 3;

          if FieldByName('OnHoliday').AsString = 'Post' then rgHoliday.ItemIndex := 0
          else if FieldByName('OnHoliday').AsString = 'Drop' then rgHoliday.ItemIndex := 1
          else if FieldByName('OnHoliday').AsString = 'After' then rgHoliday.ItemIndex := 2
          else if FieldByName('OnHoliday').AsString = 'Before' then rgHoliday.ItemIndex := 3;

          ofPeriod := FieldByName('ofPeriod').AsString;
          if ofPeriod = 'Day' then begin
            rgFrequency.ItemIndex := 0;
            seDayDays.Value := FieldByName('Every').AsInteger;
          end else if ofPeriod = 'Week' then begin
            rgFrequency.ItemIndex := 1;
            if FieldByName('DayOfWeek').AsString = 'MO' then cbWeekDay.ItemIndex := 1
            else if FieldByName('DayOfWeek').AsString = 'TU' then cbWeekDay.ItemIndex := 2
            else if FieldByName('DayOfWeek').AsString = 'WE' then cbWeekDay.ItemIndex := 3
            else if FieldByName('DayOfWeek').AsString = 'TH' then cbWeekDay.ItemIndex := 4
            else if FieldByName('DayOfWeek').AsString = 'FR' then cbWeekDay.ItemIndex := 5
            else if FieldByName('DayOfWeek').AsString = 'SA' then cbWeekDay.ItemIndex := 6
            else if FieldByName('DayOfWeek').AsString = 'SU' then cbWeekDay.ItemIndex := 0;
            seWeekDays.Value := FieldByName('Every').AsInteger;
          end else if ofPeriod = 'Month' then begin
            rgFrequency.ItemIndex := 2;
            if FieldByName('DayOfWeek').AsString = 'SOM' then cbMonthBeginEnd.ItemIndex := 0
            else if FieldByName('DayOfWeek').AsString = 'EOM' then cbMonthBeginEnd.ItemIndex := 1;
            seMonthMonths.Value := FieldByName('Every').AsInteger;
          end;
          seDayChange(nil);
          Setlength(PlannedDates, High(dates) + 1);
          for i := 0 to High(dates) do PlannedDates[i] := dates[i];
        end;
      if not repeatCalcOnly then begin
        ShowModal;
        if ModalResult = mrOk then begin
          case rgFrequency.ItemIndex of
            0: 
              begin
                ofPeriod := 'Day';
                Every := IntToStr(seDayDays.Value);
                DayOfWeek := 'MO';
                MonthDays := '0';
              end;
            1: 
              begin
                ofPeriod := 'Week';
                Every := IntToStr(seWeekDays.Value);
                case cbWeekDay.ItemIndex of
                  0: DayOfWeek := 'SU';
                  1: DayOfWeek := 'MO';
                  2: DayOfWeek := 'TU';
                  3: DayOfWeek := 'WE';
                  4: DayOfWeek := 'TH';
                  5: DayOfWeek := 'FR';
                  6: DayOfWeek := 'SA';
                end;
                MonthDays := '0';
              end;
            2: 
              begin
                ofPeriod := 'Month';
                Every := IntToStr(seMonthMonths.Value);
                case cbMonthBeginEnd.ItemIndex of
                  0: DayOfWeek := 'SOM';
                  1: DayOfWeek := 'EOM';
                end;
                MonthDays := IntToStr(seMonthDays.Value);
              end;
          end;
          case rgSaturday.ItemIndex of
            0: Sat := 'Post';
            1: Sat := 'Drop';
            2: Sat := 'After';
            3: Sat := 'Before';
          end;
          case rgSunday.ItemIndex of
            0: Sun := 'Post';
            1: Sun := 'Drop';
            2: Sun := 'After';
            3: Sun := 'Before';
          end;
          case rgHoliday.ItemIndex of
            0: Hol := 'Post';
            1: Hol := 'Drop';
            2: Hol := 'After';
            3: Hol := 'Before';
          end;

          if qryServerSchedulerepeatalarmID.AsInteger = 0 then begin
            MyCommand.SQL.Text :=
              'INSERT HIGH_PRIORITY INTO tblrepeatalarms SET ' + 'DataBaseName="' + CommonDbLib.GetSharedMyDacConnection.Database +
              '", ' + 'Description="' + escapeForMySql(edDescription.Text) + '", ' + 'Xml="' +
              escapeForMySql(memXml.Lines.Text) + '", ' + 'Every=' + Every + ', ' + 'DayOfWeek="' + DayOfWeek +
              '", ' + 'OfPeriod="' + ofPeriod + '", ' + 'MonthOffset=' + MonthDays + ', ' + 'OnSaturday="' +
              Sat + '", ' + 'OnSunday="' + Sun + '", ' + 'OnHoliday="' + Hol + '", ' + 'DueTime="' + FormatDateTime(MysqlTimeFormat,
              edDue.Time) + '", ' + 'ActiveFirst="' + FormatDateTime(MysqlDateFormat, dtBaseDate.Date + 1) +
              '", ' + 'ActiveLast="' + FormatDateTime(MysqlDateFormat, dtFinalDate.Date) + '", ' + 'DropAfterMinutes=' +
              IntToStr(DropMinutes) + ', '    //        + 'NextDue='+  +', '
              + 'LogWhenDone="' + qryServerScheduleLogWHenDone.AsString + '", ' + 'LogWhenDropped="' +
              qryServerScheduleLogWHenDropped.AsString + '"  ';

            MyCommand.Execute;
            RepeatAlarmId := MyCommand.InsertId;
            // get ID and put into schedule
            // created dates... tblschedule entries

            if KeyID = 0 then qryServerSchedule.Insert
            else qryServerSchedule.Edit;
            qryServerSchedulerepeatalarmID.AsInteger := RepeatAlarmId;
          end else begin       // update repeatalarm
            RepeatAlarmId := qryServerSchedulerepeatalarmID.AsInteger;
            MyCommand.SQL.Text :=
              'UPDATE tblrepeatalarms SET ' + 'Every=' + Every + ', ' + 'DayOfWeek="' + DayOfWeek +
              '", ' + 'OfPeriod="' + ofPeriod + '", ' + 'MonthOffset=' + MonthDays + ', ' + 'OnSaturday="' +
              Sat + '", ' + 'OnSunday="' + Sun + '", ' + 'OnHoliday="' + Hol + '", ' + 'ActiveFirst="' +
              FormatDateTime(MysqlDateFormat, dtBaseDate.Date + 1) + '", ' + 'ActiveLast="' + FormatDateTime(MysqlDateFormat,
              dtFinalDate.Date) + '", ' + 'DropAfterMinutes=' + IntToStr(DropMinutes) + ' ' + 'WHERE ID = ' + IntToStr(RepeatAlarmID);

            MyCommand.Execute;
          end;

          // insert events for next 4 weeks into tblschedule
          edDue.Date := DateOf(DtBaseDate.Date) + 1;
          edDue.Refresh;
          Setlength(PlannedDates, High(dates) + 1);
          for i := 0 to High(dates) do PlannedDates[i] := dates[i];
        end; // if Modalresult = mrok
      end;   // if not repeatCalcOnly then
    finally
      Free;
    end;
  end;
end;

procedure TServerScheduleGUI.memXmlExit(Sender: TObject);
begin
  VerifyXml;
end;

function TServerScheduleGUI.VerifyXml: boolean;
begin
  Result := false;
  XMLDocument.XML.Text := memXml.Lines.text;
  try
    XMLDocument.Active := true;
    XMLDocument.Active := false;
    XMLDocument.XML.Clear;
    Result := true;
  except
//    on E: EXMLDocError do begin
//      CommonLib.MessageDlgXP_Vista('ERP XML Syntax Error on Line: ' + IntToStr(E.Line) + #13 + #10 + #13 + #10 +
//        E.Reason + #13 + #10 +
//        'Near: ' + E.SrcText + #13 + #10 + #13 + #10 +
//        'This Server Schedule Can''t Run until Syntax Error is Corrected'
//        , mtInformation, [mbOK], 0);
//    end;
  end;
end;

procedure TServerScheduleGUI.cbAlarmSelectorChange(Sender: TObject);
var 
  dbname: string;
begin
  dbname := CommonDbLib.GetSharedMyDacConnection.Database;
  if FastFuncs.PosEx('Backup', cbAlarmSelector.Text) = 1 then memXml.Text :=
      '<EXEC program="BackupManager.exe" params="BACKUP ' + dbname + ' DnM "/>'
  else if FastFuncs.PosEx('AutoUpdate', cbAlarmSelector.Text) = 1 then memXml.Text :=
      '<EXEC program="AutoUpdate.exe" params="autostart"  />'
  else if FastFuncs.PosEx('Broadcast Flashing', cbAlarmSelector.Text) = 1 then
    memXml.Text := '<FLASHALERT dbname="' + dbname + '" msg="put message here"/>'
  else if FastFuncs.PosEx('Broadcast Popup ', cbAlarmSelector.Text) = 1 then
    memXml.Text := '<POPUPALERT dbname="' + dbname + '" msg="put message here"/>'
  else if FastFuncs.PosEx('Broadcast', cbAlarmSelector.Text) = 1 then memXml.Text :=
      '<ALERT dbname="' + dbname + '" msg="put message here"/>'
  else if FastFuncs.PosEx('Verify & Fix', cbAlarmSelector.Text) = 1 then memXml.Text :=
      '<VERIFY dbname="' + dbname + '"/>'
  else if FastFuncs.PosEx('Batch Update', cbAlarmSelector.Text) = 1 then memXml.Text :=
      '<BATCH dbname="' + dbname + '"/>'
  else if FastFuncs.PosEx('Terminate', cbAlarmSelector.Text) = 1 then memXml.Text :=
      '<TERMINATEUSERS' + ' userid="' + IntToStr(AppEnv.Employee.EmployeeID) + '" username="' + AppEnv.Employee.FirstName +
      ' ' + AppEnv.Employee.LastName + '" dbname="' + dbname + '" reason=" Performing Server Scheduled Terminate Users' +
      '" excludeuserid="' + IntToStr(AppEnv.Employee.EmployeeID) + '" terminatewaitsec="60' + '" delayloginsec="60"/>';
end;

procedure TServerScheduleGUI.cboModeChange(Sender: TObject);
begin
  inherited;
  cbRepeatAlarm.Checked := false;
  btnRepeatForm.Enabled := false;
  pnlDrop.Visible := not (FastFuncs.PosEx('Once', cboMode.Text) = 1);
end;

initialization
  RegisterClassOnce(TServerScheduleGUI);
  FormFact.RegisterMe(TServerScheduleGUI, 'TServerScheduleListGUI_Due=ID');
  FormFact.RegisterMe(TServerScheduleGUI, 'TServerScheduleListGUI_Description=ID');
end.





