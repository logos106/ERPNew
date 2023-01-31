unit AccountsListSQL;

interface

uses
  ERPDbComponents, DAScript, SysUtils, classes, Types, DB, ReportBaseObj;
Type
  TAccountList = class(TReportWithDateRangeBase)
  private
(*    fDateTo               : TDateTime;
    fDateFrom             : TDateTime;
    fbIgnoreDates: boolean;
    function getDateTo: TDateTime;
    function getDateFrom: TDateTime;*)
    Procedure DataSQL(SQL: TStrings; DataFor:String); Overload;
    Procedure DataSQL(SQL: TStrings; DataFor, Extrawhere,  Groupby: String);Overload;
    (*function PopulateReportSQL(SQL: TStrings; var msg: string): boolean;*)
  Protected
(*    function DateFromSQL      : string;
    function DateToSQL        : string;*)
    Procedure CurYearSQL(SQL: TStrings; Extrawhere , Groupby:String);
    Procedure HistorySQL(SQL: TStrings; Extrawhere , Groupby:String);
    Procedure AllSQL(SQL: TStrings; Extrawhere, Groupby: String);
  Public
    constructor Create; override;
    destructor Destroy; override;

  Published
(*    property DateFrom               : TDateTime read getDateFrom    write fDateFrom  ;
    property DateTo                 : TDateTime read getDateTo      write fDateTo  ;
    Property IgnoreDates            : boolean   read fbIgnoreDates  write fbIgnoreDates;*)
  end;
  TBankAccountReport = Class(TAccountList)
  Private
    fbIncludedataPriorToClosingDate: boolean;
  Protected
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean;Override;
  Public
    constructor Create; override;
  Published
    Property IncludedataPriorToClosingDate :boolean read fbIncludedataPriorToClosingDate write fbIncludedataPriorToClosingDate;
  End;

implementation


{ TAccountList }

constructor TAccountList.Create;
begin
  inherited;
(*  fDateTo       := date;
  fDateFrom     := incday(Date,-30);
  fbIgnoreDates := False;*)
end;
Procedure TAccountList.AllSQL(SQL: TStrings; Extrawhere,  Groupby: String);
begin
  (*if Groupby ='' then Groupby := 'T.TransId';
  DataSQL(SQL, 'A');
  if Extrawhere <> '' then SQL.add('AND ' + Extrawhere);
  SQL.add('GROUP BY ' + Groupby);*)
  DataSQL(SQL, 'A', Extrawhere,  Groupby);
end;
Procedure TAccountList.HistorySQL(SQL: TStrings; Extrawhere,  Groupby: String);
begin
  (*if Groupby ='' then Groupby := 'T.TransId';
  DataSQL(SQL, 'P');
  if Extrawhere <> '' then SQL.add('AND ' + Extrawhere);
  SQL.add('GROUP BY ' + Groupby);*)
  DataSQL(SQL, 'P', Extrawhere,  Groupby);
end;
Procedure TAccountList.CurYearSQL(SQL: TStrings; Extrawhere, Groupby: String);
begin
  (*if Groupby ='' then Groupby := 'T.TransId';
  DataSQL(SQL, 'C');
  if Extrawhere <> '' then SQL.add('AND ' + Extrawhere);
  SQL.add('GROUP BY ' + Groupby);*)
  DataSQL(SQL, 'P', Extrawhere,  Groupby);
end;
Procedure TAccountList.DataSQL(SQL: TStrings; DataFor, Extrawhere,  Groupby: String);
begin
  if Groupby ='' then Groupby := 'T.TransId';
  DataSQL(SQL, DataFor);
  if Extrawhere <> '' then SQL.add('AND ' + Extrawhere);
  SQL.add('GROUP BY ' + Groupby);
end;
Procedure TAccountList.DataSQL(SQL: TStrings; DataFor:String);
begin
      SQL.Add('SELECT');
      SQL.Add('T.GlobalRef as GlobalRef, ');
      SQL.Add('T.Date as Date, ');
      SQL.Add('Type as Type,');
      SQL.Add('AccountName as AccountName,');
      SQL.Add('T.Active as Active,');
      SQL.Add('sum(DebitsInc-CreditsInc) as "Amountinc",');
      SQL.Add('sum(DebitsEx-CreditsEx) as "Amount",');
      SQL.Add('C.ClassName as ClassName, ');
      SQL.Add('SaleID as SaleID, ');
      SQL.Add('PurchaseOrderID as PurchaseOrderID, ');
      SQL.Add('PaymentID as PaymentID, ');
      SQL.Add('PrepaymentID as PrepaymentID,');
      SQL.Add('TransID as TransID, ');
      SQL.Add('If(Reconciled = "T","T","F") as Reconciled ,');
      SQL.Add('Notes as  Notes,');
      SQL.Add('`Chq/Ref` as ChqRefNo ,');
      SQL.Add('T.ClientName as Payee');
      if (DataFor ='C') or (DataFor ='A') then begin
        SQL.Add('FROM tbltransactions T');
      end else begin
        SQL.Add('FROM tbltransactionsummarydetails T');
      end;
      SQL.Add('LEFT JOIN tblclass C USING (ClassID)');
      SQL.add('WHERE T.Date Between ' + DateFromSQL + ' AND ' + DateToSQL);
      if (DataFor ='C') then SQL.Add('AND TYPE <>"Closing Date Summary"');

end;

(*function TAccountList.DateFromSQL: string;
begin
  REsult := DateSQL(DateFrom, 'DateFrom');
end;

function TAccountList.DateToSQL: string;
begin
  REsult := DateSQL(DateTo, 'DateTo');
end;*)

destructor TAccountList.Destroy;
begin
  inherited;
end;


(*function TAccountList.getDateFrom: TDateTime;
begin
  if fbIgnoreDates then
       Result := ERPListMinDatetime
  else Result := dateof(fDateFrom);
end;

function TAccountList.getDateTo: TDateTime;
begin
  if fbIgnoreDates then
       Result := ERPListMaxDatetime
  else Result := IncSecond(IncDay(dateof(fDateTo), 1), -1);
end;*)
{ TBankAccountReport }

constructor TBankAccountReport.Create;
begin
  inherited;
  IncludedataPriorToClosingDate := false;
end;

function TBankAccountReport.PopulateReportSQL(SQL: TStrings;  var msg: string): boolean;
begin
  REsult := True;
  SQL.clear;
  if IncludedataPriorToClosingDate = False then begin
      AllSQL(SQL,    '((AccountType = "BANK"  or  AccountType = "CCARD" ) And TYPE =  "Cheque")' ,'Type,PaymentID,PurchaseOrderID,AccountID ');SQL.add('UNION ALL');
      AllSQL(SQL,    '((AccountType = "BANK"  or  AccountType = "CCARD" ) And TYPE <>  "Cheque")','TransID,Type,PaymentID,AccountID ');
  end else begin
    CurYearSQL(SQL,'((AccountType = "BANK"  or  AccountType = "CCARD" ) And TYPE =  "Cheque")' ,'Type,PaymentID,PurchaseOrderID,AccountID ') ;SQL.add('UNION ALL');
    CurYearSQL(SQL,'((AccountType = "BANK"  or  AccountType = "CCARD" ) And TYPE <> "Cheque")' ,'TransID,Type,PaymentID,AccountID ')         ;SQL.add('UNION ALL');
    HistorySQL(SQL,'((AccountType = "BANK"  or  AccountType = "CCARD" ) And TYPE =  "Cheque")' , 'Type,PaymentID,PurchaseOrderID,AccountID ');SQL.add('UNION ALL');
    HistorySQL(SQL,'((AccountType = "BANK"  or  AccountType = "CCARD" ) And TYPE <> "Cheque")' ,'TransID,Type,PaymentID,AccountID ');
  end;
  SQL.Add('ORDER BY Date DESC');
end;

initialization
  RegisterClass(TBankAccountReport);

end.

