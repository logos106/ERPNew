unit EmailedReportSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DNMSpeedButton, ExtCtrls, DNMPanel, Menus, AdvMenus,
  DataState, DBAccess, MyAccess, SelectionDialog, AppEvnts, DB, 
  MemDS, StdCtrls, Mask, wwdbedit, Wwdotdot, Wwdbcomb, wwdbdatetimepicker,
  Wwdbspin, wwdblook, DBCtrls, wwcheckbox, Shader;

type
  TEmailedReportScheduleGUI = class(TBaseInputGUI)
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    dpStartDate: TwwDBDateTimePicker;
    lblStartDate: TLabel;
    cboMode: TwwDBComboBox;
    lblMode: TLabel;
    dpStartDateTime: TwwDBDateTimePicker;
    lblTime: TLabel;
    Label3: TLabel;
    qryEmailedReportsSchedule: TMyQuery;
    edDescription: TwwDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    cboTemplate: TwwDBLookupCombo;
    Label20: TLabel;
    FromDate: TwwDBSpinEdit;
    ToDate: TwwDBSpinEdit;
    NextSendDate: TwwDBDateTimePicker;
    Label5: TLabel;
    Label6: TLabel;
    DNMSpeedButton1: TDNMSpeedButton;
    DNMSpeedButton2: TDNMSpeedButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label36: TLabel;
    chkActive: TwwCheckBox;
    wwCheckBox1: TwwCheckBox;
    Label7: TLabel;
    qryEmailedReportsScheduleGlobalRef: TStringField;
    qryEmailedReportsScheduleEmailedReportID: TIntegerField;
    qryEmailedReportsScheduleStartDate: TDateTimeField;
    qryEmailedReportsScheduleMode: TStringField;
    qryEmailedReportsScheduleNextSend: TDateTimeField;
    qryEmailedReportsScheduleFromDate: TSmallintField;
    qryEmailedReportsScheduleToDate: TSmallintField;
    qryEmailedReportsScheduleUseBcc: TStringField;
    qryEmailedReportsScheduleActive: TStringField;
    qryEmailedReportsScheduleReportName: TStringField;
    DSEmailedReportsSchedule: TDataSource;
    qryTemplates: TMyQuery;
    qryEmployeeEmail: TMyQuery;
    cboEmails: TwwDBLookupCombo;
    cboDateRange: TComboBox;
    Bevel3: TBevel;
    qryEmailedReportsScheduleTemplateID: TIntegerField;
    qryEmailedReportsScheduleEmails: TMemoField;
    EmailList: TListBox;
    Label8: TLabel;
    qryEmailedReportsScheduleDateRangeMode: TStringField;
    Label9: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure DNMSpeedButton2Click(Sender: TObject);
    procedure cboDateRangeChange(Sender: TObject);
    procedure dpStartDateChange(Sender: TObject);
    procedure cboEmailsNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: String; var Accept: Boolean);
    procedure cboTemplateNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: String; var Accept: Boolean);
    procedure FromDateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  FormFactory, CommonLib, DNMExceptions, DateUtils, 
   AppEnvironment, FastFuncs;

{$R *.dfm}

procedure TEmailedReportScheduleGUI.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TEmailedReportScheduleGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := cafree;
end;

procedure TEmailedReportScheduleGUI.FormShow(Sender: TObject);
begin
  try
    inherited;
    if qryEmailedReportsSchedule.Active then begin
      CloseQueries;
    end;

    qryEmailedReportsSchedule.Params.ParamByName('xID').asInteger := KeyID;
    OpenQueries;

    if KeyID = 0 then begin
      qryEmailedReportsSchedule.Insert;
    end else begin
      qryEmailedReportsSchedule.Edit;
      EmailList.Items.Text := qryEmailedReportsScheduleEmails.AsString;
      dpStartDate.Date := qryEmailedReportsScheduleStartDate.asDateTime;
      dpStartDateTime.DateTime := qryEmailedReportsScheduleStartDate.asDateTime;
      cboDateRange.Text := qryEmailedReportsScheduleDateRangeMode.AsString;

    end;

  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
    else raise;
  end;
end;

procedure TEmailedReportScheduleGUI.btnCompletedClick(Sender: TObject);
begin
  inherited;
  try
    if not Empty(edDescription.Text) then begin
      qryEmailedReportsSchedule.Edit;

      qryEmailedReportsScheduleEmails.AsString :=  EmailList.Items.Text;
      qryEmailedReportsScheduleStartDate.asDateTime :=  dpStartDate.Date + dpStartDateTime.Time;
      qryEmailedReportsScheduleDateRangeMode.AsString := cboDateRange.Text; 

      qryEmailedReportsSchedule.Post;
      Notify;
      Self.Close;
    end else begin
      CommonLib.MessageDlgXP_Vista('Name cannot be blank.', mtError, [mbOK], 0);
      SetControlFocus(edDescription);
    end;
  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

procedure TEmailedReportScheduleGUI.DNMSpeedButton1Click(Sender: TObject);
Var
  I:Integer;
begin
  inherited;
  If not Empty(cboEmails.Text) then Begin
    For I := 0 to EmailList.Count-1 do Begin
      If FastFuncs.SameText(EmailList.Items[I],Trim(cboEmails.Text)) then
        Exit;
    end;
    EmailList.AddItem(FastFuncs.Trim(cboEmails.Text),nil);
  end;
end;

procedure TEmailedReportScheduleGUI.DNMSpeedButton2Click(Sender: TObject);
Var
  I:Integer;
begin
  inherited;
  For I := 0 to EmailList.Count-1 do Begin
    If EmailList.Selected[I] then Begin
      EmailList.Items.Delete(I);
      Exit;
    end;
  end;
end;

procedure TEmailedReportScheduleGUI.cboDateRangeChange(Sender: TObject);
const
  // Date Range Combo values
  CUSTOM_RANGE   = 0;
  DEFAULT_RANGE  = 1;
  TODAY          = 2;
  YESTEDAY       = 3;
  LAST_WEEK      = 4;
  LAST_MONTH     = 5;
  LAST_QUARTER   = 6;
  LAST_12_MONTHS = 7;
  PREV_WEEK      = 8;
  PREV_MONTH     = 9;
  PREV_QUARTER   = 10;
  PREV_FINANCIAL_YEAR = 11;
  THIS_WEEK      = 12;
  THIS_MONTH     = 13;
  THIS_QUARTER   = 14;
  THIS_FINANCIAL_YEAR = 15;
  THIS_FINANCIAL_YEAR_TO_DATE = 16;

Var
  MonthsList: TStringList;
  FiscalYearStartMonthIndex: integer;
  dtFrom : TDateTime;
  dtTo : TDateTime;

  function StartOfTheQuarter(dtDate: TDateTime): TDateTime;
  var
    iMonth: integer;
    iQuater: integer;
    iStartMonth: integer;
  begin
    iMonth := MonthOfTheYear(dtDate);
    iQuater := (iMonth - 1) div 3 + 1;
    iStartMonth := (iQuater - 1) * 3 + 1;
    Result := StartOfTheMonth(RecodeMonth(dtDate, iStartMonth));
  end;

begin
  dtFrom := qryEmailedReportsScheduleNextSend.AsDateTime - AppEnv.Employee.ListDaysPast;
  dtTo := qryEmailedReportsScheduleNextSend.AsDateTime + AppEnv.Employee.ListDaysFuture;
  inherited;
  MonthsList := TStringList.Create;
  MonthsList.Add('January');
  MonthsList.Add('February');
  MonthsList.Add('March');
  MonthsList.Add('April');
  MonthsList.Add('May');
  MonthsList.Add('June');
  MonthsList.Add('July');
  MonthsList.Add('August');
  MonthsList.Add('September');
  MonthsList.Add('October');
  MonthsList.Add('November');
  MonthsList.Add('December');
  FiscalYearStartMonthIndex := MonthsList.IndexOf(AppEnv.CompanyPrefs.FiscalYearStarts);

  case cboDateRange.ItemIndex of
    DEFAULT_RANGE:
      begin
        dtFrom := qryEmailedReportsScheduleNextSend.AsDateTime - AppEnv.Employee.ListDaysPast;
        dtTo := qryEmailedReportsScheduleNextSend.AsDateTime + AppEnv.Employee.ListDaysFuture;
      end;

    TODAY:
      begin
        dtFrom := Date;
        dtTo := Date;
      end;
      
    YESTEDAY:
      begin
        dtFrom := IncDay(Date, - 1);
        dtTo := IncDay(Date, - 1);
      end;
      
    LAST_WEEK:
      begin
        dtFrom := IncDay(Date, - 6);
        dtTo := Date;
      end;
      
    LAST_MONTH:
      begin
        dtFrom := IncDay(IncMonth(Date, - 1));
        dtTo := Date;
      end;
      
    LAST_QUARTER:
      begin
        dtFrom := IncDay(IncMonth(Date, - 3));
        dtTo := Date;
      end;
      
    LAST_12_MONTHS:
      begin
        dtFrom := IncDay(IncYear(Date, - 1));
        dtTo := Date;
      end;

    PREV_WEEK:
      begin
        dtFrom := IncWeek(StartOfTheWeek(Date), - 1);
        dtTo := IncDay(dtFrom, 6);
      end;
      
    PREV_MONTH:
      begin
        dtFrom := IncMonth(StartOfTheMonth(Date), - 1);
        dtTo := IncDay(IncMonth(dtFrom), - 1);
      end;
      
    PREV_QUARTER:
      begin
        dtFrom := IncMonth(StartOfTheQuarter(Date), - 3);
        dtTo := IncDay(IncMonth(dtFrom, 3), - 1);
      end;
      
    PREV_FINANCIAL_YEAR:
      begin
        if MonthOfTheYear(Date) <= 6 then dtFrom := IncYear(IncMonth(StartOfTheYear(IncYear(Date, - 1)), 6), - 1)
        else dtFrom := IncYear(IncMonth(StartOfTheYear(Date), 6), - 1);

        dtTo := IncDay(IncYear(dtFrom), - 1);
      end;

    THIS_WEEK:
      begin
        dtFrom := StartOfTheWeek(Date);
        dtTo := IncDay(dtFrom, 6);
      end;
      
    THIS_MONTH:
      begin
        dtFrom := StartOfTheMonth(Date);
        dtTo := IncDay(IncMonth(dtFrom), - 1);
      end;
      
    THIS_QUARTER:
      begin
        dtFrom := StartOfTheQuarter(Date);
        dtTo := IncDay(IncMonth(dtFrom, 3), - 1);
      end;
      
    THIS_FINANCIAL_YEAR:
      begin
        if MonthOfTheYear(Date) <= 6 then dtFrom := IncMonth(StartOfTheYear(IncYear(Date, - 1)), 6)
        else dtFrom := IncMonth(StartOfTheYear(Date), 6);
          
        dtTo := IncDay(IncYear(dtFrom), - 1);
      end;

    THIS_FINANCIAL_YEAR_TO_DATE:
      begin
        if MonthOfTheYear(Date) <= FiscalYearStartMonthIndex then begin
          dtFrom := IncMonth(StartOfTheYear(IncYear(Date, - 1)), FiscalYearStartMonthIndex);
        end else begin
          dtFrom := IncMonth(StartOfTheYear(Date), FiscalYearStartMonthIndex);
        end;
        dtTo := qryEmailedReportsScheduleNextSend.AsDateTime;
      end;
  end;

  FromDate.Value := DateUtils.DaysBetween(qryEmailedReportsScheduleNextSend.AsDateTime,dtFrom);

  If DateUtils.CompareDateTime(qryEmailedReportsScheduleNextSend.AsDateTime,dtFrom)>0 then
    FromDate.Value := FromDate.Value * -1;

  ToDate.Value := DateUtils.DaysBetween(qryEmailedReportsScheduleNextSend.AsDateTime,dtTo);

  If DateUtils.CompareDateTime(qryEmailedReportsScheduleNextSend.AsDateTime,dtTo)>0 then
    ToDate.Value := ToDate.Value * -1;
end;

procedure TEmailedReportScheduleGUI.dpStartDateChange(Sender: TObject);
begin
  inherited;
  if (fsShowing in Self.FormState) or (fsCreating in Self.FormState) then Exit;
  qryEmailedReportsScheduleNextSend.asDateTime :=  dpStartDate.Date + dpStartDateTime.Time;  
end;

procedure TEmailedReportScheduleGUI.cboEmailsNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
  Accept := True;
end;

procedure TEmailedReportScheduleGUI.cboTemplateNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
  Accept := False;
end;

procedure TEmailedReportScheduleGUI.FromDateClick(Sender: TObject);
begin
  inherited;
  cboDateRange.ItemIndex := 0;
end;

initialization
  RegisterClassOnce(TEmailedReportScheduleGUI);
  with FormFact do begin
    RegisterMe(TEmailedReportScheduleGUI, 'TEmailedReportScheduleListGUI_*=EmailedReportID');
  end;
end.
