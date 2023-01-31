unit PaymentsListSQL;

interface

uses
  classes, ReportBaseObj,ERPDbComponents;

Type
  TPaymentList = Class(TReportWithDateRangeBase)
  Private
    FReconciled: Boolean;
    fiClientId: Integer;

    Function ClientIDSQL(const paramfieldname:String): String;

  Protected

  Public
    constructor Create; Override;
    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;

  Published
    Property ClientID: Integer        read fiClientId     write fiClientId;
    property Reconciled: Boolean      read FReconciled write FReconciled;
  End;


implementation

uses CommonLib,sysutils, tcConst;

{ TPaymentList }

function TPaymentList.ClientIDSQL(const paramfieldname:String): String;
var
  dt: TDateTime;
begin
  result := '';
  if not APIMode then begin
    result := ' AND (:ClientId=0 OR :ClientId=' + paramfieldname + ')';
    Exit;
  end;
  if clientID <> 0 then
    result := ' AND (' + inttostr(ClientID) + '=0 OR ' + paramfieldname + '=' + inttostr(ClientID) + ')';
end;

constructor TPaymentList.Create;
begin
  inherited;
  ficlientID := 0;
end;

function TPaymentList.PopulateReportSQL(SQL: TStrings;var msg: string): boolean;
  function ReplaceAlias(AClause: string): string;
  var
    STemp: string;
  begin
    STemp := AClause;
    STemp := ReplaceStr(STemp, 'true', '"T"');
    STemp := ReplaceStr(STemp, 'false', '"F"');
    Result := STemp;
  end;

  function ReplaceAlias2(AClause: string): string;
  var
    STemp: string;
  begin
    STemp := AClause;
    STemp := ReplaceStr(STemp, 'true', '"T"');
    STemp := ReplaceStr(STemp, 'false', '"F"');
    STemp := ReplaceStr(STemp, 'PaymentID', 'PrePaymentID');
    Result := STemp;
  end;
begin
  result := TRue;

  SQL.Clear;
  SQL.add('SELECT');
  SQL.add(quotedstr(CUSTOMER_PAYMENT) + ' AS TYPE,');
  SQL.add('Concat_ws("", PaymentNo)  AS ReceiptNo,');
  SQL.add('D.GlobalRef              AS GlobalRef,');
  SQL.add('D.PaymentDate            AS PaymentDate,');
  SQL.add('C.Company                AS ClientName,');
  SQL.add('C.jobname                AS jobname,');
  SQL.add('D.Balance                AS OpeningBalance,');
  SQL.add('Amount                   AS PaymentAmount,');
  SQL.add('Amount                   AS Credit,');
  SQL.add('0.0                      AS Debit,');
  SQL.add('PM.Name                  AS PaymentMethod,');
  SQL.add('ReferenceNo              AS ReferenceNo,');
  SQL.add('AccountName              AS BankAccount,');
  SQL.add('ClassName                AS Department,');
  SQL.add('D.Notes                  AS Notes,');
  SQL.add('D.Deleted                AS Deleted,');
  SQL.add('D.ClassID                AS ClassID,');
  SQL.add('D.Reconciled             AS Reconciled,');
  SQL.add('ClientID                 AS ClientID,');
  SQL.add('PaymentID                AS PaymentID,');
  SQL.add('D.EmployeeID             AS EmployeeID,');
  SQL.add('D.AccountID              AS AccountID,');
  SQL.add('"F"                      AS ChequePrinted');
  SQL.add('FROM tbldeposits D');
  SQL.add('INNER JOIN tblclients          C   ON C.ClientID     = D.CusID');
  SQL.add('LEFT JOIN tblpaymentmethods    PM  ON PM.PayMethodID = D.PayMethodID');
  SQL.add('INNER JOIN tblchartofaccounts  COA ON COA.AccountID  = D.AccountID');
  SQL.add('INNER JOIN tblclass            CL  ON CL.ClassID = D.ClassID');
  SQL.add('WHERE CustomerPayment="T" AND D.Customer="T"');
  SQL.add('AND PaymentDate  Between ' + DateFromSQL + ' AND ' + DateToSQL);
  SQL.add(ClientIDSQL('D.CusID'));
  if not (Search = '') then
    SQL.Add('AND D.' + ReplaceAlias(Search));

  SQL.add('UNION all');

  SQL.add('SELECT');
  SQL.add(quotedstr(SUPPLIER_PAYMENT) + ' AS TYPE,');
  SQL.add('Concat_ws("",PaymentNo)  AS ReceiptNo,');
  SQL.add('W.GlobalRef              AS GlobalRef,');
  SQL.add('PaymentDate              AS PaymentDate,');
  SQL.add('Company                  AS ClientName,');
  SQL.add('C.jobname                AS jobname,');
  SQL.add('W.Balance                AS OpeningBalance,');
  SQL.add('Amount                   AS PaymentAmount,');
  SQL.add('0.0                      AS Credit,');
  SQL.add('Amount                   AS Debit,');
  SQL.add('PM.Name                  AS PaymentMethod,');
  SQL.add('ReferenceNo              AS ReferenceNo,');
  SQL.add('AccountName              AS BankAccount,');
  SQL.add('ClassName                AS Department,');
  SQL.add('W.Notes                  AS Notes,');
  SQL.add('W.Deleted                AS Deleted,');
  SQL.add('W.ClassID                AS ClassID,');
  SQL.add('W.Reconciled             AS Reconciled,');
  SQL.add('ClientID                 AS ClientID,');
  SQL.add('PaymentID                AS PaymentID,');
  SQL.add('W.EmployeeID             AS EmployeeID,');
  SQL.add('W.AccountID              AS AccountID ,');
  SQL.add('W.ChequePrinted          AS ChequePrinted');
  SQL.add('FROM tblWithdrawal W');
  SQL.add('INNER JOIN tblClients          C   ON C.ClientID     = W.SupplierID');
  SQL.add('LEFT JOIN tblpaymentmethods    PM  ON PM.PayMethodID = W.PayMethodID');
  SQL.add('INNER JOIN tblchartofaccounts  COA ON COA.AccountID  = W.AccountID');
  SQL.add('INNER JOIN tblclass            CL  ON CL.ClassID= W.ClassID');
  SQL.add('WHERE SupplierPayment="T" AND W.Supplier="T"');
  SQL.add('AND PaymentDate Between ' + DateFromSQL + ' AND ' + DateToSQL);
  SQL.add(ClientIDSQL('W.SupplierID'));
  if not (Search = '') then
    SQL.Add('AND W.' + ReplaceAlias(Search));

  SQL.add('UNION ALL');

  SQL.add('SELECT');
  SQL.add('if (PP.Customer = "T", ' + quotedstr(CUSTOMER_PREPAYMENT) + ', ' + quotedstr(SUPPLIER_PREPAYMENT) + ') AS TYPE,');
  SQL.add('Concat_ws("", PP.PrePaymentID) AS ReceiptNo,');
  SQL.add('PP.GlobalRef             AS GlobalRef,');
  SQL.add('PP.PrePaymentDate        AS PaymentDate,');
  SQL.add('PP.CompanyName           AS ClientName,');
  SQL.add('C.jobname                AS jobname,');
  SQL.add('0                        AS OpeningBalance,');
  SQL.add('PP.Balance               AS PaymentAmount,');
  SQL.add('if (PP.Customer = "T", PP.Balance ,0.0) AS Credit,');
  SQL.add('if (PP.Customer = "T", 0.0, PP.Balance) AS Debit,');
  SQL.add('PM.Name                  AS PaymentMethod,');
  SQL.add('PP.ReferenceNo           AS ReferenceNo,');
  SQL.add('null                     AS BankAccount,');
  SQL.add('ClassName                AS Department,');
  SQL.add('PP.Notes                 AS Notes,');
  SQL.add('PP.Deleted               AS Deleted,');
  SQL.add('PP.ClassID               AS ClassID,');
  SQL.add('PP.Reconciled             AS Reconciled,');
  SQL.add('PP.ClientID              AS ClientID,');
  SQL.add('PP.PrePaymentID          AS PaymentID,');
  SQL.add('PP.EmployeeID            AS EmployeeID,');
  SQL.add('null                     AS AccountID ,');
  SQL.add('"F"                      AS ChequePrinted');
  SQL.add('FROM tblprepayments PP');
  SQL.add('INNER JOIN tblClients        C  ON C.ClientID    = PP.ClientID');
  SQL.add('LEFT JOIN tblpaymentmethods  PM ON PM.PayMethodID= PP.PayMethodID');
  SQL.add('INNER JOIN tblclass          CL ON CL.ClassID    = PP.ClassID');
  SQL.add('WHERE PP.PrePaymentDate Between ' + DateFromSQL + ' AND ' + DateToSQL);
  SQL.add(ClientIDSQL('PP.ClientID'));
  if not (Search = '') then
    SQL.Add('AND PP.' + ReplaceAlias2(Search));

  if not (OrderBy = '') then
    SQL.Add('ORDER BY ' + OrderBy)
  else
    SQL.add('ORDER BY ClientName, PaymentDate DESC');

end;


initialization
  RegisterClass(TPaymentList);
end.
