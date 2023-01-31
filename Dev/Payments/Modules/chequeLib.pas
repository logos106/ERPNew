unit chequeLib;

interface
function chequeSQL(const chequeID:Integer; const TotalAmountInc :Double):String;
Function PaychequeSQL(const PayID:Integer; const TotalAmountGross, TotalAmountNet: Double):String;
Function SupplierPaychequeSQL(const PayID:Integer; const TotalAmount, ForeignTotalAmount:Double):String;
Function SupplierPaychequeSQLDetails(const PayID:Integer; const TotalAmount, ForeignTotalAmount:Double):String;
Function SupplierPaychequeSQLforBlankLines(const PayID:Integer):String;
Function SupplierPrePaychequeSQL(const PayID:Integer; const TotalAmount:Double):String;
function Calcamount(Amount:double):String;

implementation

uses Sysutils, FastFuncs, CommonLib, DNMLib, AppEnvironment, ProductQtyLib, tcConst,
  ERPdbComponents, TemplateReportsLib, DbSharedObjectsObj, CommonDbLib;

Function PaychequeSQL(const PayID:Integer; const TotalAmountGross, TotalAmountNet: Double):String;
begin
  REsult:= '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber, CO.ABN ' +
                    ' FROM tblCompanyInformation AS CO' +
            ' ~|||~{cheque}Select  ' +
                    Quotedstr(MoneyWords(TotalAmountGross))+' as AmountGrossInWords, '+
                    AddressSQL('tblEmployees' , True ,'title' , 'FirstName' , 'MiddleName' , 'LastName' , 'Street' , 'Street2' , 'Street3', 'Suburb', 'State' , 'Postcode') +  '  as employeeAddress,   ' +
                    Quotedstr(Calcamount(TotalAmountGross)) +'  as DisplayAmountGross,'+
                    Quotedstr(MoneyWords(TotalAmountNet))+' as AmountNetInWords, '+
                    Quotedstr(Calcamount(TotalAmountNet)) +'  as DisplayAmountNet,'+
                    ' Concat(FirstName," ",LastName) AS "EmployeeName", ' +
                    ' PayDate AS "Pay Date", ' +
                    ' DatePaid AS "Date Paid"  ' +
                    ' FROM tblPays LEFT JOIN tblEmployees ON tblPays.EmployeeID=tblEmployees.EmployeeID  ' +
                    ' WHERE tblPays.Payid = ' + inttostr(PayID)+'' ;


end;

function chequeSQL(const chequeID:Integer; const TotalAmountInc :Double):String;
begin
  REsult := companyInfoSQL(*'{CompanyInfo}Select * , Concat(Address," ",Address2," ",City," ",tblCompanyInformation.State," ",tblCompanyInformation.Postcode) AS CompanyAddress '+
          ' from tblCompanyInformation '*);

  Result:= result +' ~|||~{TransDet}select ' +
          Quotedstr(MoneyWords(TotalAmountInc))+' as AmountInWords, '+
          Quotedstr(Calcamount(TotalAmountInc)) +'  as DisplayAmount,'+
          ' C.*, '+
          ' d2.PurchaseOrderID,d2.Account,d2.SupplierName,d2.OrderTo , '+
          ' d2.OrderDate,d2.Payment,d2.TotalAmountInc, d2.EmployeeName, '+
          ' d2.PurchaseOrderNumber,d2.InvoiceNumber, '+
          ' d2.Refno,d2.Comments,d2.SalesComments  as InternalComments, '+
          ' tblPurchaseLines.LineTaxCode,tblPurchaseLines.LineCost, '+
          ' tblPurchaseLines.LineTax,tblPurchaseLines.LineCostInc, '+
          ' tblPurchaseLines.Product_Description,tblPurchaseLines.CustomerJob, '+
          ' tblPurchaseLines.AccountName,tblPurchaseLines.Class, tblPurchaseLines.Accountnumber '+
          ' FROM tblPurchaseOrders d2   '+
          ' LEFT JOIN tblPurchaseLines  ON d2.PurchaseOrderID=tblPurchaseLines.PurchaseOrderID    '+
          ' LEFT JOIN tblClients C ON d2.ClientID=C.ClientID '+
          ' WHERE d2.PurchaseOrderID = ' +IntToStr(chequeID);
  if Appenv.Companyprefs.chequeTemplate_NoofLinesinDetailSection >0 then
        REsult := result +' order by LinesOrder limit ' + inttostr(Appenv.Companyprefs.chequeTemplate_NoofLinesinDetailSection );

  Result := result + '~|||~{TaxDetails}Select TTCL.`SubTaxCode`, TTCL.Percentage,   '+
          ' Sum(TTCL.`TaxAmount`) TaxAmount  '+
          ' from tblpurchasetaxcodelines TTCL  '+
          ' inner join tblpurchasetaxcodes TTC on TTCL.PurchaseTaxCodeID = TTC.ID  '+
          ' where TTC.PurchaseOrderID =  ' +IntToStr(chequeID) +
          ' group by TTCL.`SubTaxCode`'+
          '~|||~{ClientCustomFields}Select  CFL.Description , CCV.Value  '+
          ' from  tblpurchaseorders  Trans   '+
          ' inner join tblcustomfieldvaluesClients CCV on Trans.ClientID = CCV.MasterID  '+
          ' inner join tblcustomfieldlist CFL on CFL.CFID = CCV.CustomFieldlistId  '+
          ' where ifnull(CCV.Value,"")<>""    '+
          ' and CFL.ListType = "ltSupplier" and Trans.PurchaseOrderID = ' +IntToStr(chequeID);

  Result:= result +'~|||~{TransDetmore} Select  concat(ctr - ' +inttostr(Appenv.Companyprefs.chequeTemplate_NoofLinesinDetailSection)+'," more lines......" ) description From (Select Count(*) ctr '+
                  ' from tblpurchaselines where purchaseOrderID = ' +IntToStr(chequeID)+') as POSumm where ctr>' + inttostr(Appenv.Companyprefs.chequeTemplate_NoofLinesinDetailSection );
  if Appenv.Companyprefs.chequeTemplate_NoofLinesinDetailSection =0 then REsult := Result +' limit 0';
  Result := Result+'~|||~{TransComments}SELECT C.Comments ' +
                  ' FROM tblComments C ' +
                  ' inner join tbltranscomments TC on C.CommentsID = TC.CommentID ' +
                  ' where TC.Transtype = ' + quotedstr('Cheque')+' and TC.TransId = ' + inttostr(chequeID)+' ORDER BY seqno';

end;
Function SupplierPaychequeSQL(const PayID:Integer; const TotalAmount, ForeignTotalAmount:Double):String;
begin
  result := '{CompanyInfo}Select * , Concat(Address," ",Address2," ",City," ",tblCompanyInformation.State," ",tblCompanyInformation.Postcode) AS CompanyAddress from tblCompanyInformation '+
          ' ~|||~{TransDet} ' +  SupplierPaychequeSQLDetails(PayId , TotalAmount, ForeignTotalAmount)+
          ' ~|||~{BlankLines} ' + SupplierPaychequeSQLforBlankLines(PayID);
end;

Function SupplierPaychequeSQLDetails(const PayID:Integer; const TotalAmount, ForeignTotalAmount:Double):String;
begin
  result := 'Select ' + quotedstr(MoneyWords(TotalAmount)) +' as AmountInWords, ' + quotedstr(Calcamount(TotalAmount)) +' as DisplayAmount, ' + 'tblCompanyInformation.CompanyName, ' + 'Concat(Address," ",Address2," ",City," ",tblCompanyInformation.State," ",tblCompanyInformation.Postcode) AS CompanyAddress, ' +
          ' Concat("Phone ",PhoneNumber," Fax ",tblCompanyInformation.FaxNumber) AS PhoneFax, ' +
          ' Concat("ABN ",tblCompanyInformation.ABN) AS ABN, ' + 'tblWithdrawal.PaymentID,tblWithdrawal.SupplierID,Amount,tblWithdrawal.PayMethodID,ReferenceNo, ' +
          ' PaymentDate,  OpeningBalance,ClosingBalance,tblWithdrawal.ClassID,tblWithdrawal.AccountID, ' +
          ' Applied,UnApplied,tblWithdrawal.Notes,  TrnType,tblWithdrawalLines.OrderDate,PONo,OriginalAmount,tblWithdrawalLines.AmountDue, ' +
          ' AmountOutstanding,  tblWithdrawalLines.AmountDue-tblWithdrawalLines.AmountOutstanding AS AmountPaid,PaidInFull,  POID, ' +
          ' tblWithdrawalLines.ForeignOriginalAmount,tblWithdrawalLines.ForeignAmountDue,tblWithdrawalLines.ForeignPayment,tblWithdrawalLines.ForeignAmountOutstanding,' +

//          ' (select sum(TotalLineAmountInc) from tblPurchaseLines where tblPurchaseLines.PurchaseOrderID = tblWithdrawalLines.POID and tblPurchaseLines.ProductName like "%Discount%" and tblPurchaseLines.PartType = "OTHER") as PaymentDiscount,' +
          ' OrderDiscountAmount(tblWithdrawalLines.POID) as PaymentDiscount,' +
          ' OrderDiscountPercent(tblWithdrawalLines.POID) as PaymentDiscountPercent,' +

          ' ' +Quotedstr(MoneyWords(ForeignTotalAmount)) +' AS `ForeignAmountInWords`,'+ quotedstr(Calcamount(ForeignTotalAmount))+' AS `ForeignDisplayAmount`,'+
          ' Company,AccountName,ClassName,tblPaymentMethods.Name AS PayMethod, ' +
          ' CONCAT_WS(" ",C.Title,C.FirstName,C.LastName) as ClientContactName,  C.Company as ClientCompany, C.PrintName,  C.Street as ClientStreet,C.Street2 as ClientStreet2,C.Suburb as ClientSuburb, ' +
          ' C.State as ClientState,C.Country as ClientCountry,C.Postcode as ClientPostcode,  C.BillStreet as ClientBillStreet,C.BillStreet2 as ClientBillStreet2,C.BillSuburb as ClientBillSuburb, ' +
          ' C.BillState as ClientBillState,C.BillCountry as ClientBillCountry,C.BillPostcode as ClientBillPostcode, ' + 'CONCAT_WS(" ",C.Suburb,C.State,C.Postcode) as ClientLocation, ' +
          ' CONCAT_WS(" ",C.BillSuburb,C.BillState,C.BillPostcode) as ClientBillLocation, ' +
          ' C.PHONE,C.FAXNumber,C.JobName,InvoiceNumber,tblWithdrawal.ForeignExchangeRate,tblWithdrawal.ForeignExchangeCode,ForeignCurrencyAmount, tblpurchaseorders.OrderTo ' +
          ' FROM tblCompanyInformation,tblWithdrawal ' +
          ' LEFT JOIN tblWithdrawalLines  ON tblWithdrawal.PaymentID=tblWithdrawalLines.PaymentID ' +
          ' LEFT JOIN tblClients C ON tblWithdrawal.SupplierID=C.ClientID ' +
          ' LEFT JOIN tblClass  ON tblWithdrawal.ClassID=tblClass.ClassID ' +
          ' LEFT JOIN tblChartOfAccounts  ON tblWithdrawal.AccountID=tblChartOfAccounts.AccountID ' +
          ' LEFT JOIN tblPaymentMethods  ON tblWithdrawal.PayMethodID=tblPaymentMethods.PayMethodID ' +
          ' LEFT JOIN tblpurchaseorders  ON tblWithdrawalLines.POID=tblpurchaseorders.PurchaseOrderID ' +
          ' WHERE tblWithdrawal.PaymentID = '+ inttostr(PayID);

end;
Function SupplierPaychequeSQLforBlankLines(const PayID:Integer):String;
var
  qry: TERPQuery;
  ctr:Integer;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    qry.sQL.text := 'SELECT  count(*) ctr FROM  tblWithdrawalLines  WHERE tblWithdrawalLines.PaymentID =  '+ inttostr(PayID);
    qry.open;
    Result := 'Select "" as details from DUAL';
    for ctr := Appenv.Companyprefs.BlankLinesinSuppPaymentCheque downto Qry.fieldbyname('ctr').asInteger do
      REsult := REsult +' union all Select "" as details from DUAL';
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
Function SupplierPrePaychequeSQL(const PayID:Integer; const TotalAmount:Double):String;
begin
 result:=  '{CompanyInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, '+
          ' Concat_ws('+quotedstr(NL)+',Address,Address2,concat_WS(" ",City,CO.State,CO.Postcode)) AS CompanyAddress , '+
          ' CO.PhoneNumber AS PhoneNumber, CO.FaxNumber AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO '+
          '~|||~{TransDet} ' +'Select ' + Quotedstr(MoneyWords(TotalAmount)) +' AmountInWords,'+
          ' ' + quotedstr(Calcamount(TotalAmount)) +' as DisplayAmount ,'+
          ' PP.PrePaymentID,'+
          ' PP.ClientID ,'+
          ' PP.PayAmount,'+
          ' PP.ReferenceNo,'+
          ' PP.PrePaymentDate,'+
          ' PP.Notes,'+
          ' C.company,'+
          'C.PrintName,' +
          ' AccountName,'+
          ' ClassName,'+
          ' PM.Name AS PayMethod,'+
          ' CONCAT_WS(" ",C.Title,C.FirstName,C.LastName) as ClientContactName,'+
          ' C.Street as ClientStreet,'+
          ' C.Street2 as ClientStreet2,'+
          ' C.Suburb as ClientSuburb,'+
          ' C.State as ClientState,'+
          ' C.Country as ClientCountry,'+
          ' C.Postcode as ClientPostcode,'+
          ' C.BillStreet as ClientBillStreet,'+
          ' C.BillStreet2 as ClientBillStreet2,'+
          ' C.BillSuburb as ClientBillSuburb,'+
          ' C.BillState as ClientBillState,'+
          ' C.BillCountry as ClientBillCountry,'+
          ' C.BillPostcode as ClientBillPostcode,'+
          ' CONCAT_WS(" ",C.Suburb,C.State,C.Postcode) as ClientLocation,'+
          ' CONCAT_WS(" ",C.BillSuburb,C.BillState,C.BillPostcode) as ClientBillLocation,'+
          ' C.PHONE,'+
          ' C.FAXNumber,'+
          ' C.JobName,'+
          ' PP.ForeignExchangeCode,'+
          ' PP.ForeignExchangeRate,'+
          ' PP.ForeignPayAmount'+
          ' FROM tblprepayments PP'+
          ' LEFT JOIN tblClients C ON PP.ClientID = c.clientID'+
          ' LEFT JOIN tblClass  CL on CL.classId = PP.ClassID'+
          ' LEFT JOIN tblChartOfAccounts  COA ON PP.BankAccountID =COA.AccountID'+
          ' LEFT JOIN tblPaymentMethods PM ON PP.PayMethodID =PM.PayMethodID'+
          ' WHERE PP.PrePaymentID = '+ inttostr(PayID);
end;
function Calcamount(Amount:double):String;
var
  Neg:Boolean;
  sMoney:String;
begin
  Neg := (Amount<0.00);
  sMoney := CurrToStrF(Amount, ffCurrency, 2);
  sMoney := FastFuncs.RightStr(sMoney, char_length(sMoney) - 1);
  If Neg then sMoney := '-' + sMoney;
  sMoney := '**' + sMoney;
  result:= sMoney;
  end;

end.

