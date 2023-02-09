unit IntegrationPrefs;

interface
{$I ERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BasePrefs, StdCtrls, wwcheckbox, ExtCtrls, DNMPanel, DB, DBAccess,
  MyAccess, ERPdbComponents, DataSourcePrefs, Grids, Wwdbigrd, Wwdbgrid, MemDS,
  DNMSpeedButton, MessageConst, ComCtrls, CheckLst, AdvObj, BaseGrid, AdvGrid,
  PrefsConfigListObj, JsonObject, ConfigDbObj, DBCtrls, wwdblook, AdvEdit,
  DBAdvEd, fraUtilsConfigBase, fraModWebAPIConfig , fraModEBay, SMSConfigObj,
  GoogleConfigObj, GoogleCalendarConfigObj, IntegrationPrefsUPS,
  IntegrationPrefsFedEx, IntegrationPrefsUSPS, Menus, fraModUserUtilsConfigBasic,
  AdvScrollBox, Mask, wwdbedit, IntegrationPrefsAmazon, IntegrationPrefsSPS,
  fraModGoogleConfig, AccountsPrefsHMRC, AccountsPrefsVAT,
  IntegrationPrefsIntuit, AdvSpin, wwdbdatetimepicker,
  (*IntegrationPrefsMagento,*)IntegrationPrefsAvaTax,IntegrationPrefsWalmart, IntegrationPrefsEDI,
  MyBackup, DADump, MyDump, StrUtils, Spin, Wwdbspin, sgcBase_Classes,
  sgcTCP_Classes, sgcWebSocket_Classes, sgcWebSocket_Classes_Indy,
  IdIOHandler, IdIOHandlerSocket, IdHeaderList, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdTCPClient, IdHTTP,
  sgcWebSocket_Client, sgcWebSocket, kbmMemTable, shellapi, IdBaseComponent,
  IdComponent, IdIPMCastBase, IdIPMCastClient, pngimage;

const
  WM_USER_SET_FOCUS = WM_USER + 201;

type

  TIntegrationPrefConfigItem = class;

  TIntegrationPrefsGUI = class(TBasePrefsGUI)
    dsPrefs: TDataSourcePrefs;
    MyConnection: TERPConnection;
    qryGaAccounts: TERPQuery;
    qryGaAccountsUId: TIntegerField;
    qryGaAccountsErpAccountID: TIntegerField;
    qryGaAccountsAccountName: TWideStringField;
    qryGaAccountsERPAccountName: TWideStringField;
    qryGaAccountsAccountId: TWideStringField;
    qryGaAccountsEmailAddress: TWideStringField;
    qryGaAccountsPassword: TWideStringField;
    qryGaAccountsAuth: TWideMemoField;
    qryGaAccountsProfiles: TWideStringField;
    qryGaAccountsActive: TWideStringField;
    dsGaAccounts: TDataSource;
    qryProfiles: TERPQuery;
    qryProfilesUId: TIntegerField;
    qryProfilesRef_TGAAccount: TIntegerField;
    qryProfilesProfileId: TWideStringField;
    qryProfilesTitle: TWideStringField;
    qryProfilesWebPropertyId: TWideStringField;
    qryProfilesCurrency: TWideStringField;
    qryProfilesTimeZone: TWideStringField;
    qryProfilesTableId: TWideStringField;
    qryProfilesActive: TWideStringField;
    dsGaProfiles: TDataSource;
    QrygaProfilesource: TERPQuery;
    dsgaProfilesource: TDataSource;
    QrygaProfilesourceGlobalref: TWideStringField;
    QrygaProfilesourceSourceID: TIntegerField;
    QrygaProfilesourcega_ProfileId: TIntegerField;
    QrygaProfilesourceActive: TWideStringField;
    QrygaProfilesourcemsTimeStamp: TDateTimeField;
    QrygaProfilesourcemsUpdateSiteCode: TWideStringField;
    Qrysource: TERPQuery;
    QrysourceMedtypeID: TIntegerField;
    Qrysourcemediatype: TWideStringField;
    QrygaProfilesourceSourcename: TStringField;
    QrygaProfilesourceUID: TIntegerField;
    QrygaProfilesourceisDefaultSource: TWideStringField;
    qrySupplier: TERPQuery;
    qrySupplierClientId: TIntegerField;
    qrySuppliercompany: TWideStringField;
    QryAccount: TERPQuery;
    QryAccountAccountName: TWideStringField;
    QryAccountAccountID: TIntegerField;
    pnlShipment: TDNMPanel;
    Bevel10: TBevel;
    Label16: TLabel;
    chkTNTEnabled: TwwCheckBox;
    chkAllowShipmentsFromSalesOrder: TwwCheckBox;
    chkAusEParcel: TwwCheckBox;
    pnlErpApiConfig: TDNMPanel;
    Bevel11: TBevel;
    Label15: TLabel;
    Label17: TLabel;
    lblERPLinkNote: TLabel;
    chkEnableErpApi: TwwCheckBox;
    edtErpApiPort: TDBAdvEdit;
    pnlModUserUtils: TDNMPanel;
    ModUserUtilsConfig: TfrModUserUtilsConfigBasic;
    pnlWebAPI: TDNMPanel;
    ModWebAPIConfig: TfrModWebAPIConfig;
    pnlIntegrationSites: TDNMPanel;
    Bevel4: TBevel;
    Label4: TLabel;
    rgSiteStatus: TRadioGroup;
    lvIntegrationConfig: TListView;
    btnAddSite: TButton;
    btnDeleteSite: TButton;
    btnEditSite: TButton;
    pnlEBayInt: TDNMPanel;
    ModEbayConfig: TfrModEbay;
    pnlCyTrackIntegration: TDNMPanel;
    Bevel7: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    chkCyTrackIntegrationEnabled: TwwCheckBox;
    pnlSiteIntegration: TDNMPanel;
    Bevel3: TBevel;
    Label3: TLabel;
    lblSiteIntegrationEnabled: TLabel;
    lblSiteIntegrationVersion: TLabel;
    chkSiteIntegrationEnabled: TwwCheckBox;
    rgSiteIntegrationLoggingLevel: TRadioGroup;
    pnpGoolgeProfileSources: TDNMPanel;
    Bevel6: TBevel;
    lblsources: TLabel;
    grdgoogleProfilesources: TwwDBGrid;
    cbosource: TwwDBLookupCombo;
    pnlGoogleProfiles: TDNMPanel;
    Bevel2: TBevel;
    lblProfile: TLabel;
    grdProfiles: TwwDBGrid;
    pnlGoogleAccounts: TDNMPanel;
    Bevel5: TBevel;
    Label9: TLabel;
    Label2: TLabel;
    grdGaAccounts: TwwDBGrid;
    rgFilter: TRadioGroup;
    wwDBLookupCombo1: TwwDBLookupCombo;
    cboAccountName: TwwDBLookupCombo;
    pnlGoogleCalendar: TDNMPanel;
    Bevel9: TBevel;
    Label12: TLabel;
    Label14: TLabel;
    Label18: TLabel;
    lblSynchWithGoogleCalendar: TLabel;
    edtGoogleEmail: TEdit;
    btnGoogleTest: TDNMSpeedButton;
    chkSynchWithGoogle: TwwCheckBox;
    chkSynchWithGoogleCalendar: TwwCheckBox;
    pnlGoogleAnalytics: TDNMPanel;
    pnlSMSConfig: TDNMPanel;
    Bevel8: TBevel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label20: TLabel;
    lblSMSEnabled: TLabel;
    chkSMSEnabled: TwwCheckBox;
    edtSMSUserName: TEdit;
    edtSMSPassword: TEdit;
    edtPhoneNumber: TEdit;
    btnSMSrates: TDNMSpeedButton;
    pnlWalmartOptions: TDNMPanel;
    Bevel12: TBevel;
    chkEnableWalmart: TwwCheckBox;
    qryCustomers: TERPQuery;
    qryCustomerscompany: TWideStringField;
    cboWalmartcustomer: TwwDBLookupCombo;
    Label13: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    memWALMART_PrivateKey: TDBMemo;
    EDTWALMART_ConsumerId: tWWdbeDIT;
    Label23: TLabel;
    EDTWALMART_ChannelType: twwDBedit;
    optWALMART_ProductNameField: TDBRadioGroup;
    Label24: TLabel;
    chk_AutocheckforOrdersinList: TwwCheckBox;
    chk_WALMART_AutoUpdateProductQty: TwwCheckBox;
    chk_WALMART_IgnoreTaxonSale: TwwCheckBox;
    wwCheckBox2: TwwCheckBox;
    chkShowWalmartonMainmenubyDefault: TwwCheckBox;
    chkWalmart_EnableInvFeed: TwwCheckBox;
    lblEbayConfig: TLabel;
    ModGoogleConfig: TfrModGoogleConfig;
    lblAnalyticsModuleVersion: TLabel;
    pnlWooCommerceOptions: TDNMPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    chkEnableWooCommerce: TwwCheckBox;
    chkShowWooCommerceonMainmenubyDefault: TwwCheckBox;
    pnlCoreEDI: TDNMPanel;
    Bevel13: TBevel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    edtCoreEDIUSerName: TwwDBEdit;
    edtCoreEDIPassword: TwwDBEdit;
    Label32: TLabel;
    pnlcoreEDiCredentilsHint: TPanel;
    lblcoreEDiCredentilsHint: TLabel;
    lblHintAvalaraLink: TLabel;
    btnTestCoreEDI: TDNMSpeedButton;
    pnlCloneDatabase: TDNMPanel;
    Bevel14: TBevel;
    Label33: TLabel;
    Label36: TLabel;
    edtUser: TwwDBEdit;
    wwCheckBox4: TwwCheckBox;
    Label37: TLabel;
    Label38: TLabel;
    edtPass: TwwDBEdit;
    MyDump1: TMyDump;
    ExtConnection: TMyConnection;
    btnHelp: TDNMSpeedButton;
    pnlCoreEDIService: TDNMPanel;
    Bevel15: TBevel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    CoreEDIServiceHint: TLabel;
    edtCoreEDIServiceUserName: TEdit;
    edtCoreEDIServicePassword: TwwDBEdit;
    pnlCoreEDIServiceCredentials: TPanel;
    Label43: TLabel;
    Label44: TLabel;
    btnTestCoreEDIService: TDNMSpeedButton;
    spCoreEDIServicePort: TwwDBSpinEdit;
    Label45: TLabel;
    wsClient: TsgcWebSocketClient;
    Label42: TLabel;
    edtCoreEDIServiceHost: TwwDBEdit;
    CompanyEmailLabel: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    pnlYodlee: TDNMPanel;
    Bevel16: TBevel;
    Label46: TLabel;
    wwYodleeEnabled: TwwCheckBox;
    dsYodlee: TDataSource;
    kbmYodlee: TkbmMemTable;
    kbmYodleeTrueERPAccountNumber: TStringField;
    kbmYodleeTrueERPAccountId: TIntegerField;
    kbmYodleeYodleeAccountId: TIntegerField;
    kbmYodleeYodleeProviderId: TIntegerField;
    kbmYodleeYodleeProviderName: TStringField;
    pnlYodleeControls: TDNMPanel;
    dbgYodlee: TwwDBGrid;
    pnlYodleeButtons: TDNMPanel;
    bnLinkAccounts: TDNMSpeedButton;
    kbmYodleeTrueERPAccountName: TStringField;
    qryChartOfAccounts: TERPQuery;
    qryChartOfAccountsAccountName: TWideStringField;
    qryChartOfAccountsAccountID: TIntegerField;
    qryChartOfAccountsAccountNumber: TWideStringField;
    lbYodlee: TLabel;
    IdIPMCastClient1: TIdIPMCastClient;
    wwdbYodleeAccounts: TwwDBLookupCombo;
    kbmYodleeAccounts: TkbmMemTable;
    StringField3: TStringField;
    IntegerField3: TIntegerField;
    kbmYodleeAccountsYodleeAccountID: TIntegerField;
    bnYodleeCheck: TDNMSpeedButton;
    wwBankReconRemember: TwwCheckBox;
    pnlMagento: TDNMPanel;
    Bevel17: TBevel;
    Label49: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    wwCheckBoxMagento: TwwCheckBox;
    wwDBEdit2: TwwDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    wwCheckBox3: TwwCheckBox;
    wwCheckBox5: TwwCheckBox;
    wwCheckBox6: TwwCheckBox;
    wwCheckBox7: TwwCheckBox;
    chkShowMagentoonMainmenubyDefault: TwwCheckBox;
    wwCheckBox9: TwwCheckBox;
    lbMagento: TLabel;
    bnRefreshMagento: TDNMSpeedButton;
    bnRefreshWooCommerce: TDNMSpeedButton;
    lbWooCommerce: TLabel;
    bnChangePassword: TDNMSpeedButton;
    gbPassword: TDNMPanel;
    imNewShow: TImage;
    imNewHide: TImage;
    bnSubmit: TDNMSpeedButton;
    edNewPassword: TEdit;
    Label26: TLabel;
    procedure qryProfilesBeforeOpen(DataSet: TDataSet);
    procedure qryGaAccountsAfterScroll(DataSet: TDataSet);
    procedure qryGaAccountsBeforeOpen(DataSet: TDataSet);
    procedure rgFilterClick(Sender: TObject);
    procedure grdGaAccountsDblClick(Sender: TObject);
    procedure rgAnalyticsLoggingLevelClick(Sender: TObject);
    procedure qryGaAccountsAfterInsert(DataSet: TDataSet);
    procedure rgSiteIntegrationLoggingLevelClick(Sender: TObject);
    procedure rgSiteStatusClick(Sender: TObject);
    procedure btnAddSiteClick(Sender: TObject);
    procedure lvIntegrationConfigDblClick(Sender: TObject);
    procedure chkSiteIntegrationEnabledClick(Sender: TObject);
    procedure btnDeleteSiteClick(Sender: TObject);
    procedure btnEditSiteClick(Sender: TObject);
    procedure qryProfilesAfterScroll(DataSet: TDataSet);
    procedure cbosourceCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure QrygaProfilesourceAfterInsert(DataSet: TDataSet);
    procedure QrygaProfilesourceBeforePost(DataSet: TDataSet);
    procedure QrygaProfilesourceAfterPost(DataSet: TDataSet);
    procedure QrygaProfilesourceisDefaultSourceChange(Sender: TField);
    procedure QrysourceBeforeOpen(DataSet: TDataSet);
    procedure QrygaProfilesourceBeforeOpen(DataSet: TDataSet);
    procedure ModWebAPIConfigbtnShowLogClick(Sender: TObject);
    procedure ModEbayConfigbtnShowLogClick(Sender: TObject);
    procedure ModEbayConfigbtnAddSiteClick(Sender: TObject);
    procedure frModEbay1btnHelpClick(Sender: TObject);
    procedure cboAccountNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkSMSEnabledClick(Sender: TObject);
    procedure edtSMSUserNameChange(Sender: TObject);
    procedure edtSMSPasswordChange(Sender: TObject);
    procedure edtGoogleEmailChange(Sender: TObject);
    procedure edtGooglePasswordChange(Sender: TObject);
    procedure btnGoogleTestClick(Sender: TObject);
    procedure chkSynchWithGoogleClick(Sender: TObject);
    procedure chkTNTEnabledClick(Sender: TObject);
    procedure chkSynchWithGoogleCalendarClick(Sender: TObject);
    procedure btnSMSratesClick(Sender: TObject);
    procedure edtGoogleEmailExit(Sender: TObject);
    procedure edtErpApiPortChange(Sender: TObject);
    procedure chkEnableErpApiClick(Sender: TObject);
    procedure qryProfilesAfterPost(DataSet: TDataSet);
    procedure chkEnableWalmartClick(Sender: TObject);
    procedure ModWebAPIConfigchkActiveClick(Sender: TObject);
    procedure chkEnableWooCommerceClick(Sender: TObject);
    procedure edtPhoneNumberChange(Sender: TObject);
    procedure ModEbayConfigbtnEditSiteClick(Sender: TObject);
    procedure lblcoreEDiCredentilsHintMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnTestCoreEDIClick(Sender: TObject);
    procedure chkEnableCloneClick(Sender: TObject);

    procedure RestoreProgressEvent(Sender: TObject; Percent: integer);
    procedure btnHelpClick(Sender: TObject);
    procedure btnTestCoreEDIServiceClick(Sender: TObject);
    procedure wsClientException(Connection: TsgcWSConnection; E: Exception);
    procedure CompanyEmailLabelClick(Sender: TObject);
    procedure wwYodleeEnabledClick(Sender: TObject);
    procedure wwMagentoEnabledClick(Sender: TObject);
    function  CheckYodleeEnabled: Boolean;
    function  CheckMagentoEnabled: Boolean;
    function  CheckWooCommerceEnabled: Boolean;
    procedure bnLinkAccountsClick(Sender: TObject);
//    function  CheckOutputFile(AuthToken: string; var AResultJSON: string) : Boolean;
    procedure kbmYodleeYodleeAccountIdChange(Sender: TField);
    procedure SaveYodlee;
    procedure FillYodleeMemTable(AResultJSON: string);
    procedure bnYodleeCheckClick(Sender: TObject);
    procedure bnRefreshMagentoClick(Sender: TObject);
    procedure bnRefreshWooCommerceClick(Sender: TObject);
    procedure bnChangePasswordClick(Sender: TObject);
    procedure bnSubmitClick(Sender: TObject);
    procedure edNewPasswordChange(Sender: TObject);
    procedure imNewShowClick(Sender: TObject);
    procedure imNewHideClick(Sender: TObject);
  private
    SMSConfig: TSMSConfig;
    YodleeDirty : Boolean;
    GoogleConfig: TGoogleConfig;
    GoogleCalendarConfig: TGoogleCalendarConfig;
    IntegrationPrefsUPSGUI: TIntegrationPrefsUPSGUI;
    IntegrationPrefsFedExGUI: TIntegrationPrefsFedExGUI;
    IntegrationPrefsUSPSGUI: TIntegrationPrefsUSPSGUI;
    IntegrationPrefsAmazonGUI: TIntegrationPrefsAmazonGUI;
    IntegrationPrefsSPSGUI: TIntegrationPrefsSPSGUI;
    AnalyticsVersion, IntegrationVersion: string;
    fConnection: TERPConnection;
    IntPrefPanels : Array of TDnmPanel;
    PrefsHMRC: TAccountsPrefsHMRCGUI;
    PrefsVAT: TAccountsPrefsVATGUI;
    fIntegrationPrefsIntuit: TItegrationPrefsIntuitGUI;
    //fIntegrationPrefsMagento: TIntegrationPrefsMagentoGUI;
    fIntegrationPrefsAvaTax: TIntegrationPrefsAvaTaxGUI;
    fIntegrationPrefsWalmart :TIntegrationPrefsWalmartGUI;
    fIntegrationPrefsEDI: TItegrationPrefsEDIGUI;
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure PerformFinish(var Msg: TMessage); message TX_PerformFinish;
    procedure EnableDisableAnalytics(Enabled: boolean);
    procedure AddAccount;
    function PrefConfigItem: TIntegrationPrefConfigItem;
    procedure LoadSiteList;
    procedure AddSite;
    procedure EditSelectedSite;
    procedure DeleteSelectedSite;
    procedure EnableDisableIntegration(Enabled: boolean);
    function NoDefaultSource: Boolean;
    procedure DoOnShowLog(Sender: TComponent; ModuleName, ServerName: string);
    Procedure chkShowEbayonMainMenubyDefaultonclick(Sender:TObject);
    procedure initPanelOrder;
    procedure ShowPanel(pnl: TDNMPanel); overload;
    procedure ShowPanel(pnlName: string); overload;
    procedure DoEbayConfighelpclick(Sender: TObject);
    procedure AftershowCompanyinfo(Sender: TObject);
    procedure GetLinkedAccounts(Sender: TObject);
    function GetYodleeToken: string;
    function getYodleeCredentials: string;
    function AuthenticateCoreEDI(ADisplayError: Boolean = True): Boolean;
    function ShellExecuteAndWait(URL, AuthToken: string; AWaitTimeMs: Integer; var AResultJSON: string): DWORD;
    procedure SetFocusToControl(var Message: TMessage); message WM_USER_SET_FOCUS;
  Protected
    procedure StartupProcess(var Msg: TMessage); Override;
    procedure FinishProcess(var Msg: TMessage); Override;
  public
  published
    property Connection: TERPConnection read fConnection write fConnection;
  end;

  TIntegrationPrefConfigItem = class(TPrefConfigItem)
  private
    ConfigDb: TConfigDb;
  public
    SiteIntegrationConfig: TJsonObject;
    SiteStatusFilter: integer;
    constructor Create;
    destructor Destroy; override;
    procedure CommitChanges; override;
    procedure RollbackChanges; override;
  end;

var
  IntegrationPrefsGUI: TIntegrationPrefsGUI;

implementation

{$R *.dfm}

uses
  frmGaAccountEdit, AnalyticsObj, CommonLib, UtilsServerUtils,
  AppEnvironment, frmIntegrationSiteConfig, frmModuleLog, GoogleAPI, tcTYpes,
  ShipIntegrationUtils, ShipIntegrationTypes, ProgressDialog, CommonDbLib, CommonFormLib,
  SystemLib,  tcConst, Preferences, fraModCustomConfig, {GoogleAuth,
  ibgGCalendar,} GoogleCalendarTest, ERPApiObj, PreferancesLib, LogLib,
  DialogUtils, frmERPEbayConfigurationSteps , DateUtils, ERPErrorEmailUtils,
  ERPVersionConst, CoreEDILib, CoreEDIObj, coreEDIUtils, InstallConst, DocReaderObj, CompanyPrefObj, frmCompanyInformationFrm,
  MAIN, YodleeTimedDlgU;

procedure TIntegrationPrefsGUI.AddAccount;
var
  Email, Password: string;
  Active: boolean;
  GA: TGoogleAnalytics;
  msg: string;
  AccountId: string;
begin
  inherited;
  Active:= true;
  Email:= '';
  Password:= '';
  AccountID:= '';
  if frmGaAccountEdit.DoGaAccountEdit(Email,Password,Active,true) then begin
    Processingcursor(True);
    GA:= TGoogleAnalytics.Create;
    try
      GA.Connection:= TErpConnection(qryGaAccounts.Connection);
      if GA.UpdateAccount(Email,Password,AccountID,Active,msg) then begin
        qryGaAccounts.Close;
        qryGaAccounts.Open;
        qryProfiles.Close;
        qryProfiles.Open;
      end
      else begin
        Processingcursor(False);
        CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
      end;
    finally
      GA.Free;
      Processingcursor(False);
    end;
  end;
end;

procedure TIntegrationPrefsGUI.AddSite;
var
  NewSite: TJsonObject;
begin
  NewSite:= TJsonObject.Create;
  if not NewSite.Exists('NextSyncTime') then begin
    NewSite.DT['NextSyncTime']:= now + ((1/24/60) * 5);
    NewSite.O['Interval'].I['Hours']:= 0;
    NewSite.O['Interval'].I['Mins']:= 15;
    NewSite.O['Interval'].O['DayOfTheWeek'].B['1']:= true;
    NewSite.O['Interval'].O['DayOfTheWeek'].B['2']:= true;
    NewSite.O['Interval'].O['DayOfTheWeek'].B['3']:= true;
    NewSite.O['Interval'].O['DayOfTheWeek'].B['4']:= true;
    NewSite.O['Interval'].O['DayOfTheWeek'].B['5']:= true;
  end;

  if frmIntegrationSiteConfig.DoSiteConfig(NewSite,PrefConfigItem.SiteIntegrationConfig) then begin
    PrefConfigItem.SiteIntegrationConfig.A['Sites'].Add(NewSite);
    LoadSiteList;
  end
  else
    NewSite.Free;
end;

procedure TIntegrationPrefsGUI.bnChangePasswordClick(Sender: TObject);
begin
  inherited;
  gbPassword.Visible         := True;
  edNewPassword.Text         := '';
  edNewPassword.PasswordChar := '*';
  imNewShow.Left             := edNewPassword.Left + edNewPassword.Width + 1;
  imNewShow.Top              := edNewPassword.Top;
  imNewHide.Visible          := False;
  PostMessage(self.Handle, WM_USER_SET_FOCUS, 0, 0);

end;

procedure TIntegrationPrefsGUI.bnLinkAccountsClick(Sender: TObject);
var
  AuthToken   : string;
  ResultJSON  : string;
  ResultJO    : TJSONObject;
  Msg         : string;
  ProgDlg     : TProgressDialog;
  FastLinkURL : string;
  ProcResult  : DWORD;
  ConfigName  : string;
const
  BASE_URL = 'https://yoodle.erpoz.com/?fastlinkpass=';
  //https://fl4.sandbox.yodlee.com/authenticate/restserver/fastlink&fastlinktoken=';
  TimeOut = 300000; // 300 secs
begin
  inherited;
  msg := 'This will open up a web page which will invoke the Yodlee FastLink application. ' + #13#10  + #13#10 +
         'Please note that you may be required to enter your confidential bank credentials to  '  +
         'enable Yodlee to access your account(s) details.'  + #13#10 + #13#10   +
         'Please note that none of the confidential information is stored or used by TrueERP.' + #13#10 + #13+#10  +
         'Press Yes to continue or Cancel to quit.';
  if CommonLib.MessageDlgXP_Vista(msg, mtWarning, [mbYes, mbCancel], 0) <> mrYes then exit;
  GetYodleeCredentials;
  ProgDlg := TProgressDialog.Create(nil);
  try
    ProgDlg.Caption  := 'Getting Yodlee Authorization Token';
    ProgDlg.MaxValue := 10;
    ProgDlg.Value    := 1;
    ProgDlg.TimerUpdate := true;
    ProgDlg.Execute;
    AuthToken        := GetYodleeToken;

    ProgDlg.Caption  := 'Getting Yodlee FastLink URL';
    ProgDlg.MaxValue := 50;
    ProgDlg.Value    := 1;
    ProgDlg.TimerUpdate := true;
    ProgDlg.Execute;

    ResultJSON   := GetYodleeCredentials;
    ResultJO     := JO(ResultJSON);
    FastLinkURL  := ResultJO.S['FastLinkURL'];
    ConfigName   := ResultJO.S['ConfigName'];
  finally
    ProgDlg.Free;
  end;

  if AuthToken = '' then
    CommonLib.MessageDlgXP_Vista('Could not get Yodlee authorization token. Please contact CoreEDI.',mtInformation,[mbOk],0)
  else begin

    ProcResult := ShellExecuteAndWait(Format('https://yoodle.erpoz.com?fastlinkpass=%s&fastlinktoken=%s&fastlinkconfigname=%s',
                     [FastLinkURL, AuthToken, configName]),
                     AuthToken,30000, ResultJSON);

    if ProcResult = 0  then begin
      CommonLib.MessageDlgXP_Vista('Linking software could not be launched. Please retry or contact ERP for assistance.',mtError,[mbOk],0);
      exit;
    end;
    if TYodleeTimedDlg.Execute(ProcResult, AuthToken, ResultJSON) = mrOK then begin
      FillYodleeMemTable(ResultJSON);
      CommonLib.MessageDlgXP_Vista('Your list of bank accounts has been refreshed. Please match up your TrueERP accounts with your bank accounts.',mtInformation,[mbOk],0)
    end else begin
      CommonLib.MessageDlgXP_Vista('Your list of bank accounts could not be refreshed. Please retry or contact ERP for assistance.',mtError,[mbOk],0)
    end;
  end;
end;

procedure TIntegrationPrefsGUI.bnRefreshMagentoClick(Sender: TObject);
begin
  inherited;
  if CheckMagentoEnabled then begin
    wwCheckBoxMagento.Checked :=  True;
    AppEnv.CompanyPrefs.MagentoEnabled := wwCheckBoxMagento.Checked;
  end
  else begin
    wwCheckBoxMagento.Checked := False;
    CommonLib.MessageDlgXP_Vista('Magento not enabled. Please contact ERP.',mtInformation,[mbOk],0);
  end;
  lbMagento.Visible := not wwCheckBoxMagento.Checked;
end;

procedure TIntegrationPrefsGUI.bnRefreshWooCommerceClick(Sender: TObject);
begin
  inherited;
  if CheckWooCommerceEnabled then begin
    chkEnableWooCommerce.Checked :=  True;
    AppEnv.CompanyPrefs.EnableWooCommerce := chkEnableWooCommerce.Checked;
  end
  else begin
    chkEnableWooCommerce.Checked := False;
    CommonLib.MessageDlgXP_Vista('WooCommerce not enabled. Please contact ERP.',mtInformation,[mbOk],0);
  end;
  lbWooCommerce.Visible := not chkEnableWooCommerce.Checked;
end;

procedure TIntegrationPrefsGUI.bnSubmitClick(Sender: TObject);
var
  sJSON             : string;
  sResult           : string;
  JObject           : TJSONObject;
begin
  if not AuthenticateCoreEDI(False) then exit;
  if not wsClient.Active then exit;

  sJSON   := BuildJSON('CHANGEMAGENTOPASSWORD');
  sResult := wsClient.WriteAndWaitData(sJSON);

  JObject := JO(sResult);
  if JObject.B['Error'] then begin
    showmessage(sJSON);
    CommonLib.MessageDlgXP_Vista('Password change unsuccessful. Error was ',mtError,[mbOk],0);
  end else begin
    CommonLib.MessageDlgXP_Vista('Password change successful.',mtInformation,[mbOk],0);
    gbPassword.Visible := False;
  end;
end;

procedure TIntegrationPrefsGUI.bnYodleeCheckClick(Sender: TObject);
begin
  inherited;
  if CheckYodleeEnabled then begin
    wwYodleeEnabled.Checked :=  True;
    AppEnv.CompanyPrefs.YodleeEnabled := wwYodleeEnabled.Checked;
  end
  else begin
    CommonLib.MessageDlgXP_Vista('Yodlee not enabled. Please contact ERP.',mtInformation,[mbOk],0);
  end;
end;

procedure TIntegrationPrefsGUI.FillYodleeMemTable(AResultJSON: string);
var
  JObject : TJSONObject;
  JArray  : TJSONArray;
  idx     : Integer;
begin
  inherited;
  JObject     := JO(AResultJSON);
  JArray      := JObject.A['sites'];
  kbmYodleeYodleeAccountId.OnChange := Nil;
  kbmYodleeAccounts.Close;
  kbmYodleeAccounts.Open;
  for idx := 0 to JArray.Count -1 do begin
    kbmYodleeAccounts.Append;
    kbmYodleeAccounts.FieldByName('YodleeAccountId').AsInteger     := TJSONObject(JArray[idx]).I['providerAccountId'];
    kbmYodleeAccounts.FieldByName('YodleeProviderId').AsInteger    := TJSONObject(JArray[idx]).I['providerId'];
    kbmYodleeAccounts.FieldByName('YodleeProviderName').AsString   := TJSONObject(JArray[idx]).S['providerName'];
    kbmYodleeAccounts.Post;
  end;
  kbmYodleeAccounts.First;
  kbmYodleeYodleeAccountId.OnChange := kbmYodleeYodleeAccountIdChange;
end;

procedure TIntegrationPrefsGUI.btnAddSiteClick(Sender: TObject);
begin
  inherited;
  AddSite;
end;

procedure TIntegrationPrefsGUI.btnDeleteSiteClick(Sender: TObject);
begin
  inherited;
  DeleteSelectedSite;
end;

procedure TIntegrationPrefsGUI.btnEditSiteClick(Sender: TObject);
begin
  inherited;
  EditSelectedSite;
end;

procedure TIntegrationPrefsGUI.btnGoogleTestClick(Sender: TObject);
var
  Auth, RefreshToken: string;
begin
  inherited;
  Auth := GoogleConfig.Password;
  RefreshToken := GoogleConfig.RefreshToken;
  if TestGoogleCalendar(edtGoogleEmail.Text, Auth, RefreshToken) then begin
    GoogleConfig.Password := Auth;
    GoogleConfig.RefreshToken := RefreshToken;
  end
end;

procedure TIntegrationPrefsGUI.btnHelpClick(Sender: TObject);
begin
  TDocReaderObj.ShowERPHelp(nil, Self, true, 'Clone Database to External Server');
end;

procedure TIntegrationPrefsGUI.btnSMSratesClick(Sender: TObject);
begin
  inherited;
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

procedure TIntegrationPrefsGUI.btnTestCoreEDIClick(Sender: TObject);
var
  CoreEDI: TCoreEDI;
  Msg:String;
begin
  inherited;
  CoreEDI := TCoreEDI.Create;
  try
    InitCodeEDI(CoreEDI);
    if ConnecttoCoreEDI(CoreEDI, nil, nil, edtCoreEDIUSerName.text, edtCoreEDIPassword.text) then begin
      msg:= 'Connected to CoreEDI OK';
    end else begin
      if CoreEDI.ConnectError <> '' then msg := CoreEDI.ConnectError
      else Msg:= 'Failed to connect to CoreEDI';
    end;
    MessageDlgXP_vista(msg, mtInformation, [mbOK], 0);
  finally
    Freeandnil(CoreEDI);
  end;

end;

function  TIntegrationPrefsGUI.AuthenticateCoreEDI(ADisplayError: Boolean = True): Boolean;
var
  jsonToSend : TJSonObject;
  jsonResp   : TJSonObject;
  ErrorStr   : string;
begin
  Result          := False;
  if pnlCoreEDIServiceCredentials.Visible and (not ADisplayError) then exit; //some parameter is missing
  if ADisplayError = False then wsClient.Tag := 1 else wsClient.Tag := 0;
  wsClient.Active := False;
  wsClient.Host   := edtCoreEDIServiceHost.Text;
  wsClient.Port   := Trunc(spCoreEDIServicePort.Value);
  jsonToSend      := JO;
  try
    try
      With jsonToSend do begin
         S['UserEmail']    := edtCoreEDIServiceUserName.Text;
         S['UserPassword'] := edtCoreEDIServicePassword.Text;
         S['Command']      := 'AUTHENTICATE';
      end;

      wsClient.Active := True;
      sleep(1000);
      ErrorStr := wsClient.WriteAndWaitData(JsonToSend.AsString);
      if ErrorStr = '' then exit; //mostly an exception which is trapped by the assign exceptionhandler
      jsonResp := JO(ErrorStr);
      if jsonResp.B['Error'] then begin
        if ADisplayError then
          MessageDlgXP_vista(jsonResp.S['ErrorMessage'] +  #13#10 +
           'Please check your user name, password, host and port.', mtInformation, [mbOK], 0);
      end else begin
        if ADisplayError then
          MessageDlgXP_vista(jsonResp.S['ErrorMessage'], mtInformation, [mbOK], 0);
        Result := True;
      end;
      except on E:Exception do begin
        MessageDlgXP_vista('Error when connecting to CoreEDI Server. ' + E.Message, mtError, [mbOK], 0);
      end;
    end;
  finally
    jsonToSend.Free;
  end;

end;

procedure TIntegrationPrefsGUI.btnTestCoreEDIServiceClick(Sender: TObject);
begin
  if Trim(edtCoreEDIServiceUserName.Text) = '' then begin
    MessageDlgXP_vista('User name must be specified. This is your company''s email.', mtInformation, [mbOK], 0);
    exit;
  end;
  if Trim(edtCoreEDIServicePassword.Text) = '' then begin
    MessageDlgXP_vista('Please enter the password supplied to you by CoreEDI.', mtInformation, [mbOK], 0);
    exit;
  end;
  if Trim(edtCoreEDIServiceHost.Text) = '' then begin
    MessageDlgXP_vista('Please enter the host name supplied to you by CoreEDI. ', mtInformation, [mbOK], 0);
    exit;
  end;
  if spCoreEDIServicePort.Value = 0 then begin
    MessageDlgXP_vista('Please enter the port supplied to you by CoreEDI. ', mtInformation, [mbOK], 0);
    exit;
  end;
  AuthenticateCoreEDI;
end;

procedure TIntegrationPrefsGUI.cboAccountNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  editDB(qryGaAccounts);
  qryGaAccountsERPAccountID.AsInteger := QryAccountAccountID.AsInteger;
  postDB(qryGaAccounts);
end;

procedure TIntegrationPrefsGUI.cbosourceCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  editdb(QrygaProfilesource);
  QrygaProfilesourceSourceID.AsInteger := QrysourceMedtypeID.AsInteger;
  postdb(QrygaProfilesource);
end;

procedure TIntegrationPrefsGUI.chkEnableCloneClick(Sender: TObject);
begin
//  if TwwCheckBox(Sender).Checked then begin
//    if not AppEnv.UtilsClient.LicenceOptionEnabled('WooCommerce') then begin
//      TwwCheckBox(Sender).Checked := false;
//      DialogLicenceOptionNotEnabled;
//    end;
//  end;
end;

procedure TIntegrationPrefsGUI.chkEnableErpApiClick(Sender: TObject);
begin
  inherited;
  if not chkEnableErpApi.Focused then exit;
  if not chkEnableErpApi.Checked then
    ErpAPI.Active := false
  else begin
    ErpAPI.HttpPort := edtErpApiPort.IntValue;
    try
      ErpAPI.Active := true;
    except
      on ex : exception do begin
        if Pos('Could not bind socket',ex.Message) > 0 then
          CommonLib.MessageDlgXP_Vista('The Port you have selected is in use by some other program on this computer, please select a different port.',mtInformation,[mbOk],0)
        else
          CommonLib.MessageDlgXP_Vista('An error occured when this feature was enabled.' + #13#10 + #13#10 +
            'The Port you have selected may be in use by some other program on this computer, please try a different port.',mtInformation,[mbOk],0);
        chkEnableErpApi.Checked := false;
        ErpAPI.Active := false;
      end;
    end;
  end;
end;

procedure TIntegrationPrefsGUI.chkEnableWalmartClick(Sender: TObject);
begin
  inherited;
  if TwwCheckBox(Sender).Checked then begin
    if not AppEnv.UtilsClient.LicenceOptionEnabled('Walmart') then begin
      TwwCheckBox(Sender).Checked := false;
      DialogLicenceOptionNotEnabled;
    end;
  end;


end;

procedure TIntegrationPrefsGUI.chkSiteIntegrationEnabledClick(
  Sender: TObject);
begin
  inherited;
  if not chkSiteIntegrationEnabled.Focused then exit;
  PrefConfigItem.SiteIntegrationConfig.B['Active']:= chkSiteIntegrationEnabled.Checked;
  EnableDisableIntegration(chkSiteIntegrationEnabled.Checked);
end;

procedure TIntegrationPrefsGUI.chkSMSEnabledClick(Sender: TObject);
begin
  if not TwwCheckBox(Sender).Focused then exit;
  chkSMSEnabled.OnClick := nil;
  try
    inherited;
    if TwwCheckBox(Sender).Checked then begin
      if (SMSConfig.SMSUser = '') or (SMSConfig.SMSPass = '') then begin
        TwwCheckBox(Sender).Checked := false;
        MessageDlgXP_Vista('Please enter User and Password details before enabling SMS support.',mtInformation,[mbOk],0);
      end;
    end;

    if chkSMSEnabled.Checked and (AppEnv.ServerID <> '') and (SMSConfig.LastServerId <> AppEnv.ServerID) then begin
      if MessageDlgXP_Vista('This company file seems to have been restored from a server with a different ID.' +
        ' Do you wish to continue and enable SMS anyway?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
        SMSConfig.LastServerId := AppEnv.ServerID;
        SMSConfig.Save(dsPrefs.Connection);
      end
      else
        chkSMSEnabled.Checked := false;
    end;

    SMSConfig.SMSEnabled := TwwCheckBox(Sender).Checked;

    if chkSMSEnabled.Checked then
      lblSMSEnabled.Caption := 'Enabled'
    else
      lblSMSEnabled.Caption := 'Disabled';


  finally
    chkSMSEnabled.OnClick := chkSMSEnabledClick;
  end;
end;

procedure TIntegrationPrefsGUI.chkSynchWithGoogleCalendarClick(Sender: TObject);
begin
  inherited;
  if chkSynchWithGoogleCalendar.Checked and (AppEnv.ServerID <> '') and (GoogleCalendarConfig.LastServerId <> AppEnv.ServerID) then begin
    if MessageDlgXP_Vista('This company file seems to have been restored from a server with a different ID.' +
      ' It is not advisable to run Google Calendar Synchronisation for the same company file installed on more than one server.' +
      ' Do you wish to continue and enable Synchronisation anyway?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
      GoogleCalendarConfig.LastServerId := AppEnv.ServerID;
      GoogleCalendarConfig.Save(dsPrefs.Connection);
    end
    else
      chkSynchWithGoogleCalendar.Checked := false;
  end;
  GoogleCalendarConfig.SynchWithGoogleCalendar := chkSynchWithGoogleCalendar.Checked;
  if chkSynchWithGoogleCalendar.Checked then
    lblSynchWithGoogleCalendar.Caption := 'Enabled'
  else
    lblSynchWithGoogleCalendar.Caption := 'Disabled';
end;

procedure TIntegrationPrefsGUI.chkSynchWithGoogleClick(Sender: TObject);
var
  Auth, RefreshToken: string;
begin
  inherited;
  if not chkSynchWithGoogle.focused then  exit;

  if chkSynchWithGoogle.Checked then begin
    Auth := GoogleConfig.Password;
    RefreshToken := GoogleConfig.RefreshToken;
    if TestGoogleCalendar(edtGoogleEmail.Text, Auth, RefreshToken) then begin
      GoogleConfig.Password := Auth;
      GoogleConfig.RefreshToken := RefreshToken;
    end
    else begin
      chkSynchWithGoogle.Checked := false;
    end;
  end;

  GoogleConfig.SynchWithGoogle := chkSynchWithGoogle.Checked;
end;

procedure TIntegrationPrefsGUI.chkTNTEnabledClick(Sender: TObject);
begin
  inherited;
  if not chkTNTEnabled.Focused then exit;

  if TwwCheckBox(Sender).Checked then begin
    if not AppEnv.UtilsClient.LicenceOptionEnabled('TNT') then begin
      TwwCheckBox(Sender).Checked := false;
      DialogLicenceOptionNotEnabled;
    end;
  end;

  if chkTNTEnabled.Checked then
    CheckShippingMethods(spTNT,[]);
end;

procedure TIntegrationPrefsGUI.DeleteSelectedSite;
var
  listItem: TListItem;
  site: TJsonObject;
  x: integer;
begin
  listItem:= lvIntegrationConfig.Selected;
  if Assigned(listItem) then begin
    if MessageDlgXP_Vista('Are your sure you want to permently delete "' + listItem.Caption + '"?',mtConfirmation,[mbNo,mbYes],0) = mrYes then begin
      for x:= 0 to PrefConfigItem.SiteIntegrationConfig.A['Sites'].Count -1 do begin
        site:= PrefConfigItem.SiteIntegrationConfig.A['Sites'].Items[x].AsObject;
        if SameText(listItem.Caption,site.S['Name']) then begin
          PrefConfigItem.SiteIntegrationConfig.A['Sites'].Delete(x);
          LoadSiteList;
          exit;
        end;
      end;
    end;
  end;
end;

procedure TIntegrationPrefsGUI.DoOnShowLog(Sender: TComponent; ModuleName,
  ServerName: string);
begin
  frmModuleLog.ShowLog(Application.MainForm,ModuleName,ServerName);
end;

procedure TIntegrationPrefsGUI.EditSelectedSite;
var
  listItem: TListItem;
  site: TJsonObject;
  x: integer;
begin
  listItem:= lvIntegrationConfig.Selected;
  if Assigned(listItem) then begin
    for x := 0 to PrefConfigItem.SiteIntegrationConfig.A['Sites'].Count -1 do begin
      site:= PrefConfigItem.SiteIntegrationConfig.A['Sites'].Items[x].AsObject;
      if SameText(site.S['Name'],listItem.Caption) then begin
        if frmIntegrationSiteConfig.DoSiteConfig(site,PrefConfigItem.SiteIntegrationConfig) then
          self.LoadSiteList;
        exit;
      end;
    end;
  end;
end;

procedure TIntegrationPrefsGUI.edNewPasswordChange(Sender: TObject);
begin
  inherited;
  bnSubmit.Enabled := (edNewPassWord.Text <> '');
end;

procedure TIntegrationPrefsGUI.edtErpApiPortChange(Sender: TObject);
begin
  inherited;
  if not edtErpApiPort.Focused then exit;
  chkEnableErpApi.Checked := false;
  ErpApi.Active := false;
end;

procedure TIntegrationPrefsGUI.edtGoogleEmailChange(Sender: TObject);
begin
  inherited;
  GoogleConfig.Email := TEdit(Sender).Text;
end;

procedure TIntegrationPrefsGUI.edtGoogleEmailExit(Sender: TObject);
var
  Auth, RefreshToken: string;
begin
  inherited;
  if not edtGoogleEmail.Focused then exit;
  if edtGoogleEmail.Modified then begin
    try
      if chkSynchWithGoogle.Checked then begin
        Auth := GoogleConfig.Password;
        RefreshToken := GoogleConfig.RefreshToken;
        if TestGoogleCalendar(edtGoogleEmail.Text, Auth, RefreshToken) then begin
          GoogleConfig.Password := Auth;
          GoogleConfig.RefreshToken := RefreshToken;
        end
        else begin
          chkSynchWithGoogle.Checked := false;
        end;
      end;
    finally
      edtGoogleEmail.Modified := false;
    end;
  end;
end;

procedure TIntegrationPrefsGUI.edtGooglePasswordChange(Sender: TObject);
begin
  inherited;
  GoogleConfig.Password := TEdit(Sender).Text;
end;

procedure TIntegrationPrefsGUI.edtPhoneNumberChange(Sender: TObject);
begin
  inherited;
  if not TEdit(Sender).Focused then exit;
  SMSConfig.PhoneNumber := TEdit(Sender).Text;
end;

procedure TIntegrationPrefsGUI.edtSMSPasswordChange(Sender: TObject);
begin
  inherited;
  if not TEdit(Sender).Focused then exit;
  SMSConfig.SMSPass := TEdit(Sender).Text;
//  if (SMSConfig.SMSUser = '') or (SMSConfig.SMSPass = '') then begin
//    TwwCheckBox(Sender).Checked := false;
//    SMSConfig.SMSEnabled := TwwCheckBox(Sender).Checked;
//  end;
end;

procedure TIntegrationPrefsGUI.edtSMSUserNameChange(Sender: TObject);
begin
  inherited;
  if not TEdit(Sender).Focused then exit;
  SMSConfig.SMSUser := TEdit(Sender).Text;
//  if (SMSConfig.SMSUser = '') or (SMSConfig.SMSPass = '') then begin
//    TwwCheckBox(Sender).Checked := false;
//    SMSConfig.SMSEnabled := TwwCheckBox(Sender).Checked;
//  end;
end;

procedure TIntegrationPrefsGUI.EnableDisableAnalytics(Enabled: boolean);
begin
  grdGaAccounts.Enabled:= Enabled;
  rgFilter.Enabled:= Enabled;
  grdProfiles.Enabled:= Enabled;
end;

procedure TIntegrationPrefsGUI.EnableDisableIntegration(Enabled: boolean);
begin
  lvIntegrationConfig.Enabled:= Enabled;
  rgSiteStatus.Enabled:= Enabled;
  rgSiteIntegrationLoggingLevel.Enabled:= Enabled;
  btnAddSite.Enabled:= Enabled;
  btnEditSite.Enabled:= Enabled;
  btnDeleteSite.Enabled:= Enabled;
end;

//function GetForm(App: TApplication; Owner: TComponent): TForm; external 'DllForm.dll';
procedure TIntegrationPrefsGUI.DoEbayConfighelpclick(Sender: TObject);
begin
  inherited;
  With TfmERPEbayConfigurationSteps.create(Self) do try
    Showmodal;
  finally
    free;
  end;
end;
procedure TIntegrationPrefsGUI.FormCreate(Sender: TObject);
var
//  form: TForm;
  x: integer;
  ModList: TStringList;
  ModuleList, Module: TJsonObject;
  CustModGui: TfrModCustomConfig;
  pnl: TDNMPanel;
  LastTabOrder: integer;
begin
  inherited;
  YodleeDirty := False;
  lblcoreEDiCredentilsHint.caption := 'Please Contact'+NL+
                                      'CoreEDI'+NL+
                                      'for Username and'+NL+
                                      'Password';
  SetLength(IntPrefPanels, 0);
  SMSConfig           := AppEnv.CompanyPrefs.SMSConfig; //   TSMSConfig.Create;
  GoogleConfig        := TGoogleConfig.Create;
  GoogleCalendarConfig:= TGoogleCalendarConfig.Create;
  lblSynchWithGoogleCalendar.Caption := '';

  IntegrationPrefsUPSGUI    := TIntegrationPrefsUPSGUI.Create     (self);  IntegrationPrefsUPSGUI.pnlUPSConfig.Parent       := sbpanels;  (*IntegrationPrefsUPSGUI.pnlUPSConfig.TabOrder    := 4;*)
  IntegrationPrefsfedExGUI  := TIntegrationPrefsFedExGUI.Create   (self);  IntegrationPrefsfedExGUI.pnlfedExConfig.Parent   := sbpanels;  (*IntegrationPrefsfedExGUI.pnlFedExConfig.TabOrder:= 5;*)
  IntegrationPrefsUSPSGUI   := TIntegrationPrefsUSPSGUI.Create    (self);  IntegrationPrefsUSPSGUI.pnlUSPSConfig.Parent     := sbpanels;(*  IntegrationPrefsUSPSGUI.pnlUSPSConfig.TabOrder  := 6;*)
  IntegrationPrefsAmazonGUI := TIntegrationPrefsAmazonGUI.Create  (self);  IntegrationPrefsAmazonGUI.pnlAmazonConfig.Parent := sbpanels;
  IntegrationPrefsSPSGUI    := TIntegrationPrefsSPSGUI.Create     (self);  IntegrationPrefsSPSGUI.pnlSPSConfig.Parent       := sbpanels;
  fIntegrationPrefsIntuit   := TItegrationPrefsIntuitGUI.Create   (self);  fIntegrationPrefsIntuit.pnlIntuitConfig.Parent   := sbPanels;
  //fIntegrationPrefsMagento  := TIntegrationPrefsMagentoGUI.Create (self);  fIntegrationPrefsMagento.pnlMagentoConfig.Parent := sbPanels;  (*fIntegrationPrefsMagento.pnlMagentoConfig.TabOrder:= 7; *)(*fIntegrationPrefsMagento.pnlMagentoConfig.height := 500;*)
  fIntegrationPrefsAvaTax   := TIntegrationPrefsAvaTaxGUI.Create  (self);  fIntegrationPrefsAvaTax.pnlAvaTaxConfig.Parent   := sbPanels; fIntegrationPrefsAvaTax.MyConnection := Self.MyConnection;
  fIntegrationPrefsWalmart  := TIntegrationPrefsWalmartGUI.Create (self);  fIntegrationPrefsWalmart.pnlWalmartConfig.Parent := sbPanels;
  fIntegrationPrefsEDI      := TItegrationPrefsEDIGUI.Create(self);        fIntegrationPrefsEDI.pnlEDIConfig.Parent         := sbPanels;
  pnlWalmartOptions.TabOrder:= 7;

  pnlcoreEDiCredentilsHint.Visible := (trim(AppEnv.CompanyPrefs.CoreEDIUSerName)='') or (trim(AppEnv.CompanyPrefs.CoreEDIPassword)='');
  pnlcoreEDiServiceCredentials.Visible := (trim(AppEnv.CompanyPrefs.CoreEDIServiceUSerName)='') or (trim(AppEnv.CompanyPrefs.CoreEDIServicePassword)='')
  or (trim(AppEnv.CompanyPrefs.CoreEDIServiceHost)='') or (AppEnv.CompanyPrefs.CoreEDIServicePort=0);
  //pnlCloneDatabase.Visible := DEvmode ; // Cloning database is incomplete, so the panel is only visible in DEVmode;

  ModWebAPIConfig.OnShowLog   := self.DoOnShowLog;
  ModEbayConfig.OnShowLog     := self.DoOnShowLog;
  ModUserUtilsConfig.OnShowLog:= self.DoOnShowLog;

  pnlWebAPI.Visible     := false;
  ModEbayConfig.visible :=  False;
  lblEbayConfig.visible :=  True;
  AnalyticsVersion      := '';
  IntegrationVersion    := '';

  { custom items .. }
  LastTabOrder := 0;
  for x := 0 to Self.ControlCount -1 do begin
    if Controls[x] is TDNMPanel then begin
      if TDNMPanel(Controls[x]).TabOrder > LastTabOrder then
        LastTabOrder := TDNMPanel(Controls[x]).TabOrder;

    end;
  end;
  ModuleList:= nil;
  ModList := TStringList.Create;
  try
    ModList.CaseSensitive := false;
    ModList.CommaText := 'ERPModUserUtils,ERPModEbay,ERPModGoogle,ERPModSiteIntegration,ERPModWebAPI';
    try
      ModuleList:= GetModuleList(AppEnv.AppDb.Server);
    except
      on e: exception do begin
        ModuleList.Free;
      end;
    end;
    try
      for x := 0 to ModuleList.A['Items'].Count -1 do begin
        Module:= ModuleList.A['Items'].Items[x].AsObject.O['Module'];
        logtext(Module.S['ModuleName']);

        if SameText(Module.S['ModuleName'],'ERPModGoogle') then begin
          AnalyticsVersion:= Module.S['ModuleVersion'];
          ModGoogleConfig.UtilsClient := AppEnv.UtilsClient;
        end
        else if SameText(Module.S['ModuleName'],'ERPModSiteIntegration') then begin
          IntegrationVersion:= Module.S['ModuleVersion'];
        end else if SameText(Module.S['ModuleName'],'ERPModWebApi') then begin
          pnlWebAPI.Visible := true;
          ModWebAPIConfig.UtilsClient := AppEnv.UtilsClient;
        end else if SameText(Module.S['ModuleName'],'ERPModEbay') then begin
          ModEbayConfig.Visible := true;
          lblEbayConfig.Visible := False;
          ModEbayConfig.UtilsClient := AppEnv.UtilsClient;
          ModEbayConfig.btnTestAccount.visible := True;
          (*ModEbayConfig.chkShowEbayonMainMenubyDefault.Visible := True;
          ModEbayConfig.pnlShowEbayonMainMenubyDefault.Visible := True;*)
          ModEbayConfig.ShowERPMainmenu(true);
          ModEbayConfig.chkShowEbayonMainMenubyDefault.Checked := AppEnv.CompanyPrefs.ShowEbayonMainMenubyDefault;
          ModEbayConfig.chkShowEbayonMainMenubyDefault.onclick := chkShowEbayonMainMenubyDefaultonclick;
          ModEbayConfig.btnhelp.onclick :=DoEbayConfighelpclick;
        end
        else if SameText(Module.S['ModuleName'],'ERPModUserUtils') then begin
          //pnlModUserUtils.Visible := true;
          ModUserUtilsConfig.UtilsClient := AppEnv.UtilsClient;
        end;

        logtext(Module.asstring);
        if ModList.IndexOf(Module.S['ModuleName']) < 0 then begin
          { does this module have a gui for the servicemenu }
          if Module.B['GuiInERP'] then begin
            ModList.Add(Module.S['ModuleName']);
            CustModGui := TfrModCustomConfig.Create(self);
            CustModGui.Name := 'frMod' + Module.S['ModuleName'];
            pnl := TDNMPanel.Create(self);
            pnl.Parent := sbpanels;
            pnl.Name := 'pnl' + Module.S['ModuleName'];
            Inc(LastTabOrder);
            pnl.TabOrder := LastTabOrder;
            CustModGui.Parent := pnl;
            CustModGui.SeverModuleInfo.AsString := Module.AsString;
            CustModGui.UtilsClient := AppEnv.UtilsClient;
            pnl.Width := CustModGui.Width;
            pnl.Height := CustModGui.Height;
            if Module.S['LoggerClassName'] = 'TLogger' then CustModGui.OnShowLog := DoOnShowLog;
            SetLength(IntPrefPanels, length(IntPrefPanels)+1);
            IntPrefPanels[High(IntPrefPanels)] := pnl;
          end;
        end;
      end;
    finally
      ModuleList.Free;
    end;
  finally
    ModList.Free;
  end;
  lblERPLinkNote.caption := 'Creating a smart order, which needs User Approval,'+NL+'It will Send an Email to the Employee with a Link to Open the Smart Order in ERP.'+NL+NL+
                            'This HTTP Port will let the User open the Smart Order.';
  lblERPLinkNote.visible := true;

  PrefsHMRC := TAccountsPrefsHMRCGUI.Create(self);
  PrefsHMRC.pnlHMRC.Parent := sbpanels;
  PrefsHMRC.pnlHMRC.TabOrder := 3;
  PrefsHMRC.Load;

  PrefsVAT := TAccountsPrefsVATGUI.Create(self);
  PrefsVAT.pnlVAT.Parent := sbpanels;
  PrefsVAT.pnlVAT.TabOrder := 4;
  PrefsVAT.Load(dsPrefs);

  InitPanelOrder;
  edtCoreEDIServiceUserName.Text := AppEnv.CompanyInfo.Email;
  wwYodleeEnabledClick(Nil);
  wwMagentoEnabledClick(Nil);
end;

procedure TIntegrationPrefsGUI.imNewHideClick(Sender: TObject);
begin
  inherited;
  edNewPassword.PasswordChar := '*';
  imNewHide.Visible := False;
  imNewShow.Visible := True;
end;

procedure TIntegrationPrefsGUI.imNewShowClick(Sender: TObject);
begin
  inherited;
  edNewPassword.PasswordChar := #0;
  imNewShow.Visible := False;
  imNewHide.Left := imNewShow.Left;
  imNewHide.Top  := imNewShow.Top;
  imNewHide.Visible := True;
end;

Procedure TIntegrationPrefsGUI.InitPanelOrder;
var
  ctr:Integer;

begin
  if length(IntPrefPanels) > 0 then
    for ctr := low(IntPrefPanels) to high(IntPrefPanels) do
      showPanel(IntPrefPanels[ctr]);
  showPanel(pnlYodlee                                 );
  showPanel(pnlWooCommerceOptions                     );
  showPanel(pnlMagento                                );
  showPanel(pnlWebAPI                                 );
  showPanel(pnlWalmartOptions                         );
  showPanel(fIntegrationPrefsWalmart.pnlWalmartConfig );
  showPanel(PrefsVAT.pnlVAT                           );
  showPanel(IntegrationPrefsUSPSGUI.pnlUSPSConfig     );
  showPanel(pnlModUserUtils                           );
  showPanel(IntegrationPrefsUPSGUI.pnlUPSConfig       );
  showPanel(IntegrationPrefsSPSGUI.pnlSPSConfig       );
  showPanel(pnlSMSConfig                              );
  showPanel(pnlIntegrationSites                       );
  showPanel(pnlSiteIntegration                        );
  showPanel(pnlShipment                               );
  ShowPanel('pnlERPModPaymentGateway'                 );{ payment gateway }
  //showPanel(fIntegrationPrefsMagento.pnlMagentoConfig );
  showPanel(fIntegrationPrefsAvaTax.pnlAvaTaxConfig   );
  showPanel(fIntegrationPrefsIntuit.pnlIntuitConfig   );
  showPanel(PrefsHMRC.pnlHMRC                         );
  showPanel(pnlGoogleProfiles                         );
  showPanel(pnpGoolgeProfileSources                   );
  showPanel(pnlGoogleCalendar                         );
  showPanel(pnlGoogleAnalytics                        );
  showPanel(pnlGoogleAccounts                         );
  showPanel(IntegrationPrefsfedExGUI.pnlfedExConfig   );
  showPanel(pnlErpApiConfig                           );
  //showPanel(pnlERPModEDI                              );
//  showPanel(fIntegrationPrefsEDI.pnlEDIConfig         );
  showPanel(pnlEBayInt                                );
  showPanel(pnlCyTrackIntegration                     );
  {$IFDEF USING_COREEDISERVICE}
    showPanel(pnlCoreEDIService                         );
    pnlCoreEDI.Visible := False;
  {$ELSE}
    showPanel(pnlCoreEDI                                );
    pnlCoreEDIService.Visible := False;
  {$ENDIF}
  showPanel(pnlCloneDatabase                          );
  showPanel(IntegrationPrefsAmazonGUI.pnlAmazonConfig );
end;

procedure TIntegrationPrefsGUI.kbmYodleeYodleeAccountIdChange(Sender: TField);
begin
  inherited;
  kbmYodlee.Edit;
  if not kbmYodlee.FieldByName('YodleeAccountId').IsNull then begin
    kbmYodlee.FieldByName('YodleeProviderId').AsInteger   := kbmYodleeAccounts.FieldByName('YodleeProviderId').ASInteger;
    kbmYodlee.FieldByName('YodleeProviderName').AsString  := kbmYodleeAccounts.FieldByName('YodleeProviderName').AsString;
  end else begin
    kbmYodlee.FieldByName('YodleeProviderId').AsInteger   := 0;
    kbmYodlee.FieldByName('YodleeProviderName').AsString  := '';
  end;
  kbmYodlee.Post;
  YodleeDirty := True;
end;

procedure TIntegrationPrefsGUI.lblcoreEDiCredentilsHintMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if (Shift = [ssCtrl,ssLeft]) then begin
    Processingcursor(true);
    try
        SendEmailtoErp('CoreEDI Credentials',
            '    Company     :' + Appenv.CompanyInfo.Companyname + chr(13) +
            '    Phone       :' + Appenv.CompanyInfo.Phonenumber + chr(13) +
            '    Email       :' + Appenv.CompanyInfo.Email + chr(13) +
            '    Server      :' + GetSharedMyDacConnection.Server + chr(13) +
            '    Datase      :' + GetSharedMyDacConnection.Database + chr(13) +
            '    Version     :' + TABLE_VERSION + chr(13) +chr(13) +
            '    CoreEDI.Username     :' + AppEnv.CompanyPrefs.CoreEDIUSerName + chr(13) +
            '    CoreEDI.Password     :' + AppEnv.CompanyPrefs.CoreEDIPassword,
            '    CoreEDi Account Required',
            'CoreEDI Credentials' , CoreEDIEmailID);
    finally
      Processingcursor(False);
    end;
    MessageDlgXP_Vista('An Email is Sent to CoreEDI'+NL+'CoreEDI will be contacting you soon. ', mtInformation, [mbOK], 0);
  end;
end;

Procedure TIntegrationPrefsGUI.chkShowEbayonMainMenubyDefaultonclick(Sender:TObject);
begin
  if sender = ModEbayConfig.chkShowEbayonMainMenubyDefault then
    AppEnv.CompanyPrefs.ShowEbayonMainMenubyDefault := ModEbayConfig.chkShowEbayonMainMenubyDefault.Checked;
end;

procedure TIntegrationPrefsGUI.FormDestroy(Sender: TObject);
begin
  SetLength(IntPrefPanels, 0);
  inherited;
//  SMSConfig.Free;
  GoogleConfig.Free;
  GoogleCalendarConfig.Free;
end;

procedure TIntegrationPrefsGUI.frModEbay1btnHelpClick(Sender: TObject);
begin
  inherited;
  ModEbayConfig.btnHelpClick(Sender);
end;

procedure TIntegrationPrefsGUI.QrygaProfilesourceAfterInsert(DataSet: TDataSet);
begin
  inherited;
  QrygaProfilesourcega_ProfileId.AsInteger := qryProfilesUId.asInteger;
  QrygaProfilesourceActive.AsBoolean := true;
  if NoDefaultSource then
    QrygaProfilesourceisDefaultSource.asBoolean:= True;
end;

procedure TIntegrationPrefsGUI.QrygaProfilesourceAfterPost(DataSet: TDataSet);
var
  bm:TBookmark;
  Id:Integer;
begin
  inherited;
  if QrygaProfilesourceisDefaultSource.AsBoolean then begin
    QrygaProfilesource.DisableControls;
    try
      bm:= QrygaProfilesource.GetBookmark;
      try
        id := QrygaProfilesourceUID.AsInteger;
        QrygaProfilesource.First;
        While QrygaProfilesource.Eof = False do begin
          if (QrygaProfilesourceUID.AsInteger <>Id)  and (QrygaProfilesourceisDefaultSource.AsBoolean) then begin
            editdb(QrygaProfilesource);
            QrygaProfilesourceisDefaultSource.AsBoolean := False;
            PostDb(QrygaProfilesource);
          end;
          QrygaProfilesource.Next;
        end;
      finally
        QrygaProfilesource.GotoBookmark(bm);
        QrygaProfilesource.FreeBookmark(bm);
      end;
    finally
      QrygaProfilesource.EnableControls;
    end;
  end;
  PreferancesLib.DoPrefAuditTrail;
end;

procedure TIntegrationPrefsGUI.QrygaProfilesourceBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  QrygaProfilesource.ParamByName('ga_ProfileId').AsInteger:= qryProfilesUID.AsInteger;
  if Qrysource.Active=False then Qrysource.Open;
end;

procedure TIntegrationPrefsGUI.QrygaProfilesourceBeforePost(DataSet: TDataSet);
begin
  inherited;
  if QrygaProfilesourcesourceID.asInteger =0 then begin
    QrygaProfilesource.Cancel;
    abort;
  end;
  if NoDefaultSource then begin
    QrygaProfilesourceisDefaultSource.asBoolean:= True;
  end;
end;
Function TIntegrationPrefsGUI.NoDefaultSource:Boolean;
begin
   With TERPQuery.Create(Self) do try
    connection := QrygaProfilesource.Connection;
    SQL.Add(QrygaProfilesource.SQLtext +' and isDefaultSource="T"' );
    open;
    result := recordcount=0;
   finally
    closenFree;
   end;
end;
procedure TIntegrationPrefsGUI.QrygaProfilesourceisDefaultSourceChange(Sender: TField);
begin
  inherited;
  if (Screen.ActiveControl = grdgoogleProfilesources) and (Sender.AsBoolean) then
    postdb(QrygaProfilesource);
end;

procedure TIntegrationPrefsGUI.grdGaAccountsDblClick(Sender: TObject);
var
  Email, Password: string;
  Active: boolean;
  GA: TGoogleAnalytics;
  msg: string;
  AccountId: string;
begin
  inherited;
  if qryGaAccounts.Active then begin
    if (qryGaAccountsUId.AsInteger > 0) then begin
      Active:= qryGaAccountsActive.AsBoolean;
      Email:= qryGaAccountsEmailAddress.AsString;
      Password:= qryGaAccountsPassword.AsString;
      AccountId:= qryGaAccountsAccountId.AsString;
      if frmGaAccountEdit.DoGaAccountEdit(Email,Password,Active,true) then begin
        Processingcursor(True);
        GA:= TGoogleAnalytics.Create;
        try
          GA.Connection:= TErpConnection(qryGaAccounts.Connection);
          if GA.UpdateAccount(Email,Password,AccountId,Active,msg) then begin
            qryGaAccounts.Close;
            qryGaAccounts.Open;
            qryProfiles.Close;
            qryProfiles.Open;
          end
          else begin
            Processingcursor(False);
            CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
          end;
        finally
          GA.Free;
          Processingcursor(False);
        end;
      end;
    end
    else begin
      qryGaAccounts.Insert;
    end;
  end;
end;

procedure TIntegrationPrefsGUI.LoadSiteList;
var
  x: integer;
  Site: TJsonObject;
  listItem: TListItem;
begin
  lvIntegrationConfig.Clear;
  for x := 0 to PrefConfigItem.SiteIntegrationConfig.A['Sites'].Count -1 do begin
    Site:= PrefConfigItem.SiteIntegrationConfig.A['Sites'].Items[x].AsObject;
    case rgSiteStatus.ItemIndex of
      0: if not Site.B['Active'] then continue;
      1: if Site.B['Active'] then continue;
      2: ;
    end;

    listItem:= lvIntegrationConfig.Items.Add;
    listItem.Caption:= Site.S['Name'];
    if Site.B['Active'] then
      listItem.SubItems.Add('Active')
    else
      listItem.SubItems.Add('Inactive');
  end;
end;

procedure TIntegrationPrefsGUI.lvIntegrationConfigDblClick(Sender: TObject);
begin
  inherited;
  EditSelectedSite;
end;

procedure TIntegrationPrefsGUI.ModEbayConfigbtnAddSiteClick(Sender: TObject);
begin
  inherited;
  ModEbayConfig.btnAddSiteClick(Sender);
end;

procedure TIntegrationPrefsGUI.ModEbayConfigbtnEditSiteClick(Sender: TObject);
begin
  inherited;
  ModEbayConfig.btnEditSiteClick(Sender);

end;

procedure TIntegrationPrefsGUI.ModEbayConfigbtnShowLogClick(Sender: TObject);
begin
  inherited;
  ModEbayConfig.btnShowLogClick(Sender);
end;

procedure TIntegrationPrefsGUI.ModWebAPIConfigbtnShowLogClick(Sender: TObject);
begin
  inherited;
  ModWebAPIConfig.btnShowLogClick(Sender);

end;

procedure TIntegrationPrefsGUI.ModWebAPIConfigchkActiveClick(Sender: TObject);
begin
  inherited;
  ModWebAPIConfig.chkActiveClick(Sender);
end;



function TIntegrationPrefsGUI.PrefConfigItem: TIntegrationPrefConfigItem;
begin
  if not Assigned(PrefsConfigList) then begin
    PrefsConfigList := TPreferencesGUI(Preferenceform).PrefsConfigList;
  end;
  result:= TIntegrationPrefConfigItem(PrefsConfigList.ItemByName['TIntegrationPrefConfigItem']);
  if not Assigned(result) then begin
    result:= TIntegrationPrefConfigItem.Create;
    PrefsConfigList.Add(result);
  end;
end;

procedure TIntegrationPrefsGUI.qryGaAccountsAfterInsert(DataSet: TDataSet);
begin
  inherited;
  qryGaAccounts.Cancel;
  AddAccount;
end;

procedure TIntegrationPrefsGUI.qryGaAccountsAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if qryProfiles.State in [dsInsert,dsEdit] then
    qryProfiles.Post;
  if qryProfiles.Active then begin
    qryProfiles.Close;
    qryProfiles.Open;
  end;
  lblProfile.Caption := 'Google Profiles of ' + Quotedstr(qryGaAccountsAccountName.asString);
end;

procedure TIntegrationPrefsGUI.qryGaAccountsBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  case rgFilter.ItemIndex of
    0:  qryGaAccounts.SQL.Text:= 'select * from tblTGaAccount where Active = "T" order by AccountName';
    1:  qryGaAccounts.SQL.Text:= 'select * from tblTGaAccount where Active = "F" order by AccountName';
    2:  qryGaAccounts.SQL.Text:= 'select * from tblTGaAccount order by AccountName';
  end;
end;

procedure TIntegrationPrefsGUI.qryProfilesAfterPost(DataSet: TDataSet);
begin
  inherited;
  PreferancesLib.DoPrefAuditTrail;
end;

procedure TIntegrationPrefsGUI.qryProfilesAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if QrygaProfilesource.State in [dsInsert,dsEdit] then
    QrygaProfilesource.Post;
  if QrygaProfilesource.Active then begin
    QrygaProfilesource.Close;
    QrygaProfilesource.Open;
  end;
  lblsources.Caption := 'Google Profile Sources : ' + Quotedstr(qryProfilesTitle.asString);
end;

procedure TIntegrationPrefsGUI.qryProfilesBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryProfiles.ParamByName('GaAccountUId').AsInteger:= qryGaAccountsUId.AsInteger;
end;

procedure TIntegrationPrefsGUI.QrysourceBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Qrysource.Connection := QrygaProfilesource.Connection;
end;

procedure TIntegrationPrefsGUI.rgSiteIntegrationLoggingLevelClick(Sender: TObject);
begin
  inherited;
  PrefConfigItem.SiteIntegrationConfig.I['LoggingLevel']:= rgSiteIntegrationLoggingLevel.ItemIndex;
end;

procedure TIntegrationPrefsGUI.rgSiteStatusClick(Sender: TObject);
begin
  inherited;
  self.LoadSiteList;
  PrefConfigItem.SiteStatusFilter:= rgSiteStatus.ItemIndex;
end;

procedure TIntegrationPrefsGUI.ShowPanel(pnlName: string);
var
  I: integer;
begin
  for I := 0 to ComponentCount -1 do begin
    if (Components[I] is TDNMPanel) and SameText(TDNMPanel(Components[I]).Name, pnlName) then begin
      TDNMPanel(Components[I]).TabOrder := 0;
      exit;
    end;
  end;
end;

procedure TIntegrationPrefsGUI.ShowPanel(pnl: TDNMPanel);
var
  iheight:Integer;
  iWidth :Integer;
begin
  try
    With pnl do begin
      iheight := height;
      iwidth := width;
      try
        taborder:=0;
        Anchors := [akleft,aktop];
        Left:=0;
      finally
        height := iheight;
        Width := iwidth;
      end;
    end;
  except
    on E:Exception do begin
      Logtext('Error:' +E.message);
    end;
  end;
end;

procedure TIntegrationPrefsGUI.rgFilterClick(Sender: TObject);
begin
  inherited;
  qryGaAccounts.Close;
  qryGaAccounts.Open;
end;

procedure TIntegrationPrefsGUI.rgAnalyticsLoggingLevelClick(Sender: TObject);
begin
end;

{ TIntegrationPrefConfigItem }

procedure TIntegrationPrefConfigItem.CommitChanges;
begin
  inherited;
  ConfigDb.Value:= SiteIntegrationConfig.AsString;
end;

constructor TIntegrationPrefConfigItem.Create;
begin
  inherited;
  SiteIntegrationConfig:= JO;
  ConfigDb:= TConfigDb.Create('SiteIntegration',AppEnv.AppDb.Server);
  SiteIntegrationConfig.AsString:= ConfigDb.Value;
  SiteStatusFilter:= 0;
end;

destructor TIntegrationPrefConfigItem.Destroy;
begin
  SiteIntegrationConfig.Free;
  ConfigDb.Free;
  inherited;
end;

procedure TIntegrationPrefConfigItem.RollbackChanges;
begin
  inherited;

end;
procedure TIntegrationPrefsGUI.chkEnableWooCommerceClick(Sender: TObject);
begin
//  if TwwCheckBox(Sender).Checked then begin
//    if not AppEnv.UtilsClient.LicenceOptionEnabled('WooCommerce') then begin
//      TwwCheckBox(Sender).Checked := false;
//      DialogLicenceOptionNotEnabled;
//    end;
//  end;
  lbWooCommerce.Visible          := not chkEnableWooCommerce.Checked;
end;

procedure TIntegrationPrefsGUI.PerformStartup(var Msg: TMessage);
begin
  DoPerformStartup(Msg);
end;

procedure TIntegrationPrefsGUI.StartupProcess(var Msg: TMessage);
var
  ProgDlg: TProgressDialog;
begin
  ProgDlg := TProgressDialog.Create(nil);
  DoingProcess := true;
  try
    ProgDlg.Caption := 'Loading';
    ProgDlg.MaxValue := 10;
    ProgDlg.Value := 1;
    ProgDlg.TimerUpdate := true;
    ProgDlg.Execute;
    if AnalyticsVersion <> '' then begin
      lblAnalyticsModuleVersion.Caption:= 'Google Analytics module version: ' + AnalyticsVersion;
//      chkGoogleAnalyticsEnabled.Enabled:= true;
    end
    else begin
      lblAnalyticsModuleVersion.Caption:= 'Google Analytics module not installed on ERP Server';
      dsPrefs.FieldByName('GoogleAnalyticsEnabled').AsBoolean:= false;
      EnableDisableAnalytics(false);
//      chkGoogleAnalyticsEnabled.Enabled:= false;
    end;

    if IntegrationVersion <> '' then begin
      lblSiteIntegrationVersion.Caption:= 'Site Integration module version: ' + IntegrationVersion;
      chkSiteIntegrationEnabled.Enabled:= true;
    end
    else begin
      lblSiteIntegrationVersion.Caption:= 'Site Integration module not installed on ERP Server';
      PrefConfigItem.SiteIntegrationConfig.B['Active']:= false;
      EnableDisableIntegration(false);
      chkSiteIntegrationEnabled.Enabled:= false;
    end;
    lblSiteIntegrationEnabled.Enabled:= chkSiteIntegrationEnabled.Enabled;

    LoadSiteList;

    rgSiteIntegrationLoggingLevel.ItemIndex:= PrefConfigItem.SiteIntegrationConfig.I['LoggingLevel'];

    chkSiteIntegrationEnabled.Checked:= PrefConfigItem.SiteIntegrationConfig.B['Active'];
    rgSiteStatus.ItemIndex:= PrefConfigItem.SiteStatusFilter;
    EnableDisableIntegration(chkSiteIntegrationEnabled.Checked);
    if QryAccount.Active = False then QryAccount.Open;
    if qrySupplier.Active = False then qrySupplier.Open;
    SMSConfig.Load(dsPrefs.Connection);
    if SMSConfig.LastServerID = '' then begin
      SMSConfig.LastServerID := AppEnv.ServerID;
      SMSConfig.Save(CommonDbLib.GetSharedMyDacConnection);
    end;
    if SMSConfig.SMSEnabled then begin
      if (SMSConfig.LastServerId = AppEnv.ServerID) or (AppEnv.ServerID = '') then begin
        chkSMSEnabled.Checked := true;
        lblSMSEnabled.Caption := 'Enabled';
      end
      else if (SMSConfig.LastServerId <> AppEnv.ServerID) then begin
        chkSMSEnabled.Checked := false;
        lblSMSEnabled.Caption := 'Disabled - Server ID does not match';
      end;
    end
    else begin
      chkSMSEnabled.Checked := false;
      lblSMSEnabled.Caption := 'Disabled';
    end;

    edtSMSUserName.Text := SMSConfig.SMSUser;
    edtSMSPassword.Text := SMSConfig.SMSPass;
    edtPhoneNumber.Text := SMSConfig.PhoneNumber;
    edtSMSUserName.Enabled := false;
    edtSMSPassword.Enabled := false;
    edtPhoneNumber.Enabled := false;

    GoogleConfig.Load(dsPrefs.Connection);
    edtGoogleEmail.Text := GoogleConfig.Email;
    chkSynchWithGoogle.Checked := GoogleConfig.SynchWithGoogle;

    GoogleCalendarConfig.Load(dsPrefs.Connection);
    if (GoogleCalendarConfig.LastServerId = '') and (AppEnv.ServerID <> '') then begin
      GoogleCalendarConfig.LastServerId := AppEnv.ServerID;
      GoogleCalendarConfig.Save(dsPrefs.Connection);
    end;
    if GoogleCalendarConfig.SynchWithGoogleCalendar then begin
      if (GoogleCalendarConfig.LastServerId = AppEnv.ServerID) or (AppEnv.ServerID = '') then begin
        chkSynchWithGoogleCalendar.Checked := true;
        lblSynchWithGoogleCalendar.Caption := 'Enabled';
      end
      else if (GoogleCalendarConfig.LastServerId <> AppEnv.ServerID) then begin
        chkSynchWithGoogleCalendar.Checked := false;
        lblSynchWithGoogleCalendar.Caption := 'Disabled - Server ID does not match';
      end;
    end
    else begin
      chkSynchWithGoogleCalendar.Checked := false;
      lblSynchWithGoogleCalendar.Caption := 'Disabled';
    end;

    pnlSMSConfig.Hint :=
      'Rates will vary for this service depending on where the SMS is coming from,' + #13#10 +
      'which telco provider you are using and where the SMS is going to.' + #13#10 + #13#10 +
      'Billing will be from ERP, monthly.' + #13#10 + #13#10 +
      'Please contact ERP in your country, if you wish to know more.' + #13#10;
    pnlSMSConfig.ShowHint := true;
    fIntegrationPrefsIntuit.Load;
    //fIntegrationPrefsMagento.Load;
    fIntegrationPrefsAvaTax.Load;
    fIntegrationPrefsWalmart.Load;
    fIntegrationPrefsEDI.Load;

    wwYodleeEnabledClick(Nil);
    wwMagentoEnabledClick(Nil);
  finally
    DoingProcess := false;
    ProgDlg.Free;
  end;
end;

procedure TIntegrationPrefsGUI.wsClientException(Connection: TsgcWSConnection;
  E: Exception);
begin
  if wsClient.Tag = 0 then lbYodlee.Caption := 'Yodlee is disabled because it was not possible to connect to CoreEDI server. Please contact ERP.'
  else
    MessageDlgXP_vista('Could not connect to CoreEDI Server. '+ #13#10 +
    'The error received was :' + E.Message + '.'+ #13#10 + #13#10 +
    'Please check your user name, password, host and port.'+ #13#10 +
    'Íf the error persists, please contact CoreEDI', mtError, [mbOK], 0);
end;

function  TIntegrationPrefsGUI.CheckYodleeEnabled: Boolean;
var
  sJSON             : string;
  sResult           : string;
  JObject           : TJSONObject;
begin
  Result       := False;

  if not AuthenticateCoreEDI(False) then exit;
  if not wsClient.Active then exit;

  sJSON   := BuildJSON('CHECKYODLEEENABLED');
  sResult := wsClient.WriteAndWaitData(sJSON);

  JObject := JO(sResult);
  Result  := not JObject.B['Error'];

end;

function  TIntegrationPrefsGUI.CheckMagentoEnabled: Boolean;
var
  sJSON             : string;
  sResult           : string;
  JObject           : TJSONObject;
begin
  Result       := False;

  if not AuthenticateCoreEDI(False) then exit;
  if not wsClient.Active then exit;

  sJSON   := BuildJSON('CHECKMAGENTOENABLED');
  sResult := wsClient.WriteAndWaitData(sJSON);

  JObject := JO(sResult);
  Result  := not JObject.B['Error'];
end;

function  TIntegrationPrefsGUI.CheckWooCommerceEnabled: Boolean;
var
  sJSON             : string;
  sResult           : string;
  JObject           : TJSONObject;
begin
  Result       := False;

  if not AuthenticateCoreEDI(False) then exit;
  if not wsClient.Active then exit;

  sJSON   := BuildJSON('CHECKWOOCENABLED');
  sResult := wsClient.WriteAndWaitData(sJSON);

  JObject := JO(sResult);
  Result  := not JObject.B['Error'];
end;

function  TIntegrationPrefsGUI.GetYodleeToken: string;
var
  sJSON             : string;
  sResult           : string;
  JObject           : TJSONObject;
begin
  if not AuthenticateCoreEDI(False) then exit;
  if not wsClient.Active then exit;

  sJSON   := BuildJSON('GETYODLEETOKEN');
  sResult := wsClient.WriteAndWaitData(sJSON);
  JObject := JO(sResult);
  if     JObject.B['Error'] then Result := ''
  else                           Result := JObject.S['Content'];

end;

function  TIntegrationPrefsGUI.GetYodleeCredentials: string;
var
  sJSON             : string;
  sResult           : string;
  JObject           : TJSONObject;
begin
  if not AuthenticateCoreEDI(False) then exit;
  if not wsClient.Active then exit;

  sJSON   := BuildJSON('GETYODLEECREDENTIALS');
  sResult := wsClient.WriteAndWaitData(sJSON);
  JObject := JO(sResult);
  if     JObject.B['Error'] then Result := ''
  else                           Result := JObject.S['Content'];

end;


procedure TIntegrationPrefsGUI.wwYodleeEnabledClick(Sender: TObject);
begin
  wsClient.Tag := 1; // exception message will be handled differently
  //wwYodleeEnabled.Checked   := CheckYodleeEnabled;
  wsClient.Tag := 0;
  pnlYodleeControls.Enabled := wwYodleeEnabled.Checked;
  dbgYodlee.Enabled         := wwYodleeEnabled.Checked;
  dbgYodlee.ReadOnly        := not wwYodleeEnabled.Checked;
  pnlYodleeButtons.Enabled  := wwYodleeEnabled.Checked;
  bnLinkAccounts.Enabled    := wwYodleeEnabled.Checked;
  lbYodlee.Visible          := not wwYodleeEnabled.Checked;
  if wwYodleeEnabled.Checked then begin
     GetLinkedAccounts(Nil);
  end;

end;

procedure TIntegrationPrefsGUI.wwMagentoEnabledClick(Sender: TObject);
begin
  lbMagento.Visible          := not wwCheckBoxMagento.Checked;
end;

procedure TIntegrationPrefsGUI.PerformFinish(var Msg: TMessage);
begin
  DoPrefformFinish(Msg);
end;

procedure TIntegrationPrefsGUI.FinishProcess(var Msg: TMessage);
begin
  SMSConfig.Save(dsPrefs.Connection);
  GoogleConfig.Save(dsPrefs.Connection);
  GoogleCalendarConfig.Save(dsPrefs.Connection);
  if Assigned(IntegrationPrefsUPSGUI) then
    IntegrationPrefsUPSGUI.Save;
  if Assigned(IntegrationPrefsFedExGUI) then
    IntegrationPrefsFedExGUI.Save;
  if Assigned(IntegrationPrefsUSPSGUI) then
    IntegrationPrefsUSPSGUI.Save;
  if Assigned(IntegrationPrefsAmazonGUI) then
    IntegrationPrefsAmazonGUI.Save;
  if Assigned(IntegrationPrefsSPSGUI) then
    IntegrationPrefsSPSGUI.Save;
  fIntegrationPrefsIntuit.Save;
  //fIntegrationPrefsMagento.Save;
  fIntegrationPrefsAvaTax.Save;
  fIntegrationPrefsWalmart.Save;
  fIntegrationPrefsEDI.Save;

  PrefsHMRC.Save;
  SaveYodlee;
end;

procedure TIntegrationPrefsGUI.SaveYodlee;
var
  sJSON             : string;
  sResult           : string;
  JObject           : TJSONObject;
  JArray            : TJSONArray;
  JYodleeLine       : TJSONObject;
begin
  inherited;
  if not YodleeDirty then exit;
  JArray  := TJSONArray.Create;
  With kbmYodlee do begin
    First;
    while not EOF do begin
      JYodleeLine                         := JO;
      JYodleeLine.I['TrueERPAccountId']   := FieldByName('TrueERPAccountId').AsInteger;
      JYodleeLine.I['YodleeAccountId']    := FieldByName('YodleeAccountId').AsInteger;
      JYodleeLine.I['YodleeProviderId']   := FieldByName('YodleeProviderId').AsInteger;
      JYodleeLine.S['YodleeProviderName'] := FieldByName('YodleeProviderName').AsString;
      JArray.Add(JYodleeLine);
      Next;
    end;
  end;
  sJSON       := BuildJSON('SAVEYODLEELINKEDACCOUNTS', 0,0,0,JArray);
  sResult     := wsClient.WriteAndWaitData(sJSON);
  JObject := JO(sResult);
  if JObject.B['Error'] then
    CommonLib.MessageDlgXP_Vista('Error when saving Yodlee linked accounts',mtError,[mbOk],0);


end;

procedure TIntegrationPrefsGUI.CompanyEmailLabelClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfrmCompanyInformation' ,0, AftershowCompanyinfo, nil);
end;

procedure TIntegrationPrefsGUI.AftershowCompanyinfo(Sender: TObject);
begin
  inherited;
  if not (Sender is TfrmCompanyInformation) then exit;
  With TfrmCompanyInformation(Sender).edtEmail do begin
    if Visible and Enabled then SetFocus;
  end;
end;


procedure TIntegrationPrefsGUI.RestoreProgressEvent(Sender: TObject; Percent: integer);
begin
  //SendProgress('Restoring tables', IntToStr(Percent) + '%', 100, Percent);
  //DoStepProgressbar
end;

procedure TIntegrationPrefsGUI.GetLinkedAccounts(Sender: TObject);
var
  sJSON             : string;
  sResult           : string;
  JObject           : TJSONObject;
  JSubObject        : TJSONObject;
  JArray            : TJSONArray;
  idx               : Integer;
begin
  if not AuthenticateCoreEDI(False) then begin
    //CommonLib.MessageDlgXP_Vista('Could not connect to the CoreEDIService. Please check your CoreEDI configuration.', mtInformation,[mbOk],0);
    exit;
  end;

  if not wsClient.Active then exit;

  sJSON   := BuildJSON('GETYODLEELINKEDACCOUNTS');
  sResult := wsClient.WriteAndWaitData(sJSON);

  JObject := JO(sResult);

  JSubObject  := JO(JObject.S['Content']);
  JArray      := JSubObject.A['LinkedAccounts'];
  kbmYodleeYodleeAccountId.OnChange := Nil;
  kbmYodleeAccounts.Close;
  kbmYodleeAccounts.Open;
  for idx := 0 to JArray.Count -1 do begin
    kbmYodleeAccounts.Append;
    kbmYodleeAccounts.FieldByName('YodleeAccountId').AsInteger     := TJSONObject(JArray[idx]).I['YodleeAccountId'];
    kbmYodleeAccounts.FieldByName('YodleeProviderId').AsInteger    := TJSONObject(JArray[idx]).I['YodleeProviderId'];
    kbmYodleeAccounts.FieldByName('YodleeProviderName').AsString   := TJSONObject(JArray[idx]).S['YodleeProviderName'];
    kbmYodleeAccounts.Post;
  end;
  kbmYodleeAccounts.First;

  kbmYodlee.Close;
  kbmYodlee.Open;
  With qryChartofAccounts do begin
    Close;
    Open;
    First;
    while not EOF do begin
      kbmYodlee.Append;
      kbmYodlee.FieldByName('TrueERPAccountId').AsInteger    := FieldByName('AccountId').AsInteger;
      kbmYodlee.FieldByName('TrueERPAccountNumber').AsString := FieldByName('AccountNumber').AsString;
      kbmYodlee.FieldByName('TrueERPAccountName').AsString   := FieldByName('AccountName').AsString;
      for idx := 0 to JArray.Count -1 do begin
        if TJSONObject(JArray[idx]).I['ERPAccountId']  = FieldByName('AccountId').AsInteger then begin
          kbmYodlee.FieldByName('YodleeAccountId').AsInteger     := TJSONObject(JArray[idx]).I['YodleeAccountId'];
          kbmYodlee.FieldByName('YodleeProviderId').AsInteger    := TJSONObject(JArray[idx]).I['YodleeProviderId'];
          kbmYodlee.FieldByName('YodleeProviderName').AsString   := TJSONObject(JArray[idx]).S['YodleeProviderName'];
          break;
        end;
      end;
      kbmYodlee.Post;
      Next;
    end;
    Close;
  end;
  kbmYodlee.Refresh;
  kbmYodlee.First;
  kbmYodleeYodleeAccountId.OnChange := kbmYodleeYodleeAccountIdChange ;
end;

function TIntegrationPrefsGUI.ShellExecuteAndWait(URL, AuthToken: string; AWaitTimeMs: Integer; var AResultJSON: string): DWORD;
var
  ExecInfo: TShellExecuteInfo;
  AProcess : Boolean;
begin
  Result := 0;
  ZeroMemory(@ExecInfo, SizeOf(ExecInfo));
  with ExecInfo do
  begin
    cbSize       := SizeOf(ExecInfo);
    fMask        := SEE_MASK_NOCLOSEPROCESS;
    lpFile       := PChar(GetDefaultBrowser);
    lpVerb       := 'open';
    lpParameters := PChar(URL);
    nShow        := SW_NORMAL;
  end;
  AProcess := ShellExecuteEx(@ExecInfo);
  if AProcess then
    Result := ExecInfo.hProcess;
end;


procedure TIntegrationPrefsGUI.SetFocusToControl(var Message: TMessage);
begin
  edNewPassword.SetFocus;
end;

initialization
  RegisterClass(TIntegrationPrefsGUI);
finalization
  UnRegisterClass(TIntegrationPrefsGUI);


end.
