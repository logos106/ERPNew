unit TaxSummaryReportForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,   Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, MyAccess,ERPdbComponents, DBAccess, MemDS,
  wwdbdatetimepicker, DnmLib, wwdblook, wwcheckbox,
  ProgressDialog,  Shader, kbmMemTable, DAScript, MyScript, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg, TaxSummaryReportSQL;

const
  SX_DatechangeMsg = WM_USER + 116;

type
  TTaxSummaryReportGUI = class(TBaseListingGUI)
    btnRefresh: TDNMSpeedButton;
    qryMainID: TAutoIncField;
    qryMainTaxCode: TWideStringField;
    qryMainINPUT_AmountEx: TFloatField;
    qryMainINPUT_AmountInc: TFloatField;
    qryMainOUTPUT_AmountEx: TFloatField;
    qryMainOUTPUT_AmountInc: TFloatField;
    qryMainTotalNet: TFloatField;
    qryMaintotalTax: TFloatField;
    qryMaintotalTax1: TFloatField;
    qryMainTaxRate: TFloatField;
    chkShowNT: TCheckBox;
    procedure cmdPrintClick(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure DateChange(var Message: TMessage); message SX_DatechangeMsg;
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure FormDestroy(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);

  private
    { Private declarations }
    TaxSummaryReport: TTaxSummaryReport;
    BasisMode: TBASBasisMode;
    procedure ValidateTax;



  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    function GetReportTypeID: integer; override;
  public

    { Public declarations }
  end;


implementation

uses
  CommonDbLib, CommonLib,  TransAccountDetailsForm, CashBasis, CashBasisDetails,
  AppEnvironment, FastFuncs, MySQLConst, LogLib, tcConst;

{$R *.dfm}

procedure TTaxSummaryReportGUI.RefreshQuery;
var
  msg: string;
begin
  ProcessingCursor(True);
  try

    (*if chkIgnoreDates.Checked then begin
      TaxSummaryReport.DateFrom := MinDateTime;
      TaxSummaryReport.DateTo := MaxDateTime;
    end
    else begin
      TaxSummaryReport.DateFrom := FilterDateFrom;
      TaxSummaryReport.DateTo := FilterDateTo;
    end;*)

    TaxSummaryReport.DateFrom := FilterDateFrom;
    TaxSummaryReport.DateTo := FilterDateTo;

    case grpFilters.ItemIndex of
      0: TaxSummaryReport.AccountingMethod := 'Accrual';
      1: TaxSummaryReport.AccountingMethod := 'Cash';
      else TaxSummaryReport.AccountingMethod := 'Accrual';
    end;

    TaxSummaryReport.DepartmentID := SelectedclassID;
    TaxSummaryReport.ShowNT := chkShowNT.Checked;

    TaxSummaryReport.PopulateReportSQL(qryMain.SQL,msg);
    self.RefreshOrignalSQL();

    inherited;
    grdMain.columnbyName('INPUT_AmountEx').DisplayLabel   := 'INPUTS Ex (Purchases)';
    grdMain.columnbyName('INPUT_AmountInc').DisplayLabel  := 'INPUTS Inc (Purchases)';
    grdMain.columnbyName('OUTPUT_AmountEx').DisplayLabel  := 'OUTPUTS Ex  (Sales)';
    grdMain.columnbyName('OUTPUT_AmountInc').DisplayLabel := 'OUTPUTS Inc (Sales)';
    grdMain.columnbyName('TotalNet').DisplayLabel         := 'Total Net';
    grdMain.columnbyName('totalTax').DisplayLabel         := 'Total Tax';
    RefreshTotals;
  finally
    ProcessingCursor(False);
  end;
end;

procedure TTaxSummaryReportGUI.RefreshTotals;
var
  TotalNet, totalTax, totalTax1: double;
begin
  qryMain.DisableControls;
  try
    totalTax := 0;
    totalTax1 := 0;
    TotalNet := 0;
    with qryMain do begin
      First;
      while not Eof do begin
        totalTax := totalTax + qryMaintotalTax.AsCurrency;
        totalTax1 := totalTax1 + qryMaintotalTax1.AsCurrency;
        TotalNet := TotalNet + qryMainTotalNet.AsCurrency;
        Next;
      end;
    end;
    grdMain.ColumnByName('totalTax').FooterValue := FloatToStrF(totalTax, ffCurrency, 15, CurrencyRoundPlaces);
    grdMain.ColumnByName('totalTax1').FooterValue := FloatToStrF(totalTax1, ffCurrency, 15, CurrencyRoundPlaces);
    grdMain.ColumnByName('TotalNet').FooterValue := FloatToStrF(TotalNet, ffCurrency, 15, CurrencyRoundPlaces);
  finally
    qryMain.EnableControls;
  end;
end;

procedure TTaxSummaryReportGUI.cmdPrintClick(Sender: TObject);
begin
  ReportSQLSupplied := true;
  TemplateSQL :=
    'SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State,' +
    'CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN , ' +
    '"' + FormatDateTime('dd/mm/yyyy', FilterDateFrom) + '" as DateFrom,"' +
    FormatDateTime('dd/mm/yyyy', FilterDateTo) + '" as DateTo ,' +
    'ID, TaxCode,TaxRate,SUM(INPUT_AmountEx) as INPUT_AmountEx,SUM(INPUT_AmountInc) as INPUT_AmountInc,' +
    'SUM(OUTPUT_AmountEx) as OUTPUT_AmountEx, SUM(OUTPUT_AmountInc) as OUTPUT_AmountInc,SUM(TotalNet) as TotalNet, SUM(totalTax) as totalTax ' +
    'FROM tblCompanyInformation AS CO, ' + TaxSummaryReport.TempTableName + ' group by TaxCode;';
  inherited;
  ReportSQLSupplied := false;
  TemplateSQL := '';
end;

function TTaxSummaryReportGUI.GetReportTypeID: integer;
begin
  Result := 42;
end;

procedure TTaxSummaryReportGUI.grpFiltersClick(Sender: TObject);
begin
  inherited;
  case grpFilters.ItemIndex of
    0:
      begin {Accrual}
        BasisMode := Accrual_Basis;
      end;
    1:
      begin  {Cash}
        BasisMode := Cash_Basis;
      end;
  end;
  RefreshQuery;
end;


procedure TTaxSummaryReportGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  ValidateTax;
end;

procedure TTaxSummaryReportGUI.FormCreate(Sender: TObject);
begin
  inherited;
  TaxSummaryReport := TTaxSummaryReport.Create;
  TaxSummaryReport.ReportGuiForm := self;
  SelectionOption := soClass;
  ShowChartViewOnPopup := True;
end;

procedure TTaxSummaryReportGUI.DateChange(var Message: TMessage);
begin
  if not (dtTo.DroppedDown or dtFrom.DroppedDown) then begin
    RefreshQuery;
  end;
end;

procedure TTaxSummaryReportGUI.ValidateTax;
var
  frm : TTransAccountDetailsGUI;
begin
if devmode then begin
  if  not FormStillOpen('TTransAccountDetailsGUI') then
     grdMainDblClick(grdmain);

  if  FormStillOpen('TTransAccountDetailsGUI') then begin
    frm := TTransAccountDetailsGUI(GetComponentByClassName('TTransAccountDetailsGUI')) ;
      frm.dtFrom.date:= 0;
      frm.dtto.date:= Self.dtto.date;
      frm.dtFrom.date:= Self.dtFrom.date;
      frm.RefreshQuery;
    end;
end;
end;

procedure TTaxSummaryReportGUI.grdMainDblClick(Sender: TObject);
var
  sType, sTaxCode: string;
  frmCashBasisDetails: TComponent;
  frmTransAccountDetails: TComponent;
begin
  if BasisMode = Cash_Basis then begin
    if Empty(TwwDBGrid(Sender).GetActiveField.AsString) then Exit;

    if FormStillOpen('TCashBasisDetailsGUI') then TForm(FindExistingComponent('TCashBasisDetailsGUI')).Close;
    if not FormStillOpen('TCashBasisDetailsGUI') then begin
      frmCashBasisDetails := GetComponentByClassName('TCashBasisDetailsGUI',True,Self);
      if Assigned(frmCashBasisDetails) then begin
        with TCashBasisDetailsGUI(frmCashBasisDetails) do begin
          ToDate := self.FilterDateTo;
          FromDate := self.FilterDateFrom;

          sTaxCode := Trim(Self.qryMain.FieldByName('Taxcode').AsString);

          if (FastFuncs.PosEx('OUTPUT', TwwDBGrid(Sender).GetActiveField.Name) <> 0) then begin
            sType := 'OUTPUT';
          end else if (FastFuncs.PosEx('INPUT', TwwDBGrid(Sender).GetActiveField.Name) <> 0) then begin
            sType := 'INPUT';
          end else sType := '';

          if (not Empty(sTaxCode)) and (not Empty(sType)) then begin
            WhereString := '(TaxCode = ' + QuotedStr(sTaxCode) + ' AND TaxType=' + QuotedStr(sType) + ');';
          end else begin
            Close;
            Exit;
          end;
          FormStyle := fsmdiChild;
        end;
      end;
    end else begin
      TCashBasisDetailsGUI(FindExistingComponent('TCashBasisDetailsGUI')).Show;
    end;
    Exit;
  end;
  //######## Open Listing #####################
  if FormStillOpen('TTransAccountDetailsGUI') then TForm(FindExistingComponent('TTransAccountDetailsGUI')).Close;
  if not FormStillOpen('TTransAccountDetailsGUI') then begin
    frmTransAccountDetails := GetComponentByClassName('TTransAccountDetailsGUI');
    if Assigned(frmTransAccountDetails) then begin
      with  TTransAccountDetailsGUI(frmTransAccountDetails) do begin
        ToDate := self.FilterDateTo;
        FromDate := self.FilterDateFrom;
        fbDateRangeSupplied := true;
        case grpFilters.ItemIndex of
          0:
            begin {Accrual}
              qryMain.SQL.Text := ReplaceStr(qryMain.SQL.Text, 'CASH_DebitsEx', 'DebitsEx');
              qryMain.SQL.Text := ReplaceStr(qryMain.SQL.Text, 'CASH_CreditsEx', 'CreditsEx');
              qryMain.SQL.Text := ReplaceStr(qryMain.SQL.Text, 'CASH_DebitsInc', 'DebitsInc');
              qryMain.SQL.Text := ReplaceStr(qryMain.SQL.Text, 'CASH_CreditsInc', 'CreditsInc');
            end;
          1:
            begin  {Cash}
              qryMain.SQL.Text := ReplaceStr(qryMain.SQL.Text, 'DebitsEx', 'CASH_DebitsEx');
              qryMain.SQL.Text := ReplaceStr(qryMain.SQL.Text, 'CreditsEx', 'CASH_CreditsEx');
              qryMain.SQL.Text := ReplaceStr(qryMain.SQL.Text, 'DebitsInc', 'CASH_DebitsInc');
              qryMain.SQL.Text := ReplaceStr(qryMain.SQL.Text, 'CreditsInc', 'CASH_CreditsInc');
            end;
        end;
        qryMain.SQL.Add('AND (AccountName<>"Tax Paid" AND AccountName<>"Tax Collected") AND TaxCode = ' +
          QuotedStr(self.qryMainTaxCode.AsString) + ' Group by TransID;');
        WhereString := 'AND (AccountName<>"Tax Paid" AND AccountName<>"Tax Collected") AND ( TaxCode = ' + QuotedStr(self.qryMainTaxCode.AsString) + ' )';
        FormStyle := fsmdiChild;
      end;
    end;
  end else begin
    frmTransAccountDetails := FindExistingComponent('TTransAccountDetailsGUI');
    TForm(frmTransAccountDetails).Show;
  end;
end;

procedure TTaxSummaryReportGUI.FormDestroy(Sender: TObject);
begin
  TaxSummaryReport.Free;
  CashBasis.RemoveTempTable('TaxSummary');
  inherited;
end;

initialization
  RegisterClassOnce(TTaxSummaryReportGUI);
end.
