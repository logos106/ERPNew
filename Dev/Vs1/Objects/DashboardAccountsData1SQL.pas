unit DashboardAccountsData1SQL;

interface

uses
  ReportBaseObj, Classes;

Type
  TCardDataReport = Class(TReportBase)
  private
    fDTFrom1, fDTTo1: TDateTime;
    fDTFrom2, fDTTo2: TDateTime;
    fSelDate: TDateTime;
    procedure CreateTemporaryTable();

  protected
  public
    constructor Create; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): Boolean; override;

  published
    property SelDate: TDateTime   read fSelDate   write fSelDate;
  End;

implementation

uses CommonLib, SysUtils, DateUtils, ERPDbComponents, JSONObject, CommonDbLib, MySQLConst,
      ProfitAndLossSQL, LogLib;
{ TPartClass }

constructor TCardDataReport.Create;
begin
  inherited;
  fSelDate := 0;
 end;

procedure MakePnLReportSum(DateFrom: TDateTime; DateTo: TDateTime; Suffix: Integer);
var
  fReportSQLObj: TProfitAndLossReport;
  fScript: TERPScript;
  msg: String;
begin
  fReportSQLObj := TProfitAndLossReport.Create;
  try
    fReportSQLObj.DateFrom := DateFrom;
    fReportSQLObj.DateTo := DateTo;

    fScript := TERPScript.Create(nil);
    try
      fScript.Connection := CommonDbLib.GetSharedMyDacConnection;;
      fScript.SQL.Clear;
      fReportSQLObj.PopulateReportSQL(fScript.SQL, msg);
      fScript.SQL.text := 'DROP TEMPORARY TABLE IF EXISTS tmp_PNL_Data' + IntToStr(Suffix) + ';' +
                    ' CREATE TEMPORARY TABLE tmp_PNL_Data' + IntToStr(Suffix) + ' ' + fScript.SQL.text + ';' +
                    ' DELETE FROM tmp_PNL_Data' + IntToStr(Suffix) + ' WHERE NOT(`account type` LIKE "Total%" OR `account type` LIKE "Net%");';
      LogText(fScript.SQL.Text);
      fScript.Execute;
    finally
      fScript.Free;
    end;

  finally
    FreeAndNil(fReportSQLObj);
  end;

end;

procedure TCardDataReport.CreateTemporaryTable();
var
  Params: TJSONObject;
  TempScript: TERPScript;
  DateFrom1, DateTo1: String;
  DateFrom2, DateTo2: String;
begin
  if not (fSelDate > 0) then fSelDate := Now;

  fDTFrom1 := StartOfTheMonth(IncMonth(fSelDate, -2));
  fDTTo1 := EndOfTheMonth(IncMonth(fSelDate, -2));
  fDTFrom2 := StartOfTheMonth(IncMonth(fSelDate, -1));
  fDTTo2 := EndOfTheMonth(IncMonth(fSelDate, -1));

  DateFrom1 := FormatDateTime(MysqlDateFormat, fDTFrom1);
  DateTo1 := FormatDateTime(MysqlDateFormat, fDTTo1);
  DateFrom2 := FormatDateTime(MysqlDateFormat, fDTFrom2);
  DateTo2 := FormatDateTime(MysqlDateFormat, fDTTo2);

  MakePnLReportSum(fDTFrom1, fDTTo1, 1);
  MakePnLReportSum(fDTFrom2, fDTTo2, 2);

  TempScript := TERPScript.Create(nil);
  try
    with TempScript do begin
      Connection := CommonDbLib.GetSharedMyDacConnection;
      SQL.Clear;
      SQL.Add('DROP TEMPORARY TABLE IF EXISTS tmp_vs1_card_data;');
      SQL.Add('CREATE TEMPORARY TABLE tmp_vs1_card_data ( ' +
                  ' ID                     INT(11)  NOT NULL AUTO_INCREMENT, ' +
                  ' DateFrom1               DATETIME NULL DEFAULT NULL, ' +
                  ' DateTo1                 DATETIME NULL DEFAULT NULL, ' +
                  ' DateFrom2               DATETIME NULL DEFAULT NULL, ' +
                  ' DateTo2                 DATETIME NULL DEFAULT NULL, ' +

                  ' Cash_Received1          DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Cash_Received2          DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Cash_Spent1             DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Cash_Spent2             DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Cash_Surplus1           DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Cash_Surplus2           DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Cash_Balance1           DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Cash_Balance2           DOUBLE   NOT NULL DEFAULT 0, ' +

                  ' Prof_Income1            DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Prof_Income2            DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Prof_Gross1             DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Prof_Gross2             DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Prof_Expenses1          DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Prof_Expenses2          DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Prof_Net1               DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Prof_Net2               DOUBLE   NOT NULL DEFAULT 0, ' +

                  ' Income_Invoices1        INT(11)  NOT NULL DEFAULT 0, ' +
                  ' Income_Invoices2        INT(11)  NOT NULL DEFAULT 0, ' +
                  ' Income_Average1         DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Income_Average2         DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Income_Total1           DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Income_Total2           DOUBLE   NOT NULL DEFAULT 0, ' +

                  ' Perf_GrossMargin1       DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Perf_GrossMargin2       DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Perf_NetMargin1         DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Perf_NetMargin2         DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Perf_ROI1               DOUBLE   NOT NULL DEFAULT 0, ' +
                  ' Perf_ROI2               DOUBLE   NOT NULL DEFAULT 0, ' +

                  ' Bal_Debtors1            DOUBLE  NOT NULL DEFAULT 0, ' +
                  ' Bal_Debtors2            DOUBLE  NOT NULL DEFAULT 0, ' +
                  ' Bal_Creditors1          DOUBLE  NOT NULL DEFAULT 0, ' +
                  ' Bal_Creditors2          DOUBLE  NOT NULL DEFAULT 0, ' +
                  ' Bal_NetAsset1           DOUBLE  NOT NULL DEFAULT 0, ' +
                  ' Bal_NetAsset2           DOUBLE  NOT NULL DEFAULT 0, ' +

                  ' Pos_AvgDebtDays1        INT(11) NOT NULL DEFAULT 0, ' +
                  ' Pos_AvgDebtDays2        INT(11) NOT NULL DEFAULT 0, ' +
                  ' Pos_AvgCredDays1        INT(11) NOT NULL DEFAULT 0, ' +
                  ' Pos_AvgCredDays2        INT(11) NOT NULL DEFAULT 0, ' +
                  ' Pos_CashForecast1       DOUBLE  NOT NULL DEFAULT 0, ' +
                  ' Pos_CashForecast2       DOUBLE  NOT NULL DEFAULT 0, ' +
                  ' Pos_AssetToLiab1        DOUBLE  NOT NULL DEFAULT 0, ' +
                  ' Pos_AssetToLiab2        DOUBLE  NOT NULL DEFAULT 0, ' +

                  ' Sheet_AssetToLiab1      DOUBLE  NOT NULL DEFAULT 0, ' +
                  ' Sheet_AssetToLiab2      DOUBLE  NOT NULL DEFAULT 0, ' +

                  ' PRIMARY KEY (ID) ' +
                  ' ) ENGINE=MyISAM DEFAULT CHARSET=utf8;');

      SQL.Add('INSERT INTO tmp_vs1_card_data SET DateFrom1=' + QuotedStr(DateFrom1) + ';');
      SQL.Add('UPDATE tmp_vs1_card_data SET DateTo1=' + QuotedStr(DateTo1) + ';');
      SQL.Add('UPDATE tmp_vs1_card_data SET DateFrom2=' + QuotedStr(DateFrom2) + ';');
      SQL.Add('UPDATE tmp_vs1_card_data SET DateTo2=' + QuotedStr(DateTo2) + ';');

       // Cash
      SQL.Add('UPDATE tmp_vs1_card_data T, (SELECT TRUNCATE(SUM(DebitsInc), 4) AS Received FROM tbltransactions WHERE AccountType="BANK" AND `Date` BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ') T1 SET T.Cash_Received1=T1.Received;');
      SQL.Add('UPDATE tmp_vs1_card_data T, (SELECT TRUNCATE(SUM(DebitsInc), 4) AS Received FROM tbltransactions WHERE AccountType="BANK" AND `Date` BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ') T1 SET T.Cash_Received2=T1.Received;');

      SQL.Add('UPDATE tmp_vs1_card_data T, (SELECT TRUNCATE(SUM(CreditsEx), 4) AS Spent 	 FROM tbltransactions	WHERE (AccountType="BANK" OR AccountType="CCARD") AND `Date` BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ') T1 SET T.Cash_Spent1=T1.Spent;');
      SQL.Add('UPDATE tmp_vs1_card_data T, (SELECT TRUNCATE(SUM(CreditsEx), 4) AS Spent 	 FROM tbltransactions	WHERE (AccountType="BANK" OR AccountType="CCARD") AND `Date` BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ') T1 SET T.Cash_Spent2=T1.Spent;');

      SQL.Add('UPDATE tmp_vs1_card_data T, (SELECT TRUNCATE(SUM(DebitsInc) - SUM(CreditsEx), 4) AS Surplus FROM tbltransactions WHERE AccountType="BANK" AND `Date` BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ') T1 SET T.Cash_Surplus1=T1.Surplus;');
      SQL.Add('UPDATE tmp_vs1_card_data T, (SELECT TRUNCATE(SUM(DebitsInc) - SUM(CreditsEx), 4) AS Surplus FROM tbltransactions WHERE AccountType="BANK" AND `Date` BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ') T1 SET T.Cash_Surplus2=T1.Surplus;');

      SQL.Add('UPDATE tmp_vs1_card_data T, (SELECT TRUNCATE(SUM(DebitsInc), 4) AS Balance FROM tbltransactions WHERE AccountType="BANK" AND `Date` BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ') T1 SET T.Cash_Balance1=T1.Balance;');
      SQL.Add('UPDATE tmp_vs1_card_data T, (SELECT TRUNCATE(SUM(DebitsInc), 4) AS Balance FROM tbltransactions WHERE AccountType="BANK" AND `Date` BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ') T1 SET T.Cash_Balance2=T1.Balance;');

      // Profitability
      SQL.Add('UPDATE tmp_vs1_card_data SET Prof_Income1=(SELECT totalAmountEx FROM tmp_PNL_Data1 WHERE UCASE(`account type`)=UCASE("Total Income"));');
      SQL.Add('UPDATE tmp_vs1_card_data SET Prof_Income2=(SELECT totalAmountEx FROM tmp_PNL_Data2 WHERE UCASE(`account type`)=UCASE("Total Income"));');

      SQL.Add('UPDATE tmp_vs1_card_data SET Prof_Gross1=(SELECT totalAmountEx FROM tmp_PNL_Data1 WHERE UCASE(`account type`)=UCASE("Gross Profit"));');
      SQL.Add('UPDATE tmp_vs1_card_data SET Prof_Gross2=(SELECT totalAmountEx FROM tmp_PNL_Data2 WHERE UCASE(`account type`)=UCASE("Gross Profit"));');

      SQL.Add('UPDATE tmp_vs1_card_data SET Prof_Expenses1=(SELECT totalAmountEx FROM tmp_PNL_Data1 WHERE UCASE(`account type`)=UCASE("Total Expenses"));');
      SQL.Add('UPDATE tmp_vs1_card_data SET Prof_Expenses2=(SELECT totalAmountEx FROM tmp_PNL_Data2 WHERE UCASE(`account type`)=UCASE("Total Expenses"));');

      SQL.Add('UPDATE tmp_vs1_card_data SET Prof_Net1=(SELECT totalAmountEx FROM tmp_PNL_Data1 WHERE UCASE(`account type`)=UCASE("Net Income"));');
      SQL.Add('UPDATE tmp_vs1_card_data SET Prof_Net2=(SELECT totalAmountEx FROM tmp_PNL_Data2 WHERE UCASE(`account type`)=UCASE("Net Income"));');

      // Income
      SQL.Add('UPDATE tmp_vs1_card_data SET Income_Invoices1=' +
                    '(SELECT COUNT(*) FROM tblsales WHERE IsInvoice="T" AND Deleted="F"  AND Saledate BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ');');
      SQL.Add('UPDATE tmp_vs1_card_data SET Income_Invoices2=' +
                    '(SELECT COUNT(*) FROM tblsales WHERE IsInvoice="T" AND Deleted="F"  AND Saledate BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ');');

      SQL.Add('UPDATE tmp_vs1_card_data SET Income_Average1=' +
                    '(SELECT AVG(TotalAmountInc) FROM tblsales WHERE IsInvoice="T" AND Deleted="F"  AND Saledate BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ');');
      SQL.Add('UPDATE tmp_vs1_card_data SET Income_Average2=' +
                    '(SELECT AVG(TotalAmountInc) FROM tblsales WHERE IsInvoice="T" AND Deleted="F"  AND Saledate BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ');');

      SQL.Add('UPDATE tmp_vs1_card_data SET Income_Total1=' +
                    '(SELECT SUM(TotalAmountInc) FROM tblsales WHERE IsInvoice="T" AND Deleted="F" AND Saledate BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ');');
      SQL.Add('UPDATE tmp_vs1_card_data SET Income_Total2=' +
                    '(SELECT SUM(TotalAmountInc) FROM tblsales WHERE IsInvoice="T" AND Deleted="F" AND Saledate BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ');');

      // Performance
      SQL.Add('UPDATE tmp_vs1_card_data SET Perf_GrossMargin1=TRUNCATE((Prof_Income1 - (SELECT totalAmountEx FROM tmp_PNL_Data1 WHERE UCASE(`account type`) = UCASE("Total COGS"))) * 100 / Prof_Income1, 2);');
      SQL.Add('UPDATE tmp_vs1_card_data SET Perf_GrossMargin2=TRUNCATE((Prof_Income2 - (SELECT totalAmountEx FROM tmp_PNL_Data2 WHERE UCASE(`account type`) = UCASE("Total COGS"))) * 100 / Prof_Income2, 2);');

      SQL.Add('UPDATE tmp_vs1_card_data SET Perf_NetMargin1=TRUNCATE((Prof_Income1 - Prof_Expenses1) * 100 / Prof_Income1, 2);');
      SQL.Add('UPDATE tmp_vs1_card_data SET Perf_NetMargin2=TRUNCATE((Prof_Income2 - Prof_Expenses2) * 100 / Prof_Income2, 2);');

      SQL.Add('UPDATE tmp_vs1_card_data SET Perf_ROI1=TRUNCATE((Prof_Net1) * 100 / (SELECT SUM(DebitsInc) FROM tbltransactions WHERE AccountType="EQUITY"), 2);');
      SQL.Add('UPDATE tmp_vs1_card_data SET Perf_ROI2=TRUNCATE((Prof_Net2) * 100 / (SELECT SUM(DebitsInc) FROM tbltransactions WHERE AccountType="EQUITY"), 2);');

      SQL.Add('UPDATE tmp_vs1_card_data SET Perf_NetMargin1=TRUNCATE((Prof_Income1 - Prof_Expenses1) * 100 / Prof_Income1, 2);');
      SQL.Add('UPDATE tmp_vs1_card_data SET Perf_NetMargin2=TRUNCATE((Prof_Income2 - Prof_Expenses2) * 100 / Prof_Income2, 2);');

      // Balance Sheet
      SQL.Add('UPDATE tmp_vs1_card_data SET Bal_Debtors1=' +
                    '(SELECT TRUNCATE(SUM(t.DebitsEx) - SUM(t.CreditsEx), 4) ' +
                    'FROM tbltransactions t LEFT JOIN tblsales s ON t.SaleID=s.SaleID LEFT JOIN tblpurchaseorders p ON t.PurchaseOrderID = p.PurchaseOrderID ' +
                    'WHERE t.AccountType = "AR" AND IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date)) > 0 ' +
                    'AND `Date` BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ');');
      SQL.Add('UPDATE tmp_vs1_card_data SET Bal_Debtors2=' +
                    '(SELECT TRUNCATE(SUM(t.DebitsEx) - SUM(t.CreditsEx), 4) ' +
                    'FROM tbltransactions t LEFT JOIN tblsales s ON t.SaleID=s.SaleID LEFT JOIN tblpurchaseorders p ON t.PurchaseOrderID = p.PurchaseOrderID ' +
                    'WHERE t.AccountType = "AR" AND IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date)) > 0 ' +
                    'AND `Date` BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ');');

      SQL.Add('UPDATE tmp_vs1_card_data SET Bal_Creditors1=' +
                    '(SELECT TRUNCATE(SUM(t.CreditsEx) - SUM(t.DebitsEx), 4) ' +
                    'FROM tbltransactions t LEFT JOIN tblsales s ON t.SaleID=s.SaleID LEFT JOIN tblpurchaseorders p ON t.PurchaseOrderID = p.PurchaseOrderID ' +
                    'WHERE t.AccountType = "AP" AND IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date)) > 0 ' +
                    'AND `Date` BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ');');
      SQL.Add('UPDATE tmp_vs1_card_data SET Bal_Creditors2=' +
                    '(SELECT TRUNCATE(SUM(t.CreditsEx) - SUM(t.DebitsEx), 4) ' +
                    'FROM tbltransactions t LEFT JOIN tblsales s ON t.SaleID=s.SaleID LEFT JOIN tblpurchaseorders p ON t.PurchaseOrderID = p.PurchaseOrderID ' +
                    'WHERE t.AccountType = "AP" AND IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date)) > 0 ' +
                    'AND `Date` BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ');');

      SQL.Add('UPDATE tmp_vs1_card_data SET Bal_NetAsset1=' +
                    '(SELECT TRUNCATE(SUM(DebitsEx) - SUM(CreditsEx), 4) FROM tbltransactions WHERE (AccountType = "AR" OR AccountType = "BANK" OR AccountType = "OCASSET" OR AccountType = "OASSET") ' +
                    'AND `Date` BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ');');
      SQL.Add('UPDATE tmp_vs1_card_data SET Bal_NetAsset2=' +
                    '(SELECT TRUNCATE(SUM(DebitsEx) - SUM(CreditsEx), 4) FROM tbltransactions WHERE (AccountType = "AR" OR AccountType = "BANK" OR AccountType = "OCASSET" OR AccountType = "OASSET") ' +
                    'AND `Date` BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ');');

      // Position
      SQL.Add('UPDATE tmp_vs1_card_data SET Pos_AvgDebtDays1=' +
                    '(SELECT SUM(IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date))) ' +
                    'FROM tbltransactions t LEFT JOIN tblsales s ON t.SaleID=s.SaleID LEFT JOIN tblpurchaseorders p ON t.PurchaseOrderID=p.PurchaseOrderID ' +
                    'WHERE t.AccountType = "AR" AND IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date)) > 0 ' +
                    'AND `Date` BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ');');
      SQL.Add('UPDATE tmp_vs1_card_data SET Pos_AvgDebtDays2=' +
                    '(SELECT SUM(IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date))) ' +
                    'FROM tbltransactions t LEFT JOIN tblsales s ON t.SaleID=s.SaleID LEFT JOIN tblpurchaseorders p ON t.PurchaseOrderID=p.PurchaseOrderID ' +
                    'WHERE t.AccountType = "AR" AND IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date)) > 0 ' +
                    'AND `Date` BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ');');

      SQL.Add('UPDATE tmp_vs1_card_data SET Pos_AvgCredDays1=' +
                    '(SELECT SUM(IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date))) ' +
                    'FROM tbltransactions t LEFT JOIN tblsales s ON t.SaleID=s.SaleID LEFT JOIN tblpurchaseorders p ON t.PurchaseOrderID=p.PurchaseOrderID ' +
                    'WHERE t.AccountType = "AP" AND IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date)) > 0 ' +
                    'AND `Date` BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ');');
      SQL.Add('UPDATE tmp_vs1_card_data SET Pos_AvgCredDays2=' +
                    '(SELECT SUM(IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date))) ' +
                    'FROM tbltransactions t LEFT JOIN tblsales s ON t.SaleID=s.SaleID LEFT JOIN tblpurchaseorders p ON t.PurchaseOrderID=p.PurchaseOrderID ' +
                    'WHERE t.AccountType = "AP" AND IF(s.SaleID IS NULL, IF(p.PurchaseOrderID IS NULL, 0, TermToDays(p.Terms, t.Date)), TermToDays(s.Terms, t.Date)) > 0 ' +
                    'AND `Date` BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ');');

      SQL.Add('UPDATE tmp_vs1_card_data SET Pos_CashForecast1=' +
                    'Bal_Debtors1 - Bal_Creditors1;');
      SQL.Add('UPDATE tmp_vs1_card_data SET Pos_CashForecast2=' +
                    'Bal_Debtors2 - Bal_Creditors2;');

      SQL.Add('UPDATE tmp_vs1_card_data SET Pos_AssetToLiab1=Bal_NetAsset1 - ' +
                    '(SELECT IF(AccountType = "CCARD", TRUNCATE(SUM(DebitsEx) - SUM(CreditsEx), 4), TRUNCATE(SUM(CreditsEx) - SUM(DebitsEx), 4)) ' +
                    'FROM tbltransactions WHERE (AccountType="AP" OR AccountType="OCLIAB" OR AccountType="CCARD") ' +
                    'AND `Date` BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ');');
      SQL.Add('UPDATE tmp_vs1_card_data SET Pos_AssetToLiab2=Bal_NetAsset2 - ' +
                    '(SELECT IF(AccountType = "CCARD", TRUNCATE(SUM(DebitsEx) - SUM(CreditsEx), 4), TRUNCATE(SUM(CreditsEx) - SUM(DebitsEx), 4)) ' +
                    'FROM tbltransactions WHERE (AccountType="AP" OR AccountType="OCLIAB" OR AccountType="CCARD") ' +
                    'AND `Date` BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ');');

      // Sheet
      SQL.Add('UPDATE tmp_vs1_card_data SET Sheet_AssetToLiab1=' +
                    '(SELECT TRUNCATE(SUM(DebitsEx) - SUM(CreditsEx), 4) ' +
                    '  FROM tbltransactions WHERE AccountType="OCASSET" AND `Date` BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ') - ' +
                    '(SELECT TRUNCATE(SUM(DebitsEx) - SUM(CreditsEx), 4) ' +
                    '  FROM tbltransactions WHERE AccountType="OCLIAB" AND `Date` BETWEEN ' + QuotedStr(DateFrom1) + ' AND ' + QuotedStr(DateTo1) + ');');
      SQL.Add('UPDATE tmp_vs1_card_data SET Sheet_AssetToLiab2=' +
                    '(SELECT TRUNCATE(SUM(DebitsEx) - SUM(CreditsEx), 4) ' +
                    '  FROM tbltransactions WHERE AccountType="OCASSET" AND `Date` BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ') - ' +
                    '(SELECT TRUNCATE(SUM(DebitsEx) - SUM(CreditsEx), 4) ' +
                    '  FROM tbltransactions WHERE AccountType="OCLIAB" AND `Date` BETWEEN ' + QuotedStr(DateFrom2) + ' AND ' + QuotedStr(DateTo2) + ');');

//      if not Devmode then
//        SQL.Add('DROP TABLE IF EXISTS tmp_vs1_card_data;');

      Execute;
    end;
  finally
    TempScript.Free;
  end;
end;

function TCardDataReport.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
begin
  Result := inherited;

//  CreateTemporaryTable();

  SQL.Clear;

  SQL.Add('SELECT * FROM tmp_vs1_card_data');


end;
initialization
  RegisterClass(TCardDataReport);

end.
