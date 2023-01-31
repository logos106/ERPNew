unit EmployeeAccountsUSFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, Menus, ExtCtrls, StdCtrls, DB, MemDS, DBAccess,
  MyAccess, ERPdbComponents, DNMPanel, wwdblook;

type
  TEmpAccountsUS = class(TBaseForm)
    pnlMain: TDNMPanel;
    qryAccount: TERPQuery;
    dsPersonalPreferences: TDataSource;
    ScrollBox1: TScrollBox;
    DNMPanel5: TDNMPanel;
    Bevel5: TBevel;
    Label65: TLabel;
    Label35: TLabel;
    Label34: TLabel;
    cboWages: TwwDBLookupCombo;
    pnlExpenseAccounts: TDNMPanel;
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
    Label23: TLabel;
    Label68: TLabel;
    cboGrossWages: TwwDBLookupCombo;
    cboLeavePaidAccount: TwwDBLookupCombo;
    cboSocialSecurityPaidAccount: TwwDBLookupCombo;
    cboDeductionAccount: TwwDBLookupCombo;
    cboSundriesAccount: TwwDBLookupCombo;
    cboAllowanceAccount: TwwDBLookupCombo;
    cboNetWages: TwwDBLookupCombo;
    cboFedWithholdingExpence: TwwDBLookupCombo;
    cboCommissionAccount: TwwDBLookupCombo;
    cboStateWithholdingExpenses: TwwDBLookupCombo;
    cboMedicarePaid: TwwDBLookupCombo;
    pnlLiabilityAccounts: TDNMPanel;
    Bevel7: TBevel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label111: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    cboDeductionsLiability: TwwDBLookupCombo;
    cboLeaveLiability: TwwDBLookupCombo;
    cboStateWithholdingTaxPayable: TwwDBLookupCombo;
    cboFedWithholdingTaxPayable: TwwDBLookupCombo;
    cboAllowancesLiability: TwwDBLookupCombo;
    cboSocialSecurityPayable: TwwDBLookupCombo;
    cboMedicarePayable: TwwDBLookupCombo;
    Label1: TLabel;
    cboSocialSecurityPaidCompanyAccount: TwwDBLookupCombo;
    Label2: TLabel;
    cboMedicarePaidCompany: TwwDBLookupCombo;
    Label3: TLabel;
    cboSocialSecurityPayableCompany: TwwDBLookupCombo;
    Label4: TLabel;
    cboMedicarePayableCompany: TwwDBLookupCombo;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EmpAccountsUS: TEmpAccountsUS;

implementation

{$R *.dfm}

uses
  CommonDbLib;

procedure TEmpAccountsUS.FormCreate(Sender: TObject);
begin
  inherited;
  qryAccount.Connection := CommonDbLib.GetSharedMyDacConnection;
  qryAccount.Open;
end;

initialization
  RegisterClass(TEmpAccountsUS);

end.
