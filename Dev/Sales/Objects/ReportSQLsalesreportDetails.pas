unit ReportSQLsalesreportDetails;

interface

uses ReportSQLBase,classes;

type
    TReportSQLsalesreportDetails = Class(TReportSQLBase)
      Private
        fbISOnlyPOS :Boolean;
      Protected
        function GetTemplateSQL: String;Override;
        function GetReportTypeID: integer;override;
      Public
        constructor Create(Aowner:TComponent);override;
        Destructor Destroy;override;
        Property ISOnlyPOS :boolean read fbISOnlyPOS write fbISOnlyPOS;
    End;

implementation

uses SystemLib, BusObjectListObj, sysutils, MySQLConst;

{ TReportSQLsalesreportDetails }

constructor TReportSQLsalesreportDetails.Create(Aowner: TComponent);
begin
  inherited;
  usingReportTables:= False;
  ReportonForeignCurrency:= False;
  BaseTemptablename := '';
  TempTablename := '';
  ReportClassName := 'TsalesreportDetailsGUI';
  ReportSQLSupplied:= TRue;
end;

destructor TReportSQLsalesreportDetails.Destroy;
begin

  inherited;
end;

function TReportSQLsalesreportDetails.GetReportTypeID: integer;
begin
  REsult:= 124;
end;

function TReportSQLsalesreportDetails.getTemplateSQL: String;
begin
result := '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode,  '+
          ' CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO '+
          ' ~|||~{details} Select '+
          ' convert(' + quotedstr(FormatDateTime(MysqlDateFormat,DateFrom )) +' , Date) as datefrom, convert(' + quotedstr(FormatDateTime(MysqlDateFormat, Dateto)) +',date) as dateto, '+
          '  s.SAleId           as SaleID, '+
          '  if(s.IsPOS = "T", "POS", if(s.IsCashSale = "T" ,  "Cash Sale", if(s.IsInvoice = "T" , "Invoice" ,"")))  as "SaleType", '+
          '  Sl.SaleLineID      as SaleLineID, '+
          '  s.InvoiceDocNumber   as DocNumber, '+
          '  s.CustomerName       as CustomerName, '+
          '  s.Class            as Department, '+
          '  sl.ProductName     as ProductName, '+
          '  sl.Product_Description  as Product_Description, '+
          '  sl.Shipped         as Shipped, '+
          '  sl.TotalLineAmountInc as TotalLineAmountInc, '+
          '  SL.TotalLineAmount as TotalLineAmount, '+
          '  s.totalAmountinc as TotalAmountinc, '+
          '  S.TotalAmount as TotalAmount, '+
          '  s.SaleDateTime Saledate '+
          '  FROM tblSales s '+
          '  INNER JOIN tblSalesLines sl USING(SaleId) '+
          '  WHERE S.Cancelled = "F" and S.Deleted ="F" '+
          '  AND ((' +  QuotedStr(BooleantoStr(ISOnlyPOS)) +   ' ="T" and  s.IsPos = "T") '+
          '  or ((' +  QuotedStr(BooleantoStr(ISOnlyPOS)) +   ' ="F" and (s.IsPos = "T" OR s.IsCashSAle = "T" OR s.IsInvoice = "T")))) '+
          '  AND s.SaleDateTime >= ' +  QuotedStr(FormatDateTime(MysqlDateFormat,Datefrom)) +   ''+
          '  AND s.SaleDateTime < ' +  QuotedStr(FormatDateTime(MysqlDateFormat,Dateto)) +   ' '+
          '  ORDER BY s.SaleDateTime, SAleID, Productname';

end;

initialization
  BusObjectListObj.TScheduledReportObjInfoList.Inst.Add('Sales Report(Details)','TReportSQLsalesreportDetails','TsalesreportDetailsGUI');
  Classes.RegisterClass(TReportSQLsalesreportDetails);

end.

