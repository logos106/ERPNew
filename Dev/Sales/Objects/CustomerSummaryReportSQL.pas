unit CustomerSummaryReportSQL;

interface

uses
  ReportBaseObj, classes;

type

  TCustomerSummaryReport = class(TReportWithDateRangeBase)
  Private
    fbUseShipDate: Boolean;
    fbShowAllcustomers: Boolean;
    fsCustomerName: String;
    fiClientId: Integer;
    fiSummaryDetailIdx: Integer;
  Protected
  Public
    constructor Create; override;
    destructor Destroy; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  Published
    Property UseShipDate      :Boolean read fbUseShipDate       write fbUseShipDate;
    Property ShowAllcustomers :Boolean read fbShowAllcustomers  write fbShowAllcustomers;
    Property ClientId         :Integer read fiClientId          write fiClientId;
    Property CustomerName     :String  read fsCustomerName      write fsCustomerName;
    Property SummaryDetailIdx :Integer read fiSummaryDetailIdx  write fiSummaryDetailIdx;
  end;


implementation

uses ProductQtyLib, CommonLib, dateutils, sysutils;

{  TCustomerSummaryReport }

constructor  TCustomerSummaryReport.Create;
begin
  inherited;
  if APIMode then begin
    DateTo := EndOfAMonth(YearOf(Date), MonthOf(Date));
    DateFrom := Trunc(IncDay(IncYear(DateTo, -1), 1));
  end;
  UseShipDate      := True;
  ShowAllcustomers := True;
  ClientId         := 0;
  CustomerName     := '';
  SummaryDetailIdx := -1;
end;

destructor  TCustomerSummaryReport.Destroy;
begin
  inherited;
end;

function  TCustomerSummaryReport.PopulateReportSQL(SQL: TStrings; var msg: string): Boolean;
  Function UseShipDateStr     :String; begin if not(APIMode) then Result := ':UseShipDate'      else if UseShipDate       then Result := QuotedStr('T') else Result := QuotedStr('F'); end;
  Function ShowAllcustomersStr:String; begin if not(APIMode) then Result := ':ShowAllcustomers' else if ShowAllcustomers  then Result := QuotedStr('T') else Result := QuotedStr('F'); end;
begin
  Result := inherited;

  SQL.Clear;
  SQL.Add('SELECT TRIM(CL.Company)'                           + ' AS Company, ');
  SQL.Add('Space(50)'                                         + ' AS Type, ');
  SQL.Add('STR_TO_DATE(NULL, "%Y-%m-%d")'                     + ' AS SaleDate, ');
  SQL.Add('STR_TO_DATE(NULL, "%Y-%m-%d")'                     + ' AS DueDate, ');
  SQL.Add('Max(S.SaleDate)'                                   + ' AS LastSaleDate, ');
  SQL.Add('TRIM(CL.Company)'                                  + ' AS Name, ');
  SQL.Add('CT.TypeName'                                       + ' AS ClientType, ');
  SQL.Add('Space(50)'                                         + ' AS "Invoice Number", ');
  SQL.Add('SUM(SL.TotalLineAmount)'                           + ' AS "Total Amount (Ex)", ');
  SQL.Add('SUM(SL.TotalLineAmountInc)'                        + ' AS "Total Amount (Inc)", ');
  SQL.Add('SUM((SL.LinePriceInc - SL.LineCostInc) * Shipped)' + ' AS "Gross Profit", ');
  SQL.Add('SUM((SL.LinePrice - SL.LineCost) * Shipped)'       + ' AS "Gross Profit(Ex)", ');
  SQL.Add('SUM(SL.LineCost * Shipped)'                        + ' AS "Total Cost", ');
  SQL.Add('CL.Street'                                         + ' AS Address, ');
  SQL.Add('CL.Street2'                                        + ' AS "Address 2", ');
  SQL.Add('CL.Street3'                                        + ' AS "Address 3", ');
  SQL.Add('CL.Suburb'                                         + ' AS Suburb, ');
  SQL.Add('CL.Postcode'                                       + ' AS Postcode, ');
  SQL.Add('CL.State'                                          + ' AS State, ');
  SQL.Add('CL.Country'                                        + ' AS Country, ');
  SQL.Add('CL.Phone'                                          + ' AS Phone, ');
  SQL.Add('CL.EMAIL'                                          + ' AS EMAIL, ');
  SQL.Add('CL.FaxNumber'                                      + ' AS FaxNumber, ');
  SQL.Add('E.EmployeeName'                                    + ' AS REP, ');
  SQL.Add('0'                                                 + ' AS SaleID, ');
  SQL.Add('S.ClientID'                                        + ' AS ClientID, ');
  SQL.Add('0'                                                 + ' AS Details ');
  SQL.Add('FROM tblClients'                                   + ' AS CL ');
  SQL.Add('LEFT JOIN tblclienttype CT ON CL.ClientTypeID = CT.ClientTypeID ');
  SQL.Add('LEFT JOIN tblSales S ON S.ClientID = CL.ClientID AND (S.IsPOS = "T" OR S.IsRefund = "T" OR S.IsCashSale = "T" OR S.IsInvoice = "T") ' +
                                  ' AND S.IsLayby <> "T" AND S.Deleted = "F" AND S.IsSalesOrder = "F" AND S.IsQuote = "F" ' +
                                  ' AND ((' + UseShipDateStr + ' = "F"' +
                                  ' AND S.SaleDate BETWEEN ' + DateFromSQL + ' AND ' + DateToSQL + ' ) OR ' +
                                  ' (' + UseShipDateStr + ' = "T" AND S.ShipDate BETWEEN ' + DateFromSQL +' AND ' + DateToSQL + ' )) ');
  SQL.Add('LEFT JOIN tblSalesLines SL ON S.SaleId = SL.SaleID AND SL.Invoiced="T" ');
  SQL.Add('LEFT JOIN tblemployees AS E ON CL.RepID = E.EmployeeID ');
  SQL.Add('WHERE CL.Customer = "T" ');
  if ClientId <> 0 then SQL.Add('AND CL.ClientId = ' + IntToStr(ClientID));
  if CustomerName <> '' then SQL.Add('AND CL.Company = ' + QuotedStr(CustomerName));
  SQL.Add('AND (' + ShowAllcustomersStr + ' = "T" OR IFNULL(S.SaleID, 0) <> 0) ');
  SQL.Add('GROUP BY CL.ClientID ');

  //if (SummaryDetailIdx = 1) or (not(APIMode)) then begin
  if SummaryDetailIdx = 1 then begin
    SQL.Add('UNION ALL ');
    SQL.Add('SELECT SPACE(30)'                                  + ' AS Company, ');
    SQL.Add(SaleType                                            + ' AS Type, ');
    SQL.Add('STR_TO_DATE(NULL, "%Y-%m-%d")'                     + ' AS SaleDate, ');
    SQL.Add('STR_TO_DATE(NULL, "%Y-%m-%d")'                     + ' AS DueDate, ');
    SQL.Add('NULL'                                              + ' AS LastSaleDate, ');
    SQL.Add('TRIM(CL.Company)'                                  + ' AS Name, ');
    SQL.Add('CT.TypeName'                                       + ' AS ClientType, ');
    SQL.Add('Space(50)'                                         + ' AS "Invoice Number", ');
    SQL.Add('Sum(SL.TotalLineAmount)'                           + ' AS "Total Amount (Ex)", ');
    SQL.Add('Sum(SL.TotalLineAmountInc)'                        + ' AS "Total Amount (Inc)", ');
    SQL.Add('Sum((SL.LinePriceInc - SL.LineCostInc) * Shipped)' + ' AS "Gross Profit", ');
    SQL.Add('Sum((SL.LinePrice - SL.LineCost) * Shipped)'       + ' AS "Gross Profit(Ex)", ');
    SQL.Add('Sum(SL.LineCost * Shipped)'                        + ' AS "Total Cost", ');
    SQL.Add('""'                                                + ' AS Address, ');
    SQL.Add('""'                                                + ' AS "Address 2", ');
    SQL.Add('""'                                                + ' AS "Address 3", ');
    SQL.Add('""'                                                + ' AS Suburb, ');
    SQL.Add('""'                                                + ' AS Postcode, ');
    SQL.Add('""'                                                + ' AS State, ');
    SQL.Add('""'                                                + ' AS Country, ');
    SQL.Add('""'                                                + ' AS Phone, ');
    SQL.Add('""'                                                + ' AS EMail, ');
    SQL.Add('""'                                                + ' AS FaxNumber, ');
    SQL.Add('""'                                                + ' AS REP, ');
    SQL.Add('0'                                                 + ' AS SaleID, ');
    SQL.Add('S.ClientID'                                        + ' AS ClientID, ');
    SQL.Add('1'                                                 + ' AS Details ');
    SQL.Add('FROM tblSales S ');
    SQL.Add('INNER JOIN tblSalesLines SL USING(SaleID) ');
    SQL.Add('LEFT JOIN tblclients CL ON S.ClientID = CL.ClientID ');
    SQL.Add('LEFT JOIN tblclienttype CT ON CL.ClientTypeID = CT.ClientTypeID ');
    SQL.Add('WHERE CL.Customer = "T" ');
    if ClientId <> 0 then SQL.Add('AND CL.ClientId = ' + IntToStr(ClientID));
    if CustomerName <> '' then SQL.Add('AND CL.Company = ' + QuotedStr(CustomerName));
    SQL.Add('AND (S.IsPOS = "T" OR S.IsRefund = "T" OR S.IsCashSale="T" OR S.IsInvoice = "T") ');
    SQL.Add('AND SL.Invoiced = "T" AND S.IsLayby <> "T" AND S.Deleted = "F" ');
    SQL.Add('AND S.IsSalesOrder = "F" AND S.IsQuote = "F" ');
    SQL.Add('AND ((' + UseShipDateStr + ' = "F" AND ' +
                ' S.SaleDate BETWEEN ' + DateFromSQL + ' AND ' + DateToSQL + ' ) OR ' +
                ' (' + UseShipDateStr + ' = "T" AND S.ShipDate BETWEEN ' + DateFromSQL + ' AND ' + DateToSQL + ' )) ');
    SQL.Add('GROUP BY S.ClientID, S.IsCashSale, S.IsPOS, S.IsInvoice ');
  end;

//  if (SummaryDetailIdx = 2) or (not APIMode) then begin
  if SummaryDetailIdx = 2 then begin
    SQL.Add('UNION ALL ');
    SQL.Add('SELECT SPACE(30)'                                  + ' AS Company, ');
    SQL.Add(SaleType + ''                                       + ' AS Type, ');
    SQL.Add('SaleDate'                                          + ' AS SaleDate, ');
    SQL.Add('DueDate'                                           + ' AS DueDate, ');
    SQL.Add('NULL'                                              + ' AS LastSaleDate, ');
    SQL.Add('TRIM(CL.Company)'                                  + ' AS Name, ');
    SQL.Add('CT.TypeName'                                       + ' AS ClientType, ');
    SQL.Add('InvoiceDocNumber'                                  + ' AS "Invoice Number", ');
    SQL.Add('SUM(SL.TotalLineAmount)'                           + ' AS "Total Amount (Ex)", ');
    SQL.Add('SUM(SL.TotalLineAmountInc)'                        + ' AS "Total Amount (Inc)", ');
    SQL.Add('SUM((SL.LinePriceInc - SL.LineCostInc) * Shipped)' + ' AS "Gross Profit", ');
    SQL.Add('SUM((SL.LinePrice- SL.LineCost) * Shipped)'        + ' AS "Gross Profit(Ex)", ');
    SQL.Add('SUM(SL.LineCost * Shipped)'                        + ' AS "Total Cost", ');
    SQL.Add('SPACE(30)'                                         + ' AS Address, ');
    SQL.Add('SPACE(30)'                                         + ' AS "Address 2", ');
    SQL.Add('SPACE(30)'                                         + ' AS "Address 3", ');
    SQL.Add('SPACE(30)'                                         + ' AS Suburb, ');
    SQL.Add('SPACE(30)'                                         + ' AS Postcode, ');
    SQL.Add('SPACE(30)'                                         + ' AS State, ');
    SQL.Add('SPACE(30)'                                         + ' AS Country, ');
    SQL.Add('SPACE(30)'                                         + ' AS Phone, ');
    SQL.Add('SPACE(40)'                                         + ' AS Email, ');
    SQL.Add('SPACE(30)'                                         + ' AS FaxNumber, ');
    SQL.Add('SPACE(30)'                                         + ' AS REP, ');
    SQL.Add('S.SaleID'                                          + ' AS SaleID, ');
    SQL.Add('S.ClientID'                                        + ' AS ClientID, ');
    SQL.Add('2'                                                 + ' AS Details ');
    SQL.Add('FROM tblSales S ');
    SQL.Add('INNER JOIN tblSalesLines SL USING(SaleID) ');
    SQL.Add('LEFT JOIN tblclients CL ON S.ClientID = CL.ClientID ');
    SQL.Add('LEFT JOIN tblclienttype CT ON CL.ClientTypeID = CT.ClientTypeID ');
    SQL.Add('WHERE CL.Customer = "T" ');
    if ClientId <> 0 then SQL.Add('AND CL.ClientId = ' + IntToStr(ClientID));
    if CustomerName <> '' then SQL.Add('AND CL.company = ' + QuotedStr(CustomerName));

    SQL.Add('AND (S.IsPOS = "T" OR S.IsRefund = "T" OR S.IsCashSale = "T" OR S.IsInvoice = "T") ');
    SQL.Add('AND SL.Invoiced = "T" AND S.IsLayby <> "T" AND S.Deleted = "F" ');
    SQL.Add('AND S.IsSalesOrder = "F" AND S.IsQuote = "F" ');

    SQL.Add('AND (S.IsPOS = "T" OR S.IsRefund = "T" OR S.IsCashSale = "T" OR S.IsInvoice = "T") ');
    SQL.Add('AND SL.Invoiced = "T" AND S.IsLayby <> "T" AND S.Deleted = "F" ');
    SQL.Add('AND S.IsSalesOrder = "F" AND S.IsQuote = "F" ');
    SQL.Add('AND ((' + UseShipDateStr + ' = "F" ' +
            'AND S.SaleDate BETWEEN ' + DateFromSQL + ' AND ' + DateToSQL + ' ) OR ' +
            '(' + UseShipDateStr + ' = "T" AND S.ShipDate BETWEEN ' + DateFromSQL + ' AND ' + DateToSQL + ' )) ');
    SQL.Add('GROUP BY S.ClientID, S.SaleID ');
  end;

  SQL.Add('ORDER BY Name, ClientID, Details, Type ');

end;

initialization
  RegisterClass( TCustomerSummaryReport);

end.
