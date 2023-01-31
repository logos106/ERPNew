unit frmCashSale;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CashSaleBase, ProgressDialog, ImgList, DB, Menus, AdvMenus,
  DNMAction, ActnList, DataState, DBAccess, MyAccess, ERPdbComponents,
  SelectionDialog, AppEvnts, MemDS, ExtCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, ERPDbLookupCombo, Shader, wwdbedit, StdCtrls, wwdblook,
  wwdbdatetimepicker, DBCtrls, DNMSpeedButton, Mask, DNMPanel, BusobjCash;

type
  TCashSaleGUI = class(TCashSaleBaseGUI)
    tblDetailsProduct_Description_Memo: TWideMemoField;
    btnSignature: TDNMSpeedButton;
    actSignature: TAction;
    tblMasterClientSignature: TBlobField;
    tblMasterSignatureTime: TDateTimeField;
    procedure FormShow(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actSignatureExecute(Sender: TObject);
    procedure actSignatureUpdate(Sender: TObject);
  private
    function SendPrintSMS: boolean;
    function SendPrintSMSSilent: boolean;
    function SendPrintEmail: boolean;
    function SendPrintEmailSilent: boolean;
  Protected
    procedure NewTransBusObjinstance;override;
  public
    CashSale: TCashSale;
    { Public declarations }
  end;


implementation

uses FormFactory, CommonLib, frmReportingOptions, AppEnvironment,
  EmailUtils, SMSUtils, CorrespondenceObj, frmSignatureEdit;

{$R *.dfm}
procedure TCashSaleGUI.actSignatureExecute(Sender: TObject);
begin
  if frmSignatureEdit.GetClientSignature(self.tblMasterClientSignature, self.tblMasterSignatureTime) then
    self.CashSale.Dirty := true;
end;

procedure TCashSaleGUI.actSignatureUpdate(Sender: TObject);
begin
  if self.tblMasterClientSignature.BlobSize > 0 then
    btnSignature.Color := $0077ff77
  else
    btnSignature.Color := clBtnFace;
end;

procedure TCashSaleGUI.btnPrintClick(Sender: TObject);
var
  OptsForm: TfmReportingOptions;
  IsEnabled: boolean;
begin
  if not(SaveCashSale) then exit;
  Self.CommitAndNotify;
  OptsForm := EmailOptsForm;//TfmReportingOptions.Create(nil);
  try
    OptsForm.ActionList.AddDivider('Print');
    OptsForm.ActionList.Add('Print' ,'Print a Cash Sale',actPrintExecute, true, true);
    OptsForm.ActionList.Add('Preview', 'Preview a Cash Sale', self.actPreviewExecute, true, true);
    OptsForm.ActionList.Add('Picking', 'Print a Picking Slip',self.actPickExecute, false, true);
    OptsForm.ActionList.Add('Save PDF','Save a PDF Cash Sale to your computer', SaveTransToPDF, true, true);

    OptsForm.ActionList.AddDivider('Email');
    if AppEnv.CompanyPrefs.EnableCashSalePrintEmail and ((CashSale.ContactEmail <> '') or (CashSale.Customer.Email <> '')) then begin
      OptsForm.ActionList.Add('Email Msg', 'Just send an email message, without Cash Sale', self.SendPrintEmailSilent, true, true);
    end
    else begin
      OptsForm.ActionList.Add('Email Msg', 'Just send an email message, without Cash Sale', self.SendPrintEmailSilent, true, false);
    end;
    OptsForm.ActionList.Add('Email Cash Sale', 'Email a copy of the CashSale', DoEmailTransaction, true, true);
    OptsForm.ActionList.Add('Email Msg (Edit)', 'Edit email message before sending, without Cash Sale', self.SendPrintEmail, true, true);

    OptsForm.ActionList.AddDivider('SMS');
    IsEnabled := AppEnv.CompanyPrefs.SMSEnabled and
       AppEnv.CompanyPrefs.EnableCashSalePrintSMS and
       ((CashSale.ContactMobile <> '') or (CashSale.Customer.Email <> ''));
    OptsForm.ActionList.Add('SMS', 'Just send SMS', self.SendPrintSMSSilent, true, IsEnabled);
    OptsForm.ActionList.Add('SMS (Edit)', 'Edit SMS before sending', self.SendPrintSMS, true, AppEnv.CompanyPrefs.SMSEnabled);

    OptsForm.ShowModal;
    CloseAfterPrint(OptsForm.CloseWhenDone);
  finally
    OptsForm.Free;
  end;
end;

procedure TCashSaleGUI.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := True;
  inherited;

end;

procedure TCashSaleGUI.FormShow(Sender: TObject);
begin
  inherited;
  if not btnAddDate.Visible  then
  begin
    btnSignature.Top := btnAddDate.Top;
  end;
  HideProgressBar;
  ShowGridLockMsg;
end;

procedure TCashSaleGUI.NewTransBusObjinstance;
begin
  Freeandnil(CashSale);
  CashSale := TCashsale.Create(Self);
  CashSale.Name:= 'CashSale';
  CashBase := CashSale;
  inherited;
end;


function TCashSaleGUI.SendPrintEmail: boolean;
var
  recip: string;
begin

  recip := CashSale.ContactEmail;
  if recip = '' then
    recip := CashSale.Customer.Email;
  result := TCorrespondenceGui.EmailCustomer(recip,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.CashSalePrintEmailSubject, PopulateMessageSubstituteList),
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.CashSalePrintEmailText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger);

end;

function TCashSaleGUI.SendPrintEmailSilent: boolean;
var
  toEmail: string;
begin
  toEmail := CashSale.ContactEmail;
  if toEmail = '' then
    toEmail := CashSale.Customer.Email;

  result := TCorrespondenceGui.EmailCustomer(toEmail,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.CashSalePrintEmailSubject, PopulateMessageSubstituteList),
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.CashSalePrintEmailText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger,true);
end;

function TCashSaleGUI.SendPrintSMS: boolean;
var
  number: string;
begin
  result := false;
  number := GetOrAddMobileNumber;
  if number = '' then exit;

  result := TCorrespondenceGui.SMSCustomer(number,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.CashSalePrintSMSText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger);

end;

function TCashSaleGUI.SendPrintSMSSilent: boolean;
var
  toMobile: string;
begin
  toMobile := CashSale.ContactMobile;
  if toMobile = '' then
    toMobile := CashSale.Customer.Mobile;

  result := TCorrespondenceGui.SMSCustomer(toMobile,
    TMailUtils.SubstituteText(AppEnv.CompanyPrefs.CashSalePrintSMSText, PopulateMessageSubstituteList),
    self.tblMasterClientID.AsInteger, true);
end;

initialization
  RegisterClassOnce(TCashSaleGUI);
  with FormFact do begin
    RegisterMe(TCashSaleGUI, 'TInvoiceListGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TInvoicelistExpressGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TNonERPSalesListGUI_*_Cash Sale=ERPTransId');
    RegisterMe(TCashSaleGUI, 'TSalesToRefundListGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TSalesDashboardPnLdetailsGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TSalesDashBoardTopTenSalesManDetailsGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TSalesDashBoardTopTenProductsDetailsGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TSalesDashBoardTopTenCustomersDetailsGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TPickSlipGUI*_CashSale=SaleID');
    RegisterMe(TCashSaleGUI, 'TPickSlipManifestGUI*_CashSale=SaleID');
    RegisterMe(TCashSaleGUI, 'TSalesReportGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TSalesReportSaleslinescustomFieldListGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TSalesReportCustomercustomFieldListGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TSalesReportProductcustomFieldListGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TWeeklySalesreportGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TProductSalesReportGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TProductSalesReportGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TSalesListwithCommisionGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TSalesListReportGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TSalesListOutstandingGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TStatementListGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TStatementListGUI_*_Cash Sale Payment=SaleID');
    RegisterMe(TCashSaleGUI, 'TMemTransListGUI_*_TCashSaleGUI=TransID');
    RegisterMe(TCashSaleGUI, 'TVoucherListGUI_DateRedeemed=Inv No');
    RegisterMe(TCashSaleGUI, 'TVoucherListGUI_RedeemedSaleID=Inv No');
    RegisterMe(TCashSaleGUI, 'TVoucherListGUI_Inv No=Inv No');
    RegisterMe(TCashSaleGUI, 'TBalTransListGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TInventoryAssetVsStockStautsGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TTrialBalTransListGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TTransactionListGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TBASTransReturnListGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TNZTransReturnListGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TVATTransReturnListGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TGlobalsearchGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TTransAccountDetailsGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TCustomerSummaryListingGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TEmployeeReportGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TJobProfitabilityGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TJobProfitabilityforCustomerGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TRepairProfitabilityGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TGeneralLedgerReportGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TfrmDeletedInvoicesListGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TCashBasisDetailsGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TDeliveryDocketListGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TPickingSlipListGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TSoldProductsReport_*_CashSale=SaleID');
    RegisterMe(TCashSaleGUI, 'TSalescommissionListGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TCustomerSalesOnProductListGUI_*_CashSale=SaleID');
    RegisterMe(TCashSaleGUI, 'TCashSaleDepositGUI_*_CashSale=SaleID');
    RegisterMe(TCashSaleGUI, 'TRewardPointsGUI_*_CashSale=SaleID');
    RegisterMe(TCashSaleGUI, 'TRewardPointsDetailsGUI_*_CashSale=SaleID');
    RegisterMe(TCashSaleGUI, 'TRewardPointsDueToExpireGUI_*_CashSale=SaleID');
    RegisterMe(TCashSaleGUI, 'TsalesOrderConvertedsalesListGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TQuoteConvertedSalesListGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TMemTransListGUI_*_Cash Sale=TransID');
    RegisterMe(TCashSaleGUI, 'TTransactionswith0QtyGUI_*_Cash Sale=TrasnsId');
    RegisterMe(TCashSaleGUI, 'TSalesTotalAmountMisMatchGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TNumberSequenceListGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'THourlySalesReportGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TsalesreportDetailsGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TPnLEmployeereportGUI_*_Cash Sale=TransID');
    RegisterMe(TCashSaleGUI, 'TSalesTaxReportGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TRefundSalesListGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'TInvoicesPrnGUI_*_Cash Sale=SaleID');
    RegisterMe(TCashSaleGUI, 'THireSalesListGUI_*_Cash Sale=SaleID');
    //RegisterMe(TCashSaleGUI, 'TSalesAnalysisGraphDrilldownSalesGUI_*_Cash Sale=SaleID');
  end;
end.

