unit StatementsSimpleLib;

interface

procedure CreateTempStatementTable(const SQL: String);
Procedure CreateStatement(Var SQLFinal:STring);
implementation

uses StatementsLib, classes,SysUtils , commonlib, tcDataUtils, AppEnvironment,
  TemplateReportsLib, ERPDbComponents, DbSharedObjectsObj, CommonDbLib,
  TempTableUtils, MySQLConst;

Procedure CreateStatement(Var SQLFinal:STring);
var
  SQLList : TStringList;
  sOverDueMsg:String;
  function Dates:String;
  begin
      Result := Quotedstr(sFrom) + ' as DateFrom,'+ QuotedStr(sTo) + ' as DateTo, ' ;
  end;
begin
   SQLList := TStringList.create;
   try
     SQLList.add('SELECT ' +
          Dates+
          'SaleDate as "Transaction Date", CustomerName as "Customer Name", ' +
          'CL.JobName, "" AS "ReceiptNo",InvoiceDocNumber as "Invoice Number", ' +
          'If(IsRefund="T","Refund",if(IsSalesOrder="T", "Sales Order" , "Invoice")) as Type, ' +
          'if(S.TotalAmountInc=0 , "Back Order" , If('+ SalesBalance +' = 0, "Fully Paid         ", ' + 'if('+ SalesBalance +' = TotalAmountInc, "No Payment         ", If('+ SalesBalance +' < TotalAmountInc, "Partially Paid", 0)))) as Status,  ' +
          'DueDate as "Transaction Due Date", ' +
          '  (TO_DAYS(DueDate)-0.00) - ' + DaysTostatementDate+' AS "Days Outstanding", ' +
          'TotalAmountInc AS "Total Amount",   ' +
          ''+ SalesBalance +' AS "Outstanding Amount", ' +
          'S.ForeignTotalAmount AS "Foreign Total Amount",   ' +
          'S.ForeignBalanceAmount AS "Foreign Outstanding Amount", ' +
          'S.ForeignPaidAmount,'+
          'If( '+ DueDays +' <=0,  '+ SalesBalance +', 0.00) AS "Within Terms", ' +
          'If( '+ DueDays +' >0   And  ' + DueDays +' <=7  ,'+ SalesBalance +',0.00) AS "1-7 Days"  , ' +
          'if( '+ DueDays +' >7   And  ' + DueDays +' <=14 ,'+ SalesBalance +',0.00) AS "7-14 Days" , ' +
          'If( '+ DueDays +' >14  And  ' + DueDays +' <=21 ,'+ SalesBalance +',0.00) AS "14-21 Days", ' +
          'If( '+ DueDays +' >21, '+ SalesBalance +'           ,0.00) AS ">21 Days",' +
          'If( '+ DueDays +' >0   And  ' + DueDays +' <=30 ,'+ SalesBalance +',0.00) AS "1-30 Days" , ' +
          'if( '+ DueDays +' >30  And  ' + DueDays +' <=60 ,'+ SalesBalance +',0.00) AS "30-60 Days", ' +
          'If( '+ DueDays +' >60  And  ' + DueDays +' <=90 ,'+ SalesBalance +',0.00) AS "60-90 Days", ' +
          'If( '+ DueDays +' >90, '+ SalesBalance +' ,0.00) AS ">90 Days",' +
          'SaleID,S.PONumber,  CL.ClientID, ClassID , "" as ClassName, ' + '"Summary" as Flag, S.comments, S.ConNote ' +
          ' FROM  tblsales S ' +
          ' INNER JOIN tblClients as CL ON  S.CustomerName = CL.Company ' +
          ' WHERE  ' + SalesType +
          '  and (S.converted = "F" or S.ISInvoice = "T") ' +
          ' AND ' +DateTofilter +' between "' + sFrom + '" and "' + sTo + '" ' +
          ' AND ('+Clients('CL')+') ');
     if sparams.showPaid = False then
       SQLlist.add('  AND '+ SalesBalance +'<>0.00 ' );
     SQLlist.add(getClassfilter('ClassId'));
     SQLlist.add(' GROUP BY SaleID ');

     SQLList.add('Union ALL SELECT ' +
          Dates+
          'SaleDate as "Transaction Date",CustomerName as "Customer Name", ' +
          'CL.JobName,"" AS "ReceiptNo",InvoiceDocNumber as "Invoice Number", ' +
          'If(IsRefund="T","OB_Refund",if(IsSalesOrder="T", "OB_SalesOrder" , "OB_Invoice")) as Type, ' +
          'if(S.TotalAmountInc=0 , "Back Order" , If('+ SalesBalance +' = 0, "Fully Paid         ", ' + 'if('+ SalesBalance +' = TotalAmountInc, "No Payment         ", If('+ SalesBalance +' < TotalAmountInc, "Partially Paid", 0)))) as Status, ' +
          'DueDate as "Transaction Due Date", ' +
          '  (TO_DAYS(DueDate)-0.00) - ' + DaysTostatementDate+' AS "Days Outstanding", ' +
          'TotalAmountInc AS "Total Amount",   ' +
          ''+ SalesBalance +' AS "Outstanding Amount", ' +
          'S.ForeignTotalAmount AS "Foreign Total Amount",   ' +
          'S.ForeignBalanceAmount AS "Foreign Outstanding Amount", ' +
          'S.ForeignPaidAmount,'+
          'If( '+ DueDays +' <=0,  '+ SalesBalance +', 0.00) AS "Within Terms", ' +
          'If( '+ DueDays +' >0   And  ' + DueDays +' <=7  ,'+ SalesBalance +',0.00) AS "1-7 Days"  , ' +
          'if( '+ DueDays +' >7   And  ' + DueDays +' <=14 ,'+ SalesBalance +',0.00) AS "7-14 Days" , ' +
          'If( '+ DueDays +' >14  And  ' + DueDays +' <=21 ,'+ SalesBalance +',0.00) AS "14-21 Days", ' +
          'If( '+ DueDays +' >21, '+ SalesBalance +'           ,0.00) AS ">21 Days",' +
          'If( '+ DueDays +' >0   And  ' + DueDays +' <=30 ,'+ SalesBalance +',0.00) AS "1-30 Days" , ' +
          'if( '+ DueDays +' >30  And  ' + DueDays +' <=60 ,'+ SalesBalance +',0.00) AS "30-60 Days", ' +
          'If( '+ DueDays +' >60  And  ' + DueDays +' <=90 ,'+ SalesBalance +',0.00) AS "60-90 Days", ' +
          'If( '+ DueDays +' >90, '+ SalesBalance +' ,0.00) AS ">90 Days",' +
          'SaleID,  S.PONumber,  CL.ClientID, ClassID , "" as ClassName, ' + '"Summary" as Flag, S.comments, S.ConNote' +
          ' FROM  tblsales S ' +
          ' INNER JOIN tblClients as CL ON  S.CustomerName = CL.Company ' +
          ' WHERE  ' + SalesType +
          '  and (S.converted = "F" or S.ISInvoice = "T") ' +
          ' AND ' +DateTofilter +' < "' + sFrom + '" ' +
          ' AND ('+Clients('CL')+') ');
     if sParams.showPaid = False then
       SQLlist.add('  AND '+ SalesBalance +'<>0.00 ' );
     SQLlist.add(getClassfilter('ClassId'));
     SQLlist.add(' GROUP BY SaleID ');

     //Prepayments
     SQLlist.add(' Union ALL    SELECT ' +
          Dates+
          'D.PrepaymentDate as "Payment Date", ' +
          'D.companyname as "Customer Name", ' +
          'D.Companyname, ' +
          'D.PrepaymentID  AS "ReceiptNo", ' +
          '"" as "Invoice Number",   ' +
          '"Prepayment" as Type, ' +
          '"Remaining" as Status,   ' +
          'PrePaymentDate as "Due Date", ' +
          '0.00 AS "Days Outstanding",' +
          'Sum(D.PayAmount)  AS "Total Amount", ' +
          'Sum(' + Prepayamount('D') +') AS "Outstanding Amount", ' +
          'sum(D.ForeignPayAmount) AS "Foreign Total Amount",   ' +
          'Sum(D.ForeignBalance) AS "Foreign Outstanding Amount", ' +
          'sum(d.ForeignPayment) as ForeignPayment,'+
          'Sum(' + Prepayamount('D') +') AS "Within Terms", ' +
          '0.00 AS "1-7 Days", ' +
          '0.00 AS "7-14 Days", ' +
          '0.00 AS "14-21 Days",  ' +
          '0.00 AS ">21 Days",  ' +
          '0.00 AS "1-30 Days", ' +
          '0.00 AS "30-60 Days", ' +
          '0.00 AS "60-90 Days",  ' +
          '0.00 AS ">90 Days",  ' +
          '0,"",  D.ClientID, D.ClassID , "" as ClassName, ' + '"Details" as Flag, D.Notes as Comments, Null as ConNote' +
          ' FROM ' +
          '`tblPrePayments` D' +
          ' WHERE   ifnull(Deleted,"F") <> "T" and PrepaymentDate between "' +        sFrom + '" and "' + sTo + '" ' +
          ' AND ('+Clients('D')+') ');
     SQLlist.add(getClassfilter('D.ClassId'));
     SQLlist.add(' and ' + Prepayamount('D') +' <>0.00 ' );
     SQLlist.add(' GROUP BY D.PrePaymentID ');

     SQLlist.add(' Union ALL    SELECT ' +
          Dates+
          'NULL as "Payment Date", ' +
          'D.companyname as "Customer Name", ' +
          'D.Companyname, ' +
          '0 AS "ReceiptNo", ' +
          '"" as "Invoice Number",   ' +
          '"OB_Prepayment" as Type, ' +
          '"" as Status,   ' +
          'NULL as "Due Date", ' +
          '0.00 AS "Days Outstanding",' +
          'Sum(D.PayAmount)  AS "Total Amount", ' +
          'Sum(' + Prepayamount('D') +') AS "Outstanding Amount", ' +
          'Sum(D.ForeignPayAmount) AS "Foreign Total Amount",   ' +
          'Sum(D.ForeignBalance) AS "Foreign Outstanding Amount", ' +
          'sum(d.ForeignPayment) as ForeignPayment,'+
          'Sum(' + Prepayamount('D') +') AS "Within Terms", ' +
          '0.00 AS "1-7 Days", ' +
          '0.00 AS "7-14 Days", ' +
          '0.00 AS "14-21 Days",  ' +
          '0.00 AS ">21 Days",  ' +
          '0.00 AS "1-30 Days", ' +
          '0.00 AS "30-60 Days", ' +
          '0.00 AS "60-90 Days",  ' +
          '0.00 AS ">90 Days",  ' +
          '0, "",  D.ClientID, D.ClassID , "" as ClassName, ' + '"Details" as Flag, D.Notes as Comments, null as ConNote' +
          ' FROM ' +
          '`tblPrePayments` D' +
          ' WHERE   ifnull(Deleted,"F") <> "T" and PrepaymentDate < "' +        sFrom + '"  ' +
          ' AND ('+Clients('D')+') ');
     SQLlist.add(getClassfilter('D.ClassId'));
     SQLlist.add(' and ' + Prepayamount('D') +' <>0.00 ' );
     SQLlist.add(' GROUP BY D.ClientID, d.classid');
     SQLlist.add(' ORDER BY `ReceiptNo`; ');


     CreateTempStatementTable(SQLlist.Text);
   Finally
     FreeandNil(sqlList);
   end;

   sOverDueMsg := GetOverDueMsg(SParams.fsTablename);

   if Empty(sOverDueMsg) then
     sOverDueMsg := ' '; //Stop Invaild field size error ('' = null field size)
   SQLFINAL := '{Statements}'+
       'Select ST.type AS Transtype,' +
       'STSUM.`SumTotal Amount`,STSUM.`SumOutstanding Amount`,' +
       'STSUM.`SumPayment`,STSUM.`SumWithin Terms`,STSUM.`Sum1-7 Days` ,' +
       'STSUM.`Sum7-14 Days`,STSUM.`Sum14-21 Days`,STSUM.`Sum>21 Days`,' +
       'STSUM.`Sum1-30 Days`,STSUM.`Sum30-60 Days`,STSUM.`Sum60-90 Days` ,STSUM.`Sum>90 Days`, ' +
       'convert(if(ifnull(`ReceiptNo`,"")="",ST.SaleID,`ReceiptNo`),char) as transID, ' +
       'ST.* , CL.* , ' +
       'S.ForeignExchangeRate,S.ForeignExchangeCode ,  ' +
       '`SL`.`ProductName`,`SL`.`QtySold`,`SL`.`Shipped`,`SL`.`UnitofMeasureShipped`,`SL`.`BackOrder`,`SL`.`UnitofMeasureBackorder`,`SL`.`UnitofMeasureSaleLines`,`SL`.`TotalLineAmount`,`SL`.`TotalLineAmountInc`, SL.Product_Description , SL.lineTax , ' +
       // 'sl.qtysold*sl.lineprice as EstBOPrice, sl.qtysold*sl.linepriceinc as EstBOPriceinc,'+
       'CONCAT_WS(CHAR(13),CL.Company,CL.Street,CL.Street2,CL.Street3,CL.Suburb,CONCAT_WS(" ",CL.State,CL.PostCode)) as CustomerDetails,' +
       'Concat_WS(" ",CL.Title,CL.FirstName,CL.LastName) as CompanyContact,  ' +
       QuotedStr(sOverDueMsg) + ' as OverDueMsg,' + QuotedStr(SParams.SelectedClass) + ' as ClassOption, ' +
       'RIGHT(IF(ST.SaleID<>0,CONCAT_ws("",ST.`Type`,ST.SaleID),""),255) AS InvoiceDesc,' +
       FloatToStr(AvailableRewardPoints(SParams.ClientID , SParams.reportdatefrom)) + ' as OpeningBalanceRewardPoints, ' +
       FloatToStr(AvailableRewardPoints(SParams.ClientID , SParams.ReportDateTo)) + ' as ClosingBalanceRewardPoints ' +
       ' FROM ' +
       SParams.fsTablename + ' as ST  ' +
       ' inner join '+ SParams.fsTempTblName +' as STSUM on STSUM.type = ST.type ' +
       ' LEFT join (tblSalesLines SL  inner join tblSales S on S.SaleID = SL.SaleID)on SL.SaleId = ST.SaleId AND ST.Type in("Invoice" ,"Sales Order", "Refund") and ifnull(SL.Shipped,0)<>0 ' +
       ' LEFT JOIN tblclients CL on ST.ClientID = CL.ClientID ' +
       ' where ST.`Customer Name` <>  "Balance Forward" and ST.Type <> "Prepayment" and not(ST.Type like "OB_%" )' +
       ' Order by Transtype,';
   if SParams.OrderOptionsIndex =1  then
     SQLFINAL :=SQLFINAL +'transID'
   else if SParams.OrderOptionsIndex =2  then
     SQLFINAL :=SQLFINAL +'`Transaction Date`'
   else
     SQLFINAL :=SQLFINAL +'`Days Outstanding` ';

   SQLFINAL := SQLFINAL +chr(13) + '~|||~{StatementSummary}'+
                  'Select St.type, ' +
                  'Sum(if(St.type like "%Prepayment%" ,0-`Outstanding Amount` , `Outstanding Amount` )) as `Outstanding Amount`,' +
                  'Sum(if(St.type like "%Prepayment%" ,0-`Foreign Outstanding Amount` , `Foreign Outstanding Amount` )) as `Foreign Outstanding Amount`' +
                  ' FROM ' + SParams.fsTablename + ' as ST  '+
                  ' group by ST.Type ' ;
   if SParams.includeinvoiceBO then
      SQLFINAL := SQLFINAL +chr(13) +' union all ' +
                  ' SELECT "Invoice BO" as Type, '+
                  'ifnull(Sum(SL.QtySold*SL.LinePriceInc),0), '+
                  'ifnull(Sum(SL.ForeignExchangeSellRate*SL.QtySold*SL.LinePriceInc),0)'+
                  ' FROM tblsales AS S Inner Join tblsaleslines AS SL ON S.SaleID = SL.SaleID'+
                  ' Where ifnull(S.BoID,"") = "" and ifnull(SL.UnitofMeasureShipped,0) = 0 '+
                  'AND isinvoice="T"  '+
                  ' AND ('+Clients('S')+') ';
   if SParams.includeSOBO then
      SQLFINAL := SQLFINAL +chr(13) +' union all ' +
                ' SELECT  "Sales Order BO"  as Type, '+
                'ifnull(sum(SL.QtySold*SL.LinePriceInc),0),'+
                'ifnull(sum(SL.ForeignExchangeSellRate*SL.QtySold*SL.LinePriceInc),0)'+
                ' FROM tblsales AS S Inner Join tblsaleslines AS SL ON S.SaleID = SL.SaleID'+
                ' Where ifnull(S.BoID,"") = "" and ifnull(SL.UnitofMeasureShipped,0) = 0 '+
                ' AND (issalesorder="T"  ) and (ifnull(S.converted,"F") = "F")'+
                ' AND ('+Clients('S')+') ';
   SQLfinal := SQLFinal +chr(13) + '~|||~{Prepayment} Select  ST.* '+
      ' FROM ' + SParams.fsTablename + ' as ST  where ST.Type = "Prepayment"  order by `Transaction Date` DESC' ;

   SQLFINAL := SQLFINAL + chr(13) + '~|||~{Balances} SELECT ' +
        FloatToStr(TotalAmt(sFrom, sTo, false, false)) +      ' AS "Total Amount",  ' +
        FloatToStr(TotalAmt(sFrom, sTo, true, true)) + ' AS "Outstanding Amount",  ' +
        FloatToStr(TotalForeignAmt(sFrom, sTo, False, False)) +      ' AS "Foreign Total Amount",  ' +
        FloatToStr(TotalForeignAmt(sFrom, sTo, true, true)) + ' AS "Foreign Outstanding Amount",  ' +
          'sum(ForeignPayment) as ForeignPayment,'+
        'if(sum(ifnull(`ST`.`>90 Days`,0)) > 0 , ' + quotedStr(Appenv.CompanyPrefs.ODue90Days) + ' ,' +
        'if(sum(ifnull(`ST`.`60-90 Days`,0)) > 0 , ' + quotedStr(Appenv.CompanyPrefs.ODue60Days) + ' ,' +
        'if(sum(ifnull(`ST`.`30-60 Days`,0)) > 0 , ' + quotedStr(Appenv.CompanyPrefs.ODue30Days) + ' ,' +
        'if(sum(ifnull(`ST`.`>21 Days`,0)) > 0 , ' + quotedStr(Appenv.CompanyPrefs.ODue21Days) + ' ,' +
        'if(sum(ifnull(`ST`.`14-21 Days`,0)) > 0 , ' + quotedStr(Appenv.CompanyPrefs.ODue14Days) + ' ,' +
        'if(sum(ifnull(`ST`.`7-14 Days`,0)) > 0 , ' + quotedStr(Appenv.CompanyPrefs.ODue7Days) + ' ,' +
        'if(sum(ifnull(`ST`.`1-7 Days`, 0)) > 0 , ' + quotedStr(Appenv.CompanyPrefs.ODue1Days) + ' , ' + quotedStr(Appenv.CompanyPrefs.ODueOk) + ' ))))))) as OverDuemsg,' +
         QuotedStr(formatDateTime(FormatSettings.ShortDateformat, sParams.CurDate)) + ' as StatementDate  ' +
         ' FROM ' + sParams.fsTablename + ' as ST  where ST.Type ="Invoice"';

   //SQLFINAL:= SQLFINAL+chr(13) + '~|||~{compInfo}select tblcompanyinformation.*, ' + QuotedStr(AppEnv.Employee.EmployeeName) + ' as LoggedInUser from tblcompanyinformation ';
   SQLFINAL:= SQLFINAL+chr(13) + '~|||~'+companyInfoSQL;

   SQLfinal := SQLFinal +chr(13) + '~|||~{Summary}'+
      'Select sum(if(ifnull(ST.Type,"") = "Prepayment", '+
      '0-ifnull(ST.`Outstanding Amount`,0), '+
      'ifnull(ST.`Outstanding Amount`,0))) as Amount , '+
      'ST.DateFrom, ST.dateto  ' +
      ' FROM ' +
      sParams.fsTablename + ' as ST  ' +
      ' where ifnull(ST.`Customer Name`,"")  <>  "Balance Forward" and not(ST.type like "OB_%") ' +
      ' group by ST.DateFrom, ST.dateto';

   SQLFINAL := SQLFINAL + chr(13) + '~|||~{OB_Ageing}'+
      'Select "Opening Balance" AS Transtype,' +
      'Sum(if(St.type = "OB_Prepayment" ,0-`Total Amount`       , `Outstanding Amount`       )) as `Total Amount`, ' +
      'Sum(if(St.type = "OB_Prepayment" ,0-`Outstanding Amount` , `Outstanding Amount` )) as `Outstanding Amount`, ' +
      'Sum(if(St.type = "OB_Prepayment" ,0-`Within Terms`       , `Within Terms`       )) as `Within Terms`, ' +
      'Sum(if(St.type = "OB_Prepayment" ,0-`1-7 Days`           , `1-7 Days`           )) as `1-7 Days`, ' +
      'Sum(if(St.type = "OB_Prepayment" ,0-`7-14 Days`          , `7-14 Days`          )) as `7-14 Days`, ' +
      'Sum(if(St.type = "OB_Prepayment" ,0-`14-21 Days`         , `14-21 Days`         )) as `14-21 Days`,  ' +
      'Sum(if(St.type = "OB_Prepayment" ,0-`>21 Days`           , `>21 Days`           )) as `>21 Days`,  ' +
      'Sum(if(St.type = "OB_Prepayment" ,0-`1-30 Days`          , `1-30 Days`          )) as `1-30 Days`, ' +
      'Sum(if(St.type = "OB_Prepayment" ,0-`30-60 Days`         , `30-60 Days`         )) as `30-60 Days`, ' +
      'Sum(if(St.type = "OB_Prepayment" ,0-`60-90 Days`         , `60-90 Days`         )) as `60-90 Days`,  ' +
      'Sum(if(St.type = "OB_Prepayment" ,0-`>90 Days`           , `>90 Days`           )) as `>90 Days`,  ' +
      'CL.ClientID, CONCAT_WS(CHAR(13),CL.Company,CL.Street,CL.Street2,CL.Street3,CL.Suburb,CONCAT_WS(" ",CL.State,CL.PostCode)) as CustomerDetails,' +
      'Concat_WS(" ",CL.Title,CL.FirstName,CL.LastName) as CompanyContact,  ' +
      QuotedStr(sParams.SelectedClass) + ' as ClassOption ' +
      ' FROM ' +
      sParams.fsTablename + ' as ST  ' +
      ' LEFT JOIN tblclients CL on ST.ClientID = CL.ClientID ' +
      ' where ST.Type like "OB_%" ' +
      ' group by CL.ClientID';
   SQLFINAL := SQLFINAL + chr(13) + '~|||~{BackOrders}'+
            ' SELECT S.CustomerName, S.SaleDate,S.duedate, ' +
            '  (TO_DAYS(DueDate)-0.00) - ' + DaysTostatementDate+' AS "Days Outstanding", ' +
            ' If(IsRefund="T","Refund",if(IsSalesOrder="T", "Sales Order" , "Invoice")) as Type,' +
            ' S.SaleID AS TransId,CL.*,SL.ProductName,SL.QtySold,SL.Shipped,SL.BackOrder,'+
            ' SL.UnitofMeasureBackorder,SL.UnitofMeasureSaleLines,'+
            'SL.QtySold*SL.LinePriceInc as foreignLinePriceInc,'+
            ' SL.QtySold*SL.LinePriceInc,SL.QtySold*SL.LinePrice ,SL.Product_Description , '+
            ' CONCAT_WS(CHAR(13),CL.Company,CL.Street,CL.Street2,CL.Street3,CL.Suburb,CONCAT_WS(" ",CL.State,CL.PostCode))as CustomerDetails,'+
            ' Concat_WS(" ",CL.Title,CL.FirstName,CL.LastName) as CompanyContact, '+
            'SL.QtySold*SL.LinePriceInc as `Total Amount`, '+
            ' If( '+ DueDays +' <=0,  SL.QtySold*SL.LinePriceInc, 0.00) AS "Within Terms", ' +
            ' If( '+ DueDays +' >0   And  ' + DueDays +' <=7  ,SL.QtySold*SL.LinePriceInc,0.00) AS "1-7 Days"  , ' +
            ' if( '+ DueDays +' >7   And  ' + DueDays +' <=14 ,SL.QtySold*SL.LinePriceInc,0.00) AS "7-14 Days" , ' +
            ' If( '+ DueDays +' >14  And  ' + DueDays +' <=21 ,SL.QtySold*SL.LinePriceInc,0.00) AS "14-21 Days", ' +
            ' If( '+ DueDays +' >21, SL.QtySold*SL.LinePriceInc           ,0.00) AS ">21 Days",' +
            ' If( '+ DueDays +' >0   And  ' + DueDays +' <=30 ,SL.QtySold*SL.LinePriceInc,0.00) AS "1-30 Days" , ' +
            ' if( '+ DueDays +' >30  And  ' + DueDays +' <=60 ,SL.QtySold*SL.LinePriceInc,0.00) AS "30-60 Days", ' +
            ' If( '+ DueDays +' >60  And  ' + DueDays +' <=90 ,SL.QtySold*SL.LinePriceInc,0.00) AS "60-90 Days", ' +
            ' If( '+ DueDays +' >90, SL.QtySold*SL.LinePriceInc ,0.00) AS ">90 Days"' +
            ' FROM tblsales AS S'+
            ' Inner Join tblsaleslines AS SL ON S.SaleID = SL.SaleID'+
            ' inner join tblClients CL on CL.clientId = S.clientId'+
            ' Where (ifnull(S.converted,"F") = "F") and ifnull(S.BoID,"") = "" and ifnull(SL.UnitofMeasureShipped,0) = 0';
   SQLFINAL := SQLFINAL + BOType;
   SQLFINAL := SQLFINAL + ' AND ('+Clients('CL')+') ';
   SQLFINAL := SQLFINAL + ' Order by  Type';
   SQLFinal := SQLfinal + chr(13) + '~|||~{Clientdetails} Select CL.*, ' +
            ' concat(ifnull(CL.ForeignExchangeSellCode , '+ QuotedStr(Appenv.RegionalOptions.ForeignExDefault)  +') ,'+
            'if(ifnull(CC.CurrencySymbol,"")="" , "" , concat("(" ,CC.CurrencySymbol,")")))  CurrencySymbol  ,  ' +
            ' concat_WS(" " , FirstName , LastName) as ClName,' +
            'concat_WS(" " , CL.title, CL.firstname, CL.lastname )  as Clientdetailname,  ' +
            'concat_WS(" " , C.contacttitle, C.contactfirstname, C.contactsurname )  as Primarycontactname,  ' +
            QuotedStr(FormatDateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat, sPArams.ReportDateFrom))+ ' as Datefrom ,' +
            QuotedStr(FormatDateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat, sPArams.ReportDateto))+ ' as Dateto ,  ' +
            ClientbillToAddress('CL') + ' as BillToAddress '  +
            ' from tblClients CL ' +
            ' Left join tblContacts C on Cl.ClientId = C.ClientId and C.IsPrimaryContact = "T"' +
            ' left  join tblcurrencyconversion  CC on ifnull(CL.ForeignExchangeSellCode , '+ QuotedStr(Appenv.RegionalOptions.ForeignExDefault)  +')  = CC.Code' +
//                              ' where ('+Clients('CL')+')';
            ' where CL.ClientID = ' + IntToStr(sParams.ClientID);
   SQLFinal := SQLfinal + chr(13) + '~|||~{Summary_ageing}'+
      'SELECT ' +
      '`Type`       AS `Transtype`, ' +
      'Sum(if(St.type = "Prepayment" ,0-`Total Amount`      ,`Total Amount`       )) as `Total Amount`      ,' +
      'Sum(if(St.type = "Prepayment" ,0-`Outstanding Amount`,`Outstanding Amount` )) as `Outstanding Amount`,' +
      'Sum(if(St.type = "Prepayment" ,0-`Within Terms`      ,`Within Terms`       )) as `Within Terms`      ,' +
      'Sum(if(St.type = "Prepayment" ,0-`Payment`           ,`Payment`            )) as `Payment`           ,' +
      'Sum(if(St.type = "Prepayment" ,0-`1-7 Days`          ,`1-7 Days`           )) as `1-7 Days`          ,' +
      'Sum(if(St.type = "Prepayment" ,0-`7-14 Days`         ,`7-14 Days`          )) as `7-14 Days`         ,' +
      'Sum(if(St.type = "Prepayment" ,0-`14-21 Days`        ,`14-21 Days`         )) as `14-21 Days`        ,' +
      'Sum(if(St.type = "Prepayment" ,0-`>21 Days`          ,`>21 Days`           )) as `>21 Days`          ,' +
      'Sum(if(St.type = "Prepayment" ,0-`1-30 Days`         ,`1-30 Days`          )) as `1-30 Days`         ,' +
      'Sum(if(St.type = "Prepayment" ,0-`30-60 Days`        ,`30-60 Days`         )) as `30-60 Days`        ,' +
      'Sum(if(St.type = "Prepayment" ,0-`60-90 Days`        ,`60-90 Days`         )) as `60-90 Days`        ,' +
      'Sum(if(St.type = "Prepayment" ,0-`>90 Days`          ,`>90 Days`           )) as `>90 Days`           ' +
      'FROM ' +
      sParams.fsTablename + ' as ST  ' +
      ' group by Transtype order by Transtype' ;

   SQLFinal := SQLfinal + chr(13) + '~|||~{Descriptions}'+
      'Select ' +QuotedStr('(Opening Balance +' +Transactions+')') +' as Closingbalance, '+
      QuotedStr('('+Transactions+')') +' as Summary, '+
      QuotedStr('('+TransactionsWithBO+')') +' as StatementSummary';

   SQLFinal := SQLfinal + chr(13) + '~|||~{SalesPayments}'+
                ' Select ' +
                  ' D.PaymentId, D.PaymentDate, PM.NAME as Paymethod , D.Notes, D.ReferenceNo, ' +
                  ' DL.SaleID, ' +
                  ' DL.Payment, DL.ForeignPayment ' +
                  ' From tbldeposits D ' +
                  ' inner join tblpaymentmethods PM on D.PayMethodID = PM.PayMethodID ' +
                  ' inner join tbldepositline DL on D.PaymentID = DL.PaymentID ' +
                  ' inner join  tblsales AS S  on DL.saleId = S.saleID'+
                  ' inner join tblclients CL on CL.clientId = S.ClientID '+
                  ' WHERE  ' + SalesType +
                  '  and (S.converted = "F" or S.ISInvoice = "T") ' +
                  ' AND ' +DateTofilter +' between "' + sFrom + '" and "' + sTo + '" ' +
                  ' AND ('+Clients('CL')+') ' +
                  getClassfilter('S.ClassId');
end;
procedure CreateTempStatementTable(const SQL: String);
var
  qryMyScript: TERPScript;
  BulkSQL,TempList: TStringList;
  tmptablename:string;
  tmpfilename:string;
begin
  qryMyScript := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
  TempList := TStringList.Create;
  BulkSQL := TStringList.Create;
  try
    BulkSQL.Clear;
    TempList.Clear;

    With BulkSQL Do Begin
      Add('DROP TABLE IF EXISTS ' + sParams.fsTablename + ';');
      Add('CREATE TABLE ' + sParams.fsTablename + ' ( ');
      Add('`ID` int(11) NOT NULL auto_increment, ');
      Add('`DateFrom`               Date Default    NULL, ');
      Add('`DateTo`                 Date Default    NULL, ');
      Add('`Transaction Date`       Date Default    NULL, ');
      Add('`Customer Name`          Varchar(255) Default NULL, ');
      Add('`JobName`                Varchar(255) Default NULL, ');
      Add('`ReceiptNo`             Varchar(255) Default NULL, ');
      Add('`Invoice Number`         Varchar(255) Default NULL, ');
      Add('`Type`                   Varchar(255) Default NULL,');
      Add('`Status`                 Varchar(255) Default NULL,');
      Add('`Transaction Due Date`   Date         Default NULL,');
      Add('`Days Outstanding`       Double      NOT NULL Default 0,');
      Add('`Total Amount`           Double      NOT NULL Default 0,');
      Add('`Outstanding Amount`     Double      NOT NULL Default 0,');
      Add('`Foreign Total Amount`           Double      NOT NULL Default 0,');
      Add('`Foreign Outstanding Amount`     Double      NOT NULL Default 0,');
      Add('`ForeignPayment`     Double      NOT NULL Default 0,');
      Add('`Payment`               Double      NOT NULL Default 0,');
      Add('`Within Terms`           Double      NOT NULL Default 0, ');
      Add('`1-7 Days`               Double      NOT NULL Default 0, ');
      Add('`7-14 Days`              Double      NOT NULL Default 0, ');
      Add('`14-21 Days`             Double      NOT NULL Default 0, ');
      Add('`>21 Days`               Double      NOT NULL Default 0, ');
      Add('`1-30 Days`              Double      NOT NULL Default 0, ');
      Add('`30-60 Days`             Double      NOT NULL Default 0, ');
      Add('`60-90 Days`             Double      NOT NULL Default 0, ');
      Add('`>90 Days`               Double      NOT NULL Default 0, ');
      Add('`SaleID`                 int(11) Default 0, ');
      Add('`PONumber`               VARCHAR(30), ');
      Add('`ClientID`               int(11) Default 0, ');
      Add('`ClassID`                int(11) Default 0, ');
      Add('`ClassName`              Varchar(255) Default NULL, ');
      Add('`Flag`                   Varchar(255) Default NULL, ');
      Add('`Comments`               Varchar(255) Default NULL, ');
      Add('`ConNote`                Varchar(255) Default NULL, ');
      Add('PRIMARY KEY  (`ID`)) ENGINE=MyISAM; ');
    end;
    //Data
    With TempList Do Begin
      Add(' INSERT HIGH_PRIORITY INTO ' + sParams.fsTablename +
        ' ( `DateFrom`,`DateTo`,' +
        '  `Transaction Date`,`Customer Name`,`JobName`,`ReceiptNo`,' +
        '  `Invoice Number`,`Type`,`Status`,`Transaction Due Date`,`Days Outstanding`,' +
        '  `Total Amount`,`Outstanding Amount`,' +
        '  `Foreign Total Amount`,`Foreign Outstanding Amount`, ForeignPayment,'+
        '  `Within Terms`,`1-7 Days`,`7-14 Days`,' +
        '  `14-21 Days`,`>21 Days`,`1-30 Days`,`30-60 Days`,`60-90 Days`,`>90 Days`,' +
        '  `SaleID`,PONumber , `ClientID`,`ClassID`,`ClassName`,`Flag`,comments,ConNote) ');
      Add(SQL);
    end;
 //   OptimiseInserts.InsertSelectToInsertValues(TempList.Text,TempList);
    BulkSQL.AddStrings(TempList);
    TempList.Clear;
    (*BulkSQL.Add('UPDate ' + fsTablename +      ' LEFT JOIN tblClass USING(ClassID) SET ' + fsTablename + '.ClassName=tblClass.ClassName;');*)
    tmptablename:= sParams.ReportClassname;
    BulkSQL.Add(SQLfortemptable('tblClass', 'ClassName','' , 'inner join '+sParams.fsTablename + ' T on  M.ClassID = T.ClassID', tmptablename,tmpfilename, GetSharedMyDacConnection));
    BulkSQL.Add('UPDate ' + sParams.fsTablename +      ' T LEFT JOIN '+tmptablename+' M  on T.ClassId = M.ClassID SET T.ClassName=M.ClassName;');


    BulkSQL.Add('UPDate ' + sParams.fsTablename +
      ' SET `Transaction Date`=NULL,`Transaction Due Date`=NULL WHERE `Customer Name` = "Balance Forward";');
    BulkSQL.add('Delete from ' +sParams.fsTablename +
      ' where '+
      'ifnull(`Total Amount`          ,0) = 0 AND ' +
      'ifnull(`Outstanding Amount`    ,0) = 0 AND ' +
      'ifnull(`Within Terms`          ,0) = 0 AND ' +
      'ifnull(`1-7 Days`              ,0) = 0 AND ' +
      'ifnull(`7-14 Days`             ,0) = 0 AND ' +
      'ifnull(`14-21 Days`            ,0) = 0 AND ' +
      'ifnull(`>21 Days`              ,0) = 0 AND ' +
      'ifnull(`1-30 Days`             ,0) = 0 AND ' +
      'ifnull(`30-60 Days`            ,0) = 0 AND ' +
      'ifnull(`60-90 Days`            ,0) = 0 AND ' +
      'ifnull(`>90 Days`              ,0) = 0 ;' );

    BulkSQl.add('update ' +sParams.fsTablename +' as tmp' +
        ' Set tmp.Payment =ifnull((Select Sum(ifnull(dl.payment,0)) ' +
                ' from tbldepositline  dl  ' +
                ' inner join tbldeposits d on d.paymentId = dl.paymentID   ' +
                ' where  dl.SaleID = tmp.SaleID and   dl.trntype =tmp.Type  and ifnull(d.Deleted,"F") = "F" ' +
                ' and d.Paymentdate <= ' +QuotedStr(FormatDateTime(MysqlDateFormat, sParams.Curdate))+'),0)' +' ; ');
    BulkSQl.add('update ' +sParams.fsTablename +' as tmp' +
        ' Set tmp.`Outstanding Amount` = `Total Amount`- Payment where not(tmp.Type like "OB_%" ) and not(tmp.Type like "Prepayment");');
    BulkSQL.add('drop table if exists ' + sParams.fsTempTblName+';');
    BulkSQL.add('Create table ' + sParams.fsTempTblName +
              ' SELECT ' +
              ' `ST`.`Type`, ' +
              ' Sum(`ST`.`Total Amount`) as `sumTotal Amount`, ' +
              ' Sum(`ST`.`Outstanding Amount`) as `sumOutstanding Amount`, ' +
              ' Sum(`ST`.`Payment`) as `sumPayment`, ' +
              ' Sum(`ST`.`Within Terms`) as `sumWithin Terms`, ' +
              ' Sum(`ST`.`1-7 Days`) as `sum1-7 Days` , ' +
              ' Sum(`ST`.`7-14 Days`) as `sum7-14 Days`, ' +
              ' Sum(`ST`.`14-21 Days`) as `sum14-21 Days`, ' +
              ' Sum(`ST`.`>21 Days`) as `sum>21 Days`, ' +
              ' Sum(`ST`.`1-30 Days`) as `sum1-30 Days`, ' +
              ' Sum(`ST`.`30-60 Days`) as `sum30-60 Days`, ' +
              ' Sum(`ST`.`60-90 Days`) as  `sum60-90 Days` , ' +
              ' Sum(`ST`.`>90 Days`) as `sum>90 Days` ' +
              ' FROM ' +
                sParams.fsTablename + ' as ST  where ST.Type in("Invoice" ,"Sales Order", "Refund") ' +
              ' and ST.`Customer Name` <>  "Balance Forward"  and not(ST.Type like "OB_%") group by ST.type'  );
    qryMyScript.SQL.Clear;
    qryMyScript.SQL.Text := BulkSQL.Text;
    BulkSQL.Clear;
    qryMyScript.Execute;
  finally
    FreeandNil(qryMyScript);
    FreeandNil(TempList);
    FreeandNil(BulkSQL);
    AppEnv.UtilsClient.DeleteServerFiles(replaceStr(tmpfilename, '.tmp' , '*.tmp'));
    CommonDbLib.DestroyUserTemporaryTable(tmptablename);
  end;
end;


end.
