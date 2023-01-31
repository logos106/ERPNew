unit PaymentMethodListSQL;

interface

uses
  classes, ReportBaseObj;

Type
  TPaymentMethodList = class(TReportWithDateRangeBase)
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

constructor TPaymentMethodList.Create;
begin
   inherited;

   DateFrom := MinDateTime;
   DateTo := MaxDateTime;
end;

function TPaymentMethodList.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
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
  SQL.Add('PayMethodID, ');
  SQL.Add('Name, ');
  SQL.Add('IsCreditCard, ');
  SQL.Add('Active ');
  SQL.Add('FROM tblpaymentmethods');

  if not (Search = '') then
    SQL.Add('WHERE ' + ReplaceAlias(Search));

  if not (OrderBy = '') then
    SQL.Add('ORDER BY ' + OrderBy)

end;

initialization

   RegisterClass(TPaymentMethodList);

end.
