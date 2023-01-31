unit TransactionListSQL;

interface
uses
  classes, ReportBaseObj, Types, ErpDBComponents, ReportSQLBalanceSheet,
 BusObjFCOnReport,   UserLockObj;

type
  TTransListtype = (tltTransList=1, tltTransExpList=2);

  TTransactionListReport = class(TReportWithDateRangeBase)
    Private
      fiClientID: Integer;
      fsTempTableName: string;
      fTransListtype: TTransListtype;
      fFConReport: TForeignCurrencyonReport;
      FCFields:String;
      fiFilterIndex: Integer;
      fiselectedClassId: Integer;
      fbIncludedataPriorToClosingDate: Boolean;
      fsglobalref: String;
      function GetTempTableName: string;
      function GetClientName: String;
      procedure SetClientName(const Value: String);
      function GetListType: Integer;
      procedure SetListType(const Value: Integer);

    Protected

    Public
      constructor Create; override;
      destructor Destroy; override;
      function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;
      property TempTableName  : string    read  GetTempTableName;
      procedure CreateReportTable;
      procedure DoPopulateReportTable;

    Published
      Property ClientID: Integer read fiClientID write fiClientID;
      Property ClientName: String read GetClientName write SetClientName;
      Property TransListtype: TTransListtype read fTransListtype write fTransListtype;
      Property Listtype: Integer read GetListType write SetListType;
      Property FConReport: TForeignCurrencyonReport read fFConReport write fFConReport;
      Property FilterIndex: Integer read fiFilterIndex write fiFilterIndex;
      Property selectedClassId: Integer read fiselectedClassId write fiselectedClassId;
      Property IncludedataPriorToClosingDate: Boolean read fbIncludedataPriorToClosingDate write fbIncludedataPriorToClosingDate ;
      Property Globalref: String read fsglobalref write fsglobalref;

  end;

implementation

uses TempTableUtils, CommonDbLib, DbSharedObjectsObj, sysutils, commonlib,
  MySQLConst, tcConst, LogLib, SyncReportTableObj, BusObjClient;

{ TTransactionListReport }

constructor TTransactionListReport.Create;
begin
  inherited;
  fbIncludedataPriorToClosingDate := False;
  fiFilterIndex := 0;
  fiselectedClassId := 0;
  ClientId := 0;
  fsTempTableName := '';
  fTransListtype := tltTransList;
  fFConReport := nil;
  globalref := '';
end;

destructor TTransactionListReport.Destroy;
begin
  if TempTableName <> '' then TempTableUtils.DestroyUserTemporaryTable(GetSharedMyDacConnection,  TempTableName);
  inherited;
end;

function TTransactionListReport.GetTempTableName: string;
begin
  if fsTempTableName = '' then
    fsTempTableName := TempTableUtils.CreateUserTemporaryTable(GetSharedMyDacConnection, 'tmp_transactionjournal');
  Result := fsTempTableName;
end;

function TTransactionListReport.PopulateReportSQL(SQL: TStrings; var msg: string): Boolean;
begin
  DoPopulateReportTable;
  TempTableName;
  if TransListtype = tltTransList then begin
    SQL.Clear;

    SQL.add('SELECT ');
    SQL.add('ACCOUNTNAME    as ACCOUNTNAME ,');
    SQL.add('ACCOUNTID      as ACCOUNTID ,');
    SQL.add('AccountType    as AccountType ,');
    SQL.add('ACCOUNTNUMBER  as ACCOUNTNUMBER ,');
    if fiFilterIndex = 2  then begin
      SQL.add('`DATE`          as `DATE` ,');
      SQL.add('GLOBALREF       as GLOBALREF ,');
      SQL.add('`TYPE`          as `TYPE` ,');
      SQL.add('convert(transID,UNSIGNED)         as `transID` ,');
      SQL.add('convert(JobNumber,UNSIGNED)       as JobNumber ,');
      SQL.add('convert(CLASSID,UNSIGNED)         as CLASSID ,');
      SQL.add('convert(SALEID,UNSIGNED)          as SALEID ,');
      SQL.add('convert(PURCHASEORDERID,UNSIGNED) as PURCHASEORDERID ,');
      SQL.add('convert(PAYMENTID,UNSIGNED)       as PAYMENTID ,');
      SQL.add('convert(PREPAYMENTID,UNSIGNED)    as PREPAYMENTID ,');
      SQL.add('convert(FIXEDASSETID,UNSIGNED)    as FIXEDASSETID ,');
      SQL.add('convert(Seqno,UNSIGNED)           as Seqno ,');
      SQL.add('CLIENTNAME      as CLIENTNAME ,');
      SQL.add('CompanyName     as CompanyName ,');
      SQL.add('JobName         as JobName ,');
      SQL.add('CustomerJobName as CustomerJobName ,');
      SQL.add('PRODUCTNAME     as PRODUCTNAME ,');
      SQL.add('PRODUCTGROUP    as PRODUCTGROUP ,');
      SQL.add('PRODUCTDESC     as PRODUCTDESC ,');
      SQL.add('TAXCODE         as TAXCODE ,');
      SQL.add('ACCOUNT         as ACCOUNT ,');
      SQL.add('convert(TransTimeStamp, DATETIME)  as TransTimeStamp,');
    end else if fiFilterIndex = 1 then begin
      SQL.add('`DATE`          as `DATE` ,');
      SQL.add('GLOBALREF       as GLOBALREF ,');
      SQL.add('NULL            as `TYPE` ,');
      SQL.add('convert(0,UNSIGNED) as `transID` ,');
      SQL.add('convert(0,UNSIGNED) as JobNumber ,');
      SQL.add('convert(0,UNSIGNED) as CLASSID ,');
      SQL.add('convert(0,UNSIGNED) as SALEID ,');
      SQL.add('convert(0,UNSIGNED) as PURCHASEORDERID ,');
      SQL.add('convert(0,UNSIGNED) as PAYMENTID ,');
      SQL.add('convert(0,UNSIGNED) as PREPAYMENTID ,');
      SQL.add('convert(0,UNSIGNED) as FIXEDASSETID ,');
      SQL.add('convert(0,UNSIGNED) as Seqno ,');
      SQL.add('NULL            as CLIENTNAME ,');
      SQL.add('NULL            as CompanyName ,');
      SQL.add('NULL            as JobName ,');
      SQL.add('NULL            as CustomerJobName ,');
      SQL.add('NULL            as PRODUCTNAME ,');
      SQL.add('NULL            as PRODUCTGROUP ,');
      SQL.add('NULL            as PRODUCTDESC ,');
      SQL.add('NULL            as TAXCODE ,');
      SQL.add('NULL            as ACCOUNT ,');
      SQL.add('convert(NULL, DATETIME)            as TransTimeStamp,');
    end else begin
      SQL.add('`DATE`          as `DATE` ,');
      SQL.add('null            as GLOBALREF ,');
      SQL.add('NULL            as `TYPE` ,');
      SQL.add('convert(0,UNSIGNED) as `transID` ,');
      SQL.add('convert(0,UNSIGNED) as JobNumber ,');
      SQL.add('convert(0,UNSIGNED) as CLASSID ,');
      SQL.add('convert(0,UNSIGNED) as SALEID ,');
      SQL.add('convert(0,UNSIGNED) as PURCHASEORDERID ,');
      SQL.add('convert(0,UNSIGNED) as PAYMENTID ,');
      SQL.add('convert(0,UNSIGNED) as PREPAYMENTID ,');
      SQL.add('convert(0,UNSIGNED) as FIXEDASSETID ,');
      SQL.add('convert(0,UNSIGNED) as Seqno ,');
      SQL.add('NULL            as CLIENTNAME ,');
      SQL.add('NULL            as CompanyName ,');
      SQL.add('NULL            as JobName ,');
      SQL.add('NULL            as CustomerJobName ,');
      SQL.add('NULL            as PRODUCTNAME ,');
      SQL.add('NULL            as PRODUCTGROUP ,');
      SQL.add('NULL            as PRODUCTDESC ,');
      SQL.add('NULL            as TAXCODE ,');
      SQL.add('NULL            as ACCOUNT ,');
      SQL.add('convert(NULL, DATETIME)            as TransTimeStamp,');
    end;

    SQL.add('sum(DEBITSEX)                as DEBITSEX ,');
    SQL.add('sum(CREDITSEX)               as CREDITSEX ,');
    SQL.add('sum(DEBITSINC)               as DEBITSINC ,');
    SQL.add('sum(CREDITSINC)              as CREDITSINC ,');
    SQL.add('Sum(CREDITSEX- DEBITSEX )    as EXDiff,');
    SQL.add('Sum(CREDITSINC - DEBITSINC ) as IncDiff ,');
    SQL.add('sum(CASHDEBITSEX)            as CASHDEBITSEX ,');
    SQL.add('sum(CASHCREDITSEX)           as CASHCREDITSEX ,');
    SQL.add('sum(CASHDEBITSINC)           as CASHDEBITSINC ,');
    SQL.add('sum(CASHCREDITSINC)          as CASHCREDITSINC ,');
    if FConReport <> nil then
      if FConReport.Count > 0 then begin
        FCOnReport.first;
        while FConReport.Eof = False do begin
          SQL.add('sum(' + FCOnReport.Code + '_DebitsEx)   as ' + FCOnReport.Code + '_DebitsEx , ' );
          SQL.add('sum(' + FCOnReport.Code + '_CreditsEx)  as ' + FCOnReport.Code + '_CreditsEx , ' );
          SQL.add('sum(' + FCOnReport.Code + '_DebitsInc)  as ' + FCOnReport.Code + '_DebitsInc , ' );
          SQL.add('sum(' + FCOnReport.Code + '_CreditsInc) as ' + FCOnReport.Code + '_CreditsInc , ' );
          FCOnReport.Next;
        end;
      end;
    SQL.add('EMPLOYEEID    as EMPLOYEEID, ');
    SQL.Add('EmployeeName  as EmployeeName, ');
    SQL.add('Department    as Department, ');
    SQL.add('Memo          as Memo,');
    SQL.add('ReferenceNo   as ReferenceNo');
    SQL.add('from ' + TempTableName );

    if fiFilterIndex = 2 then SQL.add('GROUP BY transId ')
    else if fiFilterIndex = 1 then SQL.add('GROUP BY type, GLOBALREF')
    else SQL.add('GROUP BY type, accountid');

    SQL.add('ORDER BY Date DESC');

    Result := True;
  end
  else if Translisttype = tltTransExpList then begin
    SQL.add('select ');
    if fiFilterIndex = 2 then begin
      SQL.add('`DATE`    as `DATE` ,');
      SQL.add('`TYPE`    as `TYPE` ,');
      SQL.add('`transID` as `transID` ,');
      SQL.add('`SaleID`  as `SaleID` ,');
      SQL.add('GLOBALREF as GLOBALREF ,');
    end else if fiFilterIndex = 1 then begin
      SQL.add('`TYPE`    as `TYPE` ,');
      SQL.add('GLOBALREF as GLOBALREF ,');
      SQL.add('null      as `DATE` ,');
      SQL.add('null      as `transID` ,');
      SQL.add('null      as `SaleID` ,');
    end else begin
      SQL.add('`TYPE`    as `TYPE` ,');
      SQL.add('null      as GLOBALREF ,');
      SQL.add('null      as `DATE` ,');
      SQL.add('null      as `transID` ,');
      SQL.add('null      as `SaleID` ,');
    end;

    if FConReport <> nil then
      if FConReport.Count > 0 then begin
        FCOnReport.first;
        while FConReport.Eof = False do begin
          SQL.add('sum(' + FCOnReport.Code + '_DebitsEx)    as ' + FCOnReport.Code + '_DebitsEx , ' );
          SQL.add('sum(' + FCOnReport.Code + '_CreditsEx)   as ' + FCOnReport.Code + '_CreditsEx , ' );
          SQL.add('sum(' + FCOnReport.Code + '_DebitsInc)   as ' + FCOnReport.Code + '_DebitsInc , ' );
          SQL.add('sum(' + FCOnReport.Code + '_CreditsInc)  as ' + FCOnReport.Code + '_CreditsInc , ' );
          FCOnReport.Next;
        end;
      end;
    SQL.add('sum(DEBITSEX)                 as DEBITSEX ,');
    SQL.add('sum(CREDITSEX)                as CREDITSEX ,');
    SQL.add('sum(DEBITSINC)                as DEBITSINC ,');
    SQL.add('sum(CREDITSINC)               as CREDITSINC ,');
    SQL.add('Sum(CREDITSEX- DEBITSEX )     as EXDiff,');
    SQL.add('Sum(CREDITSINC - DEBITSINC )  as IncDiff ');
    SQL.add('from ' + TempTableName);

    if fiFilterIndex = 2 then SQL.add('GROUP BY transId ')
    else if fiFilterIndex = 1 then SQL.add('GROUP BY type, GLOBALREF')
    else SQL.add('GROUP BY type') ;

    SQL.add('ORDER BY Date DESC');

    Result := True;
  end;
end;

procedure TTransactionListReport.SetListType(const Value: Integer);
begin
  if value =1 then translisttype := tltTransList
  else translisttype := tltTransExpList;
end;

function TTransactionListReport.GetClientName: String;
begin
  Result := TClient.IDToggle(ClientId);
end;

procedure TTransactionListReport.SetClientName(const Value: String);
begin
  ClientId := TClient.IDToggle(Value);
end;

procedure TTransactionListReport.DoPopulateReportTable;
var
  ctr, i: Integer;
  transtypes: Array of String;
  cmd: TERPCommand;
  usingReportTables: Boolean;

  function summaryTransMultiplier :Integer;
  begin
    if ctr = 1 then begin
      Result := 0;
      Exit;
    end;
    With tempMyquery do try
       SQL.Add('Select Max(transID) as transID  from tbltransactions ');
       open;
       REsult := fieldbyname('transID').AsInteger;
    finally

    end;
  end;

  procedure populateTranstypes;
  var
    qry: TERPQuery;
  begin
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
      Qry.SQL.Text := 'SELECT DISTINCT type FROM tbltransactions '+
                      'WHERE Date BETWEEN ' + QuotedStr(formatdateTime(MysqlDateTimeFormat, DateFrom)) + ' AND ' + QuotedStr(formatdateTime(MysqlDateTimeFormat, DateTo));
      Qry.open;
      DoStepProgressBar;
      SetLength(transtypes, 0);
      if Qry.recordcount = 0 then Exit;
      Qry.first;
      while Qry.eof = false do begin
        SetLength(transtypes, length(transtypes ) + 1);
        transtypes[High(transtypes)] := Qry.fieldbyname('type').AsString;
        Qry.Next;
      DoStepProgressBar;
      end;
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;
  end;
begin
  Processingcursor(True);
  try
    DoShowProgressbar(20, WAITMSG);
    try
      CreateReportTable;
      DoStepProgressBar;
      populateTranstypes;
    finally
      DoHideProgressBar;
    end;

    if IsLimit0selection  then else begin
      if length(transtypes)> 0 then begin
        cmd := DbSharedObj.Getcommand(commondblib.GetSharedMyDacConnection);
        try
        with cmd do begin
          SQL.Clear;
          for i := low(transtypes) to high(transtypes) do begin
                for ctr:= 1 to 2 do begin
                  if (ctr =1) or (IncludedataPriorToClosingDate) then begin
                    SQL.Add('/*1 - ' + inttostr(i)+' of ' + inttostr(high(transtypes)) + ' */ insert into ' + TempTableName +
                                       ' (Category , Date,'+
                                       ' GlobalRef,'+
                                       ' Type,'+
                                       ' ClientID, '+
                                       ' CLIENTNAME,'+
                                       ' CompanyName,'+
                                       ' JobName,'+
                                       ' CustomerJobID,'+
                                       ' ClassID,'+
                                       ' SaleID,'+
                                       ' SaleLineID,'+
                                       ' PurchaseOrderID,'+
                                       ' PurchaseLineID,'+
                                       ' PaymentID,'+
                                       ' PrepaymentID,'+
                                       ' FixedAssetID,'+
                                       ' AccountName,'+
                                       ' AccountID,'+
                                       ' AccountType ,'+
                                       ' DebitsEx,'+
                                       ' CreditsEx,'+
                                       ' DebitsInc,'+
                                       ' CreditsInc,'+
                                       ' CashDebitsEx,'+
                                       ' CashCreditsEx,'+
                                       ' CashDebitsInc,'+
                                       ' CashCreditsInc,'+
                                       ' ProductName,'+
                                       ' ProductGroup,'+
                                       ' ProductDesc,'+
                                       ' TransTimeStamp,'+
                                       ' TaxCode,'+
                                       ' Account, AccountNumber, EmployeeID, Seqno, transId , Beforeclosing'+
                                       iif(FCFields <> '' ,',' + FCFields , '')+
                                       ' ) ' + NL +
                                       ' SELECT ' + inttostr(summaryTransMultiplier) +'+  1, '+
                                       ' Trans.Date ,'+
                                       ' Trans.GlobalRef ,'+
                                       ' Trans.Type ,'+
                                       ' Trans.ClientID, '+
                                       ' ClientName ,'+
                                       SplitField('Trans', 'ClientName', 1)+' as CompanyName, '+
                                       SplitField('Trans', 'ClientName', 2)+' as Jobname ,'+
                                       ' CustomerJobID ,'+
                                       ' Trans.ClassID ,'+
                                       ' Trans.SaleID ,'+
                                       ' Trans.SaleLineID ,'+
                                       ' Trans.PurchaseOrderID ,'+
                                       ' Trans.PurchaseLineID ,'+
                                       ' Trans.PaymentID ,'+
                                       ' Trans.PrepaymentID ,'+
                                       ' Trans.FixedAssetID ,'+
                                       ' null, '+//'SUBSTRING(If((char_length(AccountGroup)>0),Concat(Replace(AccountGroup,"^"," - ") ," - ",Trans.AccountName),Trans.AccountName),1,255) ,'+
                                       ' Trans.AccountID ,'+
                                       ' Trans.AccountType as AccountType, /*tblacctypedesc.AccDesc ,*/'+
                                       ' DebitsEx ,'+
                                       ' CreditsEx ,'+
                                       ' DebitsInc ,'+
                                       ' CreditsInc ,'+
                                       ' Cash_DebitsEx ,'+
                                       ' Cash_CreditsEx ,'+
                                       ' Cash_DebitsInc ,'+
                                       ' Cash_CreditsInc ,'+
                                       ' ProductName ,'+
                                       ' ProductGroup ,'+
                                       ' ProductDesc ,'+
                                       ' Trans.msTimeStamp as TransTimeStamp,'+
                                       ' Trans.TaxCode ,'+
                                       ' Trans.AccountName ,'+
                                       ' null as AccountNumber , /*tblchartofaccounts.AccountNumber ,*/'+
                                       ' Trans.EmployeeID, trans.Seqno , trans.transId , '+
                                        iif(ctr = 1 ,Quotedstr('T'), Quotedstr('F'))+
                                        iif(FCFields <> '' ,',' + FCFields , '')+
                                        iif(ctr = 1 ,' FROM tbltransactions as Trans', iif(ctr = 2,' FROM tbltransactionsummarydetails as Trans' , ''))+
                                       (*' INNER JOIN tblchartofaccounts Using(AccountID)'+
                                       ' LEFT JOIN tblacctypedesc On tblacctypedesc.AccType=Trans.AccountType '+*)
                                       iif(globalref <> '',' Where Trans.Globalref = ' + quotedstr(globalref) ,
                                       ' Where trans.Date Between ' + quotedstr(formatdateTime(MysqlDateTimeFormat , DateFrom)) +' AND  ' + quotedstr(formatdateTime(MysqlDateTimeFormat , DateTo)) +
                                       ' and trans.type =' +quotedstr(transtypes[i])+
                                       iif(selectedClassId <> 0 ,'  AND Trans.ClassID = ' + inttostr(selectedClassId), ''))+
                                       iif(ClientID<>0, ' AND (Trans.clientId = '+inttostr(clientID)+' or Trans.CustomerJobID = '+inttostr(clientID)+')', '') +
                                       iif((ctr = 1) and IncludedataPriorToClosingDate ,' and trans.type <> ''Closing Date Summary'' and Seqno <100' , '')+
                                       ' Order by Trans.SaleID ,Trans.SaleLineID ,Trans.PurchaseOrderID ,Trans.PurchaseLineID ,Trans.PaymentID ,Trans.PrepaymentID ,Trans.FixedAssetID;');
                  end;
                end;
            end;
          //if (*devmode OR*) not(self.classnameis('TTransactionListGUI')) then
          if  (*devmode OR*) not(sametext(ListClassname,'TTransactionListGUI')) then
          else begin
              SQL.add('/*2-1*/ALTER TABLE  ' + TempTableName + ' ADD INDEX `AccountID` (`AccountID`);');
              SQL.add('/*2-2*/ALTER TABLE  ' + TempTableName + ' ADD INDEX `SaleLineId` (`SaleLineId`);');
              SQL.add('/*2-3*/ALTER TABLE  ' + TempTableName + ' ADD INDEX `PurchaseOrderID` (`PurchaseOrderID`);');
              SQL.add('/*2-4*/ALTER TABLE  ' + TempTableName + ' ADD INDEX `PurchaseLineID` (`PurchaseLineID`);');
              SQL.add('/*2-5*/ALTER TABLE  ' + TempTableName + ' ADD INDEX `AccountType` (`AccountType`);');

              SQL.add('/*4*/update ' + TempTableName + ' T INNER JOIN tblchartofaccounts COA Using(AccountID) Set T.AccountNumber = COA.AccountNumber;');
              SQL.add('/*5*/update ' + TempTableName + ' T INNER JOIN tblchartofaccounts COA Using(AccountID) Set T.Accountname = SUBSTRING(If((char_length(COA.AccountGroup)>0),Concat(Replace(COA.AccountGroup,"^"," - ") ," - ",COA.AccountName),COA.AccountName),1,255);');

              SQL.add('/*6*/update ' + TempTableName + ' T INNER JOIN tblacctypedesc ATD  on ATD.AccType=T.AccountType Set T.AccountType = ATD.AccDesc  ;');
              SQL.add('/*7*/update ' + TempTableName + ' T inner join tblEmployees      emp on emp.Employeeid = T.employeeid Set T.Employeename = emp.EmployeeName;' );
              SQL.add('/*8*/update ' + TempTableName + ' T inner join tblClass          CLS on cls.ClassId    = T.ClassId    Set T.Department = CLS.ClassName;' );
              SQL.add('/*9*/update ' + TempTableName + ' T ');
              SQL.add('  left join tblgeneraljournaldetails GLL on GLL.GJDID = T.SaleLineId and T.type = "Journal Entry"');
              SQL.add('  left join tblPurchaseOrders as Bill on Bill.PurchaseOrderID = T.PurchaseOrderID and T.Type = "Bill"');
              SQL.add('  left join tblPurchaseLines as ChequeLine on ChequeLine.PurchaseLineID = T.PurchaseLineID and T.Type = "Cheque"');
      //        SQL.add('  Set T.Memo = ifnull(J.Memo, "") ;' );
              SQL.add('  Set T.Memo = if(not IsNull(GLL.GJID),GLL.Memo,if(not IsNull(ChequeLine.PurchaseLineID),ChequeLine.Product_Description,NULL));');
              SQL.add('/*10*/update ' + TempTableName + ' T ');
              SQL.add('inner join tblPurchaseOrders as Bill on Bill.PurchaseOrderID = T.PurchaseOrderID and T.Type = "Bill"');
              SQL.add('  Set T.ReferenceNo =  Bill.RefNo;');
              if FConReport <> nil then
                if FConReport.Count > 0 then begin
                  FCOnReport.first;
                  while FConReport.Eof = False do begin
                      SQL.add('/*11-'+inttostr(FConReport.Recno)+' of ' + inttostr(FConReport.Count) +' */update ' + TempTableName + ' set ' );
                      SQL.add(FCOnReport.Code + '_DebitsEx =DebitsEx    * ' + FCOnReport.Code + '_FCRate, ' );
                      SQL.add(FCOnReport.Code + '_CreditsEx =CreditsEx  * ' + FCOnReport.Code + '_FCRate, ' );
                      SQL.add(FCOnReport.Code + '_DebitsInc =DebitsInc  * ' + FCOnReport.Code + '_FCRate, ' );
                      SQL.add(FCOnReport.Code + '_CreditsInc =CreditsInc* ' + FCOnReport.Code + '_FCRate; ' );
                      FCOnReport.Next;
                  end;
                end;
              // just to group the transaction records
              SQL.add('/*12*/update ' + TempTableName + ' T Set type = trim(replace(type , "Un-Invoiced" , "")) where type <> "Un-Invoiced";' );
              SQL.add('/*13*/update ' + TempTableName + ' T inner join tblclients C on C.clientId = T.clientID Set T.JobNumber = C.JobNumber;' );
          end;
          SQL.add('/*14*/update ' + TempTableName + ' T inner join tblclients C on C.clientId = T.CustomerJobID Set T.CustomerJobname = C.Company;' );
          SQL.text := SyncReportObj.ChangeQuery(SQL.Text, usingReportTables);
          clog(SQL.Text);
          Execute;
        end;
        finally
          DbSharedObj.ReleaseObj(cmd);
        end;
      end;
    end;
  finally
    DoHideProgressbar;
  end;
end;

function TTransactionListReport.GetListType: Integer;
begin
  if translisttype = tltTransList then Result := 1
  else Result := 2
end;

procedure TTransactionListReport.CreateReportTable;
var
  cmd: TERPCommand;
begin
  FCFields := '';
  cmd := DbSharedObj.Getcommand(commondblib.GetSharedMyDacConnection);
  try
    With cmd do begin
      SQl.Clear;
      TempTableName;
      SQL.Add(CreateUserTemporaryTableSQL(fsTempTableName , 'tmp_transactionjournal'));
      if FConReport <> nil then
        if FConReport.Count > 0 then begin
          FCOnReport.first;
          while FConReport.Eof = False do begin
              SQL.add('Alter table ' + TempTableName + ' Add column  ' + FCOnReport.Code + '_FCRate Double,');
              SQL.add(' Add column  ' + FCOnReport.Code + '_DebitsEx Double,' );
              SQL.add(' Add column  ' + FCOnReport.Code + '_CreditsEx  Double,' );
              SQL.add(' Add column  ' +  FCOnReport.Code + '_DebitsInc  Double, ' );
              SQL.add( ' Add column  ' + FCOnReport.Code + '_CreditsInc Double;');
              if FCFields <> '' then FCFields := FCFields + ',' ;
              FCFields := FCFields + FCOnReport.Code + '_FCRate';
              FCOnReport.Next;
            end;
        end;
      logtext(SQL.Text);
      Execute;
    end;
  finally
    DbSharedObj.ReleaseObj(cmd);
  end;
end;

initialization
  RegisterClass(TTransactionListReport);
end.
