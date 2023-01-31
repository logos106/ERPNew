unit SerialNumberSalesSQL;

interface

uses
  classes, ReportBaseObj, Types, UserLockObj, UserLockBaseObj;

type

  TSerialNumberSalesReport = class(TReportBase)
  private
    fDateTo: TDateTime;
    fDateFrom: TDateTime;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  published
    property DateFrom: TDateTime read fDateFrom write fDateFrom;
    property DateTo: TDateTime read fDateTo write fDateTo;
  end;

implementation

uses
  ProductQtyLib, SysUtils;

{ TSerialNumberSalesReport }

constructor TSerialNumberSalesReport.Create;
begin
  inherited;
  fDateFrom := 0;
  fDateTo := MaxDateTime;
end;

destructor TSerialNumberSalesReport.Destroy;
begin

  inherited;
end;

function TSerialNumberSalesReport.PopulateReportSQL(SQL: TStrings;
  var msg: string): boolean;
begin
  result := true;
  msg := '';

  SQL.Clear;
  SQL.add('select');
  SQL.add('S.SaleID,');
  SQL.add('if(S.IsInvoice = "T","Invoice",If(S.IsSalesOrder, "Sales Order", "Other")) AS SaleType,');
  SQL.add('S.CustomerName,');
  SQL.add('S.ClientPrintName AS CustomerPrintName,');
  SQL.add('S.SaleDate,');
  SQL.add('S.ShipDate,');
  SQL.add('S.ShipTo,');
  SQL.add('S.Class AS Department,');
  SQL.add('S.InvoiceDocNumber AS DocNumber,');
  SQL.add('S.PONumber,');
  SQL.add('S.EmployeeName,');
  SQL.add('S.OriginalNo,');
  SQL.add('SL.ProductID,');
  SQL.add('SL.ProductName,');
  SQL.add('SL.ProductPrintName,');
  SQL.add('SL.Product_Description as ProductDescription,');
  SQL.add('SL.UnitOfMeasureSaleLines AS UOM,');
  SQL.add('SL.SalesLinesCustField1,');
  SQL.add('SL.SalesLinesCustField2,');
  SQL.add('SL.SalesLinesCustField3,');
  SQL.add('SL.SalesLinesCustField4,');
  SQL.add('SL.SalesLinesCustField5,');
  SQL.add('SL.SalesLinesCustField6,');
  SQL.add('SL.SalesLinesCustField7,');
  SQL.add('SL.SalesLinesCustField8,');
  SQL.add('SL.SalesLinesCustField9,');
  SQL.add('SL.SalesLinesCustField10,');
  SQL.add(ProductQtyLib.Firstcolumn + '     as ProductColumn1,');
  SQL.add(ProductQtyLib.Secondcolumn + '    as ProductColumn2,');
  SQL.add(ProductQtyLib.Thirdcolumn + '     as ProductColumn3,');
  SQL.add('if(not PQASN.PQADetailID IS NULL, 1, SL.UnitOfMeasureQtySold) AS QtySold,');
  SQL.add('if(not PQASN.PQADetailID IS NULL, PQASN.UOMQty, SL.UnitOfMeasureShipped) AS QtyShipped,');
  SQL.add('PQASN.Value AS SerialNumber');
  SQL.add('FROM');
  SQL.add(ProductQtyLib.SalesAllocationTables);
  SQL.add('WHERE S.IsInvoice = "T" OR S.IsSalesOrder = "T"');
  if (DateFrom > 0) or (DateTo < MaxDateTime) then
    SQL.Add('and S.SaleDate Between ' + QuotedStr(FormatDateTime('yyyy-mm-dd',DateFrom)) + ' and '  + QuotedStr(FormatDateTime('yyyy-mm-dd',DateTo)));
  SQL.add('GROUP BY S.SaleID, SL.SaleLineID, PQASN.PQADetailID;');

end;

initialization
  RegisterClass(TSerialNumberSalesReport);

end.
