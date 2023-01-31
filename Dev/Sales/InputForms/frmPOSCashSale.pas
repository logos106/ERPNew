unit frmPOSCashSale;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmCashSale, ProgressDialog, ImgList, DB, DNMAction, ActnList, Menus,
  AdvMenus, DataState, DBAccess, MyAccess, ERPdbComponents, SelectionDialog,
  AppEvnts, MemDS, ExtCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  ERPDbLookupCombo, Shader, wwdbedit, StdCtrls, wwdblook, wwdbdatetimepicker,
  DBCtrls, DNMSpeedButton, Mask, DNMPanel,CashSaleBase;

type
  TPOSCashSaleGUI = class(TCashSaleBaseGUI)
    actPrintvoucher: TDNMAction;
    btnPrintvoucher: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure grdTransactionsEnter(Sender: TObject);
    procedure grdTransactionsRowChanged(Sender: TObject);
//    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actPrintvoucherUpdate(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
  private
    function SendPrintSMS: boolean;
    function SendPrintSMSSilent: boolean;
    function SendPrintEmail: boolean;
    function SendPrintEmailSilent: boolean;
  Protected
    procedure NewTransBusObjinstance;override;

  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses
  FormFactory, BusObjPOSSale, BusObjCash , AppEnvironment, frmReportingOptions,
  EmailUtils, SMSUtils, CorrespondenceObj;

procedure TPOSCashSaleGUI.actPrintvoucherUpdate(Sender: TObject);
begin
  inherited;
  actPrintVoucher.Enabled := CashBase.hasAnyvoucher;
end;

procedure TPOSCashSaleGUI.btnPrintClick(Sender: TObject);
var
  OptsForm: TfmReportingOptions;
  IsEnabled: boolean;
begin
  OptsForm := EmailOptsForm;//TfmReportingOptions.Create(nil);
  try
    OptsForm.ActionList.AddDivider('Print');
    OptsForm.ActionList.Add('Print' ,'Print a POS Cash Sale',actPrintExecute, true, true);
    OptsForm.ActionList.Add('Preview', 'Preview a POS Cash Sale', self.actPreviewExecute, true, true);
    OptsForm.ActionList.Add('Picking', 'Print a Picking Slip',self.actPickExecute, false, true);
    OptsForm.ActionList.Add('Save PDF','Save a PDF POS Cash Sale to your computer', SaveTransToPDF, true, true);

    OptsForm.ActionList.AddDivider('Email');
    if AppEnv.CompanyPrefs.EnablePOSCashSalePrintEmail and ((CashBase.ContactEmail <> '') or (CashBase.Customer.Email <> '')) then begin
      OptsForm.ActionList.Add('Email Msg', 'Just send an email message, without POS Cash Sale', self.SendPrintEmailSilent, true, true);
    end
    else begin
      OptsForm.ActionList.Add('Email Msg', 'Just send an email message, without POS Cash Sale', self.SendPrintEmailSilent, true, false);
    end;
    OptsForm.ActionList.Add('Email Msg (Edit)', 'Edit email message before sending, without POS Cash Sale', self.SendPrintEmail, true, true);

    OptsForm.ActionList.AddDivider('SMS');
    IsEnabled := AppEnv.CompanyPrefs.SMSEnabled and
       AppEnv.CompanyPrefs.EnablePOSCashSalePrintSMS and
       ((CashBase.ContactMobile <> '') or (CashBase.Customer.Email <> ''));
    OptsForm.ActionList.Add('SMS', 'Just send SMS', self.SendPrintSMSSilent, true, IsEnabled);
    OptsForm.ActionList.Add('SMS (Edit)', 'Edit SMS before sending', self.SendPrintSMS, true, AppEnv.CompanyPrefs.SMSEnabled);

    OptsForm.ShowModal;
    CloseAfterPrint(OptsForm.CloseWhenDone);
  finally
    OptsForm.Free;
  end;
end;

function TPOSCashSaleGUI.SendPrintEmail: boolean;
var
  msgTo: string;
begin
  msgTo := CashBase.ContactEmail;
  if msgTo = '' then msgTo := CashBase.Customer.Email;

  result := TCorrespondenceGui.EmailCustomer(msgTo,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POSCashSalePrintEmailSubject, PopulateMessageSubstituteList),
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POSCashSalePrintEmailText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger);
end;

function TPOSCashSaleGUI.SendPrintEmailSilent: boolean;
var
  msgTo: string;
begin
  msgTo := CashBase.ContactEmail;
  if msgTo = '' then msgTo := CashBase.Customer.Email;

  result := TCorrespondenceGui.EmailCustomer(msgTo,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POSCashSalePrintEmailSubject, PopulateMessageSubstituteList),
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POSCashSalePrintEmailText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger, true);
end;

function TPOSCashSaleGUI.SendPrintSMS: boolean;
var
  number: string;
begin
  result := false;
  number := GetOrAddMobileNumber;
  if number = '' then exit;

  result := TCorrespondenceGui.SMSCustomer(number,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POSCashSalePrintSMSText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger);
end;

function TPOSCashSaleGUI.SendPrintSMSSilent: boolean;
var
  toMobile: string;
begin
  toMobile := CashBase.ContactMobile;
  if toMobile = '' then
    toMobile := CashBase.Customer.Mobile;

  result := TCorrespondenceGui.SMSCustomer(toMobile,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.POSCashSalePrintSMSText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger,true);
end;


//procedure TPOSCashSaleGUI.DNMSpeedButton1Click(Sender: TObject);
//var
//  sSQL:String;
//begin
//  inherited;
//        if chkChooseRpt.Checked then begin
//          LoadReportTypes(106);
//          if dlgReportSelect.Execute then begin
//            ReportToPrint := dlgReportSelect.SelectedItems.Text;
//          end;
//        end;
//        sSQL :=  '~|||~ and d2.SaleID = ' + inttostr(Transbase.ID) +
//                  '~|||~ where TTC.' +TRim(Transbase.IDFieldname)+' = ' +inttostr(Transbase.ID) +' group by TTCL.`SubTaxCode`'+
//                  '~|||~ and Trans.' +TRim(Transbase.IDFieldname)+' = ' +inttostr(Transbase.ID);
//        sSQL := sSQL + TransSpecificSQL;
//        fbReportSQLSupplied := False;
//        PrintTemplateReport(ReportToPrint, sSQL, not(Appenv.Employee.ShowPreview), 1 );
//end;

procedure TPOSCashSaleGUI.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := True;
  inherited;

end;

procedure TPOSCashSaleGUI.FormShow(Sender: TObject);
begin
  inherited;
  ShowGridLockMsg;
end;

procedure TPOSCashSaleGUI.grdTransactionsEnter(Sender: TObject);
begin
  inherited;
  //Locksales;
end;

procedure TPOSCashSaleGUI.grdTransactionsRowChanged(Sender: TObject);
begin
  inherited;
  //If (tblDetails.Recordcount<>0) then Locksales;
end;

procedure TPOSCashSaleGUI.NewTransBusObjinstance;
begin
  Freeandnil(CashBase);
  CashBase := TCashSale(TPOSCashSale.Create(self));
  CashBase.Name:= 'CashBase';
  inherited;
end;

initialization
  RegisterClass(TPOSCashSaleGUI);

  with FormFact do begin
    RegisterMe(TPOSCashSaleGUI, 'TInvoiceListGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TInvoiceListGUI_*_POS Layby Payment=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TInvoiceListGUI_*_POS Layby Reverse Transaction=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TInvoicelistExpressGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TNonERPSalesListGUI_*_POS=ERPTransId');
    RegisterMe(TPOSCashSaleGUI, 'TSalesToRefundListGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TSalesDashboardPnLdetailsGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TSalesDashBoardTopTenSalesManDetailsGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TSalesDashBoardTopTenProductsDetailsGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TSalesDashBoardTopTenCustomersDetailsGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TSalesReportGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TSalesReportSaleslinescustomFieldListGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TSalesReportCustomercustomFieldListGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TSalesReportProductcustomFieldListGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TWeeklySalesreportGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TProductSalesReportGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TProductSalesReportGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TSalesListReportGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TSalesListOutstandingGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TGlobalsearchGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TCustomerSummaryListingGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TEmployeeReportGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TJobProfitabilityGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TJobProfitabilityforCustomerGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TJobProfitabilityforCustomerGUI_*_Layby=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TRepairProfitabilityGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TRepairProfitabilityGUI_*_Layby=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TStockStatusRoling_*_POS=TransactionNo');
    RegisterMe(TPOSCashSaleGUI, 'TDeliveryDocketListGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TPickingSlipListGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TAllTransactionGUI_*_POS=TransNo');
    RegisterMe(TPOSCashSaleGUI, 'TSalescommissionListGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TTransactionswith0QtyGUI_*_POS=TrasnsId');
    RegisterMe(TPOSCashSaleGUI, 'TSalesTotalAmountMisMatchGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TNumberSequenceListGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TTransAccountDetailsGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TSalesListwithCommisionGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TBalTransListGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TInventoryAssetVsStockStautsGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TInvoiceListGUI_*_Layby Payment=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TInvoiceListGUI_*_Layby Reverse Transaction=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TInvoicelistExpressGUI_*_Layby Payment=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TSalesToRefundListGUI_*_Layby Payment=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TSalesDashboardPnLdetailsGUI_*_Layby Payment=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TSalesDashBoardTopTenSalesManDetailsGUI_*_Layby Payment=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TSalesDashBoardTopTenProductsDetailsGUI_*_Layby Payment=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TSalesDashBoardTopTenCustomersDetailsGUI_*_Layby Payment=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TInvoicelistExpressGUI_*_Layby Reverse Transaction=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TSalesToRefundListGUI_*_Layby Reverse Transaction=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TSalesDashboardPnLdetailsGUI_*_Layby Reverse Transaction=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TSalesDashBoardTopTenSalesManDetailsGUI_*_Layby Reverse Transaction=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TSalesDashBoardTopTenProductsDetailsGUI_*_Layby Reverse Transaction=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TSalesDashBoardTopTenCustomersDetailsGUI_*_Layby Reverse Transaction=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TTrialBalTransListGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TTransactionListGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TBASTransReturnListGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TNZTransReturnListGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TVATTransReturnListGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TGlobalsearchGUI_*_Cash Sale=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TGeneralLedgerReportGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TTillSummaryReportGUI_*_Cash Sale=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TfrmDeletedInvoicesListGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TCashBasisDetailsGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TSoldProductsReport_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TCustomerSalesOnProductListGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TCashSaleDepositGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TRewardPointsGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TRewardPointsDetailsGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TRewardPointsDueToExpireGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TsalesOrderConvertedsalesListGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TQuoteConvertedSalesListGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TsalesConvertedtoListGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TTransactionswith0QtyGUI_*_POS=TrasnsId');
    RegisterMe(TPOSCashSaleGUI, 'TTransactionswith0QtyGUI_*_Layby=TrasnsId');
    RegisterMe(TPOSCashSaleGUI, 'THourlySalesReportGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TsalesreportDetailsGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TPnLEmployeereportGUI_*_POS=TransID');
    RegisterMe(TPOSCashSaleGUI, 'TSalesTaxReportGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TRefundSalesListGUI_*_POS=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TSalesCollatedByItemGUI_*=SaleID');
    RegisterMe(TPOSCashSaleGUI, 'TLaybyPaymentsGUI_*=SaleId');
  end;
end.
