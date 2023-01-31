{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 24/05/05  1.00.01 BJ  Datamodule to populate the reports in the report selector
                        form. Any new report in the application should be added
                        in Addreports function. Package related reports are added
                        from the package module.
 30/05/05  1.00.02 BJ   Event handler for the updatebatchbtnOnclick from report
                        Selector form. the procedure is defined in the main form
                        of the main application. When the the project is 'build
                        with runtime packages' the report form is in the commonlib
                        package and so mainform cannot be 'USED' in there.
 06/07/05  1.00.03 DSP  Added entry for 'Combined Analysis' in the 'Jobs'
                        section.
 02/11/05  1.00.05 MV   Added Product Movement Report.
 11/11/05  1.00.06 MV   Added Customer Discount Price Report.
 30/03/06               Note: Customised reports are added in frmReportSelectorFrm.
 }
unit datReports;

interface
{$I ERP.inc}

uses
  BaseGUIDatamodule, SysUtils, Classes, frmReportSelectorFrm, ImgList, Controls;

type
  TdmReports = class(TdtmGUI)
    procedure DataModuleCreate(Sender: TObject);
  private
  Protected
    procedure DoAddReports(Const ReportSelector: TfrmReportSelectorGUI); Override;
    procedure GeneralHandler(const Sender: TObject; const Event: string; const Data: Pointer);Override;
  public
  end;

var
  dmReports: TdmReports;

implementation

uses Forms, GlobalEventsObj, CommonLib,
     dmMainGUI,  AppEnvironment, tcConst, tcTypes, frmSalesCommission, DNMLib,
  tcDataUtils;

{$R *.dfm}

procedure TdmReports.DataModuleCreate(Sender: TObject);
begin
  GlobalEvents.RegisterNameHandler(Self, 'TfrmReportSelectorGUI', '', GEVENT_AfterCreate, GeneralHandler);
  GlobalEvents.RegisterNameHandler(Self, 'TfrmReportSelectorGUI', '', GEVENT_ReportUpateBatch, GeneralHandler);
  GlobalEvents.RegisterNameHandler(Self, 'TfrmReportSelectorGUI', '', GEVENT_SalesCommissionUpateBatch, GeneralHandler);
end;

procedure TdmReports.GeneralHandler(const Sender: TObject; const Event: string; const Data: Pointer);
var
  SenderName: string;
begin
  SenderName := '';
  if Sender is TComponent then
    SenderName := TComponent(Sender).Name;

  inherited  GeneralHandler(Sender,Event,Data);

  if (Event = GEVENT_ReportUpateBatch) and (Sendername = 'btnUpdateBatch') then begin
    dtmMainGUI.actAccountsRefreshBatchTransactionExecute(nil);
  end;
  if (Event = GEVENT_SalesCommissionUpateBatch) and (Sendername = 'btnUpdateBatch') then begin
    TfmSalesCommission.Updatesalescommission(0,0,true);
  end;

end;

procedure TdmReports.DoAddReports(Const ReportSelector: TfrmReportSelectorGUI);
var
  strCaption: string;
begin
  if not Assigned(ReportSelector) then Exit;
  with ReportSelector do begin
    // Accounts
    Add(REPORT_GROUP_ACCOUNTS, 'Account Type List', 'TAccountTypesListGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Accounts Payable Report', 'TAccountsPayListGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Accounts Receivable Report', 'TAccountsReceiveListGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Accounts Running Balance', 'TAccountrunningBalanceGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Approval Reminder List', 'TApprovalReminderListGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Audit Trail List', 'TAuditTrailListGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Balance Sheet', 'TBalanceSheetGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Bank Account Report', 'TBankAccountListGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Cash Flow Forecast', 'TfrmCashFlowForecast', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Cash Flow Statement', 'TfrmCashFlowStatement', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Cash Profit and Loss Report', 'TCashProfitandLossGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Combined Companies', 'TSummarySheetsGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Combined Companies Categories', 'TSummarysheetCategoryGUI'{'TfmsummarySheets'}, 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Contractor Payment Summary', 'TContractorPaymentSummaryGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Employee Approval Levels', 'TApprovalLevelListGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'FX Trading List', 'TFxTradingListGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'General Ledger', 'TGeneralLedgerReportGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Income and Expenditure', 'TIncomeandExpenditureGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Intrastat List', 'TfrmIntrastatList', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Job - Profit and Loss', 'TJobProfitansLossGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Number Sequence List', 'TNumberSequenceListGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Profit and Loss', 'TProfitandLossGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Profit and Loss (By ' + Appenv.companyprefs.Areacolumnname +')' , 'TPnLAreaReportGUI',0);
    Add(REPORT_GROUP_ACCOUNTS, 'Profit and Loss (By ' + Appenv.companyprefs.Areacolumnname +' / Employee)' , 'TPnLAreaEmployeeReportGUI',0);
    Add(REPORT_GROUP_ACCOUNTS, 'Profit and Loss (By Employee)' , 'TPnLEmployeeReportGUI',0);
    Add(REPORT_GROUP_ACCOUNTS, 'Profit and Loss (By Period)', 'TProfitandLossByPeriodGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Profit and Loss (Compare)', 'TProfitandLossPeriodCompareGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Profit and Loss (Compare - Previous year)', 'TProfitnLosschartCompareGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Profit and Loss Summary', 'TProfitLossSummaryGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Sales Tax Report', 'TSalesTaxReportGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Statements', 'TStatementListGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Stock Value', 'TStockValue', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Summary Sheet', 'TfrmSummarySheetGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Tax Summary', 'TTaxSummaryReportGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Tax Summary Report (Main Tax)', 'TSubtaxSummaryreport_MainTaxCodeGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Transaction Approval List', 'TApprovalListGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Transaction Journal', 'TTransactionListGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Trial Balance', 'TTrialBalanceGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Unassigned Tax Codes', 'TfrmUnassignedTaxCodeList', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'Unpaid Bills', 'TUnpaidBillGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'VAT Obligation List', 'TVATObligationsGUI', 0);
    Add(REPORT_GROUP_ACCOUNTS, 'VAT Return List', 'TVATReturnListGUI', 0);

    // Appointments
    Add(REPORT_GROUP_APPOINTMENTS, 'Appointments List', 'TAppointmentListGUI', 0);
    Add(REPORT_GROUP_APPOINTMENTS, 'Appointment Report', 'TAppointmentListReportGUI', 0);
    Add(REPORT_GROUP_APPOINTMENTS, 'Customers On Support List', 'TCustomersOnSupportListGUI', 0);
    Add(REPORT_GROUP_APPOINTMENTS, 'Feedback Report', 'TFeedbackListGUI', 0);
    Add(REPORT_GROUP_APPOINTMENTS, 'Global List', 'TGlobalListFrm', 0);
    Add(REPORT_GROUP_APPOINTMENTS, 'Phone Support Log List', 'TPhoneSupportLogListGUI', 0);

    Add(REPORT_GROUP_APPOINTMENTS, 'Source List', 'TSourceListGUI', 0);
    Add(REPORT_GROUP_APPOINTMENTS, 'Support Log List', 'TPhSupportLogListGUI', 0);
    Add(REPORT_GROUP_APPOINTMENTS, 'Support Log KPI List', 'TfmSupportLogKPIList', 0);

    // Banking
    Add(REPORT_GROUP_BANKING, 'Accounts Payable Report', 'TAccountsPayListGUI', 0);
    Add(REPORT_GROUP_BANKING, 'Accounts Receivable Report', 'TAccountsReceiveListGUI', 0);
    Add(REPORT_GROUP_BANKING, 'Balance Sheet', 'TBalanceSheetGUI', 0);
    Add(REPORT_GROUP_BANKING, 'Bank Account Report', 'TBankAccountListGUI', 0);
    Add(REPORT_GROUP_BANKING, 'Bank Transaction List', 'TBankStatementLineListGUI', 0);
    Add(REPORT_GROUP_BANKING, 'Budget List', 'TBudgetGUI', 0);
    Add(REPORT_GROUP_BANKING, 'Cash Flow Forecast', 'TfrmCashFlowForecast', 0);
    Add(REPORT_GROUP_BANKING, 'Cash Flow Statement', 'TfrmCashFlowStatement', 0);
    Add(REPORT_GROUP_BANKING, 'Cheque List', 'TChequeListGUI', 0);
    Add(REPORT_GROUP_BANKING, 'Deposited List', 'TDepositedListGUI', 0);
    Add(REPORT_GROUP_BANKING, 'General Ledger', 'TGeneralLedgerReportGUI', 0);
    Add(REPORT_GROUP_BANKING, 'Profit and Loss', 'TProfitandLossGUI', 0);
    Add(REPORT_GROUP_BANKING, 'Profit and Loss (By Period)', 'TProfitandLossByPeriodGUI', 0);
    Add(REPORT_GROUP_BANKING, 'Profit and Loss Summary', 'TProfitLossSummaryGUI', 0);
    Add(REPORT_GROUP_BANKING, 'Reconciliation List', 'TReconListGUI', 0);
    Add(REPORT_GROUP_BANKING, 'Reconciliation List(Details)', 'TReconListDetailFormGUI', 0);
    Add(REPORT_GROUP_BANKING, 'Statements', 'TStatementListGUI', 0);
    Add(REPORT_GROUP_BANKING, 'Transaction Journal', 'TTransactionListGUI', 0);
    Add(REPORT_GROUP_BANKING, 'To Be Reconciled', 'TToBeReconciledGUI', 0);

    // CRM / Marketing
    if AppEnv.CompanyPrefs.UseCRM then begin
      Add(REPORT_GROUP_CRM, 'Canvasser List', 'TCanvasserListGUI', 0);
      Add(REPORT_GROUP_CRM, 'Feedback Report', 'TFeedbackListGUI', 0);
      Add(REPORT_GROUP_CRM, 'Global List', 'TGlobalListFrm', 0);
      Add(REPORT_GROUP_CRM, 'Marketing Ratio Report', 'TfrmMarketingRatios', 0);
      Add(REPORT_GROUP_CRM, 'Prospect List', 'TfrmOthersList', 0);
      Add(REPORT_GROUP_CRM, 'Phone Contact / Follow Up List', 'TfmFollowUpList', 0);
      Add(REPORT_GROUP_CRM, 'Product Reward Points List', 'TProductRewardPointsGUI', 0);
      Add(REPORT_GROUP_CRM, 'Sales Ratios Report', 'TfrmSalesRatioReport', 0);
      Add(REPORT_GROUP_CRM, 'Source List', 'TSourceListGUI', 0);
    end;

    // Employee
    Add(REPORT_GROUP_EMPLOYEE, 'Action Authorisations Report', 'TfrmActionAuthorisationsList', 0);
    Add(REPORT_GROUP_EMPLOYEE, 'Approval Reminder List', 'TApprovalReminderListGUI', 0);
    Add(REPORT_GROUP_EMPLOYEE, 'Audit Trail List', 'TAuditTrailListGUI', 0);
    Add(REPORT_GROUP_EMPLOYEE, 'Combined Analysis Report', 'TCombinedAnalysisListGUI', 0);
    Add(REPORT_GROUP_EMPLOYEE, 'Commission List', 'TSalescommissionListGUI', 0);
    Add(REPORT_GROUP_EMPLOYEE, 'Employee Analysis', 'TEmployeeAnalysisListGUI', 0);
    Add(REPORT_GROUP_EMPLOYEE, 'Employee Approval Levels', 'TApprovalLevelListGUI', 0);
    Add(REPORT_GROUP_EMPLOYEE, 'Employee Fixed Assets', 'TEmployeesFixedAssetsList', 0);
    Add(REPORT_GROUP_EMPLOYEE, 'Employee List', 'TfrmEmployeeList', 0);
    Add(REPORT_GROUP_EMPLOYEE, 'Employee Summary (By Period)', 'TEmployeeReportByPeriodGUI', 0);
    Add(REPORT_GROUP_EMPLOYEE, 'Employee Summary', 'TEmployeeReportGUI', 0);
    Add(REPORT_GROUP_EMPLOYEE, 'Global List', 'TGlobalListFrm', 0);
    (*Add(REPORT_GROUP_EMPLOYEE, 'Invoice Commission Report', 'TfrmCommissionReportGUI', 0);*)
    Add(REPORT_GROUP_EMPLOYEE, 'Product Commission List', 'TProductCommissionListGUI', 0);
    Add(REPORT_GROUP_EMPLOYEE, 'Rep Ability List', 'TfmRepAbilityList', 0);
    Add(REPORT_GROUP_EMPLOYEE, 'Rep List', 'TRepListGUI', 0);
    Add(REPORT_GROUP_EMPLOYEE, 'Roster History', 'TRosterBreakListGUI', 0);
    Add(REPORT_GROUP_EMPLOYEE, 'Roster List', 'TRosterListGUI', 0);
    Add(REPORT_GROUP_EMPLOYEE, 'Roster Report', 'TrosterReportGUI', 0);
    Add(REPORT_GROUP_EMPLOYEE, 'Sales Commission', 'TSalesListwithCommisionGUI', 0);
    Add(REPORT_GROUP_EMPLOYEE, 'To Do List', 'TToDoListGUI', 0);
    Add(REPORT_GROUP_EMPLOYEE, 'Transaction Approval List', 'TApprovalListGUI', 0);

    // Fixed Assets
    if AppEnv.CompanyPrefs.UseFixedAssets then begin
      Add(REPORT_GROUP_FIXED_ASSETS, 'Asset Register Report', 'TAssetRegisterListGUI', 0);
      Add(REPORT_GROUP_FIXED_ASSETS, 'Fixed Asset Types List', 'TFixedAssetTypeListGUI', 0);
      Add(REPORT_GROUP_FIXED_ASSETS, 'Fixed Assets Details Report', 'TfrmFixedAssetsDetails', 0);
      Add(REPORT_GROUP_FIXED_ASSETS, 'Fixed Assets List', 'TFixedAssetsListGUI', 0);
      Add(REPORT_GROUP_FIXED_ASSETS, 'Fixed Asset Repair List', 'TfmFixedAssetRepairList', 0);
      Add(REPORT_GROUP_FIXED_ASSETS, 'Service Log List', 'TServiceLogListGUI', 0);
      Add(REPORT_GROUP_FIXED_ASSETS, 'Warranty / Insurance Policy Report', 'TCheckWarranty_InsurancePolicyGUI', 0);
    end;

    // General
    Add(REPORT_GROUP_GENERAL, '' + Appenv.companyprefs.Areacolumnname +' Code List', 'TAreacodesGUI', 0);
    Add(REPORT_GROUP_GENERAL, 'Client Main Contacts', 'TClientMainContactsGUI', 0);

    Add(REPORT_GROUP_GENERAL, 'Customisable Fields - All' , 'TCustomFieldValuesAllGUI', 0);
    Add(REPORT_GROUP_GENERAL, 'Customisable Fields - Contacts' , 'TCustomFieldValuesContactGUI', 0);
    Add(REPORT_GROUP_GENERAL, 'Customisable Fields - Customer' , 'TCustomFieldValuesCustomerGUI', 0);
    Add(REPORT_GROUP_GENERAL, 'Customisable Fields - Equipment' , 'TCustomFieldValuesEquipmentGUI', 0);
    Add(REPORT_GROUP_GENERAL, 'Customisable Fields - Products' , 'TCustomFieldValuesProductsGUI', 0);
    Add(REPORT_GROUP_GENERAL, 'Customisable Fields - Leads' , 'TCustomFieldValuesLeadsGUI', 0);
    Add(REPORT_GROUP_GENERAL, 'Customisable Fields - Repairs' , 'TCustomFieldValuesReapirsGUI', 0);
    Add(REPORT_GROUP_GENERAL, 'Customisable Fields - Supplier' , 'TCustomFieldValuesSupplierGUI', 0);

    Add(REPORT_GROUP_GENERAL, 'Customisable List - Contacts' , 'TCustomFieldValuesListContactGUI', 0);
    Add(REPORT_GROUP_GENERAL, 'Customisable List - Customer' , 'TCustomFieldValuesListCustomerGUI', 0);
    Add(REPORT_GROUP_GENERAL, 'Customisable List - Equipment' , 'TCustomFieldValuesListEquipmentGUI', 0);
    Add(REPORT_GROUP_GENERAL, 'Customisable List - Leads' , 'TCustomFieldValuesListLeadsGUI', 0);
    Add(REPORT_GROUP_GENERAL, 'Customisable List - Products' , 'TCustomFieldValuesListProductGUI', 0);
    Add(REPORT_GROUP_GENERAL, 'Customisable List - Repairs' , 'TCustomFieldValuesListRepairsGUI', 0);
    Add(REPORT_GROUP_GENERAL, 'Customisable List - Supplier' , 'TCustomFieldValuesListSupplierGUI', 0);

    Add(REPORT_GROUP_GENERAL, 'Departments List', 'TClassListGUI', 0);
    Add(REPORT_GROUP_GENERAL, 'Foreign Exchange Rates List', 'TForeignExchangeRatesListGUI', 0);
    Add(REPORT_GROUP_GENERAL, 'HR Forms', 'THRFormsGUI', 0);
    Add(REPORT_GROUP_GENERAL, 'Global List', 'TGlobalListFrm', 0);
    Add(REPORT_GROUP_GENERAL, 'Location List', 'TLocationListGUI', 0);
    Add(REPORT_GROUP_GENERAL, 'Memorised Transaction List', 'TMemTransListGUI', 0);
    Add(REPORT_GROUP_GENERAL, 'Number Sequence List', 'TNumberSequenceListGUI', 0);
    Add(REPORT_GROUP_GENERAL, 'Order KPI List', 'TfmOrderKPIListing', 0);
    Add(REPORT_GROUP_GENERAL, 'Repairs KPI List', 'TfmRepairsKPIList', 0);
    Add(REPORT_GROUP_GENERAL, 'Shipment List', 'TShippingListGUI', 0);
    Add(REPORT_GROUP_GENERAL, 'State Freight Charge List', 'TfmStateFreightList', 0);
    Add(REPORT_GROUP_GENERAL, 'Support Log KPI List', 'TfmSupportLogKPIList', 0);
    Add(REPORT_GROUP_GENERAL, 'Tax Code List', 'TTaxCodeListGUI', 0);
    Add(REPORT_GROUP_GENERAL, 'Terms List', 'TTermsListGUI', 0);
    Add(REPORT_GROUP_GENERAL, 'Transactions with 0 Quantity', 'TTransactionswith0QtyGUI', 0);

    Add(REPORT_GROUP_GENERAL, 'Email Reference List', 'TEmailCorrespondenceReferenceListGUI', 0);
    Add(REPORT_GROUP_GENERAL, 'Letter Reference List', 'TLetterCorrespondenceReferenceListGUI', 0);
    if devmode then Add(REPORT_GROUP_GENERAL, 'Videos', 'TERPVideoConfigurationListLISt', 0);



    if AppEnv.CompanyPrefs.UseGoogleAnalytics then begin
      Add(REPORT_GROUP_GOOGLE, 'Google Analytics Detail List', 'TfmAnalyticsDetailList', 0);
      Add(REPORT_GROUP_GOOGLE, 'Google Analytics Summary List', 'TfmAnalyticsSummaryList', 0);
      (*Add(REPORT_GROUP_GOOGLE, 'Google Combined (By Browser)', 'TGoogleAnalytic_BrowserGUI', 0);
      Add(REPORT_GROUP_GOOGLE, 'Google Combined (By Campaign)', 'TGoogleAnalytic_CampaignGUI', 0);
      Add(REPORT_GROUP_GOOGLE, 'Google Combined (By Keyword)', 'TGoogleAnalytic_KeywordGUI', 0);
      Add(REPORT_GROUP_GOOGLE, 'Google Combined (By Language)', 'TGoogleAnalytic_LanguageGUI', 0);
      Add(REPORT_GROUP_GOOGLE, 'Google Combined (By Location)', 'TGoogleAnalytic_LocationGUI', 0);
      Add(REPORT_GROUP_GOOGLE, 'Google Combined (By Week Day)', 'TGoogleAnalytic_DayofWeekGUI', 0);*)
      Add(REPORT_GROUP_GOOGLE, 'Google Report (By Browser)', 'TGoogleAnalysisReport_BrowserGUI', 0);
      Add(REPORT_GROUP_GOOGLE, 'Google Report (By Campaign)', 'TGoogleAnalysisReport_CampaignGUI', 0);
      Add(REPORT_GROUP_GOOGLE, 'Google Report (By Keyword)', 'TGoogleAnalysisReport_KeywordGUI', 0);
      Add(REPORT_GROUP_GOOGLE, 'Google Report (By Language)', 'TGoogleAnalysisReport_LanguageGUI', 0);
      Add(REPORT_GROUP_GOOGLE, 'Google Report (By Location)', 'TGoogleAnalysisReport_LocationGUI', 0);
      Add(REPORT_GROUP_GOOGLE, 'Google Report (By Week Day)', 'TGoogleAnalysisReport_DayofWeekGUI', 0);
      Add(REPORT_GROUP_GOOGLE, 'Google Report (Summary)', 'TGoogleAnalysisReport_SummaryGUI', 0);

    end;


    // Inventory

    Add(REPORT_GROUP_INVENTORY, 'Allocation Mismatch','TAllocationMismatchGUI', 0);
    //Add(REPORT_GROUP_INVENTORY, 'Alternate Product List','TAlternateProductListGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Alternate Product List','TAlternateProductsGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Attribute Product Sales Summary', 'TAttributeProductSalesSummaryGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Barcode Picking List', 'TBarcodePickListGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Barcode Picking Manifest Report', 'TBarcodePickingManifest', 0);
    Add(REPORT_GROUP_INVENTORY, 'Batches', 'TProductBatchesGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Bin Location List', 'TBinLocationListGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Bin Quantities Report', 'TStockBinQtysReportGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Bin Usage Report', 'TfrmBinUsageReport', 0);

    Add(REPORT_GROUP_INVENTORY, 'Customer Price List', 'TCustomerPriceListGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Customer Type Price List', 'TfrmPriceListGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Goods Receipt List', 'TGoodsReceiptListGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Job Product Sales Summary','TJobProductSalesSummaryList' ,0);
    (*Add(REPORT_GROUP_INVENTORY, 'Group Reorder Report', 'TGroupReorderReportGUI', 0);*)
    Add(REPORT_GROUP_INVENTORY, 'Pick/Pack Sales List', 'TPickedSalesListGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Pick List (Done)', 'TPickSlipManifestGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product Attributes in Sales Template', 'TProdAttribTemplateFieldsGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product Attributes in Sales Template(Details)', 'TProdAttribTemplateFieldsDetailsGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product Barcodes', 'TProductBarcodesGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product BOM History', 'TProductBOMHistoryGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product Extra Buy Price List', 'TProductExtrabuyPricesGUI', 0);
    //Add(REPORT_GROUP_INVENTORY, 'Product Buy Price List', 'TProductBuyPriceListGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product Buy Price List', 'TAlternateProductsEBPGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product Category List', 'TfmProductGroupList',0);
    Add(REPORT_GROUP_INVENTORY, 'Product '+Appenv.Defaultclass.ClassHeading+' List', 'TProductClassListGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product Commission List', 'TProductCommissionListGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product Formula List', 'TfmProductformulaList', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product General Specification List', 'TProductGeneralSpecListGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product List With Unit of Measure', 'TProductListwithUOMGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product Movement Report', 'TProductMovementForm', 0);
    if Appenv.CompanyPrefs.PartCalcfieldVisible then Add(REPORT_GROUP_INVENTORY, 'Product Movement Report(Formula)', 'TProductMovementformulaGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Negative Stock Report', 'TProductNegativeStockGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product Price List', 'TProductPriceListGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product Purchase Movement Report', 'TProductPurchaseMovementListGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product Quantity List', 'TProductQtysListGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product Qty in Cross Stock Companies', 'TProductQtyinCrossStockCompaniesGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product Qty in Progress', 'TProductQtyinProgressGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product Qty List', 'TProductQtylistGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product Reward Points List', 'TProductRewardPointsGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product Sales by Category', 'TfmProductSalesCategoryList', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product Sales Details', 'TProductDetailsGUI', 0);
    //Add(REPORT_GROUP_INVENTORY, 'Product Sales Projection', 'TProductSalesListGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product Sales Projection', 'TProductSalesListFormSoldGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product Sales Summary (By Column)', 'TProductSalesSummaryByColumnGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product Sales Summary', 'TProductSummaryGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product Stock And Sales List', 'TProductStockAndSalesListGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product Summary (By Period)', 'TProductReportByPeriodGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Product Usage List', 'TProductUsageGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Products Express List', 'TProductListExpressGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Products List', 'TProductListGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Products List (Reorder)', 'TProductListReorderGUI', 0);
    (*Add(REPORT_GROUP_INVENTORY, 'Serial Numbers', 'TSerialListGUI', 0);*)
    (*Add(REPORT_GROUP_INVENTORY, 'Stock Adjustment List', 'TStockAdjustListGUI', 0);*)
    Add(REPORT_GROUP_INVENTORY, 'Projected Manufacturing Qty', 'TProjectedManufacturingQtyGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Sale Cost and Profit', 'TSaleCostListGUI', 0);
    //Add(REPORT_GROUP_INVENTORY, 'Serial Numbers', 'TSerialNumbersGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Serial Job Numbers', 'TSerialJobNumbersGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Serial Numbers Available', 'TSerialNumberListBatchGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Serial Numbers (All)', 'TSerialNumberListCurrentGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Serial / Job Numbers', 'TSerialNumbersGUI', 0);

    Add(REPORT_GROUP_INVENTORY, 'Shipment List', 'TShippingListGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Stock Adjustment List', 'TStockAdjustEntryListGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Stock Movement Status', 'TStockStatusRoling', 0);
    Add(REPORT_GROUP_INVENTORY, 'Stock Quantities & Location Report', 'TStockQtysLocationsReportGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Stock Status Report', 'TStockStatusReportGUI', 0);
    (*Add(REPORT_GROUP_INVENTORY, 'Stock Transfer List', 'TStockTransferListGUI', 0);*)
    Add(REPORT_GROUP_INVENTORY, 'Stock Transfer List', 'TStockTransferEntryListGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Stock Value', 'TStockValue', 0);
    Add(REPORT_GROUP_INVENTORY, 'Stock Adjust Entries', 'TStockAdjustEntryDetailListGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Stock Variance', 'TStockAdjustEntryDetailVariaceListGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Stock Verify', 'TfmStockVarify', 0);
    if Appenv.CompanyPrefs.PartCalcfieldVisible then Add(REPORT_GROUP_INVENTORY, 'Stock Summary(Formula)', 'TStockSummaryFormulaGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Supplier Product Report', 'TSupplierProductReportGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'UnAllocated Bins Report', 'TUnAllocatedBinsReportGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'UnAllocated Bin-Batch Qty Report', 'TUnAllocatedQtyGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Unbalanced Bin Quantities', 'TUnbalancedBinQtyGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Units Of Measure List', 'TUnitsOfMeasureListGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Units Of Measure Product List', 'TUOMProductListGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Insurance Report', 'TInsuranceReportGUI', 0);
    Add(REPORT_GROUP_INVENTORY, 'Reorder Levels', 'TfmReorderLevels', 0);

    // Jobs
    Add(REPORT_GROUP_JOBS, '' + Appenv.companyprefs.Areacolumnname +' Product List', 'TAreaPOLinesDetailsListGUI', 0);
    Add(REPORT_GROUP_JOBS, 'Combined Analysis', 'TCombinedAnalysisListGUI', 0);
    Add(REPORT_GROUP_JOBS, 'Customer / Job Follow ups', 'TfrmCustomerJobFollowupList', 0);
    Add(REPORT_GROUP_JOBS, 'Employee Analysis', 'TEmployeeAnalysisListGUI', 0);
    Add(REPORT_GROUP_JOBS, 'Job - Profit and Loss', 'TJobProfitansLossGUI', 0);
    Add(REPORT_GROUP_JOBS, 'Job Analysis / Balance Report', 'TJobAnalysisReportGUI', 0);
    //Add(REPORT_GROUP_JOBS, 'Job Profitability', 'TJobProfitabilityGUI', 0);
    Add(REPORT_GROUP_JOBS, 'Job Profitability', 'TJobProfitabilityforCustomerGUI', 0);
    Add(REPORT_GROUP_JOBS, 'Job Product Sales Summary','TJobProductSalesSummaryList' ,0);


    if (AppEnv.CompanyPrefs.UsePayroll and AppEnv.Employee.PayrollAccess) then begin
        Add(REPORT_GROUP_JOBS, 'Payroll Jobs', 'TPayJobListGUI', 0);
    end;
    Add(REPORT_GROUP_JOBS, 'Profit and Loss', 'TProfitandLossGUI', 0);
    strCaption := '';
    strCaption := strCaption + ' List With ';
    if AppEnv.CompanyPrefs.JobTitle <> '' then
      strCaption := strCaption + AppEnv.CompanyPrefs.JobTitle
    else
      strCaption := strCaption + 'Jobs';
    Add(REPORT_GROUP_JOBS, 'Profit and Loss Summary', 'TProfitLossSummaryGUI', 0);
    if AppEnv.CompanyPrefs.JobNameHeader <> '' then
      Add(REPORT_GROUP_JOBS, AppEnv.CompanyPrefs.JobNameHeader + ' List', 'TJobListGUI', 0)
    else
      Add(REPORT_GROUP_JOBS, 'Job List', 'TJobListGUI', 0);
    Add(REPORT_GROUP_JOBS, 'Profit and Loss (By ' + Appenv.companyprefs.Areacolumnname +' / Employee)' , 'TPnLAreaEmployeeReportGUI',0);

    // Payments
    Add(REPORT_GROUP_PAYMENTS, 'Accounts Payable Notes Report', 'TAccountsPayableNotes', 0);
    Add(REPORT_GROUP_PAYMENTS, 'Accounts Payable Report', 'TAccountsPayListGUI', 0);
    Add(REPORT_GROUP_PAYMENTS, 'Accounts Receivable Notes Report', 'TAccountsReceivableNotes', 0);
    Add(REPORT_GROUP_PAYMENTS, 'Accounts Receivable Report', 'TAccountsReceiveListGUI', 0);
    Add(REPORT_GROUP_PAYMENTS, 'Approval Reminder List', 'TApprovalReminderListGUI', 0);
    Add(REPORT_GROUP_PAYMENTS, 'Bank Account Report', 'TBankAccountListGUI', 0);
    Add(REPORT_GROUP_PAYMENTS, 'Cheque Details', 'TChequeDetailsListGUI', 0);
    Add(REPORT_GROUP_PAYMENTS, 'Customer Payment Detail List', 'TCustPaymentListDettailsGUI', 0);
    Add(REPORT_GROUP_PAYMENTS, 'Customer Payment List', 'TCustPaymentListGUI', 0);
    Add(REPORT_GROUP_PAYMENTS, 'Customer Prepayment List', 'TCustPrepaymentListGUI', 0);
    Add(REPORT_GROUP_PAYMENTS, 'Employee Approval Levels', 'TApprovalLevelListGUI', 0);
    Add(REPORT_GROUP_PAYMENTS, 'Expense Claims', 'TExpenseClaimListGUI', 0);
    Add(REPORT_GROUP_PAYMENTS, 'Overdue Invoices', 'TOverdueInvoicesGUI', 0);

    Add(REPORT_GROUP_PAYMENTS, 'Payment - Department Mismatch', 'TPaymentDepartmentMismatchGUI', 0);
    Add(REPORT_GROUP_PAYMENTS, 'Payment Method List','TPaymentMethodListGUI',0);
    Add(REPORT_GROUP_PAYMENTS, 'Statements', 'TStatementListGUI', 0);
    Add(REPORT_GROUP_PAYMENTS, 'Supplier Payment List', 'TSuppPaymentListGUI', 0);
    Add(REPORT_GROUP_PAYMENTS, 'Supplier Payment List(Detail)', 'TSuppPaymentDetailListGUI', 0);
    Add(REPORT_GROUP_PAYMENTS, 'Supplier Prepayment List', 'TSuppPrepaymentListGUI', 0);
    Add(REPORT_GROUP_PAYMENTS, 'Transaction Approval List', 'TApprovalListGUI', 0);
    Add(REPORT_GROUP_PAYMENTS, 'Transaction Journal', 'TTransactionListGUI', 0);

    // Payroll
    if (AppEnv.CompanyPrefs.UsePayroll and AppEnv.Employee.PayrollAccess) then begin
      Add(REPORT_GROUP_PAYROLL, 'Action Authorisations Report', 'TfrmActionAuthorisationsList', 0);
      Add(REPORT_GROUP_PAYROLL, 'Allowances', 'TfrmAllowanceList', 0);
      Add(REPORT_GROUP_PAYROLL, 'Awards', 'TfrmAwardsList', 0);
      Add(REPORT_GROUP_PAYROLL, 'Allowances Report', 'TfrmPayAllowancesReport', 0);
      Add(REPORT_GROUP_PAYROLL, 'Bank Codes', 'TfrmBankCodeList', 0);
      Add(REPORT_GROUP_PAYROLL, 'Commission List', 'TSalescommissionListGUI', 0);
      Add(REPORT_GROUP_PAYROLL, 'Deductions', 'TfrmDeductionList', 0);
      Add(REPORT_GROUP_PAYROLL, 'Deduction Report', 'TfmPayDeductionsReportList', 0);
      Add(REPORT_GROUP_PAYROLL, 'Employee Pay Tax List', 'TPayTaxListGUI', 0);
      Add(REPORT_GROUP_PAYROLL, 'ETP Report', 'TfrmETPReport', 0);
      Add(REPORT_GROUP_PAYROLL, 'Leave Accruals by Department', 'TLeaveAccrualsReportGUI', 0);
      Add(REPORT_GROUP_PAYROLL, 'Leave Accrued Details', 'TLeaveAccruedDetailsListGUI', 0);
      Add(REPORT_GROUP_PAYROLL, 'Leave Taken', 'TLeaveListGUI', 0);
      Add(REPORT_GROUP_PAYROLL, 'Pay History', 'TPayListingGUI', 0);
      Add(REPORT_GROUP_PAYROLL, '941 Fed Tax Pay History', 'TPayListForm941', 0);
      Add(REPORT_GROUP_PAYROLL, 'State Tax Pay History', 'TPayListStateTax', 0);
      Add(REPORT_GROUP_PAYROLL, 'Pay Hours List', 'TPayHoursListGUI', 0);
      Add(REPORT_GROUP_PAYROLL, 'Pay Rates', 'TfrmPayRateList', 0);
      Add(REPORT_GROUP_PAYROLL, 'PAYG Payment Summary', 'TPAYGPaymentSummaryListGUI', 0);
      Add(REPORT_GROUP_PAYROLL, 'Payroll Jobs', 'TPayJobListGUI', 0);
      Add(REPORT_GROUP_PAYROLL, 'Payroll Reconciliation Report', 'TfrmPayrollReconciliationReportListGUI', 0);
   //   Add(REPORT_GROUP_PAYROLL, 'Roster Exceptions Report', 'TfrmRosterExceptionsList', 0);
      Add(REPORT_GROUP_PAYROLL, 'Rate and Leave Accruals', 'TRateandLeaveAccrualsGUI', 0);
      Add(REPORT_GROUP_PAYROLL, 'Sales Commission', 'TSalesListwithCommisionGUI', 0);
      Add(REPORT_GROUP_PAYROLL, 'Super By Fund Report', 'TfrmSuperFundListGUI', 0);
      Add(REPORT_GROUP_PAYROLL, 'Tax Scales', 'TTaxScaleList', 0);
      Add(REPORT_GROUP_PAYROLL, 'Timesheet Pays', 'TfrmPayTimesheet', 0);
      Add(REPORT_GROUP_PAYROLL, 'Wages Journal', 'TWagesJournalReportGUI', 0);

    end;

    // POS
    Add(REPORT_GROUP_POS, 'Bar Tab List', 'TBarTabListGUI', 0);
    Add(REPORT_GROUP_POS, 'Blind Balance Report', 'TfrmBlindBalanceReport', 0);
    Add(REPORT_GROUP_POS, 'End of Period Summary', 'TPOSEOPSummaryGUI', 0);
    Add(REPORT_GROUP_POS, 'Sales Collated By Item', 'TSalesCollatedByItemGUI', 0);
    Add(REPORT_GROUP_POS, 'Daily Sales Statistics', 'TDailySalesStatisticsGUI', 0);
    Add(REPORT_GROUP_POS, 'Hourly Sales Report', 'THourlySalesReportGUI', 0);
    Add(REPORT_GROUP_POS, 'POS Cash Sale Report', 'TPOSCashPaymentsGUI', 0);
    Add(REPORT_GROUP_POS, 'POS Customer Extra Details', 'TfrmCustomerExtraDetails', 0);
    Add(REPORT_GROUP_POS, 'POS End Of Period Report', 'TfrmEndOfPeriodPOS', 0);
    Add(REPORT_GROUP_POS, 'POS Period Report', 'TfmPosPeriodReport', 0);
    Add(REPORT_GROUP_POS, 'Sales Report', 'TSalesReportGUI', 0);
    Add(REPORT_GROUP_POS, 'Till Summary Report', 'TTillSummaryReportGUI', 0);
    Add(REPORT_GROUP_POS, 'Traffic List', 'TTrafficListGUI', 0);
    Add(REPORT_GROUP_POS, 'Traffic Summary', 'TTrafficMonitoringSummaryGUI', 0);
    Add(REPORT_GROUP_POS, 'Vouchers List', 'TVoucherListGUI', 0);


    // Purchases

    Add(REPORT_GROUP_PURCHASES, 'Accounts Payable Report', 'TAccountsPayListGUI', 0);
    Add(REPORT_GROUP_PURCHASES, 'Approval Reminder List', 'TApprovalReminderListGUI', 0);
    Add(REPORT_GROUP_PURCHASES, 'Bill Details', 'TBillDetailsListGUI', 0);
    Add(REPORT_GROUP_PURCHASES, 'Bill List', 'TBillListGUI', 0);
    Add(REPORT_GROUP_PURCHASES, 'Employee Approval Levels', 'TApprovalLevelListGUI', 0);
    Add(REPORT_GROUP_PURCHASES, 'Expense Claim List', 'TExpenseClaimListGUI', 0);
    Add(REPORT_GROUP_PURCHASES, 'Foreign Purchase Report', 'TForeignPurchaseOrderListExpressGUI', 0);
    Add(REPORT_GROUP_PURCHASES, 'Incoming Customer Orders List', 'TIncomingCustomerOrdersGUI', 0); // TIncomingCustomerOrdersListGUI is replaced with this form
    Add(REPORT_GROUP_PURCHASES, 'Incoming Orders', 'TIncomingOrdersList', 0);
    Add(REPORT_GROUP_PURCHASES, 'Number Sequence List', 'TNumberSequenceListGUI', 0);
    //Add(REPORT_GROUP_PURCHASES, 'Product Report', 'TProductSalesListGUI', 0);
    Add(REPORT_GROUP_PURCHASES, 'Product Sales Projection', 'TProductSalesListFormSoldGUI', 0);
    Add(REPORT_GROUP_PURCHASES, 'Product Sales Details', 'TProductDetailsGUI', 0);
    Add(REPORT_GROUP_PURCHASES, 'Product Sales Summary', 'TProductSummaryGUI', 0);
    Add(REPORT_GROUP_PURCHASES, 'Profit and Loss Summary', 'TProfitLossSummaryGUI', 0);
    Add(REPORT_GROUP_PURCHASES, 'Profit and Loss', 'TProfitandLossGUI', 0);
    Add(REPORT_GROUP_PURCHASES, 'Purchase Order BackOrders', 'TBackOrderPurchaseListGUI', 0);
    Add(REPORT_GROUP_PURCHASES, 'Purchase Orders - Invoiced Before Ordered', 'TPOsInvoicedBeforeOrderGUI', 0);
    Add(REPORT_GROUP_PURCHASES, 'Purchase Order Change List', 'TBackorderPurchaseOrderChangeListGUI', 0);
    Add(REPORT_GROUP_PURCHASES, 'Purchase Order List', 'TPurchaseOrderListGUI', 0);
    Add(REPORT_GROUP_PURCHASES, 'Purchase Order List Detail', 'TPurchaseOrderDetailListGUI', 0);
    Add(REPORT_GROUP_PURCHASES, 'Return Authority List', 'TReturnAuthListGUI', 0);
    Add(REPORT_GROUP_PURCHASES, 'Supplier Order Totals', 'TSmartorderListDetailsGUI', 0);
    Add(REPORT_GROUP_PURCHASES, 'Smart Order List', 'TSmartOrderListGUI', 0);
    Add(REPORT_GROUP_PURCHASES, 'Stock Value', 'TStockValue', 0);
    Add(REPORT_GROUP_PURCHASES, 'Supplier List', 'TSupplierListGUI', 0);
    Add(REPORT_GROUP_PURCHASES, 'Supplier Product Report', 'TSupplierProductReportGUI', 0);
    Add(REPORT_GROUP_PURCHASES, 'Supplier Report', 'TSupplierReportGUI', 0);
    Add(REPORT_GROUP_PURCHASES, 'Supplier Statement ', 'TSupplierStatementGUI', 0);
    Add(REPORT_GROUP_PURCHASES, 'Transaction Approval List', 'TApprovalListGUI', 0);
    Add(REPORT_GROUP_PURCHASES, 'Un-Invoiced Customer Purchase Items', 'TfmUnInvoicedPurchItemList', 0);
    Add(REPORT_GROUP_PURCHASES, 'Un-Invoiced Customer Purchase Orders', 'TfmUnInvoicedPurchasesList', 0);
    Add(REPORT_GROUP_PURCHASES, 'Unpaid Bills', 'TUnpaidBillGUI', 0);


    // Sales
    Add(REPORT_GROUP_SALES, 'Accounts Receivable Report', 'TAccountsReceiveListGUI', 0);
    Add(REPORT_GROUP_SALES, 'BOM Sales Sub Products (Details)', 'TBOMSalesSubProductsDetailListGUI', 0);
    Add(REPORT_GROUP_SALES, 'BOM Sales Sub Products (Summary)', 'TBOMSalesSubProductsListGUI', 0);


    Add(REPORT_GROUP_SALES, 'Customer Balance Detail', 'TCustomerBalanceDetailGUI', 0);
    Add(REPORT_GROUP_SALES, 'Customer Details List', 'TCustomerDetailsListGUI', 0);
    Add(REPORT_GROUP_SALES, 'Customer List', 'TCustomerListGUI', 0);
    Add(REPORT_GROUP_SALES, 'Customer Express List', 'TCustomerExpressListGUI', 0);
  //  Add(REPORT_GROUP_SALES, 'Customer Notes Report', 'TCustomerNotesReportGUI', 0);
    Add(REPORT_GROUP_SALES, 'Customer Summary', 'TCustomerSummaryListingGUI', 0);
    Add(REPORT_GROUP_SALES, 'Customer Price List', 'TCustomerPriceListGUI', 0);
    Add(REPORT_GROUP_SALES, 'Customer Type List', 'TClientTypeListGUI', 0);
    Add(REPORT_GROUP_SALES, 'Customer Type Price List', 'TfrmPriceListGUI', 0);
    Add(REPORT_GROUP_SALES, 'Dispatches Report', 'TDispatchesReportGUI', 0);
    Add(REPORT_GROUP_SALES, 'Employee Summary (By Period)', 'TEmployeeReportByPeriodGUI', 0);
    Add(REPORT_GROUP_SALES, 'Employee Summary', 'TEmployeeReportGUI', 0);
    Add(REPORT_GROUP_SALES, 'Foreign Sales Report', 'TfmForeignSalesList', 0);
    Add(REPORT_GROUP_SALES, 'Commission List', 'TSalescommissionListGUI', 0);
    Add(REPORT_GROUP_SALES, 'Intrastat List', 'TfrmIntrastatList', 0);
    Add(REPORT_GROUP_SALES, 'Invoice BackOrders', 'TBackOrdersListGUI', 0);
    Add(REPORT_GROUP_SALES, 'Invoice (Internal Order) Express List', 'TInvoiceInternalOrderlistExressGUI', 0);
    (*Add(REPORT_GROUP_SALES, 'Invoice Commission Report', 'TfrmCommissionReportGUI', 0);*)
    Add(REPORT_GROUP_SALES, 'Invoice List', 'TInvoiceListGUI', 0);
    (*Add(REPORT_GROUP_SALES, 'Loyalty Program', 'TLoyaltyListGUI', 0);*)
    Add(REPORT_GROUP_SALES, 'Job Quote List', 'TfmQuoteJobList', 0);
    Add(REPORT_GROUP_SALES, 'Job Product Sales Summary','TJobProductSalesSummaryList' ,0);
    Add(REPORT_GROUP_SALES, 'Job Product Sales Detail','TJobProductSalesDetailListGUI' ,0);
    Add(REPORT_GROUP_SALES, 'Marketing Ratio Report', 'TfrmMarketingRatios', 0);
    Add(REPORT_GROUP_SALES, 'Number Sequence List', 'TNumberSequenceListGUI', 0);
    Add(REPORT_GROUP_SALES, 'Order KPI List', 'TfmOrderKPIListing', 0);
    //Add(REPORT_GROUP_SALES, 'Product Report', 'TProductSalesListGUI', 0);
    Add(REPORT_GROUP_SALES, 'Print Address Labels', 'TSalesAddressLabelPrnGUI', 0);
    Add(REPORT_GROUP_SALES, 'Product Sales Projection', 'TProductSalesListFormSoldGUI', 0);
    Add(REPORT_GROUP_SALES, 'Product Sales by Category', 'TfmProductSalesCategoryList', 0);
    Add(REPORT_GROUP_SALES, 'Product Sales Details', 'TProductDetailsGUI', 0);
    //Add(REPORT_GROUP_SALES, 'Product Sales History', 'TCustomerProductsaleshistoryGUI', 0);
    Add(REPORT_GROUP_SALES, 'Product Sales Report', 'TProductSalesReportGUI', 0);
    Add(REPORT_GROUP_SALES, 'Product Sales Summary (By Column)', 'TProductSalesSummaryByColumnGUI', 0);
    Add(REPORT_GROUP_SALES, 'Product Sales Summary', 'TProductSummaryGUI', 0);
    Add(REPORT_GROUP_SALES, 'Production Order Report', 'TProductionOrderListGUI', 0);

    Add(REPORT_GROUP_SALES, 'Profit and Loss Summary', 'TProfitLossSummaryGUI', 0);
    Add(REPORT_GROUP_SALES, 'Profit and Loss', 'TProfitandLossGUI', 0);
//    Add(REPORT_GROUP_SALES, 'Project List', 'TfrmProjectList', 0);
    Add(REPORT_GROUP_SALES, 'Quote Details Report', 'TQuoteDetailsReport', 0, 'Quote Details Report');
    Add(REPORT_GROUP_SALES, 'Quote List', 'TQuoteListGUI', 0);
    Add(REPORT_GROUP_SALES, 'Quote Status Report', 'TQuoteListGUI', 0, 'Quote Status Report');
    Add(REPORT_GROUP_SALES, 'Refund Sales Report', 'TRefundSalesListGUI', 0, 'Refund Sales Report');
    Add(REPORT_GROUP_SALES, 'Sale Cost and Profit', 'TSaleCostListGUI', 0);
    Add(REPORT_GROUP_SALES, 'Sales Commission', 'TSalesListwithCommisionGUI', 0);
    Add(REPORT_GROUP_SALES, 'Sales List', 'TSalesListReportGUI', 0);
    Add(REPORT_GROUP_SALES, 'Sales List Outstanding', 'TSalesListOutstandingGUI', 0);
    Add(REPORT_GROUP_SALES, 'Sales Order BackOrders', 'TBackOrderSOGUI', 0);
    Add(REPORT_GROUP_SALES, 'Sales Order List', 'TSalesOrderListGUI', 0);
    Add(REPORT_GROUP_SALES, 'Sales Order - Partial Invoice List', 'TsalesOrderInvoicesGUI', 0);
    Add(REPORT_GROUP_SALES, 'Sales Order - Progress Payments', 'TSalesOrderProgressPaymentsGUI', 0);
    Add(REPORT_GROUP_SALES, 'Sales Order Report', 'TSalesOrderReportGUI', 0);
    Add(REPORT_GROUP_SALES, 'Sales Order Status Report', 'TSalesOrderStatusReportGUI', 0);
    Add(REPORT_GROUP_SALES, 'Sales Order Summary Report', 'TCustSalesOrdersReportGUI', 0);
    Add(REPORT_GROUP_SALES, 'Sales Pipeline Report', 'TfrmSalesPipelineReport', 0);
//    Add(REPORT_GROUP_SALES, 'Sales Report Matrix Allocation', 'TfmProdSalesDescAttribMatrixList', 0);
    Add(REPORT_GROUP_SALES, 'Sales Report', 'TSalesReportGUI', 0);
    Add(REPORT_GROUP_SALES, 'Sales Report - Customer Custom Fields', 'TSalesReportCustomercustomFieldListGUI', 0);
    Add(REPORT_GROUP_SALES, 'Sales Report - Product Custom Fields', 'TSalesReportProductcustomFieldListGUI', 0);
    Add(REPORT_GROUP_SALES, 'Sales Report - Sales Lines Custom fields', 'TSalesReportSaleslinescustomFieldListGUI', 0);

    Add(REPORT_GROUP_SALES, 'Sales Report (Details)', 'TsalesreportDetailsGUI', 0);
    Add(REPORT_GROUP_SALES, 'Sales Report (Details) - Customer Custom fields'   , 'TSalesReportDetailsCustomercustomFieldListGUI', 0);
    Add(REPORT_GROUP_SALES, 'Sales Report (Details) - Product Custom Fields'    , 'TSalesReportDetailsProductcustomFieldListGUI', 0);
    Add(REPORT_GROUP_SALES, 'Sales Report (Details) - Sales Lines Custom Fields', 'TSalesReportDetailsSaleslinescustomFieldListGUI', 0);

    Add(REPORT_GROUP_SALES, 'Sales Reward Points', 'TfmSalesRewardPointsList', 0);
    Add(REPORT_GROUP_SALES, 'Sales Summary Report', 'TSalesSummaryReportGUI', 0);
    Add(REPORT_GROUP_SALES, 'Sales Tax Report', 'TSalesTaxReportGUI', 0);
    Add(REPORT_GROUP_SALES, 'Stock Analysis Detail Report', 'TStockAnalysisDetailsReportGUI', 0);
    Add(REPORT_GROUP_SALES, 'Stock Turnover Report', 'TSoldProductsReport', 0);
    Add(REPORT_GROUP_SALES, 'Stock Value', 'TStockValue', 0);
    Add(REPORT_GROUP_SALES, 'Sales Ratios Report', 'TfrmSalesRatioReport', 0);
    Add(REPORT_GROUP_SALES, 'Shipment List', 'TShipmentListFormGUI', 0);
    Add(REPORT_GROUP_SALES, 'Shipping Agent List', 'TShippingAgentGUI', 0);
    Add(REPORT_GROUP_SALES, 'Weekly Sales Report', 'TWeeklySalesreportGUI', 0);
    (*Add(REPORT_GROUP_SALES, 'Customer Contacts List', 'TCustomerContactListGui', 0);*)
    Add(REPORT_GROUP_SALES, 'Customer Contacts List', 'TCustomFieldValuesListContactGUI', 0);
    Add(REPORT_GROUP_SALES, 'Reorder Levels', 'TfmReorderLevels', 0);


    // Utilities
    Add(REPORT_GROUP_UTILITIES, 'Audit Trail List', 'TAuditTrailListGUI', 0);
    Add(REPORT_GROUP_UTILITIES, 'Email List', 'TEmailListGUI', 0);
    Add(REPORT_GROUP_UTILITIES, 'Emailed Reports', 'TEmailedReportsList', 0);
    Add(REPORT_GROUP_UTILITIES, 'Preference List', 'TPrejerenceToExportGUI', 0);
    Add(REPORT_GROUP_UTILITIES, 'Scheduled Reports', 'TScheduledReportsGUI', 0);

    if hasSerialNoTabletAllocationIssue then
      Add(REPORT_GROUP_UTILITIES, 'Serial No Tablet Allocation', 'TSerialNoTabletAllocationGUI', 0);

    Add(REPORT_GROUP_UTILITIES, 'Server log List', 'TfmServerLogList', 0);
    Add(REPORT_GROUP_UTILITIES, 'Site Integration Report', 'TfmSiteIntegrationReport', 0);
    Add(REPORT_GROUP_UTILITIES, 'SMS List', 'TSMSListGUI', 0);
//    Add(REPORT_GROUP_UTILITIES, 'Fax Spool List', 'TFaxSpoolListingGUI', 0);

  end;
end;

initialization
  dmReports := TdmReports.Create(Application);
end.




