unit ProfitAndLossPeriodCompareSQL;

interface

uses
  ERPDbComponents, DAScript, SysUtils, classes, Types, DB, ReportBaseObj,
  ReportSQLProfitAndLossPeriod;

type
  TProfitAndLossPeriodReportBase = class(TReportBase)
  private
  protected
    fDateTo: TDateTime;
    fPeriodType: string;
    fDateFrom: TDateTime;

    fIncludedataPriorToClosingDate: boolean;

    fReportSQLObj: TReportSQLProfitAndLossBase;//TProfitandLossPeriodCompare;

    function GetPreDataJson: string; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; Overload;override;
    function PopulateReportSQL(SQL: TStrings; var msg: string; SQLHeading, SQLDetails :String ): boolean; Overload;
  published
    property IncludePriorClosingDate: boolean read fIncludedataPriorToClosingDate write fIncludedataPriorToClosingDate;

    property DateFrom: TDateTime read fDateFrom write fDateFrom;
    property DateTo: TDateTime read fDateTo write fDateTo;


   { month, quarter, year }
    property PeriodType: string read fPeriodType write fPeriodType;
  end;

  TProfitAndLossPeriodCompareReport = Class(TProfitAndLossPeriodReportBase)
    Private
    Protected
    Public
      constructor Create; override;
  End;

  TProfitAndLossPeriodReport = Class(TProfitAndLossPeriodReportBase)
    Private
    Protected
    Public
      constructor Create; override;
  End;


implementation

uses
  (*AppEnvironment,*) StrUtils, DateUtils, (*DnMLib, *)JsonObject(*, utCloudconst*),
  DateTimeUtils, UtilsLib,
  AppEnvironmentVirtual, Dialogs;

{ TProfitAndLossPeriodReportBase }

constructor TProfitAndLossPeriodReportBase.Create;
begin
  inherited;
  //fReportSQLObj := TProfitandLossPeriodCompare.Create(nil);
  fDateTo := EndOfAMonth(YearOf(Date), MonthOf(Date));
  fDateFrom := Trunc(IncDay(IncYear(fDateTo, -2), 1));
  fPeriodType := Month1;
  fIncludedataPriorToClosingDate := true;
end;

destructor TProfitAndLossPeriodReportBase.Destroy;
begin
  fReportSQLObj.Free;
  inherited;
end;

function TProfitAndLossPeriodReportBase.GetPreDataJson: string;
begin
  result :=inherited GetPreDataJson;
(*  result :=
    '"Params":{' + #13#10 +
    '"DateFrom":"' + FormatDateTime(JsonDateTimeFormat,DateFrom) + '",' + #13#10 +
    '"DateTo":"' + FormatDateTime(JsonDateTimeFormat,DateTo) + '",' + #13#10 +
    '"PeriodType":"' + PeriodType + '"' + #13#10 +
    '}';*)
end;


function TProfitAndLossPeriodReportBase.PopulateReportSQL(SQL: TStrings; var msg: string; SQLHeading, SQLDetails :String ): boolean;
begin
  Result := PopulateReportSQL(SQL, msg);
  SQLHeading := fReportSQLobj.ReportSQLMain_Heading;
  SQLDetails := fReportSQLobj.ReportSQLMain_Details;
end;


function TProfitAndLossPeriodReportBase.PopulateReportSQL(SQL: TStrings;  var msg: string): boolean;
begin
  Result := inherited;
  fReportSQLobj.employeeID := AppEnvVirt.Int['Employee.employeeID'];// EmployeeId;//Appenv.Employee.EmployeeID;
  fReportSQLobj.IncludedataPriorToClosingDate := IncludePriorClosingDate;

  if SameText(PeriodType, Months12) then begin
    fReportSQLobj.Periodtype := ptYear;
    if (DateFrom <> GetCurrentFiscalYearStart(DateFrom)) then
      DateFrom := GetCurrentFiscalYearStart(DateFrom);
    if (DateTo <> (IncYear(GetCurrentFiscalYearStart(DateTo),1) -1)) then
      DateTo := IncYear(GetCurrentFiscalYearStart(DateTo),1) -1;
  end else if SameText(PeriodType, Months6) then begin
    fReportSQLobj.Periodtype := pt6Month;
    if (DateFrom <> StartOfTheMonth(DateFrom)) then
      DateFrom := StartOfTheMonth(DateFrom);
    if (DateTo <> EndOfTheMonth(DateTo)) then
      DateTo := EndOfTheMonth(DateTo);
    if trunc(monthsbetween(datefrom, dateto)/6) <>monthsbetween(datefrom, dateto) then
      DateTo := EndOfTheMonth(incmonth(DateTo,5));
  end else if SameText(PeriodType, Months3) then begin
    fReportSQLobj.Periodtype := ptQuarter;
    if (DateFrom <> StartOfTheQuarter(DateFrom)) then
      DateFrom := StartOfTheQuarter(DateFrom);
    if (DateTo <> EndOfTheQuarter(DateTo)) then
      DateTo := EndOfTheQuarter(DateTo);
  end else if SameText(PeriodType, Months2) then begin
    fReportSQLobj.Periodtype := pt2Month;
    if (DateFrom <> StartOfTheMonth(DateFrom)) then
      DateFrom := StartOfTheMonth(DateFrom);
    if (DateTo <> EndOfTheMonth(DateTo)) then
      DateTo := EndOfTheMonth(DateTo);
    if trunc(monthsbetween(datefrom, dateto)/2) <>monthsbetween(datefrom, dateto) then
      DateTo := EndOfTheMonth(incmonth(DateTo,1));
  end else  begin
    fReportSQLobj.Periodtype := ptMonth;
    if (DateFrom <> StartOfTheMonth(DateFrom)) then
      DateFrom := StartOfTheMonth(DateFrom);
    if (DateTo <> EndOfTheMonth(DateTo)) then
      DateTo := EndOfTheMonth(DateTo);
  end;

  fReportSQLobj.DateFrom := IncMinute(DateFrom, 1);
  fReportSQLobj.DateTo := IncMinute(DateTo, -1);
//  fReportSQLobj.DateFrom := DateFrom;
//  fReportSQLobj.DateTo := DateTo;

  if not fReportSQLobj.Prepareforreport then begin
    Result := false;
    msg := ReplaceStr(ReplaceStr(fReportSQLobj.UserLock.LockMessage, 'Unable to update data.' , 'Unable to lock Transaction Table.') , 'record' , 'Table');
    exit;
  end;

  //fReportSQLobj.MakeMainQryTable;

  SQL.Clear;
  SQL.Add(fReportSQLobj.ReportSQLMain);

(*  SQL.add('Select * from ' +
    fReportSQLobj.Qrymaintablename +  ','
    ' order by FinalOrder,AccountHeaderOrder,AccountSub1Order,AccountSub2Order ,AccountSub3Order,TotalAmount');*)
end;

{ TProfitAndLossPeriodCompareReport }

constructor TProfitAndLossPeriodCompareReport.Create;
begin
  inherited;
  fReportSQLObj := TProfitandLossPeriodCompare.Create(nil);
end;

{ TProfitAndLossPeriodReport }

constructor TProfitAndLossPeriodReport.Create;
begin
  inherited;
  fReportSQLObj := TReportSQLProfitAndLossPeriod.Create(nil);
end;

initialization
  RegisterClass(TProfitAndLossPeriodCompareReport);
  RegisterClass(TProfitAndLossPeriodReport);


end.
