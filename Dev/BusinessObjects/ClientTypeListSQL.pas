unit ClientTypeListSQL;

interface

uses
  classes, ReportBaseObj;

Type
  TClientTypeList = class(TReportWithDateRangeBase)
  Private

  Protected

  Public
    constructor Create; Override;

    function PopulateReportSQL(SQL: TStrings; var msg: string): Boolean; override;

  Published

  end;

implementation

uses sysutils, ProductQtyLib, StringUtils, CommonDbLib, ERPdbComponents, MySQLConst,
  LogLib, CommonLib, PQALib;

constructor TClientTypeList.Create;
begin
   inherited;

   DateFrom := MinDateTime;
   DateTo := MaxDateTime;
end;

function TClientTypeList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
var
  ScriptMain: TERPScript;

  function ReplaceAlias(AClause: string): string;
  var
    STemp: string;
  begin
    STemp := AClause;
    STemp := ReplaceStr(STemp, 'true', '"T"');
    STemp := ReplaceStr(STemp, 'false', '"F"');
    STemp := ReplaceStr(STemp, 'TermsName', 'Terms');
    STemp := ReplaceStr(STemp, 'TermsID', 'c.TermsID');
    STemp := ReplaceStr(STemp, 'Active', 'c.Active');
    Result := STemp;
  end;

begin
  Result := inherited;

  SQL.Clear;
  SQL.Add('SELECT');
  SQL.Add('ClientTypeID, ');
  SQL.Add('CreditLimit, ');
  SQL.Add('DefaultPostAccount, ');
  SQL.Add('TypeDescription, ');
  SQL.Add('GracePeriod, ');
  SQL.Add('c.TermsID, ');
  SQL.Add('c.Active, ');
  SQL.Add('Terms AS TermsName');
  SQL.Add('FROM tblclienttype c LEFT JOIN tblterms t ON c.TermsID=t.TermsID');

  if not (Search = '') then
    SQL.Add('WHERE ' + ReplaceAlias(Search));

  if not (OrderBy = '') then
    SQL.Add('ORDER BY ' + OrderBy)

end;

initialization

   RegisterClass(TClientTypeList);

end.
