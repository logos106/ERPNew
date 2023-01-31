unit frmPadQuote;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmPadBaseInput, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  AdvSmoothExpanderGroup, ExtCtrls, AdvSmoothButton, ActnList, AdvSmoothTabPager,
  Grids, AdvObj, BaseGrid, AdvGrid, frameButtonArray, JsonObject,
  BusObjSales, BusObjBase, StdCtrls, wwdblook, ERPDbLookupCombo, Buttons,
  Wwdbigrd, Wwdbgrid, Mask, wwdbedit, BusObjClient, wwdbdatetimepicker,
  AdvSmoothTouchKeyBoard, ProgressDialog;

type
  TfmPadQuote = class(TfmPadBaseInput)
    btnSave: TAdvSmoothButton;
    btnCancel: TAdvSmoothButton;
    tpMain: TAdvSmoothTabPager;
    tabHeader: TAdvSmoothTabPage;
    tabDetails: TAdvSmoothTabPage;
    actCustomiseKeypad: TAction;
    actKeypadHome: TAction;
    ButtonArray: TfrButtonArray;
    qrySales: TERPQuery;
    qrySalesLines: TERPQuery;
    cboCustomer: TERPDbLookupCombo;
    grdSalesLines: TwwDBGrid;
    dsSalesLines: TDataSource;
    dsSales: TDataSource;
    qrySalesLinesSaleLineID: TIntegerField;
    qrySalesLinesGlobalRef: TWideStringField;
    qrySalesLinesSaleID: TIntegerField;
    qrySalesLinesProductID: TIntegerField;
    qrySalesLinesPARTTYPE: TWideStringField;
    qrySalesLinesINCOMEACCNT: TWideStringField;
    qrySalesLinesASSETACCNT: TWideStringField;
    qrySalesLinesCOGSACCNT: TWideStringField;
    qrySalesLinesProductGroup: TWideStringField;
    qrySalesLinesProductName: TWideStringField;
    qrySalesLinesProduct_Description: TWideStringField;
    qrySalesLinesProduct_Description_Memo: TWideMemoField;
    qrySalesLinesOrgLinePrice: TFloatField;
    qrySalesLinesLinePrice: TFloatField;
    qrySalesLinesLinePriceInc: TFloatField;
    qrySalesLinesLineWholesalePrice: TFloatField;
    qrySalesLinesLineTaxRate: TFloatField;
    qrySalesLinesLineCost: TFloatField;
    qrySalesLinesLineCostInc: TFloatField;
    qrySalesLinesLineTaxCode: TWideStringField;
    qrySalesLinesLineTax: TFloatField;
    qrySalesLinesQtySold: TFloatField;
    qrySalesLinesUnitofMeasureQtySold: TFloatField;
    qrySalesLinesShipped: TFloatField;
    qrySalesLinesUnitofMeasureShipped: TFloatField;
    qrySalesLinesBackOrder: TFloatField;
    qrySalesLinesUnitofMeasureBackorder: TFloatField;
    qrySalesLinesUnitofMeasureSaleLines: TWideStringField;
    qrySalesLinesUnitOfMeasureID: TIntegerField;
    qrySalesLinesUnitofMeasureMultiplier: TFloatField;
    qrySalesLinesInvoiced: TWideStringField;
    qrySalesLinesDiscounts: TFloatField;
    qrySalesLinesMarkup: TFloatField;
    qrySalesLinesMarkupPercent: TFloatField;
    qrySalesLinesDiscountPercent: TFloatField;
    qrySalesLinesTimecostused: TWideStringField;
    qrySalesLinesTotalLineAmount: TFloatField;
    qrySalesLinesTotalLineAmountInc: TFloatField;
    qrySalesLinesEditedFlag: TWideStringField;
    qrySalesLinesDeleted: TWideStringField;
    qrySalesLinesRefundQty: TFloatField;
    qrySalesLinesLaybyID: TWideStringField;
    qrySalesLinesSoldSerials: TWideMemoField;
    qrySalesLinesAttrib1Sale: TFloatField;
    qrySalesLinesAttrib2Sale: TFloatField;
    qrySalesLinesAttrib1SaleRate: TFloatField;
    qrySalesLinesLastLineID: TIntegerField;
    qrySalesLinesDescAttrib3: TWideStringField;
    qrySalesLinesDescAttrib1: TWideStringField;
    qrySalesLinesDescAttrib2: TWideStringField;
    qrySalesLinesSupplier: TWideStringField;
    qrySalesLinesSupplierContact: TWideStringField;
    qrySalesLinesDescAttrib4: TWideStringField;
    qrySalesLinesDescAttrib5: TWideStringField;
    qrySalesLinesForeignExchangeSellRate: TFloatField;
    qrySalesLinesForeignExchangeSellCode: TWideStringField;
    qrySalesLinesForeignCurrencyLinePrice: TFloatField;
    qrySalesLinesForeignTotalLineAmount: TFloatField;
    qrySalesLinesArea: TWideStringField;
    qrySalesLinesSearchFilter: TWideStringField;
    qrySalesLinesSearchFilterCopy: TWideStringField;
    qrySalesLinesIsRelatedProduct: TWideStringField;
    qrySalesLinesRelatedParentProductID: TIntegerField;
    qrySalesLinesLastUpdated: TDateTimeField;
    qrySalesLinesHireID: TIntegerField;
    qrySalesLinesHireQty: TFloatField;
    qrySalesLinesHireToBeReturned: TDateField;
    qrySalesLinesHireSerials: TWideMemoField;
    qrySalesLinesIsQuote: TWideStringField;
    qrySalesLinesCostCentreId: TIntegerField;
    qrySalesLinesClonedFromId: TIntegerField;
    qrySalesLinesmsTimeStamp: TDateTimeField;
    qrySalesLinesDocketNumber: TWideStringField;
    qrySalesLinesUseHedging: TWideStringField;
    qrySalesLinesPartSpecID: TIntegerField;
    qrySalesLinesSpecDescription: TWideStringField;
    qrySalesLinesSpecValue: TFloatField;
    qrySalesLinesCreationDate: TDateTimeField;
    qrySalesLinesWarrantyPeriod: TWideStringField;
    qrySalesLinesWarrantyEndsOn: TDateField;
    qrySalesLinesSalesLinesCustField1: TWideStringField;
    qrySalesLinesSalesLinesCustField2: TWideStringField;
    qrySalesLinesSalesLinesCustField3: TWideStringField;
    qrySalesLinesSalesLinesCustField4: TWideStringField;
    qrySalesLinesSalesLinesCustField5: TWideStringField;
    qrySalesLinesSalesLinesCustField6: TWideStringField;
    qrySalesLinesSalesLinesCustField7: TWideStringField;
    qrySalesLinesSalesLinesCustField8: TWideStringField;
    qrySalesLinesSalesLinesCustField9: TWideStringField;
    qrySalesLinesSalesLinesCustField10: TWideStringField;
    qrySalesLinesLineNotes: TWideMemoField;
    qrySalesLinesCustomData: TWideMemoField;
    qrySalesLinesINCOMEACCNTID: TIntegerField;
    qrySalesLinesASSETACCNTID: TIntegerField;
    qrySalesLinesCOGSACCNTID: TIntegerField;
    qrySalesLinesSortId: TIntegerField;
    qrySalesLinesLinesOrder: TIntegerField;
    qrySalesLinesMemoLine: TWideMemoField;
    qrySalesLinesSeqNo: TIntegerField;
    qrySalesLinesRelatedParentLineRef: TWideStringField;
    qrySalesLinesRelatedProductQty: TFloatField;
    qrySalesLinesIsFormulaRElatedProduct: TWideStringField;
    qrySalesLinesFormulaID: TIntegerField;
    qrySalesLinesAutoSmartOrder: TWideStringField;
    qrySalesLinesSmartOrderCreated: TWideStringField;
    qrySalesLinesShipDate: TDateTimeField;
    qrySalesLinesBaseLineno: TIntegerField;
    qrySalesLinesPartBarcode: TWideStringField;
    qrySalesLinesProgresspaymentRef: TWideStringField;
    qrySalesLinesMatrixDesc: TWideMemoField;
    qrySalesLinesMatrixRef: TWideMemoField;
    qrySalesLinesMatrixPrice: TFloatField;
    qrySalesSaleID: TIntegerField;
    qrySalesGlobalRef: TWideStringField;
    qrySalesInvoiceDocNumber: TWideStringField;
    qrySalesOriginalNo: TWideStringField;
    qrySalesBaseNo: TWideStringField;
    qrySalesAccount: TWideStringField;
    qrySalesAccountID: TIntegerField;
    qrySalesBOID: TWideStringField;
    qrySalesCustomerName: TWideStringField;
    qrySalesClientID: TIntegerField;
    qrySalesInvoiceTo: TWideStringField;
    qrySalesShipTo: TWideStringField;
    qrySalesPickupFrom: TWideStringField;
    qrySalesSaleDate: TDateField;
    qrySalesTotalTax: TFloatField;
    qrySalesTotalWETTax: TFloatField;
    qrySalesTotalWEGTax: TFloatField;
    qrySalesTotalAmount: TFloatField;
    qrySalesTotalAmountInc: TFloatField;
    qrySalesTotalMarkup: TFloatField;
    qrySalesTotalDiscount: TFloatField;
    qrySalesEmployeeName: TWideStringField;
    qrySalesEmployeeID: TIntegerField;
    qrySalesClassID: TIntegerField;
    qrySalesClass: TWideStringField;
    qrySalesOrderNumber: TWideStringField;
    qrySalesPONumber: TWideStringField;
    qrySalesChequeNo: TWideStringField;
    qrySalesShipDate: TDateField;
    qrySalesFutureSO: TWideStringField;
    qrySalesDueDate: TDateField;
    qrySalesConNote: TWideStringField;
    qrySalesMemo: TWideMemoField;
    qrySalesComments: TWideMemoField;
    qrySalesInvoicePrintDesc: TWideStringField;
    qrySalesPickMemo: TWideMemoField;
    qrySalesPrintHold: TWideStringField;
    qrySalesShipping: TWideStringField;
    qrySalesTerms: TWideStringField;
    qrySalesPayMethod: TWideStringField;
    qrySalesPayDueDate: TWideStringField;
    qrySalesPaid: TWideStringField;
    qrySalesBalance: TFloatField;
    qrySalesSOBalance: TFloatField;
    qrySalesPayment: TFloatField;
    qrySalesApplyFlag: TWideStringField;
    qrySalesAmountDue: TFloatField;
    qrySalesTimeOfSale: TWideStringField;
    qrySalesIsPOS: TWideStringField;
    qrySalesPOS: TWideStringField;
    qrySalesIsRefund: TWideStringField;
    qrySalesIsCashSale: TWideStringField;
    qrySalesIsInvoice: TWideStringField;
    qrySalesIsQuote: TWideStringField;
    qrySalesIsSalesOrder: TWideStringField;
    qrySalesIsVoucher: TWideStringField;
    qrySalesIsLayby: TWideStringField;
    qrySalesIsLaybyTOS: TWideStringField;
    qrySalesIsLaybyPayment: TWideStringField;
    qrySalesDeleted: TWideStringField;
    qrySalesCancelled: TWideStringField;
    qrySalesEditedFlag: TWideStringField;
    qrySalesTotalQuoteAmount: TFloatField;
    qrySalesLaybyID: TWideStringField;
    qrySalesDeposited: TWideStringField;
    qrySalesTillID: TSmallintField;
    qrySalesHoldSale: TWideStringField;
    qrySalesSaleConfirmed: TWideStringField;
    qrySalesFreezeQuoteAmount: TWideStringField;
    qrySalesConverted: TWideStringField;
    qrySalesEnteredBy: TWideStringField;
    qrySalesEnteredAt: TWideStringField;
    qrySalesCommissionPaid: TWideStringField;
    qrySalesIsManifest: TWideStringField;
    qrySalesUsedOnManifest: TWideStringField;
    qrySalesAddToManifest: TWideStringField;
    qrySalesSalesOrderGlobalRef: TWideStringField;
    qrySalesQuoteGlobalRef: TWideStringField;
    qrySalesRepairGlobalRef: TWideStringField;
    qrySalesSOProgressPaymentGlobalRef: TWideStringField;
    qrySalesSOProgressPaymentOriginalRef: TWideStringField;
    qrySalesIsBarcodePicking: TWideStringField;
    qrySalesBarcodePickingDone: TWideStringField;
    qrySalesARNotes: TWideMemoField;
    qrySalesOriginalCreationDate: TDateField;
    qrySalesQuoteStatus: TWideStringField;
    qrySalesDespatchID: TIntegerField;
    qrySalesRunID: TIntegerField;
    qrySalesRunName: TWideStringField;
    qrySalesReference: TWideStringField;
    qrySalesmsTimeStamp: TDateTimeField;
    qrySalesPOCreated: TWideStringField;
    qrySalesLastUpdated: TDateTimeField;
    qrySalesForeignExchangeCode: TWideStringField;
    qrySalesForeignExchangeRate: TFloatField;
    qrySalesForeignTotalAmount: TFloatField;
    qrySalesForeignPaidAmount: TFloatField;
    qrySalesForeignBalanceAmount: TFloatField;
    qrySalesIsGeneratedFromHire: TWideStringField;
    qrySalesBlindBalancePeriodID: TIntegerField;
    qrySalesSaleDateTime: TDateTimeField;
    qrySalesAutoSmartOrderRef: TWideStringField;
    qrySalesIsInternalOrder: TWideStringField;
    qrySalesShippingCost: TFloatField;
    qrySalescontactID: TLargeintField;
    qrySalesContactName: TWideStringField;
    qrySalesPOSPostCode: TWideStringField;
    qrySalesRepairID: TLargeintField;
    qrySalesMedtypeID: TIntegerField;
    qrySalesMedtype: TWideStringField;
    qrySalesNoOfBoxes: TLargeintField;
    qrySalesContributionAmount: TFloatField;
    grdSalesLinesIButton: TwwIButton;
    qryCustomerLookup: TERPQuery;
    qryCustomerLookupClientID: TIntegerField;
    qryCustomerLookupCompany: TWideStringField;
    lblCustomer: TLabel;
    edtJobName: TwwDBEdit;
    qryClient: TERPQuery;
    qryClientGlobalRef: TWideStringField;
    qryClientClientID: TIntegerField;
    qryClientClientTypeID: TIntegerField;
    qryClientCompany: TWideStringField;
    qryClientABN: TWideStringField;
    qryClientTitle: TWideStringField;
    qryClientFirstName: TWideStringField;
    qryClientMiddleName: TWideStringField;
    qryClientLastName: TWideStringField;
    qryClientSkypeName: TWideStringField;
    qryClientPosition: TWideStringField;
    qryClientStreet: TWideStringField;
    qryClientStreet2: TWideStringField;
    qryClientSuburb: TWideStringField;
    qryClientState: TWideStringField;
    qryClientCountry: TWideStringField;
    qryClientPostcode: TWideStringField;
    qryClientBillStreet: TWideStringField;
    qryClientBillStreet2: TWideStringField;
    qryClientBillSuburb: TWideStringField;
    qryClientBillState: TWideStringField;
    qryClientBillCountry: TWideStringField;
    qryClientBillPostcode: TWideStringField;
    qryClientPOBox: TWideStringField;
    qryClientPOSuburb: TWideStringField;
    qryClientPOState: TWideStringField;
    qryClientPOCountry: TWideStringField;
    qryClientPOPostcode: TWideStringField;
    qryClientPhone: TWideStringField;
    qryClientFaxNumber: TWideStringField;
    qryClientMobile: TWideStringField;
    qryClientEmail: TWideStringField;
    qryClientAltContact: TWideStringField;
    qryClientAltPhone: TWideStringField;
    qryClientPhoneSupportTill: TDateField;
    qryClientContact1: TWideStringField;
    qryClientContact2: TWideStringField;
    qryClientContact1Phone: TWideStringField;
    qryClientContact2Phone: TWideStringField;
    qryClientCreationDate: TDateField;
    qryClientUpdateDate: TDateField;
    qryClientDateInactive: TDateField;
    qryClientNotes: TWideMemoField;
    qryClientClientNo: TWideStringField;
    qryClientMedTypeID: TIntegerField;
    qryClientTYPE: TWideStringField;
    qryClientTAXID: TIntegerField;
    qryClientCreditLimit: TFloatField;
    qryClientARBalance: TFloatField;
    qryClientAPBalance: TFloatField;
    qryClientBalance: TFloatField;
    qryClientSOBalance: TFloatField;
    qryClientTERMS: TWideStringField;
    qryClientTermsID: TIntegerField;
    qryClientShippingMethod: TWideStringField;
    qryClientShippingID: TIntegerField;
    qryClientDiscount: TFloatField;
    qryClientSpecialDiscount: TFloatField;
    qryClientJobName: TWideStringField;
    qryClientJobRegistration: TWideStringField;
    qryClientWarrantyFinishDate: TDateTimeField;
    qryClientHoursTakenForJob: TFloatField;
    qryClientIsJob: TWideStringField;
    qryClientCUSTFLD1: TWideStringField;
    qryClientCUSTFLD2: TWideStringField;
    qryClientCUSTFLD3: TWideStringField;
    qryClientCUSTFLD4: TWideStringField;
    qryClientCUSTFLD5: TWideStringField;
    qryClientCUSTFLD6: TWideStringField;
    qryClientCUSTFLD7: TWideStringField;
    qryClientCUSTFLD8: TWideStringField;
    qryClientCUSTFLD9: TWideStringField;
    qryClientCUSTFLD10: TWideStringField;
    qryClientCUSTFLD11: TWideStringField;
    qryClientCUSTFLD12: TWideStringField;
    qryClientCUSTFLD13: TWideStringField;
    qryClientCUSTFLD14: TWideStringField;
    qryClientCUSTFLD15: TWideStringField;
    qryClientPayMethodID: TIntegerField;
    qryClientFeedback: TWideStringField;
    qryClientCustomer: TWideStringField;
    qryClientSupplier: TWideStringField;
    qryClientOtherContact: TWideStringField;
    qryClientOtherContactType: TIntegerField;
    qryClientRepID: TIntegerField;
    qryClientRepName: TWideStringField;
    qryClientAction: TDateTimeField;
    qryClientGlobal: TWideStringField;
    qryClientDone: TWideStringField;
    qryClientDateEntered: TDateField;
    qryClientActive: TWideStringField;
    qryClientEditedFlag: TWideStringField;
    qryClientCorrespondenceMethod: TWideStringField;
    qryClientDontContact: TWideStringField;
    qryClientCompletionDate: TDateField;
    qryClientParentClientID: TIntegerField;
    qryClientShipTime: TWordField;
    qryClientGracePeriod: TWordField;
    qryClientLastContactDate: TDateField;
    qryClientLoyaltyValue: TFloatField;
    qryClientLastSaleDate: TDateField;
    qryClientAccountNo: TWideStringField;
    qryClientBankAccountName: TWideStringField;
    qryClientBankCode: TWideStringField;
    qryClientBankAccountBSB: TWideStringField;
    qryClientBankAccountNo: TWideStringField;
    qryClientURL: TWideStringField;
    qryClientCombinedInvoiceBOID: TWideStringField;
    qryClientCombinedPurchaseBOID: TWideStringField;
    qryClientCombinedSaleOrderBOID: TWideStringField;
    qryClientStopCredit: TWideStringField;
    qryClientRequired: TWideStringField;
    qryClientSecurityLevel: TIntegerField;
    qryClientForcePOOnBooking: TWideStringField;
    qryClientForcePOOnInvoice: TWideStringField;
    qryClientForcePOOnCustomer: TWideStringField;
    qryClientPickingPriority: TIntegerField;
    qryClientCallPriority: TIntegerField;
    qryClientJobNumber: TIntegerField;
    qryClientDefaultInvoiceTemplateID: TIntegerField;
    qryClientDefaultDeliveryTemplateID: TIntegerField;
    qryClientLoyaltyDateSaleDays: TDateField;
    qryClientLoyaltyDateAmount: TDateField;
    qryClientLoyaltyDateAppointDays: TDateField;
    qryClientGroupDiscountOverridesAll: TWideStringField;
    qryClientForeignExchangeSellCode: TWideStringField;
    qryClientCardNumber: TWideStringField;
    qryClientDefaultClass: TWideStringField;
    qryClientArea: TWideStringField;
    qryClientDischargeDate: TDateField;
    qryClientJobTitle: TWideStringField;
    qryClientUseInvBase: TWideStringField;
    qryClientInvBaseNumber: TIntegerField;
    qryClientApprovalFromDate: TDateTimeField;
    qryClientApprovalToDate: TDateTimeField;
    qryClientTasks: TWideMemoField;
    qryClientReminderDateTime: TDateTimeField;
    qryClientSpecialInstructions: TWideMemoField;
    qryClientCUSTDATE1: TDateField;
    qryClientCUSTDATE2: TDateField;
    qryClientCUSTDATE3: TDateField;
    qryClientSerialNumber: TWideStringField;
    qryClientModelNumber: TWideStringField;
    qryClientManufacture: TWideStringField;
    qryClientParentRelatedClientID: TIntegerField;
    qryClientDeliveryNotes: TWideMemoField;
    qryClientDefaultContactMethod: TWideStringField;
    qryClientCreditCardNumber: TWideStringField;
    qryClientCreditCardExpiryDate: TWideStringField;
    qryClientCreditCardCardHolderName: TWideStringField;
    qryClientCreditCardNotes: TWideStringField;
    qryClientCompanyTypeId: TIntegerField;
    qryClientCreditCardType: TWideStringField;
    qryClientLastUpdated: TDateTimeField;
    qryClientmsTimeStamp: TDateTimeField;
    qryClientWarrantyPeriod: TFloatField;
    qryClientCustomerJobNumber: TWideStringField;
    qryClienthours: TFloatField;
    qryClientEmailXML: TWideStringField;
    qryClientInvoiceComment: TWideMemoField;
    qryClientPOComment: TWideMemoField;
    qryClientInvoiceCommentPopup: TWideStringField;
    qryClientPOCommentPopup: TWideStringField;
    qryClientSendXMLInvoices: TWideStringField;
    qryClientDefaultPurchaseOrderTemplateID: TIntegerField;
    qryClientStreet3: TWideStringField;
    qryClientBillStreet3: TWideStringField;
    qryClientIncludeOnIntrastat: TWideStringField;
    qryClientShowInShipContainers: TWideStringField;
    qryClientForcePOOnRepair: TWideStringField;
    qryClientBPAYBillerCode: TWideStringField;
    qryClientBPAYReference: TWideStringField;
    qryClientManufactureID: TIntegerField;
    qryClientSpecialProductPriceOverridesAll: TWideStringField;
    qryClientPortOfLanding: TWideStringField;
    qryClientPortOfDischarge: TWideStringField;
    qryClientFinalDestination: TWideStringField;
    qryClientIncoPlace: TWideStringField;
    qryClientShippingAgentID: TIntegerField;
    qryClientDefaultStatementTemplateId: TIntegerField;
    qryClientTeamviewerID: TWideStringField;
    dsClient: TDataSource;
    lblJobName: TLabel;
    lblJobNumber: TLabel;
    edtJobNumber: TwwDBEdit;
    Label4: TLabel;
    edtStreet1: TwwDBEdit;
    edtStreet2: TwwDBEdit;
    edtStreet3: TwwDBEdit;
    lblSuburb: TLabel;
    Suburb: TwwDBLookupCombo;
    lblState: TLabel;
    State: TwwDBEdit;
    lblPostCode: TLabel;
    PostCode: TwwDBEdit;
    qrySuburb: TERPQuery;
    qryClientInsuranceCompanyName: TWideStringField;
    qryClientClaimNumber: TWideStringField;
    qryClientStormLocation: TWideStringField;
    qryClientStormDate: TDateField;
    qryClientYear: TDateField;
    qryClientColour: TWideStringField;
    qryClientBodyType: TWideStringField;
    qryClientAssessorsName: TWideStringField;
    qryClientExcessAmount: TFloatField;
    lblPhone: TLabel;
    edtPhone: TwwDBEdit;
    lblMobile: TLabel;
    edtMobile: TwwDBEdit;
    lblEmail: TLabel;
    edtEmail: TwwDBEdit;
    lblInsuranceCompany: TLabel;
    cboInsuranceCompany: TERPDbLookupCombo;
    qryInsuranceCompanyLookup: TERPQuery;
    lblAssessorsName: TLabel;
    edtAssessorsName: TwwDBEdit;
    lblExcessAmount: TLabel;
    edtExcessAmount: TwwDBEdit;
    lblStormLocation: TLabel;
    cboStormLocation: TwwDBLookupCombo;
    edtDateOfStorm: TwwDBDateTimePicker;
    lblStormDate: TLabel;
    lblVehicleVinNo: TLabel;
    edtVehicalVin: TwwDBEdit;
    lblRegoNumber: TLabel;
    edtRegistrationNumber: TwwDBEdit;
    Label3: TLabel;
    edtYear: TwwDBDateTimePicker;
    lblMake: TLabel;
    qryModel: TERPQuery;
    qryModelName: TWideStringField;
    qryModelId: TIntegerField;
    cboModel: TwwDBLookupCombo;
    lblModel: TLabel;
    lblColour: TLabel;
    edtColour: TwwDBEdit;
    lblBodyType: TLabel;
    edtBodyType: TwwDBEdit;
    lblSpedoReading: TLabel;
    edtSpeedoReading: TwwDBEdit;
    cboEmployee: TwwDBLookupCombo;
    qryEmployee: TERPQuery;
    lblEmployee: TLabel;
    cboClass: TwwDBLookupCombo;
    lblClass: TLabel;
    gryClass: TERPQuery;
    cboMake: TwwDBLookupCombo;
    qryManufacture: TERPQuery;
    qryManufactureName: TWideStringField;
    qryManufactureID: TIntegerField;
    actNext: TAction;
    AdvSmoothButton1: TAdvSmoothButton;
    keyNumeric: TAdvSmoothTouchKeyBoard;
    qryClientBailmentNumber: TWideStringField;
    qryClientBailmentAmountEx: TFloatField;
    qryClientStockReceivedDate: TDateField;
    qryClientNewOrUsed: TWideStringField;
    btnCustomise: TAdvSmoothButton;
    btnHome: TAdvSmoothButton;
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actCustomiseKeypadExecute(Sender: TObject);
    procedure actKeypadHomeExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdSalesLinesIButtonClick(Sender: TObject);
    procedure tpMainChanging(Sender: TObject; FromPage, ToPage: Integer;
      var AllowChange: Boolean);
    procedure tpMainChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
      modified: Boolean);
    procedure edtJobNameExit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actNextExecute(Sender: TObject);
    procedure grdSalesLinesColEnter(Sender: TObject);
    procedure grdSalesLinesColExit(Sender: TObject);
    procedure keyNumericKeyClick(Sender: TObject; Index: Integer);
    procedure grdSalesLinesDblClick(Sender: TObject);
    procedure cboMakeNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
    procedure cboModelNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
  private
//    ButtonArrayConfig: TJsonObject;
    Quote: TQuote;
    Job: TJob;
    KeypadConfig: TJsonObject;
    procedure LoadKeypadConfig;
    procedure DoOnArrayButtonClick(Button: TAdvSmoothButton; FunctionType, FunctionValue: string);
    function SaveQuote: boolean;
    procedure ApplyFormAccess;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string); Override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}


uses
  frmButtonArrayCustomise, BusObjConst, DNMExceptions, CommonLib,
  AppEnvironment, BusObjPreference, BusObjManufacture, BusObjModel;

procedure TfmPadQuote.actCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmPadQuote.actCustomiseKeypadExecute(Sender: TObject);
begin
  inherited;
  if frmButtonArrayCustomise.DoCustomiseButtons(Quote.SaleClassName , 'QuoteKeypad') then begin
    LoadKeypadConfig;
    ButtonArray.SelectedKeypadName:= 'Home';
  end;
end;

procedure TfmPadQuote.actKeypadHomeExecute(Sender: TObject);
begin
  inherited;
  ButtonArray.SelectedKeypadName:= 'Home';
end;

procedure TfmPadQuote.actNextExecute(Sender: TObject);
begin
  inherited;
  if SaveQuote then begin
    CommitTransaction;
    BeginTransaction;
    KeyId:= 0;
    Job.Load(0);
    Quote.Load(KeyID);
    Quote.New;
    Quote.Lines;
    if Quote.Lines.accessmanager.accesslevel = 3 then
        Quote.Lines.accessmanager.accesslevel:= 2;
    tpMain.ActivePageIndex:= 0;
  end;
end;

procedure TfmPadQuote.actSaveExecute(Sender: TObject);
begin
  inherited;
  if SaveQuote then begin
    CommitTransaction;
    Close;
  end;
end;

procedure TfmPadQuote.ApplyFormAccess;
var
  x: integer;
begin
  for x:= 0 to ComponentCount -1 do begin
    if Components[x] = cboCustomer then begin
      cboCustomer.Enabled:= Quote.IsNew and (AccessLevel < 4);
    end else if Components[x] = edtJobName then begin
      edtJobName.Enabled:= Quote.IsNew and (AccessLevel < 4);
    end else if (Components[x] = segMain) or
            (Components[x] = tpMain) or
            (Components[x] = tabHeader) or
            (Components[x] = btnCancel) or
            (Components[x] = lblCustomer) or
            (Components[x] = lblJobName) then begin
      Continue;
    end else if Components[x] = btnCustomise then begin
      btnCustomise.enabled :=self.tpMain.ActivePage = tabDetails ;
    end else if Components[x] = btnHome then begin
      btnHome.enabled :=self.tpMain.ActivePage = tabDetails ;
    end else begin
      if Components[x] is TControl then begin

        TControl(Components[x]).Enabled:=
          ((Quote.CustomerID > 0) and (Job.JobName <> '')) and
          ((AccessLevel < 3) or (Quote.IsNew and (AccessLevel = 3)));
      end;
    end;

  end;

end;

procedure TfmPadQuote.cboMakeNotInList(Sender: TObject; LookupTable: TDataSet;
  NewValue: string; var Accept: Boolean);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('This value not found in the list. Do you want to create a new one?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
  begin
    Accept := false;
    Exit;
  end;
  if TManufacture.NewManufacture(NewValue, MyConnection) then begin
    EditDb(cboMake.datasource.Dataset);
    TERPQuery(cboMake.datasource.Dataset).FieldByName('Manufacture').AsString := NewValue;
  end
  else begin
    CommonLib.MessageDlgXP_Vista('Error adding new value.', mtWarning, [mbOk], 0);
    Accept := false;
  end;
end;

procedure TfmPadQuote.cboModelNotInList(Sender: TObject; LookupTable: TDataSet;
  NewValue: string; var Accept: Boolean);
var
  msg: string;
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('This value not found in the list. Do you want to create a new one?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
  begin
    Accept := false;
    Exit;
  end;
  if TModel.AddNewModel(NewValue,msg,MyConnection) then begin
    EditDb(cboModel.datasource.Dataset);
    TERPQuery(cboModel.datasource.Dataset).FieldByName('ModelNumber').AsString := NewValue;
  end
  else begin
    CommonLib.MessageDlgXP_Vista('Error: ' + msg, mtWarning, [mbOk], 0);
    Accept := false;
  end;
end;

procedure TfmPadQuote.DoBusinessObjectEvent(const Sender: TDatasetBusObj;  const EventType, Value: string);
var
  ParentClientID: integer;
  ds: TDataset;
begin
  inherited ;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TQuote then
      TQuote(Sender).DataSet:= qrySales;
    if Sender is TQuoteLine then
      TQuoteLine(Sender).DataSet:= qrySalesLines;
    if (sender is TClient) and (Sender = Job) then
      TClient(Sender).Dataset := qryClient;
  end
  else if (Eventtype = BusObjEvent_Change) then begin
    if (Value = BusObjEvent_OnCalcOrderTotals) then begin
      grdSalesLines.ColumnByName('TotalLineAmountInc').FooterValue := FloatToStrF(Quote.TotalAmountInc, ffCurrency, 15, CurrencyRoundPlaces);
      grdSalesLines.ColumnByName('TotalLineAmount').FooterValue := FloatToStrF(Quote.TotalAmount, ffCurrency, 15, CurrencyRoundPlaces);
    end
    else if (Value = BusObjEventVal_ClientID) then begin
      if (Quote.CustomerID > 0) then begin
        if (not Quote.Customer.IsJob) then begin
          if Quote.IsNew then begin
            { this is a new Quote and the user has just selected a Customer
              so we need to Create a new Job for that customer }
            ParentClientID:= Quote.CustomerID;
            Job.New;
            Job.ParentClientId:= ParentClientID;
            Job.PostDb;
            Quote.CustomerID:= Job.ID;
          end;
        end
        else begin
          { load job data }
          if Job.ID <> Quote.CustomerID then begin

            ds := Quote.GetNewDataSet('select Count(SaleId) as InstCount from tblsales'+
              ' where IsQuote = "T" and ClientID = ' + IntToStr(Quote.CustomerID));
            ds.Open;
            if ds.FieldByName('InstCount').AsInteger > 0 then begin
              try
//                edtJobName.SetFocus;
//                SetControlFocus(edtJobName);
                Application.ProcessMessages;
              except

              end;
              if MessageDlgXP_Vista('There is already a Quote for this Job Name/Number "' + Quote.CustomerName + '"' +
                ', do you want to create another Quote for the same Job?',mtConfirmation,[mbNo,mbYes],0) = mrNo then begin
                Quote.CustomerID := 0;
                Job.Load(0);
                SetControlFocus(cboCustomer);
                exit;
              end;
            end;
            Job.Load(Quote.CustomerID);
          end;
        end;
      end;
      ApplyFormAccess;
    end;
  end;

end;

procedure TfmPadQuote.DoOnArrayButtonClick(Button: TAdvSmoothButton;
  FunctionType, FunctionValue: string);
var
  ds: TDataset;
begin
  if FunctionValue = '' then exit;
  
  if FunctionType = 'Product' then begin

    Quote.Lines.PostDb;
    ds := Quote.Lines.GetNewDataSet('select Count(SaleLineID) as InstCount' +
      ' from tblsaleslines where SaleId = ' + IntToStr(Quote.ID) +
      ' and ProductName = ' + QuotedStr(FunctionValue),true);
    try
      ds.Open;
      if ds.FieldByName('InstCount').AsInteger > 0 then begin
        if MessageDlgXP_Vista('You already have item "' + FunctionValue +
          '", do you want to add it again?',mtConfirmation,[mbNo,mbYes],0) = mrNo then
          exit;
      end;
    finally
      ds.Free;
    end;

    Quote.Lines.New;
    Quote.Lines.ProductName:= FunctionValue;
    Quote.Lines.UOMQtySold:= 1;

  end;

end;

procedure TfmPadQuote.edtJobNameExit(Sender: TObject);
begin
  inherited;
  ApplyFormAccess;
  Job.PostDb;
  Quote.CustomerName:= Job.ClientName;
  Quote.PostDB;
//  if True then

end;

procedure TfmPadQuote.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  CanClose:= true;
  if (quote.ID > 0) and (Job.ID > 0) then begin
    if Quote.Dirty or Job.Dirty then begin
      case MessageDlgXP_Vista('Do you wish to keep the changes you have made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
        mrYes:
          begin
            if not SaveQuote then Exit;
            CommitTransaction;
            CanClose:= true;
          end;
        mrNo:
          begin

          end;
        mrCancel:
          begin
            CanClose:= false;
          end;
      end;
    end;
  end;
end;

procedure TfmPadQuote.FormCreate(Sender: TObject);
var
  SavedColor: TColor;
begin
  SavedColor:= self.Color;
  inherited;
  self.Color:= SavedColor;
  KeypadConfig:= TJsonObject.Create;
  ButtonArray.OnButtonClick:= DoOnArrayButtonClick;
  Quote := TQuote.Create(Self);
//  Quote.DoProductallocation := Self.DoProductallocation;
  Quote.Name := 'QuoteObj';
  Quote.Connection := TMyDacDataConnection.Create(Quote);
  Quote.Connection.Connection := MyConnection;
  Quote.BusObjEvent := DoBusinessObjectEvent;
  Job:= TJob.Create(self);
  Job.Name := 'JobObj';
  Job.Connection := TMyDacDataConnection.Create(Job);
  Job.Connection.Connection := MyConnection;
  Job.BusObjEvent := DoBusinessObjectEvent;
  tpMain.ActivePage:= tabHeader;

  keyNumeric.Parent:= ButtonArray;
  keyNumeric.Align:= alClient;
end;

procedure TfmPadQuote.FormDestroy(Sender: TObject);
begin
  inherited;
  KeypadConfig.Free;
end;

procedure TfmPadQuote.FormResize(Sender: TObject);
begin
  inherited;
  tpMain.TabSettings.Width:=
    Trunc(Trunc(tpMain.ClientWidth - ((tpMain.TabSettings.LeftMargin + tpMain.TabSettings.RightMargin) * 2 + tpMain.TabSettings.Spacing)) / 2);
end;

procedure TfmPadQuote.FormShow(Sender: TObject);
begin
  try
    inherited;
    if AppEnv.CompanyPrefs.PadQuotePricesIncTax then
      GuiPrefs.DbGridElement[grdSalesLines].RemoveFields('TotalLineAmount')
    else
      GuiPrefs.DbGridElement[grdSalesLines].RemoveFields('TotalLineAmountInc');

    ButtonArray.SelectedKeypadName:= 'Home';

    BeginTransaction;

    if KeyID <> 0 then begin
      Quote.Load(KeyID);
  //    stepProgressbar('Loading '+TransBase.XMLNodeName +'#'+IntToStr(KeyID));
      Quote.Lines;
      if Quote.Lines.accessmanager.accesslevel = 3 then
        Quote.Lines.accessmanager.accesslevel:= 5;
    end else begin
      Quote.Load(KeyID);
  //    stepProgressbar('Adding New '+TransBase.XMLNodeName +'.');
      Quote.New;
      Quote.Lines;
      if Quote.Lines.accessmanager.accesslevel = 3 then
          Quote.Lines.accessmanager.accesslevel:= 2;
    end;

    { open lookup queries }
    qryCustomerLookup.Open;
    qrySuburb.Close;
    qrySuburb.Params.ParamByName('xRegionID').AsInteger := AppEnv.RegionalOptions.ID;
    qrySuburb.Open;
    qryInsuranceCompanyLookup.Open;
    qryModel.Open;
    qryEmployee.Open;
    gryClass.Open;
    qryManufacture.Open;

    ApplyFormAccess;

    cboCustomer.SetFocus;

  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
    else raise;
  end;

end;

procedure TfmPadQuote.grdSalesLinesColEnter(Sender: TObject);
begin
  inherited;
  if grdSalesLines.Enabled and (grdSalesLines.SelectedField = qrySalesLinesTotalLineAmountInc) and
     (qrySalesLinesProductName.AsString <> '') then begin
    keyNumeric.Visible:= true;
  end;

end;

procedure TfmPadQuote.grdSalesLinesColExit(Sender: TObject);
begin
  inherited;
  keyNumeric.Visible:= false;
end;

procedure TfmPadQuote.grdSalesLinesDblClick(Sender: TObject);
begin
  inherited;
  if grdSalesLines.Enabled and (grdSalesLines.SelectedField = qrySalesLinesTotalLineAmountInc) and
     (qrySalesLinesProductName.AsString <> '') then begin
    keyNumeric.Visible:= true;
  end;
end;

procedure TfmPadQuote.grdSalesLinesIButtonClick(Sender: TObject);
var
  isFiltered: Boolean;
  fId: Integer;
begin
  inherited;
  if Quote.Lines.Count > 0 then begin
    isFiltered:= Quote.Lines.dataset.filtered;
    try
      fId:= Quote.Lines.ID;
      Quote.Lines.Dataset.filtered := False;
      Quote.Lines.Dataset.Locate(Quote.Lines.IDFieldName, fId, []);
      Quote.Lines.DoFieldChangewhenDisabled := TRue;
      try
        Quote.Lines.Deleted:= true;
        Quote.Lines.PostDB;
      finally
        Quote.Lines.DoFieldChangewhenDisabled := False;
      end;
      if Quote.Lines.Count > 0 then Quote.Lines.PostDB;
    finally
      Quote.Lines.Dataset.filtered := isFiltered;
    end;
    Quote.CalcOrderTotals;
  end;
end;

procedure TfmPadQuote.keyNumericKeyClick(Sender: TObject; Index: Integer);
begin
  inherited;
  if Index = 14 then
    keyNumeric.Visible:= false;
end;

procedure TfmPadQuote.LoadKeypadConfig;
var
  Pref: TPreference;
begin
  KeypadConfig.Clear;
  if Quote.SaleClassName = '' then
    exit;
  Pref:= TPreference.Create(nil);
  try
    Pref.Connection:= TMyDacDataConnection.Create(Pref);
    Pref.Connection.Connection:= MyConnection;
    Pref.Load(0,'KeypadConfig','QuoteKeypad',Quote.SaleClassName);
    KeypadConfig.AsString:= Pref.PrefValue;
    ButtonArray.Config:= KeypadConfig;
  finally
    Pref.Free;
  end;
end;

function TfmPadQuote.SaveQuote: boolean;
begin
  result:= Job.Save and Quote.Save;
end;

procedure TfmPadQuote.SuburbCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if Modified then begin
    Job.State:= LookupTable.FieldByName('State').AsString;
    Job.Postcode:= LookupTable.FieldByName('PostCode').AsString;
    Job.Country:= LookupTable.FieldByName('Country').asString;
//    FillTable.FieldByName('State').AsString    := LookupTable.FieldByName('State').AsString;
//    FillTable.FieldByName('Postcode').AsString := LookupTable.FieldByName('Postcode').AsString;
//    FillTable.FieldByName('Country').asString  := LookupTable.FieldByName('Country').asString;
  end;
end;

procedure TfmPadQuote.tpMainChange(Sender: TObject);
begin
  inherited;
  if self.tpMain.ActivePage = tabDetails then begin
    LoadKeypadConfig;
    ButtonArray.SelectedKeypadName:= 'Home';
  end;
  btnCustomise.enabled :=self.tpMain.ActivePage = tabDetails ;
  btnHome.enabled :=self.tpMain.ActivePage = tabDetails ;
end;

procedure TfmPadQuote.tpMainChanging(Sender: TObject; FromPage, ToPage: Integer;
  var AllowChange: Boolean);
begin
  inherited;
  { validate customer before allowing change }
  if ToPage = 1 then begin
    AllowChange:= false;
    if (Quote.CustomerID = 0) then begin
      MessageDlgXP_Vista('Please select a Customer first.', mtInformation, [mbOk], 0);
      SetControlFocus(cboCustomer);
      exit;
    end
    else if (Job.JobName = '') then begin
      MessageDlgXP_Vista('Please enter Job Name / Claim Number first.', mtInformation, [mbOk], 0);
      SetControlFocus(edtJobName);
      exit;
    end;
    AllowChange:= true;
  end;
end;

initialization
  RegisterClass(TfmPadQuote);

end.
