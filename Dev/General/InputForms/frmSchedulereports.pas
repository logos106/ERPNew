unit frmSchedulereports;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   BusObjBase , BusobjScheduledReports, Grids, Wwdbigrd, Wwdbgrid, Mask, wwdbedit, wwdblook, frmSchedulereportOptions, ComCtrls, Spin, wwdbdatetimepicker, BaseListingForm,
  Buttons;

type
  TfmSchedulereports = class(TBaseInputGUI)
    QryForms: TERPQuery;
    dsForms: TDataSource;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    dsReportSchedules: TDataSource;
    QryReportSchedules: TERPQuery;
    QryFormsGlobalRef: TWideStringField;
    QryFormsFormID: TIntegerField;
    QryFormsFormName: TWideStringField;
    QryFormsBusinessObjectName: TWideStringField;
    QryFormsDescription: TWideStringField;
    QryFormsTabGroup: TIntegerField;
    QryFormsIsForm: TWideStringField;
    QryFormsAccessLevels: TWideStringField;
    QryFormsSkinsGroup: TWideStringField;
    QryFormsmsTimeStamp: TDateTimeField;
    QryFormsmsUpdateSiteCode: TWideStringField;
    QryReportSchedulesID: TIntegerField;
    QryReportSchedulesGlobalRef: TWideStringField;
    QryReportSchedulesFormID: TIntegerField;
    QryReportSchedulesEmployeeId: TIntegerField;
    QryReportSchedulesStartDate: TDateTimeField;
    QryReportSchedulesEndDate: TDateTimeField;
    QryReportSchedulesFrequency: TWideStringField;
    QryReportSchedulesEvery: TIntegerField;
    QryReportSchedulesWeekDay: TIntegerField;
    QryReportSchedulesBeginFromOption: TWideStringField;
    QryReportSchedulesmsUpdatesiteCode: TWideStringField;
    QryReportSchedulesmsTimeStamp: TDateTimeField;
    QryReportSchedulesEmployeename: TWideStringField;
    QryReportSchedulesMonthDays: TIntegerField;
    cboEmployeeLookup: TERPQuery;
    QryReportSchedulesContinueIndefinitely: TWideStringField;
    QryReportSchedulesNextDueDate: TDateTimeField;
    QryReportSchedulesLastEmaileddate: TDateTimeField;
    QryReportSchedulesSatAction: TWideStringField;
    QryReportSchedulessunAction: TWideStringField;
    QryReportSchedulesHolidayAction: TWideStringField;
    QryReportSchedulesActive: TWideStringField;
    pgMain: TPageControl;
    tabSchedule: TTabSheet;
    tabScheduledReports: TTabSheet;
    pnloptions: TDNMPanel;
    pnlScheduledReprots: TDNMPanel;
    cboEmployee: TwwDBLookupCombo;
    grdemployees: TwwDBGrid;
    wwDBGrid1: TwwDBGrid;
    Label1: TLabel;
    wwDBEdit1: TwwDBEdit;
    grdemployeesIButton: TwwIButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure pnloptionsExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure QryReportSchedulesAfterInsert(DataSet: TDataSet);
    procedure QryReportSchedulesBeforePost(DataSet: TDataSet);
    procedure cboEmployeeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure pgMainChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure wwDBGrid1Enter(Sender: TObject);
    procedure grdemployeesIButtonClick(Sender: TObject);
  private
    ERPForm: TERPForms;
    fSchedulereportOptions :TfmSchedulereportOptions;
    fsERPFormName:String;
    fScheduledReports: TBaseListingGUI;
    function SaveRecord: Boolean;
    procedure setERPFormName(const Value: String);
    Function SchedulereportOptions :TfmSchedulereportOptions;
    function SaveOptions:Boolean;
    function RefreshOptions:Boolean;
    function RepeatFrequencyToValue(Const Value :TRepeatFrequency ):String;
    function ValueRepeatFrequency(Const Value :String): TRepeatFrequency;
    function CalcNextdueDate: TDatetime;
    procedure RefreshScheduledReport;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    Property ERPFormName :String Read fsERPFormName Write setERPFormName;
  end;


implementation

uses CommonLib, BusObjConst , tcDataUtils, CommonDbLib, MySQLConst,  tcConst, CommonFormLib, DNMLib, ScheduledreportList;

{$R *.dfm}
procedure TfmSchedulereports.cboEmployeeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  SaveOptions;
end;

procedure TfmSchedulereports.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;
Function TfmSchedulereports.CalcNextdueDate:TDatetime;
begin
    ERPForm.Schedules.PostDB;
    With ERPForm.Schedules.GetNewDataset('Select NextScheduleDueDate(ID) as NextDate from tblscheduledreports where Id = ' + inttostr(ERPForm.Schedules.ID), true) do try
      REsult := fieldbyname('NextDate').asDateTime;
    finally
      if active then close;
      Free;
    end;
end;
function TfmSchedulereports.SaveOptions: Boolean;
var
  fdDate:TdateTime;
begin
  Try
    REsult := TRue;
    if ERPForm.Schedules.ID=0 then
      if ERPForm.Schedules.count =0 then
        if ERPForm.Schedules.Dataset.State <> dsInsert then exit;
    if ERPForm.Schedules.Frequency            <> RepeatFrequencyToValue(SchedulereportOptions.RepeatFrequency)  then ERPForm.Schedules.Frequency            := RepeatFrequencyToValue(SchedulereportOptions.RepeatFrequency);
    if ERPForm.Schedules.Every                <> SchedulereportOptions.Every                                    then ERPForm.Schedules.Every                := SchedulereportOptions.Every;
    if ERPForm.Schedules.WeekDay              <> SchedulereportOptions.RepeatWeekDay                            then ERPForm.Schedules.WeekDay              := SchedulereportOptions.RepeatWeekDay;
    if ERPForm.Schedules.MonthDays            <> SchedulereportOptions.MonthDays                                then ERPForm.Schedules.MonthDays            := SchedulereportOptions.MonthDays;
    if ERPForm.Schedules.BeginFromOption      <> SchedulereportOptions.BeginFromOption                          then ERPForm.Schedules.BeginFromOption      := SchedulereportOptions.BeginFromOption;
    if ERPForm.Schedules.StartDate            <> SchedulereportOptions.StartDate                                then ERPForm.Schedules.StartDate            := SchedulereportOptions.StartDate;
    if ERPForm.Schedules.EndDate              <> SchedulereportOptions.EndDate                                  then ERPForm.Schedules.EndDate              := SchedulereportOptions.EndDate;
    if ERPForm.Schedules.SatAction            <> SchedulereportOptions.SatAction                                then ERPForm.Schedules.SatAction            := SchedulereportOptions.SatAction;
    if ERPForm.Schedules.sunAction            <> SchedulereportOptions.sunAction                                then ERPForm.Schedules.sunAction            := SchedulereportOptions.sunAction;
    if ERPForm.Schedules.HolidayAction        <> SchedulereportOptions.HolidayAction                            then ERPForm.Schedules.HolidayAction        := SchedulereportOptions.HolidayAction;
    if ERPForm.Schedules.ContinueIndefinitely <> SchedulereportOptions.ContinueIndefinitely                     then ERPForm.Schedules.ContinueIndefinitely := SchedulereportOptions.ContinueIndefinitely;
    if Length(SchedulereportOptions.Dates)>0 then
      if ERPForm.Schedules.NextDueDate  <> SchedulereportOptions.Dates[0] then ERPForm.Schedules.NextDueDate  := SchedulereportOptions.Dates[0];
    if ERPForm.Schedules.NextDueDate <=Date then begin
        fdDate:=ERPForm.Schedules.NextDueDate; if ERPForm.Schedules.LastEmailedDate <> fdDate then ERPForm.Schedules.LastEmailedDate  := fdDate;
        fdDate:=CalcNextdueDate;               if ERPForm.Schedules.NextDueDate     <> fdDate then ERPForm.Schedules.NextDueDate      := CalcNextdueDate;
    end;
    if ERPForm.Schedules.LastEmailedDate > ERPForm.Schedules.NextDueDate then ERPForm.Schedules.LastEmailedDate :=0;
    ERPForm.Schedules.PostDB;
    Result:= true;
  Except
    REsult:= False;
  End;
end;

Function TfmSchedulereports.SaveRecord :Boolean;
begin
  result:= False;
  ERPForm.PostDB;
  ERPForm.Schedules.PostDB;
  SaveOptions;
  ERPForm.Schedules.PostDb;
  if not(ERPForm.Save) then exit;
  Result:= True;

end;


function TfmSchedulereports.SchedulereportOptions: TfmSchedulereportOptions;
begin
  if fSchedulereportOptions = nil then begin
    fSchedulereportOptions :=TfmSchedulereportOptions.Create(Self, Myconnection.Database);
    fSchedulereportOptions.pnlMain.parent:=pnloptions;
    fSchedulereportOptions.pnlMain.align := alclient;
  end;
  result:= fSchedulereportOptions;
end;

procedure TfmSchedulereports.setERPFormName(const Value: String);
begin
  fsERPFormName := Value;
  KeyId := getformID(Value);
end;

function TfmSchedulereports.ValueRepeatFrequency(const Value: String): TRepeatFrequency;
begin
       if Value = 'D' then result := rfDay
  else if Value = 'W' then result :=rfWeek
  else result := rfMonth;
end;

procedure TfmSchedulereports.wwDBGrid1Enter(Sender: TObject);
begin
  inherited;
  SaveOptions;
end;

procedure TfmSchedulereports.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if not SaveRecord then exit;
  ERPForm.dirty := False;
  ERPForm.Connection.CommitTransaction;
  Self.Close;
end;

procedure TfmSchedulereports.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
     inherited;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
             if Sender is TERPForms then TERPForms(Sender).Dataset  := qryforms
        else if Sender is TReportSchedules then TReportSchedules(Sender).Dataset  := QryReportSchedules;
     end else if (Eventtype = BusObjEvent_Dataset) and (Sender.IsdataIdchangeEvent(Value)) then begin
        if Sender is TReportSchedules then begin
          RefreshOptions;
          RefreshScheduledReport;
          //TReportSchedules(Sender).PostDB;
        end;
     end else if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEventDataset_beforedataIdchange) then begin
        if Sender is TReportSchedules then begin
          if TReportSchedules(Sender).dataset.state = dsInsert then
          else SaveOptions;
        end;
     end else if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AfterInsert) then begin
        RefreshOptions;
        SchedulereportOptions.seDayChange(SchedulereportOptions.dtBaseDate);
     end;
end;

procedure TfmSchedulereports.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  ERPForm.UserLock.UnlockAllCurrentInstance;
  action := caFree;
end;

procedure TfmSchedulereports.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if ERPForm.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if SaveRecord then begin
            CommitAndNotify;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          ERPForm.Dirty := false;
          CanClose := true;
          Notify(true);
        end;
      mrCancel:
        begin
          CanClose := false;
          cmdCancel.Enabled := True;
        end;
    end;
  end else begin
    CanClose := true;
    Notify(false);
  end;

end;

procedure TfmSchedulereports.FormCreate(Sender: TObject);
begin
  inherited;
  ERPForm := TERPForms.CreateWithNewConn(Self);
  ERPForm.Connection.connection := Self.MyConnection;
  ERPForm.BusObjEvent := DoBusinessObjectEvent;
  fSchedulereportOptions:= nil;
  fScheduledReports := nil;
end;
procedure TfmSchedulereports.FormDestroy(Sender: TObject);
begin
  Freeandnil(ERPForm);
  inherited;

end;

procedure TfmSchedulereports.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if assigned(fScheduledReports)      then fScheduledReports.OnKeyUp(fScheduledReports,Key,Shift);
end;

procedure TfmSchedulereports.FormShow(Sender: TObject);
begin
  fbTabSettingEnabled := false;
  inherited;
  SchedulereportOptions;
  if (ERPFormName <> '') and (KeyID=0) then KeyId := getformID(ERPFormName);
  ERPForm.Load(KeyID);
  ERPForm.connection.BeginTransaction;
  ERPForm.Schedules;
  if accesslevel < 5 then
    if not ERPForm.Lock then begin
      accesslevel := 5;
      CommonLib.MessageDlgXP_Vista(ERPForm.UserLock.LockMessage + NL+NL+ 'Access will be changed to read-only.', MtWarning, [MbOK], 0);
    end;
  openQueries;
  RefreshScheduledReport;
  RealignTabControl(pgMain, 1);
  pgMain.ActivePage :=   tabSchedule;
end;
procedure TfmSchedulereports.grdemployeesIButtonClick(Sender: TObject);
begin
  inherited;
  if ERPForm.Schedules.EmployeeID=0 then Exit;
  if MessageDlgXP_Vista('Do you Wish to Delete ' +NL+ trim(ERPForm.Schedules.Employeename) +'''s Schedule'+NL+'For ' + Quotedstr(QryFormsDescription.asString) +' ?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
  ERPForm.Schedules.Delete;
end;

procedure TfmSchedulereports.RefreshScheduledReport;
begin
  if fScheduledReports = nil then begin
    CreateHistorylistform('TScheduledreportListGUI' ,Self, fScheduledReports,' ','');
    fScheduledReports.Parent := pnlScheduledReprots;
    fScheduledReports.BorderStyle := bsNone;
    fScheduledReports.fbIgnoreQuerySpeed := true;
    try
      fScheduledReports.Show;
      TScheduledreportListGUI(fScheduledReports).Customiseforemployee(ERPForm.Schedules.EmployeeId,ERPForm.Id);
    except
      FreeAndNil(fScheduledReports);
      Exit;
    end;
  end;
  TScheduledreportListGUI(fScheduledReports).Customiseforemployee(ERPForm.Schedules.EmployeeId,ERPForm.Id);
end;




procedure TfmSchedulereports.pgMainChange(Sender: TObject);
begin
  inherited;
  ERPForm.Schedules.PostDb;
  try
    if pgMain.ActivePage = tabScheduledReports then
      SetFocusedControl(fScheduledReports.grdMain);
  Except
    // kill the exception if the subform is not created
  end;
end;

procedure TfmSchedulereports.pnloptionsExit(Sender: TObject);
begin
  inherited;
  SaveOptions;
end;

procedure TfmSchedulereports.QryReportSchedulesAfterInsert(DataSet: TDataSet);
begin
  inherited;
  RefreshScheduledReport;
end;

procedure TfmSchedulereports.QryReportSchedulesBeforePost(DataSet: TDataSet);
begin
  inherited;
  RefreshScheduledReport;
end;

function TfmSchedulereports.RefreshOptions: Boolean;
begin
  Try
    SchedulereportOptions.RepeatFrequency     := ValueRepeatFrequency(ERPForm.Schedules.Frequency);
    SchedulereportOptions.Every               := ERPForm.Schedules.Every;
    SchedulereportOptions.RepeatWeekDay       := ERPForm.Schedules.WeekDay;
    SchedulereportOptions.MonthDays           := ERPForm.Schedules.MonthDays;
    SchedulereportOptions.BeginFromOption     := ERPForm.Schedules.BeginFromOption;
    SchedulereportOptions.StartDate           := ERPForm.Schedules.StartDate ;
    SchedulereportOptions.EndDate             := ERPForm.Schedules.EndDate ;
    SchedulereportOptions.ContinueIndefinitely:= ERPForm.Schedules.ContinueIndefinitely;
    SchedulereportOptions.SatAction           := ERPForm.Schedules.SatAction            ;
    SchedulereportOptions.sunAction           := ERPForm.Schedules.sunAction             ;
    SchedulereportOptions.HolidayAction       := ERPForm.Schedules.HolidayAction         ;
    SchedulereportOptions.rbGroupclick(nil);
    if SchedulereportOptions.ContinueIndefinitely then begin
      if screen.ActiveControl = SchedulereportOptions.dtFinalDate then SetControlFocus(SchedulereportOptions.chkIndefinit);
      SchedulereportOptions.dtFinalDate.Enabled:= False;
    end else begin
      SchedulereportOptions.dtFinalDate.Enabled:= True;
    end;
    Result:= true;
  Except
    REsult:= False;
  End;
end;

function TfmSchedulereports.RepeatFrequencyToValue(const Value: TRepeatFrequency): String;
begin
       if Value = rfDay then result := 'D'
  else if Value = rfWeek then result := 'W'
  else if Value = rfMonth then result := 'M'
  else result := '';
end;

initialization
  RegisterClassOnce(TfmSchedulereports);

end.

