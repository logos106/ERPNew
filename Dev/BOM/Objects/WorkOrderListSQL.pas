unit WorkOrderListSQL;

interface

uses
  ReportBaseObj, Classes;

Type
  TWorkOrderList = class(TReportWithDateRangeBase)
  private
  protected
  public
    constructor Create; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;

  published

  End;

implementation

uses CommonLib, SysUtils, DateUtils, ERPDbComponents, JSONObject, CommonDbLib, MySQLConst,
      ProfitAndLossSQL, LogLib, PQALib, ProductQtyLib, tcConst, busobjStockMovement, LogUtils;
{ TPartClass }

constructor TWorkOrderList.Create;
begin
  inherited;

  DateFrom := MinDateTime;
  DateTo := MaxDateTime;
end;

function TWorkOrderList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
var
  sDateFrom: String;
  sDateTo: String;
begin
  Result := inherited;

  sDateFrom := FormatDateTime(MysqlDateFormat, DateFrom);
  sDateTo := FormatDateTime(MysqlDateFormat, DateTo);

  SQL.Clear;
  SQL.Add('SELECT');
  SQL.Add('CONVERT(PCT.ProcessTimeId, unsigned) AS ProcessTimeId,');
  SQL.Add('PP.ID AS PPid, PT.ProctreeId AS ProctreeId,');
  SQL.Add('S.saleId AS saleId, SL.saleLineId AS saleLineId, ');
  SQL.Add('S.CustomerName AS CustomerName, S.SaleDate AS SaleDate,');
  SQL.Add('SL.ShipDate AS ShipDate, PT.Caption AS Caption,');
  SQL.Add('REPLACE(CONVERT(TreeNodeCaption(PT.Level, PT.caption ), CHAR(255)),"," , "\n") CaptionIntend,');
  SQL.Add('E.EmployeeName AS EmployeeName, PR.ResourceName AS ResourceName,');
  SQL.Add('PRD.Description as ResourceDetailName, (PCT.TimeStart) as TimeStart ,');
  SQL.Add('DATE(PCT.timeStart) AS SchdDate, PT.totalqty as totalqty, ');
  SQL.Add('PT.quantity as quantity, Pt.ManufactureUOMQty as ManufactureUOMQty, ');
  SQL.Add('PT.FromStockUOMQty as FromStockUOMQty, ');
  SQL.Add('PT.OnOrderUOMQty as OnOrderUOMQty, ');
  SQL.Add('CONVERT((DATE_ADD(PCT.TimeStart, INTERVAL PCT.Duration Second)), DATETIME) AS TimeEnd, ');
  SQL.Add('CONVERT(FormatSecondsTotime(PCT.Duration ), char(255)) AS Duration');
  SQL.Add('FROM tblprocesstime PCT');
  SQL.Add('INNER JOIN tblprocesspart PP ON PCT.ProcessPartId = PP.ID');
  SQL.Add('INNER JOIN tblprocTree PT ON PT.ProctreeId = PP.ProcTreeId');
  SQL.Add('INNER JOIN tblsalesLines SL on PT.masterId = SL.saleLineId');
  SQL.Add('INNER JOIN tblsales S on S.saleId = SL.saleID');
  SQL.Add('INNER JOIN tblprocresourcedetails PRD on PRD.ID = PCT.ResourcedetailsID');
  SQL.Add('INNER JOIN tblprocresource PR on PRD.ProcResourceId = PR.ProcResourceId');
  SQL.Add('INNER JOIN tblemployees E on E.EmployeeID = PCT.EmployeeId');
  SQL.Add('WHERE (PCT.TimeStart BETWEEN ' + QuotedStr(SDateFrom) + ' AND ' + QuotedStr(SDateTo) + ') ');
  SQL.Add('OR (PCT.TimeEnd BETWEEN ' + QuotedStr(SDateFrom) + ' AND ' + QuotedStr(SDateTo) + ') ');
  SQL.Add('Or (PCT.TimeStart <= ' + QuotedStr(SDateFrom) + ' AND PCT.TimeEnd >= ' + QuotedStr(SDateTo) + ' )');

  if Search <> '' then SQL.Add(' AND ' + Search);

  if OrderBy <> '' then SQL.Add('ORDER BY ' + OrderBy)
  else SQL.Add('ORDER BY EmployeeName, SchdDate, SaleId, SaleLineId, Sequencedown, PP.ProcessStepSeq;');

  LogText(SQL.Text);

end;

initialization
  RegisterClass(TWorkOrderList);

end.
