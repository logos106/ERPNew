unit frmRecTransSQL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  StdCtrls, DNMSpeedButton, ProgressDialog;

type
  TfmRecTransSQL = class(TBaseInputGUI)
    btncheque: TDNMSpeedButton;
    edtID: TEdit;
    Memo1: TMemo;
    DNMSpeedButton1: TDNMSpeedButton;
    Button2: TButton;
    DNMSpeedButton2: TDNMSpeedButton;
    DNMSpeedButton3: TDNMSpeedButton;
    Button1: TButton;
    cboQtytype: TComboBox;
    Button3: TButton;
    Button4: TButton;
    DNMSpeedButton4: TDNMSpeedButton;
    Button5: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnchequeClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DNMSpeedButton2Click(Sender: TObject);
    procedure DNMSpeedButton3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure DNMSpeedButton4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    procedure Chequerecfix;
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib,Clipbrd,  CommonDbLib, TransLockManagementSQLs, AppEnvironment,
  AppDatabase, DNMLib,  TransactionsTableLib, ProductQtyLib, tcConst, ERPErrorEmailUtils,
  LogLib, ERPVersionConst, DbSharedObjectsObj, ReconciliationForm,
  BusobjReconciliation;

{$R *.dfm}
procedure TfmRecTransSQL.btnchequeClick(Sender: TObject);
var
  id:Integer;
begin
  try
    id := strToInt(edtid.text);
  except
    on E:Exception do begin
      exit;
    end;
  end;

  Memo1.clear;
    Memo1.Lines.Add('/*Cheque*/');
    Memo1.Lines.Add(ChequeReconciledSQL1(ID, TRue));
    Memo1.Lines.Add(ChequeReconciledSQL2(ID, TRue));
    Memo1.Lines.Add(ChequeOnHOLDSQL1(ID, TRue));
    Memo1.Lines.Add(ChequeOnHOLDSQL2(ID, TRue));
    Memo1.Lines.Add(ChequeDepositReconciledSQL1(ID, TRue));
    Memo1.Lines.Add(ChequeDepositReconciledSQL2(ID, TRue));
    Memo1.Lines.Add(ChequeDepositOnHOLDSQL1(ID, TRue));
    Memo1.Lines.Add(ChequeDepositOnHOLDSQL2(ID, TRue));
    Memo1.Lines.Add('/*customer Payment*/');
    Memo1.Lines.Add(CustomerPaymentReconciledSQL1(ID));
    Memo1.Lines.Add(CustomerPaymentReconciledSQL2(ID));
    Memo1.Lines.Add(CustomerPaymentOnHOLDSQL1(ID));
    Memo1.Lines.Add(CustomerPaymentOnHOLDSQL2(ID));
    Memo1.Lines.Add('/*DepositEntry - Split*/');
    Memo1.Lines.Add(DepositEntrySplitReconciledSQL1(ID));
    Memo1.Lines.Add(DepositEntrySplitReconciledSQL2(ID));
    Memo1.Lines.Add(DepositEntrySplitOnHOLDSQL1(ID));
    Memo1.Lines.Add(DepositEntrySplitOnHOLDSQL2(ID));
    Memo1.Lines.Add('/*Deposit Entry*/');
    Memo1.Lines.Add(DepositEntryReconciledSQL1(ID));
    Memo1.Lines.Add(DepositEntryReconciledSQL2(ID));
    Memo1.Lines.Add(DepositEntryOnHOLDSQL1(ID));
    Memo1.Lines.Add(DepositEntryOnHOLDSQL2(ID));
    Memo1.Lines.Add('/*to be deposited*/');
    Memo1.Lines.Add(DepositReconciledSQL1(ID));
    Memo1.Lines.Add(DepositReconciledSQL2(ID));
    Memo1.Lines.Add(DepositOnHOLDSQL1(ID));
    Memo1.Lines.Add(DepositOnHOLDSQL2(ID));
    Memo1.Lines.Add('/*Customer prepayment*/');
    Memo1.Lines.Add(CustomerPrepaymentDepositedSQL(ID));
    Memo1.Lines.Add(CustomerPrepaymentReconciledSQL1(ID));
    Memo1.Lines.Add(CustomerPrepaymentReconciledSQL2(ID));
    Memo1.Lines.Add(CustomerPrepaymentOnHOLDSQL1(ID));
    Memo1.Lines.Add(CustomerPrepaymentOnHOLDSQL2(ID));
    Memo1.Lines.Add('/*Supplier Payment*/');
    Memo1.Lines.Add(SupplierPaymentReconciledSQL1(ID));
    Memo1.Lines.Add(SupplierPaymentReconciledSQL2(ID));
    Memo1.Lines.Add(SupplierPaymentOnHOLDSQL1(ID));
    Memo1.Lines.Add(SupplierPaymentOnHOLDSQL2(ID));
    Memo1.Lines.Add('/*journal entry*/');
    Memo1.Lines.Add(JournalEntryReconciledSQL1(ID));
    Memo1.Lines.Add(JournalEntryReconciledSQL2(ID));
    Memo1.Lines.Add(JournalEntryOnHOLDSQL1(ID));
    Memo1.Lines.Add(JournalEntryOnHOLDSQL2(ID));
    Memo1.Lines.Add('/*Supplier prepayment*/');
    Memo1.Lines.Add(SupplierPrepaymentReconciledSQL1(ID));
    Memo1.Lines.Add(SupplierPrepaymentReconciledSQL2(ID));
    Memo1.Lines.Add(SupplierPrepaymentOnHOLDSQL1(ID));
    Memo1.Lines.Add(SupplierPrepaymentOnHOLDSQL2(ID));
    Memo1.Lines.Add('/*to be reconciled*/');
(*    with TReconciliationGUI.create(self) do try
      Memo1.Lines.Add('/*deposit*/');
      Memo1.Lines.Add(LoadDepositQry(False,true,0));

      Memo1.Lines.Add('/*Withdrawal*/');
      Memo1.Lines.Add(LoadWithdrawalQry(False,true,0));

    finally
      free;
    end;*)
    with TReconciliation.create(self) do try
      AccountID := 200; // test accountid
      ListofToBeReconciled := true;
      FilterLinesforDate := False;
      Memo1.Lines.Add('/*deposit*/');
      //Memo1.Lines.Add(LoadDepositQry(False,true,0));
      Memo1.Lines.Add(GuiDepositLines.SQL);


      Memo1.Lines.Add('/*Withdrawal*/');
      //Memo1.Lines.Add(LoadWithdrawalQry(False,true,0));
      Memo1.Lines.Add(GuiWithdrawLines.SQL);


    finally
      free;
    end;

    Clipboard.asText := Memo1.Lines.text;
end;

procedure TfmRecTransSQL.Chequerecfix;
  var
    tablename :string;
    Qry1,Qry2:TERPQuery;
    ERPScript:TERPScript;

  Procedure CreatechequeRec(const ID:Integer);
  begin
    With ERPScript do begin
      SQL.clear;
      SQL.add('Drop table if exists ' +tablename +';');
      SQL.add('Create table ' +tablename  +' ' + ChequeReconciledSQL1(id,true));
      SQL.add('insert into ' +tablename + ' '+ ChequeReconciledSQL2(id,true));
      SQL.add('insert into ' +tablename + ' '+ ChequeOnHOLDSQL1(id,true));
      SQL.add('insert into ' +tablename + ' '+ ChequeOnHOLDSQL2(id,true));
      SQL.add('insert into ' +tablename + ' (ReconciliationID,PurchaseOrderID, AccountName,  accountId, depositId, depositLineID, TrnsType  ) '+ ChequeDepositReconciledSQL1(id,true));
      SQL.add('insert into ' +tablename + ' (ReconciliationID,PurchaseOrderID, AccountName,  accountId, depositId, depositLineID, TrnsType  ) '+ ChequeDepositReconciledSQL2(id,true));
      SQL.add('insert into ' +tablename + ' (ReconciliationID,PurchaseOrderID, AccountName,  accountId, depositId, depositLineID, TrnsType  ) '+ ChequeDepositOnHOLDSQL1(ID,true));
      SQL.add('insert into ' +tablename + ' (ReconciliationID,PurchaseOrderID, AccountName,  accountId, depositId, depositLineID, TrnsType  ) '+ ChequeDepositOnHOLDSQL2(ID,true));
      execute;
    end;
  end;
begin
  inherited;
    Qry1:= tempmyquery;
    Qry2:= tempmyquery;
    ERPScript:=TempmyScript;
    try
      tablename := 'tmp_1';
      Qry1.SQl.add('Select PurchaseOrderId from tblPurchaseOrders where isCheque ="T"');
      Qry2.SQL.add('Select * from ' +tablename );

      Qry1.open;
      if Qry1.recordcount =0 then exit;
      Qry1.first;
      While Qry1.Eof = False do begin
         CreatechequeRec(Qry1.Fieldbyname('PurchaseOrderId').asInteger);
         if Qry2.active then Qry2.Close;
         Qry2.Open;
         if Qry2.recordcount >0 then begin
             Qry2.First;
             While Qry2.eof = False do begin
              memo1.lines.add('update tblBankDeposit Set REconciled = "T" where DepositId = ' +inttostr(Qry2.Fieldbyname('DepositID').asInteger) +' and reconciled = "F";');
              memo1.lines.add('update tblBankDepositLines Set REconciled = "T" where DepositLineId = ' +inttostr(Qry2.Fieldbyname('DepositLineID').asInteger) +' and reconciled = "F";');
              Qry2.Next;
             end;
         end;
          Qry1.Next;
      end;
    finally
      Qry1.closenFree;
      Qry2.closenFree;
      Freeandnil(ERPScript);
    end;
end;

procedure TfmRecTransSQL.Button1Click(Sender: TObject);
var
  s:String;
  scr :TERPScript;

begin
  inherited;
  if isinteger(edtID.Text) then begin
    with TTransactionTableExtra.Create(False) do try
      s:= TransSQL(strToInt(edtID.Text));
      Memo1.clear;
      Memo1.Lines.Add(s);

(*  if MessageDlgXP_Vista('Do you Wish To run the Script?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      scr := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
      try
        scr.SQL.text := 'Delete from tbltransactions where seqno =' +  strToInt(edtID.Text)+';';
        scr.SQL.add(s);
        scr.Execute;
      finally
        DbSharedObj.ReleaseObj(scr);
      end;
  end;*)


    finally
      Free;
    end;
  end else begin
    with TTransactionTableExtra.Create do try
      s:= TransactionSQLs;
      Memo1.clear;
      Memo1.Lines.Add(s);
    finally
      Free;
    end;

  end;
end;

procedure TfmRecTransSQL.Button2Click(Sender: TObject);
var
  tablenamePrefix:String;
  tablename :String;
begin
  inherited;
  tablenamePrefix := replaceStr(TABLE_VERSION , '.' , '');

  memo1.lines.clear;
  tablename := 'erpfix_bankdepositlines' + tablenamePrefix;
  if not TableExists(tablename) then
    memo1.lines.add(CreateTableSQL(tablename , 'tblbankdepositlines')+';');
  memo1.lines.add('insert ignore into ' + tablename +' (GlobalRef, DepositLineID, DepositID, PaymentID, TrnsType, CusID, PayMethodID, PaymentMethod, PaymentDate,  ' +
            ' CompanyName, ReferenceNo, ClassID, TransClassName, AccountID, AccountName, Name, Amount, Notes, Customer, Supplier, Employee, Contact, Deposited, StatementNo,  ' +
            ' FromDeposited, EditedFlag, Reconciled, TransID, msTimeStamp, Deleted, TransPaymentID) ' +
            ' Select GlobalRef, DepositLineID, DepositID, PaymentID, TrnsType, CusID, PayMethodID, PaymentMethod, PaymentDate,  ' +
            ' CompanyName, ReferenceNo, ClassID, TransClassName, AccountID, AccountName, Name, Amount, Notes, Customer, Supplier, Employee,  ' +
            ' Contact, Deposited, StatementNo, FromDeposited, EditedFlag, Reconciled, TransID, msTimeStamp, Deleted, TransPaymentID  ' +
            ' from tblbankdepositlines;');

  tablename := 'erpfix_bankdeposit' + tablenamePrefix;
  if not TableExists(tablename) then
    memo1.lines.add(CreateTableSQL(tablename , 'tblbankdeposit')+';');
  memo1.lines.add('insert ignore into ' + tablename +' (GlobalRef, DepositID, DepositDate, EmployeeID, ClassID, ClassName, AccountID, Notes, Deposit, Deleted,  ' +
            ' EditedFlag, Reconciled, msTimeStamp, DepositTot, UnDepositTot) ' +
            ' Select GlobalRef, DepositID, DepositDate, EmployeeID, ClassID, ClassName, AccountID, Notes, Deposit, Deleted,  ' +
            ' EditedFlag, Reconciled, msTimeStamp, DepositTot, UnDepositTot ' +
            ' from tblbankdeposit;');


 {journal entry.withdrawal}
  memo1.lines.add('update tblgeneraljournal JE '+
                             ' INNER JOIN tblgeneraljournaldetails JEL USING(GJID) '+
                             ' INNER JOIN tblbankdepositlines BDL ON JEL.GJID = BDL.PaymentID '+
                             ' AND JE.TransactionDate = BDL.PaymentDate AND JEL.AccountID=BDL.AccountID '+
                             ' AND BDL.Amount=(If(IsNull(JEL.DebitAmountInc),0.00,JEL.DebitAmountInc)-If(IsNull(JEL.CreditAmountInc),0.00,JEL.CreditAmountInc)) '+
                             ' AND BDL.TrnsType="Journal Entry" '+
                             ' INNER JOIN tblreconciliationwithdrawallines RWL	ON BDL.DepositID = RWL.PaymentID '+
                             ' AND BDL.PaymentDate = RWL.DepositDate AND BDL.AccountID = RWL.AccountID '+
                             ' AND -BDL.Amount = RWL.Amount AND BDL.TrnsType = RWL.Notes AND BDL.DepositLineID = RWL.DepositLineID '+
                             ' INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID'+
                             ' Set BDL.Reconciled = "T"'+
                             ' Where R.Deleted<>"T" ;');
 {journal entry.Deposit}
  memo1.lines.add('update  tblgeneraljournal JE '+
                             ' INNER JOIN tblgeneraljournaldetails JEL USING(GJID) '+
                             ' INNER JOIN tblbankdepositlines BDL ON JEL.GJID = BDL.PaymentID '+
                             ' AND JE.TransactionDate = BDL.PaymentDate AND JEL.AccountID=BDL.AccountID AND BDL.Amount=(If(IsNull(JEL.DebitAmountInc),0.00,JEL.DebitAmountInc)-If(IsNull(JEL.CreditAmountInc),0.00,JEL.CreditAmountInc)) AND BDL.TrnsType="Journal Entry" '+
                             ' INNER JOIN tblreconciliationdepositlines RDL	ON BDL.DepositID = RDL.PaymentID AND BDL.PaymentDate = RDL.DepositDate AND BDL.AccountID = RDL.AccountID AND BDL.Amount = RDL.Amount AND BDL.TrnsType = RDL.Notes AND BDL.DepositLineID = RDL.DepositLineID '+
                             ' INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID'+
                             ' Set BDL.Reconciled = "T"'+
                             ' Where R.Deleted<>"T" ;');
 {Supplier Payment.withdrawal}
  memo1.lines.add('update  tblwithdrawal W  '+
                             ' INNER JOIN tblwithdrawallines WL USING(PaymentID)  '+
                             ' INNER JOIN tblbankdepositlines BDL ON  BDL.PaymentID = W.PaymentID '+
                             ' AND  BDL.PaymentDate = W.PaymentDate AND  BDL.AccountID = W.AccountID AND  -BDL.Amount = W.Amount  AND  BDL.CompanyName = W.CompanyName AND  BDL.CusID = W.SupplierID AND  BDL.TrnsType = "Supplier Payment"  '+
                             ' INNER JOIN tblreconciliationwithdrawallines RWL	ON  BDL.DepositID = RWL.PaymentID '+
                             ' AND  BDL.CompanyName = RWL.Payee AND  BDL.PaymentDate = RWL.DepositDate AND  BDL.AccountID = RWL.AccountID AND  W.Amount = RWL.Amount AND  BDL.TrnsType = RWL.Notes AND  BDL.DepositLineID = RWL.DepositLineID  '+
                             ' INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID'+
                             ' Set BDL.reconciled = "T"'+
                             ' Where R.Deleted<>"T" ;');
 {Supplier Payment.Deposit}
  memo1.lines.add('update  tblwithdrawal W  '+
                             ' INNER JOIN tblwithdrawallines WL USING(PaymentID)  '+
                             ' INNER JOIN tblbankdepositlines BDL ON  BDL.PaymentID = W.PaymentID '+
                             ' AND  BDL.PaymentDate = W.PaymentDate AND  BDL.AccountID = W.AccountID AND  -BDL.Amount = W.Amount  AND  BDL.CompanyName = W.CompanyName AND  BDL.CusID = W.SupplierID AND  BDL.TrnsType = "Supplier Payment"  '+
                             ' INNER JOIN tblreconciliationdepositlines RDL	ON  BDL.DepositID = RDL.PaymentID '+
                             ' AND  BDL.CompanyName = RDL.Payee AND  BDL.PaymentDate = RDL.DepositDate AND  BDL.AccountID = RDL.AccountID AND  -W.Amount = RDL.Amount AND  BDL.TrnsType = RDL.Notes AND  BDL.DepositLineID = RDL.DepositLineID  '+
                             ' INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID'+
                             ' Set BDL.reconciled = "T"'+
                             ' Where  R.Deleted<>"T"  ;');
 {PrePayment.withdrawal}
  memo1.lines.add(' update tblprepayments PP  '+
              ' INNER JOIN tblbankdepositlines BDL ON   '+
                             ' BDL.PaymentID = PP.PrePaymentID  '+
                             ' AND  BDL.PaymentDate = PP.PrePaymentDate  '+
                             ' AND  BDL.AccountID = PP.BankAccountID  '+
                             ' AND  BDL.Amount = PP.PayAmount   '+
                             ' AND  BDL.CompanyName= PP.CompanyName  '+
                             ' AND  BDL.CusID=PP.ClientID  '+
                             ' AND  BDL.TrnsType = "Supplier Prepayment"   '+
              ' INNER JOIN tblreconciliationwithdrawallines RWL	ON  BDL.DepositID = RWL.PaymentID  '+
                             ' AND  BDL.CompanyName = RWL.Payee  '+
                             ' AND  BDL.PaymentDate = RWL.DepositDate  '+
                             ' AND  BDL.AccountID = RWL.AccountID  '+
                             ' AND   BDL.Amount = RWL.Amount  '+
                             ' AND  BDL.TrnsType = RWL.Notes  '+
                             ' AND  BDL.DepositLineID = RWL.DepositLineID   '+
              ' INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID   '+
              ' Set BDL.reconciled = "T"  '+
              ' Where R.Deleted<>"T"  and BDL.Reconciled ="F";');
 {PrePayment.Deposit }
  memo1.lines.add(' update tblprepayments PP   '+
              ' INNER JOIN tblbankdepositlines BDL ON  BDL.PaymentID = PP.PrePaymentID  '+
                             ' AND  BDL.PaymentDate = PP.PrePaymentDate  '+
                             ' AND  BDL.AccountID = PP.BankAccountID  '+
                             ' AND  BDL.Amount = PP.PayAmount   '+
                             ' AND  BDL.CompanyName= PP.CompanyName  '+
                             ' AND  BDL.CusID=PP.ClientID  '+
                             ' AND  BDL.TrnsType = "Supplier Prepayment"   '+
              ' INNER JOIN tblreconciliationdepositlines    RDL	ON  BDL.DepositID = RDL.PaymentID  '+
                             ' AND  BDL.CompanyName = RDL.Payee  '+
                             ' AND  BDL.PaymentDate = RDL.DepositDate  '+
                             ' AND  BDL.AccountID = RDL.AccountID  '+
                             ' AND  -BDL.Amount = RDL.Amount  '+
                             ' AND  BDL.TrnsType = RDL.Notes  '+
                             ' AND  BDL.DepositLineID = RDL.DepositLineID   '+
              ' INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID   '+
              ' Set BDL.reconciled = "T"  '+
              ' Where R.Deleted<>"T"    and BDL.Reconciled ="F";');

 {Cheque}
  Chequerecfix;
 {bank deposit - all lines reconciled but not header}
  memo1.lines.add(' Drop table if exists tmp_1;');
  memo1.lines.add(' create table tmp_1  '+
              ' SELECT   6, "Bank Deposit" as Notes, BD.DepositID,0 as DepositLineID,DepositDate, ABS(Deposit) as Amount,  '+
                             ' BD.DepositID as PaymentID, CusID, BD.Notes as ReferenceNo, "" as CompanyName  '+
                             ' FROM tblbankdeposit BD  '+
                             ' INNER JOIN tblbankdepositlines BDL Using (DepositID)  '+
                             ' WHERE BD.Reconciled <> "T"    '+
                             ' AND BDL.TrnsType<>"Deposit Entry"  '+
                             ' AND BDL.TrnsType<>"Cheque Deposit"  '+
                             ' AND BDL.TrnsType<>"Customer Prepayment"  '+
                             ' AND BDL.TrnsType<>"Supplier Prepayment"  '+
                             ' AND ifnull(Round(Deposit,5),0) > 0.00 AND FromDeposited="T"  '+
                             ' AND BD.Deleted <>"T"  '+
                             ' and BD.depositId not in (Select DepositId from tblbankdepositlines sub where sub.reconciled = "F")  '+
                             ' Group By  BD.DepositID   '+
              ' UNION ALL  '+
              ' SELECT   2, "Bank Deposit" as Notes, tblbankdeposit.DepositID,0 as DepositLineID,DepositDate, ABS(Deposit) as Amount,  '+
                             ' tblbankdeposit.DepositID as PaymentID,If(IsNull(CusID),0,CusID) as CusID, tblbankdeposit.Notes as ReferenceNo, "" as CompanyName  '+
                             ' FROM tblbankdeposit  '+
                             ' INNER JOIN tblbankdepositlines Using (DepositID)   '+
                             ' WHERE tblbankdeposit.Reconciled <> "T"    '+
                             ' AND tblbankdepositlines.TrnsType<>"Deposit Entry"  '+
                             ' AND tblbankdepositlines.TrnsType<>"Cheque"  '+
                             ' AND tblbankdepositlines.TrnsType<>"Customer Prepayment"  '+
                             ' AND tblbankdepositlines.TrnsType<>"Supplier Prepayment"  '+
                             ' AND ifnull(Round(Deposit,5),0) < 0.00 AND FromDeposited="T"  '+
                             ' AND tblbankdeposit.Deleted <>"T"   '+
                             ' and tblbankdeposit.depositId not in (Select DepositId from tblbankdepositlines sub where sub.reconciled = "F")   '+
                             ' Group By  tblbankdeposit.DepositID ; ');
  memo1.lines.add(' update tmp_1 T inner join tblbankdeposit BD on T.DepositID = BD.depositID and BD.reconciled = "F" Set BD.Reconciled ="T";');

  memo1.lines.add(' update  tblbankdeposit BD    '+
              ' INNER JOIN tblbankdepositlines BDL ON BD.DepositID = BDL.DepositID    '+
              ' INNER JOIN tblreconciliationwithdrawallines RWL ON  BDL.DepositID = RWL.PaymentID AND  BD.DepositDate = RWL.DepositDate AND  ABS(BDL.Amount) = RWL.Amount AND  RWL.Notes = "Split Deposit"    '+
              ' INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID    '+
              ' Set BDL.Reconciled = "T"     '+
              ' WHERE R.Deleted<>"T" AND BD.Deleted<>"T"  and BDL.Reconciled = "F"  ;');
  memo1.lines.add(' update  tblbankdeposit BD    '+
              ' INNER JOIN tblbankdepositlines BDL ON BD.DepositID = BDL.DepositID    '+
              ' INNER JOIN tblreconciliationdepositlines RDL ON  BDL.DepositID = RDL.PaymentID AND  BD.DepositDate = RDL.DepositDate AND  ABS(BDL.Amount) = RDL.Amount AND  RDL.Notes = "Split Deposit"    '+
              ' INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID      '+
              ' Set BDL.Reconciled = "T"    '+
              ' WHERE R.Deleted<>"T" AND BD.Deleted<>"T"    and BDL.Reconciled = "F";');
  memo1.lines.add(' update  tblbankdeposit BD    '+
              ' INNER JOIN tblbankdepositlines BDL ON BD.DepositID = BDL.DepositID    '+
              ' INNER JOIN tblreconciliationdepositlines RDL ON  BD.DepositID = RDL.PaymentID AND  BD.DepositDate = RDL.DepositDate AND  ABS(BD.Deposit) = RDL.Amount AND  RDL.Notes = "Deposit Entry"    '+
              ' INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID    '+
              ' Set BD.reconciled = "T"    '+
              ' WHERE R.Deleted<>"T" AND BD.Deleted<>"T"   and BD.reconciled = "F"  ;');
  memo1.lines.add(' update  tblbankdeposit BD    '+
              ' INNER JOIN tblbankdepositlines BDL ON BD.DepositID = BDL.DepositID    '+
              ' INNER JOIN tblreconciliationwithdrawallines RWL ON  BD.DepositID = RWL.PaymentID AND  BD.DepositDate = RWL.DepositDate AND  ABS(BD.Deposit) = RWL.Amount AND  RWL.Notes = "Deposit Entry"    '+
              ' INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID    '+
              ' Set BD.reconciled = "T"    '+
              ' WHERE   R.Deleted<>"T" AND BD.Deleted<>"T" and BD.reconciled = "F";');
  if MessageDlgXP_Vista('Do you wish to Fix?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
     SendEmailtoErp( 'Reconciliation Fix ',
                '    Company     :' +appenv.CompanyInfo.Companyname          +chr(13) +
                '    Server      :' +GetSharedMyDacConnection.Server  +chr(13) +
                '    Datase      :' +GetSharedMyDacConnection.Database+chr(13) +
                '    Version     :' +TABLE_VERSION+chr(13) +
                '    BankDeposit.backup     : erpfix_bankdepositlines' + tablenamePrefix+chr(13) +
                '    BankDepositLines.backup: erpfix_bankdepositlines' + tablenamePrefix+chr(13) +
                'SQL : ' +chr(13) +
                Memo1.Lines.text );
    ExecuteSQL(Memo1.Lines.text);
  end;
end;

procedure TfmRecTransSQL.Button3Click(Sender: TObject);
begin
  inherited;
  Memo1.lines.clear;
  Memo1.Lines.add('Select ' + NL+SQL4QtyField( QtyDesctoType(cboQtytype.Text)) + NL+ ProductTables(tDetailswithSno));

end;

procedure TfmRecTransSQL.Button4Click(Sender: TObject);
var
  st:TStringlist;
begin
  inherited;
  with TTransactionTableExtra.Create do try
    st := TStringlist.create;
    try
      InvAssetPostings(st, 'tmp_1' );
      Memo1.clear;
      Memo1.Lines.Add(st.text);
    finally
      Freeandnil(st);
    end;
    finally
      Free;
    end;

end;

procedure TfmRecTransSQL.Button5Click(Sender: TObject);
begin
  inherited;
  clog(ProductQtyLib.StockQty(True , 999999, 888888 , tftAll        , 0));
end;

procedure TfmRecTransSQL.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  memo1.lines.clear;
  memo1.lines.add('Select');
  memo1.lines.add('concat(''update tblbankdepositlines set Reconciled = "T" where DepositLineID = '' , BDL.DepositLineID , ";")');
  memo1.lines.add('From tblwithdrawal W');
  memo1.lines.add('INNER JOIN tblwithdrawallines WL USING(PaymentID)');
  memo1.lines.add('INNER JOIN tblbankdepositlines BDL ON  BDL.PaymentID = W.PaymentID AND  BDL.PaymentDate = W.PaymentDate AND  ');
  memo1.lines.add('BDL.AccountID = W.AccountID AND  -BDL.Amount = W.Amount  AND  BDL.CompanyName = W.CompanyName ');
  memo1.lines.add('AND  BDL.CusID = W.SupplierID AND  BDL.TrnsType = "Supplier Payment"');
  memo1.lines.add('INNER JOIN tblreconciliationwithdrawallines RWL	ON  BDL.DepositID = RWL.PaymentID AND  ');
  memo1.lines.add('BDL.CompanyName = RWL.Payee AND  BDL.PaymentDate = RWL.DepositDate AND  BDL.AccountID = RWL.AccountID ');
  memo1.lines.add('AND  W.Amount = RWL.Amount AND  BDL.TrnsType = RWL.Notes AND  BDL.DepositLineID = RWL.DepositLineID');
  memo1.lines.add('INNER JOIN tblreconciliation R ON RWL.ReconciliationID = R.ReconciliationID');
  memo1.lines.add('Where R.Deleted<>"T" AND R.Finished="T"   and BDL.Reconciled = "F"');

  memo1.lines.add('Select  concat(''update tblbankdepositlines set Reconciled = "T" where DepositLineID = '' , BDL.DepositLineID , ";")');
  memo1.lines.add('From tblwithdrawal W');
  memo1.lines.add('INNER JOIN tblwithdrawallines WL USING(PaymentID)');
  memo1.lines.add('INNER JOIN tblbankdepositlines BDL ON  BDL.PaymentID = W.PaymentID AND  ');
  memo1.lines.add('BDL.PaymentDate = W.PaymentDate AND  BDL.AccountID = W.AccountID AND  -BDL.Amount = W.Amount  AND ');
  memo1.lines.add('BDL.CompanyName = W.CompanyName AND  BDL.CusID = W.SupplierID AND  BDL.TrnsType = "Supplier Payment"');
  memo1.lines.add('INNER JOIN tblreconciliationdepositlines RDL	ON  BDL.DepositID = RDL.PaymentID AND ');
  memo1.lines.add(' BDL.CompanyName = RDL.Payee AND  BDL.PaymentDate = RDL.DepositDate AND  BDL.AccountID = RDL.AccountID ');
  memo1.lines.add('AND  -W.Amount = RDL.Amount AND  BDL.TrnsType = RDL.Notes AND  BDL.DepositLineID = RDL.DepositLineID');
  memo1.lines.add('INNER JOIN tblreconciliation R ON RDL.ReconciliationID = R.ReconciliationID');
  memo1.lines.add('Where R.Deleted<>"T" AND R.Finished="T"');
  memo1.lines.add('and BDL.Reconciled = "F"');

end;

procedure TfmRecTransSQL.DNMSpeedButton2Click(Sender: TObject);
begin
  inherited;
  Memo1.Lines.Clear;

  Memo1.Lines.add('Select');
  Memo1.Lines.add('BD.DepositID , PP.PrePaymentID  , BD.deleted , PP.deposited');
  Memo1.Lines.add('From tblprepayments PP');
  Memo1.Lines.add('INNER JOIN tblbankdepositlines BDL ON');
  Memo1.Lines.add('BDL.PaymentID = PP.PrePaymentID');
  Memo1.Lines.add('AND BDL.PaymentDate = PP.PrePaymentDate');
  Memo1.Lines.add('AND BDL.AccountID = PP.BankAccountID');
  Memo1.Lines.add('AND SameValue(BDL.Amount , PP.PayAmount   ,5)=1');
  Memo1.Lines.add('AND BDL.CompanyName= PP.CompanyName');
  Memo1.Lines.add('AND BDL.CusID=PP.ClientID');
  Memo1.Lines.add('AND BDL.TrnsType = "Prepayment"');
  Memo1.Lines.add('INNER JOIN tblbankdeposit BD ON BD.DepositID = BDL.DepositID');
  Memo1.Lines.add('Where /*PP.PrePaymentID in (159, 160 , 162,163,164,166,168,169,170,172,580,588,593,1656, 1657,2251) AND */ BD.Deleted<>"T"  and PP.deposited ="F"');
end;

procedure TfmRecTransSQL.DNMSpeedButton3Click(Sender: TObject);
begin
  inherited;
memo1.Lines.Clear;
memo1.Lines.add('Select');
memo1.Lines.add('D.PaymentID , D.Mstimestamp');
memo1.Lines.add('From tbldeposits D');
memo1.Lines.add('INNER JOIN tbldepositline DL USING(PaymentID)');
memo1.Lines.add('INNER JOIN tblbankdepositlines BDL ON');
memo1.Lines.add('BDL.PaymentID      = D.PaymentID');
memo1.Lines.add('AND BDL.PaymentDate= D.PaymentDate');
memo1.Lines.add('AND BDL.AccountID  = D.AccountID');
memo1.Lines.add('AND BDL.Amount     = D.Amount');
memo1.Lines.add('AND BDL.CompanyName= D.CompanyName');
memo1.Lines.add('AND BDL.CusID      = D.CusID');
memo1.Lines.add('AND BDL.TrnsType   = "Customer Payment"');
memo1.Lines.add('INNER JOIN tblbankdeposit BD on BD.DEpositID = BDL.DepositID and ifnull(BD.Deleted,"F") <> "T"');
memo1.Lines.add('Where /*D.PaymentID  =  722');
memo1.Lines.add('AND */D.Deleted      <>"T" AND D.Deposited="F"');
memo1.Lines.add('AND BDL.FromDeposited = "T"');
memo1.Lines.add('Group By D.PaymentID');
end;

procedure TfmRecTransSQL.DNMSpeedButton4Click(Sender: TObject);
var
  ctr:Integer;
  fbPrevLineEOFSQL:Boolean;
begin
  inherited;
    with TOpenDialog.Create(Self) do try
        Title := 'choose the SQL file to load';
        Filter := 'SQL Files|*.SQL|'+
                  'CSV Files|*.csv|'+
                  'All Files|*.*';
        if Execute then begin
          Memo1.Lines.Clear;
          Memo1.Lines.loadfromfile(FileName);
          fbPrevLineEOFSQL:=True;
          if Memo1.Lines.Count >0 then begin
            for ctr:= 0 to Memo1.Lines.Count-1 do begin
              Memo1.Lines[ctr] := trim(Memo1.Lines[ctr]);
              if Memo1.Lines[ctr] <> '' then begin
                if fbPrevLineEOFSQL then Memo1.Lines[ctr] := 'SQL.add('' ' +Memo1.Lines[ctr]
                else Memo1.Lines[ctr] := '      '' ' + Memo1.Lines[ctr];

                if copy(Memo1.Lines[ctr] , length(Memo1.Lines[ctr]) , 1) =';' then begin
                  Memo1.Lines[ctr] := Memo1.Lines[ctr] +' '');';
                  fbPrevLineEOFSQL := True;
                end else begin
                  Memo1.Lines[ctr] := Memo1.Lines[ctr] +  ' '' + ';
                  fbPrevLineEOFSQL := False;
                end;
              end;
            end;
            Clipboard.asText := Memo1.Lines.text;
          end;

        end;
    finally
      Free;
    end;

end;

procedure TfmRecTransSQL.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

initialization
  RegisterClassOnce(TfmRecTransSQL);

end.
