unit MAIN;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 08/04/05  1.00.01 IJB  Added RegisterClassOnce(TProductCommissionListGUI),
                        RegisterClassOnce(TfmProductRewardPointsList).
 13/04/05  1.00.02 IJB  Added exception handling to ApplicationEvents object.
 18/05/05  1.00.03 IJB  Added new report/list form frmForeignSalesList.
 18/05/05  1.00.04 IJB  Added new report/list form frmForeignPurchaseList.
 23/06/05  1.00.05 DSP  Added new list form frmNABCardFastExportList
 29/06/05  1.00.06 DSP  Added new report/list form frmPurchaseStatementPrint
 04/07/05  1.00.07 BJ   When the AppEnv.CompanyPrefs.CreateCustomerJobFromRepair is false
                        click on the 'New Job[Worksho]' to open the job form
                        to create new job for the 'Workshop' client.
                        When the preferance is true, the repair form
                        gets opened and enforces the creation of a
                        customer job for the repair.
 07/07/05  1.00.08 DMS  1. Formatted unit's source code.
                        2. Modified OnCreate event so that failure to establish
                           connection to the server will immediatelly terminate
                           the application.
 13/07/05  1.00.08 BJ   Caption of the following  form are changed based on the preference
                        When called from different switches/options of the menu
                        New Jib
                        JobList
                        New Repair
                        Repair List
 13/07/05  1.00.09 DSP  Removed ToolButton13, ToolButton14 and ToolButton15
 03/08/05  1.00.10 BJ   DeleteResrvedSrNos
                        -->in formshow will delete the reserved Serial nos of the current user.
                        -->in the formclose, if activeuser is the last user it deletes all records
                           from the reserved table
 12/08/05  1.00.11 ISB  Add Db Locking Via Server Services To Backup / Verfiy Functions
 19/08/05  1.00.12 BJ   Spelling mistake corrected - Dispatch was spelled Despatch in the menu.
 22/08/05  1.00.13 BJ   Menu options added for Equipment and Equipment list under Hire.
 30/08/05  1.00.14 DSP  Added check for version match when copying a database.
 31/08/05  1.00.15 DSP  Added check for any list forms performing an export.
 31/08/05  1.00.16 ISB  Re-Added POSAutoLoad (Start POS On Logon) ?? MIA
 20/09/05  1.00.17 ISB  Removed As Much frmRecorderForm as pos
 23/09/05  1.00.18 ISB  Modified TerminateApp  Areas.
 23/11/05  1.00.19 DSP  Added variables to store values for 'OnIdle' and
                        'OnMessage' events.
 28/11/05  1.00.20 DSP  Modified 'InterceptMessages' to use the ActionBitmap from
                        TBaseForm.
 21/03/06  1.00.21  AL  Changed [procedure TMainForm.PbxCheck;] to Popup a call form even if
                        phone number of caller is empty
 22/03/06  1.00.22  BJ  GetFormDescIfShown checks for the visibility of the form and returns
                        the caption of the form if visible. The access level information
                        is removed from the caption
 06/04/06  1.00.23  BJ  ActivePopup form was closed(hide) on cursor move on the status bar
                        - not hiding it on cursor move, but only on the timer event
                        The popup form is shown only if it is not visible and not showing(form state)
 18/04/06  1.00.24 DSP  Added a panel to the status bar to display network traffic percentage.
 14/06/06  1.00.25 DSP  Added test for UseRollaBlinds to FormShow.
 30/08/06  1.00.26 DSP  Changed AddToolbarButton to use the description
                        property of TDNMAction components.
 19/09/06  1.00.27 DSP  Installed hook functions for the mouse and keyboard to
                        determine if the user has been idle with the application
                        for a period set in the preferences.

}

interface

{$I ERP.inc}

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls,
  StdCtrls, Dialogs, Buttons, Messages, ExtCtrls, ComCtrls,AdvOfficeStatusBar, StdActns,
  ActnList, ToolWin, ImgList, DB,  DBCtrls,
  AppScreenResUnit, ProgressDialog, SelectionDialog, Registry,
  ReceiptPrinterObj, ShellAPI, DBAccess, MyAccess,ERPdbComponents, MyClasses,
  {MiddleTier,} DNMPanel, AppEvnts, SynchedThreads, wwdbdatetimepicker,
  KbmMemTable, MemDS, UserLockObj, FormSwitchObj, DNMSpeedButton, DNMAction,
  MyScript, MessageInterface, AdvOfficeStatusBarStylers,
  AdvMenus, Menus,dmGUIStylers, AdvOfficeHint, advhintinfo, frmBase, HTMLabel, Tilebmp, Shader , {frmShowMe ,} ImageDLLLib;

type
  TMainForm = class(TfrmBaseGUI)
    OpenDialog: TOpenDialog;
    MainToolBar: TToolBar;
    tmrGeneral: TTimer;
    MailFlashTimer: TTimer;
    CommandLineFunctionsTimer: TTimer;
    tmrApplicationStatus: TTimer;
    StatusBar: TAdvOfficeStatusBar;
    pnlPresent: TPanel;
    spTCPActive: TShape;
    imAlert: TImage;
    imPhone: TImage;
    pmPresentUsers: TAdvPopupMenu;
    pmAlerts: TAdvPopupMenu;
    pmSubAlerts: TAdvPopupMenu;
    YES1: TMenuItem;
    No1: TMenuItem;
    ryLater1: TMenuItem;
    Illgetbacktoyou1: TMenuItem;
    N103: TMenuItem;
    Remove2: TMenuItem;
    Remove3: TMenuItem;
    ilAlerts: TImageList;
    AdvOfficeHint1: TAdvOfficeHint;
    PhoneFlashTimer: TTimer;
    TileBmp: TTileBmp;
    lblUser: TLabel;
    lblMsg: TLabel;
    PresenceTimer: TTimer;
    TmrPopup: TTimer;
    prgDlgInitERP: TProgressDialog;
    dlgCopyTxnProgress2: TProgressDialog;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure ExecNewProcess;
    procedure tmrGeneralTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormDestroy(Sender: TObject);
    procedure MailFlashTimerTimer(Sender: TObject);
    procedure imAlertDblClick(Sender: TObject);
    procedure pmSubAlertClick(Sender: TObject);
    procedure pmPresentUsersPopup(Sender: TObject);
    procedure ShowActiveWindowPopup(Sender: TObject; x: integer);
    procedure StatusBarMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure StatusBarMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Backup1Click(Sender: TObject);
    procedure Restore1Click(Sender: TObject);
    procedure NonERPClone1Click(Sender: TObject);
    procedure OpenCompanyDbClick(Sender: TObject);
    procedure mitNewCompanyClick(Sender: TObject);
    procedure Remove1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure CommandLineFunctionsTimerTimer(Sender: TObject);
    procedure lblRegionMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure lblRegionMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure tmrApplicationStatusTimer(Sender: TObject);
    procedure StatusBarPanelRightClick(Sender: TObject; PanelIndex: Integer);
    procedure AdvOfficeHint1BeforeShowHint(Sender: TObject;AControl: TControl; AHintInfo: TAdvHintInfo;var UseOfficeHint: Boolean);
    procedure PhoneFlashTimerTimer(Sender: TObject);
    procedure imPhoneDblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure PresenceTimerTimer(Sender: TObject);
    procedure TmrPopupTimer(Sender: TObject);
    procedure lblUserDblClick(Sender: TObject);
    procedure StatusBarPanelDblClick(Sender: TObject; PanelIndex: Integer);
  private
    ProcessAppMsgs: boolean;
    ExitInProgress: boolean;
    AppRes: TAppResolution;
    //btmapfilename:String;
//    fsBackupDestinationPath: string;
    bIsPrintSpooler: boolean;
    //iReminderCnt: integer;
    iTillID: integer;
    UserLock: TUserLock;
    FAltKeyDown: boolean;
    FFormSwitch: TFormSwitchObj;
    FStoredOnIdle: TIdleEvent;
    FStoredOnMessage: TMessageEvent;
    FSocketSpeed: integer;
    IsTerminateApp: Boolean;
    MsgHandler: TMsgHandler;
    fbRefreshedERPInfo:Boolean;
//    ShowMeform :TfmShowMe;
    function DBExists(const DBName: string): boolean;
    function GetBatchDate: string;
    function GetRemindTime(const dtEventTime: TDateTime; const iMinsBefore: integer): TDateTime;
    function IsOkToBePrintSpooler: boolean;
    procedure CopyOldDBTablesToNewDB(const sNewDBName: string; const OldConnection: TERPConnection);
    procedure KickTheDrawer;
    procedure ProcessPrintSpool;
    Procedure RunClosingdateRefresh;
//    {$IFNDEF NO_LICENCE_CHECK}
//    function LicenceCheck: boolean;
//    {$ENDIF}
    {$IFDEF MESSAGING}
//    procedure AlertAllUsers(const msg: string; const flash: boolean);
    {$ENDIF}
    procedure CleanMainToolbar;
    procedure HandleOnIdle(Sender: TObject; var Done: boolean);
    procedure InterceptMessages(var Msg: TMsg; var Handled: boolean);
    procedure SetSocketSpeed(const Value: integer);
    function GetPanelPos(const PanelIndex: Integer): TRect;
    procedure SetNewCompanyDefaultValues(const sNewDBName: string; const OldConnection: TERPConnection);
    function Needtoupdateclosingdates(var MSG:String;showwarning:Boolean =true):Boolean;
    procedure UpdateUserCountDisplay(aUserCount: integer);
    procedure DoOnLoggedInUserCountChange(NewUserCount: Integer);
    procedure DoOnLostUtilsServerConnection(Sender: TObject);
    //function checkTraining: Boolean;
    Procedure unLogAllFormInuse;
    procedure GlobalEventHandler(const Sender: TObject; const Event: string; const Data: Pointer);
    procedure updateclosingdates;
    procedure CurrentUsersMsg(Msg: String);
    function CurrentUsers: String;
    function istorunClosingdateRefresh(Var Msg:String): Boolean;
    //procedure Logmainmenu;
    procedure LogSubmenu(mnu: TMenuItem; intend: Integer);
    Function makeToolbarItem(AOwner:TComponent;nameprefix:String; namesuffix:String):TERPMainSwitchButton;
    procedure DoCyTrackEvent(Sender: TObject; const Event, Value : string);
    procedure OnCallerClick(Sender: TObject);
    procedure SetUSerLbl;
    Procedure SetShowworkflowStatus(const Value:Boolean);
    function InitcompanyDefaults:Boolean;
    procedure RefreshERPInfo;
    //procedure ShowPopAlert(const HMsg, Msg: string);
    procedure StartErpApi;
  Protected
        function ignorelogInuseform:boolean;Override;
  public
    { Public declarations }
    RemovingDB:Boolean;
    RestartApp:Boolean;
    foRcptPrn: TReceiptPrinter;
    flstReceipt: TStringList;
    fbSpoolPrintInProgress: boolean;
    fbForceUseExitBtn: boolean; // set this flag to force the use of the MainSwitch EXIT button
    MacroThread: TSimpleThread;
    expectedFormName: string;
    expectedComponentName: string;
    macroError: string;
    RelocateCreatedDate: TDateTime;
    RelocateDateDropDown: TwwDBDateTimePicker;
    DisplayPoint: TPoint;
    DisplayText: string;
    DisplayTextComponentName: string;
    DisplayFormTimer: TTimer;
    NoClientSlots: integer;      // licenced Number of Clients
    theExpiryDate: TDateTime;    // licence expires
//    theServerID: string;         // ServerID
    OriginalCaption: string;
    CompaniesAlreadyCreated:Boolean;
    ApplicationStarted:Boolean;
    procedure TerminateApp;
    function GetCurrentUserCount(HideThisUser: boolean = true): integer;
    function RemoveAllConnectionsToDB(const ExceptThisForm: string = ''): boolean;
    procedure ReloadToolbarButtons;
    procedure DisableActionsByEmployee(const DM: TDataModule);
    procedure AddinPackagesMenu;
    function GetTaskBarHeight: integer;
    function getformDescifshown(const FormName:String):STring;
    property SocketSpeed: integer read FSocketSpeed write SetSocketSpeed;
    Function NewCompany:String;
    Procedure SubformPostionMiddle(Sender:TForm);
    procedure Copydb(CopyRO: Boolean=False);
    procedure DoLogrecording;
    function DoStartrecording:Boolean;
    procedure DoStoprecording;
    procedure DoCancelrecording;
    Property ShowworkflowStatus :Boolean write SetShowworkflowStatus;
    procedure TimerMsg(const Value: String; Secondstoshow: Integer=5; msgColor:TColor = clred);Overload;
    procedure LoadVideoURLs(const sButtonCaption: string);
    procedure DoRefreshedERPInfo;
    Procedure DoProgressdialogProgress(const Value:String);
    function Formheight: Integer;
    procedure AddToolbarButton(const ActionName: string);
//    procedure ShowVideoFrm(fCurrentButtonName:String);
  published
    procedure SetRegionCaption(MsgObj: TMsgObj);
  end;

  TCyTrackCallerRec = class
  public
    ClientId: integer;
    IsCustomer: boolean;
    IsSupplier: boolean;
    IsOtherContact: boolean;
    ContactId: integer;
  end;

var
  MainForm: TMainForm;
  MsgInterface :TMsgInterface;

implementation

  {$R *.dfm}
  {$WARN UNIT_PLATFORM OFF}

uses FastFuncs,CommCtrl, frmLogonFrm ,EMHelper,
  CommonLib, CommonDbLib,   DNMLib,
  frmCompanyInformationFrm,
  tcDataUtils, DateUtils, TransactionsTable, // tcMessaging,
  IniFiles, GlobalEventsObj, Grids, rwButtonArray, Wwdbgrid, DBGrids, ActionsObj,
  tcConst, tcTypes, BaseFormForm, frmActivePopup, {$WARNINGS OFF}FileCtrl{$WARNINGS ON},
  dmMainGUI, PackageControl, MainSwitchFrm2,
  MenuCustomiseForm, MenuCustomiseClasses,
  BaseListingForm, PrintSpoolThreadObj, AppContextObj,
  CommandLineFunctionsObj,
  AppEnvironment, AddinPackageInfoObj, GlobalClassFinder, ModalInputBoxGUI,
  AppDatabase, frmMySQLServerSelect, FileDownloadFuncs,
  MonitorTransactionEvents, JsonObject, UserUtilsClientObj,
   TrainingLib, frmERPSetup, frmRegionalOptionSelect, SystemLib,
   InuseFormslib, PreferenceLib, frmDatabaseBackup, frmMessage, frmMessageBase,
   CyTrackObj, frmNotification, WorkflowObj , Types, CommonFormLib,
  frmDefaults, Preferences, UpdaterConst, ERPMessageGUILib, LogLib,
  InstallConst, ERPTrainingVideos, frmTrainingAssignment, FileVersion,
  FormEvents, ProgressdialogLib, ErpApiObj, MessageDlgXP_Vistaobj, SQLsLib,
  utNewDBUtils, BusobjProduct; //ShowMeCustomVideoList;

const
  MAX_TOOLBUTTON_CAPTION = 14;


var
  IdleCounter: integer;
  MouseHook: integer;
  KeyboardHook: integer;

function AppHookMouse(Code: Integer; wParam, lParam: Longint): Longint; stdcall;
begin
  IdleCounter := 0;
{$IFDEF EXCEPTIONAL_MAGIC}
  if (Code = HC_ACTION) and Assigned(UserActions) then
    UserActions.Add(uetMouse, wParam, lParam);
{$ENDIF}
  try
    if appenv.appdb.connection.connected then begin
      if AppEnv.CompanyPrefs.UseWorkFlow then begin
        if IsWorkFlowRecoding then begin
          if (Code = HC_ACTION) and Assigned(WorkflowActions) then
            WorkflowActions.AddWorkflowAction(uetMouse, wParam, lParam);
        end;
      end;
    end;
  Except

  end;

  Result := CallNextHookEx(MouseHook, Code, wParam, lParam);
end;

function AppHookKeyboard(Code: Integer; wParam, lParam: Longint): Longint; stdcall;
begin
  IdleCounter := 0;
{$IFDEF EXCEPTIONAL_MAGIC}
  if (Code = HC_ACTION) and Assigned(UserActions) then
    UserActions.Add(uetKeyboard, wParam, lParam);
{$ENDIF}
  try
    if appenv.appdb.connection.connected then begin
      if AppEnv.CompanyPrefs.UseWorkFlow then begin
        if IsWorkFlowRecoding then begin
          if (Code = HC_ACTION) and Assigned(WorkflowActions) then
            WorkflowActions.AddWorkflowAction(uetKeyboard, wParam, lParam);
        end;
      end;
    end;
  Except
  end;

  Result := CallNextHookEx(KeyboardHook, Code, wParam, lParam);
end;

procedure TMainForm.FormShow(Sender: TObject);
var
  frmLogon: TfrmLogon;
  PanelPos: TRect;
  Form: TComponent;
  MemUsedPercent: integer;
  Json, JsonParams: TJsonObject;
  msg: string;
  ExpireDays: integer;
  minMem: Int64;
  physMem: Int64;
  TrainingSetupForm: TfmTrainingAssignment;
const
  twoGb = 2147483648;
begin
  ShowworkflowStatus := False;
  inherited;
  //Self.Left := 1410;
  try
    if Assigned(CommandLineFunctions) then
      CommandLineFunctions.ExecBeforeLoginCmdLineParams;
    if not IsWinServer then begin
      physMem := MemoryTotalPhysical;
      minMem := twoGb;
      if (physMem > 0) and (physMem < minMem) then begin
        MemUsedPercent:= MemoryUsedPercentage;
        if MemUsedPercent > 75 then begin
          CommonLib.MessageDlgXP_Vista('Your computers available memory is less than 25% (' +
            IntToStr(100 - MemUsedPercent) + '%)' +
            #13#10 + #13#10 +
            'ERP requires a minimum of 25% free memory to operate, ' +
            'future releases of ERP will not run if this minimum is not available.' +
            #13#10 + #13#10 +
            'Please add more memory or adjust your Windows page file settings.',
            mtWarning, [mbOK], 0);
          MainForm.TerminateApp;
          Exit;
        end;
      end;
    end;

    frmLogon := TfrmLogon.Create(Self);

    with frmLogon do
      try
        ExitOnComplete := CommandLineFunctions.ExitOnComplete;

        if ShowModal <> mrOk then begin
          Release;
          frmLogon := nil;
          MainForm.TerminateApp;
          Exit;
        end else begin
          DoShowProgressbar(prgDlgInitERP , 10 ,'Initializing ERP');
          try

                //lblUser.Caption := trim(Appenv.AppDB.username);
                lblUser.Caption := trim(Appenv.Employee.EmployeeName);
                CommonDbLib.GetSharedMyDacConnection.Disconnect;
                AppRes.SetResolution(Self);
                //get Toolbar Buttons
                if Screen.Width <= 1024 then begin
                  self.Width := Screen.Width;
                  MainToolBar.Wrapable := true;
                  MainToolBar.AutoSize := true;
                end;
                if Screen.Height <= 768 then begin
                  self.Height := Screen.Height;
                  MainToolBar.Wrapable := true;
                  MainToolBar.AutoSize := true;
                end;

                //Remove Not Required Packages From List

                DoProgressdialogProgress('Checking For User Preferences - 1 of 5');if not AppEnv.CompanyPrefs.UseBudget        then RemovePackageByName('Budgets');
                DoProgressdialogProgress('Checking For User Preferences - 2 of 5');if not AppEnv.CompanyPrefs.UseHire          then RemovePackageByName('Hire');
                DoProgressdialogProgress('Checking For User Preferences - 3 of 5');if not AppEnv.CompanyPrefs.UseManufacturing then RemovePackageByName('Manufacturing');
                DoProgressdialogProgress('Checking For User Preferences - 4 of 5');if not AppEnv.CompanyPrefs.UseCRM           then RemovePackageByName('Marketing');
        //      DoProgressdialogProgress('Checking For User Preferences - 5 of 5');if not AppEnv.CompanyPrefs.UseAssessment    then RemovePackageByName('Assessment');
                DoProgressdialogProgress('Checking For User Preferences - 5 of 5');if not AppEnv.CompanyPrefs.UsePriceSchemes  then RemovePackageByName('Price Schemes');

                // 1. load the toolbar settings
                DoProgressdialogProgress('ERP Packages'); LoadAddinDLLPackages;
                DoProgressdialogProgress('ERP Mainswitch'); AddinPackagesMenu;
                DoProgressdialogProgress('Local Region Setting'); AppEnv.RegionalOptions.SetupRegion;
                MainToolBar.Color := clBtnHighlight;
                MainToolBar.Ctl3D := false;
                MainToolBar.Flat := true;
                MainToolBar.Font.Style := [];
                MainToolBar.Font.Size := 8;
                MainToolBar.AutoSize := true;
                ReloadToolbarButtons;
                TileBmp.Visible := Appenv.Employee.ShowImageOnMainBackGround;
                // 2. create and display the new main switch form

                AppEnv.Reset;
                DoProgressdialogProgress('Connect ERP User');
                if AppEnv.UtilsClient.ConnectUser(msg, AppEnv.AppDb.Server,
                    AppEnv.AppDb.Database, AppEnv.AppDb.UserName, AppEnv.Employee.FirstName, AppEnv.Employee.LastName) then
                begin
                  UserLock.UnlockAllCurrentUser;
                  emptyLogbusobj;
                  unLogAllFormInuse;
                  JsonParams:= JO;

                  JsonParams.S['softwarename'] := 'ERP';
                  Json := AppEnv.UtilsClient.Client.SendRequest('UserUtils.getlicence',JsonParams);
                  try
                    if Assigned(Json) then
                    begin
                      NoClientSlots:= Json.O['result'].O['licence'].I['ConcurrentUsers'];
                      theExpiryDate:= Json.O['result'].O['licence'].F['ExpireDate'];
                    end;
                  finally
                    JSon.Free;
                  end;
        //          JsonParams:= JO;
        //          Json:= AppEnv.UtilsClient.Client.SendRequest('UserUtils.getusercount',JsonParams);
        //          if Assigned(Json) then begin
        //            try
        //              UpdateUserCountDisplay(Json.O['result'].I['usercount']);
        //            finally
        //              Json.Free;
        //            end;
        //          end;
                  UpdateUserCountDisplay(0);
                end
                else begin
                  CommonLib.MessageDlgXP_Vista(msg, mtWarning, [mbOK], 0);
                  MainForm.TerminateApp;
                  Exit;
                end;

                DoProgressdialogProgress('ERP Defaults'); if not InitcompanyDefaults then exit;;

                DoProgressdialogProgress('Main Menu');

                MainSwitch2 := TMainSwitch2.Create(Self);

                MainSwitch2.Show;
                MainSwitch2.ReadPosfromGuiPrefs;
                //Logmainmenu;

                if not devmode then begin
                  //TfmERPSetup.SetUpERP(CompaniesAlreadyCreated);
                  if not AppEnv.CompanyPrefs.IgnoreTraining then begin
                    DoProgressdialogProgress('Training Setup');
                    TrainingSetupForm := TfmTrainingAssignment.Create(Application);
                    TrainingSetupForm.OpenGoLiveAfterSave := true;
                    TrainingSetupForm.ActivePage := 1;
                    TrainingSetupForm.FormStyle := fsMDIChild;
                    TrainingSetupForm.BringToFront;
                  end;
                end;

                ExpireDays:= DaysBetween(DateUTC, theExpiryDate);

                if ExpireDays < 15 then begin
                  CommonLib.MessageDlgXP_Vista('The Licence for ERP will Expire' +
                    ' in ' + IntToStr(ExpireDays) + ' days!',
                    mtInformation, [mbOk], 0);
                end;

                {$IFDEF EXCEPTIONAL_MAGIC}
                DoProgressdialogProgress('Error Tracking');
                // Needs LicenceCheck to Go First (MainForm.NoClientSlots)
                ExceptionAppInfo.EmployeeLogonName := AppEnv.Employee.LogonName;
                ExceptionAppInfo.CompanyName := CommonDbLib.GetCompanyName;
                ExceptionAppInfo.CompanyDetails := CommonDbLib.GetCompanyDetails;;
      //          ExceptionAppInfo.EmailSMTPHost := AppEnv.CompanyPrefs.EmailSMTPHost;
                ExceptionAppInfo.EmailSMTPPort := 0;
                ExceptionAppInfo.EmailUseAuthentication := False;
                ExceptionAppInfo.EmailAuthUserID := '';
                ExceptionAppInfo.EmailAuthPassword := '';
      //          ExceptionAppInfo.EmailCompanyAddress := AppEnv.CompanyPrefs.EmailSystemAddress;
                ExceptionAppInfo.WindowsVersion := GetWindowsVersion;
                ExceptionAppInfo.MySqlServerVersion := GetMySqlServerVersion;
                ExceptionAppInfo.FileVersion := FileVersion.GetFileVersion(Application.ExeName);
                ExceptionAppInfo.ClientSlots := MainForm.NoClientSlots;
                ExceptionAppInfo.PCName := GetPCName;
                ExceptionAppInfo.PCNetworkName := GetPCNetworkName;
                ExceptionAppInfo.VaildData := True;
                ExceptionAppInfo.TransactionEventsummary := '';
                ExceptionAppInfo.DatabaseName:=AppEnv.AppDb.Database;
                {$ENDIF}

                dtmMainGUI.AuditTrail2.Enabled := (AppEnv.CompanyPrefs.UseAuditTrail and (AppEnv.AccessLevels.GetEmployeeAccessLevel('FnAuditTrail') = 1));

                iTillID := GetAssignedTillId(getPCName());
                if iTillID <> 0 then begin
                  if (IsPrintSpooler(iTillID)) then begin
                    if IsOkToBePrintSpooler() then begin
                      DoProgressdialogProgress('POS Print Spooling');
                      bIsPrintSpooler := true;
                      foRcptPrn := ReceiptPrinterList.CreatePrinter(GetPrinterType(iTillID), GetPrintername(itillID));
                      foRcptPrn.SetDevice(GetPrinterDev(iTillID));
                    end;
                  end;
                end;
          finally
            DoHideProgressbar(prgDlgInitERP);
          end;
        end;
//        if not devmode then
//          CheckTraining;
      finally
        FreeandNil(frmLogon);
      end;

  //  if AppEnv.RegionalOptions.RegionType <> rAust then
  //    StatusBar.Panels[5].Text:=
  //      'ERP Online  <a href="http://www.trueerp.com/"><P align="center">www.trueerp.com</P></a>' ;

    if AppEnv.CompanyPrefs.MonitorTransactionEvents then
      TransactionEvents.DeleteAllTransactionEvents(IncHour(now , 0-6));

    /////////////////////////////////////////
    // Restore Run Closing Dates
    /////////////////////////////////////////

    RunClosingDateRefresh;


    StatusBar.Panels[0].DateFormat := AppEnv.RegionalOptions.ShortDateformat;
    StatusBar.Panels[3].Progress.Position := FSocketSpeed;
    StatusBar.Panels[4].Progress.Position := MemoryUsedPercentage;

    PanelPos := GetPanelPos(2);
    spTCPActive.Parent := StatusBar;
    imAlert.Parent := StatusBar;
    imPhone.Parent := StatusBar;
    spTCPActive.Left := PanelPos.Left + 5;
    spTCPActive.Top := ((StatusBar.Height - spTCPActive.Height) div 2) + 2;
    imAlert.Left := PanelPos.Left + 133;
    imAlert.Top := ((StatusBar.Height - imAlert.Height) div 2);
    imPhone.Left := PanelPos.Left + 149;
    imPhone.Top := ((StatusBar.Height - imPhone.Height) div 2);
    ilAlerts.GetIcon(0, imAlert.Picture.Icon);
    ilAlerts.GetIcon(3, imPhone.Picture.Icon);


    ///////////////////////////////////////////////////////////////////////////
    // Set up the general timer.  It's initial setting here may be different form the interval
    // .. established later in the tmrGeneralTimer event.
    ///////////////////////////////////////////////////////////////////////////
    tmrGeneral.Interval := 5 * 1000; // set timer so that first event will occur in 5 secs
    tmrGeneral.Enabled := true;

    ProcessAppMsgs := true;
    Screen.Cursor := crDefault;
    PresenceTimer.Enabled := false;
    PresenceTimer.Interval := UserPresenceInterval;
    PresenceTimer.Enabled := true;

    TmrPopup.Enabled := false;
//    if AppEnv.CompanyPrefs.ShowToDoNotifications then
//      TmrPopup.Interval := 1000 * 60 * 2
//    else

//    TmrPopup.Interval := iif(devmode , ERPPopupIntervalDevmode , ERPPopupInterval);

     {Disabled the message popup as it was causing access violation}
    //TmrPopup.Interval := 5000;
    //TmrPopup.Enabled := true;


    { activate CyTrack integration if enabled }
    TCyTrack.Inst.Events.AddMultiEvent(DoCyTrackEvent);
    if AppEnv.CompanyPrefs.CyTrackIntegrationEnabled and AppEnv.Employee.CyTrackIntegrationEnabled then begin
      try
        TCyTrack.Inst.CyTrackPort := AppEnv.Employee.CyTrackPortNumber;
        TCyTrack.Inst.Active := true;
      except
        on e: exception do begin
          CommonLib.MessageDlgXP_Vista('An error occured when activating the connection with CyTrack:' +
            #13#10 + #13#10 + e.Message + #13#10 + #13#10 +
            'Please check that CyDesk is running and the Port Number in the CyDesk configuration matches the setting in ERP preferences.',mtWarning,[mbOk],0);
        end;
      end;
    end;

    DoDelayObjectProcedure(StartErpApi,5000, Self.classname +'.StartErpApi');

    if AppEnv.Employee.POSAutoLoad then begin
      if not FormStillOpen('TPOSScreenForm') then begin  // start up POS
        Form := GetComponentByClassName('TPOSScreenForm');
        if Assigned(Form) then begin //if has acess
          with TForm(Form) do begin
            FormStyle := fsmdiChild;
            BringToFront;
          end;
        end;
      end else begin
        with TForm(FindExistingComponent('TPOSScreenForm')) do begin
          Show;
          BringToFront;
        end;
      end;
    end;

    CommandLineFunctionsTimer.Enabled := True;
    RefreshMemoryUsage;
    Self.WindowState := wsMaximized;
    ApplicationStarted:=True;
  finally
      if TranslateFormLanguage then
        DoTranslateFormLanguage;
  end;
  if AppEnv.Employee.POSAutoLoad =False then
    if Appenv.Employee.ShowERPTips then
      ShowERPTip;
  { the following is causing access violations when displaying the pop-up on some machines }
  try
//    ShowPopups(True);
  except

  end;

end;
procedure TMainForm.tmrGeneralTimer(Sender: TObject);
begin
  if tmrGeneral.Interval <> 1000 then tmrGeneral.Interval := 1000;

  if bIsPrintSpooler then begin
    KickTheDrawer;
    ProcessPrintSpool;
  end;
end;

procedure TMainForm.TmrPopupTimer(Sender: TObject);
begin
  inherited;
  try
    TmrPopup.Enabled := false;
    ShowPopups(True);
    if AppEnv.CompanyPrefs.ShowToDoNotifications then
      TmrPopup.Interval := 1000 * 60 * 2
    else
      TmrPopup.Interval := iif(devmode , ERPPopupIntervalDevmode , ERPPopupInterval);

    TmrPopup.Enabled := true;
  Except
    on E:Exception do begin
      if devmode then MessageDlgXP_vista(E.Message, mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TMainForm.unLogAllFormInuse;
begin
  DeleteAllLogInuse;
end;


function TMainForm.GetRemindTime(const dtEventTime: TDateTime; const iMinsBefore: integer): TDateTime;
begin
  Result := IncMinute(dtEventTime, - ((iMinsBefore) + (int64(tmrGeneral.Interval) div (60 * 1000))));
end;


procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  TransactionTableObj: TTransactionTableObj;
  i: integer;
  {$IFNDEF DevMode}
  msg: string;
  UserCount: integer;
  {$ENDIF}
  strErr: string;
  Popup: TComponent;
begin
  if not ExitInProgress then begin
    ExitInProgress := true;


 {$IFDEF DevMode}

 {$ELSE}
    if CommonLib.MessageDlgXP_Vista('Do you really wish to exit ' + AppEnv.ApplicationName + '?', mtConfirmation,[mbYes,mbNo], 0) = mrNo then begin
      ExitInProgress := False;
      Abort;
      exit;
    end;
 {$ENDIF}
    Try
        Action := caFree;

        Application.OnIdle := nil;
        Application.OnMessage := nil;

        for i := 0 to self.ComponentCount - 1 do
          if self.Components[i] is TTimer then begin
            TTimer(self.Components[i]).Enabled := false;
          end;

        If (not CommonDbLib.GetSharedMyDacConnection.Connected) Or RemovingDB then Begin {DB Lost - Remove DB}
          Exit;
        end;

        { free and nil popup window, even though this is created with main as
          owner we where getting av if popup window showing when app closed }
        Popup := FindExistingComponent('TPromptPopup');
        if Assigned(Popup) then begin
          FreeAndNil(Popup);
        end;

//        SysUtils.ForceDirectories('C:\ERP Software\Logs');
        SysUtils.ForceDirectories(ERP_SERVER_LOG_DIR);
        if strErr <> '' then begin
          LogMessage(' Date : ' + FormatDateTime(FormatSettings.ShortDateformat, Now()), ERP_SERVER_LOG_DIR+'LeftBehindSerialno.log');
          LogMessage(strErr, ERP_SERVER_LOG_DIR + 'LeftBehindSerialno.log');
        end;
        if AppContext['Serialnumber'].VarExists('MasterId') then
            AppContext['Serialnumber'].DeleteVar('MasterId');

        if strErr <> '' then begin
          LogMessage(' Date : ' + FormatDateTime(FormatSettings.ShortDateformat, Now()), ERP_SERVER_LOG_DIR+'LeftBehindBin-BatchQty.log');
          LogMessage(strErr, ERP_SERVER_LOG_DIR+'LeftBehindBin-BatchQty.log');
        end;

        // Last Person Out Clean Temp Tables
        if GetCurrentUserCount in [0,1] then begin
          if AppEnv.CompanyPrefs.MonitorTransactionEvents then
            TransactionEvents.DeleteAllTransactionEvents;
          TransactionTableObj := TTransactionTableObj.Create(False);
          try
            Try
  {$IFNDEF DevMode}
              If not CommandLineFunctions.ExitOnComplete then begin
                TransactionTableObj.CleanOutTempTables;
              end;
  {$ENDIF}
              SetBatchInProgress(false);
              if Appenv.CompanyPrefs.USeSalesCommission then begin
                AppEnv.CompanyPrefs.SalesCommissionCalcInProgress := False;
                Appenv.CompanyPrefs.SalesCommissionCalcEmployeeID :=0;
              end;
              UnSetBarTabsConvertStarted;
            except
            end;

          finally
            FreeAndNil(TransactionTableObj);
          end;
        end else if Appenv.CompanyPrefs.SalesCommissionCalcEmployeeID = appenv.Employee.EmployeeID then begin
          if Appenv.CompanyPrefs.USeSalesCommission then begin
            AppEnv.CompanyPrefs.SalesCommissionCalcInProgress := False;
            Appenv.CompanyPrefs.SalesCommissionCalcEmployeeID :=0;
          end;
        end;

        //Remove User Temp Tables
        TransactionTableObj := TTransactionTableObj.Create(False);
        try
          TransactionTableObj.CleanOutUserTempTables;
        finally
          FreeAndNil(TransactionTableObj);
        end;

        {$IFNDEF DevMode}

          if AppEnv.CompanyPrefs.AutoBackup AND not IsTerminateApp then begin
            UserCount:= AppEnv.UtilsClient.GetLoggedOnUserCount(AppEnv.AppDb.Database, true);
            if UserCount > 1 then begin

            end
            else if UserCount < 0 then begin
              MessageDlgXP_Vista('Unable to retrieve list of logged on users at this time, skipping backup.', mtInformation, [mbOk], 0);
            end
            else begin
              self.Enabled:= false;
              try
                if not frmDatabaseBackup.DbBackup(AppEnv.AppDb.Database,AppEnv.AppDb.UserName, AppEnv.UtilsClient, msg,true) then begin
                  CommonLib.MessageDlgXP_Vista('Backup failed with message: ' + msg, mtWarning, [mbOK], 0);
                end;
              finally
                self.Enabled:= true;
              end;
            end;
          end;
        {$ENDIF}
        { unlock all users and unlog all forms when logs out - just in case }
        { Note this is done by UserUtils module on the server when user disconnects }

        unLogAllFormInuse;

        // Here we release all the mdi child forms.  If we don't do this then (at the very least)
        // .. we get issues during ERP's shutting down process (it crashes) if we have accessed the
        // .. TrafficPro in POS using its ActiveX DLL
        for i := 0 to self.MDIChildCount - 1 do begin
          if self.MDIChildren[i] is TMainSwitch2 then
            self.MDIChildren[i].Close
          else
            self.MDIChildren[i].Release;
        end;

        AppEnv.UtilsClient.Disconnect;

        if Assigned(AppRes) then
          FreeAndNil(AppRes);
    finally
      ExitInProgress := false;
    end;
  end;
end;

procedure TMainForm.LoadVideoURLs(const sButtonCaption:string);
var
  lForm : TERPTrainingVideosGUI;
begin
  lForm := TERPTrainingVideosGUI(FindExistingComponent('TERPTrainingVideosGUI'));
  if assigned(lForm) then
    lForm.PageName := sButtonCaption;
end;

procedure TMainForm.FormCreate(Sender: TObject);
type
   TUserConnectAction = (ucaNo,ucaReconnect,ucaNew,ucaShowVideo,ucaShowHelp);
const
  CONNECTION_HELP_VIDEO = 'Connection.exe';
  CONNECTION_HELP_PDF = 'ConnectionHelp.pdf';
var
  svrName: string;
  appDir: string;

  function GetUserConnectAction: TUserConnectAction;
  var dlgResult: integer;
  begin
    result:= ucaNo;
    if AppEnv.AppDb.LastConnectServer <> '' then begin
      dlgResult:=
        MessageDlgXP_Vista('You were previously connected to "' +
          AppEnv.AppDb.LastConnectServer + '" and have since lost connection.' +
          #13#10 + #13#10 +
          'Please check under F1, help "Lost Connection" as to the possible reasons.' +
          #13#10 + #13#10 +
          'Would you like to try to re-connect to "' + AppEnv.AppDb.LastConnectServer +
          '" or do you want to connect to a different server?',
          mtInformation,[],0,nil,'','',false,nil,'F1 Help,Video Help,Reconnect,New,No');
      case dlgResult of
        100: result:= ucaShowHelp;
        101: result:= ucaShowVideo;
        102: result:= ucaReconnect;
        103: result:= ucaNew;
        104: result:= ucaNo;
      end;
    end
    else begin
      dlgResult:=
        MessageDlgXP_Vista('Could not connect to ERP Server.' +
          #13#10 + #13#10 +
          'Please check under F1, help "Lost Connection" as to the possible reasons.' +
          #13#10 + #13#10 +
          'Would you like to select a different server?',
          mtInformation,[],0,nil,'','',false,nil,'F1 Help,Video Help,New,No');
      case dlgResult of
        100: result:= ucaShowHelp;
        101: result:= ucaShowVideo;
        102: result:= ucaNew;
        103: result:= ucaNo;
      end;
    end;
  end;


begin
  fbRefreshedERPInfo:=False;
  ApplicationStarted:= False;
//@@  ShowMeform := nil;
  { NOTE: SetThreadPriority has been commented out because this causes big
          speed problems on single core non-hyperthread machines.
          Seems that the VCL thread is running at such a high priority
          that other threads (eg DNMSpeedButtons) don't get a look in. }
//  SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_ABOVE_NORMAL);
  GlobalEvents.RegisterNameHandler(Self, '', '', GEVENT_AnyActionExecuting, GlobalEventHandler);
  GlobalEvents.RegisterNameHandler(Self, '', '', GEVENT_AnyActionExecuted, GlobalEventHandler);
  GlobalEvents.RegisterNameHandler(Self, '', '', GEVENT_MESSAGEDLGXP_VISTA, GlobalEventHandler);

  inherited;
  RestartApp := False;
  RemovingDB := False;
  IsTerminateApp := False;
  FFormSwitch := nil;
  FAltKeyDown := false;
  FStoredOnIdle := Application.OnIdle;
  FStoredOnMessage := Application.OnMessage;
  FSocketSpeed := 100;
  IdleCounter := 0;
  Try
    MouseHook := SetWindowsHookEx(WH_MOUSE, AppHookMouse, HInstance, GetCurrentThreadID);
    KeyboardHook := SetWindowsHookEx(WH_KEYBOARD, AppHookKeyboard, HInstance, GetCurrentThreadID);
  except
  end;

  { commented out the following as it is stopping action OnUpdates from being called on forms }
  Application.OnIdle := HandleOnIdle;
  Application.OnMessage := InterceptMessages;

  ProcessAppMsgs := false;

  {$IFDEF EXCEPTIONAL_MAGIC}
  DisableExceptionalMagic;
  {$ENDIF}

  AppEnv.UtilsClient.OnLoggedInUserCountChange:= DoOnLoggedInUserCountChange;
  AppEnv.UtilsClient.OnLostConnection:= DoOnLostUtilsServerConnection;

  if not AppEnv.AppDb.ConfigFileAccessOk then begin
    CommonLib.MessageDlgXP_Vista('ERP does not have permission to read/write the configuration file "' +
      SystemLib.ExeDir + AppDatabase.CONFIG_FILE +'".' + #13#10 + #13#10 +
      'Please ensure that the Windows user you are logged on as has full permissions to this directory before running ERP', mtWarning, [mbOK], 0);
    MainForm.TerminateApp;
    Exit;
  end;

  if not AppEnv.AppDb.ServerOk then begin

    appDir:= SystemLib.ExeDir;
    case GetUserConnectAction of
      ucaNo:
        begin
          MainForm.TerminateApp;
          Exit;
        end;
      ucaReconnect:
        begin
          AppEnv.AppDb.Server:= AppEnv.AppDb.LastConnectServer;
          if not AppEnv.AppDb.ServerOk then begin
            CommonLib.MessageDlgXP_Vista('The ERP Server: "' + AppEnv.AppDb.Server + '" Cannot be located.', mtWarning, [mbOK], 0);
            MainForm.TerminateApp;
            Exit;
          end;
        end;
      ucaNew:
        begin
          svrName:= AppEnv.AppDb.Server;
          if GetMySQLServerFromUser(svrName, AppEnv.AppDb.LastConnectServer) then begin
            AppEnv.AppDb.Server:= svrName;
            if not AppEnv.AppDb.ServerOk then begin
              CommonLib.MessageDlgXP_Vista('The ERP Server: "' + AppEnv.AppDb.Server + '" Cannot be located.', mtWarning, [mbOK], 0);
              MainForm.TerminateApp;
              Exit;
            end;
          end
          else begin
            MainForm.TerminateApp;
            Exit;
          end;
        end;
      ucaShowVideo:
        begin
          { start video then exit }
          if not TFileDownloader.DownloadFile(VIDEO_FTP_URL+CONNECTION_HELP_VIDEO,
                      appDir + CONNECTION_HELP_VIDEO) then begin
             MessageDlgXP_Vista('Unable to download video file from the internet.', mtInformation, [mbOK], 0);
          end;
          if FileExists(appDir + CONNECTION_HELP_VIDEO) then begin
            { play it ... }
            ShellExecute(Handle, 'open',PChar(appDir + CONNECTION_HELP_VIDEO),pChar(appDir), pChar(appDir), SW_SHOW);
          end;
          MainForm.TerminateApp;
          Exit;
        end;
      ucaShowHelp:
        begin
          if not TFileDownloader.DownloadFile(VIDEO_FTP_URL+CONNECTION_HELP_PDF,
                      appDir + CONNECTION_HELP_PDF) then begin
             MessageDlgXP_Vista('Unable to download latest help file from the internet.', mtInformation, [mbOK], 0);
          end;
          { show help then exit }
          if FileExists(appDir + CONNECTION_HELP_PDF) then begin
            ShellExecute(Handle, 'open',PChar(appDir + CONNECTION_HELP_PDF),pChar(appDir), pChar(appDir), SW_SHOW);
          end
          else begin
            MessageDlgXP_Vista('Can''t find help file: ' + appDir + CONNECTION_HELP_PDF, mtWarning, [mbOK], 0);
          end;

          MainForm.TerminateApp;
          Exit;
        end;
    end;

  end;
  AppRes := TAppResolution.Create(1024, 768);
  UserLock := TUserLock.Create(self);

  {$IFDEF EXCEPTIONAL_MAGIC}
  EnableExceptionalMagic;
  {$ENDIF}

  fbForceUseExitBtn := false;
  flstReceipt := TStringList.Create;
  bIsPrintSpooler := false;
  //iReminderCnt := 0;
  CommandLineFunctions := TCommandLineFunctions.Create;
  If not Assigned(MsgInterface) then
    MsgInterface := TMsgInterface.Create(Application);
  MsgHandler := TMsgHandler.Create(Self);
  GlobalEvents.Notify(Self, GEVENT_FormCreate_After);

  with TfrmActiveWindows(GetComponentByClassName('TfrmActiveWindows')) do begin  //don't need access levels
      Left:=Screen.Width-Width;
      Top:=Screen.Height-Height-GetTaskBarHeight;
  end;
end;

function TMainForm.GetCurrentUserCount(HideThisUser: boolean = true): integer;
Var
  TempStr: TStringList;
  s: string;
begin
  result:= -1;
  if AppEnv.UtilsClient.GetLoggedOnUserList(s, AppEnv.AppDb.Database) then begin

    TempStr:= TStringList.Create;
    try
      TempStr.CommaText:= s;
      result:= TempStr.Count;
      if HideThisUser then begin
        if TempStr.IndexOf(AppEnv.AppDb.UserName) > -1 then
          TempStr.Delete(TempStr.IndexOf(AppEnv.AppDb.UserName));
      end;
      If Assigned(dtmMainGUI) then begin
        dtmMainGUI.dlgCurrentUsers.Items.Assign(TempStr);
      end;
    finally
      TempStr.Free;
    end;
  end;
end;

function TMainForm.RemoveAllConnectionsToDB(const ExceptThisForm: string = ''): boolean;
var
  iFormCount: integer;
  FormDescStr: string;
  st:TStringList;
begin

  Result := false;
  try
    st:= TStringList.create;
    try
      st.CaseSensitive := False;
      st.Commatext := ExceptThisForm;
      //Check No Forms Open apart From MainSwitch and Main
      for iFormCount := 0 to MDIChildCount - 1 do begin
        if not (MDIChildren[iFormCount] is TMainForm) and not (MDIChildren[iFormCount] is TMainSwitch2) then
        begin

               if st.IndexOf(MDIChildren[iFormCount].ClassName)>=0                  then continue
          else if Sysutils.SameText('TfmVideo' ,MDIChildren[iFormCount].ClassName) then continue
          else if (ExceptThisForm = MDIChildren[iFormCount].ClassName)              then Continue;

          FormDescStr := GetFormDescription(MDIChildren[iFormCount].ClassName);
          if Empty(FormDescStr) then begin
            CommonLib.MessageDlgXP_Vista('Please Close All Open ERP Windows !', mtWarning, [mbOK], 0);
          end else begin
            CommonLib.MessageDlgXP_Vista('You Still Have ' + FormDescStr + ' Open !', mtWarning, [mbOK], 0);
          end;
          Exit;
        end;
      end;

    PresenceTimer.Enabled := false;
    PresenceTimer.Interval := UserPresenceInterval;
    PresenceTimer.Enabled := true;


      Result := true;
    finally
      FreeandNil(st);
    end;
  except
    Result := false;
  end;
end;


procedure TMainForm.Backup1Click(Sender: TObject);
var
  msg: string;
begin
  if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnBackup') <> 1 then begin
    CommonLib.MessageDlgXP_Vista(Format('You don''t have access to %s.',
      [AppEnv.AccessLevels.GetFormDescription('FnBackup')]), mtInformation, [mbOK], 0);
    Exit; // ====>  EXIT
  end;
  if not RemoveAllConnectionsToDB then
    Exit;

  if not frmDatabaseBackup.DbBackup(AppEnv.AppDb.Database,AppEnv.AppDb.UserName, AppEnv.UtilsClient, msg) then begin
    CommonLib.MessageDlgXP_Vista('Backup failed with message: ' + msg, mtWarning, [mbOK], 0);
  end;

//  if AppEnv.UtilsClient.LockLogon(msg,AppEnv.AppDb.Database, 'Performing a Backup DB') then begin
//    try
//      self.Enabled:= false;
//      try
//        if not AppEnv.UtilsClient.DatabaseBackup(Appenv.AppDb.Server,AppEnv.AppDb.Database,msg) then begin
//          CommonLib.MessageDlgXP_Vista('Backup failed with message: ' + msg, mtWarning, [mbOK], 0);
//        end;
//      finally
//        self.Enabled:= true;
//      end;
//    finally
//      AppEnv.UtilsClient.UnlockLogon;
//    end;
//  end
//  else begin
//    if msg = USERS_IN_SYSTEM_MESSAGE then begin
//      if GetCurrentUserCount > 0 then begin
//        dtmMainGUI.dlgCurrentUsers.Caption := AppEnv.AppDb.Database + ' Backup';
//        dtmMainGUI.dlgCurrentUsers.Color := $00D7F5FF;
//        dtmMainGUI.dlgCurrentUsers.Message := 'The following user(s) must exit the system.';
//        dtmMainGUI.dlgCurrentUsers.Execute;
//      end
//      else begin
//        MessageDlgXP_Vista('Unable to retrieve list of logged on users at this time.', mtInformation, [mbOk], 0);
//      end;
//    end
//    else begin
//      MessageDlgXP_Vista('Unable to Backup Database, Unable to Lock User Logon: ' + msg, mtInformation, [mbOk], 0);
//    end;
//  end;
end;

procedure TMainForm.SubformPostionMiddle(Sender: TForm);
begin
  Sender.Top  := (Self.Height - Sender.Height) div 2 - Self.ClientOrigin.Y - Self.MainToolBar.Height + Self.StatusBar.Height;
  Sender.Left := (Self.Width  - Sender.Width ) div 2;
end;
Function TMainForm.Formheight:Integer;
begin
  result := Clientheight - MainToolBar.height;
end;
procedure TMainForm.NonERPClone1Click(Sender: TObject);
var
  fsCloneDBName: string;
  i: integer;
  msg: string;
begin
  if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnNonERPClone') <> 1 then begin
    CommonLib.MessageDlgXP_Vista('You don''t have access to '+AppEnv.AccessLevels.GetFormDescription('FnNonERPClone')+'.', mtInformation, [mbOK], 0);
    Exit; // ====>  EXIT
  end;
  i := 0;
  fsCloneDBName := CommonDbLib.GetSharedMyDacConnection.Database+'_NonERPClone';
  if DBExists(fsCloneDBName) then
    if not DropDatabase(fsCloneDBName, Msg) then begin
      CommonLib.MessageDlgXP_Vista('Dropping Database ' + fsCloneDBName + ' Failed!' + NL+NL + Msg, mtInformation, [mbOK], 0);
      Exit;
    end;

  if not RemoveAllConnectionsToDB then Exit;

  Self.Enabled := False;
  try
    if not frmDatabaseBackup.DBNonERPClone(appenv.appdb.Database, fsCloneDBName, appenv.appdb.UserName,
      appenv.UtilsClient, Msg) then begin
      CommonLib.MessageDlgXP_Vista('Copy failed with message: ' + Msg, mtWarning, [mbOK], 0);
    end;
  finally
    Self.Enabled := true;
  end;
end;
procedure TMainForm.Restore1Click(Sender: TObject);
var
  sl, slDB: TStringList;
  FileName: string;
  theDatabase: string;
  msg, list: string;
  selectDialog: TSelectionDialog;
  restoreOk, restoreDone: boolean;
begin
  restoreOk:= true;
  restoreDone:= false;
  {The user doesn't have access}
  if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnRestore') <> 1 then begin
    CommonLib.MessageDlgXP_Vista(Format('You don''t have access to %s.',
      [AppEnv.AccessLevels.GetFormDescription('FnRestore')]), mtInformation, [mbOK], 0);
  end
  else begin
    if not RemoveAllConnectionsToDB then
      Exit;

    sl := TStringList.Create;
    slDB := TStringList.Create;
    try
      if AppEnv.UtilsClient.GetBackupArchiveList(msg,list,AppEnv.AppDb.Database) then begin
        sl.CommaText:= list;
        if sl.Count > 0 then begin
          selectDialog:= TSelectionDialog.Create(nil);
          try
            selectDialog.Color:= $00DCFAF9;
            selectDialog.Items.Assign(sl);
            selectDialog.Caption:= 'Select Archive to restore ' + AppEnv.AppDb.Database;
            if selectDialog.Execute then begin
              theDatabase := AppEnv.AppDb.Database;
              FileName := selectDialog.SelectedItems[0];
              if CommonLib.MessageDlgXP_Vista(Format('WARNING....You are about to replace database %s ' + 'with an older version'#13#10'(%s). ' + #13#10'Do you wish to continue?', [theDatabase, FileName]), mtWarning, [mbYes, mbNo], 0) = mrYes then begin
                CommonDbLib.GetSharedMyDacConnection.Disconnect;
                self.Enabled:= false;
                try
                  restoreDone:= true;
                  restoreOk:= frmDatabaseBackup.DbRestore(AppEnv.AppDb.Database,AppEnv.AppDb.UserName,FileName,true,AppEnv.UtilsClient, msg);
                  if not restoreOK then begin
                    CommonLib.MessageDlgXP_Vista('Restore failed with message: ' +
                      msg + #13#10 + #13#10 + 'ERP will now close.', mtWarning, [mbOK], 0);
                  end;
                finally
                  self.Enabled:= true;
                  if restoreOk then
                    CommonDbLib.GetSharedMyDacConnection.Connect;
                end;
              end;
            end;
          finally
            selectDialog.Free;
          end;
        end
        else begin
          CommonLib.MessageDlgXP_Vista('No Backups For ' + AppEnv.AppDb.Database + ' Found', mtWarning, [mbOK], 0);
        end;
      end
      else begin
        CommonLib.MessageDlgXP_Vista('Unable To Restore Database: ' + msg, mtInformation, [mbOk], 0);
      end;
    finally
      FreeAndNil(slDB);
      FreeAndNil(sl);
    end;
    if restoreOk then begin
      if RestoreDone then begin
        SetBatchInProgress(true);
        OpenCompanyDbClick(nil);
      end;
    end
    else begin
      { we dont know what state the database is in now so close the app }
      TerminateApp;
    end;
  end;

//    if AppEnv.UtilsClient.LockLogon(msg,AppEnv.AppDb.Database, 'Performing a Restore DB') then begin
//      try
//        sl := TStringList.Create;
//        slDB := TStringList.Create;
//        try
//          if AppEnv.UtilsClient.GetBackupArchiveList(msg,list,AppEnv.AppDb.Database) then begin
//            sl.CommaText:= list;
//            if sl.Count > 0 then begin
//              selectDialog:= TSelectionDialog.Create(nil);
//              try
//                selectDialog.Color:= $00DCFAF9;
//                selectDialog.Items.Assign(sl);
//                selectDialog.Caption:= 'Select Archive to restore ' + AppEnv.AppDb.Database;
//                if selectDialog.Execute then begin
//                  theDatabase := AppEnv.AppDb.Database;
//                  FileName := selectDialog.SelectedItems[0];
//                  if CommonLib.MessageDlgXP_Vista(Format('WARNING....You are about to replace database %s ' + 'with an older version'#13#10'(%s). ' + #13#10'Do you wish to continue?', [theDatabase, FileName]), mtWarning, [mbYes, mbNo], 0) = mrYes then begin
//                    CommonDbLib.GetSharedMyDacConnection.Disconnect;
//                    self.Enabled:= false;
//                    try
//                      restoreDone:= true;
//                      if not AppEnv.UtilsClient.DatabaseRestore(Appenv.AppDb.Server,AppEnv.AppDb.Database,FileName,msg) then begin
//                        restoreOk:= false;
//                        CommonLib.MessageDlgXP_Vista('Restore failed with message: ' +
//                          msg + #13#10 + #13#10 + 'ERP will now close.', mtWarning, [mbOK], 0);
//                      end;
//                    finally
//                      self.Enabled:= true;
//                      if restoreOk then
//                        CommonDbLib.GetSharedMyDacConnection.Connect;
//                    end;
//                  end;
//                end;
//              finally
//                selectDialog.Free;
//              end;
//            end
//            else begin
//              CommonLib.MessageDlgXP_Vista('No Backups For ' + AppEnv.AppDb.Database + ' Found', mtWarning, [mbOK], 0);
//            end;
//          end
//          else begin
//            CommonLib.MessageDlgXP_Vista('Unable To Restore Database: ' + msg, mtInformation, [mbOk], 0);
//          end;
//        finally
//          FreeAndNil(slDB);
//          FreeAndNil(sl);
//        end;
//
//      finally
//        AppEnv.UtilsClient.UnlockLogon;
//      end;
//    end
//    else begin
//      if msg = USERS_IN_SYSTEM_MESSAGE then begin
//        if GetCurrentUserCount > 0 then begin
//          dtmMainGUI.dlgCurrentUsers.Caption := AppEnv.AppDb.Database + ' Restore';
//          dtmMainGUI.dlgCurrentUsers.Color := $00D7F5FF;
//          dtmMainGUI.dlgCurrentUsers.Message := 'The following user(s) must exit the system.';
//          dtmMainGUI.dlgCurrentUsers.Execute;
//        end
//        else begin
//          MessageDlgXP_Vista('Unable to retrieve list of logged on users at this time.', mtInformation, [mbOk], 0);
//        end;
//      end
//      else begin
//        MessageDlgXP_Vista('Unable to Restore Database, Unable to Lock User Logon: ' + msg, mtInformation, [mbOk], 0);
//      end;
//    end;
//  end;
//  if restoreOk then begin
//    if RestoreDone then begin
//      SetBatchInProgress(true);
//      OpenCompanyDbClick(nil);
//    end;
//  end
//  else begin
//    { we dont know what state the database is in now so close the app }
//    TerminateApp;
//  end;
end;

procedure TMainForm.FormPaint(Sender: TObject);
begin
  try
    If (not RemovingDB) then begin //Stop Access to DB After RemoveDB
      inherited;
      if Empty(OriginalCaption) then begin
        OriginalCaption := Self.Caption;
      end;
      RefreshERPInfo;
      //PaintGradientColor(Self);
    end;
  Except
    on E:Exception do begin
      if devmode then MessageDlgXP_vista(E.Message, mtWarning, [mbOK], 0);
    end;
  end;
end;

Procedure TMainForm.RefreshERPInfo;
var
  BatchDateStr: string;
begin
  if fbRefreshedERPInfo then exit;
  Try
      if AppEnv.AppDb.Connection.Connected then begin
        if not AppEnv.CompanyPrefs.ClosingDateChangeDone then begin
          Self.Caption := OriginalCaption + '     -     ****** ' + DoTranslate('Closing Date Refresh Incomplete')+' / ' + DoTranslate('Not Done') +' ******';
        end
        else begin
          BatchDateStr:= GetBatchDate;
          if Trim(BatchDateStr) <> '' then
            Self.Caption := OriginalCaption + '     -     ' + DoTranslate('Batch Transaction Last Update On') + ' " ' + BatchDateStr + ' "'
          else
            Self.Caption := OriginalCaption + '     -     ****** ' + DoTranslate('Batch Transaction Incomplete')+' / ' + DoTranslate('Not Done')+' ******';
        end;
      end;
      SetUSerLbl;
      StatusBar.Update;
      fbRefreshedERPInfo:= TRue;
  Except
    on E:Exception do begin
      if devmode then MessageDlgXP_vista(E.Message, mtWarning, [mbOK], 0);
    end;
  end;
end;
procedure TMainForm.FormResize(Sender: TObject);
begin
  inherited;
  lblUser.Left := 0;
  LblUSer.Width := Self.Width;
end;

procedure TMainForm.OnCallerClick(Sender: TObject);
var
  CallRec: TCyTrackCallerRec;
begin
  if (Sender is TLabel) and (TLabel(Sender).Tag > 0) then begin
    CallRec := TCyTrackCallerRec(TLabel(Sender).Tag);
    if CallRec.IsCustomer then
      OpenERPForm('TfrmCustomer',CallRec.ClientId,nil,nil,false,false)
    else if CallRec.IsSupplier then
      OpenERPForm('TfmSupplier',CallRec.ClientId,nil,nil,false,false)
    else if CallRec.IsSupplier then
      OpenERPForm('TfrmOtherContact',CallRec.ClientId,nil,nil,false,false);

    if CallRec.ContactId <> 0 then
      OpenERPForm('TfrmContact',CallRec.ContactId,nil,nil,false,false);
  end;
end;

procedure TMainForm.OpenCompanyDbClick(Sender: TObject);
begin
  AppRes.Restore(Sender);
  RestartApp := True;
  MainForm.TerminateApp;
end;

procedure TMainForm.ExecNewProcess;
Var
  BatchFile: TStringList;
begin
  BatchFile := TStringList.Create;
  try
    BatchFile.Clear;
    BatchFile.Add('ping 127.0.0.1 -n 4 -w 1000 > nul');
    BatchFile.Add('cd "'+SystemLib.ExeDir+'"');
    BatchFile.Add('START '+ExtractFileName(Application.ExeName));
    BatchFile.Add('DEL /Q /F "'+ SystemLib.ExeDir+'RestartApp.bat"');
    BatchFile.SaveToFile(SystemLib.ExeDir+'RestartApp.bat');
  finally
    BatchFile.Free;
  end;
  WinExec(SystemLib.ExeDir+'RestartApp.bat', SW_HIDE);
end;

procedure TMainForm.mitNewCompanyClick(Sender: TObject);
var
  sDBName: string;
begin
  // Create a new database
  sDBName := NewCompany;
  if sDBName = '' then Exit;

  if AppEnv.CompanyPrefs.CopyOutstandingTxn then begin
    // Copy outstanding transactions if set
    dlgCopyTxnProgress2.Caption:= 'Copying outstanding transactions ...';
    dlgCopyTxnProgress2.MinValue:= 0;
    dlgCopyTxnProgress2.MaxValue:= 100;
    dlgCopyTxnProgress2.Step:= 1;
    dlgCopyTxnProgress2.Value:= 0;
    dlgCopyTxnProgress2.Execute;

    if not TNewDbUtils.CopyTransactions(sDBName, nil, dlgCopyTxnProgress2) then
      CommonLib.MessageDlgXP_Vista('Copying outstanding transactions failed.', mtInformation, [mbOK], 0);

    dlgCopyTxnProgress2.CloseDialog;
  end;

  if sDBName <> '' then begin
    CommonLib.MessageDlgXP_Vista('New company database "' + sDBName + '" creation complete.', mtInformation, [mbOK], 0);
  end;
end;

function TMainForm.NewCompany: String;
var
  sDBName: string;
  VersionMatch: boolean;
  msg: string;
  currentServer,currentDatabase,
  currentUserName,currentFirstName,currentLastName,currentPass: string;
  newRegion, currentRegion: string;
  UserCount: integer;
begin
  sDBName := '';
  Result := '';
  newRegion:= '';
  currentRegion:= appEnv.CompanyPrefs.CompanyRegion;
  if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnNewCoDatabase') <> 1 then begin
    CommonLib.MessageDlgXP_Vista(Format('You don''t have access to create %s.',
      [AppEnv.AccessLevels.GetFormDescription('FnNewCoDatabase')]), mtInformation, [mbOK], 0);
    Exit;
  end;

  if not ModalInputBox('New Company DB', 'Enter New Company Database', sDBName) then
    Exit;

  // Ensure that the New database name doesnt already exist.
  if DBExists(sDBName) then begin
  // It does, report error to user.
 {$IFDEF DevMode}
    if SameTExt(Appenv.Appdb.Database, sdbname) then begin
      CommonLib.MessageDlgXP_Vista('A Database With the Same Name Already Exists and you are already logged in !', mtInformation, [mbOK], 0);
      Exit;
    end else if CommonLib.MessageDlgXP_Vista('A Database With the Same Name Already Exists! do you wish to drop this database and create New?', mtconfirmation, [mbyes,mbno], 0) = mrno then Exit;
    if not DropDatabase(sDBName,msg) then begin
      CommonLib.MessageDlgXP_Vista('Dropping Database '+sdbname+' Failed!'+chr(13) +chr(13) +msg, mtInformation, [mbOK], 0);
      Exit;
    end;
 {$ELSE}
    CommonLib.MessageDlgXP_Vista('A Database With the Same Name Already Exists!', mtInformation, [mbOK], 0);
    Exit;
 {$ENDIF}
  end;

  if Empty(sDBName) then Exit;

  if not ValidAlphaNumericCharacters(sDBName) then begin
    CommonLib.MessageDlgXP_Vista('No non alphanumeric characters allowed in Database name.', mtInformation, [mbOK], 0);
    Exit;
  end;

  if not ValidDatabasename(sDBName) then begin
    Exit;
  end;

  if not RemoveAllConnectionsToDB then Exit;

  UserCount:= AppEnv.UtilsClient.GetLoggedOnUserCount(AppEnv.AppDb.Database);
  if UserCount > 1 then begin
    // Ensure there is only one user connected to the database.  That is You only!
    if GetCurrentUserCount > 1 then begin
      dtmMainGUI.dlgCurrentUsers.Caption := AppEnv.AppDb.Database + ' Create New Company';
      dtmMainGUI.dlgCurrentUsers.Color := $00D7F5FF;
      dtmMainGUI.dlgCurrentUsers.Message := 'The following user(s) must exit the system.';
      dtmMainGUI.dlgCurrentUsers.Execute;
    end else begin
      { some other process is connected to database }
      CommonLib.MessageDlgXP_Vista('Can not create new company as there are other processes connected the current database.', mtWarning, [mbOK], 0);
    end;
    Exit;
  end else if UserCount < 0 then begin
    MessageDlgXP_Vista('Unable to retrieve list of logged on users at this time, unable to create new company.', mtInformation, [mbOk], 0);
    Exit;
  end;

  OpenPrefform('Utilities', 'chkCopyDataOnNew', 0, True, 'New Database Default Data', 'pnlNewDatabaseDefaultData',
              'Choosing any checkbox here will copy the relevant data from the current database ' + Quotedstr(AppEnv.AppDb.Database ) +' into the new database.'+NL+
              'Choosing ''Cancel'' will continue with the current selections.');

  CommonDbLib.GetSharedMyDacConnection.Disconnect; // was used by above function
  VersionMatch := DatabaseVersionMatch;

  if (not AppEnv.CompanyPrefs.CopyDataToNewDB) or VersionMatch then begin
    self.Enabled:= false;
    try
      currentServer:= AppEnv.AppDb.Server;
      currentDatabase:= AppEnv.AppDb.Database;
      currentUserName:= AppEnv.AppDb.UserName;
      currentFirstName:= AppEnv.Employee.FirstName;
      currentLastName:= AppEnv.Employee.LastName;
      currentPass:= AppEnv.AppDb.UserPass;
      try
        { we need to connect to ernew db to sellect or add a region }
        AppEnv.UtilsClient.Disconnect;
        AppEnv.AppDb.Connection.Disconnect;
        AppEnv.AppDb.Database := 'erpnewdb';
        AppEnv.AppDb.ConnectUser('Admin', 'Admin');
        if not AppEnv.UtilsClient.ConnectUser(msg,currentServer, 'erpnewdb', 'Admin') then begin
          CommonLib.MessageDlgXP_Vista('Database copy failed, could not connect to template database (ernewdb) with message: ' + msg, mtWarning, [mbOK], 0);
          Exit;
        end;
        { select the region }
        newRegion:= DoSelectRegion;
        if newRegion = '' then
          exit; { user canceled }
      finally
        { reconnect to previous database}
        AppEnv.UtilsClient.Disconnect;
        AppEnv.AppDb.Connection.Disconnect;
        AppEnv.AppDb.Database:= currentDatabase;
        AppEnv.AppDb.ConnectUser(currentUserName,currentPass);
        if not AppEnv.AppDb.Connection.connected then begin
            CommonLib.MessageDlgXP_Vista('Database copy failed, could not reconnect to database with message: ' + msg +
                    #13#10 + #13#10 + 'ERP will now close, please restart ERp and log in again.', mtWarning, [mbOK], 0);
        end;
        if not AppEnv.UtilsClient.ConnectUser(msg,currentServer,currentDatabase,currentUserName,currentFirstName,currentLastName) then begin
          CommonLib.MessageDlgXP_Vista('Database copy failed, could not reconnect to database with message: ' + msg +
            #13#10 + #13#10 + 'ERP will now close, please restart ERP and log in again.', mtWarning, [mbOK], 0);
          MainForm.TerminateApp;
        end;
      end;

//    if not AppEnv.UtilsClient.DatabaseCopy(AppEnv.AppDb.Server,'erpnewdb',sDBName,msg) then begin
      if not frmDatabaseBackup.DbCopy('erpnewdb', sDBName, AppEnv.AppDb.UserName, AppEnv.UtilsClient, msg, true) then begin
        CommonLib.MessageDlgXP_Vista('Database copy failed with message: ' + msg, mtWarning, [mbOK], 0);
        Exit;
      end;
    finally
      self.Enabled:= true;
    end;
  end;

  // Now copy over the old table data to the new
  if AppEnv.CompanyPrefs.CopyDataToNewDB then begin
    if VersionMatch then begin
      if newRegion = currentRegion then
        CopyOldDBTablesToNewDB(sDBName, CommonDbLib.GetSharedMyDacConnection)
      else
        CommonLib.MessageDlgXP_Vista('The new company is in a different region (' +
        newRegion + '), so company data will not be copied', mtInformation, [mbOK], 0);
    end
    else
      CommonLib.MessageDlgXP_Vista('The ' + CommonDbLib.GetSharedMyDacConnection.Database +
        ' database version does not match ERPNewDB.' + #13#10#13#10 +
        'They should match to copy the database.', mtInformation, [mbOK], 0);
  end;

  SetNewCompanyDefaultValues(sDBName, CommonDbLib.GetSharedMyDacConnection);

  Result := sDBName;
end;


function TMainForm.GetBatchDate: string;
var
  TempDate: TDateTime;
begin
  If not (csDestroying in ComponentState) then Begin
    Try
      TempDate := AppEnv.CompanyPrefs.TransactionTableLastUpdated;

      if TempDate = 0 then
        Result := ' '
      else
        Result := FormatDateTime('dddd, mmmm d, yyyy, " at " hh:mm AM/PM', TempDate);
    except
      Result:='';
    end;
  end else
    Result:='';

end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
var
  Index: integer;
begin
  Index := 0;
  while Index < Application.ComponentCount do begin
    if Application.Components[Index] is TBaseListingGUI then begin
      if TBaseListingGUI(Application.Components[Index]).Exporting then begin
        CommonLib.MessageDlgXP_Vista('List exporting is currently being processed.' + #13#10#13#10 +
          'Please wait until it is completed to exit.', mtInformation, [mbOK], 0);
        CanClose := false;
      end;
    end;
    Inc(Index);
  end;
end;

procedure TMainForm.ProcessPrintSpool;
var
  qryTill: TERPQuery;
  bPrintStarted: boolean;
begin
  bPrintStarted := false;
  if not fbSpoolPrintInProgress then begin
    qryTill := TERPQuery.Create(nil);
    qryTill.Options.FlatBuffers := True;
    qryTill.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTill.ParamCheck := false;
    try
      fbSpoolPrintInProgress := true;
      flstReceipt.Clear;
      with qryTill do begin
        SQL.Clear;
        SQL.Add('SELECT TillID, RemoteReceipt, PrintRemoteReceipt ' +
          'FROM tblPOSTills ' +
          'WHERE RemoteTillID =' + IntToStr(iTillID) + ' AND ' +
          'PrintRemoteReceipt = "T" ' +
          'AND Active = "T"');
        Open;
        First;
        if not IsEmpty then begin
          // just grab the first one - restrict to one at a time
          flstReceipt.Text := qryTill.FieldByName('RemoteReceipt').AsString;
          Edit;
          FieldByName('PrintRemoteReceipt').AsString := 'F';
          Post;
          {printThread := }//Remove Hint
          TPrintSpoolThread.Create(false); // this thread does the printing of flstReceipt
          bPrintStarted := true;
        end;
      end;
    finally
      fbSpoolPrintInProgress := bPrintStarted;
      FreeAndNil(qryTill);
    end;
  end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
var
  env: TAppEnvironment;
begin
  env := AppEnv;
  if Assigned(env) then begin
    UserLock.LockOwnerUserName := AppEnv.Employee.LogonName;
    UserLock.UnlockAllCurrentUser;
    emptyLogbusobj;
  end;
  UnhookWindowsHookEx(MouseHook);
  UnhookWindowsHookEx(KeyboardHook);
  ReceiptPrinterList.FreePrinter(foRcptPrn);
  FreeAndNil(flstReceipt);
  FreeAndNil(FFormSwitch);
  FreeAndNil(CommandLineFunctions);
  FreeAndNil(MsgHandler);
  MsgInterface:=nil;
  inherited;
end;


procedure TMainForm.KickTheDrawer;
var
  qryTill: TERPQuery;
  qryTempExec: TERPCommand;
begin
  if not fbSpoolPrintInProgress then begin
    qryTill     := TERPQuery.Create(nil);
    qryTill.Options.FlatBuffers := True;
    qryTill.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTill.ParamCheck := false;
    qryTempExec := TERPCommand.Create(nil);
    qryTempExec.Connection := CommonDbLib.GetSharedMyDacConnection;
    try
      with qryTill do begin
        SQL.Clear;
        SQL.Add('SELECT TillID ' +
          'FROM tblPOSTills ' +
          'WHERE RemoteTillID = ' + IntToStr(iTillID) + ' AND ' +
          'KickRemoteDrawer = "T" AND ' +
          'Active = "T"');
        Open;
        First;
        if not IsEmpty then begin
          foRcptPrn.OpenCashDrawer;
          qryTempExec.SQL.Clear;
          qryTempExec.SQL.Add('UPDATE tblPOSTills SET KickRemoteDrawer = "F" ');
          qryTempExec.Execute;
        end;
      end;
    finally
      FreeAndNil(qryTill);
      FreeAndNil(qryTempExec);
    end;
  end;
end;

function TMainForm.IsOkToBePrintSpooler: boolean;
var
  qryTill: TERPQuery;
begin
  Result := false;
  if not fbSpoolPrintInProgress then begin
    qryTill := TERPQuery.Create(nil);
    qryTill.Options.FlatBuffers := True;
    qryTill.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryTill.ParamCheck := false;
    try
      with qryTill do begin
        SQL.Clear;
        SQL.Add('SELECT TillID ' +
          'FROM tblPOSTills ' +
          'WHERE RemoteTillID = ' + IntToStr(iTillID) + ' AND ' +
          'KickRemoteDrawer = "T" AND ' +
          'PrintRemoteReceipt = "T" AND ' +
          'Active = "T"');
        Open;
        if not IsEmpty then begin
          if CommonLib.MessageDlgXP_Vista('There are Receipts Awaiting to be Printed, '#10#13 +
            'Do you still Wish to be the POS Receipt Printer Server?',
            mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
            Result := true;
          end;
        end else begin
          Result := true;
        end;
      end;
    finally
      FreeAndNil(qryTill);
    end;
  end;
end;

procedure TMainForm.Remove1Click(Sender: TObject);
var
  i: Integer;
  msg: string;
begin
  if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnRemove') <> 1 then begin
    CommonLib.MessageDlgXP_Vista(Format('You don''t have access to %s.',
      [AppEnv.AccessLevels.GetFormDescription('FnRemove')]), mtInformation, [mbOK], 0);
    Exit; // ====>  EXIT
  end;
  case CommonLib.MessageDlgXP_Vista('The Remove Function Back''s Up Current Database Then Removes It From The Server.' +
    #13 + #10 + '' + #13 + #10 + '' + #13 + #10 + 'REMOVE This Company Database ?', mtWarning, [mbYes, mbNo], 0) of
    mrNo:
      Exit;
    mrYes:
      begin
        case CommonLib.MessageDlgXP_Vista('REMOVE This Company Database ?', mtConfirmation, [mbYes, mbNo], 0) of
          mrNo:
            Exit;
          mrYes:
            begin
            end;
          else
            Exit;
        end;
      end;
    else
      Exit;
  end;

  if not RemoveAllConnectionsToDB then
    Exit;

//  if AppEnv.UtilsClient.LockLogon(msg,AppEnv.AppDb.Database, 'Performing a Remove DB') then begin
//    try
      CommonDbLib.GetSharedMyDacConnection.Disconnect; // was used by above function
      try
        for i := 0 to MainForm.ComponentCount - 1 do
          if self.Components[i] is TTimer then begin
            TTimer(self.Components[i]).Enabled := false;
          end else if self.Components[i] is  TCustomForm then begin
            TCustomForm(self.Components[i]).Release;
          end;

        RemovingDB := True;
        Self.Color := clWhite;
        Self.WindowState := wsMinimized;
        Self.WindowState := wsMaximized;
        Application.ProcessMessages;
        Self.Enabled := False;
        Application.ProcessMessages;

        if not frmDatabaseBackup.DBRemove(AppEnv.AppDb.Database,AppEnv.AppDb.UserName,AppEnv.UtilsClient,msg) then begin
          CommonLib.MessageDlgXP_Vista('Remove failed with message: ' + msg, mtWarning, [mbOK], 0);
          RemovingDB := False;
        end
        else begin
          AppEnv.AppDb.Database := '';
          AppEnv.AppDb.Save;
        end;

//        if not AppEnv.UtilsClient.DatabaseRemove(Appenv.AppDb.Server,AppEnv.AppDb.Database,msg) then begin
//          CommonLib.MessageDlgXP_Vista('Remove failed with message: ' + msg, mtWarning, [mbOK], 0);
//          RemovingDB := False;
//        end
//        else begin
//          AppEnv.AppDb.Database := '';
//          AppEnv.AppDb.Save;
//        end;
      finally
        Application.ProcessMessages;
        If RemovingDB then OpenCompanyDbClick(nil);
      end;

//    finally
//      AppEnv.UtilsClient.UnlockLogon;
//    end;
//  end
//  else begin
//    if msg = USERS_IN_SYSTEM_MESSAGE then begin
//      if GetCurrentUserCount > 0 then begin
//        dtmMainGUI.dlgCurrentUsers.Caption := AppEnv.AppDb.Database + ' Remove';
//        dtmMainGUI.dlgCurrentUsers.Color := $00D7F5FF;
//        dtmMainGUI.dlgCurrentUsers.Message := 'The following user(s) must exit the system.';
//        dtmMainGUI.dlgCurrentUsers.Execute;
//      end
//      else begin
//        MessageDlgXP_Vista('Unable to retrieve list of logged on users at this time.', mtInformation, [mbOk], 0);
//      end;
//    end
//    else begin
//      MessageDlgXP_Vista('Unable to Remove Database, Unable to Lock User Logon: ' + msg, mtInformation, [mbOk], 0);
//    end;
//  end;
end;

function TMainForm.DBExists(const DBName: string): boolean;
var
  ls: TStringList;
begin
  ls := TStringList.Create;
  try
    CommonDbLib.GetSharedMyDacConnection.GetDatabaseNames(ls);
    Result := ls.IndexOf(DBName) > -1;
  finally
    FreeAndNil(ls);
  end;
end;


procedure TMainForm.Copy1Click(Sender: TObject);
begin
  Copydb;
end;
procedure TMainForm.Copydb(CopyRO:Boolean =False);
var
  sDBName, sDefault: string;
  i: integer;
  msg: string;
begin
  if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnCopy') <> 1 then begin
    CommonLib.MessageDlgXP_Vista(Format('You don''t have access to %s.',
      [AppEnv.AccessLevels.GetFormDescription('FnCopy')]), mtInformation, [mbOK], 0);
    Exit; // ====>  EXIT
  end;
  i := 0;
  sDefault := CommonDbLib.GetSharedMyDacConnection.Database;
  while DBExists(sDefault) do begin
    Inc(i);
    sDefault := 'CopyOf' + CommonDbLib.GetSharedMyDacConnection.Database + Format('%0.2d', [i]);
  end;

  case CommonLib.MessageDlgXP_Vista('Copy to ' + sDefault + #13 + #10 + '' + #13 + #10 + 'Do You Wish To Rename ?',
    mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
    mrYes:
      begin
        while Empty(sDBName) do begin
          sDBName := InputBox('New Company DB', 'Enter Copy Company Database Name', '');
          if not Empty(sDBName) and DBExists(sDBName) then begin
            case CommonLib.MessageDlgXP_Vista('Database Name Already Exist !', mtWarning, [mbOK, mbCancel], 0) of
              mrCancel:
                Exit;
              mrOk:
                sDBName := '';
            end;
          end else if Empty(sDBName) then begin
            Exit;
          end;
        end;
      end;
    mrNo:
      sDBName := sDefault;
    mrCancel:
      Exit;
  end;
  if not ValidAlphaNumericCharacters(sDBName) then begin
    CommonLib.MessageDlgXP_Vista('No non alphanumeric characters allowed in Database name.', mtWarning, [mbOK], 0);
  end else begin
    if not RemoveAllConnectionsToDB then
      Exit;

//    if AppEnv.UtilsClient.LockLogon(msg,AppEnv.AppDb.Database, 'Performing a Copy DB') then begin
//      try
        self.Enabled:= false;
        try
          if CopyRO then begin
            if not frmDatabaseBackup.DbCopyRO(AppEnv.AppDb.Database,sDBName,AppEnv.AppDb.UserName,AppEnv.UtilsClient,msg) then begin
              CommonLib.MessageDlgXP_Vista('Copy failed with message: ' + msg, mtWarning, [mbOK], 0);
            end;
          end else begin
            if not frmDatabaseBackup.DbCopyRO(AppEnv.AppDb.Database,sDBName,AppEnv.AppDb.UserName,AppEnv.UtilsClient,msg) then begin
              CommonLib.MessageDlgXP_Vista('Copy failed with message: ' + msg, mtWarning, [mbOK], 0);
            end;
          end;

        finally
          self.Enabled:= true;
        end;
  end;
end;

procedure TMainForm.PresenceTimerTimer(Sender: TObject);
var
  ResponsePeriod: integer;
  ResponseTime: TDateTime;
begin
  MainForm.PresenceTimer.Enabled := false;
  try
    try
      if AppEnv.UtilsClient.SendPresence(ResponseTime) then begin
        ResponsePeriod := Trunc(MSecsPerDay * ResponseTime);
        ResponsePeriod := Trunc(Ln(ResponsePeriod) * 12.5);
        if ResponsePeriod > NetworkSpeedResponsePeriod then begin
          if ResponsePeriod > (100 + NetworkSpeedResponsePeriod) then
            SocketSpeed := 0
          else
            SocketSpeed := (100 + NetworkSpeedResponsePeriod) - ResponsePeriod;
        end
        else
          SocketSpeed := 100;
      end;
    except
    end;
  finally
    MainForm.PresenceTimer.Interval := UserPresenceInterval;
    StatusBar.Panels[4].Progress.Position := MemoryUsedPercentage;
    MainForm.PresenceTimer.Enabled := true;
  end;
  Self.Update;
end;

procedure TMainForm.MailFlashTimerTimer(Sender: TObject);
begin
  if ilAlerts.Tag = 2 then begin
    ilAlerts.Tag := 0;
    imAlert.Top  := 3;
  end else begin
    ilAlerts.Tag := 2;
    imAlert.Top  := 1;
  end;
  ilAlerts.GetIcon(ilAlerts.Tag, imAlert.Picture.Icon);
end;

procedure TMainForm.PhoneFlashTimerTimer(Sender: TObject);
begin
  if (imPhone.Tag = 3) or (imPhone.Tag = 4) then begin
    imPhone.Tag := 5;
    imPhone.Top := 1;
  end
  else begin
    imPhone.Tag := 4;
    imPhone.Top := 3;
  end;
  ilAlerts.GetIcon(imPhone.Tag, imPhone.Picture.Icon);
end;


function TMainForm.ignorelogInuseform: boolean;
begin
  REsult := True;
end;

procedure TMainForm.imAlertDblClick(Sender: TObject);
begin
  MailFlashTimer.Enabled := false;
  ilAlerts.Tag := 2;
  ilAlerts.GetIcon(ilAlerts.Tag, imAlert.Picture.Icon);
end;

procedure TMainForm.imPhoneDblClick(Sender: TObject);
begin
  inherited;
  DoCyTrackEvent(TCyTrack.Inst,'OnStatusChange','');

//  PhoneFlashTimer.Enabled := false;
//  imPhone.Tag := 3;
//  ilAlerts.GetIcon(imPhone.Tag, imPhone.Picture.Icon);
end;

procedure TMainForm.pmSubAlertClick(Sender: TObject);
begin
  CommonLib.MessageDlgXP_Vista(TMenuItem(Sender).Caption, mtInformation , [mbOK], 0);
  if Sysutils.SameText('YES', TMenuItem(Sender).Caption) then begin
  end else if Sysutils.SameText('No', TMenuItem(Sender).Caption) then begin
  end else if Sysutils.SameText('Try Again Later', TMenuItem(Sender).Caption) then begin
  end else if Sysutils.SameText('I''ll get back to you', TMenuItem(Sender).Caption) then begin
  end else if Sysutils.SameText('Open ToDo', TMenuItem(Sender).Caption) then begin
  end else if Sysutils.SameText('Remove', TMenuItem(Sender).Caption) then begin
  end;
end;

procedure TMainForm.pmPresentUsersPopup(Sender: TObject);
//var
//  p1, p2, p3: integer;
//  i, empID: integer;
//  cap, dbname: string;
//  qry: TERPQuery;
//  conn: TERPConnection;
//
//  procedure doSorTAdvPopupMenuItems;
//  var
//    i, j: integer;
//    tmpCap: string;
//    tmpTag: integer;
//  begin
//    for i := 0 to pmPresentUsers.Items.Count - 2 do
//      for j := i + 1 to pmPresentUsers.Items.Count - 1 do
//        if FastFuncs.CompareText(pmPresentUsers.Items[i].Caption, pmPresentUsers.Items[j].Caption) > 0 then begin
//          tmpCap := pmPresentUsers.Items[i].Caption;
//          tmpTag := pmPresentUsers.Items[i].Tag;
//          pmPresentUsers.Items[i].Caption := pmPresentUsers.Items[j].Caption;
//          pmPresentUsers.Items[i].Tag := pmPresentUsers.Items[j].Tag;
//          pmPresentUsers.Items[j].Caption := tmpCap;
//          pmPresentUsers.Items[j].Tag := tmpTag;
//        end;
//  end; // doSorTAdvPopupMenuItems
begin



//  PresenceTimer.Enabled := false;
//  conn := nil;
//  qry := TERPQuery.Create(nil);
//  qry.Options.FlatBuffers := True;
//  try
//    { popup item contains eg. (2) ERP - COMPUTER(192.168.0.3)
//      or (2) - COMPUTER(192.168.0.3)
//        (database is not shown if it is this)
//      here we isolate (userid) and database  to replace with username
//      NOTE: popupMenuItem.Tag holds the EmployeeID}
//    for i := 0 to pmPresentUsers.Items.Count - 1 do begin
//      cap := pmPresentUsers.Items[i].Caption;
//      p1 := FastFuncs.PosEx('(', cap);
//      p2 := FastFuncs.PosEx(')', cap);
//      p3 := FastFuncs.PosEx('-', cap);
//      try
//        empID := StrToIntDef(Copy(cap, p1 + 1, p2 - p1 - 1), - 1);
//        if empID > -1 then begin
//          qry.Close;
//          if p3 - p2 < 3 then
//            qry.Connection := CommonDbLib.GetSharedMyDacConnection
//          else begin // we need to access a different database on the server
//            dbname := Copy(cap, p2 + 2, p3 - 2);
//            if not Assigned(conn) then begin
//              conn := TERPConnection.Create(nil);
//              conn.Server := CommonDbLib.GetSharedMyDacConnection.Server;
//              conn.Username := CommonDbLib.GetSharedMyDacConnection.Username;
//              conn.Password := CommonDbLib.GetSharedMyDacConnection.Password;
//              conn.Port     := CommonDbLib.GetSharedMyDacConnection.Port;
//            end;
//            if not Sysutils.SameText(conn.Database, dbname) then begin
//              conn.Database := dbname;
//              conn.Open;
//            end;
//            qry.Connection := conn;
//          end;
//
//          qry.SQL.Text := 'SELECT FirstName, LastName FROM tblEmployees WHERE ' + 'EmployeeID = ' + IntToStr(pmPresentUsers.Items[i].Tag) + ';';
//          qry.Open;
//          if qry.RecordCount = 1 then
//            pmPresentUsers.Items[i].Caption :=
//              Copy(cap, 1, p1 - 1) + qry.FieldByName('FirstName').AsString + ' ' + qry.FieldByName('LastName').AsString + Copy(cap, p2 + 1, 200)
//        end;
//      except
//        on Exception do;
//      end;
//    end;
//    doSorTAdvPopupMenuItems;
//  finally
//    FreeAndNil(qry);
//    FreeAndNil(conn);
//  end;
end;

procedure TMainForm.CopyOldDBTablesToNewDB(const sNewDBName: string; const OldConnection: TERPConnection);
var
  NewConnection: TERPConnection;
  slTableQueries: TERPScript;
  sCurDB: string;
  sWhere: string;

  function CopyTableSQL(const TableName: String; const Where: String=''; ZeroValuefields: String = ''; BlankValuefields: String = '') : String;
  var
    st:TStringlist;
    ctr:Integer;
  begin
    Result :=   '' ;
    if TableName = '' then exit;
    Result := 'TRUNCATE ' + TableName + ';';
    Result := Result +
          'INSERT HIGH_PRIORITY ignore INTO ' + TableName + ' ' +
            'SELECT * FROM `' + sCurDB + '`.'+ TableName + iif(Where <> '' , '  ' + iif(sametext(copy(trim(where), 1, 5), 'WHERE'), where , ' where ' + where), '') + ' ;';
    if BlankValuefields <> '' then begin
      st:= TStringlist.Create;
      try
        st.commatext := BlankValuefields;
        for ctr:= 0 to st.count-1 do result := result +' UPDATE ' + tablename + ' SET ' + st[ctr]+ ' = "";';
      finally
        FreeandNil(St);
      end;
    end;
    if ZeroValuefields <> '' then begin
      st:= TStringlist.Create;
      try
        st.commatext := ZeroValuefields;
        for ctr:= 0 to st.count-1 do result := result +' UPDATE ' + tablename + ' SET ' + st[ctr]+ ' = 0;';
      finally
        FreeandNil(St);
      end;
    end;
  end;
begin
  // Create required objects.
  NewConnection := TERPConnection.Create(nil);
  slTableQueries := TERPScript.Create(nil);
  sCurDB := OldConnection.Database;
  try
    // Setup our queries for copying.
    slTableQueries.SQL.Clear;

    slTableQueries.SQL.Add('UPDATE tblcompanyinformation SET CompanyName = ' + quotedstr(sNewDBName) + ' WHERE CompanyName = ' + quotedstr(sCurDB) + ';');

    if  AppEnv.CompanyPrefs.CopyEmployeeSettings or
        AppEnv.CompanyPrefs.CopyEmployeeAccess or
        AppEnv.CompanyPrefs.Copyclients or
        AppEnv.CompanyPrefs.CopyMarketingContacts then begin
      slTableQueries.SQL.add(CopyTableSQL('tblemployees', 'WHERE Active="T"'));
      slTableQueries.SQL.Add ('UPDATE tblEmployees SET DefaultClassName = (SELECT DefaultClass FROM tblColumnHeadings),');
      slTableQueries.SQL.Add ('DefaultClassID = (SELECT tblClass.ClassID FROM tblClass WHERE tblClass.ClassName = (SELECT DefaultClass FROM tblColumnHeadings));');
      slTableQueries.SQL.add(CopyTableSQL('tblpassword' ,'Where EmployeeID in (Select EmployeeID from  `' + sCurDB + '`.tblEmployees where active ="T")'));
      slTableQueries.SQL.add(CopyTableSQL('tblemployeeformsaccess' ,'Where EmployeeID in (Select EmployeeID from  `' + sCurDB + '`.tblEmployees where active ="T")'));
    end;

    if AppEnv.CompanyPrefs.CopyEmployeeSettings then Begin
      slTableQueries.SQL.add(CopyTableSQL('tblpersonalpreferences' ,'Where EmployeeID in (Select EmployeeID from  `' + sCurDB + '`.tblEmployees where active ="T")'));
    end;

    if AppEnv.CompanyPrefs.CopyCompanySettings then begin
      slTableQueries.SQL.add(CopyTableSQL('tbldbpreferences'));

      slTableQueries.SQL.Add('UPDATE tbldbpreferences cur  '+
            ' INNER JOIN erpnewdb.tbldbpreferences def on cur.Name = def.Name and cur.PrefType = def.PrefType '+
            ' SET cur.FieldValue = def.FieldValue '+
            '  WHERE cur.PrefType = "ptUpdate";');

      slTableQueries.SQL.add(CopyTableSQL('tblcompanyinformation'));
    end;

    if AppEnv.CompanyPrefs.CopyClients or AppEnv.CompanyPrefs.CopyCOA or AppEnv.CompanyPrefs.CopyProducts or AppEnv.CompanyPrefs.CopyOutstandingTxn then Begin
      slTableQueries.SQL.add(CopyTableSQL('tblchartofaccounts', 'WHERE Active ="T" or Required ="T"' ,'Balance' ));
    end;

    if AppEnv.CompanyPrefs.CopyClients or AppEnv.CompanyPrefs.CopyMarketingContacts then begin
      slTableQueries.SQL.add(CopyTableSQL('tbltemplatetype'));
    end;

    if AppEnv.CompanyPrefs.CopyClients then begin
      slTableQueries.SQL.add(CopyTableSQL('tblsimpletypes'));
      slTableQueries.SQL.add(CopyTableSQL('tblshippingaddress'));
      slTableQueries.SQL.add(CopyTableSQL('tblpaymentmethods'));
      slTableQueries.SQL.add(CopyTableSQL('tblbankcodes'));
      slTableQueries.SQL.add(CopyTableSQL('tbltemplates'));
      slTableQueries.SQL.add(CopyTableSQL('tblmanufacture'));
      slTableQueries.SQL.add(CopyTableSQL('tblshippingagent'));
      slTableQueries.SQL.add(CopyTableSQL('tblterms'));
      slTableQueries.SQL.add(CopyTableSQL('tblclienttype'));
      slTableQueries.SQL.add(CopyTableSQL('tblclients', '' , 'APBalance,ARBalance,Balance,CombinedSaleOrderBOID,CombinedPurchaseBOID,CombinedInvoiceBOID'));
      slTableQueries.SQL.add(CopyTableSQL('tblcontacts'));
    end;

    if AppEnv.CompanyPrefs.CopyMarketingContacts then begin
      slTableQueries.SQL.add(CopyTableSQL('tblmarketingcontacts', '' , iif(not(AppEnv.CompanyPrefs.CopyClients) , 'clientID' , '')));
      slTableQueries.SQL.add(CopyTableSQL('tblmarketingcontactcontacts'));
    end;

    if AppEnv.CompanyPrefs.CopyClients or AppEnv.CompanyPrefs.CopyProducts then Begin
      slTableQueries.SQL.add(CopyTableSQL('tblclass', 'Where Active ="T"'  ));
      slTableQueries.SQL.Add('INSERT HIGH_PRIORITY ignore INTO  tblclass ' +
                             'SELECT C.* FROM `erpnewdb`.tblclass C Where C.Active="T";');
      // Parts
      slTableQueries.SQL.add(CopyTableSQL('tblsubtaxcode'));
      slTableQueries.SQL.add(CopyTableSQL('tbltaxcodes'));
      slTableQueries.SQL.add(CopyTableSQL('tbltaxcodelines'));
      slTableQueries.SQL.Add('INSERT HIGH_PRIORITY IGNORE INTO tblsubtaxcode   SELECT * FROM `erpnewdb`.tblsubtaxcode ;');
      slTableQueries.SQL.Add('INSERT HIGH_PRIORITY IGNORE INTO tbltaxcodes     SELECT * FROM `erpnewdb`.tbltaxcodes ;');
      slTableQueries.SQL.Add('INSERT HIGH_PRIORITY IGNORE INTO tbltaxcodelines SELECT * FROM `erpnewdb`.tbltaxcodelines ;');
    End;

    if AppEnv.CompanyPrefs.CopyProducts then begin
      // UOM
      slTableQueries.SQL.add(CopyTableSQL('tblunitsofmeasure', 'where Active ="T"'));
      slTableQueries.SQL.add(CopyTableSQL('tblparts', 'where Active ="T"'));
      // related Products
      slTableQueries.SQL.add(CopyTableSQL('tblrelatedparts', ''));
      slTableQueries.SQL.add('delete from tblrelatedparts where parentid not in (Select partsId from tblparts);'); // if any exists for the inactive products
      slTableQueries.SQL.add('delete from tblrelatedparts where ProductId not in (Select partsId from tblparts);');

      // product formulas
      slTableQueries.SQL.add(CopyTableSQL('tblfeformula'                ));
      slTableQueries.SQL.add(CopyTableSQL('tblfeformulanameorder'       ));
      slTableQueries.SQL.add(CopyTableSQL('tblfeformularelatedproducts' ));
      slTableQueries.SQL.add(CopyTableSQL('tblfeformulatypes'           ));
      slTableQueries.SQL.add(CopyTableSQL('tblfenames'                  ));

      // Product Attributes
      slTableQueries.SQL.add(CopyTableSQL('tblproductattributegroups'   , 'where Active ="T"'));
      slTableQueries.SQL.add(CopyTableSQL('tblproductattributenames'    , 'where Active ="T"'));
      slTableQueries.SQL.add(CopyTableSQL('tblproductattributeproducts' , 'where Active ="T"'));
      slTableQueries.SQL.add(CopyTableSQL('tblproductattributevalues'   , 'where Active ="T"'));

      // Product barcodes
      slTableQueries.SQL.add(CopyTableSQL('tblpartbarcodes', 'WHERE Active ="T"'));

      // QtyLines
      slTableQueries.SQL.Add('TRUNCATE tblProductclasses;');
      slTableQueries.SQL.Add('INSERT HIGH_PRIORITY INTO tblProductclasses ' +
        'SELECT tblProductclasses.* FROM `' + sCurDB + '`.tblProductclasses ' +
        'INNER JOIN `' + sCurDB + '`.tblclass USING(ClassID) INNER JOIN `' + sCurDB +
        '`.tblparts ON tblparts.PARTSID=tblProductclasses.ProductID ' +
        'Where tblparts.Active="T" AND tblclass.Active="T";');
      slTableQueries.SQL.add(CopyTableSQL('tblProcessStep'   ));
      slTableQueries.SQL.add(CopyTableSQL('tblemployeeprocesssteps'   ));

      slTableQueries.SQL.add(CopyTableSQL('tblProcResourceProcess'   ));

      slTableQueries.SQL.add(CopyTableSQL('tblProcResource'   ));
      slTableQueries.SQL.add(CopyTableSQL('tblprocresourcedetails'   ));
      slTableQueries.SQL.add(CopyTableSQL('tblprocresourcedays'   ));
      slTableQueries.SQL.add(CopyTableSQL('tblprocresourceProducts'   ));
      slTableQueries.SQL.add('update tblprocresourceProducts Set ResourceDate = curdate();');
      slTableQueries.SQL.add('update tblprocresourceProducts Set NoOfResources =0;');
      slTableQueries.SQL.add('update tblprocresourceProducts RP '+
                             ' inner join tblprocresourcedetails RD on RP.ProcresourcedetailID = RD.ID  '+
                             ' Set RP.NoOfResources =RD.NoOfResources where RP.Seqno = 1;');

      slTableQueries.SQL.Add(CopyTableSQL('tblProcTree' , 'where mastertype = "mtProduct"'  ));
      slTableQueries.SQL.Add(CopyTableSQL('tblProcessPart' , 'where ProctreeId in (Select ProctreeId from `' + sCurDB + '`.tblproctree where mastertype = "mtproduct")'  ));
      slTableQueries.SQL.Add('UPDATE tblProductclasses SET ReOrderPoint= 0, PreferredLevel= 0, ReOrderAmount= 0, LastAdj= 0;');
    end;

    if devmode then begin
      slTableQueries.SQL.Add('INSERT IGNORE INTO `tblcustomfilters` '+
                    '(`FilterName`, `ReportName`, `FilterStatement`, `Active`, `AllUsers`, `UserID`, `DefaultFilter`)  '+
                    'VALUES ("User Products", "TProductListGUI", "PartsID>34", "T", "T", 1, "T");');
      slTableQueries.SQL.Add('INSERT IGNORE INTO `tblcustomfilters` '+
                    '(`FilterName`, `ReportName`, `FilterStatement`, `Active`, `AllUsers`, `UserID`, `DefaultFilter`)  '+
                    'VALUES ("User Products", "TProductListExpressGUI", "PartsID>34", "T", "T", 1, "T");');
      slTableQueries.SQL.Add('update tblcompanyinformation Set CompanyName = ' +Quotedstr(sNewDBName) +';');
    end;

    // Wang
    slTableQueries.SQL.Add('UPDATE tbldbpreferences cur  '+
          ' INNER JOIN ' + sCurDB + '.tbldbpreferences def on cur.Name=def.Name and cur.PrefType=def.PrefType ' +
          ' SET cur.FieldValue = def.FieldValue '+
          '  WHERE cur.PrefType="ptCompany" AND (cur.Name="ClosingDate" OR cur.Name="ClosingDateAP");');


    // If there is no functions to perform then exit.
    if slTableQueries.SQL.Count = 0 then
      Exit;

    NewConnection.Username := OldConnection.Username;
    NewConnection.Server   := OldConnection.Server;
    NewConnection.Password := OldConnection.Password;
    NewConnection.Database := sNewDBName;
    NewConnection.Port     := OldConnection.Port;
    // Establish Connection to New Database.
    NewConnection.Connect;

    if not OldConnection.Connected then
      OldConnection.Connect;

    Application.ProcessMessages;
    slTableQueries.Connection := NewConnection;
    slTableQueries.Execute;
    NewConnection.Disconnect;

  finally
    // Release our used objects.
    if Assigned(NewConnection) then
      FreeAndNil(NewConnection);

    if Assigned(slTableQueries) then
      FreeAndNil(slTableQueries);
  end;
end;

Function TMainForm.makeToolbarItem(AOwner:TComponent;nameprefix:String; namesuffix:String ):TERPMainSwitchButton;
begin
  if AOwner.findcomponent(makename(nameprefix +'_' +namesuffix)) <> nil then begin
    REsult := nil;
    Exit;
  end;
  REsult:= TERPMainSwitchButton.Create(AOwner);
  Result.UseLargeIcon := False;
  Result.Appearance.BorderColor := Self.color;
  Result.Appearance.BorderColorHot := Self.color;
  Result.Appearance.BorderColorDown := Self.color;
  Result.Appearance.BorderColorChecked := Self.color;
  Result.Appearance.BorderColorDisabled := Self.color;
  Result.Width := 85;
  Result.name := MakeName(AOwner , nameprefix +'_' +namesuffix(* 'TB'*));
end;

procedure TMainForm.AddToolbarButton(const ActionName: string);
var
  AI: TActionHelperItem;
  TB: TERPMainSwitchButton;
  ButtonCaption: string;

  {var for packages}
  i: integer;
  SelAddinInfo: TAddinPackageInfo;
  {declare for RTTI method}
var
  GetItem: function (const ActionName: string): TActionHelperItem of object;
begin
try
  AI := dtmMainGUI.ActionHelper.ItemByName[ActionName];

  if Assigned(AI) then begin
    if not Empty(TDNMAction(AI.Action).Description) then
      ButtonCaption := Trim(TDNMAction(AI.Action).Description)
    else
      ButtonCaption := Trim(TDNMAction(AI.Action).Caption);
    if char_length(ButtonCaption) > MAX_TOOLBUTTON_CAPTION then
      Setlength(ButtonCaption, MAX_TOOLBUTTON_CAPTION);

    TB          := makeToolbarItem(Self , 'Mainmenutoolbarbtn', ButtonCaption);
    if TB <> nil then begin
      TB.Parent   := MainToolBar;
      TB.dnmAction   := AI.Action;



      TB.Caption := ButtonCaption;
      TB.Enabled  := true;
      TB.ShowHint := true;
      TB.Hint     := AI.Action.Hint;
      TB.Visible  := true;
    end;
  end else begin
    //now load from any packages
    for i := 0 to AddinPackageList.Count - 1 do begin
      SelAddinInfo := TAddinPackageInfo(AddinPackageList[i]);

      if Assigned(SelAddinInfo.GuiDataModule) then begin
        TMethod(GetItem).code := SelAddinInfo.GuiDataModule.MethodAddress('GetItem');     {call a method in package}
        TMethod(GetItem).Data := SelAddinInfo.GuiDataModule;

        if Assigned(GetItem) then begin
          AI := GetItem(ActionName);
          if Assigned(AI) then begin
            if not Empty(TDNMAction(AI.Action).Description) then
              ButtonCaption := Trim(TDNMAction(AI.Action).Description)
            else
              ButtonCaption := Trim(TDNMAction(AI.Action).Caption);

            if char_length(ButtonCaption) > MAX_TOOLBUTTON_CAPTION then
              Setlength(ButtonCaption, MAX_TOOLBUTTON_CAPTION);
            TB := makeToolbarItem(Self , 'Mainmenutoolbarbtn' , ButtonCaption);
            if TB <> nil then begin
              TB.Parent := MainToolBar;
              TB.DnMAction := AI.Action;

              TB.Caption := ButtonCaption;
  //              TB.Caption := Trim(AI.ShortDesc);
              TB.Enabled := true;
              TB.ShowHint := true;
              TB.Hint := AI.Action.Hint;
              TB.Visible := true;
            end;
            Break;  {Assume the first actionname found can be the only one}
          end;
        end;
      end else begin
        raise Exception.Create('Action "%s" not found in Action Helper object');
      end;
    end;
  end;
Except
  //kill the exception
end;
end;

procedure TMainForm.CleanMainToolbar;
begin
  while MainToolBar.ButtonCount > 0 do
    MainToolBar.Buttons[0].Free;
end;

procedure TMainForm.DisableActionsByEmployee(const DM: TDataModule);
var
  AccessLevel, I: integer;
  ActionName, AClassName: string;
  AI: TActionHelperItem;
  ActionList: TActionList;
  {var for packages}
var
  GetItem: function (const ActionName: string): TActionHelperItem of object;
begin
  // pre-condition: all actions have to be loaded and associated with class names

  // this will disable all actions for which an employee does not have access to
  ActionList := TActionList(DM.FindComponent('ActionList'));
  if AppEnv.Employee.EmployeeID <> 0 then
    if ActionList.ActionCount > 0 then
      for I := 0 to ActionList.ActionCount - 1 do begin
        ActionName := ActionList.Actions[I].Name;

        if Assigned(DM) then begin
          TMethod(GetItem).code := DM.MethodAddress('GetItem');     {call a method in package}
          TMethod(GetItem).Data := DM;
          if Assigned(GetItem) then begin
            AI := GetItem(ActionName);
            AClassName := AI.ActionClassName;
          end;
          if AClassName <> '' then begin
            AccessLevel := AppEnv.AccessLevels.GetEmployeeAccessLevel(AClassName, AppEnv.Employee.EmployeeID);

            if AccessLevel = 6 then begin
              // disable the action
              TAction(ActionList.Actions[I]).Enabled := false;
              //TAction(ActionList.Actions[i]).Visible := false;
            end;
          end;
        end;
      end;
end;

Procedure TMainForm.LogSubmenu(mnu:TMenuItem; intend :Integer);
var
  ctr:Integer;
begin
    if mnu.Count >0 then
      for ctr:= 0 to mnu.Count-1 do
          logsubmenu(mnu.Items[ctr] , intend +1);
end;

procedure TMainForm.AddinPackagesMenu;
var
  SelAddinInfo: TAddinPackageInfo;
  i: integer;
begin
  Self.Menu := nil;
  if Assigned(dtmMainGUI) then
    FreeAndNil(dtmMainGUI);
  dtmMainGUI := TdtmMainGUI.Create(Application);
  try
    dtmMainGUI.AssociateClassNamesWithActions(dtmMainGUI.ActionList);
  Except
    // ignore error
  end;

  if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnShowDropDownMenu') = 1 then
    Self.Menu := dtmMainGUI.MainMenu
  else
    exit;

  if Assigned(AddInPackageList) then begin
    for i := 0 to AddinPackageList.Count - 1 do begin
      DoProgressdialogProgress('ERP Mainswitch Page - '+inttostr(i+1)+' of ' + inttostr(AddinPackageList.Count));
      SelAddinInfo := TAddinPackageInfo(AddinPackageList[i]);
      if Assigned(SelAddinInfo.GuiDataModule) then begin
        DisableActionsByEmployee(SelAddinInfo.GuiDataModule);
        if SelAddinInfo.PackageType = ptDynamicDLL then begin
          MergeMenus(TAdvMainMenu(SelAddinInfo.GuiDataModule.FindComponent('MainMenu')), TAdvMainMenu(Self.Menu), dtmMainGUI.ActionList);
        end
        else begin
          AppendMenu(TAdvMainMenu(SelAddinInfo.GuiDataModule.FindComponent('MainMenu')), TAdvMainMenu(Self.Menu));
        end;
        {merge the package menu onto the Applications menu}
        RemoveImageFromMenu(SelAddinInfo.GuiDataModule, TAdvMainMenu(SelAddinInfo.GuiDataModule.FindComponent('MainMenu')));
      end;
    end;
    //Logmainmenu;
  end;
end;

procedure TMainForm.ReloadToolbarButtons;
var
  MCR: TMenuCustomiseRec;
  PC: TPageCollection;
  List: TStrings;
  I: integer;
begin
  //MainToolBar.Images := dtmMainGUI.ImageListSmlIcons;

  MCR.PrefGroup := PREF_GROUP_MAIN;
  MCR.PrefName := PREF_NAME_TOOLBAR_MENU;
  MCR.PackageID := 0;
  MCR.UserID := AppEnv.Employee.EmployeeID;

  PC := TPageCollection.Create;
  try
    if not LoadPageConfigData(PC, MCR) then
      GetToolbarDefaultPreferences(PC);

    CleanMainToolbar;

    List := TStringList.Create;
    try
      try
        List.CommaText := PC.PageByName[PAGE_NAME_TOOLBAR].ButtonList;
      Except
        // kill the exception
      end;
      if List.Count > 0 then
        for I := List.Count - 1 downto 0 do
          AddToolbarButton(List[I]);
    finally
      FreeAndNil(List);
    end;
  finally
    FreeAndNil(PC);
  end;
end;

procedure TMainForm.HandleOnIdle(Sender: TObject; var Done: boolean);
var
  Index: integer;
begin
  //
  // Added this Application.OnIdle handler to try to resolve an issue caused
  // by a list index out of bounds error in TApplication.DoaActionIdle. The
  // 'for' loop was replaced by a 'while' loop.
  //

  if Assigned(FStoredOnIdle) then
    FStoredOnIdle(Sender, Done);

  Index := 0;

  while Index < Screen.CustomFormCount do begin
    with Screen.CustomForms[Index] do begin
      if HandleAllocated and IsWindowVisible(Handle) and
        IsWindowEnabled(Handle) then begin
        if not (csDesigning in Screen.CustomForms[Index].ComponentState) and not (csLoading in Screen.CustomForms[Index].ComponentState) then
          TBaseForm(Screen.CustomForms[Index]).CallUpdateActions;
      end;
    end;

    Inc(Index);
  end;

  if not ((GetCurrentThreadID = MainThreadID) and CheckSynchronize) then
    WaitMessage;

  Done := false;
end;

procedure TMainForm.TerminateApp;
var
  I: integer;

  procedure KillProcess(hWindowHandle: HWND);
  var
    hprocessID: integer;
    processHandle: THandle;
    DWResult: DWORD;
  begin
    SendMessageTimeout(hWindowHandle, WM_CLOSE, 0, 0, SMTO_ABORTIFHUNG or SMTO_NORMAL, 5000, DWResult);
    if isWindow(hWindowHandle) then begin
      GetWindowThreadProcessID(hWindowHandle, @hprocessID);
      if hprocessID <> 0 then begin
        processHandle := OpenProcess(PROCESS_TERMINATE or PROCESS_QUERY_INFORMATION, false, hprocessID);
        if processHandle <> 0 then begin
          TerminateProcess(processHandle, 0);
          CloseHandle(ProcessHandle);
        end;
      end;
    end;
  end;

begin
  IsTerminateApp := True;
  try
    try
      {$IFDEF EXCEPTIONAL_MAGIC}
      DisableExceptionalMagic;
      {$ENDIF}
      for i := 0 to self.ComponentCount - 1 do
        if self.Components[i] is TTimer then begin
          TTimer(self.Components[i]).Enabled := false;
        end;
      Application.ProcessMessages;
      for I := MDIChildCount - 1 downto 0 do
        MDIChildren[I].Release;

      while MDIChildCount <> 0 do
        Application.ProcessMessages;

      Application.ProcessMessages;
      Application.Terminate;
    except
      {Silent}
    end;
  finally
    If RestartApp then
      ExecNewProcess;
    PostMessage(Self.Handle, WM_QUIT, 0, 0);
    KillProcess(Self.Handle);
  end;
end;

procedure TMainForm.TimerMsg(const Value: String; Secondstoshow: Integer=5; msgColor:TColor = clred);
begin
  TimerMsg(lblMsg , Value ,SecondsToshow, msgColor);
end;

Function TMainForm.InitcompanyDefaults:Boolean;
var
   frmDefaults : TfmDefaults;
   s:string;
   fUserLock: TUserLock;
begin
  result := True;
  //if devmode then exit;
  if Appenv.CompanyPrefs.CompanyDefaultsSelected then exit;

  frmDefaults := TfmDefaults.Create(Self);
  with frmDefaults do
  try
    fUserLock := TUserLock.Create(self);
    try
      fuserlock.Enabled:= True;
      if not(fuserlock.Lock('tblcolumnheadings' , 0 , 'Company Defaults')) then begin
          s := 'Unable to start ERP as the Company Defaults are not set.' +NL+NL+
                'Currently the User "' + fuserlock.LockInfo.Username + '" is setting the Company Defaults since: ' + FormatDateTime('dd/mm hh:nn:ss', fuserlock.LockInfo.TimeLocked);


          MessageDlgXP_vista(s, mtWarning, [mbOK], 0);
          frmDefaults := nil;
          MainForm.TerminateApp;
          Result := False;
          Exit;
      end;
      try
        if ShowModal <> mrOk then begin
            Release;
            frmDefaults := nil;
            MainForm.TerminateApp;
            Result := False;
            Exit;
        end else begin
            Result:= True;
        end;
      finally
         fuserlock.unLock('tblcolumnheadings' , 0 , 'Company Defaults');
      end;
    finally
      Freeandnil(fuserlock);
    end;
  finally
        if Assigned(frmDefaults) then begin
          frmDefaults.Release;
          FreeandNil(frmDefaults);
        end;
  end;
end;

procedure TMainForm.InterceptMessages(var Msg: TMsg; var Handled: boolean);
var
  Index: integer;
//  Bitmap: TBitmap;
begin
  if (Msg.message = WM_SYSCHAR) and (Chr(Msg.wParam) = '`') then begin
//    if not Assigned(FFormSwitch) then begin
//      Bitmap := TBitmap.Create;
//      FFormSwitch := TFormSwitchObj.Create;
//
//      try
//        for Index := 0 to Application.MainForm.MDIChildCount - 1 do begin
//          Bitmap.Width := 0;
//          Bitmap.Height := 0;
//
//          if Sysutils.SameText(Application.MainForm.MDIChildren[Index].Name, 'MainSwitch2') then begin
//            Bitmap.LoadFromResourceName(HInstance, 'P1');
//            FFormSwitch.AddForm(MainSwitch2, Bitmap);
//          end else begin
//            Bitmap.Assign(TBaseForm(Application.MainForm.MDIChildren[Index]).ActionBitmap);
//
//            if Bitmap.Empty then
//              Bitmap.LoadFromResourceName(HInstance, 'P1');
//
//            FFormSwitch.AddForm(Application.MainForm.MDIChildren[Index], Bitmap);
//          end;
//        end;
//
//        FFormSwitch.ShowFormList;
//      finally
//        FreeAndNil(Bitmap);
//      end;
//    end;
//
//    FAltKeyDown := true;
//    Handled     := true;
  end else if FAltKeyDown and (Msg.message = WM_SYSKEYDOWN) and
    (Chr(MapVirtualKey(Msg.wParam, 2)) = '`') then begin
    if Assigned(FFormSwitch) then begin
      for Index := 1 to (Msg.lParam and $F) do
        FFormSwitch.NextForm;
    end;

    Handled := true;
  end else if FAltKeyDown and (GetKeyState(VK_MENU) >= 0) then begin
    FAltKeyDown := false;
    Application.ProcessMessages;
    if Assigned(FFormSwitch) then begin
      Try
        Try
          Application.ProcessMessages;
          FFormSwitch.ActivateSelected;
        except
        end;
      Finally
        FreeAndNil(FFormSwitch);
      end;
    end;

    Handled := true;
  end else if FAltKeyDown and (Msg.message = WM_LBUTTONDOWN) then begin
    FAltKeyDown := false;
    FreeAndNil(FFormSwitch);
  end;
  if Assigned(FStoredOnMessage) then
    FStoredOnMessage(Msg, Handled);
end;

function TMainForm.GetTaskBarHeight: integer;
var
  hTaskBarWindow: HWnd;
  Rect: TRect;
  //  Width : Integer;
  Height: integer;
begin
  hTaskBarWindow := FindWindow('Shell_TrayWnd', nil);
  GetWindowRect(hTaskBarWindow, Rect);
  Height := Rect.Bottom - Rect.Top;
  Result := Height;
end;

procedure TMainForm.GlobalEventHandler(const Sender: TObject;
  const Event: string; const Data: Pointer);
begin
  if sameText(Event , GEVENT_AnyActionExecuting)  then begin
//    Disableform;
    MainToolBar.Enabled:= false;
  end else if sameText(Event , GEVENT_AnyActionExecuted)  then begin
//    Enableform;
    MainToolBar.Enabled:= true;
  end else if sameText(Event , GEVENT_MESSAGEDLGXP_VISTA)  then begin
    try
      TMessageDlgXP_Vista(Data).DoCallMessageDlgXP_Vista;
      TMessageDlgXP_Vista(Data).Free;
    Except
      on E:Exception do begin
        MessageDlgXP_Vista(e.message, mtWarning, [mbOK], 0);
      end;
    end;
  end;
end;

procedure TMainForm.ShowActiveWindowPopup(Sender: TObject; x: integer);
var
  defaulty: integer;
var
  frmActiveWindows: TfrmActiveWindows;
begin
  frmActiveWindows := TfrmActiveWindows(FindExistingcomponent('TfrmActiveWindows'));
  if frmActiveWindows.lbActiveWindows.Items.Count > 0 then begin
    if frmActiveWindows.Visible = false then begin
      defaulty := Screen.Height - frmActiveWindows.Height - GetTaskBarHeight;
      if frmActiveWindows.Top = defaulty then begin{form has been moved off status bar}
        frmActiveWindows.Top := Screen.Height - frmActiveWindows.Height - GetTaskBarHeight;
        frmActiveWindows.Left := x;
      end;
    end;
    if (fsShowing in frmActiveWindows.formState) or
    (fsVisible in frmActiveWindows.formState) then Exit;
    frmActiveWindows.Show;
    frmActiveWindows.BringToFront;
  end;
end;

procedure TMainForm.StartErpApi;
var
  MsgOption :Word;
begin
  MsgOption := mrOk;
  try
  if AppEnv.CompanyPrefs.ErpApiEnabled then begin
    ErpApi.HttpPort := AppEnv.CompanyPrefs.ErpApiPort;
    try
      ErpApi.Active := true;
    except
      on ex : exception do begin
        if Pos('Could not bind socket',ex.Message) > 0 then
          MsgOption := CommonLib.MessageDlgXP_Vista('Could not enable the Erp Link Api.' + #13#10 + #13#10 +
          'The Port you have selected (in Preferences > EDI and Integration > ERP Link / API) is in use by some other program on this computer, please select a different port.',mtconfirmation , [mbok], 0 , nil, '', '', false, nil, 'Open Preference')
        else
          MsgOption := CommonLib.MessageDlgXP_Vista('Could not enable the Erp Link Api.' + #13#10 + #13#10 +
            'The Port you have selected (in Preferences > EDI and Integration > ERP Link / API) may be in use by some other program on this computer, please try a different port.',mtconfirmation , [mbok], 0 , nil, '', '', false, nil, 'Open Preference');
        ErpAPI.Active := false;
      end;
    end;
  end;
  finally
    if MsgOption = 100 then
      OpenPrefform('EDI and Integration' ,  'edtErpApiPort', 0 , True, 'HTTP Port' , '' );
  end;
end;

procedure TMainForm.StatusBarMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  PnlLeft: integer;
begin
  PnlLeft :=
    StatusBar.Panels[0].Width + StatusBar.Panels[1].Width +
    StatusBar.Panels[2].Width + StatusBar.Panels[3].Width +
    StatusBar.Panels[4].Width + StatusBar.Panels[5].Width +
    StatusBar.Panels[6].Width;
  if PtInRect(Rect(PnlLeft,0,PnlLeft + StatusBar.Panels[7].Width, StatusBar.Height),Point(X,Y)) then begin
    { don't do it if over panel 7 }
  end
  else begin
    if (AppEnv.Employee.ActiveWindow = 2) and (Button = mbLeft) then begin
      MainSwitch2.tmrActiveWindowsTimer(Sender);
      ShowActiveWindowPopup(Sender, X);
    end;
  end;
end;

procedure TMainForm.StatusBarMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  PnlLeft: integer;
begin
  PnlLeft :=
    StatusBar.Panels[0].Width + StatusBar.Panels[1].Width +
    StatusBar.Panels[2].Width + StatusBar.Panels[3].Width +
    StatusBar.Panels[4].Width + StatusBar.Panels[5].Width +
    StatusBar.Panels[6].Width;
  if PtInRect(Rect(PnlLeft,0,PnlLeft + StatusBar.Panels[7].Width, StatusBar.Height),Point(X,Y)) then begin
    { don't do it if over panel 7 }
  end
  else begin
    if AppEnv.Employee.ActiveWindow = 1 then
      ShowActiveWindowPopup(Sender, X);
  end;
end;

function TMainForm.getformDescifshown(const FormName:String):STring;
var
  iFormCount: integer;
  FormDescStr:String;
  oform :TForm;
begin
    Try
    for iFormCount := 0 to MDIChildCount - 1 do
        if MDIChildren[iFormCount].ClassName = formname then begin
            if FastFuncs.PosEx('- (' , Tform(MDIChildren[iFormCount]).caption) <> 0 then
                FormDescStr := Copy(TForm(MDIChildren[iFormCount]).Caption , 1 , FastFuncs.PosEx('- (' , Tform(MDIChildren[iFormCount]).caption)-1)
            else FormDescStr :=TForm(MDIChildren[iFormCount]).Caption; //ignoreaccesslevel forms caption
            Exit;
        end;
    if FormDescStr = '' then begin
        oForm := TForm(FindExistingComponent(formname));
        if oForm <> nil then if oForm.Visible then begin
            if FastFuncs.PosEx('- (' , oform.caption) <> 0 then
                FormDescStr := Copy(oForm.Caption , 1 , FastFuncs.PosEx('- (' , oForm.caption)-1)
            else FormDescStr :=oForm.Caption;
            Exit;
        end;
    end;
    Finally
        if FormDescStr = '' then FormDescStr := formName;
        if FormDescStr = 'TMainSwitch2' then FormDescStr := 'Main Switch';
        REsult := FormDescStr;
    end;
 end;

procedure TMainForm.SetShowworkflowStatus(const Value: Boolean);
begin
  if not(Value)  then StatusBar.panels[6].Width := 0 else StatusBar.panels[6].Width := 200;
end;

procedure TMainForm.SetSocketSpeed(const Value: integer);
begin
  if Value <> FSocketSpeed then begin
    FSocketSpeed := Value;
    StatusBar.Panels[3].Progress.Position := FSocketSpeed
  end;
end;

procedure TMainForm.CommandLineFunctionsTimerTimer(Sender: TObject);
begin
  CommandLineFunctionsTimer.Enabled := False;
  If Assigned(CommandLineFunctions) then CommandLineFunctions.ExecAfterLoginCmdLineParams;
end;

procedure TMainForm.lblRegionMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  StatusBarMouseDown(StatusBar,Button,Shift,X,Y);
end;

procedure TMainForm.lblRegionMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  StatusBarMouseMove(StatusBar,Shift,X,Y);
end;

procedure TMainForm.lblUserDblClick(Sender: TObject);
begin
  inherited;
  if devmode then dtmMainGUI.Maximiseform(nil);
end;

procedure TMainForm.tmrApplicationStatusTimer(Sender: TObject);
begin
  if AppEnv.AppDb.Connection.Connected then begin
    Inc(IdleCounter);
    if AppEnv.CompanyPrefs.LogoutWhenIdle then begin
      if (System.Round(AppEnv.CompanyPrefs.SessionTime) > 0) and (IdleCounter >= System.Round(AppEnv.CompanyPrefs.SessionTime)) then
        TerminateApp;
    end;
  end;
end;

procedure TMainForm.SetRegionCaption(MsgObj: TMsgObj);
begin
  StatusBar.Panels[8].text := MsgObj.StrValue;
  FreeAndNil(MsgObj);
end;

function TMainForm.GetPanelPos(const PanelIndex: Integer): TRect;
var
  Index: Integer;
begin
  Result := Rect(0, 0, 0, 0);

  for Index := 0 to PanelIndex - 1 do
    Result.Left := Result.Left + StatusBar.Panels[Index].Width;

  Result.Top := 0;
  Result.Bottom := StatusBar.Height;

  if PanelIndex = StatusBar.Panels.Count - 1 then
    Result.Right := StatusBar.Width
  else
    Result.Right := Result.Left + StatusBar.Panels[PanelIndex].Width;
end;

procedure TMainForm.StatusBarPanelDblClick(Sender: TObject;
  PanelIndex: Integer);
begin
  inherited;
  if PanelIndex = 7 then
    OpenERPListForm('TToDoListGUI');
end;

procedure TMainForm.StatusBarPanelRightClick(Sender: TObject;  PanelIndex: Integer);
begin
 If (PanelIndex=2) then pmPresentUsers.PopupAtCursor;
end;

procedure TMainForm.AdvOfficeHint1BeforeShowHint(Sender: TObject;
  AControl: TControl; AHintInfo: TAdvHintInfo; var UseOfficeHint: Boolean);
begin
  Application.HintHidePause := 10000;
end;

procedure TMainForm.SetUSerLbl;
begin
  inherited;
  if assigned(MainSwitch2) then   lblUser.Font.Color := MainSwitch2.color
  else   lblUser.Font.Color := self.color;

end;


procedure TMainForm.SetNewCompanyDefaultValues(const sNewDBName: string;
  const OldConnection: TERPConnection);
var
  NewConnection: TERPConnection;
  qry: TERPQuery;
//  script: TERPScript;
//  PurchaseTaxcodeDefault, SalesTaxcodeDefault: string;
  newRegion: string;
//  ForiegnExCode: string;
  InitialiseAdminOnlyAccess, UpdateAccountsTaxCodes: boolean;
begin
  NewConnection := TERPConnection.Create(nil);
  qry:= TERPQuery.Create(nil);
  try
    if not OldConnection.Connected then
      OldConnection.Connect;
    NewConnection.Username := OldConnection.Username;
    NewConnection.Server   := OldConnection.Server;
    NewConnection.Password := OldConnection.Password;
    NewConnection.Database := sNewDBName;
    NewConnection.Port     := OldConnection.Port;
    NewConnection.Connect;
    qry.Connection:= NewConnection;
    qry.SQL.Text:= 'select FieldValue from tbldbpreferences where name = "CompanyRegion"';
    qry.Open;
    newRegion:= qry.FieldByName('FieldValue').AsString;
    qry.Close;



    InitialiseAdminOnlyAccess :=
      (not AppEnv.CompanyPrefs.CopyDataToNewDB) or (not AppEnv.CompanyPrefs.CopyEmployeeAccess);

    UpdateAccountsTaxCodes := false;
    if not SameText(NewRegion, 'Australia') then begin
      UpdateAccountsTaxCodes := true;
      if AppEnv.CompanyPrefs.CopyDataToNewDB and (NewRegion = appEnv.CompanyPrefs.CompanyRegion ) AND (AppEnv.CompanyPrefs.CopyCOA or AppEnv.CompanyPrefs.CopyProducts) then
        UpdateAccountsTaxCodes := false;
    end;

    TNewDbUtils.SetNewCompanyDefaultValues(sNewDBName,newRegion,InitialiseAdminOnlyAccess, UpdateAccountsTaxCodes, NewConnection,nil);

//    qry.Connection:= NewConnection;
//
//    qry.SQL.Text:=
//      'select ro.TaxCodePurchaseInc from tblregionaloptions ro ' +
//      'where ro.Region = (select p.fieldvalue from tbldbpreferences p ' +
//      'where p.name = "CompanyRegion")';
//    qry.Open;
//    PurchaseTaxcodeDefault:= qry.FieldByName('TaxCodePurchaseInc').AsString;
//
//    qry.Close;
//    qry.SQL.Text:=
//      'select ro.TaxCodeSalesInc from tblregionaloptions ro ' +
//      'where ro.Region = (select p.fieldvalue from tbldbpreferences p ' +
//      'where p.name = "CompanyRegion")';
//    qry.Open;
//    SalesTaxcodeDefault:= qry.FieldByName('TaxCodeSalesInc').AsString;
//
//    qry.Close;
//    qry.SQL.Text:= 'select * from tbldbpreferences where name = ' +
//      QuotedStr('DefaultPurchaseTaxCode');
//    qry.Open;
//    if qry.IsEmpty then begin
//      qry.Insert;
//      qry.FieldByName('PrefType').AsString:= 'ptCompany';
//      qry.FieldByName('Name').AsString:= 'DefaultPurchaseTaxCode';
//      qry.FieldByName('FieldType').AsString:= 'ftString';
//      qry.FieldByName('FieldSize').AsInteger:= 100;
//    end
//    else
//      qry.Edit;
//    qry.FieldByName('FieldValue').AsString:= PurchaseTaxcodeDefault;
//    qry.Post;
//
//    qry.Close;
//    qry.SQL.Text:= 'select * from tbldbpreferences where name = ' +
//      QuotedStr('DefaultSalesTaxCode');
//    qry.Open;
//    if qry.IsEmpty then begin
//      qry.Insert;
//      qry.FieldByName('PrefType').AsString:= 'ptCompany';
//      qry.FieldByName('Name').AsString:= 'DefaultSalesTaxCode';
//      qry.FieldByName('FieldType').AsString:= 'ftString';
//      qry.FieldByName('FieldSize').AsInteger:= 100;
//    end
//    else
//      qry.Edit;
//    qry.FieldByName('FieldValue').AsString:= SalesTaxcodeDefault;
//    qry.Post;
//
//    qry.Close;
//
//    qry.SQL.Text:=
//      'select ro.ForeignExDefault from tblregionaloptions ro ' +
//      'where ro.Region = (select p.fieldvalue from tbldbpreferences p ' +
//      'where p.name = "CompanyRegion")';
//    qry.Open;
//
//    ForiegnExCode := qry.FieldByName('ForeignExDefault').AsString;
//
//    qry.Close;
//
//
//    script:= TERPScript.Create(nil);
//    try
//      script.Connection:= NewConnection;
//      { now update the products with correct tax codes for new region }
//
//      script.SQL.Add(SLNameUpdateSQL(newRegion, ''));
//
//      script.SQL.Add('update tblcurrencyconversion set Active = "F", BuyRate = 0, SellRate = 0;');
//      script.SQL.Add('update tblcurrencyconversion set Active = "T", BuyRate = 1, SellRate = 1 ' + ' where Code = ' + QuotedStr(ForiegnExCode)+';');
//      script.SQL.Add('insert ignore into tblproductclasses '+
//                      ' (ProductId, ProductName, Classid, Classname)  '+
//                      ' select P.PARTSID, P.PARTNAME , C.ClassID, C.ClassName  '+
//                      ' from tblparts P, tblclass C  '+
//                      ' where C.ClassName in (Select DefaultClass from tblcolumnheadings);');
//      script.Execute;
//
//
//      if (not AppEnv.CompanyPrefs.CopyDataToNewDB) or (not AppEnv.CompanyPrefs.CopyEmployeeAccess) then begin
//        { Employee Admin has full access }
//        script.SQL.Clear;
//        script.SQL.Add('truncate tblemployeeformsaccess;');
//        script.SQL.Add('insert into tblemployeeformsaccess (EmployeeID , FormID , access) '+
//                  ' Select (Select EmployeeId from tblemployees where  tblemployees.FirstName ="Admin") ,  '+
//                  ' formID , 1  from tblForms where  tblForms.AccessLevels ="T";');
//        script.Execute;
//      end;
//
//      if not SameText(newRegion, 'Australia') then begin
//        if (newRegion = appEnv.CompanyPrefs.CompanyRegion ) AND (AppEnv.CompanyPrefs.CopyCOA or AppEnv.CompanyPrefs.CopyProducts) then
//          // tblChartOfAccounts data is copied from the current databse only, not from erpnewdb
//        else begin
//          { Need to update chart of accounts to correct taxcode }
//          script.SQL.Clear;
//          script.SQL.Add('drop table if exists tmp_taxxref;');
//          script.SQL.Add('create table tmp_taxxref (au_taxcode varchar(255), taxcode varchar(255))ENGINE=MEMORY;');
//          script.SQL.Add('insert into tmp_taxxref (au_taxcode, taxcode) values ((select TaxCodeSalesInc     from tblregionaloptions where region = "Australia" limit 1), (select TaxCodeSalesInc    from tblregionaloptions where region = '+QuotedStr(newRegion)+' limit 1));');
//          script.SQL.Add('insert into tmp_taxxref (au_taxcode, taxcode) values ((select TaxCodeSalesEx      from tblregionaloptions where region = "Australia" limit 1), (select TaxCodeSalesEx     from tblregionaloptions where region = '+QuotedStr(newRegion)+' limit 1));');
//          script.SQL.Add('insert into tmp_taxxref (au_taxcode, taxcode) values ((select TaxCodePurchaseInc  from tblregionaloptions where region = "Australia" limit 1), (select TaxCodePurchaseInc from tblregionaloptions where region = '+QuotedStr(newRegion)+' limit 1));');
//          script.SQL.Add('insert into tmp_taxxref (au_taxcode, taxcode) values ((select TaxCodePurchaseEx   from tblregionaloptions where region = "Australia" limit 1), (select TaxCodePurchaseEx  from tblregionaloptions where region = '+QuotedStr(newRegion)+' limit 1));');
//          script.SQL.Add('insert into tmp_taxxref (au_taxcode, taxcode) values ((select TaxCodeNoTax        from tblregionaloptions where region = "Australia" limit 1), (select TaxCodeNoTax from tblregionaloptions where region = '+QuotedStr(newRegion)+' limit 1));');
//          script.SQL.Add('update tblChartOfAccounts set TaxCode = (Select taxcode from tmp_taxxref where au_taxcode = tblChartOfAccounts.TaxCode limit 1) where IfNull(tblChartOfAccounts.TaxCode,"") <> "";');
//          script.SQL.Add('drop table if exists tmp_taxxref;');
//          script.Execute;
//        end;
//      end;
//
//    finally
//      script.Free;
//    end;
  finally
    qry.Free;
    NewConnection.Free;
  end;
end;


Procedure TMainForm.updateclosingdates;
var
  dt:TDatetime;
begin
  dt:= incmonth(GetCurrentFiscalYearStart , appenv.CompanyPrefs.NoOfMonthstoChangeClosingdate);
  if dt > now then dt:= incyear(GetCurrentFiscalYearStart , -1) else dt:= GetCurrentFiscalYearStart;

  dt:= incday(dt, -1);

  if (dt > appenv.CompanyPrefs.SummarisedTransDate) or
    (dt> appenv.CompanyPrefs.ClosingDate) or
    (dt> appenv.CompanyPrefs.ClosingDateAR) or
    (dt> appenv.CompanyPrefs.ClosingDateAP) then begin
    if dt > appenv.CompanyPrefs.SummarisedTransDate then appenv.CompanyPrefs.SummarisedTransDate := dt;
    if dt > appenv.CompanyPrefs.ClosingDate         then appenv.CompanyPrefs.ClosingDate := dt;
    if dt > appenv.CompanyPrefs.ClosingDateAR       then appenv.CompanyPrefs.ClosingDateAR := dt;
    if dt > appenv.CompanyPrefs.ClosingDateAP       then appenv.CompanyPrefs.ClosingDateAP := dt;
    if appenv.CompanyPrefs.SummarisedTransDate < appenv.CompanyPrefs.ClosingDate   then appenv.CompanyPrefs.SummarisedTransDate := appenv.CompanyPrefs.ClosingDate;
    if appenv.CompanyPrefs.SummarisedTransDate < appenv.CompanyPrefs.ClosingDateAR then appenv.CompanyPrefs.SummarisedTransDate := appenv.CompanyPrefs.ClosingDateAR;
    if appenv.CompanyPrefs.SummarisedTransDate < appenv.CompanyPrefs.ClosingDateAP then appenv.CompanyPrefs.SummarisedTransDate := appenv.CompanyPrefs.ClosingDateAP;
    {Dene - auto change closign date should change all dates}
    if appenv.CompanyPrefs.SummarisedTransDate <> appenv.CompanyPrefs.ClosingDate   then appenv.CompanyPrefs.ClosingDate  := appenv.CompanyPrefs.SummarisedTransDate;
    if appenv.CompanyPrefs.SummarisedTransDate <> appenv.CompanyPrefs.ClosingDateAR then appenv.CompanyPrefs.ClosingDateAR:= appenv.CompanyPrefs.SummarisedTransDate;
    if appenv.CompanyPrefs.SummarisedTransDate <> appenv.CompanyPrefs.ClosingDateAP then appenv.CompanyPrefs.ClosingDateAP:= appenv.CompanyPrefs.SummarisedTransDate;
  end;
end;

procedure TMainForm.UpdateUserCountDisplay(aUserCount: integer);
var
  userlist, userItem: TJsonObject;
  x: integer;
  mnuItem: TMenuItem;
begin
  case aUserCount of
    0: StatusBar.Panels[2].Text := '';
    1: StatusBar.Panels[2].Text := Format('    One User(%d)', [NoClientSlots]);
    else StatusBar.Panels[2].Text := Format('    %d( %d) Logged In Users', [aUserCount, NoClientSlots]);
  end;
  StatusBar.Refresh;

  pmPresentUsers.Items.Clear;
  userlist:= AppEnv.UtilsClient.GetFullUserList;
  try
    if Assigned(userlist) then
    begin
      for x:= 0 to userlist.Count -1 do
      begin
        mnuItem:= TMenuItem.Create(pmPresentUsers);
        pmPresentUsers.Items.Add(mnuItem);
        userItem:= userlist.O[IntToStr(x)];
        mnuItem.Caption:= userItem.S['username'];
        if userItem.S['databasename'] <> '' then
          mnuItem.Caption:= mnuItem.Caption +  ' [' + userItem.S['databasename'] + ']';
        if userItem.S['firstname'] <> '' then
          mnuItem.Caption:= mnuItem.Caption +  '  ' + userItem.S['firstname'];
        if userItem.S['lastname'] <> '' then
          mnuItem.Caption:= mnuItem.Caption +  '  ' + userItem.S['lastname'];
      end;
    end;
  finally
    UserList.Free;
  end;
end;


procedure TMainForm.DoCyTrackEvent(Sender: TObject; const Event, Value: string);
var
  x, y: integer;
  qry: TERPQuery;
  sl: TStringList;
  CallRec: TCyTrackCallerRec;
  CyTrack: TCyTrack;
begin
  if AppEnv.CompanyPrefs.CyTrackIntegrationEnabled and AppEnv.Employee.CyTrackIntegrationEnabled then begin
    if SameText(Event,'OnStatusChange') then begin
      if Sender is TCyTrack then CyTrack := TCyTrack(Sender)
      else exit;
      if PhoneFlashTimer.Enabled then begin
        PhoneFlashTimer.Enabled := false;
        imPhone.Tag := 3;
        ilAlerts.GetIcon(imPhone.Tag, imPhone.Picture.Icon);
      end;

      if SameText(CyTrack.Status,'Offering') and SameText(CyTrack.CallDirection,'IN') then begin
        PhoneFlashTimer.Enabled := true;
        x:= Left + imPhone.Left; // StatusBar.Panels.Items[0].Width + StatusBar.Panels.Items[1].Width + StatusBar.Panels.Items[2].Width;
        y := Top + Height - StatusBar.Height - 35;
        qry := TERPQuery.Create(nil);
        try
          qry.Connection := CommonDbLib.GetSharedMyDacConnection;
          { first check if it is a contact calling ... }
          qry.SQL.Add('select');
          qry.SQL.Add('if(isnull(ParentClient.Company),tblclients.Company,ParentClient.Company) as Company,');
          qry.SQL.Add('if(isnull(ParentClient.ClientID),tblclients.ClientID,ParentClient.ClientID) as ClientID,');
          qry.SQL.Add('if(isnull(ParentClient.Customer),tblclients.Customer,ParentClient.Customer) as IsCustomer,');
          qry.SQL.Add('if(isnull(ParentClient.Supplier),tblclients.Supplier,ParentClient.Supplier) as IsSupplier,');
          qry.SQL.Add('if(isnull(ParentClient.OtherContact),tblclients.OtherContact,ParentClient.OtherContact) as IsOtherContact,');
          qry.SQL.Add('tblcontacts.ContactID,');
          qry.SQL.Add('Trim(Concat_WS(" ",if(IsNull(tblcontacts.ContactTitle),"",tblcontacts.ContactTitle),if(IsNull(tblcontacts.ContactFirstName),"",tblcontacts.ContactFirstName),if(IsNull(tblcontacts.ContactSurName),"",tblcontacts.ContactSurName))) as ContactName');
          qry.SQL.Add('from tblclients');
          qry.SQL.Add('left join tblcontacts on tblclients.ClientID = tblcontacts.ClientID');
          qry.SQL.Add('left join tblclients as ParentClient on ParentClient.ClientID = tblclients.ParentClientID and tblclients.IsJob = "T"');
          qry.SQL.Add('where (Replace(ContactPh," ","") like "%'+CyTrack.CallerID+'")');
          qry.SQL.Add('or (Replace(ContactMOB," ","") like "%'+CyTrack.CallerID+'")');
          qry.SQL.Add('or (Replace(ContactAltPh," ","") like "%'+CyTrack.CallerID+'")');
          qry.Open;
          if qry.RecordCount > 0 then begin
            sl:= TStringList.Create;
            sl.AddObject('Incoming call:',nil);
            while not qry.Eof do begin
              CallRec := TCyTrackCallerRec.Create;
              CallRec.ClientId := qry.FieldByName('ClientId').AsInteger;
              CallRec.ContactId := qry.FieldByName('ContactId').AsInteger;
              CallRec.IsCustomer := qry.FieldByName('IsCustomer').AsBoolean;
              CallRec.IsSupplier := qry.FieldByName('IsSupplier').AsBoolean;
              CallRec.IsOtherContact := qry.FieldByName('IsOtherContact').AsBoolean;
              sl.AddObject(qry.FieldByName('Company').AsString + '  ' + qry.FieldByName('ContactName').AsString,CallRec);
              qry.Next;
            end;
            qry.Close;
            TfmNotification.ShowNotification(Point(x,y),sl,OnCallerClick);
          end
          else begin
            qry.SQL.Clear;
            qry.SQL.Add('select');
            qry.SQL.Add('if(isnull(ParentClient.Company),tblclients.Company,ParentClient.Company) as Company,');
            qry.SQL.Add('if(isnull(ParentClient.ClientID),tblclients.ClientID,ParentClient.ClientID) as ClientID,');
            qry.SQL.Add('if(isnull(ParentClient.Customer),tblclients.Customer,ParentClient.Customer) as IsCustomer,');
            qry.SQL.Add('if(isnull(ParentClient.Supplier),tblclients.Supplier,ParentClient.Supplier) as IsSupplier,');
            qry.SQL.Add('if(isnull(ParentClient.OtherContact),tblclients.OtherContact,ParentClient.OtherContact) as IsOtherContact,');
            qry.SQL.Add('0 as ContactID,');
            qry.SQL.Add('"" as ContactName');
            qry.SQL.Add('from tblclients');
            qry.SQL.Add('left join tblclients as ParentClient on ParentClient.ClientID = tblclients.ParentClientID and tblclients.IsJob = "T"');
            qry.SQL.Add('left join tblClientsOtherPhones on tblClientsOtherPhones.ClientID = tblclients.ClientID');
            qry.SQL.Add('left join tblClientsOtherPhones as ParentOtherPhones on ParentOtherPhones.ClientID = ParentClient.ClientID');
            qry.SQL.Add('where (Replace(tblclients.Phone," ","") like "%'+CyTrack.CallerID+'")');
            qry.SQL.Add('or (Replace(tblclients.Mobile," ","") like "%'+CyTrack.CallerID+'")');
            qry.SQL.Add('or (Replace(tblclients.AltPhone," ","") like "%'+CyTrack.CallerID+'")');
            qry.SQL.Add('or (Replace(ParentClient.Phone," ","") like "%'+CyTrack.CallerID+'")');
            qry.SQL.Add('or (Replace(ParentClient.Mobile," ","") like "%'+CyTrack.CallerID+'")');
            qry.SQL.Add('or (Replace(ParentClient.AltPhone," ","") like "%'+CyTrack.CallerID+'")');
            qry.SQL.Add('or (Replace(tblClientsOtherPhones.Phone," ","") like "%'+CyTrack.CallerID+'")');
            qry.SQL.Add('or (Replace(ParentOtherPhones.Phone," ","") like "%'+CyTrack.CallerID+'")');
            qry.Open;
            if qry.RecordCount > 0 then begin
              { client .. }
              sl:= TStringList.Create;
              sl.AddObject('Incoming call:',nil);
              while not qry.Eof do begin
                CallRec := TCyTrackCallerRec.Create;
                CallRec.ClientId := qry.FieldByName('ClientId').AsInteger;
                CallRec.ContactId := qry.FieldByName('ContactId').AsInteger;
                CallRec.IsCustomer := qry.FieldByName('IsCustomer').AsBoolean;
                CallRec.IsSupplier := qry.FieldByName('IsSupplier').AsBoolean;
                CallRec.IsOtherContact := qry.FieldByName('IsOtherContact').AsBoolean;
                sl.AddObject(qry.FieldByName('Company').AsString + '  ' + qry.FieldByName('ContactName').AsString,CallRec);
                qry.Next;
              end;
              qry.Close;
              TfmNotification.ShowNotification(Point(x,y),sl,OnCallerClick);
            end
            else begin
              {  unknown number ... }
              TfmNotification.ShowNotification(Point(x,y),'Incoming Call (unknown client):' + #13#10 + CyTrack.CallerID);
            end;
          end;
        finally
          qry.Free;
        end;
      end;
    end;
  end;
end;
procedure TMainForm.DoLogrecording;
begin
  //clog(WorkflowActions.EventList.Text);
end;
Function TMainForm.DoStartrecording:Boolean;
begin
  result:= False;
  if WorkflowObj.Startrecording then begin
       StatusBar.panels[6].TExt := '<FONT COLOR="#800000" size=10><B>Recording In Progress</B></FONT>';
       //if Assigned(Menu) then menu.Enabled := False;
       ShowworkflowStatus:= TRue;
       Result:= True;
  end else ShowworkflowStatus:= False;
end;
procedure TMainForm.DoStoprecording;
begin
  ShowworkflowStatus := False;
  WorkflowObj.Stoprecording;
end;
procedure TMainForm.DoCancelrecording;
begin
  ShowworkflowStatus := False;
  WorkflowObj.Cancelrecording;
end;

procedure TMainForm.DoOnLoggedInUserCountChange(NewUserCount: Integer);
begin
  UpdateUserCountDisplay(NewUserCount);
end;

procedure TMainForm.DoOnLostUtilsServerConnection(Sender: TObject);
begin
  CommonLib.MessageDlgXP_Vista('Your network connection with the ERP Server has been interrupted.' +
  #13#10 + #13#10 +
    'ERP will now close to preserve data integrity.', mtInformation, [mbOk], 0);
  MainForm.TerminateApp;
end;
procedure TMainForm.DoProgressdialogProgress(const Value: String);
begin
  DoStepProgressbar(prgDlgInitERP, Value);
end;

procedure TMainForm.DoRefreshedERPInfo;
begin
  fbRefreshedERPInfo := False;
end;

procedure TMainForm.CurrentUsersMsg(Msg:String);
begin
      InitMsgParams;
      PopupMsgParams.Msgcaption    :='ERP Users';
      PopupMsgParams.MsgText       :=Msg + NL +  MsgLine(true) + NL + CurrentUsers;
      PopupMsgParams.MsgFunc       := nil;
      PopupMsgParams.Custombuttons :='Ok';
      PopupMsgParams.Msg1          :='Unable to run ''Closing Dates Refresh''';
      PopupMsgParams.MsgHeight     :=400;
      TfmMessage.MsgDlg;
end;
function  TMainForm.CurrentUsers:String;
var
  userlist, userItem: TJsonObject;
  x:Integer;
  st:TStringlist;
begin
  st:= TStringlist.Create;
  try
    userlist:= AppEnv.UtilsClient.GetFullUserList;
    if Assigned(userlist) then begin
      for x:= 0 to userlist.Count -1 do begin
        userItem:= userlist.O[IntToStr(x)];
        if sametext(userItem.S['databasename'] , Appenv.AppDb.Database) then
          st.Add(userItem.S['username'] );
      end;
    end;
    result := St.Text;
  finally
    Freeandnil(st);
  end;

end;
Function TMainForm.Needtoupdateclosingdates(var MSG:String; showwarning:Boolean =true):Boolean;
var
  dt:TDatetime;
  LockMessage:String;
begin
  result := False;
  if LockPreferenceTable(LockMessage) then begin
    try
      result := False;
      dt:= incmonth(GetCurrentFiscalYearStart , appenv.CompanyPrefs.NoOfMonthstoChangeClosingdate);

      if dt > now then
        dt:= incyear(GetCurrentFiscalYearStart , -1) else dt:= GetCurrentFiscalYearStart;

      dt:= incday(dt, -1);

      if (dt > appenv.CompanyPrefs.SummarisedTransDate) or
        (dt> appenv.CompanyPrefs.ClosingDate) or
        (dt> appenv.CompanyPrefs.ClosingDateAR) or
        (dt> appenv.CompanyPrefs.ClosingDateAP) then begin
        result := true;
           if (dt > appenv.CompanyPrefs.SummarisedTransDate) then Msg := '->Current Financial year Start ' + Quotedstr(formatDateTime(FormatSettings.ShortDateformat, dt))+' is greater than the current summarise Trans Date '  + Quotedstr(formatDateTime(FormatSettings.ShortDateformat, appenv.CompanyPrefs.SummarisedTransDate))
      else if (dt> appenv.CompanyPrefs.ClosingDate)          then Msg := '->Current Financial year Start ' + Quotedstr(formatDateTime(FormatSettings.ShortDateformat, dt))+' is greater than the current Closing Date '          + Quotedstr(formatDateTime(FormatSettings.ShortDateformat, appenv.CompanyPrefs.ClosingDate))
      else if (dt> appenv.CompanyPrefs.ClosingDateAR)        then Msg := '->Current Financial year Start ' + Quotedstr(formatDateTime(FormatSettings.ShortDateformat, dt))+' is greater than the current Closing Date(AR) '      + Quotedstr(formatDateTime(FormatSettings.ShortDateformat, appenv.CompanyPrefs.ClosingDateAR))
      else if (dt> appenv.CompanyPrefs.ClosingDateAP)        then Msg := '->Current Financial year Start ' + Quotedstr(formatDateTime(FormatSettings.ShortDateformat, dt))+' is greater than the current Closing Date(AP) '      + Quotedstr(formatDateTime(FormatSettings.ShortDateformat, appenv.CompanyPrefs.ClosingDateAP));
      end;
    finally
      UnLockPreferenceTable;
    end;
  end else begin
   if showwarning then  MessageDlgXP_vista('ERP Has Detected That ''Closing Dates Refresh'' Has Not Been Completed '+chr(13) +
                        'and is not able to Run ''Closing Dates Refresh'' at the moment.' +chr(13) +chr(13)+
                      LockMessage, mtWarning, [mbOK], 0);
  end;
end;

Function TMainForm.istorunClosingdateRefresh(Var Msg:String):Boolean;
begin
  result:= False;
  if  not( Appenv.CompanyPrefs.ClosingDateChangeDone) then begin
    //some one has already triggered the closing date refresh
    Exit;
  end;
  if (not IsBatchInProgress AND TempClosingTablesEmpty) then begin
    Msg :='-> The Transaction summary tables - which holds data prior to the ''Financial Closing Date'' - are empty.'+NL+
          '     To stop this happening in future, add a transaction prior to the ' +Quotedstr('Financial Closing Date - ' + formatDateTime(FormatSettings.ShortDateFormat,appenv.CompanyPrefs.ClosingDate))+'.';
    Result:= True;
    Exit;
  end;
  if Appenv.CompanyPrefs.IsClonedCopy and Appenv.CompanyPrefs.DisableAutoUpdateclosingDate then
    {cloned copy and if auto updates are disabled, shouldn't update automatically}
  else
    if Appenv.CompanyPrefs.AutomaticallyUpdateclosingDate then
      if (HoursBetween(AppEnv.CompanyPrefs.SummarisedTransDateChanged,Now()) >HrsToHoldClosingDate ) then
        if (MonthsBetween(GetCurrentFiscalYearStart,now) >= AppEnv.CompanyPrefs.NoOfMonthstoChangeClosingdate) then
          if  (CompareDate(AppEnv.CompanyPrefs.SummarisedTransDate,GetLastFiscalYearEnd(Now()))<>Types.EqualsValue) then
            if Needtoupdateclosingdates(Msg)  then begin
              Msg := Msg + NL + '->It is more than ' + inttostr(HrsToHoldClosingDate)+' Hours since the closing Date is changed on - ' + Quotedstr(formatdateTime(FormatSettings.ShortDateformat ,AppEnv.CompanyPrefs.SummarisedTransDateChanged))+ ' at ' + Quotedstr(formatdateTime('hh:nn am/pm',AppEnv.CompanyPrefs.SummarisedTransDateChanged))+ NL +
                      '->It is more than ' + inttostr(AppEnv.CompanyPrefs.NoOfMonthstoChangeClosingdate) +' months from the beginning of current financial year start  - ' + Quotedstr(formatdateTime(FormatSettings.ShortDateformat ,GetCurrentFiscalYearStart));
              Result:= True;
              Exit;
            end;
end;

procedure TMainForm.RunClosingdateRefresh;
var
  msg:String;
  TransactionTableObj: TTransactionTableObj;
begin
     If  IsTorunClosingdateRefresh(Msg) then Begin
        if GetCurrentUserCount >1 then begin
          if (HoursBetween(AppEnv.CompanyPrefs.SummarisedTransDateChanged,Now()) >24 ) and (MonthsBetween(GetCurrentFiscalYearStart,now) >= 9) then
              Msg := 'It is more than 24 Hours since the summarised date is changed. '+NL+'The following user(s) are logged in.'
          else msg:='ERP Has Detected That ''Closing Dates Refresh'' Has Not Been Completed !  The following user(s) must exit the system to run it.';
          CurrentUsersMsg(Msg);
        end else begin
           if msg <> '' then MSg := NL+MSG + NL;
           if devmode then begin
              if CommonLib.MessageDlgXP_Vista('ERP Has Detected That ''Closing Dates Refresh'' Has Not Been Completed !'+NL+ MSG +
                NL+'A ''Closing Dates Refresh'' Will Commence Immediately', mtconfirmation, [mbyes , mbno], 0, nil, '' , '' , false , nil , '' , '' , 600) = mrno then exit;
           end else begin
              CommonLib.MessageDlgXP_Vista('ERP Has Detected That ''Closing Dates Refresh'' Has Not Been Completed !'+NL+ MSG +
                NL+'A ''Closing Dates Refresh'' Will Commence Immediately', mtInformation, [mbOK], 0, nil, '' , '' , false , nil , '' , '' , 600);
           end;

           if AppEnv.UtilsClient.LockLogon(msg, AppEnv.AppDb.Database, 'Performing a Summarised Transactions') then begin
              try
                ShowUpdateBatchHint(Self , MainSwitch2.Width,  Trunc(Screen.Height/2)-50 , MainSwitch2.Left);
                try
                  updateclosingdates;
                  TransactionTableObj := TTransactionTableObj.Create(False);
                  try
                    SetBatchInProgress(True);
                    SetBatchInProgress(False);
                    AppEnv.CompanyPrefs.ClosingDateChangeDone:= false;
                    try
                      TransactionTableObj.CleanRefreshTrnsTable(true, true);
                      TransactionTableObj.CreatePermanentSummaryTable;
                      TransactionTableObj.CleanRefreshTrnsTable(true, false, true);
                    finally
                      AppEnv.CompanyPrefs.ClosingDateChangeDone:= true;
                    end;

                  finally
                    FreeAndNil(TransactionTableObj);
                  end;
                finally
                  HideERPHint(Self)
                end;
              finally
                AppEnv.UtilsClient.UnlockLogon;
              end;
           end else begin
              CommonLib.MessageDlgXP_Vista('Unable to Summarise Transactions at This Time, Unable to Lock User Logon: ' + msg, mtInformation, [mbOk], 0);
              MainForm.TerminateApp;
              Exit;
           end;
        end;
     End;
end;

initialization
  ClassFinder.AddFindModuleClassFunc(FindModuleClassFunc);
  RegisterClassOnce(TMainForm);
end.



