unit RefundSalesSQL;



interface

uses
   classes, ReportBaseObj;

Type

   TRefundSaleList = class(TReportWithDateRangeBase)

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


constructor TRefundSaleList.Create;
begin
   inherited;
   DateFrom := MinDateTime;
   DateTo := MaxDateTime;
end;


function TRefundSaleList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
begin

   SQL.Clear;
   result := inherited;

   SQL.Add('SELECT * FROM tblsales where IsRefund = "T"');

   SQL.Add(' AND tblsales.SaleDate BETWEEN ' + DateFromSQL + ' AND ' + DateToSQL);

   if not (OrderBy = '') then
      SQL.Add('ORDER BY ' + OrderBy);


end;



initialization

   RegisterClass(TRefundSaleList);

end.
