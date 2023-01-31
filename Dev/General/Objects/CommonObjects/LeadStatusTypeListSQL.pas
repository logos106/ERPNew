unit LeadStatusTypeListSQL;

interface

uses
  classes, ReportBaseObj;

Type
  TLeadStatusTypeList = class(TReportWithDateRangeBase)
  Private

  Protected

  Public
    constructor Create; Override;

    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;

  Published

  end;

implementation

uses sysutils, ProductQtyLib, StringUtils, CommonDbLib, ERPdbComponents, MySQLConst,
  LogLib, CommonLib, PQALib;

constructor TLeadStatusTypeList.Create;
begin
   inherited;

   DateFrom := MinDateTime;
   DateTo := MaxDateTime;
end;

function TLeadStatusTypeList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
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
  SQL.Add('ID, ');
  SQL.Add('TypeCode, ');
  SQL.Add('Name, ');
  SQL.Add('Description, ');
  SQL.Add('IsDefault, ');
  SQL.Add('EQPM, ');
  SQL.Add('Active ');
  SQL.Add('FROM tblsimpletypes');
  SQL.Add('WHERE Typecode="LeadStatusType"');

  if not (Search = '') then
    SQL.Add('AND ' + ReplaceAlias(Search));

  if not (OrderBy = '') then
    SQL.Add('ORDER BY ' + OrderBy)

end;

initialization

   RegisterClass(TLeadStatusTypeList);

end.
