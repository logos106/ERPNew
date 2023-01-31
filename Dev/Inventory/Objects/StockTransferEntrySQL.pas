unit StockTransferEntrySQL;

interface

uses
  classes, ReportBaseObj;

Type
  TStockTransferEntryList = class(TReportWithDateRangeBase)
  Private

  Protected

  Public
    constructor Create; Override;

    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  Published

  end;

implementation

uses sysutils, ProductQtyLib, StringUtils;


constructor TStockTransferEntryList.Create;
begin
   inherited;
   DateFrom := MinDateTime;
   DateTo := MaxDateTime;
end;


function TStockTransferEntryList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
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

   SQL.Add('SELECT * FROM tblstocktransferentry WHERE Deleted="F"');
   SQL.Add(' AND DateTransferred BETWEEN ' + DateFromSQL + ' AND ' + DateToSQL);

   if not (Search = '') then
      SQL.Add('AND ' + ReplaceAlias(Search));

   if not (OrderBy = '') then
      SQL.Add('ORDER BY ' + OrderBy);

end;

initialization

   RegisterClass(TStockTransferEntryList);

end.
