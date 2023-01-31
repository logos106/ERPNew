unit frmPhSupportLog;

{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 23/06/05  1.00.01 IJB  Modified UpdateTimerDisplay to only write to query if
                        it is active.
 29/06/05  1.00.02 BJ   Bug fixed : Open the form minimize then try to open again
                        force the user to Save/cancel the previous Call
                        before starting with a new call.
 13/07/05  1.00.03 DSP  Commented out SetFocus action on hidden cboCompany
                        component.
 19/09/05  1.00.04 DSP  Removed 'NotInList' event handlers for cboForm and
                        cboVersion.
 20/09/05  1.00.05 DSP  Setup a dummy event for the 'OnNotInList' event
                        handler for cboForm and cboVersion.                        
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,   ExtCtrls,
  DNMPanel, StdCtrls, wwdblook, DBCtrls, Mask, wwdbedit, ComCtrls,AdvOfficeStatusBar,
  wwriched, Wwdotdot, Wwdbcomb, wwdbdatetimepicker, Buttons, DNMSpeedButton, ImgList,
  DBAccess, MyAccess,ERPdbComponents, ppCtrls, ppDB, ppDBPipe, ppPrnabl, ppClass, ppBands,
  ppCache, ppComm, ppRelatv, ppProd, ppReport, ppDBJIT, ppStrtch, ppMemo,
  ppVar, ppTxPipe, DataState, MemDS, Menus, AdvMenus, OleCtrls, {VCSpell3,} Shader,
  frmAttachments, ERPDbLookupCombo ,BusObjBase,  busobjPhoneSupportLog,
  ProgressDialog, BaseListingForm, wwdbgrid, wwcheckbox, Grids, Wwdbigrd,
  CustomFieldOnGrid;

type

  TPhSupportLogGUI = class(TBaseInputGUI)
    qryCustomers: TERPQuery;
    Cus_contact1_Label: TLabel;
    cboCompany: TwwDBLookupCombo;
    dsLog: TDataSource;
    qryLog: TERPQuery;
    edtContact: TwwDBEdit;
    qryLogGlobalRef: TWideStringField;
    qryLogSupportLogID: TAutoIncField;
    qryLogClientID: TIntegerField;
    qryLogCompany: TWideStringField;
    qryLogEmployeeID: TIntegerField;
    qryLogDateCreated: TDateTimeField;
    qryLogForm: TWideStringField;
    qryLogIssue: TWideMemoField;
    qryLogType: TWideStringField;
    qryLogSolution: TWideMemoField;
    qryLogEditedFlag: TWideStringField;
    qryLogActive: TWideStringField;
    qryLogContact: TWideStringField;
    qryLogCallSecs: TIntegerField;
    qryLogCallTime: TWideStringField;
    qryLogFinished: TWideStringField;
    qryLogContactID: TIntegerField;
    qryLogVersion: TWideStringField;
    qryLogEnteredBy: TWideStringField;
    qryLogToEmployeeID: TIntegerField;
    qryLogFromEmployeeID: TIntegerField;
    qryLogFromDate: TDateTimeField;
    qryLogFromemployee: TStringField;
    qryClient: TERPQuery;
    dsClient: TDataSource;
    qryForms: TERPQuery;
    Bevel2: TBevel;
    lblCompany: TDBText;
    qryContacts: TERPQuery;
    qryClientClientID: TAutoIncField;
    qryClientCompany: TWideStringField;
    qryClientContact: TWideStringField;
    qryClientStreet: TWideStringField;
    qryClientSuburb: TWideStringField;
    qryClientState: TWideStringField;
    qryClientPostCode: TWideStringField;
    qryClientPhone: TWideStringField;
    qryClientAltPhone: TWideStringField;
    qryClientFaxNumber: TWideStringField;
    qryClientMobile: TWideStringField;
    qryClientEmail: TWideStringField;
    tmrTime: TTimer;
    imgPopup: TImageList;
    qryContactsContactID: TAutoIncField;
    qryContactsCompany: TWideStringField;
    qryContactsContact: TWideStringField;
    qryContactsStopCreditImage: TIntegerField;
    qryVersion: TERPQuery;
    qryClientRepName: TWideStringField;
    qryClientRepID: TIntegerField;
    Label13: TLabel;
    Label15: TLabel;
    DBEdit1: TDBEdit;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryEmployees: TERPQuery;
    qryEmployeesEmployeeName: TWideStringField;
    qryEmployeesEmployeeID: TIntegerField;
    qryContactsContactEmail: TWideStringField;
    qryClientStreet2: TWideStringField;
    qryClientStreet3: TWideStringField;
    qryClientCountry: TWideStringField;
    qryContactsStopCredit: TWideStringField;
    dsContacts: TDataSource;
    qryClientContactPH: TWideStringField;
    qryClientContactFax: TWideStringField;
    qryContactsContactPH: TWideStringField;
    qryContactsContactAddress: TWideStringField;
    qryContactsContactAddress2: TWideStringField;
    qryContactsContactAddress3: TWideStringField;
    qryContactsContactAltPH: TWideStringField;
    qryContactsContactMOB: TWideStringField;
    qryContactsContactCity: TWideStringField;
    qryContactsContactState: TWideStringField;
    qryContactsContactPcode: TWideStringField;
    qryContactsContactCountry: TWideStringField;
    qryContactsContactFax: TWideStringField;
    qryFromemployee: TERPQuery;
    qryFromemployeeEmployeeName: TWideStringField;
    qryFromemployeeEmployeeId: TIntegerField;

    qryContactsTeamviewerID: TWideStringField;
    QryPhoneSupporttype: TERPQuery;
    QryPhoneSupporttypeTypecode: TWideStringField;
    QryPhoneSupporttypeName: TWideStringField;
    QryPhoneSupporttypeDescription: TWideStringField;
    qryVersionTypecode: TWideStringField;
    qryVersionName: TWideStringField;
    qryVersionDescription: TWideStringField;
    PageControlMain: TPageControl;
    tsDetails: TTabSheet;
    pnlDetails: TDNMPanel;
    Bevel1: TBevel;
    cboContactX: TwwDBLookupCombo;
    btnNewContact: TDNMSpeedButton;
    Cus_address_Label: TLabel;
    lblAddress2: TLabel;
    lblAddress3: TLabel;
    Cus_city_sub_Label: TLabel;
    Cus_state_Label: TLabel;
    lblCountry: TLabel;
    edtAddress: TwwDBEdit;
    txtAddress2: TwwDBEdit;
    txtAddress3: TwwDBEdit;
    edtCity: TwwDBEdit;
    edtPostCode: TwwDBEdit;
    txtCountry: TwwDBEdit;
    Cus_Pcode_Label: TLabel;
    edtState: TwwDBEdit;
    Label6: TLabel;
    Label17: TLabel;
    Cus_Alt_PH_Label: TLabel;
    Label19: TLabel;
    edtPhone: TwwDBEdit;
    edtMobile: TwwDBEdit;
    edtAltPhone: TwwDBEdit;
    edtEmail: TwwDBEdit;
    wwDBEdit1: TwwDBEdit;
    DNMSpeedButton1: TDNMSpeedButton;
    btnTV: TDNMSpeedButton;
    Bevel3: TBevel;
    Label3: TLabel;
    cboModuleNAme: TERPDbLookupCombo;
    Label7: TLabel;
    cboForm: TwwDBLookupCombo;
    lblDateCreated: TDBText;
    Label4: TLabel;
    Bevel4: TBevel;
    Label10: TLabel;
    Label2: TLabel;
    edtTimer: TwwDBEdit;
    edtIssue: TDBMemo;
    Label16: TLabel;
    Label8: TLabel;
    cboToEmployeeID: TwwDBLookupCombo;
    lblFrom: TLabel;
    txtFromEmployee: TwwDBEdit;
    lblOn: TLabel;
    txtFromDate: TwwDBEdit;
    Label18: TLabel;
    edtSolution: TDBMemo;
    pnlAttachments: TPanel;
    Label5: TLabel;
    cboPhoneSupporttype: TwwDBLookupCombo;
    Label12: TLabel;
    cboVersion: TwwDBLookupCombo;
    Label11: TLabel;
    txtEnteredByEmp: TEdit;
    Label1: TLabel;
    lblRep: TDBText;
    Label14: TLabel;
    pgHistory: TTabSheet;
    pnlHistory: TDNMPanel;
    qryLogLines: TERPQuery;
    DNMSpeedButton2: TDNMSpeedButton;
    DNMPanel1: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnHold: TDNMSpeedButton;
    btnEmail: TDNMSpeedButton;
    btnRepair: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryLogLinesID: TIntegerField;
    qryLogLinesSupportID: TIntegerField;
    qryLogLinesDate: TDateTimeField;
    qryLogLinesEmployeeID: TIntegerField;
    qryLogLinesEmployeeName: TWideStringField;
    qryLogLinesAssignToID: TIntegerField;
    qryLogLinesAssignTo: TWideStringField;
    qryLogLinesmstimeStamp: TDateTimeField;
    qryLogLinesmsUpdateSiteCode: TWideStringField;
    qryLogLinesDeleted: TWideStringField;
    qryLogLinesActive: TWideStringField;
    qryLogLinesComments: TWideMemoField;
    QryStatus: TERPQuery;
    lblStatus: TLabel;
    cboCurrentStatus: TwwDBLookupCombo;
    qryLogStatus: TWideStringField;
    chkFinished: TwwCheckBox;
    btnTask: TDNMSpeedButton;
    qryLogTaskId: TIntegerField;
    qryContactsClientCode: TWideStringField;
    qryLogLinesIsFollowupCall: TWideStringField;
    Comments: TTabSheet;
    dsLogLines: TDataSource;
    Qryentered: TERPQuery;
    QryenteredEmployeeName: TWideStringField;
    QryenteredEmployeeID: TIntegerField;
    QryAssignTo: TERPQuery;
    WideStringField1: TWideStringField;
    IntegerField1: TIntegerField;
    DNMPanel2: TDNMPanel;
    grdTransactions: TwwDBGrid;
    cboEmployeeName: TwwDBLookupCombo;
    cboAssignTo: TwwDBLookupCombo;
    edtComments: TwwDBEdit;
    btnLineCustomFields: TDNMSpeedButton;
    qryLogLinesGlobalref: TWideStringField;
    qryLogLinesCustomField1: TWideStringCustField;
    qryLogLinesCustomField2: TWideStringCustField;
    qryLogLinesCustomField3: TWideStringCustField;
    qryLogLinesCustomField4: TWideStringCustField;
    qryLogLinesCustomField5: TWideStringCustField;
    qryLogLinesCustomField6: TWideStringCustField;
    qryLogLinesCustomField7: TWideStringCustField;
    qryLogLinesCustomField8: TWideStringCustField;
    qryLogLinesCustomField9: TWideStringCustField;
    qryLogLinesCustomField10: TWideStringCustField;
    btnEditContact: TDNMSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cboCompanyCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure RefreshCustomer;
    procedure btnSaveClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cboContactXNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure btnNewContactClick(Sender: TObject);
    procedure tmrTimeTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnHoldClick(Sender: TObject);
    procedure edtTimerExit(Sender: TObject);
    procedure cboContactXCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure btnEditContactClick(Sender: TObject);
    procedure cboContactXDblClick(Sender: TObject);
    procedure btnInvoiceClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure cboContactXExit(Sender: TObject);
    procedure qryContactsCalcFields(DataSet: TDataSet);
    procedure btnPrintClick(Sender: TObject);
    procedure cboContactXEnter(Sender: TObject);
    procedure edtIssueExit(Sender: TObject);
    procedure edtSolutionExit(Sender: TObject);
    procedure cboToEmployeeIDExit(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure btnRepairClick(Sender: TObject);
    procedure btnTVClick(Sender: TObject);
    procedure qryLogCalcFields(DataSet: TDataSet);
    procedure qryLogAfterOpen(DataSet: TDataSet);
    procedure qryLogAfterPost(DataSet: TDataSet);
    procedure cboModuleNAmeEnter(Sender: TObject);
    procedure cboModuleNAmeExit(Sender: TObject);
    procedure cboPhoneSupporttypeNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
    procedure cboPhoneSupporttypeDblClick(Sender: TObject);
    procedure cboVersionDblClick(Sender: TObject);
    procedure cboVersionNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
    procedure qryLogTypeChange(Sender: TField);
    procedure qryLogVersionChange(Sender: TField);
    procedure FormResize(Sender: TObject);
    procedure qryLogLinesBeforeOpen(DataSet: TDataSet);
    procedure DNMSpeedButton2Click(Sender: TObject);
    procedure cboCurrentStatusDblClick(Sender: TObject);
    procedure QryStatusBeforeOpen(DataSet: TDataSet);
    procedure cboCurrentStatusNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
    procedure FormDblClick(Sender: TObject);
    procedure btnTaskClick(Sender: TObject);
    procedure PageControlMainChange(Sender: TObject);
    procedure btnLineCustomFieldsClick(Sender: TObject);
    procedure PageControlMainChanging(Sender: TObject;
      var AllowChange: Boolean);

  private
    { Private declarations }
    iClientID: integer;
    iSecCtr: integer;
    bCallClosed: boolean;
    bCancelCall: boolean;
    InvoiceCall: boolean;
    bWasHeld: boolean;
    ShowPopupMessageOnce: boolean;
    iToEmployeeID: integer;
    fiContactId: Integer;
    fsNotes: String;
    fiEmployeeId: Integer;
    AttachmentForm          : TfmAttachments;
    HistoryListform: TBaseListingGUI;
    fShowHistory: boolean;
    NewTransStatus: string;
    fbCheckForMailAttachments:Boolean;
    CustomfieldonGrid: TCustomFieldonGrid;
    function SaveLog:Boolean;
    procedure UpdateTimerDisplay;


    function IsPopMessageRequired(ClientID: integer): boolean;
    function IsCustomerOK(iClientID: integer; bVerbose: boolean = true): boolean;
    procedure UpdateSecsInLog(const SupportLogID: integer);
    procedure SetToDoCompleted(AskQuestion: Boolean);
    procedure AddToDo;
    function CopytoRepair:Boolean;
    procedure SetNotes(const Value: String);
    function TeamViewerID: String;
    procedure InitAttachment;
    procedure SetUpHistoryList;
    procedure SendEmail(const MailTo: string);
    procedure DoOnGridDataSelect (Sender: TwwDbGrid);
    procedure DoOnBeforeShow(Sender: TObject);
    procedure DoSaveTask;
    procedure OncommentsPage;
    procedure BeforeShowCustomFieldList(Sender: TObject);
    procedure ApplyCustomFieldsSettings;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;

 public
    PhoneSupportLog :TPhoneSupportLog;
    Procedure UpdateMe; Override;
    Procedure UpdateMe(Const Cancelled: Boolean;Const aObject: TObject = Nil); Override;
    Property ContactID:Integer read fiContactId write fiContactId;
    Property Notes :String read fsNotes Write SetNotes;
    Property EmployeeId:Integer read fiEmployeeId write fiEmployeeId;
    property ShowHistory: boolean read fShowHistory write fShowHistory;
    Procedure LocateLine(Const LineID:Integer);
  end;

implementation

{$R *.dfm}
uses
  DNMExceptions,  FormFactory, DNMLib, frmContactFrm, DateUtils,
  CommonDbLib,   CommonLib, AppContextObj,
   AppEnvironment, ShellAPI, FastFuncs,
   AppHelpProcessorObj, AppVarsObj, frmLogmeInDetails,
  BusObjRepairs, CommonFormLib, BusObjClient, SystemLib,
  frmSupportModule , BusObjConst, BusObjToDo, frmSimpleTypes, tcconst,
  EmployeeAccesses, CorrespondenceObj, BusObjEmployee, BusObjEmailConfig,
  frmPhSupportLogComments, busobjSimpletypeActions, BusObjAttachment, TimedHint,
  BusObjTasks, ERPMessageTypes, EmailExtraUtils, frmCustomFieldList,
  BusObjCustomFields, frmDelayMessageDlg;

{ TPhSupportLogGUI }

procedure TPhSupportLogGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if tmrTime.Enabled then tmrTime.Enabled := false;
  CloseQueries;
  if not (fsModal in self.FormState) then
    Action := caFree;
end;

procedure TPhSupportLogGUI.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  Showcontrolhint(btnLineCustomFields , 'Choose to Add/Change Custom Fields.'+NL+
                                        'Custom Fields can be Viewed and Changed on the List on ''Comments'' Page');
  DisableForm;
  try
    if AppEnv.AccessLevels.GetEmployeeAccessLevel('TInvoiceGUI') > 5 then begin
      CommonLib.MessageDlgXP_Vista(Format('You don''t have high enough access to "%s" to use "%s".',
        [AppEnv.AccessLevels.GetFormDescription('TInvoiceGUI'),
        AppEnv.AccessLevels.GetFormDescription('TPhSupportLogGUI')]), mtInformation, [mbOK], 0);
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
      Exit;
    end;

    try
      inherited;

      GuiPrefs.DbGridElement[grdTransactions].RemoveFields('mstimeStamp,msUpdateSitecode,Id,supportId,EmployeeId,AssigntoID');

      ApplyCustomFieldsSettings;
      if qryLog.Active then begin
        if not bCancelCall then begin
          CommonLib.MessageDlgXP_Vista('Call is still Active !' + #13 + #10 + '' + #13 + #10 +
            'You Need To  '' Close Call ''  Or  '' Hold Call ''.', mtWarning, [mbOK], 0);
          if Self.WindowState = wsMinimized then Self.WindowState := wsNormal;
          Exit;
        end;
      end;

      // if keyid is -ve then keyid is the clientID (negated) a new log is required
      // ..for this client
      if KeyID < 0 then begin
        iClientID := Abs(KeyID);
        KeyID := 0;
      end else begin
        iClientID := 0;
      end;

      //qryLog.ParamByName('xSupportLogID').asInteger := KeyID;
      PhoneSupportLog.Load(KeyID);

      Setlength(QueryNamesNotToOpen, 2);
      QueryNamesNotToOpen[0] := 'qryClient';
      QueryNamesNotToOpen[1] := 'qryContacts';
      OpenQueries(QueryNamesNotToOpen);
      self.BeginTransaction;

      if KeyID <> 0 then begin
        // Existing log entry...
        iClientID := PhoneSupportLog.clientId;
        iSecCtr := PhoneSupportLog.CallSecs;
        bCallClosed := PhoneSupportLog.Finished;
        bWasHeld := not(PhoneSupportLog.Finished);
        iToEmployeeID := PhoneSupportLog.ToEmployeeID;
      end else begin
        PhoneSupportLog.New;
        PhoneSupportLog.PostDb;
        bCallClosed := false;
        iToEmployeeID := 0;
      end;

      UpdateTimerDisplay;

      RefreshCustomer;

      tmrTime.Enabled  := not bCallClosed;
      btnHold.Enabled  := not bCallClosed;
      edtTimer.Enabled := bCallClosed;
      btnSave.Enabled := CanSupportLogInvoice;



      // The generic dblclick replaces the local dblclick in baseinput.  We do
      // .. not want the generic one.  So we will put our's back.
      cboContactX.OnDblClick := cboContactXDblClick;


      if PhoneSupportLog.employeeId = 0 then PhoneSupportLog.employeeid :=AppEnv.Employee.EmployeeID;
      txtEnteredByEmp.Text := GetEmployeeName(PhoneSupportLog.employeeID);

      lblFrom.Visible         := PhoneSupportLog.EmployeeID<>0;
      txtFromEmployee.Visible := PhoneSupportLog.EmployeeID<>0;
      lblOn.Visible           := PhoneSupportLog.EmployeeID<>0;
      txtFromDate.Visible     := PhoneSupportLog.EmployeeID<>0;
      ShowPopupMessageOnce := false;
      RealignTabControl(PageControlMain,1);
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
    SetControlFocus(cboContactX);
  end;
end;

procedure TPhSupportLogGUI.cboCompanyCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  RefreshCustomer;
end;

procedure TPhSupportLogGUI.RefreshCustomer;
begin
  qryClient.Close;
  qryClient.ParamByName('xClientID').asInteger := iClientID;
  qryClient.Open;
  qryContacts.Close;
  qryContacts.ParamByName('xCusID').asInteger := iClientID;
  qryContacts.Open;
  if fiContactId <> 0 then begin
    if qryContacts.Locate('ContactID' ,fiContactId , []) then begin
      PhoneSupportLog.Contact :=qryContactscontact.asString;
      PhoneSupportLog.contactID:=qryContactscontactID.AsInteger;
    end;
  end
  else begin
    if qryLogContactID.AsInteger > 0 then
      qryContacts.Locate('ContactID' ,qryLogContactID.AsInteger , [])
  end;
  if fsNotes <> '' then PhoneSupportLog.Issue:= fsNotes;
  if fiEmployeeId <> 0 then
    if qryEmployees.Locate(qryEmployeesEmployeeID.fieldname ,fiEmployeeId , []) then
      PhoneSupportLog.EmployeeID :=fiEmployeeId;
  PhoneSupportLog.company := qryClient.FieldByName('Company').AsString;
  PhoneSupportLog.ClientID := qryClient.FieldByName('ClientID').AsInteger;
  if ShowHistory then begin
    if Assigned(HistoryListform) then begin
      HistoryListform.Free;
      HistoryListform := nil;
    end;
    CreateHistorylistform('TPhoneSupportLogListExpressGUI' ,Self, HistoryListform,'ClientID', IntToStr(qryClient.FieldByName('ClientID').AsInteger));
    SetUpHistoryList;
  end
  else begin
    self.pgHistory.TabVisible := false;
  end;
end;

procedure TPhSupportLogGUI.btnSaveClick(Sender: TObject);
var
  MailTo, Subject, Body: string;
  corres: TCorrespondenceGui;
  EmailConfig: TEmailConfig;
  lSilent, lSecret : boolean;

begin
  inherited;
    PhoneSupportLog.SupportType := cboPhoneSupporttype.text;
    PhoneSupportLog.postdb;
    PhoneSupportLog.Lines.postdb;
    if not(PhoneSupportLog.ValidateData) then exit;

    fbCheckForMailAttachments :=  CommonLib.MessageDlgXP_Vista('Would you like to send the attachments with this email?',mtConfirmation,[mbYes,mbNo],0) = mrYes ;

    if PhoneSupportLog.ToEmployeeID > 0 then begin
      MailTo := TEmployee.EmailForEmployeeID(PhoneSupportLog.ToEmployeeID);
      Subject := '"' + PhoneSupportLog.Company + '" Support call assigned to you';
      Body :=
        'Client: ' + PhoneSupportLog.Company + #13#10 +
        'Contact Person: ' + PhoneSupportLog.Contact + #13#10 +
        'Module: ' + PhoneSupportLog.Module + #13#10 +
        'Version: ' + PhoneSupportLog.Version + #13#10 +
        'Type: ' + PhoneSupportLog.SupportType + #13#10 +
        'Call Commenced: ' + DateTimeToStr(PhoneSupportLog.DateCreated) + #13#10 + #13#10 +
        'Issue:' + #13#10  + PhoneSupportLog.Issue + #13#10 + #13#10 +
        'Solution:' + #13#10  + PhoneSupportLog.Solution + #13#10 + #13#10 +
        'Comments:' + #13#10  + PhoneSupportLog.Comments + #13#10 + #13#10 +
        'Regards,' + #13#10 + AppEnv.Employee.EmployeeName;
      EmailConfig := nil;
      corres := TCorrespondenceGui.Create;
      try
        corres.RecipientList := MailTo;
        corres.Subject := Subject;
        corres.MessageText := Body;
        corres.EmployeeId := PhoneSupportLog.ToEmployeeID;
        if AppEnv.CompanyPrefs.UseSupportEmail then begin
          EmailConfig := TEmailConfig.CreateWithSharedConn(nil);
          EmailConfig.LoadSelect('EntityName = "Support"');
          corres.From := '"' + EmailConfig.EmailName + '"' + ' <' + EmailConfig.ReplyEmailAddress + '>';
          corres.EmailConfig := EmailConfig;
        end;
        //TAttachment.CheckForMailAttachments(Corres, 'tblphonesupportLog' ,  PhoneSupportLog.ID);
        //ReportAttachmentfiles := PrintTemplate.AddTemplateAttachments(Corres , GetTemplate(ReportToPrint));
        corres.CheckForMailAttachments := fbCheckForMailAttachments;
        corres.AttachmentTablename := 'tblphonesupportLog';
        corres.AttachmentTableID   := PhoneSupportLog.ID;

        if not EmailShortSendMode(lSilent, lSecret) then
          exit;

        if not corres.Execute(lSilent, lSecret) then begin
          if AppEnv.CompanyPrefs.UseSupportEmail then
            MessageDlgXP_Vista('Please check your email settings in Preferences > Appointments > Support Log Preferences > Email Config Button' , mtInformation, [mbOk], 0)
          else
            MessageDlgXP_Vista('Please check your email settings on the Employee Card > Address' , mtInformation, [mbOk], 0);
        end;
      finally
        corres.Free;
        EmailConfig.Free;
      end;
    end;
    {Dene wants to send an email to the customer always. The employee gets an email only when assign to is not blank}
    { send to client }
    if (PhoneSupportLog.contactId <> 0) and
        qryContacts.Locate('ContactID', PhoneSupportLog.contactId, [])
        and (qryContactsContactEmail.AsString <> '') then
      MailTo := qryContactsContactEmail.AsString
    else
      MailTo := qryClientEmail.AsString;
    SendEmail(MailTo);


    bCallClosed := true;
//    PhoneSupportLog.finished := True;
    if not SaveLog then exit;
    Application.ProcessMessages;
    if (fsModal in self.FormState) then begin
      KeyID := self.qryLogSupportLogID.AsInteger;
      ModalResult := mrOk;
    end
    else Close;
end;

function TPhSupportLogGUI.TeamViewerID:String;
var
  CustomerObj:Tcustomer;
  s:String;
begin
  result := '';
  if PhoneSupportLog.ClientID=0 then begin
    MessageDlgXP_Vista('Please select the Customer' , mtInformation, [mbOk], 0);
    Exit;
  end;

  CustomerObj:=Tcustomer.CreateWithNewConn(Self);
  try
    CustomerObj.load(PhoneSupportLog.clientId);
    if CustomerObj.count=0 then begin
      MessageDlgXP_Vista('Customer '+ PhoneSupportLog.Company+' Doesn''t Exists' , mtWarning, [mbOk], 0);
      Exit;
    end;

    {contact's TV Id}
    if PhoneSupportLog.ContactId <> 0 then begin
      try
        if CustomerObj.contacts.Locate(CustomerObj.contacts.IDFieldName ,PhoneSupportLog.ContactID, []) then begin
          if CustomerObj.contacts.TeamViewerID='' then begin
            if MessageDlgXP_Vista('Customer '+ PhoneSupportLog.Company+'''s Contact :' + PhoneSupportLog.contact +' Doesn''t Have The Team Viewer Id Specified. Do You Wish To Update the Teamviewer ID?' , mtconfirmation, [mbYes,mbNo], 0) = mrno then exit;
            if not CustomerObj.Userlock.Lock(CustomerObj.BusObjectTableName , CustomerObj.ID) then begin
              MessageDlgXP_Vista('It is not Possible to Update TeamViewer ID of  ' + CustomerObj.ClientName  +'''s Contact :' + PhoneSupportLog.Contact +'.' +chr(13) +chr(13) +
                                ReplaceStr(CustomerObj.userlock.LockMessage, 'this record' , 'Customer :' + CustomerObj.ClientName ) , mtWarning, [mbOk], 0);
              Exit;
            end;
            try
              s:= CustomerObj.contacts.teamviewerID;
              while true do begin
                if not InputQuery(CustomerObj.ClientName+'''s Contact :' + PhoneSupportLog.Contact ,'Teamviewer ID' ,s) then exit;
                if s= '' then exit
                else if (not(ISInteger(s)) or (StrToIntDef(s,0) = 0) or ((strtoInt(s)<10000000)) or (strtoInt(s) >999999999)) then
                  if MessageDlgXP_Vista('Teamviewer ID Entered (' +s+') is Invalid. Do you Wish to Re-Enter' , mtconfirmation, [mbYes,mbNo], 0) = mrno then exit else continue;
                CustomerObj.contacts.teamviewerID := s;
                CustomerObj.contacts.PostDB;
                break;
              end;
            finally
              CustomerObj.Userlock.UnLock(CustomerObj.BusObjectTableName , CustomerObj.ID);
            end;
          end;
        end;
      finally
        result :=CustomerObj.contacts.teamviewerID;
      end;
    end;
    if result <> '' then exit;

    {check and input customer's TV id}
    if CustomerObj.TeamViewerID='' then begin
      if MessageDlgXP_Vista('Customer '+ PhoneSupportLog.Company+' Doesn''t Have The Team Viewer Id Specified. Do You Wish To Update the Teamviewer ID?' , mtconfirmation, [mbYes,mbNo], 0) = mrno then exit;
      if not CustomerObj.Userlock.Lock(CustomerObj.BusObjectTableName , CustomerObj.ID) then begin
        MessageDlgXP_Vista('It is not Possible to Update TeamViewer ID of ' + CustomerObj.ClientName  +'.' +chr(13) +chr(13) +
                          ReplaceStr(CustomerObj.userlock.LockMessage, 'this record' , 'Customer :' + CustomerObj.ClientName ) , mtWarning, [mbOk], 0);
        Exit;
      end;
      try
        s:= CustomerObj.teamviewerID;
        while true do begin
          s:= Inputbox(CustomerObj.ClientName ,'Teamviewer ID' ,s);
          if s= '' then exit
          else if (not(ISInteger(s)) or ((strtoInt(s)<100000000)) or (strtoInt(s) >999999999)) then
            if MessageDlgXP_Vista('Teamviewer ID Entered (' +s+') is Invalid. Do you Wish to Re-Enter' , mtconfirmation, [mbYes,mbNo], 0) = mrno then exit else continue;
          CustomerObj.teamviewerID := s;
          CustomerObj.PostDB;
          break;
        end;
      finally
        CustomerObj.Userlock.UnLock(CustomerObj.BusObjectTableName , CustomerObj.ID);
      end;
    end;
    if CustomerObj.TeamViewerID='' then exit;

    result:=CustomerObj.TeamViewerID;
  finally
    Freeandnil(CustomerObj);
  end;
end;

procedure TPhSupportLogGUI.DoSaveTask;
var
  lTask : TTasks;
  lTaskId : integer;
  scr : TERPScript;
  qry : TERPQuery;
  sSubject : string;
  sDetails : string;
  lExisting : boolean;
begin

  if cboModuleName.Text = '' then
  begin
    MessageDlgXP_Vista('You Need To Set The Module To Create A Task', mtWarning, [mbOk], 0);
    exit;
  end;

  lTask := TTasks.Create(self);
  try
    lTask.Connection := TMyDacDataConnection.Create(lTask);
    lTask.Connection.Connection := MyConnection;
    lTask.Dataset.Connection := MyConnection;
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := lTask.DataSet.Connection;
      qry.SQL.Clear;

      sSubject := 'Support Log ' + qryLog.FieldByName('SupportLogId').AsString + ' Task';
      if qryLog.fieldByName('Issue').AsString <> '' then
          sDetails := qryLog.fieldByName('Issue').AsString
      else
        sDetails := 'Auto Created From Support Log ' + qryLog.FieldByName('SupportLogId').AsString;
      lExisting := PhoneSupportLog.TaskId > 0;
      if lExisting then
        lTask.Load(PhoneSupportLog.TaskId)
      else
        lTask.New;
      lTask.VersionNo := 'Pending';
      lTask.TaskType := ERPMESSAGE_FEATURE;
      //lTask.CustomerName := qryContacts.FieldByName('Contact').AsString;
      lTask.CustomerName := qryLogCompany.AsString;
      //lTask.Subject := sSubject;
      lTask.Subject := qryLogForm.AsString;
      lTask.Details := sSubject + #13#10 + sDetails;
      lTask.ClientCode := qryContacts.FieldByName('ClientCode').AsString;
      if not lExisting then
        lTask.TasksPages.New;
      if not SameTExt(lTask.TasksPages.PageName, cboModuleName.Text) then
        lTask.TasksPages.PageName := cboModuleName.Text;

      lTask.PostDb;
      lTaskId := lTask.Dataset.FieldByName('ID').AsInteger;
      PhoneSupportLog.TaskId := lTaskId;
      PhoneSupportLog.PostDb;
      scr := TERPScript.Create(nil);
      try
        scr.Connection := qry.Connection;
        scr.SQL.Text := 'delete from tblAttachments where TableName like "tblTasks" and TableId=' + IntToStr(lTaskId) + ';';
        if AttachmentForm.lvAttachments.Items.Count > 0 then
        begin
          // Copy attachments we already have in the table
          scr.SQL.Add('insert into tblattachments (TableName, TableId, Attachment, AttachmentName, Description, Active)');
          scr.SQL.Add('select "tblTasks",' + IntToStr(lTaskId)+ ', A.Attachment, A.AttachmentName, A.Description, A.Active');
          scr.SQL.Add('from tblAttachments A where A.AttachmentId in (select B.AttachmentId from tblAttachments B');
          scr.SQL.Add('where B.TableName="tblphonesupportlog" and B.TableId=' + IntToStr(PhoneSupportLog.ID) + ')');
        end;
        scr.Execute;
      finally
        scr.Free;
      end;
      try
      if not lTask.Save then
      begin
        MessageDlgXP_Vista('Failed To Create The Task', mtWarning, [mbOk], 0);
        exit;
      end
      else
      begin
        PhoneSupportLog.TaskId := lTaskId;
        PhoneSupportLog.PostDb;
      end;
      except
      on e:exception do
        MessageBox(0, Pchar(e.Message), 'iii', mb_ok);


      end;
    finally
      qry.ClosenFree;
    end;
  finally
    lTask.Free;
  end;

end;

procedure TPhSupportLogGUI.btnTVClick(Sender: TObject);
var
  s:String;
begin
  s:= TeamViewerID;
  if s='' then exit;

    {check for TV file}
  if not(FileExists(Appenv.companyprefs.TeamViewerPath +'\TeamViewer.exe')) then begin
      MessageDlgXP_Vista('Please Install Teamviewer.' , mtWarning, [mbok], 0) ;
      exit;
  end;


  s:= '"'+ Appenv.companyprefs.TeamViewerPath +'\TeamViewer.exe" -i '+s;
  ExecNewProcess(s, False);
end;

Function TPhSupportLogGUI.SaveLog:boolean;
begin
  try
    tmrTime.Enabled := false;
    PhoneSupportLog.Company := qryClient.FieldByName('Company').AsString;
    PhoneSupportLog.PostDB;

    if bCallClosed then begin
      PhoneSupportLog.CallSecs := SecondOfTheDay(StrToTime(PhoneSupportLog.CallTime));
    end else begin
      PhoneSupportLog.CallSecs:= iSecCtr;
    end;

    if (PhoneSupportLog.toemployeeId <> iToEmployeeID) and (PhoneSupportLog.toEmployeeId <> 0) then begin
      SetToDoCompleted(False);
      AddToDo;
      if iToEmployeeID <> 0 then begin
        PhoneSupportLog.FromEmployeeId := iToEmployeeID;
        PhoneSupportLog.fromDAte := now;
      (* end else begin
        PhoneSupportLog.FromEmployeeID:= AppEnv.Employee.EmployeeID;
        PhoneSupportLog.fromDAte := 0; *)
      end;



    end else if bCallClosed then
      SetToDoCompleted(True);

    Result := PhoneSupportLog.Save;
    if not result then exit;
    self.CommitTransaction;
    UpdateSecsInLog(PhoneSupportLog.ID);
    Notify;
  finally
    PhoneSupportLog.ResultStatus.Clear;
  end;
end;

procedure TPhSupportLogGUI.UpdateMe;
begin
  inherited;
  closedb(qryForms);
  OpenDb(qryForms);
end;

procedure TPhSupportLogGUI.UpdateMe(const Cancelled: Boolean;
  const aObject: TObject);
begin
  inherited;
  If Cancelled Then Begin
    If Assigned(fLastComboAccessed) Then Begin
      If qryForms.Locate('ModuleName', fLastComboAccessed.Text, []) Then else fLastComboAccessed.Text := '';
    End;
  End Else if fLastComboAccessed = cboModuleNAme Then Begin
        PhoneSupportLog.Module:= fLastComboAccessed.Text;
  end else begin
      if fLastComboAccessed = cboCurrentStatus then begin
        closenopendb(fLastComboAccessed.LookupTable);
        if fLastComboAccessed.LookupTable.Locate('Name', NewTransStatus, []) then begin
          PhoneSupportLog.Status := NewTransStatus;
          PhoneSupportLog.PostDB;
        end;
      end;

  End;


end;

procedure TPhSupportLogGUI.UpdateSecsInLog(const SupportLogID: integer);
var
  qryTemp: TERPCommand;
begin
  qryTemp := TERPCommand.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;

  try
    qryTemp.SQL.Clear;
    qryTemp.Sql.Add
    (
      'UPDATE tblphonesupportlog SET CallSecs= SUBSTRING_INDEX(CallTime, ":", 1)*3600 + SUBSTRING_INDEX(SUBSTRING_INDEX(CallTime, ":", 2),":",-1)*60 + SUBSTRING_INDEX(CallTime, ":", -1)');
    qryTemp.Sql.Add('WHERE SupportLogID=' + IntToStr(SupportLogID) + ';');    
    qryTemp.Execute;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TPhSupportLogGUI.btnNewClick(Sender: TObject);
begin
  inherited;
  SaveLog;
  KeyID := 0;
  FormShow(Sender);
end;

procedure TPhSupportLogGUI.ApplyCustomFieldsSettings;
begin
  CustomfieldonGrid := TCustomFieldonGrid.Create(Self,
    'CustomField1,CustomField2,CustomField3,CustomField4,CustomField5,CustomField6,CustomField7,CustomField8,CustomField9,CustomField10',
    ltSupportLines, grdTransactions, guiprefs, PhoneSupportLog.Lines);
  CustomfieldonGrid.ApplyCustomFieldsSettings;
end;

procedure TPhSupportLogGUI.BeforeShowCustomFieldList(Sender: TObject);
begin
  TfmCustomfieldList(Sender).ListType  := ltSupportLines;
end;

procedure TPhSupportLogGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  bCancelCall := true;
  tmrTime.Enabled := false;
  self.RollbackTransaction;
  if (fsModal in self.FormState) then ModalResult := mrCancel
  else Close;
end;


procedure TPhSupportLogGUI.cboContactXNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string;
  var Accept: boolean);
  { See btnNewContactClick for explanation of why genereic not-in-list doesn't work}
Var  frm: TfrmContact;
     sl: TStringList;
begin
  frm := TfrmContact(GetComponentByClassName('TfrmContact'));
 if Assigned(Frm) then begin
    frm.KeyID := 0;
//    frm.fiClientID := iClientID;
    frm.ClientID := iClientID;
    frm.Position := poScreenCenter;
    sl := TStringList.Create;
    sl.DelimitedText := NewValue;
    AppContext['TfrmContact'].VarByName['FirstName'] := sl.Strings[0];
    if sl.Count > 1 then
      AppContext['TfrmContact'].VarByName['LastName'] := sl.Strings[1];
    frm.ShowModal;
 end;
  qryContacts.Close;
  qryContacts.Open;
  if qryContacts.Locate('Contact', NewValue, [loCaseInsensitive]) then begin
    cboContactX.LookupValue := qryContacts.FieldByName('Contact').AsString;
  end;
end;

procedure TPhSupportLogGUI.cboCurrentStatusDblClick(Sender: TObject);
begin
  inherited;
  fLastComboAccessed := cboCurrentStatus;
  TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_PhSupportStatusType, PhoneSupportLog.Status,self);
end;

procedure TPhSupportLogGUI.cboCurrentStatusNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
    fLastComboAccessed := cboCurrentStatus;
    NewTransStatus     := cboCurrentStatus.Text;
    If CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtconfirmation, [mbyes, mbno], 0) = mrYes Then Begin
      TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_PhSupportStatusType, NewValue, Self);
    End;
    Accept := False;

end;

procedure TPhSupportLogGUI.cboPhoneSupporttypeDblClick(Sender: TObject);
begin
  inherited;
  TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_Phonesupporttype, PhoneSupportLog.supporttype);
end;

procedure TPhSupportLogGUI.cboPhoneSupporttypeNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtconfirmation, [mbyes, mbno], 0) = mrYes then begin
    TfmSimpleTypes.DoSimpleTypesAddNew(SimpleTypes_Phonesupporttype, NewValue);
    closenopendb(cboPhoneSupporttype.LookupTable);
    if cboPhoneSupporttype.LookupTable.Locate('Name', NewValue, []) then begin
           PhoneSupportLog.Supporttype :=NewValue;
           PhoneSupportLog.PostDB;
           Accept:= True;
    end else begin
      Accept:= False;
    end;
  end;
end;

procedure TPhSupportLogGUI.btnNewContactClick(Sender: TObject);
{ We need the button cuz we can't use the combo's generic 'Not in list' processing.
  Not-In-List doesn't work because the  contact is represented in the combo by a
  combination of their first & last name so there is no way of populating the
  the contact form on opening.
}
var
  //sNewContact: String;
  frm: TfrmContact;
begin
  inherited;
  frm := nil;
  try
    frm := TfrmContact(GetComponentByClassName('TfrmContact'));
    if Assigned(frm) then begin
//      frm.fiClientID := iClientID;
      frm.ClientID := iClientID;
      frm.Position := poScreenCenter;
      frm.ShowModal;
    end;  
  finally
    FreeandNil(frm);
  end;
  qryContacts.Close;
  qryContacts.Open;
  CommonLib.MessageDlgXP_Vista('Please Select New Contact', mtInformation, [mbOK], 0);
end;

procedure TPhSupportLogGUI.btnEditContactClick(Sender: TObject);
var
  frm: TfrmContact;
  iSavedID: integer;
begin
  inherited;
  iSavedID := qryContacts.FieldByName('ContactID').AsInteger;
  frm := nil;
  try

    frm := TfrmContact(GetComponentByClassName('TfrmContact'));
    if Assigned(Frm) then begin
      frm.KeyID := qryContacts.FieldByName('ContactID').AsInteger;
//      frm.fiClientID := iClientID;   // prevents it trying to go to the customer form on complete
      frm.ClientID := iClientID;   // prevents it trying to go to the customer form on complete
      frm.Position := poScreenCenter;
      frm.ShowModal;
    end;  
  finally
    FreeandNil(frm);
  end;
  qryContacts.Close;
  qryContacts.Open;
  if qryContacts.Locate('ContactID', iSavedID, [loCaseInsensitive]) then begin
    cboContactX.LookupValue := qryContacts.FieldByName('Contact').AsString;
  end;
  PhoneSupportLog.Contact := qryContacts.FieldByName('Contact').AsString;
end;

procedure TPhSupportLogGUI.tmrTimeTimer(Sender: TObject);
begin
  inherited;
  iSecCtr := iSecCtr + 1;
  UpdateTimerDisplay;
end;

procedure TPhSupportLogGUI.FormCreate(Sender: TObject);
begin
  AddPhoneCallbutton(edtPhone);
  AddPhoneCallbutton(edtMobile);
  AddPhoneCallbutton(edtAltPhone);
  AllowCustomiseGrid := true;
  inherited;
  fiContactId:=0;
  fsNotes := '';
  qryContacts.Connection:= CommonDbLib.GetSharedMyDacConnection;
  iSecCtr := 0;
  bCallClosed := false;
  bCancelCall := false;

  PhoneSupportLog := TPhoneSupportLog.create(self);
  PhoneSupportLog.connection := TMydacDataconnection.Create(PhoneSupportLog);
  PhoneSupportLog.Connection.Connection := Self.Myconnection;
  PhoneSupportLog.BusobjEvent := DoBusinessObjectEvent;
  fShowHistory := true;
end;

procedure TPhSupportLogGUI.FormDblClick(Sender: TObject);
var
  s:String;
begin
  {this is a shortcut for us to leave msg for mel when we receive phone calls }

  if (Sametext(Appenv.AppDb.Database , 'madeurne_pty_ltd')) or devmode then begin
    if PhoneSupportLog.Issue = '' then begin
         PhoneSupportLog.Module := 'Unknown';
         PhoneSupportLog.SupportType := 'Issue';
         PhoneSupportLog.Issue := 'Please Call ' + PhoneSupportLog.Contact;
         s:= 'Hollie Eames';
         AppContext.LoadFromfile;if AppContext[Self.classname].VarExists('ToEmployee') then s:= AppContext[Self.classname].VarByname['ToEmployee'];
         PhoneSupportLog.Solution := s;
         PhoneSupportLog.ToEmployeeName :=s;
         PhoneSupportLog.Status :='Open Support';
         PhoneSupportLog.PostDB;
         PhoneSupportLog.Version := '2017.0.0.0';
         s:=PhoneSupportLog.Issue;
         if not InputQuery('Issue' , '' ,   s) then exit;
         //PhoneSupportLog.issue := inputbox('Issue' , '' ,  ' Please call ' + PhoneSupportLog.Contact);
         PhoneSupportLog.issue := s;

         btnSave.click;
         exit;
    end;

end;
  inherited;
end;

procedure TPhSupportLogGUI.FormResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(PageControlMain,1);
end;

procedure TPhSupportLogGUI.btnHoldClick(Sender: TObject);
begin
  inherited;
  PhoneSupportLog.Supporttype := cboPhoneSupporttype.text;
  if SaveLog then begin
    if (fsModal in self.FormState) then begin
      KeyID := self.qryLogSupportLogID.AsInteger;
      ModalResult := mrOk;
    end
    else Close;
  end;
end;

procedure TPhSupportLogGUI.UpdateTimerDisplay;
var
  iSecs, iMins, iHrs: integer;
begin
  if qryLog.Active then begin
    iHrs  := iSecCtr div (60 * 60);
    iMins := (iSecCtr div (60)) mod 60;
    iSecs := iSecCtr mod 60;
    PhoneSupportLog.CallTime:= Format('%3.2d:%2.2d:%2.2d', [iHrs, iMins, iSecs]);
  end;
end;

procedure TPhSupportLogGUI.edtTimerExit(Sender: TObject);
begin
  inherited;
  try
    StrToTime(edtTimer.Text);
  except
    on EConvertError do begin
      CommonLib.MessageDlgXP_Vista('Not a valid Time: ' + edtTimer.Text,
        mtWarning, [mbOK], 0);
      SetControlFocus(edtTimer);
    end;
  end;
end;

procedure TPhSupportLogGUI.cboContactXCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  PhoneSupportLog.ContactID:= qryContacts.FieldByName('ContactID').AsInteger;
  qryClient.Locate('Contact',cboContactX.Text,[]);
  IsCustomerOK(iClientID);
  edtEmail.DataField := '';
  edtEmail.datasource:= dsContacts;
  edtEmail.DataField := 'ContactEmail';
end;

function TPhSupportLogGUI.IsCustomerOK(iClientID: integer; bVerbose: boolean = true): boolean;
begin
  Result := true;
  if AppEnv.CompanyPrefs.CreditCheckAppointment <> 'T' then Exit;
  if not IsCreditOk(iClientID, bVerbose) then Result := false;
  if result then if not IsTermsOk(iClientID, bVerbose) then Result := false;
end;

procedure TPhSupportLogGUI.cboContactXDblClick(Sender: TObject);
var
  //sNewContact: String;
  frm: TfrmContact;
  iSavedID: integer;
begin
  inherited;
  iSavedID := qryContacts.FieldByName('ContactID').AsInteger;
  frm := nil;
  try

    frm := TfrmContact(GetComponentByClassName('TfrmContact'));
    if Assigned(Frm) then begin
      frm.KeyID := qryContacts.FieldByName('ContactID').AsInteger;
//      frm.fiClientID := iClientID;   // prevents it trying to go to the customer form on complete
      frm.ClientID := iClientID;   // prevents it trying to go to the customer form on complete
      frm.Position := poScreenCenter;
      frm.ShowModal;
    end;  
  finally
    FreeandNil(frm);
  end;
  qryContacts.Close;
  qryContacts.Open;
  //  if qryContacts.Locate('ContactID', qryContacts.FieldByName('ContactID').AsString, []) then begin
  if qryContacts.Locate('ContactID', iSavedID, [loCaseInsensitive]) then begin
    cboContactX.LookupValue := qryContacts.FieldByName('Contact').AsString;
  end;
  PhoneSupportLog.Contact := qryContacts.FieldByName('Contact').AsString;
end;

procedure TPhSupportLogGUI.btnInvoiceClick(Sender: TObject);
begin
  inherited;
  InvoiceCall := true;
  If btnSave.Enabled Then
    btnSave.Click;
end;

procedure TPhSupportLogGUI.btnLineCustomFieldsClick(Sender: TObject);
begin
  if OpenERPFormModal('TfmCustomfieldList',0 , beforeshowCustomfieldList) >=0  then begin
//    CustomFieldValues.PopulateAll(CustomFieldValueMasterID);
//    qryCustomFieldList.Refresh;
//    CustomFieldValues.Dataset.Refresh;
  end;
end;

procedure TPhSupportLogGUI.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;

  if not bCancelCall then begin
    if tmrTime.Enabled then begin
      CanClose := false;
      CommonLib.MessageDlgXP_Vista('Call is still Active !' + #13 + #10 + '' + #13 + #10 + 'You Need To  '' Close Call ''  Or  '' Hold Call ''.',
        mtWarning, [mbOK], 0);
    end;
  end;
end;

function TPhSupportLogGUI.IsPopMessageRequired(ClientID: integer): boolean;
var
  qryTemp: TERPQuery;
begin
  if not AppEnv.CompanyPrefs.SupportPopupEnabled then begin
    Result := false;
    Exit;
  end;

  qryTemp := TERPQuery.Create(nil);
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;

  try
    qryTemp.Sql.Add('SELECT SupportLogID,Count(ClientID) as Calls ');
    qryTemp.Sql.Add('FROM `tblphonesupportlog` Where ClientID =' + IntToStr(ClientID) + ' ');
    qryTemp.Sql.Add('AND DateCreated Between (DATE_ADD(CURDATE(),INTERVAL -' +
      IntToStr(AppEnv.CompanyPrefs.SupportPeriodInDays) + ' Day)) ');
    qryTemp.Sql.Add('AND (DATE_ADD(CURDATE(),INTERVAL +1 Day)) ');
    qryTemp.Sql.Add('Group By ClientID;');
    qryTemp.Active := true;

    if not qryTemp.IsEmpty then begin
      if ((qryTemp.FieldByName('Calls').AsInteger + 1) >= (AppEnv.CompanyPrefs.SupportNoOfCalls)) then begin
        Result := true;
      end else begin
        Result := false;
      end;
    end else begin
      Result := false;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TPhSupportLogGUI.LocateLine(const LineID: Integer);
begin
  if PhoneSupportLog.Lines.Locate(PhoneSupportLog.Lines.IDfieldname, LineID, []) then
    PageControlMain.ActivePage := TTabSheet(Comments);
end;

procedure TPhSupportLogGUI.PageControlMainChange(Sender: TObject);
begin
  inherited;
    if (PageControlMain.ActivePage = TTabSheet(Comments)) then begin
      OncommentsPage;
    end;
end;

procedure TPhSupportLogGUI.PageControlMainChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
  if PageControlMain.ActivePage = Comments then begin
    PostDB(qryLogLines);
  end;
end;

procedure TPhSupportLogGUI.cboContactXExit(Sender: TObject);
begin
  inherited;
  //PopUp Message Test
  if IsPopMessageRequired(iClientID) and not ShowPopupMessageOnce then begin
    if AppEnv.CompanyPrefs.SupportPopupMessage <> '' then CommonLib.MessageDlgXP_Vista(AppEnv.CompanyPrefs.SupportPopupMessage, mtInformation, [mbOK], 0);
    ShowPopupMessageOnce := true;
  end;
end;

procedure TPhSupportLogGUI.qryContactsCalcFields(DataSet: TDataSet);
begin
  inherited;
  If qryContactsStopCredit.AsString = 'T' then
    qryContactsStopCreditImage.AsInteger := 0
  else
    qryContactsStopCreditImage.AsInteger := 1
end;

procedure TPhSupportLogGUI.btnPrintClick(Sender: TObject);
Var sSQL : string;
begin
  DisableForm;
  try

    PhoneSupportLog.postDB;
    fbReportSQLSupplied := true;
    sSQL :=        '{Main}SELECT * FROM tblphonesupportlog WHERE SupportLogID = ' + intToStr(PhoneSupportLog.ID);
    sSQL := sSQL + '~|||~ {ClientDetails}SELECT ';
    sSQL := sSQL + 'C.ClientID, C.Company As Company, CONCAT_WS(" ", C.Title,C.FirstName,C.LastName) as Contact, ';
    sSQL := sSQL + 'C.Street, C.Suburb, C.State, C.PostCode, C.Phone, C.AltPhone, C.FaxNumber, C.Mobile, C.Email, ';
    sSQL := sSQL + 'E.EmployeeName AS RepName, C.RepID ';
    sSQL := sSQL + 'FROM tblClients C ';
    sSQL := sSQL + 'LEFT JOIN tblemployees E ON RepID=EmployeeID ';
    sSQL := sSQL + 'WHERE C.ClientID = ' + qryClientClientID.AsString;
    sSQL := sSQL + '~|||~{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2,  ';
    sSQL := sSQL + 'CO.City, CO.State, CO.Postcode, Concat("Phone  ",CO.PhoneNumber) AS PhoneNumber,  ';
    sSQL := sSQL + 'Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN FROM     tblCompanyInformation AS CO ';

    PrintTemplateReport('Phone Support Log', sSQL, false, 1);
    fbReportSQLSupplied := false;
  finally
    EnableForm;
  end;  
end;

procedure TPhSupportLogGUI.btnRepairClick(Sender: TObject);
begin
  inherited;
    PhoneSupportLog.Supporttype := cboPhoneSupporttype.text;
    if not(PhoneSupportLog.ValidateData) then exit;
    bCallClosed := true;
    PhoneSupportLog.finished := True;
    if not SaveLog then exit;
    Application.ProcessMessages;
    if CopytoRepair then begin
      if (fsModal in self.FormState) then begin
        KeyID := self.qryLogSupportLogID.AsInteger;
        ModalResult := mrOk;
      end
      else Close;
    end;
end;

procedure TPhSupportLogGUI.qryLogAfterOpen(DataSet: TDataSet);
begin
  inherited;
  InitAttachment;
end;

procedure TPhSupportLogGUI.qryLogAfterPost(DataSet: TDataSet);
begin
  inherited;
  initAttachment;
end;

procedure TPhSupportLogGUI.qryLogCalcFields(DataSet: TDataSet);
begin
  qryLogEnteredBy.asString := txtEnteredByEmp.Text;
end;

procedure TPhSupportLogGUI.qryLogLinesBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryLogLines.Filter := 'Deleted = ''F'' ';
  qryLogLines.filtered := True;
end;

procedure TPhSupportLogGUI.qryLogTypeChange(Sender: TField);
begin
  inherited;
  qryPhoneSupportType.ParamByName('xName').AsString:= Sender.AsString;
end;

procedure TPhSupportLogGUI.qryLogVersionChange(Sender: TField);
begin
  inherited;
  qryVersion.ParamByName('xName').AsString:= Sender.AsString;
end;

procedure TPhSupportLogGUI.QryStatusBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  QryStatus.parambyname('TransStatustype').AsString := SimpleTypes_PhSupportStatusType;
  QryStatus.parambyname('SelectedStatus').AsString  := PhoneSupportLog.Status;

end;

procedure TPhSupportLogGUI.cboContactXEnter(Sender: TObject);
begin
  inherited;
  {if the lookup table is closed, open the table}
  with cboContactX.LookupTable do if Active = false then Open;
end;

procedure TPhSupportLogGUI.cboModuleNAmeEnter(Sender: TObject);
begin
  inherited;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
end;

procedure TPhSupportLogGUI.cboModuleNAmeExit(Sender: TObject);
begin
  inherited;
  fLastComboAccessed := nil;
end;

procedure TPhSupportLogGUI.edtIssueExit(Sender: TObject);
begin
  inherited;
  //SpellCheckerMemo(edtIssue);
end;

procedure TPhSupportLogGUI.edtSolutionExit(Sender: TObject);
begin
  inherited;
 // SpellCheckerMemo(edtSolution);
end;

procedure TPhSupportLogGUI.cboToEmployeeIDExit(Sender: TObject);
begin
  if cboToEmployeeID.Text = '' then begin
    if PhoneSupportLog.ToEmployeeID  <> 0 then begin
      PhoneSupportLog.ToEmployeeID := 0;
      PhoneSupportLog.PostDB;
      ShowTimedHint(cboToEmployeeID ,'This call is not assigned to Anyone Anymore.', true , 5000);
    end;
  end else if (Sametext(Appenv.AppDb.Database , 'madeurne_pty_ltd')) or devmode then begin
    AppContext[Self.classname].VarByname['ToEmployee'] := cboToEmployeeID.Text;
    AppContext.SaveToFile;
  end;
end;

procedure TPhSupportLogGUI.cboVersionDblClick(Sender: TObject);
begin
  inherited;
  TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_PhoneSupportVersion, PhoneSupportLog.Version);
end;

procedure TPhSupportLogGUI.cboVersionNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Selection NOT in list, Create New?', mtconfirmation, [mbyes, mbno], 0) = mrYes then begin
    TfmSimpleTypes.DoSimpleTypesAddNew(SimpleTypes_PhoneSupportVersion, NewValue);
    closenopendb(cboVersion.LookupTable);
    if cboVersion.LookupTable.Locate('Name', NewValue, []) then begin
           PhoneSupportLog.Version :=NewValue;
           PhoneSupportLog.PostDB;
           Accept:= True;
    end else begin
      Accept:= False;
    end;
  end;
end;

function TPhSupportLogGUI.CopytoRepair: Boolean;
var
  Repairsobj:TRepairs;
begin
  Repairsobj:=TRepairs.CreateWithNewConn(Self);
  Repairsobj.Load(0);
  Repairsobj.Connection.BeginTransaction;
  Repairsobj.New;
  Repairsobj.CopyingtoRepair := True;
  Repairsobj.CustomerName:=lblCompany.Caption;
  Repairsobj.ClientID:= iClientID;
  Repairsobj.Creationdate:= Date;
  Repairsobj.Updatedate:= Date;
  Repairsobj.Done:= False;
  Repairsobj.Notes:= 'Issues:' +edtIssue.Lines.text+chr(13) +'Solutions : ' +edtSolution.lines.text;
  Repairsobj.Classid:= Appenv.DefaultClass.ClassID;
  Repairsobj.Employeeid:= appenv.Employee.EmployeeID;
  Repairsobj.Converted:=False;
  Repairsobj.BillCustomerName:=lblCompany.Caption;
  Repairsobj.BillClientID:= iclientID;
  Repairsobj.contactID:= ContactID;

  if Repairsobj.Client.ForcePOOnRepair then begin
    if Repairsobj.CustomerPONumber = '' then begin
      Repairsobj.CustomerPONumber := 'Support-' + PhoneSupportLog.GlobalRef;
    end;
  end;

  Repairsobj.PostDb;
  if Repairsobj.Save then begin
    Repairsobj.connection.CommitTransaction;
    OpenERPForm('TRepairsGUI' , Repairsobj.ID );
    result := true;
  end else begin
    Result := False;
    Repairsobj.Connection.RollbackTransaction;
  end;
end;

procedure TPhSupportLogGUI.AddToDo;
begin
 PhoneSupportLog.Addtodo;
end;

procedure TPhSupportLogGUI.SetNotes(const Value: String);
begin
  fsNotes := Value;
end;

procedure TPhSupportLogGUI.SetToDoCompleted(AskQuestion: Boolean);
begin
  if not AskQuestion or (CommonLib.MessageDlgXP_Vista('Set "To Do" Item as Completed and Support Log as Finished?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
    if PhoneSupportLog.CompleteToDo(iToEmployeeID) then
      PhoneSupportLog.Finished := true;
  end;
end;

procedure TPhSupportLogGUI.SetUpHistoryList;
(*var
  iIndex: integer;*)
begin
  try
    inherited;
    pnlHistory.Font.Size := 9;
    try
      PostDB(qryCustomers); // to geenrate the ID for lists
      if Assigned(HistoryListform) then begin
        HistoryListform.OnGridDataSelect := DoOnGridDataSelect;
        HistoryListform.CloseOnRecSelect := false;

        HistoryListform.Parent := pnlHistory;
        HistoryListform.align := alclient;
        HistoryListform.BorderStyle := bsNone;
        HistoryListform.fbIgnoreQuerySpeed := true;
        try
          HistoryListform.Show;
        except
          FreeAndNil(HistoryListform);
        end;
        (*// Show Print & Export
        for iIndex := 0 to HistoryListform.FooterPanel.ControlCount - 1 do begin
          if HistoryListform.FooterPanel.Controls[iIndex] is TControl then begin
            TControl(HistoryListform.FooterPanel.Controls[iIndex]).Visible := false;
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

        HistoryListform.chkIgnoreDates.Checked := false;*)

      end;

    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;

    PageControlMain.ActivePageIndex := 1;
    PageControlMain.ActivePageIndex := 0;
  finally
    EnableForm;
  end;
end;

procedure TPhSupportLogGUI.btnEmailClick(Sender: TObject);
var
  MailTo: string;
begin
  if (PhoneSupportLog.contactId <> 0) and
      qryContacts.Locate('ContactID', PhoneSupportLog.contactId, [])
      and (qryContactsContactEmail.AsString <> '') then
    MailTo := qryContactsContactEmail.AsString
  else
    MailTo := qryClientEmail.AsString;
  SendEmail(MailTo);
end;

procedure TPhSupportLogGUI.SendEmail(const MailTo: string);
const
  ecrlf = #13#10;
var
  Subject, Body: string;
  corres: TCorrespondenceGui;
  EmailConfig: TEmailConfig;
  lSilent, lSecret : boolean;
begin
  DisableForm;
  try
    lSilent := true;
    if MailTo = '' then
    begin
      if CommonLib.MessageDlgXP_Vista(qryContactsContact.AsString + ' does not have an email address.'#13#10+
        'Do you wish to load the email program anyway?',mtConfirmation, [mbYes,mbNo], 0) = mrNo then exit;
        lSilent := false;
    end;

    Subject :=  'Support Call Confirmation ' + DateToStr(PhoneSupportLog.DateCreated);
    if PhoneSupportLog.ContactID <> 0 then
      Body := 'Hi ' + qryContactsContact.AsString + ',' + ecrlf + ecrlf + 'Here are the details of our conversation:' + ecrlf
    else
      Body := '';
    Body := Body + ecrlf +
      'Client: ' + PhoneSupportLog.Company + ecrlf +
      'Contact Person: ' + PhoneSupportLog.Contact + ecrlf +
      'Module: ' + PhoneSupportLog.Module + ecrlf +
      'Version: ' + PhoneSupportLog.Version + ecrlf +
      'Type: ' + PhoneSupportLog.SupportType + ecrlf +
      'Call Commenced: ' + DateTimeToStr(PhoneSupportLog.DateCreated) + ecrlf + ecrlf +
      'Issue:' + ecrlf + PhoneSupportLog.Issue + ecrlf + ecrlf +
      'Solution:' + ecrlf +  PhoneSupportLog.Solution + ecrlf + ecrlf +
      // Dene and simon don't want the Customer to see the comments
      // 'Comments:' + #13#10  + PhoneSupportLog.Comments + #13#10 + #13#10 +
      'Regards,' + ecrlf + AppEnv.Employee.EmployeeName;
    EmailConfig := nil;
    corres := TCorrespondenceGui.Create;
    try
      corres.RecipientList := MailTo;
      corres.Subject := Subject;
      corres.MessageText := Body;
//      corres.ReplyTo := '"No Reply"';
//      corres.From := '"No Reply"';
      corres.CustomerId := PhoneSupportLog.ClientID;
      if AppEnv.CompanyPrefs.UseSupportEmail then begin
        EmailConfig := TEmailConfig.CreateWithSharedConn(nil);
        EmailConfig.LoadSelect('EntityName = "Support"');
        corres.From := '"' + EmailConfig.EmailName + '"' + ' <' + EmailConfig.ReplyEmailAddress + '>';
        corres.EmailConfig := EmailConfig;
      end;
      corres.CheckForMailAttachments := fbCheckForMailAttachments;
      corres.AttachmentTablename := 'tblphonesupportLog';
      corres.AttachmentTableID   := PhoneSupportLog.ID;
      if lSilent and not EmailShortSendMode(lSilent, lSecret) then
        exit;
      if not corres.Execute(lSilent, lSecret) then begin
        if AppEnv.CompanyPrefs.UseSupportEmail then
          MessageDlgXP_Vista('Please check your email settings in Preferences > Appointments > Support Log Preferences > Email Config Button' , mtInformation, [mbOk], 0)
        else
          MessageDlgXP_Vista('Please check your email settings on the Employee Card > Address' , mtInformation, [mbOk], 0);
      end;
    finally
      corres.Free;
      EmailConfig.Free;
    end;
  finally
    EnableForm;
  end;
end;

procedure TPhSupportLogGUI.DNMSpeedButton1Click(Sender: TObject);
var
  form :Tform;
begin
  inherited;
   if PhoneSupportLog.ContactID = 0 then begin
    MessageDlgXP_Vista('Please select the contact' , mtInformation, [mbOk], 0);
    Exit;
   end;
   form := Tform(GetComponentByClassName('TfmLogmeIn' , true));
   if not(Assigned(Form)) then exit;
   if Form.visible then begin
    Form.bringtofront;
       MessageDlgXP_Vista('LogMeIn is already opened, Please close the form and Click on the ''LogMeIn'' Button again.' , mtInformation , [mbok],0);
       Exit;
   end;
   Form.FormStyle := fsmdiChild;

   form := Tform(GetComponentByClassName('TfmLogmeInDetails' , true, self));
   if (Assigned(Form)) then begin
       Form.FormStyle := fsStayOnTop;
       TfmLogmeInDetails(form).KeyId := PhoneSupportLog.ContactId;
       Form.Show;
   end;

end;
procedure TPhSupportLogGUI.DNMSpeedButton2Click(Sender: TObject);
begin
  inherited;
//  TfmPhSupportLogComments.PhSupportLogComments(Self);
  onCommentsPage;
end;
Procedure TPhSupportLogGUI.OncommentsPage;
begin
  if PhoneSupportLog.ID =0 then PhoneSupportLog.PostDB;
   if PhoneSupportLog.Lines.count =0 then PhoneSupportLog.Lines.New;
   PagecontrolMain.TabIndex := 1;
   SetcontrolFocus(grdTransactions);

end;
procedure TPhSupportLogGUI.DoBusinessObjectEvent(const Sender: TDatasetBusObj;const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TPhoneSupportLog then TPhoneSupportLog(Sender).Dataset   := QryLog
    else if Sender is TPhoneSupportLogLines then TPhoneSupportLogLines(Sender).Dataset   := QryLogLines;
  end else if (Eventtype = BusObjEvent_Change) and (Value = BusObjEventVal_status) then begin
    if PhoneSupportLog.PhsupportStatus.Description <> '' then begin
      PhoneSupportLog.EditDB;
      AddDateTime(lcdOnLoganyway, edtSolution, true);
      PhoneSupportLog.EditDB;
      edtSolution.lines[edtSolution.lines.count-1] := edtSolution.lines[edtSolution.lines.count-1] + ' ' +PhoneSupportLog.PhsupportStatus.Description ;
      SetcontrolFocus(edtSolution);
      PhoneSupportLog.PostDB;
      PhoneSupportLog.EditDB;
    end;
    if SameText(Trim(PhoneSupportLog.Status),'Closed Support') then begin
      PhoneSupportLog.Finished := true;
    end;
  end;

end;

procedure TPhSupportLogGUI.DoOnBeforeShow(Sender: TObject);
begin
  TPhSupportLogGUI(Sender).ShowHistory := false;
end;

procedure TPhSupportLogGUI.DoOnGridDataSelect(Sender: TwwDbGrid);
begin
  OpenERPForm(self.ClassName,Sender.DataSource.DataSet.FieldByName('SupportLogID').AsInteger,nil,DoOnBeforeShow,false,false);

end;

procedure TPhSupportLogGUI.btnTaskClick(Sender: TObject);
begin
  DoSaveTask;
  if PhoneSupportLog.TaskId <> 0 then
  begin
    PhoneSupportLog.Supporttype := cboPhoneSupporttype.text;
    if SaveLog then
     OpenERPForm('TfmTasks', PhoneSupportLog.TaskId);
  end;
end;

Procedure TPhSupportLogGUI.InitAttachment;
begin
  PhoneSupportLog.PostDB;
  if PhoneSupportLog.ID =0 then exit;
  If not Assigned(AttachmentForm) then Begin
    AttachmentForm := TfmAttachments(GetComponentByClassName('TfmAttachments',False,Self,True,True,PhoneSupportLog.ID));
    AttachmentForm.DBConnection := MyConnection;
    AttachmentForm.AttachObserver(Self);
    AttachmentForm.TableName := 'tblphonesupportLog';
  end;
  if AttachmentForm.TableId <> PhoneSupportLog.ID then begin
    AttachmentForm.TableId := PhoneSupportLog.ID;
    AttachmentForm.Tag := PhoneSupportLog.ID;
    AttachmentForm.lvAttachments.Parent := pnlAttachments;
    AttachmentForm.lvAttachments.Align := alClient;
    AttachmentForm.PopulateListView;
  end;
end;

initialization
  RegisterClassOnce(TPhSupportLogGUI);
  with FormFact do begin
    RegisterMe(TPhSupportLogGUI, 'TPhSupportLogListGUI_*=SupportLogID');
    RegisterMe(TPhSupportLogGUI, 'TPhoneSupportLogListGUI_*=SupportLogID');
    RegisterMe(TPhSupportLogGUI, 'TPhoneSupportLogListExpressGUI_*=SupportLogID');
    RegisterMe(TPhSupportLogGUI, 'TToDoListGUI_*_Support=OtherID');
    (*RegisterMe(TPhSupportLogGUI, 'TRemindersListGUI_*_Support=ID');*)
    RegisterMe(TPhSupportLogGUI, 'TReminderListGUI_*_Support=ID');
    // When we get here form the Customer on support list, the value of ID
    // .. is the client ID negated and therefor the value of keyid is set to _ve.
    // .. This way we know that we are to open a new log entry based on the client ID
    RegisterMe(TPhSupportLogGUI, 'TCustomersOnSupportListGUI_*=ID');
  end;
end.



