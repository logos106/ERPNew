unit DashboardSalesData1SQL;

interface

uses
  ReportBaseObj, Classes;

Type
  DashboardSalesData1 = Class(TReportBase)
  private
  protected
  public
    constructor Create; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): Boolean; override;
  published

  End;

implementation

uses CommonLib, SysUtils, DateUtils, ERPDbComponents, JSONObject, CommonDbLib, MySQLConst,
      ProfitAndLossSQL, LogLib;
{ TPartClass }

constructor DashboardSalesData1.Create;
begin
  inherited;
 end;

function DashboardSalesData1.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
begin
  Result := inherited;

  SQL.Clear;
  SQL.Add('SELECT * FROM tmp_vs1_dashboard_sales_set1');
end;

initialization
  RegisterClass(DashboardSalesData1);

end.
