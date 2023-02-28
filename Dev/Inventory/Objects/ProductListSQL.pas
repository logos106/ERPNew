unit ProductListSQL;

interface

uses
  classes, ReportBaseObj;

Type
  TProductList = class(TReportWithDateRangeBase)
  Private

  Protected

  Public
    constructor Create; Override;

    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  Published

  end;

implementation

uses sysutils, ProductQtyLib, StringUtils;


constructor TProductList.Create;
begin
   inherited;
   DateFrom := MinDateTime;
   DateTo := MaxDateTime;
end;


function TProductList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
  function ReplaceAlias(AClause: string): string;
  var
    STemp: string;
  begin
    STemp := AClause;
    STemp := ReplaceStr(STemp, 'true', '"T"');
    STemp := ReplaceStr(STemp, 'false', '"F"');
    Result := STemp;
  end;
begin
  SQL.Clear;
  result := inherited;

  SQL.Add('SELECT P.*, IFNULL(Q.AvailableQty, 0) AS AvailableQty, IFNULL(Q.AllocatedBOQty, 0) AS AllocatedBOQty, IFNULL(Q.SOQty, 0) AS SOQty, IFNULL(Q.SOBOQty, 0) AS SOBOQty, IFNULL(Q.InstockQty, 0) AS InstockQty, IFNULL(Q.POBOQty, 0) AS POBOQty');
  SQL.Add('FROM tblproductclasses C LEFT JOIN tblparts P ON C.ProductID=P.PARTSID');
  SQL.Add('LEFT JOIN');
  SQL.Add('(SELECT DISTINCT PQA.ProductID, PQA.DepartmentID,');
  SQL.Add('SUM(IF(PQA.Active="F", 0, IF(PQA.alloctype="IN" AND PQA.ISBo="F", IFNULL(PQA.QTY, 0), IF(PQA.alloctype="OUT" AND (PQA.TransType<>"TSalesOrderLine" OR PQA.ISBO="F"), 0-IFNULL(PQA.QTY, 0), 0)))) AS AvailableQty,');
  SQL.Add('SUM(IF(PQA.Active="F", 0, IF(PQA.TransType="TInvoiceLine" AND PQA.IsBO ="T", 0, IFNULL(PQA.Qty, 0)))) AS AllocatedBOQty,');
  SQL.Add('SUM(IF(PQA.Active="F", 0, IF(PQA.TransType="TSalesOrderLine" AND PQA.IsBO ="F", IFNULL(PQA.QTY, 0), 0))) AS SOQty,');
  SQL.Add('SUM(IF(PQA.Active="F", 0, IF(PQA.TransType="TSalesOrderLine" AND PQA.IsBO ="T", 0, IFNULL(PQA.Qty, 0)))) AS SOBOQty,');
  SQL.Add('SUM(IF(PQA.TransType="TSalesOrderLine" OR PQA.IsBO ="T",0,if(PQA.alloctype="IN", IFNULL(PQA.QTY,0), 0-ifnull(PQA.QTY, 0)))) AS InstockQty,');
  SQL.Add('SUM(IF(PQA.Active="F", 0, IF(PQA.TransType="TPurchaseOrderLine" AND PQA.IsBO ="T", 0, IFNULL(PQA.Qty, 0)))) AS POBOQty');
  SQL.Add('FROM tblPQA AS PQA');
  SQL.Add('WHERE PQA.TransDate BETWEEN ' + DateFromSQL + ' AND ' + DateToSQL);
  SQL.Add('GROUP BY PQA.ProductID, PQA.DepartmentID) Q');
  SQL.Add('ON C.ProductID = Q.ProductID AND C.ClassID=Q.DepartmentID');

  if not (Search = '') then
    SQL.Add('AND P.' + ReplaceAlias(Search));

  if not (OrderBy = '') then
    SQL.Add('ORDER BY P.' + OrderBy);

end;

initialization

   RegisterClass(TProductList);

end.
