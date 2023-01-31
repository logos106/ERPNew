unit frmAllowancesFrmUSA;

interface

uses
  Windows, BaseInputForm, DB, Controls, ExtCtrls, DNMPanel, Wwdotdot,
  Wwdbcomb, StdCtrls, wwcheckbox, Buttons, DNMSpeedButton, wwdblook, Mask, wwdbedit,
  DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, Classes,
  Forms, SysUtils, Dialogs, DataState, Menus, AdvMenus, Graphics, MemDS,
  Shader,BusObjAllowances,BusObjbase, Wwdbdlg, ImgList, ProgressDialog, DBCtrls,
  Grids, Wwdbigrd, Wwdbgrid;

type
  TfrmAllowancesUSA = class(TBaseInputGUI)
    qryAllowance: TERPQuery;
    DSAllowance: TDataSource;
    edtDescription: TwwDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Bevel1: TBevel;
    edtAmount: TwwDBEdit;
    Label7: TLabel;
    cboBasedOn: TwwDBLookupCombo;
    Label9: TLabel;
    Bevel2: TBevel;
    qryBasedOn: TERPQuery;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    DBCheckBox1: TwwCheckBox;
    DBCheckBox2: TwwCheckBox;
    DBCheckBox3: TwwCheckBox;
    DBCheckBox4: TwwCheckBox;
    qryAllowanceAllowanceID: TAutoIncField;
    qryAllowanceAmount: TFloatField;
    qryAllowanceBasedOnID: TIntegerField;
    qryAllowanceDescription: TWideStringField;
    qryAllowanceDisplayIn: TWideStringField;
    qryAllowancePayrollTaxExempt: TWideStringField;
    qryAllowanceSuperInc: TWideStringField;
    qryAllowanceTaxExempt: TWideStringField;
    qryAllowanceWorkcoverExempt: TWideStringField;
    qryAllowanceEditedFlag: TWideStringField;
    btnNew: TDNMSpeedButton;
    chkActive: TwwCheckBox;
    Label10: TLabel;
    qryAllowanceActive: TWideStringField;
    cboCalcBy: TwwDBComboBox;
    qryAllowanceCalcBy: TWideStringField;
    Label8: TLabel;
    lblAccount: TLabel;
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
    cboDefaultAccount: TwwDBLookupCombo;
    qryAllowanceAccountID: TIntegerField;
    qryAllowanceAccountName: TWideStringField;
    qryAllowanceGlobalRef: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryAllowanceReportExempt: TWideStringField;
    Label11: TLabel;
    cboDisplayIn: TDBComboBox;
    lblDisplayInNotes: TLabel;
    qryAllowancePercentage: TFloatField;
    qryAllowanceAllowanceType: TWideStringField;
    qryAllowancemsTimeStamp: TDateTimeField;
    qryAllowancemsUpdateSiteCode: TWideStringField;
    cboAllowanceType: TDBComboBox;
    Label6: TLabel;
    qryAllowanceAllowanceCode: TWideStringField;
    qryAllowanceType: TERPQuery;
    qryAllowanceAllowTypeID: TIntegerField;
    qryAllowanceTypeAllowTypeID: TIntegerField;
    dsAllowanceType: TDataSource;
    qryBasedOnBasedOnID: TIntegerField;
    qryBasedOnBasedOn: TWideStringField;
    qryAllowanceTypeAllowance_Type: TWideStringField;
    wwDBGrid1: TwwDBGrid;
    wwDBLookupCombo1: TwwDBLookupCombo;
    Label12: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure cboBasedOnNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure qryAllowanceAccountNameChange(Sender: TField);
    procedure cboCalcByCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure cboDefaultAccountCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboDisplayInChange(Sender: TObject);
  private
    Allowance :TAllowance;
    frmCalling: TBaseInputGUI;
    wwCombo: TwwDBLookupCombo;
    sNewName: string;     
    procedure AddNewAllowanceDetails;
    procedure UpdateNotes;
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    property CallingForm: TBaseInputGUI read frmCalling write frmCalling;
    property FillInCombo: TwwDBLookupCombo read wwCombo write wwCombo;
    property NewName: string read sNewName write sNewName;
  end;


implementation

uses
  FormFactory, DNMExceptions,  PayCommon,tcTypes,BusObjConst,
  tcDataUtils, CommonLib, AppEnvironment, PayPreferencesObj;

{$R *.dfm}

procedure TfrmAllowancesUSA.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Closequeries;
  Action := caFree;
  if Assigned(frmCalling) then begin
    if Assigned(FillInCombo) then begin
      FillInCombo.LookupTable.Close;
      FillInCombo.LookupTable.Open;
      FillInCombo.LookupTable.Locate('AllowanceID', GetAllowanceID(FillInCombo.Text), [loCaseInsensitive]);
      FillInCombo.Text := sNewName;
    end;
  end;
end;

procedure TfrmAllowancesUSA.btnCancelClick(Sender: TObject);
begin
  inherited;
  if fsModal in FormState then  else Close;
end;

procedure TfrmAllowancesUSA.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      inherited;
      if qryAllowance.Active then begin
        CloseQueries;
      end;
       //delete unwanted currency symbols from dropdown combobox
        if AppEnv.RegionalOptions.RegionType = rUK then begin
          if cboCalcBy.Items.Strings[1] = '$'#9'$' then begin
            cboCalcBy.Items.Delete(1);
          end;
        end else begin
          if (cboCalcBy.Items.Count = 3) then {For New Btn Click Error because Strings[2] is already Deleted}
            if cboCalcBy.Items.Strings[2] = '£'#9'£' then begin
              cboCalcBy.Items.Delete(2);
            end;
        end;

      qryBasedOn.Connection  := Self.MyConnection;
      qryAllowanceType.Connection  := Self.MyConnection;

      qryAccounts.Connection := Self.MyConnection;


//      cboAllowanceTypeUSA.LookupValue := 'AllowanceType';

  //   cboBasedOn.Enabled := false;


   // ShowMessage('cboBasedOn Selected   ' + cboBasedOn.Selected[0]);


   //     ShowMessage('cboAllowanceTypeUSA Selected   ' + cboAllowanceTypeUSA.Selected[0]);

     //   cboAllowanceTypeUSA.Selected[0] := Copy(cboAllowanceTypeUSA.Selected[0], 1,  Length(cboAllowanceTypeUSA.Selected[0]) - 1);

     //    cboAllowanceTypeUSA.Selected[0] := 'AllowanceType   25   AllowanceType';

      //          ShowMessage('cboAllowanceTypeUSA Selected   ' + cboAllowanceTypeUSA.Selected[0]);

      qryBasedOn.Open;
      qryAllowanceType.Open;

      qryAccounts.Open;

      Allowance.Connection  := TMyDacDataConnection.Create(Allowance);
      TMyDacDataConnection(Allowance.Connection).MydacConnection  := Self.MyConnection;
      Allowance.BusObjEvent := DoBusinessObjectEvent;
      BeginTransaction;

      if Self.KeyID = 0 then begin
        Allowance.New;
        AddNewAllowanceDetails;
        end else begin
          Allowance.Load(Self.KeyID);
        end;

      //in case the allowance was originaly created in another region;
      if Allowance.Calcby <> '%' then Allowance.Calcby := AppEnv.RegionalOptions.CurrencySymbol;
      cboCalcBy.text := Allowance.Calcby;

      if Allowance.Accountid = 0 then begin
        Allowance.Accountname := GetAccountName(AppEnv.PayPrefs.AllowancePaidAccountID);
        Allowance.Accountid   := AppEnv.PayPrefs.AllowancePaidAccountID;
      end;

      if KeyID = 0 then begin
        edtDescription.ReadOnly := False;
      end else begin
        edtDescription.ReadOnly := true;
      end;

      if Assigned(frmCalling) then begin
        edtDescription.Text := sNewName;
      end else begin
        if sNewName <> '' then begin
          Allowance.Description := sNewName;
         // edtDescription.Text := sNewName;
        end;
      end;

      chkActive.Enabled := (AccessLevel <> 2) and (AccessLevel <> 3);
      SetControlFocus(edtDescription);
      UpdateNotes;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmAllowancesUSA.btnNewClick(Sender: TObject);
begin
  inherited;
  if Allowance.Save then begin
    KeyID    := 0;
    sNewName := '';
    FormShow(nil);
  end;
end;


procedure TfrmAllowancesUSA.cboBasedOnNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
begin
  Accept := false;
end;

procedure TfrmAllowancesUSA.AddNewAllowanceDetails;
begin 
  Allowance.AccountName := GetAccountName(AppEnv.PayPrefs.AllowancePaidAccountID);
  Allowance.AccountID   := AppEnv.PayPrefs.AllowancePaidAccountID;
  Allowance.SuperInc    := False;
  Allowance.TaxExempt   := False;
  Allowance.PayrollTaxExempt := False;
  Allowance.WorkcoverExempt := False;
  Allowance.Amount      := 0.00;
  case AppEnv.RegionalOptions.RegionType of
    rUK : begin
            Allowance.CalcBy := '£';
          end;
    else begin
            Allowance.CalcBy := '$';
            end;
  end;                  

  Allowance.BasedOnID   := GetBasedOnID('None');
  Allowance.Active      := True;
end;

procedure TfrmAllowancesUSA.FormCreate(Sender: TObject);
begin
  inherited;
  Allowance := TAllowance.Create(Self);
  frmCalling := nil;
  FillInCombo := nil;
  sNewName := '';
end;  

procedure TfrmAllowancesUSA.btnSaveClick(Sender: TObject);
begin
  inherited;
  Allowance.PostDB;
  if not Allowance.ValidateData then exit;
  Allowance.PostDb;
  CommitTransaction;
  Notify;
  if fsModal in FormState then  else Close;
end;

procedure TfrmAllowancesUSA.qryAllowanceAccountNameChange(Sender: TField);
begin
  inherited;
  Allowance.AccountID := GetAccountID(qryAllowance.FieldByName('AccountName').AsString);
end;

procedure TfrmAllowancesUSA.UpdateNotes;
begin
  if SameText(cboDisplayIn.Text, 'Allowances') then
    lblDisplayInNotes.Caption :=
      'Summary Report(s) will list Allowance separately and exclude Allowance amount from the Gross Payments Amount Total.'
  else if SameText(cboDisplayIn.Text, 'Gross') then
    lblDisplayInNotes.Caption :=
      'Summary Report(s) will not list Allowance but Allowance amount will be included in the Gross Payments Amount Total.'
  else if SameText(cboDisplayIn.Text, 'Do Not Display') then
    lblDisplayInNotes.Caption :=
      'Summary Report(s) will not list Allowance and Allowance amount will be excluded from the Gross Payments Amount Total.'
  else
    lblDisplayInNotes.Caption := '';

end;

procedure TfrmAllowancesUSA.DoBusinessObjectEvent( const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if Eventtype = BusobjEventVal_HandleCalcByConflict then begin
    CommonLib.MessageDlgXP_Vista('When using %, Based On cannot be none.', mtWarning, [mbOK], 0);
    SetControlFocus(cboCalcBy);
  end else if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TAllowance         then TAllowance(Sender).DataSet     := qryAllowance;
  end;
end;

procedure TfrmAllowancesUSA.cboCalcByCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  inherited;      //work around mysql/TwwCombobox bug with pound sign
  if cboCalcBy.Text = '%' then Allowance.Calcby := '%';
  if cboCalcBy.Text = '£' then Allowance.Calcby := '£';//   char(163);
  if cboCalcBy.Text = '$' then Allowance.Calcby := '$';
  Allowance.PostDb;
end;

procedure TfrmAllowancesUSA.cboDefaultAccountCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  inherited;
  Allowance.Accountid := tcDataUtils.GetAccountID(cboDefaultAccount.Text);
end;



procedure TfrmAllowancesUSA.cboDisplayInChange(Sender: TObject);
begin
  inherited;

  UpdateNotes;

end;





initialization
  RegisterClassOnce(TfrmAllowancesUSA);
  with FormFact do begin
    RegisterMe(TfrmAllowancesUSA, 'TfrmAllowanceList_*=AllowanceID');
    RegisterControl(TfrmAllowancesUSA, '*_cboAllowance=AllowanceID');
  end;
end.
