unit PayrollPrefsUS;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 08/08/06  1.00.01 DSP  First version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MessageConst, DB, DataSourcePrefs, DBAccess, MyAccess,ERPdbComponents, StdCtrls,
  MemDS, wwcheckbox, ExtCtrls, DNMPanel, wwdbdatetimepicker, Mask,
  wwdbedit, Wwdotdot, Wwdbcomb, DNMSpeedButton, wwdblook, frmBase, BasePrefs,
  AdvEdit, DBAdvEd, Menus;

type
  TPayrollPrefsUSGUI = class(TBasePrefsGUI)
    lblWidth: TLabel;
    dsPrefs: TDataSourcePrefs;
    pnlLeaveAccrual: TDNMPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    wwCheckBox1: TwwCheckBox;
    wwCheckBox2: TwwCheckBox;
    wwCheckBox3: TwwCheckBox;
    wwCheckBox6: TwwCheckBox;
    wwCheckBox4: TwwCheckBox;
    Label8: TLabel;
    wwCheckBox5: TwwCheckBox;
    wwCheckBox7: TwwCheckBox;
    wwCheckBox8: TwwCheckBox;
    pnlLoadFromRoster: TDNMPanel;
    Bevel3: TBevel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    wwCheckBox12: TwwCheckBox;
    wwCheckBox14: TwwCheckBox;
    wwCheckBox15: TwwCheckBox;
    pnlGeneral: TDNMPanel;
    Bevel4: TBevel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    edtHoursPerWeek: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    wwDBEdit3: TwwDBEdit;
    wwDBEdit4: TwwDBEdit;
    wwDBEdit5: TwwDBEdit;
    Label27: TLabel;
    wwDBEdit6: TwwDBEdit;
    wwCheckBox16: TwwCheckBox;
    Label32: TLabel;
    wwCheckBox17: TwwCheckBox;
    Label33: TLabel;
    btnImportTaxScales: TDNMSpeedButton;
    dsPersonalPreferences: TDataSource;
    qryPersonalPreferences: TERPQuery;
    MyConnection: TERPConnection;
    DNMPanel5: TDNMPanel;
    Bevel5: TBevel;
    Label65: TLabel;
    Label35: TLabel;
    cboWages: TwwDBLookupCombo;
    qryAccount: TERPQuery;
    pnlExpenseAccounts: TDNMPanel;
    Bevel6: TBevel;
    Label37: TLabel;
    Label39: TLabel;
    cboGrossWages: TwwDBLookupCombo;
    Label41: TLabel;
    cboLeavePaidAccount: TwwDBLookupCombo;
    Label46: TLabel;
    cboSocialSecurityPaidAccount: TwwDBLookupCombo;
    Label47: TLabel;
    cboDeductionAccount: TwwDBLookupCombo;
    Label48: TLabel;
    cboSundriesAccount: TwwDBLookupCombo;
    pnlLiabilityAccounts: TDNMPanel;
    Bevel7: TBevel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    cboDeductionsLiability: TwwDBLookupCombo;
    cboLeaveLiability: TwwDBLookupCombo;
    cboStateWithholdingTaxPayable: TwwDBLookupCombo;
    cboFedWithholdingTaxPayable: TwwDBLookupCombo;
    pnlSuper: TDNMPanel;
    Bevel8: TBevel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    wwCheckBox22: TwwCheckBox;
    wwCheckBox23: TwwCheckBox;
    wwCheckBox24: TwwCheckBox;
    wwCheckBox25: TwwCheckBox;
    wwCheckBox26: TwwCheckBox;
    Label60: TLabel;
    wwDBEdit18: TwwDBEdit;
    Label61: TLabel;
    wwDBEdit19: TwwDBEdit;
    wwCheckBox19: TwwCheckBox;
    Label63: TLabel;
    wwCheckBox20: TwwCheckBox;
    Label64: TLabel;
    Label66: TLabel;
    wwDBEdit21: TwwDBEdit;
    lblIgnore8: TLabel;
    Bevel9: TBevel;
    Bevel10: TBevel;
    Bevel11: TBevel;
    wwCheckBox21: TwwCheckBox;
    Label67: TLabel;
    cboAllowanceAccount: TwwDBLookupCombo;
    Label62: TLabel;
    Label111: TLabel;
    cboAllowancesLiability: TwwDBLookupCombo;
    Label113: TLabel;
    wwCheckBox27: TwwCheckBox;
    Bevel20: TBevel;
    Label114: TLabel;
    Bevel21: TBevel;
    Bevel22: TBevel;
    Label115: TLabel;
    wwCheckBox28: TwwCheckBox;
    Label116: TLabel;
    Label117: TLabel;
    wwCheckBox29: TwwCheckBox;
    wwCheckBox30: TwwCheckBox;
    Label118: TLabel;
    Label34: TLabel;
    Label123: TLabel;
    Label122: TLabel;
    cboNetWages: TwwDBLookupCombo;
    cboFedWithholdingExpence: TwwDBLookupCombo;
    Panel1: TPanel;
    Label124: TLabel;
    Label125: TLabel;
    Label126: TLabel;
    Label127: TLabel;
    Label128: TLabel;
    Label129: TLabel;
    Label130: TLabel;
    Label131: TLabel;
    Label132: TLabel;
    Label133: TLabel;
    cboCommissionAccount: TwwDBLookupCombo;
    pnlJobs: TDNMPanel;
    Bevel2: TBevel;
    Label9: TLabel;
    wwCheckBox9: TwwCheckBox;
    Label10: TLabel;
    wwCheckBox10: TwwCheckBox;
    Label11: TLabel;
    wwCheckBox11: TwwCheckBox;
    Label12: TLabel;
    wwCheckBox13: TwwCheckBox;
    Label14: TLabel;
    Label21: TLabel;
    cboSocialSecurityPayable: TwwDBLookupCombo;
    Label22: TLabel;
    cboMedicarePayable: TwwDBLookupCombo;
    Label23: TLabel;
    cboStateWithholdingExpenses: TwwDBLookupCombo;
    Label68: TLabel;
    cboMedicarePaid: TwwDBLookupCombo;
    DNMPanel1: TDNMPanel;
    Label28: TLabel;
    wwDBEdit7: TwwDBEdit;
    lblIgnore1: TLabel;
    Label29: TLabel;
    wwDBEdit8: TwwDBEdit;
    lblIgnore2: TLabel;
    Label30: TLabel;
    wwDBEdit9: TwwDBEdit;
    lblIgnore3: TLabel;
    Label31: TLabel;
    wwDBEdit10: TwwDBEdit;
    lblIgnore4: TLabel;
    Label36: TLabel;
    wwDBEdit11: TwwDBEdit;
    lblIgnore5: TLabel;
    Label38: TLabel;
    wwDBEdit12: TwwDBEdit;
    lblIgnore6: TLabel;
    Label40: TLabel;
    wwDBEdit13: TwwDBEdit;
    lblIgnore7: TLabel;
    Label42: TLabel;
    wwDBEdit14: TwwDBEdit;
    Label43: TLabel;
    wwDBEdit15: TwwDBEdit;
    Label45: TLabel;
    wwDBEdit17: TwwDBEdit;
    Label112: TLabel;
    wwDBEdit20: TwwDBEdit;
    Label120: TLabel;
    Label119: TLabel;
    wwDBEdit46: TwwDBEdit;
    Label44: TLabel;
    wwDBEdit16: TwwDBEdit;
    Label121: TLabel;
    wwDBEdit47: TwwDBEdit;
    Label69: TLabel;
    edtPayAllowanceAmount: TDBAdvEdit;
    pnlTaxRounding: TDNMPanel;
    Label70: TLabel;
    Bevel12: TBevel;
    chkUSRoundFedTax: TwwCheckBox;
    Label71: TLabel;
    chkUSRoundStateTax: TwwCheckBox;
    Label72: TLabel;
    chkUSRoundSocialSecurityTax: TwwCheckBox;
    Label73: TLabel;
    chkUSRoundMedicareTax: TwwCheckBox;
    Label74: TLabel;
    Label75: TLabel;
    cboSocialSecurityCompanyPayable: TwwDBLookupCombo;
    Label76: TLabel;
    cboMedicarePayableCompany: TwwDBLookupCombo;
    Label77: TLabel;
    cboSocialSecurityPaidCompanyAccount: TwwDBLookupCombo;
    Label78: TLabel;
    cboMedicarePaidCompany: TwwDBLookupCombo;
    Bevel13: TBevel;
    Label79: TLabel;
    Bevel14: TBevel;
    Label80: TLabel;
    Bevel15: TBevel;
    Label81: TLabel;
    edtUSStateTaxLabel: TDBAdvEdit;
    Label82: TLabel;
    edtUSPayAllowanceStateAmount: TDBAdvEdit;
    Label83: TLabel;
    DBAdvEdit1: TDBAdvEdit;
    procedure btnImportTaxScalesClick(Sender: TObject);
  private
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure PerformFinish(var Msg: TMessage); message TX_PerformFinish;
    procedure CheckPayrollAccounts;
  public
    { Public declarations }
  end;

implementation

uses
  CommonLib,  CommonDbLib, tcDataUtils, AppEnvironment;

{$R *.dfm}

{ TPayrollPrefsGUI }

procedure TPayrollPrefsUSGUI.PerformStartup(var Msg: TMessage);
begin
  SetupPersonalPreferences(qryPersonalPreferences, AppEnv.Employee.EmployeeID);
  CheckPayrollAccounts;
end;

procedure TPayrollPrefsUSGUI.PerformFinish(var Msg: TMessage);
begin
 if qryPersonalPreferences.State in [dsEdit, dsInsert] then
   qryPersonalPreferences.Post;
end;

procedure TPayrollPrefsUSGUI.btnImportTaxScalesClick(Sender: TObject);
var
  tmpComponent: TComponent;
begin
  inherited;
  tmpComponent := GetComponentByClassName('TfrmImportTaxScalesGUI');

  if not Assigned(tmpComponent) then
    Exit;

  with TForm(tmpComponent) do begin
    ShowModal;
  end;
end;

procedure TPayrollPrefsUSGUI.CheckPayrollAccounts;
begin
  dsPrefs.DataSet.Edit;
  if dsPrefs.DataSet.findfield('RBLThreshold')          <> nil then TFloatField(dsPrefs.DataSet.findfield('RBLThreshold')).currency          := True;
  if dsPrefs.DataSet.findfield('LumpDBaseTaxFree')      <> nil then TFloatField(dsPrefs.DataSet.findfield('LumpDBaseTaxFree')).currency      := True;
  if dsPrefs.DataSet.findfield('LumpDYearlyTaxFree')    <> nil then TFloatField(dsPrefs.DataSet.findfield('LumpDYearlyTaxFree')).currency    := True;
  if dsPrefs.DataSet.findfield('YearlyIncomeThreshold') <> nil then TFloatField(dsPrefs.DataSet.findfield('YearlyIncomeThreshold')).currency := True;
  if dsPrefs.DataSet.findfield('SuperOverGross')        <> nil then TFloatField(dsPrefs.DataSet.findfield('SuperOverGross')).currency        := True;

  if dsPrefs.DataSet.FieldByName('WageAccountID').AsInteger = 0 then begin
    dsPrefs.DataSet.Edit;
    dsPrefs.DataSet.FieldByName('WageAccountID').AsInteger := GetAccountID('Payroll Bank');
    dsPrefs.DataSet.Post;
  end;

  if dsPrefs.DataSet.FieldByName('DeductionLiabilityAccountID').AsInteger = 0 then begin
    dsPrefs.DataSet.Edit;
    dsPrefs.DataSet.FieldByName('DeductionLiabilityAccountID').AsInteger := GetAccountID('Deductions');
    dsPrefs.DataSet.Post;
  end;

  if dsPrefs.DataSet.FieldByName('LeaveLiabilityAccountID').AsInteger = 0 then begin
    dsPrefs.DataSet.Edit;
    dsPrefs.DataSet.FieldByName('LeaveLiabilityAccountID').AsInteger := GetAccountID('Leave Liability');
    dsPrefs.DataSet.Post;
  end;

  if dsPrefs.DataSet.FieldByName('SuperPaidAccountID').AsInteger = 0 then begin
    dsPrefs.DataSet.Edit;
    dsPrefs.DataSet.FieldByName('SuperPaidAccountID').AsInteger := GetAccountID('Super');
    dsPrefs.DataSet.Post;
  end;

  if dsPrefs.DataSet.FieldByName('SundriesPaidAccountID').AsInteger = 0 then begin
    dsPrefs.DataSet.Edit;
    dsPrefs.DataSet.FieldByName('SundriesPaidAccountID').AsInteger := GetAccountID('Sundries Paid');
    dsPrefs.DataSet.Post;
  end;

  if dsPrefs.DataSet.FieldByName('DeductionsPaidAccountID').AsInteger = 0 then begin
    dsPrefs.DataSet.Edit;
    dsPrefs.DataSet.FieldByName('DeductionsPaidAccountID').AsInteger := GetAccountID('Deduction Paid');
    dsPrefs.DataSet.Post;
  end;

  if dsPrefs.DataSet.FieldByName('SuperPayableAccountID').AsInteger = 0 then begin
    dsPrefs.DataSet.Edit;
    dsPrefs.DataSet.FieldByName('SuperPayableAccountID').AsInteger := GetAccountID('Superannuation');
    dsPrefs.DataSet.Post;
  end;

  if dsPrefs.DataSet.FieldByName('WagesPaidAccountID').AsInteger = 0 then begin
    dsPrefs.DataSet.Edit;
    dsPrefs.DataSet.FieldByName('WagesPaidAccountID').AsInteger := GetAccountID('Gross Wages');
    dsPrefs.DataSet.Post;
  end;

  if dsPrefs.DataSet.FieldByName('PAYGTaxPayableAccountID').AsInteger = 0 then begin
    dsPrefs.DataSet.Edit;
    dsPrefs.DataSet.FieldByName('PAYGTaxPayableAccountID').AsInteger := GetAccountID('PAYG Tax');
    dsPrefs.DataSet.Post;
  end;
end;

initialization
  RegisterClassOnce(TPayrollPrefsUSGUI);
finalization
  UnRegisterClass(TPayrollPrefsUSGUI);
end.
