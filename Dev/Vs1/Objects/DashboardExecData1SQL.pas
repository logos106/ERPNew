unit DashboardExecData1SQL;

interface

uses
  ReportBaseObj, Classes;

Type
  TDashboardExecData1 = Class(TReportBase)
  private
    fDTFrom1, fDTTo1: TDateTime;
    fDTFrom2, fDTTo2: TDateTime;
    fSelDate: TDateTime;

  protected
  public
    constructor Create; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): Boolean; override;

  published
    property SelDate: TDateTime   read fSelDate   write fSelDate;
  End;

implementation

uses CommonLib, SysUtils, DateUtils, ERPDbComponents, JSONObject, CommonDbLib, MySQLConst,
      ProfitAndLossSQL, LogLib;
{ TPartClass }

constructor TDashboardExecData1.Create;
begin
  inherited;
  fSelDate := 0;
 end;

function TDashboardExecData1.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
begin
  Result := inherited;

//  CreateTemporaryTable();

  SQL.Clear;

  SQL.Add('SELECT * FROM tmp_vs1_dashboard_exec_set1');


end;
initialization
  RegisterClass(TDashboardExecData1);

end.
