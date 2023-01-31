unit PayListStateFrm;

interface
{$I ERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  StrUtils, wwcheckbox, wwDialog, Wwlocate, SelectionDialog, DNMPanel,
  MemDS, kbmMemTable, DBAccess, MyAccess,ERPdbComponents, ProgressDialog,
  wwdbdatetimepicker,  wwdblook, Shader, DAScript, MyScript, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TPayListStateTax = class(TBaseListingGUI)
    actReversePays: TAction;
    Label7: TLabel;
    qryBankDetails: TERPQuery;
    qryPayPaySplits: TERPQuery;
    DSPayPaySplits: TDataSource;
    qryPayPaySplitsEmployeeName: TWideStringField;
    qryPayPaySplitsDeleted: TWideStringField;
    qryPayPaySplitsType: TWideStringField;
    qryPayPaySplitsBSB: TWideStringField;
    qryPayPaySplitsAccountNo: TWideStringField;
    qryPayPaySplitsBankCode: TWideStringField;
    qryPayPaySplitsBankDescription: TWideStringField;
    qryPayPaySplitsAmount: TFloatField;
    btnPrintReport: TDNMSpeedButton;
    btnPrintPayslips: TDNMSpeedButton;
    chkUseDatePaid: TCheckBox;
    qryMainDatePaid: TWideStringField;
    qryMainStateWages: TFloatField;
    qryMainTaxRate: TFloatField;
    qryMainsTax: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkUseDatePaidClick(Sender: TObject);
    procedure btnPrintReportClick(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;

  private
    { Private declarations }
    sFilter: string;
    EmpStr: string;
    AddTable: string;
    Field2: string;
    bFirstOpen: boolean;

    procedure SetDateFilter;
    procedure PrintReport941;
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    function GetReportTypeID :Integer ; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses FastFuncs,Forms, CommonDbLib,
  //PayFunctionObj,
  CommonLib,BusObjPayUtils, MySQLConst, BaseInputForm, AppEnvironment,
  JsonObject, tcTypes , BusObjPayBase , chequeLib, tcConst, PayAccounts,
  tcDataUtils, DbSharedObjectsObj;

procedure TPayListStateTax.FormCreate(Sender: TObject);
var
  qry: TERPQuery;
  sl: TStringList;
  x: integer;
begin

  qryMain.Connection := CommonDbLib.GetSharedMyDacConnection;

  inherited;

end;

procedure TPayListStateTax.FormShow(Sender: TObject);
begin
  inherited;

  if not qryMain.Active then Exit;

  RefreshQuery;

  grdMain.Invalidate;
  grdMain.RefreshDisplay;

//  qryMain.FieldByName('Pay').Visible := false;
//  if Owner.Name = 'frmEmployeeFrm' then begin
//    qryMain.FieldByName('EmployeeName').Visible := false;
//    qryMain.FieldByName('Paid').Visible         := false;
//  end;
//  GuiPrefs.DbGridElement[grdMain].RemoveField('PayId');
//  SetupCustomFields;
//  grdMain.OnTitleButtonClick:= grdMainTitleButtonClick;
end;

procedure TPayListStateTax.RefreshQuery;
begin
  qryMain.Close;

  if chkIgnoreDates.Checked then begin
    qryMain.Params.ParamByName('dtFrom').AsDateTime := 0;
    qryMain.Params.ParamByName('dtTo').AsDateTime := SysUtils.MaxDateTime;
  end
  else begin
    qryMain.Params.ParamByName('dtFrom').AsString := FormatDateTime(MysqlDateFormat, dtfrom.Date);
    qryMain.Params.ParamByName('dtTo').AsString := FormatDateTime(MysqlDateFormat, dtto.Date);
  end;

  SetDateFilter;

  inherited;

end;

procedure TPayListStateTax.SetDateFilter;
begin
  if chkIgnoreDates.Checked then begin
    if chkUseDatePaid.Checked then begin
      sFilter := 'DatePaid Between ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, 0));
      sFilter := sFilter + ' AND ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, SysUtils.MaxDateTime));
    end else begin
      sFilter := 'PayDate Between ' + QuotedStr(FormatDateTime(MysqlDateFormat, 0));
      sFilter := sFilter + ' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat, SysUtils.MaxDateTime));
    end;
  end
  else begin
    if chkUseDatePaid.Checked then begin
      sFilter := 'DatePaid Between ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dtfrom.Date));
      sFilter := sFilter + ' AND ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat, dtto.Date));
    end else begin
      sFilter := 'PayDate Between ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtfrom.Date));
      sFilter := sFilter + ' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtto.Date));
    end;
  end;
end;

function TPayListStateTax.GetReportTypeID: Integer;
begin
  Result := 129;
end;

procedure TPayListStateTax.RefreshTotals;
begin
  inherited;
  CalcnShowfooter;
end;

procedure TPayListStateTax.chkUseDatePaidClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TPayListStateTax.btnPrintReportClick(Sender: TObject);
begin
  //PrintReport941;
end;

procedure TPayListStateTax.PrintReport941;
var
  ReportTemplate: string;
  ReportSQL: string;
begin
  DisableForm;
  Processingcursor(True);
  try
    // Get the selected year and quarter

    ReportTemplate := 'USAPayroll Form 941';

    ReportSQL := '{Quarterly} ' +
                'SELECT * FROM ( ' +
                'SELECT CONVERT(YEAR(DatePaid), CHAR) AS Y, CONVERT(QUARTER(DatePaid), CHAR) AS Q, ' +
                '	SUM(Gross) AS GrossWage, ' +
                '	SUM(FitWages) AS FitWage, SUM(fTax) AS FederalTax, ' +
                '	SUM(SocWages) AS SocWage, SUM(sTax) AS SocialTax, ' +
                '	SUM(MedWages) AS MedWage, SUM(mTax) AS MedicareTax, ' +
                '	SUM(sTax) + SUM(mTax) AS FICATax, ' +
                '	SUM(fTax) + SUM(sTax) + SUM(mTax) AS TotalTax, ' +
                '	0.0 AS ToTalDeposit, ';

    ReportSQLSupplied := True;
    PrintTemplateReport(ReportTemplate, ReportSQL, True, 1);

  finally
    Processingcursor(False);
    EnableForm;
  end;
end;

procedure TPayListStateTax.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TPayListStateTax.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TPayListStateTax.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TPayListStateTax.grdMainDblClick(Sender: TObject);
//var form: TBaseInputGUI;
begin
//  { form TfrmEmployeePay was not designed to have its keyid changed and
//    formshow called more than once (it crashes), also not designed to have
//    more than one instance open at a time!! ...
//    so always close existing instance before opening/re-showing new }
//  form:= TBaseInputGUI(FindExistingComponent('TfrmEmployeePay'));
//  if Assigned(form) then begin
//    form.Close;
//    Application.ProcessMessages;
//  end;
//  if not FormStillOpen('TfrmEmployeePay') then begin
    inherited;
//  end;
end;


initialization
  RegisterClassOnce(TPayListStateTax);
end.
