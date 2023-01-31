unit SupplierVS1ListSQL;

interface

uses
  ReportBaseObj, Classes;

Type
  TSupplierVS1List = Class(TReportWithDateRangeBase)
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

constructor TSupplierVS1List.Create;
begin
  inherited;
  DateFrom := MinDateTime;
  DateTo := MaxDateTime;
end;

function TSupplierVS1List.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
begin
  Result := inherited;

  SQL.Clear;
  SQL.Add('SELECT *');
  SQL.Add('FROM tblClients');
  SQL.Add('WHERE Supplier="T" AND PublishOnVS1="T"');

  if Search <> '' then SQL.Add(' AND ' + Search);

  if OrderBy <> '' then SQL.Add('ORDER BY ' + OrderBy);

end;

initialization
  RegisterClass(TSupplierVS1List);

end.
