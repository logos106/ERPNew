unit UnitOfMeasureListSQL;

interface

uses
  classes, ReportBaseObj;

Type
  TUnitOfMeasureList = class(TReportWithDateRangeBase)
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

constructor TUnitOfMeasureList.Create;
begin
   inherited;

   DateFrom := MinDateTime;
   DateTo := MaxDateTime;
end;

function TUnitOfMeasureList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
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
  SQL.Add('UnitID, ');
  SQL.Add('UnitName, ');
  SQL.Add('UnitDescription, ');
  SQL.Add('Multiplier, ');
  SQL.Add('BaseUnitName, ');
  SQL.Add('BaseUnitID, ');
  SQL.Add('Active, ');
  SQL.Add('PartID, ');
  SQL.Add('SalesDefault, ');
  SQL.Add('PurchasesDefault, ');
  SQL.Add('Height, ');
  SQL.Add('Width, ');
  SQL.Add('Length, ');
  SQL.Add('Weight, ');
  SQL.Add('Volume, ');
  SQL.Add('NoOfBoxes, ');
  SQL.Add('UnitProductKeyName, ');
  SQL.Add('UseforAutoSplitQtyinSales ');
  SQL.Add('FROM tblunitsofmeasure');

  if not (Search = '') then
    SQL.Add('WHERE ' + ReplaceAlias(Search));

  if not (OrderBy = '') then
    SQL.Add('ORDER BY ' + OrderBy)

end;

initialization

   RegisterClass(TUnitOfMeasureList);

end.
