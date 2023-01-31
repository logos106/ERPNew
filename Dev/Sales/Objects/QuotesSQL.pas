unit QuotesSQL;



interface

uses
   classes, ReportBaseObj;

Type

   TQuoteList = class(TReportWithDateRangeBase)

   Private

   Protected

   Public
      constructor Create; Override;

      function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;

   Published
      // property ByCustomer             : Boolean   Write fbByCustomer  ;

   end;



implementation

uses sysutils, ProductQtyLib;


constructor TQuoteList.Create;
begin
   inherited;
   DateFrom := MinDateTime;
   DateTo := MaxDateTime;
end;


function TQuoteList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
begin

   SQL.Clear;
   result := inherited;

   SQL.Add('SELECT * FROM tblsales where IsQuote = "T"');

   SQL.Add(' AND tblsales.SaleDate BETWEEN ' + DateFromSQL + ' AND ' + DateToSQL);

   if not (Search = '') then
      SQL.Add('AND ' + Search);

   if not (OrderBy = '') then
      SQL.Add('ORDER BY ' + OrderBy);


end;



initialization

   RegisterClass(TQuoteList);

end.
