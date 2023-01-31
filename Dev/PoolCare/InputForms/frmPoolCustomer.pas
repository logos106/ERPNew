unit frmPoolCustomer;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
22/03/05  1.00.00  BJ  Initial verson.
26/09/05  1.00.01  BJ  Removed HandleUnknownException (now handled by new
                       ExceptionalMagic code
11/01/06  1.00.03  BJ  Save closing the form after saving
                       Combo lists are orderd in alphabetic order
06/03/06  1.00.04  DSP Removed fbIgnoreAccessLevels so access levels are now
                       checked.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DataState, DBAccess, MyAccess, SelectionDialog,
  AppEvnts, DB,  StdCtrls, Mask, DBCtrls, wwcheckbox, Buttons, DNMSpeedButton,
  ExtCtrls, DNMPanel, ActnList, MemDS, wwdblook, wwdbedit, Wwdatsrc,
  Wwdotdot, Wwdbcomb, Wwdbgrid, Grids, Wwdbigrd, Menus, AdvMenus, Shader;

type
  TfmPoolCustomer = class(TBaseInputGUI)
    pnlBottom: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnNew: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    alMain: TActionList;
    actMainSave: TAction;
    actMainNew: TAction;
    actMainCancel: TAction;
    DNMPanel1: TDNMPanel;
    qryPoolProfile: TMyQuery;
    Label38: TLabel;
    cboClient: TwwDBLookupCombo;
    qryClient: TMyQuery;
    dsPoolProfile: TwwDataSource;
    qryClientCompany: TStringField;
    qryPoolProfilePoolProfileID: TIntegerField;
    qryPoolProfileClient: TStringField;
    qryPoolProfileVolume: TIntegerField;
    qryPoolProfileLocation: TStringField;
    qryPoolProfileConstruction: TStringField;
    qryPoolProfileSanitizer: TStringField;
    qryPoolProfileUsesMSA: TStringField;
    qryPoolProfileIsSpa: TStringField;
    qryPoolProfileSaltRequired: TIntegerField;
    qryPoolProfileDateEntered: TDateField;
    qryPoolProfileGlobalRef: TStringField;
    qryPoolProfileActive: TStringField;
    dsClient: TwwDataSource;
    qryClientTitle: TStringField;
    qryClientFirstName: TStringField;
    qryClientLastName: TStringField;
    qryClientPhone: TStringField;
    qryClientFaxNumber: TStringField;
    qryClientAltPhone: TStringField;
    qryClientMobile: TStringField;
    DNMPanel3: TDNMPanel;
    Label1: TLabel;
    edtVolume: TwwDBEdit;
    Label2: TLabel;
    cboLocation: TwwDBComboBox;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    edtSaltRequired: TwwDBEdit;
    actCustomer: TAction;
    acTests: TAction;
    qryClientClientID: TIntegerField;
    pnlTop: TDNMPanel;
    BitBtn1: TDNMSpeedButton;
    qryPoolProfileSanitizerlvl: TIntegerField;
    Label8: TLabel;
    edtSanitizerLevel: TwwDBEdit;
    cboConstruction: TwwDBLookupCombo;
    cboSanitizer: TwwDBLookupCombo;
    qryConstruction: TMyQuery;
    qrySnitizer: TMyQuery;
    qryConstructionTestCategoriesID: TIntegerField;
    qryConstructionName: TStringField;
    qrySnitizerTestCategoriesID: TIntegerField;
    qrySnitizerName: TStringField;
    BitBtn2: TDNMSpeedButton;
    qryPoolProfileClientID: TIntegerField;
    chkMSAUsed: TwwCheckBox;
    chkSpa: TwwCheckBox;
    Label50: TLabel;
    chkActive: TwwCheckBox;
    Label25: TLabel;
    Label27: TLabel;
    Label74: TLabel;
    Label78: TLabel;
    Label31: TLabel;
    Label76: TLabel;
    Label33: TLabel;
    Label13: TLabel;
    txtCompany: TDBEdit;
    txtContactTitle: TDBEdit;
    txtContactFirstName: TDBEdit;
    txtContactLastName: TDBEdit;
    txtPhoneNumber: TDBEdit;
    txtFaxNumber: TDBEdit;
    txtAltPhone: TDBEdit;
    txtMobile: TDBEdit;
    Bevel2: TBevel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure actMainSaveExecute(Sender: TObject);
    procedure actMainNewExecute(Sender: TObject);
    procedure actMainCancelExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure cboClientDropDown(Sender: TObject);
    procedure cboClientEnter(Sender: TObject);
    procedure cboClientCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure actCustomerExecute(Sender: TObject);
    procedure acTestsExecute(Sender: TObject);
    procedure qryPoolProfileBeforePost(DataSet: TDataSet);
    procedure cboClientDblClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    procedure DoOpenData;
    function ValidateFormData: boolean;
    function SaveData: boolean;
    // Procedure GetCustID(grdMain :TwwDbGrid);
    procedure SetCustListSql;
    procedure ShowCustDetails(Visible: boolean);
  public
    { Public declarations }
    CustId: integer;
    procedure UpdateMe; override;
  end;

implementation

{$R *.dfm}

uses
  BaseClassFuncs, 
  DNMExceptions,  // For exception handling in FormShow
  FormFactory, PoolProfileTestList,    // Only required if FormFact used in initialization
  PrintTemplateObj, CommonLib, BaseListingForm, FastFuncs;

procedure TfmPoolCustomer.ShowCustDetails(Visible: boolean);
begin
  if Visible then begin
    txtCompany.Text          := cboClient.Lookuptable.FieldByName('Company').AsString;
    txtContactTitle.Text     := cboClient.Lookuptable.FieldByName('Title').AsString;
    txtContactFirstName.Text := cboClient.Lookuptable.FieldByName('FirstName').AsString;
    txtContactLastName.Text  := cboClient.Lookuptable.FieldByName('LastName').AsString;
    txtPhoneNumber.Text      := cboClient.Lookuptable.FieldByName('Phone').AsString;
    txtFaxNumber.Text        := cboClient.Lookuptable.FieldByName('FaxNumber').AsString;
    txtAltPhone.Text         := cboClient.Lookuptable.FieldByName('AltPhone').AsString;
    txtMobile.Text           := cboClient.Lookuptable.FieldByName('Mobile').AsString;
  end else begin
    txtCompany.Text          := '';
    txtContactTitle.Text     := '';
    txtContactFirstName.Text := '';
    txtContactLastName.Text  := '';
    txtPhoneNumber.Text      := '';
    txtFaxNumber.Text        := '';
    txtAltPhone.Text         := '';
    txtMobile.Text           := '';
  end;
end;

procedure TfmPoolCustomer.SetCustListSql;
begin
  with qryClient do begin
    if Active then Close;
    Sql.Clear;
    Sql.add('SELECT C1.ClientID AS ClientID, C1.Company AS Company, ');
    Sql.add('C1.Title, C1.FirstName, C1.LastName, C1.Phone,  ');
    Sql.add('C1.FaxNumber, C1.AltPhone, C1.Mobile ');
    Sql.add(' FROM tblclients C1 ');
    if KeyId <> 0 then begin
      Sql.add(' WHERE C1.Customer=''T'' AND Length(C1.Company)>0 ');
      Sql.add(' AND C1.Active = ''T'' ');
    end else begin
      Sql.add(' LEFT JOIN tblpoolprofile ON  ');
      Sql.add(' C1.ClientID = tblpoolprofile.ClientID ');
      Sql.add(' WHERE C1.Customer=''T'' AND Length(C1.Company)>0 ');
      Sql.add(' AND C1.Active = ''T''  and tblpoolprofile.ClientID is null');
    end;
    SQL.add('Order by C1.Company');
    Open;
  end;
  ShowCustDetails((KeyID <> 0) or (CustId <> 0));
end;

  //Procedure TfmPoolCustomer.GetCustID(grdMain :TwwDbGrid);
  //begin
  //  with qryPoolProfile do begin
  //    if State in [dsInsert] then begin
  //      cboClient.LookupTable.Locate('ClientId',grdMain.DataSource.DataSet.FieldByName('ClientID').AsInteger, [loCaseInsensitive]);
  //      FieldByname('ClientID').ASInteger :=grdMain.DataSource.DataSet.FieldByName('ClientID').AsInteger;
  //      cboClient.LookupTable.Refresh;
  //      ShowCustDetails(True);
  //    end;
  //  end;
  //end;

// ---------- Form Events ------------------------------------------------------

procedure TfmPoolCustomer.FormCreate(Sender: TObject);
begin
//  Self.fbIgnoreAccessLevels := true;
  inherited;
  // If user does not have access to this form so don't process any further
  if ErrorOccurred then Exit;
end;

procedure TfmPoolCustomer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  RollbackTransaction;
  Action := caFree;
end;

procedure TfmPoolCustomer.FormShow(Sender: TObject);
begin
  try
    inherited;
    // If user does not have access to this form don't process any further
    if ErrorOccurred then Exit;
    DoOpenData;
    SetCustListSql;
    // Exception Handler
  except
    // Handle these known exceptions.
    on EAbort do HandleEAbortException;
    on e: ENoAccess do begin
      HandleNoAccessException(e);
      Exit;
    end;
    //on e: Exception do HandleUnknownException(e);
    on e: Exception do raise;
  end;
end;

procedure TfmPoolCustomer.DoOpenData;
begin
  // rollback if form is called when already open
  RollbackTransaction;
  if qryClient.Active = false then qryClient.Open;
  with qryPoolProfile do begin
    Close;
    ParamByName('PoolProfileID').AsInteger := KeyId;
    Open;
    if RecordCount = 0 then begin
      Insert;
      FieldByName('Active').AsBoolean := true;
      if CustId <> 0 then begin
        cboClient.LookupTable.Locate('ClientID', CustID, []);
        FieldByName('ClientID').AsInteger := CustID;
      end;
    end;
  end;
  DataState.Activate;
  with qryConstruction do if Active = false then Open;
  with qrySnitizer do if Active = false then Open;
end;


// ---------- Main Actions -----------------------------------------------------

procedure TfmPoolCustomer.actMainSaveExecute(Sender: TObject);
begin
  inherited;
  if qryPoolProfile.State in [dsEdit, dsInsert] then begin
    if not SaveData then Exit;
    CommitTransaction;
    Notify;
    DataState.Dirty := false;
  end;
  Self.Close;
  SetCustListSql;
end;

procedure TfmPoolCustomer.actMainNewExecute(Sender: TObject);
begin
  inherited;
  if DataState.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes: 
        begin
          if not SaveData then Exit
          else begin
            CommitTransaction;
            Notify;
          end;
        end;
      mrNo: 
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
        end;
      mrCancel: 
        begin
          Exit;
        end;
    end;
  end;

  KeyID := 0;
  SetCustListSql;
  DoOpenData;
  DataState.Dirty := false;
  SetControlFocus(cboClient);
end;

procedure TfmPoolCustomer.actMainCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

// ---------- Form Methods/Functions -------------------------------------------

procedure TfmPoolCustomer.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
  // If user does not have access to this form don't process any further
  if ErrorOccurred then Exit;

  CanClose := false;
  if DataState.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes: 
        begin
          if SaveData then begin
            CommitTransaction;
            Notify;
            CanClose := true;
          end;
        end;
      mrNo: 
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
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
end;

function TfmPoolCustomer.ValidateFormData: boolean;
begin
  Result := false;
  if cboClient.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('Customer cannot be blank.', mtError, [mbOK], 0);
    SetControlFocus(cboClient);
    Exit;
  end;
  if cboLocation.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('Location cannot be blank.', mtError, [mbOK], 0);
    SetControlFocus(cboLocation);
    Exit;
  end;
  if cboConstruction.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('Construction type cannot be blank.', mtError, [mbOK], 0);
    SetControlFocus(cboConstruction);
    Exit;
  end;
  if cboSanitizer.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('Sanitizer cannot be blank.', mtError, [mbOK], 0);
    SetControlFocus(cboSanitizer);
    Exit;
  end;
  if edtSanitizerLevel.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('Sanitizer Level cannot be blank.', mtError, [mbOK], 0);
    SetControlFocus(edtSanitizerLevel);
    Exit;
  end;

  if edtVolume.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('Volume cannot be blank.', mtError, [mbOK], 0);
    SetControlFocus(edtVolume);
    Exit;
  end;
  Result := true;
  // validate form data and set true if all ok
end;

function TfmPoolCustomer.SaveData: boolean;
begin
  Result := true;
  if not (qryPoolProfile.State in [dsinsert, dsEdit]) then Exit;
  Result := false;
  if ValidateFormData then begin
    with qryPoolProfile do begin
      if State = dsInsert then FieldByName('DateEntered').AsDateTime := Date;
      Post;
      KeyId := qryPoolProfile.FieldByName('PoolProfileID').AsInteger;
    end;
  end else Exit;

  Result := true;
end;

procedure TfmPoolCustomer.UpdateMe;
begin
  // Close/re-open queryies to refresh data
end;

  // Include this section if this for is to be opened by double clicking on a
  // list form. Replace the values indicated with <> below.

procedure TfmPoolCustomer.cboClientDropDown(Sender: TObject);
begin
  inherited;
  if qryPoolProfile.State in [dsInsert] then SetControlFocus(edtVolume);
end;

procedure TfmPoolCustomer.cboClientEnter(Sender: TObject);
begin
  inherited;
  if KeyID <> 0 then SetControlFocus(cboLocation);
end;

procedure TfmPoolCustomer.cboClientCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  ShowCustDetails(true);
  //DNMPanel2.Visible := True;
end;

procedure TfmPoolCustomer.actCustomerExecute(Sender: TObject);
begin
  if cboClient.DataSource.DataSet.FieldByName('ClientId').AsInteger <> 0 then
    with BaseClassFuncs.GetBaseInputByClassName('TfrmCustomer', false) do begin
      KeyId := cboClient.DataSource.DataSet.FieldByName('ClientId').AsInteger;
      FormStyle := fsMdiChild;
      BringToFront;
    end;
end;

procedure TfmPoolCustomer.acTestsExecute(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  if DataState.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes: 
        begin
          if not SaveData then Exit
          else begin
            CommitTransaction;
            Notify;
          end;
        end;
      mrNo: 
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
        end;
      mrCancel: 
        begin
          Exit;
        end;
    end;
  end;

  if KeyId = 0 then Exit;
  DataState.Dirty := false;
  Form := GetComponentByClassName('TPoolProfileTestListGUI');
  if Assigned(Form) then begin
    with TPoolProfileTestListGUI(Form) do begin
      PoolProfileId := Self.KeyID;
      {edtlocation.Text := cboLocation.Text;
      edtSanitizer.Text := cboSanitizer.text;
      edtVolume.Text := edtVolume.Text;
      edtSanitizerLvl.Text := edtSaltRequired.Text;
      edtConstruction.Text := cboConstruction.text;
      cbxMSA.Checked := chkMSAUsed.Checked;
      cbxSpa.Checked := chkSpa.Checked;}
      FormStyle := fsMdiChild;
      BringToFront;
      if qryMain.RecordCount = 0 then actNewExecute(Sender)
      else if qryMain.RecordCount = 1 then actdblClickGirdExecute(Sender);
    end;
  end;  
end;

procedure TfmPoolCustomer.qryPoolProfileBeforePost(DataSet: TDataSet);
begin
  inherited;
  with qryPoolProfile do begin
    if chkMSAUsed.Checked then FieldByName('UsesMSA').AsString := 'T'
    else FieldByName('UsesMSA').AsString := 'F';
    if chkSpa.Checked then FieldByName('IsSpa').AsString := 'T'
    else FieldByName('IsSpa').AsString := 'F';
  end;
end;

procedure TfmPoolCustomer.cboClientDblClick(Sender: TObject);
begin
  //  inherited;
  actCustomerExecute(Sender);
end;

procedure TfmPoolCustomer.BitBtn2Click(Sender: TObject);
var
  SQLSelect: string;
begin
  inherited;
  if DataState.Dirty then begin
    case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) of
      mrYes: 
        begin
          if not SaveData then Exit
          else begin
            CommitTransaction;
            Notify;
          end;
        end;
      mrNo: 
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
        end;
      mrCancel: 
        begin
          Exit;
        end;
    end;
  end;

  if KeyId = 0 then Exit;
  
  SQLSelect := '~|||~WHERE tblpoolprofile.PoolProfileID = ' + FastFuncs.IntToStr(KeyID);
  PrintTemplate.PrintTemplateReport('Pool Profile', SQLSelect, false, 1);
end;

initialization
  RegisterClassOnce(TfmPoolCustomer);
   with FormFact do begin
    //RegisterMe(TfmPoolCustomer, 'TfrmCustomer_ClientID_*=ClientID');
    RegisterMe(TfmPoolCustomer, 'TPoolProfileListGUI_*=PoolProfileId');
  end;
end.
