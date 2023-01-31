unit ReportSQLProductNegativeStock;

interface

uses
  ReportSQLBase, Classes;

type

  TReportSQLProductNegativeStock = Class(TReportSQLBase)
  private
  protected
    function GetTemplateSQL: String; override;
    function GetReportTypeID: integer; override;
  public
    constructor Create(Aowner: TComponent); override;
    destructor Destroy; override;
    class function ReportSQL: string;
  end;


implementation

uses
  PQALib, MySQLConst, SysUtils, BusObjectListObj, ProductQtyLib;

{ TReportSQLProductNegativeStock }

constructor TReportSQLProductNegativeStock.Create(Aowner: TComponent);
begin
  inherited;
  UsingReportTables := False;
  ReportonForeignCurrency := False;
  BaseTemptableName := '';
  TempTableName := '';
  ReportClassName := 'TProductNegativeStockGUI';
  ReportSQLSupplied := true;
end;

destructor TReportSQLProductNegativeStock.Destroy;
begin

  inherited;
end;

function TReportSQLProductNegativeStock.GetReportTypeID: integer;
begin
  result := 170;
end;

function TReportSQLProductNegativeStock.GetTemplateSQL: String;
begin
  result := ReportSQL + #13#10 +
    'where PQA.TransDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat,Dateto)) + #13#10 +
    'group by p.partsID' + #13#10 +
    'having AvailableQty < 0' + #13#10 +
    'Order by PartName';
end;

class function TReportSQLProductNegativeStock.ReportSQL: string;
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    sl.Add('Select');
    sl.Add('p.Partname as PartName,');
    sl.Add('p.ProductPrintName as PrintName,');
    sl.Add('p.PartType as PartType,');
    sl.Add(SQL4QtyField(tOnBuild) +' as OnBuildQty,');
    sl.Add(SQL4QtyField(tBuilding) +' as BuildingQty,');
    sl.Add(SQL4QtyField(tBuilt) +' as BuiltQty,');
    sl.Add(SQL4QtyField(tSubBuilt) +' as SubBuiltQty,');
    sl.Add(SQL4QtyField(tUSedForBuild) +' as USedForBuildQty,');
    sl.Add(SQL4QtyField(tInStock) +' as InStockQty,');
    sl.Add(SQL4QtyField(tInStocknOnOrder) +' as InStocknOnOrderQty,');
    sl.Add(SQL4QtyField(tActStockwithMan) +' as ActStockwithManQty,');
    sl.Add(SQL4QtyField(tActStock) +' as ActStockQty,');
    sl.Add(SQL4QtyField(tStockQty) +' as StockQtyQty,');
    sl.Add(SQL4QtyField(tAvailable) +' as AvailableQty,');
    sl.Add(SQL4QtyField(tAvailablenOnOrder) +' as AvailablenOnOrderQty,');
    sl.Add(SQL4QtyField(tSO) +' as SOQty,');
    sl.Add(SQL4QtyField(tInvBO) +' as InvBOQty,');
    sl.Add(SQL4QtyField(tTotSales) +' as TotSalesQty,');
    sl.Add(SQL4QtyField(tPOBO) +' as POBOQty,');
    sl.Add(SQL4QtyField(tSOBO) +' as SOBOQty,');
    sl.Add(SQL4QtyField(tTransQty) +' as TransQtyQty,');
    sl.Add(SQL4QtyField(tInStockMovement) +' as InStockMovementQty,');
    sl.Add(SQL4QtyField(tOUTs) +' as OUTsQty,');
    sl.Add(SQL4QtyField(tINs) +' as INsQty,');
    sl.Add(SQL4QtyField(tOnTransitOut,'','Qty') +' as OnTransitQty,');
    sl.Add(SQL4QtyField(tPOBO) +' as OnOrderQty,');
    sl.Add('P.PREFEREDSUPP  as "PreferredSupplier", ');
    sl.Add('P.PURCHASEDESC  as "PurchaseDescription", ');
    sl.Add('P.INCOMEACCNT  as "IncomeAccount", ');
    sl.Add('P.ASSETACCNT  as "AssetAccount", ');
    sl.Add('P.COGSACCNT  as "CostofGoodsSoldAccount", ');
    sl.Add('P.BARCODE  as "Barcode", ');
    sl.Add('P.PRODUCTCODE  as "ProductCode", ');
    sl.Add(Firstcolumn + '  as FirstColumn, ');
    sl.Add(Secondcolumn+ '  as SecondColumn, ');
    sl.Add(Thirdcolumn + '  as ThirdColumn, ');
    sl.Add('P.PARTSDESCRIPTION as SalesDescription,');
    sl.Add('P.WHOLESALEPRICE  as "WholesalePrice", ');

    sl.Add('P.SellQTY1  as "SellQtyA", ');
    sl.Add('P.SellQTY2  as "SellQtyB", ');
    sl.Add('P.SellQTY3  as "SellQtyC", ');

    sl.Add('P.PRICE1  as "PriceExA", ');
    sl.Add('P.PRICE2  as "PriceExB", ');
    sl.Add('P.PRICE3  as "PriceExC", ');

    sl.Add('P.PRICEINC1  as "PriceIncA", ');
    sl.Add('P.PRICEINC2  as "PriceIncB", ');
    sl.Add('P.PRICEINC3  as "PriceIncC", ');

    sl.Add('P.BuyQTY1  as "BuyQtyA", ');
    sl.Add('P.BuyQTY2  as "BuyQtyB", ');
    sl.Add('P.BuyQTY3  as "BuyQtyC", ');

    sl.Add('P.COST1  as "CostExA", ');
    sl.Add('P.COST2  as "CostExB", ');
    sl.Add('P.COST3  as "CostExC", ');

    sl.Add('P.COSTINC1  as "CostIncA", ');
    sl.Add('P.COSTINC2  as "CostIncB", ');
    sl.Add('P.COSTINC3  as "CostIncC", ');

    SL.Add('P.SupplierProductCode  as SupplierProductCode, ');
    sl.Add('P.TAXCODE  as "Taxcode", ');
    sl.Add('P.PURCHTAXCODE  as "PurchaseTaxcode", ');
    sl.Add('P.DateCreated  as DateCreated, ');
    sl.Add('P.DateUpdated  as DateUpdated, ');
    sl.Add('P.Area  as Area, ');
    sl.Add('P.Discontinued  as Discontinued, ');
    sl.Add('P.OnSpecial  as OnSpecial ');
    sl.Add('from tblparts  p inner join tblpqa pqa on pqa.ProductID = p.partsid');
    result := sl.Text;
  finally
    sl.Free;
  end;
end;

initialization
  BusObjectListObj.TScheduledReportObjInfoList.Inst.Add('Product Negative Stock','TReportSQLProductNegativeStock','TProductNegativeStockGUI');
  Classes.RegisterClass(TReportSQLProductNegativeStock);

end.
