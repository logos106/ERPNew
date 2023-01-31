{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 26/06/05  1.00.01 BJ   Bug fixed :Application breaks when new clicked here
                        Public function defined for the defualt values in all
                        4 calling forms - frmcustomer, frmjob, frmothercotnacts
                        and frmsupplier and newbtn click calls the function

                        A new string property defined to store the owner type
                        C:Customer , S:Supplier, CO: Other contacts , CJ: Jobs
 01/09/05  1.00.02 IJB  Reorganised forms logic with regards to Save/New/Cancel
                        processing to prevent posting of incomplete records.
 14/09/05  1.00.03 BJ   Savedata is broken into ValidateFormData and AfterPost
                        of the dataset as the Post was done after Savedata and
                        the functionality given within the savedata should be
                        executed after the record is posted.
 16/09/05  1.00.04 DSP  Removed the default setting of the 'Active' field of the
                        contact.
 19/09/05  1.00.05 IJB  Changed ContactName persistant field to readOnly = fase
                        (was giving a 'ContactName' cannot be modified error
                        when adding a contact from hire form). Changed
                        AfterPost to return correct Client Name to hire form.
 11/09/06  1.00.06 DSP  Removed ContactName, which was a concatenation of two
                        fields, as it could not be posted.
 06/02/07  1.00.07 DSP  The ClientID is now stored in CusID or SupID depending
                        on the calling form.
 23/03/09          RM   BusObjectized form               

}

unit frmContactFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db, StdCtrls, Mask, DBCtrls, ExtCtrls, BaseInputForm,
  Buttons, DNMSpeedButton, wwdblook, ComCtrls,AdvOfficeStatusBar, Variants,
  wwcheckbox, kbmMemTable, wwdbedit,
  ContactSelectorFrm, MemDS, DBAccess, MyAccess,ERPdbComponents, StrUtils,
  Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, Shader, DNMPanel,
  BusObjBase,
  ImgList, frmContactbase, BusObjContact, ProgressDialog, wwdbdatetimepicker,
  Wwdotdot, Wwdbcomb, Busobjcustomfields;

type
  TfrmContact = class(TfmContactbase)
    ContactID: TDBEdit;
    EditedFlag: TDBCheckBox;
    memqryContacts: TkbmMemTable;
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
    Label8: TLabel;
    qryContactsClientID: TIntegerField;
    qryContactsClientName: TWideStringField;
    qryContactsmsUpdateSiteCode: TWideStringField;
    qryContactsMainContactforCashSale: TWideStringField;
    qryContactsMainContactforVoucher: TWideStringField;
    qryContactsMainContactforPOS: TWideStringField;
    qryContactsMainContactforRefund: TWideStringField;
    qryContactsMainContactforInvoice: TWideStringField;
    qryContactsMainContactforSalesOrder: TWideStringField;
    qryContactsMainContactforStatements: TWideStringField;
    qryContactsMainContactforQuote: TWideStringField;
    qryContactsMainContactforCheque: TWideStringField;
    qryContactsMainContactforCredit: TWideStringField;
    qryContactsMainContactforBill: TWideStringField;
    qryContactsMainContactforPO: TWideStringField;
    qryContactsMainContactforRA: TWideStringField;
    qryContactsNotaMainContact: TWideStringField;
    qryContactsMainContactforRepair: TWideStringField;
    qryContactsDoNotContact: TWideStringField;
    qryContactsMainContactForSupplierPayment: TWideStringField;
    Bevel1: TBevel;
    Label10: TLabel;
    Label11: TLabel;
    Bevel3: TBevel;
    CUSTOM_FIELDS: TTabSheet;
    edtTeamviewerID: TwwDBEdit;
    chkNotaMainContact: TwwCheckBox;
    pnlMainContact: TDNMPanel;
    Label9: TLabel;
    chkMainContactforPOS: TwwCheckBox;
    chkMainContactforVoucher: TwwCheckBox;
    chkMainContactforCashSale: TwwCheckBox;
    chkMainContactforRefund: TwwCheckBox;
    chkMainContactforInvoice: TwwCheckBox;
    chkMainContactforSalesOrder: TwwCheckBox;
    chkMainContactforStatements: TwwCheckBox;
    chkMainContactforQuote: TwwCheckBox;
    chkMainContactforCheque: TwwCheckBox;
    chkMainContactforCredit: TwwCheckBox;
    chkMainContactforBill: TwwCheckBox;
    chkMainContactforPO: TwwCheckBox;
    chkMainContactforRA: TwwCheckBox;
    chkMainContactforRepair: TwwCheckBox;
    chkMainContactForSupplierPayment: TwwCheckBox;
    qryCustomFields: TERPQuery;
    //---
   cmdCustomLabels: TDNMSpeedButton;
   pnlCustFieldsTab: TDNMPanel;
   Label54: TLabel;
   Label55: TLabel;
   pgCustomFields: TPageControl;
   tabCustomFields: TTabSheet;
   pnlcustomfieldList: TDNMPanel;
   DNMPanel12: TDNMPanel;
    btnCopyShipping: TDNMSpeedButton;


    procedure cmdCloseClick(Sender: TObject);
    procedure cmdAddNewRecordClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure Notes_AfterUpdate;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure FormCreate(Sender: TObject);
    procedure SuburbEnter(Sender: TObject);
    procedure wwDBEdit1KeyPress(Sender: TObject; var Key: char);
    procedure qryContactsAfterPost(DataSet: TDataSet);
    procedure qrySuburbBeforeOpen(DataSet: TDataSet);
    procedure lblStateDblClick(Sender: TObject);
    procedure cmOriginalClick(Sender: TObject);
    procedure txtContactEmailDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure qryContactsNotaMainContactChange(Sender: TField);
    procedure qryContactsAfterOpen(DataSet: TDataSet);
    procedure cmdCustomLabelsOldClick(Sender: TObject);
    procedure TABCTL20DrawTab(Control: TCustomTabControl; TabIndex: Integer;
      const Rect: TRect; Active: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnCopyShippingClick(Sender: TObject);
  private
    fPassedConnection: TERPConnection;
//    fiemployeeId: Integer;
//    fisupplierId: Integer;
    fsClientName :String;

    fUpdateContactDetails: TUpdatecontact;
    fiClientID: integer;
    fOldConnection: TERPConnection;
    function GetClientType(iClientID: integer): string;
    procedure DoInitialise;


    Procedure SetcontractDefaults;
    procedure Check4MainContactoptions;
    procedure SetPassedConnection(const Value: TERPConnection);
    function GetClientTeamViewerId(iClientId : integer) : string;
    procedure SetConnections;
    procedure ResetConnections;

    property OldConnection : TERPConnection read fOldConnection write fOldConnection;
  Protected
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    procedure BeginTransaction; override;
    procedure CommitTransaction; override;
    procedure RollbackTransaction; override;
  public
    Contact :TContact;
    fsNewContact: string;

    Function CustomFieldExtenderListtype:TListType; Override;
//    Property SupplierId :Integer Read fisupplierId Write fisupplierId;
//    Property EmployeeID:Integer Read fiemployeeId Write fiemployeeId;
    Property UpdateContactDetails :TUpdatecontact read fUpdateContactDetails write fUpdateContactDetails;
    Property ClientID :Integer read fiClientId write fiClientID;//setClientID;
    Property ClientName :String read fsClientName write fsClientName;
//    property ContactIsCustomer: boolean read fContactIsCustomer write fContactIsCustomer;
//    property ContactIsJob: boolean read fContactIsJob write fContactIsJob;
//    property ContactIsSupplier: boolean read fContactIsSupplier write fContactIsSupplier;
//    property ContactIsOtherContact: boolean read fContactIsOtherContact write fContactIsOtherContact;
    Property PassedConnection :TERPConnection Read fPassedConnection Write SetPassedConnection;
  end;

var
  strCustomerName: string;

implementation

uses
  CommonDbLib, frmCustomerFrm, DNMLib, DNMExceptions,
  frmSupplier, FormFactory, frmJob,
  frmOtherContactFrm, {HireForm, frmUnitBookingsForm, }
  CommonLib, AppContextObj,  AppEnvironment, FastFuncs, BusObjConst,
  EmailUtilsDefaultMailClient, tcConst, DbSharedObjectsObj;

{$R *.DFM}

  /////////////////////////////////////////////////////
  // Before closing this form, test to see if we have
  // any calling forms.  If so, test to see if we
  // need to pass details back to it.
  /////////////////////////////////////////////////////
procedure TfrmContact.cmdCloseClick(Sender: TObject);
begin
  if FormStillOpen('TfrmContactSelector') then begin
    TfrmContactSelector(FindExistingComponent('TfrmContactSelector')).Show;
  end;
  CloseIt(False);
end;

procedure TfrmContact.cmdCustomLabelsOldClick(Sender: TObject);
begin
   OpenCustomFields;
end;

procedure TfrmContact.FormCreate(Sender: TObject);
begin
  Contact := TContact.Create(Self);
  Objcontact := contact;
  fbEmailchanged := false;
  if AppEnv.CompanyPrefs.UseDelivery then begin
    CheckRunLinesForExistingFields;
  end;

  inherited;
 fUpdateContactDetails := nil;
 fsClientName := '';

  qryCustomFields.Connection := CommonDbLib.GetSharedMyDacConnection;

end;

procedure TfrmContact.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then begin
    Key := 0;
  end
  else
    inherited;
end;

procedure TfrmContact.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseQueries;
  inherited;
  if PassedConnection = nil then
    self.RollbackTransaction;
  ResetConnections;
  Action := caFree;
end;

procedure TfrmContact.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  if contact.Dirty then begin
    CanClose := false;
    if Assigned(Owner) and (Owner is TfrmCustomer) and (TfrmCustomer(Owner).CustomerContactCount(contact.ID)=0) then begin
      MessageDlgXP_Vista('This Contact Record has to be saved as the Customer has no Contact.  It should have atleast one Contact. ', mtInformation, [mbOK], 0);
      if not contact.Save then Exit;
      CommitTransaction;
      Notify(false);
      ModalResult := mrOk;
    end else begin
      case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
        mrYes: begin
          if not contact.Save then Exit;

          CommitTransaction;
          Notify(false);
          ModalResult := mrOk;
        end;
        mrNo: begin
          contact.Cancel;
          self.RollbackTransaction;
        end;
        mrCancel:  Exit;
      end;
    end;
  end;
  (*
  else
  begin
    CommitTransaction;
  end;
  *)
CanClose := true;
end;

procedure TfrmContact.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      // ATTENTION: PassedConnection if set MUST not be in InTransaction state. If it
      // is, Nested Transactions will give exeptions in Commit and RollBack
      SetConnections;
      inherited;

      (*
      if Assigned(PassedConnection) then begin
        qryContacts.Connection:= PassedConnection;
      end;

      Contact.Connection  := TMyDacDataConnection.Create(Contact);
      if Assigned(PassedConnection) then
        TMyDacDataConnection(Contact.Connection).MydacConnection:= PassedConnection
      else
        TMyDacDataConnection(Contact.Connection).MydacConnection:= Self.MyConnection;
      *)
//      SetConnections;
      Contact.Connection  := TMyDacDataConnection.Create(Contact);
      TMyDacDataConnection(Contact.Connection).MydacConnection:= Self.MyConnection;
      Contact.BusObjEvent := DoBusinessObjectEvent;


      self.BeginTransaction;

      DoInitialise ;

      pnlMainContact.Parent := MainPanel;
      pnlMainContact.Top := 7;
      label10.Parent := MainPanel;

      TabCtl20.Top := pnlTitle.Top + pnlTitle.Height + 20;
      TabCtl20.Height := cmdOk.Top - 8 - TabCtl20.Top;
      TabCtl20.ActivePage := tsMain;
      TabCtl20.OnDrawTab := TabCtl20DrawTab;
      //
      SetControlFocus(txtContactFirstName);
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmContact.DoInitialise;
var
  tmpID:integer;
  qry:TERPQuery;
  strsql:string;
  lCustomer : boolean;
  lNewContact : boolean;

begin
  lNewContact := KeyId = 0;
  if KeyID = 0 then begin
    Contact.Load(0);
    Contact.New;
    Contact.PostDb;
    tmpID := Contact.ID;
    Contact.Load(tmpID);
    KeyID := tmpID;

    if ClientID <> 0 then begin
      Contact.ClientID := ClientID;
      strsql := 'SELECT ContactID,ClientID FROM tblcontacts WHERE Active = "T" and ClientId = ' + IntToStr(Contact.ClientID);
      qry := CommonDbLib.TempMyQuery;
      try
        if Assigned(PassedConnection) then  qry.Connection := PassedConnection;
        qry.SQL.Add(strsql);
        qry.Open;
        if qry.RecordCount = 0 then
          SetContractDefaults;
      finally
        FreeandNil(qry)
      end;
    end
    else
      SetContractDefaults;
  end else
  begin
    Contact.Load(KeyID);
    strSql := 'Select Customer from tblClients where ClientId = ' + IntToStr(Contact.ClientID);
    ClientId := Contact.ClientID;  // Otherwis btn New not going to work
  end;

  // Custom Fields tab visible only for customers
  strSql := 'Select Customer from tblClients where ClientId = ' + IntToStr(Contact.ClientID);
  qry := CommonDbLib.TempMyQuery;
  try
    if Assigned(PassedConnection) then
      qry.Connection := PassedConnection;
      qry.SQL.Text := strSql;
      qry.Open;
      if qry.RecordCount = 0 then
        lCustomer := false
      else
        lCustomer := qry.Fields[0].AsBoolean;
      finally
        FreeandNil(qry)
      end;

  if not lCustomer then
  begin
    CUSTOM_FIELDS.Visible := false;
    CUSTOM_FIELDS.Enabled := false;
    CUSTOM_FIELDS.Free;
//    RealignTabControl(TabCtl20, 1);
    // 2 steps, otherwise on settabvisible the active oage is lost
    tsMain.TabVisible := false;
    TabCtl20.ActivePage := tsMain;
  end
  else
  begin
    RealignTabControl(TabCtl20, 1);
//    RealignTabControl(pgCustomFields, 1);
    tabCustomFields.TabVisible := false;
    pgCustomFields.ActivePage := tabCustomFields;
  end;

  if AppContext.ContextExists('TfrmContact') then begin
      if AppContext['TfrmContact'].VarExists('FirstName') then
        if not(SameTExt(Contact.ContactFirstName , AppContext['TfrmContact'].VarByName['FirstName'])) then
          Contact.ContactFirstName := AppContext['TfrmContact'].VarByName['FirstName'];

      if AppContext['TfrmContact'].VarExists('LastName') then
        if not(Sametext(Contact.ContactSurName , AppContext['TfrmContact'].VarByName['LastName'])) then
          Contact.ContactSurName := AppContext['TfrmContact'].VarByName['LastName'];

      AppContext.DeleteContext('TfrmContact'); //??
  end;

//  lblCustType.Caption := GetClientType(Contact.CusID);
  lblCustType.Caption := GetClientType(Contact.ClientID);


  if Contact.TeamviewerID = '' then
  begin
    Contact.TeamviewerID := GetClientTeamViewerId(Contact.ClientID);
    // No idea why the following, but in a case of a new contact it breaks a lot - so add lNewContact
    Contact.Dirty :=  (Contact.TeamviewerID <> '') or lNewContact;

  end;

  (* if not DataState.IsActive then
    DataState.Activate; *)
end;


procedure TfrmContact.cmdAddNewRecordClick(Sender: TObject);
begin
  if contact.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes: begin
        if not contact.Save then Exit;
        CommitTransaction;
        fbEmailchanged:= false;
      end;
      mrNo: begin
        contact.Cancel;
        self.RollbackTransaction;
      end;
      mrCancel:  Exit;
    end;
  end
  else
  begin
    CommitTransaction;
  end;
  KeyID := 0;
  self.BeginTransaction;
  DoInitialise;
  SetControlFocus(txtCompany);
end;

procedure TfrmContact.BeginTransaction;
begin
  inherited;
  if Assigned(self.PassedConnection) then
    Contact.Connection.BeginNestedTransaction;
end;

procedure TfrmContact.btnCopyShippingClick(Sender: TObject);
var
//  scr : TERPScript;
  qry : TERPQuery;
  lNewRec : boolean;
  ShipId : integer;
  s : string;
begin
  inherited;
//
//  scr := TERPScript.Create(nil);
  qry := TERPQuery.Create(nil);
  lNewRec := false;
  try
    qry.Connection := qryContacts.Connection;
    qry.sql.Text := 'select * from tblShippingAddress where Customer_ID='+ qryContacts.FieldByName('ClientId').asString;
    qry.Open;
    if qry.Locate('ContactName', qryContacts.FieldByName('Company').asString, [loCaseInsensitive]) then
    begin
      qry.Edit;
      lNewRec := false;
    end
    else
    begin
      qry.Append;
      lNewRec := true;
    end;
    if qry.FieldByName('Customer_Id').asInteger <> qryContacts.FieldByName('ClientId').asInteger then
      qry.FieldByName('Customer_Id').asInteger := qryContacts.FieldByName('ClientId').asInteger;
    qry.FieldByName('ContactName').AsString       := qryContacts.FieldByName('Company').AsString;
    qry.FieldByName('CompanyName').AsString       := qryContacts.FieldByName('ClientName').AsString;
    qry.FieldByName('ShipAddress').AsString       := qryContacts.FieldByName('ContactAddress').AsString;
    qry.FieldByName('ShipAddress1').AsString      := qryContacts.FieldByName('ContactAddress2').AsString;
    qry.FieldByName('ShipAddress2').AsString      := qryContacts.FieldByName('ContactAddress3').AsString;
    qry.FieldByName('ShipCity').AsString          := qryContacts.FieldByName('ContactCity').AsString;
    qry.FieldByName('ShipPostCode').AsString      := qryContacts.FieldByName('ContactPcode').AsString;
    qry.FieldByName('ShipState').AsString         := qryContacts.FieldByName('ContactState').AsString;
    qry.FieldByName('ShipCountry').AsString       := qryContacts.FieldByName('ContactCountry').AsString;
    qry.FieldByName('Active').AsBoolean           := True;
    qry.FieldByName('Phone').AsString             := qryContacts.FieldByName('ContactPH').AsString;
    qry.FieldByName('email').AsString             := qryContacts.FieldByName('ContactEmail').AsString;
    qry.FieldByName('CustomerPhysicalAddress').AsString  := 'F';
    qry.Post;
    if lNewRec then
    begin
      // Create Link
      ShipId := qry.FieldByName('ShipAddressId').AsInteger;
      qry.Close;
      qry.SQL.Text := 'select * from tblClientToShipAddressLink where ClientId=' + qryContacts.FieldByName('ClientId').asString +
                      ' and ShipAddressId=' + IntToStr(ShipId);
      qry.Open;
      if qry.RecordCount = 0 then
        qry.Append
      else
        qry.Edit;
      qry.FieldByName('ClientId').AsInteger := qryContacts.FieldByName('ClientId').AsInteger;
      qry.FieldByName('ShipAddressId').AsInteger := ShipId;
      qry.Post;
    end;
  finally
    qry.Free;
    Notify(false);
    if lNewRec then
      s := ' Created'
    else
      s := ' Edited';
    MessageDlgXP_Vista('Shipping Address for ' + qryContacts.FieldByName('Company').AsString + ' Has Been ' + s, mtInformation, [mbok], 0);
  end;

end;

procedure TfrmContact.btnOkClick(Sender: TObject);
begin
  if not Contact.Dirty then begin
    self.CommitTransaction;
    Notify(false);
    CloseIt(true);
  end  else if Contact.Save then begin
      if assigned(fUpdateContactDetails) then fUpdateContactDetails(qryContacts);
      self.CommitTransaction;
      Notify(false);
      CloseIt(true);
  end;
end;

procedure TfrmContact.Notes_AfterUpdate;
begin
  txtNotes.Text := txtNotes.Text + ' :' + DateToStr(Date) + ' :' + TimeToStr(Time);
end;

procedure TfrmContact.SuburbCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  FillTable.FieldByName('ContactState').asString := LookupTable.FieldByName('State').asString;
  FillTable.FieldByName('ContactPcode').asString := LookupTable.FieldByName('Postcode').asString;
  FillTable.FieldByName('ContactCountry').asString := LookupTable.FieldByName('Country').asString;
end;

procedure TfrmContact.SuburbEnter(Sender: TObject);
begin
  inherited;
  if not (qrySuburb.Active) then begin
    qrySuburb.Active := true;
  end;
end;

procedure TfrmContact.TABCTL20DrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
begin
  Control.Canvas.Font.Style := [fsBold];
  PageControlDrawTab(Control, TabIndex,Rect,ACtive);
end;

function TfrmContact.GetClientTeamViewerId(iClientId: integer): string;
var
  qry: TERPQuery;
begin
  Result := '';
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      Close;
      SQL.Clear;
      SQL.Add(Format('SELECT TeamViewerId FROM tblClients WHERE ClientID = %d', [iClientId]));
      Open;
      if not IsEmpty then begin
        Result := qry.Fields[0].asString;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TfrmContact.GetClientType(iClientID: integer): string;
var
  qry: TERPQuery;
begin
  Result := '';
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT TypeName  ' +
        'FROM tblClients ' +
        'INNER JOIN tblClientType Using (ClientTypeID) ' +
        'WHERE ClientID = :xClientID');
      ParamByName('xClientID').asInteger := iClientID;
      Open;
      if not IsEmpty then begin
        Result := qry.FieldByName('TypeName').AsString;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;



procedure TfrmContact.wwDBEdit1KeyPress(Sender: TObject; var Key: char);
var
  iKey: integer;
begin
  inherited;
  iKey := Ord(Key);
  // Only accept keys of 0-9 or backspace - anything else is refused!
  if (iKey <> 8) and ((iKey < 48) or (iKey > 57)) then begin
    Key := #0;
    Exit;
  end;
end;

procedure TfrmContact.qryContactsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  Check4MainContactoptions;
end;

procedure TfrmContact.qryContactsAfterPost(DataSet: TDataSet);
var
  sName: string;                    {maybe move this to BusObj}
  iClientID, iContactID: integer;
  qry, qryUpdate: TERPQuery;
begin
  sName := qryContactsContactFirstName.AsString;
  if (sName <> '') and (qryContactsContactSurName.AsString <> '') then
    sName := sName + ' ' + qryContactsContactSurName.AsString;
  if fiClientID = 0 then begin
   // Notify;
  end;

  iClientID := qryContacts.FieldByName('ClientID').AsInteger;
  iContactID := qryContacts.FieldByName('ContactID').AsInteger;
  if AppEnv.CompanyPrefs.UseDelivery then begin
    qry       := TERPQuery.Create(nil);
    qry.Options.FlatBuffers := True;
    qryUpdate := TERPQuery.Create(nil);
    qryUpdate.Options.FlatBuffers := True;
    try
      qry.Connection := CommonDbLib.GetSharedMyDacConnection;
      qry.SQL.Clear;
      qryUpdate.Connection := CommonDbLib.GetSharedMyDacConnection;
      qryUpdate.SQL.Clear;
      qryUpdate.ParamCheck := true;

      qry.SQL.Add('SELECT');
      qry.SQL.Add('C.ClientID, C.Company,');
      qry.SQL.Add('TRIM(CONCAT_WS(" ", IF(ISNULL(C.ContactTitle), "", C.ContactTitle), C.ContactFirstname, C.ContactSurName)) AS "Contact",');
      qry.SQL.Add('TRIM(LEFT(CONCAT_WS(" ", C.ContactAddress, IF(ISNULL(C.ContactAddress2), "", C.ContactAddress2),');
      qry.SQL.Add('IF(ISNULL(C.ContactCity), "", C.ContactCity),');
      qry.SQL.Add(
        'IF(ISNULL(C.ContactState), "", C.ContactState), IF(ISNULL(C.ContactPcode), "", C.ContactPcode)), 200)) AS "Address", C.ContactMob AS "Mobile", C.ContactPh As "Phone",');
      qry.SQL.Add('C.ContactCity, C.ContactPCode');
      qry.SQL.Add('FROM tblcontacts AS C');
      qry.Open;

      if qry.RecordCount > 0 then begin
        qryUpdate.SQL.Add('UPDATE `tblrunslines` SET ClientName = :xClientName, Address = :xAddress,');
        qryUpdate.SQL.Add('Phone = :xPhone, Mobile = :xMobile');
        qryUpdate.SQL.Add('WHERE ClientID = :xClientID AND IsContact = "T" AND ContactID = :xContactID');
        qryUpdate.Params.ParamByName('xClientName').AsString := qry.FieldByName('Contact').AsString;
        qryUpdate.Params.ParamByName('xAddress').AsString := qry.FieldByName('Address').AsString;
        qryUpdate.Params.ParamByName('xMobile').AsString := qry.FieldByName('Mobile').AsString;
        qryUpdate.Params.ParamByName('xPhone').AsString := qry.FieldByName('Phone').AsString;
        qryUpdate.Params.ParamByName('xClientID').AsInteger := iClientID;
        qryUpdate.Params.ParamByName('xContactID').AsInteger := iContactID;
        qryUpdate.Execute;
      end;

    finally
      if Assigned(qry) then FreeAndNil(qry);
      if Assigned(qryUpdate) then
        FreeandNil(qryUpdate);
    end;
  end;
end;

procedure TfrmContact.qryContactsNotaMainContactChange(Sender: TField);
begin
  Check4MainContactoptions;
end;

procedure TfrmContact.Check4MainContactoptions;
var
  ctr:Integer;
  fbEnabled :Boolean;
begin
  inherited;
  fbEnabled  := (qryContactsNotaMainContact.asBoolean =False) and (accesslevel <= 2);
  for ctr := 0 to ComponentCount-1 do begin
    if (Components[ctr] is TwwCheckBox) and  (TwwCheckBox(Components[ctr]).parent = pnlMainContact) then begin
      TwwCheckBox(Components[ctr]).REadonly :=not(fbEnabled );
      if fbEnabled  then TwwCheckBox(Components[ctr]).font.Color := clBlack else TwwCheckBox(Components[ctr]).font.color := clGray;
    end;
  end;
  if fbEnabled  then
    pnlMainContact.hint := 'Select if the contact is the main contact for any of the actions listed'+NL
  else if qryContactsNotaMainContact.asBoolean then
    pnlMainContact.hint := 'As the contact is selected as "Do not use as any Main contact",'+NL+'it is not possible to select any of these options.' +NL;
end;

procedure TfrmContact.qrySuburbBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qrySuburb.Params.ParamByName('xRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

procedure TfrmContact.ResetConnections;
var
  idx : integer;
begin
  if not assigned(PassedConnection) then
    exit;
//  PassedConnection.Commit;
  MyConnection := OldConnection;
  for idx := 0 to ComponentCount - 1 do
    if Components[idx] is TERPQuery then
      if Components[idx] <> qryCustomFields then
        (Components[idx] as TERPQuery).Connection := OldConnection;
end;

procedure TfrmContact.RollbackTransaction;
begin
    if Assigned(self.PassedConnection) then
      Contact.Connection.RollbackNestedTransaction;

  inherited;
end;

procedure TfrmContact.lblStateDblClick(Sender: TObject);
begin
  ShowMessage(TLabel(Sender).Caption);
end;



procedure TfrmContact.SetConnections;
var
  idx : integer;
begin
  if not assigned(PassedConnection) then
    exit;
//  PassedConnection.StartTransaction;
  OldConnection := MyConnection;
  MyConnection := PassedConnection;
  for idx := 0 to ComponentCount - 1 do
    if Components[idx] is TERPQuery then
      if Components[idx] <> qryCustomFields then
      (Components[idx] as TERPQuery).Connection := PassedConnection;
end;

procedure TfrmContact.SetContractDefaults;
var
  strSQL :STring;
  firstrec:Boolean;
  qry :TERPQuery;
begin
//  if (ClientID = 0) and (supplierId =0) then Exit;
  if (ClientID = 0) then exit;
  strSQL:= 'SELECT Company, ClientID,Title,FirstName,LastName,Phone,FaxNumber,Mobile,JobTitle,Email,' +
            'AltPhone,Street,Street2,Street3,Suburb,State,Postcode, country, supplier, customer, Othercontact, Isjob , TeamviewerID ' +
            ', Customer ' +
            'from tblClients where ClientID = ' + IntToStr(ClientID) ;
  Qry := DbSharedObjectsObj.DbSharedObj.GetQuery(contact.connection.connection);
  try
  with qry do begin
    SQL.add('select * from tblcontacts where Active = "T"');
    SQL.add('and ClientID = ' +IntToStr(ClientID));
    open;
    firstrec := recordcount = 0;
    close;

    SQL.clear;
    if assigned(fPassedConnection) then connection := fPassedConnection;
    SQL.add(strSQL);
    open;
    if recordcount = 0 then exit;

    if firstrec then begin
      Contact.ContactTitle      := fieldByname('Title').asSTring;
      Contact.ContactFirstName  := fieldByname('FirstName').asSTring;
      Contact.ContactSurName    := fieldByname('LastName').asSTring;
      Contact.ContactMOB        := fieldByname('Mobile').asSTring;
      Contact.jobtitle          := fieldByname('JobTitle').asSTring;
      Contact.ContactEmail      := fieldByname('Email').asSTring;
      Contact.Company:= Trim(Contact.ContactFirstName + ' ' + Contact.ContactSurname);
      Contact.ISPrimaryContact  := True;
    end;
    Contact.ContactPH             := fieldByname('Phone').asSTring;
    Contact.ContactFax            := fieldByname('FaxNumber').asSTring;
    Contact.ContactAltPH          := fieldByname('AltPhone').asSTring;
    Contact.ContactAddress        := fieldByname('Street').asSTring;
    Contact.ContactAddress2       := fieldByname('Street2').asSTring;
    Contact.ContactAddress3       := fieldByname('Street3').asSTring;
    Contact.ContactCity           := fieldByname('Suburb').asSTring;
    Contact.ContactState          := fieldByname('State').asSTring;
    Contact.ContactPcode          := fieldByname('Postcode').asSTring;
    Contact.Contactcountry        := fieldByname('Country').asSTring;
    contact.TeamviewerID          := FieldByname('TeamviewerID').asString;
    Contact.Active                := True;
  end;

  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;

end;

procedure TfrmContact.SetPassedConnection(const Value: TERPConnection);
begin
  fPassedConnection := Value;
end;

procedure TfrmContact.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TContact then
      TContact(Sender).DataSet := qryContacts;
  end;
end;

procedure TfrmContact.cmOriginalClick(Sender: TObject);
begin
  inherited;
  SetcontractDefaults;
  SetControlFocus(txtContactFirstName);
end;

procedure TfrmContact.CommitTransaction;
begin

    if Assigned(self.PassedConnection) then
      Contact.Connection.CommitNestedTransaction;

  inherited;

end;

function TfrmContact.CustomFieldExtenderListtype: TListType;
begin
  Result := ltContact;
end;

procedure TfrmContact.txtContactEmailDblClick(Sender: TObject);
begin
  inherited;
  if qryContactsContactEmail.AsString <> '' then
    EmailUtilsDefaultMailClient.SendMail(qryContactsContactEmail.AsString,'','');
end;

initialization
  RegisterClassOnce(TfrmContact);
  with FormFact do begin
    RegisterMe(TfrmContact, 'TGlobalListFrm_*_Contact=ID');
    (*RegisterMe(TfrmContact, 'TCustomerContactListGui_*_Contact=ContactId');*)
    RegisterMe(TfrmContact, 'TCustomFieldValuesListContactGUI_*_Contact=ContactId');
    RegisterControl(TfrmContact, '*_cboContact=ContactID');
  end;
end.




