unit fraPayTaxScaleConfigUSA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ERPDbComponents, AdvEdit, DBAdvEd, StdCtrls, Mask, wwdbedit,
  Wwdotdot, Wwdbcomb;

type
  TfrPayTaxScaleConfigUSA = class(TFrame)
    lblTaxName: TLabel;
    cboScale: TwwDBComboBox;
    edtAllowanceQty: TDBAdvEdit;
    cboExpenseAccount: TwwDBComboBox;
    cboLiabilityAccount: TwwDBComboBox;
    procedure cboScaleChange(Sender: TObject);
    procedure edtAllowanceQtyChange(Sender: TObject);
  private
    fConnection: TERPConnection;
    fID: integer;
    Loading: boolean;
    procedure SetConnection(const Value: TERPConnection);
    procedure SetID(const Value: integer);
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    property ID: integer read fID write SetID;
    property Connection: TERPConnection read fConnection write SetConnection;
    procedure Load;
    procedure Save;
  end;

implementation

uses
  DbSharedObjectsObj, AppEnvironment;

{$R *.dfm}

{ TfrPayTaxScaleConfig }


procedure TfrPayTaxScaleConfigUSA.cboScaleChange(Sender: TObject);
begin
  if not Loading then
    Save;
end;


constructor TfrPayTaxScaleConfigUSA.Create(AOwner: TComponent);
begin
  inherited;
  Loading := false;
end;

procedure TfrPayTaxScaleConfigUSA.edtAllowanceQtyChange(Sender: TObject);
begin
  if not Loading then
    Save;
end;

procedure TfrPayTaxScaleConfigUSA.Load;
var
  qry : TERPQuery;
begin
  if Loading then Exit;

  if Id = 0 then Exit;
  if not Assigned(fConnection) then Exit;

  Loading := true;
  qry := DbSharedObj.GetQuery(fConnection);
  try
    qry.SQL.Add('SELECT c.TaxName, sc.*');
//    qry.SQL.Add('SELECT c.TaxName, sc.TaxScaleId, sc.ExpenseAccountId, sc.LiabilityAccountId, sc.AllowanceQty, sc.TT_Category');
    qry.SQL.Add('FROM tblPayTaxScaleConfig sc');
    qry.SQL.Add('INNER JOIN tblPayTaxConfig c ON c.ID = sc.PayTaxConfigId');
    qry.SQL.Add('WHERE sc.Id=' + IntToStr(Id));
    qry.Open;

    lblTaxName.Caption := qry.FieldByName('TaxName').AsString;

    cboScale.Value := IntToStr(qry.FieldByName('TaxScaleId').AsInteger);


    cboExpenseAccount.Value := IntToStr(qry.FieldByName('ExpenseAccountId').AsInteger);
    cboLIabilityAccount.Value := IntToStr(qry.FieldByName('LiabilityAccountId').AsInteger);
    edtAllowanceQty.IntValue := qry.FieldByName('AllowanceQty').AsInteger;
  finally
    DbSharedObj.ReleaseObj(qry);
    Loading := false;
  end;
end;



procedure TfrPayTaxScaleConfigUSA.Save;
var
  cmd: TERPCommand;
begin
//  if Id = 0 then exit;
  if not Assigned(fConnection) then exit;
  cmd := DbSharedObj.GetCommand(fConnection);
  try
    cmd.SQL.Add('UPDATE tblPaytaxScaleConfig ');
    cmd.SQL.Add('SET TaxScaleId = ' + IntToStr(StrToIntDef(cboScale.Value, 0)));
    cmd.SQL.Add(', AllowanceQty = ' + IntToStr(edtAllowanceQty.IntValue));
    cmd.SQL.Add(', ExpenseAccountId = ' + cboExpenseAccount.Value);
    cmd.SQL.Add(', LiabilityAccountId = ' + cboLiabilityAccount.Value);

    cmd.SQL.Add(' WHERE ID = ' + IntToStr(ID));

    cmd.Execute;

  finally
    DbSharedObj.ReleaseObj(cmd);
  end;
end;


procedure TfrPayTaxScaleConfigUSA.SetConnection(const Value: TERPConnection);
var
  qry: TERPQuery;
begin
  fConnection := Value;
  qry := DbSharedObj.GetQuery(fConnection);
  try
    qry.SQL.Add('SELECT ScaleId, ScaleDescription, TT_Category');
    qry.SQL.Add('FROM tblTaxScales WHERE Active = "T"');
    qry.SQL.Add('AND RegionId = ' + IntToStr(AppEnv.RegionalOptions.Id));
    qry.SQL.Add('ORDER BY ScaleDescription');
    qry.Open;

    cboScale.Items.Clear;
    cboScale.Items.Add('(Default)' + #9 + '0');

    while not qry.Eof do begin
      cboScale.Items.Add(qry.FieldByName('ScaleDescription').AsString + #9 + qry.FieldByName('ScaleID').AsString);

      qry.Next;
    end;

    qry.Close;

    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tblchartofaccounts');
    { 2018-01-02 Added COGS accounts fo client Elgee Industries #7086 }
    qry.SQL.Add('WHERE ((AccountType = "EXP") or (AccountType = "COGS")) AND Active = "T"');
    qry.SQL.Add('ORDER BY AccountName');
    qry.Open;

    cboExpenseAccount.Items.Clear;
    cboExpenseAccount.Items.Add('(Default)' + #9 + '0');
    while not qry.Eof do begin
      cboExpenseAccount.Items.Add(qry.FieldByName('AccountName').AsString + #9 + qry.FieldByName('AccountID').AsString);
      qry.Next;
    end;
    qry.Close;

    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tblchartofaccounts');
    qry.SQL.Add('WHERE AccountType = "OCLIAB" AND Active = "T"');
    qry.SQL.Add('ORDER BY AccountName');
    qry.Open;

    cboLiabilityAccount.Items.Clear;
    cboLiabilityAccount.Items.Add('(Default)' + #9 + '0');
    while not qry.Eof do begin
      cboLiabilityAccount.Items.Add(qry.FieldByName('AccountName').AsString + #9 + qry.FieldByName('AccountID').AsString);
      qry.Next;
    end;
    qry.Close;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TfrPayTaxScaleConfigUSA.SetID(const Value: integer);
begin
  fID := Value;
  Load;
end;

end.
