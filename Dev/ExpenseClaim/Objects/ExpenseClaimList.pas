unit ExpenseClaimList;

interface

uses
  ReportBaseObj, classes;

type
   TExpenseClaimList = class(TReportWithDateRangeBase)
  Private
  Protected
  Public
    constructor Create; override;
    destructor Destroy; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  Published

  end;


implementation

uses ProductQtyLib, CommonLib, dateutils, sysutils;

{  TExpenseClaimList }

constructor  TExpenseClaimList.Create;
begin
  inherited;
  if apimode then begin
    DateTo := EndOfAMonth(YearOf(Date),MonthOf(Date));
    DateFrom := Trunc(IncDay(IncYear(DateTo,-1),1));
  end;

end;

destructor  TExpenseClaimList.Destroy;
begin
  inherited;
end;

function TExpenseClaimList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
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

   SQL.Add('SELECT * FROM tblexpenseclaim'); // WHERE Deleted="F"');
   SQL.Add('WHERE `DateTime` BETWEEN ' + DateFromSQL + ' AND ' + DateToSQL);

   if not (Search = '') then
      SQL.Add('AND ' + ReplaceAlias(Search));

   if not (OrderBy = '') then
      SQL.Add('ORDER BY ' + OrderBy);

end;

initialization
  RegisterClass(TExpenseClaimList);

end.
