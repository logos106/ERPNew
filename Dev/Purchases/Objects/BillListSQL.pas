unit BillListSQL;



interface

uses
   classes, ReportBaseObj;

Type

   TBillList = class(TReportWithDateRangeBase)

   Private

   Protected

   Public
      constructor Create; Override;

      function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;

   Published
      // property ByCustomer             : Boolean   Write fbByCustomer  ;

   end;



implementation

uses sysutils, ProductQtyLib, CommonLib;

constructor TBillList.Create;
begin
   inherited;
   DateFrom := MinDateTime;
   DateTo := MaxDateTime;
end;


function TBillList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
  function ReplaceAlias(AClause: string): string;
    var
      STemp: string;
    begin
      STemp := AClause;
      STemp := ReplaceStr(STemp, 'true', '"T"');
      STemp := ReplaceStr(STemp, 'false', '"F"');
      Result := STemp;
    end;
begin

   SQL.Clear;
   result := inherited;

   SQL.Add('SELECT O.*, L.* FROM tblPurchaseOrders O');
   SQL.Add('LEFT JOIN tblPurchaseLines L ON O.PurchaseOrderID=L.PurchaseOrderID');
   SQL.Add('WHERE O.OrderDate BETWEEN ' + DateFromSQL + ' AND ' + DateToSQL);

   if not (Search = '') then
      SQL.Add('AND O.' + ReplaceAlias(Search));

   if not (OrderBy = '') then
      SQL.Add('ORDER BY ' + OrderBy);


end;



initialization

   RegisterClass(TBillList);

end.

