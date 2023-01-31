Unit frmMessages;

{ Date     Version Who What
  -------- -------- --- ------------------------------------------------------
  23/12/05  1.00.01 AL   Initial Version
}
Interface

Uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DataState, DBAccess, MyAccess, ERPdbComponents,
  SelectionDialog,
  AppEvnts, DB, ExtCtrls, DNMPanel, StdCtrls, Mask, wwdbedit,
  wwcheckbox, Buttons, DNMSpeedButton, wwdbdatetimepicker, wwdblook, MemDS,
  DBCtrls, ComCtrls, AdvOfficeStatusBar,
  Menus, AdvMenus, Shader, wwclearbuttongroup, wwradiogroup, DBTables,
  Wwtable, BusObjMessages, BusObjBase, ImgList, ActnList,
  DNMAction, ERPDbLookupCombo, Wwdotdot, Wwdbcomb, Grids, Wwdbigrd, Wwdbgrid,
  ProgressDialog;

Type
  TfrmMessagesGUI = Class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    Label1: TLabel;
    Label2: TLabel;
    dbeDetails: TwwDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Done: TLabel;
    cbDone: TwwCheckBox;
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    txtPhone: TwwDBEdit;
    txtMobile: TwwDBEdit;
    txtFax: TwwDBEdit;
    txtEmail: TwwDBEdit;
    dtdatentime: TwwDBDateTimePicker;
    qryMessages: TERPQuery;
    qryEmployees: TERPQuery;
    qryEmployeesName: TWideStringField;
    qryEmployeesEmployeeID: TIntegerField;
    cboTo: TwwDBLookupCombo;
    dsMessages: TDataSource;
    lblName: TLabel;
    qryContactNames: TERPQuery;
    dsContactNames: TDataSource;
    cboSource: TwwDBLookupCombo;
    Label14: TLabel;
    qryMediaType: TERPQuery;
    qryMediaTypeMediaType: TWideStringField;
    qryMediaTypeMedTypeID: TIntegerField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cboName: TERPDbLookupCombo;
    Label3: TLabel;
    edLastName: TwwDBEdit;
    edFirstName: TwwDBEdit;
    Label13: TLabel;
    btnContacts: TDNMSpeedButton;
    qryContactNamesclientID: TIntegerField;
    qryContactNamesCallPriority: TIntegerField;
    QryContactNamesDefaultContactMethod: TWideStringField;
    qryContactNamesCompany: TWideStringField;
    qryContactNamesSupplierID: TLargeintField;
    qryContactNamesCustomerID: TLargeintField;
    qryContactNamesJobId: TLargeintField;
    qryContactNamesProspectID: TLargeintField;
    qryContactNamesMCId: TLargeintField;
    qryContactNamescontactId: TLargeintField;
    qryContactNamesContactname: TWideStringField;
    qryContactNamesEmployeeID: TLargeintField;
    qryContactNamesType: TWideStringField;
    qryContactNamesClient_ID: TLargeintField;
    lblbtn: TLabel;
    btnRepeat: TDNMSpeedButton;
    lsTDNMSpeedButtonActions: TActionList;
    actLead: TDNMAction;
    Label16: TLabel;
    wwDBComboBox1: TwwDBComboBox;
    Label17: TLabel;
    cboDefaultContactMethod: TwwDBComboBox;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    wwDBDateTimePicker2: TwwDBDateTimePicker;
    wwDBDateTimePicker3: TwwDBDateTimePicker;
    wwDBDateTimePicker4: TwwDBDateTimePicker;
    qrymessageLines: TERPQuery;
    dsmessageLines: TDataSource;
    grdLines: TwwDBGrid;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label21: TLabel;
    wwDBLookupCombo1: TwwDBLookupCombo;
    Bevel3: TBevel;
    btnNew: TDNMSpeedButton;
    qrymessageLinesGlobalRef: TWideStringField;
    qrymessageLinesID: TIntegerField;
    qrymessageLinesMessagesID: TIntegerField;
    qrymessageLinesDateAndTime: TDateTimeField;
    qrymessageLinesEmployeeId: TIntegerField;
    qrymessageLinesEmployeeName: TWideStringField;
    qrymessageLinesDetails: TWideMemoField;
    qrymessageLinesCallPriority: TIntegerField;
    qrymessageLinesResponsedueOn: TDateField;
    qrymessageLinesResponsedueTimeFrom: TTimeField;
    qrymessageLinesResponsedueTimeTo: TTimeField;
    qrymessageLinesDeptId: TIntegerField;
    qrymessageLinesDeptName: TWideStringField;
    DNMSpeedButton1: TDNMSpeedButton;
    qrymessageLinesDone: TWideStringField;
    qryMessagesGlobalRef: TWideStringField;
    qryMessagesMessagesID: TIntegerField;
    qryMessagesFromId: TIntegerField;
    qryMessagesNameId: TIntegerField;
    qryMessagesName: TWideStringField;
    qryMessagesDone: TWideStringField;
    qryMessagesDoneDateTime: TDateTimeField;
    qryMessagesLastName: TWideStringField;
    qryMessagesPhone: TWideStringField;
    qryMessagesMobile: TWideStringField;
    qryMessagesEmail: TWideStringField;
    qryMessagesFax: TWideStringField;
    qryMessagesSource: TWideStringField;
    qryMessagesCompany: TWideStringField;
    qryMessagesCreateDateAndtime: TDateTimeField;
    qryMessagescontactType: TWideStringField;
    qryMessagesContactID: TIntegerField;
    qryMessagesDefaultContactMethod: TWideStringField;
    qryMessagesmsTimeStamp: TDateTimeField;
    rgDetails: TwwRadioGroup;
    optTelephonedBy: TwwRadioGroup;
    qrymessageLinesMessageType: TWideStringField;
    qrymessageLinesActiontype: TWideStringField;
    cboClassQry: TERPQuery;
    cboClassQryClassID: TIntegerField;
    cboClassQryClassName: TWideStringField;
    cboClassQryActive: TWideStringField;
    qryEmployeesDefaultClassName: TWideStringField;
    qryEmployeesDefaultClassID: TIntegerField;
    btnSupport: TDNMSpeedButton;
    actSupport: TDNMAction;
    qrymessageLinescActiontype: TStringField;
    qrymessageLinescMessagetype: TStringField;
    bvSupport: TBevel;
    qryMessagesRepID: TIntegerField;
    qryMessagesRepName: TWideStringField;
    qryReps: TERPQuery;
    cboRep: TwwDBLookupCombo;
    Label4: TLabel;
    qryMessagetype: TERPQuery;
    qryMessagetypename: TWideStringField;
    qryMessagetypeid: TIntegerField;
    qryMessagetypeTypecode: TWideStringField;
    Label9: TLabel;
    cboMessagetype: TwwDBLookupCombo;
    qrymessageLinesTypeID: TIntegerField;
    qrymessageLinesTypeName: TWideStringField;
    Label10: TLabel;
    wwDBEdit1: TwwDBEdit;
    qrymessageLinesEnteredBy: TIntegerField;
    qrymessageLinesEnteredByname: TWideStringField;
    qrymessageLinesTimeSinceLast: TDateTimeField;
    qrymessageLinesPeriodSinceLast: TStringField;
    qrymessageLinesSupportLogID: TIntegerField;
    Procedure FormCreate(Sender: TObject);
    Procedure btnOkClick(Sender: TObject);
    Procedure btnCancelClick(Sender: TObject);
    Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
    Procedure btnPrintClick(Sender: TObject);
    Procedure AnyTxtDblClick(Sender: TObject);
    Procedure FormShow(Sender: TObject);
    Procedure qryMessagesDoneChange(Sender: TField);
    (* procedure rgGroupClick(Sender: TObject); *)
    Procedure cboNameNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: String; Var Accept: Boolean);
    Procedure FormDestroy(Sender: TObject);
    Procedure cboNameCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
      modified: Boolean);
    Procedure btnContactsClick(Sender: TObject);
    Procedure actLeadUpdate(Sender: TObject);
    Procedure actLeadExecute(Sender: TObject);
    Procedure cboNameSpecialItem(Sender: TObject; Item: String);
    Procedure DNMSpeedButton1Click(Sender: TObject);
    Procedure wwDBLookupCombo1CloseUp(Sender: TObject;
      LookupTable, FillTable: TDataSet; modified: Boolean);
    Procedure cboToCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
      modified: Boolean);
    Procedure btnNewClick(Sender: TObject);
    Procedure actSupportUpdate(Sender: TObject);
    Procedure qrymessageLinesCalcFields(DataSet: TDataSet);
    Procedure qrymessageLinesAfterInsert(DataSet: TDataSet);
    Procedure actSupportExecute(Sender: TObject);
    Procedure cboNameDblClick(Sender: TObject);
    procedure cboMessagetypeNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: string; var Accept: Boolean);
    procedure cboMessagetypeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure rgDetailsClick(Sender: TObject);
    procedure dbeDetailsEnter(Sender: TObject);

    Private
      MessageObj        : Tmessages;
      fNotInList        : Boolean;
      tablename         : String;
      LeadId            : Integer;
      PhoneSupportTill  : TDateTime;
      fsAlldetails      : String;
      LookupListPopulated:Boolean;
      TempFileNameList: TStringList;
      Procedure LoadClientDetails;
      Procedure LoadContactDetails;
      Procedure LoadEmployeeDetails;
      Procedure LoadMCDetails;
      Procedure HandleMessageErrors;
      Procedure UpdateFromContact(Const Value: TDataSet);
      Procedure createtemptable; Overload;
      {$HINTS OFF}Procedure createtemptable(strSQL: String; SQLcount: Integer); Overload;{$HINTS ON}
      Procedure MyScriptBeforeExecute(Sender: TObject; Var SQL: String;
        Var Omit: Boolean);
      (* Procedure RefreshLookup; *)
      Procedure MarketingLeadAfterShow(Sender: TObject);
//      Procedure PhSupportLogbeforeshow(Sender: TObject);
      Function Alldetails: String;
      Procedure AlldetailsCallback(Const Sender: TBusObj; Var Abort: Boolean);
      Procedure OpenContact(Sender: TObject);
      procedure RemoveFieldfromGrid(const fsFieldname: String);
      procedure Lockcompanydetails;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
      Procedure KeyIdChanged(Const NewKeyId: Integer); Override;
    Public
      Procedure NewMessage;
      Procedure UpdateMe; Override;
      Procedure UpdateMe(Const Cancelled: Boolean;
        Const aObject: TObject = Nil); Override;

      { Public declarations }
  End;

Implementation

Uses FastFuncs, CommonLib, frmSupplier, frmCustomerFrm, BusObjConst,
  frmOtherContactFrm, FormFactory, AppEnvironment, StrUtils, BusObjClient,
  BusObjCommon, frmContactFrm, ContactLib, CommonDbLib,
  frmMarketingContactcotnact, BusobjMarketingcontacts,
  BusObjEmployeeDetails, frmJob, frmMarketingContact, frmEmployeeFrm,
  frmContactbase, tcDataUtils, frmMarketingLead, CommonFormLib, BusObjContact,
  frmPhSupportLog, frmSimpleTypes, tcconst, DateUtils,sndkey32;

{$R *.dfm}

Procedure TfrmMessagesGUI.FormCreate(Sender: TObject);
Begin
   TempFileNameList := TStringList.Create;

  LookupListPopulated:= False;
  AddPhoneCallbutton(txtPhone);
  AddPhoneCallbutton(txtMobile);
  tablename          := CommonDbLib.CreateUserTemporaryTable('tmp_globalList','contactList', 'Myisam',nil,MyConnection);
  With qryContactNames Do Begin
    If active Then
      close;
    SQL.clear;
    SQL.add('select Id as clientID, Name as company  ,');
    SQL.add('Type, ');
    SQL.add('if(Type like  "Job%"  , ID , 0) as JobId,');
    SQL.add('if((Type like "Customer%" ) , ID , 0) as  customerId,');
    SQL.add('if((Type like "Customer%" or Type like  "Job%" or Type like "Prospect%") , ID , 0) as  Client_ID,');
    SQL.add('if(Type like "Prospect%" , ID , 0) as ProspectID,');
    SQL.add('if(Type like "Supplier%" , ID , 0) as supplierId,');
    SQL.add('if(Type like "Marketing Contact%" , ID , 0) as MCId,');
    SQL.add('if(Type like "Employee%" , ID , 0) as employeeId,');
    SQL.add('contactId ,');
    SQL.add('Contactname,');
    SQL.add('CallPriority,DefaultContactMethod');
    SQL.add('FROM ' + tablename + ' AS `T`');
    SQL.add('where ( ((:SearchMode = 0) or IsNull(:SearchMode))');
    SQL.add('or ( (:SearchMode = 1) and ( (Name LIKE Concat(:SearchValue,"%")) or (ContactName LIKE Concat(:SearchValue,"%")) ) )');
    SQL.add('or ( (:SearchMode = 2) and ( (Name LIKE Concat("%",:SearchValue,"%")) or (ContactName LIKE Concat("%",:SearchValue,"%")) ) ) )');
    SQL.add('and IfNull(:SearchValue,"") <> ""');
    SQL.add('Order by Company , Contactname , type');
  End;
  AllowCustomiseGrid:= True;
  Inherited;
  UserLock.Enabled := true;
  MessageObj       := Tmessages.Create(Nil);
  { only allow create new special item as ther is no list associated }
  cboName.SpcialLookupItemList.Text := ComboSpecialItem_CreateNew;
  //createtemptable;
End;

Procedure TfrmMessagesGUI.createtemptable;
Begin
  ContactLib.ContactList(tablename, createtemptable, TempFileNameList,
    Appenv.Companyprefs.ExcludeInactiveContactFromMessages);
  LookupListPopulated:= True;
End;

Procedure TfrmMessagesGUI.createtemptable(strSQL: String; SQLcount: Integer);
Begin
  ShowProgressbar(WAITMSG, SQLcount);
  Try
    ExecuteSQL(strSQL, Nil, MyScriptBeforeExecute);

  Finally
    HideProgressbar;
  End;
End;

procedure TfrmMessagesGUI.dbeDetailsEnter(Sender: TObject);
begin
  inherited;
  if pos(getemployeeName(AppEnv.Employee.EmployeeID) , dbeDetails.text) <> 0 then
    dbeDetails.SelStart:= pos(getemployeeName(AppEnv.Employee.EmployeeID) , dbeDetails.text)-2;
end;

Procedure TfrmMessagesGUI.btnOkClick(Sender: TObject);
Begin
  Inherited;
  If Not MessageObj.Save Then Begin
    HandleMessageErrors;
    exit;
  End;
  CommitTransaction;
  Notify;
  close;
End;

Procedure TfrmMessagesGUI.btnCancelClick(Sender: TObject);
Begin
  Inherited;
  RollbackTransaction;
  close;
End;

Procedure TfrmMessagesGUI.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
  Inherited;
  Action := caFree;
End;

Procedure TfrmMessagesGUI.NewMessage;
Begin

End;

//Procedure TfrmMessagesGUI.PhSupportLogbeforeshow(Sender: TObject);
//Begin
//  If Not(Sender Is TPhSupportLogGUI) Then
//    exit;
//  TPhSupportLogGUI(Sender).contactId  := MessageObj.NameId;
//  TPhSupportLogGUI(Sender).Notes      := Alldetails;
//  TPhSupportLogGUI(Sender).EmployeeId := MessageObj.Lines.EmployeeId;
//End;

Procedure TfrmMessagesGUI.btnPrintClick(Sender: TObject);
Begin
  If Not MessageObj.Save Then
    exit;

  DisableForm;
  Try
    fbReportSQLSupplied := False;
    PrintTemplateReport('Message', '~|||~WHERE M.MessagesID = ' +
      qryMessages.FieldByName('MessagesID').AsString,
      Not(Appenv.Employee.ShowPreview), 1);
  Finally
    EnableForm;
  End;
End;

Function TfrmMessagesGUI.Alldetails: String;
Begin
  fsAlldetails := '';
  MessageObj.Lines.Iteraterecords(AlldetailsCallback);
  REsult := fsAlldetails;
End;

Procedure TfrmMessagesGUI.AlldetailsCallback(Const Sender: TBusObj;
  Var Abort: Boolean);
Begin
  If Not(Sender Is TMessageLines) Then
    exit;
  If TMessageLines(Sender).Details <> '' Then Begin
    If fsAlldetails <> '' Then
      fsAlldetails := fsAlldetails + chr(13);
    fsAlldetails   := fsAlldetails + TMessageLines(Sender).Details;
  End;
End;

Procedure TfrmMessagesGUI.AnyTxtDblClick(Sender: TObject);
Begin
  Processingcursor(True);
  Try
    If qryContactNamescontactId.AsInteger <> 0 Then Begin
      If qryContactNamesMCId.AsInteger <> 0 Then Begin
        frmToPopup := TfmMarketingContactcotnact
          (GetComponentByClassName('TfmMarketingContactcotnact'));
      End Else Begin
        frmToPopup := TfrmContact(GetComponentByClassName('TfrmContact'));
      End;
      If Assigned(frmToPopup) Then
        frmToPopup.KeyID := qryContactNamescontactId.AsInteger;
    End
    Else If qryContactNamesSupplierID.AsInteger <> 0 Then Begin
      frmToPopup := TfmSupplier(GetComponentByClassName('TfmSupplier'));
      If Assigned(frmToPopup) Then
        frmToPopup.KeyID := qryContactNamesSupplierID.AsInteger;
    End
    Else If qryContactNamesCustomerID.AsInteger <> 0 Then Begin
      frmToPopup := TfrmCustomer(GetComponentByClassName('TfrmCustomer'));
      If Assigned(frmToPopup) Then
        frmToPopup.KeyID := qryContactNamesCustomerID.AsInteger;
    End
    Else If qryContactNamesProspectID.AsInteger <> 0 Then Begin
      frmToPopup := TfrmOtherContact
        (GetComponentByClassName('TfrmOtherContact'));
      If Assigned(frmToPopup) Then
        frmToPopup.KeyID := qryContactNamesProspectID.AsInteger;
    End
    Else If qryContactNamesMCId.AsInteger <> 0 Then Begin
      frmToPopup := TfmMarketingContact
        (GetComponentByClassName('TfmMarketingContact'));
      If Assigned(frmToPopup) Then
        frmToPopup.KeyID := qryContactNamesMCId.AsInteger;
    End
    Else If qryContactNamesEmployeeID.AsInteger <> 0 Then Begin
      frmToPopup := TfrmEmployee(GetComponentByClassName('TfrmEmployee'));
      If Assigned(frmToPopup) Then
        frmToPopup.KeyID := qryContactNamesEmployeeID.AsInteger;
    End
    Else If qryContactNamesJobId.AsInteger <> 0 Then Begin
      frmToPopup := TJobGUI(GetComponentByClassName('TJobGUI'));
      If Assigned(frmToPopup) Then
        frmToPopup.KeyID := qryContactNamesJobId.AsInteger;
    End;

    { add other forms as well }

    If Not Assigned(frmToPopup) Then
      exit;

    frmToPopup.AttachObserver(Self);
    frmToPopup.FormStyle := fsMDIChild;
    frmToPopup.BringToFront;

    If qryContactNamescontactId.AsInteger <> 0 Then Begin
      If TwwDBEdit(Sender).Name = 'txtPhone' Then
        SetControlFocus(TfmContactbase(frmToPopup).ContactPh)
      Else If TwwDBEdit(Sender).Name = 'txtMobile' Then
        SetControlFocus(TfmContactbase(frmToPopup).ContactMOB)
      Else If TwwDBEdit(Sender).Name = 'txtFax' Then
        SetControlFocus(TfmContactbase(frmToPopup).ContactFax)
      Else If TwwDBEdit(Sender).Name = 'txtEmail' Then
        SetControlFocus(TfmContactbase(frmToPopup).txtContactEmail);
    End
    Else If qryContactNamesSupplierID.AsInteger <> 0 Then Begin
      If TwwDBEdit(Sender).Name = 'txtPhone' Then
        SetControlFocus(TfmSupplier(frmToPopup).txtPhoneNumber)
      Else If TwwDBEdit(Sender).Name = 'txtMobile' Then
        SetControlFocus(TfmSupplier(frmToPopup).txtMobile)
      Else If TwwDBEdit(Sender).Name = 'txtFax' Then
        SetControlFocus(TfmSupplier(frmToPopup).txtFaxNumber)
      Else If TwwDBEdit(Sender).Name = 'txtEmail' Then Begin
        TfmSupplier(frmToPopup).TabCtl20.ActivePage :=
          TTabSheet(TfmSupplier(frmToPopup).General);
        SetControlFocus(TfmSupplier(frmToPopup).Email);
        TfmSupplier(frmToPopup).DNMPanel6.Invalidate;
      End;
    End
    Else
      If qryContactNamesCustomerID.AsInteger <> 0 Then Begin
      If TwwDBEdit(Sender).Name = 'txtPhone' Then
        SetControlFocus(TfrmCustomer(frmToPopup).Phone)
      Else If TwwDBEdit(Sender).Name = 'txtMobile' Then
        SetControlFocus(TfrmCustomer(frmToPopup).MOB)
      Else If TwwDBEdit(Sender).Name = 'txtFax' Then
        SetControlFocus(TfrmCustomer(frmToPopup).FaxNumber)
      Else If TwwDBEdit(Sender).Name = 'txtEmail' Then Begin
        TfrmCustomer(frmToPopup).TabCtl20.ActivePage :=
          TTabSheet(TfrmCustomer(frmToPopup).Address_Info);
        SetControlFocus(TfrmCustomer(frmToPopup).Email);
        TfrmCustomer(frmToPopup).pnlAddress.Invalidate;
      End;
    End
    Else
      If qryContactNamesProspectID.AsInteger <> 0 Then Begin
      If TwwDBEdit(Sender).Name = 'txtPhone' Then
        SetControlFocus(TfrmOtherContact(frmToPopup).Phone)
      Else If TwwDBEdit(Sender).Name = 'txtMobile' Then
        SetControlFocus(TfrmOtherContact(frmToPopup).MOB)
      Else If TwwDBEdit(Sender).Name = 'txtFax' Then
        SetControlFocus(TfrmOtherContact(frmToPopup).FaxNumber)
      Else If TwwDBEdit(Sender).Name = 'txtEmail' Then
        SetControlFocus(TfrmOtherContact(frmToPopup).Email);
    End
    Else If qryContactNamesMCId.AsInteger <> 0 Then Begin
      TfmMarketingContact(frmToPopup).mainPage.ActivePage :=
        TTabSheet(TfmMarketingContact(frmToPopup).Customer_Info);
      If TwwDBEdit(Sender).Name = 'txtPhone' Then
        SetControlFocus(TfmMarketingContact(frmToPopup).ContactPh)
      Else If TwwDBEdit(Sender).Name = 'txtMobile' Then
        SetControlFocus(TfmMarketingContact(frmToPopup).ContactMOB)
      Else If TwwDBEdit(Sender).Name = 'txtFax' Then
        SetControlFocus(TfmMarketingContact(frmToPopup).ContactFax)
      Else If TwwDBEdit(Sender).Name = 'txtEmail' Then Begin
        TfmMarketingContact(frmToPopup).mainPage.ActivePage :=
          TTabSheet(TfmMarketingContact(frmToPopup).Address_Info);
        SetControlFocus(TfmMarketingContact(frmToPopup).Email);
      End;
    End
    Else If qryContactNamesEmployeeID.AsInteger <> 0 Then Begin
      { cannot focus as the forms  are dynamically created }
    End
    Else If qryContactNamesJobId.AsInteger <> 0 Then Begin
      TJobGUI(frmToPopup).pgeControl.ActivePage :=
        TTabSheet(TJobGUI(frmToPopup).tabCustomer);
      If TwwDBEdit(Sender).Name = 'txtPhone' Then
        SetControlFocus(TJobGUI(frmToPopup).edtPhone)
      Else If TwwDBEdit(Sender).Name = 'txtMobile' Then
        SetControlFocus(TJobGUI(frmToPopup).edtPhone)
      Else If TwwDBEdit(Sender).Name = 'txtFax' Then
        SetControlFocus(TJobGUI(frmToPopup).edtFax);
    End;
    frmToPopup := Nil;
  Finally
    Processingcursor(False);
  End;
End;

Procedure TfrmMessagesGUI.UpdateMe;
Begin
//  qryClients.close;
//  qryClients.Open;
End;

Procedure TfrmMessagesGUI.FormShow(Sender: TObject);
Begin
  DisableForm;
  Try
    Inherited;
    BeginTransaction;

    MessageObj.Connection := TMyDacDataConnection.Create(MessageObj);
    TMyDacDataConnection(MessageObj.Connection).MydacConnection :=
      Self.MyConnection;
    MessageObj.BusObjEvent := DoBusinessObjectEvent;

    qryEmployees.Open;
    cboClassQry.Open;
//    qryClients.Open;
    qryContactNames.Open;
    qryMediaType.Open;
    qryReps.Open;
    qryMessagetype.Open;

    If KeyID > 0 Then Begin
      LockCompanydetails;
      MessageObj.Load(KeyID);
      MessageObj.Lines;
      { locate the correct record here cos lookup table is used to read data
        from }
      If MessageObj.NameId <> 0 Then
        qryContactNames.Locate('contactID', MessageObj.NameId, [])
      Else If Pos(MessageObj.ContactType, 'Job') = 1 Then
        qryContactNames.Locate('JobId', MessageObj.FromId, [])
      Else If Pos(MessageObj.ContactType, 'Customer') = 1 Then
        qryContactNames.Locate('CustomerId', MessageObj.FromId, [])
      Else If Pos(MessageObj.ContactType, 'Supplier') = 1 Then
        qryContactNames.Locate('SupplierId', MessageObj.FromId, [])
      Else If Pos(MessageObj.ContactType, 'Prospect') = 1 Then
        qryContactNames.Locate('ProspectId', MessageObj.FromId, [])
      Else If Pos(MessageObj.ContactType, 'Marketing Contact') = 1 Then
        qryContactNames.Locate('MCId', MessageObj.FromId, [])
      Else If Pos(MessageObj.ContactType, 'Employee') = 1 Then
        qryContactNames.Locate('EmployeeId', MessageObj.FromId, []);
    End Else Begin
      createtemptable;
      MessageObj.New;
      MessageObj.PostDb;
      KeyID := MessageObj.ID;
      //MessageObj.Load(KeyID);
      MessageObj.Lines;
    End;
    if AppEnv.AccessLevels.GetEmployeeAccessLevel('FnCanCloseMessage') <> 1 then
      grdLines.columnbyname('Done').Readonly := True;
  Finally
    RemoveFieldfromGrid('ActionType');
    RemoveFieldfromGrid('DeptID');
    RemoveFieldfromGrid('EmployeeId');
    RemoveFieldfromGrid('Globalref');
    RemoveFieldfromGrid('ID');
    RemoveFieldfromGrid('MessagesID');
    RemoveFieldfromGrid('TypeID');
    GuiPrefs.DbGridElement[grdLines].RemoveFields('TimeSinceLast');
    EnableForm;
    SetControlFocus(cboName);
  End;
End;
procedure TfrmMessagesGUI.Lockcompanydetails;
begin
  //cboName.Enabled := False;
  cboName.REadonly := True;
  lblBtn.caption := 'Change';
end;
procedure TfrmMessagesGUI.RemoveFieldfromGrid(const fsFieldname: String);
begin
  GuiPrefs.DbGridElement[grdLines].HideField(fsFieldname);
  grdLines.RemoveField(fsFieldname);
end;

procedure TfrmMessagesGUI.rgDetailsClick(Sender: TObject);
begin
  inherited;
  if rgDetails.itemindex >=0 then MessageObj.Lines.Actiontype :=rgDetails.Values[rgDetails.itemindex];
end;

Procedure TfrmMessagesGUI.qrymessageLinesAfterInsert(DataSet: TDataSet);
Begin
  Inherited;
  If MessageObj.FromId <> 0 Then
    MessageObj.Lines.CallPriority := qryContactNamesCallPriority.AsInteger;
  rgDetails.itemindex := -1;
End;

Procedure TfrmMessagesGUI.qrymessageLinesCalcFields(DataSet: TDataSet);
Begin
  Inherited;
  If qrymessageLinesMessageType.AsString = 'T' Then
    qrymessageLinescMessagetype.AsString := 'Telephoned'
  Else
    qrymessageLinescMessagetype.AsString := 'Called-In';
  If qrymessageLinesActiontype.AsString = 'R' Then
    qrymessageLinescActiontype.AsString := 'Please Ring'
  Else
    qrymessageLinescActiontype.AsString := 'Will Ring Back';

  qryMessageLinesPeriodSinceLast.AsString := MessageObj.Lines.PeriodSinceLast;
End;

Procedure TfrmMessagesGUI.qryMessagesDoneChange(Sender: TField);
Begin
  Inherited;
  If (csDestroying In Self.ComponentState) Then
    exit;
  If (fsShowing In Self.FormState) Or (fsCreating In Self.FormState) Then
    exit;
  If cbDone.Checked Then
    If EditNoAbort(qryMessages) Then
      qryMessagesDoneDateTime.AsDateTime := Now;
End;

Procedure TfrmMessagesGUI.cboNameNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; Var Accept: Boolean);
Var
  option     : word;
  frmToPopup : TComponent;
Begin
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
  fNotInList         := true;
  option := MessageDlgXP_Vista('This name is not in the list.' + chr(13) +
    chr(13) + 'Select the Contact Type to create New.', mtInformation, [], 0,
    Nil, '', '', False, Nil,
    'Customer,Supplier,Prospect,Marketing Contact,Employee,Job,Cancel');

  Processingcursor(True);
  Try
    frmToPopup := Nil;
    If option = mrYes Then
    Else If option = 100 Then
      frmToPopup := TfrmCustomer(GetComponentByClassName('TfrmCustomer'))
    Else If option = 101 Then
      frmToPopup := TfrmCustomer(GetComponentByClassName('TfmSupplier'))
    Else If option = 102 Then
      frmToPopup := TfrmCustomer(GetComponentByClassName('TfrmOtherContact'))
    Else If option = 103 Then
      frmToPopup := TfrmCustomer(GetComponentByClassName('TfmMarketingContact'))
    Else If option = 104 Then
      frmToPopup := TfrmCustomer(GetComponentByClassName('TfrmEmployee'))
    Else If option = 105 Then
      frmToPopup := TfrmCustomer(GetComponentByClassName('TJobGUI'));
    If Not(Assigned(frmToPopup)) Then Begin
      Accept := False;
      exit;
    End;
    TBaseInputGUI(frmToPopup).AttachObserver(Self);
    TBaseInputGUI(frmToPopup).AttachObserver(cboName);
    TForm(frmToPopup).ShowModal;
  Finally
    freeAndNil(frmToPopup);
    Processingcursor(False);
  End;

  fNotInList := False;
  Accept     := true;
End;

Procedure TfrmMessagesGUI.cboNameSpecialItem(Sender: TObject; Item: String);
Var
  Accept: Boolean;
Begin
  Inherited;
  If Item = ComboSpecialItem_CreateNew Then
    cboName.OnNotInList(cboName, cboName.LookupTable, '', Accept);
End;

Procedure TfrmMessagesGUI.cboToCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
Begin
  Inherited;
  if TwwDbLookupCombo(Sender).Text = '' then
     exit;
  MessageObj.Lines.EmployeeId   := qryEmployeesEmployeeID.AsInteger;
  MessageObj.Lines.EmployeeNAme := qryEmployeesName.AsString;
  MessageObj.Lines.DeptID       := qryEmployeesDefaultClassID.AsInteger;
  MessageObj.Lines.Deptname     := qryEmployeesDefaultClassName.AsString;
End;

Procedure TfrmMessagesGUI.LoadClientDetails;
Var
  lClient: TClient;
Begin
  lClient := TClient.Create(Nil);
  Try
    lClient.Load(qryContactNamesClient_ID.AsInteger);
    MessageObj.ContactName := lClient.FirstName;
    MessageObj.LastName    := lClient.LastName;
    MessageObj.Phone       := lClient.Phone;
    MessageObj.Mobile      := lClient.Mobile;
    MessageObj.Fax         := lClient.FaxNumber;
    MessageObj.Email       := lClient.Email;
    MessageObj.Source      := lClient.SourceName;
    PhoneSupportTill       := lClient.PhoneSupportTill;
  Finally
    freeAndNil(lClient);
  End;
End;

Procedure TfrmMessagesGUI.LoadContactDetails;
Var
  contact                : TContact;
  MarketingContactContact: TMarketingContactContact;
Begin
  MessageObj.contactId := qryContactNamescontactId.AsInteger;

  If qryContactNamesMCId.AsInteger <> 0 Then Begin
    MarketingContactContact := TMarketingContactContact.Create(Nil);
    Try
      MarketingContactContact.Load(qryContactNamescontactId.AsInteger);
      If MarketingContactContact.count = 0 Then
        exit;
      MessageObj.ContactName := MarketingContactContact.ContactFirstName;
      MessageObj.LastName    := MarketingContactContact.ContactSurName;
      MessageObj.Phone       := MarketingContactContact.ContactPh;
      MessageObj.Mobile      := MarketingContactContact.ContactMOB;
      MessageObj.Fax         := MarketingContactContact.ContactFax;
      MessageObj.Email       := MarketingContactContact.ContactEmail;
    Finally
      freeAndNil(MarketingContactContact);
    End;

  End Else Begin

    contact := TContact.Create(Nil);
    Try
      contact.Load(qryContactNamescontactId.AsInteger);
      If contact.count = 0 Then
        exit;
      MessageObj.ContactName := contact.ContactFirstName;
      MessageObj.LastName    := contact.ContactSurName;
      MessageObj.Phone       := contact.ContactPh;
      MessageObj.Mobile      := contact.ContactMOB;
      MessageObj.Fax         := contact.ContactFax;
      MessageObj.Email       := contact.ContactEmail;
    Finally
      freeAndNil(contact);
    End;
  End;
End;

Procedure TfrmMessagesGUI.FormDestroy(Sender: TObject);
Begin
  freeAndNil(MessageObj);
//  CommonDbLib.DestroyUserTemporaryTable(tablename);
  TempFileNameList.Free;
  Inherited;
End;

Procedure TfrmMessagesGUI.DNMSpeedButton1Click(Sender: TObject);
Var
  xID: Integer;
  TypeName,EmployeeName,Actiontype:String;
Begin
  Inherited;
  If Not MessageObj.Lines.ValidateData Then
    exit;

  MessageObj.Alldone;
  MessageObj.Lines.first; {as the records are in desc order, this is the last respose}
  TypeName := MessageObj.Lines.typeName;
  EmployeeName:= MessageObj.Lines.EmployeeName;
  Actiontype := MessageObj.Lines.Actiontype;

  MessageObj.Lines.New;

  { to refresh the index order - last record at the top }
  MessageObj.Lines.PostDb;
  xID := MessageObj.Lines.ID;
  MessageObj.Lines.closedb;
  MessageObj.Lines.Locate('ID', xID, []);

  {copy details from the last line if any}
  MessageObj.Lines.typeName:= TypeName;
  MessageObj.Lines.EmployeeName:= EmployeeName;;
  MessageObj.Lines.Actiontype:= Actiontype;

  if Messageobj.Lines.Actiontype <> '' then begin
      if Messageobj.Lines.ResponsedueOn       = 0 then Messageobj.Lines.ResponsedueOn := Date;
      if Messageobj.Lines.ResponsedueTimeFrom = 0 then Messageobj.Lines.ResponsedueTimeFrom := now;
      if Messageobj.Lines.ResponsedueTimeTo   = 0 then Messageobj.Lines.ResponsedueTimeTo := inchour(now,2);
  end;

  SetControlFocus(dtdatentime);
End;

Procedure TfrmMessagesGUI.DoBusinessObjectEvent(Const Sender: TDatasetBusObj;
  Const EventType, Value: String);
Begin
  If (EventType = BusObjEvent_Dataset) And (Value = BusObjEvent_AssignDataset)
  Then Begin
    If Sender Is Tmessages Then
      Tmessages(Sender).DataSet := qryMessages
    Else If Sender Is TMessageLines Then
      TMessageLines(Sender).DataSet := qrymessageLines;
  End
  Else If (EventType = BusObjEvent_Change) And
    (Value = BusObjEventVal_contacttype) Then Begin
    LeadId := getLeadID(MessageObj.ContactType, MessageObj.FromId);
  End;
End;

Procedure TfrmMessagesGUI.HandleMessageErrors;
Var
  FatalStatusItem: TResultStatusItem;
Begin
  FatalStatusItem := MessageObj.ResultStatus.GetLastFatalStatusItem;
  If Assigned(FatalStatusItem) Then Begin
    Case FatalStatusItem.Code Of
      BOR_No_Message_Name: Begin
          SetControlFocus(edFirstName);
          exit;
        End;
      BOR_No_Message_To: Begin
          SetControlFocus(cboTo);
          exit;
        End;
    End;
  End;
End;

Procedure TfrmMessagesGUI.KeyIdChanged(Const NewKeyId: Integer);
Begin
  Inherited;
  If UserLock.Enabled And (AccessLevel < 5) Then Begin
    UserLock.UnlockAllCurrentInstance;
    If (KeyID > 0) Then Begin
      If Not UserLock.Lock('tblmessages', KeyID, Self.Caption) Then Begin
        AccessLevel := 5; // read only
        CommonLib.MessageDlgXP_Vista(UserLock.LockMessage + #13 + #10 + #13 +
          #10 + 'Access has been changed to read-only.', mtWarning, [mbOK], 0);
      End;
    End;
  End;
End;

procedure TfrmMessagesGUI.cboMessagetypeCloseUp(Sender: TObject; LookupTable,  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  if not (modified) then exit;
  MessageObj.Lines.TypeID         := tcDataUtils.GetSimpleType(MessageObj.Lines.typename , SimpleTypes_MessageType );
end;

procedure TfrmMessagesGUI.cboMessagetypeNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: string; var Accept: Boolean);
begin
  inherited;
  Processingcursor;
  try
    if CommonLib.MessageDlgXP_Vista('The Message Type You Have Specified is Currently Not Known.  Would You Like to Add This to the Collection List?',
      mtConfirmation, [mbOK, mbCancel], 0) = mrOk then begin
      TfmSimpleTypes.DoSimpleTypesEdit(SimpleTypes_MessageType, NewValue, self);
      fLastComboAccessed := cboMessagetype;
      Accept := False;
    end;
  finally
    Processingcursor(False);
  end;
end;

Procedure TfrmMessagesGUI.cboNameCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
Var
  ClientId: Integer;
  qry     : TERPQuery;
Begin
  // if not modified then Exit;
  Inherited;
  If fNotInList Then    exit;
  if not(LookupListPopulated) and (fLastComboAccessed = cboname) then exit;
  if not(modified) then exit;

  btnContacts.Enabled := qryContactNamesEmployeeID.AsInteger = 0;

  MessageObj.FromId               := qryContactNamesclientID.AsInteger;
  MessageObj.NameId               := qryContactNamescontactId.AsInteger;
  MessageObj.ContactType          := qryContactNamesType.AsString;
  MessageObj.DefaultContactMethod :=
    QryContactNamesDefaultContactMethod.AsString;
  PhoneSupportTill := 0;
  If qryContactNamescontactId.AsInteger > 0 Then Begin
    LoadContactDetails;
  End
  Else If qryContactNamesClient_ID.AsInteger > 0 Then Begin
    LoadClientDetails;
  End
  Else If qryContactNamesEmployeeID.AsInteger > 0 Then Begin
    LoadEmployeeDetails;
  End
  Else If qryContactNamesMCId.AsInteger > 0 Then Begin
    LoadMCDetails;
  End;
  If MessageObj.FromId <> 0 Then Begin
    If MessageObj.Lines.count = 0 Then
      MessageObj.Lines.New;
    MessageObj.Lines.CallPriority := qryContactNamesCallPriority.AsInteger;
  End;
  ClientId := 0;
  If qryContactNamesJobId.AsInteger > 0 Then
    ClientId := qryContactNamesJobId.AsInteger
  Else If qryContactNamesClient_ID.AsInteger > 0 Then
    ClientId := qryContactNamesClient_ID.AsInteger
  Else If qryContactNamesSupplierID.AsInteger > 0 Then
    ClientId := qryContactNamesSupplierID.AsInteger;
  If ClientId > 0 Then Begin
    qry := TERPQuery.Create(Nil);
    Try
      qry.Connection := MyConnection;
      qry.SQL.add('select RepID from tblClients');
      qry.SQL.add('where ClientID = ' + IntToStr(ClientId));
      qry.Open;
      If qry.FieldByName('RepID').AsInteger > 0 Then
        MessageObj.RepID := qry.FieldByName('RepID').AsInteger;
    Finally
      qry.Free;
    End;
  End;

End;

Procedure TfrmMessagesGUI.OpenContact(Sender: TObject);
Begin
  If Sender Is TBaseInputGUI Then
    TBaseInputGUI(Sender).AttachObserver(Self);
  If MessageObj.NameId <> 0 Then Begin
    // not implemented at the moment as dene said
  End;
End;

Procedure TfrmMessagesGUI.cboNameDblClick(Sender: TObject);
Var
  FormName: String;
Begin
  Inherited;
  fLastComboAccessed := cboName;
  If MessageObj.FromId = 0 Then
    exit;
  If MessageObj.IsFromCustomer Then
    FormName := 'TfrmCustomer'
  Else If MessageObj.IsFromSupplier Then
    FormName := 'TfmSupplier'
  Else If MessageObj.IsFromJob Then
    FormName := 'TJobGUI'
  Else If MessageObj.IsFromProspect Then
    FormName := 'TfrmOtherContact'
  Else If MessageObj.IsFromMarketingContact Then
    FormName := 'TfmMarketingContact'
  Else If MessageObj.IsFromEmployee Then
    FormName := 'TfrmEmployee'
  Else
    exit;
  OpenErpform(FormName, MessageObj.FromId, OpenContact);
End;

Procedure TfrmMessagesGUI.btnContactsClick(Sender: TObject);
Var
  Form  : TComponent;
  option: word;
Begin
  if not (LookupListPopulated) and (SameText(lblBtn.caption , 'Change')) then begin
    createtemptable;
    if MessageObj.NameId <> 0 then begin
      Setcontrolfocus(cboname);
      SendKeys('{F6}',true);
    end;
    lblBtn.caption := 'Contacts';
    //cboname.enabled := True;
    cboName.Readonly := False;
    Exit;
  end;
  fLastComboAccessed := cboName;
  If qryContactNamesclientID.AsInteger = 0 Then Begin
    MessageDlgXP_Vista('Please Select the Customer to create a contact for.',
      mtInformation, [mbOK, mbCancel], 0);
    exit;
  End;
  If qryContactNamesEmployeeID.AsInteger <> 0 Then Begin
    MessageDlgXP_Vista(qryContactNamesCompany.AsString +
      ' is an Employee - Employee Doesn''t Have any Contact.', mtInformation,
      [mbOK], 0);
    exit;
  End;
  option := 102;
  If qryContactNamescontactId.AsInteger <> 0 Then
    option := MessageDlgXP_Vista('Do You Wish to See the Details of ' +
      qryContactNamesContactname.AsString + ' Or Add a New Contact for ' +
      qryContactNamesCompany.AsString, mtConfirmation, [], 0, Nil, '', '',
      False, Nil, 'View Details of ' + qryContactNamesContactname.AsString +
      ',Add New Contact,Cancel')
  Else If MessageDlgXP_Vista('Do You Wish to Add a New Contact for ' +
    qryContactNamesCompany.AsString, mtConfirmation, [mbyes, mbno], 0)
    = mrYes Then
    option := 101;

  If option = 102 Then
    exit;

  If qryContactNamesMCId.AsInteger <> 0 Then Begin
    If Not FormStillOpen('TfmMarketingContactcotnact') Then Begin
      Form := GetComponentByClassName('TfmMarketingContactcotnact');
      If Assigned(Form) Then Begin
        TBaseInputGUI(Form).AttachObserver(Self);
        With TfmMarketingContactcotnact(Form) Do Begin
          If option = 100 Then
            KeyID := qryContactNamescontactId.AsInteger
          Else
            KeyID  := 0;
          MCID     := qryContactNamesMCId.AsInteger;
          Position := poScreenCenter;
          ShowModal;
          LoadContactDetails;
        End;
      End;
    End;
  End Else Begin
    If Not FormStillOpen('TfrmContact') Then Begin
      Form := GetComponentByClassName('TfrmContact');
      If Assigned(Form) Then Begin
        TBaseInputGUI(Form).AttachObserver(Self);
        With TfrmContact(Form) Do Begin
          If option = 100 Then
            KeyID := qryContactNamescontactId.AsInteger
          Else
            KeyID := 0;
//          If qryContactNamesSupplierID.AsInteger <> 0 Then
//            supplierId := qryContactNamesSupplierID.AsInteger;
//          If qryContactNamesClient_ID.AsInteger <> 0 Then
          ClientId           := qryContactNamesClient_ID.AsInteger;
          Position             := poScreenCenter;
          UpdateContactDetails := Self.UpdateFromContact;
          ShowModal;
          LoadContactDetails;
        End;
      End;
    End;
  End;
End;

Procedure TfrmMessagesGUI.btnNewClick(Sender: TObject);
Begin
  If Not MessageObj.Save Then
    exit;
  MessageObj.Connection.CommitTransaction;

  if not (LookupListPopulated) and (SameText(lblBtn.caption , 'Change')) then begin
    createtemptable;
    lblBtn.caption := 'Contacts';
    //cboname.enabled := True;
    cboName.Readonly := False;
  end;

  MessageObj.Connection.BeginTransaction;
  MessageObj.New;
  MessageObj.Lines;
  SetControlFocus(cboName);
  Inherited;

End;

Procedure TfrmMessagesGUI.UpdateFromContact(Const Value: TDataSet);
Begin
  if AccessLevel > 3 then
    exit;
  createtemptable;
  If qryContactNames.Locate('ContactName', Value.FieldByName('Company').AsString, []) Then Begin
    cboName.Text := qryContactNamesCompany.AsString;
    cboNameCloseUp(cboName, cboName.LookupTable,
      cboName.Datasource.DataSet, true);
  End;
End;

Procedure TfrmMessagesGUI.MyScriptBeforeExecute(Sender: TObject;
  Var SQL: String; Var Omit: Boolean);
Begin
  StepProgressbar;
End;

Procedure TfrmMessagesGUI.UpdateMe(Const Cancelled: Boolean;  Const aObject: TObject);
Begin
  if not(LookupListPopulated) and (fLastComboAccessed = cboname) then exit;

  If Cancelled Then Begin
    If Assigned(fLastComboAccessed) Then Begin
      if fLastComboAccessed =  cboName then
        If qryContactNames.Locate('ContactName', fLastComboAccessed.Text, []) Then else fLastComboAccessed.Text := '';
    End;
  End Else Begin
    If fLastComboAccessed = cboName Then Begin
      If Assigned(aObject) And (aObject Is TfmMarketingContactcotnact) Then
        UpdateFromContact(TfmMarketingContactcotnact(aObject).QryContacts)
      Else Begin
        createtemptable;
        cboNameCloseUp(cboName, cboName.LookupTable,
          cboName.Datasource.DataSet, true);
      End;
    end else if fLastComboAccessed = cboMessagetype then begin
        with fLastComboAccessed do begin
          closenopendb(LookupTable);
          LookupTable.Locate('ID', TBaseInputGUI(aObject).KeyID, []);
          MessageObj.Lines.typeID := LookupTable.FieldByName('ID').AsInteger;
          MessageObj.Lines.typeName := LookupTable.FieldByName('NAme').asString;
        end;

    End;
  End;
End;

Procedure TfrmMessagesGUI.wwDBLookupCombo1CloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
Begin
  Inherited;
  MessageObj.Lines.DeptID   := cboClassQryClassID.AsInteger;
  MessageObj.Lines.Deptname := cboClassQryClassName.AsString;
End;

Procedure TfrmMessagesGUI.LoadEmployeeDetails;
Var
  Employee: TEmployeeDetails;
Begin
  Employee := TEmployeeDetails.Create(Nil);
  Try
    Employee.Load(qryContactNamesEmployeeID.AsInteger);
    If Employee.count = 0 Then
      exit;
    MessageObj.ContactName := Employee.FirstName;
    MessageObj.LastName    := Employee.LastName;
    MessageObj.Phone       := Employee.Phone;
    MessageObj.Mobile      := Employee.Mobile;
    MessageObj.Fax         := Employee.FaxNumber;
    MessageObj.Email       := Employee.Email;
  Finally
    freeAndNil(Employee);
  End;
End;

Procedure TfrmMessagesGUI.LoadMCDetails;
Var
  MarketingContact: TMarketingContact;
Begin
  MarketingContact := TMarketingContact.Create(Nil);
  Try
    MarketingContact.Load(qryContactNamesMCId.AsInteger);
    If MarketingContact.count = 0 Then
      exit;
    MessageObj.ContactName := MarketingContact.FirstName;
    MessageObj.LastName    := MarketingContact.LastName;
    MessageObj.Phone       := MarketingContact.Phone;
    MessageObj.Mobile      := MarketingContact.Mobile;
    MessageObj.Fax         := MarketingContact.FaxNumber;
    MessageObj.Email       := MarketingContact.Email;
  Finally
    freeAndNil(MarketingContact);
  End;
End;

Procedure TfrmMessagesGUI.actLeadUpdate(Sender: TObject);
Begin
  Inherited;
  actLead.Enabled := (LeadId <> 0) Or
    (PosExIgnoreCase('Marketing Contact', MessageObj.ContactType) = 1);
End;

Procedure TfrmMessagesGUI.actSupportExecute(Sender: TObject);
var
  form: TPhSupportLogGUI;
Begin
  Inherited;
  If MessageObj.NameId = 0 Then
    If Clientcontactcount(MessageObj.FromId) = 0 Then Begin
      If MessageDlgXP_Vista(MessageObj.Company +
        ' has no Contact.  Do You wish to Create the Primary Contact Automatically?',
        mtConfirmation, [mbyes, mbno], 0) = mrNo Then
        exit;
      If (TClient.MakeCustomerContact(MessageObj.FromId, Self)) = 0 Then
        exit;
    end;
  if self.MessageObj.Lines.SupportLogID > 0 then begin
    MessageDlgXP_Vista('There is already a Support Log entry for this Response Line, ' +
      'please create a new Response line first', mtInformation, [mbOk],0);
    exit;
  end;

  form:= TPhSupportLogGUI.Create(nil);
  try
    form.KeyID := 0 - MessageObj.FromId;
    form.contactId  := MessageObj.NameId;
    form.Notes      := Alldetails;
    form.EmployeeId := MessageObj.Lines.EmployeeId;
    if form.ShowModal = mrOk then begin
      self.MessageObj.Lines.SupportLogID := form.KeyId;
    end;

  finally
    form.Free;
  end;

//  OpenErpform('TPhSupportLogGUI', 0 - MessageObj.FromId, Nil,PhSupportLogbeforeshow);
  MessageObj.Alldone;
End;

Procedure TfrmMessagesGUI.actSupportUpdate(Sender: TObject);
Var
  enableSupport: Boolean;
Begin
  Inherited;
  enableSupport := ((Sametext(MessageObj.ContactType, 'Customer')) Or
    (Sametext(MessageObj.ContactType, 'Customer / Supplier')) Or
    (Sametext(MessageObj.ContactType, 'Customer / Supplier(Primary Contact)')))
    And ((Appenv.Companyprefs.SupportAllcustomers) Or
    (PhoneSupportTill >= Date));

  If Not(enableSupport) Then
    If (Sametext(MessageObj.ContactType, 'Customer / Supplier(Contact)')) Or
      (Sametext(MessageObj.ContactType, 'Customer(Contact)')) Or
      (Sametext(MessageObj.ContactType, 'Customer(Primary Contact)')) Then
      If (ClientPhoneSupport(MessageObj.FromId) >= Date) Or
        (Appenv.Companyprefs.SupportAllcustomers) Then
        enableSupport := true;
  actSupport.Enabled  := enableSupport;
End;

Procedure TfrmMessagesGUI.actLeadExecute(Sender: TObject);
Begin
  Inherited;
  { incase if the lead is created from this form, the local variable is not initialised }
  If Not MessageObj.Save Then
    exit;
  If LeadId = 0 Then
    LeadId := getLeadID(MessageObj.ContactType, MessageObj.FromId);

  OpenErpform('TfmMarketingLead', LeadId, MarketingLeadAfterShow);
End;

Procedure TfrmMessagesGUI.MarketingLeadAfterShow(Sender: TObject);
Begin
  If LeadId = 0 Then
    If Pos(MessageObj.ContactType, 'Marketing Contact') = 1 Then
      If (qryContactNames.Locate('ClientID', MessageObj.FromId, [])) Or
        (qryContactNames.Locate('SupplierID', MessageObj.FromId, [])) Then
        TfmMarketingLead(Sender).AssignMC(qryContactNamesMCId.AsInteger);
End;

Initialization

RegisterClassOnce(TfrmMessagesGUI);
With FormFact Do Begin
(*  RegisterMe(TfrmMessagesGUI, 'TRemindersListGUI_*_Message=ID');*)
  RegisterMe(TfrmMessagesGUI, 'TReminderListGUI_*_Message=ID');
End;

End.
