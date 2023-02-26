unit PaymentsLib;

interface

uses
  JsonObject, MyAccess, BusObjBase, erpdbcomponents;

function ValidatePaymentLine(const PaymentLine: TMSBusObj;
  var data: TJsonObject; conn: TCustomMyConnection = nil): boolean;

procedure SendPaymentError(Sender: TMSBusObj; PaymentId, TransId: integer; TransType: string;ValidateStage: integer; msg: string);
procedure SalesOutStandingTrans(var QrySource: TERPQuery;aclientID:Integer; aSaleType:String= '' ; aTransId :Integer=0;SalePOIDs:String ='';
                                PrepayIDS:String =''; aExactClientID:Integer=0;aTxnDate:TDateTime=0; aAmount:Extended=0);
Procedure POOutStandingTrans(Var QrySource:TERPQuery; aPOtype:String = ''; aPOID:Integer = 0; SalePOIDs:String =''; PrepayIDS:String ='';
                                aclientID:Integer=0; aTxnDate:TDateTime=0; aAmount:Extended=0);

implementation

uses
  CommonDbLib, CommonLib, tcConst, BusObjPayments, sysutils,
  AppEnvironment, Math, ERPErrorEmailUtils, tcDataUtils, SystemLib;

function ValidatePaymentLine(const PaymentLine: TMSBusObj;
  var data: TJsonObject; conn: TCustomMyConnection = nil): boolean;
var
  qry: TERPQuery;
  TransactionTableName: string;
  PaymentTablename: string;
  PaymentLineTablename: string;
  IDFieldName: string;
  TransIDFieldName: string;
  TransType: string;
  TransName: string;
  AmountFieldName: string;
  Id: integer;
begin
  result:= true;
  if (PaymentLine is TGuiCustPaymentLines) and (TGuiCustPaymentLines(PaymentLine).TransType <> PrePayType) then begin
    TransactionTableName := 'tblSales';
    PaymentTablename     := 'tbldeposits';
    PaymentLineTablename := 'tbldepositline';
    IDFieldName          := 'SaleId';
    TransIDFieldName     := 'SaleId';
    TransType            := TGuiCustPaymentLines(PaymentLine).TransType;
    AmountFieldName      := 'TotalAmountInc';
    TransName:= 'Customer Payment';
    Id:= TGuiCustPaymentLines(PaymentLine).TransID;
  end
  else if (PaymentLine is TGuiCustPaymentLines) and (TGuiCustPaymentLines(PaymentLine).TransType = PrePayType) then begin
    Transactiontablename  :='tblPrePayments';
    IDFieldName           :='PrePaymentID';
    PaymentTablename      :='tbldeposits';
    PaymentLineTablename  :='tbldepositline';
    TransIDFieldName      :='PrepaymentID';
    TransType            := TGuiCustPaymentLines(PaymentLine).TransType;
    AmountFieldName      := 'PayAmount';
    TransName := CUSTOMER_PREPAYMENT;
    Id:= TGuiCustPaymentLines(PaymentLine).TransID;
  end
  else if (PaymentLine is TGuiSuppPaymentLines) and (TGuiSuppPaymentLines(PaymentLine).TransType <> PrePayType) then begin
    Transactiontablename  :='tblpurchaseorders';
    IDFieldName           :='PurchaseOrderID';
    PaymentTablename      :='tblwithdrawal';
    PaymentLineTablename  :='tblwithdrawallines';
    TransIDFieldName      :='POID';
    TransType            := TGuiSuppPaymentLines(PaymentLine).TransType;
    AmountFieldName      := 'TotalAmountInc';
    TransName := 'Supplier Payment';
    Id:= TGuiSuppPaymentLines(PaymentLine).TransID;
  end
  else if (PaymentLine is TGuiSuppPaymentLines) and (TGuiSuppPaymentLines(PaymentLine).TransType = PrePayType) then begin
    Transactiontablename  :='tblPrePayments';
    IDFieldName           :='PrePaymentID';
    PaymentTablename      :='tblwithdrawal';
    PaymentLineTablename  :='tblwithdrawallines';
    TransIDFieldName      :='PrepaymentID';
    TransType            := TGuiSuppPaymentLines(PaymentLine).TransType;
    AmountFieldName      := 'PayAmount';
    TransName := 'Supplier Pre-Payment';
    Id:= TGuiSuppPaymentLines(PaymentLine).TransID;
  end
  else if (PaymentLine is TCustPaymentLines) and (TCustPaymentLines(PaymentLine).TrnType <> PrePayType) then begin
    TransactionTableName := 'tblSales';
    PaymentTablename     := 'tbldeposits';
    PaymentLineTablename := 'tbldepositline';
    IDFieldName          := 'SaleId';
    TransIDFieldName     := 'SaleId';
    TransType            := TCustPaymentLines(PaymentLine).TrnType;
    AmountFieldName      := 'TotalAmountInc';
    TransName:= 'Customer Payment';
    Id:= TCustPaymentLines(PaymentLine).SaleID;
  end
  else if (PaymentLine is TCustPaymentLines) and (TCustPaymentLines(PaymentLine).TrnType = PrePayType) then begin
    Transactiontablename  :='tblPrePayments';
    IDFieldName           :='PrePaymentID';
    PaymentTablename      :='tbldeposits';
    PaymentLineTablename  :='tbldepositline';
    TransIDFieldName      :='PrepaymentID';
    TransType            := TCustPaymentLines(PaymentLine).TrnType;
    AmountFieldName      := 'PayAmount';
    TransName := CUSTOMER_PREPAYMENT;
    Id:= TCustPaymentLines(PaymentLine).PrePaymentID;
  end
  else if (PaymentLine is TSuppPaymentLines) and (TSuppPaymentLines(PaymentLine).TrnType <> PrePayType) then begin
    Transactiontablename  :='tblpurchaseorders';
    IDFieldName           :='PurchaseOrderID';
    PaymentTablename      :='tblwithdrawal';
    PaymentLineTablename  :='tblwithdrawallines';
    TransIDFieldName      :='POID';
    TransType            := TSuppPaymentLines(PaymentLine).TrnType;
    AmountFieldName      := 'TotalAmountInc';
    TransName := 'Supplier Payment';
    Id:= TSuppPaymentLines(PaymentLine).POID;
  end
  else if (PaymentLine is TSuppPaymentLines) and (TSuppPaymentLines(PaymentLine).TrnType = PrePayType) then begin
    Transactiontablename  :='tblPrePayments';
    IDFieldName           :='PrePaymentID';
    PaymentTablename      :='tblwithdrawal';
    PaymentLineTablename  :='tblwithdrawallines';
    TransIDFieldName      :='PrepaymentID';
    TransType            := TSuppPaymentLines(PaymentLine).TrnType;
    AmountFieldName      := 'PayAmount';
    TransName := 'Supplier Pre-Payment';
    Id:= TSuppPaymentLines(PaymentLine).PrePaymentID;
  end
  else
    Exit;

  if not Assigned(data) then data:= TJsonObject.Create;
  qry := TERPQuery.Create(nil);
  try
    if Assigned(conn) then qry.Connection := conn
    else qry.Connection := CommonDbLib.GetSharedMyDacConnection;

    qry.SQL.Add('SELECT t.Payment, t.Balance, t.Paid,');
    qry.SQL.Add('t.' + AmountFieldName + ' AS Amount,');
    qry.SQL.Add('SUM(IFNull(pl.Payment, 0)) AS PaymentTotal');
    //qry.SQL.Add('SUM(IF(IsNull(pl.' + TransIDFieldName + ') OR p.Deleted="F", pl.Payment, 0)) AS PaymentTotal');
    qry.SQL.Add('FROM ' + Transactiontablename  + ' t');
    qry.SQL.Add('LEFT JOIN ' + PaymentLineTablename + ' pl ON pl.' + TransIDFieldName+ '=t.' + IDFieldName);
    qry.SQL.Add('LEFT JOIN ' + PaymentTablename+ ' p ON p.PaymentId=pl.PaymentID');
    qry.SQL.Add('WHERE t.' + IDFieldName + '=' + IntToStr(Id));
    qry.SQL.Add('GROUP BY t.' + IDFieldName);

    qry.Open;

    data.F['Amount'] := qry.FieldByName('Amount').AsFloat;
    data.F['Payment'] := qry.FieldByName('Payment').AsFloat;
    data.F['Balance'] := qry.FieldByName('Balance').AsFloat;
    data.B['Paid'] := qry.FieldByName('Paid').AsBoolean;
    data.F['PaymentTotal'] := qry.FieldByName('PaymentTotal').AsFloat;
    if data.B['Paid'] and (data.F['balance'] <> 0) then begin
      result := false;
      data.S['message'] := TransType + ' ' + IntToStr(Id) +
        ' is flagged as paid but still has a balance of '
        + FloatToStr(data.F['balance']);
      exit;
    end
    else if not Math.SameValue((data.F['amount'] - data.F['payment']), data.F['balance'], 0.009) then begin
      result:= false;
      data.S['message']:= TransType + ' ' + IntToStr(Id) +
        ' Original amount of ' + FloatToStr(data.F['amount']) + ' minus paid of ' +
        FloatToStr(data.F['payment']) + ' does not equal balance of ' +
        FloatToStr(data.F['balance']);
      exit;
    end
//    else if not Math.SameValue(Abs(data.F['payment']), Abs(data.F['paymenttotal']),0.009) then begin
//      result:= false;
//      data.S['message']:= TransType + ' ' + IntToStr(Id) +
//        ' Paid amount of ' + FloatToStr(data.F['payment']) +
//        ' does not equal the total of payments ' +
//        FloatToStr(data.F['paymenttotal']);
//      exit;
//    end;

  finally
    qry.Free;
  end;
end;

procedure SendPaymentError(Sender: TMSBusObj; PaymentId, TransId: integer; TransType: string;
  ValidateStage: integer; msg: string);
var
  EmailText: string;
begin
  EmailText:=
    'Company   : ' +AppEnv.CompanyInfo.Companyname +chr(13) +
    'User      : ' +appenv.Employee.EmployeeName +chr(13) +
    'Database  : ' + AppEnv.AppDb.Database +chr(13) +
    '================================================='+chr(13)+
    'TransType : ' + TransType + chr(13) +
    'TransId   : ' + IntToStr(TransId) + chr(13) +
    'Sender    : ' + sender.ClassName + chr(13);
  if Assigned(Sender.Owner) and (Sender.Owner is TPayments) then
    EmailText:= EmailText +
    'Client    : ' + TPayments(Sender.Owner).CompanyName + chr(13);
  EmailText:= EmailText +
    'PaymentId : ' + IntToStr(PaymentId) + chr(13) +
    'Stage     : ' + IntToStr(ValidateStage) + chr(13) +
    'Message   : ' + msg + chr(13) +
    '=================================================';
  SendEmailtoErp('Payment Error: ' + TransType ,emailtext);

end;

procedure SalesOutStandingTrans(var QrySource: TERPQuery;aclientID:Integer; aSaleType:String= '' ; aTransId :Integer=0;SalePOIDs:String ='';
                                PrepayIDS:String =''; aExactClientID:Integer=0;aTxnDate:TDateTime=0; aAmount:Extended=0);
begin
  qrySource.SQL.Clear;
  if (aSaleType = '') or not sametext(aSaleType, PrePayType) then begin
    qrySource.SQL.Add('SELECT ');
    qrySource.SQL.Add('tblSales.SaleID                        as SaleID, ');
    qrySource.SQL.Add('If(IsRefund="T",' + QuotedStr(Refundtype) + ',' + QuotedStr(InvType) + ') as Type, ');
    qrySource.SQL.Add('CustomerName                           as CustomerName,');
    qrySource.SQL.Add('SaleDate                               as SaleDate, ');
    qrySource.SQL.Add('tblSales.GlobalRef                     as GlobalRef, ');
    qrySource.SQL.Add('InvoiceDocNumber                       as InvoiceDocNumber,');
    qrySource.SQL.Add('TotalAmountInc                         as TotalAmountInc,');
    qrySource.SQL.Add('tblSales.Balance                       as Balance, ');
    qrySource.SQL.Add('tblSales.Balance                       as AmountOutstanding, ');
    qrySource.SQL.Add('tblSales.ForeignTotalAmount            as ForeignTotalAmount, ');
    qrySource.SQL.Add('tblSales.ForeignBalanceAmount          as ForeignBalanceAmount , ');
    qrySource.SQL.Add('tblSales.ForeignBalanceAmount          as ForeignAmountOutstanding, ');
    qrySource.SQL.Add('0                                      as Payment, ');
    qrySource.SQL.Add('0                                      as ForeignPayment, ');
    qrySource.SQL.Add('tblSales.ForeignExchangeCode           as ForeignExchangeCode, ');
    qrySource.SQL.Add('tblSales.ForeignExchangeRate           as ForeignExchangeRate, ');
    qrySource.SQL.Add('Paid                                   as Paid, ');
    qrySource.SQL.Add('0                                      as Discount, ');
    qrySource.SQL.Add('0                                      as Withholding , ');
    qrySource.SQL.Add('0                                      as Refunding ,');
    qrySource.SQL.Add('0                                      as RefundPercent , ');
    qrySource.SQL.Add('"F"                                    as Apply,');
    qrySource.SQL.Add('convert(tblSales.Comments , char(255)) as RefNo,');
    qrySource.SQL.Add('tblSales.EnteredBy                     as EnteredBy');
    qrySource.SQL.Add('FROM tblSales ');
    qrySource.SQL.Add('INNER JOIN tblSalesLines ON  tblSales.SaleID = tblSalesLines.SaleID ');
    qrySource.SQL.Add('WHERE (IsInvoice="T" OR IsRefund="T") AND Paid="F" AND Invoiced="T"');
    qrySource.SQL.Add('AND tblSales.Deleted="F" AND Account<>'+quotedstr(UNDEPOSITED_FUNDS));
    if aClientId > 0 then
      qrySource.SQL.Add('AND tblSales.ClientID in (' + tcdatautils.GetALLRelatedClientIDs(aClientID) + ') ');
    qrySource.SQL.Add('AND tblSales.Balance <> 0');
    if aExactClientID <> 0 then qrySource.SQL.Add('AND tblSales.ClientID=' + IntToStr(aExactClientID));
    if aTxnDate <> 0 then qrySource.SQL.Add('AND SaleDate Between date_Add(' +
           QuotedStr(FormatDateTime('yyyy-mm-dd', aTxnDate)) + ', INTERVAL -1 MONTH) AND date_add(' +
           QuotedStr(FormatDateTime('yyyy-mm-dd', aTxnDate)) + ', INTERVAL 1 MONTH)');
    if aAmount <> 0 then qrySource.SQL.Add('AND tblSales.Balance=' + FloatToStr(aAmount));
    if Appenv.CompanyPrefs.InvoiceHasToBeApproved then qrySource.SQL.Add('AND tblSales.QuoteStatus = ' +Quotedstr('Approved'));
    if SalePOIDs <> '' then qrySource.SQL.Add('AND tblSales.SaleID In (' + SalePOIDs +')');
    if aSaleType <> '' then qrySource.SQL.Add('AND If(IsRefund="T",' + QuotedStr(Refundtype) + ',' + QuotedStr(InvType) + ') = ' + quotedstr(aSaleType));
    if aTransId  <> 0  then qrySource.SQL.Add('AND tblSales.SaleID In (' + inttostr(aTransId) +')');
      qrySource.SQL.Add('GROUP By tblSales.SaleID ');
  end;

  if (aSaleType = '') or  sametext(aSaleType , PrePayType) then begin
      if qrySource.SQL.count >0 then qrySource.SQL.Add('UNION ALL ');
      qrySource.SQL.Add('SELECT ');
      qrySource.SQL.Add('tblprepayments.PrePaymentID        as saleID, ');
      qrySource.SQL.Add( QuotedStr(PrePayType) + '          as Type,');
      qrySource.SQL.Add('CompanyName                        as CustomerName,');
      qrySource.SQL.Add('tblprepayments.PrePaymentDate      as SaleDate, ');
      qrySource.SQL.Add('tblprepayments.GlobalRef           as GlobalRef,');
      qrySource.SQL.Add('tblprepayments.PrePaymentID        as InvoiceDocNumber,');
      qrySource.SQL.Add('-tblprepayments.PayAmount          as TotalAmountInc, ');
      qrySource.SQL.Add('-tblprepayments.Balance            as Balance,');
      qrySource.SQL.Add('-tblprepayments.Balance            as AmountOutstanding,');
      qrySource.SQL.Add('-tblprepayments.ForeignPayAmount   as ForeignTotalAmount, ');
      qrySource.SQL.Add('-tblprepayments.ForeignBalance     as ForeignBalanceAmount, ');
      qrySource.SQL.Add('-tblprepayments.ForeignBalance     as ForeignAmountOutstanding, ');
      qrySource.SQL.Add('0                                  as Payment, ');
      qrySource.SQL.Add('0                                  as ForeignPayment,');
      qrySource.SQL.Add('tblprepayments.ForeignExchangeCode as ForeignExchangeCode, ');
      qrySource.SQL.Add('tblprepayments.ForeignExchangeRate as ForeignExchangeRate, ');
      qrySource.SQL.Add('tblprepayments.Paid                as Paid,');
      qrySource.SQL.Add('0                                  as Discount, ');
      qrySource.SQL.Add('0                                  as Withholding ,');
      qrySource.SQL.Add('0                                  as Refunding , ');
      qrySource.SQL.Add('0                                  as RefundPercent, ');
      qrySource.SQL.Add('"F"                                as Apply,');
      qrySource.SQL.Add('Convert(tblprepayments.ReferenceNo , char(255))  as RefNo,');
      qrySource.SQL.Add('E.EmployeeName                     as EnteredBy');
      qrySource.SQL.Add('FROM tblprepayments ');
      qrySource.SQL.Add('INNER JOIN tblemployees E on tblprepayments.EmployeeID = E.EmployeeID');
      qrySource.SQL.Add('WHERE Customer="T" AND tblprepayments.Paid="F"');
      qrySource.SQL.Add('AND tblprepayments.Deleted="F" ');
      qrySource.SQL.Add('AND tblprepayments.ClientID in (' + tcdatautils.GetALLRelatedClientIDs(aClientID) + ') ');
      qrySource.SQL.Add('AND tblprepayments.Balance <> 0');
      if PrepayIDS <> '' then qrySource.SQL.Add('AND tblprepayments.PrePaymentID In (' + PrepayIDS +')');
      if aTransId  <> 0  then qrySource.SQL.Add('AND tblprepayments.PrePaymentID In (' + inttostr(aTransId) +')');
      qrySource.SQL.Add('GROUP By tblprepayments.PrePaymentID ');
  end;
  qrySource.SQL.Add('ORDER BY SaleID;');
end;

Procedure POOutStandingTrans(Var QrySource:TERPQuery; aPOtype:String = ''; aPOID:Integer = 0; SalePOIDs:String =''; PrepayIDS:String ='';
                                aclientID:Integer=0; aTxnDate:TDateTime=0; aAmount:Extended=0);
begin
                  qrySource.SQL.Clear;
                  if (aPOtype = '') or not sametext(aPOtype , PrePayType) then begin
                      qrySource.SQL.Add('SELECT If(tblpurchaseorders.IsBill="T",' + QuotedStr(Billtype) +' ,If(tblpurchaseorders.IsPO="T",' + QuotedStr(POType)  +' ,If(tblpurchaseorders.IsCredit="T",' + QuotedStr(Credittype) + ',If(tblpurchaseorders.Ischeque="T" ,' + QuotedStr(ChequeType) +',' +  QuotedStr(RAType)+')))) as Type,');
                      qrySource.SQL.Add('SupplierName                           as SupplierName, ');
                      qrySource.SQL.Add('OrderDate                              as OrderDate,');
                      qrySource.SQL.Add('InvoiceDate                            as InvoiceDate,');
                      qrySource.SQL.Add('InvoiceNumber                          as InvoiceNumber, ');
                      qrySource.SQL.Add('tblpurchaseorders.GlobalRef            as GlobalRef, ');
                      qrySource.SQL.Add('tblpurchaseorders.Comments             as Comments, ');
                      qrySource.SQL.Add('PurchaseOrderNumber                    as PurchaseOrderNumber, ');
                      qrySource.SQL.Add('If(IsCredit="T",-tblpurchaseorders.TotalAmountInc,tblpurchaseorders.TotalAmountInc) as TotalAmountInc, ');
                      qrySource.SQL.Add('If(IsCredit="T",-tblpurchaseorders.Balance,tblpurchaseorders.Balance) as Balance,');
                      qrySource.SQL.Add('0, ');
                      qrySource.SQL.Add('If(IsCredit="T",-tblpurchaseorders.Balance,tblpurchaseorders.Balance) , ');
                      qrySource.SQL.Add('Paid                                   as Paid, ');
                      qrySource.SQL.Add('tblpurchaseorders.PurchaseOrderID      as PurchaseOrderID, ');
                      qrySource.SQL.Add('tblpurchaseorders.ForeignExchangeCode  as ForeignExchangeCode, ');
                      qrySource.SQL.Add('tblpurchaseorders.ForeignExchangeRate  as ForeignExchangeRate, ');
                      qrySource.SQL.Add('If(IsCredit="T",-tblpurchaseorders.ForeignTotalAmount, tblpurchaseorders.ForeignTotalAmount) as ForeignTotalAmount, ');
                      qrySource.SQL.Add('0, ');
                      qrySource.SQL.Add('If(IsCredit="T",-tblpurchaseorders.ForeignBalanceAmount, tblpurchaseorders.ForeignBalanceAmount) as ForeignBalanceAmount ,');
                      qrySource.SQL.Add('If(IsCredit="T",-tblpurchaseorders.ForeignBalanceAmount, tblpurchaseorders.ForeignBalanceAmount), ');
                      qrySource.SQL.Add('tblpurchaseorders.RefNo                as RefNo,');
                      qrySource.SQL.Add('tblpurchaseorders.EnteredBy            as EnteredBy');
                      qrySource.SQL.Add('FROM tblpurchaseorders');
                      qrySource.SQL.Add('INNER JOIN tblpurchaselines ON tblpurchaselines.PurchaseOrderID = tblpurchaseorders.PurchaseOrderID  ');
                      qrySource.SQL.Add('INNER JOIN tblClients  ON  tblpurchaseorders.ClientID = tblClients.ClientID  ');
                      qrySource.SQL.Add('WHERE tblpurchaseorders.ClientID =' + IntToStr(aclientID) );
                      qrySource.SQL.Add('AND (IsBill ="T" OR IsPO ="T" OR IsCredit ="T") AND IsRA ="F" ');
                      qrySource.SQL.Add('AND tblpurchaseorders.Deleted<>"T" And TotalAmountInc <> 0 AND Paid="F" ');
                      {For VS1, PO doesn't need invoice number to pay}
                      qrySource.SQL.Add('AND If((IsCredit="T" OR IsBill="T" or ' + Quotedstr(BooleanToStr(appenv.appdb.apimode))+ '="T" ),1,char_length(tblpurchaseorders.InvoiceNumber))>0  ');
                      qrySource.SQL.Add('AND tblpurchaseorders.Balance <> 0');
                      if aTxnDate <> 0 then qrySource.SQL.Add('AND OrderDate Between date_Add(' +
                             QuotedStr(FormatDateTime('yyyy-mm-dd', aTxnDate)) + ', INTERVAL -1 MONTH) AND date_add(' +
                             QuotedStr(FormatDateTime('yyyy-mm-dd', aTxnDate)) + ', INTERVAL 1 MONTH)');
                      if aAmount <> 0 then qrySource.SQL.Add('AND tblpurchaseorders.Balance=' + FloatToStr(aAmount));
                      if SalePOIDs <> '' then qrySource.SQL.Add('AND tblpurchaseorders.PurchaseOrderId In (' + SalePOIDs +')');
                      if aPOtype   <> '' then qrySource.SQL.Add('AND If(tblpurchaseorders.IsBill="T",' + QuotedStr(Billtype) +' ,If(tblpurchaseorders.IsPO="T",' + QuotedStr(POType)  +' ,If(tblpurchaseorders.IsCredit="T",' + QuotedStr(Credittype) + ',If(tblpurchaseorders.Ischeque="T" ,' + QuotedStr(ChequeType) +',' +  QuotedStr(RAType)+')))) =' + quotedstr(aPOtype));
                      if aPOID     <> 0  then qrySource.SQL.Add('AND tblpurchaseorders.PurchaseOrderId In (' + inttostr(aPOID) +')');
                      if AppEnv.CompanyPrefs.POOnlyApprovedTransInSuppPayment then begin
                        qrySource.SQL.Add('AND Approved = "T" ');
                      end;
                      qrySource.SQL.Add('GROUP BY tblpurchaseorders.PurchaseOrderID ');
                  end;


                  if (aPOtype = '') or  sametext(aPOtype , PrePayType) then begin
                    if qrySource.SQL.count >0 then qrySource.SQL.Add('UNION ALL ');
                    qrySource.SQL.Add('SELECT');
                    qrySource.SQL.Add(QuotedStr(PrePayType) + '                 as Type, ');
                    qrySource.SQL.Add('CompanyName                              as SupplierName, ');
                    qrySource.SQL.Add('tblprepayments.PrePaymentDate            as OrderDate,');
                    qrySource.SQL.Add('tblprepayments.PrePaymentDate            as InvoiceDate, ');
                    qrySource.SQL.Add('""                                       as InvoiceNumber, ');
                    qrySource.SQL.Add('tblprepayments.GlobalRef                 as GlobalRef, ');
                    qrySource.SQL.Add('tblprepayments.Notes                     as "Comments", ');
                    qrySource.SQL.Add('tblprepayments.PrePaymentID              as PurchaseOrderNumber, ');
                    qrySource.SQL.Add('-tblprepayments.PayAmount                as TotalAmountInc, ');
                    qrySource.SQL.Add('-tblprepayments.Balance                  as Balance,');
                    qrySource.SQL.Add('0,');
                    qrySource.SQL.Add('-tblprepayments.Balance, ');
                    qrySource.SQL.Add('tblprepayments.Paid                      as Paid, ');
                    qrySource.SQL.Add('tblprepayments.PrePaymentID              as PurchaseOrderID,');
                    qrySource.SQL.Add('tblprepayments.ForeignExchangeCode       as ForeignExchangeCode, ');
                    qrySource.SQL.Add('tblprepayments.ForeignExchangeRate       as ForeignExchangeRate, ');
                    qrySource.SQL.Add('-tblprepayments.ForeignPayAmount         as ForeignTotalAmount, ');
                    qrySource.SQL.Add('0, ');
                    qrySource.SQL.Add('-tblprepayments.ForeignBalance           as ForeignBalanceAmount, ');
                    qrySource.SQL.Add('-tblprepayments.ForeignBalance           as ForeignBalance,');
                    qrySource.SQL.Add('tblprepayments.ReferenceNo               as RefNo,');
                    qrySource.SQL.Add('E.EmployeeName                           as EnteredBy');
                    qrySource.SQL.Add('FROM tblprepayments');
                    qrySource.SQL.Add('INNER JOIN tblemployees E ON tblprepayments.EmployeeId=E.EmployeeId');
                    qrySource.SQL.Add('WHERE Supplier="T" AND tblprepayments.Paid="F" AND tblprepayments.Deleted="F" ');
                    qrySource.SQL.Add('AND tblprepayments.Balance <> 0');
                    qrySource.SQL.Add('AND tblprepayments.ClientID = ' + IntToStr(aclientID) );
                    if PrepayIDS <> '' then qrySource.SQL.Add('AND tblprepayments.PrePaymentID In (' + PrepayIDS +')');
                    if aPOID     <> 0  then qrySource.SQL.Add('AND tblprepayments.PrePaymentID In (' + inttostr(aPOID) +')');
                    qrySource.SQL.Add('GROUP By tblprepayments.PrePaymentID ');
                  end;
                  qrySource.SQL.Add('ORDER BY PurchaseOrderID;');
end;

end.

