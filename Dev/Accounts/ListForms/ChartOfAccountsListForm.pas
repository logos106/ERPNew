unit ChartOfAccountsListForm;

{ Date     Version Who  What
 -------- -------- ---  --------------------------------------------------------
 07/09/05  1.00.01 IJB  Modified to use new filtering on base listing.
 }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar, 
  SelectionDialog, DNMPanel, wwDialog, Wwlocate, wwcheckbox, MemDS,
  DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog, 
  wwdblook, Shader, kbmMemTable, DAScript, MyScript, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TChartOfAccountsListGUI = class(TBaseListingGUI)
    qryMainAccountNumber: TWideStringField;
    qryMainType: TWideStringField;
    qryMainFullAccountName: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainBalance: TFloatField;
    qryMainTaxCode: TWideStringField;
    qryMainTaxCodeDescription: TWideStringField;
    qryMainBSB: TWideStringField;
    qryMainBankAccNo: TWideStringField;
    qryMainBankAccountName: TWideStringField;
    qryMainBankNumber: TWideStringField;
    qryMainAccountName: TWideStringField;
    qryMainAccountGroup: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainTaxCodeID: TIntegerField;
    qryMainAccountID: TIntegerField;
    qryMainAccountTree: TWideStringField;
    qryMainLevel1: TWideStringField;
    qryMainLevel2: TWideStringField;
    qryMainLevel3: TWideStringField;
    qryMainLevel4: TWideStringField;
    chkTreeMode: TwwCheckBox;
    qryMainTotalBalance: TCurrencyField;
    N1: TMenuItem;
    Merge1: TMenuItem;
    Label4: TLabel;
    TotalBalances: TERPQuery;
    qryMainSortOrder: TIntegerField;
    qryMainBudgetAccountno: TLargeintField;
    qryMainAllowExpenseClaim: TWideStringField;
    btnEdit: TDNMSpeedButton;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure chkTreeModeClick(Sender: TObject);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: boolean; var Accept: boolean);
    procedure actMergeExecute(Sender: TObject);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);

  private
    LastSelectedID: integer;
    procedure BudgetEntry(grdMain: TwwDbGrid);
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }

  end;


implementation

uses Forms, CommonLib, frmChartofAccountsFrm, TransAccountDetailsForm,
     MergeObj, frmChartOfAccountsTree, {tcMessaging,} MAIN, tcDataUtils,
     AppContextObj, frmAccountbudget, frmBudgetSelector, 
     AppEnvironment, dmMainGUI, UserUtilsClientObj, frmAccountListEditPopUp;

{$R *.dfm}

procedure TChartOfAccountsListGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:
      begin
        GroupFilterString := 'Active = ' + QuotedStr('T');
      end;
    1:
      begin
        GroupFilterString := 'Active = ' + QuotedStr('F');
      end;
    2:
      begin
           GroupFilterString := 'BudgetAccountno > 0';
      end;
  end;
  inherited;
end;             
procedure TChartOfAccountsListGUI.BudgetEntry(grdMain: TwwDbGrid);
Var Form : TComponent;
    BudgetID :Integer;
begin
  inherited;
  Self.CloseOnRecSelect := True;
  Form := GetComponentByClassName('TfmBudgetSelector');
  Try
    TfmBudgetSelector(Form).AccountId :=qryMainAccountID.asInteger;
    TfmBudgetSelector(form).ShowModal;
    if TfmBudgetSelector(Form).ModalREsult = mrCancel then begin
        Self.CloseOnRecSelect := False;
        Exit;
    end;
    BudgetID := TfmBudgetSelector(form).BudgetID;
  Finally
    FreeandNil(Form);
  end;
  Form := GetComponentByClassName('TfmAccountbudget');
  if Assigned(Form) then begin
    with TfmAccountbudget(Form) do begin
      AttachObserver(Self);
      AccountId := qryMainAccountID.asInteger;
      AccountName := qryMainAccountName.asString;
      BudgetDefId := BudgetID;
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;

end;

procedure TChartOfAccountsListGUI.FormShow(Sender: TObject);
begin
  inherited;
  {concatenated field}
  cbofilter.Items.Delete(cbofilter.Items.IndexOf('FULLACCOUNTNAME'));
  cbofilter.Items.Delete(cbofilter.Items.IndexOf('ACCOUNTGROUP'));
  cbofilter.Items.Delete(cbofilter.Items.IndexOf('ACCOUNTTREE'));

  GuiPrefs.DbGridElement[grdMain].RemoveFields('AccountID,TaxCodeID');
  GroupFilterString := 'Active = ' + QuotedStr('T');
  ApplyQueryFilter;
  if AppContext['AccountList'].VarExists('Budget') then
        if AppContext['AccountList'].VarByname['Budget'] = 'T' then  begin
            onGridDataselect := BudgetEntry;
            grpFilters.ItemIndex:= 2;
        end;
  if AppContext['AccountList'].VarExists('Budget') then
    AppContext.DeleteContext('AccountList');
  if not(Assigned(fOnGridDataSelect)) then begin
    EnableMultiSelect('Choose Records of the Same Type to Merge');
  end;
end;

procedure TChartOfAccountsListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  DisableForm;
  try
    inherited;
    Form := GetComponentByClassName('TfrmChartOfAccounts');
    if Assigned(Form) then begin
      with TfrmChartOfAccounts(Form) do begin
        AttachObserver(Self);
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
  finally
    EnableForm;
  end;  
end;
procedure TChartOfAccountsListGUI.grdMainDblClick(Sender: TObject);
var
  frmTransAccountDetails: TComponent;
begin
  if not (grdMain.GetActiveField = qryMainBalance) then begin
    inherited;
  end else begin

    if FormStillOpen('TTransAccountDetailsGUI') then TForm(FindExistingComponent('TTransAccountDetailsGUI')).Close;
    if not FormStillOpen('TTransAccountDetailsGUI') then begin
      frmTransAccountDetails := GetComponentByClassName('TTransAccountDetailsGUI');
      if Assigned(frmTransAccountDetails) then begin
        with TTransAccountDetailsGUI(frmTransAccountDetails) do begin
          ToDate := Now;
          FromDate := 0;
          qryMain.SQL.Add('AND AccountID = ' + qryMainAccountID.AsString + ' Group by TransID;');
          WhereString := 'AND (AccountID = ' + qryMainAccountID.AsString + ' )';
          FormStyle := fsmdiChild;
        end;
      end;  
    end else begin
      TForm(FindExistingComponent('TTransAccountDetailsGUI')).Show;
    end;
  end;
end;

procedure TChartOfAccountsListGUI.chkTreeModeClick(Sender: TObject);
var
  frm: TfmChartOfAccountsTree;
begin
  ProcessingCursor(True);
  try
    inherited;
    frm := TfmChartOfAccountsTree(GetComponentByClassName('TfmChartOfAccountsTree'));
    if Assigned(frm) then begin
      with frm do begin
        FormStyle := fsMDIChild;
        BringToFront;
      end;
    end;
    Close;
  finally
    ProcessingCursor(False);
  end;
end;



procedure TChartOfAccountsListGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: boolean; var Accept: boolean);
begin
  inherited;
  LastSelectedID := qryMain.FieldByName('AccountID').AsInteger;
end;

procedure TChartOfAccountsListGUI.actMergeExecute(Sender: TObject);
var
  i: integer;
  MergeObj: TMergeObj;
  PrincipleName: string;
  PrincipleID: integer;
  PrincipleType: string;
  SecordaryName: string;
  SecordaryID: integer;
  msg: string;
begin
  inherited;
  if grdMain.SelectedList.Count > 1 then begin
    qryMain.DisableControls;
    qryMain.Locate('AccountID', LastSelectedID, [loCaseInsensitive]);
    PrincipleName := GetAccountName(qryMain.FieldByName('AccountID').AsInteger);
    PrincipleID   := qryMain.FieldByName('AccountID').AsInteger;
    PrincipleType:= qryMain.FieldByName('Type').AsString;

    { first make sure accounts are of the same tyep }
    for i := 0 to grdMain.SelectedList.Count - 1 do begin
      qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
      if qryMain.FieldByName('AccountID').AsInteger <> PrincipleID then begin
        if PrincipleType <> qryMain.FieldByName('Type').AsString then begin
          CommonLib.MessageDlgXP_Vista('Can''t merge Accounts of different Types !', mtInformation, [mbOK], 0);
          exit;
        end;
      end;
    end;


    if CommonLib.MessageDlgXP_Vista('Are you sure you wish to merge these accounts into ' + PrincipleName, mtConfirmation,
      [mbYes, mbNo], 0) = mrYes then begin
      for i := 0 to grdMain.SelectedList.Count - 1 do begin
        qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
        if qryMain.FieldByName('AccountID').AsInteger = PrincipleID then
          continue;
        SecordaryName := GetAccountName(qryMain.FieldByName('AccountID').AsInteger);
        SecordaryID := qryMain.FieldByName('AccountID').AsInteger;

        // Ensure there is only one user connected to the database.  That is You only!
        if AppEnv.UtilsClient.LockLogon(msg,AppEnv.AppDb.Database, 'Performing a Merge Account') then begin
          try
            MergeObj := TMergeObj.Create;
            try
              MergeObj.Merge(mAccount, PrincipleName, PrincipleID, SecordaryName, SecordaryID);
            finally
              MergeObj.Free;
            end;
          finally
            AppEnv.UtilsClient.UnlockLogon;
          end;
        end
        else begin
          if msg = USERS_IN_SYSTEM_MESSAGE then begin
            MainForm.GetCurrentUserCount;
            dtmMainGUI.dlgCurrentUsers.Caption := qryMain.Connection.Database + ' Merge Account';
            dtmMainGUI.dlgCurrentUsers.Color := pnlHeader.Color;
            dtmMainGUI.dlgCurrentUsers.Message := 'The following user(s) must exit the system.';
            dtmMainGUI.dlgCurrentUsers.Execute;
          end
          else begin
            MessageDlgXP_Vista('Unable to merge Accounts, Unable to Lock User Logon: ' + msg, mtInformation, [mbOk], 0);
          end;
        end;
      end;
    end;
    grdMain.SelectedList.Clear;
    qryMain.EnableControls;
    TotalBalances.Close;
    TotalBalances.Open;
    UpdateMe;
  end else begin
    CommonLib.MessageDlgXP_Vista('Please select at least two (2) Accounts.' + #13 + #10 +
      '(Hold down ''CTRL'' and click on row to toggle selection.)',
      mtInformation, [mbOK], 0);
  end;
end;

procedure TChartOfAccountsListGUI.RefreshQuery;
begin
  inherited;
  if chkTreeMode.Checked then begin
    UseSortinSearch         := false;
    grdMain.OnTitleButtonClick := nil;
    qryMain.IndexFieldNames := 'FullAccountName ASC CIS';
  end else begin
    UseSortinSearch := true;
    grdMain.OnTitleButtonClick := grdMainTitleButtonClick;
  end;
end;

procedure TChartOfAccountsListGUI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.Params.ParamByName('xRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

procedure TChartOfAccountsListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  KeyIdfieldname := Qrymainaccountid.Fieldname;
  KeyNamefieldname :=Qrymainaccountname.Fieldname;
  LastSelectedID:= 0;
  ShowChartViewOnPopup := True;
end;

procedure TChartOfAccountsListGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TChartOfAccountsListGUI.btnEditClick(Sender: TObject);
begin
  inherited;
  DoEditFromAccountList;
end;

procedure TChartOfAccountsListGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TChartOfAccountsListGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TChartOfAccountsListGUI);
end.

