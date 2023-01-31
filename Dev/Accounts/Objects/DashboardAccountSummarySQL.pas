unit DashboardAccountSummarySQL;

interface
uses
  classes, ReportBaseObj, Types;

type

  TDashboardAccountSummaryReport = class(TReportBase)
  private
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  published
  end;

implementation

uses
  SysUtils, DateUtils, Appenvironment;

{ TDashboardAccountSummaryeport }

constructor TDashboardAccountSummaryReport.Create;
begin
  inherited;

end;

destructor TDashboardAccountSummaryReport.Destroy;
begin

  inherited;
end;

function TDashboardAccountSummaryReport.PopulateReportSQL(SQL: TStrings;
  var msg: string): boolean;
var
  MStart,MEnd: string;
  YStart, YEnd: string;
  year,month,day: word;
  TaxPercent: string;
begin
  inherited;
  msg := '';
  result := true;
  DecodeDate(now,year,month,day);
  MStart := QuotedStr(FormatDateTime('yyyy-mm-dd',EncodeDate(year,month,1)));
  MEnd := QuotedStr(FormatDateTime('yyyy-mm-dd',EndOfAMonth(year,month)));
  YStart := QuotedStr(FormatDateTime('yyyy-mm-dd', IncDay(AppEnv.CompanyPrefs.ClosingDate)));
  YEnd := QuotedStr(FormatDateTime('yyyy-mm-dd',now + 1));
  TaxPercent := FloatToStr(AppEnv.companyPrefs.IncomeTaxPercentage);

  SQL.Add('SELECT 1 as FinalOrder,"Income YTD" as Description,');
  SQL.Add('sum(CreditsEx - DebitsEx) as "Ex",');
  SQL.Add('sum(CreditsInc - DebitsInc) as "Inc"');
  SQL.Add('FROM tbltransactions T Where char_length(AccountName)>0 AND (AccountType in("EXINC" ,"INC"))');
  SQL.Add('and Date between '+YStart+' AND ' + YEnd);
  SQL.Add('UNION ALL');
  SQL.Add('SELECT 1 as FinalOrder,"Income MTD" as Description,');
  SQL.Add('sum(CreditsEx - DebitsEx) as "Ex",');
  SQL.Add('sum(CreditsInc - DebitsInc) as "Inc"');
  SQL.Add('FROM tbltransactions T Where char_length(AccountName)>0 AND (AccountType in("EXINC" ,"INC"))');
  SQL.Add('and Date between '+MStart+' AND ' + MEnd);
  SQL.Add('UNION ALL');
  SQL.Add('SELECT 2 as FinalOrder,"COGS YTD" as Description,');
  SQL.Add('sum(CreditsEx - DebitsEx) as "Ex",');
  SQL.Add('sum(CreditsInc - DebitsInc) as "Inc"');
  SQL.Add('FROM tbltransactions T Where char_length(AccountName)>0 AND (AccountType in("COGS"))');
  SQL.Add('and Date between '+YStart+' AND ' + YEnd);
  SQL.Add('UNION ALL');
  SQL.Add('SELECT 2 as FinalOrder,"COGS MTD" as Description,');
  SQL.Add('sum(CreditsEx - DebitsEx) as "Ex",');
  SQL.Add('sum(CreditsInc - DebitsInc) as "Inc"');
  SQL.Add('FROM tbltransactions T Where char_length(AccountName)>0 AND (AccountType in("COGS"))');
  SQL.Add('and Date between '+MStart+' AND ' + MEnd);
  SQL.Add('UNION ALL');
  SQL.Add('SELECT 3 as FinalOrder,"Gross Profit YTD" as Description,');
  SQL.Add('sum(CreditsEx - DebitsEx) as "Ex",');
  SQL.Add('sum(CreditsInc - DebitsInc) as "Inc"');
  SQL.Add('FROM tbltransactions T Where char_length(AccountName)>0 AND (AccountType in("COGS",  "EXINC" ,"INC"))');
  SQL.Add('and Date between '+YStart+' AND ' + YEnd);
  SQL.Add('UNION ALL');
  SQL.Add('SELECT 3 as FinalOrder,"Gross Profit MTD" as Description,');
  SQL.Add('sum(CreditsEx - DebitsEx) as "Ex",');
  SQL.Add('sum(CreditsInc - DebitsInc) as "Inc"');
  SQL.Add('FROM tbltransactions T Where char_length(AccountName)>0 AND (AccountType in("COGS",  "EXINC" ,"INC"))');
  SQL.Add('and Date between '+MStart+' AND ' + MEnd);

  SQL.Add('UNION ALL');
  SQL.Add('SELECT 4 as FinalOrder,"Expense YTD" as Description,');
  SQL.Add('sum(CreditsEx - DebitsEx) as "Ex",');
  SQL.Add('sum(CreditsInc - DebitsInc) as "Inc"');
  SQL.Add('FROM tbltransactions T Where char_length(AccountName)>0 AND (AccountType in("EXEXP" ,"EXP"))');
  SQL.Add('and Date between '+YStart+' AND ' + YEnd);
  SQL.Add('UNION ALL');
  SQL.Add('SELECT 4 as FinalOrder,"Expense MTD" as Description,');
  SQL.Add('sum(CreditsEx - DebitsEx) as "Ex",');
  SQL.Add('sum(CreditsInc - DebitsInc) as "Inc"');
  SQL.Add('FROM tbltransactions T Where char_length(AccountName)>0 AND (AccountType in("EXEXP" ,"EXP"))');
  SQL.Add('and Date between '+MStart+' AND ' + MEnd);

  SQL.Add('UNION ALL');
  SQL.Add('SELECT 5 as FinalOrder,"Net Income (Inc) YTD" as Description,');
  SQL.Add('sum(CreditsEx - DebitsEx) as "Ex",');
  SQL.Add('sum(CreditsInc - DebitsInc) as "Inc"');
  SQL.Add('FROM tbltransactions T Where char_length(AccountName)>0 AND (AccountType in("EXEXP" ,"EXP", "COGS", "EXINC" ,"INC"))');
  SQL.Add('and Date between '+YStart+' AND ' + YEnd);
  SQL.Add('UNION ALL');
  SQL.Add('SELECT 5 as FinalOrder,"Net Income (Inc) MTD" as Description,');
  SQL.Add('sum(CreditsEx - DebitsEx) as "Ex",');
  SQL.Add('sum(CreditsInc - DebitsInc) as "Inc"');
  SQL.Add('FROM tbltransactions T Where char_length(AccountName)>0 AND (AccountType in("EXEXP" ,"EXP", "COGS", "EXINC" ,"INC"))');
  SQL.Add('and Date between '+MStart+' AND ' + MEnd);

  SQL.Add('UNION ALL');
//  SQL.Add('SELECT 6 as FinalOrder,"IncomeTax'+TaxPercent+'%_YTD" as Description,');
  SQL.Add('SELECT 6 as FinalOrder,"Income Tax YTD" as Description,');
  SQL.Add('sum(CreditsEx - DebitsEx) * ' + TaxPercent + '/100 as "Ex",');
  SQL.Add('sum(CreditsInc - DebitsInc) * ' + TaxPercent + '/100 as "Inc"');
  SQL.Add('FROM tbltransactions T Where char_length(AccountName)>0 AND (AccountType in("EXEXP" ,"EXP", "COGS", "EXINC" ,"INC"))');
  SQL.Add('and Date between '+YStart+' AND ' + YEnd);
  SQL.Add('UNION ALL');
//  SQL.Add('SELECT 6 as FinalOrder,"IncomeTax'+TaxPercent+'%_MTD" as Description,');
  SQL.Add('SELECT 6 as FinalOrder,"Income Tax MTD" as Description,');
  SQL.Add('sum(CreditsEx - DebitsEx) * ' + TaxPercent + '/100 as "Ex",');
  SQL.Add('sum(CreditsInc - DebitsInc) * ' + TaxPercent + '/100 as "Inc"');
  SQL.Add('FROM tbltransactions T Where char_length(AccountName)>0 AND (AccountType in("EXEXP" ,"EXP", "COGS", "EXINC" ,"INC"))');
  SQL.Add('and Date between '+MStart+' AND ' + MEnd);

  SQL.Add('UNION ALL');
  SQL.Add('SELECT 7 as FinalOrder,"Net Income (Ex) YTD" as Description,');
  SQL.Add('sum(CreditsEx - DebitsEx) * (100-'+TaxPercent+')/100 as "Ex",');
  SQL.Add('sum(CreditsInc - DebitsInc) * (100-'+TaxPercent+')/100 as "Inc"');
  SQL.Add('FROM tbltransactions T Where char_length(AccountName)>0 AND (AccountType in("EXEXP" ,"EXP", "COGS", "EXINC" ,"INC"))');
  SQL.Add('and Date between '+YStart+' AND ' + YEnd);
  SQL.Add('UNION ALL');
  SQL.Add('SELECT 7 as FinalOrder,"Net Income (Ex) MTD" as Description,');
  SQL.Add('sum(CreditsEx - DebitsEx) * (100-'+TaxPercent+')/100 as "Ex",');
  SQL.Add('sum(CreditsInc - DebitsInc) * (100-'+TaxPercent+')/100 as "Inc"');
  SQL.Add('FROM tbltransactions T Where char_length(AccountName)>0 AND (AccountType in("EXEXP" ,"EXP", "COGS", "EXINC" ,"INC"))');
  SQL.Add('and Date between '+MStart+' AND ' + MEnd);

  SQL.Add('Order by finalorder,description');

end;


initialization
  RegisterClass(TDashboardAccountSummaryReport);

end.
