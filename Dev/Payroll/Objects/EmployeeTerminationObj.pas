unit EmployeeTerminationObj;
           //needs an employee ID to populate and to calc Summary you need to pass Reason for termination,
           // ETPpreJul1983 ammount,ETPpostJul1983 amount,ETPpostJun1994 amount ,
           //sOther (None, Back Payment of Salary or Wages,Return to Work Payment), PayEmployee or not);
           // Record ET for passing a data set not used. Finish removing out when time permits

interface

uses
  MyAccess, DB, kbmMemTable, SysUtils, PayObj,  
  DateUtils, Classes;

type
  TEmpTerminationRec = record
    EmpID: integer;
    EmpName: string;
    Reason: string;
    ReasonIndex: integer;
    NormalHours: double;
    PayEmployee: boolean;
    HasPaySetup: boolean;
    DatePaid: TDateTime;

    // Death Benefits
    DeathPaidTo: string;
    DeathPaidIndex: integer;
    ClassID: integer;
    ClassName: string;

    HourlyRate: currency;
    OALLoadRate: currency;
    OALAccruedBefore180893: currency;
    OALAccruedAfter170893: currency;
    OALAccruedBefore180893Leave: currency;
    OALAccruedAfter170893Leave: currency;

    // ETP Values
    ETP: boolean;
    PreJuly1983: currency;
    PreJuly1983Margin: currency;
    PostJune1983: currency;
    PostJune1983Tax: currency;
    PostJune1994: currency;
    ETPAssessable: currency;

    TaxableETPAmt: currency;
    TaxFreeETPAmt: currency;

    // Totals
    LumpSumA: currency;
    LumpATax: currency;
    LumpSumB: currency;
    LumpBMargin: currency;
    LumpBTax: currency;
    LumpSumC: currency; // This sum goes to the ETP Statement.
    LumpSumD: currency;
    LumpETax: currency;
    TotalLeaveLoading: currency;
    GrossTax: currency;
    NonETPTax: currency;
    LumpSums: currency;
  end;

type
  TEmployeeTerminationObj = class(TObject)

  private
    fsLeaveType: string;
    ET: TEmpTerminationRec;
    fdDaysServiceTo30Jun1983: integer;
    fdDaysServiceFrom1July1983: integer;
    fdTotalDaysService: integer;

    fdAnnualPre18Aug93: double;
    fdLoadingPre18Aug93: double;
    fdAnnualPost17Aug93: double;
    fdLoadingPost17Aug93: double;
    fdLongPre16Aug78: double;
    fdLongMid: double;
    fdLongPost17Aug93: double;

    fdPayEmployee: boolean;
    fdLumpSumA: currency;
    fdLumpATax: currency;
    fdLumpSumB: currency;
    fdLumpBMargin: currency;
    fdLumpBTax: currency;
    fdLumpSumC: currency;
    fdLumpSumD: currency;
    fdLumpSumE: currency;
    fdLumpETax: currency;

    fdETPpreJul1983: currency;
    fdETPpostJun1983: currency;
    fdETPpostJun1994: currency;

    fdETPpreJul1983RollOver: currency;
    fdETPpostJun1983RollOver: currency;
    fdETPpostJun1994RollOver: currency;

    fdGrossETP: currency;

    fdTaxFreeETPAmt: currency;
    fdTaxableETPAmt: currency;
    fdETPtaxWitheld: currency;
    fdAssesableETP: currency;

    fdGross: currency;    //excluding LumpSums,Allowances,Other income, CDEP payments
    fdTax: currency;
    fdNet: currency;

    fdSummaryGross: currency;    //including LumpSums,Allowances,Other income, CDEP payments
    fdSummaryTax: currency;
    fdSummaryNet: currency;

    fdWageGross: currency;
    fdWageTax: currency;
    fdWageNet: currency;

    fdClassID: integer;
    fdClassName: string;

    fdLumpSums: currency;
    fdAddToEft: boolean;

    fdDateFinished: TDateTime;
    fdDateStarted: TDateTime;
    fdRollOver: currency;
    fdCDEP: double;
    TempPay: TPayObj;
    DSEmployee: TDataset;
    DSEmployeePayRates: TDataset;
    DSEmployeeAllowances: TDataset;
    DSEmployeeDeductions: TDataset;
    DSEmployeeSuper: TDataset;
    DSEmployeeLeave: TDataset;
    DSPays: TDataset;
    DSPaysPayRates: TDataset;

    FConnection: TMyConnection;

    fbManualAL: Boolean;
    fbManualLongService: Boolean;
    fsReason:String;
    fsTypeOfDeathBenefit:String;
    fdtEndOfFY : TDateTime;
    procedure SetPayObject(EmployeeID: integer);
    procedure DestroyPayObject;
    procedure CalcLongService;
    procedure CalcOwedAnnual;
    procedure PopulateET;
    function GetDaysToRetirement(const sSex: string): integer;
    function GetWagePerWeek: double;
    function GetReportableFB:double;
    function GetTotalAllowances:double;
  public
    constructor Create;
    class procedure Instance;
    destructor Destroy; override;

    procedure ReCalc;
    function SetSummary(const sReason: string; const sOther: string; const bPayEmployee: boolean; const DeathTFN: boolean;
      const DeathPaidTo: string): boolean;
    function PreparePay: integer;

    procedure PopulateMe(const EmpID: integer);
    procedure SetETPs(const dTotal: double; const sReason: string);
    procedure SetAnnualPre18Aug93(const APre18Aug93: double);
    procedure SetAnnualPost17Aug93(const APost17Aug93: double);
    procedure SetLongPre16Aug78(const LPre16Aug78: double);
    procedure SetLongMid(const LMid: double);
    procedure SetLongPost17Aug93(const LPost17Aug93: double);
    procedure SetLoadingPre18Aug93(const LoadPre18Aug93: double);
    procedure SetLoadingPost17Aug93(const LoadPost17Aug93: double);
    procedure SetLumpSumE(const LumpE: double);
    procedure SetRollOver(const ROver: double);
    procedure SetPayEmployee(const PayEmp: boolean);
    procedure SetAddToEFT(const AddEFT: boolean);
    procedure SetDateFinished(const dtFinished: TDateTime);
    procedure TerminateEmployee;

    property LeaveType: string read fsLeaveType write fsLeaveType;
    property AnnualPre18Aug93: double read fdAnnualPre18Aug93 write fdAnnualPre18Aug93;
    property AnnualPost17Aug93: double read fdAnnualPost17Aug93 write fdAnnualPost17Aug93;
    property LoadingPre18Aug93: double read fdLoadingPre18Aug93 write fdLoadingPre18Aug93;
    property LoadingPost17Aug93: double read fdLoadingPost17Aug93 write fdLoadingPost17Aug93;
    property LongPre16Aug78: double read fdLongPre16Aug78 write fdLongPre16Aug78;
    property LongMid: double read fdLongMid write fdLongMid;
    property LongPost17Aug93: double read fdLongPost17Aug93 write fdLongPost17Aug93;
    property PayEmployee: boolean read fdPayEmployee write fdPayEmployee;

    property AddToEft: boolean read fdAddToEft write fdAddToEft;

    property LumpSumA: currency read fdLumpSumA;
    property LumpATax: currency read fdLumpATax;
    property LumpSumB: currency read fdLumpSumB;
    property LumpBMargin: currency read fdLumpBMargin;
    property LumpBTax: currency read fdLumpBTax;
    property LumpSumC: currency read fdLumpSumC;
    property LumpSumD: currency read fdLumpSumD;
    property LumpSumE: currency read fdLumpSumE write fdLumpSumE;
    property LumpETax: currency read fdLumpETax;

    property Gross: currency read fdGross;
    property Tax: currency read fdTax;
    property Net: currency read fdNet;
    property SummaryGross: currency read fdSummaryGross;
    property SummaryTax: currency read fdSummaryTax;
    property SummaryNet: currency read fdSummaryNet;

    property LumpSums: currency read fdLumpSums;
    property ETPpreJul1983: currency read fdETPpreJul1983;
    property ETPpostJun1983: currency read fdETPpostJun1983;
    property ETPpostJun1994: currency read fdETPpostJun1994;
    property TaxFreeETPAmt: currency read fdTaxFreeETPAmt;
    property TaxableETPAmt: currency read fdTaxableETPAmt;
    property DateFinished: TDateTime read fdDateFinished;
    property DaysServiceTo30Jun1983: integer read fdDaysServiceTo30Jun1983;
    property DaysServiceFrom1July1983: integer read fdDaysServiceFrom1July1983;
    property TotalDaysService: integer read fdTotalDaysService;
    property GrossETP: currency read fdGrossETP;
    property AssesableETP: currency read fdAssesableETP;
    property ETPtaxWitheld: currency read fdETPtaxWitheld;
    property RollOver: currency read fdRollOver write fdRollOver;
    property WageTax: currency read fdWageTax;
    property WageGross: currency read fdWageGross;
    property ClassID: integer read fdClassID;
    property ClassNameD: string read fdClassName;
    property ETPpreJul1983RollOver: currency read fdETPpreJul1983RollOver;
    property ETPpostJun1983RollOver: currency read fdETPpostJun1983RollOver;
    property ETPpostJun1994RollOver: currency read fdETPpostJun1994RollOver;

    property ManualAL : Boolean read fbManualAL write fbManualAL;
    property ManualLongService : Boolean read fbManualLongService write fbManualLongService;
    property CDEP: double read fdCDEP write fdCDEP;

    property Connection: TMyConnection read FConnection write FConnection;
  end;

var
  Terminate: TEmployeeTerminationObj;
  EmployeeID, iPayID: integer;

implementation

uses
  CommonDbLib, ProgressDialog, DNMLib,  PayCommon,
  PayFunctionObj, AppEnvironment, FastFuncs, CommonLib;

 constructor TEmployeeTerminationObj.Create;
begin
  Inherited;
  FConnection := nil;
end;

procedure TEmployeeTerminationObj.PopulateMe(const EmpID: integer);
begin
  EmployeeID := EmpID;
  try
    SetPayObject(EmployeeID);
    PopulateET;
    CalcLongService;
    CalcOwedAnnual;
  finally
  end;
end;

procedure TEmployeeTerminationObj.ReCalc;
begin
  PopulateMe(EmployeeID);
end;

function TEmployeeTerminationObj.GetReportableFB:double;
var
  qry:TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := Self.Connection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT GlobalRef, FBTID, EmployeeID, YearEnding, Notes, Amount, ');
    qry.SQL.Add('FBTReportable, EditedFlag, ClassID, ClassName, Type ');
    qry.SQL.Add('FROM tblfbt WHERE EmployeeID = ' + FastFuncs.IntToStr(EmployeeID));
    qry.SQL.Add(' AND YearEnding BETWEEN ' + FormatDateTime('yyyy-mm-dd',IncYear(fdtEndOfFY, -1)));
    qry.SQL.Add(' AND ' + FormatDateTime('yyyy-mm-dd',fdtEndOfFY));
    qry.Open;

    result := qry.FieldByName('FBTReportable').AsFloat;

  finally
    FreeAndNil(qry);
  end;
end;
function TEmployeeTerminationObj.GetTotalAllowances:double;
var
  qry:TMyQuery;
begin
   qry := TMyQuery.Create(nil);
  try
    qry.Connection := Self.Connection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT Sum(Allowances) as TotalAllowances,EmployeeID,Paid,Deleted FROM tblpays ');
    qry.SQL.Add('WHERE EmployeeID = ' + FastFuncs.IntToStr(EmployeeID));
    qry.SQL.Add(' AND Paid = "T" AND Deleted = "F"');
    qry.SQL.Add(' AND PayDate > ' + FormatDateTime('yyyy-mm-dd',IncYear(fdtEndOfFY, -1)));
    qry.SQL.Add(' GROUP BY EmployeeID');
    qry.Open;

    result := qry.FieldByName('TotalAllowances').AsFloat;

  finally
    FreeAndNil(qry);
  end;
end;
procedure TEmployeeTerminationObj.TerminateEmployee;
var
  dAnnualAmount, dLSAmount: double;
  qry: TMyQuery;
  TempPayFunction: TPayFunctionObj;
  sTempDeath:string;
  dAccruedLeaveHours:double;
begin
  if EmployeeID = 0 then exit;
  qry := TMyQuery.Create(nil);
  qry.Connection := Self.Connection;
  TempPayFunction := TPayFunctionObj.Create;
  try
    if fsReason = 'Death' then sTempDeath := 'T' else sTempDeath := 'F';
    qry.SQL.Clear;
    qry.SQL.Add('INSERT INTO tblemployeeterminations (EmployeeID,EmployeeName,StartDate,EndDate,');
    qry.SQL.Add('DaysServicePre01071983,DaysServicePost30061983,ETPpre071983,');
    qry.SQL.Add('ETPpost061983Untaxed,ETPpost061983taxed,ETPpost061994Component,');
    qry.SQL.Add('GrossTermination,TaxWithheld,ETPAssessable,DeathBenefit,');
    qry.SQL.Add('TypeOfDeathBenefit,LumpSumA,LumpSumB,LumpSumD,LumpSumE,ReasonLeft,GrossETP,');
    qry.SQL.Add('CDEP,ReportableFB,TotalAllowances');
    qry.SQL.Add(') VALUES (' + FastFuncs.IntToStr(EmployeeID) + ',' +
    QuotedStr(GetEmployeeName(EmployeeID)) + ',' +
    QuotedStr(FormatDateTime('yyyy-mm-dd',fdDateStarted)) + ',' +
    QuotedStr(FormatDateTime('yyyy-mm-dd',fdDateFinished)) + ', ' +
    FastFuncs.IntToStr(fdDaysServiceTo30Jun1983) + ',' +
    FastFuncs.IntToStr(fdDaysServiceFrom1July1983) + ',' +
    FormatFloat('##########0.0',fdETPpreJul1983) + ',' +
    FormatFloat('##########0.0',fdTaxFreeETPAmt) + ',' +
    FormatFloat('##########0.0',fdETPpostJun1983) + ',' +
    FormatFloat('##########0.0',fdETPpostJun1994) + ',' +
    FormatFloat('##########0.0',fdGrossETP) + ',' +
    FormatFloat('##########0.0',fdETPtaxWitheld) + ',' +
    FormatFloat('##########0.0',fdAssesableETP) + ',' +
    QuotedStr(sTempDeath) + ',' +
    QuotedStr(fsTypeOfDeathBenefit) + ',' +
    FormatFloat('##########0.0',fdLumpSumA) + ',' +
    FormatFloat('##########0.0',fdLumpSumB) + ',' +
    FormatFloat('##########0.0',fdLumpSumD) + ',' +
    FormatFloat('##########0.0',fdLumpSumE) + ',' +
    QuotedStr(fsReason) + ',' +
    FormatFloat('##########0.0',fdGrossETP) + ',' +
    FormatFloat('##########0.0',fdCDEP) + ',' +
    FormatFloat('##########0.0',GetReportableFB) +  ',' +
    FormatFloat('##########0.0',GetTotalAllowances) + ')'  );
    qry.Execute;

    if fdPayEmployee = true then begin
          // Next Step, are we paying the employee with  unpaid work, if so we need to
          //ammend the current pay packet
          qry.Close;
          qry.SQL.Clear;
          qry.SQL.Add('SELECT * FROM tblpays WHERE EmployeeID = :xEmpID AND Paid=''F'' AND Deleted = ''F''');
          qry.Params.ParamByName('xEmpID').asInteger := EmployeeID;
          qry.Open;
          qry.First;
          if qry.RecordCount > 0 then begin
          qry.Edit;
          //Load data into pay table
          iPayID := qry.FieldByName('PayID').AsInteger;
          qry.FieldByName('Gross').AsCurrency := fdGross + fdLumpSums;
          qry.FieldByName('Wages').AsCurrency := fdWageGross;
          qry.FieldByName('Tax').AsCurrency := fdTax;
          qry.FieldByName('Net').AsCurrency := fdNet;
          qry.FieldByName('LumpA').AsCurrency := fdLumpSumA;
          qry.FieldByName('LumpB').AsCurrency := fdLumpSumB;
          qry.FieldByName('LumpD').AsCurrency := fdLumpSumD;
          qry.FieldByName('LumpE').AsCurrency := fdLumpSumE;
          qry.FieldByName('ETP').AsCurrency := fdLumpSumC;
          qry.FieldByName('PayNotes').AsString := 'Termination Pay.';

          qry.Post;

          // Now check to see if we need to add a annual leave payrate line.
          qry.Close;
          qry.SQL.Clear;
          qry.SQL.Add('SELECT * FROM tblpayspayrates WHERE PayID = :xPayID');
          qry.Params.ParamByName('xPayID').asInteger := iPayID;
          qry.Open;

          dAnnualAmount := fdAnnualPre18Aug93 + fdLoadingPre18Aug93 + fdAnnualPost17Aug93+fdLoadingPost17Aug93;

          // Do we have an amount of leave to post.
          if dAnnualAmount <> 0 then begin
            qry.Insert;
            qry.FieldByName('PayID').AsInteger := iPayID;
            qry.FieldByName('PayRateID').AsInteger := GetPayRateID('Annual Leave');
            qry.FieldByName('TypeID').AsInteger := GetPayRateTypeID('Hourly Rate');
            qry.FieldByName('SuperInc').AsString := 'F';
            dAccruedLeaveHours := TempPay.Leave.LeaveTotals.GetHrs(TempPay.Leave.LeaveTotals.GetLeaveID('Annual Leave'));
            qry.FieldByName('Qty').AsFloat := dAccruedLeaveHours;
            qry.FieldByName('Amount').AsCurrency := DivZer(dAnnualAmount,dAccruedLeaveHours);
            qry.FieldByName('LineTotal').AsCurrency := dAnnualAmount;
            qry.FieldByName('ClassID').AsInteger := fdClassID;
            qry.FieldByName('ClassName').AsString := fdClassName;

            qry.Post;
          end;

          // Now check to see if we need to add a long service payrate line.
          dLSAmount := fdLongPre16Aug78 + fdLongMid + fdLongPost17Aug93;

          // Do we have an amount of leave to post.
          if dLSAmount <> 0 then begin
            qry.Insert;
            qry.FieldByName('PayID').AsInteger := iPayID;
            qry.FieldByName('PayRateID').AsInteger := GetPayRateID('Long Service');
            qry.FieldByName('TypeID').AsInteger := GetPayRateTypeID('Hourly Rate');
            qry.FieldByName('SuperInc').AsString := 'F';
            dAccruedLeaveHours := TempPay.Leave.LeaveTotals.GetHrs(TempPay.Leave.LeaveTotals.GetLeaveID('Long Service'));
            qry.FieldByName('Qty').AsFloat := dAccruedLeaveHours;
            qry.FieldByName('Amount').AsCurrency := DivZer(dLSAmount,dAccruedLeaveHours);
            qry.FieldByName('LineTotal').AsCurrency := dLSAmount;
            qry.FieldByName('ClassID').AsInteger := fdClassID;
            qry.FieldByName('ClassName').AsString := fdClassName;

            qry.Post;
          end;

          // Now enter the rest of the details as a termination payout.
          if fdLumpSums <> 0 then begin
            qry.Insert;
            qry.FieldByName('PayID').AsInteger := iPayID;
            qry.FieldByName('PayRateID').AsInteger := GetPayRateID('Termination');
            qry.FieldByName('TypeID').AsInteger := GetPayRateTypeID('Payout');
            qry.FieldByName('SuperInc').AsString := 'F';
            qry.FieldByName('LineTotal').AsCurrency := fdLumpSums;
            qry.FieldByName('Amount').AsCurrency := fdLumpSums;
            qry.FieldByName('Qty').AsFloat := 1.0;
            qry.FieldByName('ClassID').AsInteger := fdClassID;
            qry.FieldByName('ClassName').AsString := fdClassName;

            qry.Post;
            qry.Close;
          end;

          // Now do termination pay in records.
          if EmployeeID > 0 then begin
            TempPayFunction.ProcessPay(iPayID, fdDateFinished, fdAddToEFT, true,True); // TempPayFunction.GetUnprocessedPayID(EmployeeID), fdDateFinished, fdAddToEFT, true,True);
            //Delete pay created from last pay
            TempPayFunction.ReallyDeletePay(TempPayFunction.GetUnprocessedPayID(EmployeeID));
          end;
        end;
    end;
    // Now terminate the employee.
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tblemployees WHERE EmployeeID = :xEmpID');
    qry.Params.ParamByName('xEmpID').asInteger := EmployeeID;
    qry.Open;
    qry.First;
    if qry.Recordcount > 0 then  begin
      qry.Edit;
      qry.FieldByName('Active').AsString         := 'F';
      qry.FieldByName('DateFinished').AsDateTime := fdDateFinished;
      qry.FieldByName('IsTerminated').AsString   := 'T';
      qry.Post;
    end;

  finally
    FreeAndNil(qry);
    FreeAndNil(TempPayFunction);
  end;
end;

function TEmployeeTerminationObj.PreparePay: integer;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.connection := Self.Connection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tblPays WHERE Paid = ''F'' AND Deleted = ''F'' AND EmployeeID = :xEmpID');
    qry.Params.ParamByName('xEmpID').asInteger := EmployeeID;
    qry.Open;

    if qry.RecordCount = 0 then begin
      qry.Insert;
      qry.FieldByName('EmpName').AsString := TempPay.Employee.EmployeeDetails.EmployeeName;
      qry.FieldByName('EmployeeID').AsInteger := EmployeeID;
      qry.FieldByName('PayPeriods').AsInteger := 1;
      qry.FieldByName('PayPeriod').AsString := TempPay.Employee.EmployeeSettings.PayPeriod;
      qry.FieldByName('Paid').AsString := 'F';
      qry.Post;
    end;
    Result := qry.FieldByName('PayID').AsInteger;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TEmployeeTerminationObj.SetDateFinished(const dtFinished: TDateTime);
begin
  fdDateFinished := dtFinished;
end;

procedure TEmployeeTerminationObj.SetAddToEFT(const AddEFT: boolean);
begin
  fdAddToEFT := AddEFT;
end;

procedure TEmployeeTerminationObj.SetPayEmployee(const PayEmp: boolean);
begin
  fdPayEmployee := PayEmp;
end;

procedure TEmployeeTerminationObj.SetRollOver(const ROver: double);
begin
  fdRollOver := ROver;
end;

procedure TEmployeeTerminationObj.SetLumpSumE(const LumpE: double);
begin
  fdLumpSumE := LumpE;
end;

procedure TEmployeeTerminationObj.SetLoadingPre18Aug93(const LoadPre18Aug93: double);
begin
  fdLoadingPre18Aug93 := LoadPre18Aug93;
end;

procedure TEmployeeTerminationObj.SetLoadingPost17Aug93(const LoadPost17Aug93: double);
begin
  fdLoadingPost17Aug93 := LoadPost17Aug93;
end;

procedure TEmployeeTerminationObj.SetLongPre16Aug78(const LPre16Aug78: double);
begin
  fdLongPre16Aug78 := LPre16Aug78;
end;

procedure TEmployeeTerminationObj.SetLongMid(const LMid: double);
begin
  fdLongMid := LMid;
end;

procedure TEmployeeTerminationObj.SetLongPost17Aug93(const LPost17Aug93: double);
begin
  fdLongPost17Aug93 := LPost17Aug93;
end;

procedure TEmployeeTerminationObj.SetAnnualPost17Aug93(const APost17Aug93: double);
begin
  fdAnnualPost17Aug93 := APost17Aug93;
end;

procedure TEmployeeTerminationObj.SetAnnualPre18Aug93(const APre18Aug93: double);
begin
  fdAnnualPre18Aug93 := APre18Aug93;
end;

function TEmployeeTerminationObj.GetDaysToRetirement(const sSex: string): integer;
var
  qryRetire: TMyQuery;
  dRetirementAge, dPartYear: double;
  iRetirementAge, iPartYearDays: integer;
  DOB: TDateTime;
begin
  qryRetire := TMyQuery.Create(nil);
  try
    DOB := TempPay.Employee.EmployeeDetails.DOB;
    qryRetire.Connection := Self.Connection;
    qryRetire.SQL.Clear;
    iPartYearDays := 0;
    if sSex = 'Male' then begin
      qryRetire.SQL.Add('SELECT * FROM tblretirementage WHERE Sex = "Male"');
      qryRetire.Open;
      dRetirementAge := qryRetire.FieldByName('RetireAge').AsFloat;
    end else begin
      qryRetire.SQL.Add('SELECT StartOfPeriod,EndOfPeriod,RetireAge,Sex FROM tblretirementage WHERE Sex = "Female"');
      qryRetire.Open;
      qryRetire.First;
      dRetirementAge := 0;
      while not qryRetire.Eof do begin
        if (DOB < qryRetire.FieldByName('EndOfPeriod').AsDateTime) and (DOB > qryRetire.FieldByName('StartOfPeriod').AsDateTime) then
        begin
          dRetirementAge := qryRetire.FieldByName('RetireAge').AsFloat;
          Break;
        end;
        qryRetire.Next;
      end;
    end;
    dPartYear      := dRetirementAge - Trunc(dRetirementAge);
    iRetirementAge := Trunc(dRetirementAge);
    if dPartYear <> 0 then begin
      iPartYearDays := Trunc(365.2425 * dPartYear);   //needs work; what about leap years?
    end;
    Result := daysbetween(IncYear(DOB, iRetirementAge), fdDateFinished) + iPartYearDays;
  finally
    FreeAndNil(qryRetire);
  end;
end;

procedure TEmployeeTerminationObj.SetETPs(const dTotal: double; const sReason: string);
var
  iYearsOfService: integer;
  iDaysToRetirement: integer;
  dTaxFreeRedundancyLimit: double;
begin
  iYearsOfService := YearsBetween(fdDateFinished, TempPay.Employee.EmployeeDetails.DateStarted);
  if (sReason = 'Redundancy') or (sReason = 'Early Retirement') then begin
    if iYearsOfService > 25 then begin
      iYearsOfService := 25;
    end;
    dTaxFreeRedundancyLimit := 6194 + (iYearsOfService * 3097);     //needs hard coding removed
    if dTotal < dTaxFreeRedundancyLimit then begin
      fdLumpSumD := dTotal;
    end else begin
      fdLumpSumD := dTaxFreeRedundancyLimit;
    end;
    fdAssesableETP := 0;
    fdTaxableETPAmt := 0;
    fdETPpreJul1983 := 0;
    fdETPpostJun1983 := 0;
    if dTotal > fdLumpSumD then begin
      fdETPpreJul1983 := (RoundCurrency(Divzer(fdDaysServiceTo30Jun1983, fdTotalDaysService) * (dTotal - fdLumpSumD - fdRollOver)));
      //NOTE fdTaxFreeETPAmt should be named ETPostJun1983Untaxed (confusing terminology from ATO)
      fdTaxFreeETPAmt := RoundCurrency(dTotal - fdLumpSumD - fdRollover - fdETPpreJul1983);
    end;
    fdAssesableETP := dTotal - fdLumpSumD - fdRollOver - (fdETPpreJul1983 * 0.95);
    fdTaxableETPAmt := dTotal - fdLumpSumD - fdRollOver - fdETPpreJul1983;
  end else if sReason = 'Invalidity' then begin
    iDaysToRetirement := GetDaysToRetirement(TempPay.Employee.EmployeeDetails.Sex);
    fdETPpostJun1994 := RoundCurrency(divzer((dTotal * iDaysToRetirement), (fdTotalDaysService + iDaysToRetirement)));
    fdETPpreJul1983 := (RoundCurrency(Divzer(fdDaysServiceTo30Jun1983, fdTotalDaysService) * dTotal));
    fdTaxFreeETPAmt := RoundCurrency(dTotal - fdETPpostJun1994);
    fdAssesableETP := dTotal - fdETPpostJun1994;
    fdTaxableETPAmt := fdAssesableETP;
  end else begin
    fdETPpreJul1983 := (RoundCurrency(Divzer(fdDaysServiceTo30Jun1983, fdTotalDaysService) * dTotal));
    fdTaxFreeETPAmt := RoundCurrency(dTotal - fdETPpreJul1983);
    fdAssesableETP := dTotal - fdLumpSumD - fdRollOver - (fdETPpreJul1983 * 0.95);
    fdTaxableETPAmt := dTotal - fdLumpSumD - fdRollOver - fdETPpreJul1983;
  end;
  fdETPpreJul1983RollOver  := (RoundCurrency(Divzer(fdDaysServiceTo30Jun1983, fdTotalDaysService) * fdRollOver));
  fdETPpostJun1983RollOver := RoundCurrency(fdRollOver - fdETPpreJul1983RollOver);
end;

procedure TEmployeeTerminationObj.PopulateET;
var
  qryEmp: TMyQuery;
  qry: TMyQuery;
  wYear, wMonth, wDay: word;
  dtTestDate: TDateTime;
begin
  qry := TMyQuery.Create(nil);
  qryEmp := TMyQuery.Create(nil);
  try
    qry.Connection := Self.connection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tblcompanyinformation');
    qry.Open;

    qryEmp.Connection := Self.connection;
    qryEmp.SQL.Clear;
    qryEmp.SQL.Add('SELECT EmployeeID,DateFinished,DateStarted FROM tblemployees WHERE EmployeeID = ' + FastFuncs.IntToStr(EmployeeID));
    qryEmp.Open;
    fdDateStarted := qryEmp.FieldByName('DateStarted').AsDateTime;
    dtTestDate := EncodeDate(1983, 7, 1);
    if qryEmp.FieldByName('DateStarted').AsDateTime < dtTestDate then begin
      fdDaysServiceTo30Jun1983 := DaysBetween(qryEmp.FieldByName('DateStarted').AsDateTime, dtTestDate) - 1;
    end else begin
      fdDaysServiceTo30Jun1983 := 0;
    end;

    dtTestDate := EncodeDate(1983, 6, 30);
    fdtEndOfFY  := GetCurrentFiscalYearStart(qryEmp.FieldByName('DateFinished').AsDateTime);
    DecodeDate(fdtEndOfFY, wYear, wMonth, wDay);
    if qryEmp.FieldByName('DateStarted').AsDateTime < dtTestDate then begin
      fdDaysServiceFrom1July1983 := DaysBetween(dtTestDate, qryEmp.FieldByName('DateFinished').AsDateTime) - 1;
    end else begin
      fdDaysServiceFrom1July1983 := DaysBetween(qryEmp.FieldByName('DateStarted').AsDateTime, fdDateFinished) - 1;
    end;
    if fdDaysServiceFrom1July1983 < 0 then fdDaysServiceFrom1July1983 := 0; //in case they enter late start date then finsish date 
    fdTotalDaysService := fdDaysServiceFrom1July1983 + fdDaysServiceTo30Jun1983;

    ET.EmpID       := TempPay.Employee.EmployeeID;
    ET.EmpName     := TempPay.Employee.EmployeeDetails.EmployeeName;
    ET.NormalHours := TempPay.PayRates.TotalStandardHours;
    ET.HourlyRate  := TempPay.PayRates.HourlyRate;
    ET.ClassID     := TempPay.Employee.EmployeeSettings.ClassID;
    ET.ClassName   := GetClassName(ET.ClassID);

    fdClassID   := ET.ClassID;
    fdClassName := ET.ClassName;

  finally
    FreeAndNil(qryEmp);
    FreeAndNil(qry);
  end;
end;

function TEmployeeTerminationObj.GetWagePerWeek: double;
begin
  if FastFuncs.Trim(TempPay.Employee.EmployeeSettings.PayPeriod) = 'Weekly' then begin
    Result := TempPay.PayRates.Total
  end else if FastFuncs.Trim(TempPay.Employee.EmployeeSettings.PayPeriod) = 'Fortnightly' then begin
    Result := TempPay.PayRates.Total / 2;
  end else if FastFuncs.Trim(TempPay.Employee.EmployeeSettings.PayPeriod) = 'Bi-Monthly' then begin
    Result := TempPay.PayRates.Total / 2.667;
  end else if FastFuncs.Trim(TempPay.Employee.EmployeeSettings.PayPeriod) = 'Monthly' then begin
    Result := TempPay.PayRates.Total / 4.33333;
  end else begin
    Result := 0;
  end;
end;

function TEmployeeTerminationObj.SetSummary(const sReason: string; const sOther: string; const bPayEmployee: boolean;
  const DeathTFN: boolean; const DeathPaidTo: string): boolean;
var
  iEmpAge: integer;
  tmpTax, tmpWageTax, dWagePerWeek, dWeeklyWageAverageYTD: double;
begin
  fsReason := sReason;
  fsTypeOfDeathBenefit := DeathPaidTo;
  fdGrossETP := fdETPpreJul1983 + fdTaxFreeETPAmt + fdETPpostJun1994;
  try
    ET.Reason    := sReason;
    dWagePerWeek := GetWagePerWeek;
    if not bPayEmployee = true then begin
      fdWageGross := 0;
      fdWageTax := 0;
    end else begin
      ET.DatePaid := Now;
      fdWageGross := TempPay.PayRates.Total;
      fdWageTax := GetTaxComponent(TempPay.Employee.EmployeeSettings.TaxScale, RoundCurrency(dWagePerWeek),
        FastFuncs.Trim(TempPay.Employee.EmployeeSettings.PayPeriod),False);
      fdWageNet := fdWageGross - fdWageTax;
    end;
    // Did the employee leave due to a Redundancy, Invalidity or Early Retirement?
    if ((ET.Reason = 'Redundancy') or (ET.Reason = 'Invalidity') or (ET.Reason = 'Early Retirement')) then begin
      // Yes, Calculate Lump Sums as so.
      ET.TotalLeaveLoading := fdLoadingPost17Aug93 + fdLoadingPre18Aug93;
      // Deduct Leave Load Threshold if applicable before applying tax.
      if ET.TotalLeaveLoading > AppEnv.CompanyPrefs.LeaveLoadTaxThreshold then begin
        if fdLoadingPre18Aug93 > AppEnv.CompanyPrefs.LeaveLoadTaxThreshold then begin
          fdLoadingPre18Aug93 := fdLoadingPre18Aug93 - AppEnv.CompanyPrefs.LeaveLoadTaxThreshold;
        end;
      end;
      // Lump Sum A
      fdLumpSumA := (fdAnnualPre18Aug93 + fdLoadingPre18Aug93) + (fdAnnualPost17Aug93 + fdLoadingPost17Aug93) +
        fdLongMid + fdLongPost17Aug93;

      // Lump Sum B
      fdLumpSumB := fdLongPre16Aug78; //ET.AccruedBefore160878;

      // Lump Sum C
      fdLumpSumC := fdETPpreJul1983 + fdTaxFreeETPAmt +  + fdETPpostJun1994;

      // Lump Sum D
      if sReason = 'Invalidity' then begin
        ET.TaxFreeETPAmt := (fdETPpreJul1983 * 0.95) + fdETPpostJun1994;
      end;
      fdSummaryGross := fdLumpSumA + fdLumpSumB + fdLumpSumD + fdLumpSumE;
    end else begin
      // Calculate Total Leave Loading
      ET.TotalLeaveLoading := fdLoadingPre18Aug93 + fdLoadingPost17Aug93;

      // Deduct Leave Load Threshold if applicable before applying tax.
      if ET.TotalLeaveLoading > AppEnv.CompanyPrefs.LeaveLoadTaxThreshold then
        fdLoadingPost17Aug93 := fdLoadingPost17Aug93 - AppEnv.CompanyPrefs.LeaveLoadTaxThreshold;

      // Lump Sum A
      fdLumpSumA := fdLongMid + fdAnnualPre18Aug93 + fdLoadingPre18Aug93;

      // Lump Sum B
      fdLumpSumB := fdLongPre16Aug78;

      // Lump Sum C
      fdLumpSumC := fdETPpreJul1983 + TaxFreeETPAmt + fdETPpostJun1994;

      // Lump Sum D
      if sReason <> 'Death' then begin
        ET.TaxFreeETPAmt := (fdETPpreJul1983 * 0.05);
        fdLumpSumD := 0;
      end else begin
        fdLumpSumD := fdETPpreJul1983;
      end;
      fdGross := fdLongPost17Aug93 + fdAnnualPost17Aug93 + fdLoadingPost17Aug93;
      fdSummaryGross := fdLongPost17Aug93 + fdAnnualPost17Aug93 + fdLoadingPost17Aug93;
    end;

    ///////////////////////
    // Calculate Totals.
    ///////////////////////
    // Calculate Taxable Amount from LumpSumB. Only 5% of amount is taxable.
    ET.LumpBMargin := fdLumpSumB * (5 / 100);

    // Lump Sum A & B Tax @ 30 + Medicare Levy Rate.
    if not Empty(TempPay.Employee.EmployeeSettings.TFN) then begin
      ET.NonETPTax := (fdLumpSumA + fdLumpBMargin) * ((AppEnv.CompanyPrefs.LumpSumTaxRate + AppEnv.CompanyPrefs.MedicareLevyRate) / 100);
    end else begin
      ET.NonETPTax := (fdLumpSumA + ET.LumpBMargin) * ((AppEnv.CompanyPrefs.NoTFNTaxRate + AppEnv.CompanyPrefs.MedicareLevyRate) / 100);
    end;
    // ETP Tax
    if sReason <> 'Death' then begin
      iEmpAge := GetEmployeeAge(TempPay.Employee.EmployeeDetails.DOB, Now());
      //  dPreJuly1983Margin :=RemoveCents(fdETPpreJul1983 * (5 / 100) );

      if not Empty(TempPay.Employee.EmployeeSettings.TFN) then begin
        if iEmpAge > 54 then begin
          if fdTaxableETPAmt < AppEnv.CompanyPrefs.YearlyIncomeThreshold then begin
            fdETPtaxWitheld := RemoveCents((fdTaxableETPAmt) *
            ((AppEnv.CompanyPrefs.LumpSumTaxRateOver55 + AppEnv.CompanyPrefs.MedicareLevyRate) / 100));

          end else begin          //if above Low Rate Threshold
            fdETPtaxWitheld := (RemoveCents((AppEnv.CompanyPrefs.YearlyIncomeThreshold) *
            ((AppEnv.CompanyPrefs.LumpSumTaxRateOver55 + AppEnv.CompanyPrefs.MedicareLevyRate) / 100)) )

            +  ((fdTaxableETPAmt -  AppEnv.CompanyPrefs.YearlyIncomeThreshold )*
            ((AppEnv.CompanyPrefs.LumpSumTaxRate + AppEnv.CompanyPrefs.MedicareLevyRate) / 100))  ;
          end;

        end else begin
          fdETPtaxWitheld := RemoveCents((fdTaxableETPAmt) * ((AppEnv.CompanyPrefs.LumpSumTaxRate + AppEnv.CompanyPrefs.MedicareLevyRate) / 100));
        end;
      end else begin
        // Calculate on No TFN Tax Rate
        fdETPtaxWitheld := RemoveCents((fdTaxableETPAmt) * ((AppEnv.CompanyPrefs.NoTFNTaxRate + AppEnv.CompanyPrefs.MedicareLevyRate) / 100));
      end;

      // Get total of Lump Sums
      fdLumpSums := fdLumpSumA + fdLumpSumB + fdLumpSumC + fdLumpSumD + fdLumpSumE;//ET.LumpSumE;

      // Calculate Lump Sum E Tax if applicable.

      if sOther = 'Back Payment of Salary or Wages' then begin
        fdLumpETax := (fdLumpSumE) * ((AppEnv.CompanyPrefs.LumpSumETaxRate + AppEnv.CompanyPrefs.MedicareLevyRate) / 100);
      end else if sOther = 'Return to Work Payment' then begin
        fdLumpETax := (fdLumpSumE) * ((AppEnv.CompanyPrefs.LumpSumTaxRate + AppEnv.CompanyPrefs.MedicareLevyRate) / 100);
      end;

      // Calculate Overall Tax Balance.

      if fdGross > 0 then begin
        //Accrued Annual leave and Long service treated like a bonus spread over a year
        dWeeklyWageAverageYTD := divzer(TempPay.PayTotals.YTDWages, WeeksBetweenSigned(Now(), StartOfTheFY(Now())));

        tmpTax := PayCommon.GetTaxComponent(TempPay.Employee.EmployeeSettings.TaxScale,
          ((fdGross / 52) + dWeeklyWageAverageYTD), FastFuncs.Trim(TempPay.Employee.EmployeeSettings.PayPeriod),False);

        tmpWageTax := GetTaxComponent(TempPay.Employee.EmployeeSettings.TaxScale,
          RoundCurrency(dWeeklyWageAverageYTD), FastFuncs.Trim(TempPay.Employee.EmployeeSettings.PayPeriod),False);

        ET.GrossTax := (tmpTax - tmpWageTax) * 52;
      end;
      if bPayEmployee = true then begin
        // Add the Wage gross onto the final gross.
        fdGross := fdGross + fdWageGross;
        fdTax := ET.NonETPTax + ET.GrossTax + fdETPtaxWitheld + ET.LumpETax + fdWageTax;
      end else begin
        fdTax := ET.NonETPTax + ET.GrossTax + fdETPtaxWitheld + ET.LumpETax;
      end;
      fdSummaryGross := fdSummaryGross + fdWageGross + fdGrossETP;
    end else begin     //DEATH
      if (DeathPaidTo = 'Non Dependant') and (DeathTFN = true) then begin
        fdETPtaxWitheld := fdETPpostJun1983 * 0.315;
      end else if (DeathPaidTo = 'Non Dependant') and (DeathTFN = false) then begin
        fdETPtaxWitheld := fdETPpostJun1983 * 0.485;
      end else begin
        fdETPtaxWitheld := 0;
      end;
      // Save ETP Assessable Amount.
      fdAssesableETP := RemoveCents(fdETPpostJun1983);
      // Get total of Lump Sums
      fdLumpSums := fdLumpSumA + fdLumpSumB + fdLumpSumC + fdLumpSumD + fdLumpSumE;

      if sOther = 'Back Payment of Salary or Wages' then begin
        ET.LumpETax := (fdLumpSumE) * ((AppEnv.CompanyPrefs.LumpSumETaxRate + AppEnv.CompanyPrefs.MedicareLevyRate) / 100);
      end else if sOther = 'Return to Work Payment' then begin
        ET.LumpETax := (fdLumpSumE) * ((AppEnv.CompanyPrefs.LumpSumTaxRate + AppEnv.CompanyPrefs.MedicareLevyRate) / 100);
      end;

      ET.GrossTax := TempPay.PayTotals.Tax;

      // Calculate Overall Tax Balance.

      if bPayEmployee = true then begin
        // Add the Wage gross onto the final gross.  Since we have now
        // taxed the gross we can now add the wage gross
        fdGross := fdGross + fdWageGross;
        fdSummaryGross := fdSummaryGross + fdWageGross + fdLumpSums;
        fdTax := ET.NonETPTax + fdWageTax + ET.GrossTax + fdETPtaxWitheld + ET.LumpETax;
      end else begin
        fdTax := ET.NonETPTax + ET.GrossTax + fdETPtaxWitheld + ET.LumpETax;
        fdSummaryGross := fdSummaryGross + fdLumpSums;
      end;
    end;

    // Net Wage is Gross - Tax
    fdSummaryNet   := RemoveCents(fdSummaryGross - fdTax);
    fdNet          := RemoveCents(fdSummaryGross - fdTax);
    fdSummaryGross := RemoveCents(fdSummaryGross);
    fdTax          := RemoveCents(fdTax);
    fdLumpSumA     := RemoveCents(fdLumpSumA);
    fdLumpSumB     := RemoveCents(fdLumpSumB);
    fdLumpSumC     := RemoveCents(fdLumpSumC);
    fdLumpSumD     := RemoveCents(fdLumpSumD);
    fdLumpSumE     := RemoveCents(fdLumpSumE);
    fdLumpSums     := RemoveCents(fdLumpSums);

    //THIS IS A TEMP FIX. fdGross is used for AL and LSL which is calculated as a bonus spread over
    // a year. I wrote it to fdWageGross here so that it shows in the PAYG statement. It makes the
    // payslip look a little dodgy but OK for now
    fdWageGross := fdGross;

  finally
    Result := false;
  end;
end;

procedure TEmployeeTerminationObj.CalcOwedAnnual;
var
  TestDate, dtLeaveGoesBackTo: TDateTime;
  dLeaveLoadRate:double;   //,dLastPayAL: double;
  iDaysTotal, dNumOfAccumPeriods, dDaysInAccumPeriod: double;
  dAccruedAnnualLeaveHours, dDaysBack, dLeaveHourlyRate: double;
  wYear, wMonth, wDay: word;
  qryLeave: TMyQuery;
  sPayPeriod: string;
begin
  qryLeave := TMyQuery.Create(nil);
  try
    if not fbManualAL then begin
      // Outstanding Annual Leave Service
      qryLeave.Connection := Self.Connection;//CommonDbLib.GetSharedMyDACConnection;
      qryLeave.SQL.Clear;
      qryLeave.SQL.Add('SELECT EmployeeID,AccrueHours,Type FROM tblleave  ');
      qryLeave.SQL.Add('WHERE EmployeeID = ' + FastFuncs.IntToStr(EmployeeID) + ' AND Type = "Annual Leave"');
      qryLeave.Open;

      // Get the Leave Loading Rate for this employee.
      dLeaveLoadRate := TempPay.Employee.EmployeeSettings.LeaveLoading;

      // Get Accrued Annual Leave.       //is returning hours including this pay
      dAccruedAnnualLeaveHours := TempPay.Leave.LeaveTotals.GetHrs(TempPay.Leave.LeaveTotals.GetLeaveID('Annual Leave'));

      // create our test date.
      wYear    := 1993;
      wMonth   := 8;
      wDay     := 18;
      TestDate := EncodeDate(wYear, wMonth, wDay);

      /////////////////////////////////////////////////////
      // Now calculate the Outstanding Accrued Annual Leave
      /////////////////////////////////////////////////////
      dLeaveHourlyRate := ET.HourlyRate * (1 + dLeaveLoadRate);
      //ET.HourlyRate + (ET.HourlyRate * (dLeaveLoadRate / 100));
      //need to calc how many pay periods have accumalated
      //and see if these go back further than the cut off date
      dDaysInAccumPeriod := 0;
      sPayPeriod         := TempPay.Employee.EmployeeSettings.PayPeriod;
      if sPayPeriod = 'Weekly' then begin
        dDaysInAccumPeriod := 7;
      end else if sPayPeriod = 'Fornightly' then begin
        dDaysInAccumPeriod := 14;
      end else if sPayPeriod = 'Monthly' then begin
        dDaysInAccumPeriod := 30.4375;     //averaged over 4 year span.
      end else if sPayPeriod = 'Bi-Monthly' then begin
        dDaysInAccumPeriod := 30.4375 / 2;
      end;
      dNumOfAccumPeriods := divzer(dAccruedAnnualLeaveHours, qryLeave.FieldByName('AccrueHours').AsFloat);
      dDaysBack          := dDaysInAccumPeriod * dNumOfAccumPeriods;
      dtLeaveGoesBackTo  := fdDateFinished - dDaysBack;

      ET.OALAccruedAfter170893 := dLeaveHourlyRate * dAccruedAnnualLeaveHours;
      //Does the accumulation go back before 18/08/1993
      if dtLeaveGoesBackTo < TestDate then begin
        dDaysBack := DaysBetween(TestDate, dtLeaveGoesBackTo);
        iDaysTotal := DaysBetween(fdDateFinished, dtLeaveGoesBackTo);
        ET.OALAccruedBefore180893 := Divzer(dDaysBack, iDaysTotal) * dAccruedAnnualLeaveHours * ET.HourlyRate;
        ET.OALAccruedBefore180893Leave := ET.OALAccruedBefore180893 * dLeaveLoadRate;
        ET.OALAccruedAfter170893 := ((dAccruedAnnualLeaveHours * ET.HourlyRate) - ET.OALAccruedBefore180893) * ET.HourlyRate;
        ET.OALAccruedAfter170893Leave := ET.OALAccruedAfter170893 * dLeaveLoadRate;
      end else begin
        ET.OALAccruedBefore180893 := 0;
        ET.OALAccruedBefore180893Leave := 0;
        ET.OALAccruedAfter170893 := dAccruedAnnualLeaveHours * ET.HourlyRate;
        ET.OALAccruedAfter170893Leave := dAccruedAnnualLeaveHours * dLeaveLoadRate * ET.HourlyRate;
      end;
      //Load properties
      fdAnnualPre18Aug93   := ET.OALAccruedBefore180893;
      fdAnnualPost17Aug93  := ET.OALAccruedAfter170893;
      fdLoadingPre18Aug93  := ET.OALAccruedBefore180893Leave;
      fdLoadingPost17Aug93 := ET.OALAccruedAfter170893Leave ;
    end;
  finally
    FreeAndNil(qryLeave);
  end;
end;

procedure TEmployeeTerminationObj.CalcLongService;
var
  DateStarted, TestDate, TestDate2, TestDate3: TDateTime;
  dLongServiceSum: double;
  dAccruedLongServiceHours: double;
  dLeaveTakenUpto, dMyCalculated: double;
  iDaysToNow: integer;
  dDaysInAccumPeriod: double;
  dNumOfAccumPeriods: double;
  wYear, wMonth, wDay: word;
  qryLeave,qryNormalHrs: TMyQuery;
  sPayPeriod: string;
  iWholeSumDays, iTotalDaysC, iTotalDaysD, iDaysTotal: integer;
  dNormalHrs : double;
begin
  // Outstanding Long Service

  if not fbManualLongService then begin

    qryLeave := nil;
    qryLeave := TMyQuery.Create(nil);
    qryNormalHrs := TMyQuery.Create(nil);
    try
      // has employee been working for the required years
      if IncYear(TempPay.Employee.EmployeeDetails.DateStarted, 10) > fdDateFinished then begin
        Exit;
      end;
      qryNormalHrs.Connection := Self.Connection;//CommonDbLib.GetSharedMyDACConnection;
      qryNormalHrs.SQL.Clear;
      qryNormalHrs.SQL.Add('SELECT EmployeeID,Qty FROM tblemployeepayrates  ');
      qryNormalHrs.SQL.Add('WHERE EmployeeID = ' + FastFuncs.IntToStr(EmployeeID) + ' AND TypeID = 1');

      qryNormalHrs.Open;
      dNormalHrs := qryNormalHrs.FieldByName('Qty').AsFloat;

      qryLeave.Connection := Self.Connection;//CommonDbLib.GetSharedMyDACConnection;
      qryLeave.SQL.Clear;
      qryLeave.SQL.Add('SELECT EmployeeID,AccrueHours,Type FROM tblleave  ');
      qryLeave.SQL.Add('WHERE EmployeeID = ' + FastFuncs.IntToStr(EmployeeID) + ' AND Type = "Long Service"');

      qryLeave.Open;
      sPayPeriod := TempPay.Employee.EmployeeSettings.PayPeriod;
      // Get the date the employee started working.
      DateStarted        := TempPay.Employee.EmployeeDetails.DateStarted;
      iDaysToNow         := DaysBetween(Date(), DateStarted);
      dDaysInAccumPeriod := 0;
      if sPayPeriod = 'Weekly' then begin
        dDaysInAccumPeriod := 7;
      end else if sPayPeriod = 'Fornightly' then begin
        dDaysInAccumPeriod := 14;
      end else if sPayPeriod = 'Monthly' then begin
        dDaysInAccumPeriod := 30.4375;     //averaged over 4 year span.
      end else if sPayPeriod = 'Bi-Monthly' then begin
        dDaysInAccumPeriod := 30.4375 / 2;
      end;

      dNumOfAccumPeriods := Divzer(iDaysToNow, dDaysInAccumPeriod);
      // Get Accrued Long Service Hours.
      dAccruedLongServiceHours := dNumOfAccumPeriods * qryLeave.FieldByName('AccrueHours').AsFloat;

      // Now create our test date.
      wYear    := 1978;
      wMonth   := 8;
      wDay     := 16;
      TestDate := EncodeDate(wYear, wMonth, wDay);

      wYear     := 1993;
      wMonth    := 8;
      wDay      := 18;
      TestDate2 := EncodeDate(wYear, wMonth, wDay);

      wYear      := 1993;
      wMonth     := 8;
      wDay       := 17;
      TestDate3  := EncodeDate(wYear, wMonth, wDay);
      iDaysTotal := DaysBetween(Date(), DateStarted);

      // Calculate the Lump Sum of Long Service
      dLongServiceSum := ET.HourlyRate * dAccruedLongServiceHours;

      // Employee Commenced before 16 August 1978
      if DateStarted < TestDate then begin
        // Step #1 - Calculate the Amount which accrued after 15 August 1978
        iTotalDaysC := DaysBetween(fdDateFinished, (TestDate - 1.0));



        dLeaveTakenUpto := TempPay.Leave.LeaveTotals.GetTakenHrs(GetLeaveTypeID('Long Service'), (TestDate - 2.0));

        iTotalDaysD := Trunc(ConvertHoursToWorkingDays(dLeaveTakenUpTo,TempPay.Employee.EmployeeSettings.PayPeriod,dNormalHrs));
        iWholeSumDays := Trunc(ConvertHoursToWorkingDays(dAccruedLongServiceHours,TempPay.Employee.EmployeeSettings.PayPeriod,dNormalHrs));
        dMyCalculated := divzer(dLongServiceSum, iWholeSumDays) *
          ((divzer((iTotalDaysC * (iWholeSumDays + iTotalDaysD)), iDaysTotal)) - iTotalDaysD);

        // Step #2
        fdLongPre16Aug78 := dLongServiceSum - dMyCalculated;

        // Step #3 - Now calculate the amount which accrued after 17 August 1993
        iTotalDaysC := DaysBetween(fdDateFinished, (TestDate3 + 1.0));

        dLeaveTakenUpto := TempPay.Leave.LeaveTotals.GetTakenHrs(GetLeaveTypeID('Long Service'), (TestDate3 - 1.0));

        iTotalDaysD := Trunc(ConvertHoursToWorkingDays(dLeaveTakenUpTo,TempPay.Employee.EmployeeSettings.PayPeriod,dNormalHrs));
        iWholeSumDays := Trunc(ConvertHoursToWorkingDays(dAccruedLongServiceHours,TempPay.Employee.EmployeeSettings.PayPeriod,dNormalHrs));

        dMyCalculated := divzer(dLongServiceSum, iWholeSumDays) *
          ((divzer((iTotalDaysC * (iWholeSumDays + iTotalDaysD)), iDaysTotal)) - iTotalDaysD);
        //Step #4
        fdLongMid := dLongServiceSum - dMyCalculated;
        fdLongPost17Aug93 := dLongServiceSum - (fdLongMid + fdLongPre16Aug78);

        // Employee Commenced after 15 August but before 18 August 1993
      end else if (DateStarted > TestDate) and (DateStarted < TestDate2) then begin
        // Step #1 - Now calculate the amount which accrued after 17 August 1993
        iTotalDaysC := DaysBetween(fdDateFinished, (TestDate3 + 1.0));

        dLeaveTakenUpto := TempPay.Leave.LeaveTotals.GetTakenHrs(GetLeaveTypeID('Long Service'), (TestDate3 - 1.0));

        iTotalDaysD := Trunc(ConvertHoursToWorkingDays(dLeaveTakenUpTo,TempPay.Employee.EmployeeSettings.PayPeriod,dNormalHrs));
        iWholeSumDays := Trunc(ConvertHoursToWorkingDays(dAccruedLongServiceHours,TempPay.Employee.EmployeeSettings.PayPeriod,dNormalHrs));
        try
          dMyCalculated := divzer(dLongServiceSum, iWholeSumDays) *
            ((divzer((iTotalDaysC * (iWholeSumDays + iTotalDaysD)), iDaysTotal)) - iTotalDaysD);

        except
          dMyCalculated := 0;
        end;
        // Step #2 - Calculate Balance.
        fdLongMid := dLongServiceSum - dMyCalculated;
        fdLongPre16Aug78 := 0;
        fdLongPost17Aug93 := dLongServiceSum - (fdLongMid + fdLongPre16Aug78);

        // Accrued After the 17 August 1993
      end else begin
        fdLongPre16Aug78 := 0;
        fdLongMid := 0;
        fdLongPost17Aug93 := dLongServiceSum;
      end;
    finally
      FreeAndNil(qryLeave);
      FreeAndNil(qryNormalHrs);
    end;
  end;  
end;

procedure TEmployeeTerminationObj.SetPayObject;
begin
  inherited;
  if Assigned(TempPay) then FreeAndNil(TempPay);
  if Assigned(DSEmployee) then FreeAndNil(DSEmployee);
  if Assigned(DSEmployeePayRates) then FreeAndNil(DSEmployeePayRates);
  if Assigned(DSEmployeeAllowances) then FreeAndNil(DSEmployeeAllowances);
  if Assigned(DSEmployeeDeductions) then FreeAndNil(DSEmployeeDeductions);
  if Assigned(DSEmployeeSuper) then FreeAndNil(DSEmployeeSuper);
  if Assigned(DSEmployeeLeave) then FreeAndNil(DSEmployeeLeave);
  if Assigned(DSPays) then FreeAndNil(DSPays);
  if Assigned(DSPaysPayRates) then FreeAndNil(DSPaysPayRates);
  DSEmployee           := RetrieveDataset('tblEmployees', 'EmployeeID', EmployeeID);
  DSEmployeePayRates   := RetrieveDataset('tblpayspayrates', 'PayID', iPayID);
  DSEmployeeAllowances := RetrieveDataset('tblpaysallowances', 'PayID', iPayID);
  DSEmployeeDeductions := RetrieveDataset('tblpaysdeductions', 'PayID', iPayID);
  DSEmployeeSuper      := RetrieveDataset('tblsuperannuation', 'EmployeeID', EmployeeID);
  DSEmployeeLeave      := RetrieveDataset('tblleave', 'EmployeeID', EmployeeID);
  DSPays               := RetrieveDataset('tblpays', 'PayID', iPayID);

  TempPay := TPayObj.Create;
  TempPay.DataSet := DSPays;
  TempPay.Employee.DataSet := DSEmployee;
  TempPay.PayRates.DataSet := DSEmployeePayRates;
  TempPay.Allowances.DataSet := DSEmployeeAllowances;
  TempPay.Deductions.DataSet := DSEmployeeDeductions;
  TempPay.Superannuation.DataSet := DSEmployeeSuper;
  TempPay.Leave.LeaveAccrued.DataSet := DSEmployeeLeave;
  TempPay.Recalc;
end;


procedure TEmployeeTerminationObj.DestroyPayObject;
begin
  if Assigned(TempPay) then FreeAndNil(TempPay);
  if Assigned(DSEmployee) then FreeAndNil(DSEmployee);
  if Assigned(DSEmployeePayRates) then FreeAndNil(DSEmployeePayRates);
  if Assigned(DSEmployeeAllowances) then FreeAndNil(DSEmployeeAllowances);
  if Assigned(DSEmployeeDeductions) then FreeAndNil(DSEmployeeDeductions);
  if Assigned(DSEmployeeSuper) then FreeAndNil(DSEmployeeSuper);
  if Assigned(DSEmployeeLeave) then FreeAndNil(DSEmployeeLeave);
  if Assigned(DSPays) then FreeAndNil(DSPays);
end;

class procedure TEmployeeTerminationObj.Instance;
begin
  if Terminate = nil then begin
    Terminate := TEmployeeTerminationObj.Create;
  end;
end;

destructor TEmployeeTerminationObj.Destroy;
begin
  inherited;
  DestroyPayObject;
  
end;

end.





