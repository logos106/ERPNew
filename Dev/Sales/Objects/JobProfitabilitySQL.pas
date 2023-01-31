unit JobProfitabilitySQL;

interface

uses
  classes, ReportBaseObj;

Type
  TJobProfitability = class(TReportWithDateRangeBase)
  Private
    fTablename: string;
    fClientID: Integer;
    fInvoiceDate: Boolean;
    procedure CreateTempJobProfTable;
    procedure PopulateData;

  Protected

  Public
    constructor Create; Override;

    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;

  Published
    property ClientID: Integer  read fClientID write fClientID;
    property IsInvoiceDate: Boolean  read fInvoiceDate write fInvoiceDate;
  end;

implementation

uses sysutils, ProductQtyLib, StringUtils, CommonDbLib, ERPdbComponents, MySQLConst,
  LogLib;


constructor TJobProfitability.Create;
begin
   inherited;

   fTablename := commondblib.GetUserTemporaryTableName('jobprofitabilityCustomer');
   fClientID := 0;

   DateFrom := MinDateTime;
   DateTo := MaxDateTime;
end;

procedure TJobProfitability.CreateTempJobProfTable;
var
  LScript: TERPScript;
begin
  commondblib.DestroyUserTemporaryTable(fTablename);

  LScript := TERPScript.Create(nil);
  try
    with LScript do begin
      Connection := CommonDbLib.GetSharedMyDacConnection;

      SQL.Clear;
      SQL.Add('CREATE TABLE ' + fTablename + ' (');
      SQL.Add('ID                       int(11) NOT NULL AUTO_INCREMENT,');
      SQL.Add('Details                  INT(11)     DEFAULT 0,');
      SQL.Add('Transdate                DateTime,');
      SQL.Add('CompanyName              VARCHAR(255),');
      SQL.Add('SupplierName             VARCHAR(255),');
      SQL.Add('Department               VARCHAR(255),');
      SQL.Add('JobName                  VARCHAR(255),');
      SQL.Add('JobNumber                INT(11)     DEFAULT 0,');
      SQL.Add('SaleID                   INT(11)  NULL   DEFAULT 0,');
      SQL.Add('LineID                   INT(11)     DEFAULT 0,');
      SQL.Add('AccountName              VARCHAR(255),');
      SQL.Add('CreditEx                 DOUBLE      DEFAULT 0,');
      SQL.Add('DebitEx                  DOUBLE      DEFAULT 0,');
      SQL.Add('TransactionType          VARCHAR(255),');
      SQL.Add('ClientID                 INT(11)     DEFAULT 0,');
      SQL.Add('TransactionNo            VARCHAR(30),');
      SQL.Add('CostEx                   DOUBLE      DEFAULT 0,');
      SQL.Add('IncomeEx                 DOUBLE      DEFAULT 0,');
      SQL.Add('Quotedex                 DOUBLE      DEFAULT 0,');
      SQL.Add('DiffIncome_Cost         DOUBLE      DEFAULT 0,');
      SQL.Add('PercentDiffIncomebyCost  DOUBLE      DEFAULT 0,');
      SQL.Add('DiffQuote_Cost          DOUBLE      DEFAULT 0,');
      SQL.Add('DiffIncome_Quote        DOUBLE      DEFAULT 0,');
      SQL.Add('PercentDiffIncomebyQuote DOUBLE      DEFAULT 0,');
      SQL.Add('PercentDiffQuotebyCost   DOUBLE      DEFAULT 0,');
      SQL.Add('Backorders               DOUBLE      DEFAULT 0,');
      SQL.Add('ProfitPercent            DOUBLE      DEFAULT 0,');
      SQL.Add('ProfitDollars            DOUBLE      DEFAULT 0,');
      SQL.Add('ProductName              VARCHAR(60),');
      SQL.Add('ProductID                INT(11)     DEFAULT 0,');
      SQL.Add('QtyOrdered               DOUBLE      DEFAULT 0,');
      SQL.Add('QtyShipped               DOUBLE      DEFAULT 0,');
      SQL.Add('QtyBackOrder             DOUBLE      DEFAULT 0,');
      SQL.Add('LandedCost               DOUBLE      DEFAULT 0,');
      SQL.Add('Latestcost               DOUBLE      DEFAULT 0,');
      SQL.Add('DiffIncome_Landedcost   DOUBLE      DEFAULT 0,');
      SQL.Add('DiffIncome_Latestcost   DOUBLE      DEFAULT 0,');
      SQL.Add('PercentDiffIncomebyLandedcost      DOUBLE      DEFAULT 0,');
      SQL.Add('PercentDiffIncomebyLatestcost      DOUBLE      DEFAULT 0,');
      SQL.Add('FirstColumn              VARCHAR(255),');
      SQL.Add('SecondColumn             VARCHAR(255),');
      SQL.Add('ThirdColumn              VARCHAR(255),');
      SQL.Add('Area                     VARCHAR(255),');
      SQL.Add('CUSTFLD1 VARCHAR(255) NULL DEFAULT NULL,');
      SQL.Add('CUSTFLD2 VARCHAR(255) NULL DEFAULT NULL,');
      SQL.Add('CUSTFLD3 VARCHAR(255) NULL DEFAULT NULL,');
      SQL.Add('CUSTFLD4 VARCHAR(255) NULL DEFAULT NULL,');
      SQL.Add('CUSTFLD5 VARCHAR(255) NULL DEFAULT NULL,');
      SQL.Add('CUSTFLD6 VARCHAR(255) NULL DEFAULT NULL,');
      SQL.Add('CUSTFLD7 VARCHAR(255) NULL DEFAULT NULL,');
      SQL.Add('CUSTFLD8 VARCHAR(255) NULL DEFAULT NULL,');
      SQL.Add('CUSTFLD9 VARCHAR(255) NULL DEFAULT NULL,');
      SQL.Add('CUSTFLD10 VARCHAR(255) NULL DEFAULT NULL,');
      SQL.Add('CUSTFLD11 VARCHAR(255) NULL DEFAULT NULL,');
      SQL.Add('CUSTFLD12 VARCHAR(255) NULL DEFAULT NULL,');
      SQL.Add('CUSTFLD13 VARCHAR(255) NULL DEFAULT NULL,');
      SQL.Add('CUSTFLD14 VARCHAR(255) NULL DEFAULT NULL,');
      SQL.Add('CUSTFLD15 VARCHAR(255) NULL DEFAULT NULL,');
      SQL.Add('INDEX    CompanyNameIndex (CompanyName),');
      SQL.Add('INDEX    SaleIDIndex (SaleID),');
      SQL.Add('INDEX    LineIDIndex (LineID),');
      SQL.Add('INDEX    TransactionTypeIndex (TransactionType),');
      SQL.Add('PRIMARY KEY (ID)) ENGINE=MyISAM;');

      Execute;
    end;

  finally
    LScript.Free;
  end;

end;

procedure TJobProfitability.PopulateData;
var
  ScriptMain: TERPScript;

  procedure AddDateFilter(const Filterfieldname :STring);
  begin
    ScriptMain.SQL.Add('AND ' + Filterfieldname + ' BETWEEN ' +
      QuotedStr(formatDatetime(MysqlDateTimeFormat, DateFrom)) +
      ' AND ' + QuotedStr(formatDatetime(MysqlDateTimeFormat, Dateto)) + '');
  end;

  Procedure AddSales;
  begin
    ScriptMain.SQL.Add('/*SALES*/');
    ScriptMain.SQL.Add('SELECT');
    ScriptMain.SQL.Add('0                                AS Details,');
    ScriptMain.SQL.Add(Splitfield('C' , 'Company',1) +'  AS CompanyName,');
    ScriptMain.SQL.Add('C.JobName                        as JobName, ');
    ScriptMain.SQL.Add('C.JobNumber                      AS JobNumber, ');
    ScriptMain.SQL.Add('s.SaleID                         as SaleID,');
    ScriptMain.SQL.Add(ProductQtyLib.SaleType +       '  as "TransactionType",');
    ScriptMain.SQL.Add('s.ClientID                       as ClientID, ');
    ScriptMain.SQL.Add('InvoiceDocNumber                 as TransactionNo,');
    ScriptMain.SQL.Add('If(s.IsInvoice="T" , Sum(sl.LineCost * Shipped), IF(s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T",  Sum(sl.LineCost * Shipped), Sum(0.00))) AS "CostEx",');
    ScriptMain.SQL.Add('IF(s.IsInvoice="T" , Sum(sl.TotalLineAmount)   , IF(s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T",  Sum(sl.TotalLineAmount)   , Sum(0.00))) as "IncomeEx",');
    ScriptMain.SQL.Add('IF(s.IsQuote="T"   , Sum(sl.TotalLineAmount)   , Sum(0.00)) as "Quotedex",');
    ScriptMain.SQL.Add('0.00                             AS "DebitEx",');
    ScriptMain.SQL.Add('0.00                             AS "CreditEx",');
    ScriptMain.SQL.Add('IF((s.IsInvoice="T" OR s.IsQuote="T") ,  Sum(sl.TotalLineAmount)-Sum(sl.LineCost*Shipped)                                   '+',IF(s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T"'+',      Sum(sl.TotalLineAmount)-Sum(sl.LineCost*Shipped)                                   '+', Sum(0.00))) as "DiffIncome_Cost",');
    ScriptMain.SQL.Add('IF((s.IsInvoice="T" OR s.IsQuote="T") ,if(ifnull(sl.LineCost,0)=0,100, ((Sum(sl.TotalLineAmount)-Sum(sl.LineCost*Shipped)) / Sum(sl.LineCost*Shipped))*100)'+',IF(s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T"'+',      if(ifnull(sl.LineCost,0)=0,100,((Sum(sl.TotalLineAmount)-Sum(sl.LineCost*Shipped)) / Sum(sl.LineCost*Shipped))*100)'+', Sum(0.00))) as "PercentDiffIncomebyCost",');
    ScriptMain.SQL.Add('0.00                             as "DiffQuote_Cost",');
    ScriptMain.SQL.Add('0.00                             as "PercentDiffQuotebyCost",');
    ScriptMain.SQL.Add('Sum(IF(sl.Invoiced = "F", sl.QtySold, 0.00)) As "Backorders", ');
    ScriptMain.SQL.Add('0.00                             AS "ProfitPercent", ');
    ScriptMain.SQL.Add('0.00 as ProfitDollars,');
    ScriptMain.SQL.Add('sl.SaleLineID                    AS LineID,');
    ScriptMain.SQL.Add('SPACE(255)                       AS Department,');
    ScriptMain.SQL.Add('SPACE(60)                        AS "ProductName",');
    ScriptMain.SQL.Add('SPACE(255)                       AS "FirstColumn",');
    ScriptMain.SQL.Add('SPACE(255)                       AS "SecondColumn",');
    ScriptMain.SQL.Add('SPACE(255)                       AS "ThirdColumn",');
    ScriptMain.SQL.Add('SPACE(255)                       AS "Area",');
//    ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
//    ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
//    ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
    ScriptMain.SQL.Add('C.CUSTFLD1, C.CUSTFLD2, C.CUSTFLD3, C.CUSTFLD4, C.CUSTFLD5,');
    ScriptMain.SQL.Add('C.CUSTFLD6, C.CUSTFLD7, C.CUSTFLD8, C.CUSTFLD9, C.CUSTFLD10,');
    ScriptMain.SQL.Add('C.CUSTFLD11, C.CUSTFLD12, C.CUSTFLD13, C.CUSTFLD14, C.CUSTFLD15');
    ScriptMain.SQL.Add('FROM tblSales s '+
                'INNER JOIN tblSalesLines sl on (s.SaleID = sl.SaleID) '+
                'INNER JOIN tblclients C on C.ClientID = s.ClientID');
    ScriptMain.SQL.Add('WHERE (IsRefund="T" or IsInvoice="T" or IsCashSale="T" or s.IsQuote="T")  '+
                'AND ((s.Converted="T" AND s.Deleted="T") OR s.Deleted <> "T")');
    AdddateFilter('s.SaleDate');
    if fClientID <> 0 then
      ScriptMain.SQL.Add('AND s.ClientID=' + IntToStr(fClientID));
    ScriptMain.SQL.Add('GROUP By s.ClientID, s.IsInvoice, s.IsQuote');
  end;

  Procedure AddPOs;
  begin
    ScriptMain.SQL.Add('/*PURCHASES*/');
    ScriptMain.SQL.Add('SELECT STRAIGHT_JOIN 0, ');
    ScriptMain.SQL.Add(Splitfield('C' , 'Company',1) +' AS CompanyName,');
    ScriptMain.SQL.Add('JobName, C.JobNumber, P.PurchaseOrderID,');
    ScriptMain.SQL.Add('if(IsPO="T" , "Purchase Order" , if(IsBill="T" , "Bill" , if(IsCredit="T" ,"Credit" , if(IsCheque="T" , "Cheque" , "")))) as "TransactionType",');
    ScriptMain.SQL.Add('PL.CustomerJobID, PurchaseOrderNumber as InvoiceNo,');
    ScriptMain.SQL.Add('Sum(TotalLineAmount) as "CostEx",');
    ScriptMain.SQL.Add('0.00 as "IncomeEx", 0.00 as "Quotedex",');
    ScriptMain.SQL.Add('0.00 AS "DebitEx",');
    ScriptMain.SQL.Add('0.00 AS "CreditEx",');
    ScriptMain.SQL.Add('Sum(TotalLineAmount)-Sum(0.00) as "DiffIncome_Cost",');
    ScriptMain.SQL.Add('(Sum(TotalLineAmount)-Sum(0.00))/Sum(0.00)*100 as "PercentDiffIncomebyCost",');
    ScriptMain.SQL.Add('0.00 as "DiffQuote_Cost", 0.00 as "PercentDiffQuotebyCost",');
    ScriptMain.SQL.Add('Sum(PL.Backorder) AS "Backorders", 0.00 AS "ProfitPercent",');
    ScriptMain.SQL.Add('0.00 as ProfitDollars,');
    ScriptMain.SQL.Add('PL.PurchaseLineID,');
    ScriptMain.SQL.Add('SPACE(255) AS Department,');
    ScriptMain.SQL.Add('SPACE(60) AS "ProductName",');
    ScriptMain.SQL.Add('SPACE(255) AS "FirstColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "SecondColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "ThirdColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "Area",');
//    ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
//    ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
//    ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
    ScriptMain.SQL.Add('C.CUSTFLD1, C.CUSTFLD2, C.CUSTFLD3, C.CUSTFLD4, C.CUSTFLD5,');
    ScriptMain.SQL.Add('C.CUSTFLD6, C.CUSTFLD7, C.CUSTFLD8, C.CUSTFLD9, C.CUSTFLD10,');
    ScriptMain.SQL.Add('C.CUSTFLD11, C.CUSTFLD12, C.CUSTFLD13, C.CUSTFLD14, C.CUSTFLD15');
    ScriptMain.SQL.Add('FROM tblpurchaseorders P');
    ScriptMain.SQL.Add('INNER JOIN tblpurchaselines PL on P.PurchaseOrderID = PL.PurchaseOrderID');
    ScriptMain.SQL.Add('INNER JOIN tblclients C on C.ClientID = PL.CustomerJobID');
    ScriptMain.SQL.Add('WHERE (IsPO="T" or IsBill="T" or IsCredit="T" or IsCheque="T") AND NOT ISNULL(Company) AND P.Deleted <> "T" And UseTimeCost <> "T"');

    if fInvoiceDate then Adddatefilter('P.invoicedate') else Adddatefilter('P.OrderDate');
    if fClientID <> 0 then
      ScriptMain.SQL.Add('AND s.ClientID=' + IntToStr(fClientID));
    ScriptMain.SQL.Add('GROUP BY  CompanyName, jobname');
  end;

  Procedure AddPays;
  begin
    ScriptMain.SQL.Add('/*PAYS*/');
    ScriptMain.SQL.Add('SELECT 0,');
    ScriptMain.SQL.Add(Splitfield('C', 'Company',1) +' AS CompanyName,');
    ScriptMain.SQL.Add('JobName, C.JobNumber, P.PayID, IF(C.Burden > 0, CONCAT("Payroll + ", CONVERT(C.Burden, CHAR), "%"), "Payroll") AS TransactionType,');
    ScriptMain.SQL.Add('PL.ClientID, 0 AS InvoiceNo, SUM(LineTotal) * (1 + C.Burden/100) AS "CostEx",');
    ScriptMain.SQL.Add('0.00 AS "IncomeEx", 0.00 as "Quotedex",');
    ScriptMain.SQL.Add('0.00 AS "DebitEx",');
    ScriptMain.SQL.Add('0.00 AS "CreditEx",');
    ScriptMain.SQL.Add('Sum(LineTotal) - Sum(0.00) AS "DiffIncome_Cost",');
    ScriptMain.SQL.Add('(Sum(LineTotal) - Sum(0.00)) / Sum(0.00) * 100 AS "PercentDiffIncomebyCost",');
    ScriptMain.SQL.Add('0.00 as "DiffQuote_Cost", 0.00 as "PercentDiffQuotebyCost",');
    ScriptMain.SQL.Add('0.00 AS "Backorders", 0.00 AS "ProfitPercent",');
    ScriptMain.SQL.Add('0.00 as ProfitDollars,');
    ScriptMain.SQL.Add('PL.PaysPayRateID,');
    ScriptMain.SQL.Add('PL.ClassName AS Department,');
    ScriptMain.SQL.Add('SPACE(60) AS "ProductName",');
    ScriptMain.SQL.Add('SPACE(255) AS "FirstColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "SecondColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "ThirdColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "Area",');
//    ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
//    ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
//    ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
    ScriptMain.SQL.Add('C.CUSTFLD1, C.CUSTFLD2, C.CUSTFLD3, C.CUSTFLD4, C.CUSTFLD5,');
    ScriptMain.SQL.Add('C.CUSTFLD6, C.CUSTFLD7, C.CUSTFLD8, C.CUSTFLD9, C.CUSTFLD10,');
    ScriptMain.SQL.Add('C.CUSTFLD11, C.CUSTFLD12, C.CUSTFLD13, C.CUSTFLD14, C.CUSTFLD15');
    ScriptMain.SQL.Add('FROM tblpays P');
    ScriptMain.SQL.Add('INNER JOIN tblpayspayrates PL on (P.PayID = PL.PayID) AND (NOT ISNULL(PL.ClientID) AND PL.ClientID <> "")');
    //ScriptMain.SQL.Add('INNER JOIN tblTimeSheets T ON (PL.TimeSheetId = T.ID) AND ((T.SalesId < 1) OR ISNULL(T.SalesId))');
    ScriptMain.SQL.Add('LEFT JOIN tblTimeSheets T ON (PL.TimeSheetId = T.ID)');

    ScriptMain.SQL.Add('INNER JOIN tblclients C on C.ClientID = PL.ClientID');
    ScriptMain.SQL.Add('WHERE (Paid = "T") AND P.Deleted="F" ');
    ScriptMain.SQL.Add('and ((IfNull(PL.TimeSheetId,0) = 0) or ((T.SalesId < 1) OR ISNULL(T.SalesId)))');
    Adddatefilter('P.DatePaid');

    if fClientID <> 0 then
      ScriptMain.SQL.Add('AND s.ClientID=' + IntToStr(fClientID));
    ScriptMain.SQL.Add('GROUP BY C.ClientID');
  end;

  Procedure AddTimesheets;
  begin
    ScriptMain.SQL.Add('/*TIMESHEETS*/');
    ScriptMain.SQL.Add('SELECT 0,');
    ScriptMain.SQL.Add(Splitfield('C' , 'Company',1) +' AS CompanyName,');
    ScriptMain.SQL.Add('JobName, C.JobNumber,P.ID, ');
    ScriptMain.SQL.Add(' #P.EmployeeID,');
    ScriptMain.SQL.Add(' "Timesheet" AS "TransactionType",');
    ScriptMain.SQL.Add('P.JobID, 0 AS InvoiceNo, ');
    ScriptMain.SQL.Add('IF(P.JobID > 0, Sum(P.Total), Sum(0.00)) AS "CostEx",');
    ScriptMain.SQL.Add('0.00 AS "IncomeEx", 0.00 as "Quotedex",');
    ScriptMain.SQL.Add('0.00 AS "DebitEx",');
    ScriptMain.SQL.Add('0.00 AS "CreditEx",');
    ScriptMain.SQL.Add('Sum(Total) - Sum(0.00) AS "DiffIncome_Cost",');
    ScriptMain.SQL.Add('(Sum(Total) - Sum(0.00)) / Sum(0.00) * 100 AS "PercentDiffIncomebyCost",');
    ScriptMain.SQL.Add('0.00 as "DiffQuote_Cost", 0.00 as "PercentDiffQuotebyCost",');
    ScriptMain.SQL.Add('0.00 AS "Backorders", 0.00 AS "ProfitPercent",');
    ScriptMain.SQL.Add('0.00 as ProfitDollars,');
    ScriptMain.SQL.Add('P.ID,');
    ScriptMain.SQL.Add('SPACE(255) AS Department,');
    ScriptMain.SQL.Add('SPACE(60) AS "ProductName",');
    ScriptMain.SQL.Add('SPACE(255) AS "FirstColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "SecondColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "ThirdColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "Area",');
//    ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
//    ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
//    ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
    ScriptMain.SQL.Add('C.CUSTFLD1, C.CUSTFLD2, C.CUSTFLD3, C.CUSTFLD4, C.CUSTFLD5,');
    ScriptMain.SQL.Add('C.CUSTFLD6, C.CUSTFLD7, C.CUSTFLD8, C.CUSTFLD9, C.CUSTFLD10,');
    ScriptMain.SQL.Add('C.CUSTFLD11, C.CUSTFLD12, C.CUSTFLD13, C.CUSTFLD14, C.CUSTFLD15');
    ScriptMain.SQL.Add('FROM tbltimesheets P');
    ScriptMain.SQL.Add('INNER JOIN tblclients C on C.ClientID = P.JobID');
    ScriptMain.SQL.Add('WHERE (P.Active = "T" AND P.JobID > 0)');
    Adddatefilter('P.ServiceDate');

    if fClientID <> 0 then
      ScriptMain.SQL.Add('AND s.ClientID=' + IntToStr(fClientID));
    ScriptMain.SQL.Add('GROUP BY P.JobID');
  end;

  Procedure AddJournalEnties;
  begin
      ScriptMain.SQL.Add('/*JOURNALENTRIES*/');
      ScriptMain.SQL.Add('SELECT DISTINCT 0,');
      ScriptMain.SQL.Add(Splitfield('C' , 'Company',1) +' AS CompanyName,');
      ScriptMain.SQL.Add('JobName, C.JobNumber, JED.GJID, ');
      ScriptMain.SQL.Add('"Journal entry" AS "TransactionType",');
      ScriptMain.SQL.Add('JED.ClientID,');
      ScriptMain.SQL.Add('0 as Invoiceno,');
      ScriptMain.SQL.Add('IF(JED.clientID > 0, Sum(JED.CreditAmount - JED.DebitAmount), sum(0)) AS CostEx,');
      ScriptMain.SQL.Add('0 AS IncomeEx,');
      ScriptMain.SQL.Add('0 AS Quotedex,');
      ScriptMain.SQL.Add('sum(JED.DebitAmount) AS DebitEx,');
      ScriptMain.SQL.Add('sum(JED.CreditAmount) AS CreditEx,');
      ScriptMain.SQL.Add('IF(JED.clientID > 0, Sum(JED.CreditAmount - JED.DebitAmount), sum(0))  AS DiffIncome_Cost ,');
      ScriptMain.SQL.Add('IF(JED.clientID > 0, Sum(JED.CreditAmount - JED.DebitAmount), sum(0))   as PercentDiffIncomebyCost,');
      ScriptMain.SQL.Add('0 AS DiffQuote_Cost,');
      ScriptMain.SQL.Add('0 AS PercentDiffQuotebyCost,');
      ScriptMain.SQL.Add('0 AS Backorders,');
      ScriptMain.SQL.Add('0 AS ProfitPercent,');
      ScriptMain.SQL.Add('0 AS ProfitDollars,');
      ScriptMain.SQL.Add('JED.GJDID,');
      ScriptMain.SQL.Add('JED.ClassName ,');
      ScriptMain.SQL.Add('"" AS ProductName,');
      ScriptMain.SQL.Add('"" AS FirstColumn,');
      ScriptMain.SQL.Add('"" AS SecondColumn,');
      ScriptMain.SQL.Add('"" AS ThirdColumn,');
      ScriptMain.SQL.Add('"" AS Area,');
//          ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
//          ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
//          ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
      ScriptMain.SQL.Add('C.CUSTFLD1, C.CUSTFLD2, C.CUSTFLD3, C.CUSTFLD4, C.CUSTFLD5,');
      ScriptMain.SQL.Add('C.CUSTFLD6, C.CUSTFLD7, C.CUSTFLD8, C.CUSTFLD9, C.CUSTFLD10,');
      ScriptMain.SQL.Add('C.CUSTFLD11, C.CUSTFLD12, C.CUSTFLD13, C.CUSTFLD14, C.CUSTFLD15');
      ScriptMain.SQL.Add('FROM tblgeneraljournaldetails JED '+
                          ' INNER JOIN tblgeneraljournal JE ON JED.GJID = JE.GJID  '+
                          ' INNER JOIN tblclients C ON JED.ClientID = C.ClientID');
      ScriptMain.SQL.Add('WHERE (JED.clientID > 0)');
      Adddatefilter('JE.TransactionDate');

      if fClientID <> 0 then
        ScriptMain.SQL.Add('AND s.ClientID=' + IntToStr(fClientID));
      ScriptMain.SQL.Add('GROUP BY JED.ClientID');
  end;

  Procedure Addrepairs;
  begin
    ScriptMain.SQL.Add('/*REPAIRS*/');
    ScriptMain.SQL.Add('SELECT');
    ScriptMain.SQL.Add('0 AS Details,' +Splitfield('C' , 'Company',1) +' ,C.JobName,');
    ScriptMain.SQL.Add('C.JobNumber,R.RepairID,"Repair" AS "TransactionType",');
    ScriptMain.SQL.Add('R.CusID,R.RepairID AS transactionno, sum(RP.Linecost*RP.Qty) AS "CostEx",');
    ScriptMain.SQL.Add('Sum(RP.PriceEx*RP.Qty) as "Income(Ex)",0 as "DebitEx" , 0 as "CreditEx", ');
    ScriptMain.SQL.Add('sum(RP.Linecost*RP.Qty) -Sum(RP.PriceEx*RP.Qty)  as "DiffIncome_Cost",');
    ScriptMain.SQL.Add(' ((sum(RP.Linecost*RP.Qty) -Sum(RP.PriceEx*RP.Qty) ) / Sum(RP.PriceEx*RP.Qty))*100,');
    ScriptMain.SQL.Add(' ((sum(RP.Linecost*RP.Qty) -Sum(RP.PriceEx*RP.Qty) ) / Sum(RP.PriceEx*RP.Qty))*100 as "PercentDiffIncomebyCost",');
    ScriptMain.SQL.Add('0.00 as "DiffQuote_Cost",0.00 as "PercentDiffQuotebyCost",');
    ScriptMain.SQL.Add('0 As "Backorders", 0.00 AS "ProfitPercent",');
    ScriptMain.SQL.Add('0.00 as ProfitDollars,');
    ScriptMain.SQL.Add('RP.RepairPartsID AS LineID,');
    ScriptMain.SQL.Add('SPACE(255) AS Department,SPACE(60) AS "ProductName",');
    ScriptMain.SQL.Add('SPACE(255) AS "FirstColumn",SPACE(255) AS "SecondColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "ThirdColumn",SPACE(255) AS "Area",');
    ScriptMain.SQL.Add('R.CUSTFLD1, R.CUSTFLD2, R.CUSTFLD3, R.CUSTFLD4, R.CUSTFLD5,');
    ScriptMain.SQL.Add('R.CUSTFLD6, R.CUSTFLD7, R.CUSTFLD8, R.CUSTFLD9, R.CUSTFLD10,');
    ScriptMain.SQL.Add('R.CUSTFLD11, R.CUSTFLD12, R.CUSTFLD13, R.CUSTFLD14, R.CUSTFLD15');
    ScriptMain.SQL.Add('FROM tblrepairs AS R');
    ScriptMain.SQL.Add('Inner Join tblrepairparts AS RP ON R.RepairID = RP.RepairID');
    ScriptMain.SQL.Add('Inner Join tblclients C ON  R.CusID = C.ClientID');
    ScriptMain.SQL.Add('WHERE R.converted = "F"');
    Adddatefilter('RP.PartIssuedON');
    if fClientID <> 0 then
      ScriptMain.SQL.Add('AND s.ClientID=' + IntToStr(fClientID));
    ScriptMain.SQL.Add('GROUP By R.CusId');
  end;

  procedure AddStockAdjust;
  begin
    ScriptMain.SQL.Add('/*STOCKADJUST*/');
    ScriptMain.SQL.Add('SELECT 0,');
    ScriptMain.SQL.Add('c.Company AS CompanyName,');
    ScriptMain.SQL.Add('c.JobName, c.JobNumber, s.StockAdjustEntryID, "Stock Adjustment" AS "TransactionType",');
    ScriptMain.SQL.Add('c.ClientID, 0 AS InvoiceNo, Sum(sl.Cost) AS "CostEx",');
    ScriptMain.SQL.Add('0.00 AS "IncomeEx", 0.00 as "Quotedex",');
    ScriptMain.SQL.Add('0.00 AS "DebitEx",');
    ScriptMain.SQL.Add('0.00 AS "CreditEx",');
    ScriptMain.SQL.Add('SUM(sl.Cost) - SUM(0.00) AS "DiffIncome_Cost",');
    ScriptMain.SQL.Add('(SUM(sl.Cost) - SUM(0.00)) / SUM(sl.Cost) * 100 AS "PercentDiffIncomebyCost",');
    ScriptMain.SQL.Add('0.00 as "DiffQuote_Cost", 0.00 as "PercentDiffQuotebyCost",');
    ScriptMain.SQL.Add('0.00 AS "Backorders", 0.00 AS "ProfitPercent",');
    ScriptMain.SQL.Add('0.00 as ProfitDollars,');
    ScriptMain.SQL.Add('c.ClientID,');
    ScriptMain.SQL.Add('sl.ClassName AS Department,');
    ScriptMain.SQL.Add('sl.ProductName AS "ProductName",');
    ScriptMain.SQL.Add('SPACE(255) AS "FirstColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "SecondColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "ThirdColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "Area",');
    ScriptMain.SQL.Add('c.CUSTFLD1, c.CUSTFLD2, c.CUSTFLD3, c.CUSTFLD4, c.CUSTFLD5,');
    ScriptMain.SQL.Add('c.CUSTFLD6, c.CUSTFLD7, c.CUSTFLD8, c.CUSTFLD9, c.CUSTFLD10,');
    ScriptMain.SQL.Add('c.CUSTFLD11, c.CUSTFLD12, c.CUSTFLD13, c.CUSTFLD14, c.CUSTFLD15');
    ScriptMain.SQL.Add('FROM tblstockadjustentrylines sl');
    ScriptMain.SQL.Add('INNER JOIN tblstockadjustentry s USING(StockAdjustEntryID)');
    ScriptMain.SQL.Add('INNER JOIN tblclients c ON c.ClientID = sl.JobID');
    ScriptMain.SQL.Add('WHERE sl.Deleted="F" AND s.Deleted="F"');
    Adddatefilter('s.Adjustmentdate');

    if fClientID <> 0 then
      ScriptMain.SQL.Add('AND s.ClientID=' + IntToStr(fClientID));
    ScriptMain.SQL.Add('GROUP BY c.ClientID');
  end;

  procedure AddAllowances;
  begin
    ScriptMain.SQL.Add('/*ALLOWANCES*/');
    ScriptMain.SQL.Add('SELECT 0,');
    ScriptMain.SQL.Add('c.Company AS CompanyName,');
    ScriptMain.SQL.Add('c.JobName, c.JobNumber, a.PayAllowanceID, "Payroll-Other" AS TransactionType,');
    ScriptMain.SQL.Add('c.ClientID, 0 AS InvoiceNo, SUM(a.Qty * a.Amount) AS CostEx,');
    ScriptMain.SQL.Add('0.00 AS IncomeEx, 0.00 as Quotedex,');
    ScriptMain.SQL.Add('0.00 AS DebitEx,');
    ScriptMain.SQL.Add('0.00 AS CreditEx,');
    ScriptMain.SQL.Add('SUM(a.Qty * a.Amount) - SUM(0.00) AS DiffIncome_Cost,');
    ScriptMain.SQL.Add('(SUM(a.Qty * a.Amount) - SUM(0.00)) / SUM(a.Qty * a.Amount) * 100 AS PercentDiffIncomebyCost,');
    ScriptMain.SQL.Add('0.00 as DiffQuote_Cost, 0.00 as PercentDiffQuotebyCost,');
    ScriptMain.SQL.Add('0.00 AS Backorders, 0.00 AS ProfitPercent,');
    ScriptMain.SQL.Add('0.00 as ProfitDollars,');
    ScriptMain.SQL.Add('c.ClientID,');
    ScriptMain.SQL.Add('a.ClassName AS Department,');
    ScriptMain.SQL.Add('"" AS ProductName,');
    ScriptMain.SQL.Add('SPACE(255) AS FirstColumn,');
    ScriptMain.SQL.Add('SPACE(255) AS SecondColumn,');
    ScriptMain.SQL.Add('SPACE(255) AS ThirdColumn,');
    ScriptMain.SQL.Add('SPACE(255) AS Area,');
    ScriptMain.SQL.Add('c.CUSTFLD1, c.CUSTFLD2, c.CUSTFLD3, c.CUSTFLD4, c.CUSTFLD5,');
    ScriptMain.SQL.Add('c.CUSTFLD6, c.CUSTFLD7, c.CUSTFLD8, c.CUSTFLD9, c.CUSTFLD10,');
    ScriptMain.SQL.Add('c.CUSTFLD11, c.CUSTFLD12, c.CUSTFLD13, c.CUSTFLD14, c.CUSTFLD15');
    ScriptMain.SQL.Add('FROM tblpaysallowances a');
    ScriptMain.SQL.Add('INNER JOIN tblclients c ON c.ClientID = a.ClientID');
    ScriptMain.SQL.Add('INNER JOIN tblpays p ON a.PayID=p.PayID');
    ScriptMain.SQL.Add('WHERE a.TaxExempt="T" AND p.Paid="T" AND p.Deleted="F"');
    AddDateFilter('p.DatePaid');

    if fClientID <> 0 then
      ScriptMain.SQL.Add('AND s.ClientID=' + IntToStr(fClientID));
    ScriptMain.SQL.Add('GROUP BY c.ClientID');
  end;

  Procedure AddsalesDetails;
  begin
      ScriptMain.SQL.Add('/*SALES DETAILS*/');
      ScriptMain.SQL.Add('SELECT');
      ScriptMain.SQL.Add('1 AS Details,S.Saledate,');
      ScriptMain.SQL.Add(Splitfield('C' , 'Company',1) +' AS CompanyName,');
      ScriptMain.SQL.Add('JobName, C.JobNumber, s.SaleID,');
      ScriptMain.SQL.Add(SaleType + ' as "TransactionType",');
      ScriptMain.SQL.Add('s.ClientID, InvoiceDocNumber AS TransactionNo,');

      ScriptMain.SQL.Add('IF(s.IsInvoice="T" , sl.LineCost * Shipped, IF(s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T", sl.LineCost * Shipped, 0.00)) AS "CostEx",');
      ScriptMain.SQL.Add('IF(s.IsInvoice="T" , sl.TotalLineAmount, IF(s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T", sl.TotalLineAmount, 0.00)) as "IncomeEx",');
      ScriptMain.SQL.Add('IF(s.IsQuote="T" , sl.TotalLineAmount, 0.00) as "Quotedex",');

      ScriptMain.SQL.Add('0.00 AS "DebitEx",');
      ScriptMain.SQL.Add('0.00 AS "CreditEx",');
      ScriptMain.SQL.Add('IF((s.IsInvoice="T" OR s.IsQuote="T") , sl.TotalLineAmount-sl.LineCost*Shipped, IF(s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T", sl.TotalLineAmount-sl.LineCost*Shipped, 0.00)) as "DiffIncome_Cost",');
      ScriptMain.SQL.Add('IF((s.IsInvoice="T" OR s.IsQuote="T") , ((sl.TotalLineAmount-sl.LineCost*Shipped) / sl.LineCost*Shipped)*100,');
      ScriptMain.SQL.Add('IF(s.IsRefund="T" OR s.IsCashSale="T" OR s.IsPOS="T", ((sl.TotalLineAmount-sl.LineCost*Shipped) / sl.LineCost*Shipped)*100, 0.00)) as "PercentDiffIncomebyCost",');
      ScriptMain.SQL.Add('IF(s.IsQuote="T" , sl.TotalLineAmount-sl.LineCost*Shipped, 0.00) AS "DiffIncome_Quote",');
      ScriptMain.SQL.Add('IF(s.IsQuote="T" , ((sl.TotalLineAmount-sl.LineCost*Shipped) / (sl.LineCost*Shipped))*100, 0.00) AS "PercentDiffIncomebyQuote",');
      ScriptMain.SQL.Add('0.00 AS "DiffQuote_Cost",');
      ScriptMain.SQL.Add('0.00 AS "PercentDiffQuotebyCost",');

      ScriptMain.SQL.Add('IF(sl.Invoiced = "F" AND s.IsInvoice="T" , sl.QtySold, 0) AS "Backorders",');
      ScriptMain.SQL.Add('0.00 AS "ProfitPercent",');
      ScriptMain.SQL.Add('0.00 as ProfitDollars,');
      ScriptMain.SQL.Add('sl.SaleLineID AS LineID,');
      ScriptMain.SQL.Add('s.Class AS Department,');
      ScriptMain.SQL.Add('sl.ProductName AS "ProductName",');
      ScriptMain.SQL.Add('sl.ProductId as ProductID,');
      ScriptMain.SQL.Add('sl.QtySold as QtyOrdered,');
      ScriptMain.SQL.Add('sl.Shipped as QtyShipped,');
      ScriptMain.SQL.Add('sl.BackOrder as QtyBackOrder,');
      ScriptMain.SQL.Add(Firstcolumn('tp') + ' AS FirstColumn, ');
      ScriptMain.SQL.Add(Secondcolumn('tp')+ ' AS SecondColumn, ');
      ScriptMain.SQL.Add(Thirdcolumn('tp') + ' AS ThirdColumn, ');
      ScriptMain.SQL.Add('tp.Area AS "Area",');
      ScriptMain.SQL.Add('C.CUSTFLD1, C.CUSTFLD2, C.CUSTFLD3, C.CUSTFLD4, C.CUSTFLD5,');
      ScriptMain.SQL.Add('C.CUSTFLD6, C.CUSTFLD7, C.CUSTFLD8, C.CUSTFLD9, C.CUSTFLD10,');
      ScriptMain.SQL.Add('C.CUSTFLD11, C.CUSTFLD12, C.CUSTFLD13, C.CUSTFLD14, C.CUSTFLD15');
      ScriptMain.SQL.Add('FROM tblSales s');
      ScriptMain.SQL.Add('INNER JOIN tblSalesLines sl on s.SaleID = sl.SaleID');
      ScriptMain.SQL.Add('INNER JOIN tblparts tp on tp.PartsID = sl.ProductID');
      ScriptMain.SQL.Add('LEFT JOIN tblclients C on C.ClientID = s.ClientID');
      ScriptMain.SQL.Add
      ('WHERE (IsRefund="T" or IsInvoice="T" or IsCashSale="T" or s.IsQuote="T") AND ((s.Converted="T" AND s.Deleted="T") OR s.Deleted <> "T")');
      Adddatefilter('s.SaleDate');

      if fClientID <> 0 then
        ScriptMain.SQL.Add('AND s.ClientID=' + IntToStr(fClientID));
  end;

  Procedure AddPODetails;
  begin
      ScriptMain.SQL.Add('/*PURCHASE DETAILS*/');
      ScriptMain.SQL.Add('SELECT');
      ScriptMain.SQL.Add('STRAIGHT_JOIN 1,P.Orderdate,');
      ScriptMain.SQL.Add(Splitfield('C' , 'Company',1) +' AS CompanyName,');
      ScriptMain.SQL.Add('JobName, C.JobNumber, P.PurchaseOrderID,');
      (* ScriptMain.SQL.Add(ProductQtyLib.POType + ' as "TransactionType",'); *)
      ScriptMain.SQL.Add('if(IsPO="T" , "Purchase Order" , if(IsBill="T" , "Bill" , if(IsCredit="T" ,"Credit" , if(IsCheque="T" , "Cheque" , "")))) as "TransactionType",');
      ScriptMain.SQL.Add('PL.CustomerJobID, PurchaseOrderNumber AS InvoiceNo,');
      ScriptMain.SQL.Add('TotalLineAmount AS "CostEx",');
      ScriptMain.SQL.Add('0.00 AS "IncomeEx",');
      ScriptMain.SQL.Add('0.00 AS "Quotedex",');
      ScriptMain.SQL.Add('0.00 AS "DebitEx",');
      ScriptMain.SQL.Add('0.00 AS "CreditEx",');
      ScriptMain.SQL.Add('TotalLineAmount AS "DiffIncome_Cost",');
      ScriptMain.SQL.Add('TotalLineAmount AS "PercentDiffIncomebyCost",');
      ScriptMain.SQL.Add('0.00 AS "DiffIncome_Quote",');
      ScriptMain.SQL.Add('0.00 AS "PercentDiffIncomebyQuote",');
      ScriptMain.SQL.Add('0.00 AS "DiffQuote_Cost",');
      ScriptMain.SQL.Add('0.00 AS "PercentDiffQuotebyCost",');
      ScriptMain.SQL.Add('PL.Backorder AS "Backorders", 0.00 AS "ProfitPercent",');
      ScriptMain.SQL.Add('0.00 as ProfitDollars,');
      ScriptMain.SQL.Add('PL.PurchaseLineID,');
      ScriptMain.SQL.Add('PL.Class AS Department,');
      ScriptMain.SQL.Add('PL.ProductName AS "ProductName",');
      ScriptMain.SQL.Add('Pl.ProductId as ProductID,');
      ScriptMain.SQL.Add('Pl.QtySold as QtyOrdered,');
      ScriptMain.SQL.Add('Pl.Shipped as QtyShipped,');
      ScriptMain.SQL.Add('Pl.BackOrder as QtyBackOrder,');
      ScriptMain.SQL.Add(Firstcolumn('tp') + ' AS FirstColumn, ');
      ScriptMain.SQL.Add(Secondcolumn('tp')+ ' AS SecondColumn, ');
      ScriptMain.SQL.Add(Thirdcolumn('tp') + ' AS ThirdColumn, ');
      ScriptMain.SQL.Add('tp.Area AS "Area",');
      ScriptMain.SQL.Add('C.CUSTFLD1, C.CUSTFLD2, C.CUSTFLD3, C.CUSTFLD4, C.CUSTFLD5,');
      ScriptMain.SQL.Add('C.CUSTFLD6, C.CUSTFLD7, C.CUSTFLD8, C.CUSTFLD9, C.CUSTFLD10,');
      ScriptMain.SQL.Add('C.CUSTFLD11, C.CUSTFLD12, C.CUSTFLD13, C.CUSTFLD14, C.CUSTFLD15');
      ScriptMain.SQL.Add('FROM tblpurchaseorders P');
      ScriptMain.SQL.Add('INNER JOIN tblpurchaselines PL on P.PurchaseOrderID = PL.PurchaseOrderID');
      ScriptMain.SQL.Add('INNER JOIN tblparts tp on tp.PartsID = PL.ProductID');
      ScriptMain.SQL.Add('INNER JOIN tblclients C on C.ClientID = PL.CustomerJobID');
      ScriptMain.SQL.Add('WHERE (IsPO="T" or IsBill="T"or IsCredit="T" or IsCheque="T") AND NOT ISNULL(PL.ProductID) AND NOT ISNULL(Company) AND P.Deleted <> "T" AND UseTimeCost <> "T"');
      if IsInvoiceDate then Adddatefilter('P.invoicedate') else Adddatefilter('P.OrderDate');
      if fClientID <> 0 then
        ScriptMain.SQL.Add('AND s.ClientID=' + IntToStr(fClientID));
      ScriptMain.SQL.Add('UNION ALL');
      ScriptMain.SQL.Add('SELECT');
      ScriptMain.SQL.Add('STRAIGHT_JOIN 0,P.OrderDate,');
      ScriptMain.SQL.Add(Splitfield('C' , 'Company',1) +' AS CompanyName,');
      ScriptMain.SQL.Add('JobName, C.JobNumber, P.PurchaseOrderID,');
      (* ScriptMain.SQL.Add(ProductQtyLib.POType + ' as "TransactionType",'); *)
      ScriptMain.SQL.Add('if(IsPO="T" , "Purchase Order" , if(IsBill="T" , "Bill" , if(IsCredit="T" ,"Credit" , if(IsCheque="T" , "Cheque" , "")))) as "TransactionType",');
      ScriptMain.SQL.Add('PL.CustomerJobID, PurchaseOrderNumber AS InvoiceNo,');
      ScriptMain.SQL.Add('TotalLineAmount AS "CostEx",');
      ScriptMain.SQL.Add('0.00 AS "IncomeEx",');
      ScriptMain.SQL.Add('0.00 AS "Quotedex",');
      ScriptMain.SQL.Add('0.00 AS "DebitEx",');
      ScriptMain.SQL.Add('0.00 AS "CreditEx",');
      ScriptMain.SQL.Add('TotalLineAmount AS "DiffIncome_Cost",');
      ScriptMain.SQL.Add('TotalLineAmount AS "PercentDiffIncomebyCost",');
      ScriptMain.SQL.Add('0.00 AS "DiffIncome_Quote",');
      ScriptMain.SQL.Add('0.00 AS "PercentDiffIncomebyQuote",');
      ScriptMain.SQL.Add('0.00 AS "DiffQuote_Cost",');
      ScriptMain.SQL.Add('0.00 AS "PercentDiffQuotebyCost",');
      ScriptMain.SQL.Add('PL.Backorder AS "Backorders", 0.00 AS "ProfitPercent",');
      ScriptMain.SQL.Add('0.00 as ProfitDollars,');
      ScriptMain.SQL.Add('PL.PurchaseLineID,');
      ScriptMain.SQL.Add('PL.Class AS Department,');
      ScriptMain.SQL.Add('PL.ProductName AS "ProductName",');
      ScriptMain.SQL.Add('Pl.ProductId as ProductID,');
      ScriptMain.SQL.Add('Pl.QtySold as QtyOrdered,');
      ScriptMain.SQL.Add('Pl.Shipped as QtyShipped,');
      ScriptMain.SQL.Add('Pl.BackOrder as QtyBackOrder,');
      ScriptMain.SQL.Add('"" AS "FirstColumn",');
      ScriptMain.SQL.Add('"" AS "SecondColumn",');
      ScriptMain.SQL.Add('"" AS "ThirdColumn",');
      ScriptMain.SQL.Add('"" AS "Area",');
      ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
      ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
      ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
      ScriptMain.SQL.Add('FROM tblpurchaseorders P');
      ScriptMain.SQL.Add('INNER JOIN tblpurchaselines PL on P.PurchaseOrderID = PL.PurchaseOrderID');
      ScriptMain.SQL.Add('INNER JOIN tblclients C on C.ClientID = PL.CustomerJobID');
      ScriptMain.SQL.Add('WHERE (IsPO="T" or IsBill="T"or IsCredit="T" or IsCheque="T") AND ISNULL(PL.ProductID) AND NOT ISNULL(Company) AND P.Deleted <> "T" AND UseTimeCost <> "T"');
      if IsInvoiceDate then Adddatefilter('P.invoicedate') else Adddatefilter('P.OrderDate');
      if fClientID <> 0 then
        ScriptMain.SQL.Add('AND s.ClientID=' + IntToStr(fClientID));
  end;

  Procedure AddPayDetails;
  begin
    ScriptMain.SQL.Add('/*PAY DETAILS*/');
    ScriptMain.SQL.Add('SELECT 1,P.PayDate,');
    ScriptMain.SQL.Add(Splitfield('C' , 'Company',1) +' AS CompanyName,');
    ScriptMain.SQL.Add('JobName, C.JobNumber, P.PayID, IF(C.Burden > 0, CONCAT("Payroll + ", CONVERT(C.Burden, CHAR), "%"), "Payroll") AS TransactionType, ');
    ScriptMain.SQL.Add('PL.ClientID, ');
    ScriptMain.SQL.Add('P.PayID AS InvoiceNo,');
    ScriptMain.SQL.Add('LineTotal * (1 + C.Burden/100) AS "CostEx",');
    ScriptMain.SQL.Add('0.00 AS "IncomeEx",');
    ScriptMain.SQL.Add('0.00 AS "Quotedex",');
    ScriptMain.SQL.Add('0.00 AS "DebitEx",');
    ScriptMain.SQL.Add('0.00 AS "CreditEx",');
    ScriptMain.SQL.Add('LineTotal AS "DiffIncome_Cost",');
    ScriptMain.SQL.Add('LineTotal AS "PercentDiffIncomebyCost",');
    ScriptMain.SQL.Add('0.00 AS "DiffIncome_Quote",');
    ScriptMain.SQL.Add('0.00 AS "PercentDiffIncomebyQuote",');
    ScriptMain.SQL.Add('0.00 AS "DiffQuote_Cost",');
    ScriptMain.SQL.Add('0.00 AS "PercentDiffQuotebyCost",');
    ScriptMain.SQL.Add('0.00 AS "Backorders", 0.00 AS "ProfitPercent",');
    ScriptMain.SQL.Add('0.00 as ProfitDollars,');
    ScriptMain.SQL.Add('PL.PaysPayRateID,');
    ScriptMain.SQL.Add('PL.ClassName AS Department,');
    ScriptMain.SQL.Add('"" AS "ProductName",');
    ScriptMain.SQL.Add('null AS ProductId,');
    ScriptMain.SQL.Add('null AS QtyOrdered,');
    ScriptMain.SQL.Add('null AS QtyShipped,');
    ScriptMain.SQL.Add('null AS QtyBackOrder,');
    ScriptMain.SQL.Add('"" AS "FirstColumn",');
    ScriptMain.SQL.Add('"" AS "SecondColumn",');
    ScriptMain.SQL.Add('"" AS "ThirdColumn",');
    ScriptMain.SQL.Add('"" AS "Area",');
//          ScriptMain.SQL.Add('"" as CUSTFLD1, "" as CUSTFLD2, "" as CUSTFLD3, "" as CUSTFLD4, "" as CUSTFLD5,');
//          ScriptMain.SQL.Add('"" as CUSTFLD6, "" as CUSTFLD7, "" as CUSTFLD8, "" as CUSTFLD9, "" as CUSTFLD10,');
//          ScriptMain.SQL.Add('"" as CUSTFLD11, "" as CUSTFLD12, "" as CUSTFLD13, "" as CUSTFLD14, "" as CUSTFLD15');
    ScriptMain.SQL.Add('C.CUSTFLD1, C.CUSTFLD2, C.CUSTFLD3, C.CUSTFLD4, C.CUSTFLD5,');
    ScriptMain.SQL.Add('C.CUSTFLD6, C.CUSTFLD7, C.CUSTFLD8, C.CUSTFLD9, C.CUSTFLD10,');
    ScriptMain.SQL.Add('C.CUSTFLD11, C.CUSTFLD12, C.CUSTFLD13, C.CUSTFLD14, C.CUSTFLD15');
    ScriptMain.SQL.Add('FROM tblpays P');
    ScriptMain.SQL.Add('INNER JOIN tblpayspayrates PL on (P.PayID = PL.PayID) AND (NOT ISNULL(PL.ClientID) AND PL.ClientID <> "")');
    //ScriptMain.SQL.Add('INNER JOIN tblTimeSheets T ON (PL.TimeSheetId = T.ID) AND ((T.SalesId < 1) OR ISNULL(T.SalesId))');
    ScriptMain.SQL.Add('LEFT JOIN tblTimeSheets T ON (PL.TimeSheetId = T.ID) AND ((T.SalesId < 1) OR ISNULL(T.SalesId))');
    ScriptMain.SQL.Add('INNER JOIN tblclients C on C.ClientID = PL.ClientID');
    ScriptMain.SQL.Add('WHERE (Paid = "T") AND P.Deleted="F" ');
    Adddatefilter('P.DatePaid');
    if fClientID <> 0 then
      ScriptMain.SQL.Add('AND s.ClientID=' + IntToStr(fClientID));
  end;

  Procedure AddJournalEntryDetails;
  begin
    ScriptMain.SQL.Add('/*JOURNAL DEAILS*/');
    ScriptMain.SQL.Add('SELECT DISTINCT 1,JE.TransactionDate, ');
    ScriptMain.SQL.Add(Splitfield('C' , 'Company',1) +' AS CompanyName,');
    ScriptMain.SQL.Add('JobName, C.JobNumber, JED.GJID, "Journal entry" AS "TransactionType",');
    ScriptMain.SQL.Add('JED.ClientID, ');
    ScriptMain.SQL.Add('0 as Invoiceno,');
    ScriptMain.SQL.Add('JED.CreditAmount - JED.DebitAmount AS CostEx,');
    ScriptMain.SQL.Add('0 AS IncomeEx,');
    ScriptMain.SQL.Add('0 AS Quotedex,');
    ScriptMain.SQL.Add('JED.DebitAmount AS DebitEx,');
    ScriptMain.SQL.Add('JED.CreditAmount AS CreditEx,');
    ScriptMain.SQL.Add('JED.CreditAmount - JED.DebitAmount AS DiffIncome_Cost ,');
    ScriptMain.SQL.Add('JED.CreditAmount - JED.DebitAmount  as PercentDiffIncomebyCost,');
    ScriptMain.SQL.Add('0 AS DiffIncome_Quote,');
    ScriptMain.SQL.Add('0 AS PercentDiffIncomebyQuote,');
    ScriptMain.SQL.Add('0 AS DiffQuote_Cost,');
    ScriptMain.SQL.Add('0 AS PercentDiffQuotebyCost,');
    ScriptMain.SQL.Add('0 AS Backorders,');
    ScriptMain.SQL.Add('0 AS ProfitPercent,');
    ScriptMain.SQL.Add('0 AS ProfitDollars,');
    ScriptMain.SQL.Add('JED.GJDID,');
    ScriptMain.SQL.Add('JED.ClassName ,');
    ScriptMain.SQL.Add('"" AS ProductName,');
    ScriptMain.SQL.Add('null AS ProductId,');
    ScriptMain.SQL.Add('null AS QtyOrdered,');
    ScriptMain.SQL.Add('null AS QtyShipped,');
    ScriptMain.SQL.Add('null AS QtyBackOrder,');
    ScriptMain.SQL.Add('"" AS FirstColumn,');
    ScriptMain.SQL.Add('"" AS SecondColumn,');
    ScriptMain.SQL.Add('"" AS ThirdColumn,');
    ScriptMain.SQL.Add('"" AS Area,');
    ScriptMain.SQL.Add('C.CUSTFLD1, C.CUSTFLD2, C.CUSTFLD3, C.CUSTFLD4, C.CUSTFLD5,');
    ScriptMain.SQL.Add('C.CUSTFLD6, C.CUSTFLD7, C.CUSTFLD8, C.CUSTFLD9, C.CUSTFLD10,');
    ScriptMain.SQL.Add('C.CUSTFLD11, C.CUSTFLD12, C.CUSTFLD13, C.CUSTFLD14, C.CUSTFLD15');
    ScriptMain.SQL.Add('FROM tblgeneraljournaldetails JED  '+
                        ' INNER JOIN tblgeneraljournal JE ON JED.GJID = JE.GJID  '+
                        ' INNER JOIN tblclients C ON JED.ClientID = C.ClientID');
    ScriptMain.SQL.Add('WHERE (JED.clientID > 0)');
    Adddatefilter('JE.TransactionDate');

    if fClientID <> 0 then
      ScriptMain.SQL.Add('AND s.ClientID=' + IntToStr(fClientID));
  end;

  Procedure AddtimesheetDetails;
  begin
    ScriptMain.SQL.Add('/*TIMESHEET DETAILS*/');
    ScriptMain.SQL.Add('SELECT DISTINCT 1,P.TimesheetDate,');
    ScriptMain.SQL.Add(Splitfield('C' , 'Company',1) +' AS CompanyName,');
    ScriptMain.SQL.Add('JobName, C.JobNumber, P.ID, "Timesheet" AS "TransactionType",');

    ScriptMain.SQL.Add('P.JobID, 0 AS InvoiceNo,');
    ScriptMain.SQL.Add('Total AS "CostEx",');
    ScriptMain.SQL.Add('0.00 AS "IncomeEx",');
    ScriptMain.SQL.Add('0.00 AS "Quotedex",');
    ScriptMain.SQL.Add('0.00 AS "DebitEx",');
    ScriptMain.SQL.Add('0.00 AS "CreditEx",');
    ScriptMain.SQL.Add('Total AS "DiffIncome_Cost",');
    ScriptMain.SQL.Add('Total AS "PercentDiffIncomebyCost",');
    ScriptMain.SQL.Add('0.00 AS "DiffIncome_Quote",');
    ScriptMain.SQL.Add('0.00 AS "PercentDiffIncomebyQuote",');
    ScriptMain.SQL.Add('0.00 AS "DiffQuote_Cost",');
    ScriptMain.SQL.Add('0.00 AS "PercentDiffQuotebyCost",');
    ScriptMain.SQL.Add('0.00 AS "Backorders", 0.00 AS "ProfitPercent",');
    ScriptMain.SQL.Add('0.00 as ProfitDollars,');
    ScriptMain.SQL.Add('P.ID,');
    ScriptMain.SQL.Add('P.ClassName,');
    ScriptMain.SQL.Add('"" AS "ProductName",');
    ScriptMain.SQL.Add('null AS ProductId,');
    ScriptMain.SQL.Add('null AS QtyOrdered,');
    ScriptMain.SQL.Add('null AS QtyShipped,');
    ScriptMain.SQL.Add('null AS QtyBackOrder,');
    ScriptMain.SQL.Add('"" AS "FirstColumn",');
    ScriptMain.SQL.Add('"" AS "SecondColumn",');
    ScriptMain.SQL.Add('"" AS "ThirdColumn",');
    ScriptMain.SQL.Add('"" AS "Area",');
    ScriptMain.SQL.Add('C.CUSTFLD1, C.CUSTFLD2, C.CUSTFLD3, C.CUSTFLD4, C.CUSTFLD5,');
    ScriptMain.SQL.Add('C.CUSTFLD6, C.CUSTFLD7, C.CUSTFLD8, C.CUSTFLD9, C.CUSTFLD10,');
    ScriptMain.SQL.Add('C.CUSTFLD11, C.CUSTFLD12, C.CUSTFLD13, C.CUSTFLD14, C.CUSTFLD15');
    ScriptMain.SQL.Add('FROM tbltimesheets P');
    ScriptMain.SQL.Add('INNER JOIN tblclients C on C.ClientID = P.JobID');
    ScriptMain.SQL.Add('WHERE (P.Active = "T" AND P.JobID > 0)');
    Adddatefilter('P.ServiceDate');
    if fClientID <> 0 then
      ScriptMain.SQL.Add('AND s.ClientID=' + IntToStr(fClientID));
  end;

  Procedure AddrepairDetails;
  begin
    ScriptMain.SQL.Add('/*REPAIR DETAILS*/');
    ScriptMain.SQL.Add('SELECT');
    ScriptMain.SQL.Add('1 AS Details,R.UpdateDate,');
    ScriptMain.SQL.Add('Left(SUBSTRING_INDEX(C.Company,"^",1),255) AS CompanyName,');
    ScriptMain.SQL.Add('C.JobName,  C.JobNumber, R.RepairID, "Repairs" as "TransactionType",');
    ScriptMain.SQL.Add('R.CusID, R.RepairID AS TransactionNo, RP.Linecost*RP.Qty  as "CostEx",');
    ScriptMain.SQL.Add('RP.PriceEx*RP.Qty as "IncomeEx", R.QuotedAmount as "Quotedex",');
    ScriptMain.SQL.Add('0.00 AS "DebitEx", 0.00 AS "CreditEx",');
    ScriptMain.SQL.Add('RP.PriceEx*RP.Qty-RP.Linecost*RP.Qty as "DiffIncome_Cost",');
    ScriptMain.SQL.Add('((RP.PriceEx*RP.Qty-RP.Linecost*RP.Qty) / RP.PriceEx*RP.Qty)*100 as PercentDiffIncomeByCost,');
    ScriptMain.SQL.Add('RP.PriceEx*RP.Qty-RP.Linecost*RP.Qty AS "DiffIncome_Quote",');
    ScriptMain.SQL.Add('((RP.PriceEx*RP.Qty-RP.Linecost*RP.Qty) / RP.PriceEx*RP.Qty)*100 as  "PercentDiffIncomebyQuote",');
    ScriptMain.SQL.Add('0.00 AS "DiffQuote_Cost",');
    ScriptMain.SQL.Add('0.00 AS "PercentDiffQuotebyCost",');
    ScriptMain.SQL.Add('0 as BackOrders, 0.00 as ProfitPercent, 0.00 as ProfitDollars, RepairPartsId as LineId,');
    ScriptMain.SQL.Add('RP.ClassName, RP.PartName, RP.PartsID as ProductID,');
    ScriptMain.SQL.Add('null as QtyOrdered, null as QtyShipped, null as QtyBackOrder,');
    ScriptMain.SQL.Add('Left(SUBSTRING_INDEX(P.ProductGroup,"^",1),255) AS FirstColumn,');
    ScriptMain.SQL.Add('Left(substring(substring_index(P.ProductGroup,"^",2),char_length(substring_index(P.ProductGroup,"^",1))+2),255) AS SecondColumn,');
    ScriptMain.SQL.Add('Left(substring(substring_index(P.ProductGroup,"^",3),char_length(substring_index(P.ProductGroup,"^",2))+2),255) AS ThirdColumn,');
    ScriptMain.SQL.Add('P.Area,');
    ScriptMain.SQL.Add('R.CUSTFLD1, R.CUSTFLD2, R.CUSTFLD3, R.CUSTFLD4, R.CUSTFLD5,');
    ScriptMain.SQL.Add('R.CUSTFLD6, R.CUSTFLD7, R.CUSTFLD8, R.CUSTFLD9, R.CUSTFLD10,');
    ScriptMain.SQL.Add('R.CUSTFLD11, R.CUSTFLD12, R.CUSTFLD13, R.CUSTFLD14, R.CUSTFLD15');
    ScriptMain.SQL.Add('FROM');
    ScriptMain.SQL.Add('tblrepairs AS R');
    ScriptMain.SQL.Add('Inner Join tblrepairparts AS RP ON R.RepairID = RP.RepairID');
    ScriptMain.SQL.Add('Inner Join tblparts AS P ON RP.PartsID = P.PARTSID');
    ScriptMain.SQL.Add('Inner Join tblclients AS C ON R.CusID = C.ClientID');
    ScriptMain.SQL.Add('Where R.converted = "F"');
    Adddatefilter('RP.PartIssuedOn');
    if fClientID <> 0 then
      ScriptMain.SQL.Add('AND s.ClientID=' + IntToStr(fClientID));

  end;

  procedure AddStockAdjustDetails;
  begin
    ScriptMain.SQL.Add('/*STOCKADJUST DETAILS*/');
    ScriptMain.SQL.Add('SELECT 0, s.CreationDate,');
    ScriptMain.SQL.Add('c.Company AS CompanyName,');
    ScriptMain.SQL.Add('c.JobName, c.JobNumber, s.StockAdjustEntryID, "Stock Adjustment" AS "TransactionType",');
    ScriptMain.SQL.Add('c.ClientID, 0 AS TransactionNo, (sl.Cost * sl.AdjustQty) AS "CostEx",');
    ScriptMain.SQL.Add('0.00 AS "IncomeEx", 0.00 as "QuotedEx", 0.00 AS "DebitEx", 0.00 AS "CreditEx",');
    ScriptMain.SQL.Add('(sl.Cost - 0.00) AS "DiffIncome_Cost",');
    ScriptMain.SQL.Add('(sl.Cost - 0.00) / sl.Cost * 100 AS "PercentDiffIncomebyCost",');
    ScriptMain.SQL.Add('0.00 as "DiffQuote_Cost", 0.00 as "PercentDiffQuotebyCost",');
    ScriptMain.SQL.Add('0.00 AS "DiffIncome_Quote",');
    ScriptMain.SQL.Add('0.00 AS "PercentDiffIncomebyQuote",');
    ScriptMain.SQL.Add('0.00 AS "Backorders", 0.00 AS "ProfitPercent",');
    ScriptMain.SQL.Add('0.00 as ProfitDollars,');
    ScriptMain.SQL.Add('c.ClientID,');
    ScriptMain.SQL.Add('sl.ClassName AS Department,');
    ScriptMain.SQL.Add('sl.ProductName AS "ProductName",');
    ScriptMain.SQL.Add('sl.ProductID AS ProductId,');
    ScriptMain.SQL.Add('sl.AvailableUOMQty AS QtyOrdered,');
    ScriptMain.SQL.Add('sl.FinalUOMQty AS QtyShipped,');
    ScriptMain.SQL.Add('sl.AdjustUOMQty AS QtyBackOrder,');
    ScriptMain.SQL.Add('SPACE(255) AS "FirstColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "SecondColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "ThirdColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "Area",');
    ScriptMain.SQL.Add('c.CUSTFLD1, c.CUSTFLD2, c.CUSTFLD3, c.CUSTFLD4, c.CUSTFLD5,');
    ScriptMain.SQL.Add('c.CUSTFLD6, c.CUSTFLD7, c.CUSTFLD8, c.CUSTFLD9, c.CUSTFLD10,');
    ScriptMain.SQL.Add('c.CUSTFLD11, c.CUSTFLD12, c.CUSTFLD13, c.CUSTFLD14, c.CUSTFLD15');
    ScriptMain.SQL.Add('FROM tblstockadjustentrylines sl');
    ScriptMain.SQL.Add('INNER JOIN tblstockadjustentry s USING(StockAdjustEntryID)');
    ScriptMain.SQL.Add('INNER JOIN tblclients c ON c.ClientID=sl.JobID');
    ScriptMain.SQL.Add('WHERE sl.Deleted="F" AND s.Deleted="F"');
    AddDateFilter('s.AdjustmentDate');

    if fClientID <> 0 then
      ScriptMain.SQL.Add('AND s.ClientID=' + IntToStr(fClientID));
  end;

  procedure AddAllowanceDetails;
  begin
    ScriptMain.SQL.Add('/*ALLOWANCE DETAIL*/');
    ScriptMain.SQL.Add('SELECT 0, p.PayDate,');
    ScriptMain.SQL.Add('c.Company AS CompanyName,');
    ScriptMain.SQL.Add('c.JobName, c.JobNumber, a.PayAllowanceID, "Payroll-Other" AS TransactionType,');
    ScriptMain.SQL.Add('c.ClientID, 0 AS TransactionNo, a.Qty * a.Amount AS CostEx,');
    ScriptMain.SQL.Add('0.00 AS IncomeEx, 0.00 as QuotedEx, 0.00 AS DebitEx, 0.00 AS CreditEx,');
    ScriptMain.SQL.Add('(a.Qty * a.Amount - 0.00) AS DiffIncome_Cost,');
    ScriptMain.SQL.Add('(a.Qty * a.Amount - 0.00) / a.Qty * a.Amount * 100 AS "PercentDiffIncomebyCost",');
    ScriptMain.SQL.Add('0.00 as "DiffQuote_Cost", 0.00 as "PercentDiffQuotebyCost",');
    ScriptMain.SQL.Add('0.00 AS "DiffIncome_Quote",');
    ScriptMain.SQL.Add('0.00 AS "PercentDiffIncomebyQuote",');
    ScriptMain.SQL.Add('0.00 AS "Backorders", 0.00 AS "ProfitPercent",');
    ScriptMain.SQL.Add('0.00 as ProfitDollars,');
    ScriptMain.SQL.Add('c.ClientID,');
    ScriptMain.SQL.Add('a.ClassName AS Department,');
    ScriptMain.SQL.Add('"" AS "ProductName",');
    ScriptMain.SQL.Add('null AS ProductId,');
    ScriptMain.SQL.Add('null AS QtyOrdered,');
    ScriptMain.SQL.Add('null AS QtyShipped,');
    ScriptMain.SQL.Add('null AS QtyBackOrder,');
    ScriptMain.SQL.Add('SPACE(255) AS "FirstColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "SecondColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "ThirdColumn",');
    ScriptMain.SQL.Add('SPACE(255) AS "Area",');
    ScriptMain.SQL.Add('c.CUSTFLD1, c.CUSTFLD2, c.CUSTFLD3, c.CUSTFLD4, c.CUSTFLD5,');
    ScriptMain.SQL.Add('c.CUSTFLD6, c.CUSTFLD7, c.CUSTFLD8, c.CUSTFLD9, c.CUSTFLD10,');
    ScriptMain.SQL.Add('c.CUSTFLD11, c.CUSTFLD12, c.CUSTFLD13, c.CUSTFLD14, c.CUSTFLD15');
    ScriptMain.SQL.Add('FROM tblpaysallowances a');
    ScriptMain.SQL.Add('INNER JOIN tblclients c ON c.ClientID=a.ClientID');
    ScriptMain.SQL.Add('INNER JOIN tblpays p ON a.PayID=p.PayID');
    ScriptMain.SQL.Add('WHERE a.TaxExempt="T" AND p.Paid="T" AND p.Deleted="F"');
    AddDateFilter('p.DatePaid');

    if fClientID <> 0 then
      ScriptMain.SQL.Add('AND s.ClientID=' + IntToStr(fClientID));
  end;

begin
  ScriptMain := TERPScript.Create(nil);
  try
    ScriptMain.Connection := CommonDbLib.GetSharedMyDacConnection;
    ScriptMain.SQL.Clear;
    ScriptMain.SQL.ADD('TRUNCATE TABLE ' + fTableName + ';');
    ScriptMain.SQL.ADD('INSERT INTO ' + fTableName +
          ' (Details,CompanyName,JobName,JobNumber,SaleID,TransactionType,ClientID,TransactionNo,'+
          'CostEx,IncomeEx,Quotedex,DebitEx,CreditEx,DiffIncome_Cost,PercentDiffIncomebyCost,'+
          'DiffQuote_Cost,PercentDiffQuotebyCost,Backorders,ProfitPercent, ProfitDollars, LineID,Department,'+
          'ProductName,FirstColumn,SecondColumn,ThirdColumn,Area, ' +
          'CUSTFLD1, CUSTFLD2, CUSTFLD3, CUSTFLD4, CUSTFLD5, CUSTFLD6, CUSTFLD7, CUSTFLD8,' +
          'CUSTFLD9, CUSTFLD10, CUSTFLD11, CUSTFLD12, CUSTFLD13, CUSTFLD14, CUSTFLD15)');

    Addsales;         ScriptMain.SQL.Add(' UNION ALL ' );
    AddPOs;           ScriptMain.SQL.Add(' UNION ALL ' );
    AddPays;          ScriptMain.SQL.Add(' UNION ALL ' );
    Addtimesheets;    ScriptMain.SQL.Add(' UNION ALL ' );
    AddJournalEnties; ScriptMain.SQL.Add(' UNION ALL ' );
    AddStockAdjust;   ScriptMain.SQL.Add(' UNION ALL ' );
    AddAllowances;    ScriptMain.SQL.Add(' UNION ALL ' );
    AddRepairs;
    ScriptMain.SQL.Add(' ;');

    ScriptMain.SQL.add('UPDATE ' + fTableName +
      ' SET CostEx = IF(DebitEx <> 0.0, ABS(CostEx), -ABS(CostEx))' +
      ' WHERE TransactionType = ''Journal entry'';');

    ScriptMain.SQL.add('UPDATE ' + fTableName + ' SET ProfitPercent = (IncomeEx - CostEx)/ IncomeEx * 100.0;');
    ScriptMain.SQL.add('UPDATE ' + fTableName + ' SET ProfitDollars = (IncomeEx - CostEx);');
    ScriptMain.SQL.add('UPDATE ' + fTableName + ' SET TransactionNo = null where details = 0;');

    ScriptMain.SQL.add( 'UPDATE ' + fTableName + ' SET DiffIncome_Cost = 0 where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex <> 0;');
    ScriptMain.SQL.add( 'UPDATE ' + fTableName + ' SET PercentDiffIncomebyCost  = 0 where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex <> 0;');

    ScriptMain.SQL.add( 'UPDATE ' + fTableName + ' T inner join tblparts P on T.productID  = P.partsID set T.LandedCost        = P.LandedCost * T.QtyShipped, T.LatestCost = P.LatestCost * T.QtyShipped where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS");');
    ScriptMain.SQL.add( 'UPDATE ' + fTableName + ' SET DiffIncome_Landedcost    = IncomeEx-LandedCost        where ifnull(ProductID,0)<> 0 and TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") ;');
    ScriptMain.SQL.add( 'UPDATE ' + fTableName + ' SET DiffIncome_Latestcost    =IncomeEx-Latestcost        where ifnull(ProductID,0)<> 0 and  TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") ;');

    ScriptMain.SQL.add( 'UPDATE ' + fTableName + ' SET PercentDiffIncomebyLandedcost =  (IncomeEx-LandedCost)/if(ifnull(LandedCost,0)=0,IncomeEx,LandedCost)*100     where  ifnull(ProductID,0)<> 0 and TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") ;');
    ScriptMain.SQL.add( 'UPDATE ' + fTableName + ' SET PercentDiffIncomebyLatestcost = (IncomeEx-Latestcost)/if(ifnull(Latestcost,0)=0,IncomeEx,Latestcost)*100     where  ifnull(ProductID,0)<> 0 and TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") ;');

    ScriptMain.SQL.add( 'UPDATE ' + fTableName + ' SET DiffQuote_Cost           =IncomeEx-Quotedex                where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex <> 0;');
    ScriptMain.SQL.add( 'UPDATE ' + fTableName + ' SET PercentDiffQuotebyCost =  (IncomeEx-Quotedex)/if(ifnull(Quotedex,0)=0,IncomeEx,Quotedex)*100 where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex <> 0;');

    ScriptMain.SQL.add( 'UPDATE ' + fTableName + ' SET TransactionType ="Quote" where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex <> 0 and Details >0;');
    ScriptMain.SQL.add( 'UPDATE ' + fTableName + ' SET DiffIncome_Cost =IncomeEx-CostEx where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex = 0;');
    ScriptMain.SQL.add( 'UPDATE ' + fTableName + ' SET PercentDiffIncomebyCost= (IncomeEx-CostEx)/if(ifnull(CostEx,0)=0,IncomeEx,CostEx)*100     where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex = 0;');

    ScriptMain.SQL.add( 'UPDATE ' + fTableName + ' SET DiffQuote_Cost = 0 where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex = 0;');
    ScriptMain.SQL.add( 'UPDATE ' + fTableName + ' SET PercentDiffQuotebyCost =0 where TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS") and Quotedex = 0;');
    ScriptMain.SQL.add( 'UPDATE ' + fTableName + ' SET CostEx =0 where TransactionType = "Quote";');
    ScriptMain.SQL.add( 'UPDATE ' + fTableName + ' SET DiffIncome_Cost = 0 where not(TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS")) ;');
    ScriptMain.SQL.add( 'UPDATE ' + fTableName + ' SET PercentDiffIncomebyCost=0 where not(TransactionType in ("Invoice", "Cash Sale" ,"Refund", "POS")) ;');
    ScriptMain.SQL.add( 'UPDATE ' + fTableName + ' T '+
                        'INNER JOIN tblpurchaseorders PO ON T.saleId = PO.PurchaseorderId ' +
                        'SET T.Suppliername = PO.SupplierName ' +
                        'WHERE TransactionType IN ("Purchase Order", "Bill", "Credit", "Cheque");');
    LogText(ScriptMain.SQLtext);
    ScriptMain.Execute;

  finally
    ScriptMain.Free;
  end;

end;

function TJobProfitability.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
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
  CreateTempJobProfTable;
  PopulateData;

  SQL.Clear;
  result := inherited;

  SQL.Add('SELECT *');
  SQL.Add('FROM ' + fTableName);

  if not (Search = '') then
    SQL.Add('AND ' + ReplaceAlias(Search));

  if not (OrderBy = '') then
    SQL.Add('ORDER BY ' + OrderBy);

end;

initialization

   RegisterClass(TJobProfitability);

end.
