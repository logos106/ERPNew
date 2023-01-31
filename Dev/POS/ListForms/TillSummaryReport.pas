unit TillSummaryReport;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 15/06/05  1.00.01 IJB  Modified to show Invoice sales through POS.
  // 10/08/05  1.00.02 DSP  'New' button is now disabled.
  // 01/11/05  1.00.03 DLS  Added RegisterClass

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, MyAccess,ERPdbComponents, MemDS, DBAccess,
  wwdbdatetimepicker,
  //ERP
  MessageConst, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox,
  ReportSQLTillSummary;

type
  TTillSummaryReportGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainTillName: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainClass: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainInvoiceDocNumber: TWideStringField;
    qryMainCash: TFloatField;
    qryMainEFTPOS: TFloatField;
    qryMainDebitCard: TFloatField;
    qryMainCheque: TFloatField;
    qryMainDinersClub: TFloatField;
    qryMainMasterCard: TFloatField;
    qryMainVISA: TFloatField;
    qryMainAmex: TFloatField;
    qryMainAmericanExpress: TFloatField;
    qryMainBankCard: TFloatField;
    qryMainCreditCard: TFloatField;
    qryMainDirectDebt: TFloatField;
    qryMainDirectDeposit: TFloatField;
    qryMainMoneyOrder: TFloatField;
    qryMainLayby: TFloatField;
    qryMainVoucher: TFloatField;
    qryMainVoucherReversal: TFloatField;
    qryMainTotal: TFloatField;
    qryMainSaleType: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainInvoice: TFloatField;
    qryMainDetails: TLargeintField;
    qryMainSalesCount: TLargeintField;
    qryMainTrafficCount: TLargeintField;
    qryMainSaleID: TLargeintField;
    qryMainTotalsAvg: TFloatField;
    qryMainSalesPerPerson: TFloatField;
    cboClassQry: TERPQuery;
    pnlDept: TDnmPanel;
    lblClassTitle: TLabel;
    cboClass: TwwDBLookupCombo;
    lblAllclass: TLabel;
    chkAllClass: TwwCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure DateChange(var Message: TMessage); message SX_DatechangeMsg;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure cboClassChange(Sender: TObject);
    procedure chkAllClassClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
    ReportSQL: TReportSQLTillSummary;
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    function GetReportTypeID: integer; override;
    function DoEmailIfToBeEmailed: boolean; override;
  public
    { Public declarations }
  end;

var
  TillSummaryReportGUI: TTillSummaryReportGUI;

implementation

uses
  FastFuncs,CommonDbLib, CommonLib, MySQLConst, AppEnvironment,
  TempTableUtils;

{$R *.dfm}

procedure TTillSummaryReportGUI.cboClassChange(Sender: TObject);
begin
  inherited;
  if sender = cboClass then begin
    chkAllClass.Checked := cboClass.Text = '';
    RefreshQuery;
  end;
end;

procedure TTillSummaryReportGUI.chkAllClassClick(Sender: TObject);
begin
  inherited;
  if sender = chkAllClass then
    RefreshQuery;
end;

procedure TTillSummaryReportGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    ReportSQLSupplied   := true;
    UseStringListForSQL := False;
    try
      TemplateSQL :=  ReportSQL.TemplateSQL;
      inherited;
    finally
      ReportSQLSupplied   := false;
      UseStringListForSQL := false;
    end;
  finally
    EnableForm;
  end;
end;

procedure TTillSummaryReportGUI.RefreshQuery;
begin
  ReportSQL.ClassId := 0;
  if not chkAllClass.Checked then begin
    if cboClassQry.Locate('classname', cboClass.Text , []) then
      ReportSQL.ClassId :=  cboClassQry.FieldByName('ClassId').AsInteger;
  end;
  if chkIgnoreDates.Checked then begin
    ReportSQL.Datefrom := 0;
    ReportSQL.DateTo := MaxDateTime;
  end
  else begin
    ReportSQL.Datefrom := dtFrom.DateTime;;
    ReportSQL.DateTo := dtTo.DateTime;
  end;
  ReportSQL.Prepareforreport;

  if chkIgnoreDates.Checked then begin
    qryMain.Params.ParamByName('txtfrom').AsDate := 0;
    qryMain.Params.ParamByName('txtto').AsDate := MaxDateTime;
    qryMain.Params.ParamByName('txtfrom1').AsDate := 0;
    qryMain.Params.ParamByName('txtto1').AsDate := MaxDAteTime;
  end
  else begin
    qryMain.Params.ParamByName('txtfrom').AsDate := dtFrom.DateTime;
    qryMain.Params.ParamByName('txtto').AsDate := dtTo.DateTime;
    qryMain.Params.ParamByName('txtfrom1').AsDate := dtFrom.DateTime;
    qryMain.Params.ParamByName('txtto1').AsDate := dtTo.DateTime;
  end;
  inherited;
  RefreshTotals;
end;

procedure TTillSummaryReportGUI.RefreshTotals;
var
  Cash: double;
  EFTPOS: double;
  DebitCard: double;
  Cheque: double;
  DinersClub: double;
  MasterCard: double;
  VISA: double;
  Amex: double;
  AmericanExpress: double;
  BankCard: double;
  CreditCard: double;
  DirectDebt: double;
  DirectDeposit: double;
  MoneyOrder: double;
  Layby: double;
  Voucher: double;
  VoucherReversal: double;
  Invoice: double;
  Totals: double;
begin
  Cash := 0.00;
  EFTPOS := 0.00;
  DebitCard := 0.00;
  Cheque := 0.00;
  DinersClub := 0.00;
  MasterCard := 0.00;
  VISA := 0.00;
  Amex := 0.00;
  AmericanExpress := 0.00;
  BankCard := 0.00;
  CreditCard := 0.00;
  DirectDebt := 0.00;
  DirectDeposit := 0.00;
  MoneyOrder := 0.00;
  Layby := 0.00;
  Voucher := 0.00;
  VoucherReversal := 0.00;
  Invoice := 0.00;
  Totals := 0.00;
  qryMain.DisableControls;
  with qryMain do begin
    First;
    while not Eof do begin
      if Empty(qryMainSaleDate.AsString) then begin
        Cash := Cash + qryMain.FieldByName('Cash').asCurrency;
        EFTPOS := EFTPOS + qryMain.FieldByName('EFTPOS').asCurrency;
        DebitCard := DebitCard + qryMain.FieldByName('DebitCard').asCurrency;
        Cheque := Cheque + qryMain.FieldByName('Cheque').asCurrency;
        DinersClub := DinersClub + qryMain.FieldByName('DinersClub').asCurrency;
        MasterCard := MasterCard + qryMain.FieldByName('MasterCard').asCurrency;
        VISA := VISA + qryMain.FieldByName('VISA').asCurrency;
        Amex := Amex + qryMain.FieldByName('Amex').asCurrency;
        AmericanExpress := AmericanExpress + qryMain.FieldByName('AmericanExpress').asCurrency;
        BankCard := BankCard + qryMain.FieldByName('BankCard').asCurrency;
        CreditCard := CreditCard + qryMain.FieldByName('CreditCard').asCurrency;
        DirectDebt := DirectDebt + qryMain.FieldByName('DirectDebt').asCurrency;
        DirectDeposit := DirectDeposit + qryMain.FieldByName('DirectDeposit').asCurrency;
        MoneyOrder := MoneyOrder + qryMain.FieldByName('MoneyOrder').asCurrency;
        Layby := Layby + qryMain.FieldByName('Layby').asCurrency;
        Voucher := Voucher + qryMain.FieldByName('Voucher').asCurrency;
        VoucherReversal := VoucherReversal + qryMain.FieldByName('VoucherReversal').asCurrency;
        Invoice := Invoice + +qryMain.FieldByName('Invoice').asCurrency;
        Totals := Totals + +qryMain.FieldByName('Total').asCurrency;
      end;
      Next;
    end;
  end;
  qryMain.EnableControls;
  qryMain.First;
  grdMain.ColumnByName('Cash').FooterValue := FloatToStrF(Cash, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('EFTPOS').FooterValue := FloatToStrF(EFTPOS, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('DebitCard').FooterValue := FloatToStrF(DebitCard, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Cheque').FooterValue := FloatToStrF(Cheque, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('DinersClub').FooterValue := FloatToStrF(DinersClub, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('MasterCard').FooterValue := FloatToStrF(MasterCard, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('VISA').FooterValue := FloatToStrF(VISA, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Amex').FooterValue := FloatToStrF(Amex, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('AmericanExpress').FooterValue := FloatToStrF(AmericanExpress, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('BankCard').FooterValue := FloatToStrF(BankCard, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CreditCard').FooterValue := FloatToStrF(CreditCard, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('DirectDebt').FooterValue := FloatToStrF(DirectDebt, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('DirectDeposit').FooterValue := FloatToStrF(DirectDeposit, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('MoneyOrder').FooterValue := FloatToStrF(MoneyOrder, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Layby').FooterValue := FloatToStrF(Layby, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Voucher').FooterValue := FloatToStrF(Voucher, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('VoucherReversal').FooterValue := FloatToStrF(VoucherReversal, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Invoice').FooterValue := FloatToStrF(Invoice, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Total').FooterValue := FloatToStrF(Totals, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TTillSummaryReportGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  TillSummaryReportGUI := nil;
end;

procedure TTillSummaryReportGUI.FormCreate(Sender: TObject);
begin
  ReportSQL := TReportSQLTillSummary.Create(self);

  qryMain.SQL.Text := ReplaceStr(qryMain.SQL.Text, 'aaaaa', ReportSQL.Temptablename);
  inherited;
end;

procedure TTillSummaryReportGUI.FormShow(Sender: TObject);
begin
  inherited;
  if not ErrorOccurred then begin
    RefreshQuery;
  end;
  if cboClassQry.Active = False then begin
    cboClassQry.Connection := Qrymain.Connection;
    cboClassQry.Open;
  end;
  if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnCanViewTillsummaryOfAllDepartments') = 1 then begin
    cboClass.Enabled := True;
    chkAllClass.Enabled := True;
    lblClassTitle.font.Color  := clblack;
    cboClass.font.Color       := clblack;
    lblAllclass.font.Color    := clblack;
    chkAllClass.font.Color    := clblack;
    pnlDept.Hint := 'Select A ' + appenv.DefaultClass.ClassHeading+' or ''All'' to see the Till summary for';
  end else begin
    cboClass.Enabled := False;
    chkAllClass.Enabled := False;
    cboClassQry.Locate('ClassID' , AppEnv.DefaultClass.ClassID, []);
    cboClass.Text :=cboClassQry.fieldbyname('classname').asString;
    chkAllClass.Checked:= False;
    lblClassTitle.font.Color  := clInactiveCaption;
    cboClass.font.Color       := clInactiveCaption;
    lblAllclass.font.Color    := clInactiveCaption;
    chkAllClass.font.Color    := clInactiveCaption;
    pnlDept.Hint := 'You don''t have access to view the Till summary of any other  ' + appenv.DefaultClass.ClassHeading;
  end;
  pnlDept.showhint := True;
end;

function TTillSummaryReportGUI.GetReportTypeID: integer;
begin
  result := 138;
end;

procedure TTillSummaryReportGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin {Summary}
        GroupFilterString := '(Details = 0)';
      end;
  end;
  inherited;
end;

procedure TTillSummaryReportGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainSalesPerPerson.AsFloat:= CommonLib.Round(CommonLib.DivZer(qryMainSalesCount.AsFloat,qryMainTrafficCount.AsFloat),2);
end;

procedure TTillSummaryReportGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if Empty(qryMainSaleDate.AsString) then begin
    AFont.Style := AFont.Style + [fsBold];
  end;
end;

procedure TTillSummaryReportGUI.DateChange(var Message: TMessage);
begin
  if not (dtTo.DroppedDown or dtFrom.DroppedDown) then begin
    RefreshQuery;
  end;
end;

function TTillSummaryReportGUI.DoEmailIfToBeEmailed: boolean;
begin
  TemplateSQL :=  ReportSQL.TemplateSQL;
  ReportSQLSupplied   := true;
  result := inherited;
end;

procedure TTillSummaryReportGUI.grdMainDblClick(Sender: TObject);
begin
  if (qryMainSaleID.AsInteger <> 0) then begin
  (*
    If Sysutils.SameText(qryMainSaleType.asString,'Invoice') then Begin
      SubsequentID := Chr(95) + 'Invoice'
    end else
      SubsequentID := Chr(95) + 'Cash Sale';
  *)
    If Sysutils.SameText(qryMainSaleType.asString,'Till') then Begin
      SubsequentID := Chr(95) + 'Cash Sale'
    end else  // Invoice and Acc Payment
      SubsequentID := Chr(95) + 'Invoice';
    inherited;
  end;
end;

initialization
  RegisterClassOnce(TTillSummaryReportGUI);
end.
