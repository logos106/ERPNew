unit frmPadRepairs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmPadBaseInput, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  AdvSmoothExpanderGroup, ExtCtrls, AdvSmoothButton, ActnList, AdvSmoothTabPager,
  Grids, AdvObj, BaseGrid, AdvGrid, frameButtonArray, JsonObject,
  BusObjBase, StdCtrls, wwdblook, ERPDbLookupCombo, Buttons,
  Wwdbigrd, Wwdbgrid, Mask, wwdbedit, BusObjClient, wwdbdatetimepicker,
  AdvSmoothTouchKeyBoard, ProgressDialog,BusObjRepairs, DBCtrls, ComCtrls,
  AdvSmoothToggleButton, DNMSpeedButton, TeeProcs, TeeDraw3D, DNMPanel, frmDraw, DNMAction;

type
  TfmPadRepairs = class(TfmPadBaseInput)
    btnSave: TAdvSmoothButton;
    btnCancel: TAdvSmoothButton;
    tpMain: TAdvSmoothTabPager;
    tabHeader: TAdvSmoothTabPage;
    tpDetails: TAdvSmoothTabPage;
    actCustomiseKeypad: TAction;
    actKeypadHome: TAction;
    ButtonArray: TfrButtonArray;
    QryRepairs: TERPQuery;
    qryRepairparts: TERPQuery;
    cboCustomer: TERPDbLookupCombo;
    grdRepairParts: TwwDBGrid;
    dsRepairparts: TDataSource;
    dsRepairs: TDataSource;
    grdRepairPartsIButton: TwwIButton;
    qryCustomerLookup: TERPQuery;
    qryCustomerLookupClientID: TIntegerField;
    qryCustomerLookupCompany: TWideStringField;
    lblCustomer: TLabel;
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
    Label4: TLabel;
    edtStreet1: TwwDBEdit;
    edtStreet2: TwwDBEdit;
    edtStreet3: TwwDBEdit;
    lblSuburb: TLabel;
    lblState: TLabel;
    edtState: TwwDBEdit;
    lblPostCode: TLabel;
    edtPostCode: TwwDBEdit;
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
    qryEmployee: TERPQuery;
    cboClass: TwwDBLookupCombo;
    lblClass: TLabel;
    gryClass: TERPQuery;
    actNext: TAction;
    AdvSmoothButton1: TAdvSmoothButton;
    keyNumeric: TAdvSmoothTouchKeyBoard;
    qryClientBailmentNumber: TWideStringField;
    qryClientBailmentAmountEx: TFloatField;
    qryClientStockReceivedDate: TDateField;
    qryClientNewOrUsed: TWideStringField;
    btnCustomise: TAdvSmoothButton;
    btnHome: TAdvSmoothButton;
    QryRepairsRepairID: TIntegerField;
    QryRepairsGlobalRef: TWideStringField;
    QryRepairsRepairDocNo: TWideStringField;
    QryRepairsCusID: TIntegerField;
    QryRepairsCreationDate: TDateField;
    QryRepairsNotes: TWideMemoField;
    QryRepairsFeedbackNotes: TWideMemoField;
    QryRepairsClassID: TIntegerField;
    QryRepairsEmployeeID: TIntegerField;
    QryRepairsmsTimeStamp: TDateTimeField;
    QryRepairsCustomerName: TWideStringField;
    QryRepairsDeptClassname: TStringField;
    qryRepairpartsGlobalRef: TWideStringField;
    qryRepairpartsRepairPartsID: TIntegerField;
    qryRepairpartsRepairID: TIntegerField;
    qryRepairpartsPartsID: TIntegerField;
    qryRepairpartsPartName: TWideStringField;
    qryRepairpartsQty: TFloatField;
    qryRepairpartsDescription: TWideStringField;
    qryRepairpartsPriceEx: TFloatField;
    qryRepairpartsPriceInc: TFloatField;
    qryRepairpartsClassName: TWideStringField;
    qryRepairpartsClassID: TIntegerField;
    qryRepairpartsPartType: TWideStringField;
    qryRepairpartsUnitofMeasure: TWideStringField;
    qryRepairpartsUnitofMeasureID: TLargeintField;
    qryRepairpartsUnitofMeasureMultiplier: TFloatField;
    qryRepairpartsUOMQty: TFloatField;
    qryRepairpartsmsUpdateSiteCode: TWideStringField;
    qryRepairpartsmsTimeStamp: TDateTimeField;
    Label1: TLabel;
    txtNotes: TDBMemo;
    edtcity: TwwDBEdit;
    QryRepairEquip: TERPQuery;
    dsRepairEquip: TDataSource;
    QryRepairEquipRepairID: TIntegerField;
    QryRepairEquipEquipName: TWideStringField;
    QryRepairEquipStreetMap: TBlobField;
    QryRepairEquipBuildingMap: TBlobField;
    qryrepairpartsDeleted: TWideStringField;
    QryRepairEquipcustomerequipID: TIntegerField;
    qryrepairpartsCustomerEquipmentID: TIntegerField;
    qryrepairpartsTaxCode: TWideStringField;
    qryrepairpartsTaxRate: TFloatField;
    qryrepairpartsDiscount: TFloatField;
    qryrepairpartsMarkup: TFloatField;
    qryrepairpartsDiscountPercent: TFloatField;
    qryrepairpartsMarkupPercent: TFloatField;
    qryrepairpartsLineTotalEx: TFloatField;
    qryrepairpartsEditedFlag: TWideStringField;
    qryrepairpartsConvertToInvoice: TWideStringField;
    qryrepairpartsETADate: TDateField;
    qryrepairpartsPurchaseOrderID: TIntegerField;
    qryrepairpartsMemoLine: TWideMemoField;
    qryrepairpartsInvoiceLineRef: TWideStringField;
    qryrepairpartsEquipment: TWideStringField;
    qryrepairpartsPartIssuedOn: TDateTimeField;
    qryrepairpartsSerialNos: TWideMemoField;
    qryrepairpartsLinecost: TFloatField;
    qryrepairpartsParentProductID: TLargeintField;
    qryrepairpartsParentLineRef: TWideStringField;
    qryrepairpartsRelatedProductQty: TFloatField;
    qryrepairpartsIsRelatedProduct: TWideStringField;
    qryrepairpartsSaleLineId: TIntegerField;
    qryrepairpartsMatrixDesc: TWideMemoField;
    qryrepairpartsMatrixRef: TWideMemoField;
    qryrepairpartsMatrixPrice: TFloatField;
    qryrepairpartsCustfld1: TWideStringField;
    qryrepairpartsCustFld2: TWideStringField;
    qryrepairpartsCustFld3: TWideStringField;
    qryrepairpartsCustFld4: TWideStringField;
    qryrepairpartsCustFld5: TWideStringField;
    qryrepairpartsCustFld6: TWideStringField;
    qryrepairpartsCustFld7: TWideStringField;
    qryrepairpartsCustFld8: TWideStringField;
    qryrepairpartsCustFld9: TWideStringField;
    qryrepairpartsCustFld10: TWideStringField;
    qryrepairpartsFormulaQtyValue1: TFloatField;
    qryrepairpartsFormulaQtyValue2: TFloatField;
    qryrepairpartsFormulaQtyValue3: TFloatField;
    qryrepairpartsFormulaQtyValue4: TFloatField;
    qryrepairpartsFormulaQtyValue5: TFloatField;
    qryrepairpartsFormulaQtyValue: TFloatField;
    qryrepairpartscalcTax: TFloatField;
    qryrepairpartscalcTotalEx: TFloatField;
    qryrepairpartscalcTotalInc: TFloatField;
    qryrepairpartscalcTotalIncBase: TFloatField;
    QryrepairsCancelled: TWideStringField;
    QryrepairsUpdateDate: TDateField;
    QryrepairsDone: TWideStringField;
    QryrepairsEditedFlag: TWideStringField;
    QryrepairsCustomerDetails: TWideStringField;
    QryrepairsPhone: TWideStringField;
    QryrepairsAltPhone: TWideStringField;
    QryrepairsFax: TWideStringField;
    QryrepairsJobDueDate: TDateTimeField;
    QryrepairsConverted: TWideStringField;
    QryrepairsStatus: TWideStringField;
    QryrepairsBillToCustomerDetails: TWideStringField;
    QryrepairsBillCusID: TIntegerField;
    QryrepairsUseBillCust: TWideStringField;
    QryrepairsBillPhone: TWideStringField;
    QryrepairsBillAltPhone: TWideStringField;
    QryrepairsBillFax: TWideStringField;
    QryrepairsSOGlobalRef: TWideStringField;
    QryrepairsQuoteGlobalRef: TWideStringField;
    QryrepairsCustomerPONumber: TWideStringField;
    QryrepairsCompletionTime: TWideStringField;
    QryrepairsShipping: TWideStringField;
    QryrepairsAllocatedEmployeeID: TIntegerField;
    QryrepairsTermsId: TLargeintField;
    QryrepairsTerms: TWideStringField;
    QryrepairsMobile: TWideStringField;
    QryrepairsBillMobile: TWideStringField;
    QryrepairsContactID: TLargeintField;
    QryrepairsQuotedAmount: TFloatField;
    QryrepairsQuotedAmountinc: TFloatField;
    QryrepairsHoldRepair: TWideStringField;
    QryrepairsCUSTFLD1: TWideStringField;
    QryrepairsCUSTFLD2: TWideStringField;
    QryrepairsCUSTFLD3: TWideStringField;
    QryrepairsCUSTFLD4: TWideStringField;
    QryrepairsCUSTFLD5: TWideStringField;
    QryrepairsCUSTFLD6: TWideStringField;
    QryrepairsCUSTFLD7: TWideStringField;
    QryrepairsCUSTFLD8: TWideStringField;
    QryrepairsCUSTFLD9: TWideStringField;
    QryrepairsCUSTFLD10: TWideStringField;
    QryrepairsCUSTFLD11: TWideStringField;
    QryrepairsCUSTFLD12: TWideStringField;
    QryrepairsCUSTFLD13: TWideStringField;
    QryrepairsCUSTFLD14: TWideStringField;
    QryrepairsCUSTFLD15: TWideStringField;
    QryrepairsCUSTDATE1: TDateTimeField;
    QryrepairsCUSTDATE2: TDateTimeField;
    QryrepairsCUSTDATE3: TDateTimeField;
    QryrepairsDetailsExported: TWideStringField;
    QryrepairsBillCustomerName: TWideStringField;
    QryrepairsBilltotalPrice: TFloatField;
    QryrepairsShipToID: TIntegerField;
    QryrepairsmsUpdateSiteCode: TWideStringField;
    qryTimeSheetEntry: TERPQuery;
    qryTimeSheetEntryGlobalRef: TWideStringField;
    qryTimeSheetEntryTimesheetEntryID: TIntegerField;
    qryTimeSheetEntryEntryDate: TDateTimeField;
    qryTimeSheetEntryType: TWideStringField;
    qryTimeSheetEntryTypeID: TIntegerField;
    qryTimeSheetEntryWhoEntered: TWideStringField;
    qryTimeSheetEntrymsTimeStamp: TDateTimeField;
    qryTimesheets: TERPQuery;
    qryTimesheetsEmployeeName: TWideStringField;
    qryTimesheetstimesheetDate: TDateTimeField;
    qryTimesheetsEquipment: TWideStringField;
    qryTimesheetsRepairDocNo: TStringField;
    qryTimesheetsJob: TWideStringField;
    qryTimesheetsPayRateTypeName: TWideStringField;
    qryTimesheetsLabourCost: TFloatField;
    qryTimesheetsHours: TFloatField;
    qryTimesheetsServiceName: TWideStringField;
    qryTimesheetsQty: TFloatField;
    qryTimesheetsChargeRate: TFloatField;
    qryTimesheetsServiceDate: TDateField;
    qryTimesheetsClassName: TWideStringField;
    QryTimeSheetsNotes: TWideMemoField;
    qryTimesheetsAllowEdit: TWideStringField;
    qryTimesheetsUseTimeCost: TWideStringField;
    qryTimesheetsTotal: TFloatField;
    qryTimesheetsTotalServicecharge: TFloatField;
    qryTimesheetsRepairID: TIntegerField;
    qryTimesheetscustomerEquipmentID: TIntegerField;
    qryTimesheetsTimesheetEntryID: TIntegerField;
    qryTimesheetsSuperInc: TWideStringField;
    qryTimesheetsGlobalRef: TWideStringField;
    qryTimesheetsID: TAutoIncField;
    qryTimesheetsJobID: TIntegerField;
    qryTimesheetsEmployeeID: TIntegerField;
    qryTimesheetsClassID: TIntegerField;
    qryTimesheetsRosterID: TIntegerField;
    qryTimesheetsServiceID: TIntegerField;
    qryTimesheetsPartID: TIntegerField;
    qryTimesheetsPartName: TWideStringField;
    qryTimesheetsPayRateTypeID: TIntegerField;
    qryTimesheetsHourlyRate: TFloatField;
    qryTimesheetsSuperAmount: TFloatField;
    qryTimesheetsActive: TWideStringField;
    qryTimesheetsSalesID: TIntegerField;
    qryTimesheetsTax: TFloatField;
    qryTimesheetsPartsDescription: TWideStringField;
    qryTimesheetsSaleLineID: TIntegerField;
    DSTimesheet: TDataSource;
    dsTimeSheetEntry: TDataSource;
    tabLabour: TAdvSmoothTabPage;
    Label5: TLabel;
    dtServicedate: TwwDBDateTimePicker;
    Label7: TLabel;
    txtStartTime: TComboBox;
    Label8: TLabel;
    txtEndtime: TComboBox;
    Label6: TLabel;
    edtHours: TwwDBEdit;
    grdTimesheet: TwwDBGrid;
    ibtimesheet: TwwIButton;
    lblMsg: TLabel;
    Label9: TLabel;
    edtEquip: TwwDBEdit;
    Label10: TLabel;
    wwDBEdit4: TwwDBEdit;
    btnGo: TAdvSmoothToggleButton;
    edttime: TEdit;
    tmrGo: TTimer;
    tpEquip: TAdvSmoothTabPage;
    Label11: TLabel;
    wwDBEdit2: TwwDBEdit;
    QryRepairEquipWarantyfinishdate: TDateTimeField;
    QryRepairEquipWarantystartDate: TDateTimeField;
    QryRepairEquipQuantity: TFloatField;
    QryRepairEquipWarantyPeriodLeft: TLargeintField;
    QryRepairEquipNotes: TWideStringField;
    QryRepairEquipCustomField1: TWideStringField;
    QryRepairEquipCustomField2: TWideStringField;
    QryRepairEquipCustomField3: TWideStringField;
    QryRepairEquipCustomField4: TWideStringField;
    QryRepairEquipCustomField5: TWideStringField;
    QryRepairEquipCustomField6: TWideStringField;
    QryRepairEquipCustomField7: TWideStringField;
    QryRepairEquipCustomField8: TWideStringField;
    QryRepairEquipCustomField9: TWideStringField;
    QryRepairEquipCustomField10: TWideStringField;
    QryRepairEquipCustomerEquipmentID: TIntegerField;
    QryRepairEquipOnSite: TWideStringField;
    Label12: TLabel;
    DBImage2: TDBImage;
    Label13: TLabel;
    DBImage3: TDBImage;
    Label14: TLabel;
    wwDBEdit3: TwwDBEdit;
    Label16: TLabel;
    wwDBEdit6: TwwDBEdit;
    Label17: TLabel;
    wwDBEdit5: TwwDBEdit;
    Label15: TLabel;
    Label18: TLabel;
    wwDBEdit8: TwwDBEdit;
    Label19: TLabel;
    QryRepairEquipWarantyPeriod: TFloatField;
    QryRepairEquipWarrantyPeriodUsed: TFloatField;
    wwDBEdit9: TwwDBEdit;
    Label20: TLabel;
    wwDBEdit7: TwwDBEdit;
    QryRepairEquipUOM: TWideStringField;
    Label21: TLabel;
    wwDBEdit10: TwwDBEdit;
    Label22: TLabel;
    wwDBEdit11: TwwDBEdit;
    Label23: TLabel;
    wwDBEdit12: TwwDBEdit;
    Label24: TLabel;
    wwDBEdit13: TwwDBEdit;
    Label25: TLabel;
    wwDBEdit14: TwwDBEdit;
    Label26: TLabel;
    wwDBEdit15: TwwDBEdit;
    QryRepairEquipManufacture: TWideStringField;
    QryRepairEquipmodel: TWideStringField;
    QryRepairEquipSerialno: TWideStringField;
    QryRepairEquipRegistration: TWideStringField;
    QryRepairEquipEquipNotes: TWideMemoField;
    Shape1: TShape;
    qryClientcontact: TERPQuery;
    dsClientcontact: TDataSource;
    qryClientcontactclientID: TIntegerField;
    qryClientcontactcompany: TWideStringField;
    qryClientcontactStreet: TWideStringField;
    qryClientcontactstreet2: TWideStringField;
    qryClientcontactstreet3: TWideStringField;
    qryClientcontactstate: TWideStringField;
    qryClientcontactpostcode: TWideStringField;
    qryClientcontactphone: TWideStringField;
    qryClientcontactMobile: TWideStringField;
    qryClientcontactEmail: TWideStringField;
    qryClientcontactSuburb: TWideStringField;
    qryClientcontactcontactname: TWideStringField;
    Label27: TLabel;
    wwDBEdit16: TwwDBEdit;
    Shape2: TShape;
    Label3: TLabel;
    txtFeedback: TDBMemo;
    btntoggle: TAdvSmoothButton;
    QryRepairEquipRepairFault: TWideStringField;
    Label2: TLabel;
    wwDBEdit1: TwwDBEdit;
    optRepairStatus: TRadioGroup;
    qryServices: TERPQuery;
    qryServicesServiceName: TWideStringField;
    qryServicesID: TAutoIncField;
    qryServicesEmployeeID: TIntegerField;
    qryServicesRate: TFloatField;
    qryServicesPartID: TIntegerField;
    qryServicesPartName: TWideStringField;
    cboServices: TwwDBLookupCombo;
    Label28: TLabel;
    btnAttach: TAdvSmoothButton;
    pnlsignature: TDNMPanel;
    qryTimesheetssignature: TBlobField;
    qryTimesheetsSignatureTime: TDateTimeField;
    qryTimesheetsContactName:TWideStringfield;

    Label29: TLabel;
    Label30: TLabel;
    wwDBEdit17: TwwDBEdit;
    Shape3: TShape;
    Label31: TLabel;
    qryContacts: TERPQuery;
    wwDBLookupCombo1: TwwDBLookupCombo;
    qryContactsContactID: TIntegerField;
    qryContactscontactName: TWideStringField;
    qryTimesheetsSignatureMemo: TStringField;
    qryEmployees: TERPQuery;
    dsOtherFollowUp: TDataSource;
    tbOtherFollowUp: TERPQuery;
    tbOtherFollowUpFollowUpDate: TDateTimeField;
    tbOtherFollowUpEmployeeName: TWideStringField;
    tbOtherFollowUpDone: TWideStringField;
    tbOtherFollowUpGlobalRef: TWideStringField;
    tbOtherFollowUpFollowUpID: TAutoIncField;
    tbOtherFollowUpOtherContactID: TIntegerField;
    tbOtherFollowUpRepairID: TIntegerField;
    tbOtherFollowUpEmployeeID: TIntegerField;
    tbOtherFollowUpClientID: TIntegerField;
    tbOtherFollowUpEditedFlag: TWideStringField;
    tbOtherFollowUpAppearDays: TIntegerField;
    tbOtherFollowUpCreationDate: TDateTimeField;
    tbOtherFollowUpUpdateDate: TDateField;
    tbOtherFollowUpIsSupplier: TWideStringField;
    tbOtherFollowUpIsOtherContact: TWideStringField;
    tbOtherFollowUpIsCustomer: TWideStringField;
    tbOtherFollowUpNotes: TWideMemoField;
    AdvSmoothTabPage1: TAdvSmoothTabPage;
    tblrepairsFaults: TERPQuery;
    dsrepairsFaults: TDataSource;
    tblrepairsFaultsGlobalRef: TWideStringField;
    tblrepairsFaultsRepairsFaultId: TIntegerField;
    tblrepairsFaultsRepairID: TIntegerField;
    tblrepairsFaultsTimeSheetID: TIntegerField;
    tblrepairsFaultsRepairFault: TWideStringField;
    tblrepairsFaultsmsTimeStamp: TDateTimeField;
    tblrepairsFaultsCustomerEquipmentID: TIntegerField;
    tblrepairsFaultsEquipment: TWideStringField;
    tblrepairsFaultsDeleted: TWideStringField;
    tblrepairsFaultsmsUpdateSiteCode: TWideStringField;
    tblrepairsFaultsDone: TWideStringField;
    QryrepairFaults: TERPQuery;
    QryrepairFaultsName: TWideStringField;
    QryrepairFaultsDescription: TWideStringField;
    QryrepairFaultsTypecode: TWideStringField;
    AdvSmoothButton2: TAdvSmoothButton;
    actInvoice: TDNMAction;
    DNMPanel3: TDNMPanel;
    DNMPanel1: TDNMPanel;
    grdOtherFollowUp: TwwDBGrid;
    btnDeleteOtherFollowUp: TwwIButton;
    dtpFollowUpDate: TwwDBDateTimePicker;
    cboEmployeeOthersFollowUp: TwwDBLookupCombo;
    Label33: TLabel;
    DNMPanel2: TDNMPanel;
    Label32: TLabel;
    grdParts: TwwDBGrid;
    btnDeleteParts: TwwIButton;
    cboRepairFault: TwwDBLookupCombo;
    qryDocuments: TERPQuery;
    DSDocuments: TDataSource;
    DNMPanel4: TDNMPanel;
    grdDocs: TwwDBGrid;
    grdDocsIButton: TwwIButton;
    LetterBtn: TDNMSpeedButton;
    EmailBtn: TDNMSpeedButton;
    Label34: TLabel;
    btnEmail: TAdvSmoothButton;
    DNMAction1: TDNMAction;
    qryStatus: TERPQuery;
    qryStatusName: TWideStringField;
    Label35: TLabel;
    cboStatus: TwwDBLookupCombo;
    btnPreview: TAdvSmoothButton;
    AdvSmoothButton3: TAdvSmoothButton;
    QryAttachments: TERPQuery;
    QryAttachmentsGlobalRef: TWideStringField;
    QryAttachmentsAttachmentId: TIntegerField;
    QryAttachmentsTableName: TWideStringField;
    QryAttachmentsTableId: TIntegerField;
    QryAttachmentsAttachment: TBlobField;
    QryAttachmentsAttachmentName: TWideStringField;
    QryAttachmentsDescription: TWideStringField;
    QryAttachmentsmsTimeStamp: TDateTimeField;
    QryAttachmentsmsUpdateSiteCode: TWideStringField;
    qryShippingAddress: TERPQuery;
    dsShippingAddress: TDataSource;
    qryShippingAddressGlobalRef: TWideStringField;
    qryShippingAddressShipAddressID: TIntegerField;
    qryShippingAddressCompanyName: TWideStringField;
    qryShippingAddressCustomer_ID: TIntegerField;
    qryShippingAddressContactName: TWideStringField;
    qryShippingAddressShipAddress: TWideStringField;
    qryShippingAddressShipAddress1: TWideStringField;
    qryShippingAddressShipCity: TWideStringField;
    qryShippingAddressShipPostCode: TWideStringField;
    qryShippingAddressShipState: TWideStringField;
    qryShippingAddressShipCountry: TWideStringField;
    qryShippingAddressEditedFlag: TWideStringField;
    qryShippingAddressmsTimeStamp: TDateTimeField;
    qryShippingAddressShipAddress2: TWideStringField;
    qryShippingAddressActive: TWideStringField;
    qryShippingAddressPortOfLanding: TWideStringField;
    qryShippingAddressPortOfDischarge: TWideStringField;
    qryShippingAddressFinalDestination: TWideStringField;
    qryShippingAddressIncoPlace: TWideStringField;
    qryShippingAddressPhone: TWideStringField;
    qryShippingAddressmsUpdateSiteCode: TWideStringField;
    qryShippingAddressemail: TWideStringField;
    btnAddDate: TAdvSmoothButton;
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actCustomiseKeypadExecute(Sender: TObject);
    procedure actKeypadHomeExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdRepairPartsIButtonClick(Sender: TObject);
    procedure tpMainChanging(Sender: TObject; FromPage, ToPage: Integer;
      var AllowChange: Boolean);
    procedure tpMainChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actNextExecute(Sender: TObject);
    procedure grdRepairPartsColEnter(Sender: TObject);
    procedure grdRepairPartsColExit(Sender: TObject);
    procedure keyNumericKeyClick(Sender: TObject; Index: Integer);
    procedure grdRepairPartsDblClick(Sender: TObject);
    procedure QryrepairsAfterOpen(DataSet: TDataSet);
    procedure cboCustomerExit(Sender: TObject);
    procedure dttimefromChange(Sender: TObject);
    procedure ibtimesheetClick(Sender: TObject);
    procedure grdTimesheetRowChanged(Sender: TObject);
    procedure LocateThisLabourRec(Sender: TObject);
    procedure grdTimesheetCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure btnGoClick(Sender: TObject);
    procedure tmrGoTimer(Sender: TObject);
    procedure edtEquipDblClick(Sender: TObject);
    procedure QryRepairEquipCalcFields(DataSet: TDataSet);
    procedure FormActivate(Sender: TObject);
    procedure btntoggleClick(Sender: TObject);
    procedure edtEmailClick(Sender: TObject);
    procedure optRepairStatusClick(Sender: TObject);
    procedure btnAttachClick(Sender: TObject);
    procedure pnlsignatureExit(Sender: TObject);
    procedure qryTimesheetsAfterOpen(DataSet: TDataSet);
    procedure qryTimesheetsCalcFields(DataSet: TDataSet);
    procedure grdOtherFollowUpExit(Sender: TObject);
    procedure wwDBLookupCombo1NotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure btnDeletePartsClick(Sender: TObject);
    procedure tblrepairsFaultsAfterInsert(DataSet: TDataSet);
    procedure cboRepairFaultDblClick(Sender: TObject);
    procedure cboRepairFaultNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure txtFeedbackEnter(Sender: TObject);
    procedure txtFeedbackExit(Sender: TObject);
    procedure actInvoiceExecute(Sender: TObject);
    procedure tblrepairsFaultsBeforeOpen(DataSet: TDataSet);
    procedure cboStatusDblClick(Sender: TObject);
    procedure cboStatusNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
    procedure cboStatusCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure btnEmailClick(Sender: TObject);
    procedure EmailBtnClick(Sender: TObject);
    procedure LetterBtnClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure AdvSmoothButton3Click(Sender: TObject);
    procedure qryTimesheetsQtyChange(Sender: TField);
    procedure btnAddDateClick(Sender: TObject);
  private
    KeypadConfig: TJsonObject;
    fiapptID: Integer;
    timeSheetID:Integer;
    tmStarted:Tdatetime;
    seconds :Integer;
    DtHeight :Integer;
    DTWidth :Integer;
    fSignature : TfmDraw;
    FeedbackchangeUsernDtTime:String;

    procedure LoadKeypadConfig;
    procedure DoOnArrayButtonClick(Button: TAdvSmoothButton; FunctionType, FunctionValue: string);
    function SaveRepair: boolean;
    procedure ApplyFormAccess;
    procedure MakeTimeSheet;
    function combotime(Sender:TCombobox; dt: TDateTime; fbnext:Boolean = True): String;
    procedure ShowAttachments(fbDragnDropping :Boolean);
    procedure showSignature;
    procedure OnSigned(Sender: TObject);
    procedure EmailServicePad;
    Procedure PrintReport;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    RepairsOBJ: TRepairs;
    Property apptID:Integer read fiapptID write fiapptID;
  end;

const
  KeyPadName = 'RepairKeypad';

implementation


{$R *.dfm}


uses
  frmButtonArrayCustomise, BusObjConst, DNMExceptions, CommonLib,
  AppEnvironment, BusObjPreference, BusObjManufacture, BusObjModel,
  BusObjEmployeeServices, tcDataUtils, BusObjTimeSheet, dateutils,
  BusObjAppointments, timelib, MySQLConst, tcTypes,
  frmRepairCorrespondenceCreate, frmAttachments,  BusObjCommon, frmSimpleTypes, tcconst, DNMLib, BusObjSales, RepairsLib, AppEnvVirtualObj, BusObjPrintDoc, frmPicture,
  BusObjAttachment, BusObjShippingAddress;

procedure TfmPadRepairs.actCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmPadRepairs.actCustomiseKeypadExecute(Sender: TObject);
begin
  inherited;
  if frmButtonArrayCustomise.DoCustomiseButtons(RepairsOBJ.DeptClassName, KeyPadName) then begin
    LoadKeypadConfig;
    ButtonArray.SelectedKeypadName:= 'Home';
  end;
end;

procedure TfmPadRepairs.actInvoiceExecute(Sender: TObject);
var
  str,SaleIDs :String;
begin
    ProcessingCursor;
    try

          if RepairsOBJ.Converted then
            if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnMakeduplicateInvoiceForrepair') <> 1 then begin
              MessageDlgXP_Vista('Invoice is already created for this repair. You don''t have access to create a duplicate Invoice for the repair', mtWarning, [mbOK], 0);
              Exit;
            end;
          if RepairsOBJ.Converted then
              str:= 'This Repair is already converted.' + chr(13) + 'Are you sure you want to Save changes and convert it again?'
              else str :='Are you sure you want to Save changes and convert this Repair to Invoice?';
          if CommonLib.MessageDlgXP_Vista(str, mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;

            if not SaveRepair then Exit;
            try
                RepairsOBJ.connection.CommitTransaction;
                SaleIDs:= RepairsObj.CopyRepairtoSales(TInvoice.classname);
                if (SaleIDs <> '') then
                  if (Pos(',',SaleIDs) = 0) then
                    CommonLib.MessageDlgXP_Vista('Invoice # ' +SaleIDs + ' is created'   ,mtInformation,[mbOk],0)
                  else
                    CommonLib.MessageDlgXP_Vista('The following Invoice(s) are created: ' + SaleIDs ,mtInformation,[mbOk],0);
            finally
              RepairsOBJ.connection.BeginTransaction;
            end;
    finally
        ProcessingCursor(False);
    end;
end;

procedure TfmPadRepairs.actKeypadHomeExecute(Sender: TObject);
begin
  inherited;
  ButtonArray.SelectedKeypadName:= 'Home';
end;
function TfmPadRepairs.combotime(Sender:TCombobox;dt:TDateTime; fbnext:Boolean = True):String;
begin
  while Sender.Items.IndexOf(FormatDateTime(MysqlTimeFormat12hr, dt)) <0 do
    if fbnext then dt := IncMinute(dt, 1) else dt := IncMinute(dt, -1);
  Sender.text :=FormatDateTime(MysqlTimeFormat12hr, dt);
end;

Procedure TfmPadRepairs.MakeTimeSheet;
var
  dt:TdateTime;
begin
    if AccessLevel > 3 then exit;
    if RepairsOBJ.TimesheetEntry.Count =0 then RepairsOBJ.newTimesheetEntry;
    RepairsOBJ.TimesheetEntry.Timesheet.New;
    if cboServices.Text = '' then begin
      TEmployeeServices.AddService(PART_SERVICE_LABOUR , Appenv.Employee.EmployeeID , GetProduct(PART_SERVICE_LABOUR));
      RepairsOBJ.TimesheetEntry.Timesheet.ServiceName := PART_SERVICE_LABOUR;
    end else begin
      RepairsOBJ.TimesheetEntry.Timesheet.ServiceName :=cboServices.Text;
    end;
    if apptID <> 0 then begin
      With TAppointment.Create(Self) do try
        connection := RepairsOBJ.Connection;
        Load(apptID);
        RepairsOBJ.TimesheetEntry.Timesheet.timeSheetdate := AppDate;
        RepairsOBJ.TimesheetEntry.Timesheet.Servicedate:= AppDate;
        TxtstartTime.Text  := Start_Time;
        txtendtime.Text := End_Time;
      finally
        Free;
      end;
    end else begin
        RepairsOBJ.TimesheetEntry.Timesheet.timeSheetdate := Date;
        RepairsOBJ.TimesheetEntry.Timesheet.Servicedate:= Date;
        dt:= now;             combotime(TxtstartTime, dt, false);
        dt:= inchour(now,2);  combotime(Txtendtime,dt);
    end;
    RepairsOBJ.TimesheetEntry.Timesheet.EmployeeID :=Appenv.Employee.EmployeeID;
    RepairsOBJ.TimesheetEntry.Timesheet.EquipmentName :=QryRepairEquipEquipName.AsString;
    RepairsOBJ.TimesheetEntry.Timesheet.PostDB;
    timeSheetID := RepairsOBJ.TimesheetEntry.Timesheet.Id;
    RepairsOBJ.TimesheetEntry.Timesheet.IgnoreLabourcostValidation:= True;
    dttimefromChange(TxtstartTime);
end;
procedure TfmPadRepairs.actNextExecute(Sender: TObject);
begin
  inherited;
  if SaveRepair then begin
    CommitTransaction;
    apptID:= 0;
    BeginTransaction;
    KeyId:= 0;
    RepairsOBJ.Load(KeyID);
    RepairsOBJ.New;
    RepairsOBJ.RepairParts;
    MakeTimeSheet;
    RepairsOBJ.OtherFollowup;
    RepairsOBJ.RepairEquipmentFault;
    if RepairsOBJ.RepairParts.accessmanager.accesslevel = 3 then
        RepairsOBJ.RepairParts.accessmanager.accesslevel:= 2;
    tpMain.ActivePageIndex:= 0;
    RepairsOBJ.Customer;
    ApplyFormAccess;
  end;
end;

procedure TfmPadRepairs.actSaveExecute(Sender: TObject);
begin
  inherited;
  if SaveRepair then begin
    CommitTransaction;
    RepairsOBJ.Dirty := False;
    Close;
  end;
end;

procedure TfmPadRepairs.EmailBtnClick(Sender: TObject);
begin
  inherited;
    if Accesslevel >= 5 then Exit;
    repairsObj.PostDb;
    RepairCreateCorrespondence(ctEmail, self, repairsObj.Customer.FirstName);
    if qryDocuments.active then qryDocuments.close; qryDocuments.open;
end;

procedure TfmPadRepairs.EmailServicePad;
var
  fPrintDoc :TBusObjPrintDoc;
begin
 DisableForm;
  try
    if SaveRepair then begin
      //RepairsOBJ.Connection.CommitTransaction;
      RepairsOBJ.Dirty := False;
      ReportToPrint := GetDefaultReport(TemplateTypeID('Service Pad'));
      if ReportToPrint = '' then ReportToPrint:= 'Service Pad';
      fbTemplateUsesNonFormConnection:= False;
      try
        EmailReport(RepairsOBJ.ID, RepairsOBJ.client.ClientName, RepairsOBJ.Client.Email , 'Repair - Service Pad' ,ReportToPrint ,RepairsReportSQL(RepairsObj.ID, timeSheetID) , True, true);

        fPrintDoc := TBusObjPrintDoc.Create(nil);
        try
            fPrintDoc.PrintDoc(RepairsOBJ.ClassName,RepairsOBJ.ID,dtMain,Self.Classname ,dotEmail , ReportToPrint);
        finally
          fPrintDoc.Free;
        end;

        RepairsObj.Correspondence.New;
        RepairsObj.Correspondence.ReferenceTxt  := '';
        RepairsObj.Correspondence.Ref_Date      := now;
        RepairsObj.Correspondence.RepairID      := RepairsObj.ID;
        RepairsObj.Correspondence.CusId         := RepairsObj.ClientID;
        RepairsObj.Correspondence.ContactId     := RepairsObj.ContactID;
        RepairsObj.Correspondence.Ref_Type      := 'Email';
        RepairsObj.Correspondence.MessageFrom   := AppEnv.Employee.EmployeeName;
        RepairsObj.Correspondence.MessageTo     := RepairsOBJ.client.ClientName;
        RepairsObj.Correspondence.PostDB;
        if qryDocuments.active then qryDocuments.close; qryDocuments.open;
      finally
        fbTemplateUsesNonFormConnection:= True;
      end;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfmPadRepairs.btnEmailClick(Sender: TObject);
begin
  inherited;
  EmailServicePad;
end;

procedure TfmPadRepairs.AdvSmoothButton3Click(Sender: TObject);
begin
  inherited;
  RepairsOBJ.RepairAttachments.Connection.BeginNestedTransaction;
  Try
    RepairsOBJ.RepairAttachments.new;
    if TfmPicture.TakePicture('Repair - On site Photo', QryAttachments,'Attachment', 'AttachmentName') then
      RepairsOBJ.RepairAttachments.Connection.CommitNestedTransaction
    else RepairsOBJ.RepairAttachments.Connection.RollbackNestedTransaction;
  Except
    on E:Exception do begin
      RepairsOBJ.RepairAttachments.Connection.RollbackNestedTransaction;
    end;
  End;
end;

procedure TfmPadRepairs.btnAddDateClick(Sender: TObject);
begin
  inherited;
  //txtFeedback.text:= AddDateTime(lcdOnLoganyway,txtFeedback.text, true);
  AddDateTime(lcdOnLoganyway,txtFeedback, true);
end;
procedure TfmPadRepairs.txtFeedbackExit(Sender: TObject);
begin
  inherited;
  //txtFeedback.text:= AddDateTime(lcdOnServicePadFeedback,txtFeedback.text, true);
  AddDateTime(lcdOnServicePadFeedback,txtFeedback, true);
end;

procedure TfmPadRepairs.ApplyFormAccess;
var
  x: integer;
begin
  for x:= 0 to ComponentCount -1 do begin
    if Components[x] = cboCustomer then begin
      cboCustomer.Readonly:= not(RepairsOBJ.IsNew and (AccessLevel < 4));
    end else if (Components[x] = segMain) or
            (Components[x] = tpMain) or
            (Components[x] = tpEquip) or
            (Components[x] = tpDetails) or
            (Components[x] = tabHeader) or
            (Components[x] = btnCancel) or
            (Components[x] = lblCustomer) then begin
      Continue;
    end else if Components[x] = btnCustomise then begin
      btnCustomise.enabled :=self.tpMain.ActivePage = tpDetails ;
    end else if Components[x] = btnHome then begin
      btnHome.enabled :=self.tpMain.ActivePage = tpDetails ;
    end else begin
      if Components[x] is TControl then begin
        TControl(Components[x]).Enabled:=
          ((RepairsOBJ.ClientID > 0) ) and
          ((AccessLevel < 3) or (RepairsOBJ.IsNew and (AccessLevel = 3)));
      end;
    end;
    if (Components[x] = dtServicedate) or (Components[x] = txtStartTime) or (Components[x] = txtEndtime) then begin
        if TControl(Components[x]).Enabled then
          TControl(Components[x]).enabled :=btnGo.Down=False;
    end;
  end;
end;

procedure TfmPadRepairs.btnAttachClick(Sender: TObject);
begin
  inherited;
  ShowAttachments(False);
end;

procedure TfmPadRepairs.btnDeletePartsClick(Sender: TObject);
begin
  inherited;
  RepairsOBJ.RepairEquipmentFault.Deleted := True;
  RepairsOBJ.RepairEquipmentFault.PostDb;
end;

procedure TfmPadRepairs.btnGoClick(Sender: TObject);
begin
  inherited;
  if btnGo.Down  then begin
    RepairsOBJ.TimeSheetentry.timeSheet.Servicedate := Date;
    RepairsOBJ.TimeSheetentry.timeSheet.timesheetdate:= Date;
    combotime(TxtstartTime,now, false);
    txtEndtime.Text     :=  '';
    btnGo.Caption := 'Stop';
    edttime.Visible := true;
    edttime.Text := '00:00:00';
    tmStarted := now;
    tmrGo.Enabled:= TRue;
    RepairsOBJ.TimeSheetentry.timeSheet.Quantity := 0;
    edtHours.text := '';
  end else begin
    combotime(txtEndtime,now, true);
    dttimefromChange(nil);
    btnGo.Caption := 'Start';
    edttime.Visible:= False;
    tmrGo.Enabled := False;
  end;
  ApplyFormAccess;
end;



procedure TfmPadRepairs.btnPreviewClick(Sender: TObject);
begin
  inherited;
  PrintReport;
end;

procedure TfmPadRepairs.cboCustomerExit(Sender: TObject);
begin
  inherited;
  ApplyFormAccess;
end;




procedure TfmPadRepairs.cboRepairFaultDblClick(Sender: TObject);
begin
  inherited;
  TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_RepairFault, RepairsObj.RepairEquipmentFault.RepairFault);

end;

procedure TfmPadRepairs.cboRepairFaultNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtconfirmation, [mbyes, mbno], 0) = mrYes then begin
    TfmSimpleTypes.DoSimpleTypesAddNew(SimpleTypes_RepairFault, NewValue);
    closenopendb(cboRepairFault.LookupTable);
    if cboRepairFault.LookupTable.Locate('Name', NewValue, []) then begin
           RepairsObj.RepairEquipmentFault.RepairFault :=NewValue;
           RepairsObj.RepairEquipmentFault.PostDB;
           Accept:= True;
    end else begin
      Accept:= False;
    end;
  end;
end;

procedure TfmPadRepairs.cboStatusCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if RepairsObj.status = 'Emailed' then
    if MessageDlgXP_Vista('Do you like to email This record?', mtConfirmation, [mbYes, mbNo], 0) = mryes then
      EmailServicePad;
end;

procedure TfmPadRepairs.cboStatusDblClick(Sender: TObject);
begin
  inherited;
  TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_StatusType);
end;

procedure TfmPadRepairs.cboStatusNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
// inherited;
  Accept := False;
  if CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    if TfmSimpleTypes.DoSimpleTypesAddNew(SimpleTypes_StatusType,NewValue) then begin
      Accept:= true;
      LookupTable.Refresh;
    end;
  end;
end;

procedure TfmPadRepairs.txtFeedbackEnter(Sender: TObject);
begin
  inherited;
  if accesslevel = 1 then begin
    RepairsObj.EditDB;
    with txtFeedback do
      if FeedbackchangeUsernDtTime <> '' then
        if pos(' : ' +FeedbackchangeUsernDtTime,Lines.Strings[Lines.Count - 1])<> 0 then
          Lines.Strings[Lines.Count - 1] := replaceStr(Lines.Strings[Lines.Count - 1], ' : ' +FeedbackchangeUsernDtTime , '')
        else if pos(FeedbackchangeUsernDtTime,Lines.Strings[Lines.Count - 1])<> 0 then
          Lines.Strings[Lines.Count - 1] := replaceStr(Lines.Strings[Lines.Count - 1], FeedbackchangeUsernDtTime , '');
  end;
end;


procedure TfmPadRepairs.DoBusinessObjectEvent(const Sender: TDatasetBusObj;  const EventType, Value: string);
begin
  inherited ;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
         if Sender  is TRepairs           then TRepairs(Sender).DataSet         := QryRepairs
    else if Sender  is TRepairPArts       then TRepairParts(Sender).DataSet     := qryRepairparts
    else if sender  is TOtherFollowups    then TOtherFollowups(sender).Dataset  := tbOtherFollowUp
    else if sender  is TRepairEquipmentFault     then TOtherFollowups(sender).Dataset  := tblrepairsFaults
    else if sender  is TClient            then TClient(Sender).Dataset          := qryClient
    else if Sender  is TTimesheetEntry    then TTimesheetEntry(Sender).DataSet  := qryTimeSheetEntry
    else if Sender  is TTimesheet         then TTimesheet(Sender).DataSet       := qryTimesheets
    else if Sender  is TAttachment        then TAttachment(Sender).DataSet      := QryAttachments
    else if Sender  is TShippingAddress   then TShippingAddress(Sender).DataSet := QryShippingAddress;
  end else if (Eventtype = BusObjEvent_Dataset) and (Sender.IsdataIdchangeEvent(Value)) then begin
    if Sender  is TTimesheet then
      fSignature.REfreshdb;
  end;
end;

procedure TfmPadRepairs.DoOnArrayButtonClick(Button: TAdvSmoothButton;
  FunctionType, FunctionValue: string);
begin
  if FunctionType = 'Product' then begin
    RepairsOBJ.RepairParts.New;
    RepairsOBJ.RepairParts.customerEquipmentId  := QryRepairEquipcustomerequipID.asInteger;
    RepairsOBJ.RepairParts.ProductName          := FunctionValue;
    RepairsOBJ.RepairParts.UOMQty               := 1;
    RepairsOBJ.RepairParts.PostDB;
  end else begin
    inherited;
  end;
end;

procedure TfmPadRepairs.LocateThisLabourRec(Sender: TObject);
begin
  inherited;
  if not RepairsOBJ.TimesheetEntry.Timesheet.locate(RepairsOBJ.TimesheetEntry.Timesheet.IDFieldName, timeSheetID , []) then
      MakeTimeSheet;
end;

procedure TfmPadRepairs.dttimefromChange(Sender: TObject);
begin
  inherited;
  try
    RepairsOBJ.TimesheetEntry.Timesheet.Quantity :=
      round(HourSpan(DateOf(RepairsOBJ.TimesheetEntry.Timesheet.TimeSheetDate) + ValidStrToTime(TxtstartTime.Text) ,
                    DateOf(RepairsOBJ.TimesheetEntry.Timesheet.TimeSheetDate) + ValidStrToTime(txtEndtime.text)),2);
  Except
    // kill the exception if any of the time is blank
  end;
  RepairsOBJ.TimesheetEntry.Timesheet.PostDB;
end;

procedure TfmPadRepairs.FormActivate(Sender: TObject);
begin
  inherited;
  (*if (DtHeight > self.height ) or (DTWidth > Self.Width) then *)WindowState := wsMaximized;
end;
procedure TfmPadRepairs.ShowAttachments(fbDragnDropping :Boolean);
Var
  frm : TComponent;
begin
  if RepairsObj.ID < 1 then Exit;
  Frm := GetComponentByClassName('TfmAttachments',True,Self,True,True,RepairsObj.ID);
  if Assigned(frm) then begin
    with TfmAttachments(frm) do begin
      DBConnection := TERPConnection (RepairsObj.Connection.Connection);
      AttachObserver(Self);
      TableName := Repairsobj.BusObjectTableName;
      TableId := RepairsObj.ID;
      Tag :=RepairsObj.ID;
      DragnDropping :=fbDragnDropping;
      ShowModal;
    end;
  end;
end;

procedure TfmPadRepairs.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  CanClose:= true;
  if (RepairsOBJ.ID > 0) then begin
    if RepairsOBJ.Dirty  then begin
      case MessageDlgXP_Vista('Do you wish to keep the changes you have made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
        mrYes:
          begin
            if not SaveRepair then Exit;
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

procedure TfmPadRepairs.FormCreate(Sender: TObject);
var
  SavedColor: TColor;
begin
  btnAddDate.Visible :=   not(UserPreferenceOn(lcdOnServicePadFeedback));
  FeedbackchangeUsernDtTime := '';
  fSignature := nil;
  DtHeight := self.height;
  DTWidth := Self.Width;
  SavedColor:= self.Color;
  inherited;
  self.Color:= SavedColor;
  KeypadConfig:= TJsonObject.Create;
  ButtonArray.OnButtonClick:= DoOnArrayButtonClick;
  RepairsOBJ := TRepairs.Create(Self);
  RepairsOBJ.Connection := TMyDacDataConnection.Create(RepairsOBJ);
  RepairsOBJ.Connection.Connection := MyConnection;
  RepairsOBJ.BusObjEvent := DoBusinessObjectEvent;
  tpMain.ActivePage:= tabHeader;

  keyNumeric.Parent:= ButtonArray;
  keyNumeric.Align:= alClient;

  fSignature := TfmDraw.DoDraw(Self, pnlsignature , ''  );
end;

procedure TfmPadRepairs.FormDestroy(Sender: TObject);
begin
  Freeandnil(fSignature);
  inherited;
  KeypadConfig.Free;
end;

procedure TfmPadRepairs.FormResize(Sender: TObject);
begin
  inherited;
  tpMain.TabSettings.Width:=
    Trunc(Trunc(tpMain.ClientWidth - ((tpMain.TabSettings.LeftMargin + tpMain.TabSettings.RightMargin) * 5 + tpMain.TabSettings.Spacing)) / 5);
end;

procedure TfmPadRepairs.FormShow(Sender: TObject);
begin
  //WindowState := wsMaximized;
  try
    PopulateTimecombo(txtStartTime);
    PopulateTimecombo(txtEndTime);

    inherited;
    ButtonArray.SelectedKeypadName:= 'Home';
    BeginTransaction;
    if KeyID <> 0 then begin
      RepairsOBJ.Load(KeyID);
      RepairsOBJ.RepairParts;
      if RepairsOBJ.RepairParts.accessmanager.accesslevel = 3 then
        RepairsOBJ.RepairParts.accessmanager.accesslevel:= 5;
      RepairsOBJ.Customer;

      if not RepairsOBJ.userlock.Lock(RepairsOBJ.BusobjectTableName , RepairsOBJ.ID, RepairsOBJ.LockGroupName) then begin
        AccessLevel := 5;
        CommonLib.MessageDlgXP_Vista(RepairsOBJ.UserLock.LockMessage + #13 + #10 + #13 + #10 +
              ' Repairs : access will be changed to read-only.', mtWarning, [mbOK], 0);

      end;
      IF RepairsOBJ.Converted then begin
         Self.Caption := Self.Caption +' {Invoice already created!}';
      end;
    end else begin
      RepairsOBJ.Load(KeyID);
      RepairsOBJ.New;
      RepairsOBJ.RepairParts;
      if RepairsOBJ.RepairParts.accessmanager.accesslevel = 3 then
          RepairsOBJ.Repairparts.accessmanager.accesslevel:= 2;
    end;

    MakeTimeSheet;
    RepairsOBJ.OtherFollowup;
    RepairsOBJ.RepairEquipmentFault;
    RepairsOBJ.RepairAttachments;
    qryServices.ParamByName('xEmpID').AsInteger := Appenv.Employee.EmployeeID;
    qryContacts.ParamByName('ClientID').AsInteger :=RepairsOBJ.ClientID;
    Qrydocuments.ParamByName('RepairID').AsInteger :=RepairsOBJ.Id;
    openqueries;
    ApplyFormAccess;
    SetControlfocus(cboCustomer);
(*    if assigned(pnlsignature) then
      if pnlsignature.height > 250 then
        pnlsignature.height := 250;*)
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
    else raise;
  end;

end;

procedure TfmPadRepairs.grdOtherFollowUpExit(Sender: TObject);
begin
  inherited;
  Editdb(grdOtherFollowUp.DataSource.DataSet);
  PostDB(grdOtherFollowUp.DataSource.DataSet);
end;

procedure TfmPadRepairs.grdRepairPartsColEnter(Sender: TObject);
begin
  inherited;
  if grdRepairParts.Enabled and (grdRepairParts.SelectedField = qryRepairpartspriceinc) and
     (qryRepairpartspartname.AsString <> '') then begin
    keyNumeric.Visible:= true;
  end;

end;

procedure TfmPadRepairs.grdRepairPartsColExit(Sender: TObject);
begin
  inherited;
  keyNumeric.Visible:= false;
end;

procedure TfmPadRepairs.grdRepairPartsDblClick(Sender: TObject);
begin
  inherited;
  if grdRepairparts.Enabled and (grdRepairparts.SelectedField = qryRepairpartspriceinc) and
     (qryRepairpartsPriceinc.AsString <> '') then begin
    keyNumeric.Visible:= true;
  end;
end;

procedure TfmPadRepairs.grdRepairPartsIButtonClick(Sender: TObject);
var
  isFiltered: Boolean;
  fId: Integer;
begin
  inherited;
  if RepairsOBJ.Repairparts.Count > 0 then begin
    isFiltered:= RepairsOBJ.Repairparts.dataset.filtered;
    try
      fId:= RepairsOBJ.Repairparts.ID;
      RepairsOBJ.Repairparts.Dataset.filtered := False;
      RepairsOBJ.Repairparts.Dataset.Locate(RepairsOBJ.Repairparts.IDFieldName, fId, []);
      RepairsOBJ.Repairparts.DoFieldChangewhenDisabled := TRue;
      try
        RepairsOBJ.Repairparts.Deleted:= true;
        RepairsOBJ.Repairparts.PostDB;
      finally
        RepairsOBJ.Repairparts.DoFieldChangewhenDisabled := False;
      end;
      if RepairsOBJ.Repairparts.Count > 0 then RepairsOBJ.Repairparts.PostDB;
    finally
      RepairsOBJ.Repairparts.Dataset.filtered := isFiltered;
    end;
    RepairsOBJ.CalcPartsTotal;
  end;
end;

procedure TfmPadRepairs.grdTimesheetCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if RepairsOBJ.TimesheetEntry.TimeSheet.ID =timeSheetID then
    ABrush.Color :=$00BBFFFF
  else Afont.Color :=   clInactiveCaption;
  if RepairsOBJ.TimesheetEntry.TimeSheet.ID =timeSheetID then
      Afont.Color :=   clblack;
end;

procedure TfmPadRepairs.grdTimesheetRowChanged(Sender: TObject);
begin
  inherited;
  ApplyFormAccess;
  lblMsg.Visible:= False;
end;

procedure TfmPadRepairs.ibtimesheetClick(Sender: TObject);
begin
  inherited;
  if RepairsOBJ.TimesheetEntry.TimeSheet.Count > 0 then begin
    if (RepairsOBJ.TimesheetEntry.TimeSheet.ID <> timeSheetID) then
      if  (RepairsOBJ.TimesheetEntry.TimeSheet.EmployeeID = Appenv.Employee.EmployeeID) then begin
          RepairsOBJ.TimesheetEntry.TimeSheet.Delete;
          ApplyFormAccess;
      end else begin
        TimerMsg(lblMsg , ' You can only delete your labour records');
      end;
  end;
end;

procedure TfmPadRepairs.keyNumericKeyClick(Sender: TObject; Index: Integer);
begin
  inherited;
  if Index = 14 then
    keyNumeric.Visible:= false;
end;

procedure TfmPadRepairs.LetterBtnClick(Sender: TObject);
begin
  inherited;
    if Accesslevel >= 5 then Exit;
    repairsObj.PostDb;
    RepairCreateCorrespondence(ctLetter, self, repairsObj.Customer.FirstName);
    if qryDocuments.active then qryDocuments.close; qryDocuments.open;
end;

procedure TfmPadRepairs.LoadKeypadConfig;
var
  Pref: TPreference;
begin
  KeypadConfig.Clear;
  if RepairsOBJ.DeptClassName = '' then
    exit;
  Pref:= TPreference.Create(nil);
  try
    Pref.Connection:= TMyDacDataConnection.Create(Pref);
    Pref.Connection.Connection:= MyConnection;
    Pref.Load(0,'KeypadConfig',KeyPadName,RepairsOBJ.DeptClassName);
    KeypadConfig.AsString:= Pref.PrefValue;
    ButtonArray.Config:= KeypadConfig;
  finally
    Pref.Free;
  end;
end;

procedure TfmPadRepairs.QryRepairEquipCalcFields(DataSet: TDataSet);
begin
  inherited;
  QryRepairEquipWarrantyPeriodUsed.AsFloat :=  QryRepairEquipWarantyPeriod.AsFloat -    QryRepairEquipWarantyPeriodLeft.AsFloat;
end;

procedure TfmPadRepairs.QryrepairsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  closedb(QryRepairEquip);
  QryRepairEquip.ParamByName('ID').AsInteger := RepairsOBJ.ID;
  openDb(QryRepairEquip);

  closedb(QryClientcontact);
  QryClientcontact.ParamByName('clientID').AsInteger := RepairsOBJ.ClientID;
  QryClientcontact.ParamByName('contactID').AsInteger := RepairsOBJ.ContactID;
  openDb(QryClientcontact);

  btntoggle.Visible :=  RepairsOBJ.ContactID <> 0;

       if RepairsOBJ.Done       then  optRepairStatus.ItemIndex := 2
  else if RepairsOBJ.HoldRepair then  optRepairStatus.ItemIndex := 1
  else optRepairStatus.ItemIndex := 0;

end;
procedure TfmPadRepairs.qryTimesheetsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  showSignature;
  //qryTimesheetsSignatureTime.DisplayFormat := LongTimeFormat;
end;

procedure TfmPadRepairs.qryTimesheetsCalcFields(DataSet: TDataSet);
begin
  inherited;
  if qryTimesheetssignature.Value = Null then qryTimesheetsSignatureMemo.AsString := '' else qryTimesheetsSignatureMemo.AsString := '[• • •]';
end;

procedure TfmPadRepairs.qryTimesheetsQtyChange(Sender: TField);
begin
  inherited;
  RepairsOBJ.TimesheetEntry.Timesheet.Hours := Sender.AsFloat;
end;

procedure TfmPadRepairs.showSignature;
begin
  fSignature.dataset      := qryTimesheets;
  fSignature.fieldname    := 'Signature';
  fSignature.Drawtimefield:= 'Signaturetime';
  fSignature.onDrew       := Onsigned;
  fSignature.REfreshdb;
end;
procedure TfmPadRepairs.OnSigned(Sender: TObject);
begin
  if fSignature.dirty then begin
    fSignature.PostDb;
    editDB(qryTimesheets);
    qryTimesheetsSignatureTime.AsDateTime := now;
    PostDB(qryTimesheets);
  end;
end;

procedure TfmPadRepairs.optRepairStatusClick(Sender: TObject);
begin
  inherited;
  if not(Screen.ActiveControl = optRepairStatus) and not(screen.activeControl.owner = optRepairStatus) then exit;
  RepairsOBJ.Done       := optRepairStatus.ItemIndex = 2;
  RepairsOBJ.HoldRepair := optRepairStatus.ItemIndex = 1;
  RepairsOBJ.PostDB;
end;

procedure TfmPadRepairs.pnlsignatureExit(Sender: TObject);
begin
  inherited;
  fSignature.Postdb;
end;

procedure TfmPadRepairs.PrintReport;
var
  fPrintDoc :TBusObjPrintDoc;
begin
  DisableForm;
  try
    if SaveRepair then begin
      //RepairsOBJ.Connection.CommitTransaction;
      RepairsOBJ.Dirty := False;
      ReportToPrint := GetDefaultReport(TemplateTypeID('Service Pad'));
      if ReportToPrint = '' then ReportToPrint:= 'Service Pad';

      fbTemplateUsesNonFormConnection:= False;
      try
        PrintTemplateReport(ReporttoPrint, RepairsReportSQL(RepairsObj.ID, timeSheetID)  , not(Appenv.Employee.ShowPreview) , 1);
      finally
        fbTemplateUsesNonFormConnection:= True;
      end;

      fPrintDoc := TBusObjPrintDoc.Create(nil);
      try
        if not Appenv.Employee.ShowPreview then
          fPrintDoc.PrintDoc(RepairsOBJ.ClassName,RepairsOBJ.ID,dtMain,Self.Classname ,dotPrint , ReportToPrint)
        else
          fPrintDoc.PrintDoc(RepairsOBJ.ClassName,RepairsOBJ.ID,dtMain,Self.Classname ,dotPreview , ReportToPrint);
      finally
        fPrintDoc.Free;
      end;

    end
  finally
    EnableForm;
  end;


(* DisableForm;
  try
    if SaveRepair then begin
      //RepairsOBJ.Connection.CommitTransaction;
      RepairsOBJ.Dirty := False;
      ReportToPrint := GetDefaultReport(TemplateTypeID('Service Pad'));
      if ReportToPrint = '' then ReportToPrint:= 'Service Pad';
      fbTemplateUsesNonFormConnection:= False;
      try
        PrintTemplateReport(ReporttoPrint, RepairsReportSQL(RepairsObj.ID, timeSheetID)  , not(Appenv.Employee.ShowPreview) , 1);
      finally
        fbTemplateUsesNonFormConnection:= True;
      end;
    end;
  finally
    EnableForm;
  end;*)

end;

procedure TfmPadRepairs.btntoggleClick(Sender: TObject);
begin
  inherited;
  if SameText(btntoggle.caption , 'Show Customer Details') then begin
    edtStreet1.DataSource   := dsClient;
    edtStreet2.DataSource   := dsClient;
    edtStreet3.DataSource   := dsClient;
    edtcity.DataSource      := dsClient;
    edtPhone.DataSource     := dsClient;
    edtState.DataSource     := dsClient;
    edtMobile.DataSource    := dsClient;
    edtPostCode.DataSource  := dsClient;
    edtEmail.DataSource     := dsClient;
    btntoggle.caption       := 'Show Contact Details'
  end else begin
    edtStreet1.DataSource   := dsClientcontact;
    edtStreet2.DataSource   := dsClientcontact;
    edtStreet3.DataSource   := dsClientcontact;
    edtcity.DataSource      := dsClientcontact;
    edtPhone.DataSource     := dsClientcontact;
    edtState.DataSource     := dsClientcontact;
    edtMobile.DataSource    := dsClientcontact;
    edtPostCode.DataSource  := dsClientcontact;
    edtEmail.DataSource     := dsClientcontact;
    btntoggle.caption       := 'Show Customer Details';
  end;

end;

function TfmPadRepairs.SaveRepair: boolean;
begin
  Result:= False;
  if btnGo.Down  then begin
    if MessageDlgXP_Vista('You have started the timer. Woud you like to Stop the timer, Save the time and continue saving?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
    btnGo.click;
  end;
  RepairsOBJ.PostDB;
  RepairsOBJ.RepairParts.PostDb;
  RepairsOBJ.TimesheetEntry.PostDb;
  try
    RepairsOBJ.TimesheetEntry.Timesheet.Quantity := round(HourSpan(DateOf(RepairsOBJ.TimesheetEntry.Timesheet.TimeSheetDate) + ValidStrToTime(TxtstartTime.Text) ,
                                                          DateOf(RepairsOBJ.TimesheetEntry.Timesheet.TimeSheetDate) + ValidStrToTime(txtEndtime.text)),2);
    if fSignature.Dirty then fSignature.PostDB;
  Except
    // kill the exception if any of the time is blank
  end;
  RepairsOBJ.TimesheetEntry.Timesheet.PostDB;
  RepairsOBJ.RepairEquipmentFault.PostDb;
  result:= RepairsOBJ.Save;
end;

procedure TfmPadRepairs.tblrepairsFaultsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  REpairsObj.RepairEquipmentFault.TimeSheetID := timeSheetID;
  REpairsObj.RepairEquipmentFault.CustomerEquipmentID     := QryRepairEquipcustomerequipID.asInteger;
  REpairsObj.RepairEquipmentFault.Equipment               := QryRepairEquipequipname.asString;
end;

procedure TfmPadRepairs.tblrepairsFaultsBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  tblrepairsFaults.Filter := 'Deleted = ''F'' and CustomerEquipmentID = ' + inttostr(QryRepairEquipcustomerequipID.asInteger);
end;

procedure TfmPadRepairs.tmrGoTimer(Sender: TObject);
begin
  inherited;
    seconds  :=SecondsBetween(tmStarted, now);
    edttime.Text := SecondsToTime(seconds );
end;

procedure TfmPadRepairs.tpMainChange(Sender: TObject);
begin
  inherited;
  if self.tpMain.ActivePage = tpDetails then begin
    LoadKeypadConfig;
    ButtonArray.SelectedKeypadName:= 'Home';
  end;
  btnCustomise.enabled :=self.tpMain.ActivePage = tpDetails ;
  btnHome.enabled :=self.tpMain.ActivePage = tpDetails ;
end;

procedure TfmPadRepairs.tpMainChanging(Sender: TObject; FromPage, ToPage: Integer;
  var AllowChange: Boolean);
begin
  inherited;
  { validate customer before allowing change }
  if ToPage = 1 then begin
    AllowChange:= false;
    if (RepairsOBJ.clientID = 0) then begin
      MessageDlgXP_Vista('Please select a Customer first.', mtInformation, [mbOk], 0);
      SetControlFocus(cboCustomer);
      exit;
    end;
    AllowChange:= true;
  end;
end;

procedure TfmPadRepairs.wwDBLookupCombo1NotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  Accept := True;
end;

procedure TfmPadRepairs.edtEmailClick(Sender: TObject);
begin
  inherited;
  if edtEmail.Text = '' then exit;

  DisableForm;
  try
    RepairCreateCorrespondence(ctEmail,self, repairsObj.Customer.FirstName);
  finally
    EnableForm;
  end;

end;

procedure TfmPadRepairs.edtEquipDblClick(Sender: TObject);
begin
  inherited;
  if edtEquip.Text <> '' then tpMain.ActivePageIndex:= 1;
end;

initialization
  RegisterClass(TfmPadRepairs);

end.
