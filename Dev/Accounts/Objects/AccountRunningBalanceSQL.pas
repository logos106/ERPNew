unit AccountRunningBalanceSQL;

interface

uses
  ERPDbComponents, DAScript, SysUtils, classes, Types, DB, ReportBaseObj;

type
  TAccountRunningBalanceReport = class(TReportWithDateRangeBase)
  private
(*    fDateTo: TDateTime;
    fDateFrom: TDateTime;*)
    fIgnoreSummarised: boolean;
    fsAccountname: String;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
  published
    property IgnoreSummarised: boolean read fIgnoreSummarised write fIgnoreSummarised;
    Property Accountname :String read fsAccountname write fsAccountname;
(*    property DateFrom: TDateTime read fDateFrom write fDateFrom;
    property DateTo: TDateTime read fDateTo write fDateTo;*)
  end;

implementation

uses
  DateUtils, MySQLConst;

{ TAccountRunningBalanceReport }

constructor TAccountRunningBalanceReport.Create;
begin
  inherited;
  DateTo := EndOfAMonth(YearOf(Date),MonthOf(Date));
  DateFrom := Trunc(IncDay(IncYear(DateTo,-1),1));
  fIgnoreSummarised := true;
  Accountname := '';
end;

destructor TAccountRunningBalanceReport.Destroy;
begin

  inherited;
end;

function TAccountRunningBalanceReport.PopulateReportSQL(SQL: TStrings;
  var msg: string): boolean;
var
  dFromStr,
  dToStr: string;
begin
  result := inherited;
  SQL.Clear;

  dFromStr := DateFromSQL ;//Quotedstr(Formatdatetime(mysqlDateTimeFormat, DateFrom));
  dToStr := DateToSQL ;    // Quotedstr(Formatdatetime(mysqlDateTimeFormat, DateTo));
  SQL.Add('select 2 as SeqNo, Trans.clientname as clientname, Trans.ClientID as ClientId, Acc.AccountID, Acc.AccountName, Acc.AccountType, Acc.AccountNumber, Date, Type,');
  SQL.Add('SaleID, PurchaseOrderID,PaymentID,PrepaymentID,FixedAssetID,');
  SQL.Add('convert(Null,DECIMAL(15,5)) as OpeningBalanceEx,');
  SQL.Add('convert(Null,DECIMAL(15,5)) as OpeningBalanceInc,');
  SQL.Add('convert(Null,DECIMAL(15,5)) as ClosingBalanceEx,');
  SQL.Add('convert(Null,DECIMAL(15,5)) as ClosingBalanceInc,');
  SQL.Add('convert(DebitsEx,DECIMAL(15,5)) as TotalDebitEx,');
  SQL.Add('convert(DebitsInc,DECIMAL(15,5)) as TotalDebitInc,');
  SQL.Add('convert(CreditsEx,DECIMAL(15,5)) as TotalCreditEx,');
  SQL.Add('convert(CreditsInc,DECIMAL(15,5)) as TotalCreditInc,');
  SQL.Add('convert(If(Acc.AccountType="CCARD" OR Acc.AccountType = "EQUITY" OR Acc.AccountType = "INC" OR Acc.AccountType = "OCLIAB", CreditsEx-DebitsEx, DebitsEx-CreditsEx),DECIMAL(15,5)) as Balance');
  SQL.Add('from tbltransactions as Trans');
  SQL.Add('inner join tblchartofaccounts as Acc on Acc.AccountID = Trans.AccountID');
  SQL.Add('where Trans.Date between ' + dFromStr + ' and ' + dToStr);
  if Accountname <> '' then SQL.Add('and Trans.AccountName =' + quotedstr(Accountname));
  if not IgnoreSummarised then begin
    SQL.Add(' and Seqno <100');
    SQL.Add('union all');
    SQL.Add('select 2 as SeqNo, Trans.clientname as clientname, Trans.ClientID as ClientId, Acc.AccountID, Acc.AccountName, Acc.AccountType, Acc.AccountNumber, Date, Type,');
    SQL.Add('SaleID, PurchaseOrderID,PaymentID,PrepaymentID,FixedAssetID,');
    SQL.Add('convert(Null,DECIMAL(15,5)) as OpeningBalanceEx,');
    SQL.Add('convert(Null,DECIMAL(15,5)) as OpeningBalanceInc,');
    SQL.Add('convert(Null,DECIMAL(15,5)) as ClosingBalanceEx,');
    SQL.Add('convert(Null,DECIMAL(15,5)) as ClosingBalanceInc,');
    SQL.Add('convert(DebitsEx,DECIMAL(15,5)) as TotalDebitEx,');
    SQL.Add('convert(DebitsInc,DECIMAL(15,5)) as TotalDebitInc,');
    SQL.Add('convert(CreditsEx,DECIMAL(15,5)) as TotalCreditEx,');
    SQL.Add('convert(CreditsInc,DECIMAL(15,5)) as TotalCreditInc,');
    SQL.Add('convert(If(Acc.AccountType="CCARD" OR Acc.AccountType = "EQUITY" OR Acc.AccountType = "INC" OR Acc.AccountType = "OCLIAB", CreditsEx-DebitsEx, DebitsEx-CreditsEx),DECIMAL(15,5)) as Balance');
    SQL.Add('from tbltransactionsummarydetails as Trans');
    SQL.Add('inner join tblchartofaccounts as Acc on Acc.AccountID = Trans.AccountID');
    SQL.Add('where Trans.Date between ' + dFromStr + ' and ' + dToStr);
    if Accountname <> '' then SQL.Add('and Trans.AccountName =' + quotedstr(Accountname));
  end;
  SQL.Add('union all');

  SQL.Add('select SeqNo, null as clientname, Null as ClientId, AccountID, AccountName, AccountType, AccountNumber, Date, Type,');
  SQL.Add('null as SaleID, null as PurchaseOrderID,null as PaymentID,null as PrepaymentID,null as FixedAssetID,');
  SQL.Add('convert(Sum(OpeningBalanceEx),DECIMAL(15,5)) as OpeningBalanceEx,');
  SQL.Add('convert(Sum(OpeningBalanceInc),DECIMAL(15,5)) as OpeningBalanceInc,');
  SQL.Add('convert(Sum(ClosingBalanceEx),DECIMAL(15,5)) as ClosingBalanceEx,');
  SQL.Add('convert(Sum(ClosingBalanceInc),DECIMAL(15,5)) as ClosingBalanceInc,');
  SQL.Add('convert(Sum(TotalDebitEx),DECIMAL(15,5)) as TotalDebitEx,');
  SQL.Add('convert(Sum(TotalDebitInc),DECIMAL(15,5)) as TotalDebitInc,');
  SQL.Add('convert(Sum(TotalCreditEx),DECIMAL(15,5)) as TotalCreditEx,');
  SQL.Add('convert(Sum(TotalCreditInc),DECIMAL(15,5)) as TotalCreditInc,');
  SQL.Add('convert(Sum(Balance),DECIMAL(15,5)) as Balance');
  SQL.Add('from ( ');
  SQL.Add('select 1 as SeqNo, Acc.AccountID, Acc.AccountName, Acc.AccountType, Acc.AccountNumber, Cast(0 as DATE) as Date, Null as Type,');
  SQL.Add('If(Date < ' + dFromStr + ', If(Acc.AccountType="CCARD" OR Acc.AccountType = "EQUITY" OR Acc.AccountType = "INC" OR Acc.AccountType = "OCLIAB", CreditsEx-DebitsEx, DebitsEx-CreditsEx), 0.0) as OpeningBalanceEx,');
  SQL.Add('If(Date < ' + dFromStr + ', If(Acc.AccountType="CCARD" OR Acc.AccountType = "EQUITY" OR Acc.AccountType = "INC" OR Acc.AccountType = "OCLIAB", CreditsInc-DebitsInc, DebitsInc-CreditsInc), 0.0) as OpeningBalanceInc,');
  SQL.Add('If(Date <= ' + dToStr + ', If(Acc.AccountType="CCARD" OR Acc.AccountType = "EQUITY" OR Acc.AccountType = "INC" OR Acc.AccountType = "OCLIAB", CreditsEx-DebitsEx, DebitsEx-CreditsEx), 0.0) as ClosingBalanceEx,');
  SQL.Add('If(Date <= ' + dToStr + ', If(Acc.AccountType="CCARD" OR Acc.AccountType = "EQUITY" OR Acc.AccountType = "INC" OR Acc.AccountType = "OCLIAB", CreditsInc-DebitsInc, DebitsInc-CreditsInc), 0.0) as ClosingBalanceInc,');
  SQL.Add('If(Date >= ' + dFromStr + ' and Date < ' + dToStr + ', DebitsEx, 0.0) as TotalDebitEx,');
  SQL.Add('If(Date >= ' + dFromStr + ' and Date < ' + dToStr + ', DebitsInc, 0.0) as TotalDebitInc,');
  SQL.Add('If(Date >= ' + dFromStr + ' and Date < ' + dToStr + ', CreditsEx, 0.0) as TotalCreditEx,');
  SQL.Add('If(Date >= ' + dFromStr + ' and Date < ' + dToStr + ', CreditsInc, 0.0) as TotalCreditInc,');
  SQL.Add('If(Date <= ' + dToStr + ', If(Acc.AccountType="CCARD" OR Acc.AccountType = "EQUITY" OR Acc.AccountType = "INC" OR Acc.AccountType = "OCLIAB", CreditsEx-DebitsEx, DebitsEx-CreditsEx), 0.0) as Balance');
  SQL.Add('from tbltransactions as Trans');
  SQL.Add('inner join tblchartofaccounts as Acc on Acc.AccountID = Trans.AccountID');
  SQL.Add('where Trans.Date between ' + dFromStr + ' and ' + dToStr);
  if Accountname <> '' then SQL.Add('and Trans.AccountName =' + quotedstr(Accountname));
  if not IgnoreSummarised then begin
    SQL.Add(' and Seqno <100');
    SQL.Add('union all');
    SQL.Add('select 1 as SeqNo, Acc.AccountID, Acc.AccountName, Acc.AccountType, Acc.AccountNumber, Cast(0 as DATE) as Date, Null as Type,');
    SQL.Add('If(Date < ' + dFromStr + ', If(Acc.AccountType="CCARD" OR Acc.AccountType = "EQUITY" OR Acc.AccountType = "INC" OR Acc.AccountType = "OCLIAB", CreditsEx-DebitsEx, DebitsEx-CreditsEx), 0.0) as OpeningBalanceEx,');
    SQL.Add('If(Date < ' + dFromStr + ', If(Acc.AccountType="CCARD" OR Acc.AccountType = "EQUITY" OR Acc.AccountType = "INC" OR Acc.AccountType = "OCLIAB", CreditsInc-DebitsInc, DebitsInc-CreditsInc), 0.0) as OpeningBalanceInc,');
    SQL.Add('If(Date <= ' + dToStr + ', If(Acc.AccountType="CCARD" OR Acc.AccountType = "EQUITY" OR Acc.AccountType = "INC" OR Acc.AccountType = "OCLIAB", CreditsEx-DebitsEx, DebitsEx-CreditsEx), 0.0) as ClosingBalanceEx,');
    SQL.Add('If(Date <= ' + dToStr + ', If(Acc.AccountType="CCARD" OR Acc.AccountType = "EQUITY" OR Acc.AccountType = "INC" OR Acc.AccountType = "OCLIAB", CreditsInc-DebitsInc, DebitsInc-CreditsInc), 0.0) as ClosingBalanceInc,');
    SQL.Add('If(Date >= ' + dFromStr + ' and Date < ' + dToStr + ', DebitsEx, 0.0) as TotalDebitEx,');
    SQL.Add('If(Date >= ' + dFromStr + ' and Date < ' + dToStr + ', DebitsInc, 0.0) as TotalDebitInc,');
    SQL.Add('If(Date >= ' + dFromStr + ' and Date < ' + dToStr + ', CreditsEx, 0.0) as TotalCreditEx,');
    SQL.Add('If(Date >= ' + dFromStr + ' and Date < ' + dToStr + ', CreditsInc, 0.0) as TotalCreditInc,');
    SQL.Add('If(Date <= ' + dToStr + ', If(Acc.AccountType="CCARD" OR Acc.AccountType = "EQUITY" OR Acc.AccountType = "INC" OR Acc.AccountType = "OCLIAB", CreditsEx-DebitsEx, DebitsEx-CreditsEx), 0.0) as Balance');
    SQL.Add('from tbltransactionsummarydetails as Trans');
    SQL.Add('inner join tblchartofaccounts as Acc on Acc.AccountID = Trans.AccountID');
    SQL.Add('where Trans.Date between ' + dFromStr + ' and ' + dToStr);
    if Accountname <> '' then SQL.Add('and Trans.AccountName =' + quotedstr(Accountname));
  end;
  SQL.Add(') as T Group By T.AccountID');
  SQL.Add('ORDER BY Date DESC, AccountName, SeqNo');

end;

initialization
  RegisterClass(TAccountRunningBalanceReport);

end.
