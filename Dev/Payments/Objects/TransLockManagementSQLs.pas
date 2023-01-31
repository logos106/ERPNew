unit TransLockManagementSQLs;

interface
    function ChequeReconciledSQL1(const ID: integer;Details:Boolean =False): String;
    function ChequeReconciledSQL2(const ID: integer;Details:Boolean =False): String;
    function ChequeOnHOLDSQL1(const ID: integer;Details:Boolean =False): String;
    function ChequeOnHOLDSQL2(const ID: integer;Details:Boolean =False): String;

    function ChequeDepositOnHOLDSQL1(const ID: integer;Details:Boolean =False): String;
    function ChequeDepositOnHOLDSQL2(const ID: integer;Details:Boolean =False): String;
    function ChequeDepositReconciledSQL1(const ID: integer;Details:Boolean =False): String;
    function ChequeDepositReconciledSQL2(const ID: integer;Details:Boolean =False): String;

    function CustomerPaymentReconciledSQL1(const ID: integer): String;
    function CustomerPaymentReconciledSQL2(const ID: integer): String;
    function CustomerPaymentOnHOLDSQL1(const ID: integer):String;
    function CustomerPaymentOnHOLDSQL2(const ID: integer):String;

    function DepositEntrySplitReconciledSQL1(const ID: integer): String;
    function DepositEntrySplitReconciledSQL2(const ID: integer): String;
    function DepositEntrySplitOnHOLDSQL1(const ID: integer): String;
    function DepositEntrySplitOnHOLDSQL2(const ID: integer): String;

    function DepositEntryReconciledSQL1(const ID: integer): String;
    function DepositEntryReconciledSQL2(const ID: integer): String;
    function DepositEntryOnHOLDSQL1(const ID: integer): String;
    function DepositEntryOnHOLDSQL2(const ID: integer): String;

    function DepositReconciledSQL1(const ID: integer): string;
    function DepositReconciledSQL2(const ID: integer): string;
    function DepositOnHOLDSQL1(const ID: integer):String;
    function DepositOnHOLDSQL2(const ID: integer):String;

    function CustomerPrepaymentDepositedSQL(const ID: integer): String;
    function CustomerPrepaymentReconciledSQL1(const ID: integer): String;
    function CustomerPrepaymentReconciledSQL2(const ID: integer): String;
    function CustomerPrepaymentOnHOLDSQL1(const ID: integer): String;
    function CustomerPrepaymentOnHOLDSQL2(const ID: integer): String;

    Function SupplierPaymentReconciledSQL1(const ID:Integer):String;
    Function SupplierPaymentReconciledSQL2(const ID:Integer):String;
    function SupplierPaymentOnHOLDSQL1(const ID: integer):String;
    function SupplierPaymentOnHOLDSQL2(const ID: integer):String;

    Function JournalEntryReconciledSQL1(Const ID:Integer):String;
    Function JournalEntryReconciledSQL2(Const ID:Integer):String;
    function JournalEntryOnHOLDSQL1(const ID: integer):String;
    function JournalEntryOnHOLDSQL2(const ID: integer):String;

    function SupplierPrepaymentReconciledSQL1(const ID: integer): String;
    function SupplierPrepaymentReconciledSQL2(const ID: integer): String;
    function SupplierPrepaymentOnHOLDSQL1(const ID: integer): String;
    function SupplierPrepaymentOnHOLDSQL2(const ID: integer): String;
implementation

uses sysutils, CommonLib, tcConst;

function CustomerPaymentReconciledSQL1(const ID: integer):String;
begin

      Result := ' Select ';
      Result := Result + ' R.ReconciliationID ';
      Result := Result + ' From tbldeposits D ';
      Result := Result + ' INNER JOIN tbldepositline DL USING(PaymentID) ';
      Result := Result + ' INNER JOIN tblbankdepositlines BDL ON ';
      Result := Result + ' BDL.PaymentID = D.PaymentID AND ';
      Result := Result + ' BDL.PaymentDate = D.PaymentDate AND ';
      Result := Result + ' BDL.AccountID = D.AccountID AND ';
      Result := Result + ' SameValue(BDL.Amount , D.Amount ,' + inttostr(GeneralRoundPlaces) +')=1 AND ';
      Result := Result + ' BDL.CompanyName = D.CompanyName AND ';
      Result := Result + ' BDL.CusID = D.CusID AND ';
      Result := Result + ' BDL.TrnsType = "Customer Payment" ';
      Result := Result + ' INNER JOIN tblreconciliationdepositlines RDL	ON ';
      Result := Result + ' BDL.DepositID = RDL.PaymentID AND ';
      Result := Result + ' BDL.CompanyName = RDL.Payee AND ';
      Result := Result + ' BDL.PaymentDate = RDL.DepositDate AND ';
      Result := Result + ' BDL.AccountID = RDL.AccountID AND ';
      Result := Result + ' SameValue(BDL.Amount , RDL.Amount,' + inttostr(GeneralRoundPlaces) +')=1 AND ';
      Result := Result + ' BDL.TrnsType = RDL.Notes AND ';
      Result := Result + ' BDL.DepositLineID = RDL.DepositLineID ';
      Result := Result + ' INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID ';
      Result := Result + ' Where D.PaymentID=' + IntToStr(ID) + ' AND D.Deleted<>"T" AND R.Deleted<>"T" AND R.Finished="T" ';
      Result := Result + ' Group By R.ReconciliationID ';
end;
function CustomerPaymentReconciledSQL2(const ID: integer):String;
begin
        Result :=  ' Select ';
        Result := Result + ' R.ReconciliationID ';
        Result := Result + ' From tbldeposits D ';
        Result := Result + ' INNER JOIN tbldepositline DL USING(PaymentID) ';
        Result := Result + ' INNER JOIN tblbankdepositlines BDL ON ';
        Result := Result + ' BDL.PaymentID = D.PaymentID AND ';
        Result := Result + ' BDL.PaymentDate = D.PaymentDate AND ';
        Result := Result + ' BDL.AccountID = D.AccountID AND ';
        Result := Result + ' SameValue(BDL.Amount , D.Amount,' + inttostr(GeneralRoundPlaces) +')=1  AND ';
        Result := Result + ' BDL.CompanyName = D.CompanyName AND ';
        Result := Result + ' BDL.CusID = D.CusID AND ';
        Result := Result + ' BDL.TrnsType = "Customer Payment" ';
        Result := Result + ' INNER JOIN tblreconciliationwithdrawallines RWL	ON ';
        Result := Result + ' BDL.DepositID = RWL.PaymentID AND ';
        Result := Result + ' BDL.CompanyName = RWL.Payee AND ';
        Result := Result + ' BDL.PaymentDate = RWL.DepositDate AND ';
        Result := Result + ' BDL.AccountID = RWL.AccountID AND ';
        Result := Result + ' SameValue(-BDL.Amount , RWL.Amount,' + inttostr(GeneralRoundPlaces) +')=1 AND ';
        Result := Result + ' BDL.TrnsType = RWL.Notes AND ';
        Result := Result + ' BDL.DepositLineID = RWL.DepositLineID ';
        Result := Result + ' INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID ';
        Result := Result + ' Where D.PaymentID=' + IntToStr(ID) + ' AND D.Deleted<>"T" AND R.Deleted<>"T" AND R.Finished="T" ';
        Result := Result + ' Group By R.ReconciliationID ';
end;
function ChequeReconciledSQL1(const ID: integer;Details:Boolean =False): String;
begin
      Result := 'Select R.ReconciliationID,PO.TotalAmountInc ';
      if Details then Result := Result + '  ,PO.PurchaseOrderID, BDL.AccountName,  BDL.accountId, BDL.depositId, BDL.depositLineID, BDL.TrnsType ';
      Result := Result + ' From tblpurchaseorders PO ';
      Result := Result + ' INNER JOIN tblbankdepositlines BDL ON ';
      Result := Result + ' PO.PurchaseOrderID = BDL.PaymentID AND ';
      Result := Result + ' BDL.TrnsType="Cheque" ';
      Result := Result + ' INNER JOIN tblreconciliationwithdrawallines RWL	ON ';
      Result := Result + ' BDL.DepositID = RWL.PaymentID AND ';
      Result := Result + ' BDL.CompanyName = RWL.Payee AND ';
      Result := Result + ' BDL.PaymentDate = RWL.DepositDate AND ';
      Result := Result + ' SameValue(ABS(PO.TotalAmountInc) , ABS(RWL.Amount),' + inttostr(GeneralRoundPlaces) +')=1 AND ';
      Result := Result + ' BDL.TrnsType = RWL.Notes ';
      Result := Result + ' INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID ';
      Result := Result + ' Where PO.PurchaseOrderID=' + IntToStr(ID) + ' AND PO.IsCheque="T" AND R.Deleted<>"T" AND R.Finished="T" ';
      Result := Result + ' Group By R.ReconciliationID ';
      Result := Result + ' HAVING Round(PO.TotalAmountInc,'+inttostr(CurrencyRoundPlaces)+') = Round(Sum(If(BDL.TrnsType="Cheque",-BDL.Amount,0.00)),'+inttostr(CurrencyRoundPlaces)+'); ';
end;
function ChequeReconciledSQL2(const ID: integer;Details:Boolean =False): String;
begin
    REsult := 'Select R.ReconciliationID,PO.TotalAmountInc ';
    if Details then Result := Result + '  ,PO.PurchaseOrderID, BDL.AccountName,  BDL.accountId, BDL.depositId, BDL.depositLineID, BDL.TrnsType  ';
    Result := Result + ' From tblpurchaseorders PO ';
    Result := Result + ' INNER JOIN tblbankdepositlines BDL ON ';
    Result := Result + ' PO.PurchaseOrderID = BDL.PaymentID AND ';
    Result := Result + ' BDL.TrnsType="Cheque" ';
    Result := Result + ' INNER JOIN tblreconciliationdepositlines RDL	ON ';
    Result := Result + ' BDL.DepositID = RDL.PaymentID AND ';
    Result := Result + ' BDL.CompanyName = RDL.Payee AND ';
    Result := Result + ' BDL.PaymentDate = RDL.DepositDate AND ';
    Result := Result + ' SameValue(ABS(PO.TotalAmountInc) , ABS(RDL.Amount),' + inttostr(GeneralRoundPlaces) +')=1 AND ';
    Result := Result + ' BDL.TrnsType = RDL.Notes ';
    Result := Result + ' INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID ';
    Result := Result + ' Where PO.PurchaseOrderID=' + IntToStr(ID) + ' AND PO.IsCheque="T" AND R.Deleted<>"T" AND R.Finished="T" ';
    Result := Result + ' Group By R.ReconciliationID ';
    Result := Result + ' HAVING Round(PO.TotalAmountInc,'+inttostr(CurrencyRoundPlaces)+') = Round(Sum(If(BDL.TrnsType="Cheque",-BDL.Amount,0.00)),'+inttostr(CurrencyRoundPlaces)+'); ';
end;
function ChequeOnHOLDSQL1(const ID: integer;Details:Boolean =False): String;
begin
      Result := ' Select R.ReconciliationID,PO.TotalAmountInc ';
      if Details then Result := Result + '   ,PO.PurchaseOrderID, BDL.AccountName,  BDL.accountId, BDL.depositId, BDL.depositLineID, BDL.TrnsType ';
      Result := Result + ' From tblpurchaseorders PO ';
      Result := Result + ' INNER JOIN tblbankdepositlines BDL ON ';
      Result := Result + ' PO.PurchaseOrderID = BDL.PaymentID AND ';
      Result := Result + ' BDL.TrnsType="Cheque" ';
      Result := Result + ' INNER JOIN tblreconciliationwithdrawallines RWL	ON ';
      Result := Result + ' BDL.DepositID = RWL.PaymentID AND ';
      Result := Result + ' BDL.CompanyName = RWL.Payee AND ';
      Result := Result + ' BDL.PaymentDate = RWL.DepositDate AND ';
      Result := Result + ' SameValue(ABS(PO.TotalAmountInc) , ABS(RWL.Amount),' + inttostr(GeneralRoundPlaces) +')=1 AND ';
      Result := Result + ' BDL.TrnsType = RWL.Notes ';
      Result := Result + ' INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID ';
      Result := Result + ' Where PO.PurchaseOrderID=' + IntToStr(ID) + ' AND PO.IsCheque="T" AND R.Deleted<>"T" AND R.Finished <> "T" ';
      Result := Result + ' Group By R.ReconciliationID ';
      Result := Result + ' Having SameValue(PO.TotalAmountInc , Sum(If(BDL.TrnsType="Cheque",-BDL.Amount,0.00)),' + inttostr(GeneralRoundPlaces) +')=1; ';
end;
function ChequeOnHOLDSQL2(const ID: integer;Details:Boolean =False): String;
begin
        Result := ' Select R.ReconciliationID,PO.TotalAmountInc ';
        if Details then Result := Result + ' ,PO.PurchaseOrderID, BDL.AccountName,  BDL.accountId, BDL.depositId, BDL.depositLineID, BDL.TrnsType  ';
        Result := Result + ' From tblpurchaseorders PO ';
        Result := Result + ' INNER JOIN tblbankdepositlines BDL ON ';
        Result := Result + ' PO.PurchaseOrderID = BDL.PaymentID AND ';
        Result := Result + ' BDL.TrnsType="Cheque" ';
        Result := Result + ' INNER JOIN tblreconciliationdepositlines RDL	ON ';
        Result := Result + ' BDL.DepositID = RDL.PaymentID AND ';
        Result := Result + ' BDL.CompanyName = RDL.Payee AND ';
        Result := Result + ' BDL.PaymentDate = RDL.DepositDate AND ';
        Result := Result + ' SameValue(ABS(PO.TotalAmountInc) , ABS(RDL.Amount),' + inttostr(GeneralRoundPlaces) +')=1 AND ';
        Result := Result + ' BDL.TrnsType = RDL.Notes ';
        Result := Result + ' INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID ';
        Result := Result + ' Where PO.PurchaseOrderID=' + IntToStr(ID) + ' AND PO.IsCheque="T" AND R.Deleted<>"T" AND R.Finished <> "T" ';
        Result := Result + ' Group By R.ReconciliationID ';
        Result := Result + ' Having SameValue(PO.TotalAmountInc , Sum(If(BDL.TrnsType="Cheque",-BDL.Amount,0.00)),' + inttostr(GeneralRoundPlaces) +')=1; ';
end;
function ChequeDepositOnHOLDSQL1(const ID: integer;Details:Boolean =False): String;
begin
      Result := ' Select R.ReconciliationID ';
      if Details then Result := Result + '   ,PO.PurchaseOrderID, BDL.AccountName,  BDL.accountId, BDL.depositId, BDL.depositLineID, BDL.TrnsType ';
      Result := Result + ' From tblpurchaseorders PO ';
      Result := Result + ' INNER JOIN tblbankdepositlines BDL ON ';
      Result := Result + ' PO.PurchaseOrderID = BDL.PaymentID AND ';
      Result := Result + ' BDL.TrnsType="Cheque Deposit" ';
      Result := Result + ' INNER JOIN tblreconciliationwithdrawallines RWL ON ';
      Result := Result + ' BDL.DepositID = RWL.PaymentID AND ';
      Result := Result + ' BDL.CompanyName = RWL.Payee AND ';
      Result := Result + ' BDL.PaymentDate = RWL.DepositDate AND ';
      Result := Result + ' SameValue(ABS(BDL.Amount) , ABS(RWL.Amount),' + inttostr(GeneralRoundPlaces) +')=1 AND ';
      Result := Result + ' BDL.TrnsType = RWL.Notes ';
      Result := Result + ' INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID ';
      Result := Result + ' Where PO.PurchaseOrderID=' + IntToStr(ID) + ' AND PO.IsCheque="T" AND R.Deleted<>"T" AND R.Finished <> "T" ';
      Result := Result + ' Group By R.ReconciliationID; ';
end;
function ChequeDepositOnHOLDSQL2(const ID: integer;Details:Boolean =False): String;
begin
        Result := ' Select R.ReconciliationID ';
        if Details then Result := Result + ' ,PO.PurchaseOrderID, BDL.AccountName,  BDL.accountId, BDL.depositId, BDL.depositLineID, BDL.TrnsType  ';
        Result := Result + ' From tblpurchaseorders PO ';
        Result := Result + ' INNER JOIN tblbankdepositlines BDL ON ';
        Result := Result + ' PO.PurchaseOrderID = BDL.PaymentID AND ';
        Result := Result + ' BDL.TrnsType="Cheque Deposit" ';
        Result := Result + ' INNER JOIN tblreconciliationdepositlines RDL	ON ';
        Result := Result + ' BDL.DepositID = RDL.PaymentID AND ';
        Result := Result + ' BDL.CompanyName = RDL.Payee AND ';
        Result := Result + ' BDL.PaymentDate = RDL.DepositDate AND ';
        Result := Result + ' SameValue(ABS(BDL.Amount) , ABS(RDL.Amount),' + inttostr(GeneralRoundPlaces) +')=1 AND ';
        Result := Result + ' BDL.TrnsType = RDL.Notes ';
        Result := Result + ' INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID ';
        Result := Result + ' Where PO.PurchaseOrderID=' + IntToStr(ID) + ' AND PO.IsCheque="T" AND R.Deleted<>"T" AND R.Finished<>"T" ';
        Result := Result + ' Group By R.ReconciliationID; ';
end;
function ChequeDepositReconciledSQL1(const ID: integer;Details:Boolean =False): String;
begin
      Result := Result + ' Select R.ReconciliationID ';
      if Details then Result := Result + '  ,PO.PurchaseOrderID, BDL.AccountName,  BDL.accountId, BDL.depositId, BDL.depositLineID, BDL.TrnsType  ';
      Result := Result + ' From tblpurchaseorders PO ';
      Result := Result + ' INNER JOIN tblbankdepositlines BDL ON ';
      Result := Result + ' PO.PurchaseOrderID = BDL.PaymentID AND ';
      Result := Result + ' BDL.TrnsType="Cheque Deposit" ';
      Result := Result + ' INNER JOIN tblreconciliationwithdrawallines RWL	ON ';
      Result := Result + ' BDL.DepositID = RWL.PaymentID AND ';
      Result := Result + ' BDL.CompanyName = RWL.Payee AND ';
      Result := Result + ' BDL.PaymentDate = RWL.DepositDate AND ';
      Result := Result + ' SameValue(ABS(BDL.Amount) , ABS(RWL.Amount),' + inttostr(GeneralRoundPlaces) +')=1 AND ';
      Result := Result + ' BDL.TrnsType = RWL.Notes ';
      Result := Result + ' INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID ';
      Result := Result + ' Where PO.PurchaseOrderID=' + IntToStr(ID) + ' AND PO.IsCheque="T" AND R.Deleted<>"T" AND R.Finished="T" ';
      Result := Result + ' Group By R.ReconciliationID; ';
end;
function ChequeDepositReconciledSQL2(const ID: integer;Details:Boolean =False): String;
begin
        Result := Result + ' Select R.ReconciliationID ';
        if Details then Result := Result + '  ,PO.PurchaseOrderID, BDL.AccountName,  BDL.accountId, BDL.depositId, BDL.depositLineID, BDL.TrnsType ';
        Result := Result + ' From tblpurchaseorders PO ';
        Result := Result + ' INNER JOIN tblbankdepositlines BDL ON ';
        Result := Result + ' PO.PurchaseOrderID = BDL.PaymentID AND ';
        Result := Result + ' BDL.TrnsType="Cheque Deposit" ';
        Result := Result + ' INNER JOIN tblreconciliationdepositlines RDL	ON ';
        Result := Result + ' BDL.DepositID = RDL.PaymentID AND ';
        Result := Result + ' BDL.CompanyName = RDL.Payee AND ';
        Result := Result + ' BDL.PaymentDate = RDL.DepositDate AND ';
        Result := Result + ' SameValue(ABS(BDL.Amount) , ABS(RDL.Amount),' + inttostr(GeneralRoundPlaces) +')=1 AND ';
        Result := Result + ' BDL.TrnsType = RDL.Notes ';
        Result := Result + ' INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID ';
        Result := Result + ' Where PO.PurchaseOrderID=' + IntToStr(ID) + ' AND PO.IsCheque="T" AND R.Deleted<>"T" AND R.Finished="T" ';
        Result := Result + ' Group By R.ReconciliationID; ';

end;
function DepositReconciledSQL1(const ID: integer):string;
begin
      REsult := ' Select R.ReconciliationID ';
      REsult := result + ' FROM tblbankdeposit BD ';
      REsult := result + ' INNER JOIN tblbankdepositlines BDL ON BD.DepositID = BDL.DepositID ';
      REsult := result + ' INNER JOIN tblreconciliationdepositlines RDL ON ';
      REsult := result + ' BD.DepositID = RDL.PaymentID AND ';
      REsult := result + ' BD.DepositDate = RDL.DepositDate AND ';
      REsult := result + ' SameValue(BD.Deposit , RDL.Amount,' + inttostr(GeneralRoundPlaces) +')=1 AND ';
      REsult := result + ' RDL.Notes = "Bank Deposit" ';
      REsult := result + ' INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID ';
      REsult := result + ' WHERE BD.DepositID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND BD.Deleted<>"T"  AND R.Finished="T" ';
      REsult := result + ' GROUP BY R.ReconciliationID; ';
end;

function DepositReconciledSQL2(const ID: integer):string;
begin
        REsult := ' Select R.ReconciliationID ';
        REsult := result + ' FROM tblbankdeposit BD ';
        REsult := result + ' INNER JOIN tblbankdepositlines BDL ON BD.DepositID = BDL.DepositID ';
        REsult := result + ' INNER JOIN tblreconciliationwithdrawallines RWL ON ';
        REsult := result + ' BD.DepositID = RWL.PaymentID AND ';
        REsult := result + ' BD.DepositDate = RWL.DepositDate AND ';
        REsult := result + ' SameValue(-BD.Deposit , RWL.Amount ,' + inttostr(GeneralRoundPlaces) +')=1 AND ';
        REsult := result + ' RWL.Notes = "Bank Deposit" ';
        REsult := result + ' INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID ';
        REsult := result + ' WHERE BD.DepositID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND R.Finished="T" ';
        REsult := result + ' GROUP BY R.ReconciliationID; ';
end;
function DepositEntryOnHOLDSQL1(const ID: integer):String;
begin
      REsult := ' Select R.ReconciliationID '+
            ' FROM tblbankdeposit BD '+
            ' INNER JOIN tblbankdepositlines BDL ON BD.DepositID = BDL.DepositID '+
            ' INNER JOIN tblreconciliationdepositlines RDL ON '+
            ' BD.DepositID = RDL.PaymentID AND '+
            ' BD.DepositDate = RDL.DepositDate AND '+
            ' SameValue(ABS(BD.Deposit) , RDL.Amount  ,' + inttostr(GeneralRoundPlaces) +')=1 AND '+
            ' RDL.Notes = "Deposit Entry" '+
            ' INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID '+
            ' WHERE BD.DepositID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND BD.Deleted<>"T"  AND R.Finished<>"T" '+
            ' GROUP BY R.ReconciliationID; ';
end;
function DepositEntryOnHOLDSQL2(const ID: integer):String;
begin
      REsult := ' Select R.ReconciliationID '+
              ' FROM tblbankdeposit BD '+
              ' INNER JOIN tblbankdepositlines BDL ON BD.DepositID = BDL.DepositID '+
              ' INNER JOIN tblreconciliationwithdrawallines RWL ON '+
              ' BD.DepositID = RWL.PaymentID AND '+
              ' BD.DepositDate = RWL.DepositDate AND '+
              ' SameValue(ABS(BD.Deposit) , RWL.Amount  ,' + inttostr(GeneralRoundPlaces) +')=1 AND '+
              ' RWL.Notes = "Deposit Entry" '+
              ' INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID '+
              ' WHERE BD.DepositID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND BD.Deleted<>"T"  AND R.Finished<>"T" '+
              ' GROUP BY R.ReconciliationID; ';
end;
function DepositEntryReconciledSQL1(const ID: integer): String;
begin
      Result := ' Select R.ReconciliationID ';
      Result := Result + ' FROM tblbankdeposit BD ';
      Result := Result + ' INNER JOIN tblbankdepositlines BDL ON BD.DepositID = BDL.DepositID ';
      Result := Result + ' INNER JOIN tblreconciliationdepositlines RDL ON ';
      Result := Result + ' BD.DepositID = RDL.PaymentID AND ';
      Result := Result + ' BD.DepositDate = RDL.DepositDate AND ';
      Result := Result + ' SameValue(ABS(BD.Deposit) , RDL.Amount  ,' + inttostr(GeneralRoundPlaces) +')=1 AND ';
      Result := Result + ' RDL.Notes = "Deposit Entry" ';
      Result := Result + ' INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID ';
      Result := Result + ' WHERE BD.DepositID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND BD.Deleted<>"T" AND R.Finished="T" ';
      Result := Result + ' GROUP BY R.ReconciliationID; ';
end;
function DepositEntryReconciledSQL2(const ID: integer): String;
begin
        Result := ' Select R.ReconciliationID ';
        Result := Result + ' FROM tblbankdeposit BD ';
        Result := Result + ' INNER JOIN tblbankdepositlines BDL ON BD.DepositID = BDL.DepositID ';
        Result := Result + ' INNER JOIN tblreconciliationwithdrawallines RWL ON ';
        Result := Result + ' BD.DepositID = RWL.PaymentID AND ';
        Result := Result + ' BD.DepositDate = RWL.DepositDate AND ';
        Result := Result + ' SameValue(ABS(BD.Deposit) , RWL.Amount  ,' + inttostr(GeneralRoundPlaces) +')=1 AND ';
        Result := Result + ' RWL.Notes = "Deposit Entry" ';
        Result := Result + ' INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID ';
        Result := Result + ' WHERE BD.DepositID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND BD.Deleted<>"T" AND R.Finished="T" ';
        Result := Result + ' GROUP BY R.ReconciliationID; ';
end;
function DepositEntrySplitOnHOLDSQL1(const ID: integer):String;
begin
    REsult := 'Select R.ReconciliationID '+
            ' FROM tblbankdeposit BD '+
            ' INNER JOIN tblbankdepositlines BDL ON BD.DepositID = BDL.DepositID '+
            ' INNER JOIN tblreconciliationwithdrawallines RWL ON '+
            ' BDL.DepositID = RWL.PaymentID AND '+
            ' BD.DepositDate = RWL.DepositDate AND '+
            ' SameValue(ABS(BDL.Amount) , RWL.Amount  ,' + inttostr(GeneralRoundPlaces) +')=1 AND '+
            ' RWL.Notes = "Split Deposit" '+
            ' INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID '+
            ' WHERE BD.DepositID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND BD.Deleted<>"T"  AND R.Finished<>"T" '+
            ' GROUP BY R.ReconciliationID; ';
end;
function DepositEntrySplitOnHOLDSQL2(const ID: integer):String;
begin
    REsult := 'Select R.ReconciliationID '+
              ' FROM tblbankdeposit BD '+
              ' INNER JOIN tblbankdepositlines BDL ON BD.DepositID = BDL.DepositID '+
              ' INNER JOIN tblreconciliationdepositlines RDL ON '+
              ' BDL.DepositID = RDL.PaymentID AND '+
              ' BD.DepositDate = RDL.DepositDate AND '+
              ' SameValue(ABS(BDL.Amount) , RDL.Amount  ,' + inttostr(GeneralRoundPlaces) +')=1 AND '+
              ' RDL.Notes = "Split Deposit" '+
              ' INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID '+
              ' WHERE BD.DepositID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND BD.Deleted<>"T"  AND R.Finished<>"T" '+
              ' GROUP BY R.ReconciliationID; ';
end;
function DepositEntrySplitReconciledSQL1(const ID: integer): String;
begin
      Result := ' Select R.ReconciliationID ';
      Result := Result + ' FROM tblbankdeposit BD ';
      Result := Result + ' INNER JOIN tblbankdepositlines BDL ON BD.DepositID = BDL.DepositID ';
      Result := Result + ' INNER JOIN tblreconciliationwithdrawallines RWL ON ';
      Result := Result + ' BDL.DepositID = RWL.PaymentID AND ';
      Result := Result + ' BD.DepositDate = RWL.DepositDate AND ';
      Result := Result + ' SameValue(ABS(BDL.Amount) , RWL.Amount  ,' + inttostr(GeneralRoundPlaces) +')=1 AND ';
      Result := Result + ' RWL.Notes = "Split Deposit" ';
      Result := Result + ' INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID ';
      Result := Result + ' WHERE BD.DepositID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND BD.Deleted<>"T"  AND R.Finished="T" ';
      Result := Result + ' GROUP BY R.ReconciliationID; ';
end;

function DepositEntrySplitReconciledSQL2(const ID: integer): String;
begin
        Result := ' Select R.ReconciliationID ';
        Result := Result + ' FROM tblbankdeposit BD ';
        Result := Result + ' INNER JOIN tblbankdepositlines BDL ON BD.DepositID = BDL.DepositID ';
        Result := Result + ' INNER JOIN tblreconciliationdepositlines RDL ON ';
        Result := Result + ' BDL.DepositID = RDL.PaymentID AND ';
        Result := Result + ' BD.DepositDate = RDL.DepositDate AND ';
        Result := Result + ' SameValue(ABS(BDL.Amount) , RDL.Amount  ,' + inttostr(GeneralRoundPlaces) +')=1 AND ';
        Result := Result + ' RDL.Notes = "Split Deposit" ';
        Result := Result + ' INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID ';
        Result := Result + ' WHERE BD.DepositID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND BD.Deleted<>"T"  AND R.Finished="T" ';
        Result := Result + ' GROUP BY R.ReconciliationID; ';
end;
function JournalEntryReconciledSQL1(const ID: Integer): String;
begin
      Result := 'Select R.ReconciliationID '+
        'From tblgeneraljournal JE '+
        'INNER JOIN tblgeneraljournaldetails JEL USING(GJID) '+
        'INNER JOIN tblbankdepositlines BDL ON '+
        'JEL.GJID = BDL.PaymentID AND '+
        'JE.TransactionDate = BDL.PaymentDate AND '+
        'JEL.AccountID=BDL.AccountID AND '+
        'SameValue(BDL.Amount, (If(IsNull(JEL.DebitAmountInc),0.00,JEL.DebitAmountInc)-If(IsNull(JEL.CreditAmountInc),0.00,JEL.CreditAmountInc))  ,' + inttostr(GeneralRoundPlaces) +')=1 AND '+
        'BDL.TrnsType="Journal Entry" '+
        'INNER JOIN tblreconciliationwithdrawallines RWL	ON '+
        'BDL.DepositID = RWL.PaymentID AND '+
        'BDL.PaymentDate = RWL.DepositDate AND '+
        'BDL.AccountID = RWL.AccountID AND '+
        'SameValue(-BDL.Amount , RWL.Amount  ,' + inttostr(GeneralRoundPlaces) +')=1 AND '+
        'BDL.TrnsType = RWL.Notes AND '+
        'BDL.DepositLineID = RWL.DepositLineID '+
        'INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID '+
        'Where JE.GJID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND R.Finished="T" '+
        'Group By R.ReconciliationID ';
end;

function JournalEntryReconciledSQL2(const ID: Integer): String;
begin
  Result := 'Select R.ReconciliationID '+
        'From tblgeneraljournal JE '+
        'INNER JOIN tblgeneraljournaldetails JEL USING(GJID) '+
        'INNER JOIN tblbankdepositlines BDL ON '+
        'JEL.GJID = BDL.PaymentID AND '+
        'JE.TransactionDate = BDL.PaymentDate AND '+
        'JEL.AccountID=BDL.AccountID AND '+
        'SameValue(BDL.Amount,(If(IsNull(JEL.DebitAmountInc),0.00,JEL.DebitAmountInc)-If(IsNull(JEL.CreditAmountInc),0.00,JEL.CreditAmountInc)) ,' + inttostr(GeneralRoundPlaces) +')=1  AND '+
        'BDL.TrnsType="Journal Entry" '+
        'INNER JOIN tblreconciliationdepositlines RDL	ON BDL.DepositID = RDL.PaymentID AND '+
        'BDL.PaymentDate = RDL.DepositDate AND '+
        'BDL.AccountID = RDL.AccountID AND '+
        'SameValue(BDL.Amount , RDL.Amount  ,' + inttostr(GeneralRoundPlaces) +')=1 AND '+
        'BDL.TrnsType = RDL.Notes AND '+
        'BDL.DepositLineID = RDL.DepositLineID '+
        'INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID '+
        'Where JE.GJID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND R.Finished="T" '+
        'Group By ReconciliationID ';
end;
function CustomerPrepaymentOnHOLDSQL1(const ID: integer):String;
begin
      Result := '';
      Result := Result + 'Select ';
      Result := Result + 'R.ReconciliationID ';
      Result := Result + 'From tblprepayments PP ';
      Result := Result + 'INNER JOIN tblbankdepositlines BDL ON ';
      Result := Result + 'BDL.PaymentID = PP.PrePaymentID AND ';
      Result := Result + 'BDL.PaymentDate = PP.PrePaymentDate AND ';
      Result := Result + 'BDL.AccountID = PP.BankAccountID AND ';
      Result := Result + 'SameValue(BDL.Amount , PP.PayAmount  ,' + inttostr(GeneralRoundPlaces) +')=1  AND ';
      Result := Result + 'BDL.CompanyName= PP.CompanyName AND ';
      Result := Result + 'BDL.CusID=PP.ClientID AND ';
      Result := Result + 'BDL.TrnsType = "'+CUSTOMER_PREPAYMENT+'" ';
      Result := Result + 'INNER JOIN tblreconciliationdepositlines RDL	ON ';
      Result := Result + 'BDL.DepositID = RDL.PaymentID AND ';
      Result := Result + 'BDL.CompanyName = RDL.Payee AND ';
      Result := Result + 'BDL.PaymentDate = RDL.DepositDate AND ';
      Result := Result + 'BDL.AccountID = RDL.AccountID AND ';
      Result := Result + 'SameValue(BDL.Amount , RDL.Amount  ,' + inttostr(GeneralRoundPlaces) +')=1 AND ';
      Result := Result + 'BDL.TrnsType = RDL.Notes AND ';
      Result := Result + 'BDL.DepositLineID = RDL.DepositLineID ';
      Result := Result + 'INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID ';
      Result := Result + 'Where PP.PrePaymentID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND R.Finished<>"T" ';
      Result := Result + 'Group By R.ReconciliationID ';
end;
function CustomerPrepaymentOnHOLDSQL2(const ID: integer):String;
begin
      Result := '';
        Result := Result + 'Select ';
        Result := Result + 'R.ReconciliationID ';
        Result := Result + 'From tblprepayments PP ';
        Result := Result + 'INNER JOIN tblbankdepositlines BDL ON ';
        Result := Result + 'BDL.PaymentID = PP.PrePaymentID AND ';
        Result := Result + 'BDL.PaymentDate = PP.PrePaymentDate AND ';
        Result := Result + 'BDL.AccountID = PP.BankAccountID AND ';
        Result := Result + 'SameValue(BDL.Amount , PP.PayAmount   ,' + inttostr(GeneralRoundPlaces) +')=1 AND ';
        Result := Result + 'BDL.CompanyName= PP.CompanyName AND ';
        Result := Result + 'BDL.CusID=PP.ClientID AND ';
        Result := Result + 'BDL.TrnsType = "'+CUSTOMER_PREPAYMENT+'" ';
        Result := Result + 'INNER JOIN tblreconciliationwithdrawallines RWL	ON ';
        Result := Result + 'BDL.DepositID = RWL.PaymentID AND ';
        Result := Result + 'BDL.CompanyName = RWL.Payee AND ';
        Result := Result + 'BDL.PaymentDate = RWL.DepositDate AND ';
        Result := Result + 'BDL.AccountID = RWL.AccountID AND ';
        Result := Result + 'SameValue(-BDL.Amount , RWL.Amount  ,' + inttostr(GeneralRoundPlaces) +')=1 AND ';
        Result := Result + 'BDL.TrnsType = RWL.Notes AND ';
        Result := Result + 'BDL.DepositLineID = RWL.DepositLineID ';
        Result := Result + 'INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID ';
        Result := Result + 'Where PP.PrePaymentID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND R.Finished<>"T" ';
        Result := Result + 'Group By R.ReconciliationID ';
end;
function SupplierPrepaymentOnHOLDSQL1(const ID: integer): string;
begin
      result := ' Select '+
      ' R.ReconciliationID '+
      ' From tblprepayments PP '+
      ' INNER JOIN tblbankdepositlines BDL ON '+
      ' BDL.PaymentID    = PP.PrePaymentID AND '+
      ' BDL.PaymentDate  = PP.PrePaymentDate AND '+
      ' BDL.AccountID    = PP.BankAccountID AND '+
      ' SameValue(BDL.Amount       , PP.PayAmount   ,' + inttostr(GeneralRoundPlaces) +')=1 AND '+
      ' BDL.CompanyName  = PP.CompanyName AND '+
      ' BDL.CusID        = PP.ClientID AND '+
      ' BDL.TrnsType     = "Supplier Prepayment" '+
      ' INNER JOIN tblreconciliationwithdrawallines RWL	ON '+
      ' BDL.DepositID    = RWL.PaymentID AND '+
      ' BDL.CompanyName  = RWL.Payee AND '+
      ' BDL.PaymentDate  = RWL.DepositDate AND '+
      ' BDL.AccountID    = RWL.AccountID AND '+
      ' SameValue(BDL.Amount       , RWL.Amount  ,' + inttostr(GeneralRoundPlaces) +')=1 AND '+
      ' BDL.TrnsType     = RWL.Notes AND '+
      ' BDL.DepositLineID= RWL.DepositLineID '+
      ' INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID '+
      ' Where PP.PrePaymentID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND R.Finished<>"T" '+
      ' Group By R.ReconciliationID ';
end;
function SupplierPrepaymentOnHOLDSQL2(const ID: integer): string;
begin
      result :=   ' Select '+
        ' R.ReconciliationID '+
        ' From tblprepayments PP '+
        ' INNER JOIN tblbankdepositlines BDL ON '+
        ' BDL.PaymentID = PP.PrePaymentID AND '+
        ' BDL.PaymentDate = PP.PrePaymentDate AND '+
        ' BDL.AccountID = PP.BankAccountID AND '+
        ' SameValue(BDL.Amount , PP.PayAmount   ,' + inttostr(GeneralRoundPlaces) +')=1 AND '+
        ' BDL.CompanyName= PP.CompanyName AND '+
        ' BDL.CusID=PP.ClientID AND '+
        ' BDL.TrnsType = "Supplier Prepayment" '+
        ' INNER JOIN tblreconciliationdepositlines RDL	ON '+
        ' BDL.DepositID = RDL.PaymentID AND '+
        ' BDL.CompanyName = RDL.Payee AND '+
        ' BDL.PaymentDate = RDL.DepositDate AND '+
        ' BDL.AccountID = RDL.AccountID AND '+
        ' SameValue(-BDL.Amount , RDL.Amount  ,' + inttostr(GeneralRoundPlaces) +')=1 AND '+
        ' BDL.TrnsType = RDL.Notes AND '+
        ' BDL.DepositLineID = RDL.DepositLineID '+
        ' INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID '+
        ' Where PP.PrePaymentID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND R.Finished<>"T" '+
        ' Group By R.ReconciliationID ';
end;
function SupplierPrepaymentReconciledSQL1(const ID: integer):String;
begin
      Result := ' Select '+
      ' R.ReconciliationID '+
      ' From tblprepayments PP '+
      ' INNER JOIN tblbankdepositlines BDL ON '+
      ' BDL.PaymentID = PP.PrePaymentID AND '+
      ' BDL.PaymentDate = PP.PrePaymentDate AND '+
      ' BDL.AccountID = PP.BankAccountID AND '+
      ' SameValue(BDL.Amount , PP.PayAmount   ,' + inttostr(GeneralRoundPlaces) +')=1 AND '+
      ' BDL.CompanyName= PP.CompanyName AND '+
      ' BDL.CusID=PP.ClientID AND '+
      ' BDL.TrnsType = "Supplier Prepayment" '+
      ' INNER JOIN tblreconciliationwithdrawallines RWL	ON '+
      ' BDL.DepositID = RWL.PaymentID AND '+
      ' BDL.CompanyName = RWL.Payee AND '+
      ' BDL.PaymentDate = RWL.DepositDate AND '+
      ' BDL.AccountID = RWL.AccountID AND '+
      ' SameValue(BDL.Amount , RWL.Amount  ,' + inttostr(GeneralRoundPlaces) +')=1 AND '+
      ' BDL.TrnsType = RWL.Notes AND '+
      ' BDL.DepositLineID = RWL.DepositLineID '+
      ' INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID '+
      ' Where PP.PrePaymentID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND R.Finished="T" '+
      ' Group By R.ReconciliationID ';
end;
function SupplierPrepaymentReconciledSQL2(const ID: integer): String;
begin
        result := ' Select '+
        ' R.ReconciliationID '+
        ' From tblprepayments PP '+
        ' INNER JOIN tblbankdepositlines BDL ON '+
        ' BDL.PaymentID = PP.PrePaymentID AND '+
        ' BDL.PaymentDate = PP.PrePaymentDate AND '+
        ' BDL.AccountID = PP.BankAccountID AND '+
        ' SameValue(BDL.Amount , PP.PayAmount   ,' + inttostr(GeneralRoundPlaces) +')=1 AND '+
        ' BDL.CompanyName= PP.CompanyName AND '+
        ' BDL.CusID=PP.ClientID AND '+
        ' BDL.TrnsType = "Supplier Prepayment" '+
        ' INNER JOIN tblreconciliationdepositlines RDL	ON '+
        ' BDL.DepositID = RDL.PaymentID AND '+
        ' BDL.CompanyName = RDL.Payee AND '+
        ' BDL.PaymentDate = RDL.DepositDate AND '+
        ' BDL.AccountID = RDL.AccountID AND '+
        ' SameValue(-BDL.Amount , RDL.Amount  ,' + inttostr(GeneralRoundPlaces) +')=1 AND '+
        ' BDL.TrnsType = RDL.Notes AND '+
        ' BDL.DepositLineID = RDL.DepositLineID '+
        ' INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID '+
        ' Where PP.PrePaymentID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND R.Finished="T" '+
        ' Group By R.ReconciliationID ';
end;
function SupplierPaymentReconciledSQL1(const ID: Integer): String;
begin
      Result := 'Select '+
                ' R.ReconciliationID '+
                ' From tblwithdrawal W '+
                ' INNER JOIN tblwithdrawallines WL USING(PaymentID) '+
                ' INNER JOIN tblbankdepositlines BDL ON '+
                ' BDL.PaymentID = W.PaymentID AND '+
                ' BDL.PaymentDate = W.PaymentDate AND '+
                ' BDL.AccountID = W.AccountID AND '+
                ' SameValue(-BDL.Amount , W.Amount   ,' + inttostr(GeneralRoundPlaces) +')=1 AND '+
                ' BDL.CompanyName = W.CompanyName AND '+
                ' BDL.CusID = W.SupplierID AND '+
                ' BDL.TrnsType = "Supplier Payment" '+
                ' INNER JOIN tblreconciliationwithdrawallines RWL	ON '+
                ' BDL.DepositID = RWL.PaymentID AND '+
                ' BDL.CompanyName = RWL.Payee AND '+
                ' BDL.PaymentDate = RWL.DepositDate AND '+
                ' BDL.AccountID = RWL.AccountID AND '+
                ' SameValue(W.Amount , RWL.Amount  ,' + inttostr(GeneralRoundPlaces) +')=1 AND '+
                ' BDL.TrnsType = RWL.Notes AND '+
                ' BDL.DepositLineID = RWL.DepositLineID '+
                ' INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID '+
                ' Where W.PaymentID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND R.Finished="T" '+
                ' Group By R.ReconciliationID ';
end;

function SupplierPaymentReconciledSQL2(const ID: Integer): String;
begin
      Result := 'Select '+
                  ' R.ReconciliationID '+
                  ' From tblwithdrawal W '+
                  ' INNER JOIN tblwithdrawallines WL USING(PaymentID) '+
                  ' INNER JOIN tblbankdepositlines BDL ON '+
                  ' BDL.PaymentID = W.PaymentID AND '+
                  ' BDL.PaymentDate = W.PaymentDate AND '+
                  ' BDL.AccountID = W.AccountID AND '+
                  ' SameValue(-BDL.Amount , W.Amount   ,' + inttostr(GeneralRoundPlaces) +')=1 AND '+
                  ' BDL.CompanyName = W.CompanyName AND '+
                  ' BDL.CusID = W.SupplierID AND '+
                  ' BDL.TrnsType = "Supplier Payment" '+
                  ' INNER JOIN tblreconciliationdepositlines RDL	ON '+
                  ' BDL.DepositID = RDL.PaymentID AND '+
                  ' BDL.CompanyName = RDL.Payee AND '+
                  ' BDL.PaymentDate = RDL.DepositDate AND '+
                  ' BDL.AccountID = RDL.AccountID AND '+
                  ' SameValue(-W.Amount , RDL.Amount  ,' + inttostr(GeneralRoundPlaces) +')=1 AND '+
                  ' BDL.TrnsType = RDL.Notes AND '+
                  ' BDL.DepositLineID = RDL.DepositLineID '+
                  ' INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID '+
                  ' Where W.PaymentID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND R.Finished="T" '+
                  ' Group By R.ReconciliationID ';
end;
function CustomerPrepaymentDepositedSQL(const ID: integer): String;
begin
  Result := '';
  Result := Result + 'Select ';
  Result := Result + 'BD.DepositID ';
  Result := Result + 'From tblprepayments PP ';
  Result := Result + 'INNER JOIN tblbankdepositlines BDL ON ';
  Result := Result + 'BDL.PaymentID = PP.PrePaymentID AND ';
  Result := Result + 'BDL.PaymentDate = PP.PrePaymentDate AND ';
  Result := Result + 'BDL.AccountID = PP.BankAccountID AND ';
  Result := Result + 'SameValue(BDL.Amount , PP.PayAmount   ,' + inttostr(GeneralRoundPlaces) +')=1 AND ';
  Result := Result + 'BDL.CompanyName= PP.CompanyName AND ';
  Result := Result + 'BDL.CusID=PP.ClientID AND ';
  Result := Result + 'BDL.TrnsType = "Prepayment" ';
  Result := Result + 'INNER JOIN tblbankdeposit BD ON BD.DepositID = BDL.DepositID ';
  Result := Result + 'Where PP.PrePaymentID=' + IntToStr(ID) + ' AND BD.Deleted<>"T" ';
end;
function CustomerPrepaymentReconciledSQL1(const ID: integer):String;
begin
      REsult := '';
      Result := Result + 'Select ';
      Result := Result + 'R.ReconciliationID ';
      Result := Result + 'From tblprepayments PP ';
      Result := Result + 'INNER JOIN tblbankdepositlines BDL ON ';
      Result := Result + 'BDL.PaymentID = PP.PrePaymentID AND ';
      Result := Result + 'BDL.PaymentDate = PP.PrePaymentDate AND ';
      Result := Result + 'BDL.AccountID = PP.BankAccountID AND ';
      Result := Result + 'SameValue(BDL.Amount , PP.PayAmount   ,' + inttostr(GeneralRoundPlaces) +')=1 AND ';
      Result := Result + 'BDL.CompanyName= PP.CompanyName AND ';
      Result := Result + 'BDL.CusID=PP.ClientID AND ';
      Result := Result + 'BDL.TrnsType = "'+CUSTOMER_PREPAYMENT+'" ';
      Result := Result + 'INNER JOIN tblreconciliationdepositlines RDL	ON ';
      Result := Result + 'BDL.DepositID = RDL.PaymentID AND ';
      Result := Result + 'BDL.CompanyName = RDL.Payee AND ';
      Result := Result + 'BDL.PaymentDate = RDL.DepositDate AND ';
      Result := Result + 'BDL.AccountID = RDL.AccountID AND ';
      Result := Result + 'SameValue(BDL.Amount , RDL.Amount  ,' + inttostr(GeneralRoundPlaces) +')=1 AND ';
      Result := Result + 'BDL.TrnsType = RDL.Notes AND ';
      Result := Result + 'BDL.DepositLineID = RDL.DepositLineID ';
      Result := Result + 'INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID ';
      Result := Result + 'Where PP.PrePaymentID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND R.Finished="T" ';
      Result := Result + 'Group By R.ReconciliationID ';
end;
function CustomerPrepaymentReconciledSQL2(const ID: integer):String;
begin
        REsult := '';
        Result := Result + 'Select ';
        Result := Result + 'R.ReconciliationID ';
        Result := Result + 'From tblprepayments PP ';
        Result := Result + 'INNER JOIN tblbankdepositlines BDL ON ';
        Result := Result + 'BDL.PaymentID = PP.PrePaymentID AND ';
        Result := Result + 'BDL.PaymentDate = PP.PrePaymentDate AND ';
        Result := Result + 'BDL.AccountID = PP.BankAccountID AND ';
        Result := Result + 'SameValue(BDL.Amount , PP.PayAmount   ,' + inttostr(GeneralRoundPlaces) +')=1 AND ';
        Result := Result + 'BDL.CompanyName= PP.CompanyName AND ';
        Result := Result + 'BDL.CusID=PP.ClientID AND ';
        Result := Result + 'BDL.TrnsType = "'+CUSTOMER_PREPAYMENT+'" ';
        Result := Result + 'INNER JOIN tblreconciliationwithdrawallines RWL	ON ';
        Result := Result + 'BDL.DepositID = RWL.PaymentID AND ';
        Result := Result + 'BDL.CompanyName = RWL.Payee AND ';
        Result := Result + 'BDL.PaymentDate = RWL.DepositDate AND ';
        Result := Result + 'BDL.AccountID = RWL.AccountID AND ';
        Result := Result + 'SameValue(-BDL.Amount , RWL.Amount  ,' + inttostr(GeneralRoundPlaces) +')=1 AND ';
        Result := Result + 'BDL.TrnsType = RWL.Notes AND ';
        Result := Result + 'BDL.DepositLineID = RWL.DepositLineID ';
        Result := Result + 'INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID ';
        Result := Result + 'Where PP.PrePaymentID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND R.Finished="T" ';
        Result := Result + 'Group By R.ReconciliationID ';
end;

function CustomerPaymentOnHOLDSQL1(const ID: integer):String;
begin
      Result := ' Select '+
            ' R.ReconciliationID '+
            ' From tbldeposits D '+
            ' INNER JOIN tbldepositline DL USING(PaymentID) '+
            ' INNER JOIN tblbankdepositlines BDL ON '+
            ' BDL.PaymentID = D.PaymentID AND '+
            ' BDL.PaymentDate = D.PaymentDate AND '+
            ' BDL.AccountID = D.AccountID AND '+
            ' SameValue(BDL.Amount , D.Amount   ,' + inttostr(GeneralRoundPlaces) +')=1 AND '+
            ' BDL.CompanyName = D.CompanyName AND '+
            ' BDL.CusID = D.CusID AND '+
            ' BDL.TrnsType = "Customer Payment" '+
            ' INNER JOIN tblreconciliationdepositlines RDL	ON '+
            ' BDL.DepositID = RDL.PaymentID AND '+
            ' BDL.CompanyName = RDL.Payee AND '+
            ' BDL.PaymentDate = RDL.DepositDate AND '+
            ' BDL.AccountID = RDL.AccountID AND '+
            ' SameValue(BDL.Amount , RDL.Amount  ,' + inttostr(GeneralRoundPlaces) +')=1 AND '+
            ' BDL.TrnsType = RDL.Notes AND '+
            ' BDL.DepositLineID = RDL.DepositLineID '+
            ' INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID '+
            ' Where D.PaymentID=' + IntToStr(ID) + ' AND D.Deleted<>"T" AND R.Deleted<>"T" AND R.Finished<>"T" '+
            ' Group By R.ReconciliationID ';
end;
function CustomerPaymentOnHOLDSQL2(const ID: integer):String;
begin
      Result := ' Select '+
              ' R.ReconciliationID '+
              ' From tbldeposits D '+
              ' INNER JOIN tbldepositline DL USING(PaymentID) '+
              ' INNER JOIN tblbankdepositlines BDL ON '+
              ' BDL.PaymentID = D.PaymentID AND '+
              ' BDL.PaymentDate = D.PaymentDate AND '+
              ' BDL.AccountID = D.AccountID AND '+
              ' SameValue(BDL.Amount , D.Amount   ,' + inttostr(GeneralRoundPlaces) +')=1 AND '+
              ' BDL.CompanyName = D.CompanyName AND '+
              ' BDL.CusID = D.CusID AND '+
              ' BDL.TrnsType = "Customer Payment" '+
              ' INNER JOIN tblreconciliationwithdrawallines RWL	ON '+
              ' BDL.DepositID = RWL.PaymentID AND '+
              ' BDL.CompanyName = RWL.Payee AND '+
              ' BDL.PaymentDate = RWL.DepositDate AND '+
              ' BDL.AccountID = RWL.AccountID AND '+
              ' SameValue(-BDL.Amount , RWL.Amount  ,' + inttostr(GeneralRoundPlaces) +')=1 AND '+
              ' BDL.TrnsType = RWL.Notes AND '+
              ' BDL.DepositLineID = RWL.DepositLineID '+
              ' INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID '+
              ' Where D.PaymentID=' + IntToStr(ID) + ' AND D.Deleted<>"T" AND R.Deleted<>"T" AND R.Finished<>"T" '+
              ' Group By R.ReconciliationID ';
end;




function DepositOnHOLDSQL1(const ID: integer):String;
begin
      REsult := 'Select R.ReconciliationID '+
            ' FROM tblbankdeposit BD '+
            ' INNER JOIN tblbankdepositlines BDL ON BD.DepositID = BDL.DepositID '+
            ' INNER JOIN tblreconciliationdepositlines RDL ON '+
            ' BD.DepositID = RDL.PaymentID AND '+
            ' BD.DepositDate = RDL.DepositDate AND '+
            ' SameValue(BD.Deposit , RDL.Amount  ,' + inttostr(GeneralRoundPlaces) +')=1 AND '+
            ' RDL.Notes = "Bank Deposit" '+
            ' INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID '+
            ' WHERE BD.DepositID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND BD.Deleted<>"T" AND R.Finished<>"T" '+
            ' GROUP BY R.ReconciliationID; ';
end;
function DepositOnHOLDSQL2(const ID: integer):String;
begin
      REsult := 'Select R.ReconciliationID '+
              ' FROM tblbankdeposit BD '+
              ' INNER JOIN tblbankdepositlines BDL ON BD.DepositID = BDL.DepositID '+
              ' INNER JOIN tblreconciliationwithdrawallines RWL ON '+
              ' BD.DepositID = RWL.PaymentID AND '+
              ' BD.DepositDate = RWL.DepositDate AND '+
              ' SameValue(-BD.Deposit , RWL.Amount  ,' + inttostr(GeneralRoundPlaces) +')=1 AND '+
              ' RWL.Notes = "Bank Deposit" '+
              ' INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID '+
              ' WHERE BD.DepositID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND R.Finished<>"T" '+
              ' GROUP BY R.ReconciliationID; ';
end;

function SupplierPaymentOnHOLDSQL1(const ID: integer):String;
begin
    REsult := ' Select '+
            ' R.ReconciliationID '+
            ' From tblwithdrawal W '+
            ' INNER JOIN tblwithdrawallines WL USING(PaymentID) '+
            ' INNER JOIN tblbankdepositlines BDL ON '+
            ' BDL.PaymentID = W.PaymentID AND '+
            ' BDL.PaymentDate = W.PaymentDate AND '+
            ' BDL.AccountID = W.AccountID AND '+
            ' -BDL.Amount = W.Amount  AND '+
            ' BDL.CompanyName = W.CompanyName AND '+
            ' BDL.CusID = W.SupplierID AND '+
            ' BDL.TrnsType = "Supplier Payment" '+
            ' INNER JOIN tblreconciliationwithdrawallines RWL	ON '+
            ' BDL.DepositID = RWL.PaymentID AND '+
            ' BDL.CompanyName = RWL.Payee AND '+
            ' BDL.PaymentDate = RWL.DepositDate AND '+
            ' BDL.AccountID = RWL.AccountID AND '+
            ' W.Amount = RWL.Amount AND '+
            ' BDL.TrnsType = RWL.Notes AND '+
            ' BDL.DepositLineID = RWL.DepositLineID '+
            ' INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID '+
            ' Where W.PaymentID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND R.Finished<>"T" '+
            ' Group By R.ReconciliationID ';
end;
function SupplierPaymentOnHOLDSQL2(const ID: integer):String;
begin
    REsult := ' Select '+
              ' R.ReconciliationID '+
              ' From tblwithdrawal W '+
              ' INNER JOIN tblwithdrawallines WL USING(PaymentID) '+
              ' INNER JOIN tblbankdepositlines BDL ON '+
              ' BDL.PaymentID = W.PaymentID AND '+
              ' BDL.PaymentDate = W.PaymentDate AND '+
              ' BDL.AccountID = W.AccountID AND '+
              ' -BDL.Amount = W.Amount  AND '+
              ' BDL.CompanyName = W.CompanyName AND '+
              ' BDL.CusID = W.SupplierID AND '+
              ' BDL.TrnsType = "Supplier Payment" '+
              ' INNER JOIN tblreconciliationdepositlines RDL	ON '+
              ' BDL.DepositID = RDL.PaymentID AND '+
              ' BDL.CompanyName = RDL.Payee AND '+
              ' BDL.PaymentDate = RDL.DepositDate AND '+
              ' BDL.AccountID = RDL.AccountID AND '+
              ' -W.Amount = RDL.Amount AND '+
              ' BDL.TrnsType = RDL.Notes AND '+
              ' BDL.DepositLineID = RDL.DepositLineID '+
              ' INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID '+
              ' Where W.PaymentID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND R.Finished<>"T" '+
              ' Group By R.ReconciliationID ';
end;


function JournalEntryOnHOLDSQL1(const ID: integer):String;
begin
      REsult := ' Select R.ReconciliationID '+
            ' From tblgeneraljournal JE '+
            ' INNER JOIN tblgeneraljournaldetails JEL USING(GJID) '+
            ' INNER JOIN tblbankdepositlines BDL ON '+
            ' JEL.GJID = BDL.PaymentID AND '+
            ' JE.TransactionDate = BDL.PaymentDate AND '+
            ' JEL.AccountID=BDL.AccountID AND '+
            ' BDL.Amount=(If(IsNull(JEL.DebitAmountInc),0.00,JEL.DebitAmountInc)-If(IsNull(JEL.CreditAmountInc),0.00,JEL.CreditAmountInc)) AND '+
            ' BDL.TrnsType="Journal Entry" '+
            ' INNER JOIN tblreconciliationwithdrawallines RWL	ON '+
            ' BDL.DepositID = RWL.PaymentID AND '+
            ' BDL.PaymentDate = RWL.DepositDate AND '+
            ' BDL.AccountID = RWL.AccountID AND '+
            ' -BDL.Amount = RWL.Amount AND '+
            ' BDL.TrnsType = RWL.Notes AND '+
            ' BDL.DepositLineID = RWL.DepositLineID '+
            ' INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID '+
            ' Where JE.GJID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND R.Finished<>"T" '+
            ' Group By R.ReconciliationID ';
end;
function JournalEntryOnHOLDSQL2(const ID: integer):String;
begin
      REsult :=         ' Select R.ReconciliationID '+
              ' From tblgeneraljournal JE '+
              ' INNER JOIN tblgeneraljournaldetails JEL USING(GJID) '+
              ' INNER JOIN tblbankdepositlines BDL ON '+
              ' JEL.GJID = BDL.PaymentID AND '+
              ' JE.TransactionDate = BDL.PaymentDate AND '+
              ' JEL.AccountID=BDL.AccountID AND '+
              ' BDL.Amount=(If(IsNull(JEL.DebitAmountInc),0.00,JEL.DebitAmountInc)-If(IsNull(JEL.CreditAmountInc),0.00,JEL.CreditAmountInc)) AND '+
              ' BDL.TrnsType="Journal Entry" '+
              ' INNER JOIN tblreconciliationdepositlines RDL	ON BDL.DepositID = RDL.PaymentID AND '+
              ' BDL.PaymentDate = RDL.DepositDate AND '+
              ' BDL.AccountID = RDL.AccountID AND '+
              ' BDL.Amount = RDL.Amount AND '+
              ' BDL.TrnsType = RDL.Notes AND '+
              ' BDL.DepositLineID = RDL.DepositLineID '+
              ' INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID '+
              ' Where JE.GJID=' + IntToStr(ID) + ' AND R.Deleted<>"T" AND R.Finished<>"T" '+
              ' Group By R.ReconciliationID '
end;
end.






