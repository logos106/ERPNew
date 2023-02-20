unit DashboardMyData3SQL;

interface

uses
  ReportBaseObj, Classes;

Type
  TDashboardMyData3 = Class(TReportBase)
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

constructor TDashboardMyData3.Create;
begin
  inherited;

  fiEmployeeID := 0;
end;

function TDashboardMyData3.PopulateReportSQL(SQL: TStrings; var msg: string): Boolean;
begin
  Result := inherited;

  SQL.Clear;
  SQL.Add('SELECT * FROM tmp_vs1_dashboard_my_set3 WHERE EmployeeID=' + IntToStr(fiEmployeeID));
end;

initialization
  RegisterClass(TDashboardMyData3);

end.
