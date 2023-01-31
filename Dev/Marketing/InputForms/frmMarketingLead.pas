unit frmMarketingLead;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,ERPdbComponents,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, DNMPanel, MessageInterface,
  wwdbdatetimepicker, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbedit,
  StdCtrls, DBCtrls, wwdblook, Mask, DNMSpeedButton, MemDS, ImgList,
  Wwdotdot, Wwdbcomb, MessageConst, Shader, busobjbase,
  BusObjMarketingLeads, ComCtrls, wwriched, ERPDbLookupCombo, ProgressDialog,
  HTMLUn2, HtmlView, IdMessage, FileAssociationDetails, frmAttachments,
  BusObjCustomFields;

type
  TfmMarketingLead = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    pnlTop: TDNMPanel;
    pnlBottom: TDNMPanel;
    cmdOK: TDNMSpeedButton;
    cmdClose: TDNMSpeedButton;
    btnFollowUp: TDNMSpeedButton;
    btnAppointment: TDNMSpeedButton;
    btnQuote: TDNMSpeedButton;
    btnInvoice: TDNMSpeedButton;
    Bevel3: TBevel;
    Bevel: TBevel;
    Bevel2: TBevel;
    Label7: TLabel;
    Label15: TLabel;
    LastTrainerID_Label: TLabel;
    Label9: TLabel;
    Cus_Alt_PH_Label: TLabel;
    Label6: TLabel;
    Label3: TLabel;
    Label22: TLabel;
    txtPhone: TwwDBEdit;
    txtAltPhone: TwwDBEdit;
    txtFax: TDBEdit;
    txtMoblie: TwwDBEdit;
    txtDays: TwwDBEdit;
    btnSalesOrder: TDNMSpeedButton;
    qryLeads: TERPQuery;
    qryLeadLines: TERPQuery;
    dsLeads: TDataSource;
    dsLeadLines: TDataSource;
    qryLeadLinesActionTypeName: TWideStringField;
    qryLeadLinesStatus: TWideStringField;
    qryEmployeeLookup: TERPQuery;
    qryEmployeeLookupEmployeeID: TIntegerField;
    qryEmployeeLookupEmployeeName: TWideStringField;
    cboEnteredBy: TwwDBLookupCombo;
    qryActionType: TERPQuery;
    qryActionTypeId: TIntegerField;
    qryActionTypeTypeCode: TWideStringField;
    qryActionTypeName: TWideStringField;
    qryActionTypeActive: TWideStringField;
    qryStatus: TERPQuery;
    IntegerField1: TIntegerField;
    StringField1: TWideStringField;
    StringField2: TWideStringField;
    StringField3: TWideStringField;
    txtCompany: TDBEdit;
    qryMarketingContact: TERPQuery;
    qryMarketingContactID: TIntegerField;
    qryMarketingContactFaxNumber: TWideStringField;
    qryMarketingContactPhone: TWideStringField;
    qryMarketingContactAltPhone: TWideStringField;
    qryMarketingContactMobile: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qrySimpleTypes: TERPQuery;
    StringField4: TWideStringField;
    IntegerField2: TIntegerField;
    StringField5: TWideStringField;
    StringField6: TWideStringField;
    qryLeadLinesGlobalRef: TWideStringField;
    qryLeadLinesLeadID: TIntegerField;
    qryLeadLinesLeadLineID: TIntegerField;
    qryLeadLinesActionType: TIntegerField;
    qryLeadLinesActionID: TIntegerField;
    qryLeadLinesFollowupID: TIntegerField;
    qryLeadLinesActionRef: TWideStringField;
    qryLeadLinesCreationDate: TDateTimeField;
    qryLeadLinesUpdateDate: TDateTimeField;
    qryLeadLinesFollowUpDate: TDateTimeField;
    qryLeadLinesStatusID: TIntegerField;
    qryLeadLinesPriority: TIntegerField;
    qryLeadLinesEmployeeID: TIntegerField;
    qryLeadLinesDuration: TWideStringField;
    qryLeadLinesTypeId: TIntegerField;
    qryLeadLinesTypeName: TWideStringField;
    qryLeadLinesHours: TFloatField;
    qryLeadLinesResultTypeId: TIntegerField;
    qryLeadLinesResultTypeName: TWideStringField;
    qryLeadLinesIsPhoneFollowUp: TWideStringField;
    qryLeadLinesEntryCount: TIntegerField;
    qryLeadLinesCreatedByID: TIntegerField;
    qryLeadLinesDone: TWideStringField;
    qryLeadLinesNotes: TWideMemoField;
    qryLeadLinesIsMarketing: TWideStringField;
    qryLeadLinesIsLead: TWideStringField;
    qryLeadLinesmsTimeStamp: TDateTimeField;
    dsEmployeeLookup: TDataSource;
    dsmarketingcontact: TDataSource;
    txtClientDetails: TMemo;
    qryLeadsGlobalRef: TWideStringField;
    qryLeadsLeadID: TIntegerField;
    qryLeadsMarketingContactID: TIntegerField;
    qryLeadsCompany: TWideStringField;
    qryLeadsClientID: TIntegerField;
    qryLeadsRepID: TIntegerField;
    qryLeadsEnteredByEmployeeID: TIntegerField;
    qryLeadsIsLead: TWideStringField;
    qryLeadsmsTimeStamp: TDateTimeField;
    qryMarketingContacts: TERPQuery;
    qryMarketingContactscompany: TWideStringField;
    qryMarketingContactsId: TIntegerField;
    qryMarketingContactsfirstName: TWideStringField;
    qryMarketingContactsLastName: TWideStringField;
    qryLeadsnotes: TWideStringField;
    qryActiontypes: TERPQuery;
    StringField7: TWideStringField;
    IntegerField3: TIntegerField;
    StringField8: TWideStringField;
    StringField9: TWideStringField;
    qryLeadLinesActionDate: TDateTimeField;
    Label1: TLabel;
    cboSource: TwwDBLookupCombo;
    qryMediaType: TERPQuery;
    qryLeadsEnteredBy: TWideStringField;
    cboRep: TwwDBLookupCombo;
    Label2: TLabel;
    qryRep: TERPQuery;
    StringField10: TWideStringField;
    IntegerField4: TIntegerField;
    qryLeadsRepName: TWideStringField;
    qryClient: TERPQuery;
    qryClientFaxNumber: TWideStringField;
    qryClientPhone: TWideStringField;
    qryClientAltPhone: TWideStringField;
    qryClientMobile: TWideStringField;
    qryMarketingContactSource: TWideStringField;
    qryClientMedTypeID: TIntegerField;
    qryClientSource: TWideStringField;
    qryClientNotes: TWideMemoField;
    qryMarketingContactNotes: TWideMemoField;
    qryClientClientID: TIntegerField;
    qryMarketingContactCOMPANY: TWideStringField;
    qryMarketingContactStreet: TWideStringField;
    qryMarketingContactStreet2: TWideStringField;
    qryMarketingContactStreet3: TWideStringField;
    qryMarketingContactSUBURB: TWideStringField;
    qryMarketingContactSTATE: TWideStringField;
    qryMarketingContactPOSTCODE: TWideStringField;
    qryMarketingContactCountry: TWideStringField;
    qryClientCompany: TWideStringField;
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
    qryClientGlobalRef: TWideStringField;
    qryClientClientTypeID: TIntegerField;
    qryClientABN: TWideStringField;
    qryClientTitle: TWideStringField;
    qryClientFirstName: TWideStringField;
    qryClientMiddleName: TWideStringField;
    qryClientLastName: TWideStringField;
    qryClientPosition: TWideStringField;
    qryClientEmail: TWideStringField;
    qryClientAltContact: TWideStringField;
    qryClientPhoneSupportTill: TDateField;
    qryClientContact1: TWideStringField;
    qryClientContact2: TWideStringField;
    qryClientContact1Phone: TWideStringField;
    qryClientContact2Phone: TWideStringField;
    qryClientCreationDate: TDateField;
    qryClientUpdateDate: TDateField;
    qryClientDateInactive: TDateField;
    qryClientClientNo: TWideStringField;
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
    qryClientCombinedSaleOrderBOID: TWideStringField;
    qryClientStopCredit: TWideStringField;
    qryClientRequired: TWideStringField;
    qryClientSecurityLevel: TIntegerField;
    qryClientForcePOOnBooking: TWideStringField;
    qryClientForcePOOnInvoice: TWideStringField;
    qryClientForcePOOnCustomer: TWideStringField;
    qryClientPickingPriority: TIntegerField;
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
    qryClientInvoiceCommentPopup: TWideStringField;
    qryClientSendXMLInvoices: TWideStringField;
    qryClientDefaultPurchaseOrderTemplateID: TIntegerField;
    qryClientStreet3: TWideStringField;
    qryClientBillStreet3: TWideStringField;
    qryClientIncludeOnIntrastat: TWideStringField;
    qryMarketingContactGlobalRef: TWideStringField;
    qryMarketingContactCompanyTypeName: TWideStringField;
    qryMarketingContactEmployeeSize: TWideStringField;
    qryMarketingContactActive: TWideStringField;
    qryMarketingContactJobTitle: TWideStringField;
    qryMarketingContactTitle: TWideStringField;
    qryMarketingContactFirstName: TWideStringField;
    qryMarketingContactMiddleName: TWideStringField;
    qryMarketingContactLastName: TWideStringField;
    qryMarketingContactEmail: TWideStringField;
    qryMarketingContactDateEntered: TDateTimeField;
    qryMarketingContactEnteredEmpID: TIntegerField;
    qryMarketingContactDateOfBirth: TDateField;
    qryMarketingContactDuration: TDateTimeField;
    qryMarketingContactmsTimeStamp: TDateTimeField;
    qryMarketingContactNumUnansweredCalls: TIntegerField;
    qryMarketingContactDoNotQualify: TWideStringField;
    qryMarketingContactClientID: TIntegerField;
    Label4: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    edEmail: TDBEdit;
    edWeb: TDBEdit;
    qryMarketingContactURL: TWideStringField;
    qryLeadStatus: TERPQuery;
    Label11: TLabel;
    qryLeadsLeadStatus: TWideStringField;
    cboLeadStatus2: TwwDBLookupCombo;
    qryLeadStatusid: TIntegerField;
    qryLeadStatusTypecode: TWideStringField;
    qryLeadStatusname: TWideStringField;
    qryEmployeeLookupActive: TWideStringField;
    qryLeadLinesEmployeeName: TWideStringField;
    btnPrint: TDNMSpeedButton;
    qryMarketingContactsstreet: TWideStringField;
    qryMarketingContactsstreet2: TWideStringField;
    qryMarketingContactsStreet3: TWideStringField;
    qryMarketingContactsSTATE: TWideStringField;
    qryMarketingContactsPOSTCODE: TWideStringField;
    qryMarketingContactsSUBURB: TWideStringField;
    Label12: TLabel;
    wwDBEdit1: TwwDBEdit;
    qryMarketingContactSkypeName: TWideStringField;
    qryClientSkypeName: TWideStringField;
    qryMarketingContactBillStreet: TWideStringField;
    qryMarketingContactBillStreet2: TWideStringField;
    qryMarketingContactBillStreet3: TWideStringField;
    qryMarketingContactBillSuburb: TWideStringField;
    qryMarketingContactBillState: TWideStringField;
    qryMarketingContactBillPostcode: TWideStringField;
    qryMarketingContactBillCountry: TWideStringField;
    TabCTL20: TPageControl;
    tabActionFollowup: TTabSheet;
    actCorrespondence: TTabSheet;
    lblFollowUpType: TLabel;
    grdActions: TwwDBGrid;
    SubformDetailsIButton: TwwIButton;
    cboActionType: TwwDBLookupCombo;
    cboStatus: TwwDBLookupCombo;
    cboPriority: TwwDBComboBox;
    dtActionDate: TwwDBDateTimePicker;
    cboLineEmployee: TwwDBLookupCombo;
    cboresultType: TwwDBLookupCombo;
    Label5: TLabel;
    memContactNotes: TDBMemo;
    qryCorrespondence: TERPQuery;
    qryCorrespondenceRefID: TIntegerField;
    qryCorrespondenceDate: TDateTimeField;
    qryCorrespondenceType: TWideStringField;
    qryCorrespondenceReference: TWideStringField;
    qryCorrespondenceMarketingContactID: TIntegerField;
    qryCorrespondenceMarketingContactName: TWideStringField;
    qryCorrespondenceActive: TWideStringField;
    qryCorrespondenceMessageFrom: TWideStringField;
    qryCorrespondenceMessageTo: TWideStringField;
    qryCorrespondenceMessageId: TWideStringField;
    qryCorrespondenceMessageData: TBlobField;
    dsCorrespondence: TDataSource;
    pnlDocumentsInner: TDNMPanel;
    Splitter1: TSplitter;
    pnlDocumentsList: TDNMPanel;
    Label96: TLabel;
    Label140: TLabel;
    grdDocs: TwwDBGrid;
    btnGetEmails: TButton;
    chkShowInactive: TCheckBox;
    pnlDocumentsMessage: TDNMPanel;
    HtmlViewer: THtmlViewer;
    lvAttachments: TListView;
    qryDocPath: TERPQuery;
    btnemail: TDNMSpeedButton;
    btnLetter: TDNMSpeedButton;
    btnFax: TDNMSpeedButton;
    tabAttachments: TTabSheet;
    qryMarketingContactsCustomer: TWideStringField;
    qryMarketingContactsSupplier: TWideStringField;
    qryMarketingContactsOtherContact: TWideStringField;
    pnlheader: TDNMPanel;
    lblMsg: TLabel;
    btnEmailAction: TDNMSpeedButton;
    cbomarketingcontact: TERPDbLookupCombo;
    btnTodo: TDNMSpeedButton;
    qryLeadsCreatedOn: TDateTimeField;
    qryLeadsmsUpdateSiteCode: TWideStringField;
    Label13: TLabel;
    wwDBEdit2: TwwDBEdit;
    Custom_Fields: TTabSheet;
    pnlCustFieldsTab: TDNMPanel;
    pgCustomFields: TPageControl;
    tabCustomFields: TTabSheet;
    pnlcustomfieldList: TDNMPanel;
    QrysalesCustomerPONum: TERPQuery;
    QrysalesCustomerPONumsaleID: TIntegerField;
    QrysalesCustomerPONumPONumber: TWideStringField;
    qryLeadLinessalesPONumber: TWideStringField;
    tmrNewLeadActionRecordCreated: TTimer;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdActionsDblClick(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure btnActionButtonClick(Sender: TObject);
    procedure txtCompanyDblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cbomarketingcontactExit(Sender: TObject);
    procedure cbomarketingcontactDropDown(Sender: TObject);
    procedure grdActionsColEnter(Sender: TObject);
    procedure SubformDetailsIButtonClick(Sender: TObject);
    procedure grdActionsRowChanged(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure qryLeadLinesBeforePost(DataSet: TDataSet);
    procedure cbomarketingcontactEnter(Sender: TObject);
    procedure cbomarketingcontactDblClick(Sender: TObject);
    procedure cboActionTypeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure edEmailClick(Sender: TObject);
    procedure cboLeadStatus2NotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure edWebClick(Sender: TObject);
    procedure cbomarketingcontactNotInList(Sender: TObject;
      LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
    procedure btnPrintClick(Sender: TObject);
    procedure cboSourceCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cbomarketingcontactAfterchange(Sender: TObject);
    procedure TabCTL20Resize(Sender: TObject);
    procedure chkShowInactiveClick(Sender: TObject);
    procedure grdDocsDblClick(Sender: TObject);
    procedure grdDocsRowChanged(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure HtmlViewerHotSpotClick(Sender: TObject; const SRC: string;
      var Handled: Boolean);
    procedure HtmlViewerImageRequest(Sender: TObject; const SRC: string;
      var Stream: TStream);
    procedure lvAttachmentsDblClick(Sender: TObject);
    procedure btnGetEmailsClick(Sender: TObject);
    //procedure EmailBtnClick(Sender: TObject);
    procedure btnemailClick(Sender: TObject);
    procedure btnFaxClick(Sender: TObject);
    procedure btnLetterClick(Sender: TObject);
    procedure cboActionTypeDblClick(Sender: TObject);
    procedure cboActionTypeNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
    procedure qryLeadsAfterOpen(DataSet: TDataSet);
    procedure grdActionsEnter(Sender: TObject);
    procedure btnEmailActionClick(Sender: TObject);
    procedure grdActionsCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure qryLeadLinesAfterScroll(DataSet: TDataSet);
    procedure cbomarketingcontactAfterUpdateMe(Sender: TObject);
    procedure cbomarketingcontactCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure qryLeadLinesBeforeOpen(DataSet: TDataSet);
    procedure tmrNewLeadActionRecordCreatedTimer(Sender: TObject);
    procedure qryMarketingContactsBeforeOpen(DataSet: TDataSet);
  private
    fbCreateAppointment :Boolean;
    NewActiontype:String;
    isnotinlist:boolean;
    tablename :String;
    SelectedMail: TIdMessage;
    HTMLImageStream: TMemoryStream;
    FileAssociationDetails: TFileAssociationDetails;
    MailProgesss: TProgressDialog;
    ProgressCanceled: boolean;
    AttachmentForm: TfmAttachments;
    fbcheckingforOtherMarketingRecord :Boolean;
    fbChangingMarketingcontact :Boolean;
    fsMarketingContactName :String;
    ApptDetails :String;
    function ShowFormWithObserver(Const aKeyID: Integer; Const aClassName: string): Boolean;
    procedure WMPostMsgToSelf(var Msg: TMessage); message WM_PostMsgToSelf;
    procedure OnChangeMarketingcontact;
    procedure CheckForEmails;
    procedure DoOnCheckForEmailsProgress(const msg: string; var Continue: boolean);
    procedure DoOnGetMessageCount(const MessageCount: integer);
    procedure DoOnProgressCancel(Sender: TObject);
    procedure checkforOtherMarketingRecord;
    procedure Initform;
    Procedure LockIfLEADLine;
    Function CreateaNewMcforclient:Boolean;
    procedure RefreshMCCombo(const MCID: Integer);
    procedure MakeEmail(CreateNewRecfrEmail:boolean);
    procedure ShowMCCombo;
    procedure REfreshSalesPONum;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    Lead: TLeads;
    Function CustomFieldExtenderListtype:TListType; Override;
    procedure UpdateMe; overload; override;
    procedure UpdateMe(const Cancelled: boolean; const aObject: TObject = nil); overload; override;
    Property CreateAppointment:Boolean read fbCreateAppointment write fbCreateAppointment;
    Procedure AssignMC(MCID:Integer);
    Property MarketingContactName :STring read fsMarketingContactName write fsMarketingContactName;

  published
  end;


implementation

uses
  CommonLib, FormFactory, BusObjConst,
  FastFuncs,frmSimpleTypes,
  BusobjMarketingcontacts, tcDataUtils, BusObjClient, AFQuickMail,
  AppEnvironment, CommonDbLib,ShellAPI,tcconst, BaseWebBrowser,
  DNMLib, SystemLib, ContentTypeObj, IdText, IdAttachmentFile,
  IdAttachmentMemory, HTTPUtil, IdHttp, IdAttachment,
  MailReaderObj, BusObjEmailConfig, frmCorrespondenceCreate, EmailConst,
  tcTypes, SMSUtilsGui, HTTPConst, DbSharedObjectsObj, LogLib;

{$R *.dfm}
procedure TfmMarketingLead.FormCreate(Sender: TObject);
begin
  AlignbuttonTopnHeight(pnlBottom);
  ApptDetails :='';
  MarketingContactName :='';
  fbcheckingforOtherMarketingRecord:= False;
  fbChangingMarketingcontact := False;
  cbomarketingcontact.LookupFormClassName := 'TClientsandMarketingcontactsListGUI';
  AddPhoneCallbutton(txtPhone);
  AddPhoneCallbutton(txtAltPhone);
  AddPhoneCallbutton(txtMoblie);
  AllowCustomiseGrid := False;
  inherited;
  FileAssociationDetails := TFileAssociationDetails.Create;
  HTMLImageStream := TMemoryStream.Create;
  self.AddFlag('FormInitialising');
  CreateAppointment := False;
  Lead := TLeads.Create(Self);
  Lead.BusObjEvent := DoBusinessObjectEvent;
  Lead.Connection := TMyDacDataConnection.Create(Lead);
  Lead.Connection.Connection := MyConnection;
//  Lead.ISLead := True;
  tablename := 'tmp_mcl' + commondblib.GetTemporaryTableNameSuffix;
  TabCTL20.ActivePageIndex := 0;

end;


procedure TfmMarketingLead.FormDestroy(Sender: TObject);
begin
  inherited;
  HTMLImageStream.Free;
  FileAssociationDetails.Free;
end;

procedure TfmMarketingLead.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    GuiPrefs.DbGridElement[grdActions].RemoveFields('LeadID,LeadLineID,FollowupID,StatusID,' +
      'EmployeeID,TypeID,ResultTypeID,CreatedByID');
    isnotinlist := False;
    Initform;
    DoDelayObjectProcedure(ShowMCCombo,50, Self.classname +'.ShowMCCombo');
    RealignTabControl(TabCTL20, 1);
    RealignTabControl(pgCustomFields, 1);
    if KeyID>0 then
      if Lead.Lines.Count >0 then begin
        Lead.Lines.Last;
        if Lead.Lines.ActionType = tcDataUtils.LeadActionLead then
          Lead.Lines.New;
      end;
  finally
    MarketingContactName := '';
    self.RemoveFlag('FormInitialising');
    EnableForm;
    if KeyId <> 0 then begin
        SetControlFocus(grdActions);
    end else


    begin
//      custom_fields.Enabled := false;
//      custom_Fields.Visible := false;
//      cmdNew.Click;
      SetControlFocus(cbomarketingcontact);
    end;
  end;
end;

Procedure TfmMarketingLead.Initform;
var
  DoNotOpenQueries: array of string;
begin
    if (KeyId =0) and (MarketingContactName <> '') then begin
      KeyId := getLeadID('Marketing Contact' , MarketingContactID(MarketingContactName));
    end;

    Lead.connection.BeginTransaction;
    Lead.Load(KeyID);
    if KeyID = 0 then begin
      Lead.New;
      Lead.PostDb;
      if Assigned(AttachmentForm) then
        AttachmentForm.TableId := Lead.ID;
      if MarketingContactName <> '' then begin
        Lead.company:=MarketingContactName;
        Lead.PostDB;
        Lead.EditDB;
      end;
      Lead.Lines;
    end else begin
      Lead.Lines;
      Lead.Marketingcontacts;

      if Lead.IsLead <> true then begin
        Lead.CreatedOn := now;
        Lead.Lines.new;
        Lead.Lines.Actiontype :=tcDataUtils.LeadActionLead ;
        Lead.Lines.IsLead := True;
        Lead.Lines.PostDB;
        Lead.IsLead := true;
        Lead.PostDb;

        Lead.Lines.new;
        Lead.Lines.Actiontype :=tcDataUtils.LeadActionFollowup ;
        Lead.Lines.IsLead := True;
        Lead.Lines.PostDB;

      end;
    end;
    if Lead.ClientID <> 0 then Begin
      Lead.Client;
      dsmarketingcontact.DataSet := qryClient;
    end;

    qryEmployeeLookup.Filter:= 'Active = "T" or EmployeeID = ' + qryLeadsEnteredByEmployeeID.AsString;
    qryEmployeeLookup.Filtered:= true;

    (*if KeyId <> 0 then begin
        SetcontrolFocus(txtCompany);
        cbomarketingcontact.visible := False;
    end else begin
        cbomarketingcontact.visible := true;
    end;*)

    if Self.ErrorOccurred then Exit;

    BringToFront;
    //qryMarketingContacts.ParamByName('MarketingContactId').AsInteger:= 0;
    Setlength(DonotOpenQueries, 5);
    DoNotOpenQueries[0] := 'qryLeads';
    DoNotOpenQueries[1] := 'qryLeadLines';
    DoNotOpenQueries[2] := 'qryMarketingContact';
    DoNotOpenQueries[3] := 'qryClient';
    DoNotOpenQueries[3] := 'qryCorrespondence';
    if keyid <> 0 then  begin
      Setlength(DonotOpenQueries, 5);
      DoNotOpenQueries[4] := 'qryMarketingContacts';
    end;
    OpenQueries(DoNotOpenQueries);

    if KeyID <> 0 then begin
      txtDays.Text := IntToStr(Lead.DaysSinceLastAction);
    end;

    if CreateAppointment then
        btnAppointment.click;

    txtClientDetails.Lines.clear;
    if Lead.ClientID <> 0 then Begin
      if (Lead.Client.FirstName <> '') or (Lead.Client.LastName <> '') then
        txtClientDetails.Lines.Add(Lead.Client.FirstName + ' ' + Lead.Client.LastName);
      txtClientDetails.Lines.Add(Lead.Client.ShipToAddress);
      txtClientDetails.Lines.Add(Lead.Client.Country);
    end else begin
      if Lead.MarketingContacts.Count <> 0 then begin
        txtClientDetails.Lines.Add(Lead.MarketingContacts.Fullname);
        if Lead.MarketingContacts.ShipToAddress <> '' then
          txtClientDetails.Lines.Add(Lead.MarketingContacts.ShipToAddress);
        if Lead.MarketingContacts.Country <> '' then
          txtClientDetails.Lines.Add(Lead.MarketingContacts.Country);
      end;
    end;

//    if Lead.MarketingContactID > 0 then
//      qryCorrespondence.ParamByName('MarketingContactID').AsInteger := Lead.MarketingContactID
//    else
//      qryCorrespondence.ParamByName('MarketingContactID').AsInteger := -1;
//
//    if chkShowInactive.Checked then
//      qryCorrespondence.ParamByName('ShowInactive').AsString := 'T'
//    else
//      qryCorrespondence.ParamByName('ShowInactive').AsString := 'F';
//    if not qryCorrespondence.Active then
//      qryCorrespondence.Open
//    else
//      qryCorrespondence.Refresh;

    Lead.Dirty := false;
end;
procedure TfmMarketingLead.LockIfLEADLine;
begin
  if Lead.Lines.ActionType  = LeadActionLead then begin
    grdActions.options := grdActions.options - [dgEditing];
    //grdActions.columnbyname('ActionTypeName').Readonly := True;
    cboActionType.enabled   := False;
    cboStatus.enabled       := False;
    cboPriority.enabled     := False;
    dtActionDate.enabled    := False;
    cboLineEmployee.enabled := False;
    cboresultType.enabled   := False;
  end else if accesslevel <= 2 then begin
    grdActions.options := grdActions.options + [dgEditing];
    //grdActions.columnbyname('ActionTypeName').Readonly := False;
    cboActionType.enabled   := True;
    cboStatus.enabled       := True;
    cboPriority.enabled     := True;
    dtActionDate.enabled    := True;
    cboLineEmployee.enabled := True;
    cboresultType.enabled   := True;
  end;
end;

procedure TfmMarketingLead.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  inherited;
end;

procedure TfmMarketingLead.grdActionsDblClick(Sender: TObject);
var
  frmPopup: TBaseInputGUI;
  lsSubsequentID: string;
begin
  inherited;

  if (grdActions.GetActiveField <> nil) (*and not Empty(grdActions.GetActiveField.AsString)*) then begin
    if grdActions.GetActiveField.FieldName = 'Notes' then
      exit;

    FormFact.FieldName := grdActions.GetActiveField.FieldName;
    ProcessingCursor(True);
    Enabled := False;
    try

           if Lead.Lines.ActionType = tcDataUtils.LeadActionAppointment     then lsSubsequentID := '_Appointment'
      else if Lead.Lines.ActionType = tcDataUtils.LeadActionFollowup        then lsSubsequentID := '_FollowUp'
      else if Lead.Lines.ActionType = tcDataUtils.LeadActionQuote           then lsSubsequentID := '_Quote'
      else if Lead.Lines.ActionType = tcDataUtils.LeadActionToDo            then lsSubsequentID := '_ToDo'
      else if Lead.Lines.ActionType = tcDataUtils.LeadActionSalesOrder      then lsSubsequentID := '_SalesOrder'
      else if Lead.Lines.ActionType = tcDataUtils.LeadActionInvoice         then lsSubsequentID := '_Invoice'
      else Exit;



      frmPopup := FormFact.CreateForm[ClassName + Chr(95) + grdActions.GetActiveField.FieldName + lsSubsequentID];

      if Assigned(frmPopup) then begin
        with frmPopup do try
            KeyID := qryLeadLinesActionID.AsInteger;

            frmPopup.CallingClassName := self.ClassName;

            AttachObserver(Self);

            if frmPopup.AccessLevel = 6 then begin //No Access
              frmPopup.Close;
              Exit;
            end;

            if not Visible then begin
              FormStyle := fsMDIChild; //Shows the form in MDIChild mode.
            end else begin
              OnShow(Self); //Needs this to refresh itself when a new KeyID is selected
            end;

            BringToFront;
          except
            raise;
          end;
      end else begin
        CommonLib.MessageDlgXP_Vista('No further information available on this column. ', mtInformation, [mbOK], 0);
      end;
    finally
      Enabled := True;
      ProcessingCursor(False);
    end;
    //    end;
  end;
end;

procedure TfmMarketingLead.grdActionsEnter(Sender: TObject);
begin
  inherited;
  LockIfLEADLine;
end;

procedure TfmMarketingLead.cmdOKClick(Sender: TObject);
begin
  PostDb(qryCorrespondence);
  if Lead.Save then begin
      Lead.connection.CommitTransaction;
      Application.ProcessMessages;
      if isModalForm then modalresult := mrOk else self.close;
      //Self.Close;
  end;
end;

procedure TfmMarketingLead.cmdCloseClick(Sender: TObject);
begin
//    Self.close;
      if isModalForm then modalresult := mrcancel else self.close;
end;

function TfmMarketingLead.CreateaNewMcforclient: Boolean;
var
  Client :Tclient;
  msg: string;
begin
  result:= False;
  if Lead.Company = '' then exit;
  client := TClient.CreateWithNewConn(nil);
  try
    client.Connection := Lead.Connection;
    client.LoadSelect('company = ' + Quotedstr(Lead.Company));
    if client.count =1 then begin
        LEad.connection.beginnestedtransaction;
        try
            if client.ConvertToMarketingContact(msg) = 0 then begin
              MessageDlgXP_Vista(client.TypeofclientRec + ' ' + quotedstr(client.ClientName) +' cannot be converted in to a Marketing contact.' + NL +  msg, mtWarning, [mbOK], 0);
              client.connection.RollbackNestedTransaction;
              exit;
            end else begin
              TimerMsg(lblMsg    ,quotedstr(client.ClientName) +' was a ' + client.TypeofclientRec +'.  Converted to a Marketing Contact' );
            end;
          client.connection.commitNestedtransaction;
          Lead.MarketingContactID := TMarketingContact.IDToggle(Lead.Company, TERPConnection(Lead.Connection.Connection));
          REsult:= Lead.MarketingContactID <> 0;
          if Lead.Lines.Dataset.locate('Actiontype' ,tcDataUtils.LeadActionLead , []) = False then begin
            Lead.Lines.new;
            Lead.Lines.Actiontype :=tcDataUtils.LeadActionLead ;
            Lead.Lines.IsLead := True;
            Lead.Lines.PostDB;

            Lead.Lines.new;
            Lead.Lines.Actiontype :=tcDataUtils.LeadActionFollowup ;
            Lead.Lines.IsLead := True;
            Lead.Lines.PostDB;
          end;


        except
          on E:Exception do begin
            client.connection.rollbacknestedtransaction;
          end;
        end;

    end;
  finally
    FreeandNil(client);
  end;


end;

function TfmMarketingLead.CustomFieldExtenderListtype: TListType;
begin
  Result := ltLeads;
end;

procedure TfmMarketingLead.btnActionButtonClick(Sender: TObject);
  function SenderToActionType: TLeadActions;
  begin
         if Sender = btnFollowUp then     Result := latFollowUp
    else if Sender = btnAppointment then  Result := latAppointment
    else if Sender = btnQuote then        Result := latQuote
    else if Sender = btnToDo  then        Result := latToDo
    else if Sender = btnInvoice then      Result := latInvoice
    else if Sender = btnSalesOrder then   Result := latSalesOrder
    else if sender = btnEmailAction then  result := latEmail
    else Result := latNone;
  end;
begin
    Lead.Lines.PostDB;
    Lead.Lines.Last;
    if Lead.Lines.Count > 0 then begin
      Lead.Lines.Done := true;
      Lead.Lines.PostDB;
    end;
    Lead.NewAction(SenderToActionType);
    grdActionsRowChanged(grdActions);
end;


procedure TfmMarketingLead.btnEmailActionClick(Sender: TObject);
begin
  inherited;
  MakeEmail(True);
end;

procedure TfmMarketingLead.btnemailClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    MakeEmail(True);
  finally
    EnableForm;
  end;
end;
Procedure TfmMarketingLead.MakeEmail(CreateNewRecfrEmail:boolean);
begin
  if Lead.MarketingContacts.currentEmailID = '' then begin
      if CommonLib.MessageDlgXP_Vista('The contact ' + Lead.MarketingContacts.Company +
        ' does not have an email address.' + #13 + #10 + 'Do you wish to load the email program anyway?',
        mtConfirmation, [mbYes, mbNo], 0)  = mrNo then Exit;
  end;
  if CreateNewRecfrEmail then begin
     Lead.Lines.New;
     Lead.Lines.ActionTypeName := 'Email';
     Lead.Lines.PostDB;
  end;
  MCCreateCorrespondence(ctEmail,self, LEad.MarketingContacts.FirstName, ApptDetails);
  self.BeginTransaction;
end;
procedure TfmMarketingLead.btnFaxClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    MCCreateCorrespondence(ctFax,self, LEad.MarketingContacts.FirstName);
  finally
    EnableForm;
  end;
end;

procedure TfmMarketingLead.btnGetEmailsClick(Sender: TObject);
begin
  inherited;
  CheckForEmails;
end;

procedure TfmMarketingLead.btnLetterClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    MCCreateCorrespondence(ctLetter,self, LEad.MarketingContacts.FirstName);
  finally
    EnableForm;
  end;
end;

procedure TfmMarketingLead.UpdateMe;
begin
  inherited;
  //UpdateMe(False, nil);
end;

procedure TfmMarketingLead.UpdateMe(const Cancelled: boolean; const aObject: TObject);
begin
  inherited;
  if  Cancelled then exit;
  if aObject =  nil then exit;

  isnotinlist := true;
  try
    if Assigned(aObject) and (aObject is TfmCorrespondenceCreate) then begin
      qryCorrespondence.Close;
      qryCorrespondence.Open;
      Lead.Lines.Notes := TfmCorrespondenceCreate(aObject).cboCorrespondencetype.Text + ' ' + Lead.Lines.Notes;
      Lead.Lines.PostDB;
    end else if Assigned(aObject) and aObject.ClassNameIs('TfrmCustomer') then begin
      Self.AddFlag('CustomerClosed');
      if dsmarketingcontact.DataSet = qryClient then begin
        dsmarketingcontact.DataSet.Close;
        dsmarketingcontact.DataSet.Open;
        dsmarketingcontact.DataSet.Locate('ClientID', TBaseInputGUI(aObject).KeyID, [])
      end;
    end else if Self.IsFlag('CustomerClosed', True) then begin
      PostMessage(Handle, WM_PostMsgToSelf, 0, 0);
    end else if fLastComboAccessed = cboActionType then begin
          fLastComboAccessed.LookupTable.Close;
          fLastComboAccessed.LookupTable.Open;
          closedb(qrySimpleTypes);
          opendb(qrySimpleTypes);
          if fLastComboAccessed.Lookuptable.locate('Name' ,NewActiontype , []) then    begin
            Lead.lines.ActiontypeName := NewActiontype;
            cboactiontype.text:= NewActiontype;
            Lead.lines.Actiontype:=qryActionTypeId.AsInteger;
            Lead.lines.PostDB;
          end;
    end else if Assigned(fLastComboAccessed) then begin
      if Assigned(aObject) and (aObject is TBaseInputGUI) then begin

          fLastComboAccessed.Text := '';
          if (Sysutils.SameText(fLastComboAccessed.Name, 'cbomarketingcontact')) then begin
              RefreshMCCombo(TBaseInputGUI(aObject).KeyID);
              SetFocusedControl(fLastComboAccessed);
              fLastComboAccessed.Text :=qryMarketingContactscompany.asString;
          end;
      end;
    end else begin


      dsmarketingcontact.DataSet.Close;
      dsmarketingcontact.DataSet.Open;
      if Assigned(aObject) and (aObject is TBaseInputGUI) and (aObject.Classnameis('TfrmOtherContact')) then begin
       if dsmarketingcontact.DataSet = qryMarketingContact then
          dsmarketingcontact.DataSet.Locate('ID', TBaseInputGUI(aObject).KeyID, [])
        else
          dsmarketingcontact.DataSet.Locate('ClientID', TBaseInputGUI(aObject).KeyID, []);
      end;
    end;
  finally
        isnotinlist := false;
  end;
end;
Procedure TfmMarketingLead.RefreshMCCombo(const MCID:Integer);
begin
              qryMarketingContacts.Close;
              //qryMarketingContacts.ParamByName('MarketingContactId').AsInteger:= MCID;
              qryMarketingContacts.Open;
              if qryMarketingContacts.active then
                if qryMarketingContacts.Locate('ID', MCID, []) then begin
                    Lead.MarketingContactID :=MCID;
                    isnotinlist := false;
                    OnChangeMarketingcontact;
                end;
end;
function TfmMarketingLead.ShowFormWithObserver(Const aKeyID: Integer; Const aClassName: string): Boolean;
var
  frmPopup: TBaseInputGUI;
begin
  inherited;
  Result := False;
  Processingcursor(True);
  Enabled := False;

  try
    frmPopup := TBaseInputGUI(GetComponentByClassName(aClassName));

    if Assigned(frmPopup) then begin
      with frmPopup do try
          KeyID := aKeyID;
          frmPopup.CallingClassName := self.ClassName;
          AttachObserver(Self);

          if frmPopup.AccessLevel = 6 then begin //No Access
            frmPopup.Close;
            Exit;
          end;

          if not Visible then begin
            FormStyle := fsMDIChild; //Shows the form in MDIChild mode.
          end else begin
            OnShow(Self); //Needs this to refresh itself when a new KeyID is selected
          end;

          BringToFrontSoon;
          Result := True;
        except
          raise;
        end;
    end else begin
      CommonLib.MessageDlgXP_Vista('Error showing client. ', mtInformation, [mbOK], 0);
    end;
  finally
    Enabled := True;
    Processingcursor(False);
  end;
end;

procedure TfmMarketingLead.WMPostMsgToSelf(var Msg: TMessage);
begin
end;

procedure TfmMarketingLead.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
begin
    inherited;
    if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TLeads then
          TLeads(Sender).Dataset := qryLeads
        else if Sender is TLeadLines then
          TLeadLines(Sender).Dataset := qryLeadLines
        else if Sender is TMarketingContact then
          TMarketingContact(Sender).Dataset := qryMarketingContact
        else if Sender is TClient then
          TClient(Sender).Dataset := qryClient;
    end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_MarketingcontactChanged) then begin
      OnChangeMarketingcontact;
    end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_Marketingcontact_ClientSelected) then begin
        if not CreateaNewMcforclient then begin
          Lead.Cancel;
          Exit;
        end;
        RefreshMCCombo(Lead.MarketingContactID);
    end else if (EventType = BusobjEvent_Event) and (Value = BusObjEvent_NewLeadActionRecord) then begin
      closeDB(qryActionType);       openDB(qryActionType);
      closeDB(qrySimpleTypes);      openDB(qrySimpleTypes);
    end else if (EventType = BusobjEvent_Event) and (Value = BusObjEvent_NewLeadActionRecordCreated) then begin
        tmrNewLeadActionRecordCreated.enabled := True;
    end else if (EventType = BusobjEvent_Event) and (Value = BusObjEvent_NewLeadAppointmentRecord) then begin
      ApptDetails := Lead.Lines.TransactionDetails;
      btnEmailAction.click;
		  ApptDetails := '';
    end
    else if (Eventtype = BusObjEvent_Dataset) and (Sender.IsdataIdchangeEvent(Value)) and (Sender is TMarketingContact ) then begin
      CloseDb(qryCorrespondence);
      qryCorrespondence.ParamByName('MarketingContactID').AsInteger := TMarketingContact(Sender).ID;
      if chkShowInactive.Checked then
        qryCorrespondence.ParamByName('ShowInactive').AsString := 'T'
      else
        qryCorrespondence.ParamByName('ShowInactive').AsString := 'F';
      OpenDb(qryCorrespondence);
    end;
end;

procedure TfmMarketingLead.DoOnCheckForEmailsProgress(const msg: string;
  var Continue: boolean);
begin
  if Assigned(MailProgesss) then begin
    MailProgesss.Message := msg;
    MailProgesss.StepIt;
    Continue := not ProgressCanceled;
  end;
end;

procedure TfmMarketingLead.DoOnGetMessageCount(const MessageCount: integer);
begin
  MailProgesss.MaxValue := MessageCount;
end;

procedure TfmMarketingLead.DoOnProgressCancel(Sender: TObject);
begin
  ProgressCanceled := true;
end;

procedure TfmMarketingLead.tmrNewLeadActionRecordCreatedTimer(Sender: TObject);
var
  fiid:Integer;
begin
  inherited;
  tmrNewLeadActionRecordCreated.enabled := False;
  fiid:= Lead.lines.id;
  try
    Lead.lines.closedb;
  finally
    Lead.lines.locate(Lead.lines.IDfieldname, fiid , []);
  end;
end;

procedure TfmMarketingLead.txtCompanyDblClick(Sender: TObject);
begin
  if Lead.clientID<> 0 then begin
    if Lead.Client.Customer then
      ShowFormWithObserver(Lead.ClientID, 'TfrmCustomer')
    else if Lead.Client.OtherContact then
      ShowFormWithObserver(Lead.ClientID, 'TfrmOtherContact');
  end else begin
    Lead.MarketingContacts.PostDb;
    ShowFormWithObserver(Lead.MarketingContactID, 'TfmMarketingContact');
  end;
end;

procedure TfmMarketingLead.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ErrorOccurred then Exit;
  CanClose := false;
  if Lead.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          if Lead.Save then begin
            Lead.Connection.CommitTransaction;
            CanClose := true;
          end;
        end;
      mrNo:
        begin
          Lead.Connection.RollbackTransaction;
          Lead.Dirty := false;
          CanClose := true;
        end;
      mrCancel:
        begin
          CanClose := false;
        end;
    end;
  end else begin
    CanClose := true;
  end;

  if canclose then begin
    try
      closedb(qryMarketingContacts);
    Except
        //kill the exception - when the list is too big close is giving a 'Lost connection; error
    end;
    CloseQueries;
  end;
end;

procedure TfmMarketingLead.OnChangeMarketingcontact;
Var
  tmpLeadID:Integer;
  MsgOption :Word;
  tempMCID:Integer;

  Function GetLeadID(Const MCID:Integer):Integer;
  begin
    with Lead.GetNewDataSet('SELECT tblmarketingleads.LeadID FROM tblmarketingleads WHERE tblmarketingleads.MarketingContactID =' + IntToStr(MCID), true) do try
      Result := FieldByName('LeadID').AsInteger;
    finally
        if active then close;
        Free;
    end;
  end;

begin
  if fbChangingMarketingcontact then exit;
  fbChangingMarketingcontact:= True;
  try
    (* if (cbomarketingcontact.text = '') or (cbomarketingcontact.SpecialItemSelected) then Exit; *)
    if Lead.MarketingContactID=0 then exit;
    tempMCID:=Lead.MarketingContactID;
    Lead.Marketingcontacts;
    if TempMCID =qryMarketingContactsId.asInteger then
    else if qryMarketingContactsId.asInteger <> 0 then begin
      if (lead.id<> 0) and Lead.Dirty then begin
          MsgOption := CommonLib.MessageDlgXP_Vista('Do you Wish To Save The Changes?' , mtConfirmation , [mbYes, mbNo, mbCancel], 0);
          if MsgOption = mrcancel then exit;
          if MsgOption = mrNo then begin
              Lead.Connection.RollbackTransaction;
              Lead.Dirty := false;
          end else if MsgOption = mrYes then begin
             if Lead.Save then begin
              Lead.Connection.CommitTransaction;
             end else begin
              Exit;
            end;
          end;
      end else begin
        Lead.Connection.RollbackTransaction;
        Lead.Dirty := false;
      end;

      Lead.Connection.BeginTransaction;
      tmpLeadID := GetLeadID(TempMCID);
      if tmpLeadID <> 0 then begin
          Lead.Load(tmpLeadID);
          TabCTL20.ActivePage := tabActionFollowup;
          MessageDlgXP_Vista('A Lead record already exists for this marketing contact.', mtInformation, [mbOK], 0);
      end else begin
          if lead.dataset.state <> dsinsert then
              Lead.NEw;
          Lead.MarketingContactID :=qryMarketingContactsId.asInteger;
          Lead.IsLead := true;
          Lead.PostDB;
      end;
      Lead.IsLead := True;
      Lead.PostDB;
      Lead.MarketingContacts;
      if Lead.Lines.count = 0 then Lead.Lines.New;
    end;
    if (KeyId=0) then checkforOtherMarketingRecord;
    if Lead.MarketingContactId >0 then begin
      txtClientDetails.Lines.Clear;
      txtClientDetails.Lines.Add(Lead.MarketingContacts.PrimaryContact.FullName);
      txtClientDetails.Lines.Add(Lead.MarketingContacts.ShipToAddress);
      txtClientDetails.Lines.Add(Lead.MarketingContacts.Country);
    end;
  finally
    fbChangingMarketingcontact:= False;
  end;
end;
Procedure TfmMarketingLead.ShowMCCombo;
begin
try
    if KeyId <> 0 then begin
        try
          SetcontrolFocus(txtCompany);
        Except
          on E:Exception do begin
            if devmode then MessageDlgXP_Vista(E.message, mtWarning, [mbOK], 0);
          end;
        end;
        cbomarketingcontact.visible := False;
    end else begin
        cbomarketingcontact.visible := true;
    end;
Except
  on E:Exception do begin
    //if devmode then MessageDlgXP_Vista(E.message, mtWarning, [mbOK], 0);
  end;
end;
end;
procedure TfmMarketingLead.checkforOtherMarketingRecord;
var
  LeadId:Integer;
  IsLead:Boolean;
  //Msgoption :Word;
begin
  if fbcheckingforOtherMarketingRecord then exit;
  fbcheckingforOtherMarketingRecord := True;
  try
  Lead.checkforOtherMarketingRecord(LeadId, isLead);
  if LeadId <> 0 then begin
    (*if IsLead then Msgoption:= MessageDlgXP_vista('Another Lead record already exists for this marketing contact. Do you want to open it?', mtConfirmation, [mbYes, mbNo], 0)
    else Msgoption:= MessageDlgXP_vista('Another Telemarketing record already exists for this marketing contact. Do you want to convert it to a Lead and open it?', mtConfirmation, [mbYes, mbNo], 0);
    if Msgoption = mrNo then begin
      Lead.Connection.RollbackTransaction;
      Lead.Dirty := false;
      KeyId:=0;
      Initform;
      Setcontrolfocus(cbomarketingcontact);
    end else begin*)
      Lead.Connection.RollbackTransaction;
      Lead.Dirty := false;
      KeyId:=LeadID;
      Initform;
      DoDelayObjectProcedure(ShowMCCombo,50, Self.classname +'.ShowMCCombo');
      if Lead.Lines.Dataset.locate('Actiontype' ,tcDataUtils.LeadActionLead , []) = False then begin
        Lead.Lines.new;
        Lead.Lines.Actiontype :=tcDataUtils.LeadActionLead ;
      //  Followups.Lines.Actiontype :=tcDataUtils.LeadActionFollowup ; {todo: do we need a line to be lead}
        Lead.Lines.IsLead := True;
        TimerMsg(lblMsg    ,'A Telemarketing record already exists for this Marketing Contact which is converted into a Lead and opened.  Please close the form and reopen for a new Lead record.', 30);
        Lead.Lines.PostDB;

        Lead.Lines.new;
        Lead.Lines.Actiontype :=tcDataUtils.LeadActionFollowup ;
        Lead.Lines.IsLead := True;
        Lead.Lines.PostDB;

      end else begin
        TimerMsg(lblMsg    ,'Another Lead record already exists for this marketing contact.  Please close the form and reopen for a new Lead record.', 30);
      end;

    (*end;*)
  end;
  finally
    fbcheckingforOtherMarketingRecord := False;
  end;
end;
procedure TfmMarketingLead.TabCTL20Resize(Sender: TObject);
begin
  inherited;
  if not self.IsFlag('FormInitialising') then
    RealignTabControl(TabCTL20, 1);
end;

procedure TfmMarketingLead.cbomarketingcontactExit(Sender: TObject);
begin
  inherited;
  try
    if isnotinlist then begin
        if Assigned(frmToPopup) then
        SetControlFocus(frmToPopup);
        exit;
    end;
    if cbomarketingcontact.text = '' then begin
        SetControlFocus(cbomarketingcontact);
        Exit;
    end;
  Except
    on E:Exception do begin
      //if devmode then MessageDlgXP_Vista(E.message, mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TfmMarketingLead.cbomarketingcontactDropDown(Sender: TObject);
begin
  inherited;
  if (lead.count = 0) and (lead.dataset.state <> dsinsert) then Lead.new;
  if (KeyId = 0) and (Lead.Dataset.RecordCount > 0) then
    KeyId := Lead.DataSet.FieldByName('LeadId').asInteger;
  Lead.ISLead := true;
end;
procedure TfmMarketingLead.SubformDetailsIButtonClick(Sender: TObject);
begin
  inherited;
    if Lead.Lines.IsTransationREcord  then begin
        if CommonLib.MessageDlgXP_Vista('This has a Linked ' + Lead.Lines.ActionTypeName +' record. Do you want to open this ' + Lead.Lines.ActionTypeName +' record?', mtConfirmation, [mbyes, mbNo], 0) = mrYes then
            grdActionsDblClick(grdActions);
    end else if Lead.Lines.ActionType =LeadActionLead then begin
        CommonLib.MessageDlgXP_Vista('This is a conversion record(Telemarketing to Lead).Its not possible to delete it.' , mtInformation , [mbok],0);
    end else begin
        if CommonLib.MessageDlgXP_Vista('Do you want to delete this ' + Lead.Lines.ActionTypeName +' record?', mtConfirmation, [mbyes, mbNo], 0) = mrYes then
            Lead.DeleteCurLines;
    end;
end;

procedure TfmMarketingLead.grdActionsRowChanged(Sender: TObject);
begin
    inherited;
    LockIfLEADLine;
    if self <> screen.activeform then exit;
    if (Sysutils.SameText(grdActions.GetActiveField.fieldNAme , 'Notes')) then
        grdActions.options := grdActions.options + [dgEditing]
    else if ((Lead.Lines.Dataset.State = dsBrowse) and
             (Lead.Lines.IsTransationRecord)) or
            (Lead.Lines.IsLead = False) then
    else if (Sysutils.SameText(grdActions.GetActiveField.fieldName , 'Done')) then begin
      if grdActions.GetActiveField.AsBoolean then
        grdActions.options := grdActions.options - [dgEditing]
      else
        grdActions.options := grdActions.options + [dgEditing];
    end
    else if ((Lead.Lines.Dataset.State = dsBrowse) and
             (Lead.Lines.IsTransationRecord)) or (Lead.Lines.IsLead = False) then
    else   if ((qryLeadLines.State = dsBrowse) and
               (Lead.Lines.IsTransationRecord)) or
              (Lead.Lines.IsLead = False) then
             grdActions.options := grdActions.options - [dgEditing]
    else grdActions.options := grdActions.options + [dgEditing] ;
            //grdActions.SetActiveField('notes');
end;

procedure TfmMarketingLead.grdDocsDblClick(Sender: TObject);
var
  FileNamedocx,FileName: string;
  FileNotFound: boolean;
  sRef: string;
//  Form : TComponent;
  IdMessage: TIdMessage;
  Stream: TStream;
  Field: TField;
begin
  inherited;
  Field := grdDocs.GetActiveField;
  if Assigned(Field) and (Field = qryCorrespondenceActive) then begin
    exit;
  end;

  if SameText(qryCorrespondenceType.AsString, 'Email') and (qryCorrespondenceMessageId.AsString <> '') then begin
    { this is an email }
    FileName := SystemLib.GetAppTempDir + '\' + qryCorrespondenceMessageId.AsString + '.eml';
    IdMessage := TIdMessage.Create;
    try
      Stream := qryCorrespondence.CreateBlobStream(qryCorrespondenceMessageData,bmRead);
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
  sRef := qryCorrespondenceReference.AsString;

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
  end
  else begin
    ShellExecute(Handle, 'Open', PChar(FileName), '', '', SW_SHOWNORMAL);
  end;

//  if AppEnv.Employee.UseWord then begin // trying new approach here...
//    if FileExists(FileName) then ShellExecute(Handle, 'Open', PChar(FileName), '', '', SW_SHOWNORMAL)
//    else FileNotFound := true;
//  end
//  else begin
//    if FileExists(FileName) then begin
//      Form := GetComponentByClassName('TREMainClient');
//      if Assigned(Form) then begin
//        with TREMainClient(Form) do begin
//          Referencetxt.Text := SRef;
//          Edit1.Text := 'True';
//          FormStyle := fsMDIChild;
//          BringToFront;
//        end;
//      end;
//    end else FileNotFound := true;
//  end;

  if FileNotFound then CommonLib.MessageDlgXP_Vista('The file ''' + FileName + ''' does not exist', mtWarning, [mbOK], 0);
end;

procedure TfmMarketingLead.grdDocsRowChanged(Sender: TObject);
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
  if qryCorrespondenceMessageId.AsString <> '' then begin
    if not Assigned(SelectedMail) then begin
      SelectedMail := TIdMessage.Create(self);
    end;
    Stream := qryCorrespondence.CreateBlobStream(qryCorrespondenceMessageData,bmRead);
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
    if SameText(qryCorrespondenceType.AsString,'Email') then begin
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

procedure TfmMarketingLead.HtmlViewerHotSpotClick(Sender: TObject;
  const SRC: string; var Handled: Boolean);
begin
  inherited;
  if SameText(grdDocs.DataSource.DataSet.FieldByName('Type').AsString,'Voice') then
    SMSUtilsGui.PlayMessages(SRC)
  else
    ShellExecute(0,'open',PChar(SRC),nil,nil,SW_NORMAL)
end;

procedure TfmMarketingLead.HtmlViewerImageRequest(Sender: TObject;
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

procedure TfmMarketingLead.lvAttachmentsDblClick(Sender: TObject);
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

procedure TfmMarketingLead.grdActionsCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if Lead.Lines.Actiontype =tcDataUtils.LeadActionLead  then begin
    Afont.color := clInactiveCaption;
  end;
  if sametext(field.fieldname , QryleadlinesActionid.fieldname) or
     sametext(field.fieldname , qryLeadLinessalesPONumber.fieldname) then
      if (Lead.Lines.ActionType = tcDataUtils.LeadActionQuote) or (Lead.Lines.ActionType = tcDataUtils.LeadActionSalesOrder) or (Lead.Lines.ActionType = tcDataUtils.LeadActionInvoice) then
      else Afont.color := ABrush.color ;
end;

procedure TfmMarketingLead.grdActionsColEnter(Sender: TObject);
begin
  inherited;
    if self <> screen.activeform then exit;
    if Sysutils.SameText(grdActions.GetActiveField.fieldNAme , 'Status') then
        grdActions.SetActiveField('Priority') ;
    grdActionsRowChanged(grdActions);
end;
procedure TfmMarketingLead.FormResize(Sender: TObject);
begin
  if not self.IsFlag('FormInitialising') then
    RealignTabControl(TabCTL20, 1);
end;

procedure TfmMarketingLead.qryLeadLinesAfterScroll(DataSet: TDataSet);
begin
  inherited;
  self.qryEmployeeLookup.ParamByName('EmployeeName').AsString := qryLeadLinesEmployeeName.AsString;
end;

procedure TfmMarketingLead.qryLeadLinesBeforeOpen(DataSet: TDataSet);
begin
  REfreshSalesPONum;
end;
procedure TfmMarketingLead.REfreshSalesPONum;
var
  qry: TERPQuery;
  SaleIDs:String;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Lead.connection.connection);
  try
    closedb(qry);
    qry.sql.text := qryLeadLines.SQL.text;
    qry.filter := ' Actiontype =' + inttostr(GetSimpleType('Invoice', SimpleTypes_LeadActionType)) +' or '+
                  ' Actiontype = ' + inttostr(GetSimpleType('SalesOrder', SimpleTypes_LeadActionType)) +' or '+
                  ' Actiontype = ' + inttostr(GetSimpleType('Quote', SimpleTypes_LeadActionType));
    qry.open;
    qry.filtered:= true;
    SaleIDs:=qry.Groupconcat('ActionID');
    if SaleIDs ='' then SaleIDs := '0';
    closedb(QrysalesCustomerPONum);
    QrysalesCustomerPONum.sql.text := 'SELECT saleID, PONumber FROM tblsales where saleId in (' + SaleIDs +')';
    QrysalesCustomerPONum.connection := qryLeadLines.connection;
    opendb(QrysalesCustomerPONum);
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TfmMarketingLead.qryLeadLinesBeforePost(DataSet: TDataSet);
begin
  inherited;
//    qryLeadLines.fieldByname('Notes').asString := edtNotes.Text;
end;

procedure TfmMarketingLead.qryLeadsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryLeadsCreatedOn.DisplayFormat := FormatSettings.ShortDateFormat;
  If not Assigned(AttachmentForm) then Begin
    AttachmentForm := TfmAttachments(GetComponentByClassName('TfmAttachments',False,Self,True,True,qryLeadsLeadID.AsInteger));
    AttachmentForm.DBConnection := MyConnection;
    AttachmentForm.AttachObserver(Self);
    AttachmentForm.TableName := 'tblMarketingLeads ';
    AttachmentForm.TableId := qryLeadsLeadID.AsInteger;
    AttachmentForm.Tag := qryLeadsLeadID.AsInteger;
    AttachmentForm.lvAttachments.Parent := tabAttachments;
    AttachmentForm.lvAttachments.Align := alClient;
    AttachmentForm.PopulateListView;
  end;
end;

procedure TfmMarketingLead.qryMarketingContactsBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  logtext(qryMarketingContacts.SQLtext);
end;

procedure TfmMarketingLead.cbomarketingcontactEnter(Sender: TObject);
begin
  inherited;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
end;

procedure TfmMarketingLead.cbomarketingcontactAfterchange(Sender: TObject);
begin
  inherited;
  SetControlFocus(grdActions);
end;

procedure TfmMarketingLead.cbomarketingcontactAfterUpdateMe(Sender: TObject);
begin
  inherited;
  if (Lead.MarketingContactID <> 0) and  ((Lead.Lines.count =0) or (Lead.Lines.Locate('Actiontype' , tcDataUtils.LeadActionLead  , []) = False)) then begin
        Lead.Lines.new;
        Lead.Lines.Actiontype :=tcDataUtils.LeadActionLead ;
        Lead.Lines.IsLead := True;
        Lead.Lines.Done := True;
        Lead.Lines.PostDB;
        Lead.IsLead := true;
        Lead.PostDb;

        Lead.Lines.new;
        Lead.Lines.Actiontype :=tcDataUtils.LeadActionFollowup ;
        Lead.Lines.IsLead := True;
        Lead.Lines.PostDB;
  end;
end;

procedure TfmMarketingLead.cbomarketingcontactCloseUp(Sender: TObject;  LookupTable, FillTable: TDataSet; modified: Boolean);
var
  aleadid:Integer;
  aIsLead:boolean;
begin
  inherited;
  Lead.CheckforOtherMarketingRecord(aleadid, aIsLead);
  if (aleadid <> 0) and (aleadid <> Lead.ID) then   begin
    Lead.Connection.RollbackTransaction;
    Lead.Dirty := false;
    Lead.Connection.beginTransaction;
    KeyID :=  aLeadID;
    Lead.Load(KeyID);
  end;
end;

procedure TfmMarketingLead.cbomarketingcontactDblClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TfmMarketingLead.cboActionTypeCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
//Var
//  QuickMail: TAFQuickMail;
begin
  If not modified then Exit;
  inherited;
  if Sysutils.SameText(cboActionType.text ,'Email') then Begin
//    QuickMail := TAFQuickMail.Create(Self);
//    try
//      QuickMail.ResetAll;
//      QuickMail.ToEmail.Text := dsmarketingcontact.DataSet.FieldByName('Email').AsString;
//      QuickMail.Subject :=  Appenv.Companyprefs.DefaultEmailSubject;
//      QuickMail.TextToSend.text := Appenv.Companyprefs.DefaultEmailText;
//      QuickMail.ShowDialog := (AppEnv.CompanyPrefs.DefaultMailClientPreview) or (QuickMail.ToEmail.Text = '');
//      Application.ProcessMessages;
//      if not(QuickMail.ShowDialog) then
//        if MessageDlgXP_Vista('In the Company Preference you have selected an option not to Preview the Email.  This will Send an Email to ' + Lead.company+'.  Do you Wish to Continue?' , mtconfirmation , [mbyes, mbno] , 0) = mrno then exit;
//      QuickMail.Execute;
//    finally
//      FreeandNil(QuickMail);
//    end;
      MakeEmail(False);
  end;
end;

procedure TfmMarketingLead.cboActionTypeDblClick(Sender: TObject);
begin
  inherited;
  TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_LeadActionType,  Lead.lines.ActiontypeName);
end;

procedure TfmMarketingLead.cboActionTypeNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  fLastComboAccessed := cboActionType;
  NewActiontype := cboActionType.Text;
  if CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtconfirmation, [mbyes, mbno], 0) = mrYes then begin
    TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_LeadActionType, NewValue, Self);
  end;
  Accept := False;
end;

procedure TfmMarketingLead.edEmailClick(Sender: TObject);
//var
//  SavedCursor:TCursor;
//  sString:string;
begin
  inherited;
  if edEmail.Text = '' then exit;

  DisableForm;
  try
    MCCreateCorrespondence(ctEmail,self, LEad.MarketingContacts.FirstName);
  finally
    EnableForm;
  end;



//  inherited;
  //open default email
//  if TDBEdit(Sender).Text <> '' then begin
//    Processingcursor(True);
//    try
//      sString := 'mailto:' + TDBEdit(Sender).Text + '?Subject=Confirmation ' + '&body=' ;
//      ShellExecute(0, nil, PChar(sString), '', '', SW_SHOWDEFAULT);
//    finally
//      Processingcursor(False);
//    end;
//  end;
end;


procedure TfmMarketingLead.cboLeadStatus2NotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
  var
  iResult :integer;
//  frm:TComponent;
begin
  inherited;
  if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnCanCreateSalesStatus') <> 1 then begin
    MessageDlgXP_Vista('You are not Allowed to Create Status', mtInformation, [mbOK], 0);
    Accept := False;
    Exit;
  end;
  Processingcursor(True);
  try
    iResult := CommonLib.MessageDlgXP_Vista('The Lead Status You Have Specified is Currently Not Known.  Would You Like to Add This to the Collection List?',
      mtConfirmation, [mbOK, mbCancel], 0);
    if iResult = mrOk then begin
//      TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_LeadStatusType, NewValue);
      Accept := TfmSimpleTypes.DoModalSimpleTypesEdit(SimpleTypes_LeadStatusType, NewValue) = mrOK;
      // Must reload to avoid problems with cancelled addition and deleted stuff
      qryLeadStatus.Close;
      qryLeadStatus.Open;
      // value could be deleted in the SimpleTypeEdit
      if Accept then
      begin
        qryLeadStatus.Locate('Name', NewValue, [loCaseInsensitive]);
        cboLeadStatus2.Text := NewValue;
      end;
    end;
  finally
    Processingcursor(False);
  end;
end;

procedure TfmMarketingLead.edWebClick(Sender: TObject);
begin
  inherited;
  if Trim(edWeb.text) = '' then exit;
      with TBaseWebBrowserGUI(GetComponentByClassName('TBaseWebBrowserGUI' , True , self , False )) do try
        WebAddress := edWeb.text;
        showmodal;
      finally
        free;
      end;
end;

(*procedure TfmMarketingLead.EmailBtnClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    if Lead.MarketingContacts.Email = '' then begin
      if CommonLib.MessageDlgXP_Vista('The contact ' + Lead.MarketingContacts.Company +
        ' does not have an email address.' + #13 + #10 + 'Do you wish to load the email program anyway?',
        mtConfirmation, [mbYes, mbNo], 0)  = mrNo then Exit;
    end;
    MCCreateCorrespondence(ctEmail,self, LEad.MarketingContacts.FirstName);

  finally
    EnableForm;
  end;
end;*)

procedure TfmMarketingLead.cbomarketingcontactNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
  (*if (sender = cbomarketingcontact) then
    if trim(cbomarketingcontact.Text) <> '' then begin
      cbomarketingcontact.DoSelectFromList;
      Exit;
    end;*)
  OnComboNotInList(Sender, LookupTable, NewValue, Accept);
end;

procedure TfmMarketingLead.AssignMC(MCID: Integer);
begin
  if qryMarketingContacts.Locate('ID', MCID , []) then   begin
    cbomarketingcontact.text :=qryMarketingContactscompany.asString;
    OnChangeMarketingcontact;
  end;
end;

procedure TfmMarketingLead.btnPrintClick(Sender: TObject);
var
  strSql:String;
begin
  inherited;
  if not Lead.Save then exit;
  Lead.connection.CommitTransaction;
  strSQL:= '~|||~ where ML.LeadId = ' +IntToStr(Lead.ID);
  fbReportSQLSupplied := False;
  PrintTemplateReport('Lead' , StrSQL , not AppEnv.Employee.ShowPreview , 1);
  if AppEnv.Employee.CloseOnPrint then
    self.close
  else
    self.BeginTransaction;
end;

procedure TfmMarketingLead.cboSourceCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if lead.MarketingContactID = 0 then exit;
  if Sysutils.SameText(cboSource.text,lookuptable.fieldbyname('MediaType').asString) then
  else begin
    //if dsmarketingcontact.dataset = qryMarketingContact then begin
      if lead.userlock.lock('tblmarketingcontacts' ,lead.MarketingContactID, lead.LockGroupName)  then begin
        lead.MarketingContacts.Source:=lookuptable.fieldbyname('MediaType').asString;
        lead.MarketingContacts.PostDB;
      end else begin
          MessageDlgXP_Vista(replacestr(lead.userlock.LockMessage , 'Unable to update data.' , 'Unable to change Source of Marketing Contact.') , mtWarning, [mbok] , 0);
      end;
    (*end else *)if dsmarketingcontact.dataset = qryClient then begin
      if lead.userlock.lock('tblclients' ,lead.ClientID, lead.LockGroupName)  then begin
        lead.client.Sourcename:=lookuptable.fieldbyname('MediaType').asString;
        lead.client.PostDB;
      end else begin
          MessageDlgXP_Vista(replacestr(lead.userlock.LockMessage , 'Unable to update data.' , 'Unable to change Source of Client.') , mtWarning, [mbok] , 0);
      end;
    end;
  end;
end;

procedure TfmMarketingLead.CheckForEmails;
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
    MailReader.Connection := TERPConnection(qryCorrespondence.Connection);
    MailConfig.Connection := TMyDacDataConnection.Create(MailConfig);
    MailConfig.Connection.Connection := qryCorrespondence.Connection;
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
  CloseDb(qryCorrespondence);
  OpenDb(qryCorrespondence);
end;

procedure TfmMarketingLead.chkShowInactiveClick(Sender: TObject);
begin
  inherited;
    if chkShowInactive.Checked then
      qryCorrespondence.ParamByName('ShowInactive').AsString := 'T'
    else
      qryCorrespondence.ParamByName('ShowInactive').AsString := 'F';
    qryCorrespondence.Refresh;
end;

initialization
  RegisterClassOnce(TfmMarketingLead);
  with FormFact do begin
    (*RegisterMe(TfmMarketingLead, 'TRemindersListGUI_*_Lead FollowUp=ID');*)
    RegisterMe(TfmMarketingLead, 'TReminderListGUI_*_Lead FollowUp=ID');
    RegisterMe(TfmMarketingLead, 'TMarketingLeadsGUI_*=LeadID');
    RegisterMe(TfmMarketingLead, 'TMarketingContactGUI_*=LeadId');
    RegisterMe(TfmMarketingLead, 'TMarketingContactListDetailGUI_*_Lead=LeadId');
    RegisterMe(TfmMarketingLead, 'TfrmSalesPipelineReport_*=LeadID');
    RegisterMe(TfmMarketingLead, 'TMarketingContactGUI_*_Lead=LeadID');
    RegisterMe(TfmMarketingLead, 'TCustomFieldValuesListLeadsGUI_*_Lead=LeadID');

  end;
end.




