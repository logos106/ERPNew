{ Date     Version Who What
 -------- -------- --- ------------------------------------------------------
 05/05/05  1.00.01 BJ  Implemented the mask edit for BSB
 23/05/05  1.00.02 BJ  Checked for the access levels in the history tab
 03/06/05  1.00.03 BJ  If the company name is duplicate, changing the tab
                       is causing a run time error -> fixed
 27/06/05  1.00.04 BJ  New property introduced to open the form to select the foreign currency
                       When the supplier is selected in the parts form for 'Extra Sell price'
                       if the 'ForeignExchangeSellCode' is blank, supplier form is opened with
                       this peoperty set to 'True'.
                       When the property is True, the form is opened with the 'General' tab
                       active with focus on the 'foreign Currency' field.
 22/07/05  1.00.05 IJB Implemented UserLock object to prevent wait lock
                       timeouts.
 26/08/05  1.00.12 BJ  SetContractDefaults sets the defualt values for the new
                        contract record
 31/08/05  1.00.13 IJB Added AfterPOst event to set forms KeyId (needed when
                       form created from NotInList processing from Purchase
                       Order).
 16/09/05  1.00.04 DSP Removed the default setting of the 'Active' field of the
                       contact.
 23/12/05  1.00.09 AL  Added button next to phone number
 25/01/07  1.00.10 DSP Added default purchase order template option.

}

unit frmSupplier;
{$I ERP.inc}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, StdCtrls, Mask, DBCtrls, ExtCtrls, DBCGrids, ComCtrls,AdvOfficeStatusBar,
  BaseInputForm, wwdblook, jpeg, Buttons, DNMSpeedButton, DNMPanel, Word2000,
  OleServer, Variants, Wwdbigrd, Grids, Wwdbgrid, BaseListingForm,
  wwdbedit, wwdbdatetimepicker, Wwdotdot, Wwdbcomb, Wwdbspin,
  wwriched, kbmMemTable, DBAccess, MyAccess,ERPdbComponents, MemDS, SelectionDialog,
  AppEvnts, DataState, frmContactFrm, Menus, AdvMenus, wwcheckbox, Shader,
  ImgList, frmClientEquipment, WordXP, JsonObject, Busobjcustomfields,
  frmAttachments, ProgressDialog, HTMLUn2, HtmlView, IdMessage,
  FileAssociationDetails, ERPDbLookupCombo ,frmClient, BusObjClient, BusObjBase;

type
  TfmSupplier = class(TfmClient)
    frmSupplierSrc: TDataSource;
    Label141: TLabel;
    edtCompany: TDBMemo;
    qrySupplier: TERPQuery;
    cmdOk: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    qryDocuments: TERPQuery;
    qryContacts: TERPQuery;
    DSContacts: TDataSource;
    DSDocuments: TDataSource;
    Label4: TLabel;
    Bevel6: TBevel;
    WordApplication1:TWordApplication;
    cmdNew: TDNMSpeedButton;
    cmdNotes: TDNMSpeedButton;
    cmdPrint: TDNMSpeedButton;
    Button1: TDNMSpeedButton;
    //    qryEmpID: TERPQuery;
    //    cboEmployeeIDSrc: TDataSource;
    TabCtl20: TPageControl;
    Supplier_Info: TTabSheet;
    DNMPanel1: TDNMPanel;
    Box70: TBevel;
    Box69: TBevel;
    lblCompany: TLabel;
    Label27: TLabel;
    Label74: TLabel;
    Label78: TLabel;
    Label31: TLabel;
    Label76: TLabel;
    Label33: TLabel;
    Label8: TLabel;
    txtCompany: TDBEdit;
    txtContactTitle: TDBEdit;
    txtContactFirstName: TDBEdit;
    txtContactLastName: TDBEdit;
    txtPhoneNumber: TwwDBEdit;
    txtFaxNumber: TwwDBEdit;
    txtAltPhone: TwwDBEdit;
    edtNotes: TDBMemo;
    Address: TTabSheet;
    General: TTabSheet;
    DNMPanel6: TDNMPanel;
    Box76: TBevel;
    Label56: TLabel;
    Label52: TLabel;
    Label65: TLabel;
    Label9: TLabel;
    Label163: TLabel;
    Label1: TLabel;
    AccountNo: TDBEdit;
    ABN: TDBEdit;
    History: TTabSheet;
    pnlHistory: TDNMPanel;
    grpHistory: TRadioGroup;
    Contacts: TTabSheet;
    DNMPanel3: TDNMPanel;
    Bevel2: TBevel;
    letterflag: TCheckBox;
    Faxflag: TCheckBox;
    Emailflag: TCheckBox;
    chkShowAll: TCheckBox;
    CNewbtn: TDNMSpeedButton;
    Emailbtn: TDNMSpeedButton;
    Faxbtn: TDNMSpeedButton;
    Letterbtn: TDNMSpeedButton;
    Editbtn: TDNMSpeedButton;
    Documents: TTabSheet;
    Custom_Fields: TTabSheet;
    tabEquip: TTabSheet;
    Bevel4: TBevel;
    dsOtherFollowUp: TDataSource;
    Bevel5: TBevel;
    qrySupplierPhone: TWideStringField;
    qrySupplierFaxNumber: TWideStringField;
    qrySupplierMobile: TWideStringField;
    qrySupplierAltPhone: TWideStringField;
    qrySupplierContact1Phone: TWideStringField;
    qrySupplierContact2Phone: TWideStringField;
    qrySupplierClientID: TAutoIncField;
    qrySupplierCompany: TWideStringField;
    qrySupplierABN: TWideStringField;
    qrySupplierFirstName: TWideStringField;
    qrySupplierMiddleName: TWideStringField;
    qrySupplierLastName: TWideStringField;
    qrySupplierPosition: TWideStringField;
    qrySupplierEmail: TWideStringField;
    qrySupplierAltContact: TWideStringField;
    qrySupplierContact1: TWideStringField;
    qrySupplierPhoneSupportTill: TDateField;
    qrySupplierContact2: TWideStringField;
    qrySupplierNotes: TWideMemoField;
    qrySupplierMedTypeID: TIntegerField;
    qrySupplierTYPE: TWideStringField;
    qrySupplierCreditLimit: TFloatField;
    qrySupplierBalance: TFloatField;
    qrySupplierTERMS: TWideStringField;
    qrySupplierTermsID: TIntegerField;
    qrySupplierShippingMethod: TWideStringField;
    qrySupplierShippingID: TIntegerField;
    qrySupplierDiscount: TFloatField;
    qrySupplierSpecialDiscount: TFloatField;
    qrySupplierJobName: TWideStringField;
    qrySupplierIsJob: TWideStringField;
    qrySupplierPayMethodID: TIntegerField;
    qrySupplierFeedback: TWideStringField;
    qrySupplierCustomer: TWideStringField;
    qrySupplierSupplier: TWideStringField;
    qrySupplierOtherContact: TWideStringField;
    qrySupplierOtherContactType: TIntegerField;
    qrySupplierRepID: TIntegerField;
    qrySupplierGlobal: TWideStringField;
    qrySupplierDone: TWideStringField;
    qrySupplierActive: TWideStringField;
    qrySupplierEditedFlag: TWideStringField;
    qrySupplierCorrespondenceMethod: TWideStringField;
    Terms: TwwDBLookupCombo;
    cboShipping: TwwDBLookupCombo;
    cboCorrespondence: TwwDBComboBox;
    cboRep: TwwDBLookupCombo;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Label7: TLabel;
    edtNormShipTime: TwwDBSpinEdit;
    qrySupplierShipTime: TWordField;
    cmdShipping: TDNMSpeedButton;
    qrySupplierClientNo: TWideStringField;
    Label10: TLabel;
    Bevel9: TBevel;
    edtBankAccName: TwwDBEdit;
    lblBSB: TLabel;
    edtBankAccBSB: TwwDBEdit;
    Label12: TLabel;
    qrySupplierBankAccountName: TWideStringField;
    qrySupplierBankAccountBSB: TWideStringField;
    qrySupplierBankAccountNo: TWideStringField;
    qrySupplierTAXID: TIntegerField;
    qrySupplierTitle: TWideStringField;
    txtMobile: TwwDBEdit;
    Label13: TLabel;
    qrySupplierURL: TWideStringField;
    memqrySupplier: TkbmMemTable;
    memqryContacts: TkbmMemTable;
    Bevel10: TBevel;
    Label17: TLabel;
    cboPaymentMethod: TwwDBLookupCombo;
    memtbOtherFollowUp: TkbmMemTable;
    qrySupplierRequired: TWideStringField;
    qrySupplierRepName: TWideStringField;
    qrySupplierBankCode: TWideStringField;
    Label18: TLabel;
    cboBankCode: TwwDBLookupCombo;
    Label19: TLabel;
    Bevel11: TBevel;
    cboForeignCurrencyCode: TwwDBLookupCombo;
    qrySupplierForeignExchangeSellCode: TWideStringField;
    qrySupplierStreet: TWideStringField;
    qrySupplierStreet2: TWideStringField;
    qrySupplierSuburb: TWideStringField;
    qrySupplierState: TWideStringField;
    qrySupplierCountry: TWideStringField;
    qrySupplierPostcode: TWideStringField;
    qrySupplierBillStreet: TWideStringField;
    qrySupplierBillStreet2: TWideStringField;
    qrySupplierBillSuburb: TWideStringField;
    qrySupplierBillState: TWideStringField;
    qrySupplierBillCountry: TWideStringField;
    qrySupplierBillPostcode: TWideStringField;
    qrySupplierPOBox: TWideStringField;
    qrySupplierPOSuburb: TWideStringField;
    qrySupplierPOState: TWideStringField;
    qrySupplierPOCountry: TWideStringField;
    qrySupplierPOPostcode: TWideStringField;
    qrySupplierCUSTFLD1: TWideStringField;
    qrySupplierCUSTFLD2: TWideStringField;
    qrySupplierCUSTFLD3: TWideStringField;
    qrySupplierCUSTFLD4: TWideStringField;
    qrySupplierCUSTFLD5: TWideStringField;
    qrySupplierCUSTFLD6: TWideStringField;
    qrySupplierCUSTFLD7: TWideStringField;
    qrySupplierCUSTFLD8: TWideStringField;
    qrySupplierCUSTFLD9: TWideStringField;
    qrySupplierCUSTFLD10: TWideStringField;
    qrySupplierCUSTFLD11: TWideStringField;
    qrySupplierCUSTFLD12: TWideStringField;
    qrySupplierCUSTFLD13: TWideStringField;
    qrySupplierCUSTFLD14: TWideStringField;
    qrySupplierCUSTFLD15: TWideStringField;
    qrySupplierCreationDate: TDateField;
    btnAddDateTime: TDNMSpeedButton;
    qryDocPath: TERPQuery;
    qryCustomFields: TERPQuery;
    subfrmSupRefdocsQry: TERPQuery;
    qryForeignCurrency: TERPQuery;
    cboShippingQry: TERPQuery;
    qryPayMethod: TERPQuery;
    cboTermsQry: TERPQuery;
    SuburbQry: TERPQuery;
    qryBankCodes: TERPQuery;
    qryEmpID: TERPQuery;
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
    tbOtherFollowUpGlobalRef: TWideStringField;
    tbOtherFollowUpUpdateDate: TDateField;
    tbOtherFollowUpIsCustomer: TWideStringField;
    btnPO: TDNMSpeedButton;
    qrySupplierCUSTDATE1: TDateField;
    qrySupplierCUSTDATE2: TDateField;
    qrySupplierCUSTDATE3: TDateField;
    Label5: TLabel;
    wwDBLookupCombo1: TwwDBLookupCombo;
    qrySupplierDefaultPurchaseOrderTemplateID: TIntegerField;
    qryTemplates: TERPQuery;
    qryTemplatesTemplID: TIntegerField;
    qryTemplatesTemplName: TWideStringField;
    chkActive: TwwCheckBox;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    tbOtherFollowUpLeadLineID: TIntegerField;
    qrySupplierStreet3: TWideStringField;
    qrySupplierBillStreet3: TWideStringField;
    chkIntrastat: TwwCheckBox;
    lblIntrastat: TLabel;
    qrySupplierIncludeOnIntrastat: TWideStringField;
    Label22: TLabel;
    Label23: TLabel;
    chkShowInShipContainers: TwwCheckBox;
    qrySupplierShowInShipContainers: TWideStringField;
    qrySupplierGlobalref: TWideStringField;
    qrySupplierBPAYBillerCode: TWideStringField;
    qrySupplierBPAYReference: TWideStringField;
    Bevel1: TBevel;
    edtBPAYBiller: TDBEdit;
    edtBPAYReference: TDBEdit;
    Label24: TLabel;
    Label26: TLabel;
    Label28: TLabel;
    grdContact: TwwDBGrid;
    wwIButton1: TwwIButton;
    qryEquip: TERPQuery;
    qryEquipDescription: TWideStringField;
    qryEquipNotes: TWideMemoField;
    qryEquipid: TAutoIncField;
    qryEquipEquipmentID: TIntegerField;
    qryEquipClientID: TIntegerField;
    qryEquipGlobalRef: TWideStringField;
    qryEquipManufacture: TWideStringField;
    qryEquipModel: TWideStringField;
    qryEquipSerialno: TWideStringField;
    qryEquipRegistration: TWideStringField;
    qryEquipWarantyPeriod: TFloatField;
    qryEquipWarantyFinishDate: TDateTimeField;
    qryEquipEquipName: TWideStringField;
    qryEquipUOM: TWideStringField;
    qryEquipUOMID: TLargeintField;
    qryEquipUOMMultiplier: TFloatField;
    qryEquipUOMQty: TFloatField;
    qryEquipQuantity: TFloatField;
    qryEquipWarantyStartDate: TDateTimeField;
    DSCustomerEquipment: TDataSource;
    qrySupplierLastUpdated: TDateTimeField;
    CustEquipDNMPanel: TDNMPanel;
    edtBankAccNo: TwwDBEdit;
    qrySupplierCallPriority: TIntegerField;
    qrySupplierDefaultContactMethod: TWideStringfield;
    Box71: TBevel;
    Label6: TLabel;
    wwDBComboBox1: TwwDBComboBox;
    Bevel13: TBevel;
    Label11: TLabel;
    cboDefaultContactMethod: TwwDBComboBox;
    btnOtherPhones: TDNMSpeedButton;
    qrySupplierskypename: TWideStringField;
    Label29: TLabel;
    edtSkypeName: TDBEdit;
    Label30: TLabel;
    memoSalesComments: TDBMemo;
    wwCheckBox1: TwwCheckBox;
    Bevel16: TBevel;
    qrySupplierPOCommentPopup: TWideStringField;
    qrySupplierPOComment: TWideMemoField;
    qrySupplierClientTypeID: TIntegerField;
    qryContactsGlobalRef: TWideStringField;
    qryContactsContactID: TIntegerField;
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
    qryContactsContactName: TWideStringField;
    pgCustomFields: TPageControl;
    tabCustomFields: TTabSheet;
    pnlcustomfieldList: TDNMPanel;
    DNMPanel4: TDNMPanel;
    TabSheet1: TTabSheet;
    pnlCustFields: TDNMPanel;
    Box181: TBevel;
    Bevel14: TBevel;
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
    Label34: TLabel;
    CUSTLBL16: TLabel;
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
    qrySupplierSupplierCreditLimit: TFloatField;
    CreditLimit: TwwDBEdit;
    Label36: TLabel;
    qryContactsClientID: TIntegerField;
    qryContactsClientName: TWideStringField;
    tbOtherFollowUpNotes: TWideMemoField;
    tabAttachments: TTabSheet;
    tabFollowUps: TTabSheet;
    pnlAttach: TDNMPanel;
    Label3: TLabel;
    pnlAttachments: TPanel;
    pnlFollowUps: TDNMPanel;
    Label35: TLabel;
    grdFollowUp: TwwDBGrid;
    wwIButton2: TwwIButton;
    cboEmployee: TwwDBLookupCombo;
    dtpDatePicker: TwwDBDateTimePicker;
    pnlDocuments: TDNMPanel;
    Label66: TLabel;
    pnlDocumentsInner: TDNMPanel;
    Splitter1: TSplitter;
    pnlDocumentsList: TDNMPanel;
    Label96: TLabel;
    Label37: TLabel;
    grdCorrespondence: TwwDBGrid;
    grdDocsIButton: TwwIButton;
    btnGetEmails: TButton;
    chkdocuments: TCheckBox;
    pnlDocumentsMessage: TDNMPanel;
    HtmlViewer: THtmlViewer;
    lvAttachments: TListView;
    qryDocumentsRefID: TIntegerField;
    qryDocumentsRef_Date: TDateTimeField;
    qryDocumentsRef_type: TWideStringField;
    qryDocumentsReferencetxt: TWideStringField;
    qryDocumentsCusID: TIntegerField;
    qryDocumentsContactID: TIntegerField;
    qryDocumentsContact: TWideStringField;
    qryDocumentsActive: TWideStringField;
    qryDocumentsMessageId: TWideStringField;
    qryDocumentsReferenceData: TBlobField;
    qryDocumentsMessageFrom: TWideStringField;
    qryDocumentsMessageTo: TWideStringField;
    Bevel3: TBevel;
    qrySupplierArea: TWideStringField;
    QryAreaCodes: TERPQuery;
    QryAreaCodesAreaCode: TWideStringField;
    QryAreaCodesAreaName: TWideStringField;
    lblArea: TLabel;
    cboAreaCode: TwwDBLookupCombo;
    QrySupplierskills: TERPQuery;
    QrySupplierskillsglobalref: TWideStringField;
    QrySupplierskillsID: TIntegerField;
    QrySupplierskillsProviderID: TIntegerField;
    QrySupplierskillsskillid: TIntegerField;
    QrySupplierskillsActive: TWideStringField;
    QrySupplierskillsmsTimeStamp: TDateTimeField;
    QrySupplierskillsSkillname: TWideStringField;
    dsSkillProviderskills: TDataSource;
    Label40: TLabel;
    qryskills: TERPQuery;
    qryskillsSkill: TWideStringField;
    qryskillsSkillID: TIntegerField;
    cboskills: TwwDBLookupCombo;
    grdSkills: TwwDBGrid;
    wwIButton3: TwwIButton;
    memQrySupplierskills: TkbmMemTable;
    qrySupplierSendXMLPOs: TWideStringField;
    qrySupplierEmailPOXML: TWideStringField;
    QryAPAccounts: TERPQuery;
    lblAccount: TLabel;
    cboDefaultAPAccountName: TwwDBLookupCombo;
    Bevel17: TBevel;
    qrySupplierDefaultAPAccountID: TIntegerField;
    qrySupplierDefaultAPAccountName: TWideStringField;
    QryAPAccountsAccountID: TIntegerField;
    QryAPAccountsAccountName: TWideStringField;
    btnAddfollowupnotedate: TDNMSpeedButton;
    Label44: TLabel;
    edtBankLodgementRef: TwwDBEdit;
    qrySupplierBankLodgementRef: TWideStringField;
    qrySupplierSendFTPXMLPOs: TWideStringField;
    qrySupplierFTPAddress: TWideStringField;
    qrySupplierFTPUserName: TWideStringField;
    qrySupplierFTPPassword: TWideStringField;
    pnlDocsBottom: TDNMPanel;
    lblDocumentPath: TDBText;
    btnOpenDocumentPath: TDNMSpeedButton;
    btnSetDocumentPath: TDNMSpeedButton;
    qrySupplierDocumentPath: TWideStringField;
    qrySuppliercDocumentPath: TStringField;
    qrySupplierclientCode: TWideStringField;
    Label43: TLabel;
    DBEdit19: TDBEdit;
    qrySupplierIgnoreSupplierforProductLatestCost: TWideStringField;
    Bevel19: TBevel;
    chkIgnoreSupplierforProductLatestCost: TDBCheckBox;
    qrySupplierPrintName: TWideStringField;
    lblClientPrintNameHeading: TLabel;
    edtPrintName: TDBEdit;
    lblContractor: TLabel;
    wwCheckBox2: TwwCheckBox;
    qrySupplierContractor: TWideStringField;
    pcAddress: TPageControl;
    tsSupplierAddress: TTabSheet;
    tsEDI: TTabSheet;
    DNMPanel8: TDNMPanel;
    pnlAddress: TDNMPanel;
    DNMPanel5: TDNMPanel;
    Bevel12: TBevel;
    Label2: TLabel;
    Label39: TLabel;
    Label180: TLabel;
    Label20: TLabel;
    lblSuburb: TLabel;
    lblState: TLabel;
    lblPostCode: TLabel;
    Label14: TLabel;
    Street: TDBEdit;
    Street2: TDBEdit;
    Street3: TDBEdit;
    Suburb: TwwDBLookupCombo;
    State: TDBEdit;
    Postcode: TDBEdit;
    Country: TDBEdit;
    cmdCopy: TDNMSpeedButton;
    DNMPanel7: TDNMPanel;
    Bevel15: TBevel;
    Label38: TLabel;
    Label42: TLabel;
    Label187: TLabel;
    Label21: TLabel;
    lblBillSuburb: TLabel;
    lblBillState: TLabel;
    lblBillPostcode: TLabel;
    Label15: TLabel;
    txtBillAddress: TDBEdit;
    txtBillAddress2: TDBEdit;
    txtBillAddress3: TDBEdit;
    BillSuburb: TwwDBLookupCombo;
    BillState: TDBEdit;
    BillPostcode: TDBEdit;
    txtBillCountry: TDBEdit;
    dsCoreEDIConfig: TDataSource;
    qryCoreEDIConfig: TERPQuery;
    qrySupplierAddressValid: TWideStringField;
    qrySupplierBillAddressValid: TWideStringField;
    qrySupplierUpdateDate: TDateField;
    qrySupplierDateInactive: TDateField;
    qrySupplierTaxname: TWideStringField;
    qrySupplierARBalance: TFloatField;
    qrySupplierAPBalance: TFloatField;
    qrySupplierSOBalance: TFloatField;
    qrySupplierPrintJobName: TWideStringField;
    qrySupplierJobRegistration: TWideStringField;
    qrySupplierWarrantyFinishDate: TDateTimeField;
    qrySupplierHoursTakenForJob: TFloatField;
    qrySupplierIsInternal: TWideStringField;
    qrySupplierAction: TDateTimeField;
    qrySupplierDateEntered: TDateField;
    qrySupplierDontContact: TWideStringField;
    qrySupplierCompletionDate: TDateField;
    qrySupplierParentClientID: TIntegerField;
    qrySupplierGracePeriod: TWordField;
    qrySupplierLastContactDate: TDateField;
    qrySupplierLoyaltyValue: TFloatField;
    qrySupplierLastSaleDate: TDateField;
    qrySupplierAccountNo: TWideStringField;
    qrySupplierCombinedInvoiceBOID: TWideStringField;
    qrySupplierCombinedPurchaseBOID: TWideStringField;
    qrySupplierCombinedSaleOrderBOID: TWideStringField;
    qrySupplierStopCredit: TWideStringField;
    qrySupplierSecurityLevel: TIntegerField;
    qrySupplierForcePOOnBooking: TWideStringField;
    qrySupplierForcePOOnInvoice: TWideStringField;
    qrySupplierForcePOOnSalesOrder: TWideStringField;
    qrySupplierForcePOOnCustomer: TWideStringField;
    qrySupplierPickingPriority: TIntegerField;
    qrySupplierJobNumber: TIntegerField;
    qrySupplierDefaultInvoiceTemplateID: TIntegerField;
    qrySupplierDefaultSalesOrderTemplateID: TIntegerField;
    qrySupplierDefaultDeliveryTemplateID: TIntegerField;
    qrySupplierLoyaltyDateSaleDays: TDateField;
    qrySupplierLoyaltyDateAmount: TDateField;
    qrySupplierLoyaltyDateAppointDays: TDateField;
    qrySupplierGroupDiscountOverridesAll: TWideStringField;
    qrySupplierCardNumber: TWideStringField;
    qrySupplierDefaultClass: TWideStringField;
    qrySupplierDischargeDate: TDateField;
    qrySupplierJobTitle: TWideStringField;
    qrySupplierUseInvBase: TWideStringField;
    qrySupplierInvBaseNumber: TIntegerField;
    qrySupplierApprovalFromDate: TDateTimeField;
    qrySupplierApprovalToDate: TDateTimeField;
    qrySupplierTasks: TWideMemoField;
    qrySupplierReminderDateTime: TDateTimeField;
    qrySupplierSpecialInstructions: TWideMemoField;
    qrySupplierSerialNumber: TWideStringField;
    qrySupplierModelNumber: TWideStringField;
    qrySupplierManufacture: TWideStringField;
    qrySupplierParentRelatedClientID: TIntegerField;
    qrySupplierDeliveryNotes: TWideMemoField;
    qrySupplierCreditCardNumber: TWideStringField;
    qrySupplierCreditCardExpiryDate: TWideStringField;
    qrySupplierCreditCardCardHolderName: TWideStringField;
    qrySupplierCreditCardNotes: TWideStringField;
    qrySupplierCreditCardCVC: TWideStringField;
    qrySupplierCompanyTypeId: TIntegerField;
    qrySupplierCreditCardType: TWideStringField;
    qrySupplierWarrantyPeriod: TFloatField;
    qrySupplierCustomerJobNumber: TWideStringField;
    qrySupplierhours: TFloatField;
    qrySupplierEmailXML: TWideStringField;
    qrySupplierInvoiceComment: TWideMemoField;
    qrySupplierrepairComment: TWideMemoField;
    qrySupplierInvoiceCommentPopup: TWideStringField;
    qrySupplierRepairCommentPopUp: TWideStringField;
    qrySupplierSendXMLInvoices: TWideStringField;
    qrySupplierSendFTPXMLInvoices: TWideStringField;
    qrySupplierForcePOOnRepair: TWideStringField;
    qrySupplierManufactureID: TIntegerField;
    qrySupplierSpecialProductPriceOverridesAll: TWideStringField;
    qrySupplierPortOfLanding: TWideStringField;
    qrySupplierPortOfDischarge: TWideStringField;
    qrySupplierFinalDestination: TWideStringField;
    qrySupplierIncoPlace: TWideStringField;
    qrySupplierShippingAgentID: TIntegerField;
    qrySupplierDefaultStatementTemplateId: TIntegerField;
    qrySupplierTeamviewerID: TWideStringField;
    qrySupplierInsuranceCompanyName: TWideStringField;
    qrySupplierClaimNumber: TWideStringField;
    qrySupplierStormLocation: TWideStringField;
    qrySupplierStormDate: TDateField;
    qrySupplierYear: TDateField;
    qrySupplierColour: TWideStringField;
    qrySupplierBodyType: TWideStringField;
    qrySupplierAssessorsName: TWideStringField;
    qrySupplierExcessAmount: TFloatField;
    qrySupplierBailmentNumber: TWideStringField;
    qrySupplierBailmentAmountEx: TFloatField;
    qrySupplierStockReceivedDate: TDateField;
    qrySupplierNewOrUsed: TWideStringField;
    qrySuppliermsUpdateSiteCode: TWideStringField;
    qrySupplierDefaultARAccountID: TIntegerField;
    qrySupplierDefaultARAccountName: TWideStringField;
    qrySupplierExpiryDate: TDateField;
    qrySupplierExternalRef: TWideStringField;
    qrySupplierClientPaysShippment: TWideStringField;
    qrySupplierClientShipperAccountNo: TWideStringField;
    DNMPanel2: TDNMPanel;
    DBCheckBox3: TDBCheckBox;
    Label50: TLabel;
    edtEDIVendorCode: TEdit;
    Label25: TLabel;
    edtPOSendUser: TEdit;
    Label45: TLabel;
    edtPOSendPass: TEdit;
    Label49: TLabel;
    edtPOSendServer: TEdit;
    Label51: TLabel;
    edtPOSendDir: TEdit;
    lblPOReceiveDir: TLabel;
    lblPOFTPPort: TLabel;
    edtPOReceiveDir: TEdit;
    edtPOReceiveArchiveDir: TEdit;
    lblPOReceiveArchiveDir: TLabel;
    edtPOFTPPort: TEdit;
    DNMPanel9: TDNMPanel;
    DNMPanel10: TDNMPanel;
    DBCheckBox1: TDBCheckBox;
    Label32: TLabel;
    Label41: TLabel;
    Label16: TLabel;
    edtURL: TDBEdit;
    XMLEmail: TDBEdit;
    Email: TDBEdit;
    DNMPanel11: TDNMPanel;
    DBCheckBox2: TDBCheckBox;
    Label47: TLabel;
    FTPUserName: TDBEdit;
    Label48: TLabel;
    Label46: TLabel;
    FTPAddress: TDBEdit;
    FTPPassword: TDBEdit;
    edtLocalReceiveDir: TEdit;
    Label53: TLabel;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure cmdOkClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cboTermsEnter(Sender: TObject);
    procedure cboShippingEnter(Sender: TObject);
    procedure cmdNotesClick(Sender: TObject);
    procedure BillSuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cmdCustomLabelsOldClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure LetterbtnClick(Sender: TObject);
    procedure FaxbtnClick(Sender: TObject);
    procedure EmailbtnClick(Sender: TObject);
    procedure EditbtnClick(Sender: TObject);
    procedure CNewbtnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure grdContactRowChanged(Sender: TObject);
    procedure chkShowAllClick(Sender: TObject);
    procedure grpHistoryClick(Sender: TObject);
    procedure TabCtl20Change(Sender: TObject);
    procedure cmdCopyClick(Sender: TObject);
    procedure EmployeeIDEnter(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure grdDocsDblClick(Sender: TObject);
    procedure btnInactiveFollowUpClick(Sender: TObject);
    procedure SuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure SuburbEnter(Sender: TObject);
    procedure btnInactiveClick(Sender: TObject);
    procedure cmdShippingClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure grdFollowUpColExit(Sender: TObject);
    procedure grdFollowUpColEnter(Sender: TObject);
    procedure qrySupplierAfterOpen(DataSet: TDataSet);
    procedure qryContactsAfterOpen(DataSet: TDataSet);
    procedure tbOtherFollowUpAfterOpen(DataSet: TDataSet);
    procedure qrySupplierFirstNameChange(Sender: TField);
    procedure qrySupplierLastNameChange(Sender: TField);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure grdContactFieldChanged(Sender: TObject; Field: TField);
    procedure grdDocsFieldChanged(Sender: TObject; Field: TField);
    procedure grdFollowUpFieldChanged(Sender: TObject; Field: TField);
    procedure qrySupplierRepIDChange(Sender: TField);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure btnAddDateTimeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnPOClick(Sender: TObject);
    procedure TabCtl20Resize(Sender: TObject);
    procedure edtURLDblClick(Sender: TObject);
    procedure cboBankCodeEnter(Sender: TObject);
    procedure TabCtl20Changing(Sender: TObject; var AllowChange: boolean);
    procedure qrySupplierAfterPost(DataSet: TDataSet);
    procedure btnOtherPhonesClick(Sender: TObject);
    procedure grdContactKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtBankAccNoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SuburbQryBeforeOpen(DataSet: TDataSet);
    procedure chkActiveClick(Sender: TObject);
    procedure grdFollowUpDblClick(Sender: TObject);
    procedure tbOtherFollowUpAfterScroll(DataSet: TDataSet);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure qrySupplierCompanySetText(Sender: TField;
      const Text: String);
    procedure TermsCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure qrySupplierAfterInsert(DataSet: TDataSet);
    procedure tbOtherFollowUpAfterInsert(DataSet: TDataSet);
    procedure AccountNoKeyPress(Sender: TObject; var Key: Char);
    procedure grdCorrespondenceDblClick(Sender: TObject);
    procedure grdCorrespondenceFieldChanged(Sender: TObject; Field: TField);
    procedure grdDocsIButtonClick(Sender: TObject);
    procedure chkdocumentsClick(Sender: TObject);
    procedure grdCorrespondenceRowChanged(Sender: TObject);
    procedure btnGetEmailsClick(Sender: TObject);
    procedure lvAttachmentsDblClick(Sender: TObject);
    procedure HtmlViewerImageRequest(Sender: TObject; const SRC: string;
      var Stream: TStream);
    procedure HtmlViewerHotSpotClick(Sender: TObject; const SRC: string;
      var Handled: Boolean);
    procedure qryBankCodesBeforeOpen(DataSet: TDataSet);
    procedure wwIButton3Click(Sender: TObject);
    procedure QrySupplierskillsAfterOpen(DataSet: TDataSet);
    procedure QrySupplierskillsAfterInsert(DataSet: TDataSet);
    procedure cboskillsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure cboRepChange(Sender: TObject);
    procedure cboDefaultAPAccountNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure btnAddfollowupnotedateClick(Sender: TObject);
    procedure btnOpenDocumentPathClick(Sender: TObject);
    procedure btnSetDocumentPathClick(Sender: TObject);
    procedure QrySupplierCalcFields(DataSet: TDataSet);
    procedure edtPrintNameExit(Sender: TObject);
    procedure edtPrintNameChange(Sender: TObject);
    procedure DBCheckBox1Click(Sender: TObject);
    procedure DBCheckBox2Click(Sender: TObject);
    procedure edtPOSendUserChange(Sender: TObject);
    procedure edtPOSendPassChange(Sender: TObject);
    procedure edtPOSendServerChange(Sender: TObject);
    procedure pcAddressChange(Sender: TObject);
    procedure edtEDIVendorCodeChange(Sender: TObject);
    procedure edtPOSendDirChange(Sender: TObject);
    procedure edtPOReceiveDirChange(Sender: TObject);
    procedure edtPOReceiveArchiveDirChange(Sender: TObject);
    procedure edtPOFTPPortChange(Sender: TObject);
    procedure edtLocalReceiveDirChange(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    //    procedure fixDates(qry: TERPQuery);

  private
    { Private declarations }
    bNewSupp: boolean;
    fsNewCompanyName: string;

    fSupplierStatement: TBaseListingGUI;
    fPurchaseOrderList: TBaseListingGUI;
    fBillList: TBaseListingGUI;
    fChequeList: TBaseListingGUI;
    fSuppPaymentList: TBaseListingGUI;

    //SupplierStatementManRunOnce: boolean;
    //PurchaseOrderListManRunOnce: boolean;
    //BillListManRunOnce: boolean;
    //ChequeListManRunOnce: boolean;
    //SuppPaymentListManRunOnce: boolean;
    fbSaveClicked: boolean;
    fbIsModified: boolean;
    fbFocusOnForeignCurrency: boolean;
    fbEmailchanged:Boolean;
    Equipmentform:TfmClientEquipment;
    HistoryListform: TBaseListingGUI;
    AttachmentForm: TfmAttachments;
    SelectedMail: TIdMessage;
    HTMLImageStream: TMemoryStream;
    FileAssociationDetails: TFileAssociationDetails;
    MailProgesss: TProgressDialog;
    ProgressCanceled: boolean;
    fbaddingskill :Boolean;
    fiSkillIdtoLocate :Integer;
    fsSupplierNameToCreate:String;
    fbUpdatingcompanyonName :Boolean;
    fbclientnameMadeFromName:Boolean;
    TabCtl20CurTab:TTabSheet;
    function IsFollowUpOK: boolean;
    procedure PreSaveSupplier;
    procedure GlobalEventHandler(const Sender: TObject; const Event: string; const Data: Pointer);
    Procedure Callcontactform(Sender:TDNMSpeedbutton);
    procedure SetComboFocus(var Msg: TMessage); message TX_SetFocus;
    procedure AssignComboAccessed(Sender: TObject);
    Procedure UpdatefromEquipment;
    function ChkCustReqdFields: boolean;
    function NewCompanyNameOk(const aCompanyName: string): boolean;

    Function SupplierStatement: TBaseListingGUI;
    Function PurchaseOrderList: TBaseListingGUI;
    Function BillList: TBaseListingGUI;
    Function ChequeList: TBaseListingGUI;
    Function SupplierPaymentList: TBaseListingGUI;
    function SAvesupplier:boolean;
    function MakeNewcontactifnone: Boolean;
    function MakeSuppliercontact: boolean;
    procedure LoadMemTable;
    procedure DoOnAfterListPopupFormShow(ListForm: TBaseListingGUI; PopupForm: TBaseInputGUI);
    function isCompanyNameOk(const aCompanyName: string;fKeyID: Integer): boolean;
    procedure CheckForEmails;
    procedure DoOnCheckForEmailsProgress(const msg: string; var Continue: boolean);
    procedure DoOnGetMessageCount(const MessageCount: integer);
    procedure DoOnProgressCancel(Sender: TObject);
    procedure Makecompany;
    procedure LoadCoreEDIConfig;
  protected
    Supplier: TSupplier;
    //    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure KeyIdChanged(const NewKeyId: integer); override;
    procedure CompleteComboNotInList(const aObserver: TObject); override;
    procedure CustomFieldsRefresh;Override;
    function GetKeyString: string; override;
    procedure SetKeyString(const Value: string); override;
    function SaveOrCancelChanges: boolean;override;
    procedure SetStateParams(const Value: TJsonObject); override;
    Function ClientId :Integer; Override;
  public
    { Public declarations }
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string); override;
    class procedure CloseMe; override;
    procedure UpdateMe(const Cancelled: boolean; const aObject: TObject = nil); override;
    {ML - This property is used to open the Supplier form with company name already specified.
    You can't append the details to the text box due to the fact it's data aware}
    property NewCompanyName: string read fsNewCompanyName write fsNewCompanyName;
    property FocusOnForeignCurrency: boolean read fbFocusOnForeignCurrency write fbFocusOnForeignCurrency;
    Procedure AfterPopupformshow;Override;
    Function CustomFieldExtenderListtype:TListType; Override;
    Property addingskill :Boolean read fbaddingskill write fbaddingskill;
    Property SkillIdtoLocate :Integer read fiSkillIdtoLocate write fiSkillIdtoLocate;
    Property SupplierNameToCreate :String read fsSupplierNameToCreate write fsSupplierNameToCreate;
    function ShiptoAddress:String;
  end;

//var
//  frmSupplier: TfmSupplier;

implementation

uses FastFuncs,CommonDbLib, frmCustomFieldsFrm, FormFactory, DnMLib, AuditObj,
  (*frmClientReferenceFrm, *)remainClientFrm,  frmFollowUp,
  DNMExceptions, AppContextObj, GlobalEventsObj,

  PurchaseOrderListForm, ShipAddressListForm,
  frmPurchaseOrders, ShellAPI,
  Commonlib, frmClientsOtherPhonesGUI,  MaskUtils,
   AppEnvironment, tcDataUtils,tcTypes , CommonFormLib,
  FormReopenerObj, tcConst, MailReaderObj, BusObjEmailConfig, HTTPUtil,
  ContentTypeObj, IdText, IdAttachmentFile, IdAttachmentMemory, IdHTTP,
  SystemLib, IdAttachment, EmailConst,
  frmSupplierCorrespondenceCreate, {$WARNINGS OFF}FileCtrl{$WARNINGS ON}, docPathLib,
  HTTPConst, UserCustomisedNames, MessageConst, DialogUtils, EmployeeAccesses,
  BusObjConst, BusObjCoreEDIConfig, utFTPLib;

{$R *.DFM}

procedure TfmSupplier.cmdOkClick(Sender: TObject);
begin
  DisableForm;
  try
      if SaveSupplier then begin
        CommitTransaction;
        Notify;
        fbSaveClicked := true;
        Notify(false);
        if fsModal in FormState then modalresult := mrok else Close;
      end;
  finally
    EnableForm;
  end;
end;

procedure TfmSupplier.cmdCancelClick(Sender: TObject);
begin
  DisableForm;
  try
    if fsModal in FormState then modalresult := mrCancel else Close;
  finally
    EnableForm;
  end;
end;

procedure TfmSupplier.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      if qrySupplier.Active then begin
        if not (qrySupplier.State in [dsBrowse]) then begin
          qrySupplier.Post;
          Notify;
        end;
        CloseQueries;
      end;

      BeginTransaction;
      fbSaveClicked := false;
      fbIsModified  := false;

      (*qrySupplier.ParamByName('KeyID').asInteger := 0;
      qrySupplier.ParamByName('KeyID').asInteger := KeyID;*)
      qryContacts.ParamByName('SupID').asInteger := KeyID;
      tbOtherFollowUp.ParamByName('xClientID').asInteger := KeyID;
      QrySupplierskills.ParamByName('xClientID').asInteger := KeyID;

      if not chkShowAll.Checked then begin
        qryContacts.filtered := false;
        qryContacts.filter := 'Active = ''T''';
        qryContacts.filtered := true;
      end;

      qryDocuments.ParamByName('SupID').asInteger := KeyID;
      //qrySupplier.Open;
      Supplier.Load(KeyID);
      qryContacts.Open;
      tbOtherFollowUp.Open;
      QrySupplierskills.Open;
      qryDocuments.Open;
      qryDocPath.Open;
      qryPayMethod.Open;
      qryForeignCurrency.Open;
      qryTemplates.Open;
      cboTermsQry.Open;
      opendb(QryareaCodes);
      opendb(qryskills);
      opendb(QryAPAccounts);

      if qrySupplierCustomer.AsBoolean then begin
        Label4.Font.Color := clSilver;
      end;

      cmdOK.Enabled    := IsOkToSave;
      cmdNew.Enabled   := IsOkToSave;
      Button1.Enabled  := (not qrySupplierCustomer.AsBoolean) and IsOkToSave;
      cmdCopy.Enabled  := IsOkToSave;
      edtNotes.Enabled := IsOkToSave;

      if KeyID = 0 then begin
        bNewSupp := true;
        btnPO.Enabled := false;
        qrySupplier.Insert;
        if fsNewCompanyName <> '' then qrySupplier.FieldByName('Company').AsString := fsNewCompanyName;
        qrySupplier.FieldByName('Supplier').AsString := 'T';
        qrySupplier.FieldByName('PayMethodID').AsInteger := AppEnv.CompanyPrefs.DefaultPayMethodID;
        qrySupplier.FieldByName('CreationDate').AsDateTime := Now;
        chkActive.Checked := true;
        Self.txtCompany.ReadOnly := false;
        if SupplierNameToCreate <> '' then qrySupplierCompany.AsString :=SupplierNameToCreate;
        qrySupplierTermsID.AsInteger := AppEnv.CompanyPrefs.DebitTermsID;

      end else begin
        //      self.fixDates(qrySupplier);
        btnPO.Enabled := true;
        txtCompany.ReadOnly := true;
        if EditNoAbort(qrySupplier) then begin
          qrySupplierEditedFlag.AsString := 'T';
        end;
      end;

      chkActive.Enabled := (AccessLevel = 1);

      if qrySupplierRequired.AsBoolean then begin
        chkActive.Enabled := false;
        Label141.Enabled := false;
      end;

      CustomFieldsRefresh;
      grdContactRowChanged(Sender);
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;
  finally

    EnableForm;
    TabCtl20.ActivePageIndex:= 0;
    pcAddress.ActivePageIndex := 0;
    Setcontrolfocus(edtPrintName);
    if (KeyID<>0) and (addingskill) then begin
        TabCtl20.ActivePage := tabFollowUps;
        SetControlFocus(grdSkills);
    end else if (KeyID<>0) and (SkillIdtoLocate <> 0) then begin
        TabCtl20.ActivePage := tabFollowUps;
        SetControlFocus(grdSkills);
    end else if fbFocusOnForeignCurrency = false then begin
      TabCtl20.ActivePage := TTabSheet(Supplier_Info);
      SetControlFocus(edtPrintName);
    end else begin
      TabCtl20.ActivePage := TTabSheet(General);
      SetControlFocus(cboForeignCurrencyCode);
    end;
  end;
end;

procedure TfmSupplier.PreSaveSupplier;
begin
  try
    if not Empty(txtCompany.Text) then begin
      postdb(qrySupplier);
      bNewSupp := false;
      KeyID := qrySupplierClientID.AsInteger;
      FormShow(nil);
      TabCtl20.ActivePage := TTabSheet(Supplier_Info);
      qrySupplier.Edit;
    end;
  except
  end;
end;

procedure TfmSupplier.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ShowWindow(Handle, SW_HIDE);
  Self.Enabled := false;
  CloseQueries;
  Action := caFree;
  inherited;
end;

class procedure TfmSupplier.CloseMe;
begin
  if FormStillOpen('TfmSupplier') then begin
      TfmSupplier(FindExistingComponent('TfmSupplier')).Close;
    Application.ProcessMessages;
  end;
end;

procedure TfmSupplier.cboTermsEnter(Sender: TObject);
begin
  inherited;
  if not (cboTermsQry.Active) then begin
    cboTermsQry.Active := true;
  end;
end;

procedure TfmSupplier.cboShippingEnter(Sender: TObject);
begin
  inherited;
  if not (cboShippingQry.Active) then begin
    cboShippingQry.Active := true;
  end;
end;


procedure TfmSupplier.cboskillsCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  QrySupplierskillsskillID.AsInteger := qryskillsSkillID.AsInteger;
  QrySupplierskillsSkillname.asString  := qryskillsSkill.AsString;
end;

procedure TfmSupplier.cmdNotesClick(Sender: TObject);
begin
  inherited;
  TabCtl20.ActivePage := TTabSheet(Supplier_Info);
  SetControlFocus(edtNotes);
end;

procedure TfmSupplier.BillSuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if Modified then begin
    FillTable.FieldByName('BillState').AsString    := LookupTable.FieldByName('State').AsString;
    FillTable.FieldByName('BillPostcode').AsString := LookupTable.FieldByName('Postcode').AsString;
    FillTable.FieldByName('BillCountry').asString  := LookupTable.FieldByName('Country').asString;
  end;
end;

function TfmSupplier.CustomFieldExtenderListtype: TListType;
begin
  Result := ltSupplier;
end;

procedure TfmSupplier.CustomFieldsRefresh;
begin
  CustomFieldRefresh('CFSupp' ,pnlCustFields);
end;
procedure TfmSupplier.DBCheckBox1Click(Sender: TObject);
begin
  inherited;
  if not TDBCheckBox(Sender).Focused then exit;
  if TDbCheckBox(Sender).Checked then begin
    if not AppEnv.UtilsClient.LicenceOptionEnabled('SupplierEmailXML') then begin
      TDbCheckBox(Sender).Checked := false;
      DialogLicenceOptionNotEnabled;
    end;
  end;
end;

procedure TfmSupplier.DBCheckBox2Click(Sender: TObject);
begin
  inherited;
  if not TDBCheckBox(Sender).Focused then exit;
  if TDbCheckBox(Sender).Checked then begin
    if devmode then else if not AppEnv.UtilsClient.LicenceOptionEnabled('SupplierFTPXML') then begin
      TDbCheckBox(Sender).Checked := false;
      DialogLicenceOptionNotEnabled;
    end;
  end;
end;

procedure TfmSupplier.DNMSpeedButton1Click(Sender: TObject);
var
  errmsg:String;
  FTP_Config: TJsonObject;
begin
  FTP_Config := JO;
  try
    FTP_Config.FormatOutput := false;
    FTP_Config.O['Params'].O['Config'].Assign(Supplier.CoreEDIConfig.Config.O['PO']);
    if TestConnection(FTP_Config, errmsg) then
          MessageDlgxP_Vista('FTP Connection Credentials Valid' , mtWarning, [mbOK], 0)
    else  MessageDlgxP_Vista('Error Connecting  FTP' + NL+errmsg, mtInformation, [mbOK], 0 );
  finally
    FTP_Config.Free;
  end;
end;

procedure TfmSupplier.DoBusinessObjectEvent(const Sender: TDatasetBusObj;
  const EventType, Value: string);
begin
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TSupplier then
      TSupplier(Sender).Dataset:= qrySupplier
    else if Sender is TCoreEDIConfig then
      TCoreEDIConfig(Sender).Dataset:= qryCoreEDIConfig

  end
  else if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEventDataset_dataIdchange_dcLoad ) then begin

  end;

end;

procedure TfmSupplier.DoOnAfterListPopupFormShow(ListForm: TBaseListingGUI;
  PopupForm: TBaseInputGUI);
begin
  StateParams:= FormReopenerObj.FormReopenerList.Add(self.ClassName, PopupForm).Params;
  StateParams.I['KeyID']:= self.qrySupplierClientID.AsInteger;
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
  if Savesupplier then begin
    CommitTransaction;
    fbSaveClicked:= True;
    Close;
  end;
end;

procedure TfmSupplier.DoOnCheckForEmailsProgress(const msg: string;
  var Continue: boolean);
begin
  if Assigned(MailProgesss) then begin
    MailProgesss.Message := msg;
    MailProgesss.StepIt;
    Continue := not ProgressCanceled;
  end;
end;

procedure TfmSupplier.DoOnGetMessageCount(const MessageCount: integer);
begin
  MailProgesss.MaxValue := MessageCount;
end;

procedure TfmSupplier.DoOnProgressCancel(Sender: TObject);
begin
  ProgressCanceled := true;
end;

function TfmSupplier.ChkCustReqdFields: boolean;
begin
  Result := ChkReqdFields('Supp');
  if not Result then TabCtl20.ActivePage := Custom_Fields;
  if result then begin
    if Assigned(Equipmentform) and (Equipmentform.qryEquip.RecordCount > 0) then begin
      if not Equipmentform.CustomerEquipment.Save then begin
        result:= false;
//        focusinvalidcomp(tabEquip ,Equipmentform.grdEquipment, '');
      end;
    end;
  end;
end;

procedure TfmSupplier.cmdCustomLabelsOldClick(Sender: TObject);
begin
  OpenCustomFields;
end;

procedure TfmSupplier.FormActivate(Sender: TObject);
begin
  inherited;
  if not fbNoAccess then begin
    if self.qryContacts.Active then begin
      self.qryContacts.Close;
      self.qryContacts.Open;
    end;
  end;
end;

procedure TfmSupplier.LetterbtnClick(Sender: TObject);
begin
    if Accesslevel >= 5 then Exit;
    PostDB(qrySupplier);
    EditDB(qrySupplier);
    PostDB(qryContacts);
    EditDB(qryContacts);
   SuppContactCreateCorrespondence(ctLetter, self, qrySuppliercompany.AsString);
(*Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    if qrySupplier.State in [dsEdit,dsInsert] then begin
      qrySupplier.Post;
      qrySupplier.Edit;
    end;

    Form := GetComponentByClassName('TfrmClientReference');
    if Assigned(Form) then begin
      with TfrmClientReference(Form) do begin
        FormStyle := fsMDIChild;
        BringToFront;
        TitleLabel.Caption := 'Letter To Contact';
        EditedFlag.Checked := true;
        Ref_Type.Text := 'Letter';
        ClientID.Text := qrySupplierClientID.AsString;
        SupID.Text    := qrySupplierClientID.AsString;
        CID           := qryContacts.FieldByName('ContactID').AsInteger;
        Ref_Date.Text := DateToStr(Date);
        EmailNo.Text  := '';
        FaxNo.Text    := '';
        KeyID         := 0;
        Refresh;
      end;
    end;
  finally
    EnableForm;
  end;*)
end;

procedure TfmSupplier.FaxbtnClick(Sender: TObject);
begin
    if Accesslevel >= 5 then Exit;
    PostDB(qrySupplier);
    EditDB(qrySupplier);
    PostDB(qryContacts);
    EditDB(qryContacts);
   SuppContactCreateCorrespondence(ctfax, self, qrySuppliercompany.AsString);
(*Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    if qrySupplier.State in [dsEdit,dsInsert] then begin
      qrySupplier.Post;
      qrySupplier.Edit;
    end;

    Form := GetComponentByClassName('TfrmClientReference');
    if Assigned(Form) then begin
      with TfrmClientReference(Form) do begin
        FormStyle := fsMDIChild;
        BringToFront;
        TitleLabel.Caption := 'Fax To Contact';
        EditedFlag.Checked := true;
        Ref_Type.Text := 'Fax';
        ClientID.Text := qrySupplierClientID.AsString;
        SupID.Text := qrySupplierClientID.AsString;
        CID := qryContacts.FieldByName('ContactID').AsInteger;
        Ref_Date.Text := DateToStr(Date);
        EmailNo.Text := '';
        if txtFaxNumber.Text <> '' then FaxNo.Text := txtFaxNumber.Text
        else FaxNo.Text := 'Fax';
        Refresh;
      end;
    end;
  finally
    EnableForm;
  end; *)
end;

procedure TfmSupplier.EmailbtnClick(Sender: TObject);
begin
    if Accesslevel >= 5 then Exit;

    if self.qryContactsContactEmail.AsString = '' then begin
      if CommonLib.MessageDlgXP_Vista('The contact ' + self.qryContactsCompany.AsString +
        ' does not have an email address.' + #13 + #10 + 'Do you wish to load the email program anyway?',
        mtConfirmation, [mbYes, mbNo], 0)  = mrNo then Exit;
    end;

    PostDB(qrySupplier);
    EditDB(qrySupplier);
    PostDB(qryContacts);
    EditDB(qryContacts);
   SuppContactCreateCorrespondence(ctEmail, self, qrySuppliercompany.AsString);
(*Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    if self.qryContactsContactEmail.AsString = '' then begin
      if CommonLib.MessageDlgXP_Vista('The contact ' + self.qryContactsCompany.AsString +
        ' does not have an email address.' + #13 + #10 + 'Do you wish to load the email program anyway?',
        mtConfirmation, [mbYes, mbNo], 0)  = mrNo then Exit;
    end;


    if qrySupplier.State in [dsEdit,dsInsert] then begin
      qrySupplier.Post;
      qrySupplier.Edit;
    end;

    Form := GetComponentByClassName('TfrmClientReference',false,self);
    if Assigned(Form) then begin
      with TfrmClientReference(Form) do begin
        FormStyle := fsMDIChild;
        BringToFront;
        AttachObserver(self);
        TitleLabel.Caption := 'Email To Contact';
        EditedFlag.Checked := true;
        Ref_Type.Text := 'Email';
        ClientID.Text := qrySupplierClientID.AsString;
        SupID.Text := qrySupplierClientID.AsString;
        CID := qryContacts.FieldByName('ContactID').AsInteger;
        Ref_Date.Text := DateTimeToStr(now);
        //if not Empty(Email.Text) then EmailNo.Text := Email.Text
        //else EmailNo.Text := 'Email';
        EmailNo.Text := self.qryContactsContactEmail.AsString;

        FaxNo.Text := '';
        Refresh;
      end;
    end;
  finally
    EnableForm;
  end; *)
end;

procedure TfmSupplier.EditbtnClick(Sender: TObject);
begin
  DisableForm;
  try
    if self.qryContacts.FieldByName('ContactID').AsInteger=0 then Exit;
    Callcontactform(TDNMSpeedButton(EditBtn));
  finally
    EnableForm;
  end;
end;

procedure TfmSupplier.CNewbtnClick(Sender: TObject);
begin
  DisableForm;
  try
    Callcontactform(TDNMSpeedButton(Sender));
  finally
    EnableForm;
  end;
end;

procedure TfmSupplier.Button1Click(Sender: TObject);
//var
//  cmd: TERPCommand;
begin
  inherited;
  if qrySupplier.FieldByName('Customer').AsBoolean then exit;

  qrySupplier.Edit;
  qrySupplier.FieldByName('Customer').AsString := 'T';
  qrySupplierClientTypeID.asInteger := DefaultclientTypeId;
//  if qryContacts.RecordCount > 0 then begin
//    cmd:= TERPCommand.Create(nil);
//    try
//      cmd.Connection:= qryContacts.Connection;
//      cmd.SQL.Add('update tblcontacts set CusID = ' + IntToStr(qrySupplierClientID.AsInteger)+', ContactIsCustomer = "T"');
//      cmd.SQL.Add('where SupId = ' + IntToStr(qrySupplierClientID.AsInteger));
//      cmd.Execute;
//    finally
//      cmd.Free;
//    end;
//  end;
  Button1.Enabled := False;
end;

procedure TfmSupplier.grdContactRowChanged(Sender: TObject);
begin
  inherited;
  Letterbtn.Enabled := (grdContact.datasource.dataset.Active) and (grdContact.datasource.dataset.recordcount > 0);
  Faxbtn.Enabled := Letterbtn.Enabled;
  Emailbtn.Enabled := Letterbtn.Enabled;
  Editbtn.Enabled := Letterbtn.Enabled;
end;

procedure TfmSupplier.grdCorrespondenceDblClick(Sender: TObject);
var
  FileNamedocx,FileName: OleVariant;
  sRef: string;
  form : TComponent;
  IdMessage: TIdMessage;
  Stream: TStream;
  EmailFileName: string;
begin
  inherited;
  if SameText(qryDocuments.FieldByName('Ref_Type').AsString, 'Email') and (qryDocuments.FieldByName('MessageId').AsString <> '') then begin
    { this is an email }
    EmailFileName := SystemLib.GetAppTempDir + '\' + qryDocuments.FieldByName('MessageId').AsString + '.eml';
    IdMessage := TIdMessage.Create;
    try
      Stream := qryDocuments.CreateBlobStream(qryDocuments.FieldByName('ReferenceData'),bmRead);
      try
        IdMessage.LoadFromStream(Stream);
      finally
        Stream.Free;
      end;
      IdMessage.SaveToFile(EmailFileName);
    finally
      IdMessage.Free;
    end;
    ShellExecute(Handle, 'Open', PChar(EmailFileName), '', '', SW_SHOWNORMAL);
    exit;
  end;

  sRef := qryDocuments.FieldByName('ReferenceTxt').AsString;
  if qryDocPath.FieldByName('DocumentPath').AsString <> '' then
    FileName    := qryDocPath.FieldByName('DocumentPath').AsString + '\' + SRef
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

  if AppEnv.Employee.UseWord then begin
    WordApplication1.Disconnect;
    WordApplication1.DDETerminateAll;
    WordApplication1.Connect;
    WordApplication1.Visible := true;
    WordApplication1.Documents.Open(FileName, EmptyParam,
      EmptyParam, EmptyParam, EmptyParam, EmptyParam,
      EmptyParam, EmptyParam, EmptyParam, EmptyParam,
      EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam);
    WordApplication1.Documents.Save(EmptyParam, EmptyParam);
    WordApplication1.Activate;
    WordApplication1.Disconnect;
    WordApplication1.DDETerminateAll;
  end else begin
    FileName := FileName + '.RTF';
    Form := GetComponentByClassName('TREMainClient');
    if Assigned(Form) then begin
      with TREMainClient(Form) do begin
        Referencetxt.Text := SRef;
        Edit1.Text := 'True';
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  end;
end;

procedure TfmSupplier.grdCorrespondenceFieldChanged(Sender: TObject;
  Field: TField);
begin
  inherited;
  fbIsModified := true;
end;

procedure TfmSupplier.grdCorrespondenceRowChanged(Sender: TObject);
var
  stream: TStream;
  str: string;
  PartContent: TContentType;
  x: integer;
  BodyFound: boolean;
  Item: TListItem;
  ImageIndex: integer;
begin
  inherited;
  HTMLViewer.Clear;
  lvAttachments.Clear;
  FileAssociationDetails.Clear;
  lvAttachments.SmallImages := FileAssociationDetails.Images;
  if qryDocuments.FieldByName('MessageId').AsString <> '' then begin
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
  else begin
    FreeAndNil(SelectedMail);
    if SameText(qryDocuments.FieldByName('Ref_Type').AsString,'Email') then begin
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

procedure TfmSupplier.chkdocumentsClick(Sender: TObject);
begin
  inherited;
  qryDocuments.filtered := false;
  if not chkdocuments.Checked then begin
    qryDocuments.filter   := 'Active = ''T''';
    qryDocuments.filtered := true;
  end;
end;

procedure TfmSupplier.chkShowAllClick(Sender: TObject);
begin
  inherited;
  qryContacts.filtered := false;
  if not chkShowAll.Checked then begin
    qryContacts.filter   := 'Active = ''T''';
    qryContacts.filtered := true;
  end;
end;

procedure TfmSupplier.grpHistoryClick(Sender: TObject);
var
  iIndex: integer;
begin
  DisableForm;
  try
    HistoryListform := nil;
    inherited;
    try
      case grpHistory.ItemIndex of
        0:HistoryListform := SupplierStatement;
        1:HistoryListform := PurchaseOrderList;
        2:HistoryListform := BillList;
        3:HistoryListform := ChequeList;
        4:HistoryListform := SupplierPaymentList;
      end;

      if Assigned(HistoryListform) then begin
        HistoryListForm.OnAfterPopupFormShow:= DoOnAfterListPopupFormShow;
        grpHistory.Color := HistoryListform.pnlHeader.Color;

        { hide custom reports to save space }
        HistoryListform.lblcustomReport.Visible := False;
        HistoryListform.cboCustomReports.Visible := False;

        HistoryListform.Parent := pnlHistory;
        HistoryListform.BorderStyle := bsNone;
        HistoryListform.Show;

        // Show Print & Export
        for iIndex := 0 to HistoryListform.FooterPanel.ControlCount - 1 do begin
          if HistoryListform.FooterPanel.Controls[iIndex] is TControl then begin
            TControl(HistoryListform.FooterPanel.Controls[iIndex]).Visible := false;
          end;
        end;
//        HistoryListform.edtSearch.Width := 150;
(*        HistoryListform.FooterPanel.Height := 30;
        HistoryListform.cmdExport.Top := 1;
        HistoryListform.cmdExport.Left := 100;
        HistoryListform.cmdExport.Visible := true;
        HistoryListform.cmdPrint.Top := 1;
        HistoryListform.cmdPrint.Left := pnlHistory.Width - 200;
        HistoryListform.cmdPrint.Visible := true;
        HistoryListform.FooterPanel.Visible := true;
        HistoryListform.grpFilters.Visible := False;
        HistoryListform.pnlButtons.Visible := true;
        HistoryListform.grdMain.PopupMenu := HistoryListform.mnuFilter;
        HistoryListform.grdMain.Align := alClient;*)

      end else begin
        if Assigned(fSupplierStatement) then begin
          fSupplierStatement.Parent := nil;
          fSupplierStatement.Hide;
        end;
        if Assigned(fPurchaseOrderList) then begin
          fPurchaseOrderList.Parent := nil;
          fPurchaseOrderList.Hide;
        end;
        if Assigned(fBillList) then begin
          fBillList.Parent := nil;
          fBillList.Hide;
        end;
        if Assigned(fChequeList) then begin
          fChequeList.Parent := nil;
          fChequeList.Hide;
        end;
        if Assigned(fSuppPaymentList) then begin
          fSuppPaymentList.Parent := nil;
          fSuppPaymentList.Hide;
        end;
        pnlHistory.Font.Size := 15;
        pnlHistory.Caption := 'YOU DO NOT HAVE ACCESS TO THIS REPORT!';
        pnlHistory.Paint;
      end;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfmSupplier.HtmlViewerHotSpotClick(Sender: TObject;
  const SRC: string; var Handled: Boolean);
begin
  inherited;
  ShellExecute(0,'open',PChar(SRC),nil,nil,SW_NORMAL)
end;

procedure TfmSupplier.HtmlViewerImageRequest(Sender: TObject;
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

procedure TfmSupplier.TabCtl20Change(Sender: TObject);
var
  SelectedTab: TTabSheet;
begin
  inherited;
  if (TabCtl20.ActivePage = TTabSheet(tabAttachments))   then
      if not CanShowCustomerAttachments then begin
         TabCtl20.ActivePage := TabCtl20CurTab;
         MessageDlgXP_Vista('You Don''t Have Access to View the Attachments', mtWarning, [mbOK], 0);
         Exit;
      end;

  //Save Before Changing Tabs (They Need KeyID !)
  SelectedTab := TabCtl20.ActivePage;
  if bNewSupp and (TabCtl20.ActivePage <> TTabSheet(Supplier_Info)) then begin
    PreSaveSupplier; // only need the id, not commiting, So i think we don;t need the confirmation?????????????
    TabCtl20.ActivePage := TTabSheet(SelectedTab);
  end;

  if (TabCtl20.ActivePage = TTabSheet(General)) then begin
    if not (cboTermsQry.Active) then begin
      cboTermsQry.Active := true;
      cboShippingQry.Active := true;
      qryEmpID.Active := true;
      qryBankCodes.Active := true;
    end;
  end else if TabCtl20.ActivePage = TTabSheet(Address) then begin
    //
  end else if TabCtl20.ActivePage = TTabSheet(Documents) then begin
    qryDocPath.Open;
    qryDocuments.Close;
    qryDocuments.ParamByName('SupID').asInteger := KeyID;
    qryDocuments.Open;
 end else if TabCtl20.ActivePage = TTabSheet(tabEquip) then begin
    if Equipmentform = nil then begin
      Equipmentform:= TfmClientEquipment.Newform(KeyID, self.Myconnection, self, CustEquipDNMPanel, UpdatefromEquipment);
    end;
  end else if TabCtl20.ActivePage = TTabSheet(History) then begin
    pnlHistory.Update;
    Application.ProcessMessages;
    if grpHistory.ItemIndex < 0 then
      grpHistory.ItemIndex:= 0;
  end;
end;

procedure TfmSupplier.cmdCopyClick(Sender: TObject);
begin
  inherited;
  EditDB(qrySupplier);  qrySupplier.FieldByName('BillStreet').AsString  := Street.Text;
  EditDB(qrySupplier);  qrySupplier.FieldByName('BillStreet2').AsString := Street2.Text;
  EditDB(qrySupplier);  qrySupplier.FieldByName('BillStreet3').AsString := Street3.Text;
  EditDB(qrySupplier);  qrySupplier.FieldByName('BillSuburb').AsString  := Suburb.Text;
  EditDB(qrySupplier);  qrySupplier.FieldByName('BillState').AsString   := State.Text;
  EditDB(qrySupplier);  qrySupplier.FieldByName('BillPostCode').AsString:= PostCode.Text;
  EditDB(qrySupplier);  qrySupplier.FieldByName('BillCountry').AsString := Country.Text;
  PostDB(qrySupplier);
  EditDB(qrySupplier);
end;

procedure TfmSupplier.EmployeeIDEnter(Sender: TObject);
begin
  inherited;
  if not (qryEmpID.Active) then begin
    qryEmpID.Active := true;
  end;
end;

procedure TfmSupplier.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    if IsFollowUpOk() then begin
      if not ChkCustReqdFields() then begin
        Exit;
      end;
      if not Empty(txtCompany.Text) then begin
        if not isCompanyNameOk(txtCompany.Text , keyID) then Exit;
        try
          fsNewCompanyName := txtCompany.Text;

          ProcessEditedFlag('Main', Self, memqrySupplier, qrySupplier, nil);
          (*qrySupplier.Edit;
          qrySupplier.Post;*)
          PostDB(qrySupplier);

          ProcessEditedFlag('Follow Up Lines', Self, memtbOtherFollowUp, tbOtherFollowUp, nil);
          (*tbOtherFollowUp.Edit;
          if tbOtherFollowUp.RecordCount > 0 then tbOtherFollowUp.Post;*)
          PostDB(tbOtherFollowUp);

          ProcessEditedFlag('Supplier Skills', Self, memQrySupplierskills, QrySupplierskills, nil);
          (*QrySupplierskills.Edit;
          if QrySupplierskills.RecordCount > 0 then QrySupplierskills.Post;*)
          PostDB(QrySupplierskills);



          ProcessEditedFlag('Contact Lines', Self, memqryContacts, qryContacts, nil);
          (*qryContacts.Edit;
          if qryContacts.RecordCount > 0 then qryContacts.Post;*)
          PostDB(qryContacts);
          Supplier.Save;

          CommitTransaction;
          Notify;
        except
          on e: EDatabaseError do begin
            Audit.AddEntry(e, Self);
            if FastFuncs.PosEx('duplicate', FastFuncs.LowerCase(e.Message)) > 0 then begin
              CommonLib.MessageDlgXP_Vista('You already have a company name identical to this', mtWarning, [mbOK], 0);
            end else begin
              CommonLib.MessageDlgXP_Vista(e.Message + Chr(13) + 'Errors occured in ' + Self.ClassName, mtWarning, [mbOK], 0);
            end;
          end;
          on e: Exception do begin
            Audit.AddEntry(e, Self);
            CommonLib.MessageDlgXP_Vista(e.Message + Chr(13) + 'Errors occured in ' + Self.ClassName, mtWarning, [mbOK], 0);
          end;
        end;

        KeyID := 0;
        fsNewCompanyName := '';
        FormShow(nil);
      end else begin
        CommonLib.MessageDlgXP_Vista('Company Name cannot be blank.', mtWarning, [mbOK], 0);
        SetControlFocus(txtCompany);
      end;
    end;
  finally
    EnableForm;
  end;
end;


procedure TfmSupplier.grdDocsDblClick(Sender: TObject);
var
  FileNamedocx,FileName: OleVariant;
  sRef: string;
  form : TComponent;
begin
  inherited;
  sRef := qryDocuments.FieldByName('ReferenceTxt').AsString;
  if qryDocPath.FieldByName('DocumentPath').AsString <> '' then
    FileName    := qryDocPath.FieldByName('DocumentPath').AsString + '\' + SRef
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

  if AppEnv.Employee.UseWord then begin
    WordApplication1.Disconnect;
    WordApplication1.DDETerminateAll;
    WordApplication1.Connect;
    WordApplication1.Visible := true;
    WordApplication1.Documents.Open(FileName, EmptyParam,
      EmptyParam, EmptyParam, EmptyParam, EmptyParam,
      EmptyParam, EmptyParam, EmptyParam, EmptyParam,
      EmptyParam, EmptyParam, EmptyParam, EmptyParam, EmptyParam);
    WordApplication1.Documents.Save(EmptyParam, EmptyParam);
    WordApplication1.Activate;
    WordApplication1.Disconnect;
    WordApplication1.DDETerminateAll;
  end else begin
    FileName := FileName + '.RTF';
    Form := GetComponentByClassName('TREMainClient');
    if Assigned(Form) then begin
      with TREMainClient(Form) do begin
        Referencetxt.Text := SRef;
        Edit1.Text := 'True';
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  end;
end;

procedure TfmSupplier.btnInactiveFollowUpClick(Sender: TObject);
begin
  inherited;
  tbOtherFollowup.Delete;
  if tbOtherFollowup.RecordCount = 0 then begin
    tbOtherFollowUp.Insert;
  end else begin
    tbOtherFollowUp.Edit;
  end;
end;

procedure TfmSupplier.SuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if Modified then begin
    FillTable.FieldByName('State').AsString    := LookupTable.FieldByName('State').AsString;
    FillTable.FieldByName('Postcode').AsString := LookupTable.FieldByName('Postcode').AsString;
    FillTable.FieldByName('Country').asString  := LookupTable.FieldByName('Country').asString;
  end;
end;

procedure TfmSupplier.SuburbEnter(Sender: TObject);
begin
  inherited;
  if not (SuburbQry.Active) then begin
    SuburbQry.Active := true;
  end;
  AssignComboAccessed(Sender);
end;

procedure TfmSupplier.btnInactiveClick(Sender: TObject);
begin
  inherited;
  qryContacts.Edit;
  qryContacts.FieldByName('Active').AsString := 'F';
  qryContacts.Post;
  qryContacts.Close;
  qryContacts.Open;
end;

procedure TfmSupplier.cmdShippingClick(Sender: TObject);
var
  ShipAddressList: TShipAddressListGUI;
begin
  DisableForm;
  try
    inherited;
    ShipAddressList := TShipAddressListGUI(GetComponentByClassName('TShipAddressListGUI'));

    if Assigned(ShipAddressList) then
    begin
//      ShipAddressList.FilterString := 'ClientID = ' + IntToStr(KeyID);
      ShipAddressList.CustomerID := KeyId;
      ShipAddressList.FormStyle := fsMDIChild;
      ShipAddressList.BringToFront;
    end;
  finally
    EnableForm;
  end;
end;



procedure TfmSupplier.cmdPrintClick(Sender: TObject);
var
  sSQL: string;
  sClientID: string;
begin
  DisableForm;
  try
    inherited;
    if not ChkCustReqdFields() then begin
      Exit;
    end;
    if IsOkToSave() then begin
      Postdb(qrySupplier);//.Post;
      EditDB(qrySupplier);//.Edit;
    end;

    sClientID := qrySupplier.FieldByName('ClientID').AsString;
    fbTemplateUsesNonFormConnection := false;
    sSQL := '';
    fbReportSQLSupplied := true;

    sSQL := sSQL + '{Master} ';
    sSQL := sSQL + 'SELECT ';
    sSQL := sSQL + '"Supplier Detail Report" AS ReportTitle, ';
    sSQL := sSQL + 'C.*, SUBSTRING_INDEX(C.Company, "^", 1) as Company_NoJobName, CONCAT_WS(" ", C.Title, C.FirstName, C.LastName) AS FullName, ';
    sSQL := sSQL + 'CONCAT_WS("  ", C.Suburb, C.State, C.PostCode) AS FullPostal, ';
    sSQL := sSQL + 'CONCAT_WS("  ", C.BillSuburb, C.BillState, C.BillPostCode) AS FullBillPostal ';
    sSQL := sSQL + 'FROM tblclients C ';
    sSQL := sSQL + 'WHERE C.ClientID=' + sClientID + ' AND C.Supplier="T"; ';
    sSQL := sSQL + '~|||~{Custom Fields} ';
    sSQL := sSQL + 'SELECT * FROM tblcustomfields; ';
    sSQL := sSQL + '~|||~{Contacts} ';
    sSQL := sSQL + 'SELECT *, CONCAT_WS(" ", ContactTitle, ContactFirstName, ContactSurName) AS FullName ';
    sSQL := sSQL + 'FROM tblcontacts ';
    sSQL := sSQL + 'WHERE ClientId = ' + sClientID + ' /*AND ContactIsCustomer="F" AND ContactIsJob="F" AND ';
    sSQL := sSQL + 'ContactIsSupplier="F" AND ContactIsOtherContact="F"*/ AND Active="T"; ';
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

function TfmSupplier.IsFollowUpOK: boolean;
begin
  Result := true;
  with tbOtherFollowUp do begin
    if RecordCount <> 0 then begin
      First;
      while not Eof do begin
        if tbOtherFollowUpEmployeeID.AsInteger = 0 then begin
          Result := false;
          CommonLib.MessageDlgXP_Vista('You must provide an Employee in the FollowUp Table', mtWarning, [mbOK], 0);
          TabCtl20.ActivePage := TTabSheet(Documents);
          SetControlFocus(grdFollowUp);
          Break;
        end;
        Next;
      end;
    end;
  end;
end;

// Adds date / time to notes when user leaves the selected cell.
procedure TfmSupplier.grdFollowUpColExit(Sender: TObject);
begin
  inherited;
  if sameText(grdFollowUp.GetActiveField.FieldName , tbOtherFollowUpNotes.FieldName) then begin
    if tbOtherFollowUpNotes.ReadOnly  then exit;
    if sametext(tbOtherFollowUpNotes.AsString , tbOtherFollowUpNotes.OldValue) then else begin
      EditDB(tbOtherFollowUp);
      tbOtherFollowUpNotes.asString := AddDateTime(lcdOnSupplierfollowupNotes, tbOtherFollowUpNotes.asString, False);
    end;
  end;
end;
procedure TfmSupplier.btnAddfollowupnotedateClick(Sender: TObject);
begin
  inherited;
      if tbOtherFollowUpNotes.ReadOnly  then exit;
      EditDB(tbOtherFollowUp);
      tbOtherFollowUpNotes.asString := AddDateTime(lcdOnLoganyway, tbOtherFollowUpNotes.asString, False);
end;

// Remove date / time if they are present.
procedure TfmSupplier.grdFollowUpColEnter(Sender: TObject);
begin
  inherited;
  if sameText(grdFollowUp.GetActiveField.FieldName , tbOtherFollowUpNotes.FieldName) then begin
    if tbOtherFollowUpNotes.ReadOnly  then exit;
    with grdFollowUp do begin
      editdb(TBOtherFollowUp);
      TBOtherFollowUpnotes.asString := StripDateTime(TBOtherFollowUpnotes.asString);
      Postdb(TBOtherFollowUp);
    end;
  end;
end;

procedure TfmSupplier.qrySupplierAfterInsert(DataSet: TDataSet);
begin
  inherited;
  fbclientnameMadeFromName := False;
  PostDB(qrySupplier);
  LoadMemTable;
  EditDB(qrySupplier);
  qrySupplierDocumentPath.AsString := Appenv.DocPath.DocumentPath;
end;

procedure TfmSupplier.qrySupplierAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadMemTable;
  If not Assigned(AttachmentForm) then Begin
    AttachmentForm := TfmAttachments(GetComponentByClassName('TfmAttachments',False,Self,True,True,self.qrySupplierClientID.AsInteger));
    AttachmentForm.DBConnection := MyConnection;
    AttachmentForm.AttachObserver(Self);
    AttachmentForm.TableName := 'tblClients';
    AttachmentForm.TableId := qrySupplierClientID.AsInteger;
    AttachmentForm.Tag := qrySupplierClientID.AsInteger;
    AttachmentForm.lvAttachments.Parent := pnlAttachments;
    AttachmentForm.lvAttachments.Align := alClient;
    AttachmentForm.PopulateListView;
  end;
end;

procedure TfmSupplier.LoadCoreEDIConfig;
begin
  edtPOSendUser.text      := Supplier.CoreEDIConfig.Config.O['PO'].O['FTP'].S['User'];
  edtPOSendPass.text      := Supplier.CoreEDIConfig.Config.O['PO'].O['FTP'].S['Pass'];
  edtPOSendServer.text    := Supplier.CoreEDIConfig.Config.O['PO'].O['FTP'].S['Server'];
  edtPOSendDir.text       := Supplier.CoreEDIConfig.Config.O['PO'].O['FTP'].S['SendDir'];
  edtPOReceiveDir.text    := Supplier.CoreEDIConfig.Config.O['PO'].O['FTP'].S['ReceiveDir'];
  edtPOReceiveArchiveDir.text    := Supplier.CoreEDIConfig.Config.O['PO'].O['FTP'].S['FTPReceiveArchiveDir'];
  edtEDIVendorCode.text   := Supplier.CoreEDIConfig.Config.S['EDIVendorCode'];
  edtPOFTPPort.text       := inttostr(Supplier.CoreEDIConfig.Config.O['PO'].O['FTP'].I['Port']); if edtPOFTPPort.text ='0' then edtPOFTPPort.text:= '';
  edtLocalReceiveDir.text := Supplier.CoreEDIConfig.Config.O['PO'].O['FTP'].S['LocalReceiveDir'];
end;

procedure TfmSupplier.LoadMemTable;
begin
  if memqrySupplier.active then
    if qrySupplierClientID.asInteger =  memqrySupplier.fieldbyname('ClientID').asInteger then exit;
  LoadEditedFlagMemTable(qrySupplier, memqrySupplier);
end;

procedure TfmSupplier.lvAttachmentsDblClick(Sender: TObject);
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

procedure TfmSupplier.qryBankCodesBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  TERPQuery(Dataset).Params.ParamByName('XRegionID').AsInteger := AppEnv.RegionalOptions.ID;
  TERPQuery(Dataset).Params.ParamByName('BankCode').AsString := qrySupplierBankCode.AsString;
end;

procedure TfmSupplier.qryContactsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadEditedFlagMemTable(qryContacts, memqryContacts);
end;

procedure TfmSupplier.tbOtherFollowUpAfterInsert(DataSet: TDataSet);
begin
  inherited;
  tbOtherFollowUpClientID.Value := qrySupplier.FieldByName('ClientID').AsInteger;
  tbOtherFollowUpCreationDate.Value := Now;
  tbOtherFollowUpIsSupplier.AsBoolean := true;
  tbOtherFollowUpIsOtherContact.AsBoolean := false;
end;

procedure TfmSupplier.tbOtherFollowUpAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadEditedFlagMemTable(tbOtherFollowUp, memtbOtherFollowUp);
end;

procedure TfmSupplier.qrySupplierFirstNameChange(Sender: TField);
//var newName: string;
begin
  inherited;
  (*if Empty(qrySupplierCompany.AsString) then begin
    newName:= qrySupplierFirstName.AsString;
    if NewCompanyNameOk(newName) then begin
      qrySupplier.Edit;
      qrySupplierCompany.AsString := newName;
    end;
  end;*)
  if  not NamenPrintNameGridObj.UpdatecompanyonNamechange(fbUpdatingcompanyonName,qrySupplier) then SetControlFocus(txtcompany);
end;

procedure TfmSupplier.qrySupplierLastNameChange(Sender: TField);
//var newName: string;
begin
  inherited;
  (*if Empty(qrySupplierCompany.AsString) or (qrySupplierCompany.AsString = qrySupplierFirstName.AsString) then begin
    newName:= qrySupplierFirstName.AsString + ' ' + qrySupplierLastName.AsString;
    if NewCompanyNameOk(newName) then begin
      qrySupplier.Edit;
      qrySupplierCompany.AsString := newName;
    end;
  end;*)
  if  not NamenPrintNameGridObj.UpdatecompanyonNamechange(fbUpdatingcompanyonName,qrySupplier) then SetControlFocus(txtcompany);
end;

procedure TfmSupplier.FormCloseQuery(Sender: TObject; var CanClose: boolean);

begin
  inherited;
  if (not fbSaveClicked) and IsOkToSave() then begin
    if not IsClientNameUnique(txtCompany.Text , keyID) then begin
       Canclose:= CommonLib.MessageDlgXP_Vista('You already have a company name identical to "' + txtCompany.Text + '"' + NL+NL+
                                               'Do You Wish To Cancel These Changes You Have Made?', mtConfirmation,
        [mbYes, mbNo], 0) = mrYes;
        if Canclose then begin
            RollbackTransaction;
            Notify(true);
        end;
    end else
      if fbIsModified or IsModified(memqrySupplier, qrySupplier) then begin
          Canclose:= SaveOrCancelChanges;
      end;
  end;
end;
function TfmSupplier.SaveOrCancelChanges: boolean;
var
  iExitResult: integer;
begin
    Result := True;
    iExitResult := CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation,
        [mbYes, mbNo, mbCancel], 0);
      case iExitResult of
        mrYes:
          begin
            result := Savesupplier;
            if result then begin
              CommitTransaction;
              Notify(False);
            end;
          end;
        mrNo:
          begin;
            RollbackTransaction;
            REsult := true;
            Notify(true);
          end;
        mrCancel: REsult := false;
      end;
end;
function TfmSupplier.MakeSuppliercontact: boolean;
(* var
  s:String; *)
begin
            if qryContacts.Locate('ContactFirstName;ContactSurName;Active' , vararrayof([QrySupplierFirstName.asString ,QrySupplierLastName.asString , 'F' ]) , []) then begin
              editDb(qryContacts);
              qryContactsactive.asBoolean := True;
              PostDB(qryContacts);
              Result:=true;
              Exit;
            end;
         (* finally
            qryContacts.filtered := fbfiltered;
          end;*)

        if (QrySupplierFirstName.asString = '') and (QrySupplierLastName.asString = '') then begin
          result:= false;
          exit;
        end;

        if QrySupplierclientId.asInteger = 0 then begin
          PostDb(QrySupplier);
          EditDb(QrySupplier);
        end;

        (* s:= 'insert into tblContacts Set ';
        s:= s+'CusId=' +inttostr(QrySupplierclientId.asInteger)+',';
        if QrySuppliersupplier.asBoolean then s:= s+'SupId=' +inttostr(QrySupplierclientId.asInteger)+',';
        s:= s+'ContactTitle          = ' +Quotedstr(QrySupplierTitle.asString)+',';
        s:= s+'ContactFirstName      = ' +Quotedstr(QrySupplierFirstName.asString)+',';
        s:= s+'ContactSurName        = ' +Quotedstr(QrySupplierLastName.asString)+',';
        s:= s+'ContactMOB            = ' +Quotedstr(QrySupplierMobile.asString)+',';
        s:= s+'ContactEmail          = ' +Quotedstr(QrySupplierEmail.asString)+',';
        s:= s+'Company               = ' +Quotedstr(QrySupplierFirstName.asString+' ' +QrySupplierLastName.asString)+',';
        s:= s+'ContactPH             = ' +Quotedstr(QrySupplierPhone.asString)+',';
        s:= s+'ContactFax            = ' +Quotedstr(QrySupplierFaxNumber.asString)+',';
        s:= s+'ContactAltPH          = ' +Quotedstr(QrySupplierAltPhone.asString)+',';
        s:= s+'ContactAddress        = ' +Quotedstr(QrySupplierStreet.asString)+',';
        s:= s+'ContactAddress2       = ' +Quotedstr(QrySupplierStreet2.asString)+',';
        s:= s+'ContactCity           = ' +Quotedstr(QrySupplierSuburb.asString)+',';
        s:= s+'ContactState          = ' +Quotedstr(QrySupplierState.asString)+',';
        s:= s+'ContactPcode          = ' +Quotedstr(QrySupplierPostcode.asString)+',';
        s:= s+'Contactcountry        = ' +Quotedstr(QrySupplierCountry.asString)+',';
        s:= s+'ISPrimaryContact     ="T",';
        s:= s+'ContactIsOtherContact="F",';
        s:= s+'ContactIsJob         ="F",';
        s:= s+'Active               ="T",';
        s:= s+'ContactIsSupplier    ="T",';
        if QrySupplierCustomer.asboolean then  s:= s+'ContactIsCustomer    ="T"' else   s:= s+'ContactIsCustomer    ="F"';
        s:=s+';';
        ExecuteSQLinconnection(s);
        if qryContacts.ParamByName('SupID').AsInteger <> QrySupplier.FieldByName('ClientID').AsInteger then begin
          closedb(qryContacts);
          qryContacts.ParamByName('SupID').AsInteger := QrySupplier.FieldByName('ClientID').AsInteger;
          opendb(qryContacts);
        end else
          QryContacts.refresh;
        *)

        if qryContacts.ParamByName('SupID').AsInteger <> QrySupplier.FieldByName('ClientID').AsInteger then begin
          closedb(qryContacts);
          qryContacts.ParamByName('SupID').AsInteger := QrySupplier.FieldByName('ClientID').AsInteger;
          opendb(qryContacts);
        end;

        qryContacts.Insert;
        if qryContacts.state in [dsedit,dsinsert] then else qryContacts.Edit;
        qryContactsClientID.asInteger :=QrySupplierClientID.AsInteger;
        qryContactsClientName.asString :=QrySupplierCompany.AsString;
        qryContactsContactTitle.asString      := QrySupplierTitle.asString;
        qryContactsContactFirstName.asString  := QrySupplierFirstName.asString;
        qryContactsContactSurName.asString    := QrySupplierLastName.asString;
        qryContactsContactMOB.asString        := QrySupplierMobile.asString;
        qryContactsContactEmail.asString      := QrySupplierEmail.asString;
        qryContactsCompany.asString           := QrySupplierFirstName.asString+' ' +QrySupplierLastName.asString;
        qryContactsContactPH.asString         := QrySupplierPhone.asString;
        qryContactsContactFax.asString        := QrySupplierFaxNumber.asString;
        qryContactsContactAltPH.asString      := QrySupplierAltPhone.asString;
        qryContactsContactAddress.asString    := QrySupplierStreet.asString;
        qryContactsContactAddress2.asString   := QrySupplierStreet2.asString;
        qryContactsContactCity.asString       := QrySupplierSuburb.asString;
        qryContactsContactState.asString      := QrySupplierState.asString;
        qryContactsContactPcode.asString      := QrySupplierPostcode.asString;
        qryContactsContactcountry.asString    := QrySupplierCountry.asString;
        qryContactsISPrimaryContact.asBoolean := true;
        //qryContactsContactIsOtherContact.asBoolean := False;
        //qryContactsContactIsJob.asBoolean     := False;
        qryContactsActive.asBoolean           := true;
        //qryContactsContactIsSupplier.asBoolean:= true;
        //qryContactsContactIsCustomer.asBoolean:= QrySupplierCustomer.asboolean;
        qryContacts.Post;
        result := QryContactsContactId.asInteger > 0;
end;

Function TfmSupplier.MakeNewcontactifnone:Boolean;
var
  fbShowAllL:Boolean;
begin
  REsult := False;
      fbShowAllL:=chkShowAll.checked;
      try
        if chkShowAll.checked = False then chkShowAll.checked := true;
        if qryContacts.recordcount =0 then begin
          if MakeSupplierContact then begin
            qryContacts.First;
            REsult := true;
          end;
        end;
      finally
        chkShowAll.checked := fbShowAllL;
      end;
end;
function TfmSupplier.SAvesupplier: boolean;
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
    REsult := False;
    if AppEnv.CompanyPrefs.EnforcesupplierFirstName then begin
      if qrySupplierFirstName.AsString = '' then begin
            Result := false;
            MessageDlgXP_Vista('You must provide the First Name of the Supplier', mtWarning, [mbOK], 0);
            TabCtl20.ActivePage := Supplier_Info;
            SetControlFocus(txtContactFirstName);
            exit;
      end;
    end;
    if IsFollowUpOk() then begin
      if not Empty(txtCompany.Text) then begin
        if not ChkCustReqdFields() then  Exit;
        if not isCompanyNameOk(txtCompany.Text , keyID) then Exit;

        if qrySupplierSendXMLPOs.asString = 'T' then
              if qrySupplierEmailPOXML.asString = '' then begin
                focusinvalidcomp(Address ,XMLEmail ,'''XML email'' should not be blank when ''Send XML POs on PO Run'' is selected');
                Exit;
              end;

        if qrySupplierSendFTPXMLPOs.asString = 'T' then begin
          if qrySupplierFTPAddress.AsString = '' then begin
            FocusInvalidComp(Address ,FTPAddress ,'''FTP Address'' should not be blank when ''Send FTP XML POs on PO Run'' is selected');
            Exit;
          end;
          if qrySupplierFTPUserName.AsString = '' then begin
            FocusInvalidComp(Address ,FTPUserName ,'''FTP User'' should not be blank when ''Send FTP XML POs on PO Run'' is selected');
            Exit;
          end;
          if qrySupplierFTPPassword.AsString = '' then begin
            FocusInvalidComp(Address, FTPPassword ,'''FTP Pass'' should not be blank when ''Send FTP XML POs on PO Run'' is selected');
            Exit;
          end;
        end;

        MakeNewcontactifnone;
        try
          fsNewCompanyName := txtCompany.Text;
          if qrySupplierGlobalref.AsString = '' then begin
            PostDb(qrySupplier);
            EditDb(qrySupplier);
            qrySupplierGlobalref.AsString:= AppEnv.Branch.SiteCode + qrySupplierClientID.AsString;
            PostDb(qrySupplier);
          end;
          ProcessEditedFlag('Main', Self, memqrySupplier, qrySupplier, nil);
          PostDB(qrySupplier);

          ProcessEditedFlag('Follow Up Lines', Self, memtbOtherFollowUp, tbOtherFollowUp, nil);
          postDB(tbOtherFollowUp);

          ProcessEditedFlag('Supplier Skills', Self, memQrySupplierskills, QrySupplierskills, nil);
          PostDB(QrySupplierskills);

          ProcessEditedFlag('Contact Lines', Self, memqryContacts, qryContacts, nil);
          PostDB(qryContacts);

          Supplier.Save;

          REsult := True;
        except
          on e: EDatabaseError do begin
            Audit.AddEntry(e, Self);
            if FastFuncs.PosEx('duplicate', FastFuncs.LowerCase(e.Message)) > 0 then begin
              CommonLib.MessageDlgXP_Vista('You Already Have a Company Name Identical To This One', mtWarning, [mbOK], 0);
            end else begin
              CommonLib.MessageDlgXP_Vista(e.Message + Chr(13) + 'Errors occured in ' + Self.ClassName, mtWarning, [mbOK], 0);
            end;
          end;
          on e: Exception do begin
            Audit.AddEntry(e, Self);
            CommonLib.MessageDlgXP_Vista(e.Message + Chr(13) + 'Errors occured in ' + Self.ClassName, mtWarning, [mbOK], 0);
          end;
        end;
      end else begin
        CommonLib.MessageDlgXP_Vista('Company Name cannot be blank.', mtWarning, [mbOK], 0);
        if TabCtl20.ActivePage <> Supplier_Info then TabCtl20.ActivePage := Supplier_Info;
        SetControlFocus(txtCompany);
      end;
    end;
end;

procedure TfmSupplier.grdContactFieldChanged(Sender: TObject; Field: TField);
begin
  inherited;
  // Do not want to check for modified here as this grids quey is not in transaction
  //fbIsModified := true;
end;

procedure TfmSupplier.grdDocsFieldChanged(Sender: TObject; Field: TField);
begin
  inherited;
  fbIsModified := true;
end;

procedure TfmSupplier.grdDocsIButtonClick(Sender: TObject);
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

procedure TfmSupplier.grdFollowUpFieldChanged(Sender: TObject; Field: TField);
begin
  inherited;
  fbIsModified := true;
end;

procedure TfmSupplier.qrySupplierRepIDChange(Sender: TField);
begin
  inherited;
  qrySupplier.Edit;
  qrySupplierRepName.AsString := qryEmpID.FieldByName('EmployeeName').AsString;
end;

procedure TfmSupplier.QrySupplierskillsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  PostDB(qrySupplier);
  if qrySupplierClientID.asInteger =0 then abort;
  QrySupplierskillsProviderID.asInteger := qrySupplierClientID.asInteger;
end;

procedure TfmSupplier.QrySupplierskillsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadEditedFlagMemTable(QrySupplierskills, memQrySupplierskills);
  if SkillIdtoLocate <> 0 then
    QrySupplierskills.Locate('ID' , SkillIdtoLocate  , []);
end;

procedure TfmSupplier.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
var
  cThisKey: char;
begin
//  inherited; { Removed to stop form close on esc }
  if key = VK_ESCAPE then
 {$IFDEF DevMode}
  inherited
  {$ENDIF}
  else  inherited;

  if Shift = [ssCtrl] then begin
    cThisKey := Chr(Key);
    Key      := 0;
    // Supplier Information Tab
    if cThisKey = 'P' then begin
      TabCtl20.ActivePageIndex := 0;
      TabCtl20Change(Sender);
      Exit;
    end;

    // Address Information Tab
    if cThisKey = 'A' then begin
      TabCtl20.ActivePageIndex := 1;
      TabCtl20Change(Sender);
      Exit;
    end;

    // General Tab
    if cThisKey = 'E' then begin
      TabCtl20.ActivePageIndex := 2;
      TabCtl20Change(Sender);
      Exit;
    end;

    // History Tab
    if cThisKey = 'H' then begin
      TabCtl20.ActivePageIndex := 4;
      TabCtl20Change(Sender);
      Exit;
    end;

    // Contacts Tab
    if cThisKey = 'N' then begin
      TabCtl20.ActivePageIndex := 5;
      TabCtl20Change(Sender);
      Exit;
    end;

    // Documents Tab
    if cThisKey = 'D' then begin
      TabCtl20.ActivePageIndex := 5;
      TabCtl20Change(Sender);
      Exit;
    end;

    // Custom Fields Tab
    if cThisKey = 'I' then begin
      TabCtl20.ActivePageIndex := 6;
      TabCtl20Change(Sender);
      Exit;
    end;

    // Follow Up Tab
    if cThisKey = 'F' then begin
      TabCtl20.ActivePageIndex := 7;
      TabCtl20Change(Sender);
      Exit;
    end;
  end;
end;

procedure TfmSupplier.btnAddDateTimeClick(Sender: TObject);
begin
  inherited;
  edtNotes.Lines.Text := edtNotes.Lines.Text + ' :- (' + AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName +
    ') ' + FormatDateTime('dddd mmmm d yyyy " at " hh:mm AM/PM', Now) + #13#10;
  qrySupplier.Edit;
  qrySupplierNotes.AsString := edtNotes.Lines.Text;
  edtNotes.Update;
end;


procedure TfmSupplier.FormCreate(Sender: TObject);
begin
  fbUpdatingcompanyonName := False;
  ApplyLabelCaptions(lblCompany , cpSupplierName);
  ApplyLabelCaptions(lblClientPrintNameHeading , cpClientPrintName);


  btnAddfollowupnotedate.Visible :=   not(UserPreferenceOn(lcdOnSupplierfollowupNotes));
  addingskill:= False;
  SkillIdtoLocate:= 0;
  SupplierNameToCreate:= '';
  SelectedMail := nil;
  FileAssociationDetails := TFileAssociationDetails.Create;
  HTMLImageStream := TMemoryStream.Create;
  HistoryListform:= nil;
  AddPhoneCallbutton(txtPhoneNumber);
  AddPhoneCallbutton(txtAltPhone);
  AddPhoneCallbutton(txtMobile);

  fbEmailchanged := false;
  inherited;
  if ErrorOccurred then Exit;
  UserLock.Enabled := true;
//  qryDocuments.Connection := CommonDbLib.GetSharedMyDacConnection;

  fSupplierStatement:=Nil;
  fPurchaseOrderList:=Nil;
  fBillList:=Nil;
  fChequeList:=Nil;
  fSuppPaymentList:=Nil;

  Supplier := TSupplier.Create(nil);
  Supplier.Connection := TMyDacDataConnection.Create(Supplier);
  Supplier.Connection.Connection := MyConnection;
  Supplier.BusObjEvent := DoBusinessObjectEvent;

  // register the global event handler for a specific form and event
  GlobalEvents.RegisterNameHandler(Self, 'TfmFollowUp', '', GEVENT_DataChanged, GlobalEventHandler);
end;

procedure TfmSupplier.FormDestroy(Sender: TObject);
begin
  Supplier.Free;
  if not ErrorOccurred then begin
    Freeandnil(EquipmentForm);
    if Assigned(fSupplierStatement) then FreeAndNil(fSupplierStatement);
    if Assigned(fPurchaseOrderList) then FreeAndNil(fPurchaseOrderList);
    if Assigned(fBillList) then FreeAndNil(fBillList);
    if Assigned(fChequeList) then FreeAndNil(fChequeList);
    if Assigned(fSuppPaymentList) then FreeAndNil(fSuppPaymentList);
    Notify; {Needed For TBaseTransGUI cboClientNotInList}
  end;
  HTMLImageStream.Free;
  FileAssociationDetails.Free;
  inherited;
end;

procedure TfmSupplier.btnPOClick(Sender: TObject);
var
  frm: TPurchaseGUI;
begin
  DisableForm;
  try
    inherited;
    frm := TPurchaseGUI(GetComponentByClassName('TPurchaseGUI'));
    if Assigned(Frm) then begin
      frm.InitialiseStartup := true;
      frm.CustomerID := qrySupplier.FieldByName('ClientID').AsInteger;
      frm.FormStyle := fsMDIChild;
      frm.BringToFront;
      Application.ProcessMessages;
      Self.cmdOk.Click;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfmSupplier.TabCtl20Resize(Sender: TObject);
begin
  inherited;
  RealignTabControl(TabCtl20, 2);
  RealignTabControl(pcAddress, 1);
end;

procedure TfmSupplier.edtURLDblClick(Sender: TObject);
begin
  inherited;
  ShellExecute(0, 'open', PChar(Trim(edtURL.Text)), nil, nil, sw_shownormal);
end;

procedure TfmSupplier.cboBankCodeEnter(Sender: TObject);
begin
  inherited;
  with cboBankCode.Lookuptable do begin
    if Active = false then Open;
  end;
end;

procedure TfmSupplier.cboDefaultAPAccountNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  EditDB(qrySupplier);
  qrySupplierDefaultAPAccountID.AsInteger := QryAPAccountsAccountID.AsInteger;
end;

procedure TfmSupplier.cboRepChange(Sender: TObject);
begin
  inherited;
  if screen.ActiveControl = cboRep then
    if trim(cboRep.text) = '' then begin
      editDB(qrySupplier);
      qrySupplierRepID.asInteger := 0;
      PostDB(qrySupplier);
    end;
end;

procedure TfmSupplier.TabCtl20Changing(Sender: TObject; var AllowChange: boolean);
begin
  inherited;
  AllowChange := true;
  (*if not IsClientNameUnique(txtCompany.Text, KeyID) then begin
    CommonLib.MessageDlgXP_Vista('You already have a company name identical to this', mtWarning, [mbOK], 0);
    SetControlFocus(txtcompany);
    AllowChange := false;
  end;*)
  if not isCompanyNameOk(txtCompany.Text , keyID) then
    AllowChange := False;
  TabCtl20CurTab :=TabCtl20.ActivePage;

end;

procedure TfmSupplier.KeyIdChanged(const NewKeyId: integer);
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
  btnSetDocumentPath.Enabled :=  AccessLevel < 3;
  btnOpenDocumentPath.Enabled := btnSetDocumentPath.Enabled;
end;

procedure TfmSupplier.Makecompany;
begin
  if not fbclientnameMadeFromName then
    NamenPrintNameGridObj.Makecompany(fbUpdatingcompanyonName,qrySupplier);
  fbclientnameMadeFromName := False;
end;
procedure TfmSupplier.qrySupplierAfterPost(DataSet: TDataSet);
begin
  inherited;
  Makecompany;

  if KeyId <> self.qrySupplierClientID.AsInteger then KeyId := qrySupplierClientID.AsInteger;
end;

procedure TfmSupplier.btnOtherPhonesClick(Sender: TObject);
Var
  frm: TfrmClientsOtherPhone;
begin
  inherited;
  frm := TfrmClientsOtherPhone(GetComponentByClassName('TfrmClientsOtherPhone'));
  if Assigned(Frm) then begin
    frm.KeyID := qrySupplier.FieldByName('ClientID').AsInteger;
    frm.FormStyle := fsMDIChild;
    frm.BringToFront;
    Application.ProcessMessages;
  end;
end;

procedure TfmSupplier.grdContactKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if grdContact.GetActiveField.FieldName = 'ContactName' then
    CommonLib.MessageDlgXP_Vista('This is a read only field.'+#13+#10+'Please use the Edit or New button to modify it.', mtInformation, [mbOK], 0);
end;

procedure TfmSupplier.edtBankAccNoMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  edtBankAccNo.SelStart := 0;
end;

procedure TfmSupplier.edtEDIVendorCodeChange(Sender: TObject);
begin
  inherited;
  if not TEdit(Sender).Focused then exit;
  Supplier.CoreEDIConfig.Config.S['EDIVendorCode'] := edtEDIVendorCode.text;
end;

procedure TfmSupplier.edtPOReceiveDirChange(Sender: TObject);
begin
  inherited;
  if not TEdit(Sender).Focused then exit;
  Supplier.CoreEDIConfig.Config.O['PO'].O['FTP'].S['ReceiveDir'] := TEdit(Sender).text;
end;
procedure TfmSupplier.edtPOReceiveArchiveDirChange(Sender: TObject);
begin
  inherited;
  if not TEdit(Sender).Focused then exit;
  Supplier.CoreEDIConfig.Config.O['PO'].O['FTP'].S['FTPReceiveArchiveDir'] := TEdit(Sender).text;
end;
procedure TfmSupplier.edtPOFTPPortChange(Sender: TObject);
begin
  inherited;
  if not TEdit(Sender).Focused then exit;
  try Supplier.CoreEDIConfig.Config.O['PO'].O['FTP'].I['Port'] := strToInt(TEdit(Sender).text); except end;
end;

procedure TfmSupplier.edtPOSendDirChange(Sender: TObject);
begin
  if not TEdit(Sender).Focused then exit;
  Supplier.CoreEDIConfig.Config.O['PO'].O['FTP'].S['SendDir'] := TEdit(Sender).text;
end;

procedure TfmSupplier.edtPOSendPassChange(Sender: TObject);
begin
  inherited;
  if not TEdit(Sender).Focused then exit;
  Supplier.CoreEDIConfig.Config.O['PO'].O['FTP'].S['Pass'] := edtPOSendPass.text;
end;

procedure TfmSupplier.edtPOSendServerChange(Sender: TObject);
begin
  inherited;
  if not TEdit(Sender).Focused then exit;
  Supplier.CoreEDIConfig.Config.O['PO'].O['FTP'].S['Server'] := edtPOSendServer.text;
end;

procedure TfmSupplier.edtPOSendUserChange(Sender: TObject);
begin
  inherited;
  if not TEdit(Sender).Focused then exit;
  Supplier.CoreEDIConfig.Config.O['PO'].O['FTP'].S['User'] := edtPOSendUser.text;
end;

procedure TfmSupplier.edtPrintNameChange(Sender: TObject);
begin
  inherited;
  if Screen.ActiveControl = Sender then
    fbclientnameMadeFromName := False;
end;

procedure TfmSupplier.edtPrintNameExit(Sender: TObject);
begin
  inherited;
  if Trim(qrySupplier.FieldByname('PrintName').AsString) <> '' then PostDB(qrySupplier);
end;

procedure TfmSupplier.edtLocalReceiveDirChange(Sender: TObject);
begin
  inherited;
  if not TEdit(Sender).Focused then exit;
  Supplier.CoreEDIConfig.Config.O['PO'].O['FTP'].S['LocalReceiveDir'] := TEdit(Sender).text;
end;

procedure TfmSupplier.SuburbQryBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  SuburbQry.Params.ParamByName('xRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

procedure TfmSupplier.chkActiveClick(Sender: TObject);
begin
  inherited;
  if not TwwCheckBox(Sender).DataSource.DataSet.Active then Exit;
  if EditNoAbort(TwwCheckBox(Sender).DataSource.DataSet) then begin
    if TwwCheckBox(Sender).Checked then begin
      TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsString := 'T'
    end else begin
      TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsString := 'F';
    end;

    if (qrySupplierActive.AsString = 'F') and (RoundCurrency(qrySupplierBalance.AsFloat) <> 0.00) then begin
      qrySupplierActive.AsString := 'T';
      CommonLib.MessageDlgXP_Vista('This Supplier Can''t Be Made Inactive' + #13#10#13#10 +
        'There Is a Balance Outstanding !', mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TfmSupplier.grdFollowUpDblClick(Sender: TObject);
var
  Form: TBaseInputGUI;
begin
  inherited;
//  if (tbOtherFollowUp.State = dsInsert) and not tbOtherFollowUp.FieldByName('FollowUpDate').IsNull
//      and not tbOtherFollowUp.FieldByName('EmployeeName').IsNull then begin
//    tbOtherFollowUp.Post;
//  end;
  if (tbOtherFollowUp.State = dsInsert) then begin
    if tbOtherFollowUp.FieldByName('FollowUpDate').IsNull then
      tbOtherFollowUp.FieldByName('FollowUpDate').AsDateTime := Trunc(now);
    PostDb(tbOtherFollowUp);
  end;
  if (tbOtherFollowUp.RecNo > 0) then
    if tbOtherFollowUpLeadLineID.AsInteger = 0 then begin
      AppContext['TfmFollowUp'].VarByName['SetFocus'] := 'cboFollowUpResult';
      try
        frmFollowUp.DoFollowUp(0, tbOtherFollowUpFollowUpID.AsInteger, Self.MyConnection, Self);
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

function TfmSupplier.GetKeyString: string;
begin
  if qrySupplier.Active then
    result:= qrySupplierPrintname.AsString
  else
    result:= '';
end;

procedure TfmSupplier.GlobalEventHandler(const Sender: TObject; const Event: string; const Data: Pointer);
begin
  tbOtherFollowUp.Close;
  tbOtherFollowUp.Open;
end;

procedure TfmSupplier.tbOtherFollowUpAfterScroll(DataSet: TDataSet);
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

procedure TfmSupplier.Callcontactform(Sender: TDNMSpeedbutton);
Var
  Form : TComponent;
begin
  inherited;
  PostDB(qrySupplier);
  fLastComboAccessed:= nil;
  Form := GetComponentByClassName('TfrmContact');
  if Assigned(Form) then begin
    with TfrmContact(Form) do begin
      AttachObserver(self);
      if sender = EditBtn then
        KeyID := self.qryContacts.FieldByName('ContactID').AsInteger
      else KeyID := 0;
//      SupplierId := Self.KeyID;  //qrySupplierClientID.asInteger;
      ClientID := self.KeyID;
      ClientName:= qrySupplierCompany.asString;
//      ContactIsSupplier := true;
//      if qrySupplierCustomer.AsBoolean then
//        ClientID:= SupplierID;

      PassedConnection := Self.MyConnection;
      (* if (fsmodal in Self.formstate) then begin
        Showmodal;
      end else begin
        FormStyle := fsMDIChild;
        BringToFront;
      end;
      Refresh;*)
      Showmodal;

    end;
  end;
end;

procedure TfmSupplier.UpdateMe(const Cancelled: boolean;
  const aObject: TObject);
begin
  inherited;
  if Cancelled then begin
    if Assigned(fLastComboAccessed) then begin
      fLastComboAccessed.Text := '';
      Closenopendb(fLastComboAccessed.LookupTable);
    end;
  end
  else begin
    if Assigned(fLastComboAccessed) and Assigned(aObject) and (aObject is TBaseInputGUI) then begin
      if Sysutils.SameText(fLastComboAccessed.Name, 'Suburb') then begin
        with fLastComboAccessed do begin
          Closenopendb(LookupTable);
          LookupTable.Locate('LocationId', TBaseInputGUI(aObject).KeyID, []);
          EditDB(qrySupplier);
          qrySupplierSuburb.AsString := LookupTable.FieldByName('City_sub').AsString;
          SuburbCloseUp(fLastComboAccessed, LookupTable, qrySupplier, true);
        end;
      end else if Sysutils.SameText(fLastComboAccessed.Name, 'BillSuburb') then begin
        with fLastComboAccessed do begin
          Closenopendb(LookupTable);
          LookupTable.Locate('LocationId', TBaseInputGUI(aObject).KeyID, []);
          EditDB(qrySupplier);
          qrySupplierBillSuburb.AsString := LookupTable.FieldByName('City_sub').AsString;
          BillSuburbCloseUp(fLastComboAccessed, LookupTable, qrySupplier, true);
        end;
      end;
    end;
    if Assigned(aObject) then begin
      if (aObject.Classname = 'TfrmContact') then begin
        if TfrmContact(aObject).Contact.IsPrimaryContact then begin
          PostDb(qrySupplier);
          qrySupplier.Refresh;
          EditDb(qrySupplier);
        end;
        if qryContacts.Active then begin
          qryContacts.Refresh;
        end;
      end
      else if aObject.ClassNameIs('TfmCustomerCorrespondenceCreate') then begin
        CloseDb(qryDocuments);
        OpenDb(qryDocuments);
      end;
    end;
  end;
end;

procedure TfmSupplier.wwIButton3Click(Sender: TObject);
begin
  inherited;
  QrySupplierskills.Delete;
  if QrySupplierskills.RecordCount = 0 then begin
    QrySupplierskills.Insert;
  end else begin
    QrySupplierskills.Edit;
  end;

end;

procedure TfmSupplier.CompleteComboNotInList(const aObserver: TObject);
begin
  inherited;
  if Assigned(fLastComboAccessed) then begin
    SetControlFocus(fLastComboAccessed);
   end;
   InComboNotinList := False;
end;

procedure TfmSupplier.SetComboFocus(var Msg: TMessage);
begin
  if Assigned(fLastComboAccessed) then SetControlFocus(fLastComboAccessed);
end;

procedure TfmSupplier.SetKeyString(const Value: string);
begin
  SetKeyString(TSupplier, qrySupplier, Value , 'Printname');
end;

procedure TfmSupplier.SetStateParams(const Value: TJsonObject);
begin
  inherited;
  if not Assigned(Value) then
    exit;
  if Value.Count > 0 then begin
    TabCtl20.ActivePageIndex:= Value.I['TabControlActivePageIndex'];
    if TabCtl20.ActivePage = History then begin
      grpHistory.ItemIndex:= StateParams.I['grpHistoryItemIndex'];
      Application.ProcessMessages;
      if Assigned(HistoryListform) then begin
        HistoryListForm.dtFrom.DateTime:= StateParams.F['DateFrom'];
        HistoryListForm.dtTo.DateTime:= StateParams.F['DateTo'];
        PostMessage(HistoryListForm.Handle, SX_DatechangeMsg, 0, 0);

//        HistoryListForm.btnRequery.Click;
      end;
    end;
  end;
end;

function TfmSupplier.ShiptoAddress: String;
begin
  Result := ConcatStrings([qrySupplierCompany.AsString , qrySupplierstreet.AsString, qrySupplierstreet2.AsString, qrySupplierstreet3.AsString ,
            ConcatStrings([qrySupplierSuburb.AsString , qrySupplierState.AsString , qrySupplierPostcode.AsString], ' ')] , NL);

end;

procedure TfmSupplier.AssignComboAccessed(Sender: TObject);
begin
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
end;

procedure TfmSupplier.UpdatefromEquipment;
begin
  EditDB(qrySupplier);
  qrySupplierLastUpdated.AsDateTime := Now;

end;

procedure TfmSupplier.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
begin
  inherited;
  if E is EDBEditError then begin
    if ActiveControl = edtBankAccBSB then
      MessageDlgXP_Vista('Bank ' + lblBSB.Caption + ' format is not correct, use Esc to cancel changes.',mtInformation,[mbOk],0)
    else if ActiveControl = edtBankAccNo then
      MessageDlgXP_Vista('Bank Account No format is not correct, use Esc to cancel changes.',mtInformation,[mbOk],0)
    else
      MessageDlgXP_Vista('Format is not correct, use Esc to cancel changes.',mtInformation,[mbOk],0);
  end
  else if E is EInvalidOperation then begin
      MessageDlgXP_Vista(E.Message,mtError,[mbOk],0);
  end
  else if Pos('Duplicate entry',E.Message) > 0 then begin
    MessageDlgXP_Vista(E.Message,mtWarning,[mbOk],0);
  end
  else  if devmode then
    MessageDlgXP_Vista(E.Message,mtWarning,[mbOk],0)
  else
    raise E;
end;

function TfmSupplier.NewCompanyNameOk(const aCompanyName: string): boolean;
begin
  result := isCompanyNameOk(aCompanyName , 0);
end;
procedure TfmSupplier.pcAddressChange(Sender: TObject);
begin
  inherited;
  if (pcAddress.ActivePage = TTabSheet(tsEDI)) then begin
    Supplier.CoreEDIConfig;
    if Supplier.CoreEDIConfig.IsEmpty then
      Supplier.CoreEDIConfig.New;
//    Supplier.CoreEDIConfig;
    LoadCoreEDIConfig;
  end;
end;

procedure TfmSupplier.btnGetEmailsClick(Sender: TObject);
begin
  inherited;
  CheckForEmails;
end;

function TfmSupplier.isCompanyNameOk(const aCompanyName: string;fKeyID:Integer): boolean;
begin
  result:= true;
  if not IsClientNameUnique(aCompanyName,fKeyID) then begin
    CommonLib.MessageDlgXP_Vista('You already have a company name identical to "' + aCompanyName + '"', mtInformation, [mbOK], 0);
    SetControlFocus(txtcompany);
    result:= false;
  end;
end;

procedure TfmSupplier.qrySupplierCompanySetText(Sender: TField;
  const Text: String);
begin
  inherited;
  if NewCompanyNameOk(Text) then
    Sender.AsString:= Text;
end;

procedure TfmSupplier.TermsCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
  if qrySupplierTERMS.AsString <> cboTermsQry.FieldByName('Terms').AsString then begin
    qrySupplierTERMS.AsString:= cboTermsQry.FieldByName('Terms').AsString;

  end;
end;

procedure TfmSupplier.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if TabCtl20.ActivePage = TTabSheet(History) then begin
    case grpHistory.ItemIndex of
      0 : if assigned(fSupplierStatement) then fSupplierStatement.OnKeyUp(fSupplierStatement,Key,Shift);
      1 : if assigned(fPurchaseOrderList) then fPurchaseOrderList.OnKeyUp(fPurchaseOrderList,Key,Shift);
      2 : if assigned(fBillList)          then fBillList.OnKeyUp(fBillList,Key,Shift);
      3 : if assigned(fChequeList)        then fChequeList.OnKeyUp(fChequeList,Key,Shift);
      4 : if assigned(fSuppPaymentList)   then fSuppPaymentList.OnKeyUp(fSuppPaymentList,Key,Shift);
    end;
  end;
end;


function TfmSupplier.BillList: TBaseListingGUI;
begin
  CreateHistorylistform('TBillListGUI' ,Self, fbilllist,'ClientID', qrySupplier.FieldByName('ClientID').AsString);
  result :=fbilllist
end;

procedure TfmSupplier.CheckForEmails;
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

function TfmSupplier.ChequeList: TBaseListingGUI;
begin
  CreateHistorylistform('TChequeListGUI' ,Self, fchequelist,'ClientID', qrySupplier.FieldByName('ClientID').AsString);
  result := fchequelist;
end;

function TfmSupplier.PurchaseOrderList: TBaseListingGUI;
begin
  CreateHistorylistform('TPurchaseOrderListGUI' ,Self, fPurchaseOrderList,'ClientID', qrySupplier.FieldByName('ClientID').AsString);
  if assigned(fPurchaseOrderList) then
    TPurchaseOrderListGUI(fPurchaseOrderList).grdPOOptions.Visible := False;
  result := fPurchaseOrderList;
end;

function TfmSupplier.SupplierStatement: TBaseListingGUI;
begin
  CreateHistorylistform('TSupplierStatementGUI' ,Self, fSupplierStatement,'ClientID', qrySupplier.FieldByName('ClientID').AsString);
  result := fSupplierStatement;
end;

function TfmSupplier.SupplierPaymentList: TBaseListingGUI;
begin
  CreateHistorylistform('TSuppPaymentListGUI' ,Self, fSuppPaymentList,'ClientID', qrySupplier.FieldByName('ClientID').AsString);
  result := fSuppPaymentList;
end;

procedure TfmSupplier.AccountNoKeyPress(Sender: TObject; var Key: Char);
begin
  { Removed 26/05/2016 so alpha chars can be used - its allowed in customer form as well}
(*var
  iKey: integer;
begin
  inherited;
  iKey := Ord(Key);
  // Only accept keys of 0-9 or backspace - anything else is refused!
  if (iKey <> 8) and (iKey <> 46) and ((iKey < 48) or (iKey > 57)) then begin
    Key := #0;
    Exit;
  end;*)
end;

procedure TfmSupplier.AfterPopupformshow;
begin
  inherited;
  if Sysutils.SameText(CallingClassName , 'TContactListGUI') or
    Sysutils.SameText(CallingClassName , 'TGlobalsearchGUI')  then
    TabCtl20.Activepage := Contacts;
end;
procedure TfmSupplier.QrySupplierCalcFields(DataSet: TDataSet);
begin
  inherited;
  QrySuppliercDocumentPath.AsString  := cDocumentPath(QrySupplier);
end;
procedure TfmSupplier.btnSetDocumentPathClick(Sender: TObject);
begin
  SetDocPath(QrySupplier);
end;
procedure TfmSupplier.btnOpenDocumentPathClick(Sender: TObject);
begin
  inherited;
   OpenDocPath(QrySupplier);
end;
function TfmSupplier.ClientId: Integer;
begin
  Result := qrySupplierClientID.AsInteger;
end;

initialization
  RegisterClassOnce(TfmSupplier);
  with FormFact do begin
    RegisterMe(TfmSupplier, 'TSupplierListGUI_*=ClientID');
    RegisterMe(TfmSupplier, 'TSupplierExpressListGUI_*=ClientID');
    RegisterMe(TfmSupplier, 'TSupplierSkillListGUI_*=ClientID');
    (*RegisterMe(TfmSupplier, 'TRemindersListGUI_*_Supplier FollowUp=ClientID');*)
    RegisterMe(TfmSupplier, 'TReminderListGUI_*_Supplier FollowUp=ClientID');
    (*RegisterMe(TfmSupplier, 'TRemindersListGUI_Client_AppointmentSupplier=ClientID');*)
    RegisterMe(TfmSupplier, 'TReminderListGUI_Client_AppointmentSupplier=ClientID');
    RegisterMe(TfmSupplier, 'TAppointmentListGUI_Company_Supplier=ClientID');
    RegisterControl(TfmSupplier, 'TPurchaseGUI_cboClientR=ClientID');
    RegisterControl(TfmSupplier, 'TPurchaseGUI_cboClientR=ClientID');
    RegisterControl(TfmSupplier, 'TReturnAGUI_cboClientR=ClientID');
    RegisterControl(TfmSupplier, 'TBillGUI_cboClientR=ClientID');
    RegisterControl(TfmSupplier, 'TCreditGUI_cboClientR=ClientID');
    RegisterControl(TfmSupplier, 'TfmCheque_cboClientR=ClientID');
    RegisterControl(TfmSupplier, 'TSmartOrderGUI_cboClientR=ClientID');
    RegisterControl(TfmSupplier, 'TfrmPayrollCompanyInfo_cboClient=ClientID');
    RegisterControl(TfmSupplier, '*_cboSupp=ClientID');
    RegisterControl(TfmSupplier, '*_cboSupplier=ClientID');
    RegisterControl(TfmSupplier, 'TfmSuppPayments_cboClient=ClientID');
    RegisterControl(TfmSupplier, 'TfmSuppPrepayments_cboClient=ClientID');
    //RegisterControl(TfmSupplier, 'TFixedAssetGUI_cboClient=ClientID');
    RegisterControl(TfmSupplier, 'TfmFixedAsset_cboClient=ClientID');
    RegisterControl(TfmSupplier, 'TfrmEmployee_cboSuperFund=ClientID');
    RegisterControl(TfmSupplier, 'TfrmEmployee_Workcover=ClientID');
    RegisterMe(TfmSupplier, 'TMarketingLeadsGUI_Company_Supplier=ClientID');
    RegisterMe(TfmSupplier, 'TGlobalListSearchFrm_*_Supplier(Contact)=ID');
    RegisterMe(TfmSupplier, 'TGlobalListSearchFrm_*_Supplier(Primary Contact)=ID');
    RegisterMe(TfmSupplier, 'TGlobalListSearchFrm_*_Supplier=ID');
    RegisterMe(TfmSupplier, 'TGlobalListFrm_*_Supplier(Contact)=ID');
    RegisterMe(TfmSupplier, 'TGlobalListFrm_*_Supplier=ID');
    RegisterMe(TfmSupplier, 'TMarketingContactListGUI_*_S=ClientID');
    RegisterMe(TfmSupplier, 'TClientListGUI_*_Supplier=ClientID');
    RegisterMe(TfmSupplier, 'TContactListGUI_*_Supplier=ClientID');
    RegisterMe(TfmSupplier, 'TGlobalsearchGUI_*_Supplier=ClientID');
    RegisterMe(TfmSupplier, 'TOtherfollowupsGUI_*_Supplier=ClientID');
    RegisterMe(TfmSupplier, 'TClientMainContactsGUI_*_Supplier=ClientID');
    RegisterMe(TfmSupplier, 'TCustomFieldValuesSupplierGUI_*_MasterID=ClientID');
    RegisterMe(TfmSupplier, 'TCustomFieldValuesListContactGUI_*_Supplier=ClientId');
    RegisterMe(TfmSupplier, 'TCustomFieldValuesListSupplierGUI_*=ClientId');
  end;

finalization
  UnRegisterClass(TfmSupplier);
end.






