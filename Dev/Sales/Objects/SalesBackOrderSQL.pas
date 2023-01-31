unit SalesBackOrderSQL;

interface
uses
  classes, ReportBaseObj, Types;

type

  TSalesBackOrderReport = class(TReportWithDateRangeBase)
  private
    fsExtraFilter: String;
    fiCustomerId: Integer;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  published
    Property ExtraFilter :String read fsExtraFilter write fsExtraFilter;
    Property CustomerId :Integer read fiCustomerId write fiCustomerId;
  end;

implementation
uses
  SysUtils, ProductQtyLib;

{ TSalesBackOrderReport }

constructor TSalesBackOrderReport.Create;
begin
  inherited;
  DateTo :=  MaxDateTime;
  DateFrom := 0;
  fsExtraFilter := '';
  CustomerId := 0;
end;

destructor TSalesBackOrderReport.Destroy;
begin

  inherited;
end;


function TSalesBackOrderReport.PopulateReportSQL(SQL: TStrings;
  var msg: string): boolean;
begin
  result := true;
  msg := '';
  SQL.Clear;
    SQL.add('SELECT');
    SQL.add('S.SaleID as SaleID,');
    SQL.add('S.ShipDate as ShipDate,');
    SQL.add('C.ClientID as ClientID,');
    SQL.add('S.IsCashSale as IsCashSale,');
    SQL.add('S.IsRefund as IsRefund,');
    SQL.add('S.ISSalesOrder as ISSalesOrder,');
    SQL.add('S.IsQuote as IsQuote,');
    SQL.add('S.IsCashSale as IsCashSale,');
    SQL.add('S.Islayby as Islayby,');
    SQL.add('S.IsInvoice as IsInvoice,');
    SQL.add('S.IsCustomerReturn as IsCustomerReturn,');
    SQL.add('S.IsVoucher as IsVoucher,');
    SQL.add('E.EmployeeID as EmployeeID,');
    SQL.add('SL.ProductID as ProductID,');
    SQL.add('S.SaleDate as SaleDate,');
    SQL.add(SaleType('S')+' as SaleType,');
    SQL.add(Firstcolumn('P') + ' AS FirstColumn, ');
    SQL.add(Secondcolumn('P') + ' AS Secondcolumn,');
    SQL.add(Thirdcolumn('P') + ' AS Thirdcolumn,');
    SQL.add('CONCAT_WS(" ", If(InStr(C.Company,"^") -1 >0,Left(C.Company,InStr(C.Company,"^")-1),C.Company),IF(char_length(C.JobName)>0, Concat("(",C.JobName,")"),"")) as CustomerName,');
    SQL.add('TypeName as CustomerType,');
    SQL.add('S.GlobalRef as GlobalRef,');
    SQL.add('S.OriginalNo as OriginalNo,');
    SQL.add('S.DueDate as DueDate ,');
    SQL.add('S.InvoiceDocNumber as InvoiceDocNumber,');
    SQL.add('S.PONumber as PONumber,');
    SQL.add('SL.BackOrder as BackOrder,');
    SQL.add('SL.ProductName as ProductName,');
    SQL.add('SL.Product_Description as Product_Description,');
    SQL.add('SL.LinePrice as LinePrice,');
    SQL.add('SL.LinePriceInc as LinePriceInc,');
    SQL.add('SL.LineWholesalePrice as LineWholesalePrice,');
    SQL.add('SL.LineCost as LineCost,');
    SQL.add('SL.LineCostInc as LineCostInc,');
    SQL.add('SL.BackOrder*SL.LineCost as TotalLineCost,');
    SQL.add('SL.BackOrder*SL.LineCostInc as TotalLineCostinc,');
    SQL.add('SL.BackOrder*SL.LinePrice as TotalLinePrice,');
    SQL.add('SL.BackOrder*SL.LinePriceInc as TotalLinePriceInc,');
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
    SQL.add('SL.WarrantyEndsOn as WarrantyEndsOn,');
    SQL.add('SL.WarrantyPeriod as WarrantyPeriod,');
    SQL.add('SL.ShipDate as LineShipDate,');
    SQL.add('S.Employeename as Rep,');
    SQL.add('S.EnteredBy as EnteredBy,');
    SQL.add('S.PickUpFrom as PickUpFrom,');
    SQL.add('S.Deleted as Deleted,');
    SQL.add('SL.SaleLineID as SaleLineID,');
    SQL.add('S.Converted as Converted,');
    SQL.add('S.QuoteGlobalRef as ConvertFromQuote,');
    SQL.add('S.SalesOrderGlobalRef as ConvertFromSO,');
    SQL.add('C.CUSTFLD1 AS CUSTFLD1,');
    SQL.add('C.CUSTFLD2 AS CUSTFLD2,');
    SQL.add('C.CUSTFLD3 AS CUSTFLD3,');
    SQL.add('C.CUSTFLD4 AS CUSTFLD4,');
    SQL.add('C.CUSTFLD5 AS CUSTFLD5,');
    SQL.add('C.CUSTFLD6 AS CUSTFLD6,');
    SQL.add('C.CUSTFLD7 AS CUSTFLD7,');
    SQL.add('C.CUSTFLD8 AS CUSTFLD8,');
    SQL.add('C.CUSTFLD9 AS CUSTFLD9,');
    SQL.add('C.CUSTFLD10 AS CUSTFLD10,');
    SQL.add('C.CUSTFLD11 AS CUSTFLD11,');
    SQL.add('C.CUSTFLD12 AS CUSTFLD12,');
    SQL.add('C.CUSTFLD13 AS CUSTFLD13,');
    SQL.add('C.CUSTFLD14 AS CUSTFLD14,');
    SQL.add('C.CUSTFLD15 AS CUSTFLD15,');
    SQL.add('C.CUSTdate1 as CUSTdate1,');
    SQL.add('C.CUSTdate2 as CUSTdate2,');
    SQL.add('C.CUSTdate3 as CUSTdate3,');
    SQL.add('C.PrintName as PrintName,');
    SQL.add('S.Class as class,');
    SQL.add('SL.CreationDate as CreationDate,');
    SQL.add('P.PreferedSupp as PreferedSupplier ,');
    SQL.add('S.PickMemo ,');
    SQL.add('S.IsInvoice as IsInvoice,');
    SQL.add('S.IsSalesOrder as IsSalesOrder,');
    SQL.add('if(S.IsInvoice ="T", "I" , "S") as SalesCategory');
    SQL.add('FROM tblSales S');
    SQL.add('INNER JOIN tblSalesLines SL on S.SaleId = Sl.saleId');
    SQL.add('INNER JOIN tblParts P ON SL.ProductID=P.PARTSID');
    SQL.add('INNER JOIN tblClients C ON  (S.ClientID = C.ClientID)');
    SQL.add('Left JOIN tblclienttype CT on CT.ClientTypeID = C.ClientTypeID');
    SQL.add('inner JOIN tblEmployees E ON  S.EmployeeID = E.EmployeeID');
    SQL.add('WHERE S.Converted  ="F" and (S.IsInvoice="T" OR S.IsSalesOrder="T" ) AND S.IsRefund="F" AND S.IsCashSale="F"');
    if CustomerId <> 0 then SQL.add('AND   S.clientId =' + inttostr(CustomerId));
    SQL.add('AND   S.IsQuote="F" AND S.Deleted="F"');
    SQL.add('AND   S.SaleDate Between ' + QuotedStr(FormatDateTime('yyyy-mm-dd',DateFrom)) + ' AND ' +QuotedStr(FormatDateTime('yyyy-mm-dd',DateTo)));
    SQL.add('AND   SL.Invoiced = "F" AND SL.BackOrder <> 0');
    SQL.add('AND   ifnull(S.BOID , "") = ""');
    if ExtraFilter <> '' then SQL.add('AND   (' + ExtraFilter +')');
    //SQL.add('GROUP BY SL.SaleLineID order by SaleLineID desc');

   if not (Search = '') then
      SQL.Add('AND ' + Search);

   if not (OrderBy = '') then
      SQL.Add('ORDER BY ' + OrderBy);


end;



initialization

  //removing this object as  TInvoiceList does the same
  //RegisterClass(TSalesBackOrderReport);

end.
