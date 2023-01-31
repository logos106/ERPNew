unit SupplierProductSQL;

interface

uses
  classes, ReportBaseObj;

Type
  TSupplierProduct = class(TReportWithDateRangeBase)
  Private

  Protected

  Public
    constructor Create; Override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;

  Published

  end;

implementation

uses sysutils, ProductQtyLib, StringUtils;


constructor TSupplierProduct.Create;
begin
   inherited;
   DateFrom := MinDateTime;
   DateTo := MaxDateTime;
end;


function TSupplierProduct.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
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
  Result := inherited;

  SQL.Add('SELECT tblpurchaseorders.OrderDate AS "Order Date",');
  SQL.Add(' IF(tblpurchaseorders.IsBill="T", "Bill", IF(tblpurchaseorders.IsPO="T", "Purchase Order", IF(tblpurchaseorders.IsCredit="T", "Credit", "Return Authority"))) AS "Transaction Type",');
  SQL.Add(' tblpurchaseorders.SupplierName AS "Supplier Name" ,');
  SQL.Add(' tblpurchaseorders.GlobalRef AS "Global #" ,');
  SQL.Add(' tblpurchaseorders.OriginalNo AS "Original #",');
  SQL.Add(' tblpurchaseorders.PurchaseOrderNumber AS "Purchase Order Number" ,');
  SQL.Add(' tblpurchaseorders.InvoiceNumber AS "Invoice Number",');
  SQL.Add(' IF(tblpurchaseorders.IsCredit="T", -tblpurchaseorders.TotalAmount, tblpurchaseorders.TotalAmount) AS "Total Amount (Ex)",');
  SQL.Add(' IF(tblpurchaseorders.IsCredit="T", -(tblpurchaseorders.TotalAmountInc-tblpurchaseorders.TotalAmount), (tblpurchaseorders.TotalAmountInc-tblpurchaseorders.TotalAmount)) AS "Total Tax",');
  SQL.Add(' IF(tblpurchaseorders.IsCredit="T", -tblpurchaseorders.TotalAmountInc, tblpurchaseorders.TotalAmountInc) AS "Total Amount (Inc)" ,');
  SQL.Add(' tblpurchaselines.Qtysold AS Ordered,');
  SQL.Add(' tblpurchaselines.ETADate AS ETADate,');
  SQL.Add(' CONCAT(tblEmployees.FirstName, " ", tblEmployees.LastName) AS "Employee Name",');
  SQL.Add(' tblpurchaseorders.Comments AS "Comments",');
  SQL.Add(' tblpurchaseorders.SalesComments AS "Sales Comments",');
  SQL.Add(' tblpurchaselines.Class AS "Class Name",');
  SQL.Add(' tblpurchaselines.AccountName AS "AccountName",');
  SQL.Add(' TypeDesc AS "Product Type",');
  SQL.Add(' LEFT(IF(InStr(tblparts.PRODUCTGROUP, "^") - 1 > 0, LEFT(tblparts.PRODUCTGROUP, InStr(tblparts.PRODUCTGROUP, "^") - 1), tblparts.PRODUCTGROUP), 255) AS Department,');
  SQL.Add(' LEFT(MID(tblparts.PRODUCTGROUP, InStr(tblparts.PRODUCTGROUP,"^") + 1, IF(LOCATE("^", tblparts.PRODUCTGROUP, InStr(tblparts.PRODUCTGROUP, "^") + 1) - InStr(tblparts.PRODUCTGROUP, "^") > 0,');
  SQL.Add('  LOCATE("^",tblparts.PRODUCTGROUP,InStr(tblparts.PRODUCTGROUP,"^")+1)-1 - InStr(tblparts.PRODUCTGROUP,"^"), IF(InStr(tblparts.PRODUCTGROUP,"^") <> 0, LENGTH(tblparts.PRODUCTGROUP) - InStr(tblparts.PRODUCTGROUP, "^"), 0))), 255) AS Type,');
  SQL.Add(' LEFT(IF((LOCATE("^", tblparts.PRODUCTGROUP, InStr(tblparts.PRODUCTGROUP, "^") + 1)) > 0, MID(tblparts.PRODUCTGROUP,LOCATE("^", tblparts.PRODUCTGROUP, InStr(tblparts.PRODUCTGROUP, "^") + 1) + 1, CHAR_LENGTH(tblparts.PRODUCTGROUP) - ');
  SQL.Add('  LOCATE("^",tblparts.PRODUCTGROUP, InStr(tblparts.PRODUCTGROUP, "^") + 1)), Null),155) AS Manufacturer,');
  SQL.Add(' tblpurchaselines.ProductName AS "Product Name",');
  SQL.Add(' tblpurchaselines.Product_Description AS "Product Description" ,');
  SQL.Add(' IF(tblpurchaseorders.IsCredit="T", -tblpurchaselines.LineCost, tblpurchaselines.LineCost) AS "Line Cost (Ex)",');
  SQL.Add(' IF(tblpurchaseorders.IsCredit="T", -tblpurchaselines.LineCostInc, tblpurchaselines.LineCostInc) AS "Line Cost (Inc)",');
  SQL.Add(' IF(tblpurchaseorders.IsCredit="T", -tblpurchaselines.TotalLineAmount, tblpurchaselines.TotalLineAmount) AS "Line Cost Total(Ex)",');
  SQL.Add(' IF(tblpurchaseorders.IsCredit="T", -tblpurchaselines.TotalLineAmountInc, tblpurchaselines.TotalLineAmountInc) AS "Line Cost Total(Inc)",');
  SQL.Add(' IF(tblpurchaseorders.IsCredit="T", -tblpurchaselines.LineTax, tblpurchaselines.LineTax) AS "Line Tax",');
  SQL.Add(' IF(tblpurchaseorders.IsCredit="T", -(tblpurchaselines.LineCostInc * tblpurchaselines.Backorder),(tblpurchaselines.LineCostInc * tblpurchaselines.Backorder)) AS `BO Line Cost Total(Inc)`,');
  SQL.Add(' IF(tblpurchaseorders.IsCredit="T", -(tblpurchaselines.LineCost * tblpurchaselines.Backorder),(tblpurchaselines.LineCost * tblpurchaselines.Backorder)) AS `BO Line Cost Total(Ex)`,');
  SQL.Add(' tblpurchaselines.LineTaxCode AS "Tax Code",');
  SQL.Add(' tblpurchaselines.Shipped AS Shipped,');
  SQL.Add(' tblpurchaselines.BackOrder AS BackOrder,');
  SQL.Add(' tblpurchaselines.ProductID AS ProductID,');
  SQL.Add(' tblpurchaseorders.Deleted AS Deleted,');
  SQL.Add(' tblEmployees.EmployeeID AS EmployeeID,');
  SQL.Add(' tblClients.ClientID AS ClientID,');
  SQL.Add(' tblpurchaseorders.PurchaseOrderID AS PurchaseOrderID,');
  SQL.Add(' tblpurchaselines.Attrib1Purchase AS Attrib1Purchase,');
  SQL.Add(' tblpurchaselines.Attrib2Purchase AS Attrib2Purchase,');
  SQL.Add(' tblpurchaselines.Attrib1PurchaseRate AS Attrib1PurchaseRate,');
  SQL.Add(' tblpurchaselines.ReceivedDate AS ReceivedDate,');
  SQL.Add(' tblpurchaselines.DocketNumber AS DocketNumber,');
  SQL.Add(' tblParts.Barcode AS Barcode,');
  SQL.Add(' tblchartofaccounts.AccountNumber AS AccountNumber ,');
  SQL.Add(' COGS.AccountNumber AS COGSAccountNumber,');
  SQL.Add(' Asset.AccountNumber AS AssetAccountNumber,');
  SQL.Add(' Income.AccountNumber AS IncomeAccountNumber,');
  SQL.Add(' COGS.AccountName AS COGSAccountName,');
  SQL.Add(' Asset.AccountName AS AssetAccountName,');
  SQL.Add(' Income.AccountName AS IncomeAccountName');
  SQL.Add('FROM tblpurchaseorders');
  SQL.Add(' INNER JOIN tblpurchaselines ON tblpurchaselines.PurchaseOrderID = tblpurchaseorders.PurchaseOrderID');
  SQL.Add(' LEFT JOIN tblparts ON tblparts.PARTSID = tblpurchaselines.ProductID');
  SQL.Add(' LEFT JOIN tblparttypes ON tblparts.PARTTYPE = tblparttypes.TypeCode');
  SQL.Add(' LEFT JOIN tblchartofaccounts ON tblchartofaccounts.AccountName = tblpurchaselines.AccountName');
  SQL.Add(' LEFT JOIN tblchartofaccounts COGS on COGS.AccountID = tblpurchaselines.COGSACCNTID');
  SQL.Add(' LEFT JOIN tblchartofaccounts Asset on Asset.AccountID = tblpurchaselines.ASSETACCNTID');
  SQL.Add(' LEFT JOIN tblchartofaccounts Income on Income.AccountID = tblpurchaselines.INCOMEACCNTID');
  SQL.Add(' LEFT JOIN tblClients  ON  tblpurchaseorders.SupplierName = tblClients.Company');
  SQL.Add(' LEFT JOIN tblEmployees ON  tblpurchaseorders.EmployeeID = tblEmployees.employeeId #(tblpurchaseorders.EmployeeName = Concat(tblEmployees.FirstName," ", tblEmployees.LastName))');
  SQL.Add('WHERE (IsBill = "T" OR IsPO = "T" OR IsRA = "T" OR IsCredit = "T")  AND');
  SQL.Add(' (tblpurchaselines.ProductName > '' OR tblpurchaselines.AccountName > '') AND OrderDate BETWEEN ' + QuotedStr(FormatDateTime('yyyy-mm-dd', DateFrom)) + ' AND ' + QuotedStr(FormatDateTime('yyyy-mm-dd', DateTo)));
  SQL.Add(' AND tblpurchaseorders.Deleted <> "T"');

  if not (Search = '') then
    SQL.Add(' AND ' + Search);

  if not (OrderBy = '') then
    SQL.Add(' ORDER BY ' + OrderBy)
  else
    SQL.Add(' ORDER BY tblpurchaseorders.OrderDate DESC');

end;

initialization

   RegisterClass(TSupplierProduct);

end.
