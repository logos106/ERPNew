unit frmDeductionsUSAFrm;

interface

uses
  Windows, BaseInputForm, DB, Controls, ExtCtrls, DNMPanel, Wwdotdot,
  Wwdbcomb, wwdblook, StdCtrls, wwcheckbox, Buttons, DNMSpeedButton, Mask, wwdbedit,
  DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, Classes,
  Forms, SysUtils, Dialogs, DataState, Menus, AdvMenus, Graphics, MemDS,
  Shader,BusObjDeductions,BusObjBase, ImgList, ProgressDialog, DBCtrls;

type
  TfrmDeductionsUSA = class(TBaseInputGUI)
    qryDeduction: TERPQuery;
    edtDescription: TwwDBEdit;
    Label1: TLabel;
    Bevel1: TBevel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    wwCheckBox1: TwwCheckBox;
    wwCheckBox2: TwwCheckBox;
    Label2: TLabel;
    chkActive: TwwCheckBox;
    btnNew: TDNMSpeedButton;
    Bevel2: TBevel;
    Label7: TLabel;
    Label9: TLabel;
    edtAmount: TwwDBEdit;
    chkIsWorkPlacegiving: TwwCheckBox;
    cboBasedON: TwwDBLookupCombo;
    qryBasedOn: TERPQuery;
    qryDeductionDeductionID: TAutoIncField;
    qryDeductionDescription: TWideStringField;
    qryDeductionTaxExempt: TWideStringField;
    qryDeductionIsWorkPlacegiving: TWideStringField;
    qryDeductionUnionFees: TWideStringField;
    qryDeductionActive: TWideStringField;
    qryDeductionEditedFlag: TWideStringField;
    qryDeductionDisplayIn: TWideStringField;
    qryDeductionAmount: TFloatField;
    qryDeductionBasedOnID: TIntegerField;
    qryDeductionCalcBy: TWideStringField;
    cboCalcBy: TwwDBComboBox;
    Label8: TLabel;
    DSDeduction: TDataSource;
    qryAccounts: TERPQuery;
    qryAccountsAccountName: TWideStringField;
    qryAccountsType: TWideStringField;
    qryAccountsAccountType: TWideStringField;
    qryAccountsAccountID: TIntegerField;
    qryAccountsGlobalRef: TWideStringField;
    qryAccountsDescription: TWideStringField;
    qryAccountsBankAccountName: TWideStringField;
    qryAccountsBalance: TFloatField;
    qryAccountsAccountNumber: TWideStringField;
    qryAccountsTaxcode: TWideStringField;
    qryAccountsBankNumber: TWideStringField;
    qryAccountsExtra: TWideStringField;
    qryAccountsActive: TWideStringField;
    qryAccountsEditedFlag: TWideStringField;
    qryAccountsClass: TWideStringField;
    qryAccountsAllClasses: TWideStringField;
    qryAccountsOpeningBalance: TFloatField;
    qryAccountsDebits: TFloatField;
    qryAccountsCredits: TFloatField;
    qryAccountsClosingBalance: TFloatField;
    qryAccountsAccountGroup: TWideStringField;
    qryDeductionAccountID: TIntegerField;
    qryDeductionAccountName: TWideStringField;
    cboDefaultAccount: TwwDBLookupCombo;
    lblAccount: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Label5: TLabel;
    cboBox12Code: TwwDBLookupCombo;
    qryDeductionBox12CodeID: TIntegerField;
    qryBox12Code: TERPQuery;
    qryBox12CodeCodeID: TIntegerField;
    qryBox12CodeCode: TWideStringField;
    qryBox12CodeDescription: TWideStringField;
    Label3: TLabel;
    wwCheckBox3: TwwCheckBox;
    wwCheckBox4: TwwCheckBox;
    wwCheckBox5: TwwCheckBox;
    wwCheckBox6: TwwCheckBox;
    qryDeductionTaxExemptFederal: TWideStringField;
    qryDeductionTaxExemptState: TWideStringField;
    qryDeductionTaxExemptSocial: TWideStringField;
    qryDeductionTaxExemptMedicare: TWideStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure cboBasedONNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure cboCalcByCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure cboDefaultAccountCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure qryDeductionIsWorkPlacegivingChange(Sender: TField);

  private
    Deduction :TDeduction;
    fsNewDescription: string;
    procedure AddNewDeductionDetails; 
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    { Public declarations }
    property NewDescription: string read fsNewDescription write fsNewDescription;
  end;

implementation

uses
  FormFactory, DNMExceptions,  PayCommon, 
  tcDataUtils, CommonLib, AppEnvironment,BusObjConst,TcTypes;

{$R *.dfm}

procedure TfrmDeductionsUSA.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Closequeries;
  Action := caFree;
 
end;

procedure TfrmDeductionsUSA.btnCancelClick(Sender: TObject);
begin
  inherited;
  if fsModal in FormState then else Close;
end;

procedure TfrmDeductionsUSA.AddNewDeductionDetails;
begin
  Deduction.AccountName := GetAccountName(AppEnv.PayPrefs.DeductionLiabilityAccountID);
  Deduction.AccountID   := AppEnv.PayPrefs.DeductionLiabilityAccountID;

  Deduction.TaxExempt   := False;
  Deduction.UnionFees   := False;
  Deduction.Amount      := 0.00;
  if AppEnv.RegionalOptions.RegionType = rUK then begin
    Deduction.CalcBy := '£';
  end
  else begin
    Deduction.CalcBy := '$';
  end;
  Deduction.BasedOnID   := GetBasedOnID('None');
  Deduction.Active      := True;
end;

procedure TfrmDeductionsUSA.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      if qryDeduction.Active then begin
        CloseQueries;
      end;

      //delete unwanted currency symbols from dropdown combobox
      if AppEnv.RegionalOptions.RegionType = rUK then begin
        if cboCalcBy.Items.Strings[1] = '$'#9'$' then begin
          cboCalcBy.Items.Delete(1);
        end;
      end else begin
        if cboCalcBy.Items.Strings[2] = '£'#9'£' then begin
          cboCalcBy.Items.Delete(2);
        end;
      end;

      qryBasedOn.Connection  := Self.MyConnection;
      qryBox12Code.Connection  := Self.MyConnection;
      qryAccounts.Connection := Self.MyConnection;

      qryBasedOn.Open;
      qryBox12Code.Open;
      qryAccounts.Open;

      Deduction.Connection  := TMyDacDataConnection.Create(Deduction);
      TMyDacDataConnection(Deduction.Connection).MydacConnection  := Self.MyConnection;
      Deduction.BusObjEvent := DoBusinessObjectEvent;

      BeginTransaction;

      if Self.KeyID = 0 then begin
        Deduction.New;
        AddNewDeductionDetails;
      end else begin
        Deduction.Load(Self.KeyID);
      end;

      //in case the deduction was originaly created in another region;
      if Deduction.Calcby <> '%' then Deduction.Calcby := AppEnv.RegionalOptions.CurrencySymbol;
    //  cboCalcBy.text := Deduction.Calcby;

      if Deduction.AccountID = 0 then begin
          Deduction.AccountName := GetAccountName(AppEnv.PayPrefs.DeductionLiabilityAccountID);
          Deduction.AccountID   := AppEnv.PayPrefs.DeductionLiabilityAccountID;
      end;

      if KeyID = 0 then begin
        edtDescription.ReadOnly := False;
      end else begin
        edtDescription.ReadOnly := true;
      end;

      if NewDescription <> '' then begin
        Deduction.Description := NewDescription;
        edtDescription.Text := fsNewDescription;
      end;

      chkActive.Enabled := (AccessLevel <> 2) and (AccessLevel <> 3);
      SetControlFocus(edtDescription);
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmDeductionsUSA.qryDeductionIsWorkPlacegivingChange(Sender: TField);
begin
  inherited;
  if qryDeductionIsWorkPlacegiving.asBoolean then begin
    qryDeductionUnionFees.asBoolean  := False;
    postDB(qryDeduction);
    EditDb(qryDeduction);
  end;
end;

procedure TfrmDeductionsUSA.btnNewClick(Sender: TObject);
begin
  Exit;

  inherited;
  if Deduction.Save then begin
    CommitTransaction;
    KeyID          := 0;
    NewDescription := '';    
    FormShow(nil);
  end;
end;

procedure TfrmDeductionsUSA.cboBasedONNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
begin
  Accept := false;
end;

//procedure TfrmDeductions.cboBox12CodeChange(Sender: TObject);
//begin
//  inherited;
//  label5.Caption := qryBox12CodeDescription.Value;
//end;

procedure TfrmDeductionsUSA.FormCreate(Sender: TObject);
begin
  inherited;
  Deduction := TDeduction.Create(Self);

  fsNewDescription := '';
end;


procedure TfrmDeductionsUSA.btnSaveClick(Sender: TObject);
begin
  inherited;

  if (cboBasedOn.Text = 'None') AND (cboCalcBy.Text = '%') then begin
    CommonLib.MessageDlgXP_Vista('Please select what the deduction will be based on.', mtInformation,  [mbOk], 0);
    SetControlFocus(cboBasedOn);
    exit;
  end;
  if not Deduction.ValidateData then exit;
  Deduction.PostDb;
  CommitTransaction;
  Notify;
  if fsModal in FormState then  else Close;
end;

procedure TfrmDeductionsUSA.DoBusinessObjectEvent( const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if Eventtype = BusobjEventVal_HandleCalcByConflict then begin
    CommonLib.MessageDlgXP_Vista('When using %, Based On cannot be none.', mtWarning, [mbOK], 0);
      SetControlFocus(cboCalcBy);
  end else if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TDeduction   then TDeduction(Sender).DataSet     := qryDeduction;
  end;
end;

procedure TfrmDeductionsUSA.cboCalcByCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  inherited;     //work around mysql/TwwCombobox bug with pound sign
  if cboCalcBy.Text = '%' then Deduction.Calcby := '%';
  if cboCalcBy.Text = '£' then Deduction.Calcby :=  '£'; //char(163);
  if cboCalcBy.Text = '$' then Deduction.Calcby :=  '$';
  Deduction.PostDb;
end;

procedure TfrmDeductionsUSA.cboDefaultAccountCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  Deduction.Accountid := tcDataUtils.GetAccountID(cboDefaultAccount.Text); 
end;

initialization
  RegisterClassOnce(TfrmDeductionsUSA);
  with FormFact do begin
    RegisterMe(TfrmDeductionsUSA, 'TfrmDeductionList1_*=DeductionID');
    RegisterControl(TfrmDeductionsUSA, '*_cboDeduction=DeductionID');
  end;
end.
