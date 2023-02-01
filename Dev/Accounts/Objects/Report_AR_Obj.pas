unit Report_AR_Obj;

interface

uses ReportTransactionsTable;

type

  TAR_Report_Obj = class(TReportTransactionTableObj)
  Private
  Protected
  Public
    Procedure CleanRefresh_AR_Table(
      IgnoreDateRange: Boolean;
      const Point_In_Time: TDateTime;
      const ClassID: integer;
      const AllClasses: boolean;
      const ClientID: integer;
      const AgeByTransDate: boolean = false;
      const sTablename :String = '';
      const FCFields:String = '';
      CalenderMonthAgeing: boolean = false);
  end;

  (*Function Date_Thismonth(IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;
  Function Datefrom_1_30 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;
  Function Datefrom_30_60(IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;
  Function Datefrom_60_90(IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;

  Function Date_today (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;
  Function Date_1_7 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;
  Function Date_7_14 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;
  Function Date_14_21 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;

  Function Date_1_30 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;
  Function Date_30_60 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;
  Function Date_60_90 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;
  Function DateformatStr(const Userformat:Boolean):String;*)


implementation

uses ERPdbComponents, OptimiseInsertsObj , classes, sysutils, MySQLConst,datetimeutils,DateUtils,
  tcConst,forms, controls, TransactionsTable, AppEnvironmentVirtual , ReportLib;

{ TAR_Report_Obj }
(*Function DateformatStr(const Userformat:Boolean):String;
begin
  if  Userformat then REsult := shortdateformat else REsult := MysqlDateFormat;
end;
Function Date_Thismonth(IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;begin result := SysUtils.FormatDateTime(DateformatStr(Userformat),StartOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),0)));end;
Function Datefrom_1_30 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;begin result := SysUtils.FormatDateTime(DateformatStr(Userformat),StartOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),-1)));end;
Function Datefrom_30_60(IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;begin result := SysUtils.FormatDateTime(DateformatStr(Userformat),StartOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),-2))) end;
Function Datefrom_60_90(IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;begin result := SysUtils.FormatDateTime(DateformatStr(Userformat),StartOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),-3))) end;

Function Date_today (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;begin result := SysUtils.FormatDateTime(DateformatStr(Userformat),CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time));end;
Function Date_1_7 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;begin result := SysUtils.FormatDateTime(DateformatStr(Userformat),Incdays(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),-7));end;
Function Date_7_14 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;begin result := SysUtils.FormatDateTime(DateformatStr(Userformat),Incdays(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),-14));end;
Function Date_14_21 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;begin result := SysUtils.FormatDateTime(DateformatStr(Userformat),Incdays(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),-21));end;

Function Date_1_30 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;begin result := SysUtils.FormatDateTime(DateformatStr(Userformat),Incdays(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),-30));end;
Function Date_30_60 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;begin result := SysUtils.FormatDateTime(DateformatStr(Userformat),Incdays(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),-60));end;
Function Date_60_90 (IgnoreDateRange: Boolean; const Point_In_Time: TDateTime; const Userformat:Boolean):String;begin result := SysUtils.FormatDateTime(DateformatStr(Userformat),Incdays(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),-90));end;*)


procedure TAR_Report_Obj.CleanRefresh_AR_Table(IgnoreDateRange: Boolean; const Point_In_Time: TDateTime;const ClassID: integer; const AllClasses: boolean; const ClientID: integer;const AgeByTransDate: boolean; const sTablename, FCFields: String;CalenderMonthAgeing: boolean);
var
  Save_Cursor: TCursor;
  AgeFieldName: string;
  qryTemp: TERPQuery;
  I: Integer;
  TempStrList: TStringList;
  fsTablename :String;
  SevenDays, FourteenDays, TwentyOneDays, ThirtyDays, SixtyDays, NintyDays: string;

  procedure Insert_AR_DataCleanRefresh(const FromDate, Point_In_Time_SQL: TDateTime; Const ClientID: Integer; Const AgeFieldName: String; Const fsTablename: String);
  Var
    TempList: TStringList;
    OptimiseInserts: TOptimiseInserts;
  const
    DiffIncStr = '((Sum(DebitsInc)-Sum(CreditsInc)) + IF(Sum(DebitsInc)-Sum(CreditsInc) > 0, 0.00001, -0.00001))';
    function CreditDebitDiffSQL:String ;
    begin
      result := 'IF(Abs(' + DiffIncStr + ') > 0.009, Round(' + DiffIncStr + ',' + intTostr(fTotalsRoundPlaces)+'),0.000)';
    end;
  begin
    OptimiseInserts := TOptimiseInserts.Create;
    TempList := TStringList.Create;
    try
      with TempList do begin
      {
      When related customers invoices are paid by the master company
      tblSales.clientId -> ChildclientId
      tbldeposits.cusId -> MasterClienId
      }
        Add('INSERT HIGH_PRIORITY INTO ' + fstablename +
          ' (Details,TransID,PO_Number, CustomerName,Type,SaleDate,DueDate,InvoiceNumber,Name,TransactionName,OriginalAmount,AmountDue,' +
          'Current,`1-7Days`,`7-14Days`,`14-21Days`,`>21Days`,`1-30Days`,`30-60Days`,`60-90Days`,`>90Days`,SaleID,ClientID,' +
          'ARNotes,ClassID,AccountName');
        if FCFields <> '' then Add(',' + FCfields);
        Add(')');
        Add('SELECT ');
        Add('2 as Details, ');
        Add('TRANS.TransID,S.PONumber,  ');
        Add('If(ifnull(tblClients.ParentRelatedClientID,0)=0, ');
        Add('CONCAT_WS(" ", If(InStr(TRANS.ClientName,"^") -1 >0,Left(TRANS.ClientName,InStr(TRANS.ClientName,"^")-1),TRANS.ClientName),IF(char_length(tblClients.JobName)>0, Concat("(",tblClients.JobName,")"),"")), ');
        Add('CONCAT_WS(" ", If(InStr(C2.Company,"^") -1 >0,Left(C2.Company,InStr(C2.Company,"^")-1),C2.Company),IF(char_length(C2.JobName)>0, Concat("(",C2.JobName,")"),""))) as CustomerName, ');
        Add('TRANS.Type as Type, ');
        Add('TRANS.Date as SaleDate, ');
        Add('DueDate as DueDate, ');
        Add('InvoiceDocNumber as "Invoice Number", ');
        Add('If(ifnull(tblClients.ParentRelatedClientID,0)=0, ');
        Add('CONCAT_WS(" ", If(InStr(TRANS.ClientName,"^") -1 >0,Left(TRANS.ClientName,InStr(TRANS.ClientName,"^")-1),TRANS.ClientName),IF(char_length(tblClients.JobName)>0, Concat("(",tblClients.JobName,")"),"")), ');
        Add('CONCAT_WS(" ", If(InStr(C2.Company,"^") -1 >0,Left(C2.Company,InStr(C2.Company,"^")-1),C2.Company),IF(char_length(C2.JobName)>0, Concat("(",C2.JobName,")"),""))) as Name, ');
        Add('CONCAT_WS(" ", If(InStr(TRANS.ClientName,"^") -1 >0,Left(TRANS.ClientName,InStr(TRANS.ClientName,"^")-1),TRANS.ClientName),IF(char_length(tblClients.JobName)>0, Concat("(",tblClients.JobName,")"),"")) as TransactionName, ');
        Add('IfNull(TotalAmountInc,0) AS "Original Amount", ');
        Add(CreditDebitDiffSQL + ' AS "Amount Due", ');
        if CalenderMonthAgeing then begin
            Add('if('+AgeFieldName+' is null or  '+AgeFieldName+' >= "'+Date_Thismonth(IgnoreDateRange,Point_In_Time,False)+ '",'+ CreditDebitDiffSQL+',0.00) as "Within Terms", ');
            Add('0.00 as "1-7 Days", ');
            Add('0.00 as "7-14 Days", ');
            Add('0.00 as "14-21 Days", ');
            Add('0.00 as ">21 Days", ');
            Add('if('+AgeFieldName+' < "'+Date_Thismonth (IgnoreDateRange,Point_In_Time,False) + '" and '+AgeFieldName+' >= "'+Datefrom_1_30 (IgnoreDateRange,Point_In_Time,False)+'",'+ CreditDebitDiffSQL+',0.00) as "1-30 Days", ');
            Add('if('+AgeFieldName+' < "'+Datefrom_1_30  (IgnoreDateRange,Point_In_Time,False) + '" and '+AgeFieldName+' >= "'+Datefrom_30_60(IgnoreDateRange,Point_In_Time,False)+'",'+ CreditDebitDiffSQL+',0.00) as "30-60 Days", ');
            Add('if('+AgeFieldName+' < "'+Datefrom_30_60 (IgnoreDateRange,Point_In_Time,False) + '" and '+AgeFieldName+' >= "'+Datefrom_60_90(IgnoreDateRange,Point_In_Time,False)+'",'+ CreditDebitDiffSQL+',0.00) as "60-90 Days", ');
            Add('if('+AgeFieldName+' < "'+Datefrom_60_90 (IgnoreDateRange,Point_In_Time,False)+ '" ,'+ CreditDebitDiffSQL+',0.00) as ">90 Days", ');
        end else begin
            Add('if('+AgeFieldName+' is null or  '+AgeFieldName+' >= "'+Date_today   (IgnoreDateRange,Point_In_Time,False)+ '",'+ CreditDebitDiffSQL+',0.00) as "Within Terms", ');
            Add('if('+AgeFieldName+' < "'+Date_today    (IgnoreDateRange,Point_In_Time,False) + '" and '+AgeFieldName+' >="'+Date_1_7 (IgnoreDateRange,Point_In_Time,False)+'",'+ CreditDebitDiffSQL+',0.00) as "1-7 Days", ');
            Add('if('+AgeFieldName+' < "'+Date_1_7      (IgnoreDateRange,Point_In_Time,False) + '" and '+AgeFieldName+' >="'+Date_7_14 (IgnoreDateRange,Point_In_Time,False)+'",'+ CreditDebitDiffSQL+',0.00) as "7-14 Days", ');
            Add('if('+AgeFieldName+' < "'+Date_7_14     (IgnoreDateRange,Point_In_Time,False) + '" and '+AgeFieldName+' >="'+Date_14_21 (IgnoreDateRange,Point_In_Time,False)+'",'+ CreditDebitDiffSQL+',0.00) as "14-21 Days", ');
            Add('if('+AgeFieldName+' < "'+Date_14_21     (IgnoreDateRange,Point_In_Time,False) + '" ,'+ CreditDebitDiffSQL+',0.00) as ">21 Days", ');

            Add('if('+AgeFieldName+' < "'+Date_today    (IgnoreDateRange,Point_In_Time,False) + '" and '+AgeFieldName+' >="'+Date_1_30 (IgnoreDateRange,Point_In_Time,False)+'",'+ CreditDebitDiffSQL+',0.00) as "1-30 Days", ');
            Add('if('+AgeFieldName+' < "'+Date_1_30     (IgnoreDateRange,Point_In_Time,False) + '" and '+AgeFieldName+' >="'+Date_30_60 (IgnoreDateRange,Point_In_Time,False)+'",'+ CreditDebitDiffSQL+',0.00) as "30-60 Days", ');
            Add('if('+AgeFieldName+' < "'+Date_30_60    (IgnoreDateRange,Point_In_Time,False) + '" and '+AgeFieldName+' >="'+Date_60_90 (IgnoreDateRange,Point_In_Time,False)+'",'+ CreditDebitDiffSQL+',0.00) as "60-90 Days", ');
            Add('if('+AgeFieldName+' < "'+Date_60_90    (IgnoreDateRange,Point_In_Time,False) + '" ,'+ CreditDebitDiffSQL+',0.00) as ">90 Days", ');

        end;
        Add('If(TRANS.PrepaymentID<>0,TRANS.PrepaymentID,If(TRANS.SaleID=0,TRANS.PaymentID,TRANS.SaleID)) as SaleID,  ');
        Add('If(ifnull(tblClients.ParentRelatedClientID,0)=0,ifnull(rc.childClientID, Trans.ClientID),tblClients.ParentRelatedClientID) as ClientID, ');
        Add('ARNotes,TRANS.ClassID,TRANS.AccountName');
        if FCFields <> '' then Add(',' + StringReplace('TRANS.' + FCFields , ',' , ',TRANS.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions TRANS ');
        Add('LEFT JOIN tblSales S ON TRANS.SaleID = S.SaleID ');
        Add('LEFT JOIN tblClients ON S.ClientID =  tblClients.ClientID ');
        Add('LEFT JOIN tblclienttype CT ON CT.ClientTypeID = tblClients.ClientTypeID  ');
        Add('LEFT JOIN tblClients C2 ON C2.ClientID = ifnull(tblClients.ParentRelatedClientID,0) ');
        Add('LEFT JOIN tblRelatedClients rc ON rc.childClientID = Trans.ClientID');
        Add('Where TRANS.AccountType = "AR" AND TRANS.Type <> "'+CUSTOMER_PREPAYMENT+'" ');
(*        if CalenderMonthAgeing then
          Add('AND (TRANS.TYPE = "Invoice" OR TRANS.TYPE = "Refund") or (TRANS.Date Between ' + QuotedStr(FormatDateTime(MysqlDateFormat, FromDate)) + ' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat, Point_In_Time_SQL)) + ') ')
        else
          Add('AND TRANS.Date Between ' + QuotedStr(FormatDateTime(MysqlDateFormat, FromDate)) + ' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat, Point_In_Time_SQL)) + ' ');*)
          Add('AND TRANS.Date Between ' + QuotedStr(FormatDateTime(MysqlDateFormat, FromDate)) + ' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat, Point_In_Time_SQL)) + ' ');
        if (ClientID<>-1) then begin
          //Add('AND tblClients.ClientID = '+IntToStr(ClientID)+' ');
          Add('AND ifnull(rc.masterClientID, Trans.ClientID) = '+IntToStr(ClientID)+' ');

        end;
        Add('AND (TRANS.TYPE = "Invoice" OR TRANS.TYPE = "Refund" OR TRANS.TYPE = "Customer Payment") ');
        if not AllClasses then begin
          Add('AND TRANS.ClassID=' + IntToStr(ClassID) + ' ');
        end;
        //Add('Group By ClientID,SaleID; ');
        Add('Group By ifnull(rc.masterClientID, Trans.ClientID),SaleID; ');


      end;
       if (ClientID<>-1) then OptimiseInserts.InsertSelectToInsertValues(TempList.Text,TempList);
      BulkSQL.AddStrings(TempList);

      TempList.Clear;
      with TempList do begin
                Add('INSERT HIGH_PRIORITY INTO ' + fstablename +
          ' (Details,TransID,PO_Number, CustomerName,Type,SaleDate,DueDate,InvoiceNumber,Name,TransactionName,OriginalAmount,AmountDue,' +
          'Current,`1-7Days`,`7-14Days`,`14-21Days`,`>21Days`,`1-30Days`,`30-60Days`,`60-90Days`,`>90Days`,SaleID,ClientID,' +
          'ARNotes,ClassID,AccountName'
          );

        if FCFields <> '' then Add(',' + FCfields);
        Add(')');
        Add('SELECT ');
        Add('2 as Details, ');
        //Add('TRANS.TransID,S.PONumber,  ');
        Add('TRANS.TransID,null  as PONumber,  ');
        Add('If(ifnull(tblClients.ParentRelatedClientID,0)=0, ');
        Add('CONCAT_WS(" ", If(InStr(TRANS.ClientName,"^") -1 >0,Left(TRANS.ClientName,InStr(TRANS.ClientName,"^")-1),TRANS.ClientName),IF(char_length(tblClients.JobName)>0, Concat("(",tblClients.JobName,")"),"")), ');
        Add('CONCAT_WS(" ", If(InStr(C2.Company,"^") -1 >0,Left(C2.Company,InStr(C2.Company,"^")-1),C2.Company),IF(char_length(C2.JobName)>0, Concat("(",C2.JobName,")"),""))) as CustomerName, ');
        Add('TRANS.Type as Type, ');
        Add('TRANS.Date as SaleDate, ');
        Add('JE.TransactionDate as DueDate, ');
        Add('"" as "Invoice Number", ');
        Add('If(ifnull(tblClients.ParentRelatedClientID,0)=0, ');
        Add('CONCAT_WS(" ", If(InStr(TRANS.ClientName,"^") -1 >0,Left(TRANS.ClientName,InStr(TRANS.ClientName,"^")-1),TRANS.ClientName),IF(char_length(tblClients.JobName)>0, Concat("(",tblClients.JobName,")"),"")), ');
        Add('CONCAT_WS(" ", If(InStr(C2.Company,"^") -1 >0,Left(C2.Company,InStr(C2.Company,"^")-1),C2.Company),IF(char_length(C2.JobName)>0, Concat("(",C2.JobName,")"),""))) as Name, ');
        Add('CONCAT_WS(" ", If(InStr(TRANS.ClientName,"^") -1 >0,Left(TRANS.ClientName,InStr(TRANS.ClientName,"^")-1),TRANS.ClientName),IF(char_length(tblClients.JobName)>0, Concat("(",tblClients.JobName,")"),"")) as TransactionName, ');
        Add('JE.Amount AS "Original Amount", ');
        Add(CreditDebitDiffSQL + ' AS "Amount Due", ');
        Add(CreditDebitDiffSQL + ' AS "Within Terms", ');
        Add('0.00 AS "1-7 Days",');
        Add('0.00 AS "7-14 Days",');
        Add('0.00 AS "14-21 Days",');
        Add('0.00 AS ">21 Days",');
        Add('0.00 AS "1-30 Days",');
        Add('0.00 AS "30-60 Days",');
        Add('0.00 AS "60-90 Days",');
        Add('0.00 AS ">90 Days",');
        Add('If(TRANS.PrepaymentID<>0,TRANS.PrepaymentID,If(TRANS.SaleID=0,TRANS.PaymentID,TRANS.SaleID)) as SaleID,  ');
        Add('If(ifnull(tblClients.ParentRelatedClientID,0)=0,ifnull(rc.childClientID, Trans.ClientID),tblClients.ParentRelatedClientID) as ClientID, ');
        Add('"",TRANS.ClassID,TRANS.AccountName');
        if FCFields <> '' then Add(',' + StringReplace('TRANS.' + FCFields , ',' , ',TRANS.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions TRANS ');
        //Add('LEFT JOIN tblSales S ON TRANS.SaleID = S.SaleID ');
        Add('LEFT JOIN tblgeneraljournal JE ON TRANS.SaleID = JE.GJID ');
        Add('LEFT JOIN tblClients ON Trans.ClientID =  tblClients.ClientID ');
        Add('LEFT JOIN tblclienttype CT ON CT.ClientTypeID = tblClients.ClientTypeID  ');
        Add('LEFT JOIN tblClients C2 ON C2.ClientID = ifnull(tblClients.ParentRelatedClientID,0) ');
        Add('LEFT JOIN tblRelatedClients rc ON rc.childClientID = Trans.ClientID');
        Add('Where TRANS.AccountType = "AR" AND TRANS.Type <> "'+CUSTOMER_PREPAYMENT+'" ');
        if not CalenderMonthAgeing then
          Add('AND TRANS.Date Between ' + QuotedStr(FormatDateTime(MysqlDateFormat, FromDate)) + ' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat, Point_In_Time_SQL)) + ' ');
        if (ClientID<>-1) then begin
          Add('AND ifnull(rc.childClientID, Trans.ClientID) = '+IntToStr(ClientID)+' ');
        end;
        Add('AND (TRANS.Type = "Journal Entry") ');
        if not AllClasses then begin
          Add('AND TRANS.ClassID=' + IntToStr(ClassID) + ' ');
        end;
        Add('Group By ifnull(rc.childClientID, Trans.ClientID) , TRANS.Accountname; ');

        Add('UPDATE ' + fstablename  + ' SET Current = AmountDue WHERE TYPE = "Journal Entry";');
      end;
      if (ClientID<>-1) then OptimiseInserts.InsertSelectToInsertValues(TempList.Text,TempList);
      BulkSQL.AddStrings(TempList);

      TempList.Clear;
      with TempList do begin
        Add('INSERT HIGH_PRIORITY INTO ' + fstablename +
          ' (Details,TransID,CustomerName,Type,SaleDate,DueDate,InvoiceNumber,Name,TransactionName,OriginalAmount,AmountDue,' +
          'Current,`1-7Days`,`7-14Days`,`14-21Days`,`>21Days`,`1-30Days`,`30-60Days`,`60-90Days`,`>90Days`,SaleID,ClientID,' +
          'ARNotes,ClassID,AccountName'
          );
        if FCFields <> '' then Add(',' + FCfields);
        Add(')');
        Add('SELECT ');
        Add('2 as Details, ');
        Add('TRANS.TransID, ');
        Add('If(ifnull(tblClients.ParentRelatedClientID,0)=0, ');
        Add('CONCAT_WS(" ", If(InStr(TRANS.ClientName,"^") -1 >0,Left(TRANS.ClientName,InStr(TRANS.ClientName,"^")-1),TRANS.ClientName),IF(char_length(tblClients.JobName)>0, Concat("(",tblClients.JobName,")"),"")), ');
        Add('CONCAT_WS(" ", If(InStr(C2.Company,"^") -1 >0,Left(C2.Company,InStr(C2.Company,"^")-1),C2.Company),IF(char_length(C2.JobName)>0, Concat("(",C2.JobName,")"),""))) as CustomerName, ');
        Add('"'+CUSTOMER_PREPAYMENT+'" AS "Type", ');
        Add('TRANS.Date as SaleDate, ');
        Add('Date as DueDate, ');
        Add('PaymentID as "Invoice Number", ');
        Add('If(ifnull(tblClients.ParentRelatedClientID,0)=0, ');
        Add('CONCAT_WS(" ", If(InStr(TRANS.ClientName,"^") -1 >0,Left(TRANS.ClientName,InStr(TRANS.ClientName,"^")-1),TRANS.ClientName),IF(char_length(tblClients.JobName)>0, Concat("(",tblClients.JobName,")"),"")), ');
        Add('CONCAT_WS(" ", If(InStr(C2.Company,"^") -1 >0,Left(C2.Company,InStr(C2.Company,"^")-1),C2.Company),IF(char_length(C2.JobName)>0, Concat("(",C2.JobName,")"),""))) as Name, ');
        Add('CONCAT_WS(" ", If(InStr(TRANS.ClientName,"^") -1 >0,Left(TRANS.ClientName,InStr(TRANS.ClientName,"^")-1),TRANS.ClientName),IF(char_length(tblClients.JobName)>0, Concat("(",tblClients.JobName,")"),"")) as TransactionName, ');
        Add('0.00 AS "Original Amount",');
        Add('Sum(DebitsInc-CreditsInc) AS "Amount Due",');
        Add('Sum(DebitsInc-CreditsInc) AS "Within Terms",');
        Add('0.00 AS "1-7 Days",');
        Add('0.00 AS "7-14 Days",');
        Add('0.00 AS "14-21 Days",');
        Add('0.00 AS ">21 Days",');
        Add('0.00 AS "1-30 Days",');
        Add('0.00 AS "30-60 Days",');
        Add('0.00 AS "60-90 Days",');
        Add('0.00 AS ">90 Days",');
        Add('TRANS.PrepaymentID as SaleID, ');
        Add('If(ifnull(tblClients.ParentRelatedClientID,0)=0,ifnull(rc.childClientID, Trans.ClientID),tblClients.ParentRelatedClientID) as ClientID, ');
        Add('PP.Notes as ARNotes,TRANS.ClassID,TRANS.AccountName');
        if FCFields <> '' then Add(',' + StringReplace('TRANS.' + FCFields , ',' , ',TRANS.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions TRANS ');
        Add('INNER JOIN tblPrepayments PP ON PP.PrepaymentID = TRANS.PrepaymentID ');
        Add('LEFT JOIN tblClients ON TRANS.ClientID =  tblClients.ClientID ');
        Add('LEFT JOIN tblclienttype CT ON CT.ClientTypeID = tblClients.ClientTypeID  ');
        Add('LEFT JOIN tblClients C2 ON C2.ClientID = ifnull(tblClients.ParentRelatedClientID,0) ');
        Add('LEFT JOIN tblRelatedClients rc ON rc.childClientID = Trans.ClientID');
        Add('Where TRANS.AccountID = ' + IntToStr(GetPrepaymentAccountID('C'))+
          ' AND ((TRANS.Type = "'+CUSTOMER_PREPAYMENT+'") OR (TRANS.Type = "Customer Payment")) ');
        if not CalenderMonthAgeing then
          Add('AND TRANS.Date Between ' + QuotedStr(FormatDateTime(MysqlDateFormat, FromDate)) + ' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat, Point_In_Time_SQL)) + ' ');
        if (ClientID<>-1) then begin
          Add('AND ifnull(rc.childClientID, Trans.ClientID) = '+IntToStr(ClientID)+' ');
        end;
        if not AllClasses then begin
          Add('AND TRANS.ClassID=' + IntToStr(ClassID) + ' ');
        end;
        Add('group by ClientId, TRANS.PrepaymentId;');
      end;

      if (ClientID<>-1) then OptimiseInserts.InsertSelectToInsertValues(TempList.Text,TempList);
      BulkSQL.AddStrings(TempList);
      BulkSQL.Add('update   ' + fstablename + ' T inner join tblclients C on C.clientId = T.ClientID ' +
              ' Set T.CUSTFLD1 = C.CUSTFLD1,'+
              'T.CUSTFLD2 = C.CUSTFLD2,'+
              'T.CUSTFLD3 = C.CUSTFLD3,'+
              'T.CUSTFLD4 = C.CUSTFLD4,'+
              'T.CUSTFLD5 = C.CUSTFLD5,'+
              'T.CUSTFLD6 = C.CUSTFLD6,'+
              'T.CUSTFLD7 = C.CUSTFLD7,'+
              'T.CUSTFLD8= C.CUSTFLD8,'+
              'T.CUSTFLD9= C.CUSTFLD9,'+
              'T.CUSTFLD10= C.CUSTFLD10,'+
              'T.CUSTFLD11= C.CUSTFLD11,'+
              'T.CUSTFLD12= C.CUSTFLD12,'+
              'T.CUSTFLD13= C.CUSTFLD13,'+
              'T.CUSTFLD14= C.CUSTFLD14,'+
              'T.CUSTFLD15= C.CUSTFLD15,'+
              'T.`Phone`= C.Phone,'+
              'T.`FaxNumber`= C.FaxNumber,'+
              'T.`Mobile`= C.Mobile,'+
              'T.`AltPhone`= C.AltPhone,'+
              'T.StopCredit = C.StopCredit,'+
              'T.ParentClientID  = C.ParentClientID;')
    Finally
      FreeAndNil(TempList);
      FreeAndNil(OptimiseInserts);
    end;
  end;

begin
  fDoingRefresh:= true;
  try
    if AgeByTransDate then
      AgeFieldName := 'TRANS.Date'
    else
      AgeFieldName := 'DueDate';

    SevenDays := '7';
    FourteenDays := '14';
    TwentyOneDays := '21';
    ThirtyDays := '30';
    SixtyDays := '60';
    NintyDays := '90';

    qryTemp := TERPQuery.Create(nil);
    qryTemp.Options.FlatBuffers := True;
    TempStrList := TStringList.Create;
    Save_Cursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      with BulkSQL do begin
        if sTablename = '' then
          fstablename := 'tmp_tblaccountsreceivable' + GetTemporaryTableNameSuffix
        else
          fstablename := sTablename;

        Clear;
        Add('Truncate  ' + fstablename + ';');
        Add('ALTER TABLE ' + fstablename +' CHANGE `ID` `ID` INT(11) NOT NULL;');
        Add('ALTER TABLE ' + fstablename +' ENGINE = InnoDB;');
        Add('ALTER TABLE ' + fstablename +' ENGINE = MyISAM;');
        Add('ALTER TABLE ' + fstablename +' CHANGE `ID` `ID` INT(11)   NOT NULL AUTO_INCREMENT;');

        TempStrList.Clear;
        If (ClientID<>-1) then begin
          TempStrList.Add(IntToStr(ClientID));

          qryTemp.Connection := TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
          qryTemp.SQL.Clear;
          qryTemp.SQL.Add('SELECT ClientID FROM tblClients WHERE ifnull(ParentRelatedClientID,0) = '
                                 + IntToStr(ClientID) + ' AND ifnull(ParentRelatedClientID,0) <> 0;');
          qryTemp.SQL.text := ChangeQuery(qryTemp.SQL.text);
          qryTemp.Open;
        end;

        If (qryTemp.RecordCount>0) then Begin
          TempStrList.Add(IntToStr((qryTemp.FieldByName('ClientID').AsInteger)));
        end;

        If TempStrList.Count=0 then Insert_AR_DataCleanRefresh(0, Point_In_Time,-1,AgeFieldName,fsTablename);

        For I := 0 to TempStrList.Count-1 do Begin
          Insert_AR_DataCleanRefresh(0, Point_In_Time,StrToIntDef(TempStrList[I],0),AgeFieldName,fsTablename);
        end;
        Add('delete from ' + fstablename + ' where ifnull(`Amount Due`,0)=0;');

        (*Add('DELETE FROM ' + fstablename);
        Add('WHERE ID IN');
        Add('(');
        Add('  SELECT I.ID FROM');
        Add('  (');
        Add('    SELECT I.ID, I.InvoiceNumber, I.AmountDue FROM ' + fstablename + ' I');
        Add('      WHERE I.InvoiceNumber IS NOT NULL AND I.InvoiceNumber <> ''''');
        Add('        AND I.Type = ''Invoice''');
        Add('        AND I.AmountDue <> 0.0');
        Add('  ) I');
        Add('  LEFT JOIN');
        Add('  (');
        Add('    SELECT P.ID, P.InvoiceNumber, P.AmountDue FROM ' + fstablename + ' P');
        Add('    WHERE P.InvoiceNumber IS NOT NULL AND P.InvoiceNumber <> ''''');
        Add('      AND P.Type = ''Customer Payment''');
        Add('      AND P.AmountDue <> 0.0');
        Add('  ) P ON I.InvoiceNumber = P.InvoiceNumber');
        Add('  WHERE I.AmountDue = -P.AmountDue');
        Add(');');*)

        Add('UPDATE ' + fstablename + ' ');
        Add('INNER JOIN tblClients Using(ClientID) ');
        Add('INNER JOIN tblclienttype Using(ClientTypeID) ');
        Add('SET CustomerType=tblclienttype.TypeName ');
        Add('WHERE tblClients.ClientTypeID<>0 AND Not IsNull(tblClients.ClientTypeID);');

        Add('UPDATE ' + fstablename + ' T ');
        Add('INNER JOIN tblsaleslines SL on T.saleId = SL.SaleId  ');
        Add('INNER JOIN tblparts P on p.partsid = SL.productId and P.partname = ' +Quotedstr(tcconst.PART_OVERDUE_SURCH));
        Add('SET t.OverdueSurcharge = SL.linepriceinc, T.OverdueSurchargeDesc = SL.Product_Description ');
        Add('WHERE T.type <> ' +Quotedstr(JOURNAL_ENTRY) + ' and T.type <> ' +Quotedstr(CUSTOMER_PREPAYMENT) +' and T.type <> ' + quotedstr(RefundType) +';');

        Add('UPDATE ' + fstablename + ' T inner join tblsales S on T.saleId = S.saleId set T.ConNote = S.ConNote;');


       end;

      ExecuteBulkSQL;
    finally
      FreeAndNil(TempStrList);
      FreeAndNil(qryTemp);
      Screen.Cursor := Save_Cursor;
      Application.ProcessMessages
    end;
  finally
    fDoingRefresh:= false;
  end;
end;

end.
