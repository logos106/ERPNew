{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 06/05/05  1.00.01 BJ  Fixed enforcing the mask for BSB number. BSB should be
                       gven in 999-999 format(if given).
 08/06/05  1.00.02 IJB Changed to not check BSB if this is not a bank account.
 08/08/05  1.00.03 DSP The user was asked if they wanted to Save data even
                       when no entries had been made. This has been fixed.
 20/09/05  1.00.04 DLS Moved DataState activation code to after exception handler
 19/10/05  1.00.05 DLS Added RegisterClass
 19/12/05  1.00.06  AL  Removed "Instance"  *Task306*

 }

unit frmChartOfAccountsFrm;

interface

uses
  Windows, BaseInputForm, DB,   Forms, Dialogs, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  wwcheckbox, wwdblook, StdCtrls, Mask, DBCtrls, Controls, ExtCtrls,
  DNMPanel, ComCtrls,AdvOfficeStatusBar, Classes, wwdbedit, StrUtils, kbmMemTable,
  DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, DataState, Messages,
  Menus, AdvMenus, Graphics, MemDS, Shader, ImgList, ProgressDialog;

type
  TfrmChartOfAccounts = class(TBaseInputGUI)
    frmChartofAccountsSrc: TDataSource;
    cmdNew: TDNMSpeedButton;
    Label50: TLabel;
    qryChartofAccounts: TERPQuery;
    cboAccountTypeQry: TERPQuery;
    cbTaxCodeQry: TERPQuery;
    cmdOk: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    qryAccClasses: TERPQuery;
    qryAccClassesClassID: TIntegerField;
    qryAccClassesAccountID: TIntegerField;
    qryAccClassesClassName: TWideStringField;
    qryAccountName: TERPQuery;
    qryAccLevel3: TERPQuery;
    qryAccLevel2: TERPQuery;
    qryAccLevel1: TERPQuery;
    qryProductLevels: TERPQuery;
    qryChartofAccountsAccountID: TAutoIncField;
    qryChartofAccountsAccountNumber: TWideStringField;
    qryChartofAccountsAccountType: TWideStringField;
    qryChartofAccountsAccountGroup: TWideStringField;
    qryChartofAccountsAccountName: TWideStringField;
    qryChartofAccountsDescription: TWideStringField;
    qryChartofAccountsBankNumber: TWideStringField;
    qryChartofAccountsActive: TWideStringField;
    qryChartofAccountsTaxcode: TWideStringField;
    qryChartofAccountsEditedFlag: TWideStringField;
    qryChartofAccountsClass: TWideStringField;
    qryChartofAccountsAllClasses: TWideStringField;
    qryChartofAccountsBankAccountName: TWideStringField;
    memqryChartofAccounts: TkbmMemTable;
    chkActive: TwwCheckBox;
    qryChartofAccountsLastChequeNo: TIntegerField;
    qryChartofAccountsUseLastChequeNo: TWideStringField;
    qryChartofAccountsRequired: TWideStringField;
    qryChartofAccountsBankCode: TWideStringField;
    qryChartofAccountsAPCANo: TWideStringField;
    qryBankCodes: TERPQuery;
    qryChartofAccountsBSB: TWideStringField;
    qryChartofAccountsGlobalRef: TWideStringField;
    qryChartofAccountsBalance: TFloatField;
    qryChartofAccountsExtra: TWideStringField;
    qryChartofAccountsOpeningBalance: TFloatField;
    qryChartofAccountsDebits: TFloatField;
    qryChartofAccountsCredits: TFloatField;
    qryChartofAccountsClosingBalance: TFloatField;
    qryChartofAccountsLevel1: TWideStringField;
    qryChartofAccountsLevel2: TWideStringField;
    qryChartofAccountsLevel3: TWideStringField;
    qryChartofAccountsLevel4: TWideStringField;
    qryChartofAccountsIncludeBalanceRecord: TWideStringField;
    qryChartofAccountsIncludeNetTotal: TWideStringField;
    qryChartofAccountsIncludeCreditTotal: TWideStringField;
    qryChartofAccountsIncludeDebitTotal: TWideStringField;
    qryChartofAccountsBankAccountNumber: TWideStringField;
    qryChartofAccountsIsHeader: TWideStringField;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryChartofAccountsAllowExpenseClaim: TWideStringField;
    DNMPanel1: TDNMPanel;
    Bevel3: TBevel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    lblBSB: TLabel;
    lblBankAccNo: TLabel;
    lblBankAccDetails: TLabel;
    lblBankAccName: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label9: TLabel;
    Bevel4: TBevel;
    Label13: TLabel;
    AccountNumber: TDBEdit;
    cboAccountType: TwwDBLookupCombo;
    cboTaxCode: TwwDBLookupCombo;
    txtDescription: TDBEdit;
    cboAccLevel1: TwwDBLookupCombo;
    cboAccLevel2: TwwDBLookupCombo;
    cboAccLevel3: TwwDBLookupCombo;
    edtAccountName: TwwDBEdit;
    edtBankAccName: TwwDBEdit;
    AccountTreeView: TTreeView;
    txtLastChequeNo: TDBEdit;
    chkIsHeader: TwwCheckBox;
    pnlEFT: TDNMPanel;
    Label12: TLabel;
    Label18: TLabel;
    APCANo: TwwDBEdit;
    cboBankCode: TwwDBLookupCombo;
    btnOptions: TDNMSpeedButton;
    edtBSB: TDBEdit;
    chkUseLastChequeNo: TwwCheckBox;
    chkAllowExpenseClaim: TwwCheckBox;
    edtBankAccNo: TDBEdit;
    cmdRules: TDNMSpeedButton;
    procedure cmdCancelClick(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qryAccClassesClassNameChange(Sender: TField);
    procedure cboAccountNameNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure FormCreate(Sender: TObject);
    procedure cboClassNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure cboAccountTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure qryChartofAccountsAfterOpen(DataSet: TDataSet);
    procedure cboAccLevel1Change(Sender: TObject);
    procedure cboAccLevel2Change(Sender: TObject);
    procedure cboAccLevel3Change(Sender: TObject);
    procedure edtAccountNameChange(Sender: TObject);
    procedure AccountTreeViewClick(Sender: TObject);
    procedure cboAccLevel1Exit(Sender: TObject);
    procedure cboAccLevel2Exit(Sender: TObject);
    procedure cboAccLevel3Exit(Sender: TObject);
    procedure cboAccLevel1NotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure btnOptionsClick(Sender: TObject);
    procedure cboAccountTypeExit(Sender: TObject);
    //procedure btnDeleteClick(Sender: TObject);
    procedure grdTransactionsExit(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
    procedure edtBSBCheckValue(Sender: TObject; PassesPictureTest: boolean);
    procedure FormDestroy(Sender: TObject);
    procedure cbTaxCodeQryBeforeOpen(DataSet: TDataSet);
    procedure qryAccClassesAfterInsert(DataSet: TDataSet);
    procedure qryAccClassesBeforePost(DataSet: TDataSet);
    procedure chkIsHeaderClick(Sender: TObject);
    procedure cmdRulesClick(Sender: TObject);
    procedure qryBankCodesBeforeOpen(DataSet: TDataSet);
  private
    fbSaveClicked: boolean;
    fbcheckingIsHeader :Boolean;
    function AccountGroupJoin: string;
    function PerformSave: boolean;
    (*procedure SeparateBankAccNo;*)
    procedure AccountTreeOrder;
    procedure AccountLevelCombosRefresh;
    function AccountNameUnique: boolean;
    procedure SetFocusToAccCombo(var Msg: TMessage); message WM_SetFocus;
    Function isCOAUniqueRecord:Boolean;
    function AccountSaved: boolean;

  Protected
    procedure KeyIdChanged(const NewKeyId: integer); override;
    function GetKeyString: string; override;
    procedure SetKeyString(const Value: string); override;
    function SaveOrCancelChanges: boolean;override;
  public
    COAID: integer;
    fsNewAccount: string;
    function AddAllSubAccounts: boolean;
    function InsertAccountRecord(const AccountName, AccountType, Active, AccountGroup: string): boolean;
  end;

implementation

uses FastFuncs, DNMLib, SysUtils, FormFactory, DNMExceptions, EFTOptionsPopup,
  CommonLib,   MyClasses, AppEnvironment, tcTypes, CommonDbLib, tcConst,
  BusObjGLAccount, sndkey32;

{$R *.DFM}

procedure TfrmChartOfAccounts.cmdCancelClick(Sender: TObject);
begin
  DisableForm;
  try
    Notify(true);
    Self.Close;
  finally
    EnableForm;
  end;  
end;
Function TfrmchartOfAccounts.AccountSaved:boolean;
begin
  REsult := False;
  fsNewAccount := edtAccountName.Text;
      if Empty(cboAccountType.Text) then begin
        CommonLib.MessageDlgXP_Vista('Account Type cannot be blank.', mtWarning, [mbOK], 0);
        if (cboAccountType.Enabled) and (cboAccountType.Visible) then SetControlFocus(cboAccountType);
        exit;
      end;
      if Empty(edtAccountName.Text) then begin
        CommonLib.MessageDlgXP_Vista('Account Name cannot be blank.', mtWarning, [mbOK], 0);
        if (edtAccountName.Enabled) and (edtAccountName.Visible) then SetControlFocus(edtAccountName);
        exit;
      end;
      if not (qryChartOfAccounts.State in [dsBrowse]) then begin
        if not isCOAUniqueRecord then
          exit;
        if not PerformSave then Exit;
        SetAccountLevelField(qryChartofAccountsAccountID.AsInteger);
        Notify(false);
      end;
      edtAccountName.ReadOnly := true;
      REsult := true;
end;
procedure TfrmChartOfAccounts.cmdOkClick(Sender: TObject);
begin
  DisableForm;
  try
    try
      if not (Accountsaved) then exit;
      CommitTransaction;
      fbSaveClicked := true;
      Self.Close;
    except
      on EAbort do HandleEAbortException;
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

procedure TfrmChartOfAccounts.cmdRulesClick(Sender: TObject);
begin
  inherited;
  ShowformComments;
end;

procedure TfrmChartOfAccounts.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    try
      fsNewAccount := edtAccountName.Text;
      if not Empty(edtAccountName.Text) then begin
        if not (qryChartOfAccounts.State in [dsBrowse]) then begin
          PerformSave;
          SetAccountLevelField(qryChartofAccountsAccountID.AsInteger);
          Notify;
          BeginTransaction;
        end;
        fsNewAccount := '';
        cboAccLevel1.Text := '';
        cboAccLevel2.Text := '';
        cboAccLevel3.Text := '';
        edtAccountName.ReadOnly := false;
        KeyID := 0;
        FormShow(nil);
        if (cboAccountType.Enabled) and (cboAccountType.Visible) then SetControlFocus(cboAccountType);
      end else begin
        CommonLib.MessageDlgXP_Vista('Account Name cannot be blank.', mtWarning, [mbOK], 0);
        if (edtAccountName.Enabled) and (edtAccountName.Visible) then SetControlFocus(edtAccountName);
      end;
    except
      on EAbort do HandleEAbortException;
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmChartOfAccounts.FormShow(Sender: TObject);
var
  SaveSuccess, bIsBank: boolean;
begin
  btnOptions.Visible := Appenv.RegionalOptions.RegionType = rAust;
  DisableForm;
  try
    try
      inherited;
      BeginTransaction;

      if qryChartOfAccounts.Active then begin
        if not (qryChartOfAccounts.State in [dsBrowse]) then begin
          fsNewAccount := edtAccountName.Text;
          if not Empty(cboAccountType.Text) then begin
            if not Empty(edtAccountName.Text) then begin
              if not (qryChartOfAccounts.State in [dsBrowse]) then begin
                SaveSuccess := PerformSave;
                if SaveSuccess = false then begin
                  CommonLib.MessageDlgXP_Vista('Error Saving Account', mtWarning, [mbOK], 0);
                  Exit;
                end;
                Notify;
              end;
            end else begin
              CommonLib.MessageDlgXP_Vista('Account Name cannot be blank.', mtWarning, [mbOK], 0);
              if (edtAccountName.Enabled) and (edtAccountName.Visible) then SetControlFocus(edtAccountName);
              Exit;
            end;
          end else begin
            CommonLib.MessageDlgXP_Vista('Account Type cannot be blank.', mtWarning, [mbOK], 0);
            if (cboAccountType.Enabled) and (cboAccountType.Visible) then SetControlFocus(cboAccountType);
            Exit;
          end;
        end;
        CloseQueries;
      end;

      fbSaveClicked     := false;
      chkActive.OnClick := nil;
      qryProductLevels.ParamByName('KeyID').asInteger := KeyID;
      qryChartOfAccounts.ParamByName('COAID').asInteger := KeyID;
      qryAccClasses.ParamByName('ACCID').asInteger := KeyID;
      OpenQueries;

      if KeyID = 0 then begin
        qryChartOfAccounts.Insert;
        qryChartofAccounts.FieldByName('Active').AsString := 'T';
        qryChartofAccounts.FieldByName('EditedFlag').AsString := 'T';
        qryChartOfAccounts.FieldByName('AllClasses').AsString := 'T';
        edtAccountName.ReadOnly:= false;
        cboAccountType.ReadOnly:= false;
//        cboAccLevel1.ReadOnly:= false;
//        cboAccLevel2.ReadOnly:= false;
//        cboAccLevel3.ReadOnly:= false;
        if not Empty(fsNewAccount) then qryChartOfAccounts.FieldByName('AccountName').AsString := fsNewAccount;
        qryAccClasses.Insert;
      end else begin
        edtAccountName.ReadOnly:= true;
        cboAccountType.ReadOnly:= true;
//        cboAccLevel1.ReadOnly:= true;
//        cboAccLevel2.ReadOnly:= true;
//        cboAccLevel3.ReadOnly:= true;
        EditNoAbort(qryChartOfAccounts);
        (*SeparateBankAccNo;*)
        EditNoAbort(qryAccClasses);
      end;

      bIsBank         := (cboAccountType.LookupValue = ACCOUNT_TYPE_BANK);
      edtBankAccName.Enabled := bIsBank;
      edtBSB.Enabled  := bIsBank;
      edtBankAccNo.Enabled := bIsBank;
      lblBankAccDetails.Enabled := bIsBank;
      lblBankAccName.Enabled := bIsBank;
      lblBSB.Enabled  := bIsBank;
      lblBankAccNo.Enabled := bIsBank;
      Label9.Enabled  := bIsBank;
      txtLastChequeNo.Enabled := bIsBank;
      chkUseLastChequeNo.Enabled := (bIsBank and AppEnv.CompanyPrefs.UseAutoChequeNo);
      Label12.Enabled := bIsBank;
      APCANo.Enabled  := bIsBank;
      Label18.Enabled := bIsBank;
      cboBankCode.Enabled := bIsBank;
      btnOptions.Enabled := bIsBank;
      //AccountNumber.Enabled := Not(bIsBank);
      chkAllowExpenseClaim.Enabled := (cboAccountType.LookupValue = ACCOUNT_TYPE_EXPENSE);

      chkActive.Enabled := (AccessLevel <> 2) and (AccessLevel <> 3);
      AccountLevelCombosRefresh;
      cboAccLevel1.LookupValue := qryProductLevels.FieldByName('AccLevel1').AsString;
      cboAccLevel2.LookupValue := qryProductLevels.FieldByName('AccLevel2').AsString;
      cboAccLevel3.LookupValue := qryProductLevels.FieldByName('AccLevel3').AsString;
      AccountLevelCombosRefresh;
      AccountTreeOrder;
      chkActive.OnClick := chkActiveClick;
      if (cboAccountType.Enabled) and (cboAccountType.Visible) then SetControlFocus(cboAccountType);

      if not DataState.IsActive then DataState.Activate;
      DataState.Dirty := false;

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
  end;  
end;

function TfrmChartOfAccounts.GetKeyString: string;
begin
  if self.qryChartofAccounts.Active then
    result:= self.qryChartofAccountsAccountName.AsString
  else
    result:= '';
end;

procedure TfrmChartOfAccounts.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseQueries;
  inherited;
  Action := caFree;
end;

procedure TfrmChartOfAccounts.qryAccClassesClassNameChange(Sender: TField);
begin
  inherited;
  qryAccClassesAccountID.AsInteger := qryChartofAccounts.FieldByName('AccountID').AsInteger;
end;

procedure TfrmChartOfAccounts.qryBankCodesBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  TERPQuery(Dataset).Params.ParamByName('XRegionID').AsInteger := AppEnv.RegionalOptions.ID;
  TERPQuery(Dataset).Params.ParamByName('BankCode').AsString := qryChartofAccountsBankCode.AsString;
end;

function TfrmChartOfAccounts.AccountGroupJoin: string;
begin
  if not empty(cboAccLevel1.Text) then begin
    if not empty(cboAccLevel2.Text) then begin
      if not empty(cboAccLevel3.Text) then begin
        Result := cboAccLevel1.Text + '^' + cboAccLevel2.Text + '^' + cboAccLevel3.Text;
      end else begin
        Result := cboAccLevel1.Text + '^' + cboAccLevel2.Text;
      end;
    end else begin
      Result := cboAccLevel1.Text;
    end;
  end else begin
    Result := '';
  end;
end;

procedure TfrmChartOfAccounts.cboAccountNameNotInList(Sender: TObject; LookupTable: TDataSet;
  NewValue: string; var Accept: boolean);
begin
  inherited;
  if KeyID <> 0 then begin
    CommonLib.MessageDlgXP_Vista('Cannot Rename Account. Create a New One !', mtWarning, [mbOK], 0);
    Accept := false;
  end;
end;

function TfrmChartOfAccounts.AddAllSubAccounts: boolean;
begin
  if not empty(cboAccLevel3.Text) then begin
    InsertAccountRecord(cboAccLevel3.Text, qryChartofAccountsAccountType.AsString, 'T',
      cboAccLevel1.Text + '^' + cboAccLevel2.Text)
  end;

  if not empty(cboAccLevel2.Text) then begin
    InsertAccountRecord(cboAccLevel2.Text, qryChartofAccountsAccountType.AsString, 'T', cboAccLevel1.Text)
  end;

  if not empty(cboAccLevel1.Text) then begin
    InsertAccountRecord(cboAccLevel1.Text, qryChartofAccountsAccountType.AsString, 'T', '')
  end;
  Result := true;
end;


function TfrmChartOfAccounts.InsertAccountRecord(const AccountName, AccountType, Active, AccountGroup: string): boolean;
var
  qryInsertRecord: TERPQuery;
begin
  qryInsertRecord := TERPQuery.Create(nil);
  qryInsertRecord.Connection := MyConnection;
  try
    qryInsertRecord.SQL.Add('INSERT HIGH_PRIORITY INTO tblchartofaccounts (AccountName,AccountType,Active,AccountGroup)' +
      'VALUES ("' + AccountName + '","' + AccountType + '","' + Active + '","' + AccountGroup + '");');
    try
      qryInsertRecord.Execute;
      Result := true;
    except
      // Almost Silent Exception
      on E: EMyError do Result := false;
    end;

  finally
    qryInsertRecord.Free;
  end;
end;

procedure TfrmChartOfAccounts.FormCreate(Sender: TObject);
begin
  inherited;
  fbcheckingIsHeader:= False;
  fbAllowNotInList := true;
  fsNewAccount := '';
  UserLock.Enabled := true;
end;

procedure TfrmChartOfAccounts.cboClassNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string;
  var Accept: boolean);
begin
  inherited;
  Accept := false;
  NotInListWarning(Sender);
end;

procedure TfrmChartOfAccounts.cboAccountTypeCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
var
  bIsBank: boolean;
begin
  if not Modified then Exit;
  inherited;
  edtBankAccName.Clear;
  edtBSB.Clear;
  edtBankAccNo.Clear;
  bIsBank := (cboAccountType.LookupValue = ACCOUNT_TYPE_BANK);
  edtBankAccName.Enabled := bIsBank;
  edtBSB.Enabled := bIsBank;
  edtBankAccNo.Enabled := bIsBank;
  lblBankAccDetails.Enabled := bIsBank;
  lblBankAccName.Enabled := bIsBank;
  lblBSB.Enabled := bIsBank;
  lblBankAccNo.Enabled := bIsBank;
  Label9.Enabled := bIsBank;
  txtLastChequeNo.Enabled := bIsBank;
  Label12.Enabled := bIsBank;
  APCANo.Enabled := bIsBank;
  Label18.Enabled := bIsBank;
  cboBankCode.Enabled := bIsBank;
  btnOptions.Enabled := bIsBank;
  //AccountNumber.Enabled := Not(bIsBank);
  chkAllowExpenseClaim.Checked := False;
  qryChartOfAccountsAllowExpenseClaim.AsString := 'F';
  chkAllowExpenseClaim.Enabled := (cboAccountType.LookupValue = ACCOUNT_TYPE_EXPENSE);
end;

function TfrmChartOfAccounts.PerformSave: boolean;
begin
  try
    {Account name cannot be duplicate}
    if not AccountNameUnique then begin
      CommonLib.MessageDlgXP_Vista('Account with this name already exists. Account name cannot be duplicate', mtWarning, [mbOK], 0);
      if edtAccountName.Enabled = false then edtAccountName.Enabled := true;
      SetControlFocus(edtAccountName);
      Result := false;
      Exit;
    end;

    if qryChartofAccountsRequired.AsBoolean and (qryChartofAccountsActive.AsString = 'F') then begin
      CommonLib.MessageDlgXP_Vista('This is a "Required" account, it can not be made inactive', mtWarning, [mbOK], 0);
      result:= false;
      exit;
    end;

    AddAllSubAccounts;

    qryChartOfAccounts.Edit;
    if qryAccClasses.RecordCount > 0 then
      qryChartOfAccounts.FieldByName('AllClasses').AsString := 'F';

    qryChartOfAccounts.FieldByName('AccountGroup').AsString := AccountGroupJoin;


    if (cboAccountType.LookupValue = ACCOUNT_TYPE_BANK) then begin
      qryChartOfAccounts.FieldByName('BankNumber').AsString := edtBSB.Text + edtBankAccNo.Text;
      qryChartOfAccounts.FieldByName('BSB').AsString := edtBSB.Text;
      qryChartOfAccounts.FieldByName('BankAccountNumber').AsString := edtBankAccNo.Text;
    end;

    qryChartOfAccounts.Post;
    //KeyId := GetLastRecordPostID('tblChartofAccounts' ,qryChartOfAccounts.Connection );
    KeyId := qryChartofAccountsAccountID.AsInteger;

    if qryChartOfAccountsGlobalref.AsString = '' then begin
      EditDb(qryChartOfAccounts);
      qryChartOfAccountsGlobalref.AsString:= AppEnv.Branch.SiteCode + qryChartOfAccountsAccountID.AsString;
      PostDb(qryChartOfAccounts);
    end;

    ProcessEditedFlag('Main', Self, memqryChartOfAccounts, qryChartOfAccounts, nil);
    qryChartOfAccounts.Edit;
    qryChartOfAccounts.Post;
    if qryAccClasses.RecordCount > 0 then begin
      qryAccClasses.Edit;
      qryAccClasses.Post;
    end;

    CommitTransaction;
    Result := true;
    Datastate.Dirty := false;
  except
    on E: Exception do begin
      raise E;
      Result := false;
    end;
  end;
end;

(*procedure TfrmChartOfAccounts.SeparateBankAccNo;
var
  sBankNo: string;
begin
  sBankNo := qryChartOfAccounts.FieldByName('BankNumber').AsString;
  edtBSB.Text := FastFuncs.LeftStr(sBankNo, AppEnv.RegionalOptions.BSBLength);
  Delete(sBankNo, 1, AppEnv.RegionalOptions.BSBLength);
  edtBankAccNo.Text := sBankNo;
end;*)

procedure TfrmChartOfAccounts.qryChartofAccountsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  LoadEditedFlagMemTable(qryChartOfAccounts, memqryChartOfAccounts);
end;

procedure TfrmChartOfAccounts.AccountTreeOrder;
var
  Level1: TTreeNode;
  Level2: TTreeNode;
  Level3: TTreeNode;
  procedure EnableLevel(AControl: TwwDBLookupCombo; AEnable: Boolean; ATabOrder: Integer = -1);
  begin
    if not AEnable then
      AControl.Text := '';
    AControl.Enabled := AEnable;
    if AEnable then begin
      AControl.TabOrder := ATabOrder;
      AControl.TabStop := True;
    end;
  end;
begin
  if Empty(cboAccLevel1.Text) then begin
     EnableLevel(cboAccLevel2, False);
     EnableLevel(cboAccLevel3, False);
  end else begin
     EnableLevel(cboAccLevel2, True, 2);
     if Empty(cboAccLevel2.Text) then
       EnableLevel(cboAccLevel3, False)
     else
       EnableLevel(cboAccLevel3, True, 3);
  end;
  AccountTreeView.Items.Clear;

  if Empty(cboAccLevel1.Text) then begin
    AccountTreeView.Items.Add(nil, edtAccountName.Text);
  end else if Empty(cboAccLevel2.Text) then begin
    Level1 := AccountTreeView.Items.Add(nil, cboAccLevel1.Text);
    AccountTreeView.Items.AddChild(Level1, edtAccountName.Text);
  end else if Empty(cboAccLevel3.Text) then begin
    Level1 := AccountTreeView.Items.Add(nil, cboAccLevel1.Text);
    Level2 := AccountTreeView.Items.AddChild(Level1, cboAccLevel2.Text);
    AccountTreeView.Items.AddChild(Level2, edtAccountName.Text);
  end else begin
    Level1 := AccountTreeView.Items.Add(nil, cboAccLevel1.Text);
    Level2 := AccountTreeView.Items.AddChild(Level1, cboAccLevel2.Text);
    Level3 := AccountTreeView.Items.AddChild(Level2, cboAccLevel3.Text);
    AccountTreeView.Items.AddChild(Level3, edtAccountName.Text);
  end;
  AccountTreeView.FullExpand;
end;

procedure TfrmChartOfAccounts.cboAccLevel1Change(Sender: TObject);
begin
  inherited;
  AccountTreeOrder;
end;

procedure TfrmChartOfAccounts.cboAccLevel2Change(Sender: TObject);
begin
  inherited;
  AccountTreeOrder;
end;

procedure TfrmChartOfAccounts.cboAccLevel3Change(Sender: TObject);
begin
  inherited;
  AccountTreeOrder;
end;

procedure TfrmChartOfAccounts.edtAccountNameChange(Sender: TObject);
begin
  inherited;
  AccountTreeOrder;
end;

procedure TfrmChartOfAccounts.AccountTreeViewClick(Sender: TObject);
begin
  inherited;
  AccountTreeView.FullExpand;
end;

procedure TfrmChartOfAccounts.AccountLevelCombosRefresh;
var
  xType, AccName, AccLvl1, AccLvl2, AccLvl3: string;
begin
  AccName := qryChartofAccounts.FieldByName('AccountName').AsString;
  AccLvl1 := cboAccLevel1.Text;
  AccLvl2 := cboAccLevel2.Text;
  AccLvl3 := cboAccLevel3.Text;
  xType := qryChartofAccounts.FieldByName('AccountType').AsString;

  qryAccLevel1.Close;
  qryAccLevel1.ParamByName('SelfAcc').asString := qryChartofAccountsAccountName.AsString;
  qryAccLevel1.ParamByName('xType').asString := xType;
  qryAccLevel1.Open;

  qryAccLevel2.Close;
  qryAccLevel2.ParamByName('SubAcc').asString := AccLvl1;
  qryAccLevel2.ParamByName('xType').asString := xType;
  qryAccLevel2.ParamByName('SelfAcc').asString := qryChartofAccountsAccountName.AsString;
  qryAccLevel2.Open;

  qryAccLevel3.Close;
  qryAccLevel3.ParamByName('SubAcc').asString := AccLvl1 + '^' + AccLvl2;
  qryAccLevel3.ParamByName('xType').asString := xType;
  qryAccLevel3.ParamByName('SelfAcc').asString := qryChartofAccountsAccountName.AsString;
  qryAccLevel3.Open;

  cboAccLevel1.LookupValue := AccLvl1;
  cboAccLevel2.LookupValue := AccLvl2;
  cboAccLevel3.LookupValue := AccLvl3;
end;

procedure TfrmChartOfAccounts.cboAccLevel1Exit(Sender: TObject);
begin
  inherited;
  AccountLevelCombosRefresh;
  PostMessage(Self.Handle, WM_SetFocus, 2, 0);
end;

procedure TfrmChartOfAccounts.cboAccLevel2Exit(Sender: TObject);
begin
  inherited;
  AccountLevelCombosRefresh;
  PostMessage(Self.Handle, WM_SetFocus, 3, 0);
end;

procedure TfrmChartOfAccounts.cboAccLevel3Exit(Sender: TObject);
begin
  inherited;
  AccountLevelCombosRefresh;
end;

procedure TfrmChartOfAccounts.cboAccLevel1NotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
begin
// inherited;
  Accept := False;
  CommonLib.MessageDlgXP_Vista('The Account "' + AccountGroupJoin + '" Has Not Been Created.' + #13 + #10 + '' +
    #13 + #10 + 'Please Create It Try Again.', mtWarning, [mbOK], 0);
end;

procedure TfrmChartOfAccounts.FormCloseQuery(Sender: TObject; var CanClose: boolean);

begin
  inherited;

  if not fbSaveClicked then begin
    if DataState.IsActive and DataState.Dirty then begin
      Canclose:= saveOrCancelChanges;
    end else begin
      //
      // A rollback is performed as a post has already occurred during the
      // FormShow method.
      //
      RollbackTransaction;
    end;
  end;
end;
function TfrmChartOfAccounts.SaveOrCancelChanges:boolean;
var
  iExitResult: integer;
begin
  REsult := true;
  iExitResult := CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation,
    [mbYes, mbNo, mbCancel], 0);
  case iExitResult of
    mrYes:
      begin
        Result := AccountSaved;
        if result then begin
          CommitTransaction;
          Notify(False);
        end;
      end;
    mrNo:
      begin;
        RollbackTransaction;
        Notify(True);
        REsult := true;
      end;
    mrCancel:
      begin
        REsult := false;
      end;
  end;

end;
procedure TfrmChartOfAccounts.btnOptionsClick(Sender: TObject);
Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TEFTOptions');
    if not Assigned(Form) then Exit;
    with TEFTOptions(Form) do begin
      IncludeBalanceRecord := qryChartofAccountsIncludeBalanceRecord.AsBoolean;
      IncludeNetTotal := qryChartofAccountsIncludeNetTotal.AsBoolean;
      IncludeCreditTotal := qryChartofAccountsIncludeCreditTotal.AsBoolean;
      IncludeDebitTotal := qryChartofAccountsIncludeDebitTotal.AsBoolean;
      Position := poScreenCenter;
      if ShowModal = mrOk then begin
        qryChartofAccounts.Edit;
        qryChartofAccountsIncludeBalanceRecord.AsBoolean := IncludeBalanceRecord;
        qryChartofAccountsIncludeNetTotal.AsBoolean := IncludeNetTotal;
        qryChartofAccountsIncludeCreditTotal.AsBoolean := IncludeCreditTotal;
        qryChartofAccountsIncludeDebitTotal.AsBoolean := IncludeDebitTotal;
      end;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmChartOfAccounts.cboAccountTypeExit(Sender: TObject);
begin
  inherited;
  AccountLevelCombosRefresh;
  PostMessage(Self.Handle, WM_SetFocus, 1, 0);
end;

(*procedure TfrmChartOfAccounts.btnDeleteClick(Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      qryAccClasses.Delete;
    except
      {Do nothing - raise a silent exception}
    end;
  end;
end;*)

procedure TfrmChartOfAccounts.grdTransactionsExit(Sender: TObject);
begin
  inherited;
  if qryAccClasses.RecordCount > 0 then begin
    qryChartOfAccounts.Edit;
    qryChartOfAccounts.FieldByName('AllClasses').AsString := 'F';
  end;
end;

procedure TfrmChartOfAccounts.chkActiveClick(Sender: TObject);
begin
  inherited;
  if not(Screen.ActiveControl =chkActive) then exit;

  if not chkActive.Checked then  begin
    if (RoundCurrency(qryChartofAccountsBalance.AsFloat) <> 0.00) then begin
      CommonLib.MessageDlgXP_Vista('Cannot Deactivate This Account As It''s Balance Is Not Zero', mtWarning, [mbOK], 0);
      qryChartofAccounts.Edit;
      qryChartofAccountsActive.AsString := 'T';
      Exit;
    end;
    if not(TAccount.Inactivateallchildren(qryChartofAccountsAccountname.asString,qryChartofAccounts.Connection , Self)) then begin
      qryChartofAccounts.Edit;
      qryChartofAccountsActive.AsString := 'T';
      Exit;

    end;
  end else begin
    TAccount.ActivateallParents(qryChartofAccountsAccountID.AsInteger,qryChartofAccounts.Connection , Self);
  end;
end;

procedure TfrmChartOfAccounts.chkIsHeaderClick(Sender: TObject);
var
  s: string;
begin
  inherited;
  if fbcheckingIsHeader then exit;
  fbcheckingIsHeader:= True;
  try
    PostDB(qryChartOfAccounts);
    if screen.ActiveControl = chkIsHeader then
      if chkIsHeader.Checked then begin
        if TAccount.AccountInUse(self.qryChartofAccountsAccountID.AsInteger, s, qryChartofAccounts.Connection) then begin
          CommonLib.MessageDlgXP_Vista('Cannot make this account a header account, there are transactions in ERP already using this account.',
            mtWarning, [mbOK], 0);
          chkIsHeader.Checked := false;
          SendKeys('{TAB}',True);
          editDB(qryChartofAccounts);
          qryChartofAccountsISHeader.AsBoolean := False;
          PostDB(qryChartofAccounts);
        end;
      end;
  finally
    fbcheckingIsHeader:= False;
  end;
end;

procedure TfrmChartOfAccounts.edtBSBCheckValue(Sender: TObject; PassesPictureTest: boolean);
begin
  inherited;
  if PassesPictureTest = false then Abort;
end;

function TfrmChartOfAccounts.AccountNameUnique: boolean;
var
  Qry: TERPQuery;
begin
  Qry := TERPQuery.Create(nil);
  with Qry do try
      Connection := MyConnection;
      Sql.add('Select AccountId from tblChartofAccounts where AccountName  = ' +
        QuotedStr(qryChartofAccountsAccountName.AsString));
      if qryChartofAccountsAccountID.AsString <> '' then SQL.add(' and AccountId <> ' + qryChartofAccountsAccountID.AsString);
      Open;
      Result := RecordCount = 0;
    finally
      if active then Close;
      free;
    end;
end;

procedure TfrmChartOfAccounts.FormDestroy(Sender: TObject);
begin
  Notify;
  inherited;
end;

procedure TfrmChartOfAccounts.SetFocusToAccCombo(var Msg: TMessage);
begin
  case Msg.wParam of
    1: 
      begin
        if cboAccLevel1.Enabled and cboAccLevel1.Visible then SetControlFocus(cboAccLevel1);
      end;
    2: 
      begin
        if cboAccLevel2.Enabled and cboAccLevel2.Visible then SetControlFocus(cboAccLevel2);
      end;
    3: 
      begin
        if cboAccLevel3.Enabled and cboAccLevel3.Visible then SetControlFocus(cboAccLevel3);
      end;
  end;
end;

procedure TfrmChartOfAccounts.SetKeyString(const Value: string);
begin
  (*if self.qryChartofAccounts.Active then
    self.qryChartofAccountsAccountName.AsString:= Value;
  if KeyID = 0 then
    KeyId:= TAccount.IDToggle(Value);*)
  SetKeyString(TAccount, qryChartofAccounts, Value , 'AccountName');
end;

procedure TfrmChartOfAccounts.cbTaxCodeQryBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  cbTaxCodeQry.ParamByName('xRegionID').asInteger := AppEnv.RegionalOptions.ID;
end;

procedure TfrmChartOfAccounts.qryAccClassesAfterInsert(DataSet: TDataSet);
begin
  inherited;
    Dataset.fieldbyname('AccountID').asInteger := qryChartofAccountsAccountID.AsInteger;
end;

procedure TfrmChartOfAccounts.qryAccClassesBeforePost(DataSet: TDataSet);
begin
  inherited;
        if Dataset.Fieldbyname('classId').asInteger = 0 then Abort;
end;
procedure TfrmChartOfAccounts.KeyIdChanged(const NewKeyId: integer);
begin
  logInuseform;
  if UserLock.Enabled and (AccessLevel < 5) then begin
    // remove all existing locks
    UserLock.UnlockAllCurrentInstance;

    if (KeyId > 0) then begin
      if not UserLock.Lock('tblChartofAccounts', KeyId, Self.Caption) then begin
        AccessLevel := 5; // read only

        CommonLib.MessageDlgXP_Vista(UserLock.LockMessage + #13 + #10 + #13 + #10 + 'Access has been changed to read-only.',
          mtWarning, [mbOK], 0);
      end;
    end;
  end;
end;

function TfrmChartOfAccounts.isCOAUniqueRecord: Boolean;
var
  strSQL:String;
begin
  PostDB(qryChartofAccounts);
  strSQL:= 'Select AccountId ' +
            ' from tblChartofAccounts ' +
            ' where accountName = ' +quotedStr(qryChartofAccountsAccountName.asString) +
            ' and accountId <> ' +IntToStr(qryChartofAccountsAccountID.asInteger);
  With commonDbLib.TempMyQuery do try
    SQL.add(strSQL);
    Open;
    result := recordcount = 0;
    if not result then
      CommonLib.MessageDlgXP_Vista('Account Name Should be Unique.', mtWarning, [mbOK], 0);
  finally
      if active then Close;
      free;
  end;
  if not result then exit;
  if qryChartofAccountsAccountNumber.asString = '' then exit;

  strSQL:= 'Select AccountId ' +
            ' from tblChartofAccounts ' +
            ' where Accountnumber = ' + QuotedStr(qryChartofAccountsAccountNumber.asString) +
            ' and accountId <> ' +IntToStr(qryChartofAccountsAccountID.asInteger);
  With commonDbLib.TempMyQuery do try
    SQL.add(strSQL);
    Open;
    result := recordcount = 0;
    if not result then
      CommonLib.MessageDlgXP_Vista('Account No Should be Unique.', mtWarning, [mbOK], 0);
  finally
      if active then Close;
      free;
  end;
end;

initialization
  RegisterClassOnce(TFrmChartofAccounts);
  with FormFact do begin
    RegisterMe(TfrmChartOfAccounts, 'TChartOfAccountsListGUI_*=AccountID');
    RegisterMe(TfrmChartOfAccounts, 'TChartOfAccountsListExpressGUI_*=AccountID');
    RegisterMe(TfrmChartOfAccounts, 'TBankAccountListGUI_*=AccountID');
    RegisterMe(TfrmChartOfAccounts, 'TAccountrunningBalanceGUI_*=AccountID');
    RegisterMe(TfrmChartOfAccounts, '*_cboAccount=AccountID'); { TODO : probably not what was meant - leave it for now }
    RegisterMe(TfrmChartOfAccounts, 'TGlobalsearchGUI_*_Account=AccountID');
    RegisterControl(TfrmChartOfAccounts, '*_cboCOA=AccountID');
    RegisterControl(TfrmChartOfAccounts, '*_cboAccountLine=AccountID');
    RegisterControl(TfrmChartOfAccounts, '*_cboAccount=AccountID');
    RegisterControl(TfrmChartOfAccounts, '*_cboASSETACC=AccountID');
    RegisterControl(TfrmChartOfAccounts, '*_cboCOGSACC=AccountID');
    RegisterControl(TfrmChartOfAccounts, '*_cboINCOMEACC=AccountID');
    RegisterControl(TfrmChartOfAccounts, '*_cboAccountLine=AccountID');
    RegisterControl(TfrmChartOfAccounts, '*_cboIncomeAcnt=AccountID');
    RegisterControl(TfrmChartOfAccounts, '*_cboCOGSAcnt=AccountID');
    RegisterControl(TfrmChartOfAccounts, '*_cboAssetAcnt=AccountID');
    RegisterControl(TfrmChartOfAccounts, '*_cboDefaultSales=AccountID');
    RegisterControl(TfrmChartOfAccounts, '*_cboDefPurch=AccountID');
    RegisterControl(TfrmChartOfAccounts, '*_cboPayCustAcnt=AccountID');
    RegisterControl(TfrmChartOfAccounts, '*_cboPaySuppAcnt=AccountID');
    RegisterControl(TfrmChartOfAccounts, '*_cboPayCCAcnt=AccountID');
    RegisterControl(TfrmChartOfAccounts, '*_cboDefaultPostAccount=AccountName');
  end;
end.




