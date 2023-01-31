unit PayList941Frm;

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
  TPayListForm941 = class(TBaseListingGUI)
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
    btnPrintCheque: TDNMSpeedButton;
    btnPrintPayslips: TDNMSpeedButton;
    chkUseDatePaid: TCheckBox;
    grdDetail: TwwDBGrid;
    wwIButton1: TwwIButton;
    qryDetail: TERPQuery;
    dsDetail: TDataSource;
    qryMainDetail: TWideStringField;
    qryMainYear: TWideStringField;
    qryMainQUARTER: TWideStringField;
    qryMainGrossWage: TFloatField;
    qryMainFitWage: TFloatField;
    qryMainFederalTax: TFloatField;
    qryMainSocWage: TFloatField;
    qryMainSocialTax: TFloatField;
    qryMainMedWage: TFloatField;
    qryMainMedicareTax: TFloatField;
    qryMainFICATax: TFloatField;
    qryMainTotalTax: TFloatField;
    qryMainToTalDeposit: TFloatField;
    qryMainTaxDue: TFloatField;
    ebnDetail: TwwExpandButton;
    qryDetailDatePaid: TWideStringField;
    qryDetailTaxL: TFloatField;
    qryDetailDeposit: TFloatField;
    qryDetailTaxD: TFloatField;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkUseDatePaidClick(Sender: TObject);
    procedure btnPrintReportClick(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure btnPrintChequeClick(Sender: TObject);
    procedure ebnDetailBeforeExpand(Sender: TObject);
    procedure ebnDetailAfterExpand(Sender: TObject);

  private
    { Private declarations }
    sFilter: string;
    EmpStr: string;
    AddTable: string;
    Field2: string;
    bFirstOpen: boolean;
    sOption: string;
    procedure SetDateFilter;
    procedure PrintReport941;
    procedure LoadSQL(AYear: Word; AQuarter: Word);
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

procedure TPayListForm941.FormCreate(Sender: TObject);
var
  qry: TERPQuery;
  sl: TStringList;
  x: integer;
begin

  qryMain.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryDetail.Connection := CommonDbLib.GetSharedMyDacConnection;

  sOption := 'Detail';

  inherited;

end;

procedure TPayListForm941.FormShow(Sender: TObject);
begin
  inherited;

  if not qryMain.Active then Exit;

  RefreshQuery;

  grdMain.Invalidate;
  grdMain.RefreshDisplay;

  grdDetail.Invalidate;
  grdDetail.RefreshDisplay;
  grdDetail.TitleColor := Self.Color;
  grdDetail.FooterColor := Self.Color;

//  qryMain.FieldByName('Pay').Visible := false;
//  if Owner.Name = 'frmEmployeeFrm' then begin
//    qryMain.FieldByName('EmployeeName').Visible := false;
//    qryMain.FieldByName('Paid').Visible         := false;
//  end;
//  GuiPrefs.DbGridElement[grdMain].RemoveField('PayId');
//  SetupCustomFields;
//  grdMain.OnTitleButtonClick:= grdMainTitleButtonClick;
end;

procedure TPayListForm941.RefreshQuery;
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

procedure TPayListForm941.SetDateFilter;
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

procedure TPayListForm941.grpFiltersClick(Sender: TObject);
begin
  SetDateFilter;
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      sOption := 'Detail';
    1:
      sOption := 'Summary';
  end;

  RefreshQuery;
  
  inherited;
    
end;

function TPayListForm941.GetReportTypeID: Integer;
begin
  Result := 129;
end;

procedure TPayListForm941.RefreshTotals;
begin
  inherited;
  CalcnShowfooter;
end;

procedure TPayListForm941.chkUseDatePaidClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TPayListForm941.btnPrintReportClick(Sender: TObject);
begin
  PrintReport941;
end;

procedure TPayListForm941.PrintReport941;
var
  Year, Quarter: Integer;
  ReportTemplate: string;
  ReportSQL: string;
begin
  DisableForm;
  Processingcursor(True);
  try
    // Get the selected year and quarter
    Year := qryMainYear.AsInteger;
    Quarter := qryMainQuarter.AsInteger;

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
                '	0.0 AS ToTalDeposit, ' +
                '	SUM(fTax) + SUM(sTax) + SUM(mTax) - 0.0 AS TaxDue ' +
                'FROM ( ' +
                '	SELECT p.PayID, p.DatePaid, ' +
                '		p.Gross,	p.FitWages,	p.SocWages,	p.MedWages, ' +
                '		SUM(IF(c.GroupType="Federal", t.Amount , 0)) AS fTax, ' +
                '		SUM(IF(c.GroupType="SocialSecurity", t.Amount , 0)) AS sTax, ' +
                '		SUM(IF(c.GroupType="Medicare", t.Amount , 0)) AS mTax ' +
                '	FROM tblpays p LEFT JOIN tblpaytax t ON p.PayID=t.PayID ' +
                '		LEFT JOIN tblpaytaxconfig c ON t.PayTaxConfigId=c.ID ' +
                '	WHERE p.DatePaid IS NOT null ' +
                ') T ' +
                'WHERE DatePaid BETWEEN "' + FormatDateTime(MysqlDateFormat, dtfrom.Date) + '" AND "' + FormatDateTime(MysqlDateFormat, dtTo.Date) + '" ' +
                'GROUP BY YEAR(DatePaid), QUARTER(DatePaid)) T2 ' +
                'WHERE Y = ' + IntToStr(Year) + ' AND Q = ' + IntToStr(Quarter) + ' ' +
                '~|||~ ' +
                '{Quarterly} ' +
                'SELECT MID(ABN, 1, 1) AS EIN1, MID(ABN, 2, 1) AS EIN2, MID(ABN, 3, 1) AS EIN3, MID(ABN, 4, 1) AS EIN4, ' +
                '	MID(ABN, 5, 1) AS EIN5, MID(ABN, 6, 1) AS EIN6, MID(ABN, 7, 1) AS EIN7, ' +
                '	MID(ABN, 8, 1) AS EIN8, MID(ABN, 9, 1) AS EIN9, ' +
                '	CONCAT(FirstName, " ", LastName) AS EName, CONCAT(Address, " ", Address2, " ", Address3) AS Address, ' +
                '	City, State, POBox ' +
                'FROM tblcompanyinformation';

    ReportSQLSupplied := True;
    PrintTemplateReport(ReportTemplate, ReportSQL, True, 1);

  finally
    Processingcursor(False);
    EnableForm;
  end;
end;

procedure TPayListForm941.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TPayListForm941.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TPayListForm941.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TPayListForm941.ebnDetailAfterExpand(Sender: TObject);
begin
  inherited;

  grdDetail.Width := grdMain.Width - 65;
  grdDetail.Height := grdMain.Height - 65;
end;

procedure TPayListForm941.ebnDetailBeforeExpand(Sender: TObject);
var
  Year, Quarter: Word;
begin
  inherited;

  qryDetail.Close;

  // Get the selected year and quarter
  Year := qryMainYear.AsInteger;
  Quarter := qryMainQuarter.AsInteger;

  LoadSQL(Year, Quarter);

  qryDetail.Open;
end;

procedure TPayListForm941.btnPrintChequeClick(Sender: TObject);
begin
  inherited;
  ReportToPrint := '';
  if isTochooseTemplate then begin
    LoadReportTypes;
    if dlgReportSelect.Execute then
      ReportToPrint := trim(dlgReportSelect.SelectedItems.Text);
  end;
  if ReportToPrint = '' then tcdatautils.GetDefaultReport(GetReportTypeID);
  if ReportToPrint = '' then ReportToPrint := 'Pay cheque';
  IterateProcNo:= 1;
  IterateSelectedRecords;
end;

procedure TPayListForm941.grdMainDblClick(Sender: TObject);
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

procedure TPayListForm941.LoadSQL(AYear: Word; AQuarter: Word);
var
  I: Integer;
  LMonth: Integer;
begin
  qryDetail.SQL.Clear;

  qryDetail.SQL.Add('SET @rt = 0;');
  for I := 0 to 2 do begin
    LMonth := (AQuarter - 1) * 3 + 1 + I;
    with qryDetail do begin
      SQL.Add('SELECT ');
      SQL.Add(' DATE_FORMAT(DatePaid, "%Y-%m-%d") AS DatePaid, ');
      SQL.Add(' TaxL, 0.0 AS Deposit, ');
      SQL.Add(' @rt := @rt + totals.TaxL AS TaxD ');
      SQL.Add('FROM ');
      SQL.Add(' (SELECT DatePaid, SUM(Tax) AS TaxL FROM tblpays ');
      SQL.Add('  WHERE YEAR(DatePaid)=' + IntToStr(AYear) + ' AND MONTH(DatePaid)=' + IntToStr(LMonth) + ' ');
      SQL.Add('  GROUP BY DatePaid ');
      SQL.Add(' ) totals ');

      SQL.Add('UNION ALL');

      SQL.Add('SELECT ');
      SQL.Add(' "Total" AS DatePaid, SUM(Tax) AS TaxL, 0.0 AS Depoist, 0.0 TaxD ');
      SQL.Add('FROM tblpays ');
      SQL.Add('WHERE YEAR(DatePaid) = ' + IntToStr(AYear) + ' AND MONTH(DatePaid)=' + IntToStr(LMonth) + ' ');

      SQL.Add('UNION ALL');
    end;
  end;

  qryDetail.SQL.Delete(qryDetail.SQL.Count - 1);
end;

initialization
  RegisterClassOnce(TPayListForm941);
end.
