unit fraPayTaxConfigEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, wwdbedit, Wwdotdot, Wwdbcomb, ExtCtrls, DNMPanel,
  ERPDbComponents, wwcheckbox, AdvEdit, DBAdvEd, DB, MemDS, DBAccess, MyAccess,
  wwdblook, tcDataUtils;

type
  TfrPayTaxConfigEdit = class(TFrame)
    pnlMain: TDNMPanel;
    lblTaxName: TLabel;
    cboExpense: TwwDBLookupcombo;
    cboLiability: TwwDBLookupcombo;
    cboType: TwwDBComboBox;
    edtAllowanceAmount: TDBAdvEdit;
    chkRound: TwwCheckBox;
    lblType: TLabel;
    lblAllowance: TLabel;
    lblRound: TLabel;
    Bevel1: TBevel;
    lblInstruct: TLabel;
    lblGroup: TLabel;
    cboGroup: TwwDBComboBox;
    lblExpense: TLabel;
    lblLiability: TLabel;
    qryExp: TERPQuery;
    qryExpAccountName: TWideStringField;
    qryExpType: TWideStringField;
    qryExpAccountID: TIntegerField;
    qryLiab: TERPQuery;
    WideStringField1: TWideStringField;
    WideStringField2: TWideStringField;
    IntegerField1: TIntegerField;
    procedure cboExpenseChange(Sender: TObject);
    procedure cboLiabilityChange(Sender: TObject);
    procedure cboTypeChange(Sender: TObject);
    procedure edtAllowanceAmountChange(Sender: TObject);
    procedure chkRoundClick(Sender: TObject);
    procedure pnlMainDblClick(Sender: TObject);
    procedure lblTaxNameDblClick(Sender: TObject);
    procedure cboExpenseDblClick(Sender: TObject);
    procedure cboLiabilityDblClick(Sender: TObject);
    procedure cboTypeDblClick(Sender: TObject);
    procedure edtAllowanceAmountDblClick(Sender: TObject);
    procedure lblInstructDblClick(Sender: TObject);
  private
    fId: integer;
    fConnection: TERPConnection;
    Loading: boolean;
    function GetID: integer;
    procedure SetID(const Value: integer);
    procedure SetConnection(const Value: TERPConnection);
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    property ID: integer read GetID write SetID;
    property Connection: TERPConnection read fConnection write SetConnection;
    procedure Load;
    procedure Save;
  end;

implementation

uses
  DbSharedObjectsObj, PreferancesLib;

{$R *.dfm}

{ TfrPayTaxConfigEdit }

procedure TfrPayTaxConfigEdit.cboExpenseChange(Sender: TObject);
begin
  if not Loading then
    Save;
end;

procedure TfrPayTaxConfigEdit.cboExpenseDblClick(Sender: TObject);
begin
  self.OnDblClick(self);
end;

procedure TfrPayTaxConfigEdit.cboLiabilityChange(Sender: TObject);
begin
  if not Loading then
    Save;
end;

procedure TfrPayTaxConfigEdit.cboLiabilityDblClick(Sender: TObject);
begin
  self.OnDblClick(self);
end;

procedure TfrPayTaxConfigEdit.cboTypeChange(Sender: TObject);
begin
  if not Loading then
    Save;
end;

procedure TfrPayTaxConfigEdit.cboTypeDblClick(Sender: TObject);
begin
  self.OnDblClick(self);
end;

procedure TfrPayTaxConfigEdit.chkRoundClick(Sender: TObject);
begin
  if not Loading then
    Save;
end;

constructor TfrPayTaxConfigEdit.Create(AOwner: TComponent);
begin
  inherited;
  Loading := false;
end;

procedure TfrPayTaxConfigEdit.edtAllowanceAmountChange(Sender: TObject);
begin
  if not Loading then
    Save;
end;

procedure TfrPayTaxConfigEdit.edtAllowanceAmountDblClick(Sender: TObject);
begin
  self.OnDblClick(self);
end;

function TfrPayTaxConfigEdit.GetID: integer;
begin
  result := fId;
end;

procedure TfrPayTaxConfigEdit.lblInstructDblClick(Sender: TObject);
begin
  self.OnDblClick(self);
end;

procedure TfrPayTaxConfigEdit.lblTaxNameDblClick(Sender: TObject);
begin
  self.OnDblClick(self);
end;

procedure TfrPayTaxConfigEdit.Load;
var
  qry: TERPQuery;
begin
  if Loading then exit;

  if Id = 0 then exit;
  if not Assigned(fConnection) then exit;
  Loading := true;
  qry := DbSharedObj.GetQuery(fConnection);
  try
    qry.SQL.Text := Format('select T.*, a.accountName as ExpenseAccountName, B.AccountName as LiabilityAccountName ' +
                            'from tblpaytaxconfig T ' +
                            'left join tblchartofaccounts A on A.AccountId = T.ExpenseAccountId ' +
                            'left join tblchartofaccounts B on B.AccountId = T.LiabilityAccountId where T.ID = %d', [id]);
    qry.Open;
    lblTaxName.Caption := qry.FieldByName('TaxName').AsString;
    cboExpense.LookupValue := qry.FieldByName('ExpenseAccountId').asString;
    cboLiability.LookupValue := qry.FieldByName('LiabilityAccountId').asString;

    cboType.ItemIndex := cboType.Items.IndexOf(qry.FieldByName('TaxType').AsString);
    edtAllowanceAmount.FloatValue := qry.FieldByName('AllowanceAmount').AsFloat;
    chkRound.Checked := qry.FieldByName('RoundTax').AsBoolean;
    //cboGroup.ItemIndex :=
    cboGroup.Value := qry.FieldByName('GroupType').AsSTring;
  finally
    DbSharedObj.ReleaseObj(qry);
    Loading := false;
  end;
end;

procedure TfrPayTaxConfigEdit.pnlMainDblClick(Sender: TObject);
begin
  self.OnDblClick(self);
end;

procedure TfrPayTaxConfigEdit.Save;
var
  cmd: TERPCommand;
begin
  if Id = 0 then exit;
  if not Assigned(fConnection) then exit;
  cmd := DbSharedObj.GetCommand(fConnection);
  try
    cmd.SQL.Add('update tblpaytaxconfig');
    cmd.SQL.Add('set ExpenseAccountId = ' + cboExpense.LookupValue);
    cmd.SQL.Add(', LiabilityAccountId = ' + cboLiability.LookupValue);
    cmd.SQL.Add(', TaxType = ' + QuotedStr(cboType.Text));
    cmd.SQL.Add(', AllowanceAmount = ' + FloatToStr(edtAllowanceAmount.FloatValue));
    cmd.SQL.Add(', GroupType = "' + cboGroup.Value + '"');
    if chkRound.Checked then
      cmd.SQL.Add(', RoundTax = "T"')
    else
      cmd.SQL.Add(', RoundTax = "F"');
    cmd.SQL.Add('where ID = ' + IntToStr(ID));
    cmd.Execute;
    PreferancesLib.DoPrefAuditTrail
    ;
  finally
    DbSharedObj.ReleaseObj(cmd);
  end;
end;

procedure TfrPayTaxConfigEdit.SetConnection(const Value: TERPConnection);
begin
  fConnection := Value;
  if qryExp.Active then qryExp.Close;
  qryExp.Connection := value;
  qryExp.Open;

  if qryLiab.Active then qryLiab.Close;
  qryLiab.Connection := value;
  qryLiab.Open;
(*var
  qry: TERPQuery;
begin
  fConnection := Value;
  qry := DbSharedObj.GetQuery(fConnection);
  try
    qry.SQL.Text := 'select AccountId, AccountName ' +
      'from tblchartofaccounts where AccountType = "EXP" and Active = "T" order by AccountNAme';
    qry.Open;
    cboExpense.Items.Clear;
    while not qry.Eof do begin
      cboExpense.Items.Add(qry.FieldByName('AccountName').AsString + #9 + qry.FieldByName('AccountID').AsString);
      qry.Next;
    end;
    qry.Close;

    qry.SQL.Text := 'select AccountId, AccountName ' +
      'from tblchartofaccounts where AccountType = "OCLIAB" and Active = "T" order by AccountNAme';
    qry.Open;
    cboLIability.Items.Clear;
    while not qry.Eof do begin
      cboLIability.Items.Add(qry.FieldByName('AccountName').AsString + #9 + qry.FieldByName('AccountID').AsString);
      qry.Next;
    end;
    qry.Close;

  finally
    DbSharedObj.ReleaseObj(qry);
  end;*)
end;

procedure TfrPayTaxConfigEdit.SetID(const Value: integer);
begin
  fId := Value;
  Load;
end;

end.
