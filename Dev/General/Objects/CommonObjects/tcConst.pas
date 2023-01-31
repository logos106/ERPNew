unit tcConst;

{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 22/11/05 1.00.02  IJB  Added GLACCOUNT_TAX_COLLECTED and GLACCOUNT_TAX_WET
 14/12/05 1.00.03  DSP  Added 'actApptsAllocateJob' and
                        'actApptsJobAllocationList' to
                        DEFAULT_ACTIONS_APPOINTMENTS.
}

interface
{$I ERP.inc}
uses SysUtils, tcTypes , MyAccess,ERPdbComponents, MyClasses, Graphics, StSConst;



resourcestring
  WAITMSG = 'Please Wait...';
  REQUIRED_SERVICES_VERSION = '7.5';
  UPDATE_NOTES_FILE         = 'UpdateNotes.rtf';
  LICENCE_AGREEMENT_FILE    = 'Software Licence Agreement.pdf';
  ADDITIONS_AGREEMENT_FILE  = 'Software Additions Contract.pdf';
  SMS_RATES_FILE            = 'SMS Rates.xls';

  APPROVALREQUESTDESC       = 'Requires Your Approval';
  APPROVEDDESC              = 'Has Been Approved';
  NOTAPPROVEDREMINDERDESC   = 'Has Not Been Approved';
  POCREATEDFORSO            = 'Purchase Order Has been Created';
  HASBEENCREATEDDESC        = 'Has Been Created';


  TABLE_NAMES_NOT_TO_BE_INNODB = '|tbltransactions|tmp_tblbudgetactuals|tblbalancesheet|tbltransactions_inprogress|tbltransactionsummary|tbltransactionsummarydetails|';
  SPECIAL_FEATURES_FILE     = 'keys.dll';

  MASK_HIRE_NO = '[HireNo]';
  DEFAULT_HIRE_DESC = 'Hire (Hire No [HireNo])';
  FIELD_MASK_PERCENT = '###0.00###%';
  CRLF = #13#10;

  {Tax related}
  TAX_CODE_GST = 'GST';

  {Chart of Accounts}
  GLACCOUNT_TAX_PAID = 'Tax Paid';
  GLACCOUNT_TAX_COLLECTED = 'Tax Collected';
  GLACCOUNT_TAX_WET       = 'WET';
  GLACCOUNT_TAX_WEG       = 'WEG';
  GLACCOUNT_CUSTPREPAYMENT= 'Customer Prepayments';
  GLACCOUNT_SUPPPREPAYMENT= 'Supplier Prepayments';
  GLACCOUNT_ROUNDFIX      =  'Round Fix Expense';
  GLACCOUNT_COGS          = 'Cost of Goods Sold';
  GLACCOUNT_SALES         = 'Sales';
  GLACCOUNT_INVASST       = 'Inventory Asset';
  UNDEPOSITED_FUNDS       = 'Undeposited Funds';
  UNINVOICEDSO            = 'Uninvoiced SO';
  UNINVOICEDPO            = 'Un-Invoiced PO';
  UNAVAILABLE             = 'UnAvailable';
  AVAILABLE               = 'Available';


  {Product constants}
  // Special Part names (note that these names must match those in tblParts)
  PART_HIRE                     = 'Hire';
  PART_SERVICE_LABOUR           = 'Service Labour';
  PART_PCENT_DISC  = '%Discount';
  PART_DOL_DISC    = '$Discount';
  PART_PCENT_SURCH = '%Surcharge';
  PART_DOL_SURCH   = '$Surcharge';
  PART_OVERDUE_SURCH='Surcharge for Overdue';
  PART_ROUNDING    = 'Rounding';
  PART_MISC        = 'MISC';
  PART_LABOUR      = 'Labour';
  PART_VOUCHER     = 'Voucher';
  PART_COMPLETION  = 'Completion';
  PART_CASH_OUT    = 'Cash Out';
  PART_VOUCHER_PAY = 'Voucher Payment';
  PART_MEMO        = 'Memo Only';
  PART_ACNT_PAY    = 'Account Payment';
  PART_ROOM        = 'Room Booking';
  PART_EXTRAS      = 'Extras';
  PART_REVERSAL    = 'Reversal';
  PART_PAYMENT     = 'Payment';
  PART_SOPROGRESSPAYMENT='Progress Payment';
  PART_PROGRESSShipment='Progress Shipment';
  PART_LAYBY_PAY   = 'Layby Payment';
  PART_PROGRESSPAYMENT_TERMS='Progress Payment Based on Terms';
  PART_DUMMYPRODUCT = 'Dummy Product';

  ACNT_ACNTS_RCV                = 'Accounts Receivable';
  ACNT_ACNTS_PAY                = 'Accounts Payable';
  ACNT_DUMMYACCOUNT             = 'Dummy Account';
  TERMS_ON_RCPT                 = 'Due on Receipt';
  TERMS_PREPAYMENT              = 'Prepayment';
  EARLY_PAYMENT_DISCOUNT_PRODUCT= 'Early Payment Discount';
  CURRENCY_VARIATION_PRODUCT    = 'Currency Variation';
  PAYMENT_DISCOUNT_PRODUCT      = 'Payment Discount';
  INVOICE_RETENTION_PRODUCT     = 'Invoice Retention';
  TOTALDISCOUNT_PRODUCT         = 'Total Sale Discount';
  ACNT_REWARD_POINTS_SOLD       = 'Reward Points sold';
  ACNT_REWARD_POINTS_EXPIRED    = 'Reward Points Expired';
  ERPAdminEmployeeName          = 'Admin .';
  ACNT_REWARD_POINTS_COGS       = 'COGS for Reward Points';
  REDEEM_POINTS    = 'Reward Points';

  PAYMENT_DISCOUNT_EXPENSE_ACCOUNT = 'Discount';


    ACC_LVL_MSG_1 = ' - (Full Access)';
    ACC_LVL_MSG_2 = ' - (Full Access, No Delete)';
    ACC_LVL_MSG_3 = ' - (Create + Read)';
    ACC_LVL_MSG_4 = ' - (Read Only)';
    ACC_LVL_MSG_5 = ' - (No Access)';
    ACC_LVL_MSG_6 = ' - (No Access)';



  JOURNAL_ENTRY    = 'Journal Entry';
  CUSTOMER_PAYMENT = 'Customer Payment';
  SUPPLIER_PAYMENT = 'Supplier Payment';
  CHEQUE           = 'Cheque';
  CREDITCARD       = 'Credit Card';
  EFT              = 'E.F.T.';
  CHEQUE_DEPOSIT   = 'Cheque Deposit';
  DEPOSIT          = 'Deposit';
  BANK_DEPOSIT     = 'Bank Deposit';
  DEPOSIT_ENTRY    = 'Deposit Entry';
  DEPOSIT_SPLIT    = 'Split Deposit';
  CUSTOMER_PREPAYMENT = 'Customer Prepayment';
  SUPPLIER_PREPAYMENT = 'Supplier Prepayment';


  PRINTER_EPSONTMU220 ='Epson TM-U220 Series on USB';
  PRINTER_EPSONT82II ='Epson TM-T82II Series on USB';

  PRINTER_STARTSP100  ='STAR TSP-100 Series on USB';



  CLIENT_CASH = 'Cash Customer';
  CLIENT_WORKSHOP = 'Workshop';
  Normal_Hours = 'Normal Hours';
  Piece_Rate    = 'Piece-Rate';

  PREF_GROUP_COMPANY     = 'Company';
  PREF_GROUP_GENERAL     = 'General';
  PREF_GROUP_EMPLOYEE    = 'Employee';
  PREF_GROUP_MAIN_SWITCH = 'MainSwitch';
  PREF_GROUP_MAIN        = 'MainMenu';

  PREF_NAME_MAIN_SWITCH_MENU     = 'MainSwitchMenu';
  PREF_NAME_TOOLBAR_MENU         = 'ToolbarMenu';
  PREF_NAME_EMPLOYEE_PREFERENCES = 'EmployeePreferences';

  PAGE_NAME_TOOLBAR = 'Toolbar';
  MAIN_MENU_CAPTION = 'Main Menu';
  PREF_MENU_CAPTION = 'Preference Menu';

  {transaction types}
    PrePayType  = 'Prepayment';
    InvType     = 'Invoice';
    RefundType  = 'Refund';
    POType      = 'Purchase Order';
    RAType      = 'Return Authority';
    CreditType  = 'Credit';
    Billtype    = 'Bill';
    ChequeType  = 'Cheque';
    StockAdjustEntryType = 'StockAdjustEntry';
    StockTransferEntrytype = 'StockTransferEntry';
    StSStockMovementType = 'StSTags';


   RALineStatus_Awaiting_RA_No  = 'Awaiting RA No';
   RALineStatus_In_Transit      ='In Transit';
   RALineStatus_Returned        = 'Returned';
   RALineStatus_Send_To_Supplier='Send To Supplier';
   RALineStatus_Testing         = 'Testing';
   RALineStatus_With_Supplier   = 'With Supplier';

  RALineStatusCommaText = '"Awaiting RA No",'+
                          '"In Transit",'+
                          'Returned,'+
                          '"Send To Supplier",'+
                          'Testing,'+
                          '"With Supplier"';

  TABLE_PROFITANDLOSSREPORT = 'tmp_profitandlossreport';

  TABLE_EXPORT_TABLES = 'tblexporttables';

  SEQ_ORDER_CUSTDOCKETREF = 'OrderCustDocketRef';
  SEQ_LAST_CHEQUENO = 'LastChequeNo';

(*  REPORTING_DB_NAME    = 'ERP_Export';
  REPORTING_DB_USER    = 'Export';
  REPORTING_DB_USER_PASS = 'Export';*)
  DB_KEY_IF_NOT_EXISTS = 'IF NOT EXISTS';

  AuditTrialOldValue = ' - Old Value =';
  AuditTrialNewValue = ', New Value =';
  VIDEO_SUBDIR = 'Videos\';
  BarCodeType_WorkOrder = 'btWorkOrder';
  BarCodeType_None      = 'btNone';
  HELPDOC_SUBDIR = 'Helpdocs\';


  DEFAULT_ACTIONS_SALES =
    'actSalesCustomersNewCustomer,' +
    'actSalesQuotesQuote,' +
    'actSalesSalesOrdersSalesOrder,' +
    'actSalesSalesInvoice,' +
    'actSalesSalesCashSale,' +
    'actCustomerReturns,'+

    'actCustomerExpressList,'+
    'actSalesQuotesQuoteExpressList,'+
    'actSalesSalesOrdersSalesOrderExpressList,'+
    'actSalesSalesInvoiceExpressList,'+
    'actSalesSalesRefunds,' +
    'actCustomerReturnList,' +

    'actInventProductsProductsExpressList,' +
    'actsalesdispatch,'+
    'actSalesSalesBackOrders,' +
    'actsalesDashboard,' +
    'actSalesReport,'+
    'actReportsSales,'+

    'actSalesPrintInvoices,'+
    'actDeldocketList,'+
    'actSalesPrintPickSlips,'+

    'act_How_To_Create_and_Use_Leads,'+
    'act_How_To_Create_Quote,'+
    'act_How_To_Create_Refund';

  DEFAULT_ACTIONS_COLES =
    'actColesSalesOrderExpressList,'+
    'actColesORDRSPExpressList,'+
    'actColesInvoiceExpressList,'+
    'actColesDESADVExpressList';
//    'actColesDESADVExpressList,'+
//    'actColesREMADVExpressList';

  DEFAULT_ACTIONS_DELIVERY =
    'actSalesManifestManifestVehicle,'+
    'actSalesManifestManifestRoute,'+
    'actSalesManifestManifestAllocationList,'+
    'actSalesManifestManifestList,'+
    'actDeliveryDocketList,'+
    'actBarcodeAction,'+
    'actSalesManifestManifestVehicleList,' +
    'actSalesManifestManifestRouteList,'+
    'actSalesManifestManifestListDetail';

  DEFAULT_ACTIONS_PURCHASES =
    'actPurchasesSuppliersSupplier,'+
    'actPurchasesSmartOrdersSmartOrder,'+
    'actPurchasesPurchaseOrdersPurchaseOrder,' +
    'actPurchasesReturnAuthorityReturnAuthority,'+
    'actPurchasesBillsBill,'+
    'actPurchasesBillsBillRefund,' +

    'actPurchasesSuppliersSupplierExpressList,'+
    'actPurchasesSmartOrdersSmartOrderList,'+
    'actPurchasesPurchaseOrdersPurchaseOrderExpressList,' +
    'actPurchasesReturnAuthorityReturnAuthorityList,'+
    'actPurchasesBillsBillList,'+
    'actPurchasesPurchaseOrdersBackOrders,'+

    'actExpenseClaimRequest,'+
    'actShippingContainer,' +
    'actPurchasesPurchaseOrdersPurchaseOrderListDetail,' +
    'actInventProductsProductsExpressList,'+
    'actAccountsForeignExchangeRatesList,'+
    'actReportsPurchases,'+

    'actPurchasesExpenseClaimList,'+
    'actShipContainerList,' +
    'act_How_To_Create_and_Use_S_M_and_PO,'+
    'act_How_To_Auto_Reorder,'+
    'act_How_To_Back_Ordered_PO_Sequence,' +
    'act_How_To_Create_Shipping_Containers,'+

    'act_How_To_Set_Up_Landed_Costs';



DEFAULT_ACTIONS_INVENTORY_ADJUST =
    'actInventStockStockAdjustmentbatch,' +
    'actInventStockStockAdjustmentBin,' +
    'actInventStockStockAdjustmentSN,'+
    'actInventStockStockAdjustment,' +
    'actInventStockStockTake,'+
    'actInventPriceUpdate,' +

    'actInventStockStockAdjustmentbatchList,' +
    'actInventStockStockAdjustmentbinList,' +
    'actInventStockStockAdjustmentsnLsit,'+
    'actInventStockStockAdjustmentList,' +
    'actStockTakeList,'+
    'actInventAutoReOrder,' +

    'actStockTransferEntryBatch,' +
    'actStockTransferEntryBin,' +
    'actStockTransferEntrySN,'+
    'actStockTransferEntryTree,' +
    'actExportStockAdjustment,'+
    'actAutoAdjustbin,' +

    'actStockTransferEntryListBAtch,' +
    'actStockTransferEntryListBin,' +
    'actStockTransferEntryListSN,'+
    'actInventStockStockTransferList,'+
    'actImportStockAdjustment,' +
    'actReportsInventory,'+

    'actStockanalysisReport,'+
    'act_How_To_Inventory_Asset_v_Balance_Sheet';



  DEFAULT_ACTIONS_INVENTORY =
    'actInventProductsProduct,' +
    'actInventBarcodePickingAssembly,' +
    'actGoodsReceipt,' +
    'actSerialNumberList,' +
    'actDeldocketList,' +
    'actInventPriceUpdate,' +

    'actInventProductsProductsExpressList,' +
    'actInventBarcodePickingAssemblyList,' +
    'actGoodsReceiptList,'+
    'actSerialJobnumber,'+
    'actInventPrintPickSlips,' +
    'actInventAutoReOrder,' +

    'actProductQtylist,'+
    'actsingleSalesAddressLabelPrn,'+
    'actBatches,' +
    'actProductAttributes,'+
    'actProductOptions,'+
    'actInventoryAsset,' +
    'actReportsInventory,'+

    'actInventProductsProductsList,'+
    'actSalesAddressLabelPrn,' +
    'act_How_To_Auto_Reorder,'+
    'act_How_To_Product_Forecast_Formula,'+
    'act_How_To_Inventory_Asset_v_Balance_Sheet';


  DEFAULT_ACTIONS_PAYMENTS =
    'actPaymentsAccountsReceivableReport,'+
    'actPaymentsCustomerPrepayment,'+
    'actPaymentsCustomerPayment,'+
    'actPaymentsSupplierPrepayment,'+
    'actPaymentsSupplierPayment,'+
    'actPaymentsPrintStatements,'+

    'actPaymentsAccountsPayableReport,'+
    'actPaymentsCustomerPrepaymentList,'+
    'actPaymentsCustomerPaymentList,'+
    'actPaymentsSuppPrepaymentList,'+
    'actPaymentsSupplierPaymentList,'+
    'actReportsPayments,'+

    'actPaymentsAccountsReceivableNotes,'+
    'actPaymentsStatements,'+
    'actPaymentsReceivedBulkPayments,'+
    'actPaymentsPrintRecipientCreatedStatement,'+
    'actPaymentsBulkPaySuppliers,'+
    'actPaymentsCustomerPaymentExpressList';

  DEFAULT_ACTIONS_EMPLOYEE =
    'actEmployeeRep,'+
    'actEmployeeToDo,'+
    'actEmployeeEmployee,'+
    'actTimesheetEntry,' +
    'actEmployeeRoster,'+
    'actEmployeeClockOn,'+

    'actEmployeeRepList,'+
    'actEmployeeToDoList,'+
    'actEmployeeEmployeeList,'+
    'actEmployeeTimesheetList,' +
    'actEmployeeRosterList,'+
    'actClockedOnList,'+

    'actExpenseClaimRequest,'+
    'actEmployeeRepServices,'+
    'actrosterReport,'+
    'actEmployeeEmployeeSummary,'+
    'actReportsCustomReports,'+
    'actEmployeePersonalPreferences,' +

    'actPurchasesExpenseClaimList,'+
    'actProjectInstallations,'+
    'actRosterBreakList,'+
    'actSetupEmployee,' +
    'actHRForms,'+
    'actReportsEmployee,'+

    'act_How_To_Add_Employee_to_Calendar';


  DEFAULT_ACTIONS_TRAINING=
    'actSetupcompany,'+
    'actEmployeeEmployee,'+
    'actTrainingAssignment,' +
    'actTrainingStatus,'+
    'actTrainingModule,'+
    'actVideos,'+

    'actSetupTraining ,'+
    'actEmployeeEmployeeList,'+
    'actTrainingRoster,'+
    'actHRForm,'+
    'actTrainingList,'+
    'actCustomisetraining,' +

    'actGoLive,' +
    'actHowToList,'+
    'actTrainingDocs,' +
    'actHRForms,'+
    'actTrainingProgresschart,'+
    'actHowTogoLive';

  DEFAULT_ACTIONS_PAYROLL =
    'actEmployeePayrollPayStaff,'+
    'actEmployeePayrollNewAward,'+
    'actEmployeePayrollNewAllowance,'+
    'actEmployeePayrollNewDeduction,'+
    'actEmployeePayrollATO,' +
    'actEmployeePayrollTaxScales,'+

    'actEmployeePayrollPayHistory,'+
    'actEmployeePayrollAwards,'+
    'actEmployeePayrollAllowances,'+
    'actEmployeePayrollDeductions,'+
    'actEmployeePayrollBankCodes,'+
    'actReportsPayroll,'+

    'actEmployeePayrollPayRates,' +
    'actEmployeePayrollEmployeeServices,'+
    'actEmployeePayrollPAYGSummary,'+
//    'actEmployeePayrollCompanyPayrollInfo,'+
//    'actEmployeePayrollTimeSheetList,'+
//    'actEmployeePayrollTimeSheet,'+

    'actEmployeePayrollSuperByFund,'+
    'actSetupPayroll,'+
    'actEmpPayRunList';

  DEFAULT_ACTIONS_PAYROLL_UK =
    'actEmployeePayrollPayStaff,'+
    'actEmployeePayrollNewAward,'+
    'actEmployeePayrollNewAllowance,'+
    'actEmployeePayrollNewDeduction,'+
    'actEmployeePayrollATO,' +
    'actEmployeePayrollTaxScales,'+

    'actEmployeePayrollPayHistory,'+
    'actEmployeePayrollAwards,'+
    'actEmployeePayrollAllowances,'+
    'actEmployeePayrollDeductions,'+
    'actEmployeePayrollBankCodes,'+
    'actReportsPayroll,'+

    'actEmployeePayrollPayRates,' +
    'actEmployeePayrollEmployeeServices,'+
    'actEmployeePayrollPAYGSummary,'+
//    'actEmployeePayrollCompanyPayrollInfo,'+
//    'actEmployeePayrollTimeSheetList,'+
//    'actEmployeePayrollTimeSheet,'+

    'actEmployeePayrollSuperByFund,'+
    'actSetupPayroll,'+
    'actVATObligationList';

  DEFAULT_ACTIONS_PAYROLL_USA =
    'actEmployeePayrollPayStaff,'+
    'actEmployeePayrollNewAward,'+
    'actEmployeePayrollNewAllowance,'+
    'actEmployeePayrollNewDeduction,'+
    'actEmployeeTaxList,'+
    'actEmployeePayrollTaxScales,'+

    'actEmployeePayrollPayHistory,'+
    'actEmployeePayrollAwards,'+
    'actEmployeePayrollAllowances,'+
    'actEmployeePayrollDeductions,'+
    'actEmployeePayrollBankCodes,'+
    'actReportsPayroll,'+

    'actEmployeePayrollPayRates,' +
    'actEmployeePayrollEmployeeServices,'+
    'actEmployeePayrollPAYGSummary,'+

    'actUSPayrollforms';
//    'actEmployeePayrollCompanyPayrollInfo';
//    'actEmployeePayrollTimeSheetList,'+
//    'actEmployeePayrollTimeSheet';


  DEFAULT_ACTIONS_ACCOUNTS_AUS_NZ =
    'actAccountsAccount,'+
    'actReportsBAS,'+
    'actAccountsJournalEntry,'+
    'actCashFlowForecast,'+
    'actAccountsProfitAndLoss,'+
    'actAccountsBalanceSheet,' +

    'actAccountsAccountsList,'+
    'actReportsBASList,'+
    'actAccountsJournalEntryList,'+
    'actCashFlowStatement,'+
    'actAccountsTrialBalance,'+
    'actAccountrunningBalance,' +

    'actReportsAccountsSummary,'+
    'actmainDashboard,'+
    'actPaymentsTransactionJournal,'+
    'actProfitnLosschart,'+
    'actProfitnLosschartgrossProfit,'+
    'actReportsAccounts,'+

    'actProfitnLosschartCompareGrossMonth,'+
    'actProfitnLosschartCompareGrossQuarter,'+
    'actProfitnLosschartCompareGrossYear,'+
    'actummarySheets'
    {$IFDEF DevMode}
    +',actInventoryAsset' +
    ',actUnInvoicedPOList'+
    ',actCustomAccountsReportTree'+
    ',actCustomAccountsReport'
    {$ENDIF}
    ;

  DEFAULT_ACTIONS_ACCOUNTS_UK =
    'actAccountsAccount,'+
    'actReportsBAS,'+
    'actAccountsJournalEntry,'+
    'actCashFlowForecast,'+
    'actAccountsProfitAndLoss,'+
    'actAccountsBalanceSheet,' +

    'actAccountsAccountsList,'+
    'actReportsBASList,'+
    'actAccountsJournalEntryList,'+
    'actCashFlowStatement,'+
    'actAccountsTrialBalance,'+
    'actAccountrunningBalance,' +

    'actReportsAccountsSummary,'+
    'actmainDashboard,'+
    'actPaymentsTransactionJournal,'+
    'actProfitnLosschart,'+
    'actProfitnLosschartgrossProfit,'+
    'actReportsAccounts,'+

    'actProfitnLosschartCompareGrossMonth,'+
    'actProfitnLosschartCompareGrossQuarter,'+
    'actProfitnLosschartCompareGrossYear,'+
    'actummarySheets,' +
    'actVATObligationList'
    {$IFDEF DevMode}
    +',actInventoryAsset' +
    ',actUnInvoicedPOList'+
    ',actCustomAccountsReportTree'+
    ',actCustomAccountsReport'
    {$ENDIF}
    ;

  DEFAULT_ACTIONS_ACCOUNTS_OTHERS =
    'actAccountsAccount,'+
    'actReportsAccountsSummary,'+
    'actAccountsJournalEntry,'+
    'actCashFlowForecast,'+
    'actAccountsProfitAndLoss,'+
    'actAccountsBalanceSheet,' +

    'actAccountsAccountsList,'+
    'actmainDashboard,'+
    'actAccountsJournalEntryList,'+
    'actCashFlowStatement,'+
    'actAccountsTrialBalance,'+
    'actAccountrunningBalance,' +

    'actProfitnLosschartCompareGrossMonth,'+
    'actProfitnLosschartCompareGrossQuarter,'+
    'actProfitnLosschartCompareGrossYear,'+
    'actProfitnLosschart,'+
    'actProfitnLosschartgrossProfit,'+
    'actReportsAccounts,'+

    'actPaymentsTransactionJournal,'+
    'actummarySheets'
    {$IFDEF DevMode}
    +',actInventoryAsset' +
    ',actUnInvoicedPOList'+
    ',actCustomAccountsReportTree'+
    ',actCustomAccountsReport'
    {$ENDIF}
    ;

  DEFAULT_ACTIONS_WORKFlow = 'actStartRecording,'+
                            'actStoprecording,'+
                            'actCancelrecording,'+
                            'actWorkflows,'+
                            'actImportWorkflow,'+
                            'actExportAllWorkflows';

  DEFAULT_ACTIONS_WooCommerce = 'actInt_WoocommCustomers,'+
                                'actWoocommitems,'+
                                'actWooCommerceInvoices' ;

  DEFAULT_ACTIONS_QuickBooks  = 'actQuickbooksSynchList,'+
                                'actInt_QuickBooks';
  DEFAULT_ACTIONS_EDISynch  =   'actint_CoreEDIService'    +','+
                                'actint_CoreEDIService_Help' + ','+
                                'actEDIConnectionsList';
  DEFAULT_ACTIONS_Magento     = 'actMagentoOrders,'+
                                'actMagentoProducts,'+
                                'actMagentoCustomers';

  DEFAULT_ACTIONS_AvaTax     = 'actint_AvaTax';

  DEFAULT_ACTIONS_WALMART  = 'actInt_WalMartOrders,' +
                             'actWalmartitems,' +
                             'actWalmartSalesOrders,' +
                             'actwalmartshippingmethods,' +
                             'actInt_WalMart,' +

                             'actInt_WalmartFeeds,' +
                             'act_Making_a_new_product_in_Walmart,' + // action is dynamically crated for the help document
                             'act_Walmart_Intergeration_in_ERP';

                             (*'actInt_WalMartOrders,' +
                             'actWalmartitems,' +
                             'actWalmartSalesOrders,' +
                             'actwalmartshippingmethods,'+
                             'actInt_WalmartFeeds,'+
                             'actInt_WalMart';*)

  DEFAULT_ACTIONS_EBAY    =  'actEBayOrders,'+
                             'actEBaySalesOrders,' +
                             'actInt_Ebay,'+
                             'act_Ebay_on_ERP,'+
                             'act_Ebay_Registration';

  DEFAULT_ACTIONS_AMAZON  = 'actAmazonEdiOrderList,' +
                            'actAmazonSalesOrderExpressList,' +
                            'actAmazonInvoiceExpressList,' +
                            'actInt_Amazon,'+
                            'act_Amazon_Intergration';


  (*DEFAULT_ACTIONS_EDI  = 'actInt_WalMartOrders,' +
                             'actWalmartitems,' +
                             'actWalmartSalesOrders,' +
                             'actwalmartshippingmethods,'+
                             'actInt_WalMart,'+

                             'actEBayOrders,'+
                             'actEBaySalesOrders';*)


  DEFAULT_ACTIONS_HIRE =
                            'actFixedAssetsFixedAsset, ' +
                            'actDuration,'+
                            'actHire,'+
                            'actHireListDetails,' +
                            'actHireItemDetails,'+
                            'actSetupHire,'+

                            'actFixedAssetsFixedAssetsList, ' +
                            'actDurationList,'+
                            'actHireList,'+
                            'actHireAvailability,'+
                            'actHireHistory,'+
                            'actHirePlanner,'+

                            'actStockToAsset,'+
                            'actStockToAssetList';

  DEFAULT_ACTIONS_WORKSHOP = 'actInventProductsProduct,'+
                            'actNewRepair,'+
                            'actNewRepairfault,'+
                            'actmanufacture,'+
                            'actEquipment,'+
                            'actSalesCustomersCustomerList,'+

                            'actInventProductsProductsExpressList,'+
                            'actRepairsExpressLsit,'+
                            'actRepairfaults,' +
                            'actManufactureList,'+
                            'actEquipmentList, '+
                            'actReportsWorkShop,'+

                            'actClientEquipmentlist,'+
                            'actRepairListInvocie,'+
                            'actEmpCalendar,'+
                            'actRepairSummary' ;



  DEFAULT_ACTIONS_TOOLBAR = 'actPaymentsAccountsReceivableReport,'+
                            'actSalesSalesBackOrders,' +
                            'actApptMainCalendar,'+
                            'actSalesCustomersCustomerList,'+
                            'actEmployeeGlobalList,' +
                            'actSalesCRMOtherContactsList,'+

                            'actSalesPOSPOSScreen,'+
                            'actInventProductsProductsList,' +
                            'actSalesQuotesQuote,'+
                            'actSalesSalesSalesReport,'+
                            'actPurchasesSuppliersSupplierList,' +
                            'actEmployeeToDoList,'+

                            'actEmployeeAccessLevels';

  DEFAULT_ACTIONS_UTILITIES =
                            'actUtilsSetupDocsPath,'+
//                            'actLinkTo,' +
                            'actUtilsDbUtilsOptimise,'+
                            'actUtilsDbUtilsBackup,'+
                            'actUtilsDbUtilsRestore,'+
                            'actUtilsAuditTrailAuditTrailList,'+
                            'actUtilsPreferences,'+

                            'actPickingSlipList,' +
                            'actDeliveryDocketList,' +
                            'actPurchaseOrderAudit,'+
                            'actUtilsCompanyInformation,'+
                            'actScheduledReports,'+
                            'actERPChanges,'+

//                            'actSiteIntegrationReport,' +

                            'actEmailList,'+
                            'actSMSList,'+
                            'actCustomImports,'+
                            'act_How_To_Upload_Backup,'+
                            'act_How_To_Install_Test_Server,'+
                            'actReportsUtilities,'+

                            'act_How_To_Setting_Up_Offsite_Backups,' +
                            'actAuseParcelconf';


  DEFAULT_ACTIONS_CRM =     'actSalesCRMOtherContacts,'+
                            'actSalesCRMCanvasser,'+
                            'actSource,'+
                            'actSalesCRMMailMerge,'+
                            'actSalesCRMLoyaltyProgram,'+
                            'actCar,'+

                            'actSalesCRMOtherContactsList,'+
                            'actSalesCRMCanvasserList,'+
                            'actApptsSourceList,'+
                            'actMailMergeHistory,'+
                            'actInventProductsProductRewardPointsList,'+
                            'actCarList,' +

                            'actMarketingRatios,'+
                            'actSalesRatios,'+
                            'actSalesPipeline,'+
                            'actRewardPoints,'+
                            'actRewardPointsDueToExpireGUI,'+
                            'actReportsCRM,'+

                            'actsalesDashboard,'+
                            'actApptsFeedbackReport,'+
                            'actsalesAnalysisGraph,'+
                            'act_How_To_Create_and_Use_Leads';


  DEFAULT_ACTIONS_MARKETING ='actMarketingContact,'+
                             'actContactSelectionRange,'+
                             'actMarketing,actLead,'+
                             'actSalesCRMOtherContacts,'+
                             'actSalesAnalysis,'+
                             'actMarketingContactList,'+

                             'actContactSelectionRangeList,'+
                             'actMarketingList,'+
                             'actLeadList,actSalesCRMOtherContactsList,'+
                             'actSalesAnalysisList,'+
                             ' actReminderPrn,'+
                             'actMarketingContactListDetail,'+

                             'actMarketingRatios,'+
                             'actSalesRatios,'+
                             'actSalesPipeline, '+
                             'actMarketingReports,'+
                             'actsalesAnalysisGraph,'+
                             'actsalesDashboard,'+

                             'act_How_To_Create_and_Use_Leads';

  DEFAULT_ACTIONS_GENERAL = 'actAccountsShipping,'+
                            'actAccountsDepartment,'+
                            'actAccountsForeignExchangeRate,'+
                            'actAccountsTaxCodeList,'+
                            'actCar,'+ // this option was removed and dene has asked to add it back
                            'actReportsTemplates,' +

                            'actAccountsShippingList,'+
                            'actAccountsDepartmentsList,'+
                            'actAccountsForeignExchangeRatesList,'+
                            'actAccountsTermsList,'+
                            'actEmployeeGlobalList,'+
                            'actSimpleTypes,'+

                            'actCarList,'+  // this option was removed and dene has asked to add it back
                            'actUtilsLocations,'+
                            'actWindowCustomiseToolbar,'+
                            'actAccountsMemorisedTransactionList,'+
                            'actFileImportAPI,'+
                            'actReportsGeneral,' +

                            'actERPPDFDocs, '+
                            'actHRForms,' +
                            'act_How_To_Fixed_Dollar_Excise_Taxes';

  DEFAULT_ACTIONS_PRICESCHEME='actProductFormulaCreator,' +
                              'actProductFormulaType,' +
                              'actProductFormulaEntry,'+
                              'actProductAttributes,'+
                              'actPriceLists,'+
                              'actPriceMatrixHelp,'+

                              'actProductFormulaList,'+
                              'actProductformulaTypeList,'+
                              'actProdAttribTemplateFields,'+
                              'actProdAttribTemplateFieldsdetails,'+
                              'actPriceSchemeList,'+
                              'actPriceSchemeReports';


  DEFAULT_ACTIONS_MANUFACTURING_SETUP = 'actProcessSteps,' +
                                        'actResource,'+
                                        'actManufactureProductList,'+
                                        'actEmpResProcRoster,'+
                                        'actResourceUnAvailability,'+
                                        'actProcPreferences,'+


                                    {2} 'actprocessstepList,' +
                                        'actResourceList,' +
                                        'actInventProductsProductsExpressList,'+
                                        'actBOMSetup,'+
                                        'actManufacturingReports,'+
                                        'act_How_To_Set_Up_Manufacturing';

  DEFAULT_ACTIONS_MANUFACTURING = 'actBarCodeManufacturing,'+
                                  'actCapacityPlanning,' +
                                  'actEmpResProcRosternSchedule,'+
                                  'actSimpleWorkOrder,'+
                                  'actWorkOrdertimeSheet,'+
                                  'actWastagereport,'+

                                  'actOrderStatus,'+
                              {2} 'actProductionOrders,'+
                                  'actCapacityPlanningonGanttchart,'+
                                  'actEmployeeJobStatus,'+
                                  'actWorkOrders,'+
                                  'actProductionJobStatusDetails,' +

                                  'actProcProgress,'+
                                  'actProcessJobListing,' +
                              {3} 'actBOMWorkOrdersSummary,'+
                                  'actOrdersFromStock,' +
                                  'actStowAwayList,'+
                                  'actManufacturingReports,'+

                                  'act_How_To_Set_Up_Manufacturing,' +
                              {4} 'actBOMProgressbuilds,' +
                                  'actBOMSalesList,'+
                                  'actRosterBreakList';





 DEFAULT_ACTIONS_BUDGET=  'actBudgetDefinition,' +
                          'actBudget,' +
                          'actBudgetProfitAndLossReport,'+
                          'actBudgetAccountList,' +
                          'actBudgetVariation,' +
                          'actReportsBudget,' +

                          'actBudgetDefinitionList,' +
                          'actBudgetList,' +
                          'actBudgetvsActual,' +
                          'actJobBudgetVsActual';

  DEFAULT_ACTIONS_APPOINTMENTS =  'actApptMainCalendar, ' +
                                  'actApptsNewAppointment, ' +
                                  'actApptsCustomersOnSupportList, ' +
                                  'actTask,'+
                                  'actUtilsPublicHolidays, ' +
                                  'actApptsPrintAppointments,' +

                                  'actProjectInstallations, ' +
                                  'actApptsAppointmentsList, ' +
                                  'actApptsPhoneSupportLogList,'+
                                  'actTaskList,' +
                                  'actApptsPhoneSupport, '+
                                  'actReportsAppointments,'+

                                  'act_How_To_Create_an_Appointment,'+
                                  'act_How_To_Create_a_Support_Log,'+
                                  'act_How_To_Finish_a_Support_Log,'+
                                  'act_How_To_Add_A_Task,'+
                                  'act_How_To_Add_Employee_to_Calendar';

  DEFAULT_ACTIONS_FIXEDASSETS = 'actFixedAssetsFixedAsset, ' +
                                'actFixedAssetsFixedAssetType, ' +
                                'actFixedAssetsServiceLog,  ' +
                                'actAssetRegisterList,' +
                                //'actStockToAsset,'+
                                'actFixedAssetsCheckWarrantiesInsurancePolicy,'+
                                'actReportsFixedAssets, ' +
                                'actFixedAssetsFixedAssetsList, ' +
                                'actFixedAssetsFixedAssetTypesList,'+
                                'actFixedAssetsServiceLogList,' +
                                'actStockToAssetList' ;


  DEFAULT_ACTIONS_BANKING = 'actPaymentsAccountsReceivableReport, ' +
                            'actPaymentsDepositEntry, ' +
                            'actPaymentsCheque, ' +
                            'actPaymentsChequePrn, ' +
                            'actPaymentsReconcile, ' +
                            //'act_How_To_Create_and_Use_Cheque, ' +
                            'actPaymentsBankAccountReport,' +

                            'actPaymentsAccountsPayableReport, ' +
                            'actPaymentsDepositedList, ' +
                            'actPaymentsChequeList,' +
                            'actPaymentsToBeDeposited, ' +
                            'actPaymentsReconciliationList, ' +
                            'actReportsBanking, ' +

                            'act_Create_and_use_cheques,'+
                            'actPaymentsEFT';


  DEFAULT_ACTIONS_GOOGLE =  'actGoogleAnalyticReport_Language,'+
                            'actGoogleAnalyticReport_Location,'+
                            'actGoogleAnalyticReport_Browser,'+
                            'actAnalyticsSummaryList,'+
                            'actGoogleAnalysisReport_Summary,'+
                            'actGoogleAnalytic_Summary,'+

                            'actGoogleAnalyticReport_Campaign,'+
                            'actGoogleAnalyticReport_keyword,'+
                            'actGoogleAnalyticReport_DayofWeek,'+
                            'actAnalyticsDetailList,'+
                            'actAnalyicreports,'+
                            'actreportsGoogle,'+

                            'actGoogleanalysisCost';

  DEFAULT_ACTIONS_INTEGRATION = 'actInt_Amazon,'+
                                'actInt_ATO,'+
                                'actInt_AustPostParcel,'+
                                'actint_AvaTax,'+
                                'actInt_CanadaPost,' +
                                'actInt_CustomerPortal,' +

                                'actInt_Cytrack,' +
                                'actInt_Ebay,' +
                                'actInt_Eftpos,' +
                                'actInt_Endica,'+
                                'actInt_ePadLink,'+
                                'actInt_Erico,' +

                                'actInt_ERPAPI,'+
                                'actInt_FedEx,' +
                                'avtInt_Fuel,' +
                                'actInt_GoogleAnalytics,' +
                                'actInt_GoogleCalendar,' +
                                'actInt_HMRC,'+

                                'actint_Magento,'+
                                'actInt_OPOS,' +
                                'actInt_Payeezy,'+
                                'actInt_PaymentExpress,'+
                                'actInt_PNET,' +
                                'actInt_QuickBooks,'+

                                'actInt_Seagate,'+
                                'actInt_Scanner,'+
                                'actInt_ShoppingCart,' +
                                'actInt_SMS,' +
                                'actImportSolidWorksBOM,'+
                                'actInt_Sony,'+

                                'actint_SPS,'+
                                'actInt_Stamps,'+
                                'actInt_Stripe,'+
                                'actInt_Target,'+
                                'actInt_Telstra,' +
                                'actInt_TNT,' +

                                'actInt_UPS,' +
                                'actInt_USPS,' +
                                'actInt_VAT,'+
                                'actInt_WalMart,'+
                                'actInt_Web,' +
                                'actInt_Woocommerce,'+

                                'actInt_XML';
  DEFAULT_ACTIONS_ERPCustomOptions =  'actClientTreeList,'+
                          'actMasterSMSConfig,'+
                          'actERPClientList,'+
                          'actGetClientMessageData,'+
                          'actClientServerLog,'+
                          'actMessageCostList,'+

                          'actCreateSO,'+
                          'actERPOffices,'+
                          'actTrainingVideoConfiguration,'+
                          'actHelpDocConfiguration';

  DEFAULT_ACTIONS_Vs1CustomOptions = 'actvs1ClientList,'+
                                     'actVS1LicenseLevelsnModules,'+
                                     'actVs1DatabaseList,'+
                                     'actVS1AdminDBconfig,'+
                                     'actWebAPITest,'+
                                     'actVS1Test,'+
                                     'actClientARListGUI';

  DEFAULT_ACTIONS_StS     =  'actStrain,'+
                             'actStSClass,'+
                             'actStsTagOrder,'+
                             'actStSMain,'+
                             'actStsHarvest,'+
                             'actint_StS,'+

                             'actStSStrains,'+
                             'actStSClassList,'+
                             'actStsTagOrders,'+
                             'actStSTags,'+
                             'actStsHarvestList,'+
                             'actStSReport,'+

                             'actStSProductQtyList,'+
                             'actStsTagGrowthHistory,'+
                             {$IFDEF DevMode}'actShowTagReports,'+{$ENDIF}
                             'actStSRooms,'+
                             {$IFDEF DevMode}'actWebAPITest,'+{$ENDIF}
                             'actStsTagActivityLog,' +
                             'actStsNewHarvestPackage,' +
                             'actStsNewAnotherPackage,' +
                             'actStsPackageList,' +
                             'actStsTransferPackage' +
                             'actStsTransferPackageList';

  DEFAULT_ACTIONS_StSSupplier = 'actStSTagsofStSSupplier';

  REPORT_GROUP_ACCOUNTS      = ' Accounts';
  REPORT_GROUP_APPOINTMENTS  = ' Appointments';
  REPORT_GROUP_BANKING       = ' Banking';
  REPORT_GROUP_BUDGET        = ' Budget';
  REPORT_GROUP_CRM           = ' CRM';
  REPORT_GROUP_EMPLOYEE      = ' Employee';
  REPORT_GROUP_FIXED_ASSETS  = ' Fixed Assets';
  REPORT_GROUP_GENERAL       = ' General';
  REPORT_GROUP_GOOGLE        = ' Google';
  REPORT_GROUP_INVENTORY     = ' Inventory';
  REPORT_GROUP_JOBS          = ' Jobs';
  REPORT_GROUP_MARKETING     = ' Marketing';
  REPORT_GROUP_MANUFACTURING = ' Manufacturing';
  REPORT_GROUP_Assessment    = ' Assessment';
  REPORT_GROUP_PAYMENTS      = ' Payments';
  REPORT_GROUP_PAYROLL       = ' Payroll';
  REPORT_GROUP_POS           = ' POS';
  REPORT_GROUP_PRICE_SCHEMES = ' Price Schemes';
  REPORT_GROUP_PURCHASES     = ' Purchases';
  REPORT_GROUP_SALES         = ' Sales';
  REPORT_GROUP_UTILITIES     = ' Utilities';
  REPORT_GROUP_WORKSHOP      = ' Workshop';
  REPORT_GROUP_TRAINING      = ' Training';
  REPORT_GROUP_WORKFLOW      = ' Workflow';
  REPORT_GROUP_HIRE          = ' Hire';
  REPORT_GROUP_SeedToSale    = ' Seed To sale';


  SALES_ORDER_COPY_TO_INVOICE = 'SalesOrderCopyToInvoice';

  cPrefGroupCustomFields = 'CustomFields';
  cPackcountField = 'Packcount';
  cPackWeightfieldField = 'PackWeightfield';

  PAY_CASH  = 'Cash';
  PAY_SPLIT = 'Split';

 { LockMsg Const }
  LockMsgReconcileHold      = 'Reconcile On Hold';
  LockMsgReconciled         = 'Reconciled';
  LockMsgClosingDate        = 'Before Closing Date';
  LockMsgAlteredTrans       = 'Original transaction(s) altered';
  LockMsgInUse              = 'Users accessing required transaction(s)';
  LockMsgDeletedPayment     = 'Deleted Payment';
  LockMsgDeletedBankDeposit = 'Deleted Bank Deposit';
  LockMsgApplied            = 'Applied';
  LockMsgDeposited          = 'Deposited';
  LockMsgDeletedPrepayment  = 'Deleted Prepayment';
  govtalkgovuk_CM_envelope  = 'http://www.govtalk.gov.uk/CM/envelope';
  LockMsgDelPriceMtxProduct = 'DeletePriceMatrixProduct';
Const

  {Colours}
  GridColHighLightDarkGreen = $00B3FFB3;
  GridColhighLightGreen     = $00D9FFD9;
  GridColhighLightYellow1   = $00CCFFFF;
  GridColhighLightYellow2   = $00CCFFF0;
  GridColhighLightBlue      = $00FFE9D2;
  GridColhighLightRed       = $00D2D2FF;
  GridColhighLightOrange    = $00B0CAFF;
  GridColhighLightPurple    = $00FFBFDF;
  GridColhighLightNavy      = $00FEBAA9;

  GridcolInactive         = clDkGray;
  GridColBrushInactive    = $00D6D3D6;
  GridColFontRed          = clRed;
  GridColFontBlue         = clblue;
  GridColFontBlack        = clBlack;
  GridColFontGreen        = clGreen;
  GridColFontOlive        = clOlive;
  Color_Yellow            = clyellow;
  Color_White             = clWhite;
  Color_Navy              = clNavy;


  Default_ColourAlternatingRow = 10944511;
  Default_ColourERPSingle      = 16777215;
  Default_ColourERPButton      = 8388608;
  Default_ColourERPButtonFont  = 16777215;
  Default_ColourERPButtonHT    = 14248960;

  Default_ColourAlternatingRowgreen = 10944511;
  Default_ColourERPSinglegreen      = 16777215;
  Default_ColourERPButtongreen      = 13056;
  Default_ColourERPButtonFontgreen  = 10092543;
  Default_ColourERPButtonHTgreen    = 6723891;

  Default_projectFortasks = 'Default';

  Inactivefontcolor =  $00BCBCBC;

  ErpLanguageDBName       = 'ErpLanguages';
  ErpservicesDBName       = 'services';
  erpdocumentationDBNAme  ='erpdocumentation';
  erpnewdbDBNAme          ='erpnewdb';
  mysqlDBNAme             ='mysql';
  ServerUpdatesDBNAme     ='ServerUpdates';
  InformationSchemaDBNAme ='InformationSchema';
(*  VS1ClientdbDBName       = 'vs1_clientdb_admin'; // used for VS1 for non-db requests,
                                            // its stored in the VS1 license table - tblvs1_clientdbservers,
                                            // GREP for AdminDB and AdminUser  for usage*)
  GeneralRoundPlaces = 5;
  SameValue_GeneralRound = 0.000005;
  OtherRoundPlaces = 2;
  MaxRecordsToGenerate = 1000;
  ERPPopupInterval = 2*60*60*1000;  { 2 hours }
  ERPPopupIntervalDevmode         = 2*60*60*1000;  { 2 hours }
  ItearteProcno4ValidateSelection = 1001;
  ItearteProcno4ExportToSQL       = 1002;
  ItearteProcno4AddSelectedRecords= 1003;
  IDForallOther                   = 99999999;
  MENU_BUTTON_COLOR: TColor      = clWhite;

  MENU_BUTTON_WIDTH   = 110;
  MENU_BUTTON_HEIGHT  = 95;
  MENU_BUTTON_SPACE_X = 18;
  MENU_BUTTON_SPACE_Y = 10;
  MENU_MIN_OFFSET_X   =   MENU_BUTTON_SPACE_X +   MENU_BUTTON_WIDTH;
  MENU_MIN_OFFSET_Y   =   MENU_BUTTON_SPACE_Y +   MENU_BUTTON_HEIGHT;
  MENU_FORM_HEIGHT    = MENU_MIN_OFFSET_Y*5 +160;
  MENU_FORM_MIN_HEIGHT    = MENU_MIN_OFFSET_Y +160;


  LARGE_FONT_SIZE = 18;

  UOT_HOUR  = 1;
  UOT_DAY   = 2;
  UOT_WEEK  = 3;
  UOT_MONTH = 4;
  UOT_YEAR  = 5;

  cCustomFieldsMax       = 10;

  GRIDBUTTONWHITE  = $00FEFEFE;

  BOOL_STR_SHORT: TBoolStr = ('F', 'T');
  PRODUCT_ID_NONE          = 0;

  RoundPlacesforeigncurrency = 2;

  NL = Chr(13) ;
  NLnLF= Chr(10)+Chr(13) ;
  DOUBLE_FIELD_MASK = '#,###,###,###,###,##0.00';
  DOUBLE_FIELD_MASK_BLANK = '#,###,###,###,###,###.##';
  QTY_FIELD_MASK = '#,###,###,###,###,##0.00000';

  TAG_MASK_PT  = $01;  // Used for personal tabs
  TAG_MASK_PTS = $02;  // Used for personal tabs shapes
  TAG_MASK_CG  = $04;  // Used for customise grids
  TAG_MASK_FC  = $08;  // Used for foreign currency calculated fields
  TAG_MASK_DC  = $10;   // used for Default Currency fields - when is dynamic for departments, eg: Profit N loss

  cDefaultGradientColor = $ADCF9C;
  cAdjustLuma = 50;
  cMaxColorMap = 25;

  MYSQL_FIELDS: array[TMySQLField] of string = ('TINYINT',
    'SMALLINT',
    'MEDIUMINT',
    'INT',
    'INTEGER',
    'BIGINT',
    'REAL',
    'DOUBLE',
    'FLOAT',
    'DECIMAL',
    'NUMERIC',
    'DATE',
    'TIME',
    'TIMESTAMP',
    'DATETIME',
    'CHAR',
    'VARCHAR',
    'TINYBLOB',
    'BLOB',
    'MEDIUMBLOB',
    'LONGBLOB',
    'TINYTEXT',
    'TEXT',
    'MEDIUMTEXT',
    'LONGTEXT',
    'ENUM',
    'SET');

  PRODUCT_QTY_FIELDS: array[TProductQty] of string = ('InStockQty',
    'SalesOrdersQty',
    'InvoiceBOQty',
    'OnOrderQty',
    'ReorderPoint',
    'PreferredLevel',
    'ReOrderAmount',
    'SalesOrderBOQty',
    'OnLaybyQty',
    '*');
 (* cColorMapping: array[1..cMaxColorMap] of TColorMapRec = ((Name: 'General'         ; Color: $00FF6666; AdjLuma: 60),
                                                           (Name: 'Appointments'    ; Color: $0055AAFF; AdjLuma: 20),
                                                           (Name: 'Accounts'        ; Color: $008C8C46; AdjLuma: 60),
                                                           (Name: 'CRM'             ; Color: $00FF88C4; AdjLuma: 20),
                                                           (Name: 'Employee'        ; Color: clYellow ; AdjLuma: 90),
                                                           (Name: 'SalesOrder'      ; Color: $002881F9; AdjLuma: 60),
                                                           (Name: 'Purchases'       ; Color: $00145F69; AdjLuma: 60),
                                                           (Name: 'FixedAssets'     ; Color: $00C08000; AdjLuma: 60),
                                                           (Name: 'Sales'           ; Color: $004080FF; AdjLuma: 60),
                                                           (Name: 'Miscellaneous'   ; Color: $00FB37C5; AdjLuma: 60),
                                                           (Name: 'Returns'         ; Color: $00808040; AdjLuma: 60),
                                                           (Name: 'Manufacturing'   ; Color: $00404080; AdjLuma: 60),
                                                           (Name: 'Payroll'         ; Color: $00797900; AdjLuma: 60),
                                                           (Name: 'Inventory'       ; Color: $00C18300; AdjLuma: 60),
                                                           (Name: 'Utilities'       ; Color: $00D56A00; AdjLuma: 60),
                                                           (Name: 'MainBackground'  ; Color: $00FF6666; AdjLuma: 60),
                                                           (Name: 'Training'        ; Color: $00408000; AdjLuma: 60),
                                                           (Name: 'Banking'         ; Color: $0077870A; AdjLuma: 60),
                                                           (Name: 'Delivery'        ; Color: $00564480; AdjLuma: 60),
                                                           (Name: 'Payments'        ; Color: $000049E1; AdjLuma: 60),
                                                           (Name: 'POS'             ; Color: clYellow ; AdjLuma: 90),
                                                           (Name: 'Repairs'         ; Color: $009D4F00; AdjLuma: 60)
                                                           );*)
  cColorMapping: array[1..cMaxColorMap] of TColorMapRec =  ((Name: 'Accounts';Color: $008C8C46; AdjLuma: 80),
                                                            (Name: 'Appointments';Color: $0055AAFF; AdjLuma: 20),
                                                            (Name: 'Banking';Color: $00FFCC99; AdjLuma: 0),
                                                            (Name: 'CRM';Color: $00FF88C4; AdjLuma: 20),
                                                            (Name: 'Delivery';Color: $00564480; AdjLuma: 73),
                                                            (Name: 'EBay';Color: $000099FF; AdjLuma: 90),
                                                            (Name: 'Employee';Color: clYellow; AdjLuma: 90),
                                                            (Name: 'FixedAssets';Color: $00C08000; AdjLuma: 97),
                                                            (Name: 'General';Color: $00FF6666; AdjLuma: 60),
                                                            (Name: 'Google';Color: $00FF6666; AdjLuma: 60),
                                                            (Name: 'Hire';Color: $00FFFFC6; AdjLuma: 60),
                                                            (Name: 'Inventory';Color: $00669933; AdjLuma: 77),
                                                            (Name: 'MainBackground';Color: $00FF6666; AdjLuma: 60),
                                                            (Name: 'Manufacturing';Color: clGray; AdjLuma: 78),
                                                            (Name: 'Miscellaneous';Color: $00C665CD; AdjLuma: 62),
                                                            (Name: 'Payments';Color: $00CCFFCC; AdjLuma: 0),
                                                            (Name: 'Payroll';Color: $00FF80FF; AdjLuma: 37),
                                                            (Name: 'POS';Color: $00FFCC99; AdjLuma: 0),
                                                            (Name: 'Purchases';Color: $00408080; AdjLuma: 48),
                                                            (Name: 'Repairs';Color: clSilver; AdjLuma: 0),
                                                            (Name: 'Returns';Color: $0099CCFF; AdjLuma: 22),
                                                            (Name: 'Sales';Color: $000099FF; AdjLuma: 83),
                                                            (Name: 'SalesOrder';Color: $002881F9; AdjLuma: 60),
                                                            (Name: 'Training';Color: $0099CCFF; AdjLuma: 0),
                                                            (Name: 'Utilities';Color: $0099FFFF; AdjLuma: 60));


  MYDAC_OPTIONS_COMPRESS = false;
  MYDAC_OPTIONS_PROTOCOL = mpDefault;

  { Functional area prefix's }

  faGenDataSet    = 0;
  faGeneral       = 20;

  faAccounts      = 1000;
  faFixedAssets   = 2000;
  faEmployee      = 3000;
  faSales         = 4000;
  faPurchases     = 5000;
  faInventory     = 6000;

  faAppoinyments  = 7000;
  faCRM           = 8000;
  faPayroll       = 9000;
  faUtilities     = 10000;
  faWorkshop      = 11000;
  faProduction    = 12000;  { Manufacturing }


  ACCOUNT_TYPE_BANK = 'BANK';
  ACCOUNT_TYPE_CREDIT_CARD = 'CCARD';
  ACCOUNT_TYPE_EXPENSE = 'EXP';

  CORRESPONDENCE_FIELD1 = 'Appointment Name';
  CORRESPONDENCE_FIELD2 = 'Appointment Date and Time';

// Splash screen Video File
  csSplashScreenVideoFile = 'Splash\TrueERP_Logo.wmv';
// Pos screen files path
  csPosVideoFiles = 'PosVideo\';
  csPOSVideoSection = 'VideoDelay';
  csPOSVideoIdent = 'DelaySeconds';
  csPosVideFilesCustomer = csPosVideoFiles + 'Customer\';
  csUseRatio = true;
  // POS Customer display file - moved from POSCustomerDisplay
  csCustomerDisplayFile = 'POSDisplay.ini';

 VS1LogEmailID  = {$IFDEF DevMode}'binny@erpoz.com'                 {$ELSE}'Support@erpoz.com' {$ENDIF};
 ERPEmailId     = {$IFDEF DevMode}'binny.jacobs@erpAustralia.com.au'{$ELSE}'Support@erpoz.com' {$ENDIF};
 CoreEDIEmailID = {$IFDEF DevMode}'binny.jacobs@erpAustralia.com.au'{$ELSE}'Support@erpoz.com'{$ENDIF};

//  ERPEmailId = 'andrei.gribanov@gmail.com';

  {Simple types}
  SimpleTypes_CompanyType                 = 'CompanyType';
  SimpleTypes_FollowUpType                = 'FollowUpType';
  SimpleTypes_FollowUpResultType          = 'FollowUpResultType';
  SimpleTypes_StatusType                  = 'StatusType';
  SimpleTypes_LeadStatusType              = 'LeadStatusType';
  SimpleTypes_RosterBreaks                = 'RosterBreaks';
  SimpleTypes_CustomerReturnStatus        = 'CustomerReturnStatus';
  SimpleTypes_OrderStatus                 = 'OrderStatus';
  SimpleTypes_ReturnAuthority             = 'ReturnAuthorityStatus';
  SimpleTypes_Credit                      = 'CreditStatus';
  SimpleTypes_Bill                        = 'BillStatus';
  SimpleTypes_cheque                      = 'ChequeStatus';
  SimpleTypes_SalesCategory               = 'SalesCategory';
  SimpleTypes_StSRoom                     = 'StSRoom';
  SimpleTypes_StSAction                   = 'StSAction';
  SimpleTypes_SalesDelDelayReason         = 'SalesDelDelayReason';
  SimpleTypes_AppointmentCancellationType = 'AppointmentCancellation';
  SimpleTypes_AppointmentStatusType       = 'AppointmentStatusType';
  SimpleTypes_LeadActionType              = 'LeadActionType';
  SimpleTypes_ShippingContainerStatusType = 'ShippingContainerStatusType';
  SimpleTypes_MessageType                 = 'MessageType';
  SimpleTypes_PhoneSupportType            = 'SupportType';
  SimpleTypes_RepairFault                 = 'RepairFault' ;
  SimpleTypes_PhoneSupportVersion         = 'SupportVersion';
  SimpleTypes_EmployeeSkillLevel          = 'EmployeeSkillLevel';
  simpletypes_CAR_Actiontype              = 'CAR Action type';
  simpletypes_CAR_Productionbuild         = 'CAR Productionbuild';
  simpletypes_CAR_ActionRequired          = 'CAR ActionRequired';
  simpletypes_CAR_PreventiveActionComments= 'CAR PreventiveActionComments';
  SimpleTypes_PhSupportStatusType         = 'PhoneSupportStatusType';
  SimpleTypes_BOM_WastageReason           = 'BOM_WastageReason';
  SimpleTypes_ProcresourceColour          = 'ProcresourceColour';

  SimpleTypes_CompanyType_Desc                 = 'Company Types';
  SimpleTypes_FollowUpType_Desc                = 'Follow-Up Types';
  SimpleTypes_FollowUpResultType_Desc          = 'Follow-Up Result Types';
  SimpleTypes_StatusType_Desc                  = 'Status Types';
  SimpleTypes_LeadStatusType_Desc              = 'Lead/Quote Status Types';
  SimpleTypes_PhSupportStatusType_Desc         = 'Phone Support Status';
  SimpleTypes_CustomerReturnStatus_Desc        = 'Customer Return Status';
  SimpleTypes_ShippingContainerStatusType_Desc = 'Ship Container Status';
  SimpleTypes_AppointmentStatusType_Desc       = 'Appointment Status';
  SimpleTypes_AppointmentCancellationType_Desc = 'Appointment Cancellation Reasons';
  SimpleTypes_SalesCategory_Desc               = 'Sales Category';
  SimpleTypes_StSRoom_Desc                     = STS_CAPTION+' - Rooms';
  SimpleTypes_StSAction_Desc                   = STS_CAPTION+' - Action';
  SimpleTypes_SalesDelDelayReason_Desc         = 'Delivery Delay Reasons';
  SimpleTypes_PhoneSupportType_Desc            = 'Support Type';
  SimpleTypes_PhoneSupportVersion_Desc         = 'Support Version';
  SimpleTypes_RepairFault_Desc                 = 'Repair Fault';
  simpletypes_CAR_Actiontype_Desc              = 'CAR - Action type';
  simpletypes_CAR_Productionbuild_Desc         = 'CAR - Production build';
  simpletypes_CAR_ActionRequired_Desc          = 'CAR - ACtion Required';
  simpletypes_CAR_PreventiveActionComments_Desc= 'CAR - Preventive Actions';
  SimpleTypes_OrderStatus_Desc                 = 'Order Status';
  SimpleTypes_ReturnAuthority_Desc             = 'Return Authority Status';
  SimpleTypes_Credit_Desc                      = 'Credit Status';
  SimpleTypes_Bill_Desc                        = 'Bill Status';
  SimpleTypes_cheque_Desc                      = 'Cheque Status';
  SimpleTypes_RosterBreaks_Desc                = 'Roster Breaks';
  SimpleTypes_LeadActionType_Desc              = 'Action Type';
  SimpleTypes_BOM_WastageReason_Desc           = 'BOM Wastage Reason';
  SimpleTypes_ProcresourceColour_Desc          = 'Colour';
  SimpleTypes_EmployeeSkillLevel_Desc          = 'Employee Skill Level';
  SimpleTypes_MessageType_Desc                 = 'Message Type';



  { Simple type actions }
  SimpleTypeAction_Invoice        ='Invoice';
  SimpleTypeAction_SmartOrder     ='Smart Order';
  SimpleTypeAction_Appointment    ='Appointment';
  SimpleTypeAction_NotesAdded     ='Notes Added';
  SimpleTypeAction_ProductAdded   ='Product Added';
  SimpleTypeAction_EquipmentAdded ='Equipment Added';
  SimpleTypeAction_TimesheetAdded ='Timesheet Added';
  SimpleTypeAction_FollowupAdded  ='Followup Added';


  LBstoKGs = 0.453592;
  KGstoLBs = 2.20462;
  CubicMeterToBroadFeet = 423.7760007;

{Walmart}
  vosOK = 1;
  vosNotValidated = 2;
  vosMultipleFxinLine =3;
  vosMultipleFxinOrder =4;
  vosFxVarriesinLinenTax =5;
  vosInvalidTaxCode= 6;
  vosInvalidProduct= 7;
  vosValidated = 8;

  WalmartOrderStatus_Created      ='Created';
  WalmartOrderStatus_Ordered      ='Ordered';
  WalmartOrderStatus_Acknowledged ='Acknowledged';
  WalmartOrderStatus_Cancelled    ='Cancelled';
  WalmartOrderStatus_ERPSOCreated ='ERP Order Created';
  WalmartOrderStatus_ERPBO        ='ERP Order Created-BO';
(*  WalmartOrderStatus_Reviewed     ='Reviewed';*)
  WalmartOrderStatus_Scheduled    ='Scheduled';
  WalmartOrderStatus_Built        ='Built';
  WalmartOrderStatus_Shipped      ='Shipped';
  WalmartOrderStatus_Invoiced      ='Invoiced';


  CUSTOMER_REQUESTED_SELLER_TO_CANCEL     = 'CUSTOMER_REQUESTED_SELLER_TO_CANCEL';
  SELLER_CANCEL_OUT_OF_STOCK              = 'SELLER_CANCEL_OUT_OF_STOCK';
  SELLER_CANCEL_CUSTOMER_DUPLICATE_ORDER  = 'SELLER_CANCEL_CUSTOMER_DUPLICATE_ORDER';
  SELLER_CANCEL_CUSTOMER_CHANGE_ORDER     = 'SELLER_CANCEL_CUSTOMER_CHANGE_ORDER';
  SELLER_CANCEL_CUSTOMER_INCORRECT_ADDRESS= 'SELLER_CANCEL_CUSTOMER_INCORRECT_ADDRESS';
  SELLER_CANCEL_FRAUD_STOP_SHIPMENT       = 'SELLER_CANCEL_FRAUD_STOP_SHIPMENT';
  SELLER_CANCEL_PRICING_ERROR             = 'SELLER_CANCEL_PRICING_ERROR';

  sCUSTOMER_REQUESTED_SELLER_TO_CANCEL     = 'Customer Cancelled';
  sSELLER_CANCEL_OUT_OF_STOCK              = 'Out of Stock';
  sSELLER_CANCEL_CUSTOMER_DUPLICATE_ORDER  = 'Duplicate Order';
  sSELLER_CANCEL_CUSTOMER_CHANGE_ORDER     = 'Changed Order';
  sSELLER_CANCEL_CUSTOMER_INCORRECT_ADDRESS= 'Incorrect Address';
  sSELLER_CANCEL_FRAUD_STOP_SHIPMENT       = 'Fraud Order';
  sSELLER_CANCEL_PRICING_ERROR             = 'Pricing Error';
{EDI}
  WALMART_CHECKORDERSINTERVAL = 1000 * 10; // 10 seconds - progress bar
  WOOCOMM_CHECKORDERSINTERVAL = 1000 * 10; // 10 seconds - progress bar
  MAGENTO_CHECKORDERSINTERVAL = 1000 * 10; // 10 seconds - progress bar
  MAGENTO_CHECKCUSTOMERSINTERVAL = 1000 * 1 * 300; // 5 mins - progress bar
  MAGENTO_CHECKPRODUCTSINTERVAL = 1000 * 1 * 300; // 5 mins - progress bar
  AvaTax_CHECKORDERSINTERVAL  = 1000 * 10; // 10 seconds - progress bar

  AvaTax_Sandbox_URL = 'https://ai-sbx.avlr.sh/account/login?returnUrl=%2'+
                       'Fconnect%2Fauthorize%2Fcallback%3Fresponse_type%3D'+
                       'code%26client_id%3Dcustomer-portal-sbx%26redirect_uri'+
                       '%3Dhttps%253A%252F%252Fsandbox.admin.avalara.com%252'+
                       'Fauth%252Fcallback%26scope%3Dopenid%2520avatax%2520'+
                       'openid%2520profile%2520offline_access';
  AvaTax_Production_URL = 'https://identity.avalara.com/account/login?'+
                       'returnUrl=%2Fconnect%2Fauthorize%2Fcallback%3Fresponse_type'+
                       '%3Dcode%26client_id%3Dcustomer-portal-prod%26redirect_uri%3'+
                       'Dhttps%253A%252F%252Fadmin.avalara.com%252Fauth%252Fcallback'+
                       '%26scope%3Dopenid%2520avatax%2520openid%2520profile%2520'+
                       'offline_access%26state%3Dhttps%253A%252F%252Fadmin.avalara.com'+
                       '%252Fcup%252Fa%252F1100039686%252Fusers%253FstemCompanyId%253D59820';


  SPECIALPASSWORD = 'mc3My&%!)';

  {conversions}

    //Non Metric to Metric
      SqFtToSqCM    = 929.03;
      SqFtToSqM     = 0.092903;
      SqinchtoSqM   = 0.00064516;
      SqinchtoSqcm  = 6.4516;
      FtToM         = 0.3048;
      FtTocM        = 30.48;
      InchToCM      = 2.54;
      inchtoM       = 0.0254;
  //Metric to Non Metric
      SqmtoSqF      = 10.7639;
      sqcmtosqf     = 0.00107639;
      sqcmtosqinch  = 0.155;
      sqmtosqin     = 1550;
      Mtoinch       = 39.3701;
      cmtoinch      = 0.393701;
      cmtofeet      = 0.0328084;
      mtoFeet       = 3.28084;


{Qty fieldnames}
  Instock_Qty_fieldname = 'Instock';
  Available_Qty_fieldname = 'Available';

type
  TRoundingArray = array [0..8] of integer;
const
 csRounding : TRoundingArray  = (-100, -10, -5, -1, 0, 1, 5, 10, 100);

implementation

end.

