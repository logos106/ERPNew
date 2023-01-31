unit fraCustomSetupEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, wwdbedit, Wwdotdot, Wwdbcomb, ExtCtrls, DNMPanel,
  ERPDbComponents, wwcheckbox, AdvEdit, DBAdvEd, DB, MemDS, DBAccess, MyAccess,
  wwdblook, tcDataUtils, ERPDbLookupCombo, Grids, Wwdbgrid, Wwdbigrd;

type
  TCustomSetupEdit = class(TFrame)
    pnlMain: TDNMPanel;
    lblColumn: TLabel;
    Bevel1: TBevel;
    lblLiability: TLabel;
    edtHeader: TEdit;
    cboAccounts: TERPDbLookupCombo;
    qryAccounts: TERPQuery;
    qryAccountsAccountTree: TWideStringField;
    qryAccountsFullAccountName: TWideStringField;
    qryAccountsAccountName: TWideStringField;
    qryAccountsAccountID: TIntegerField;
    qryAccountsAccountNumber: TWideStringField;
    qryAccountsAccountGroup: TWideStringField;
    qryAccountsType: TWideStringField;
    qryAccountsDescription: TWideStringField;
    qryAccountsTaxcode: TWideStringField;
    qryAccountsActive: TWideStringField;
    dsMain: TDataSource;
    qryMain: TERPQuery;
    lblDelete: TLabel;
    qryMainaccountid: TIntegerField;
    qryMainaccountname: TWideStringField;
    procedure lblColumnDblClick(Sender: TObject);
    procedure cboAccountsDoGridDataSelect(Sender: TObject);
    procedure lblDeleteDblClick(Sender: TObject);
    procedure cboAccountsChange(Sender: TObject);
  private
    fId: integer;
    fConnection: TERPConnection;
    Loading: boolean;

    function GetID: integer;
    procedure SetID(const Value: integer);
    procedure SetConnection(const Value: TERPConnection);
    { Private declarations }
  public
    Accounts : array of string;

    constructor Create(AOwner: TComponent); override;
    property ID: integer read GetID write SetID;
    property Connection: TERPConnection read fConnection write SetConnection;
    procedure Load;
    procedure Save;
  end;

implementation

uses
  DbSharedObjectsObj, PreferancesLib, LookupcomboLib;

{$R *.dfm}

{ TfrPayTaxConfigEdit }

constructor TCustomSetupEdit.Create(AOwner: TComponent);
begin
  inherited;
  Loading := false;
end;

procedure TCustomSetupEdit.cboAccountsChange(Sender: TObject);
begin
  SetLength(Accounts, 1);
  Accounts[0] := IntToStr(qryAccounts.FieldByName('AccountID').AsInteger) + '@' + qryAccounts.FieldByName('AccountName').AsString;
end;

procedure TCustomSetupEdit.cboAccountsDoGridDataSelect(Sender: TObject);
var
  str: string;
  id: Integer;
  acct: string;
  grid: TwwDBGrid;
  count: Integer;
begin
  inherited;

  count := 0;
  if sender is TwwDBGrid then begin
    if TwwDBGrid(Sender).DataSource.DataSet.RecordCount < Length(Accounts) then Exit;
    while not TwwDBGrid(Sender).DataSource.DataSet.EOF do begin
      id := TwwDBGrid(Sender).DataSource.DataSet.FieldByName('AccountID').AsInteger;
      acct := TwwDBGrid(Sender).DataSource.DataSet.FieldByName('AccountName').AsString;
      str := IntToStr(id) + '@' + acct;

      Inc(count);
      SetLength(Accounts, count);
      Accounts[count] := str;

      TwwDBGrid(Sender).DataSource.DataSet.Next;
    end;
  end;
end;

function TCustomSetupEdit.GetID: integer;
begin
  result := fId;
end;

procedure TCustomSetupEdit.SetID(const Value: integer);
begin
  fId := Value;
  Load;
end;

procedure TCustomSetupEdit.lblColumnDblClick(Sender: TObject);
begin
  self.OnDblClick(self);
end;

procedure TCustomSetupEdit.lblDeleteDblClick(Sender: TObject);
begin
  self.OnDblClick(self);
end;

procedure TCustomSetupEdit.Load;
var
  qry: TERPQuery;
begin
  if Loading then exit;

end;

procedure TCustomSetupEdit.Save;
var
  cmd: TERPCommand;
begin
  if Id = 0 then exit;
  if not Assigned(fConnection) then exit;
  cmd := DbSharedObj.GetCommand(fConnection);

end;

procedure TCustomSetupEdit.SetConnection(const Value: TERPConnection);
begin
  fConnection := Value;

  if qryMain.Active then qryMain.Close;
  qryMain.Connection := value;
  qryMain.Open;

  if qryAccounts.Active then qryAccounts.Close;
  qryAccounts.Connection := value;
  qryAccounts.Open;
end;

end.
