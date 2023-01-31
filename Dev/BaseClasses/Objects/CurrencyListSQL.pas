unit CurrencyListSQL;

interface

uses
  classes, ReportBaseObj;

Type
  TCurrencyList = class(TReportWithDateRangeBase)
  Private

  Protected

  Public
    constructor Create; Override;

    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;

  Published

  end;

implementation

uses sysutils, StringUtils, CommonDbLib, ERPdbComponents, MySQLConst,
  LogLib, CommonLib;

constructor TCurrencyList.Create;
begin
   inherited;

   DateFrom := MinDateTime;
   DateTo := MaxDateTime;
end;

function TCurrencyList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
var
  ScriptMain: TERPScript;

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
  Result := inherited;

  SQL.Clear;
  SQL.Add('SELECT');
  SQL.Add('CurrencyID, ');
  SQL.Add('Country, ');
  SQL.Add('Currency, ');
  SQL.Add('Code, ');
  SQL.Add('BuyRate, ');
  SQL.Add('SellRate, ');
  SQL.Add('RateLastModified, ');
  SQL.Add('Active, ');
  SQL.Add('FixedRate, ');
  SQL.Add('UpperVariation, ');
  SQL.Add('LowerVariation, ');
  SQL.Add('TriggerPriceVariation, ');
  SQL.Add('CurrencySymbol, ');
  SQL.Add('CountryID ');
  SQL.Add('FROM tblcurrencyconversion');

  if not (Search = '') then
    SQL.Add('WHERE ' + ReplaceAlias(Search));

  if not (OrderBy = '') then
    SQL.Add('ORDER BY ' + OrderBy)

end;

initialization

   RegisterClass(TCurrencyList);

end.
