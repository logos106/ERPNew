unit BusObjTaxBase;

interface
{$I ERP.inc}

uses
  BusObjBase, Classes;

type
  TTaxBase = class(TMSBusObj)
  private
//    function CDEPTaxReductionAmount(Const WeeklyCDEPAmount: Double): Integer;
//    function DoCalcTax: Double;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    Function CalcTax: Double; virtual;
  end;

implementation

uses
  CommonLib, SysUtils, BusObjPayBase, PayCommon, DbSharedObjectsObj,
  AppEnvironment, ERPDbComponents, CommonDbLib, PayTaxableTotalObj, tcTypes;

Function TTaxBase.CalcTax: Double;
begin
  Result := 0.00;
end;

//function TTaxBase.CDEPTaxReductionAmount(const WeeklyCDEPAmount: Double): Integer;
//begin
//  Result := Trunc((WeeklyCDEPAmount - 115) / 6);
//  { was going to make 115 a payroll pref but didn't as it
//    has not changed since 2004 }
//  If Result < 0 then
//    Result := 0;
//end;

//function TTaxBase.DoCalcTax: Double;
//var
//  dNormalTax,
//  dNormalTaxTotal: Double;
//  dHECSAmount: Double;
//  dSFSSAmount: Double;
//  dWeeklyTaxableGross: Double;
//  dWeeklyTaxableGrossNoCommission: Double;
//  dWeeklyTaxableCDEP: Double;
//  dCDEPTaxReduction: Double;
//  qry: TERPQuery;
//  x, y: integer;
//  taRec, taSubRec: TTaxAmount;
//  ttRec: TTaxableTotal;
//  taxAmount: double;
//begin
//  { Manual Tax Does Not ReCalc Tax Amount }
//  dHECSAmount := 0.00;
//  dSFSSAmount := 0.00;
//  dWeeklyTaxableGross := 0.00;
//  dWeeklyTaxableGrossNoCommission := 0.00;
//  dWeeklyTaxableCDEP := 0.00;
//  result := 0;
//
//  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
//  try
//    qry.SQL.Add('select * from tblPayTaxScaleConfig');
//    qry.SQL.Add('inner join tblpaytaxconfig on tblpaytaxconfig.ID = tblPayTaxScaleConfig.PayTaxConfigId and tblpaytaxconfig.RegionId = '+
//	  IntToStr(AppEnv.RegionalOptions.Id)+' and tblpaytaxconfig.Active = "T"');
//    qry.SQL.Add('where tblPayTaxScaleConfig.EmployeeId = ' + IntToStr(Tpaybase(Self.Owner).EmployeeId));
//    qry.Open;
//
//    // calc the weekly equivalent gross
//    if Trim(Tpaybase(Self.Owner).EmployeePaySettings.Payperiod) = 'Fortnightly' then begin
//      dWeeklyTaxableGross := Trunc((Tpaybase(Self.Owner).PayTotals.GrossTaxable) / 2);
//      dWeeklyTaxableGrossNoCommission :=
//        Trunc((Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner)
//        .PayCommissions.TotalBeforeTax) / 2);
//      dWeeklyTaxableCDEP := Trunc((Tpaybase(Self.Owner).PayTotals.GrossCDEP) / 2);
//    end
//    else if Trim(Tpaybase(Self.Owner).EmployeePaySettings.Payperiod) = 'Monthly' then begin
//      if system.Round(Frac(Tpaybase(Self.Owner).PayTotals.GrossTaxable) * 100) = 33 then begin
//        dWeeklyTaxableGross := ((Tpaybase(Self.Owner).PayTotals.GrossTaxable) + 0.01) * 3 / 13;
//        dWeeklyTaxableCDEP := ((Tpaybase(Self.Owner).PayTotals.GrossCDEP) + 0.01) * 3 / 13;
//      end
//      else begin
//        dWeeklyTaxableGross := (Tpaybase(Self.Owner).PayTotals.GrossTaxable) * 3 / 13;
//        dWeeklyTaxableCDEP := (Tpaybase(Self.Owner).PayTotals.GrossCDEP) * 3 / 13;
//      end;
//      if system.Round(Frac(Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner)
//        .PayCommissions.TotalBeforeTax) * 100) = 33 then begin
//        dWeeklyTaxableGrossNoCommission :=
//          ((Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner)
//          .PayCommissions.TotalBeforeTax) + 0.01) * 3 / 13;
//      end
//      else begin
//        dWeeklyTaxableGrossNoCommission :=
//          (Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner)
//          .PayCommissions.TotalBeforeTax) * 3 / 13;
//      end;
//    end
//    else if Trim(Tpaybase(Self.Owner).EmployeePaySettings.Payperiod) = 'Bi-Monthly' then begin
//      if Trunc(Frac((Tpaybase(Self.Owner).PayTotals.GrossTaxable)) * 100) = 33 then begin
//        dWeeklyTaxableGross :=
//          (((Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner)
//          .PayCommissions.TotalBeforeTax) + 0.01) * 3 / 13) * 2;
//        dWeeklyTaxableCDEP := (((Tpaybase(Self.Owner).PayTotals.GrossCDEP) + 0.01) * 3 / 13) * 2;
//      end
//      else begin;
//        dWeeklyTaxableGross := ((Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner)
//          .PayCommissions.TotalBeforeTax) * 3 / 13) * 2;
//        dWeeklyTaxableCDEP := ((Tpaybase(Self.Owner).PayTotals.GrossCDEP) * 3 / 13) * 2;
//      end;
//      if Trunc(Frac((Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner)
//        .PayCommissions.TotalBeforeTax)) * 100) = 33 then begin
//        dWeeklyTaxableGrossNoCommission :=
//          (((Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner)
//          .PayCommissions.TotalBeforeTax) + 0.01) * 3 / 13) * 2;
//      end
//      else begin;
//        dWeeklyTaxableGrossNoCommission :=
//          ((Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner)
//          .PayCommissions.TotalBeforeTax) * 3 / 13) * 2;
//      end;
//    end
//    else if Trim(Tpaybase(Self.Owner).EmployeePaySettings.Payperiod) = 'Weekly' then begin
//      dWeeklyTaxableGross := (Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner)
//        .PayCommissions.TotalBeforeTax);
//      dWeeklyTaxableCDEP := Tpaybase(Self.Owner).PayTotals.GrossCDEP;
//      dWeeklyTaxableGrossNoCommission :=
//        (Tpaybase(Self.Owner).PayTotals.GrossTaxable - Tpaybase(Self.Owner)
//        .PayCommissions.TotalBeforeTax);
//    end;
//
//    { #1 Pay Periods (Pay Multiple Weeks In One Pay }
//    dWeeklyTaxableGross := DivZer(dWeeklyTaxableGross, Tpaybase(Self.Owner).Payperiods);
//    dWeeklyTaxableCDEP := DivZer(dWeeklyTaxableCDEP, Tpaybase(Self.Owner).Payperiods);
//    dWeeklyTaxableGrossNoCommission := DivZer(dWeeklyTaxableGrossNoCommission,
//      Tpaybase(Self.Owner).Payperiods);
//
//    dCDEPTaxReduction := CDEPTaxReductionAmount(dWeeklyTaxableCDEP);
//
//    if Tpaybase(Self.Owner).EmployeeDetails.Hecsindicator then begin
//      dHECSAmount := GetTaxComponent(Tpaybase(Self.Owner).EmployeeDetails.HecsTaxScale,
//        dWeeklyTaxableGross, Trim(Tpaybase(Self.Owner).EmployeePaySettings.Payperiod),
//        Tpaybase(Self.Owner).IsPayVerify);
//    end;
//    if Tpaybase(Self.Owner).EmployeeDetails.Studentloanindicator then begin
//      dSFSSAmount := GetTaxComponent(Tpaybase(Self.Owner).EmployeeDetails.StudentloanTaxScale,
//        dWeeklyTaxableGross, Trim(Tpaybase(Self.Owner).EmployeePaySettings.Payperiod),
//        Tpaybase(Self.Owner).IsPayVerify);
//    end;
//
//    { #2 Pay Periods (Pay Multiple Weeks In One Pay }
//    dHECSAmount := dHECSAmount * Tpaybase(Self.Owner).Payperiods;
//    dSFSSAmount := dSFSSAmount * Tpaybase(Self.Owner).Payperiods;
//    dCDEPTaxReduction := dCDEPTaxReduction * Tpaybase(Self.Owner).Payperiods;
//
//    dNormalTaxTotal := 0;
//    qry.First;
//    while not qry.Eof do begin
//
//
//      dNormalTax := GetTaxComponent(qry.FieldByName('TaxScaleId').AsInteger,
//        dWeeklyTaxableGrossNoCommission, Trim(Tpaybase(Self.Owner).EmployeePaySettings.Payperiod),
//        Tpaybase(Self.Owner).IsPayVerify);
//
//      { #2 Pay Periods (Pay Multiple Weeks In One Pay }
//      dNormalTax := dNormalTax * Tpaybase(Self.Owner).Payperiods;
//
//      if qry.FieldByName('PrimaryTax').AsBoolean then begin
//        { Extra Tax }
//        { Only apply Extra tax to primay tax }
//        if FindInSet(Trim(Tpaybase(Self.Owner).EmployeeDetails.ExtraTaxOptions), '$') then begin
//          dNormalTax := dNormalTax + Tpaybase(Self.Owner).EmployeeDetails.ExtraTax;
//        end
//        else if FindInSet(Trim(Tpaybase(Self.Owner).EmployeeDetails.ExtraTaxOptions), '%') then begin
//          dNormalTax := dNormalTax + (dNormalTax * Tpaybase(Self.Owner).EmployeeDetails.ExtraTax / 100);
//        end
//        else if FindInSet(Trim(Tpaybase(Self.Owner).EmployeeDetails.ExtraTaxOptions), 'Fixed') then begin
//          dNormalTax := Tpaybase(Self.Owner).EmployeeDetails.ExtraTax;
//        end;
//      end;
//
//      Tpaybase(Self.Owner).PayTotals.TaxableTotals.TaxList.AddItem(qry.FieldByName('PayTaxConfigId').AsInteger, dNormalTax, qry.FieldByName('TaxType').AsString);
//      dNormalTaxTotal := dNormalTaxTotal + dNormalTax;
//
//      qry.Next;
//    end;
//
//    { Commission Tax }
//    Tpaybase(Self.Owner).PayCommissions.CalcTax;
//
//    for x := 0 to Tpaybase(Self.Owner).PayTotals.TaxableTotals.TaxList.Count -1 do begin
//      taRec := Tpaybase(Self.Owner).PayTotals.TaxableTotals.TaxList[x];
//      if qry.Locate('PayTaxConfigId',taRec.PayTaxConfigId,[]) then begin
//        if qry.FieldByName('RoundTax').AsBoolean then
//          { round to whole dollars }
//          taRec.TaxAmount := CommonLib.Round(taRec.TaxAmount,0);
//      end;
////      result := result + taRec.TaxAmount;
//    end;
//
//    { now split the tax up between taxable totals  }
//    for x := 0 to Tpaybase(Self.Owner).PayTotals.TaxableTotals.TaxList.Count -1 do begin
//      taRec := Tpaybase(Self.Owner).PayTotals.TaxableTotals.TaxList[x];
//      taxAmount := taRec.TaxAmount;
//      for y := 0 to Tpaybase(Self.Owner).PayTotals.TaxableTotals.Count -1 do begin
//        ttRec := Tpaybase(Self.Owner).PayTotals.TaxableTotals[y];
//        taSubRec := ttRec.TaxList.ItemByTaxConfigId(taRec.PayTaxConfigId);
//        if not Assigned(taSubRec) then
//          taSubRec := ttRec.TaxList.AddItem(taRec.PayTaxConfigId,0,taRec.TaxType);
//
//
//        if y < Tpaybase(Self.Owner).PayTotals.TaxableTotals.Count -1 then begin
//          taSubRec.TaxAmount := Round(ttRec.AmountFraction * taRec.TaxAmount,2);
//          taxAmount := taxAmount - taSubRec.TaxAmount;
//        end
//        else begin
//          { last record, allocate the rest  }
//          taSubRec.TaxAmount := taxAmount;
//        end;
//        if taSubRec.TaxType = 'Employee' then
//          result := result + taSubRec.TaxAmount;
//      end;
//    end;
//
//    Result := result + dHECSAmount + dSFSSAmount - dCDEPTaxReduction;
//
//    if AppEnv.RegionalOptions.RegionType = rAust then begin
//
//      { ATO requires that tax is rounded to nearest dollar }
//      Result := CommonLib.Round(Result, 0);
//    end;
//  finally
//    DbSharedObj.ReleaseObj(qry);
//  end;
//end;

class function TTaxBase.GetBusObjectTablename: string;
begin
  Result := '';
end;

class function TTaxBase.GetIDField: String;
begin
  Result := ''
end;

initialization

RegisterClassOnce(TTaxBase);

end.
