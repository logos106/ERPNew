unit ProductSalesDetailsSQL;

interface

uses
  classes, ReportBaseObj, Types;

type

  TProductSalesDetailsReport = class(TReportWithDateRangeBase)
  private
    fFirstColumn: String;
    fProductID: Integer;
    fDepartmentID: Integer;
    fSecondColumn: String;
    fThirdColumn: String;
    fIncludeProductsUsedInManufacture: boolean;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  published
    Property ProductID: Integer read fProductID write fProductID;
    property IncludeProductsUsedInManufacture: boolean read fIncludeProductsUsedInManufacture
      write fIncludeProductsUsedInManufacture;
    Property DepartmentID: Integer read fDepartmentID write fDepartmentID;
    Property FirstColumn: String read fFirstColumn  write fFirstColumn;
    Property SecondColumn: String read fSecondColumn write fSecondColumn;
    Property ThirdColumn: String read fThirdColumn write fThirdColumn;
  end;


implementation

uses
  ProductQtyLib, SysUtils, CommonLib, tcConst, AppEnvironment;

{ TProductSalesDetailsReport }

constructor TProductSalesDetailsReport.Create;
begin
  inherited;
  fFirstColumn := '';
  fProductID := 0;
  fDepartmentID := 0;
  fSecondColumn := '';
  fThirdColumn := '';
  fIncludeProductsUsedInManufacture := false;
  DateTo := MaxDateTime;
  DateFrom := 0;
end;

destructor TProductSalesDetailsReport.Destroy;
begin

  inherited;
end;

function TProductSalesDetailsReport.PopulateReportSQL(SQL: TStrings;
  var msg: string): boolean;
begin
  inherited;
  SQL.Clear;
  msg := '';
  result := true;
  SQL.Add('SELECT "S" as Category,  ');
  SQL.Add('if('+ inttostr(DepartmentID )+'>0 , S.Class , "All") as Classname, ');
  SQL.Add('S.SaleDate as SaleDate,');
  SQL.Add(ProductQtyLib.firstcolumn   + ' as FirstColumn,');
  SQL.Add(ProductQtyLib.Secondcolumn  + ' as Secondcolumn,');
  SQL.Add(ProductQtyLib.Thirdcolumn   + ' as Thirdcolumn,');
  SQL.Add(' Trim(SL.ProductName) as ProductName , ');
  SQL.Add(' ifnull(TT.Description , if(S.IsInvoice="T" , "Invoice" , if(issalesorder = "T" , "Sales Order" , if(iscashSale="T" , "Cash Sale" , if(isRefund = "T" , "Refund" , if(isLayby="T", "Layby" , "")))))) as TransactionType,');
  SQL.Add(' ifnull(TT.FormName , if(S.IsInvoice="T" , "TInvoiceGUI" , if(issalesorder = "T" , "TSalesOrderGUI" , if(iscashSale="T" , "TCashSaleGUI" , if(isRefund = "T" , "TRefundGUI" , if(isLayby="T", "TSalesOrderGUI" , "")))))) as FormName,');
  SQL.Add(' S.InvoiceDocNumber as InvoiceNo, ');
  SQL.Add(' S.CustomerName as CustomerName, ');
  SQL.Add(' Round(Sum(SL.Shipped), ' + IntToStr(tcConst.GeneralRoundPlaces) + ') as Qty, ');
  SQL.Add(' SL.UnitOfMeasureSaleLines as UnitOfMeasure, ');
  SQL.Add(' Convert(FXCode( S.ForeignExchangeCode ,ifnull(SL.ForeignExchangeSellRate ,S.ForeignExchangeRate) ,' +
    QuotedStr(Appenv.RegionalOptions.ForeignExDefault) +'), char(100)) as FXCode,');
  SQL.Add(' Sum(SL.ForeignTotalLineAmount) as ForeignTotalLineAmount,');
  SQL.Add(' Sum(SL.TotalLineAmount) as `Total Amount (Ex)`, ');
  SQL.Add(' Round(Sum(SL.TotalLineAmount) - SUM(SL.LineCost*SL.Shipped),'+IntToStr(CurrencyRoundPlaces) +') as `Total Profit (Ex)`, ');
  SQL.Add(' Round(Sum(SL.TotalLineAmountInc) - SUM(SL.LineCostInc*SL.Shipped),'+IntToStr(CurrencyRoundPlaces) +') as `Total Profit (Inc)`, ');
  SQL.Add(' Sum(SL.TotalLineAmountInc) as `Total Amount (Inc)`, ');
  SQL.Add(' SL.TotalLineAmount as GrossProfitTotal, ');
  SQL.Add(' Round(SL.LineCost*SL.Shipped,'+intToStr(CurrencyRoundPlaces) +') as `Line Cost (Ex)`,');
  SQL.Add(' S.SaleID as TransactionNo, ');
  SQL.Add(' SL.ProductID as ProductID, ');
  SQL.Add(' S.EmployeeName as EmployeeName, ');
  SQL.Add(' Sum(SL.Attrib1Sale) as Attrib1Sale, ');
  SQL.add('Sum(SL.Attrib2Sale) as Attrib2Sale,  ');
  SQL.Add(' Sum(SL.Attrib1SaleRate) as Attrib1SaleRate, ');
  SQL.Add(' SL.Product_Description as ProductDescription, ');
  SQL.Add(' IF(INSTR(SL.CustomData, "PriceScheme"),"T","F") as IsSpecial, ');
  SQL.Add(' 2 as Details , ');
  SQL.Add(' SL.SaleLineID as SaleLineID, ');
  SQL.add('CT.TypeName as TypeName,');
  SQL.Add(' S.converted as converted,');
  SQL.Add(' C.Email , ');
  SQL.Add(' C.Street , ');
  SQL.Add(' C.Street2 , ');
  SQL.Add(' C.Suburb , ');
  SQL.Add(' C.State , ');
  SQL.Add(' C.Postcode,');
  SQL.Add(' C.Country,');
  SQL.Add(' C.FirstName,');
  SQL.Add(' C.LastName,');
  SQL.Add('P.CommodityCode,');
  SQL.Add('P.NetWeightKg,');
  SQL.Add('P.ProductUOM,');
  SQL.Add('CTRY.Country as CountryOfOrigin,');
  SQL.Add('P.Ex_Works as ExWorks,');
  SQL.Add('C.CUSTFLD1 as CustomerCUSTFLD1,');
  SQL.Add('C.CUSTFLD2 as CustomerCUSTFLD2,');
  SQL.Add('C.CUSTFLD3 as CustomerCUSTFLD3,');
  SQL.Add('C.CUSTFLD4 as CustomerCUSTFLD4,');
  SQL.Add('C.CUSTFLD5 as CustomerCUSTFLD5,');
  SQL.Add('C.CUSTFLD6 as CustomerCUSTFLD6,');
  SQL.Add('C.CUSTFLD7 as CustomerCUSTFLD7,');
  SQL.Add('C.CUSTFLD8 as CustomerCUSTFLD8,');
  SQL.Add('C.CUSTFLD9 as CustomerCUSTFLD9,');
  SQL.Add('C.CUSTFLD10 as CustomerCUSTFLD10,');
  SQL.Add('C.CUSTFLD11 as CustomerCUSTFLD11,');
  SQL.Add('C.CUSTFLD12 as CustomerCUSTFLD12,');
  SQL.Add('C.CUSTFLD13 as CustomerCUSTFLD13,');
  SQL.Add('C.CUSTFLD14 as CustomerCUSTFLD14,');
  SQL.Add('C.CUSTFLD15 as CustomerCUSTFLD15,');
  SQL.Add('convert(C.CUSTDATE1, dateTime)  as CustomerCUSTDATE1,');
  SQL.Add('convert(C.CUSTDATE2, dateTime)  as CustomerCUSTDATE2,');
  SQL.Add('convert(C.CUSTDATE3, dateTime)  as CustomerCUSTDATE3,');
  SQL.Add('SL.FormulaQtyShippedValue1 as FormulaQtyShippedValue1,');
  SQL.Add('SL.FormulaQtyShippedValue2 as FormulaQtyShippedValue2,');
  SQL.Add('SL.FormulaQtyShippedValue3 as FormulaQtyShippedValue3,');
  SQL.Add('SL.FormulaQtyShippedValue4 as FormulaQtyShippedValue4,');
  SQL.Add('SL.FormulaQtyShippedValue5 as FormulaQtyShippedValue5,');
  SQL.Add('SL.FormulaQtyShippedValue as FormulaQtyShippedValue,');
  SQL.Add('F.formulaNAme as PartCalcformula,');
  SQL.Add('F.formula as formula,');
  SQL.Add('DescribeFormula(F.Formula) as formulaDetails');
  SQL.Add('FROM ');
  SQL.Add('tblsales AS S');
  SQL.Add(' INNER JOIN tblSalesLines as SL USING(SaleID) ');
  SQL.Add('LEft  join (tblfesaleslines FE inner join tblfeformula F on FE.FormulaId = F.formulaID) on FE.salelineId = SL.saleLineId');
  SQL.Add(' INNER JOIN tblparts as P ON PARTSID = SL.ProductID ');
  SQL.Add(' Left JOIN tblcountries as CTRY on CTRY.CountryId = P.CountryofOriginID');
  SQL.Add(' Left JOIN tblPQA as PQA on PQA.TransID = S.SaleId and PQA.TransLineID =SL.SaleLineId and PQA.TransType in (' + SalesTransTypes+')');
  SQL.Add(' Left JOIN tblpqatranstypes as TT ON TT.TRansType  = PQA.TransType ');
  SQL.Add(' INNER JOIN tblclients C ON C.ClientID=S.ClientID ');
  SQL.Add(' LEFT JOIN tblClientType CT ON C.ClientTypeID=CT.ClientTypeID ');
  SQL.Add('Where  (S.IsPOS ="T" or S.IsRefund ="T"  ' +
           ' or S.IsCashSale="T" or S.IsInvoice="T" '+
           ' or S.IsSalesOrder="T" or S.IsLayby ="T") '+
           ' AND SL.Invoiced="T" AND S.Deleted ="F"  AND S.IsQuote="F"  AND S.converted = "F" ');
//           ' AND S.SaleDate Between   :FromDate  AND   :ToDate AND S.ClassID Like :ClassId)');
  if (DateFrom > 0) or (DateTo < MaxDateTime) then
    SQL.Add('and S.SaleDate Between ' + QuotedStr(FormatDateTime('yyyy-mm-dd',DateFrom)) + ' and '  + QuotedStr(FormatDateTime('yyyy-mm-dd',DateTo)));
  if DepartmentID > 0 then
    SQL.Add('and S.ClassID = ' + IntToStr(DepartmentID));
  if fProductID<> 0 then begin
    SQL.Add(' and SL.ProductID = ' +inttostr(fProductID));
  end else if firstcolumn <> '' then  begin
    SQL.Add(' and '+ProductQtyLib.firstcolumn('SL')   + ' = ' +Quotedstr(Firstcolumn));
  end else if Secondcolumn <> '' then  begin
    SQL.Add(' and '+ProductQtyLib.secondcolumn('SL')   + ' = ' +Quotedstr(Secondcolumn));
  end else if Thirdcolumn <> '' then  begin
    SQL.Add(' and '+ProductQtyLib.thirdcolumn('SL')   + ' = ' +Quotedstr(Thirdcolumn));
  end;

  SQL.Add('GROUP BY SL.ProductID, SL.UnitOfMeasureSaleLines, S.SaleID ');

  {manufaturing products}
  if IncludeProductsUsedInManufacture then begin
    SQL.add('union all');
    SQL.Add('SELECT "M" as Category, ');
    SQL.Add('if('+ inttostr(DepartmentID )+'>0 , S.Class , "All") as Classname, ');
    SQL.Add('S.SaleDate as SaleDate,');
    SQL.Add(ProductQtyLib.firstcolumn   + ' as FirstColumn,');
    SQL.Add(ProductQtyLib.Secondcolumn  + ' as Secondcolumn,');
    SQL.Add(ProductQtyLib.Thirdcolumn   + ' as Thirdcolumn,');
    SQL.Add('PTP.ProductName as ProductName, ');
    SQL.Add('"Manufacturing" as TransactionType,');
    SQL.Add(' ifnull(TT.FormName , if(S.IsInvoice="T" , "TInvoiceGUI" , if(issalesorder = "T" , "TSalesOrderGUI" , if(iscashSale="T" , "TCashSaleGUI" , if(isRefund = "T" , "TRefundGUI" , if(isLayby="T", "TSalesOrderGUI" , "")))))) as FormName,');
    SQL.Add(' S.InvoiceDocNumber as InvoiceNo,');
    SQL.Add('S.CustomerName as Customername,');
    SQL.Add('Sum(PTP.Qty) as Qty,');
    SQL.Add('PTP.UnitOfMeasure as UnitOfMeasure,');
    SQL.Add(' Convert(FXCode( S.ForeignExchangeCode ,ifnull(SL.ForeignExchangeSellRate ,S.ForeignExchangeRate) ,' +QuotedStr(Appenv.RegionalOptions.ForeignExDefault) +'), char(100)) as FXCode,');
    SQL.Add('Sum(PTP.Qty*PT.Price*ifnull(SL.ForeignExchangeSellRate ,ifnull(S.ForeignExchangeRate,1))) as ForeignTotalLineAmount,');
    SQL.Add('Sum(PTP.Qty*PT.Price)  as `Total Amount (Ex)`,');
    SQL.Add('Sum(PTP.Qty*PT.Price) - Sum(PTP.Qty * PT.Cost) as `Total Profit (Ex)`,');
    SQL.Add('Sum(PTP.Qty*PT.Price) - Sum(PTP.Qty * PT.Cost)  as `Total Profit (Inc)`,');
    SQL.Add('Sum(PTP.Qty*PT.Price)  as `Total Amount (Inc)`,');
    SQL.Add('Sum(PTP.Qty*PT.Price)  as GrossProfitTotal, ');
    SQL.Add('Sum(PTP.Qty * PT.Cost)  as `Line Cost (Ex)`,');
    SQL.Add('S.SaleID as TransactionNo,');
    SQL.Add('PTP.ProductId as ProductId,');
    SQL.Add('S.EmployeeName as EmployeeName,');
    SQL.Add('Sum(PTP.Qty * P.Attrib1Sale) as Attrib1Sale,');
    SQL.Add('Sum(PTP.Qty * P.Attrib2Sale) as Attrib2Sale,');
    SQL.Add('P.Attrib1SaleRate as Attrib1SaleRate,');
    SQL.Add('P.PARTSDESCRIPTION as ProductDescription,');
    SQL.Add('"F" as IsSpecial,');
    SQL.Add('2 as Details ,');
    SQL.Add('PTP.ProcTreePartId as SaleLineID, ');
    SQL.add('CT.TypeName as TypeName,');
    SQL.Add('S.Converted as Converted,');
    SQL.Add(' C.Email , ');
    SQL.Add(' C.Street , ');
    SQL.Add(' C.Street2 , ');
    SQL.Add(' C.Suburb , ');
    SQL.Add(' C.State , ');
    SQL.Add(' C.Postcode,');
    SQL.Add(' C.Country,');
  SQL.Add(' C.FirstName,');
  SQL.Add(' C.LastName,');
    SQL.Add('P.CommodityCode,');
    SQL.Add('P.NetWeightKg,');
    SQL.Add('P.ProductUOM,');
    SQL.Add('CTRY.Country as CountryOfOrigin,');
    SQL.Add('P.Ex_Works as ExWorks,');
    SQL.Add('C.CUSTFLD1 as CustomerCUSTFLD1,');
    SQL.Add('C.CUSTFLD2 as CustomerCUSTFLD2,');
    SQL.Add('C.CUSTFLD3 as CustomerCUSTFLD3,');
    SQL.Add('C.CUSTFLD4 as CustomerCUSTFLD4,');
    SQL.Add('C.CUSTFLD5 as CustomerCUSTFLD5,');
    SQL.Add('C.CUSTFLD6 as CustomerCUSTFLD6,');
    SQL.Add('C.CUSTFLD7 as CustomerCUSTFLD7,');
    SQL.Add('C.CUSTFLD8 as CustomerCUSTFLD8,');
    SQL.Add('C.CUSTFLD9 as CustomerCUSTFLD9,');
    SQL.Add('C.CUSTFLD10 as CustomerCUSTFLD10,');
    SQL.Add('C.CUSTFLD11 as CustomerCUSTFLD11,');
    SQL.Add('C.CUSTFLD12 as CustomerCUSTFLD12,');
    SQL.Add('C.CUSTFLD13 as CustomerCUSTFLD13,');
    SQL.Add('C.CUSTFLD14 as CustomerCUSTFLD14,');
    SQL.Add('C.CUSTFLD15 as CustomerCUSTFLD15,');
    SQL.Add('C.CUSTDATE1 as CustomerCUSTDATE1,');
    SQL.Add('C.CUSTDATE2 as CustomerCUSTDATE2,');
    SQL.Add('C.CUSTDATE3 as CustomerCUSTDATE3,');
    SQL.Add('SL.FormulaQtyShippedValue1 as FormulaQtyShippedValue1,');
    SQL.Add('SL.FormulaQtyShippedValue2 as FormulaQtyShippedValue2,');
    SQL.Add('SL.FormulaQtyShippedValue3 as FormulaQtyShippedValue3,');
    SQL.Add('SL.FormulaQtyShippedValue4 as FormulaQtyShippedValue4,');
    SQL.Add('SL.FormulaQtyShippedValue5 as FormulaQtyShippedValue5,');
    SQL.Add('SL.FormulaQtyShippedValue as FormulaQtyShippedValue,');
    SQL.Add('F.formulaNAme as PartCalcformula,');
    SQL.Add('F.formula as formula,');
    SQL.Add('DescribeFormula(F.Formula) as formulaDetails');


    SQL.Add('FROM ');
    SQL.Add('tblsales AS S');
    SQL.Add('Inner Join tblsaleslines AS SL ON S.SaleID = SL.SaleID');
    SQL.Add('Left join (tblfesaleslines FE inner join tblfeformula F on FE.FormulaId = F.formulaID) on FE.salelineId = SL.saleLineId');
    SQL.Add('Inner Join tblproctreepart AS PTP ON SL.SaleID = PTP.SaleId AND SL.SaleLineID = PTP.SaleLineId');
    SQL.Add('Inner Join tblproctree AS PT ON PTP.ProcTreeId = PT.ProcTreeId AND PT.ParentId <> 0');
    SQL.Add('Inner Join tblparts AS P ON PTP.ProductId = P.PARTSID');
    SQL.Add(' Left JOIN tblcountries as CTRY on CTRY.CountryId = P.CountryofOriginID');
    SQL.Add('LEFT  Join tblpqa AS PQA ON PTP.SaleId = PQA.TransID AND PTP.ProcTreePartId = PQA.TransLineID AND PQA.TransType in(' + ManufactureTypes +')');
    SQL.Add('LEFT Join tblpqatranstypes AS TT ON PQA.TransType = TT.Transtype');
    SQL.Add('INNER JOIN tblclients C ON C.ClientID=S.ClientID');
    SQL.Add('LEFT JOIN tblClientType CT ON C.ClientTypeID=CT.ClientTypeID ');
//    SQL.Add(' Where S.SaleDate Between   :FromDate  AND   :ToDate');
    SQL.Add('Where S.SaleDate Between ' + QuotedStr(FormatDateTime('yyyy-mm-dd',DateFrom)) + ' and '  + QuotedStr(FormatDateTime('yyyy-mm-dd',DateTo)));
    if fProductID <> 0 then begin
      SQL.Add(' and PTP.ProductID = ' +IntToStr(fProductID));
    end else if firstcolumn <> '' then  begin
      SQL.Add(' and '+ProductQtyLib.firstcolumn('SL')   + ' = ' +Quotedstr(Firstcolumn));
    end else if Secondcolumn <> '' then  begin
      SQL.Add(' and '+ProductQtyLib.secondcolumn('SL')   + ' = ' +Quotedstr(Secondcolumn));
    end else if Thirdcolumn <> '' then  begin
      SQL.Add(' and '+ProductQtyLib.thirdcolumn('SL')   + ' = ' +Quotedstr(Thirdcolumn));
    end;
    SQL.Add('GROUP BY PTP.ProductID, PTP.UnitOfMeasure, S.SaleID');
  end;

end;

initialization
  RegisterClass(TProductSalesDetailsReport);

end.
