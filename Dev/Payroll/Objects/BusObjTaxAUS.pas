unit BusObjTaxAUS;
interface
uses
  BusObjTaxBase,Classes;
type
   TTaxAUS = class(TTaxBase)
   private
     Function CDEPTaxReductionAmount(Const WeeklyCDEPAmount:Double):Integer;
//     class function GetIDField: string; override;
//     class function GetBusObjectTablename: string; Override;
   public
     Function CalcTax:double;  override;
   end;
implementation

uses
  BusObjPaybase, BusObjEmployeeDetails,CommonLib,PayCommon, sysutils;

//const
//  TAX_SCALE_HECS = 10;
//  TAX_SCALE_SFSS = 9;

function TTaxAUS.CalcTax: double;
var
  dNormalTax: double; 
  dCommissionTax: double;
  dHECSAmount: double;
  dSFSSAmount: double;
  dWeeklyTaxableGross: double;
  dWeeklyTaxableGrossNoCommission: double;
  dWeeklyTaxableCDEP: double;
  dCDEPTaxReduction: double;
begin
  {Manual Tax Does Not ReCalc Tax Amount}
  dHECSAmount := 0.00;
  dSFSSAmount := 0.00;
  dWeeklyTaxableGross := 0.00;
  dWeeklyTaxableGrossNoCommission := 0.00;
  dWeeklyTaxableCDEP := 0.00;


  // calc the weekly equivalent gross
  if Trim(Tpaybase(Self.Owner).EmployeePaySettings.Payperiod) = 'Fortnightly' then begin
    dWeeklyTaxableGross := Trunc((Tpaybase(Self.Owner).PayTotals.GrossTaxable) / 2);
    dWeeklyTaxableGrossNoCommission := Trunc((Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner).PayCommissions.TotalBeforeTax) / 2);
    dWeeklyTaxableCDEP := Trunc((Tpaybase(Self.Owner).PayTotals.GrossCDEP) / 2);
  end else if Trim(Tpaybase(Self.Owner).EmployeePaySettings.Payperiod) = 'Monthly' then begin
    if system.Round(Frac(Tpaybase(Self.Owner).PayTotals.GrossTaxable) * 100) = 33 then begin
      dWeeklyTaxableGross := ((Tpaybase(Self.Owner).PayTotals.GrossTaxable) + 0.01) * 3 / 13;
      dWeeklyTaxableCDEP := ((Tpaybase(Self.Owner).PayTotals.GrossCDEP) + 0.01) * 3 / 13;
    end else begin
      dWeeklyTaxableGross := (Tpaybase(Self.Owner).PayTotals.GrossTaxable) * 3 / 13;
      dWeeklyTaxableCDEP := (Tpaybase(Self.Owner).PayTotals.GrossCDEP) * 3 / 13;
    end;
    if system.Round(Frac(Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner).PayCommissions.TotalBeforeTax) * 100) = 33 then begin
      dWeeklyTaxableGrossNoCommission := ((Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner).PayCommissions.TotalBeforeTax) + 0.01) * 3 / 13;
    end else begin
      dWeeklyTaxableGrossNoCommission := (Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner).PayCommissions.TotalBeforeTax) * 3 / 13;
    end;
  end else if Trim(Tpaybase(Self.Owner).EmployeePaySettings.Payperiod) = 'Bi-Monthly' then begin
    if Trunc(Frac((Tpaybase(Self.Owner).PayTotals.GrossTaxable)) * 100) = 33 then begin
      dWeeklyTaxableGross := (((Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner).PayCommissions.TotalBeforeTax) + 0.01) * 3 / 13) * 2;
      dWeeklyTaxableCDEP := (((Tpaybase(Self.Owner).PayTotals.GrossCDEP) + 0.01) * 3 / 13) * 2;
    end else begin;
      dWeeklyTaxableGross := ((Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner).PayCommissions.TotalBeforeTax) * 3 / 13) * 2;
      dWeeklyTaxableCDEP := ((Tpaybase(Self.Owner).PayTotals.GrossCDEP) * 3 / 13) * 2;
    end;
    if Trunc(Frac((Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner).PayCommissions.TotalBeforeTax)) * 100) = 33 then begin
      dWeeklyTaxableGrossNoCommission := (((Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner).PayCommissions.TotalBeforeTax) + 0.01) * 3 / 13) * 2;
    end else begin;
      dWeeklyTaxableGrossNoCommission := ((Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner).PayCommissions.TotalBeforeTax) * 3 / 13) * 2;
    end;
  end else if Trim(Tpaybase(Self.Owner).EmployeePaySettings.Payperiod) = 'Weekly' then begin
    dWeeklyTaxableGross := (Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner).PayCommissions.TotalBeforeTax);
    dWeeklyTaxableCDEP := Tpaybase(Self.Owner).PayTotals.GrossCDEP;
    dWeeklyTaxableGrossNoCommission := (Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner).PayCommissions.TotalBeforeTax);
  end;

  {#1 Pay Periods (Pay Multiple Weeks In One Pay}
  dWeeklyTaxableGross := DivZer(dWeeklyTaxableGross, Tpaybase(Self.Owner).Payperiods);
  dWeeklyTaxableCDEP := DivZer(dWeeklyTaxableCDEP, Tpaybase(Self.Owner).PayPeriods);
  dWeeklyTaxableGrossNoCommission := DivZer(dWeeklyTaxableGrossNoCommission, Tpaybase(Self.Owner).PayPeriods);

  dNormalTax := GetTaxComponent(Tpaybase(Self.Owner).EmployeeDetails.Taxscaleid, dWeeklyTaxableGrossNoCommission,Trim(Tpaybase(Self.Owner).EmployeePaySettings.PayPeriod),Tpaybase(Self.Owner).IsPayVerify);
 
  dCDEPTaxReduction := CDEPTaxReductionAmount(dWeeklyTaxableCDEP);

  if Tpaybase(Self.Owner).EmployeeDetails.Hecsindicator then begin
  //  dHECSAmount := GetTaxComponent(TAX_SCALE_HECS, dWeeklyTaxableGross, Trim(Tpaybase(Self.Owner).EmployeePaySettings.Payperiod),Tpaybase(Self.Owner).IsPayVerify);
    dHECSAmount := GetTaxComponent(Tpaybase(Self.Owner).EmployeeDetails.HecsTaxScale, dWeeklyTaxableGross, Trim(Tpaybase(Self.Owner).EmployeePaySettings.Payperiod),Tpaybase(Self.Owner).IsPayVerify);
  end;
  if Tpaybase(Self.Owner).EmployeeDetails.Studentloanindicator then begin
  //  dSFSSAmount := GetTaxComponent(TAX_SCALE_SFSS, dWeeklyTaxableGross, Trim(Tpaybase(Self.Owner).EmployeePaySettings.PayPeriod),Tpaybase(Self.Owner).IsPayVerify);
    dSFSSAmount := GetTaxComponent(Tpaybase(Self.Owner).EmployeeDetails.StudentloanTaxScale, dWeeklyTaxableGross, Trim(Tpaybase(Self.Owner).EmployeePaySettings.PayPeriod),Tpaybase(Self.Owner).IsPayVerify);
  end;

  {#2 Pay Periods (Pay Multiple Weeks In One Pay}
  dNormalTax := dNormalTax * Tpaybase(Self.Owner).Payperiods;
  dHECSAmount := dHECSAmount * Tpaybase(Self.Owner).PayPeriods;
  dSFSSAmount := dSFSSAmount * Tpaybase(Self.Owner).PayPeriods;
  dCDEPTaxReduction := dCDEPTaxReduction * Tpaybase(Self.Owner).PayPeriods;

  {Commission Tax}
  dCommissionTax := Tpaybase(Self.Owner).PayCommissions.CalcTax;

  {Normal Tax}
  Result := dNormalTax + dCommissionTax + dHECSAmount + dSFSSAmount - dCDEPTaxReduction;

  {Extra Tax}
  if FindInSet(Trim(Tpaybase(Self.Owner).EmployeeDetails.ExtraTaxOptions), '$') then begin
    Result := Result + Tpaybase(Self.Owner).EmployeeDetails.ExtraTax;
  end else if FindInSet(Trim(Tpaybase(Self.Owner).EmployeeDetails.ExtraTaxOptions), '%') then begin
    Result := Result + (Result * Tpaybase(Self.Owner).EmployeeDetails.ExtraTax / 100);
  end else if FindInSet(Trim(Tpaybase(Self.Owner).EmployeeDetails.ExtraTaxOptions), 'Fixed') then begin
    Result := Tpaybase(Self.Owner).EmployeeDetails.ExtraTax;
  end;

  { ATO requires that tax is rounded to nearest dollar }
  result := CommonLib.Round(result,0);

end;

Function TTaxAUS.CDEPTaxReductionAmount(Const WeeklyCDEPAmount:Double):Integer;
Begin
  Result := Trunc((WeeklyCDEPAmount-115)/6);  { was going to make 115 a payroll pref but didn't as it
                                               has not changed since 2004 }
  If Result<0 then Result:=0;
end;          

initialization
RegisterClassOnce(TTaxAUS);
end.
