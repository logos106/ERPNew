unit DeptClassListSQL;

interface

uses
  classes, ReportBaseObj;

Type
  TDeptClassList = class(TReportWithDateRangeBase)
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

constructor TDeptClassList.Create;
begin
   inherited;

   DateFrom := MinDateTime;
   DateTo := MaxDateTime;
end;

function TDeptClassList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
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
  SQL.Add('ClassID, ');
  SQL.Add('ClassName, ClassGroup, Description, Active, SubClass, SubClassOf, ');
  SQL.Add('ClassPercent, Level1, Level2, Level3, Level4, AutoCreateSmartOrders, AutoCreateRepairs, ');
  SQL.Add('UseAddress, Street, Street2, Street3, Suburb, State, Postcode, Country, ');
  SQL.Add('TaxID, Taxname, LocationCode');
  SQL.Add('FROM tblclass');

  if not (Search = '') then
    SQL.Add('WHERE ' + ReplaceAlias(Search));

  if not (OrderBy = '') then
    SQL.Add('ORDER BY ' + OrderBy)

end;

initialization

   RegisterClass(TDeptClassList);

end.
