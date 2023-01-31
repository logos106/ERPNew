unit frmMarketingContact;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, StdCtrls, wwdbedit, Wwdotdot, Wwdbcomb,
  wwdbdatetimepicker, ComCtrls, wwriched, DNMSpeedButton, wwcheckbox,
  wwdblook, Mask, DBCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, ExtCtrls,
  DB, MemDS, DBAccess, MyAccess, ERPdbComponents, Shader, DNMPanel,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  BusObjBase, BusobjMarketingcontacts, BusObjMarketingLeads,
  frmMarketingContactcotnact, ERPDbLookupCombo, ProgressDialog;

type
  TfmMarketingContact = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    txtCompany: TDBMemo;
    dsMarketingContacts: TDataSource;
    qryMarketingContacts: TERPQuery;
    qryMarketingContactsID: TIntegerField;
    qryMarketingContactsGlobalRef: TWideStringField;
    qryMarketingContactsCompanyTypeName: TWideStringField;
    qryMarketingContactsCOMPANY: TWideStringField;
    qryMarketingContactsStreet: TWideStringField;
    qryMarketingContactsStreet2: TWideStringField;
    qryMarketingContactsFaxNumber: TWideStringField;
    qryMarketingContactsPhone: TWideStringField;
    qryMarketingContactsAltPhone: TWideStringField;
    qryMarketingContactsMobile: TWideStringField;
    qryMarketingContactsSUBURB: TWideStringField;
    qryMarketingContactsSTATE: TWideStringField;
    qryMarketingContactsPOSTCODE: TWideStringField;
    qryMarketingContactsEmployeeSize: TWideStringField;
    qryMarketingContactsNotes: TWideMemoField;
    qryMarketingContactsActive: TWideStringField;
    qryMarketingContactsJobTitle: TWideStringField;
    qryMarketingContactsTitle: TWideStringField;
    qryMarketingContactsFirstName: TWideStringField;
    qryMarketingContactsMiddleName: TWideStringField;
    qryMarketingContactsLastName: TWideStringField;
    qryMarketingContactsEmail: TWideStringField;
    qryMarketingContactsCountry: TWideStringField;
    qryMarketingContactsDateEntered: TDateTimeField;
    qryMarketingContactsEnteredEmpID: TIntegerField;
    qryMarketingContactsDateOfBirth: TDateField;
    qryMarketingContactsDuration: TDateTimeField;
    qryMarketingContactsmsTimeStamp: TDateTimeField;
    qryMarketingContactsSource: TWideStringField;
    qryMarketingContactsStreet3: TWideStringField;
    qryMarketingContactsURL: TWideStringField;
    mainPage: TPageControl;
    Customer_Info: TTabSheet;
    DNMPanel1: TDNMPanel;
    Bevel23: TBevel;
    Box70: TBevel;
    Box69: TBevel;
    Label25: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label31: TLabel;
    Label33: TLabel;
    Label178: TLabel;
    Label34: TLabel;
    Label5: TLabel;
    Label48: TLabel;
    Label11: TLabel;
    lblRelatedCust: TLabel;
    grdRelatedClient: TwwDBGrid;
    wwIButton2: TwwIButton;
    cboClient: TwwDBLookupCombo;
    Address_Info: TTabSheet;
    DNMPanel2: TDNMPanel;
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
    lblBillSuburb: TLabel;
    lblBillState: TLabel;
    lblBillPostcode: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    Label1: TLabel;
    Label13: TLabel;
    Label35: TLabel;
    Box76: TBevel;
    Label127: TLabel;
    BillStreet: TDBEdit;
    BillState: TDBEdit;
    BillPostcode: TDBEdit;
    BillSuburb: TwwDBLookupCombo;
    BillStreet2: TDBEdit;
    BillCountry: TDBEdit;
    URL: TwwDBRichEdit;
    BillStreet3: TDBEdit;
    Email: TDBEdit;
    tabFollowUp: TTabSheet;
    DNMPanel3: TDNMPanel;
    Custom_Fields: TTabSheet;
    cmdCustomLabels: TDNMSpeedButton;
    pnlCustFields: TDNMPanel;
    Box181: TBevel;
    Label179: TLabel;
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
    tabContacts: TTabSheet;
    DNMPanel4: TDNMPanel;
    Bevel2: TBevel;
    EditBtn: TDNMSpeedButton;
    cmdNewContact: TDNMSpeedButton;
    chkShowAll: TCheckBox;
    grdContact: TwwDBGrid;
    wwIButton1: TwwIButton;
    tabDocuments: TTabSheet;
    DNMPanel5: TDNMPanel;
    DBEdit1: TDBEdit;
    edtTitle: TDBEdit;
    txtContactFirstName: TDBEdit;
    txtContactSurName: TDBEdit;
    JobTitle: TDBEdit;
    qryCompanyType: TERPQuery;
    cboCompanyType: TwwDBLookupCombo;
    ContactMOB: TwwDBEdit;
    ContactFax: TwwDBEdit;
    txtContactAltPH: TwwDBEdit;
    qrySuburbs: TERPQuery;
    txtCountry: TDBEdit;
    Postcode: TDBEdit;
    State: TDBEdit;
    Suburb: TwwDBLookupCombo;
    txtContactAddress3: TDBEdit;
    txtContactAddress2: TDBEdit;
    txtContactAddress: TDBEdit;
    qryMarketingContactsBillStreet: TWideStringField;
    qryMarketingContactsBillStreet2: TWideStringField;
    qryMarketingContactsBillStreet3: TWideStringField;
    qryMarketingContactsBillSuburb: TWideStringField;
    qryMarketingContactsBillState: TWideStringField;
    qryMarketingContactsBillPostcode: TWideStringField;
    qryMarketingContactsBillCountry: TWideStringField;
    qryContactType: TERPQuery;
    qryMarketingContactsREpId: TIntegerField;
    qryMarketingContactsREpName: TWideStringField;
    qryEmp: TERPQuery;
    cboRep: TwwDBLookupCombo;
    qryRelatedClients: TERPQuery;
    DSRelatedClients: TDataSource;
    qryRelatedClientsGlobalRef: TWideStringField;
    qryRelatedClientsRelatedContactID: TIntegerField;
    qryRelatedClientsMasterContactID: TIntegerField;
    qryRelatedClientsMasterCompany: TWideStringField;
    qryRelatedClientsChildContactID: TIntegerField;
    qryRelatedClientsChildCompany: TWideStringField;
    qryRelatedClientsCustomer: TWideStringField;
    qryRelatedClientsSupplier: TWideStringField;
    qryRelatedClientsOtherContact: TWideStringField;
    qryRelatedClientsmsTimeStamp: TDateTimeField;
    cboClientLookup: TERPQuery;
    cboClientLookupClientID: TIntegerField;
    cboClientLookupCompany: TWideStringField;
    cboClientLookupCustomer: TWideStringField;
    cboClientLookupsupplier: TWideStringField;
    cboClientLookupOthercontact: TWideStringField;
    cboClientLookupMarketingcontact: TWideStringField;
    qryMarketingContactsMedTypeID: TIntegerField;
    qryLeadLines: TERPQuery;
    qryLeadLinesActiontypeName: TWideStringField;
    qryLeadLinesActionDate: TDateTimeField;
    qryLeadLinesEmployeeName: TWideStringField;
    qryLeadLinesDone: TWideStringField;
    qryLeadLinesNotes: TWideMemoField;
    qryLeadLinesCreationDate: TDateTimeField;
    qryLeadLinesResultTypeName: TWideStringField;
    qryLeadLinesFollowUpDate: TDateTimeField;
    qryLeadLinesUpdateDate: TDateTimeField;
    qryLeadLinesGlobalRef: TWideStringField;
    qryLeadLinesLeadID: TIntegerField;
    qryLeadLinesLeadLineID: TIntegerField;
    qryLeadLinesActionType: TIntegerField;
    qryLeadLinesActionID: TIntegerField;
    qryLeadLinesFollowupID: TIntegerField;
    qryLeadLinesActionRef: TWideStringField;
    qryLeadLinesStatusID: TIntegerField;
    qryLeadLinesPriority: TIntegerField;
    qryLeadLinesEmployeeID: TIntegerField;
    qryLeadLinesDuration: TWideStringField;
    qryLeadLinesTypeId: TIntegerField;
    qryLeadLinesTypeName: TWideStringField;
    qryLeadLinesHours: TFloatField;
    qryLeadLinesResultTypeId: TIntegerField;
    qryLeadLinesIsPhoneFollowUp: TWideStringField;
    qryLeadLinesEntryCount: TIntegerField;
    qryLeadLinesCreatedByID: TIntegerField;
    qryLeadLinesIsMarketing: TWideStringField;
    qryLeadLinesIsLead: TWideStringField;
    qryLeadLinesmsTimeStamp: TDateTimeField;
    dsLeadLines: TDataSource;
    qryActionType: TERPQuery;
    qryActionTypeName: TWideStringField;
    qryActionTypeId: TIntegerField;
    qryActionTypeTypeCode: TWideStringField;
    qryActionTypeActive: TWideStringField;
    qryEmployee: TERPQuery;
    cboActionType: TwwDBLookupCombo;
    cboEmployee: TwwDBLookupCombo;
    edtActionDate: TwwDBDateTimePicker;
    grdFollowups: TwwDBGrid;
    grdFollowupsIButton: TwwIButton;
    qryLeads: TERPQuery;
    qryLeadsGlobalRef: TWideStringField;
    qryLeadsLeadID: TIntegerField;
    qryLeadsMarketingContactID: TIntegerField;
    qryLeadsClientID: TIntegerField;
    qryLeadsRepID: TIntegerField;
    qryLeadsEnteredByEmployeeID: TIntegerField;
    qryLeadsIsLead: TWideStringField;
    qryLeadsmsTimeStamp: TDateTimeField;
    qryLeadsCompany: TWideStringField;
    qryLeadsLeadStatus: TWideStringField;
    daLeads: TDataSource;
    DBMemo1: TDBMemo;
    Bevel1: TBevel;
    Label2: TLabel;
    cmdOk: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    cmdNew: TDNMSpeedButton;
    cmdPrint: TDNMSpeedButton;
    Label36: TLabel;
    qryMediaType: TERPQuery;
    cboSource: TwwDBLookupCombo;
    Label9: TLabel;
    txtEmpSize: TDBEdit;
    qryContacts: TERPQuery;
    DSContacts: TDataSource;
    qryCustomFields: TERPQuery;
    qryMarketingContactsClientID: TIntegerField;
    qryMarketingContactsCUSTFLD1: TWideStringField;
    qryMarketingContactsCUSTFLD2: TWideStringField;
    qryMarketingContactsCUSTFLD3: TWideStringField;
    qryMarketingContactsCUSTFLD4: TWideStringField;
    qryMarketingContactsCUSTFLD5: TWideStringField;
    qryMarketingContactsCUSTFLD6: TWideStringField;
    qryMarketingContactsCUSTFLD7: TWideStringField;
    qryMarketingContactsCUSTFLD8: TWideStringField;
    qryMarketingContactsCUSTFLD9: TWideStringField;
    qryMarketingContactsCUSTFLD10: TWideStringField;
    qryMarketingContactsCUSTFLD11: TWideStringField;
    qryMarketingContactsCUSTFLD12: TWideStringField;
    qryMarketingContactsCUSTFLD13: TWideStringField;
    qryMarketingContactsCUSTFLD14: TWideStringField;
    qryMarketingContactsCUSTFLD15: TWideStringField;
    qryMarketingContactsCUSTDATE1: TDateTimeField;
    qryMarketingContactsCUSTDATE2: TDateTimeField;
    qryMarketingContactsCUSTDATE3: TDateTimeField;
    cmdCopy: TDNMSpeedButton;
    qryCustomFieldsCFLabel1: TWideStringField;
    qryCustomFieldsCFLabel2: TWideStringField;
    qryCustomFieldsCFLabel3: TWideStringField;
    qryCustomFieldsCFLabel4: TWideStringField;
    qryCustomFieldsCFLabel5: TWideStringField;
    qryCustomFieldsCFLabel6: TWideStringField;
    qryCustomFieldsCFLabel7: TWideStringField;
    qryCustomFieldsCFLabel8: TWideStringField;
    qryCustomFieldsCFLabel9: TWideStringField;
    qryCustomFieldsCFLabel10: TWideStringField;
    qryCustomFieldsCFLabel11: TWideStringField;
    qryCustomFieldsCFLabel12: TWideStringField;
    qryCustomFieldsCFLabel13: TWideStringField;
    qryCustomFieldsCFLabel14: TWideStringField;
    qryCustomFieldsCFLabel15: TWideStringField;
    qryCustomFieldsCFLabel16: TWideStringField;
    qryCustomFieldsCFLabel17: TWideStringField;
    qryCustomFieldsCFLabel18: TWideStringField;
    qryCustomFieldsCFMC1: TWideStringField;
    qryCustomFieldsCFMC2: TWideStringField;
    qryCustomFieldsCFMC3: TWideStringField;
    qryCustomFieldsCFMC4: TWideStringField;
    qryCustomFieldsCFMC5: TWideStringField;
    qryCustomFieldsCFMC6: TWideStringField;
    qryCustomFieldsCFMC7: TWideStringField;
    qryCustomFieldsCFMC8: TWideStringField;
    qryCustomFieldsCFMC9: TWideStringField;
    qryCustomFieldsCFMC10: TWideStringField;
    qryCustomFieldsCFMC11: TWideStringField;
    qryCustomFieldsCFMC12: TWideStringField;
    qryCustomFieldsCFMC13: TWideStringField;
    qryCustomFieldsCFMC14: TWideStringField;
    qryCustomFieldsCFMC15: TWideStringField;
    qryCustomFieldsCFMC16: TWideStringField;
    qryCustomFieldsCFMC17: TWideStringField;
    qryCustomFieldsCFMC18: TWideStringField;
    qryContact: TERPQuery;
    qrySimpleTypes: TERPQuery;
    StringField4: TWideStringField;
    IntegerField2: TIntegerField;
    StringField5: TWideStringField;
    StringField6: TWideStringField;
    qryContactsGlobalRef: TWideStringField;
    qryContactsContactID: TIntegerField;
    qryContactsMarketingContactID: TIntegerField;
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
    qryContactsmsTimeStamp: TDateTimeField;
    qryContactsIsPrimarycontact: TWideStringField;
    qryContactGlobalRef: TWideStringField;
    qryContactContactID: TIntegerField;
    qryContactMarketingContactID: TIntegerField;
    qryContactCompany: TWideStringField;
    qryContactContactTitle: TWideStringField;
    qryContactContactFirstName: TWideStringField;
    qryContactContactSurName: TWideStringField;
    qryContactContactAddress: TWideStringField;
    qryContactContactAddress2: TWideStringField;
    qryContactContactAddress3: TWideStringField;
    qryContactContactCity: TWideStringField;
    qryContactContactState: TWideStringField;
    qryContactContactPcode: TWideStringField;
    qryContactContactCountry: TWideStringField;
    qryContactContactPH: TWideStringField;
    qryContactContactAltPH: TWideStringField;
    qryContactContactMOB: TWideStringField;
    qryContactContactFax: TWideStringField;
    qryContactContactEmail: TWideStringField;
    qryContactNotes: TWideStringField;
    qryContactEditedFlag: TWideStringField;
    qryContactActive: TWideStringField;
    qryContactCardNumber: TWideStringField;
    qryContactAccountNo: TWideStringField;
    qryContactJobTitle: TWideStringField;
    qryContactmsTimeStamp: TDateTimeField;
    qryContactIsPrimarycontact: TWideStringField;
    cboClientLookupcategory: TWideStringField;
    Label10: TLabel;
    qryRelatedClientsMarketingcontact: TWideStringField;
    qryContactsContactName: TWideStringField;
    qryMarketingcontactProducts: TERPQuery;
    dsMarketingcontactProducts: TDataSource;
    qryMarketingcontactProductsGlobalref: TWideStringField;
    qryMarketingcontactProductsID: TLargeintField;
    qryMarketingcontactProductsMarketingcontactId: TLargeintField;
    qryMarketingcontactProductsProductID: TLargeintField;
    qryMarketingcontactProductsProductName: TWideStringField;
    qryMarketingcontactProductsDescription: TWideStringField;
    qryMarketingcontactProductsActive: TWideStringField;
    qryMarketingcontactProductsmstimestamp: TDateTimeField;
    Label3: TLabel;
    Bevel3: TBevel;
    cboProductQry: TERPQuery;
    cboProductQryPARTNAME: TWideStringField;
    cboProductQryPartsDescription: TWideStringField;
    cboProductQryManuf: TWideStringField;
    cboProductQryType: TWideStringField;
    cboProductQryDept: TWideStringField;
    cboProductQryPARTSID: TIntegerField;
    cboProductQryPARTTYPE: TWideStringField;
    cboProductQryLatestCostPrice: TFloatField;
    cboProductQrySNTracking: TWideStringField;
    cboProductQryActive: TWideStringField;
    cboProductQryPreferedSupp: TWideStringField;
    cboProductQryPRODUCTGROUP: TWideStringField;
    cboProductQryINCOMEACCNT: TWideStringField;
    cboProductQryASSETACCNT: TWideStringField;
    cboProductQryCOGSACCNT: TWideStringField;
    cboProductQryBARCODE: TWideStringField;
    cboProductQryPRODUCTCODE: TWideStringField;
    cboProductQryTAXCODE: TWideStringField;
    cboProductQryBatch: TWideStringField;
    cboProductQryAutoBatch: TWideStringField;
    cboProductQryMultipleBins: TWideStringField;
    cboProductQrySpecialDiscount: TWideStringField;
    cboProductQryBuyQTY1: TIntegerField;
    cboProductQryBuyQTY2: TIntegerField;
    cboProductQryBuyQTY3: TIntegerField;
    cboProductQryCOST1: TFloatField;
    cboProductQryCOST2: TFloatField;
    cboProductQryCOST3: TFloatField;
    cboProductQrySellQTY1: TIntegerField;
    cboProductQrySellQTY2: TIntegerField;
    cboProductQrySellQTY3: TIntegerField;
    cboProductQryPRICE1: TFloatField;
    cboProductQryPRICE2: TFloatField;
    cboProductQryPRICE3: TFloatField;
    cboProductQryWHOLESALEPRICE: TFloatField;
    cboProductQryEditedFlag: TWideStringField;
    cboProductQryAvgCost: TFloatField;
    cboProductQryAttrib1Sale: TFloatField;
    cboProductQryAttrib2Sale: TFloatField;
    cboProductQryAttrib1SaleRate: TFloatField;
    cboProductQryDiscontinued: TWideStringField;
    cboProductR: TERPDbLookupCombo;
    grdProduct: TwwDBGrid;
    wwDBGrid1IButton: TwwIButton;
    ContactPh: TwwDBEdit;
    chkActive: TDBCheckBox;
    btnNewRelatedCustomer: TDNMSpeedButton;
    qryMarketingContactsCallPriority: TIntegerField;
    qryMarketingContactsDefaultContactMethod: TWideStringField;
    Label14: TLabel;
    wwDBComboBox1: TwwDBComboBox;
    cboDefaultContactMethod: TwwDBComboBox;
    Label15: TLabel;
    Bevel4: TBevel;
    qryMarketingContactsSkypeName: TWideStringField;
    txtSkypename: TDBEdit;
    Label4: TLabel;
    qryMarketingContactsConvertedDesc: TStringField;
    DBText1: TDBText;
    lblCreatedOn: TLabel;
    edtCreatedOn: TwwDBDateTimePicker;
    qryMarketingContactsCreatedOn: TDateTimeField;
    btnTelemarketing: TDNMSpeedButton;
    btnLead: TDNMSpeedButton;
    qryMarketingContactsDoNotContact: TWideStringField;
    qryMarketingContactsmsUpdateSiteCode: TWideStringField;
    chkDoNotContact: TDBCheckBox;
    Label16: TLabel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    cboPrintProductR: TERPDbLookupCombo;
    qryLeadsnotes: TWideStringField;
    qryLeadsCreatedOn: TDateTimeField;
    qryLeadsmsUpdateSiteCode: TWideStringField;
    procedure cboClientCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure qryRelatedClientsAfterInsert(DataSet: TDataSet);
    procedure cmdCustomLabelsOldClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mainPageChanging(Sender: TObject; var AllowChange: Boolean);
    procedure mainPageChange(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure cboenter(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure qrySuburbsBeforeOpen(DataSet: TDataSet);
    procedure txtEmpSizeKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure SuburbCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure BillSuburbCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cmdCopyClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure Openmarketingcontactcontact(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cboRepCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure qryContactAfterInsert(DataSet: TDataSet);
    procedure qryContactsCalcFields(DataSet: TDataSet);
    procedure cboProductQryAfterOpen(DataSet: TDataSet);
    procedure cboProductRNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: String; var Accept: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cboProductRCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure wwDBGrid1IButtonClick(Sender: TObject);
    procedure grdProductDblClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure mainPageResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnNewRelatedCustomerClick(Sender: TObject);
    procedure wwIButton2Click(Sender: TObject);
    procedure cboCompanyTypeNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
    procedure wwIButton1Click(Sender: TObject);
    procedure grdFollowupsIButtonClick(Sender: TObject);
    procedure qryMarketingContactsCalcFields(DataSet: TDataSet);
    procedure DBText1Click(Sender: TObject);
    procedure btnTelemarketingClick(Sender: TObject);
    procedure btnLeadClick(Sender: TObject);
    procedure qryMarketingContactsAfterOpen(DataSet: TDataSet);
    procedure grdContactDblClick(Sender: TObject);
  private
    MCFOpened:Boolean;
    RealignTabInProgress: boolean;
    NewRelatedCustomerClicked:boolean;


    function SaveData:Boolean;
    Procedure Callcontactform(Sender:TDNMSpeedbutton);
    function contactform :TfmMarketingContactcotnact;
    function ChkCustReqdFields: boolean;
    Procedure AddNEwRelatedContact(Sender: TObject);
    procedure GlobalEventHandler(const Sender: TObject; const Event: string; const Data: Pointer);
    Procedure initMarketingform(Sender :TObject);
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure CustomFieldsRefresh;Override;
    function GetKeyString: string; override;
    procedure SetKeyString(const Value: string); override;
    function SaveOrCancelChanges: boolean;override;
    procedure KeyIdChanged(const NewKeyId: integer); Override;
    Procedure InitERPLookupCombonFields; Override;
  public
    MC:TMarketingContact;
    MCF:TLeads;
    procedure UpdateMe(const Canceled: Boolean; const aObject: TObject = nil);override;
    procedure UpdateMe; overload; override;
    Procedure AfterPopupformshow;Override;
  end;


implementation

uses CommonLib, frmCustomFieldsFrm, FastFuncs, AppEnvironment,
  EmployeeObj, BusObjConst, CommonDbLib, DNMLib, FormFactory, frmContactFrm,
   frmPartsFrm, CommonFormLib, MarketingRelatedClientSelectionList, GlobalEventsObj,
  BusObjSimpleTypes, tcDataUtils, tcConst, frmMarketing, frmMarketingLead;

{$R *.dfm}
procedure TfmMarketingContact.cboClientCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  MC.RelatedContacts.ChildCompany     :=cboClient.LookupTable.FieldByName('Company').AsString;
  MC.RelatedContacts.ChildContactID   :=cboClient.LookupTable.FieldByName('clientID').asInteger;
  MC.RelatedContacts.Customer         := cboClient.LookupTable.FieldByName('Customer').asBoolean;
  MC.RelatedContacts.Supplier         :=    cboClient.LookupTable.FieldByName('supplier').asBoolean;
  MC.RelatedContacts.Othercontact     := cboClient.LookupTable.FieldByName('Othercontact').asBoolean;
  MC.RelatedContacts.Marketingcontact := cboClient.LookupTable.FieldByName('Marketingcontact').asBoolean;
end;

procedure TfmMarketingContact.cboCompanyTypeNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
var
  CoType: TCompanyType;
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('This value not found in the list. Do you want to create a new one?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
  begin
    Accept := false;
    Exit;
  end;
  CoType:= TCompanyType.Create(nil);
  try
    CoType.Connection := TMyDacDataConnection.Create(CoType);
    CoType.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
    try
      CoType.Load(0);
      CoType.New;
      CoType.TypeName := NewValue;
      if not CoType.Save then begin
        CommonLib.MessageDlgXP_Vista('Could not create new value', mtWarning, [mbOk], 0);
        Accept:= false;
      end;
    except
      on e: exception do begin
        CommonLib.MessageDlgXP_Vista('Could not create new value: ' + e.Message, mtWarning, [mbOk], 0);
        Accept:= false;
      end;
    end;
  finally
    CoType.Free;
  end;
end;

procedure TfmMarketingContact.qryRelatedClientsAfterInsert(
  DataSet: TDataSet);
begin
  inherited;
  qryRelatedClientsMasterContactID.AsInteger := qryMarketingContactsId.asInteger;
  qryRelatedClientsMasterCompany.AsString := qryMarketingContactscompany.asString;

end;

procedure TfmMarketingContact.cmdCustomLabelsOldClick(Sender: TObject);
begin
  OpenCustomFields;
end;

procedure TfmMarketingContact.FormShow(Sender: TObject);
begin
  inherited;
  SetTransconenctiontoQueries;
  if Assigned(self.TransConnection) then
    MC.Connection.Connection := self.TransConnection;

  MC.Load(KeyId);

  MC.Connection.BeginTransaction;
  if KeyId = 0 then begin
      MC.New;
      MC.PostDB;// to get the ID for related contacts
      KeyId := MC.ID;
  end else if not mc.lock then begin
    accesslevel := 5;
    MessageDlgXP_Vista(replacestr(MC.userlock.LockMessage , 'Unable to update data.' , 'Access changed To Read Only.') , mtWarning, [mbok] , 0);
  end;
  MC.RelatedContacts;
  MC.MarketingContactContacts;
  MC.MarketingcontactProducts;

  closeDb(qryContacts);

  qryContacts.SQL.text := 'SELECT * ' +
                            ' FROM tblMarketingcontactContacts ' +
                            ' WHERE MarketingcontactID= ' + IntToStr(MC.ID);




  OpenDB(cboClientLookup);
  OpenDB(qryEmp);
  OpenDB(qrySuburbs);
  OpenDB(qryMediaType);
  OpenDB(qryEmployee);
  OpenDB(qryActionType);
  OpenDB(qryContacts);
  opendb(qryCompanyType);
  opendb(cboProductQry);
  opendb(qryRelatedClients);
  CustomFieldsRefresh;

  mainPage.ActivePageIndex := 0;
  SetControlFocus(edtTitle);
  MC.EditDB;
  GuiPrefs.DbGridElement[grdProduct].RemoveFields('GlobalRef,ID,MarketingContactId,ProductID,mstimestamp');
  GuiPrefs.DbGridElement[grdContact].RemoveFields('GlobalRef,ContactID,MarketingContactID,msTimeStamp,EditedFlag');
  GuiPrefs.DbGridElement[grdFollowups].RemoveFields('GlobalRef,LeadID,LeadLineID,ActionID,EmployeeID,TypeID,ResultTypeId,CreatedByID,StatusID,msTimestamp');
end;

function TfmMarketingContact.GetKeyString: string;
begin
  if qryMarketingContacts.Active then
    result:= qryMarketingContactsCOMPANY.AsString
  else
    result:= '';
end;

procedure TfmMarketingContact.FormCreate(Sender: TObject);
begin
  AddPhoneCallbutton(txtContactAltPH);
  AddPhoneCallbutton(ContactMOB);
  AddPhoneCallbutton(ContactPh);
  NewRelatedCustomerClicked := False;
  AllowCustomiseGrid := true;
  ExcludeGridfromcustomize(grdRelatedClient);
  inherited;
  MC:= TMarketingContact.create(Self);
  MC.connection := TMyDacDataConnection.create(MC);
  MC.Connection.Connection := Self.MyConnection;
  MCF:= TLeads.create(Self);
  MCF.Connection := MC.Connection;
  MCF.BusObjEvent := DoBusinessObjectEvent;
  MC.BusObjEvent := DoBusinessObjectEvent;
  MCFOpened := False;

  GlobalEvents.RegisterNameHandler(Self, 'TMarketingRelatedClientSelectionListGUI', '', GEVENT_ListClosed, GlobalEventHandler);
end;

procedure TfmMarketingContact.DBText1Click(Sender: TObject);
begin
  inherited;
  if qryMarketingContactsclientId.asInteger = 0 then
  else if Sametext(qryMarketingContactsConvertedDesc.asString , 'Has Been Converted'+ NL+ 'Customer') then OpenERPForm('TfrmCustomer'     ,qryMarketingContactsclientId.AsInteger )
  else if Sametext(qryMarketingContactsConvertedDesc.asString , 'Has Been Converted'+ NL+ 'Job'     ) then OpenERPForm('TJobGUI'          ,qryMarketingContactsclientId.AsInteger )
  else if Sametext(qryMarketingContactsConvertedDesc.asString , 'Has Been Converted'+ NL+ 'Supplier') then OpenERPForm('TfmSupplier'     ,qryMarketingContactsclientId.AsInteger )
  else if Sametext(qryMarketingContactsConvertedDesc.asString , 'Has Been Converted'+ NL+ 'Prospect') then OpenERPForm('TfrmOtherContact' ,qryMarketingContactsclientId.AsInteger );
end;

procedure TfmMarketingContact.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
      if Sender is TMarketingContact then TMarketingContact(Sender).Dataset := qryMarketingContacts
      else if Sender is TLeads then
        TLeads(Sender).dataset := qryLeads
      else if Sender is TLeadLines then
        TLeadLines(Sender).dataset := qryLeadLines
      else if Sender is TRelatedContacts then TRelatedContacts(Sender).Dataset := qryRelatedClients
      else if Sender is TMarketingContactProduct then TMarketingContactProduct(Sender).Dataset := qryMarketingcontactProducts
      else if sender is TMarketingContactContact then TMarketingContactContact(SendeR).dataset := qryContact;
  end;
end;

procedure TfmMarketingContact.mainPageChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
  MC.PostDB;
  if mc.count = 0 then allowchange := False;
end;

procedure TfmMarketingContact.mainPageChange(Sender: TObject);
begin
  inherited;
  if mainPage.ActivePage = tabFollowUp then begin
      MC.PostDB;
      if not MCFOpened then begin
        MCF.LoadSelect('MarketingContactID = ' +IntToStr(MC.ID));
        if MCF.count = 0 then begin
          MCF.new;
          MCF.MarketingContactID := MC.ID;
          MCF.Company := MC.COMPANY;
          MCF.ClientID := Mc.ClientID;
          MCF.EnteredByEmployeeID := AppEnv.Employee.EmployeeID;
          MCF.IsLead := False;
          MCF.PostDB;
        end;
        MCF.Lines.new;
        MCF.Lines.postdb;
        MCFOpened := true;
      end;
  end else if mainPage.ActivePage = tabContacts then begin
      MC.PostDB;
      MC.Save;
      closedb(qryContacts);
      opendb(qryContacts);
  end;
end;

procedure TfmMarketingContact.CustomFieldsRefresh;
begin
CustomFieldRefresh('CFMC' ,pnlCustFields);
end;
function TfmMarketingContact.ChkCustReqdFields: boolean;
begin
  Result := ChkReqdFields('MC');
  if not Result then mainPage.ActivePage := Custom_Fields;
end;

procedure TfmMarketingContact.UpdateMe(const Canceled: Boolean;
  const aObject: TObject);
begin
  inherited;
    if Assigned(fLastComboAccessed) then begin
      if (Sysutils.SameText(fLastComboAccessed.Name, 'Suburb')) then begin
          fLastComboAccessed.LookupTable.Close;
          fLastComboAccessed.LookupTable.Open;
          SetFocusedControl(fLastComboAccessed);
          fLastComboAccessed.Text :=  combonotInlistValue;
          if fLastComboAccessed.LookupTable.Locate(fLastComboAccessed.LookupField, combonotInlistValue , [loCaseInsensitive]) then begin
              SuburbCloseUp(Suburb,qrySuburbs , nil, True);
          end;
      end;
    end;

end;

procedure TfmMarketingContact.cmdOkClick(Sender: TObject);
begin
  inherited;
  DisableForm;
  try
    if SaveData then begin
      Mc.Connection.CommitTransaction;
      Notify(False);
      if fsModal in FormState then begin
          ModalResult := mrOk;
        end else begin
          Self.Close;
        end;

    end;
  finally
    EnableForm;
  end;

end;

function TfmMarketingContact.SaveData: Boolean;
begin
  MC.PostDB;
  MCF.PostDB;
  MC.Relatedcontacts.PostDB;
  PostDB(qryLeadLines);
  Result := ChkCustReqdFields;
  if not Result then Exit;
  result := MC.Save;
end;

procedure TfmMarketingContact.SetKeyString(const Value: string);
begin
  SetKeyString(TMarketingContact, qryMarketingContacts, Value , 'COMPANY');
end;

procedure TfmMarketingContact.cboenter(Sender: TObject);
begin
  inherited;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
end;

procedure TfmMarketingContact.UpdateMe;
begin
  inherited;
  UpdateMe(False, nil);
end;
function TfmMarketingContact.SaveOrCancelChanges: boolean;
begin
  Result := True;
  case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if MC.Save then begin
            MC.Connection.CommitTransaction;
            result := TRue;
            Notify(False);
          end;
        end;
      mrNo:
        begin
          MC.Connection.RollbackTransaction;
          MC.Dirty := false;
          Result := true;
          Notify(true);
        end;
      mrCancel:
        begin
          REsult := false;
        end;
    end;
end;
procedure TfmMarketingContact.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ErrorOccurred then Exit;
  CanClose := false;
  if MC.Dirty then begin
    Canclose:= SaveOrCancelChanges;
  end else begin
    CanClose := true;
  end;

end;

procedure TfmMarketingContact.qrySuburbsBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qrySuburbs.Params.ParamByName('xRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

procedure TfmMarketingContact.txtEmpSizeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if ((Key <> #8) and ((Key < '0') or (Key > '9'))) then begin
    Key := #0;
  end;
end;

procedure TfmMarketingContact.FormActivate(Sender: TObject);
begin
  inherited;
  if not Self.ErrorOccurred then begin
      SetControlFocus(edtTitle);
  end;
end;

procedure TfmMarketingContact.SuburbCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
  if Modified then begin
    MC.State   := LookupTable.FieldByName('State').AsString;
    MC.Postcode:= LookupTable.FieldByName('Postcode').AsString;
    MC.Country := LookupTable.FieldByName('Country').asString;
  end;
end;

procedure TfmMarketingContact.BillSuburbCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
  if Modified then begin
    MC.billState   := LookupTable.FieldByName('State').AsString;
    MC.BillPostcode:= LookupTable.FieldByName('Postcode').AsString;
    MC.BillCountry := LookupTable.FieldByName('Country').asString;
  end;
end;

procedure TfmMarketingContact.cmdCopyClick(Sender: TObject);
begin
  with MC do begin
    BillStreet    := Street;
    BillStreet2   := Street2;
    BillStreet3   := Street3;
    BillSuburb    := Suburb;
    BillState     := State;
    BillPostCode  := PostCode;
    BillCountry   := Country;
    PostDB;
  end;
end;

procedure TfmMarketingContact.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmMarketingContact.cmdCancelClick(Sender: TObject);
begin
  inherited;
  if fsModal in FormState then begin
    ModalResult := mrCancel;
  end else begin
    Self.Close;
  end;
end;

procedure TfmMarketingContact.cmdNewClick(Sender: TObject);
begin
  inherited;
  if MC.Save = False then exit;
  MC.Connection.CommitTransaction;
  MC.Connection.begintransaction;
  MC.New;
  mainpage.ActivePageindex := 0;
  SetControlFocus(edtTitle);
end;

procedure TfmMarketingContact.Openmarketingcontactcontact(Sender: TObject);
begin
  DisableForm;
  try
    Callcontactform(TDNMSpeedButton(Sender));
  finally
    EnableForm;
  end;
end;
procedure TfmMarketingContact.Callcontactform(Sender: TDNMSpeedbutton);
var
  form : TComponent;
begin
  MC.PostDB;
  MC.Connection.BeginNestedTransaction;
  try
    form := contactform;
    try
      if Assigned(form) then
        with TfmMarketingContactcotnact(form) do begin
          AttachObserver(self);
          MCID := MC.ID;
          if sender = EditBtn then begin
            KeyID:= Self.Qrycontacts.fieldbyname('contactID').asInteger;
          end;
          lblCustType.Caption := mc.CompanyTypeName;
          if Showmodal = mrOk then begin
            MC.Connection.CommitNestedTransaction;
            CloseDB(self.QryContacts);
            OpenDB(self.QryContacts);
          end else begin
            MC.Connection.RollbackNestedTransaction;
          end;
        end;
    finally
      Freeandnil(Form);
    end;
  except
    MC.Connection.RollbackNestedTransaction;
  end;
end;

function TfmMarketingContact.contactform: TfmMarketingContactcotnact;
begin
    result := TfmMarketingContactcotnact.create(nil);
    result.TransConnection := Self.MyConnection;
end;


procedure TfmMarketingContact.FormDestroy(Sender: TObject);
begin
  FreeandNil(MC);
  inherited;
end;

procedure TfmMarketingContact.cboRepCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  Mc.REPNAME := qryEmp.fieldByname('EmployeeName').AsString;
  MC.REPID := qryEmp.fieldByname('EmployeeID').asInteger;
end;

procedure TfmMarketingContact.qryContactAfterInsert(DataSet: TDataSet);
begin
  inherited;
  MC.PostDB;
  Mc.MarketingContactContacts.MarketingContactID:= MC.ID;
end;

procedure TfmMarketingContact.qryContactsCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryContactsContactName.asString := Trim(qryContactsContactFirstName.AsString) +' ' + Trim(qryContactsContactSurName.asString); 
end;

procedure TfmMarketingContact.qryMarketingContactsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if (MC.Count =0) or (not(MC.HasTelemarketing)) then btnTelemarketing.hint:= 'Make a New Telemarketing' else btnTelemarketing.hint:= 'Open Telemarketing';
  if (MC.Count =0) or (not(MC.HasLead))          then btnLead.hint         := 'Make a New Lead'          else btnLead.hint         := 'Open Lead';
end;

procedure TfmMarketingContact.qryMarketingContactsCalcFields(DataSet: TDataSet);
begin
  inherited;
  if qryMarketingContactsclientId.asInteger = 0 then
    qryMarketingContactsConvertedDesc.asString := ''
  else case Clienttype(qryMarketingContactsclientId.AsInteger) of
    ttcustomer    : qryMarketingContactsConvertedDesc.asString := 'Has Been Converted'+ NL+ 'Customer';
    ttJob         : qryMarketingContactsConvertedDesc.asString := 'Has Been Converted'+ NL+ 'Job';
    ttSupplier    : qryMarketingContactsConvertedDesc.asString := 'Has Been Converted'+ NL+ 'Supplier';
    ttOthercontact: qryMarketingContactsConvertedDesc.asString := 'Has Been Converted'+ NL+ 'Prospect';
    else qryMarketingContactsConvertedDesc.asString := '';
  end;
end;

procedure TfmMarketingContact.cboProductQryAfterOpen(DataSet: TDataSet);
begin
  inherited;
  cboProductQry.IndexFieldNames := QuotedStr('PartName') + ' ASC CIS ; ' + QuotedStr('PartType') + ' ASC CIS';
end;

procedure TfmMarketingContact.cboProductRNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
var
  frm: TBaseInputGUI;
begin
  if cboProductR.LookupTable.RecordCount <> 0 then begin
    frm    := nil;
    Accept := false;
    if CommonLib.MessageDlgXP_Vista('Product not found in list. Would you like to create this Product?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      try
        if TfrmParts.FormActive then begin
          TfrmParts.CloseMe;
        end;

        frm := TfrmParts(GetComponentByClassName('TfrmParts'));
        if assigned(frm) then begin
            TfrmParts(frm).fsPartName := NewValue;
            frm.Position := poScreenCenter;
            frm.ShowModal;
        end;
      finally
        cboProductQry.Close;
        cboProductQry.Open;
        if not Empty(TfrmParts(frm).fsPartName) then begin
          if cboProductQry.Locate('PartName', TfrmParts(frm).fsPartName, [loCaseInsensitive]) then begin
            cboProductR.Text := TfrmParts(frm).fsPartName;
            cboProductR.PerformSearch;
          end;
          Accept := true;
        end;
      end;
    end;
  end;
end;

procedure TfmMarketingContact.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if ((Key = VK_ESCAPE) or (key = 0)) and (ActiveControl = cboProductR) then
    cboProductR.Text:= '';
end;

procedure TfmMarketingContact.cboProductRCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  MC.MarketingContactProducts.ProductID := cboProductQryPARTSID.asInteger;
  MC.MarketingContactProducts.ProductName := cboProductQryPARTNAME.asString;
  MC.MarketingContactProducts.PostDB;
end;

procedure TfmMarketingContact.wwDBGrid1IButtonClick(Sender: TObject);
begin
  inherited;
  if MC.MarketingContactProducts.Active  then begin
      if CommonLib.MessageDlgXP_Vista('Do you wish to delete this product for ' +MC.COMPANY+'?' , mtConfirmation , [mbyes, mbNo] , 0) = mrYes then begin
        MC.MarketingContactProducts.Active := false;
        MC.MarketingContactProducts.PostDB;
      end;
  end;

end;

procedure TfmMarketingContact.wwIButton1Click(Sender: TObject);
begin
  inherited;
  if MC.MarketingContactContacts.Count > 0 then begin
    if CommonLib.MessageDlgXP_Vista('Do you wish to delete this contact: ' + self.qryContactsContactName.AsString + '?' , mtConfirmation , [mbyes, mbNo] , 0) = mrYes then begin
      qryContacts.Delete;
      MC.FlagAsUpdated();
      MC.MarketingContactContacts.RefreshDB;
    end;
  end;
end;

procedure TfmMarketingContact.wwIButton2Click(Sender: TObject);
begin
  inherited;
  if MC.RelatedContacts.Count > 0 then begin
    if CommonLib.MessageDlgXP_Vista('Do you wish to delete the related customer: ' +MC.RelatedContacts.ChildCompany+'?' , mtConfirmation , [mbyes, mbNo] , 0) = mrYes then begin
      MC.RelatedContacts.Delete;
      MC.FlagAsUpdated();
    end;
  end;
end;

procedure TfmMarketingContact.grdContactDblClick(Sender: TObject);
begin
  inherited;
  if qryContactsContactID.asinteger <> 0 then
    Openmarketingcontactcontact(EditBtn);
end;

procedure TfmMarketingContact.grdFollowupsIButtonClick(Sender: TObject);
begin
  inherited;
  if self.MCF.Lines.Count > 0 then begin
    if CommonLib.MessageDlgXP_Vista('Do you wish to delete this Followup?', mtConfirmation , [mbyes, mbNo] , 0) = mrYes then begin
      MCF.Lines.Delete;
      MCF.FlagAsUpdated();
    end;
  end;
end;

procedure TfmMarketingContact.grdProductDblClick(Sender: TObject);
begin
  inherited;
  if MC.MarketingContactProducts.Active = False then begin
      if CommonLib.MessageDlgXP_Vista('Do you wish to restore this product for  ' +MC.COMPANY+'?' , mtConfirmation , [mbyes, mbNo] , 0) = mrYes then begin
        MC.MarketingContactProducts.Active := True;
        MC.MarketingContactProducts.PostDB;
      end;
  end;
end;

procedure TfmMarketingContact.initMarketingform(Sender: TObject);
begin
  if sender is TfmMarketing then
    TfmMarketing(Sender).MarketingContactName := MC.Company
  else if sender is TfmMarketingLead then
    TfmMarketingLead(Sender).MarketingContactName := MC.Company;
end;

procedure TfmMarketingContact.KeyIdChanged(const NewKeyId: integer);
begin
  inherited;

end;

procedure TfmMarketingContact.cmdPrintClick(Sender: TObject);
var
  sSQL: string;
begin
  DisableForm;
  try
    if not MC.Save then Exit;
    MC.Connection.CommitTransaction; 

    Application.ProcessMessages;

    sSQL := '';
    fbReportSQLSupplied := true;

    PrintTemplateReport('Other Contact', sSQL, false, 1);
    fbReportSQLSupplied := false;
  finally
    EnableForm;
  end;
end;

procedure TfmMarketingContact.mainPageResize(Sender: TObject);
begin
  inherited;
  if not RealignTabInProgress then begin
    RealignTabInProgress := true;
    if not self.IsFlag('FormInitialising') then
      RealignTabControl(mainPage, 2);
    if mainPage.TabWidth > 130 then mainPage.TabWidth := mainPage.TabWidth - 1;
    RealignTabInProgress := false;
  end;
end;

procedure TfmMarketingContact.FormResize(Sender: TObject);
begin
  inherited;
  if not self.IsFlag('FormInitialising') then
    RealignTabControl(mainPage, 4);
end;

procedure TfmMarketingContact.btnLeadClick(Sender: TObject);
begin
  inherited;
  if not SaveData then exit;
  Mc.Connection.CommitTransaction;
  Mc.Dirty := False;
  Mc.Connection.BeginTransaction;
  if fsModal in FormState then begin
    OpenERPFormModal('TfmMarketingLead',0 , initMarketingform);
  end else begin
    OpenERPForm('TfmMarketingLead',0 , nil, initMarketingform);
  end;
  if fsModal in FormState then begin
    ModalResult := mrOk;
  end else begin
    Self.Close;
  end;

end;

procedure TfmMarketingContact.btnNewRelatedCustomerClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormultiselect('TMarketingRelatedClientSelectionListGUI' , AddNEwRelatedContact);
  NewRelatedCustomerClicked := True;
end;
procedure TfmMarketingContact.btnTelemarketingClick(Sender: TObject);
begin
  inherited;
  if not SaveData then exit;
  Mc.Connection.CommitTransaction;
  Mc.Connection.BeginTransaction;
  if fsModal in FormState then begin
    OpenERPFormModal('TfmMarketing',0 , initMarketingform);
  end else begin
    OpenERPForm('TfmMarketing',0 , nil, initMarketingform);
  end;
  if fsModal in FormState then begin
    ModalResult := mrOk;
  end else begin
    Self.Close;
  end;
end;

procedure TfmMarketingContact.GlobalEventHandler(const Sender: TObject;  const Event: string; const Data: Pointer);
begin
  if (sameText(Event , GEVENT_ListClosed)) and (Sender.Classnameis('TMarketingRelatedClientSelectionListGUI')) and (NewRelatedCustomerClicked) then begin
      AddNEwRelatedContact(Sender);
      NewRelatedCustomerClicked:= False;
  end;
end;
procedure TfmMarketingContact.AddNEwRelatedContact(Sender: TObject);
var
  i:Integer;
  form : TMarketingRelatedClientSelectionListGUI;
begin
    form := nil;
    if ( (Sender is TMarketingRelatedClientSelectionListGUI)) then form := TMarketingRelatedClientSelectionListGUI(Sender)
    else if  ((Sender is TDNMSpeedButton)  and
             (assigned(TDNMSpeedButton(sender).owner))  and
             (TDNMSpeedButton(sender).owner is TMarketingRelatedClientSelectionListGUI))  then form :=TMarketingRelatedClientSelectionListGUI(TDNMSpeedButton(sender).owner);
    if form=nil then exit;

    With Form.Qrymain do begin
        for i := 0 to Form.grdmain.SelectedList.Count - 1 do begin
          GotoBookmark(Form.grdmain.SelectedList.Items[i]);
          if (fieldbyname('ClientID').asInteger <> 0) and (fieldbyname('ClientID').asInteger <> MC.ID) then begin
            if MC.RelatedContacts.Locate('ChildContactID;Customer;Supplier;Othercontact;Marketingcontact' ,
              Vararrayof([Fieldbyname('ClientID').asInteger,
                          Fieldbyname('Customer').AsBoolean,
                          Fieldbyname('Supplier').AsBoolean,
                          Fieldbyname('Othercontact').AsBoolean,
                          Fieldbyname('Marketingcontact').AsBoolean]), []) then
            else begin
              MC.RelatedContacts.New;
              MC.RelatedContacts.ChildCompany     := FieldByName('Company').AsString;
              MC.RelatedContacts.ChildContactID   := FieldByName('clientID').asInteger;
              MC.RelatedContacts.Customer         := FieldByName('Customer').asBoolean;
              MC.RelatedContacts.Supplier         := FieldByName('supplier').asBoolean;
              MC.RelatedContacts.Othercontact     := FieldByName('Othercontact').asBoolean;
              MC.RelatedContacts.Marketingcontact := FieldByName('Marketingcontact').asBoolean;
              MC.RelatedContacts.PostDB;
            end;
          end;
        end;
    end;
end;

procedure TfmMarketingContact.AfterPopupformshow;
begin
  inherited;
  if Sysutils.SameText(CallingClassName , 'TContactListGUI') then
    mainPage.Activepage := tabContacts;
end;
procedure TfmMarketingContact.InitERPLookupCombonFields;
begin
  inherited;
  SetupProductNamenPrintNameinGrid(cboProductR ,cboPrintProductR ,'ProductName' , 'ProductPrintName' , 'PARTSDESCRIPTION' , grdProduct );
end;

initialization
  RegisterClassOnce(TfmMarketingContact);
  with FormFact do begin
    RegisterMe(TfmMarketingContact, 'TMarketingContactRawListGUI_*=ID');
    RegisterMe(TfmMarketingContact, 'TGoogleLeadsGUI_*=ID');
    RegisterMe(TfmMarketingContact, 'TMarketingContactGUI_Company=ID');
    RegisterMe(TfmMarketingContact, 'TMarketingGUI_Company=ID');
    RegisterMe(TfmMarketingContact, 'TMarketingContactListGUI_*_MC=ID');
    RegisterMe(TfmMarketingContact, 'TClientsandMarketingcontactsListGUI_*_MC=ID');

    RegisterMe(TfmMarketingContact, 'TMarketingContactGUI_firstname=ID');
    RegisterMe(TfmMarketingContact, 'TMarketingContactGUI_LastName=ID');
    RegisterMe(TfmMarketingContact, 'TMarketingContactListDetailGUI_Company=ID');
    RegisterMe(TfmMarketingContact, 'TMarketingContactListDetailGUI_firstname=ID');
    RegisterMe(TfmMarketingContact, 'TMarketingContactListDetailGUI_LastName=ID');
    RegisterMe(TfmMarketingContact, 'TGlobalListSearchFrm_*_Marketing Contact=ID');
    RegisterMe(TfmMarketingContact, 'TGlobalListSearchFrm_*_Marketing Contact(Contact)=ID');
    RegisterMe(TfmMarketingContact, 'TGlobalListSearchFrm_*_Marketing Contact(Primary Contact)=ID');
    RegisterMe(TfmMarketingContact, 'TGlobalListFrm_*_Marketing Contact=ID');
    RegisterControl(TfmMarketingContact, 'TfmMarketingLead_cbomarketingcontact=ID');
    RegisterMe(TfmMarketingContact, 'TMarketingLeadsGUI_Company=Company');
    RegisterMe(TfmMarketingContact, 'TMarketingGUI_Company=ID');
    RegisterMe(TfmMarketingContact, 'TMarketingRelatedClientSelectionListGUI_*_Marketing Contact=ClientID');
    RegisterMe(TfmMarketingContact, 'TMarketingContactcontactListGUI_*=MarketingContactID');
    RegisterMe(TfmMarketingContact, 'TMarketingContactProductListGUI_*=ID');
    RegisterMe(TfmMarketingContact, 'TGlobalsearchGUI_*_Marketing contact=ID');
  end;

end.



