unit frmOtherContactFrm;

{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 12/04/05  1.00.01 IJB  Changed to allow addition of Company Types on the fly.
 03/06/05  1.00.02 BJ   If the company name is duplicate, changing the tab
                        is causing a run time error -> fixed
 04/07/05  1.00.05 IJB Enabled UserLock object in form create to stop more than
                       one user editing the same OtherContact at one time.
 26/08/05  1.00.12 BJ  SetContractDefaults sets the defualt values for the new
                        contract record
 20/10/05  1.00.13 DLS  Added RegisterClass
 23/12/05  1.00.14 AL   Added button next to phone number
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, StdCtrls, Mask, DBCtrls, ExtCtrls, DBCGrids, ComCtrls,AdvOfficeStatusBar,
  BaseInputForm, Grids, jpeg, wwdblook, DNMPanel, Buttons, DNMSpeedButton, BaseListingForm,
  wwdbdatetimepicker, Wwdbigrd, Wwdbgrid, wwcheckbox, wwriched, kbmMemTable,BusObjBase,
  wwdbedit, Wwdotdot, Wwdbcomb, OleServer, Word2000, Variants, MemDS,BusObjProspectFollowUps,
  DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, DataState, Menus, AdvMenus, Shader,
  ImgList, WordXP, ProgressDialog,frmClient;

type
  TfrmOtherContact = class(TfmClient)
    frmCustomerSrc: TDataSource;
    TabCtl20: TPageControl;
    Customer_Info: TTabSheet;
    Address_Info: TTabSheet;
    FollowUpSrc: TDataSource;
    Custom_Fields: TTabSheet;
    cmdCustomLabels: TDNMSpeedButton;
    chkActive: TDBCheckBox;
    Label36: TLabel;
    cmdNew: TDNMSpeedButton;
    txtCusID: TDBEdit;
    cmdPrint: TDNMSpeedButton;
    txtCompany: TDBMemo;
    qryCustomers: TERPQuery;
    qryFollowUp: TERPQuery;
    DNMPanel1: TDNMPanel;
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
    Company: TDBEdit;
    Title: TDBEdit;
    FirstName: TDBEdit;
    LastName: TDBEdit;
    Phone: TwwDBEdit;
    FaxNumber: TwwDBEdit;
    MOB: TwwDBEdit;
    AltPhone: TwwDBEdit;
    DNMPanel2: TDNMPanel;
    Box41: TBevel;
    Box83: TBevel;
    Label180: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label42: TLabel;
    Label78: TLabel;
    lblPostCode: TLabel;
    lblState: TLabel;
    lblBillSuburb: TLabel;
    lblBillState: TLabel;
    lblBillPostcode: TLabel;
    Street: TDBEdit;
    Street2: TDBEdit;
    State: TDBEdit;
    Postcode: TDBEdit;
    BillStreet: TDBEdit;
    BillState: TDBEdit;
    BillPostcode: TDBEdit;
    Suburb: TwwDBLookupCombo;
    BillSuburb: TwwDBLookupCombo;
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
    cmdCustomLabelsOld: TDNMSpeedButton;
    qryCustomFields: TERPQuery;
    qryCustomFieldsCFLabel1: TWideStringField;
    qryCustomFieldsCFCust1: TWideStringField;
    qryCustomFieldsCFEmpl1: TWideStringField;
    qryCustomFieldsCFSupp1: TWideStringField;
    qryCustomFieldsCFLabel2: TWideStringField;
    qryCustomFieldsCFCust2: TWideStringField;
    qryCustomFieldsCFEmpl2: TWideStringField;
    qryCustomFieldsCFSupp2: TWideStringField;
    qryCustomFieldsCFLabel3: TWideStringField;
    qryCustomFieldsCFCust3: TWideStringField;
    qryCustomFieldsCFEmpl3: TWideStringField;
    qryCustomFieldsCFSupp3: TWideStringField;
    qryCustomFieldsCFLabel4: TWideStringField;
    qryCustomFieldsCFCust4: TWideStringField;
    qryCustomFieldsCFEmpl4: TWideStringField;
    qryCustomFieldsCFSupp4: TWideStringField;
    qryCustomFieldsCFLabel5: TWideStringField;
    qryCustomFieldsCFCust5: TWideStringField;
    qryCustomFieldsCFEmpl5: TWideStringField;
    qryCustomFieldsCFSupp5: TWideStringField;
    qryCustomFieldsCFLabel6: TWideStringField;
    qryCustomFieldsCFCust6: TWideStringField;
    qryCustomFieldsCFEmpl6: TWideStringField;
    qryCustomFieldsCFSupp6: TWideStringField;
    qryCustomFieldsCFLabel7: TWideStringField;
    qryCustomFieldsCFCust7: TWideStringField;
    qryCustomFieldsCFEmpl7: TWideStringField;
    qryCustomFieldsCFSupp7: TWideStringField;
    qryCustomFieldsCFLabel8: TWideStringField;
    qryCustomFieldsCFCust8: TWideStringField;
    qryCustomFieldsCFEmpl8: TWideStringField;
    qryCustomFieldsCFSupp8: TWideStringField;
    qryCustomFieldsCFLabel9: TWideStringField;
    qryCustomFieldsCFCust9: TWideStringField;
    qryCustomFieldsCFEmpl9: TWideStringField;
    qryCustomFieldsCFSupp9: TWideStringField;
    qryCustomFieldsCFLabel10: TWideStringField;
    qryCustomFieldsCFCust10: TWideStringField;
    qryCustomFieldsCFEmpl10: TWideStringField;
    qryCustomFieldsCFSupp10: TWideStringField;
    qryCustomFieldsCFLabel11: TWideStringField;
    qryCustomFieldsCFCust11: TWideStringField;
    qryCustomFieldsCFEmpl11: TWideStringField;
    qryCustomFieldsCFSupp11: TWideStringField;
    qryCustomFieldsCFLabel12: TWideStringField;
    qryCustomFieldsCFCust12: TWideStringField;
    qryCustomFieldsCFEmpl12: TWideStringField;
    qryCustomFieldsCFSupp12: TWideStringField;
    qryCustomFieldsCFLabel13: TWideStringField;
    qryCustomFieldsCFCust13: TWideStringField;
    qryCustomFieldsCFEmpl13: TWideStringField;
    qryCustomFieldsCFSupp13: TWideStringField;
    qryCustomFieldsCFLabel14: TWideStringField;
    qryCustomFieldsCFCust14: TWideStringField;
    qryCustomFieldsCFEmpl14: TWideStringField;
    qryCustomFieldsCFSupp14: TWideStringField;
    qryCustomFieldsCFLabel15: TWideStringField;
    qryCustomFieldsCFCust15: TWideStringField;
    qryCustomFieldsCFEmpl15: TWideStringField;
    qryCustomFieldsCFSupp15: TWideStringField;
    qryCustomFieldsEditedFlag: TWideStringField;
    qryCustomFieldsCFOthr1: TWideStringField;
    qryCustomFieldsCFOthr2: TWideStringField;
    qryCustomFieldsCFOthr3: TWideStringField;
    qryCustomFieldsCFOthr4: TWideStringField;
    qryCustomFieldsCFOthr5: TWideStringField;
    qryCustomFieldsCFOthr6: TWideStringField;
    qryCustomFieldsCFOthr7: TWideStringField;
    qryCustomFieldsCFOthr8: TWideStringField;
    qryCustomFieldsCFOthr9: TWideStringField;
    qryCustomFieldsCFOthr10: TWideStringField;
    qryCustomFieldsCFOthr11: TWideStringField;
    qryCustomFieldsCFOthr12: TWideStringField;
    qryCustomFieldsCFOthr13: TWideStringField;
    qryCustomFieldsCFOthr14: TWideStringField;
    qryCustomFieldsCFOthr15: TWideStringField;
    DataSource3: TDataSource;
    cmdOk: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    btnSupplier: TDNMSpeedButton;
    btnCustomer: TDNMSpeedButton;
    Label4: TLabel;
    Bevel1: TBevel;
    Customer: TDBCheckBox;
    Supplier: TDBCheckBox;
    qryContactType: TERPQuery;
    BillStreet2: TDBEdit;
    Label6: TLabel;
    qryCustomersClientID: TAutoIncField;
    qryCustomersCompany: TWideStringField;
    qryCustomersABN: TWideStringField;
    qryCustomersTitle: TWideStringField;
    qryCustomersFirstName: TWideStringField;
    qryCustomersMiddleName: TWideStringField;
    qryCustomersLastName: TWideStringField;
    qryCustomersPosition: TWideStringField;
    qryCustomersPhone: TWideStringField;
    qryCustomersFaxNumber: TWideStringField;
    qryCustomersMobile: TWideStringField;
    qryCustomersEmail: TWideStringField;
    qryCustomersAltContact: TWideStringField;
    qryCustomersAltPhone: TWideStringField;
    qryCustomersContact1: TWideStringField;
    qryCustomersPhoneSupportTill: TDateField;
    qryCustomersContact2: TWideStringField;
    qryCustomersContact1Phone: TWideStringField;
    qryCustomersContact2Phone: TWideStringField;
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
    cmdCopy: TDNMSpeedButton;
    dsOtherFollowUp: TDataSource;
    History: TTabSheet;
    pnlHistory: TDNMPanel;
    FollowUp: TTabSheet;
    DNMPanel3: TDNMPanel;
    grdFollowUp: TwwDBGrid;
    btnInactiveFollowUp: TwwIButton;
    dtpDatePicker: TwwDBDateTimePicker;
    cboEmployee: TwwDBLookupCombo;
    cboRep: TwwDBLookupCombo;
    Label5: TLabel;
    qryCustomersClientNo: TWideStringField;
    qryCustomersTAXID: TIntegerField;
    Country: TDBEdit;
    Label7: TLabel;
    Label8: TLabel;
    BillCountry: TDBEdit;
    Label12: TLabel;
    URL: TwwDBRichEdit;
    qryCustomersURL: TWideStringField;
    memqryCustomers: TkbmMemTable;
    memtbOtherFollowUp: TkbmMemTable;
    qryCustomersRequired: TWideStringField;
    qryMediaType: TERPQuery;
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
    qryCustomersRepName: TWideStringField;
    qryCustomersStreet: TWideStringField;
    qryCustomersStreet2: TWideStringField;
    qryCustomersSuburb: TWideStringField;
    qryCustomersState: TWideStringField;
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
    tabContacts: TTabSheet;
    tabDocuments: TTabSheet;
    qryContacts: TERPQuery;
    qryContactsGlobalRef: TWideStringField;
    qryContactsContactID: TAutoIncField;
    qryContactsCompany: TWideStringField;
    qryContactsContactTitle: TWideStringField;
    qryContactsContactFirstName: TWideStringField;
    qryContactsContactSurName: TWideStringField;
    qryContactsContactAddress: TWideStringField;
    qryContactsContactCity: TWideStringField;
    qryContactsContactState: TWideStringField;
    qryContactsContactPcode: TWideStringField;
    qryContactsContactPH: TWideStringField;
    qryContactsContactAltPH: TWideStringField;
    qryContactsContactMOB: TWideStringField;
    qryContactsContactFax: TWideStringField;
    qryContactsContactEmail: TWideStringField;
    qryContactsNotes: TWideStringField;
    qryContactsEditedFlag: TWideStringField;
    qryContactsContactAddress2: TWideStringField;
    qryContactsCardNumber: TWideStringField;
    qryContactsAccountNo: TWideStringField;
    qryContactsActive: TWideStringField;
    qryContactsContactName: TWideStringField;
    qryDocuments: TERPQuery;
    DSContacts: TDataSource;
    DSDocuments: TDataSource;
    WordApplication1: TWordApplication;
    memqryContacts: TkbmMemTable;
    qryDocPath: TERPQuery;
    tabNotes: TTabSheet;
    DNMPanel4: TDNMPanel;
    Label10: TLabel;
    LetterBtn: TDNMSpeedButton;
    FaxBtn: TDNMSpeedButton;
    EmailBtn: TDNMSpeedButton;
    EditBtn: TDNMSpeedButton;
    cmdNewContact: TDNMSpeedButton;
    chkShowAll: TCheckBox;
    DNMPanel5: TDNMPanel;
    Bevel5: TBevel;
    Label138: TLabel;
    Label140: TLabel;
    grdDocs: TwwDBGrid;
    DNMPanel6: TDNMPanel;
    Label59: TLabel;
    edtNotes: TDBMemo;
    qryCustomersCreationDate: TDateField;
    btnAddDateTime: TDNMSpeedButton;
    CUSTLBL16: TLabel;
    CUSTFLD16: TwwDBDateTimePicker;
    CUSTLBL17: TLabel;
    CUSTFLD17: TwwDBDateTimePicker;
    CUSTLBL18: TLabel;
    CUSTFLD18: TwwDBDateTimePicker;
    qryCustomersCUSTDATE1: TDateTimeField;
    qryCustomersCUSTDATE2: TDateTimeField;
    qryCustomersCUSTDATE3: TDateTimeField;
    qryCustomFieldsCFLabel16: TWideStringField;
    qryCustomFieldsCFLabel17: TWideStringField;
    qryCustomFieldsCFLabel18: TWideStringField;
    qryCustomFieldsCFOthr16: TWideStringField;
    qryCustomFieldsCFOthr17: TWideStringField;
    qryCustomFieldsCFOthr18: TWideStringField;
    qrySuburb: TERPQuery;
    Label48: TLabel;
    JobTitle: TDBEdit;
    cboCompanyType: TwwDBLookupCombo;
    Label11: TLabel;
    qryCompanyType: TERPQuery;
    qryCustomersCompanyTypeId: TIntegerField;
    qryCustomersJobTitle: TWideStringField;
    cmdFollowUp: TDNMSpeedButton;
    cboFollowUpType: TwwDBLookupCombo;
    tbOtherFollowUp: TERPQuery;
    tbOtherFollowUpGlobalRef: TWideStringField;
    tbOtherFollowUpFollowUpID: TAutoIncField;
    tbOtherFollowUpOtherContactID: TIntegerField;
    tbOtherFollowUpRepairID: TIntegerField;
    tbOtherFollowUpEmployeeID: TIntegerField;
    tbOtherFollowUpClientID: TIntegerField;
    tbOtherFollowUpFollowUpDate: TDateTimeField;
    tbOtherFollowUpDone: TWideStringField;
    tbOtherFollowUpEditedFlag: TWideStringField;
    tbOtherFollowUpAppearDays: TIntegerField;
    tbOtherFollowUpCreationDate: TDateTimeField;
    tbOtherFollowUpUpdateDate: TDateField;
    tbOtherFollowUpIsSupplier: TWideStringField;
    tbOtherFollowUpIsOtherContact: TWideStringField;
    tbOtherFollowUpIsCustomer: TWideStringField;
    tbOtherFollowUpHours: TFloatField;
    tbOtherFollowUpTypeId: TIntegerField;
    tbOtherFollowUpResultTypeId: TIntegerField;
    tbOtherFollowUpTypeName: TWideStringField;
    tbOtherFollowUpResultTypeName: TWideStringField;
    qryFollowUpType: TERPQuery;
    qryFollowUpResultType: TERPQuery;
    qryEmployee: TERPQuery;
    tbOtherFollowUpEmployeeName: TWideStringField;
    qryEmp: TERPQuery;
    dsEmp: TDataSource;
    btnOtherPhones: TDNMSpeedButton;
    lblSuburb: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    tbOtherFollowUpLeadLineID: TIntegerField;
    qrySimpleTypes: TERPQuery;
    Label1: TLabel;
    Street3: TDBEdit;
    Label13: TLabel;
    BillStreet3: TDBEdit;
    qryCustomersStreet3: TWideStringField;
    qryCustomersBillStreet3: TWideStringField;
    qryContactsIsPrimarycontact: TWideStringField;
    grdContact: TwwDBGrid;
    wwIButton1: TwwIButton;
    Bevel2: TBevel;
    DSRelatedClients: TDataSource;
    qryRelatedClients: TERPQuery;
    qryRelatedClientsRelatedClientID: TAutoIncField;
    qryRelatedClientsMasterClientID: TIntegerField;
    qryRelatedClientsMasterCompany: TWideStringField;
    qryRelatedClientsChildClientID: TIntegerField;
    qryRelatedClientsChildCompany: TWideStringField;
    cboClientLookup: TERPQuery;
    Label35: TLabel;
    Email: TDBEdit;
    Box76: TBevel;
    Label127: TLabel;
    cboMediaType: TwwDBLookupCombo;
    lblRelatedCust: TLabel;
    cboClient: TwwDBLookupCombo;
    Bevel23: TBevel;
    grdRelatedClient: TwwDBGrid;
    wwIButton2: TwwIButton;
    Label2: TLabel;
    cboContactType: TwwDBLookupCombo;
    cboFollowUpResultType: TwwDBLookupCombo;
    qryCustomersCallPriority: TIntegerField;
    qryCustomersDefaultContactMethod: TWideStringField;
    Label9: TLabel;
    wwDBComboBox1: TwwDBComboBox;
    Bevel3: TBevel;
    Label3: TLabel;
    cboDefaultContactMethod: TwwDBComboBox;
    qryContactsClientID: TIntegerField;
    qryContactsClientName: TWideStringField;
    tbOtherFollowUpNotes: TWideMemoField;
    qryContactsContactAddress3: TWideStringField;
    DNMSpeedButton1: TDNMSpeedButton;
    Bevel4: TBevel;
    Label14: TLabel;
    chkDontContact: TDBCheckBox;
    Bevel6: TBevel;
    qryCustomersDontContact: TWideStringField;
    qryCustomersmsUpdateSiteCode: TWideStringField;
    DBEdit19: TDBEdit;
    Label43: TLabel;
    qryCustomersclientCode: TWideStringField;
    qryCustomersPrintName: TWideStringField;
    lblClientPrintNameHeading: TLabel;
    edtPrintName: TDBEdit;
    qryCustomersGlobalRef: TWideStringField;
    procedure cmdOkClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure TabCtl20Change(Sender: TObject);
    procedure SuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure BillSuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cmdCustomLabelsOldClick(Sender: TObject);
    procedure btnCustomerClick(Sender: TObject);
    procedure btnSupplierClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmdCopyClick(Sender: TObject);
    procedure btnInactiveFollowUpClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure qryCustomersAfterOpen(DataSet: TDataSet);
    procedure tbOtherFollowUpAfterOpen(DataSet: TDataSet);
    procedure SuburbEnter(Sender: TObject);
    procedure BillSuburbEnter(Sender: TObject);
    procedure grdFollowUpEnter(Sender: TObject);
    procedure tbOtherFollowUpNewRecord(DataSet: TDataSet);
    procedure qryCustomersFirstNameChange(Sender: TField);
    procedure qryCustomersLastNameChange(Sender: TField);
    procedure qryCustomersRepIDChange(Sender: TField);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure LetterBtnClick(Sender: TObject);
    procedure cmdNewContactClick(Sender: TObject);
    procedure EditBtnClick(Sender: TObject);
    procedure EmailBtnClick(Sender: TObject);
    procedure FaxBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdContactRowChanged(Sender: TObject);
    procedure qryContactsAfterOpen(DataSet: TDataSet);
    procedure grdDocsDblClick(Sender: TObject);
    procedure chkShowAllClick(Sender: TObject);
    procedure btnAddDateTimeClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure cboCompanyTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cmdFollowUpClick(Sender: TObject);
    procedure grdFollowUpDblClick(Sender: TObject);
    procedure cboFollowUpTypeNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure btnInactiveClick(Sender: TObject);
    procedure cboCompanyTypeNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure TabCtl20Changing(Sender: TObject; var AllowChange: boolean);
    procedure qryCustomersAfterPost(DataSet: TDataSet);
    procedure btnOtherPhonesClick(Sender: TObject);
    procedure grdContactKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure qrySuburbBeforeOpen(DataSet: TDataSet);
    procedure edtNotesExit(Sender: TObject);
    procedure tbOtherFollowUpAfterScroll(DataSet: TDataSet);
    procedure wwIButton2Click(Sender: TObject);
    procedure cboClientCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboClientNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: String; var Accept: Boolean);
    procedure cboFollowUpResultTypeNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure cboCompanyTypeEnter(Sender: TObject);
    procedure cboContactTypeEnter(Sender: TObject);
    procedure cboRepEnter(Sender: TObject);
    procedure cboClientEnter(Sender: TObject);
    procedure cboMediaTypeEnter(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure qryCustomersAfterInsert(DataSet: TDataSet);
    procedure tbOtherFollowUpAfterInsert(DataSet: TDataSet);
    procedure qryRelatedClientsAfterInsert(DataSet: TDataSet);
    procedure edtPrintNameExit(Sender: TObject);
    procedure edtPrintNameChange(Sender: TObject);
  private
    { Private declarations }
    ffrmList: TBaseListingGUI;
    fbSaveClicked: boolean;
    AppointmentFollowUpResultId: integer;
    fNewName:String;
    ProspectFollowUp:TProspectfollowup;
    fbEmailchanged:Boolean;
    frmLoyaltyList:TBaseListingGUI;
    fbUpdatingcompanyonName :Boolean;
    fbclientnameMadeFromName:Boolean;
    procedure InitNewContact;
    function ChkOthrReqdFields: boolean;
    procedure GlobalEventHandler(const Sender: TObject; const Event: string; const Data: Pointer);
    function SaveData: boolean;
    function ValidData: boolean;
    Procedure Callcontactform(Sender:TDNMSpeedbutton);
    function ChkCustReqdFields: boolean;
    Function LoyaltyListFormGUI:TBaseListingGUI;
    procedure LoadMemTable;
    procedure Makecompany;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure CustomFieldsRefresh;Override;
    function GetKeyString: string; override;
    procedure SetKeyString(const Value: string); override;
    function SaveOrCancelChanges: boolean;override;
    procedure Saveclose;Override;
    Function ClientId :Integer;Override;
  public
    { Public declarations }
    procedure UpdateMe; override;
    procedure UpdateMe(const Cancelled: Boolean; const aObject: TObject = nil); override;
    property NewName:String read fNewName write fNewName;
    Procedure AfterPopupformshow;Override;
  end;


implementation

uses
  CommonDbLib, FormFactory, DNMLib, AuditObj, frmCustomFieldsFrm,
  DNMExceptions, LoyaltyListForm,
  (*frmClientReferenceFrm, *)frmContactFrm,
  remainClientFrm, frmFollowUp, AppContextObj, GlobalEventsObj, frmSimpleTypes,
  CommonLib, frmClientsOtherPhonesGUI,BusObjConst,
  AppEnvironment, tcDataUtils, FastFuncs, tcconst, BusObjClient,
  CommonFormLib, frmOthercontactCorrespondenceCreate, tcTypes, busobjobjectproperties,
   UserCustomisedNames, ERPDbLookupCombo;

{$R *.DFM}

procedure TfrmOtherContact.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    if SaveData then begin
      KeyID := 0;
      FormShow(nil);
    end;
  finally
    EnableForm;
  end;
end;

function TfrmOtherContact.ValidData: boolean;
var
  fid:Integer;
begin
  Result := false;
  if (ProspectFollowUp.Count > 0) and (not ProspectFollowUp.ValidateData) then Exit;
  if not ChkOthrReqdFields() then Exit;

  if Empty(Company.Text) then begin
    if not (qryCustomers.State in [dsEdit, dsInsert]) then qryCustomers.Edit;
    Company.Text := FirstName.Text + ' ' + LastName.Text;
  end;

  if Empty(Company.Text) then begin
    CommonLib.MessageDlgXP_Vista('Company Name cannot be blank.', mtWarning, [mbOK], 0);
    Exit;
  end;

  if not IsClientNameUnique(Company.Text, KeyID) then begin
    CommonLib.MessageDlgXP_Vista('You Have Created An Entry (Company) That Already Exists !' + #13#10#13#10 +
      'Please Ensure Your Entry Is Unique.', mtWarning, [mbOK], 0);
    Exit;
  end;
//  if not ConfirmEmailId(fbEmailchanged ,Email ,qryCustomers ,'Email') then begin
//    Exit;
//  end;
  if not ChkCustReqdFields then begin
      exit;
  end;
  if Empty(FirstName.Text) then begin
    CommonLib.MessageDlgXP_Vista('First Name cannot be blank.', mtWarning, [mbOK], 0);
    Exit;
  end;
  fid:=qryCustomersclientID.AsInteger;
  With TOthercontact.CreateWithNewConn(Self) do try
    busobjevent := DoBusinessObjectEvent;
    connection.Connection := qryCustomers.Connection;
    Load(fid);
    if not ValidateObjectProperties then begin
      REsult:= False;
      Exit;
    end;
  finally
    Free;
  end;

  Result := true;
end;

procedure TfrmOtherContact.Saveclose;
begin
  fbSaveClicked := true;
  inherited;
end;

function TfrmOtherContact.SaveData: boolean;
var
  McID: integer;
  msg: string;
begin
  Result := false;
  ProspectFollowUp.PostDb;
  if qryRelatedClients.state in [dsEdit,dsInsert] then qryRelatedClients.post;
  if ValidData then try
      //cmdOk.Enabled := False;  //Stops Click Twice
      qryCustomers.Edit;

      qryCustomersOtherContact.AsString := 'T';
      qryCustomers.FieldByName('Type').AsString := cboContactType.Text;
      ProcessEditedFlag('Main', Self, memqryCustomers, qryCustomers, nil);
      qryCustomers.Edit;
      qryCustomers.Post;
      With Tclient.create(nil) do try
        connection := TMydacdataconnection.create(self);
        connection.connection :=qryCustomers.connection;
        connection.beginnestedtransaction;
        try
          Load(qryCustomersclientId.asInteger);
          if count > 0 then begin
            McID := ConvertToMarketingContact(msg);
            if McId = 0 then begin
              CommonLib.MessageDlgXP_Vista(msg, mtInformation, [mbOk], 0);
              connection.RollbackNestedTransaction;
              exit;
            end;
          end;
          connection.commitNestedtransaction;
        except
          on E:Exception do begin
            connection.rollbacknestedtransaction;
          end;
        end;
      finally
        free;
      end;
      CommitTransaction;
      Result := true;
    except
      on e: Exception do begin
        Audit.AddEntry(e, Self);
        CommonLib.MessageDlgXP_Vista(e.Message + Chr(13) + 'Errors occured in ' + Self.ClassName, mtWarning, [mbOK], 0);
      end;
    end;
end;

procedure TfrmOtherContact.SetKeyString(const Value: string);
begin
  SetKeyString(TCustomer, qryCustomers, Value , 'Printname');
end;

procedure TfrmOtherContact.cmdOkClick(Sender: TObject);
begin
  DisableForm;
  try
    if SaveData then begin
      Saveclose;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmOtherContact.cmdCancelClick(Sender: TObject);
begin
  DisableForm;
  try
    Notify(true);
    Self.Close;
  finally
    EnableForm;
  end;
  (*Self.Enabled := false;
  cmdCancel.Enabled := false;  //Stops Click Twice
  if MyConnection.intransaction then begin
    RollbackTransaction;
  end;
  if fsModal in FormState then begin
    ModalResult := mrCancel;
  end else begin
    Self.Close;
  end;*)
//  Self.Close;
end;
function TfrmOtherContact.SaveOrCancelChanges: boolean;
var iExitResult:integer;
begin
  REsult := True;
  iExitResult:=CommonLib.MessageDlgXP_Vista('Do you wish to Save changes?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
  if iExitResult = mrYes then begin
    Result:= SaveData;
    if result then Notify(False);
  end else if iExitResult = mrNo then begin
    Result:=  true;
    RollbackTransaction;
    Notify(True);
  end else if iExitResult = mrCancel then begin
    Result := false;
  end;
end;

procedure TfrmOtherContact.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseQueries;
  Action := caFree;
  inherited;
end;

procedure TfrmOtherContact.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if (MyConnection.Connected and MyConnection.intransaction) then begin
      canclose:= SaveOrCancelChanges;
  end;
end;

procedure TfrmOtherContact.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if sender is TProspectfollowup then TProspectfollowup(Sender).DataSet  := tbOtherFollowUp;
    if sender is TOthercontact then TOthercontact(Sender).DataSet  := qryCustomers;
  end;
end;

procedure TfrmOtherContact.FormShow(Sender: TObject);
  //var
  //  FormInUse: TInUse;
begin
  fsBusobjClassname := TOtherContact.ClassName;
  DisableForm;
  try
    try
      inherited;
      fbSaveClicked := false;

      if qryCustomers.Active then begin
        if not (qryCustomers.State in [dsBrowse]) then begin
          qryCustomers.Post;
          Notify;
        end;
        CloseQueries;
      end;

      qryCompanyType.ParamByName('TypeCode').AsString := SimpleTypes_CompanyType;
      qryCompanyType.Open;
      // as the busobj is used to validate the data which uses the same query, overwrites the SQL with the busobj SQL- which doesn't have the Param
      // on 'NEW' formshow is called again and the param doesn't exists , so reload the SQL
      qryCustomers.SQL.text := 'SELECT ' +
                        '* '+
                        'FROM tblclients ' +
                        'WHERE ClientID = :CusID;';
      qryCustomers.Connection := MyConnection;
      qryCustomers.ParamByName('CusID').asInteger := KeyID;

      qryDocuments.ParamByName('CusID').asInteger := KeyID;
      qryFollowUp.ParamByName('CusID').asInteger := KeyID;
      qryRelatedClients.ParamByName('ID').asInteger := KeyID;
      cboClientLookup.Params.ParamByName('ID').AsInteger   := KeyID;

      // Setup our qryContact component.
      if not chkShowAll.Checked then begin
        qryContacts.filtered := false;
        qryContacts.filter := 'Active = ''T''';
        qryContacts.filtered := true;
      end;

      qryContacts.ParamByName('CusID').asInteger := KeyID;

      // needs to be transactional connection so changes are passed to Follow Up form
      qryContacts.Connection := MyConnection;
      qryContacts.Open;

      //OpenQueries;
      qryCustomers.Open;
      qryFollowUp.Open;
      qryEmp.Open;
      qryEmployee.Open;
      qryMediaType.Open;
      qryContactType.Open;
      qryDocuments.Open;
      opendb(qryRelatedClients);
      OpenDB(cboClientLookup);

      qryFollowUpType.Close;
      qryFollowUpType.Connection := MyConnection;
      qryFollowUpType.ParamByName('TypeCode').asString := SimpleTypes_FollowUpType;
      qryFollowUpType.Open;

      qryFollowUpResultType.Close;
      qryFollowUpResultType.Connection := MyConnection;
      qryFollowUpResultType.ParamByName('TypeCode').asString := SimpleTypes_FollowUpResultType;
      qryFollowUpResultType.Open;

      BeginTransaction;

      if KeyID = 0 then begin
        qryCustomers.Insert;
        InitNewContact;
        qryCustomers.Post;
        qryCustomers.Edit;
      end else begin
        qryCustomers.Edit;
        //EditedFlag.Checked := true;
      end;

      ProspectFollowUp := TProspectfollowup.Create(Self) ;
      ProspectFollowUp.Connection := TMyDacDataConnection.Create(ProspectFollowUp);
      TMyDacDataConnection(ProspectFollowUp.Connection).MyDacConnection := MyConnection;
      ProspectFollowUp.BusObjEvent  := DoBusinessObjectEvent;

      ProspectFollowUp.LoadSelect('OtherContactID = ' + IntToStr(Self.KeyID));

//      tbOtherFollowUp.Connection := MyConnection;
//      tbOtherFollowUp.ParamByName('ClientId').asInteger := KeyID;
//      tbOtherFollowUp.Open;
      chkActive.Enabled := (AccessLevel <> 2) and (AccessLevel <> 3);

      if qryCustomersRequired.AsBoolean then begin
        chkActive.Enabled := false;
        Label36.Enabled := false;
      end;
      CustomFieldsRefresh;

      // set the default company type (if defined)
      if (cboCompanyType.Text = '') then begin
        qryCompanyType.First;
        while not qryCompanyType.Eof do begin
          if qryCompanyType.FieldByName('IsDefault').AsBoolean then begin
            qryCustomersCompanyTypeId.AsInteger :=
              qryCompanyType.FieldByName('Id').AsInteger;
            Break;
          end;
          qryCompanyType.Next;
        end;
      end;

      // reload memtable so form is "Clean"
      LoadEditedFlagMemTable(qryCustomers, memqryCustomers);
      qryCustomers.Edit;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do begin
        HandleNoAccessException(e);
        Exit;
      end;
      else raise;
    end;

    btnCustomer.Enabled := not qryCustomers.FieldByName('Customer').AsBoolean;
    btnSupplier.Enabled := not qryCustomers.FieldByName('Supplier').AsBoolean;
    TabCtl20.ActivePage := TTabSheet(Customer_Info);
    SetControlFocus(Company);
  finally
    Setcontrolfocus(edtPrintName);
    EnableForm;
  end;
end;


procedure TfrmOtherContact.TabCtl20Change(Sender: TObject);
begin
  inherited;
  if TabCtl20.ActivePage = TTabSheet(History) then begin
    ffrmList := LoyaltyListFormGUI;
    if Assigned(ffrmList) then begin
        ffrmList.Show;
    end else begin
        pnlHistory.Font.Size := 15;
        pnlHistory.Caption := 'YOU DO NOT HAVE ACCESS TO THIS REPORT!';
        pnlHistory.Paint;
    end;
    (*if not Assigned(ffrmList) then begin
      if AppEnv.AccessLevels.GetEmployeeAccessLevel('TLoyaltyListGUI') < 6 then Begin
        ffrmList := TLoyaltyListGUI.Create(Self);
       {To Stop FindExistingComponent Finding This Instance}
        if Assigned(ffrmList) then ffrmList.Tag := 99;
        ffrmList.FilterString := 'CusID = ' + IntToStr(KeyID);
        ffrmList.grdMain.TitleColor := StringToColor('$00D7FFFF');
        ffrmList.HeaderPanel.Color := StringToColor('$00D7FFFF');
        ffrmList.FooterPanel.Color := StringToColor('$00D7FFFF');
        ffrmList.lblcustomReport.Visible := False;
        ffrmList.cboCustomReports.Visible := False;
        ffrmList.Parent := pnlHistory;
        ffrmList.BorderStyle := bsNone;
        ffrmList.Show;
      end else begin
        pnlHistory.Font.Size := 15;
        //pnlHistory.Caption := 'ACCESS TO THIS PANEL IS RESTRICTED!';
        pnlHistory.Caption := 'YOU DO NOT HAVE ACCESS TO THIS REPORT!';
        pnlHistory.Paint;
      end;
    end;*)
  end else if TabCtl20.ActivePage = TTabSheet(tabDocuments) then begin
    qryDocPath.Open;
    qryDocuments.Close;
    qryDocuments.ParamByName('CusID').asInteger := KeyID;
    qryDocuments.Open;
  end else if TabCtl20.ActivePage = TTabSheet(tabContacts) then begin
    qryDocPath.Open;
    // Need to remove qryContacts from Transaction handling as we need to
    // see changes reflected in the Grid associated with this qry immediately
    // on return from Contact form
    qryContacts.Close;
    qryContacts.ParamByName('CusID').asInteger := KeyID;
    qryContacts.Open;
  end else if TabCtl20.ActivePage = TTabSheet(Address_Info) then begin
    URL.Text:= self.qryCustomersURL.AsString;
  end;
end;

procedure TfrmOtherContact.SuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if Modified then begin
    FillTable.FieldByName('State').asString    := LookupTable.FieldByName('State').asString;
    FillTable.FieldByName('Postcode').asString := LookupTable.FieldByName('Postcode').asString;
    FillTable.FieldByName('Country').asString  := LookupTable.FieldByName('Country').asString;
  end;
end;

procedure TfrmOtherContact.BillSuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  FillTable.FieldByName('BillState').AsString    := LookupTable.FieldByName('State').AsString;
  FillTable.FieldByName('BillPostcode').AsString := LookupTable.FieldByName('Postcode').AsString;
  FillTable.FieldByName('BillCountry').asString  := LookupTable.FieldByName('Country').asString;
end;

procedure TfrmOtherContact.cmdCustomLabelsOldClick(Sender: TObject);
begin
  OpenCustomFields;
  (*Var Form : TComponent;
begin
  Form := GetComponentByClassName('TfrmCustomFields');
  if Assigned(Form) then begin
    with TfrmCustomFields(Form) do begin
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;*)
end;

procedure TfrmOtherContact.CustomFieldsRefresh;
begin
    CustomFieldRefresh('CFOthr' ,pnlCustFields);
end;

procedure TfrmOtherContact.btnCustomerClick(Sender: TObject);
begin
  inherited;
  //  Customer.Checked := True;
  editdb(qryCustomers);
  qryCustomers.FieldByName('Customer').AsBoolean := true;
  PostDB(qryCustomers);
  //qryCustomers.FieldByName('OtherContact').AsBoolean := false;
  btnCustomer.Enabled := false;
  CommonLib.MessageDlgXP_Vista('This Other Contact has been successfully converted to a Customer.' + #13#10#13#10 +
    'This record can now be accessed / viewed in the Customers List Window.', mtInformation, [mbOK], 0);
  if not SaveData then Exit;
  OpenERPForm('TfrmCustomer' , QryCustomersClientID.asInteger);
  Saveclose;
end;

procedure TfrmOtherContact.btnSupplierClick(Sender: TObject);
begin
  inherited;

  editdb(qryCustomers);
  qryCustomers.FieldByName('Supplier').AsBoolean := true;
  //qryCustomers.FieldByName('OtherContact').AsBoolean := false;
  Postdb(qryCustomers);
  btnSupplier.Enabled := false;
  CommonLib.MessageDlgXP_Vista('This Other Contact has been successfully converted to a Supplier.' + #13#10#13#10 +
    'This record can now be accessed / viewed in the Suppliers List Window.', mtInformation, [mbOK], 0);
  if not SaveData then Exit;
  OpenERPForm('TfmSupplier' , QryCustomersClientID.asInteger);
  Saveclose;
end;

procedure TfrmOtherContact.cmdPrintClick(Sender: TObject);
var
  sSQL: string;
  sClientID: string;
begin
  DisableForm;
  try
    if ValidData then begin
      if qryCustomers.State <> dsBrowse then begin
        qryCustomers.Post;
        qryCustomers.Edit;
      end;
    end;

    Application.ProcessMessages;

    sClientID := qryCustomers.FieldByName('ClientID').AsString;
    fbTemplateUsesNonFormConnection := false;
    sSQL := '';
    fbReportSQLSupplied := true;

    sSQL := sSQL + '{Master} ';
    sSQL := sSQL + 'SELECT ';
    sSQL := sSQL + '"Other Contact Detail Report" AS ReportTitle, ';
    sSQL := sSQL + 'C.*, SUBSTRING_INDEX(C.Company, "^", 1) as Company_NoJobName, CONCAT_WS(" ", C.Title, C.FirstName, C.LastName) AS FullName, ';
    sSQL := sSQL + 'CONCAT_WS("  ", C.Suburb, C.State, C.PostCode) AS FullPostal, ';
    sSQL := sSQL + 'CONCAT_WS("  ", C.BillSuburb, C.BillState, C.BillPostCode) AS FullBillPostal, ';
    sSQL := sSQL + 'ST.Name AS "CompanyType", OT.OtherType AS "ContactType", ';
    sSQL := sSQL + 'CASE C.Global WHEN "T" THEN "Yes" WHEN "F" THEN "No" END AS "GlobalViewing" ';
    sSQL := sSQL + 'FROM tblclients C ';
    sSQL := sSQL + 'LEFT JOIN tblsimpletypes ST on ST.Id = C.CompanyTypeID ';
    sSQL := sSQL + 'LEFT JOIN tblothertype OT on OT.OtherTypeID = C.OtherContactType ';
    sSQL := sSQL + 'WHERE C.ClientID = ' + sClientID + ' AND C.OtherContact="T"; ';
    sSQL := sSQL + '~|||~{Custom Fields} SELECT * FROM tblcustomfields; ';
    sSQL := sSQL + '~|||~{Contacts} SELECT *, CONCAT_WS(" ", ContactTitle, ContactFirstName, ';
    sSQL := sSQL + 'ContactSurName) AS FullName FROM tblcontacts ';
    sSQL := sSQL + 'WHERE ClientID = ' + sClientID + ' AND /*ContactIsCustomer="F" AND ContactIsJob="F" AND ';
    sSQL := sSQL + 'ContactIsSupplier="F" AND ContactIsOtherContact="F" */  Active="T"; ';
    sSQL := sSQL + '~|||~{FollowUps} SELECT FU.FollowUpDate, FU.Notes, ';
    sSQL := sSQL + 'CASE FU.Done WHEN "T" THEN "Yes" WHEN "F" THEN "No" END AS "Completed", ';
    sSQL := sSQL + 'TN.Name AS "Type", ST.Name AS "ResultType" ';
    sSQL := sSQL + 'FROM tblotherfollowup FU ';
    sSQL := sSQL + 'LEFT JOIN tblSimpleTypes TN on FU.TypeID = TN.ID ';
    sSQL := sSQL + 'LEFT JOIN tblSimpleTypes ST on ST.ID = FU.ResultTypeID ';
    sSQL := sSQL + 'WHERE ClientID = ' + sClientID + ' AND OtherContactID = ' + sClientID + ' ';
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
    sSQL := sSQL + '~|||~ {Company} SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode,   Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber,   CO.ABN FROM tblCompanyInformation AS CO;';


    PrintTemplateReport('Other Contact', sSQL, false, 1);
    fbReportSQLSupplied := false;
  finally
    EnableForm;
  end;
end;

procedure TfrmOtherContact.cmdCopyClick(Sender: TObject);
begin
  inherited;
  if IsOkToSave() then begin
    qryCustomers.Edit;
    qryCustomers.FieldByName('BillStreet').AsString   := Street.Text;
    qryCustomers.FieldByName('BillStreet2').AsString  := Street2.Text;
    qryCustomers.FieldByName('BillStreet3').AsString  := Street3.Text;
    qryCustomers.FieldByName('BillSuburb').AsString   := Suburb.Text;
    qryCustomers.FieldByName('BillState').AsString    := State.Text;
    qryCustomers.FieldByName('BillPostCode').AsString := PostCode.Text;
    qryCustomers.FieldByName('BillCountry').AsString  := Country.Text;
  end;
end;

procedure TfrmOtherContact.btnInactiveFollowUpClick(Sender: TObject);
begin
  inherited;
  tbOtherFollowup.Delete;
  if tbOtherFollowup.RecordCount = 0 then begin
    tbOtherFollowUp.Insert;
  end else begin
    tbOtherFollowUp.Edit;
  end;
end;

procedure TfrmOtherContact.FormDestroy(Sender: TObject);
begin
  if Assigned(ffrmList) then
    FreeandNil(ffrmList);
  inherited;
end;

procedure TfrmOtherContact.InitNewContact;
begin
  qryCustomersActive.AsString := 'T';
  qryCustomersGlobal.AsString := 'T';
  qryCustomersOtherContact.AsString := 'T';
  qryCustomers.FieldByName('CreationDate').AsDateTime := Now;
  cboRep.LookupValue := IntToStr(AppEnv.Employee.EmployeeID);
  qryCustomersRepID.AsInteger := AppEnv.Employee.EmployeeID;
  if NewName <> '' then qryCustomers.FieldByName('Company').AsString := NewName;
end;


procedure TfrmOtherContact.qryCustomersAfterInsert(DataSet: TDataSet);
begin
  inherited;
  fbclientnameMadeFromName := False;
  PostDb(qryCustomers);
  LoadMemTable;
  EditDB(qryCustomers);
end;

procedure TfrmOtherContact.qryCustomersAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadMemTable;
end;

procedure TfrmOtherContact.LoadMemTable;
begin
  if memqryCustomers.active then
    if qryCustomersclientId.asInteger =  memqryCustomers.fieldbyname('ClientID').asInteger then exit;
  LoadEditedFlagMemTable(qryCustomers, memqryCustomers);
end;

procedure TfrmOtherContact.tbOtherFollowUpAfterInsert(DataSet: TDataSet);
begin
  inherited;
  tbOtherFollowUpClientID.AsInteger := qryCustomers.FieldByName('ClientID').AsInteger;
  tbOtherFollowUpOtherContactID.AsInteger := qryCustomers.FieldByName('ClientID').AsInteger;
  tbOtherFollowUpCreationDate.AsDateTime := Now;
  tbOtherFollowUpIsOtherContact.AsBoolean := true;
end;

procedure TfrmOtherContact.tbOtherFollowUpAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadEditedFlagMemTable(tbOtherFollowUp, memtbOtherFollowUp);
end;

procedure TfrmOtherContact.SuburbEnter(Sender: TObject);
begin
  inherited;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
  if not (QrySuburb.Active) then begin
    QrySuburb.Active := true;
  end;
end;

procedure TfrmOtherContact.BillSuburbEnter(Sender: TObject);
begin
  inherited;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
  if not (QrySuburb.Active) then begin
    QrySuburb.Active := true;
  end;
end;

procedure TfrmOtherContact.grdFollowUpEnter(Sender: TObject);
begin
  inherited;
  qryCustomers.Edit;
  qryCustomers.Post;
  qryCustomers.Edit;
end;

procedure TfrmOtherContact.tbOtherFollowUpNewRecord(DataSet: TDataSet);
begin
  inherited;
  tbOtherFollowUpEmployeeID.AsInteger := AppEnv.Employee.EmployeeID;
end;

procedure TfrmOtherContact.qryCustomersFirstNameChange(Sender: TField);
begin
  inherited;
  (*if Empty(qryCustomersCompany.AsString) then begin
    qryCustomers.Edit;
    qryCustomersCompany.AsString := qryCustomersFirstName.AsString;
  end;*)
  if  not NamenPrintNameGridObj.UpdatecompanyonNamechange(fbUpdatingcompanyonName,qryCustomers) then SetControlFocus(txtcompany);
end;

procedure TfrmOtherContact.qryCustomersLastNameChange(Sender: TField);
begin
  inherited;
  (*if Empty(qryCustomersCompany.AsString) or (qryCustomersCompany.AsString = qryCustomersFirstName.AsString) then begin
    qryCustomers.Edit;
    qryCustomersCompany.AsString := qryCustomersFirstName.AsString + ' ' + qryCustomersLastName.AsString;
  end;*)
  if  not NamenPrintNameGridObj.UpdatecompanyonNamechange(fbUpdatingcompanyonName,qryCustomers) then SetControlFocus(txtcompany);
end;

procedure TfrmOtherContact.qryCustomersRepIDChange(Sender: TField);
begin
  inherited;
  qryCustomers.Edit;
  qryCustomersRepName.AsString := qryEmp.FieldByName('EmployeeName').AsString;
end;

function TfrmOtherContact.ChkOthrReqdFields: boolean;
var
//  SavedPage: TTabSheet;
  companyTypeStr: string;
begin
  Result := True;
  companyTypeStr := cboCompanyType.Text;
  // check we have a valid Company Type
  if CompanyTypeStr <> cboCompanyType.LookupTable.FieldByName('Name').AsString then begin
    // close and reopen lookup in case user has added a new companuy type
    cboCompanyType.LookupTable.Close;
    cboCompanyType.LookupTable.Open;
    if not cboCompanyType.LookupTable.Locate('Name', CompanyTypeStr, [loCaseInsensitive]) then begin
      CommonLib.MessageDlgXP_Vista('Can not find the company type you have entered.', mtWarning, [mbOK], 0);
      Result := false;
      SetControlFocus(cboCompanyType);
      Exit;
    end else begin
      cboCompanyType.DataSource.DataSet.FieldByName(cboCompanyType.DataField).AsInteger :=
        cboCompanyType.LookupTable.FieldByName(cboCompanyType.LookupField).AsInteger;
    end;
  end;
  If not ChkReqdFields('Othr') then begin
    Result := False;
    TabCtl20.ActivePage := Custom_Fields;
  end;
end;

procedure TfrmOtherContact.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
var
  cThisKey: char;
begin
  inherited;
  cThisKey := Chr(Key);
  // Tab Page Shortcuts.
  if Shift = [ssCtrl] then begin
    if cThisKey = 'O' then begin
      TabCtl20.ActivePage := TTabSheet(Customer_Info);
      TabCtl20Change(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'A' then begin
      TabCtl20.ActivePage := TTabSheet(Address_Info);
      TabCtl20Change(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'F' then begin
      TabCtl20.ActivePage := TTabSheet(FollowUp);
      TabCtl20Change(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'I' then begin
      TabCtl20.ActivePage := TTabSheet(Custom_Fields);
      TabCtl20Change(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'H' then begin
      TabCtl20.ActivePage := TTabSheet(History);
      TabCtl20Change(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'N' then begin
      TabCtl20.ActivePage := TTabSheet(tabContacts);
      TabCtl20Change(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'D' then begin
      TabCtl20.ActivePage := TTabSheet(tabDocuments);
      TabCtl20Change(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'E' then begin
      TabCtl20.ActivePage := TTabSheet(tabNotes);
      TabCtl20Change(Sender);
      Key := 0;
      Exit;
    end;
  end;
end;

procedure TfrmOtherContact.LetterBtnClick(Sender: TObject);
begin
    if Accesslevel >= 5 then Exit;
    PostDB(qryCustomers);
    EditDB(qryCustomers);
    PostDB(qryContacts);
    EditDB(qryContacts);
  OthercontactContactCreateCorrespondence(ctLetter, self, qryCustomerscompany.AsString);

(*Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TfrmClientReference', false);
    if Assigned(Form) then begin
      with TfrmClientReference(Form) do begin
        FormStyle := fsMDIChild;
        BringToFront;
        TitleLabel.Caption := 'Letter To Contact';
        EditedFlag.Checked := true;
        Ref_Type.Text := 'Letter';
        ClientID.Text := IntToStr(qryCustomers.FieldByName('clientid').AsInteger);
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

function TfrmOtherContact.LoyaltyListFormGUI: TBaseListingGUI;
begin
  if not(Assigned(frmLoyaltyList)) then begin
    CreateHistorylistform('TLoyaltyListGUI' ,Self, frmLoyaltyList,'CusID', inttostr(KeyID));
    if assigned(frmLoyaltyList) then begin
      frmLoyaltyList.grdMain.TitleColor := StringToColor('$00D7FFFF');
      frmLoyaltyList.HeaderPanel.Color := StringToColor('$00D7FFFF');
      frmLoyaltyList.FooterPanel.Color := StringToColor('$00D7FFFF');
      frmLoyaltyList.lblcustomReport.Visible := False;
      frmLoyaltyList.cboCustomReports.Visible := False;
      frmLoyaltyList.Parent := pnlHistory;
      frmLoyaltyList.BorderStyle := bsNone;
    end;
  end;
  result := frmLoyaltyList;
end;

procedure TfrmOtherContact.cmdNewContactClick(Sender: TObject);
begin
  Callcontactform(TDNMSpeedButton(Sender));
end;

procedure TfrmOtherContact.EditBtnClick(Sender: TObject);
begin
    if self.qryContacts.FieldByName('ContactID').AsInteger=0 then Exit;
    Callcontactform(TDNMSpeedButton(EditBtn));
end;

procedure TfrmOtherContact.EmailBtnClick(Sender: TObject);
begin
    if Accesslevel >= 5 then Exit;

    if self.qryContactsContactEmail.AsString = '' then begin
      if CommonLib.MessageDlgXP_Vista('The contact ' + self.qryContactsCompany.AsString +
        ' does not have an email address.' + #13 + #10 + 'Do you wish to load the email program anyway?',
        mtConfirmation, [mbYes, mbNo], 0)  = mrNo then Exit;
    end;

    PostDB(qryCustomers);
    EditDB(qryCustomers);
    PostDB(qryContacts);
    EditDB(qryContacts);
  OthercontactContactCreateCorrespondence(ctemail, self, qryCustomerscompany.AsString);

(*Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    if qryCustomers.State in [dsEdit,dsInsert] then begin
      qryCustomers.Post;
      qryCustomers.Edit;
    end;
    form := GetComponentByClassName('TfrmClientReference', false);
    if Assigned(Form) then begin
      with TfrmClientReference(Form) do begin
        FormStyle := fsMDIChild;
        BringToFront;


        TitleLabel.Caption := 'Email To Contact';
        EditedFlag.Checked := true;
        Ref_Type.Text := 'Email';
        ClientID.Text := IntToStr(qryCustomers.FieldByName('clientid').AsInteger);
        Ref_Date.Text := DateToStr(Date);
        if Empty(Email.Text) then EmailNo.Text := Email.Text
        else EmailNo.Text := 'Email';

        FaxNo.Text := '';
        KeyID := 0;
        Refresh;
      end;
    end;
  finally
    EnableForm;
  end; *)
end;

procedure TfrmOtherContact.FaxBtnClick(Sender: TObject);
begin
    if Accesslevel >= 5 then Exit;
    PostDB(qryCustomers);
    EditDB(qryCustomers);
    PostDB(qryContacts);
    EditDB(qryContacts);
  OthercontactContactCreateCorrespondence(ctFax, self, qryCustomerscompany.AsString);

(*Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    if qryCustomers.State in [dsEdit,dsInsert] then begin
      qryCustomers.Post;
      qryCustomers.Edit;
    end;

    Form := GetComponentByClassName('TfrmClientReference', false);
    if Assigned(Form) then begin
      with TfrmClientReference(Form) do begin
        FormStyle := fsMDIChild;
        BringToFront;

        TitleLabel.Caption := 'Fax To Contact';
        EditedFlag.Checked := true;
        Ref_Type.Text := 'Fax';
        ClientID.Text := IntToStr(qryCustomers.FieldByName('clientid').AsInteger);
        CID := qryContacts.FieldByName('ContactID').AsInteger;
        Ref_Date.Text := DateToStr(Date);
        EmailNo.Text := '';

        if FaxNumber.Text <> '' then FaxNo.Text := FaxNumber.Text
        else FaxNo.Text := 'Fax';

        KeyID := 0;
        Refresh;
      end;
    end;
  finally
    EnableForm;
  end;  *)
end;

procedure TfrmOtherContact.FormCreate(Sender: TObject);
var
  qry: TERPQuery;
begin
  fbUpdatingcompanyonName := False;
  ApplyLabelCaptions(lblCompany , cpProspectName);
  ApplyLabelCaptions(lblClientPrintNameHeading , cpClientPrintName);


  AddPhoneCallbutton(Phone);
  AddPhoneCallbutton(MOB);
  AddPhoneCallbutton(AltPhone);
  inherited;
  frmLoyaltyList:= nil;
  fbEmailchanged := false;
  self.UserLock.Enabled := true;
  TabCtl20.ActivePage := TTabSheet(Customer_Info);
  TabCtl20Change(Sender);

  qryDocuments.Connection := nil;
  qryDocuments.Connection := CommonDbLib.GetSharedMyDacConnection;

  // get AppointmentFollowUpResultId
  AppointmentFollowUpResultId := 0;
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text   := 'SELECT Id FROM tblSimpleTypes' + ' WHERE TypeCode = ' +
      QuotedStr(SimpleTypes_FollowUpResultType) + ' AND Name = "Appointment"';
    qry.Open;
    if not qry.IsEmpty then AppointmentFollowUpResultId := qry.FieldByName('Id').AsInteger;
    qry.Close;
  finally
    FreeAndNil(qry);
  end;

  if AppointmentFollowUpResultId > 0 then begin
    tbOtherFollowUp.Filter   := 'ResultTypeId <> ' + IntToStr(AppointmentFollowUpResultId);
    tbOtherFollowUp.Filtered := true;
  end;


  // register the global event handler for a specific form and event
  GlobalEvents.RegisterNameHandler(Self, 'TfmFollowUp', '', GEVENT_DataChanged, GlobalEventHandler);
end;

procedure TfrmOtherContact.grdContactRowChanged(Sender: TObject);
begin
  Letterbtn.Enabled := true;
  Faxbtn.Enabled := true;
  Emailbtn.Enabled := true;
  Editbtn.Enabled := true;
end;

procedure TfrmOtherContact.qryContactsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadEditedFlagMemTable(qryContacts, memqryContacts);
end;

procedure TfrmOtherContact.grdDocsDblClick(Sender: TObject);
var
  FileNamedocx,FileName: OleVariant;
  sRef: string;
  Form : TComponent;
begin
  inherited;
  sRef := qryDocuments.FieldByName('Reference').AsString;
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

procedure TfrmOtherContact.chkShowAllClick(Sender: TObject);
begin
  inherited;
  qryContacts.filtered := false;
  if not chkShowAll.Checked then begin
    qryContacts.filter   := 'Active = ''T''';
    qryContacts.filtered := true;
  end;
end;

procedure TfrmOtherContact.btnAddDateTimeClick(Sender: TObject);
begin
  inherited;
  edtNotes.Lines.Text := edtNotes.Lines.Text + ' :- (' + AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName +
    ') ' + FormatDateTime('dddd mmmm d yyyy " at " hh:mm AM/PM', Now) + #13#10;
  If EditNoAbort(qryCustomers) then
    qryCustomersNotes.AsString := edtNotes.Lines.Text;
  edtNotes.Update;
end;

procedure TfrmOtherContact.FormResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(TabCtl20, 2);
  TabCtl20.TabWidth := TabCtl20.TabWidth - 1;
end;

procedure TfrmOtherContact.cboCompanyTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  if cboCompanyType.Text = '' then Exit;
  FillTable.Edit;
  FillTable.FieldByName('CompanyTypeId').AsInteger := LookupTable.FieldByName('Id').AsInteger;
end;

procedure TfrmOtherContact.cboCompanyTypeEnter(Sender: TObject);
begin
  inherited;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
end;

procedure TfrmOtherContact.cmdFollowUpClick(Sender: TObject);
var
  aClientId, aFollowUpId: integer;
begin
  DisableForm;
  try
    inherited;
    aFollowupId := 0;
    aClientId := qryCustomers.FieldByName('ClientId').AsInteger;
    frmFollowUp.DoPhoneFollowUp(false, aClientId, aFollowUpId, Self.MyConnection, Self);
  finally
    EnableForm;
  end;
end;

function TfrmOtherContact.GetKeyString: string;
begin
  if qryCustomers.Active then
    result:= qryCustomersPrintname.AsString
  else
    result:= '';
end;

procedure TfrmOtherContact.GlobalEventHandler(const Sender: TObject; const Event: string; const Data: Pointer);
begin
  qryFollowUpResultType.Close;
  qryFollowUpResultType.Open;
  qryFollowUpType.Close;
  qryFollowUpType.Open;
  tbOtherFollowUp.Close;
  tbOtherFollowUp.Open;
end;

procedure TfrmOtherContact.grdFollowUpDblClick(Sender: TObject);
var
  Form: TBaseInputGUI;
begin
  inherited;
  //
  if (tbOtherFollowUp.State = dsInsert) and not tbOtherFollowUp.FieldByName('FollowUpDate').IsNull
      and not tbOtherFollowUp.FieldByName('TypeName').IsNull and not tbOtherFollowUp.FieldByName('ResultTypeName').IsNull then begin
    tbOtherFollowUp.Post;
  end;
  if tbOtherFollowUp.RecNo > 0 then
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

procedure TfrmOtherContact.cboFollowUpTypeNotInList(Sender: TObject; LookupTable: TDataSet;
  NewValue: string; var Accept: boolean);
begin
  Accept := False;
  if NewValue = '' then Exit;
  if CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    if TfmSimpleTypes.DoSimpleTypesAddNew(SimpleTypes_FollowUpType,NewValue) then begin
      LookupTable.Refresh;
      if LookupTable.Locate('Name',NewValue,[]) then begin
        EditDb(tbOtherFollowUp);
        tbOtherFollowUp.FieldByName('TypeId').AsInteger := LookupTable.FieldByName('Id').AsInteger;
        PostDb(tbOtherFollowUp);
      end;
    end;
  end;
end;

procedure TfrmOtherContact.cboMediaTypeEnter(Sender: TObject);
begin
  inherited;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
end;

procedure TfrmOtherContact.cboRepEnter(Sender: TObject);
begin
  inherited;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
end;

procedure TfrmOtherContact.cboFollowUpResultTypeNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
  Accept := False;
  if NewValue = '' then Exit;
  if CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    if TfmSimpleTypes.DoSimpleTypesAddNew(SimpleTypes_FollowUpResultType,NewValue) then begin
      LookupTable.Refresh;
      if LookupTable.Locate('Name',NewValue,[]) then begin
        EditDb(tbOtherFollowUp);
        tbOtherFollowUp.FieldByName('ResultTypeId').AsInteger := LookupTable.FieldByName('Id').AsInteger;
        PostDb(tbOtherFollowUp);
      end;
    end;
  end;
end;

procedure TfrmOtherContact.btnInactiveClick(Sender: TObject);
begin
  inherited;
  qryContacts.Edit;
  qryContacts.FieldByName('Active').AsString := 'F';
  qryContacts.Post;
  qryContacts.Close;
  qryContacts.Open;
end;

procedure TfrmOtherContact.cboCompanyTypeNotInList(Sender: TObject; LookupTable: TDataSet;
  NewValue: string; var Accept: boolean);
begin
//  inherited;
  Accept := False;
  if CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    if TfmSimpleTypes.DoSimpleTypesAddNew(SimpleTypes_CompanyType,NewValue) then begin
      Accept:= true;
      LookupTable.Refresh;
    end;
  end;
end;

procedure TfrmOtherContact.cboContactTypeEnter(Sender: TObject);
begin
  inherited;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
end;

procedure TfrmOtherContact.TabCtl20Changing(Sender: TObject; var AllowChange: boolean);
begin
  inherited;
  if not (qryCustomers.State in [dsEdit, dsInsert]) then begin
    qryCustomers.Edit;
  end;
  qryCustomers.Fieldbyname('company').asstring := Company.Text;
end;
procedure TfrmOtherContact.Makecompany;
begin
  if not fbclientnameMadeFromName then
    NamenPrintNameGridObj.Makecompany(fbUpdatingcompanyonName,qryCustomers);
  fbclientnameMadeFromName := False;
end;
procedure TfrmOtherContact.qryCustomersAfterPost(DataSet: TDataSet);
begin
  inherited;
  Makecompany;
  if KeyID = 0 then KeyID := qryCustomers.FieldByName('clientId').AsInteger;
end;

procedure TfrmOtherContact.btnOtherPhonesClick(Sender: TObject);
Var
  frm: TfrmClientsOtherPhone;
begin
  inherited;
  frm := TfrmClientsOtherPhone(GetComponentByClassName('TfrmClientsOtherPhone'));
  if Assigned(Frm) then begin
    frm.KeyID := qryCustomers.FieldByName('ClientID').AsInteger;
    frm.FormStyle := fsMDIChild;
    frm.BringToFront;
    Application.ProcessMessages;
  end;
end;

procedure TfrmOtherContact.grdContactKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if grdContact.GetActiveField.FieldName = 'ContactName' then
    CommonLib.MessageDlgXP_Vista('This is a read only field.'+#13+#10+'Please use the Edit or New button to modify it.', mtInformation, [mbOK], 0);
end;

procedure TfrmOtherContact.qrySuburbBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qrySuburb.Params.ParamByName('xRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

procedure TfrmOtherContact.edtNotesExit(Sender: TObject);
begin
  inherited;
  If EditNoAbort(qryCustomers) then
    qryCustomersNotes.AsString := edtNotes.Lines.Text;
end;

procedure TfrmOtherContact.edtPrintNameChange(Sender: TObject);
begin
  inherited;
  if Screen.ActiveControl = Sender then
    fbclientnameMadeFromName := False;
end;

procedure TfrmOtherContact.edtPrintNameExit(Sender: TObject);
begin
  inherited;
  if Trim(qryCustomers.FieldByname('PrintName').AsString) <> '' then PostDB(qryCustomers);
end;

procedure TfrmOtherContact.tbOtherFollowUpAfterScroll(DataSet: TDataSet);
  procedure FollowUpFieldsReadOnly(const Value: Boolean);
  begin
    tbOtherFollowUpFollowUpDate.ReadOnly := Value;
    tbOtherFollowUpTypeName.ReadOnly := Value;
    tbOtherFollowUpResultTypeName.ReadOnly := Value;
    tbOtherFollowUpNotes.ReadOnly := Value;
    tbOtherFollowUpEmployeeName.ReadOnly := Value;
    tbOtherFollowUpDone.ReadOnly := Value;
  end;
begin
  FollowUpFieldsReadOnly(tbOtherFollowUpLeadLineID.AsInteger <> 0);
end;

procedure TfrmOtherContact.Callcontactform(Sender: TDNMSpeedbutton);
Var
  Form : TComponent;
begin
  PostDB(qryCustomers);
  Form := GetComponentByClassName('TfrmContact');
  if Assigned(Form) then begin
    with TfrmContact(Form) do begin
      AttachObserver(self);
      if sender = EditBtn then
        KeyID := self.qryContacts.FieldByName('ContactID').AsInteger
      else KeyID := 0;
      ClientID := qryCustomersClientID.asInteger;
      ClientName:= qryCustomersCompany.asString;
      PassedConnection := Self.MyConnection;
      Showmodal;
    end;
  end;
end;

procedure TfrmOtherContact.UpdateMe;
begin
  inherited;
end;

procedure TfrmOtherContact.wwIButton2Click(Sender: TObject);
begin
  inherited;
  DeleteRecord(qryRelatedClients);
end;

procedure TfrmOtherContact.cboClientCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
  qryRelatedClientsChildCompany.AsString := cboClient.LookupTable.FieldByName('Company').AsString;

end;

procedure TfrmOtherContact.cboClientEnter(Sender: TObject);
begin
  inherited;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
end;

procedure TfrmOtherContact.cboClientNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
  // inherited;  {Cannot Created New Customer From Customer}
  Accept := False;
end;

procedure TfrmOtherContact.qryRelatedClientsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryRelatedClientsMasterClientID.AsInteger := qryCustomersClientID.AsInteger;
  qryRelatedClientsMasterCompany.AsString := qryCustomersCompany.AsString;
end;

procedure TfrmOtherContact.UpdateMe(const Cancelled: Boolean;
  const aObject: TObject);
begin
  inherited;
  if qryContacts.Active then
    qryContacts.Refresh;
  if (fLastComboAccessed = Suburb) or (fLastComboAccessed = BillSuburb) then
    fLastComboAccessed.LookupTable.Refresh;
  if Assigned(aObject) then begin
    if (aObject.Classname = 'TfrmContact') then begin
      if TfrmContact(aObject).Contact.IsPrimaryContact then begin
        PostDb(qryCustomers);
        qryCustomers.Refresh;
        EditDb(qryCustomers);
      end;
    end;
  end;

end;
function TfrmOtherContact.ChkCustReqdFields: boolean;
begin
  Result := ChkReqdFields('Othr');
  if not Result then TabCtl20.ActivePage := Custom_Fields;
end;

procedure TfrmOtherContact.AfterPopupformshow;
begin
  inherited;
  if Sysutils.SameText(CallingClassName , 'TContactListGUI') or
    Sysutils.SameText(CallingClassName , 'TGlobalsearchGUI')  then
    TabCtl20.Activepage := tabContacts;
end;
function TfrmOtherContact.ClientId: Integer;
begin
  Result := qryCustomersclientID.AsInteger;
end;

initialization
  RegisterClassOnce(TfrmOtherContact);
  with FormFact do begin
    (*RegisterMe(TfrmOtherContact, 'TRemindersListGUI_*_Other Contact FollowUp=ClientID');*)
    RegisterMe(TfrmOtherContact, 'TReminderListGUI_*_Other Contact FollowUp=ClientID');
    (*RegisterMe(TfrmOtherContact, 'TRemindersListGUI_Client_AppointmentOtherContact=ClientID');*)
    RegisterMe(TfrmOtherContact, 'TReminderListGUI_Client_AppointmentOtherContact=ClientID');
    RegisterMe(TfrmOtherContact, 'TfrmOthersList_*=ClientID');
    // note that the '?' is not a wild card - its an actual value
    RegisterMe(TfrmOtherContact, 'TGlobalListFrm_*_?=ID');
    RegisterMe(TfrmOtherContact, 'TAppointmentListGUI_Company_OtherContact=ClientID');
    (*RegisterMe(TfrmOtherContact, 'TMarketingLeadsGUI_Company_OtherContact=ClientID');*)
    RegisterMe(TfrmOtherContact, 'TCustomFieldValuesListLeadsGUI_Company_OtherContact=ClientID');
    RegisterMe(TfrmOtherContact, 'TGlobalListSearchFrm_*_Prospect(Contact)=ID');
    RegisterMe(TfrmOtherContact, 'TGlobalListSearchFrm_*_Prospect(Primary Contact)=ID');
    RegisterMe(TfrmOtherContact, 'TGlobalListSearchFrm_*_Prospect=ID');
    RegisterMe(TfrmOtherContact, 'TGlobalListFrm_*_Prospect(Contact)=ID');
    RegisterMe(TfrmOtherContact, 'TGlobalListFrm_*_Prospect=ID');
    RegisterMe(TfrmOtherContact, 'TMarketingContactListGUI_*_P=ClientID');
    RegisterMe(TfrmOtherContact, 'TClientListGUI_*_Other Contact=ClientID');
    RegisterMe(TfrmOtherContact, 'TContactListGUI_*_Other Contact=ClientID');
    RegisterMe(TfrmOtherContact, 'TGlobalsearchGUI_*_Other Contact=ClientID');
    RegisterMe(TfrmOtherContact, 'TOtherfollowupsGUI_*_Other Contact=ClientID');
    RegisterMe(TfrmOtherContact, 'TClientMainContactsGUI_*_Othercontact=ClientID');
    RegisterMe(TfrmOtherContact, 'TCustomFieldValuesListContactGUI_*_Prospect=ClientId');
  end;
end.






