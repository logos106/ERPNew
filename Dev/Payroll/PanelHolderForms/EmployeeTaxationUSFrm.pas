unit EmployeeTaxationUSFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,BusObjEmployeePay, StdCtrls, ExtCtrls, DNMPanel,
  wwclearbuttongroup, wwradiogroup, wwcheckbox, wwdblook, Mask, DBCtrls,
  DB, MemDS, DBAccess, MyAccess,ERPdbComponents, wwdbedit, frmBase, BusObjBase,
  Menus, MessageConst;

type
  TEmployeeTaxUSGUI = class(TfrmBaseGUI)
    DSEmployees: TDataSource;
    qryTaxScales: TERPQuery;
    dsEmpPaySettings: TDataSource;
    qryTaxScale: TERPQuery;
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    DNMPanel3: TDNMPanel;
    Label7: TLabel;
    lblUSFedTaxScaleID: TLabel;
    Label65: TLabel;
    edTFN: TDBEdit;
    TaxScale: TwwDBLookupCombo;
    chkEnableStateTax: TwwCheckBox;
    ABN: TDBEdit;
    DNMPanel5: TDNMPanel;
    Label1: TLabel;
    Label20: TLabel;
    ExtraTaxOptions: TwwRadioGroup;
    ExtraTax: TDBEdit;
    StateTaxScale: TwwDBLookupCombo;
    qryStateTaxScale: TERPQuery;
    qrySocialSecurityTax: TERPQuery;
    Label2: TLabel;
    SocialSecurityTaxScale: TwwDBLookupCombo;
    Label3: TLabel;
    MedicareTaxScale: TwwDBLookupCombo;
    qryMedicareTaxScale: TERPQuery;
    Label4: TLabel;
    edtAllowanceQty: TwwDBEdit;
    lblUSStateTaxScaleID: TLabel;
    Label5: TLabel;
    edtAllowanceStateQty: TwwDBEdit;
    Label6: TLabel;
    Label8: TLabel;
    edtTaxExpense: TEdit;
    edtTaxLiability: TEdit;
    edtStateExpense: TEdit;
    edtStateLiability: TEdit;
    edtSocialExpense: TEdit;
    edtSocialLiability: TEdit;
    edtSocialCoExpense: TEdit;
    edtSocialCoLiability: TEdit;
    edtMedExpense: TEdit;
    edtMedLiability: TEdit;
    edtMedCoExpense: TEdit;
    edtMedCoLiability: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    procedure SetSubEmpPay(Const Value :Temployeepay );
    procedure chkEnableStateTaxClick(Sender: TObject);
    procedure qryTaxScaleBeforeOpen(DataSet: TDataSet);
    procedure qrySocialSecurityTaxBeforeOpen(DataSet: TDataSet);
    procedure qryMedicareTaxScaleBeforeOpen(DataSet: TDataSet);
    procedure qryStateTaxScaleBeforeOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure PayAccountDblClick(Sender: TObject);
    //procedure edtStateTaxLabelExit(Sender: TObject);
  private
    fSubEmpPay:Temployeepay;
    //edtStateTaxLabelSave: string;
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure LoadAccounts;
  public
    procedure DoPanelBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
    property SubEmpPay:Temployeepay  read fSubEmpPay write SetSubEmpPay ;
  end;

implementation
uses
  BusObjConst,CommonLib, AppEnvironment, CommonDbLib, BusObjGLAccount,
  PayAccounts, Preferences;

{$R *.dfm}

procedure TEmployeeTaxUSGUI.SetSubEmpPay(Const Value :Temployeepay);
begin
  fSubEmpPay := Value;
end;


procedure TEmployeeTaxUSGUI.chkEnableStateTaxClick(Sender: TObject);
begin
  if not chkEnableStateTax.Checked then SubEmpPay.EmployeeDetails.USStateTaxScaleID := 0;
  StateTaxScale.Enabled := chkEnableStateTax.Checked;
  edtAllowanceStateQty.Enabled := chkEnableStateTax.Checked;
end;

procedure TEmployeeTaxUSGUI.DoPanelBusinessObjectEvent(
  const Sender: TDatasetBusObj; const EventType, Value: string);
var
  ErrorCode: integer;
begin
  if Value = BusobjEventVal_FailedTaxationValidateData then begin
//    HandleEmployeeTaxErrors;
    ErrorCode := StrToIntDef(EventType,0);
    case ErrorCode of
      BOR_Employee_Err_NoStateTax:
        begin
          SetControlFocus(StateTaxScale);
          exit;
        end;
      BOR_Employee_Err_HECSTaxScale : begin
//                                        SubEmpPay.EmployeeDetails.HecsTaxScale := 0;
//                                        cboHECSTaxScales.RefreshDisplay;
//                                        SetControlFocus(chkHECS);
//                                        exit;
                                      end;
      BOR_Employee_Err_NoHECSTaxScale : begin
//                                        SetControlFocus(cboHECSTaxScales);
//                                        exit;
                                      end;
      BOR_Employee_Err_StudentLoanTaxScale : begin
//                                              SubEmpPay.EmployeeDetails.StudentloanTaxScale := 0;
//                                              cboStudentLoanTaxScales.RefreshDisplay;
//                                              SetControlFocus(chkSFSS);
//                                              exit;
                                            end;
      BOR_Employee_Err_NoStudentLoanTaxScale : begin
//                                                SetControlFocus(cboStudentLoanTaxScales);
//                                                exit;
                                              end;


   end;
  end;
end;

procedure TEmployeeTaxUSGUI.PayAccountDblClick(Sender: TObject);
var
  DoRefresh: boolean;
begin
  DoRefresh := false;
  if Sender = edtTaxExpense then
    DoRefresh := OpenPrefForm('Payroll','cboFedWithholdingExpence',0,true,'Fed Withholding Expense')
  else if Sender = edtTaxLiability then
    DoRefresh := OpenPrefForm('Payroll','cboFedWithholdingTaxPayable',0,true,'Fed Withholding Payable')

  else if Sender = edtStateExpense then
    DoRefresh := OpenPrefForm('Payroll','cboStateWithholdingExpenses',0,true,'State Withholding Expense')
  else if Sender = edtStateLiability then
    DoRefresh := OpenPrefForm('Payroll','cboStateWithholdingTaxPayable',0,true,'State Withholding Payable')

  else if Sender = edtSocialExpense then
    DoRefresh := OpenPrefForm('Payroll','cboSocialSecurityPaidAccount',0,true,'Social Security Paid')
  else if Sender = edtSocialLiability then
    DoRefresh := OpenPrefForm('Payroll','cboSocialSecurityPayable',0,true,'Social Security Payable')

  else if Sender = edtSocialCoExpense then
    DoRefresh := OpenPrefForm('Payroll','cboSocialSecurityPaidCompanyAccount',0,true,'Co Social Security Paid')
  else if Sender = edtSocialCoLiability then
    DoRefresh := OpenPrefForm('Payroll','cboSocialSecurityCompanyPayable',0,true,'Co Social Security Payable')

  else if Sender = edtMedExpense then
    DoRefresh := OpenPrefForm('Payroll','cboMedicarePaid',0,true,'Medicare Paid')
  else if Sender = edtMedLiability then
    DoRefresh := OpenPrefForm('Payroll','cboMedicarePayable',0,true,'Medicare Payable')

  else if Sender = edtMedCoExpense then
    DoRefresh := OpenPrefForm('Payroll','cboMedicarePaidCompany',0,true,'Co Medicare Paid')
  else if Sender = edtMedCoLiability then
    DoRefresh := OpenPrefForm('Payroll','cboMedicarePayableCompany',0,true,'Co Medicare Payable');

  if DoRefresh then
    LoadAccounts;

end;


procedure TEmployeeTaxUSGUI.FormCreate(Sender: TObject);
begin
  inherited;
  lblUSStateTaxScaleID.caption := AppEnv.PayPrefs.USStateTaxLabel+' :';
  lblUSFedTaxScaleID.caption := AppEnv.PayPrefs.USFedTaxLabel+' :';
end;

procedure TEmployeeTaxUSGUI.LoadAccounts;
begin
  edtTaxExpense.Text := TAccount.IDToggle(PAYGExpenseAccountID(SubEmpPay.EmployeeDetails.ID));
  edtTaxLiability.Text := TAccount.IDToggle(PAYGTaxPayableAccountID(SubEmpPay.EmployeeDetails.ID));

  edtStateExpense.Text := TAccount.IDToggle(StateWithholdingTaxPaidAccountId(SubEmpPay.EmployeeDetails.ID));
  edtStateLiability.Text := TAccount.IDToggle(StateWithholdingTaxPayableAccountId(SubEmpPay.EmployeeDetails.ID));

  edtSocialExpense.Text := TAccount.IDToggle(SocialSecurityPaidAccountId(SubEmpPay.EmployeeDetails.ID));
  edtSocialLiability.Text := TAccount.IDToggle(SocialSecurityPayableAccountId(SubEmpPay.EmployeeDetails.ID));

  edtSocialCoExpense.Text := TAccount.IDToggle(SocialSecurityPaidCompanyAccountId(SubEmpPay.EmployeeDetails.ID));
  edtSocialCoLiability.Text := TAccount.IDToggle(SocialSecurityPayableCompanyAccountId(SubEmpPay.EmployeeDetails.ID));


  edtMedExpense.Text := TAccount.IDToggle(MedicarePaidAccountId(SubEmpPay.EmployeeDetails.ID));
  edtMedLiability.Text := TAccount.IDToggle(MedicarePayableAccountId(SubEmpPay.EmployeeDetails.ID));

  edtMedCoExpense.Text := TAccount.IDToggle(MedicarePaidCompanyAccountId(SubEmpPay.EmployeeDetails.ID));
  edtMedCoLiability.Text := TAccount.IDToggle(MedicarePayableCompanyAccountId(SubEmpPay.EmployeeDetails.ID));
end;

(*procedure TEmployeeTaxUSGUI.edtStateTaxLabelExit(Sender: TObject);
var
  qry: TERPQuery;
begin
  inherited;
  if edtStateTaxLabel.Text <> edtStateTaxLabelSave then begin
    edtStateTaxLabelSave := edtStateTaxLabel.Text;
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := fSubEmpPay.Connection.Connection;   //CommonDbLib.GetSharedMyDacConnection;
      qry.SQL.Text := 'select * from tbldbpreferences where Name = "USStateTaxLabel" and PrefType = "ptCompany"';
      qry.Open;
      if qry.IsEmpty then begin
        qry.Insert;
        qry.FieldByName('PrefType').AsString := 'ptCompany';
        qry.FieldByName('Name').AsString := 'USStateTaxLabel';
        qry.FieldByName('RefType').AsString := 'None';
        qry.FieldByName('LocalPref').AsString := 'F';
        qry.FieldByName('FieldType').AsString := 'ftString';
        qry.FieldByName('FieldSize').AsInteger := 255;
      end
      else
        qry.Edit;
      qry.FieldByName('FieldValue').AsString := edtStateTaxLabel.Text;
      qry.Post;
    finally
      qry.Free;
    end;
  end;
end;*)

procedure TEmployeeTaxUSGUI.PerformStartup(var Msg: TMessage);
//var
(*  qry: TERPQuery;*)
//  Accnt: TAccount;
begin
  (*edtStateTaxLabel.Color := DNMPanel3.Color;
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := fSubEmpPay.Connection.Connection; //CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text := 'select FieldValue from tbldbpreferences where Name = "USStateTaxLabel" and PrefType = "ptCompany"';
    qry.Open;
    edtStateTaxLabelSave := qry.FieldByName('FieldValue').AsString;
    if edtStateTaxLabelSave <> '' then
      edtStateTaxLabel.Text := edtStateTaxLabelSave;

  finally
    qry.Free;
  end;*)

  LoadAccounts;

end;

procedure TEmployeeTaxUSGUI.qryMedicareTaxScaleBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryMedicareTaxScale.parambyname('RegionID').asInteger := AppEnv.RegionalOptions.ID;
end;

procedure TEmployeeTaxUSGUI.qrySocialSecurityTaxBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qrySocialSecurityTax.parambyname('RegionID').asInteger := AppEnv.RegionalOptions.ID;
end;

procedure TEmployeeTaxUSGUI.qryStateTaxScaleBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryStateTaxScale.parambyname('RegionID').asInteger := AppEnv.RegionalOptions.ID;
end;

procedure TEmployeeTaxUSGUI.qryTaxScaleBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryTaxScale.parambyname('RegionID').asInteger := AppEnv.RegionalOptions.ID;
end;

initialization
  RegisterClassOnce(TEmployeeTaxUSGUI);
end.
