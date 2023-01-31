unit ReconcilitaionLib;

interface

Function ToBeREconciled(Const AccountID:Integer;DateFilter:boolean; ToDate :Tdatetime;ShowReconciled:Boolean):String;

implementation

uses FastFuncs,Classes, SysUtils, MySQLConst, tcConst;

Function ToBeREconciled(Const AccountID:Integer;DateFilter:boolean; ToDate :Tdatetime;ShowReconciled:Boolean):String;
var
  strList:TStringList;
  Function Reconciledfilter(const Value:String):string;
  begin
      if   ShowReconciled then result := ' ' else result := ' AND ' + Value +' <> "T"'; 
  end;
  function AccountIDFilter(Tablealias :String) :String;
  begin
      if AccountId = 0 then
      else REsult := ' AND ' + Tablealias  +'.AccountId =' +IntToStr(AccountID) +  '  ' ;
  end;
  function AccountIDfield(Tablealias :String) :String;
  begin
      REsult := Tablealias  +'.AccountId' ;
  end;
begin
  strList:=TStringList.create;
  Try
    StrList.add('SELECT tblbankdepositlines.Reconciled, ' +
    AccountIDfield('tblbankdepositlines') + ' as AccountId , ' +
      '"Deposit" as Category, tblbankdeposit.DepositID,tblbankdepositlines.DepositLineID,DepositDate, ' +
      'ABS(Amount) as Amount, PaymentID,If(IsNull(CusID),0,CusID) as CusID,' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.TrnsType ,"Split Deposit") as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName ' +
       'FROM tblbankdeposit ' +
       'INNER JOIN tblbankdepositlines Using (DepositID) ' +
       'WHERE   tblbankdepositlines.TrnsType<>"Deposit Entry" ' +
       'AND tblbankdepositlines.TrnsType<>"Cheque Deposit" ' +
       'AND tblbankdepositlines.TrnsType<>"Cheque" ' +
       'AND tblbankdepositlines.TrnsType<>"'+CUSTOMER_PREPAYMENT+'"  ' +
       'AND tblbankdepositlines.TrnsType<>"Supplier Prepayment" ' +
       'AND FromDeposited<>"T" ' +
       'AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00  ' +
       'AND tblbankdeposit.Deleted <>"T"  ' +
       AccountIDFilter('tblbankdepositlines') +
        Reconciledfilter('  tblbankdepositlines.Reconciled ') );

      if DateFilter then
        StrList.add('AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, Todate)));

      StrList.add('Group By tblbankdepositlines.DepositLineID ');

    //Customer Prepayment
    StrList.add('UNION ALL ' +
      'SELECT  tblbankdepositlines.Reconciled,' +
      AccountIDfield('tblbankdepositlines') + ' as AccountId ,' +
      '"Deposit" as Category, tblbankdeposit.DepositID,tblbankdepositlines.DepositLineID,DepositDate, ABS(Deposit) as Amount, ' +
      'tblbankdeposit.DepositID as PaymentID,If(IsNull(CusID),0,CusID) as CusID,' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.TrnsType ,"Deposit Entry") as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName ' +
       'FROM tblbankdeposit ' +
       'INNER JOIN tblbankdepositlines Using (DepositID) ' +
       'WHERE    tblbankdepositlines.TrnsType="'+CUSTOMER_PREPAYMENT+'" ' +
       'AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 ' +
       'AND tblbankdeposit.Deleted <>"T"  ' +
       AccountIDFilter('tblbankdepositlines') +
       Reconciledfilter(' tblbankdepositlines.Reconciled ') );

      if DateFilter then
        StrList.add('AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, Todate)));
        
      StrList.add('Group By tblbankdepositlines.DepositLineID ');

    //Supplier Prepayment
    StrList.add('UNION ALL SELECT  tblbankdepositlines.Reconciled,' +
    AccountIDfield('tblbankdepositlines') + ' as AccountId , ' +
      '"Deposit" as Category, tblbankdeposit.DepositID,tblbankdepositlines.DepositLineID,DepositDate, ABS(Sum(Amount)) as Amount, ' +
      'PaymentID,If(IsNull(CusID),0,CusID) as CusID, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.TrnsType ,"Split Deposit") as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName  ' +
       'FROM tblbankdeposit  ' +
       'INNER JOIN tblbankdepositlines Using (DepositID) ' +
       'WHERE  tblbankdepositlines.TrnsType="Supplier Prepayment" ' +
       'AND tblbankdeposit.Deleted <>"T" AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 '  +
       AccountIDFilter('tblbankdepositlines') +
     Reconciledfilter(' tblbankdepositlines.Reconciled  ' ));

      if DateFilter then
        StrList.add('AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, Todate)));

      StrList.add('Group By tblbankdepositlines.DepositLineID  ');

    //Deposit Entry
    StrList.add('UNION ALL ' +
      'SELECT  tblbankdeposit.Reconciled ,' +
      AccountIDfield('tblbankdeposit') + ' as AccountId , ' +
      '"Deposit" as Category, tblbankdeposit.DepositID,0 as DepositLineID,DepositDate, ABS(Deposit) as Amount, ' +
      'tblbankdeposit.DepositID as PaymentID,If(IsNull(CusID),0,CusID) as CusID,' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.TrnsType ,"Deposit Entry") as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName ' +
       'FROM tblbankdeposit ' +
       'INNER JOIN tblbankdepositlines Using (DepositID) ' +
       'Where    tblbankdepositlines.TrnsType="Deposit Entry" ' +
       'AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 ' +
       'AND tblbankdeposit.Deleted <>"T"  '+
       AccountIDFilter('tblbankdeposit') +
     Reconciledfilter(' tblbankdeposit.Reconciled  ' ));

      if DateFilter then
        StrList.add('AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, Todate)));

      StrList.add('Group By  tblbankdeposit.DepositID ');

    //Deposit Entry Split
    StrList.add('UNION ALL ' +
      'SELECT  tblbankdepositlines.Reconciled,' +
      AccountIDfield('tblbankdepositlines') + ' as AccountId , ' +
      '"Deposit" as Category, tblbankdeposit.DepositID,DepositLineID,DepositDate, ABS(Amount) as Amount, ' +
      'tblbankdeposit.DepositID as PaymentID,If(IsNull(CusID),0,CusID) as CusID,' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      '"Split Deposit" as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName ' +
       'FROM tblbankdeposit ' +
       'INNER JOIN tblbankdepositlines Using (DepositID) ' +
       'WHERE   tblbankdepositlines.TrnsType="Deposit Entry" ' +
       'AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 ' +
       'AND tblbankdeposit.Deleted <>"T"  '+
       AccountIDFilter('tblbankdepositlines') +
     Reconciledfilter(' tblbankdepositlines.Reconciled ') );

      if DateFilter then
        StrList.add('AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, Todate)));

      StrList.add('Group By tblbankdepositlines.DepositLineID  ');

    //Bank Deposit
    StrList.add('UNION ALL ' +
      'SELECT  tblbankdeposit.Reconciled ,' +
      AccountIDfield('tblbankdeposit') + ' as AccountId , ' +
      '"Deposit" as Category, tblbankdeposit.DepositID,0 as DepositLineID,DepositDate, ABS(Deposit) as Amount, ' +
      'tblbankdeposit.DepositID as PaymentID, CusID, tblbankdeposit.Notes as ReferenceNo, ' +
      '"Bank Deposit" as Notes, ' +
      '"" as CompanyName ' +
       'FROM tblbankdeposit ' +
       'INNER JOIN tblbankdepositlines Using (DepositID) ' +
       'Where   tblbankdepositlines.TrnsType<>"Deposit Entry" AND tblbankdepositlines.TrnsType<>"Cheque Deposit" ' +
       'AND tblbankdepositlines.TrnsType<>"'+CUSTOMER_PREPAYMENT+'" AND tblbankdepositlines.TrnsType<>"Supplier Prepayment" ' +
       'AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 AND FromDeposited="T" ' +
       'AND tblbankdeposit.Deleted <>"T" '+
       AccountIDFilter('tblbankdeposit') +
     Reconciledfilter(' tblbankdeposit.Reconciled ' )
       );

      if DateFilter then
        StrList.add('AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, Todate)));

      StrList.add('Group By  tblbankdeposit.DepositID ');

    //Cheques
    StrList.add('UNION ALL SELECT  tblbankdeposit.Reconciled ,' +
    AccountIDfield('tblbankdeposit') + ' as AccountId , ' +
      '"Deposit" as Category, tblbankdeposit.DepositID,0 as DepositLineID,DepositDate, ABS(Deposit) as Amount, ' +
      // 0 as DepositLineID Due To
      'PaymentID,If(IsNull(CusID),0,CusID) as CusID, ' +                                                                                         //  Grouping
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.TrnsType ,"Split Deposit") as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName  ' +
       'FROM tblbankdeposit  ' +
       'INNER JOIN tblbankdepositlines Using (DepositID) ' +
       'Where   tblbankdepositlines.TrnsType="Cheque" ' +
       'AND tblbankdeposit.Deleted <>"T" ' +
       'AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 '+
       AccountIDFilter('tblbankdeposit') +
     Reconciledfilter(' tblbankdeposit.Reconciled   ') );

      if DateFilter then
        StrList.add('AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, Todate)));

      StrList.add('Group By tblbankdeposit.DepositID  '); //Not tblbankdepositlines.DepositLineID  Because Sum Of Cheque Header Account

    //Cheque Deposits
    StrList.add('UNION ALL ' +
      'SELECT  tblbankdeposit.Reconciled ,' +
      AccountIDfield('tblbankdeposit') + ' as AccountId , ' +
      '"Deposit" as Category, tblbankdeposit.DepositID,tblbankdepositlines.DepositLineID,DepositDate, ABS(Sum(Amount)) as Amount, ' +
      'PaymentID,If(IsNull(CusID),0,CusID) as CusID, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.TrnsType ,"Deposit Entry") as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName ' +
       'FROM tblbankdeposit ' +
       'INNER JOIN tblbankdepositlines Using (DepositID) ' +
       'Where   tblbankdepositlines.TrnsType="Cheque Deposit" ' +
       'AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 ' +
       'AND tblbankdeposit.Deleted <>"T"  '+
       AccountIDFilter('tblbankdeposit') +
     Reconciledfilter('  tblbankdeposit.Reconciled ' ) );

      if DateFilter then
        StrList.add('AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, Todate)));
      StrList.add('Group By tblbankdepositlines.DepositLineID ');
  StrList.add('UNION ALL ' +
      'SELECT  tblbankdepositlines.Reconciled,' +
      AccountIDfield('tblbankdepositlines') + ' as AccountId , ' +
      '"Withdrawal" as Category, tblbankdeposit.DepositID,tblbankdepositlines.DepositLineID,DepositDate, ' +
      'ABS(Amount) as Amount, PaymentID,If(IsNull(CusID),0,CusID) as CusID, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.TrnsType ,"Split Deposit") as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName ' +
       'FROM tblbankdeposit ' +
       'INNER JOIN tblbankdepositlines Using (DepositID) ' +
       'WHERE   tblbankdepositlines.TrnsType<>"Deposit Entry" ' +
       'AND tblbankdepositlines.TrnsType<>"Cheque"  ' +
       'AND tblbankdepositlines.TrnsType<>"Cheque Deposit" ' +
       'AND tblbankdepositlines.TrnsType<>"'+CUSTOMER_PREPAYMENT+'" ' +
       'AND tblbankdepositlines.TrnsType<>"Supplier Prepayment" ' +
       'AND tblbankdeposit.Deleted <>"T"  ' +
       'AND FromDeposited<>"T" ' +
       'AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 ' + AccountIDFilter('tblbankdepositlines') +
     Reconciledfilter('  tblbankdepositlines.Reconciled   ' ));

      if DateFilter then
        StrList.add('AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, Todate)));

      StrList.add('Group By tblbankdepositlines.DepositLineID ');

    //Bank Deposit
    StrList.add('UNION ALL ' +
      'SELECT  tblbankdeposit.Reconciled ,' +
      AccountIDfield('tblbankdeposit') + ' as AccountId , ' +
      '"Withdrawal" as Category, tblbankdeposit.DepositID,0 as DepositLineID,DepositDate, ABS(Deposit) as Amount, ' +
      'tblbankdeposit.DepositID as PaymentID,If(IsNull(CusID),0,CusID) as CusID, tblbankdeposit.Notes as ReferenceNo, ' +
      '"Bank Deposit" as Notes, ' +
      '"" as CompanyName ' +
       'FROM tblbankdeposit ' +
       'INNER JOIN tblbankdepositlines Using (DepositID) ' +
       'WHERE   tblbankdepositlines.TrnsType<>"Deposit Entry" AND tblbankdepositlines.TrnsType<>"Cheque" ' +
       'AND tblbankdepositlines.TrnsType<>"'+CUSTOMER_PREPAYMENT+'" AND tblbankdepositlines.TrnsType<>"Supplier Prepayment" ' +
       'AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 AND FromDeposited="T" ' +
       'AND tblbankdeposit.Deleted <>"T" ' + AccountIDFilter('tblbankdeposit') +
     Reconciledfilter('  tblbankdeposit.Reconciled ' ));

      if DateFilter then
        StrList.add('AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, Todate)));

      StrList.add('Group By  tblbankdeposit.DepositID ');

    //Deposit Entry
    StrList.add('UNION ALL ' +
      'SELECT  tblbankdeposit.Reconciled ,' +
      AccountIDfield('tblbankdeposit') + ' as AccountId , ' +
      '"Withdrawal" as Category, tblbankdeposit.DepositID,0 as DepositLineID,DepositDate, ABS(Deposit) as Amount, ' +
      'tblbankdeposit.DepositID as PaymentID,If(IsNull(CusID),0,CusID) as CusID,' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.TrnsType ,"Deposit Entry") as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName ' +
       'FROM tblbankdeposit ' +
       'INNER JOIN tblbankdepositlines Using (DepositID) ' +
       'WHERE    tblbankdepositlines.TrnsType="Deposit Entry" ' +
       'AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 ' +
       'AND tblbankdeposit.Deleted <>"T"  ' + AccountIDFilter('tblbankdeposit') +
     Reconciledfilter('  tblbankdeposit.Reconciled  ' ));

      if DateFilter then
        StrList.add('AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, Todate)));

      StrList.add('Group By  tblbankdeposit.DepositID ');

    //Deposit Entry Split
    StrList.add('UNION ALL ' +
      'SELECT  tblbankdepositlines.Reconciled,' +
      AccountIDfield('tblbankdepositlines') + ' as AccountId , ' +
      '"Withdrawal" as Category, tblbankdeposit.DepositID,DepositLineID,DepositDate, ABS(Amount) as Amount, ' +
      'tblbankdeposit.DepositID as PaymentID,If(IsNull(CusID),0,CusID) as CusID,' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      '"Split Deposit" as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName ' +
       'FROM tblbankdeposit ' +
       'INNER JOIN tblbankdepositlines Using (DepositID) ' +
       'WHERE   tblbankdepositlines.TrnsType="Deposit Entry" ' +
       'AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 ' +
       'AND tblbankdeposit.Deleted <>"T"  ' + AccountIDFilter('tblbankdepositlines') +
     Reconciledfilter(' tblbankdepositlines.Reconciled  ' ));

     if DateFilter then
        StrList.add('AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, Todate)));
      StrList.add('Group By tblbankdepositlines.DepositLineID  ');

    //Supplier Prepayment
    StrList.add('UNION ALL SELECT  tblbankdepositlines.Reconciled,' +
    AccountIDfield('tblbankdepositlines') + ' as AccountId , ' +
      '"Withdrawal" as Category, tblbankdeposit.DepositID,tblbankdepositlines.DepositLineID,DepositDate, ABS(Sum(Amount)) as Amount, ' +
      'PaymentID,If(IsNull(CusID),0,CusID) as CusID, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.TrnsType ,"Split Deposit") as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName  ' +
       'FROM tblbankdeposit  ' +
       'INNER JOIN tblbankdepositlines Using (DepositID) ' +
       'WHERE   tblbankdepositlines.TrnsType="Supplier Prepayment" ' +
       'AND tblbankdeposit.Deleted <>"T" AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) > 0.00 ' + AccountIDFilter('tblbankdepositlines') +
     Reconciledfilter(' tblbankdepositlines.Reconciled  ' ));

     if DateFilter then
        StrList.add('AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, Todate)));
      StrList.add('Group By tblbankdepositlines.DepositLineID  ');

    //Customer Prepayment
    StrList.add('UNION ALL ' +
      'SELECT  tblbankdepositlines.Reconciled,' +
      AccountIDfield('tblbankdeposit') + ' as AccountId , ' +
      '"Withdrawal" as Category, tblbankdeposit.DepositID,tblbankdepositlines.DepositLineID,DepositDate,  ABS(Deposit) as Amount, ' +
      'tblbankdeposit.DepositID as PaymentID,If(IsNull(CusID),0,CusID) as CusID,' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.TrnsType ,"Deposit Entry") as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName ' +
       'FROM tblbankdeposit ' +
       'INNER JOIN tblbankdepositlines Using (DepositID) ' +
       'WHERE    tblbankdepositlines.TrnsType="'+CUSTOMER_PREPAYMENT+'" ' +
       'AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 ' +
       'AND tblbankdeposit.Deleted <>"T"   ' + AccountIDFilter('tblbankdeposit') +
      Reconciledfilter( ' tblbankdepositlines.Reconciled   ') );

      if DateFilter then
        StrList.add('AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, Todate)));
      StrList.add('Group By tblbankdepositlines.DepositLineID ');

    //Cheques
    StrList.add('UNION ALL SELECT tblbankdeposit.Reconciled , ' +
    AccountIDfield('tblbankdeposit') + ' as AccountId , ' +
      '"Withdrawal" as Category, tblbankdeposit.DepositID,0 as DepositLineID,DepositDate, ABS(Deposit) as Amount, ' +
      // 0 as DepositLineID Due To
      'PaymentID,If(IsNull(CusID),0,CusID) as CusID, ' +                                                                                         //  Grouping
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.TrnsType ,"Split Deposit") as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName  ' +
       'FROM tblbankdeposit  ' +
       'INNER JOIN tblbankdepositlines Using (DepositID) ' +
       'WHERE     tblbankdepositlines.TrnsType="Cheque" ' +
       'AND tblbankdeposit.Deleted <>"T" ' +
       'AND ifnull(Round(Deposit,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 ' + AccountIDFilter('tblbankdeposit') +
     Reconciledfilter('  tblbankdeposit.Reconciled   '));

      if DateFilter then
        StrList.add('AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, Todate)));
      StrList.add('Group By tblbankdeposit.DepositID  '); //Not tblbankdepositlines.DepositLineID  Because Sum Of Cheque Header Account

    //Cheque Deposits
    StrList.add('UNION ALL ' +
      'SELECT  tblbankdeposit.Reconciled ,' +
      AccountIDfield('tblbankdeposit') + ' as AccountId ,' +
      ' "Withdrawal" as Category, tblbankdeposit.DepositID,tblbankdepositlines.DepositLineID,DepositDate, ABS(Sum(Amount)) as Amount, ' +
      'PaymentID,If(IsNull(CusID),0,CusID) as CusID, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.ReferenceNo ,"") as ReferenceNo, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.TrnsType ,"Deposit Entry") as Notes, ' +
      'If( (MAx(CusID)-Min(CusID)=0) OR IsNull(CusID) ,tblbankdepositlines.CompanyName ,"") as CompanyName ' +
       'FROM tblbankdeposit ' +
       'INNER JOIN tblbankdepositlines Using (DepositID) ' +
       'WHERE    tblbankdepositlines.TrnsType="Cheque Deposit" ' +
       'AND ifnull(Round(Amount,'+inttostr(GeneralRoundPlaces)+'),0) < 0.00 ' +
       'AND tblbankdeposit.Deleted <>"T"  ' + AccountIDFilter('tblbankdeposit') +
     Reconciledfilter('  tblbankdeposit.Reconciled  ') );

      if DateFilter then
        StrList.add('AND DepositDate <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, Todate)));
      StrList.add('Group By tblbankdepositlines.DepositLineID ');
      StrList.add('Order by CAtegory, DepositDate');
    Result := StrList.text;
    finally
        FreeandNil(StrList);
    end;
end;

end.
