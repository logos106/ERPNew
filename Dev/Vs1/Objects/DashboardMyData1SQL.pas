unit DashboardMyData1SQL;

interface

uses
  ReportBaseObj, Classes;

Type
  TDashboardMyData1 = Class(TReportBase)
  private
    fiEmployeeID: Integer;

  protected
  public
    constructor Create; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): Boolean; override;

  published
    property EmployeeID: Integer read   fiEmployeeID  write fiEmployeeID;

  End;

implementation

uses CommonLib, SysUtils, DateUtils, ERPDbComponents, JSONObject, CommonDbLib, MySQLConst,
      ProfitAndLossSQL, LogLib;
{ TPartClass }

constructor TDashboardMyData1.Create;
begin
  inherited;

  fiEmployeeID := 0;
end;

function TDashboardMyData1.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
begin
  Result := inherited;

  SQL.Clear;
  SQL.Add('SELECT * FROM tmp_vs1_dashboard_my_set1 WHERE EmployeeID=' + IntToStr(fiEmployeeID));
end;

initialization
  RegisterClass(TDashboardMyData1);

end.
