unit ServiceLogListSQL;

interface

uses
  ReportBaseObj, Classes;

Type
  TServiceLogList = Class(TReportWithDateRangeBase)
  private
    fiFilterOn: Integer;

  protected
  public
    constructor Create; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;

  published
    property FilterOn: Integer read fiFilterOn write fiFilterOn;

  End;

implementation

uses CommonLib, SysUtils, DateUtils, ERPDbComponents, JSONObject, CommonDbLib, MySQLConst,
      ProfitAndLossSQL, LogLib, PQALib, ProductQtyLib, tcConst, busobjStockMovement, LogUtils;
{ TPartClass }

constructor TServiceLogList.Create;
begin
  inherited;

  fiFilterOn := 0;
  DateFrom := MinDateTime;
  DateTo := MaxDateTime;
end;

function TServiceLogList.PopulateReportSQL(SQL: TStrings; var msg: string): Boolean;
var
  fsDateFrom: String;
  fsDateTo: String;
begin
  Result := inherited;

  fsDateFrom := FormatDateTime(MysqlDateFormat, DateFrom);
  fsDateTo := FormatDateTime(MysqlDateFormat, DateTo);

  SQL.Clear;
  SQL.Add('SELECT ');
  SQL.Add('GlobalRef AS GlobalRef,');
  SQL.Add('ServiceID AS ServiceID,');
  SQL.Add('AssetID AS AssetID,');
  SQL.Add('AssetCode AS AssetCode,');
  SQL.Add('AssetName AS AssetName,');
  SQL.Add('ServiceProvider AS ServiceProvider,');
  SQL.Add('ServiceDate AS ServiceDate,');
  SQL.Add('NextServiceDate AS NextServiceDate,');
  SQL.Add('SUBSTRING(ServiceNotes, 1, 255) AS ServiceNotes,');
  SQL.Add('HoursFornextService AS Hours,');
  SQL.Add('KmsForNextService AS Kms,');
  SQL.Add('done as Done');
  SQL.Add('FROM tblfixedassetservicelog');
  SQL.Add('WHERE ((ServiceDate BETWEEN ' + QuotedStr(fsDateFrom) + ' AND ' + QuotedStr(fsDateTo) + ' AND ' + IntToStr(fiFilterOn) + ' = 0) OR (NextServiceDate BETWEEN ' + QuotedStr(fsDateFrom) + ' AND ' + QuotedStr(fsDateFrom) + ' AND ' + IntToStr(fiFilterOn) + ' = 1))');

  if Search <> '' then SQL.Add(' AND ' + Search);

  if OrderBy <> '' then SQL.Add('ORDER BY ' + OrderBy);

end;

initialization
  RegisterClass(TServiceLogList);

end.
