unit EmployeeAccountsFrm;

interface
{$I ERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, Menus, ExtCtrls, StdCtrls, wwdblook, DNMPanel, DB, MemDS,
  DBAccess, MyAccess, ERPdbComponents;

type
  TEmpAccounts = class(TfrmBaseGUI)
    pnlMain: TDNMPanel;
    DNMPanel5: TDNMPanel;
    Bevel5: TBevel;
    Label65: TLabel;
    Label35: TLabel;
    Label34: TLabel;
    cboWages: TwwDBLookupCombo;
    DNMPanel6: TDNMPanel;
    Bevel6: TBevel;
    Label37: TLabel;
    Label39: TLabel;
    Label41: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label62: TLabel;
    Label123: TLabel;
    Label122: TLabel;
    Label133: TLabel;
    cboGrossWages: TwwDBLookupCombo;
    cboLeavePaidAccount: TwwDBLookupCombo;
    cboSuperPaidAccount: TwwDBLookupCombo;
    cboDeductionAccount: TwwDBLookupCombo;
    cboSundriesAccount: TwwDBLookupCombo;
    cboAllowanceAccount: TwwDBLookupCombo;
    cboNetWages: TwwDBLookupCombo;
    cboPAYGExpence: TwwDBLookupCombo;
    cboCommissionAccount: TwwDBLookupCombo;
    DNMPanel7: TDNMPanel;
    Bevel7: TBevel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label111: TLabel;
    wwDBLookupCombo7: TwwDBLookupCombo;
    wwDBLookupCombo8: TwwDBLookupCombo;
    wwDBLookupCombo9: TwwDBLookupCombo;
    wwDBLookupCombo10: TwwDBLookupCombo;
    wwDBLookupCombo14: TwwDBLookupCombo;
    qryAccount: TERPQuery;
    dsPersonalPreferences: TDataSource;
    cboLumpSumDPaidAccountID: TwwDBLookupCombo;
    Label68: TLabel;
    pnlAccounts: TDNMPanel;
    Label1: TLabel;
    wwDBLookupCombo1: TwwDBLookupCombo;
    Label2: TLabel;
    Bevel1: TBevel;
    Label3: TLabel;
    wwDBLookupCombo2: TwwDBLookupCombo;
    wwDBLookupCombo3: TwwDBLookupCombo;
    Label4: TLabel;
    Label5: TLabel;
    wwDBLookupCombo4: TwwDBLookupCombo;
    Label6: TLabel;
    wwDBLookupCombo5: TwwDBLookupCombo;
    Label7: TLabel;
    wwDBLookupCombo6: TwwDBLookupCombo;
    Label69: TLabel;
    Label70: TLabel;
    Label8: TLabel;
    wwDBLookupCombo11: TwwDBLookupCombo;
    wwDBLookupCombo12: TwwDBLookupCombo;
    Label9: TLabel;
    wwDBLookupCombo13: TwwDBLookupCombo;
    wwDBLookupCombo15: TwwDBLookupCombo;
    Label10: TLabel;
    wwDBLookupCombo16: TwwDBLookupCombo;
    wwDBLookupCombo17: TwwDBLookupCombo;
    Label11: TLabel;
    wwDBLookupCombo18: TwwDBLookupCombo;
    wwDBLookupCombo19: TwwDBLookupCombo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EmpAccounts: TEmpAccounts;

implementation

{$R *.dfm}

uses
  CommonDbLib;

procedure TEmpAccounts.FormCreate(Sender: TObject);
begin
  inherited;
  {$IFDEF PayTax}
  pnlMain.Visible := false;
  pnlAccounts.Visible := true;
  {$ELSE}
  pnlMain.Visible := true;
  pnlAccounts.Visible := false;
  {$ENDIF}
  qryAccount.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryAccount.Open;
end;

initialization

  RegisterClass(TEmpAccounts);

end.
