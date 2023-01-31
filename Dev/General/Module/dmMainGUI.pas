
unit dmMainGUI;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 27/10/05 1.00.02  DSP  Added buttons for 'Allocate Job' and
                        'Job Allocation List' to 'Appointments'.
 02/11/05 1.00.03  MV   Added Employee Details Transfer option.
 29/11/05 1.00.04  DSP  Added AssignActionBitmap to several procedures.
 02/12/05 1.00.05  DSP  Replaced the use of '.Instance' to create forms with
                        GetComponentByClassName.
 16/12/05 1.00.06  MV   Added functionality to support Jobs list.
 19/01/06 1.00.07  DSP  Changed calls to BarcodeReader.
 27/01/06 1.00.08  DSP  Changed parameter values in calls in BarcodeReader.
 01/02/06 1.00.09  IJB  Added Appointments / Appointment Cancellation Reason.
 24/04/06 1.00.10  DSP  Added method actEmployeeAccessLevelsExecute as using
                        'AnyActionExecute' was causing exception errors for
                        this action.
 02/08/06 1.00.11  DSP  Added define for new preferences.
 22/08/06 1.00.12  DSP  Added Utilities2Click to hadle the enabling / disabling
                        of the AuditTrail2 menu item.
 30/08/06 1.00.13  DSP  Added in values to the Description property of the
                        TDNMAction components.
 11/09/06 1.00.14  DSP  Changed menu item caption 'Reset Customisation' to
                        'Reset Personal Tabs'.

}

{$I ERP.inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseGUIDatamodule, ActnList, Menus, ImgList, SelectionDialog,
  {VerifyFunctionsObj, }DNMAction, AdvMenus, AdvMenuStylers, MessageInterface,
  dmGUIStylers, wwDbGrid, BaseListingForm;


type
  TdtmMainGUI = class(TdtmGUI)
    ActionList: TActionList;
    actFileNewCompany: TDNMAction;
    actFileOpenCompany: TDNMAction;
    actFileImportData: TDNMAction;
    actFileImportTemplates: TDNMAction;
    actFileImportTNTClientRates: TDNMAction;
    actFileImportTNTPostcodeToRating: TDNMAction;
    actFileExportData: TDNMAction;
    actFileExportTemplates: TDNMAction;
    actApptMainCalendar: TDNMAction;
    actApptsPrintAppointments: TDNMAction;
    actApptsNewAppointment: TDNMAction;
    actApptsAppointmentsList: TDNMAction;
    actApptsNewSource: TDNMAction;
    actApptsSourceList: TDNMAction;
    actApptsNewJob: TDNMAction;
    actApptsJobList: TDNMAction;
    actApptsPhoneSupport: TDNMAction;
    actApptsFeedbackReport: TDNMAction;
    actApptsAppointmentsReport: TDNMAction;
    actApptsPhoneSupportLogList: TDNMAction;
    actApptsCustomersOnSupportList: TDNMAction;
    actSalesCustomersNewCustomer: TDNMAction;
    actSalesCustomersCustomerList: TDNMAction;
    actSalesCustomersCustomerAccountNoSetup: TDNMAction;
    actSalesCustomersClientType: TDNMAction;
    actSalesCustomersClientTypeList: TDNMAction;
    actSalesCustomersCustomerSummary: TDNMAction;
    actSalesCustomersCustomerDetailsList: TDNMAction;
    actSalesCRMOtherContacts: TDNMAction;
    actSalesCRMOtherContactsList: TDNMAction;
    actSalesCRMPhoneContact: TDNMAction;
    actSalesCRMPhoneContactList: TDNMAction;
    actSalesCRMCanvasser: TDNMAction;
    actSalesCRMCanvasserList: TDNMAction;
    actSalesCRMLoyaltyProgram: TDNMAction;
    actSalesCRMMailMerge: TDNMAction;
    actSalesJobsJobAnalysisBalanceReport: TDNMAction;
    actSalesJobsJobProfitability: TDNMAction;
    actSalesQuotesQuote: TDNMAction;
    actSalesQuotesQuoteList: TDNMAction;
    actSalesSalesOrdersSalesOrder: TDNMAction;
    actSalesSalesOrdersSalesOrderList: TDNMAction;
    actSalesSalesOrdersSalesOrderReport: TDNMAction;
    actSalesSalesInvoiceExpressList: TDNMAction;
    actSalesSalesInvoiceInternalOrderExpressList: TDNMAction;
    actCustomerReturnList: TDNMAction;
    actCustomerReturns: TDNMAction;
    actSalesSalesOrdersSalesOrderExpressList: TDNMAction;
    actSalesQuotesQuoteExpressList: TDNMAction;
    actSalesSalesCashSale: TDNMAction;
    actSalesSalesRefunds: TDNMAction;
    actSalesSalesInvoice: TDNMAction;
    actSalesSalesInvoiceList: TDNMAction;
    actSalesSalesBackOrders: TDNMAction;
    actSalesSalesSalesList: TDNMAction;
    actSalesPOSCustomisePOS: TDNMAction;
    actSalesPOSBarTabList: TDNMAction;
    actSalesPOSVouchersList: TDNMAction;
    actSalesPOSTillSummaryReport: TDNMAction;
    actSalesPOSTrafficList: TDNMAction;
    actSalesPOSTrafficSummaryReport: TDNMAction;
    actSalesPOSOrderProcessList: TDNMAction;
    actSalesManifestManifestAllocationList: TDNMAction;
    actSalesManifestManifest: TDNMAction;
    actSalesManifestManifestList: TDNMAction;
    actSalesManifestManifestListDetail: TDNMAction;
    actSalesManifestManifestVehicle: TDNMAction;
    actSalesManifestManifestVehicleList: TDNMAction;
    actSalesManifestManifestRoute: TDNMAction;
    actSalesManifestManifestRouteList: TDNMAction;
    actSalesPrintInvoices: TDNMAction;
    actSalesPrintSalesOrders: TDNMAction;
    actPurchasesSuppliersSupplier: TDNMAction;
    actPurchasesSuppliersSupplierList: TDNMAction;
    actPurchasesSuppliersSupplierExpressList: TDNMAction;
    actPurchasesSmartOrdersSmartOrder: TDNMAction;
    actPurchasesSmartOrdersSmartOrderList: TDNMAction;
    actPurchasesPurchaseOrdersPurchaseOrder: TDNMAction;
    actPurchasesPurchaseOrdersPurchaseOrderList: TDNMAction;
    actPurchasesPurchaseOrdersPurchaseOrderListDetail: TDNMAction;
    actPurchasesPurchaseOrdersPurchaseOrderExpressList: TDNMAction;
    actPurchasesPurchaseOrdersBackOrders: TDNMAction;
    actPurchasesBillsBill: TDNMAction;
    actPurchasesBillsBillRefund: TDNMAction;
    actPurchasesBillsBillList: TDNMAction;
    actPurchasesReturnAuthorityReturnAuthority: TDNMAction;
    actPurchasesReturnAuthorityReturnAuthorityList: TDNMAction;
    actInventProductsProduct: TDNMAction;
    actInventProductsProductsExpressList: TDNMAction;
    actProductsWithBlanknameList: TDNMAction;
    actInventProductsProductsExpressBatchbinSNList: TDNMAction;
    actInventProductsProductsList: TDNMAction;
    actInventProductPictureProductsList: TDNMAction;
    actInventProductsProductCommission: TDNMAction;
    actInventProductsProductCommissionList: TDNMAction;
    actInventProductsProductRewardPoints: TDNMAction;
    actInventProductsProductRewardPointsList: TDNMAction;
    actInventProductsBatchProductCreator: TDNMAction;
    actInventProductsBatchProductCodeAbbreviator: TDNMAction;
    actInventStockStockTransfer: TDNMAction;
    actInventStockStockTransferList: TDNMAction;
    actInventStockStockAdjustment: TDNMAction;
    actInventStockStockAdjustmentbatchList: TDNMAction;
    actInventStockStockAdjustmentbinList: TDNMAction;
    actInventStockStockAdjustmentsnLsit: TDNMAction;
    actInventStockStockAdjustmentbatch: TDNMAction;
    actInventStockStockAdjustmentBin: TDNMAction;
    actInventStockStockAdjustmentSN: TDNMAction;
    actInventStockStockAdjustmentList: TDNMAction;
    actInventStockStockTake: TDNMAction;
    actInventPriceUpdate: TDNMAction;
    actoldInventPriceUpdate: TDNMAction;
    actInventAutoReOrder: TDNMAction;
    actInventCustomerTypePriceList: TDNMAction;
    actInventCustomerPriceList: TDNMAction;
    actInventPrintPickSlips: TDNMAction;
    actInventBarcodePickingAssembly: TDNMAction;
    actInventBarcodePickingAssemblyList: TDNMAction;
    actInventPickedSalesList: TDNMAction;
    actInventPickSlipManifest: TDNMAction;
    actInventProductSales: TDNMAction;
    actInventProductSalesnotSold: TDNMAction;
    actInventUnitsOfMeasure: TDNMAction;
    actInventUnitsOfMeasureList: TDNMAction;
    actPaymentsCustomerPayment: TDNMAction;
    actPaymentsCustomerPaymentList: TDNMAction;
    actPaymentsCustomerPrepayment: TDNMAction;
    actPaymentsCustomerPrepaymentList: TDNMAction;
    actPaymentsBulkPaySuppliers: TDNMAction;
    actPaymentsReceivedBulkPayments: TDNMAction;
    actPaymentsCustomerPaymentExpressList: TDNMAction;
    actPaymentsSupplierPayment: TDNMAction;
    actPaymentsSupplierPaymentList: TDNMAction;
    actPaymentsSupplierPrepayment: TDNMAction;
    actPaymentsSuppPrepaymentList: TDNMAction;
    actPaymentsDepositEntry: TDNMAction;
    actPaymentsToBeDeposited: TDNMAction;
    actPaymentsDepositedList: TDNMAction;
    actPaymentsCheque: TDNMAction;
    actPaymentsChequeList: TDNMAction;
    actPaymentsReconcile: TDNMAction;
    actPaymentsReconciliationList: TDNMAction;
    actPaymentsStatements: TDNMAction;
    actPaymentsPrintStatements: TDNMAction;
    actPaymentsAccountsPayableReport: TDNMAction;
    actPaymentsAccountsReceivableReport: TDNMAction;
    actPaymentsBankAccountReport: TDNMAction;
    actPaymentsTransactionJournal: TDNMAction;
    actPaymentsTransactionJournalExpress: TDNMAction;
    actEmployeePayrollPayStaff: TDNMAction;
    actEmployeePayrollPayHistory: TDNMAction;
    actEmployeePayslist: TDNMAction;
    actEmployeePayrollNewAllowance: TDNMAction;
    actEmployeePayrollAllowances: TDNMAction;
    actEmployeePayrollNewAward: TDNMAction;
    actEmployeePayrollAwards: TDNMAction;
    actEmployeePayrollNewBankCode: TDNMAction;
    actEmployeePayrollBankCodes: TDNMAction;
    actEmployeePayrollNewDeduction: TDNMAction;
    actEmployeePayrollDeductions: TDNMAction;
    actEmployeePayrollNewPayRate: TDNMAction;
    actEmployeePayrollPayRates: TDNMAction;
    actEmployeePayrollNewTaxScale: TDNMAction;
    actEmployeePayrollTaxScales: TDNMAction;
    actEmployeePayrollImportTaxScales: TDNMAction;
    actEmployeePayrollLeaveAccruedList: TDNMAction;
    actEmployeePayrollLeaveTakenList: TDNMAction;
    actEmployeePayrollPayrollJobsList: TDNMAction;
    actEmployeePayrollEmployeeServices: TDNMAction;
    actEmployeeRep: TDNMAction;
    actEmployeeRepList: TDNMAction;
    actEmployeeToDo: TDNMAction;
    actEmployeeEmployee: TDNMAction;
    actEmployeeEmployeeAnalysis: TDNMAction;
    actEmployeeEmployeeList: TDNMAction;
    actEmployeeTerminateEmployee: TDNMAction;
    actEmployeeGlobalList: TDNMAction;
    actEmployeeRepServices: TDNMAction;
    actEmployeeRoster: TDNMAction;
    actEmployeeRosterList: TDNMAction;
    actEmployeeClockOn: TDNMAction;
    actEmployeeResetPersonalTabs: TDNMAction;
    actFixedAssetsFixedAsset: TDNMAction;
    actFixedAssetsFixedAssetsList: TDNMAction;
    actFixedAssetsFixedAssetType: TDNMAction;
    actFixedAssetsFixedAssetTypesList: TDNMAction;
    actFixedAssetsCheckWarrantiesInsurancePolicy: TDNMAction;
    actFixedAssetsServiceLog: TDNMAction;
    actFixedAssetsServiceLogList: TDNMAction;
    actAccountsAccount: TDNMAction;
    actAccountsAccountsList: TDNMAction;
    actAccountsAccountTypeList: TDNMAction;
    actAccountsDepartment: TDNMAction;
    actAccountsDepartmentsList: TDNMAction;
    actAccountsTaxCode: TDNMAction;
    actAccountsTaxCodeList: TDNMAction;
    actTaxCodeDetailList: TDNMAction;
    actAccountsTerms: TDNMAction;
    actAccountsTermsList: TDNMAction;
    actAccountsShipping: TDNMAction;
    actAccountsShippingList: TDNMAction;
    actAccountsForeignExchangeRate: TDNMAction;
    actAccountsForeignExchangeRatesList: TDNMAction;
    actAccountsForeignExchangeHistoryList: TDNMAction;
    actAccountsMemorisedTransactionList: TDNMAction;
    actAccountsJournalEntry: TDNMAction;
    actAccountsJournalEntryList: TDNMAction;
    actAccountsTrialBalance: TDNMAction;
    actAccountsBalanceSheet: TDNMAction;
    actAccountsProfitAndLoss: TDNMAction;
    actAccountsjobProfitAndLoss: TDNMAction;
    actAccountsProfitAndLossByPeriod: TDNMAction;
    actAccountsElectronicFundsTransfer: TDNMAction;
    actAccountsRefreshBatchTransaction: TDNMAction;
    actReportsAccounts: TDNMAction;
    actReportsAppointments: TDNMAction;
    actReportsBanking: TDNMAction;
    actEmployeeEmployeeSummary: TDNMAction;
    actReportsFixedAssets: TDNMAction;
    actReportsHospitality: TDNMAction;
    actReportsInventory: TDNMAction;
    actReportsPayments: TDNMAction;
    actReportsPayroll: TDNMAction;
    actReportsPurchases: TDNMAction;
    actReportsSales: TDNMAction;
    actReportsTemplates: TDNMAction;
    actReportsCustomReports: TDNMAction;
    actWindowTiled: TDNMAction;
    actWindowCascade: TDNMAction;
    actWindowArrangeIcons: TDNMAction;
    actWindowCustomiseToolbar: TDNMAction;
    actUtilsLocations: TDNMAction;
    actUtilsDbUtilsBackup: TDNMAction;
    actUtilsDbUtilsRestore: TDNMAction;
    actUtilsDbUtilsCopy: TDNMAction;
    actUtilsDbUtilsCopyRO: TDNMAction;
    actUtilsDbUtilsRemove: TDNMAction;
    actUtilsDbUtilsOptimise: TDNMAction;
    actUtilsSetupDocsPath: TDNMAction;
    actUtilsPublicHolidays: TDNMAction;
    actUtilsPreferences: TDNMAction;
    actUtilsCompanyInformation: TDNMAction;
    actUtilsCurrentUsers: TDNMAction;
    actUtilsFaxJobsFaxSpoolList: TDNMAction;
    actUtilsFaxJobsPurgeOldFaxJobs: TDNMAction;
    actUtilsAuditTrailAuditTrailList: TDNMAction;
    actUtilsAuditTrailPurgeAuditTrail: TDNMAction;
    actUtilsAuditTrailExportAuditTrail: TDNMAction;
    dlgCurrentUsers: TSelectionDialog;
    actAboutUpdateNotes: TDNMAction;
    actAboutAbout: TDNMAction;
    actFileExit: TDNMAction;
    actEmployeePayrollPAYGSummary: TDNMAction;
    actReportsQuoteStatus: TDNMAction;
    actReportsSalesOrderStatus: TDNMAction;
    actReportsUnPaidBills: TDNMAction;
    actReportsStockStatus: TDNMAction;
    actReportsProductSalesSummary: TDNMAction;
    actReportsTransactionJournal: TDNMAction;
    actReportsGeneralLedger: TDNMAction;
    actReportsJobProfitability: TDNMAction;
    actReportsSupplier: TDNMAction;
    actReportsBAS: TDNMAction;
    actReportsBASList: TDNMAction;
    actReportsAccountsSummary: TDNMAction;
    actUtilsExportToReportDB: TDNMAction;
    actCustomImports: TDNMAction;
    actEmployeeTransferDetails: TDNMAction;
    MainMenu: TAdvMainMenu;
    File2: TMenuItem;
    Exit2: TMenuItem;
    N1: TMenuItem;
    Export2: TMenuItem;
    ExportTemplates2: TMenuItem;
    ExportData2: TMenuItem;
    Import2: TMenuItem;
    CustomImports1: TMenuItem;
    NT2: TMenuItem;
    PostcodetoRatingAreaZone2: TMenuItem;
    ClientRates2: TMenuItem;
    emplates3: TMenuItem;
    Data2: TMenuItem;
    N126: TMenuItem;
    OpenCompany2: TMenuItem;
    NewCompany2: TMenuItem;
    Appointments3: TMenuItem;
    CustomersOnSupportList2: TMenuItem;
    PhoneSupportLogList2: TMenuItem;
    AppointmentsReport2: TMenuItem;
    FeedbackReport2: TMenuItem;
    PhoneSupport2: TMenuItem;
    JobList2: TMenuItem;
    NewJob2: TMenuItem;
    SourceList2: TMenuItem;
    NewSource2: TMenuItem;
    AppointmentsList2: TMenuItem;
    NewAppointment2: TMenuItem;
    N133: TMenuItem;
    PrintAppointments2: TMenuItem;
    MainCalendar2: TMenuItem;
    Sales3: TMenuItem;
    PrintInvoices2: TMenuItem;
    N136: TMenuItem;
    Manifest3: TMenuItem;
    ManifestRouteList2: TMenuItem;
    ManifestRoute2: TMenuItem;
    N137: TMenuItem;
    ManifestVehicleList2: TMenuItem;
    ManifestVehicle2: TMenuItem;
    N138: TMenuItem;
    ManifestList2: TMenuItem;
    Manifest4: TMenuItem;
    N139: TMenuItem;
    ManifestAllocationList2: TMenuItem;
    POS2: TMenuItem;
    OrderProcessList2: TMenuItem;
    TrafficSummaryReport2: TMenuItem;
    TrafficList2: TMenuItem;
    TillSummaryReport2: TMenuItem;
    VouchersList2: TMenuItem;
    BarTabList2: TMenuItem;
    N140: TMenuItem;
    CustomisePOS2: TMenuItem;
    POSScreen2: TMenuItem;
    Sales4: TMenuItem;
    SalesList2: TMenuItem;
    N141: TMenuItem;
    BackOrders3: TMenuItem;
    N142: TMenuItem;
    InvoiceList2: TMenuItem;
    Invoice2: TMenuItem;
    Refunds2: TMenuItem;
    CashSale2: TMenuItem;
    SalesOrders2: TMenuItem;
    SalesOrderReport2: TMenuItem;
    SalesOrderList2: TMenuItem;
    SalesOrder2: TMenuItem;
    Quotes2: TMenuItem;
    QuoteList2: TMenuItem;
    Quote2: TMenuItem;
    Jobs2: TMenuItem;
    JobProfitability2: TMenuItem;
    JobAnalysisBalanceReport2: TMenuItem;
    CRM2: TMenuItem;
    N146: TMenuItem;
    N147: TMenuItem;
    N148: TMenuItem;
    N149: TMenuItem;
    MailMerge2: TMenuItem;
    N150: TMenuItem;
    LoyaltyProgram2: TMenuItem;
    N151: TMenuItem;
    CanvasserList2: TMenuItem;
    Canvasser2: TMenuItem;
    N152: TMenuItem;
    PhoneContactList2: TMenuItem;
    PhoneContact2: TMenuItem;
    OtherContactsList2: TMenuItem;
    OtherContacts2: TMenuItem;
    Customers2: TMenuItem;
    CustomerDetailsList2: TMenuItem;
    CustomerSummary2: TMenuItem;
    N154: TMenuItem;
    ClientTypeList2: TMenuItem;
    ClientType2: TMenuItem;
    N155: TMenuItem;
    CustomerAccountNoSetup2: TMenuItem;
    CustomerList2: TMenuItem;
    NewCustomer2: TMenuItem;
    Purchases2: TMenuItem;
    RefreshSnapshotProducts5: TMenuItem;
    ReturnAuthority3: TMenuItem;
    ReturnAuthorityList2: TMenuItem;
    ReturnAuthority4: TMenuItem;
    Bills2: TMenuItem;
    BillList2: TMenuItem;
    BillRefund2: TMenuItem;
    Bill2: TMenuItem;
    PurchaseOrders2: TMenuItem;
    BackOrders4: TMenuItem;
    N157: TMenuItem;
    PurchaseOrderList2: TMenuItem;
    PurchaseOrder2: TMenuItem;
    SmartOrders2: TMenuItem;
    SmartOrderList2: TMenuItem;
    SmartOrder2: TMenuItem;
    Suppliers2: TMenuItem;
    SupplierReport2: TMenuItem;
    N158: TMenuItem;
    SupplierList2: TMenuItem;
    Supplier2: TMenuItem;
    Inventory2: TMenuItem;
    RefreshSnapshotProducts6: TMenuItem;
    N159: TMenuItem;
    UnitsOfMeasureList2: TMenuItem;
    UnitsOfMeasure2: TMenuItem;
    ProductSales2: TMenuItem;
    BarcodePickingAssemblyList2: TMenuItem;
    BarcodePickingAssembly2: TMenuItem;
    PrintPickSlips2: TMenuItem;
    N163: TMenuItem;
    CustomerTypePriceList2: TMenuItem;
    N164: TMenuItem;
    AutoReOrder2: TMenuItem;
    PriceUpdate2: TMenuItem;
    Stock2: TMenuItem;
    StockTake2: TMenuItem;
    N166: TMenuItem;
    StockAdjustmentList2: TMenuItem;
    StockAdjustment2: TMenuItem;
    N167: TMenuItem;
    StockTransferList2: TMenuItem;
    StockTransfer2: TMenuItem;
    Products2: TMenuItem;
    N169: TMenuItem;
    BatchProductCodeAbbreviator2: TMenuItem;
    BatchProductCreator2: TMenuItem;
    N170: TMenuItem;
    ProductRewardPointsList2: TMenuItem;
    ProductRewardPoints2: TMenuItem;
    N171: TMenuItem;
    ProductCommissionList2: TMenuItem;
    ProductCommission2: TMenuItem;
    N172: TMenuItem;
    ProductsList2: TMenuItem;
    ProductsExpressList2: TMenuItem;
    NewProduct2: TMenuItem;
    Banking1: TMenuItem;
    TransactionJournal2: TMenuItem;
    BankAccountReport2: TMenuItem;
    AccountsReceivableReport2: TMenuItem;
    AccountsPayableReport2: TMenuItem;
    N174: TMenuItem;
    PrintRecipientCreatedStatement2: TMenuItem;
    PrintStatements2: TMenuItem;
    Statements2: TMenuItem;
    ReconciliationList2: TMenuItem;
    Reconcile2: TMenuItem;
    ChequeList2: TMenuItem;
    Cheque2: TMenuItem;
    N177: TMenuItem;
    DepositedList2: TMenuItem;
    oBeDeposited2: TMenuItem;
    DepositEntry2: TMenuItem;
    Employee3: TMenuItem;
    ResetPersonalTabs1: TMenuItem;
    N183: TMenuItem;
    ClockOn2: TMenuItem;
    RosterList2: TMenuItem;
    Roster2: TMenuItem;
    CustomReports3: TMenuItem;
    N185: TMenuItem;
    RepServices2: TMenuItem;
    GlobalList2: TMenuItem;
    N186: TMenuItem;
    PersonalPreferences2: TMenuItem;
    AccessLevels2: TMenuItem;
    N187: TMenuItem;
    TerminateEmployeemnu: TMenuItem;
    EmployeeList2: TMenuItem;
    EmployeeAnalysis2: TMenuItem;
    NewEmployee2: TMenuItem;
    oDoList2: TMenuItem;
    NewToDo2: TMenuItem;
    RepList2: TMenuItem;
    NewRep2: TMenuItem;
    Payroll2: TMenuItem;
    imeSheetEntry2: TMenuItem;
    EmployeeServices2: TMenuItem;
    N190: TMenuItem;
    PayrollJobsList2: TMenuItem;
    N192: TMenuItem;
    LeaveTakenList2: TMenuItem;
    LeaveAccruedList2: TMenuItem;
    N193: TMenuItem;
    ImportTaxScales2: TMenuItem;
    axScalesList2: TMenuItem;
    NewTaxScale2: TMenuItem;
    N194: TMenuItem;
    PayRates2: TMenuItem;
    NewPayRate2: TMenuItem;
    N195: TMenuItem;
    DeductionsList2: TMenuItem;
    NewDeduction2: TMenuItem;
    N196: TMenuItem;
    BankCodes2: TMenuItem;
    NewBankCode2: TMenuItem;
    N197: TMenuItem;
    Awards2: TMenuItem;
    NewAward2: TMenuItem;
    N198: TMenuItem;
    Allowances2: TMenuItem;
    NewAllowance2: TMenuItem;
    N199: TMenuItem;
    PayHistory2: TMenuItem;
    PayStaff2: TMenuItem;
    FixedAssets3: TMenuItem;
    ServiceLogList2: TMenuItem;
    ServiceLog2: TMenuItem;
    N210: TMenuItem;
    CheckWarrantiesInsurancePolicy2: TMenuItem;
    FixedAssetTypesList2: TMenuItem;
    FixedAssetType2: TMenuItem;
    FixedAssetsList2: TMenuItem;
    FixedAsset2: TMenuItem;
    Accounts2: TMenuItem;
    RefreshBatchTransaction2: TMenuItem;
    N214: TMenuItem;
    ElectronicFundsTransfer2: TMenuItem;
    ProfitAndLossByPeriod2: TMenuItem;
    ProfitAndLoss2: TMenuItem;
    BalanceSheet2: TMenuItem;
    TrialBalance2: TMenuItem;
    N217: TMenuItem;
    JournalEntryList2: TMenuItem;
    JournalEntry2: TMenuItem;
    MemorisedTransactionList2: TMenuItem;
    N219: TMenuItem;
    ForeignExchangeHistoryList2: TMenuItem;
    ForeignExchangeRatesList2: TMenuItem;
    ForeignExchangeRate2: TMenuItem;
    ShippingList2: TMenuItem;
    Shipping2: TMenuItem;
    ermsList2: TMenuItem;
    erms2: TMenuItem;
    axCodeList2: TMenuItem;
    axCode2: TMenuItem;
    DepartmentsList2: TMenuItem;
    Department2: TMenuItem;
    AccountTypeList2: TMenuItem;
    N225: TMenuItem;
    AccountsList2: TMenuItem;
    Account2: TMenuItem;
    mnuReports: TMenuItem;
    CustomReports4: TMenuItem;
    emplates4: TMenuItem;
    N229: TMenuItem;
    SalesReport4: TMenuItem;
    PurchasesReport2: TMenuItem;
    PayrollReports2: TMenuItem;
    PaymentsReport2: TMenuItem;
    InventoryReport2: TMenuItem;
    FixedAssets4: TMenuItem;
    Employee4: TMenuItem;
    Banking2: TMenuItem;
    Appointments4: TMenuItem;
    AccountsReport2: TMenuItem;
    miWindow: TMenuItem;
    ArrangeIcons2: TMenuItem;
    Cascade2: TMenuItem;
    iled2: TMenuItem;
    Utilities2: TMenuItem;
    N231: TMenuItem;
    AuditTrail2: TMenuItem;
    ExportAuditTrail2: TMenuItem;
    PurgeAuditTrail2: TMenuItem;
    AuditTrailList2: TMenuItem;
    N233: TMenuItem;
    FaxJobs2: TMenuItem;
    PurgeOldFaxJobs2: TMenuItem;
    FaxSpoolList2: TMenuItem;
    CurrentUsers2: TMenuItem;
    CompanyInformation2: TMenuItem;
    N234: TMenuItem;
    Preferences2: TMenuItem;
    PublicHolidays2: TMenuItem;
    N235: TMenuItem;
    SetupDocsPath2: TMenuItem;
    DatabaseUtils2: TMenuItem;
    Optimise2: TMenuItem;
    N242: TMenuItem;
    Remove2: TMenuItem;
    Copy2: TMenuItem;
    Restore2: TMenuItem;
    Backup2: TMenuItem;
    Locations2: TMenuItem;
    Help1: TMenuItem;
    About4: TMenuItem;
    N243: TMenuItem;
    UpdateNotes2: TMenuItem;
    actPaymentsPrintRecipientCreatedStatement: TDNMAction;
    actSalesPOSPOSScreen: TDNMAction;
    actSalesPOSQuickPOS: TDNMAction;
    actEmployeeToDoList: TDNMAction;
    actEmployeeAccessLevels: TDNMAction;
    actEmployeePersonalPreferences: TDNMAction;
    actSTPPreferences: TDNMAction;
    actCompanyTypes: TDNMAction;
    actFollowupTypes: TDNMAction;
    actFollowupResultTypes: TDNMAction;
    actReminders: TDNMAction;
    actBinUsageReport: TDNMAction;
    N3: TMenuItem;
    BinUsageReport1: TMenuItem;
    actReportsSalesSummary: TDNMAction;
    actPaymentsChequePrn: TDNMAction;
    actPaymentsEFT: TDNMAction;
    actAboutShowManual: TDNMAction;
    actReportsEmployee: TDNMAction;
    actPaymentsAccountsReceivableNotes: TDNMAction;
    N5: TMenuItem;
    BinLocation1: TMenuItem;
    BinLocationList1: TMenuItem;
    actApptsCancellationReasons: TDNMAction;
    CancellationReasonList1: TMenuItem;
    POBOList: TDNMAction;
    POBOExpressList: TDNMAction;
    INVBOList: TDNMAction;
    INVBOListExpress: TDNMAction;
    SOBOList: TDNMAction;
    SOBOListExpress: TDNMAction;
    Contents2: TMenuItem;
    LicenceAgreement1: TMenuItem;
    TrainingGuideMnu: TMenuItem;
    actSalesPrintPickSlips: TDNMAction;
    actCustomExport: TDNMAction;
    CustomExport1: TMenuItem;
    actReportsCRM: TDNMAction;
    actReportsJobs: TDNMAction;
    CRMReports1: TMenuItem;
    Jobs1: TMenuItem;
    actEquipmentList: TDNMAction;
    actEquipment: TDNMAction;
    TrainingVideos1: TMenuItem;
    ProductFormulaEntry1: TMenuItem;
    ProductFormulaCreator1: TMenuItem;
    ProductFormulaList1: TMenuItem;
    actProductFormulaEntry: TDNMAction;
    actProductFormulaCreator: TDNMAction;
    actProductFormulaList: TDNMAction;
    actBarcodeAction: TDNMAction;
    N11: TMenuItem;
    actCustomerProfitability: TDNMAction;
    actEmployeePayrollATO: TDNMAction;
    ATOSubmissions: TMenuItem;
    actPurchasesBillsBillDetailsList: TDNMAction;
    actPaymentsChequeDetailsList: TDNMAction;
    N13: TMenuItem;
    BillDetailsList2: TMenuItem;
    ChequeDetailsList2: TMenuItem;
    actPurchasesExpenseClaimList: TDNMAction;
    ExpenseClaimList1: TMenuItem;
    actPaymentsApprovalReminderList: TDNMAction;
    actWorkOrderStatusList: TDNMAction;
    actDeliveryDocketList: TDNMAction;
    actEmployeeTerminationList: TDNMAction;
    TerminationsList: TMenuItem;
    actAccountsIntrastatDeclaration: TDNMAction;
    actAccountsIntrastatList: TDNMAction;
    actSource: TDNMAction;
    actUtilsEmailedReport: TDNMAction;
    EmailedReport1: TMenuItem;
    General1: TMenuItem;
    Accounts1: TMenuItem;
    Department1: TMenuItem;
    axCodes1: TMenuItem;
    JournalEntry1: TMenuItem;
    Source1: TMenuItem;
    Payments1: TMenuItem;
    AccountsReceivableReport1: TMenuItem;
    AccountsPayableReport1: TMenuItem;
    ApprovalReminderList2: TMenuItem;
    N6: TMenuItem;
    SuppPrepaymentList1: TMenuItem;
    SupplierPrepayment1: TMenuItem;
    SupplierPaymentList1: TMenuItem;
    SupplierPayment1: TMenuItem;
    ReceivedBulkPayments1: TMenuItem;
    BulkPaySuppliers1: TMenuItem;
    CustomerPrepaymentList1: TMenuItem;
    CustomerPrepayment1: TMenuItem;
    CustomerPaymentList1: TMenuItem;
    CustomerPayment1: TMenuItem;
    Deposits1: TMenuItem;
    Cheques1: TMenuItem;
    Reconciliation1: TMenuItem;
    Reps1: TMenuItem;
    oDo1: TMenuItem;
    Employee1: TMenuItem;
    Roster1: TMenuItem;
    FixedAsset1: TMenuItem;
    FixedAssetType1: TMenuItem;
    ServiceLogs1: TMenuItem;
    N26: TMenuItem;
    N29: TMenuItem;
    Shipping1: TMenuItem;
    erms1: TMenuItem;
    ForeignExchangeRates1: TMenuItem;
    N41: TMenuItem;
    N42: TMenuItem;
    Support1: TMenuItem;
    Statements1: TMenuItem;
    N30: TMenuItem;
    N43: TMenuItem;
    Allowance1: TMenuItem;
    Award1: TMenuItem;
    BankCodes1: TMenuItem;
    axScales1: TMenuItem;
    N44: TMenuItem;
    erminations1: TMenuItem;
    N45: TMenuItem;
    Deduction1: TMenuItem;
    PayRate1: TMenuItem;
    Leave1: TMenuItem;
    UnitsOfMeasure1: TMenuItem;
    BarcodePicking1: TMenuItem;
    N16: TMenuItem;
    AuditTrailList1: TMenuItem;
    AccountsPayableReport3: TMenuItem;
    AccountsReceivableReport3: TMenuItem;
    BankAccountReport3: TMenuItem;
    CustomerPayment2: TMenuItem;
    CustomerPrepayment2: TMenuItem;
    SupplierPayments1: TMenuItem;
    SupplierPrepayments1: TMenuItem;
    N14: TMenuItem;
    N17: TMenuItem;
    Bins1: TMenuItem;
    N2: TMenuItem;
    actCashFlowForecast: TDNMAction;
    actCashFlowStatement: TDNMAction;
    CashFlowForecast1: TMenuItem;
    CashFlowStatement1: TMenuItem;
    actGeneralLedger: TDNMAction;
    GeneralLedger1: TMenuItem;
    actUnpaidBillGUI: TDNMAction;
    UnpaidBills1: TMenuItem;
    N21: TMenuItem;
    N35: TMenuItem;
    actCustomerBalanceDetail: TDNMAction;
    actCustomerNotesReport: TDNMAction;
    actEmployeeReportByPeriod: TDNMAction;
    actForeignSalesList: TDNMAction;
    actActionAuthorisationsList: TDNMAction;
    actCombinedAnalysisList: TDNMAction;
		actCommissionReport: TDNMAction;
		actEmployeesFixedAssetsList: TDNMAction;
		actSalesCommissionList: TDNMAction;
		actAssetRegisterList: TDNMAction;
		actFixedAssetsDetails: TDNMAction;
		actProductSalesSummaryByColumn: TDNMAction;
	  actStockStatusRoling: TDNMAction;
	  actStockQtysLocationsReport: TDNMAction;
    actBinQtyReport: TDNMAction;
	  actSupplierProductReport: TDNMAction;
		actUnAllocatedBinsReport: TDNMAction;
		actUnbalancedBinQty: TDNMAction;
		actProfitLossSummary: TDNMAction;
		actCustomerJobFollowupList: TDNMAction;
		actAccountsPayableNotes:TDNMAction;
		actExpenseClaimList:TDNMAction;
		actForeignPurchaseList:TDNMAction;
		actSupplierStatement:TDNMAction;
		actUnInvoicedPurchasesList:TDNMAction;
		actUnInvoicedPurchItemList:TDNMAction;
		actQuoteDetailsReport:TDNMAction;
		actSalesReport:TDNMAction;
		actSalesRewardPointsList:TDNMAction;
		actSoldProductsReport:TDNMAction;
    actTransactionList: TDNMAction;
    N9: TMenuItem;
    actReportsGeneral: TDNMAction;
    actReportsUtilities: TDNMAction;
    actReportsPOS: TDNMAction;
    GeneralReports1: TMenuItem;
    POSReports1: TMenuItem;
    UtilitiesReports1: TMenuItem;
    CustomerBalanceDetail1: TMenuItem;
    CustomerNotesReport1: TMenuItem;
    CustomerTypePriceList1: TMenuItem;
    N15: TMenuItem;
    N18: TMenuItem;
    EmployeesummarybyPeriod1: TMenuItem;
    EmployeeSummary1: TMenuItem;
    EmployeeSummary2: TMenuItem;
    ForeignSalesReport1: TMenuItem;
    SalesList1: TMenuItem;
    ActionAuthorisations1: TMenuItem;
    CombinedAnalysis1: TMenuItem;
    EmployeeFixedAssests1: TMenuItem;
    InvoiceandProductcommissionReport1: TMenuItem;
    AssetRegisterReport1: TMenuItem;
    WarrantyInsurancePolicyReport2: TMenuItem;
    ProductSalesSummary1: TMenuItem;
    StockStatusReport1: TMenuItem;
    ProductSalesSummaryByColumn1: TMenuItem;
    StockMovementStatus1: TMenuItem;
    StockQuantitiesLocationReport1: TMenuItem;
    SupplierProductReport1: TMenuItem;
    N19: TMenuItem;
    StockMovementStatus2: TMenuItem;
    StockQuantitiesLocationReport2: TMenuItem;
    UnAllocatedBinsReport1: TMenuItem;
    UnbalancedBinQuantities1: TMenuItem;
    N20: TMenuItem;
    CustomerJobFollowups1: TMenuItem;
    CustomerDiscountPriceList3: TMenuItem;
    CombinedAnalysis2: TMenuItem;
    EmployeeAnalysis1: TMenuItem;
    JobList1: TMenuItem;
    ProfitandLossSummary1: TMenuItem;
    ProfitAndLoss1: TMenuItem;
    AccountsPayableNotesReport1: TMenuItem;
    AccountsReceivableNotes1: TMenuItem;
    ExpenseClaims1: TMenuItem;
    AccountsPayableNotesReport2: TMenuItem;
    ForeignPurchaseReport1: TMenuItem;
    ProductSalesProjection2: TMenuItem;
    ProductSalesSummary2: TMenuItem;
    ProfitandLossSummary2: TMenuItem;
    ProfitAndLoss3: TMenuItem;
    SupplierProductReport2: TMenuItem;
    SupplierStatement1: TMenuItem;
    UnInvoicedCustomerPurchaseOrders1: TMenuItem;
    UnInvoicedCustomerPurchaseItems1: TMenuItem;
    UnpaidBillsReport1: TMenuItem;
    N8: TMenuItem;
    QuoteList1: TMenuItem;
    InvoiceandProductCommissionReport2: TMenuItem;
    InvoiceCommissionReport2: TMenuItem;
    ProductSalesProjection1: TMenuItem;
    ProductSalesSummary3: TMenuItem;
    ProductSalesSummaryByColumn2: TMenuItem;
    ProfitAndLoss4: TMenuItem;
    ProfitandLossSummary3: TMenuItem;
    SalesReport1: TMenuItem;
    SalesRewardPoints1: TMenuItem;
    SalesSummary1: TMenuItem;
    StockTurnoverReport1: TMenuItem;
    SalesList3: TMenuItem;
    SalesOrderReport1: TMenuItem;
    actProductAttributes: TDNMAction;
    ProductAttributes1: TMenuItem;
    actMarketingRatios: TDNMAction;
    actSalesRatios: TDNMAction;
    actLeadStatusType1: TDNMAction;
    actSalesPipeline: TDNMAction;
    actSerialNumbersOld: TDNMAction;
    mnuSerialNumbers: TMenuItem;
    actShippingContainerStatus: TDNMAction;
    actShippingContainer: TDNMAction;
    actShipContainerList: TDNMAction;
    actBatches: TDNMAction;
    ForeignExchangeRates2: TMenuItem;
    ForeignPurchaseReport2: TMenuItem;
    ForeignExchangeRatesList1: TMenuItem;
    ForeignExchangeHistoryList1: TMenuItem;
    actMailMergeHistory: TDNMAction;
    actTimesheetEntry: TDNMAction;
    actEmployeeTimesheetList: TDNMAction;
    ActiveForms2: TMenuItem;
    PAYGPaymentSummary1: TMenuItem;
    RepServices1: TMenuItem;
    N4: TMenuItem;
    Equipment1: TMenuItem;
    EquipmentList1: TMenuItem;
    actReportsWorkShop: TDNMAction;
    actClientEquipmentlist: TDNMAction;
    Videos1: TMenuItem;
    actVidoes: TDNMAction;
    actincomeExpenseConfig: TDNMAction;
    actIncomeandExpenditurereport: TDNMAction;
    actmainDashboard: TDNMAction;
    actSalesDashboard: TDNMAction;
    actSerialJobnumber: TDNMAction;
    mnuSerialjobNumber: TMenuItem;
    actAutoAdjustbin: TDNMAction;
    About1: TMenuItem;
    mnuUtilsExportToReportDB: TMenuItem;
    actSalesListwithCommision: TDNMAction;
    actCashSaleDepositGUI: TDNMAction;
    actAdjustUOM: TDNMAction;
    actRewardPoints: TDNMAction;
    actRewardPointsDueToExpireGUI: TDNMAction;
    N10: TMenuItem;
    AdjustUOM1: TMenuItem;
    actAppointmentStatusList: TDNMAction;
    AppointmentStatusList1: TMenuItem;
    actRepAbilityList: TDNMAction;
    actRepAbility: TDNMAction;
    RepAbility1: TMenuItem;
    RepAbilityList1: TMenuItem;
    actTransactionwith0Qty: TDNMAction;
    actCustomerExpressList: TDNMAction;
    actShippingAgent: TDNMAction;
    actShippingAgentlist: TDNMAction;
    mnuTaxreport: TMenuItem;
    BASReport1: TMenuItem;
    BASReportList1: TMenuItem;
    SummarySheet1: TMenuItem;
    ransactionJournal1: TMenuItem;
    About2: TMenuItem;
    axCodeList1: TMenuItem;
    axCodeList3: TMenuItem;
    MemorisedTransactionList1: TMenuItem;
    PrintCheques1: TMenuItem;
    N22: TMenuItem;
    imesheetList1: TMenuItem;
    PAYGPaymentSummary2: TMenuItem;
    imesheet1: TMenuItem;
    q1: TMenuItem;
    imesheetList2: TMenuItem;
    ransferEmployeeData1: TMenuItem;
    GlobalList1: TMenuItem;
    actMessages: TDNMAction;
    actVideos1: TMenuItem;
    Messages1: TMenuItem;
    Reminders1: TMenuItem;
    emplates1: TMenuItem;
    DatabaseUtils1: TMenuItem;
    Optimise1: TMenuItem;
    N23: TMenuItem;
    Remove1: TMenuItem;
    Copy1: TMenuItem;
    Restore1: TMenuItem;
    Backup1: TMenuItem;
    N24: TMenuItem;
    actCustomise: TDNMAction;
    Customise1: TMenuItem;
    CustomiseToolbar1: TMenuItem;
    Reminders2: TMenuItem;
    Messages2: TMenuItem;
    Videos2: TMenuItem;
    actProfitandLossByPeriod: TDNMAction;
    actProfitandLossSummary: TDNMAction;
    Videos3: TMenuItem;
    BackOrders1: TMenuItem;
    DeliveryDocketList2: TMenuItem;
    MarketingRatiosReport1: TMenuItem;
    ProductsExpressList1: TMenuItem;
    ProductsList1: TMenuItem;
    SalesPipeline1: TMenuItem;
    SalesRatiosReport1: TMenuItem;
    N25: TMenuItem;
    Import1: TMenuItem;
    NT1: TMenuItem;
    PostcodetoRatingAreaZone1: TMenuItem;
    ClientRates1: TMenuItem;
    CustomImports2: TMenuItem;
    ImportTemplates1: TMenuItem;
    Data1: TMenuItem;
    ExportToReportDB1: TMenuItem;
    Export1: TMenuItem;
    ExportToReportDB2: TMenuItem;
    CustomExport2: TMenuItem;
    ExportTemplates1: TMenuItem;
    ExportData1: TMenuItem;
    Maximise1: TMenuItem;
    Customise2: TMenuItem;
    actProductListwithUOM: TDNMAction;
    actRegionList: TDNMAction;
    actRegion: TDNMAction;
    Locations1: TMenuItem;
    actProductBarcodes: TDNMAction;
    actClientList: TDNMAction;
    actContactList: TDNMAction;
    actMarketingContactcontactList: TDNMAction;
    actProductClassList: TDNMAction;
    actOtherfollowups: TDNMAction;
    actProductgroupdiscount: TDNMAction;
    actProductSpecificationList: TDNMAction;
    actProductExtrabuyPrices: TDNMAction;
    actProductExtraSellPrices: TDNMAction;
    actProductforeignBuyPrice: TDNMAction;
    actproductForeignSellPrice: TDNMAction;
    actRelatedProducts: TDNMAction;
    actrelatedcustomers: TDNMAction;
    actShippingMethods: TDNMAction;
    actSpecialProducts: TDNMAction;
    N7: TMenuItem;
    mnuLanguage: TMenuItem;
    actLanguages: TDNMAction;
    Languages1: TMenuItem;
    actkills: TDNMAction;
    actSkillList: TDNMAction;
    actEmployeeSkillList: TDNMAction;
    actProductGroupList: TDNMAction;
    ProductGroupList1: TMenuItem;
    actPickingSlipList: TDNMAction;
    actSalesQuotesPadQuote: TDNMAction;
    actWebAPITest: TDNMAction;
    WebAPITest1: TMenuItem;
    actSubTaxcodes: TDNMAction;
    SubTaxCodeList1: TMenuItem;
    actSubTaxcode: TDNMAction;
    SubTaxCode1: TMenuItem;
    actNotesAuditTrial: TDNMAction;
    NotesAuditTrialList1: TMenuItem;
    actImportDataMapping: TDNMAction;
    actImportDataMappingList: TDNMAction;
    actDeldocketList: TDNMAction;
    actSalesListOutstanding: TDNMAction;
    actPrintPurchaseOrders: TDNMAction;
    actPurchaseOrderAudit: TDNMAction;
    actSalesJobQuoteList: TDNMAction;
    actTask: TDNMAction;
    actTaskList: TDNMAction;
    actClientPhoneList: TDNMAction;
    actPhoneSupportLogListExpress: TDNMAction;
    actCustlistWithDetails: TDNMAction;
    actPhoneSupportTypeList: TDNMAction;
    actPhoneSupportVersionList: TDNMAction;
    SupportTypeList1: TMenuItem;
    SupportVersionList1: TMenuItem;
    JobProfitAndLoss1: TMenuItem;
    actUnAllocatedQty: TDNMAction;
    UnAllocatedQty1: TMenuItem;
    actProductPurchaseMovementList: TDNMAction;
    actNumberSequenceList: TDNMAction;
    N27: TMenuItem;
    SubTaxCodeList2: TMenuItem;
    SubTaxCode2: TMenuItem;
    N28: TMenuItem;
    actLinkTo: TDNMAction;
    actGoogleAnalysisReport_Language: TDNMAction;
    actGoogleAnalysisReport_Location: TDNMAction;
    actGoogleAnalysisReport_keyword: TDNMAction;
    actGoogleAnalysisReport_Campaign: TDNMAction;
    actGoogleAnalysisReport_Browser: TDNMAction;
    actGoogleAnalysisReport_DayofWeek: TDNMAction;
    actGoogleAnalyticReport_Language: TDNMAction;
    actGoogleAnalyticReport_Location: TDNMAction;
    actGoogleAnalyticReport_Keyword: TDNMAction;
    actGoogleAnalyticReport_Campaign: TDNMAction;
    actGoogleAnalyticReport_Browser: TDNMAction;
    actGoogleAnalyticReport_DayofWeek: TDNMAction;
    actreportsGoogle: TDNMAction;
    actAnalyicreports: TDNMAction;
    actAnalyticsSummaryList: TDNMAction;
    actAnalyticsDetailList: TDNMAction;
    LinkTo1: TMenuItem;
    actGoogleAnalysisReport_Summary: TDNMAction;
    actGoogleAnalytic_Summary: TDNMAction;
    actFaq: TDNMAction;
    actGoogleanalysisCost: TDNMAction;
    actProductSalesReport: TDNMAction;
    BankCodeList1: TMenuItem;
    actVoucher: TDNMAction;
    VoucherSale1: TMenuItem;
    actsalesAnalysisGraph: TDNMAction;
    SalesanalysisChart1: TMenuItem;
    SalesAnalysisChart2: TMenuItem;
    SalesAnalysisChart3: TMenuItem;
    actEmailList: TDNMAction;
    EmailList1: TMenuItem;
    actEmailPurge: TDNMAction;
    EmailPurge1: TMenuItem;
    actSalesAnalysisManual: TDNMAction;
    actSalesAnalysisManualList: TDNMAction;
    actvoucherInvoice: TDNMAction;
    VoucherInvoice1: TMenuItem;
    VoucherSale2: TMenuItem;
    SalesAnalysis1: TMenuItem;
    SalesAnalysisManual1: TMenuItem;
    objectactSalesAnalysisManualListTDNMAction1: TMenuItem;
    SalesAnalysisChart4: TMenuItem;
    actProfitnLosschart: TDNMAction;
    actProfitnLosschartCompareGross:TDNMAction;
    actProfitnLosschartCompareGrossMonth:TDNMAction;
    actProfitnLosschartCompareGrossQuarter:TDNMAction;
    actProfitnLosschartCompareGrossYear:TDNMAction;
    actProfitnLosschartCompareRevenue:TDNMAction;
    actProfitnLosschartCompareRevenueMonth:TDNMAction;
    actProfitnLosschartCompareRevenueQuarter:TDNMAction;
    actProfitnLosschartCompareRevenueYear:TDNMAction;
    actProfitnLosschartCompareNI:TDNMAction;
    actProfitnLosschartCompareNIMonth:TDNMAction;
    actProfitnLosschartCompareNIQuarter:TDNMAction;
    actProfitnLosschartCompareNIYear:TDNMAction;
    actProfitnLosschartgrossProfit: TDNMAction;
    actSmartorderListDetails: TDNMAction;
    SmartOrderDetailList1: TMenuItem;
    actTaxSummaryDetailReport: TDNMAction;
    REadOnlyCopy1: TMenuItem;
    ReadOnlyCopy2: TMenuItem;
    actrosterReport: TDNMAction;
    actRosterReportDetails: TDNMAction;
    N31: TMenuItem;
    RosterReportSummary1: TMenuItem;
    RosterReportDetails1: TMenuItem;
    Skills1: TMenuItem;
    SkillList1: TMenuItem;
    SkillProviderList1: TMenuItem;
    EmployeeSkillList1: TMenuItem;
    actSiteIntegrationReport: TDNMAction;
    InsurancePad1: TMenuItem;
    N32: TMenuItem;
    actApprovalLevelList: TDNMAction;
    actApprovalList: TDNMAction;
    ApprovalList1: TMenuItem;
    ApprovalReminderList1: TMenuItem;
    N33: TMenuItem;
    Dashboard1: TMenuItem;
    actHourlySalesReport: TDNMAction;
    HourlySalesReport1: TMenuItem;
    actEmailReferenceList: TDNMAction;
    actLetterReferenceList: TDNMAction;
    Correspondence1: TMenuItem;
    EmailReferenceList1: TMenuItem;
    LetterReferenceList1: TMenuItem;
    actAccountrunningBalance: TDNMAction;
    AccountRunningBalance1: TMenuItem;
    actCashProfitandLoss: TDNMAction;
    CashProfitandLossReport1: TMenuItem;
    actPnLEmployeereport: TDNMAction;
    PnLEmployee1: TMenuItem;
    actAreaCode: TDNMAction;
    actAreacodes: TDNMAction;
    AreaCodeList1: TMenuItem;
    actProductstoExcludeDefaultTaxCode: TDNMAction;
    ProductstoExcludeDefaultTaxCode1: TMenuItem;
    actEBayOrders: TDNMAction;
    Ebay1: TMenuItem;
    EbayOrders1: TMenuItem;
    actEBaySalesOrders: TDNMAction;
    EBaySalesOrders1: TMenuItem;
    actAuseParcelconf: TDNMAction;
    actSalesTaxReport: TDNMAction;
    actCleanDatabase: TDNMAction;
    CleanDatabase1: TMenuItem;
    actWeeklysalesreport: TDNMAction;
    Weeklysalesreport1: TMenuItem;
    actFxTrading: TDNMAction;
    actFxTradingList: TDNMAction;
    FxTrading1: TMenuItem;
    actummarySheets: TDNMAction;
    actSummarySheets: TDNMAction;
    SummarySheetsCategory1: TMenuItem;
    SummarySheets1: TMenuItem;
    actcolorPrefs: TDNMAction;
    actSMSList: TDNMAction;
    BOSalesOrders1: TMenuItem;
    SMSList1: TMenuItem;
    actStockTransferEntryBatch: TDNMAction;
    actStockTransferEntryBin: TDNMAction;
    actStockTransferEntrySN: TDNMAction;
    actStockTransferEntryListBAtch: TDNMAction;
    actStockTransferEntryListBin: TDNMAction;
    actStockTransferEntryListSN: TDNMAction;
    actStockTransferEntryTree: TDNMAction;
    actStockAdjustEntryflat: TDNMAction;
    actStockTakeList: TDNMAction;
    actEmailedReports: TDNMAction;
    actScheduledReports: TDNMAction;
    actProductReportByPeriod: TDNMAction;
    actCAR: TDNMAction;
    actCarList: TDNMAction;
    actPayHoursList: TDNMAction;
    actStockValue: TDNMAction;
    actProductBuyPriceList: TDNMAction;
    actProductQtyAdjOptions: TDNMAction;
    actProfitandLossPeriodCompare: TDNMAction;
    actRefundSalesList: TDNMAction;
    RefundSalesReport1: TMenuItem;
    CustomerReturn1: TMenuItem;
    CustomerReturnList1: TMenuItem;
    N34: TMenuItem;
    ProfitandLosscharts1: TMenuItem;
    PnLCompareGross1: TMenuItem;
    PnLCompareRevenue1: TMenuItem;
    GrossProfitChart1: TMenuItem;
    actSupplierSkillList: TDNMAction;
    actEmployeeTaxList: TDNMAction;
    actPaymentMethodList: TDNMAction;
    actPaymentMethod: TDNMAction;
    PaymentMethodList1: TMenuItem;
    actClientMainContacts: TDNMAction;
    ClientMainContacts1: TMenuItem;
    actShippingList: TDNMAction;
    actSalesAddressLabelPrn: TDNMAction;
    PrintAddressLabels1: TMenuItem;
    actsingleSalesAddressLabelPrn: TDNMAction;
    PrintAddressLabel1: TMenuItem;
    actPOsInvoicedBeforeOrder: TDNMAction;
    POsInvoicedBeforeOrdered1: TMenuItem;
    ExpenseClaim1: TMenuItem;
    actExpenseClaimRequest: TDNMAction;
    ExpenseClaimRequest1: TMenuItem;
    ExpenseClaim2: TMenuItem;
    ExpenseClaimList2: TMenuItem;
    ExpenseClaimRequest2: TMenuItem;
    actProdAttribTemplateFields: TDNMAction;
    actProdAttribTemplateFieldsDEtails: TDNMAction;
    ProductAttributesinSalesTemplatedetails1: TMenuItem;
    ProductAttributesinSalesTemplate1: TMenuItem;
    actSmartOrderRFQs: TDNMAction;
    SmartOrderRFQs1: TMenuItem;
    ProductPictureList1: TMenuItem;
    actImportStockAdjustment: TDNMAction;
    actExportStockAdjustment: TDNMAction;
    actInventoryAssetVsStockStauts: TDNMAction;
    actInventoryAsset: TDNMAction;
    InventoryAssetVsBalancesheet1: TMenuItem;
    actAreaPOLinesDetailsList: TDNMAction;
    mnuSMSRates: TMenuItem;
    actUOMList: TDNMAction;
    UOMList1: TMenuItem;
    PickPackSalesList1: TMenuItem;
    actInt_ATO: TDNMAction;
    actInt_AustPostParcel: TDNMAction;
    actInt_CanadaPost: TDNMAction;
    actInt_CustomerPortal: TDNMAction;
    actInt_Cytrack: TDNMAction;
    actInt_Ebay: TDNMAction;
    actInt_Eftpos: TDNMAction;
    actInt_FedEx: TDNMAction;
    avtInt_Fuel: TDNMAction;
    actInt_GoogleAnalytics: TDNMAction;
    actInt_PNET: TDNMAction;
    actInt_OPOS: TDNMAction;
    actInt_ShoppingCart: TDNMAction;
    actInt_SMS: TDNMAction;
    actInt_Telstra: TDNMAction;
    actInt_TNT: TDNMAction;
    actInt_UPS: TDNMAction;
    actInt_USPS: TDNMAction;
    actInt_Web: TDNMAction;
    actInt_XML: TDNMAction;
    actInt_WalMart: TDNMAction;
    actInt_Woocommerce: TDNMAction;
    actInt_QuickBooks: TDNMAction;
    actInt_Target: TDNMAction;
    actInt_Sony: TDNMAction;
    actInt_Seagate: TDNMAction;
    actInt_Erico: TDNMAction;

    actCustomAccountsReport: TDNMAction;
    actCustomAccountsReportTree: TDNMAction;
    actClockedOnList: TDNMAction;
    actRosterBreakList: TDNMAction;
    actProductPriceList: TDNMAction;
    actERPTip: TDNMAction;
    ERPTip1: TMenuItem;
    actsalesdispatch: TDNMAction;
    actSalesDispatches: TDNMAction;
    actSalesDispatchBatches: TDNMAction;
    actProjectInstallations: TDNMAction;
    ProjectManagersAppointments1: TMenuItem;
    N36: TMenuItem;
    ProjectManagersAppointments2: TMenuItem;
    ColourPreferences1: TMenuItem;
    actSetupPayroll: TDNMAction;
    actSaleCostAndProfit: TDNMAction;
    actOverdueInvoices: TDNMAction;
    OverdueInvoices1: TMenuItem;
    QuickPOS2: TMenuItem;
    actInt_ePadLink: TDNMAction;
    actInt_Scanner: TDNMAction;
    actERPChanges: TDNMAction;
    actSalesOrderProgressPayments: TDNMAction;
    actEmployeeLeaveRequests: TDNMAction;
    actEmployeeLeaveRequest: TDNMAction;
    actSetupEmployee: TDNMAction;
    actSOList: TDNMAction;
    actProductQtyinCrossStockCompanies: TDNMAction;
    actInventoryAssetCheckList: TDNMAction;
    actUnInvoicedPOList: TDNMAction;
    actSpecialForm: TDNMAction;
    N12: TMenuItem;
    SpecialForm1: TMenuItem;
    ImportAPI1: TMenuItem;
    actFileImportAPI: TDNMAction;
    actSoftwareAdditionsAgreement: TMenuItem;
    actNonERPSalesList: TDNMAction;
    NonERPSales1: TMenuItem;
    actNonERPPOList: TDNMAction;
    actPhoneSupportLogList: TDNMAction;
    N37: TMenuItem;
    HowTo1: TMenuItem;
    InstallingTestServer1: TMenuItem;
    UploadingaBackupToERP1: TMenuItem;
    N38: TMenuItem;
    HowTo2: TMenuItem;
    InstallingTestServer2: TMenuItem;
    UploadingaBackupToERP2: TMenuItem;
    ERPPDFDocs1: TMenuItem;
    actHRForm: TDNMAction;
    actHRForms: TDNMAction;
    HRForm1: TMenuItem;
    New1: TMenuItem;
    HRForms1: TMenuItem;
    HRForm2: TMenuItem;
    HRList1: TMenuItem;
    HRForm3: TMenuItem;
    mnuSettingupOffsiteBackup: TMenuItem;
    actDutynHandlingProductList: TDNMAction;
    actERPHelpDoc: TDNMAction;
    HowTO3: TMenuItem;
    ChequeForms1: TMenuItem;
    HowTo4: TMenuItem;
    UsingSmartOrdersandPurchaseOrders1: TMenuItem;
    actPOSCashPayments: TDNMAction;
    NonERPSlaes2: TMenuItem;
    actStateFreightChargeList: TDNMAction;
    StateFreightCharges1: TMenuItem;
    actSimpleTypes: TDNMAction;
    mnutypeCodes: TMenuItem;
    ypeCodes2: TMenuItem;
    PurchaseOrderListDetail1: TMenuItem;
    actProductcustomFieldList: TDNMAction;
    ProductListCustomFields1: TMenuItem;
    actCustomFieldValuesProducts: TDNMAction;
    actCustomFieldValuesAlls: TDNMAction;
    actCustomFieldValuesContacts: TDNMAction;
    actCustomFieldValuesCustomers: TDNMAction;
    actCustomFieldValuesEquipments: TDNMAction;
    actCustomFieldValuesLeadss: TDNMAction;
    actCustomFieldValuesSuppliers: TDNMAction;
    actCustomFieldValuesListProducts: TDNMAction;
    actCustomFieldValuesListContacts: TDNMAction;
    actCustomFieldValuesListCustomers: TDNMAction;
    actCustomFieldValuesListEquipments: TDNMAction;
    actCustomFieldValuesListLeadss: TDNMAction;
    actCustomFieldValuesListSuppliers: TDNMAction;

    CustomisableListProducts1: TMenuItem;
    N39: TMenuItem;
    CustomisableListAll1: TMenuItem;
    CustomisableListCustomers2: TMenuItem;
    CustomisableListEquipment2: TMenuItem;
    CustomisableListSupplier2: TMenuItem;
    CustomisableList1: TMenuItem;
    CustomisableListAll2: TMenuItem;
    CustomisableListProducts2: TMenuItem;
    CustomisableListContacts1: TMenuItem;
    CustomisableListCustomers1: TMenuItem;
    CustomisableListEquipment1: TMenuItem;
    CustomisableListLeads1: TMenuItem;
    CustomisableListSupplier1: TMenuItem;
    CustomisableFields1: TMenuItem;
    CustomisableFieldsProducts1: TMenuItem;
    CustomisableFieldsContacts1: TMenuItem;
    CustomisableFieldsCustomers1: TMenuItem;
    CustomisableFieldsEquipment1: TMenuItem;
    CustomisableFieldsLeads1: TMenuItem;
    CustomisableFieldsSupplier1: TMenuItem;
    mnuCustomFieldValuesListRepairs: TMenuItem;
    CustomisableListRepairs1: TMenuItem;
    actIncomingCustomerOrders: TDNMAction;
    actPurchaseList: TDNMAction;
    actEmployeePayrollSuperByFund: TDNMAction;
    actProductQtylist: TDNMAction;
    actChooseProductList: TDNMAction;
    actInventProductsProductsList1: TDNMAction;
    actProductQtylist1: TDNMAction;
    actInventProductsProductsExpressList1: TDNMAction;
    actStockanalysisReport: TDNMAction;
    StockAnalysisReport1: TMenuItem;
    StockAnalysisReport2: TMenuItem;
    actProjectedManufacturingQty: TDNMAction;
    ProjectedManufacturingQty1: TMenuItem;
    actProductSerialNumberQtyList: TDNMAction;
    ProductSerialNumberQtyList1: TMenuItem;
    actContractorPaymentSummary: TDNMAction;
    actProductStockAndSalesList: TDNMAction;
    actProductformulaTypeList: TDNMAction;
    actProductFormulaType: TDNMAction;
    ProductFormulaType1: TMenuItem;
    ProductFormulaTypeList1: TMenuItem;
    actGoodsReceipt: TDNMAction;
    actGoodsReceiptList: TDNMAction;
    actMainswitchHeightIncrease: TDNMAction;
    actMainswitchHeightdecrease: TDNMAction;
    actMainswitchHeightDefault: TDNMAction;
    actSerialNumberList: TDNMAction;
    actSerialjobnumbers: TDNMAction;
    SerialNumberBatch1: TMenuItem;
    actSerialNumbers: TDNMAction;
    actERPPDFDocs: TDNMAction;
    actBankTransactionList: TDNMAction;
    actBankTransactionImport: TDNMAction;
    BankTransactionImport1: TMenuItem;
    BankTransactionList1: TMenuItem;
    actSerialNoTabletAllocation: TDNMAction;
    mnuSerialNoTabletAllocation: TMenuItem;
    actPriceMatrixHelp: TDNMAction;
    InvoiceInternalOrderExpressList1: TMenuItem;
    actAlternateProductList: TDNMAction;
    AlternateProductList1: TMenuItem;
    ProductExtraBuyPrices1: TMenuItem;
    actBackorderPurchaseOrderChangeList: TDNMAction;
    actAlternateProducts: TDNMAction;
    ProductBuyPriceList1: TMenuItem;
    actAccountsJournalEntries: TDNMAction;
    JournalEntries1: TMenuItem;
    actUserPasswordDetails: TDNMAction;
    UserPasswordDetails1: TMenuItem;
    actReportsAttributesProductSalesSummary: TDNMAction;
    actPrejerence: TDNMAction;
    PrejerenceList1: TMenuItem;
    actEmpPayRunList: TDNMAction;
    PayRunList: TMenuItem;
    actWalmartitems: TDNMAction;
    actWoocommitems: TDNMAction;
    actWalmartSalesOrders: TDNMAction;
    actWooCommerceInvoices: TDNMAction;
    Walmart1: TMenuItem;
    WalmartProducts1: TMenuItem;
    Walmart2: TMenuItem;
    Walmart3: TMenuItem;
    Walmart13: TMenuItem;
    actwalmartshippingmethods: TDNMAction;
    WalmartShippingMethods1: TMenuItem;
    actInt_WalMartOrders: TDNMAction;
    actInt_WoocommCustomers: TDNMAction;
    actInt_WalmartFeeds: TDNMAction;
    Walmart4: TMenuItem;
    actAmazonEdiOrderList: TDNMAction;
    actInt_Amazon: TDNMAction;
    actAmazonSalesOrderExpressList: TDNMAction;
    actAmazonInvoiceExpressList: TDNMAction;
    actVATObligationList: TDNMAction;
    DNMAction1: TDNMAction;
    actUSPayrollforms: TDNMAction;
    acttrialbalanceadjsutemnt: TDNMAction;
    WooCommerce1: TMenuItem;
    WooCommerceOrders1: TMenuItem;
    WooCommerce2: TMenuItem;
    actint_SPS: TDNMAction;
    actint_Magento: TDNMAction;
    actint_AvaTax: TDNMAction;
    actInt_GoogleCalendar: TDNMAction;
    actInt_HMRC: TDNMAction;
    actInt_Stripe: TDNMAction;
    actInt_PaymentExpress: TDNMAction;
    actInt_Payeezy: TDNMAction;
    actInt_Endica: TDNMAction;
    actInt_VAT: TDNMAction;
    actInt_ERPAPI: TDNMAction;
    actInt_Stamps: TDNMAction;
    actProductSumQtyList: TDNMAction;
    actQuickbooksSynchList: TDNMAction;
    NonERPPurchases1: TMenuItem;
    actMagentoOrders: TDNMAction;
    actEDISynchList: TDNMAction;
    actInt_EDISynch: TDNMAction;
    actMagentoProducts: TDNMAction;
    actMagentoCustomers: TDNMAction;
    actERPUpdateFix: TDNMAction;
    ProductQtyFix1: TMenuItem;
    ProductsExpressList3: TMenuItem;
    actProductOptions: TDNMAction;
    ProductOptions: TMenuItem;
    actEDIConnectionsList: TDNMAction;
    actint_CoreEDIService: TDNMAction;
    actColesSalesOrderExpressList: TDNMAction;
    actint_CoreEDIService_Help: TDNMAction;
    actColesORDRSPExpressList: TDNMAction;
    actColesInvoiceExpressList: TDNMAction;
    actColesDESADVExpressList: TDNMAction;
    actColesREMADVExpressList: TDNMAction;
    actPayrollDataRecoverFix: TDNMAction;
    NonERPClone1: TMenuItem;
    procedure actAboutUpdateNotesExecute(Sender: TObject);
    procedure actAccountsAccountsListExecute(Sender: TObject);
    procedure actAccountsRefreshBatchTransactionExecute(Sender: TObject);
    procedure actApptsNewJobExecute(Sender: TObject);
    procedure actEmployeePersonalPreferencesExecute(Sender: TObject);
    procedure actSTPPreferencesExecute(Sender: TObject);
    procedure actEmployeeResetPersonalTabsExecute(Sender: TObject);
    procedure actFileExitExecute(Sender: TObject);
    //procedure actInventStockStockAdjustmentExecute(Sender: TObject);
    procedure actInventStockStockTakeExecute(Sender: TObject);
    procedure actPaymentsReceivedBulkPaymentsExecute(Sender: TObject);
    procedure actReportsAccountsExecute(Sender: TObject);
    procedure actReportsAppointmentsExecute(Sender: TObject);
    procedure actReportsBankingExecute(Sender: TObject);
    procedure actReportsCustomReportsExecute(Sender: TObject);
    procedure actReportsEmployeeExecute(Sender: TObject);
    procedure actReportsFixedAssetsExecute(Sender: TObject);
    procedure actReportsInventoryExecute(Sender: TObject);
    procedure actReportsPaymentsExecute(Sender: TObject);
    procedure actReportsPayrollExecute(Sender: TObject);
    procedure actReportsPurchasesExecute(Sender: TObject);
    procedure actReportsQuoteStatusExecute(Sender: TObject);
    procedure actReportsSalesExecute(Sender: TObject);
    procedure actSalesCRMCompanyTypesExecute(Sender: TObject);
    procedure actSalesCRMFollowUpResultTypesExecute(Sender: TObject);
    procedure actSalesCRMPhoneContactExecute(Sender: TObject);
    procedure actSalesCRMReportsExecute(Sender: TObject);
    procedure actSalesCustomersCustomerAccountNoSetupExecute(Sender: TObject);
    procedure actUtilsAuditTrailExportAuditTrailExecute(Sender: TObject);
    procedure actUtilsAuditTrailPurgeAuditTrailExecute(Sender: TObject);
    procedure actUtilsCurrentUsersExecute(Sender: TObject);
    procedure actUtilsDBUtilsCopyExecute(Sender: TObject);
    procedure actUtilsDBUtilsRemoveExecute(Sender: TObject);
    procedure actUtilsFaxJobsPurgeOldFaxJobsExecute(Sender: TObject);
    procedure actWindowCustomiseToolbarExecute(Sender: TObject);
    procedure actUtilsDBUtilsBackupExecute(Sender: TObject);
    procedure actUtilsDBUtilsRestoreExecute(Sender: TObject);
    procedure actApptsJobListExecute(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure SetImageList(const ImgList: TImageList; const Resname: string);
    procedure actWindowTiledExecute(Sender: TObject);
    procedure actWindowCascadeExecute(Sender: TObject);
    procedure actWindowArrangeIconsExecute(Sender: TObject);
    procedure actFileNewCompanyExecute(Sender: TObject);
    procedure actFileOpenCompanyExecute(Sender: TObject);
    //procedure GetImageListsDLL;
    procedure actSalesCRMFollowUpTypesExecute(Sender: TObject);
    procedure Contents2Click(Sender: TObject);
    procedure LicenceAgreement1Click(Sender: TObject);
    procedure TrainingGuideMnuClick(Sender: TObject);
    procedure actEmployeeAccessLevelsExecute(Sender: TObject);
    procedure actSalesPrintPickSlipsExecute(Sender: TObject);
    procedure actReportsCRMExecute(Sender: TObject);
    procedure actReportsJobsExecute(Sender: TObject);
    procedure actHireItemReportExecute(Sender: TObject);
    procedure TrainingVideos1Click(Sender: TObject);
    procedure Utilities2Click(Sender: TObject);
    procedure actBarcodeActionExecute(Sender: TObject);
    procedure miWindowClick(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure actReportsGeneralExecute(Sender: TObject);
    procedure actReportsUtilitiesExecute(Sender: TObject);
    procedure actReportsPOSExecute(Sender: TObject);
    procedure actPaymentsReconcileExecute(Sender: TObject);
    procedure actLeadStatusTypeExecute(Sender: TObject);
    procedure actShippingContainerStatusExecute(Sender: TObject);
    procedure ActiveForms2Click(Sender: TObject);
    procedure actEmployeeGlobalListExecute(Sender: TObject);
    procedure actReportsWorkShopExecute(Sender: TObject);
    procedure actVidoesExecute(Sender: TObject);
    procedure actAutoAdjustbinExecute(Sender: TObject);
    procedure actAppointmentStatusListExecute(Sender: TObject);
    procedure actMessagesExecute(Sender: TObject);
    procedure actRemindersExecute(Sender: TObject);
    procedure actCustomiseExecute(Sender: TObject);
    procedure Maximise1Click(Sender: TObject);
    procedure mnuLanguageClick(Sender: TObject);
    procedure actUtilsPreferencesExecute(Sender: TObject);
    procedure actPhoneSupportTypeListExecute(Sender: TObject);
    procedure actPhoneSupportVersionListExecute(Sender: TObject);
    procedure actreportsGoogleExecute(Sender: TObject);
    procedure LaunchListWithDefaultGraph(Sender: TObject);
    procedure ProfitnLosschart_REv_Exp(Sender: TObject);
    procedure actProfitnLosschartCompareGrossClick(Sender: TObject);
    procedure actProfitnLosschartCompareRevenueClick(Sender: TObject);
    procedure actProfitnLosschartCompareNIclick(Sender: TObject);
    procedure ProfitnLosschart_GrossProfit(Sender: TObject);
    procedure actUtilsDbUtilsCopyROExecute(Sender: TObject);
    procedure actAuseParcelconfUpdate(Sender: TObject);
    procedure actcolorPrefsExecute(Sender: TObject);
    procedure mnuSMSRatesClick(Sender: TObject);
    procedure actIntegrationExecute(Sender: TObject);
    procedure actERPTipExecute(Sender: TObject);
    procedure actStockTransferEntryBinHint(var HintStr: string;
      var CanShow: Boolean);
    procedure actProductQtyinCrossStockCompaniesUpdate(Sender: TObject);
    procedure actFileImportAPIExecute(Sender: TObject);
    procedure actSoftwareAdditionsAgreementClick(Sender: TObject);
    procedure OpenProductList(Sender: TObject);
    procedure actStockanalysisReportExecute(Sender: TObject);
    procedure actMainswitchHeightIncreaseExecute(Sender: TObject);
    procedure actMainswitchHeightdecreaseExecute(Sender: TObject);
    procedure actMainswitchHeightDefaultExecute(Sender: TObject);
    procedure actPriceMatrixHelpExecute(Sender: TObject);
    procedure actInt_WalMartExecute(Sender: TObject);
    procedure actInt_WalMartOrdersExecute(Sender: TObject);
    procedure actInt_WoocommExecute(Sender: TObject);
    procedure actint_CoreEDIService_HelpExecute(Sender: TObject);
    procedure NonERPClone1Click(Sender: TObject);
   private
    WindowList: TStringList;
    MsgHandler: TMsgHandler;
    WindowItemcount:Integer;
    {$IFDEF DevMode}
    fsSearchForMenu:String;
    {$ENDIF}
    UnallocatedBinQtyList: TBaseListingGUI;
    procedure CreateNewJob(const Sender: TObject);
    function LaunchList(const Sender: TObject; const sListClass: string; const ListName: string = ''; groupFilterItemIndex:Integer =-1):TComponent;
    procedure OpenCustomReport(const sListClass: string; const iGuiID: integer;ReportName:String);
    procedure ShowCurrentlyLoggedUsers;
    procedure ShowJobList(const Sender: TObject);
    procedure SetActiveWindow(Sender: TObject);
    procedure AddCustomReports;
    procedure OnMyreportSelect(Sender: TObject);
    Procedure AddLanguageMenuItems;
    procedure InitReturnMenuItems(Inputform, listform, Category: String);
    procedure InitPayrollMenuItems(Inputform, listform, Category: String);
    procedure SetGoogleActions;
    procedure DoOnUnallocatedBinQtyListSelect(Sender: TwwDbGrid);
    Procedure InitAreacolumnnname;
    procedure MakesimpletypeMenuItems;
    procedure SimpleTypeList(Sender: TObject);Overload;
    Procedure SimpleTypeList(const sSimpletype:String);Overload;
    Procedure MakeERPHelpDocActions;
    procedure afterproductformshow(Sender: TObject);

  public
    procedure ShowSelectedLanguage(Selectelangid: Integer);
    constructor Create(AOwner: TComponent); override;
    procedure Maximiseform(Sender: TObject);
    procedure Launchchart(const Sender: TObject; const sListClass: string; Chartname: String=''; const ListName: string=''; showasMax:boolean =False; groupFilterItemIndex:Integer =-1);

    procedure HowToExtraButtonClick(Sender : TObject);

    {$IFDEF DevMode}
    procedure DevModeShowForm(Sender: TObject);
    Procedure DevModeexportGuiPref(Sender: TObject);
    Procedure DevModeERPPasswords(Sender: TObject);
    Procedure DevModeformPropertyReader(Sender: TObject);
    Procedure DevModeExportnUploadLanguage(Sender: TObject);
    Procedure DevModeErpPDFDocs(Sender: TObject);
    Procedure DevModeexportImages(Sender: TObject);
    Procedure DevModeQryanalyser(Sender: TObject);
    Procedure DevModeCopyBackup(Sender: TObject);
    Procedure DevmodeRunScript(Sender:TObject);
    Procedure LogEnglish(Sender:TObject);
    Procedure ShowDevForms(Sender:TObject);
    procedure CrashMe(Sender: TObject);
    Procedure OpenContactList(Sender: TObject);
    Procedure initContactList(Sender: TObject);
    Procedure SearchForMenu(const Value :String); overload;
    function  SearchForMenu(mnu :TMenuItem; const Value :String):Boolean;overload;
    function showmenutree(mnu :TMenuItem):String;
    procedure DoSendSMS(Sender: TObject);


  {$IFDEF BUSOBJ_FILTER_LIST}
    procedure ClickBusObjFilterList(Sender: TObject);
  {$ENDIF}
{$ENDIF}
  {$IFDEF GET_HELPCONTEX_INFO}
    procedure ClickHelpContextInfo(Sender: TObject);
  {$ENDIF}
    procedure AssociateClassNamesWithActions(aActionList: TActionList); override;
//    procedure CheckOtherUsersOnline;
  Function ImageListSmlIcons: TImageList;
  end;

  TGetImageListFunc = function : TImageList;


var
  dtmMainGUI: TdtmMainGUI;

implementation

{$R *.dfm}

uses FastFuncs,Forms,  CommonDBLib, CommonLib, DNMLib, ActionsObj,
     TableFunctionsObj,
     TransactionsTable,
     MyAccess,ERPdbComponents, AuditTrailObj,
     ShellAPI, TypInfo,
     MenuCustomiseForm, Main, MainSwitchFrm2,
     PackageControl,
     Preferences,tcTypes, JSonImport, DocReaderObj,
{$IFDEF NEW_VERIFY}
     VerifyTask,
{$ENDIF}
     frmSimpleTypes,
     BarcodeActionObj, StrUtils, AppEnvironment, AppHelpProcessorObj,
  AddinPackageInfoObj, tcconst,BusObjSimpleTypes, frmStockAdjustEntryFlat,
  BusobjStockAdjustEntry, StockAdjustEntryList, CommonFormLib,
  AppContextObj, BaseFormForm, LanguageTranslationObj,
  JsonObject, PreferenceLib, frmAuditExportPerge{$IFDEF DevMode}, frmComboInput{$ENDIF},
  tcDataUtils, frmStockAdjustEntry, SystemLib,  contacts,
  POSTillsGUI, ERPMessageGUILib, ImagesDatamodule, InventoryLib, BaseInputForm,
  SimpleTypes, DbSharedObjectsObj, EdiGuiUtilsObj, frmFollowUp,
  frmSeqNumbersGUI;



constructor TdtmMainGUI.Create(AOwner: TComponent);
{$IFDEF DevMode}
var
  lItem: TMenuItem;
  Devmodemenu: TMenuItem;
  //Workflowmenu: TMenuItem;
{$ENDIF}
begin
  inherited;
  { employee termination needs updating, remove for now }
  actEmployeeTerminationList.Free;
  actEmployeeTerminationList := nil;
  actEmployeeTerminateEmployee.Free;
  actEmployeeTerminateEmployee:= nil;

  //MakeERPHelpDocActions;

  {$IFDEF DevMode}

    Devmodemenu := TMenuItem.Create(Self);
    Devmodemenu.Caption := 'Dev Mode';
    MainMenu.Items.Add(Devmodemenu);


    lItem := TMenuItem.Create(Self);
    lItem.Caption := '&Show Form';
    lItem.OnClick := DevModeShowForm;
    Devmodemenu.Add(lItem);

    lItem := TMenuItem.Create(Self);
    lItem.Caption := 'Export GuiPref';
    lItem.OnClick := DevModeexportGuiPref;
    Devmodemenu.Add(lItem);

    lItem := TMenuItem.Create(Self);
    lItem.Caption := 'ERP Passwords';
    lItem.OnClick := DevModeERPPasswords;
    Devmodemenu.Add(lItem);

    lItem := TMenuItem.Create(Self);
    lItem.Caption := 'Form Property Reader';
    lItem.OnClick := DevModeformPropertyReader;
    Devmodemenu.Add(lItem);

    lItem := TMenuItem.Create(Self);
    lItem.Caption := 'Copy Backup';
    lItem.OnClick := DevModeCopyBackup;
    Devmodemenu.Add(lItem);


    lItem := TMenuItem.Create(Self);
    lItem.Caption := 'Export n Upload Language';
    lItem.OnClick := DevModeExportnUploadLanguage;
    Devmodemenu.Add(lItem);

    lItem := TMenuItem.Create(Self);
    lItem.Caption := 'ERP PDF Docs';
    lItem.OnClick := DevModeErpPDFDocs;
    Devmodemenu.Add(lItem);

    lItem := TMenuItem.Create(Self);
    lItem.Caption := 'Export Images';
    lItem.OnClick := DevModeexportImages;
    Devmodemenu.Add(lItem);

    lItem := TMenuItem.Create(Self);
    lItem.Caption := 'Run Script';
    lItem.OnClick := DevmodeRunScript;
    Devmodemenu.Add(lItem);

    lItem := TMenuItem.Create(Self);
    lItem.Caption := '&Log English';
    lItem.OnClick := LogEnglish;
    Devmodemenu.Add(lItem);

    lItem := TMenuItem.Create(Self);
    lItem.Caption := 'Query Analyser';
    lItem.OnClick := DevModeQryanalyser;
    Devmodemenu.Add(lItem);

    lItem := TMenuItem.Create(Self);
    lItem.Caption := 'Send SMS';
    lItem.OnClick := DoSendSMS;
    Devmodemenu.Add(lItem);

    lItem := TMenuItem.Create(Self);
    lItem.Caption := '&Dev Forms';
    lItem.OnClick := ShowDevForms;
    Devmodemenu.Add(lItem);

    lItem := TMenuItem.Create(Self);
    lItem.Caption := 'Crash Me';
    lItem.OnClick := CrashMe;
    Devmodemenu.Add(lItem);

    lItem := TMenuItem.Create(Self);
    lItem.Caption := 'Contact List';
    lItem.OnClick := OpenContactList;
    Devmodemenu.Add(lItem);

      {$IFDEF GET_HELPCONTEX_INFO}
        lItem := TMenuItem.Create(Self);
        lItem.Caption := 'Create Help Context Info';
        lItem.OnClick := ClickHelpContextInfo;
        Devmodemenu.Add(lItem);
      {$ENDIF}

      {$IFDEF BUSOBJ_FILTER_LIST}
        lItem := TMenuItem.Create(Self);
        lItem.Caption := 'Bus Obj Filter List';
        lItem.OnClick := ClickBusObjFilterList;
        Devmodemenu.Add(lItem);
      {$ENDIF}
  {$ENDIF}
end;

{$IFDEF GET_HELPCONTEX_INFO}
procedure TdtmMainGUI.ClickHelpContextInfo(Sender: TObject);
Var
  I: Integer;
  tmpComp: TComponent;
  DoneList: TStringList;
begin
  tmpComp:= nil;
  DoneList := TStringList.Create;
  try
    AllRegisteredClass.SaveToFile('c:\AllRegisteredClass.txt');
    for I := 0 to AllRegisteredClass.Count-1 do begin
      try
        tmpComp := GetComponentByClassName(AllRegisteredClass[I],False,nil,False,False,19191);
        DoneList.Add('Created - '+AllRegisteredClass[I]);
      except
        on E: exception do begin
          DoneList.Add('FAILED - '+AllRegisteredClass[I] + '  With exception: ' + E.Message);
          Continue;
        end;
      end;
      Application.ProcessMessages;
      try
        If Assigned(tmpComp) then
          If tmpComp is TCustomForm then
            TCustomForm(tmpComp).Release
          else
            tmpComp.Free;
      except
        on E: exception do begin
          DoneList.Add('FAILED - Destroying: '+AllRegisteredClass[I] + '  With exception: ' + E.Message);
          Continue;
        end;
      end;
      Application.ProcessMessages;
      Sleep(1);
    end;
  finally
     DoneList.SaveToFile('c:\doneLog.txt');
     DoneList.Free;
     MessageDlgXP_Vista('Done!', mtConfirmation, [mbOK], 0);
  end;
end;
{$ENDIF}


{$IFDEF DevMode}
procedure TdtmMainGUI.DevModeShowForm(Sender: TObject);
var
  lClassName: string;
  lForm: TComponent;
  FileName: string;
begin
 (* FileName:= SystemLib.ExeDir + 'Last Show Form Name.txt';
  if FileExists(FileName) then begin
    with TStringList.Create do begin
      LoadFromFile(FileName);
      s:= Text;
      Free;
    end;
  end;
  lClassName := Trim(InputBox('Dev Mode - Show Form', 'Class Name:', s));
  if lClassName <> '' then begin
    with TStringList.Create do begin
      Text:= lClassName;
      SaveToFile(FileName);
      Free;
    end;
  end;*)
  FileName:= SystemLib.ExeDir + 'Last Show Form Name.txt';
  lClassName := ComboInput(filename, 'Dev Mode - Show Form' , 'Class Name:' , (Sender<> nil)  );
  if lClassName = '' then Exit;
    Processingcursor(True);
    try

      lForm := GetComponentByClassName(lClassName);
      if Assigned(lForm) and (lForm is TForm) then begin
        TForm(lForm).FormStyle := fsMDIChild;
        TForm(lForm).BringToFront;
      end;
    finally
      Processingcursor(False);
    end;
  end;
Procedure TdtmMainGUI.initContactList(Sender: TObject);
begin
  if not(sender is TcontactsGUI) then exit;
  TcontactsGUI(Sender).Stringtosearch := inputbox('string to search','', '' );
end;
Procedure TdtmMainGUI.OpenContactList(Sender: TObject);
begin
  OpenERPListForm('TcontactsGUI', initContactList);
end;


procedure TdtmMainGUI.CrashMe(Sender: TObject);
var
  st: TSimpleTypes;
begin
  st:= nil;
  if MessageDlgXP_Vista('ERP will crash now ', mtWarning, mbYesNoCancel, 0) <> mryes then exit;
  ShowMessage(st.TypeName);
end;

{$ENDIF}

function TdtmMainGUI.LaunchList(const Sender: TObject; const sListClass: string; const ListName: string = ''; groupFilterItemIndex:Integer =-1):Tcomponent;
var
  C: TClass;
  frmList: TBaseListingGUI;
  SummarySheet: TComponent;
begin
  result:= nil;
  C := GetClass(sListClass);

  if Assigned(C) then begin
    if sListClass = 'TfrmSummarySheetGUI' then begin
      SummarySheet := GetComponentByClassName('TfrmSummarySheetGUI', true);
      if Assigned(SummarySheet) then begin //if has acess
        REsult:= SummarySheet;
        with TForm(SummarySheet) do begin
          AssignActionBitmap(Sender, TForm(SummarySheet));
          FormStyle := fsMDIChild;
          BringToFront;
        end;
      end;
    end else begin
      frmList := TBaseListingGUI(GetComponentByClassType(TPersistentClass(C), true));
      if Assigned(frmList) then begin //if has acess
        REsult:= frmList;
        AssignActionBitmap(Sender, frmList);
        if groupFilterItemIndex >=0 then begin
          frmList.grpfilters.ItemIndex :=groupFilterItemIndex;
          frmList.GrpfilterSupplied := True;
        end;
        frmList.FormStyle := fsmdiChild;
        //Rename List;
        if not Empty(ListName) then begin
          frmList.TitleLabel.Caption := ListName;
          frmList.Caption := ListName;
        end;
      end;
    end;
  end else begin
    CommonLib.MessageDlgXP_Vista('This List is not registered for Customization (' + sListClass + ')',
      mtWarning, [mbOK], 0);
  end;
end;

procedure TdtmMainGUI.LaunchListWithDefaultGraph(Sender: TObject);
var
  Listclass:String;
begin
  inherited;
  if Sender is TDNMAction then begin
      listClass:= TDNMAction(Sender).ClassExecute;
      if listClass<> '' then begin
        Launchchart(Sender , listClass );
      end;
  end;
end;

procedure TdtmMainGUI.CreateNewJob(const Sender: TObject);
Var Form : TComponent;
begin
    Form := GetComponentByClassName('TJobGUI', true);
    if Assigned(Form) then begin //if has acess
      with TBaseInputGUI(Form) do begin
        AssignActionBitmap(Sender,TBaseInputGUI(form));
        KeyID := 0;
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
end;

procedure TdtmMainGUI.ShowJobList(const Sender: TObject);
Var Form : TComponent;
begin
    Form := GetComponentByClassName('TJobListGUI', true);
    if Assigned(Form) then begin //if has acess
      with TBaseListingGUI(Form) do begin
        AssignActionBitmap(Sender, TBaseListingGUI(Form));
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
end;

procedure TdtmMainGUI.ShowCurrentlyLoggedUsers;
var
  userlist, userItem: TJsonObject;
  x: integer;
begin
  dlgCurrentUsers.Items.Clear;
  userlist:= AppEnv.UtilsClient.GetFullUserList;
  if Assigned(userlist) then begin
    for x:= 0 to userlist.Count -1 do begin
      userItem:= userlist.O[IntToStr(x)];
      dlgCurrentUsers.Items.Add(userItem.S['username'] + ' [' + userItem.S['databasename'] + ']');
    end;
    dlgCurrentUsers.Caption := 'ERP Users';
    dlgCurrentUsers.Message := ' Current ERP Users (all databases) ';
    dlgCurrentUsers.Color := clMoneyGreen;
    dlgCurrentUsers.Execute;
  end
  else begin
    MessageDlgXP_Vista('Unable to retrieve list of logged on users at this time.', mtInformation, [mbOk], 0);
  end;
end;

procedure TdtmMainGUI.SetImageList(Const ImgList: TImageList; Const Resname: string);
var
  bm: TBitmap;
begin
  bm := TBitmap.Create;
  try
    bm.LoadFromResourceName(hinstance, Resname);
    ImgList.AddMasked(bm, bm.TransparentColor);
  finally
    FreeandNil(bm);
  end;
end;

{$IFDEF DevMode}
Procedure TdtmMainGUI.LogEnglish(Sender:TObject);
begin
    if screen.activeform = nil then exit;
end;


Procedure TdtmMainGUI.showDevForms(Sender:TObject);
begin
  OpenERPform('TfmDevForms',0);
end;
{$ENDIF}
function TdtmMainGUI.ImageListSmlIcons: TImageList;
begin
  REsult := ImgDatamodule.ImageListSmlIcons;
end;

procedure TdtmMainGUI.InitAreacolumnnname;
begin
  actAreaPOLinesDetailsList.caption := AppEnv.CompanyPrefs.Areacolumnname +' Product List';
end;
procedure TdtmMainGUI.InitPayrollMenuItems(Inputform, listform, Category: String);
begin
     ActionHelper.AssociateActionWithClassName('actEmployeePayrollPayStaff', listform);
end;
Procedure TdtmMainGUI.InitReturnMenuItems(Inputform, listform, Category:String);
begin
     ActionHelper.AssociateActionWithClassName('actReportsBAS', Inputform);
     actReportsBAS.Caption := Category +' Return';
     ActionHelper.AssociateActionWithClassName('actReportsBASList', listform);
     actReportsBASList.Caption := Category +' Return List';
     mnuTaxreport.Caption := Category ;
     if Sametext(Category , 'VAT') then begin
        ActionHelper.AssociateActionWithClassName('actEmployeePayrollPAYGSummary', 'TPAYGPaymentSummaryListGUI');
        actEmployeePayrollPAYGSummary.Caption := 'W-2 Statements';//'PAYE Payment Summary'; // dene asked to change the label
     end;
end;

{$IFDEF DevMode}
function TdtmMainGUI.showmenutree(mnu :TMenuItem):String;
var
  s:String;
  obj :TObject;
begin
  s:= mnu.Caption;
  obj := mnu.Parent;
  while (obj <> nil) and (obj is TMenuitem) do begin
    if tmenuitem(obj).Caption <> '' then s:= replacestr(tmenuitem(obj).Caption, '&' , '') +'->' + s;
    obj :=tmenuitem(obj).Parent;
  end;
  result:= s;
end;
function TdtmMainGUI.SearchForMenu(mnu :TMenuItem; const Value :String):Boolean;
var
  ctr:Integer;
begin
  REsult:= False;
  if mnu.Count =0 then begin
    result:= sameTExt(mnu.Caption , value) or Commonlib.StartsWith(mnu.caption, Value) or Commonlib.Stringcontains(mnu.caption, Value);
    if result then fsSearchForMenu := fsSearchForMenu +chr(13)+ showmenutree(mnu);
  end else begin
    for ctr:= 0 to mnu.Count -1 do begin
      SearchForMenu(mnu.items[ctr] , value);
    end;
  end;
end;

Procedure TdtmMainGUI.SearchForMenu(const Value :String);
var
  ctr:Integer;
begin
  fsSearchForMenu :='';
  for ctr:= 0 to MainMenu.items.count-1 do begin
    SearchForMenu(MainMenu.items[ctr] , value) ;
  end;
  if fsSearchForMenu <> '' then
    MessageDlgXP_Vista(trim(fsSearchForMenu), mtInformation, [mbOK], 0);
end;

{$ENDIF}

procedure TdtmMainGUI.AssociateClassNamesWithActions(aActionList: TActionList);
var
  i: integer;
  Action: TDNMAction;
begin
  // here all actions need to be associated with its corresponding form class

  //Action names should be unique to differentiate between different packagages.
  //example
  for i := 0 to ActionList.Actioncount - 1 do begin
    Action := TDNMAction(ActionList.Actions[I]);
    try
      if not (Action is TDNMAction) then begin
        if Devmode then showmessage('Action is of wrong type '+ Action.Name);
        continue;
      end;

      if (Action.Name = 'actQuestionMark') or (Action.Name = 'actUpdateNotes') then Continue;
      ActionHelper.AssociateActionWithClassName(Action.Name, Action.ClassExecute, Action.Description);
    except
      on e: exception do begin
       //if Devmode then showmessage('Error: Index: ' + IntToStr(i) + '  ' + Action.Name + '  ' + e.Message );
      end;
    end;
  end;

    ActionHelper.AssociateActionWithClassName('actApptsNewJob', 'TJobGUI');
    ActionHelper.AssociateActionWithClassName('actApptsJobList', 'TJoblistGUI');

  if AppEnv.CompanyPrefs.DefaultToChartOfAccountsTreeView then
    ActionHelper.AssociateActionWithClassName('actAccountsAccountsList','TfmChartOfAccountsTree')
  else
    ActionHelper.AssociateActionWithClassName('actAccountsAccountsList', 'TChartOfAccountsListGUI');

  // Tax Reports
  if (AppEnv.RegionalOptions.RegionType = rAust ) then Begin
     InitReturnMenuItems('TfmBASReturn' ,'TBasReturnListGUI' , 'BAS');
  end else if (AppEnv.RegionalOptions.RegionType = rNZ) then Begin
     InitReturnMenuItems('TfmNZReturn' ,'TNZReturnlistGUI' , 'GST');
  end else if (AppEnv.RegionalOptions.RegionType = rUK) then Begin
     { rUK and everewhere else }
     InitReturnMenuItems('TfmVATReturn' ,'TVATReturnListGUI' , 'VAT');
  end else if (AppEnv.RegionalOptions.RegionType = rUSA) then Begin

  end else begin

  end;

  // payroll
//  if (AppEnv.RegionalOptions.RegionType = rUSA) then Begin
//    InitPayrollMenuItems('TfmEmployeePayUSA','TfmPaySummaryUSA',  'USA');
//  end else begin
//     InitPayrollMenuItems('TfrmEmployeePay', 'TfrmPaySummary', '');
//  end;

  // Remove Non UK Stuff

  if (AppEnv.RegionalOptions.RegionType <> rAust) then Begin
    actFileImportTNTClientRates.Visible := False;
    actFileImportTNTClientRates.Enabled := False;
    actFileImportTNTPostcodeToRating.Enabled := False;
    actFileImportTNTPostcodeToRating.Visible := False;
    NT2.Visible := False;
    imeSheetEntry2.Enabled := False;
    imeSheetEntry2.Visible := False;
    N190.Visible := False;
  end;
  actUSPayrollforms.Visible := AppEnv.RegionalOptions.RegionType = rUSA;

  (*actInt_WalMart.visible := AppEnv.CompanyPrefs.EnableWalmart;
  actWalmartitems.visible := AppEnv.CompanyPrefs.EnableWalmart;
  actWalmartSalesOrders.visible := AppEnv.CompanyPrefs.EnableWalmart;
  actwalmartshippingmethods.visible := AppEnv.CompanyPrefs.EnableWalmart;
  actWalmartPreferences.visible := AppEnv.CompanyPrefs.EnableWalmart;*)

  actEBayOrders.visible := AppEnv.CompanyPrefs.ShowEbayonMainMenubyDefault;
  actEBaySalesOrders.visible := AppEnv.CompanyPrefs.ShowEbayonMainMenubyDefault;
  //mnuEdiModules.visible := AppEnv.CompanyPrefs.EnableEbay or AppEnv.CompanyPrefs.EnableWalmart;

end;

procedure TdtmMainGUI.actApptsNewJobExecute(Sender: TObject);
begin
  inherited;
  CreateNewJob(Sender);
end;

procedure TdtmMainGUI.actApptsJobListExecute(Sender: TObject);
begin
  inherited;
  ShowJobList(Sender);
end;


(*procedure TdtmMainGUI.GetImageListsDLL;
begin
  ImageDLL.Images_ResToImageList(IMageListNew, true);
  ImageDLL.Images_ResToImageList(IMageListSmlIcons, False);
end;*)


(*procedure TdtmMainGUI.GetImageListsDLL;
var
  Handle: THandle;
  GetImageListFunc: TGetImageListFunc;
begin
  Handle := LoadLibrary(pchar(SystemLib.ExeDir + 'DllImages.dll'));
  if Handle <> 0 then begin
    Try
      @GetImageListFunc := GetProcAddress(Handle, 'GetImageList');
      if @GetImageListFunc <> nil then
      begin
        IMageListNew.AddImages(GetImageListFunc);
      end;
      GetImageListFunc.Clear;
      @GetImageListFunc := GetProcAddress(Handle, 'GetImageListSmlIcons');
      if @GetImageListFunc <> nil then
      begin
        IMageListSmlIcons.AddImages(GetImageListFunc);
      end;
    Finally
      FreeLibrary(Handle);
    end;
  end;
end;*)
Procedure TdtmMainGUI.SetGoogleActions;
begin
    actGoogleAnalysisReport_Language.caption := 'Google Report ' + (*NL+*) 'Language';
    actGoogleAnalysisReport_Location.caption := 'Google Report ' + (*NL+*) 'Location';
    actGoogleAnalysisReport_Keyword.caption := 'Google Report ' + (*NL+*) 'Keyword';
    actGoogleAnalysisReport_Campaign.caption := 'Google Report ' + (*NL+*) 'Campaign';
    actGoogleAnalysisReport_Browser.caption := 'Google Report ' + (*NL+*) 'Browser';
    actGoogleAnalysisReport_DayofWeek.caption := 'Google Report ' + (*NL+*) 'Day of the Week';
    actGoogleAnalytic_Summary.Caption := 'Analytics Report ' + (*NL+*) 'Google Summary'
end;

procedure TdtmMainGUI.DataModuleCreate(Sender: TObject);
var
    j :Integer;
    SelAddinInfo: TAddinPackageInfo;
    x :Integer;
    AllowAllocationinStockTransfer : Boolean;
begin
  MakeERPHelpDocActions;
  inherited;
  
  (* actUtilsPreferences.ClassExecute := 'TPreferencesGUI'; *)
  SetGoogleActions;
  actEmployeeAccessLevels.ClassExecute := 'TAccessLevelsGUI';
  //PopulateActionHelper(Self.ActionList);
  //GetImageListsDLL;
  RemoveImageFromMenu(Self, MainMenu);
  WindowList := TStringList.Create;
  MsgHandler := TMsgHandler.Create(Self);
  WindowItemcount := miWindow.count;
  {access level kills and recreates the dmmain. other datamodules using the imagelist from the dmmain looses its link as they are not recreated
  reestablishing the links here}
  if (Assigned(AddinPackageList)) and (AddinPackageList.count > 0) then
    for j := 0 to AddinPackageList.Count - 1 do begin
        SelAddinInfo := TAddinPackageInfo(AddinPackageList[j]);
        (*if SelAddinInfo.GuiDataModule.LoadImagefromAppMainImageList then begin*)
            for x := 0 to SelAddinInfo.GuiDataModule.ComponentCount-1 do
                if SelAddinInfo.GuiDataModule.Components[x] is TActionlist then
                    TActionList(SelAddinInfo.GuiDataModule.Components[x]).Images := (*ImageListNew*)ImageList;
        (*end;*)
    end;

{$IFNDEF DevMode}
  ActiveForms2.Visible:= false;
  actERPHelpDoc.visible := false;
{$ENDIF}
  AddCustomReports;
  AddLanguageMenuItems;
  InitAreacolumnnname;
  FreeAndNil(actUtilsFaxJobsFaxSpoolList);

  actStockTransferEntryBatch.hint := BatchAdjhint(False);
  actStockTransferEntryBin.hint := BinAdjhint(False);
  actStockTransferEntrySN.hint := SNAdjhint(False);

  actInventStockStockAdjustmentbatch.hint := BatchAdjhint(true);
  actInventStockStockAdjustmentBin.hint := BinAdjhint(true);
  actInventStockStockAdjustmentSN.hint := SNAdjhint(true);

    AllowAllocationinStockTransfer := EmployeeHasAccess('FnAllowAllocationinStockTransfer');
    actStockTransferEntryBatch.Enabled :=AllowAllocationinStockTransfer;
    actStockTransferEntryListBAtch.Enabled :=AllowAllocationinStockTransfer;
    actStockTransferEntryBin.Enabled :=AllowAllocationinStockTransfer;
    actStockTransferEntryListBin.Enabled :=AllowAllocationinStockTransfer;
    actStockTransferEntrySN.Enabled :=AllowAllocationinStockTransfer;
    actStockTransferEntryListSN.Enabled :=AllowAllocationinStockTransfer;
    actStockTransferEntryTree.Enabled :=AllowAllocationinStockTransfer;

   makeSimpletypeMenuItems;

   actSerialNoTabletAllocation.Enabled := hasSerialNoTabletAllocationIssue;
   mnuSerialNoTabletAllocation.Enabled := actSerialNoTabletAllocation.Enabled;

  actProductFormulaList.Enabled     := AppEnv.CompanyPrefs.FeFieldVisible;
  actProductformulaTypeList.Enabled := AppEnv.CompanyPrefs.FeFieldVisible;
  actProductFormulaCreator.Enabled  := AppEnv.CompanyPrefs.FeFieldVisible;
  actProductFormulaType.Enabled     := AppEnv.CompanyPrefs.FeFieldVisible;
  actProductFormulaEntry.Enabled    := AppEnv.CompanyPrefs.FeFieldVisible;

  //actInt_WalMart.Enabled            := UsingWalmart;

   //MakeERPHelpDocActions;
end;
Procedure TdtmMainGUI.SimpleTypeList(Sender :TObject);
var
  s:String;
begin
   if not(Sender is TMenuItem) then exit;
   s:=TMenuItem(Sender).caption;
   s:=replacestr(s  , '&' , '');
   if s = '' then exit;
   SimpleTypeList(s);
end;

Procedure TdtmMainGUI.SimpleTypeList(const sSimpletype:String);
begin
         if sameText(sSimpletype, SimpleTypes_CompanyType_DESC                            +' List' ) then  TSimpleTypesGUI.SimpleTypesCompanyTypeList
    else if sameText(sSimpletype, SimpleTypes_FollowUpType_DESC                           +' List' ) then  TSimpleTypesGUI.SimpleTypesFollowUpTypeList
    else if sameText(sSimpletype, SimpleTypes_FollowUpResultType_DESC                     +' List' ) then  TSimpleTypesGUI.SimpleTypesFollowUpResultTypeList
    else if sameText(sSimpletype, SimpleTypes_StatusType_DESC                             +' List' ) then  TSimpleTypesGUI.SimpleTypesStatusTypeList
    else if sameText(sSimpletype, SimpleTypes_LeadStatusType_DESC                         +' List' ) then  TSimpleTypesGUI.SimpleTypesLeadStatusTypeList
    else if sameText(sSimpletype, SimpleTypes_PhSupportStatusType_DESC                    +' List' ) then  TSimpleTypesGUI.SimpleTypesPhSupportStatusTypeList
    else if sameText(sSimpletype, SimpleTypes_CustomerReturnStatus_DESC                   +' List' ) then  TSimpleTypesGUI.SimpleTypesCustomerReturnStatusList
    else if sameText(sSimpletype, SimpleTypes_ShippingContainerStatusType_DESC            +' List' ) then  TSimpleTypesGUI.SimpleTypesShippingContainerStatusTypeList
    else if sameText(sSimpletype, SimpleTypes_AppointmentStatusType_DESC                  +' List' ) then  TSimpleTypesGUI.SimpleTypesAppointmentStatusTypeList
    else if sameText(sSimpletype, SimpleTypes_AppointmentCancellationType_DESC            +' List' ) then  TSimpleTypesGUI.SimpleTypesAppointmentCancellationTypeList
    else if sameText(sSimpletype, SimpleTypes_SalesCategory_DESC                          +' List' ) then  TSimpleTypesGUI.SimpleTypesSalesCategoryList
    else if sameText(sSimpletype, SimpleTypes_SalesDelDelayReason_DESC                    +' List' ) then  TSimpleTypesGUI.SimpleTypesSalesDelDelayReasonList
    else if sameText(sSimpletype, SimpleTypes_PhoneSupportType_DESC                       +' List' ) then  TSimpleTypesGUI.SimpleTypesPhoneSupportTypeList
    else if sameText(sSimpletype, SimpleTypes_PhoneSupportVersion_DESC                    +' List' ) then  TSimpleTypesGUI.SimpleTypesPhoneSupportVersionList
    else if sameText(sSimpletype, SimpleTypes_RepairFault_DESC                            +' List' ) then  TSimpleTypesGUI.SimpleTypesRepairFaultList
    else if sameText(sSimpletype, SimpleTypes_CAR_Actiontype_DESC                         +' List' ) then  TSimpleTypesGUI.SimpleTypesCAR_ActiontypeList
    else if sameText(sSimpletype, SimpleTypes_CAR_Productionbuild_DESC                    +' List' ) then  TSimpleTypesGUI.SimpleTypesCAR_ProductionbuildList
    else if sameText(sSimpletype, SimpleTypes_CAR_ActionRequired_DESC                     +' List' ) then  TSimpleTypesGUI.SimpleTypesCAR_ActionRequiredList
    else if sameText(sSimpletype, SimpleTypes_CAR_PreventiveActionComments_DESC           +' List' ) then  TSimpleTypesGUI.SimpleTypesCAR_PreventiveActionCommentsList
    else if sameText(sSimpletype, SimpleTypes_OrderStatus_DESC                            +' List' ) then  TSimpleTypesGUI.SimpleTypesOrderStatusList
    else if sameText(sSimpletype, SimpleTypes_ReturnAuthority_DESC                        +' List' ) then  TSimpleTypesGUI.SimpleTypesReturnAuthorityList
    else if sameText(sSimpletype, SimpleTypes_Credit_DESC                                 +' List' ) then  TSimpleTypesGUI.SimpleTypesCreditList
    else if sameText(sSimpletype, SimpleTypes_Bill_DESC                                   +' List' ) then  TSimpleTypesGUI.SimpleTypesBillList
    else if sameText(sSimpletype, SimpleTypes_cheque_DESC                                 +' List' ) then  TSimpleTypesGUI.SimpleTypeschequeList
    else if sameText(sSimpletype, SimpleTypes_RosterBreaks_DESC                           +' List' ) then  TSimpleTypesGUI.SimpleTypesRosterBreaksList
    else if sameText(sSimpletype, SimpleTypes_LeadActionType_DESC                         +' List' ) then  TSimpleTypesGUI.SimpleTypesLeadActionTypeList
    else if sameText(sSimpletype, SimpleTypes_BOM_WastageReason_DESC                      +' List' ) then  TSimpleTypesGUI.SimpleTypesBOM_WastageReasonList
    else if sameText(sSimpletype, SimpleTypes_EmployeeSkillLevel_DESC                     +' List' ) then  TSimpleTypesGUI.SimpleTypesEmployeeSkillLevelList
    else if sameText(sSimpletype, SimpleTypes_MessageType_DESC                            +' List' ) then  TSimpleTypesGUI.SimpleTypesMessageTypeList;

end;
procedure TdtmMainGUI.MakeERPHelpDocActions;
var
  qry: TERPQuery;
  act :TDnmAction;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    qry.sql.text := 'select Distinct Description from `erpdocumentaion`.`tblhelpdocs` where active ="T" order by Description';
    qry.open;
    if qry.recordcount >0 then begin
      qry.First;
      While qry.EOF = false do begin
       try
            act := TDNMAction.create(self);
            act.name := Makename(self, 'act_' + Qry.fieldbyname('Description').asString ,'.pdf');
            act.Hint :=Qry.fieldbyname('Description').asString;
            act.Category := 'General';
            act.Caption := Qry.fieldbyname('Description').asString;
            act.ImageIndex := 746;
            act.OnExecute := AnyERPDocActionExecute;
            act.ClassExecute := Qry.fieldbyname('Description').asString;
            act.Description := Qry.fieldbyname('Description').asString;
            act.buttoncolor := clWhite;
            Act.ActionList := ActionList;
            //ActionList.InsertComponent(act);
       Except
        on E: Exception do begin
           if Devmode then showmessage('Error:' + e.Message );
        end;
       end;
        qry.Next;
      end;
    end;

  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;


end;

Procedure TdtmMainGUI.MakesimpletypeMenuItems;
var
  lItem : TMenuItem;
begin
try
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_AppointmentCancellationType )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_AppointmentStatusType       )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_Bill                        )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_BOM_WastageReason           )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_ProcresourceColour          )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_CAR_ActionRequired          )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_CAR_Actiontype              )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_CAR_PreventiveActionComments)+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_CAR_Productionbuild         )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_cheque                      )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_CompanyType                 )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_Credit                      )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_CustomerReturnStatus        )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_EmployeeSkillLevel          )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_FollowUpResultType          )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_FollowUpType                )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_LeadActionType              )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_LeadStatusType              )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_MessageType                 )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_OrderStatus                 )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_PhoneSupportType            )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_PhoneSupportVersion         )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_PhSupportStatusType         )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_RepairFault                 )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_ReturnAuthority             )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_RosterBreaks                )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_SalesCategory               )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_SalesDelDelayReason         )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_ShippingContainerStatusType )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
    lItem := TMenuItem.Create(Self); lItem.Caption :=   TSimpleTypes.SimpleTypeTypeDesc(SimpleTypes_StatusType                  )+' List' ; lItem.OnClick := SimpleTypeList; mnutypeCodes.Add(lItem);lItem.visible := lItem.caption <> '';
Except
  // kill the exception - if the stored procedure is not cretaed
end;
end;
procedure TdtmMainGUI.actSalesCustomersCustomerAccountNoSetupExecute(Sender: TObject);
var
  AccessLevel: integer;
begin
  inherited;
  AccessLevel := AppEnv.AccessLevels.GetEmployeeAccessLevel('FnCustomerAccountNoSetup');

  if (AccessLevel = 6) or (AccessLevel = 0) then begin
    CommonLib.MessageDlgXP_Vista(Format('You don''t have access to %s.',
      [AppEnv.AccessLevels.GetFormDescription('FnCustomerAccountNoSetup')]),
      mtInformation, [mbOK], 0);

    Exit;
  end;

  frmSeqNumbersGUI.DoSequenceNumberConfig(CommonDbLib.SEQ_CustAccountNumber,
    'Customer Account No',
    AccessLevel,
    true);
end;

procedure TdtmMainGUI.actSalesCRMPhoneContactExecute(Sender: TObject);
begin
  inherited;
  frmFollowUp.DoPhoneFollowUp(true, 0, 0);
end;

procedure TdtmMainGUI.actSalesCRMCompanyTypesExecute(Sender: TObject);
begin
  inherited;
  TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_CompanyType);
end;


procedure TdtmMainGUI.actSalesCRMFollowUpResultTypesExecute(Sender: TObject);
begin
  inherited;
  TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_FollowUpResultType);
end;

(*procedure TdtmMainGUI.actInventStockStockAdjustmentExecute(Sender: TObject);
Var Form : TComponent;
begin
  inherited;

  if not FormStillOpen(actInventStockStockAdjustment.ClassExecute) then begin
    Form := GetComponentByClassName(actInventStockStockAdjustment.ClassExecute);
    if Assigned(Form) and (form is TfmStockAdjustEntry) then begin //if has acess
      with TForm(Form) do begin
        AssignActionBitmap(Sender, TfmStockAdjustEntry(FindExistingComponent(actInventStockStockAdjustment.ClassExecute)));
        TfmStockAdjustEntry(FindExistingComponent(actInventStockStockAdjustment.ClassExecute)).isStockTake := false;
        FormStyle := fsmdiChild;
        BringToFront;
      end;
    end;
  end else if Not(TfmStockAdjustEntry(FindExistingComponent(actInventStockStockAdjustment.ClassExecute)).isStockTake) then begin
    with TForm(FindExistingComponent(actInventStockStockAdjustment.ClassExecute)) do begin
      Show;
      BringToFront;
    end;
  end;
end;*)

procedure TdtmMainGUI.actIntegrationExecute(Sender: TObject);

  procedure ShowIntMsg(const aMsg: string);
  begin
    MessageDlgXP_Vista('For Information On ' + quotedstr(aMsg) + ' Integration Contact TrueERP.',mtInformation,[mbOk],0);
  end;
  Procedure DoshowPOSTillsPopUp;
  begin
      with TPOSTillsPopUp.Create(Self) do try
        if ShowModal = mrOk then begin;   { TODO : Code to change main keypad on return }
        end;
      finally
        Free;
      end;
  end;

begin
            if (Sender = actInt_AustPostParcel   ) then begin OpenPrefform('Utilities', '' ,1 ,false, 'Enable Australian E-Parcel | Utilities');
  end  else if (Sender = actInt_Amazon           ) then begin OpenPrefform('EDI and Integration', '' ,1 ,false, 'Amazon | EDI and Integration');
  end  else if (Sender = actInt_CanadaPost       ) then begin OpenPrefform('EDI and Integration', '' ,1 ,false, 'UPS | EDI and Integration');
  end  else if (Sender = actInt_Cytrack          ) then begin OpenPrefform('EDI and Integration', '' ,1 ,false, 'CyTrack Integration | EDI and Integration');
  end  else if (Sender = actInt_FedEx            ) then begin OpenPrefform('EDI and Integration', '' ,1 ,false, 'FedEx | EDI and Integration');
  end  else if (Sender = actInt_GoogleAnalytics  ) then begin OpenPrefform('EDI and Integration', '' ,1 ,false, 'Google Analytics | EDI and Integration');
  end  else if (Sender = actInt_GoogleCalendar   ) then begin OpenPrefform('EDI and Integration', '' ,1 ,false, 'Google Calendar Synchronisation | EDI and Integration');
  end  else if (Sender = actInt_SMS              ) then begin OpenPrefform('EDI and Integration', '' ,1 ,false, 'SMS | EDI and Integration');
  end  else if (Sender = actInt_TNT              ) then begin OpenPrefform('EDI and Integration', '' ,1 ,false, 'Shipment | EDI and Integration');
  end  else if (Sender = actInt_UPS              ) then begin OpenPrefform('EDI and Integration', '' ,1 ,false, 'UPS | EDI and Integration');
  end  else if (Sender = actInt_USPS             ) then begin OpenPrefform('EDI and Integration', '' ,1 ,false, 'USPS | EDI and Integration');
  end  else if (Sender = actInt_Web              ) then begin OpenPrefform('EDI and Integration', '' ,1 ,false, 'Web API | EDI and Integration');
  end  else if (Sender = actInt_WalMart          ) then begin OpenPrefform('EDI and Integration', '' ,1 ,false, 'Walmart | EDI and Integration');
  end  else if (Sender = actInt_Woocommerce      ) then begin OpenPrefform('EDI and Integration', '' ,1 ,false, 'WooCommerce | EDI and Integration');
  end  else if (Sender = actint_SPS              ) then begin OpenPrefform('EDI and Integration', '' ,1 ,false, 'SPS | EDI and Integration');
  end  else if (Sender = actint_HMRC             ) then begin OpenPrefform('EDI and Integration', '' ,1 ,false, 'HMRC API (UK Gov VAT) | EDI and Integration');
  end  else if (Sender = actint_VAT              ) then begin OpenPrefform('EDI and Integration', '' ,1 ,false, 'VAT | EDI and Integration');
  end  else if (Sender = actInt_QuickBooks       ) then begin OpenPrefform('EDI and Integration', '' ,1 ,false, 'Intuit (QuickBooks) | EDI and Integration');
  end  else if (Sender = actInt_Ebay             ) then begin OpenPrefform('EDI and Integration', '' ,1 ,false, 'Ebay Integration | EDI and Integration');
  end  else if (Sender = actint_Magento          ) then begin OpenPrefform('EDI and Integration', '' ,1 ,false, 'Magento | EDI and Integration');
  end  else if (Sender = actint_AvaTax           ) then begin OpenPrefform('EDI and Integration', '' ,1 ,false, 'Avalara Tax | EDI and Integration');
  end  else if (Sender = actint_EDISynch         ) then begin OpenPrefform('EDI and Integration', '' ,1 ,false, 'EDI (X12) | EDI and Integration');
  end  else if (Sender = actint_CoreEDIService   ) then begin OpenPrefform('EDI and Integration', '' ,1 ,false, 'Core EDI Service | EDI and Integration');
  end  else if (Sender = actInt_Eftpos           ) then begin ShowIntMsg('EFT POS');
  end  else if (Sender = actInt_Ebay             ) then begin ShowIntMsg('Ebay');//    OpenPrefform('EDI and Integration', '' ,1 ,false, 'Ebay Integration | EDI and Integration');
  end  else if (Sender = actInt_CustomerPortal   ) then begin ShowIntMsg('Customer Portal');
  end  else if (Sender = actInt_ATO              ) then begin ShowIntMsg('Australian Tax Office');
  end  else if (Sender = actInt_ShoppingCart     ) then begin ShowIntMsg('Online Shopping Cart');
  end  else if (Sender = avtInt_Fuel             ) then begin ShowIntMsg('Fuel Pump');
  end  else if (Sender = actInt_PNET             ) then begin ShowIntMsg('Insurance Company PNET');
  end  else if (Sender = actInt_Telstra          ) then begin ShowIntMsg('Telstra');
  end  else if (Sender = actInt_XML              ) then begin ShowIntMsg('XML');
  end  else if (Sender = actInt_Target           ) then begin ShowIntMsg('Target');
  end  else if (Sender = actInt_Sony             ) then begin ShowIntMsg('Sony');
  end  else if (Sender = actInt_Seagate          ) then begin ShowIntMsg('Seagate');
  end  else if (Sender = actInt_Erico            ) then begin ShowIntMsg('Erico');
  end  else if (Sender = actInt_ePadLink         ) then begin ShowIntMsg('ePadLink');
  end  else if (Sender = actInt_Scanner          ) then begin ShowIntMsg('Scanner');
  end  else if (Sender = actInt_OPOS             ) then begin DoshowPOSTillsPopUp;
  end  else if (Sender =  actint_Stripe          )  OR
               (Sender =  actint_PaymentExpress  )  OR
               (Sender =  actint_Payeezy         )  OR
               (Sender =  actint_Endica          )  OR
               (Sender =  actint_ERPAPI          )  OR
               (Sender =  actInt_Stamps          )  then begin ShowIntMsg(TDnmAction(Sender).caption);
  end;
end;


procedure TdtmMainGUI.actint_CoreEDIService_HelpExecute(Sender: TObject);
begin
  inherited;
  TDocReaderObj.ShowERPHelp(nil, Self, true, 'Setup CoreEDI');
end;

procedure TdtmMainGUI.actInventStockStockTakeExecute(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  if not FormStillOpen('TfmStockAdjustEntryflat') then begin
    Form := GetComponentByClassName('TfmStockAdjustEntryflat');
    if Assigned(Form) then begin //if has acess
      with TForm(Form) do begin
        AssignActionBitmap(Sender, TfmStockAdjustEntryflat(FindExistingComponent('TfmStockAdjustEntryflat')));
        TfmStockAdjustEntryflat(form).isStockTake := true;
        FormStyle := fsmdiChild;
        BringToFront;
      end;
    end;
  end else begin
    with TForm(FindExistingComponent('TfmStockAdjustEntryflat')) do begin
      Show;
      BringToFront;
      if (TfmStockAdjustEntryflat(FindExistingComponent('TfmStockAdjustEntryflat')).isStockTake) =False then
        MessageDlgXP_Vista('Please close the Stock Adjustment form to do a Stock Take', mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TdtmMainGUI.actPaymentsReceivedBulkPaymentsExecute(Sender: TObject);
var
  frm: TComponent;
begin
  inherited;
  frm := GetComponentByClassName('TfrmBulkReceiveCustomersGUI', true);
  if Assigned(Frm) and (frm is TBaseInputGUI) then begin //if has acess
    with TBaseInputGUI(frm) do begin
      AssignActionBitmap(Sender, TForm(frm));
      KeyID     := 0;
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TdtmMainGUI.actEmployeePersonalPreferencesExecute(Sender: TObject);
var
  AccLevel: Integer;
begin
  inherited;
  AccLevel := AppEnv.AccessLevels.GetEmployeeAccessLevel('FnPersonalPref');

  if AccLevel >= 5 then begin
    CommonLib.MessageDlgXP_Vista('You do not have Access to ' + AppEnv.AccessLevels.GetFormDescription('FnPersonalPref'), mtWarning, [mbOK], 0);
  end else begin
    OpenPrefform('Employee,Colours' ,  '' , AccLevel , False);
  end;
end;
procedure TdtmMainGUI.actSTPPreferencesExecute(Sender: TObject);
begin
    OpenPrefform('Payroll' ,  '', 0 , True, 'Single Touch Payroll' , '' );
end;



procedure TdtmMainGUI.actEmployeeResetPersonalTabsExecute(Sender: TObject);
var
  TableFunctionsObj: TTableFunctionsObj;
begin
  inherited;

  TableFunctionsObj := TTableFunctionsObj.Create;
  try
    TableFunctionsObj.RemoveListCustomisation(IntToStr(AppEnv.Employee.EmployeeID));
  finally
    FreeandNil(TableFunctionsObj);
  end;
end;

procedure TdtmMainGUI.actERPTipExecute(Sender: TObject);
begin
  inherited;
  ShowERPTip;
end;

procedure TdtmMainGUI.actAccountsAccountsListExecute(Sender: TObject);
var
  TreeForm: Tcomponent;
  frmChartOfAccountsList: TComponent;
begin
  inherited;

  if AppEnv.CompanyPrefs.DefaultToChartOfAccountsTreeView then begin
    TreeForm := GetComponentByClassName('TfmChartOfAccountsTree', true);
    if not Assigned(TreeForm) then Exit;

    with TBaseInputGUI(TreeForm) do begin
      AssignActionBitmap(Sender, TForm(TreeForm));
      FormStyle := fsMDIChild;
      BringToFront;
    end
  end else begin
    frmChartOfAccountsList := GetComponentByClassName('TChartOfAccountsListGUI', true);
    if Assigned(frmChartOfAccountsList) then begin //if has acess
      AssignActionBitmap(Sender, TForm(frmChartOfAccountsList));
      TForm(frmChartOfAccountsList).FormStyle := fsMDIChild;
      TForm(frmChartOfAccountsList).BringToFront;
    end;
  end;
end;

procedure TdtmMainGUI.actAccountsRefreshBatchTransactionExecute(Sender: TObject);
var
  TransactionTableObj: TTransactionTableObj;
begin
  inherited;
  Application.ProcessMessages;
  TransactionTableObj := TTransactionTableObj.Create(False);
  try
    if (AppEnv.UtilsClient.GetDatabaseUserCount(AppEnv.AppDb.Database) <= 1) AND (MainForm.MDIChildCount <=3) then
      TransactionTableObj.InitforRefreshTrnsTable;
      TransactionTableObj.CleanRefreshTrnsTable(true, false, true);
  finally
    FreeandNil(TransactionTableObj);
    MainForm.DoRefreshedERPInfo;
  end;

end;

procedure TdtmMainGUI.actReportsAccountsExecute(Sender: TObject);
begin
  inherited;
  AssignActionBitmap(Sender, MainSwitch2.DoReportShow('', REPORT_GROUP_ACCOUNTS));
end;

procedure TdtmMainGUI.actReportsAppointmentsExecute(Sender: TObject);
begin
  inherited;
  AssignActionBitmap(Sender, MainSwitch2.DoReportShow('', REPORT_GROUP_APPOINTMENTS));
end;

procedure TdtmMainGUI.actReportsBankingExecute(Sender: TObject);
begin
  inherited;
  AssignActionBitmap(Sender, MainSwitch2.DoReportShow('', REPORT_GROUP_BANKING));
end;

procedure TdtmMainGUI.actReportsEmployeeExecute(Sender: TObject);
begin
  inherited;
  AssignActionBitmap(Sender, MainSwitch2.DoReportShow('', REPORT_GROUP_EMPLOYEE));
end;

procedure TdtmMainGUI.actReportsFixedAssetsExecute(Sender: TObject);
begin
  inherited;
  AssignActionBitmap(Sender, MainSwitch2.DoReportShow('', REPORT_GROUP_FIXED_ASSETS));
end;

procedure TdtmMainGUI.actReportsInventoryExecute(Sender: TObject);
begin
  inherited;
  AssignActionBitmap(Sender, MainSwitch2.DoReportShow('', REPORT_GROUP_INVENTORY));
end;

procedure TdtmMainGUI.actReportsPaymentsExecute(Sender: TObject);
begin
  inherited;
  AssignActionBitmap(Sender, MainSwitch2.DoReportShow('', REPORT_GROUP_PAYMENTS));
end;

procedure TdtmMainGUI.actReportsPayrollExecute(Sender: TObject);
begin
  inherited;
  AssignActionBitmap(Sender, MainSwitch2.DoReportShow('', REPORT_GROUP_PAYROLL));
end;

procedure TdtmMainGUI.actReportsPurchasesExecute(Sender: TObject);
begin
  inherited;
  AssignActionBitmap(Sender, MainSwitch2.DoReportShow('', REPORT_GROUP_PURCHASES));
end;

procedure TdtmMainGUI.actReportsSalesExecute(Sender: TObject);
begin
  inherited;
  AssignActionBitmap(Sender, MainSwitch2.DoReportShow('', REPORT_GROUP_SALES));
end;

procedure TdtmMainGUI.actReportsCustomReportsExecute(Sender: TObject);
var
  EmployeeReportsGUI: TComponent;
begin
  inherited;
  EmployeeReportsGUI := GetComponentByClassName('TEmployeeReportsGUI', true);
  if Assigned(EmployeeReportsGUI) and (EmployeeReportsGUI is TBaseInputGUI) then begin //if has acess
    with TBaseInputGUI(EmployeeReportsGUI) do begin
      AssignActionBitmap(Sender, TBaseInputGUI(EmployeeReportsGUI));
      KeyID     := AppEnv.Employee.EmployeeID;
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

//procedure TdtmMainGUI.CheckOtherUsersOnline;
//begin
//  if AppEnv.UtilsClient.GetDatabaseUserCount(AppEnv.AppDb.Database) > 1 then begin
//    dlgCurrentUsers.Items.CommaText:= AppEnv.UtilsClient.GetDatabaseUserList(AppEnv.AppDb.Database,AppEnv.AppDb.UserName,true);
//    dlgCurrentUsers.Caption := AppEnv.AppDb.Database + ' Verify Functions';
//    dlgCurrentUsers.Color   := $00D7F5FF;
//    dlgCurrentUsers.Message := 'The following user(s) must exit the system.';
//    dlgCurrentUsers.Execute;
//    // raise the silent exception
//    Abort;
//  end;
//end;


procedure TdtmMainGUI.actUtilsDBUtilsCopyExecute(Sender: TObject);
begin
  inherited;
  //MainForm.Copy1Click(Sender);
  MainForm.Copydb;
end;

procedure TdtmMainGUI.actUtilsDbUtilsCopyROExecute(Sender: TObject);
begin
  inherited;
  MainForm.Copydb(True);
end;

procedure TdtmMainGUI.actUtilsDBUtilsRemoveExecute(Sender: TObject);
begin
  inherited;
  Mainform.Remove1Click(Sender);
end;

procedure TdtmMainGUI.actUtilsCurrentUsersExecute(Sender: TObject);
begin
  inherited;
  ShowCurrentlyLoggedUsers;
end;

procedure TdtmMainGUI.actUtilsFaxJobsPurgeOldFaxJobsExecute(Sender: TObject);
var
  qryTemp: TERPCommand;
begin
  inherited;

  if CommonLib.MessageDlgXP_Vista('Are You Sure You Wish To Purge Fax Tables ?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then begin
    qryTemp := TERPCommand.Create(nil);
    try
      qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
      qryTemp.SQL.Clear;
      qryTemp.SQL.Add('DELETE FROM tblfaxspool;');
      qryTemp.Execute;

      qryTemp.SQL.Clear;
      qryTemp.SQL.Add('DELETE FROM tblfaxspooldocs;');
      qryTemp.Execute;

      CommonLib.MessageDlgXP_Vista('Old Fax Jobs successfully purged', mtInformation, [mbOK], 0);
    finally
      FreeAndNil(qryTemp);
    end;
  end;
end;

procedure TdtmMainGUI.actUtilsPreferencesExecute(Sender: TObject);
begin
  inherited;
  OpenPrefform('' ,  '', 0 , False );
end;

procedure TdtmMainGUI.actUtilsAuditTrailPurgeAuditTrailExecute(Sender: TObject);
var
  frm: TfmAuditExportPerge;
begin
  inherited;

  if AppEnv.CompanyPrefs.UseAuditTrail then begin
    frm := TfmAuditExportPerge(GetComponentByClassName('TfmAuditExportPerge',True));
    if Assigned(frm) then begin
      frm.ExportAudit:= true;
      frm.PurgeAudit:= true;
      frm.FormStyle:= FsMDIChild;
      frm.Show;
      frm.BringToFront;
    end;
  end;

//  if AppEnv.CompanyPrefs.UseAuditTrail then begin
//    AuditTrail := TAuditTrailObj.Create;
//    try
//      if AuditTrail.ExportAuditTrail then begin
//        AuditTrail.Purge;
//      end;
//    finally
//      FreeAndNil(AuditTrail);
//    end;
//  end;
end;

procedure TdtmMainGUI.actUtilsAuditTrailExportAuditTrailExecute(Sender: TObject);
var
  frm: TfmAuditExportPerge;
begin
  inherited;

  if AppEnv.CompanyPrefs.UseAuditTrail then begin
    frm := TfmAuditExportPerge(GetComponentByClassName('TfmAuditExportPerge',True));
    if Assigned(frm) then begin
      frm.ExportAudit:= true;
      frm.FormStyle:= FsMDIChild;
      frm.Show;
      frm.BringToFront;
    end;
  end;

//  if AppEnv.CompanyPrefs.UseAuditTrail then begin
//    AuditTrail := TAuditTrailObj.Create;
//    try
//      AuditTrail.ExportAuditTrail;
//    finally
//      FreeAndNil(AuditTrail);
//    end;
//  end;
end;

procedure TdtmMainGUI.actAboutUpdateNotesExecute(Sender: TObject);
begin
  inherited;
  try
    ShellExecute(0,
      'open',
//      PChar(SystemLib.ExeDir + UPDATE_NOTES_FILE),
      PChar('http://www.trueerp.com/en/download'),
      nil,
      nil,
      SW_SHOWNORMAL);
  except;
  end;
end;

procedure TdtmMainGUI.actFileExitExecute(Sender: TObject);
begin
  inherited;
  Application.MainForm.Close;
  PerformPaints;
end;

procedure TdtmMainGUI.actFileImportAPIExecute(Sender: TObject);
begin
  inherited;
  //
  ImportSalesListJson;
end;

procedure TdtmMainGUI.actReportsQuoteStatusExecute(Sender: TObject);
begin
  inherited;
  LaunchList(Sender, 'TQuoteListGUI', 'Quote Status Report');
end;

procedure TdtmMainGUI.actWindowCustomiseToolbarExecute(Sender: TObject);
begin
  inherited;
  if CustomiseToolbar then begin
    MainForm.ReloadToolbarButtons;
  end;
end;

procedure TdtmMainGUI.actSalesCRMReportsExecute(Sender: TObject);
begin
  inherited;
  AssignActionBitmap(Sender, MainSwitch2.DoReportShow('', REPORT_GROUP_CRM));
end;

{backup and restore are on the mainform}
procedure TdtmMainGUI.actUtilsDBUtilsBackupExecute(Sender: TObject);
begin
  MainForm.Backup1Click(Self);
end;

procedure TdtmMainGUI.actUtilsDBUtilsRestoreExecute(Sender: TObject);
begin
  MainForm.Restore1Click(Self);
end;

procedure TdtmMainGUI.actWindowTiledExecute(Sender: TObject);
begin
  inherited;
  MainForm.Tile;
end;

procedure TdtmMainGUI.actWindowCascadeExecute(Sender: TObject);
begin
  inherited;
  MainForm.Cascade;
end;

procedure TdtmMainGUI.actInt_WalMartOrdersExecute(Sender: TObject);
begin
  inherited;
(*      OpenPrefform('EDI and Integration' ,  'chkEnableWalmart', 0 , False, 'Walmart' , 'pnlWalmartOptions' ,
                    'Changes made here will not take affect unless the Application is Restarted.');*)
end;


procedure TdtmMainGUI.actWindowArrangeIconsExecute(Sender: TObject);
begin
  inherited;
  MainForm.ArrangeIcons;
end;

procedure TdtmMainGUI.actFileNewCompanyExecute(Sender: TObject);
begin
  inherited;
  MainForm.mitNewCompanyClick(nil);
end;

procedure TdtmMainGUI.actFileOpenCompanyExecute(Sender: TObject);
begin
  inherited;
  MainForm.OpenCompanyDbClick(nil);
end;

procedure TdtmMainGUI.actSalesCRMFollowUpTypesExecute(Sender: TObject);
begin
  inherited;
  TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_FollowUpType);
end;

procedure TdtmMainGUI.Contents2Click(Sender: TObject);
begin
  inherited;
//  AppHelpProcessor.ShowContents;
  AppHelpProcessor.ShowHelp(MainForm.HelpContext);
//  try
//    ShellExecute(0,
//      'open',
//      PChar(SystemLib.ExeDir + 'Help\ERP.hlp'),
//      nil,
//      nil,
//      SW_SHOWNORMAL);
//  except;
//  end;
end;

procedure TdtmMainGUI.LicenceAgreement1Click(Sender: TObject);
begin
  inherited;
  try
    ShellExecute(0,
      'open',
      PChar(SystemLib.ExeDir + LICENCE_AGREEMENT_FILE),
      nil,
      nil,
      SW_SHOWNORMAL);
  except;
  end;
end;

procedure TdtmMainGUI.TrainingGuideMnuClick(Sender: TObject);
begin
  inherited;
  try
    //Application.HelpContext(TRAINING_GUIDE_CONTEXT_ID);
  except;
  end;
end;

procedure TdtmMainGUI.actEmployeeAccessLevelsExecute(Sender: TObject);
var
  AccessLevel: integer;
begin
  inherited;
  if Assigned(AppEnv.Employee) then begin
    AccessLevel := AppEnv.AccessLevels.GetEmployeeAccessLevel('TAccessLevelsGUI');
    if AccessLevel >= 5 then begin
      CommonLib.MessageDlgXP_Vista('You do not have Access to ' + AppEnv.AccessLevels.GetFormDescription('TAccessLevelsGUI'), mtWarning	, [mbOK], 0);
    end
    else begin
      AnyActionExecute(Sender);
    end;
  end;
end;

procedure TdtmMainGUI.actSalesPrintPickSlipsExecute(Sender: TObject);
var
  frm:TComponent;
begin
  inherited;
  if not FormStillOpen('TfrmPickingSlipsPrn') then begin
    frm := GetComponentByClassName('TfrmPickingSlipsPrn',True);
    if Assigned(frm) then begin
      with TForm(frm) do begin
        FormStyle := fsmdiChild;
        Show;
        BringToFront;
      end;
    end;
  end else begin
    frm := FindExistingComponent('TfrmPickingSlipsPrn');
    if Assigned(frm) then begin
      TForm(frm).WindowState := wsNormal;
      TForm(frm).BringToFront;
    end;
  end;
end;

procedure TdtmMainGUI.actReportsCRMExecute(Sender: TObject);
begin
  inherited;
  AssignActionBitmap(Sender, MainSwitch2.DoReportShow('', REPORT_GROUP_CRM));
end;

procedure TdtmMainGUI.actReportsJobsExecute(Sender: TObject);
begin
  inherited;
  AssignActionBitmap(Sender, MainSwitch2.DoReportShow('', REPORT_GROUP_JOBS));
end;

procedure TdtmMainGUI.actHireItemReportExecute(Sender: TObject);
var
  frm:TComponent;
begin
  inherited;
  if not FormStillOpen('THiredItemsReportGUI') then begin
    frm := GetComponentByClassName('THiredItemsReportGUI',True);
    if Assigned(frm) then begin
      with TForm(frm) do begin
        FormStyle := fsmdiChild;
        Show;
        BringToFront;
      end;
    end;
  end else begin
    frm := FindExistingComponent('THiredItemsReportGUI');
    if Assigned(frm) then begin
      TForm(frm).WindowState := wsNormal;
      TForm(frm).BringToFront;
    end;
  end;
end;

procedure TdtmMainGUI.TrainingVideos1Click(Sender: TObject);
begin
  inherited;
//  try
//    If Not FileExists(TRAINING_VIDEOS_EXE_PATH) then Begin
//      CommonLib.MessageDlgXP_Vista('Training Videos Are Not Installed !', mtInformation, [mbOK], 0);
//    end else
//    ShellExecute(0,
//      'open',
//      PChar(TRAINING_VIDEOS_EXE_PATH),
//      nil,
//      nil,
//      SW_SHOWNORMAL);
//  except;
//  end;
end;

procedure TdtmMainGUI.Utilities2Click(Sender: TObject);
begin
  inherited;
  AuditTrail2.Enabled := (AppEnv.CompanyPrefs.UseAuditTrail and
                         (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnAuditTrail') = 1));
end;

procedure TdtmMainGUI.actBarcodeActionExecute(Sender: TObject);
var
  BarcodeAction: TBarcodeAction;
begin
  inherited;
  BarcodeAction := TBarcodeAction(FindExistingComponent('TBarcodeAction'));

  if Assigned(BarcodeAction) then
    BarcodeAction.BringToFront
  else begin
    BarcodeAction := TBarcodeAction(GetComponentByClassName('TBarcodeAction'));
    if Assigned(BarcodeAction) then begin
      BarcodeAction.CreateForm;
      BarcodeAction.SetupDisplay;
    end;
  end;
end;

procedure TdtmMainGUI.actcolorPrefsExecute(Sender: TObject);
begin
  inherited;
  OpenPrefform('Colours' ,  '' , 1 , False);
end;

procedure TdtmMainGUI.miWindowClick(Sender: TObject);
var
  Index: Integer;
  MenuItem: TmenuItem;
begin
  inherited;
  MainMenu.BeginUpdate;

  try
    WindowList.Clear;

    while miWindow.Count > WindowItemcount do
      miWindow.Items[WindowItemcount].Free;

    MenuItem := TMenuItem.Create(Self);
    MenuItem.Caption := '-';
    miWindow.Add(MenuItem);

    for Index := 0 to Application.MainForm.MDIChildCount - 1 do begin
      MenuItem := TMenuItem.Create(Self);
      MenuItem.Caption := IntToStr(Index + 1) + ' ' + Application.MainForm.MDIChildren[Index].Caption;
      MenuItem.Checked := Application.MainForm.MDIChildren[Index].Active;
      MenuItem.OnClick := SetActiveWindow;
      miWindow.Add(MenuItem);
      WindowList.Add(MenuItem.Caption + '=' + Application.MainForm.MDIChildren[Index].ClassName);
    end;
  finally
    MainMenu.EndUpdate;
  end;
end;

procedure TdtmMainGUI.mnuLanguageClick(Sender: TObject);
begin
  inherited;
  if sender = mnuLanguage then exit;
  TLanguageTranslationObj.Inst.ChangeLanguage(TMenuItem(Sender));
  ShowSelectedLanguage(TMenuItem(Sender).tag);
end;
procedure TdtmMainGUI.mnuSMSRatesClick(Sender: TObject);
begin
  try
    if not(FileExists(SystemLib.ExeDir + SMS_RATES_FILE)) then begin
      MessageDlgXP_vista('Unable to open the SMS Rates - the file is missing.', mtWarning, [mbOK], 0);
      Exit;
    end;
    Processingcursor(true);
    try
      ShellExecute(0,'open',PChar(SystemLib.ExeDir + SMS_RATES_FILE),nil,nil,SW_SHOWNORMAL);
    finally
      Processingcursor(False);
    end;
  except
    on E:Exception do begin
      MessageDlgXP_vista('Unable to open the SMS Rates.' + NL+ E.message, mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TdtmMainGUI.NonERPClone1Click(Sender: TObject);
begin
  inherited;
  mainform.NonERPClone1Click(Sender);
end;

procedure TdtmMainGUI.ShowSelectedLanguage(Selectelangid:Integer);
var
  ctr:Integer;
begin
  For ctr := 0 to  mnuLanguage.count-1 do
    mnuLanguage.items[ctr].checked :=mnuLanguage.items[ctr].tag = Selectelangid;
end;


procedure TdtmMainGUI.DataModuleDestroy(Sender: TObject);
begin
  FreeandNil(WindowList);
  FreeandNil(MsgHandler);
  inherited;
end;


procedure TdtmMainGUI.DoOnUnallocatedBinQtyListSelect(Sender: TwwDbGrid);
var
  SAOriginalno: String;
  form :TComponent;
begin
  self.UnallocatedBinQtyList.Hide;
  if Sender.SelectedList.Count = 0 then exit;
  SAOriginalno := TStockAdjustEntry.AutoAdjustBin('','','','','',nil,Sender);
  if SAOriginalno <> '' then begin
      CommonLib.MessageDlgXP_Vista( 'Unallocated bin Quantity is allocated to the Default Bin.' +
                              chr(13)+chr(13)+'The Original no of the Stock Adjustment(s): ' +SAOriginalno +
                              chr(13) +Chr(13) +'Please make sure the stock adjustment(s) are processed.', mtInformation, [mbok], 0);
      form := GetComponentByClassName('TStockAdjustEntryListGUI');
      if assigned(Form) then begin
          TStockAdjustEntryListGUI(Form).FormStyle := fsMDIChild;
          TStockAdjustEntryListGUI(Form).qryMain.Filter := 'Originalno = ' +QuotedStr(SAOriginalno);
          TStockAdjustEntryListGUI(Form).qryMain.Filtered := True;
          TStockAdjustEntryListGUI(Form).BringToFront;
      end;
  end;
end;

procedure TdtmMainGUI.HowToExtraButtonClick(Sender: TObject);
Var
  Form : TComponent;
begin
  inherited;
  if not FormStillOpen('TfmHowTo') then
  begin
    Form := GetComponentByClassName('TfmHowTo');
    if Assigned(Form) then
    begin //if has acess
      with TBaseInputGUI(Form) do
      begin
//        AssignActionBitmap(Sender, TfmStockAdjustEntryflat(FindExistingComponent('TfmStockAdjustEntryflat')));
//        TfmStockAdjustEntryflat(form).isStockTake := true;
        KeyId := TComponent(Sender).Tag;
        FormStyle := fsmdiChild;
        BringToFront;
      end;
    end;
  end;
  (* else begin
    with TForm(FindExistingComponent('TfmStockAdjustEntryflat')) do begin
      Show;
      BringToFront;
      if (TfmStockAdjustEntryflat(FindExistingComponent('TfmStockAdjustEntryflat')).isStockTake) =False then
        MessageDlgXP_Vista('Please close the Stock Adjustment form to do a Stock Take', mtWarning, [mbOK], 0);
    end;
  end;
  *)
end;

procedure TdtmMainGUI.SetActiveWindow(Sender: TObject);
var
  Form: TForm;
  ClassStr: string;
  MenuItemCaption: string;
begin
  if Sender is TMenuItem then begin
    MenuItemCaption := AnsiReplaceText(TMenuItem(Sender).Caption, '&', '');
    ClassStr := WindowList.Values[MenuItemCaption];

    if ClassStr <> '' then begin
      Form := TForm(GetComponentByClassName(ClassStr));

      if Assigned(Form) then
        Form.BringToFront;
    end;
  end;
end;

procedure TdtmMainGUI.actReportsGeneralExecute(Sender: TObject);
begin
  inherited;
  AssignActionBitmap(Sender, MainSwitch2.DoReportShow('', REPORT_GROUP_GENERAL));
end;

procedure TdtmMainGUI.actreportsGoogleExecute(Sender: TObject);
begin
  inherited;
  AssignActionBitmap(Sender, MainSwitch2.DoReportShow('', REPORT_GROUP_GOOGLE));
end;

procedure TdtmMainGUI.actReportsUtilitiesExecute(Sender: TObject);
begin
  inherited;
  AssignActionBitmap(Sender, MainSwitch2.DoReportShow('', REPORT_GROUP_UTILITIES));
end;

procedure TdtmMainGUI.actReportsPOSExecute(Sender: TObject);
begin
  inherited;
  AssignActionBitmap(Sender, MainSwitch2.DoReportShow('', REPORT_GROUP_POS));
end;
{$IFDEF DevMode}
{$IFDEF BUSOBJ_FILTER_LIST}
procedure TdtmMainGUI.ClickBusObjFilterList(Sender: TObject);
var
  ListingForm: TBaseListingGUI;
begin
  ListingForm := TBaseListingGUI(GetComponentByClassName('TfmBusObjFilterList', true));
  if Assigned(ListingForm) then begin //if has acess
    with TForm(ListingForm) do begin
      //AssignActionBitmap(Sender, TForm(SummarySheet));
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;

end;
{$ENDIF}
{$ENDIF}

procedure TdtmMainGUI.actPaymentsReconcileExecute(Sender: TObject);
var
  frm:TComponent;
begin
  inherited;
  try
    frm := FindExistingComponent('TReconciliationGUI');
    if Assigned(frm) then begin
      TForm(frm).BringToFront ;
      ShowMessage('The Reconciliation form is already open.');
    end else begin
      frm := GetComponentByClassName('TReconciliationGUI');
      if Assigned(frm) and (frm is TForm) then begin
        TForm(frm).FormStyle := fsMDIChild;
        TForm(frm).BringToFront;
      end;
    end;

  finally
  end;
end;


procedure TdtmMainGUI.actPhoneSupportTypeListExecute(Sender: TObject);
begin
  inherited;
  TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_PhoneSupportType);
end;

procedure TdtmMainGUI.actPhoneSupportVersionListExecute(Sender: TObject);
begin
  inherited;
  TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_PhoneSupportVersion);
end;

Procedure TdtmMainGUI.Launchchart(const Sender: TObject; const sListClass: string; Chartname:String ='';const ListName: string = '' ; showasMax:boolean =False; groupFilterItemIndex:Integer =-1);
var
  Form : TComponent;
begin
  form := LaunchList(Sender , sListClass ,ListName , groupFilterItemIndex);
  if assigned(Form) and (form is TBaseListingGUI) then begin
    TBaseListingGUI(Form).charttolaunch :=  Chartname;
    TBaseListingGUI(Form).showGraph;
    if showasMax then TBaseListingGUI(Form).windowstate := wsMaximized;
  end;
end;

procedure TdtmMainGUI.actLeadStatusTypeExecute(Sender: TObject);
begin
  inherited;
  TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_LeadStatusType);
end;

procedure TdtmMainGUI.actShippingContainerStatusExecute(Sender: TObject);
begin
  inherited;
  TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_ShippingContainerStatusType);
end;

procedure TdtmMainGUI.actSoftwareAdditionsAgreementClick(Sender: TObject);
begin
  inherited;
  try
    ShellExecute(0,
      'open',
      PChar(SystemLib.ExeDir + ADDITIONS_AGREEMENT_FILE),
      nil,
      nil,
      SW_SHOWNORMAL);
  except;
  end;
end;

procedure TdtmMainGUI.actStockanalysisReportExecute(Sender: TObject);
var
  fsClassname:String;
begin
  inherited;
  fsClassname :=AppEnv.Employee.StockanalysisReport;
  if fsClassname = '' then fsClassname:= TDnMAction(Sender).ClassExecute;
  ShowGUI(Sender,fsClassname, true);
end;

procedure TdtmMainGUI.actStockTransferEntryBinHint(var HintStr: string;
  var CanShow: Boolean);
begin
  inherited;
  CanShow := True;
end;

procedure TdtmMainGUI.ActiveForms2Click(Sender: TObject);
var
  x: integer;
  sl: TStringList;
begin
  inherited;
  sl:= TStringList.Create;
  for x := 0 to Screen.FormCount - 1 do begin
    sl.Add(Screen.Forms[x].Name);
  end;
//  for x:= 0 to Application.ComponentCount -1 do
//    if Application.Components[x] is TForm then
//      sl.Add(Application.Components[x].ClassName + '  ' + Application.Components[x].Name);
  showmessage(sl.Text);
  sl.Free;
end;

procedure TdtmMainGUI.actEmployeeGlobalListExecute(Sender: TObject);
var
  fsformnmame :String;
  frm:TComponent;
begin
  inherited;
  try
    fsformnmame := 'TGlobalListSearchFrm';
    frm := FindExistingComponent(fsformnmame);
    if Assigned(frm) then TForm(frm).BringToFront
    else begin
      frm := GetComponentByClassName(fsformnmame);
      if Assigned(frm) and (frm is TForm) then begin
        TForm(frm).FormStyle := fsMDIChild;
        TForm(frm).BringToFront;
      end;
    end;
  finally
  end;
end;
procedure TdtmMainGUI.Maximiseform(Sender: TObject);
var
  w,h:Integer;
begin
   w:= Mainform.width;
   h := mainform.height;
   MainForm.windowstate:= wsNormal;
   MainForm.Left := 0;
   Mainform.Top := 0;
   mainform.Width := w*2;
   mainform.height := h;
end;

{$IFDEF DevMode}

Procedure TdtmMainGUI.DevModeQryanalyser(Sender: TObject);
begin
   OpenERPForm('TfmQueryAnalyser', 0);
end;
Procedure TdtmMainGUI.DevModeCopyBackup(Sender: TObject);
begin
   OpenERPForm('TfmCopyBackup', 0);
end;
Procedure TdtmMainGUI.DevModeexportImages(Sender: TObject);
begin
  with TForm(GetcomponentbyclassName('Tfmimages', true, nil, false)) do
    show;
end;
Procedure TdtmMainGUI.DevModeErpPDFDocs(Sender: TObject);
begin
  OpenERPForm('TERPPDFDocsDevListGUI', 0);
end;
Procedure TdtmMainGUI.DevModeExportnUploadLanguage(Sender: TObject);
begin
  OpenERPForm('TfmExportnuploadLanguage', 0);
end;
Procedure TdtmMainGUI.DevModeERPPasswords(Sender: TObject);
begin
  OpenERPListForm('TErpPasswordsForDevModeGUI', nil);
end;
procedure TdtmMainGUI.DevModeexportGuiPref(Sender: TObject);
begin
   with TForm(GetcomponentbyclassName('TfmExportpreferences', true, nil, false)) do
    show;
end;
Procedure TdtmMainGUI.DevModeformPropertyReader(Sender: TObject);
begin
   with TForm(GetcomponentbyclassName('TfmformPropertyReader', true, nil, false)) do
    show;
end;
procedure TdtmMainGUI.DevmodeRunScript(Sender: TObject);
begin
  with TForm(GetcomponentbyclassName('TRunScriptGUI', true, nil, false)) do
    show;
end;

procedure TdtmMainGUI.DoSendSMS(Sender: TObject);
begin
  with TForm(GetcomponentbyclassName('TfmSendSMS', true, nil, false)) do
    show;
end;

{$ENDIF}
procedure TdtmMainGUI.actReportsWorkShopExecute(Sender: TObject);
begin
  inherited;
  AssignActionBitmap(Sender, MainSwitch2.DoReportShow('', REPORT_GROUP_WORKSHOP));
end;

procedure TdtmMainGUI.actAuseParcelconfUpdate(Sender: TObject);
begin
  inherited;
  actAuseParcelconf.Visible := (AppEnv.RegionalOptions.RegionType = rAust) and (Appenv.CompanyPrefs.EnableAusEparcel);
end;
procedure TdtmMainGUI.actPriceMatrixHelpExecute(Sender: TObject);
var
  Qry:TERPQuery;
begin
  inherited;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    closedb(qry);
    Qry.sql.text := 'select partsId , if(parttype="INV",1,2) as parttype from tblparts where parttype ="inv" '+
             ' union select partsId , if(parttype="INV",1,2) as parttype from tblparts where parttype <> "inv"  '+
             ' order by parttype, partsId  limit 1';
    opendb(qry);
    if (qry.recordcount =0) or (qry.fieldbyname('partsId').asInteger =0) then exit;
    OpenERPform('TfrmParts',qry.fieldbyname('partsId').asInteger, afterproductformshow);
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
procedure TdtmMainGUI.afterproductformshow(Sender:TObject);
begin
    if (sender is TBaseInputGUI) and (Sender.classnameis('TfrmParts')) then
      TBaseInputGUI(sender).DoFocusControl('PriceMatrix');
end;
procedure TdtmMainGUI.actProductQtyinCrossStockCompaniesUpdate(Sender: TObject);
begin
  inherited;
  actProductQtyinCrossStockCompanies.Visible := AppEnv.CrossStockCompanies.count >0;
end;

procedure TdtmMainGUI.actAutoAdjustbinExecute(Sender: TObject);
var
  SAOriginalno: String;
  form :TComponent;
  sel : integer;
begin
  inherited;
  sel := CommonLib.MessageDlgXP_Vista('Do you wish to see all bin products in the Adjustment, or select from a list of bin products first?',
    mtConfirmation,[],0,nil,'','',false,nil,'Show All,Select from List,Cancel');
  case sel of
    100: { continue with code below };
    101: begin
           UnallocatedBinQtyList := TBaseListingGUI(GetComponentByClassName('TUnallocatedBinQtyListGUI',false));
           if not assigned(UnallocatedBinQtyList) then exit;
           UnallocatedBinQtyList.OnGridDataSelect := DoOnUnallocatedBinQtyListSelect;
           UnallocatedBinQtyList.Show;
           exit;
         end;
    102: exit;
  end;

  SAOriginalno := TStockAdjustEntry.AutoAdjustBin;
  if SAOriginalno <> '' then begin
      CommonLib.MessageDlgXP_Vista( 'Unallocated bin Quantity is allocated to the Default Bin.' +
                              chr(13)+chr(13)+'The Original no of the Stock Adjustment(s): ' +SAOriginalno +
                              chr(13) +Chr(13) +'Please make sure the stock adjustment(s) are processed.', mtInformation, [mbok], 0);
      form := GetComponentByClassName('TStockAdjustEntryListGUI');
      if assigned(Form) then begin
          TStockAdjustEntryListGUI(Form).FormStyle := fsMDIChild;
          TStockAdjustEntryListGUI(Form).qryMain.Filter := 'Originalno = ' +QuotedStr(SAOriginalno);
          TStockAdjustEntryListGUI(Form).qryMain.Filtered := True;
          TStockAdjustEntryListGUI(Form).BringToFront;
      end;
  end;

end;

procedure TdtmMainGUI.actAppointmentStatusListExecute(Sender: TObject);
begin
  inherited;
  TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_AppointmentStatusType);
end;

procedure TdtmMainGUI.actMessagesExecute(Sender: TObject);
begin
  inherited;
  MainSwitch2.ShowmesageForm;
end;

procedure TdtmMainGUI.actRemindersExecute(Sender: TObject);
begin
  inherited;
  MainSwitch2.Showreminders
end;
procedure TdtmMainGUI.actVidoesExecute(Sender: TObject);
begin
  inherited;
//@@@@  Mainform.ShowVideoFrm(MainSwitch2.CurrentButtonName);
end;

procedure TdtmMainGUI.actCustomiseExecute(Sender: TObject);
begin
  inherited;
  MainSwitch2.Docustomise(Sender);
end;

procedure TdtmMainGUI.Maximise1Click(Sender: TObject);
begin
  inherited;
   Maximiseform(Sender);;
end;

procedure TdtmMainGUI.AddCustomReports;
var
  qry: TERPQuery;
  myreport, mi: TMenuItem;
begin
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.ParamCheck := false;
    qry.SQL.Add('SELECT GuiID, Report   FROM tblCustomizedLists ' +
      'WHERE ((NOT IsNull(Report)) AND (Report <> "")) AND EmployeeID = ' +
      IntToStr(AppEnv.Employee.EmployeeID));

    qry.Open;
    if Qry.recordcount = 0 then exit;

    myreport := TMenuItem.Create(mnuReports);
    myreport.Caption := '-';
    mnuReports.Add(myreport);

    myreport := TMenuItem.Create(mnuReports);
    myreport.Caption := 'My reports';
    mnuReports.Add(myreport);

    qry.First;

    while not qry.Eof do begin
      mi := TMenuItem.Create(mnuReports);
      mi.Caption := qry.FieldByName('Report').AsString;
      mi.onclick := OnMyreportSelect;
      mi.Tag := qry.FieldByName('GuiID').AsInteger;
      myreport.add(mi);
      qry.Next;
    end;

    qry.Close;
  finally
    FreeAndNil(qry);
  end;
end;
procedure TdtmMainGUI.AddLanguageMenuItems;
var
  NewItem: TMenuItem;
begin
  With TempmyQuery do try
    connection := GetNewERPLanguageConnection(Self);
    SQL.text := 'Select * from Languages where active = "T" or Language = "English"';
    try
      open;
    Except
      on E:Exception do begin
        mnuLanguage.visible := False;
        exit;
      end;
    end;
    if recordcount > 0 then begin
      first;
      while Eof = False do begin
            NewItem := TMenuItem.Create(TAdvPopupMenu(mnuLanguage));
            NewItem.Caption := FieldByname('Language').asString;
            NewItem.Tag := FieldByname('Id').asInteger;
            NewItem.OnClick := mnuLanguageClick;
            NewItem.Name := 'mnuLanguage'+trim(inttostr(recno));
            mnuLanguage.Add(NewItem);
        Next;
      end;
    end;
  finally
    Connection.free;
    Free;
  end;
end;

procedure TdtmMainGUI.OnMyreportSelect(Sender: TObject);
begin
   if not(Sender is TMenuItem) then exit;
   if TMenuItem(SendeR).tag = 0 then exit;
   With CommonDbLib.TempMyQuery do try
    SQL.add('Select ClassName, Report from  tblCustomizedLists where  GuiID = ' + IntToStr(TMenuItem(SendeR).tag));
    open;
    OpenCustomReport(Fieldbyname('Classname').asString ,TMenuItem(SendeR).tag , Fieldbyname('Report').asString );
   finally
       if active then close;
       Free;
   end;
end;

procedure TdtmMainGUI.OpenCustomReport(const sListClass: string; const iGuiID: integer;ReportName:String);
var
  frmList: TBaseListingGUI;
begin

  if FormStillOpen(sListClass,iGuiID) then begin
    with TForm(GetComponentByClassName(sListClass,True,nil,True,True,iGuiID)) do begin
        WindowState := wsNormal;
        BringToFront;
        Exit;
    end
  end;

  if Sysutils.SameText(sListClass , 'TfrmSummarySheetGUI') then begin
    OpenERPListForm(sListClass);
    Exit;
  end;

  AppContext['CustomReportListing'].VarByname['Prefname']:= ReportName;
  try
    frmList := TBaseListingGUI(GetComponentByClassName(sListClass,True,nil,True,True,iGuiID));
    if not Assigned(frmList) then exit;
  Finally
    AppContext['CustomReportListing'].DeleteVar('Prefname');
  end;
  frmList.Tag := iGuiID;
  frmList.fiGuiID := iGuiID;
  frmList.FormStyle := fsmdiChild;
end;

procedure TdtmMainGUI.OpenProductList(Sender: TObject);
begin
  if Sender is TDnMAction then
       if  (TDnMAction(Sender) = actInventProductsProductsExpressList ) and not (AppEnv.Employee.ShowProductListtypeSelectionforExpress) then  ShowGUI(Sender, actInventProductsProductsExpressList1.classExecute, true)
  else if (TDnMAction(Sender)  = actProductQtylist                    ) and not (AppEnv.Employee.ShowProductListtypeSelectionforQtylist) then  ShowGUI(Sender, actProductQtylist1.classExecute, true)
  else if (TDnMAction(Sender)  = actInventProductsProductsList        ) and not (AppEnv.Employee.ShowProductListtypeSelectionforDetails) then  ShowGUI(Sender, actInventProductsProductsList1.classExecute, true)
  else  ShowGUI(Sender, 'TfmChooseProductList', true);
end;

procedure TdtmMainGUI.ProfitnLosschart_GrossProfit(Sender: TObject);
begin
  inherited;
  Launchchart(Sender , 'TProfitnLosschartGUI'  , 'Gross Profit' , 'Gross Profit' , true);
end;

procedure TdtmMainGUI.ProfitnLosschart_REv_Exp(Sender: TObject)              ;begin Launchchart(Sender , 'TProfitnLosschartGUI'         , 'Profit n Loss Chart'       , 'Revenue Chart'                           , true); end;
procedure TdtmMainGUI.actProfitnLosschartCompareGrossClick(Sender: TObject)  ;begin Launchchart(Sender , 'TProfitnLosschartCompareGUI'  , 'Gross Profit Comparison'     , ''       , true, TDNMAction(Sender).Tag); end;
procedure TdtmMainGUI.actProfitnLosschartCompareRevenueClick(Sender: TObject);begin Launchchart(Sender , 'TProfitnLosschartCompareGUI'  , 'Revenue comparison'   , ''     , true, TDNMAction(Sender).Tag); end;
procedure TdtmMainGUI.actProfitnLosschartCompareNIclick(Sender: TObject)     ;begin Launchchart(Sender , 'TProfitnLosschartCompareGUI'  , 'Net Income Comparison' , ''  , true, TDNMAction(Sender).Tag); end;

procedure TdtmMainGUI.actMainswitchHeightdecreaseExecute(Sender: TObject);begin  MainSwitch2.ChangeHeight(0-MENU_MIN_OFFSET_Y , true );end;
procedure TdtmMainGUI.actMainswitchHeightDefaultExecute (Sender: TObject);begin  MainSwitch2.ChangeHeight(  MENU_FORM_HEIGHT  , False);end;
procedure TdtmMainGUI.actMainswitchHeightIncreaseExecute(Sender: TObject);begin  MainSwitch2.ChangeHeight(  MENU_MIN_OFFSET_Y , true );end;
procedure TdtmMainGUI.actInt_WalMartExecute(Sender: TObject);
begin
  inherited;
  if not UsingWalmart then begin
    if MessageDlgXP_Vista(WalmartMsg, mtWarning, [mbOK], 0 ,nil,'','',false,nil,'Open Preferences') = 100 then
        OpenPrefform('EDI and Integration' ,  WalmartPrefinvalidcomponent, 1 , False,'Walmart' , 'pnlWalmartOptions' );
    Exit;
  end;
  AnyActionExecute(Sender);
end;
procedure TdtmMainGUI.actInt_WoocommExecute(Sender: TObject);
begin
  inherited;
//  if not UsingWoocommerce then begin
//    if MessageDlgXP_Vista(WoocommerceMsg, mtWarning, [mbOK], 0 ,nil,'','',false,nil,'Open Preferences') = 100 then
//        OpenPrefform('EDI and Integration' ,  WooCommercePrefinvalidcomponent, 1 , False, 'Woocommerce' , 'pnlWooCommerceOptions' );
//    Exit;
//  end;
  AnyActionExecute(Sender);
end;

initialization
  RegisterClassOnce(TdtmMainGUI);

end.












