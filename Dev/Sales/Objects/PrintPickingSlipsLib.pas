unit PrintPickingSlipsLib;

interface

uses
  JsonObject, SysUtils, Classes;

  function SQL4PickingSlipReport(reportName: String; var Json: TJsonObject;
    const TransIDs: String = ''; TRansType: String = ''; const fsBinfilter: String = '';
    DetailSQL: String = ''): String;

implementation

uses
  ProductQtyLib, tcConst, AppEnvironment, TemplateReportsLib, CommonLib,
  ERPDbComponents, CommonDbLib, tcDataUtils;

function PickingslipreporttoOrder(reportName: String): Integer;
begin
  if (SysUtils.SameText(reportName, 'Picking Slip List(Product)')) or
    (SysUtils.SameText(reportName, 'Pick Slip(Product)')) then
    result := 0
  else if (SameText(copy(reportName, 1, Length('Picking Slip List(Bin)')), 'Picking Slip List(Bin)')
    ) or (SameText(copy(reportName, 1, Length('Pick slip(Bin)')), 'Pick slip(Bin)')) then
    result := 1
  else if (SysUtils.SameText(reportName, 'Picking Slip List(Col1)')) or
    (SysUtils.SameText(reportName, 'Pick Slip(Col1)')) then
    result := 2
  else if (SysUtils.SameText(reportName, 'Picking Slip List(col2)')) or
    (SysUtils.SameText(reportName, 'Pick Slip(Col2)')) then
    result := 3
  else if (SysUtils.SameText(reportName, 'Picking Slip List(Col3)')) or
    (SysUtils.SameText(reportName, 'Pick Slip(Col3)')) then
    result := 4
  else if (SysUtils.SameText(reportName, 'Picking Slip List')) or
    (SysUtils.SameText(reportName, 'Picking Slip')) then
    result := 5
  else
    result := 5;
end;

function SQL4PickingSlipReport(reportName: String; var Json: TJsonObject;
  const TransIDs: String = ''; TransType: String = ''; const fsBinfilter: String = '';
  DetailSQL: String = ''): String;
var
  sSQL: String;
  PqaString: STring;
  PickingSlipOrder: Integer;

  function PickingSlipreportJson: TJsonObject;
  begin
    result := JO;
    result.O['1'].S['Master'] := 'Detail';
    result.O['1'].S['Detail'] := 'RawMaterials';
    result.O['1'].S['masterfields'] := 'saleLineId';
    result.O['1'].S['detailfields'] := 'PT.MasterID';
  end;

begin
  PickingSlipOrder := PickingslipreporttoOrder(reportName);

  PqaString :=
    'and ((P.multiplebins = "F" and P.Batch="F" and P.SNTracking = "F") OR (PQA.PQAID in (Select PQAID from tblPQADetails)))';

  if TRansType = '' then
    TransType := SalesTransTypes
  else if TRansType <> SalesTransTypes then
    TransType := QuotedStr(TransType);
  { inventory items }
  sSQL := '{Detail}SELECT  ' + 'SL.Product_Description as PARTSDESCRIPTION,' +
    'concat_ws("-",SL.Productname,SL.SalesLinesCustField1) as ProductnamenCustFld1 ,' +
    'concat_ws("-",SL.ProductPrintName,SL.SalesLinesCustField1) as ProductprintnamenCustFld1,' +
    'SL.Product_Description_Memo as PARTSDESCRIPTION_Memo,' + 'SL.RequiresAssembly,' +
    'SL.Attrib1Sale,' + 'SL.Attrib2Sale,' + 'SL.MemoLine ,' + 'PBin.Binlocation, ' +
    'concat(SL.SaleID, "-" , SL.SaleLineID , "-" ,  PQABatch.Value) as SaleProductBatchBarcode, ' +
    'PQABatch.CustFLD6 as GrossWeight,'+
    'PQABatch.CustFLD7 as NetWeight,'+
    'PBin.binnumber,' + 'PQABatch.Value as batchno, ' + SplitField('PQABatch', 'Value', 1, '-') +
    ' as BatchGroup,' + SplitField('PQABatch', 'Value', 2, '-') + ' as BatchDetails,' +
    'PQABatch.TruckLoadNo , ' + 'PQABatch.ExpiryDate, ' + 'PQABatch.CUSTFLD1 as BatchCustFld1, ' +
    'Round(sum(if(ifnull(PQASN.PQADEtailID,0)<>0 , PQASN.UOMQty ,if (ifnull(PQABins.PQADEtailID,0)<>0 , PQABins.UOMQty , if(ifnull(PQABatch.UOMQty,0)<>0 , PQABatch.uomQty , PQA.uomQty)))), '
    + inttostr(tcConst.GeneralRoundPlaces) + ') as BinQty,' +
    'Replace(GROUP_CONCAT(PQASN.Value), '','' , '',\n'') as SoldSerials ,' +
  { this is to display the binbach labels in the report only if its a bin bach product }
    'if(P.Batch       ="T","Batch number" ,"") as BatchnumberCaption,' +
    'if(P.Batch       ="T","Expiry Date"  ,"") as ExpiryDateCaption,' +
    'if(P.MultipleBins="T","Bin Location" ,"") as BinLocationCaption,' +
    'if(P.MultipleBins="T","Bin Number"   ,"") as BinnumberCaption,' +
    'if(P.SNtracking  ="T","Serial Number","") as SerialnumberCaption,' +
    'round(if(P.SNtracking  ="T" or P.MultipleBins="T" or P.Batch="T" , "Qty Allocated" , ""), ' +
    inttostr(tcConst.GeneralRoundPlaces) + ')  as QtyAllocated, ' +
    'Round(if(P.SNtracking  ="T" or P.MultipleBins="T" or P.Batch="T" , "Qty Picked" , ""), ' +
    inttostr(tcConst.GeneralRoundPlaces) + ')  as QtyPicked, ' +
    ' CONCAT("S-",S.SaleId) as SaleBarcode, S.*,' +
    'SL.SalesLinesCustField1,SL.SalesLinesCustField2,SL.SalesLinesCustField3,SL.SalesLinesCustField4,SL.SalesLinesCustField5,SL.SalesLinesCustField6,SL.SalesLinesCustField7,SL.SalesLinesCustField8,SL.SalesLinesCustField9,SL.SalesLinesCustField10,'
    + '`SL`.`WarrantyPeriod`,`SL`.`WarrantyEndsOn`, SL.sortID,' +
    'SL.ProductID, SL.ProductName, SL.UnitofMeasureSaleLines, ' +
    ' if (HoldSale = "T", "HOLD", "") AS Hold, ' + CHR(13) + ' P.BARCODE as ProductBarCode,' +
    CHR(13) + ' CONCAT(SL.ProductName,Product_Description) AS GroupLine, ' + CHR(13) +
    ' CL.CUSTFLD1,CL.CUSTFLD2,CL.CUSTFLD3,CL.CUSTFLD4,CL.CUSTFLD5, ' + CHR(13) +
    ' CL.CUSTFLD6,CL.CUSTFLD7,CL.CUSTFLD8,CL.CUSTFLD9, CL.CUSTFLD10, ' + CHR(13) +
    ' CL.CUSTFLD11,CL.CUSTFLD12,CL.CUSTFLD13,CL.CUSTFLD14,CL.CUSTFLD15, ' + CHR(13) +
    ' CL.Phone as CustomerPhone,CL.FaxNumber as CustomerFaxNumber, ' + CHR(13) +
    ' CL.Mobile as CustomerMobile,   ' + CHR(13) + Thirdcolumn + '  as Dept, ' + CHR(13) +
    SecondColumn + ' as type, ' + CHR(13) + Firstcolumn + ' as Manufacture, ';

  // if (PickingSlipOrder = 5) or (PickingSlipOrder = 0) then
  sSQL := sSQL + 'Sl.SaleLineID ,' + 'sum(SL.UnitofMeasureShipped)   as qShipped, ' +
    'sum(SL.UnitofMeasureBackorder) as qBackorder , ' +
    'sum(UnitofMeasureQtySold)      as qOrdered, ' +
    'sum(SL.totalLineAmountInc)     as totalLineAmountInc, ' +
    'sum(SL.LinePriceInc) as LinePriceInc, ' + 'sum(SL.LinePrice) as LinePriceEx, ';

  if PickingSlipOrder = 0 then
    sSQL := sSQL +
      'CONCAT( "Product Details :" , SL.ProductName,Product_Description) AS Groupfield '
  else if PickingSlipOrder = 1 then
    sSQL := sSQL +
      'CONCAT( "Bin Location / Number:" , PBin.BinLocation,"-",PBin.BinNumber) as GroupField'
  else if PickingSlipOrder = 2 then
    sSQL := sSQL + 'CONCAT(' + QuotedStr(AppEnv.DefaultClass.Firstcolumn) + ',' + QuotedStr(': ') +
      ',' + Firstcolumn + ')  as GroupField'
  else if PickingSlipOrder = 3 then
    sSQL := sSQL + 'CONCAT(' + QuotedStr(AppEnv.DefaultClass.SecondColumn) + ',' + QuotedStr(': ') +
      ',' + SecondColumn + ')  as GroupField'
  else if PickingSlipOrder = 4 then
    sSQL := sSQL + 'CONCAT(' + QuotedStr(AppEnv.DefaultClass.Thirdcolumn) + ',' + QuotedStr(': ') +
      ',' + Thirdcolumn + ')  as GroupField'
  else if PickingSlipOrder = 5 then
    sSQL := sSQL + 'Concat(' + QuotedStr('Invoice No: ') + ', S.invoicedocnumber) AS Groupfield ';

  sSQL := sSQL + ',CLT.TypeName,' +
    'DPB.BinLocation as DefaultBinLocation,DPB.BinNumber as DefaultBinNumber ';
  sSQL := sSQL + ',P.CUSTFLD1 AS ProductCustFld1, ' + 'P.CUSTFLD2 AS ProductCustFld2, ' +
    'P.CUSTFLD3 AS ProductCustFld3, ' + 'P.CUSTFLD4 AS ProductCustFld4, ' +
    'P.CUSTFLD5 AS ProductCustFld5, ' + 'P.CUSTFLD6 AS ProductCustFld6, ' +
    'P.CUSTFLD7 AS ProductCustFld7, ' + 'P.CUSTFLD8 AS ProductCustFld8, ' +
    'P.CUSTFLD9 AS ProductCustFld9, ' + 'P.CUSTFLD10 AS ProductCustFld10, ' +
    'P.CUSTFLD11 AS ProductCustFld11, ' + 'P.CUSTFLD12 AS ProductCustFld12, ' +
    'P.CUSTFLD13 AS ProductCustFld13, ' + 'P.CUSTFLD14 AS ProductCustFld14, ' +
    'P.CUSTFLD15 AS ProductCustFld15, ' + 'P.CUSTDATE1 AS ProductCustDate1, ' +
    'P.CUSTDATE2 AS ProductCustDate2, ' + 'P.CUSTDATE3 AS ProductCustDate3 , ' +
    'PP.partPic as PartPicture, ' +
    'UOM.Height 	as Height,  ' +
    'UOM.Width 	as Width,  ' +
    'UOM.Length 	as Length,  ' +
    'UOM.Weight 	as Weight,  ' +
    'UOM.Volume 	as Volume,' +
    'SL.UnitofMeasureShipped * UOM.Height as shippedHeight,  ' +
    'SL.UnitofMeasureShipped * UOM.Width 	as shippedWidth,  ' +
    'SL.UnitofMeasureShipped * UOM.Length as  shippedLength,' +
    'SL.UnitofMeasureShipped * UOM.Weight as  shippedWeight,' +
    'SL.UnitofMeasureShipped * UOM.Volume as  shippedVolume,' +
    'ct.contactemail as ContEmail, ' +
    'ct.contacttitle as ContTitle, ' + 'ct.contactfirstname as ContFirstName, ' +
    'ct.contactsurname as ContSurname,   ' + 'ct.contactaddress as ContAddress, ' +
    'ct.contactaddress2 as ContAddress2, ' + 'ct.contactaddress3 as ContAddress3, ' +
    'ct.contactcity as ContCity, ' + 'ct.contactstate as ContState, ' +
    'ct.contactpcode as ContPostcode, ' + 'ct.contactcountry as ContCountry, ' +
    'ct.contactph as ContPh, ' + 'ct.contactaltph as ContAltPh, ' + 'ct.contactmob as ContMob, ' +
    'ct.contactfax as ContactFax,' + 'CL.Street, ' + 'CL.Street2, ' + 'CL.Street3, ' + 'CL.Suburb, '
    + 'CL.State , ' + 'CL.Postcode, CL.DeliveryNotes, ' +
  (* ' (Select sum(ifnull(SLPW.AttribValue1,0)*ifnull(Packcount,0)) from tblsaleslinepackweightlines SLPW where  SL.saleLineId = SLPW.saleLineId ) as PackFieldValue1 , ' +
    ' (Select sum(ifnull(SLPW.AttribValue2,0)*ifnull(Packcount,0)) from tblsaleslinepackweightlines SLPW where  SL.saleLineId = SLPW.saleLineId ) as PackFieldValue2 , ' +
    ' (Select sum(ifnull(Packcount,0) from tblsaleslinepackweightlines SLPW where  SL.saleLineId = SLPW.saleLineId ) as Packcount , ' + *)
    'SLP.PackFieldValue1  , SLP.PackFieldValue2 , SLP.Packcount , ' +
    '(Select Sum(PP.Balance) TotalBalance ' + ' from tblSalesPrepayments  SP  ' +
    ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef   ' +
    ' Where PP.Deleted = "F" and SP.SalesRef = S.Globalref or SP.SalesRef = S.salesorderglobalref) as Prepayments,   '
    + '(Select Sum(PP.Balance) TotalBalance  ' + ' from tblSalesPrepayments  SP  ' +
    ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef   ' +
    ' Where PP.Deleted = "F" and SP.SalesRef = S.Globalref or SP.SalesRef = S.salesorderglobalref) +S.payment as Totalpayment,  '
    + 'S.totalamountinc - ' + '(Select Sum(PP.Balance) TotalBalance  ' +
    ' from tblSalesPrepayments  SP  ' +
    ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef   ' +
    ' Where PP.Deleted = "F" and SP.SalesRef = S.Globalref or SP.SalesRef = S.salesorderglobalref) -payment as Invoicebalance,'
    + 'convert(concat(pqabatch.Value , "-",P.CUSTFLD1 , "-",P.CUSTFLD2,  "-",P.CUSTFLD3,"-",Format(pqabatch.UOMQty,2)), char(1000)) as CombinedBarCode ';
  sSQL := sSQL + CHR(13) + ' FROM ' + StringReplace(ProductTables(tDetailswithSno, False, False, 0,
    False), PqaString, '', [rfIgnoreCase]) +
    ' inner join tblunitsofmeasure UOM on UOM.UnitID = PQA.UOMID ' +
    ' inner join tblsaleslines AS SL on SL.ProductID = P.PartsID and ifnull(SL.BOMProductionLine, "F") ="F" '
    + ' Left join ( (Select SLPW.SaleLineId, ' +
    ' sum(ifnull(SLPW.AttribValue1,0)*ifnull(Packcount,0)) as PackFieldValue1 ,  ' +
    ' sum(ifnull(SLPW.AttribValue2,0)*ifnull(Packcount,0)) as PackFieldValue2 ,  ' +
    ' sum(ifnull(Packcount,0)) as Packcount   ' +
    ' from tblsaleslinepackweightlines SLPW group by SLPW.SaleLineId)) as  SLP on  SLP.SaleLineId = SL.saleLineId'
    +

    ' inner JOIN tblsales AS S ON  SL.SaleID = S.SaleID and ifnull(SL.BOMProductionLine, "F") ="F" '
    + ' inner JOIN tblclients AS CL ON S.ClientID = CL.ClientID' +
    ' LEFT JOIN tblcontacts AS ct on (S.ContactID=ct.ContactID)           ' +
    ' Left join tblclienttype CLT on CLT.ClientTypeID = CL.ClientTypeID' +
    ' Left Join tblproductbin as DPB on DPB.BinID = PC.DefaultBinID' +
    ' Left join tblpartspics PP ON PP.partID = P.PartsID and PP.isDefault = "T"';

  sSQL := sSQL + '  WHERE  P.HideonPickSlip <> "T"';
  if (TransIDs <> '') then
    sSQL := sSQL + ' AND S.SaleID in ( ' + TransIDs + ')'
  else
    sSQL := sSQL + '  AND S.SaleID <> 0 ';

  if (TransType <> '') then
    sSQL := sSQL + '  and PQA.transtype in (' + TransType + ')';

  sSQL := sSQL + ' and PQA.TransId = SL.saleId and PQA.TransLineId = SL.SaleLineId ';

  if fsBinfilter <> '' then
    sSQL := sSQL + ' AND ' + fsBinfilter;

  sSQL := sSQL + CHR(13) + ' Group by GroupField,   ';
  if PickingSlipOrder = 5 then
    sSQL := sSQL + 'S.SaleID, SL.SortID,Sl.SalelineID,  ';
  sSQL := sSQL +
    ' PBin.binnumber,PBin.Binlocation, PQABatch.Value , PQABatch.ExpiryDate, ProductID, SL.SaleLineID, PQASN.value';

  { non inventory items }
  sSQL := sSQL + CHR(13) + ' Union All SELECT  SL.Product_Description as PARTSDESCRIPTION,' +
    'concat_ws("-",SL.Productname,SL.SalesLinesCustField1) as ProductnamenCustFld1 ,' +
    'concat_ws("-",SL.ProductPrintName,SL.SalesLinesCustField1) as ProductprintnamenCustFld1,' +
    'SL.Product_Description_Memo as PARTSDESCRIPTION_Memo,' + 'SL.RequiresAssembly,' +
    'SL.Attrib1Sale,SL.Attrib2Sale,SL.MemoLine ,' + 'Null as Binlocation,' +
    'null as SaleProductBatchBarcode, ' +
    'null as GrossWeight,'+
    'null as NetWeight,'+
    'Null as binnumber,' + 'Null as batchno,' +
    'Null as BatchGroup,' + 'Null as BatchDetails,' + 'null as TruckLoadNo,' + 'null as ExpiryDate,'
    + 'null as BatchCustFld1,' + 'null as BinQty,' + 'null as SoldSerials, ' +
    'null as BatchnumberCaption,' + 'null as ExpiryDateCaption ,' + 'null as BinLocationCaption,' +
    'null as BinnumberCaption,' + 'null as SerialnumberCaption, ' + 'null as QtyAllocated, ' +
    'null as QtyPicked,  ' + 'CONCAT("S-",S.SaleId) as SaleBarcode, s.*,' +
    'SL.SalesLinesCustField1,SL.SalesLinesCustField2,SL.SalesLinesCustField3,SL.SalesLinesCustField4,SL.SalesLinesCustField5,SL.SalesLinesCustField6,SL.SalesLinesCustField7,SL.SalesLinesCustField8,SL.SalesLinesCustField9,SL.SalesLinesCustField10,'
    + '`SL`.`WarrantyPeriod`,`SL`.`WarrantyEndsOn`, SL.SortId,' +
    'SL.ProductID, SL.ProductName, SL.UnitofMeasureSaleLines, ' +
    ' if (HoldSale = "T", "HOLD", "") AS Hold, ' + CHR(13) + ' P.BARCODE as ProductBarCode,' +
    CHR(13) + ' CONCAT(SL.ProductName,Product_Description) AS GroupLine, ' + CHR(13) +
    ' CL.CUSTFLD1,CL.CUSTFLD2,CL.CUSTFLD3,CL.CUSTFLD4,CL.CUSTFLD5, ' + CHR(13) +
    ' CL.CUSTFLD6,CL.CUSTFLD7,CL.CUSTFLD8,CL.CUSTFLD9, CL.CUSTFLD10, ' + CHR(13) +
    ' CL.CUSTFLD11,CL.CUSTFLD12,CL.CUSTFLD13,CL.CUSTFLD14,CL.CUSTFLD15, ' + CHR(13) +
    ' CL.Phone as CustomerPhone,CL.FaxNumber as CustomerFaxNumber, ' + CHR(13) +
    ' CL.Mobile as CustomerMobile,   ' + CHR(13) + Thirdcolumn + '  as Dept, ' + CHR(13) +
    SecondColumn + ' as type, ' + CHR(13) + Firstcolumn + ' as Manufacture, ';

  // if (PickingSlipOrder = 5) or (PickingSlipOrder = 0) then
  sSQL := sSQL + 'Sl.SaleLineID , ' + 'sum(SL.UnitofMeasureShipped)   as qShipped, ' +
    'sum(SL.UnitofMeasureBackorder) as qBackorder , ' +
    'sum(UnitofMeasureQtySold)     as qOrdered, ' +
    'sum(SL.totalLineAmountInc)     as totalLineAmountInc, ' +
    'sum(SL.LinePriceInc) as LinePriceInc, ' + 'sum(SL.LinePrice) as LinePriceEx, ';

  if PickingSlipOrder = 0 then
    sSQL := sSQL + 'CONCAT("Product Details :" , SL.ProductName,Product_Description) AS Groupfield '
  else if PickingSlipOrder = 1 then
    sSQL := sSQL + 'null  as GroupField'
  else if PickingSlipOrder = 2 then
    sSQL := sSQL + 'CONCAT(' + QuotedStr(AppEnv.DefaultClass.Firstcolumn) + ',' + QuotedStr(': ') +
      ', ' + Firstcolumn + ')  as GroupField'
  else if PickingSlipOrder = 3 then
    sSQL := sSQL + 'CONCAT(' + QuotedStr(AppEnv.DefaultClass.SecondColumn) + ',' + QuotedStr(': ') +
      ', ' + SecondColumn + ')  as GroupField'
  else if PickingSlipOrder = 4 then
    sSQL := sSQL + 'CONCAT(' + QuotedStr(AppEnv.DefaultClass.Thirdcolumn) + ',' + QuotedStr(': ') +
      ', ' + Thirdcolumn + ')  as GroupField'
  else if PickingSlipOrder = 5 then
    sSQL := sSQL + 'Concat(' + QuotedStr('Invoice No: ') + ', S.invoicedocnumber) AS Groupfield ';

  sSQL := sSQL + ',CLT.TypeName,' + 'NULL, NULL ';
  sSQL := sSQL + ',P.CUSTFLD1 AS ProductCustFld1, ' + 'P.CUSTFLD2  AS ProductCustFld2, ' +
    'P.CUSTFLD3  AS ProductCustFld3, ' + 'P.CUSTFLD4  AS ProductCustFld4, ' +
    'P.CUSTFLD5  AS ProductCustFld5, ' + 'P.CUSTFLD6  AS ProductCustFld6, ' +
    'P.CUSTFLD7  AS ProductCustFld7, ' + 'P.CUSTFLD8  AS ProductCustFld8, ' +
    'P.CUSTFLD9  AS ProductCustFld9, ' + 'P.CUSTFLD10 AS ProductCustFld10, ' +
    'P.CUSTFLD11 AS ProductCustFld11, ' + 'P.CUSTFLD12 AS ProductCustFld12, ' +
    'P.CUSTFLD13 AS ProductCustFld13, ' + 'P.CUSTFLD14 AS ProductCustFld14, ' +
    'P.CUSTFLD15 AS ProductCustFld15, ' + 'P.CUSTDATE1 AS ProductCustDate1, ' +
    'P.CUSTDATE2 AS ProductCustDate2, ' + 'P.CUSTDATE3 AS ProductCustDate3, ' +
    'PP.partPic as PartPicture, ' +
    'UOM.Height 	as Height,  ' +
    'UOM.Width 	as Width,  ' +
    'UOM.Length 	as Length,  ' +
    'UOM.Weight 	as Weight,  ' +
    'UOM.Volume 	as Volume,' +
    'SL.UnitofMeasureShipped * UOM.Height as shippedHeight,  ' +
    'SL.UnitofMeasureShipped * UOM.Width 	as shippedWidth,  ' +
    'SL.UnitofMeasureShipped * UOM.Length as  shippedLength,' +
    'SL.UnitofMeasureShipped * UOM.Weight as  shippedWeight,' +
    'SL.UnitofMeasureShipped * UOM.Volume as  shippedVolume,' +
    'ct.contactemail as ContEmail, ' +
    'ct.contacttitle as ContTitle, ' + 'ct.contactfirstname as ContFirstName, ' +
    'ct.contactsurname as ContSurname,   ' + 'ct.contactaddress as ContAddress, ' +
    'ct.contactaddress2 as ContAddress2, ' + 'ct.contactaddress3 as ContAddress3, ' +
    'ct.contactcity as ContCity, ' + 'ct.contactstate as ContState, ' +
    'ct.contactpcode as ContPostcode, ' + 'ct.contactcountry as ContCountry, ' +
    'ct.contactph as ContPh, ' + 'ct.contactaltph as ContAltPh, ' + 'ct.contactmob as ContMob, ' +
    'ct.contactfax as ContactFax,' + 'CL.Street, ' + 'CL.Street2, ' + 'CL.Street3, ' + 'CL.Suburb, '
    + 'CL.State , ' + 'CL.Postcode,CL.DeliveryNotes,' +
    'SLP.PackFieldValue1  , SLP.PackFieldValue2 , SLP.Packcount , ' +
    '(Select Sum(PP.Balance) TotalBalance  ' + ' from tblSalesPrepayments  SP  ' +
    ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef   ' +
    ' Where PP.Deleted = "F" and SP.SalesRef = S.Globalref or SP.SalesRef = S.salesorderglobalref) as Prepayments,   '
    + '(Select Sum(PP.Balance) TotalBalance  ' + ' from tblSalesPrepayments  SP  ' +
    ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef   ' +
    ' Where PP.Deleted = "F" and SP.SalesRef = S.Globalref or SP.SalesRef = S.salesorderglobalref) +S.payment as Totalpayment,  '
    + 'S.totalamountinc - (Select Sum(PP.Balance) TotalBalance  ' +
    ' from tblSalesPrepayments  SP  ' +
    ' inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef   ' +
    ' Where PP.Deleted = "F" and SP.SalesRef = S.Globalref or SP.SalesRef = S.salesorderglobalref) -payment as Invoicebalance, '
    + ' null as CombinedBarCode ';
  sSQL := sSQL + CHR(13) + '  FROM tblParts as P ' +
    ' inner join tblsaleslines AS SL on SL.ProductID = P.PartsID ' +
    ' Left join ( (Select SLPW.SaleLineId, ' +
    ' sum(ifnull(SLPW.AttribValue1,0)*ifnull(Packcount,0)) as PackFieldValue1 ,  ' +
    ' sum(ifnull(SLPW.AttribValue2,0)*ifnull(Packcount,0)) as PackFieldValue2 ,  ' +
    ' sum(ifnull(Packcount,0)) as Packcount   ' +
    ' from tblsaleslinepackweightlines SLPW group by SLPW.SaleLineId)) as  SLP on  SLP.SaleLineId = SL.saleLineId'
    + ' inner join tblunitsofmeasure UOM on UOM.UnitID = SL.UnitOfMeasureID ' +
    ' inner JOIN tblsales AS S ON  SL.SaleID = S.SaleID ' +
    ' inner JOIN tblclients AS CL ON S.ClientID = CL.ClientID ' +
    ' LEFT JOIN tblcontacts AS ct on (S.ContactID=ct.ContactID)           ' +
    ' Left join tblclienttype CLT on CLT.ClientTypeID = CL.ClientTypeID' +
    ' Left join tblpartspics PP ON PP.partID = P.PartsID and PP.isDefault = "T"' +
    ' Where P.PartType <> "INV" ' + ' AND P.HideonPickSlip <> "T"';

  if (TransIDs <> '') then
    sSQL := sSQL + ' AND S.SaleID in ( ' + TransIDs + ')'
  else
    sSQL := sSQL + ' AND S.SaleID <> 0 ';

  sSQL := sSQL + CHR(13) + ' Group by  GroupField,ProductID, SL.SaleLineID';

  if PickingSlipOrder = 5 then
    sSQL := sSQL + ', S.SaleID, SL.SortID, Sl.SaleLineId  ';

  if PickingSlipOrder = 0 then begin // productname
    sSQL := sSQL + ' ORDER BY Groupfield';
  end
  else if PickingSlipOrder = 1 then begin // bins
    sSQL := sSQL + ' ORDER BY  Groupfield, BatchGroup, BatchDetails, batchno ;';
  end
  else if PickingSlipOrder = 2 then begin // first columne (Manufacture)
    sSQL := sSQL + ' ORDER BY Groupfield, Manufacture'; // Product_Description';
  end
  else if PickingSlipOrder = 3 then begin // second column
    sSQL := sSQL + ' ORDER BY Groupfield,type'; // Product_Description';
  end
  else if PickingSlipOrder = 4 then begin // third column
    sSQL := sSQL + ' ORDER BY Groupfield,Dept'; // Product_Description';
  end
  else if PickingSlipOrder = 5 then begin // defualt order
    sSQL := sSQL + ' ORDER BY SaleID, SortID, BatchGroup , BatchDetails';
  end;

  { if report has a master-detail relationship, the detail sql is added here which has to be the second SQL - SO DON'T MOVE THIS SECTION }
  if DetailSQL <> '' then
    sSQL := sSQL + CHR(13) + '~|||~' + DetailSQL;

  sSQL := sSQL + '~|||~{CompanyInfo}'+CompanyInfoSQL;
  sSQL := sSQL + '~|||~{AttribCaptions}SELECT  ' + QuotedStr(AppEnv.CompanyPrefs.ProductAttrib1Name)
    + ' as ProductAttrib1Name, ' + QuotedStr(AppEnv.CompanyPrefs.ProductAttrib2Name) +
    ' as ProductAttrib2Name, ' + QuotedStr('Price / ' + AppEnv.CompanyPrefs.ProductAttrib1Name) +
    ' as ProductAttrib1SaleRate';

  sSQL := sSQL + '~|||~{BinBatchStock} Select PQa.UOM ,' +
    'C.Classname, SL.Product_Description as PARTSDESCRIPTION,' +
    'SL.Product_Description_Memo as PARTSDESCRIPTION_Memo,' + 'SL.RequiresAssembly,' +
    'SL.Attrib1Sale,' + 'SL.Attrib2Sale,' +
    'PBin.Binlocation, PBin.binnumber,PQABatch.Value as batchno,PQABatch.TruckLoadNo ,  PQABatch.ExpiryDate, '
    + SplitField('PQABatch', 'Value', 1, '-') + ' as BatchGroup,' + SplitField('PQABatch', 'Value',
    2, '-') + ' as BatchDetails,' +
  // 'sum(if (ifnull(PQABins.PQADEtailID,0)<>0 , PQABins.UOMQty , PQABatch.UOMQty)) as BinQty,'+
  (* 'Round(sum(if(PQA.TransID = SL.SaleId and PQa.transLineId = Sl.SaleLineId and PQa.transtype in (' +SalesTransTypes +') , 0 ,' +
    'if(PQA.Alloctype="IN" , (if (ifnull(PQABins.PQADEtailID,0)<>0 , PQABins.UOMQty , PQABatch.UOMQty)) , '+
    '0-(if (ifnull(PQABins.PQADEtailID,0)<>0 , PQABins.UOMQty , PQABatch.UOMQty))))), ' +inttostr(tcConst.GeneralRoundPlaces) +') as BinQty,'+

    'Round(sum(if(PQA.TransID = SL.SaleId and PQa.transLineId = Sl.SaleLineId and PQa.transtype in (' +SalesTransTypes +') ,'+
    '(if (ifnull(PQABins.PQADEtailID,0)<>0 , PQABins.UOMQty , PQABatch.UOMQty)) ,0)), ' +inttostr(tcConst.GeneralRoundPlaces) +') as allocatedqty,' +

    'Round(sum(if(PQA.TransID = SL.SaleId and PQa.transLineId = Sl.SaleLineId and PQa.transtype in (' +SalesTransTypes +') ,'+
    '(if (ifnull(PQABins.PQADEtailID,0)<>0 , PQABins.BOUOMQty , PQABatch.BOUOMQty)) ,0)), ' +inttostr(tcConst.GeneralRoundPlaces) +') as BOallocatedqty,' +

    'Round(sum(if(PQA.TransID = SL.SaleId and PQa.transLineId = Sl.SaleLineId and PQa.transtype in (' +SalesTransTypes +') ,'+
    '(PQABatch.CUSTFLD1) ,0)), ' +inttostr(tcConst.GeneralRoundPlaces) +') as allocatedLength,' + *)

    '(Select ' +
    'Round(sum(if(sPQA.TransID = SL.SaleId and sPQA.transLineId = Sl.SaleLineId and sPQA.transtype = pqa.transtype ,  '
    + '0 ,if(sPQA.Alloctype="IN" , (if (ifnull(sPQABins.PQADEtailID,0)<>0 , sPQABins.UOMQty , sPQABatch.UOMQty)) , 0-(if (ifnull(sPQABins.PQADEtailID,0)<>0 , sPQABins.UOMQty , sPQABatch.UOMQty))))), 5) as BinQty '
    + 'from ' + 'tblparts sP ' + 'inner join tblpqa sPQA  on sPQA.productId = sP.partsId ' +
    'left join `tblPqaDetails` sPQABatch  on sPQABatch.PQAId 	= sPQA.PQAID and sPQABatch.PQAType = "Batch"  and sPQABatch.Active= "T" '
    + 'left join `tblPqaDetails` sPQABins  on sPQABins.PQAId 	= sPQA.PQAID  and sPQABins.PQAType = "Bin" and sPQABins.Active = "T" and    '
    + '( (sPQABatch.globalref = IFNULL(sPQABins.ParentRef,"") and sP.Batch="T" and sP.multiplebins = "T")  or   (ifnull(sPQABins.Parentref ,"") = "" AND sP.Batch="F" and sP.multiplebins = "T")) '
    + 'where sPQA.ProductID = PQa.productId and sPQA.DepartmentID = PQA.DepartmentID ' +
    'and ((sP.batch ="F" ) or (sPQABatch.value = PQABatch.value and sPQABatch.expiryDate = PQABatch.ExpiryDate and sPQABatch.truckloadno = PQABatch.truckloadno )) '
    + 'and ((sP.multiplebins ="F" ) or(sPQABins.binId = PQABins.binId))  ) as BinQty,' +

    'Round(sum(if (ifnull(PQABins.PQADEtailID,0)<>0 , PQABins.UOMQty , PQABatch.UOMQty)) , ' +
    inttostr(tcConst.GeneralRoundPlaces) + ') as allocatedqty,' +
    'Round(sum(if (ifnull(PQABins.PQADEtailID,0)<>0 , PQABins.BOUOMQty , PQABatch.BOUOMQty)) , ' +
    inttostr(tcConst.GeneralRoundPlaces) + ') as BOallocatedqty,' +
    'Round(sum(PQABatch.CUSTFLD1) , ' + inttostr(tcConst.GeneralRoundPlaces) +
    ') as allocatedLength,' +

    ' CONCAT("S-",S.SaleId) as SaleBarcode, S.*,`SL`.`WarrantyPeriod`,`SL`.`WarrantyEndsOn`, SL.sortID,'
    + 'SL.ProductID, SL.ProductName, SL.UnitofMeasureSaleLines, ' +
    ' if (HoldSale = "T", "HOLD", "") AS Hold, ' + CHR(13) + ' P.BARCODE as ProductBarCode,' +
    CHR(13) + ' CONCAT(SL.ProductName,Product_Description) AS GroupLine, ' + CHR(13) +
    ' CL.CUSTFLD1,CL.CUSTFLD2,CL.CUSTFLD3,CL.CUSTFLD4,CL.CUSTFLD5, ' + CHR(13) +
    ' CL.CUSTFLD6,CL.CUSTFLD7,CL.CUSTFLD8,CL.CUSTFLD9, CL.CUSTFLD10, ' + CHR(13) +
    ' CL.CUSTFLD11,CL.CUSTFLD12,CL.CUSTFLD13,CL.CUSTFLD14,CL.CUSTFLD15, ' + CHR(13) +
    ' CL.Phone as CustomerPhone,CL.FaxNumber as CustomerFaxNumber, ' + CHR(13) +
    ' CL.Mobile as CustomerMobile,   ' + CHR(13) + Thirdcolumn + '  as Dept, ' + CHR(13) +
    SecondColumn + ' as type, ' + CHR(13) + Firstcolumn + ' as Manufacture, ';

  // if (PickingSlipOrder = 5) or (PickingSlipOrder = 0) then
  sSQL := sSQL + 'Sl.SaleLineID ,' + 'sum(SL.UnitofMeasureShipped)   as qShipped, ' +
    'sum(SL.UnitofMeasureBackorder) as qBackorder , ' +
    'sum(UnitofMeasureQtySold)      as qOrdered, ' +
    'sum(SL.totalLineAmountInc)     as totalLineAmountInc, ' +
    'sum(SL.LinePriceInc) as LinePriceInc, ' + 'sum(SL.LinePrice) as LinePriceEx, ';

  if PickingSlipOrder = 0 then
    sSQL := sSQL +
      'CONCAT( "Product Details :" , SL.ProductName,Product_Description) AS Groupfield '
  else if PickingSlipOrder = 1 then
    sSQL := sSQL +
      'CONCAT( "Bin Location / Number:" , PBin.BinLocation,"-",PBin.BinNumber) as GroupField'
  else if PickingSlipOrder = 2 then
    sSQL := sSQL + 'CONCAT(' + QuotedStr(AppEnv.DefaultClass.Firstcolumn) + ',' + QuotedStr(': ') +
      ',' + Firstcolumn + ')  as GroupField'
  else if PickingSlipOrder = 3 then
    sSQL := sSQL + 'CONCAT(' + QuotedStr(AppEnv.DefaultClass.SecondColumn) + ',' + QuotedStr(': ') +
      ',' + SecondColumn + ')  as GroupField'
  else if PickingSlipOrder = 4 then
    sSQL := sSQL + 'CONCAT(' + QuotedStr(AppEnv.DefaultClass.Thirdcolumn) + ',' + QuotedStr(': ') +
      ',' + Thirdcolumn + ')  as GroupField'
  else if PickingSlipOrder = 5 then
    sSQL := sSQL + 'Concat(' + QuotedStr('Invoice No: ') + ', S.invoicedocnumber) AS Groupfield ';

  sSQL := sSQL + ',CLT.TypeName,' +
    'DPB.BinLocation as DefaultBinLocation,DPB.BinNumber as DefaultBinNumber ';
  sSQL := sSQL + ',P.CUSTFLD1 AS ProductCustFld1, ' + 'P.CUSTFLD2 AS ProductCustFld2, ' +
    'P.CUSTFLD3 AS ProductCustFld3, ' + 'P.CUSTFLD4 AS ProductCustFld4, ' +
    'P.CUSTFLD5 AS ProductCustFld5, ' + 'P.CUSTFLD6 AS ProductCustFld6, ' +
    'P.CUSTFLD7 AS ProductCustFld7, ' + 'P.CUSTFLD8 AS ProductCustFld8, ' +
    'P.CUSTFLD9 AS ProductCustFld9, ' + 'P.CUSTFLD10 AS ProductCustFld10, ' +
    'P.CUSTFLD11 AS ProductCustFld11, ' + 'P.CUSTFLD12 AS ProductCustFld12, ' +
    'P.CUSTFLD13 AS ProductCustFld13, ' + 'P.CUSTFLD14 AS ProductCustFld14, ' +
    'P.CUSTFLD15 AS ProductCustFld15, ' + 'P.CUSTDATE1 AS ProductCustDate1, ' +
    'P.CUSTDATE2 AS ProductCustDate2, ' + 'P.CUSTDATE3 AS ProductCustDate3 ';

  sSQL := sSQL + ' FROM  tblSaleslines SL ' + ' inner JOIN tblsales AS S ON  SL.SaleID = S.SaleID '
    + ' inner join tblClients CL on CL.ClientID = S.ClientID ' +
    ' Left join tblclienttype CLT on CLT.ClientTypeID = CL.ClientTypeID ' +
    ' inner join `tblParts` as P on SL.ProductId = P.PartsId ' +
    ' inner join `tblPQA` as PQA on PQA.transId = SL.saleId and PQA.translineId =  Sl.salelineId and PQA.transtype in ('
    + SalesTransTypes + ' ) ' + ' inner join `tblclass` as C on PQA.departmentID = C.ClassID ' +
    ' Inner join `tblProductClasses` as PC on PC.ProductID = PQA.ProductID and PC.ClassID = PQA.departmentID '
    + ' Left Join tblproductbin as DPB on DPB.BinID = PC.DefaultBinID ' +
    ' left join `tblPqaDetails` PQABatch  on PQABatch.PQAId 	= PQA.PQAID and PQABatch.PQAType = "Batch"  and PQABatch.Active= "T" '
    + ' left join `tblPqaDetails` PQABins  on PQABins.PQAId 	= PQA.PQAID  and PQABins.PQAType = "Bin" and PQABins.Active = "T" and  '
    + ' ( (PQABatch.globalref = IFNULL(PQABins.ParentRef,"") and P.Batch="T" and P.multiplebins = "T")  or  '
    + ' (ifnull(PQABins.Parentref ,"") = "" AND P.Batch="F" and P.multiplebins = "T")) ' +
    ' Left join `tblProductBin` PBin     on PBin.binId 	= PQABins.BinID ' +
  (* ' FROM ' +ProductTables(tExtraDetails)+
    ' inner join tblSaleslines SL on SL.ProductId = P.PartsId ' +
    ' inner JOIN tblsales AS S ON  SL.SaleID = S.SaleID '+
    ' inner join tblClients CL on CL.ClientID = S.ClientID'+
    ' Left join tblclienttype CLT on CLT.ClientTypeID = CL.ClientTypeID '+
    ' Left Join tblproductbin as DPB on DPB.BinID = PC.DefaultBinID '+ *)
    ' Where P.PartType = "INV"';

  if (TransIDs <> '') or (TransType <> '') then
    sSQL := sSQL + ' AND  S.SaleID in( ' + TransIDs + ')';
  // +' and PQA.transtype in (' + Transtype+')'

  if fsBinfilter <> '' then
    sSQL := sSQL + ' AND ' + fsBinfilter;

  sSQL := sSQL + CHR(13) + ' Group by PQa.departmentID, PQa.UOM , GroupField,   ';
  if PickingSlipOrder = 5 then
    sSQL := sSQL + 'S.SaleID, SL.SortID,Sl.SalelineID,  ';
  sSQL := sSQL +
    ' PBin.binnumber,PBin.Binlocation, PQABatch.Value , PQABatch.ExpiryDate, ProductID, SL.SaleLineID '
    + 'having ';
  if AppEnv.CompanyPrefs.ExcludeZeroAllocationsFromPickingSlip then begin
  end
  else begin
    sSQL := sSQL + ' ifnull(Binqty,0)<> 0  or ';
  end;
  sSQL := sSQL + ' ifnull(allocatedqty,0)<> 0';
  if SameText(reportName, 'Picking Slip with Batch Qty with BatchGroup') then
    sSQL := sSQL +
      ' Order by Classname, BatchGroup, BatchDetails, batchno ,TruckLoadNo ,  binlocation, binnumber, uom '
  else if SameText(reportName, 'Picking Slip with Batch Qty with Totals') then
    sSQL := sSQL +
      ' Order by Classname,Productname, BatchGroup, BatchDetails, batchno ,TruckLoadNo ,  binlocation, binnumber, uom '
  else
    sSQL := sSQL + ' Order by Classname,batchno ,TruckLoadNo ,  binlocation, binnumber, uom ';

  sSQL := sSQL + '~|||~{TaxDetails}Select TTCL.`SubTaxCode`, TTCL.Percentage,    ' +
    ' Sum(TTCL.`TaxAmount`) TaxAmount   ' + ' from tblsalestaxcodelines TTCL   ' +
    ' inner join tblsalestaxcodes TTC on TTCL.SalesTaxCodeID = TTC.ID ' + ' Where TTC.SaleId in( ' +
    TransIDs + ') group by TTCL.`SubTaxCode` ';
  sSQL := sSQL + '~|||~{ClientCustomFields}Select  CFL.Description , CCV.Value   ' +
    ' from  tblsales Trans    ' +
    ' inner join tblcustomfieldvaluesClients CCV on Trans.ClientID = CCV.MasterID   ' +
    ' inner join tblcustomfieldlist CFL on CFL.CFID = CCV.CustomFieldlistId   ' +
    ' where ifnull(CCV.Value,"")<>""  and CFL.ListType = "ltCustomer"';
  sSQL := sSQL + '~|||~{CompanyInfo}' + companyInfoSQL('', 0, 0, False);

  sSQL := sSQL + '~|||~{RawMaterials}select  ' + ' sl.saleId, sl.salelineId,  ' +
    ' PT.MasterId	,PT.SequenceDown,PT.SequenceUp	,PT.Caption	,PT.Description	,PT.Quantity	,PT.TotalQty	,PT.TotalQtyOriginal	,PT.QtyOriginal	,PT.QtyVariation,  '
    + ' PT.HideOnPrint	,PT.AddToSale	,PT.PartSource,PT.Price	,PT.TreePricechanged	,PT.Cost	,PT.ProcStepItemRef	,PT.Value	,PT.Complete	,PT.Level	,PT.Info	,  '
    + ' PT.QtyPer,PT.TreePartUOM	,PT.TreePartUOMMultiplier	,PT.TreePartUOMQuantity	,PT.TreePartUOMTotalQty	,PT.MatrixDesc	,PT.MatrixRef	,PT.MatrixPrice	,PT.FromStockUOMQty	,  '
    + ' PT.ManufactureUOMQty	,PT.ManufacturedUOMQty	,PT.ManufacturingUOMQty	,PT.OnOrderUOMQty	,PT.FromStockQty	,PT.ManufactureQty	,PT.ManufacturedQty	,PT.ManufacturingQty	,  '
    + ' PT.OnOrderQty	,PT.QtyPlanned	,PT.TotalQtyPlanned	,	PT.FormulaQtyValue1	,	PT.FormulaQtyValue2	,	PT.FormulaQtyValue3	,	PT.FormulaQtyValue4	,	PT.FormulaQtyValue5	,  '
    + ' PT.FormulaQtyValue	,	PT.BuildFormulaQtyValue1	,	PT.BuildFormulaQtyValue2	,	PT.BuildFormulaQtyValue3	,	PT.BuildFormulaQtyValue4	,	PT.BuildFormulaQtyValue5	,	PT.BuildFormulaQtyValue	,  '
    + ' PT.BuildLineNo		,	PT.OrderFormulaQtyValue1	,	PT.OrderFormulaQtyValue2	,	PT.OrderFormulaQtyValue3	,	PT.OrderFormulaQtyValue4	,	PT.OrderFormulaQtyValue5	,	PT.OrderFormulaQtyValue	,  '
    + ' PT.ProductUnitPrice	,	PT.ProductUnitCost	,	PT.BOMGroupedLine	,PT.BOMProductionLine	,PT.MakeCoupons	,PT.CouponLabelPrinted	,PT.QtyPerCoupon	,	PT.RAtePercoupon	,  '
    + ' PT.CouponsPerBundle	,PT.BundleQty	,	PT.ZeroWhenLessthan1	,PT.RoundtoNextNumber	,PT.RoundtoPrevNumber	,PT.comments	,	PT.IgnoreItemCommentsforDescription	,  '
    + ' TreeNodeCaption(PT.Level, PT.Caption) as TreeNodeCaption ,  ' +
    ' concat(pt.TreePartUOM , "(" , pt.TreePartUOMMultiplier , ")") as UOM  ' +
    ' from tblsaleslines Sl  ' +
    ' inner join tblproctree pt on sl.salelineid = pt.MasterId and pt.MasterType <> "mtProduct"  ' +
    ' left join tblproctree ppt on pt.ParentId = ppt.ProcTreeId  ' +
    ' left join tblprocesspart ptp on pt.ProcTreeId = ptp.ProcTreeId  ' + ' where sl.saleID in( ' +
    TransIDs +
    ')  and (ifnull(ppt.ProcTreeId,0)=0 or ppt.InputType <> "itOption" or (ppt.InputType = "itOption" and pt.Selected ="T"))';

  Json := PickingSlipreportJson;
  result := sSQL;
end;

end.
