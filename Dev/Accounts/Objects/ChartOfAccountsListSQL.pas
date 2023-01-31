unit ChartOfAccountsListSQL;

interface

uses
  ReportBaseObj, Classes;

Type
  TChartOfAccountsList = Class(TReportWithDateRangeBase)
  private
    fiRegionID: Integer;
    fsEHA: Boolean;

  protected
  public
    constructor Create; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;

  published
    property RegionID: Integer              read fiRegionID write fiRegionID;
    property ExcludeHeaderAccounts: Boolean  read fsEHA      write fsEHA;

  End;

implementation

uses CommonLib, SysUtils, DateUtils, ERPDbComponents, JSONObject, CommonDbLib, MySQLConst,
      ProfitAndLossSQL, LogLib, PQALib, ProductQtyLib, tcConst, busobjStockMovement, LogUtils;
{ TPartClass }

constructor TChartOfAccountsList.Create;
begin
  inherited;

  fiRegionID := 0;
  fsEHA := true;
  DateFrom := MinDateTime;
  DateTo := MaxDateTime;
end;

function TChartOfAccountsList.PopulateReportSQL(SQL: TStrings; var msg: string): Boolean;
var
  sEHA: String;

begin
  Result := inherited;

  if fsEHA then sEHA := 'T' else sEHA := 'F';

  SQL.Clear;

  SQL.Add('SELECT DISTINCT');
  SQL.Add('ifnull(tblbudgetPeriodLines.AccountId,0) as BudgetAccountno, ');
  SQL.Add('tblChartofAccounts.AccountNumber as AccountNo, ');
  SQL.Add('AccDesc AS Type, ');
  SQL.Add('SUBSTRING(If((char_length(tblChartofAccounts.AccountGroup)>0),Concat(REPLACE(tblChartofAccounts.AccountGroup,"^"," - ")," - ",tblChartofAccounts.AccountName),tblChartofAccounts.AccountName),1,255) AS "FullAccountName", ');
  SQL.Add('tblChartofAccounts.Description as "Description", ');
  SQL.Add('tblChartofAccounts.Balance as "Balance", ');
  SQL.Add('tblChartofAccounts.Taxcode as TaxCode, ');
  SQL.Add('tblTaxcodes.Description as TaxCodeDescription,');
  SQL.Add('tblChartofAccounts.BSB  AS BSB,');
  SQL.Add('tblChartofAccounts.BankAccountNumber as BankAccNo,');
  SQL.Add('tblChartofAccounts.BankAccountName as BankAccountName, ');
  SQL.Add('tblChartofAccounts.BankNumber as "Bank Number", ');
  SQL.Add('tblChartofAccounts.AccountName as "AccountName", ');
  SQL.Add('SUBSTRING(If((char_length(tblChartofAccounts.AccountGroup)>0),Replace(tblChartofAccounts.AccountGroup,"^"," - "),""),1,255) AS "AccountGroup", ');
  SQL.Add('Concat(If( char_length(Level4)>0,Space(15), If( char_length(Level3)>0,Space(10),If( char_length(Level2)>0,Space(5),Space(0)))),AccountName) as "AccountTree", ');
  SQL.Add('tblChartofAccounts.Active as Active, ');
  SQL.Add('tblTaxcodes.TaxCodeID as TaxCodeID, ');
  SQL.Add('Level1 as Level1, ');
  SQL.Add('Level2 as Level2, ');
  SQL.Add('Level3 as Level3, ');
  SQL.Add('Level4 as Level4, ');
  SQL.Add('tblChartofAccounts.AccountID as AccountID, ');
  SQL.Add('AllowExpenseClaim as AllowExpenseClaim, ');
  SQL.Add('SortOrder as SortOrder ');
  SQL.Add('FROM tblChartofAccounts ');
  SQL.Add('LEFT JOIN tblTaxcodes ON tblTaxcodes.Name = tblChartofAccounts.Taxcode AND tblTaxcodes.RegionID = ' + IntToStr(fiRegionID));
  SQL.Add('LEFT JOIN tblacctypedesc ON tblacctypedesc.AccType=tblChartofAccounts.AccountType');
  SQL.Add('LEFT JOIN tblbudgetPeriodLines ON tblbudgetPeriodLines.AccountId = tblChartofAccounts.AccountID and tblbudgetPeriodLines.Active <> "F"' );
  SQL.Add('WHERE ((IsHeader <> "T") AND (' + QuotedStr(sEHA) + ' = "T")) OR (IsNull(' + QuotedStr(sEHA) + ') OR (' + QuotedStr(sEHA) + ' = "F"))');
  SQL.Add('ORDER BY SortOrder,FullAccountName');

end;

initialization
  RegisterClass(TChartOfAccountsList);

end.
