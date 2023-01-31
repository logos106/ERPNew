unit ProjectTasksListSQL;

interface

uses
  ReportBaseObj, Classes;

Type
  TProjectTasksList = Class(TReportWithDateRangeBase)
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

constructor TProjectTasksList.Create;
begin
  inherited;
  DateFrom := MinDateTime;
  DateTo := MaxDateTime;
end;

function TProjectTasksList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
begin
  Result := inherited;

  SQL.Clear;
  SQL.Add('SELECT pt.*, e.Email AS AssignEmail, e.Phone AS AssignPhone, c.Email AS ContactEmail, c.Phone AS ContactPhone');
  SQL.Add('FROM tblProjectTasks pt');
  SQL.Add('LEFT JOIN tblemployees e ON pt.AssignID=e.EmployeeID');
  SQL.Add('LEFT JOIN tblclients c ON pt.CustomerID=c.ClientID');
  SQL.Add('WHERE 1');

  if Search <> '' then SQL.Add('AND ' + Search);

  if OrderBy <> '' then SQL.Add('ORDER BY ' + OrderBy);

end;

initialization
  RegisterClass(TProjectTasksList);

end.
