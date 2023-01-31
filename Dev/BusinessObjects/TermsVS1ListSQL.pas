unit TermsVS1ListSQL;

interface

uses
  classes, ReportBaseObj;

Type
  TTermsVS1List = class(TReportWithDateRangeBase)
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

constructor TTermsVS1List.Create;
begin
   inherited;

   DateFrom := MinDateTime;
   DateTo := MaxDateTime;
end;

function TTermsVS1List.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
var
  ScriptMain: TERPScript;

  function ReplaceAlias(AClause: string): string;
  var
    STemp: string;
  begin
    STemp := AClause;
    STemp := ReplaceStr(STemp, 'true', '"T"');
    STemp := ReplaceStr(STemp, 'false', '"F"');
    STemp := ReplaceStr(STemp, 'IsEOM', 'EOM');
    STemp := ReplaceStr(STemp, 'IsEOMPlus', 'EOMPlus');
    STemp := ReplaceStr(STemp, 'IsDays', 'Days');
    STemp := ReplaceStr(STemp, 'IsProgressPayment', 'PP');
    Result := STemp;
  end;

begin
  Result := inherited;

  SQL.Clear;
  SQL.Add('SELECT');
  SQL.Add('TermsID, ');
  SQL.Add('Terms, ');
  SQL.Add('TermsAmount, ');
  SQL.Add('EOM AS IsEOM, ');
  SQL.Add('EOMPlus AS IsEOMPlus, ');
  SQL.Add('Days AS IsDays, ');
  SQL.Add('PP AS IsProgressPayment, ');
  SQL.Add('Active, ');
  SQL.Add('Description, ');
  SQL.Add('Required, ');
  SQL.Add('EarlyPaymentDiscount, ');
  SQL.Add('EarlyPaymentDays, ');
  SQL.Add('ProgressPaymentType, ');
  SQL.Add('ProgressPaymentDuration, ');
  SQL.Add('ProgressPaymentInstallments, ');
  SQL.Add('ProgressPaymentfirstPayonSaleDate, ');
  SQL.Add('IsSalesDefault, ');
  SQL.Add('IsPurchaseDefault ');
  SQL.Add('FROM tblterms');
  SQL.Add('WHERE PublishOnVS1="T"');

  if not (Search = '') then
    SQL.Add('AND ' + ReplaceAlias(Search));

  if not (OrderBy = '') then
    SQL.Add('ORDER BY ' + OrderBy)

end;

initialization

   RegisterClass(TTermsVS1List);

end.
