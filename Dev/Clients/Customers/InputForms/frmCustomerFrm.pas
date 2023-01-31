unit frmCustomerFrm;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 19/04/05  1.00.01 IJB  Fixed can't focus disabled control bug on Save.
 22/04/05  1.00.02 IJB  Added foreign currency to Accounts tab.
 05/05/05  1.00.03 BJ   Implemented the amsk edit for BSB
 20/05/05  1.00.03 ISB  Added Related Customer Check B4 Delete
 01/06/05  1.00.04 BJ  beforepost of the customer table intialises cutomertype
                       to 0 when it is null. It gets null value once if the
                       selected type is removed from the combo. the field does
                       not support null value, but 0 is acceptable.
 03/06/05  1.00.04 BJ  Validation done for the unique company name in the
                      following procs before the 'qryCustomers.post'
                          --> TabCtl20Changing
                          --> Savebuttonclick
                          --> Newbuttonclick
 23/06/05  1.00.05 DSP Added component 'txtCardHolderName' for use with the
                       NAB CardFast payment method
 04/07/05  1.00.06 IJB Enabled UserLock object in form create to stop more than
                       one user editing the same Customer at one time.
 04/07/05  1.00.07 BJ  Bug fixed: A required customer cannot be made 'Inactive'
 06/07/05  1.00.08 DMS 1. Formatted unit's source code.
                       2. Modified the way the attachments are open.
 26/07/05  1.00.09 DSP Added '.doc' prior to ShellExecute call when opening
                       Word documents. Also added ExcludeTrailingPathDelimiter
                       function call to strip off trailing back-slashes from
                       the file path. Added FileExists test and a message
                       dialog when the file does not exist.
 03/08/05  1.00.10 DSP When entering a customer name not in the list on the
                       frmAppointments form and a new customer is created; the
                       new customer name was not returned to the customer
                       combobox. A Notify call has been added to the Save and
                       Cancel operations.
 05/08/05  1.00.11 DSP The KeyID value is now passed across to frmPriceListGUI.
 26/08/05  1.00.12 BJ  SetContractDefaults sets the defualt values for the new
                       contract record
 30/08/05  1.00.13 DSP Removed the FreeAndNil calls for each history list form
                       from the FormDestroy method as they are freed by their
                       owner (this form).
 14/09/05  1.00.14 IJB Added code to hide the RelatedCustomersList button on
                       Customer List form.
 31/10/05  1.00.15 MV  Added new field Default Delivery Template to customer
                       general tab and tblclients.
 04/11/05  1.00.16 MV  Added Account Receivable Noyes to History Tab.
 09/11/05  1.00.17 MV  Added Discount Price List control button.
 19/12/05  1.00.18 AL  Removed "Instance"  *Task306*
 23/12/05  1.00.19 AL  Added button next to phone number
 04/01/06  1.00.20 BJ  Field added for the outstanding hours
                       reference to the form variable - frmcontact- is removed
                       the form object is created by 'Findlass' which will not create the form
                       variable.
 11/01/06  1.00.21 IJB Modified to fix bug of form hiding hehind others when
                       trying to create a new customer from POS. Also reduced
                       the number of calls to RealignTabControl by adding
                       "FormInitialising" flag.
 12/01/06  1.00.22 IJB Fixd Not-In-List for Source and Customer Type.
 02/02/06  1.00.23 DSP 1. Adjusted some control positions.
                       2. Listed the items of grpHistory into alphabetical
                          order.


}

{$I ERP.inc}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, StdCtrls, Mask, DBCtrls, ExtCtrls, DBCGrids, ComCtrls,AdvOfficeStatusBar,
  BaseInputForm, Grids, jpeg, wwdblook, DNMPanel, Buttons, DNMSpeedButton,
  BaseListingForm, Word2000, OleServer, Variants, wwdbedit, wwdbdatetimepicker,
  Wwdbigrd, Wwdbgrid, DBGrids, wwriched, ActnList, wwcheckbox, kbmMemTable,
  Wwdotdot, Wwdbcomb, SelectionDialog, AppEvnts, wwMemo, MemDS, DBAccess,
  MyAccess,ERPdbComponents, {LbCipher, LbClass,} DateUtils, DNMLib,
  DataState, frmAttachments, frmContactFrm, Menus, AdvMenus, wwclearbuttongroup,
  wwradiogroup, Shader, ImgList, frmClientEquipment,
  uTPLb_BaseNonVisualComponent, uTPLb_Codec, WordXP, ERPDbLookupCombo,
  JsonObject, Busobjcustomfields, ProgressDialog, HTMLUn2, HtmlView, IdMessage,
  BusObjClient, FileAssociationDetails(*, CustomerContactListForm*) , BusObjBase , frmClient;

type
  TfrmCustomer = class(TfmClient)
    frmCustomerSrc: TDataSource;
    TabCtl20: TPageControl;
    Customer_Info: TTabSheet;
    Address_Info: TTabSheet;
    General: TTabSheet;
    History: TTabSheet;
    SpecialProds: TTabSheet;
    tabContacts: TTabSheet;
    Documents: TTabSheet;
    Custom_Fields: TTabSheet;
    cmdCustomLabels: TDNMSpeedButton;
    qryCustomers: TERPQuery;
    pnlMain: TDNMPanel;
    Box72: TBevel;
    Box70: TBevel;
    Box69: TBevel;
    lblCompany: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label31: TLabel;
    Label33: TLabel;
    Label178: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label59: TLabel;
    Company: TDBEdit;
    Title: TDBEdit;
    FirstName: TDBEdit;
    LastName: TDBEdit;
    Phone: TwwDBEdit;
    FaxNumber: TwwDBEdit;
    MOB: TwwDBEdit;
    AltPhone: TwwDBEdit;
    AltContact: TDBEdit;
    Notes: TDBMemo;
    pnlAddress: TDNMPanel;
    Box41: TBevel;
    Box83: TBevel;
    Label180: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label42: TLabel;
    Label78: TLabel;
    lblSuburb: TLabel;
    lblPostCode: TLabel;
    lblState: TLabel;
    Label182: TLabel;
    lblBillSuburb: TLabel;
    lblBillState: TLabel;
    lblBillPostcode: TLabel;
    Street: TDBEdit;
    Street2: TDBEdit;
    State: TDBEdit;
    Postcode: TDBEdit;
    cmdCopy: TDNMSpeedButton;
    BillStreet: TDBEdit;
    BillStreet2: TDBEdit;
    BillState: TDBEdit;
    BillPostcode: TDBEdit;
    DNMPanel3: TDNMPanel;
    Label128: TLabel;
    Label127: TLabel;
    Label163: TLabel;
    pnlCustFieldsTab: TDNMPanel;
    pnlHistory: TDNMPanel;
    pnlButtons: TDNMPanel;
    cmdOk: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    cmdShipping: TDNMSpeedButton;
    cmdNotes: TDNMSpeedButton;
    cmdPrint: TDNMSpeedButton;
    pnlHeader: TDNMPanel;
    txtCompany: TDBMemo;
    grpHistory: TRadioGroup;
    DNMPanel9: TDNMPanel;
    qryDocuments: TERPQuery;
    DSDocuments: TDataSource;
    qrySpecials: TERPQuery;
    DSSpecials: TDataSource;
    qryContacts: TERPQuery;
    DSContacts: TDataSource;
    DNMPanel5: TDNMPanel;
    Label98: TLabel;
    Label104: TLabel;
    pnlContacts: TDNMPanel;
    Bevel3: TBevel;
    pnlDocuments: TDNMPanel;
    tabAttachments: TTabSheet;
    dsOtherFollowUp: TDataSource;
    chkShowAll: TCheckBox;
    Label6: TLabel;
    grdSpecials: TwwDBGrid;
    cboProd: TERPDBLookupCombo;
    grdSpecialsIButton: TwwIButton;
    btnNewProd: TDNMSpeedButton;
    cmdNewContact: TDNMSpeedButton;
    EditBtn: TDNMSpeedButton;
    btnContactMessage: TDNMSpeedButton;
    Suburb: TwwDBLookupCombo;
    BillSuburb: TwwDBLookupCombo;
    qryCustomersPhone: TWideStringField;
    qryCustomersFaxNumber: TWideStringField;
    qryCustomersMobile: TWideStringField;
    qryCustomersAltPhone: TWideStringField;
    qryCustomersContact1Phone: TWideStringField;
    qryCustomersContact2Phone: TWideStringField;
    qryCustomersClientID: TAutoIncField;
    qryCustomersCompany: TWideStringField;
    qryCustomersABN: TWideStringField;
    qryCustomersFirstName: TWideStringField;
    qryCustomersMiddleName: TWideStringField;
    qryCustomersLastName: TWideStringField;
    qryCustomersPosition: TWideStringField;
    qryCustomersEmail: TWideStringField;
    qryCustomersAltContact: TWideStringField;
    qryCustomersContact1: TWideStringField;
    qryCustomersPhoneSupportTill: TDateField;
    qryCustomersContact2: TWideStringField;
    qryCustomersNotes: TWideMemoField;
    qryCustomersMedTypeID: TIntegerField;
    qryCustomersTYPE: TWideStringField;
    qryCustomersCreditLimit: TFloatField;
    qryCustomersBalance: TFloatField;
    qryCustomersTERMS: TWideStringField;
    qryCustomersTermsID: TIntegerField;
    qryCustomersShippingMethod: TWideStringField;
    qryCustomersShippingID: TIntegerField;
    qryCustomersDiscount: TFloatField;
    qryCustomersSpecialDiscount: TFloatField;
    qryCustomersJobName: TWideStringField;
    qryCustomersIsJob: TWideStringField;
    qryCustomersPayMethodID: TIntegerField;
    qryCustomersFeedback: TWideStringField;
    qryCustomersCustomer: TWideStringField;
    qryCustomersSupplier: TWideStringField;
    qryCustomersOtherContact: TWideStringField;
    qryCustomersOtherContactType: TIntegerField;
    qryCustomersRepID: TIntegerField;
    qryCustomersGlobal: TWideStringField;
    qryCustomersDone: TWideStringField;
    qryCustomersActive: TWideStringField;
    qryCustomersEditedFlag: TWideStringField;
    qryCustomersDontContact: TWideStringField;
    qryCustomersParentClientID: TIntegerField;
    cboMediaType: TwwDBLookupCombo;
    cboRep: TwwDBLookupCombo;
    Bevel7: TBevel;
    PhoneSupport: TwwDBDateTimePicker;
    edtSpecDisc: TEdit;
    edtDisc: TEdit;
    qryCustomersGracePeriod: TSmallintField;
    lblClientType: TLabel;
    cboClientType: TwwDBLookupCombo;
    qrySpecialsCustomerLinesID: TAutoIncField;
    qrySpecialsProductID: TIntegerField;
    qrySpecialsLinePrice: TFloatField;
    qrySpecialsOrigPrice: TFloatField;
    qrySpecialsName: TWideStringField;
    qrySpecialsDescription: TWideStringField;
    qryCustomersClientNo: TWideStringField;
    qryCustomersTAXID: TIntegerField;
    qryCustomersTitle: TWideStringField;
    qryCustomersClientTypeID: TIntegerField;
    Label10: TLabel;
    Country: TDBEdit;
    Label11: TLabel;
    BillCountry: TDBEdit;
    Label12: TLabel;
    qryCustomersURL: TWideStringField;
    ActionList1: TActionList;
    actGeneral: TAction;
    tabEquip: TTabSheet;
    memqryCustomers: TkbmMemTable;
    memtbOtherFollowUp: TkbmMemTable;
    memqrySpecials: TkbmMemTable;
    qrySpecialsEditedFlag: TWideStringField;
    memqryContacts22: TkbmMemTable;
    dsProdGroupDiscs: TDataSource;
    qryProdGroupDiscs: TERPQuery;
    qryProdGroupDiscsClientID: TIntegerField;
    qryProdGroupDiscsCol1: TWideStringField;
    qryProdGroupDiscsCol2: TWideStringField;
    qryProdGroupDiscsCol3: TWideStringField;
    qryProdGroupDiscsDiscount: TFloatField;
    qryCustomersStopCredit: TWideStringField;
    qryCustomersRequired: TWideStringField;
    Label15: TLabel;
    qryCustomersForcePOOnBooking: TWideStringField;
    qryCustomersForcePOOnInvoice: TWideStringField;
    cboPickingPriority: TwwDBComboBox;
    Label19: TLabel;
    qryCustomersPickingPriority: TIntegerField;
    qryCustomersDefaultInvoiceTemplateID: TIntegerField;
    qryCustomersRepName: TWideStringField;
    qryCustomersCardNumber: TWideStringField;
    qryCustomersGroupDiscountOverridesAll: TWideStringField;
    cboClassName: TwwDBLookupCombo;
    lblDefaultClass: TLabel;
    Bevel17: TBevel;
    qryCustomersDefaultClass: TWideStringField;
    qryCustomersState: TWideStringField;
    qryCustomersStreet: TWideStringField;
    qryCustomersStreet2: TWideStringField;
    qryCustomersSuburb: TWideStringField;
    qryCustomersCountry: TWideStringField;
    qryCustomersPostcode: TWideStringField;
    qryCustomersBillStreet: TWideStringField;
    qryCustomersBillStreet2: TWideStringField;
    qryCustomersBillSuburb: TWideStringField;
    qryCustomersBillState: TWideStringField;
    qryCustomersBillCountry: TWideStringField;
    qryCustomersBillPostcode: TWideStringField;
    qryCustomersPOBox: TWideStringField;
    qryCustomersPOSuburb: TWideStringField;
    qryCustomersPOState: TWideStringField;
    qryCustomersPOCountry: TWideStringField;
    qryCustomersPOPostcode: TWideStringField;
    qryCustomersCUSTFLD1: TWideStringField;
    qryCustomersCUSTFLD2: TWideStringField;
    qryCustomersCUSTFLD3: TWideStringField;
    qryCustomersCUSTFLD4: TWideStringField;
    qryCustomersCUSTFLD5: TWideStringField;
    qryCustomersCUSTFLD6: TWideStringField;
    qryCustomersCUSTFLD7: TWideStringField;
    qryCustomersCUSTFLD8: TWideStringField;
    qryCustomersCUSTFLD9: TWideStringField;
    qryCustomersCUSTFLD10: TWideStringField;
    qryCustomersCUSTFLD11: TWideStringField;
    qryCustomersCUSTFLD12: TWideStringField;
    qryCustomersCUSTFLD13: TWideStringField;
    qryCustomersCUSTFLD14: TWideStringField;
    qryCustomersCUSTFLD15: TWideStringField;
    tabAccounts: TTabSheet;
    DNMPanel13: TDNMPanel;
    Label13: TLabel;
    ChkStopCredit: TwwCheckBox;
    wwDBDateTimePicker1: TwwDBDateTimePicker;
    qryCustomersCreationDate: TDateField;
    qryCustomersDischargeDate: TDateField;
    Bevel8: TBevel;
    Label26: TLabel;
    wwDBDateTimePicker2: TwwDBDateTimePicker;
    Label30: TLabel;
    qryCustomersArea: TWideStringField;
    lblArea: TLabel;
    tabReferrals: TTabSheet;
    dsReferrals: TDataSource;
    qryReferrals: TERPQuery;
    qryReferralsReferralID: TAutoIncField;
    qryReferralsClientID: TIntegerField;
    qryReferralsReferredClientID: TIntegerField;
    qryReferralsEditedFlag: TWideStringField;
    qryReferralsCompanyLookup: TWideStringField;
    qryReferralsPhoneLookup: TWideStringField;
    qryReferralsFaxLookup: TWideStringField;
    actReferralsPrint: TAction;
    Label48: TLabel;
    JobTitle: TDBEdit;
    qryCustomersJobTitle: TWideStringField;
    qryCustomersInvBaseNumber: TIntegerField;
    qryCustomersUseInvBase: TWideStringField;
    tbOtherFollowUp: TERPQuery;
    tbOtherFollowUpFollowUpDate: TDateTimeField;
    tbOtherFollowUpEmployeeName: TWideStringField;
    tbOtherFollowUpDone: TWideStringField;
    tbOtherFollowUpEmployeeID: TIntegerField;
    tbOtherFollowUpFollowUpID: TAutoIncField;
    tbOtherFollowUpOtherContactID: TIntegerField;
    tbOtherFollowUpRepairID: TIntegerField;
    tbOtherFollowUpEditedFlag: TWideStringField;
    tbOtherFollowUpAppearDays: TIntegerField;
    tbOtherFollowUpCreationDate: TDateTimeField;
    tbOtherFollowUpClientID: TIntegerField;
    tbOtherFollowUpIsSupplier: TWideStringField;
    tbOtherFollowUpIsOtherContact: TWideStringField;
    tbOtherFollowUpIsCustomer: TWideStringField;
    tbOtherFollowUpGlobalRef: TWideStringField;
    tbOtherFollowUpUpdateDate: TDateField;
    EquipNotesDialog1: TwwMemoDialog;
    btnAddDateTime: TDNMSpeedButton;
    qryProductGroupcol3: TERPQuery;
    qryDocPath: TERPQuery;
    qryClientTypes: TERPQuery;
    qryProductGroupcol2: TERPQuery;
    qryProductGroupcol1: TERPQuery;
    qryTaxCodes: TERPQuery;
    qryClients: TERPQuery;
    qryEmployees: TERPQuery;
    qryPayMethod: TERPQuery;
    qryMediaType: TERPQuery;
    qryTerms: TERPQuery;
    qryInvoiceTemplates: TERPQuery;
    qrySuburb: TERPQuery;
    cboProductQry: TERPQuery;
    qryShipping: TERPQuery;
    cboClassQry: TERPQuery;
    qryCustomFields: TERPQuery;
    cboClassQryClassID: TIntegerField;
    cboClassQryClassName: TWideStringField;
    btnInvoice: TDNMSpeedButton;
    btnSalesOrder: TDNMSpeedButton;
    btnQuote: TDNMSpeedButton;
    Label51: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    grdRelatedClient: TwwDBGrid;
    wwIButton1: TwwIButton;
    qryRelatedClients: TERPQuery;
    DSRelatedClients: TDataSource;
    cboClientLookup: TERPQuery;
    Bevel23: TBevel;
    lblRelatedCust: TLabel;
    qryRelatedClientsRelatedClientID: TAutoIncField;
    qryRelatedClientsMasterClientID: TIntegerField;
    qryRelatedClientsMasterCompany: TWideStringField;
    qryRelatedClientsChildClientID: TIntegerField;
    qryRelatedClientsChildCompany: TWideStringField;
    lblChildmessage: TLabel;
    qryCustomersParentRelatedClientID: TIntegerField;
    Bevel24: TBevel;
    memoDeliveryNotes: TDBMemo;
    Label60: TLabel;
    qryCustomersDeliveryNotes: TWideMemoField;
    Label53: TLabel;
    cboDefaultContactMethod: TwwDBComboBox;
    qryCustomersDefaultContactMethod: TWideStringField;
    qrySpecialsCustomerId: TIntegerField;
    qryCustomersCreditCardNumber: TWideStringField;
    qryCustomersCreditCardExpiryDate: TWideStringField;
    qryCustomersCreditCardNotes: TWideStringField;
    qryCustomersCreditCardType: TWideStringField;
    Label66: TLabel;
    Label20: TLabel;
    cboInvoiceTemplate: TwwDBLookupCombo;
    qryCustomersLastUpdated: TDateTimeField;
    qryBankCodes: TERPQuery;
    qryCustomersBankAccountName: TWideStringField;
    qryCustomersBankAccountBSB: TWideStringField;
    qryCustomersBankAccountNo: TWideStringField;
    qryCustomersBankCode: TWideStringField;
    qryForeignCurrency: TERPQuery;
    qryCustomersForeignExchangeSellCode: TWideStringField;
    qryCustomersCreditCardCardHolderName: TWideStringField;
    qryCustomersForcePOOnCustomer: TWideStringField;
    Label74: TLabel;
    cboDeliveryTemplate: TwwDBLookupCombo;
    qryDeliveryTemplates: TERPQuery;
    qryCustomersDefaultDeliveryTemplateID: TIntegerField;
    btnOtherPhones: TDNMSpeedButton;
    qryCustomersHours: TFloatField;
    btnCustStatement: TDNMSpeedButton;
    btnARReport: TDNMSpeedButton;
    Label77: TLabel;
    Email: TDBEdit;
    qryCustomersEmailXML: TWideStringField;
    Bevel12: TBevel;
    memoSalesComments: TDBMemo;
    Label44: TLabel;
    qryCustomersInvoiceComment: TWideMemoField;
    qryCustomersrepairComment: TWideMemoField;
    wwCheckBox2: TwwCheckBox;
    qryCustomersInvoiceCommentPopUp: TWideStringField;
    qryCustomersrepairCommentPopUp: TWideStringField;
    qryCustomersSendXMLInvoices: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    tbOtherFollowUpLeadLineID: TIntegerField;
    Label73: TLabel;
    Street3: TDBEdit;
    Label79: TLabel;
    BillStreet3: TDBEdit;
    qryCustomersStreet3: TWideStringField;
    qryCustomersBillStreet3: TWideStringField;
    qryCustomersIncludeOnIntrastat: TWideStringField;
    edtURL: TDBEdit;
    qryCustomersCUSTDATE1: TDateField;
    qryCustomersCUSTDATE2: TDateField;
    qryCustomersCUSTDATE3: TDateField;
    DNMPanel10: TDNMPanel;
    grdProdGroupDiscs: TwwDBGrid;
    grdProdGroupDiscsIButton: TwwIButton;
    cboCol1: TwwDBLookupCombo;
    cboCol2: TwwDBLookupCombo;
    cboCol3: TwwDBLookupCombo;
    Label57: TLabel;
    Label68: TLabel;
    Label21: TLabel;
    chkgroupdiscount: TwwCheckBox;
    btnAddDate: TDNMSpeedButton;
    qryCustomersForcePOOnRepair: TWideStringField;
    qryCustomersGlobalref: TWideStringField;
    Label80: TLabel;
    CustEquipDNMPanel: TDNMPanel;
    qryOpeningPoints: TERPQuery;
    dsOpeningPoints: TDataSource;
    qryOpeningPointsGlobalref: TWideStringField;
    qryOpeningPointsSalesLinesPointsId: TIntegerField;
    qryOpeningPointsLineValue: TFloatField;
    qryOpeningPointsPointExpiresOn: TDateField;
    qryOpeningPointsExpiresOnNoOfMonthsAfterPurchase: TIntegerField;
    qryOpeningPointsPointsUOMID: TIntegerField;
    qryOpeningPointsPointsUOMMultiplier: TFloatField;
    qryOpeningPointsActive: TWideStringField;
    qryOpeningPointsclientID: TIntegerField;
    qryOpeningPointsRewardPointID: TIntegerField;
    qryOpeningPointsValueforRewardPoint: TFloatField;
    qryOpeningPointsmsTimeStamp: TDateTimeField;
    qryOpeningPointsIsOpeningBalance: TWideStringField;
    qryOpeningPointsOpeningBalanceAsOn: TDateField;
    qryOpeningPointsDeptID: TLargeintField;
    qryOpeningPointsDeptname: TWideStringField;
    qryOpeningPointsSaleID: TIntegerField;
    qryOpeningPointsSaleLineID: TIntegerField;
    qryOpeningPointsProductID: TIntegerField;
    qryOpeningPointsProductName: TWideStringField;
    qryOpeningPointsLinePoints: TFloatField;
    QrySalesRedeemedPoints: TERPQuery;
    dsSalesRedeemedPoints: TDataSource;
    QrySalesRedeemedPointsUsedPoints: TFloatField;
    Label24: TLabel;
    chksplPrductdiscount: TwwCheckBox;
    qryCustomersSpecialProductPriceOverridesAll: TWideStringField;
    qryReferralsCustomertype: TWideStringField;
    Label85: TLabel;
    Label84: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    Bevel13: TBevel;
    qryCustomersPortOfLanding: TWideStringField;
    qryCustomersPortOfDischarge: TWideStringField;
    qryCustomersFinalDestination: TWideStringField;
    qryCustomersIncoPlace: TWideStringField;


    QryShippingAgent: TERPQuery;
    QryShippingAgentShippingAgentID: TLargeintField;
    QryShippingAgentCode: TWideStringField;
    QryShippingAgentDescription: TWideStringField;
    QryShippingAgentSupplierName: TWideStringField;
    QryShippingAgentSupplierID: TLargeintField;
    QryShippingAgentActive: TWideStringField;
    QryShippingAgentInsurance: TWideStringField;
    qryCustomersShippingAgentCode: TWideStringField;
    qryCustomersShippingAgentID: TIntegerField;
    qryCustomersShippingAgentDescription:TWideStringField;
    qryCustomersShippingAgentSuplierName:TWideStringField;
    qryCustomersShippingAgentSuplierID: TIntegerField;
    cboPortOfLoading: TwwDBLookupCombo;
    cboPortOfDischarge: TwwDBLookupCombo;
    cboFinalDestination: TwwDBLookupCombo;
    qryCustomersShippingAgentInsurance: TWideStringField;
    cboIncoPlace: TwwDBLookupCombo;
    qryProdGroupDiscsGrpDiscID: TIntegerField;
    WordApplication1: TWordApplication;
    QrystatementTemplates: TERPQuery;
    qryCustomersDefaultStatementTemplateId: TIntegerField;
    Label87: TLabel;
    wwDBLookupCombo1: TwwDBLookupCombo;
    cboShippingMethod_Label: TLabel;
    cboVia: TwwDBLookupCombo;
    Label90: TLabel;
    wwDBComboBox1: TwwDBComboBox;
    qryCustomersCallPriority: TIntegerField;
    qryClientTypesTypeName: TWideStringField;
    qryClientTypesTypeDescription: TWideStringField;
    qryClientTypesTermsID: TIntegerField;
    qryClientTypesCreditLimit: TFloatField;
    qryClientTypesGracePeriod: TWordField;
    qryClientTypesClientTypeID: TIntegerField;
    qryClientTypescallpriority: TIntegerField;
    Label91: TLabel;
    wwDBEdit6: TwwDBEdit;
    qryCustomersTeamviewerID: TWideStringField;
    Bevel19: TBevel;
    qryCustomersSkypename: TWideStringField;
    edtSkypeName: TDBEdit;
    Label92: TLabel;
    qryClientTypesactive: TWideStringField;
    DNMSpeedButton1: TDNMSpeedButton;
    cboClientR: TERPDbLookupCombo;
    pgCustomFields: TPageControl;
    tabCustomFields: TTabSheet;
    pnlcustomfieldList: TDNMPanel;
    DNMPanel12: TDNMPanel;
    TabSheet2: TTabSheet;
    pnlCustFldsFixed: TDNMPanel;
    Bevel14: TBevel;
    Box181: TBevel;
    Label95: TLabel;
    CUSTLBL1: TLabel;
    CUSTLBL2: TLabel;
    CUSTLBL3: TLabel;
    CUSTLBL4: TLabel;
    CUSTLBL5: TLabel;
    CUSTLBL6: TLabel;
    CUSTLBL7: TLabel;
    CUSTLBL8: TLabel;
    CUSTLBL9: TLabel;
    CUSTLBL10: TLabel;
    CUSTLBL11: TLabel;
    CUSTLBL12: TLabel;
    CUSTLBL13: TLabel;
    CUSTLBL14: TLabel;
    CUSTLBL15: TLabel;
    CUSTLBL16: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    CUSTLBL17: TLabel;
    CUSTLBL18: TLabel;
    cmdCustomLabelsOld: TDNMSpeedButton;
    CUSTFLD1: TwwDBComboBox;
    CUSTFLD2: TwwDBComboBox;
    CUSTFLD3: TwwDBComboBox;
    CUSTFLD4: TwwDBComboBox;
    CUSTFLD5: TwwDBComboBox;
    CUSTFLD10: TwwDBComboBox;
    CUSTFLD9: TwwDBComboBox;
    CUSTFLD8: TwwDBComboBox;
    CUSTFLD7: TwwDBComboBox;
    CUSTFLD6: TwwDBComboBox;
    CUSTFLD11: TwwDBComboBox;
    CUSTFLD12: TwwDBComboBox;
    CUSTFLD13: TwwDBComboBox;
    CUSTFLD14: TwwDBComboBox;
    CUSTFLD15: TwwDBComboBox;
    CUSTFLD16: TwwDBDateTimePicker;
    CUSTFLD17: TwwDBDateTimePicker;
    CUSTFLD18: TwwDBDateTimePicker;
    Bevel22: TBevel;
    qryContactsGlobalRef: TWideStringField;
    qryContactsContactID: TIntegerField;
    qryContactsClientID: TIntegerField;
    qryContactsClientName: TWideStringField;
    qryContactsCompany: TWideStringField;
    qryContactsContactTitle: TWideStringField;
    qryContactsContactFirstName: TWideStringField;
    qryContactsContactSurName: TWideStringField;
    qryContactsContactAddress: TWideStringField;
    qryContactsContactAddress2: TWideStringField;
    qryContactsContactAddress3: TWideStringField;
    qryContactsContactCity: TWideStringField;
    qryContactsContactState: TWideStringField;
    qryContactsContactPcode: TWideStringField;
    qryContactsContactCountry: TWideStringField;
    qryContactsContactPH: TWideStringField;
    qryContactsContactAltPH: TWideStringField;
    qryContactsContactMOB: TWideStringField;
    qryContactsContactFax: TWideStringField;
    qryContactsContactEmail: TWideStringField;
    qryContactsNotes: TWideStringField;
    qryContactsEditedFlag: TWideStringField;
    qryContactsActive: TWideStringField;
    qryContactsCardNumber: TWideStringField;
    qryContactsAccountNo: TWideStringField;
    qryContactsJobTitle: TWideStringField;
    qryContactsUseOnRun: TWideStringField;
    qryContactsmsTimeStamp: TDateTimeField;
    qryContactsLogMeInComputerIPAddress: TWideStringField;
    qryContactsLogMeInEmailPassword: TWideStringField;
    qryContactsLogMeInUserName: TWideStringField;
    qryContactsLogMeInPassword: TWideStringField;
    qryContactsLogMeInERPUserName: TWideStringField;
    qryContactsLogMeInERPPassword: TWideStringField;
    qryContactsLogMeIncomputerPassword: TWideStringField;
    qryContactsIsPrimarycontact: TWideStringField;
    qryContactsTeamviewerID: TWideStringField;
    qryContactsmsUpdateSiteCode: TWideStringField;
    tbOtherFollowUpNotes: TWideMemoField;
    qryCustomersmsUpdateSiteCode: TWideStringField;
    pnlDocumentsInner: TDNMPanel;
    pnlDocumentsList: TDNMPanel;
    grdDocs: TwwDBGrid;
    grdDocsIButton: TwwIButton;
    btnGetEmails: TButton;
    chkdocuments: TCheckBox;
    Label140: TLabel;
    Splitter1: TSplitter;
    pnlDocumentsMessage: TDNMPanel;
    HtmlViewer: THtmlViewer;
    lvAttachments: TListView;
    btnCopySpecialPrices: TDNMSpeedButton;
    chkIsInternal: TwwCheckBox;
    qryCustomersIsInternal: TWideStringField;
    cboClientLookupClientID: TIntegerField;
    cboClientLookupCompany: TWideStringField;
    QryAreaCodes: TERPQuery;
    QryAreaCodesAreaCode: TWideStringField;
    QryAreaCodesAreaName: TWideStringField;
    cboAreaCode: TwwDBLookupCombo;
    qryTaxExceptionProducts: TERPQuery;
    dsTaxExceptionProducts: TDataSource;
    qryTaxExceptionProductsID: TIntegerField;
    qryTaxExceptionProductsglobalref: TWideStringField;
    qryTaxExceptionProductsClientID: TIntegerField;
    qryTaxExceptionProductsClientName: TWideStringField;
    qryTaxExceptionProductsProductId: TIntegerField;
    qryTaxExceptionProductsProductName: TWideStringField;
    qryTaxExceptionProductsActive: TWideStringField;
    qryTaxExceptionProductsmsTimeStamp: TDateTimeField;
    qryTaxExceptionProductsmsUpdatesitecode: TWideStringField;
    QryProduct: TERPQuery;
    QryProductPARTSID: TIntegerField;
    QryProductPARTNAME: TWideStringField;
    QryProductPARTTYPE: TWideStringField;
    QryProductPRODUCTGROUP: TWideStringField;
    QryProductPARTSDESCRIPTION: TWideStringField;
    QryProductINCOMEACCNT: TWideStringField;
    QryProductASSETACCNT: TWideStringField;
    QryProductCOGSACCNT: TWideStringField;
    QryProductBARCODE: TWideStringField;
    QryProductPRODUCTCODE: TWideStringField;
    QryProductTAXCODE: TWideStringField;
    QryProductSpecialDiscount: TWideStringField;
    QryProductSNTracking: TWideStringField;
    QryProductBuyQTY1: TIntegerField;
    QryProductBuyQTY2: TIntegerField;
    QryProductBuyQTY3: TIntegerField;
    QryProductCOST1: TFloatField;
    QryProductCOST2: TFloatField;
    QryProductCOST3: TFloatField;
    QryProductSellQTY1: TIntegerField;
    QryProductSellQTY2: TIntegerField;
    QryProductSellQTY3: TIntegerField;
    QryProductPRICE1: TFloatField;
    QryProductPRICE2: TFloatField;
    QryProductPRICE3: TFloatField;
    QryProductWHOLESALEPRICE: TFloatField;
    QryProductActive: TWideStringField;
    QryProductEditedFlag: TWideStringField;
    tabFollowUp: TTabSheet;
    TabSheet3: TTabSheet;
    tabAusEParcel: TTabSheet;
    DNMPanel8: TDNMPanel;
    Bevel27: TBevel;
    lblReferralsWarning: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    grdReferrals: TwwDBGrid;
    btnDeleteReferral: TwwIButton;
    cboClients: TwwDBLookupCombo;
    btnLetters: TDNMSpeedButton;
    chkSelectAll: TCheckBox;
    MiscPageControl: TPageControl;
    DNMPanel14: TDNMPanel;
    Qryclients_eParcel: TERPQuery;
    dsclients_eParcel: TDataSource;
    Qryclients_eParcelGlobalRef: TWideStringField;
    Qryclients_eParcelID: TIntegerField;
    Qryclients_eParcelClientID: TIntegerField;
    Qryclients_eParceleParcelreference1: TWideStringField;
    Qryclients_eParceleParcelreference2: TWideStringField;
    Qryclients_eParcelPrinteParcelreference1: TWideStringField;
    Qryclients_eParcelPrinteParcelreference2: TWideStringField;
    Qryclients_eParcelReturn_Company: TWideStringField;
    Qryclients_eParcelReturn_Name: TWideStringField;
    Qryclients_eParcelReturn_Street1: TWideStringField;
    Qryclients_eParcelReturn_Street2: TWideStringField;
    Qryclients_eParcelReturn_Street3: TWideStringField;
    Qryclients_eParcelReturn_Suburb: TWideStringField;
    Qryclients_eParcelReturn_State: TWideStringField;
    Qryclients_eParcelReturn_Country: TWideStringField;
    Qryclients_eParcelReturn_Postcode: TWideStringField;
    Qryclients_eParcelReDir_Company: TWideStringField;
    Qryclients_eParcelReDir_Name: TWideStringField;
    Qryclients_eParcelReDir_Street1: TWideStringField;
    Qryclients_eParcelReDir_Street2: TWideStringField;
    Qryclients_eParcelReDir_Street3: TWideStringField;
    Qryclients_eParcelReDir_Suburb: TWideStringField;
    Qryclients_eParcelReDir_State: TWideStringField;
    Qryclients_eParcelReDir_Country: TWideStringField;
    Qryclients_eParcelReDir_Postcode: TWideStringField;
    Qryclients_eParcelEmailNotification: TWideStringField;
    Label37: TLabel;
    DBEdit1: TDBEdit;
    Label41: TLabel;
    DBEdit2: TDBEdit;
    Label64: TLabel;
    DBEdit3: TDBEdit;
    Label97: TLabel;
    DBEdit4: TDBEdit;
    Label99: TLabel;
    DBEdit5: TDBEdit;
    Label100: TLabel;
    wwDBLookupCombo2: TwwDBLookupCombo;
    Label101: TLabel;
    DBEdit6: TDBEdit;
    Label102: TLabel;
    DBEdit7: TDBEdit;
    Label103: TLabel;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    wwDBLookupCombo3: TwwDBLookupCombo;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    DBEdit17: TDBEdit;
    Label109: TLabel;
    wwCheckBox4: TwwCheckBox;
    Shape1: TShape;
    Shape3: TShape;
    btnCopyReturnAddress: TDNMSpeedButton;
    Shape4: TShape;
    Qryclients_eParcelconsigneePhoneonLabel: TWideStringField;
    Qryclients_eParcelLeaveAtAddress: TWideStringField;
    Qryclients_eParcelSignatureReqd: TWideStringField;
    Qryclients_eParcelExtraDeliveryInstructions: TWideStringField;
    Qryclients_eParcelChargeBackAcntID: TIntegerField;
    Qryclients_eParcelChargeBackAcnt: TWideStringField;
    Label108: TLabel;
    Shape2: TShape;
    DBEdit18: TDBEdit;
    Label110: TLabel;
    wwCheckBox5: TwwCheckBox;
    Label111: TLabel;
    wwCheckBox6: TwwCheckBox;
    wwCheckBox7: TwwCheckBox;
    Label112: TLabel;
    Label113: TLabel;
    wwCheckBox8: TwwCheckBox;
    Label114: TLabel;
    txtExtraDeliveryInstructions: TDBMemo;
    Shape5: TShape;
    cboAccountQry: TERPQuery;
    lblAccount: TLabel;
    cboAccount: TwwDBLookupCombo;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    wwRadioGroup1: TwwRadioGroup;
    Label115: TLabel;
    Shape10: TShape;
    DNMPanel11: TDNMPanel;
    DNMPanel17: TDNMPanel;
    grdFollowUp: TwwDBGrid;
    btnInactiveFollowUp: TwwIButton;
    cboEmployee: TwwDBLookupCombo;
    dtpDatePicker: TwwDBDateTimePicker;
    btnRepeat: TDNMSpeedButton;
    btnServiceCycle: TDNMSpeedButton;
    pnlAttach: TDNMPanel;
    pnlAttachments: TPanel;
    qryDocumentsRefID: TIntegerField;
    qryDocumentsDate: TDateTimeField;
    qryDocumentsType: TWideStringField;
    qryDocumentsReference: TWideStringField;
    qryDocumentsCusID: TIntegerField;
    qryDocumentsContactID: TIntegerField;
    qryDocumentsContactName: TWideStringField;
    qryDocumentsactive: TWideStringField;
    qryDocumentsEditedFlag: TWideStringField;
    qryDocumentsMessageId: TWideStringField;
    qryDocumentsReferenceData: TBlobField;
    qryDocumentsMessageFrom: TWideStringField;
    qryDocumentsMessageTo: TWideStringField;
    qryDocumentsStatus: TWideStringField;
    Memo1: TMemo;
    PageAddress: TPageControl;
    tabAddressmain: TTabSheet;
    TabShippingAddresses: TTabSheet;
    pnlShippingAddress: TDNMPanel;
    QryShippingAddressmain: TERPQuery;
    QryShippingAddressmainGlobalRef: TWideStringField;
    QryShippingAddressmainShipAddressID: TIntegerField;
    QryShippingAddressmainCompanyName: TWideStringField;
    QryShippingAddressmainCustomer_ID: TIntegerField;
    QryShippingAddressmainContactName: TWideStringField;
    QryShippingAddressmainShipAddress: TWideStringField;
    QryShippingAddressmainShipAddress1: TWideStringField;
    QryShippingAddressmainShipCity: TWideStringField;
    QryShippingAddressmainShipPostCode: TWideStringField;
    QryShippingAddressmainShipState: TWideStringField;
    QryShippingAddressmainShipCountry: TWideStringField;
    QryShippingAddressmainEditedFlag: TWideStringField;
    QryShippingAddressmainmsTimeStamp: TDateTimeField;
    QryShippingAddressmainShipAddress2: TWideStringField;
    QryShippingAddressmainActive: TWideStringField;
    QryShippingAddressmainPortOfLanding: TWideStringField;
    QryShippingAddressmainPortOfDischarge: TWideStringField;
    QryShippingAddressmainFinalDestination: TWideStringField;
    QryShippingAddressmainIncoPlace: TWideStringField;
    QryShippingAddressmainPhone: TWideStringField;
    QryShippingAddressmainmsUpdateSiteCode: TWideStringField;
    QryShippingAddressmainemail: TWideStringField;
    QryShippingAddressmainCustomerPhysicalAddress: TWideStringField;
    qryClientToShipAddressLink: TERPQuery;
    qryClientToShipAddressLinkGlobalRef: TWideStringField;
    qryClientToShipAddressLinkID: TIntegerField;
    qryClientToShipAddressLinkClientID: TIntegerField;
    qryClientToShipAddressLinkShipAddressID: TIntegerField;
    qryClientToShipAddressLinkEditedFlag: TWideStringField;
    qryClientToShipAddressLinkmsTimeStamp: TDateTimeField;
    qryClientToShipAddressLinkmsUpdateSiteCode: TWideStringField;
    QrycustomerShipAddresslist: TERPQuery;
    QrycustomerShipAddresslistCompanyName: TWideStringField;
    QrycustomerShipAddresslistContactName: TWideStringField;
    QrycustomerShipAddresslistAddress: TWideStringField;
    QrycustomerShipAddresslistAddress2: TWideStringField;
    QrycustomerShipAddresslistAddress3: TWideStringField;
    QrycustomerShipAddresslistCity: TWideStringField;
    QrycustomerShipAddresslistPostCode: TWideStringField;
    QrycustomerShipAddresslistState: TWideStringField;
    QrycustomerShipAddresslistCountry: TWideStringField;
    QrycustomerShipAddresslistActive: TWideStringField;
    QrycustomerShipAddresslistPortOfLanding: TWideStringField;
    QrycustomerShipAddresslistPortOfDischarge: TWideStringField;
    QrycustomerShipAddresslistFinalDestination: TWideStringField;
    QrycustomerShipAddresslistIncoPlace: TWideStringField;
    QrycustomerShipAddresslistShipAddressId: TIntegerField;
    QrycustomerShipAddresslistShipAddressIdAlreadySelected: TStringField;
    QrycustomerShipAddresslistCustomerPhysicalAddress: TWideStringField;
    grdShipAddressList: TwwDBGrid;
    dscustomerShipAddresslist: TDataSource;
    lblcustomerShipAddresslist: TLabel;
    qryTaxCodesTaxCodeID: TIntegerField;
    qryTaxCodesDescription: TWideStringField;
    qryTaxCodesRate: TFloatField;
    qryTaxCodesLocation: TWideStringField;
    qryTaxCodescRate: TFloatField;
    qryCustomersTaxname: TWideStringField;
    qryTaxCodesTaxname: TWideStringField;
    DNMSpeedButton2: TDNMSpeedButton;
    Label116: TLabel;
    Bevel20: TBevel;
    wwCheckBox9: TwwCheckBox;
    DBMemo2: TDBMemo;
    QryCreditcardtypes: TERPQuery;
    QryARAccounts: TERPQuery;
    qryCustomersDefaultARAccountName: TWideStringField;
    qryCustomersDefaultARAccountID: TIntegerField;
    QryARAccountsAccountID: TIntegerField;
    QryARAccountsAccountName: TWideStringField;
    btnAddfollowupnotedate: TDNMSpeedButton;
    tabXML: TTabSheet;
    pnlXML: TDNMPanel;
    Label43: TLabel;
    XMLEmail: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    Bevel25: TBevel;
    qryCustomersSendFTPXMLInvoices: TWideStringField;
    qryCustomersFTPAddress: TWideStringField;
    qryCustomersFTPUserName: TWideStringField;
    qryCustomersFTPPassword: TWideStringField;
    Label118: TLabel;
    Label119: TLabel;
    FTPUserName: TDBEdit;
    Label120: TLabel;
    FTPPassword: TDBEdit;
    Label121: TLabel;
    FTPAddress: TDBEdit;
    DBCheckBox2: TDBCheckBox;
    Label45: TLabel;
    Bevel28: TBevel;
    pnlDocsBottom: TDNMPanel;
    btnOpenDocumentPath: TDNMSpeedButton;
    btnSetDocumentPath: TDNMSpeedButton;
    lblDocumentPath: TDBText;
    qryCustomersDocumentPath: TWideStringField;
    qryCustomerscDocumentPath: TStringField;
    qryCustomersclientCode: TWideStringField;
    Label8: TLabel;
    edtclientCode: TDBEdit;
    btnValidatePhysical: TDNMSpeedButton;
    btnValidateBill: TDNMSpeedButton;
    qryCustomersAddressValid: TWideStringField;
    qryCustomersBillAddressValid: TWideStringField;
    chkBillAddressValid: TwwCheckBox;
    chkAddressValid: TwwCheckBox;
    qryCustomersForcePoOnSalesOrder: TWideStringField;
    qryCustomersDefaultSalesOrderTemplateID: TIntegerField;
    Label36: TLabel;
    cboDefaultSalesOrderTemplate: TwwDBLookupCombo;
    qrySalesOrderTemplate: TERPQuery;
    btnFollowUps: TDNMSpeedButton;
    pnlContactsForm: TDNMPanel;
    btnContactCustomise: TDNMSpeedButton;
    cboContactName: TwwDBLookupCombo;
    qryContactNames: TERPQuery;
    dsContactSelector: TDataSource;
    qryContactNamesContactName: TWideStringField;
    qryContactNamesContactId: TIntegerField;
    tbOtherFollowUpContactId: TIntegerField;
    tbOtherFollowUpContactName: TWideStringField;
    qryContactSelector: TERPQuery;
    cboContactSelector: TComboBoxEx;
    qryContactSelectorContactName: TWideStringField;
    qryContactSelectorContactId: TIntegerField;
    Label3: TLabel;
    btnRepair: TDNMSpeedButton;
    qryProdGroupDiscsGlobalRef: TWideStringField;
    qryProdGroupDiscsEditedFlag: TWideStringField;
    qryProdGroupDiscsmsTimeStamp: TDateTimeField;
    qryProdGroupDiscsmsUpdateSiteCode: TWideStringField;
    btnDeleteShippingAddress: TwwIButton;
    QrycustomerShipAddresslistCustomer_ID: TIntegerField;
    QrycustomerShipAddresslistClientID: TIntegerField;
    qryProdGroupDiscsMustMatch: TWideStringField;
    qryCustomersPrintName: TWideStringField;
    lblClientPrintNameHeading: TLabel;
    edtPrintName: TDBEdit;
    pnlDontContact: TDNMPanel;
    chkDontContact: TDBCheckBox;
    pnlActive: TDNMPanel;
    DNMPanel6: TDNMPanel;
    DNMPanel7: TDNMPanel;
    chkIntrastat: TDBCheckBox;
    Label4: TLabel;
    btnSupplier: TDNMSpeedButton;
    chkActive: TDBCheckBox;
    btnPriceList: TDNMSpeedButton;
    lblSendXMLInvoices: TLabel;
    qrySpecialsGlobalRef: TWideStringField;
    qrySpecialsIncludeInRun: TWideStringField;
    qrySpecialsDateFrom: TDateField;
    qrySpecialsDateTo: TDateField;
    qrySpecialsmsTimeStamp: TDateTimeField;
    qrySpecialsmsUpdateSiteCode: TWideStringField;
    qrySpecialsUOM: TWideStringField;
    qrySpecialsUOMID: TIntegerField;
    qrySpecialsUOMMultiplier: TFloatField;
    QryUOM: TERPQuery;
    QryUOMUnitname: TWideStringField;
    QryUOMmultiplier: TFloatField;
    QryUOMUnitId: TIntegerField;
    QryUOMPartID: TIntegerField;
    cboUOM: TwwDBLookupCombo;
    DNMPanel1: TDNMPanel;
    Label40: TLabel;
    btnMarketingContact: TDNMSpeedButton;
    qryCustomersCreditCardCVC: TWideStringField;
    Label96: TLabel;
    qryCustomersClientPaysShippment: TWideStringField;
    qryCustomersClientShipperAccountNo: TWideStringField;
    chkClientPaysShipping: TwwCheckBox;
    edtClientShippingAccountNo: TwwDBEdit;
    btnLead: TDNMSpeedButton;
    DNMPanel2: TDNMPanel;
    Label63: TLabel;
    cboCreditCardType: TwwDBLookupCombo;
    Label62: TLabel;
    txtCardHolderName: TwwDBEdit;
    Label22: TLabel;
    txtCardNumber: TEdit;
    Label61: TLabel;
    wwDBEdit2: TwwDBEdit;
    Label25: TLabel;
    edtCreditCardCVC: TwwDBEdit;
    Label32: TLabel;
    DBMemo1: TDBMemo;
    btnClearCreditCardDetails: TDNMSpeedButton;
    DNMPanel15: TDNMPanel;
    Label56: TLabel;
    AccountNo: TDBEdit;
    DNMPanel16: TDNMPanel;
    Label52: TLabel;
    cboTerms: TwwDBLookupCombo;
    Label5: TLabel;
    CreditLimit: TwwDBEdit;
    Label7: TLabel;
    GracePeriod: TwwDBEdit;
    btnExportCredit: TDNMSpeedButton;
    DNMPanel18: TDNMPanel;
    Label58: TLabel;
    CardNumber: TDBEdit;
    DNMPanel19: TDNMPanel;
    Label86: TLabel;
    cboShippingAgent: TwwDBLookupCombo;
    Label88: TLabel;
    Label89: TLabel;
    wwDBEdit5: TwwDBEdit;
    wwDBEdit3: TwwDBEdit;
    DNMPanel20: TDNMPanel;
    chkUseBaseInvNo: TwwCheckBox;
    Label50: TLabel;
    edtBaseInvNo: TwwDBEdit;
    DNMPanel21: TDNMPanel;
    wwCheckBox3: TwwCheckBox;
    Label23: TLabel;
    Label16: TLabel;
    chkForcePOOnBooking: TwwCheckBox;
    Label14: TLabel;
    chkForcePOOnInvoice: TwwCheckBox;
    Label2: TLabel;
    wwCheckBox1: TwwCheckBox;
    Label18: TLabel;
    DNMPanel22: TDNMPanel;
    cboPaymentMethod: TwwDBLookupCombo;
    Label17: TLabel;
    Label49: TLabel;
    cboForeignCurrencyCode: TwwDBLookupCombo;
    ABN: TDBEdit;
    Label65: TLabel;
    DNMPanel23: TDNMPanel;
    Label1: TLabel;
    Label71: TLabel;
    wwDBEdit1: TwwDBEdit;
    Label75: TLabel;
    txtFreeHours: TwwDBEdit;
    DNMPanel24: TDNMPanel;
    Label67: TLabel;
    edtBankAccName: TwwDBEdit;
    lblBSB: TLabel;
    edtBankAccBSB: TwwDBEdit;
    Label69: TLabel;
    edtBankAccNo: TwwDBEdit;
    Label70: TLabel;
    cboBankCode: TwwDBLookupCombo;
    DNMPanel27: TDNMPanel;
    DNMPanel4: TDNMPanel;
    lblrewardPoints: TLabel;
    lblLinePoints: TLabel;
    lblOpeningBalanceAsOn: TLabel;
    lblPointExpiresOn: TLabel;
    Label83: TLabel;
    edtLinePoints: TwwDBEdit;
    edtOpeningBalanceAsOn: TwwDBDateTimePicker;
    edtPointExpiresOn: TwwDBDateTimePicker;
    wwDBEdit4: TwwDBEdit;
    DNMPanel26: TDNMPanel;
    Label9: TLabel;
    Label72: TLabel;
    cboTaxExceptionProduct: TERPDbLookupCombo;
    grdTaxExceptionProducts: TwwDBGrid;
    delTaxExceptionProducts: TwwIButton;
    cboTaxCode: TERPDbLookupCombo;
    DNMPanel25: TDNMPanel;
    Label76: TLabel;
    cboDefaultARAccountName: TwwDBLookupCombo;
    tabCustomershippingoptions: TTabSheet;
    qryCustomershippingoptions: TERPQuery;
    dsCustomershippingoptions: TDataSource;
    qryCustomershippingoptionsGlobalRef: TWideStringField;
    qryCustomershippingoptionsCustomerShipingOptionID: TIntegerField;
    qryCustomershippingoptionsCustomerID: TIntegerField;
    qryCustomershippingoptionsShipperType: TWideStringField;
    qryCustomershippingoptionsPackageProvider: TWideStringField;
    qryCustomershippingoptionsPayorType: TWideStringField;
    qryCustomershippingoptionsAccountNumber: TWideStringField;
    qryCustomershippingoptionsActive: TWideStringField;
    qryCustomershippingoptionsmsTimeStamp: TDateTimeField;
    qryCustomershippingoptionsmsUpdateSiteCode: TWideStringField;
    grdCustomershippingoptions: TwwDBGrid;
    cboPayorType: TwwDBComboBox;
    qryCustomershippingoptionsIsDefault: TWideStringField;
    lblMsg: TLabel;
    QryShippingAddressmainAddressValidated: TWideStringField;
    tsEDI: TTabSheet;
    DNMPanel28: TDNMPanel;
    Label117: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    Label126: TLabel;
    DBCheckBox3: TDBCheckBox;
    edtEDIVendorCode: TEdit;
    edtSaleSendUser: TEdit;
    edtSaleSendPass: TEdit;
    edtSaleSendServer: TEdit;
    edtSaleSendDir: TEdit;
    edtSaleReceiveDir: TEdit;
    qryCoreEDIConfig: TERPQuery;
    dsCoreEDIConfig: TDataSource;
    lblPOFTPPort: TLabel;
    edtSaleFTPPort: TEdit;
    edtLocalReceiveDir: TEdit;
    Label129: TLabel;
    qryCustomersmsTimeStamp: TDateTimeField;
    MnuCreditCard: TAdvPopupMenu;
    Decrypt1: TMenuItem;
    RestoreFromTable1: TMenuItem;
    Encrypt1: TMenuItem;
    N1: TMenuItem;



    procedure cmdNewClick(Sender: TObject);
    procedure cmdCopyClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure TabCtl20Change(Sender: TObject);
    procedure SuburboldCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure BillSuburboldCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cmdCustomLabelsOldClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure grpHistoryClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EditbtnClick(Sender: TObject);
    procedure cmdNewContactClick(Sender: TObject);
    procedure LetterbtnClick(Sender: TObject);
    procedure FaxBtnClick(Sender: TObject);
    procedure EmailbtnClick(Sender: TObject);
    procedure btnSupplierClick(Sender: TObject);
    procedure dsStateChange(Sender: TObject);
//    procedure btnInactiveClick(Sender: TObject);
    procedure chkShowAllClick(Sender: TObject);
    procedure cboProdCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure grdSpecialsIButtonClick(Sender: TObject);
    procedure btnNewProdClick(Sender: TObject);
    procedure grdDocsDblClick(Sender: TObject);
    procedure btnInactiveFollowUpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure BillSuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cmdNotesClick(Sender: TObject);
    procedure cmdShippingClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure edtDiscExit(Sender: TObject);
    procedure qryCustomersBeforePost(DataSet: TDataSet);
    procedure qryCustomersAfterOpen(DataSet: TDataSet);
    procedure cboClientTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure edtSpecDiscExit(Sender: TObject);
    procedure SuburbOnEnter(Sender: TObject);
    procedure BillSuburbBeforeDropDown(Sender: TObject);
    procedure cboTaxCodeNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure qryCustomersFirstNameChange(Sender: TField);
    procedure actGeneralUpdate(Sender: TObject);
    procedure grdFollowUpColExit(Sender: TObject);
    procedure grdFollowUpColEnter(Sender: TObject);
    procedure tbOtherFollowUpAfterOpen(DataSet: TDataSet);
    procedure qrySpecialsAfterOpen(DataSet: TDataSet);
    procedure qryContactsAfterOpen(DataSet: TDataSet);
    procedure grdProdGroupDiscsIButtonClick(Sender: TObject);
    procedure edtURLDblClick(Sender: TObject);
    procedure qryCustomersLastNameChange(Sender: TField);
    procedure qryCustomersRepIDChange(Sender: TField);
    procedure btnExportCreditClick(Sender: TObject);
    procedure TabCtl20Changing(Sender: TObject; var AllowChange: boolean);
    procedure btnDeleteReferralClick(Sender: TObject);
    procedure chkAllRefsClick(Sender: TObject);
    procedure btnLettersClick(Sender: TObject);
    procedure actReferralsPrintExecute(Sender: TObject);
    procedure actReferralsPrintUpdate(Sender: TObject);
    procedure chkUseBaseInvNoClick(Sender: TObject);
    procedure grdReferralsExit(Sender: TObject);
    procedure grdProdGroupDiscsExit(Sender: TObject);
    procedure grdSpecialsExit(Sender: TObject);
    procedure cboClientsExit(Sender: TObject);
    procedure EquipNotesDialog1UserButton1Click(Dialog: TwwMemoDlg; Memo: TMemo);
    procedure AccountNoKeyPress(Sender: TObject; var Key: char);
    procedure btnAddDateTimeClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnPriceListClick(Sender: TObject);
    procedure btnInvoiceClick(Sender: TObject);
    procedure btnQuoteClick(Sender: TObject);
    procedure btnSalesOrderClick(Sender: TObject);
    procedure TabCtl20Resize(Sender: TObject);
    procedure grdRelatedClientExit(Sender: TObject);
    procedure wwIButton1Click(Sender: TObject);
    procedure cboClientCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure qryRelatedClientsChildCompanyChange(Sender: TField);
    procedure edtSequenceKeyPress(Sender: TObject; var Key: char);
    procedure wwDBEdit1DblClick(Sender: TObject);
    procedure tbOtherFollowUpNewRecord(DataSet: TDataSet);
    procedure btnRepeatClick(Sender: TObject);
    procedure txtCardNumberExit(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
    procedure btnServiceCycleClick(Sender: TObject);
    procedure cboProductQryAfterOpen(DataSet: TDataSet);
    procedure cboBankCodeEnter(Sender: TObject);
    procedure edtBankAccBSBCheckValue(Sender: TObject; PassesPictureTest: boolean);
    procedure cboProdChange(Sender: TObject);
    procedure cboRepChange(Sender: TObject);
    procedure cboRepCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure SuburbChange(Sender: TObject);
    procedure BillSuburbChange(Sender: TObject);
    procedure cboTermsChange(Sender: TObject);
    procedure cboTermsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboClientNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure btnOtherPhonesClick(Sender: TObject);
    procedure cboMediaTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
//    procedure grdContactKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCustStatementClick(Sender: TObject);
    procedure btnARReportClick(Sender: TObject);
    procedure qrySuburbBeforeOpen(DataSet: TDataSet);
    procedure qryTaxCodesBeforeOpen(DataSet: TDataSet);
    procedure XMLEmailExit(Sender: TObject);
    procedure EmailExit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure grdRelatedClientFieldChanged(Sender: TObject; Field: TField);
    procedure grdFollowUpFieldChanged(Sender: TObject; Field: TField);
    procedure grdSpecialsFieldChanged(Sender: TObject; Field: TField);
    procedure grdProdGroupDiscsFieldChanged(Sender: TObject;
      Field: TField);
    procedure grdReferralsFieldChanged(Sender: TObject; Field: TField);
    procedure grdContactFieldChanged(Sender: TObject; Field: TField);
    procedure cboDeliveryCodeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure grdFollowUpDblClick(Sender: TObject);
    procedure tbOtherFollowUpAfterScroll(DataSet: TDataSet);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FirstNameExit(Sender: TObject);
    procedure btnAddDateClick(Sender: TObject);
    procedure qryCustomersShippingIDChange(Sender: TField);
    procedure qryCustomersTermsIDChange(Sender: TField);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure qryOpeningPointsAfterInsert(DataSet: TDataSet);
    procedure qryOpeningPointsAfterOpen(DataSet: TDataSet);
    procedure edtPointExpiresOnExit(Sender: TObject);
    procedure edtLinePointsExit(Sender: TObject);
    procedure QrySalesRedeemedPointsAfterOpen(DataSet: TDataSet);
    procedure cboShippingAgentCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboShippingAgentEnter(Sender: TObject);
    procedure cboPortOfLoadingEnter(Sender: TObject);
    procedure cboPortOfDischargeEnter(Sender: TObject);
    procedure cboFinalDestinationEnter(Sender: TObject);
    procedure cboClientTypeEnter(Sender: TObject);
    procedure cboIncoPlaceEnter(Sender: TObject);
    procedure qryCustomersAfterInsert(DataSet: TDataSet);
    procedure EmailDblClick(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure qrySpecialsNameChange(Sender: TField);
    procedure qrySpecialsAfterInsert(DataSet: TDataSet);
    procedure qrySpecialsAfterPost(DataSet: TDataSet);
    procedure qryCustomersClientTypeIDChange(Sender: TField);
    procedure tbOtherFollowUpAfterInsert(DataSet: TDataSet);
    procedure qryReferralsAfterInsert(DataSet: TDataSet);
    procedure qryRelatedClientsAfterInsert(DataSet: TDataSet);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure tbOtherFollowUpBeforeInsert(DataSet: TDataSet);
    procedure qryRelatedClientsBeforePost(DataSet: TDataSet);
    procedure cboClientRAfterchange(Sender: TObject);
    procedure cboClientRBeforeOpenList(Sender: TObject);
    procedure lblChildmessageDblClick(Sender: TObject);
    procedure grdDocsIButtonClick(Sender: TObject);
    procedure chkdocumentsClick(Sender: TObject);
    procedure btnGetEmailsClick(Sender: TObject);
    procedure grdDocsRowChanged(Sender: TObject);
    procedure HtmlViewerImageRequest(Sender: TObject; const SRC: string;
      var Stream: TStream);
    procedure HtmlViewerHotSpotClick(Sender: TObject; const SRC: string;
      var Handled: Boolean);
    procedure qryDocumentsAfterPost(DataSet: TDataSet);
    procedure qryDocumentsBeforePost(DataSet: TDataSet);
    procedure lvAttachmentsDblClick(Sender: TObject);
    procedure btnCopySpecialPricesClick(Sender: TObject);
    procedure qryTaxExceptionProductsAfterInsert(DataSet: TDataSet);
    procedure delTaxExceptionProductsClick(Sender: TObject);
    procedure grdTaxExceptionProductsDblClick(Sender: TObject);
    procedure qryTaxExceptionProductsProductNameChange(Sender: TField);
    procedure qryTaxExceptionProductsBeforePost(DataSet: TDataSet);
    procedure cboTaxExceptionProductCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure cboTaxExceptionProductChange(Sender: TObject);
    procedure QryProductAfterOpen(DataSet: TDataSet);
    procedure qryBankCodesBeforeOpen(DataSet: TDataSet);
    procedure Qryclients_eParcelAfterInsert(DataSet: TDataSet);
    procedure MiscPageControlChanging(Sender: TObject; var AllowChange: Boolean);
    procedure MiscPageControlChange(Sender: TObject);
    procedure btnCopyReturnAddressClick(Sender: TObject);
    procedure wwDBLookupCombo2CloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure wwDBLookupCombo3CloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure cboAccountCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure btnSMSClick(Sender: TObject);
    procedure PageAddressChange(Sender: TObject);
    procedure qryCustomersAfterPost(DataSet: TDataSet);
    procedure QryShippingAddressmainBeforeOpen(DataSet: TDataSet);
    procedure qryContactsBeforeOpen(DataSet: TDataSet);
    procedure qryClientToShipAddressLinkBeforeOpen(DataSet: TDataSet);
    procedure QryShippingAddressmainBeforeScroll(DataSet: TDataSet);
    procedure QryShippingAddressmainAfterPost(DataSet: TDataSet);
    procedure grdShipAddressListCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure QrycustomerShipAddresslistBeforeOpen(DataSet: TDataSet);
    procedure PageAddressChanging(Sender: TObject; var AllowChange: Boolean);
    procedure qryTermsAfterOpen(DataSet: TDataSet);
    procedure qryTaxCodesCalcFields(DataSet: TDataSet);
    procedure DNMSpeedButton2Click(Sender: TObject);
    procedure cboCreditCardTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure cboCreditCardTypeChange(Sender: TObject);
    procedure cboDefaultARAccountNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure btnAddfollowupnotedateClick(Sender: TObject);
    procedure grdFollowUpRowChanged(Sender: TObject);
    procedure grdFollowUpEnter(Sender: TObject);
    procedure qryProdGroupDiscsAfterInsert(DataSet: TDataSet);
    procedure qryProdGroupDiscsAfterOpen(DataSet: TDataSet);
    procedure qryProdGroupDiscsBeforeOpen(DataSet: TDataSet);
    procedure qryProdGroupDiscsBeforePost(DataSet: TDataSet);
    procedure qryCustomersTaxnameChange(Sender: TField);
    procedure ActionList1Update(Action: TBasicAction; var Handled: Boolean);
    procedure btnOpenDocumentPathClick(Sender: TObject);
    procedure btnSetDocumentPathClick(Sender: TObject);
    procedure QryCustomersCalcFields(DataSet: TDataSet);
    procedure btnValidatePhysicalClick(Sender: TObject);
    procedure cboRepEnter(Sender: TObject);
    procedure btnCustomiseClick(Sender: TObject);
    procedure btnContactCustomiseClick(Sender: TObject);
    procedure btnFollowUpsClick(Sender: TObject);
    procedure btnContactMessageClick(Sender: TObject);
    procedure qryContactNamesBeforeOpen(DataSet: TDataSet);
    procedure cboContactSelectorChange(Sender: TObject);
    procedure cboContactSelectorSelect(Sender: TObject);
    procedure qryContactSelectorBeforeOpen(DataSet: TDataSet);
    procedure btnRepairClick(Sender: TObject);
    procedure btnDeleteShippingAddressClick(Sender: TObject);
    procedure edtPrintNameExit(Sender: TObject);
    procedure edtPrintNameChange(Sender: TObject);
    procedure grdSpecialsDblClick(Sender: TObject);
    procedure qrySpecialsBeforePost(DataSet: TDataSet);
    procedure cboUOMCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;modified: Boolean);
    procedure cboUOMDropDown(Sender: TObject);
    procedure btnMarketingContactClick(Sender: TObject);
    procedure DBCheckBox1Click(Sender: TObject);
    procedure DBCheckBox2Click(Sender: TObject);
    procedure btnLeadClick(Sender: TObject);
    procedure btnClearCreditCardDetailsClick(Sender: TObject);
    procedure qryCustomershippingoptionsAfterInsert(DataSet: TDataSet);
    procedure grdCustomershippingoptionsEnter(Sender: TObject);
    procedure qryCustomershippingoptionsIsDefaultChange(Sender: TField);
    procedure qryCustomershippingoptionsAfterScroll(DataSet: TDataSet);
    procedure qryCustomershippingoptionsAfterPost(DataSet: TDataSet);
    procedure grdShipAddressListDblClick(Sender: TObject);
    procedure edtEDIVendorCodeChange(Sender: TObject);
    procedure edtSaleReceiveDirChange(Sender: TObject);
    procedure edtSaleSendDirChange(Sender: TObject);
    procedure edtSaleSendPassChange(Sender: TObject);
    procedure edtSaleSendServerChange(Sender: TObject);
    procedure edtSaleSendUserChange(Sender: TObject);
    procedure DBCheckBox3Click(Sender: TObject);
    procedure edtSaleFTPPortChange(Sender: TObject);
    procedure edtLocalReceiveDirChange(Sender: TObject);
    procedure Decrypt1Click(Sender: TObject);
    procedure RestoreFromTable1Click(Sender: TObject);
    procedure Encrypt1Click(Sender: TObject);

  private
    { Private declarations }
    NoLockSource: boolean;
    oTASDescription: TASDescription;
    RealignTabInProgress: boolean;
    bShowingHistory: boolean;
    bNewCust: boolean;
    fsNewCompanyName: string;
    //fShipAddressList :TBaseListingGUI;
    fListStatements: TBaseListingGUI;
    fListAppoints: TBaseListingGUI;
    fListSalesOrder: TBaseListingGUI;
    fRepairList: TBaseListingGUI;
    fListQuotes: TBaseListingGUI;
    fListInvoices: TBaseListingGUI;
    fRewardPoints:TBaselistingGUI;
    fListJobprofit: TBaseListingGUI;
    fListTimesheet: TBaseListingGUI;
    fListNonERPSales: TBaseListingGUI;
    fListcleintHRForms: TBaseListingGUI;
    fListProductSales: TBaseListingGUI;
    fListJobs: TBaseListingGUI;
    fListArNotes: TBaseListingGUI;
    fCustomerContactListForm: TBaseListingGUI;
    AttachmentForm: TfmAttachments;
//    frmContact :TfrmContact;
    fbSaveClicked: boolean;
    fbIsModified: boolean;
    fsEquipmenttoAdd: STring;
    fsRegotoAdd: STring;
    fbEmailchanged:Boolean;
    Equipmentform:TfmClientEquipment;
    fDefaultTab: String;
    HistoryListform: TBaseListingGUI;
    SelectedMail: TIdMessage;
    HTMLImageStream: TMemoryStream;
    FileAssociationDetails: TFileAssociationDetails;
    MailProgesss: TProgressDialog;
    ProgressCanceled: boolean;
    fbCopyGroupDiscount,fbCopyPermanentDiscount,fbCopySpecialProducts,fbCopySpecialProductDiscount:Boolean;
    fContactCreated: boolean;
    fbUpdatingcompanyonName :Boolean;
    fbclientnameMadeFromName:Boolean;
    fsCheckJobsMsg:String;
    fiCheckJobscount:Integer;
    TabCtl20CurTab:TTabSheet;
    CustomerObj:TCustomer;


    function PreSaveCustomer: boolean;
    procedure GetDiscounts;
    procedure SetDefaults;
//    function IsFollowUpOK: boolean;
    procedure ExportCreditToJobs;
//    procedure SetCustomerToContact;
    function ChkCustReqdFields: boolean;
    procedure SetComboFocus(var Msg: TMessage); message TX_SetFocus;
    procedure AssignComboAccessed(Sender: TObject);
    procedure UpdateClientTypeData;
    procedure GlobalEventHandler(const Sender: TObject; const Event: string; const Data: Pointer);
    Procedure Callcontactform(Sender:TDNMSpeedbutton);
    Procedure SetProdColumQry(Qry :TERPQuery; colno :Integer);
    function ValidateCustomer(checkall:Boolean):Boolean;
    Function CustomerSaved:Boolean;
    Procedure UpdatefromEquipment;
    Function StatementsList: TBaseListingGUI;
    Function ListAppoints: TBaseListingGUI;
    Function SalesOrderList: TBaseListingGUI;
    Function RepairsList: TBaseListingGUI;
    Function ListQuotes: TBaseListingGUI;
    Function ListInvoices: TBaseListingGUI;
    Function RewardPointList:TBaselistingGUI;
    Function ListJobprofit: TBaseListingGUI;
    Function TimesheetList: TBaseListingGUI;
    Function NonERPSalesList: TBaseListingGUI;
    Function cleintHRFormsList: TBaseListingGUI;
    Function ListProductSales: TBaseListingGUI;
    Function ListJobs: TBaseListingGUI;
    Function ListArNotes: TBaseListingGUI;
    Function CustomerContactListForm: TBaseListingGUI;
//    function Makecustomercontact: boolean;
    Procedure Makecustomer_eParcelRec;
    function RelatedCustomerHascontributionAmount(relatedclientID:Integer): Boolean;
    function MakeNewcontactifnone:Boolean;
    procedure LoadMemTable;
    procedure BeforeShowNotesAuditTrailList(Sender: TObject);
    procedure DoOnAfterListPopupFormShow(ListForm: TBaseListingGUI; PopupForm: TBaseInputGUI);
    //Function Newcustomer:boolean;
    procedure InitListofHistoryforms(Sender: TObject);
    procedure CheckForEmails;
    procedure DoOnCheckForEmailsProgress(const msg: string; var Continue: boolean);
    procedure DoOnGetMessageCount(const MessageCount: integer);
    procedure DoOnProgressCancel(Sender: TObject);
    procedure CopySpecialPricesToOtherCustomers;
    procedure DoCustomerListBeforeShow(Sender: TObject);
    procedure CustomerGridDataSelect(Sender: TwwDbGrid);
    function IsProductUnique(ProductName: String; ID: Integer): Boolean;
    Procedure OpenSubQry(Qry :TERPQuery; clientIDParamname:String);
    procedure MainShippingAddress;
    procedure initSalesAddressLabelPrn(Sender: TObject);
    procedure SetGUIControllStates;
    procedure initfrmPriceListGUI(Sender: TObject);
    procedure CustomerContactListFormShow;
    procedure Makecompany;
    function InitUOM(const UOMName: String; UOMQry: Tdataset): Integer;
    procedure CheckJobs;
    procedure CheckJobsCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure CopySpecialPricesTocustomer(Thiscust :TCustomer; ClientID: Integer);
    procedure DoOnGridDataSelectMultiCustomer(Sender: TwwDbGrid);
    function MarketingcotnactID(var  msg: string): Integer;
    procedure initMarketingform(Sender: TObject);
    procedure LoadCoreEDIConfig;
    function CoreEDIConfigSave: boolean;
    procedure CustomerIDChange;
    Function DecryptCreditCardNumber(sTemp: string):String;
    function EncryptCreditCardNumber(const sTemp: String): String;

  protected
    function GetReportTypeID: integer; override;
    procedure CheckCreateCustomerAccountNumber;
    procedure KeyIdChanged(const NewKeyId: integer); override;
    procedure CompleteComboNotInList(const aObserver: TObject); override;
    procedure CustomFieldsRefresh;Override;
    function GetKeyString: string; override;
    procedure SetKeyString(const Value: string); override;
    Function SaveOrCancelChanges: boolean;Override;
    procedure SetStateParams(const Value: TJsonObject); override;
    Procedure AfterFormShow; override;
    procedure AftershowPopupform(frmPopup:TBaseInputGUI);Override;
    // Contacts
//    procedure UpdatePrimaryContact;
    (*function CustomerContactListForm(Recreate : boolean = false) : TCustomerContactListGUI;*)
    // Page switches
    procedure OnTabGeneral(Sender : TObject);
    procedure OnTabAccounts(Sender : TObject);
    procedure OnTabHistory(Sender : TObject);
    procedure OnTabReferrals(Sender : TObject);
    procedure OnTabContacts(Sender : TObject);
    procedure OnTabSpecialProds(Sender : TObject);
    procedure LoadContactSelector;
    function FilteredContactId : integer;
    function ContactFiltered : boolean;
    procedure SetContactFilter(aContactId : integer);
    procedure ContactsFormBeforeShow(Sender: TObject);
    property ContactCreated : boolean read fContactCreated write fContactCreated;
    procedure InitGridcolumnsforGuiPrefs(sender: TwwDBGrid);Override;
    Function ClientId :Integer; Override;
  public
    { Public declarations }
    fbUpdatingNotes: boolean;
    Procedure newEquip(const Value:String);
    Procedure newRego(const Value:String);
    Procedure LocateEquip(const customerEquipID:Integer);

    class procedure CloseMe; override;
    {ML - This property is used to open the Customer form with company name already specified.
    You can't append the details to the text box due to the fact it's data aware}

    property NewCompanyName: string read fsNewCompanyName write fsNewCompanyName;
    property ServiceCycleDescription: TASDescription read oTASDescription write oTASDescription;
    procedure UpdateMe; override;
    procedure UpdateMe(const Cancelled: boolean; const aObject: TObject = nil); override;
    Property EquipmenttoAdd:STring Read fsEquipmenttoAdd write fsEquipmenttoAdd;
    Property RegotoAdd:STring Read fsRegotoAdd write fsRegotoAdd;
    Property DefaultTab:string read fDefaultTab Write fDefaultTab;
    Procedure AfterPopupformshow;Override;
    Function CustomFieldExtenderListtype:TListType; Override;
    function ShiptoAddress:String;

    // ARe used by Correspondence
    function SelectedContactId : integer;
    function SelectedContactEMail : string;
    function SelectedContactCompany : string;
    function SelectedContactAddress : string;
    function SelectedContactState : string;  // City + State + PCode + Country
    function SelectedContactFirstName : string;
    function SelectedContactFax : string;
    function SelectedContactName : string;
    function SelectedContactMobile : string;
    function CustomerContactCount(excludecontactID:Integer) : integer;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string); override;

  end;


implementation

uses
  CommonDbLib, FormFactory, AuditObj, frmCustomFieldsFrm, AppointmentListForm,
  SalesOrderListForm, QuoteListForm, InvoiceListForm,
  (*frmClientReferenceFrm,*) remainClientFrm, StatementListForm, DNMExceptions,
  CustomerListForm,  ShipAddressListForm, (*LoyaltyListForm,*)
  ShellAPI,  StrUtils,
  (*JobProfitabilityForm, *)frmPayTimesheetFrm, CustomerSalesOnProductList,
  PriceListForm, frmInvoice, frmQuote, frmSalesOrder, AccountsReceiveListForm,
  frmRepeat, TransLockManagementObj, AccountsReceivableNotesList,
  Commonlib, frmClientsOtherPhonesGUI,
  frmServiceDescriptionGUI,
  FastFuncs, GlobalEventsObj, AppContextObj,
  frmFollowup, AppEnvironment, tcDataUtils,tcTypes, (*frmEquipmentFrm,*)
  ProductQtyLib, frmPrintInvoiceStatements, RepairList, BusObjCommon,
  RewardPoints, DefaultClassObj, CompanyPrefObj, CommonFormLib, CipherUtils,
  JobProfitabilityforCustomer, EmailUtilsDefaultMailClient, EncryptFix,
  InventoryLib, NotesAuditTrailList, FormReopenerObj,
  CustomerExpressList, MailReaderObj, BusObjEmailConfig, HTTPUtil,
  ContentTypeObj, IdText, IdAttachmentFile, IdAttachmentMemory, IdHTTP,
  SystemLib, IdAttachment, EmailConst, IntegerListObj,
  frmCustomerCorrespondenceCreate, busobjclienttaxexceptionproducts, BusObjStock,
  SMSMessageObj, frmMobileNumberInput, SMSUtils, SMSUtilsGui,
  EmployeeAccesses, SalesAddressLabelPrn, frmPaymentMethod, {$WARNINGS OFF}FileCtrl{$WARNINGS ON},
  docPathLib, tcConst, frmCustomerSpecialPricecopy, LogLib, CorrespondenceObj,
  ibxezaddress, ShipAddressValidationObj, TimedHint, frmReportingOptions,PurchaseOrderListForm,
  QueryManipulationObj, frmRepairs, NonERPSalesList, HTTPConst, clientHRForms,
   UserCustomisedNames, CustomFieldValuesListContact, DbSharedObjectsObj,
  CustomerPriceListList, MySQLConst, DialogUtils, frmMarketingLead,
  ShipIntegrationTypes, BusObjConst, BusObjCoreEDIConfig;
  // datSpelling;


{$R *.DFM}

const
  csActive = ' AND (Active="T")';

procedure TfrmCustomer.cmdCopyClick(Sender: TObject);
begin
  if IsOkToSave() and qryCustomers.Active  then begin
    EditDB(qryCustomers);qryCustomers.FieldByName('BillStreet').AsString   := Street.Text;
    EditDB(qryCustomers);qryCustomers.FieldByName('BillStreet2').AsString  := Street2.Text;
    EditDB(qryCustomers);qryCustomers.FieldByName('BillStreet3').AsString  := Street3.Text;
    EditDB(qryCustomers);qryCustomers.FieldByName('BillSuburb').AsString   := Suburb.Text;
    EditDB(qryCustomers);qryCustomers.FieldByName('BillState').AsString    := State.Text;
    EditDB(qryCustomers);qryCustomers.FieldByName('BillPostCode').AsString := PostCode.Text;
    EditDB(qryCustomers);qryCustomers.FieldByName('BillCountry').AsString  := Country.Text;
  end;
end;

procedure TfrmCustomer.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
      cmdNew.Enabled := false; //Stops Click Twice
      if not CustomerSaved then exit;

      CommitTransaction;
      fsNewCompanyName := Company.Text;
      Notify;
      SetRelatedChildID(qryCustomers);
      CommitTransaction;

      BeginTransaction;
      TabCtl20.ActivePage := TTabSheet(Customer_Info);
      KeyID := 0;
      cmdNew.Enabled := True;
      cmdOk.enabled := True;
      btnSupplier.enabled := True;
      fsNewCompanyName := '';
      FormShow(nil);
  finally
    EnableForm;
  end;
end;

procedure TfrmCustomer.GetDiscounts;
begin
  edtDisc.Text := FloatToStrF(qryCustomers.FieldByName('Discount').AsFloat * 100, ffGeneral, 5, 2);
  edtSpecDisc.Text := FloatToStrF(qryCustomers.FieldByName('SpecialDiscount').AsFloat * 100, ffGeneral, 5, 2);
end;

function TfrmCustomer.GetKeyString: string;
begin
  if qryCustomers.Active then
    result:= qryCustomersPrintname.AsString
  else
    result:= '';
end;

procedure TfrmCustomer.cmdOkClick(Sender: TObject);
begin
  DisableForm;
  try
    try
      cmdOk.Enabled := false; //Stops Click Twice
      if not CustomerSaved then exit;

      CommitTransaction;
      fsNewCompanyName := Company.Text;
      SetRelatedChildID(qryCustomers);
      CommitTransaction;
    except
      on E: Exception do raise;
    end;
    KeyId := qryCustomersClientId.AsInteger;
    fbSaveClicked := true;
    Notify(false);

    if fsModal in FormState then begin
      ModalResult := mrOk;
    end else begin
      Self.Close;
    end;
  finally
    cmdOk.Enabled := true;
    EnableForm;
  end;
end;

procedure TfrmCustomer.cmdCancelClick(Sender: TObject);
begin
  DisableForm;
  try
    (*RollbackTransaction;
    cmdCancel.Enabled := false; //Stops Click Twice
    Notify(true);*)
    if fsmodal in formstate then modalresult := mrCancel
    else Self.Close;
  finally
    EnableForm;
  end;
end;

procedure TfrmCustomer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ShowWindow(Handle, SW_HIDE);
  Self.Enabled := false;
  closeDB(qryReferrals); // Added For Bug on Clicking X top right of form kills Lookup fields on Query.Close
  CloseQueries;
  Action := caFree;
  inherited;
//  frmCustomer := nil;
end;
procedure TfrmCustomer.FormShow(Sender: TObject);
var
  x: integer;
  POSIsActive: boolean;
begin
  DisableForm;
  try
    try
      self.AddFlag('FormInitialising');
      try
        inherited;
        if qryCustomers.Active then begin
          if not (qryCustomers.State in [dsBrowse]) then begin
            PostDB(qryCustomers);
            Notify;
          end;
          CloseQueries;
        end;
        Customerobj.Load(KeyID);
        //qryCustomers.ParamByName('CusID').asInteger := KeyID;

        Qryclients_eParcel.ParamByName('CusID').asInteger := KeyID;


        opendb(qryForeignCurrency);

        qryOpeningPoints.ParamByName('CusID').asInteger := KeyID;
        qryDocuments.ParamByName('CusID').asInteger := KeyID;
        qrySpecials.ParamByName('CusID').asInteger := KeyID;
        qryReferrals.ParamByName('xClientID').asInteger := KeyID;
        tbOtherFollowUp.ParamByName('xClientID').asInteger := KeyID;
        qryRelatedClients.ParamByName('ID').asInteger := KeyID;
        cboClientLookup.Params.ParamByName('ID').AsInteger   := KeyID;
        qryTaxExceptionProducts.ParamByName('xClientID').asInteger := KeyID;
        qryCustomershippingoptions.ParamByName('xClientID').asInteger := KeyID;
        qryContactSelector.ParamByName('xClientID').asInteger := KeyID;


        qryMediaType.Connection:= CommonDbLib.GetSharedMyDacConnection;

        //OpenQueries ;
        if Self.AccessLevel < 6 then begin
          if TabCtl20.ActivePage <> TTabSheet(Customer_Info) then begin
            TabCtl20.ActivePage := TTabSheet(Customer_Info);
            TabCtl20Change(Sender);
          end;
        end;

        {Moved alot of the Open Query statements to On Tab Change Event
         to Speed Up at Start}
        opendb(cboAccountQry);
        opendb(qryCustomers);
        closedb(qryTaxCodes);
        opendb(qryTaxCodes);
        qryClientTypes.Connection:= CommonDbLib.GetSharedMyDacConnection;
        opendb(qryClientTypes);
        opendb(qryEmployees);
        opendb(qryOpeningPoints);
        opendb(qrySpecials);
        opendb(QryareaCodes);
        EditNoAbort(qrySpecials);
        opendb(qryTaxExceptionProducts);
        opendb(qryCustomershippingoptions);
        opendb(Qryclients_eParcel);
        opendb(QryCreditcardtypes);
        opendb(QryARAccounts);
        opendb(QryUOM);

//        opendb(qryContacts);
        opendb(qryContactNames);
        openDB(qryContactSelector);
        if Sender <> nil then
          LoadContactSelector;

        tbOtherFollowUp.Connection := MyConnection;
        opendb(tbOtherFollowUp);
        opendb(qryPayMethod);

        fbSaveClicked := false;
        fbIsModified  := false;
        BeginTransaction;

        SetProdColumQry(QryProductGroupcol1 , 1);
        SetProdColumQry(QryProductGroupcol2,2);
        SetProdColumQry(QryProductGroupcol3,3);

        if KeyID = 0 then begin
          bNewCust := true;
          btnPriceList.Enabled := false;
          btnInvoice.Enabled := false;
          btnQuote.Enabled := false;
          btnSalesOrder.Enabled := false;
//          qryCustomers.Insert;
          Customerobj.New;
          EditDb(qryCustomers);
          if fsNewCompanyName <> '' then begin
            try
            EditDb(qryCustomers);
            qryCustomers.FieldByName('Company').AsString := fsNewCompanyName;
            PostDb(qryCustomers);
            Except
              // ignore exception
            end;
          end;
          EditDb(qryCustomers);
          KeyID:=qryCustomersClientID.asInteger;

          SetDefaults;
          Self.Company.ReadOnly := false;


          grdProdGroupDiscs.Enabled := false; // Disable grid until a customer has actually been saved.
          grdReferrals.Enabled := false; // Disable grid until a customer has actually been saved.
          lblReferralsWarning.Visible := true;
          NoLockSource := true;
        end else begin
          if (not(CanModifySource)) then begin
            cboMediaType.Enabled := false;
            cboMediaType.ReadOnly := true;
          end;
          if NoLockSource then begin
            cboMediaType.Enabled := true;
            cboMediaType.ReadOnly := false;
          end;
          bNewCust := false;
          grdProdGroupDiscs.Enabled := true;
          lblReferralsWarning.Visible := false;

          if EditNoAbort(qryCustomers) then begin
            qryCustomersEditedFlag.AsString := 'T';
          end;

          Self.Company.ReadOnly := true;

        end;
        opendb(QryShippingAddressmain);
        if IsRelatedChild(KeyID) then begin
          if not lblChildmessage.Visible then begin
            grdRelatedClient.ReadOnly := true;
            grdRelatedClient.Enabled := false;
            wwIButton1.Enabled := false;
            grdRelatedClient.Height:=  grdRelatedClient.Height - Trunc(lblChildmessage.Height * 1.2);
            lblChildmessage.Visible := true;
            lblChildmessage.Caption := '( Sub Related Customer of  " ' +
              GetClientName(qryCustomersParentRelatedClientID.AsInteger) + ' " )';
            lblChildmessage.hint := 'Double Click to view details of : ' + GetClientName(qryCustomersParentRelatedClientID.AsInteger);
          end;
        end else begin
          if lblChildmessage.Visible then begin
            grdRelatedClient.ReadOnly := false;
            grdRelatedClient.Enabled := true;
            wwIButton1.Enabled := true;
            grdRelatedClient.Height:=  grdRelatedClient.Height + Trunc(lblChildmessage.Height * 1.2);
            lblChildmessage.Visible := false;
            lblChildmessage.Caption := '';
            lblChildmessage.hint := '';
          end;
        end;

        if qryCustomersRequired.AsBoolean then begin
          chkActive.Enabled := false;
        end;

        Notes.Enabled := IsOkToSave;

        if (CanSeeCreditCards) then begin
          txtCardNumber.Enabled := true;
          txtCardNumber.ReadOnly := false;
          txtCardNumber.PasswordChar := #0;
        end else begin
          txtCardNumber.Enabled := false;
          txtCardNumber.ReadOnly := true;
          txtCardNumber.PasswordChar := '*';
        end;

        // Set our cardnumber box the card number.
        txtCardNumber.text :=  DecryptCreditCardNumber(qryCustomers.FieldByName('CreditCardNumber').AsString);


        {the active cehck box should be disabled when it is required custoemr - eg: cash Custoemr
         or when the use doesn;t have the write access}
        //chkActive.Enabled := (AccessLevel = 1)
        chkActive.Enabled := ((AccessLevel = 1) and (qryCustomersRequired.AsBoolean = false));

        edtSpecDisc.Text := FloatToStrF(StrValue(edtSpecDisc.Text), ffFixed, 7, 2) + ' %';
        edtDisc.Text     := FloatToStrF(qrycustomersDiscount.asFloat* 100, ffFixed, 7, 2) + ' %';
//        grdContactRowChanged(Sender);
        TabCtl20.ActivePage := TTabSheet(Customer_Info);
        pgCustomFields.ActivePage := TTabSheet(tabCustomFields);

        grdProdGroupDiscs.Enabled := true;
        grdReferrals.Enabled        := true;
        lblReferralsWarning.Visible := false;

        CustomFieldsRefresh;
        //SetControlFocus(Company);

        MiscPageControl.ActivePage := TTabSheet(tabFollowUp);

        if (Self.CallingClassName = 'TfrmCustomerJobFollowupList') then begin
          TabCtl20.ActivePage := TTabSheet(tabReferrals);
          MiscPageControl.ActivePage := TTabSheet(tabFollowUp);
          TabCtl20Change(TabCtl20);
        end;


        { When adding a new customer from POS (via cust list) all open forms are
          returning to their normal window state (ie they are no longer wsMaximised)
          and the customer form is getting lost ... so we need to make sure all
          forms are maximised and bring the cust form to the front. }
        {Have we come from pos (ie POS screen active) }
        POSIsActive:= false;
        for x:= 0 to Application.MainForm.MDIChildCount -1 do begin
          if Application.MainForm.MDIChildren[x].ClassNameIs('TPOSScreenForm') then begin
            POSIsActive:= true;
            Break;
          end;
        end;

        SetGUIControllStates;

        if POSIsActive then begin
          self.DisableAlign;
          try
            for x:= 0 to Application.MainForm.MDIChildCount -1 do begin
              if Application.MainForm.MDIChildren[x].WindowState <> wsMaximized then
                Application.MainForm.MDIChildren[x].WindowState:= wsMaximized;
            end;
            self.BringToFront;
          finally
            self.EnableAlign;
          end;
        end;

        btnValidatePhysical.Enabled :=  AccessLevel < 3;
        btnValidateBill.Enabled :=  AccessLevel < 3;

        cboClientType.readonly := not(AppEnv.AccessLevels.GetEmployeeAccessLevel('FnChangeCustomerType') in [1, 2]);
        if (cboClientType.readonly) then
          ShowControlhint(cboClientType, 'You don''t have enough access to change the Customer Type');


      finally

        self.RemoveFlag('FormInitialising');

      end;

    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;
  finally
    Setcontrolfocus(edtPrintName);
    RealignTabControl(TabCtl20, 2);
    RealignTabControl(MiscPageControl, 1);
    RealignTabControl(PageAddress, 1);
    RealignTabControl(pgCustomFields, 1);
    if RegotoAdd <> '' then begin
      newRego(RegotoAdd);
    end else if EquipmenttoAdd <> '' then begin
      newEquip(EquipmenttoAdd);
    end else if fDefaultTab ='Equipment' then begin
      TabCtl20.ActivePage:= tabEquip;
      TabCtl20Change(TabCtl20);
    end;
    EnableForm;
  end;
end;

procedure TfrmCustomer.SetDefaults;
begin
  qryCustomers.FieldByName('Customer').AsString := 'T';
  qryCustomers.FieldByName('TermsID').AsInteger := AppEnv.CompanyPrefs.CreditTermsID;
  qryCustomers.FieldByName('CreditLimit').AsCurrency := AppEnv.CompanyPrefs.CreditLimit;
  qryCustomers.FieldByName('GracePeriod').AsInteger := AppEnv.CompanyPrefs.GracePeriod;
  qryCustomers.FieldByName('CreationDate').AsDateTime := Now;
  chkActive.Checked := true;
  chkDontContact.Checked := false;
end;

procedure TfrmCustomer.SetGUIControllStates;
begin
  if self.qryCustomersActive.AsBoolean then begin
    btnInvoice.Enabled := TRue;
    btnSalesOrder.Enabled := TRue;
    btnQuote.Enabled := TRue;
  end
  else begin
    btnInvoice.Enabled := False;
    btnSalesOrder.Enabled := False;
    btnQuote.Enabled := False;
  end;
end;

procedure TfrmCustomer.SetKeyString(const Value: string);
begin
  SetKeyString(TCustomer, Qrycustomers, Value , 'Printname');
  (*if qryCustomers.Active then
      if qryCustomersCompany.AsString <> Value then qryCustomersCompany.AsString:= Value;
  if KeyID = 0 then
    KeyId:= TCustomer.IDToggle(Value);*)
end;
(*var
  fid:Integer;
begin
  fid:= TCustomer.IDToggle(Value);
  if (KeyId = fid) AND (fid<>0)  then exit;

  if (qryCustomers.Active)  then begin
    if not SaveOrCancelChanges then begin
      MessageDlgXP_Vista('Another Customer is Already Opened. Please Save/Cancel it to Open '+Value, mtWarning, [mbOK], 0);
      exit;
    end;
  end;
  if KeyId <> fid then KeyID := fid;
  if (KeyId =0) and (qryCustomers.Active) then
    qryCustomers.fieldbyname('Company').AsString:= Value;
end;*)


class procedure TfrmCustomer.CloseMe;
begin
  if FormStillOpen('TfrmCustomer') then begin
    TfrmCustomer(FindExistingComponent('TfrmCustomer')).Close;
    Application.ProcessMessages;
  end;
end;

procedure TfrmCustomer.TabCtl20Change(Sender: TObject);
begin
  inherited;
  if (TabCtl20.ActivePage = TTabSheet(tabAttachments))   then
      if not CanShowCustomerAttachments then begin
         TabCtl20.ActivePage := TabCtl20CurTab;
         MessageDlgXP_Vista('You Don''t Have Access to View the Attachments', mtWarning, [mbOK], 0);
         Exit;
      end;

  //Save Before Changing Tabs (They Need KeyID !)
  if bNewCust then begin
    if Company.Text = '' then begin
      CommonLib.MessageDlgXP_Vista('Please enter a Company Name (or First and Last Names) before selecting  advanced ' +
        #13 + #10 + 'features.', mtWarning, [mbOK], 0);
      TabCtl20.ActivePage := TTabSheet(Customer_Info);
      SetControlFocus(Company);
      Exit;
    end else begin
      if PreSaveCustomer = false then begin
        Exit;
      end;
    end;
  end;

//  SetCustomerToContact;

  if (TabCtl20.ActivePage = TTabSheet(General)) then
    OnTabGeneral(Sender)
  else if (TabCtl20.ActivePage = TTabSheet(tabAccounts)) then
    OnTabAccounts(Sender)
  else if TabCtl20.ActivePage = TTabSheet(Address_Info) then begin
    opendb(cboClassQry);
    PostDB(qryCustomers);
  end else if TabCtl20.ActivePage = TTabSheet(History) then
    OnTabHistory(Sender)
  else if TabCtl20.ActivePage = TTabSheet(Custom_Fields) then
    CustomFieldsRefresh
  else if TabCtl20.ActivePage = TTabSheet(tabReferrals) then
    OnTabReferrals(Sender)
  else if TabCtl20.ActivePage = TTabSheet(Documents) then begin
    opendb(qryDocPath);
    CloseDB(qryDocuments);
    qryDocuments.ParamByName('CusID').asInteger := KeyID;
    opendb(qryDocuments);
  end else if TabCtl20.ActivePage = TTabSheet(tabContacts) then
    OnTabContacts(Sender)
  else if TabCtl20.ActivePage = TTabSheet(tabEquip) then begin
    if Equipmentform = nil then begin
      Equipmentform:= TfmClientEquipment.Newform(KeyID, self.Myconnection, self, CustEquipDNMPanel,UpdatefromEquipment);
    end;
  end else if TabCtl20.ActivePage = TTabSheet(SpecialProds) then
    OnTabSpecialProds(Sender);
end;

procedure TfrmCustomer.SuburboldCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  State.Text := LookupTable.FieldByName('State').AsString;
  Postcode.Text := LookupTable.FieldByName('Postcode').AsString;
end;

procedure TfrmCustomer.BillSuburboldCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  BillState.Text := LookupTable.FieldByName('State').AsString;
  BillPostcode.Text := LookupTable.FieldByName('Postcode').AsString;
end;



function TfrmCustomer.CustomFieldExtenderListtype: TListType;
begin
  Result := ltCustomer;
end;

procedure TfrmCustomer.CustomFieldsRefresh;
begin
  CustomFieldRefresh('CFCust' ,pnlCustFldsFixed);
end;

procedure TfrmCustomer.DBCheckBox1Click(Sender: TObject);
begin
  inherited;
  if not TDBCheckBox(Sender).Focused then exit;
  if TDbCheckBox(Sender).Checked then begin
    if not AppEnv.UtilsClient.LicenceOptionEnabled('CustomerEmailXML') then begin
      TDbCheckBox(Sender).Checked := false;
      DialogLicenceOptionNotEnabled;
    end;
  end;
end;

procedure TfrmCustomer.DBCheckBox2Click(Sender: TObject);
begin
  inherited;
  if not TDBCheckBox(Sender).Focused then exit;
  if TDbCheckBox(Sender).Checked then begin
    if not AppEnv.UtilsClient.LicenceOptionEnabled('CustomerFTPXML') then begin
      TDbCheckBox(Sender).Checked := false;
      DialogLicenceOptionNotEnabled;
    end;
  end;
end;

procedure TfrmCustomer.DBCheckBox3Click(Sender: TObject);
begin
  inherited;
  if not TDBCheckBox(Sender).Focused then exit;
  if TDbCheckBox(Sender).Checked then begin
    if not AppEnv.UtilsClient.LicenceOptionEnabled('CustomerFTPXML') then begin
      TDbCheckBox(Sender).Checked := false;
      DialogLicenceOptionNotEnabled;
    end;
  end;

end;


procedure TfrmCustomer.delTaxExceptionProductsClick(Sender: TObject);
begin
  inherited;
  editDB(qryTaxExceptionProducts);
  qryTaxExceptionProductsActive.AsBoolean := False;
  PostDB(qryTaxExceptionProducts);
end;

procedure TfrmCustomer.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  OpenErpListform('TNotesAuditTrailListGUI' , BeforeShowNotesAuditTrailList);
end;
procedure TfrmCustomer.DNMSpeedButton2Click(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TSalesAddressLabelPrnGUI' , initSalesAddressLabelPrn);
end;
procedure TfrmCustomer.btnClearCreditCardDetailsClick(Sender: TObject);
begin
  inherited;
  EditDB(qryCustomers);qryCustomersCreditCardType.asString      := '';
  EditDB(qryCustomers);qryCustomersCreditCardCardHolderName.asString      := '';
  EditDB(qryCustomers);txtCardNumber.text := '';
  EditDB(qryCustomers);qryCustomersCreditCardNumber.asString    := '';
  EditDB(qryCustomers);qryCustomersCreditCardExpiryDate.asString:= '';
  EditDB(qryCustomers);qryCustomersCreditCardCVC.asString       := '';
  EditDB(qryCustomers);qryCustomersCreditCardNotes.asString     := '';
  PostDB(qryCustomers);
end;

procedure TfrmCustomer.initSalesAddressLabelPrn(Sender: TObject);
begin
  if not(sender is TSalesAddressLabelPrnGUI) then exit;
  TSalesAddressLabelPrnGUI(Sender).CustomerID := qryCustomersClientID.AsInteger;
end;

procedure TfrmCustomer.BeforeShowNotesAuditTrailList(Sender: TObject);
begin
  if not(Sender is TNotesAuditTrailListGUI) then exit;
  TNotesAuditTrailListGUI(Sender).CustomerId := qryCustomersClientID.asInteger;
end;

procedure TfrmCustomer.DoBusinessObjectEvent(const Sender: TDatasetBusObj;
  const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TCustomer then
      TCustomer(Sender).Dataset:= qryCustomers
    else if Sender is TCoreEDIConfig then
      TCoreEDIConfig(Sender).Dataset:= qryCoreEDIConfig

  end
  else if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEventDataset_dataIdchange_dcLoad ) then begin

  end;

end;

procedure TfrmCustomer.DoCustomerListBeforeShow(Sender: TObject);
begin
  TBaseListingGUI(Sender).OnGridDataSelect := CustomerGridDataSelect;
  TBaseListingGUI(Sender).FilterString := 'CompanyName <> "' + self.qryCustomersCompany.AsString + '"';
end;

procedure TfrmCustomer.DoOnAfterListPopupFormShow(ListForm: TBaseListingGUI; PopupForm: TBaseInputGUI);
begin
  StateParams:= FormReopenerObj.FormReopenerList.Add(self.ClassName, PopupForm).Params;
  StateParams.I['KeyID']:= self.qryCustomersClientID.AsInteger;
  StateParams.I['TabControlActivePageIndex']:= TabCtl20.ActivePageIndex;
  if TabCtl20.ActivePage = History then begin
    StateParams.I['grpHistoryItemIndex']:= grpHistory.ItemIndex;
    if Assigned(HistoryListform) then begin
      StateParams.F['DateFrom']:= HistoryListForm.dtFrom.DateTime;
      StateParams.F['DateTo']:= HistoryListForm.dtTo.DateTime;
    end;
  end;
  BringToFront;
  { try and close the customer form }
  if CustomerSaved then begin
    CommitTransaction;
    fbSaveClicked:= True;
    Close;
  end;

end;

procedure TfrmCustomer.DoOnCheckForEmailsProgress(const msg: string;
  var Continue: boolean);
begin
  if Assigned(MailProgesss) then begin
    MailProgesss.Message := msg;
    MailProgesss.StepIt;
    Continue := not ProgressCanceled;
  end;
end;

procedure TfrmCustomer.DoOnGetMessageCount(const MessageCount: integer);
begin
  MailProgesss.MaxValue := MessageCount;
end;

procedure TfrmCustomer.DoOnProgressCancel(Sender: TObject);
begin
  ProgressCanceled := true;
end;

procedure TfrmCustomer.cmdCustomLabelsOldClick(Sender: TObject);
begin
  OpenCustomFields;
(*Var Form : TComponent;
begin
  DisableForm;
  try
    Form := GetComponentByClassName('TfrmCustomFields');
    if Assigned(Form) then begin
      with TfrmCustomFields(Form) do begin
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;*)
end;

procedure TfrmCustomer.FormActivate(Sender: TObject);
begin
  if not fbNoAccess then begin
    inherited;
  end;
end;

procedure TfrmCustomer.grpHistoryClick(Sender: TObject);
var
  iIndex: integer;
begin
  try
    inherited;
    HistoryListform := nil;
    pnlHistory.Font.Size := 9;
    try
      try
        PostDB(qryCustomers); // to geenrate the ID for lists
        case grpHistory.ItemIndex of
          0: HistoryListform := ListAppoints;
          1: HistoryListform := ListArNotes;
          2: HistoryListform := ListInvoices;
          3: HistoryListform := ListJobprofit;
          4: HistoryListform := ListJobs;
          5: HistoryListform := ListProductSales;
          6: HistoryListform := ListQuotes;
          7: HistoryListform := RepairsList;
          8: HistoryListform := RewardPointList;
          9: HistoryListform := SalesOrderList;
         10: HistoryListform := StatementsList;
         11: HistoryListform := TimesheetList;
         12: HistoryListform := NonERPSalesList;
         13: HistoryListform := cleintHRFormsList;
        end;

        if Assigned(HistoryListform) then begin
          HistoryListForm.OnAfterPopupFormShow:= DoOnAfterListPopupFormShow;
          grpHistory.Color := HistoryListform.pnlHeader.Color;
          HistoryListform.Parent := pnlHistory;
          HistoryListform.align := alclient;
          HistoryListform.BorderStyle := bsNone;
          HistoryListform.fbIgnoreQuerySpeed := true;
          try
            HistoryListform.Show;

            if  HistoryListform = fListcleintHRForms then begin
              TclientHRFormsGUI(fListcleintHRForms).btnNewHrform.Width := 90;
              TclientHRFormsGUI(fListcleintHRForms).btnNewHrform.Top := 0;
              TclientHRFormsGUI(fListcleintHRForms).Centralisebuttons(TclientHRFormsGUI(fListcleintHRForms).pnlNewHrform);
              TclientHRFormsGUI(fListcleintHRForms).referenceID :=qryCustomersClientID.asInteger;
            end;

          except
            FreeAndNil(HistoryListform);
          end;
          // Show Print & Export
          for iIndex := 0 to HistoryListform.FooterPanel.ControlCount - 1 do begin
            if HistoryListform.FooterPanel.Controls[iIndex] is TControl then begin
              TControl(HistoryListform.FooterPanel.Controls[iIndex]).Visible := false;
            end;
            if HistoryListform.ClassNameIs('TInvoiceListGUI') then begin
              TInvoiceListGUI(HistoryListform).btnDelete.Visible := false
            end;
          end;
          HistoryListform.FooterPanel.Height         := 30;
          HistoryListform.cmdExport.Top              := 1;
          HistoryListform.cmdExport.Left             := 100;
          HistoryListform.cmdExport.Visible          := true;
          HistoryListform.cmdPrint.Top               := 1;
          HistoryListform.cmdPrint.Left              := pnlHistory.Width - 200;
          HistoryListform.cmdPrint.Visible           := true;
          HistoryListform.FooterPanel.Visible        := true;
          HistoryListform.grpFilters.Visible         := true;
          HistoryListform.pnlButtons.Visible         := true;
          HistoryListform.grdMain.PopupMenu          := HistoryListform.mnuFilter;
          HistoryListform.grdMain.Align              := alClient;
(*          HistoryListform.lblcustomReport.Visible    := False;
          HistoryListform.cboCustomReports.Visible   := False;*)



          if HistoryListform.ClassNameIs('TInvoiceListGUI') then begin
            TInvoiceListGUI(HistoryListform).btnDelete.Visible := false;
            TInvoiceListGUI(HistoryListform).chkIgnoreDates.Checked := false;
            TInvoiceListGUI(HistoryListform).chkIgnoreDates.Visible := false;
          end;

          if HistoryListform.ClassNameIs('TSalesOrderListGUI') then begin
            TSalesOrderListGUI(HistoryListform).chkIgnoreDates.Checked := false;
            TSalesOrderListGUI(HistoryListform).chkIgnoreDates.Visible := false;
          end;

          if HistoryListform.ClassNameIs('TJobProfitabilityforCustomerGUI') then begin
            TJobProfitabilityforCustomerGUI(HistoryListform).chkAllClients.Visible := false;
            TJobProfitabilityforCustomerGUI(HistoryListform).ClientId := KeyId; // set also ckAlClients.checked = false
            TJobProfitabilityforCustomerGUI(HistoryListform).Label4.Visible := false;
            TJobProfitabilityforCustomerGUI(HistoryListform).Label5.Visible := false;
            TJobProfitabilityforCustomerGUI(HistoryListform).cboClients.Visible := false;
            TJobProfitabilityforCustomerGUI(HistoryListform).cboClass.Visible := false;

          end;

          if HistoryListForm is TStatementListGUI then begin
            TStatementListGUI(HistoryListForm).grpFilters.ItemIndex := 2;
            //TStatementListGUI(HistoryListForm).grpFilters.Click;
          end;
          HistoryListform.Refresh;
        end else begin
          if Assigned(fListStatements) then begin
            fListStatements.Parent := nil;
            fListStatements.Hide;
          end;

          if Assigned(fListAppoints) then begin
            fListAppoints.Parent := nil;
            fListAppoints.Hide;
          end;

          if Assigned(fRepairList) then begin
              fRepairList.Parent := nil;
              fRepairList.Hide;
          end;
          if Assigned(fListSalesOrder) then begin
            fListSalesOrder.Parent := nil;
            fListSalesOrder.Hide;
          end;

          if Assigned(fListQuotes) then begin
            fListQuotes.Parent := nil;
            fListQuotes.Hide;
          end;

          if Assigned(fListInvoices) then begin
            fListInvoices.Parent := nil;
            fListInvoices.Hide;
          end;

          if Assigned(fRewardPoints) then begin
            fRewardPoints.Parent := nil;
            fRewardPoints.Hide;
          end;

          if Assigned(fListJobprofit) then begin
            fListJobprofit.Parent := nil;
            fListJobprofit.Hide;
          end;

          if Assigned(fListTimesheet) then begin
            fListTimesheet.Parent := nil;
            fListTimesheet.Hide;
          end;
          if Assigned(fListNonERPSales) then begin
            fListNonERPSales.Parent := nil;
            fListNonERPSales.Hide;
          end;
          if Assigned(fListcleintHRForms) then begin
            fListcleintHRForms.Parent := nil;
            fListcleintHRForms.Hide;
          end;

          if Assigned(fListProductSales) then begin
            fListProductSales.Parent := nil;
            fListProductSales.Hide;
          end;

          if Assigned(fListJobs) then begin
            fListJobs.Parent := nil;
            fListJobs.Hide;
          end;

          if Assigned(fListArNotes) then begin
            fListArNotes.Parent := nil;
            fListArNotes.Hide;
          end;

          pnlHistory.Font.Size := 15;
          //pnlHistory.Caption := 'ACCESS TO THIS PANEL IS RESTRICTED!';
          pnlHistory.Caption := 'YOU DO NOT HAVE ACCESS TO THIS REPORT!';
          pnlHistory.Paint;
        end;

      except
        on EAbort do HandleEAbortException;
        on e: ENoAccess do HandleNoAccessException(e);
        else raise;
      end;
    finally
//      AppEnv.Employee.ShowQuerySpeedNotification := TempShowQuerySpeedNotification;
    end;
  finally
    EnableForm;
  end;
end;


procedure TfrmCustomer.HtmlViewerHotSpotClick(Sender: TObject;
  const SRC: string; var Handled: Boolean);
begin
  inherited;
  if SameText(self.qryDocumentsType.AsString,'Voice') then
    SMSUtilsGui.PlayMessages(SRC)
  else
    ShellExecute(0,'open',PChar(SRC),nil,nil,SW_NORMAL);
end;

procedure TfrmCustomer.HtmlViewerImageRequest(Sender: TObject;
  const SRC: string; var Stream: TStream);
var
  MessageId: string;
  HTTP: TIdHTTP;
  x: integer;
begin
  inherited;
  Stream := nil;
  HTMLImageStream.Clear;
  if Assigned(SelectedMail) then begin
    if Pos('cid:',LowerCase(SRC)) = 1 then begin
      { looking for content id from part of this message }
      MessageId := Copy(SRC,5,Length(SRC));

      for x := 0 to SelectedMail.MessageParts.Count -1 do begin
        if Pos(MessageId, SelectedMail.MessageParts[x].ContentID) > 0 then begin
          if SelectedMail.MessageParts[x] is TIdAttachmentFile then begin
            TIdAttachmentFile(SelectedMail.MessageParts[x]).SaveToStream(HTMLImageStream);
            HTMLImageStream.Position := 0;
            Stream := HTMLImageStream;
          end;
          break;
        end;
      end;
    end
    else if Pos('http',LowerCase(SRC)) = 1 then begin
      { external image request }
      HTTP:= TIDHTTP.Create(nil);
      try
        HTTP.Request.UserAgent := HTTPConst.TrueERPUserAgent;
        HTTP.Get(SRC,HTMLImageStream);
        try
          HTMLImageStream.Position := 0;
          if HTMLImageStream.Size > 0 then
            Stream := HTMLImageStream;
        except

        end;
      finally
        HTTP.Free;
      end;
    end;
  end;
end;

procedure TfrmCustomer.FormDestroy(Sender: TObject);
begin
  Notify; {Needed For TBaseTransGUI cboClientNotInList}
  Freeandnil(EquipmentForm);
  HTMLImageStream.Free;
  FileAssociationDetails.Free;
  //////// FreeAndNil(FCustomerContactListForm);
//  Spelling.AddictSpell.RemoveControl(Notes);
  inherited;
end;

{}
procedure TfrmCustomer.EditbtnClick(Sender: TObject);
begin
  DisableForm;
  try
    // If the contact is blank then we will bypass the double left click.
//    if qryContacts.FieldByName('ContactID').AsInteger = 0 then Exit;
    Callcontactform(EditBtn);
  finally
    EnableForm;
  end;
end;

procedure TfrmCustomer.cmdNewContactClick(Sender: TObject);
begin
  DisableForm;
  try
    Callcontactform(cmdNew);
  finally
    EnableForm;
  end;
end;

Function TfrmCustomer.MakeNewcontactIfNone:Boolean;
begin

  if (CustomerContactCount(0) > 0) or (ContactCreated) then begin
    Result := true;
    exit;
  end;

  TABCtl20.ActivePage := tabContacts;
  TabCtl20Change(TabCtl20);
//  SetControlFocus(fin);
  cmdNewContactClick(cmdNewContact);
  Result := ContactCReated; //CustomerContactListForm.qryMain.RecordCount > 0;
end;

procedure TfrmCustomer.MiscPageControlChange(Sender: TObject);
begin
  inherited;
  if MiscPageControl.activepage = tabAusEParcel then
    Makecustomer_eParcelRec;
end;

procedure TfrmCustomer.MiscPageControlChanging(Sender: TObject; var AllowChange: Boolean);
begin
  inherited;
  if MiscPageControl.activepage = tabAusEParcel then
    PostDB(Qryclients_eParcel)
  else if MiscPageControl.ActivePage = tabFollowUp then
  begin
    LoadContactSelector;
  end;

end;

(*function TfrmCustomer.Newcustomer: boolean;
begin
  if keyId =0 then
  begin
    REsult := True;
    Exit;
  end;

  with tempMyQuery do
  try
    SQL.add('select ClientId,company from tblclients where clientId = ' +inttostr(KeyId));
    open;
    result := recordcount=0;
  finally
    closenFree;
  end;
end;*)

procedure TfrmCustomer.LetterbtnClick(Sender: TObject);
begin
  if Accesslevel >= 5 then
    Exit;

  PostDB(qryCustomers);
  EditDB(qryCustomers);
  CustContactCreateCorrespondence(ctLetter, self, SelectedContactCompany);//qryCustomerscompany.AsString);
end;

procedure TfrmCustomer.FaxBtnClick(Sender: TObject);
begin
  if Accesslevel >= 5 then
    Exit;

  PostDB(qryCustomers);
  EditDB(qryCustomers);
  CustContactCreateCorrespondence(ctFax, self, SelectedContactCompany);//qryCustomerscompany.AsString);
end;

procedure TfrmCustomer.EmailbtnClick(Sender: TObject);
begin
  if SelectedContactEmail = '' then
    if CommonLib.MessageDlgXP_Vista('The contact ' + SelectedContactCompany +
        ' does not have an email address.'#13#10'Do you wish to load the email program anyway?',
        mtConfirmation, [mbYes, mbNo], 0)  = mrNo then
        Exit;

  if Accesslevel >= 5 then
    Exit;
  PostDB(qryCustomers);
  EditDB(qryCustomers);

  CustContactCreateCorrespondence(tcTypes.ctEmail, self, SelectedContactCompany); //qryCustomerscompany.AsString);

end;

procedure TfrmCustomer.btnSupplierClick(Sender: TObject);
//var
//  cmd: TERPCommand;
begin
  inherited;
  if qryCustomers.FieldByName('Supplier').asBoolean then begin
    MessageDlgXP_Vista(trim(qryCustomersCompany.AsString) +' is a Supplier as Well', mtInformation, [mbOK], 0);
    Exit;
  end;
  EditDB(qryCustomers);
  qryCustomers.FieldByName('Supplier').AsString := 'T';
  PostDB(qryCustomers);
  MessageDlgXP_Vista(trim(qryCustomersCompany.AsString) +' is Flagged as a Supplier as Well', mtInformation, [mbOK], 0);


//  if qryContacts.RecordCount > 0 then begin
//    cmd:= TERPCommand.Create(nil);
//    try
//      cmd.Connection:= qryContacts.Connection;
//      cmd.SQL.Add('update tblcontacts set SupID = ' + IntToStr(qryCustomersClientID.AsInteger)+', ContactIsSupplier = "T" ');
//      cmd.SQL.Add('where CusId = ' + IntToStr(qryCustomersClientID.AsInteger));
//      cmd.Execute;
//    finally
//      cmd.Free;
//    end;
//  end;
  btnSupplier.Enabled := False;
end;

procedure TfrmCustomer.btnValidatePhysicalClick(Sender: TObject);
var
  fProvider: TibxezaddressProviders;
  val: TShipAddressValidation;
  ShippingProviders: ShippingProviderSet;
begin
  inherited;
  ShippingProviders := [];
//  if AppEnv.CompanyPrefs.UPSConfig.UPSEnabled then
//    fProvider := pUPS
//  else if AppEnv.CompanyPrefs.USPSConfig.USPSEnabled then
//    fProvider := pUSPS
//  else if AppEnv.CompanyPrefs.FedExConfig.FedExEnabled then
//    fProvider := pFedEx
//  else begin
//    MessageDlgXP_Vista('You do not have a Shipping Provider configured in Preferences to use for Address Validation.', mtInformation, [mbOK], 0);
//    exit;
//  end;
  if AppEnv.CompanyPrefs.UPSConfig.UPSEnabled then
    ShippingProviders := ShippingProviders + [pUPS];
  if AppEnv.CompanyPrefs.USPSConfig.USPSEnabled then
    ShippingProviders := ShippingProviders + [pUSPS];
  if AppEnv.CompanyPrefs.FedExConfig.FedExEnabled then
    ShippingProviders := ShippingProviders + [pFedEx];
  if ShippingProviders = [] then begin
    MessageDlgXP_Vista('You do not have a Shipping Provider configured in Preferences to use for Address Validation.', mtInformation, [mbOK], 0);
    exit;
  end;

  val := TShipAddressValidation.Create;
  try
    //Val.Provider := fProvider;
    Val.Providers := ShippingProviders;
    Val.AllowUserSelect := true; //false;
    if Sender = btnValidatePhysical then begin
      Val.Address.AddressLine1 := Street.Text;
      Val.Address.AddressLine2 := Street2.Text;
      Val.Address.AddressLine3 := Street3.Text;
      Val.Address.City := Suburb.Text;
      Val.Address.State := State.Text;
      Val.Address.PostCode := PostCode.Text;
      Val.Address.Country := Country.Text;
    end
    else begin
      { Bill To }
      Val.Address.AddressLine1 := BillStreet.Text;
      Val.Address.AddressLine2 := BillStreet2.Text;
      Val.Address.AddressLine3 := BillStreet3.Text;
      Val.Address.City := BillSuburb.Text;
      Val.Address.State := BillState.Text;
      Val.Address.PostCode := BillPostCode.Text;
      Val.Address.Country := BillCountry.Text;
    end;
    if Val.ValidateAddress then begin
      if Val.Address.Updated then begin
        if Sender = btnValidatePhysical then begin
          EditDB(qryCustomers);
          Street.DataSource.DataSet.FieldByName(Street.DataField).AsString := Val.Address.AddressLine1;
          Street2.DataSource.DataSet.FieldByName(Street2.DataField).AsString := Val.Address.AddressLine2;
          Street3.DataSource.DataSet.FieldByName(Street3.DataField).AsString := Val.Address.AddressLine3;
          Suburb.DataSource.DataSet.FieldByName(Suburb.DataField).AsString := Val.Address.City;
          State.DataSource.DataSet.FieldByName(State.DataField).AsString := Val.Address.State;
          PostCode.DataSource.DataSet.FieldByName(PostCode.DataField).AsString := Val.Address.PostCode;
          Country.DataSource.DataSet.FieldByName(Country.DataField).AsString := Val.Address.Country;
          PostDB(qryCustomers);
        end
        else begin
          { Bill To }
          EditDB(qryCustomers);
          BillStreet.DataSource.DataSet.FieldByName(BillStreet.DataField).AsString := Val.Address.AddressLine1;
          BillStreet2.DataSource.DataSet.FieldByName(BillStreet2.DataField).AsString := Val.Address.AddressLine2;
          BillStreet3.DataSource.DataSet.FieldByName(BillStreet3.DataField).AsString := Val.Address.AddressLine3;
          BillSuburb.DataSource.DataSet.FieldByName(BillSuburb.DataField).AsString := Val.Address.City;
          BillState.DataSource.DataSet.FieldByName(BillState.DataField).AsString := Val.Address.State;
          BillPostCode.DataSource.DataSet.FieldByName(BillPostCode.DataField).AsString := Val.Address.PostCode;
          BillCountry.DataSource.DataSet.FieldByName(BillCountry.DataField).AsString := Val.Address.Country;
          PostDB(qryCustomers);
        end;
        MessageDlgXP_Vista('Address Updated.', mtInformation, [mbOK], 0);
      end
      else begin
        MessageDlgXP_Vista('Address is Valid.', mtInformation, [mbOK], 0);
        if Sender = btnValidatePhysical then begin
          EditDb(qryCustomers);
          self.qryCustomersAddressValid.AsBoolean := true;
          PostDb(qryCustomers);
        end
        else begin
          EditDb(qryCustomers);
          self.qryCustomersBillAddressValid.AsBoolean := true;
          PostDb(qryCustomers);
        end;
      end;
    end
    else begin
      MessageDlgXP_Vista(Val.ErrMessage, mtInformation, [mbOK], 0);
      if Sender = btnValidatePhysical then begin
        EditDb(qryCustomers);
        self.qryCustomersAddressValid.AsBoolean := false;
      end
      else begin
        EditDb(qryCustomers);
        self.qryCustomersBillAddressValid.AsBoolean := false;
      end;
    end;
  finally
    val.Free;
  end;
end;

procedure TfrmCustomer.btnGetEmailsClick(Sender: TObject);
begin
  inherited;
  CheckForEmails;
end;

procedure TfrmCustomer.dsStateChange(Sender: TObject);
begin
  inherited;
  if Sender is TDataSource then
    with Sender as TDataSource do
      if State <> dsBrowse then
        BeginTransaction;
end;

(*
procedure TfrmCustomer.btnInactiveClick(Sender: TObject);
begin
  inherited;
  if qryContacts.recordcount=0 then begin
    MessageDlgXP_Vista(qryCustomersCompany.asString + ' has no contact to delete', mtInformation, [mbOK], 0);
    exit;
  end;
  EditDB(qryContacts);
  qryContacts.FieldByName('Active').AsString := 'F';
  PostDB(qryContacts);
  closenopendb(qryContacts);
end;
*)
procedure TfrmCustomer.chkShowAllClick(Sender: TObject);
begin
  inherited;
  if chkShowAll.Checked then
    CustomerContactListForm.FilterString := ''
  else
    CustomerContactListForm.FilterString := '(Active = "T")'
end;


procedure TfrmCustomer.cboProdCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  AssignComboAccessed(Sender);
  inherited;
end;

procedure TfrmCustomer.grdSpecialsIButtonClick(Sender: TObject);
begin
  inherited;
  DeleteRecord(qrySpecials);
  EditDB(qryCustomers);
  qryCustomers.FieldByName('EditedFlag').AsString := 'T';
  PostDB(qryCustomers);
  EditDB(qryCustomers);
end;

procedure TfrmCustomer.btnNewProdClick(Sender: TObject);
begin
  inherited;
  SetControlFocus(grdSpecials);
  qrySpecials.Last;
  qrySpecials.Append;
end;

procedure TfrmCustomer.grdDocsDblClick(Sender: TObject);
var
  FileNamedocx,FileName: string;
  FileNotFound: boolean;
  sRef: string;
  Form : TComponent;
  IdMessage: TIdMessage;
  Stream: TStream;
begin
  inherited;
  if SameText(qryDocuments.FieldByName('Type').AsString, 'Email') and (qryDocuments.FieldByName('MessageId').AsString <> '') then begin
    { this is an email }
    FileName := SystemLib.GetAppTempDir + '\' + qryDocuments.FieldByName('MessageId').AsString + '.eml';
    IdMessage := TIdMessage.Create;
    try
      Stream := qryDocuments.CreateBlobStream(qryDocuments.FieldByName('ReferenceData'),bmRead);
      try
        IdMessage.LoadFromStream(Stream);
      finally
        Stream.Free;
      end;
      IdMessage.SaveToFile(FileName);
    finally
      IdMessage.Free;
    end;
    ShellExecute(Handle, 'Open', PChar(FileName), '', '', SW_SHOWNORMAL);
    exit;
  end;

  FileNotFound := false;
  sRef := qryDocuments.FieldByName('Reference').AsString;

  if qryDocPath.FieldByName('DocumentPath').AsString <> '' then
    FileName    := ExcludeTrailingPathDelimiter(qryDocPath.FieldByName('DocumentPath').AsString) + '\' + SRef
  else FileName := 'C:\' + SRef;

  if AppEnv.Employee.UseWord then Begin
    FileNamedocx := FileName + '.docx';
    FileName := FileName + '.doc'
  end else
    FileName := FileName + '.RTF';

  if FileExists(FileNamedocx) then
    FileName := FileNamedocx;

  if not FileExists(FileName) then begin
    CommonLib.MessageDlgXP_Vista('Cannot Find File !', mtWarning, [mbOK], 0);
    Exit;
  end;

  if AppEnv.Employee.UseWord then // trying new approach here...
  begin
    if FileExists(FileName) then ShellExecute(Handle, 'Open', PChar(FileName), '', '', SW_SHOWNORMAL)
    else FileNotFound := true;
  end else begin
    if FileExists(FileName) then begin
      Form := GetComponentByClassName('TREMainClient');
      if Assigned(Form) then begin
        with TREMainClient(Form) do begin
          Referencetxt.Text := SRef;
          Edit1.Text := 'True';
          FormStyle := fsMDIChild;
          BringToFront;
        end;
      end;
    end else FileNotFound := true;
  end;

  if FileNotFound then CommonLib.MessageDlgXP_Vista('The file ''' + FileName + ''' does not exist', mtWarning, [mbOK], 0);
end;

procedure TfrmCustomer.grdDocsIButtonClick(Sender: TObject);
begin
  inherited;
  if QryDocuments.FieldByName('Active').asBoolean =False then begin
    MessageDlgXP_Vista('This document is already deleted', mtInformation, [mbOK], 0);
    Exit;
  end;
  if MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
  EditDB(qryDocuments);
  QryDocuments.FieldByName('Active').asBoolean:= False;
  PostDb(qryDocuments);
end;

procedure TfrmCustomer.grdDocsRowChanged(Sender: TObject);
var
  stream: TStream;
  str: string;
  PartContent: TContentType;
  x: integer;
  BodyFound: boolean;
  Item: TListItem;
  ImageIndex: integer;
  SMSMsg: TSMSMessage;
begin
  inherited;
  HTMLViewer.Clear;
  lvAttachments.Clear;
  FileAssociationDetails.Clear;
  lvAttachments.SmallImages := FileAssociationDetails.Images;
  if SameText(qryDocumentsType.AsString,'Email') and (qryDocuments.FieldByName('MessageId').AsString <> '') then begin
    if not Assigned(SelectedMail) then begin
      SelectedMail := TIdMessage.Create(self);
    end;
    Stream := qryDocuments.CreateBlobStream(qryDocuments.FieldByName('ReferenceData'),bmRead);
    try
      SelectedMail.LoadFromStream(Stream);
    finally
      Stream.Free;
    end;

    if SelectedMail.MessageParts.Count > 0 then begin
      BodyFound := false;
      PartContent := TContentType.Create;
      try
        for x := 0 to SelectedMail.MessageParts.Count -1 do begin
          PartContent.AsString := SelectedMail.MessageParts[x].ContentType;
          if SelectedMail.MessageParts[x] is TIdText then begin
            if (PartContent.SubType = 'html') and (not BodyFound) then begin
              BodyFound := true;
              HTMLViewer.LoadFromString(TIdText(SelectedMail.MessageParts[x]).Body.Text);
            end;
          end
          else if SelectedMail.MessageParts[x] is TIdAttachmentFile then begin
            if SelectedMail.MessageParts[x].ContentID = '' then begin
              { does not have a ContentId so is probably a separate attachment (as opposed to a body image attachment) }
              item := lvAttachments.Items.Add;
              item.Caption := TIdAttachmentFile(SelectedMail.MessageParts[x]).FileName;
              item.Data := SelectedMail.MessageParts[x];
            end;
          end
          else if SelectedMail.MessageParts[x] is TIdAttachmentMemory then begin
            if SelectedMail.MessageParts[x].ContentID = '' then begin
              { does not have a ContentId so is probably a separate attachment (as opposed to a body image attachment) }
              item := lvAttachments.Items.Add;
              item.Caption := TIdAttachmentMemory(SelectedMail.MessageParts[x]).FileName;
              item.Data := SelectedMail.MessageParts[x];
            end;
          end;
        end;
      finally
        PartContent.Free;
      end;

    end
    else begin
      { not a multipart message, display body text. }
      { remove illegal characters and replace CR LF with <BR> }
      str := StringReplace(HTTPUtil.HTMLEscape(SelectedMail.Body.Text),#13#10,'<BR>',[rfReplaceAll]);
      str := StringReplace(str,#10#13,'<BR>',[rfReplaceAll]);
      str := StringReplace(str,#10,'<BR>',[rfReplaceAll]);
      str := StringReplace(str,#13,'<BR>',[rfReplaceAll]);

      HTMLViewer.LoadFromString(str);
    end;

  end
  else if SameText(qryDocumentsType.AsString,'SMS') then begin
    FreeAndNil(SelectedMail);
    SMSMsg := TSMSMessage.Create;
    Stream := qryDocuments.CreateBlobStream(qryDocuments.FieldByName('ReferenceData'),bmRead);
    try
      SMSMsg.ReadFromStream(stream);
      HtmlViewer.LoadFromString(SMSMsg.AsHtml);
    finally
      SMSMsg.Free;
      stream.Free;
    end;
  end
  else begin
    FreeAndNil(SelectedMail);
    if SameText(qryDocuments.FieldByName('Type').AsString,'Email') then begin
      HTMLViewer.LoadFromString(EmailConst.EmailContentNotAvailable);
    end;

  end;
  if lvAttachments.Items.Count > 0 then begin
    lvAttachments.Visible := true;
    HTMLViewer.Height := lvAttachments.Top - 3;
    for x := 0 to lvAttachments.Items.Count -1 do begin
      FileAssociationDetails.AddFile(lvAttachments.Items[x].Caption);
    end;
    FileAssociationDetails.GetFileIconsAndDescriptions;
    for x := 0 to lvAttachments.Items.Count -1 do begin
      ImageIndex := FileAssociationDetails.Extensions.IndexOf(ExtractFileExt(lvAttachments.Items[x].Caption));
      lvAttachments.Items[x].ImageIndex := ImageIndex;
    end;

  end
  else begin
    lvAttachments.Visible := false;
    HTMLViewer.Height := lvAttachments.Top + lvAttachments.Height;
  end;
end;

procedure TfrmCustomer.btnInactiveFollowUpClick(Sender: TObject);
begin
  inherited;
  tbOtherFollowup.Delete;
  if tbOtherFollowup.RecordCount = 0 then begin

  end
  else EditDB(tbOtherFollowUp);
end;

procedure TfrmCustomer.FormCreate(Sender: TObject);
begin
  fbUpdatingcompanyonName := False;
  ApplyLabelCaptions(lblCompany , cpCustomerName);
  ApplyLabelCaptions(lblClientPrintNameHeading , cpClientPrintName);

  AllowCustomiseGrid := true;
  //fShipAddressList:= nil;
  btnAddfollowupnotedate.Visible :=   not(UserPreferenceOn(lcdOnSupplierfollowupNotes));
  PageAddress.activePageIndex :=0;
  tabAusEParcel.TabVisible:= (Appenv.RegionalOptions.RegionType = RAust) and (Appenv.CompanyPrefs.EnableAusEparcel);
  cboClientR.LookupFormClassName := 'TCustomerListGUI';
  cboClientR.EditFormClassName := 'TfrmCustomer';
  SelectedMail := nil;
  FileAssociationDetails := TFileAssociationDetails.Create;
  HTMLImageStream := TMemoryStream.Create;
  HistoryListform:= nil;
  AddPhoneCallbutton(Phone);
  AddPhoneCallbutton(MOB);
  AddPhoneCallbutton(AltPhone);

  chkgroupdiscount.Showhint     := true;
  chksplPrductdiscount.Showhint := true;
  chkgroupdiscount.hint         := DiscountOverrideHint;
  chksplPrductdiscount.hint     := DiscountOverrideHint;

  fbEmailchanged :=false;
  fsEquipmenttoAdd := '';
  fsRegotoAdd := '';
  inherited;
  lblSendXMLInvoices.caption :=  'When Checked,'+NL+
                                 'Emailing an Invoice from the ''Invoice Form'' will Send '+NL+
                                 'the Invoice in XML Format to the Email Address Provided below.';
  cboClientR.SpcialLookupItemList.Text := ComboSpecialItem_OpenList;
  { need to use full cust list so we have related cust info }
//  cboClientR.LookupFormClassName:= 'TCustomerListGUI';

  self.AddFlag('FormInitialising');
  UserLock.Enabled := true;

  fbTabSettingEnabled := false;
  fbAllowNotInList := true; // allow not-in-list processing
  fbUpdatingNotes := false;
  bShowingHistory := false;
  NoLockSource := false;
  fDefaultTab := '';

  // The BaseInputForm puts all queries into transaction mode. But
  // .. we don't want this query in that mode so we override the connection
  // .. string
  qryCustomFields.Connection := CommonDbLib.GetSharedMyDacConnection;

  qryDocuments.Connection := CommonDbLib.GetSharedMyDacConnection;



  qrySpecialsLinePrice.DisplayFormat := AppEnv.RegionalOptions.CurrencySymbol+'###0.00###';

  // register the global event handler for a specific form and event
  GlobalEvents.RegisterNameHandler(Self, 'TfmFollowUp', '', GEVENT_DataChanged, GlobalEventHandler);
  if HasAccessToCustomerClass then begin
      lblDefaultClass.visible := true;
      cboClassName.visible    := true;
  end else begin
      lblDefaultClass.visible := False;
      cboClassName.visible    := False;
  end;

  CustomerObj := TCustomer.Create(nil);
  CustomerObj.Connection := TMyDacDataConnection.Create(CustomerObj);
  CustomerObj.Connection.Connection := MyConnection;
  CustomerObj.BusObjEvent := DoBusinessObjectEvent;


//  Spelling.AddictSpell.AddControl(Notes);
end;

procedure TfrmCustomer.SuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  AssignComboAccessed(Sender);
  if not Modified then Exit;
  inherited;
  FillTable.FieldByName('State').AsString := LookupTable.FieldByName('State').AsString;
  FillTable.FieldByName('Postcode').AsString := LookupTable.FieldByName('Postcode').AsString;
  FillTable.FieldByName('Country').asString := LookupTable.FieldByName('Country').asString;
end;

procedure TfrmCustomer.BillSuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  AssignComboAccessed(Sender);
  inherited;
  FillTable.FieldByName('BillState').AsString := LookupTable.FieldByName('State').AsString;
  FillTable.FieldByName('BillPostcode').AsString := LookupTable.FieldByName('Postcode').AsString;
  FillTable.FieldByName('BillCountry').asString := LookupTable.FieldByName('Country').asString;
end;

procedure TfrmCustomer.cmdNotesClick(Sender: TObject);
begin
  inherited;
  TabCtl20.ActivePage := TTabSheet(Customer_Info);
  SetControlFocus(Notes);
end;

procedure TfrmCustomer.cmdShippingClick(Sender: TObject);
var
  ShipAddressList: TShipAddressListGUI;
begin
  DisableForm;
  try
    inherited;
    ShipAddressList := TShipAddressListGUI(GetComponentByClassName('TShipAddressListGUI'));

    if Assigned(ShipAddressList) then
    begin
      // ShipAddressList.FilterString := 'ClientID = ' + IntToStr(KeyID);
      //ShipAddressList.FilterString := 'Customer_ID = ' + IntToStr(KeyID);
      ShipAddressList.CustomerID := KeyId;
      ShipAddressList.grdMain.Options := ShipAddressList.grdMain.Options + [TwwDBGridOption.dgMultiSelect];
      ShipAddressList.FormStyle := fsMDIChild;
      ShipAddressList.BringToFront;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmCustomer.cmdPrintClick(Sender: TObject);
var
  sSQL: string;
  sClientID: string;
begin
  DisableForm;
  try
    inherited;
    if not CustomerSaved then exit;

    sClientID := qryCustomers.FieldByName('ClientID').AsString;
    fbTemplateUsesNonFormConnection := false;
    sSQL := '';
    fbReportSQLSupplied := true;

    sSQL := sSQL + '{Master} ';
    sSQL := sSQL + 'SELECT ';
    sSQL := sSQL + '"Customer Detail Report" AS ReportTitle, ';
    sSQL := sSQL + 'C.*, SUBSTRING_INDEX(C.Company, "^", 1) as Company_NoJobName, CONCAT_WS(" ", C.Title, C.FirstName, C.LastName) AS FullName, ';
    sSQL := sSQL + 'CONCAT_WS("  ", C.Suburb, C.State, C.PostCode) AS FullPostal, ';
    sSQL := sSQL + 'CONCAT_WS("  ", C.BillSuburb, C.BillState, C.BillPostCode) AS FullBillPostal, S.MediaType AS "Source" ';
    sSQL := sSQL + 'FROM tblclients C ';
    sSQL := sSQL + 'LEFT JOIN tblsource S on C.MedTypeID = S.MedTypeID ';
    sSQL := sSQL + 'WHERE C.ClientID=' + sClientID + ' AND C.Customer="T"; ';
    sSQL := sSQL + '~|||~{Custom Fields} ';
    sSQL := sSQL + 'SELECT * FROM tblcustomfields; ';
    sSQL := sSQL + '~|||~{Contacts} ';
    sSQL := sSQL + 'SELECT *, CONCAT_WS(" ", ContactTitle, ContactFirstName, ContactSurName) AS FullName ';
    sSQL := sSQL + 'FROM tblcontacts ';
    sSQL := sSQL + 'WHERE ClientID = ' + sClientID + ' /*AND ContactIsCustomer="F" AND ContactIsJob="F" AND ';
    sSQL := sSQL + 'ContactIsSupplier="F" AND ContactIsOtherContact="F" */ AND Active="T"; ';
    sSQL := sSQL + '~|||~{FollowUps} ';
    sSQL := sSQL + 'SELECT ';
    sSQL := sSQL + 'FU.FollowUpDate, FU.Notes, ';
    sSQL := sSQL + 'CASE FU.Done ';
    sSQL := sSQL + '  WHEN "T" THEN "Yes" ';
    sSQL := sSQL + '  WHEN "F" THEN "No" ';
    sSQL := sSQL + 'END AS "Completed", E.EmployeeName ';
    sSQL := sSQL + 'FROM tblotherfollowup FU ';
    sSQL := sSQL + 'LEFT JOIN tblemployees E ON FU.EmployeeID = E.EmployeeID ';
    sSQL := sSQL + 'WHERE FU.ClientID = ' + sClientID + ' ';
    sSQL := sSQL + '~|||~{Documents} ';
    sSQL := sSQL + 'SELECT ';
    sSQL := sSQL + 'tblReference.RefID, tblReference.Ref_Date as Date, tblReference.Ref_type as Type, tblReference.Referencetxt as Reference, ';
    sSQL := sSQL +
      'tblReference.CusID, tblReference.ContactID, Concat_Ws(" ",tblContacts.ContactFirstName,tblContacts.ContactSurname) as ContactName, ';
    sSQL := sSQL + 'tblContacts.ContactID, tblReference.EditedFlag ';
    sSQL := sSQL + 'FROM tblReference ';
    sSQL := sSQL + 'LEFT JOIN tblClients ON tblReference.CusID=tblClients.ClientID ';
    sSQL := sSQL + 'LEFT JOIN tblContacts ON tblReference.ContactID=tblContacts.ContactID ';
    sSQL := sSQL + 'WHERE tblReference.CusID=' + sClientID + ' ';
    sSQL := sSQL + 'GROUP BY tblReference.RefID ';
    sSQL := sSQL + 'ORDER BY tblReference.Ref_Date DESC;';
    sSQL := sSQL + '~|||~{CompanyInfo}  SELECT   CompanyName, Address, Address2, City, State, Postcode, ABN, PhoneNumber, FaxNumber  FROM tblCompanyInformation  ';



    PrintTemplateReport('General Details', sSQL, false, 1);
    fbReportSQLSupplied := false;
  finally
    EnableForm;
  end;
end;

procedure TfrmCustomer.edtDiscExit(Sender: TObject);
var
  TempPercent: double;
begin
  inherited;
  if IsOkToSave() then begin
    edtDisc.Text := FloatToStrF(StrValue(edtDisc.Text), ffFixed, 7, 2) + ' %';
    TempPercent  := StrValue(edtDisc.Text) / 100;
    if not qryCustomers.Active then begin
      qryCustomers.ParamByName('CusID').asInteger := KeyID;
      opendb(qryCustomers);
    end;
    EditDB(qryCustomers);
    qryCustomers.FieldByName('Discount').AsFloat := TempPercent;
    edtDisc.Text := FloatToStrF(TempPercent * 100, ffFixed, 7, 2) + ' %';
  end;
end;

procedure TfrmCustomer.qryCustomersBeforePost(DataSet: TDataSet);
var
  s:String;
begin
  inherited;
  if qryCustomersCreditLimit.AsFloat = 0 then
    qryCustomersCreditLimit.asFloat := 0;
  CheckCreateCustomerAccountNumber;
  {removing a selected type in the combo will initialise the field to
  null and the field does not allow null value, should be 0}
  if (qryCustomersClientTypeID.Value = null) or (qryCustomersClientTypeID.Value = 0) then begin
    qryCustomers.FieldByName('ClientTypeID').AsInteger := 0;
  end;
  if qryCustomersclientCode.asString = '' then begin
    s:=NameToCode(qrycustomerscompany.AsString);
    if s <> '' then
      if TCustomer.IsUnique(qryCustomersClientID.asInteger, 'ClientCode = ' + quotedstr(StringDataForSQL(s))) then
        qryCustomersclientCode.asString := s;
  end;

  if (qryCustomersclientCode.Value <> Null) and (qryCustomersclientCode.asString = '' ) then
    qryCustomersclientCode.Clear;

  if qryCustomersclientCode.asString <> '' then
    if not TCustomer.IsUnique(qryCustomersClientID.asInteger, 'ClientCode = ' + quotedstr(StringDataForSQL(qryCustomersclientCode.asString))) then begin
      MessageDlgXP_Vista('Customer Code ' + quotedstr(qryCustomersclientCode.asString)+' Already Exists for Another Customer. ', mtWarning, [mbOK], 0);
      qryCustomersclientCode.Clear;
    end;


  // pity it never gets here  (transaction processing grabs it)
  //  UpdateDiscounts;
end;

procedure TfrmCustomer.qryCustomersClientTypeIDChange(Sender: TField);
begin
  inherited;
  closedb(qryClientTypes);
  qryClientTypes.Parambyname('ClientTypeID').asInteger :=qryCustomersClientTypeID.asInteger;
  opendb(qryClientTypes);
end;

procedure TfrmCustomer.qryCustomersAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadMemTable;
  GetDiscounts;
  CustomerIDChange;
end;
procedure TfrmCustomer.CustomerIDChange;
begin
  if qryCustomersClientID.AsInteger =0 then exit;

  if Assigned(AttachmentForm) and (AttachmentForm.TableId <> qryCustomersClientID.AsInteger) then
    FreeandNil(AttachmentForm);
  If not Assigned(AttachmentForm) then Begin
    postdb(qryCustomers);
    AttachmentForm := TfmAttachments(GetComponentByClassName('TfmAttachments',False,Self,True,True,qryCustomersClientID.AsInteger));
    AttachmentForm.DBConnection := MyConnection;
    AttachmentForm.AttachObserver(Self);
    AttachmentForm.TableName := 'tblClients';
    AttachmentForm.TableId := qryCustomersClientID.AsInteger;
    AttachmentForm.Tag := qryCustomersClientID.AsInteger;
    AttachmentForm.lvAttachments.Parent := pnlAttachments;
    AttachmentForm.lvAttachments.Align := alClient;
    AttachmentForm.PopulateListView;
  end;
  qryCustomersClientTypeIDChange(Nil);
  chkIsInternal.visible  := (qryCustomersClientID.asInteger <> InhouseClientID) and not(Sametext(qryCustomersCompany.asString , Appenv.CompanyInfo.CompanyName));
  chkActive.visible      := chkIsInternal.visible;
  pnlActive.visible      := chkIsInternal.visible;
  chkDontContact.visible := chkIsInternal.visible;
  pnlDontContact.visible := chkIsInternal.visible;
end;
procedure TfrmCustomer.Makecompany;
begin
  if not fbclientnameMadeFromName then
    NamenPrintNameGridObj.Makecompany(fbUpdatingcompanyonName,qryCustomers);
  fbclientnameMadeFromName  := True;
end;
procedure TfrmCustomer.qryCustomersAfterPost(DataSet: TDataSet);
begin
  inherited;
  Makecompany;



  MainShippingAddress;
  closedb(qryTaxCodes);
  opendb(qryTaxCodes);
end;
(*
Procedure TfrmCustomer.MainShippingAddress;
var
  bm:TBookmark;
begin
  OpenSubQry(QryShippingAddressmain , 'KeyId');
  if QryShippingAddressmain.recordcount =0 then begin
    QryShippingAddressmain.append;
    QryShippingAddressmainCustomer_ID.AsInteger := qryCustomersClientID.AsInteger;
    QryShippingAddressmainCustomerPhysicalAddress.AsBoolean:= True;
    PostDB(QryShippingAddressmain);
  end;
    EditDB(QryShippingAddressmain);
    QryShippingAddressmainCompanyName.asString := qryCustomersCompany.AsString;
    OpenSubQry(qryContacts , 'CusID');
    bm :=qryContacts.getBookmark;
    try
      if qryContacts.Active and (qryContacts.RecordCount>0 ) and (qryContacts.Locate('IsPrimarycontact' , 'T', [])) then begin
        EditDB(QryShippingAddressmain);
        QryShippingAddressmainContactName.AsString :=qryContactsCompany.AsString;
      end;
      EditDB(QryShippingAddressmain);QryShippingAddressmainShipAddress.AsString       := qryCustomersStreet.AsString;
      EditDB(QryShippingAddressmain);QryShippingAddressmainShipAddress1.AsString      := qryCustomersStreet2.AsString;
      EditDB(QryShippingAddressmain);QryShippingAddressmainShipCity.AsString          := qryCustomersSuburb.AsString;
      EditDB(QryShippingAddressmain);QryShippingAddressmainShipPostCode.AsString      := qryCustomersPostcode.AsString;
      EditDB(QryShippingAddressmain);QryShippingAddressmainShipState.AsString         := qryCustomersState.AsString;
      EditDB(QryShippingAddressmain);QryShippingAddressmainShipCountry.AsString       := qryCustomersCountry.AsString;
      EditDB(QryShippingAddressmain);QryShippingAddressmainShipAddress2.AsString      := qryCustomersStreet3.AsString;
      EditDB(QryShippingAddressmain);QryShippingAddressmainActive.AsBoolean           := True;
      EditDB(QryShippingAddressmain);QryShippingAddressmainPortOfLanding.AsString     := qryCustomersPortOfLanding.AsString;
      EditDB(QryShippingAddressmain);QryShippingAddressmainPortOfDischarge.AsString   := qryCustomersPortOfDischarge.AsString;
      EditDB(QryShippingAddressmain);QryShippingAddressmainFinalDestination.AsString  := qryCustomersFinalDestination.AsString;
      EditDB(QryShippingAddressmain);QryShippingAddressmainIncoPlace.AsString         := qryCustomersIncoPlace.AsString;
      EditDB(QryShippingAddressmain);QryShippingAddressmainPhone.AsString             := qryCustomersPhone.AsString;
      EditDB(QryShippingAddressmain);QryShippingAddressmainemail.AsString             := qryCustomersEmail.AsString;
      PostDB(QryShippingAddressmain);
    finally
      qryContacts.gotobookmark(bm);
      qryContacts.FreeBookmark(bm);
    end;
end;
*)
Procedure TfrmCustomer.MainShippingAddress;
var
  qry : TERPQuery;
begin
  qry := TERPQuery.Create(Self);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text := 'SELECT * FROM tblContacts where IsPrimaryContact="T" and ClientId = '+ inttostr(qryCustomersClientID.AsInteger);
    qry.Open;

    OpenSubQry(QryShippingAddressmain , 'KeyId');
    if QryShippingAddressmain.recordcount =0 then begin
      QryShippingAddressmain.append;
      QryShippingAddressmainCustomer_ID.AsInteger := qryCustomersClientID.AsInteger;
      QryShippingAddressmainCustomerPhysicalAddress.AsBoolean:= True;
      PostDB(QryShippingAddressmain);
    end;

    EditDB(QryShippingAddressmain);
    QryShippingAddressmainCompanyName.asString := qryCustomersCompany.AsString;
    if qry.RecordCount > 0 then begin
      EditDB(QryShippingAddressmain);
      QryShippingAddressmainContactName.AsString :=qry.FieldByName('Company').AsString;
    end;
    EditDB(QryShippingAddressmain);QryShippingAddressmainShipAddress.AsString       := qryCustomersStreet.AsString;
    EditDB(QryShippingAddressmain);QryShippingAddressmainShipAddress1.AsString      := qryCustomersStreet2.AsString;
    EditDB(QryShippingAddressmain);QryShippingAddressmainShipCity.AsString          := qryCustomersSuburb.AsString;
    EditDB(QryShippingAddressmain);QryShippingAddressmainShipPostCode.AsString      := qryCustomersPostcode.AsString;
    EditDB(QryShippingAddressmain);QryShippingAddressmainShipState.AsString         := qryCustomersState.AsString;
    EditDB(QryShippingAddressmain);QryShippingAddressmainShipCountry.AsString       := qryCustomersCountry.AsString;
    EditDB(QryShippingAddressmain);QryShippingAddressmainShipAddress2.AsString      := qryCustomersStreet3.AsString;
    EditDB(QryShippingAddressmain);QryShippingAddressmainActive.AsBoolean           := True;
    EditDB(QryShippingAddressmain);QryShippingAddressmainPortOfLanding.AsString     := qryCustomersPortOfLanding.AsString;
    EditDB(QryShippingAddressmain);QryShippingAddressmainPortOfDischarge.AsString   := qryCustomersPortOfDischarge.AsString;
    EditDB(QryShippingAddressmain);QryShippingAddressmainFinalDestination.AsString  := qryCustomersFinalDestination.AsString;
    EditDB(QryShippingAddressmain);QryShippingAddressmainIncoPlace.AsString         := qryCustomersIncoPlace.AsString;
    EditDB(QryShippingAddressmain);QryShippingAddressmainPhone.AsString             := qryCustomersPhone.AsString;
    EditDB(QryShippingAddressmain);QryShippingAddressmainemail.AsString             := qryCustomersEmail.AsString;
    EditDB(QryShippingAddressmain);QryShippingAddressmainAddressValidated.asBoolean := qryCustomersAddressValid.asBoolean;
    try
      PostDB(QryShippingAddressmain);
    Except
      on E:Exception do begin
        if devmode then
          MessageDlgXP_Vista(e.message, mtWarning, [mbOK], 0);
      end;
    end;
  finally
    qry.Free;
  end;
end;

procedure TfrmCustomer.LoadContactSelector;

begin
  cboContactSelector.Clear;
  CboContactSelector.Items.Add('All');
  qryContactSelector.First;
  while (not qryContactSelector.EOF) do
  begin
    CboContactSelector.Items.AddObject(qryContactSelector.FieldByName('ContactName').AsString,
                                       Pointer(qryContactSelector.FieldByName('ContactId').AsInteger));
    qryContactSelector.Next;
  end;
  cboContactSelector.ItemIndex := 0;
end;

procedure TfrmCustomer.LoadMemTable;
begin
  if qryCustomersClientID.AsInteger =0 then exit;
  if memqryCustomers.active then
    if qryCustomersclientId.asInteger =  memqryCustomers.fieldbyname('ClientID').asInteger then exit;
  LoadEditedFlagMemTable(qryCustomers, memqryCustomers);
end;

procedure TfrmCustomer.cboClientTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  AssignComboAccessed(Sender);
  inherited;
  if Empty(cboClientType.Text) then Exit;
  UpdateClientTypeData;
end;

procedure TfrmCustomer.edtSpecDiscExit(Sender: TObject);
var
  TempPercent: double;
begin
  inherited;
  edtSpecDisc.Text := FloatToStrF(StrValue(edtSpecDisc.Text), ffFixed, 7, 2) + ' %';
  TempPercent := StrValue(edtSpecDisc.Text) / 100;
  EditDB(qryCustomers);
  qryCustomers.FieldByName('SpecialDiscount').AsFloat := TempPercent;
  edtSpecDisc.Text := FloatToStrF(TempPercent * 100, ffFixed, 7, 2) + ' %';
end;

procedure TfrmCustomer.SuburbOnEnter(Sender: TObject);
begin
  inherited;
  if not (QrySuburb.Active) then begin
    QrySuburb.Active := true;
  end;
end;

procedure TfrmCustomer.BillSuburbBeforeDropDown(Sender: TObject);
begin
  inherited;
  if not (QrySuburb.Active) then begin
    QrySuburb.Active := true;
  end;
end;

procedure TfrmCustomer.cboTaxCodeNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
begin
  accept := false;
  self.NotInListWarning(Sender);
end;

procedure TfrmCustomer.qryCustomersFirstNameChange(Sender: TField);
begin
  inherited;
  if not NamenPrintNameGridObj.UpdatecompanyonNamechange(fbUpdatingcompanyonName , qryCustomers) then SetControlFocus(txtcompany);
end;
procedure TfrmCustomer.QrycustomerShipAddresslistBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  QrycustomerShipAddresslist.ParamByName('KeyId').asInteger := qryCustomersclientID.asInteger;
end;

procedure TfrmCustomer.actGeneralUpdate(Sender: TObject);
begin
  inherited;
  cmdOK.Enabled := IsOkToSave;
  cmdNew.Enabled := IsOkToSave;
  btnSupplier.Enabled := (not qryCustomersSupplier.AsBoolean) and IsOkToSave;
  cmdCopy.Enabled := IsOkToSave;
end;


procedure TfrmCustomer.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  inherited;
  btnSetDocumentPath.Enabled :=  AccessLevel < 3;
  btnOpenDocumentPath.Enabled := btnSetDocumentPath.Enabled;
end;

// Adds date / time to notes when user leaves the selected cell.

procedure TfrmCustomer.grdFollowUpColExit(Sender: TObject);
begin
  inherited;
  if sameText(grdFollowUp.GetActiveField.FieldName , tbOtherFollowUpNotes.FieldName) then begin
    if tbOtherFollowUpNotes.ReadOnly then exit;
    if (tbOtherFollowUp.RecordCount = 0) or VarIsNull(tbOtherFollowUpNotes.OldValue) or (not SameText(tbOtherFollowUpNotes.AsString , tbOtherFollowUpNotes.OldValue)) then  begin
      EditDB(tbOtherFollowUp);
      tbOtherFollowUpNotes.asString := AddDateTime(lcdOnSupplierfollowupNotes, tbOtherFollowUpNotes.asString, False);
    end;
  end;

end;

// Remove date / time if they are present.

procedure TfrmCustomer.grdFollowUpColEnter(Sender: TObject);
begin
  inherited;
  if sameText(grdFollowUp.GetActiveField.FieldName , tbOtherFollowUpNotes.FieldName) then begin
    if tbOtherFollowUpNotes.ReadOnly  then exit;
    if TBOtherFollowUpnotes.asString = '' then exit;
    with grdFollowUp do begin
      editdb(TBOtherFollowUp);
      TBOtherFollowUpnotes.asString := StripDateTime(TBOtherFollowUpnotes.asString);
      Postdb(TBOtherFollowUp);
    end;
  end;
end;

procedure TfrmCustomer.tbOtherFollowUpAfterInsert(DataSet: TDataSet);
begin
  inherited;
  tbOtherFollowUpClientID.AsInteger := qryCustomers.FieldByName('ClientID').AsInteger;
  tbOtherFollowUpOtherContactID.AsInteger := qryCustomers.FieldByName('ClientID').AsInteger;
  tbOtherFollowUpCreationDate.AsDateTime := Now;
  tbOtherFollowUpIsCustomer.AsBoolean := true;
end;

procedure TfrmCustomer.tbOtherFollowUpAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadEditedFlagMemTable(tbOtherFollowUp, memtbOtherFollowUp);
end;

procedure TfrmCustomer.qrySpecialsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qrySpecialsCustomerId.AsInteger := KeyID;
end;

procedure TfrmCustomer.qrySpecialsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadEditedFlagMemTable(qrySpecials, memqrySpecials);
end;

procedure TfrmCustomer.qrySpecialsAfterPost(DataSet: TDataSet);
var
  SavedAccessLevel: integer;
begin
  inherited;
    if (qrySpecialsOrigPrice.asFloat=0) and
       (qrySpecialsLinePrice.asFloat=0) and
       (qrySpecialsProductID.asInteger=0) then begin
      SavedAccessLevel:= AccessLevel;
      try
        AccessLevel:= 1;
        qrySpecials.Delete;
      finally
        AccessLevel:= SavedAccessLevel;
      end;
    end;
end;

procedure TfrmCustomer.qrySpecialsBeforePost(DataSet: TDataSet);
var
  strSQL:String;
  Function DateFrom:TDatetime;
  begin
    result := 0;
    if qrySpecialsDateFrom.asDatetime<>0 then result := qrySpecialsDateFrom.asDatetime;
  end;
  Function DateTo:TDatetime;
  begin
     result := MaxDateTime;
     if qrySpecialsDateTo.asDatetime <> 0 then result := qrySpecialsDateTo.asDatetime;
  end;
begin
  inherited;
  strSQL:='Select * from tblcustomerlines ' +
          ' where   ((ifnull(DateFrom,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+') <=' + QuotedStr(FormatDateTime(MysqlDateFormat , DateFrom)) +' and ifnull(Dateto,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+')>=' + QuotedStr(FormatDateTime(MysqlDateFormat , DateFrom)) +' ) '+
          '       Or (ifnull(DateFrom,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+') <=' + QuotedStr(FormatDateTime(MysqlDateFormat , DateTo  )) +' and ifnull(Dateto,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+')>=' + QuotedStr(FormatDateTime(MysqlDateFormat , DateTo  )) +' )'+
          '       Or (ifnull(DateFrom,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+') >=' + QuotedStr(FormatDateTime(MysqlDateFormat , DateFrom)) +' and ifnull(Dateto,'+QuotedStr(FormatdateTime(MysqlDateFormat , 0))+')<=' + QuotedStr(FormatDateTime(MysqlDateFormat , DateTo  )) +' ))'+
          ' and ifnull(customerId,0) ='+inttostr(qryCustomersClientId.AsInteger)+
          ' and ifnull(ProductID,0) ='+IntToStr(qrySpecialsProductID.asInteger) +
          ' and ifnull(UOMID,0)     ='+IntToStr(qrySpecialsUOMID.asInteger) +
          ' and ifnull(CustomerLinesID,0)<>'+IntToStr(qrySpecialsCustomerLinesID.asInteger);

  with CommonDbLib.TempMyQuery do try
      connection := qrySpecials.connection;
      SQL.add(strSQL);
      Open;
      if recordcount > 0 then begin
        Commonlib.MessageDlgXP_Vista('A Discount Price Already Exists For Product ' +qrySpecialsName.asString +' For An Overlaping Period.' ,mtWarning, [mbok],0);
        abort;
      end;
  finally
      if active then close;
      Free;
  end;

end;

procedure TfrmCustomer.qrySpecialsNameChange(Sender: TField);
begin
  inherited;
  if not((screen.activecontrol = cboProd) or (Screen.activecontrol = grdSpecials)) then exit;
  if cboProductQry.Locate('PARTNAME' ,qrySpecialsName.asString , []) then begin
    qrySpecialsProductID.AsInteger  := cboProductQry.fieldbyname('PartsID').AsInteger;
    qrySpecialsDescription.AsString := cboProductQry.fieldbyname('PartsDescription').AsString;
    qrySpecialsOrigPrice.AsCurrency := cboProductQry.fieldbyname('Price1').AsCurrency;
    qrySpecialsLinePrice.AsCurrency := cboProductQry.fieldbyname('Price1').AsCurrency;
  end;
end;

procedure TfrmCustomer.qryBankCodesBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  TERPQuery(Dataset).Params.ParamByName('XRegionID').AsInteger := AppEnv.RegionalOptions.ID;
  TERPQuery(Dataset).Params.ParamByName('BankCode').AsString := qryCustomersBankCode.AsString;
end;

procedure TfrmCustomer.Qryclients_eParcelAfterInsert(DataSet: TDataSet);
begin
  inherited;
  Qryclients_eParcelclientId.asInteger := qryCustomersclientID.asInteger;
end;

procedure TfrmCustomer.qryClientToShipAddressLinkBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryClientToShipAddressLink.ParamByName('KeyId').AsInteger := qryCustomersclientID.asInteger;
  qryClientToShipAddressLink.ParamByName('shipAddressID').AsInteger := QryShippingAddressmainShipAddressID.asInteger;
end;

procedure TfrmCustomer.qryContactNamesBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryContactNames.ParamByName('ClientId').asInteger := qryCustomersclientID.asInteger;
end;

procedure TfrmCustomer.qryContactsAfterOpen(DataSet: TDataSet);
begin
  inherited;
//  LoadEditedFlagMemTable(qryContacts, memqryContacts);
end;

procedure TfrmCustomer.qryContactsBeforeOpen(DataSet: TDataSet);
begin
  inherited;
//  qryContacts.ParamByName('CusID').asInteger := qryCustomersclientID.asInteger;
end;

procedure TfrmCustomer.qryContactSelectorBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryContactSelector.ParamByName('xClientId').asInteger := qryCustomersclientID.asInteger;
end;

procedure TfrmCustomer.grdProdGroupDiscsIButtonClick(Sender: TObject);
begin
  inherited;
  if qryProdGroupDiscs.IsEmpty then
    exit;
  qryProdGroupDiscs.Delete;
  EditDB(qryProdGroupDiscs);
end;

procedure TfrmCustomer.cboCreditCardTypeChange(Sender: TObject);
begin
  inherited;
  AssignComboAccessed(Sender);
end;

procedure TfrmCustomer.cboCreditCardTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  AssignComboAccessed(Sender);
end;

procedure TfrmCustomer.edtURLDblClick(Sender: TObject);
begin
  inherited;
  ShellExecute(0, 'open', PChar(Trim(edtURL.Text)), nil, nil, sw_shownormal);
end;

procedure TfrmCustomer.qryCustomershippingoptionsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  EditDB(qryCustomershippingoptions);qryCustomershippingoptionsIsDefault.asBoolean := False;
  EditDB(qryCustomershippingoptions);qryCustomershippingoptionsActive.asBoolean := TRue;
  EditDB(qryCustomershippingoptions);qryCustomershippingoptionsCustomerID.AsInteger   := qryCustomersClientID.AsInteger;
end;

procedure TfrmCustomer.qryCustomershippingoptionsAfterPost(DataSet: TDataSet);
begin
  inherited;
  if qryCustomershippingoptionsIsDefault.asBoolean then begin
     EditDB(qryCustomers);
     qryCustomersClientShipperAccountNo.asString := qryCustomershippingoptionsAccountNumber.asString ;
     qryCustomersClientPaysShippment.asBoolean := sametext(trim(qryCustomershippingoptionsPayorType.asString ), 'Recipient');
     PostDB(qryCustomers);
  end;
end;

procedure TfrmCustomer.qryCustomershippingoptionsAfterScroll(DataSet: TDataSet);
var
  fbFlag:Boolean;
begin
  inherited;
  if accessmanager.accesslevel >3 then
  else begin
    fbFlag := sametext(qryCustomershippingoptionsShipperType.asString , 'USPS') or
              sametext(qryCustomershippingoptionsShipperType.asString , 'Canada Post');
    qryCustomershippingoptionsPayorType.readonly := fbFlag;
    qryCustomershippingoptionsAccountNumber.readonly := sametext(qryCustomershippingoptionsShipperType.asString , 'USPS');
    if sametext(qryCustomershippingoptionsShipperType.asString , 'USPS') then begin
       TimerMsg(lblMsg, 'For USPS / Canada Post - Sender will have to pay, The Payor Rype and Account numebr as Disabled');
    end;
  end;
end;

procedure TfrmCustomer.qryCustomershippingoptionsIsDefaultChange(Sender: TField);
var
  fiid:Integer;
begin
  inherited;
  postdb(qryCustomershippingoptions);
  if qryCustomershippingoptionsIsDefault.asboolean and (qryCustomershippingoptions.recordcount>1) then begin
    qryCustomershippingoptions.Disablecontrols;
    try
        fiID:= qryCustomershippingoptionsCustomerShipingOptionID.asInteger;
        qryCustomershippingoptions.first;
        While qryCustomershippingoptions.eof = False do begin
          if fiID<> qryCustomershippingoptionsCustomerShipingOptionID.asInteger then begin
            if qryCustomershippingoptionsIsDefault.asboolean then begin
              EditDB(qryCustomershippingoptions);
              qryCustomershippingoptionsIsDefault.asboolean := False;
              PostDB(qryCustomershippingoptions);
            end;
          end;
          qryCustomershippingoptions.next;
        end;
        qryCustomershippingoptions.locate('CustomerShipingOptionID', fiid, []);
    finally
      qryCustomershippingoptions.EnableControls;
    end;
  end;
end;

procedure TfrmCustomer.qryCustomersLastNameChange(Sender: TField);
begin
  inherited;
  if not NamenPrintNameGridObj.UpdatecompanyonNamechange(fbUpdatingcompanyonName , qryCustomers) then SetControlFocus(txtcompany);

end;

procedure TfrmCustomer.qryCustomersRepIDChange(Sender: TField);
begin
  inherited;
  if qryEmployees.Locate('EmployeeName', cboRep.Text, [loCaseInsensitive]) then begin
    if EditNoAbort(qryCustomers) then qryCustomersRepName.AsString := qryEmployees.FieldByName('EmployeeName').AsString;
  end else begin
    if EditNoAbort(qryCustomers) then qryCustomersRepName.AsString := '';
  end;
end;

procedure TfrmCustomer.btnExportCreditClick(Sender: TObject);
begin
  DisableForm;
  try
    ExportCreditToJobs;
  finally
    EnableForm;
  end;
end;

procedure TfrmCustomer.btnFollowUpsClick(Sender: TObject);
//var
//  idx : integer;
begin
(*
  inherited;
  for idx := 1 to  cboContactSelector.Items.Count - 1 do
  begin
    if Integer(cboContactSelector.Items.Objects[idx]) = SelectedContactId then
    begin
      cboContactSelector.ItemIndex := idx;
      Break;
    end;
  end;
*)
  SetContactFilter(SelectedContactId);
  tabCtl20.ActivePage := tabReferrals;
  MiscPageControl.ActivePage := tabFollowUp;
  cboContactSelectorChange(Self);
end;

procedure TfrmCustomer.ExportCreditToJobs;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(Self);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('UPDATE tblClients SET ' +
      'CreditLimit = :xCreditLimit,  ' +
      'TermsID = :xTermsID, ' +
      'TERMS = :xTerms, ' + // not used, but put here just in case
      'GracePeriod = :xGracePeriod ' +
      'WHERE ParentClientID = :xParentClientID');
    qry.ParamByName('xParentClientID').AsInteger := qryCustomersClientID.AsInteger;
    qry.ParamByName('xCreditLimit').AsFloat    := qryCustomersCreditLimit.AsFloat;
    qry.ParamByName('xTermsID').AsInteger        := qryCustomersTermsID.AsInteger;
    qry.ParamByName('xTerms').AsString          := qryCustomersTerms.AsString;
    qry.ParamByName('xGracePeriod').AsInteger    := qryCustomersGracePeriod.AsInteger;
    qry.Execute;
  finally
    FreeAndNil(qry);
  end;
end;

function TfrmCustomer.ChkCustReqdFields: boolean;
begin
  Result := ChkReqdFields('Cust');
  if not Result then TabCtl20.ActivePage := Custom_Fields;
end;

procedure TfrmCustomer.TabCtl20Changing(Sender: TObject; var AllowChange: boolean);
begin
  if bShowingHistory then begin
    AllowChange := false;
    Exit;
  end;
  if not ValidateCustomer(False) then begin
    AllowChange := false;
    Exit;
  end;

  inherited;
  if AllowChange = true then if not IsClientNameUnique(Company.Text, KeyID) then begin
      Allowchange := false;
      CommonLib.MessageDlgXP_Vista('You Have Created An Entry (Company) That Already Exists !' + #13#10#13#10 +
        'Please Ensure Your Entry Is Unique.', mtWarning, [mbOK], 0);
  end;
  TabCtl20CurTab:=TabCtl20.ActivePage;
end;

procedure TfrmCustomer.btnDeleteReferralClick(Sender: TObject);
begin
  inherited;
  DeleteRecord(qryReferrals);
end;

procedure TfrmCustomer.btnDeleteShippingAddressClick(Sender: TObject);
var
  scr : TERPScript;
begin
  inherited;
//
  // delete link
  if qryCustomerShipAddressList.FieldByName('CustomerPhysicalAddress').AsString = 'T' then
  begin
    MessageDlgXP_Vista('Cannot Delete The Customer Physical Address', mtWarning, [mbOk], 0);
    exit;
  end;

  scr := TERPScript.Create(nil);
  try
    scr.Connection := qryCustomerShipAddressList.Connection;
    scr.SQL.Text := 'delete from tblClientToShipAddressLink where ClientId=' + qryCustomerShipAddressList.FieldByName('Customer_id').AsString +
                    #13#10'and ShipAddressId=' + qryCustomerShipAddressList.FieldByName('ShipAddressId').AsString;
    scr.Execute;
//    qryCustomerShipAddressList.Edit;
    qryCustomerShipAddressList.Delete;
//    qryCustomerShipAddressList.Post;

  finally
    scr.Free;
  end;

end;

procedure TfrmCustomer.qryReferralsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryReferralsClientID.AsInteger := qryCustomersClientID.AsInteger;
end;

procedure TfrmCustomer.chkAllRefsClick(Sender: TObject);
begin
  inherited;
  (*if chkAllRefs.Checked then begin
    grdReferrals.SelectAll;
  end else begin
    grdReferrals.UnselectAll;
  end;*)
end;

procedure TfrmCustomer.btnLeadClick(Sender: TObject);
var
  msg: string;
  fiMarketingcotnactID:Integer;
begin
  if not CustomerSaved then exit;
  fiMarketingcotnactID:= MarketingcotnactID(msg);
  if fiMarketingcotnactID =0 then begin
    CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
    Exit;
  end;
  CommitTransaction;
  fbSaveClicked:= True;
  if fsModal in FormState then begin
    OpenERPFormModal('TfmMarketingLead',0 , initMarketingform);
    ModalResult := mrOk;
  end else begin
    OpenERPForm('TfmMarketingLead',0 , nil, initMarketingform);
    Self.CloseWait;
  end;
end;
procedure TfrmCustomer.initMarketingform(Sender: TObject);
begin
  if sender is TfmMarketingLead then
    TfmMarketingLead(Sender).MarketingContactName := qryCustomersCompany.asString;
end;

procedure TfrmCustomer.btnLettersClick(Sender: TObject);
var
  //lstReports: TStrings;
  i, j: integer;
  sSql: string;
begin
  inherited;

  fbReportSQLSupplied := true;

  dlgReportSelect.MultiSelect := true;
  LoadReportTypes;

  if not dlgReportSelect.Execute then begin
    Exit;
  end;

  for j := 0 to grdReferrals.SelectedList.Count - 1 do begin
    qryReferrals.GotoBookmark(grdReferrals.SelectedList.Items[j]);
    for i := 0 to dlgReportSelect.SelectedItems.Count - 1 do begin
      ReportToPrint := dlgReportSelect.SelectedItems[i];

      sSql :=
        'SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, ' +
        'Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, ' + 'Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN, ' +
        'C1.Company, C1.Street, C1.Street2, C1.Suburb, C1.State, C1.Postcode, ' + 'C2.Company as ReferredCompany, ' +
        'C2.Street as ReferredStreet, ' + 'C2.Street2 as ReferredStreet2, ' + 'C2.Suburb as ReferredSuburb, ' +
        'C2.State as ReferredState, ' + 'C2.PostCode as ReferredPostCode ' + 'FROM tblCompanyInformation as CO, tblclients as C1 ' +
        'INNER JOIN tblClients AS C2 ON C2.ClientID= ' + qryReferralsReferredClientID.AsString + ' ' +
        'WHERE C1.ClientID = ' + qryCustomersClientID.AsString;


      PrintTemplateReport(dlgReportSelect.SelectedItems[i], sSQL, not AppEnv.Employee.ShowPreview, 1);
    end;
  end;
  fbReportSQLSupplied := false;
end;

procedure TfrmCustomer.btnMarketingContactClick(Sender: TObject);
var
  msg: string;
begin
    if MarketingcotnactID(msg) >0 then
      CommonLib.MessageDlgXP_Vista(iif(trim(msg)<> '' , msg , 'New Marketing Contact has been created.'),mtInformation,[mbOk],0)
    else
      CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
end;
Function TfrmCustomer.MarketingcotnactID(var msg: string):Integer;
var
  Cust: TCustomer;
begin
  inherited;
  REsult := 0;
  Cust := TCustomer.CreateWithNewConn(nil);
  try
    Cust.Connection.Connection := MyConnection;
    Cust.Load(qryCustomersClientID.AsInteger);
    if sametext(Cust.Clientname, 'Cash Customer' ) or
     sametext(Cust.Clientname, 'Workshop' ) or
     sametext(Cust.Clientname, 'Misc Supplier' ) or
     sametext(Cust.Clientname, 'Default Company' ) then Exit;

    REsult := Cust.ConverttoMarketingcontact(msg) ;
  finally
    Cust.Free;
  end;

end;

function TfrmCustomer.GetReportTypeID: integer;
begin
  Result := 47;
end;

procedure TfrmCustomer.actReferralsPrintExecute(Sender: TObject);
var
  // lstReports: TStrings;
  i, j: integer;
  sSql: string;
begin
  DisableForm;
  try
    inherited;

    fbReportSQLSupplied := true;

    dlgReportSelect.MultiSelect := true;
    LoadReportTypes;

    if not dlgReportSelect.Execute then begin
      Exit;
    end;

    for j := 0 to grdReferrals.SelectedList.Count - 1 do begin
      qryReferrals.GotoBookmark(grdReferrals.SelectedList.Items[j]);
      for i := 0 to dlgReportSelect.SelectedItems.Count - 1 do begin
        ReportToPrint := dlgReportSelect.SelectedItems[i];
        sSql :=
          'SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, ' +
          'Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, ' + 'Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN, ' +
          'C1.Company, C1.Street, C1.Street2, C1.Suburb, C1.State, C1.Postcode, ' + 'C2.Company as ReferredCompany, ' +
          'C2.Street as ReferredStreet, ' + 'C2.Street2 as ReferredStreet2, ' + 'C2.Suburb as ReferredSuburb, ' +
          'C2.State as ReferredState, ' + 'C2.PostCode as ReferredPostCode ' + 'FROM tblCompanyInformation as CO, tblclients as C1 ' +
          'INNER JOIN tblClients AS C2 ON C2.ClientID= ' + qryReferralsReferredClientID.AsString + ' ' +
          'WHERE C1.ClientID = ' + qryCustomersClientID.AsString;
        PrintTemplateReport(dlgReportSelect.SelectedItems[i], sSQL, not AppEnv.Employee.ShowPreview, 1);
      end;
    end;
    fbReportSQLSupplied := false;
  finally
    EnableForm;
  end;
end;

procedure TfrmCustomer.actReferralsPrintUpdate(Sender: TObject);
begin
  inherited;
  actReferralsPrint.Enabled := (grdReferrals.SelectedList.Count <> 0)
end;
procedure TfrmCustomer.PageAddressChange(Sender: TObject);
begin
  inherited;
  if PageAddress.activepage = TabShippingAddresses then begin
    closedb(QrycustomerShipAddresslist);
    opendb(QrycustomerShipAddresslist);
  end else if PageAddress.activepage = tabCustomershippingoptions then begin
    closedb(qryCustomershippingoptions);
    opendb(qryCustomershippingoptions);
    grdCustomershippingoptionsEnter(grdCustomershippingoptions);
  end else if (PageAddress.ActivePage = TTabSheet(tsEDI)) then begin
    CustomerObj.CoreEDIConfig;
    if CustomerObj.CoreEDIConfig.IsEmpty then
      CustomerObj.CoreEDIConfig.New;
    LoadCoreEDIConfig;
  end;

  (*if PageAddress.ActivePage = TTabSheet(TabShippingAddresses) then begin
    if fShipAddressList = nil then begin
       CreateHistorylistform('TShipAddressListGUI' ,Self, fShipAddressList);
        if Assigned(fShipAddressList) then begin
          fShipAddressList.Parent := pnlShippingAddress;
          fShipAddressList.BorderStyle := bsNone;
          fShipAddressList.fbIgnoreQuerySpeed := true;
          fShipAddressList.ShowbuttonsinPanel := True;
          fShipAddressList.filterString :=  'ClientID = '+ IntToStr(qryCustomersClientID.asInteger);
          try
            fShipAddressList.Show;
          except
            FreeAndNil(fShipAddressList);
          end;
        end;
    end;
  end;*)
end;

procedure TfrmCustomer.PageAddressChanging(Sender: TObject; var AllowChange: Boolean);
begin
  inherited;
  if PageAddress.activepage = tabAddressmain then begin
    postdb(qryCustomers);
  end;
end;


function TfrmCustomer.PreSaveCustomer: boolean;
var
  SelectedTab: TTabSheet;
begin
  Result := true;
  SelectedTab := TabCtl20.ActivePage;
  try
    try
      if not Empty(Company.Text) then begin
        EditDB(qryCustomers);
        PostDB(qryCustomers);
        bNewCust := false;
        KeyID := qryCustomersClientID.AsInteger;
        NoLockSource := true;
        FormShow(nil);
        TabCtl20.ActivePage := TTabSheet(Customer_Info);
        EditDB(qryCustomers);
      end;
    except
      on E: Exception do begin
        Result := false;
        raise;
      end;
    end;
  finally
    if TabCtl20.ActivePage <> SelectedTab then TabCtl20.ActivePage := SelectedTab;
  end;
end;

procedure TfrmCustomer.chkUseBaseInvNoClick(Sender: TObject);
begin
  inherited;
  if chkUseBaseInvNo.Checked then begin
    edtBaseInvNo.Enabled := true;
  end else begin
    edtBaseInvNo.Enabled := false;
  end;
end;

procedure TfrmCustomer.grdReferralsExit(Sender: TObject);
begin
  inherited;
  if (grdReferrals.DataSource.DataSet.Active) and (grdReferrals.DataSource.DataSet.RecordCount > 0) then begin
    EditDB(grdReferrals.DataSource.DataSet);
    PostDB(grdReferrals.DataSource.DataSet);
    EditDB(grdReferrals.DataSource.DataSet);
  end;
end;

procedure TfrmCustomer.grdProdGroupDiscsExit(Sender: TObject);
begin
  inherited;
  if (grdProdGroupDiscs.DataSource.DataSet.Active) and (grdProdGroupDiscs.DataSource.DataSet.RecordCount > 0) then begin
    EditDB(grdProdGroupDiscs.DataSource.DataSet);
    PostDB(grdProdGroupDiscs.DataSource.DataSet);
    EditDB(grdProdGroupDiscs.DataSource.DataSet);
  end;
end;

procedure TfrmCustomer.grdSpecialsDblClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfrmParts',qrySpecialsProductID.AsInteger);
end;

procedure TfrmCustomer.grdSpecialsExit(Sender: TObject);
begin
  inherited;
  if (grdSpecials.DataSource.DataSet.Active) and (grdSpecials.DataSource.DataSet.RecordCount > 0) then begin
    EditDB(grdSpecials.DataSource.DataSet);
    PostDB(grdSpecials.DataSource.DataSet);
    EditDB(grdSpecials.DataSource.DataSet);
  end;
end;

procedure TfrmCustomer.cboClientsExit(Sender: TObject);
begin
  inherited;
  if (grdReferrals.DataSource.DataSet.Active) and (grdReferrals.DataSource.DataSet.RecordCount > 0) then begin
    EditDB(grdReferrals.DataSource.DataSet);
    PostDB(grdReferrals.DataSource.DataSet);
    EditDB(grdReferrals.DataSource.DataSet);
  end;
end;

procedure TfrmCustomer.EquipNotesDialog1UserButton1Click(Dialog: TwwMemoDlg; Memo: TMemo);
begin
  inherited;
  Memo.Lines.Text := Memo.Lines.Text + ' :- (' + AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName +
    ')' + FormatDateTime('dddd mmmm d yyyy " at " hh:mm AM/PM', Now) + #13#10;
end;

procedure TfrmCustomer.AccountNoKeyPress(Sender: TObject; var Key: char);
//var
//  iKey: integer;
begin
  inherited;
  { Removed 18/11/13 so alpha chars can be used }
//  iKey := Ord(Key);
//  // Only accept keys of 0-9 or backspace - anything else is refused!
//  if (iKey <> 8) and (iKey <> 46) and ((iKey < 48) or (iKey > 57)) then begin
//    Key := #0;
//    Exit;
//  end;
end;

procedure TfrmCustomer.btnAddDateTimeClick(Sender: TObject);
begin
  inherited;
  Notes.Lines.Text := Notes.Lines.Text + ' :- (' + AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName +
    ')' + FormatDateTime('dddd mmmm d yyyy " at " hh:mm AM/PM', Now) + #13#10;
  EditDB(qryCustomers);
  qryCustomersNotes.AsString := Notes.Lines.Text;
  Notes.Update;
end;

procedure TfrmCustomer.btnAddfollowupnotedateClick(Sender: TObject);
begin
  inherited;
    if tbOtherFollowUpNotes.ReadOnly  then exit;
    editdb(TBOtherFollowUp);
    TBOtherFollowUpnotes.asString := StripDateTime(TBOtherFollowUpnotes.asString);
    TBOtherFollowUpnotes.asString := AddDateTime(lcdOnLoganyway, TBOtherFollowUpnotes.asString, true);
    Postdb(TBOtherFollowUp);
end;

procedure TfrmCustomer.FormResize(Sender: TObject);
begin
  inherited;
  if not self.IsFlag('FormInitialising') then begin
    RealignTabControl(TabCtl20, 4);
    RealignTabControl(MiscPageControl, 1);
    RealignTabControl(PageAddress, 1);
    RealignTabControl(pgCustomFields, 1);
  end;

end;

procedure TfrmCustomer.btnInvoiceClick(Sender: TObject);
var
  frm: TInvoiceGUI;
begin
  if Accesslevel >= 5 then Exit;
  if not CustomerSaved then exit;
  CommitTransaction;
  BeginTransaction;
  DisableForm;
  try
    inherited;
    frm := TInvoiceGUI(GetComponentByClassName('TInvoiceGUI'));
    if Assigned(frm) then begin
      frm.InitialiseStartup := true;
      frm.CustomerID := qryCustomers.FieldByName('ClientID').AsInteger;
      frm.FormStyle := fsMDIChild;
      frm.BringToFront;
      Application.ProcessMessages;
      fbSaveClicked:= True;
      Self.Close;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmCustomer.btnQuoteClick(Sender: TObject);
var
  frm: TQuoteGUI;
begin
  if Accesslevel >= 5 then Exit;
  if not CustomerSaved then exit;
  CommitTransaction;
  BeginTransaction;
  DisableForm;
  try
    inherited;
    frm := TQuoteGUI(GetComponentByClassName('TQuoteGUI'));
    if Assigned(Frm) then begin
      frm.InitialiseStartup := true;
      frm.CustomerID := qryCustomers.FieldByName('ClientID').AsInteger;
      frm.FormStyle := fsMDIChild;
      frm.BringToFront;
      Application.ProcessMessages;
      fbSaveClicked:= True;
      Self.Close;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmCustomer.btnSalesOrderClick(Sender: TObject);
var
  frm: TSalesOrderGUI;
begin
  if Accesslevel >= 5 then Exit;
  if not CustomerSaved then exit;
  CommitTransaction;
  BeginTransaction;
  DisableForm;
  try
    inherited;
    frm := TSalesOrderGUI(GetComponentByClassName('TSalesOrderGUI'));
    if Assigned(Frm) then begin
      frm.InitialiseStartup := true;
      frm.CustomerID := qryCustomers.FieldByName('ClientID').AsInteger;
      frm.FormStyle := fsMDIChild;
      frm.BringToFront;
      Application.ProcessMessages;
      fbSaveClicked:= True;
      Self.Close;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmCustomer.TabCtl20Resize(Sender: TObject);
begin
  inherited;
  if not RealignTabInProgress then begin
    RealignTabInProgress := true;
    if not self.IsFlag('FormInitialising') then begin
      RealignTabControl(TabCtl20, 2);
      RealignTabControl(MiscPageControl, 1);
      RealignTabControl(PageAddress, 1);
      RealignTabControl(pgCustomFields, 1);
    end;
    if TabCtl20.TabWidth > 130 then TabCtl20.TabWidth := TabCtl20.TabWidth - 1;
    RealignTabInProgress := false;
  end;
end;

procedure TfrmCustomer.grdRelatedClientExit(Sender: TObject);
begin
  inherited;
  if (grdRelatedClient.DataSource.DataSet.Active) then begin
    if (qryRelatedClients.State in [dsEdit, dsInsert]) then begin
      EditDB(grdRelatedClient.DataSource.DataSet);
      PostDB(grdRelatedClient.DataSource.DataSet);
      EditDB(grdRelatedClient.DataSource.DataSet);
    end;
  end;
end;

function TfrmCustomer.RelatedCustomerHascontributionAmount(relatedclientID:Integer):Boolean;
begin
  Result := false;
  with TempMyquery do Try
      Sql.Clear;
      Sql.Add('SELECT tblsales.ClientID as Records ');
      Sql.Add('FROM tblsales ');
      Sql.Add('WHERE tblsales.ClientID=' + IntToStr(relatedclientID) + ' AND ');
      Sql.Add('ifnull(ContributionAmount,0) <> 0');
      Open;
      if RecordCount >= 1 then begin
        Result := true;
      end;
  finally
    ClosenFree;
  end;
end;
procedure TfrmCustomer.wwIButton1Click(Sender: TObject);
var
  qryUpdate: TERPQuery;
  PaymentsManagement: TLockManagement;
begin
  inherited;
  PaymentsManagement := TLockManagement.Create;
  try
    if RelatedCustomerHascontributionAmount(qryRelatedClients.FieldByName('ChildClientID').AsInteger) then begin
      CommonLib.MessageDlgXP_Vista('The Related Customer Has Sales With Contribution Amount By This Customer.' + chr(13) +
        'Cannot Delete This Related Customer !' , mtWarning, [mbOK], 0);
      exit;
    end;
    if not PaymentsManagement.IsRelatedCustomerUsed(qryRelatedClients.FieldByName('ChildClientID').AsInteger) then begin
      qryUpdate := TERPQuery.Create(Self);
      qryUpdate.Connection := MyConnection;
      try
        qryUpdate.SQL.Clear;
        qryUpdate.Sql.Add('UPDATE tblclients ');
        qryUpdate.Sql.Add('SET ParentRelatedClientID=0 ');
        qryUpdate.Sql.Add('WHERE ClientID=' + IntToStr(qryRelatedClients.FieldByName('ChildClientID').AsInteger) + ';');
        try
          qryUpdate.Execute;
        except
        end;
        DeleteRecord(qryRelatedClients);
      finally
        FreeandNil(qryUpdate);
      end;
    end else begin
      CommonLib.MessageDlgXP_Vista('The Related Customer Has Invoices Paid By This Customer.' + #10#13#10#13 +
        'Cannot Delete This Related Customer !' + #10#13#10#13 +
        'N.B.' + #9 + 'This Customer''s Payments Are Applied To The Related Customer''s Invoices.' + #10#13 +
        #9 + 'Delete These Payments To Delete The Related Customer', mtWarning, [mbOK], 0);
    end;
  finally
    FreeandNil(PaymentsManagement);
  end;
end;

procedure TfrmCustomer.qryRelatedClientsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryRelatedClientsMasterClientID.AsInteger := qryCustomersClientID.AsInteger;
  qryRelatedClientsMasterCompany.AsString := qryCustomersCompany.AsString;
end;

procedure TfrmCustomer.qryRelatedClientsBeforePost(DataSet: TDataSet);
begin
  inherited;
  if qryRelatedClientsChildClientID.asInteger =0 then begin
    CancelDb(qryRelatedClients);
    abort;
  end;
end;

procedure TfrmCustomer.cboClientCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if cboClientR.SpecialItemSelected = false then begin
    EditDb(qryRelatedClients);
    //qryRelatedClientsChildCompany.AsString := cboClientR.LookupTable.FieldByName('Company').AsString;
    qryRelatedClientsChildClientID.AsInteger :=cboClientR.LookupTable.FieldByName('ClientID').AsInteger;
    PostDB(qryRelatedClients);
  end;
end;

procedure TfrmCustomer.qryRelatedClientsChildCompanyChange(Sender: TField);
begin
  inherited;
  qryRelatedClientsChildClientID.AsInteger := cboClientR.LookupTable.FieldByName('ClientID').AsInteger;
end;

procedure TfrmCustomer.edtSequenceKeyPress(Sender: TObject; var Key: char);
begin
  inherited;
  // Ensure the user only presses valid keys.
  if ((Key <> #8) and ((Key < '0') or (Key > '9'))) then begin
    Key := #0;
  end;
end;

procedure TfrmCustomer.wwDBEdit1DblClick(Sender: TObject);
begin
  inherited;
  btnARReportClick(btnARReport);
end;

procedure TfrmCustomer.grdCustomershippingoptionsEnter(Sender: TObject);
var
  x:Integer;
begin
  inherited;
  if cboPayorType.Items.count =0 then begin
    for x := Low(PayorTypeList) to High(PayorTypeList) do
      cboPayorType.Items.Add(PayorTypeList[x].Name);
  end;

  if qryCustomershippingoptions.recordcount =0 then begin
      for x := Low(ShipProviderList) to High(ShipProviderList) do begin
          qryCustomershippingoptions.Append;
          qryCustomershippingoptionsShipperType.asString := PackageProviderToStr(ShipProviderList[x].Provider);
          PostDB(qryCustomershippingoptions);
      end;
  end;
end;

procedure TfrmCustomer.grdShipAddressListCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if QrycustomerShipAddresslistCustomerPhysicalAddress.AsBoolean then
    AFont.Color := ClRed;
end;

procedure TfrmCustomer.grdShipAddressListDblClick(Sender: TObject);
begin
  inherited;

    if QrycustomerShipAddresslistCustomerPhysicalAddress.AsBoolean then begin
        MessageDlgXP_Vista('This is the physical address of' + NL+
          quotedstr(qryCustomersCompany.asString) +'.'+NL+'Please change it in the customer card', mtInformation, [mbOK], 0);
        TabCtl20.ActivePage := Address_Info;
        PageAddress.ActivePage := tabAddressmain;
        SetControlfocus(Street);
        Exit;
    end;
    OpenERPForm('TShipAddressGUI' ,  QrycustomerShipAddresslistShipAddressId.asInteger);
end;

procedure TfrmCustomer.wwDBLookupCombo2CloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  AssignComboAccessed(Sender);
  if not Modified then Exit;
  inherited;
  Qryclients_eParcelReturn_State.AsString := LookupTable.FieldByName('State').AsString;
  Qryclients_eParcelReturn_Postcode.AsString := LookupTable.FieldByName('Postcode').AsString;
  Qryclients_eParcelReturn_Country.asString := LookupTable.FieldByName('Country').asString;

end;

procedure TfrmCustomer.wwDBLookupCombo3CloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  AssignComboAccessed(Sender);
  if not Modified then Exit;
  inherited;
  Qryclients_eParcelRedir_State.AsString := LookupTable.FieldByName('State').AsString;
  Qryclients_eParcelRedir_Postcode.AsString := LookupTable.FieldByName('Postcode').AsString;
  Qryclients_eParcelReDir_Country.asString := LookupTable.FieldByName('Country').asString;
end;

procedure TfrmCustomer.tbOtherFollowUpNewRecord(DataSet: TDataSet);
begin
  inherited;
  tbOtherFollowUpEmployeeID.AsInteger := AppEnv.Employee.EmployeeID;
  if ContactFiltered then
    tbOtherFollowUpContactId.asInteger := FilteredContactId;
end;

procedure TfrmCustomer.btnRepairClick(Sender: TObject);
var
  frm: TRepairsGUI;
begin
  if Accesslevel >= 5 then Exit;
  DisableForm;
  try
    inherited;
    frm := TRepairsGUI(GetComponentByClassName('TRepairsGUI'));
    if Assigned(frm) then begin
//      frm.InitialiseStartup := true;
      frm.CustomerID := qryCustomers.FieldByName('ClientID').AsInteger;
      frm.FormStyle := fsMDIChild;
      frm.BringToFront;
      Application.ProcessMessages;
      Self.cmdOk.Click;
    end;
  finally
    EnableForm;
  end;//
end;

procedure TfrmCustomer.btnRepeatClick(Sender: TObject);
  procedure InsertRecords(const dates: array of TDateTime);
  var
    iCnt: integer;
  begin
    if tbOtherFollowup.RecordCount > 0 then begin
      if tbOtherFollowup.FieldByName('FollowupDate').AsDateTime = 0 then tbOtherFollowup.Delete;
    end;

    try
      for iCnt := 0 to Length(dates) - 1 do begin
        tbOtherFollowup.Insert;
        tbOtherFollowup.FieldByName('EmployeeID').AsInteger := AppEnv.Employee.EmployeeID;
        tbOtherFollowup.FieldByName('Done').AsString := 'F';
        tbOtherFollowup.FieldByName('FollowupDate').AsDateTime := DateOf(dates[iCnt]);
        tbOtherFollowup.FieldByName('CreationDate').AsDateTime := Date;
        tbOtherFollowup.FieldByName('IsCustomer').AsString := 'T';
        //        tbOtherFollowup.FieldByName('Hours').AsFloat := 0.0;
        tbOtherFollowup.FieldByName('ClientID').AsInteger := qryCustomers.FieldByName('ClientID').AsInteger;
        PostDB(tbOtherFollowup);
      end;

      // Ensure the followup table is returned to edit mode.
      EditDB(tbOtherFollowup);
      CommonLib.MessageDlgXP_Vista(Format('Inserted %d Repeats into Customer Followup Table', [Length(dates)]), mtInformation , [mbOK], 0);

    except
      on e: Exception do begin
        CommonLib.MessageDlgXP_Vista(e.Message + Chr(13) + 'Errors occured in ' + Self.ClassName, mtWarning, [mbOK], 0);
      end;
    end;
  end;
begin
  DisableForm;
  try
    inherited;
    with TRepeatFrm.Create(self, CommonDbLib.GetSharedMyDacConnection.Database) do begin
      try
        Caption := 'Repeat Customer Follow Up';

        ShowModal;

        if ModalResult = mrOk then begin
          InsertRecords(dates);
        end;
      finally
        Free;
      end;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmCustomer.txtCardNumberExit(Sender: TObject);
begin
  inherited;
  // Now check the credit card number.  If provided we must encrypt
  // the number and Save the encryption data to the backend.
  if not Empty(txtCardNumber.Text) then begin
    EditDB(qryCustomers);
    qryCustomers.FieldByName('CreditCardNumber').AsString := EncryptCreditCardNumber(txtCardNumber.Text);
    (*{$ifdef COMPILER_22_UP}
    qryCustomers.FieldByName('CreditCardNumber').AsString := CipherUtils.EncryptString(txtCardNumber.Text);
    {$else}
    qryCustomers.FieldByName('CreditCardNumber').AsString := lbBlowFish1.EncryptString(txtCardNumber.Text);
    {$endif}*)
    PostDB(qryCustomers);
  end;
end;
procedure TfrmCustomer.chkActiveClick(Sender: TObject);
begin
  inherited;
  if not TDBCheckBox(Sender).Focused then exit;

  if not TDBCheckBox(Sender).DataSource.DataSet.Active then Exit;
  if EditNoAbort(TDBCheckBox(Sender).DataSource.DataSet) then begin
    if TDBCheckBox(Sender).Checked then begin
      TDBCheckBox(Sender).DataSource.DataSet.FieldByName(TDBCheckBox(Sender).DataField).AsString := 'T'
    end else begin
      TDBCheckBox(Sender).DataSource.DataSet.FieldByName(TDBCheckBox(Sender).DataField).AsString := 'F';
    end;
    if (qryCustomersActive.AsString = 'F') and (RoundCurrency(qryCustomersBalance.AsFloat) <> 0.00) then begin
      qryCustomersActive.AsString := 'T';
      CommonLib.MessageDlgXP_Vista('This Customer Can''t Be Made Inactive' + #13#10#13#10 +
        'There Is a Balance Outstanding !', mtWarning, [mbOK], 0);
    end;
  end;
  SetGUIControllStates;
end;

procedure TfrmCustomer.btnServiceCycleClick(Sender: TObject);
var
  frm: TfrmServiceDescription;

  procedure InsertRecords(const dates: array of TDateTime);
  var
    iCnt: integer;
  begin
    if tbOtherFollowup.RecordCount > 0 then begin
      if tbOtherFollowup.FieldByName('FollowupDate').AsDateTime = 0 then tbOtherFollowup.Delete;
    end;

    try
      for iCnt := 0 to Length(dates) - 1 do begin
        tbOtherFollowup.Insert;
        tbOtherFollowup.FieldByName('EmployeeID').AsInteger := AppEnv.Employee.EmployeeID;
        tbOtherFollowup.FieldByName('Done').AsString := 'F';
        tbOtherFollowup.FieldByName('FollowupDate').AsDateTime := DateOf(dates[iCnt]);
        tbOtherFollowup.FieldByName('CreationDate').AsDateTime := Date;
        tbOtherFollowup.FieldByName('IsCustomer').AsString := 'T';
        tbOtherFollowup.FieldByName('Notes').AsString := ServiceCycleDescription.Result;
        //        tbOtherFollowup.FieldByName('Hours').AsFloat := 0.0;
        tbOtherFollowup.FieldByName('ClientID').AsInteger := qryCustomers.FieldByName('ClientID').AsInteger;
        PostDB(tbOtherFollowup);
      end;

      // Ensure the followup table is returned to edit mode.
      EditDB(tbOtherFollowup);
      CommonLib.MessageDlgXP_Vista(Format('Inserted %d Service Cycle Repeats into Customer Followup Table', [Length(dates)]), mtInformation , [mbOK], 0);

    except
      on e: Exception do begin
        CommonLib.MessageDlgXP_Vista(e.Message + Chr(13) + 'Errors occured in ' + Self.ClassName, mtWarning, [mbOK], 0);
      end;
    end;
  end;
begin
  DisableForm;
  try
    inherited;
    frm := TfrmServiceDescription(GetComponentByClassName('TfrmServiceDescription'));
    if Assigned(Frm) then begin
      with TfrmServiceDescription(frm) do begin
        //frm           := TfrmServiceDescription(GetComponentByClassName('TfrmServiceDescription'));
        frm.ReturnResult := @oTASDescription;
        frm.FormStyle := fsNormal;
        frm.ShowModal;

        Self.Paint;
        DNMPanel17.Paint;
        Self.pnlTitle.Invalidate;
      end;
    end;

    if not Empty(oTASDescription.Result) then begin
      with TRepeatFrm.Create(self, CommonDbLib.GetSharedMyDacConnection.Database) do begin
        try
          Caption := 'Service Cycle Repeat';

          ShowModal;

          if ModalResult = mrOk then begin
            InsertRecords(dates);
          end;
        finally
          Free;
        end;
      end;
    end;
  finally
    EnableForm;
  end;
end;


procedure TfrmCustomer.btnSMSClick(Sender: TObject);
var
  mobile: string;
  (*
  function ContactName: string;
  begin
    result := self.qryContactsContactFirstName.AsString;
    if self.qryContactsContactSurName.AsString <> '' then begin
      if result <> '' then result := result + ' ';
      result := result + self.qryContactsContactSurName.AsString;
    end;
  end;
  *)
begin
  if (SelectedContactMobile = '') or (not SMSUtils.NumberHasCorrectPrefix(SelectedContactMobile, MyConnection)) then
  begin
    if (SelectedContactMobile = '') then
      mobile := GetMobileNumberFromUser('Contact (' + SelectedContactName + ') does not have a mobile number.'#13#10'Please enter a number.')
    else
      mobile := GetMobileNumberFromUser('Contact (' + SelectedContactName +
        ') number format is incorrect.'#13#10'Please prefix number with "+" and country code.', mobile, MyConnection);
    if mobile <> '' then
    begin
    (*@@@TODO
      EditDb(qryContacts);
      qryContactsContactMOB.AsString := mobile;
      PostDb(qryContacts);
      if self.qryContactsIsPrimarycontact.AsBoolean then
      begin
        EditDb(qryCustomers);
        self.qryCustomersMobile.AsString := mobile;
      end;
    *)
    end
    else
      exit;
  end;

  TCorrespondenceGui.SMSCustomer(SelectedContactMobile, '',  self.qryCustomersClientID.AsInteger);

  qryDocuments.Refresh;
(*
  if (qryContactsContactMOB.AsString = '') or (not SMSUtils.NumberHasCorrectPrefix(qryContactsContactMOB.AsString, MyConnection)) then begin
    if (qryContactsContactMOB.AsString = '') then
      mobile := GetMobileNumberFromUser('Contact (' + ContactName +
        ') does not have a mobile number.' +#13#10 + 'Please enter a number.')
    else
      mobile := GetMobileNumberFromUser('Contact (' + ContactName +
        ') number format is incorrect.' +#13#10 + 'Please prefix number with "+" and country code.', mobile, MyConnection);
    if mobile <> '' then begin
      EditDb(qryContacts);
      qryContactsContactMOB.AsString := mobile;
      PostDb(qryContacts);
      if self.qryContactsIsPrimarycontact.AsBoolean then begin
        EditDb(qryCustomers);
        self.qryCustomersMobile.AsString := mobile;
      end;

    end
    else
      exit;
  end;

  TCorrespondenceGui.SMSCustomer(self.qryContactsContactMOB.AsString,
    '',
    self.qryCustomersClientID.AsInteger);

  qryDocuments.Refresh;
*)
end;

procedure TfrmCustomer.cboProductQryAfterOpen(DataSet: TDataSet);
begin
  inherited;
  cboProductQry.IndexFieldNames := QuotedStr('PARTNAME') + ' ASC CIS';
end;

procedure TfrmCustomer.cboTaxExceptionProductChange(Sender: TObject);
begin
  inherited;
  AssignComboAccessed(Sender);
end;

procedure TfrmCustomer.cboTaxExceptionProductCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if not Modified then Exit;
  AssignComboAccessed(Sender);
end;

procedure TfrmCustomer.chkdocumentsClick(Sender: TObject);
begin
  inherited;
  qryDocuments.filtered := false;
  if not chkdocuments.Checked then begin
    qryDocuments.filter   := 'Active = ''T''';
    qryDocuments.filtered := true;
  end;
end;

procedure TfrmCustomer.CheckCreateCustomerAccountNumber;
begin
  if bNewCust and (qryCustomers.FieldByName('ClientNo').AsString = '') then begin
    if (AppEnv.CompanyPrefs.AutoGenerateCustomerAccntNumber) then begin
      // Yes, generate number for this customer.
      qryCustomers.FieldByName('ClientNo').AsString := CommonDbLib.GetSequenceNumber(CommonDbLib.SEQ_CustAccountNumber(*,true, true*));
    end;
  end;
end;

procedure TfrmCustomer.CheckForEmails;
var
  MailReader: TMailReader;
  MailConfig: TEmailConfig;
  msg: string;
begin
  FreeAndNil(MailProgesss);
  MailProgesss := TProgressDialog.Create(self);
  MailProgesss.MaxValue := 100;
  MailProgesss.Step := 1;
  MailProgesss.Caption := 'Checking for Emails';
  MailProgesss.AllowCancel := true;
  MailProgesss.OnCancel := DoOnProgressCancel;
  MailProgesss.Execute;
  ProgressCanceled := false;
  MailReader := TMailReader.Create;
  MailConfig := TEmailConfig.Create(nil);
  try
    MailReader.Connection := TERPConnection(qryDocuments.Connection);
    MailConfig.Connection := TMyDacDataConnection.Create(MailConfig);
    MailConfig.Connection.Connection := qryDocuments.Connection;
    MailConfig.LoadSelect('EntityName = ' + QuotedStr(AppEnv.Employee.EmployeeName));
    if (MailConfig.Count > 0) then begin
      if MailConfig.ConfigValid then begin
        MailReader.Config.AsString := MailConfig.ConfigJSON;
        MailReader.EmailAddress := MailConfig.EmailAddress;
        MailReader.OnProgress := DoOnCheckForEmailsProgress;
        MailReader.OnGetMessageCount := DoOnGetMessageCount;
        try
          if MailReader.GetMail(msg) then begin

          end
          else begin

          end;

        finally
          //DoHideProgressBar;
        end;
      end;
    end;
  finally
    if Assigned(MailProgesss) then begin
      MailProgesss.CloseDialog;
      FreeAndNil(MailProgesss);
    end;
    MailReader.Free;
    MailConfig.Free;
  end;
  CloseDb(qryDocuments);
  OpenDb(qryDocuments);
end;

// ---------- File Attachment stuff --------------------------------------------

procedure TfrmCustomer.UpdateMe;
begin
  // update a field in tblClients to indicate that data has changed
  //  ie attachments have been added/removed
  if qryCustomers.Active then begin
    if not (qryCustomers.State in [dsEdit, dsInsert]) then
      EditDB(qryCustomers);
    qryCustomersLastUpdated.AsDateTime := Now;
  end;
  MainShippingAddress; // shipping address
end;

//------------------------------------------------------------------------------

procedure TfrmCustomer.cboAccountCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  Qryclients_eParcelChargeBackAcntID.asInteger := cboAccountQry.fieldbyname('AccountID').asInteger;
end;

procedure TfrmCustomer.cboBankCodeEnter(Sender: TObject);
begin
  inherited;
  opendb(qryBankCodes);
end;

procedure TfrmCustomer.edtBankAccBSBCheckValue(Sender: TObject; PassesPictureTest: boolean);
begin
  inherited;
  if PassesPictureTest = false then Abort;
end;

procedure TfrmCustomer.KeyIdChanged(const NewKeyId: integer);
begin
  logInuseform;
  if UserLock.Enabled and (AccessLevel < 5) then begin
    // remove all existing locks
    UserLock.UnlockAllCurrentInstance;

    if (KeyId > 0) then begin
      if not UserLock.Lock('tblClients', KeyId, Self.Caption) then begin
        AccessLevel := 5; // read only

        CommonLib.MessageDlgXP_Vista(UserLock.LockMessage + #13 + #10 + #13 + #10 + 'Access has been changed to read-only.',
          mtWarning, [mbOK], 0);
      end;
    end;
  end;
  //Freeandnil(fShipAddressList);
end;

procedure TfrmCustomer.lblChildmessageDblClick(Sender: TObject);
begin
  inherited;
  if qryCustomersParentRelatedClientID.AsInteger =0 then exit;

  DisableForm;
  try
      cmdNew.Enabled := false; //Stops Click Twice
      if not CustomerSaved then exit;

      CommitTransaction;
      fsNewCompanyName := Company.Text;
      Notify;
      SetRelatedChildID(qryCustomers);
      CommitTransaction;

      BeginTransaction;
      KeyID := qryCustomersParentRelatedClientID.AsInteger;
      fsNewCompanyName := GetClientName(qryCustomersParentRelatedClientID.AsInteger);
      FormShow(nil);
      cmdNew.Enabled := True;
      cmdOk.Enabled := True;
  finally
    EnableForm;
  end;

end;

procedure TfrmCustomer.CompleteComboNotInList(const aObserver: TObject);
//var
//  DisplayVal: string;
begin
  if Assigned(fLastComboAccessed) then begin
    SetControlFocus(fLastComboAccessed);
   end;
   InComboNotinList := False;
end;

function TfrmCustomer.ContactFiltered: boolean;
begin
  Result := (cboContactSelector.ItemIndex > 0);
end;

procedure TfrmCustomer.ContactsFormBeforeShow(Sender: TObject);
begin
  //F
end;

procedure TfrmCustomer.CopySpecialPricesToOtherCustomers;
begin
  With TfmCustomerSpecialPricecopy.create(Self) do try
    setCopyGroupDiscount(qryProdGroupDiscs.RecordCount>0, 'There are no Group Discounts.');
    setCopyPermanentDiscount (qryCustomers.FieldByName('Discount').AsFloat <>0, 'There is no Permanent Discount (%).');
    setCopySpecialProducts(qrySpecials.RecordCount>0, 'There are no Special Products');
    setCopySpecialProductDiscount(qryCustomers.FieldByName('SpecialDiscount').AsFloat <>0, 'There is no Special Product Discount (%).');

    Showmodal;
    if modalresult = mrCancel then exit;
    if not(CopyGroupDiscount) and not(CopyPermanentDiscount) and not(CopySpecialProducts) and not(CopySpecialProductDiscount) then Exit;
    fbCopyGroupDiscount:=CopyGroupDiscount;
    fbCopyPermanentDiscount:=CopyPermanentDiscount;
    fbCopySpecialProducts:=CopySpecialProducts;
    fbCopySpecialProductDiscount:=CopySpecialProductDiscount;
   if OpenERPListFormultiselect('TCustomerExpressListGUI',DoCustomerListBeforeShow, false,DoOnGridDataSelectMultiCustomer) then begin

   end;
  finally
    Free;
  end;
end;
procedure TfrmCustomer.CopySpecialPricesTocustomer(Thiscust :TCustomer; ClientID:Integer);
var
  custobj:TCustomer;
begin
  if clientId =0 then exit;
  //if not userlock.lock('tblclients' ,clientId) then exit;
  custobj := TCustomer.create(Self);
  try
    custobj.connection := TMyDacDataconnection.Create(custobj);
    custobj.connection.connection:=qryCustomers.connection;
    custobj.Load(clientID);
    if custobj.count =0 then exit;
    if not custobj.lock then exit;

    with custobj do begin
      if fbCopyGroupDiscount then begin
          custobj.GroupDiscountOverridesAll       :=Thiscust.GroupDiscountOverridesAll;
          custobj.SpecialProductPriceOverridesAll :=Thiscust.SpecialProductPriceOverridesAll;
          custobj.postdb;

          if Thiscust.ProductGroupDiscount.count >0 then begin
            Thiscust.ProductGroupDiscount.first;
            while Thiscust.ProductGroupDiscount.eof = false do begin
              if not custobj.ProductGroupDiscount.locate('Col1;Col2;Col3' , vararrayof([Thiscust.ProductGroupDiscount.Col1,Thiscust.ProductGroupDiscount.Col2,Thiscust.ProductGroupDiscount.Col3]), []) then begin
                custobj.ProductGroupDiscount.new;
                custobj.ProductGroupDiscount.CustomerName :=custobj.clientName;
                custobj.ProductGroupDiscount.clientID :=custobj.ID;
                custobj.ProductGroupDiscount.Col1 := Thiscust.ProductGroupDiscount.col1;
                custobj.ProductGroupDiscount.Col2 := Thiscust.ProductGroupDiscount.col2;
                custobj.ProductGroupDiscount.Col3 := Thiscust.ProductGroupDiscount.col3;
              end;
              custobj.ProductGroupDiscount.Discount := Thiscust.ProductGroupDiscount.Discount;
              custobj.ProductGroupDiscount.MustMatch := Thiscust.ProductGroupDiscount.MustMatch;
              custobj.ProductGroupDiscount.PostDB;
              Thiscust.ProductGroupDiscount.Next;
            end;
          end;
      end;
      stepProgressbar(custobj.ClientName +' -> Product Group Discount');
      if fbCopySpecialProducts then begin
          if Thiscust.SpecialProducts.count >0 then begin
            Thiscust.SpecialProducts.first;
            while Thiscust.SpecialProducts.eof = false do begin
                  if not custobj.SpecialProducts.locate('ProductID;UOM' , vararrayof([Thiscust.SpecialProducts.ProductID , Thiscust.SpecialProducts.UOM]), []) then begin
                    custobj.SpecialProducts.NEw;
                    custobj.SpecialProducts.CustomerId := custobj.ID;
                    custobj.SpecialProducts.ProductID := Thiscust.SpecialProducts.ProductID;
                    custobj.SpecialProducts.ProductName := Thiscust.SpecialProducts.ProductName;
                    custobj.SpecialProducts.UOM := Thiscust.SpecialProducts.UOM;
                    custobj.SpecialProducts.UOMMultiplier := Thiscust.SpecialProducts.UOMMultiplier;
                  end;
                  custobj.SpecialProducts.Description := Thiscust.SpecialProducts.Description;
                  custobj.SpecialProducts.OrigPrice := Thiscust.SpecialProducts.OrigPrice;
                  custobj.SpecialProducts.LinePrice := Thiscust.SpecialProducts.LinePrice;
                  custobj.SpecialProducts.IncludeInRun := Thiscust.SpecialProducts.IncludeInRun;
                  custobj.SpecialProducts.DateFrom := Thiscust.SpecialProducts.DateFrom;
                  custobj.SpecialProducts.DateTo := Thiscust.SpecialProducts.DateTo;
                  custobj.SpecialProducts.PostDB;
              Thiscust.SpecialProducts.Next;
            end;
          end;

      end;
      stepProgressbar(custobj.ClientName +' -> Special Products');
      if fbCopyPermanentDiscount then begin
         if Thiscust.Discount <> 0 then begin
          custobj.Discount :=Thiscust.Discount;
          custobj.postdb;
         end;
      end;
      stepProgressbar(custobj.ClientName +' -> Permanent Discount');
      if fbCopySpecialProductDiscount then begin
         if Thiscust.SpecialDiscount <> 0 then begin
          custobj.SpecialDiscount :=Thiscust.SpecialDiscount;
          custobj.postdb;
         end;
      end;
      stepProgressbar(custobj.ClientName +' -> Special Discount');
    end;
  finally
    Freeandnil(custobj);
  end;
end;
procedure TfrmCustomer.DoOnGridDataSelectMultiCustomer(Sender: TwwDbGrid);
var
  i: integer;
  custobj:TCustomer;
begin
  custobj := TCustomer.create(Self);
  try
    custobj.connection := TMyDacDataconnection.Create(custobj);
    custobj.connection.connection:=qryCustomers.connection;
    custobj.Load(qryCustomersClientID.asInteger);
    Sender.DataSource.DataSet.DisableControls;
    try
      showProgressbar(WAITMSG, Sender.SelectedList.Count*4, false);
      try
        for i := 0 to Sender.SelectedList.Count - 1 do begin
          Sender.DataSource.DataSet.GotoBookmark(Sender.SelectedList.Items[i]);
          CopySpecialPricesTocustomer(custobj, Sender.DataSource.DataSet.FieldByName('ClientID').AsInteger);
          stepProgressbar;
        end;
      finally
        HideProgressbar;
      end;
    finally
        Sender.DataSource.DataSet.EnableControls;
    end;
  finally
    FreeandNil(custobj);
  end;
end;

function TfrmCustomer.SelectedContactAddress: string;begin Result := CustomerContactListForm.qryMAin.FieldByName('Address').AsString;end;
function TfrmCustomer.SelectedContactCompany: string;begin  Result := CustomerContactListForm.qryMain.FieldByName('Company').AsString;end;
function TfrmCustomer.SelectedContactEMail: string;begin  Result := CustomerContactListForm.qryMain.FieldByName('EMail').AsString;end;
function TfrmCustomer.SelectedContactFax: string;begin  Result := CustomerContactListForm.qryMain.FieldByName('Fax').AsString;end;
function TfrmCustomer.SelectedContactFirstName: string;begin  Result := CustomerContactListForm.qryMain.FieldByName('FirstName').AsString;end;
function TfrmCustomer.SelectedContactId: integer;begin Result := CustomerContactListForm.qryMain.FieldByName('ContactId').AsInteger;end;
function TfrmCustomer.SelectedContactMobile: string;begin Result := CustomerContactListForm.qryMain.FieldByName('Mobile').AsString;end;
function TfrmCustomer.SelectedContactName: string;begin  Result := CustomerContactListForm.qryMain.FieldByName('ClientName').AsString;end;
function TfrmCustomer.SelectedContactState: string;begin  Result := CustomerContactListForm.qryMain.FieldByName('City').AsString + ' ' + CustomerContactListForm.qryMain.FieldByName('CountryState').AsString;end;

procedure TfrmCustomer.SetComboFocus(var Msg: TMessage);
begin
  if Assigned(fLastComboAccessed) then SetControlFocus(fLastComboAccessed);
end;


procedure TfrmCustomer.SetContactFilter(aContactId: integer);
var
  idx : integer;
begin
  if aContactId <= 0 then
    cboContactSelector.ItemIndex := 0
  else
  begin
    for idx := 1 to  cboContactSelector.Items.Count - 1 do
    begin
      if Integer(cboContactSelector.Items.Objects[idx]) = aContactId then
      begin
        cboContactSelector.ItemIndex := idx;
        Break;
      end;
    end;
  end;
end;

procedure TfrmCustomer.UpdateMe(const Cancelled: boolean; const aObject: TObject = nil);
var
  newtext:String;
begin
  inherited;
  if Cancelled then begin
    if Assigned(fLastComboAccessed) then begin
      fLastComboAccessed.Text := '';
      closenopendb(fLastComboAccessed.LookupTable);
    end;
  end
  else begin
    if assigned(fLastComboAccessed) and Assigned(aObject) and (aObject is TBaseInputGUI) then begin
      newtext :=fLastComboAccessed.text;
      (* if Assigned(aObject) and aObject.ClassNameIs('TfrmCustomFields') then begin
          if Equipmentform<> nil then
            Equipmentform.CustomFieldsRefresh;
      end else  *)
      if Sysutils.SameText(fLastComboAccessed.Name, 'cboCreditCardType') then begin
        with fLastComboAccessed do begin
          closenopendb(LookupTable);
          if LookupTable.Locate('Name', newtext, []) then begin
            EditDB(qryCustomers);
            qryCustomersCreditCardType.asString := LookupTable.FieldByName('Name').asString;
            PostDB(qryCustomers);
          end;
        end;
      end else if Sysutils.SameText(fLastComboAccessed.Name, 'cboShippingAgent') then begin
        with fLastComboAccessed do begin
          closenopendb(LookupTable);
          LookupTable.Locate('ShippingAgentID', TBaseInputGUI(aObject).KeyID, []);
          EditDB(qryCustomers);
          qryCustomersShippingAgentID.AsInteger := LookupTable.FieldByName('ShippingAgentID').AsInteger;
          cboShippingAgentCloseUp(fLastComboAccessed, LookupTable, qryCustomers, true);
        end;
      end else if Sysutils.SameText(fLastComboAccessed.Name, 'cboProd') then begin
        with fLastComboAccessed do begin
          closenopendb(LookupTable);
          LookupTable.Locate('PartsId', TBaseInputGUI(aObject).KeyID, []);
          EditDB(qrySpecials);
          qrySpecialsProductID.AsInteger := LookupTable.FieldByName('PartsID').AsInteger;
          cboProdCloseUp(fLastComboAccessed, LookupTable, qrySpecials, true);
        end;
      end else if Sysutils.SameText(fLastComboAccessed.Name, 'cboRep') then begin
        with fLastComboAccessed do begin
          closenopendb(LookupTable);
          LookupTable.Locate('EmployeeId', TBaseInputGUI(aObject).KeyID, []);
          EditDB(qryCustomers);
          qryCustomersRepID.AsInteger := LookupTable.FieldByName('EmployeeID').AsInteger;
          cboRepCloseUp(fLastComboAccessed, LookupTable, qryCustomers, true);
        end;
      end else if Sysutils.SameText(fLastComboAccessed.Name, 'Suburb') then begin
        with fLastComboAccessed do begin
          closenopendb(LookupTable);
          LookupTable.Locate('LocationId', TBaseInputGUI(aObject).KeyID, []);
          EditDB(qryCustomers);
          qryCustomersSuburb.AsString := LookupTable.FieldByName('City_sub').AsString;
          SuburbCloseUp(fLastComboAccessed, LookupTable, qryCustomers, true);
        end;
      end else if Sysutils.SameText(fLastComboAccessed.Name, 'BillSuburb') then begin
        with fLastComboAccessed do begin
          closenopendb(LookupTable);
          LookupTable.Locate('LocationId', TBaseInputGUI(aObject).KeyID, []);
          EditDB(qryCustomers);
          qryCustomersBillSuburb.AsString := LookupTable.FieldByName('City_sub').AsString;
          BillSuburbCloseUp(fLastComboAccessed, LookupTable, qryCustomers, true);
        end;
      end else if Sysutils.SameText(fLastComboAccessed.Name, 'cboClientType') then begin
        with fLastComboAccessed do begin
          closenopendb(LookupTable);
          LookupTable.Locate('ClientTypeID', TBaseInputGUI(aObject).KeyID, []);
          EditDB(qryClientTypes);
          fLastComboAccessed.Text := LookupTable.fieldbyname('TypeName').AsString;
          qryCustomersClientTypeID.AsInteger := LookupTable.FieldByName('ClientTypeID').AsInteger;
          UpdateClientTypeData;
        end;
      end else if Sysutils.SameText(fLastComboAccessed.Name, 'cboMediaType') then begin
        with fLastComboAccessed do begin
          closenopendb(LookupTable);
          LookupTable.Locate('MedTypeID', TBaseInputGUI(aObject).KeyID, []);
          qryCustomersMedTypeID.AsInteger := LookupTable.FieldByName('MedTypeID').AsInteger;
          cboMediaTypeCloseUp(fLastComboAccessed, LookupTable, qryCustomers, true);
        end;
      end else if Sysutils.SameText(fLastComboAccessed.Name, 'cbolookupPrescribers') then begin
        with fLastComboAccessed do begin
          closenopendb(LookupTable);
          LookupTable.Locate('Providernum', combonotInlistValue, []);
        end;
      end;
    end
    else begin
      if Assigned(aObject) then begin
        if (aObject.Classname = 'TfrmContact') then
        begin
          if TfrmContact(aObject).Contact.IsPrimaryContact then begin
            PostDb(qryCustomers);
            qryCustomers.Refresh;
          end;
          (*
          if qryContacts.Active then
            qryContacts.Refresh;
          *)
          MainShippingAddress;  // refresh in case we created new shipping in contact form
          EditDB(qryCustomers);
          qryCustomersLastUpdated.AsDateTime := Now;
          CustomerContactListForm.DoRefreshQuery;
          if chkShowAll.Checked then
            CustomerContactListForm.FilterString := ''
          else
            CustomerContactListForm.FilterString := '(Active = "T")';
        end
        else if aObject.ClassNameIs('TfmCustomerCorrespondenceCreate') then begin
          CloseDb(qryDocuments);
          OpenDb(qryDocuments);
        end;
      end
    end;
  end;
end;


{
procedure TfrmCustomer.UpdatePrimaryContact;
begin
(*
  if (qryContacts.State <> dsBrowse) or
     (qryContactsIsPrimaryContact.Value <> 'T') or
     (qryContactsClientId.Value <> qryCustomersClientId.Value) then
    exit;
  qryContacts.Edit;
  qryContactsJobTitle.Value := qryCustomersJobTitle.Value;
  qryContactsContactFirstName.Value :=  qryCustomersFirstName.Value;
  qryContactsContactSurName.Value := qryCustomersLastName.Value;
  qryContactsContactPh.Value := qryCustomersPhone.Value;
  qryContactsContactFax.Value := qryCustomersFaxNumber.Value;
  qryContactsContactMOB.Value := qryCustomersMobile.Value;
  qryContactsContactAltPh.Value := qryCustomersAltPhone.Value;
//  .Value := qryCustomersAltName.Value;
//  .Value := qryCustomersAltContact.Value;
//  qryContacts.Post;
  PostDb(qryContacts);
*)
end;
}
procedure TfrmCustomer.cboProdChange(Sender: TObject);
begin
  inherited;
  AssignComboAccessed(Sender);
end;

procedure TfrmCustomer.cboRepChange(Sender: TObject);
begin
  inherited;
  AssignComboAccessed(Sender);
end;

procedure TfrmCustomer.cboRepCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  AssignComboAccessed(Sender);
end;

procedure TfrmCustomer.cboRepEnter(Sender: TObject);
begin
  inherited;
  if not CanChangeCustomerRep then
    if qryCustomersRepID.asInteger <> 0 then begin
      cboRep.Readonly := True;
      if devmode then ShowTimedHint(cboRep ,'You Don''t Have Access to Change The Representative.', False , 5000);
    end;
end;

procedure TfrmCustomer.SuburbChange(Sender: TObject);
begin
  inherited;
  AssignComboAccessed(Sender);
end;

procedure TfrmCustomer.BillSuburbChange(Sender: TObject);
begin
  inherited;
  AssignComboAccessed(Sender);
end;

procedure TfrmCustomer.cboTermsChange(Sender: TObject);
begin
  inherited;
  AssignComboAccessed(Sender);
end;

procedure TfrmCustomer.cboTermsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  AssignComboAccessed(Sender);
  qryCustomers.fieldbyname('Terms').asstring := cboTerms.text;
end;

procedure TfrmCustomer.cboUOMCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if not modified then Exit;
  inherited;
  if filltable.State = dsCalcFields then exit;
  EditDB(Filltable);
  if InitUOM(Lookuptable.fieldbyname('UnitName').asString , Lookuptable)<>0 then begin
    filltable.fieldbyname('UOMID').asInteger      := Lookuptable.fieldbyname('UnitId').asInteger;
    filltable.fieldbyname('UOM').asString         := Lookuptable.fieldbyname('UnitName').asString;
    filltable.fieldbyname('UOMMultiplier').asfloat:= Lookuptable.fieldbyname('Multiplier').Asfloat;
  end else begin
    cancelDb(filltable);
  end;
  PostDB(Filltable);
  EditDB(Filltable);

end;
procedure TfrmCustomer.cboUOMDropDown(Sender: TObject);
begin
  inherited;
  if (QryUOM.active =False) or (QryUOM.parambyname('KeyId').asInteger <> qrySpecialsProductID.asInteger) then begin
    closedb(QryUOM);
    QryUOM.parambyname('KeyId').asInteger :=  qrySpecialsProductID.asInteger;
    opendb(QryUOM);
  end;
end;

function TfrmCustomer.InitUOM(const UOMName:String; UOMQry :Tdataset):Integer;
var
  Product:TProduct;
begin
  result:= 0;
  Product:=TProduct.Create(Self);
  try
    Product.Connection := TMyDacDataConnection.Create(product);
    Product.Connection.Connection := qryProduct.Connection;
    Product.Load(qrySpecialsProductID.AsInteger);
    Product.UOMList.Closedb;
    Product.UOMList.OpenDb;
    if Product.ProductUOMLocate(UOMName)  then begin
       result:= Product.UOMList.ID;
       closedb(UOMQry);
       openDb(UOMQry);
       UOMQry.Locate('unitID' , result, []);
    end;
  finally
    Freeandnil(Product);
  end;
end;
procedure TfrmCustomer.AssignComboAccessed(Sender: TObject);
begin
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
end;

procedure TfrmCustomer.cboClientNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
begin
  // inherited;  {Cannot Created New Customer From Customer}
  Accept := False;
end;

procedure TfrmCustomer.cboClientRAfterchange(Sender: TObject);
begin
  inherited;
  cboClientCloseup(cboClientR , cboClientR.Lookuptable , cboClientR.Datasource.dataset , True);
  (* if cboClientR.SpecialItemSelected =False then begin
    if (cboClientR.Lookuptable.Locate('Company' ,cboClientR.Text , [])) then begin
      EditDb(qryRelatedClients);
      qryRelatedClientsChildClientID.asInteger :=cboClientR.Lookuptable.Fieldbyname('ClientId').asInteger;
      PostDB(qryRelatedClients);
    end;
  end; *)
end;

procedure TfrmCustomer.cboClientRBeforeOpenList(Sender: TObject);
var
  fsFilter:String;
begin
  inherited;
  (*if (Sender is TCustomerExpressListGUI)  then begin
    With TCustomerExpressListGUI(Sender) do begin
      fsFilter := FilterString;
      if fsfilter <> '' then fsfilter := '(' + fsfilter + ') and ';
      FilterString := fsFilter + '( IsJob = "F" ParentClientID =0 and ParentRelatedClientID =0 and clientId <> ' +inttostr(qryCustomers.FieldByName('ClientID').AsInteger)+')';
    end;
  end else *)if (Sender is TCustomerListGUI)  then begin
    With TCustomerListGUI(Sender) do begin
      fsFilter := FilterString;
      if fsfilter <> '' then fsfilter := '(' + fsfilter + ') and ';
      FilterString := fsFilter + '( IsJob = "F" and Relatedclients =0 and RelatedClientID =0 and ParentRelatedClientID =0 and clientId <> ' +inttostr(qryCustomers.FieldByName('ClientID').AsInteger)+')';
    end;
  end
end;


procedure TfrmCustomer.btnOtherPhonesClick(Sender: TObject);
Var
  frm: TfrmClientsOtherPhone;
begin
  inherited;
  frm := TfrmClientsOtherPhone(GetComponentByClassName('TfrmClientsOtherPhone'));
  if Assigned(frm) then begin
    frm.KeyID := qryCustomers.FieldByName('ClientID').AsInteger;
    frm.FormStyle := fsMDIChild;
    frm.BringToFront;
    Application.ProcessMessages;
  end;
end;

procedure TfrmCustomer.UpdateClientTypeData;
begin
  if MessageDlgXP_Vista('Do You Want to Change Terms/Credit Limits for This Customer?', mtWarning, [mbYes, mbNo], 0) = mrYes then
  begin
    qryCustomers.FieldByName('TermsID').AsInteger :=    qryClientTypes.FieldByName('TermsID').AsInteger;
    qryCustomers.FieldByName('CreditLimit').AsCurrency :=    qryClientTypes.FieldByName('CreditLimit').AsInteger;
    qryCustomers.FieldByName('GracePeriod').AsInteger :=     qryClientTypes.FieldByName('GracePeriod').AsInteger;
    if qryCustomersCallPriority.asInteger < qryClientTypescallpriority.asInteger then
    begin
      editDB(qryCustomers);
      qryCustomersCallPriority.asInteger := qryClientTypescallpriority.asInteger;
      PostDB(qryCustomers);
    end;
  end;
end;

procedure TfrmCustomer.cboMediaTypeCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
  AssignComboAccessed(Sender);
end;
{
procedure TfrmCustomer.grdContactKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  field: TField;
begin
  inherited;
  (*
  field := grdContact.GetActiveField;
  if Assigned(field) and (field.FieldName = 'ContactName') then
    CommonLib.MessageDlgXP_Vista('This is a read only field.'+#13+#10+'Please use the Edit or New button to modify it.', mtInformation, [mbOK], 0);
    *)
end;
}
procedure TfrmCustomer.btnContactCustomiseClick(Sender: TObject);
begin
  inherited;
  CustomerContactListForm.btnCustomizeClick(Sender);
end;

procedure TfrmCustomer.btnContactMessageClick(Sender: TObject);
var
  OptsForm: TfmReportingOptions;
begin
  if CustomerContactListForm.qryMain.RecordCount = 0 then
    exit;

  OptsForm := TfmReportingOptions.Create(nil);
  try
    OptsForm.ActionList.AddDivider('Send A ');
    OptsForm.ActionList.Add('Letter', 'Send A Letter To ' + SelectedContactName, LetterBtnClick, false, true);
    OptsForm.ActionList.Add('EMail', 'Send E-mail To ' + SelectedContactName, EmailBtnClick, false, true);
    OptsForm.ActionList.Add('SMS', 'Send SMS To ' + SelectedContactName, btnSMSClick, false, true);
    OptsForm.ShowModal;
  finally
    OptsForm.Free;
  end;
end;

procedure TfrmCustomer.btnCopyReturnAddressClick(Sender: TObject);
begin
  inherited;
    EditDB(Qryclients_eParcel);Qryclients_eParcelReturn_Company.AsString   := Appenv.CompanyInfo.CompanyName;
    EditDB(Qryclients_eParcel);Qryclients_eParcelReturn_Name.AsString      := Appenv.CompanyInfo.CompanyName;
    EditDB(Qryclients_eParcel);Qryclients_eParcelReturn_Street1.AsString   := Appenv.CompanyInfo.Address;
    EditDB(Qryclients_eParcel);Qryclients_eParcelReturn_Street2.AsString   := Appenv.CompanyInfo.Address2;
    EditDB(Qryclients_eParcel);Qryclients_eParcelReturn_Street3.AsString   := Appenv.CompanyInfo.Address3;
    EditDB(Qryclients_eParcel);Qryclients_eParcelReturn_Suburb.AsString    := Appenv.CompanyInfo.City;
    EditDB(Qryclients_eParcel);Qryclients_eParcelReturn_State.AsString     := Appenv.CompanyInfo.State;
    EditDB(Qryclients_eParcel);Qryclients_eParcelReturn_Country.AsString   := Appenv.CompanyInfo.Country;
    EditDB(Qryclients_eParcel);Qryclients_eParcelReturn_Postcode.AsString  := Appenv.CompanyInfo.Postcode;
end;

procedure TfrmCustomer.btnCopySpecialPricesClick(Sender: TObject);
begin
  inherited;
  if MessageDlgXP_Vista('This will save the current changes. Do you Wish to Continue? ', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
  if not CustomerSaved then exit;
  CommitTransaction;
  BeginTransaction;
  cmdOk.Enabled := true;

  if (qrySpecials.RecordCount > 0) or (qryProdGroupDiscs.RecordCount > 0) or (qryCustomers.FieldByName('Discount').AsFloat <>0) or (qryCustomers.FieldByName('SpecialDiscount').AsFloat <> 0)  then begin
    self.CopySpecialPricesToOtherCustomers;
  end
  else begin
    CommonLib.MessageDlgXP_Vista('There are are no Special Products/Group Discounts/Discount Amounts to copy.',mtInformation,[mbOk],0);
  end;
end;

procedure TfrmCustomer.btnCustomiseClick(Sender: TObject);
begin
  inherited;
  GuiPrefs.ShowCustomiseForm('Contacts');
end;

procedure TfrmCustomer.btnCustStatementClick(Sender: TObject);
var
  frm: TPrintStatement;
begin
  DisableForm;
  try
    inherited;
    if FormStillOpen('TPrintStatement') then TPrintStatement(FindExistingComponent('TPrintStatement')).Close;
    Application.ProcessMessages;
    if not FormStillOpen('TPrintStatement') then begin
      frm := TPrintStatement(GetComponentByClassName('TPrintStatement'));
      if Assigned(frm) then begin
        frm.ARClientID := qryCustomers.FieldByName('ClientID').AsInteger;
        frm.FormStyle := fsMDIChild;
        frm.grd.SelectRecord;
        frm.BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmCustomer.btnARReportClick(Sender: TObject);
Var
  Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    if FormStillOpen('TAccountsReceiveListGUI') then TAccountsReceiveListGUI(FindExistingComponent('TAccountsReceiveListGUI')).Close;
    Application.ProcessMessages;
    if not FormStillOpen('TAccountsReceiveListGUI') then begin
      Form := GetComponentByClassName('TAccountsReceiveListGUI');
      if Assigned(Form) then begin
        with TAccountsReceiveListGUI(Form) do begin
          ARClientID := qryCustomers.FieldByName('ClientID').AsInteger;
          FormStyle := fsMDIChild;
          BringToFront;
        end;
      end;
    end;
    Application.ProcessMessages;
  finally
    EnableForm;
  end;
end;

procedure TfrmCustomer.qrySuburbBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qrySuburb.Params.ParamByName('xRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

procedure TfrmCustomer.qryTaxCodesBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryTaxCodes.ParamByName('RegionID').asInteger             := AppEnv.RegionalOptions.ID;
  qryTaxCodes.ParamByName('Clientcountry').asString         := qryCustomersCountry.asString;
  qryTaxCodes.ParamByName('ClientState').asString           := qryCustomersState.AsString;
  qryTaxCodes.ParamByName('clientLocation').asString        := qryCustomersSuburb.asString;
  qryTaxCodes.ParamByName('ClientPostcode').asString        := qryCustomersPostcode.asString;
  qryTaxCodes.ParamByName('filterTaxcodeforClient').asString:= BooleanToStr(AppEnv.companyprefs.filterTaxcodeforClient);
(*  qryTaxCodes.ParamByName('FilterTaxcodeonState').AsString := Booleantostr(appenv.companyprefs.filterTaxcodeforClientState);
  qryTaxCodes.ParamByName('State').asString                := qryCustomersState.AsString;
  qryTaxCodes.ParamByName('ShowBlankStae').asString        := Booleantostr(appenv.companyprefs.ShowTaxwithNostate);*)
  TaxCodecomboHint(cboTaxCode);
end;

procedure TfrmCustomer.qryTaxCodesCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryTaxCodescRate.AsFloat := qryTaxCodesRate.AsFloat * 100;
end;

procedure TfrmCustomer.qryTaxExceptionProductsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryTaxExceptionProductsClientID.AsInteger   := qryCustomersClientID.AsInteger;
  qryTaxExceptionProductsClientName.AsString  := qryCustomersCompany.AsString;
  qryTaxExceptionProductsActive.AsBoolean     := True;
end;

procedure TfrmCustomer.qryTaxExceptionProductsBeforePost(DataSet: TDataSet);
begin
  inherited;
  if (qryTaxExceptionProductsClientID.AsInteger =0) or (qryTaxExceptionProductsProductId.AsInteger =0) then begin
    qryTaxExceptionProducts.Cancel;
    abort;
  end;
end;

Function TfrmCustomer.IsProductUnique(ProductName:String; ID:Integer):Boolean;
begin
  REsult:= TClientTaxExceptionProducts.IsUnique(qryTaxExceptionProductsID.asInteger ,
              'ClientId = ' + inttostr(qryTaxExceptionProductsClientID.asInteger) +
              ' and ProductId = ' + inttostr(qryTaxExceptionProductsProductId.AsInteger) ,
              qryTaxExceptionProducts.connection );
end;
procedure TfrmCustomer.qryTaxExceptionProductsProductNameChange(Sender: TField);
begin
  inherited;
  if qryTaxExceptionProductsProductName.AsString = '' then exit;
  if not(IsProductUnique(qryTaxExceptionProductsProductName.AsString , qryTaxExceptionProductsID.AsInteger )) then begin
    qryTaxExceptionProducts.Cancel;
    abort;
    Exit;
  end;
  qryTaxExceptionProductsProductId.AsInteger := TProduct.idtoggle(qryTaxExceptionProductsProductName.AsString);
end;

procedure TfrmCustomer.qryTermsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if  not(CanChangeCustomerTerms) then begin
    cboTerms.hint := 'You don''t have access to change the Terms';
    cboTerms.showhint := True;
    cboTerms.Parentshowhint := False;
    cboTerms.ReadOnly := True;
  end;

end;

procedure TfrmCustomer.XMLEmailExit(Sender: TObject);
begin
  inherited;
  if XMLEmail.Text = '' then exit;
  if FastFuncs.PosEx('@',XMLEmail.Text) = 0 then begin
    CommonLib.MessageDlgXP_Vista(XMLEmail.Text + ' is not a valid address.', mtInformation, [mbOK], 0);
    SetControlFocus(XMLEmail);
    exit;
  end;
end;

procedure TfrmCustomer.EmailExit(Sender: TObject);
begin
  inherited;
  if Email.Text = '' then exit;
  if FastFuncs.PosEx('@',Email.Text) = 0 then begin
    CommonLib.MessageDlgXP_Vista(Email.Text + ' is not a valid address.', mtInformation, [mbOK], 0);
    SetControlFocus(Email);
    exit;
  end;
end;

procedure TfrmCustomer.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  if (not fbSaveClicked) and IsOkToSave() then begin
    CanClose := SaveorcancelChanges;
  end;
  if not CanClose then begin
    if Assigned(StateParams) then
      StateParams.Clear;
  end;
end;
function TFrmCustomer.SaveOrCancelChanges:boolean;
var
  iExitResult: integer;
begin
  REsult := true;
  (*if fbIsModified or IsModified(memqryCustomers, qryCustomers) then begin*)
      iExitResult := CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation,
        [mbYes, mbNo, mbCancel], 0);
      case iExitResult of
        mrYes:
          begin
            result := CustomerSaved;
            if result then begin
              CommitTransaction;
              Notify(False);
            end;
          end;
        mrNo:
          begin;
            RollbackTransaction;
            Notify(True);
            REsult := true;
          end;
        mrCancel: REsult := false;
      end;
    (*end;*)
end;
procedure TfrmCustomer.grdRelatedClientFieldChanged(Sender: TObject;
  Field: TField);
begin
  inherited;
  fbIsModified := true;
end;

procedure TfrmCustomer.grdFollowUpFieldChanged(Sender: TObject;
  Field: TField);
begin
  inherited;
  fbIsModified := true;
end;

procedure TfrmCustomer.grdFollowUpRowChanged(Sender: TObject);
begin
  if self.IsFlag('grdFollowUpRowChange') then exit;
  self.AddFlag('grdFollowUpRowChange');
  try
    inherited;
    grdFollowUpColEnter(grdFollowUp);
  finally
    self.RemoveFlag('grdFollowUpRowChange');
  end;
end;

procedure TfrmCustomer.grdSpecialsFieldChanged(Sender: TObject;
  Field: TField);
begin
  inherited;
  fbIsModified := true;
end;

procedure TfrmCustomer.grdProdGroupDiscsFieldChanged(Sender: TObject;
  Field: TField);
begin
  inherited;
  fbIsModified := true;
end;

procedure TfrmCustomer.grdReferralsFieldChanged(Sender: TObject;
  Field: TField);
begin
  inherited;
  fbIsModified := true;
end;

procedure TfrmCustomer.grdTaxExceptionProductsDblClick(Sender: TObject);
begin
  inherited;
  EditDB(qryTaxExceptionProducts);
  qryTaxExceptionProductsActive.AsBoolean := True;
  PostDb(qryTaxExceptionProducts);
end;

procedure TfrmCustomer.grdContactFieldChanged(Sender: TObject;
  Field: TField);
begin
  inherited;
  fbIsModified := true;
end;

procedure TfrmCustomer.cboDefaultARAccountNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  EditDB(qryCustomers);
  qryCustomersDefaultARAccountID.AsInteger := QryARAccountsAccountID.AsInteger;
end;

procedure TfrmCustomer.cboDeliveryCodeCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  EditDB(qryCustomers);
end;

procedure TfrmCustomer.grdFollowUpDblClick(Sender: TObject);
var
  Form: TBaseInputGUI;
  id : integer;
begin
  if (tbOtherFollowUp.State = dsInsert) and not tbOtherFollowUp.FieldByName('FollowUpDate').IsNull
      and not tbOtherFollowUp.FieldByName('EmployeeName').IsNull then begin
    PostDB(tbOtherFollowUp);
  end;
  inherited;
  if tbOtherFollowUp.RecNo > 0 then
    if tbOtherFollowUpLeadLineID.AsInteger = 0 then begin
      AppContext['TfmFollowUp'].VarByName['SetFocus'] := 'cboFollowUpResult';
      try
        if ContactFiltered then
          id := FilteredContactId
        else if tbOtherFollowUp.FieldByName('ContactId').AsInteger > 0  then // edit existing
          id := tbOtherFollowUp.FieldByName('ContactId').AsInteger
        else  // create new without contact
          id := 0;
        frmFollowUp.DoFollowUp(0, tbOtherFollowUpFollowUpID.AsInteger, Self.MyConnection, Self, id);
      finally
        AppContext.DeleteContext('TfmFollowUp');
      end;
    end else begin
      Form := TBaseInputGUI(GetComponentByClassName('TfmMarketingLead'));
      if Assigned(Form) then begin
        Form.KeyID := FieldByNameValue('SELECT LeadID FROM tblMarketingleadlines WHERE LeadLineID = '
          + IntToStr(tbOtherFollowUpLeadLineID.AsInteger), 'LeadID', AsInteger);
        Form.FormStyle := fsMDIChild;
        Form.BringToFrontSoon;
      end;
    end;
end;

procedure TfrmCustomer.grdFollowUpEnter(Sender: TObject);
begin
  inherited;
  grdFollowUpColEnter(grdFollowUp);
end;

procedure TfrmCustomer.GlobalEventHandler(const Sender: TObject; const Event: string; const Data: Pointer);
begin
  closenopendb(tbOtherFollowUp);
end;

procedure TfrmCustomer.tbOtherFollowUpAfterScroll(DataSet: TDataSet);
  procedure FollowUpFieldsReadOnly(const Value: Boolean);
  begin
    tbOtherFollowUpFollowUpDate.ReadOnly := Value;
    tbOtherFollowUpNotes.ReadOnly := Value;
    tbOtherFollowUpEmployeeName.ReadOnly := Value;
    tbOtherFollowUpDone.ReadOnly := Value;
  end;
begin
  FollowUpFieldsReadOnly(tbOtherFollowUpLeadLineID.AsInteger <> 0);
end;

procedure TfrmCustomer.tbOtherFollowUpBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  if (tbOtherFollowUp.RecordCount > 0) and (tbOtherFollowUpFollowUpDate.AsDateTime = 0) then
    abort;
end;

procedure TfrmCustomer.Callcontactform(Sender: TDNMSpeedbutton);
var
  frmContact : TfrmContact;
begin
  PostDB(qryCustomers);
  fLastComboAccessed:= nil;
  // frmContact is freed in its OnClose event, so we do not need to free it here
  // Be careful - we have to create it every time!
  frmContact := TfrmContact.Create(self);

  frmContact.AttachObserver(self);
  if Sender = EditBtn then
    frmContact.KeyID := SelectedContactId
  else
    frmContact.KeyID := 0;

  frmContact.PassedConnection := Self.MyConnection;
  frmContact.ClientID := qryCustomers.FieldByName('Clientid').asInteger;
  frmContact.ClientName:= qryCustomersCompany.asString;
  ContactCreated := frmContact.ShowModal = mrOK;
  (*TCustomerContactListGui(CustomerContactListForm).RefreshQuery;*)
  TCustomFieldValuesListContactGUI(CustomerContactListForm).RefreshQuery;
end;

procedure TfrmCustomer.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if TabCtl20.ActivePage = TTabSheet(History) then begin
    case grpHistory.ItemIndex of
          0:  if assigned(fListAppoints)      then fListAppoints.OnKeyUp(fListAppoints,Key,Shift);
          1:  if assigned(fListArNotes)       then fListArNotes.OnKeyUp(fListArNotes,Key,Shift);
          2:  if assigned(fListInvoices)      then fListInvoices.OnKeyUp(fListInvoices,Key,Shift);
          3:  if assigned(fListJobprofit)     then fListJobprofit.OnKeyUp(fListJobprofit,Key,Shift);
          4:  if assigned(fListJobs)          then fListJobs.OnKeyUp(fListJobs,Key,Shift);
          5:  if assigned(fListProductSales)  then fListProductSales.OnKeyUp(fListProductSales,Key,Shift);
          6:  if assigned(fListQuotes)        then fListQuotes.OnKeyUp(fListQuotes,Key,Shift);
          7:  if assigned(fRepairList)        then fRepairList.OnKeyUp(fRepairList,Key,Shift);
          8:  if assigned(fRewardPoints)      then fRewardPoints.OnKeyUp(fRewardPoints,Key,Shift);
          9:  if assigned(fListSalesOrder)    then fListSalesOrder.OnKeyUp(fListSalesOrder,Key,Shift);
         10:  if assigned(fListStatements)    then fListStatements.OnKeyUp(fListStatements,Key,Shift);
         11:  if assigned(fListTimesheet)     then fListTimesheet.OnKeyUp(fListTimesheet,Key,Shift);
         12:  if assigned(fListNonERPSales)   then fListNonERPSales.OnKeyUp(fListNonERPSales,Key,Shift);
         13:  if assigned(fListcleintHRForms) then fListcleintHRForms.OnKeyUp(fListcleintHRForms,Key,Shift);
    end;
  end else if TabCtl20.ActivePage = TTabSheet(tabContacts) then begin
    if assigned(fCustomerContactListForm)    then fCustomerContactListForm.OnKeyUp(fCustomerContactListForm,Key,Shift);
  end;
end;
function TfrmCustomer.FilteredContactId: integer;
begin
  Result := integer(cboContactSelector.Items.Objects[cboContactSelector.ItemIndex]);
end;

procedure TfrmCustomer.FirstNameExit(Sender: TObject);
begin
  inherited;
//  EditDB(qryCustomers);
//  qryCustomersEmail.asSTring := MakeEmailID(fbEmailchanged,qryCustomersFirstName.asString,
//                                                  qryCustomersLastName.asSTring ,
//                                                  qryCustomersEmail.asSTring,
//                                                  qryCustomersCOMPANY.asString);
//  PostDB(qryCustomers);

end;

procedure TfrmCustomer.SetProdColumQry(Qry: TERPQuery; colno: Integer);
begin
  closedb(Qry);
  Qry.SQL.clear;
  Qry.SQL.add('SELECT');
  if colno = 1 then Qry.SQL.add(Firstcolumn)
  else if colno = 2 then Qry.SQL.add(Secondcolumn)
  else if colno = 3 then Qry.SQL.add(thirdcolumn);
  Qry.SQL.add('AS PartLevel');
  Qry.SQL.add('FROM tblparts P');
  Qry.SQL.add('where ' );
  if colno = 1 then Qry.SQL.add(Firstcolumn)
  else if colno = 2 then Qry.SQL.add(Secondcolumn)
  else if colno = 3 then Qry.SQL.add(thirdcolumn);
  Qry.SQL.add('<> ""');
  Qry.SQL.add('Group by PartLevel');
  Qry.SQL.add('Order by PartLevel;');
end;

procedure TfrmCustomer.SetStateParams(const Value: TJsonObject);
begin
  inherited;
  if not Assigned(Value) then
    exit;
  if Value.Count > 0 then begin
    TabCtl20.ActivePageIndex:= Value.I['TabControlActivePageIndex'];
    if TabCtl20.ActivePage = History then begin
      grpHistory.ItemIndex:= StateParams.I['grpHistoryItemIndex'];
      grpHistory.OnClick(grpHistory);
      if Assigned(HistoryListform) then begin
        HistoryListForm.dtFrom.DateTime:= StateParams.F['DateFrom'];
        HistoryListForm.dtTo.DateTime:= StateParams.F['DateTo'];
        HistoryListForm.btnRequery.Click;
      end;
    end;
  end;
end;

function TfrmCustomer.ShiptoAddress: String;
begin
  Result := ConcatStrings([qryCustomersCompany.AsString , qryCustomersstreet.AsString, qryCustomersstreet2.AsString, qryCustomersstreet3.AsString ,
            ConcatStrings([qryCustomersSuburb.AsString , qryCustomersState.AsString , qryCustomersPostcode.AsString], ' ')] , NL);
end;

procedure TfrmCustomer.newEquip(const Value: String);
begin
  TabCtl20.ActivePage:= tabEquip;
  TabCtl20Change(TabCtl20);
  Equipmentform.NewEquip(Value);
end;
procedure TfrmCustomer.newRego(const Value: String);
begin
  TabCtl20.ActivePage:= tabEquip;
  TabCtl20Change(TabCtl20);
  Equipmentform.newRego(Value);
end;

procedure TfrmCustomer.OnTabAccounts(Sender: TObject);
begin
  if not (qryTerms.Active) then
    qryTerms.Active := true;
  postdb(qryCustomers);
  opendb(QryProduct);
end;

procedure TfrmCustomer.OnTabContacts(Sender: TObject);
begin
    opendb(qryDocPath);
    { Need to remove qryContacts from Transaction handling as we need to
    see changes reflected in the Grid associated with this qry immediately
    on return from Contact form }
    CloseDB(qryDocuments);
    qryDocuments.ParamByName('CusID').asInteger := KeyID;
    opendb(qryDocuments);

    CustomerContactListFormShow;
end;
Procedure TfrmCustomer.CustomerContactListFormShow;
begin
if assigned(fCustomerContactListForm) then exit;
  CustomerContactListForm;
  if Assigned(fCustomerContactListForm) then begin
    With fCustomerContactListForm do begin
          OnAfterPopupFormShow:= DoOnAfterListPopupFormShow;
          Parent := pnlContactsForm;
          align := alclient;
          BorderStyle := bsNone;
          fbIgnoreQuerySpeed := true;
          try
            Show;
            FooterPanel.Visible        := False;
          except
            FreeAndNil(fCustomerContactListForm);
          end;
(*          // Show Print & Export
          for iIndex := 0 to FooterPanel.ControlCount - 1 do begin
            if FooterPanel.Controls[iIndex] is TControl then begin
              TControl(FooterPanel.Controls[iIndex]).Visible := false;
            end;
          end;
          FooterPanel.Height         := 30;
          cmdExport.Top              := 1;
          cmdExport.Left             := 100;
          cmdExport.Visible          := true;
          cmdPrint.Top               := 1;
          cmdPrint.Left              := pnlHistory.Width - 200;
          cmdPrint.Visible           := true;
          FooterPanel.Visible        := true;
          grpFilters.Visible         := true;
          pnlButtons.Visible         := true;
          grdMain.PopupMenu          := mnuFilter;
          grdMain.Align              := alClient;
          Refresh;*)
    end;
  end;

end;

procedure TfrmCustomer.OnTabGeneral(Sender: TObject);
begin
  qryInvoiceTemplates.Active  := true;
  qryDeliveryTemplates.Active := true;
  QrystatementTemplates.Active := true;
  qrySalesOrderTemplate.Active := true;
  qryRelatedClients.ParamByName('ID').asInteger := KeyID;
  cboClientLookup.Params.ParamByName('ID').AsInteger   := KeyID;
  opendb(cboClientLookup);
  opendb(qryRelatedClients);
  if grdRelatedClient.Enabled then
    EditNoAbort(qryRelatedClients);

  if not (qryMediaType.Active) then
  begin
    qryShipping.Active := true;
    qryMediaType.Active := true;
  end;
end;

procedure TfrmCustomer.OnTabHistory(Sender: TObject);
begin
  bShowingHistory := true;
  pnlHistory.Update;
  Application.ProcessMessages;
  grpHistoryClick(Sender);
  bShowingHistory := false;
end;

procedure TfrmCustomer.OnTabReferrals(Sender: TObject);
begin
  if not qryReferrals.Active then
  begin
    opendb(qryClients);
    opendb(qryReferrals);
    EditNoAbort(qryReferrals);
  end;
end;

procedure TfrmCustomer.OnTabSpecialProds(Sender: TObject);
begin
  opendb(QryProductGroupcol1);
  opendb(QryProductGroupcol2);
  opendb(QryProductGroupcol3);
  opendb(qryProdGroupDiscs);
  Application.ProcessMessages;
  opendb(cboProductQry);
end;

procedure TfrmCustomer.OpenSubQry(Qry: TERPQuery; clientIDParamname: String);
begin
  if Qry.ParamByName(clientIDParamname) = nil then exit;
  if Qry.ParamByName(clientIDParamname).asInteger <> qryCustomersclientID.asInteger then begin
    Closedb(qry);
    Qry.ParamByName(clientIDParamname).asInteger := qryCustomersclientID.asInteger;
  end;
  opendb(Qry);
end;

procedure TfrmCustomer.LocateEquip(const customerEquipID: Integer);
begin
  TabCtl20.ActivePage:= tabEquip;
  TabCtl20Change(TabCtl20);
  Equipmentform.LocateEquip(customerEquipID);
end;

procedure TfrmCustomer.lvAttachmentsDblClick(Sender: TObject);
var
  item: TListItem;
  Option: word;
  FileName: string;
  SaveDialog: TSaveDialog;
begin
  inherited;
  item := lvAttachments.Selected;
  if Assigned(item) then begin
    Option := MessageDlgXP_Vista('Do you wish to Save of Open this attachment?',
      mtConfirmation, [] , 0, nil , '','', False, nil, 'Save,Open,Cancel');
    case Option of
      100: { save }
        begin
          FileName := SystemLib.GetMyDocumentsDir + TIdAttachment(item.Data).FileName;
          SaveDialog:= TSaveDialog.Create(nil);
          try
            SaveDialog.FileName := FileName;
            SaveDialog.InitialDir := ExtractFilePath(FileName);
            if SaveDialog.Execute then begin
              TIdAttachment(item.Data).SaveToFile(SaveDialog.FileName);
            end;
          finally
            SaveDialog.Free;
          end;
        end;
      101: { open }
        begin
          FileName := SystemLib.GetAppTempDir + '\' + TIdAttachment(item.Data).FileName;
          TIdAttachment(item.Data).SaveToFile(FileName);
          ShellExecute(Handle, 'Open', PChar(FileName), '', '', SW_SHOWNORMAL);
        end;
      102: exit; { Cancel }
    end;
  end;
end;
{
function TfrmCustomer.Makecustomercontact: boolean;
begin


            if qryContacts.Locate('ContactFirstName;ContactSurName;Active' , vararrayof([QrycustomersFirstName.asString ,QrycustomersLastName.asString , 'F' ]) , []) then begin
              editDb(qryContacts);
              qryContactsactive.asBoolean := True;
              PostDB(qryContacts);
              Result:=true;
              Exit;
            end;

        if (QrycustomersFirstName.asString = '') and (QrycustomersLastName.asString = '') then begin
          result:= false;
          exit;
        end;


        if QrycustomersclientId.asInteger = 0 then begin
          PostDb(Qrycustomers);
          EditDb(Qrycustomers);
        end;

        if qryContacts.ParamByName('CusID').AsInteger <>qryCustomers.FieldByName('ClientID').AsInteger then begin
          closedb(qryContacts);
          qryContacts.ParamByName('CusID').AsInteger := qryCustomers.FieldByName('ClientID').AsInteger;
          opendb(qryContacts);
        end;
        qryContacts.Insert;
        if qryContacts.state in [dsedit,dsinsert] then else qryContacts.Edit;
        qryContactsClientID.AsInteger := QrycustomersclientId.asInteger;
        qryContactsClientName.ASString :=qryCustomersCompany.AsString;
        qryContactsContactTitle.asString          :=  QrycustomersTitle.asString;
        qryContactsContactFirstName.asString      :=  QrycustomersFirstName.asString;
        qryContactsContactSurName.asString        :=  QrycustomersLastName.asString;
        qryContactsCompany.asString               :=  QrycustomersFirstName.asString+' ' +QrycustomersLastName.asString;
        qryContacts.Post;
        qryContacts.Edit;
        qryContactsContactMOB.asString            :=  QrycustomersMobile.asString;
        qryContactsjobtitle.asString              :=  QrycustomersJobTitle.asString;
        qryContactsContactEmail.asString          :=  QrycustomersEmail.asString;
        qryContactsContactPH.asString             :=  QrycustomersPhone.asString;
        qryContactsContactFax.asString            :=  QrycustomersFaxNumber.asString;
        qryContactsContactAltPH.asString          :=  QrycustomersAltPhone.asString;
        qryContactsContactAddress.asString        :=  QrycustomersStreet.asString;
        qryContactsContactAddress2.asString       :=  QrycustomersStreet2.asString;
        qryContactsContactCity.asString           :=  QrycustomersSuburb.asString;
        qryContactsContactState.asString          :=  QrycustomersState.asString;
        qryContactsContactPcode.asString          :=  QrycustomersPostcode.asString;
        qryContactsContactcountry.asString        :=  QrycustomersCountry.asString;
        qryContactsISPrimaryContact.asBoolean     := True;
        qryContactsActive.asBoolean               := True;
        qryContacts.Post;
        result := QryContactsContactId.asInteger > 0;

        (* s:= 'insert into tblContacts Set ';
        s:= s+'CusId=' +inttostr(QrycustomersclientId.asInteger)+',';
        if Qrycustomerssupplier.asBoolean then s:= s+'SupId=' +inttostr(QrycustomersclientId.asInteger)+',';
        s:= s+'ContactTitle          = ' +Quotedstr(QrycustomersTitle.asString)+',';
        s:= s+'ContactFirstName      = ' +Quotedstr(QrycustomersFirstName.asString)+',';
        s:= s+'ContactSurName        = ' +Quotedstr(QrycustomersLastName.asString)+',';
        s:= s+'ContactMOB            = ' +Quotedstr(QrycustomersMobile.asString)+',';
        s:= s+'jobtitle              = ' +Quotedstr(QrycustomersJobTitle.asString)+',';
        s:= s+'ContactEmail          = ' +Quotedstr(QrycustomersEmail.asString)+',';
        s:= s+'Company               = ' +Quotedstr(QrycustomersFirstName.asString+' ' +QrycustomersLastName.asString)+',';
        s:= s+'ContactPH             = ' +Quotedstr(QrycustomersPhone.asString)+',';
        s:= s+'ContactFax            = ' +Quotedstr(QrycustomersFaxNumber.asString)+',';
        s:= s+'ContactAltPH          = ' +Quotedstr(QrycustomersAltPhone.asString)+',';
        s:= s+'ContactAddress        = ' +Quotedstr(QrycustomersStreet.asString)+',';
        s:= s+'ContactAddress2       = ' +Quotedstr(QrycustomersStreet2.asString)+',';
        s:= s+'ContactCity           = ' +Quotedstr(QrycustomersSuburb.asString)+',';
        s:= s+'ContactState          = ' +Quotedstr(QrycustomersState.asString)+',';
        s:= s+'ContactPcode          = ' +Quotedstr(QrycustomersPostcode.asString)+',';
        s:= s+'Contactcountry        = ' +Quotedstr(QrycustomersCountry.asString)+',';
        s:= s+'ISPrimaryContact     ="T",';
        s:= s+'ContactIsOtherContact="F",';
        s:= s+'ContactIsJob         ="F",';
        s:= s+'Active               ="T",';
        s:= s+'ContactIsCustomer    ="T",';
        if Qrycustomerssupplier.asboolean then  s:= s+'ContactIsSupplier    ="T"' else   s:= s+'ContactIsSupplier    ="F"';
        s:=s+';';
        ExecuteSQLinconnection(s);
        if qryContacts.ParamByName('CusID').AsInteger <>qryCustomers.FieldByName('ClientID').AsInteger then begin
          closedb(qryContacts);
          qryContacts.ParamByName('CusID').AsInteger := qryCustomers.FieldByName('ClientID').AsInteger;
          opendb(qryContacts);
        end else
          QryContacts.refresh;
        result := QryContactsContactId.asInteger > 0; *)
end;
}

procedure TfrmCustomer.Makecustomer_eParcelRec;
begin
  postDB(qryCustomers);
  if Qryclients_eParcel.ParamByName('CusID').AsInteger <>qryCustomers.FieldByName('ClientID').AsInteger then begin
          closedb(Qryclients_eParcel);
          Qryclients_eParcel.ParamByName('CusID').AsInteger := qryCustomers.FieldByName('ClientID').AsInteger;
          opendb(Qryclients_eParcel);
  end;
  postDB(Qryclients_eParcel);
  if Qryclients_eParcel.recordcount =0 then Qryclients_eParcel.append;
end;

procedure TfrmCustomer.btnAddDateClick(Sender: TObject);
begin
  inherited;
  if Notes.Lines.Count = 0 then
    CommonLib.MessageDlgXP_Vista('There are no notes to add date and time to.',mtINformation,[mbOk],0)
  else Notes.text:= AddDateTime(lcdOnLoganyway,Notes.text);
end;

procedure TfrmCustomer.qryCustomersShippingIDChange(Sender: TField);
begin
  inherited;
  qryCustomersShippingMethod.AsString:=
    TShippingMethod.IDToggle(Sender.AsInteger,qryCustomers.Connection);
end;

procedure TfrmCustomer.qryCustomersTaxnameChange(Sender: TField);
begin
  if IsFlag('qryCustomersTaxnameChange') then exit;

  AddFlag('qryCustomersTaxnameChange');
  try
    inherited;
  //  EditDB(qryCustomers);
//    if qryTaxCodesTaxCodeID.AsInteger < 1 then
  //    qryCustomersTaxname.Clear;
//      Sender.Clear;
    qryCustomersTAXID.AsInteger := qryTaxCodesTaxCodeID.AsInteger;
  finally
    RemoveFlag('qryCustomersTaxnameChange');
  end;
end;

procedure TfrmCustomer.qryCustomersTermsIDChange(Sender: TField);
begin
  inherited;
  qryCustomersTerms.AsString:=
    TTerms.IDToggle(Sender.AsInteger,qryCustomers.Connection);
end;

procedure TfrmCustomer.qryDocumentsAfterPost(DataSet: TDataSet);
begin
  inherited;
  if qryDocuments.FieldByName('GlobalRef').AsString = '' then begin
    EditDb(qryDocuments);
    qryDocuments.FieldByName('GlobalRef').AsString := AppEnv.Branch.SiteCode + IntToStr(qryDocuments.FieldByName('RefId').AsInteger);
    PostDb(qryDocuments);
  end;
end;

procedure TfrmCustomer.qryDocumentsBeforePost(DataSet: TDataSet);
begin
  inherited;
  if not SameText(qryDocuments.FieldByName('msUpdateSiteCode').AsString,AppEnv.Branch.SiteCode) then
    qryDocuments.FieldByName('msUpdateSiteCode').AsString := AppEnv.Branch.SiteCode;
end;

procedure TfrmCustomer.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  { NOTE: inherited removed to prevent form close on esc ...
          this is used to cancel changes on mask edits }
  if key = VK_ESCAPE then
 {$IFDEF DevMode}
  inherited
  {$ENDIF}
  else  inherited;
end;

function TfrmCustomer.ValidateCustomer(checkall:Boolean): Boolean;
var
  BusObj: TBusObj;
  s:String;

  procedure focusinvalidcomp(const ftabsheet :TTabsheet; const finvcomp :TWinControl; const invalidmsg :STring);
  begin
    if invalidmsg <> '' then
      CommonLib.MessageDlgXP_Vista(invalidmsg, mtWarning, [mbOK], 0);
    if ftabsheet <> TabCtl20.ActivePage then begin
      TabCtl20.ActivePage := TTabSheet(ftabsheet);
      TabCtl20Change(TabCtl20);
    end;
    SetControlFocus(finvcomp);
  end;

begin
  Result := False;
  if checkall or (TabCtl20.ActivePage = Custom_Fields) then begin
    if not ChkCustReqdFields() then begin
        Exit;
    end;
  end;

  if checkall or (TabCtl20.ActivePage = Customer_Info) then begin
    postdb(qryCustomers);
    if Empty(Company.Text) then begin
        focusinvalidcomp(Customer_Info ,Company ,'Company Name cannot be blank.');
        exit;
    end;

(*    if Empty(firstname.Text) then begin
        focusinvalidcomp(Customer_Info ,FirstName ,'Company First Name cannot be blank.');
        exit;
    end;*)

    if AppEnv.CompanyPrefs.EnforceCustomerFirstAndLastName then begin
      if qryCustomers.FieldByName('FirstName').AsString = '' then begin
          focusinvalidcomp(Customer_Info, FirstName, 'You must provide a First Name for the Customer');
          exit;
      end;
      if qryCustomers.FieldByName('LastName').AsString = '' then begin
        focusinvalidcomp(Customer_Info, LastName, 'You must provide a Last Name for the Customer');
        exit;
      end;
    end;


    if not IsClientNameUnique(Company.Text, KeyID) then begin
        focusinvalidcomp(Customer_Info ,Company ,'You Have Created An Entry (Company) That Already Exists !' + #13#10#13#10 +
          'Please Ensure Your Entry Is Unique.');
        Exit;
    end;
    if AppEnv.CompanyPrefs.CustomerTypeRequired and (qryCustomersClientTypeID.asInteger = 0) then begin
      focusinvalidcomp(Customer_Info ,cboClientType ,'Client type cannot be blank.');
      exit;
    end;

  end;
  if checkall or (TabCtl20.ActivePage = Address_Info) then begin
    if qryCustomersSendXMLInvoices.asString = 'T' then
        if qryCustomersEmailXML.asString = '' then begin
          focusinvalidcomp(Address_Info ,XMLEmail ,'''XML email'' should not be blank when ''Send XML Invoices on Invoice Run'' is selected');
          Exit;
        end;
    if (qryCustomers.FieldByName('Mobile').AsString <> '') and
      (not SMSUtils.NumberHasCorrectPrefix(qryCustomers.FieldByName('Mobile').AsString, MyConnection)) then begin
      FocusInvalidComp(Customer_Info, MOB, 'Mobile number format is invalid, number must begin with "+" followed by country code with no leading zero''s.');
      exit;
    end;

    if qryCustomersclientCode.asString <> '' then
      if not TCustomer.IsUnique(qryCustomersClientID.asInteger, 'ClientCode = ' + quotedstr(StringDataForSQL(qryCustomersclientCode.asString))) then begin
        s:='Customer Code ' + quotedstr(qryCustomersclientCode.asString)+' Already Exists for Another Customer. ';
        EditDB(qryCustomers);
        qryCustomersclientCode.Clear;
        focusinvalidcomp(Address_Info ,edtclientCode ,s);
        Exit;
      end;

  end;
  if checkall or (TabCtl20.ActivePage = tabAccounts) then begin
    if (qryCustomersTermsID.AsInteger = 0) then begin
        EditDB(qryCustomers);
        qryCustomersTermsID.AsInteger := AppEnv.CompanyPrefs.CreditTermsID;
    end;
  end;

  if checkall or (TabCtl20.ActivePage = tabContacts) then begin
    if not MakeNewcontactifnone  then begin
      FocusInvalidComp(tabContacts ,cmdNewContact ,'Please Create At Least one Contact for the Customer');
      Exit;
    end;
  end;

  if checkall or (TabCtl20.ActivePage = tabFollowUp) then begin
    //EditDB(tbOtherFollowup);
    PostDB(tbOtherFollowup);
    with tbOtherFollowUp do begin
      if RecordCount <> 0 then begin
        First;
        while not Eof do begin
          if tbOtherFollowUpEmployeeID.AsInteger = 0 then begin
            TabCtl20.ActivePage := TTabSheet(tabReferrals);
            MiscPageControl.ActivePage := TTabSheet(tabFollowUp);
            focusinvalidcomp(tabFollowUp ,grdFollowUp ,'You must provide an Employee in the FollowUp Table');
            Exit;
          end;
          Next;
        end;
      end;
    end;

    if tbOtherFollowup.RecordCount > 0 then begin
      BusObj:= TOtherFollowUps.Create(nil);
      try
        BusObj.Dataset:= tbOtherFollowUp;
  //      BusObj.SilentMode:= true;
        if not BusObj.ValidateDataList then begin
          TabCtl20.ActivePage := TTabSheet(tabReferrals);
          MiscPageControl.ActivePage := TTabSheet(tabFollowUp);
          focusinvalidcomp(tabFollowUp ,grdFollowUp, '' {BusObj.ResultStatus.Messages});
          exit;
        end;
      finally
        BusObj.Free;
      end;
    end;
  end;
  if checkall or (TabCtl20.ActivePage = General) then begin
    if not AppEnv.CompanyPrefs.DisableCusSourceTracking then begin
      if (cboMediaType.Enabled) and (Empty(qryCustomers.FieldByName('MedTypeID').AsString) or
        (qryCustomers.FieldByName('MedTypeID').AsInteger = 0)) then begin
        focusinvalidcomp( General , cboMediaType , 'Source must be entered in ''General Tab''');
        Exit;
      end;
    end;
  end;

  if checkall or (TabCtl20.ActivePage = SpecialProds) then begin
    BusObj:= TProductGroupDiscount.Create(nil);
    try
      BusObj.Dataset:= qryProdGroupDiscs;
      //BusObj.sSilentMode:= true;
      if not BusObj.ValidateDataList then begin
        focusinvalidcomp(SpecialProds ,grdProdGroupDiscs, '' {BusObj.ResultStatus.Messages});
        exit;
      end;
    finally
      BusObj.Free;
    end;

    BusObj:= TSpecialProducts.Create(nil);
    grdSpecials.DataSource.DataSet.DisableControls;
    try
      BusObj.Dataset:= qrySpecials;
      //BusObj.SilentMode:= true;
      if not BusObj.ValidateDataList then begin
        focusinvalidcomp(SpecialProds ,grdSpecials, '' {BusObj.ResultStatus.Messages});
        exit;
      end;
    finally
      BusObj.Free;
      grdSpecials.DataSource.DataSet.EnableControls;
    end;
  end;


  if checkall or (TabCtl20.ActivePage = tabEquip) then begin
    if Assigned(Equipmentform) then begin
      Equipmentform.qryEquip.Filtered:= false;
      try
        if (Equipmentform.qryEquip.RecordCount > 0) then begin
          if not Equipmentform.CustomerEquipment.ValidateDataList then begin
            focusinvalidcomp(tabEquip ,Equipmentform.grdEquipment, '');
            exit;
          end;
        end;
      finally
        Equipmentform.qryEquip.Filtered:= true;
      end;
    end;
  end;

  if IsOkToSave() then begin
      PostDB(qryCustomers);
      EditDB(qryCustomers);
  end;

  Result := true;
end;

function TfrmCustomer.CustomerContactCount(excludecontactID:Integer): integer;
var
  qry : TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(qrycustomers.connection);
  try
    qry.SQL.Text := 'SELECT Count(*) ctr FROM tblContacts '+
                    ' where ClientId = ' + inttostr(qryCustomersClientID.AsInteger)+
                    ' and contactId <> ' + inttostr(excludecontactID);
    qry.Open;
    Result := qry.fieldbyname('ctr').AsInteger;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

{function TfrmCustomer.CustomerContactListForm(Recreate : boolean = false) : TCustomerContactListGUI;
var
  Q : TQueryManipulationObj;
begin
  if Recreate then
    FreeAndNil(FCustomerContactListForm);

  if not assigned(FCustomerContactListForm) then
  begin
    (*
    FCustomerContactListForm := TCustomerContactListGui(OpenERPForminPanel('TCustomerContactListGui', Self, pnlContactsForm, ContactsFormBeforeShow));
    FCustomerContactListForm.PassedConnection := Self.MyConnection;
    *)
    // Have to create manually, since if the Contact List form has already been opened in reports,
    // we have problems
    FCustomerContactListForm := TCustomerContactListGui.Create(self);
//    FCustomerContactListForm.qryMain.Connection := MyConnection;
    FCustomerContactListForm.PassedConnection := MyConnection;
    Q := TQueryManipulationObj.Create(FCustomerContactListForm.qryMain.SQL.Text);
    try
      Q.ProcessSearch('ClientId', IntToStr(KeyID));
      FCustomerContactListForm.qryMain.SQL.Text := Q.ModifiedSQL;
      FCustomerContactListForm.RefreshOrignalSQL;
    finally
      FreeandNil(Q);
    end;

    FCustomerContactListForm.FilterString := '(ClientID = ' + IntToStr(KeyID) + ')' + csActive;
    FCustomerContactListForm.Parent := pnlContactsForm;
    FCustomerContactListForm.borderstyle := bsNone;
  end;
  Result := FCustomerContactListForm;
end;}

procedure TfrmCustomer.CustomerGridDataSelect(Sender: TwwDbGrid);
var
  cmd: TMyCommand;
  i, x: integer;
  idList: TIntegerList;
begin
  if Sender.SelectedList.Count > 0 then begin
    cmd := TERPCommand.Create(nil);
    idList := TIntegerList.Create;
    try
      cmd.Connection := self.MyConnection;
      Sender.DataSource.DataSet.DisableControls;
      try
        for i := 0 to Sender.SelectedList.Count - 1 do begin
          idList.Add(Sender.DataSource.DataSet.FieldByName('ClientID').AsInteger);
          Sender.DataSource.DataSet.GotoBookmark(Sender.SelectedList.Items[i]);
        end;
      finally
        Sender.DataSource.DataSet.EnableControls;
      end;
      for i := 0 to idList.Count -1 do begin
        if not UserLock.Lock(GetMainTablename, idLIst[i], Self.Caption) then begin
          CommonLib.MessageDlgXP_Vista('Can not update customer ' + TClient.IDToggle(idLIst[i]) +
            '.' + #13#10 + #13#10 +  UserLock.LockMessage + #13#10 + #13#10 + 'All copying cancelld.',mtInformation,[mbOk],0);
          for x := i downto 0 do begin
            UserLock.UnLock(GetMainTablename,idList[x],Self.Caption);
            exit;
          end;
        end;
      end;
      cmd.SQL.Clear;

      for i := 0 to idList.Count -1 do begin
        if fbCopySpecialProducts then begin
            cmd.SQL.Add('insert ignore into tblcustomerlines (CustomerId,ProductID,Name,Description,OrigPrice,LinePrice)'+
                              ' select ' + IntToStr(idList[i]) + ' as ClientId, ProductID,Name,Description,OrigPrice,LinePrice'+
                              ' from tblcustomerlines where CustomerID = ' + IntToStr(self.qryCustomersClientID.AsInteger)+';');
            cmd.SQL.Add('update tblcustomerlines set GlobalRef = Concat("'  + AppEnv.Branch.SiteCode + '",CustomerLinesID)'+
                              ' where CustomerID = ' + IntToStr(idList[i])+
                              ' and IsNull(GlobalRef);');
            cmd.SQL.Add('update tblcustomerlines set'+
                              ' msUpdateSiteCode = "' + AppEnv.Branch.SiteCode + '"'+
                              ' where CustomerID = ' + IntToStr(idList[i])+';');
          end;
          if fbCopyGroupDiscount then begin
                cmd.SQL.Add('insert ignore into tblprodgroupdiscs (ClientID, Col1, Col2, Col3, Discount , dateFrom, DateTo  )'+
                                  ' select ' + IntToStr(idList[i]) + ' as ClientId,Col1, Col2, Col3, Discount , dateFrom, DateTo  '+
                                  ' from tblprodgroupdiscs '+
                                  ' where ClientID = ' + IntToStr(self.qryCustomersClientID.AsInteger)+';');

                cmd.SQL.Add('update tblprodgroupdiscs set GlobalRef = Concat("'  + AppEnv.Branch.SiteCode + '",grpdiscid)'+
                                  ' where ClientID = ' + IntToStr(idList[i])+
                                  ' and IsNull(GlobalRef);');

                cmd.SQL.Add('update tblprodgroupdiscs set'+
                                  ' msUpdateSiteCode = "' + AppEnv.Branch.SiteCode + '"'+
                                  ' where ClientID = ' + IntToStr(idList[i])+';');

          end;
          if fbCopyPermanentDiscount and (qryCustomers.FieldByName('Discount').AsFloat <>0) then
            cmd.SQL.Add('update tblclients Set Discount =' + FloatTostr(qryCustomers.FieldByName('Discount').AsFloat)+' where clientId = ' + IntToStr(idList[i])+';');

          if fbCopySpecialProductDiscount and (qryCustomers.FieldByName('SpecialDiscount').AsFloat <>0) then
            cmd.SQL.Add('update tblclients Set SpecialDiscount =' + FloatTostr(qryCustomers.FieldByName('SpecialDiscount').AsFloat)+' where clientId = ' + IntToStr(idList[i])+';');
      end;

      if cmd.SQL.Count >0 then begin
        clog(cmd.SQL.Text);
        cmd.Execute;
      end;

      CommonLib.MessageDlgXP_Vista('Special Prices/Group Discounts/Discounts have beem copied to ' + IntToStr(idList.Count) + ' Customer(s).',mtInformation,[mbOk],0);
    finally
      cmd.Free;
      idList.Free;
    end;
  end;
end;

function TfrmCustomer.CustomerSaved: Boolean;
begin
  result := False;
  if accesslevel >=5 then exit;
    if not ValidateCustomer(true) then Exit;
    try
      cmdOk.Enabled := false; //Stops Click Twice
      EditDB(qrySpecials);

      if (not qryCustomers.IsEmpty) then begin
        if (qryCustomersGlobalref.AsString = '') then begin
          PostDb(qryCustomers);
          EditDb(qryCustomers);
          qryCustomersGlobalref.AsString:= AppEnv.Branch.SiteCode + qryCustomersClientID.AsString;
          qryCustomersmsUpdateSiteCode.AsString := AppEnv.Branch.SiteCode;
          PostDb(qryCustomers);
        end
        else begin
          EditDb(qryCustomers);
          qryCustomersMsTimeStamp.AsDateTime:= now;
          qryCustomersmsUpdateSiteCode.AsString := AppEnv.Branch.SiteCode;
          PostDb(qryCustomers);
        end;
      end;

      ProcessEditedFlag('Main', Self, memqryCustomers, qryCustomers, nil);
      EditDB(qryCustomers);
      PostDB(qryCustomers);
      PostDB(Qryclients_eParcel);

      if (qryProdGroupDiscs.Active) and ((qryProdGroupDiscs.state in [dsEdit,dsInsert]) or (qryProdGroupDiscs.recordcount>0)) then begin
        EditDB(qryProdGroupDiscs);
        PostDB(qryProdGroupDiscs);
      end;

      ProcessEditedFlag('Follow Up Lines', Self, memtbOtherFollowUp, tbOtherFollowUp, nil);
      //EditDB(tbOtherFollowUp);
      PostDB(tbOtherFollowUp);


      ProcessEditedFlag('Special Price Lines', Self, memqrySpecials, qrySpecials, qryCustomers);
      EditDB(qrySpecials);
      PostDB(qrySpecials);

      if (qryReferrals.Active) and (qryReferrals.RecordCount > 0) then begin
        EditDB(qryReferrals);
        PostDB(qryReferrals);
      end;

      if (qryRelatedClients.Active) and (qryRelatedClients.RecordCount > 0) then begin
        EditDB(qryRelatedClients);
        PostDB(qryRelatedClients);
      end;

      // Now check the credit card number.  If provided we must encrypt
      // the number and Save the encryption data to the backend.
      if not Empty(txtCardNumber.Text) then begin
        EditDB(qryCustomers);
        {$ifdef COMPILER_22_UP}
        qryCustomers.FieldByName('CreditCardNumber').AsString := CipherUtils.EncryptString(txtCardNumber.Text);
        {$else}
        qryCustomers.FieldByName('CreditCardNumber').AsString := lbBlowFish1.EncryptString(txtCardNumber.Text);
        {$endif}
        PostDB(qryCustomers);
      end;

      if  Empty(cboInvoiceTemplate.Text) then begin
        EditDB(qryCustomers);
        qryCustomers.FieldByName('DefaultInvoiceTemplateID').asInteger := 0;
        PostDB(qryCustomers);
      end;

      if  Empty(cboDeliveryTemplate.Text) then begin
        EditDB(qryCustomers);
        qryCustomers.FieldByName('DefaultDeliveryTemplateID').asInteger := 0;
        PostDB(qryCustomers);
      end;
      PostDB(qryCustomershippingoptions);
      MainShippingAddress;
      CheckJobs;
      REsult := CoreEDIConfigSave;
    except
      on E: Exception do begin
            Audit.AddEntry(e, Self);
            CommonLib.MessageDlgXP_Vista(e.Message + Chr(13) + 'Errors occured in ' + Self.ClassName, mtWarning, [mbOK], 0);
            Raise
      end;
    end;
end;
Procedure TfrmCustomer.CheckJobs;
var
  Jobobj : TJob;
begin
  Jobobj := TJob.CreateWithNewConn(Self);
  try
     Jobobj.Connection.connection := qryCustomers.Connection;
     Jobobj.LoadSelect('ParentClientID = ' + inttostr(qryCustomersclientID.asInteger));
     if Jobobj.count = 0 then exit;
     if MessageDlgXP_Vista('Do You Wish To Update the "Sales comments" in All Jobs of '+quotedstr(qryCustomerscompany.asString)+'?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
     fsCheckJobsMsg := '';
     fiCheckJobscount := 0;
     Jobobj.IterateRecords(CheckJobsCallback);
     MessageDlgXP_Vista(inttostr(fiCheckJobscount) +' of ' +inttostr(Jobobj.count)+' Jobs Updated.'+
                      iif(fsCheckJobsMsg <> '' , NL+NL +'The Following Jobs are Locked and didn''t Update :'+NL+fsCheckJobsMsg , ''),
                      mtWarning, [mbOK], 0);

  finally
    freeandnil(Jobobj);
  end;
end;
procedure TfrmCustomer.CheckJobsCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not (Sender is TJob) then exit;
  if not TJob(SendeR).lock then begin
      fsCheckJobsMsg:= trim(fsCheckJobsMsg + NL+ TJob(SendeR).JobName);
      Exit;
  end;
  TJob(SendeR).InvoiceCommentPopUp := qryCustomersInvoiceCommentPopUp.asBoolean;
  TJob(SendeR).InvoiceComment := qryCustomersInvoiceComment.asString;
  TJob(SendeR).PostDB;
  fiCheckJobscount := fiCheckJobscount +1;
end;
procedure TfrmCustomer.UpdatefromEquipment;
begin
  EditDB(qryCustomers);
  qryCustomersLastUpdated.AsDateTime := Now;
end;

procedure TfrmCustomer.qryOpeningPointsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryOpeningPointsISOpeningbalance.asBoolean := true;
  qryOpeningPointsclientID.asInteger := qryCustomersClientID.AsInteger;
  qryOpeningPointsDeptID.AsInteger := appenv.DefaultClass.ClassID;
  qryOpeningPointsDeptname.asString := tcDataUtils.GetClassName(qryOpeningPointsDEptID.asInteger);
  qryOpeningPointsActive.asBoolean := true;
  qryOpeningPointsValueforRewardPoint.AsFloat := appenv.CompanyPrefs.ValueforRewardPoints;
  qryOpeningPoints.Post;
  closedb(QrySalesRedeemedPoints);
  QrySalesRedeemedPoints.Parambyname('SalesPointID').asInteger :=qryOpeningPointsSalesLinesPointsId.asInteger;
  OpenDB(QrySalesRedeemedPoints);
  qryOpeningPoints.Edit;
end;


procedure TfrmCustomer.qryOpeningPointsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  closedb(QrySalesRedeemedPoints);
  QrySalesRedeemedPoints.Parambyname('SalesPointID').asInteger :=qryOpeningPointsSalesLinesPointsId.asInteger;
  OpenDB(QrySalesRedeemedPoints);
end;

procedure TfrmCustomer.qryProdGroupDiscsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  EditDB(qryProdGroupDiscs);
  qryProdGroupDiscs.FieldByName('ClientID').AsInteger := KeyID;
end;

procedure TfrmCustomer.qryProdGroupDiscsAfterOpen(DataSet: TDataSet);
begin
  inherited;
    qryProdGroupDiscsCol1.DisplayLabel := AppEnv.DefaultClass.FirstColumn;
    qryProdGroupDiscsCol2.DisplayLabel := AppEnv.DefaultClass.SecondColumn;
    qryProdGroupDiscsCol3.DisplayLabel := AppEnv.DefaultClass.ThirdColumn;
end;

procedure TfrmCustomer.qryProdGroupDiscsBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryProdGroupDiscs.ParamByName('xClientID').asInteger := KeyID;
end;

procedure TfrmCustomer.qryProdGroupDiscsBeforePost(DataSet: TDataSet);
begin
  inherited;
  if not TProductGroupDiscount.IsUnique(qryProdGroupDiscsGrpDiscID.AsInteger, 'ClientID= ' + inttostr(qryProdGroupDiscsClientID.AsInteger) +
                                                                          ' and Col1= ' +quotedstr(StringDataForSQL(qryProdGroupDiscsCol1.AsString)) +
                                                                          ' and Col2= ' +quotedstr(StringDataForSQL(qryProdGroupDiscsCol2.AsString)) +
                                                                          ' and Col3= ' +quotedstr(StringDataForSQL(qryProdGroupDiscsCol3.AsString)),
                                        qryProdGroupDiscs.connection ) then begin
    cancelDb(qryProdGroupDiscs);
    abort;
  end;
end;

procedure TfrmCustomer.QryProductAfterOpen(DataSet: TDataSet);
begin
  inherited;
  QryProduct.IndexFieldNames := QuotedStr('PARTNAME') + ' ASC CIS';
end;

procedure TfrmCustomer.edtPointExpiresOnExit(Sender: TObject);
begin
  inherited;
  PostDB(qryOpeningPoints);
  if (not qryOpeningPoints.IsEmpty) and
    (self.qryOpeningPointsLinePoints.AsInteger = 0) and (self.qryOpeningPointsOpeningBalanceAsOn.AsDateTime = 0) then
    qryOpeningPoints.Delete;
end;

procedure TfrmCustomer.edtPrintNameChange(Sender: TObject);
begin
  inherited;
  if Screen.ActiveControl = Sender then
    fbclientnameMadeFromName := False;
end;

procedure TfrmCustomer.edtPrintNameExit(Sender: TObject);
begin
  inherited;
  if Trim(qryCustomers.FieldByname('PrintName').AsString) <> '' then PostDB(qryCustomers);
end;

procedure TfrmCustomer.edtLinePointsExit(Sender: TObject);
begin
  inherited;
  PostDB(qryOpeningPoints);
  if (not qryOpeningPoints.IsEmpty) and
    (self.qryOpeningPointsLinePoints.AsInteger = 0) and (self.qryOpeningPointsOpeningBalanceAsOn.AsDateTime = 0) then
    qryOpeningPoints.Delete;
end;
procedure TfrmCustomer.QrySalesRedeemedPointsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  edtLinePoints.enabled         := QrySalesRedeemedPointsUsedPoints.AsFloat = 0;
  edtOpeningBalanceAsOn.enabled := QrySalesRedeemedPointsUsedPoints.AsFloat = 0;
  edtPointExpiresOn.enabled     := QrySalesRedeemedPointsUsedPoints.AsFloat = 0;
  lblLinePoints.enabled         := QrySalesRedeemedPointsUsedPoints.AsFloat = 0;
  lblOpeningBalanceAsOn.enabled := QrySalesRedeemedPointsUsedPoints.AsFloat = 0;
  lblPointExpiresOn.enabled     := QrySalesRedeemedPointsUsedPoints.AsFloat = 0;
  lblrewardPoints.enabled       := QrySalesRedeemedPointsUsedPoints.AsFloat = 0;
end;

procedure TfrmCustomer.QryShippingAddressmainAfterPost(DataSet: TDataSet);
begin
  inherited;
  Closedb(qryClientToShipAddressLink);
  Opendb(qryClientToShipAddressLink);
  if qryClientToShipAddressLink.RecordCount=0 then begin
    qryClientToShipAddressLink.Append;
    qryClientToShipAddressLinkClientID.AsInteger :=qryCustomersclientID.asInteger;
    qryClientToShipAddressLinkShipAddressID.AsInteger := QryShippingAddressmainShipAddressID.asInteger;
    PostDB(qryClientToShipAddressLink);
  end;
  //if Assigned(fShipAddressList) then fShipAddressList.DoRefreshQuery;
  closedb(QrycustomerShipAddresslist);
  opendb(QrycustomerShipAddresslist);
end;

procedure TfrmCustomer.QryShippingAddressmainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  QryShippingAddressmain.ParamByName('KeyId').asInteger := qryCustomersclientID.asInteger;
end;

procedure TfrmCustomer.QryShippingAddressmainBeforeScroll(DataSet: TDataSet);
begin
  inherited;
  closedb(qryClientToShipAddressLink);
end;

procedure TfrmCustomer.cboShippingAgentCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
  EditDB(qryCustomers);
  qryCustomersShippingAgentID.asInteger := QryShippingAgentShippingAgentID.asInteger;

end;

procedure TfrmCustomer.cboShippingAgentEnter(Sender: TObject);
begin
  inherited;
  fLastComboAccessed:= cboShippingAgent;
end;

procedure TfrmCustomer.cboPortOfLoadingEnter(Sender: TObject);
begin
  inherited;
  if not (QrySuburb.Active) then begin
    QrySuburb.Active := true;
  end;
end;

procedure TfrmCustomer.cboPortOfDischargeEnter(Sender: TObject);
begin
  inherited;
  if not (QrySuburb.Active) then begin
    QrySuburb.Active := true;
  end;
end;

procedure TfrmCustomer.cboFinalDestinationEnter(Sender: TObject);
begin
  inherited;
  if not (QrySuburb.Active) then begin
    QrySuburb.Active := true;
  end;
end;

procedure TfrmCustomer.cboClientTypeEnter(Sender: TObject);
begin
  inherited;
  AssignComboAccessed(Sender);
end;

procedure TfrmCustomer.cboContactSelectorChange(Sender: TObject);
begin

  if (cboContactSelector.Items.Count = 0) or
     (cboContactSelector.ItemIndex <= 0) then
  begin
    memtbOtherFollowUp.Filtered := false;
    tbOtherFollowUp.Filtered := false;
  end
  else
  begin
    memtbOtherFollowUp.Filter := 'ContactId=' + IntToStr(Integer(cboContactSelector.Items.Objects[cboContactSelector.ItemIndex])); //IntToStr(cboContactSelector.Value);
    memtbOtherFollowUp.Filtered := true;
    tbOtherFollowUp.Filter := 'ContactId=' + IntToStr(Integer(cboContactSelector.Items.Objects[cboContactSelector.ItemIndex]));//IntToStr(cboContactSelector.Value);
    tbOtherFollowUp.Filtered := true;
  end;
end;


procedure TfrmCustomer.cboContactSelectorSelect(Sender: TObject);
begin
  if (cboContactSelector.Items.Count = 0) or
     (cboContactSelector.ItemIndex <= 0) then
  begin
    memtbOtherFollowUp.Filtered := false;
    tbOtherFollowUp.Filtered := false;
  end
  else
  begin
    memtbOtherFollowUp.Filter := 'ContactId=' + IntToStr(Integer(cboContactSelector.Items.Objects[cboContactSelector.ItemIndex])); //IntToStr(cboContactSelector.Value);
    memtbOtherFollowUp.Filtered := true;
    tbOtherFollowUp.Filter := 'ContactId=' + IntToStr(Integer(cboContactSelector.Items.Objects[cboContactSelector.ItemIndex]));//IntToStr(cboContactSelector.Value);
    tbOtherFollowUp.Filtered := true;
  end;
end;

procedure TfrmCustomer.cboIncoPlaceEnter(Sender: TObject);
begin
  inherited;
  if not (QrySuburb.Active) then begin
    QrySuburb.Active := true;
  end;
end;

procedure TfrmCustomer.qryCustomersAfterInsert(DataSet: TDataSet);
begin
  inherited;
  fbclientnameMadeFromName := False;
  postDB(qryCustomers);
  LoadMemTable;
  EditDB(qryCustomers);
  qryCustomersClientTypeID.asInteger := DefaultclientTypeId;
  qryCustomersDocumentPath.AsString := Appenv.DocPath.DocumentPath;
  EditDB(qryCustomers);
  CustomerIDChange;
end;

function TfrmCustomer.ListAppoints: TBaseListingGUI;
begin
  CreateHistorylistform('TAppointmentListGUI' ,Self, fListAppoints,'ClientID', IntToStr(qryCustomersClientID.asInteger));
  result := fListAppoints;
end;

function TfrmCustomer.ListArNotes: TBaseListingGUI;
begin
  CreateHistorylistform('TAccountsReceivableNotes' ,Self, fListArNotes,'ClientID' , IntToStr(qryCustomersClientID.asInteger));
  result := fListArNotes;
end;

function TfrmCustomer.ListInvoices: TBaseListingGUI;
begin
  CreateHistorylistform('TInvoiceListGUI' ,Self, fListInvoices,'ClientID  ' , IntToStr(qryCustomersClientID.asInteger));
  result := fListInvoices;
end;

function TfrmCustomer.ListJobprofit: TBaseListingGUI;
begin
  CreateHistorylistform('TJobProfitabilityforCustomerGUI' ,Self, fListJobprofit,'ClientID  ' , IntToStr(qryCustomersClientID.asInteger) ,InitListofHistoryforms);
  result := fListJobprofit;
end;

function TfrmCustomer.ListJobs: TBaseListingGUI;
begin
  CreateHistorylistform('TJobListGUI' ,Self, fListJobs,'ParentClientID', IntToStr(qryCustomersClientID.asInteger));
  result := fListJobs;
end;

function TfrmCustomer.ListProductSales: TBaseListingGUI;
begin
  CreateHistorylistform('TCustomerSalesOnProductListGUI' ,Self, fListProductSales );
  result := fListProductSales;
  TCustomerSalesOnProductListGUI(fListProductSales).lblCustomer.Caption := GetClientName(qryCustomersClientID.asInteger);
  TCustomerSalesOnProductListGUI(fListProductSales).fiClientID := qryCustomersClientID.asInteger;
  TCustomerSalesOnProductListGUI(fListProductSales).fiProductID := 0;
end;
procedure TfrmCustomer.InitListofHistoryforms(Sender: TObject);
begin
   if Sender.ClassnameIs('TJobProfitabilityforCustomerGUI')  then TJobProfitabilityforCustomerGUI(Sender).ClientID := qryCustomersClientID.asInteger ;
end;

function TfrmCustomer.ListQuotes: TBaseListingGUI;
begin
  CreateHistorylistform('TQuoteListGUI' ,Self, fListQuotes,'ClientID  ' , IntToStr(qryCustomersClientID.asInteger));
  result := fListQuotes;
end;

function TfrmCustomer.SalesOrderList: TBaseListingGUI;
begin
  CreateHistorylistform('TSalesOrderListGUI' ,Self, fListSalesOrder,'ClientID  ' , IntToStr(qryCustomersClientID.asInteger));
  result := fListSalesOrder;
end;
Function TfrmCustomer.CustomerContactListForm: TBaseListingGUI;
begin
  if fCustomerContactListForm = nil then begin
    CreateHistorylistform('TCustomFieldValuesListContactGUI' ,Self, fCustomerContactListForm,'ClientID  ' , IntToStr(qryCustomersClientID.asInteger));
  end;
  if chkShowAll.Checked then
    fCustomerContactListForm.FilterString := ''
  else
    fCustomerContactListForm.FilterString := '(Active = "T")';

  result := fCustomerContactListForm;
end;
function TfrmCustomer.StatementsList: TBaseListingGUI;
begin
  CreateHistorylistform('TStatementListGUI' ,Self, fListStatements,'ClientID  ' , IntToStr(qryCustomersClientID.asInteger));
  result := fListStatements;
end;

function TfrmCustomer.TimesheetList: TBaseListingGUI;
begin
  CreateHistorylistform('TfrmPayTimesheet' ,Self, fListTimesheet,'jobid ' , IntToStr(qryCustomersClientID.asInteger));
  result := fListTimesheet;
end;
function TfrmCustomer.NonERPSalesList: TBaseListingGUI;
begin
  CreateHistorylistform('TNonERPSalesListGUI' ,Self, fListNonERPSales,'ClientID ' , IntToStr(qryCustomersClientID.asInteger));
  result := fListNonERPSales;
end;
function TfrmCustomer.cleintHRFormsList: TBaseListingGUI;
begin
  CreateHistorylistform('TclientHRFormsGUI' ,Self, fListcleintHRForms,'ClientID ' , IntToStr(qryCustomersClientID.asInteger));
  TclientHRFormsGUI(fListcleintHRForms).btnNewHrform.visible := True;
  result := fListcleintHRForms;
end;

function TfrmCustomer.RepairsList: TBaseListingGUI;
begin
  CreateHistorylistform('TRepairsList' ,Self, fRepairList);
  result := fRepairList;
  TRepairsList(fRepairList).clientID := Self.KeyId;
end;


function TfrmCustomer.RewardPointList: TBaselistingGUI;
begin
  CreateHistorylistform('TStatementListGUI' ,Self, fRewardPoints,'ClientID  ' , IntToStr(qryCustomersClientID.asInteger));
  result := fRewardPoints;
end;

procedure TfrmCustomer.EmailDblClick(Sender: TObject);
begin
  inherited;
  if qryCustomersEmail.AsString <> '' then
    EmailUtilsDefaultMailClient.SendMail(qryCustomersEmail.AsString,'','');
end;

procedure TfrmCustomer.AfterformShow;
begin
  inherited;
  fLastComboAccessed:= nil;
end;


procedure TfrmCustomer.AfterPopupformshow;
var
  lForm : TBaseListingGUI;
begin
  inherited;
  if Sysutils.SameText(CallingClassName , 'TContactListGUI') or
    Sysutils.SameText(CallingClassName , 'TGlobalsearchGUI')  then
    TabCtl20.Activepage := tabContacts
  else if SameText(CallingClassName, 'TReminderListGUI') then
  begin
    lForm := TBaseListingGUI(FindExistingComponent('TReminderListGUI'));
    SetContactFilter(lForm.qryMain.FieldByName('ContactId').AsInteger);
    tabCtl20.ActivePage := tabReferrals;
    MiscPageControl.ActivePage := tabFollowUp;
    cboContactSelectorChange(Self);
  end;

end;

procedure TfrmCustomer.AftershowPopupform(frmPopup: TBaseInputGUI);
begin
  inherited;
  if frmPopup is TfmPaymentMethod then begin
    if Assigned(fLastComboAccessed) and (fLastComboAccessed = cboCreditCardType) then begin
      if TfmPaymentMethod(frmPopup).KeyId =0 then begin
        TfmPaymentMethod(frmPopup).KeyId := GetPaymentMethod(cboCreditCardType.text);
        TfmPaymentMethod(frmPopup).Initform;
      end;
      TfmPaymentMethod(frmPopup).isCreditCard := True;
    end;
  end;
end;
procedure TfrmCustomer.QryCustomersCalcFields(DataSet: TDataSet);
begin
  inherited;
  QryCustomerscDocumentPath.AsString  := cDocumentPath(QryCustomers);
end;

procedure TfrmCustomer.btnSetDocumentPathClick(Sender: TObject);
begin
  SetDocPath(QryCustomers);
end;

procedure TfrmCustomer.btnOpenDocumentPathClick(Sender: TObject);
begin
  inherited;
   OpenDocPath(QryCustomers);
end;

procedure TfrmCustomer.btnPriceListClick   (Sender: TObject);
var
  s:string;
begin
  if Appenv.Employee.CustomerPriceLsitOption =1 then  s:= 'TCustomerPriceListGUI'else s:= 'TfrmPriceListGUI';
  if s= '' then s:=   'TCustomerPriceListGUI';
  OpenERPListForm(s    , initfrmPriceListGUI);
end;

procedure TfrmCustomer.initfrmPriceListGUI(Sender: TObject);
begin
  if sender is TfrmPriceListGUI then begin
    TfrmPriceListGUI(Sender).ClientTypeID := Self.qryClientTypes.FieldByName('ClientTypeID').AsInteger;
    TfrmPriceListGUI(Sender).CustomerID := KeyID;
    TfrmPriceListGUI(Sender).CustomerPriceList := True;
  end else if sender is TCustomerPriceListGUI then begin
    TCustomerPriceListGUI(Sender).CustomerTypeID := qryCustomersClientTypeID.AsInteger;
    TCustomerPriceListGUI(Sender).CustomerID := qryCustomersClientID.AsInteger;
    TCustomerPriceListGUI(Sender).CustomerPriceList := True;
  end;
end;
procedure TfrmCustomer.InitGridcolumnsforGuiPrefs(sender:TwwDBGrid);
begin
    if (Sender = nil) or (sender = grdDocs) then begin
      GuiPrefs.DbGridElement[grdDocs].RemoveField(qryDocumentsactive.fieldname);
      GuiPrefs.DbGridElement[grdDocs].RemoveField(qryDocumentsContactID.fieldname);
      GuiPrefs.DbGridElement[grdDocs].RemoveField(qryDocumentsCusID.fieldname);
      GuiPrefs.DbGridElement[grdDocs].RemoveField(qryDocumentsEditedFlag.fieldname);
      GuiPrefs.DbGridElement[grdDocs].RemoveField(qryDocumentsMessageId.fieldname);
      GuiPrefs.DbGridElement[grdDocs].RemoveField(qryDocumentsRefID.fieldname);
    end;
    if (Sender = nil) or (sender = grdFollowUp) then begin
      GuiPrefs.DbGridElement[grdFollowUp].RemoveField(tbOtherFollowUpClientID.fieldname);
      GuiPrefs.DbGridElement[grdFollowUp].RemoveField(tbOtherFollowUpContactId.fieldname);
      GuiPrefs.DbGridElement[grdFollowUp].RemoveField(tbOtherFollowUpEditedFlag.fieldname);
      GuiPrefs.DbGridElement[grdFollowUp].RemoveField(tbOtherFollowUpEmployeeID.fieldname);
      GuiPrefs.DbGridElement[grdFollowUp].RemoveField(tbOtherFollowUpFollowUpID.fieldname);
      GuiPrefs.DbGridElement[grdFollowUp].RemoveField(tbOtherFollowUpGlobalRef.fieldname);
      GuiPrefs.DbGridElement[grdFollowUp].RemoveField(tbOtherFollowUpLeadLineID.fieldname);
      GuiPrefs.DbGridElement[grdFollowUp].RemoveField(tbOtherFollowUpOtherContactID.fieldname);
      GuiPrefs.DbGridElement[grdFollowUp].RemoveField(tbOtherFollowUpRepairID.fieldname);
    end;
    if (Sender = nil) or (sender = grdProdGroupDiscs) then begin
      GuiPrefs.DbGridElement[grdProdGroupDiscs].RemoveField(qryProdGroupDiscsClientID.FieldName);
      GuiPrefs.DbGridElement[grdProdGroupDiscs].RemoveField(qryProdGroupDiscsEditedFlag.FieldName);
      GuiPrefs.DbGridElement[grdProdGroupDiscs].RemoveField(qryProdGroupDiscsGlobalRef.FieldName);
      GuiPrefs.DbGridElement[grdProdGroupDiscs].RemoveField(qryProdGroupDiscsGrpDiscID.FieldName);
      GuiPrefs.DbGridElement[grdProdGroupDiscs].RemoveField(qryProdGroupDiscsmsTimeStamp.FieldName);
      GuiPrefs.DbGridElement[grdProdGroupDiscs].RemoveField(qryProdGroupDiscsmsUpdateSiteCode.FieldName);
    end;
    if (Sender = nil) or (sender = grdReferrals) then begin
      GuiPrefs.DbGridElement[grdReferrals].RemoveField(qryReferralsClientID.fieldname);
      GuiPrefs.DbGridElement[grdReferrals].RemoveField(qryReferralsEditedFlag.fieldname);
      GuiPrefs.DbGridElement[grdReferrals].RemoveField(qryReferralsReferralID.fieldname);
      GuiPrefs.DbGridElement[grdReferrals].RemoveField(qryReferralsReferredClientID.fieldname);
    end;
    if (Sender = nil) or (sender = grdRelatedClient) then begin
      GuiPrefs.DbGridElement[grdRelatedClient].RemoveField(qryRelatedClientsChildClientID.fieldname);
      GuiPrefs.DbGridElement[grdRelatedClient].RemoveField(qryRelatedClientsMasterClientID.fieldname);
      GuiPrefs.DbGridElement[grdRelatedClient].RemoveField(qryRelatedClientsRelatedClientID.fieldname);
    end;
    if (Sender = nil) or (sender = grdShipAddressList) then begin
      GuiPrefs.DbGridElement[grdShipAddressList].RemoveField(QrycustomerShipAddresslistClientID.fieldname);
      GuiPrefs.DbGridElement[grdShipAddressList].RemoveField(QrycustomerShipAddresslistCustomer_ID.fieldname);
      GuiPrefs.DbGridElement[grdShipAddressList].RemoveField(QrycustomerShipAddresslistShipAddressId.fieldname);
    end;
    if (Sender = nil) or (sender = grdSpecials) then begin
      GuiPrefs.DbGridElement[grdSpecials].RemoveField(qrySpecialsCustomerId.FieldName);
      GuiPrefs.DbGridElement[grdSpecials].RemoveField(qrySpecialsCustomerLinesID.FieldName);
      GuiPrefs.DbGridElement[grdSpecials].RemoveField(qrySpecialsEditedFlag.FieldName);
      GuiPrefs.DbGridElement[grdSpecials].RemoveField(qrySpecialsGlobalRef.FieldName);
      GuiPrefs.DbGridElement[grdSpecials].RemoveField(qrySpecialsmsTimeStamp.FieldName);
      GuiPrefs.DbGridElement[grdSpecials].RemoveField(qrySpecialsmsUpdateSiteCode.FieldName);
      GuiPrefs.DbGridElement[grdSpecials].RemoveField(qrySpecialsProductId.FieldName);
      GuiPrefs.DbGridElement[grdSpecials].RemoveField(qrySpecialsUOMID.FieldName);
      GuiPrefs.DbGridElement[grdSpecials].RemoveField(qrySpecialsUOMMultiplier.FieldName);
    end;
    if (Sender = nil) or (sender = grdTaxExceptionProducts) then begin
      GuiPrefs.DbGridElement[grdTaxExceptionProducts].RemoveField(qryTaxExceptionProductsClientID.Fieldname);
      GuiPrefs.DbGridElement[grdTaxExceptionProducts].RemoveField(qryTaxExceptionProductsglobalref.Fieldname);
      GuiPrefs.DbGridElement[grdTaxExceptionProducts].RemoveField(qryTaxExceptionProductsID.Fieldname);
      GuiPrefs.DbGridElement[grdTaxExceptionProducts].RemoveField(qryTaxExceptionProductsmsTimeStamp.Fieldname);
      GuiPrefs.DbGridElement[grdTaxExceptionProducts].RemoveField(qryTaxExceptionProductsmsUpdatesitecode.Fieldname);
      GuiPrefs.DbGridElement[grdTaxExceptionProducts].RemoveField(qryTaxExceptionProductsProductId.Fieldname);
    end;

end;
function TfrmCustomer.ClientId: Integer;
begin
  REsult := qryCustomersClientId.AsInteger;
end;
procedure TfrmCustomer.LoadCoreEDIConfig;
begin
  edtSaleSendUser.text    := CustomerObj.CoreEDIConfig.Config.O['SALES'].O['FTP'].S['User'];
  edtSaleSendPass.text    := CustomerObj.CoreEDIConfig.Config.O['SALES'].O['FTP'].S['Pass'];
  edtSaleSendServer.text  := CustomerObj.CoreEDIConfig.Config.O['SALES'].O['FTP'].S['Server'];
  edtSaleSendDir.text     := CustomerObj.CoreEDIConfig.Config.O['SALES'].O['FTP'].S['SendDir'];
  edtSaleReceiveDir.text  := CustomerObj.CoreEDIConfig.Config.O['SALES'].O['FTP'].S['ReceiveDir'];
  edtEDIVendorCode.text   := CustomerObj.CoreEDIConfig.Config.S['EDICompVendorCode'];
  edtSaleFTPPort.text     := inttostr(CustomerObj.CoreEDIConfig.Config.O['SALES'].O['FTP'].I['Port']); if edtSaleFTPPort.text ='0' then edtSaleFTPPort.text := '';
  edtLocalReceiveDir.text := CustomerObj.CoreEDIConfig.Config.O['SALES'].O['FTP'].S['LocalReceiveDir'];
end;
procedure TfrmCustomer.edtEDIVendorCodeChange   (Sender: TObject);begin  if not TEdit(Sender).Focused then exit;  CustomerObj.CoreEDIConfig.Config.S['EDICompVendorCode']             := edtEDIVendorCode.text  ;end;
procedure TfrmCustomer.edtSaleReceiveDirChange  (Sender: TObject);begin  if not TEdit(Sender).Focused then exit;  CustomerObj.CoreEDIConfig.Config.O['SALES'].O['FTP'].S['ReceiveDir']:= TEdit(Sender).text     ;end;
procedure TfrmCustomer.edtSaleSendDirChange     (Sender: TObject);begin  if not TEdit(Sender).Focused then exit;  CustomerObj.CoreEDIConfig.Config.O['SALES'].O['FTP'].S['SendDir']   := TEdit(Sender).text     ;end;
procedure TfrmCustomer.edtSaleSendPassChange    (Sender: TObject);begin  if not TEdit(Sender).Focused then exit;  CustomerObj.CoreEDIConfig.Config.O['SALES'].O['FTP'].S['Pass']      := edtSaleSendPass.text   ;end;
procedure TfrmCustomer.edtSaleSendServerChange  (Sender: TObject);begin  if not TEdit(Sender).Focused then exit;  CustomerObj.CoreEDIConfig.Config.O['SALES'].O['FTP'].S['Server']    := edtSaleSendServer.text ;end;
procedure TfrmCustomer.edtSaleSendUserChange    (Sender: TObject);begin  if not TEdit(Sender).Focused then exit;  CustomerObj.CoreEDIConfig.Config.O['SALES'].O['FTP'].S['User']      := edtSaleSendUser.text   ;end;
procedure TfrmCustomer.edtLocalReceiveDirChange (Sender: TObject);begin  if not TEdit(Sender).Focused then exit;  CustomerObj.CoreEDIConfig.Config.O['SALES'].O['FTP'].S['LocalReceiveDir']    := TEdit(Sender).text     ;end;
procedure TfrmCustomer.edtSaleFTPPortChange     (Sender: TObject);begin  if not TEdit(Sender).Focused then exit;  try CustomerObj.CoreEDIConfig.Config.O['SALES'].O['FTP'].I['Port']  := strtoint(TEdit(Sender).text);except end;end;

function TfrmCustomer.CoreEDIConfigSave: boolean;
begin
  Result := true;
  if CustomerObj.Container.Exists(TCoreEDIConfig) then begin
    result := CustomerObj.CoreEDIConfig.Save;
    if not result then begin
      CustomerObj.AddResult(false, rssWarning, 0, CustomerObj.CoreEDIConfig.ResultStatus.Messages);
      exit;
    end;
  end;
end;
procedure TfrmCustomer.Encrypt1Click(Sender: TObject);
begin
  inherited;
  txtCardNumber.text := EncryptCreditCardNumber(txtCardNumber.text);
  Setcontrolfocus(txtCardNumber);
end;
procedure TfrmCustomer.RestoreFromTable1Click(Sender: TObject);
begin
  inherited;
  txtCardNumber.text := qryCustomers.FieldByName('CreditCardNumber').AsString;
  Setcontrolfocus(txtCardNumber);
end;
procedure TfrmCustomer.Decrypt1Click(Sender: TObject);
begin
  inherited;
  txtCardNumber.text :=  DecryptCreditCardNumber(txtCardNumber.text);
  Setcontrolfocus(txtCardNumber);
end;
Function TfrmCustomer.DecryptCreditCardNumber(sTemp: string):String;
begin
        Result:= '';
        if sTemp <> '' then begin
          {$ifdef COMPILER_22_UP}
          result:= EncryptFix.DecryptString(sTemp);
          {$else}
          result:= lbBlowFish1.DecryptString(sTemp);
          {$endif}
        end;
end;
Function TfrmCustomer.EncryptCreditCardNumber(const sTemp:String):String;
begin
    {$ifdef COMPILER_22_UP}
    REsult := CipherUtils.EncryptString(sTemp);
    {$else}
    REsult := lbBlowFish1.EncryptString(sTemp);
    {$endif}
end;

initialization
  RegisterClassOnce(TfrmCustomer);

  with FormFact do begin
    RegisterMe(TfrmCustomer, 'TAppointmentListGUI_Company_Customer=ClientID');
    RegisterMe(TfrmCustomer, 'TOtherfollowupsGUI_*_Customer=ClientID');
    (*RegisterMe(TfrmCustomer, 'TRemindersListGUI_Client_AppointmentCustomer=ClientID');*)
    RegisterMe(TfrmCustomer, 'TReminderListGUI_Client_AppointmentCustomer=ClientID');
    (*RegisterMe(TfrmCustomer, 'TRemindersListGUI_Client_Repair FollowUp=ClientID');*)
    RegisterMe(TfrmCustomer, 'TReminderListGUI_Client_Repair FollowUp=ClientID');
    RegisterMe(TfrmCustomer, 'TClientListGUI_*_Customer=ClientID');
    RegisterMe(TfrmCustomer, 'TContactListGUI_*_Customer=ClientID');
    (*RegisterMe(TfrmCustomer, 'TRemindersListGUI_*_Customer FollowUp=ClientID');*)
    RegisterMe(TfrmCustomer, 'TReminderListGUI_*_Customer FollowUp=ClientID');
    RegisterMe(TfrmCustomer, 'TCustomerListGUI_*_F=ClientID');
    RegisterMe(TfrmCustomer, 'TCustlistWithDetailsGUI_*_F=ClientID');
    RegisterMe(TfrmCustomer, 'TCustomerExpressListGUI_*_F=ClientID');
    RegisterMe(TfrmCustomer, 'TRelatedCustomerListGUI_*_ParentCustomer=ParentRelatedClientID');
    RegisterMe(TfrmCustomer, 'TRelatedCustomerListGUI_*=ClientID');
    RegisterMe(TfrmCustomer, 'TQuoteListGUI_Customer Name_Customer=ClientID');
    RegisterMe(TfrmCustomer, 'TQuoteListGUI_FundingBody_Customer=FundingBodyId');
    RegisterMe(TfrmCustomer, 'TSalesorderListExpressGUI_CustomerName_Customer=ClientID');
    RegisterMe(TfrmCustomer, 'TWalmartSalesOrdersGUI_CustomerName_Customer=ClientID');
    RegisterMe(TfrmCustomer, 'TInvoicelistExpressGUI_CustomerName_Customer=ClientID');
    RegisterMe(TfrmCustomer, 'TInvoiceInternalOrderlistExressGUI_CustomerName_Customer=ClientID');
    RegisterMe(TfrmCustomer, 'TSalesAddressLabelPrnGUI_CustomerName_Customer=ClientID');
    RegisterMe(TfrmCustomer, 'TSalesToRefundListGUI_CustomerName_Customer=ClientID');
    RegisterMe(TfrmCustomer, 'TQuoteListExpressGUI_CustomerName_Customer=ClientID');
    RegisterMe(TfrmCustomer, 'TInvoicesPrnGUI_CustomerName=ClientID');


    RegisterMe(TfrmCustomer, 'TSalescommissionListGUI_Company_Customer=ClientID');
    RegisterMe(TfrmCustomer, 'TSalesReportGUI_Customer Name_*=ClientID');
    RegisterMe(TfrmCustomer, 'TSalesReportCustomercustomFieldListGUI_Customer Name_*=ClientID');
    RegisterMe(TfrmCustomer, 'TSalesReportProductcustomFieldListGUI_Customer Name_*=ClientID');
    RegisterMe(TfrmCustomer, 'TSalesReportSaleslinescustomFieldListGUI_Customer Name_*=ClientID');
    RegisterMe(TfrmCustomer, 'TSerialListGUI_Company_*=ClientID');
    RegisterMe(TfrmCustomer, 'TClientEquipmentlist_Company=ClientID');
    RegisterControl(TfrmCustomer, '*_cboClientR=ClientID');
    RegisterControl(TfrmCustomer, '*_cboRetailer=ClientID');
    RegisterControl(TfrmCustomer, '*_cboVeteran=ClientID'); // for the veteranId in the sales order and invoice
    RegisterControl(TfrmCustomer, '*_cboCustomerJob=ClientID');
    RegisterControl(TfrmCustomer, '*_cboCompany=ClientID');
    RegisterControl(TfrmCustomer, '*_cboCusID=ClientID');
    RegisterControl(TfrmCustomer, '*_cboClientJob=CusID');
    RegisterMe(TfrmCustomer, 'TCustomerDetailsListGUI_*=ClientID');
    RegisterMe(TfrmCustomer, 'TCustomerNotesReportGUI_*_F=ClientID');
    RegisterMe(TfrmCustomer, 'TfrmCustomerJobFollowupList_*_Customer=ClientID');
    RegisterMe(TfrmCustomer, 'TMarketingLeadsGUI_Company_Customer=ClientID');
    RegisterMe(TfrmCustomer, 'TCustomFieldValuesListLeadsGUI_Company_Customer=ClientID');
    RegisterMe(TfrmCustomer, 'TClientMainContactsGUI_*_Customer=ClientID');
    RegisterMe(TfrmCustomer, 'TGlobalListSearchFrm_*_Customer / Supplier(contact)=ID');
    RegisterMe(TfrmCustomer, 'TGlobalListSearchFrm_*_Customer / Supplier(Primary Contact)=ID');
    RegisterMe(TfrmCustomer, 'TGlobalListSearchFrm_*_Customer / Supplier=ID');
    RegisterMe(TfrmCustomer, 'TGlobalListSearchFrm_*_Customer(Contact)=ID');
    RegisterMe(TfrmCustomer, 'TGlobalListSearchFrm_*_Customer(Primary Contact)=ID');
    RegisterMe(TfrmCustomer, 'TGlobalListSearchFrm_*_Customer=ID');

    RegisterMe(TfrmCustomer, 'TGlobalListFrm_*_Customer / Supplier(contact)=ID');
    RegisterMe(TfrmCustomer, 'TGlobalListFrm_*_Customer / Supplier=ID');
    RegisterMe(TfrmCustomer, 'TGlobalListFrm_*_Customer(Contact)=ID');
    RegisterMe(TfrmCustomer, 'TGlobalListFrm_*_Customer=ID');
    RegisterMe(TfrmCustomer, 'TRewardPointsGUI_*_OpeningBalance=clientid');
    RegisterMe(TfrmCustomer, 'TRewardPointsDetailsGUI_*_OpeningBalance=clientid');
    RegisterMe(TfrmCustomer, 'TRewardPointsDueToExpireGUI_*_OpeningBalance=clientid');
    RegisterMe(TfrmCustomer, 'TMarketingContactListGUI_*_C=ClientID');
    RegisterMe(TfrmCustomer, 'TJobtimeSheetsGUI_SaleCustomerName=ClientId');
    RegisterMe(TfrmCustomer, 'TNonERPSalesListGUI_CustomerName=ClientId');
    RegisterMe(TfrmCustomer, 'TclientHRFormsGUI_CustomerName=ClientId');
    RegisterMe(TfrmCustomer, 'TProductionJobStatusGUI_SaleCustomerName=ClientId');
    RegisterMe(TfrmCustomer, 'TProductionjobstatusdetailsList_SaleCustomerName=ClientId');
    RegisterMe(TfrmCustomer, 'TBOMOrderStatusGUI_SaleCustomerName=ClientId');
    RegisterMe(TfrmCustomer, 'TrelatedcustomersGUI_Mastercompany=MAsterclientID');
    RegisterMe(TfrmCustomer, 'TrelatedcustomersGUI_Childcompany=ChildclientID');
    RegisterMe(TfrmCustomer, 'TProductgroupdiscountListGUI_*_=ClientId');
    RegisterMe(TfrmCustomer, 'TSpecialProductsGUI_*_=CustomerID');
    RegisterMe(TfrmCustomer, 'TGlobalsearchGUI_*_Customer=clientID');
    RegisterMe(TfrmCustomer, 'TProductstoExcludeDefaultTaxCodeGUI_*_=ClientID');
//    RegisterMe(TfrmCustomer, 'TShipAddressListGUI_*_Client=ClientID');
    RegisterMe(TfrmCustomer, 'TShipAddressListGUI_*_Client=Customer_ID');
    RegisterMe(TfrmCustomer, 'TfrmPriceListGUI_*_Client=ClientId');
    RegisterMe(TfrmCustomer, 'TCustomFieldValuesListContactGUI_*_Customer=ClientId');
    RegisterMe(TfrmCustomer, 'TCustomFieldValuesListCustomerGUI_*=ClientId');



  end;

end.








