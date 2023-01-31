unit frmServerLogList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DNMSpeedButton, StdCtrls, wwdbdatetimepicker, Shader, Grids,
  Wwdbigrd, Wwdbgrid, ExtCtrls, DB, DBAccess, MyAccess, ERPdbComponents, MemDS,
  wwcheckbox;

type
  TfmServerLogList = class(TForm)
    pnlHeader: TPanel;
    pnlBottom: TPanel;
    grdMain: TwwDBGrid;
    Panel1: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    chkIgnoreDates: TCheckBox;
    cboDateRange: TComboBox;
    lblFrom: TLabel;
    dtFrom: TwwDBDateTimePicker;
    lblTo: TLabel;
    dtTo: TwwDBDateTimePicker;
    cmdClose: TDNMSpeedButton;
    dsMain: TDataSource;
    qryMain: TERPQuery;
    MyConnection1: TERPConnection;
    qryMainLogID: TLargeintField;
    qryMainModule: TWideStringField;
    qryMainLogTime: TDateTimeField;
    qryMainLogType: TWideStringField;
    qryMainLog: TWideMemoField;
    cboModule: TComboBox;
    label1: TLabel;
    Label2: TLabel;
    cboType: TComboBox;
    btnRequery: TDNMSpeedButton;
    chkFollowTail: TwwCheckBox;
    btnClearLog: TDNMSpeedButton;
    tmrFollowTail: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdCloseClick(Sender: TObject);
    procedure cboDateRangeCloseUp(Sender: TObject);
    procedure dtFromChange(Sender: TObject);
    procedure dtToChange(Sender: TObject);
    procedure cboTypeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cboModuleChange(Sender: TObject);
    procedure chkIgnoreDatesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnRequeryClick(Sender: TObject);
    procedure btnClearLogClick(Sender: TObject);
    procedure tmrFollowTailTimer(Sender: TObject);
    procedure chkFollowTailClick(Sender: TObject);
  private
//    fModuleName
    LogCount: integer;
    procedure RefreshQuery;
    function GetModuleName: string;
    procedure SetModuleName(const Value: string);
  public
    { Public declarations }
  published
    property ModuleName: string read GetModuleName write SetModuleName;
  end;

var
  fmServerLogList: TfmServerLogList;

implementation

uses
  DateUtils, DbSharedObjectsObj, Vista_MessageDlg, LogThreadDbLib;

{$R *.dfm}

procedure TfmServerLogList.btnClearLogClick(Sender: TObject);
var
  cmd: TErpCommand;
begin
  inherited;
  if Vista_MessageDlg.MessageDlgXP_Vista('This will delete all the Server Log Entries, is that what you want to do?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
    cmd:= TErpCommand.Create(nil);
    try
      cmd.Connection := MyConnection1;
      cmd.SQL.Text:= 'truncate tblLog';
      cmd.Execute;
      self.btnRequery.Click;
    finally
      cmd.Free;
    end;
  end;
end;

procedure TfmServerLogList.btnRequeryClick(Sender: TObject);
begin
  RefreshQuery;
end;

procedure TfmServerLogList.cboDateRangeCloseUp(Sender: TObject);
const
  // Date Range Combo values
  TODAY = 0;
  YESTEDAY = 1;
  LAST_WEEK = 2;
  LAST_MONTH = 3;
  LAST_QUARTER = 4;
  LAST_12_MONTHS = 5;
  PREV_WEEK = 6;
  PREV_MONTH = 7;
  PREV_QUARTER = 8;
  PREV_FINANCIAL_YEAR = 9;
  THIS_WEEK = 10;
  THIS_MONTH = 11;
  THIS_QUARTER = 12;
  THIS_FINANCIAL_YEAR = 13;
  THIS_FINANCIAL_YEAR_TO_DATE = 14;
  // from 1st of [Fiscal Year] ()Preference in account tab) to Today

var
  MonthsList: TStringList;
  FiscalYearStartMonthIndex: integer;

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
  //if ErrorOccurred then exit;
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
//  FiscalYearStartMonthIndex := MonthsList.IndexOf(AppEnv.CompanyPrefs.FiscalYearStarts);
  FiscalYearStartMonthIndex := MonthsList.IndexOf('January');

  case cboDateRange.ItemIndex of
    TODAY: begin
        dtFrom.Date := Date;
        dtTo.Date := Date;
      end;
    YESTEDAY: begin
        dtFrom.Date := IncDay(Date, -1);
        dtTo.Date := IncDay(Date, -1);
      end;
    LAST_WEEK: begin
        dtFrom.Date := IncDay(Date, -6);
        dtTo.Date := Date;
      end;
    LAST_MONTH: begin
        dtFrom.Date := IncDay(IncMonth(Date, -1));
        dtTo.Date := Date;
      end;
    LAST_QUARTER: begin
        dtFrom.Date := IncDay(IncMonth(Date, -3));
        dtTo.Date := Date;
      end;
    LAST_12_MONTHS: begin
        dtFrom.Date := IncDay(IncYear(Date, -1));
        dtTo.Date := Date;
      end;
    PREV_WEEK: begin
        dtFrom.Date := IncWeek(StartOfTheWeek(Date), -1);
        dtTo.Date := IncDay(dtFrom.Date, 6);
      end;
    PREV_MONTH: begin
        dtFrom.Date := IncMonth(StartOfTheMonth(Date), -1);
        dtTo.Date := IncDay(IncMonth(dtFrom.Date), -1);
      end;
    PREV_QUARTER: begin
        dtFrom.Date := IncMonth(StartOfTheQuarter(Date), -3);
        dtTo.Date := IncDay(IncMonth(dtFrom.Date, 3), -1);
      end;
    PREV_FINANCIAL_YEAR: begin
        if MonthOfTheYear(Date) <= FiscalYearStartMonthIndex then begin
          dtFrom.Date := IncYear(IncMonth(StartOfTheYear(IncYear(Date, -1)), FiscalYearStartMonthIndex), -1);
        end else begin
          dtFrom.Date := IncYear(IncMonth(StartOfTheYear(Date), FiscalYearStartMonthIndex), -1);
        end;
        dtTo.Date := IncDay(IncYear(dtFrom.Date), -1);
      end;
    THIS_WEEK: begin
        dtFrom.Date := StartOfTheWeek(Date);
        dtTo.Date := IncDay(dtFrom.Date, 6);
      end;
    THIS_MONTH: begin
        dtFrom.Date := StartOfTheMonth(Date);
        dtTo.Date := IncDay(IncMonth(dtFrom.Date), -1);
      end;
    THIS_QUARTER: begin
        dtFrom.Date := StartOfTheQuarter(Date);
        dtTo.Date := IncDay(IncMonth(dtFrom.Date, 3), -1);
      end;
    THIS_FINANCIAL_YEAR: begin
        if MonthOfTheYear(Date) <= FiscalYearStartMonthIndex then begin
          dtFrom.Date := IncMonth(StartOfTheYear(IncYear(Date, -1)), FiscalYearStartMonthIndex);
        end else begin
          dtFrom.Date := IncMonth(StartOfTheYear(Date), FiscalYearStartMonthIndex);
        end;
        dtTo.Date := IncDay(IncYear(dtFrom.Date), -1);
      end;
    THIS_FINANCIAL_YEAR_TO_DATE: begin
        if MonthOfTheYear(Date) <= FiscalYearStartMonthIndex then begin
          dtFrom.Date := IncMonth(StartOfTheYear(IncYear(Date, -1)), FiscalYearStartMonthIndex);
        end else begin
          dtFrom.Date := IncMonth(StartOfTheYear(Date), FiscalYearStartMonthIndex);
        end;
        dtTo.Date := DateUtils.TODAY;
      end;
  end;
  // dtFromChange(nil);
  dtToChange(nil);
end;

procedure TfmServerLogList.cboModuleChange(Sender: TObject);
begin
  RefreshQuery;
end;

procedure TfmServerLogList.cboTypeChange(Sender: TObject);
begin
  RefreshQuery;
end;

procedure TfmServerLogList.chkFollowTailClick(Sender: TObject);
begin
  tmrFollowTail.Enabled:= chkFollowTail.Checked;
end;

procedure TfmServerLogList.chkIgnoreDatesClick(Sender: TObject);
begin
  RefreshQuery;
end;

procedure TfmServerLogList.cmdCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmServerLogList.dtFromChange(Sender: TObject);
begin
  RefreshQuery;
end;

procedure TfmServerLogList.dtToChange(Sender: TObject);
begin
  RefreshQuery;
end;

procedure TfmServerLogList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;


procedure TfmServerLogList.FormCreate(Sender: TObject);
var
  qry: TERPQuery;
begin
  TDbLogger.CheckDbExists('localhost');

  qryMain.Close;
  myConnection1.Close;
  myConnection1.Server := 'localhost';
  myConnection1.Database := 'services';
  myConnection1.Open;

  qry := DbSharedObj.GetQuery(myConnection1);
  try
    qry.SQL.Text := 'select distinct Module from tbllog';
    qry.Open;
    cboModule.Items.Clear;
    cboModule.Items.Add('All');
    while not qry.Eof do begin
      cboModule.Items.Add(qry.FieldByName('Module').AsString);
      qry.Next;
    end;
    cboModule.ItemIndex := 0;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TfmServerLogList.FormShow(Sender: TObject);
begin
  cboDateRange.ItemIndex := cboDateRange.Items.IndexOf('This Week');
  cboDateRangeCloseUp(cboDateRange);
//  RefreshQuery;
end;

function TfmServerLogList.GetModuleName: string;
begin
  result := cboModule.Text;
end;

procedure TfmServerLogList.RefreshQuery;
begin
  qryMain.Close;
  if chkIgnoreDates.Checked then begin
    qryMain.ParamByName('dtFrom').AsDateTime := 0;
    qryMain.ParamByName('dtTo').AsDateTime := MaxDateTime;
  end
  else begin
    qryMain.ParamByName('dtFrom').AsDateTime := dtFrom.Date;
    qryMain.ParamByName('dtTo').AsDateTime := dtTo.Date;
  end;
  qryMain.ParamByName('Module').AsString := cboModule.Text;
  qryMain.ParamByName('LogType').AsString := cboType.Text;
  qryMain.Open;
end;

procedure TfmServerLogList.SetModuleName(const Value: string);
var
  idx: integer;
begin
  idx := cboModule.Items.IndexOf(Value);
  if idx > -1 then
    cboModule.ItemIndex := idx;
end;

procedure TfmServerLogList.tmrFollowTailTimer(Sender: TObject);
var
  qry: TERPQuery;
begin
  inherited;
  tmrFollowTail.Enabled:= false;
  try
    qry:= DbSharedObj.GetQuery(qryMain.Connection);
    try
      qry.Connection:= qryMain.Connection;
      qry.SQL.Add('select count(LogId) as LogCount from tblLog');
      qry.SQL.Add('where LogTime between :dtFrom and :dtTo');
      qry.SQL.Add('and ((:Module = "All") or (:Module = Module))');
      qry.SQL.Add('and ((:LogType = "All") or (:LogType = "Error" and LogType = "ltError") or (:LogType = "Warning" and LogType = "ltWarning"))');

      qry.ParamByName('dtFrom').AsDate:= dtFrom.Date;
      qry.ParamByName('dtTo').AsDate:= dtTo.Date;
      qry.ParamByName('Module').AsString := cboModule.Text;
      qry.ParamByName('LogType').AsString := cboType.Text;

      qry.Open;
      if LogCount <> qry.FieldByName('LogCount').AsInteger then begin
        LogCount:= qry.FieldByName('LogCount').AsInteger;
        qry.Close;
        btnRequery.Click;
      end;
    finally
      DbSharedObj.ReleaseObj(qry);
    end;
  finally
    if chkFollowTail.Enabled then
      tmrFollowTail.Enabled:= true;
  end;
end;

initialization
  RegisterClass(TfmServerLogList);

end.
