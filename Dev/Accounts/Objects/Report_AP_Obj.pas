unit Report_AP_Obj;

interface

uses ReportTransactionsTable;

type
  TAP_Report_Obj = class(TReportTransactionTableObj)
  Private
  Protected
  Public
    Procedure CleanRefresh_AP_Table(IgnoreDateRange:Boolean; const Point_In_Time: TDateTime; const ClassID: integer; const AllClasses: boolean;
      const ClientID: integer; const AgeByTransDate: boolean = false; const sTablename :String = '';
      const FCFields:String = ''; CalenderMonthAgeing: boolean = false);
  end;


implementation

uses
  controls, forms, MySQLConst,datetimeutils,DateUtils,TransactionsTable,
  sysutils, UtilsLib , ReportLib;

{ TAP_Report_Obj }


{ TAP_Report_Obj }

procedure TAP_Report_Obj.CleanRefresh_AP_Table(IgnoreDateRange: Boolean;
  const Point_In_Time: TDateTime; const ClassID: integer;
  const AllClasses: boolean; const ClientID: integer;
  const AgeByTransDate: boolean; const sTablename, FCFields: String;
  CalenderMonthAgeing: boolean);
var
//  ProgressDialog: TProgressDialog;
  Save_Cursor: TCursor;
  AgeFieldName: string;
  fsTablename :String;
const
  DiffIncStr = '((Sum(CreditsInc)-Sum(DebitsInc)) + IF(Sum(CreditsInc)-Sum(DebitsInc) > 0, 0.00001, -0.00001))';
  function CreditDebitDiffSQL :String ;
  begin
    result := 'IF(Abs(' + DiffIncStr + ') > 0.009, Round(' + DiffIncStr + ',' + intTostr(fTotalsRoundPlaces) +'),0.000)';
  end;
begin
  fDoingRefresh:= true;
  try
    if AgeByTransDate then
      AgeFieldName := 'TRANS.Date'
    else
      AgeFieldName := 'DueDate';
//    ProgressDialog := TProgressDialog.Create(nil);
    if IsGui then begin
      Save_Cursor := Screen.Cursor;
      Screen.Cursor := crHourGlass;
    end;
    try
      with BulkSQL do begin

        if sTablename = '' then
          fstablename := 'tmp_tblaccountspayable'
        else
          fstablename := sTablename;

        Clear;
        Add('Truncate ' + fstablename + ';');

        Add('INSERT HIGH_PRIORITY INTO ' + fstablename + ' (SeqNo, TransID,SupplierName,Type,OrderDate,DueDate,PONumber,Name,OriginalAmount,AmountDue,Current,30Days,60Days,90Days,120Days,PurchaseOrderID,Details,ClientID, InvoiceNumber,InvoiceDate,AccountName,APNotes, foreignexchangecode,ForeignExchangeRate ');
        if FCFields <> '' then Add(',' + FCFields);
        Add(')');
        Add('SELECT 1, TRANS.TransID,TRANS.ClientName as SupplierName, ');
        Add('TRANS.Type as Type, ');
//        Add('PO.OrderDate as OrderDate, ');
        { NOTE: there is a left join to PO, so use trans date not PO OrderDate
          ... also need this so AP mactches with Balance sheet AP when "Age By Transaction Date" checked !!! }
        Add('TRANS.Date as OrderDate, ');
        Add('PO.DueDate as DueDate, ');
        Add('PurchaseOrderNumber as "PO Number", ');
        Add('TRANS.ClientName as Name, ');
        Add('IF(IsCredit ="T",IFNULL(-TotalAmountInc,0.00),IFNULL(TotalAmountInc,0.00)) AS "Original Amount", ');
        Add(CreditDebitDiffSQL + ' AS "Amount Due", ');
(*
        Add('If((TO_DAYS(' + QuotedStr(FormatDateTime(MysqlDateFormat, CurDateifIgnoredateRange(IgnoreDateRange,Point_In_time))) + ') - TO_DAYS(' + AgeFieldName +
          '))<=0,' + CreditDebitDiffSQL + ',0.00) AS "Within_Terms", ');
        Add('If((TO_DAYS(' + QuotedStr(FormatDateTime(MysqlDateFormat, CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time))) + ') - TO_DAYS(' +
          AgeFieldName + '))>0 And (TO_DAYS(' + QuotedStr(FormatDateTime(MysqlDateFormat, CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time))) + ') - TO_DAYS(' + AgeFieldName +
          '))<=30,' + CreditDebitDiffSQL + ',0.00) AS "1-30 Days", ');
        Add('If((TO_DAYS(' + QuotedStr(FormatDateTime(MysqlDateFormat, CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time))) + ') - TO_DAYS(' + AgeFieldName + '))>30 And (TO_DAYS(' +
          QuotedStr(FormatDateTime(MysqlDateFormat, CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time))) + ') - TO_DAYS(' + AgeFieldName + '))<=60,' + CreditDebitDiffSQL + ',0.00) AS "30-60 Days", ');
        Add('If((TO_DAYS(' + QuotedStr(FormatDateTime(MysqlDateFormat, CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time))) + ') - TO_DAYS(' + AgeFieldName + '))>60 And (TO_DAYS(' +
          QuotedStr(FormatDateTime(MysqlDateFormat, CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time))) + ') - TO_DAYS(' +
          AgeFieldName + '))<=90,' + CreditDebitDiffSQL + ',0.00) AS "60-90 Days", ');
        Add('If((TO_DAYS(' + QuotedStr(FormatDateTime(MysqlDateFormat, CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time))) +
          ') - TO_DAYS(' + AgeFieldName + '))>90,' + CreditDebitDiffSQL + ',0.00) AS ">90 Days", ');
*)
{        if CalenderMonthAgeing then begin
          (*if AgeByTransDate then begin
            Add('if(TRANS.Date >= "'+
              FormatDateTime(MysqlDateFormat,StartOfTheMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time)))+
              '",'+ CreditDebitDiffSQL+',0.00) as "Within Terms", ');
            Add('if(TRANS.Date between "'+
              FormatDateTime(MysqlDateFormat,StartOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),-1)))+
              '" and "'+FormatDateTime(MysqlDateFormat,EndOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),-1)))+'",'+
              CreditDebitDiffSQL+',0.00) as "1-30 Days", ');
            Add('if(TRANS.Date between "'+
              FormatDateTime(MysqlDateFormat,StartOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),-2)))+
              '" and "'+FormatDateTime(MysqlDateFormat,EndOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),-2)))+'",'+
              CreditDebitDiffSQL+',0.00) as "30-60 Days", ');
            Add('if(TRANS.Date between "'+
              FormatDateTime(MysqlDateFormat,StartOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),-3)))+
              '" and "'+FormatDateTime(MysqlDateFormat,EndOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),-3)))+'",'+
              CreditDebitDiffSQL+',0.00) as "60-90 Days", ');
            Add('if(TRANS.Date < "'+
              FormatDateTime(MysqlDateFormat,StartOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),-3)))+
              '",'+ CreditDebitDiffSQL+',0.00) as ">90 Days", ');
          end
          else begin
            // age by due date
            Add('if(DueDate <= "'+
              FormatDateTime(MysqlDateFormat,EndOfTheMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time)))+
              '",'+ CreditDebitDiffSQL+',0.00) as "Within Terms", ');
            Add('if(DueDate between "'+
              FormatDateTime(MysqlDateFormat,StartOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),1)))+
              '" and "'+FormatDateTime(MysqlDateFormat,EndOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),1)))+'",'+
              CreditDebitDiffSQL+',0.00) as "1-30 Days", ');
            Add('if(DueDate between "'+
              FormatDateTime(MysqlDateFormat,StartOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),2)))+
              '" and "'+FormatDateTime(MysqlDateFormat,EndOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),2)))+'",'+
              CreditDebitDiffSQL+',0.00) as "30-60 Days", ');
            Add('if(DueDate between "'+
              FormatDateTime(MysqlDateFormat,StartOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),3)))+
              '" and "'+FormatDateTime(MysqlDateFormat,EndOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),3)))+'",'+
              CreditDebitDiffSQL+',0.00) as "60-90 Days", ');
            Add('if(DueDate > "'+
              FormatDateTime(MysqlDateFormat,StartOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),3)))+
              '",'+ CreditDebitDiffSQL+',0.00) as ">90 Days", ');
          end;*)

            Add('if(' + AgeFieldName +' < "'+
              FormatDateTime(MysqlDateFormat,StartOfTheMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time)))+
              '",'+ CreditDebitDiffSQL+',0.00) as "Within Terms", ');
            Add('if(' + AgeFieldName +' between "'+
              FormatDateTime(MysqlDateFormat,StartOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),1)))+
              '" and "'+FormatDateTime(MysqlDateFormat,EndOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),1)))+'",'+
              CreditDebitDiffSQL+',0.00) as "1-30 Days", ');
            Add('if(' + AgeFieldName +' between "'+
              FormatDateTime(MysqlDateFormat,StartOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),2)))+
              '" and "'+FormatDateTime(MysqlDateFormat,EndOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),2)))+'",'+
              CreditDebitDiffSQL+',0.00) as "30-60 Days", ');
            Add('if(' + AgeFieldName +' between "'+
              FormatDateTime(MysqlDateFormat,StartOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),3)))+
              '" and "'+FormatDateTime(MysqlDateFormat,EndOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),3)))+'",'+
              CreditDebitDiffSQL+',0.00) as "60-90 Days", ');
            Add('if(' + AgeFieldName +' > "'+
              FormatDateTime(MysqlDateFormat,StartOfTheMonth(IncMonth(CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time),3)))+
              '",'+ CreditDebitDiffSQL+',0.00) as ">90 Days", ');

        end
        else begin
          Add('If((TO_DAYS(' + QuotedStr(FormatDateTime(MysqlDateFormat, CurDateifIgnoredateRange(IgnoreDateRange,Point_In_time))) + ') - TO_DAYS(' + AgeFieldName +
            '))<=0,' + CreditDebitDiffSQL + ',0.00) AS "Within_Terms", ');
          Add('If((TO_DAYS(' + QuotedStr(FormatDateTime(MysqlDateFormat, CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time))) + ') - TO_DAYS(' +
            AgeFieldName + '))>0 And (TO_DAYS(' + QuotedStr(FormatDateTime(MysqlDateFormat, CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time))) + ') - TO_DAYS(' + AgeFieldName +
            '))<=30,' + CreditDebitDiffSQL + ',0.00) AS "1-30 Days", ');
          Add('If((TO_DAYS(' + QuotedStr(FormatDateTime(MysqlDateFormat, CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time))) + ') - TO_DAYS(' + AgeFieldName + '))>30 And (TO_DAYS(' +
            QuotedStr(FormatDateTime(MysqlDateFormat, CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time))) + ') - TO_DAYS(' + AgeFieldName + '))<=60,' + CreditDebitDiffSQL + ',0.00) AS "30-60 Days", ');
          Add('If((TO_DAYS(' + QuotedStr(FormatDateTime(MysqlDateFormat, CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time))) + ') - TO_DAYS(' + AgeFieldName + '))>60 And (TO_DAYS(' +
            QuotedStr(FormatDateTime(MysqlDateFormat, CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time))) + ') - TO_DAYS(' +
            AgeFieldName + '))<=90,' + CreditDebitDiffSQL + ',0.00) AS "60-90 Days", ');
          Add('If((TO_DAYS(' + QuotedStr(FormatDateTime(MysqlDateFormat, CurDateifIgnoredateRange(IgnoreDateRange,Point_In_Time))) +
            ') - TO_DAYS(' + AgeFieldName + '))>90,' + CreditDebitDiffSQL + ',0.00) AS ">90 Days", ');
        end;    }
        if CalenderMonthAgeing then begin
            Add('if('+AgeFieldName+' is null or  '+AgeFieldName+' >= "'+Date_Thismonth(IgnoreDateRange,Point_In_Time,False)+ '",'+ CreditDebitDiffSQL+',0.00) as "Within Terms", ');
            Add('if('+AgeFieldName+' < "'+Date_Thismonth (IgnoreDateRange,Point_In_Time,False) + '" and '+AgeFieldName+' >= "'+Datefrom_1_30 (IgnoreDateRange,Point_In_Time,False)+'",'+ CreditDebitDiffSQL+',0.00) as "1-30 Days", ');
            Add('if('+AgeFieldName+' < "'+Datefrom_1_30  (IgnoreDateRange,Point_In_Time,False) + '" and '+AgeFieldName+' >= "'+Datefrom_30_60(IgnoreDateRange,Point_In_Time,False)+'",'+ CreditDebitDiffSQL+',0.00) as "30-60 Days", ');
            Add('if('+AgeFieldName+' < "'+Datefrom_30_60 (IgnoreDateRange,Point_In_Time,False) + '" and '+AgeFieldName+' >= "'+Datefrom_60_90(IgnoreDateRange,Point_In_Time,False)+'",'+ CreditDebitDiffSQL+',0.00) as "60-90 Days", ');
            Add('if('+AgeFieldName+' < "'+Datefrom_60_90 (IgnoreDateRange,Point_In_Time,False)+ '" ,'+ CreditDebitDiffSQL+',0.00) as ">90 Days", ');
        end else begin
            Add('if('+AgeFieldName+' is null or  '+AgeFieldName+' >= "'+Date_today   (IgnoreDateRange,Point_In_Time,False)+ '",'+ CreditDebitDiffSQL+',0.00) as "Within Terms", ');
            Add('if('+AgeFieldName+' < "'+Date_today    (IgnoreDateRange,Point_In_Time,False) + '" and '+AgeFieldName+' >="'+Date_1_30 (IgnoreDateRange,Point_In_Time,False)+'",'+ CreditDebitDiffSQL+',0.00) as "1-30 Days", ');
            Add('if('+AgeFieldName+' < "'+Date_1_30     (IgnoreDateRange,Point_In_Time,False) + '" and '+AgeFieldName+' >="'+Date_30_60 (IgnoreDateRange,Point_In_Time,False)+'",'+ CreditDebitDiffSQL+',0.00) as "30-60 Days", ');
            Add('if('+AgeFieldName+' < "'+Date_30_60    (IgnoreDateRange,Point_In_Time,False) + '" and '+AgeFieldName+' >="'+Date_60_90 (IgnoreDateRange,Point_In_Time,False)+'",'+ CreditDebitDiffSQL+',0.00) as "60-90 Days", ');
            Add('if('+AgeFieldName+' < "'+Date_60_90    (IgnoreDateRange,Point_In_Time,False) + '" ,'+ CreditDebitDiffSQL+',0.00) as ">90 Days", ');
        end;


        Add('If(TRANS.PrepaymentID<>0,TRANS.PrepaymentID,If(TRANS.PurchaseOrderID=0,TRANS.PaymentID,TRANS.PurchaseOrderID)) as PurchaseOrderID, ');
        Add('2 as Details, ');
        Add('TRANS.ClientID as ClientID,  ');
        Add('PO.InvoiceNumber as InvoiceNumber,');
        Add('IF(IsPO ="T",PO.InvoiceDate,IF(IsNull(PO.OrderDate),TRANS.Date,PO.OrderDate )) as InvoiceDate,TRANS.AccountName,APNotes, PO.ForeignExchangeCode, PO.ForeignExchangeRate');
        if FCFields <> '' then Add(',' + StringReplace('TRANS.' + FCFields , ',' , ',TRANS.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions TRANS ');
        Add('LEFT JOIN tblpurchaseorders PO ON TRANS.PurchaseOrderID = PO.PurchaseOrderID ');
        Add('WHERE TRANS.AccountType = "AP" AND TRANS.Type <> "Supplier Prepayment"'); // AND TRANS.Type <> "Supplier Payment" ');
        if CalenderMonthAgeing then
          Add('AND ((TRANS.TYPE = "PO" OR TRANS.TYPE = "Bill") Or (TRANS.Date <=' + QuotedStr(FormatDateTime(MysqlDateFormat, Point_In_Time)) + ')) ')
        else
          Add('AND (TRANS.Date <=' + QuotedStr(FormatDateTime(MysqlDateFormat, Point_In_Time)) + ') ');
        Add('AND (TRANS.TYPE = "PO" OR TRANS.TYPE = "Bill" OR TRANS.TYPE = "Credit" OR TRANS.TYPE = "Supplier Payment") ');
        if not AllClasses then begin
          Add('AND TRANS.ClassID=' + IntToStr(ClassID) + ' ');
        end;
        if (ClientID<>-1) then begin
          Add('AND TRANS.ClientID = '+IntToStr(ClientID)+' ');
        end;
        Add('Group By ClientID,PurchaseOrderID;');

        { Journals (group by clientid) }
        Add('INSERT HIGH_PRIORITY INTO ' + fstablename + ' (SeqNo, TransID,SupplierName,Type,OrderDate,DueDate,PONumber,Name,OriginalAmount,AmountDue,Current,30Days,60Days,90Days,120Days,PurchaseOrderID,Details,ClientID, InvoiceNumber,InvoiceDate,AccountName,APNotes, ForeignExchangeCode, ForeignExchangeRate ');
        if FCFields <> '' then Add(',' + FCFields);
        Add(')');
        Add('SELECT 2,TRANS.TransID,TRANS.ClientName as SupplierName, ');
        Add('TRANS.Type as Type, ');
        Add('TRANS.Date as OrderDate, ');
        Add('TRANS.Date as DueDate, ');
        Add('PurchaseOrderNumber as "PO Number", ');
        Add('TRANS.ClientName as Name, ');
        Add('IF(IsCredit ="T",IFNULL(-TotalAmountInc,0.00),IFNULL(TotalAmountInc,0.00)) AS "Original Amount", ');
        Add(CreditDebitDiffSQL + ' AS "Amount Due", ');
        Add(CreditDebitDiffSQL + ' AS "Within Terms", ');
        Add('0.00 AS "1-30 Days",');
        Add('0.00 AS "30-60 Days",');
        Add('0.00 AS "60-90 Days",');
        Add('0.00 AS ">90 Days",');
        Add('If(TRANS.PrepaymentID<>0,TRANS.PrepaymentID,If(TRANS.PurchaseOrderID=0,TRANS.PaymentID,TRANS.PurchaseOrderID)) as PurchaseOrderID, ');
        Add('2 as Details, ');
        Add('TRANS.ClientID as ClientID,  ');
        Add('PO.InvoiceNumber as InvoiceNumber,');
        Add('IF(IsPO ="T",PO.InvoiceDate,IF(IsNull(PO.OrderDate),TRANS.Date,PO.OrderDate )) as InvoiceDate,TRANS.AccountName,APNotes, PO.ForeignExchangeCode, PO.ForeignExchangeRate');
        if FCFields <> '' then Add(',' + StringReplace('TRANS.' + FCFields , ',' , ',TRANS.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions TRANS ');
        Add('LEFT JOIN tblpurchaseorders PO ON TRANS.PurchaseOrderID = PO.PurchaseOrderID ');
        Add('WHERE TRANS.AccountType = "AP" AND TRANS.Type <> "Supplier Prepayment"'); // AND TRANS.Type <> "Supplier Payment" ');
        if not CalenderMonthAgeing then
          Add('AND TRANS.Date <=' + QuotedStr(FormatDateTime(MysqlDateFormat, Point_In_Time)) + ' ');
        Add('AND (TRANS.TYPE = "Journal Entry") ');
        if not AllClasses then begin
          Add('AND TRANS.ClassID=' + IntToStr(ClassID) + ' ');
        end;
        if (ClientID<>-1) then begin
          Add('AND TRANS.ClientID = '+IntToStr(ClientID)+' ');
        end;
        Add('Group By ClientID;');

        Add('INSERT HIGH_PRIORITY INTO ' + fstablename + ' (SeqNo, TransID,SupplierName,Type,OrderDate,DueDate,PONumber,Name,OriginalAmount,AmountDue,Current,30Days,60Days,90Days,120Days,PurchaseOrderID,Details,ClientID, InvoiceNumber,InvoiceDate,AccountName,APNotes, ForeignExchangeCode, ForeignExchangeRate ');
        if FCFields <> '' then Add(',' + FCFields);
        Add(')');
        Add('SELECT 3, TRANS.TransID,TRANS.ClientName as SupplierName, ');
        Add('"Supplier Prepayment" as Type, ');
        Add('TRANS.Date as OrderDate, ');
        Add('TRANS.Date as DueDate, ');
        Add('Trans.PrepaymentID as "PO Number", ');
        Add('TRANS.ClientName as Name, ');
        Add('0.00 AS "Original Amount",');
        Add('Sum(CreditsInc-DebitsInc) AS "Amount Due",');
        Add('Sum(CreditsInc-DebitsInc) AS "Within Terms",');
        Add('0.00 AS "1-30 Days",');
        Add('0.00 AS "30-60 Days",');
        Add('0.00 AS "60-90 Days",');
        Add('0.00 AS ">90 Days",');
        Add('TRANS.PrepaymentID as PurchaseOrderID, ');
        Add('2 as Details, ');
        Add('TRANS.ClientID as ClientID,  ');
        Add('"" as InvoiceNumber,');
        Add('TRANS.Date as InvoiceDate,TRANS.AccountName,PP.Notes as APNotes, PP.ForeignExchangeCode, PP.ForeignExchangeRate');
        if FCFields <> '' then Add(',' + StringReplace('TRANS.' + FCFields , ',' , ',TRANS.',[rfReplaceAll,rfIgnoreCase]));
        Add('FROM tbltransactions TRANS ');
        Add('INNER JOIN tblPrepayments PP ON PP.PrepaymentID = TRANS.PrepaymentID ');
        Add('WHERE TRANS.AccountID = ' + IntToStr(GetPrepaymentAccountID('S')) + ' ');
        Add('AND (TRANS.Type = "Supplier Prepayment" OR TRANS.Type = "Supplier Payment") ');
        if not CalenderMonthAgeing then
          Add('AND TRANS.Date <=' + QuotedStr(FormatDateTime(MysqlDateFormat, Point_In_Time)) + ' ');
        if not AllClasses then begin
          Add('AND TRANS.ClassID=' + IntToStr(ClassID) + ' ');
        end;
        if (ClientID<>-1) then begin
          Add('AND TRANS.ClientID = '+IntToStr(ClientID)+' ');
        end;

        Add('Group By ClientID,Trans.PrepaymentID;');

        Add('UPDATE ' + fstablename  + ' SET Current = AmountDue WHERE TYPE = "Journal Entry";');
      end;

      (*ProgressDlg.Caption := 'Please Wait .......';
      ProgressDlg.MinValue := 0;
      ProgressDlg.Step := 1;
      if not Assigned(qryMyScript) then qryMyScript := TempMyScript;
      qryMyScript.BeforeExecute := MyScriptBeforeExecute;
      qryMyScript.SQL.Clear;
      qryMyScript.SQL.Text := ChangeQuery(BulkSQL.Text);
      ProgressDlg.MaxValue := qryMyScript.Statements.Count;
      ProgressDlg.Execute;
      BulkSQL.Clear;
      qryMyScript.IgnorenContinueOnError := True;
      qryMyScript.ProcessScriptExecteError := DoProcessScriptExecteError;
      qryMyScript.Execute;*)
      ExecuteBulkSQL;
    finally
      //ProgressDlg.CloseDialog;
      if IsGui then begin
        Screen.Cursor := Save_Cursor;
        Application.ProcessMessages
      end;
    end;
  finally
    fDoingRefresh:= false;
  end;
end;
end.
