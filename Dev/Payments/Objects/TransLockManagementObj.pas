unit TransLockManagementObj;

{$I ERP.inc}

interface

{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 05/07/05  1.00.01 DMS  1. Formatted unit's source code.
                        2. Modified CustomerPaymentDeposited function to
                           exclude records that have Deposited field = False.
 14/09/05  1.00.02 DSP  Added OpenDepositedListDetails.
 30/09/05  1.00.03 IJB  Removed procedures GUI OpenDepositedListDetails and
                        OpenReconciledListDetails and replaced them with new
                        non-GUI procedures GetDepositedListSQL and
                        GetReconciledListSQL. New procedures to display these
                        list forms have been added to new library
                        PaymenstsLibGUI.pas

}

uses MyAccess,ERPdbComponents,  DB, ReconciliationFlagsObj, Classes, tcTypes;

type
  TLockManagement = class(TObject)
  private
    foDBConnection: TCustomMyConnection;
    procedure EstablishConnection(Const Tbl: TERPQuery);

    //Cheques
    function ChequeReconciled(const ID: integer; const ReconciliationIDList: TStringList = nil): boolean;
    function ChequeOnHOLD(const ID: integer; const ReconciliationIDList: TStringList = nil): boolean;
    function ChequeDepositReconciled(const ID: integer; const ReconciliationIDList: TStringList = nil): boolean;
    function ChequeDepositOnHOLD(const ID: integer; const ReconciliationIDList: TStringList = nil): boolean;
    //Deposits
    function DepositReconciled(const ID: integer; const ReconciliationIDList: TStringList = nil): boolean;
    function DepositOnHOLD(const ID: integer; const ReconciliationIDList: TStringList = nil): boolean;
    //Deposit Entries
    function DepositEntryReconciled(const ID: integer; const ReconciliationIDList: TStringList = nil): boolean;
    function DepositEntryOnHOLD(const ID: integer; const ReconciliationIDList: TStringList = nil): boolean;
    function DepositEntrySplitReconciled(const ID: integer; const ReconciliationIDList: TStringList = nil): boolean;
    function DepositEntrySplitOnHOLD(const ID: integer; const ReconciliationIDList: TStringList = nil): boolean;
    //Journal Entry
    function JournalEntryReconciled(const ID: integer; const ReconciliationIDList: TStringList = nil): boolean;
    function JournalEntryOnHOLD(const ID: integer; const ReconciliationIDList: TStringList = nil): boolean;
    //Customer Prepayment
    function CustomerPrepaymentDeposited(const ID: integer): boolean;

    function CustomerPrepaymentReconciled(const ID: integer; const ReconciliationIDList: TStringList = nil): boolean;
    function CustomerPrepaymentOnHOLD(const ID: integer; const ReconciliationIDList: TStringList = nil): boolean;
    //Supplier Prepayment
    function SupplierPrepaymentReconciled(const ID: integer; const ReconciliationIDList: TStringList = nil): boolean;
    function SupplierPrepaymentOnHOLD(const ID: integer; const ReconciliationIDList: TStringList = nil): boolean;
    //Customer Payment
    function CustomerPaymentReconciled(const ID: integer; const ReconciliationIDList: TStringList = nil): boolean;
    function CustomerPaymentOnHOLD(const ID: integer; const ReconciliationIDList: TStringList = nil): boolean;
    //Supplier Payment
    function SupplierPaymentReconciled(const ID: integer; const ReconciliationIDList: TStringList = nil): boolean;
    function SupplierPaymentOnHOLD(const ID: integer; const ReconciliationIDList: TStringList = nil): boolean;

    procedure GetReconciledDetails(const ID: integer; const TranType: TRecTranType;
      const ReconciliationIDList: TStringList);

  public
    Procedure LogSQLs;
    function CustomerPrepaymentApplied(const ID: integer): boolean;
    function SupplierPrepaymentApplied(const ID: integer): boolean;
    function CashSale_Locked(const SaleID: integer; var LockType: TTransLockType): boolean;
    function CustPayment_UndeleteLocked(const PaymentID: integer): boolean;
    function IsChequeLocked(const ID: integer; var LockType: TTransLockType): boolean;
    function IsCustomerPaymentLocked(const ID: integer; var LockType: TTransLockType): boolean;
    function CustomerPaymentDeposited(const ID: integer): boolean;
    function IsCustomerPrepaymentLocked(const ID: integer; var LockType: TTransLockType): boolean;
    function IsDepositLocked(const ID: integer; var LockType: TTransLockType): boolean;
    function IsDepositEntryLocked(const ID: integer; var LockType: TTransLockType): boolean;
    function IsJournalEntryLocked(const ID: integer; var LockType: TTransLockType): boolean;
    function IsRelatedCustomerUsed(const ClientID: integer): boolean;
    function IsSupplierPaymentLocked(const ID: integer; var LockType: TTransLockType): boolean;
    function IsSupplierPrepaymentLocked(const ID: integer; var LockType: TTransLockType): boolean;
    function POHasPayment_Locked(const POID: integer; var LockType: TTransLockType): boolean;
    function IsPOApproved(const POID: integer): boolean;
    function SaleHasPayment_Locked(const SaleID: integer; var LockType: TTransLockType): boolean;
    function SuppPayment_UndeleteLocked(const PaymentID: integer): boolean;
    procedure CustPaymentsAdjust(const Undeleted: boolean; const SaleID, CurrentPaymentID: integer;
      const PaymentAmount, AmountDue: currency);
    procedure SuppPaymentsAdjust(const Undeleted: boolean; const POID, CurrentPaymentID: integer;
      const PaymentAmount, AmountDue: currency);
    procedure UpdateCustPrepaymentBalance(const PrepaymentID: integer; const PaymentAmount: currency);
    procedure UpdateLastPOBalance(const POID: integer; const FromMultisite: boolean = false);
    procedure UpdateLastSaleBalance(const SaleID: integer; const FromMultisite: boolean = false);
    procedure UpdateSuppPrepaymentBalance(const PrepaymentID: integer; const PaymentAmount: currency);
    property Connection: TCustomMyConnection read foDBConnection write foDBConnection;
    { Returns SQL to be used by DepositedListGUI qryMainSub }
    function GetDepositedListSQL(const PaymentID: integer; const TranType: string=''): string;
    { Returns the SQL to be used on TransRecListGUI qryMain }
    function GetReconciledListSQL(const ID: integer; const TranType: string): string;

  end;

implementation

uses SysUtils, StrUtils, CommonDbLib, CommonLib, tcConst,
  TransLockManagementSQLs;

procedure TLockManagement.EstablishConnection(Const Tbl: TERPQuery);
begin
  with Tbl do begin
    if Assigned(foDBConnection) then begin
      Connection := foDBConnection;
    end else begin
      Connection := CommonDbLib.GetSharedMyDacConnection;
    end;
  end;
end;

procedure TLockManagement.CustPaymentsAdjust(const Undeleted: boolean; const SaleID, CurrentPaymentID: integer;
  const PaymentAmount, AmountDue: currency);
var
  qryPaymentOnSale: TERPQuery;
begin
  qryPaymentOnSale := TERPQuery.Create(nil);

  try
    {Details}
    EstablishConnection(qryPaymentOnSale);
    with qryPaymentOnSale do begin
      Close;
      Sql.Clear;
      Sql.Add('SELECT PaymentLineID,tbldepositline.PaymentID, SaleID, Payment, AmountOutstanding, AmountDue, PaidInFull ');
      Sql.Add('FROM tbldepositline Inner Join tbldeposits Using(PaymentID) ');
      Sql.Add('Where SaleID = ' + IntToStr(SaleID) + ' AND tbldepositline.PaymentID > ' +
        IntToStr(CurrentPaymentID) + ' AND tbldeposits.Deleted = "F" ;');
      //Prepared := true;
      Open;
    end;
    qryPaymentOnSale.First;
    while not qryPaymentOnSale.Eof do begin
      qryPaymentOnSale.Edit;


      if Undeleted then begin
        qryPaymentOnSale.FieldByName('AmountOutstanding').asCurrency :=
          qryPaymentOnSale.FieldByName('AmountOutstanding').asCurrency - PaymentAmount;
        qryPaymentOnSale.FieldByName('AmountDue').asCurrency :=
          qryPaymentOnSale.FieldByName('AmountDue').asCurrency - PaymentAmount;
      end else begin
        qryPaymentOnSale.FieldByName('AmountOutstanding').asCurrency :=
          qryPaymentOnSale.FieldByName('AmountOutstanding').asCurrency + PaymentAmount;
        qryPaymentOnSale.FieldByName('AmountDue').asCurrency :=
          qryPaymentOnSale.FieldByName('AmountDue').asCurrency + PaymentAmount;
      end;


      if (qryPaymentOnSale.FieldByName('AmountOutstanding').asCurrency = 0.00) then begin
        qryPaymentOnSale.FieldByName('PaidInFull').AsString := 'Yes';
      end else begin
        qryPaymentOnSale.FieldByName('PaidInFull').AsString := 'No';
      end;

      qryPaymentOnSale.Post;
      qryPaymentOnSale.Next;
    end;
    {Header}
    with qryPaymentOnSale do begin
      Close;
      Sql.Clear;
      Sql.Add('SELECT tbldeposits.PaymentID,tbldeposits.Balance');
      Sql.Add('FROM tbldeposits  Inner Join tbldepositline Using(PaymentID) ');
      Sql.Add('Where SaleID = ' + IntToStr(SaleID) + ' AND tbldepositline.PaymentID > ' +
        IntToStr(CurrentPaymentID) + ' AND tbldeposits.Deleted = "F" ');
      Sql.Add('Group By PaymentID ;');
      //Prepared := true;
      Open;
    end;
    qryPaymentOnSale.First;
    while not qryPaymentOnSale.Eof do begin
      qryPaymentOnSale.Edit;

      if Undeleted then begin
        qryPaymentOnSale.FieldByName('Balance').asCurrency :=
          qryPaymentOnSale.FieldByName('Balance').asCurrency - PaymentAmount;
      end else begin
        qryPaymentOnSale.FieldByName('Balance').asCurrency :=
          qryPaymentOnSale.FieldByName('Balance').asCurrency + PaymentAmount;
      end;

      qryPaymentOnSale.Post;
      qryPaymentOnSale.Next;
    end;

  finally
    FreeAndNil(qryPaymentOnSale);
  end;
end;

procedure TLockManagement.UpdateLastSaleBalance(const SaleID: integer; const FromMultisite: boolean = false);
var
  tblSalesDetails: TERPQuery;
  qryPaymentOnSale: TERPQuery;
  AmountOutstanding: currency;
  NoPayments: boolean;
begin
  tblSalesDetails := TERPQuery.Create(nil);
  qryPaymentOnSale := TERPQuery.Create(nil);
  NoPayments := false;
  try
    {Details}
    EstablishConnection(tblSalesDetails);
    EstablishConnection(qryPaymentOnSale);

    with qryPaymentOnSale do begin
      Close;
      Sql.Clear;
      Sql.Add('SELECT PaymentLineID,tbldepositline.PaymentID, SaleID, Payment,OriginalAmount, AmountOutstanding, AmountDue, PaidInFull ');
      Sql.Add('FROM tbldepositline Inner Join tbldeposits Using(PaymentID) ');
      Sql.Add('Where SaleID = ' + IntToStr(SaleID) + ' AND tbldeposits.Deleted = "F" ;');
      //Prepared := true;
      Open;
    end;
    if qryPaymentOnSale.RecordCount = 0 then NoPayments := true;
    qryPaymentOnSale.Last;
    AmountOutstanding := qryPaymentOnSale.FieldByName('AmountOutstanding').asCurrency;

    with tblSalesDetails do begin
      Close;
      Sql.Clear;
      Sql.Add('SELECT * FROM tblsales Where SaleID = ' + IntToStr(SaleID) + ';');
      //Prepared := true;
      Open;
    end;

    with tblSalesDetails do begin
      tblSalesDetails.Last;
      tblSalesDetails.Edit;

      if NoPayments then begin
        tblSalesDetails.FieldByName('Payment').asCurrency := 0.00;
      end else begin
        tblSalesDetails.FieldByName('Payment').asCurrency := tblSalesDetails.FieldByName('TotalAmountInc').asCurrency -
          AmountOutstanding;
      end;

      tblSalesDetails.FieldByName('Balance').asCurrency := tblSalesDetails.FieldByName('TotalAmountInc').asCurrency -
        tblSalesDetails.FieldByName('Payment').asCurrency;

      if (tblSalesDetails.FieldByName('Balance').asCurrency = 0.00) and
        (tblSalesDetails.FieldByName('TotalAmountInc').asCurrency <> 0.00) then begin
        tblSalesDetails.FieldByName('Paid').AsString := 'T';
      end else begin
        tblSalesDetails.FieldByName('Paid').AsString := 'F';
      end;
      if not FromMultisite then begin
        tblSalesDetails.FieldByName('EditedFlag').AsString := 'T';
      end;
      tblSalesDetails.Post;
    end;
  finally
    FreeAndNil(tblSalesDetails);
    FreeAndNil(qryPaymentOnSale);
  end;
end;

procedure TLockManagement.SuppPaymentsAdjust(const Undeleted: boolean; const POID, CurrentPaymentID: integer;
  const PaymentAmount, AmountDue: currency);
var
  qryPaymentOnPO: TERPQuery;
begin
  qryPaymentOnPO := TERPQuery.Create(nil);

  try
    {Details}
    EstablishConnection(qryPaymentOnPO);
    with qryPaymentOnPO do begin
      Close;
      Sql.Clear;
      Sql.Add('SELECT PaymentLineID,tblwithdrawallines.PaymentID, POID, Payment, AmountOutstanding, AmountDue, PaidInFull ');
      Sql.Add('FROM tblwithdrawallines Inner Join tblwithdrawal Using(PaymentID) ');
      Sql.Add('Where POID = ' + IntToStr(POID) + ' AND tblwithdrawallines.PaymentID > ' +
        IntToStr(CurrentPaymentID) + ' AND tblwithdrawal.Deleted = "F" ;');
      //Prepared := true;
      Open;
    end;
    qryPaymentOnPO.First;
    while not qryPaymentOnPO.Eof do begin
      qryPaymentOnPO.Edit;
      if Undeleted then begin
        qryPaymentOnPO.FieldByName('AmountOutstanding').asCurrency :=
          qryPaymentOnPO.FieldByName('AmountOutstanding').asCurrency - PaymentAmount;
        qryPaymentOnPO.FieldByName('AmountDue').asCurrency :=
          qryPaymentOnPO.FieldByName('AmountDue').asCurrency - PaymentAmount;
      end else begin
        qryPaymentOnPO.FieldByName('AmountOutstanding').asCurrency :=
          qryPaymentOnPO.FieldByName('AmountOutstanding').asCurrency + PaymentAmount;
        qryPaymentOnPO.FieldByName('AmountDue').asCurrency :=
          qryPaymentOnPO.FieldByName('AmountDue').asCurrency + PaymentAmount;
      end;
      if (qryPaymentOnPO.FieldByName('AmountOutstanding').asCurrency = 0.00) then begin
        qryPaymentOnPO.FieldByName('PaidInFull').AsString := 'Yes';
      end else begin
        qryPaymentOnPO.FieldByName('PaidInFull').AsString := 'No';
      end;
      qryPaymentOnPO.Post;
      qryPaymentOnPO.Next;
    end;
    {Header}
    with qryPaymentOnPO do begin
      Close;
      Sql.Clear;
      Sql.Add('SELECT tblwithdrawal.PaymentID,tblwithdrawal.Balance');
      Sql.Add('FROM tblwithdrawal  Inner Join tblwithdrawallines Using(PaymentID) ');
      Sql.Add('Where POID = ' + IntToStr(POID) + ' AND tblwithdrawallines.PaymentID > ' +
        IntToStr(CurrentPaymentID) + ' AND tblwithdrawal.Deleted = "F" ');
      Sql.Add('Group By PaymentID ;');
      //Prepared := true;
      Open;
    end;
    qryPaymentOnPO.First;
    while not qryPaymentOnPO.Eof do begin
      qryPaymentOnPO.Edit;

      if Undeleted then begin
        qryPaymentOnPO.FieldByName('Balance').asCurrency := qryPaymentOnPO.FieldByName('Balance').asCurrency + PaymentAmount;
      end else begin
        qryPaymentOnPO.FieldByName('Balance').asCurrency := qryPaymentOnPO.FieldByName('Balance').asCurrency - PaymentAmount;
      end;

      qryPaymentOnPO.Post;
      qryPaymentOnPO.Next;
    end;

  finally
    FreeAndNil(qryPaymentOnPO);
  end;
end;

procedure TLockManagement.UpdateLastPOBalance(const POID: integer; const FromMultisite: boolean = false);
var
  tblPODetails: TERPQuery;
  qryPaymentOnPO: TERPQuery;
  AmountOutstanding: currency;
  NoPayments: boolean;
begin
  tblPODetails := TERPQuery.Create(nil);
  qryPaymentOnPO := TERPQuery.Create(nil);
  NoPayments := false;
  try
    {Details}
    EstablishConnection(tblPODetails);
    EstablishConnection(qryPaymentOnPO);

    with qryPaymentOnPO do begin
      Close;
      Sql.Clear;
      Sql.Add('SELECT PaymentLineID,tblwithdrawallines.PaymentID, POID, Payment, OriginalAmount, AmountOutstanding, AmountDue, PaidInFull ');
      Sql.Add('FROM tblwithdrawallines Inner Join tblwithdrawal Using(PaymentID) ');
      Sql.Add('Where POID = ' + IntToStr(POID) + ' AND tblwithdrawal.Deleted = "F" ;');
      //Prepared := true;
      Open;
    end;

    if qryPaymentOnPO.RecordCount = 0 then NoPayments := true;
    qryPaymentOnPO.Last;
    AmountOutstanding := qryPaymentOnPO.FieldByName('AmountOutstanding').asCurrency;

    with tblPODetails do begin
      Close;
      Sql.Clear;
      Sql.Add('SELECT * FROM tblpurchaseorders Where PurchaseOrderID = ' + IntToStr(POID) + ';');
      //Prepared := true;
      Open;
    end;

    with tblPODetails do begin
      tblPODetails.Last;
      tblPODetails.Edit;

      if NoPayments then begin
        tblPODetails.FieldByName('Payment').asCurrency := 0.00;
      end else begin
        tblPODetails.FieldByName('Payment').asCurrency := tblPODetails.FieldByName('TotalAmountInc').asCurrency -
          AmountOutstanding;
      end;

      tblPODetails.FieldByName('Balance').asCurrency := tblPODetails.FieldByName('TotalAmountInc').asCurrency -
        tblPODetails.FieldByName('Payment').asCurrency;

      if (tblPODetails.FieldByName('Balance').asCurrency = 0.00) and
        (tblPODetails.FieldByName('TotalAmountInc').asCurrency <> 0.00) then begin
        tblPODetails.FieldByName('Paid').AsString := 'T';
      end else begin
        tblPODetails.FieldByName('Paid').AsString := 'F';
      end;

      if not FromMultisite then begin
        tblPODetails.FieldByName('EditedFlag').AsString := 'T';
      end;
      tblPODetails.Post;
    end;
  finally
    FreeAndNil(tblPODetails);
    FreeAndNil(qryPaymentOnPO);
  end;
end;

function TLockManagement.SaleHasPayment_Locked(const SaleID: integer; var LockType: TTransLockType): boolean;
var
  qryTemp: TERPQuery;
begin
  Result := false;
  qryTemp := TERPQuery.Create(nil);
  try
    {Details}
    EstablishConnection(qryTemp);
    with qryTemp do begin
      Close;
      Sql.Clear;
      Sql.Add('SELECT tbldepositline.SaleID,tbldepositline.PaymentID ');
      Sql.Add('From tbldeposits INNER JOIN tbldepositline Using(PaymentID) ');
      Sql.Add('Where tbldeposits.Deleted <> "T" AND SaleID = ' + IntToStr(SaleID) + ';');
      Open;

      if RecordCount > 0 then begin
        Result := true;
        LockType := ltPaymentApplied;
      end;
    end;

  finally
    FreeAndNil(qryTemp);
  end;
end;
function TLockManagement.IsPOApproved(const POID: integer): boolean;
begin
  With TEmpMyQuery do try
    SQL.add('Select Approved from tblPurchaseorders where purchaseORderID = ' + inttostr(POID));
    open;
    result := Fieldbyname('Approved').asBoolean;
  finally
    closenFree;
  end;
end;

function TLockManagement.POHasPayment_Locked(const POID: integer; var LockType: TTransLockType): boolean;
var
  qryTemp: TERPQuery;
begin
  Result := false;
  qryTemp := TERPQuery.Create(nil);
  try
    {Details}
    EstablishConnection(qryTemp);
    with qryTemp do begin
      Close;
      Sql.Clear;
      Sql.Add('SELECT tblwithdrawallines.POID,tblwithdrawallines.PaymentID  ');
      Sql.Add('From tblwithdrawal INNER JOIN tblwithdrawallines Using(PaymentID) ');
      Sql.Add('Where tblwithdrawal.Deleted <> "T" AND POID = ' + IntToStr(POID) + ';');
      //Prepared := true;
      Open;

      if RecordCount > 0 then begin
        Result := true;
        LockType := ltPaymentApplied;
      end;
    end;

  finally
    FreeAndNil(qryTemp);
  end;
end;

function TLockManagement.CustPayment_UndeleteLocked(const PaymentID: integer): boolean;
var
  qryPayment: TERPQuery;
  qrySales: TERPQuery;
begin
  Result := false;
  qryPayment := TERPQuery.Create(nil);
  qrySales := TERPQuery.Create(nil);
  try
    {Details}
    EstablishConnection(qryPayment);
    EstablishConnection(qrySales);
    with qryPayment do begin
      Close;
      Sql.Clear;
      Sql.Add('SELECT PaymentLineID,tbldepositline.PaymentID,SaleID,PrePaymentID,OriginalAmount,InvoiceDate,TrnType ');
      Sql.Add('FROM tbldeposits INNER JOIN tbldepositline Using(PaymentID) ');
      Sql.Add('WHERE tbldepositline.PaymentID = ' + IntToStr(PaymentID) + ';');
      //Prepared := true;
      Open;
    end;

    if qryPayment.RecordCount <> 0 then begin
      qryPayment.First;
      while not qryPayment.Eof do begin
        if Trim(qryPayment.FieldByName('TrnType').AsString) <> 'Prepayment' then begin
          {Sales}
          with qrySales do begin
            Close;
            Sql.Clear;
            Sql.Add('SELECT SaleID,TotalAmountInc,SaleDate,Balance FROM tblsales WHERE SaleID = ' +
              IntToStr(qryPayment.FieldByName('SaleID').AsInteger) + ';');
            //Prepared := true;
            Open;
          end;

          if (RoundCurrency(qryPayment.FieldByName('OriginalAmount').AsCurrency) <>
            RoundCurrency(qrySales.FieldByName('TotalAmountInc').AsCurrency)) then begin
            Result := true;
          end;

          if (qryPayment.FieldByName('InvoiceDate').AsDateTime <> qrySales.FieldByName('SaleDate').AsDateTime) then begin
            Result := true;
          end;
        end else begin
          {Prepayment}
          with qrySales do begin
            Close;
            Sql.Clear;
            Sql.Add('SELECT PrePaymentID,PayAmount,PrePaymentDate,Balance FROM tblprepayments WHERE Deleted="F" And PrepaymentID = ' +
              IntToStr(qryPayment.FieldByName('PrePaymentID').AsInteger) + ';');
            //Prepared := true;
            Open;
          end;

          if (RoundCurrency(qryPayment.FieldByName('OriginalAmount').AsCurrency) <>
            RoundCurrency(-qrySales.FieldByName('PayAmount').AsCurrency)) then begin
            Result := true;
          end;

          if (qryPayment.FieldByName('InvoiceDate').AsDateTime <> qrySales.FieldByName('PrePaymentDate').AsDateTime) then
          begin
            Result := true;
          end;
        end;
        qryPayment.Next;
      end;
    end;
  finally
    FreeAndNil(qryPayment);
    FreeAndNil(qrySales);
  end;
end;


function TLockManagement.SuppPayment_UndeleteLocked(const PaymentID: integer): boolean;
var
  qryPayment: TERPQuery;
  qryPO: TERPQuery;
  TotalAmount: double;
begin
  Result := false;
  qryPayment := TERPQuery.Create(nil);
  qryPO := TERPQuery.Create(nil);
  try
    {Details}
    EstablishConnection(qryPayment);
    EstablishConnection(qryPO);

    with qryPayment do begin
      Close;
      Sql.Clear;
      Sql.Add('SELECT PaymentLineID,tblwithdrawallines.PaymentID,POID,PrePaymentID,OriginalAmount,OrderDate,TrnType ');
      Sql.Add('FROM tblwithdrawal INNER JOIN tblwithdrawallines Using(PaymentID) ');
      Sql.Add('WHERE tblwithdrawallines.PaymentID = ' + IntToStr(PaymentID) + ';');
      //Prepared := true;
      Open;
    end;

    if qryPayment.RecordCount <> 0 then begin
      qryPayment.First;
      while not qryPayment.Eof do begin
        if Trim(qryPayment.FieldByName('TrnType').AsString) <> 'Prepayment' then begin
          {PO & Bill /Credit}
          with qryPO do begin
            Close;
            Sql.Clear;
            Sql.Add('SELECT  PurchaseOrderID ,IsCredit, TotalAmountInc FROM tblpurchaseorders WHERE PurchaseOrderID = ' +
              IntToStr(qryPayment.FieldByName('POID').AsInteger) + ';');
            //Prepared := true;
            Open;
          end;
          TotalAmount := qryPO.FieldByName('TotalAmountInc').AsCurrency;

          if qryPO.FieldByName('IsCredit').AsBoolean then begin
            TotalAmount := TotalAmount * -1;
          end;

          if (RoundCurrency(qryPayment.FieldByName('OriginalAmount').AsCurrency) <> RoundCurrency(TotalAmount)) then begin
            Result := true;
          end;
        end else begin
          {Prepayment}
          with qryPO do begin
            Close;
            Sql.Clear;
            Sql.Add('SELECT PrePaymentID,PayAmount,PrePaymentDate,Balance FROM tblprepayments WHERE Deleted="F" And PrepaymentID = ' +
              IntToStr(qryPayment.FieldByName('PrepaymentID').AsInteger) + ';');
            //Prepared := true;
            Open;
          end;

          if (RoundCurrency(qryPayment.FieldByName('OriginalAmount').AsCurrency) <>
            RoundCurrency(-qryPO.FieldByName('PayAmount').AsCurrency)) then begin
            Result := true;
          end;

          if (qryPayment.FieldByName('OrderDate').AsDateTime <> qryPO.FieldByName('PrePaymentDate').AsDateTime) then begin
            Result := true;
          end;
        end;

        qryPayment.Next;
      end;
    end;
  finally
    FreeAndNil(qryPayment);
    FreeAndNil(qryPO);
  end;
end;


function TLockManagement.CashSale_Locked(const SaleID: integer;var LockType: TTransLockType): boolean;
var
  qryTemp: TERPQuery;
begin
  Result := false;
  qryTemp := TERPQuery.Create(nil);
  try
    {Details}
    EstablishConnection(qryTemp);
    with qryTemp do begin
      SQL.Add('select SP.PaymentId ');
      SQL.Add('from tblsalespayments sp ');
      SQL.Add('inner join  tblbankdepositlines bdl on  bdl.TrnsType  in ( "Cash Sale" , "POS Cash Sale", "Refund")  and sp.saleid = bdl.TransId  ');
      SQL.Add('inner join tblbankdeposit bd on bd.DepositID = bdl.DepositId');
      SQL.Add('where sp.saleid = ' + IntToStr(SaleID));
      SQL.Add('and bd.Deleted <> "T"');
      SQL.add('union all');
      SQL.Add('select SP.PaymentId ');
      SQL.Add('from tblsalespayments sp ');
      SQL.Add('inner join  tblbankdepositlines bdl on  bdl.TrnsType in ("Cash Sale", "Refund") and sp.saleid = bdl.TransId  ');
      SQL.Add('inner join tblbankdeposit bd on bd.DepositID = bdl.DepositId');
      SQL.add('inner join tblbankdepositlinessales bdls on bdls.paymentid = sp.Paymentid');
      SQL.Add('where sp.saleid = ' + IntToStr(SaleID));
      SQL.Add('and bd.Deleted <> "T"');
      (*SQL.add('select sp.PaymentId from tblsalespayments sp ');
      SQL.add('inner join tblbankdepositlinessales bdls on bdls.paymentid = sp.Paymentid');
      SQL.Add('where sp.saleid = ' + IntToStr(SaleID));*)
      Open;
      if qryTemp.RecordCount > 0 then begin
        (*If (qryTemp.Fields[0].AsInteger >0) then Begin*)
          Result := true;
          LockType := ltDeposited;
        (*end;*)
      end;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;


procedure TLockManagement.UpdateCustPrepaymentBalance(const PrepaymentID: integer; const PaymentAmount: currency);
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTemp);
    with qryTemp do begin
      Close;
      Sql.Clear;
      Sql.Add('SELECT * FROM `tblprepayments` ');
      Sql.Add('Where Deleted <> "T" AND PrePaymentID = ' + IntToStr(PrepaymentID) + ';');
      //Prepared := true;
      Open;

      if not qryTemp.IsEmpty then begin
        qryTemp.Edit;
        qryTemp.FieldByName('Payment').asCurrency := RoundCurrency(-(qryTemp.FieldByName('Payment').asCurrency) - PaymentAmount);
        qryTemp.FieldByName('Balance').asCurrency := RoundCurrency(qryTemp.FieldByName('PayAmount').asCurrency -
          qryTemp.FieldByName('Payment').asCurrency);
        if (qryTemp.FieldByName('Balance').asCurrency = 0.00) and (qryTemp.FieldByName('PayAmount').asCurrency <> 0.00) then
        begin
          qryTemp.FieldByName('Paid').AsString := 'T';
        end else begin
          qryTemp.FieldByName('Paid').AsString := 'F';
        end;
        qryTemp.FieldByName('EditedFlag').AsString := 'T';
        qryTemp.Post;
      end;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

procedure TLockManagement.UpdateSuppPrepaymentBalance(const PrepaymentID: integer; const PaymentAmount: currency);
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTemp);
    with qryTemp do begin
      Close;
      Sql.Clear;
      Sql.Add('SELECT * FROM `tblprepayments` ');
      Sql.Add('Where Deleted <> "T" AND PrePaymentID = ' + IntToStr(PrepaymentID) + ';');
      //Prepared := true;
      Open;

      if not qryTemp.IsEmpty then begin
        qryTemp.Edit;
        qryTemp.FieldByName('Payment').asCurrency := RoundCurrency(-(qryTemp.FieldByName('Payment').asCurrency) - PaymentAmount);
        qryTemp.FieldByName('Balance').asCurrency := RoundCurrency(qryTemp.FieldByName('PayAmount').asCurrency -
          qryTemp.FieldByName('Payment').asCurrency);
        if (qryTemp.FieldByName('Balance').asCurrency = 0.00) and (qryTemp.FieldByName('PayAmount').asCurrency <> 0.00) then
        begin
          qryTemp.FieldByName('Paid').AsString := 'T';
        end else begin
          qryTemp.FieldByName('Paid').AsString := 'F';
        end;
        qryTemp.FieldByName('EditedFlag').AsString := 'T';
        qryTemp.Post;
      end;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function TLockManagement.IsChequeLocked(const ID: integer; var LockType: TTransLockType): boolean;
begin
  Result := false;
  LockType := ltNone;
  {CHEQUES}
  if not Result then begin
    if ChequeReconciled(ID) then begin
      {RECONCILED}
      Result := true;
      LockType := ltReconciled;
    end;
  end;
  if not Result then begin
    if ChequeOnHOLD(ID) then begin
      {ON HOLD}
      Result := true;
      LockType := ltOnHoldRec;
    end;
  end;
  {CHEQUE DEPOSITS}
  if not Result then begin
    if ChequeDepositReconciled(ID) then begin
      {RECONCILED}
      Result := true;
      LockType := ltReconciled;
    end;
  end;
  if not Result then begin
    if ChequeDepositOnHOLD(ID) then begin
      {ON HOLD}
      Result := true;
      LockType := ltOnHoldRec;
    end;
  end;
end;


function TLockManagement.ChequeReconciled(const ID: integer; const ReconciliationIDList: TStringList): boolean;
var
  qryTest: TERPQuery;
begin
  Result := false;
  qryTest := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTest);
    with qryTest do begin
      Sql.Clear;
      Sql.Add(ChequeReconciledSQL1(ID));
      Open;
      if RecordCount >= 1 then begin
        Result := true;
        if (ReconciliationIDList <> nil) then begin
          qryTest.First;
          while not qryTest.Eof do begin
            ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
            qryTest.Next;
          end;
        end;
      end;
      if (not Result) or (ReconciliationIDList <> nil) then begin
        Sql.Clear;
        Sql.Add(ChequeReconciledSQL2(ID));
        Open;
        if RecordCount >= 1 then begin
          Result := true;
          if (ReconciliationIDList <> nil) then begin
            qryTest.First;
            while not qryTest.Eof do begin
              ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
              qryTest.Next;
            end;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(qryTest)
  end;
end;


function TLockManagement.ChequeOnHOLD(const ID: integer; const ReconciliationIDList: TStringList): boolean;
var
  qryTest: TERPQuery;
begin
  Result := false;
  qryTest := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTest);
    with qryTest do begin
      Sql.Clear;
      SQL.add(ChequeOnHOLDSQL1(ID));
      Open;
      if RecordCount >= 1 then begin
        Result := true;
        if (ReconciliationIDList <> nil) then begin
          qryTest.First;
          while not qryTest.Eof do begin
            ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
            qryTest.Next;
          end;
        end;
      end;
      if (not Result) or (ReconciliationIDList <> nil) then begin
        Sql.Clear;
        SQL.add(ChequeOnHOLDSQL2(ID));
        Open;
        if RecordCount >= 1 then begin
          Result := true;
          if (ReconciliationIDList <> nil) then begin
            qryTest.First;
            while not qryTest.Eof do begin
              ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
              qryTest.Next;
            end;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(qryTest)
  end;
end;


function TLockManagement.ChequeDepositOnHOLD(const ID: integer; const ReconciliationIDList: TStringList): boolean;
var
  qryTest: TERPQuery;
begin
  Result := false;
  qryTest := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTest);
    with qryTest do begin
      Sql.Clear;
      SQL.add(ChequeDepositOnHOLDSQL1(ID));
      Open;
      if RecordCount >= 1 then begin
        Result := true;
        if (ReconciliationIDList <> nil) then begin
          qryTest.First;
          while not qryTest.Eof do begin
            ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
            qryTest.Next;
          end;
        end;
      end;
      if (not Result) or (ReconciliationIDList <> nil) then begin
        Sql.Clear;
        SQL.add(ChequeDepositOnHOLDSQL2(ID));
        Open;
        if RecordCount >= 1 then begin
          Result := true;
          if (ReconciliationIDList <> nil) then begin
            qryTest.First;
            while not qryTest.Eof do begin
              ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
              qryTest.Next;
            end;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(qryTest)
  end;
end;

function TLockManagement.ChequeDepositReconciled(const ID: integer; const ReconciliationIDList: TStringList): boolean;
var
  qryTest: TERPQuery;
begin
  Result := false;
  qryTest := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTest);
    with qryTest do begin
      Sql.Clear;
      SQL.add(ChequeDepositReconciledSQL1(ID));
      Open;
      if RecordCount >= 1 then begin
        Result := true;
        if (ReconciliationIDList <> nil) then begin
          qryTest.First;
          while not qryTest.Eof do begin
            ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
            qryTest.Next;
          end;
        end;
      end;
      if (not Result) or (ReconciliationIDList <> nil) then begin
        Sql.Clear;
        SQL.add(ChequeDepositReconciledSQL2(ID));
        Open;
        if RecordCount >= 1 then begin
          Result := true;
          if (ReconciliationIDList <> nil) then begin
            qryTest.First;
            while not qryTest.Eof do begin
              ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
              qryTest.Next;
            end;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(qryTest)
  end;
end;


function TLockManagement.IsDepositEntryLocked(const ID: integer; var LockType: TTransLockType): boolean;
begin
  Result := false;
  LockType := ltNone;
  if not Result then begin
    if DepositEntryReconciled(ID) then begin
      {RECONCILED}
      Result := true;
      LockType := ltReconciled;
    end;
  end;
  if not Result then begin
    if DepositEntryOnHOLD(ID) then begin
      {ON HOLD}
      Result := true;
      LockType := ltOnHoldRec;
    end;
  end;
  if not Result then begin
    if DepositEntrySplitReconciled(ID) then begin
      {RECONCILED}
      Result := true;
      LockType := ltReconciled;
    end;
  end;
  if not Result then begin
    if DepositEntrySplitOnHOLD(ID) then begin
      {ON HOLD}
      Result := true;
      LockType := ltOnHoldRec;
    end;
  end;
end;

function TLockManagement.IsDepositLocked(const ID: integer; var LockType: TTransLockType): boolean;
begin
  Result := false;
  LockType := ltNone;
  if not Result then begin
    if DepositReconciled(ID) then begin
      {RECONCILED}
      Result := true;
      LockType := ltReconciled;
    end;
  end;
  if not Result then begin
    if DepositOnHOLD(ID) then begin
      {ON HOLD}
      Result := true;
      LockType := ltOnHoldRec;
    end;
  end;
end;

function TLockManagement.DepositOnHOLD(const ID: integer; const ReconciliationIDList: TStringList): boolean;
var
  qryTest: TERPQuery;
begin
  Result := false;
  qryTest := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTest);
    with qryTest do begin
      Sql.Clear;
      Sql.Add(DepositOnHOLDSQL1(ID));
      Open;
      if RecordCount >= 1 then begin
        Result := true;
        if (ReconciliationIDList <> nil) then begin
          qryTest.First;
          while not qryTest.Eof do begin
            ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
            qryTest.Next;
          end;
        end;
      end;
      if (not Result) or (ReconciliationIDList <> nil) then begin
        Sql.Clear;
        Sql.Add(DepositOnHOLDSQL2(ID));
        Open;
        if RecordCount >= 1 then begin
          Result := true;
          if (ReconciliationIDList <> nil) then begin
            qryTest.First;
            while not qryTest.Eof do begin
              ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
              qryTest.Next;
            end;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(qryTest)
  end;
end;


function TLockManagement.DepositReconciled(const ID: integer; const ReconciliationIDList: TStringList): boolean;
var
  qryTest: TERPQuery;
begin
  Result := false;
  qryTest := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTest);
    with qryTest do begin
      Sql.Clear;
      SQL.add(DepositReconciledSQL1(ID));
      Open;
      if RecordCount >= 1 then begin
        Result := true;
        if (ReconciliationIDList <> nil) then begin
          qryTest.First;
          while not qryTest.Eof do begin
            ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
            qryTest.Next;
          end;
        end;
      end;
      if (not Result) or (ReconciliationIDList <> nil) then begin
        Sql.Clear;
        SQL.add(DepositReconciledSQL2(ID));
        Open;
        if RecordCount >= 1 then begin
          Result := true;
          if (ReconciliationIDList <> nil) then begin
            qryTest.First;
            while not qryTest.Eof do begin
              ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
              qryTest.Next;
            end;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(qryTest)
  end;
end;

function TLockManagement.DepositEntryOnHOLD(const ID: integer; const ReconciliationIDList: TStringList): boolean;
var
  qryTest: TERPQuery;
begin
  Result := false;
  qryTest := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTest);
    with qryTest do begin
      Sql.Clear;
      Sql.Add(DepositEntryOnHOLDSQL1(ID));
      Open;
      if RecordCount >= 1 then begin
        Result := true;
        if (ReconciliationIDList <> nil) then begin
          qryTest.First;
          while not qryTest.Eof do begin
            ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
            qryTest.Next;
          end;
        end;
      end;
      if (not Result) or (ReconciliationIDList <> nil) then begin
        Sql.Clear;
        Sql.Add(DepositEntryOnHOLDSQL2(ID));
        Open;
        if RecordCount >= 1 then begin
          Result := true;
          if (ReconciliationIDList <> nil) then begin
            qryTest.First;
            while not qryTest.Eof do begin
              ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
              qryTest.Next;
            end;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(qryTest)
  end;
end;

function TLockManagement.DepositEntryReconciled(const ID: integer; const ReconciliationIDList: TStringList): boolean;
var
  qryTest: TERPQuery;
begin
  Result := false;
  qryTest := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTest);
    with qryTest do begin
      Sql.Clear;
      SQL.add(DepositEntryReconciledSQL1(ID));
      Open;
      if RecordCount >= 1 then begin
        Result := true;
        if (ReconciliationIDList <> nil) then begin
          qryTest.First;
          while not qryTest.Eof do begin
            ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
            qryTest.Next;
          end;
        end;
      end;
      if (not Result) or (ReconciliationIDList <> nil) then begin
        Sql.Clear;
        SQL.add(DepositEntryReconciledSQL2(ID));

        Open;
        if RecordCount >= 1 then begin
          Result := true;
          if (ReconciliationIDList <> nil) then begin
            qryTest.First;
            while not qryTest.Eof do begin
              ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
              qryTest.Next;
            end;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(qryTest)
  end;
end;

function TLockManagement.DepositEntrySplitOnHOLD(const ID: integer; const ReconciliationIDList: TStringList): boolean;
var
  qryTest: TERPQuery;
begin
  Result := false;
  qryTest := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTest);
    with qryTest do begin
      Sql.Clear;
      Sql.Add(DepositEntrySplitOnHOLDSQL1(ID));
      Open;
      if RecordCount >= 1 then begin
        Result := true;
        if (ReconciliationIDList <> nil) then begin
          qryTest.First;
          while not qryTest.Eof do begin
            ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
            qryTest.Next;
          end;
        end;
      end;
      if (not Result) or (ReconciliationIDList <> nil) then begin
        Sql.Clear;
        Sql.Add(DepositEntrySplitOnHOLDSQL2(ID));
        Open;
        if RecordCount >= 1 then begin
          Result := true;
          if (ReconciliationIDList <> nil) then begin
            qryTest.First;
            while not qryTest.Eof do begin
              ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
              qryTest.Next;
            end;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(qryTest)
  end;
end;

function TLockManagement.DepositEntrySplitReconciled(const ID: integer;
  const ReconciliationIDList: TStringList): boolean;
var
  qryTest: TERPQuery;
begin
  Result := false;
  qryTest := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTest);
    with qryTest do begin
      Sql.Clear;
      SQL.add(DepositEntrySplitReconciledSQL1(ID));
      Open;
      if RecordCount >= 1 then begin
        Result := true;
        if (ReconciliationIDList <> nil) then begin
          qryTest.First;
          while not qryTest.Eof do begin
            ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
            qryTest.Next;
          end;
        end;
      end;
      if (not Result) or (ReconciliationIDList <> nil) then begin
        Sql.Clear;
        SQL.add(DepositEntrySplitReconciledSQL2(ID));
        Open;
        if RecordCount >= 1 then begin
          Result := true;
          if (ReconciliationIDList <> nil) then begin
            qryTest.First;
            while not qryTest.Eof do begin
              ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
              qryTest.Next;
            end;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(qryTest)
  end;
end;

function TLockManagement.IsJournalEntryLocked(const ID: integer; var LockType: TTransLockType): boolean;
begin
  Result := false;
  LockType := ltNone;
  if not Result then begin
    if JournalEntryReconciled(ID) then begin
      {RECONCILED}
      Result := true;
      LockType := ltReconciled;
    end;
  end;
  if not Result then begin
    if JournalEntryOnHOLD(ID) then begin
      {ON HOLD}
      Result := true;
      LockType := ltOnHoldRec;
    end;
  end;
end;

function TLockManagement.JournalEntryOnHOLD(const ID: integer; const ReconciliationIDList: TStringList): boolean;
var
  qryTest: TERPQuery;
begin
  Result := false;
  qryTest := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTest);
    with qryTest do begin
      {Withdrawals}
      Sql.Clear;
      Sql.Add(JournalEntryOnHOLDSQL1(ID));
      Open;
      if RecordCount >= 1 then begin
        Result := true;
        if (ReconciliationIDList <> nil) then begin
          qryTest.First;
          while not qryTest.Eof do begin
            ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
            qryTest.Next;
          end;
        end;
      end;
      if (not Result) or (ReconciliationIDList <> nil) then begin
        {Deposits}
        Sql.Clear;
        Sql.Add(JournalEntryOnHOLDSQL2(ID));
        Open;
        if RecordCount >= 1 then begin
          Result := true;
          if (ReconciliationIDList <> nil) then begin
            qryTest.First;
            while not qryTest.Eof do begin
              ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
              qryTest.Next;
            end;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(qryTest)
  end;
end;

function TLockManagement.JournalEntryReconciled(const ID: integer; const ReconciliationIDList: TStringList): boolean;
var
  qryTest: TERPQuery;
begin
  Result := false;
  qryTest := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTest);
    with qryTest do begin
      {Withdrawals}
      Sql.Clear;
      SQL.add(journalEntryReconciledSQL1(ID));
      Open;
      if RecordCount >= 1 then begin
        Result := true;
        if (ReconciliationIDList <> nil) then begin
          qryTest.First;
          while not qryTest.Eof do begin
            ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
            qryTest.Next;
          end;
        end;
      end;
      if (not Result) or (ReconciliationIDList <> nil) then begin
        {Deposits}
        Sql.Clear;
        SQL.add(journalEntryReconciledSQL2(ID));
        Open;
        if RecordCount >= 1 then begin
          Result := true;
          if (ReconciliationIDList <> nil) then begin
            qryTest.First;
            while not qryTest.Eof do begin
              ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
              qryTest.Next;
            end;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(qryTest)
  end;
end;



function TLockManagement.IsCustomerPrepaymentLocked(const ID: integer; var LockType: TTransLockType): boolean;
begin
  Result := false;
  LockType := ltNone;
  if not Result then begin
    if CustomerPrepaymentReconciled(ID) then begin
      {RECONCILED}
      Result := true;
      LockType := ltReconciled;
    end;
  end;
  if not Result then begin
    if CustomerPrepaymentOnHOLD(ID) then begin
      {ON HOLD}
      Result := true;
      LockType := ltOnHoldRec;
    end;
  end;
  if not Result then begin
    if CustomerPrepaymentDeposited(ID) then begin
      {DEPOSITED}
      Result := true;
      LockType := ltDeposited;
    end;
  end;
  if not Result then begin
    if CustomerPrepaymentApplied(ID) then begin
      {APPLIED}
      Result := true;
      LockType := ltPaymentApplied;
    end;
  end;
end;


function TLockManagement.CustomerPrepaymentApplied(const ID: integer): boolean;
var
  qryTest: TERPQuery;
begin
  Result := false;
  qryTest := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTest);
    with qryTest do begin
      Sql.Clear;
      Sql.Add('SELECT tbldepositline.SaleID,tbldepositline.PaymentID ');
      Sql.Add('From tbldeposits ');
      Sql.Add('INNER JOIN tbldepositline Using(PaymentID) ');
      Sql.Add('Where tbldeposits.Deleted <> "T" AND ');
      Sql.Add('TrnType = "Prepayment" AND ');
      Sql.Add('PrepaymentID = ' + IntToStr(ID) + ';');
      Open;
      if RecordCount >= 1 then begin
        Result := true;
      end;
    end;
  finally
    FreeAndNil(qryTest)
  end;
end;

function TLockManagement.CustomerPrepaymentOnHOLD(const ID: integer; const ReconciliationIDList: TStringList): boolean;
var
  qryTest: TERPQuery;
begin
  Result := false;
  qryTest := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTest);
    with qryTest do begin
      Sql.Clear;
      SQL.add(CustomerPrepaymentOnHOLDSQL1(ID));
      Open;
      if RecordCount >= 1 then begin
        Result := true;
        if (ReconciliationIDList <> nil) then begin
          qryTest.First;
          while not qryTest.Eof do begin
            ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
            qryTest.Next;
          end;
        end;
      end;
      if (not Result) or (ReconciliationIDList <> nil) then begin
        Sql.Clear;
        SQL.add(CustomerPrepaymentOnHOLDSQL2(ID));
        Open;
        if RecordCount >= 1 then begin
          Result := true;
          if (ReconciliationIDList <> nil) then begin
            qryTest.First;
            while not qryTest.Eof do begin
              ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
              qryTest.Next;
            end;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(qryTest)
  end;
end;

function TLockManagement.CustomerPrepaymentReconciled(const ID: integer;
  const ReconciliationIDList: TStringList): boolean;
var
  qryTest: TERPQuery;
begin
  Result := false;
  qryTest := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTest);
    with qryTest do begin
      Sql.Clear;
      SQL.add(CustomerPrepaymentReconciledSQL1(ID));
      Open;
      if RecordCount >= 1 then begin
        Result := true;
        if (ReconciliationIDList <> nil) then begin
          qryTest.First;
          while not qryTest.Eof do begin
            ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
            qryTest.Next;
          end;
        end;
      end;
      if (not Result) or (ReconciliationIDList <> nil) then begin
        Sql.Clear;
        SQL.add(CustomerPrepaymentReconciledSQL2(ID));
        Open;
        if RecordCount >= 1 then begin
          Result := true;
          if (ReconciliationIDList <> nil) then begin
            qryTest.First;
            while not qryTest.Eof do begin
              ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
              qryTest.Next;
            end;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(qryTest)
  end;
end;




function TLockManagement.CustomerPrepaymentDeposited(const ID: integer): boolean;
var
  qryTest: TERPQuery;
begin
  Result := false;
  qryTest := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTest);
    with qryTest do begin
      Sql.Clear;
      Sql.Add(CustomerPrepaymentDepositedSQL(ID));
      Open;
      if RecordCount >= 1 then begin
        Result := true;
      end;
    end;
  finally
    FreeAndNil(qryTest)
  end;
end;

function TLockManagement.IsSupplierPrepaymentLocked(const ID: integer; var LockType: TTransLockType): boolean;
begin
  Result := false;
  LockType := ltNone;
  if not Result then begin
    if SupplierPrepaymentReconciled(ID) then begin
      {RECONCILED}
      Result := true;
      LockType := ltReconciled;
    end;
  end;
  if not Result then begin
    if SupplierPrepaymentOnHOLD(ID) then begin
      {ON HOLD}
      Result := true;
      LockType := ltOnHoldRec;
    end;
  end;
  if not Result then begin
    if SupplierPrepaymentApplied(ID) then begin
      {APPLIED}
      Result := true;
      LockType := ltPaymentApplied;
    end;
  end;
end;

function TLockManagement.SupplierPrepaymentOnHOLD(const ID: integer; const ReconciliationIDList: TStringList): boolean;
var
  qryTest: TERPQuery;
begin
  Result := false;
  qryTest := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTest);
    with qryTest do begin
      Sql.Clear;
      Sql.Add(SupplierPrepaymentOnHOLDSQL1(ID));
      Open;
      if RecordCount >= 1 then begin
        Result := true;
        if (ReconciliationIDList <> nil) then begin
          qryTest.First;
          while not qryTest.Eof do begin
            ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
            qryTest.Next;
          end;
        end;
      end;
      if (not Result) or (ReconciliationIDList <> nil) then begin
        Sql.Clear;
        Sql.Add(SupplierPrepaymentOnHOLDSQL2(ID));
        Open;
        if RecordCount >= 1 then begin
          Result := true;
          if (ReconciliationIDList <> nil) then begin
            qryTest.First;
            while not qryTest.Eof do begin
              ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
              qryTest.Next;
            end;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(qryTest)
  end;
end;

function TLockManagement.SupplierPrepaymentReconciled(const ID: integer;
  const ReconciliationIDList: TStringList): boolean;
var
  qryTest: TERPQuery;
begin
  Result := false;
  qryTest := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTest);
    with qryTest do begin
      Sql.Clear;
      SQL.add(SupplierPrepaymentReconciledSQL1(ID));
      Open;
      if RecordCount >= 1 then begin
        Result := true;
        if (ReconciliationIDList <> nil) then begin
          qryTest.First;
          while not qryTest.Eof do begin
            ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
            qryTest.Next;
          end;
        end;
      end;
      if (not Result) or (ReconciliationIDList <> nil) then begin
        Sql.Clear;
        SQL.add(SupplierPrepaymentReconciledSQL2(ID));
        Open;
        if RecordCount >= 1 then begin
          Result := true;
          if (ReconciliationIDList <> nil) then begin
            qryTest.First;
            while not qryTest.Eof do begin
              ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
              qryTest.Next;
            end;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(qryTest)
  end;
end;

function TLockManagement.SupplierPrepaymentApplied(const ID: integer): boolean;
var
  qryTest: TERPQuery;
begin
  Result := false;
  qryTest := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTest);
    with qryTest do begin
      Sql.Clear;
      Sql.Add('SELECT tblwithdrawallines.POID,tblwithdrawallines.PaymentID ');
      Sql.Add('From tblwithdrawal ');
      Sql.Add('INNER JOIN tblwithdrawallines Using(PaymentID) ');
      Sql.Add('Where tblwithdrawal.Deleted <> "T" AND ');
      Sql.Add('TrnType = "Prepayment" AND PrepaymentID = ' + IntToStr(ID) + ';');
      Open;
      if RecordCount >= 1 then begin
        Result := true;
      end;
    end;
  finally
    FreeAndNil(qryTest)
  end;
end;

function TLockManagement.IsCustomerPaymentLocked(const ID: integer; var LockType: TTransLockType): boolean;
begin
  Result := false;
  LockType := ltNone;
  if not Result then begin
    if CustomerPaymentReconciled(ID) then begin
      {RECONCILED}
      Result := true;
      LockType := ltReconciled;
    end;
  end;
  if not Result then begin
    if CustomerPaymentOnHOLD(ID) then begin
      {ON HOLD}
      Result := true;
      LockType := ltOnHoldRec;
    end;
  end;
  if not Result then begin
    if CustomerPaymentDeposited(ID) then begin
      {DEPOSITED}
      Result := true;
      LockType := ltDeposited;
    end;
  end;
end;

function TLockManagement.CustomerPaymentDeposited(const ID: integer): boolean;
var
  qryTest: TERPQuery;
begin
  Result := false;
  qryTest := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTest);
    with qryTest do begin
      Sql.Clear;
      Sql.Add('Select ');
      Sql.Add('D.PaymentID ');
      Sql.Add('From tbldeposits D ');
      Sql.Add('INNER JOIN tbldepositline DL USING(PaymentID) ');
      Sql.Add('INNER JOIN tblbankdepositlines BDL ON ');
      Sql.Add('BDL.PaymentID = D.PaymentID AND ');
      Sql.Add('BDL.PaymentDate = D.PaymentDate AND ');
      Sql.Add('BDL.AccountID = D.AccountID AND ');
      Sql.Add('BDL.Amount = D.Amount  AND ');
      Sql.Add('BDL.CompanyName = D.CompanyName AND ');
      Sql.Add('BDL.CusID = D.CusID AND ');
      Sql.Add('BDL.TrnsType = "Customer Payment" ');
      Sql.Add('INNER JOIN tblbankdeposit  BD ON BDL.DepositID = BD.DepositID AND BD.Deleted ="F"');
      Sql.Add('Where D.PaymentID=' + IntToStr(ID) + ' AND D.Deleted<>"T" /*AND D.Deposited="T" */');
      Sql.Add('AND BDL.FromDeposited="T" ');
      Sql.Add('Group By D.PaymentID ');
      Open;
      if RecordCount >= 1 then begin
        Result := true;
      end;
    end;
  finally
    FreeAndNil(qryTest)
  end;
end;

function TLockManagement.CustomerPaymentOnHOLD(const ID: integer; const ReconciliationIDList: TStringList): boolean;
var
  qryTest: TERPQuery;
begin
  Result := false;
  qryTest := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTest);
    with qryTest do begin
      Sql.Clear;
      Sql.Add('Select ');
      Sql.Add('R.ReconciliationID ');
      Sql.Add('From tbldeposits D ');
      Sql.Add('INNER JOIN tbldepositline DL USING(PaymentID) ');
      Sql.Add('INNER JOIN tblbankdepositlines BDL ON ');
      Sql.Add('BDL.PaymentID = D.PaymentID AND ');
      Sql.Add('BDL.PaymentDate = D.PaymentDate AND ');
      Sql.Add('BDL.AccountID = D.AccountID AND ');
      Sql.Add('BDL.Amount = D.Amount  AND ');
      Sql.Add('BDL.CompanyName = D.CompanyName AND ');
      Sql.Add('BDL.CusID = D.CusID AND ');
      Sql.Add('BDL.TrnsType = "Customer Payment" ');
      Sql.Add('INNER JOIN tblreconciliationdepositlines RDL	ON ');
      Sql.Add('BDL.DepositID = RDL.PaymentID AND ');
      Sql.Add('BDL.CompanyName = RDL.Payee AND ');
      Sql.Add('BDL.PaymentDate = RDL.DepositDate AND ');
      Sql.Add('BDL.AccountID = RDL.AccountID AND ');
      Sql.Add('BDL.Amount = RDL.Amount AND ');
      Sql.Add('BDL.TrnsType = RDL.Notes AND ');
      Sql.Add('BDL.DepositLineID = RDL.DepositLineID ');
      Sql.Add('INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID ');
      Sql.Add('Where D.PaymentID=' + IntToStr(ID) + ' AND D.Deleted<>"T" AND R.Deleted<>"T" AND R.Finished<>"T" ');
      Sql.Add('Group By R.ReconciliationID ');
      Open;
      if RecordCount >= 1 then begin
        Result := true;
        if (ReconciliationIDList <> nil) then begin
          qryTest.First;
          while not qryTest.Eof do begin
            ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
            qryTest.Next;
          end;
        end;
      end;
      if (not Result) or (ReconciliationIDList <> nil) then begin
        Sql.Clear;
        Sql.Add('Select ');
        Sql.Add('R.ReconciliationID ');
        Sql.Add('From tbldeposits D ');
        Sql.Add('INNER JOIN tbldepositline DL USING(PaymentID) ');
        Sql.Add('INNER JOIN tblbankdepositlines BDL ON ');
        Sql.Add('BDL.PaymentID = D.PaymentID AND ');
        Sql.Add('BDL.PaymentDate = D.PaymentDate AND ');
        Sql.Add('BDL.AccountID = D.AccountID AND ');
        Sql.Add('BDL.Amount = D.Amount  AND ');
        Sql.Add('BDL.CompanyName = D.CompanyName AND ');
        Sql.Add('BDL.CusID = D.CusID AND ');
        Sql.Add('BDL.TrnsType = "Customer Payment" ');
        Sql.Add('INNER JOIN tblreconciliationwithdrawallines RWL	ON ');
        Sql.Add('BDL.DepositID = RWL.PaymentID AND ');
        Sql.Add('BDL.CompanyName = RWL.Payee AND ');
        Sql.Add('BDL.PaymentDate = RWL.DepositDate AND ');
        Sql.Add('BDL.AccountID = RWL.AccountID AND ');
        Sql.Add('-BDL.Amount = RWL.Amount AND ');
        Sql.Add('BDL.TrnsType = RWL.Notes AND ');
        Sql.Add('BDL.DepositLineID = RWL.DepositLineID ');
        Sql.Add('INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID ');
        Sql.Add('Where D.PaymentID=' + IntToStr(ID) + ' AND D.Deleted<>"T" AND R.Deleted<>"T" AND R.Finished<>"T" ');
        Sql.Add('Group By R.ReconciliationID ');
        Open;
        if RecordCount >= 1 then begin
          Result := true;
          if (ReconciliationIDList <> nil) then begin
            qryTest.First;
            while not qryTest.Eof do begin
              ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
              qryTest.Next;
            end;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(qryTest)
  end;
end;

function TLockManagement.CustomerPaymentReconciled(const ID: integer; const ReconciliationIDList: TStringList): boolean;
var
  qryTest: TERPQuery;
begin
  Result := false;
  qryTest := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTest);
    with qryTest do begin
      Sql.Clear;
      SQL.add(CustomerPaymentReconciledSQL1(ID));
      Open;
      if RecordCount >= 1 then begin
        Result := true;
        if (ReconciliationIDList <> nil) then begin
          qryTest.First;
          while not qryTest.Eof do begin
            ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
            qryTest.Next;
          end;
        end;
      end;
      if (not Result) or (ReconciliationIDList <> nil) then begin
        Sql.Clear;
        SQL.add(CustomerPaymentReconciledSQL2(ID));
        Open;
        if RecordCount >= 1 then begin
          Result := true;
          if (ReconciliationIDList <> nil) then begin
            qryTest.First;
            while not qryTest.Eof do begin
              ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
              qryTest.Next;
            end;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(qryTest)
  end;
end;

function TLockManagement.IsSupplierPaymentLocked(const ID: integer; var LockType: TTransLockType): boolean;
begin
  Result := false;
  LockType := ltNone;
  if not Result then begin
    if SupplierPaymentReconciled(ID) then begin
      {RECONCILED}
      Result := true;
      LockType := ltReconciled;
    end;
  end;
  if not Result then begin
    if SupplierPaymentOnHOLD(ID) then begin
      {ON HOLD}
      Result := true;
      LockType := ltOnHoldRec;
    end;
  end;
end;

function TLockManagement.SupplierPaymentOnHOLD(const ID: integer; const ReconciliationIDList: TStringList): boolean;
var
  qryTest: TERPQuery;
begin
  Result := false;
  qryTest := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTest);
    with qryTest do begin
      Sql.Clear;
      Sql.Add(SupplierPaymentOnHOLDSQL1(ID));
      Open;
      if RecordCount >= 1 then begin
        Result := true;
        if (ReconciliationIDList <> nil) then begin
          qryTest.First;
          while not qryTest.Eof do begin
            ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
            qryTest.Next;
          end;
        end;
      end;
      if (not Result) or (ReconciliationIDList <> nil) then begin
        Sql.Clear;
        Sql.Add(SupplierPaymentOnHOLDSQL2(ID));
        Open;
        if RecordCount >= 1 then begin
          Result := true;
          if (ReconciliationIDList <> nil) then begin
            qryTest.First;
            while not qryTest.Eof do begin
              ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
              qryTest.Next;
            end;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(qryTest)
  end;
end;

function TLockManagement.SupplierPaymentReconciled(const ID: integer; const ReconciliationIDList: TStringList): boolean;
var
  qryTest: TERPQuery;
begin
  Result := false;
  qryTest := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTest);
    with qryTest do begin
      Sql.Clear;
      SQL.add(SupplierPaymentReconciledSQL1(ID));
      Open;
      if RecordCount >= 1 then begin
        Result := true;
        if (ReconciliationIDList <> nil) then begin
          qryTest.First;
          while not qryTest.Eof do begin
            ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
            qryTest.Next;
          end;
        end;
      end;
      if (not Result) or (ReconciliationIDList <> nil) then begin
        Sql.Clear;
        SQL.add(SupplierPaymentReconciledSQL2(ID));
        Open;
        if RecordCount >= 1 then begin
          Result := true;
          if (ReconciliationIDList <> nil) then begin
            qryTest.First;
            while not qryTest.Eof do begin
              ReconciliationIDList.Add(qryTest.FieldByName('ReconciliationID').AsString);
              qryTest.Next;
            end;
          end;
        end;
      end;
    end;
  finally
    FreeAndNil(qryTest)
  end;
end;



procedure TLockManagement.GetReconciledDetails(const ID: integer; const TranType: TRecTranType;
  const ReconciliationIDList: TStringList);
begin
  case TranType of

    rttCheque:
      begin
        ChequeReconciled(ID, ReconciliationIDList);
        ChequeOnHOLD(ID, ReconciliationIDList);
        ChequeDepositReconciled(ID, ReconciliationIDList);
        ChequeDepositOnHOLD(ID, ReconciliationIDList);
      end;

    rttCustomerPrepayment:
      begin
        CustomerPrepaymentReconciled(ID, ReconciliationIDList);
        CustomerPrepaymentOnHOLD(ID, ReconciliationIDList);
      end;

    rttSupplierPrepayment:
      begin
        SupplierPrepaymentReconciled(ID, ReconciliationIDList);
        SupplierPrepaymentOnHOLD(ID, ReconciliationIDList);
      end;

    rttCustomerPayment:
      begin
        CustomerPaymentReconciled(ID, ReconciliationIDList);
        CustomerPaymentOnHOLD(ID, ReconciliationIDList);
      end;

    rttSupplierPayment:
      begin
        SupplierPaymentReconciled(ID, ReconciliationIDList);
        SupplierPaymentOnHOLD(ID, ReconciliationIDList);
      end;

    rttJournalEntry:
      begin
        JournalEntryReconciled(ID, ReconciliationIDList);
        JournalEntryOnHOLD(ID, ReconciliationIDList);
      end;

    rttBankDeposit:
      begin
        DepositReconciled(ID, ReconciliationIDList);
        DepositOnHOLD(ID, ReconciliationIDList);
      end;

    rttDepositEntry:
      begin
        DepositEntryReconciled(ID, ReconciliationIDList);
        DepositEntryOnHOLD(ID, ReconciliationIDList);
        DepositEntrySplitReconciled(ID, ReconciliationIDList);
        DepositEntrySplitOnHOLD(ID, ReconciliationIDList);
      end;
  end;
end;

function TLockManagement.IsRelatedCustomerUsed(const ClientID: integer): boolean;
var
  qryTest: TERPQuery;
begin
  Result := false;
  qryTest := TERPQuery.Create(nil);
  try
    EstablishConnection(qryTest);

    with qryTest do begin
      Sql.Clear;
      Sql.Add('SELECT tblsales.ClientID as Records ');
      Sql.Add('FROM tblsales ');
      Sql.Add('INNER JOIN tbldepositline Using(SaleID) ');
      Sql.Add('INNER JOIN tbldeposits Using(PaymentID) ');
      Sql.Add('WHERE tbldeposits.Deleted="F" AND ');
      Sql.Add('tblsales.ClientID=' + IntToStr(ClientID) + ' AND ');
      Sql.Add('tbldeposits.CusID<>' + IntToStr(ClientID) + ';');
      Open;

      if RecordCount >= 1 then begin
        Result := true;
      end;
    end;
  finally
    FreeAndNil(qryTest)
  end;
end;

{ Returns the SQL to be used on TransRecListGUI qryMain }
function TLockManagement.GetReconciledListSQL(const ID: integer; const TranType: string): string;
var
  I: integer;
  WhereSQL, TempSQL: string;
  RecIDs: TStringList;
begin
  inherited;
  RecIDs := TStringList.Create;

  try
    TReconciliationFlagsObj.Instance;

    try
      GetReconciledDetails(ID, ReconciliationFlags.StringToRecTranType(TranType), RecIDs);
    finally
      FreeAndNil(ReconciliationFlags);
    end;

    TempSQL := 'SELECT tblReconciliation.ReconciliationID, tblReconciliation.ReconciliationDate, ' +
      'tblReconciliation .StatementNo, tblChartofAccounts.AccountName, ' +
      'If(tblReconciliation.Finished="T","Reconciled","On Hold") as Status ' +
      'FROM tblReconciliation INNER JOIN tblChartofAccounts ON tblReconciliation.AccountID=tblChartofAccounts.AccountID ';

    for I := 0 to RecIDs.Count - 1 do begin
      WhereSQL := WhereSQL + ' tblReconciliation.ReconciliationID=' + RecIDs.Strings[I];
      if (I <> RecIDs.Count - 1) then WhereSQL := WhereSQL + ' OR ';
    end;


    if not Empty(WhereSQL) then TempSQL := TempSQL + 'WHERE (' + WhereSQL + ');'
    else TempSQL := TempSQL + 'WHERE tblReconciliation.ReconciliationID=0;';

    Result := TempSQL;
  finally
    FreeAndNil(RecIDs);
  end;
end;

  { Returns SQL to be used by DepositedListGUI qryMainSub }
function TLockManagement.GetDepositedListSQL(const PaymentID: integer; const TranType: string): string;
begin
  inherited;
  Result := 'SELECT bdl.PaymentMethod as `Payment Method`, bdl.TrnsType AS Type, DepositDate, bd.GlobalRef, ' +
    'bd.DepositID AS "DepositNo", Deposit AS Amount FROM tblbankdeposit bd ' +
    'INNER JOIN tblbankdepositlines bdl ON bd.DepositID = bdl.DepositID ' +
    'WHERE bdl.PaymentID=' + IntToStr(PaymentID) +
    ' and ifnull(BD.Deleted,"F") = "F" ';

  If TranType<>'' then
    Result := Result + ' AND bdl.TrnsType = '+ QuotedStr(TranType);

end;

procedure TLockManagement.LogSQLs;
begin
    ChequeReconciled(0 , nil);
    ChequeDepositReconciled(0 , nil);
    DepositReconciled(0 , nil);
    DepositEntryReconciled(0 , nil);
    DepositEntrySplitReconciled(0 , nil);
    JournalEntryReconciled(0 , nil);
    CustomerPrepaymentReconciled(0 , nil);
    SupplierPrepaymentReconciled(0 , nil);
    CustomerPaymentReconciled(0 , nil);
    SupplierPaymentReconciled(0 , nil);

end;

end.


