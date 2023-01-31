unit ProductStocknsalePeriodSQL;

interface
uses
  ERPDbComponents, DAScript, SysUtils, classes, Types, DB, ReportBaseObj,
  ReportSqlProductStocknSalePeriod;

type
  TProductStocknSalePeriodReport = class(TReportWithDateRangeBase)
  private
  protected
    //fDateTo: TDateTime;
    fPeriodType: string;
    //fDateFrom: TDateTime;
    fIncludedataPriorToClosingDate: boolean;
    fReportSQLObj: TReportSqlProductStocknSalePeriod;//TProfitandLossPeriodCompare;

    function GetPreDataJson: string; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  published
    property IncludePriorClosingDate: boolean read fIncludedataPriorToClosingDate write fIncludedataPriorToClosingDate;
    //property DateFrom: TDateTime read fDateFrom write fDateFrom;
    //property DateTo: TDateTime read fDateTo write fDateTo;
    { month, quarter, year }
    property PeriodType: string read fPeriodType write fPeriodType;
  end;

implementation

uses JSONObject, dateutils, DNMLib;

{ TProductStocknSalePeriodReport }

constructor TProductStocknSalePeriodReport.Create;
begin
  inherited;
  DateTo := EndOfAMonth(YearOf(Date),MonthOf(Date));
  DateFrom := Trunc(IncDay(IncYear(DateTo,-1),1));
  fPeriodType := 'Month';
  fIncludedataPriorToClosingDate := true;
  fReportSQLObj := TReportSqlProductStocknSalePeriod.Create(nil);
end;

destructor TProductStocknSalePeriodReport.Destroy;
begin
  fReportSQLObj.Free;
  inherited;
end;

function TProductStocknSalePeriodReport.GetPreDataJson: string;
begin
  result :=inherited GetPreDataJson;
  (*result :=  '"Params":{' + #13#10 +
    '"DateFrom":"' + FormatDateTime(JsonDateTimeFormat,DateFrom) + '",' + #13#10 +
    '"DateTo":"' + FormatDateTime(JsonDateTimeFormat,DateTo) + '",' + #13#10 +
    '"PeriodType":"' + PeriodType + '"' + #13#10 +
    '}';*)

end;

function TProductStocknSalePeriodReport.PopulateReportSQL(SQL: TStrings;
  var msg: string): boolean;
begin
  result := inherited;
  if SameText(PeriodType, 'Quarter') then begin
    fReportSQLobj.Periodtype := ptQuarter;
    if (DateFrom <> StartOfTheQuarter(DateFrom)) then
      DateFrom := StartOfTheQuarter(DateFrom);
    if (DateTo <> EndOfTheQuarter(DateTo)) then
      DateTo := EndOfTheQuarter(DateTo);
  end
  else if SameText(PeriodType, 'Year') then begin
    fReportSQLobj.Periodtype := ptYear;
    if (DateFrom <> GetCurrentFiscalYearStart(DateFrom)) then
      DateFrom := GetCurrentFiscalYearStart(DateFrom);
    if (DateTo <> (IncYear(GetCurrentFiscalYearStart(DateTo),1) -1)) then
      DateTo := IncYear(GetCurrentFiscalYearStart(DateTo),1) -1;
  end
  else begin { Month }
    fReportSQLobj.Periodtype := ptMonth;
    if (DateFrom <> StartOfTheMonth(DateFrom)) then
      DateFrom := StartOfTheMonth(DateFrom);
    if (DateTo <> EndOfTheMonth(DateTo)) then
      DateTo := EndOfTheMonth(DateTo);
  end;


  fReportSQLobj.DateFrom := DateFrom;
  fReportSQLobj.DateTo := DateTo;
  fReportSQLobj.Prepareforreport;

  fReportSQLobj.MakeMainQryTable(SQL);

(*  SQL.add('Select M.*, H.* from ' +
    fReportSQLobj.Qrymaintablename + ' M, '+ fReportSQLobj.Qrymaintablename +'_CH H'+
    ' order by Productname');*)
end;
initialization
  RegisterClass(TProductStocknSalePeriodReport);

end.
