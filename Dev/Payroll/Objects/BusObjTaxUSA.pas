unit BusObjTaxUSA;

interface

uses
  BusObjTaxBase,Classes;

type

   TTaxUSA = class(TTaxBase)
   private
     fFedTax,
     fStateTax,
     fMedicareTax,
     fSocialSecurityTax: double;
//     class function GetIDField: string; override;
//     class function GetBusObjectTablename: string; Override;
   public
     procedure CalcAllTax;
     function CalcTax: double; override;
     property FedTax: double read fFedTax;
     property StateTax: double read fStateTax;
     property MedicareTax: double read fMedicareTax;
     property SocialSecurityTax: double read fSocialSecurityTax;
   end;

implementation

uses
  SysUtils, BusObjPayBase, CommonLib, PayCommon, AppEnvironment;

{ TTaxUSA }

procedure TTaxUSA.CalcAllTax;
var
  dFedTax: double;
  dStateTax: double;
  dSocialSecurityTax: double;
  dMedicareTax: double;
  //dCommissionTax: double;
//  dHECSAmount: double;
//  dSFSSAmount: double;
  dWeeklyTaxableGross: double;
  ///dWeeklyTaxableGrossNoCommission: double;
//  dWeeklyTaxableCDEP: double;
//  dCDEPTaxReduction: double;
begin
  {Manual Tax Does Not ReCalc Tax Amount}
//  dHECSAmount := 0.00;
//  dSFSSAmount := 0.00;
  dWeeklyTaxableGross := 0.00;
  ////dWeeklyTaxableGrossNoCommission := 0.00;
//  dWeeklyTaxableCDEP := 0.00;


  // calc the weekly equivalent gross
  if Trim(Tpaybase(Self.Owner).EmployeePaySettings.Payperiod) = 'Fortnightly' then begin
    dWeeklyTaxableGross := (Tpaybase(Self.Owner).PayTotals.GrossTaxable) / 2;
//    dWeeklyTaxableGross := Trunc((Tpaybase(Self.Owner).PayTotals.GrossTaxable) / 2);
    ///dWeeklyTaxableGrossNoCommission := Trunc((Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner).PayCommissions.TotalBeforeTax) / 2);
//    dWeeklyTaxableCDEP := Trunc((Tpaybase(Self.Owner).PayTotals.GrossCDEP) / 2);
  end else if Trim(Tpaybase(Self.Owner).EmployeePaySettings.Payperiod) = 'Monthly' then begin
    if system.Round(Frac(Tpaybase(Self.Owner).PayTotals.GrossTaxable) * 100) = 33 then begin
      dWeeklyTaxableGross := ((Tpaybase(Self.Owner).PayTotals.GrossTaxable) + 0.01) * 3 / 13;
//      dWeeklyTaxableCDEP := ((Tpaybase(Self.Owner).PayTotals.GrossCDEP) + 0.01) * 3 / 13;
    end else begin
      dWeeklyTaxableGross := (Tpaybase(Self.Owner).PayTotals.GrossTaxable) * 3 / 13;
//      dWeeklyTaxableCDEP := (Tpaybase(Self.Owner).PayTotals.GrossCDEP) * 3 / 13;
    end;
    if system.Round(Frac(Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner).PayCommissions.TotalBeforeTax) * 100) = 33 then begin
      ////dWeeklyTaxableGrossNoCommission := ((Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner).PayCommissions.TotalBeforeTax) + 0.01) * 3 / 13;
    end else begin
      ///dWeeklyTaxableGrossNoCommission := (Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner).PayCommissions.TotalBeforeTax) * 3 / 13;
    end;
  end else if Trim(Tpaybase(Self.Owner).EmployeePaySettings.Payperiod) = 'Bi-Monthly' then begin
    if Trunc(Frac((Tpaybase(Self.Owner).PayTotals.GrossTaxable)) * 100) = 33 then begin
      dWeeklyTaxableGross := (((Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner).PayCommissions.TotalBeforeTax) + 0.01) * 3 / 13) * 2;
//      dWeeklyTaxableCDEP := (((Tpaybase(Self.Owner).PayTotals.GrossCDEP) + 0.01) * 3 / 13) * 2;
    end else begin;
      dWeeklyTaxableGross := ((Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner).PayCommissions.TotalBeforeTax) * 3 / 13) * 2;
//      dWeeklyTaxableCDEP := ((Tpaybase(Self.Owner).PayTotals.GrossCDEP) * 3 / 13) * 2;
    end;
    if Trunc(Frac((Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner).PayCommissions.TotalBeforeTax)) * 100) = 33 then begin
      ///dWeeklyTaxableGrossNoCommission := (((Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner).PayCommissions.TotalBeforeTax) + 0.01) * 3 / 13) * 2;
    end else begin;
      ////dWeeklyTaxableGrossNoCommission := ((Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner).PayCommissions.TotalBeforeTax) * 3 / 13) * 2;
    end;
  end else if Trim(Tpaybase(Self.Owner).EmployeePaySettings.Payperiod) = 'Weekly' then begin
    dWeeklyTaxableGross :=             (Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner).PayCommissions.TotalBeforeTax);
//    dWeeklyTaxableCDEP := Tpaybase(Self.Owner).PayTotals.GrossCDEP;
    ///dWeeklyTaxableGrossNoCommission := (Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner).PayCommissions.TotalBeforeTax);
  end;

  {#1 Pay Periods (Pay Multiple Weeks In One Pay}
  dWeeklyTaxableGross := DivZer(dWeeklyTaxableGross, Tpaybase(Self.Owner).Payperiods);
//  dWeeklyTaxableCDEP := DivZer(dWeeklyTaxableCDEP, Tpaybase(Self.Owner).PayPeriods);
  ///dWeeklyTaxableGrossNoCommission := DivZer(dWeeklyTaxableGrossNoCommission, Tpaybase(Self.Owner).PayPeriods);

//  dNormalTax := GetTaxComponent(Tpaybase(Self.Owner).EmployeeDetails.Taxscaleid, dWeeklyTaxableGrossNoCommission,Trim(Tpaybase(Self.Owner).EmployeePaySettings.PayPeriod),Tpaybase(Self.Owner).IsPayVerify);
//  dFedTax := GetTaxComponent(Tpaybase(Self.Owner).EmployeeDetails.Taxscaleid, dWeeklyTaxableGrossNoCommission,Trim(Tpaybase(Self.Owner).EmployeePaySettings.PayPeriod),Tpaybase(Self.Owner).IsPayVerify);
//  if Tpaybase(Self.Owner).EmployeeDetails.USEnableStateTax then
//    dStateTax := GetTaxComponent(Tpaybase(Self.Owner).EmployeeDetails.USStateTaxScaleID, dWeeklyTaxableGrossNoCommission,Trim(Tpaybase(Self.Owner).EmployeePaySettings.PayPeriod),Tpaybase(Self.Owner).IsPayVerify)
//  else
//    dStateTax := 0;
//  dSocialSecurityTax := GetTaxComponent(Tpaybase(Self.Owner).EmployeeDetails.USSocialSecurityTaxScaleID, dWeeklyTaxableGrossNoCommission,Trim(Tpaybase(Self.Owner).EmployeePaySettings.PayPeriod),Tpaybase(Self.Owner).IsPayVerify);
//  dMedicareTax := GetTaxComponent(Tpaybase(Self.Owner).EmployeeDetails.USMedicareTaxScaleID, dWeeklyTaxableGrossNoCommission,Trim(Tpaybase(Self.Owner).EmployeePaySettings.PayPeriod),Tpaybase(Self.Owner).IsPayVerify);

  { Include comission in calculation }
  dFedTax := GetTaxComponent(Tpaybase(Self.Owner).EmployeeDetails.Taxscaleid,
    dWeeklyTaxableGross,Trim(Tpaybase(Self.Owner).EmployeePaySettings.PayPeriod),
    Tpaybase(Self.Owner).IsPayVerify, TPayBase(Self.Owner).USTaxAllowanceQty * AppEnv.PayPrefs.USPayAllowanceAmount,
    TPayBase(Self.Owner).Employeeid);
  if Tpaybase(Self.Owner).EmployeeDetails.USEnableStateTax then
    dStateTax := GetTaxComponent(Tpaybase(Self.Owner).EmployeeDetails.USStateTaxScaleID,
      dWeeklyTaxableGross,Trim(Tpaybase(Self.Owner).EmployeePaySettings.PayPeriod),
      Tpaybase(Self.Owner).IsPayVerify, TPayBase(Self.Owner).USTaxAllowanceStateQty * AppEnv.PayPrefs.USPayAllowanceStateAmount,
      TPayBase(Self.Owner).Employeeid)
  else
    dStateTax := 0;
  dSocialSecurityTax := GetTaxComponent(Tpaybase(Self.Owner).EmployeeDetails.USSocialSecurityTaxScaleID, dWeeklyTaxableGross,Trim(Tpaybase(Self.Owner).EmployeePaySettings.PayPeriod),Tpaybase(Self.Owner).IsPayVerify);
  dMedicareTax := GetTaxComponent(Tpaybase(Self.Owner).EmployeeDetails.USMedicareTaxScaleID, dWeeklyTaxableGross,Trim(Tpaybase(Self.Owner).EmployeePaySettings.PayPeriod),Tpaybase(Self.Owner).IsPayVerify);


//  dCDEPTaxReduction := CDEPTaxReductionAmount(dWeeklyTaxableCDEP);

//  if Tpaybase(Self.Owner).EmployeeDetails.Hecsindicator then begin
//    dHECSAmount := GetTaxComponent(Tpaybase(Self.Owner).EmployeeDetails.HecsTaxScale, dWeeklyTaxableGross, Trim(Tpaybase(Self.Owner).EmployeePaySettings.Payperiod),Tpaybase(Self.Owner).IsPayVerify);
//  end;
//  if Tpaybase(Self.Owner).EmployeeDetails.Studentloanindicator then begin
//    dSFSSAmount := GetTaxComponent(Tpaybase(Self.Owner).EmployeeDetails.StudentloanTaxScale, dWeeklyTaxableGross, Trim(Tpaybase(Self.Owner).EmployeePaySettings.PayPeriod),Tpaybase(Self.Owner).IsPayVerify);
//  end;

  {#2 Pay Periods (Pay Multiple Weeks In One Pay}
  dFedTax := dFedTax * Tpaybase(Self.Owner).Payperiods;
  if dStateTax <> 0 then
    dStateTax := dStateTax * Tpaybase(Self.Owner).Payperiods;
  dSocialSecurityTax := dSocialSecurityTax * Tpaybase(Self.Owner).Payperiods;
  dMedicareTax := dMedicareTax * Tpaybase(Self.Owner).Payperiods;
//  dHECSAmount := dHECSAmount * Tpaybase(Self.Owner).PayPeriods;
//  dSFSSAmount := dSFSSAmount * Tpaybase(Self.Owner).PayPeriods;
//  dCDEPTaxReduction := dCDEPTaxReduction * Tpaybase(Self.Owner).PayPeriods;

  {Commission Tax}
  { Note: commission included in above }
  //dCommissionTax := Tpaybase(Self.Owner).PayCommissions.CalcTax;



  {Normal Tax}
//  Result := dNormalTax + dCommissionTax + dHECSAmount + dSFSSAmount - dCDEPTaxReduction;

  { Extra Tax NOTE only added to Federal tax }
  if FindInSet(Trim(Tpaybase(Self.Owner).EmployeeDetails.ExtraTaxOptions), '$') then begin
    dFedTax := dFedTax + Tpaybase(Self.Owner).EmployeeDetails.ExtraTax;
  end else if FindInSet(Trim(Tpaybase(Self.Owner).EmployeeDetails.ExtraTaxOptions), '%') then begin
    dFedTax := dFedTax + (dFedTax * Tpaybase(Self.Owner).EmployeeDetails.ExtraTax / 100);
  end else if FindInSet(Trim(Tpaybase(Self.Owner).EmployeeDetails.ExtraTaxOptions), 'Fixed') then begin
    dFedTax := Tpaybase(Self.Owner).EmployeeDetails.ExtraTax;
  end;

  { round to nearest dollar }
  if AppEnv.PayPrefs.USRoundFedTax then
    fFedTax := CommonLib.Round(dFedTax, 0)
  else
    fFedTax := dFedTax;
  if AppEnv.PayPrefs.USRoundStateTax then
    fStateTax := CommonLib.Round(dStateTax, 0)
  else
    fStateTax := dStateTax;
  if AppEnv.PayPrefs.USRoundSocialSecurityTax then
    fSocialSecurityTax := CommonLib.Round(dSocialSecurityTax, 0)
  else
    fSocialSecurityTax := dSocialSecurityTax;
  if AppEnv.PayPrefs.USRoundMedicareTax then
    fMedicareTax := CommonLib.Round(dMedicareTax, 0)
  else
    fMedicareTax := dMedicareTax;

end;

function TTaxUSA.CalcTax: double;
begin
  result := fFedTax + fStateTax + fMedicareTax + fSocialSecurityTax;
end;

end.
