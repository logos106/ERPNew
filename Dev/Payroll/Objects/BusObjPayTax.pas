                                                                                                                                                        unit BusObjPayTax;

interface

uses
  BusObjBase, Classes, ERPDbComponents;

type
  TPayTax = class(TMSBusObj)
  private
    qryPercent: TERPQuery;
    dDeduct: Double;

    function CDEPTaxReductionAmount(Const WeeklyCDEPAmount: Double): Integer;

    function GetAmount: double;
    function GetPayId: integer;
    function GetPayTaxConfigId: integer;
    function GetMSType: string;
    function GetPayLineId: integer;
//    function AdjustWage(ATaxGroup: string; ATaxType: string; AWeeklyWage: Double;
//                          AAllowanceQty: Integer; AAllowanceAmount: Double; APay: TPayBase; APeriods: Integer) : Double;
    procedure SetAmount(const Value: double);
    procedure SetPayId(const Value: integer);
    procedure SetPayTaxConfigId(const Value: integer);
    procedure SetMSType(const Value: string);
    procedure SetPayLineId(const Value: integer);

    procedure CallBackAdjustFederal(const Sender: TBusObj; var Abort: Boolean);
    procedure CallBackAdjustState(const Sender: TBusObj; var Abort: Boolean);
    procedure CallBackAdjustSocial(const Sender: TBusObj; var Abort: Boolean);
    procedure CallBackAdjustMedicare(const Sender: TBusObj; var Abort: Boolean);

  protected
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    procedure CalculateTax;
    function TotlEmployeeTaxForPayPayRate(PayPayRateId: integer): double;

  published
    property PayId: integer read GetPayId write SetPayId;
    property PayTaxConfigId: integer read GetPayTaxConfigId write SetPayTaxConfigId;
    property Amount: double read GetAmount write SetAmount;
    property MSType: string read GetMSType write SetMSType;
    property PayLineId: integer read GetPayLineId write SetPayLineId;

  end;

implementation

uses
  DbSharedObjectsObj, PayTaxableTotalObj, CommonDbLib, SysUtils, AppenVironment, CommonLib, PayCommon, tcTypes, BusObjFormW4,
  BusObjPaysDeductions, BusObjPayBase;

{ TPayTax }

procedure TPayTax.CallBackAdjustFederal(const Sender: TBusObj; var Abort: Boolean);
var
  Deduction: TPaysDeductions;
begin
  Deduction := TPaysDeductions(Sender);
  if not Deduction.Taxexempt and Deduction.TaxExemptFederal then begin
    dDeduct := dDeduct + Deduction.Amount;   // Add again because the deduction was wrong
  end;
end;

procedure TPayTax.CallBackAdjustState(const Sender: TBusObj; var Abort: Boolean);
var
  Deduction: TPaysDeductions;
begin
  Deduction := TPaysDeductions(Sender);
  if not Deduction.Taxexempt and Deduction.TaxexemptState then begin
    dDeduct := dDeduct + Deduction.Amount;   // Add again because the deduction was wrong
  end;
end;

procedure TPayTax.CallBackAdjustSocial(const Sender: TBusObj; var Abort: Boolean);
var
  Deduction: TPaysDeductions;
begin
  Deduction := TPaysDeductions(Sender);
  if not Deduction.Taxexempt and Deduction.TaxexemptSocial then begin  // neither Both nor State
    dDeduct := dDeduct + Deduction.Amount;   // Add again because the deduction was wrong
  end;
end;

procedure TPayTax.CallBackAdjustMedicare(const Sender: TBusObj; var Abort: Boolean);
var
  Deduction: TPaysDeductions;
begin
  Deduction := TPaysDeductions(Sender);
  if not Deduction.Taxexempt and Deduction.TaxexemptMedicare then begin
    dDeduct := dDeduct + Deduction.Amount;   // Add again because the deduction was wrong
  end;
end;

procedure TPayTax.CalculateTax;
var
  Pay: TPayBase;
  dNormalTax,
  dHECSAmount,
  dSFSSAmount,
  dWeeklyTaxableGross,
  dWeeklyTaxableGrossNoCommission,
  dWeeklyTaxableCDEP,
  dTaxable,
  dAllowance,
  dMin, dMax, dPercent,
  dCDEPTaxReduction: Double;
  qry : TERPQuery;
  x, y, scaleID: integer;
  taRec, taSubRec: TTaxAmount;
  ttRec: TTaxableTotal;
  taxAmount: Double;
  TotalTaxEmp, TotalTaxCo: Double;
  varGross, varA, varC, varD: Double;
  nPeriods: Integer;
  sGroupType: string;
  sTaxType: string;

  function AdjustWage(ATaxGroup: string; ATaxType: string; AWeeklyWage: Double;
                      AAllowanceQty: Integer; AAllowanceAmount: Double; APay: TPayBase; APeriods: Integer) : Double;
  var
    dTaxable : Double;
    dAllowance, dMin, dMax, dPercent : Double;
    qry2 : TERPQuery;
    nPeriod : Integer;
    W4 : TFormW4;
    bEmpty : Boolean;
  begin
    dTaxable := AWeeklyWage;

    // Adjust taxable for individual tax exampt deducitons
    if (ATaxGroup = 'Federal') and (ATaxType = 'Employee') then begin
      dDeduct := 0.0;
      APay.PayDeductions.IterateRecords(CallBackAdjustFederal, False);
      dTaxable := AWeeklyWage - dDeduct;
    end;

    if (ATaxGroup = 'State') and (ATaxType = 'Employee') then begin
      dDeduct := 0.0;
      APay.PayDeductions.IterateRecords(CallBackAdjustState, False);
      dTaxable := AWeeklyWage - dDeduct;
    end;

    if (ATaxGroup = 'SocialSecurity') and (ATaxType = 'Employee') then begin
      dDeduct := 0.0;
      APay.PayDeductions.IterateRecords(CallBackAdjustSocial, False);
      dTaxable := AWeeklyWage - dDeduct;
    end;

    if (ATaxGroup = 'Medicare') and (ATaxType = 'Employee') then begin
      dDeduct := 0.0;
      APay.PayDeductions.IterateRecords(CallBackAdjustMedicare, False);
      dTaxable := AWeeklyWage - dDeduct;
    end;

    // Adjust taxable for allowances
    if (ATaxGroup = 'State') and (ATaxType = 'Employee') then begin
      dTaxable := dTaxable * 52;

      qry2 := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
      qry2.SQL.Add('SELECT PayPeriod, A, B, C FROM tblTaxable WHERE PayPeriod = "Annually"');
      qry2.Open;

      // Standard deduction
      bEmpty := qry2.IsEmpty;
      if not bEmpty then begin
        dPercent := AppEnv.CompanyPrefs.TaxableDeduction;
        dMin := qry2.FieldByName('B').AsFloat;
        dMax := qry2.FieldByName('C').AsFloat;
        if (dTaxable * dPercent < dMin) then
          dTaxable := dTaxable - dMin
        else if (dTaxable * dPercent > dMax) then
          dTaxable := dTaxable - dMax;

        dAllowance := AAllowanceQty * qry2.FieldByName('A').AsFloat;
      end;

      // Exemption
      dTaxable := dTaxable - dAllowance;

      qry2.Close;

      dTaxable := dTaxable / 52;
    end;

    // Federal tax
    if (ATaxGroup = 'Federal') and (ATaxType = 'Employee') then begin
      // Step 1-1
      dTaxable := dTaxable * 52;

      W4 := TFormW4.Create(nil);
      W4.LoadSelect('EmployeeID=' + IntToStr(APay.EmployeeID));
      if W4.Count > 0 then begin  // Submitted Form W-4 2020 or later
        // Step 1-2
        dTaxable := dTaxable + W4.OtherIncome;   // W-4 4(a)

        // Step 1-3
        dTaxable := dTaxable - W4.Deductions;    // W-4 4(b)
        if not W4.HaveMultipleJobs then begin
          if W4.TaxReportingType = 'B' then // Married filing jointly
            dTaxable := dTaxable - 12900
          else
            dTaxable := dTaxable - 8600
        end;
      end else                       // Not submitted Form W-4 2020 or later
        dTaxable := dTaxable -  AAllowanceQty * 4300;

      // Fill in the percentage table
      with qryPercent do begin
        SQL.Clear;
        SQL.Add('SELECT * FROM tblPaysPercentage');
        SQL.Add('WHERE PayID=' + IntToStr(APay.PayID));
        Open;

        bEmpty := IsEmpty;
        if bEmpty then begin
          Append;
          FieldByName('PayID').AsInteger := APay.PayID;
        end
        else
          Edit;

        FieldByName('F1A').AsFloat := AWeeklyWage;

        FieldByName('F1B').AsFloat := APeriods;

        FieldByName('F1C').AsFloat := AWeeklyWage * APeriods;

        if W4.Count > 0 then begin
          FieldByName('F1D').AsFloat := W4.OtherIncome;

          FieldByName('F1E').AsFloat := FieldByName('F1C').AsFloat + FieldByName('F1D').AsFloat;

          FieldByName('F1F').AsFloat := W4.Deductions;

          if not W4.HaveMultipleJobs then begin
            if W4.TaxReportingType = 'B' then // Married filing jointly
              FieldByName('F1G').AsFloat := 12900
            else
              FieldByName('F1G').AsFloat := 8600
          end;

          FieldByName('F1H').AsFloat := FieldByName('F1F').AsFloat + FieldByName('F1G').AsFloat;

          FieldByName('F1I').AsFloat := FieldByName('F1E').AsFloat - FieldByName('F1H').AsFloat;
          if FieldByName('F1I').AsFloat < 0 then
            FieldByName('F1I').AsFloat := 0;

          FieldByName('F3A').AsFloat := W4.Dependent;
          FieldByName('F3B').AsFloat := RoundCurrency(DivZer(FieldByName('F3A').AsFloat, FieldByName('F1B').AsFloat));
          FieldByName('F3C').AsFloat := FieldByName('F2H').AsFloat - FieldByName('F3B').AsFloat;
          if FieldByName('F3C').AsFloat < 0 then
            FieldByName('F3C').AsFloat := 0;

          FieldByName('F4A').AsFloat := W4.ExtraWithholding;
          FieldByName('F4B').AsFloat := FieldByName('F3C').AsFloat + FieldByName('F4A').AsFloat;

        end
        else begin
          FieldByName('F1J').AsFloat := AAllowanceQty;

          FieldByName('F1K').AsFloat := AAllowanceQty * 4300;

          FieldByName('F1L').AsFloat := FieldByName('F1C').AsFloat - FieldByName('F1K').AsFloat;
          if FieldByName('F1L').AsFloat < 0 then
            FieldByName('F1L').AsFloat := 0;

          FieldByName('F3A').AsFloat := 0;
          FieldByName('F3B').AsFloat := 0;
          FieldByName('F3C').AsFloat := 0;

          FieldByName('F4A').AsFloat := APay.EmployeePaySettings.NonWageIncome;
          FieldByName('F4B').AsFloat := FieldByName('F4A').AsFloat;
        end;

        Post;
        Close;
      end;

      W4.Destroy;

      dTaxable := dTaxable / 52;
    end;

    if ATaxGroup = 'SocialSecurity' then begin

    end;

    if ATaxGroup = 'Medicare' then begin

    end;

    if dTaxable < 0 then dTaxable := 0;
    Result := RoundCurrency(dTaxable);

  end;

begin
  if (not Assigned(Owner)) or (not (Owner is TPayBase)) then Exit;
  Pay := TPayBase(Owner);

  Self.DeleteAll;

  { Manual Tax Does Not ReCalc Tax Amount }
  dHECSAmount := 0.00;
  dSFSSAmount := 0.00;
  dWeeklyTaxableGross := 0.00;
  dWeeklyTaxableGrossNoCommission := 0.00;
  dWeeklyTaxableCDEP := 0.00;
  TotalTaxEmp := 0;
  TotalTaxCo := 0;
  Pay.PayTotals.TaxableTotals.ClearAllTax;

  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    { Set TaxExempt field as false for deductions in case of USA }
    if AppEnv.RegionalOptions.RegionType = rUSA then begin
      qry.SQL.Add('UPDATE tblDeductions SET TaxExempt="F";');
      qry.SQL.Add('UPDATE tblEmployeeDeductions SET TaxExempt="F";');
      qry.SQL.Add('UPDATE tblPaysDeductions SET TaxExempt="F";');
      qry.Execute;
    end;

    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tblPayTaxConfig c');
    qry.SQL.Add('LEFT JOIN tblPayTaxScaleConfig sc ON c.ID = sc.PayTaxConfigId');
    qry.SQL.Add('WHERE c.RegionId = ' + IntToStr(AppEnv.RegionalOptions.Id));
    qry.SQL.Add('AND c.Active = "T"');
//    qry.SQL.Add('AND sc.TaxScaleId > 0');
    qry.SQL.Add('AND sc.EmployeeId = ' + IntToStr(Pay.EmployeeId));
    qry.Open;

    // Calc the weekly equivalent gross
    nPeriods := 4; // Quarterly
    if Trim(Pay.EmployeePaySettings.PayPeriod) = 'Fortnightly' then begin
      dWeeklyTaxableGross := Trunc((Pay.PayTotals.GrossTaxable) / 2);
      if AppEnv.RegionalOptions.RegionType = rAust then begin
        dWeeklyTaxableGrossNoCommission := Trunc((Pay.PayTotals.GrossTaxable - Pay.PayCommissions.TotalBeforeTax) / 2);
        dWeeklyTaxableCDEP := Trunc((Pay.PayTotals.GrossCDEP) / 2);
      end
      else begin
        { don't trunc or round }
        dWeeklyTaxableGrossNoCommission := ((Pay.PayTotals.GrossTaxable - Pay.PayCommissions.TotalBeforeTax) / 2);
        dWeeklyTaxableCDEP := (Pay.PayTotals.GrossCDEP / 2);
      end;

      nPeriods := 24;
    end
    else if Trim(Pay.EmployeePaySettings.PayPeriod) = 'Monthly' then begin
      if system.Round(Frac(Pay.PayTotals.GrossTaxable) * 100) = 33 then begin
        dWeeklyTaxableGross := ((Pay.PayTotals.GrossTaxable) + 0.01) * 3 / 13;
        dWeeklyTaxableCDEP := ((Pay.PayTotals.GrossCDEP) + 0.01) * 3 / 13;
      end
      else begin
        dWeeklyTaxableGross := (Pay.PayTotals.GrossTaxable) * 3 / 13;
        dWeeklyTaxableCDEP := (Pay.PayTotals.GrossCDEP) * 3 / 13;
      end;

      if system.Round(Frac(Pay.PayTotals.GrossTaxable - Pay.PayCommissions.TotalBeforeTax) * 100) = 33 then
        dWeeklyTaxableGrossNoCommission := ((Pay.PayTotals.GrossTaxable - Pay.PayCommissions.TotalBeforeTax) + 0.01) * 3 / 13
      else
        dWeeklyTaxableGrossNoCommission := (Pay.PayTotals.GrossTaxable - Pay.PayCommissions.TotalBeforeTax) * 3 / 13;

      nPeriods := 12;
    end
    else if Trim(Pay.EmployeePaySettings.PayPeriod) = 'Bi-Monthly' then begin
      if Trunc(Frac((Pay.PayTotals.GrossTaxable)) * 100) = 33 then begin
        dWeeklyTaxableGross :=
          (((Pay.PayTotals.GrossTaxable - Pay.PayCommissions.TotalBeforeTax) + 0.01) * 3 / 13) * 2;
        dWeeklyTaxableCDEP := (((Pay.PayTotals.GrossCDEP) + 0.01) * 3 / 13) * 2;
      end
      else begin;
        dWeeklyTaxableGross := ((Pay.PayTotals.GrossTaxable - Pay.PayCommissions.TotalBeforeTax) * 3 / 13) * 2;
        dWeeklyTaxableCDEP := ((Pay.PayTotals.GrossCDEP) * 3 / 13) * 2;
      end;

      if Trunc(Frac((Pay.PayTotals.GrossTaxable - Pay.PayCommissions.TotalBeforeTax)) * 100) = 33 then
        dWeeklyTaxableGrossNoCommission :=
          (((Pay.PayTotals.GrossTaxable - Pay.PayCommissions.TotalBeforeTax) + 0.01) * 3 / 13) * 2
      else
        dWeeklyTaxableGrossNoCommission :=
          ((Pay.PayTotals.GrossTaxable - Pay.PayCommissions.TotalBeforeTax) * 3 / 13) * 2;

      nPeriods := 6;
    end
    else if Trim(Pay.EmployeePaySettings.PayPeriod) = 'Weekly' then begin
      dWeeklyTaxableGross := (Pay.PayTotals.GrossTaxable - Pay.PayCommissions.TotalBeforeTax);
      dWeeklyTaxableCDEP := Pay.PayTotals.GrossCDEP;
      dWeeklyTaxableGrossNoCommission := (Pay.PayTotals.GrossTaxable - Pay.PayCommissions.TotalBeforeTax);

      nPeriods := 52;
    end;

    { #1 Pay Periods (Pay Multiple Weeks In One Pay }
    dWeeklyTaxableGross := DivZer(dWeeklyTaxableGross, Pay.PayPeriods);
    dWeeklyTaxableCDEP := DivZer(dWeeklyTaxableCDEP, Pay.PayPeriods);
    dWeeklyTaxableGrossNoCommission := DivZer(dWeeklyTaxableGrossNoCommission, Pay.Payperiods);

    dCDEPTaxReduction := CDEPTaxReductionAmount(dWeeklyTaxableCDEP);

    if Pay.EmployeeDetails.HecsIndicator then begin
      dHECSAmount := GetTaxComponent(Pay.EmployeeDetails.HecsTaxScale,
        dWeeklyTaxableGross, Trim(Pay.EmployeePaySettings.PayPeriod),
        Pay.IsPayVerify);
    end;

    if Pay.EmployeeDetails.StudentLoanIndicator then begin
      dSFSSAmount := GetTaxComponent(Pay.EmployeeDetails.StudentLoanTaxScale,
        dWeeklyTaxableGross, Trim(Pay.EmployeePaySettings.PayPeriod),
        Pay.IsPayVerify);
    end;

    { #2 Pay Periods (Pay Multiple Weeks In One Pay }
    dHECSAmount := dHECSAmount * Pay.PayPeriods;
    dSFSSAmount := dSFSSAmount * Pay.PayPeriods;
    dCDEPTaxReduction := dCDEPTaxReduction * Pay.PayPeriods;

//    qry.First;
    while not qry.EOF do begin
      if qry.FieldByName('PrimaryTax').AsBoolean and Pay.Manualtax then begin
        dNormalTax := Pay.Tax;
      end
      else begin
        // TaxScale ID
        scaleID := qry.FieldByName('TaxScaleId').AsInteger;
        if scaleID = 0 then begin     // If tax scale is not specified, then skip
          qry.Next;
          Continue
        end;

        if AppEnv.RegionalOptions.RegionType = rUSA then begin  // USA
          sGroupType := qry.FieldByName('GroupType').AsString;
          sTaxType := qry.FieldByName('TaxType').AsString;
          dTaxable := AdjustWage(sGroupType, sTaxType,
                                  dWeeklyTaxableGrossNoCommission,
                                  qry.FieldByName('AllowanceQty').AsInteger,
                                  qry.FieldByName('AllowanceAmount').AsFloat,
                                  Pay, nPeriods);

          // Save the taxable wages
          if (sGroupType = 'Federal') and (sTaxType = 'Employee') then
            Pay.PayTotals.FITWages := dTaxable;

          if sGroupType = 'SocialSecurity' then
            Pay.PayTotals.SocWages := dTaxable;

          if sGroupType = 'Medicare' then
            Pay.PayTotals.MedWages := dTaxable;

          if (sGroupType = 'State') and (sTaxType = 'Employee') then
            Pay.PayTotals.StateWages := dTaxable;

          // Calculate all the tax
          dNormalTax := GetTaxComponentUSA(scaleID, dTaxable, Pay.Employeeid, qry.FieldByName('GroupType').AsString,
                                            qry.FieldByName('TaxType').AsString,
                                            Trim(Pay.EmployeePaySettings.PayPeriod),
                                            varGross, varA, varD, varD);

          // Fill in the percentage table
          with qryPercent do begin
            SQL.Clear;
            SQL.Add('SELECT * FROM tblPaysPercentage');
            SQL.Add('WHERE PayID=' + IntToStr(Pay.PayID));
            Open;

            if not IsEmpty then begin
              Edit;
              FieldByName('F2A').AsFloat := varGross;
              FieldByName('F2B').AsFloat := varA;
              FieldByName('F2C').AsFloat := varC;
              FieldByName('F2D').AsFloat := varD * 100;
              FieldByName('F2E').AsFloat := varGross - varA;
              FieldByName('F2F').AsFloat := (varGross - varA) * varD;
              FieldByName('F2G').AsFloat := varC + (varGross - varA) * varD;
              FieldByName('F2H').AsFloat := RoundCurrency(DivZer(FieldByName('F2G').AsFloat, FieldByName('F1B').AsFloat));
              Post;
              Close;
            end;
          end;
        end
        else begin    // Other countries
          dTaxable := dWeeklyTaxableGrossNoCommission;
          dAllowance := qry.FieldByName('AllowanceQty').AsInteger * qry.FieldByName('AllowanceAmount').AsFloat;

          dNormalTax := GetTaxComponent(scaleID, dTaxable, Trim(Pay.EmployeePaySettings.PayPeriod),
                                        Pay.IsPayVerify, dAllowance, Pay.EmployeeId);
        end;

        { #2 Pay Periods (Pay Multiple Weeks In One Pay }
        dNormalTax := dNormalTax * Pay.PayPeriods;

        if qry.FieldByName('PrimaryTax').AsBoolean then begin
          { Extra Tax }
          { Only apply Extra tax to primay tax }
          if FindInSet(Trim(Pay.EmployeeDetails.ExtraTaxOptions), '$') then
            dNormalTax := dNormalTax + Pay.EmployeeDetails.ExtraTax
          else if FindInSet(Trim(Pay.EmployeeDetails.ExtraTaxOptions), '%') then
            dNormalTax := dNormalTax + (dNormalTax * Pay.EmployeeDetails.ExtraTax / 100)
          else if FindInSet(Trim(Pay.EmployeeDetails.ExtraTaxOptions), 'Fixed') then
            dNormalTax := Pay.EmployeeDetails.ExtraTax;

          { Australian stuff .. only one tax scale, adjust for HECS, SFSS and CDEP }
          dNormalTax := dNormalTax + dHECSAmount + dSFSSAmount - dCDEPTaxReduction;
        end;
      end;

      Pay.PayTotals.TaxableTotals.TaxList.AddItem(qry.FieldByName('PayTaxConfigId').AsInteger, dNormalTax, qry.FieldByName('TaxType').AsString);

      qry.Next;
    end;

    { Commission Tax }
    Pay.PayCommissions.CalcTax;

    for x := 0 to Pay.PayTotals.TaxableTotals.TaxList.Count - 1 do begin
      taRec := Pay.PayTotals.TaxableTotals.TaxList[x];
      if qry.Locate('PayTaxConfigId', taRec.PayTaxConfigId, []) then begin
        if qry.FieldByName('RoundTax').AsBoolean then
          { round to whole dollars }
          taRec.TaxAmount := CommonLib.Round(taRec.TaxAmount, 0);
      end;
//      result := result + taRec.TaxAmount;
    end;

    { Now split the tax up between taxable totals  }
    for x := 0 to Pay.PayTotals.TaxableTotals.TaxList.Count - 1 do begin
      taRec := Pay.PayTotals.TaxableTotals.TaxList[x];
      taxAmount := taRec.TaxAmount;
      for y := 0 to Pay.PayTotals.TaxableTotals.Count - 1 do begin
        ttRec := Pay.PayTotals.TaxableTotals[y];
        taSubRec := ttRec.TaxList.ItemByTaxConfigId(taRec.PayTaxConfigId);
        if not Assigned(taSubRec) then
          taSubRec := ttRec.TaxList.AddItem(taRec.PayTaxConfigId, 0, taRec.TaxType);

        if y < Pay.PayTotals.TaxableTotals.Count - 1 then begin
          taSubRec.TaxAmount := Round(ttRec.AmountFraction * taRec.TaxAmount, 2);
          taxAmount := taxAmount - taSubRec.TaxAmount;
        end
        else begin
          { last record, allocate the rest  }
          taSubRec.TaxAmount := taxAmount;
        end;

        if taSubRec.TaxType = 'Employee' then
          TotalTaxEmp := TotalTaxEmp + taSubRec.TaxAmount
        else
          TotalTaxCo := TotalTaxCo + taSubRec.TaxAmount;
      end;
    end;

    if AppEnv.RegionalOptions.RegionType = rAust then begin
      { ATO requires that tax is rounded to nearest dollar }
      TotalTaxEmp := CommonLib.Round(TotalTaxEmp, 0);
    end;

    Pay.PayTotals.Tax := TotalTaxEmp;
    Pay.PayTotals.CompanyTax := TotalTaxCo;

    { create the db records }
    for x := 0 to Pay.PayTotals.TaxableTotals.Count - 1 do begin
      ttRec := Pay.PayTotals.TaxableTotals[x];
      for y := 0 to ttRec.TaxList.Count - 1 do begin
        taRec := ttRec.TaxList[y];
        self.New;
        self.PayId := Pay.PayID;
        self.PayTaxConfigId := taRec.PayTaxConfigId;
        self.Amount := taRec.TaxAmount;
        self.MSType := ttRec.MSType;
        self.PayLineId := ttRec.PayLineId;
        self.PostDb;
      end;
    end;

  finally
    DbSharedObj.ReleaseObj(qry);
  end;

end;

function TPayTax.CDEPTaxReductionAmount(const WeeklyCDEPAmount: Double): Integer;
begin
  Result := Trunc((WeeklyCDEPAmount - 115) / 6);
  { was going to make 115 a payroll pref but didn't as it
    has not changed since 2004 }
  If Result < 0 then
    Result := 0;
end;

constructor TPayTax.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  fBusObjectTypeDescription := 'PayTax';
  fSQL := 'SELECT * FROM tblpaytax';

  qryPercent := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
end;

destructor TPayTax.Destroy;
begin
  inherited;

  qryPercent.Close;
end;

function TPayTax.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  if Assigned(Owner) and (Owner is TPayBase) then
    PayId := TPayBase(Owner).PayID;
end;

function TPayTax.GetAmount: double;
begin
  result := GetFloatField('Amount');
end;

class function TPayTax.GetBusObjectTablename: string;
begin
  result := 'tblpaytax';
end;

class function TPayTax.GetIDField: string;
begin
  result := 'Id';
end;

function TPayTax.GetMSType: string;
begin
  result := GetStringField('MSType');
end;

function TPayTax.GetPayLineId: integer;
begin
  result := GetIntegerField('PayLineId');
end;

function TPayTax.GetPayId: integer;
begin
  result := GetIntegerField('PayId');
end;

function TPayTax.GetPayTaxConfigId: integer;
begin
  result := GetIntegerField('PayTaxConfigId');
end;

procedure TPayTax.SetAmount(const Value: double);
begin
  SetFloatField('Amount', Value);
end;

procedure TPayTax.SetMSType(const Value: string);
begin
  SetStringField('MSType', Value);
end;

procedure TPayTax.SetPayLineId(const Value: integer);
begin
  SetIntegerField('PayLineId', Value);
end;

procedure TPayTax.SetPayId(const Value: integer);
begin
  SetIntegerField('PayId', Value);
end;

procedure TPayTax.SetPayTaxConfigId(const Value: integer);
begin
  SetIntegerField('PayTaxConfigId', Value);
end;

function TPayTax.TotlEmployeeTaxForPayPayRate(PayPayRateId: integer): double;
var
  qry: TERPQuery;
begin
  qry := DbSharedObj.GetQuery(Connection.Connection);
  try
    qry.SQL.Add('SELECT SUM(Amount) AS Amount');
    qry.SQL.Add('FROM tblpaytax');
    qry.SQL.Add('INNER JOIN tblpaytaxconfig ON tblpaytaxconfig.ID = tblpaytax.PayTaxConfigId AND tblpaytaxconfig.TaxType = "Employee"');
    qry.SQL.Add('WHERE PayLineId = ' + IntToStr(PayPayRateId));
    qry.Open;

    Result := qry.FieldByName('Amount').AsFloat;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

end.
