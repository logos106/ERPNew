unit JobSalesSummarySQL;

interface

uses
  classes, ReportBaseObj;

Type
  TJobSalesSummary = class(TReportWithDateRangeBase)
  Private
    fClientID: Integer;

  Protected

  Public
    constructor Create; Override;

    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;

  Published
    property ClientID: Integer  read fClientID write fClientID;
  end;

implementation

uses sysutils, ProductQtyLib, StringUtils;


constructor TJobSalesSummary.Create;
begin
   inherited;
   DateFrom := MinDateTime;
   DateTo := MaxDateTime;
end;


function TJobSalesSummary.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
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

  SQL.Add('SELECT');
  SQL.Add(' 0 AS DetailType,');
  SQL.Add(' tblclients.ParentClientID AS ParentClientID,');
  SQL.Add(' pc.Company as Customer,');
  SQL.Add(' 0 AS ClientID,');
  SQL.Add(' NULL AS JobCustomer,');
  SQL.Add(' NULL AS CustomerJobNumber,');
  SQL.Add(' NULL AS JobName,');
  SQL.Add(' NULL AS ProductName,');
  SQL.Add(' NULL AS QtyShipped,');
  SQL.Add(' SUM(tblsaleslines.Discounts) AS TotalDiscount,');
  SQL.Add(' SUM(tblsaleslines.TotalLineAmount) AS TotalAmountEx,');
  SQL.Add(' SUM(tblsaleslines.TotalLineAmountInc) AS TotalAmountInc,');
  SQL.Add(' SUM(tblsaleslines.LineTax) AS TotalTax');
  SQL.Add('FROM tblsales');
  SQL.Add('INNER JOIN tblclients ON tblclients.ClientID = tblsales.ClientID');
  SQL.Add('INNER JOIN tblsaleslines ON tblsaleslines.SaleID = tblsales.SaleID');
  SQL.Add('LEFT JOIN tblclients pc ON pc.clientid = tblclients.ParentClientID');
  SQL.Add('WHERE ((pc.ClientID = ' + IntToStr(ClientId) + ') OR (' + IntToStr(ClientId) + ' = 0))');
  SQL.Add(' AND (tblsales.SaleDateTime BETWEEN ' + QuotedStr(FormatDateTime('yyyy-mm-dd', DateFrom)) + ' AND ' + QuotedStr(FormatDateTime('yyyy-mm-dd', DateTo))  + ')');
//  if not (Search = '') then
//    SQL.Add('AND ' + ReplaceAlias(Search));
  SQL.Add('GROUP BY pc.ClientID');

  SQL.Add('UNION ALL');

  SQL.Add('SELECT');
  SQL.Add(' 1 AS DetailType,');
  SQL.Add(' tblclients.ParentClientID AS ParentClientID,');
  SQL.Add(' pc.Company AS Customer,');
  SQL.Add(' tblsales.ClientID AS ClientID,');
  SQL.Add(' tblsales.CustomerName AS JobCustomer,');
  SQL.Add(' tblclients.CustomerJobNumber as CustomerJobNumber,');
  SQL.Add(' tblclients.JobName AS JobName,');
  SQL.Add(' tblsaleslines.ProductName AS ProductName,');
  SQL.Add(' SUM(tblsaleslines.UnitOfMeasureShipped) AS QtyShipped,');
  SQL.Add(' SUM(tblsaleslines.Discounts) AS TotalDiscount,');
  SQL.Add(' SUM(tblsaleslines.TotalLineAmount) AS TotalAmountEx,');
  SQL.Add(' SUM(tblsaleslines.TotalLineAmountInc) AS TotalAmountInc,');
  SQL.Add(' SUM(tblsaleslines.LineTax) AS TotalTax');
  SQL.Add('FROM tblsales');
  SQL.Add('INNER JOIN tblclients ON tblclients.ClientID = tblsales.ClientID');
  SQL.Add('INNER JOIN tblsaleslines ON tblsaleslines.SaleID = tblsales.SaleID');
  SQL.Add('LEFT JOIN tblclients pc ON pc.clientid = tblclients.ParentClientID');
  SQL.Add('WHERE ((pc.ClientID = ' + IntToStr(ClientId) + ') OR (' + IntToStr(ClientId) + ' = 0))');
//  if not (Search = '') then
//    SQL.Add('AND ' + ReplaceAlias(Search));
  SQL.Add(' AND (tblsales.SaleDateTime BETWEEN ' + QuotedStr(FormatDateTime('yyyy-mm-dd', DateFrom)) + ' AND ' + QuotedStr(FormatDateTime('yyyy-mm-dd', DateTo))  + ')');
  SQL.Add('GROUP BY pc.ClientID, tblsaleslines.ProductID');

  if not (OrderBy = '') then
    SQL.Add('ORDER BY ' + OrderBy)
  else
    SQL.Add('ORDER BY Customer, DetailType');

end;

initialization

   RegisterClass(TJobSalesSummary);

end.
