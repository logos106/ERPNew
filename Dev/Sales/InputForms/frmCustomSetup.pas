unit frmCustomSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, BusObjPayTaxConfig, BusObjBase, DNMSpeedButton,
  Shader, DNMPanel, wwcheckbox, wwdblook, Wwdotdot, Wwdbcomb, Mask, wwdbedit,
  DBCtrls, ERPDbLookupCombo, Grids, Wwdbigrd, Wwdbgrid, fraCustomSetupEdit;

type
  TCustomSetup = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnSave: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    DBEdit1: TDBEdit;
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
    qryMain: TERPQuery;
    dsMain: TDataSource;
    qryMaincompany: TWideStringField;
    qryMainaccount1name: TWideStringField;
    cboAccounts: TERPDbLookupCombo;
    Panel1: TPanel;
    scbHeaders: TScrollBox;
    btnNewColumn: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnNewColumnClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    LoadingColumnList: boolean;
    fForms : array of TCustomSetupEdit;
    procedure LoadColumnList;
    procedure DeleteColumn(Sender: TObject);

  public
    { Public declarations }
  end;

implementation

uses
  BusObjConst, CommonLib, DNMExceptions, Appenvironment, FastFuncs, DataTreeObj,
  DataTreeBaseObj;


{$R *.dfm}

{ TfmPayTaxConfigEdit }

procedure TCustomSetup.FormCreate(Sender: TObject);
begin
  inherited;
  LoadingColumnList := False;
end;

procedure TCustomSetup.FormShow(Sender: TObject);
begin
  qryAccounts.Open;
  qryMain.Open;

  GuiPrefs.Active := True;
  GuiPrefs.LoadPrefs;

  LoadColumnList;
end;

procedure TCustomSetup.btnNewColumnClick(Sender: TObject);
var
  line: TCustomSetupEdit;
  count: Integer;
begin
  inherited;

  count := Length(fForms);
  SetLength(fForms, count + 1);

  line := TCustomSetupEdit.Create(self);
  line.Connection := TERPConnection(MyConnection);
  line.Name := 'CustomSetupEdit_' + IntToStr(scbHeaders.ControlCount);
  line.Top := count * (line.Height + 2) + 20;
  line.Left := 10;
  line.OnDblClick := DeleteColumn;
  line.ID := count;
  line.lblColumn.Caption := line.lblColumn.Caption + IntToStr(count + 1);
  line.edtHeader.Text := 'New Column';
  SetLength(line.Accounts, 0);
  line.Parent := scbHeaders;

  NamenPrintNameGridObj.AccountLookupQueryWithSearchengine(0, line.cboAccounts);

  fForms[count] := line;
end;

procedure TCustomSetup.btnSaveClick(Sender: TObject);
var
  I, K: Integer;
  line: TCustomSetupEdit;
  str, str2: string;
  count: Integer;
  node: TDataTreeNodeBase;
begin
  inherited;
  // Save the column data to GuiPrefs
  if GuiPrefs.Node.Exists('Headers') then begin
    node := GuiPrefs.Node['Headers'];
    node.Clear;
    node.NodeName := 'Headers';
  end
  else
    GuiPrefs.Node['cboAccounts'].Parent.AddNode('Headers');

  count := 0;
  for I := 0 to Length(fForms) - 1 do begin
    line := fForms[I];

    if line.edtHeader.Text <> '' then begin
      str := line.edtHeader.Text + ':';

      // Concate the account names;
      str2 := '';
      for K := 0 to Length(line.Accounts) - 1 do begin
        if K = Length(line.Accounts) - 1 then
          str2 := str2 + line.Accounts[K]
        else
          str2 := str2 + line.Accounts[K] + ';';
      end;

      if str2 <> '' then begin
        GuiPrefs.Node['Headers'].AddNode('Header');
        GuiPrefs.Node['Headers'].Items[count].AsString := str + str2;
        Inc(count);
      end;
    end;

  end;

  GuiPrefs.SavePrefs;
end;

procedure TCustomSetup.FormClose(Sender: TObject; var Action: TCloseAction);
var
  I: Integer;
begin
  inherited;

  for I := 0 to Length(fForms) - 1 do begin
    fForms[I].Free;
  end;

  Action := caFree;
end;

procedure TCustomSetup.LoadColumnList;
var
  I, K: Integer;
  HeaderString, HeaderLabel: string;
  AccountID: string;
  SL, SL2, SL3: TStringList;
  line: TCustomSetupEdit;
begin
  if LoadingColumnList then exit;
  LoadingColumnList := true;

  try
    // Remove the controls
    while scbHeaders.ControlCount > 0 do
      scbHeaders.Controls[0].Free;

    if not GuiPrefs.Node.Exists('Headers') then Exit;     

    SetLength(fForms, GuiPrefs.Node['Headers'].Count);
    for I := 0 to GuiPrefs.Node['Headers'].Count - 1 do begin
      HeaderString := GuiPrefs.Node['Headers'].Items[I].AsString;

      SL := TStringList.create;
      try
        Split(HeaderString, ':', SL);
        HeaderLabel := SL[0];

        AccountID := '';
        SL2 := nil;
        if SL.Count > 0 then begin
          SL2 := TStringList.create;
          SL3 := TStringList.create;
          try
            Split(SL[1], ';', SL2);
            Split(SL2[0], '@', SL3);
            AccountID := SL3[0];
          finally
//            FreeandNil(SL2);
            FreeandNil(SL3);
          end;
        end;
      finally
          FreeandNil(SL);
      end;

      line := TCustomSetupEdit.Create(self);
      line.Connection := TERPConnection(MyConnection);
      line.Name := 'CustomSetupEdit_' + IntToStr(scbHeaders.ControlCount);
      line.Top := I * (line.Height + 2) + 20;
      line.Left := 10;
      line.OnDblClick := DeleteColumn;
      line.ID := I;
      line.lblColumn.Caption := line.lblColumn.Caption + IntToStr(I + 1);
      line.edtHeader.Text := HeaderLabel;
      line.qryMain.Locate('AccountID', StrToInt(AccountID), []);
      if SL2 <> nil then begin
        SetLength(line.Accounts, SL2.Count);
        for K := 0 to SL2.Count - 1 do begin
          line.Accounts[K] := SL2[K];
        end;
        FreeandNil(SL2);
      end;
      line.Parent := scbHeaders;

      NamenPrintNameGridObj.AccountLookupQueryWithSearchengine(0, line.cboAccounts);

      fForms[I] := line;
    end;

  finally
    LoadingColumnList := false;
  end;
end;

procedure TCustomSetup.DeleteColumn(Sender: TObject);
var
  line: TCustomSetupEdit;
  I, K: Integer;
begin
  if MessageDlgXP_Vista('Are you sure to delete the column?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;

  line := TCustomSetupEdit(Sender);
  for I := 0 to Length(fForms) - 1 do begin
    if fForms[I].ID = line.ID then begin
      fForms[I].Free;
//      scbHeaders.Controls[I].Free;
      for K := I to Length(fForms) - 2 do
        fForms[K] := fForms[K + 1];
      Break;
    end;
  end;

  SetLength(fForms, Length(fForms) - 1);

end;

end.
