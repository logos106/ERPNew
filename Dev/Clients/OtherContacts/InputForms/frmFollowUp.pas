unit frmFollowUp;

{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 30/06/05  1.00.01 IJB  Modified RunFollowup function to use new Userlock object.
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts,
  DB, MemDS, StdCtrls, DBCtrls, Mask, wwdbedit, Grids, Wwdbigrd,
  Wwdbgrid, wwdblook, wwcheckbox, Buttons, DNMSpeedButton, wwdbdatetimepicker, DataState,
  ExtCtrls, DNMPanel, Wwdotdot, Wwdbcomb, XMLDataObj, ComCtrls,AdvOfficeStatusBar, Menus, AdvMenus,
  Shader, MessageInterface, ImgList, ProgressDialog;

type
  TfmFollowUp = class(TBaseInputGUI)
    dsClient: TDataSource;
    dsContacts: TDataSource;
    dsFollowUp: TDataSource;
    qryContacts: TERPQuery;
    qryFollowUp: TERPQuery;
    qryClient: TERPQuery;
    qryContactsTitle: TWideStringField;
    qryContactsFirstName: TWideStringField;
    qryContactsLastName: TWideStringField;
    qryContactsPhone: TWideStringField;
    qryContactsMobile: TWideStringField;
    qryContactsEmail: TWideStringField;
    qryContactsJobTitle: TWideStringField;
    qryFollowUpResultType: TERPQuery;
    qryFollowUpType: TERPQuery;
    qryEmployee: TERPQuery;
    pnlBottom: TDNMPanel;
    btnOk: TDNMSpeedButton;
    cmdFollowUp: TDNMSpeedButton;
    cmdClose: TDNMSpeedButton;
    btnNext: TDNMSpeedButton;
    btnAppointment: TDNMSpeedButton;
    pnlTop: TDNMPanel;
    qryClientSelectionList: TERPQuery;
    qryClientList: TERPQuery;
    qryFollowUpGlobalRef: TWideStringField;
    qryFollowUpFollowUpID: TAutoIncField;
    qryFollowUpOtherContactID: TIntegerField;
    qryFollowUpRepairID: TIntegerField;
    qryFollowUpEmployeeID: TIntegerField;
    qryFollowUpClientID: TIntegerField;
    qryFollowUpFollowUpDate: TDateTimeField;
    qryFollowUpDone: TWideStringField;
    qryFollowUpEditedFlag: TWideStringField;
    qryFollowUpAppearDays: TIntegerField;
    qryFollowUpCreationDate: TDateTimeField;
    qryFollowUpUpdateDate: TDateField;
    qryFollowUpIsSupplier: TWideStringField;
    qryFollowUpIsOtherContact: TWideStringField;
    qryFollowUpIsCustomer: TWideStringField;
    qryFollowUpHours: TFloatField;
    qryFollowUpTypeId: TIntegerField;
    qryFollowUpResultTypeId: TIntegerField;
    qryFollowUpContactId : TIntegerField;
    qryCustomFields: TERPQuery;
    dsCustomFields: TDataSource;
    txtCompany: TDBMemo;
    qryCheckForFollowUps: TERPQuery;
    btnClient: TDNMSpeedButton;
    qryFollowUpIsPhoneFollowUp: TWideStringField;
    DNMPanel1: TDNMPanel;
    PageControl: TPageControl;
    tabDetails: TTabSheet;
    pnlDetails: TDNMPanel;
    Label8: TLabel;
    Label6: TLabel;
    lblFollowUpType: TLabel;
    lblFollowUpDate: TLabel;
    lblEmployee: TLabel;
    lblFollowUpResult: TLabel;
    lblDone: TLabel;
    edtLastUpdated: TwwDBEdit;
    memNotes: TDBMemo;
    grdContacts: TwwDBGrid;
    cboFollowUpType: TwwDBLookupCombo;
    dtpFollowUpDate: TwwDBDateTimePicker;
    cboEmployee: TwwDBLookupCombo;
    cboFollowUpResult: TwwDBLookupCombo;
    chkDone: TwwCheckBox;
    Custom_Fields: TTabSheet;
    pnlCustFields: TDNMPanel;
    Box181: TBevel;
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
    lblListSelection: TLabel;
    cboListSelection: TwwDBLookupCombo;
    qryContactsAltPhone: TWideStringField;
    cmd: TERPCommand;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryFollowUpNotes: TWideMemoField;
    qryContactsContactId: TLargeintField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdFollowUpClick(Sender: TObject);
    procedure btnAppointmentClick(Sender: TObject);
    procedure cboFollowUpResultNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure cboFollowUpTypeNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure cboListSelectionCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure btnNextClick(Sender: TObject);
    procedure btnClientClick(Sender: TObject);
    procedure cboListSelectionDblClick(Sender: TObject);
    procedure cmdCustomLabelsOldClick(Sender: TObject);
    procedure qryFollowUpAfterOpen(DataSet: TDataSet);
    procedure qryFollowUpAfterClose(DataSet: TDataSet);
    procedure qryContactsPhoneGetText(Sender: TField; var Text: string; DisplayText: boolean);
    procedure memNotesEnter(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    fMsgHandler: TMsgHandler;
    fFollowUpId, fClientId: integer;
    DBConnection: TCustomMyConnection;
    fClientListMode: boolean;
    XMLData: TXMLData;
    ClientListSQL: string;
    EditStartTime, EditEndTime: TDateTime;
    fIsPhoneFollowUp: boolean;
    procedure SetClientListMode(const Value: boolean);

    function ContactHasFollowUps(ClientId: integer): boolean;
    procedure UpdateEditTime;
    procedure SeTDNMSpeedButtons;
    function ValidateFormData: boolean;
    function ChkCustReqdFields: boolean;

  Protected
    procedure CustomFieldsRefresh;Override;
  public
    procedure UpdateMe; override;
    property ClientId: integer read fClientId write fClientId;
    property FollowUpId: integer read fFollowUpId write fFollowUpId;
    property ClientListMode: boolean read fClientListMode write SetClientListMode;
    property IsPhoneFollowUp: boolean read fIsPhoneFollowUp;
  published
    procedure AppointmentClosed(MsgObj: TMsgObj);
  end;

procedure DoFollowUp(aClientId, aFollowUpId: integer; aDBConnection: TCustomMyConnection = nil; aOwner: TBaseInputGUI = nil; aContactId : integer = 0);
procedure DoPhoneFollowUp(aClientListMode: boolean; aClientId, aFollowUpId: integer;
  aDBConnection: TCustomMyConnection = nil; aOwner: TBaseInputGUI = nil);

implementation

{$R *.dfm}

uses
  DNMExceptions,  AppContextObj, GlobalEventsObj,
  DNMLib, CommonDbLib, frmOtherContactFrm,
  CommonLib, frmMarketingContactSelectionRange, FormFactory, frmCustomFieldsFrm,
  MaskUtils, FastFuncs, AppEnvironment, tcconst, MySQLConst;

// If an owner is passed use it as the Owner (so this form is closed with owner)
procedure RunFollowUp(aIsPhoneFollowUp, aClientListMode: boolean; aClientId, aFollowUpId: integer;
  aDBConnection: TCustomMyConnection = nil; aOwner: TBaseInputGUI = nil; aContactId : integer = 0);
var
  aControl: TControl;
  Form: TfmFollowUp;
begin
  Form := TfmFollowUp(GetComponentByClassName('TfmFollowUp',false,aOwner));
  if Assigned(Form) then begin
    if aClientID <> 0 then begin
      Form.UserLock.LockList.AddLock('tblClients', aClientId, 'Client');
      if not Form.UserLock.Lock('Client') then begin
        CommonLib.MessageDlgXP_Vista('Currently the User [ ' + Form.UserLock.LockInfo.UserName + ' ] is accessing this Client!' +
          #13#10#13#10 + 'Please retry again shortly!', mtWarning, [mbOK], 0);
        Form.Destroy;
        Exit;
      end;
      end else if aFollowUpId <> 0 then begin
      //     FormInUse := CheckForInUse(Form, aFollowUpId);
      //     if FormInUse.InUse then begin
      //        if FormInUse.Username <> Employee.LogonName then begin
      //           CommonLib.MessageDlgXP_Vista('Currently the User [ ' + FormInUse.Username + ' ] is accessing this record!'+
      //                      #13#10#13#10+'Please retry again shortly!', mtWarning, [mbOK], 0);
      //           Form.Destroy;
      //        end else begin
      //            Form.BringToFront;
      //            Form.Paint;
      //            Form.Refresh;
      //            Application.ProcessMessages;
      //        end;
      //
      //        exit;
      //     end;
      //     AddUserInUseEntry(Form, Employee.LogonName, aFollowUpId);

      Form.UserLock.LockList.AddLock('tblOtherFollowUp', aFollowUpId, 'FollowUp');
      if not Form.UserLock.Lock('FollowUp') then begin
        CommonLib.MessageDlgXP_Vista('Currently the User [ ' + Form.UserLock.LockInfo.UserName + ' ] is accessing this Follow-Up!' +
          #13#10#13#10 + 'Please retry again shortly!', mtWarning, [mbOK], 0);
        Form.Destroy;
        Exit;
      end;
    end;

    if Assigned(aDBConnection) then Form.DBConnection := aDBConnection
    else Form.DBConnection := Form.MyConnection;
    with Form do begin
      fIsPhoneFollowUp := aIsPhoneFollowUp;
      ClientId         := aClientId;
      FollowUpId       := aFollowUpId;
      ClientListMode   := aClientListMode;
      if aContactId > 0 then
      begin
        qryContacts.Filter := 'ContactId=' + IntToStr(aContactId);
        qryContacts.Filtered := true;
      end;

      if IsPhoneFollowUp then begin
        grdContacts.TitleColor := $00ECECD9;
        StringReplace(Caption, 'Follow-Up', 'Phone Contact',[rfReplaceAll]);
        TitleLabel.Caption := 'Phone Contact';

        // hide the controls not used for phone follow-up
        cboFollowUpType.Visible := false;
        lblFollowUpType.Visible := false;
        dtpFollowUpDate.Visible := false;
        lblFollowUpDate.Visible := false;
        cboEmployee.Visible := false;
        lblEmployee.Visible := false;
        chkDone.Visible := false;
        lblDone.Visible := false;

        cboFollowUpResult.Left := cboFollowUpType.Left;
        lblFollowUpResult.Left := lblFollowUpType.Left;
      end else begin
        grdContacts.TitleColor := $00D7FFFF;
        cmdFollowUp.Enabled := false;
      end;

      FormStyle := fsmdiChild;
      Show;
      // Get any context data that is intended for this form
      if AppContext.ContextExists(ClassName) then begin
        if AppContext[ClassName].VarExists('SetFocus') then begin
          aControl := FindChildControl(AppContext['TfmFollowUp'].VarByName['SetFocus']);
          if Assigned(aControl) then
            SetControlFocus(TWinControl(aControl))
          else
          begin
            SetControlFocus(Form.memNotes);
            Form.memNotes.SelStart := Length(Form.memNotes.Text);
          end;
        end;
      end;
    end;

  end;
end;

procedure DoFollowUp(aClientId, aFollowUpId: integer; aDBConnection: TCustomMyConnection = nil; aOwner: TBaseInputGUI = nil; aContactId : integer = 0);
begin
  RunFollowUp(false, false, aClientId, aFollowUpId, aDBConnection, aOwner, aContactId);
end;

procedure DoPhoneFollowUp(aClientListMode: boolean; aClientId, aFollowUpId: integer;
  aDBConnection: TCustomMyConnection = nil; aOwner: TBaseInputGUI = nil);
begin
  RunFollowUp(true, aClientListMode, aClientId, aFollowUpId, aDBConnection, aOwner);
end;


procedure TfmFollowUp.FormCreate(Sender: TObject);
begin
  fMsgHandler := TMsgHandler.Create(Self);
  //Self.fbIgnoreAccessLevels := true;
  fIsPhoneFollowUp := false; // default to normal follow-up
  EditStartTime := 0;
  EditEndTime := 0;
  fFollowUpId := 0;
  fClientId := 0;
  fClientListMode := false;
  DBConnection := nil;
  inherited;
  UserLock.Enabled := true;
  if Self.ErrorOccurred then Exit;
  XMLData := TXMLData.Create(Self);
  qryClientList.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryClientSelectionList.Connection := CommonDbLib.GetSharedMyDacConnection;
  // Save a copy of base sql
  ClientListSQL := qryClientList.SQL.Text;
end;

procedure TfmFollowUp.FormActivate(Sender: TObject);
begin
  inherited;
//
end;

procedure TfmFollowUp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if qryFollowUp.State <> dsBrowse then qryFollowUp.Cancel;

  CloseQueries;
  Action := caFree;

  inherited;
end;

procedure TfmFollowUp.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fMsgHandler);
  inherited;
end;

procedure TfmFollowUp.FormShow(Sender: TObject);
var
  IsNewFollowUp: boolean;
begin
  DisableForm;
  try
    try
      inherited;
      if Self.ErrorOccurred then Exit;

      if not Assigned(DBConnection) then begin
        DBConnection := MyConnection;
      end;

      cmd.Connection := DBConnection;

      qryFollowUp.Close;
      qryClient.Close;
      qryContacts.Close;
      qryFollowUpType.Close;
      qryFollowUpResultType.Close;
      qryEmployee.Close;

      qryFollowUpType.Connection := DBConnection;
      qryFollowUpType.ParamByName('TypeCode').asString := SimpleTypes_FollowUpType;
      qryFollowUpType.Open;

      qryEmployee.Open;

      qryFollowUpResultType.Connection := DBConnection;
      qryFollowUpResultType.ParamByName('TypeCode').asString := SimpleTypes_FollowUpResultType;

      qryFollowUp.Connection := DBConnection;
      qryClient.Connection   := DBConnection;
      qryContacts.Connection := DBConnection;

      if KeyId > 0 then begin
        fFollowUpId := KeyId;
      end;

      if fFollowUpId > 0 then begin  // we are opening an existing record
        IsNewFollowUp := false;
        qryFollowUp.ParamByName('FollowUpId').AsInteger := fFollowUpId;
        qryFollowUp.Open;
        fClientId := qryFollowUp.FieldByName('ClientId').AsInteger;
        EditNoAbort(qryFollowUp);
        btnNext.Enabled := false;
      end else begin
        IsNewFollowUp := true;
        EditStartTime := Now;
      end;

      qryClient.ParamByName('ClientId').AsInteger := fClientId;
      qryClient.Open;

      qryContacts.ParamByName('ClientId').AsInteger := fClientId;
      qryContacts.Open;

      Self.BeginTransaction;

      if IsNewFollowUp then begin // a new record
        qryFollowUp.ParamByName('FollowUpId').AsInteger := fFollowUpId;
        qryFollowUp.Open;
        qryFollowUp.Append;
        qryFollowUp.FieldByName('ClientId').AsInteger := fClientId;
        qryFollowUp.FieldByName('OtherContactId').AsInteger := fClientId;
        qryFollowUp.FieldByName('EmployeeId').AsInteger := AppEnv.Employee.EmployeeID;
        qryFollowUp.FieldByName('CreationDate').AsDateTime := Now;
        qryFollowUp.FieldByName('IsOtherContact').AsBoolean :=
          qryClient.FieldByName('OtherContact').AsBoolean;
        qryFollowUp.FieldByName('IsCustomer').AsBoolean :=
          qryClient.FieldByName('Customer').AsBoolean;
        qryFollowUp.FieldByName('FollowUpDate').AsDateTime := Now;
        if Self.IsPhoneFollowUp then begin
          if cboFollowUpType.LookupTable.Locate('Name', 'Phone', []) then cboFollowUpType.Text := 'Phone';
          qryFollowUpIsPhoneFollowUp.AsBoolean := true;
          qryFollowUpDone.AsString := 'T';
        end else
        begin
          qryFollowUpIsPhoneFollowUp.AsBoolean := false;
          if qryFollowUp.FieldByName('ContactId').AsInteger > 0 then
          begin

          end;

        end;
      end;

      qryFollowUpType.Open;
      if IsNewFollowUp and (cboFollowUpType.Text = '') and (not IsPhoneFollowUp) then begin
        qryFollowUpType.First;
        while not qryFollowUpType.Eof do begin
          if qryFollowUpType.FieldByName('IsDefault').AsBoolean then begin
            qryFollowUp.FieldByName('TypeId').AsInteger := qryFollowUpType.FieldByName('Id').AsInteger;
            Break;
          end;
          // Fetch next record.
          qryFollowUpType.Next;
        end;
      end;

      qryFollowUpResultType.Open;
      //Self.OpenQueries;

      CustomFieldsRefresh;

      SeTDNMSpeedButtons;
      PageControl.ActivePage := tabDetails;
//      memNotes.OnEnter(self);
      SendMessage(memNotes.Handle, CM_ENTER, 0, 0);
//      SendMessage(memNotes.Handle, WM_IME_NOTIFY, IMN_OPENCANDIDATE, 0);
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfmFollowUp.memNotesEnter(Sender: TObject);
begin
  inherited;
//
end;

procedure TfmFollowUp.btnOkClick(Sender: TObject);
begin
  inherited;
  if not ValidateFormData then
    Exit;
  if Self.ClientId < 1 then
  begin
    CommonLib.MessageDlgXP_Vista('Cannot Save, no client selected', mtWarning, [mbOK], 0);
    Exit;
  end;

  if not (qryFollowUp.State in [dsInsert, dsEdit]) then
    qryFollowUp.Edit;

  qryFollowUp.FieldByName('UpdateDate').AsDateTime := Now;
  qryFollowUp.FieldByName('ContactId').AsInteger := qryContacts.FieldByName('ContactId').AsInteger;

  qryFollowUp.Post;

  if qryClient.State in [dsInsert, dsEdit] then qryClient.Post;

  if DBConnection = MyConnection then Self.CommitTransaction;

  UpdateEditTime;

  // send notification that data has changed
  GlobalEvents.Notify(Self, GEVENT_DataChanged);
  if fsModal in Self.FormState then ModalResult := mrOk
  else Close;
end;

procedure TfmFollowUp.cmdCloseClick(Sender: TObject);
begin
  inherited;
  if DBConnection = MyConnection then Self.RollbackTransaction;

  if fsModal in Self.FormState then ModalResult := mrCancel
  else Close;
end;

procedure TfmFollowUp.cmdFollowUpClick(Sender: TObject);
begin
  inherited;
  if ClientId <> 0 then begin
    AppContext['TfmFollowUp'].VarByName['SetFocus'] := 'cboFollowUpType';
    try
      //      DoFollowUp(ClientId,0, DBConnection, Self);
      DoFollowUp(ClientId, 0); // don't pass owner or connection in case this for is closed
    finally
      // Get rid of tempory context data
      AppContext.DeleteContext('TfmFollowUp');
    end;

    if cboFollowUpResult.LookupTable.Locate('Name', 'Follow-up', []) then cboFollowUpResult.Text := 'Follow-up';

    if Self.ClientListMode then begin
      if qryClientList.Active and (not qryClientList.Eof) then btnNext.Click
      else btnOk.Click;
    end else begin // not in client list mode
      btnOk.Click;
    end;
  end;
end;

procedure TfmFollowUp.btnAppointmentClick(Sender: TObject);
var
  s: string;
  NewAppointment: TComponent;
  MsgObj: TMsgObj;
begin
  MsgObj := TMsgObj.Create;
  Try
    MsgObj.SetAddress('TAppointmentGUI', 'CloseIfOpen');
    if fMsgHandler.Send(MsgObj, MsgObj) then begin
      Exit;
    end;
  Finally
    FreeAndNil(MsgObj);
  End;
  MsgObj := TMsgObj.Create;
  Try
    MsgObj.SetAddress('TCalendarGUI', 'IsPlacingAppointment');
    if fMsgHandler.Send(MsgObj, MsgObj) then begin
      CommonLib.MessageDlgXP_Vista('The last appointment has not been made. Please make it now.', mtInformation, [mbOK], 0);
      Exit;
    end;
  Finally
    FreeAndNil(MsgObj);
  End;

  inherited;

  s := '';
  if not qryContacts.IsEmpty then begin
    s := 'With:';
    if qryContactsTitle.AsString <> '' then s := s + ' ' + qryContactsTitle.AsString;
    if qryContactsFirstName.AsString <> '' then s := s + ' ' + qryContactsFirstName.AsString;
    if qryContactsLastName.AsString <> '' then s := s + ' ' + qryContactsLastName.AsString;
    if qryContactsJobTitle.AsString <> '' then s := s + ' Pos: ' + qryContactsJobTitle.AsString;
    if qryContactsPhone.AsString <> '' then s := s + ' Ph: ' + qryContactsPhone.AsString;
    if qryContactsMobile.AsString <> '' then s := s + ' Mbl: ' + qryContactsMobile.AsString;
    if qryContactsEmail.AsString <> '' then s := s + ' Ph: ' + qryContactsEmail.AsString;
  end;
  if memNotes.Text <> '' then begin
    if s <> '' then s := s + #13#10;
    s := s + memNotes.Text;
  end;


  // show the calendar
  NewAppointment := GetComponentByClassName('TNewAppointment', False);
  NewAppointment.Name := GetUniqueName(NewAppointment.ClassName);
  if Assigned(NewAppointment) then begin
    MsgObj := TMsgObj.Create;
    MsgObj.SetAddress('TNewAppointment', 'ClientID', NewAppointment.Name);
    MsgObj.IntValue := fClientID;
    fMsgHandler.Send(MsgObj, MsgObj);
    MsgObj.MethodStr := 'ActiveControl';
    MsgObj.StrValue := 'cboEmployee';
    fMsgHandler.Send(MsgObj, MsgObj);
    if s <> '' then begin
      MsgObj.MethodStr := 'Note';
      MsgObj.StrValue := s;
      fMsgHandler.Send(MsgObj, MsgObj);
    end;
    MsgObj.MethodStr := 'CreateNewAppointment';
    MsgObj.BoolValue := True; //appointment required
    fMsgHandler.Send(MsgObj);
  end;

  if cboFollowUpResult.LookupTable.Locate('Name', 'Appointment', []) then begin
    cboFollowUpResult.Text := 'Appointment';
    qryFollowUp.Edit;
    qryFollowup.FieldByName('ResultTypeID').AsInteger := cboFollowUpResult.LookupTable.FieldByName('ID').AsInteger;
    qryFollowUp.Post;
  end;

  if Self.ClientListMode then begin
    if qryClientList.Active and (not qryClientList.Eof) then btnNext.Click
    else btnOk.Click;
  end else begin // not in client list mode
    btnOk.Click;
  end;

end;

procedure TfmFollowUp.cboFollowUpResultNotInList(Sender: TObject; LookupTable: TDataSet;
  NewValue: string; var Accept: boolean);
begin
  inherited;
  // this Follow Up Result Type is not in list ... so add it
  LookupTable.Append;
  LookupTable.FieldByName('Name').AsString := NewValue;
  LookupTable.FieldByName('TypeCode').AsString := SimpleTypes_FollowUpResultType;
  LookupTable.Post;
  LookupTable.Locate('TypeCode;Name', VarArrayOf([SimpleTypes_FollowUpResultType, NewValue]), []);
  qryFollowUp.FieldByName('ResultTypeId').AsInteger := GetLastRecordPostId('tblSimpleTypes',
    qryFollowUpResultType.Connection);
end;

procedure TfmFollowUp.cboFollowUpTypeNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string;
  var Accept: boolean);
begin
  inherited;
  // this Follow Up Type is not in list ... so add it
  LookupTable.Append;
  LookupTable.FieldByName('Name').AsString := NewValue;
  LookupTable.FieldByName('TypeCode').AsString := SimpleTypes_FollowUpType;
  LookupTable.Post;
  LookupTable.Locate('TypeCode;Name', VarArrayOf([SimpleTypes_FollowUpType, NewValue]), []);
  qryFollowUp.FieldByName('TypeId').AsInteger := GetLastRecordPostId('tblSimpleTypes', qryFollowUpType.Connection);
end;

procedure TfmFollowUp.SetClientListMode(const Value: boolean);
begin
  fClientListMode := Value;
  lblListSelection.Visible := fClientListMode;
  cboListSelection.Visible := fClientListMode;
  btnNext.Visible := fClientListMode;
  qryClientSelectionList.Active := fClientListMode;
  btnClient.Visible := fClientListMode;
  if ClientListMode then begin
    Caption          := 'Phone Contact';
    TitleLabel.Caption := Caption;
  end;

  if ClientListMode then begin
    btnOk.Left       := 78;
    btnNext.Left     := btnOk.Left + btnOk.Width + 24;
    btnClient.Left   := btnNext.Left + btnNext.Width + 24;
    cmdFollowUp.Left := btnClient.Left + btnClient.Width + 24;
  end else begin
    btnOk.Left       := 191;
    cmdFollowUp.Left := btnOk.Left + btnOk.Width + 24;
  end;

  btnAppointment.Left := cmdFollowUp.Left + cmdFollowUp.Width + 24;
  cmdClose.Left := btnAppointment.Left + btnAppointment.Width + 24;
end;

procedure TfmFollowUp.cboListSelectionCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  // user has selected a new client list
  if cboListSelection.Text = '' then Exit;
  qryClientList.DisableControls;
  try
    qryClientList.Close;
    XMLData.Text := LookupTable.FieldByName('XMLData').AsString;
    qryClientList.ParamCheck := false;
    qryClientList.SQL.Clear;
    qryClientList.SQL.Text := ClientListSQL + 'HAVING ' + StringReplace(XMLData.Node['SQLSelect'].Attribute['SQL'].AsString,'tblmarketingcontacts.','',[rfReplaceAll, rfIgnoreCase]);

    //qryClientList.Prepared := true;
    qryClientList.Open;
  finally
    qryClientList.EnableControls;
  end;
  if qryClientList.RecordCount = 0 then CommonLib.MessageDlgXP_Vista('No record where found matching the criteria for this client list.',
      mtWarning, [mbOK], 0)
  else CommonLib.MessageDlgXP_Vista('Found ' + IntToStr(qryClientList.RecordCount) + ' matching records.', mtInformation, [mbOK], 0);

  btnNext.Enabled := not qryClientList.Eof;

  if not qryClientList.Eof then begin
    Self.ClientId := qryClientList.FieldByName('ClientId').AsInteger;
    Self.FormShow(Self);
  end;
end;

procedure TfmFollowUp.btnNextClick(Sender: TObject);
begin
  inherited;
  if not ValidateFormData then Exit;
  if qryFollowUp.State in [dsInsert, dsEdit] then qryFollowUp.Edit;
  qryFollowUp.FieldByName('UpdateDate').AsDateTime := Now;

  qryFollowUp.Post;

  if qryClient.State in [dsInsert, dsEdit] then qryClient.Post;

  if DBConnection = MyConnection then Self.CommitTransaction;

  UpdateEditTime;

  // go to next in list, skip records that already have follow-ups (possibly entered by other users)
  while (ContactHasFollowUps(qryClientList.FieldByName('ClientId').AsInteger)) and
    (not qryClientList.Eof) do qryClientList.Next;

  if not qryClientList.Eof then begin
    Self.ClientId := qryClientList.FieldByName('ClientId').AsInteger;
    Self.FormShow(Self);
  end;
  btnNext.Enabled := not qryClientList.Eof;
end;

procedure TfmFollowUp.btnClientClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  if ClientId > 0 then begin
    Form := GetComponentByClassName('TfrmOtherContact');
    if Assigned(Form) then begin
      with TfrmOtherContact(Form) do begin
        KeyId := ClientId;
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  end;
end;

procedure TfmFollowUp.CustomFieldsRefresh;
begin
  CustomFieldRefresh('CFOthr' ,pnlCustFields);
end;

function TfmFollowUp.ContactHasFollowUps(ClientId: integer): boolean;
begin
  qryCheckForFollowUps.ParamByName('ClientId').AsInteger := ClientId;
  qryCheckForFollowUps.Open;
  Result := not qryCheckForFollowUps.IsEmpty;
  qryCheckForFollowUps.Close;
end;

procedure TfmFollowUp.cboListSelectionDblClick(Sender: TObject);
var
  RangeSelectionId: integer;
  Form : TComponent;
begin
  inherited;

  RangeSelectionId := qryClientSelectionList.FieldByName('RangeSelectionId').AsInteger;
  if RangeSelectionId > 0 then begin
    Form := GetComponentByClassName('TfmMarketingContactSelectionRange');
    if Assigned(Form) then begin
      with TfmmarketingContactSelectionRange(Form) do begin
        KeyId := RangeSelectionId;
        //AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  end;
end;

procedure TfmFollowUp.cmdCustomLabelsOldClick(Sender: TObject);
begin
  OpenCustomFields;
(*Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfrmCustomFields');
  if Assigned(Form) then begin
    with TfrmCustomFields(Form) do begin
      AttachObserver(self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;*)
end;

procedure TfmFollowUp.UpdateMe;
begin
  inherited;
  CustomFieldsRefresh;
end;

procedure TfmFollowUp.UpdateEditTime;
begin
  if EditStartTime > 0 then begin
    cmd.SQL.Text := 'INSERT HIGH_PRIORITY INTO tblOtherFollowUpTime SET' + ' FollowUpId = ' +
      qryFollowUp.FieldByName('FollowupId').AsString + ',' + ' Duration = ' +
      QuotedStr(FormatDateTime(MysqlDateTimeFormat, Now - EditStartTime));
    cmd.Execute;
    EditStartTime := 0;
  end;
end;

procedure TfmFollowUp.SeTDNMSpeedButtons;
begin
  if qryFollowUp.Active and (ClientId > 0) then begin
    btnOk.Enabled := true;
    if IsPhoneFollowUp then cmdFollowUp.Enabled := true;
    btnAppointment.Enabled := true;
    if ClientListMode then begin
      btnNext.Enabled := true;
      btnClient.Enabled := true;
    end;
  end else begin
    btnOk.Enabled          := false;
    cmdFollowUp.Enabled    := false;
    btnAppointment.Enabled := false;
    if ClientListMode then begin
      btnNext.Enabled := false;
      btnClient.Enabled := false;
    end;
  end;
end;

procedure TfmFollowUp.qryFollowUpAfterOpen(DataSet: TDataSet);
begin
  inherited;
  SeTDNMSpeedButtons;
end;

procedure TfmFollowUp.qryFollowUpAfterClose(DataSet: TDataSet);
begin
  inherited;
  SeTDNMSpeedButtons;
end;

function TfmFollowUp.ValidateFormData: boolean;
begin
  Result := true;
  if Self.IsPhoneFollowUp and ((qryFollowup.FieldByName('ResultTypeID').AsInteger = 0) or
    (qryFollowup.FieldByName('ResultTypeID').IsNull)) then begin
    Result := false;
    CommonLib.MessageDlgXP_Vista('Please select a result', mtWarning, [mbOK], 0);
    SetControlFocus(cboFollowUpResult);
    Exit;
  end;
  if not ChkCustReqdFields then begin
      REsult := False;
      Exit;
  end;
end;

procedure TfmFollowUp.qryContactsPhoneGetText(Sender: TField; var Text: string; DisplayText: boolean);
var
  s: string;
begin
  inherited;
  // format the phone number
  s := StringReplace(Sender.AsString, ' ', '',[rfReplaceAll]);
  if char_length(s) = 10 then Text := FormatMaskText('00 0000 0000;0;*', s)
  else Text := Sender.AsString;
end;

procedure TfmFollowUp.AppointmentClosed(MsgObj: TMsgObj);
begin
  FreeAndNil(MsgObj);
  btnAppointmentClick(Self);
end;
function TfmFollowUp.ChkCustReqdFields: boolean;
begin
  Result := ChkReqdFields('Othr');
  if not Result then PageControl.ActivePage := Custom_Fields;
end;
initialization
  RegisterClassOnce(TfmFollowUp);
  with FormFact do begin
    // register all columns on course list form to open this form on DblClick
    RegisterMe(TfmFollowUp, 'TfmFollowUpList_*=FollowUpId');
    RegisterMe(TfmFollowUp, 'TfrmMarketingContactSummaryListGUI_*_Other Contact=FollowUpId');
  end;
end.




