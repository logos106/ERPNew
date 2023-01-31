unit fraPayTaxScaleConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ERPDbComponents, AdvEdit, DBAdvEd, StdCtrls, Mask, wwdbedit,
  Wwdotdot, Wwdbcomb;

type
  TfrPayTaxScaleConfig = class(TFrame)
    lblTaxName: TLabel;
    cboScale: TwwDBComboBox;
    edtAllowanceQty: TDBAdvEdit;
    cboExpenseAccount: TwwDBComboBox;
    cboLiabilityAccount: TwwDBComboBox;
    cboCategory: TwwDBComboBox;
    Label1: TLabel;
    cboOption: TwwDBComboBox;
    cboSTSL: TwwDBComboBox;
    cboMLS: TwwDBComboBox;
    cboMLE: TwwDBComboBox;
    cboMLR: TwwDBComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    procedure cboScaleChange(Sender: TObject);
    procedure edtAllowanceQtyChange(Sender: TObject);
    procedure cboCategoryChange(Sender: TObject);
    procedure cboOptionChange(Sender: TObject);
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

procedure TfrPayTaxScaleConfig.cboCategoryChange(Sender: TObject);
begin
   inherited;

      cboOption.Items.Clear;
      cboOption.Items.Add('(Default)' + #9 + '');

      cboSTSL.Items.Clear;
      cboSTSL.Items.Add('(Default)' + #9 + '');

      cboMLS.Items.Clear;
      cboMLS.Items.Add('(Default)' + #9 + '');

      cboMLE.Items.Clear;
      cboMLE.Items.Add('(Default)' + #9 + '');

      cboMLR.Items.Clear;
      cboMLR.Items.Add('(Default)' + #9 + '');


   if cboCategory.Text = 'Regular' then
   begin
      cboOption.Items.Add('Daily casuals' + #9 + 'D');
      cboOption.Items.Add('No tax-free threshold' + #9 + 'N');
      cboOption.Items.Add('Tax-free threshold' + #9 + 'T');
      cboOption.ApplyList;

//      cboSTSL.Items.Clear;
      cboSTSL.Items.Add('Has STSL' + #9 + 'S');
      cboSTSL.Items.Add('No STSL' + #9 + 'X');
      cboSTSL.ApplyList;

//      cboMLS.Items.Clear;
      cboMLS.Items.Add('No surcharge' + #9 + 'X');
      cboMLS.Items.Add('Tier 1' + #9 + '1');
      cboMLS.Items.Add('Tier 2' + #9 + '2');
      cboMLS.Items.Add('Tier 3' + #9 + '3');
      cboMLS.ApplyList;

//      cboMLE.Items.Clear;
      cboMLE.Items.Add('Half' + #9 + 'H');
      cboMLE.Items.Add('Full' + #9 + 'F');
      cboMLE.Items.Add('No exemption' + #9 + 'X');
      cboMLE.ApplyList;

//      cboMLR.Items.Clear;
      cboMLR.Items.Add('1 dependant' + #9 + '1');
      cboMLR.Items.Add('2 dependants' + #9 + '2');
      cboMLR.Items.Add('3 dependants' + #9 + '3');
      cboMLR.Items.Add('4 dependants' + #9 + '4');
      cboMLR.Items.Add('5 dependants' + #9 + '5');
      cboMLR.Items.Add('6 dependants' + #9 + '6');
      cboMLR.Items.Add('7 dependants' + #9 + '7');
      cboMLR.Items.Add('8 dependants' + #9 + '8');
      cboMLR.Items.Add('9 dependants' + #9 + '9');
      cboMLR.Items.Add('10 or more dependants' + #9 + 'A');
      cboMLR.Items.Add('No reduction' + #9 + 'X');
      cboMLR.Items.Add('Spouse only' + #9 + '0');
      cboMLR.ApplyList;

   end
   else if cboCategory.Text = 'Actors' then
   begin
//      cboOption.Items.Clear;
      cboOption.Items.Add('3 or less performances per week' + #9 + 'D');
      cboOption.Items.Add('No tax-free threshold' + #9 + 'N');
      cboOption.Items.Add('Promotional' + #9 + 'P');
      cboOption.Items.Add('Tax-free threshold' + #9 + 'T');
      cboOption.ApplyList;

      cboSTSL.Items.Clear;
      cboSTSL.Items.Add('No STSL' + #9 + 'X');
      cboSTSL.ApplyList;
 //     cboSTSL.Text := 'No STSL';

      cboMLS.Items.Clear;
      cboMLS.Items.Add('No surcharge' + #9 + 'X');
      cboMLS.ApplyList;

      cboMLE.Items.Clear;
      cboMLE.Items.Add('No exemption' + #9 + 'X');
      cboMLE.ApplyList;

      cboMLR.Items.Clear;
      cboMLR.Items.Add('No reduction' + #9 + 'X');
      cboMLR.ApplyList;


   end
   else if cboCategory.Text = 'Horticulturalists and Shearers' then
   begin
//      cboOption.Items.Clear;
      cboOption.Items.Add('Foreign resident' + #9 + 'F');
      cboOption.Items.Add('Tax-free threshold' + #9 + 'T');
      cboOption.ApplyList;

      cboSTSL.Items.Clear;
      cboSTSL.Items.Add('No STSL' + #9 + 'X');
      cboSTSL.ApplyList;

      cboMLS.Items.Clear;
      cboMLS.Items.Add('No surcharge' + #9 + 'X');
      cboMLS.ApplyList;

      cboMLE.Items.Clear;
      cboMLE.Items.Add('No exemption' + #9 + 'X');
      cboMLE.ApplyList;

      cboMLR.Items.Clear;
      cboMLR.Items.Add('No reduction' + #9 + 'X');
      cboMLR.ApplyList;


   end
   else if cboCategory.Text = 'Seniors and Pensioners' then
   begin
//      cboOption.Items.Clear;
      cboOption.Items.Add('Illness separated' + #9 + 'I');
      cboOption.Items.Add('Member of a couple' + #9 + 'M');
      cboOption.Items.Add('Single' + #9 + 'S');
      cboOption.ApplyList;

//      cboSTSL.Items.Clear;
      cboSTSL.Items.Add('Has STSL' + #9 + 'S');
      cboSTSL.Items.Add('No STSL' + #9 + 'X');
      cboSTSL.ApplyList;

//      cboMLS.Items.Clear;
      cboMLS.Items.Add('No surcharge' + #9 + 'X');
      cboMLS.Items.Add('Tier 1' + #9 + '1');
      cboMLS.Items.Add('Tier 2' + #9 + '2');
      cboMLS.Items.Add('Tier 3' + #9 + '3');
      cboMLS.ApplyList;

//      cboMLE.Items.Clear;
      cboMLE.Items.Add('Half' + #9 + 'H');
      cboMLE.Items.Add('Full' + #9 + 'F');
      cboMLE.Items.Add('No exemption' + #9 + 'X');
      cboMLE.ApplyList;

//      cboMLR.Items.Clear;
      cboMLR.Items.Add('1 dependant' + #9 + '1');
      cboMLR.Items.Add('2 dependants' + #9 + '2');
      cboMLR.Items.Add('3 dependants' + #9 + '3');
      cboMLR.Items.Add('4 dependants' + #9 + '4');
      cboMLR.Items.Add('5 dependants' + #9 + '5');
      cboMLR.Items.Add('6 dependants' + #9 + '6');
      cboMLR.Items.Add('7 dependants' + #9 + '7');
      cboMLR.Items.Add('8 dependants' + #9 + '8');
      cboMLR.Items.Add('9 dependants' + #9 + '9');
      cboMLR.Items.Add('10 or more dependants' + #9 + 'A');
      cboMLR.Items.Add('No reduction' + #9 + 'X');
      cboMLR.Items.Add('Spouse only' + #9 + '0');
      cboMLR.ApplyList;


   end
   else if cboCategory.Text = 'Working Holiday Makers' then
   begin
//      cboOption.Items.Clear;
      cboOption.Items.Add('No TFN - foreign resident' + #9 + 'F');
      cboOption.Items.Add('Registered employer' + #9 + 'R');
      cboOption.Items.Add('Unregistered employer' + #9 + 'U');
      cboOption.ApplyList;

      cboSTSL.Items.Clear;
      cboSTSL.Items.Add('No STSL' + #9 + 'X');
      cboSTSL.ApplyList;

      cboMLS.Items.Clear;
      cboMLS.Items.Add('No surcharge' + #9 + 'X');
      cboMLS.ApplyList;

      cboMLE.Items.Clear;
      cboMLE.Items.Add('No exemption' + #9 + 'X');
      cboMLE.ApplyList;

      cboMLR.Items.Clear;
      cboMLR.Items.Add('No reduction' + #9 + 'X');
      cboMLR.ApplyList;


   end
   else if cboCategory.Text = 'Seasonal Worker Programme' then
   begin
      cboOption.Items.Clear;
      cboOption.Items.Add('Seasonal Worker Programme' + #9 + 'P');
      cboOption.ApplyList;

      cboSTSL.Items.Clear;
      cboSTSL.Items.Add('No STSL' + #9 + 'X');
      cboSTSL.ApplyList;

      cboMLS.Items.Clear;
      cboMLS.Items.Add('No surcharge' + #9 + 'X');
      cboMLS.ApplyList;

      cboMLE.Items.Clear;
      cboMLE.Items.Add('No exemption' + #9 + 'X');
      cboMLE.ApplyList;

      cboMLR.Items.Clear;
      cboMLR.Items.Add('No reduction' + #9 + 'X');
      cboMLR.ApplyList;


   end
   else if cboCategory.Text = 'Foreign Resident' then
   begin
      cboOption.Items.Clear;
      cboOption.Items.Add('Foreign resident' + #9 + 'F');
      cboOption.ApplyList;

//      cboSTSL.Items.Clear;
      cboSTSL.Items.Add('Has STSL' + #9 + 'S');
      cboSTSL.Items.Add('No STSL' + #9 + 'X');
      cboSTSL.ApplyList;

      cboMLS.Items.Clear;
      cboMLS.Items.Add('No surcharge' + #9 + 'X');
      cboMLS.ApplyList;

      cboMLE.Items.Clear;
      cboMLE.Items.Add('No exemption' + #9 + 'X');
      cboMLE.ApplyList;

      cboMLR.Items.Clear;
      cboMLR.Items.Add('No reduction' + #9 + 'X');
      cboMLR.ApplyList;


   end
   else if cboCategory.Text = 'No TFN' then
   begin
//      cboOption.Items.Clear;
      cboOption.Items.Add('Australian resident' + #9 + 'A');
      cboOption.Items.Add('Foreign resident' + #9 + 'F');
      cboOption.ApplyList;

      cboSTSL.Items.Clear;
      cboSTSL.Items.Add('No STSL' + #9 + 'X');
      cboSTSL.ApplyList;

      cboMLS.Items.Clear;
      cboMLS.Items.Add('No surcharge' + #9 + 'X');
      cboMLS.ApplyList;

      cboMLE.Items.Clear;
      cboMLE.Items.Add('No exemption' + #9 + 'X');
      cboMLE.ApplyList;

      cboMLR.Items.Clear;
      cboMLR.Items.Add('No reduction' + #9 + 'X');
      cboMLR.ApplyList;


   end
   else if cboCategory.Text = 'ATO-Defined' then
   begin
//      cboOption.Items.Clear;
      cboOption.Items.Add('Death beneficiaries' + #9 + 'B');
      cboOption.Items.Add('Downwards variation' + #9 + 'V');
      cboOption.Items.Add('Non-employee' + #9 + 'Z');
      cboOption.ApplyList;

      cboSTSL.Items.Clear;
      cboSTSL.Items.Add('No STSL' + #9 + 'X');
      cboSTSL.ApplyList;

      cboMLS.Items.Clear;
      cboMLS.Items.Add('No surcharge' + #9 + 'X');
      cboMLS.ApplyList;

      cboMLE.Items.Clear;
      cboMLE.Items.Add('No exemption' + #9 + 'X');
      cboMLE.ApplyList;

      cboMLR.Items.Clear;
      cboMLR.Items.Add('No reduction' + #9 + 'X');
      cboMLR.ApplyList;


   end
   else if cboCategory.Text = 'Voluntary Agreement' then
   begin
//      cboOption.Items.Clear;
      cboOption.Items.Add('Commissioner’s instalment Rate' + #9 + 'C');
      cboOption.Items.Add('No Commissioner’s Instalment Rate' + #9 + 'O');
      cboOption.ApplyList;

      cboSTSL.Items.Clear;
      cboSTSL.Items.Add('No STSL' + #9 + 'X');
      cboSTSL.ApplyList;

      cboMLS.Items.Clear;
      cboMLS.Items.Add('No surcharge' + #9 + 'X');
      cboMLS.ApplyList;

      cboMLE.Items.Clear;
      cboMLE.Items.Add('No exemption' + #9 + 'X');
      cboMLE.ApplyList;

      cboMLR.Items.Clear;
      cboMLR.Items.Add('No reduction' + #9 + 'X');
      cboMLR.ApplyList;

   end;

   cboOption.ItemIndex := 0;
   cboSTSL.ItemIndex := 0;
   cboMLS.ItemIndex := 0;
   cboMLE.ItemIndex := 0;
   cboMLR.ItemIndex := 0;


   cboScaleChange(Sender);

end;



procedure TfrPayTaxScaleConfig.cboOptionChange(Sender: TObject);
begin
   inherited;

   if cboOption.Text = 'Daily casuals' then
   begin

      cboSTSL.Items.Clear;
      cboSTSL.Items.Add('No STSL' + #9 + 'X');
      cboSTSL.ApplyList;

      cboMLS.Items.Clear;
      cboMLS.Items.Add('No surcharge' + #9 + 'X');
      cboMLS.ApplyList;

      cboMLE.Items.Clear;
      cboMLE.Items.Add('No exemption' + #9 + 'X');
      cboMLE.ApplyList;

      cboMLR.Items.Clear;
      cboMLR.Items.Add('No reduction' + #9 + 'X');
      cboMLR.ApplyList;

   end;

   cboSTSL.ItemIndex := 0;
   cboMLS.ItemIndex := 0;
   cboMLE.ItemIndex := 0;
   cboMLR.ItemIndex := 0;


   cboScaleChange(Sender);

end;




procedure TfrPayTaxScaleConfig.cboScaleChange(Sender: TObject);
var
  qry : TERPQuery;

begin

  if Loading then Exit;


  qry := DbSharedObj.GetQuery(fConnection);
  try
      qry.SQL.Clear;

      qry.SQL.Add('Select * FROM tbltaxscales WHERE ScaleID = ' + cboScale.Value);

    qry.Open;


    cboCategory.Value := qry.FieldByName('TT_Category').AsString;

    cboOption.Value := qry.FieldByName('TT_Option').AsString;
    cboSTSL.Value := qry.FieldByName('TT_STSL').AsString;
    cboMLS.Value := qry.FieldByName('TT_MLS').AsString;
    cboMLE.Value := qry.FieldByName('TT_MLE').AsString;
    cboMLR.Value := qry.FieldByName('TT_MLR').AsString;

  finally
    DbSharedObj.ReleaseObj(qry);
    Loading := false;
  end;



  if not Loading then
    Save;
end;


constructor TfrPayTaxScaleConfig.Create(AOwner: TComponent);
begin
  inherited;
  Loading := false;
end;

procedure TfrPayTaxScaleConfig.edtAllowanceQtyChange(Sender: TObject);
begin
  if not Loading then
    Save;
end;

procedure TfrPayTaxScaleConfig.Load;
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

    cboCategory.Value := qry.FieldByName('TT_Category').AsString;

    cboOption.Value := qry.FieldByName('TT_Option').AsString;
    cboSTSL.Value := qry.FieldByName('TT_STSL').AsString;
    cboMLS.Value := qry.FieldByName('TT_MLS').AsString;
    cboMLE.Value := qry.FieldByName('TT_MLE').AsString;
    cboMLR.Value := qry.FieldByName('TT_MLR').AsString;


    cboExpenseAccount.Value := IntToStr(qry.FieldByName('ExpenseAccountId').AsInteger);
    cboLIabilityAccount.Value := IntToStr(qry.FieldByName('LiabilityAccountId').AsInteger);
    edtAllowanceQty.IntValue := qry.FieldByName('AllowanceQty').AsInteger;
  finally
    DbSharedObj.ReleaseObj(qry);
    Loading := false;
  end;
end;



procedure TfrPayTaxScaleConfig.Save;
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

    cmd.SQL.Add(', TT_Category = "' + cboCategory.Value);
    cmd.SQL.Add('", TT_Option = "' + cboOption.Value);
    cmd.SQL.Add('", TT_STSL = "' + cboSTSL.Value);
    cmd.SQL.Add('", TT_MLS = "' + cboMLS.Value);
    cmd.SQL.Add('", TT_MLE = "' + cboMLE.Value);
    cmd.SQL.Add('", TT_MLR = "' + cboMLR.Value);

    cmd.SQL.Add('" WHERE ID = ' + IntToStr(ID));

    cmd.Execute;

  finally
    DbSharedObj.ReleaseObj(cmd);
  end;
end;


procedure TfrPayTaxScaleConfig.SetConnection(const Value: TERPConnection);
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

procedure TfrPayTaxScaleConfig.SetID(const Value: integer);
begin
  fID := Value;
  Load;
end;

end.
