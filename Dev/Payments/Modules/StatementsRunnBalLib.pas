unit StatementsRunnBalLib;

interface

Procedure CreateRunningBalanceStatement(Var SQLFinal:STring);
Procedure PopulateTransDetails;


implementation

uses CommonLib,tcDataUtils, sysutils, classes, ERPDbComponents, StatementsLib,
  DbSharedObjectsObj, CommonDbLib, TemplateReportsLib,
  ProductQtyLib, LogLib;
Procedure PopulateTransDetails;
var
  x:Integer;
  s:String;
  SQLList : TStringList;
  scr :TERPScript;
begin
   SQLList := TStringList.create;
   try
     SQLList.add(' drop table if exists ' +SParams.fsRTDetailTablename+'_1' +';');
     SQLList.add(' create table  ' +SParams.fsRTDetailTablename+'_1' + '( ' +
	                          ' ID                      INT(11)       NOT NULL AUTO_INCREMENT, ' +
                            ' TypeNo                  INT(11)       NULL DEFAULT NULL, ' +
	                          ' Type                    VARCHAR(25)   NULL DEFAULT "" , ' +
	                          ' TransDate               DATETime      NULL DEFAULT NULL, ' +
	                          ' CustomerName            VARCHAR(255)  NULL DEFAULT NULL, ' +
	                          ' JobName                 VARCHAR(255)  NULL DEFAULT NULL, ' +
	                          ' TransID                 VARCHAR(30)   NULL DEFAULT NULL, ' +
	                          ' Status                  VARCHAR(30)   NOT NULL DEFAULT "" , ' +
	                          ' Duedate                 DATETime      NULL DEFAULT NULL, ' +
	                          ' DaysOutstanding         Double        NULL DEFAULT NULL, ' +
	                          ' TotalAmountinc          DOUBLE        NULL DEFAULT  0 , ' +
	                          ' TotalTax                DOUBLE        NULL DEFAULT  0 , ' +
	                          ' TotalAmount             DOUBLE        NULL DEFAULT  0 , ' +
	                          ' OutstandingAmount       DOUBLE        NULL DEFAULT  0 , ' +
	                          ' WithinTerms             DOUBLE        NULL DEFAULT  0 , ' +
	                          ' 1_7Days                 DOUBLE        NULL DEFAULT  0 , ' +
	                          ' 7_14Days                DOUBLE        NULL DEFAULT  0 , ' +
	                          ' 14_21Days               DOUBLE        NULL DEFAULT  0 , ' +
	                          ' Over21Days              DOUBLE        NULL DEFAULT  0 , ' +
	                          ' 1_30Days                DOUBLE        NULL DEFAULT  0 , ' +
	                          ' 30_60Days               DOUBLE        NULL DEFAULT  0 , ' +
	                          ' 60_90Days               DOUBLE        NULL DEFAULT  0 , ' +
	                          ' Over90Days              DOUBLE        NULL DEFAULT  0 , ' +
	                          ' SaleID                  INT(11)       NULL DEFAULT  0 , ' +
	                          ' PONumber                VARCHAR(30)   NULL DEFAULT NULL, ' +
	                          ' ClientID                INT(11)       NULL DEFAULT  0 , ' +
	                          ' ClassID                 INT(11)       NULL DEFAULT NULL, ' +
	                          ' ClassName               VARCHAR(255)  NULL DEFAULT NULL, ' +
	                          ' ForeignExchangeRate     DOUBLE        NULL DEFAULT  0 , ' +
	                          ' ForeignExchangeCode     VARCHAR(25)   NULL DEFAULT NULL, ' +
	                          ' ForeignTotalAmount      DOUBLE        NULL DEFAULT  0 , ' +
	                          ' ForeignBalanceAmount    DOUBLE        NULL DEFAULT  0 , ' +
	                          ' Comments                VARCHAR(255)  NULL, ' +
	                          ' PRIMARY KEY (ID) ) ENGINE=Myisam ; ' );

{Sales Within  date range}
        SQLList.add(' INSERT IGNORE INTO ' +SParams.fsRTDetailTablename+'_1' +
        '( TypeNo,Type,SaleID ,TransID, TransDate,TotalAmountinc,TotalAmount,OutstandingAmount,ForeignTotalAmount,ForeignBalanceAmount) '+
        ' SELECT 1 ,"Opening Balance",null, null,  ' +Quotedstr(sFrom)+','+
              FloatToStr(TotalAmt(sFrom, sTo, false, false))+','+
              FloatToStr(TotalAmt(sFrom, sTo, false, false))+','+
              FloatToStr(TotalAmt(sFrom, sFrom, true, true))+','+
              FloatToStr(TotalForeignAmt(sFrom, sTo, False, False))+',' +
              FloatToStr(TotalForeignAmt(sFrom, sFrom, true, true))+';');

        SQLList.add(' INSERT IGNORE INTO ' +SParams.fsRTDetailTablename+'_1' + '( TypeNo,Type,TransDate,CustomerName,JobName,TransID,Status,Duedate,DaysOutstanding,TotalAmountinc,TotalTax,TotalAmount,OutstandingAmount,' +
                    'WithinTerms,1_7Days,7_14Days,14_21Days,Over21Days,1_30Days,30_60Days,60_90Days,Over90Days,' +
                    'SaleID,PONumber,ClientID,ClassID,ClassName,ForeignExchangeRate,ForeignExchangeCode,ForeignTotalAmount,ForeignBalanceAmount,Comments) '+
        ' SELECT 2 , ' +ProductQtyLib.SaleType('S')+' as Type, ' +
                    'SaleDate as TransDate, '+
                    'CustomerName , ' +
                    'CL.JobName,  '+
                    'InvoiceDocNumber as "TransID", ' +
                    'if(S.TotalAmountInc=0 , "Back Order" , If('+ SalesBalance +' = 0, "Fully Paid         ", ' + 'if('+ SalesBalance +' = TotalAmountInc, "No Payment         ", If('+ SalesBalance +' < TotalAmountInc, "Partially Paid", 0)))) as Status, ' +
                    'DueDate as Duedate, ' +
                    '  (TO_DAYS(DueDate)-0.00) - ' + DaysTostatementDate+' AS "DaysOutstanding", ' +
                    'TotalAmountInc AS "TotalAmountinc",   ' +
                    ' TotalTax , TotalAmount, ' +
                    ''+ SalesBalance +' AS "OutstandingAmount", ' +
                    'If( '+ DueDays +' <=0,  '+ SalesBalance +', 0.00) AS "WithinTerms", ' +
                    'If( '+ DueDays +' >0   And  ' + DueDays +' <=7  ,'+ SalesBalance +',0.00) AS "1_7Days"  , ' +
                    'if( '+ DueDays +' >7   And  ' + DueDays +' <=14 ,'+ SalesBalance +',0.00) AS "7_14Days" , ' +
                    'If( '+ DueDays +' >14  And  ' + DueDays +' <=21 ,'+ SalesBalance +',0.00) AS "14_21Days", ' +
                    'If( '+ DueDays +' >21, '+ SalesBalance +'           ,0.00) AS "Over21Days",' +
                    'If( '+ DueDays +' >0   And  ' + DueDays +' <=30 ,'+ SalesBalance +',0.00) AS "1_30Days" , ' +
                    'if( '+ DueDays +' >30  And  ' + DueDays +' <=60 ,'+ SalesBalance +',0.00) AS "30_60Days", ' +
                    'If( '+ DueDays +' >60  And  ' + DueDays +' <=90 ,'+ SalesBalance +',0.00) AS "60_90Days", ' +
                    'If( '+ DueDays +' >90, '+ SalesBalance +' ,0.00) AS "Over90Days",' +
                    ' SaleID, S.PONumber,   CL.ClientID, ClassID , S.Class as ClassName, ' +
                    ' S.ForeignExchangeRate,S.ForeignExchangeCode , S.ForeignTotalAmount , ' +
                    ' S.ForeignBalanceAmount, s.Comments ' +
        ' FROM  tblsales S ' +
        ' INNER JOIN tblClients as CL ON  S.CustomerName = CL.Company ' +
        ' WHERE  ' + SalesType +
        ' and S.converted = "F" and totalamount<> 0 ' +
        ' AND ' +DateTofilter +' between "' + sFrom + '" and "' + sTo + '" ' +
        ' AND ('+Clients('CL')+') ' + iif(sParams.showPaid = False ,'  AND '+ SalesBalance +'<>0.00 ' ,'')+
          getClassfilter('ClassId')+
        ' GROUP BY SaleID; ');

{BO-Sales Within  date range}
     if ((sParams.includeinvoiceBO) or (sParams.includeSOBO))  then
        SQLList.add(' INSERT IGNORE INTO ' +SParams.fsRTDetailTablename+'_1' + '( TypeNo,Type,TransDate,CustomerName,JobName,TransID,Status,Duedate,DaysOutstanding,TotalAmountinc,TotalTax,TotalAmount,OutstandingAmount,' +
                    'WithinTerms,1_7Days,7_14Days,14_21Days,Over21Days,1_30Days,30_60Days,60_90Days,Over90Days,' +
                    'SaleID,PONumber,ClientID,ClassID,ClassName,ForeignExchangeRate,ForeignExchangeCode,ForeignTotalAmount,ForeignBalanceAmount,Comments) '+
            ' SELECT 3,concat(' + ProductQtyLib.SaleType('S')+',"-BO") as Type, ' +
                      'SaleDate as TransDate, CustomerName , ' +
                      'CL.JobName, InvoiceDocNumber as "TransID", ' +
                      '"No Payment         "as Status, ' +
                      'DueDate as Duedate, ' +
                      '  (TO_DAYS(DueDate)-0.00) - ' + DaysTostatementDate+' AS "DaysOutstanding", ' +
                      'sum(SL.QtySold*if(ifnull(SL.LinePriceInc,0)=0, sl.lineprice, sl.linepriceinc)) AS "TotalAmountinc",      ' +
                      ' 0 as TotalTax ,' +
                      'sum(SL.QtySold*SL.LinePrice) AS "TotalAmount",      ' +
                      'sum(SL.QtySold*if(ifnull(SL.LinePriceInc,0)=0, sl.lineprice, sl.linepriceinc))  AS "OutstandingAmount", ' +
                      'If( '+ DueDays +' <=0,  sum(SL.QtySold*if(ifnull(SL.LinePriceInc,0)=0, sl.lineprice, sl.linepriceinc)), 0.00) AS "WithinTerms", ' +
                      'If( '+ DueDays +' >0   And  ' + DueDays +' <=7  ,sum(SL.QtySold*if(ifnull(SL.LinePriceInc,0)=0, sl.lineprice, sl.linepriceinc)),0.00) AS "1_7Days"  , ' +
                      'if( '+ DueDays +' >7   And  ' + DueDays +' <=14 ,sum(SL.QtySold*if(ifnull(SL.LinePriceInc,0)=0, sl.lineprice, sl.linepriceinc)),0.00) AS "7_14Days" , ' +
                      'If( '+ DueDays +' >14  And  ' + DueDays +' <=21 ,sum(SL.QtySold*if(ifnull(SL.LinePriceInc,0)=0, sl.lineprice, sl.linepriceinc)),0.00) AS "14_21Days", ' +
                      'If( '+ DueDays +' >21, sum(SL.QtySold*if(ifnull(SL.LinePriceInc,0)=0, sl.lineprice, sl.linepriceinc))           ,0.00) AS "Over21Days",' +
                      'If( '+ DueDays +' >0   And  ' + DueDays +' <=30 ,sum(SL.QtySold*if(ifnull(SL.LinePriceInc,0)=0, sl.lineprice, sl.linepriceinc)),0.00) AS "1_30Days" , ' +
                      'if( '+ DueDays +' >30  And  ' + DueDays +' <=60 ,sum(SL.QtySold*if(ifnull(SL.LinePriceInc,0)=0, sl.lineprice, sl.linepriceinc)),0.00) AS "30_60Days", ' +
                      'If( '+ DueDays +' >60  And  ' + DueDays +' <=90 ,sum(SL.QtySold*if(ifnull(SL.LinePriceInc,0)=0, sl.lineprice, sl.linepriceinc)),0.00) AS "60_90Days", ' +
                      'If( '+ DueDays +' >90, sum(SL.QtySold*if(ifnull(SL.LinePriceInc,0)=0, sl.lineprice, sl.linepriceinc)) ,0.00) AS "Over90Days",'+
                      'S.SaleID, S.PONumber,   CL.ClientID, ClassID ,S.Class  as ClassName, ' +
                      ' S.ForeignExchangeRate,S.ForeignExchangeCode , S.ForeignTotalAmount , ' +
                      ' S.ForeignBalanceAmount, s.Comments ' +
            ' FROM tblsales AS S'+
            ' Inner Join tblsaleslines AS SL ON S.SaleID = SL.SaleID'+
            ' inner join tblClients CL on CL.clientId = S.clientId'+
            ' Where (ifnull(S.converted,"F") = "F") and ifnull(S.BoID,"") = "" and ifnull(SL.UnitofMeasureShipped,0) = 0' + BOType + ' AND ('+Clients('CL')+') '+
            ' AND ' +DateTofilter +' between "' + sFrom + '" and "' + sTo + '" ' +
            ' AND ('+Clients('CL')+') ' + getClassfilter('S.ClassId')+
            ' group by S.saleId ;' );
{Payment Within  date range of the sales within Date Range}
        SQLList.add(' INSERT IGNORE INTO ' +SParams.fsRTDetailTablename+'_1' + '( TypeNo,Type,TransDate,CustomerName,JobName,TransID,Status,TotalAmountinc,TotalAmount,' +
                    'SaleID,ClientID,ClassID,ClassName,ForeignExchangeRate,ForeignExchangeCode,ForeignTotalAmount,ForeignBalanceAmount,Comments) '+
           ' Select 4,"Payment" as Type, '+
           ' D.PaymentDate as transdate , '+
           ' Cl.company CustomerName, CL.JobName, D.PaymentId as TransId, "Paid" as Status, '+
           ' 0- DL.Payment as TotalAmountinc, '+
           ' 0- DL.Payment as TotalAmount,  '+
           ' DL.saleId, CL.ClientID, D.classID,C.classname , '+
           ' D.ForeignExchangeRate , D.ForeignExchangeCode , DL.ForeignPayment , DL.ForeignAmountOutstanding , D.Notes '+
           ' from '+
           ' tblDeposits D '+
           ' inner join tbldepositLine DL on DL.paymentId= D.paymentId and D.deleted ="F" and DL.Trntype <> "Prepayment" '+
           ' inner join  ' +SParams.fsRTDetailTablename+'_1' + ' S on S.SaleID = DL.saleid and S.typeno in (2,3)'+
           ' INNER JOIN tblClients as CL ON D.CusID =CL.ClientID '+
           ' inner join tblclass C on D.classId = C.classId '+

           ' Where D.PaymentDate between "' + sFrom + '" and "' + sTo + '"' +' ;' );

{Pre-Payment as on to-date  of the customers of sales within Date Range}
        SQLList.add(' INSERT IGNORE INTO ' +SParams.fsRTDetailTablename+'_1' + '( TypeNo,Type,TransDate,CustomerName,JobName,TransID,Status,TotalAmountinc,TotalAmount,'+
        'SaleID,ClientID,ClassID,ClassName,ForeignExchangeRate,ForeignExchangeCode,ForeignTotalAmount,Comments) '+
       ' Select distinct 5,"Pre-Payment" as Type,  PP.PrePaymentDate as transdate ,  CL.company as  CustomerName, '+
       ' CL.JobName, PP.PrePaymentID as TransId, '+
       ' "Paid" as Status, '+
       ' 0- PP.Balance as TotalAmountinc, '+
       ' 0- PP.Balance as TotalAmount, '+
       ' null saleId, '+
       ' CL.ClientID, PP.ClassID,C.classname , '+
       ' PP.ForeignExchangeRate , PP.ForeignExchangeCode, 0-PP.ForeignBalance,  PP.notes '+
       ' from  tblprepayments PP '+
       ' inner join   ' +SParams.fsRTDetailTablename+'_1' + '  S on S.ClientId = PP.ClientID and S.typeno in (2,3)'+
       ' INNER JOIN tblClients as CL ON S.clientID =CL.ClientID '+
       ' inner join tblclass C on PP.ClassID = C.classId '+
       ' Where PP.Customer="T"  and ifnull(PP.Balance,0)<> 0 and  PP.PrePaymentDate between "' + sFrom + '" and "' + sTo + '"' +' ;' );

        SQLList.add(' INSERT IGNORE INTO ' +SParams.fsRTDetailTablename+'_1' +
        '( TypeNo,Type,SaleID ,TransID, TransDate,TotalAmountinc,TotalAmount,OutstandingAmount,ForeignTotalAmount,ForeignBalanceAmount) '+
        ' SELECT 6 ,"Closing Balance",null, null,  ' +Quotedstr(sFrom)+','+
              FloatToStr(TotalAmt(sFrom, sTo, false, false))+','+
              FloatToStr(TotalAmt(sFrom, sTo, false, false))+','+
              FloatToStr(TotalAmt(sTo, sTo, true, true))+','+
              FloatToStr(TotalForeignAmt(sFrom, sTo, False, False))+',' +
              FloatToStr(TotalForeignAmt(sTo, sTo, true, true))+';');


     SQLList.add(' drop table if exists ' +SParams.fsRTDetailTablename +';');
     SQLList.add(' create table  ' +SParams.fsRTDetailTablename + '( ' +
	                          ' ID                      INT(11)       NOT NULL AUTO_INCREMENT, ' +
                            ' TypeNo                  INT(11)       NULL DEFAULT NULL, ' +
	                          ' Type                    VARCHAR(25)   NULL DEFAULT "" , ' +
	                          ' TransDate               DATETime      NULL DEFAULT NULL, ' +
	                          ' CustomerName            VARCHAR(255)  NULL DEFAULT NULL, ' +
	                          ' JobName                 VARCHAR(255)  NULL DEFAULT NULL, ' +
	                          ' TransID                 VARCHAR(30)   NULL DEFAULT NULL, ' +
	                          ' Status                  VARCHAR(30)   NOT NULL DEFAULT "" , ' +
	                          ' Duedate                 DATETime      NULL DEFAULT NULL, ' +
	                          ' DaysOutstanding         Double        NULL DEFAULT NULL, ' +
	                          ' TotalAmountinc          DOUBLE        NULL DEFAULT  0 , ' +
	                          ' TotalTax                DOUBLE        NULL DEFAULT  0 , ' +
	                          ' TotalAmount             DOUBLE        NULL DEFAULT  0 , ' +
	                          ' OutstandingAmount       DOUBLE        NULL DEFAULT  0 , ' +
	                          ' WithinTerms             DOUBLE        NULL DEFAULT  0 , ' +
	                          ' 1_7Days                 DOUBLE        NULL DEFAULT  0 , ' +
	                          ' 7_14Days                DOUBLE        NULL DEFAULT  0 , ' +
	                          ' 14_21Days               DOUBLE        NULL DEFAULT  0 , ' +
	                          ' Over21Days              DOUBLE        NULL DEFAULT  0 , ' +
	                          ' 1_30Days                DOUBLE        NULL DEFAULT  0 , ' +
	                          ' 30_60Days               DOUBLE        NULL DEFAULT  0 , ' +
	                          ' 60_90Days               DOUBLE        NULL DEFAULT  0 , ' +
	                          ' Over90Days              DOUBLE        NULL DEFAULT  0 , ' +
	                          ' SaleID                  INT(11)       NULL DEFAULT  0 , ' +
	                          ' PONumber                VARCHAR(30)   NULL DEFAULT NULL, ' +
	                          ' ClientID                INT(11)       NULL DEFAULT  0 , ' +
	                          ' ClassID                 INT(11)       NULL DEFAULT NULL, ' +
	                          ' ClassName               VARCHAR(255)  NULL DEFAULT NULL, ' +
	                          ' ForeignExchangeRate     DOUBLE        NULL DEFAULT  0 , ' +
	                          ' ForeignExchangeCode     VARCHAR(25)   NULL DEFAULT NULL, ' +
	                          ' ForeignTotalAmount      DOUBLE        NULL DEFAULT  0 , ' +
	                          ' ForeignBalanceAmount    DOUBLE        NULL DEFAULT  0 , ' +
	                          ' Comments                VARCHAR(255)  NULL, ' +
                            ' Runningtotal            DOUBLE        NULL DEFAULT 0, '+
	                          ' OpeningBalance      DOUBLE        NULL DEFAULT  0 , ' +
	                          ' closingBalance    DOUBLE        NULL DEFAULT  0 , ' +
                            ' aClientID               INT(11)       NULL DEFAULT 0, '+
	                          ' PRIMARY KEY (ID) ) ENGINE=Myisam ; ' );

    SQLList.add(' INSERT IGNORE INTO ' +SParams.fsRTDetailTablename + ' ( Runningtotal , /*aClientID , */ID, TypeNo,Type,TransDate,CustomerName,JobName,TransID,Status,Duedate,DaysOutstanding,TotalAmountinc,TotalTax,TotalAmount,OutstandingAmount,' +
                    'WithinTerms,1_7Days,7_14Days,14_21Days,Over21Days,1_30Days,30_60Days,60_90Days,Over90Days,' +
                    'SaleID,PONumber,ClientID,ClassID,ClassName,ForeignExchangeRate,ForeignExchangeCode,ForeignTotalAmount,ForeignBalanceAmount,Comments) '+
                    ' Select '+
                    '  @Runningtotal:=@Runningtotal+Totalamountinc   Runningtotal, '+
                    ' Details.* '+
                    ' from  ( select * from  ' +SParams.fsRTDetailTablename + '_1  Order by ClientId, transdate , SaleID  ,typeno ) details ,  (SELECT @Runningtotal:=0) r /*,  (SELECT @ClientId:=0) s*/;');

     SQLList.add(' drop table if exists ' +SParams.fsRTDetailTablename +'_1;');
     SQLList.add(' Create table  ' +SParams.fsRTDetailTablename +'_1 Select * from ' +SParams.fsRTDetailTablename +' where typeno in (1,6);');
     if not devmode then SQLList.add(' delete from ' +SParams.fsRTDetailTablename +' where typeno in (1,6);');
     SQLList.add(' update ' +SParams.fsRTDetailTablename +' Set openingbalance = (Select OutstandingAmount from  ' +SParams.fsRTDetailTablename +'_1 where typeno in (1));');
     SQLList.add(' update ' +SParams.fsRTDetailTablename +' Set closingBalance = (Select OutstandingAmount from  ' +SParams.fsRTDetailTablename +'_1 where typeno in (6));');
     SQLList.add(' drop table if exists ' +SParams.fsRTDetailTablename +'_1;');

      scr := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
      try
           clog(SQLlist.Text);
           scr.SQL.clear;
           scr.SQL.add(SQLlist.Text);
           scr.Execute;
           scr.SQL.clear;
      finally
        DbSharedObj.ReleaseObj(scr);
      end;
   finally
    Freeandnil(SQLlist);
   end;
end;
Procedure CreateRunningBalanceStatement(Var SQLFinal:STring);
var
  SQLList : TStringList;
  RunningTotal : Double;
  sOverDueMsg:String;
  aQry:TERPQuery;
begin
   SQLList := TStringList.create;
   try
     SQLList.add(' drop table if exists ' +SParams.fsRTTablename +';');
     SQLList.add(' create table  ' +SParams.fsRTTablename +
        ' SELECT ' +
        'SaleDate as SaleDate, CustomerName as "Customer Name", ' +
        'CL.JobName, InvoiceDocNumber as "TransID", ' +
        'If(IsRefund="T","Refund",if(IsSalesOrder="T", "Sales Order" , "Invoice")) as Type, ' +
        'if(S.TotalAmountInc=0 , "Back Order" , If('+ SalesBalance +' = 0, "Fully Paid         ", ' + 'if('+ SalesBalance +' = TotalAmountInc, "No Payment         ", If('+ SalesBalance +' < TotalAmountInc, "Partially Paid", 0)))) as Status, ' +
        'DueDate as "Transaction Due Date", ' +
        '  (TO_DAYS(DueDate)-0.00) - ' + DaysTostatementDate+' AS "Days Outstanding", ' +
        'TotalAmountInc AS "Total Amount",   ' +
        ' TotalTax , TotalAmount, ' +
        'Payment AS "Payment",   ' +
        ''+ SalesBalance +' AS "Outstanding Amount", ' +
        'If( '+ DueDays +' <=0,  '+ SalesBalance +', 0.00) AS "Within Terms", ' +
        'If( '+ DueDays +' >0   And  ' + DueDays +' <=7  ,'+ SalesBalance +',0.00) AS "1-7 Days"  , ' +
        'if( '+ DueDays +' >7   And  ' + DueDays +' <=14 ,'+ SalesBalance +',0.00) AS "7-14 Days" , ' +
        'If( '+ DueDays +' >14  And  ' + DueDays +' <=21 ,'+ SalesBalance +',0.00) AS "14-21 Days", ' +
        'If( '+ DueDays +' >21, '+ SalesBalance +'           ,0.00) AS ">21 Days",' +
        'If( '+ DueDays +' >0   And  ' + DueDays +' <=30 ,'+ SalesBalance +',0.00) AS "1-30 Days" , ' +
        'if( '+ DueDays +' >30  And  ' + DueDays +' <=60 ,'+ SalesBalance +',0.00) AS "30-60 Days", ' +
        'If( '+ DueDays +' >60  And  ' + DueDays +' <=90 ,'+ SalesBalance +',0.00) AS "60-90 Days", ' +
        'If( '+ DueDays +' >90, '+ SalesBalance +' ,0.00) AS ">90 Days",' +
        ' SaleID, S.PONumber,   CL.ClientID, ClassID , S.Class as ClassName, ' +
        ' S.ForeignExchangeRate,S.ForeignExchangeCode , S.ForeignTotalAmount , ' +
        ' S.ForeignBalanceAmount, S.ForeignPaidAmount , s.Comments ' +
        ' FROM  tblsales S ' +
        ' INNER JOIN tblClients as CL ON  S.CustomerName = CL.Company ' +
        ' WHERE  ' + SalesType +
        '  and S.converted = "F" and totalamount<> 0 ' +
        ' AND ' +DateTofilter +' between "' + sFrom + '" and "' + sTo + '" ' +
        ' AND ('+Clients('CL')+') ');
        if SParams.showPaid = False then
          SQLlist.add('  AND '+ SalesBalance +'<>0.00 ' );
     SQLlist.add(getClassfilter('ClassId'));
     SQLlist.add(' GROUP BY SaleID ');

     if (SParams.includeinvoiceBO) or (sparams.includeSOBO) then
     begin
       SQLlist.add(' UNION ALL '+
            ' SELECT ' +
            'SaleDate as SaleDate, CustomerName as "Customer Name", ' +
            'CL.JobName, InvoiceDocNumber as "TransID", ' +
            'If(IsSalesOrder="T", "SO-BO" , "Invoice-BO") as Type,  ' +
            '"No Payment         "as Status, ' +
            'DueDate as "Transaction Due Date", ' +
            '  (TO_DAYS(DueDate)-0.00) - ' + DaysTostatementDate+' AS "Days Outstanding", ' +
            'sum(SL.QtySold*SL.LinePriceInc) AS "Total Amount",      ' +
                      ' 0,0, ' +
            '0 AS "Payment", '+
            'sum(SL.QtySold*SL.LinePriceInc)  AS "Outstanding Amount", ' +
            'If( '+ DueDays +' <=0,  sum(SL.QtySold*SL.LinePriceInc), 0.00) AS "Within Terms", ' +
            'If( '+ DueDays +' >0   And  ' + DueDays +' <=7  ,sum(SL.QtySold*SL.LinePriceInc),0.00) AS "1-7 Days"  , ' +
            'if( '+ DueDays +' >7   And  ' + DueDays +' <=14 ,sum(SL.QtySold*SL.LinePriceInc),0.00) AS "7-14 Days" , ' +
            'If( '+ DueDays +' >14  And  ' + DueDays +' <=21 ,sum(SL.QtySold*SL.LinePriceInc),0.00) AS "14-21 Days", ' +
            'If( '+ DueDays +' >21, sum(SL.QtySold*SL.LinePriceInc)           ,0.00) AS ">21 Days",' +
            'If( '+ DueDays +' >0   And  ' + DueDays +' <=30 ,sum(SL.QtySold*SL.LinePriceInc),0.00) AS "1-30 Days" , ' +
            'if( '+ DueDays +' >30  And  ' + DueDays +' <=60 ,sum(SL.QtySold*SL.LinePriceInc),0.00) AS "30-60 Days", ' +
            'If( '+ DueDays +' >60  And  ' + DueDays +' <=90 ,sum(SL.QtySold*SL.LinePriceInc),0.00) AS "60-90 Days", ' +
            'If( '+ DueDays +' >90, sum(SL.QtySold*SL.LinePriceInc) ,0.00) AS ">90 Days",'+
            'S.SaleID, S.PONumber,   CL.ClientID, ClassID ,S.Class  as ClassName, ' +
            ' S.ForeignExchangeRate,S.ForeignExchangeCode , S.ForeignTotalAmount , ' +
            ' S.ForeignBalanceAmount, S.ForeignPaidAmount , s.Comments ' +
            ' FROM tblsales AS S'+
                ' Inner Join tblsaleslines AS SL ON S.SaleID = SL.SaleID'+
                ' inner join tblClients CL on CL.clientId = S.clientId'+
                ' Where (ifnull(S.converted,"F") = "F") and ifnull(S.BoID,"") = "" and ifnull(SL.UnitofMeasureShipped,0) = 0' +
                 BOType + ' AND ('+Clients('CL')+') '+
                 'group by S.saleId');
       SQLlist.add(' Order by `Days Outstanding`, SaleID');
     end;

     SQLlist.add(' ;');
     SQLlist.add(' ALTER TABLE ' +SParams.fsRTTablename+' ADD COLUMN `ID` int not NULL AUTO_INCREMENT , ADD PRIMARY KEY(`ID`);');
     SQLlist.add(' ALTER TABLE ' +SParams.fsRTTablename+' ADD INDEX `Saledateindex`(`SaleDate`);');
     SQLlist.add(' ALTER TABLE ' +SParams.fsRTTablename+' Add COLUMN `RunningTotal` Double null default NULL;');
     SQLlist.add(' ALTER TABLE ' +SParams.fsRTTablename+' Add COLUMN ConNote VARCHAR(25) null default NULL;');
     SQLlist.add(' Update ' +SParams.fsRTTablename+' T inner join tblsales S on T.saleId = S.saleId Set T.ConNote = S.ConNote;');


     SQLlist.add('insert into ' +SParams.fsRTTablename+
                 '(SAleDate, `Customer Name`, JobName, `TransID`,`Type` , `Total Amount` , '+
                 ' `Outstanding Amount`, `Within Terms`, `ClientID`, `ClassID`, `ClassName` , '+
                 '`Days Outstanding`, Payment, `Transaction Due Date` , status , '+
                 'ForeignExchangeRate, ForeignExchangeCode, ForeignTotalAmount, '+
                 'ForeignBalanceAmount, ForeignPaidAmount,Comments)'+
                 ' SELECT `P`.`PrePaymentDate`, `P`.`CompanyName`, `C`.`JobName`, `P`.`PrePaymentID` , "Prepayment" AS `Type`,  0-`P`.`PayAmount`, 0-`P`.`Balance`,0-`P`.`Balance`,`P`.`ClientID`,`P`.`ClassID`,`tblclass`.`ClassName` , ' +
                 '  (TO_DAYS(PrePaymentDate)-0.00) - ' + DaysTostatementDate+' AS "Days Outstanding" , ' +
                 '' + Prepayamount('P' , 'Payment')  +' , `P`.`PrePaymentDate`, ' +
                 'If(' + Prepayamount +' = 0, "Fully Paid         ", ' + 'if(' + Prepayamount +' = P.PayAmount, "No Payment         ", If(' + Prepayamount +' < P.Payamount, "Partially Paid", 0))) as Status ,' +
                 'P.ForeignExchangeRate,P.ForeignExchangeCode,P.ForeignPayAmount ,P.ForeignBalance , P.ForeignPayment , P.Notes'+
                 ' FROM' +
                 ' `tblprepayments` AS `P`' +
                 ' Inner Join `tblclients` AS `C` ON `P`.`ClientID` = `C`.`ClientID`' +
                 ' Inner Join `tblclass` ON `P`.`ClassID` = `tblclass`.`ClassID`' +
                 ' Where ifnull(P.Deleted,"F") <> "T" and  ifnull(' + Prepayamount +',0)<> 0   ' +
                 ' AND `P`.`PrePaymentDate` between "' + sFrom + '" and "' + sTo + '" ' +
                 ' AND ('+Clients('C')+') ;');
     aQry:= DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
     try
      With aQry do begin
       SQL.add(SQLlist.Text);
       Execute;
       SQL.clear;
       SQL.add(' select * from ' +SParams.fsRTTablename+' order by `days outstanding`');
       Open;
       RunningTotal := TotalAmt(sFrom, sTo, false, false);
       if recordcount > 0 then
       begin
         First;
         While Eof = False do
         begin
           RunningTotal := RunningTotal + fieldbyname('Outstanding Amount').asFloat;
           Edit;
           FieldByname('RunningTotal').asFloat := RunningTotal;
           Post;
           Next;
         end;
       end;
      end;
     finally
       DbSharedObjectsObj.DbSharedObj.ReleaseObj(aqry);
     end;
   finally
     FreeandNil(SQLList);
   end;

   sOverDueMsg := GetOverDueMsg(SParams.fsRTTablename);
   if empty(sOverDueMsg) then
     sOverdueMsg := '';
       SQLfinal := '{Clientdetails}Select CL.*,' +
                   ' concat_WS(" " , FirstName , LastName) as ClName,' +
                    FloatToStr(AvailableRewardPoints(sParams.ClientID , sParams.ReportDateFrom)) + ' as OpeningBalanceRewardPoints, ' +
                    FloatToStr(AvailableRewardPoints(sParams.ClientID , sParams.ReportDateTo)) + ' as ClosingBalanceRewardPoints , ' +
                    FloatToStr(TotalAmt(sFrom, sTo, false, false))+ ' as OpeningBalance , '+
                    FloatToStr(RunningTotal)               + ' as OutstandingAmt  , '+
                    Quotedstr(FormatDatetime(FormatSettings.ShortDateformat, sParams.ReportDateFrom))   + ' as DateFrom ,'+
                    Quotedstr(FormatDatetime(FormatSettings.ShortDateformat, sParams.ReportDateTo))     + ' as DateTo, '+
                    Quotedstr(FormatDatetime(FormatSettings.ShortDateformat, sParams.CurDate))+ ' as Paymentdate,  '+
                    ClientbillToAddress('CL') + ' as BillToAddress '  +
                    ' from tblclients  CL where  '+Clients('CL') +
                    chr(13) + ' ~|||~{Details} select P.*,  ' +
                    ' if(P.type = "Prepayment" ,     "Payment Date"                  , "Product Name") as D1, ' +
                    ' if(P.type = "Prepayment" ,     "Currency Code" , "Description")     as D2, ' +
                    ' if(P.type = "Prepayment" ,     "Exchange Rate"  , "UOM")               as D3, ' +
                    ' if(P.type = "Prepayment" ,     "Method"              , "Quantity Sold") as D4, ' +
                    ' if(P.type = "Prepayment" ,     "Amount"             , "Total amount")  as D5, ' +
                    ' if(P.type = "Prepayment" ,     `PR`.`PrePaymentDate` , SL.ProductName) as F1, ' +
                    ' if(P.type = "Prepayment" ,     `PR`.`ForeignExchangeCode` , SL.Product_Description) F2, ' +
                    ' if(P.type = "Prepayment" ,     Pr.ForeignExchangeRate , SL.UnitofMeasureSaleLines)as F3, ' +
                    ' if(P.type = "Prepayment" ,     `PM`.`NAME` , SL.UnitofMeasureShipped) F4, ' +
                    ' if(P.type = "Prepayment" ,     0-`PR`.`Payamount` , SL.TotalLineAmountInc) F5, ' +
                    'Sl.LineTaxCode , SL.LineTax, ' +
                    quotedstr(sOverDueMsg) + ' as OverDueMsg ' +
                    ' from ' +SParams.fsRTTablename+' P '+
                    ' Left join tblSalesLines SL on SL.SaleId = P.TransID and P.type <> "Prepayment" '+
                    ' Left join tblprepayments PR on PR.PrepaymentId = P.TransId and P.type = "Prepayment" '+
                    ' Left Join `tblpaymentmethods` AS `PM` ON `PR`.`PayMethodID` = `PM`.`PayMethodID` '+
                    ' order by '+
                    iif(sparams.OrderOptionsIndex =0 , '`days outstanding`', iif(sparams.OrderOptionsIndex =1 , 'P.TransID','P.saledate' ))+
                    '~|||~'+ companyInfoSQL;
       SQLFinal := SQLfinal + chr(13) + '~|||~{SalesPayments}'+
                    ' Select ' +
                    ' D.PaymentId, D.PaymentDate, PM.NAME as Paymethod , D.Notes, D.ReferenceNo, ' +
                    ' DL.SaleID, ' +
                    ' DL.Payment, DL.ForeignPayment ' +
                    ' From tbldeposits D ' +
                    ' inner join tblpaymentmethods PM on D.PayMethodID = PM.PayMethodID ' +
                    ' inner join tbldepositline DL on D.PaymentID = DL.PaymentID ' +
                    ' inner join  ' +SParams.fsRTTablename+' S on DL.saleId = S.saleID where  D.Deleted ="F" ' ;
   end;

end.
