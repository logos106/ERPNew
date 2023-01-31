unit RecLib;

interface

function ToBeReconciledWithdrawalSQL(aAccountID:Integer;FilterLinesDate:TDateTime; FilterLinesforDate:Boolean; ListofToBeReconciled,UseStatements:Boolean; ReconciliationID:Integer):String;Overload;
function ToBeReconciledDepositsSQL(aAccountID:Integer;FilterLinesDate:TDateTime; FilterLinesforDate:Boolean; ListofToBeReconciled,UseStatements:Boolean; ReconciliationID:Integer):String;Overload;

function ToBeReconciledWithdrawalSQL(FilterLinesDate:TDateTime; FilterLinesforDate:Boolean; ListofToBeReconciled,UseStatements:Boolean; ReconciliationID:Integer):String;Overload;
function ToBeReconciledDepositsSQL(FilterLinesDate:TDateTime; FilterLinesforDate:Boolean; ListofToBeReconciled,UseStatements:Boolean; ReconciliationID:Integer):String;Overload;

implementation

uses CommonLib, sysutils, MySQLConst, tcConst, LogLib;

function ToBeReconciledWithdrawalSQL(aAccountID:Integer;FilterLinesDate:TDateTime; FilterLinesforDate:Boolean; ListofToBeReconciled,UseStatements:Boolean; ReconciliationID:Integer): String;
begin
  Result := ToBeReconciledWithdrawalSQL(FilterLinesDate, FilterLinesforDate, ListofToBeReconciled, UseStatements, ReconciliationID);
  Result := ReplaceStr(Result, ':XAccountID', InttoStr(aAccountID));
end;


function ToBeReconciledDepositsSQL(aAccountID:Integer;FilterLinesDate:TDateTime; FilterLinesforDate:Boolean; ListofToBeReconciled,UseStatements:Boolean; ReconciliationID:Integer):String;
begin
  Result := ToBeReconciledDepositsSQL(FilterLinesDate,FilterLinesforDate,ListofToBeReconciled,UseStatements, ReconciliationID);
  Result := replaceStr(Result , ':XAccountID' , inttostr(aAccountID));
end;


function ToBeReconciledWithdrawalSQL(FilterLinesDate:TDateTime; FilterLinesforDate:Boolean; ListofToBeReconciled,UseStatements:Boolean; ReconciliationID:Integer):String;
    Function BDnBDLTable                  (FilterBDAccount:Boolean)                         :String;begin  Result := 'FROM tblbankdeposit BD INNER JOIN tblbankdepositlines BDL Using (DepositID)  WHERE '+
                                                                                                                      iif(FilterBDAccount, 'BD.AccountID' , 'BDL.AccountID')+' = :xAccountID  ' ;end;
    function FilterForListofToBeReconciled(afieldName:String)                               :String;begin  Result := '';  if ListofToBeReconciled      then Result := Result +' AND '+aFieldname +' <> "T"  ' ;end;
    Function FilterLinesforDateCond       (aFieldname:String)                               :String;begin  Result := '';  if FilterLinesforDate        then Result := ' AND '+afieldname+' <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, FilterLinesDate));end;
    Function FieldReconciled              (const aFieldname:String)                         :String;begin  Result := '';  if not(ListofToBeReconciled) then Result := aFieldname +',';end;
    Function CustomerField                (SingleOrNocusIDValue, MultipleCusIDValue:String) :String;begin  Result := 'If((Max(CusID)-Min(CusID)=0) OR IsNull(CusID) ,'+SingleOrNocusIDValue+','+MultipleCusIDValue+') ';end;
    Function CUSIDField                                                                     :String;begin  Result := 'If(IsNull(CusID),0,CusID) as CusID,';end;
    Function BlankStatementfields                                                           :string;begin  Result :=  '0 AS StatementLineID,null AS StatementTransactionDate,null AS StatementAmount,null AS StatementDescription ';end;
begin
    Result := '';
    Result := Result +'SELECT   ' +
                       FieldReconciled('BDL.Reconciled')+
                       '1'                                                  +' as Seqno, ' +
                       CustomerField('BDL.TrnsType' ,'"Split Deposit"')     +' as Notes, ' +
                       'BD.DepositID'                                       +' as DepositID,' +
                       'BDL.DepositLineID'                                  +' as DepositLineID,' +
                       'DepositDate'                                        +' as DepositDate, ' +
                       'BDL.TrnsType '                                      +' as TransactionType,' +
                       'ABS(Amount)'                                        +' as Amount, ' +
                       'PaymentID'                                          +' as PaymentID,' +
                       CUSIDField+
                       CustomerField('BDL.ReferenceNo' ,'""')               +' as ReferenceNo, ' +
                       CustomerField('BDL.CompanyName' ,'""')               +' as CompanyName, ' +
                       BlankStatementfields+
                       BDnBDLTable(False)+
                       FilterForListofToBeReconciled('BDL.Reconciled')+
                       ' AND BDL.TrnsType<>"Deposit Entry" ' +
                                            ' AND BDL.TrnsType<>"Cheque"  ' +
                                            ' AND BDL.TrnsType<>"Cheque Deposit" ' +
                                            ' AND BDL.TrnsType<> '+quotedstr(CUSTOMER_PREPAYMENT)+'  ' +
                                            ' AND BDL.TrnsType<>'+ quotedstr(SUPPLIER_PREPAYMENT) + '   ' +
                                            ' AND BD.Deleted <>"T"  ' +
                                            ' AND FromDeposited<>"T" ' +
                                            ' AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 '+
                       FilterLinesforDateCond('DepositDate')+
                       ' GROUP BY BDL.DepositLineID ';


    //Bank Deposit
    Result := Result + NL + ' UNION ALL SELECT   ' +
                       FieldReconciled('BD.Reconciled')+
                       '2 '                     +' as Seqno, ' +
                       '"Bank Deposit" '        +' as Notes, ' +
                       'BD.DepositID '          +' as DepositID,' +
                       '0 '                     +' as DepositLineID,' +
                       'DepositDate '           +' as DepositDate, ' +
                       'BDL.TrnsType '                                      +' as TransactionType,' +
                       'ABS(Deposit) '          +' as Amount, ' +
                       'BD.DepositID '          +' as PaymentID,' +
                       CUSIDField+
                       'BD.Notes '              +' as ReferenceNo, ' +
                       '"" '                    +' as CompanyName, ' +
                       BlankStatementfields+
                       BDnBDLTable(true)+
                       FilterForListofToBeReconciled('BD.Reconciled')+
                       ' AND BDL.TrnsType<>"Deposit Entry"      AND BDL.TrnsType<>"Cheque" ' +
                                                              ' AND BDL.TrnsType<> '+quotedstr(CUSTOMER_PREPAYMENT)+'   ' +
                                                              ' AND BDL.TrnsType<>'+ quotedstr(SUPPLIER_PREPAYMENT) + '   ' +
                                                              ' AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 AND FromDeposited="T" ' +
                                                              ' AND BD.Deleted <>"T" '+
                       FilterLinesforDateCond('DepositDate')+
                       ' Group By  BD.DepositID ';

    //Deposit Entry
    Result := Result + NL + 'UNION ALL SELECT   '+
                       FieldReconciled('BD.Reconciled')+
                       '3 '                                               +' as Seqno, ' +
                       CustomerField('BDL.TrnsType' ,'"Deposit Entry"')+''+' as Notes, ' +
                       'BD.DepositID '                                    +' as DepositID,' +
                       '0 '                                               +' as DepositLineID,' +
                       'DepositDate '                                     +' as DepositDate, ' +
                       'BDL.TrnsType '                                      +' as TransactionType,' +
                       'ABS(Deposit) '                                    +' as Amount, ' +
                       'BD.DepositID '                                    +' as PaymentID,' +
                       CUSIDField+
                       CustomerField('BDL.ReferenceNo' ,'""')             +' as ReferenceNo, ' +
                       CustomerField('BDL.CompanyName' ,'""')             +' as CompanyName, ' +
                       BlankStatementfields+
                       BDnBDLTable(true)+
                       FilterForListofToBeReconciled('BD.Reconciled')+    ' AND BDL.TrnsType="Deposit Entry" ' +
                                                                          ' AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 ' +
                                                                          ' AND BD.Deleted <>"T"  '+
                       FilterLinesforDateCond('DepositDate')+
                       ' Group By  BD.DepositID ';

    //Deposit Entry Split
    Result := Result + NL + ' UNION ALL SELECT   ' +
                       FieldReconciled('BDL.Reconciled')+
                       '4 '                                         +' as Seqno, ' +
                       '"Split Deposit" '                           +' as Notes, ' +
                       'BD.DepositID '                              +' as DepositID,' +
                       'DepositLineID '                             +' as DepositLineID,' +
                       'DepositDate '                               +' as DepositDate, ' +
                       'BDL.TrnsType '                                      +' as TransactionType,' +
                       'ABS(Amount) '                               +' as Amount, ' +
                       'BD.DepositID '                              +' as PaymentID,' +
                       CUSIDField+
                       CustomerField('BDL.ReferenceNo' ,'""')       +' as ReferenceNo, ' +
                       CustomerField('BDL.CompanyName' ,'""')       +' as CompanyName, ' +
                       BlankStatementfields+
                       BDnBDLTable(False)+
                       FilterForListofToBeReconciled('BDL.Reconciled')+' AND BDL.TrnsType="Deposit Entry" ' +
                                                                       'AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 ' +
                                                                       'AND BD.Deleted <>"T"  '+
                       FilterLinesforDateCond('DepositDate')+
                       ' Group By BDL.DepositLineID  ';

    //Supplier Prepayment
    Result := Result + NL + 'UNION ALL  SELECT   ' +
                       FieldReconciled('BDL.Reconciled')+
                       '5 '                                                 +' as Seqno, ' +
                       CustomerField('BDL.TrnsType' ,'"Split Deposit"')     +' as Notes, ' +
                       'BD.DepositID '                                      +' as DepositID,' +
                       'BDL.DepositLineID '                                 +' as DepositLineID,' +
                       'DepositDate '                                       +' as DepositDate, ' +
                       'BDL.TrnsType '                                      +' as TransactionType,' +
                       'ABS(Sum(Amount)) '                                  +' as Amount, ' +
                       'PaymentID '                                         +' as PaymentID,' +
                       CUSIDField+
                       CustomerField('BDL.ReferenceNo' ,'""')               +' as ReferenceNo, ' +
                       CustomerField('BDL.CompanyName' ,'""')               +' as CompanyName,  ' +
                       BlankStatementfields+
                       BDnBDLTable(False)+
                       FilterForListofToBeReconciled('BDL.Reconciled')+'AND BDL.TrnsType='+ quotedstr(SUPPLIER_PREPAYMENT) + '   ' +
                                                                        'AND BD.Deleted <>"T" AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 '+
                       FilterLinesforDateCond('DepositDate')+
                       ' Group By BDL.DepositLineID  ';

    //Customer Prepayment
    Result := Result + NL + ' UNION ALL SELECT   ' +
                       FieldReconciled('BDL.Reconciled')+
                       '6 '                                                +' as Seqno, ' +
                       CustomerField('BDL.TrnsType' ,'"Deposit Entry"')    +' as Notes, ' +
                       'BD.DepositID '                                     +' as DepositID,' +
                       'BDL.DepositLineID '                                +' as DepositLineID,' +
                       'DepositDate '                                      +' as DepositDate,  ' +
                        'BDL.TrnsType '                                      +' as TransactionType,' +
                      'ABS(Deposit) '                                     +' as Amount, ' +
                       'BD.DepositID '                                     +' as PaymentID,' +
                       CUSIDField+
                       CustomerField('BDL.ReferenceNo' ,'""')              +' as ReferenceNo, ' +
                       CustomerField('BDL.CompanyName' ,'""')              +' as CompanyName, ' +
                       BlankStatementfields+
                       BDnBDLTable(true)+
                       FilterForListofToBeReconciled('BDL.Reconciled')+   ' AND BDL.TrnsType= '+quotedstr(CUSTOMER_PREPAYMENT)+'  ' +
                                                                          ' AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 ' +
                                                                          ' AND BD.Deleted <>"T"  '+
                       FilterLinesforDateCond('DepositDate')+
                       ' Group By BDL.DepositLineID ';

    //Cheques
    Result := Result + NL + 'UNION ALL  SELECT   ' +
                        FieldReconciled('BD.Reconciled')+
                        '7 '                                                +' as Seqno, ' +
                        CustomerField('BDL.TrnsType' ,'"Split Deposit"')    +' as Notes, ' +
                        'BD.DepositID '                                     +' as DepositID,' +
                        '0 '                                                +' as DepositLineID,' +
                        'DepositDate '                                      +' as DepositDate, ' +
                        'BDL.TrnsType '                                     +' as TransactionType,' +
                  //      'BDL.Amount'                                     +' as Amount, ' +
                       'if(BDL.TrnsType="Cheque", 0-Deposit, abs(Deposit))  as Amount, ' +
                        'PaymentID '                                        +' as PaymentID,' +
                        CUSIDField+
                        CustomerField('BDL.ReferenceNo' ,'""')              +' as ReferenceNo, ' +
                        CustomerField('BDL.CompanyName' ,'""')              +' as CompanyName,  ' +
                        BlankStatementfields+
                        BDnBDLTable(true)+
                        FilterForListofToBeReconciled('BD.Reconciled')+ ' AND BDL.TrnsType="Cheque" ' +
                                                                        ' AND BD.Deleted <>"T" ' +
 //                                                                       ' AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 '+
                        FilterLinesforDateCond('DepositDate')+
                        ' Group By BD.DepositID  '; //Not BDL.DepositLineID  Because Sum Of Cheque Header Account

    //Cheque Deposits
    Result := Result + NL + 'UNION ALL SELECT   ' +
                        FieldReconciled('BD.Reconciled')+
                        '8 '                                                +' as Seqno, ' +
                        CustomerField('BDL.TrnsType' ,'"Deposit Entry"')    +' as Notes, ' +
                        'BD.DepositID '                                     +' as DepositID,' +
                        'BDL.DepositLineID '                                +' as DepositLineID,' +
                        'DepositDate '                                      +' as DepositDate, ' +
                       'BDL.TrnsType '                                      +' as TransactionType,' +
//                        'Sum(Amount) '                                 +' as Amount, ' +
                        'ABS(Sum(Amount)) '                                 +' as Amount, ' +
                        'PaymentID '                                        +' as PaymentID,' +
                        CUSIDField+
                        CustomerField('BDL.ReferenceNo' ,'""')              +' as ReferenceNo, ' +
                        CustomerField('BDL.CompanyName' ,'""')              +' as CompanyName, ' +
                        BlankStatementfields+
                        BDnBDLTable(true)+
                        FilterForListofToBeReconciled('BD.Reconciled')+ ' AND BDL.TrnsType="Cheque Deposit" ' +
                                                                        ' AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 ' +
                                                                        ' AND BD.Deleted <>"T"  '+
                        FilterLinesforDateCond('DepositDate')+
                        ' Group By BDL.DepositLineID ';

    if UseStatements then begin
      Result := Result + NL + 'UNION ALL SELECT   ' +
                            FieldReconciled('Null')+
                             '0 '+' as Seqno, ' +
                              'bsl.DescriptionSimple '+' as Notes, ' +
                              '0 '                    +' as DepositID, ' +
                              '0 '                    +' as DepositLineID, ' +
                              'bsl.TransactionDate '+' as DepositDate, ' +
                       'BSL.Type '                                      +' as TransactionType,' +
                              'bsl.Amount '+' as Amount, ' +
                              '0 '+' as PaymentID, ' +
                              '0 '+' as CusID, ' +
                              'null '+' as ReferenceNo, ' +
                              'null '+' as CompanyName, ' +
                              'bsl.ID '+' as StatementLineID, ' +
                              'bsl.TransactionDate '+' as StatementTransactionDate, ' +
                              'bsl.Amount '+' as StatementAmount, ' +
                              'bsl.DescriptionSimple '+' as StatementDescription ' +
                              'from  tblbankstatementline bsl ' +
                              'where bsl.AccountID = :xAccountID ' +
                              'and bsl.Active = "T"' +
                              'and bsl.BaseType = "DEBIT" ' +
                              'and IfNull(bsl.ReconciliationLineID,0) = 0 ' +
                              FilterLinesforDateCond('bsl.TransactionDate');
    end;

    Result := Result + NL +' Order by DepositDate';
    LogText('Wihdrawal = ' + NL + Result);
end;



{ TToBeReconciledDeposit }
function ToBeReconciledDepositsSQL(FilterLinesDate:TDateTime; FilterLinesforDate:Boolean; ListofToBeReconciled,UseStatements:Boolean; ReconciliationID:Integer):String;
    Function BDnBDLTable                  (FilterBDAccount:Boolean)                         :String;begin  Result := 'FROM tblbankdeposit BD INNER JOIN tblbankdepositlines BDL Using (DepositID)  WHERE '+
                                                                                                                      iif(FilterBDAccount, 'BD.AccountID' , 'BDL.AccountID')+' = :xAccountID  ' ;end;
    function FilterForListofToBeReconciled(afieldName:String)                               :String;begin  Result := '';  if ListofToBeReconciled      then Result := ' AND '+aFieldname +' <> "T"  ' ;end;
    Function FilterLinesforDateCond       (aFieldname:String)                               :String;begin  Result := '';  if FilterLinesforDate        then Result := ' AND '+afieldname+' <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, FilterLinesDate));end;
    Function FieldReconciled              (const aFieldname:String)                         :String;begin  Result := '';  if not(ListofToBeReconciled) then Result := aFieldname +' as Reconciled,';end;
    Function CustomerField                (SingleOrNocusIDValue, MultipleCusIDValue:String) :String;begin  Result := 'If((Max(CusID)-Min(CusID)=0) OR IsNull(CusID) ,'+SingleOrNocusIDValue+','+MultipleCusIDValue+') ';end;
    Function CUSIDField                                                                     :String;begin  Result := 'If(IsNull(CusID),0,CusID) as CusID,';end;
    Function BlankStatementfields                                                           :string;begin  Result :=  '0 AS StatementLineID,null AS StatementTransactionDate,null AS StatementAmount,null AS StatementDescription ';end;
begin
    Result := '';
    Result := Result +' SELECT  '+
                        FieldReconciled('BDL.Reconciled')+
                        '1'                                                 +' AS Seqno,  ' +
                        CustomerField('BDL.TrnsType','"Split Deposit"') +'' +' AS Notes, ' +
                        'BD.DepositID'                                      +' AS DepositID,' +
                        'BDL.DepositLineID'                                 +' AS DepositLineID,' +
                        'DepositDate'                                     +' AS DepositDate, ' +
                       'BDL.TrnsType '                                      +' as TransactionType,' +
                        'ABS(Amount)'                                     +' AS Amount, ' +
                        'PaymentID'                                     +' AS PaymentID,' +
                        CUSIDfield+
                        CustomerField('BDL.ReferenceNo' ,'""')+''           +' AS ReferenceNo, ' +
                        CustomerField('BDL.CompanyName' ,'""')+''           +' AS CompanyName, ' +
                        BlankStatementfields+
                        BDnBDLTable(False)+//'FROM tblbankdeposit BD INNER JOIN tblbankdepositlines BDL Using (DepositID) WHERE BDL.AccountID = :xAccountID   ' +
                         FilterForListofToBeReconciled('BDL.Reconciled')+
                        ' AND BDL.TrnsType<>"Deposit Entry" ' +
                        ' AND BDL.TrnsType<>"Cheque Deposit" ' +
                        ' AND BDL.TrnsType<>"Cheque" ' +
                        ' AND BDL.TrnsType<> '+quotedstr(CUSTOMER_PREPAYMENT)+'   ' +
                        ' AND BDL.TrnsType<>'+ quotedstr(SUPPLIER_PREPAYMENT) + '   ' +
                        ' AND FromDeposited<>"T" ' +
                        ' AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00  ' +
                        ' AND BD.Deleted <>"T"  '+
                        FilterLinesforDateCond('DepositDate')+
                        ' Group By BDL.DepositLineID ';


      //Customer Prepayment
      Result := Result +NL + ' UNION ALL  '+
                          'SELECT  '+ FieldReconciled('BDL.Reconciled')+
                          '2'                                                 +' AS Seqno,  ' +
                          CustomerField('BDL.TrnsType' ,'"Deposit Entry"')+'' +' AS Notes, ' +
                          'BD.DepositID '                                     +' AS DepositID,' +
                          'BDL.DepositLineID'                                 +' AS DepositLineID,' +
                          'DepositDate  '                                     +' AS DepositDate, ' +
                        'BDL.TrnsType '                                      +' as TransactionType,' +
                         'ABS(Deposit) '                                     +' AS Amount, ' +
                          'BD.DepositID '                                     +' AS PaymentID,' +
                          CUSIDfield+
                          CustomerField('BDL.ReferenceNo' ,'""')+''           +' AS ReferenceNo, ' +
                          CustomerField('BDL.CompanyName' ,'""')+''           +' AS CompanyName, ' +
                          BlankStatementfields+
                          BDnBDLTable(False)+//'FROM tblbankdeposit BD INNER JOIN tblbankdepositlines BDL Using (DepositID)  WHERE BDL.AccountID = :xAccountID    ' +
                          FilterForListofToBeReconciled('BDL.Reconciled')+
                          'AND BDL.TrnsType= '+quotedstr(CUSTOMER_PREPAYMENT)+'  ' +
                          'AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 ' +
                          'AND BD.Deleted <>"T"  '+
                          FilterLinesforDateCond('DepositDate')+
                          ' Group By BDL.DepositLineID ';



      //Supplier Prepayment
      Result := Result + NL  + ' UNION ALL ' +
                          'SELECT   '+ FieldReconciled('BDL.Reconciled')+
                          '3'                                                 +' AS Seqno,  ' +
                          CustomerField('BDL.TrnsType' ,'"Split Deposit"') +' AS Notes, ' +
                          'BD.DepositID '                                     +' AS DepositID  ,' +
                          'BDL.DepositLineID'                                 +' AS DepositLineID,' +
                          'DepositDate  '                                     +' AS DepositDate, ' +
                       'BDL.TrnsType '                                      +' as TransactionType,' +
                          'ABS(Sum(Amount))'                                  +' AS Amount, ' +
                          'PaymentID    '                                     +' AS PaymentID,' +
                          CUSIDfield+
                          CustomerField('BDL.ReferenceNo' ,'""')+''           +' AS ReferenceNo, ' +
                          CustomerField('BDL.CompanyName' ,'""')+''           +' AS CompanyName,  ' +
                          BlankStatementfields+
                          BDnBDLTable(False)+//'FROM tblbankdeposit BD  INNER JOIN tblbankdepositlines BDL Using (DepositID)  WHERE BDL.AccountID = :xAccountID  ' +
                          FilterForListofToBeReconciled('BDL.Reconciled')+
                          ' AND BDL.TrnsType='+ quotedstr(SUPPLIER_PREPAYMENT) + '   ' +
                          'AND BD.Deleted <>"T" AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 '+
                          FilterLinesforDateCond('DepositDate')+
                          ' Group By BDL.DepositLineID  ';

      //Deposit Entry
      Result := Result + NL  + ' UNION ALL  ' +
                          'SELECT   '+ FieldReconciled('BD.Reconciled')+
                          '4'                                                 +' AS Seqno,  ' +
                          CustomerField('BDL.TrnsType' ,'"Deposit Entry"')+'' +' AS Notes, ' +
                          'BD.DepositID '                                     +' AS DepositID,' +
                          '0'                                                 +' AS DepositLineID,' +
                          'DepositDate  '                                     +' AS DepositDate  , ' +
                       'BDL.TrnsType '                                      +' as TransactionType,' +
                          'ABS(Deposit) '                                     +' AS Amount, ' +
                          'BD.DepositID '                                     +' AS PaymentID,' +
                          CUSIDfield+
                          CustomerField('BDL.ReferenceNo' ,'""')+''           +' AS ReferenceNo, ' +
                          CustomerField('BDL.CompanyName' ,'""')+''           +' AS CompanyName, ' +
                          BlankStatementfields+
                          BDnBDLTable(true)+//'FROM tblbankdeposit BD INNER JOIN tblbankdepositlines BDL Using (DepositID) WHERE BD.AccountID = :xAccountID  ' +
                          FilterForListofToBeReconciled('BD.Reconciled')+
                          ' AND BDL.TrnsType="Deposit Entry" ' +
                          'AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 ' +
                          'AND BD.Deleted <>"T"  '+
                          FilterLinesforDateCond('DepositDate')+
                          ' Group By  BD.DepositID ';

      //Deposit Entry Split
      Result := Result + NL  + 'UNION ALL ' +
                          'SELECT   '+ FieldReconciled('BDL.Reconciled')+
                          '5'                                               +' AS Seqno,  ' +
                          '"Split Deposit"'                                 +' AS Notes, ' +
                          'BD.DepositID'                                    +' AS DepositID,' +
                          'DepositLineID'                                   +' AS DepositLineID,' +
                          'DepositDate'                                     +' AS DepositDate, ' +
                       'BDL.TrnsType '                                      +' as TransactionType,' +
                          'ABS(Amount)'                                     +' AS Amount, ' +
                          'BD.DepositID'                                    +' AS PaymentID,' +
                          CUSIDfield+
                          CustomerField('BDL.ReferenceNo' ,'""')+''         +' AS ReferenceNo, ' +
                          CustomerField('BDL.CompanyName' ,'""')+''         +' AS CompanyName, ' +
                          BlankStatementfields+
                          BDnBDLTable(False)+//'FROM tblbankdeposit BD INNER JOIN tblbankdepositlines BDL Using (DepositID) WHERE BDL.AccountID = :xAccountID  ' +
                          FilterForListofToBeReconciled('BDL.Reconciled')+
                          ' AND BDL.TrnsType="Deposit Entry" ' +
                          'AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 ' +
                          'AND BD.Deleted <>"T"  '+
                          FilterLinesforDateCond('DepositDate')+
                          ' Group By BDL.DepositLineID  ';

      //Bank Deposit
      Result := Result + NL  + ' UNION ALL ' +
                          'SELECT   '+ FieldReconciled('BD.Reconciled ')+
                          '6'                                                         +' AS Seqno,  ' +
                          '"Bank Deposit"       '                                     +' AS Notes, ' +
                          'BD.DepositID         '                                     +' AS DepositID,' +
                          '0'                                                         +' AS DepositLineID,' +
                          'DepositDate'                                               +' AS DepositDate  , ' +
                       'BDL.TrnsType '                                      +' as TransactionType,' +
                          'ABS(Deposit)         '                                     +' AS Amount, ' +
                          'BD.DepositID         '                                     +' AS PaymentID, ' +
                          'CusID    '                                                 +' AS CusID, ' +
                          'BD.Notes '                                                 +' AS ReferenceNo, ' +
                          '""       '                                                 +' AS CompanyName, ' +
                          BlankStatementfields+
                          BDnBDLTable(true)+//'FROM tblbankdeposit BD INNER JOIN tblbankdepositlines BDL Using (DepositID) WHERE BD.AccountID = :xAccountID    ' +
                          FilterForListofToBeReconciled('BD.Reconciled')+
                          ' AND BDL.TrnsType<>"Deposit Entry" AND BDL.TrnsType<>"Cheque Deposit" ' +
                          'AND BDL.TrnsType<> '+quotedstr(CUSTOMER_PREPAYMENT)+'  AND BDL.TrnsType<>'+ quotedstr(SUPPLIER_PREPAYMENT) + '   ' +
                          'AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 AND FromDeposited="T" ' +
                          'AND BD.Deleted <>"T" '+
                          FilterLinesforDateCond('DepositDate')+
                          ' Group By  BD.DepositID ';

      //Cheques
//      Result := Result + NL  + ' UNION ALL  ' +
//                          'SELECT   '+ FieldReconciled('BD.Reconciled ')+
//                          '7'                                                 +' AS Seqno,  ' +
//                          CustomerField('BDL.TrnsType' ,'"Split Deposit"') +' AS Notes, ' +
//                          'BD.DepositID '                                     +' AS DepositID  ,' +
//                          '0'                                                 +' AS DepositLineID,' +
//                          'DepositDate  '                                     +' AS DepositDate, ' +
//                        'BDL.TrnsType '                                      +' as TransactionType,' +
//                      //   'BDL.Amount'                                     +' AS Amount, ' +
//                          'if(BDL.TrnsType="Cheque", 0-Deposit, abs(Deposit))  as Amount, ' +
//                          // 0 AS DepositLineID Due To
//                          'PaymentID    '                                     +' AS PaymentID,' +
//                          CUSIDfield+
//                          CustomerField('BDL.ReferenceNo' ,'""')+''           +' AS ReferenceNo, ' +
//                          CustomerField('BDL.CompanyName' ,'""')+''           +' AS CompanyName,  ' +
//                          BlankStatementfields+
//                          BDnBDLTable(true)+//'FROM tblbankdeposit BD  INNER JOIN tblbankdepositlines BDL Using (DepositID) WHERE BD.AccountID = :xAccountID  ' +
//                          FilterForListofToBeReconciled('BD.Reconciled')+
//                          'AND BDL.TrnsType="Cheque" ' +
//                          'AND BD.Deleted <>"T" ' +
//                          'AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 '+
//                          FilterLinesforDateCond('DepositDate')+
//                          ' Group By BD.DepositID  '; //Not BDL.DepositLineID  Because Sum Of Cheque Header Account

      //Cheque Deposits
      Result := Result + NL  + ' UNION ALL  ' +
                          'SELECT   '+ FieldReconciled('BD.Reconciled ')+
                          '8'                                                 +' AS Seqno,  ' +
                          CustomerField('BDL.TrnsType' ,'"Deposit Entry"')+'' +' AS Notes, ' +
                          'BD.DepositID '                                     +' AS DepositID,' +
                          'BDL.DepositLineID'                                 +' AS DepositLineID,' +
                          'DepositDate  '                                     +' AS DepositDate, ' +
                       'BDL.TrnsType '                                      +' as TransactionType,' +
//                          'Sum(Amount)'                                  +' AS Amount, ' +
                          'ABS(Sum(Amount))'                                  +' AS Amount, ' +
                          'PaymentID    '                                     +' AS PaymentID,' +
                          CUSIDfield+
                          CustomerField('BDL.ReferenceNo' ,'""')+''           +' AS ReferenceNo, ' +
                          CustomerField('BDL.CompanyName' ,'""')+''           +' AS CompanyName, ' +
                          BlankStatementfields+
                          BDnBDLTable(True)+//'FROM tblbankdeposit BD INNER JOIN tblbankdepositlines BDL Using (DepositID) WHERE BD.AccountID = :xAccountID   ' +
                          FilterForListofToBeReconciled('BD.Reconciled')+
                          ' AND BDL.TrnsType="Cheque Deposit" ' +
                          'AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 ' +
                          'AND BD.Deleted <>"T"  '+
                          FilterLinesforDateCond('DepositDate')+
                          ' group by BDL.DepositLineID ';

    if UseStatements then begin
      Result := Result + NL  + 'UNION ALL ' +
                          'SELECT   '+ FieldReconciled('Null')+
                          '0'                                 +' AS Seqno,  ' +
                          'bsl.DescriptionSimple'             +' AS Notes, ' +
                          '0'                                 +' AS DepositID, ' +
                          '0'                                 +' AS DepositLineID, ' +
                          'bsl.TransactionDate'               +' AS DepositDate, ' +
                          'BSL.Type '                         +' as TransactionType,' +
                          'bsl.Amount'                        +' AS Amount, ' +
                          '0'                                 +' AS PaymentID, ' +
                          '0'                                 +' AS CusID, ' +
                          'null'                              +' AS ReferenceNo, ' +
                          'null'                              +' AS CompanyName, ' +
                          'bsl.ID'                            +' AS StatementLineID, ' +
                          'bsl.TransactionDate'               +' AS StatementTransactionDate, ' +
                          'bsl.Amount'                        +' AS StatementAmount, ' +
                          'bsl.DescriptionSimple'             +' AS StatementDescription ' +
//                          'from  tblbankstatementline bsl left join tblReconciliationDepositLines rdl on rdl.ReconciliationLineID = bsl.ReconciliationLineID where bsl.AccountID = :xAccountID ' +
//                          'and bsl.Active = "T"' +
//                          'and bsl.BaseType = "CREDIT"' +
//                          'and ((IfNull(bsl.ReconciliationLineID,0) = 0) or (IfNull(rdl.ReconciliationId,0) > 0 and rdl.ReconciliationId = ' + IntToStr(ReconciliationID)+ '))'+
//                          FilterLinesforDateCond('bsl.TransactionDate');
                          'from  tblbankstatementline bsl where bsl.AccountID = :xAccountID ' +
                          'and bsl.Active = "T"' +
                          'and bsl.BaseType = "CREDIT"' +
                          'and IfNull(bsl.ReconciliationLineID,0) = 0 '+
                          FilterLinesforDateCond('bsl.TransactionDate');
    end;

    Result := Result + NL +' Order by DepositDate';
        LogText('Deposit = ' + NL + Result);
end;


end.
