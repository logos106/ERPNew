unit PayCommon;

interface
{$I ERP.inc}

uses DB, MyAccess,ERPdbComponents,
//PayObj,
  Classes, Windows, kbmMemTable, kbmMemCSVStreamFormat
  ,BusObjPaybase,BusObjBase;

type
  TEmployeePayRateRec = record
    IsValid: boolean;
    RateDept: string;
    RateType: string;
    PayRate: string;
    Qty: double;
    Amount: currency;
    HourlyRate: currency;
    LineTotal: currency;
    ClassID: integer;
    Super: boolean;
    TypeID: integer;
    RateID: integer;
  end;

type
  PPayRecord = ^TPayRecord;
  TPayRecord = record
    ClassID: integer;
    Rate: double;
    JobID: integer;
  end;

type
  PSelectedPayRate = ^TSelectedPayRate;
  TSelectedPayRate = record
    IndexID: integer;
    ClassID: integer;
    HourlyRate: currency;
    LineTotal: currency;
    Qty: double;
  end;

function SumNonAccumLeave(const Dataset: TDataset; const FieldName: string): double;
function GetPayTypeDescription(iTypeID:integer):string;
function SumField(const Dataset: TDataset; const FieldName: string): double;
function AvgField(const Dataset: TDataset; const FieldName: string): double;
function DatasetOk(const Dataset: TDataset): boolean;
function DatasetEmpty(const Dataset: TDataset): boolean;
function FindInSet(const Str, StrList: string): boolean;
procedure FilterDataset(const Dataset: TDataset; const FilterStr: string);
procedure RemoveFilterDataset(const Dataset: TDataset);
function RetrievePaysDataset(const sTableName, sMasterKeyName: string; const MasterID: integer): TDataset;
procedure PostDataset(Dataset: TDataset);
procedure DeleteEntireDataset(Dataset: TDataset);
Procedure DebugDeleteEntirePayTrans(Dataset:TDataset);
procedure DeleteEntireTable(const sTableName, sMasterKeyName: string; const MasterID: integer);
procedure DatasetToEditMode(Dataset: TDataset);
function ForeignKeyFilter(const sMasterFieldName, sForeignKeyFieldName, sTableName, sFilterFieldName,
  sFilterStr: string): string;
function IsDigits(const S: string): boolean;
function IsSub(const Sub, S: string): boolean;
function RemoveCents(const dAmount: double): double;
function ConvertHoursToWorkingDays(const iTotalHours: double; const sPayPeriod: string; const dNormalHrs: double): double;
procedure ExportMemtable(const MemTable: TkbmMemTable; const FileName: string);

  // Payroll Specific
function GetLastTerminationEndDate(const iEmployeeID:integer):TDateTime;
function NoPaysExistForEmployee(const iEmployeeID:integer):Boolean;
function PayFromDate(const PayDate: TDateTime; const PayPeriod: string): TDateTime;
function NumberOfThisDayInFiscalYear(const PayDate: TDateTime; const StepinDays: integer): integer;
function GetCommissionPeriod(const iPeriodID: integer): string;
function GetCommissionName(const iCommissionID: integer): string;
function CheckABN(const ABNStr: string): boolean;
function CheckTFN9(const TFN: string): boolean;
function CheckTFN8(const TFN: string): boolean;
function GetPayRateMultiplier(const iPayRateID: integer): double;
function GetDeductionName(const iDeductionID: integer): string;
function GetDeductionID(const DeductionName: String): Integer;
function GetDeductionAccountID(const iDeductionID: integer): integer;
function GetAllowanceName(const iAllowanceID: integer): string;
function GetSundryName(const iSundryID: integer): string;
function GetAllowanceID(const AllowanceName: String): Integer;
function GetAllowanceAccountID(const iAllowanceID: integer): integer;
function GetPayRegion(const iPayID: integer): String;
function IsLeave(const iRateID: integer): boolean;
function GetLeaveTypeID(const sLeaveType: string): integer;
function GetLeaveType(const iRateID: integer): string;
function GetLeaveLoading(const EmployeeID: integer; const sType:String): double;
function GetBasedOnID(const sBasedOnName: string): integer;
function GetBasedOnName(const iBasedOnID: integer): string;
function GetBasedOnFilter(const iBasedOnID: integer): string;
function GetPayRateID(const sPayRate: string): integer;
function GetEmployeePayRateTypeID(const iEmpID:integer): integer;
function GetPayRate(const iPayRateID: integer): string;
(*function GetPayRateTypeID(const sRateType: string): integer;*)
function GetPayRateType(const iRateTypeID: integer): string;
function GetMonthlyGrossTotal(const iEmployeeID: integer; const dtPayDate: TDateTime; const PayID: integer = 0;const PassedConnection:TMyDacDataConnection = nil): double;

function GetTaxComponentUSA(const iTaxScaleID: Integer; const dWeeklyTaxable: Double;  const iEmpID: Integer;
                            const sGroupType: string; const sTaxType: string; const sPayPeriod: string;
                            var varGross, varA, varC, varD: Double) : Double;
function GetTaxComponent(const iTaxScaleID: integer; const dWeeklyGross: double;
                            const sPayPeriod: string; IsPayVerify: Boolean; TaxAllowanceAmount: double = 0;
                            EmployeeId: integer = 0): double;

function GetEmployeeAge(const DOB, PayDate: TDateTime): integer;
function GetEmployeeStartDate(const EmployeeID:integer): TDateTime;
function GetNumberOfPays(const iEmployeeID: integer; const AsOfDate: TDateTime;
  const ByPayPeriod: boolean = false): integer;
function PaysBetweenDates(const iEmployeeID: integer; const FromDate, ToDate: TDateTime;
  const ExcludePayID: integer = 0): integer;
function GetSuperName(const iSuperTypeID: integer): string;
function GetSuperTypeID(const sSuperName: string): integer;
function GetLastPayDate(const iEmployeeID: integer;const PassedConnection:TMyDacDataConnection = nil): TDateTime;
function GetLastPayDateFromPays(const iEmployeeID: integer;const PassedConnection:TERPConnection = nil): TDateTime;
procedure DeletePayRecords(const sTableName: string; const iPayID: integer);
procedure ReallyDeletePayRecords(const sTableName: string; const iPayID: integer);overload;
procedure ReallyDeletePayRecords(const sTableName: string; const ThisPay: Tpaybase);overload;
//procedure AddAccruedHoursAdjustmentToDB(const ThisPay: TPayObj; const AccrualType, LeaveType: string;
//  const Hours, HourlyRate: double; const iPayLineID: integer);
function AwardInUseByEmployees(const iAwardID: integer): integer;
function GetAwardSickLeaveDaysThreshold(const iAwardID: integer): integer;
function IsNormalPayRate(const sPayRateName: string): boolean;
function IsCorrectMultiplierPayRate(const TestPayRateID, CurrentPayRateID: integer): boolean;
function UnprocessedPayExists(const iEmployeeID: integer;const PassedConnection:TERPConnection = nil): integer;
function IsUnprocessedPayATimesheet(const iEmployeeID: integer): boolean;
function GetNormalHoursMultiplierPayRateRec(const ThisPayRateID: integer;
  const DSEmployeePayRates: TDataset): TEmployeePayRateRec;
function GetPayPeriodWeeks(const Period: string): double;
function GetTotalOfReportableFringeBenefits(const iEmpID: integer; const dtTo, dtFrom: TDateTime): double;
//procedure VerifyEmployeeLeave(const DSEmployeeLeave: TDataset);
Function GetUnprocessedPayID(const iEmployeeid:integer):integer;
Function GetTerminationPayID(const iEmployeeID:integer):integer;
function GetDaysToRetirement(EmployeeID:integer;FinishDate:TDateTime): integer;
function EmployeeRetiredAtEndOfYear(const DOB:TDateTime;const Sex:String;const CurrentDate:TDateTime):Boolean;

  //#####  Awards  #####
function GetPaySuperOnLeaveLoading(const iEmployeeID: integer): boolean;
//function SuperThreshold(const iAwardID: integer;Pay: TPayObj): double;
function SuperThreshold(const iAwardID: integer): double;

function GetNormalHoursPayRatesID: integer;
function GetHourlyRateTypeID: integer;
function GetEmployeeAwardClassID(const iEmployeeID: integer): integer;
function GetClassificationID(const iAwardID: integer; const sClassificationName: string): integer;
function GetClassificationName(const iClassificationID: integer): string;

function GetAdvanceClassificationID(const iAwardID: integer; const DS_Employee: TDataset): integer;
function GetAdvanceDate(const AdvanceDescription: string; const StartDate, DOB: TDateTime): TDateTime;
function GetNextClassificationName(const iClassificationID: integer): string;
//function CheckAwardAdvanceRequiredUpdate(DS_Employee: TDataset): boolean;
function AwardSuperOnLeaveLoading(const iAwardID:integer):Boolean;

procedure LoadAwardGeneral(const DS_Award, DS_Employee: TDataset);
procedure LoadAwardLeave(const DS_Award, DS_AwardLeave, DS_Employee, DS_EmployeeLeave: TDataset);
procedure LoadAwardSuper(const DS_Award, DS_Employee, DS_EmployeeSuper: TDataset);
procedure LoadAwardAllowances(const DS_Award, DS_ClassificationAllowances, DS_Employee, DS_EmployeeAllowances: TDataset);
procedure LoadAwardDeductions(const DS_Award, DS_ClassificationDeductions, DS_Employee, DS_EmployeeDeductions: TDataset);
procedure LoadAwardRates(const DS_Award, DS_Classification, DS_ClassificationExtraPayRates,
  DS_Employee, DS_EmployeePayRates: TDataset);


// Leave Accruals Report
function GetEmployeeHourlyRate(const iEmployeeID: integer): double;

// Payroll Reconciliation Report List
function GetTotalSummarisedMonthlyWages(const iMonth, iYear: integer; const ByWhichDate: string): double;
function GetTotalSummarisedMonthlyTax(const iMonth, iYear: integer; const ByWhichDate:string): double;

function GetBasedOnRate(const aBasedOnId, aPayId: integer; var aRate: double; conn: TCustomMyConnection): boolean;

implementation

uses CommonDbLib, SysUtils, DateUtils, Math, DecimalRounding,
   DnmLib,  StrUtils, Dialogs,
   //PayFunctionObj,
   tcDataUtils, AppEnvironment,
  CommonLib,  MySQLConst, types, tcTypes, DbSharedObjectsObj, BusObjFormW4;

procedure ExportMemtable(const MemTable: TkbmMemTable; const FileName: string);
var
  CSVStreamFormat: TkbmCSVStreamFormat;
Begin
  CSVStreamFormat := TkbmCSVStreamFormat.Create(nil);
  try
    MemTable.SaveToFileViaFormat(FileName,CSVStreamFormat);
  finally
    FreeAndNil(CSVStreamFormat);
  end;
end;


//##########################

function EmployeeRetiredAtEndOfYear(const DOB:TDateTime;const Sex:string;const CurrentDate:TDateTime):Boolean;
var
  qryRetire: TERPQuery;
  AgeAtEOY:double;
  dRetirementAge:double;
begin
  Result := False;
  qryRetire := TERPQuery.Create(nil);
  try
    qryRetire.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryRetire.SQL.Clear;
    if Sex = 'Male' then begin
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
    AgeAtEOY := GetCurrentFiscalYearStart(CurrentDate)  - DOB;
    if AgeAtEOY >= dRetirementAge then Result := True;
  finally
  FreeAndNil(qryRetire);
end;
end;

function GetDaysToRetirement(EmployeeID:integer;FinishDate:TDateTime): integer;
var
  qryRetire,qryDOB: TERPQuery;
  dRetirementAge, dPartYear: double;
  iRetirementAge, iPartYearDays: integer;
  DOB: TDateTime;
  sSex:String;
begin
  qryRetire := TERPQuery.Create(nil);
  qryDOB    := TERPQuery.Create(nil);
  try
    qryDOB.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryDOB.SQL.Clear;
    qryDOB.SQL.Add('SELECT EmployeeID,DOB,Sex from tblemployees WHERE EmployeeID = ' + IntToStr(EmployeeID));
    qryDOB.Open;
    DOB := qryDOB.fieldbyname('DOB').AsDateTime;
    sSex := qryDOB.fieldbyname('Sex').AsString;

    qryRetire.Connection := CommonDbLib.GetSharedMyDacConnection;
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
    Result := daysbetween(IncYear(DOB, iRetirementAge), FinishDate) + iPartYearDays;
  finally
    FreeAndNil(qryRetire);
    FreeAndNil(qryDOB);
  end;
end;






function GetEmployeeHourlyRate(const iEmployeeID: integer): double;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  qry.ParamCheck := true;
  try
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT EmployeeRateID, If(IsNull(LineTotal/Qty),HourlyRate,(LineTotal/Qty)) as HourlyRate FROM tblemployeepayrates ' +
        'WHERE EmployeeID = :xEmpID Order By Qty Desc;');
      Params.ParamByName('xEmpID').asInteger := iEmployeeID;
      Open;
      if RecordCount > 0 then begin
        First;
        Result := FieldByName('HourlyRate').AsCurrency;
      end else begin
        Result := 0.00;
      end;
    end;
  finally
    // Free our used objects.
    FreeAndNil(qry);
  end;
end;


function GetTotalSummarisedMonthlyWages(const iMonth, iYear: integer; const ByWhichDate:string): double;
var
  qry: TERPQuery;
  dtStartMonth, dtEndMonth: TDateTime;
  wYear, wMonth, wDay: word;
begin
  qry := nil;
  wMonth := iMonth;
  wYear := iYear;
  wDay := 1;
  dtStartMonth := EncodeDate(wYear, wMonth, wDay);
  wDay := DaysInMonth(dtStartMonth);
  dtEndMonth := EncodeDate(wYear, wMonth, wDay);
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT PayID, Sum(Gross) AS Gross FROM tblpays');
    qry.SQL.Add('WHERE Paid = "T" AND Deleted = "F" AND (' + ByWhichDate + ' BETWEEN ' +
      QuotedStr(FormatDateTime(MysqlDateFormat, dtStartMonth)) + ' AND ' +
      QuotedStr(FormatDateTime(MysqlDateFormat, dtEndMonth)) + ')');

    qry.SQL.Add('GROUP BY Paid');
    qry.Open;
    if qry.RecordCount > 0 then begin
      Result := qry.FieldByName('Gross').AsCurrency;
    end else begin
      Result := 0;
    end;

  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function GetTotalSummarisedMonthlyTax(const iMonth, iYear: integer; const ByWhichDate:string): double;
var
  qry: TERPQuery;
  dtStartMonth, dtEndMonth: TDateTime;
  wYear, wMonth, wDay: word;
begin
  qry := nil;
  wMonth := iMonth;
  wYear := iYear;
  wDay := 1;
  dtStartMonth := EncodeDate(wYear, wMonth, wDay);
  wDay := DaysInMonth(dtStartMonth);
  dtEndMonth := EncodeDate(wYear, wMonth, wDay);
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT PayID, Sum(Tax) AS Tax FROM tblpays');
    qry.SQL.Add('WHERE Paid = "T" AND Deleted = "F" AND (' + ByWhichDate + ' BETWEEN ' +
      QuotedStr(FormatDateTime(MysqlDateFormat, dtStartMonth)) + ' AND ' +
      QuotedStr(FormatDateTime(MysqlDateFormat, dtEndMonth)) + ')');
    qry.SQL.Add('GROUP BY Paid');
    qry.Open;
    if qry.RecordCount > 0 then begin
      Result := qry.FieldByName('Tax').AsCurrency;
    end else begin
      Result := 0;
    end;

  finally
    // Free our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;


function GetLastTerminationEndDate(const iEmployeeID:integer):TDateTime;
var
  qryEmployee: TERPQuery;
begin
  qryEmployee := TERPQuery.Create(nil);
  try
    qryEmployee.Options.FlatBuffers := True;
    qryEmployee.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryEmployee.SQL.Clear;
    qryEmployee.SQL.Add('SELECT EmployeeID, EndDate FROM tblEmployeeterminations WHERE EmployeeID = :xEmpID '
                         + 'ORDER BY EndDate Desc;');
    qryEmployee.Params.ParamByName('xEmpID').AsInteger := iEmployeeID;
    qryEmployee.Open;
    if qryEmployee.RecordCount > 0 then begin
      qryEmployee.First;
      Result := qryEmployee.FieldByName('EndDate').AsDateTime;
    end else begin
      Result := 0;
    end;
  finally
    if Assigned(qryEmployee) then FreeAndNil(qryEmployee);
  end;
end;


function GetEmployeeStartDate(const EmployeeID:integer): TDateTime;
var
  qryEmployee: TERPQuery;
begin
  qryEmployee := TERPQuery.Create(nil);
  try
    qryEmployee.Options.FlatBuffers := True;
    qryEmployee.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryEmployee.SQL.Clear;
    qryEmployee.SQL.Add('SELECT EmployeeID, DateStarted FROM tblEmployees WHERE EmployeeID = :xEmpID');
    qryEmployee.Params.ParamByName('xEmpID').AsInteger := EmployeeID;
    qryEmployee.Open;
    if qryEmployee.RecordCount > 0 then begin
      Result := qryEmployee.FieldByName('DateStarted').AsDateTime;
    end else begin
      Result := 0;
    end;
  finally
    if Assigned(qryEmployee) then FreeAndNil(qryEmployee);
  end;
end;


//procedure VerifyEmployeeLeave(const DSEmployeeLeave: TDataset);
//var
//  qryLeaveTotals: TERPQuery;
//  bm: TBookmark;
//  WasLocked: boolean;
//begin
//  bm := DSEmployeeLeave.GetBookmark;
//  qryLeaveTotals := TERPQuery.Create(nil);
//  try
//    qryLeaveTotals.Options.FlatBuffers := True;
//    qryLeaveTotals.Connection := CommonDbLib.GetSharedMyDacConnection;
//    DSEmployeeLeave.DisableControls;
//    DSEmployeeLeave.First;
//    while not DSEmployeeLeave.Eof do begin
//      qryLeaveTotals.Close;
//      qryLeaveTotals.SQL.Clear;
//      qryLeaveTotals.SQL.Add('SELECT EmployeeID,LeaveType,Round(Sum(AccruedHours),4) as AccruedHoursTotal ');
//      qryLeaveTotals.SQL.Add('FROM tblleaveaccruals ');
//      qryLeaveTotals.SQL.Add('WHERE EmployeeID=' + IntToStr(DSEmployeeLeave.FieldByName('EmployeeID').AsInteger) + ' ');
//      qryLeaveTotals.SQL.Add('AND LeaveType=' + QuotedStr(DSEmployeeLeave.FieldByName('Type').AsString) + ' ');
//      qryLeaveTotals.SQL.Add('Group By EmployeeID,LeaveType;');
//
//      qryLeaveTotals.Open;
//
//      if qryLeaveTotals.RecordCount <> 0 then begin
//        DSEmployeeLeave.Edit;
//        WasLocked := DSEmployeeLeave.FieldByName('AccruedHours').ReadOnly;
//        DSEmployeeLeave.FieldByName('AccruedHours').ReadOnly := false;
//        DSEmployeeLeave.FieldByName('AccruedDate').ReadOnly := false;
//        DSEmployeeLeave.FieldByName('AccruedHours').AsFloat :=
//          qryLeaveTotals.FieldByName('AccruedHoursTotal').AsFloat + DSEmployeeLeave.FieldByName('OpenningBalanceHrs').AsFloat;
//        DSEmployeeLeave.FieldByName('AccruedDate').AsDateTime :=
//          GetLastPayDate(DSEmployeeLeave.FieldByName('EmployeeID').AsInteger);
//        if WasLocked then begin
//          DSEmployeeLeave.FieldByName('AccruedHours').ReadOnly := true;
//          DSEmployeeLeave.FieldByName('AccruedDate').ReadOnly := true;
//        end;
//        DSEmployeeLeave.Post;
//      end else begin
//        DSEmployeeLeave.Edit;
//        WasLocked := DSEmployeeLeave.FieldByName('AccruedHours').ReadOnly;
//        DSEmployeeLeave.FieldByName('AccruedHours').ReadOnly := false;
//        DSEmployeeLeave.FieldByName('AccruedDate').ReadOnly := false;
//        DSEmployeeLeave.FieldByName('AccruedHours').AsFloat :=
//          0.00 + DSEmployeeLeave.FieldByName('OpenningBalanceHrs').AsFloat;
//        DSEmployeeLeave.FieldByName('AccruedDate').AsDateTime :=
//          GetLastPayDate(DSEmployeeLeave.FieldByName('EmployeeID').AsInteger);
//        if WasLocked then begin
//          DSEmployeeLeave.FieldByName('AccruedHours').ReadOnly := true;
//          DSEmployeeLeave.FieldByName('AccruedDate').ReadOnly := true;
//        end;
//        DSEmployeeLeave.Post;
//      end;
//      DSEmployeeLeave.Next;
//    end;
//  finally
//    DSEmployeeLeave.EnableControls;
//    DSEmployeeLeave.GotoBookmark(bm);
//    DSEmployeeLeave.FreeBookmark(bm);
//    DSEmployeeLeave.Edit;
//    FreeAndNil(qryLeaveTotals);
//  end;
//end;


Function GetTerminationPayID(const iEmployeeID:integer):integer;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('SELECT PayID,EmployeeID FROM tblemployeeterminations WHERE EmployeeID = '+IntToStr(iEmployeeID)+' AND IsPayEntitled = "T"  AND Deleted = "F"');
    qry.Open;
    if qry.RecordCount > 0 then begin
       qry.Last;
       result := qry.FieldByName('PayID').AsInteger;
    end else begin
       result := 0;
    end;
  finally
    FreeAndNil(qry);
  end;
end;


Function GetUnprocessedPayID(const iEmployeeID:integer):integer;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('SELECT PayID FROM tblPays WHERE EmployeeID = '+IntToStr(iEmployeeID)+' AND Paid = "F"  AND Deleted = "F";');
    qry.Open;
    if qry.RecordCount > 0 then begin
       result := qry.FieldByName('PayID').AsInteger;
    end else begin
       result := 0;
    end;
  finally
    FreeAndNil(qry);
  end;
end;


function GetEmployeeAwardClassID(const iEmployeeID: integer): integer;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT EmployeeID, Department FROM tblemployees WHERE EmployeeID = ' + IntToStr(iEmployeeID) + ';');
    qry.Open;
    if qry.RecordCount > 0 then begin
      Result := qry.FieldByName('Department').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function IsUnprocessedPayATimesheet(const iEmployeeID: integer): boolean;
var
  qryPays: TERPQuery;
begin
  qryPays := TERPQuery.Create(nil);
  try
    qryPays.Options.FlatBuffers := True;
    qryPays.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryPays.SQL.Clear;
    qryPays.SQL.Add('SELECT PayID, IsTimeSheet FROM tblPays WHERE EmployeeID = ' + IntToStr(iEmployeeID) + ' AND Paid = "F"');
    qryPays.Open;
    if qryPays.RecordCount > 0 then begin
      if qryPays.FieldByName('IsTimesheet').AsString = 'T' then begin
        Result := true;
      end else begin
        Result := false;
      end;
    end else begin
      Result := false;
    end;
  finally
    if Assigned(qryPays) then FreeAndNil(qryPays);
  end;
end;

function UnprocessedPayExists(const iEmployeeID: integer;const PassedConnection:TERPConnection = nil): integer;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    if Assigned(PassedConnection) then qry.Connection := PassedConnection
    else qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('SELECT EmployeeID,PayID FROM tblPays WHERE EmployeeID=' + QuotedStr(IntToStr(iEmployeeID))+ ' AND PAID <> "T"');
    qry.Open;
    if qry.RecordCount > 0 then begin
      Result := qry.FieldByName('PayID').Asinteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function PayFromDate(const PayDate: TDateTime; const PayPeriod: string): TDateTime;
var
  iDays: integer;
begin
  Result := IncDay(PayDate, - 7);
  if Trim(PayPeriod) = 'Weekly' then begin
    Result := IncDay(PayDate, - 7);
  end else if Trim(PayPeriod) = 'Fortnightly' then begin
    Result := IncDay(PayDate, - 14);
  end else if Trim(PayPeriod) = 'Monthly' then begin
    Result := IncMonth(PayDate, - 1);
  end else if Trim(PayPeriod) = 'Bi-Monthly' then begin
    iDays  := Trunc(DaysInMonth(PayDate) / 2); //get approx half month for bi-month case
    Result := IncDay(PayDate, - iDays);
  end;
  Result := IncDay(Result, 1);
end;

function IsNormalPayRate(const sPayRateName: string): boolean;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT RateID, Multiplier FROM tblpayrates');
    qry.SQL.Add('WHERE Description = ' + QuotedStr(sPayRateName) + ' AND Multiplier = 1;');
    qry.Open;
    if (qry.RecordCount > 0) then begin
      Result := true;
    end else begin
      Result := false;
    end;
  finally
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function IsCorrectMultiplierPayRate(const TestPayRateID, CurrentPayRateID: integer): boolean;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT RateID,MultiplierParentID FROM tblpayrates');
    qry.SQL.Add('WHERE RateID = ' + IntToStr(CurrentPayRateID) + ';');
    qry.Open;
    if (qry.RecordCount > 0) then begin
      if (qry.FieldByName('MultiplierParentID').AsInteger = TestPayRateID) then begin
        Result := true;
      end else begin
        Result := false;
      end;
    end else begin
      Result := false;
    end;
  finally
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function GetNormalHoursMultiplierPayRateRec(const ThisPayRateID: integer;
  const DSEmployeePayRates: TDataset): TEmployeePayRateRec;
var
  bm: TBookmark;
  bInEdit: boolean;
begin
  Result.IsValid := false;
  if DSEmployeePayRates.Active then begin
    if DSEmployeePayRates.State in [dsInsert, dsEdit] then begin
      bInEdit := true;
      DSEmployeePayRates.Post;
    end else begin
      bInEdit := false;
    end;
    bm := DSEmployeePayRates.GetBookmark;
    DSEmployeePayRates.DisableControls;
    try
      DSEmployeePayRates.First;
      while not DSEmployeePayRates.Eof do begin
        if IsCorrectMultiplierPayRate(DSEmployeePayRates.FieldByName('PayRateID').AsInteger, ThisPayRateID) then begin
          Result.IsValid := true;
          Result.RateDept := GetClassName(DSEmployeePayRates.FieldByName('ClassID').AsInteger);
          Result.RateType := GetPayRateType(DSEmployeePayRates.FieldByName('TypeID').AsInteger);
          Result.PayRate := GetPayRate(DSEmployeePayRates.FieldByName('PayRateID').AsInteger);
          Result.Qty := DSEmployeePayRates.FieldByName('Qty').AsFloat;
          Result.Amount := DSEmployeePayRates.FieldByName('Amount').AsFloat;
          Result.HourlyRate := DSEmployeePayRates.FieldByName('HourlyRate').AsFloat;
          Result.LineTotal := DSEmployeePayRates.FieldByName('LineTotal').AsFloat;
          Result.ClassId := DSEmployeePayRates.FieldByName('ClassId').AsInteger;
          Result.TypeID := DSEmployeePayRates.FieldByName('TypeId').AsInteger;
          Result.RateID := DSEmployeePayRates.FieldByName('PayRateId').AsInteger;
          Result.Super := (DSEmployeePayRates.FieldByName('Super').AsString = 'T');
          Break;
        end;
        DSEmployeePayRates.Next;
      end;
    finally
      DSEmployeePayRates.GoToBookmark(bm);
      DSEmployeePayRates.FreeBookmark(bm);
      if bInEdit then begin
        DSEmployeePayRates.Edit;
      end;
      DSEmployeePayRates.EnableControls;
    end;
  end;
end;

function GetPayRateMultiplier(const iPayRateID: integer): double;
var
  qry: TERPQuery;
begin
  Result := 1;
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      SQL.Clear;
      SQL.Add('Select Multiplier FROM tblPayRates WHERE RateID=' + IntToStr(iPayRateID) + ';');
      Open;
      if not IsEmpty then begin
        Result := FieldByName('Multiplier').AsFloat;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function CheckABN(const ABNStr: string): boolean;
var
  arrX: array[1..11] of integer;
  arrY: array[1..11] of integer;
  Remainder: extended;
  ABN: string;
begin
  ABN:= ReplaceStr(ABNStr, ' ', '');
  if char_length(ABN) <> 11 then begin
    CommonLib.MessageDlgXP_Vista('ABN Needs To Be 11 Digits !', mtInformation, [mbOK], 0);
    Result := false;
    Exit;
  end;
  try
    arrY[1]   := 10;
    arrY[2]   := 1;
    arry[3]   := 3;
    arry[4]   := 5;
    arry[5]   := 7;
    arry[6]   := 9;
    arry[7]   := 11;
    arry[8]   := 13;
    arry[9]   := 15;
    arry[10]  := 17;
    arry[11]  := 19;
    arrx[1]   := StrToInt(MidStr(ABN, 1, 1));
    arrx[2]   := StrToInt(MidStr(ABN, 2, 1));
    arrx[3]   := StrToInt(MidStr(ABN, 3, 1));
    arrx[4]   := StrToInt(MidStr(ABN, 4, 1));
    arrx[5]   := StrToInt(MidStr(ABN, 5, 1));
    arrx[6]   := StrToInt(MidStr(ABN, 6, 1));
    arrx[7]   := StrToInt(MidStr(ABN, 7, 1));
    arrx[8]   := StrToInt(MidStr(ABN, 8, 1));
    arrx[9]   := StrToInt(MidStr(ABN, 9, 1));
    arrx[10]  := StrToInt(MidStr(ABN, 10, 1));
    arrx[11]  := StrToInt(MidStr(ABN, 11, 1));
    Remainder := ((arry[1] * (arrx[1] - 1)) + (arry[2] * arrx[2]) + (arry[3] * arrx[3]) +
      (arry[4] * arrx[4]) + (arry[5] * arrx[5]) + (arry[6] * arrx[6]) + (arry[7] * arrx[7]) +
      (arry[8] * arrx[8]) + (arry[9] * arrx[9]) + (arry[10] * arrx[10]) + (arry[11] * arrx[11])) mod 89;
  except
    Remainder := 1;
  end;
  if Remainder = 0 then Result := true
  else Result := false;
end;

function CheckTFN9(const TFN: string): boolean;
var
  arrX: array[1..9] of integer;
  arrY: array[1..9] of integer;
  Remainder: extended;
begin
  arry[1] := 10;
  arry[2] := 7;
  arry[3] := 8;
  arry[4] := 4;
  arry[5] := 6;
  arry[6] := 3;
  arry[7] := 5;
  arry[8] := 2;
  arry[9] := 1;

  arrx[1] := StrToInt(MidStr(TFN, 1, 1));
  arrx[2] := StrToInt(MidStr(TFN, 2, 1));
  arrx[3] := StrToInt(MidStr(TFN, 3, 1));
  arrx[4] := StrToInt(MidStr(TFN, 4, 1));
  arrx[5] := StrToInt(MidStr(TFN, 5, 1));
  arrx[6] := StrToInt(MidStr(TFN, 6, 1));
  arrx[7] := StrToInt(MidStr(TFN, 7, 1));
  arrx[8] := StrToInt(MidStr(TFN, 8, 1));
  arrx[9] := StrToInt(MidStr(TFN, 9, 1));
  Remainder := ((arry[1] * arrx[1]) + (arry[2] * arrx[2]) + (arry[3] * arrx[3]) + (arry[4] * arrx[4]) +
    (arry[5] * arrx[5]) + (arry[6] * arrx[6]) + (arry[7] * arrx[7]) + (arry[8] * arrx[8]) + (arry[9] * arrx[9])) mod 11;
  if Remainder = 0 then Result := true
  else Result := false;
end;

function CheckTFN8(const TFN: string): boolean;
var
  arrX: array[1..8] of integer;
  arrY: array[1..8] of integer;
  Remainder: extended;
begin
  arrY[1] := 10;
  arrY[2] := 7;
  arry[3] := 8;
  arry[4] := 4;
  arry[5] := 6;
  arry[6] := 3;
  arry[7] := 5;
  arry[8] := 1;
  arrx[1] := StrToInt(MidStr(TFN, 1, 1));
  arrx[2] := StrToInt(MidStr(TFN, 2, 1));
  arrx[3] := StrToInt(MidStr(TFN, 3, 1));
  arrx[4] := StrToInt(MidStr(TFN, 4, 1));
  arrx[5] := StrToInt(MidStr(TFN, 5, 1));
  arrx[6] := StrToInt(MidStr(TFN, 6, 1));
  arrx[7] := StrToInt(MidStr(TFN, 7, 1));
  arrx[8] := StrToInt(MidStr(TFN, 8, 1));
  Remainder := ((arry[1] * arrx[1]) + (arry[2] * arrx[2]) + (arry[3] * arrx[3]) + (arry[4] * arrx[4]) +
    (arry[5] * arrx[5]) + (arry[6] * arrx[6]) + (arry[7] * arrx[7]) + (arry[8] * arrx[8])) mod 11;
  if Remainder = 0 then Result := true
  else Result := false;
end;

function IsSub(const Sub, S: string): boolean;
begin
  Result := false;
  if not ((S = '') or (Sub = '')) then begin
    Result := (Pos(Lowercase(Sub), Lowercase(S)) > 0);
  end;
end;

function IsDigits(const S: string): boolean;
var
  i: integer;
begin
  if S = '' then begin
    Result := false;
  end else begin
    Result := true;
    for i := 1 to char_length(S) do begin
      if not IsSub(S[i], '0123456789.,') then begin
        Result := false;
        Break;
      end;
    end;
  end;
end;

function GetHourlyRateTypeID: integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qry.Options.FlatBuffers := True;
    with qry do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT TypeID FROM tblpayratetype ' +
        'WHERE Description = "Hourly Rate" OR Description LIKE "%Hourly Rate%";');
      Open;
      if not IsEmpty then begin
        Result := FieldByName('TypeID').AsInteger;
      end
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function GetNormalHoursPayRatesID: integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qry.Options.FlatBuffers := True;
    with qry do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT RateID FROM tblPayRates ' +
        'WHERE Description = "Normal Hours" OR Description LIKE "%Normal Hours%";');
      Open;
      if not IsEmpty then begin
        Result := FieldByName('RateID').AsInteger;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function GetPaySuperOnLeaveLoading(const iEmployeeID: integer): boolean;
var
  qry: TERPQuery;
begin
  Result := false;
  qry := TERPQuery.Create(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qry.Options.FlatBuffers := True;
    with qry do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT EmployeeID,PaySuperOnLeaveLoading FROM tblemployees WHERE EmployeeID = ' + IntToStr(iEmployeeID) + ';');
      Open;
      if not IsEmpty then begin
        Result := FieldByName('PaySuperOnLeaveLoading').AsBoolean;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function AwardSuperOnLeaveLoading(const iAwardID:integer):Boolean;
var
  qry: TERPQuery;
begin
  Result := True;
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT AwardID, PaySuperOnLeaveLoading FROM tblawards WHERE AwardID = ' +
      IntToStr(iAwardID) + ';');
    qry.Open;
    if qry.RecordCount > 0 then begin
      if (qry.FieldByName('PaySuperOnLeaveLoading').AsString = 'F') then begin
        Result := False;
      end else begin
        Result := True;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

//function SuperThreshold(const iAwardID: integer;Pay: TPayObj): double;
function SuperThreshold(const iAwardID: integer): double;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.Close;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT AwardID, UseCompanySuperThreshold,SuperThresholdAmount FROM tblawards WHERE AwardID = ' +
      IntToStr(iAwardID) + ';');
    qry.Open;
    if qry.RecordCount > 0 then begin
      if (qry.FieldByName('UseCompanySuperThreshold').AsString = 'F') then begin
        Result := qry.FieldByName('SuperThresholdAmount').AsFloat;
      end else begin
        Result := AppEnv.PayPrefs.SuperOverGross;
      end;
    end else begin
      Result := AppEnv.PayPrefs.SuperOverGross;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure LoadAwardRates(const DS_Award, DS_Classification, DS_ClassificationExtraPayRates,
  DS_Employee, DS_EmployeePayRates: TDataset);
var
  dWeeks, dRate, dQty, dAmount: double;
  iPeriod: integer;
begin
  DS_EmployeePayRates.DisableControls;
  DS_ClassificationExtraPayRates.DisableControls;
  try
    dWeeks := GetPayPeriodWeeks(Trim(DS_Award.FieldByName('PayPeriod').AsString));
    // Default Normal Hours
    DS_EmployeePayRates.Insert;
    DS_EmployeePayRates.FieldByName('EmployeeID').AsInteger := DS_Employee.FieldByName('EmployeeID').AsInteger;;
    DS_EmployeePayRates.FieldByName('PayRateID').AsInteger := GetNormalHoursPayRatesID;
    DS_EmployeePayRates.FieldByName('TypeID').AsInteger    := GetPayRateTypeID(DS_Classification.FieldByName('Type').AsString);
    DS_EmployeePayRates.FieldByName('ClassID').AsInteger   := DS_Award.FieldByName('ClassID').AsInteger;
    DS_EmployeePayRates.FieldByName('ClassName').AsString  := GetClassName(DS_EmployeePayRates.FieldByName('ClassID').AsInteger);
    DS_EmployeePayRates.FieldByName('Qty').AsFloat         := AppEnv.CompanyPrefs.HoursPerWeek * dWeeks;

    if Trim(DS_Employee.FieldByName('BasisOfPayment').AsString) = 'F' then begin
      DS_EmployeePayRates.FieldByName('HourlyRate').AsFloat := DS_Classification.FieldByName('FullTime').AsFloat;
    end else if Trim(DS_Employee.FieldByName('BasisOfPayment').AsString) = 'P' then begin
      DS_EmployeePayRates.FieldByName('HourlyRate').AsFloat := DS_Classification.FieldByName('PartTime').AsFloat;
    end else if Trim(DS_Employee.FieldByName('BasisOfPayment').AsString) = 'C' then begin
      DS_EmployeePayRates.FieldByName('HourlyRate').AsFloat :=
        DS_Classification.FieldByName('Casual').AsFloat + (DS_Classification.FieldByName('Casual').AsFloat *
        (DS_Classification.FieldByName('CasualLoading').AsFloat / 100));
    end else begin
      DS_EmployeePayRates.FieldByName('HourlyRate').AsFloat := DS_Classification.FieldByName('FullTime').AsFloat;
    end;

    DS_EmployeePayRates.FieldByName('Super').AsString := 'T';
    dAmount := DS_EmployeePayRates.FieldByName('HourlyRate').AsFloat;
    if (Trim(DS_Classification.FieldByName('Type').AsString) = 'Annual Payment') then begin
      if Trim(DS_Award.FieldByName('PayPeriod').AsString) = 'Weekly' then begin
        iPeriod := 52;
      end else if Trim(DS_Award.FieldByName('PayPeriod').AsString) = 'Fortnightly' then begin
        iPeriod := 26;
      end else if Trim(DS_Award.FieldByName('PayPeriod').AsString) = 'Monthly' then begin
        iPeriod := 12;
      end else if Trim(DS_Award.FieldByName('PayPeriod').AsString) = 'Bi-Monthly' then begin
        iPeriod := 24;
      end else begin
        iPeriod := 52;
      end;
      DS_EmployeePayRates.FieldByName('HourlyRate').AsFloat := RoundCurrency(dAmount);
      DS_EmployeePayRates.FieldByName('LineTotal').AsFloat := RoundCurrency(DivZer(dAmount, iPeriod));
    end else if ((Trim(DS_Classification.FieldByName('Type').AsString) = 'Hourly Rate') or
      (Trim(DS_Classification.FieldByName('Type').AsString) = 'CDEP')) then begin
      dQty := DS_EmployeePayRates.FieldByName('Qty').AsFloat;
      dRate := DS_EmployeePayRates.FieldByName('HourlyRate').AsFloat;
      DS_EmployeePayRates.FieldByName('LineTotal').AsFloat := RoundCurrency(dRate * dQty);
      DS_EmployeePayRates.FieldByName('Amount').AsFloat := RoundCurrency(dRate * dQty);
    end else if (Trim(DS_Classification.FieldByName('Type').AsString) = 'Salary') then begin
      dRate := DS_EmployeePayRates.FieldByName('HourlyRate').AsFloat;
      DS_EmployeePayRates.FieldByName('LineTotal').AsFloat := RoundCurrency(dRate);
    end;

    DS_EmployeePayRates.Post;
    //Extra Pay Rates
    FilterDataset(DS_ClassificationExtraPayRates, '[ClassificationID]=' +
      IntToStr(GetClassificationID(DS_Award.FieldByName('AwardID').AsInteger,
      DS_Employee.FieldByName('Classification').AsString)));
    DS_ClassificationExtraPayRates.First;
    while not DS_ClassificationExtraPayRates.Eof do begin
      DS_EmployeePayRates.Insert;
      DS_EmployeePayRates.FieldByName('EmployeeID').AsInteger := DS_Employee.FieldByName('EmployeeID').AsInteger;
      DS_EmployeePayRates.FieldByName('PayRateID').AsInteger :=
        DS_ClassificationExtraPayRates.FieldByName('PayRate').AsInteger;
      DS_EmployeePayRates.FieldByName('TypeID').AsInteger := DS_ClassificationExtraPayRates.FieldByName('TypeID').AsInteger;
      DS_EmployeePayRates.FieldByName('ClassID').AsInteger := DS_Award.FieldByName('ClassID').AsInteger;
      DS_EmployeePayRates.FieldByName('ClassName').AsString :=
        GetClassName(DS_EmployeePayRates.FieldByName('ClassID').AsInteger);
      DS_EmployeePayRates.FieldByName('Qty').AsFloat := DS_ClassificationExtraPayRates.FieldByName('Worked').AsFloat;
      DS_EmployeePayRates.FieldByName('HourlyRate').AsFloat := DS_ClassificationExtraPayRates.FieldByName('Amount').AsFloat;
      DS_EmployeePayRates.FieldByName('Super').AsString := DS_ClassificationExtraPayRates.FieldByName('SuperInc').AsString;
      DS_EmployeePayRates.FieldByName('Amount').AsFloat := DS_EmployeePayRates.FieldByName('Qty').AsFloat *
        DS_EmployeePayRates.FieldByName('HourlyRate').AsFloat;
      DS_EmployeePayRates.FieldByName('LineTotal').AsFloat := DS_EmployeePayRates.FieldByName('Qty').AsFloat *
        DS_EmployeePayRates.FieldByName('HourlyRate').AsFloat;
      DS_EmployeePayRates.Post;
      DS_ClassificationExtraPayRates.Next;
    end;
  finally
    RemoveFilterDataset(DS_ClassificationExtraPayRates);
    DS_EmployeePayRates.EnableControls;
    DS_ClassificationExtraPayRates.EnableControls;
  end;
end;


procedure LoadAwardDeductions(const DS_Award, DS_ClassificationDeductions, DS_Employee, DS_EmployeeDeductions: TDataset);
var
  qryDeductions: TERPQuery;
begin
  DS_ClassificationDeductions.DisableControls;
  DS_EmployeeDeductions.DisableControls;
  try
    qryDeductions := TERPQuery.Create(nil);
    try
      qryDeductions.Options.FlatBuffers := True;
      qryDeductions.Connection := CommonDbLib.GetSharedMyDacConnection;
      qryDeductions.SQL.Clear;
      qryDeductions.SQL.Add('SELECT * FROM tbldeductions Where Active="T";');
      qryDeductions.Open;
      FilterDataset(DS_ClassificationDeductions, '[ClassificationID]=' +
        IntToStr(GetClassificationID(DS_Award.FieldByName('AwardID').AsInteger,
        DS_Employee.FieldByName('Classification').AsString)));
      DS_ClassificationDeductions.First;
      while not DS_ClassificationDeductions.Eof do begin
        if qryDeductions.Locate('DeductionID', DS_ClassificationDeductions.FieldByName('DeductID').AsInteger, []) then begin
          DS_EmployeeDeductions.Insert;
          DS_EmployeeDeductions.FieldByName('EmployeeID').AsInteger := DS_Employee.FieldByName('EmployeeID').AsInteger;
          DS_EmployeeDeductions.FieldByName('Deduction').AsString := qryDeductions.FieldByName('Description').AsString;
          DS_EmployeeDeductions.FieldByName('DeductionID').AsInteger :=
            DS_ClassificationDeductions.FieldByName('DeductID').AsInteger;
          DS_EmployeeDeductions.FieldByName('BasedOnID').AsInteger :=
            DS_ClassificationDeductions.FieldByName('BasedOnID').AsInteger;
          DS_EmployeeDeductions.FieldByName('Amount').AsFloat := DS_ClassificationDeductions.FieldByName('Amount').AsFloat;
          DS_EmployeeDeductions.FieldByName('Qty').AsFloat := 1;
          DS_EmployeeDeductions.FieldByName('CalcBy').AsString := DS_ClassificationDeductions.FieldByName('CalcBy').AsString;
          DS_EmployeeDeductions.FieldByName('TaxExempt').AsString := qryDeductions.FieldByName('TaxExempt').AsString;
          DS_EmployeeDeductions.FieldByName('UnionFees').AsString := qryDeductions.FieldByName('UnionFees').AsString;
          DS_EmployeeDeductions.FieldByName('ClassID').AsInteger := DS_Award.FieldByName('ClassID').AsInteger;
          DS_EmployeeDeductions.FieldByName('ClassName').AsString :=
            GetClassName(DS_EmployeeDeductions.FieldByName('ClassID').AsInteger);
          DS_EmployeeDeductions.Post;
        end;
        DS_ClassificationDeductions.Next;
      end;
    finally
      FreeAndNil(qryDeductions);
    end;
  finally
    RemoveFilterDataset(DS_ClassificationDeductions);
    DS_ClassificationDeductions.EnableControls;
    DS_EmployeeDeductions.EnableControls;
  end;
end;

procedure LoadAwardAllowances(const DS_Award, DS_ClassificationAllowances, DS_Employee, DS_EmployeeAllowances: TDataset);
var
  qryAllowances: TERPQuery;
begin
  DS_EmployeeAllowances.DisableControls;
  DS_ClassificationAllowances.DisableControls;
  try
    qryAllowances := TERPQuery.Create(nil);
    try
      qryAllowances.Options.FlatBuffers := True;
      qryAllowances.Connection := CommonDbLib.GetSharedMyDacConnection;
      qryAllowances.SQL.Clear;
      qryAllowances.SQL.Add('SELECT * FROM tblallowances Where Active="T";');
      qryAllowances.Open;
      FilterDataset(DS_ClassificationAllowances, '[ClassificationID]=' +
        IntToStr(GetClassificationID(DS_Award.FieldByName('AwardID').AsInteger,
        DS_Employee.FieldByName('Classification').AsString)));
      DS_ClassificationAllowances.First;
      while not DS_ClassificationAllowances.Eof do begin
        if qryAllowances.Locate('AllowanceID', DS_ClassificationAllowances.FieldByName('AllowID').AsInteger, []) then begin
          DS_EmployeeAllowances.Insert;
          DS_EmployeeAllowances.FieldByName('EmployeeID').AsInteger := DS_Employee.FieldByName('EmployeeID').AsInteger;
          DS_EmployeeAllowances.FieldByName('Allowance').AsString := qryAllowances.FieldByName('Description').AsString;
          DS_EmployeeAllowances.FieldByName('AllowanceID').AsInteger :=
            DS_ClassificationAllowances.FieldByName('AllowID').AsInteger;
          DS_EmployeeAllowances.FieldByName('BasedOnID').AsInteger :=
            DS_ClassificationAllowances.FieldByName('BasedOnID').AsInteger;
          DS_EmployeeAllowances.FieldByName('Amount').AsFloat := DS_ClassificationAllowances.FieldByName('Amount').AsFloat;
          DS_EmployeeAllowances.FieldByName('Qty').AsFloat := 1;
          DS_EmployeeAllowances.FieldByName('CalcBy').AsString := DS_ClassificationAllowances.FieldByName('CalcBy').AsString;
          DS_EmployeeAllowances.FieldByName('SuperInc').AsString := qryAllowances.FieldByName('SuperInc').AsString;
          DS_EmployeeAllowances.FieldByName('TaxExempt').AsString := qryAllowances.FieldByName('TaxExempt').AsString;
          DS_EmployeeAllowances.FieldByName('ClassID').AsInteger := DS_Award.FieldByName('ClassID').AsInteger;
          DS_EmployeeAllowances.FieldByName('ClassName').AsString :=
            GetClassName(DS_EmployeeAllowances.FieldByName('ClassID').AsInteger);
          DS_EmployeeAllowances.Post;
        end;
        DS_ClassificationAllowances.Next;
      end;
    finally
      FreeAndNil(qryAllowances);
    end;
  finally
    RemoveFilterDataset(DS_ClassificationAllowances);
    DS_ClassificationAllowances.EnableControls;
    DS_EmployeeAllowances.EnableControls;
  end;
end;


procedure LoadAwardSuper(const DS_Award, DS_Employee, DS_EmployeeSuper: TDataset);
var
  bFound: boolean;
begin
  bFound := false;
  DS_EmployeeSuper.DisableControls;
  try
    DS_EmployeeSuper.First;
    while not DS_EmployeeSuper.Eof do begin
      if Sysutils.SameText(Trim(GetSuperName(DS_EmployeeSuper.FieldByName('SuperTypeID').AsInteger)), 'Super Guarantee') then begin
        bFound := true;
        Break;
      end;
      DS_EmployeeSuper.Next;
    end;
    if not bFound then begin
      DS_EmployeeSuper.Insert;
      DS_EmployeeSuper.FieldByName('EmployeeID').AsInteger := DS_Employee.FieldByName('EmployeeID').AsInteger;
      DS_EmployeeSuper.FieldByName('SuperTypeID').AsInteger := GetSuperTypeID('Super Guarantee');
      DS_EmployeeSuper.Post;
    end;
    DS_EmployeeSuper.Edit;
    DS_EmployeeSuper.FieldByName('Amount').AsFloat     := DS_Award.FieldByName('SuperValue').AsFloat;
    DS_EmployeeSuper.FieldByName('TaxExempt').AsString := 'T';
    DS_EmployeeSuper.FieldByName('TaxRate').AsFloat    := 0.0;
    DS_EmployeeSuper.FieldByName('ClassID').AsInteger  := DS_Award.FieldByName('ClassID').AsInteger;
    DS_EmployeeSuper.FieldByName('ClassName').AsString := GetClassName(DS_EmployeeSuper.FieldByName('ClassID').AsInteger);
    if Trim(DS_Award.FieldByName('SuperType').AsString) = 'Percentage' then begin
      DS_EmployeeSuper.FieldByName('CalcBy').AsString := '%';
    end else begin
      DS_EmployeeSuper.FieldByName('CalcBy').AsString := '$';
    end;
    DS_EmployeeSuper.Post;
  finally
    DS_EmployeeSuper.EnableControls;
  end;
end;

procedure LoadAwardLeave(const DS_Award, DS_AwardLeave, DS_Employee, DS_EmployeeLeave: TDataset);
begin
  DS_AwardLeave.DisableControls;
  DS_EmployeeLeave.DisableControls;
  try
    if (not DatasetEmpty(DS_Award)) and (not DatasetEmpty(DS_Employee)) then begin
      DS_AwardLeave.First;
      while not DS_AwardLeave.Eof do begin
        DS_EmployeeLeave.Insert;
        DS_EmployeeLeave.FieldByName('EmployeeID').AsInteger := DS_Employee.FieldByName('EmployeeID').AsInteger;
        DS_EmployeeLeave.FieldByName('Type').AsString := DS_AwardLeave.FieldByName('Type').AsString;
        DS_EmployeeLeave.FieldByName('AccrueAfterNo').AsFloat := DS_AwardLeave.FieldByName('AccrueAfterNo').AsFloat;
        DS_EmployeeLeave.FieldByName('AccrueAfterPeriod').AsString := DS_AwardLeave.FieldByName('AccrueAfterPeriod').AsString;
        DS_EmployeeLeave.FieldByName('AccrueNo').AsFloat := DS_AwardLeave.FieldByName('AccrueNo').AsFloat;
        DS_EmployeeLeave.FieldByName('AccruePeriod').AsString := DS_AwardLeave.FieldByName('AccruePeriod').AsString;
        DS_EmployeeLeave.FieldByName('AccrueHours').AsFloat := DS_AwardLeave.FieldByName('AccrueHours').AsFloat;
        DS_EmployeeLeave.FieldByName('AccruedHours').ReadOnly := false;
        DS_EmployeeLeave.FieldByName('AccruedDate').ReadOnly := false;
        DS_EmployeeLeave.FieldByName('AccruedHours').AsFloat := 0.00;
        DS_EmployeeLeave.FieldByName('AccruedDate').AsDateTime := Date;
        DS_EmployeeLeave.FieldByName('AccruedHours').ReadOnly := true;
        DS_EmployeeLeave.FieldByName('AccruedDate').ReadOnly := true;

        DS_EmployeeLeave.FieldByName('UseStartEndDates').ReadOnly := false;
        DS_EmployeeLeave.FieldByName('UseStartEndDates').AsString := DS_AwardLeave.FieldByName('UseStartEndDates').AsString;;
        DS_EmployeeLeave.FieldByName('UseStartEndDates').ReadOnly := true;

        DS_EmployeeLeave.FieldByName('StartDate').ReadOnly := false;
        DS_EmployeeLeave.FieldByName('StartDate').AsDateTime := DS_AwardLeave.FieldByName('AwardStartDate').AsDateTime;
        DS_EmployeeLeave.FieldByName('StartDate').ReadOnly := true;

        DS_EmployeeLeave.FieldByName('EndDate').ReadOnly := false;
        DS_EmployeeLeave.FieldByName('EndDate').AsDateTime := DS_AwardLeave.FieldByName('AwardEndDate').AsDateTime;;
        DS_EmployeeLeave.FieldByName('EndDate').ReadOnly := true;

        DS_EmployeeLeave.FieldByName('ClassID').AsInteger := DS_Award.FieldByName('ClassID').AsInteger;
        DS_EmployeeLeave.FieldByName('ClassName').AsString := GetClassName(DS_EmployeeLeave.FieldByName('ClassID').AsInteger);
        DS_EmployeeLeave.FieldByName('LeaveLoading').AsFloat := DS_AwardLeave.FieldByName('LeaveLoading').AsFloat;
        DS_EmployeeLeave.Post;
        DS_AwardLeave.Next;
      end;
    end;
  finally
    DS_AwardLeave.EnableControls;
    DS_EmployeeLeave.EnableControls;
  end;
end;

procedure LoadAwardGeneral(const DS_Award, DS_Employee: TDataset);
begin
  DS_Employee.DisableControls;
  try
    if (not DatasetEmpty(DS_Award)) and (not DatasetEmpty(DS_Employee)) then begin
      DS_Employee.Edit;
      DS_Employee.FieldByName('Department').AsInteger := DS_Award.FieldByName('ClassID').AsInteger;
      DS_Employee.FieldByName('PayPeriod').AsString := DS_Award.FieldByName('PayPeriod').AsString;
      if Trim(DS_Employee.FieldByName('BasisOfPayment').AsString) = 'C' then begin
        DS_Employee.FieldByName('LeaveLoading').AsFloat := 0.00;
      end else begin
        DS_Employee.FieldByName('LeaveLoading').AsFloat := DS_Award.FieldByName('AnnualLeaveLoading').AsFloat;
        DS_Employee.FieldByName('PaySuperOnLeaveLoading').AsString := DS_Award.FieldByName('PaySuperOnLeaveLoading').AsString;
      end;
      DS_Employee.FieldByName('MealBreakHours').AsFloat := DS_Award.FieldByName('MealBreakHours').AsFloat;
      DS_Employee.FieldByName('MealBreakThreshold').AsFloat := DS_Award.FieldByName('MealBreakThreshold').AsFloat;
      DS_Employee.Post;
    end;
  finally
    DS_Employee.EnableControls;
  end;
end;

function GetAwardSickLeaveDaysThreshold(const iAwardID: integer): integer;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT AwardID,SickleaveDaysThreshold FROM tblawards WHERE AwardID = ' + IntToStr(iAwardID) + ';');
    qry.Open;
    Result := qry.FieldByName('SickleaveDaysThreshold').AsInteger;
  finally
    FreeAndNil(qry);
  end;
end;

function AwardInUseByEmployees(const iAwardID: integer): integer;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT EmployeeID FROM tblemployees WHERE Award = ' + IntToStr(iAwardID) + ';');
    qry.Open;
    Result := qry.RecordCount;
  finally
    FreeAndNil(qry);
  end;
end;

function GetClassificationName(const iClassificationID: integer): string;
var
  qry: TERPQuery;
begin
  Result := '';
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('Select ClassificationID,Classification FROM tblAwardClassificationDetails ' +
      'WHERE ClassificationID= ' + IntToStr(iClassificationID) + ';');
    qry.Open;
    if not qry.IsEmpty then begin
      Result := qry.FieldByName('Classification').AsString;
    end
  finally
    FreeAndNil(qry);
  end;
end;

function GetNextClassificationName(const iClassificationID: integer): string;
var
  qry: TERPQuery;
begin
  Result := '';
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('Select ClassificationID,AdvanceToClassification,AwardID FROM tblAwardClassificationDetails ' +
      'WHERE ClassificationID= ' + IntToStr(iClassificationID) + ';');
    qry.Open;
    if not qry.IsEmpty then begin
      Result := qry.FieldByName('AdvanceToClassification').AsString;
    end;
  finally
    FreeAndNil(qry);
  end;
end;



function GetClassificationID(const iAwardID: integer; const sClassificationName: string): integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('Select ClassificationID FROM tblAwardClassificationDetails ' +
      'WHERE AwardID = ' + IntToStr(iAwardID) + ' AND Classification = ' + QuotedStr(sClassificationName) + ';');
    qry.Open;
    if not qry.IsEmpty then begin
      Result := qry.FieldByName('ClassificationID').AsInteger;
    end
  finally
    FreeAndNil(qry);
  end;
end;

function GetAdvanceDate(const AdvanceDescription: string; const StartDate, DOB: TDateTime): TDateTime;
begin
  Result := -1;
  if (Trim(AdvanceDescription) = '6 Weeks') then begin
    Result := IncWeek(StartDate, 6);
  end else if (Trim(AdvanceDescription) = '3 Month') then begin
    Result := IncMonth(StartDate, 3);
  end else if (Trim(AdvanceDescription) = '6 Month') then begin
    Result := IncMonth(StartDate, 6);
  end else if (Trim(AdvanceDescription) = '1 Year') then begin
    Result := IncYear(StartDate, 1);
  end else if (Trim(AdvanceDescription) = '2 Years') then begin
    Result := IncYear(StartDate, 2);
  end else if (Trim(AdvanceDescription) = '3 Years') then begin
    Result := IncYear(StartDate, 3);
  end else if (Trim(AdvanceDescription) = '4 Years') then begin
    Result := IncYear(StartDate, 4);
  end else if (Trim(AdvanceDescription) = '5 Years') then begin
    Result := IncYear(StartDate, 5);
  end else if (Trim(AdvanceDescription) = '6 Years') then begin
    Result := IncYear(StartDate, 6);
  end else if (Trim(AdvanceDescription) = '7 Years') then begin
    Result := IncYear(StartDate, 7);
  end else if (Trim(AdvanceDescription) = '8 Years') then begin
    Result := IncYear(StartDate, 8);
  end else if (Trim(AdvanceDescription) = '9 Years') then begin
    Result := IncYear(StartDate, 9);
  end else if (Trim(AdvanceDescription) = '10 Years') then begin
    Result := IncYear(StartDate, 10);
  end else if (Trim(AdvanceDescription) = '11 Years') then begin
    Result := IncYear(StartDate, 11);
  end else if (Trim(AdvanceDescription) = '12 Years') then begin
    Result := IncYear(StartDate, 12);
  end else if (Trim(AdvanceDescription) = '16 Years Old') then begin
    Result := IncYear(DOB, 16);
  end else if (Trim(AdvanceDescription) = '17 Years Old') then begin
    Result := IncYear(DOB, 17);
  end else if (Trim(AdvanceDescription) = '18 Years Old') then begin
    Result := IncYear(DOB, 18);
  end else if (Trim(AdvanceDescription) = '19 Years Old') then begin
    Result := IncYear(DOB, 19);
  end else if (Trim(AdvanceDescription) = '20 Years Old') then begin
    Result := IncYear(DOB, 20);
  end else if (Trim(AdvanceDescription) = '21 Years Old') then begin
    Result := IncYear(DOB, 21);
  end;
end;

function GetAdvanceClassificationID(const iAwardID: integer; const DS_Employee: TDataset): integer;
var
  qry: TERPQuery;
  TestDate, LastPaid, LowestDate, NextPayDate, StartDate, BirthDate: TDateTime;
  iDays: integer;
  PayPeriod: string;
begin
  Result := 0;
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('Select * FROM tblawardclassificationdetails ' +
      'WHERE AwardID = ' + IntToStr(iAwardID) + ' ORDER BY AdvanceID;');
    qry.Open;
    if not qry.RecordCount <> 0 then begin
      StartDate := DS_Employee.FieldByName('DateStarted').AsDateTime;
      BirthDate := DS_Employee.FieldByName('DOB').AsDateTime;
      LastPaid := DS_Employee.FieldByName('LastPaid').AsDateTime;
      PayPeriod := Trim(DS_Employee.FieldByName('PayPeriod').AsString);
      NextPayDate := LastPaid;
      if Trim(PayPeriod) = '' then begin
        NextPayDate := IncDay(LastPaid, 7);
      end else if Trim(PayPeriod) = 'Weekly' then begin
        NextPayDate := IncDay(LastPaid, 7);
      end else if Trim(PayPeriod) = 'Fortnightly' then begin
        NextPayDate := IncDay(LastPaid, 14);
      end else if Trim(PayPeriod) = 'Monthly' then begin
        NextPayDate := IncMonth(LastPaid, 1);
      end else if Trim(PayPeriod) = 'Bi-Monthly' then begin
        iDays := Trunc(DaysInMonth(LastPaid) / 2); //get approx half month for bi-month case
        NextPayDate := IncDay(LastPaid, iDays);
      end;
      LowestDate := 0;
      qry.First;
      while not qry.Eof do begin
        TestDate := GetAdvanceDate(qry.FieldByName('AdvanceIDName').AsString, StartDate, BirthDate);
        if (TestDate < 0) then begin
          if (Result = 0) then Result := qry.FieldByName('ClassificationID').AsInteger;
          qry.Next;
          Continue;
        end;
        if (NextPayDate >= TestDate) then begin
          Result := GetClassificationID(qry.FieldByName('AwardID').AsInteger,
            GetNextClassificationName(qry.FieldByName('ClassificationID').AsInteger));
        end else begin
          if (LowestDate >= TestDate) or (LowestDate = 0) then begin
            Result := qry.FieldByName('ClassificationID').AsInteger;
            LowestDate := TestDate;
          end;
        end;
        qry.Next;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;


function ForeignKeyFilter(const sMasterFieldName, sForeignKeyFieldName, sTableName, sFilterFieldName,
  sFilterStr: string): string;
var
  DSForeignKey: TDataset;
  DSFilterStr: string;
  Count, iFilterCounter: integer;
  FilterStr: string;
begin
  FilterStr := '';
  DSForeignKey := RetrieveDataset(sTableName, sForeignKeyFieldName, - 1);
  try
    with DSForeignKey do begin
      Count := CharCounter(':', sFilterFieldName);
      DSFilterStr := '';
      for iFilterCounter := 1 to Count do begin
        DSFilterStr := DSFilterStr + '[' + ExtractStrPortion(sFilterFieldName, ':', iFilterCounter)
          + ']=' + QuotedStr(ExtractStrPortion(sFilterStr, ':', iFilterCounter));
        if (iFilterCounter <> Count) then begin
          DSFilterStr := DSFilterStr + ' AND ';
        end;
      end;

      FilterDataset(DSForeignKey, DSFilterStr);
      First;
      while not Eof do begin
        FilterStr := FilterStr + '[' + sMasterFieldName + ']=' + IntToStr(FieldByName(sForeignKeyFieldName).AsInteger) +
          ' OR ';
        Next;
      end;
    end;
    Result := '(' + Copy(FilterStr, 0, char_length(FilterStr) - 4) + ')';
  finally
    FreeAndNil(DSForeignKey);
  end;
end;

function GetBasedOnFilter(const iBasedOnID: integer): string;
var
  sBasedOnName: string;
  iPayRateID: integer;
  iTypeID: integer;
begin
  sBasedOnName := GetBasedOnName(iBasedOnID);
  iPayRateID := GetPayRateID(sBasedOnName);

  if FindInSet(sBasedOnName, 'Pays,Wages,None,Day,Week') then begin
    Result := '';  //All Wages
  end else if FindInSet(sBasedOnName, 'Hours,CDEP Payment') then begin
    iTypeID := 0;
    if FindInSet(sBasedOnName, 'Hours') then begin
      iTypeID := GetPayRateTypeID('Hourly Rate');
    end else if FindInSet(sBasedOnName, 'CDEP Payment') then begin
      iTypeID := GetPayRateTypeID('CDEP');
    end;
    if (iTypeID <> 0) then Result := '[TypeID]=' + IntToStr(iTypeID);  //BasedOn which Is a PayType
  end else if FindInSet(sBasedOnName, 'Km,Items') then begin
    Result := '';
  end else if iPayRateID <> 0 then begin
    Result := '[PayRateID]=' + IntToStr(iPayRateID);  //BasedOn which Is a PayRate
  end else begin
    Result := '[Amount]=Null';   //No Wages
  end;
end;

function GetLeaveTypeID(const sLeaveType: string): integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT LeaveTypeID FROM tblleavetypes WHERE LeaveType = ' + QuotedStr(sLeaveType) + ';');
      Open;
      if not IsEmpty then begin
        Result := FieldByName('LeaveTypeID').AsInteger;
      end
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function GetLeaveType(const iRateID: integer): string;
var
  qry: TERPQuery;
begin
 // Result := 0;
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT RateID,Description FROM tblpayrates WHERE RateID = ' + IntToStr(iRateID) + ';');
      Open;
      Result := FieldByName('Description').AsString;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function GetLeaveLoading(const EmployeeID: integer;const sType:String): double;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
//  qry.Connection := CommonDbLib.GetNewMyDacConnection(nil);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT EmployeeID,LeaveLoading,Type FROM tblleave WHERE EmployeeID = ' + IntToStr(EmployeeID));
    qry.SQL.Add(' AND Type = ' + QuotedStr(sType));
    qry.Open;
    Result := qry.FieldByName('LeaveLoading').AsFloat / 100;
  finally
    FreeAndNil(qry);
  end;
end;


function GetEmployeePayRateTypeID(const iEmpID:integer): integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT EmployeeID,TypeID FROM tblemployeepayrates WHERE EmployeeID = ' + QuotedStr(IntToStr(iEmpID) + ';'));
      Open;
      if not IsEmpty then begin
        Result := FieldByName('TypeID').AsInteger;
      end
    end;
  finally
    FreeAndNil(qry);
  end;
end;


function GetPayRateID(const sPayRate: string): integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT RateID FROM tblPayRates WHERE Description = ' + QuotedStr(sPayRate) + ';');
      Open;
      if not IsEmpty then begin
        Result := FieldByName('RateID').AsInteger;
      end
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function GetPayRate(const iPayRateID: integer): string;
var
  qry: TERPQuery;
begin
  Result := '';
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT Description FROM tblPayRates WHERE RateID = ' + IntToStr(iPayRateID) + ';');
      Open;
      if not IsEmpty then begin
        Result := FieldByName('Description').AsString;
      end
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function GetAllowanceName(const iAllowanceID: integer): string;
var
  qry: TERPQuery;
begin
  Result := '';
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT AllowanceID,Description FROM tblAllowances WHERE AllowanceID = ' + IntToStr(iAllowanceID) + ';');
      Open;
      if not IsEmpty then begin
        Result := FieldByName('Description').AsString;
      end
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function GetSundryName(const iSundryID: integer): string;
var
  qry: TERPQuery;
begin
  Result := '';
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT SundryID,SundryDesc FROM tblsundrytypes WHERE SundryID = ' + IntToStr(iSundryID) + ';');
      Open;
      if not IsEmpty then begin
        Result := FieldByName('SundryDesc').AsString;
      end
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function GetPayRegion(const iPayID: integer): String;
var
  qry: TERPQuery;
begin
  Result := '';
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT PayID,Region FROM tblpays WHERE PayID = ' + IntToStr(iPayID) + ';');
      Open;
      if not IsEmpty then begin
        Result := FieldByName('Region').AsString;
      end
    end;
  finally
    FreeAndNil(qry);
  end;
end;


function GetAllowanceAccountID(const iAllowanceID: integer): integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT AllowanceID,AccountID FROM tblAllowances WHERE AllowanceID = ' + IntToStr(iAllowanceID) + ';');
      Open;
      if not IsEmpty then begin
        Result := FieldByName('AccountID').AsInteger;
      end
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function GetCommissionName(const iCommissionID: integer): string;
var
  qry: TERPQuery;
begin
  Result := '';
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT CommissionID,CommissionDesc FROM tblcommissiontypes WHERE CommissionID=' + IntToStr(iCommissionID) + ';');
      Open;
      if not IsEmpty then begin
        Result := FieldByName('CommissionDesc').AsString;
      end
    end;
  finally
    FreeAndNil(qry);
  end;
end;


function GetCommissionPeriod(const iPeriodID: integer): string;
var
  qry: TERPQuery;
begin
  Result := '';
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT PeriodID,Period FROM tblcommissionperiod WHERE PeriodID=' + IntToStr(iPeriodID) + ';');
      Open;
      if not IsEmpty then begin
        Result := FieldByName('Period').AsString;
      end
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function GetDeductionAccountID(const iDeductionID:integer):integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT DeductionID,AccountID FROM tblDeductions WHERE DeductionID =  ' + IntToStr(iDeductionID) + ';');
      Open;
      if not IsEmpty then begin
        Result := FieldByName('AccountID').AsInteger;
      end
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function GetDeductionName(const iDeductionID: integer): string;
var
  qry: TERPQuery;
begin
  Result := '';
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT DeductionID,Description FROM tblDeductions WHERE DeductionID =  ' + IntToStr(iDeductionID) + ';');
      Open;
      if not IsEmpty then begin
        Result := FieldByName('Description').AsString;
      end
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function GetDeductionID(const DeductionName: String): Integer;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT DeductionID,Description FROM tblDeductions WHERE Description =  ' + QuotedStr(DeductionName) + ';');
      Open;

      Result := FieldByName('DeductionID').AsInteger;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function GetAllowanceID(const AllowanceName: String): Integer;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT AllowanceID,Description FROM tblAllowances WHERE Description =  ' + QuotedStr(AllowanceName) + ';');
      Open;

      Result := FieldByName('AllowanceID').AsInteger;
    end;
  finally
    FreeAndNil(qry);
  end;
end;



(*function GetPayRateTypeID(const sRateType: string): integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT TypeID FROM tblPayRateType WHERE Description = ' + QuotedStr(sRateType) + ';');
      Open;
      if not IsEmpty then begin
        Result := FieldByName('TypeID').AsInteger;
      end
    end;
  finally
    FreeAndNil(qry);
  end;
end;*)

function GetPayRateType(const iRateTypeID: integer): string;
var
  qry: TERPQuery;
begin
  Result := '';
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT TypeID,Description FROM tblPayRateType WHERE TypeID = ' + IntToStr(iRateTypeID) + ';');
      Open;
      if not IsEmpty then begin
        Result := FieldByName('Description').AsString;
      end
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function GetBasedOnName(const iBasedOnID: integer): string;
var
  qry: TERPQuery;
begin
  Result := '';
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT BasedOnID,BasedOn FROM tblallowancebasedon WHERE BasedOnID =' + IntToStr(iBasedOnID) + ';');
      Open;
      if not IsEmpty then begin
        Result := FieldByName('BasedOn').AsString;
      end
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function IsLeave(const iRateID: integer): boolean;
var
  qry: TERPQuery;
begin
  Result := false;
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT RateID,IsLeave FROM tblPayRates WHERE RateID = ' + IntToStr(iRateID) + ';');
      Open;
      if not IsEmpty then begin
        Result := (qry.FieldByName('IsLeave').AsString = 'T');
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;


function GetBasedOnID(const sBasedOnName: string): integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT BasedOnID FROM tblallowancebasedon WHERE BasedOn =' + QuotedStr(sBasedOnName) + ';');
      Open;
      if not IsEmpty then begin
        Result := FieldByName('BasedOnID').AsInteger;
      end
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function GetBasedOnRate(const aBasedOnId, aPayId: integer; var aRate: double; conn: TCustomMyConnection): boolean;
var
  qry: TERPQuery;
begin
  aRate:= 0;
  qry := TERPQuery.Create(nil);
  try
    qry.Connection:= conn;
    qry.SQL.Text:=
      'select pr.Amount from tblPaysPayRates pr, tblAllowanceBasedOn abo, tblpayrates r ' +
      'where abo.BasedOn = r.Description and r.RateId = pr.PayRateId ' +
      'and pr.PayId = ' + IntToStr(aPayId) + ' and abo.BasedOnId = ' + IntToStr(aBasedOnId);
    qry.Open;
    result:= not qry.IsEmpty;
    if result then
      aRate:= qry.FieldByName('Amount').AsFloat;
  finally
    qry.Free;
  end;
end;

function FindInSet(const Str, StrList: string): boolean;
var
  Index: integer;
  StringArray: TStringDynArray;
begin
  Result := false;
  StringArray:= SplitString(StrList,',');
  for Index := Low(StringArray) to High(StringArray) do begin
    if uppercase(Trim(StringArray[Index])) = uppercase(Trim(Str)) then begin
      Result := true;
      Break;
    end;
  end;
end;

function AvgField(const Dataset: TDataset; const FieldName: string): double;
var
  bm: TBookmark;
  I: integer;
  Totals: double;
begin
  I := 0;
  Totals := 0.00;
  Result := 0.00;
  if not DatasetOk(Dataset) then Exit;
  if (Dataset.FindField(FieldName) = nil) then Exit;
  with Dataset do begin
    bm := GetBookmark;
    DisableControls;
    First;
    while not Eof do begin
      Inc(I);
      Totals := Totals + FieldByName(FieldName).AsFloat;
      Next;
    end;
    Result := Divzer(Totals, I);
    EnableControls;
    GotoBookmark(bm);
    FreeBookmark(bm);
    Dataset.Edit;
  end;
end;

function SumNonAccumLeave(const Dataset: TDataset; const FieldName: string): double;
var
  bm: TBookmark;
begin
  Result := 0.00;
  if not DatasetOk(Dataset) then Exit;
  if (Dataset.FindField(FieldName) = nil) then Exit;
  with Dataset do begin
    bm := GetBookmark;
    DisableControls;
    First;
    while not Eof do begin
      if GetPayTypeDescription(FieldByName('PayRateID').AsInteger)  = 'Pay without leave' then  Result := Result + FieldByName(FieldName).AsFloat;
      Next;
    end;
    EnableControls;
    GotoBookmark(bm);
    FreeBookmark(bm);
    Dataset.Edit;
  end;
end;
function GetPayTypeDescription(iTypeID:integer):string;
var
  qry : TERPQuery;
begin
  result := '';
  qry := TERPQuery.Create(nil);
  try
    qry.Connection  := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT RateID,Description FROM tblpayrates WHERE RateID = ' + IntToStr(iTypeID));
      Open;
      result := FieldByName('Description').AsString;
    end;
  finally
    FreeAndNil(qry);
  end;
end;
function SumField(const Dataset: TDataset; const FieldName: string): double;
var
  bm: TBookmark;
begin
  Result := 0.00;
  if not DatasetOk(Dataset) then Exit;
  if (Dataset.FindField(FieldName) = nil) then Exit;
  with Dataset do begin
    bm := GetBookmark;
    DisableControls;
    First;
    while not Eof do begin
      Result := Result + FieldByName(FieldName).AsFloat;
      Next;
    end;
    EnableControls;
    GotoBookmark(bm);
    FreeBookmark(bm);
    Dataset.Edit;
  end;
end;

Procedure DebugDeleteEntirePayTrans(Dataset:TDataset);
begin
  try
    if (Dataset.RecordCount > 0) then begin
        Dataset.First;
        while not Dataset.Eof do begin
          Dataset.Delete;
        end;
    end;
  except
    on E: EDatabaseError do;
  end;
end;

procedure DeleteEntireDataset(Dataset: TDataset);
begin
  try
    //if Dataset.Name <> 'PaysTrans' then begin
      if (Dataset.RecordCount > 0) then begin
        Dataset.First;
        while not Dataset.Eof do begin
          Dataset.Delete;
        end;
      end;
    //end;

  except
    on E: EDatabaseError do;
  end;
end;

procedure PostDataset(Dataset: TDataset);
begin
  try
    if not Dataset.Active then Exit;
    if (Dataset.RecordCount > 0) and (Dataset.State in [dsEdit, dsInsert]) then begin
      Dataset.Post;
      Dataset.Edit;
    end;
  except
    on E: EDatabaseError do;
  end;
end;

procedure DatasetToEditMode(Dataset: TDataset);
begin
  try
    if (Dataset.RecordCount > 0) and not (Dataset.State in [dsEdit, dsInsert]) then begin
      Dataset.Edit;
    end;
  except
    on E: EDatabaseError do;
  end;
end;

procedure FilterDataset(const Dataset: TDataset; const FilterStr: string);
begin
  if not DatasetOk(Dataset) then Exit;
  with Dataset do begin
    DisableControls;
    try
      Filtered := false;
      Filter := FilterStr;
      Filtered := true;
      Last;
      First;
    except
    end;
  end;
end;

procedure RemoveFilterDataset(const Dataset: TDataset);
begin
  if not DatasetOk(Dataset) then Exit;
  with Dataset do begin
    try
      Filtered := false;
      Filter := '';
      Last;
      First;
    except
    end;
    EnableControls;
  end;
end;


procedure DeleteEntireTable(const sTableName, sMasterKeyName: string; const MasterID: integer);
begin
  with TERPQuery.Create(nil) do begin
    Options.FlatBuffers := True;
    Connection := CommonDbLib.GetSharedMyDacConnection;
    Sql.Clear;
    if (MasterID<>-1) then begin
      Sql.Add(Format('DELETE FROM `%s` WHERE %s = %d;', [sTableName, sMasterKeyName, MasterID]));
    end else begin
      Sql.Add(Format('DELETE FROM `%s`;', [sTableName]));
    end;
    Execute;
  end;
end;

function RetrievePaysDataset(const sTableName, sMasterKeyName: string; const MasterID: integer): TDataset;
begin
  Result := TERPQuery.Create(nil);
  with TERPQuery(Result) do begin
    Options.FlatBuffers := True;
    Connection := CommonDbLib.GetSharedMyDacConnection;
    Sql.Clear;
    if sTableName = 'tblpays' then begin
      if (MasterID<>-1) then begin
        Sql.Add(Format('SELECT * FROM tblpays WHERE %s = %d AND Deleted = "F";', [sMasterKeyName, MasterID]));
      end else begin
        Sql.Add('SELECT * FROM tblpays WHERE Deleleted = "F";');
      end;
    end else begin
      if (MasterID<>-1) then begin
        Sql.Add('SELECT A.*,P.PayID,P.Deleted FROM ');
        Sql.Add(Format('%s as A INNER JOIN tblpays as P on A.PayID = P.PayID WHERE A.%s = %d AND P.Deleted = "F";', [sTableName, sMasterKeyName, MasterID]));
      end else begin
        Sql.Add('SELECT A.*,P.PayID,P.Deleted FROM ');
        Sql.Add(Format('%s as A INNER JOIN tblpays as P on A.PayID = P.PayID WHERE P.Deleted = "F" ;', [sTableName]));
      end;
    end;
    Open;
  end;
end;

function DatasetOk(const Dataset: TDataset): boolean;
begin
  try
    if Assigned(Dataset) then begin
      Result := true;
      if Dataset.Active then begin
        //Auto Post
        PostDataset(Dataset);
      end else begin
        Result := false;
      end;
    end else begin
      Result := false;
    end;
  except
    Result := false;
  end;
end;

function DatasetEmpty(const Dataset: TDataset): boolean;
begin
  Result := true;
  try
    if DatasetOk(Dataset) then begin
      if (Dataset.RecordCount <> 0) then begin
        Result := false;
      end;
    end;
  except
    Result := true;
  end;
end;

function GetMonthlyGrossTotal(const iEmployeeID: integer; const dtPayDate: TDateTime; const PayID: integer = 0;const PassedConnection:TMyDacDataConnection = nil): double;
var
  qryPays: TERPQuery;
  wDay, wMonth, wYear: word;
  dtStartDate{, dtEndDate}: TDateTime;
begin
  qryPays := TERPQuery.Create(nil);
  try
    qryPays.Options.FlatBuffers := True;

    if Assigned(PassedConnection) then qryPays.Connection := TERPConnection(TMyDacDataConnection(PassedConnection).MyDacConnection)
      else qryPays.Connection := CommonDbLib.GetSharedMyDacConnection;

    qryPays.SQL.Clear;
    qryPays.SQL.Add('SELECT Sum(Gross) AS TotalGross FROM tblpays');
    qryPays.SQL.Add('WHERE EmployeeID = :xEmployeeID AND Paid = "T" AND Deleted = "F" AND (PayDate BETWEEN :dtFrom AND :dtTo) ');
//    qryPays.SQL.Add(' AND PayID <> :xPayID ');
    DecodeDate(dtPayDate, wYear, wMonth, wDay);
    dtStartDate := EncodeDate(wYear, wMonth, 1);

    dtStartDate := IncMonth(dtStartDate,-1);

    qryPays.Params.ParamByName('dtFrom').AsDateTime := dtStartDate;
    qryPays.Params.ParamByName('dtTo').AsDateTime := dtPayDate;
    qryPays.Params.ParamByName('xEmployeeID').AsInteger := iEmployeeID;
//    qryPays.Params.ParamByName('xPayID').AsInteger := PayID;
    qryPays.Open;
    if qryPays.RecordCount > 0 then begin
      Result := qryPays.FieldByName('TotalGross').AsFloat;
    end else begin
      Result := 0.00;
    end;
  finally
    FreeAndNil(qryPays);
  end;
end;

// By Wang 2021.08.12, 09.22
function GetTaxComponentUSA(const iTaxScaleID: Integer; const dWeeklyTaxable: Double; const iEmpID: Integer;
                            const sGroupType: string; const sTaxType: string; const sPayPeriod: string;
                            var varGross, varA, varC, varD: Double) : Double;
var
  K : integer;

  arrA: array[1..12] of Double;
  arrB: array[1..12] of Double;
  arrC: array[1..12] of Double;
  arrD: array[1..12] of Double;
  arrE: array[1..12] of Double;

  TaxScales : TERPQuery;
  dGross, dTax : Double;
  W4 : TFormW4;
begin
  Result := 0.00;

  if dWeeklyTaxable = 0.00 then Exit;

  for K := low(arrA) to high(arrA) do arrA[K] := 0;
  for K := low(arrB) to high(arrB) do arrB[K] := 0;
  for K := low(arrC) to high(arrC) do arrC[K] := 0;
  for K := low(arrD) to high(arrD) do arrD[K] := 0;
  for K := low(arrE) to high(arrE) do arrE[K] := 0;

  TaxScales := CommonDbLib.TempMyQuery;
  try
    TaxScales.SQL.Add('SELECT ScaleID, A, B, C, D, E FROM tbltax_us WHERE ScaleID=' + IntToStr(iTaxScaleID) + ' ORDER BY TaxID');
    TaxScales.Open;
    TaxScales.First;

    K := 1;
    while not TaxScales.EOF do begin
      if K > High(arrA) then begin
        CommonLib.MessageDlgXP_Vista('Tax for the Pay scale ID #' + IntToStr(iTaxScaleID)+' is more than 12. Please Contact ERP', mtInformation, [mbOK], 0);
        Result := 0.0;
        Exit;
      end
      else begin
        arrA[K] := TaxScales.FieldByName('A').AsFloat;
        arrB[K] := TaxScales.FieldByName('B').AsFloat;
        arrC[K] := TaxScales.FieldByName('C').AsFloat;
        arrD[K] := TaxScales.FieldByName('D').AsFloat;
        arrE[K] := TaxScales.FieldByName('E').AsFloat;
        K := K + 1;
      end;
      TaxScales.Next;
    end;

    TaxScales.Close;

    if (sGroupType = 'State') and (sTaxType = 'Employee') then begin
      dGross := dWeeklyTaxable;

      if sPayPeriod = 'Fortnightly' then begin
        dGross := dGross * 2;
      end else if sPayPeriod = 'Monthly' then begin
        dGross := (dGross * 13) / 3;
      end else if sPayPeriod = 'Bi-Monthly' then begin
        dGross := ((dGross * 13) / 3) / 2;
      end;
    end
    else
      dGross := dWeeklyTaxable * 52;   // Yearly gross

    K := 1;
    repeat
      if (dGross >= arrA[K]) and ((dGross < arrB[K]) or (arrB[K] = 0)) then begin
        dTax := arrC[K] + (dGross - arrA[K]) * arrD[K];

        varGross := dGross;
        varA := arrA[K];
        varC := arrC[K];
        varD := arrD[K];

        Break;
      end;

      K := K + 1;
    until K > High(arrA);

    if (sGroupType = 'State') and (sTaxType = 'Employee') then begin
      if sPayPeriod = 'Fortnightly' then begin
        dTax := dTax / 2;
      end else if sPayPeriod = 'Monthly' then begin
        dTax := (dTax * 3) / 13;
      end else if sPayPeriod = 'Bi-Monthly' then begin
        dTax := (dTax * 2 * 3) / 13;
      end;
    end
    else
      dTax := dTax / 52;   // Yearly gross

    // To perform step3 and step4 of the percentage method
    if (sGroupType = 'Federal') and (sTaxType = 'Employee') then begin
      W4 := TFormW4.Create(nil);
      W4.LoadSelect('EmployeeID=' + IntToStr(iEmpID));

      // Step 3
      if W4.Count > 0 then begin  // Submitted Form W-4 2020 or later
        dTax := dTax - W4.Dependent;   // W-4 3
      end;

      // Step 4
      if W4.Count > 0 then begin  // Submitted Form W-4 2020 or later
        dTax := dTax + W4.ExtraWithholding;   // W-4 3
      end;

      W4.Destroy;
    end;

    Result := RoundCurrency(dTax);

  finally
    FreeAndNil(TaxScales);
  end;
end;

function GetTaxComponent(const iTaxScaleID: integer; const dWeeklyGross: double;const sPayPeriod: string; IsPayVerify: Boolean; TaxAllowanceAmount: double = 0; EmployeeId: integer = 0): double;
var
  t: integer;
  intC: integer;
  (*intJ: integer;*)
  TaxCalcOn: double;
  arrT: array[1..50] of double;
  arrA: array[1..50] of double;
  arrB: array[1..50] of double;
  TaxScales: TERPQuery;
  dTax: double;
  qry: TERPQuery;
  maxYearAmount: double;
begin
  Result := 0.00;
  if (dWeeklyGross = 0.00) then begin
    Exit;
  end;

  if (AppEnv.RegionalOptions.RegionType <> rAUST) and (EmployeeId > 0) then begin
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
    try
      qry.SQL.Text := 'select Maximum from tbltaxscales where ScaleId = ' + IntToStr(iTaxScaleID);
      qry.Open;
      maxYearAmount := qry.FieldByName('Maximum').AsFloat;
      qry.Close;
      if maxYearAmount > 0 then begin
        qry.SQL.Clear;
        qry.SQL.Add('select sum(Gross) as Amount from tblpays where EmployeeID = ' + IntToStr(EmployeeID));
        qry.SQL.Add('and Deleted = "F" and Paid = "T"');
        qry.SQL.Add('and PayDate > "' + FormatDateTime('yyyy',now) + '-01-01' + '"');
        qry.Open;
        if qry.FieldByName('Amount').AsFloat >= maxYearAmount then begin
          { we have exceeded the maximum so no tax }
          exit;
        end;
      end;
    finally
      qry.Close;
      DbSharedObj.ReleaseObj(qry);
    end;

  end;

  for t := low(arrT) to high(arrT) do arrT[t]:= 0;
  for t := low(arrA) to high(arrA) do arrT[t]:= 0;
  for t := low(arrB) to high(arrB) do arrT[t]:= 0;

  Result := 0.00;
  if (dWeeklyGross = 0.00) then begin
    Exit;
  end;
  // calculate weekly tax
  TaxScales := (*TERPQuery.Create(nil);*)CommonDbLib.TempMyQuery;
  try
    (*TaxScales.Options.FlatBuffers := True;
    TaxScales.Connection := CommonDbLib.GetSharedMyDacConnection;*)

    if IsPayVerify AND TableExists('tmp_tblpaystax') then begin
      TaxScales.SQL.Add('Select ScaleID,Threshold,A,B FROM tmp_tblpaystax WHERE ScaleID=' + IntToStr(iTaxScaleID) + '  ORDER BY TaxID;');
    end  else begin
      TaxScales.SQL.Add('Select ScaleID,Threshold,A,B FROM tblTax WHERE ScaleID=' + IntToStr(iTaxScaleID) + '  ORDER BY TaxID;');
    end;

    TaxScales.Open;
    TaxScales.First;
    intC := 1;
//    intJ := 10;
    t    := 1;
    while not TaxScales.Eof do begin
      if t > high(arrT) then begin
        CommonLib.MessageDlgXP_Vista('Tax for the Pay scale ID #'+ IntToStr(iTaxScaleID)+' is more than 12. Please Contact ERP', mtInformation, [mbOK], 0);
        result:= 0;
        exit;
      end else begin
        arrT[t] := TaxScales.FieldByName('Threshold').AsFloat;
        arrA[t] := TaxScales.FieldByName('A').AsFloat;
        arrB[t] := TaxScales.FieldByName('B').AsFloat;
        t := t + 1;
      end;
      TaxScales.Next;
    end;
    TaxScales.Close;
    TaxCalcOn := 0;
    dTax      := 0.00;
    TaxCalcOn := TaxCalcOn + dWeeklyGross;
    repeat
      if AppEnv.RegionalOptions.RegionType <> rAUST then begin
        if TaxCalcOn <= (arrT[intC] + TaxAllowanceAmount) then begin
          try
            dTax := (arrA[intC] * TaxCalcOn) - arrB[intC] - TaxAllowanceAmount;
            if dTax < 0 then dTax := 0;
          except
          end;
          break;
        end;
      end
      else begin
        if TaxCalcOn < arrT[intC] then begin
          try
            dTax := ((arrA[intC] * (Int(TaxCalcOn) + 0.99)) - arrB[intC]); {ATO NAT 1004}
          except
          end;
          Break;
        end;
      end;
      intC := intC + 1;
    until intC > High(arrT);

//    dTax := DecimalRoundDbl(dTax, 0, drHalfUp); {ATO NAT 1004}

    // cal the pay period equivalent tax
    if sPayPeriod = 'Fortnightly' then begin
      dTax := dTax * 2;
    end else if sPayPeriod = 'Monthly' then begin
      dTax := (dTax * 13) / 3;
    end else if sPayPeriod = 'Bi-Monthly' then begin
      dTax := ((dTax * 13) / 3) / 2;
    end;

//    Result := DecimalRoundDbl(dTax, 0, drHalfUp);

   { 16//8/2013 Dene wanted this changed (rounded to 2 places) to match
                total of tax postings! }

    Result := RoundCurrency(dTax);

  finally
    FreeAndNil(TaxScales);
  end;
end;

function GetEmployeeAge(const DOB, PayDate: TDateTime): integer;
begin
  Result := Floor((DaysBetween(PayDate, DOB)) / 365.25);
end;

function GetNumberOfPays(const iEmployeeID: integer; const AsOfDate: TDateTime; const ByPayPeriod: boolean): integer;
var
  qryPays: TERPQuery;
begin
  qryPays := TERPQuery.Create(nil);
  try
    qryPays.Options.FlatBuffers := True;
    qryPays.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qryPays do begin
      SQL.Clear;
      if ByPayPeriod then begin
        SQL.Add('SELECT Sum(PayPeriods) as Count FROM tblPays ');
      end else begin
        SQL.Add('SELECT Count(PayID) as Count FROM tblPays ');
      end;
      SQL.Add('WHERE Paid = "T" AND Deleted = "F" AND PayDate<=:xAsDate AND EmployeeID=:xEmployeeID;');
      Params.ParamByName('xEmployeeID').AsInteger := iEmployeeID;
      Params.ParamByName('xAsDate').AsDateTime := AsOfDate;
      Open;
      if not IsEmpty then begin
        Result := FieldByName('Count').AsInteger
      end else begin
        Result := 0;
      end;
    end;
  finally
    FreeAndNil(qryPays);
  end;
end;

function PaysBetweenDates(const iEmployeeID: integer; const FromDate, ToDate: TDateTime;
  const ExcludePayID: integer): integer;
var
  qryPays: TERPQuery;
begin
  qryPays := TERPQuery.Create(nil);
  try
    qryPays.Options.FlatBuffers := True;
    qryPays.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qryPays do begin
      SQL.Clear;
      SQL.Add('SELECT Count(PayID) as Count FROM tblPays ');
      SQL.Add('WHERE Paid = "T" AND Deleted = "F" ');
      SQL.Add('AND PayID<>:ExcludePayID ');
      SQL.Add('AND PayDate Between :txtfrom AND :txtto ');
      SQL.Add('AND EmployeeID=:xEmployeeID ');
      Params.ParamByName('xEmployeeID').AsInteger := iEmployeeID;
      Params.ParamByName('txtfrom').AsDateTime := FromDate;
      Params.ParamByName('txtto').AsDateTime := ToDate;
      Params.ParamByName('ExcludePayID').AsInteger := ExcludePayID;
      Open;
      if not IsEmpty then begin
        Result := FieldByName('Count').AsInteger
      end else begin
        Result := 0;
      end;
    end;
  finally
    FreeAndNil(qryPays);
  end;
end;

function GetSuperName(const iSuperTypeID: integer): string;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT SuperTypeID,Description FROM tblSuperType WHERE SuperTypeID = :xSuperTypeID');
      Params.ParamByName('xSuperTypeID').AsInteger := iSuperTypeID;
      Open;
      if not IsEmpty then begin
        Result := FieldByName('Description').AsString;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function GetSuperTypeID(const sSuperName: string): integer;
var
  qry: TERPQuery;
begin
  Result := 0;
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      SQL.Clear;
      SQL.Add('SELECT SuperTypeID,Description FROM tblSuperType WHERE Description = :xDescription;');
      Params.ParamByName('xDescription').AsString := sSuperName;
      Open;
      if not IsEmpty then begin
        Result := FieldByName('SuperTypeID').AsInteger;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function NoPaysExistForEmployee(const iEmployeeID:integer):Boolean;
var
  qryPays: TERPQuery;
begin
  Result := True;
  qryPays := TERPQuery.Create(nil);
  try
    qryPays.Options.FlatBuffers := True;
    with qryPays do begin
      Connection := CommonDbLib.GetSharedMyDacConnection;
      SQL.Clear;
      if (iEmployeeID = 0) then begin
        exit;
      end else begin
        SQL.Add('SELECT PayID, Deleted,EmployeeID,Paid FROM tblPays WHERE EmployeeID = ' + IntToStr(iEmployeeID) +
          ' and Paid = "F" AND Deleted = "F" ;');
      end;
      Open;
      if RecordCount > 0 then Result := False;
    end;
  finally
    FreeAndNil(qryPays);
  end;
end;

function GetLastPayDate(const iEmployeeID:integer; const PassedConnection: TMyDacDataConnection = nil): TDateTime;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Options.FlatBuffers := True;
    with qry do begin
      if Assigned(PassedConnection) then Connection := TERPConnection(TMyDacDataConnection(PassedConnection).MyDacConnection)
      else Connection := CommonDbLib.GetSharedMyDacConnection;
      SQL.Clear;
      if iEmployeeID <> 0 then begin
        SQL.Add('SELECT EmployeeID, LastPaid FROM tblemployeepaysettings WHERE EmployeeID = ' + IntToStr(iEmployeeID));
        Open;
        Result := FieldByName('LastPaid').AsDateTime;
      end else begin
        SQL.Add('SELECT PayID, PayDate FROM tblpays WHERE Pay = "T" AND Paid <> "T" AND Deleted = "F" AND PayDate <> 0 ORDER BY PayDate DESC LIMIT 1;');
        Open;
        if RecordCount <> 0 then begin
          Last;
          Result := FieldByName('PayDate').AsDateTime;
        end else begin
          Result := 0;
        end;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function GetLastPayDateFromPays(const iEmployeeID: integer; const PassedConnection: TERPConnection = nil): TDateTime;
var
  qry: TERPQuery;
  conn: TERPConnection;
begin
  result := 0;
  if iEmployeeID = 0 then
    exit;
  if Assigned(PassedConnection) then conn := PassedConnection
  else conn := CommonDbLib.GetSharedMyDacConnection;
  qry := DbSharedObj.GetQuery(conn);
  try
    qry.SQL.Add('select max(PayDate) as PayDate from tblpays');
    qry.SQL.Add('where EmployeeID = ' + IntToStr(iEmployeeID));
    qry.SQL.Add('and paid = "T" and Deleted = "F"');
    qry.Open;
    if not qry.IsEmpty then
      result := qry.FieldByName('PayDate').AsDateTime
    else begin
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('select DateStarted FROM tblemployees WHERE EmployeeID = ' + IntToStr(iEmployeeID));
      qry.Open;
      result := qry.FieldByName('DateStarted').AsDateTime;
    end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

//function GetLastPayDate(const iEmployeeID: integer): TDateTime;
//var
//  qryPays: TERPQuery;
//begin
//  qryPays := TERPQuery.Create(nil);
//  try
//    qryPays.Options.FlatBuffers := True;
//    with qryPays do begin
//      Connection := CommonDbLib.GetSharedMyDacConnection;
//      SQL.Clear;
//      if (iEmployeeID = 0) then begin
//        SQL.Add('SELECT PayID, PayDate FROM tblpays WHERE Pay = "T" AND Paid <> "T" AND Deleted = "F" AND PayDate <> 0 ORDER BY PayDate DESC LIMIT 1;');
//      end else begin
//        SQL.Add('SELECT PayID, PayDate FROM tblPays WHERE EmployeeID = ' + IntToStr(iEmployeeID) +
//          ' and Paid = "T" AND Deleted = "F" ORDER BY PayDate DESC LIMIT 1;');
//      end;
//      Open;
//      if qryPays.RecordCount <> 0 then begin
//        qryPays.Last;
//        Result := qryPays.FieldByName('PayDate').AsDateTime;
//      end else begin
//        if (iEmployeeID <> 0) then begin
//          SQL.Clear;
//          SQL.Add('SELECT EmployeeID, DateStarted FROM tblemployees WHERE EmployeeID = ' + IntToStr(iEmployeeID) + ';');
//          Open;
//          if qryPays.RecordCount <> 0 then begin
//            Result := qryPays.FieldByName('DateStarted').AsDateTime;
//          end else begin
//            Result := 0;
//          end;
//        end else begin
//          Result := 0;
//        end;
//      end;
//    end;
//    if (Result = 0) then Result := Now;
//  finally
//    FreeAndNil(qryPays);
//  end;
//end;

procedure ReallyDeletePayRecords(const sTableName: string; const iPayID: integer);
var
  qry: TERPCommand;
begin
  qry := TERPCommand.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('DELETE FROM `' + sTableName + '` WHERE PayID = ' + IntToStr(iPayID) + ';');
    qry.Execute;
  finally
    FreeAndNil(qry);
  end;
end;

procedure ReallyDeletePayRecords(const sTableName: string; const ThisPay: Tpaybase);
var
  qry: TERPCommand;
begin
  qry := TERPCommand.Create(nil);
  try
    qry.Connection := ThisPay.Connection.Connection;
    qry.SQL.Add('DELETE FROM `' + sTableName + '` WHERE PayID = ' + IntToStr(ThisPay.PayID) + ';');
    qry.Execute;
  finally
    FreeAndNil(qry);
  end;
end;

procedure DeletePayRecords(const sTableName: string; const iPayID: integer);
var
  qry: TERPCommand;
begin
  qry := TERPCommand.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
//    qry.SQL.Add('DELETE FROM `' + sTableName + '` WHERE PayID = ' + IntToStr(iPayID) + ';');
    qry.SQL.Add('UPDATE tblpays SET Deleted= "T" WHERE PayID= ' + IntToStr(iPayID) + ';');
    qry.Execute;

//    qry.SQL.Add('UPDATE tblpays SET Deleted= "T" WHERE PayID= ' + IntToStr(iPayID) + ';');
//    qry.Execute;
  finally
    FreeAndNil(qry);
  end;
end;


function NumberOfThisDayInFiscalYear(const PayDate: TDateTime; const StepinDays: integer): integer;
var
  I: integer;
  YearEnd, tmpDate: TDateTime;
  Year, Month, WeekOfMonth, DayOfWeek, PayDayOfWeek: word;
begin
  I := 0;
  Result := 1;
  DecodeDateMonthWeek(GetCurrentFiscalYearStart(PayDate), Year, Month, WeekOfMonth, DayOfWeek);
  DecodeDateMonthWeek(PayDate, Year, Month, WeekOfMonth, PayDayOfWeek);
  while (PayDayOfWeek <> DayOfWeek) do begin
    DecodeDateMonthWeek(IncDay(GetCurrentFiscalYearStart(PayDate), I), Year, Month, WeekOfMonth, DayOfWeek);
    I := I + 1;
  end;
  tmpDate := IncDay(GetCurrentFiscalYearStart(PayDate), I);
  YearEnd := IncYear(GetCurrentFiscalYearStart(PayDate));
  while not (tmpDate > YearEnd) do begin
    tmpDate := IncDay(tmpDate, StepinDays);
    Inc(Result);
  end;
  Result := Result - 1;
end;


function GetPayPeriodWeeks(const Period: string): double;
begin
  Result := 0;
  if (Trim(Period) = '1 Week') then begin
    Result := 1;
  end else if (Trim(Period) = '2 Weeks') then begin
    Result := 2;
  end else if (Trim(Period) = '3 Weeks') then begin
    Result := 3;
  end else if (Trim(Period) = '4 Weeks') then begin
    Result := 4;
  end else if (Trim(Period) = 'Monthly') then begin
    Result := (13 / 3);
  end else if (Trim(Period) = '1 Month') then begin
    Result := (13 / 3);
  end else if (Trim(Period) = '2 Months') then begin
    Result := (13 / 3) * 2;
  end else if (Trim(Period) = '3 Months') then begin
    Result := (13 / 3) * 3;
  end else if (Trim(Period) = '4 Months') then begin
    Result := (13 / 3) * 4;
  end else if (Trim(Period) = '5 Months') then begin
    Result := (13 / 3) * 5;
  end else if (Trim(Period) = '6 Months') then begin
    Result := (13 / 3) * 6;
  end else if (Trim(Period) = 'Annually') then begin
    Result := 52;
  end else if (Trim(Period) = 'Weekly') then begin
    Result := 1;
  end else if (Trim(Period) = 'Fortnightly') then begin
    Result := 2;
  end;
end;

function RemoveCents(const dAmount: double): double;
begin
  Result := DecimalRoundDbl(dAmount, 0, drRndDown);
end;

function GetTotalOfReportableFringeBenefits(const iEmpID: integer; const dtTo, dtFrom: TDateTime): double;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  qry.Options.FlatBuffers := True;
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT Sum(FBTReportable) AS FringeBenefits FROM tblfbt WHERE (EmployeeID = ' + IntToStr(iEmpID) + ' AND');
    qry.SQL.Add('(YearEnding BETWEEN ' + QuotedStr(FormatDateTime(MysqlDateFormat, dtFrom)) + ' AND ' +
      QuotedStr(FormatDateTime(MysqlDateFormat, dtTo)) + '));');
    qry.Open;
    if qry.RecordCount > 0 then begin
      Result := qry.FieldByName('FringeBenefits').AsCurrency;
    end else begin
      Result := 0.00;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function ConvertHoursToWorkingDays(const iTotalHours: double; const sPayPeriod: string; const dNormalHrs: double): double;
var
//  iHoursInADay: TDateTime;
//  wHour, wMin, wSec, wMSec: word;
  dHrsPerDay: double;
begin
  dHrsPerDay := 0;
  if sPayPeriod = 'Weekly' then begin
    dHrsPerDay := dNormalHrs/7;
  end;
  if sPayPeriod = 'Fortnightly' then begin
    dHrsPerDay := dNormalHrs/14;
  end;
  if sPayPeriod = 'Monthly' then begin
    dHrsPerDay := dNormalHrs/4.33333;
  end;

  Result := divzer(iTotalHours, dHrsPerDay);

//  iHoursInADay := (AppEnv.CompanyPrefs.EndOfDay - AppEnv.CompanyPrefs.StartOfDay);
//  DecodeTime( dHrsPerDay, wHour, wMin, wSec, wMSec);
//  Result := divzer(iTotalHours, wHour);
end;

end.
