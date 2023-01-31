Unit CompanyPrefObj;

{

  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
}

Interface

{$I ERP.inc}

Uses
  MyAccess, ERPdbComponents, DB, DNMLib, Classes, Dialogs, Controls, Variants,
  Graphics, InventoryTypes, SMSConfigObj, UPSConfigObj, GoogleCalendarConfigObj,
  FedExConfigObj, USPSConfigObj, PasswordConfigObj,
  SPSConfigObj, AmazonConfigObj, HMRC_APIConfigObj, IntuitConfigObj,
  MagentoConfigObj, AvaTaxConfigObj, StSConfigObj, VS1ConfigObj, WalmartConfigObj, EDIConfigObj;

Type
  TSalesLineLatestCostBasedOn = ( lcbPurchaseOrder= 1, lcbProductCard = 2, lcbAvgCost = 3, lcbHighest = 4,lcbLowest = 5);

  TPrefConvert = Class(
    TObject)
  Private
    FFoundRecord: Boolean;
    FQuery      : TERPQuery;
  Protected
    Function GetAsBoolean: Boolean; // virtual;
    Function GetAsCurrency: Currency; // virtual;
    Function GetAsDateTime: TDateTime; // virtual;
    Function GetAsFloat: Double; // virtual;
    Function GetAsInteger: Integer; // virtual;
    Function GetAsString: String; // virtual;
    Function GetAsVariant: Variant; // virtual;
    Procedure SetAsBoolean(Const Value: Boolean); // virtual;
    Procedure SetAsCurrency(Const Value: Currency); // virtual;
    Procedure SetAsDateTime(Const Value: TDateTime); // virtual;
    Procedure SetAsFloat(Const Value: Double); // virtual;
    Procedure SetAsInteger(Const Value: Integer); // virtual;
    Procedure SetAsString(Const Value: String); // virtual;
    Procedure SetAsVariant(Const Value: Variant); // virtual;
  Public
    Constructor Create;
    Property FoundRecord: Boolean Read FFoundRecord Write FFoundRecord;
    Property Query: TERPQuery Read FQuery Write FQuery;
    Property AsBoolean: Boolean Read GetAsBoolean Write SetAsBoolean;
    Property AsCurrency: Currency Read GetAsCurrency Write SetAsCurrency;
    Property AsDateTime: TDateTime Read GetAsDateTime Write SetAsDateTime;
    Property AsFloat: Double Read GetAsFloat Write SetAsFloat;
    Property AsInteger: Integer Read GetAsInteger Write SetAsInteger;
    Property AsString: String Read GetAsString Write SetAsString;
    Property AsVariant: Variant Read GetAsVariant Write SetAsVariant;

  End;

  TCompanyPrefObj = Class(TObject)
  Private
      FPrefConvert               : TPrefConvert;
      QryPrefs                   : TERPQuery;
      FsManifestType             : String;
      FbHintInEditMode           : Boolean;
      FbDefaultRepUser           : Boolean;
      FbWholeSaleToggleON        : Boolean;
      FdWholesalePercentag       : Double;
      FbSuppressJobNameOnInvoices: Boolean;
      FbReceiptPrinterON        : Boolean;
      FbSingleQtySO             : Boolean;
      FbSoToInvShipWhenAvailable: Boolean;
      FbMultiTills              : Boolean;
      FbMultiSalesPerson        : Boolean;
      FbMustProvidePOSPostCode  : Boolean;
      FbAutoBackup              : Boolean;
      FbDisableCusSourceTracking: Boolean;
      FbPrintBestPractices: Boolean;
      FbShowInvoiceFormwhenRepairInvoiced: Boolean;
      FdMaxDiscountPercentage            : Double;
      FdMinMarkupPercentage              : Double;
      FdMinimumMarginPercentage          : Double;
      FiDefaultSuppPaymentAccount        : Integer;
      FiAPTerms1                         : Integer;
      FiDefaultCCardPaymentAccount       : Integer;
      FiAPTerms3                         : Integer;
      FiDefaultCustPaymentAccount        : Integer;
      FiDefaultSPAAccount                : Integer;
      FsInvoice_footer                   : String;
      FsLaybyTerms                       : String;
      FsReceiptFooter                    : String;
      FsReceiptPrinterType               : String;
      FsReceiptPrinterPort               : String;
      FdtClosingDate                     : TDateTime;
      FdtClosingDateAP                   : TDateTime;
      FdtClosingDateAR                   : TDateTime;
      FiCreditTermsID                    : Integer;
      FiDebitTermsId                     : Integer;
      FrCreditLimit                      : Currency;
      FrMaxSmartAmount                   : Currency;
      fiTotalvolumeUOMInsmartOrder       : Integer;
      fsUOMforTotalvolumeInsmartOrder    : String;
      FiGracePeriod                      : Integer;
      FiDefaultSalesAccount              : Integer;
      FiDefaultPurchasesAccount          : Integer;
      FiFollowupDays                     : Integer;
      FbFastProductList                  : Boolean;
      FbDisableNotifyLists               : Boolean;
      FdMinAboveCost                     : Double;
      FiDefaultDepositsAccount           : Integer;
      FiDefPartsCOGSAccount              : Integer;
      FiDefPartsAssetAccount             : Integer;
      FiDefPartsIncomeAccount            : Integer;
      FsDefaultPurchaseTaxCode           : String;
      FsDefaultSalesTaxCode              : String;
      FsPickupShipingMethod              : String;
      FsCommittedStatus                  : String;
      FbPrintBarcodesOnReceival          : Boolean;
      FiDefaultChequeAccount             : Integer;
      FbValidateAllocation               : Boolean;
      FbEnforceAllocationValidation      : Boolean;
      FbEnforceAllocationValidationinPI  : Boolean;
      FbResetSaleDateWhenBuilt           : Boolean;
      FbPrintStoreAwayOnReceival      : Boolean;
      FbUsePayroll                    : Boolean;
      FbUseGoogleAnalytics            : Boolean;
      FsSupplierforautoPostingGoogle  : String;
      FbPOSPassword                   : Boolean;
      FbNoPreferredSuppQuestion       : Boolean;
      FbNoCustSpecialPriceQuestion    : Boolean;
      FbNoCashCustSpecialPriceQuestion: Boolean;
      FbAutoPickBins           : Boolean;
      FbAutoPickBatches        : Boolean;
      FbShowSalesUnits         : Boolean;
      FbShowSalesCostInc       : Boolean;
      FbShowPurchasecostinSales: Boolean;
      FbShowSalesDescription   : Boolean;
      FbShowSalesProfit        : Boolean;
      FbShowSalesProfitPercent : Boolean;
      FbShowSalesTaxCode       : Boolean;
      FbShowSalesTaxAmount     : Boolean;
      FbShowSalesDiscount      : Boolean;
      FbShowPurchUnits         : Boolean;
      FbShowPurchDescription   : Boolean;
      FbShowPurchCustJob       : Boolean;
      FbShowPurchCostInc       : Boolean;
      FbShowPurchClass         : Boolean;
      FbShowPurchTaxCode       : Boolean;
      // fbShowTaxwithNostate: Boolean;
      FbfilterTaxcodeforClient                 : Boolean;
      FbShowAllocationBatchExpiryDate          : Boolean;
      FbShowAllocationBatchTruckLoadNo         : Boolean;
      fsAllocationBatchTruckLoadNoGenerateMode : String;
      FbAllowToPickFromOtherslaesIntheGroup    : Boolean;
      FbAllowtoshipnPickFromBackorderinthegroup: Boolean;
      FbShowPurchTaxAmount                     : Boolean;
      FbCreditCheckInv                         : Boolean;
      FbCreditCheckSO                          : Boolean;
      FbShowProductAttributes                  : Boolean;
      FbShowProductOptions                     : Boolean;
      FbYodleeEnabled                          : Boolean;
      FbMagentoEnabled                         : Boolean;
      FbShowMagentoOnMainMenu                  : Boolean;
      FbAutoSyncMagento                        : Boolean;
      FiSmartOrderbasedOn                      : Integer;
      FbShowMeasurementAttributes              : Boolean;
      FbShowProductExtraAttributes             : Boolean;
      FiNoOfAttribstodisplay                   : Integer;
      FsProductAttrib1Name                     : String;
      FsAreaColumnName                         : String;
      FsProductAttrib2Name                     : String;
      FsProductAttrib3Name                     : String;
      FsSalesDefaultValueForAreaFrom           : String;
      FsPODefaultValueForAreaFrom              : String;
      FsPrimaryPrinter                         : String;
      FdHoursPerWeek                           : Double;
      FdALeaveWeeks                            : Double;
      FdSickLeaveDays                          : Double;
      FdLSLWeeks                               : Double;
      FdLSLCommenceYears                       : Double;
      FbPOSRestrictRefund                      : Boolean;
      FbRestrictRefund                         : Boolean;
      FbPOSHideLaybyRcptAmnt                   : Boolean;
      FbPOSHideSalesRcptAmnt                   : Boolean;
      FbCombinedInvoiceBO                      : Boolean;
      FbCombinedSaleOrderBO                    : Boolean;
      FbUseAutoChequeNo                        : Boolean;
      FbUseGroupedPOSDeposits                  : Boolean;
      FbSpecProd_Override_Disc                 : Boolean;
      FbUseForeignCurrencyonPO                 : Boolean;
      FbEnforceConNoteOnPO                     : Boolean;
      FbIncludeLandedCostsinAvgCost            : Boolean;
      FbUseFixedAssets                         : Boolean;
      FbUseShippedDateForTerms                 : Boolean;
      FbAllowchangeofTermAfterDueDate          : Boolean;
      FiShippedDaysAfterCreate                 : Integer;
      FichequeTemplate_NoofLinesinDetailSection: Integer;
      FbPrintPickSlipWithInvoice               : Boolean;
      FbPrintDelDocketWithInvoice              : Boolean;
      FbUseManifest                            : Boolean;
      FiManifestDaysAfterDespatchDate          : Integer;
      FbAutoEditInvoiceBarcodePick             : Boolean;
      FbPrintInvoiceBarcodePick                : Boolean;
      FbPrintDelDocketBarcodePick              : Boolean;
      FbPrintConNotesBarcodePick               : Boolean;
      FbAutoAddBarcodes                        : Boolean;
      FbPhoneNumberFormatting                  : Boolean;
      FbPostcodeFormatting                     : Boolean;
      FbDefaultPayMethodID                     : Integer;
      FbUseBatchTransactions                   : Boolean;
      FbShowAccountNumbers                     : Boolean;
      FbShowSupplieronSO                       : Boolean;
      FbShowSupplierContactonSO                : Boolean;
      FsODueOk                                 : String;
      FsODue1Days                              : String;
      FsODue7Days                              : String;
      FsODue14Days                             : String;
      FsODue21Days                             : String;
      FsODue30Days                             : String;
      FsODue60Days                             : String;
      FsODue90Days                             : String;
      FbUseBarcodePicking                      : Boolean;
      FbUseForeignCurrencyonSales              : Boolean;
      FbAutoAddProdCode                        : Boolean;
      FbPOSLaybyPickSlip                       : Boolean;
      FbUseTrafficMonitor                      : Boolean;
      FbPOSNumKeyPad                           : Boolean;
      FbUseExpressProductList                  : Boolean;
      FiProductNameDropdownWidth               : Integer;
      FiProductfirstcolumnDropdownWidth        : Integer;
      FiProductsecondcolumnDropdownWidth       : Integer;
      FiProductthirdcolumnDropdownWidth        : Integer;
      FiProductSalesDescDropdownWidth          : Integer;
      FiProductPODescDropdownWidth             : Integer;
      FiProductPreferedSupDropdownWidth        : Integer;
      FiProductSupplierProductCodeDropdownWidth: Integer;
      FiLastContactDays                        : Integer;
      FiLastSaleDays                           : Integer;
      FdtStartOfDay                            : TDateTime;
      FdtEndOfDay                              : TDateTime;
      FdLeaveLoadTaxThreshold                  : Double;
      FdtLoyaltyStartDate                      : TDateTime;
      FbPOSSummarise                           : Boolean;
      FbPOenforceETA                           : Boolean;
      FsPurchaseETACalculatedFrom              : String;
      FdSalesValue                             : Double;
      FdtLoyaltyReminderDate                   : TDateTime;
      FiLoyaltyReminderRepeatDays              : Integer;
      FiLastAppointDays                        : Integer;
      FbOpenCashDrawerFromCashSale             : Boolean;
      FbUseClockOn                             : Boolean;
      FbUseClockedHrs                          : Boolean;
      FbIgnoreEarlyStart                       : Boolean;
      FbIgnoreLateFinish                       : Boolean;
      FbBarcodePickingInSOMode                 : Boolean;
      FbAutoConvertSOtoInvoiceBarcodePick      : Boolean;
      FbConsolidateCustBOonInvoice             : Boolean;
      FbHideMatrixLineWithnoQty                : Boolean;
      FbHideNonProductBOMEnrties               : Boolean;
      FbShowActiveClassOnReports               : Boolean;
      FbIntegratedEFTPOS                       : Boolean;
      FbCostonSalesToPO                        : Boolean;
      FbPOSUseCashDrawerOnly                   : Boolean;
      FbMemTransPriceUpdate                    : Boolean;
      FbUseAuditTrail                          : Boolean;
      FbPOSSummariseBarTabInv                  : Boolean;
      FbUseTNTFreight                          : Boolean;
      FbGroupJobsOnAccountsReceivable          : Boolean;
      FbEnforceNoModifyonNotes                 : Boolean;
      FbNoReturntoPrimaryKeypad                : Boolean;
      FsStartWorkWeek                            : String;
      FiNoofWeekendDays                          : Integer;
      FsEndWeek                                  : String;
      FiStartWorkWeek                            : Integer;
      FiEndWeek                                  : Integer;
      FbRecalcCostInvBO                          : Boolean;
      FsFixedAssetDepreciationAssetAccount       : String;
      FsFixedAssetDepreciationExpAccount         : String;
      FsFixedAssetCostAssetAccount               : String;
      FsFixedAssetClearingAccount                : String;
      FbFiscalYearStarts                         : String;
      FbDepreciationCalculationConventions1      : String;
      FbMonthofPurchase1                         : String;
      FbMonthofDisposal1                         : String;
      FbDepreciationCalculationConventions2      : String;
      FbMonthofPurchase2                         : String;
      FbMonthofDisposal2                         : String;
      FbVerifyBalanceOnBatch                     : Boolean;
      FiSpecialBarcodeLen                        : Integer;
      FiSpecialBarcodeProductPos                 : Integer;
      FiSpecialBarcodeProductLen                 : Integer;
      FiSpecialBarcodeAmountPos                  : Integer;
      FiSpecialBarcodeAmountLen                  : Integer;
      FiDepreciationForTransactions              : Integer;
      FbSupportPopupEnabled                      : Boolean;
      FiSupportNoOfCalls                         : Integer;
      FiSupportPeriodInDays                      : Integer;
      FsSupportPopupMessage                      : String;
      FdMedicareLevyRate                         : Double;
      FdTaxableDeduction                         : Double;
      FdMedicareLevySurchargeRate                : Double;
      FdLumpSumTaxRate                           : Double;
      FdLumpSumTaxRateOver55                     : Double;
      FdLumpSumETaxRate                          : Double;
      FdFBTTaxRate                               : Double;
      FdRBLThreshold                             : Double;
      FdNoTFNTaxRate                             : Double;
      FdYearlyIncomeThreshold                    : Double;
      FbPOSCloseInvoiceAfterCreate               : Boolean;
      FbShowSoldSerialNumbers                    : Boolean;
      FbUseTemplateDefaultInvoice                : Boolean;
      FbSumReceivedOnlyForeignCurrencyonPO       : Boolean;
      FsJobNameHeader                            : String;
      FsDefaultStatusForInvoiceofdonerepair      : String;
      FsDefaultStockTransferAccount              : String;
      FsDefaultStatusforSOofDoneRepair           : String;
      FsJobNumberHeader                          : String;
      FbUseDelivery                              : Boolean;
      FbOneRunPerCustomer                        : Boolean;
      FbPOSCreateOrders                          : Boolean;
      FbPrintBarcodesOnOrder                     : Boolean;
      FbAutoGenerateCustomerAccntNumber          : Boolean;
      FbStoreForeignCurrencyValue                : Boolean;
      FbUseManufacturing                         : Boolean;
      FbShowLatestCost                           : Boolean;
      FbShowGrossProfitPercent                   : Boolean;
      FbAutoCorrectPriceDiscountsOnDeliveries    : Boolean;
      FbUseHistoryOnDespatchRuns                 : Boolean;
      FbDefaultToChartOfAccountsTreeView         : Boolean;
      FbUseCostCentres                           : Boolean;
      FbDisableAltSaveCost                       : Boolean;
      FbShowCustomerJobNoByDefault               : Boolean;
      FbCopyDataToNewDB                          : Boolean;
      FbCopyEmployeeSettings                     : Boolean;
      FbCopyCompanySettings                      : Boolean;
      FbCopyEmployeeAccess                       : Boolean;
      FbUseCRM                                   : Boolean;
      FbUseBudget                                : Boolean;
      FbUseHire                                  : Boolean;
      FbLogoutwhenIdle                           : Boolean;
      FdSessiontime                              : Double;
      FbUseWorkShop                              : Boolean;
      FbUseWorkFlow                              : Boolean;
      FbStartJobNumber                           : Boolean;
      FbDisableCopyToSmart                       : Boolean;
      FbDisableInvCopyToSmartIfPOCreated         : Boolean;
      FbShowDocketNumberColumnOnSales            : Boolean;
      FbShowDocketNumberColumnOnPurchases        : Boolean;
      FbJobTitle                                 : String;
      FbShowInvoiceFormwhenApptInvoiced          : Boolean;
      FbSalesWarrantyEndsOnCaption               : String;
      FbSalesWarrantyPeriodCaption               : String;
      FbShowSalesWarrantyEndsOn                  : Boolean;
      FbShowSalesWarrantyPeriod                  : Boolean;
      FbMatchUOMonSerialNoSelection              : Boolean;
      FbMatchUOMonBinBatchAllocation             : Boolean;
      FbMatchUOMinallocation                     : Boolean;
      FbEnforceBinVolume                         : Boolean;
      fbCountSOBOInAvailable                     : Boolean;
      FbEnableBatchByDefault                     : Boolean;
      FdDefaultProductVolume                     : Double;
      FbEnableBinByDefault                       : Boolean;
      FbEnableSerialsByDefault                   : Boolean;
      FbCreditCheckAppointment                   : String;
      FbCreditCheckRepair                        : Boolean;
      FbUseProductSpecsCalcsPO                   : Boolean;
      FbUseProductSpecsCalcsSales                : Boolean;
      FbAllowAlocationFromOtherClasses           : Boolean;
      FNABCardFastMerchantNumber                 : String;
      FtStockCostSystem                          : TStockCostSystem;
      FRememberLastTransactionBySupplier         : Boolean;
      FRememberLastReconDeposit                  : Boolean;
      FUseTimesheetRateIncAsInvoiceCost          : Boolean;
      FCancelledAppointmentsNotPrinted           : Boolean;
      FsCustomerListMode                         : String;
      FAlwaysShowBOonCustomerCost                : Boolean;
      FbProductClassDefaultAll                   : Boolean;
      FbInvoiceClassDefaultAll                   : Boolean;
      FbEmailWhenPrintingPickingSlip             : Boolean;
      FsPickingSlipEmailRecipient                : String;
      FbCopyCOA                                  : Boolean;
      FbCopyClients                              : Boolean;
      FbCopyMarketingContacts                    : Boolean;
      FbIncludeContactNameInSalesshippingAddress : Boolean;
      FbIncludeContactPhoneInSalesshippingAddress: Boolean;
      FbCopyProducts                             : Boolean;
      FbCopyOutstandingTxn                       : Boolean;
      FdIncomeTaxPercentage                      : Double;
      FiMonthsStockRetained                      : Integer;
      FsCodeHeader                               : String;
      FdSummarisedTransDate                      : TDateTime;
      FdSummarisedTransDateChanged               : TDateTime;
      FiSupplierPaymentsDefaultVariationAccountID: Integer;
      FiCustomerPaymentsDefaultVariationAccountID: Integer;
      FsEmailAuthPassword                        : String;
      FbAllClassesOnCustList                     : Boolean;
      FbPOOnlyApprovedTransInSuppPayment         : Boolean;
      FbIncludeUnInvoicedPOtoGL                  : Boolean;
      FiUnInvoicedPOAccount                      : Integer;
      FbIncludeUnInvoicedSOtoGL                  : Boolean;
      FiUnInvoicedSOAccount                      : Integer;
      FiUnInvoicedSOType                         : Integer;
      FiUnInvoicedSOLabourAccount                : Integer;
      FbUseBlindBalance                          : Boolean;
      FsCompanyRegion                            : String;
      FbPOSShowProductPic                        : Boolean;
      FbBankAccFormatting                        : Boolean;
      FbPOSPrintReceiptOnlyOnCompleteSale        : Boolean;
      FbPOSPrintDescriptionMultipleLines         : Boolean;
      FbUsePCC                                   : Boolean;
      FsPCCPathToVisualConsole                   : String;
      FbUseAlphaNumericBarcodes                  : Boolean;
      FbBarTabsConvertStarted                    : Boolean;
      FbBatchUpdateInProgress                    : Boolean;
      FbSalesCommissionCalcInProgress            : Boolean;
      FiSalesCommissionCalcEmployeeID            : Integer;
      FdtTransactionTableLastUpdated             : TDateTime;
      FdtReportTablesLastUpdatedOn               : TDateTime;
      FdtSerialNumberListUpdatedOn               : TDateTime;
      FbUseFutureSO                              : Boolean;
      FbLeaveOpenOnCopyToINV                     : Boolean;
      FiFutureSODays                             : Integer;
      FbPCCVCAutoStart                           : Boolean;
      FbEnableWebAPILoging                       : Boolean;
      // fbUseAssessment: boolean;
      FbEmailInvoiceInfoToCustomer  : Boolean;
      FbAutomaticDeliveryDocketPrint: Boolean;
      FbResetCustPrices             : Boolean;
      FbPaymentsAddToEFT            : Boolean;
      FsDefaultDiscountMarkup       : String;
      FbUseApprovalLevels           : Boolean;
      fbCleanUseApprovalLevels      : Boolean;
      FsApprovalType                : String;
      FbUsePriceSchems              : Boolean;
      FbUseDefaultMailClient        : Boolean;
      FbDefaultMailClientPreview    : Boolean;
      FbEnableInvoicePickMail       : Boolean;
      FbEnableInvoicePickSMS        : Boolean;
      FbEnableInvoiceDelMail        : Boolean;
      FbEnableInvoiceDelSMS         : Boolean;
      FbEnableInvoiceMail           : Boolean;
      FbEnableInvoicePrintSMS       : Boolean;

      FsInvoicePickMailSubject: String;
      FsInvoicePickMailText   : String;
      FsInvoicePickSMSText    : String;
      FsInvoiceDelMailSubject : String;
      FsInvoiceDelMailText    : String;
      FsInvoiceDelSMSText     : String;
      FsInvoiceMailSubject    : String;
      FsInvoiceMailText       : String;
      FsInvoicePrintSMSText   : String;

      FbUseElectronicIntrastat        : Boolean;
      FbUseElectronicVAT              : Boolean;
      FsVATSenderID                   : String;
      FsVATKeyType                    : String;
      FsVATKeys                       : String;
      FsVATVendorID                   : String;
      FsProductListPriceMultiplierOn  : String;
      FsVATCurrencyCode               : String;
      FsVATAuthentication             : String;
      FiVATMaxAttemptsPerSession      : Integer;
      FbUKGateWayIsLive               : Boolean;
      FbUseEmployeeClassForARList     : Boolean;
      FUpdateSaleShippedFromPOReceived: Boolean;
      FWorkersCompRate                : Double;
      FProductListPriceMultiplier     : Double;
      FbShowDashboard                 : Boolean;
      FsDashboardToshow               : String;
      FbZerotaxWhenLoss               : Boolean;
      // FbProductAvgcostCalculatedForDepartment  : Boolean;
      FbConfirmBeforeInvoiceStockToNegative    : Boolean;
      FsUSBPrinterName                         : String;
      FbPrintPOSTemplateReport                 : Boolean;
      FsNegativeStockcheckinInvoicebasedon     : String;
      FsRetailcustomerType1                    : String;
      FsWholeSaleCustomerType1                 : String;
      FsWholeSaleCustomerType2                 : String;
      FsWholeSaleCustomerType3                 : String;
      FsWholeSaleCustomerType4                 : String;
      FbUSeSalesCommission                     : Boolean;
      FCustomerTypeRequired                    : Boolean;
      FbUniqueCustomerPONumInSale              : Boolean;
      FbExcludeBOFromPrintinPO                 : Boolean;
      FbExcludeBOFromPrintinSales              : Boolean;
      FbMustProvidePOSSource                   : Boolean;
      FbMustProvideDetailsforCashout           : Boolean;
      FValueforRewardPoints                    : Double;
      FiRoundUpPoints                          : Integer;
      FiRewardPointssoldAccount                : Integer;
      FiExpenseAccountforRewardPoints          : Integer;
      FsPOSRewardPointTemplate                 : String;
      FiExpiresOnNoOfMonthsAfterPurchase       : Integer;
      FiRewardPointsExpiredAccount             : Integer;
      FiMultiplesofPointstoRedeem              : Integer;
      FbMonitorTransactionEvents               : Boolean;
      FbAutoLoadActualDatetimeFromscheduled    : Boolean;
      FiAppointmentDuration                    : Integer;
      FiMinimumChargeAppointmentTime           : Integer;
      FbAutoUpdateActual                       : Boolean;
      FbManufacturePartSourceStock             : Boolean;
      FiNoOfMonthstoChangeClosingdate          : Integer;
      FbProductcomboLookupExpressList          : Boolean;
      FbCustomercomboLookupExpressList         : Boolean;
      FbAutomaticallyUpdateclosingDate         : Boolean;
      FbCopyClientDetailsFromPOStoSalesComments: Boolean;
      FsUOMWeightUOM                           : String;
      FsUOMVolumeDimensionUOM                  : String;
      FbManufacturePartSourceStockconfirm      : Boolean;
      FbAutoCreateSmartOrderFromSalesOrderTree : Boolean;
      FbCopyTreeInfotoSalesDesc                : Boolean;
      FbPrintOnItemProgress                    : Boolean;
      FbPrintOnItemcompletion                  : Boolean;
      FbHideSelectedSubnodesinReport           : Boolean;
      FbAutoclockOnemployeeOnjob               : Boolean;
      FbOpenTreeOnSmartOrdercreation: Boolean;
      FbCustomerABNFormating        : Boolean;
      FbShowAccountNumberinBudget   : Boolean;
      FbConvertConvertedSmartOrder  : Boolean;
      FbConvertConvertedSalesOrder  : Boolean;
      FbConfirmBeforesalePricechange: Boolean;
      // fiQtyRoundTo: Integer;
      FbDefaultCustomerClassInPayments: Boolean;
      FbIgnoreTraining                : Boolean;
      FbCurrentDateforSalesshipment   : Boolean;
      FbPOSPrintAfterSave             : Boolean;
      FiRoundUp                       : Integer;
      FbRoundLotsnRoundup             : Boolean;
      FdRoundLotsof                   : Double;

      FiProductPriceRoundUp          : Integer;
      FbProductPriceRoundLotsnRoundup: Boolean;
      FiProductPriceRoundLotsof      : Integer;

      FdOPOSScaleMultiplier                       : Double;
      FsCopySalesOrderShiptotoRepairs             : String;
      FsDefaultEmailSubject                       : String;
      FsDefaultEmailText                          : String;
      FbPOMatchLineETAToHeaderETA                 : Boolean;
      FbSalesWarrantyEndsOnRequired               : Boolean;
      FbSalesWarrantyPeriodRequired               : Boolean;
      FbPOMatchLineETAToShippingContainerETA      : Boolean;
      FbWarnWhenSalesCreationdateisfuture         : Boolean;
      FbLogchangingDetailsonServicePadFeedback    : Boolean;
      FbLogchangingDetailsonRepairsFeedback       : Boolean;
      FbLogchangingDetailsonRepairsNotes          : Boolean;
      FbLogchangingDetailsonSupportPricingNotes   : Boolean;
      FbLogchangingDetailsonSupplierfollowupNotes : Boolean;
      FbLogchangingDetailsonchequecomments        : Boolean;
      FbLogchangingDetailsonchequeInternalcomments: Boolean;
      FbLogchangingDetailsonCustPayComments       : Boolean;
      FbLogchangingDetailsonDepositEntryNotes     : Boolean;
      FbLogchangingDetailsonDepositNotes          : Boolean;
      FbLogchangingDetailsonSuppPayNotes          : Boolean;
      FbLogchangingDetailsonTimesheetInvoiceNotes : Boolean;
      FbLogchangingDetailsonRepairNotes           : Boolean;
      FbLogchangingDetailsonRepairFeedbackNotes   : Boolean;
      FbLogchangingDetailsonCashsAleComments      : Boolean;
      FbLogchangingDetailsonCustomerfollowupNotes : Boolean;

      FbWarnWhenPurchaseCreationDateisfuture      : Boolean;
      FbShowDeliveryDetailsformonDeldocketprint   : Boolean;
      FbShowManufacutresummarywhenchangedfromSales: Boolean;
      FbPrintAddressLabelfromDelPrint             : Boolean;
      FbCapacityplannerSelectionOptionBeforeLoad  : Boolean;
      FbUseEmployeeDeptAddressinPOShipto          : Boolean;
      FbOpenTreeFromSalesOrder                    : Boolean;
      // fbPOMatchHeaderETAToShippingContainerETA:Boolean;
      FbPOMatchHeaderETAToLineETA         : Boolean;
      //FdFristTransDate                    : TDateTime;
      FbEnablequoteVariation              : Boolean;
      FbSupportAllcustomers               : Boolean;
      FsTeamViewerPath                    : String;
      FsERPSupportPath                    : String;
      FiMaxNoOfAttributes                 : Integer;
      FbBOByDefaultOnSO                   : Boolean;
      FsSkypePath                         : String;
      FbExcludeInactiveContactFromMessages: Boolean;
      FbShowRelatedMasterinSales          : Boolean;
      FbShowRelatedProductsinSales        : Boolean;
      // FbSales_ProductlistMatchCustomerArea : Boolean;
      FsRelatedMasterCaptionInSales               : String;
      FMatchSaleLineShipDateToHeader              : Boolean;
      FMatchSalesLineShipdateToProductDeliveryDays: Boolean;
      FsStatusToMakeSalesOrder                    : String;
      FsStatustoMakeInvoice                       : String;
      FbRemoveHideOnPrintProductFromReports       : Boolean;
      FbHoldRepairOnPrinting                      : Boolean;
      FbRepairDoneOnConversion                    : Boolean;
      FbLockRepairwhenDone                        : Boolean;
      // fbRepairHasToBeApprovedforInvoicing: Boolean;
      FsRepairStatustoMakeInvoice: String;
      // fbSOHasToBeApprovedforInvoicing: Boolean;
      FbEnforceCustPOInrepairbeforeOtherInfo: Boolean;
      FbCanEditSalesshiptoAddress           : Boolean;
      // FbfbIncludeJournalsInCashBAS                    : Boolean;
      FbCanChanePOInvoiceNo                           : Boolean;
      FdInsuranceProductListMinCost                   : Double;
      FsInsuranceProductNameStartsWith                : String;
      FsDefaultAccountingMethod                       : String;
      FsInsurancereportOrderbyProductNameStartswith1  : String;
      FsInsurancereportOrderbyProductNameStartswith2  : String;
      FsInsuranceAgencyREf1                           : String;
      FsInsuranceAgencyREf2                           : String;
      FdInsurancePremiumcharged                       : Double;
      FbIsSalesCategoryMandatory                      : Boolean;
      FsSalesPrintOrderBy                             : String;
      FbReplaceDiscontinuedwithAlternate              : Boolean;
      FbUseDiscontinuedProductPriceforAlternateProduct: Boolean;
      FbLoadCustnameinNewshippingAddress              : Boolean;
      FsDefualtModuleNameforPhSupport                 : String;
      FbPadQuotePricesIncTax                          : Boolean;
      // FbUseProductBuyCostForLatestCost                : Boolean;
      fSalesLineLatestCostBasedOn           : TSalesLineLatestCostBasedOn;
      FbCreditCheckPO                       : Boolean;
      FbCreditcheckPOIncludeBO              : Boolean;
      FsRALineDefaultStatus                 : String;
      FbClosingDateChangeDone               : Boolean;
      FbSupportAutoAssign                   : Boolean;
      FbCombineRepairTimeSheetLinesOnInvoice: Boolean;
      FbPartCalcfield1                      : Boolean;
      FbPartCalcfield2                      : Boolean;
      FbPartCalcfield3                      : Boolean;
      FbPartCalcfield4                      : Boolean;
      FbPartCalcfield5                      : Boolean;

      FsPartCalcfield5Name             : String;
      FsPartCalcField1Name             : String;
      FsPartCalcfield2Name             : String;
      FsPartCalcfield3Name             : String;
      FsPartCalcfield4Name             : String;
      FQtySoldColour                   : TColor;
      FQtyShippedColour                : TColor;
      FBinAllocationColour             : TColor;
      FBatchAllocationColour           : TColor;
      FSNAllocationColour              : TColor;
      FContainerRelatedProductColour   : TColor;
      FPalletRelatedProductColour      : TColor;
      FbIndicateifBatchAllocated       : Boolean;
      FbIndicateifBinAllocated         : Boolean;
      FbIndicateifSNAllocated          : Boolean;
      FbIndicateContainerRelatedProduct: Boolean;
      FbIndicatePalletRelatedProduct   : Boolean;
      FGanttChartGFStartColour         : TColor;
      FGanttChartGFEndcolour           : TColor;
      FiGanttChartDrawStyle            : Integer;
      FiGanttChartBarHeight              : Integer;
      FiCostDecimalPlacesinTree          : Integer;
      FiPPGBalanceAdjAccountID           : Integer;
      FiPPGBalanceAdjEmployeeID          : Integer;
      FsDefaultBOMWastageAccount         : String;
      FBoMNonProductsubnodePostingAccount: String;
      FProductStatusPartQtyColour        : TColor;
      FProductStatusTransQtyColour       : TColor;
      FProductStatusOrderQtyColour       : TColor;
      FProductStatusETAWithinPeriodColour: TColor;
      FProductStatusETAExceededColour    : TColor;
      FbShowSalesProductAutoSelectOptions: Boolean;
      FCyTrackIntegrationEnabled         : Boolean;
      FbIsClonedCopy                     : Boolean;
      FbDisableAutoUpdateclosingDate     : Boolean;
      FbShowAmountToAppearOnPrintout     : Boolean;
      FEnforceCustomerFirstAndLastName   : Boolean;
      FEnforcesupplierFirstName          : Boolean;
      FbIncludeJournalsInCashBAS         : Boolean;
      FbEnableAusEparcel                 : Boolean;
      FbEnableInvoiceSaveMail            : Boolean;
      FbEnableInvoiceSaveSMS             : Boolean;
      FsInvoiceSaveEmailSubject          : String;
      FsInvoiceSaveEmailText             : String;
      FsInvoiceSaveSMSText               : String;

      FSMSConfig                       : TSMSConfig;
      fGoogleCalendarConfig            : TGoogleCalendarConfig;
      FbEnableSOPrintSMS               : Boolean;
      FsSOPrintEmailSubject            : String;
      FbEnableSOPrintEmail             : Boolean;
      FsSOPrintEmailText               : String;
      FsSOPrintSMSText                 : String;
      FbEnableSOSaveEmail              : Boolean;
      FsSOSaveEmailText                : String;
      FbEnableSOSaveSMS                : Boolean;
      FbApplyPrepaymentsOnSOConversion : Boolean;
      FbEnableScheduledreports         : Boolean;
      FsSOSaveSMSText                  : String;
      FsSOSaveEmailSubject             : String;
      FsQuoteSaveSMSText               : String;
      FbEnableQuotePrintSMS            : Boolean;
      FsQuoteSaveEmailSubject          : String;
      FsQuotePrintSMSText              : String;
      FbEnableQuoteSaveEmail           : Boolean;
      FsQuotePrintEmailSubject         : String;
      FsQuoteSaveEmailText             : String;
      FbEnableQuotePrintEmail          : Boolean;
      FsQuotePrintEmailText            : String;
      FbEnableQuoteSaveSMS             : Boolean;
      FbEnablShipContainerChangeSMS    : Boolean;
      FsShipContainerChangeEmailText   : String;
      FsShipContainerChangeSMSText     : String;
      FsShipContainerChangeEmailSubject: String;
      FbEnableShipContainerChangeEmail : Boolean;
      FbEnableAppointmentPrintEmail    : Boolean;
      FsAppointmentPrintEmailText      : String;
      FbEnableAppointmentPrintSMS      : Boolean;
      FsAppointmentPrintSMSText        : String;
      FsAppointmentPrintEmailSubject   : String;
      FsPOReceiveInvEmailText          : String;
      FbEnablePOReceiveSOSMS           : Boolean;
      FbEnablePOReceiveInvSMS          : Boolean;
      FsPOReceiveSOSMSText             : String;
      FsPOReceiveInvSMSText            : String;
      FsPOReceiveSOEmailSubject        : String;
      FsPOReceiveInvEmailSubject       : String;
      FbEnablePOReceiveSOEmail         : Boolean;
      FbEnablePOReceiveInvEmail        : Boolean;
      FsPOReceiveSOEmailText           : String;
      FsInvShipChangeEmailText         : String;
      FbEnableInvShipChangeSMS         : Boolean;
      FsInvShipChangeSMSText           : String;
      FsInvShipChangeEmailSubject      : String;
      FbEnableInvShipChangeEmail       : Boolean;
      FbEnableSOShipChangeSMS          : Boolean;
      FsSOShipChangeSMSText            : String;
      FsSOShipChangeEmailSubject       : String;
      FbEnableSOShipChangeEmail        : Boolean;
      FsSOShipChangeEmailText          : String;
      FsRefundPrintEmailSubject        : String;
      FbEnableRefundPrintEmail         : Boolean;
      FsRefundPrintEmailText           : String;
      FbEnableRefundPrintSMS           : Boolean;
      FsRefundPrintSMSText             : String;
      FsRepairPrintSMSText             : String;

      FsSavesoundfile          : String;
      FsPrintsoundfile         : String;
      FsCancelsoundfile        : String;
      FsEmailsoundfile         : String;
      FsRepairPrintEmailSubject: String;
      FbEnableSoundonEmail     : Boolean;
      FbEnableSoundonSave      : Boolean;
      FbEnableSoundonPrint     : Boolean;
      FbEnableSoundonCancel    : Boolean;

      FbEnableRepairPrintEmail           : Boolean;
      FbEnableAutoSplitQtyintoUOMinSales : Boolean;
      FsRepairPrintEmailText             : String;
      FbEnableRepairPrintSMS             : Boolean;
      FbEnableAppointmentRepPrintSMS     : Boolean;
      FsAppointmentRepPrintSMSText       : String;
      FsPOPrintEmailSubject              : String;
      FbEnablePOPrintEmail               : Boolean;
      FsPOPrintEmailText                 : String;
      FbEnablePOPrintSMS                 : Boolean;
      FsPOPrintSMSText                   : String;
      FsRAPrintSMSText                   : String;
      FsRAPrintEmailSubject              : String;
      FbEnableRAPrintEmail               : Boolean;
      FsRAPrintEmailText                 : String;
      FbEnableRAPrintSMS                 : Boolean;
      FsBillPrintEmailText               : String;
      FbEnableBillPrintSMS               : Boolean;
      FsBillPrintSMSText                 : String;
      FsBillPrintEmailSubject            : String;
      FbEnableBillPrintEmail             : Boolean;
      FbEnableCreditPrintEmail           : Boolean;
      FsCreditPrintEmailText             : String;
      FbEnableCreditPrintSMS             : Boolean;
      FsCreditPrintSMSText               : String;
      FsCreditPrintEmailSubject          : String;
      FsCashSalePrintSMSText             : String;
      FsCashSalePrintEmailSubject        : String;
      FbEnableCashSalePrintEmail         : Boolean;
      FsCashSalePrintEmailText           : String;
      FbEnableCashSalePrintSMS           : Boolean;
      FbEnablePOSCashSalePrintEmail      : Boolean;
      FsPOSCashSalePrintEmailText        : String;
      FbEnablePOSCashSalePrintSMS        : Boolean;
      FsPOSCashSalePrintSMSText          : String;
      FsPOSCashSalePrintEmailSubject     : String;
      FsVoucherSalePrintSMSText          : String;
      FsVoucherSalePrintEmailSubject     : String;
      FbEnableVoucherSalePrintEmail      : Boolean;
      FsVoucherSalePrintEmailText        : String;
      FbEnableVoucherSalePrintSMS        : Boolean;
      FbInvoiceHasToBeApproved           : Boolean;
      FbEnableBoinBOMsalesOrder          : Boolean;
      FDepreciationCalcStart2            : String;
      FDepreciationCalcStart1            : String;
      FPQADEtailsCUSTFLD1                : String;
      FEnablePQADEtailsCUSTFLD1          : Boolean;
      FDisableAuditTrialinQuickPOS       : Boolean;
      FCompleteBOMOrderOnSave            : Boolean;
      FAutoScheduleBasedonBOMEmpRoster   : Boolean;
      FOnlyshowScheduledJobsForBarCodeMan: Boolean;
      // fUPSPassword: string;
      // fUPSAccessKey: string;
      // fUPSServer: string;
      // fUPSEnabled: boolean;
      // fUPSUserID: string;
      // fUPSAccountNumber: string;

      FUPSConfig: TUPSConfig;

      FAllowShipmentsFromSalesOrder                : Boolean;
      FbBOByDefaultOnInvoice                       : Boolean;
      fbBackupAfterUpdateCheck                     : Boolean;
      fShowEdiIntegration                          : Boolean;
      fPreventInvoiceOnStopCredit                  : Boolean;
      FbAccountPosingPopulated                     : Boolean;
      FbCompanyDefaultsSelected                    : Boolean;
      FbAutomaticSODeliveryDocketPrint             : Boolean;
      fPreventSalesOrderOnStopCredit               : Boolean;
      fbcheckforStockinOtherDept                   : Boolean;
      fInvoiceMailAttachmentBodyText               : string;
      fInvoiceMailAttachmentSubject                : string;
      fbPrintEOPProductGroupreport                 : Boolean;
      fCombinePOSQuntities                         : Boolean;
      fAutoAppendBatchNumber                       : Boolean;
      fAllProductGroupsforSalesCollatedByItemreport: Boolean;
      fUseBarcodeDispatch                          : Boolean;
      FFedExConfig                                 : TFedExConfig;
      FUSPSConfig                                  : TUSPSConfig;
      FbEnforceConNoteOnRA                         : Boolean;
      fPrintStatementsSMSText                      : string;
      fARSMSText                                   : string;
      // fStandardCostVarianceAccountID: integer;
      fIncludeContactNameInSalesBillingAddress: Boolean;
      fUseInventoryStandardCosting            : Boolean;
      fUseCustFld1ForSaleLineBatchAllocation  : Boolean;
      fExcludeZeroAllocationsFromPickingSlip  : Boolean;
      fAutoPopUpBarcodePickingOptions         : Boolean;
      fStandardCostPurchaseAdjustmentAccountID: Integer;
      fStandardCostCOGSAdjustmentAccountID    : Integer;
      fEnforceConNoteOnSale                   : Boolean;
      fUOMToBeUsedInManufactureDefault        : string;
      FdSurchargePercent1                     : Double;
      FdSurchargePercent2                     : Double;
      FdSurchargePercent3                     : Double;
      FdSurchargePercent4                     : Double;
      fDefaultSuperOnTimesheet                : Boolean;
      fUseSupportEmail                        : Boolean;
      FPOSBliandBalanceVarianceAccount        : string;
      fPOSPostBlindBalanceVariance            : Boolean;
      fEOPReportShowAlltimeSlots              : Boolean;
      fUseCashDrop                            : Boolean;
      fCashDropLotsOf                         : Integer;
      // fEnablePackWeight: boolean;
      fEnablePackWeightField1  : Boolean;
      fEnablePackWeightField2  : Boolean;
      FPackWeightField1        : string;
      FPackWeightField2        : string;
      FiPackWeightQtyField     : Integer;
      fDefaultHireIncomeAccount: string;
      fDefaultHireProductName  : string;

      fbFe1Visible: Boolean;
      fbFe2Visible: Boolean;
      fbFe3Visible: Boolean;
      fbFe4Visible: Boolean;
      fbFe5Visible: Boolean;

      fsFe1Name                                          : String;
      fsFe2Name                                          : String;
      fsFe3Name                                          : String;
      fsFe4Name                                          : String;
      fsFe5Name                                          : String;
      fsFeQtyField                                       : String;
      fsFeQtyFieldInfodisplayLabel                       : String;
      fsNewRepairNotesText                               : string;
      fAddNotesToNewRepair                               : Boolean;
      fProductReorderRoundNearest                        : Boolean;
      fProductReorderRoundValue                          : Integer;
      fCashDropLimit                                     : Integer;
      FEnablePQADEtailsCUSTFLD4                          : Boolean;
      FPQADEtailsCUSTFLD4                                : String;
      FsPOCreateEmailSubject                             : String;
      FbEnablePOCreateEmail                              : Boolean;
      FsPOCreateEmailText                                : String;
      FShowRelatedProductSelectioninSale                 : Boolean;
      FbHideCustTypeNotSelectedinSlsCatgbyItmRpt         : Boolean;
      FiDutiesAccount                                    : Integer;
      FiBrokerHandlingAccount                            : Integer;
      FbEnableRepairInvoicedEmail                        : Boolean;
      FsRepairInvoicedEmailText                          : String;
      FbEnableRepairInvoicedSMS                          : Boolean;
      FsRepairInvoicedSMSText                            : String;
      FsRepairInvoicedEmailSubject                       : String;
      fbPrintLabelsOnReceipt                             : Boolean;
      fbEmailCustomerOnReceipt                           : Boolean;
      fbEmailEmployeeOnReceipt                           : Boolean;
      FbUseFuturePO                                      : Boolean;
      FiFuturePODays                                     : Integer;
      FPOHasPeriodPosting                                : Boolean;
      fClientPrintNameHeading                            : String;
      fProductPrintNameHeading                           : String;
      fbPosConfirmTotalPayment                           : Boolean;
      fFreightChargeProduct                              : string;
      fStateFreightChargeEnabled                         : Boolean;
      fCopyProductPrintNameToName                        : Boolean;
      fCopyClientPrintNameToName                         : Boolean;
      fLoginExpireDays                                   : Integer;
      fSalesBackorderCheckType                           : string;
      fsPOCreateOptiononSalesToSOconvertion              : String;
      fBlankLinesinSuppPaymentCheque                     : Integer;
      fSalesDefaultAreaFromCustomer                      : Boolean;
      fPurchaseDefaultAreaFromSupplier                   : Boolean;
      fsCreditCheckTermsInv                              : String;
      fsCreditCheckTermsSO                               : String;
      fbChangeCreditCheckTermsInv                        : Boolean;
      fbChangeCreditCheckTermsSO                         : Boolean;
      fbAutoLocateproductinList                          : Boolean;
      fbAutoLocateLastRecord                             : Boolean;
      fDisablePurchaseLineZeroQuantityWarning            : Boolean;
      fDisableSaleLineZeroQuantityWarning                : Boolean;
      FsPOStoreAwayTemplate                              : String;
      FiAccountNamecolumnDropdownWidth                   : Integer;
      FiAccountTypecolumnDropdownWidth                   : Integer;
      FiAccountDescriptioncolumnDropdownWidth            : Integer;
      fSalesTaxThresholdWholeOrder                       : Boolean;
      fShowSaleLineInStockQty                            : Boolean;
      fMatchInvoiceDAteToShipDate                        : Boolean;
      fMatchInvoiceDateToETADate                         : Boolean;
      fCustEarlyPaymentAction                            : Integer;
      fOpenfileWhenDataExported                          : Boolean;
      fUseERPFilenameforDataExport                       : Boolean;
      FsDataExportDefaultExtension                       : String;
      FbUpdateProductDescriptionFromTreeInfo             : Boolean;
      FbUpdateSalesDescriptionFromTreeInfo               : Boolean;
      FbBOMPriceOverridesAllOtherPrice                   : Boolean;
      FbIgnoreBOMCalcPriceOnSale                         : Boolean;
      FbSubBOMUseAvailableQtyFromStock                   : Boolean;
      FbCSPOverridesRawMaterialPrices                    : Boolean;
      fbAllowChangingProductAllocationFlags              : Boolean;
      fSuppEarlyPaymentAction                            : Integer;
      FbUpdateLinenowhenManufacturingUpdateBatch         : Boolean;
      fUserSetMainSwitchHeight                           : Integer;
      fGenerateEmployeeno                                : Boolean;
      FiOrderLinesToDisableCalcs                         : Integer;
      FiSaleLinesToDisableCalcs                          : Integer;
      FiExpenseLinesToDisableCalcs                       : Integer;
      FiCustPayLinesToDisableCalcs                       : Integer;
      FiSuppPayLinesToDisableCalcs                       : Integer;
      fConfirmProductAutoPriceUpdate                     : Boolean;
      fCostUpdateFromPurchase                            : Boolean;
      fLoginExpireDate                                   : TDateTime;
      fPasswordConfig                                    : TPasswordConfig;
      FbShowMultiSelectSelectionList                     : Boolean;
      fUseBankStatements                                 : Boolean;
      fSortRelatedProductsinSale                         : Boolean;
      fCostEditableinSales                               : Boolean;
      fDosyncSerialnumberlist                            : Boolean;
      fErpApiEnabled                                     : Boolean;
      fErpApiPort                                        : Integer;
      fShowToDoNotifications                             : Boolean;
      fDefaultNotifyNewSmartOrder                        : Boolean;
      fDefaultNotifyEditingSmartOrder                    : Boolean;
      fDefaultShowPOfromSmartOrder                       : Boolean;
      fDefaultSupplierallLinesSmartOrder                 : Boolean;
      fConvertSOIntoPOOnApproval                         : Boolean;
      fDefaultNotifyPurchaseOrderChange                  : Boolean;
      FbConfirmQtysOnfinalise                            : Boolean;
      FbEnableWalmart                                    : Boolean;
      FbUpdatebatchRunVS1_sum                            : Boolean;
      FbUpdatebatchRunVS1_PnLReport                      : Boolean;
      FbUpdatebatchRunVS1_PnLReport_Sum                  : Boolean;
      FbUpdatebatchRunVS1_APReport                       : Boolean;
      FbUpdatebatchRunVS1_SalesList                      : Boolean;
      FbUpdatebatchRunVS1_PQASumList                     : Boolean;
      FbUpdatebatchRunVS1_Sum2                           : Boolean;
      //FbEnableEbay                                       : Boolean;
      FbWALMART_AutocheckforOrdersinList                 : Boolean;
      FbWALMART_AutoUpdateProductQty                     : Boolean;
      FbWALMART_IgnoreTaxonSale                          : Boolean;
      fWalmartcustomer                                   : string;
      fWALMART_ConsumerId                                : string;
      fWALMART_PrivateKey                                : string;
      fWALMART_ChannelType                               : string;
      fWALMART_ProductNameField                          : string;
      FbWALMARTOrderSilentProcessShipment                : Boolean;
      FbShowWalmartonMainmenubyDefault                   : Boolean;
      FbShowEbayonMainMenubyDefault                      : Boolean;
      FbWalmart_EnableInvFeed                            : Boolean;
      fSPSConfig: TSPSConfig;
      fAmazonConfig: TAmazonConfig;
      fHMRC_APIConfig: THMRC_APIConfig;
      fTrialBalanceAdjustAccount: Integer;
      FbEnableWooCommerce                                : Boolean;
//      FbHasWooCommerceCredentials                        : Boolean;
      FbShowWooCommerceonMainmenubyDefault               : Boolean;
//      fWooCommerce_consumerKey                           : string;
//      fWooCommerce_consumerSecretKey                     : string;
//      fWooCommerce_URL                                   : string;
      fBuildDetailsUpdateOption                          : string;
      fbHasExcelPrices                                   : Boolean;
      fCrosscompanySalesForPOType                        : string;
//      fWoocommerce_ProductNameField                      : string;
//      FbWooCommerce_AutocheckforOrdersinList             : Boolean;
      FbGrossWeightnQtyRelated                           : Boolean;
      FbMakeMcforClients                                 : Boolean;
      FbDoUpdateProductQtySum                            : Boolean;
      FbHasMagentoCredentials                            : Boolean;
      FbHasWalmartCredentials                            : Boolean;
      FbHasAvaTaxCredentials                             : Boolean;
      fCoreEDIUSerName                                   : string;
      fCoreEDIPassword                                   : string;
      fCoreEDIServiceUSerName                            : string;
      fCoreEDIServicePassword                            : string;
      fCoreEDIServiceHost                                : string;
      fCoreEDIServicePort                                : Integer;
      fIntuitConfig : TIntuitConfig;
      fMagentoConfig: TMagentoConfig;
      fWalmartConfig: TWalmartConfig;
      fAvaTaxConfig : TAvaTaxConfig;
      fEDIConfig    : TEDIConfig;
      fStSConfig    : TStSConfig;
      fVS1Config    : TVS1Config;

      FbShowSaturdayinApptCalendar  : Boolean;
      FbShowSundayinApptCalendar    : Boolean;
      FbShowMondayinApptCalendar    : Boolean;
      FbShowTuesdayinApptCalendar   : Boolean;
      FbShowWednesdayinApptCalendar : Boolean;
      FbShowThursdayinApptCalendar  : Boolean;
      FbShowFridayinApptCalendar    : Boolean;
      FsApptStartTime               : String;
      FsApptEndtime                 : String;
      FiDefaultApptDuration         : Integer;
      FiRoundApptDurationTo         : Integer;
      FiShowApptDurationin          : Integer;
      FiDefaultServiceProductID     : Integer;
      FsNonERPClone_User            : String;
      FsNonERPClone_Password        : String;
      fOneSidedJournal              : Boolean;

    Procedure SetCompanyRegion(Const Value: String);
    Procedure setApprovalType(Const Value: String);
    Procedure SetLoyaltyReminderRepeatDays(Const Value: Integer);
    Procedure SetMultiTills(Value: Boolean);
    Procedure SetCreditTermsID(Value: Integer);
    Procedure SetDebitTermsID(Value: Integer);
    Procedure SetSummarisedTransDate(Value: TDateTime);
    Procedure SetAccountPosingPopulated(value:Boolean);
    Procedure SetCompanyDefaultsSelected(value:Boolean);
    Function GetUseCostCentres: Boolean;
    Procedure StoreFieldValue(Const Name: String; Const Value: Variant);
    Procedure SetMonthsStockRetained(Const Value: Integer);
    Procedure SetLoyaltyReminderDate(Const Value: TDateTime);
    Function GetBarTabsConvertStarted: Boolean;
    Procedure SetBarTabsConvertStarted(Const Value: Boolean);
    Function GetBatchUpdateInProgress: Boolean;
    Function GetEnableWebAPILoging: Boolean;
    Procedure SetBatchUpdateInProgress(Const Value: Boolean);
    Function GetTransactionTableLastUpdated: TDateTime;
    Procedure SetTransactionTableLastUpdated(Const Value: TDateTime);
    Function GetReportTablesLastUpdatedOn: TDateTime;
    Function GetSerialNumberListUpdatedOn: TDateTime;
    Procedure SetReportTablesLastUpdatedOn(Const Value: TDateTime);
    Procedure SetSerialNumberListUpdatedOn(Const Value: TDateTime);
    Function GetSalesCommissionCalcInProgress: Boolean;
    Function GetSalesCommissionCalcEmployeeID: Integer;
    Procedure SetSalesCommissionCalcInProgress(Const Value: Boolean);
    Procedure SetSalesCommissionCalcEmployeeID(Const Value: Integer);
    Procedure Setclosingdate(Const Value: TDateTime);
    Procedure SetClosingDateAP(Const Value: TDateTime);
    Procedure SetClosingDateAR(Const Value: TDateTime);
    Procedure SetShowDashboard(Const Value: Boolean);
    Procedure SetEndOfDay(Const Value: TDateTime);
    Procedure SetStartOfDay(Const Value: TDateTime);
    Function GetShowLatestCost: Boolean;
    Function ReadskypePath: String;
    Function GetFirstTransDAte: TDateTime;
    Procedure SetClosingDateChangeDone(Const Value: Boolean);
    Function GetPartCalcfield1Visible: Boolean;
    Function GetPartCalcfield2Visible: Boolean;
    Function GetPartCalcfield3Visible: Boolean;
    Function GetPartCalcfield4Visible: Boolean;
    Function GetPartCalcfield5Visible: Boolean;
    Function GetPartCalcfieldVisible: Boolean;
    Function GetFeFieldVisible: Boolean;
    Function Colourof(Const Colour, GradIntensity: Integer): TColor;
    Function GetPurchaseETAFromProductNormalDeliveryTime: Boolean;
    Function GetPurchaseETAFromSupplierShippingtime: Boolean;
    Function GetTeamViewerPath: String;
    Function GetERPSupportPath: String;
    Function GetDaysinWeek: Integer;
    Function GetHoursinaDay: Double;
    Procedure SetCyTrackIntegrationEnabled(Const Value: Boolean);
    Function GetSMSEnabled: Boolean;
    Procedure SetEnableAutoSplitQtyintoUOMinSales(Const Value: Boolean);
    function getSpecialbarcodeformat: String;
    function getWholeSaleCustomerTypes: String;
    function getGenerateNextNoforAllocationBatchTruckLoadNo: Boolean;
    function GetBlankAllocationBatchTruckLoadNo: Boolean;
    function GetKeepSameNoforAllocationBatchTruckLoadNo: Boolean;
    procedure SetAutoPopUpBarcodePickingOptions(const Value: boolean);
    function getSurchargePercentDEfined: Boolean;
    function getSecondsInaday: Integer;
    function getSalesLineLatestCostBasedOnMsg: String;
    function getSecsInaWorkingDay: Integer;
    function getCostDecimalPlacesinTree: Integer;
    Procedure PopulateFenames;
    procedure SetIgnoreTraining(const Value: Boolean);
    procedure setManufacturePartSourceStock(const Value: Boolean);
    procedure setEnforceBinVolume(const Value: Boolean);
    procedure setEnforceAllocationValidation(const Value: Boolean);
    procedure setYodleeEnabled(const Value: Boolean);
    procedure setMagentoEnabled(const value: Boolean);
    procedure setMagentoShowOnMainMenu(const Value: Boolean);
    function GetCreatePOOnSalesToSmartOrderconvertion :Boolean ;
    function GetConfirmPOCreationOnSalesToSmartOrderconvertion :Boolean ;
    function GetDonotCreatePOOnSalesToSmartOrderconvertion :Boolean ;
    Procedure DoPopulateMe;
    procedure SetDisablePurchaseLineZeroQuantityWarning(const Value: boolean);
    procedure SetDisableSaleLineZeroQuantityWarning(const Value: boolean);
    procedure SetUserSetMainSwitchHeight(const Value: Integer);
    procedure SetFeQtyFieldInfodisplayLabel(const Value: String);
    procedure SetShowMultiSelectSelectionList(const Value: Boolean);
    procedure setConfirmQtysOnfinalise(const Value: Boolean);
    function getWALMART_ProductNameFieldNAme: String;
    procedure setShowEbayonMainMenubyDefault(const Value: Boolean);
    procedure setShowWalmartonMainmenubyDefault(const Value: Boolean);
    Function HasEbayforThisDB:Boolean;
    Function GetStatusUpdatedUntil:TDatetime;
    procedure setWooCommerceEnabled(const Value: Boolean);
    procedure setShowWooCommerceonMainmenubyDefault(const Value: Boolean);
    procedure setTrialBalanceAdjustAccount(const Value: integer);
    function getBOMDetailsAppendsProductDescriptionMemo: Boolean;
    function getBOMDetailsReplacesProductDescriptionMemo: Boolean;
    function getIgnoreBOMDetailsUpdateonSales: Boolean;
    function getCrosscompanySalesForPOTypeDesc: String;
//    procedure SetWooCommerce_consumerKey(const Value: String);
//    procedure setWooCommerce_consumerSecretKey(const Value: String);
//    procedure setWooCommerce_URL(const Value: String);
//    function getWoocommerce_ProductNameFieldName: String;
    procedure setGrossWeightnQtyRelated(const Value: Boolean);
    procedure setDoUpdateProductQtySum(const Value: Boolean);
    procedure setCoreEDIUSerName(const Value: String);
    procedure setCoreEDIPassword(const Value: String);
    procedure setCoreEDIServicePassword(const Value: String);
    procedure setCoreEDIServiceHost(const Value: String);
    procedure setCoreEDIServicePort(const Value: Integer);
    function GetWalmartclientID                : String;
    function GetWalmartclientSecret            : String;
    function GetWalmartsynchAccount            : String;
    function GetWalmartsynchAccountDescription : String;
    Function getWalmart_OrdersSynchedUntil     : TDatetime;
    function GetWalmartToken_URL               : String;
    Function GetWalmart_Order_Released_URL     : String;
    Function GetWalmart_Order_Released_Cont_URL: String;
    Function GetWalmart_Order_All_URL          : String;
    Function GetWalmart_Order_All_cont_URL     : String;
    Function GetWalmart_Order_Single_URL       : String;
    Function GetWalmart_Order_Ack_URL          : String;
    Function GetWalmart_Order_Cancel_URL       : String;
    Function GetWalmart_Order_Refund_URL       : String;
    Function GetWalmart_Order_Shipping_URL     : String;
    Function GetWalmart_FeedStatus_URL         : String;
    function getUseSinglePersonApproval: Boolean;
    function getUseSteppedApproval: Boolean;

    Function getEnableMagento                :boolean;
    Function GetMagento_ShowMagentoOnMainMenu: Boolean   ;
    Function GetMagento_AutosynchList        : Boolean   ;
    Function GetMagento_API_Base_URL         : String    ;
    Function GetMagento_Consumer_Key         : String    ;
    Function GetMagento_Consumer_Secret      : String    ;
    Function GetMagento_Access_Token         : String    ;
    Function GetMagento_Access_Token_Secret  : String    ;
    Function GetMagento_AdminUserName        : String    ;
    Function GetMagento_AdminPassword        : String    ;
    Function GetMagento_SalesType            : String    ;
    Function GetMagento_CustomerID           : String    ;
    function getIsMagentoSalestypeSO         : Boolean   ;
    function getIsMagentoSalestypeInv        : Boolean   ;
    function getISMagentoCustomerIDName      : Boolean   ;
    function getISMagentoCustomerIDEmail     : Boolean   ;
    Function GetMagento_SynchPageSize        : Integer   ;
    Function GetMagento_Companyid            : String    ;

    Function getEnableAvaTax                : boolean;
    Function getAvaTaxCredentialsValidated  : boolean;
    Function GetAvaTax_ShowAvaTaxOnMainMenu : Boolean   ;
    Function GetAvaTax_AutosynchList        : Boolean   ;
    Function GetAvaTax_Username             : String    ;
    Function GetAvaTax_Password             : String    ;
    Function GetAvaTax_BaseURL              : String    ;
    Function GetAvaTax_CompanyID            : String    ;
    Function GetAvaTax_AvaTaxSaleCode       : String    ;
    Function GetAvaTax_CompanyCode          : String    ;
    Function GetAvaTax_AccountType          : String    ;
    function getIsAvaTaxSandBox             : Boolean   ;
    function getIsAvaTaxProduction          : Boolean   ;

    Function getUseSeedtoSale                : boolean   ;
    Function getStSUsesBins           : boolean   ;
    Function getStSSimpleMode         : boolean   ;
    Function GetStSPackageTagProduct         : String    ;
    Function GetStSPlantTagProduct           : String    ;
    Function GetStSSupplier                  : String    ;
    Function GetStSStockAccount              : String    ;
    function getEnableSeedtoSale: boolean;
    function getFiscalYearStartsno: Integer;
    procedure setDefaultPurchaseTaxCode(const Value: STring);
    procedure setDefaultSalesTaxCode(const Value: String);
    procedure setPickupShipingMethod(const Value: String);
    procedure setCommittedStatus(const Value: String);
    function getSeedToSaleStarted: Boolean;
    Function getVS1useRegioncurrency         : boolean   ;
    Function GetVS1DefaultCurrency           : String    ;
    Function getEnableJobKeepersAllowance(Paydate:Tdatetime=0)         : boolean   ;
    function getDefaultServiceProduct: String;
    function GetFiscalYearStartingDate: TDateTime;

  Protected
    Function FieldByName(Const FieldName: String): TPrefConvert;
    Function LoadFieldValue(Const Name: String): Variant;
  Public
    Constructor Create;
    Destructor Destroy; Override;
    Procedure PopulateMe;
    Procedure LoadHoursFromRoster(Const LoadHours: Boolean);
    Function ValidateData: Boolean;
    Procedure CheckForHasExcelPrices ;
    Procedure DisableApprovalLevels;
    Procedure EnableApprovalLevels;


    Property DefaultRepUser: Boolean Read FbDefaultRepUser;
    Property DisableCusSourceTracking: Boolean Read FbDisableCusSourceTracking;
    Property SingleQtySO: Boolean Read FbSingleQtySO;
    Property SoToInvShipWhenAvailable: Boolean Read FbSoToInvShipWhenAvailable;
    Property UniqueCustomerPONumInSale: Boolean Read FbUniqueCustomerPONumInSale;
    Property CopySalesOrderShiptotoRepairs: String Read FsCopySalesOrderShiptotoRepairs;
    Property ExcludeBOFromPrintinPO: Boolean Read FbExcludeBOFromPrintinPO;
    Property ExcludeBOFromPrintinSales: Boolean Read FbExcludeBOFromPrintinSales;
    Property WholesalePercentag: Double Read FdWholesalePercentag;
    Property Invoice_footer: String Read FsInvoice_footer;
    Property WholeSaleToggleON: Boolean Read FbWholeSaleToggleON;
    Property PrintBestPractices: Boolean Read FbPrintBestPractices;
    Property ShowInvoiceFormwhenRepairInvoiced: Boolean Read FbShowInvoiceFormwhenRepairInvoiced;
    Property AutoBackup: Boolean Read FbAutoBackup;
    property BackupAfterUpdateCheck: boolean read fbBackupAfterUpdateCheck;
    // -----------------------------------
    // Used with the Manifest and billing.
    // -----------------------------------
    Property DefaultSPAAccount: Integer Read FiDefaultSPAAccount;
    // -----------------------------------
    Property DefaultCustPaymentAccount: Integer Read FiDefaultCustPaymentAccount;
    Property DefaultSuppPaymentAccount: Integer Read FiDefaultSuppPaymentAccount;
    Property DefaultCCardPaymentAccount: Integer Read FiDefaultCCardPaymentAccount;
    Property ClosingDate: TDateTime Read FdtClosingDate Write Setclosingdate;
    Property FiscalYearStartingDate: TDateTime Read GetFiscalYearStartingDate;
    Property ClosingDateAR: TDateTime Read FdtClosingDateAR Write SetClosingDateAR;
    Property ClosingDateAP: TDateTime Read FdtClosingDateAP Write SetClosingDateAP;
    Property ReceiptPrinterON: Boolean Read FbReceiptPrinterON;
    Property ReceiptPrinterPort: String Read FsReceiptPrinterPort;
    Property MultiSalesPerson: Boolean Read FbMultiSalesPerson;
    Property MustProvidePOSPostCode: Boolean REad FbMustProvidePOSPostCode;
    Property MustProvideDetailsforCashout: Boolean Read FbMustProvideDetailsforCashout;
    Property MustProvidePOSSource: Boolean Read FbMustProvidePOSSource;

    /// Property RoundLots  :boolean read fbRoundLots;
    /// Property Roundup5Cents :boolean read fbRoundup5Cents;
    Property RoundUp: Integer Read FiRoundUp;
    Property RoundLotsnRoundup: Boolean Read FbRoundLotsnRoundup;
    Property RoundLotsof: Double Read FdRoundLotsof;

    Property ProductPriceRoundUp: Integer Read FiProductPriceRoundUp;
    Property ProductPriceRoundLotsnRoundup: Boolean Read FbProductPriceRoundLotsnRoundup;
    Property ProductPriceRoundLotsof: Integer Read FiProductPriceRoundLotsof;
    Property RoundUpPoints: Integer Read FiRoundUpPoints;
    Property LaybyTerms: String Read FsLaybyTerms;
    Property ReceiptFooter: String Read FsReceiptFooter;
    Property POSRewardPointTemplate: String Read FsPOSRewardPointTemplate;
    Property ReceiptPrinterType: String Read FsReceiptPrinterType;
    Property USBPrinterName: String Read FsUSBPrinterName;
    Property PrintPOSTemplateReport: Boolean Read FbPrintPOSTemplateReport;
    Property MaxDiscountPercentage: Double Read FdMaxDiscountPercentage;
    Property MinMarkupPercentage: Double Read FdMinMarkupPercentage;
    Property MinimumMarginPercentage: Double Read FdMinimumMarginPercentage;
    Property MultiTills: Boolean Read FbMultiTills Write SetMultiTills;
    Property CreditTermsID: Integer Read FiCreditTermsID write setCreditTermsID;
    Property DebitTermsId: Integer Read FiDebitTermsId write setDebitTermsId;
    Property CreditLimit: Currency Read FrCreditLimit;
    Property MaxSmartAmount: Currency Read FrMaxSmartAmount;
    Property TotalvolumeUOMInsmartOrder :Integer read fiTotalvolumeUOMInsmartOrder;
    Property UOMforTotalvolumeInsmartOrder :String read fsUOMforTotalvolumeInsmartOrder;
    Property GracePeriod: Integer Read FiGracePeriod;
    Property DefaultSalesAccount: Integer Read FiDefaultSalesAccount;
    Property DefaultPurchasesAccount: Integer Read FiDefaultPurchasesAccount;
    Property FollowupDays: Integer Read FiFollowupDays;
    Property FastProductList: Boolean Read FbFastProductList;
    Property DisableNotifyLists: Boolean Read FbDisableNotifyLists Write FbDisableNotifyLists;
    Property MinAboveCost: Double Read FdMinAboveCost;
    Property DefaultDepositsAccount: Integer Read FiDefaultDepositsAccount;
    Property DefPartsCOGSAccount: Integer Read FiDefPartsCOGSAccount;
    Property DefPartsAssetAccount: Integer Read FiDefPartsAssetAccount;
    Property DefPartsIncomeAccount: Integer Read FiDefPartsIncomeAccount;
    Property DefaultPurchaseTaxCode: STring Read FsDefaultPurchaseTaxCode write setDefaultPurchaseTaxCode;
    // Property QtyRoundTo :Integer read fiQtyRoundTo;
    Property DefaultSalesTaxCode: String Read FsDefaultSalesTaxCode write setDefaultSalesTaxCode;
    Property PickupShipingMethod: String Read FsPickupShipingMethod write setPickupShipingMethod;
    Property CommittedStatus: String Read FsCommittedStatus write setCommittedStatus;
    Property PrintBarcodesOnReceival: Boolean Read FbPrintBarcodesOnReceival;
    property PrintLabelsOnReceipt : boolean read fbPrintLabelsOnReceipt;
    property EmailCustomerOnReceipt: boolean read fbEmailCustomerOnReceipt;
    property EmailEmployeeOnReceipt: boolean read fbEmailEmployeeOnReceipt;
    Property DefaultChequeAccount: Integer Read FiDefaultChequeAccount;
    Property ValidateAllocation: Boolean Read FbValidateAllocation;
    Property EnforceAllocationValidation: Boolean Read FbEnforceAllocationValidation write setEnforceAllocationValidation;
    Property EnforceAllocationValidationinPI: Boolean Read FbEnforceAllocationValidationinPI;
    Property ResetSaleDateWhenBuilt: Boolean Read FbResetSaleDateWhenBuilt;
    //Property DefaultCoupenTimeinWOTimesheet: Boolean Read FbDefaultCoupenTimeinWOTimesheet;
    Property PrintStoreAwayOnReceival: Boolean Read FbPrintStoreAwayOnReceival;
    Property UsePayroll: Boolean Read FbUsePayroll Write FbUsePayroll;
    Property UseGoogleAnalytics: Boolean Read FbUseGoogleAnalytics Write FbUseGoogleAnalytics;
    Property SupplierforautoPostingGoogle: String Read FsSupplierforautoPostingGoogle;
    Property POSPassword: Boolean Read FbPOSPassword;
    Property NoPreferredSuppQuestion: Boolean Read FbNoPreferredSuppQuestion;
    Property NoCustSpecialPriceQuestion: Boolean Read FbNoCustSpecialPriceQuestion;
    Property NoCashCustSpecialPriceQuestion: Boolean Read FbNoCashCustSpecialPriceQuestion;
    Property AutoPickBins: Boolean Read FbAutoPickBins;
    Property AutoPickBatches: Boolean Read FbAutoPickBatches;
    Property ShowSalesUnits: Boolean Read FbShowSalesUnits;
    Property ShowSalesCostInc: Boolean Read FbShowSalesCostInc;
    Property ShowPurchasecostinSales: Boolean Read FbShowPurchasecostinSales;
    Property ShowSalesDescription: Boolean Read FbShowSalesDescription;
    Property ShowSalesProfit: Boolean Read FbShowSalesProfit;
    Property ShowSalesProfitPercent: Boolean Read FbShowSalesProfitPercent;
    Property ShowSalesTaxCode: Boolean Read FbShowSalesTaxCode;
    Property ShowSalesTaxAmount: Boolean Read FbShowSalesTaxAmount;
    Property ShowSalesDiscount: Boolean Read FbShowSalesDiscount;
    Property ShowPurchUnits: Boolean Read FbShowPurchUnits;
    Property ShowPurchCostInc: Boolean Read FbShowPurchCostInc;
    Property ShowPurchDescription: Boolean Read FbShowPurchDescription;
    Property ShowPurchCustJob: Boolean Read FbShowPurchCustJob;
    Property ShowPurchClass: Boolean Read FbShowPurchClass;
    Property ShowPurchTaxCode: Boolean Read FbShowPurchTaxCode;
    Property UseFuturePO: Boolean Read FbUseFuturePO;
    Property FuturePODays: Integer Read FiFuturePODays;
    // property ShowTaxwithNostate: Boolean read fbShowTaxwithNostate;
    Property FilterTaxcodeforClient: Boolean Read FbfilterTaxcodeforClient;
    Property ShowAllocationBatchExpiryDate: Boolean Read FbShowAllocationBatchExpiryDate;
    Property ShowAllocationBatchTruckLoadNo: Boolean Read FbShowAllocationBatchTruckLoadNo;
    //Property AllocationBatchTruckLoadNoGenerateMode :String read fsAllocationBatchTruckLoadNoGenerateMode;
    Property GenerateNextNoforAllocationBatchTruckLoadNo :Boolean read getGenerateNextNoforAllocationBatchTruckLoadNo;
    Property KeepSameNoforAllocationBatchTruckLoadNo :Boolean read GetKeepSameNoforAllocationBatchTruckLoadNo;
    Property BlankAllocationBatchTruckLoadNo :Boolean read GetBlankAllocationBatchTruckLoadNo;
    Property AllowToPickFromOthersalesIntheGroup: Boolean Read FbAllowToPickFromOtherslaesIntheGroup;
    Property AllowtoshipnPickFromBackorderinthegroup: Boolean Read FbAllowtoshipnPickFromBackorderinthegroup;
    Property ShowPurchTaxAmount: Boolean Read FbShowPurchTaxAmount;
    Property CreditCheckInv: Boolean Read FbCreditCheckInv;
    Property CreditCheckSO: Boolean Read FbCreditCheckSO;
    Property CreditCheckPO: Boolean Read FbCreditCheckPO;
    Property CreditcheckPOIncludeBO: Boolean Read FbCreditcheckPOIncludeBO;
    Property ShowProductAttributes: Boolean Read FbShowProductAttributes;
    Property ShowProductOptions: Boolean Read FbShowProductOptions;
    Property YodleeEnabled: Boolean Read FbYodleeEnabled write SetYodleeEnabled;
    Property MagentoEnabled: Boolean Read FbMagentoEnabled write SetMagentoEnabled;
    Property ShowMagentoOnMainMenu: Boolean read FbShowMagentoOnMainMenu write setMagentoShowOnMainMenu;
    Property AutoSyncMagento : Boolean read FbAutoSyncMagento write FbAutoSyncMagento;
    Property SmartOrderbasedOn: Integer Read FiSmartOrderbasedOn;
//    Property TransLinesToDisableCalcs: Integer Read FiTransLinesToDisableCalcs Write FiTransLinesToDisableCalcs;
    Property SaleLinesToDisableCalcs: Integer Read FiSaleLinesToDisableCalcs Write FiSaleLinesToDisableCalcs;
    Property ExpenseLinesToDisableCalcs: Integer Read FiExpenseLinesToDisableCalcs Write FiExpenseLinesToDisableCalcs;
    Property CustPayLinesToDisableCalcs: Integer Read FiCustPayLinesToDisableCalcs Write FiCustPayLinesToDisableCalcs;
    Property SuppPayLinesToDisableCalcs: Integer Read FiSuppPayLinesToDisableCalcs Write FiSuppPayLinesToDisableCalcs;
    Property OrderLinesToDisableCalcs: Integer Read FiOrderLinesToDisableCalcs Write FiOrderLinesToDisableCalcs;
    Property ShowMeasurementAttributes: Boolean Read FbShowMeasurementAttributes;
    Property ShowProductExtraAttributes: Boolean Read FbShowProductExtraAttributes;
    Property NoOfAttribstodisplay: Integer Read FiNoOfAttribstodisplay;
    Property ProductAttrib1Name: String Read FsProductAttrib1Name;
    Property AreaColumnName: String Read FsAreaColumnName;
    Property ProductAttrib2Name: String Read FsProductAttrib2Name;
    Property ProductAttrib3Name: String Read FsProductAttrib3Name;
    Property SalesDefaultValueForAreaFrom: String Read FsSalesDefaultValueForAreaFrom;
    Property PODefaultValueForAreaFrom: String Read FsPODefaultValueForAreaFrom;
    Property PrimaryPrinter: String Read FsPrimaryPrinter;
    Property HoursPerWeek: Double Read FdHoursPerWeek;
    Property ALeaveWeeks: Double Read FdALeaveWeeks;
    Property SickLeaveDays: Double Read FdSickLeaveDays;
    Property LSLWeeks: Double Read FdLSLWeeks;
    Property LSLCommenceYears: Double Read FdLSLCommenceYears;
    Property POSRestrictRefund: Boolean Read FbPOSRestrictRefund;
    Property RestrictRefund: Boolean Read FbRestrictRefund;
    Property POSHideLaybyRcptAmnt: Boolean Read FbPOSHideLaybyRcptAmnt;
    Property POSHideSalesRcptAmnt: Boolean Read FbPOSHideSalesRcptAmnt;
    Property RewardPointssoldAccount: Integer Read FiRewardPointssoldAccount;
    Property RewardPointsExpiredAccount: Integer Read FiRewardPointsExpiredAccount;
    Property ExpenseAccountforRewardPoints: Integer Read FiExpenseAccountforRewardPoints;
    Property ExpiresOnNoOfMonthsAfterPurchase: Integer Read FiExpiresOnNoOfMonthsAfterPurchase;
    Property POSCreateOrders: Boolean Read FbPOSCreateOrders Write FbPOSCreateOrders;
    Property CombinedInvoiceBO: Boolean Read FbCombinedInvoiceBO;
    Property CombinedSaleOrderBO: Boolean Read FbCombinedSaleOrderBO;
    Property UseAutoChequeNo: Boolean Read FbUseAutoChequeNo;
    Property UseGroupedPOSDeposits: Boolean Read FbUseGroupedPOSDeposits;
    Property SpecialProductOverridesDiscounts: Boolean Read FbSpecProd_Override_Disc;
    Property UseForeignCurrencyonPO: Boolean Read FbUseForeignCurrencyonPO;
    Property EnforceConNoteOnPO: Boolean Read FbEnforceConNoteOnPO;
    Property EnforceConNoteOnRA: Boolean Read FbEnforceConNoteOnRA;
    Property IncludeLandedCostsinAvgCost: Boolean Read FbIncludeLandedCostsinAvgCost;
    Property UseFixedAssets: Boolean Read FbUseFixedAssets;
    Property UseShippedDateForTerms: Boolean Read FbUseShippedDateForTerms;
    Property AllowchangeofTermAfterDueDate: Boolean Read FbAllowchangeofTermAfterDueDate;
    Property ShippedDaysAfterCreate: Integer Read FiShippedDaysAfterCreate;
    Property ChequeTemplate_NoofLinesinDetailSection: Integer Read FichequeTemplate_NoofLinesinDetailSection;
    Property PrintPickSlipWithInvoice: Boolean Read FbPrintPickSlipWithInvoice;
    Property PrintDelDocketWithInvoice: Boolean Read FbPrintDelDocketWithInvoice;
    Property UseManifest: Boolean Read FbUseManifest;
    Property ManifestDaysAfterDespatchDate: Integer Read FiManifestDaysAfterDespatchDate;
    Property AutoEditInvoiceBarcodePick: Boolean Read FbAutoEditInvoiceBarcodePick;
    Property PrintInvoiceBarcodePick: Boolean Read FbPrintInvoiceBarcodePick;
    Property PrintDelDocketBarcodePick: Boolean Read FbPrintDelDocketBarcodePick;
    Property PrintConNotesBarcodePick: Boolean Read FbPrintConNotesBarcodePick;
    Property AutoAddBarcodes: Boolean Read FbAutoAddBarcodes;
    Property PhoneNumberFormatting: Boolean Read FbPhoneNumberFormatting;
    Property CustomerABNFormating: Boolean Read FbCustomerABNFormating;
    Property ConvertConvertedSmartOrder: Boolean Read FbConvertConvertedSmartOrder write FbConvertConvertedSmartOrder;
    Property ConvertConvertedSalesOrder: Boolean Read FbConvertConvertedSalesOrder;
    Property POMatchLineETAToHeaderETA: Boolean Read FbPOMatchLineETAToHeaderETA;
    Property POMatchLineETAToShippingContainerETA: Boolean Read FbPOMatchLineETAToShippingContainerETA;
    Property WarnWhenSalesCreationdateisfuture: Boolean Read FbWarnWhenSalesCreationdateisfuture;
    Property LogchangingDetailsonServicePadFeedback : Boolean Read FbLogchangingDetailsonServicePadFeedback	;
    Property LogchangingDetailsonRepairsFeedback : Boolean Read FbLogchangingDetailsonRepairsFeedback	;
    Property LogchangingDetailsonRepairsNotes : Boolean Read FbLogchangingDetailsonRepairsNotes	;
    Property LogchangingDetailsonSupportPricingNotes : Boolean Read FbLogchangingDetailsonSupportPricingNotes	;
    Property LogchangingDetailsonSupplierfollowupNotes : Boolean Read FbLogchangingDetailsonSupplierfollowupNotes	;
    Property LogchangingDetailsonchequecomments : Boolean Read FbLogchangingDetailsonchequecomments	;
    Property LogchangingDetailsonchequeInternalcomments : Boolean Read FbLogchangingDetailsonchequeInternalcomments	;
    Property LogchangingDetailsonCustPayComments : Boolean Read FbLogchangingDetailsonCustPayComments	;
    Property LogchangingDetailsonDepositEntryNotes : Boolean Read FbLogchangingDetailsonDepositEntryNotes	;
    Property LogchangingDetailsonDepositNotes : Boolean Read FbLogchangingDetailsonDepositNotes	;
    Property LogchangingDetailsonSuppPayNotes : Boolean Read FbLogchangingDetailsonSuppPayNotes	;
    Property LogchangingDetailsonTimesheetInvoiceNotes : Boolean Read FbLogchangingDetailsonTimesheetInvoiceNotes	;
    Property LogchangingDetailsonRepairNotes : Boolean Read FbLogchangingDetailsonRepairNotes	;
    Property LogchangingDetailsonRepairFeedbackNotes : Boolean Read FbLogchangingDetailsonRepairFeedbackNotes	;
    Property LogchangingDetailsonCashsAleComments : Boolean Read FbLogchangingDetailsonCashsAleComments	;
    Property LogchangingDetailsonCustomerfollowupNotes : Boolean Read FbLogchangingDetailsonCustomerfollowupNotes	;
    Property WarnWhenPurchaseCreationDateisfuture: Boolean Read FbWarnWhenPurchaseCreationDateisfuture;
    Property ShowDeliveryDetailsformonDeldocketprint: Boolean Read FbShowDeliveryDetailsformonDeldocketprint;
    Property ShowManufacutresummarywhenchangedfromSales: Boolean Read FbShowManufacutresummarywhenchangedfromSales;
    Property PrintAddressLabelfromDelPrint: Boolean Read FbPrintAddressLabelfromDelPrint;
    Property CapacityplannerSelectionOptionBeforeLoad: Boolean Read FbCapacityplannerSelectionOptionBeforeLoad;
    Property UseEmployeeDeptAddressinPOShipto: Boolean Read FbUseEmployeeDeptAddressinPOShipto;
    Property OpenTreeFromSalesOrder: Boolean Read FbOpenTreeFromSalesOrder;
    // Property POMatchHeaderETAToShippingContainerETA :Boolean read fbPOMatchHeaderETAToShippingContainerETA;
    Property POMatchHeaderETAToLineETA: Boolean Read FbPOMatchHeaderETAToLineETA;
    Property PostcodeFormatting: Boolean Read FbPostcodeFormatting;
    Property ShowDashboard: Boolean Read FbShowDashboard Write SetShowDashboard;
    Property DashboardToshow: String Read FsDashboardToshow;
    Property DefaultPayMethodID: Integer Read FbDefaultPayMethodID;
    Property UseBatchTransactions: Boolean Read FbUseBatchTransactions Write FbUseBatchTransactions;
    Property ShowAccountNumbers: Boolean Read FbShowAccountNumbers;
    Property ShowSupplieronSO: Boolean Read FbShowSupplieronSO;
    Property ShowSupplierContactonSO: Boolean Read FbShowSupplierContactonSO;
    Property ODueOk: String Read FsODueOk;
    Property ODue1Days: String Read FsODue1Days;
    Property ODue7Days: String Read FsODue7Days;
    Property ODue14Days: String Read FsODue14Days;
    Property ODue21Days: String Read FsODue21Days;
    Property ODue30Days: String Read FsODue30Days;
    Property ODue60Days: String Read FsODue60Days;
    Property ODue90Days: String Read FsODue90Days;
    Property UseBarcodePicking: Boolean Read FbUseBarcodePicking;
    Property UseForeignCurrencyonSales: Boolean Read FbUseForeignCurrencyonSales;
    Property ProductNameDropdownWidth: Integer Read FiProductNameDropdownWidth;
    Property ProductfirstcolumnDropdownWidth: Integer Read FiProductfirstcolumnDropdownWidth;
    Property ProductsecondcolumnDropdownWidth: Integer Read FiProductsecondcolumnDropdownWidth;
    Property ProductthirdcolumnDropdownWidth: Integer Read FiProductthirdcolumnDropdownWidth;
    Property ProductSalesDescDropdownWidth: Integer Read FiProductSalesDescDropdownWidth;
    Property ProductPODescDropdownWidth: Integer Read FiProductPODescDropdownWidth;
    Property ProductPreferedSupDropdownWidth: Integer Read FiProductPreferedSupDropdownWidth;
    Property ProductSupplierProductCodeDropdownWidth: Integer Read FiProductSupplierProductCodeDropdownWidth;
    Property AutoAddProdCode: Boolean Read FbAutoAddProdCode;
    Property POSLaybyPickSlip: Boolean Read FbPOSLaybyPickSlip;
    Property UseTrafficMonitor: Boolean Read FbUseTrafficMonitor;
    Property POSNumKeyPad: Boolean Read FbPOSNumKeyPad;
    Property StartOfDay: TDateTime Read FdtStartOfDay Write SetStartOfDay;
    Property EndOfDay: TDateTime Read FdtEndOfDay Write SetEndOfDay;
    Property SecondsInaday:Integer read getSecondsInaday;
    Property SecsInaWorkingDay :Integer read getSecsInaWorkingDay;
    Property LeaveLoadTaxThreshold: double Read FdLeaveLoadTaxThreshold;
    Property UseExpressProductList: Boolean Read FbUseExpressProductList;
    Property POSSummarise: Boolean Read FbPOSSummarise;
    Property POenforceETA: Boolean Read FbPOenforceETA;
    Property PurchaseETACalculatedFrom: String Read FsPurchaseETACalculatedFrom;
    Property PurchaseETAFromProductNormalDeliveryTime: Boolean Read GetPurchaseETAFromProductNormalDeliveryTime;
    Property PurchaseETAFromSupplierShippingtime: Boolean Read GetPurchaseETAFromSupplierShippingtime;

    Property LoyaltyStartDate: TDateTime Read FdtLoyaltyStartDate ;
    Property LastContactDays: Integer Read FiLastContactDays ;
    Property LastSaleDays: Integer Read FiLastSaleDays ;
    Property SalesValue: Double Read FdSalesValue ;
    Property LoyaltyReminderDate: TDateTime Read FdtLoyaltyReminderDate Write SetLoyaltyReminderDate;
    Property LoyaltyReminderRepeatDays: Integer Read FiLoyaltyReminderRepeatDays Write SetLoyaltyReminderRepeatDays;
    Property LastAppointDays: Integer Read FiLastAppointDays ;

    Property OpenCashDrawerFromCashSale: Boolean Read FbOpenCashDrawerFromCashSale;
    Property UseClockOn: Boolean Read FbUseClockOn;
    Property UseClockedHrs: Boolean Read FbUseClockedHrs;
    Property IgnoreEarlyStart: Boolean Read FbIgnoreEarlyStart;
    Property IgnoreLateFinish: Boolean Read FbIgnoreLateFinish;
    Property BarcodePickingInSOMode: Boolean Read FbBarcodePickingInSOMode;
    Property AutoConvertSOtoInvoiceBarcodePick: Boolean Read FbAutoConvertSOtoInvoiceBarcodePick;
    Property ConsolidateCustBOonInvoice: Boolean Read FbConsolidateCustBOonInvoice;
    Property HideMatrixLineWithnoQty: Boolean Read FbHideMatrixLineWithnoQty;
    Property HideNonProductBOMEnrties: Boolean Read FbHideNonProductBOMEnrties;
    Property ShowActiveClassOnReports: Boolean Read FbShowActiveClassOnReports;
    Property IntegratedEFTPOS: Boolean Read FbIntegratedEFTPOS;
    property PosConfirmTotalPayment : boolean read fbPosConfirmTotalPayment write fbPosConfirmTotalPayment;
    Property CostonSalesToPO: Boolean Read FbCostonSalesToPO;
    Property POSUseCashDrawerOnly: Boolean Read FbPOSUseCashDrawerOnly;
    Property MemTransPriceUpdate: Boolean Read FbMemTransPriceUpdate;
    Property DefaultCustomerClassInPayments: Boolean Read FbDefaultCustomerClassInPayments;
    Property IgnoreTraining: Boolean Read FbIgnoreTraining write SetIgnoreTraining;
    Property UseAuditTrail: Boolean Read FbUseAuditTrail;
    Property POSSummariseBarTabInv: Boolean Read FbPOSSummariseBarTabInv;
    Property UseTNTFreight: Boolean Read FbUseTNTFreight;
    Property GroupJobsOnAccountsReceivable: Boolean Read FbGroupJobsOnAccountsReceivable;
    Property EnforceNoModifyonNotes: Boolean Read FbEnforceNoModifyonNotes;
    Property NoReturntoPrimaryKeypad: Boolean Read FbNoReturntoPrimaryKeypad;
    Property StartWorkWeek: String Read FsStartWorkWeek;
    Property EndWeek: String Read FsEndWeek;
    Property StartWorkWeekDay: Integer Read FiStartWorkWeek;
    Property NoofWeekendDays: Integer Read FiNoofWeekendDays;
    Property EndWeekDay: Integer Read FiEndWeek;
    Property DaysinWeek: Integer Read GetDaysinWeek;
    Property HoursinaDay: Double Read GetHoursinaDay;

    Property RecalcCostInvBO: Boolean Read FbRecalcCostInvBO;
    Property FixedAssetDepreciationAssetAccount: String Read FsFixedAssetDepreciationAssetAccount;
    Property FixedAssetDepreciationExpAccount: String Read FsFixedAssetDepreciationExpAccount;
    Property FixedAssetCostAssetAccount: String Read FsFixedAssetCostAssetAccount;
    Property FixedAssetClearingAccount: String Read FsFixedAssetClearingAccount;
    Property FiscalYearStarts: String Read FbFiscalYearStarts;
    Property FiscalYearStartsno: Integer read getFiscalYearStartsno;
    Property DepreciationCalculationConventions1: String Read FbDepreciationCalculationConventions1;
    Property MonthofPurchase1: String Read FbMonthofPurchase1;
    Property MonthofDisposal1: String Read FbMonthofDisposal1;
    Property DepreciationCalculationConventions2: String Read FbDepreciationCalculationConventions2;
    Property MonthofPurchase2: String Read FbMonthofPurchase2;
    Property MonthofDisposal2: String Read FbMonthofDisposal2;
    Property VerifyBalanceOnBatch: Boolean Read FbVerifyBalanceOnBatch;
    Property SpecialBarcodeLen: Integer Read FiSpecialBarcodeLen;
    Property Specialbarcodeformat :String read getSpecialbarcodeformat;
    Property SpecialBarcodeProductPos: Integer Read FiSpecialBarcodeProductPos;
    Property SpecialBarcodeProductLen: Integer Read FiSpecialBarcodeProductLen;
    Property SpecialBarcodeAmountPos: Integer Read FiSpecialBarcodeAmountPos;
    Property SpecialBarcodeAmountLen: Integer Read FiSpecialBarcodeAmountLen;
    Property DepreciationForTransactions: Integer Read FiDepreciationForTransactions;
    Property SupportPopupEnabled: Boolean Read FbSupportPopupEnabled;
    Property SupportAllcustomers: Boolean Read FbSupportAllcustomers;
    Property TeamViewerPath: String Read GetTeamViewerPath;
    Property ERPSupportPath: String Read GetERPSupportPath;
    Property SkypePath: String Read FsSkypePath;
    Property MaxNoOfAttributes: Integer Read FiMaxNoOfAttributes;
    Property SupportNoOfCalls: Integer Read FiSupportNoOfCalls;
    Property SupportPeriodInDays: Integer Read FiSupportPeriodInDays;
    Property SupportPopupMessage: String Read FsSupportPopupMessage;
    Property MedicareLevyRate: Double Read FdMedicareLevyRate;
    Property TaxableDeduction: Double Read FdTaxableDeduction;
    Property MedicareLevySurchargeRate: Double Read FdMedicareLevySurchargeRate;
    Property LumpSumTaxRate: Double Read FdLumpSumTaxRate;
    Property LumpSumTaxRateOver55: Double Read FdLumpSumTaxRateOver55;
    Property LumpSumETaxRate: Double Read FdLumpSumETaxRate;
    Property FBTTaxRate: Double Read FdFBTTaxRate;
    Property RBLThreshold: Double Read FdRBLThreshold;
    Property NoTFNTaxRate: Double Read FdNoTFNTaxRate;
    Property YearlyIncomeThreshold: Double Read FdYearlyIncomeThreshold;
    Property POSCloseInvoiceAfterCreate: Boolean Read FbPOSCloseInvoiceAfterCreate;
    Property ShowSoldSerialNumbers: Boolean Read FbShowSoldSerialNumbers;
    Property UseTemplateDefaultInvoice: Boolean Read FbUseTemplateDefaultInvoice;
    Property SumReceivedOnlyForeignCurrencyonPO: Boolean Read FbSumReceivedOnlyForeignCurrencyonPO;
    Property JobNameHeader: String Read FsJobNameHeader;
    Property DefaultStatusForInvoiceofdonerepair: String Read FsDefaultStatusForInvoiceofdonerepair;
    Property DefaultStockTransferAccount: String Read FsDefaultStockTransferAccount;
    Property DefaultStatusforSOofDoneRepair: String Read FsDefaultStatusforSOofDoneRepair;
    Property JobNumberHeader: String Read FsJobNumberHeader;
    Property ManifestType: String Read FsManifestType;
    Property HintInEditMode: Boolean REad FbHintInEditMode Write FbHintInEditMode;
    Property UseDelivery: Boolean Read FbUseDelivery;
    Property OneRunPerCustomer: Boolean Read FbOneRunPerCustomer;
    Property SuppressJobNamesOnInvoices: Boolean Read FbSuppressJobNameOnInvoices;
    Property PrintBarcodesOnOrder: Boolean Read FbPrintBarcodesOnOrder;
    Property ShowAccountNumberinBudget: Boolean Read FbShowAccountNumberinBudget;
    // property RepairFormTitle: string read fsRepairTitle;
    Property AutoGenerateCustomerAccntNumber: Boolean Read FbAutoGenerateCustomerAccntNumber;
    Property StoreForeignCurrencyValue: Boolean Read FbStoreForeignCurrencyValue;
    Property UseManufacturing: Boolean Read FbUseManufacturing;
    Property ShowLatestCost: Boolean Read GetShowLatestCost;
    Property ShowGrossProfitPercent: Boolean Read FbShowGrossProfitPercent;
    Property AutoCorrectPriceDiscountsOnDeliveries: Boolean Read FbAutoCorrectPriceDiscountsOnDeliveries;
    Property UseHistoryOnDespatchRuns: Boolean Read FbUseHistoryOnDespatchRuns;
    Property DefaultToChartOfAccountsTreeView: Boolean Read FbDefaultToChartOfAccountsTreeView;
    Property UseCostCentres: Boolean Read GetUseCostCentres;
    Property DisableAltSaveCost: Boolean Read FbDisableAltSaveCost;
    Property ShowCustomerJobNoByDefault: Boolean Read FbShowCustomerJobNoByDefault;
    Property CopyDataToNewDB: Boolean Read FbCopyDataToNewDB;
    Property CopyEmployeeAccess: Boolean Read FbCopyEmployeeAccess;
    Property CopyEmployeeSettings: Boolean Read FbCopyEmployeeSettings;
    Property CopyCompanySettings: Boolean Read FbCopyCompanySettings;
    Property UseCRM: Boolean Read FbUseCRM;
    Property UseBudget: Boolean Read FbUseBudget;
    Property UseHire: Boolean Read FbUseHire;
    Property LogoutwhenIdle: Boolean Read FbLogoutwhenIdle;
    Property Sessiontime: Double Read FdSessiontime;
    Property UseWorkShop: Boolean Read FbUseWorkShop;
    Property UseWorkFlow: Boolean Read FbUseWorkFlow;
    Property StartJobNameWithJobNumber: Boolean Read FbStartJobNumber;
    Property DisableCopyToSmartwhenSOCreate: Boolean Read FbDisableCopyToSmart;
    Property DisableInvCopyToSmartIfPOCreated: Boolean Read FbDisableInvCopyToSmartIfPOCreated;
    Property ShowDocketNumberColumnOnSales: Boolean Read FbShowDocketNumberColumnOnSales;
    Property ShowDocketNumberColumnOnPurchases: Boolean Read FbShowDocketNumberColumnOnPurchases;
    Property JobTitle: String Read FbJobTitle;
    Property ShowInvoiceFormwhenApptInvoiced: Boolean Read FbShowInvoiceFormwhenApptInvoiced;
    Property SalesWarrantyEndsOnCaption: String Read FbSalesWarrantyEndsOnCaption;
    Property SalesWarrantyPeriodCaption: String Read FbSalesWarrantyPeriodCaption;
    Property ShowSalesWarrantyEndsOn: Boolean Read FbShowSalesWarrantyEndsOn;
    Property SalesWarrantyEndsOnRequired: Boolean Read FbSalesWarrantyEndsOnRequired;
    Property SalesWarrantyPeriodRequired: Boolean Read FbSalesWarrantyPeriodRequired;
    Property ShowSalesWarrantyPeriod: Boolean Read FbShowSalesWarrantyPeriod;
    Property MatchUOMonSerialNoSelection: Boolean Read FbMatchUOMonSerialNoSelection;
    Property MatchUOMonBinBatchAllocation: Boolean Read FbMatchUOMonBinBatchAllocation;
    Property MatchUOMinallocation: Boolean Read FbMatchUOMinallocation;
    Property ManufacturePartSourceStock: Boolean Read FbManufacturePartSourceStock write setManufacturePartSourceStock;
    Property ManufacturePartSourceStockconfirm: Boolean Read FbManufacturePartSourceStockconfirm;
    Property AutoCreateSmartOrderFromSalesOrderTree: Boolean Read FbAutoCreateSmartOrderFromSalesOrderTree;
    Property CopyTreeInfotoSalesDesc: Boolean Read FbCopyTreeInfotoSalesDesc;
    Property PrintOnItemProgress: Boolean Read FbPrintOnItemProgress;
    Property PrintOnItemcompletion: Boolean Read FbPrintOnItemcompletion;
    Property HideSelectedSubnodesinReport: Boolean Read FbHideSelectedSubnodesinReport;
    Property AutoclockOnemployeeOnjob: Boolean Read FbAutoclockOnemployeeOnjob;
    Property OpenTreeOnSmartOrdercreation: Boolean Read FbOpenTreeOnSmartOrdercreation;
    Property EnforceBinVolume: Boolean Read FbEnforceBinVolume write SetEnforceBinVolume;
    property CountSOBOInAvailable : boolean read fbCountSOBOInAvailable;
    Property EnableBatchByDefault: Boolean Read FbEnableBatchByDefault;
    Property DefaultProductVolume: Double Read FdDefaultProductVolume;
    Property EnableBinByDefault: Boolean Read FbEnableBinByDefault;
    Property EnableSerialsByDefault: Boolean Read FbEnableSerialsByDefault;
    Property CreditCheckAppointment: String Read FbCreditCheckAppointment;
    Property CreditCheckRepair: Boolean Read FbCreditCheckRepair Write FbCreditCheckRepair;
    Property UseProductSpecsCalcsPO: Boolean Read FbUseProductSpecsCalcsPO;
    Property UseProductSpecsCalcsSales: Boolean Read FbUseProductSpecsCalcsSales;
    Property AllowAlocationFromOtherClasses: Boolean Read FbAllowAlocationFromOtherClasses;
    Property NABCardFastMerchantNumber: String Read FNABCardFastMerchantNumber;
    Property StockCostSystem: TStockCostSystem Read FtStockCostSystem;
    Property RememberLastTransactionBySupplier: Boolean Read FRememberLastTransactionBySupplier;
    Property RememberLastReconDeposit: Boolean Read FRememberLastReconDeposit;
    Property UseTimesheetRateIncAsInvoiceCost: Boolean Read FUseTimesheetRateIncAsInvoiceCost;
    Property CancelledAppointmentsNotPrinted: Boolean Read FCancelledAppointmentsNotPrinted;
    Property AutoLoadActualDatetimeFromscheduled: Boolean Read FbAutoLoadActualDatetimeFromscheduled;
    Property CopyClientDetailsFromPOStoSalesComments: Boolean Read FbCopyClientDetailsFromPOStoSalesComments;
    Property AutoUpdateActual: Boolean Read FbAutoUpdateActual;
    Property AppointmentDuration: Integer Read FiAppointmentDuration;
    Property MinimumChargeAppointmentTime: Integer Read FiMinimumChargeAppointmentTime;
    Property CustomerListMode: String Read FsCustomerListMode;
    Property AlwaysShowBOonCustomerCost: Boolean Read FAlwaysShowBOonCustomerCost;
    Property ProductClassDefaultAll: Boolean Read FbProductClassDefaultAll;
    Property InvoiceClassDefaultAll: Boolean Read FbInvoiceClassDefaultAll;
    Property EmailWhenPrintingPickingSlip: Boolean Read FbEmailWhenPrintingPickingSlip;
    Property PickingSlipEmailRecipient: String Read FsPickingSlipEmailRecipient;
    Property MonthsStockRetained: Integer Read FiMonthsStockRetained Write SetMonthsStockRetained;
    Property CodeHeader: String Read FsCodeHeader;
    Property CopyCOA: Boolean Read FbCopyCOA;
    Property CopyClients: Boolean Read FbCopyClients;
    Property CopyMarketingContacts: Boolean Read FbCopyMarketingContacts;
    Property IncludeContactNameInSalesshippingAddress: Boolean Read FbIncludeContactNameInSalesshippingAddress;
    Property IncludeContactPhoneInSalesshippingAddress: Boolean Read FbIncludeContactPhoneInSalesshippingAddress;
    Property CopyProducts: Boolean Read FbCopyProducts;
    Property CopyOutstandingTxn: Boolean Read FbCopyOutstandingTxn;
    Property IncomeTaxPercentage: Double Read FdIncomeTaxPercentage;
    Property ZerotaxWhenLoss: Boolean Read FbZerotaxWhenLoss;
    //Property ProductAvgcostCalculatedForDepartment: Boolean Read FbProductAvgcostCalculatedForDepartment;
    Property ConfirmBeforeInvoiceStockToNegative: Boolean Read FbConfirmBeforeInvoiceStockToNegative;
    Property ConfirmBeforesalePricechange: Boolean Read FbConfirmBeforesalePricechange;
    Property CurrentDateforSalesshipment: Boolean Read FbCurrentDateforSalesshipment;
    Property POSPrintAfterSave: Boolean Read FbPOSPrintAfterSave;
    Property NoOfMonthstoChangeClosingdate: Integer Read FiNoOfMonthstoChangeClosingdate;
    Property ProductcomboLookupExpressList: Boolean Read FbProductcomboLookupExpressList;
    Property CustomercomboLookupExpressList: Boolean Read FbCustomercomboLookupExpressList;
    Property AutomaticallyUpdateclosingDate: Boolean Read FbAutomaticallyUpdateclosingDate;
    Property UOMWeightUOM: String Read FsUOMWeightUOM;
    Property UOMVolumeDimensionUOM: String Read FsUOMVolumeDimensionUOM;
    Property MonitorTransactionEvents: Boolean Read FbMonitorTransactionEvents Write FbMonitorTransactionEvents;
    Property NegativeStockcheckinInvoicebasedon: String Read FsNegativeStockcheckinInvoicebasedon;
    Property RetailcustomerType1: String Read FsRetailcustomerType1;
    Property WholeSaleCustomerType1: String Read FsWholeSaleCustomerType1;
    Property WholeSaleCustomerType2: String Read FsWholeSaleCustomerType2;
    Property WholeSaleCustomerType3: String Read FsWholeSaleCustomerType3;
    Property WholeSaleCustomerType4: String Read FsWholeSaleCustomerType4;
    Property WholeSaleCustomerTypes :String read getWholeSaleCustomerTypes;
    Property SummarisedTransDate: TDateTime Read FdSummarisedTransDate Write SetSummarisedTransDate;
    Property SummarisedTransDateChanged: TDateTime Read FdSummarisedTransDateChanged;
    Property CustomerPaymentsDefaultVariationAccountID: Integer Read FiCustomerPaymentsDefaultVariationAccountID;
    Property SupplierPaymentsDefaultVariationAccountID: Integer Read FiSupplierPaymentsDefaultVariationAccountID;
    Property EmailAuthPassword: String Read FsEmailAuthPassword;
    Property AllClassesOnCustList: Boolean Read FbAllClassesOnCustList;
    Property POOnlyApprovedTransInSuppPayment: Boolean Read FbPOOnlyApprovedTransInSuppPayment;
    Property UseApprovalLevels: Boolean Read FbUseApprovalLevels;
    Property ApprovalType: String Read FsApprovalType write setApprovalType;
    Property UseSteppedApproval: Boolean Read getUseSteppedApproval ;
    Property UseSinglePersonApproval: Boolean Read getUseSinglePersonApproval ;
    Property IncludeUnInvoicedPOtoGL: Boolean Read FbIncludeUnInvoicedPOtoGL;
    Property UnInvoicedPOAccount: Integer Read FiUnInvoicedPOAccount;
    Property DutiesAccount : integer read FiDutiesAccount;
    Property BrokerHandlingAccount : integer read FiBrokerHandlingAccount;
    Property IncludeUnInvoicedSOtoGL: Boolean Read FbIncludeUnInvoicedSOtoGL;
    Property UnInvoicedSOAccount: Integer Read FiUnInvoicedSOAccount;
    Property UnInvoicedSOType: Integer Read FiUnInvoicedSOType;
    Property UnInvoicedSOLabourAccount: Integer Read FiUnInvoicedSOLabourAccount;
    Property UseBlindBalance: Boolean Read FbUseBlindBalance;
    Property CompanyRegion: String Read FsCompanyRegion Write SetCompanyRegion;
    Property POSShowProductPic: Boolean Read FbPOSShowProductPic;
    Property BankAccFormatting: Boolean Read FbBankAccFormatting;
    Property UsePCC: Boolean Read FbUsePCC;
    Property PCCPathToVisualConsole: String Read FsPCCPathToVisualConsole;
    Property POSPrintReceiptOnlyOnCompleteSale: Boolean Read FbPOSPrintReceiptOnlyOnCompleteSale;
    // must be ON if UsePCC is ON
    Property POSPrintDescriptionMultipleLines: Boolean Read FbPOSPrintDescriptionMultipleLines;
    // must be ON if UsePCC is ON
    Property UseAlphaNumericBarcodes: Boolean Read FbUseAlphaNumericBarcodes;
    Property BarTabsConvertStarted: Boolean Read GetBarTabsConvertStarted Write SetBarTabsConvertStarted;
    Property BatchUpdateInProgress: Boolean Read GetBatchUpdateInProgress Write SetBatchUpdateInProgress;
    Property EnableWebAPILoging: Boolean Read GetEnableWebAPILoging;
    Property SalesCommissionCalcInProgress: Boolean Read GetSalesCommissionCalcInProgress Write SetSalesCommissionCalcInProgress;
    Property USeSalesCommission: Boolean Read FbUSeSalesCommission;
    Property SalesCommissionCalcEmployeeID: Integer Read GetSalesCommissionCalcEmployeeID Write SetSalesCommissionCalcEmployeeID;
    Property TransactionTableLastUpdated: TDateTime Read GetTransactionTableLastUpdated Write SetTransactionTableLastUpdated;
    Property ReportTablesLastUpdatedOn: TDateTime Read GetReportTablesLastUpdatedOn Write SetReportTablesLastUpdatedOn;
    Property SerialNumberListUpdatedOn: TDateTime Read GetSerialNumberListUpdatedOn Write SetSerialNumberListUpdatedOn;
    Property UseFutureSO: Boolean Read FbUseFutureSO;
    Property LeaveOpenOnCopyToINV: Boolean Read FbLeaveOpenOnCopyToINV;
    Property FutureSODays: Integer Read FiFutureSODays;
    Property PCCVCAutoStart: Boolean Read FbPCCVCAutoStart;
    // property UseAssessment: Boolean read fbUseAssessment ;
    Property EmailInvoiceInfoToCustomer: Boolean Read FbEmailInvoiceInfoToCustomer;
    Property AutomaticDeliveryDocketPrint: Boolean Read FbAutomaticDeliveryDocketPrint;
    Property AutomaticSODeliveryDocketPrint: Boolean Read FbAutomaticSODeliveryDocketPrint;
    Property ResetCustPrices: Boolean Read FbResetCustPrices;
    Property PaymentsAddToEFT: Boolean Read FbPaymentsAddToEFT;
    Property DefaultDiscountMarkup: String Read FsDefaultDiscountMarkup;
    Property UsePriceSchemes: Boolean Read FbUsePriceSchems;
    Property UseDefaultMailClient: Boolean Read FbUseDefaultMailClient;
    Property DefaultMailClientPreview: Boolean Read FbDefaultMailClientPreview;
    Property EnableInvoicePickMail: Boolean Read FbEnableInvoicePickMail;
    Property EnableInvoicePickSMS: Boolean Read FbEnableInvoicePickSMS;
    Property EnableInvoiceDelMail: Boolean Read FbEnableInvoiceDelMail;
    Property EnableInvoiceDelSMS: Boolean Read FbEnableInvoiceDelSMS;
    Property EnableInvoiceMail: Boolean Read FbEnableInvoiceMail;
    Property EnableInvoicePrintSMS: Boolean Read FbEnableInvoicePrintSMS;
    Property InvoicePickMailSubject: String Read FsInvoicePickMailSubject;
    Property InvoicePickMailText: String Read FsInvoicePickMailText;
    Property InvoicePickSMSText: String Read FsInvoicePickSMSText;
    Property InvoiceDelMailSubject: String Read FsInvoiceDelMailSubject;
    Property InvoiceDelMailText: String Read FsInvoiceDelMailText;
    Property InvoiceDelSMSText: String Read FsInvoiceDelSMSText;
    Property InvoiceMailSubject: String Read FsInvoiceMailSubject;
    Property InvoiceMailText: String Read FsInvoiceMailText;
    Property InvoicePrintSMSText: String Read FsInvoicePrintSMSText;
    Property DefaultEmailSubject: String Read FsDefaultEmailSubject;
    Property DefaultEmailText: String Read FsDefaultEmailText;
    Property UseElectronicIntrastat: Boolean Read FbUseElectronicIntrastat;
    Property UseElectronicVAT: Boolean Read FbUseElectronicVAT;
    Property VATSenderID: String Read FsVATSenderID;
    Property VATKeyType: String Read FsVATKeyType;
    Property VATKeys: String Read FsVATKeys;
    Property VATVendorID: String Read FsVATVendorID;
    Property ProductListPriceMultiplierOn: String Read FsProductListPriceMultiplierOn;
    Property VATCurrencyCode: String Read FsVATCurrencyCode;
    Property VATAuthentication: String Read FsVATAuthentication;
    Property VATMaxAttemptsPerSession: Integer Read FiVATMaxAttemptsPerSession;
    Property UKGatewayIsLive: Boolean Read FbUKGateWayIsLive;
    Property UseEmployeeClassForARList: Boolean Read FbUseEmployeeClassForARList Write FbUseEmployeeClassForARList;
    Property UpdateSaleShippedFromPOReceived: Boolean Read FUpdateSaleShippedFromPOReceived Write FUpdateSaleShippedFromPOReceived;
    Property WorkersCompRate: Double Read FWorkersCompRate Write FWorkersCompRate;
    Property ProductListPriceMultiplier: Double Read FProductListPriceMultiplier Write FProductListPriceMultiplier;
    Property ValueforRewardPoints: Double Read FValueforRewardPoints Write FValueforRewardPoints;
    Property OPOSScaleMultiplier: Double Read FdOPOSScaleMultiplier;
    Property MultiplesofPointstoRedeem: Integer Read FiMultiplesofPointstoRedeem Write FiMultiplesofPointstoRedeem;
    Property CustomerTypeRequired: Boolean Read FCustomerTypeRequired Write FCustomerTypeRequired;
    Property EnablequoteVariation: Boolean Read FbEnablequoteVariation Write FbEnablequoteVariation;
    //Property FristTransDate: TDateTime Read FdFristTransDate;
    Property FirstTransDate: TDateTime Read GetFirstTransDAte;
    Property BOByDefaultOnSO: Boolean Read FbBOByDefaultOnSO;
    Property BOByDefaultOnInvoice: Boolean Read FbBOByDefaultOnInvoice;
    Property ExcludeInactiveContactFromMessages: Boolean Read FbExcludeInactiveContactFromMessages;
    Property ShowRelatedMasterinSales: Boolean Read FbShowRelatedMasterinSales;
    Property ShowRelatedProductsinSales: Boolean Read FbShowRelatedProductsinSales;
    //Property Sales_ProductlistMatchCustomerArea: Boolean Read FbSales_ProductlistMatchCustomerArea;
    Property RelatedMasterCaptionInSales: String Read FsRelatedMasterCaptionInSales;
    Property MatchSaleLineShipDateToHeader: Boolean Read FMatchSaleLineShipDateToHeader;
    Property MatchSalesLineShipdateToProductDeliveryDays: Boolean Read FMatchSalesLineShipdateToProductDeliveryDays;
    Property StatusToMakeSalesOrder: String Read FsStatusToMakeSalesOrder;
    Property StatustoMakeInvoice: String Read FsStatustoMakeInvoice;
    Property RemoveHideOnPrintProductFromReports: Boolean Read FbRemoveHideOnPrintProductFromReports Write FbRemoveHideOnPrintProductFromReports;
    Property HoldRepairOnPrinting: Boolean Read FbHoldRepairOnPrinting;
    Property RepairDoneOnConversion: Boolean Read FbRepairDoneOnConversion;
    Property LockRepairwhenDone: Boolean Read FbLockRepairwhenDone;
    // property RepairHasToBeApprovedforInvoicing: Boolean read fbRepairHasToBeApprovedforInvoicing;
    Property RepairStatustoMakeInvoice: STring Read FsRepairStatustoMakeInvoice;
    // property SOHasToBeApprovedforInvoicing: Boolean read fbSOHasToBeApprovedforInvoicing;
    Property EnforceCustPOInrepairbeforeOtherInfo: Boolean Read FbEnforceCustPOInrepairbeforeOtherInfo;
    Property CanEditSalesshiptoAddress: Boolean Read FbCanEditSalesshiptoAddress;
    Property CanRemoveSupplierInvoiceNoInPO: Boolean Read FbCanChanePOInvoiceNo;
    Property InsuranceProductListMinCost: Double Read FdInsuranceProductListMinCost;
    Property InsuranceProductNameStartsWith: String Read FsInsuranceProductNameStartsWith;
    Property DefaultAccountingMethod: String Read FsDefaultAccountingMethod;
    Property InsurancereportOrderbyProductNameStartswith1: String Read FsInsurancereportOrderbyProductNameStartswith1;
    Property InsurancereportOrderbyProductNameStartswith2: String Read FsInsurancereportOrderbyProductNameStartswith2;
    Property InsuranceAgencyREf1: String Read FsInsuranceAgencyREf1;
    Property InsuranceAgencyREf2: String Read FsInsuranceAgencyREf2;
    Property InsurancePremiumcharged: Double Read FdInsurancePremiumcharged;
    Property IsSalesCategoryMandatory: Boolean Read FbIsSalesCategoryMandatory;
    Property SalesPrintOrderBy: String Read FsSalesPrintOrderBy;
    Property ReplaceDiscontinuedwithAlternate: Boolean Read FbReplaceDiscontinuedwithAlternate;
    Property UseDiscontinuedProductPriceforAlternateProduct: Boolean Read FbUseDiscontinuedProductPriceforAlternateProduct;
    Property LoadCustnameinNewshippingAddress: Boolean Read FbLoadCustnameinNewshippingAddress;
    Property DefualtModuleNameforPhSupport: String Read FsDefualtModuleNameforPhSupport;
    Property PadQuotePricesIncTax: Boolean Read FbPadQuotePricesIncTax;
    //Property UseProductBuyCostForLatestCost: Boolean Read FbUseProductBuyCostForLatestCost;
    Property SalesLineLatestCostBasedOn :TSalesLineLatestCostBasedOn Read fSalesLineLatestCostBasedOn;
    Property SalesLineLatestCostBasedOnMsg :String read getSalesLineLatestCostBasedOnMsg;
    Property RALineDefaultStatus: String Read FsRALineDefaultStatus;
    Property ClosingDateChangeDone: Boolean Read FbClosingDateChangeDone Write SetClosingDateChangeDone;
    Property SupportAutoAssign: Boolean Read FbSupportAutoAssign;
    Property CombineRepairTimeSheetLinesOnInvoice: Boolean Read FbCombineRepairTimeSheetLinesOnInvoice;
    Property PartCalcfield1: Boolean Read FbPartCalcfield1 ;
    Property PartCalcfield2: Boolean Read FbPartCalcfield2 ;
    Property PartCalcfield3: Boolean Read FbPartCalcfield3 ;
    Property PartCalcfield4: Boolean Read FbPartCalcfield4 ;
    Property PartCalcfield5: Boolean Read FbPartCalcfield5 ;

    Property PartCalcfield1Visible: Boolean Read GetPartCalcfield1Visible;
    Property PartCalcfield2Visible: Boolean Read GetPartCalcfield2Visible;
    Property PartCalcfield3Visible: Boolean Read GetPartCalcfield3Visible;
    Property PartCalcfield4Visible: Boolean Read GetPartCalcfield4Visible;
    Property PartCalcfield5Visible: Boolean Read GetPartCalcfield5Visible;
    Property PartCalcfieldVisible: Boolean Read GetPartCalcfieldVisible;

    Property PartCalcField1Name: String Read FsPartCalcField1Name;
    Property PartCalcfield2Name: String Read FsPartCalcfield2Name;
    Property PartCalcfield3Name: String Read FsPartCalcfield3Name;
    Property PartCalcfield4Name: String Read FsPartCalcfield4Name;
    Property PartCalcfield5Name: String Read FsPartCalcfield5Name;
    Property QtySoldColour: TColor Read FQtySoldColour;
    Property QtyShippedColour: TColor Read FQtyShippedColour;
    Property IndicateifBatchAllocated: Boolean Read FbIndicateifBatchAllocated;
    Property IndicateifBinAllocated: Boolean Read FbIndicateifBinAllocated;
    Property IndicateifSNAllocated: Boolean Read FbIndicateifSNAllocated;
    Property IndicateContainerRelatedProduct: Boolean Read FbIndicateContainerRelatedProduct;
    Property IndicatePalletRelatedProduct: Boolean Read FbIndicatePalletRelatedProduct;

    Property BatchAllocationColour: TColor Read FBatchAllocationColour;
    Property BinAllocationColour: TColor Read FBinAllocationColour;
    Property SNAllocationColour: TColor Read FSNAllocationColour;
    Property ContainerRelatedProductColour: TColor Read FContainerRelatedProductColour;
    Property PalletRelatedProductColour: TColor Read FPalletRelatedProductColour;
    Property GanttChartGFStartColour: TColor Read FGanttChartGFStartColour;
    Property GanttChartGFEndcolour: TColor Read FGanttChartGFEndcolour;
    Property GanttChartDrawStyle: Integer Read FiGanttChartDrawStyle;
    Property GanttChartBarHeight: Integer Read FiGanttChartBarHeight;
    Property CostDecimalPlacesinTree : Integer Read getCostDecimalPlacesinTree;
    Property PPGBalanceAdjAccountID : Integer Read fiPPGBalanceAdjAccountID;
    Property PPGBalanceAdjEmployeeID : Integer Read fiPPGBalanceAdjEmployeeID;
    Property DefaultBOMWastageAccount : String Read fsDefaultBOMWastageAccount;
    Property BoMNonProductsubnodePostingAccount : String Read fBoMNonProductsubnodePostingAccount;
    Property ProductStatusPartQtyColour: TColor Read FProductStatusPartQtyColour;
    Property ProductStatusTransQtyColour: TColor Read FProductStatusTransQtyColour;
    Property ProductStatusOrderQtyColour: TColor Read FProductStatusOrderQtyColour;
    Property ProductStatusETAWithinPeriodColour: TColor Read FProductStatusETAWithinPeriodColour;
    Property ProductStatusETAExceededColour: TColor Read FProductStatusETAExceededColour;
    Property ShowSalesProductAutoSelectOptions: Boolean Read FbShowSalesProductAutoSelectOptions;
    Property CyTrackIntegrationEnabled: Boolean Read FCyTrackIntegrationEnabled Write SetCyTrackIntegrationEnabled;
    Property IsClonedCopy: Boolean Read FbIsClonedCopy;
    Property DisableAutoUpdateclosingDate: Boolean Read FbDisableAutoUpdateclosingDate;
    Property ShowAmountToAppearOnPrintout: Boolean Read FbShowAmountToAppearOnPrintout Write FbShowAmountToAppearOnPrintout;
    Property EnforceCustomerFirstAndLastName: Boolean Read FEnforceCustomerFirstAndLastName Write FEnforceCustomerFirstAndLastName;
    Property EnforcesupplierFirstName: Boolean Read FEnforcesupplierFirstName Write FEnforcesupplierFirstName;
    Property IncludeJournalsInCashBAS: Boolean Read FbIncludeJournalsInCashBAS;
    Property EnableAusEparcel: Boolean Read FbEnableAusEparcel;
    Property SMSEnabled: Boolean Read GetSMSEnabled;
    Property EnableInvoiceSaveMail: Boolean Read FbEnableInvoiceSaveMail;
    Property EnableInvoiceSaveSMS: Boolean Read FbEnableInvoiceSaveSMS;
    Property InvoiceSaveEmailSubject: String Read FsInvoiceSaveEmailSubject;
    Property InvoiceSaveEmailText: String Read FsInvoiceSaveEmailText;
    Property InvoiceSaveSMSText: String Read FsInvoiceSaveSMSText;

    Property EnableSOPrintEmail: Boolean Read FbEnableSOPrintEmail;
    Property EnableSOPrintSMS: Boolean Read FbEnableSOPrintSMS;
    Property SOPrintEmailSubject: String Read FsSOPrintEmailSubject;
    Property SOPrintEmailText: String Read FsSOPrintEmailText;
    Property SOPrintSMSText: String Read FsSOPrintSMSText;

    Property EnableSOSaveEmail: Boolean Read FbEnableSOSaveEmail;
    Property EnableSOSaveSMS: Boolean Read FbEnableSOSaveSMS;
    Property ApplyPrepaymentsOnSOConversion: Boolean Read FbApplyPrepaymentsOnSOConversion;
    Property EnableScheduledreports: Boolean Read FbEnableScheduledreports;
    Property SOSaveEmailSubject: String Read FsSOSaveEmailSubject;
    Property SOSaveEmailText: String Read FsSOSaveEmailText;
    Property SOSaveSMSText: String Read FsSOSaveSMSText;

    Property EnableQuotePrintEmail: Boolean Read FbEnableQuotePrintEmail;
    Property EnableQuotePrintSMS: Boolean Read FbEnableQuotePrintSMS;
    Property QuotePrintEmailSubject: String Read FsQuotePrintEmailSubject;
    Property QuotePrintEmailText: String Read FsQuotePrintEmailText;
    Property QuotePrintSMSText: String Read FsQuotePrintSMSText;

    Property EnableQuoteSaveEmail: Boolean Read FbEnableQuoteSaveEmail;
    Property EnableQuoteSaveSMS: Boolean Read FbEnableQuoteSaveSMS;
    Property QuoteSaveEmailSubject: String Read FsQuoteSaveEmailSubject;
    Property QuoteSaveEmailText: String Read FsQuoteSaveEmailText;
    Property QuoteSaveSMSText: String Read FsQuoteSaveSMSText;

    Property EnableShipContainerChangeEmail: Boolean Read FbEnableShipContainerChangeEmail;
    Property EnablShipContainerChangeSMS: Boolean Read FbEnablShipContainerChangeSMS;
    Property ShipContainerChangeEmailSubject: String Read FsShipContainerChangeEmailSubject;
    Property ShipContainerChangeEmailText: String Read FsShipContainerChangeEmailText;
    Property ShipContainerChangeSMSText: String Read FsShipContainerChangeSMSText;

    Property EnableAppointmentPrintEmail: Boolean Read FbEnableAppointmentPrintEmail;
    Property EnableAppointmentPrintSMS: Boolean Read FbEnableAppointmentPrintSMS;
    Property EnableAppointmentRepPrintSMS: Boolean Read FbEnableAppointmentRepPrintSMS;
    Property AppointmentPrintEmailSubject: String Read FsAppointmentPrintEmailSubject;
    Property AppointmentPrintEmailText: String Read FsAppointmentPrintEmailText;
    Property AppointmentPrintSMSText: String Read FsAppointmentPrintSMSText;
    Property AppointmentRepPrintSMSText: String Read FsAppointmentRepPrintSMSText;

    Property EnablePOReceiveSOEmail: Boolean Read FbEnablePOReceiveSOEmail;
    Property EnablePOReceiveSOSMS: Boolean Read FbEnablePOReceiveSOSMS;
    Property POReceiveSOEmailSubject: String Read FsPOReceiveSOEmailSubject;
    Property POReceiveSOEmailText: String Read FsPOReceiveSOEmailText;
    Property POReceiveSOSMSText: String Read FsPOReceiveSOSMSText;

    Property EnablePOReceiveInvEmail: Boolean Read FbEnablePOReceiveInvEmail;
    Property EnablePOReceiveInvSMS: Boolean Read FbEnablePOReceiveInvSMS;
    Property POReceiveInvEmailSubject: String Read FsPOReceiveInvEmailSubject;
    Property POReceiveInvEmailText: String Read FsPOReceiveInvEmailText;
    Property POReceiveInvSMSText: String Read FsPOReceiveInvSMSText;

    Property EnableInvShipChangeEmail: Boolean Read FbEnableInvShipChangeEmail;
    Property EnableInvShipChangeSMS: Boolean Read FbEnableInvShipChangeSMS;
    Property InvShipChangeEmailSubject: String Read FsInvShipChangeEmailSubject;
    Property InvShipChangeEmailText: String Read FsInvShipChangeEmailText;
    Property InvShipChangeSMSText: String Read FsInvShipChangeSMSText;

    Property EnableSOShipChangeEmail: Boolean Read FbEnableSOShipChangeEmail;
    Property EnableSOShipChangeSMS: Boolean Read FbEnableSOShipChangeSMS;
    Property SOShipChangeEmailSubject: String Read FsSOShipChangeEmailSubject;
    Property SOShipChangeEmailText: String Read FsSOShipChangeEmailText;
    Property SOShipChangeSMSText: String Read FsSOShipChangeSMSText;

    Property EnableRefundPrintEmail: Boolean Read FbEnableRefundPrintEmail;
    Property EnableRefundPrintSMS: Boolean Read FbEnableRefundPrintSMS;
    Property RefundPrintEmailSubject: String Read FsRefundPrintEmailSubject;
    Property RefundPrintEmailText: String Read FsRefundPrintEmailText;
    Property RefundPrintSMSText: String Read FsRefundPrintSMSText;

    Property EnableRepairInvoicedEmail: Boolean Read FbEnableRepairInvoicedEmail;
    Property EnableRepairInvoicedSMS: Boolean Read FbEnableRepairInvoicedSMS;
    Property RepairInvoicedEmailSubject: String Read FsRepairInvoicedEmailSubject;
    Property RepairInvoicedEmailText: String Read FsRepairInvoicedEmailText;
    Property RepairInvoicedSMSText: String Read FsRepairInvoicedSMSText;


    Property EnableRepairPrintEmail: Boolean Read FbEnableRepairPrintEmail;
    Property EnableAutoSplitQtyintoUOMinSales: Boolean Read FbEnableAutoSplitQtyintoUOMinSales Write SetEnableAutoSplitQtyintoUOMinSales;
    Property EnableRepairPrintSMS: Boolean Read FbEnableRepairPrintSMS;
    Property RepairPrintEmailSubject: String Read FsRepairPrintEmailSubject;
    Property RepairPrintEmailText: String Read FsRepairPrintEmailText;
    Property RepairPrintSMSText: String Read FsRepairPrintSMSText;

    Property EnablePOCreateEmail: Boolean Read FbEnablePOCreateEmail;
    Property POCreateEmailSubject: String Read FsPOCreateEmailSubject;
    Property POCreateEmailText: String Read FsPOCreateEmailText;

    Property EnablePOPrintEmail: Boolean Read FbEnablePOPrintEmail;
    Property EnablePOPrintSMS: Boolean Read FbEnablePOPrintSMS;
    Property POPrintEmailSubject: String Read FsPOPrintEmailSubject;
    Property POPrintEmailText: String Read FsPOPrintEmailText;
    Property POPrintSMSText: String Read FsPOPrintSMSText;

    Property EnableRAPrintEmail: Boolean Read FbEnableRAPrintEmail;
    Property EnableRAPrintSMS: Boolean Read FbEnableRAPrintSMS;
    Property RAPrintEmailSubject: String Read FsRAPrintEmailSubject;
    Property RAPrintEmailText: String Read FsRAPrintEmailText;
    Property RAPrintSMSText: String Read FsRAPrintSMSText;

    Property EnableBillPrintEmail: Boolean Read FbEnableBillPrintEmail;
    Property EnableBillPrintSMS: Boolean Read FbEnableBillPrintSMS;
    Property BillPrintEmailSubject: String Read FsBillPrintEmailSubject;
    Property BillPrintEmailText: String Read FsBillPrintEmailText;
    Property BillPrintSMSText: String Read FsBillPrintSMSText;

    Property EnableCreditPrintEmail: Boolean Read FbEnableCreditPrintEmail;
    Property EnableCreditPrintSMS: Boolean Read FbEnableCreditPrintSMS;
    Property CreditPrintEmailSubject: String Read FsCreditPrintEmailSubject;
    Property CreditPrintEmailText: String Read FsCreditPrintEmailText;
    Property CreditPrintSMSText: String Read FsCreditPrintSMSText;

    Property EnableCashSalePrintEmail: Boolean Read FbEnableCashSalePrintEmail;
    Property EnableCashSalePrintSMS: Boolean Read FbEnableCashSalePrintSMS;
    Property CashSalePrintEmailSubject: String Read FsCashSalePrintEmailSubject;
    Property CashSalePrintEmailText: String Read FsCashSalePrintEmailText;
    Property CashSalePrintSMSText: String Read FsCashSalePrintSMSText;

    Property EnablePOSCashSalePrintEmail: Boolean Read FbEnablePOSCashSalePrintEmail;
    Property EnablePOSCashSalePrintSMS: Boolean Read FbEnablePOSCashSalePrintSMS;
    Property POSCashSalePrintEmailSubject: String Read FsPOSCashSalePrintEmailSubject;
    Property POSCashSalePrintEmailText: String Read FsPOSCashSalePrintEmailText;
    Property POSCashSalePrintSMSText: String Read FsPOSCashSalePrintSMSText;

    Property EnableVoucherSalePrintEmail: Boolean Read FbEnableVoucherSalePrintEmail;
    Property EnableVoucherSalePrintSMS: Boolean Read FbEnableVoucherSalePrintSMS;
    Property InvoiceHasToBeApproved: Boolean Read FbInvoiceHasToBeApproved;
    Property EnableBoinBOMsalesOrder: Boolean Read FbEnableBoinBOMsalesOrder;
    Property VoucherSalePrintEmailSubject: String Read FsVoucherSalePrintEmailSubject;
    Property VoucherSalePrintEmailText: String Read FsVoucherSalePrintEmailText;
    Property VoucherSalePrintSMSText: String Read FsVoucherSalePrintSMSText;

    property PrintStatementsSMSText: string read fPrintStatementsSMSText;
    property ARSMSText: string read fARSMSText;

    Property Savesoundfile: String Read FsSavesoundfile;
    Property Printsoundfile: String Read FsPrintsoundfile;
    Property Cancelsoundfile: String Read FsCancelsoundfile;
    Property Emailsoundfile: String Read FsEmailsoundfile;

    Property EnableSoundonSave: Boolean Read FbEnableSoundonSave;
    Property EnableSoundonPrint: Boolean Read FbEnableSoundonPrint;
    Property EnableSoundonCancel: Boolean Read FbEnableSoundonCancel;
    Property EnableSoundonEmail: Boolean Read FbEnableSoundonEmail;

    Property DepreciationCalcStart1: String Read FDepreciationCalcStart1;
    Property DepreciationCalcStart2: String Read FDepreciationCalcStart2;
    Property PQADEtailsCUSTFLD1: String Read FPQADEtailsCUSTFLD1;
    Property EnablePQADEtailsCUSTFLD1: Boolean Read FEnablePQADEtailsCUSTFLD1;
    Property PQADEtailsCUSTFLD4: String Read FPQADEtailsCUSTFLD4;
    Property EnablePQADEtailsCUSTFLD4: Boolean Read FEnablePQADEtailsCUSTFLD4;
    Property DisableAuditTrialinQuickPOS: Boolean Read FDisableAuditTrialinQuickPOS;
    Property CompleteBOMOrderOnSave: Boolean Read FCompleteBOMOrderOnSave;
    Property AutoScheduleBasedonBOMEmpRoster: Boolean Read FAutoScheduleBasedonBOMEmpRoster;
    Property OnlyshowScheduledJobsForBarCodeMan: Boolean Read FOnlyshowScheduledJobsForBarCodeMan;
    // property UPSEnabled: boolean read fUPSEnabled;
    // property UPSAccessKey: string read fUPSAccessKey;
    // property UPSPassword: string  read fUPSPassword;
    // property UPSAccountNumber: string read fUPSAccountNumber;
    // property UPSUserID: string read fUPSUserID;
    // property UPSServer: string read fUPSServer;
    property SMSConfig: TSMSConfig read FSMSConfig;

    Property UPSConfig: TUPSConfig Read FUPSConfig;
    Property FedExConfig: TFedExConfig Read FFedExConfig;
    Property USPSConfig: TUSPSConfig Read FUSPSConfig;

    property GoogleCalendarConfig: TGoogleCalendarConfig read fGoogleCalendarConfig;
    property SPSConfig: TSPSConfig read fSPSConfig;
    property HMRC_APIConfig: THMRC_APIConfig read fHMRC_APIConfig;
    property AmazonConfig: TAmazonConfig read fAmazonConfig;
    property PasswordConfig: TPasswordConfig read fPasswordConfig;
    Property AllowShipmentsFromSalesOrder: Boolean Read FAllowShipmentsFromSalesOrder;
    property ShowEdiIntegration: boolean read fShowEdiIntegration;
    property PreventInvoiceOnStopCredit: boolean read fPreventInvoiceOnStopCredit;
    property PreventSalesOrderOnStopCredit: boolean read fPreventSalesOrderOnStopCredit;
    Property AccountPosingPopulated: Boolean Read FbAccountPosingPopulated write SetAccountPosingPopulated;
    Property CompanyDefaultsSelected: Boolean Read FbCompanyDefaultsSelected write SetCompanyDefaultsSelected;
    Property checkforStockinOtherDept :Boolean read fbcheckforStockinOtherDept;
    //Property AllowSplitPaymentInInvoice :Boolean read fbAllowSplitPaymentInInvoice;
    property InvoiceMailAttachmentSubject: string read fInvoiceMailAttachmentSubject;
    property InvoiceMailAttachmentBodyText: string read fInvoiceMailAttachmentBodyText;
    Property PrintEOPProductGroupreport :Boolean read fbPrintEOPProductGroupreport;
    property CombinePOSQuntities: boolean read fCombinePOSQuntities;
    property AutoAppendBatchNumber: boolean read fAutoAppendBatchNumber;
    property AllProductGroupsforSalesCollatedByItemreport: boolean read fAllProductGroupsforSalesCollatedByItemreport;
    property UseBarcodeDispatch: boolean read fUseBarcodeDispatch;
    property StandardCostCOGSAdjustmentAccountID: integer read fStandardCostCOGSAdjustmentAccountID;
    property StandardCostPurchaseAdjustmentAccountID: integer read fStandardCostPurchaseAdjustmentAccountID;

    property IncludeContactNameInSalesBillingAddress: boolean read fIncludeContactNameInSalesBillingAddress;
    property UseInventoryStandardCosting: boolean read fUseInventoryStandardCosting;
    property UseCustFld1ForSaleLineBatchAllocation: boolean read fUseCustFld1ForSaleLineBatchAllocation;
    property ExcludeZeroAllocationsFromPickingSlip: boolean read fExcludeZeroAllocationsFromPickingSlip;
    property AutoPopUpBarcodePickingOptions: boolean read fAutoPopUpBarcodePickingOptions write SetAutoPopUpBarcodePickingOptions;
    property EnforceConNoteOnSale: boolean read fEnforceConNoteOnSale;
    property UOMToBeUsedInManufactureDefault: string read fUOMToBeUsedInManufactureDefault;
    Property SurchargePercent1: Double Read FdSurchargePercent1;
    Property SurchargePercent2: Double Read FdSurchargePercent2;
    Property SurchargePercent3: Double Read FdSurchargePercent3;
    Property SurchargePercent4: Double Read FdSurchargePercent4;
    Property SurchargePercentDEfined:Boolean read getSurchargePercentDEfined;
    property DefaultSuperOnTimesheet: boolean read fDefaultSuperOnTimesheet;
    property UseSupportEmail: boolean read fUseSupportEmail;
    property POSPostBlindBalanceVariance: boolean read fPOSPostBlindBalanceVariance;
    property EOPReportShowAlltimeSlots: boolean read fEOPReportShowAlltimeSlots;
    property UseCashDrop: boolean read fUseCashDrop;
    Property CashDropLotsOf :Integer read fCashDropLotsOf ;
    property POSBliandBalanceVarianceAccount: string read fPOSBliandBalanceVarianceAccount;
    //property EnablePackWeight: boolean read fEnablePackWeight;
    property EnablePackWeightField1: boolean read fEnablePackWeightField1;
    property EnablePackWeightField2: boolean read fEnablePackWeightField2;
    property PackWeightField1: string read fPackWeightField1;
    property PackWeightField2: string read fPackWeightField2;
    property PackWeightQtyField: Integer read fiPackWeightQtyField;
    property DefaultHireIncomeAccount: string read fDefaultHireIncomeAccount;
    property DefaultHireProductName: string read fDefaultHireProductName;
    Property Fe1Name :String read fsFe1Name;
    Property Fe2Name :String read fsFe2Name;
    Property Fe3Name :String read fsFe3Name;
    Property Fe4Name :String read fsFe4Name;
    Property Fe5Name :String read fsFe5Name;
    Property FeQtyField :String read fsFeQtyField;
    Property FeQtyFieldInfodisplayLabel :String read fsFeQtyFieldInfodisplayLabel Write SetFeQtyFieldInfodisplayLabel;

    Property Fe1Visible :Boolean Read fbFe1Visible;
    Property Fe2Visible :Boolean Read fbFe2Visible;
    Property Fe3Visible :Boolean Read fbFe3Visible;
    Property Fe4Visible :Boolean Read fbFe4Visible;
    Property Fe5Visible :Boolean Read fbFe5Visible;
    Property FeFieldVisible: Boolean Read GetFeFieldVisible;

    property NewRepairNotesText: string read fsNewRepairNotesText;
    property AddNotesToNewRepair : boolean read fAddNotesToNewRepair;
    property ProductReorderRoundNearest : boolean read fProductReorderRoundNearest;
    property ProductReorderRoundValue : integer read fProductReorderRoundValue;
    Property ShowRelatedProductSelectioninSale: Boolean Read FShowRelatedProductSelectioninSale;
    property CashDropLimit : integer read fCashDropLimit;
    Property HideCustomertypeNotSelectedinSalesCatgbyItemReport: Boolean Read FbHideCustTypeNotSelectedinSlsCatgbyItmRpt;
    Property POHasPeriodPosting: Boolean Read FPOHasPeriodPosting;
    Property ClientPrintNameHeading :String read fClientPrintNameHeading;
    Property ProductPrintNameHeading :String read fProductPrintNameHeading;

    property StateFreightChargeEnabled: boolean read fStateFreightChargeEnabled;
    property CopyProductPrintNameToName: boolean read fCopyProductPrintNameToName;
    property CopyClientPrintNameToName: boolean read fCopyClientPrintNameToName;
    property FreightChargeProduct: string read fFreightChargeProduct;
    property LoginExpireDays: integer read fLoginExpireDays;
    property LoginExpireDate: TDateTime read fLoginExpireDate;
    property SalesBackorderCheckType: string read fSalesBackorderCheckType;
    Property CreatePOOnSalesToSmartOrderconvertion :Boolean read getCreatePOOnSalesToSmartOrderconvertion;
    Property ConfirmPOCreationOnSalesToSmartOrderconvertion :Boolean read getConfirmPOCreationOnSalesToSmartOrderconvertion;
    Property DonotCreatePOOnSalesToSmartOrderconvertion :Boolean read getDonotCreatePOOnSalesToSmartOrderconvertion;
    property BlankLinesinSuppPaymentCheque: integer read fBlankLinesinSuppPaymentCheque;
    property SalesDefaultAreaFromCustomer: boolean read fSalesDefaultAreaFromCustomer;
    property PurchaseDefaultAreaFromSupplier: boolean read fPurchaseDefaultAreaFromSupplier;
    Property CreditCheckTermsInv :String read fsCreditCheckTermsInv;
    Property CreditCheckTermsSO :String read fsCreditCheckTermsSO;
    Property ChangeCreditCheckTermsInv :boolean read fbChangeCreditCheckTermsInv;
    Property ChangeCreditCheckTermsSO :boolean read fbChangeCreditCheckTermsSO;
    Property AutoLocateproductinList :boolean read fbAutoLocateproductinList;
    Property AutoLocateLastRecord :boolean read fbAutoLocateLastRecord;
    property DisableSaleLineZeroQuantityWarning: boolean read fDisableSaleLineZeroQuantityWarning write SetDisableSaleLineZeroQuantityWarning;
    property DisablePurchaseLineZeroQuantityWarning: boolean read fDisablePurchaseLineZeroQuantityWarning write SetDisablePurchaseLineZeroQuantityWarning;
    Property POStoreAwayTemplate: String Read FsPOStoreAwayTemplate;

    Property AccountNamecolumnDropdownWidth: Integer Read FiAccountNamecolumnDropdownWidth;
    Property AccountTypecolumnDropdownWidth: Integer Read FiAccountTypecolumnDropdownWidth;
    Property AccountDescriptioncolumnDropdownWidth: Integer Read FiAccountDescriptioncolumnDropdownWidth;

    property SalesTaxThresholdWholeOrder: boolean read fSalesTaxThresholdWholeOrder;
    property ShowSaleLineInStockQty: boolean read fShowSaleLineInStockQty;
    property MatchInvoiceDateToShipDate: boolean read fMatchInvoiceDAteToShipDate;
    property MatchInvoiceDateToETADate: boolean read fMatchInvoiceDateToETADate;
    property CustEarlyPaymentAction: integer read fCustEarlyPaymentAction;
    property SuppEarlyPaymentAction: integer read fSuppEarlyPaymentAction;
    property OpenfileWhenDataExported: boolean read fOpenfileWhenDataExported;
    property UseERPFilenameforDataExport: boolean read fUseERPFilenameforDataExport;
    Property DataExportDefaultExtension: String Read FsDataExportDefaultExtension;
    Property UpdateProductDescriptionFromTreeInfo: Boolean Read FbUpdateProductDescriptionFromTreeInfo;
    Property UpdateSalesDescriptionFromTreeInfo: Boolean Read FbUpdateSalesDescriptionFromTreeInfo;
    Property BOMPriceOverridesAllOtherPrice: Boolean Read FbBOMPriceOverridesAllOtherPrice;
    Property IgnoreBOMCalcPriceOnSale: Boolean Read FbIgnoreBOMCalcPriceOnSale;
    Property SubBOMUseAvailableQtyFromStock: Boolean Read FbSubBOMUseAvailableQtyFromStock;
    Property CSPOverridesRawMaterialPrices: Boolean Read FbCSPOverridesRawMaterialPrices;
    property AllowChangingProductAllocationFlags: boolean read fbAllowChangingProductAllocationFlags;
    Property UpdateLinenowhenManufacturingUpdateBatch: Boolean Read FbUpdateLinenowhenManufacturingUpdateBatch;
    property UserSetMainSwitchHeight: integer read fUserSetMainSwitchHeight write SetUserSetMainSwitchHeight;
    property GenerateEmployeeno: boolean read fGenerateEmployeeno;
    property ConfirmProductAutoPriceUpdate: boolean read fConfirmProductAutoPriceUpdate;
    property CostUpdateFromPurchase: boolean read fCostUpdateFromPurchase;
    Property ShowMultiSelectSelectionList: Boolean Read FbShowMultiSelectSelectionList write SetShowMultiSelectSelectionList;
    property UseBankStatements: boolean read fUseBankStatements write fUseBankStatements;
    property SortRelatedProductsinSale: boolean read fSortRelatedProductsinSale write fSortRelatedProductsinSale;
    property CostEditableinSales: boolean read fCostEditableinSales write fCostEditableinSales;
    property DosyncSerialnumberlist: boolean read fDosyncSerialnumberlist write fDosyncSerialnumberlist;
    property ErpApiEnabled: boolean read fErpApiEnabled;
    property ErpApiPort: integer read fErpApiPort;
    property ShowToDoNotifications: boolean read fShowToDoNotifications;
    property DefaultNotifyNewSmartOrder: boolean read fDefaultNotifyNewSmartOrder;
    property DefaultNotifyEditingSmartOrder: boolean read fDefaultNotifyEditingSmartOrder;
    property DefaultShowPOfromSmartOrder: boolean read fDefaultShowPOfromSmartOrder;
    property DefaultSupplierallLinesSmartOrder: boolean read fDefaultSupplierallLinesSmartOrder;
    property ConvertSOIntoPOOnApproval: boolean read fConvertSOIntoPOOnApproval;
    property DefaultNotifyPurchaseOrderChange: boolean read fDefaultNotifyPurchaseOrderChange;
    Property ConfirmQtysOnfinalise: Boolean Read FbConfirmQtysOnfinalise write setConfirmQtysOnfinalise;
    Property EnableWalmart: Boolean Read FbEnableWalmart ;

    Property UpdatebatchRunVS1_sum: Boolean Read FbUpdatebatchRunVS1_sum ;
    Property UpdatebatchRunVS1_PnLReport: Boolean Read FbUpdatebatchRunVS1_PnLReport ;
    Property UpdatebatchRunVS1_PnLReport_Sum: Boolean Read FbUpdatebatchRunVS1_PnLReport_Sum ;
    Property UpdatebatchRunVS1_APReport: Boolean Read FbUpdatebatchRunVS1_APReport ;
    Property UpdatebatchRunVS1_SalesList: Boolean Read FbUpdatebatchRunVS1_SalesList ;
    Property UpdatebatchRunVS1_PQASumList: Boolean Read FbUpdatebatchRunVS1_PQASumList ;
    Property UpdatebatchRunVS1_Sum2: Boolean Read FbUpdatebatchRunVS1_Sum2 ;

    Property EnableMagento                : Boolean   Read getEnableMagento ;
    Property Magento_ShowMagentoOnMainMenu: Boolean   read getMagento_ShowMagentoOnMainMenu  ;
    Property Magento_AutosynchList        : Boolean   read getMagento_AutosynchList          ;
    Property Magento_API_Base_URL         : String    read getMagento_API_Base_URL           ;
    Property Magento_Consumer_Key         : String    read getMagento_Consumer_Key           ;
    Property Magento_Consumer_Secret      : String    read getMagento_Consumer_Secret        ;
    Property Magento_Access_Token         : String    read getMagento_Access_Token           ;
    Property Magento_Access_Token_Secret  : String    read getMagento_Access_Token_Secret    ;
    Property Magento_AdminUserName        : String    read getMagento_AdminUserName          ;
    Property Magento_Companyid            : String    read getMagento_Companyid              ;
    Property Magento_AdminPassword        : String    read getMagento_AdminPassword          ;
    Property Magento_SalesType            : String    read getMagento_SalesType              ;
    Property Magento_CustomerID           : String    read getMagento_CustomerID             ;
    Property IsMagentoSalestypeSO         : Boolean   read getIsMagentoSalestypeSO           ;
    Property IsMagentoSalestypeInv        : Boolean   read getIsMagentoSalestypeInv          ;
    Property ISMagentoCustomerIDName      : Boolean   read getISMagentoCustomerIDName        ;
    Property ISMagentoCustomerIDEmail     : Boolean   read getISMagentoCustomerIDEmail       ;
    Property Magento_SynchPageSize        : Integer   read getMagento_SynchPageSize          ;

    Property EnableAvaTax               : Boolean   Read getEnableAvaTax                ;
    Property AvaTaxCredentialsValidated : Boolean   Read getAvaTaxCredentialsValidated  ;
    Property AvaTax_ShowAvaTaxOnMainMenu: Boolean   read getAvaTax_ShowAvaTaxOnMainMenu ;
    Property AvaTax_AutosynchList       : Boolean   read getAvaTax_AutosynchList        ;
    Property AvaTax_Username            : String    read getAvaTax_Username             ;
    Property AvaTax_Password            : String    read getAvaTax_Password             ;
    Property AvaTax_BaseURL             : String    read getAvaTax_BaseURL              ;
    Property AvaTax_CompanyID           : String    read getAvaTax_CompanyID            ;
    Property AvaTax_AvaTaxSaleCode      : String    read getAvaTax_AvaTaxSaleCode       ;
    Property AvaTax_CompanyCode         : String    read getAvaTax_CompanyCode          ;
    Property AvaTax_AccountType         : String    read getAvaTax_AccountType          ;
    Property IsAvaTaxSandBox            : Boolean   read getIsAvaTaxSandBox             ;
    Property IsAvaTaxProduction         : Boolean   read getIsAvaTaxProduction          ;

    Property UseSeedtoSale                : Boolean   Read getUseSeedtoSale             ;
    Property StSUsesBins                  : Boolean   Read getStSUsesBins               ;
    Property StSSimpleMode                : Boolean   Read getStSSimpleMode             ;
    Property StSPackageTagProduct         : String    read getStSPackageTagProduct      ;
    Property StSPlantTagProduct           : String    read getStSPlantTagProduct        ;
    Property StSSupplier                  : String    read getStSSupplier               ;
    Property StSStockAccount              : String    read getStSStockAccount           ;
    Property EnableSeedtoSale             : boolean   read getEnableSeedtoSale          ;
    Property SeedToSaleStarted            : Boolean   read getSeedToSaleStarted;

    Property VS1useRegioncurrency         : Boolean   Read getVS1useRegioncurrency      ;
    Property VS1DefaultCurrency           : String    read getVS1DefaultCurrency        ;

    Property EnableEbay: Boolean Read HasEbayforThisDB;//FbEnableEbay ;
    Property StatusUpdatedUntil: Tdatetime Read GetStatusUpdatedUntil;//FbEnableEbay ;


    Property ShowWalmartonMainmenubyDefault: Boolean Read FbShowWalmartonMainmenubyDefault  write setShowWalmartonMainmenubyDefault;
    Property ShowEbayonMainMenubyDefault: Boolean Read FbShowEbayonMainMenubyDefault write setShowEbayonMainMenubyDefault;
    Property Walmart_EnableInvFeed: Boolean Read FbWalmart_EnableInvFeed ;
    property TrialBalanceAdjustAccount: integer read fTrialBalanceAdjustAccount write setTrialBalanceAdjustAccount;
    Property EnableWooCommerce: Boolean Read FbEnableWooCommerce write setWooCommerceEnabled;
//    Property HasWooCommerceCredentials: Boolean Read FbHasWooCommerceCredentials ;
    Property ShowWooCommerceonMainmenubyDefault: Boolean Read FbShowWooCommerceonMainmenubyDefault  write setShowWooCommerceonMainmenubyDefault;
//    Property WooCommerce_consumerKey :String read fWooCommerce_consumerKey write SetWooCommerce_consumerKey;
//    Property WooCommerce_consumerSecretKey :String read fWooCommerce_consumerSecretKey write setWooCommerce_consumerSecretKey;
//    Property WooCommerce_URL :String read fWooCommerce_URL write setWooCommerce_URL;
    Property BuildDetailsUpdateOption :String read fBuildDetailsUpdateOption;
    Property BOMDetailsReplacesProductDescriptionMemo :Boolean read getBOMDetailsReplacesProductDescriptionMemo;
    Property BOMDetailsAppendsProductDescriptionMemo :Boolean read getBOMDetailsAppendsProductDescriptionMemo;
    Property IgnoreBOMDetailsUpdateonSales : Boolean read getIgnoreBOMDetailsUpdateonSales;
    Property HasExcelPrices :Boolean read fbHasExcelPrices;
    Property CrosscompanySalesForPOType :String read fCrosscompanySalesForPOType;
    Property CrosscompanySalesForPOTypeDesc : String read getCrosscompanySalesForPOTypeDesc;
//    Property Woocommerce_ProductNameField :String read fWoocommerce_ProductNameField;
//    Property WooCommerce_AutocheckforOrdersinList: Boolean Read FbWooCommerce_AutocheckforOrdersinList ;
    Property GrossWeightnQtyRelated: Boolean Read FbGrossWeightnQtyRelated write setGrossWeightnQtyRelated;
    Property MakeMcforClients: Boolean Read FbMakeMcforClients write fbMakeMcforClients;
    Property DoUpdateProductQtySum: Boolean Read FbDoUpdateProductQtySum write setDoUpdateProductQtySum;
    Property CoreEDIUSerName :String read fCoreEDIUSerName write setCoreEDIUSerName;
    Property CoreEDIPassword :String read fCoreEDIPassword write setCoreEDIPassword;
    Property CoreEDIServiceUSerName :String read fCoreEDIServiceUSerName;
    Property CoreEDIServicePassword :String read fCoreEDIServicePassword write setCoreEDIServicePassword;
    Property CoreEDIServiceHost :String read fCoreEDIServiceHost write setCoreEDIServiceHost;
    Property CoreEDIServicePOrt :Integer read fCoreEDIServicePort write setCoreEDIServicePort;
    property IntuitConfig : TIntuitConfig   read fIntuitConfig;
    property MagentoConfig: TMagentoConfig  read fMagentoConfig;
    property WalmartConfig: TWalmartConfig  read fWalmartConfig;
    property AvaTaxConfig : TAvaTaxConfig   read fAvaTaxConfig;
    property EDIConfig    : TEDIConfig      read fEDIConfig;
    property StSConfig    : TStSConfig      read fStSConfig;
    property VS1Config    : TVS1Config      read fVS1Config;
    Property HasMagentoCredentials: Boolean Read FbHasMagentoCredentials ;
    Property HasWalmartCredentials: Boolean Read FbHasWalmartCredentials ;
    Property HasAvaTaxCredentials : Boolean Read FbHasAvaTaxCredentials ;

    Property WALMART_AutocheckforOrdersinList: Boolean Read FbWALMART_AutocheckforOrdersinList ;
    Property WALMART_AutoUpdateProductQty: Boolean Read FbWALMART_AutoUpdateProductQty ;
    Property WALMART_IgnoreTaxonSale: Boolean Read FbWALMART_IgnoreTaxonSale ;
    Property Walmartcustomer :String read fWalmartcustomer;
    Property WALMART_ConsumerId :String read fWALMART_ConsumerId;
    Property WALMART_PrivateKey :String read fWALMART_PrivateKey;
    Property WALMART_ChannelType :String read fWALMART_ChannelType;
    Property WALMART_ProductNameField :String read fWALMART_ProductNameField;
    Property WALMART_ProductNameFieldNAme :String read getWALMART_ProductNameFieldNAme;
    Property WALMARTOrderSilentProcessShipment: Boolean Read FbWALMARTOrderSilentProcessShipment ;

    Property WalmartclientID                :String read GetWalmartclientID ;
    Property WalmartclientSecret            :String read GetWalmartclientSecret ;
    Property WalmartsynchAccount            :String read GetWalmartsynchAccount ;
    Property WalmartsynchAccountDescription :String read GetWalmartsynchAccountDescription ;
    Property Walmart_OrdersSynchedUntil     :Tdatetime read getWalmart_OrdersSynchedUntil;
    Property WalmartTokenURL                :String read GetWalmartToken_URL ;
    Property Walmart_Order_Released_URL      :String read getWalmart_Order_Released_URL;
    Property Walmart_Order_Released_Cont_URL :String read getWalmart_Order_Released_Cont_URL;
    Property Walmart_Order_All_URL           :String read getWalmart_Order_All_URL;
    Property Walmart_Order_All_cont_URL      :String read getWalmart_Order_All_cont_URL;
    Property Walmart_Order_Single_URL        :String read getWalmart_Order_Single_URL;
    Property Walmart_Order_Ack_URL           :String read getWalmart_Order_Ack_URL;
    Property Walmart_Order_Cancel_URL        :String read getWalmart_Order_Cancel_URL;
    Property Walmart_Order_Refund_URL        :String read getWalmart_Order_Refund_URL;
    Property Walmart_Order_Shipping_URL      :String read getWalmart_Order_Shipping_URL;
    Property Walmart_FeedStatus_URL          :String read getWalmart_FeedStatus_URL;
    Property EnableJobKeepersAllowance[Paydate:Tdatetime=0]       : Boolean   Read getEnableJobKeepersAllowance           ;

    Property ShowSaturdayinApptCalendar   : Boolean Read fbShowSaturdayinApptCalendar;
    Property ShowSundayinApptCalendar     : Boolean Read fbShowSundayinApptCalendar;
    Property ShowMondayinApptCalendar     : Boolean Read fbShowMondayinApptCalendar;
    Property ShowTuesdayinApptCalendar    : Boolean Read fbShowTuesdayinApptCalendar;
    Property ShowWednesdayinApptCalendar  : Boolean Read fbShowWednesdayinApptCalendar;
    Property ShowThursdayinApptCalendar   : Boolean Read fbShowThursdayinApptCalendar;
    Property ShowFridayinApptCalendar     : Boolean Read fbShowFridayinApptCalendar;
    Property ApptStartTime                : String  Read FsApptStartTime;
    Property ApptEndtime                  : String  Read FsApptEndtime;
    Property DefaultApptDuration          : Integer Read fiDefaultApptDuration;
    Property RoundApptDurationTo          : Integer Read fiRoundApptDurationTo;
    Property ShowApptDurationin           : Integer Read fiShowApptDurationin;
    Property DefaultServiceProductID      : Integer Read fiDefaultServiceProductID;
    Property DefaultServiceProduct        : String  Read getDefaultServiceProduct;
    Property NonERPClone_User             : String  Read FsNonERPClone_User;
    Property NonERPClone_Password         : String  Read FsNonERPClone_Password;
    property OneSidedJournal              : Boolean read fOneSidedJournal write fOneSidedJournal;
  End;

Implementation

Uses
  SysUtils, CommonDbLib, DateUtils, CommonLib, AppEnvironment, TcDataUtils, TcConst, TcTypes, RegEdit, PreferenceLib, GraphUtil, SystemLib, ShlObj, StringUtils,
  PreferancesLib, ConfigReaderLib, DbSharedObjectsObj, MySQLConst;

Constructor TCompanyPrefObj.Create;
Begin
  Inherited;
  QryPrefs     := Nil;
  FPrefConvert := TPrefConvert.Create;

  FbMonitorTransactionEvents := False;
{$IFDEF MonitorTransactionEvents}
  FbMonitorTransactionEvents := True;

{$ENDIF}
  FSMSConfig := TSMSConfig.Create;
  FUPSConfig := TUPSConfig.Create;
  FFedExConfig := TFedExConfig.Create;
  FUSPSConfig := TUSPSConfig.Create;
  fSPSConfig := TSPSConfig.Create;
  fAmazonConfig := TAmazonConfig.Create;
  fGoogleCalendarConfig := TGoogleCalendarConfig.Create;
  fPasswordConfig := TPasswordConfig.Create;
  fHMRC_APIConfig := THMRC_APIConfig.Create;
  fIntuitConfig   := TIntuitConfig.Create;
  fMagentoConfig  := TMagentoConfig.Create;
  fWalmartConfig  := TWalmartConfig.Create;
  fAvaTaxConfig   := TAvaTaxConfig.Create;
  fEDIConfig      := TEDIConfig.Create;
  fStSConfig      := TStSConfig.Create;
  fVS1Config      := TVS1Config.Create;
End;

Destructor TCompanyPrefObj.Destroy;
Begin
  Inherited;
  FreeAndNil(FPrefConvert);
  FSMSConfig.Free;
  FUPSConfig.Free;
  FFedExConfig.Free;
  FUSPSConfig.Free;
  fSPSConfig.Free;
  fHMRC_APIConfig.Free;
  fAmazonConfig.Free;
  fGoogleCalendarConfig.Free;
  fPasswordConfig.Free;
  fIntuitConfig.Free;
  fMagentoConfig.Free;
  fWalmartConfig.Free;
  fAvaTaxConfig.Free;
  fEDIConfig.Free;
  fStSConfig.Free;
  fVS1Config.Free;
End;

Function TCompanyPrefObj.FieldByName(Const FieldName: String): TPrefConvert;
Begin
  Result := FPrefConvert;
  If Not Assigned(FPrefConvert) Then Exit;

  FPrefConvert.FoundRecord := False;

  If Assigned(QryPrefs) And (Not QryPrefs.IsEmpty) Then Begin
    FPrefConvert.FoundRecord := QryPrefs.Locate('Name', FieldName, [LoCaseInsensitive]);
    FPrefConvert.Query       := QryPrefs;
  End;
End;

Function TCompanyPrefObj.GetUseCostCentres: Boolean;
Begin
  Result := FbUseCostCentres;
End;
function TCompanyPrefObj.getUseSinglePersonApproval: Boolean;begin   result := ApprovalType ='A'; end;
function TCompanyPrefObj.getUseSteppedApproval: Boolean;begin   Result := ApprovalType ='M'; end;

function TCompanyPrefObj.getWALMART_ProductNameFieldNAme: String;
begin
       if fWALMART_ProductNameField ='P' then result := 'ProductName'
  else if fWALMART_ProductNameField ='S' then result := 'SKU'(*
  else if fWALMART_ProductNameField ='U' then result := 'UPC'
  else if fWALMART_ProductNameField ='G' then result := 'GTIN'
  else if fWALMART_ProductNameField ='W' then result := 'WPID'*)
  else REsult := 'ProductName';
end;

function TCompanyPrefObj.getWholeSaleCustomerTypes: String;
begin
  result := '';
  if WholeSaleCustomerType1 <> '' then begin if result <> '' then result := result +','+NL; result := result + WholeSaleCustomerType1; end;
  if WholeSaleCustomerType2 <> '' then begin if result <> '' then result := result +','+NL; result := result + WholeSaleCustomerType2; end;
  if WholeSaleCustomerType3 <> '' then begin if result <> '' then result := result +','+NL; result := result + WholeSaleCustomerType3; end;
  if WholeSaleCustomerType4 <> '' then begin if result <> '' then result := result +','+NL; result := result + WholeSaleCustomerType4; end;
end;

function TCompanyPrefObj.HasEbayforThisDB: Boolean;
begin
  result := HasEbayforDB(CommonDbLib.GetSharedMyDacConnection.Database);
end;
function TCompanyPrefObj.GetStatusUpdatedUntil:TDateTime;
begin
  result := StatusUpdatedUntilforDB(CommonDbLib.GetSharedMyDacConnection.Database);
end;
Procedure TCompanyPrefObj.LoadHoursFromRoster(Const LoadHours: Boolean);
Var
  IResult: Integer;
Begin
  Inherited;
  QryPrefs                     := TERPQuery.Create(Nil);
  QryPrefs.Options.FlatBuffers := True;
  Try
    QryPrefs.Connection := CommonDbLib.GetSharedMyDacConnection;
    QryPrefs.SQL.Clear;
    QryPrefs.SQL.Add('SELECT * FROM tbldbpreferences');
    QryPrefs.Open;

    If LoadHours Then Begin
      If UseClockedHrs Then Begin
        IResult := CommonLib.MessageDlgXP_Vista('Would you like to Ignore Early Starts and Late Finishes?' + #13 + #10 + #13 + #10 +
          'Press YesToAll Button to Ignore Both, OK Button to Ignore only Early Starts or the CANCEL button to NOT ignore any.', MtConfirmation, [MbYesToAll, MbOK, MbCancel], 0);
        Case IResult Of
          MrYesToAll: Begin
              FieldByName('IgnoreEarlyStart').AsBoolean := True;
              FieldByName('IgnoreLateFinish').AsBoolean := True;
            End;

          MrOk: Begin
              FieldByName('IgnoreEarlyStart').AsBoolean := True;
              FieldByName('IgnoreLateFinish').AsBoolean := False;
            End;

          MrCancel: Begin
              FieldByName('IgnoreEarlyStart').AsBoolean := False;
              FieldByName('IgnoreLateFinish').AsBoolean := False;
            End;
        End;

        AppEnv.CompanyPrefs.PopulateMe;
      End;
    End;
  Finally FreeAndNil(QryPrefs);
  End;
End;

procedure TCompanyPrefObj.PopulateFenames;
var
  QryFenames  : TERPQuery;
begin
  fsFe1Name :='';
  fsFe2Name :='';
  fsFe3Name :='';
  fsFe4Name :='';
  fsFe5Name :='';
  fsFeQtyField :='';

  QryFenames  := TERPQuery.Create(Nil);
  try
    Qryfenames.Connection := CommonDbLib.GetSharedMyDacConnection;
    Qryfenames.SQL.Text := 'select * from tblfenames';
    OpenDb(Qryfenames);

    fbFe1Visible := False;
    fbFe2Visible := False;
    fbFe3Visible := False;
    fbFe4Visible := False;
    fbFe5Visible := False;

    if Qryfenames.recordcount >=1 then begin Qryfenames.First;fsFe1Name :=Qryfenames.FieldByName('formulaentryname').AsString;  fbFe1Visible :=Qryfenames.FieldByName('Active').AsBoolean; if Qryfenames.FieldByName('IsQtyfield').AsBoolean then fsFeQtyField := fsFe1Name;  end;
    if Qryfenames.recordcount >=2 then begin Qryfenames.Next ;fsFe2Name :=Qryfenames.FieldByName('formulaentryname').AsString;  fbFe2Visible :=Qryfenames.FieldByName('Active').AsBoolean; if Qryfenames.FieldByName('IsQtyfield').AsBoolean then fsFeQtyField := fsFe2Name;  end;
    if Qryfenames.recordcount >=3 then begin Qryfenames.Next ;fsFe3Name :=Qryfenames.FieldByName('formulaentryname').AsString;  fbFe3Visible :=Qryfenames.FieldByName('Active').AsBoolean; if Qryfenames.FieldByName('IsQtyfield').AsBoolean then fsFeQtyField := fsFe3Name;  end;
    if Qryfenames.recordcount >=4 then begin Qryfenames.Next ;fsFe4Name :=Qryfenames.FieldByName('formulaentryname').AsString;  fbFe4Visible :=Qryfenames.FieldByName('Active').AsBoolean; if Qryfenames.FieldByName('IsQtyfield').AsBoolean then fsFeQtyField := fsFe4Name;  end;
    if Qryfenames.recordcount >=5 then begin Qryfenames.Next ;fsFe5Name :=Qryfenames.FieldByName('formulaentryname').AsString;  fbFe5Visible :=Qryfenames.FieldByName('Active').AsBoolean; if Qryfenames.FieldByName('IsQtyfield').AsBoolean then fsFeQtyField := fsFe5Name;  end;

    // if qty field is not assigned, by default its the 4th field. If 4ith field not visible , the last one visible
    if fsFeQtyField = '' then begin
      if Qryfenames.recordcount >=1 then begin Qryfenames.First;if fbFe1Visible then fsFeQtyField := fsFe1Name;  end;
      if Qryfenames.recordcount >=2 then begin Qryfenames.Next ;if fbFe2Visible then fsFeQtyField := fsFe2Name;  end;
      if Qryfenames.recordcount >=3 then begin Qryfenames.Next ;if fbFe3Visible then fsFeQtyField := fsFe3Name;  end;
      if Qryfenames.recordcount >=4 then begin Qryfenames.Next ;if fbFe4Visible then fsFeQtyField := fsFe4Name;  end;
      if fsFeQtyField = '' then if Qryfenames.recordcount >=5 then begin Qryfenames.Next ;if fbFe5Visible then fsFeQtyField := fsFe5Name;  end;
    end;

  finally
    FreeAndNil(QryFenames);
  end;

end;
Procedure TCompanyPrefObj.PopulateMe;
begin
  doPopulateMe;
  if (FbIncludeUnInvoicedPOtoGL) and (FiUnInvoicedPOAccount =0) then
    MessageDlgXP_vista('Please Note that You Have Selected ''Include Un Invoiced PO to GL'' and haven''t Selected the Account For Un-Invoiced PO Posting.'+chr(13)+chr(13)+
                       'Please Choose that in Preference - Purchases.', mtWarning, [mbOK], 0);
end;
Procedure TCompanyPrefObj.doPopulateMe;
Var
  TmpYear, TmpMonth, TmpDay: Word;
  LockMessage              : String;
Begin
  QryPrefs                     := TERPQuery.Create(Nil);
  QryPrefs.Options.FlatBuffers := True;
  Try
    With FSMSConfig             do Load(CommonDbLib.GetSharedMyDacConnection);
    With FUPSConfig             do Load(CommonDbLib.GetSharedMyDacConnection);
    With FFedExConfig           do Load(CommonDbLib.GetSharedMyDacConnection);
    With FUSPSConfig            do Load(CommonDbLib.GetSharedMyDacConnection);
    With FSPSConfig             do Load(CommonDbLib.GetSharedMyDacConnection);
    With fHMRC_APIConfig        do Load(CommonDbLib.GetSharedMyDacConnection);
    With FAmazonConfig          do Load(CommonDbLib.GetSharedMyDacConnection);
    With fPasswordConfig        do Load(CommonDbLib.GetSharedMyDacConnection);
    With fGoogleCalendarConfig  do Load(CommonDbLib.GetSharedMyDacConnection);
    With fIntuitConfig          do Load(CommonDbLib.GetSharedMyDacConnection);
    With fMagentoConfig         do Load(CommonDbLib.GetSharedMyDacConnection);
    With fStSConfig             do Load(CommonDbLib.GetSharedMyDacConnection);
    With fAvaTaxConfig          do Load(CommonDbLib.GetSharedMyDacConnection);
    With fVS1Config             do Load(CommonDbLib.GetSharedMyDacConnection);
    fEDIConfig.Load(CommonDbLib.GetSharedMyDacConnection);
    FbHasMagentoCredentials :=  (fMagentoConfig.EnableMagento) and
                                (fMagentoConfig.API_Base_URL        <>'') and
                                (fMagentoConfig.Consumer_Key        <>'') and
                                (fMagentoConfig.Consumer_Secret     <>'') and
                                (fMagentoConfig.Access_Token        <>'') and
                                (fMagentoConfig.Access_Token_Secret <>'') and
                                (fMagentoConfig.AdminUserName       <>'') and
                                (fMagentoConfig.Companyid           <>'') and
                                (fMagentoConfig.AdminPassword       <>'');

    FbHasAvaTaxCredentials  :=  (fAvaTaxConfig.EnableAvaTax) and
                                 (fAvaTaxConfig.CredentialsValidated) and
                                 (fAvaTaxConfig.CompanyID    <>'') and
                                 (fAvaTaxConfig.CompanyCode  <>'') and
                                 (fAvaTaxConfig.Username     <>'') and
                                 (fAvaTaxConfig.Password     <>'') ;

    With fWalmartConfig         do Load(CommonDbLib.GetSharedMyDacConnection);
    FbHasWalmartCredentials :=  (fWalmartConfig.EnableWalmart) and
                                (WalmartclientID<>'') and
                                (WalmartclientSecret<>'');
    QryPrefs.Connection := CommonDbLib.GetSharedMyDacConnection;
    QryPrefs.SQL.Text   := 'SELECT * FROM tbldbpreferences';
    QryPrefs.Open;
    FbDefaultRepUser                := FieldByName('DefaultRepUser').AsBoolean;
    FbWholeSaleToggleON             := False; // FieldByName('WholeSaleToggleON').AsBoolean;
    FdWholesalePercentag            := FieldByName('WholesalePercentag').AsFloat;
    FbReceiptPrinterON              := FieldByName('ReceiptPrinterON').AsBoolean;
    FbSingleQtySO                   := FieldByName('SingleQtySO').AsBoolean;
    FbSoToInvShipWhenAvailable      := FieldByName('SoToInvShipWhenAvailable').AsBoolean;
    FbMultiTills                    := FieldByName('MultiTills').AsBoolean;
    FbMultiSalesPerson              := FieldByName('MultiSalesPerson').AsBoolean;
    FbMustProvidePOSPostCode        := FieldByName('MustProvidePOSPostCode').AsBoolean;
    FbMustProvideDetailsforCashout  := FieldByName('MustProvideDetailsforCashout').AsBoolean;
    FbMustProvidePOSSource          := FieldByName('MustProvidePOSSource').AsBoolean;
    FbAutoBackup                    := FieldByName('AutoBackup').AsBoolean;
    fbBackupAfterUpdateCheck        := FieldByName('BackupAfterRestart').AsBoolean;
    FbDisableCusSourceTracking      := FieldByName('DisableCusSourceTracking').AsBoolean;
    FbUniqueCustomerPONumInSale     := FieldByName('UniqueCustomerPONumInSale').AsBoolean;
    FsCopySalesOrderShiptotoRepairs := FieldByName('CopySalesOrderShiptotoRepairs').AsString;
    FbExcludeBOFromPrintinSales     := FieldByName('ExcludeBOFromPrintinSales').AsBoolean;
    FbExcludeBOFromPrintinPO        := FieldByName('ExcludeBOFromPrintinPO').AsBoolean;
    FbPrintBestPractices      := FieldByName('PrintBestPractices').AsBoolean;
    FbShowInvoiceFormwhenRepairInvoiced := FieldByName('ShowInvoiceFormwhenRepairInvoiced').AsBoolean;
    FdMaxDiscountPercentage   := FieldByName('MaxDiscountPercentage').AsFloat;
    FdMinMarkupPercentage     := FieldByName('MinMarkupPercentage').AsFloat;
    FdMinimumMarginPercentage := FieldByName('MinimumMarginPercentage').AsFloat;

    FiRoundUp           := FieldByName('RoundUp').AsInteger;
    FdRoundLotsof       := FieldByName('RoundLotsof').AsFloat;
    FbRoundLotsnRoundup := FieldByName('RoundLotsnRoundup').AsBoolean;

    FiProductPriceRoundUp           := FieldByName('ProductPriceRoundUp').AsInteger;
    FiProductPriceRoundLotsof       := FieldByName('ProductPriceRoundLotsof').AsInteger;
    FbProductPriceRoundLotsnRoundup := FieldByName('ProductPriceRoundLotsnRoundup').AsBoolean;

    /// fbRoundLots        := FieldByName('RoundLots').asBoolean;
    /// fbRoundup5Cents    := FieldByName('Roundup5Cents').asBoolean;
    /// if fbRoundup5Cents then  if fiRoundUp =0 then fiRoundUp := 3;
    /// if fbRoundLots     then  if fdRoundLotsof = 0 then fdRoundLotsof := 0.25;
    FiRoundUpPoints                             := FieldByName('RoundUpPoints').AsInteger;
    If FiRoundUpPoints < 0 Then FiRoundUpPoints := 0;
    If FbRoundLotsnRoundup Then Begin
      If FdRoundLotsof = 0 Then FdRoundLotsof      := 0.025;
      If FiRoundUpPoints <= 0 Then FiRoundUpPoints := 1;
    End;
    FiDefaultSuppPaymentAccount  := FieldByName('DefaultSuppPaymentAccount').AsInteger;
    FiAPTerms1                   := FieldByName('APTerms1').AsInteger;
    FiDefaultCCardPaymentAccount := FieldByName('DefaultCCardPaymentAccount').AsInteger;
    FiAPTerms3                   := FieldByName('APTerms3').AsInteger;
    FiDefaultCustPaymentAccount  := FieldByName('DefaultCustPaymentAccount').AsInteger;
    FsInvoice_footer             := FieldByName('Invoice_footer').AsString;
    FsLaybyTerms                 := FieldByName('LaybyTerms').AsString;
    FsReceiptFooter              := FieldByName('ReceiptFooter').AsString;
    FsPOSRewardPointTemplate     := FieldByName('POSRewardPointTemplate').AsString;
    FsReceiptPrinterType         := FieldByName('ReceiptPrinterType').AsString;
    FsUSBPrinterName             := FieldByName('USBPrinterName').AsString;
    FbPrintPOSTemplateReport     := FieldByName('PrintPOSTemplateReport').AsBoolean;
    FsReceiptPrinterPort         := FieldByName('ReceiptPrinterPort').AsString;
    FdtClosingDate               := EndOfTheDay(FieldByName('ClosingDate').AsDateTime);
    FdtClosingDateAP             := EndOfTheDay(FieldByName('ClosingDateAP').AsDateTime);
    FdtClosingDateAR             := EndOfTheDay(FieldByName('ClosingDateAR').AsDateTime);
    FiCreditTermsID              := FieldByName('CreditTermsID').AsInteger;
    FiDebitTermsId               := FieldByName('DebitTermsId').AsInteger;
    FrCreditLimit                := FieldByName('CreditLimit').AsCurrency;
    FrMaxSmartAmount             := FieldByName('MaxSmartAmount').AsCurrency;
    fiTotalvolumeUOMInsmartOrder := fieldByname('TotalvolumeUOMInsmartOrder').AsInteger;
    fsUOMforTotalvolumeInsmartOrder := fieldbyname('UOMforTotalvolumeInsmartOrder').AsString;
    FiGracePeriod                := FieldByName('GracePeriod').AsInteger;
    FiDefaultSalesAccount        := FieldByName('DefaultSalesAccount').AsInteger;
    FiDefaultPurchasesAccount    := FieldByName('DefaultPurchasesAccount').AsInteger;
    FiFollowupDays               := FieldByName('FollowupDays').AsInteger;
    FbFastProductList            := FieldByName('FastProductList').AsBoolean;
    FbDisableNotifyLists         := FieldByName('DisableNotifyLists').AsBoolean;
    FdMinAboveCost               := FieldByName('MinAboveCost').AsFloat;
    FiDefaultSPAAccount          := FieldByName('DefaultSPAAccount').AsInteger;
    FiDefaultDepositsAccount     := FieldByName('DefaultDepositsAccount').AsInteger;
    FiDefPartsCOGSAccount        := FieldByName('DefPartsCOGSAccount').AsInteger;
    FiDefPartsAssetAccount       := FieldByName('DefPartsAssetAccount').AsInteger;
    FiDefPartsIncomeAccount      := FieldByName('DefPartsIncomeAccount').AsInteger;
    FsDefaultPurchaseTaxCode     := FieldByName('DefaultPurchaseTaxCode').AsString;
    // fiQtyRoundTo := FieldByname('QtyRoundTo').asInteger;
    // if fiQtyRoundTo = 0 then fiQtyRoundTo := 5;
    FsDefaultSalesTaxCode          := FieldByName('DefaultSalesTaxCode').AsString;
    FsPickupShipingMethod          := FieldByName('PickupShipingMethod').AsString;
    FsCommittedStatus              := FieldByName('CommittedStatus').AsString;
    FbPrintBarcodesOnReceival      := FieldByName('PrintBarcodesOnReceival').AsBoolean;
    FiDefaultChequeAccount         := FieldByName('DefaultChequeAccount').AsInteger;
    FbValidateAllocation           := FieldByName('ValidateAllocation').AsBoolean;
    FbEnforceAllocationValidation  := FieldByName('EnforceAllocationValidation').AsBoolean;
    FbEnforceAllocationValidationinPI  := FieldByName('EnforceAllocationValidationinPI').AsBoolean;
    FbResetSaleDateWhenBuilt       := FieldByName('ResetSaleDateWhenBuilt').AsBoolean;
    //FbDefaultCoupenTimeinWOTimesheet  := FieldByName('DefaultCoupenTimeinWOTimesheet').AsBoolean;
    FbPrintStoreAwayOnReceival     := FieldByName('PrintStoreAwayOnReceival').AsBoolean;
    FbUsePayroll                   := FieldByName('UsePayroll').AsBoolean;
    FbUseGoogleAnalytics           := FieldByName('UseGoogleAnalytics').AsBoolean;
    FsSupplierforautoPostingGoogle := FieldByName('SupplierforautoPostingGoogle').AsString;
    FbPOSPassword                  := FieldByName('POSPassword').AsBoolean;
    FbPOSCreateOrders              := FieldByName('POSCreateOrders').AsBoolean;
    FbNoPreferredSuppQuestion      := FieldByName('NoPreferredSuppQuestion').AsBoolean;
    FbNoCustSpecialPriceQuestion   := FieldByName('NoCustSpecialPriceQuestion').AsBoolean;
    FbNoCashCustSpecialPriceQuestion   := FieldByName('NoCashCustSpecialPriceQuestion').AsBoolean or FieldByName('NoCustSpecialPriceQuestion').AsBoolean;
    FbAutoPickBins           := FieldByName('AutoPickBins').AsBoolean;
    FbAutoPickBatches        := FieldByName('AutoPickBatches').AsBoolean;
    FbShowSalesUnits         := FieldByName('ShowSalesUnits').AsBoolean;
    FbShowSalesCostInc       := FieldByName('ShowSalesCostInc').AsBoolean;
    FbShowPurchasecostinSales       := FieldByName('ShowPurchasecostinSales').AsBoolean;
    FbShowSalesDescription   := FieldByName('ShowSalesDescription').AsBoolean;
    FbShowSalesProfit        := FieldByName('ShowSalesProfit').AsBoolean;
    FbShowSalesProfitPercent := FieldByName('ShowSalesProfitPercent').AsBoolean;
    FbShowSalesTaxCode       := FieldByName('ShowSalesTaxCode').AsBoolean;
    FbShowSalesTaxAmount     := FieldByName('ShowSalesTaxAmount').AsBoolean;
    FbShowSalesDiscount      := FieldByName('ShowSalesDiscount').AsBoolean;
    FbShowPurchUnits         := FieldByName('ShowPurchUnits').AsBoolean;
    FbShowPurchCustJob       := FieldByName('ShowPurchCustJob').AsBoolean;
    FbShowPurchDescription   := FieldByName('ShowPurchDescription').AsBoolean;
    FbShowPurchClass         := FieldByName('ShowPurchClass').AsBoolean;
    FbShowPurchTaxCode       := FieldByName('ShowPurchTaxCode').AsBoolean;
    FbUseFuturePO            := FieldByName('UseFuturePO').AsBoolean;
    FiFuturePODays           := FieldByName('FuturePODays').AsInteger;
    // fbShowTaxwithNostate := FieldByName('ShowTaxwithNostate').AsBoolean;
    FbfilterTaxcodeforClient                  := FieldByName('filterTaxcodeforClient').AsBoolean;
    FbShowAllocationBatchExpiryDate           := FieldByName('ShowAllocationBatchExpiryDate').AsBoolean;
    FbShowAllocationBatchTruckLoadNo          := FieldByName('ShowAllocationBatchTruckLoadNo').AsBoolean;
    fsAllocationBatchTruckLoadNoGenerateMode  := FieldByname('AllocationBatchTruckLoadNoGenerateMode').AsString;
    FbAllowToPickFromOtherslaesIntheGroup     := FieldByName('AllowToPickFromOthersalesIntheGroup').AsBoolean;
    FbAllowtoshipnPickFromBackorderinthegroup := FieldByName('AllowtoshipnPickFromBackorderinthegroup').AsBoolean;
    FbShowPurchTaxAmount                      := FieldByName('ShowPurchTaxAmount').AsBoolean;
    FbCreditCheckInv                          := FieldByName('CreditCheckInv').AsBoolean;
    FbCreditCheckSO                           := FieldByName('CreditCheckSO').AsBoolean;
    FbCreditCheckPO                           := FieldByName('CreditCheckPO').AsBoolean;
    FbCreditcheckPOIncludeBO                  := FieldByName('CreditcheckPOIncludeBO').AsBoolean;
    FsProductAttrib1Name                      := FieldByName('ProductAttrib1Name').AsString;
    FsAreaColumnName                          := FieldByName('AreaColumnName').AsString;
    FsProductAttrib2Name                      := FieldByName('ProductAttrib2Name').AsString;
    FsProductAttrib3Name                      := FieldByName('ProductAttrib3Name').AsString;
    FsSalesDefaultValueForAreaFrom            := FieldByName('SalesDefaultValueForAreaFrom').AsString;
    FsPODefaultValueForAreaFrom               := FieldByName('PODefaultValueForAreaFrom').AsString;
    FbShowProductAttributes                   := FieldByName('ShowProductAttributes').AsBoolean;
    FbShowProductOptions                      := FieldByName('ShowProductOptions').AsBoolean;
    FbYodleeEnabled                           := FieldByName('YodleeEnabled').AsBoolean;
    FbMagentoEnabled                          := FieldByName('MagentoEnabled').AsBoolean;
    FbShowMagentoOnMainMenu                   := FieldByName('ShowMagentoOnMainMenu').ASBoolean;
    FiSmartOrderbasedOn                       := FieldByName('SmartOrderbasedOn').AsInteger;
    FbShowMeasurementAttributes               := FieldByName('ShowMeasurementAttributes').AsBoolean;
    FbShowProductExtraAttributes              := FieldByName('ShowProductExtraAttributes').AsBoolean;
//    FiTransLinesToDisableCalcs                := FieldByName('TransLinesToDisableCalcs').AsInteger;
    FiSaleLinesToDisableCalcs                 := FieldByName('SaleLinesToDisableCalcs').AsInteger;
    FiExpenseLinesToDisableCalcs              := FieldByName('ExpenseLinesToDisableCalcs').AsInteger;
    FiCustPayLinesToDisableCalcs              := FieldByName('CustPayLinesToDisableCalcs').AsInteger;
    FiSuppPayLinesToDisableCalcs              := FieldByName('SuppPayLinesToDisableCalcs').AsInteger;
    FiOrderLinesToDisableCalcs                := FieldByName('OrderLinesToDisableCalcs').AsInteger;
    FiNoOfAttribstodisplay                    := FieldByName('NoOfAttribstodisplay').AsInteger;
    FsPrimaryPrinter                          := FieldByName('PrimaryPrinter').AsString;
    FdHoursPerWeek                            := FieldByName('HoursPerWeek').AsFloat;
    If FdHoursPerWeek = 0 Then FdHoursPerWeek := 38; { Stop Div by zero Error }
    FdALeaveWeeks                             := FieldByName('ALeaveWeeks').AsFloat;
    FdSickLeaveDays                           := FieldByName('SickLeaveDays').AsFloat;
    FdLSLWeeks                                := FieldByName('LSLWeeks').AsFloat;
    FdLSLCommenceYears                        := FieldByName('LSLCommenceYears').AsFloat;
    FbPOSRestrictRefund                       := FieldByName('POSRestrictRefund').AsBoolean;
    FbRestrictRefund                          := FieldByName('RestrictRefund').AsBoolean;
    FbPOSHideLaybyRcptAmnt                    := FieldByName('POSHideLaybyRcptAmnt').AsBoolean;
    FbPOSHideSalesRcptAmnt                    := FieldByName('POSHideSalesRcptAmnt').AsBoolean;
    FbCombinedInvoiceBO                       := FieldByName('CombinedInvoiceBO').AsBoolean;
    // fbCombinedSaleOrderBO := FieldByName('CombinedSaleOrderBO').AsBoolean;
    // as converting the SO should convert all its BO, its not possible to convert a SO with a combined BO, so disable this pref
    FbCombinedSaleOrderBO   := False;
    FbUseAutoChequeNo       := FieldByName('UseAutoChequeNo').AsBoolean;
    FbUseGroupedPOSDeposits := FieldByName('UseGroupedPOSDeposits').AsBoolean;
    FbSpecProd_Override_Disc                     := FieldByName('SpecProd_Override_Disc').AsBoolean;
    FbUseForeignCurrencyonPO                     := FieldByName('UseForeignCurrencyonPO').AsBoolean;
    FbEnforceConNoteOnPO                         := FieldByName('EnforceConNoteOnPO').AsBoolean;
    FbEnforceConNoteOnRA                         := FieldByName('EnforceConNoteOnRA').AsBoolean;
    FbIncludeLandedCostsinAvgCost                := FieldByName('IncludeLandedCostsinAvgCost').AsBoolean;
    FbUseFixedAssets                             := FieldByName('UseFixedAssets').AsBoolean;
    FbUseShippedDateForTerms                     := FieldByName('UseShippedDateForTerms').AsBoolean;
    FbAllowchangeofTermAfterDueDate              := FieldByName('AllowchangeofTermAfterDueDate').AsBoolean;
    FiShippedDaysAfterCreate                     := FieldByName('ShippedDaysAfterCreate').AsInteger;
    FichequeTemplate_NoofLinesinDetailSection    := FieldByName('chequeTemplate_NoofLinesinDetailSection').AsInteger;
    FbPrintPickSlipWithInvoice                   := FieldByName('PrintPickSlipWithInvoice').AsBoolean;
    FbPrintDelDocketWithInvoice                  := FieldByName('PrintDelDocketWithInvoice').AsBoolean;
    FbUseManifest                                := FieldByName('UseManifest').AsBoolean;
    FiManifestDaysAfterDespatchDate              := FieldByName('ManifestDaysAfterDespatchDate').AsInteger;
    FbAutoEditInvoiceBarcodePick                 := FieldByName('AutoEditInvoiceBarcodePick').AsBoolean;
    FbPrintInvoiceBarcodePick                    := FieldByName('PrintInvoiceBarcodePick').AsBoolean;
    FbPrintDelDocketBarcodePick                  := FieldByName('PrintDelDocketBarcodePick').AsBoolean;
    FbPrintConNotesBarcodePick                   := FieldByName('PrintConNotesBarcodePick').AsBoolean;
    FbAutoAddBarcodes                            := FieldByName('AutoAddBarcodes').AsBoolean;
    FbPhoneNumberFormatting                      := FieldByName('PhoneNumberFormatting').AsBoolean;
    FbCustomerABNFormating                       := FieldByName('CustomerABNFormating').AsBoolean;
    FbConvertConvertedSmartOrder                 := FieldByName('ConvertConvertedSmartOrder').AsBoolean;
    FbConvertConvertedSalesOrder                 := FieldByName('ConvertConvertedSalesOrder').AsBoolean;
    FbPOMatchLineETAToHeaderETA                  := FieldByName('POMatchLineETAToHeaderETA').AsBoolean;
    FbPOMatchLineETAToShippingContainerETA       := FieldByName('POMatchLineETAToShippingContainerETA').AsBoolean;
    FbWarnWhenSalesCreationdateisfuture          := FieldByName('WarnWhenSalesCreationdateisfuture').AsBoolean;
    fbLogchangingDetailsonServicePadFeedback     := FieldByName('LogchangingDetailsonServicePadFeedback').asBoolean;
    fbLogchangingDetailsonRepairsFeedback        := FieldByName('LogchangingDetailsonRepairsFeedback').asBoolean;
    fbLogchangingDetailsonRepairsNotes           := FieldByName('LogchangingDetailsonRepairsNotes').asBoolean;
    fbLogchangingDetailsonSupportPricingNotes    := FieldByName('LogchangingDetailsonSupportPricingNotes').asBoolean;
    fbLogchangingDetailsonSupplierfollowupNotes  := FieldByName('LogchangingDetailsonSupplierfollowupNotes').asBoolean;
    fbLogchangingDetailsonchequecomments         := FieldByName('LogchangingDetailsonchequecomments').asBoolean;
    fbLogchangingDetailsonchequeInternalcomments := FieldByName('LogchangingDetailsonchequeInternalcomments').asBoolean;
    fbLogchangingDetailsonCustPayComments        := FieldByName('LogchangingDetailsonCustPayComments').asBoolean;
    fbLogchangingDetailsonDepositEntryNotes      := FieldByName('LogchangingDetailsonDepositEntryNotes').asBoolean;
    fbLogchangingDetailsonDepositNotes           := FieldByName('LogchangingDetailsonDepositNotes').asBoolean;
    fbLogchangingDetailsonSuppPayNotes           := FieldByName('LogchangingDetailsonSuppPayNotes').asBoolean;
    fbLogchangingDetailsonTimesheetInvoiceNotes  := FieldByName('LogchangingDetailsonTimesheetInvoiceNotes').asBoolean;
    fbLogchangingDetailsonRepairNotes            := FieldByName('LogchangingDetailsonRepairNotes').asBoolean;
    fbLogchangingDetailsonRepairFeedbackNotes    := FieldByName('LogchangingDetailsonRepairFeedbackNotes').asBoolean;
    fbLogchangingDetailsonCashsAleComments       := FieldByName('LogchangingDetailsonCashsAleComments').asBoolean;
    fbLogchangingDetailsonCustomerfollowupNotes  := FieldByName('LogchangingDetailsonCustomerfollowupNotes').asBoolean;

    FbWarnWhenPurchaseCreationDateisfuture       := FieldByName('WarnWhenPurchaseCreationDateisfuture').AsBoolean;
    FbShowDeliveryDetailsformonDeldocketprint    := FieldByName('ShowDeliveryDetailsformonDeldocketprint').AsBoolean;
    FbShowManufacutresummarywhenchangedfromSales := FieldByName('ShowManufacutresummarywhenchangedfromSales').AsBoolean;
    FbPrintAddressLabelfromDelPrint              := FieldByName('PrintAddressLabelfromDelPrint').AsBoolean;
    FbCapacityplannerSelectionOptionBeforeLoad   := FieldByName('CapacityplannerSelectionOptionBeforeLoad').AsBoolean;
    FbUseEmployeeDeptAddressinPOShipto           := FieldByName('UseEmployeeDeptAddressinPOShipto').AsBoolean;
    FbOpenTreeFromSalesOrder                     := FieldByName('OpenTreeFromSalesOrder').AsBoolean;
    // fbPOMatchHeaderETAToShippingContainerETA:= Fieldbyname('POMatchHeaderETAToShippingContainerETA').AsBoolean;
    FbPOMatchHeaderETAToLineETA                  := FieldByName('POMatchHeaderETAToLineETA').AsBoolean;
    FbPostcodeFormatting                         := FieldByName('PostcodeFormatting').AsBoolean;
    FbShowDashboard                              := FieldByName('ShowDashboard').AsBoolean;
    FsDashboardToshow                            := FieldByName('DashboardToshow').AsString;
    FbDefaultPayMethodID                         := FieldByName('DefaultPayMethodID').AsInteger;
    FbUseBatchTransactions                       := FieldByName('UseBatchTransactions').AsBoolean;
    FbShowAccountNumbers                         := FieldByName('ShowAccountNumbers').AsBoolean;
    FbShowSupplieronSO                           := FieldByName('ShowSupplieronSO').AsBoolean;
    FbShowSupplierContactonSO                    := FieldByName('ShowSupplierContactonSO').AsBoolean;
    FsODueOk                                     := Trim(FieldByName('ODueOk').AsString);
    FsODue1Days                                  := Trim(FieldByName('ODue1Days').AsString);
    FsODue7Days                                  := Trim(FieldByName('ODue7Days').AsString);
    FsODue14Days                                 := Trim(FieldByName('ODue14Days').AsString);
    FsODue21Days                                 := Trim(FieldByName('ODue21Days').AsString);
    FsODue30Days                                 := Trim(FieldByName('ODue30Days').AsString);
    FsODue60Days                                 := Trim(FieldByName('ODue60Days').AsString);
    FsODue90Days                                 := Trim(FieldByName('ODue90Days').AsString);
    FbUseBarcodePicking                          := FieldByName('UseBarcodePicking').AsBoolean;
    FbUseForeignCurrencyonSales                  := FieldByName('UseForeignCurrencyonSales').AsBoolean;
    FiProductNameDropdownWidth                   := FieldByName('ProductNameDropdownWidth').AsInteger;
    FiProductfirstcolumnDropdownWidth            := FieldByName('ProductfirstcolumnDropdownWidth').AsInteger;
    FiProductsecondcolumnDropdownWidth           := FieldByName('ProductsecondcolumnDropdownWidth').AsInteger;
    FiProductthirdcolumnDropdownWidth            := FieldByName('ProductthirdcolumnDropdownWidth').AsInteger;
    FiProductSalesDescDropdownWidth              := FieldByName('ProductSalesDescDropdownWidth').AsInteger;
    FiProductPODescDropdownWidth                 := FieldByName('ProductPODescDropdownWidth').AsInteger;
    FiProductPreferedSupDropdownWidth            := FieldByName('ProductPreferedSupDropdownWidth').AsInteger;
    FiProductSupplierProductCodeDropdownWidth    := FieldByName('ProductSupplierProductCodeDropdownWidth').AsInteger;
    FbAutoAddProdCode                            := FieldByName('AutoAddProdCode').AsBoolean;
    FbPOSLaybyPickSlip                           := FieldByName('POSLaybyPickSlip').AsBoolean;
    FbUseTrafficMonitor                          := FieldByName('UseTrafficMonitor').AsBoolean;
    FbPOSNumKeyPad                               := FieldByName('POSNumKeyPad').AsBoolean;
    FdtStartOfDay                                := FieldByName('StartOfDay').AsDateTime;
    FdtEndOfDay                                  := FieldByName('EndOfDay').AsDateTime;
    FdLeaveLoadTaxThreshold                      := FieldByName('LeaveLoadTaxThreshold').AsCurrency;
    FbUseExpressProductList                      := FieldByName('UseExpressProductList').AsBoolean;
    FbPOSSummarise                               := FieldByName('POSSummarise').AsBoolean;
    FdtLoyaltyStartDate                          := FieldByName('LoyaltyStartDate').AsDateTime;
    FbPOenforceETA                               := FieldByName('POenforceETA').AsBoolean;
    FsPurchaseETACalculatedFrom                  := FieldByName('PurchaseETACalculatedFrom').AsString;
    FiLastContactDays                            := FieldByName('LastContactDays').AsInteger;
    FiLastSaleDays                               := FieldByName('LastSaleDays').AsInteger;
    FdSalesValue                                 := FieldByName('SalesValue').AsFloat;
    FdtLoyaltyReminderDate                       := FieldByName('LoyaltyReminderDate').AsDateTime;
    FiLoyaltyReminderRepeatDays                  := FieldByName('LoyaltyReminderRepeatDays').AsInteger;
    FiLastAppointDays                            := FieldByName('LastAppointDays').AsInteger;
    FbOpenCashDrawerFromCashSale                 := FieldByName('OpenCashDrawerFromCashSale').AsBoolean;
    FbUseClockOn                                 := FieldByName('UseClockOn').AsBoolean;
    FbUseClockedHrs                              := FieldByName('UseClockedHrs').AsBoolean;
    FbIgnoreEarlyStart                           := FieldByName('IgnoreEarlyStart').AsBoolean;
    FbIgnoreLateFinish                           := FieldByName('IgnoreLateFinish').AsBoolean;
    If Trim(FieldByName('BarcodePickingType').AsString) = 'SALESORDER' Then FbBarcodePickingInSOMode := True
    Else FbBarcodePickingInSOMode                := False;
    FbAutoConvertSOtoInvoiceBarcodePick          := FieldByName('AutoConvertSOtoInvoiceBarcodePick').AsBoolean;
    FbConsolidateCustBOonInvoice                 := FieldByName('ConsolidateCustBOonInvoice').AsBoolean;
    FbHideMatrixLineWithnoQty                    := FieldByName('HideMatrixLineWithnoQty').AsBoolean;
    FbHideNonProductBOMEnrties                   := FieldByName('HideNonProductBOMEnrties').AsBoolean;
    FbShowActiveClassOnReports                   := FieldByName('ShowActiveClassOnReports').AsBoolean;
    FbIntegratedEFTPOS                           := FieldByName('IntegratedEFTPOS').AsBoolean;
    FbPosConfirmTotalPayment                     := FieldByName('PosConfirmTotalPayment').AsBoolean;
    FbCostonSalesToPO                            := FieldByName('CostonSalesToPO').AsBoolean;
    FbPOSUseCashDrawerOnly                       := FieldByName('POSUseCashDrawerOnly').AsBoolean;
    FbMemTransPriceUpdate                        := FieldByName('MemTransPriceUpdate').AsBoolean;
    FbDefaultCustomerClassInPayments             := FieldByName('DefaultCustomerClassInPayments').AsBoolean;
    FbIgnoreTraining                             := FieldByName('IgnoreTraining').AsBoolean;
    FbUseAuditTrail                              := FieldByName('UseAuditTrail').AsBoolean;
    FbPOSSummariseBarTabInv                      := FieldByName('POSSummariseBarTabInv').AsBoolean;
    FbUseTNTFreight                              := FieldByName('UseTNTFreight').AsBoolean;
    FbGroupJobsOnAccountsReceivable              := FieldByName('GroupJobsOnAccountsReceivable').AsBoolean;
    FbEnforceNoModifyonNotes                     := FieldByName('EnforceNoModifyonNotes').AsBoolean;
    FbNoReturntoPrimaryKeypad                    := FieldByName('NoReturntoPrimaryKeypad').AsBoolean;
    FsStartWorkWeek                              := FieldByName('StartWorkWeek').AsString;
    If FsStartWorkWeek = '' Then FsStartWorkWeek := 'Monday';
    FiStartWorkWeek                              := WeekDay(FsStartWorkWeek);
    FiNoofWeekendDays                            := FieldByName('NoofWeekendDays').AsInteger;
    FiEndWeek                                    := Skipdays(FiStartWorkWeek, 0 - FiNoofWeekendDays);
    // if fiStartWorkWeek = 1 then fiEndWeek :=7 else fiEndWeek := fiStartWorkWeek-1;
    FsEndWeek                                    := WeekDay(FiEndWeek);
    FbRecalcCostInvBO                            := FieldByName('RecalcCostInvBO').AsBoolean;
    FsFixedAssetDepreciationAssetAccount         := FieldByName('FixedAssetDepreciationAssetAccount').AsString;
    FsFixedAssetDepreciationExpAccount           := FieldByName('FixedAssetDepreciationExpAccount').AsString;
    FsFixedAssetCostAssetAccount                 := FieldByName('FixedAssetCostAssetAccount').AsString;
    FsFixedAssetClearingAccount                  := FieldByName('FixedAssetClearingAccount').AsString;
    FbFiscalYearStarts                           := FieldByName('FiscalYearStarts').AsString;
    FbDepreciationCalculationConventions1        := FieldByName('DepreciationCalculationConventions').AsString;
    FbMonthofPurchase1                           := FieldByName('MonthofPurchase').AsString;
    FbMonthofDisposal1                           := FieldByName('MonthofDisposal').AsString;
    FbDepreciationCalculationConventions2        := FieldByName('DepreciationCalculationConventions2').AsString;
    FbMonthofPurchase2                           := FieldByName('MonthofPurchase2').AsString;
    FbMonthofDisposal2                           := FieldByName('MonthofDisposal2').AsString;
    FbVerifyBalanceOnBatch                       := True;
    FiSpecialBarcodeLen                          := FieldByName('SpecialBarcodeLen').AsInteger;
    FiSpecialBarcodeProductPos                   := FieldByName('SpecialBarcodeProductPos').AsInteger;
    FiSpecialBarcodeProductLen                   := FieldByName('SpecialBarcodeProductLen').AsInteger;
    FiSpecialBarcodeAmountPos                    := FieldByName('SpecialBarcodeAmountPos').AsInteger;
    FiSpecialBarcodeAmountLen                    := FieldByName('SpecialBarcodeAmountLen').AsInteger;
    FiDepreciationForTransactions                := FieldByName('DepreciationForTransactions').AsInteger;
    FbSupportPopupEnabled                        := FieldByName('SupportPopupEnabled').AsBoolean;
    FbSupportAllcustomers                        := FieldByName('SupportAllcustomers').AsBoolean;
    FiMaxNoOfAttributes                          := FieldByName('MaxNoOfAttributes').AsInteger;
    FsTeamViewerPath                             := '';
    FsERPSupportPath                             := '';
    FsSkypePath                                  := ReadskypePath;
    // if fsTeamViewerPath ='' then fsTeamViewerPath := 'C:\Program Files\TeamViewer\Version6\';
    FiSupportNoOfCalls                           := FieldByName('SupportNoOfCalls').AsInteger;
    FiSupportPeriodInDays                        := FieldByName('SupportPeriodInDays').AsInteger;
    FsSupportPopupMessage                        := FieldByName('SupportPopupMessage').AsString;
    FdMedicareLevyRate                           := FieldByName('MedicareLevyRate').AsFloat;
    FdTaxableDeduction                           := FieldByName('TaxableDeduction').AsFloat;
    FdMedicareLevySurchargeRate                  := FieldByName('MedicareLevySurchargeRate').AsFloat;
    FdLumpSumTaxRate                             := FieldByName('LumpSumTaxRate').AsFloat;
    FdLumpSumTaxRateOver55                       := FieldByName('LumpSumTaxRateOver55').AsFloat;
    FdLumpSumETaxRate                            := FieldByName('LumpSumETaxRate').AsFloat;
    FdFBTTaxRate                                 := FieldByName('FBTTaxRate').AsFloat;
    FdNoTFNTaxRate                               := FieldByName('NoTFNTaxRate').AsFloat;
    FdYearlyIncomeThreshold                      := FieldByName('YearlyIncomeThreshold').AsFloat;
    FdRBLThreshold                               := FieldByName('RBLThreshold').AsFloat;
    FbPOSCloseInvoiceAfterCreate                 := FieldByName('POSCloseInvoiceAfterCreate').AsBoolean;
    FbShowSoldSerialNumbers                      := FieldByName('ShowSoldSerialNumbers').AsBoolean;
    FbUseTemplateDefaultInvoice                  := FieldByName('UseTemplateDefaultInvoice').AsBoolean;
    FbSumReceivedOnlyForeignCurrencyonPO         := FieldByName('SumReceivedOnlyForeignCurrencyonPO').AsBoolean;
    FsJobNumberHeader                            := FieldByName('JobNumberHeader').AsString;
    If FsJobNumberHeader = '' Then FsJobNumberHeader := 'Job no';
    FsJobNameHeader                              := FieldByName('JobNameHeader').AsString;
    FsDefaultStatusForInvoiceofdonerepair        := FieldByName('DefaultStatusForInvoiceofdonerepair').AsString;
    FsDefaultStockTransferAccount                := FieldByName('DefaultStockTransferAccount').AsString;
    FsDefaultStatusforSOofDoneRepair             := FieldByName('DefaultStatusforSOofDoneRepair').AsString;
    FsManifestType                               := FieldByName('ManifestType').AsString;
    FbUseDelivery                                := FieldByName('UseDelivery').AsBoolean;
    FbOneRunPerCustomer                          := FieldByName('OneRunPerCustomer').AsBoolean;
    FbSuppressJobNameOnInvoices                  := FieldByName('SuppressJobNamesOnInvoices').AsBoolean;
    FbPrintBarcodesOnOrder                       := FieldByName('PrintBarcodesOnOrder').AsBoolean;
    FbPrintLabelsOnReceipt                       := FieldByName('PrintLabelsOnReceipt').AsBoolean;
    fbEmailCustomerOnReceipt                     := FieldByName('EmailCustomerOnReceipt').AsBoolean;
    fbEmailEmployeeOnReceipt                     := FieldByName('EmailEmployeeOnReceipt').AsBoolean;
    FbShowAccountNumberinBudget                  := FieldByName('ShowAccountNumberinBudget').AsBoolean;
    FbAutoGenerateCustomerAccntNumber            := FieldByName('AutoGenerateCustomerAccntNumber').AsBoolean;
    FbStoreForeignCurrencyValue                  := FieldByName('StoreForeignCurrencyValue').AsBoolean;
    FbUseManufacturing                           := FieldByName('UseManufacturing').AsBoolean;
    FbShowLatestCost                             := FieldByName('ShowLatestCost').AsBoolean;
    FbShowGrossProfitPercent                     := FieldByName('ShowGrossProfitPercent').AsBoolean;
    FbAutoCorrectPriceDiscountsOnDeliveries      := FieldByName('AutoCorrectPriceDiscountsOnDeliveries').AsBoolean;
    FbUseHistoryOnDespatchRuns                   := FieldByName('UseHistoryOnDespatchRuns').AsBoolean;
    FbDefaultToChartOfAccountsTreeView           := FieldByName('DefaultAccountsTreeView').AsBoolean;
    FbUseCostCentres                             := FieldByName('UseCostCentres').AsBoolean;
    FbDisableAltSaveCost                         := FieldByName('DisableAltSaveCost').AsBoolean;
    FbShowCustomerJobNoByDefault                 := FieldByName('ShowCustomerJobNoByDefault').AsBoolean;
    FbCopyDataToNewDB                            := FieldByName('CopyDataToNewDB').AsBoolean;
    FbCopyEmployeeAccess                         := FieldByName('CopyEmployeeAccess').AsBoolean;
    FbCopyEmployeeSettings                       := FieldByName('CopyEmployeeSettings').AsBoolean;
    FbCopyCompanySettings                        := FieldByName('CopyCompanySettings').AsBoolean;
    FbUseCRM                                     := FieldByName('UseCRM').AsBoolean;
    FbUseBudget                                  := FieldByName('UseBudget').AsBoolean;
    FbUseHire                                    := FieldByName('UseHire').AsBoolean;
    FbLogoutwhenIdle                             := FieldByName('LogoutwhenIdle').AsBoolean;
    FdSessiontime                                := FieldByName('Sessiontime').AsFloat;
    FbUseWorkShop                                := FieldByName('UseWorkshop').AsBoolean;
    FbUseWorkFlow                                := FieldByName('UseWorkFlow').AsBoolean;
    FbStartJobNumber                             := FieldByName('StartJobNumberField').AsBoolean;
    FbDisableCopyToSmart                         := FieldByName('DisableCopyToSmart').AsBoolean;
    FbDisableInvCopyToSmartIfPOCreated           := FieldByName('DisableInvCopyToSmartIfPOCreated').AsBoolean;
    FbShowDocketNumberColumnOnSales              := FieldByName('ShowDocketNumberColumnOnSales').AsBoolean;
    FbShowDocketNumberColumnOnPurchases          := FieldByName('ShowDocketNumberColumnOnPO').AsBoolean;
    FbShowInvoiceFormwhenApptInvoiced            := FieldByName('ShowInvoiceFormwhenApptInvoiced').AsBoolean;

    If JobNameHeader <> '' Then FbJobTitle := JobNameHeader
    Else FbJobTitle                        := 'Job';

    FbSalesWarrantyEndsOnCaption                 := FieldByName('SalesWarrantyEndsOnCaption').AsString;
    If FbSalesWarrantyEndsOnCaption = '' Then FbSalesWarrantyEndsOnCaption := 'Date Field';
    FbSalesWarrantyPeriodCaption                 := FieldByName('SalesWarrantyPeriodCaption').AsString;
    If FbSalesWarrantyPeriodCaption = '' Then FbSalesWarrantyPeriodCaption := 'Text Field';
    FbShowSalesWarrantyEndsOn                    := FieldByName('ShowSalesWarrantyEndsOn').AsString = 'T';
    FbShowSalesWarrantyPeriod                    := FieldByName('ShowSalesWarrantyPeriod').AsString = 'T';
    FbSalesWarrantyEndsOnRequired                := FieldByName('SalesWarrantyEndsOnRequired').AsString = 'T';
    FbSalesWarrantyPeriodRequired                := FieldByName('SalesWarrantyPeriodRequired').AsString = 'T';
    FbMatchUOMonSerialNoSelection                := FieldByName('MatchUOMonSerialNoSelection').AsString = 'T';
    FbMatchUOMinallocation                       := FieldByName('MatchUOMinallocation').AsString = 'T';
    FbManufacturePartSourceStock                 := FieldByName('ManufacturePartSourceStock').AsString = 'T';
    FbManufacturePartSourceStockconfirm          := FieldByName('ManufacturePartSourceStockconfirm').AsString = 'T';
    FbAutoCreateSmartOrderFromSalesOrderTree     := FieldByName('AutoCreateSmartOrderFromSalesOrderTree').AsBoolean;
    FbCopyTreeInfotoSalesDesc                    := FieldByName('CopyTreeInfotoSalesDesc').AsBoolean;
    FbPrintOnItemProgress                        := FieldByName('PrintOnItemProgress').AsBoolean;
    FbPrintOnItemcompletion                      := FieldByName('PrintOnItemcompletion').AsBoolean;
    FbHideSelectedSubnodesinReport               := FieldByName('HideSelectedSubnodesinReport').AsBoolean;
    FbAutoclockOnemployeeOnjob                   := FieldByName('AutoclockOnemployeeOnjob').AsBoolean;
    FbOpenTreeOnSmartOrdercreation               := FieldByName('OpenTreeOnSmartOrdercreation').AsBoolean;
    FbMatchUOMonBinBatchAllocation               := FieldByName('MatchUOMonBinBatchAllocation').AsString = 'T';
    FbEnforceBinVolume                           := FieldByName('EnforceBinVolume').AsString = 'T';
    fbCountSOBOInAvailable                       := FieldByName('CountSOBOInAvailable').asString = 'T';
    FbEnableBatchByDefault                       := FieldByName('EnableBatchByDefault').AsString = 'T';
    FdDefaultProductVolume                       := FieldByName('DefaultProductVolume').AsFloat;
    FbEnableBinByDefault                         := FieldByName('EnableBinByDefault').AsString = 'T';
    FbEnableSerialsByDefault                     := FieldByName('EnableSerialsByDefault').AsString = 'T';
    FbCreditCheckAppointment                     := FieldByName('CreditCheckAppointment').AsString;
    FbCreditCheckRepair                          := FieldByName('CreditCheckRepair').AsBoolean;
    FbUseProductSpecsCalcsPO                     := FieldByName('UseProductSpecsCalcsPO').AsBoolean;
    FbUseProductSpecsCalcsSales                  := FieldByName('UseProductSpecsCalcsSales').AsBoolean;
    FbAllowAlocationFromOtherClasses             := FieldByName('AllowAlocationFromOtherClasses').AsBoolean;
    FNABCardFastMerchantNumber                   := FieldByName('NABCardFastMerchantNumber').AsString;
    FtStockCostSystem                            := GetStockCostSystem(FieldByName('StockCostSystem').AsInteger);
    FRememberLastTransactionBySupplier           := FieldByName('RememberLastTransactionBySupplier').AsBoolean;
    FRememberLastReconDeposit                    := FieldByName('RememberLastReconDeposit').AsBoolean;
    FUseTimesheetRateIncAsInvoiceCost            := FieldByName('UseTimesheetRateIncAsInvoiceCost').AsBoolean;
    FCancelledAppointmentsNotPrinted             := FieldByName('CancelledAppointmentsNotPrinted').AsBoolean;
    FbAutoLoadActualDatetimeFromscheduled        := FieldByName('AutoLoadActualDatetimeFromscheduled').AsBoolean;
    FbCopyClientDetailsFromPOStoSalesComments    := FieldByName('CopyClientDetailstoSalesComments').AsBoolean;
    FbAutoUpdateActual                           := FieldByName('AutoUpdateActual').AsBoolean;
    FiAppointmentDuration                        := FieldByName('AppointmentDuration').AsInteger;
    If FiAppointmentDuration = 0 Then FiAppointmentDuration                := 30;
    FiMinimumChargeAppointmentTime               := FieldByName('MinimumChargeAppointmentTime').AsInteger;
    FsCustomerListMode                           := Trim(FieldByName('CustomerListMode').AsString);
    FAlwaysShowBOonCustomerCost                  := (FieldByName('AlwaysShowBOonCustomerCost').AsString = 'T');
    FbProductClassDefaultAll                     := FieldByName('ProductClassDefaultAll').AsBoolean;
    FbInvoiceClassDefaultAll                     := FieldByName('InvoiceClassDefaultAll').AsBoolean;
    FbEmailWhenPrintingPickingSlip               := FieldByName('EmailWhenPrintingPickingSlip').AsBoolean;
    FsPickingSlipEmailRecipient                  := FieldByName('PickingSlipEmailRecipient').AsString;
    FiMonthsStockRetained                        := FieldByName('MonthsStockRetained').AsInteger;
    FsCodeHeader                                 := FieldByName('CodeHeader').AsString;
    FbCopyCOA                                    := FieldByName('CopyCOA').AsBoolean;
    FbCopyClients                                := FieldByName('CopyClients').AsBoolean;
    FbCopyMarketingContacts                      := FieldByName('CopyMarketingContacts').AsBoolean;
    FbIncludeContactNameInSalesshippingAddress   := FieldByName('IncludeContactNameInSalesshippingAddress').AsBoolean;
    FbIncludeContactPhoneInSalesshippingAddress  := FieldByName('IncludeContactPhoneInSalesshippingAddress').AsBoolean;
    FbCopyProducts                               := FieldByName('CopyProducts').AsBoolean;
    FbCopyOutstandingTxn                         := FieldByName('CopyOutstandingTxn').AsBoolean;
    FdIncomeTaxPercentage                        := FieldByName('IncomeTaxPercentage').AsFloat;
    FbZerotaxWhenLoss                            := FieldByName('ZerotaxWhenLoss').AsBoolean;
    //FbProductAvgcostCalculatedForDepartment      := FieldByName('ProductAvgcostCalculatedForDepartment').AsBoolean;
    FbConfirmBeforeInvoiceStockToNegative        := FieldByName('ConfirmBeforeInvoiceStockToNegative').AsBoolean;
    FbConfirmBeforesalePricechange               := FieldByName('ConfirmBeforesalePricechange').AsBoolean;
    FbCurrentDateforSalesshipment                := FieldByName('CurrentDateforSalesshipment').AsBoolean;
    FbPOSPrintAfterSave                          := FieldByName('POSPrintAfterSave').AsBoolean;
    FiNoOfMonthstoChangeClosingdate              := FieldByName('NoOfMonthstoChangeClosingdate').AsInteger;
    FbProductcomboLookupExpressList              := FieldByName('ProductcomboLookupListform').AsString = 'E';
    FbCustomercomboLookupExpressList             := FieldByName('CustomercomboLookupExpressList').AsString = 'E';
    FbAutomaticallyUpdateclosingDate             := FieldByName('AutomaticallyUpdateclosingDate').AsBoolean;
    FsUOMWeightUOM                               := FieldByName('UOMWeightUOM').AsString;
    If FsUOMWeightUOM = '' Then FsUOMWeightUOM   := 'kg';
    FsUOMVolumeDimensionUOM                      := FieldByName('UOMVolumeDimensionUOM').AsString;
    If FsUOMVolumeDimensionUOM = '' Then FsUOMVolumeDimensionUOM           := 'mm';
    FsNegativeStockcheckinInvoicebasedon         := FieldByName('NegativeStockcheckinInvoicebasedon').AsString;
    FsRetailcustomerType1                        := FieldByName('RetailcustomerType1').AsString;
    FsWholeSaleCustomerType1                     := FieldByName('WholeSaleCustomerType1').AsString;
    FsWholeSaleCustomerType2                     := FieldByName('WholeSaleCustomerType2').AsString;
    FsWholeSaleCustomerType3                     := FieldByName('WholeSaleCustomerType3').AsString;
    FsWholeSaleCustomerType4                     := FieldByName('WholeSaleCustomerType4').AsString;
    FdSummarisedTransDate                        := EndOfTheDay(FieldByName('SummarisedTransDate').AsDateTime);
    If FdtClosingDate < FdSummarisedTransDate Then Begin
      If LockPreferenceTable(LockMessage) Then
        Try
          DecodeDate(Now(), TmpYear, TmpMonth, TmpDay);
          If (TmpMonth < GetMonthNo(FbFiscalYearStarts)) Then TmpYear                       := TmpYear - 1;
          FieldByName('ClosingDate').AsDateTime                                             := IncDay(EncodeDate(TmpYear, GetMonthNo(FbFiscalYearStarts), 1), -1);
          FdtClosingDate                                                                    := FieldByName('ClosingDate').AsDateTime;
          If FdtClosingDateAP < FdtClosingDate Then FieldByName('ClosingDateAP').AsDateTime := FdtClosingDate;
          FdtClosingDateAP                                                                  := FieldByName('ClosingDateAP').AsDateTime;
          If FdtClosingDateAR < FdtClosingDate Then FieldByName('ClosingDateAR').AsDateTime := FdtClosingDate;
          FdtClosingDateAR                                                                  := FieldByName('ClosingDateAR').AsDateTime;
      Finally
        UnLockPreferenceTable;
      End;
    End;
    FdSummarisedTransDateChanged                 := FieldByName('SummarisedTransDateChanged').AsDateTime;
    FiCustomerPaymentsDefaultVariationAccountID  := FieldByName('CustomerPaymentsDefaultVariationAccountID').AsInteger;
    FiSupplierPaymentsDefaultVariationAccountID  := FieldByName('SupplierPaymentsDefaultVariationAccountID').AsInteger;
    FsEmailAuthPassword                          := FieldByName('EmailAuthPassword').AsString;
    FbAllClassesOnCustList                       := FieldByName('AllClassesOnCustList').AsBoolean;
    FbPOOnlyApprovedTransInSuppPayment           := FieldByName('POOnlyApprovedTransInSuppPayment').AsBoolean;
    // if fbPOOnlyApprovedTransInSuppPayment then
    FbUseApprovalLevels                          := FieldByName('UseApprovalLevels').AsBoolean;
    fbCleanUseApprovalLevels                     := fbUseApprovalLevels;
    FsApprovalType                               := FieldByName('ApprovalType').AsString; //A:Any, S:single, M:Multiple
    // else
    // fbUseApprovalLevels := False;
    FbIncludeUnInvoicedPOtoGL                    := FieldByName('IncludeUnInvoicedPOtoGL').AsBoolean;
    FiUnInvoicedPOAccount                        := FieldByName('UnInvoicedPOAccount').AsInteger;
    FiDutiesAccount                              := FieldByName('DutiesAccount').AsInteger;
    FiBrokerHandlingAccount                      := FieldByName('BrokerHandlingAccount').AsInteger;
    FbIncludeUnInvoicedSOtoGL                    := FieldByName('IncludeUnInvoicedSOtoGL').AsBoolean;
    FiUnInvoicedSOAccount                        := FieldByName('UnInvoicedSOAccount').AsInteger;
    FiUnInvoicedSOType                           := FieldByName('UnInvoicedSOType').AsInteger;
    FiUnInvoicedSOLabourAccount                  := FieldByName('UnInvoicedSOLabourAccount').AsInteger;
    FbUseBlindBalance                            := FieldByName('UseBlindBalance').AsBoolean;
    FsCompanyRegion                              := FieldByName('CompanyRegion').AsString;
    FbPOSShowProductPic                          := FieldByName('POSShowProductPic').AsBoolean;
    FbBankAccFormatting                          := FieldByName('BankAccFormatting').AsBoolean;
    FbUsePCC                                     := FieldByName('UsePCC').AsBoolean;
    FsPCCPathToVisualConsole                     := FieldByName('PCCPathToVisualConsole').AsString;
    FbPOSPrintReceiptOnlyOnCompleteSale          := FieldByName('POSPrintReceiptOnlyOnCompleteSale').AsBoolean;
    FbPOSPrintDescriptionMultipleLines           := FieldByName('POSPrintDescriptionMultipleLines').AsBoolean;
    FbUseAlphaNumericBarcodes                    := FieldByName('UseAlphaNumericBarcodes').AsBoolean;
    FbBarTabsConvertStarted                      := FieldByName('BarTabsConvertStarted').AsBoolean;
    FbBatchUpdateInProgress                      := FieldByName('BatchUpdateInProgress').AsBoolean;
    FbEnableWebAPILoging                         := FieldByName('EnableWebAPILoging').AsBoolean;
    FbSalesCommissionCalcInProgress              := FieldByName('SalesCommissionCalcInProgress').AsBoolean;
    FiSalesCommissionCalcEmployeeID              := FieldByName('SalesCommissionCalcEmployeeID').AsInteger;
    FdtTransactionTableLastUpdated               := FieldByName('TransactionTableLastUpdated').AsDateTime;
    FdtReportTablesLastUpdatedOn                 := FieldByName('ReportTablesLastUpdatedOn').AsDateTime;
    FdtSerialNumberListUpdatedOn                 := FieldByName('SerialNumberListUpdatedOn').AsDateTime;
    FbUseFutureSO                                := FieldByName('UseFutureSO').AsBoolean;
    FbUSeSalesCommission                         := FieldByName('USeSalesCommission').AsBoolean;
    FbLeaveOpenOnCopyToINV                       := FieldByName('LeaveOpenOnCopyToINV').AsBoolean;
    FiFutureSODays                               := FieldByName('FutureSODays').AsInteger;
    FbPCCVCAutoStart                             := FieldByName('PCCVCAutoStart').AsBoolean;
    // fbUseAssessment                           := FieldByName('UseAssessment').AsBoolean;
    FbEmailInvoiceInfoToCustomer                 := FieldByName('EmailInvoiceInfoToCustomer').AsBoolean;
    FbAutomaticDeliveryDocketPrint               := FieldByName('AutomaticDeliveryDocketPrint').AsBoolean;
    FbAutomaticSODeliveryDocketPrint             := FieldByName('AutomaticSODeliveryDocketPrint').AsBoolean;
    FbResetCustPrices                            := FieldByName('ResetCustPrices').AsBoolean;
    FbPaymentsAddToEFT                           := FieldByName('PaymentsAddToEFT').AsBoolean;
    FsDefaultDiscountMarkup                      := FieldByName('DefaultDiscountMarkup').AsString;
    FbUsePriceSchems                             := FieldByName('UsePriceSchemes').AsBoolean;
    FbUseDefaultMailClient                       := True;
    FbDefaultMailClientPreview                   := FieldByName('DefaultMailClientPreview').AsBoolean;
    FbEnableInvoicePickMail                      := FieldByName('EnableInvoicePickMail').AsBoolean;
    FbEnableInvoicePickSMS                       := FieldByName('EnableInvoicePickSMS').AsBoolean;
    FbEnableInvoiceDelMail                       := FieldByName('EnableInvoiceDelMail').AsBoolean;
    FbEnableInvoiceDelSMS                        := FieldByName('EnableInvoiceDelSMS').AsBoolean;
    FbEnableInvoiceMail                          := FieldByName('EnableInvoiceMail').AsBoolean;
    FbEnableInvoicePrintSMS                      := FieldByName('EnableInvoicePrintSMS').AsBoolean;
    FsInvoicePickMailSubject                     := FieldByName('InvoicePickMailSubject').AsString;
    FsInvoicePickMailText                        := FieldByName('InvoicePickMailText').AsString;
    FsInvoicePickSMSText                         := FieldByName('InvoicePickSMSText').AsString;
    FsInvoiceDelMailSubject                      := FieldByName('InvoiceDelMailSubject').AsString;
    FsInvoiceDelMailText                         := FieldByName('InvoiceDelMailText').AsString;
    FsInvoiceDelSMSText                          := FieldByName('InvoiceDelSMSText').AsString;
    FsInvoiceMailSubject                         := FieldByName('InvoiceMailSubject').AsString;
    FsInvoiceMailText                            := FieldByName('InvoiceMailText').AsString;
    FsInvoicePrintSMSText                        := FieldByName('InvoicePrintSMSText').AsString;
    FsDefaultEmailSubject                        := FieldByName('DefaultEmailSubject').AsString;
    FsDefaultEmailText                           := FieldByName('DefaultEmailText').AsString;
    FbUseElectronicIntrastat                     := FieldByName('UseElectronicIntrastat').AsBoolean;
    FbUseElectronicVAT                           := FieldByName('UseElectronicVAT').AsBoolean;
    FsVATSenderID                                := FieldByName('VATSenderID').AsString;
    FsVATKeyType                                 := FieldByName('VATKeyType').AsString;
    FsVATKeys                                    := FieldByName('VATKeys').AsString;
    FsVATVendorID                                := FieldByName('VATVendorID').AsString;
    FsProductListPriceMultiplierOn               := FieldByName('ProductListPriceMultiplierOn').AsString;
    FsVATCurrencyCode                            := FieldByName('VATCurrencyCode').AsString;
    FsVATAuthentication                          := FieldByName('VATAuthentication').AsString;
    FiVATMaxAttemptsPerSession                   := FieldByName('VATMaxAttemptsPerSession').AsInteger;
    FbUKGateWayIsLive                            := FieldByName('UKGateWayIsLive').AsBoolean;
    FbUseEmployeeClassForARList                  := FieldByName('UseEmployeeClassForARList').AsBoolean;
    FUpdateSaleShippedFromPOReceived             := FieldByName('UpdateSaleShippedFromPOReceived').AsBoolean;
    FWorkersCompRate                             := FieldByName('WorkersCompRate').AsFloat;
    FProductListPriceMultiplier                  := FieldByName('ProductListPriceMultiplier').AsFloat;
    FValueforRewardPoints                        := FieldByName('ValueforRewardPoints').AsFloat;
    FdOPOSScaleMultiplier                        := FieldByName('OPOSScaleMultiplier').AsFloat;
    FiMultiplesofPointstoRedeem                  := FieldByName('MultiplesofPointstoRedeem').AsInteger;
    If FiMultiplesofPointstoRedeem <= 0 Then FiMultiplesofPointstoRedeem  := 1;
    FCustomerTypeRequired                        := FieldByName('CustomerTypeRequired').AsBoolean;
    FbEnablequoteVariation                       := FieldByName('EnablequoteVariation').AsBoolean;
    // fVideoUseInternet  := FieldByName('VideoUseInternet').AsBoolean;
    FiExpiresOnNoOfMonthsAfterPurchase           := FieldByName('ExpiresOnNoOfMonthsAfterPurchase').AsInteger;
    FiRewardPointssoldAccount                    := FieldByName('RewardPointssoldAccount').AsInteger;
    FiExpenseAccountforRewardPoints              := FieldByName('ExpenseAccountforRewardPoints').AsInteger;
    FiRewardPointsExpiredAccount                 := FieldByName('RewardPointsExpiredAccount').AsInteger;
    { if accounts are not selected then assign defaults }
    If FiExpenseAccountforRewardPoints = 0 Then FiExpenseAccountforRewardPoints := TcDataUtils.GetAccountID(ACNT_REWARD_POINTS_COGS);
    If FiRewardPointssoldAccount       = 0 Then FiRewardPointssoldAccount       := TcDataUtils.GetAccountID(ACNT_REWARD_POINTS_SOLD);
    If FiRewardPointsExpiredAccount    = 0 Then FiRewardPointsExpiredAccount    := TcDataUtils.GetAccountID(ACNT_REWARD_POINTS_EXPIRED);
    //FdFristTransDate                           := TcDataUtils.FristTransDate;
    //If FdFristTransDate = 0 Then FdFristTransDate := FdtClosingDate;
    FbHintInEditMode                             := False;
    FbBOByDefaultOnSO                            := FieldByName('BOByDefaultOnSO').AsBoolean;
    FbBOByDefaultOnInvoice                       := FieldByName('BOByDefaultOnInvoice').AsBoolean;
    FbExcludeInactiveContactFromMessages         := FieldByName('ExcludeInactiveContactFromMessages').AsBoolean;
    FbShowRelatedMasterinSales                   := FieldByName('ShowRelatedMasterinSales').AsBoolean;
    FbShowRelatedProductsinSales                 := FieldByName('ShowRelatedProductsinSales').AsBoolean;
    //FbSales_ProductlistMatchCustomerArea       := FieldByName('Sales_ProductlistMatchCustomerArea').AsBoolean;
    FsRelatedMasterCaptionInSales                := FieldByName('RelatedMasterCaptionInSales').AsString;
    FMatchSaleLineShipDateToHeader               := FieldByName('MatchSaleLineShipDateToHeader').AsBoolean;
    FMatchSalesLineShipdateToProductDeliveryDays := FieldByName('MatchSalesLineShipdateToProductDeliveryDays').AsBoolean;
    FsStatusToMakeSalesOrder                     := FieldByName('StatusToMakeSalesOrder').AsString;
    FsStatustoMakeInvoice                        := FieldByName('StatustoMakeInvoice').AsString;
    FbRemoveHideOnPrintProductFromReports        := FieldByName('RemoveHideOnPrintProductFromReports').AsBoolean;
    FbHoldRepairOnPrinting                       := FieldByName('HoldRepairOnPrinting').AsBoolean;
    FbRepairDoneOnConversion                     := FieldByName('RepairDoneOnConversion').AsBoolean;
    FbLockRepairwhenDone                         := FieldByName('LockRepairwhenDone').AsBoolean;
    // fbRepairHasToBeApprovedforInvoicing       := FieldByName('RepairHasToBeApprovedforInvoicing').AsBoolean;
    FsRepairStatustoMakeInvoice                  := FieldByname('RepairStatustoMakeInvoice').AsString;
    // fbSOHasToBeApprovedforInvoicing           := FieldByName('SOHasToBeApprovedforInvoicing').AsBoolean;
    FbEnforceCustPOInrepairbeforeOtherInfo       := FieldByName('EnforceCustPOInrepairbeforeOtherInfo').AsBoolean;
    FbCanEditSalesshiptoAddress                  := FieldByName('CanEditSalesshiptoAddress').AsBoolean;
    fbIncludeJournalsInCashBAS                   := FieldByName('IncludeJournalsInCashBAS').AsBoolean;
    FbCanChanePOInvoiceNo                        := FieldByName('CanRemoveSupplierInvoiceNoInPO').AsBoolean;
    FdInsuranceProductListMinCost                := FieldByName('InsuranceProductListMinCost').AsFloat;
    FsInsuranceProductNameStartsWith             := FieldByName('InsuranceProductNameStartsWith').AsString;
    FsDefaultAccountingMethod                    := FieldByName('DefaultAccountingMethod').AsString;
    FsInsurancereportOrderbyProductNameStartswith1:= FieldByName('InsurancereportOrderbyProductNameStartswith1').AsString;
    FsInsurancereportOrderbyProductNameStartswith2:= FieldByName('InsurancereportOrderbyProductNameStartswith2').AsString;
    FsInsuranceAgencyREf1                        := FieldByName('InsuranceAgencyREf1').AsString;
    FsInsuranceAgencyREf2                        := FieldByName('InsuranceAgencyREf2').AsString;
    FdInsurancePremiumcharged                    := FieldByName('InsurancePremiumcharged').AsFloat;
    FbIsSalesCategoryMandatory                   := FieldByName('IsSalesCategoryMandatory').AsBoolean;
    FsSalesPrintOrderBy                          := FieldByName('SalesPrintOrderBy').AsString;
    FbReplaceDiscontinuedwithAlternate           := FieldByName('AlternateProductSelection').AsString = 'R';
    FbUseDiscontinuedProductPriceforAlternateProduct := FieldByName('UseDiscontinuedProductPriceforAlternateProduct').AsBoolean;
    FbLoadCustnameinNewshippingAddress           := FieldByName('LoadCustnameinNewshippingAddress').AsBoolean;
    FsDefualtModuleNameforPhSupport              := FieldByName('DefualtModuleNameforPhSupport').AsString;
    FbPadQuotePricesIncTax                       := FieldByName('PadQuotePricesIncTax').AsBoolean;
    //FbUseProductBuyCostForLatestCost           := FieldByName('UseProductBuyCostForLatestCost').AsBoolean;
         if FieldByname('SalesLineLatestCostBasedOn').asInteger =1 then fSalesLineLatestCostBasedOn := lcbPurchaseOrder
    else if FieldByname('SalesLineLatestCostBasedOn').asInteger =2 then fSalesLineLatestCostBasedOn := lcbProductCard
    else if FieldByname('SalesLineLatestCostBasedOn').asInteger =3 then fSalesLineLatestCostBasedOn := lcbAvgCost
    else if FieldByname('SalesLineLatestCostBasedOn').asInteger =4 then fSalesLineLatestCostBasedOn := lcbHighest
    else fSalesLineLatestCostBasedOn             := lcbLowest;
    FsRALineDefaultStatus                        := FieldByName('RALineDefaultStatus').AsString;
    FbClosingDateChangeDone                      := FieldByName('ClosingDateChangeDone').AsBoolean;
    FbSupportAutoAssign                          := FieldByName('SupportAutoAssign').AsBoolean;
    FbCombineRepairTimeSheetLinesOnInvoice       := FieldByName('CombineRepairTimeSheetLinesOnInvoice').AsBoolean;
    FbPartCalcfield1                             := FieldByName('PartCalcfield1').AsBoolean;
    FbPartCalcfield2                             := FieldByName('PartCalcfield2').AsBoolean;
    FbPartCalcfield3                             := FieldByName('PartCalcfield3').AsBoolean;
    FbPartCalcfield4                             := FieldByName('PartCalcfield4').AsBoolean;
    FbPartCalcfield5                             := FieldByName('PartCalcfield5').AsBoolean;
    FsPartCalcField1Name                         := FieldByName('PartCalcField1Name').AsString;
    FsPartCalcfield2Name                         := FieldByName('PartCalcfield2Name').AsString;
    FsPartCalcfield3Name                         := FieldByName('PartCalcfield3Name').AsString;
    FsPartCalcfield4Name                         := FieldByName('PartCalcfield4Name').AsString;
    FsPartCalcfield5Name                         := FieldByName('PartCalcfield5Name').AsString;
    FQtySoldColour                               := Colourof(FieldByName('QtySoldColour').AsInteger, FieldByName('QtySoldGradIntensity').AsInteger);
    FQtyShippedColour                            := Colourof(FieldByName('QtyShippedColour').AsInteger, FieldByName('QtyShippedGradIntensity').AsInteger);
    FBatchAllocationColour                       := Colourof(FieldByName('BatchAllocationColour').AsInteger, FieldByName('BatchAllocationGradIntensity').AsInteger);
    FBinAllocationColour                         := Colourof(FieldByName('BinAllocationColour').AsInteger, FieldByName('BinAllocationGradIntensity').AsInteger);
    FSNAllocationColour                          := Colourof(FieldByName('SNAllocationColour').AsInteger, FieldByName('SNAllocationGradIntensity').AsInteger);
    FContainerRelatedProductColour               := Colourof(FieldByName('ContainerRelatedProductColour').AsInteger, FieldByName('ContainerRelatedProductGradIntensity').AsInteger);
    FPalletRelatedProductColour                  := Colourof(FieldByName('PalletRelatedProductColour').AsInteger, FieldByName('PalletRelatedProductGradIntensity').AsInteger);
    FbIndicateifBatchAllocated                   := FieldByName('IndicateifBatchAllocated').AsBoolean;
    FbIndicateifBinAllocated                     := FieldByName('IndicateifBinAllocated').AsBoolean;
    FbIndicateifSNAllocated                      := FieldByName('IndicateifSNAllocated').AsBoolean;
    FbIndicateContainerRelatedProduct            := FieldByName('IndicateContainerRelatedProduct').AsBoolean;
    FbIndicatePalletRelatedProduct               := FieldByName('IndicatePalletRelatedProduct').AsBoolean;
    FGanttChartGFStartColour                     := Colourof(FieldByName('GanttChartGFStartColour').AsInteger, FieldByName('GanttChartGFStartColourIntensity').AsInteger);
    FGanttChartGFEndcolour                       := Colourof(FieldByName('GanttChartGFEndcolour').AsInteger, FieldByName('GanttChartGFEndcolourIntensity').AsInteger);
    FProductStatusPartQtyColour                  := Colourof(FieldByName('ProductStatusPartQtyColour').AsInteger, FieldByName('ProductStatusPartQtyColourIntensity').AsInteger);
    FProductStatusTransQtyColour                 := Colourof(FieldByName('ProductStatusTransQtyColour').AsInteger, FieldByName('ProductStatusTransQtyColourIntensity').AsInteger);
    FProductStatusOrderQtyColour                 := Colourof(FieldByName('ProductStatusOrderQtyColour').AsInteger, FieldByName('ProductStatusOrderQtyColourIntensity').AsInteger);
    FProductStatusETAWithinPeriodColour          := Colourof(FieldByName('ProductStatusETAWithinPeriodColour').AsInteger, FieldByName('ProductStatusETAWithinPeriodColourIntensity').AsInteger);
    FProductStatusETAExceededColour              := Colourof(FieldByName('ProductStatusETAExceededColour').AsInteger, FieldByName('ProductStatusETAExceededColourIntensity').AsInteger);
    FiGanttChartDrawStyle                        := FieldByName('GanttChartDrawStyle').AsInteger;
    FiGanttChartBarHeight                        := FieldByName('GanttChartBarHeight').AsInteger;
    FiCostDecimalPlacesinTree                    := FieldByName('CostDecimalPlacesinTree').AsInteger;
    FiPPGBalanceAdjAccountID                     := FieldByName('PPGBalanceAdjAccountID').AsInteger;
    FiPPGBalanceAdjEmployeeID                    := FieldByName('PPGBalanceAdjEmployeeID').AsInteger;
    fsDefaultBOMWastageAccount                   := FieldByName('DefaultBOMWastageAccount').asString;
    fBoMNonProductsubnodePostingAccount          := FieldByName('BoMNonProductsubnodePostingAccount').asString;
    FbShowSalesProductAutoSelectOptions          := FieldByName('ShowSalesProductAutoSelectOptions').AsBoolean;
    FCyTrackIntegrationEnabled                   := FieldByName('CyTrackIntegrationEnabled').AsBoolean;
    FbIsClonedCopy                               := FieldByName('IsClonedCopy').AsBoolean;
    FbDisableAutoUpdateclosingDate               := FieldByName('DisableAutoUpdateclosingDate').AsBoolean;
    FbShowAmountToAppearOnPrintout               := FieldByName('ShowAmountToAppearOnPrintout').AsBoolean;
    FEnforceCustomerFirstAndLastName             := FieldByName('EnforceCustomerFirstAndLastName').AsBoolean;
    FEnforcesupplierFirstName                    := FieldByName('EnforcesupplierFirstName').AsBoolean;
    FbEnableAusEparcel                           := FieldByName('EnableAusEparcel').AsBoolean;

    FbEnableInvoiceSaveMail                      := FieldByName('EnableInvoiceSaveMail').AsBoolean;
    FbEnableInvoiceSaveSMS                       := FieldByName('EnableInvoiceSaveSMS').AsBoolean;
    FsInvoiceSaveEmailSubject                    := FieldByName('InvoiceSaveEmailSubject').AsString;
    FsInvoiceSaveEmailText                       := FieldByName('InvoiceSaveEmailText').AsString;
    FsInvoiceSaveSMSText                         := FieldByName('InvoiceSaveSMSText').AsString;

    FbEnableSOPrintEmail                         := FieldByName('EnableSOPrintEmail').AsBoolean;
    FbEnableSOPrintSMS                           := FieldByName('EnableSOPrintSMS').AsBoolean;
    FsSOPrintEmailSubject                        := FieldByName('SOPrintEmailSubject').AsString;
    FsSOPrintEmailText                           := FieldByName('SOPrintEmailText').AsString;
    FsSOPrintSMSText                             := FieldByName('SOPrintSMSText').AsString;

    FbEnableSOSaveEmail                          := FieldByName('EnableSOSaveEmail').AsBoolean;
    FbEnableSOSaveSMS                            := FieldByName('EnableSOSaveSMS').AsBoolean;
    FbApplyPrepaymentsOnSOConversion             := FieldByName('ApplyPrepaymentsOnSOConversion').AsBoolean;
    FbEnableScheduledreports                     := FieldByName('EnableScheduledreports').AsBoolean;
    FsSOSaveEmailSubject                         := FieldByName('SOSaveEmailSubject').AsString;
    FsSOSaveEmailText                            := FieldByName('SOSaveEmailText').AsString;
    FsSOSaveSMSText                              := FieldByName('SOSaveSMSText').AsString;

    FbEnableQuotePrintEmail                      := FieldByName('EnableQuotePrintEmail').AsBoolean;
    FbEnableQuotePrintSMS                        := FieldByName('EnableQuotePrintSMS').AsBoolean;
    FsQuotePrintEmailSubject                     := FieldByName('QuotePrintEmailSubject').AsString;
    FsQuotePrintEmailText                        := FieldByName('QuotePrintEmailText').AsString;
    FsQuotePrintSMSText                          := FieldByName('QuotePrintSMSText').AsString;

    FbEnableQuoteSaveEmail                      := FieldByName('EnableQuoteSaveEmail').AsBoolean;
    FbEnableQuoteSaveSMS                        := FieldByName('EnableQuoteSaveSMS').AsBoolean;
    FsQuoteSaveEmailSubject                     := FieldByName('QuoteSaveEmailSubject').AsString;
    FsQuoteSaveEmailText                        := FieldByName('QuoteSaveEmailText').AsString;
    FsQuoteSaveSMSText                          := FieldByName('QuoteSaveSMSText').AsString;

    FbEnableShipContainerChangeEmail            := FieldByName('EnableShipContainerChangeEmail').AsBoolean;
    FbEnablShipContainerChangeSMS               := FieldByName('EnablShipContainerChangeSMS').AsBoolean;
    FsShipContainerChangeEmailSubject           := FieldByName('ShipContainerChangeEmailSubject').AsString;
    FsShipContainerChangeEmailText              := FieldByName('ShipContainerChangeEmailText').AsString;
    FsShipContainerChangeSMSText                := FieldByName('ShipContainerChangeSMSText').AsString;

    FbEnableAppointmentPrintEmail               := FieldByName('EnableAppointmentPrintEmail').AsBoolean;
    FbEnableAppointmentPrintSMS                 := FieldByName('EnableAppointmentPrintSMS').AsBoolean;
    FbEnableAppointmentRepPrintSMS              := FieldByName('EnableAppointmentRepPrintSMS').AsBoolean;
    FsAppointmentPrintEmailSubject              := FieldByName('AppointmentPrintEmailSubject').AsString;
    FsAppointmentPrintEmailText                 := FieldByName('AppointmentPrintEmailText').AsString;
    FsAppointmentPrintSMSText                   := FieldByName('AppointmentPrintSMSText').AsString;
    FsAppointmentRepPrintSMSText                := FieldByName('AppointmentRepPrintSMSText').AsString;

    FbEnablePOReceiveSOEmail                    := FieldByName('EnablePOReceiveSOEmail').AsBoolean;
    FbEnablePOReceiveSOSMS                      := FieldByName('EnablePOReceiveSOSMS').AsBoolean;
    FsPOReceiveSOEmailSubject                   := FieldByName('POReceiveSOEmailSubject').AsString;
    FsPOReceiveSOEmailText                      := FieldByName('POReceiveSOEmailText').AsString;
    FsPOReceiveSOSMSText                        := FieldByName('POReceiveSOSMSText').AsString;

    FbEnablePOReceiveInvEmail                   := FieldByName('EnablePOReceiveInvEmail').AsBoolean;
    FbEnablePOReceiveInvSMS                     := FieldByName('EnablePOReceiveInvSMS').AsBoolean;
    FsPOReceiveInvEmailSubject                  := FieldByName('POReceiveInvEmailSubject').AsString;
    FsPOReceiveInvEmailText                     := FieldByName('POReceiveInvEmailText').AsString;
    FsPOReceiveInvSMSText                       := FieldByName('POReceiveInvSMSText').AsString;

    FbEnableInvShipChangeEmail                  := FieldByName('EnableInvShipChangeEmail').AsBoolean;
    FbEnableInvShipChangeSMS                    := FieldByName('EnableInvShipChangeSMS').AsBoolean;
    FsInvShipChangeEmailSubject                 := FieldByName('InvShipChangeEmailSubject').AsString;
    FsInvShipChangeEmailSubject                 := FieldByName('InvShipChangeEmailSubject').AsString;
    FsInvShipChangeSMSText                      := FieldByName('InvShipChangeSMSText').AsString;

    FbEnableSOShipChangeEmail                   := FieldByName('EnableSOShipChangeEmail').AsBoolean;
    FbEnableSOShipChangeSMS                     := FieldByName('EnableSOShipChangeSMS').AsBoolean;
    FsSOShipChangeEmailSubject                  := FieldByName('SOShipChangeEmailSubject').AsString;
    FsSOShipChangeEmailSubject                  := FieldByName('SOShipChangeEmailSubject').AsString;
    FsSOShipChangeSMSText                       := FieldByName('SOShipChangeSMSText').AsString;

    FbEnableRefundPrintEmail                    := FieldByName('EnableRefundPrintEmail').AsBoolean;
    FbEnableRefundPrintSMS                      := FieldByName('EnableRefundPrintSMS').AsBoolean;
    FsRefundPrintEmailSubject                   := FieldByName('RefundPrintEmailSubject').AsString;
    FsRefundPrintEmailText                      := FieldByName('RefundPrintEmailText').AsString;
    FsRefundPrintSMSText                        := FieldByName('RefundPrintSMSText').AsString;



    FbEnableRepairInvoicedEmail                 := FieldByname('EnableRepairInvoicedEmail').AsBoolean;
    FbEnableRepairInvoicedSMS                   := FieldByname('EnableRepairInvoicedSMS').AsBoolean;
    FsRepairInvoicedEmailSubject                := FieldByName('RepairInvoicedEmailSubject').AsString;
    FsRepairInvoicedEmailText                   := FieldByName('RepairInvoicedEmailText').AsString;
    FsRepairInvoicedSMSText                     := FieldByName('RepairInvoicedSMSText').AsString;


    FbEnableAutoSplitQtyintoUOMinSales          := FieldByname('EnableAutoSplitQtyintoUOMinSales').AsBoolean;

    FbEnableRepairPrintEmail                    := FieldByname('EnableRepairPrintEmail').AsBoolean;
    FbEnableRepairPrintSMS                      := FieldByname('EnableRepairPrintSMS').AsBoolean;
    FsRepairPrintEmailSubject                   := FieldByName('RepairPrintEmailSubject').AsString;
    FsRepairPrintEmailText                      := FieldByName('RepairPrintEmailText').AsString;
    FsRepairPrintSMSText                        := FieldByName('RepairPrintSMSText').AsString;

    FbEnablePOPrintEmail                        := FieldByName('EnablePOPrintEmail').AsBoolean;
    FbEnablePOPrintSMS                          := FieldByName('EnablePOPrintSMS').AsBoolean;
    FsPOPrintEmailSubject                       := FieldByName('POPrintEmailSubject').AsString;
    FsPOPrintEmailText                          := FieldByName('POPrintEmailText').AsString;
    FsPOPrintSMSText                            := FieldByName('POprintSMSText').AsString;


    FbEnablePOCreateEmail                       := FieldByName('EnablePOCreateEmail').asBoolean;
    FsPOCreateEmailSubject                      := FieldByName('POCreateEmailSubject').asString;
    FsPOCreateEmailText                         := FieldByName('POCreateEmailText').asString;

    FbEnableRAPrintEmail                        := FieldByName('EnableRAPrintEmail').AsBoolean;
    FbEnableRAPrintSMS                          := FieldByName('EnableRAPrintSMS').AsBoolean;
    FsRAPrintEmailSubject                       := FieldByName('RAPrintEmailSubject').AsString;
    FsRAPrintEmailText                          := FieldByName('RAPrintEmailText').AsString;
    FsRAPrintSMSText                            := FieldByName('RAprintSMSText').AsString;

    FbEnableBillPrintEmail                      := FieldByName('EnableBillPrintEmail').AsBoolean;
    FbEnableBillPrintSMS                        := FieldByName('EnableBillPrintSMS').AsBoolean;
    FsBillPrintEmailSubject                     := FieldByName('BillPrintEmailSubject').AsString;
    FsBillPrintEmailText                        := FieldByName('BillPrintEmailText').AsString;
    FsBillPrintSMSText                          := FieldByName('BillPrintSMSText').AsString;

    FbEnableCreditPrintEmail                    := FieldByName('EnableCreditPrintEmail').AsBoolean;
    FbEnableCreditPrintSMS                      := FieldByName('EnableCreditPrintSMS').AsBoolean;
    FsCreditPrintEmailSubject                   := FieldByName('CreditPrintEmailSubject').AsString;
    FsCreditPrintEmailText                      := FieldByName('CreditPrintEmailText').AsString;
    FsCreditPrintSMSText                        := FieldByName('CreditPrintSMSText').AsString;

    FbEnableCashSalePrintEmail                  := FieldByName('EnableCashSalePrintEmail').AsBoolean;
    FbEnableCashSalePrintSMS                    := FieldByName('EnableCashSalePrintSMS').AsBoolean;
    FsCashSalePrintEmailSubject                 := FieldByName('CashSalePrintEmailSubject').AsString;
    FsCashSalePrintEmailText                    := FieldByName('CashSalePrintEmailText').AsString;
    FsCashSalePrintSMSText                      := FieldByName('CashSalePrintSMSText').AsString;

    FbEnablePOSCashSalePrintEmail               := FieldByName('EnablePOSCashSalePrintEmail').AsBoolean;
    FbEnablePOSCashSalePrintSMS                 := FieldByName('EnablePOSCashSalePrintSMS').AsBoolean;
    FsPOSCashSalePrintEmailSubject              := FieldByName('POSCashSalePrintEmailSubject').AsString;
    FsPOSCashSalePrintEmailText                 := FieldByName('POSCashSalePrintEmailText').AsString;
    FsPOSCashSalePrintSMSText                   := FieldByName('POSCashSalePrintSMSText').AsString;

    FbEnableVoucherSalePrintEmail               := FieldByName('EnableVoucherSalePrintEmail').AsBoolean;
    FbEnableVoucherSalePrintSMS                 := FieldByName('EnableVoucherSalePrintSMS').AsBoolean;
    FbInvoiceHasToBeApproved                    := FieldByName('InvoiceHasToBeApproved').AsBoolean;
    FbEnableBoinBOMsalesOrder                   := FieldByName('EnableBoinBOMsalesOrder').AsBoolean;
    FsVoucherSalePrintEmailSubject              := FieldByName('VoucherSalePrintEmailSubject').AsString;
    FsVoucherSalePrintEmailText                 := FieldByName('VoucherSalePrintEmailText').AsString;
    FsVoucherSalePrintSMSText                   := FieldByName('VoucherSalePrintSMSText').AsString;
    fPrintStatementsSMSText                     := FieldByName('PrintStatementsSMSText').AsString;
    fARSMSText                                  := FieldByName('ARSMSText').AsString;
    FsSavesoundfile                             := FieldByName('Savesoundfile').AsString;
    FsPrintsoundfile                            := FieldByName('Printsoundfile').AsString;
    FsCancelsoundfile                           := FieldByName('Cancelsoundfile').AsString;
    FsEmailsoundfile                            := FieldByName('Emailsoundfile').AsString;
    FbEnableSoundonSave                         := FieldByname('EnableSoundonSave').AsBoolean;
    FbEnableSoundonPrint                        := FieldByname('EnableSoundonPrint').AsBoolean;
    FbEnableSoundonCancel                       := FieldByname('EnableSoundonCancel').AsBoolean;
    FbEnableSoundonEmail                        := FieldByname('EnableSoundonEmail').AsBoolean;
    FDepreciationCalcStart1                     := FieldByName('DepreciationCalcStart1').AsString;
    FDepreciationCalcStart2                     := FieldByName('DepreciationCalcStart2').AsString;
    FPQADEtailsCUSTFLD1                         := FieldByName('PQADEtailsCUSTFLD1').AsString;
    FEnablePQADEtailsCUSTFLD1                   := FieldByName('EnablePQADEtailsCUSTFLD1').AsBoolean;
    FPQADEtailsCUSTFLD4                         := FieldByName('PQADEtailsCUSTFLD4').AsString;
    FEnablePQADEtailsCUSTFLD4                   := FieldByName('EnablePQADEtailsCUSTFLD4').AsBoolean;
    FDisableAuditTrialinQuickPOS                := FieldByName('DisableAuditTrialinQuickPOS').AsBoolean;
    FCompleteBOMOrderOnSave                     := FieldByName('CompleteBOMOrderOnSave').AsBoolean;
    FAutoScheduleBasedonBOMEmpRoster            := FieldByName('AutoScheduleBasedonBOMEmpRoster').AsBoolean;
	FOnlyshowScheduledJobsForBarCodeMan           := FieldByName('OnlyshowScheduledJobsForBarCodeMan').AsBoolean;
    FAllowShipmentsFromSalesOrder               := FieldByName('AllowShipmentsFromSalesOrder').AsBoolean;
    fShowEdiIntegration                         := FieldByName('ShowEdiIntegration').AsBoolean;
    fPreventInvoiceOnStopCredit                 := FieldByName('PreventInvoiceOnStopCredit').AsBoolean;
    fPreventSalesOrderOnStopCredit              := FieldByName('PreventSalesOrderOnStopCredit').AsBoolean;
    FbAccountPosingPopulated                    := FieldByName('AccountPosingPopulated').AsBoolean;
    FbCompanyDefaultsSelected                   := FieldByName('CompanyDefaultsSelected').AsBoolean;
    fbcheckforStockinOtherDept                  := Fieldbyname('checkforStockinOtherDept').asBoolean;
    //fbAllowSplitPaymentInInvoice              := FieldByname('AllowSplitPaymentInInvoice').asBoolean;
    fInvoiceMailAttachmentSubject               := FieldByName('InvoiceMailAttachmentSubject').AsString;
    fInvoiceMailAttachmentBodyText              := FieldBYName('InvoiceMailAttachmentBodyText').ASString;
    fbPrintEOPProductGroupreport                := fieldbyname('PrintEOPProductGroupreport').asBoolean;
    fCombinePOSQuntities                        := FieldByName('CombinePOSQuntities').AsBoolean;
    fAutoAppendBatchNumber                      := fieldbyname('AutoAppendBatchNumber').asBoolean;
    fAllProductGroupsforSalesCollatedByItemreport   := fieldbyname('AllProductGroupsforSalesCollatedByItemreport').asBoolean;
    fUseBarcodeDispatch                         := FieldByName('UseBarcodeDispatch').AsBoolean;
    fStandardCostCOGSAdjustmentAccountID        := FieldByName('StandardCostCOGSAdjustmentAccountID').AsInteger;
    fStandardCostPurchaseAdjustmentAccountID    := FieldByName('StandardCostPurchaseAdjustmentAccountID').AsInteger;
    fIncludeContactNameInSalesBillingAddress    := FieldByName('IncludeContactNameInSalesBillingAddress').AsBoolean;
    fUseInventoryStandardCosting                := FieldByName('UseInventoryStandardCosting').AsBoolean;
    fUseCustFld1ForSaleLineBatchAllocation      := FieldByName('UseCustFld1ForSaleLineBatchAllocation').AsBoolean;
    fExcludeZeroAllocationsFromPickingSlip      := FieldByName('ExcludeZeroAllocationsFromPickingSlip').AsBoolean;
    fAutoPopUpBarcodePickingOptions             := FieldByName('AutoPopUpBarcodePickingOptions').AsBoolean;
    fEnforceConNoteOnSale                       := FieldByName('EnforceConNoteOnSale').AsBoolean;
    fUOMToBeUsedInManufactureDefault            := FieldByName('UOMToBeUsedInManufactureDefault').AsString;
    // fUPSPassword                             := FieldByName('UPSPassword').AsString;
    // fUPSAccessKey                            := FieldByName('UPSAccessKey').AsString;
    // fUPSServer                               := FieldByName('UPSServer').AsString;
    // fUPSEnabled                              := FieldByName('UPSEnabled').AsBoolean;
    // fUPSUserID                               := FieldByName('UPSUserID').AsString;
    // fUPSAccountNumber                        := FieldByName('UPSAccountNumber').AsString;

    FdSurchargePercent1                         := FieldByName('SurchargePercent1').AsFloat;
    FdSurchargePercent2                         := FieldByName('SurchargePercent2').AsFloat;
    FdSurchargePercent3                         := FieldByName('SurchargePercent3').AsFloat;
    FdSurchargePercent4                         := FieldByName('SurchargePercent4').AsFloat;
    if FdSurchargePercent2 =0 then FdSurchargePercent2 := FdSurchargePercent1;
    if FdSurchargePercent3 =0 then FdSurchargePercent3 := FdSurchargePercent2;
    if FdSurchargePercent4 =0 then FdSurchargePercent4 := FdSurchargePercent3;

    fDefaultSuperOnTimesheet                    := FieldByName('DefaultSuperOnTimesheet').AsBoolean;
    fUseSupportEmail                            := FieldByName('UseSupportEmail').AsBoolean;
    fPOSPostBlindBalanceVariance                := FieldByName('POSPostBlindBalanceVariance').AsBoolean;
    fEOPReportShowAlltimeSlots                  := FieldByName('EOPReportShowAlltimeSlots').AsBoolean;
    fUseCashDrop                                := FieldByName('UseCashDrop').AsBoolean;
    fCashDropLotsOf                             := FieldByName('CashDropLotsOf').asInteger;
    fPOSBliandBalanceVarianceAccount            := FieldByName('POSBliandBalanceVarianceAccount').AsString;
    //fEnablePackWeight                         := FieldByName('EnablePackWeight').AsBoolean;
    fEnablePackWeightField1                     := FieldByName('EnablePackWeightField1').AsBoolean;
    fEnablePackWeightField2                     := FieldByName('EnablePackWeightField2').AsBoolean;
    fPackWeightField1                           := FieldByName('PackWeightField1').AsString; if fPackWeightField1 = '' then fPackWeightField1   := 'Weight';
    fPackWeightField2                           := FieldByName('PackWeightField2').AsString; if fPackWeightField2 = '' then fPackWeightField2   := 'Length';
    fiPackWeightQtyField                        := FieldByName('PackWeightQtyField').asInteger;
    fDefaultHireIncomeAccount                   := FieldByName('DefaultHireIncomeAccount').AsString;
    fDefaultHireProductName                     := FieldByName('DefaultHireProductName').AsString;

    fsNewRepairNotesText                        := FieldByName('NewRepairNotesText').asString;
    fsFeQtyFieldInfodisplayLabel                := FieldByName('FeQtyFieldInfodisplayLabel').asString; if fsFeQtyFieldInfodisplayLabel = '' then fsFeQtyFieldInfodisplayLabel   := 'Qty';
    fAddNotesToNewRepair                        := FieldByName('AddNotesToNewRepair').asBoolean;
    fProductReorderRoundNearest                 := FieldByName('ProductReorderRoundNearest').AsBoolean;
    fProductReorderRoundValue                   := FieldByName('ProductReorderRoundValue').AsInteger;
    FShowRelatedProductSelectioninSale          := FieldByName('ShowRelatedProductSelectioninSale').AsBoolean;
    FbHideCustTypeNotSelectedinSlsCatgbyItmRpt  := FieldByName('HideCustomertypeNotSelectedinSalesCatgbyItemReport').AsBoolean;
    FPOHasPeriodPosting                         := FieldByName('POHasPeriodPosting').AsBoolean;
    fCashDropLimit                              := FieldByName('CashDropLimit').AsInteger;
    fClientPrintNameHeading                     := FieldByName('ClientPrintNameHeading').ASString; if fClientPrintNameHeading = '' then fClientPrintNameHeading                      := 'Print Name';
    fProductPrintNameHeading                    := FieldByName('ProductPrintNameHeading').ASString; if fProductPrintNameHeading = '' then fProductPrintNameHeading                      := 'Print Name';
    fFreightChargeProduct                       := FieldByName('FreightChargeProduct').AsString;
    fStateFreightChargeEnabled                  := FieldByName('StateFreightChargeEnabled').AsBoolean;
    fCopyProductPrintNameToName                 := FieldByName('CopyProductPrintNameToName').AsBoolean;
    fCopyClientPrintNameToName                  := FieldByName('CopyClientPrintNameToName').AsBoolean;
    fLoginExpireDays                            := FieldByName('LoginExpireDays').AsInteger;
    fLoginExpireDate                            := FieldByName('LoginExpireDate').AsDateTime;
    fSalesBackorderCheckType                    := FieldByName('SalesBackorderCheckType').AsString;
    fsPOCreateOptiononSalesToSOconvertion       := FieldByName('POCreateOptiononSalesToSmartOrderconvertion').AsString;
    fBlankLinesinSuppPaymentCheque              := FieldByName('BlankLinesinSuppPaymentCheque').AsInteger;
    fSalesDefaultAreaFromCustomer               := FieldByName('SalesDefaultAreaFromCustomer').AsBoolean;
    fPurchaseDefaultAreaFromSupplier            := FieldByName('PurchaseDefaultAreaFromSupplier').AsBoolean;
    fsCreditCheckTermsInv                       := FieldByName('CreditCheckTermsInv').AsString;
    fsCreditCheckTermsSO                        := FieldByName('CreditCheckTermsSO').AsString;
    fbChangeCreditCheckTermsInv                 := FieldByName('ChangeCreditCheckTermsInv').ASBoolean;
    fbChangeCreditCheckTermsSO                  := FieldByName('ChangeCreditCheckTermsSO').ASBoolean;
    fbAutoLocateproductinList                   := FieldByName('AutoLocateproductinList').ASBoolean;
    fbAutoLocateLastRecord                      := FieldByName('AutoLocateLastRecord').ASBoolean;
    fDisableSaleLineZeroQuantityWarning         := FieldByName('DisableSaleLineZeroQuantityWarning').ASBoolean;
    fDisablePurchaseLineZeroQuantityWarning     := FieldByName('DisablePurchaseLineZeroQuantityWarning').ASBoolean;
    FsPOStoreAwayTemplate                       := FieldByName('POStoreAwayTemplate').AsString;
    FiAccountNamecolumnDropdownWidth            := FieldByName('AccountNamecolumnDropdownWidth').AsInteger;
    FiAccountTypecolumnDropdownWidth            := FieldByName('AccountTypecolumnDropdownWidth').AsInteger;
    FiAccountDescriptioncolumnDropdownWidth     := FieldByName('AccountDescriptioncolumnDropdownWidth').AsInteger;
    fSalesTaxThresholdWholeOrder                := FieldByName('SalesTaxThresholdWholeOrder').AsBoolean;
    fShowSaleLineInStockQty                     := FieldByName('ShowSaleLineInStockQty').AsBoolean;
    fMatchInvoiceDAteToShipDate                 := FieldByName('MatchInvoiceDAteToShipDate').AsBoolean;
    fMatchInvoiceDateToETADate                  := FieldByName('MatchInvoiceDateToETADate').AsBoolean;
    fCustEarlyPaymentAction                     := FieldByName('CustEarlyPaymentAction').AsInteger;
    fSuppEarlyPaymentAction                     := FieldByName('SuppEarlyPaymentAction').AsInteger;
    fOpenfileWhenDataExported                   := FieldByName('OpenfileWhenDataExported').AsBoolean;
    fUseERPFilenameforDataExport                := FieldByName('UseERPFilenameforDataExport').AsBoolean;
    FsDataExportDefaultExtension                := FieldByName('DataExportDefaultExtension').AsString; if FsDataExportDefaultExtension = '' then FsDataExportDefaultExtension := 'TXT';
    FbUpdateProductDescriptionFromTreeInfo      := FieldByName('UpdateProductDescriptionFromTreeInfo').AsBoolean;
    FbUpdateSalesDescriptionFromTreeInfo        := FieldByName('UpdateSalesDescriptionFromTreeInfo').AsBoolean;
    FbBOMPriceOverridesAllOtherPrice            := FieldByName('BOMPriceOverridesAllOtherPrice').AsBoolean;
    FbIgnoreBOMCalcPriceOnSale                  := FieldByName('IgnoreBOMCalcPriceOnSale').AsBoolean;
    FbSubBOMUseAvailableQtyFromStock            := FieldByName('SubBOMUseAvailableQtyFromStock').AsBoolean;
    FbCSPOverridesRawMaterialPrices             := FieldByName('CSPOverridesRawMaterialPrices').AsBoolean;
    fbAllowChangingProductAllocationFlags       := FieldByName('AllowChangingProductAllocationFlags').AsBoolean;
    FbUpdateLinenowhenManufacturingUpdateBatch  := FieldByName('UpdateLinenowhenManufacturingUpdateBatch').AsBoolean;
    fUserSetMainSwitchHeight                    := FieldByName('UserSetMainSwitchHeight').AsInteger;
    fGenerateEmployeeno                         := FieldByName('GenerateEmployeeno').AsBoolean;
    fConfirmProductAutoPriceUpdate              := FieldByName('ConfirmProductAutoPriceUpdate').AsBoolean;
    fCostUpdateFromPurchase                     := FieldByName('CostUpdateFromPurchase').AsBoolean;
    FbShowMultiSelectSelectionList              := FieldByName('ShowMultiSelectSelectionList').AsBoolean;
    fUseBankStatements                          := FieldByName('UseBankStatements').AsBoolean;
    fSortRelatedProductsinSale                  := FieldByName('SortRelatedProductsinSale').AsBoolean;
    fCostEditableinSales                        := FieldByName('CostEditableinSales').AsBoolean;
    fDosyncSerialnumberlist                     := FieldByName('DosyncSerialnumberlist').AsBoolean;
    fErpApiEnabled                              := FieldByName('ErpApiEnabled').AsBoolean;
    fErpApiPort                                 := FieldByName('ErpApiPort').AsInteger;
    fShowToDoNotifications                      := FieldByName('ShowToDoNotifications').AsBoolean;
    fDefaultNotifyNewSmartOrder                 := FieldByName('DefaultNotifyNewSmartOrder').AsBoolean;
    fDefaultNotifyEditingSmartOrder             := FieldByName('DefaultNotifyEditingSmartOrder').AsBoolean;
    fDefaultShowPOfromSmartOrder                := FieldByName('DefaultShowPOfromSmartOrder').AsBoolean;
    fDefaultSupplierallLinesSmartOrder          := FieldByName('DefaultSupplierallLinesSmartOrder').AsBoolean;
    fConvertSOIntoPOOnApproval                  := FieldByName('ConvertSOIntoPOOnApproval').AsBoolean;
    fDefaultNotifyPurchaseOrderChange           := FieldByName('DefaultNotifyPurchaseOrderChange').AsBoolean;
    FbConfirmQtysOnfinalise                     := FieldByName('ConfirmQtysOnfinalise').AsString = 'T';

    FbUpdatebatchRunVS1_sum                     := FieldByName('UpdatebatchRunVS1_sum').AsString = 'T';
    FbUpdatebatchRunVS1_PnLReport               := FieldByName('UpdatebatchRunVS1_PnLReport').AsString = 'T';
    FbUpdatebatchRunVS1_PnLReport_Sum           := FieldByName('UpdatebatchRunVS1_PnLReport_Sum').AsString = 'T';
    FbUpdatebatchRunVS1_APReport                := FieldByName('UpdatebatchRunVS1_APReport').AsString = 'T';
    FbUpdatebatchRunVS1_SalesList               := FieldByName('UpdatebatchRunVS1_SalesList').AsString = 'T';
    FbUpdatebatchRunVS1_PQASumList              := FieldByName('UpdatebatchRunVS1_PQASumList').AsString = 'T';
    FbUpdatebatchRunVS1_Sum2                    := FieldByName('UpdatebatchRunVS1_Sum2').AsString = 'T';

    FbEnableWalmart                             := WalmartConfig.EnableWalmart;
    FbWALMART_AutocheckforOrdersinList          := FieldByName('WALMART_AutocheckforOrdersinList').AsString = 'T';
    FbWALMART_AutoUpdateProductQty              := FieldByName('WALMART_AutoUpdateProductQty').AsString = 'T';
    FbWALMART_IgnoreTaxonSale                   := FieldByName('WALMART_IgnoreTaxonSale').AsString = 'T';
    fWalmartcustomer                            := FieldByName('Walmartcustomer').AsString;
    fWALMART_ConsumerId                         := FieldByName('WALMART_ConsumerId').AsString;
    fWALMART_PrivateKey                         := FieldByName('WALMART_PrivateKey').AsString;
    fWALMART_ChannelType                        := FieldByName('WALMART_ChannelType').AsString;
    fWALMART_ProductNameField                   := FieldByName('WALMART_ProductNameField').AsString; if fWALMART_ProductNameField = '' then fWALMART_ProductNameField  := 'P';
    FbWALMARTOrderSilentProcessShipment         := FieldByName('WALMARTOrderSilentProcessShipment').AsString = 'T';
    FbWalmart_EnableInvFeed                     := FieldByName('Walmart_EnableInvFeed').AsString = 'T';
    //FbEnableEbay                                := true;// HasEbayforThisDB;

    FbShowWalmartonMainmenubyDefault            := FieldByName('ShowWalmartonMainmenubyDefault').AsString = 'T';
    FbShowEbayonMainMenubyDefault               := FieldByName('ShowEbayonMainMenubyDefault').AsString = 'T';
    fTrialBalanceAdjustAccount                  := FieldByName('TrialBalanceAdjustAccount').AsInteger;
//    fWooCommerce_consumerKey                    := FieldByName('WooCommerce_consumerKey').AsString;
//    fWooCommerce_consumerSecretKey              := FieldByName('WooCommerce_consumerSecretKey').AsString;
//    fWooCommerce_URL                            := FieldByName('WooCommerce_URL').AsString;
    FbEnableWooCommerce                         := (FieldByName('EnableWooCommerce').AsString = 'T') ;
    FbShowWooCommerceonMainmenubyDefault        := (FieldByName('ShowWooCommerceonMainmenubyDefault').AsString = 'T') and FbEnableWooCommerce;
//    fWoocommerce_ProductNameField               := FieldByName('Woocommerce_ProductNameField').AsString; if fWoocommerce_ProductNameField = '' then fWoocommerce_ProductNameField   := 'P';
//    FbWooCommerce_AutocheckforOrdersinList      := FieldByName('WooCommerce_AutocheckforOrdersinList').AsString = 'T';
    fBuildDetailsUpdateOption                   := FieldByName('BuildDetailsUpdateOption').AsString;
    fCrosscompanySalesForPOType                 := FieldByName('CrosscompanySalesForPOType').AsString;
    FbGrossWeightnQtyRelated                    := FieldByName('GrossWeightnQtyRelated').AsString = 'T';
    FbMakeMcforClients                          := FieldByName('MakeMcforClients').AsString = 'T';
    FbDoUpdateProductQtySum                     := FieldByName('DoUpdateProductQtySum').AsBoolean;
    fCoreEDIUSerName                            := FieldByName('CoreEDIUSerName').AsString;
    fCoreEDIPassword                            := FieldByName('CoreEDIPassword').AsString;
    fCoreEDIServiceUSerName                     := AppEnv.CompanyInfo.email;
    fCoreEDIServicePassword                     := FieldByName('CoreEDIServicePassword').AsString;
    fCoreEDIServiceHost                         := FieldByName('CoreEDIServiceHost').AsString;
    fCoreEDIServicePort                         := FieldByName('CoreEDIServicePort').AsInteger;

    FbShowSaturdayinApptCalendar  := FieldByName('ShowSaturdayinApptCalendar').AsBoolean;
    FbShowSundayinApptCalendar    := FieldByName('ShowSundayinApptCalendar').AsBoolean;
    FbShowMondayinApptCalendar    := FieldByName('ShowMondayinApptCalendar').AsBoolean;
    FbShowTuesdayinApptCalendar   := FieldByName('ShowTuesdayinApptCalendar').AsBoolean;
    FbShowWednesdayinApptCalendar := FieldByName('ShowWednesdayinApptCalendar').AsBoolean;
    FbShowThursdayinApptCalendar  := FieldByName('ShowThursdayinApptCalendar').AsBoolean;
    FbShowFridayinApptCalendar    := FieldByName('ShowFridayinApptCalendar').AsBoolean;
    FsApptStartTime               := FieldByName('ApptStartTime').AsString;
    FsApptEndtime                 := FieldByName('ApptEndtime').AsString;
    fiDefaultApptDuration         := FieldByName('DefaultApptDuration').AsInteger;
    fiRoundApptDurationTo         := FieldByName('RoundApptDurationTo').AsInteger;
    fiShowApptDurationin          := FieldByName('ShowApptDurationin').AsInteger;
    fiDefaultServiceProductID     := FieldByName('DefaultServiceProductID').AsInteger;
    FsNonERPClone_User            := FieldByName('NonERPClone_User').AsString;
    FsNonERPClone_Password            := FieldByName('NonERPClone_Password').AsString;

//    if sametext(copy(fWooCommerce_URL , length(fWooCommerce_URL)-length('wp-json/wc/v3')+1 , length('wp-json/wc/v3')) ,'wp-json/wc/v3') then
//    else if copy(fWooCommerce_URL, length(fWooCommerce_URL) , 1) ='/' then fWooCommerce_URL:= fWooCommerce_URL +'wp-json/wc/v3'
//    else fWooCommerce_URL:= fWooCommerce_URL +'/wp-json/wc/v3';
//
//    FbHasWooCommerceCredentials := (FbEnableWooCommerce) and
//                                   (trim(fWooCommerce_consumerKey)<> '') and
//                                   (trim(fWooCommerce_consumerSecretKey)<> '') and
//                                   (trim(fWooCommerce_URL)<> '') ;

    if AssigneD(fIntuitConfig) and (fCoreEDIUSerName ='') and (fIntuitConfig.S['CoreEDIUser']     <> '') then CoreEDIUSerName :=fIntuitConfig.S['CoreEDIUser'];
    if AssigneD(fIntuitConfig) and (fCoreEDIPassword ='') and (fIntuitConfig.S['CoreEDIPassword'] <> '') then CoreEDIPassword :=fIntuitConfig.S['CoreEDIPassword'];

    PopulateFenames;
    CheckForHasExcelPrices;
  Finally
    FreeAndNil(QryPrefs);
  End;
End;
function TCompanyPrefObj.GetCreatePOOnSalesToSmartOrderconvertion         : Boolean ;begin result := fsPOCreateOptiononSalesToSOconvertion='A';end;
function TCompanyPrefObj.getCrosscompanySalesForPOTypeDesc: String;
begin
  if CrosscompanySalesForPOType = 'I' then Result := 'Invoice'
  else result := 'Sales Order';
end;

function TCompanyPrefObj.GetConfirmPOCreationOnSalesToSmartOrderconvertion: Boolean ;begin result := fsPOCreateOptiononSalesToSOconvertion='C';end;
function TCompanyPrefObj.GetDonotCreatePOOnSalesToSmartOrderconvertion    : Boolean ;begin result := fsPOCreateOptiononSalesToSOconvertion='D';end;

Function TCompanyPrefObj.Colourof(Const Colour, GradIntensity: Integer): TColor;
Begin
  Result := ColorAdjustLuma(Colour, GradIntensity Div 2, False);
End;

Function TCompanyPrefObj.ReadskypePath: String;
Var
  FRegEdit: TRegEdit;
Begin
  FRegEdit   := TRegEdit.Create(Nil);
  Try Result := FRegEdit.ReadLocalMachineRegistry('SOFTWARE\Skype\Phone', 'skypePath');
  Finally FreeAndNil(FRegEdit);
  End;
End;

// function TCompanyPrefObj.ReadTeamViewerPath: string;
// var
// fRegEdit:TRegEdit;
// begin
// fRegEdit:=TRegEdit.Create(nil);
// try
// result:= fRegEdit.ReadLocalMachineRegistry('SOFTWARE\TeamViewer\Version6' , 'InstallationDirectory')  ;
// finally
// Freeandnil(fRegEdit);
// end;
// end;

Function TCompanyPrefObj.LoadFieldValue(Const Name: String): Variant;
Begin
  Result   := '';
  QryPrefs := TERPQuery.Create(Nil);
  Try
    QryPrefs.Options.FlatBuffers := True;
    QryPrefs.Connection          := CommonDbLib.GetSharedMyDacConnection;
    QryPrefs.SQL.Add('SELECT * FROM tbldbpreferences');

    If Not QryPrefs.Connection.Connected Then Begin
      Exit;
    End;
    QryPrefs.Open;
    If FieldByName(Name).AsVariant <> Null Then Result := FieldByName(Name).AsVariant;
  Finally FreeAndNil(QryPrefs);
  End;
End;

Procedure TCompanyPrefObj.StoreFieldValue(Const Name: String; Const Value: Variant);
Var
  FieldType: String;
Begin
  QryPrefs                     := TERPQuery.Create(Nil);
  QryPrefs.Options.FlatBuffers := True;
  Try
    QryPrefs.Connection := CommonDbLib.GetSharedMyDacConnection;
    QryPrefs.SQL.Add('SELECT * FROM tbldbpreferences');
    QryPrefs.Open;

    FieldByName(Name).AsString;
    FieldType := QryPrefs.FieldByName('FieldType').AsString;

    If SysUtils.SameText(FieldType, 'ftDate') Or SysUtils.SameText(FieldType, 'ftTime') Or SysUtils.SameText(FieldType, 'ftDateTime') Then FieldByName(Name).AsString := FloatToStr(Value)
    Else If SysUtils.SameText(FieldType, 'ftBoolean') Then Begin
      If SameText(Value, 'T') Or SameText(Value, 'True') Then FieldByName(Name).AsString := 'T'
      Else FieldByName(Name).AsString                                                    := 'F';
    End
    Else FieldByName(Name).AsVariant := Value;
  Finally FreeAndNil(QryPrefs);
  End;
End;

Procedure TCompanyPrefObj.SetLoyaltyReminderDate(Const Value: TDateTime);
Begin
  If Value <> FdtLoyaltyReminderDate Then Begin
    FdtLoyaltyReminderDate := Value;
    StoreFieldValue('LoyaltyReminderDate', Value);
  End;
End;

Procedure TCompanyPrefObj.SetMonthsStockRetained(Const Value: Integer);
Begin
  If Value <> FiMonthsStockRetained Then Begin
    FiMonthsStockRetained := Value;
    StoreFieldValue('MonthsStockRetained', Value)
  End;
End;


Function TCompanyPrefObj.GetBarTabsConvertStarted: Boolean;
Begin
  If SysUtils.SameText(LoadFieldValue('BarTabsConvertStarted'), 'T') Then Result := True
  Else Result                                                                    := False;
End;

Procedure TCompanyPrefObj.SetBarTabsConvertStarted(Const Value: Boolean);
Begin
  If Value <> FbBarTabsConvertStarted Then Begin
    FbBarTabsConvertStarted := Value;

    If Value Then StoreFieldValue('BarTabsConvertStarted', 'T')
    Else StoreFieldValue('BarTabsConvertStarted', 'F');
  End;
End;
Procedure TCompanyPrefObj.SetCreditTermsID(Value: Integer);
begin
  If Value <> fiCreditTermsID Then Begin
    fiCreditTermsID := Value;
    StoreFieldValue('CreditTermsID', fiCreditTermsID);
  End;
end;
Procedure TCompanyPrefObj.SetDebitTermsID(Value: Integer);
begin
  If Value <> fiDebitTermsID Then Begin
    fiDebitTermsID := Value;
    StoreFieldValue('DebitTermsID', fiDebitTermsID);
  End;
end;
Procedure TCompanyPrefObj.SetMultiTills(Value: Boolean);
Begin
  If Value <> FbMultiTills Then Begin
    FbMultiTills := Value;

    If Value Then StoreFieldValue('MultiTills', 'T')
    Else StoreFieldValue('MultiTills', 'F');
  End;
End;

Function TCompanyPrefObj.GetBatchUpdateInProgress: Boolean;
Begin
  If SysUtils.SameText(LoadFieldValue('BatchUpdateInProgress'), 'T') Then Result := True
  Else Result  := False;
End;
Function TCompanyPrefObj.GetEnableWebAPILoging: Boolean;
Begin
  If SysUtils.SameText(LoadFieldValue('EnableWebAPILoging'), 'T') Then Result := True
  Else Result  := False;
End;

function TCompanyPrefObj.GetBlankAllocationBatchTruckLoadNo             : Boolean;begin  REsult := Sametext(fsAllocationBatchTruckLoadNoGenerateMode , 'B')end;
function TCompanyPrefObj.getCostDecimalPlacesinTree: Integer;
begin
  result := fiCostDecimalPlacesinTree;
  if result =0 then Result := appenv.RegionalOptions.DecimalPlaces;
end;

function TCompanyPrefObj.getFiscalYearStartsno: Integer;
begin
       if sametext(fbFiscalYearStarts  , 'January'  ) then Result := 1
  else if sametext(fbFiscalYearStarts  , 'February' ) then Result := 2
  else if sametext(fbFiscalYearStarts  , 'March'    ) then Result := 3
  else if sametext(fbFiscalYearStarts  , 'April'    ) then Result := 4
  else if sametext(fbFiscalYearStarts  , 'May'      ) then Result := 5
  else if sametext(fbFiscalYearStarts  , 'June'     ) then Result := 6
  else if sametext(fbFiscalYearStarts  , 'July'     ) then Result := 7
  else if sametext(fbFiscalYearStarts  , 'August'   ) then Result := 8
  else if sametext(fbFiscalYearStarts  , 'September') then Result := 9
  else if sametext(fbFiscalYearStarts  , 'October'  ) then Result := 10
  else if sametext(fbFiscalYearStarts  , 'November' ) then Result := 11
  else if sametext(fbFiscalYearStarts  , 'December' ) then Result := 12
  else result := 0;

end;

function TCompanyPrefObj.GetGenerateNextNoforAllocationBatchTruckLoadNo : Boolean;begin  REsult := Sametext(fsAllocationBatchTruckLoadNoGenerateMode , 'G')end;


Procedure TCompanyPrefObj.CheckForHasExcelPrices;
var
  Qry  : TERPQuery;
begin

  fbHasExcelPrices := False;
  if not TableExists('tblpartsforexcelprice') then exit;

  Qry  := TERPQuery.Create(Nil);
  try
    Qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    Qry.SQL.Text := 'select COUNT(*) ctr from tblpartsforexcelprice';
    OpenDb(Qry);
    fbHasExcelPrices := Qry.fieldbyname('ctr').asInteger >0;
  finally
    Qry.ClosenFree;
  end;
end;

function TCompanyPrefObj.GetKeepSameNoforAllocationBatchTruckLoadNo     : Boolean;begin  REsult := Sametext(fsAllocationBatchTruckLoadNoGenerateMode , 'S')end;

Function TCompanyPrefObj.GetDaysinWeek: Integer;
Begin
  Result := 7 - NoofWeekendDays;
End;
function TCompanyPrefObj.getDefaultServiceProduct: String;
begin
  With CommonDbLib.TempMyquery Do
    Try
      SQL.Add('Select Partname from tblparts where partsId = '+ inttostr(DefaultServiceProductID));
      Open;
      Result := FieldByName('Partname').asString;
    Finally
      ClosenFree;
    End;
end;

Function TCompanyPrefObj.GetFirstTransDAte: TDateTime;
Begin
  Result := 0;
  With CommonDbLib.TempMyquery Do
    Try
      SQL.Add('select min(Date) date from tbltransactionsummarydetails');
      Open;
      Result := FieldByName('Date').AsDateTime;
      If Result > 0 Then Exit;

      If Active Then Close;
      SQL.Clear;
      SQL.Add('Select min(date) Date from tbltransactionsummary');
      Open;
      Result := FieldByName('Date').AsDateTime;
      If Result > 0 Then Exit;

      If Active Then Close;
      SQL.Clear;
      SQL.Add('Select min(date) Date from tbltransactions');
      Open;
      Result := FieldByName('Date').AsDateTime;
      If Result > 0 Then Exit;
      Result := SummarisedTransDate;
    Finally
      Result := Dateof(Result);
      ClosenFree;
    End;
End;

function TCompanyPrefObj.GetFiscalYearStartingDate: TDateTime;
begin
  Result := incday(ClosingDate);
end;

Function TCompanyPrefObj.GetHoursinaDay: Double;
Begin
  Try Result    := HoursPerWeek / DaysinWeek;
  Except Result := 7.5;
  End;
End;


Procedure TCompanyPrefObj.SetBatchUpdateInProgress(Const Value: Boolean);
Begin
  If Value <> FbBatchUpdateInProgress Then Begin
    FbBatchUpdateInProgress := Value;

    If Value Then StoreFieldValue('BatchUpdateInProgress', 'T')
    Else StoreFieldValue('BatchUpdateInProgress', 'F')
  End;
End;

Procedure TCompanyPrefObj.SetTransactionTableLastUpdated(Const Value: TDateTime);
Begin
  If Value <> FdtTransactionTableLastUpdated Then Begin
    FdtTransactionTableLastUpdated := Value;
    StoreFieldValue('TransactionTableLastUpdated', Value)
  End;
End;

Function TCompanyPrefObj.GetTeamViewerPath: String;
Var
  Path  : String;
  Ctr, X: Integer;
Const
  Programfiles: Array [1 .. 2] Of Integer = (CSIDL_PROGRAM_FILESX86, CSIDL_PROGRAM_FILES);
Begin
  If FsTeamViewerPath = '' Then Begin
    For Ctr := Low(Programfiles) To High(Programfiles) Do Begin
      Path  := SpecialFolder( Programfiles[Ctr]) + 'TeamViewer';
      If DirectoryExists(Path) Then Begin
        Path  := IncludeTrailingPathDelimiter(Path);
        For X := 50 Downto 6 Do Begin
          If DirectoryExists(Path + 'Version' + IntToStr(X)) Then Begin
            FsTeamViewerPath := Path + 'Version' + IntToStr(X);
            Break;
          End;
        End;
      End;
    End;
  End;
  Result := FsTeamViewerPath;
End;
Function TCompanyPrefObj.GetERPSupportPath: String;
Var
  Path  : String;
  Ctr: Integer;
Const
  Programfiles: Array [1 .. 2] Of Integer = (CSIDL_PROGRAM_FILESX86, CSIDL_PROGRAM_FILES);
Begin
  If FsERPSupportPath = '' Then Begin
    For Ctr := Low(Programfiles) To High(Programfiles) Do Begin
      Path  := SpecialFolder( Programfiles[Ctr]) + 'ERP Software\';
      If DirectoryExists(Path) Then Begin
        Path  := IncludeTrailingPathDelimiter(Path);
        if FileExists(Path + '\TrueERP Support.exe') then begin
            FsERPSupportPath := Path ;
            Break;
        end;
      End;
    End;
  End;
  Result := FsERPSupportPath;
End;

Function TCompanyPrefObj.GetTransactionTableLastUpdated: TDateTime;
Begin
  Result := LoadFieldValue('TransactionTableLastUpdated');
End;

Function TCompanyPrefObj.GetPartCalcfield1Visible: Boolean;
Begin
  Result := PartCalcfield1 And (Trim(PartCalcField1Name) <> '');
End;

Function TCompanyPrefObj.GetPartCalcfield2Visible: Boolean;
Begin
  Result := PartCalcfield2 And (Trim(PartCalcfield2Name) <> '');
End;

Function TCompanyPrefObj.GetPartCalcfield3Visible: Boolean;
Begin
  Result := PartCalcfield3 And (Trim(PartCalcfield3Name) <> '');
End;

Function TCompanyPrefObj.GetPartCalcfield4Visible: Boolean;
Begin
  Result := PartCalcfield4 And (Trim(PartCalcfield4Name) <> '');
End;

Function TCompanyPrefObj.GetPartCalcfield5Visible: Boolean;
Begin
  Result := PartCalcfield5 And (Trim(PartCalcfield5Name) <> '');
End;

Function TCompanyPrefObj.GetPurchaseETAFromProductNormalDeliveryTime: Boolean;
Begin
  Result := PurchaseETACalculatedFrom = 'P';
End;

Function TCompanyPrefObj.GetPurchaseETAFromSupplierShippingtime: Boolean;
Begin
  Result := PurchaseETACalculatedFrom = 'S';
End;

Function TCompanyPrefObj.GetReportTablesLastUpdatedOn: TDateTime;
Begin
  Result := LoadFieldValue('ReportTablesLastUpdatedOn');
End;
Function TCompanyPrefObj.GetSerialNumberListUpdatedOn: TDateTime;
Begin
  Result := LoadFieldValue('SerialNumberListUpdatedOn');
End;

Function TCompanyPrefObj.GetPartCalcfieldVisible: Boolean;
Begin
  Result := PartCalcfield1Visible Or PartCalcfield2Visible Or PartCalcfield3Visible Or PartCalcfield4Visible Or PartCalcfield5Visible;
End;
Function TCompanyPrefObj.GetFeFieldVisible: Boolean;
Begin
  Result := Fe1Visible Or Fe2Visible Or Fe3Visible Or Fe4Visible Or Fe5Visible;
End;

Procedure TCompanyPrefObj.SetReportTablesLastUpdatedOn(Const Value: TDateTime);
Begin
  If Value <> FdtReportTablesLastUpdatedOn Then Begin
    FdtReportTablesLastUpdatedOn := Value;
    StoreFieldValue('ReportTablesLastUpdatedOn', Value)
  End;
End;
Procedure TCompanyPrefObj.SetSerialNumberListUpdatedOn(Const Value: TDateTime);
Begin
  If Value <> FdtSerialNumberListUpdatedOn Then Begin
    FdtSerialNumberListUpdatedOn := Value;
    StoreFieldValue('SerialNumberListUpdatedOn', Value)
  End;
End;

Procedure TCompanyPrefObj.SetSummarisedTransDate(Value: TDateTime);
Begin
  If Value <> FdSummarisedTransDate Then Begin
    FdSummarisedTransDate        := EndOfTheDay(Value);
    FdSummarisedTransDateChanged := Now;
    StoreFieldValue('SummarisedTransDate', Value);
    StoreFieldValue('SummarisedTransDateChanged', FdSummarisedTransDateChanged);
  End;
End;

Procedure TCompanyPrefObj.SetAccountPosingPopulated(Value: Boolean);
Begin
  If Value <> fbAccountPosingPopulated Then Begin
    fbAccountPosingPopulated        := Value;
    StoreFieldValue('AccountPosingPopulated', Value);
  End;
End;

procedure TCompanyPrefObj.SetAutoPopUpBarcodePickingOptions(
  const Value: boolean);
begin
  If Value <> fAutoPopUpBarcodePickingOptions Then Begin
    fAutoPopUpBarcodePickingOptions := Value;
    StoreFieldValue('AutoPopUpBarcodePickingOptions', Value);
  End;
end;

Procedure TCompanyPrefObj.SetCompanyDefaultsSelected(Value: Boolean);
Begin
  If Value <> fbCompanyDefaultsSelected Then Begin
    fbCompanyDefaultsSelected        := Value;
    StoreFieldValue('CompanyDefaultsSelected', Value);
  End;
End;

Function TCompanyPrefObj.GetSMSEnabled: Boolean;
Begin
  if Self.FSMSConfig.LastServerID = '' then begin
    Self.FSMSConfig.LastServerID := AppEnv.ServerID;
    Self.FSMSConfig.Save(CommonDbLib.GetSharedMyDacConnection);
  end;

  Result := Self.FSMSConfig.SMSEnabled and (Self.FSMSConfig.LastServerID = AppEnv.ServerID);
End;

function TCompanyPrefObj.getSpecialbarcodeformat: String;
begin
    result :='';
    if SpecialBarcodeLen = 0 then Exit;
    result := 'Total Lengh : '+inttostr(SpecialBarcodeLen)+' where '+ NL;
    if SpecialBarcodeProductPos <SpecialBarcodeAmountPos then begin
      result := result +'  Product barcode : '+ inttostr(SpecialBarcodeProductLen)+' characters '+NL  +
                '  price :'+ inttostr(SpecialBarcodeAmountLen- appenv.RegionalOptions.DecimalPlaces)+' characters ' +  appenv.RegionalOptions.WholeCurrencyName +' and '+ inttostr(Appenv.RegionalOptions.DecimalPlaces)+' characters '+ appenv.RegionalOptions.DecimalCurrencyName;
    end else begin
      result := result +'  price :'+ inttostr(SpecialBarcodeAmountLen- appenv.RegionalOptions.DecimalPlaces)+' characters ' +  appenv.RegionalOptions.WholeCurrencyName +' and '+ inttostr(Appenv.RegionalOptions.DecimalPlaces)+' characters '+ appenv.RegionalOptions.DecimalCurrencyName+NL+
                '  Product barcode : '+ inttostr(SpecialBarcodeProductLen)+' characters ';

    end;
end;

function TCompanyPrefObj.getSurchargePercentDEfined: Boolean;
begin
    Result := (SurchargePercent1<>0) or (SurchargePercent2<>0) or (SurchargePercent3<>0) or (SurchargePercent4<>0);
end;

{ TPrefConvert }

Constructor TPrefConvert.Create;
Begin
  Inherited;
  FFoundRecord := False;
  FQuery       := Nil;
End;

Function TPrefConvert.GetAsBoolean: Boolean;
Begin
  If FoundRecord Then Begin
    If (FQuery.FieldByName('FieldValue').AsString = '') And (FQuery.FieldByName('DefaultValue').AsString <> '') Then Begin
      If SysUtils.SameText(FQuery.FieldByName('DefaultValue').AsString, 'T') Then Result := True
      Else Result                                                                        := False;
    End
    Else If SysUtils.SameText(FQuery.FieldByName('FieldValue').AsString, 'T') Then Result := True
    Else Result                                                                           := False;
  End
  Else Result := False;
End;

Function TPrefConvert.GetAsCurrency: Currency;
Var
  TmpValue: String;
Begin
  If FoundRecord Then Begin
    TmpValue := FQuery.FieldByName('FieldValue').AsString;

    If (TmpValue = '') And (FQuery.FieldByName('DefaultValue').AsString <> '') Then TmpValue := FQuery.FieldByName('DefaultValue').AsString;

    If TmpValue <> '' Then Result := StrToCurr(TmpValue)
    Else Result                   := 0;
  End
  Else Result := 0;
End;

Function TPrefConvert.GetAsDateTime: TDateTime;
Var
  TmpValue: String;
Begin
  If FoundRecord Then Begin
    TmpValue := FQuery.FieldByName('FieldValue').AsString;

    If (TmpValue = '') And (FQuery.FieldByName('DefaultValue').AsString <> '') Then TmpValue := FQuery.FieldByName('DefaultValue').AsString;

    If TmpValue <> '' Then Result := StrToFloatDef(TmpValue, 0)
    Else Result                   := 0;
  End
  Else Result := 0;
End;

Function TPrefConvert.GetAsFloat: Double;
Var
  TmpValue: String;
Begin
  If FoundRecord Then Begin
    TmpValue := FQuery.FieldByName('FieldValue').AsString;

    If (TmpValue = '') And (FQuery.FieldByName('DefaultValue').AsString <> '') Then TmpValue := FQuery.FieldByName('DefaultValue').AsString;

    If TmpValue <> '' Then Result := StringUtils.StringToFloat(TmpValue) // StrToFloat(TmpValue)
    Else Result                   := 0;
  End
  Else Result := 0;
End;

Function TPrefConvert.GetAsInteger: Integer;
Begin
  If FoundRecord Then Begin
    If (FQuery.FieldByName('FieldValue').AsString = '') And (FQuery.FieldByName('DefaultValue').AsString <> '') Then Result := StrToIntDef(FQuery.FieldByName('DefaultValue').AsString, 0)
    Else Result                                                                                                             := StrToIntDef(FQuery.FieldByName('FieldValue').AsString, 0);
  End
  Else Result := 0;
End;

Function TPrefConvert.GetAsString: String;
Begin
  If FoundRecord Then Begin
    If (FQuery.FieldByName('FieldValue').AsString = '') And (FQuery.FieldByName('DefaultValue').AsString <> '') Then Result := FQuery.FieldByName('DefaultValue').AsString
    Else Result                                                                                                             := FQuery.FieldByName('FieldValue').AsString;
  End
  Else Result := '';
End;

Function TPrefConvert.GetAsVariant: Variant;
Var
  FieldType: String;
Begin
  If FoundRecord Then Begin
    If (FQuery.FieldByName('FieldValue').AsString = '') And (FQuery.FieldByName('DefaultValue').AsString <> '') Then Begin
      FieldType := FQuery.FieldByName('FieldType').AsString;

      If SysUtils.SameText(FieldType, 'ftDate') Or SysUtils.SameText(FieldType, 'ftTime') Or SysUtils.SameText(FieldType, 'ftDateTime') Then
          Result  := StrToFloatDef(FQuery.FieldByName('DefaultValue').AsString, 0)
      Else Result := FQuery.FieldByName('DefaultValue').AsString;
    End Else Begin
      FieldType := FQuery.FieldByName('FieldType').AsString;

      If SysUtils.SameText(FieldType, 'ftDate') Or SysUtils.SameText(FieldType, 'ftTime') Or SysUtils.SameText(FieldType, 'ftDateTime') Then
          Result  := StrToFloatDef(FQuery.FieldByName('FieldValue').AsString, 0)
      Else Result := FQuery.FieldByName('FieldValue').AsString;
    End;
  End
  Else Result := '';
End;

Procedure TPrefConvert.SetAsBoolean(Const Value: Boolean);
Begin
  If FoundRecord Then Begin
    FQuery.Edit;

    If Value Then FQuery.FieldByName('FieldValue').AsString := 'T'
    Else FQuery.FieldByName('FieldValue').AsString          := 'F';

    FQuery.Post;
  End;
End;

Procedure TPrefConvert.SetAsCurrency(Const Value: Currency);
Begin
  If FoundRecord Then Begin
    FQuery.Edit;
    FQuery.FieldByName('FieldValue').AsString := CurrToStr(Value);
    FQuery.Post;
  End;
End;

Procedure TPrefConvert.SetAsDateTime(Const Value: TDateTime);
Begin
  If FoundRecord Then Begin
    FQuery.Edit;
    FQuery.FieldByName('FieldValue').AsString := FloatToStr(Value);
    FQuery.Post;
  End;
End;

Procedure TPrefConvert.SetAsFloat(Const Value: Double);
Begin
  If FoundRecord Then Begin
    FQuery.Edit;
    FQuery.FieldByName('FieldValue').AsString := FloatToStr(Value);
    FQuery.Post;
  End;
End;

Procedure TPrefConvert.SetAsInteger(Const Value: Integer);
Begin
  If FoundRecord Then Begin
    FQuery.Edit;
    FQuery.FieldByName('FieldValue').AsString := IntToStr(Value);
    FQuery.Post;
  End;
End;

Procedure TPrefConvert.SetAsString(Const Value: String);
Begin
  If FoundRecord Then Begin
    FQuery.Edit;
    FQuery.FieldByName('FieldValue').AsString := Value;
    FQuery.Post;
  End;
End;

Procedure TPrefConvert.SetAsVariant(Const Value: Variant);
Var
  FieldType: String;
Begin
  If FoundRecord Then Begin
    FQuery.Edit;
    FieldType := FQuery.FieldByName('FieldType').AsString;

    If SysUtils.SameText(FieldType, 'ftDate') Or SysUtils.SameText(FieldType, 'ftTime') Or SysUtils.SameText(FieldType, 'ftDateTime') Then
        FQuery.FieldByName('FieldValue').AsString   := FloatToStr(Value)
    Else FQuery.FieldByName('FieldValue').AsVariant := Value;

    FQuery.Post;
  End;
End;

Procedure TCompanyPrefObj.SetCompanyRegion(Const Value: String);
Begin
  If Value <> FsCompanyRegion Then Begin
    FsCompanyRegion := Value;
    StoreFieldValue('CompanyRegion', Value);
    AppEnv.RegionalOptions.LoadSelect('Region = ' + QuotedStr(Value));
    AppEnv.RegionalOptions.SetupRegion;
    PreferancesLib.DoPrefAuditTrail;
  End;
End;
Procedure TCompanyPrefObj.SetApprovalType(Const Value: String);
Begin
  If Value <> FsApprovalType Then Begin
    FsApprovalType := Value;
    StoreFieldValue('ApprovalType', Value);
  End;
End;

Procedure TCompanyPrefObj.SetCyTrackIntegrationEnabled(Const Value: Boolean);
Begin
  If Value <> FCyTrackIntegrationEnabled Then Begin
    FCyTrackIntegrationEnabled := Value;
    StoreFieldValue('CyTrackIntegrationEnabled', Value);
  End;
End;

procedure TCompanyPrefObj.setDefaultPurchaseTaxCode(const Value: STring);
begin
  FsDefaultPurchaseTaxCode := Value;
  StoreFieldValue('DefaultPurchaseTaxCode', Value);
end;

procedure TCompanyPrefObj.setDefaultSalesTaxCode(const Value: String);
begin
  FsDefaultSalesTaxCode := Value;
  StoreFieldValue('DefaultSalesTaxCode', Value);
end;
procedure TCompanyPrefObj.setPickupShipingMethod(const Value: String);
begin
  FsPickupShipingMethod := Value;
  StoreFieldValue('PickupShipingMethod', Value);
end;
procedure TCompanyPrefObj.setCommittedStatus(const Value: String);
begin
  FsCommittedStatus := Value;
  StoreFieldValue('CommittedStatus', Value);
end;

procedure TCompanyPrefObj.SetDisablePurchaseLineZeroQuantityWarning(
  const Value: boolean);
begin
  fDisablePurchaseLineZeroQuantityWarning := Value;
  StoreFieldValue('DisablePurchaseLineZeroQuantityWarning', Value);
end;

procedure TCompanyPrefObj.SetDisableSaleLineZeroQuantityWarning(
  const Value: boolean);
begin
  fDisableSaleLineZeroQuantityWarning := Value;
  StoreFieldValue('DisableSaleLineZeroQuantityWarning', Value);
end;
procedure TCompanyPrefObj.SetUserSetMainSwitchHeight(const Value: Integer);
begin
  fUserSetMainSwitchHeight := Value;
  StoreFieldValue('UserSetMainSwitchHeight', Value);

end;
//procedure TCompanyPrefObj.SetWooCommerce_consumerKey(const Value: String);
//begin
//  If Value <> FWooCommerce_consumerKey Then Begin
//    FWooCommerce_consumerKey := Value;
//    StoreFieldValue('WooCommerce_consumerKey', Value);
//  End;
//end;

//procedure TCompanyPrefObj.setWooCommerce_consumerSecretKey(const Value: String);
//begin
//  If Value <> fWooCommerce_consumerSecretKey Then Begin
//    FWooCommerce_consumerSecretKey := Value;
//    StoreFieldValue('WooCommerce_consumerSecretKey', Value);
//  End;
//end;

//procedure TCompanyPrefObj.setWooCommerce_URL(const Value: String);
//begin
//  If Value <> fWooCommerce_URL Then Begin
//    FWooCommerce_URL := Value;
//    StoreFieldValue('WooCommerce_URL', Value);
//  End;
//end;
procedure TCompanyPrefObj.setGrossWeightnQtyRelated(const Value: Boolean);
begin
  If Value <> FbGrossWeightnQtyRelated Then Begin
    FbGrossWeightnQtyRelated := Value;
    StoreFieldValue('GrossWeightnQtyRelated', Value);
  End;
end;

//function TCompanyPrefObj.getWoocommerce_ProductNameFieldNAme: String;
//begin
//       if fWoocommerce_ProductNameField ='P' then result := 'ProductName'
//  else if fWoocommerce_ProductNameField ='S' then result := 'SKU'
//  else REsult := 'ProductName';
//end;

Procedure TCompanyPrefObj.SetEnableAutoSplitQtyintoUOMinSales(Const Value: Boolean);
Begin
  If Value <> FbEnableAutoSplitQtyintoUOMinSales Then Begin
    FbEnableAutoSplitQtyintoUOMinSales := Value;
    StoreFieldValue('EnableAutoSplitQtyintoUOMinSales', Value);
  End;
End;

Procedure TCompanyPrefObj.SetLoyaltyReminderRepeatDays(Const Value: Integer);
Begin
  If Value <> FiLoyaltyReminderRepeatDays Then Begin
    FiLoyaltyReminderRepeatDays := Value;
    StoreFieldValue('LoyaltyReminderRepeatDays', Value)
  End;
End;

procedure TCompanyPrefObj.setManufacturePartSourceStock(const Value: Boolean);
begin
  If Value <> FbManufacturePartSourceStock Then Begin
    FbManufacturePartSourceStock := Value;
    StoreFieldValue('ManufacturePartSourceStock', Value);
  End;
end;
procedure TCompanyPrefObj.setEnforceBinVolume(const Value: Boolean);
begin
  If Value <> FbEnforceBinVolume Then Begin
    FbEnforceBinVolume := Value;
    StoreFieldValue('EnforceBinVolume', Value);
  End;
end;

Function TCompanyPrefObj.ValidateData: Boolean;
Begin
  If FiscalYearStarts = '' Then Begin
    Result := False;
    CommonLib.MessageDlgXP_Vista('Accounts : Fiscal Year Starts Cannot Be Blank.', MtWarning, [MbOK], 0);
    Exit;
  End;
  If DefaultPurchaseTaxCode = '' Then Begin
    Result := False;
    CommonLib.MessageDlgXP_Vista('Inventory :Default Purchase Tax Code For New Product Cannot Be Blank.', MtWarning, [MbOK], 0);
    Exit;
  End;
  If DefaultSalesTaxCode = '' Then Begin
    Result := False;
    CommonLib.MessageDlgXP_Vista('Inventory :Default Sales Tax Code For New Product Cannot Be Blank.', MtWarning, [MbOK], 0);
    Exit;
  End;
  Result := True;
End;

Function TCompanyPrefObj.GetSalesCommissionCalcInProgress: Boolean;
Begin
  If SysUtils.SameText(LoadFieldValue('SalesCommissionCalcInProgress'), 'T') Then Result := True
  Else Result                                                                            := False;

End;

function TCompanyPrefObj.getSalesLineLatestCostBasedOnMsg: String;
begin
     if SalesLineLatestCostBasedOn =lcbPurchaseOrder then result :=' Latest Product Cost is Based On Purchase Order '
else if SalesLineLatestCostBasedOn =lcbProductCard then result :=' Latest Product Cost is Based On Product Card '
else if SalesLineLatestCostBasedOn =lcbAvgCost then result :=' Latest Product Cost is Based On Average Cost '
else if SalesLineLatestCostBasedOn =lcbHighest then result :=' Latest Product Cost is Based On Highest of Purchase Cost, Product Cost and Average Cost '
else if SalesLineLatestCostBasedOn =lcbLowest  then result :=' Latest Product Cost is Based On Lowest of Purchase Cost, Product Cost and Average Cost '
else result := '';
end;

function TCompanyPrefObj.getSecondsInaday: Integer;
begin
  result := secondsBetween(Startofday, EndofDay);
end;

function TCompanyPrefObj.getSecsInaWorkingDay: Integer;
begin
  REsult := SecondsBetween(commonlib.DayStart(date),commonlib.DayEnd(date));
end;

Function TCompanyPrefObj.GetShowLatestCost: Boolean;
Begin
  Result := FbShowLatestCost;
End;

Procedure TCompanyPrefObj.SetSalesCommissionCalcInProgress(Const Value: Boolean);
Begin
  If Value <> FbSalesCommissionCalcInProgress Then Begin
    FbSalesCommissionCalcInProgress := Value;

    If Value Then StoreFieldValue('SalesCommissionCalcInProgress', 'T')
    Else StoreFieldValue('SalesCommissionCalcInProgress', 'F')
  End;

End;

Function TCompanyPrefObj.GetSalesCommissionCalcEmployeeID: Integer;
Begin
  Result := LoadFieldValue('SalesCommissionCalcEmployeeID');
End;

Procedure TCompanyPrefObj.SetSalesCommissionCalcEmployeeID(Const Value: Integer);
Begin
  If Value <> FiSalesCommissionCalcEmployeeID Then Begin
    FiSalesCommissionCalcEmployeeID := Value;
    StoreFieldValue('SalesCommissionCalcEmployeeID', Value)
  End;

End;

Procedure TCompanyPrefObj.Setclosingdate(Const Value: TDateTime);
Begin
  If Value <> FdtClosingDate Then Begin
    FdtClosingDate := EndOfTheDay(Value);
    StoreFieldValue('ClosingDate', Value);
  End;
End;

Procedure TCompanyPrefObj.SetClosingDateAP(Const Value: TDateTime);
Begin
  If Value <> FdtClosingDateAP Then Begin
    FdtClosingDateAP := Value;
    StoreFieldValue('ClosingDateAP', Value);
  End;

End;

Procedure TCompanyPrefObj.SetClosingDateAR(Const Value: TDateTime);
Begin
  If Value <> FdtClosingDateAR Then Begin
    FdtClosingDateAR := Value;
    StoreFieldValue('ClosingDateAR', Value);
  End;
End;

Procedure TCompanyPrefObj.SetClosingDateChangeDone(Const Value: Boolean);
Begin
  If FbClosingDateChangeDone <> Value Then Begin
    FbClosingDateChangeDone := Value;
    StoreFieldValue('ClosingDateChangeDone', Value);
  End;
End;

Procedure TCompanyPrefObj.SetShowDashboard(Const Value: Boolean);
Begin
  If Value <> FbShowDashboard Then Begin
    FbShowDashboard := Value;
    StoreFieldValue('ShowDashboard', Value);
  End;
End;

Procedure TCompanyPrefObj.SetEndOfDay(Const Value: TDateTime);
Begin
  If Value <> FdtEndOfDay Then Begin
    FdtEndOfDay := Value;
    StoreFieldValue('EndOfDay', Value);
  End;
End;

procedure TCompanyPrefObj.setEnforceAllocationValidation(const Value: Boolean);
begin
  If Value <> FbEnforceAllocationValidation Then Begin
    FbEnforceAllocationValidation := Value;
    StoreFieldValue('EnforceAllocationValidation', Value);
  End;
end;

procedure TCompanyPrefObj.setYodleeEnabled(const Value: Boolean);
begin
  If Value <> FbYodleeEnabled Then Begin
    FbYodleeEnabled := Value;
    StoreFieldValue('YodleeEnabled', Value);
  End;
end;

procedure TCompanyPrefObj.setMagentoEnabled(const Value: Boolean);
begin
  If Value <> FbMagentoEnabled Then Begin
    FbMagentoEnabled := Value;
    StoreFieldValue('MagentoEnabled', Value);
  End;
end;

procedure TCompanyPrefObj.setMagentoShowOnMainMenu(const Value: Boolean);
begin
  If Value <> FbShowMagentoOnMainMenu Then Begin
    FbShowMagentoOnMainMenu := Value;
    StoreFieldValue('ShowMagentoOnMainMenu', Value);
  End;
end;

procedure TCompanyPrefObj.SetFeQtyFieldInfodisplayLabel(const Value: String);
begin
  If Value <> fsFeQtyFieldInfodisplayLabel Then Begin
    fsFeQtyFieldInfodisplayLabel := Value;
    StoreFieldValue('FeQtyFieldInfodisplayLabel', Value);
  End;

end;

procedure TCompanyPrefObj.SetIgnoreTraining(const Value: Boolean);
begin
  If Value <> FbIgnoreTraining Then Begin
    FbIgnoreTraining := Value;
    StoreFieldValue('IgnoreTraining', Value);
  End;
end;

Procedure TCompanyPrefObj.SetStartOfDay(Const Value: TDateTime);
Begin
  If Value <> FdtStartOfDay Then Begin
    FdtStartOfDay := Value;
    StoreFieldValue('StartOfDay', Value);
  End;
End;
procedure TCompanyPrefObj.SetShowMultiSelectSelectionList(const Value: Boolean);
begin
  If Value <> ShowMultiSelectSelectionList Then Begin
    fbShowMultiSelectSelectionList := Value;
    StoreFieldValue('ShowMultiSelectSelectionList', Value);
  End;
end;
procedure TCompanyPrefObj.setConfirmQtysOnfinalise(const Value: Boolean);
begin
  If Value <> FbConfirmQtysOnfinalise Then Begin
    FbConfirmQtysOnfinalise := Value;
    StoreFieldValue('ConfirmQtysOnfinalise', Value);
  End;
end;
procedure TCompanyPrefObj.setShowEbayonMainMenubyDefault(const Value: Boolean);
begin
  If Value <> FbShowEbayonMainMenubyDefault Then Begin
    FbShowEbayonMainMenubyDefault := Value;
    StoreFieldValue('ShowEbayonMainMenubyDefault', Value);
  End;
end;
procedure TCompanyPrefObj.setShowWalmartonMainmenubyDefault(const Value: Boolean);
begin
  If Value <> FbShowWalmartonMainmenubyDefault Then Begin
    FbShowWalmartonMainmenubyDefault := Value;
    StoreFieldValue('ShowWalmartonMainmenubyDefault', Value);
  End;
end;
procedure TCompanyPrefObj.setShowWooCommerceonMainmenubyDefault(const Value: Boolean);
begin
  If Value <> FbShowWooCommerceonMainmenubyDefault Then Begin
    FbShowWooCommerceonMainmenubyDefault := Value;
    StoreFieldValue('ShowWooCommerceonMainmenubyDefault', Value);
  End;
end;
procedure TCompanyPrefObj.setWooCommerceEnabled(const Value: Boolean);
begin
  If Value <> FbEnableWooCommerce Then Begin
    FbEnableWooCommerce := Value;
    StoreFieldValue('EnableWooCommerce', Value);
  End;
end;
procedure TCompanyPrefObj.setTrialBalanceAdjustAccount(const Value: integer);
begin
  If Value <> fTrialBalanceAdjustAccount Then Begin
    fTrialBalanceAdjustAccount := Value;
    StoreFieldValue('TrialBalanceAdjustAccount', Value);
  End;
end;
procedure TCompanyPrefObj.setDoUpdateProductQtySum(const Value: Boolean);
begin
  If Value <> FbDoUpdateProductQtySum Then Begin
    FbDoUpdateProductQtySum := Value;
    StoreFieldValue('DoUpdateProductQtySum', Value);
  End;
end;

function TCompanyPrefObj.getBOMDetailsAppendsProductDescriptionMemo: Boolean;
begin
  result := BuildDetailsUpdateOption='A';
end;

function TCompanyPrefObj.getBOMDetailsReplacesProductDescriptionMemo: Boolean;
begin
  result := BuildDetailsUpdateOption='R';
end;
function TCompanyPrefObj.getIgnoreBOMDetailsUpdateonSales: Boolean;
begin
  result := (BuildDetailsUpdateOption<>'R') and (BuildDetailsUpdateOption<>'A');
end;
procedure TCompanyPrefObj.setCoreEDIUSerName(const Value: String);
begin
  If Value <> fCoreEDIUSerName Then Begin
    FCoreEDIUSerName := Value;
    StoreFieldValue('CoreEDIUSerName', Value);
  End;
end;
procedure TCompanyPrefObj.setCoreEDIPassword(const Value: String);
begin
  If Value <> fCoreEDIPassword Then Begin
    FCoreEDIPassword := Value;
    StoreFieldValue('CoreEDIPassword', Value);
  End;
end;
procedure TCompanyPrefObj.setCoreEDIServicePassword(const Value: String);
begin
  If Value <> fCoreEDIServicePassword Then Begin
    FCoreEDIServicePassword := Value;
    StoreFieldValue('CoreEDIServicePassword', Value);
  End;
end;
procedure TCompanyPrefObj.setCoreEDIServiceHost(const Value: String);
begin
  If Value <> fCoreEDIServiceHost Then Begin
    FCoreEDIServiceHost := Value;
    StoreFieldValue('CoreEDIServiceHost', Value);
  End;
end;
procedure TCompanyPrefObj.setCoreEDIServicePort(const Value: Integer);
begin
  If Value <> fCoreEDIServicePort Then Begin
    FCoreEDIServicePort := Value;
    StoreFieldValue('CoreEDIServicePort', Value);
  End;
end;
function TCompanyPrefObj.GetWalmartclientID                : String;begin  if fWalmartConfig.UseSandbox then result :=fWalmartConfig.SandBoxClientID       else result := fWalmartConfig.ProductionClientID    ;end;
function TCompanyPrefObj.GetWalmartclientSecret            : String;begin  if fWalmartConfig.UseSandbox then result :=fWalmartConfig.SandBoxClientSecret   else result := fWalmartConfig.ProductionClientSecret;end;
function TCompanyPrefObj.GetWalmartsynchAccount            : String;begin  Result := fWalmartConfig.synchAccount;end;
function TCompanyPrefObj.GetWalmartsynchAccountDescription : String;begin  Result := fWalmartConfig.synchAccountDescription;end;
function TCompanyPrefObj.GetWalmartToken_URL               : String;begin  if fWalmartConfig.UseSandbox then result :=WMR_Sandbox_Token_URL                else result := WMR_Prod_Token_URL               ;end;
function TCompanyPrefObj.GetWalmart_Order_Released_URL     : String;begin  if fWalmartConfig.UseSandbox then result :=WMR_Sandbox_Order_Released_URL       else result := WMR_Prod_Order_Released_URL      ;end;
function TCompanyPrefObj.GetWalmart_Order_Released_Cont_URL: String;begin  if fWalmartConfig.UseSandbox then result :=WMR_Sandbox_Order_Released_Cont_URL  else result := WMR_Prod_Order_Released_Cont_URL ;end;
function TCompanyPrefObj.GetWalmart_Order_All_URL          : String;begin  if fWalmartConfig.UseSandbox then result :=WMR_Sandbox_Order_All_URL            else result := WMR_Prod_Order_All_URL           ;end;
function TCompanyPrefObj.GetWalmart_Order_All_cont_URL     : String;begin  if fWalmartConfig.UseSandbox then result :=WMR_Sandbox_Order_All_cont_URL       else result := WMR_Prod_Order_All_cont_URL      ;end;
function TCompanyPrefObj.GetWalmart_Order_Single_URL       : String;begin  if fWalmartConfig.UseSandbox then result :=WMR_Sandbox_Order_Single_URL         else result := WMR_Prod_Order_Single_URL        ;end;
function TCompanyPrefObj.GetWalmart_Order_Ack_URL          : String;begin  if fWalmartConfig.UseSandbox then result :=WMR_Sandbox_Order_Ack_URL            else result := WMR_Prod_Order_Ack_URL           ;end;
function TCompanyPrefObj.GetWalmart_Order_Cancel_URL       : String;begin  if fWalmartConfig.UseSandbox then result :=WMR_Sandbox_Order_Cancel_URL         else result := WMR_Prod_Order_Cancel_URL        ;end;
function TCompanyPrefObj.GetWalmart_Order_Refund_URL       : String;begin  if fWalmartConfig.UseSandbox then result :=WMR_Sandbox_Order_Refund_URL         else result := WMR_Prod_Order_Refund_URL        ;end;
function TCompanyPrefObj.GetWalmart_Order_Shipping_URL     : String;begin  if fWalmartConfig.UseSandbox then result :=WMR_Sandbox_Order_Shipping_URL       else result := WMR_Prod_Order_Shipping_URL      ;end;
function TCompanyPrefObj.GetWalmart_FeedStatus_URL         : String;begin  if fWalmartConfig.UseSandbox then result :=WMR_Sandbox_FeedStatus_URL           else result := WMR_Prod_FeedStatus_URL          ;end;
function TCompanyPrefObj.getWalmart_OrdersSynchedUntil     : TDatetime;begin  result := fWalmartConfig.OrdersSynchedUntil ;end;

function TCompanyPrefObj.getEnableMagento                : Boolean   ;begin  Result := fMagentoconfig.EnableMagento          ; end;
function TCompanyPrefObj.getMagento_ShowMagentoOnMainMenu: Boolean   ;begin  Result := fMagentoconfig.ShowMagentoOnMainMenu  ; end;
function TCompanyPrefObj.getMagento_AutosynchList        : Boolean   ;begin  Result := fMagentoconfig.AutosynchList          ; end;
function TCompanyPrefObj.getMagento_API_Base_URL         : String    ;begin  Result := fMagentoconfig.API_Base_URL           ; end;
function TCompanyPrefObj.getMagento_Consumer_Key         : String    ;begin  Result := fMagentoconfig.Consumer_Key           ; end;
function TCompanyPrefObj.getMagento_Consumer_Secret      : String    ;begin  Result := fMagentoconfig.Consumer_Secret        ; end;
function TCompanyPrefObj.getMagento_Access_Token         : String    ;begin  Result := fMagentoconfig.Access_Token           ; end;
function TCompanyPrefObj.getMagento_Access_Token_Secret  : String    ;begin  Result := fMagentoconfig.Access_Token_Secret    ; end;
function TCompanyPrefObj.getMagento_AdminUserName        : String    ;begin  Result := fMagentoconfig.AdminUserName          ; end;
function TCompanyPrefObj.getMagento_Companyid            : String    ;begin  Result := fMagentoconfig.Companyid              ; end;
function TCompanyPrefObj.getMagento_AdminPassword        : String    ;begin  Result := fMagentoconfig.AdminPassword          ; end;
function TCompanyPrefObj.getMagento_SalesType            : String    ;begin  Result := fMagentoconfig.Magento_SalesType      ; end;
function TCompanyPrefObj.getMagento_CustomerID           : String    ;begin  Result := fMagentoconfig.Magento_CustomerID     ; end;
Function TCompanyPrefObj.getIsMagentoSalestypeSO         : Boolean   ;begin  result := Sametext(Magento_SalesType , 'Sales Order'); end;
Function TCompanyPrefObj.getIsMagentoSalestypeInv        : Boolean   ;begin  result := Sametext(Magento_SalesType , 'Invoice'); end;
function TCompanyPrefObj.getMagento_SynchPageSize        : Integer   ;begin  Result := fMagentoconfig.Magento_SynchPageSize   ; if result =0 then result := 100;end;
Function TCompanyPrefObj.getISMagentoCustomerIDName      : Boolean   ;begin  result := Sametext(Magento_CustomerID , 'CustomerName'); end;
Function TCompanyPrefObj.getISMagentoCustomerIDEmail     : Boolean   ;begin  result := Sametext(Magento_CustomerID , 'Email'); end;

function TCompanyPrefObj.getEnableAvaTax                : Boolean   ;begin  Result := fAvaTaxconfig.EnableAvaTax         ; end;
function TCompanyPrefObj.getAvaTaxCredentialsValidated  : Boolean   ;begin  Result := fAvaTaxconfig.CredentialsValidated ; end;
function TCompanyPrefObj.getAvaTax_ShowAvaTaxOnMainMenu : Boolean   ;begin  Result := fAvaTaxconfig.ShowAvaTaxOnMainMenu ; end;
function TCompanyPrefObj.getAvaTax_AutosynchList        : Boolean   ;begin  Result := fAvaTaxconfig.AutosynchList        ; end;
function TCompanyPrefObj.getAvaTax_Username             : String    ;begin  Result := fAvaTaxconfig.Username             ; end;
function TCompanyPrefObj.getAvaTax_Password             : String    ;begin  Result := fAvaTaxconfig.Password             ; end;
function TCompanyPrefObj.getAvaTax_BaseURL              : String    ;begin  Result := fAvaTaxconfig.BaseURL              ; end;
function TCompanyPrefObj.getAvaTax_CompanyID            : String    ;begin  Result := fAvaTaxconfig.CompanyID            ; end;
function TCompanyPrefObj.getAvaTax_AvaTaxSaleCode       : String    ;begin  Result := fAvaTaxconfig.AvaTaxSaleCode       ; end;
function TCompanyPrefObj.getAvaTax_CompanyCode          : String    ;begin  Result := fAvaTaxconfig.CompanyCode          ; end;
function TCompanyPrefObj.getAvaTax_AccountType          : String    ;begin  Result := fAvaTaxconfig.AvaTax_AccountType   ; end;
Function TCompanyPrefObj.getIsAvaTaxSandBox             : Boolean   ;begin  result := fAvaTaxconfig.IsAvaTaxSandBox      ; end;
Function TCompanyPrefObj.getIsAvaTaxProduction          : Boolean   ;begin  result := fAvaTaxconfig.IsAvaTaxProduction   ; end;

function TCompanyPrefObj.getUseSeedtoSale                : Boolean   ;begin  Result := fStSconfig.UseSeedtoSale           ; end;
function TCompanyPrefObj.getStSUsesBins           : Boolean   ;begin  Result := fStSconfig.StSUsesBins      ; end;
function TCompanyPrefObj.getStSSimpleMode         : Boolean   ;begin  Result := fStSconfig.StSSimpleMode    ; end;
function TCompanyPrefObj.getStSPackageTagProduct         : String    ;begin  Result := fStSconfig.StSPackageTagProduct    ; end;
function TCompanyPrefObj.getStSPlantTagProduct           : String    ;begin  Result := fStSconfig.StSPlantTagProduct      ; end;
function TCompanyPrefObj.getStSSupplier                  : String    ;begin  Result := fStSconfig.StSSupplier             ; end;
function TCompanyPrefObj.getStSStockAccount              : String    ;begin  Result := fStSconfig.StSStockAccount         ; if result ='' then result := 'Stock Adjustment'; end;
function TCompanyPrefObj.getEnableSeedtoSale: boolean;
begin
  Result := UseSeedtoSale and
            (trim(StSPackageTagProduct)<> '') and
            (trim(StSPlantTagProduct)<> '') and
            (trim(StSSupplier)<> '') ;
end;
function TCompanyPrefObj.getSeedToSaleStarted: Boolean;
begin
  Result := TcDataUtils.SeedToSaleStarted;
end;

function TCompanyPrefObj.getVS1useRegioncurrency         : Boolean   ;begin  Result := fVS1config.useRegioncurrency   ; end;
function TCompanyPrefObj.getVS1DefaultCurrency           : String    ;begin  Result := fVS1config.DefaultCurrency     ; end;

Procedure TCompanyPrefObj.DisableApprovalLevels;
begin
  fbCleanUseApprovalLevels:= FbUseApprovalLevels;
  FbUseApprovalLevels := False;
end;
Procedure TCompanyPrefObj.EnableApprovalLevels;
begin
  FbUseApprovalLevels := fbCleanUseApprovalLevels;
end;
function TCompanyPrefObj.getEnableJobKeepersAllowance(Paydate:Tdatetime=0)         : Boolean   ;
var
  qry: TERPQuery;
begin
  Result := AppEnv.RegionalOptions.RegionType = rAUST;
  if result then
    if  Paydate >0 then begin
      qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
      try
        qry.Sql.TExt := 'Select * from tblstpjobkeeperpaymentphases where ' + quotedstr(formatDateTime(MysqlDateFormat,Paydate))+' between DateFrom and DateTo';
        qry.Open;
        result :=qry.recordcount > 0;
      finally
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
      end;

    end;
end;

End.


