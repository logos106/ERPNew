unit frmMultiSiteGUI2;

interface

uses
  Windows, Messages, Forms, Dialogs, Graphics, BaseInputForm, MyScript,
  ExtCtrls, IdMessage, IdSMTP, Variants,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdMessageClient, IdPOP3, DB, MyAccess, MemDS, DBAccess, AbBase, AbBrowse,
  AbZBrows, AbZipper, AbZipKit, kbmMemCSVStreamFormat, kbmMemTable,
  kbmMemBinaryStreamFormat, StdCtrls, Controls, wwcheckbox, ComCtrls,
  DNMPanel, ProgressTime, Buttons, DNMSpeedButton, DataState, SelectionDialog, AppEvnts,
  Classes,  AbArcTyp, MultisiteFunctionsObj2, LbClass,
  kbmCompress, IdCoderMIME, Menus, AdvMenus, DAScript, Shader;

const
  GUI_MSG    = WM_USER + 1;
  WM_AutoRun = WM_USER + 2;

type
  TGuiMsgType = (msgNone, msgToLog, msgStatus, msgProgMax, msgProgPos);

  TGUIData = class
  private
    txt,
    Font: string;
    isError: boolean;
  end;

  TMultiSiteGUI2 = class(TBaseInputGUI)
    mtExport: TkbmMemTable;
    kbmBinaryStreamFormat1: TkbmBinaryStreamFormat;
    kbmCSVStreamFormat1: TkbmCSVStreamFormat;
    bbSave: TDNMSpeedButton;
    pbDB: TProgressBar;
    reLog: TRichEdit;
    AbZipKit: TAbZipKit;
    mtImport: TkbmMemTable;
    ProgressTime1: TProgressTime;
    mtUpdate: TkbmMemTable;
    mtForeignKey: TkbmMemTable;
    MyCommand1: TMyCommand;
    qryGeneric: TMyQuery;
    qryGeneric2: TMyQuery;
    qryGeneric3: TMyQuery;
    tblMsForeignKey: TMyTable;
    tblMsDenySend: TMyTable;
    tblMsMasterDetails: TMyTable;
    tblMsBackendId: TMyTable;
    tblMsDenyReceive: TMyTable;
    tblMsForeignKeyGlobalRef: TStringField;
    tblMsForeignKeyForeignKeyID: TIntegerField;
    tblMsForeignKeyTableName: TStringField;
    tblMsForeignKeyFieldName: TStringField;
    tblMsForeignKeyForeignTableName: TStringField;
    tblMsForeignKeyQualifierField: TStringField;
    tblMsForeignKeyQualifier: TStringField;
    tblMsBackendIdGlobalRef: TStringField;
    tblMsBackendIdBackEndID: TIntegerField;
    tblMsBackendIdSiteCode: TStringField;
    tblMsBackendIdSiteDesc: TStringField;
    tblMsBackendIdBEDefault: TStringField;
    tblMsBackendIdEditedFlag: TStringField;
    tblMsBackendIdEmailCount: TIntegerField;
    tblMsBackendIdSentID: TIntegerField;
    tblMsBackendIdSentStamp: TDateTimeField;
    tblMsBackendIdReceivedID: TIntegerField;
    tblMsBackendIdReceivedStamp: TDateTimeField;
    tblMsBackendIdEmailAddressData: TStringField;
    tblMsBackendIdEmailPassword: TStringField;
    tblMsDenySendGlobalRef: TStringField;
    tblMsDenySendID: TIntegerField;
    tblMsDenySendSiteCode: TStringField;
    tblMsDenySendTableName: TStringField;
    tblMsDenyReceiveGlobalRef: TStringField;
    tblMsDenyReceiveEditedFlag: TStringField;
    tblMsDenyReceiveID: TIntegerField;
    tblMsDenyReceiveSiteCode: TStringField;
    tblMsDenyReceiveTableName: TStringField;
    tblMsMasterDetailsGlobalRef: TStringField;
    tblMsMasterDetailsMasterDetailsID: TIntegerField;
    tblMsMasterDetailsMasterTableName: TStringField;
    tblMsMasterDetailsDetailsTableName: TStringField;
    tblMsMasterDetailsMasterFieldName: TStringField;
    pbTable: TProgressBar;
    Label4: TLabel;
    mtForeignKeyGlobalRef: TStringField;
    mtForeignKeyForeignKeyID: TIntegerField;
    mtForeignKeyTableName: TStringField;
    mtForeignKeyFieldName: TStringField;
    mtForeignKeyForeignTableName: TStringField;
    mtForeignKeyQualifierField: TStringField;
    mtForeignKeyQualifier: TStringField;
    mtForeignKeyEditedFlag: TStringField;
    mtForeignKeyForeignTablePrimaryKey: TStringField;
    tblMsBackendIdConflictTodoUserId: TIntegerField;
    POP3: TIdPOP3;
    SMTP: TIdSMTP;
    MailMessage: TIdMessage;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    DNMPanel1: TDNMPanel;
    sbImport: TDNMSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    btnReceiveMail: TDNMSpeedButton;
    memExpecting: TMemo;
    memAvailable: TMemo;
    DNMPanel2: TDNMPanel;
    sbExport: TDNMSpeedButton;
    Label1: TLabel;
    edSentLast: TEdit;
    DNMPanel3: TDNMPanel;
    btnNewMultisite: TDNMSpeedButton;
    DNMPanel4: TDNMPanel;
    Label5: TLabel;
    Label6: TLabel;
    btnResend: TDNMSpeedButton;
    lbArchive: TListBox;
    cbOtherSites: TComboBox;
    SpeedButton1: TDNMSpeedButton;
    reNewMultisiteHelp: TRichEdit;
    EarlyExitTimer: TTimer;
    tblmsCalcFields: TMyTable;
    MyScript1: TMyScript;
    sbViewLog: TDNMSpeedButton;
    resolve: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure btnReceiveClick(Sender: TObject);
    procedure bbSaveClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure GuiMsg(var msg: TMessage); message GUI_MSG;
    procedure AutoRun(var msg: TMessage); message WM_AutoRun;
    procedure btnReceiveMailClick(Sender: TObject);
    procedure btnNewMultisiteClick(Sender: TObject);
    procedure lbArchiveClick(Sender: TObject);
    procedure btnResendClick(Sender: TObject);
    procedure cbOtherSitesChange(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure EarlyExitTimerTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MyScript1BeforeExecute(Sender: TObject; var SQL: string; var Omit: boolean);
    procedure MyCommand1AfterExecute(Sender: TObject; Result: boolean);
    procedure AbZipKitArchiveProgress(Sender: TObject; Progress: byte; var Abort: boolean);
    procedure AbZipKitArchiveItemProgress(Sender: TObject; Item: TAbArchiveItem; Progress: byte; var Abort: boolean);
    procedure POP3Work(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: integer);
    procedure POP3Status(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
    procedure SMTPStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
    procedure SMTPWork(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: integer);
    procedure sbViewLogClick(Sender: TObject);
    procedure CompressBlobStream(Dataset: TkbmCustomMemTable; UnCompressedStream, CompressedStream: TStream);
    procedure DecompressBlobStream(Dataset: TkbmCustomMemTable; CompressedStream, DeCompressedStream: TStream);
    procedure FormatSaveField(Sender: TObject; Field: TField; var Null: boolean; var Data: string);
    procedure FormatLoadField(Sender: TObject; Field: TField; var Null: boolean; var Data: string);
    procedure pnlTitleMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlTitleDblClick(Sender: TObject);
    procedure resolveClick(Sender: TObject);
  private
    { Private declarations }
    Initialized: boolean;
    SendBackendOnly: boolean;
    DB: TDBTableInfo;
    liErrorLog: TStringList;
    liTablesToSend: TStringList;
    liTablesToSendNot: TStringList;
    liTablesToSendOrdered: TStringList;
    logFile: TextFile;
    WrittenToLogFile: boolean;
    msUtils: TmsUtils;
    KeyPressed: boolean;
    function CanSend(const tblName: string): boolean;
    function FormDeltaFileName(const dbName, site: string; const no: integer; const dt: TDateTime): string;
    procedure LoadMemTables;
    procedure SendGuiMsg(const Kind: TGuiMsgType; const atxt, afont: string; const isError: boolean);
    procedure SendProgressMaximum(const Maximum: integer);
    procedure SendProgressPosition(const Position: integer);
    function MustSend(const tblName: string): boolean;
    procedure ProcessSend(const Data: Pointer);
    procedure ProcessReceive;
    procedure RefreshStatus;
    function SendEmail(const recipient, AttachmentFileName: string): boolean;
    procedure Initialize_Tables_Flags;
    procedure DetermineTablesToSend(UseMustSend: boolean = true);
    procedure VerifyTimeStamps;
    procedure VerifyGlobalRef;
    function IsPosEOPDone: boolean; {Check To See If End Of Period was Done !}
    function EncodeStr(const Str: string): string;
    function DecodeStr(const Str: string): string;
    procedure OrderTablesToSend(var canSendDelta: Boolean);
  public
    PerformAction: string;
  end;

implementation

uses FastFuncs,ShellAPI, CommonDbLib, DNMLib, DNMExceptions, frmMultisiteWizardGUI, 
  MiddleTier, frmCompanyInformationFrm, frmMultisiteWait, MyClasses, SysUtils, 
  tcMessaging, PopupAlert, MAIN,  TransactionsTable, CommonLib, Preferences,
  AppDatabase, AppEnvironment, dmMainGUI;

{$R *.dfm}
const
  KEYPHRASE     = 'QryGeneric.CommandText := SELECT SiteCode, TableName from tblmsDenySend';
  MULTISITEPATH = 'C:\Platinum1\Multisite\';
  LOGSPATH      = 'C:\Platinum1\Logs\';
  LOGFILENAME   = 'MultiSiteError';

procedure TMultiSiteGUI2.FormCreate(Sender: TObject);
var
  ServicesClient: TtcServicesClient;
begin
  inherited;
  KeyPressed := false;
  fbStartingUp := true;
  fActionBitmap := TBitmap.Create;
  mtForeignKey.OnCompressBlobStream := CompressBlobStream;
  mtForeignKey.OnDecompressBlobStream := DecompressBlobStream;
  mtUpdate.OnCompressBlobStream := CompressBlobStream;
  mtUpdate.OnDecompressBlobStream := DecompressBlobStream;
  mtExport.OnCompressBlobStream := CompressBlobStream;
  mtExport.OnDecompressBlobStream := DecompressBlobStream;
  mtImport.OnCompressBlobStream := CompressBlobStream;
  mtImport.OnDecompressBlobStream := DecompressBlobStream;
  kbmBinaryStreamFormat1.OnCompress := CompressBlobStream;
  kbmBinaryStreamFormat1.OnDeCompress := DecompressBlobStream;
  kbmCSVStreamFormat1.OnCompress := CompressBlobStream;
  kbmCSVStreamFormat1.OnDeCompress := DecompressBlobStream;
  kbmCSVStreamFormat1.OnFormatLoadField := FormatLoadField;
  kbmCSVStreamFormat1.OnFormatSaveField := FormatSaveField;
  ServicesClient := TtcServicesClient.Create;
  try
    ServicesClient.StopMultisiteNag;
  finally
    FreeandNil(ServicesClient);
  end;
  EarlyExitTimer.Enabled := false;
  //fbIgnoreAccessLevels := true;
  Initialized := false;
  liErrorLog := TStringList.Create;
  liTablesToSend := TStringList.Create;
  liTablesToSendOrdered := TStringList.Create;
  liTablesToSendNot := TStringList.Create;
  //fbIgnoreAccessLevels := true;
  SendBackendOnly := false;
  ForceDirectories(MULTISITEPATH);
  ForceDirectories(MULTISITEPATH + '\Archive');
  msUtils := TmsUtils.Create(CommonDbLib.GetSharedMyDacConnection);
  tblMsCalcFields.Connection := CommonDbLib.GetSharedMyDacConnection;
  tblMsDenySend.Connection := CommonDbLib.GetSharedMyDacConnection;
  tblMsDenyReceive.Connection := CommonDbLib.GetSharedMyDacConnection;
  tblmsForeignKey.Connection := CommonDbLib.GetSharedMyDacConnection;
  tblMsMasterDetails.Connection := CommonDbLib.GetSharedMyDacConnection;
  tblMsBackendId.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryGeneric.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryGeneric2.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryGeneric3.Connection := CommonDbLib.GetSharedMyDacConnection;
  MyCommand1.Connection := CommonDbLib.GetSharedMyDacConnection;
  MyScript1.Connection := CommonDbLib.GetSharedMyDacConnection;
  AbZipKit.Password := SYSDB_PASS;

end; //FormCreate

procedure TMultiSiteGUI2.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
  POP3.Disconnect;
  SMTP.Disconnect;
end;

procedure TMultiSiteGUI2.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: integer;
begin
  {$I-}
  System.CloseFile(logFile);
  {$I+}
  if IOResult = 0 then;
  FreeandNil(DB);
  FreeandNil(liErrorLog);
  FreeandNil(liTablesToSend);
  for i := 0 to liTablesToSendOrdered.Count - 1 do liTablesToSendordered.Objects[i].Free;
  FreeandNil(liTablesToSendOrdered);
  FreeandNil(liTablesToSendNot);
  FreeandNil(msUtils);
  Action := caFree;
  inherited;
end;

procedure TMultiSiteGUI2.FormDestroy(Sender: TObject);
var
  ServicesClient: TtcServicesClient;
begin
  FreeandNil(fActionBitmap);
  ServicesClient := TtcServicesClient.Create;
  try
    ServicesClient.ResetMultisiteNag;
    ServicesClient.UnLockLogonToDB;
  finally
    FreeandNil(ServicesClient);
  end;
  inherited;  
end;

procedure TMultiSiteGUI2.LoadMemTables;
var
  foreignTable: string;
begin
  DB := TDBTableInfo.Create(CommonDbLib.GetSharedMyDacConnection);

  tblMsCalcFields.Open;
  tblMsDenySend.Open;
  tblMsDenyReceive.Open;
  tblmsForeignKey.Open;
  tblMsMasterDetails.Open;
  tblMsBackendId.Open;

  mtForeignKey.Open;
  mtForeignKey.CopyRecords(tblMsForeignKey, mtForeignKey, 10000, false, false);

  with mtForeignKey do begin
    First;
    while not Eof do begin
      foreignTable := FieldByName('ForeignTableName').AsString;
      if foreignTable > '' then begin
        Edit;
        FieldByName('ForeignTablePrimaryKey').AsString := DB.GetPrimaryKey(foreignTable);
        Post;
      end;
      Next;
      Application.ProcessMessages;
    end;
  end;
end; //LoadMemTables

function TMultiSiteGUI2.FormDeltaFileName(const dbName, site: string; const no: integer; const dt: TDateTime): string;
begin
  Result := dbName + 'Delta_' + site + Format('%0.6d', [no]);
  if dt > 0.0 then Result := Result + '_' + FormatDateTime('yyyy-mm-dd_hh:nn', dt);
end;

procedure TMultiSiteGUI2.RefreshStatus;
var
  s: string;
  i, j: integer;
  sl: TStringList;
begin
  if not tblmsBackendID.Active then Exit;
  sl := TStringList.Create;
  try
    edSentLast.Text := ' ' + FormDeltaFileName(FastFuncs.LowerCase(CommonDbLib.GetSharedMyDacConnection.Database),
      AppEnv.Branch.SiteCode, AppEnv.Branch.SentID, AppEnv.Branch.SentStamp);

    memExpecting.Clear;
    tblmsBackendID.First;
    while not tblmsBackendID.Eof do begin
      if tblmsBackendIDBEDefault.AsString <> 'T' then begin
        s := FormDeltaFileName(FastFuncs.LowerCase(CommonDbLib.GetSharedMyDacConnection.Database),
          tblmsBackendIDSiteCode.AsString, tblmsBackendIDReceivedID.AsInteger + 1, 0.0);
        memExpecting.Lines.Add(s);
      end;
      tblmsBackendId.Next;
      Application.ProcessMessages;
    end;

    SetCurrentDir(MULTISITEPATH);
    FindInCurrentDir(FastFuncs.LowerCase(CommonDbLib.GetSharedMyDacConnection.Database) + 'Delta_*.*', sl);
    memAvailable.Lines := sl;
    sbImport.Enabled   := false;
    for i := 0 to memExpecting.Lines.Count - 1 do for j := 0 to memAvailable.Lines.Count - 1 do
        if FastFuncs.PosEx(memExpecting.Lines[i], memAvailable.Lines[j]) = 1 then begin
          sbImport.Enabled := true;
          Break;
        end;

    btnResend.Enabled := (cbOtherSites.ItemIndex > -1) and (lbArchive.ItemIndex > -1);
  finally
    FreeandNil(sl);
  end;
end;

procedure TMultiSiteGUI2.FormShow(Sender: TObject);
var
  SplashScreen: TForm;
  ServicesClient: TtcServicesClient;
  tmpMsgHStr, tmpMsgStr: string;
  MTClient: TMTClient;
  requestXml, answerXml: string;
  ServicesClientTerminateWait: TServicesClientTerminateWait;
  UsersAllowed: integer;
  tmpComponent: TComponent;  
begin
  if (PerformAction = 'MSRECEIVE') or (PerformAction = 'MSSEND') then UsersAllowed := 0
  else UsersAllowed := 1;
  try
    if GetCurrentThreadsConnected(CommonDbLib.GetSharedMyDacConnection.Database) > UsersAllowed then begin
      // Ensure there is only one user connected to the database.  That is You only!
      if MainForm.GetCurrentUserCount > UsersAllowed then begin
        dtmMainGUI.dlgCurrentUsers.Caption := CommonDbLib.GetSharedMyDacConnection.Database + ' Run Multisite';
        dtmMainGUI.dlgCurrentUsers.Color := $00D7F5FF;
        dtmMainGUI.dlgCurrentUsers.Message := 'The following user(s) must exit the system.';
        if not ((PerformAction = 'MSRECEIVE') or (PerformAction = 'MSSEND')) then dtmMainGUI.dlgCurrentUsers.Execute;

        // Terminate Users
        if ((PerformAction = 'MSRECEIVE') or (PerformAction = 'MSSEND')) or
          (CommonLib.MessageDlgXP_Vista('Do You Wish To Force The Exit Of These Users ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
          MTClient := TMTClient.Create(Self);
          try
            with MTClient do begin
              DB := CommonDbLib.GetSharedMyDacConnection.Database;
              DBUserName := CommonDbLib.GetSharedMyDacConnection.UserName;
              DBPassword := CommonDbLib.GetSharedMyDacConnection.Password;
              DBPort     := CommonDbLib.GetSharedMyDacConnection.Port;              
              Host := CommonDbLib.GetSharedMyDacConnection.Server;
              requestXml := '<Platinum1Msg><TERMINATEUSERS' + ' userid="' + FastFuncs.IntToStr(AppEnv.Employee.EmployeeID) +
                '" username="' + AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName + '" dbname="' +
                CommonDbLib.GetSharedMyDacConnection.Database + '" reason=" Performing Multisite' + '" excludeuserid="' +
                FastFuncs.IntToStr(AppEnv.Employee.EmployeeID) + '" terminatewaitsec="120' + '" delayloginsec="60"/></Platinum1Msg>';
              answerXml := SendXml(requestXml);
            end;
          finally
            FreeandNil(MTClient);
          end;
          ServicesClientTerminateWait := TServicesClientTerminateWait.Create(Self);
          try
            ServicesClientTerminateWait.StartTimer(125);
            while ServicesClientTerminateWait.Waiting do begin
              Application.ProcessMessages;
            end;
          finally
            FreeandNil(ServicesClientTerminateWait);
          end;
        end;
      end;
    end;

    // Lock DB
    ServicesClient := TtcServicesClient.Create;
    try
      ServicesClient.LockLogonToDB(' Performing Multisite');
    finally
      FreeandNil(ServicesClient);
    end;

    SplashScreen := TMultisiteWaitGUI.Create(Self);
    try
      with SplashScreen do begin
        SplashScreen.Show;
        Application.ProcessMessages;
      end;
      if not Initialized then begin
        Initialized := true;
        if Empty(AppEnv.Branch.EmailAddressData) or Empty(AppEnv.Branch.EmailUserName) or Empty(AppEnv.Branch.EmailPassword) then begin
          SplashScreen.Hide;
          if (CommonLib.MessageDlgXP_Vista('Email Settings incomplete!' + #13 + #10 + '' + #13 + #10 + 'Would Like Correct This Now?',
            mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
            Screen.Cursor := crDefault;
            tmpComponent := GetComponentByClassName('TfrmCompanyInformation');
            If not Assigned(tmpComponent) then Exit;
            with TfrmCompanyInformation(tmpComponent) do begin
              FormStyle := fsMDIChild;
              BringToFront;
              SetControlFocus(grdBranch);
              grdBranch.SetActiveField('EmailAddressData');
            end;
          end;
          EarlyExitTimer.Enabled := true;
          Screen.Cursor := crDefault;
          Exit;
        end;
        Screen.Cursor := crDefault;
        if Empty(AppEnv.CompanyPrefs.EmailPOPHost) or Empty(AppEnv.CompanyPrefs.EmailSMTPHost) then begin
          SplashScreen.Hide;
          if (CommonLib.MessageDlgXP_Vista('POP Host(Incoming) and SMTP Host(Outgoing) must be Set!' + #13 + #10 +
            '' + #13 + #10 + 'Would You Like Correct This Now?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
            Screen.Cursor := crDefault;
            tmpComponent := GetComponentByClassName('TPreferencesGUI');
            If not Assigned(tmpComponent) then Exit;
            with TPreferencesGUI(tmpComponent) do begin
              FormStyle := fsMDIChild;
              BringToFront;
            end;
          end;
          EarlyExitTimer.Enabled := true;
          Screen.Cursor := crDefault;
          Exit;
        end;
        Screen.Cursor := crDefault;
        ForceDirectories(LOGSPATH);
        if not FileExists(LOGSPATH + LOGFILENAME + '_' + GetCompanyName + '_' + AppEnv.Employee.LogonName + '.log') then begin
          {$I-}
          System.CloseFile(logFile);
          {$I+}
          if IOResult = 0 then;

          System.AssignFile(logFile, LOGSPATH + LOGFILENAME + '_' + GetCompanyName + '_' + AppEnv.Employee.LogonName + '.log');
          {$I-}
          System.Rewrite(logFile);
          {$I+}
          if IOResult <> 0 then CommonLib.MessageDlgXP_Vista('Error Rewrite LogFile', mtError, [mbOK], 0);
        end else begin
          {$I-}
          System.CloseFile(logFile);
          {$I+}
          if IOResult = 0 then;

          System.AssignFile(logFile, LOGSPATH + LOGFILENAME + '_' + GetCompanyName + '_' + AppEnv.Employee.LogonName + '.log');
          {$I-}
          System.Reset(logFile);
          {$I+}
          if IOResult = 0 then;
          {$I-}
          System.Append(logFile);
          {$I+}
          if IOResult <> 0 then CommonLib.MessageDlgXP_Vista('Error Append LogFile', mtError, [mbOK], 0);
        end;

        WrittenToLogFile := false;
        Screen.Cursor := crHourGlass;
        LoadMemTables;
        Screen.Cursor := crDefault;
      end;
      PageControl1.ActivePageIndex := 0;
      Initialize_Tables_Flags;
      RefreshStatus;
      if (PerformAction = 'MSRECEIVE') or (PerformAction = 'MSSEND') then PostMessage(self.Handle, WM_AutoRun, 0, 0);
    finally
      SplashScreen.Hide;
      FreeandNil(SplashScreen);
    end;
    if Empty(PerformAction) then begin
      ServicesClient := TtcServicesClient.Create;
      try
        if not ServicesClient.SendMultisiteUptoDateTest(tmpMsgHStr, tmpMsgStr) then begin
          If not Empty(tmpMsgStr) then Begin
            tmpComponent := GetComponentByClassName('TPopupAlertGUI');
            If not Assigned(tmpComponent) then Exit;
            with TPopupAlertGUI(tmpComponent) do begin
              MsgStr := tmpMsgStr;
              HeaderMsgStr := tmpMsgHStr;
              FormStyle := fsStayOnTop;
              Show;
              BringToFront;
            end;
          end;            
        end;
      finally
        FreeandNil(ServicesClient);
      end;
    end;
  except
    on e: ENoAccess do HandleNoAccessException(e);
    else raise;
  end;
end; //FormShow

procedure TMultiSiteGUI2.AutoRun(var msg: TMessage);
begin
  Application.ProcessMessages;
  if PerformAction = 'MSRECEIVE' then begin
    if btnReceiveMail.Enabled then btnReceiveMailClick(nil);
    if sbImport.Enabled then btnReceiveClick(nil);
    Sleep(20000);
    bbSaveClick(nil);
  end else if PerformAction = 'MSSEND' then begin
    PageControl1.ActivePageIndex := 1;
    if sbExport.Enabled then btnSendClick(nil);
    Sleep(20000);
    bbSaveClick(nil);
  end;
end;

// ---------------------------------------- SEND ----------------------------

function TMultiSiteGUI2.CanSend(const tblName: string): boolean;
var
  partMatchCount: integer;
begin
  Result := true;
  with tblMsDenySend do begin
    First;
    while not Eof and Result do begin
      if (tblMsDenySendSiteCode.AsString = AppEnv.Branch.SiteCode) or (tblMsDenySendSiteCode.AsString = '*') then
        if (tblMsDenySendTableName.AsString = tblName) or (tblMsDenySendTableName.AsString = '*') then Result := false;
      if Result then begin
        partMatchCount := FastFuncs.PosEx('*', tblMsDenySendTableName.AsString);
        if partMatchCount > 1 then if FastFuncs.CompareText(Copy(tblName, 1, partmatchCount - 1),
            Copy(tblMsDenySendTableName.AsString, 1, partmatchCount - 1)) = 0 then Result := false;
      end;
      Next;
    end;
  end;
end; //CanSend

function TMultiSiteGUI2.MustSend(const tblName: string): boolean;
var
  sitecount: integer;
  aSiteCode: string;
begin
  Result := false;
  with tblMsDenyReceive do begin
    First;
    while not Eof do begin
      if (tblMsDenyReceiveSiteCode.AsString = '*') then if (tblMsDenyReceiveTableName.AsString = tblName)
          or (tblMsDenyReceiveTableName.AsString = '*') then Exit; //===========> !   no site processes this table
      Next;
    end;
  end;

  siteCount := TblmsBackendID.RecordCount - 1; // we count down the deny entries for table
  // less the site this is running on
  TblmsBackendID.First;
  while not TblmsBackendID.Eof do begin // now check for each site
    aSiteCode := TblmsBackendIDSiteCode.AsString;
    if aSiteCode <> AppEnv.Branch.SiteCode then begin
      with tblMsDenyReceive do begin
        First;
        while not Eof do begin
          if (tblMsDenyReceiveSiteCode.AsString = aSiteCode) then
            if (tblMsDenyReceiveTableName.AsString = tblName) or (tblMsDenyReceiveTableName.AsString = '*') then
              Dec(siteCount); // this site does not process this table
          Next;
        end;
      end;
    end;
    TblmsBackendID.Next;
  end;
  Result := siteCount > 0; // siteCount is only 0 if all other sites don't process
end; //MustSend

procedure TMultiSiteGUI2.OrderTablesToSend(var canSendDelta: Boolean);
  {Context: we need to ensure that a table which has fields refering to other
    tables, is transfered later than the referred to tables.}
var
  ls: TStringList;
  i, level: integer;
  s: string;

  function CanResolve(const aTableName: string; var refTable: string): boolean;
    {check for each reference field wether the referred to table is
     already in liTablesToSendOrdered.
     Also returns the tablename of the table that is not yet in there}
  begin
    Result := true;
    with tblMsForeignKey do begin
      Filtered := false;
      Filter   := 'TableName = ''' + aTableName + '''';
      Filtered := true;
      First;
      while not Eof do begin
        refTable := tblMsForeignKeyForeignTableName.AsString;
        if (refTable > '') then
          Result := (refTable = aTableName) or (liTablesToSendOrdered.IndexOf(refTable) >= 0)
        else
          Result := false;
        if not Result then Exit; // ========>
        Next;
      end;
    end;
  end; //CanResolve
begin
  ls := TStringList.Create;
  try
    liTablesToSendOrdered.Clear;
    ls.Text := liTablesToSend.Text;
    level   := 0;
    repeat
      Inc(level);
      for i := ls.Count - 1 downto 0 do begin
        if canResolve(ls[i], s) then begin
          liTablesToSendOrdered.Add(ls[i]);
          ls.Delete(i);
        end;
      end;
    until (ls.Count = 0) or (level > 50);
    for i := 0 to ls.Count - 1 do begin
      canResolve(ls[i], s); // ot extract reftable to s
      ls[i] := ls[i] + ' - refers to: ' + s;
      SendGuiMsg(msgToLog, 'Table dependencies. Could not resolve ' + ls[i], '', true);
      canSendDelta := false;
    end;
  finally
    FreeandNil(ls);
  end;
end; //OrderTablesToSend

procedure TMultiSiteGUI2.ProcessSend(const Data: Pointer);
var
  DeltaFileName: string;
  canSendDelta: boolean;
  totalrecords: integer;



  procedure FlagMasterRecords;
    {Flagging Master Record Where Only Detail Records Changed}
  var
    i: integer;
    pk, masterTable: string;
  begin
    for i := 0 to liTablesToSendOrdered.Count - 1 do begin
      tblMsMasterDetails.Filtered := false;
      tblMsMasterDetails.Filter   := 'DetailsTableName=' + QuotedStr(liTablesToSendOrdered[i]);
      tblMsMasterDetails.Filtered := true;

      if (tblMsMasterDetails.RecordCount > 0) then begin
        tblMsMasterDetails.First;
        while not tblMsMasterDetails.Eof do begin
          masterTable := tblMsMasterDetailsMasterTableName.AsString;
          if DB.FindTable(masterTable) < 0 then begin
            SendGuiMsg(msgToLog, Format('Error: tlbMasterDetails MasterTable not found - "%s"',
              [masterTable]), '', true);
            tblMsMasterDetails.Filtered := false;
            Exit;
          end;

          pk := DB.GetPrimaryKey(masterTable);
          MyCommand1.SQL.Text := 'UPDATE ' + tblMsMasterDetailsMasterTableName.AsString + ' AS m' +
            ' INNER JOIN ' + tblMsMasterDetailsDetailsTableName.AsString + ' AS d ON ' + ' m.' + pk + ' = d.' +
            tblMsMasterDetailsMasterFieldName.AsString + ' SET m.msTimeStamp = d.msTimeStamp' +
            ' WHERE d.msTimeStamp >= "' + FormatDateTime('yyyy-mm-dd hh:nn:ss', AppEnv.Branch.SentStamp) +
            '" AND m.msTimeStamp < d.msTimeStamp;';
          try
            MyCommand1.Execute;
          except
            on E: EMyError do begin
              CommonLib.MessageDlgXP_Vista(MyCommand1.SQL.Text, mtError, [mbOK], 0);
            end;
          end;

          tblMsMasterDetails.Next;
        end;
      end;
      tblMsMasterDetails.Filtered := false;
    end;
  end; // FlagMasterRecords

  procedure FlagDetailRecords;
    { Context: detail records being deleted.
      The way to propagate this to other sites is done by transmitting all
      detail records of a master (being edited after last delta creation)
      and when receiving such a (master) record to delete all detail records first
      (which will then be reimported) }
  var
    i: integer;
    pk, masterTable: string;
  begin
    for i := 0 to liTablesToSendOrdered.Count - 1 do begin
      tblMsMasterDetails.Filtered := false;
      tblMsMasterDetails.Filter   := 'MasterTableName=' + QuotedStr(liTablesToSendOrdered[i]);
      tblMsMasterDetails.Filtered := true;

      if (tblMsMasterDetails.RecordCount > 0) then begin
        masterTable := tblMsMasterDetailsMasterTableName.AsString;
        tblMsMasterDetails.First;
        while not tblMsMasterDetails.Eof do begin
          if DB.FindTable(masterTable) < 0 then begin
            SendGuiMsg(msgToLog, Format('Error: tlbMasterDetails MasterTable not found - "%s"',
              [masterTable]), '', true);
            tblMsMasterDetails.Filtered := false;
            Exit;
          end;

          pk := DB.GetPrimaryKey(masterTable);
          MyCommand1.SQL.Text := 'UPDATE ' + tblMsMasterDetailsDetailsTableName.AsString + ' AS d' +
            ' INNER JOIN ' + tblMsMasterDetailsMasterTableName.AsString + ' AS m ON ' + ' m.' + pk + ' = d.' +
            tblMsMasterDetailsMasterFieldName.AsString + ' SET d.msTimeStamp = m.msTimeStamp ' +
            ' WHERE m.msTimeStamp >= "' + FormatDateTime('yyyy-mm-dd hh:nn:ss', AppEnv.Branch.SentStamp) + '";';
          try
            //loglib.Log(MyCommand1.SQL.Text+' 2','Multisite');
            MyCommand1.Execute;
          except
          end;

          tblMsMasterDetails.Next;
        end;
      end;
      tblMsMasterDetails.Filtered := false;
    end;
  end;

  procedure ProduceExportSQL;
    { create SQL to export tables. SQL is stored as TStringList in
      liTablesToSendOrdered.Objects[] }
  var
    iTable, iField, {DBIndex,} tid: integer;
    SQL, s1, s2, pk, theTableName: string;
    mtFK: TKbmMemTable;
  begin
    mtFK := TKbmMemTable.Create(Self);
    mtFK.LoadFromDataSet(tblmsForeignKey, [mtcpoStructure, mtcpoProperties]);
    try
      for iTable := 0 to liTablesToSendOrdered.Count - 1 do begin
        theTableName := liTablesToSendOrdered[iTable];
        tblMsForeignKey.Filtered := false;
        tblMsForeignKey.Filter := 'TableName = ''' + theTableName + '''';
        tblMsForeignKey.Filtered := true;
        mtFK.Filtered := false;
        mtFK.EmptyTable;
        tblMsForeignKey.First;
        while not tblMsForeignKey.Eof do begin
          mtFK.Insert;
          mtFK.FieldByName('ForeignKeyID').asInteger := 0;
          mtFK.FieldByName('TableName').asString := tblMsForeignKeyTableName.asString;
          mtFK.FieldByName('FieldName').asString := tblMsForeignKeyFieldName.asString;
          mtFK.FieldByName('ForeignTableName').asString := tblMsForeignKeyForeignTableName.asString;
          mtFK.FieldByName('QualifierField').asString := tblMsForeignKeyQualifierField.asString;
          mtFK.FieldByName('Qualifier').asString := tblMsForeignKeyQualifier.asString;
          mtFK.Post;
          tblMsForeignKey.Next;
        end;
        s1 := '';
        s2 := #13#10 + ' FROM ' + theTableName + ' AS t ';
        tid := 0;
        for iField := 0 to DB.Fields[theTableName].Count - 1 do begin
          mtFK.Filtered := false;
          mtFK.Filter := 'FieldName = ''' + DB.Fields[theTableName][iField] + '''';
          mtFK.Filtered := true;
          if mtFK.RecordCount = 0 then // this field is not a reference
            s1 := s1 + 't.' + DB.Fields[theTableName][iField] + ', '
          else begin
            mtFK.First;
            Inc(tid);
            if mtFK.RecordCount = 1 then begin
              pk := DB.GetPrimaryKey(mtFK.FieldByName('ForeignTableName').AsString);
              s1 := s1 + #13#10 + 't' + FastFuncs.IntToStr(tid) + '.GlobalRef AS ' + DB.Fields[theTableName][iField] + 'GR, ';

              s2 := s2 + #13#10 + 'LEFT JOIN ' + mtFK.FieldByName('ForeignTableName').AsString +
                ' AS t' + FastFuncs.IntToStr(tid) + ' ON (' + 't.' + DB.Fields[theTableName][iField] + ' = ' + 't' + FastFuncs.IntToStr(tid) + '.' + pk + ') '
            end else begin
              s1 := s1 + #13#10 + 'CONCAT_WS("", ';
              repeat
                pk := DB.GetPrimaryKey(mtFK.FieldByName('ForeignTableName').AsString);
                if pk = '' then begin
                  SendGuiMsg(msgToLog, Format('Error: tblForeignKey ForeignTableNName empty',
                    [mtFK.FieldByName('ForeignTableName').AsString]), '', true);
                  Break;
                end;
                Inc(tid);
                s1 := s1 + 't' + FastFuncs.IntToStr(tid) + '.GlobalRef, ';

                s2 := s2 + #13#10 + 'LEFT JOIN ' + mtFK.FieldByName('ForeignTableName').AsString +
                  ' AS t' + FastFuncs.IntToStr(tid) + ' ON (' + 't.' + DB.Fields[theTableName][iField] + ' = ' + 't' +
                  FastFuncs.IntToStr(tid) + '.' + pk + ') ' + ' AND (t.' + mtFK.FieldByName('QualifierField').AsString +
                  ' = ' + '''' + mtFK.FieldByName('Qualifier').AsString + ''')';
                mtFK.Next;
              until mtFK.Eof;
              Delete(s1,FastFuncs.StrLength(s1) - 1, 2); // remove last comma
              s1 := s1 + ') AS ' + DB.Fields[theTableName][iField] + 'GR, ';
            end;
          end;
        end;
        Delete(s1,FastFuncs.StrLength(s1) - 1, 2); // remove last comma
        if FastFuncs.SameText(liTablesToSendOrdered[iTable], 'tblmsbackendid') then SQL := 'SELECT ' + s1 + s2 + ';' // essential !!!
        else SQL := 'SELECT ' + s1 + s2 + #13#10 + ' WHERE t.msTimeStamp > :LastSent';
        if not Assigned(liTablesToSendOrdered.Objects[iTable]) then
          liTablesToSendOrdered.Objects[iTable] := TStringList.Create;
        TStringList(liTablesToSendOrdered.Objects[iTable]).Text := SQL;
      end;
    finally
      FreeandNil(mtFK);
    end;
  end; //ProduceExportSQL

  function hasSelfReference(const tableName: string): boolean;
  begin
    tblMsForeignKey.Filter :=
      '(TableName = ''' + tableName + ''') AND (ForeignTableName = ''' + tableName + ''')';
    tblMsForeignKey.Filtered := true;
    Result := tblMsForeignKey.RecordCount > 0;
  end;

  function PerformExportSQL: string;
    {creates files (matching tables) containing all records edited later than last export}
  type
    TEncryption = (enNone, enBlowFish);
  var
    i, fldCount: integer;
    t, t1, t2: cardinal;
    stPlain: TMemoryStream;
    stEncrypted: TMemoryStream;
    selfRefFieldName: string;
    selfRef, globalRef: string;
    archiveFileName: string;
    lsRef: TStringList;
    canMove: boolean;
    lsRefIndex: integer;
    SentID: integer;
    SentStamp: TDateTime;
    hh, nn, ss, ms: word;
    encryption: TEncryption;
  begin
    encryption := enBlowFish;
    //encryption := enNone;
    stPlain := TMemoryStream.Create;
    stEncrypted := TMemoryStream.Create;
    lsRef := TStringList.Create;
    try
      SentID := AppEnv.Branch.SentID + 1;
      DecodeTime(Now, hh, nn, ss, ms);
      SentStamp := Date + EncodeTime(hh, nn, 0, 0);
      SetCurrentDir(MULTISITEPATH);
      AbZipKit.BaseDirectory := GetCurrentDir;
      DeleteFiles('', DeltaFileName + '*.zip');
      DeleteFiles('', DeltaFileName + '*.enc');
      SendProgressMaximum(liTablesToSendOrdered.Count);
      totalrecords := 0;
      //    if liTablesToSendOrdered.IndexOf('tblfixedassets') > -1 then
      //      liTablesToSendOrdered.Delete( liTablesToSendOrdered.IndexOf('tblfixedassets'));
      {TODO : tables above contain fieldnames > 31 ----> change?}

      for i := 0 to liTablesToSendOrdered.Count - 1 do begin
        SendProgressPosition(i);
        SendGuiMsg(msgStatus, 'Exporting ' + liTablesToSendOrdered[i], '', false);
        Application.ProcessMessages;
        t := GetTickCount;

        qryGeneric.Close;
        QryGeneric.SQL := TStringList(liTablesToSendOrdered.Objects[i]);
        QryGeneric.SQL.Text := ReplaceStr(QryGeneric.SQL.Text, ':LastSent',
          '"' + FormatDateTime('yyyy-mm-dd hh:nn:ss', AppEnv.Branch.SentStamp) + '"');
        qryGeneric.Open;

        t2 := GetTickCount;
        if not (qryGeneric.Eof and qryGeneric.Bof) then begin
          mtExport.Close;
          if hasSelfReference(liTablesToSendOrdered[i]) then begin // need to ensure that referred to records come first
            mtExport.CreateTableAs(qryGeneric, [mtcpoStructure, mtcpoProperties]);
            mtExport.Open;
            lsRef.Clear;
            qryGeneric.First;
            while not qryGeneric.Eof do begin
              lsRef.AddObject(qryGeneric.FieldByName('GlobalRef').AsString,
                qryGeneric.GetBookmark);
              qryGeneric.Next;
            end;

            while lsRef.Count > 0 do begin
              lsRefIndex := 0;
              while lsRefIndex < lsRef.Count do begin
                // if none of selfRefFields targets is in lsRef then move to mtExport
                tblMsForeignKey.First;
                canMove := true;
                // tblMsForeignKey is filtered for this table and selfreferring fields
                while not tblMsForeignKey.Eof do begin
                  selfRefFieldName := tblMsForeignKeyFieldName.AsString + 'GR';
                  qryGeneric.GotoBookmark(lsRef.Objects[lsRefIndex]);
                  selfRef := qryGeneric.FieldByName(selfRefFieldName).AsString;
                  globalRef := qryGeneric.FieldByName('GlobalRef').AsString;
                  if (selfRef > '') and (lsRef.IndexOf(selfRef) > -1) and (selfRef <> globalRef) then begin
                    canMove := false; // selfref is still in slTmp/mtTmp
                    Break;
                  end;
                  tblMsForeignKey.Next;
                end;
                if canMove then begin
                  mtExport.Append;
                  for fldCount := 0 to qryGeneric.FieldCount - 1 do
                    mtExport.Fields[fldCount].AsVariant := qryGeneric.Fields[fldCount].AsVariant;
                  mtExport.Post;
                  lsRef.Delete(lsRefIndex);
                end else Inc(lsRefIndex);
              end;
            end;
          end else mtExport.LoadFromDataSet(qryGeneric, [mtcpoStructure, mtcpoProperties]);
          t2 := GetTickCount - t2;
          qryGeneric.Close;

          mtExport.Open;
          stPlain.Clear;
          mtExport.SaveToStreamViaFormat(stPlain, mtExport.DefaultFormat);

          t1 := GetTickCount - t;
          t := GetTickCount;
          if liTablesToSendOrdered[i] <> 'tblmsbackendid' then // enter sent (edited) record into tblmsEdited
          {// (so we can check against concurrent updates from incoming deltas)} 
          begin
            mtExport.First;
            while not mtExport.Eof do begin
              tblMsBackendId.First;
              while not tblMsBackendId.Eof do begin
                if tblMsBackendIdBEDefault.AsString <> 'T' then begin
                  MyCommand1.sql.Text := 'INSERT HIGH_PRIORITY INTO tblMsEdited ' +
                    '(EditedTableName, EditedGlobalRef, SiteCode, SentStamp) VALUES( ' + Format('"%s", "%s", "%s", "%s" );',
                    [liTablesToSendOrdered[i], mtExport.FieldByName('GlobalRef').AsString, tblMsBackendIdSiteCode.AsString,
                    FormatDateTime('_yyyy-mm-dd_hh:nn', SentStamp) + ':00']);
                  //loglib.Log(MyCommand1.SQL.Text+' 3','Multisite');
                  MyCommand1.Execute;
                end;
                tblMsBackendId.Next;
              end;
              mtExport.Next;
            end;
          end;

          // compress, encrypt and save
          ArchiveFileName := GetCurrentDir + '\' + DeltaFileName + Format('%0.6d_%s',
            [SentID, FormatDateTime('yyyy-mm-dd_hh-nn', SentStamp)]) + '.zip';
          AbZipKit.FileName := ArchiveFileName;
          // (Note: AddFromStream saves and clears FileName)
          AbZipKit.AddFromStream(liTablesToSendOrdered[i] + '.exp', stPlain);
          SendGuiMsg(msgToLog, Format('  %-35s  %6.0n  %3.1n  %3.1n  %3.1n',
            [Copy(liTablesToSendOrdered[i], 4, 100), 0.0 + mtExport.RecordCount,
            t1 / 1000.0, (GetTickCount - t) / 1000.0, t2 / 1000.0]),
            'Courier New', false);
          totalrecords := totalrecords + mtExport.RecordCount;
          mtExport.Close;
          Application.ProcessMessages;
        end;
      end;
      AbZipKit.CloseArchive;

      // encrypt compressed archive
      case Encryption of
        enNone: Result := ExpandFileName(ArchiveFileName);
        enBlowfish: with TLbBlowFish.Create(Self) do begin
            GenerateKey(KEYPHRASE);
            Result := ChangeFileExt(ExpandFileName(ArchiveFileName), '.enc');
            EncryptFile(ArchiveFileName, Result);
            DeleteFile(ArchiveFileName);
          end;
      end;

      // copy zip-archive to folder .\Archive
      stPlain.LoadFromFile(Result);
      SetCurrentDir(MultisitePath + '\Archive');
      stPlain.SaveToFile(ExtractFileName(Result));

      AppEnv.Branch.SentID    := SentID;
      AppEnv.Branch.SentStamp := SentStamp;
      SendGuiMsg(msgStatus, Format('Export Finished. Records in Delta: %6.0n',
        [0.0 + totalrecords]), '', false);
    finally
      FreeandNil(stPlain);
      FreeandNil(stEncrypted);
      FreeandNil(lsRef);
      SendProgressMaximum(0);
    end;
  end; //PerformSQL

  procedure SetTblmsBackendID;
  var
    p: integer;
  begin
    p := liTablesToSendOrdered.IndexOf('tblmsbackendid');
    if p > -1 then liTablesToSendOrdered.Move(p, 0)
    else liTablesToSendOrdered.Insert(0, 'tblmsbackendid');
  end;
var
  sentOK: boolean;
  recipients: string;
begin //ProcessSend
      //sentOK := False;
  canSendDelta := true;
  tblmsBackendId.Close; // in case we came from Multisite Wizard
  tblmsBackendId.Open;

  //NO End Of Period Done
  if not IsPosEOPDone() then begin
    CommonLib.MessageDlgXP_Vista('You must Complete the POS End-Of-Period before commencing an Export', mtError, [mbOK], 0);
    canSendDelta := false;
    ProgressTime1.Reset;
    ProgressTime1.Stop('Send Failed', clRed);
    Exit;
  end;

  DeltaFileName := FastFuncs.LowerCase(CommonDbLib.GetSharedMyDacConnection.Database) + 'Delta_' + AppEnv.Branch.SiteCode;
  SetCurrentDir(ExtractFilePath(ParamStr(0)));

  SendGuiMsg(msgToLog, 'Determine Tables to Send', '', false);
  DetermineTablesToSend;

  SendGuiMsg(msgToLog, 'Verify GlobalRefs', '', false);
  VerifyGlobalRef;

  SendGuiMsg(msgToLog, 'Verify TimeStamps', '', false);
  VerifyTimeStamps;

  SendGuiMsg(msgToLog, 'Resolving Sending Order', '', false);
  OrderTablesToSend(canSendDelta);

  SendGuiMsg(msgToLog, 'Flagging Master Record Where Only Detail Records Changed', '', false);
  FlagMasterRecords;

  SendGuiMsg(msgToLog, 'Flagging Detail Records', '', false);
  FlagDetailRecords;

  SendGuiMsg(msgToLog, 'Force TblmsBackendID to be sent', '', false);
  SetTblmsBackendID;

  SendGuiMsg(msgToLog, 'Producing SQL', '', false);
  ProduceExportSQL;

  DeltaFileName := PerformExportSQL;

  SetCurrentDir(ExtractFilePath(ParamStr(0)));

  if not canSendDelta then begin
    msUtils.AddToDoByFormAccessRight(Self.ClassName,
      'Multisite Export Error. Delta not sent! Please check file: ' + LOGSPATH + LOGFILENAME +
      '_' + GetCompanyName + '_' + AppEnv.Employee.LogonName + '.log', Date);
    ProgressTime1.Stop('Error: Delta file was not sent (see Log)', clRed);
  end else begin
    recipients := '';
    with tblmsbackendId do begin
      First;
      while not Eof do begin
        if tblmsbackendIdBEDefault.AsString <> 'T' then recipients :=
            recipients + tblmsbackendIdEmailAddressData.AsString + ',';
        Next;
      end;
    end;
    System.Delete(recipients,FastFuncs.StrLength(recipients), 1); // delete last comma

    if recipients > '' then begin
      sentOK := SendEmail(recipients, DeltaFileName);
      if sentOK then begin
        msUtils.MSLogAddSent(totalrecords, 'OK File="' + ExtractFileName(DeltaFileName) + '" ');
        ProgressTime1.Stop('Send success', clGreen);
      end else begin
        msUtils.MSLogAddSent(totalrecords, 'ERROR File="' + ExtractFileName(DeltaFileName) + '" ');
        ProgressTime1.Stop('Send Failed', clRed);
      end;
    end else begin
      msUtils.MSLogAddSent(totalrecords, 'OK File not sent (no recipients)');
      ProgressTime1.Stop('Nothing was Sent (no recipients)', clGreen);
    end;

    DeleteFile(DeltaFileName); // note: copy of this file is in folder .\Archive
  end;
     //  CloseFile(f);
end; //ProcessSend

procedure TMultiSiteGUI2.btnSendClick(Sender: TObject);
begin
  SetControlFocus(reLog);
  sbImport.Enabled := false;
  sbExport.Enabled := false;
  bbSave.Enabled := false;
  try
    ProgressTime1.Start('Send Delta ');
    ProcessSend(nil);
    SetMultisitePC(AppEnv.Employee.EmployeeID);
  finally
    sbImport.Enabled := true;
    bbSave.Enabled   := true;
    RefreshStatus;
  end;
end;

// ---------------------------------------- RECEIVE ----------------------------

procedure TMultiSiteGUI2.ProcessReceive;
var
  t, ix, fileCount: integer;
  inStream: TMemoryStream;
  DeltaFileName, SearchFileName, WantedFileName, ZipFileName: string;
  nextFileNo: string;
  aSiteCode: string;
  slFiles: TStringList;
  SenderSynchDate: TDateTime;
  t1, t2, t3: cardinal;

  procedure UpdateTable(const tableName: string); // imported records in mtImport;

    procedure replaceGR;
    var
      refFieldName, pkFieldName, refTableName, qualifierFieldName, GR: string;
    begin
      mtImport.Edit;
      mtforeignKey.First;
      while not mtForeignKey.Eof do begin
        qualifierFieldName := mtForeignKeyQualifierField.AsString;
        if (qualifierFieldName = '') or (mtImport.FieldByName(qualifierFieldName).AsString = mtForeignKeyQualifier.AsString) then
        begin
          refFieldName := mtForeignKeyFieldName.AsString;
          if (mtImport.FindField(refFieldName + 'GR') <> nil) then GR := mtImport.FieldByName(refFieldName + 'GR').AsString;
          if GR > '' then begin
            refTableName := mtForeignKeyForeignTableName.AsString;
            pkFieldName := mtForeignKeyForeignTablePrimaryKey.AsString;
            qryGeneric2.SQL.Text := 'SELECT ' + pkFieldName + ' FROM ' + refTableName + ' WHERE GlobalRef = "' + GR + '";';
            //loglib.Log(qryGeneric2.SQL.Text+' 4','Multisite');
            qryGeneric2.Execute;
            if qryGeneric2.RecordCount <> 1 then begin
              SendGuiMsg(msgToLog, Format('Error: Did not find GlobalRef %s in Table %s',
                [GR, refTableName]), '', true);
              Break;
            end;
            if Assigned(mtImport.Fields.FindField(refFieldName + 'GR')) then
              mtImport.FieldByName(refFieldName + 'GR').AsString := qryGeneric2.FieldByName(pkFieldName).AsString;
            qryGeneric2.Close;
          end;
        end;
        mtForeignKey.Next;
      end;
      mtImport.Post;
    end; //replaceGR

    procedure updateAdd(const lsFields: TStringList);
    var
      GR: string;

      function GetFieldContent(const targetField, sourceField: TField): string;
      var
        blen: integer;
        bst: TStream;
        bufbin, bufhex: Pointer;
      begin
        if sourceField.IsNull then begin
          if DB.IsNullableField(tableName, targetField.FieldName) then Result := 'NULL, '
          else Result := '"", ';

          Exit;
        end;

        case targetField.DataType of

          ftDate: if not (sourceField.AsDateTime = 0) then Result :=
                '"' + FormatDateTime('yyyy-mm-dd', sourceField.AsDateTime) + '", '
            else if DB.IsNullableField(tableName, targetField.FieldName) then Result := 'NULL, '
              else Result := '"", ';

              ftTime: if not (sourceField.AsDateTime = 0) then Result :=
                '"' + FormatDateTime('hh:nn:ss', sourceField.AsDateTime) + '", '
            else if DB.IsNullableField(tableName, targetField.FieldName) then Result := 'NULL, '
              else Result := '"", ';

              ftDateTime: if not (sourceField.AsDateTime = 0) then begin
              if FastFuncs.SameText(targetField.FieldName, 'msTimeStamp') then
                Result := '"' + FormatDateTime('yyyymmddhhnnss', sourceField.AsDateTime) + '", '
              else Result := '"' + FormatDateTime('yyyy-mm-dd hh:nn:ss', sourceField.AsDateTime) + '", ';
            end else if DB.IsNullableField(tableName, targetField.FieldName) then Result := 'NULL, '
              else Result := '"", ';

              ftLargeInt, ftInteger: try
              if (sourceField.DataType = ftMemo) then Result := FastFuncs.IntToStr(Trunc(StrValue(sourceField.AsString))) + ', '
              else Result := FastFuncs.IntToStr(sourceField.AsInteger) + ', ';
            except
              on EConvertError do begin
                Result := FastFuncs.IntToStr(Trunc(StrValue(sourceField.AsString))) + ', ';
              end;
              on EDatabaseError do begin
                if (sourceField.DataType = ftMemo) then Result := FastFuncs.IntToStr(Trunc(StrValue(sourceField.AsString))) + ', ';
              end;
            end;

          ftFloat: try
              Result := FloatToStr(sourceField.AsFloat) + ', '            except              on EConvertError do
                begin                Result := FloatToStr(StrValue(sourceField.AsString)) + ', ';
              end;
              on EDatabaseError do begin
                if (sourceField.DataType = ftMemo) then Result := FloatToStr(StrValue(sourceField.AsString)) + ', ';
              end;
            end;

          ftBoolean: if not sourceField.IsNull and sourceField.AsBoolean then Result := '"T", '
            else Result := '"F", ';

            ftBlob: 
            begin
              bst := mtImport.CreateBlobStream(sourceField, bmRead);
              try
                if bst.Size > 0 then begin
                  blen := bst.Size;
                  bufbin := GetMemory(blen);
                  bufhex := GetMemory(blen * 2 + 1);
                  bst.ReadBuffer(bufbin^, blen);
                  BinToHex(bufbin, bufhex, blen);
                  Result := '0x' + Copy(string(bufhex), 1, blen * 2) + ', ';
                  FreeMemory(bufbin);
                  FreeMemory(bufHex);
                end else if DB.IsNullableField(tableName, targetField.FieldName) then Result := 'NULL, '
                else Result := '"", ';
              finally
                FreeandNil(bst);
              end;
            end else Result := '"' + escapeForMySQL(sourceField.AsString) + '", ';
        end;
      end; //GetFieldContent

      function makeInsertSQL: string;
      var
        fno: integer;
        s1, s2: string;
      begin
        s1 := '';
        s2 := '';
        for fno := 0 to lsFields.Count - 1 do if lsFields.Objects[fno] <> Pointer(-1) then begin
            s1 := s1 + lsFields[fno] + ', ';
            if not FastFuncs.SameText(lsFields[fno], 'msTimeStamp') then s2 :=
                s2 + GetFieldContent(qryGeneric3.Fields[fno], mtImport.Fields[integer(lsFields.Objects[fno])])
            else s2 := s2 + FormatDateTime('yyyymmddhhnnss', AppEnv.Branch.SentStamp) + ', ';
          end;
        Result := 'INSERT HIGH_PRIORITY INTO ' + tableName + ' (' + Copy(s1, 1,FastFuncs.StrLength(s1) - 2) + ') VALUES (' + Copy(s2, 1,
         FastFuncs.StrLength(s2) - 2) + ');';
      end; //makeInsertSQL

      function makeUpdateSQL: string;
        {qryGeneric3 holds (to be updated) record}
      var
        fno: integer;
        s1: string;
      begin
        Result := '';
        s1 := '';
        for fno := 0 to lsFields.Count - 1 do begin
          if lsFields.Objects[fno] <> Pointer(-1) then begin
            {exclude fields from comparing (tblmscalcFields}
            if qryGeneric3.Fields[fno].AsString <> mtImport.Fields[integer(lsFields.Objects[fno])].AsString then begin
              if not tblmsCalcFields.Locate('TableName;FieldName', VarArrayOf([tableName, lsFields[fno]]),
                [loCaseInsensitive]) and not FastFuncs.SameText(lsFields[fno], 'msTimeStamp') then begin
                {compare with qryGeneric3 and only update if different}
                s1 := s1 + lsFields[fno] + ' = ' + GetFieldContent(qryGeneric3.Fields[fno],
                  mtImport.Fields[integer(lsFields.Objects[fno])]);
              end;
            end;
          end;
        end;

        if (s1 > '') then begin
          { Include msTimeStamp so that it's value doesn't change}
          s1     := s1 + 'msTimeStamp = "' + FormatDateTime('yyyymmddhhnnss', AppEnv.Branch.SentStamp) + '"';
          Result := 'UPDATE ' + tableName + ' SET ' + s1 + ' WHERE GlobalRef = "' + GR + '";';
        end;
      end; //makeUpdateSQL

      procedure DeleteDetailRecords(const TableName, GR: string);
      var
        BulkSQL: TStrings;
        pk: string;
      begin
        // delete detail records if table in tblMasterDetails.MasterTableName
        //   (all detail records were imported if a master was edited )
        BulkSQL := TStringList.Create;
        try
          tblMsMasterDetails.Filter   := 'MasterTableName = ''' + tableName + '''';
          tblMsMasterDetails.Filtered := true;
          if tblMsMasterDetails.RecordCount > 0 then begin
            BulkSQL.Clear;
            tblMsMasterDetails.First;
            pk := DB.GetPrimaryKey(TableName);
            while not tblMsMasterDetails.Eof do begin
              BulkSQL.Add(Format('DELETE %s FROM %s AS td ' + 'INNER JOIN %s AS tm ON td.%s = tm.%s ' +
                'WHERE tm.GlobalRef = "%s";',
                [tblMsMasterDetailsDetailsTableName.AsString,
                tblMsMasterDetailsDetailsTableName.AsString,
                TableName,
                tblMsMasterDetailsMasterFieldName.AsString,
                pk,
                GR]));
              Application.ProcessMessages;
              tblMsMasterDetails.Next;
            end;
            MyScript1.SQL := BulkSQL;
            Application.ProcessMessages;
            //loglib.Log(MyScript1.SQL.TEXT+' 5','Multisite');
            MyScript1.Execute;
          end;
        finally
          FreeandNil(BulkSQL);
        end;
      end; //DeleteDetailRecords
    var
      op: string;
      timeStamp: TDateTime;
      conflictString: string;
    begin //updateAdd
      GR := mtImport.FieldByName('GlobalRef').AsString; //
      qryGeneric3.SQL.Text := 'SELECT * FROM ' + tableName + ' WHERE GlobalRef = "' + GR + '";';
      try
        qryGeneric3.Open;
        try
          if qryGeneric3.RecordCount = 0 then begin
            op := 'Insert';
            MyCommand1.SQL.Text := makeInsertSQL;
            DeleteDetailRecords(tableName, GR);
            //loglib.Log(MyCommand1.SQL.Text+' 6','Multisite');
            MyCommand1.Execute;
            if MyCommand1.RowsAffected <> 1 then SendGuiMsg(msgToLog, Format('Error: %s UpdateAdd  op %s failed',
                [tableName, op]), '', true);
          end else if not FastFuncs.SameText(tableName, 'tblmsbackendid') then begin
            op := 'Update';
            qryGeneric2.Close;
            MyCommand1.SQL.Text := makeUpdateSQL;
            if MyCommand1.SQL.Text > '' then begin
              // only if records differ
              timeStamp := qryGeneric3.FieldByName('msTimeStamp').AsDateTime;
              qryGeneric2.SQL.Text :=
                'SELECT * FROM tblmsedited WHERE EditedGlobalRef = "' + GR + '" ' + 'AND SiteCode = "' + aSiteCode + '";';
              qryGeneric2.Open;
              if (timeStamp > AppEnv.Branch.SentStamp) or (qryGeneric2.RecordCount > 0) then begin
                // check if records differ. if so: notify conflictTodoUserId
                qryGeneric2.Close;
                conflictString := '';
                if timeStamp > AppEnv.Branch.SentStamp then conflictString :=
                    Format(#13#10'msTimeStamp: %s'#13#10'lastSent   : %s ', [FormatDateTime('yyyymmdd hh:mm:ss', timeStamp),
                    FormatDateTime('yyyymmdd hh:mm:ss', AppEnv.Branch.SentStamp)]);
                Insert(Format('Conflict from %s  %s %s', [aSiteCode, tableName, GR]),
                  conflictString, 0);
                SendGuiMsg(msgToLog, conflictString, '', true);
                msUtils.MSLogAddConflict(aSiteCode, tableName, GR, '', timeStamp);
              end else begin
                DeleteDetailRecords(tableName, GR);
                //loglib.Log(MyCommand1.SQL.Text+' 7','Multisite');
                MyCommand1.Execute;
                if MyCommand1.RowsAffected <> 1 then SendGuiMsg(msgToLog, Format('Error: %s - %s GR %s failed',
                    [tableName, op, GR]), '', true);
              end;
            end;
          end;
        except
          on E: Exception do SendGuiMsg(msgToLog, Format('%s Error: %s Table: %s GlobalRef: %s',
              [op, E.Message, tableName, GR]), 'Courier New', true);
        end;
      finally
        qryGeneric3.Close;
      end;
    end; //updateAdd
         { procedure UpdateTable(tableName: String) }
  var
    i: integer;
    pk, fn: string;
    lsFields: TStringList;
    fld: TField;
    t: cardinal;
  begin
    lsFields := TStringList.Create; // lsFields: index represents Fields index of mtImport
    //            Objects[] represents Fields index of qryGeneric
    try

      if not TableExists(tableName) then Exit;

      // filter ref fields
      mtForeignKey.Filtered := false;
      mtForeignKey.Filter   := 'TableName = ''' + TableName + '''';
      mtForeignKey.Filtered := true;

      // prepare FieldList (see above)
      qryGeneric3.SQL.Text := 'SELECT * FROM ' // force population of Fields
        + tableName + ' WHERE GlobalRef = "xxx";';
      qryGeneric3.Open;
      pk := DB.GetPrimaryKey(tableName);
      for i := 0 to mtImport.FieldCount - 1 do lsFields.AddObject('', Pointer(-1)); // initialise to -1
      for i := 0 to mtImport.FieldCount - 1 do begin
        fn := mtImport.Fields[i].FieldName;
        if Copy(fn,FastFuncs.StrLength(fn) - 1, 2) = 'GR' then // reduce xxxxGR to xxxx
          System.Delete(fn,FastFuncs.StrLength(fn) - 1, 2);
        if fn <> pk then begin
          fld := qryGeneric3.FindField(fn);
          if fld = nil then SendGuiMsg(msgToLog, Format('Update: Field %s in table %s not found',
              [fn, tableName]), 'Courier New', true)
          else {if not FastFuncs.SameText( fn, 'msTimeStamp') then } 
          begin
            lsFields.Strings[i] := fn;
            lsFields.Objects[i] := Pointer(qryGeneric3.Fields.IndexOf(fld));
          end;
        end;
      end;
      qryGeneric3.Close;

      pbTable.Max     := mtImport.RecordCount;
      pbTable.Visible := true;

      // process each imported record
      mtImport.First;
      while not mtImport.Eof do begin
        pbTable.Position := mtImport.RecNo;
        Application.ProcessMessages;
        t := GetTickCount;

        // replace GlobalRefs in mtImport with local ID's
        // Note: the sender has ordered records in such a way
        // that records being referred to come first
        // (to ensure that 'replaceGR' finds that record on this site's db
        if mtForeignKey.RecordCount > 0 then replaceGR;
        t1 := t1 + (GetTickCount - t);
        t := GetTickCount;

        // add or update table
        updateAdd(lsFields);
        t2 := t2 + (GetTickCount - t);
        mtImport.Next;
      end;

    finally
      FreeandNil(lsFields);
      pbTable.Visible := false;
    end;
  end; //UpdateTable

  procedure PerformImport(const ArchiveIndex: integer);
  var
    tblFileName, tblName: string;
    p: integer;
    b1, b2, b3: boolean;
  begin
    inStream.Clear;
    tblFileName := AbZipKit.Items[ArchiveIndex].FileName;
    p := FastFuncs.PosEx('.', tblFileName);
    tblName := Copy(tblFileName, 1, p - 1);
    b1 := not tblMsDenySend.Locate('SiteCode;TableName', VarArrayOf(['*', tblName]), [loCaseInsensitive]);
    b2 := not tblMsDenyReceive.Locate('SiteCode;TableName', VarArrayOf(['*', tblName]), [loCaseInsensitive]);
    b3 := not tblMsDenyReceive.Locate('SiteCode;TableName', VarArrayOf([AppEnv.Branch.SiteCode, tblName]), [loCaseInsensitive]);
    if b1 and b2 and b3 then begin
      //    lbStatus.Caption := 'Updating ' + tblName;
      //    lbStatus.Refresh;
      ProgressTime1.Start('Updating ' + tblName + ' ');
      t := GetTickCount;
      inStream.Clear;
      Application.ProcessMessages;
      AbZipKit.ExtractToStream(tblFileName, inStream);
      Application.ProcessMessages;
      if inStream.Size > 0 then begin
        Application.ProcessMessages;
        inStream.Seek(0, soFromBeginning);
        mtImport.Reset;
        Application.ProcessMessages;
        mtImport.LoadFromStreamViaFormat(inStream, mtExport.DefaultFormat);
        Application.ProcessMessages;
        if FastFuncs.PosEx('tblmsbackendid', tblFileName) > 0 then begin
          if not mtImport.Locate('SiteCode', AppEnv.Branch.SiteCode, []) then begin
            SendGuiMsg(msgToLog, 'Received tblmsbackendid: no Entry for ' + AppEnv.Branch.SiteCode, '', true);
            Exit; //====> EXIT;
          end;
          SenderSynchDate := mtImport.FieldByName('ReceivedStamp').AsDateTime;
          SendGuiMsg(msgToLog, Format('Site %s last updated from %s %s',
            [aSiteCode, AppEnv.Branch.SiteCode,
            FormatDateTime('yyyy-mm-dd_hh:nn', SenderSynchDate)]),
            'Courier New', false);
        end;
        t1 := 0;
        t2 := 0;
        t3 := 0;
        // now update or add record
        UpdateTable(tblName);
        SendGuiMsg(msgToLog, Format('Updated: %-35s %6.0n  %5.1n %5.1n %5.1n ',
          [Copy(tblName, 4, 100), 0.0 + mtImport.RecordCount,
        (t1) / 1000.0, (t2) / 1000.0, (t3) / 1000.0]),
          'Courier New', false);
        mtImport.Close;
      end;
    end;
  end; //PerformImport

  function ExpectedFileNo: string;
  begin
    Result := Format('%0.6d', [tblMsBackendIdReceivedID.AsInteger + 1]);
    WantedFileName := FastFuncs.LowerCase(CommonDbLib.GetSharedMyDacConnection.Database) + 'Delta_' + aSiteCode + Result + '*.*';
    SendGuiMsg(msgStatus, 'Attempting to update from ' + WantedFileName, '', false);
  end; //ExpectedFileNo
var
  done: boolean;
begin //ProcessReceive()
  Screen.Cursor := crHourGlass;
  slFiles := TStringList.Create;
  try
    inStream := TMemoryStream.Create;
    try
      SetCurrentDir(MULTISITEPATH);
      AbZipKit.BaseDirectory := GetCurrentDir;
      tblMsBackendId.First;
      while not tblMsBackendId.Eof do begin // for each site <> this look for delta
        aSiteCode := tblMsBackendIdSiteCode.AsString;
        if aSiteCode <> AppEnv.Branch.SiteCode then begin
          // get all filenames filtered by aSiteCode
          SearchFileName := FastFuncs.LowerCase(CommonDbLib.GetSharedMyDacConnection.Database) + 'Delta_' + aSiteCode + '*.*';
          repeat
            done := true;
            slFiles.Clear;
            FindInCurrentDir(SearchFileName, slFiles);
            slFiles.Sort;
            nextFileNo := ExpectedFileNo;
            SenderSynchDate := 0.0;

            for fileCount := 0 to slFiles.Count - 1 do if FastFuncs.PosEx(nextFileNo + '_', slFiles[fileCount]) > 0 then
              begin // expected File found
                DeltaFileName := slFiles[fileCount];
                SendGuiMsg(msgStatus, 'Updating from ' + DeltaFileName, '', false);
                // delta file can be *.zip or *.enc (encrypted)
                if ExtractFileExt(DeltaFileName) = '.zip' then ZipFileName := GetCurrentDir + '\' + DeltaFileName
                else with TLbBlowFish.Create(Self) do begin
                    GenerateKey(KEYPHRASE);
                    ZipFileName := ChangeFileExt(ExpandFileName(DeltaFileName), '.zip');
                    DecryptFile(DeltaFileName, ZipFileName);
                  end;
                AbZipKit.OpenArchive(ZipFileName);
                SendProgressMaximum(AbZipKit.Count);

                for ix := 0 to AbZipKit.Count - 1 do {// each file in archive} 
                begin
                  SendProgressPosition(ix);
                  PerformImport(ix); // extract end process

                  if SenderSynchDate > 0.0 then {// we rely on tblmsbackendid being first} 
                  begin // in archive
                    MyCommand1.SQL.Text :=
                      'DELETE FROM tblmsedited ' + 'WHERE SiteCode = "' + aSiteCode + '" ' +
                      'AND SentStamp <= "' + FormatDateTime('yyyy-mm-dd hh:nn', SenderSynchDate) + ':00";';
                    //loglib.Log(MyCommand1.SQL.Text+' 8','Multisite');
                    MyCommand1.Execute;
                    SenderSynchDate := 0.0;
                  end;
                end;
                AbZipKit.CloseArchive;

                msUtils.MSLogAddReceived(aSiteCode, 'OK File="' + ExtractFileName(ZipFileName) + '"');
                DeleteFile(ZipFileName);
                if FileExists(DeltaFileName) then // in case it was encrypted
                  DeleteFile(DeltaFileName);      // delete this one as well
                MyCommand1.SQL.Text :=
                  'UPDATE tblmsbackendid SET ' + 'ReceivedID = "' + nextFileNo +
                  '", ReceivedStamp = CURRENT_TIMESTAMP ' + 'WHERE SiteCode = "' + aSiteCode + '";';
                //loglib.Log(MyCommand1.SQL.Text+' 9','Multisite');
                MyCommand1.Execute;
                //              while MyCommand1.Executing do
                //                Application.ProcessMessages;
                tblMsBackendId.Refresh;
                done := false; // did this - lets check for next
                RefreshStatus;
                nextFileNo := ExpectedFileNo;
              end;
          until done or (slFiles.Count = 0);
        end;
        tblMsBackendId.Next;
        SendGuiMsg(msgStatus, 'Updating Done from ' + aSiteCode, '', false);
      end;
    finally
      SendGuiMsg(msgStatus, 'Updating Done', '', false);
      if WrittenToLogFile then msUtils.AddToDoByFormAccessRight(Self.ClassName,
          'Multisite Error at ' + AppEnv.Branch.SiteDesc + '(' + FormatDateTime('hh:nn:ss',
          Time) + ').'#13#10 + 'Please check and clear file: ' + LOGSPATH + LOGFILENAME + '_' + GetCompanyName +
          '_' + AppEnv.Employee.LogonName + '.log', Date);
      SendProgressMaximum(0);
      FreeandNil(inStream);
    end;
  finally
    FreeandNil(slFiles);
    Screen.Cursor := crDefault;
  end;
end; //ProcessReceive

procedure TMultiSiteGUI2.btnReceiveClick(Sender: TObject);
  {$IFNDEF DevMode}
var
  sle: TStringList;
  params: string;
  TMBackup: TMTUseServicesProgressForm;
  {$ENDIF}
begin
  // (automatically) backup database
  {$IFNDEF DevMode}
  sle := TStringList.Create;
  try
    TMBackup := TMTUseServicesProgressForm.Create(Self);
    with TMBackup do begin
      try
        if not Connect(CommonDbLib.GetSharedMyDacConnection.Server,
                       CommonDbLib.GetSharedMyDacConnection.Username,
                       CommonDbLib.GetSharedMyDacConnection.Password, CommonDbLib.GetSharedMyDacConnection.Port) then begin
          CommonLib.MessageDlgXP_Vista('Services connection failed', mtError, [mbOK], 0);
          Exit;
        end else begin
          params := 'BACKUP ' + CommonDbLib.GetSharedMyDacConnection.Database + ' ' +
            CommonDbLib.GetSharedMyDacConnection.UserName + ' ' + CommonDbLib.GetSharedMyDacConnection.Password;
          if not Exec('BACKUP IN PROGRESS', 'BackupManager.exe', params, sle) then begin
            CommonLib.MessageDlgXP_Vista('Backup failed', mtError, [mbOK], 0);
            Exit;
          end;
        end;
      finally
        FreeAndNil(TMBackup);
      end;
    end;
  finally
    //If Assigned(sle) then sle.Free; //Middle Tier
  end;
  {$ENDIF}

  SetControlFocus(reLog);
  sbImport.Enabled := false;
  sbExport.Enabled := false;
  bbSave.Enabled := false;
  try
    ProgressTime1.Visible := true;
    ProgressTime1.Active  := true;
    ProcessReceive;
  finally
    ProgressTime1.Enabled := false;
    ProgressTime1.Active  := false;
    bbSave.Enabled        := true;
    RefreshStatus;
  end;
end;

procedure TMultiSiteGUI2.btnReceiveMailClick(Sender: TObject);
var
  targetFolder: string;
  FileName, tmpFileName: string;
  MsgCount, i, p, mailcount, suffix: integer;
begin
  SetCurrentDir(ExtractFilePath(ParamStr(0)));
  p := FastFuncs.PosEx('@', AppEnv.Branch.EmailAddressData);
  if p < 1 then begin
    Exit;
  end;;
  mailcount := 0;
  targetFolder := MULTISITEPATH;
  Screen.Cursor := crHourGlass;

  ProgressTime1.Start('Receiving Email Attachments ');
  try
    POP3.Host     := AppEnv.CompanyPrefs.EmailPOPHost;
    POP3.Port     := AppEnv.CompanyPrefs.EmailPOPPort;
    POP3.Username := AppEnv.Branch.EmailUserName;
    POP3.Password := AppEnv.Branch.EmailPassword;
    try
      POP3.Connect;
    except
      on E: Exception do begin
        CommonLib.MessageDlgXP_Vista('Error: ' + E.Message + #13 + #10 + 'Connection to POP server Timed out.' + #13 + #10 + #13 + #10 +
          'Check Username,Password and POP3 Settings.  ', mtWarning, [mbOK], 0);
        ProgressTime1.Stop('', clGreen);
        Exit;
      end;
    end;
    MsgCount := POP3.CheckMessages;
    for i := 1 to MsgCount do begin
      MailMessage.Clear;
      POP3.RetrieveHeader(i, MailMessage);
      if FastFuncs.PosEx('Platinum1 Multisite Update from Store ', MailMessage.Subject) = 1 then begin
        Inc(mailcount);
        SendGuiMsg(msgToLog, 'Retrieving "' + MailMessage.Subject + '"', 'Courier New', false);
        POP3.Retrieve(i, MailMessage);
        for p := 0 to MailMessage.MessageParts.Count - 1 do if MailMessage.MessageParts.Items[p] is TidAttachment then begin
            FileName := TidAttachment(MailMessage.MessageParts.Items[p]).FileName;
            tmpFileName := targetFolder + ExtractFileName(FileName);
            suffix := 0;
            while FileExists(tmpFileName) do begin
              Inc(suffix);
              tmpFileName := targetFolder + ExtractFileName(FileName) + Format('_%0.2d', [suffix]);
            end;
            TidAttachment(MailMessage.MessageParts.Items[p]).SaveToFile(tmpFileName);
            SendGuiMsg(msgToLog, 'Saved "' + tmpFileName + '"', 'Courier New', false);
          end;
      end else SendGuiMsg(msgToLog, Format('other email deleted: %s',
          [MailMessage.Subject]), '', false);
      POP3.Delete(i);
    end;

    //    MsgWaitForSingleObject(SpawnProcess('.\Scripts\Rebol -qs .\Scripts\receivedelta.r '
    //      + SenderEmail + ' ' + targetFolder ).hProcess);
    if mailcount > 0 then ProgressTime1.Stop('Mail Received (' + FastFuncs.IntToStr(mailcount) + ') ', clGreen)
    else ProgressTime1.Stop('No Mail Available ', clGreen);
  finally
    POP3.Disconnect;
    ProgressTime1.Active := false;
    //    lbStatus.Caption := 'Received Email';
    Screen.Cursor := crDefault;
    RefreshStatus;
  end;
end; //btnReceiveMailClick

// -----------------------------------------------------------------------------

procedure TMultiSiteGUI2.SendGuiMsg(const Kind: TGuiMsgType; const atxt, afont: string; const isError: boolean);
var
  guiData: TGuiData;
begin
  guiData := TGuiData.Create;
  GuiData.txt := atxt;
  GuiData.Font := afont;
  GuiData.isError := isError;
  PostMessage(self.Handle, GUI_MSG, Ord(Kind), integer(GUIData));
  Application.ProcessMessages;
end;

procedure TMultiSiteGUI2.SendProgressMaximum(const Maximum: integer);
begin
  PostMessage(self.Handle, GUI_MSG, 3, Maximum);
end;

procedure TMultiSiteGUI2.SendProgressPosition(const Position: integer);
begin
  PostMessage(self.Handle, GUI_MSG, 4, Position);
end;

procedure TMultiSiteGUI2.bbSaveClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TMultiSiteGUI2.GuiMsg(var msg: TMessage);
begin
  case msg.WParam of
    1: 
      begin
        with TGuiData(msg.LParam) do begin
          reLog.SelStart :=FastFuncs.StrLength(reLog.Text);
          reLog.SelLength := 0;
          if Font > '' then reLog.SelAttributes.Name := Font;
          if isError then begin
            reLog.SelAttributes.Color := clRed;
            {$I-}
            System.Writeln(logFile, FormatDateTime('yyyymmdd hh:nn ', Now), txt);
            {$I+}
            if IOResult = 0 then;

            WrittenToLogFile := true;
          end else reLog.SelAttributes.Color := clGreen;
          reLog.Lines.Add(txt);
          reLog.Perform(EM_LINEINDEX, reLog.Lines.Count - 1, 0);
        end;
        TGuiData(msg.LParam).Free;
      end;
    2: //lbStatus.Caption := tGuiData(msg.LParam).txt;
      ProgressTime1.Stop(tGuiData(msg.LParam).txt, clBlue);
    3: 
      begin
        pbDB.Max := msg.LParam;
        pbDB.Visible := msg.LParam > 0;
      end;
    4: pbDB.Position := msg.LParam;
  end;
end;

procedure TMultiSiteGUI2.btnNewMultisiteClick(Sender: TObject);
var
  TransactionTableObj: TTransactionTableObj;
  BatchState: boolean;
  tmpComponent: TComponent;
begin
  inherited;
  // Remove Connections
  if not MainForm.RemoveAllConnectionsToDB('TMultiSiteGUI2') then Exit;
  if not IsPosEOPDone() then begin
    CommonLib.MessageDlgXP_Vista('You must Complete the POS End-Of-Period before commencing a New Multisite', mtError, [mbOK], 0);
    Exit;
  end;
  //Remove Temp Table Data
  TransactionTableObj := TTransactionTableObj.Create;
  try
    BatchState := AppEnv.CompanyPrefs.UseBatchTransactions;
    AppEnv.CompanyPrefs.UseBatchTransactions := false;
    TransactionTableObj.CleanOutTempTables;
    AppEnv.CompanyPrefs.UseBatchTransactions := BatchState;
  finally
    FreeandNil(TransactionTableObj);
  end;
  Self.MyConnection.Disconnect;
  Self.MyConnection.Close;
  FreeAndNil(MyConnection);

  tmpComponent := GetComponentByClassName('TMultiSiteWizardGUI');
  If not Assigned(tmpComponent) then Exit;
  with TMultiSiteWizardGUI(tmpComponent) do begin
    Position  := poScreenCenter;
    FormStyle := fsNormal;
    ShowModal;
    if NewSiteGenerated > '' then begin
      CommonDbLib.GetSharedMyDacConnection.Connect;
      Self.tblMsCalcFields.Connection := CommonDbLib.GetSharedMyDacConnection;
      Self.tblMsDenySend.Connection := CommonDbLib.GetSharedMyDacConnection;
      Self.tblMsDenyReceive.Connection := CommonDbLib.GetSharedMyDacConnection;
      Self.tblmsForeignKey.Connection := CommonDbLib.GetSharedMyDacConnection;
      Self.tblMsMasterDetails.Connection := CommonDbLib.GetSharedMyDacConnection;
      Self.tblMsBackendId.Connection := CommonDbLib.GetSharedMyDacConnection;
      Self.qryGeneric.Connection := CommonDbLib.GetSharedMyDacConnection;
      Self.qryGeneric2.Connection := CommonDbLib.GetSharedMyDacConnection;
      Self.qryGeneric3.Connection := CommonDbLib.GetSharedMyDacConnection;
      Self.MyCommand1.Connection := CommonDbLib.GetSharedMyDacConnection;
      Self.MyScript1.Connection := CommonDbLib.GetSharedMyDacConnection;
      if Assigned(Self.msUtils) then FreeandNil(Self.msUtils);
      Self.msUtils := TmsUtils.Create(CommonDbLib.GetSharedMyDacConnection);
      Self.tblMsCalcFields.Open;
      Self.tblMsDenySend.Open;
      Self.tblMsDenyReceive.Open;
      Self.tblmsForeignKey.Open;
      Self.tblMsMasterDetails.Open;
      Self.tblMsBackendId.Open;

      // create Delta with only tblbackendid and send out
      SendBackendOnly := true;
      SendGuiMsg(msgStatus, 'Notifying all sites of New Multisite', '', false);
      btnSendClick(nil);
      SendBackendOnly := false;
    end;
  end;
end;

procedure TMultiSiteGUI2.lbArchiveClick(Sender: TObject);
begin
  RefreshStatus;
end;

procedure TMultiSiteGUI2.btnResendClick(Sender: TObject);
var
  emailAddress: string;
begin
  inherited;
  if tblmsBackendID.Locate('SiteCode', Copy(cbOtherSites.Text, 1, 3), []) then begin
    emailAddress := tblmsBackendIDEmailAddressData.AsString;
    ProgressTime1.Reset;
    ProgressTime1.Start('Sending Mail to ' + emailAddress + ' ');
    if SendEmail(emailAddress, MULTISITEPATH + '\Archive\' + lbArchive.Items[lbArchive.ItemIndex]) then
      ProgressTime1.Stop('Send Success', clGreen)
    else ProgressTime1.Stop('Send Failed', clRed);
  end else ProgressTime1.Stop('Invalid Site', clRed);
end;

procedure TMultiSiteGUI2.cbOtherSitesChange(Sender: TObject);
begin
  RefreshStatus;
end;

procedure TMultiSiteGUI2.PageControl1Change(Sender: TObject);
var
  sl: TStringList;
begin
  if PageControl1.ActivePageIndex = 3 then begin
    cbOtherSites.Items.Clear;
    tblmsBackendID.First;
    while not tblmsBackendID.Eof do begin
      if tblmsBackendIDBEDefault.AsString <> 'T' then cbOtherSites.Items.Add(tblmsBackendIDSiteCode.AsString + ' ' +
          tblmsBackendIDSiteDesc.AsString);
      tblmsBackendId.Next;
    end;

    SetCurrentDir(MULTISITEPATH + '\Archive\');
    sl := TStringList(lbArchive.Items);
    FindInCurrentDir(FastFuncs.LowerCase(CommonDbLib.GetSharedMyDacConnection.Database) + 'Delta_*.*', sl);
  end;
end;

function TMultiSiteGUI2.SendEmail(const recipient, AttachmentFileName: string): boolean;
var
  notes, subject: string;
  done: boolean;
begin
  Result := false;
  notes := 'Attached File: ' + ExtractFileName(AttachmentFileName);
  subject := 'Platinum1 Multisite Update from Store ' + AppEnv.Branch.SiteDesc;

  ProgressTime1.Start('Sending Delta as Email Attachment');
  SMTP.Host := AppEnv.CompanyPrefs.EmailSMTPHost;
  SMTP.Port := AppEnv.CompanyPrefs.EmailSMTPPort;
  MailMessage.Clear;
  try
    MailMessage.From.Address := AppEnv.Branch.EmailAddressData;
    MailMessage.Recipients.EMailAddresses := recipient;
    MailMessage.Subject      := subject;
    MailMessage.Body.Text    := 'Platinum1 Delta from: ' + AppEnv.Branch.EmailAddressData;
    TIdAttachment.Create(MailMessage.MessageParts, AttachmentFileName);
    MailMessage.ContentType := 'multipart/mixed';
    done := false;
    repeat
      try
        try
          SMTP.Connect(25000);
          SMTP.Send(MailMessage);
          Result := true;
        except 
          on E: Exception do begin
            done := CommonLib.MessageDlgXP_Vista('Error: ' + E.Message + #13 + #10 + 'Your Email preferences do not' + #13 +
              #10 + 'match your multi-site Email' + #13 + #10 + 'preferences. Adjust your Email' + #13 + #10 +
              'preferences in "Preferences".' + #13 + #10 + #13 + #10 + 'Send again?', mtWarning, [mbYes, mbCancel], 0) <> mrYes;
          end;
        end;
      finally
        if SMTP.Connected then SMTP.Disconnect;
      end;
    until Result or done;
  finally
    MailMessage.Clear;
  end;
end;

procedure TMultiSiteGUI2.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  reNewMultisiteHelp.Visible := not reNewMultisiteHelp.Visible;
end;

procedure TMultiSiteGUI2.EarlyExitTimerTimer(Sender: TObject);
begin
  inherited;
  Self.ModalResult := mrCancel;
  EarlyExitTimer.Enabled := false;
  Self.Close;
end;

procedure TMultiSiteGUI2.DetermineTablesToSend(UseMustSend: boolean = true);
var
  i: integer;
begin
  liTablesToSend.Clear;
  liTablesToSendNot.Clear;
  if not SendBackendOnly then begin
    for i := 0 to DB.Count - 1 do begin
      if UseMustSend then begin
        if (canSend(DB[i]) and mustSend(DB[i])) or (FastFuncs.SameText(DB[i], 'tblmsbackendid')) then begin
          liTablesToSend.Add(DB[i])
        end else begin
          liTablesToSendNot.Add(DB[i]);
        end;
      end else begin
        if canSend(DB[i]) or FastFuncs.SameText(DB[i], 'tblmsbackendid') then begin
          liTablesToSend.Add(DB[i])
        end else begin
          liTablesToSendNot.Add(DB[i]);
        end;
      end;
      Application.ProcessMessages;
    end
  end else begin
    liTablesToSend.Add('tblmsbackendid');
  end;
end; //DetermineTablesToSend

procedure TMultiSiteGUI2.VerifyGlobalRef;
var
  i: integer;
  sql: string;
begin
  for i := 0 to liTablesToSend.Count - 1 do begin
    if (DB.FindField(liTablesToSend[i], 'GlobalRef') < 0)      {or (DB.FindField(liTablesToSend[i], 'EditedFlag') < 0)} then
      SendGuiMsg(msgToLog, 'Missing "GlobalRef" in ' + liTablesToSend[i], '', true)
      // ensure empty GlobalRef is set
    else begin
      sql := 'UPDATE ' + liTablesToSend[i] + ' SET GlobalRef = CONCAT_WS("",' + QuotedStr(AppEnv.Branch.SiteCode)
        + ',' + DB.GetPrimaryKey(liTablesToSend[i]) + ') Where Length(GlobalRef)<=0 OR IsNull(GlobalRef) OR GlobalRef="0";';
      MyCommand1.SQL.Text := sql;
      Application.ProcessMessages;
      try
        //loglib.Log(MyCommand1.SQL.Text+' 10','Multisite');
        MyCommand1.Execute(1);
      except
      end;
      Application.ProcessMessages;
    end;
  end;
end; //VerifyGlobalRef;

procedure TMultiSiteGUI2.VerifyTimeStamps;
var
  i: integer;
  Save_Cursor: TCursor;
begin
  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass; { Show hourglass cursor }
  try
    for i := 0 to liTablesToSend.Count - 1 do begin
      if (DB.FindField(liTablesToSend[i], 'msTimeStamp') < 0) then begin
        SendGuiMsg(msgToLog, 'Missing "TimeStamp" in ' + DB[i], '', false);
        // alter table to add a msTimeStamp field
        MyCommand1.SQL.Text := 'ALTER TABLE ' + liTablesToSend[i] + ' ADD msTimeStamp TIMESTAMP  ;';
        //loglib.Log(MyCommand1.SQL.Text+' 11','Multisite');
        MyCommand1.Execute(1);
      end;
      Application.ProcessMessages;
    end;
    FreeandNil(DB);
    DB := TDBTableInfo.Create(CommonDbLib.GetSharedMyDacConnection); // ensure all fields are known
  finally
    Screen.Cursor := Save_Cursor; { Always restore to normal }
  end;
end;

procedure TMultiSiteGUI2.Initialize_Tables_Flags;
begin
  SendGuiMsg(msgToLog, 'Initialization Started', '', false);
  DetermineTablesToSend(false);
  SendGuiMsg(msgToLog, '-> Verify GlobalRefs', '', false);
  VerifyGlobalRef;
  SendGuiMsg(msgToLog, '-> Verify TimeStamps', '', false);
  VerifyTimeStamps;
  SendGuiMsg(msgToLog, 'Initialization Completed.', '', false);
  reLog.Clear;
end;

function TMultiSiteGUI2.IsPosEOPDone: boolean;
var
  qry: TMyQuery;
begin
  Result := false;
  qry := TMyQuery.Create(Self);
  qry.Options.FlatBuffers := True;
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    with qry do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT SaleID FROM tblsales WHERE POS = "T" LIMIT 0,10 ');
      Open;
      if IsEmpty then begin
        Result := true;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TMultiSiteGUI2.MyScript1BeforeExecute(Sender: TObject; var SQL: string; var Omit: boolean);
begin
  inherited;
  Application.ProcessMessages;
end;

procedure TMultiSiteGUI2.MyCommand1AfterExecute(Sender: TObject; Result: boolean);
begin
  inherited;
  Application.ProcessMessages;
end;

procedure TMultiSiteGUI2.AbZipKitArchiveProgress(Sender: TObject; Progress: byte; var Abort: boolean);
begin
  inherited;
  Application.ProcessMessages;
end;

procedure TMultiSiteGUI2.AbZipKitArchiveItemProgress(Sender: TObject; Item: TAbArchiveItem;
  Progress: byte; var Abort: boolean);
begin
  inherited;
  Application.ProcessMessages;
end;

procedure TMultiSiteGUI2.POP3Work(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: integer);
begin
  inherited;
  Application.ProcessMessages;
end;

procedure TMultiSiteGUI2.POP3Status(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
begin
  inherited;
  Application.ProcessMessages;
end;

procedure TMultiSiteGUI2.SMTPStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
begin
  inherited;
  Application.ProcessMessages;
end;

procedure TMultiSiteGUI2.SMTPWork(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: integer);
begin
  inherited;
  Application.ProcessMessages;
end;

procedure TMultiSiteGUI2.sbViewLogClick(Sender: TObject);
begin
  inherited;
  if FileExists(LOGSPATH + LOGFILENAME + '_' + GetCompanyName + '_' + AppEnv.Employee.LogonName + '.log') then begin
    try
      ShellExecute(0, 'open', PChar(LOGSPATH + LOGFILENAME + '_' + GetCompanyName + '_' + AppEnv.Employee.LogonName + '.log'),
        nil, nil, sw_shownormal);
    except 
    end;
  end;
end;

function TMultiSiteGUI2.EncodeStr(const Str: string): string;
var
  Encoder: TIdEncoderMIME;
  SStream: TStringStream;
begin
  Encoder := TIdEncoderMIME.Create(nil);
  SStream := TStringStream.Create(Str);
  try
    Result := Encoder.Encode(SStream);
  finally
    FreeandNil(Encoder);
    FreeandNil(SStream);
  end;
end;

function TMultiSiteGUI2.DecodeStr(const Str: string): string;
var
  Decoder: TIdDecoderMIME;
  SStream: TStringStream;
begin
  Decoder := TIdDecoderMIME.Create(nil);
  SStream := TStringStream.Create('');
  try
    Decoder.DecodeToStream(Str, SStream);
    Result := SStream.DataString;
  finally
    FreeandNil(Decoder);
    FreeandNil(SStream);
  end;
end;

procedure TMultiSiteGUI2.CompressBlobStream(Dataset: TkbmCustomMemTable; UnCompressedStream, CompressedStream: TStream);
begin
  inherited;
  LZHCompressBlobStream(UnCompressedStream, CompressedStream);
end;

procedure TMultiSiteGUI2.DecompressBlobStream(Dataset: TkbmCustomMemTable; CompressedStream, DeCompressedStream: TStream);
begin
  inherited;
  LZHDeCompressBlobStream(CompressedStream, DeCompressedStream);
end;

procedure TMultiSiteGUI2.FormatSaveField(Sender: TObject; Field: TField; var Null: boolean; var Data: string);
begin
  inherited;
  Data := EncodeStr(Data);
end;

procedure TMultiSiteGUI2.FormatLoadField(Sender: TObject; Field: TField; var Null: boolean; var Data: string);
begin
  inherited;
  Data := DecodeStr(Data);
end;

procedure TMultiSiteGUI2.pnlTitleMouseDown(Sender: TObject;  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if (Shift = [ssShift, ssCtrl, ssLeft]) then begin
    KeyPressed := True;
  end else begin
    KeyPressed := false;
  end;
end;

procedure TMultiSiteGUI2.pnlTitleDblClick(Sender: TObject);
begin
  inherited;
  if KeyPressed then begin
    sbImport.Visible := True;
    sbExport.Visible := True;
    resolve.Visible := True;
  end;
end;

procedure TMultiSiteGUI2.resolveClick(Sender: TObject);
Var
  canSendDelta :Boolean;
begin
  inherited;
  OrderTablesToSend(canSendDelta);
  CommonLib.MessageDlgXP_Vista('Test Completed', mtWarning, [mbOK], 0)
end;

initialization
  RegisterClassOnce(TMultiSiteGUI2);
end.



