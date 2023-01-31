unit PartClassSQL;

interface

uses
  ReportBaseObj,classes;

Type
  TPartClass = Class(TReportBase)
  Private
  Protected
  Public
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  End;

implementation

uses CommonLib;

{ TPartClass }

function TPartClass.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
begin
  result := inherited;
  SQL.Clear;

  SQL.Add('SELECT');
  SQL.Add('PC.GlobalRef           AS GlobalRef,');
  SQL.Add('PC.ID                  AS ID,');
  SQL.Add('PC.ProductID           AS ProductID,');
  SQL.Add('PC.ProductName         AS ProductName,');
  SQL.Add('PC.ProductGroup        AS ProductGroup,');
  SQL.Add('PC.ClassID             AS ClassID,');
  SQL.Add('PC.ClassName           AS ClassName,');
  SQL.Add('PC.ReOrderPoint        AS ReOrderPoint,');
  SQL.Add('PC.PreferredLevel      AS PreferredLevel,');
  SQL.Add('PC.ReOrderAmount       AS ReOrderAmount,');
  SQL.Add('PC.LastAdj             AS LastAdj,');
  SQL.Add('PC.LastAdjAccount      AS LastAdjAccount,');
  SQL.Add('PC.ClassPriceVariance  AS ClassPriceVariance,');
  SQL.Add('PC.VariantPrice        AS VariantPrice,');
  SQL.Add('PC.NextStocktakeDate   AS NextStocktakeDate,');
  SQL.Add('PC.Active              AS Active,');
  SQL.Add('PB.binlocation         AS Defaultbinlocation,');
  SQL.Add('PB.binnumber           AS defaultbinnumber,');
  SQL.Add('P.Description          AS SalesDescription,');
  SQL.Add('P.COST1                AS COST1,');
  SQL.Add('P.COSTINC1             AS COSTINC1,');
  SQL.Add('P.BuyQTY1              AS BuyQTY1,');
  SQL.Add('P.COST2                AS COST2 ,');
  SQL.Add('P.COSTINC2             AS COSTINC2 ,');
  SQL.Add('P.BuyQTY2              AS BuyQTY2 ,');
  SQL.Add('P.COST3                AS COST3 ,');
  SQL.Add('P.COSTINC3             AS COSTINC3 ,');
  SQL.Add('P.BuyQTY3              AS BuyQTY3 ,');
  SQL.Add('P.Price1               AS Price1 ,');
  SQL.Add('P.PriceINC1            AS PriceINC1 ,');
  SQL.Add('P.SellQTY1             AS SellQTY1 ,');
  SQL.Add('P.Price2               AS Price2,');
  SQL.Add('P.PriceINC2            AS PriceINC2 ,');
  SQL.Add('P.SellQTY2             AS SellQTY2 ,');
  SQL.Add('P.Price3               AS Price3 ,');
  SQL.Add('P.PriceINC3            AS PriceINC3 ,');
  SQL.Add('P.SellQTY3             AS SellQTY3 ,');
  SQL.Add('P.BARCODE              AS Primarybarcode,');
  SQL.Add('P.active               AS ProductActive,');
  SQL.Add('PC.active              AS ProductClassActive,');
  SQL.Add('if(P.msTimeStamp > PC.MsTimeStamp , P.MsTimeStamp , PC.MsTimeStamp) AS MsTimeStamp,');
  SQL.Add('if(P.msTimeStamp > PC.MsTimeStamp AND trim(P.msUpdateSiteCode)<> "", P.MsUpdateSiteCode , PC.MsUpdateSiteCode) AS MsUpdateSiteCode');
  SQL.Add('FROM tblparts P');
  SQL.Add('INNER JOIN tblProductclasses PC ON P.PARTSID = PC.productId');
  SQL.Add('Left join tblProductBin PB on PB.binId= PC.defaultBinId');
  SQL.Add('Order by ProductName , ClassName')

end;
initialization
  RegisterClass(TPartClass);

end.
