unit SalesOrdersSQL;



interface

uses
   classes, ReportBaseObj;

Type

   TSalesOrderList = class(TReportWithDateRangeBase)

   Private

   Protected

   Public
      constructor Create; Override;

      function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;

   Published
      // property ByCustomer             : Boolean   Write fbByCustomer  ;

   end;



implementation

uses sysutils, ProductQtyLib, StringUtils;


constructor TSalesOrderList.Create;
begin
   inherited;
   DateFrom := MinDateTime;
   DateTo := MaxDateTime;
end;


function TSalesOrderList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
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

   SQL.Add('SELECT * FROM tblsales WHERE IsSalesOrder="T"');
   SQL.Add(' AND tblsales.SaleDate BETWEEN ' + DateFromSQL + ' AND ' + DateToSQL);

   if not (Search = '') then
      SQL.Add('AND ' + ReplaceAlias(Search));

   if not (OrderBy = '') then
      SQL.Add('ORDER BY ' + OrderBy);

end;



initialization

   RegisterClass(TSalesOrderList);

end.
