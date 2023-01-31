unit PayObj;

interface

uses
  Classes, DB, PayEmployeeObj, PayPayRatesObj, PayDeductionsObj, PayAllowancesObj,
  PaySundriesObj, PayCommissionObj, PaySuperannuationObj, PayLeaveObj, kbmMemTable, PayDataXML,
  PayPaySplitsObj,PaySplitObj;

type
  TPayTotals = class(TObject)
  private
    foOwner: TObject;
    fdWages: double;
    fdWagesIncludedInSuper: double;
    fdAllowancesBeforeTax: double;
    fdAllowancesAfterTax: double;
    fdAllowancesIncludedInSuper: double;
    fdAllowances: double;
    fdSundriesBeforeTax: double;
    fdSundriesAfterTax: double;
    fdSundries: double;
    fdCommissionBeforeTax: double;
    fdCommissionAfterTax: double;
    fdCommissionIncludedInSuper: double;
    fdCommission: double;
    fdSuperannuation: double;
    fdDeductionBeforeTax: double;
    fdDeductionAfterTax: double;
    fdDeduction: double;
    fdGross: double;
    fdGrossTaxable: double;
    fdGrossCDEP: double;
    fdTax: double;
    fdNet: double;

    {YTD Totals}
    fdYTDWages: double;
    fdYTDAllowances: double;
    fdYTDSundries: double;
    fdYTDCommission: double;
    fdYTDSuperannuation: double;
    fdYTDDeduction: double;
    fdYTDGrossTaxable: double;
    fdYTDGross: double;
    fdYTDTax: double;
    fdYTDNet: double;
    fmtTaxableTotals: TkbmMemTable;
    procedure SetupTaxableTotalsMemTable;
  public
    constructor Create(const Owner: TObject);
    destructor Destroy; override;
    procedure Tax_PostToAccounts;
    property Owner: TObject read foOwner;
    property TaxableTotals: TkbmMemTable read fmtTaxableTotals;
    property Wages: double read fdWages write fdWages;
    property WagesIncludedInSuper: double read fdWagesIncludedInSuper write fdWagesIncludedInSuper;
    property AllowancesBeforeTax: double read fdAllowancesBeforeTax write fdAllowancesBeforeTax;
    property AllowancesAfterTax: double read fdAllowancesAfterTax write fdAllowancesAfterTax;
    property AllowancesIncludedInSuper: double read fdAllowancesIncludedInSuper write fdAllowancesIncludedInSuper;
    property Allowances: double read fdAllowances write fdAllowances;
    property SundriesBeforeTax: double read fdSundriesBeforeTax write fdSundriesBeforeTax;
    property SundriesAfterTax: double read fdSundriesAfterTax write fdSundriesAfterTax;
    property Sundries: double read fdSundries write fdSundries;
    property CommissionBeforeTax: double read fdCommissionBeforeTax write fdCommissionBeforeTax;
    property CommissionAfterTax: double read fdCommissionAfterTax write fdCommissionAfterTax;
    property CommissionIncludedInSuper: double read fdCommissionIncludedInSuper write fdCommissionIncludedInSuper;
    property Commission: double read fdCommission write fdCommission;
    property Superannuation: double read fdSuperannuation write fdSuperannuation;
    property DeductionBeforeTax: double read fdDeductionBeforeTax write fdDeductionBeforeTax;
    property DeductionAfterTax: double read fdDeductionAfterTax write fdDeductionAfterTax;
    property Deduction: double read fdDeduction write fdDeduction;
    property Gross: double read fdGross write fdGross;
    property GrossTaxable: double read fdGrossTaxable write fdGrossTaxable;
    property GrossCDEP: double read fdGrossCDEP write fdGrossCDEP;
    property Tax: double read fdTax write fdTax;
    property Net: double read fdNet write fdNet;
    property YTDWages: double read fdYTDWages write fdYTDWages;
    property YTDAllowances: double read fdYTDAllowances write fdYTDAllowances;
    property YTDSundries: double read fdYTDSundries write fdYTDSundries;
    property YTDCommission: double read fdYTDCommission write fdYTDCommission;
    property YTDSuperannuation: double read fdYTDSuperannuation write fdYTDSuperannuation;
    property YTDDeduction: double read fdYTDDeduction write fdYTDDeduction;
    property YTDGross: double read fdYTDGross write fdYTDGross;
    property YTDGrossTaxable: double read fdYTDGrossTaxable write fdYTDGrossTaxable;
    property YTDTax: double read fdYTDTax write fdYTDTax;
    property YTDNet: double read fdYTDNet write fdYTDNet;

  end;

type
  TPayObj = class(TObject)
  private
    fiPayID: integer;
    fiPayVersion: integer;
    fiPayPeriods: integer;
    fdtPayDate: TDateTime;
    fdtDatePaid: TDateTime;
    fbPaid: boolean;
    fdtPayStartPeriod: TDateTime;
    fdtPayEndPeriod: TDateTime;
    //FPayPreferences: TPayPreferencesObj;
    FEmployee: TPayEmployeeObj;
    FPayTotals: TPayTotals;
    FPayRates: TPayRatesObj;
    FDeductions: TDeductionsObj;
    FAllowances: TAllowancesObj;
    FSundries: TSundriesObj;
    FCommission: TCommissionObj;
    FSuperannuation: TSuperannuationObj;
    FLeave: TLeaveObj;
    FDataXML: TDataXMLObj;
    FDSPay: TDataset;
    fbManualTax: boolean;
    fbIsPayVerify: Boolean;
    FPayPaySplits: TPayPaySplitsObj;
    FPaySplit: TPaySplitObj;
    fbIsTerminationPay: Boolean;
    procedure RecalcAll;
    procedure SetPayTotals(const RefreshYTDTotals: boolean = true);
    function CalcTax: double;
    Function CDEPTaxReductionAmount(Const WeeklyCDEPAmount:Double):Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure PopulateMe;    
    procedure Recalc;
    procedure Delete;
    procedure UnDelete;
    procedure PostToAccounts;
    property DataSet: TDataset read FDSPay write FDSPay;
    property PayID: integer read fiPayID;
    property PayVersion: integer read fiPayVersion;
    property PayDate: TDateTime read fdtPayDate;
    property DatePaid: TDateTime read fdtDatePaid;
    property Paid: boolean read fbPaid;
    property PayPeriods: integer read fiPayPeriods;
    property StartPayPeriod: TDateTime read fdtPayStartPeriod;
    property EndPayPeriod: TDateTime read fdtPayEndPeriod;
    //property PayPreferences: TPayPreferencesObj read FPayPreferences;
    property Employee: TPayEmployeeObj read FEmployee;
    property PayTotals: TPayTotals read FPayTotals;
    property PayRates: TPayRatesObj read FPayRates;
    property Allowances: TAllowancesObj read FAllowances;
    property Deductions: TDeductionsObj read FDeductions;
    property Sundries: TSundriesObj read FSundries;
    property Commission: TCommissionObj read FCommission;
    property Superannuation: TSuperannuationObj read FSuperannuation;
    property Leave: TLeaveObj read FLeave;
    property ManualTax: boolean read fbManualTax write fbManualTax;
    property DataXML: TDataXMLObj read FDataXML;
    property IsPayVerify: Boolean read fbIsPayVerify  write fbIsPayVerify;
    property PayPaySplits: TPayPaySplitsObj read FPayPaySplits;
    property PaySplit: TPaySplitObj read FPaySplit;
    property IsTerminationPay: Boolean read fbIsTerminationPay write fbIsTerminationPay;
  end;

implementation

uses FastFuncs,SysUtils, DateUtils, PayCommon, DnMLib, CommonLib, CommonDbLib, AppEnvironment;

const
  TAX_SCALE_HECS = 10;
  TAX_SCALE_SFSS = 9;

  { TPayObj }

constructor TPayObj.Create;
begin
  inherited;
  FPayTotals := TPayTotals.Create(Self);
  FEmployee := TPayEmployeeObj.Create(Self);
  //FPayPreferences := TPayPreferencesObj.Create;
  FPayRates := TPayRatesObj.Create(Self);
  FDeductions := TDeductionsObj.Create(Self);
  FAllowances := TAllowancesObj.Create(Self);
  FSundries := TSundriesObj.Create(Self);
  FCommission := TCommissionObj.Create(Self);
  FSuperannuation := TSuperannuationObj.Create(Self);
  FLeave := TLeaveObj.Create(Self);
  FPayPaySplits := TPayPaySplitsObj.Create(Self);
  FPaySplit := TPaySplitObj.Create(Self);
  FDataXML := TDataXMLObj.Create(Self);
  fbIsTerminationPay := False;
end;

destructor TPayObj.Destroy;
begin
  FreeAndNil(FPayTotals);
  FreeAndNil(FEmployee);
  //FreeAndNil(FPayPreferences);
  FreeAndNil(FPayRates);
  FreeAndNil(FDeductions);
  FreeAndNil(FAllowances);
  FreeAndNil(FSundries);
  FreeAndNil(FCommission);
  FreeAndNil(FSuperannuation);
  FreeAndNil(FLeave);
  FreeAndNil(FDataXML);
  FreeAndNil(FPayPaySplits);
  FreeAndNil(FPaySplit);
  inherited;
end;

procedure TPayObj.PopulateMe;
var
  iDays: integer;
begin
  if DatasetOk(FDSPay) then begin
    with FDSPay do begin
      fiPayID := FieldByName('PayID').AsInteger;
      fiPayVersion := FieldByName('PayVersion').AsInteger;
      fdtPayDate := FieldByName('PayDate').AsDateTime;
      fdtDatePaid := FieldByName('DatePaid').AsDateTime;
      fdtPayEndPeriod := fdtPayDate;
      fbPaid := FieldByName('Paid').AsBoolean;
      fdtPayStartPeriod := PayFromDate(fdtPayDate, Self.Employee.EmployeeSettings.PayPeriod);
      fiPayPeriods := FieldByName('PayPeriods').AsInteger;
      Leave.LeaveTaken.PaySuperOnLeaveLoading := FieldByName('PaySuperOnLeaveLoading').AsBoolean;
    end;
  end else begin
    {No tblPays Dataset (From Employee)}
    if FastFuncs.Trim(Self.Employee.EmployeeSettings.PayPeriod) = '' then begin
      fdtPayDate := IncDay(Self.Employee.EmployeeSettings.LastPaid, 7);
    end else if FastFuncs.Trim(Self.Employee.EmployeeSettings.PayPeriod) = 'Weekly' then begin
      fdtPayDate := IncDay(Self.Employee.EmployeeSettings.LastPaid, 7);
    end else if FastFuncs.Trim(Self.Employee.EmployeeSettings.PayPeriod) = 'Fortnightly' then begin
      fdtPayDate := IncDay(Self.Employee.EmployeeSettings.LastPaid, 14);
    end else if FastFuncs.Trim(Self.Employee.EmployeeSettings.PayPeriod) = 'Monthly' then begin
      fdtPayDate := IncMonth(Self.Employee.EmployeeSettings.LastPaid, 1);
    end else if FastFuncs.Trim(Self.Employee.EmployeeSettings.PayPeriod) = 'Bi-Monthly' then begin
      iDays := Trunc(DaysInMonth(Self.Employee.EmployeeSettings.LastPaid) / 2); //get approx half month for bi-month case
      fdtPayDate := IncDay(Self.Employee.EmployeeSettings.LastPaid, iDays);
    end;
    fdtPayEndPeriod   := fdtPayDate;
    fdtPayStartPeriod := PayFromDate(fdtPayDate, Self.Employee.EmployeeSettings.PayPeriod);
    fiPayPeriods      := 1;
    Leave.LeaveTaken.PaySuperOnLeaveLoading := Employee.EmployeeSettings.PaySuperOnLeaveLoading;
  end;
  if (fdtDatePaid = 0) then fdtDatePaid := fdtPayDate;
end;

procedure TPayObj.Recalc;
begin
  RecalcAll;
  SetPayTotals;
end;

procedure TPayObj.RecalcAll;
begin
  //if Assigned(PayPreferences) then if not PayPreferences.PopulateMe then Exit; {Maybe Open Preferences ??}

  Self.PayTotals.fmtTaxableTotals.EmptyTable;
  Employee.PopulateMe;
  Self.PopulateMe;
  Employee.PopulateMe; {Pay Period This Pay Year Needs PayDate}
  PayRates.Recalc;
  If not fbIsTerminationPay then
    fbIsTerminationPay := PayRates.HasTerminationRecord;
  Allowances.Recalc;
  Deductions.Recalc;
  Sundries.Recalc;
  Commission.Recalc;
  SetPayTotals(false); {Super Needs Gross}
  Leave.Recalc;        {Super Needs Leave Loading }
  Superannuation.Recalc;
  Leave.Recalc;
end;

procedure TPayObj.SetPayTotals(const RefreshYTDTotals: boolean);
var
  YTDTotals: TDataset;
begin
  with PayTotals do begin
    fdWages := FPayRates.Total;
    fdWagesIncludedInSuper := FPayRates.TotalIncludedInSuper;
    fdAllowances := FAllowances.Total;
    fdAllowancesBeforeTax := FAllowances.TotalBeforeTax;
    fdAllowancesAfterTax := FAllowances.TotalAfterTax;
    fdAllowancesIncludedInSuper := FAllowances.TotalIncludedInSuper;
    fdDeduction := FDeductions.Total;
    fdDeductionBeforeTax := FDeductions.TotalBeforeTax;
    fdDeductionAfterTax := FDeductions.TotalAfterTax;
    fdSundries := FSundries.Total;
    fdSundriesBeforeTax := FSundries.TotalBeforeTax;
    fdSundriesAfterTax := FSundries.TotalAfterTax;
    fdCommission := FCommission.TotalNet;
    fdCommissionBeforeTax := FCommission.TotalBeforeTax;
    fdCommissionAfterTax := FCommission.TotalAfterTax;
    fdCommissionIncludedInSuper := FCommission.TotalIncludedInSuper;
    fdSuperannuation := FSuperannuation.Total;
    fdGrossCDEP := FPayRates.TotalCDEP;
    fdGross := fdWages + fdCommission + fdAllowances + fdSundries - Self.Superannuation.SalarySacrificeTotal;
    fdGrossTaxable := (fdWages - fdDeductionBeforeTax) + fdCommissionBeforeTax + fdAllowancesBeforeTax +
      fdSundriesBeforeTax - Self.Superannuation.SalarySacrificeTotal;
    fdGrossTaxable := fdGrossTaxable - Self.Leave.LeaveTaken.NonTaxableLeaveLoading;
    fdTax := CalcTax;

    fdNet := ((((fdGrossTaxable + Self.Leave.LeaveTaken.NonTaxableLeaveLoading) - fdTax) -
        fdDeductionAfterTax) + fdCommissionAfterTax + fdAllowancesAfterTax + fdSundriesAfterTax -
        Self.Superannuation.EmployeeNegativeTotal) - Self.Superannuation.EmployeeOptionalTotal -
        Self.Superannuation.SpouseContributionTotal;

    // YTD Totals
    if RefreshYTDTotals then begin
      YTDTotals := RetrieveDataset('SELECT Sum(Wages) as Wages,Sum(Allowances) as Allowances,Sum(Sundries) as Sundries, ' +
        'Sum(Commission) as Commission,Sum(Superannuation) as Superannuation,Sum(Deductions) as Deductions, ' +
        'Sum(Gross) as Gross,Sum(Tax) as Tax,Sum(Net) as Net FROM tblpays WHERE Paid="T" AND Deleted="F" ' +
        'AND EmployeeID=' + FastFuncs.IntToStr(Self.Employee.EmployeeID) + ' AND PayDate BETWEEN ' +
        QuotedStr(FormatDateTime('yyyy-mm-dd', GetCurrentFiscalYearStart(Self.PayDate))) + ' AND ' +
        QuotedStr(FormatDateTime('yyyy-mm-dd', Self.PayDate)) + ';');
      try
        if DatasetOk(YTDTotals) then begin
          with YTDTotals do begin
            Self.PayTotals.fdYTDWages := FieldByName('Wages').AsFloat;
            fdYTDAllowances := FieldByName('Allowances').AsFloat;
            fdYTDSundries := FieldByName('Sundries').AsFloat;
            fdYTDCommission := FieldByName('Commission').AsFloat;
            fdYTDSuperannuation := FieldByName('Superannuation').AsFloat;
            fdYTDDeduction := FieldByName('Deductions').AsFloat;
            fdYTDGross := FieldByName('Gross').AsFloat;
            fdYTDTax := FieldByName('Tax').AsFloat;
            fdYTDNet := FieldByName('Net').AsFloat;
          end;
        end;
      finally
        FreeAndNil(YTDTotals);
      end;
    end;
  end;
end;

function TPayObj.CalcTax: double;
var
  dNormalTax: double;
  dNormalWeeklyTax: double;
  dCommissionTax: double;
  dHECSAmount: double;
  dSFSSAmount: double;
  dWeeklyTaxableGross: double;
  dWeeklyTaxableGrossNoCommission: double;
  dWeeklyTaxableCDEP: double;
  dCDEPTaxReduction: double;
begin
  {Manual Tax Does Not Recalc Tax Amount}
  dHECSAmount := 0.00;
  dSFSSAmount := 0.00;
  dWeeklyTaxableGross := 0.00;
  dWeeklyTaxableGrossNoCommission := 0.00;
  dWeeklyTaxableCDEP := 0.00;

  if DatasetOk(FDSPay) then begin
    if (FDSPay.FindField('ManualTax') <> nil) then begin
      if (FDSPay.FieldByName('ManualTax').AsString = 'T') or fbManualTax then begin
        Result := FDSPay.FieldByName('Tax').AsFloat;
        Exit;
      end;
    end;
  end;


  // calc the weekly equivalent gross
  if FastFuncs.Trim(Self.Employee.EmployeeSettings.PayPeriod) = 'Fortnightly' then begin
    dWeeklyTaxableGross := Trunc((Self.PayTotals.GrossTaxable) / 2);
    dWeeklyTaxableGrossNoCommission := Trunc((Self.PayTotals.GrossTaxable - Self.Commission.TotalBeforeTax) / 2);
    dWeeklyTaxableCDEP := Trunc((Self.PayTotals.GrossCDEP) / 2);
  end else if FastFuncs.Trim(Self.Employee.EmployeeSettings.PayPeriod) = 'Monthly' then begin
    if system.Round(Frac(Self.PayTotals.GrossTaxable) * 100) = 33 then begin
      dWeeklyTaxableGross := ((Self.PayTotals.GrossTaxable) + 0.01) * 3 / 13;
      dWeeklyTaxableCDEP := ((Self.PayTotals.GrossCDEP) + 0.01) * 3 / 13;
    end else begin
      dWeeklyTaxableGross := (Self.PayTotals.GrossTaxable) * 3 / 13;
      dWeeklyTaxableCDEP := (Self.PayTotals.GrossCDEP) * 3 / 13;
    end;
    if system.Round(Frac(Self.PayTotals.GrossTaxable - Self.Commission.TotalBeforeTax) * 100) = 33 then begin
      dWeeklyTaxableGrossNoCommission := ((Self.PayTotals.GrossTaxable - Self.Commission.TotalBeforeTax) + 0.01) * 3 / 13;
    end else begin
      dWeeklyTaxableGrossNoCommission := (Self.PayTotals.GrossTaxable - Self.Commission.TotalBeforeTax) * 3 / 13;
    end;
  end else if FastFuncs.Trim(Self.Employee.EmployeeSettings.PayPeriod) = 'Bi-Monthly' then begin
    if Trunc(Frac((Self.PayTotals.GrossTaxable)) * 100) = 33 then begin
      dWeeklyTaxableGross := (((Self.PayTotals.GrossTaxable - Self.Commission.TotalBeforeTax) + 0.01) * 3 / 13) * 2;
      dWeeklyTaxableCDEP := (((Self.PayTotals.GrossCDEP) + 0.01) * 3 / 13) * 2;
    end else begin;
      dWeeklyTaxableGross := ((Self.PayTotals.GrossTaxable - Self.Commission.TotalBeforeTax) * 3 / 13) * 2;
      dWeeklyTaxableCDEP := ((Self.PayTotals.GrossCDEP) * 3 / 13) * 2;
    end;
    if Trunc(Frac((Self.PayTotals.GrossTaxable - Self.Commission.TotalBeforeTax)) * 100) = 33 then begin
      dWeeklyTaxableGrossNoCommission := (((Self.PayTotals.GrossTaxable - Self.Commission.TotalBeforeTax) + 0.01) * 3 / 13) * 2;
    end else begin;
      dWeeklyTaxableGrossNoCommission := ((Self.PayTotals.GrossTaxable - Self.Commission.TotalBeforeTax) * 3 / 13) * 2;
    end;
  end else if FastFuncs.Trim(Self.Employee.EmployeeSettings.PayPeriod) = 'Weekly' then begin
    dWeeklyTaxableGross := (Self.PayTotals.GrossTaxable - Self.Commission.TotalBeforeTax);
    dWeeklyTaxableCDEP := Self.PayTotals.GrossCDEP;
    dWeeklyTaxableGrossNoCommission := (Self.PayTotals.GrossTaxable - Self.Commission.TotalBeforeTax);
  end;

  {#1 Pay Periods (Pay Multiple Weeks In One Pay}
  dWeeklyTaxableGross := DivZer(dWeeklyTaxableGross, fiPayPeriods);
  dWeeklyTaxableCDEP := DivZer(dWeeklyTaxableCDEP, fiPayPeriods);
  dWeeklyTaxableGrossNoCommission := DivZer(dWeeklyTaxableGrossNoCommission, fiPayPeriods);

  dNormalTax := GetTaxComponent(Self.Employee.EmployeeSettings.TaxScale, dWeeklyTaxableGrossNoCommission,FastFuncs.Trim(Self.Employee.EmployeeSettings.PayPeriod),Self.IsPayVerify);
  dNormalWeeklyTax := GetTaxComponent(Self.Employee.EmployeeSettings.TaxScale, dWeeklyTaxableGrossNoCommission, 'Weekly',Self.IsPayVerify);

  dCDEPTaxReduction := CDEPTaxReductionAmount(dWeeklyTaxableCDEP);

  if Self.Employee.EmployeeSettings.HECS then begin
    dHECSAmount := GetTaxComponent(TAX_SCALE_HECS, dWeeklyTaxableGross, FastFuncs.Trim(Self.Employee.EmployeeSettings.PayPeriod),Self.IsPayVerify);
  end;
  if Self.Employee.EmployeeSettings.SFSS then begin
    dSFSSAmount := GetTaxComponent(TAX_SCALE_SFSS, dWeeklyTaxableGross, FastFuncs.Trim(Self.Employee.EmployeeSettings.PayPeriod),Self.IsPayVerify);
  end;

  {#2 Pay Periods (Pay Multiple Weeks In One Pay}
  dNormalTax := dNormalTax * fiPayPeriods;
  dHECSAmount := dHECSAmount * fiPayPeriods;
  dSFSSAmount := dSFSSAmount * fiPayPeriods;
  dCDEPTaxReduction := dCDEPTaxReduction * fiPayPeriods;

  {Commission Tax}
  dCommissionTax := Self.Commission.CalcTax(dWeeklyTaxableGrossNoCommission, dNormalWeeklyTax);

  {Normal Tax}
  Result := dNormalTax + dCommissionTax + dHECSAmount + dSFSSAmount - dCDEPTaxReduction;

  {Extra Tax}
  if FindInSet(FastFuncs.Trim(Self.Employee.EmployeeSettings.ExtraTaxOption), '$') then begin
    Result := Result + Self.Employee.EmployeeSettings.ExtraTax;
  end else if FindInSet(FastFuncs.Trim(Self.Employee.EmployeeSettings.ExtraTaxOption), '%') then begin
    Result := Result + (Result * Self.Employee.EmployeeSettings.ExtraTax / 100);
  end else if FindInSet(FastFuncs.Trim(Self.Employee.EmployeeSettings.ExtraTaxOption), 'Fixed') then begin
    Result := Self.Employee.EmployeeSettings.ExtraTax;
  end;

end;

Function TPayObj.CDEPTaxReductionAmount(Const WeeklyCDEPAmount:Double):Integer;
Begin
  Result := Trunc((WeeklyCDEPAmount-115)/6);
  If Result<0 then Result:=0;
end;

procedure TPayObj.PostToAccounts;
begin
  Self.PayRates.PostToAccounts;
  Self.Deductions.PostToAccounts;
  Self.Allowances.PostToAccounts;;
  Self.Sundries.PostToAccounts;
  Self.Commission.PostToAccounts;
  Self.Superannuation.PostToAccounts;
  Self.PayTotals.Tax_PostToAccounts;
  Self.Leave.LeaveTaken.PostToAccounts;
  if fbIsTerminationPay = False then Self.Leave.LeaveAccrued.PostToAccounts;
end;

procedure TPayObj.Delete;
begin
  ReallyDeletePayRecords('tblleaveaccruals', Self.PayID);
  ReallyDeletePayRecords('tblpaystransactions', Self.PayID);
  VerifyEmployeeLeave(Self.Leave.LeaveAccrued.DataSet);
end;

procedure TPayObj.UnDelete;
begin
  ReallyDeletePayRecords('tblleaveaccruals', Self.PayID);
  ReallyDeletePayRecords('tblpaystransactions', Self.PayID);
  Self.Leave.LeaveTotals.AddLeaveAccrued;
  Self.Leave.LeaveTotals.DeductLeaveTaken;
  Self.PostToAccounts;
  VerifyEmployeeLeave(Self.Leave.LeaveAccrued.DataSet);
end;

{ TPayTotals }

constructor TPayTotals.Create(const Owner: TObject);
begin
  inherited Create;
  foOwner := Owner;
  fmtTaxableTotals := TkbmMemTable.Create(nil);
  SetupTaxableTotalsMemTable;
end;

destructor TPayTotals.Destroy;
begin
  FreeAndNil(fmtTaxableTotals);
  inherited;
end;

procedure TPayTotals.SetupTaxableTotalsMemTable;
begin
  fmtTaxableTotals.Close;
  with fmtTaxableTotals.FieldDefs.AddFieldDef do begin
    Name     := 'AutoID';
    DataType := ftAutoInc;
  end;
  with fmtTaxableTotals.FieldDefs.AddFieldDef do begin
    Name     := 'ID';
    DataType := ftInteger;
  end;
  with fmtTaxableTotals.FieldDefs.AddFieldDef do begin
    Name     := 'Rate';
    DataType := ftString;
    Size     := 255;
  end;
  with fmtTaxableTotals.FieldDefs.AddFieldDef do begin
    Name     := 'Type';
    DataType := ftString;
    Size     := 255;
  end;
  with fmtTaxableTotals.FieldDefs.AddFieldDef do begin
    Name     := 'ClassID';
    DataType := ftInteger;
  end;
  with fmtTaxableTotals.FieldDefs.AddFieldDef do begin
    Name     := 'Amount';
    DataType := ftFloat;
  end;
  with fmtTaxableTotals.FieldDefs.AddFieldDef do begin
    Name     := 'PayLineID';
    DataType := ftInteger;
  end;
  with fmtTaxableTotals.FieldDefs.AddFieldDef do begin
    Name     := 'MSType';
    DataType := ftString;
    Size     := 255;
  end;
  fmtTaxableTotals.CreateTable;
  fmtTaxableTotals.Open;
  fmtTaxableTotals.UpdateIndexes;
  fmtTaxableTotals.Emptytable;
end;

procedure TPayTotals.Tax_PostToAccounts;
var
  dTaxLeft, dTaxPercent, dAmount: double;
  CreditAccID: integer;
  DebitAccID: integer;
begin
  if DatasetOk(fmtTaxableTotals) then begin
    with fmtTaxableTotals do begin
      DisableControls;
      fmtTaxableTotals.SortOn('Amount', []);
      First;
      {Normal Tax}
      dTaxLeft := TPayObj(Self.Owner).PayTotals.fdTax - TPayObj(Self.Owner).Commission.TotalTax;
      {Used To Stop Rounding Errors}
      while not Eof do begin
        dTaxPercent := Divzer(Abs(fmtTaxableTotals.FieldByName('Amount').AsFloat),
          TPayObj(Self.Owner).PayTotals.fdGrossTaxable - TPayObj(Self.Owner).Commission.TotalBeforeTax);

          //handle paying manual tax on a commission
        if (dTaxPercent = 0) and (fmtTaxableTotals.FieldByName('Amount').AsFloat > 0) then begin
          dAmount := RoundCurrency(TPayObj(Self.Owner).PayTotals.fdTax);
        end else begin
          dAmount := RoundCurrency((TPayObj(Self.Owner).PayTotals.fdTax - TPayObj(Self.Owner).Commission.TotalTax) * dTaxPercent);
        end;

        if (dAmount > dTaxLeft) then begin
          dAmount := dTaxLeft;
          dTaxLeft := 0.00;
        end else begin
          dTaxLeft := dTaxLeft - dAmount;
        end;
(*        DebitAccID := TPayObj(Self.Owner).PayPreferences.BankAccountID;
        CreditAccID := TPayObj(Self.Owner).PayPreferences.PAYGTaxPayableAccountID;*)
        DebitAccID := AppEnv.PayPrefs.BankAccountID;
        CreditAccID :=AppEnv.PayPrefs.PAYGTaxPayableAccountID;
        PostToPaysTransactions('Payroll PAYG','PAYG - '+FieldByName('MSType').AsString,'PAYG - ' + FieldByName('Rate').AsString +
          ' : ' + FieldByName('Type').AsString, TPayObj(Self.Owner),
          CreditAccID,
          DebitAccID,
          FieldByName('ClassID').AsInteger, FieldByName('PaylineID').AsInteger,
          dAmount);
        Next;
      end;
      fmtTaxableTotals.Sort([]);
      {Commission Tax}
      with TPayObj(Self.Owner).Commission.TotalDS do begin
        TPayObj(Self.Owner).Commission.TotalDS.DisableControls;
        TPayObj(Self.Owner).Commission.TotalDS.First;
        while not TPayObj(Self.Owner).Commission.TotalDS.Eof do begin
(*          DebitAccID := TPayObj(Self.Owner).PayPreferences.BankAccountID;
          CreditAccID := TPayObj(Self.Owner).PayPreferences.PAYGTaxPayableAccountID;*)
          DebitAccID := AppEnv.PayPrefs.BankAccountID;
          CreditAccID := AppEnv.PayPrefs.PAYGTaxPayableAccountID;
          PostToPaysTransactions('Payroll PAYG','PAYG - Commission', 'PAYG - Commission' +
            ' : ' + TPayObj(Self.Owner).Commission.TotalDS.FieldByName('Type').AsString, TPayObj(Self.Owner),
            CreditAccID,
            DebitAccID,
            TPayObj(Self.Owner).Commission.TotalDS.FieldByName('ClassID').AsInteger, FieldByName('PaylineID').AsInteger,
            TPayObj(Self.Owner).Commission.TotalDS.FieldByName('TaxAmount').AsFloat);
          TPayObj(Self.Owner).Commission.TotalDS.Next;
        end;
        TPayObj(Self.Owner).Commission.TotalDS.EnableControls;
      end;
      EnableControls;
    end;
  end;
end;

end.

