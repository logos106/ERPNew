unit EmployeeListSQL;

interface

uses
  ReportBaseObj, Classes;

Type
  TEmployeeList = Class(TReportWithDateRangeBase)
  private
  protected
  public
    constructor Create; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;

  End;

implementation

uses CommonLib, SysUtils, DateUtils, ERPDbComponents, JSONObject, CommonDbLib, MySQLConst,
      ProfitAndLossSQL, LogLib, PQALib, ProductQtyLib, tcConst, busobjStockMovement, LogUtils;
{ TPartClass }

constructor TEmployeeList.Create;
begin
  inherited;
  DateFrom := MinDateTime;
  DateTo := MaxDateTime;
end;

function TEmployeeList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
begin
  Result := inherited;

  SQL.Clear;
  SQL.Add('SELECT *');
  SQL.Add('FROM tblEmployees');
  SQL.Add('WHERE 1');

  if Search <> '' then SQL.Add(' AND ' + Search);

  if OrderBy <> '' then SQL.Add('ORDER BY ' + OrderBy);

end;

initialization
  RegisterClass(TEmployeeList);

end.
