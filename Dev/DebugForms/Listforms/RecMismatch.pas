unit RecMismatch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript, CustomInputBox, wwcheckbox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TRecMismatchGui = class(TBaseListingGUI)
    qryAccount: TERPQuery;
    qryAccountAccountName: TWideStringField;
    qryAccountAccountID: TIntegerField;
    qryAccountAccountType: TWideStringField;
    Label4: TLabel;
    cboAccount: TwwDBLookupCombo;
    qryMainCategory: TWideStringField;
    qryMainReconciled: TWideStringField;
    qryMainDeleted: TWideStringField;
    qryMainFinished: TWideStringField;
    qryMainSeqno: TLargeintField;
    qryMainNotes: TWideStringField;
    qryMainDepositID: TIntegerField;
    qryMainDepositLineID: TLargeintField;
    qryMainDepositDate: TDateField;
    qryMainAmount: TFloatField;
    qryMainPaymentID: TIntegerField;
    qryMainCusID: TLargeintField;
    qryMainReferenceNo: TWideStringField;
    qryMainCompanyName: TWideStringField;
    DNMSpeedButton1: TDNMSpeedButton;
    btnupdate: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure qryAccountBeforeClose(DataSet: TDataSet);
    procedure btnupdateClick(Sender: TObject);
  private
    fsDeposittablename, fsWithdrawaltablename:String;
    function GetDepositPaymentID(const DepositID: integer;const TrnsType: string): integer;
    procedure MakeUpdateForAccunt(tmpScript: TERPScript);
    procedure Dobackup(tmpScript: TERPScript);
    function MakeQry(Deposittablename, Withdrawaltablename: STring;AccountID: Integer;ShowInvalidsOnly:boolean = true): String;
    (* function GetWithdrawalPaymentID(const DepositID: integer): integer; *)
  public
    Procedure RefreshQuery; Override;
  end;

implementation

uses CommonLib, CommonDbLib, AppDatabase, tcConst,
  frmCustPayments, frmSuppPayments, frmSuppPrepayments, frmCustPrepayments,
  frmJournalEntry, frmCheque, frmDepositFrm, frmDepositEntry,
  ERPVersionConst, frmReconciliationVerify , BusobjReconciliation;

{$R *.dfm}
{ TRecMismatchGui }

procedure TRecMismatchGui.btnupdateClick(Sender: TObject);
var
  tmpScript:TERPScript;
begin
  inherited;
//  inherited;
  TmpScript:= TempMyScript;
  With TmpScript do try
    DoBackup(tmpScript);
    MakeUpdateForAccunt(tmpScript);
  finally
    Free;
  end;
end;

procedure TRecMismatchGui.cmdPrintClick(Sender: TObject);
var
  s:STring;
  strSQL:String;
begin

//  inherited;
  if qryAccount.active = False then qryAccount.open;
  if qryAccount.recordcount =0 then exit;
  s:= '';
  showProgressbar(WAITMSG,qryAccount.recordcount);
  try
    qryAccount.First;
    While qryAccount.eof = False do begin
      RefreshQuery;
      if s<> '' then s := s+ ' union all';
      strSQL:= makeQry(fsDeposittablename+'_'+ intToStr(qryAccountAccountID.asInteger),fsWithdrawaltablename+'_'+ intToStr(qryAccountAccountID.asInteger), qryAccountAccountID.asInteger );
      s:= s+ strSQL;
      qryAccount.next;
      stepProgressbar;
    end;
  finally
    HideProgressbar;
  end;

  if s= '' then exit;
  s:= '{CompInfo}SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City, CO.State, CO.Postcode, Concat("Phone ",CO.PhoneNumber) AS PhoneNumber, Concat("Fax ",CO.FaxNumber) AS FaxNumber, CO.ABN FROM tblCompanyInformation AS CO' +
          '~|||~{Details}' + s+ ' Order by Mismatch, CAtegory ,  DepositDate';
  PrintTemplate.ReportSQLSupplied := TRue;
  PrintTemplate.PrintTemplateReport('Reconcilable transactions', s, False, 1);
end;

procedure TRecMismatchGui.DNMSpeedButton1Click(Sender: TObject);
var
  tmpScript:TERPScript;
begin
//  inherited;
  if qryAccount.active = False then qryAccount.open;
  if qryAccount.recordcount =0 then exit;
  TmpScript:= TempMyScript;
  With TmpScript do try
    DoBackup(tmpScript);
    showProgressbar(WAITMSG,qryAccount.recordcount);
    try
      qryAccount.first;
      While qryAccount.eof = False do begin
        RefreshQuery;
        MakeUpdateForAccunt(tmpScript);
        qryAccount.next;
        stepProgressbar;
      end;
    finally
      HideProgressbar;
    end;
    Execute;
  finally
    Free;
  end;
end;

Procedure TRecMismatchGUI.Dobackup(tmpScript:TERPScript);
var
  fstablename :String;
  tablePrefix :String;
begin
    tablePrefix := replacestr(TABLE_VERSION , '.' , '')+'_1';
    fstablename :='erpfix_bankdepositlines' + TablePrefix;
    if not tableexists(fstablename) then tmpScript.sql.add('create table ' +fstablename +' Select * from tblbankdepositlines;')
    else tmpScript.sql.add('insert ignore into  ' +fstablename +' Select * from tblbankdepositlines;');
    fstablename :='erpfix_bankdeposit' + TablePrefix;
    if not tableexists(fstablename) then tmpScript.sql.add('create table ' +fstablename +' Select * from tblbankdeposit;')
    else tmpScript.sql.add('insert ignore into  ' +fstablename +' Select * from tblbankdeposit;');
end;
Procedure TRecMismatchGUI.MakeUpdateForAccunt(tmpScript:TERPScript);
var
  s:String;
begin
          Qrymain.First;
          While Qrymain.Eof = False do begin
            s:= '';
                  if SameText(QrymainCategory.asString , 'Deposit') and (QrymainReconciled.asBoolean ) and (Qrymainseqno.asInteger in [1,2,3,5]) and (QrymainDepositLineID.asInteger <> 0) then
                      s:= 'update  tblbankdepositlines Set  Reconciled = "F" where DepositLineID = ' +inttostr(QrymainDepositLineID.asInteger) +';'
            else  if SameText(QrymainCategory.asString , 'Deposit') and (QrymainReconciled.asBoolean ) and (Qrymainseqno.asInteger in [4,6,7,8]) and (QrymainDepositID.asInteger <> 0) then
                      s:= 'update  tblbankdeposit Set  Reconciled = "F" where DepositID = ' +inttostr(QrymainDepositID.asInteger) +';'
            else  if SameText(QrymainCategory.asString , 'Withdrawal') and (QrymainReconciled.asBoolean ) and (Qrymainseqno.asInteger in [1,4,5,6]) and (QrymainDepositLineID.asInteger <> 0) then
                      s:= 'update  tblbankdepositlines Set  Reconciled = "F" where DepositLineID = ' +inttostr(QrymainDepositLineID.asInteger) +';'
            else  if SameText(QrymainCategory.asString , 'Withdrawal') and (QrymainReconciled.asBoolean ) and (Qrymainseqno.asInteger in [2,3,7,8]) and (QrymainDepositID.asInteger <> 0) then
                      s:= 'update  tblbankdeposit Set  Reconciled = "F" where DepositID = ' +inttostr(QrymainDepositID.asInteger) +';'
            else if SameText(QrymainCategory.asString , 'Deposit') and (QrymainReconciled.asBoolean =False) and (Qrymainseqno.asInteger in [1,2,3,5]) and (QrymainDepositLineID.asInteger <> 0) then
                      s:= 'update  tblbankdepositlines Set  Reconciled = "T" where DepositLineID = ' +inttostr(QrymainDepositLineID.asInteger) +';'
            else  if SameText(QrymainCategory.asString , 'Deposit') and (QrymainReconciled.asBoolean =False) and (Qrymainseqno.asInteger in [4,6,7,8]) and (QrymainDepositID.asInteger <> 0) then
                      s:= 'update  tblbankdeposit Set  Reconciled = "T" where DepositID = ' +inttostr(QrymainDepositID.asInteger) +';'
            else  if SameText(QrymainCategory.asString , 'Withdrawal') and (QrymainReconciled.asBoolean =False) and (Qrymainseqno.asInteger in [1,4,5,6]) and (QrymainDepositLineID.asInteger <> 0) then
                      s:= 'update  tblbankdepositlines Set  Reconciled = "T" where DepositLineID = ' +inttostr(QrymainDepositLineID.asInteger) +';'
            else  if SameText(QrymainCategory.asString , 'Withdrawal') and (QrymainReconciled.asBoolean =False ) and (Qrymainseqno.asInteger in [2,3,7,8]) and (QrymainDepositID.asInteger <> 0) then
                      s:= 'update  tblbankdeposit Set  Reconciled = "T" where DepositID = ' +inttostr(QrymainDepositID.asInteger) +';';
            if s<> '' then tmpScript.SQL.add(s);
            Qrymain.Next;
          end;
end;
procedure TRecMismatchGui.qryAccountBeforeClose(DataSet: TDataSet);
begin
  inherited;
  DEleteTable(fsDeposittablename);
  DEleteTable(fsWithdrawaltablename);
  While qryAccount.eof = False do begin
    DEleteTable(fsDeposittablename+'_'+ intToStr(qryAccountAccountID.asInteger));
    DEleteTable(fsWithdrawaltablename+'_'+ intToStr(qryAccountAccountID.asInteger));
    qryAccount.next;
  end;
end;

procedure TRecMismatchGui.FormCreate(Sender: TObject);
begin
  inherited;
  fsDeposittablename:= GetUserTemporaryTableName('Deposit');
  fsWithdrawaltablename:=GetUserTemporaryTableName('Withdraw');
end;

procedure TRecMismatchGui.FormShow(Sender: TObject);
begin
  opendb(qryAccount);
  if cboAccount.text = '' then begin
    if qryAccount.RecordCount > 0 then begin
        qryAccount.first;
        cboAccount.text := qryAccountAccountName.asString;
    end;
  end;
  inherited;
end;

procedure TRecMismatchGui.grdMainDblClick(Sender: TObject);
var
  iDepositId: integer;
  iPayID: integer;
  (* bOk: boolean; *)
  sTransType: string;
  (* qry: TERPQuery; *)
  SavedAccessLevel: integer;
begin
      iDepositID := QrymainPaymentId.asInteger;
      if iDepositID = 0 then Exit;

      sTransType := Qrymainnotes.asString;

      if (sTransType = DEPOSIT_ENTRY) or (sTransType = BANK_DEPOSIT) or (sTransType = DEPOSIT_SPLIT) then begin
        iPayID := iDepositID;
      end else begin
        iPayID := GetDepositPaymentID(iDepositID, sTransType);
      end;

      if iPayID <> 0 then begin
        SavedAccessLevel:= self.AccessLevel;
        if Sysutils.SameText(sTransType, CUSTOMER_PAYMENT) then begin
          with TfmCustPayments.Create(Self) do try
              KeyID := iPayID;
              Position := poScreenCenter;
              ShowModal;
            finally
              Free;
            end;
        end else if Sysutils.SameText(sTransType, SUPPLIER_PAYMENT) then begin
          with TfmSuppPayments.Create(Self) do try
              KeyID := iPayID;
              Position := poScreenCenter;
              ShowModal;
            finally
              Free;
            end;
        end else if Sysutils.SameText(sTransType, CUSTOMER_PREPAYMENT) then begin
          with TfmCustPrepayments.Create(Self) do try
              KeyID := iPayID;
              Position := poScreenCenter;
              ShowModal;
            finally
              Free;
            end;
        end else if Sysutils.SameText(sTransType, SUPPLIER_PREPAYMENT) then begin
          with TfmSuppPrepayments.Create(Self) do try
              KeyID := iPayID;
              Position := poScreenCenter;
              ShowModal;
            finally
              Free;
            end;
        end else if Sysutils.SameText(sTransType, JOURNAL_ENTRY) then begin
          with TJournalEntryGUI.Create(Self) do try
              KeyID := iPayID;
              Position := poScreenCenter;
              ShowModal;
            finally
              Free;
            end;
        end else if Sysutils.SameText(sTransType, CHEQUE) then begin
          with TfmCheque.Create(Self) do try
              KeyID := iPayID;
              Position := poScreenCenter;
              ShowModal;
            finally
              Free;
            end;
        end else if Sysutils.SameText(sTransType, CHEQUE_DEPOSIT) then begin
          with TfmCheque.Create(Self) do try
              KeyID := iPayID;
              Position := poScreenCenter;
              ShowModal;
            finally
              Free;
            end;
        end else if Sysutils.SameText(sTransType, BANK_DEPOSIT) then begin
          with TDepositGUI.Create(Self) do try
              KeyID := iPayID;
              Position := poScreenCenter;
              ShowModal;
            finally
              Free;
            end;
        end else if Sysutils.SameText(sTransType, DEPOSIT_ENTRY) then begin
          with TDepositEntryGUI.Create(Self) do try
              KeyID := iPayID;
              Position := poScreenCenter;
              ShowModal;
            finally
              Free;
            end;
        end else if Sysutils.SameText(sTransType, DEPOSIT_SPLIT) then begin
          with TDepositEntryGUI.Create(Self) do try
              KeyID := iPayID;
              Position := poScreenCenter;
              ShowModal;
            finally
              Free;
            end;
        end else begin
          CommonLib.MessageDlgXP_Vista('No Information is available for this Transaction Type', mtInformation, [mbOK], 0);
          (* bOk := false; *)

        end;


        { have to restore access level here as opening forms above with self as
          owner will change this forms access level }
        self.AccessLevel:= SavedAccessLevel;
     end;
end;

function TRecMismatchGui.GetDepositPaymentID(const DepositID: integer;const TrnsType: string): integer;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    if Empty(TrnsType) then begin
      qryTemp.Sql.Add('SELECT PaymentID  FROM tblbankdepositlines Where DepositID = ' + QuotedStr(IntToStr(DepositID)) + ';');
    end else begin
      qryTemp.Sql.Add('SELECT PaymentID  FROM tblbankdepositlines WHERE DepositID = ' + QuotedStr(IntToStr(DepositID)));
      qryTemp.Sql.Add(' AND TrnsType=' + QuotedStr(Trim(TrnsType)) + ';');
    end;

    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('PaymentID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

(* function TRecMismatchGui.GetWithdrawalPaymentID(const DepositID: integer): integer;
var
  qryTemp: TERPQuery;
begin
  REsult :=0;
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT PaymentID  FROM tblbankdepositlines Where DepositID = ' + QuotedStr(IntToStr(DepositID)) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('PaymentID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end; *)
procedure TRecMismatchGui.RefreshQuery;
begin
  Qrymain.Disablecontrols;
  try
    closedb(Qrymain);
    Qrymain.SQL.clear;
    Qrymain.SQL.add(makeQry(fsDeposittablename ,fsWithdrawaltablename, qryAccountAccountID.asInteger));
    inherited;
  finally
    Qrymain.Enablecontrols;
  end;
end;

Function TRecMismatchGui.MakeQry(Deposittablename ,Withdrawaltablename:STring; AccountID:Integer;ShowInvalidsOnly:boolean = true):String;
var
  recform:TfmReconciliationVerify;
  Qry:TERPscript;
begin
  recform := TfmReconciliationVerify(GetcomponentByclassname('TfmReconciliationVerify',False , Self ));
  try
    qry := TempMyScript ;
    try
        with TReconciliation.create(self) do try
          AccountID := 200; // test accountid
          ListofToBeReconciled := False;
          qry.SQl.add('Drop table if exists ' + Deposittablename+';');
          qry.SQl.add('Create table ' + Deposittablename);
          qry.SQL.add(GuiDepositLines.SQL+';');
          qry.SQl.add('Drop table if exists ' + Withdrawaltablename+';');
          qry.SQl.add('Create table ' + Withdrawaltablename);
          qry.SQL.add(GuiWithdrawLines.SQL+';');
          qry.SQL.text := replacestr(qry.SQl.text , ':xAccountID' , inttostr(AccountID));
          qry.Execute;
        finally
          free;
        end;

    finally
      Free;
    end;
  finally
    Freeandnil(recform);
  end;

  REsult := '';
  REsult := Result + ' Select "Deposit" as Category , Deposit.*  , REc.Deleted , Rec.finished,';
  REsult := result +' if(ifnull(Deposit.Reconciled,"F")  <>ifnull(Reclines.REconciled , "F") , "T" , "F") as Mismatch';
  REsult := Result + ' From '+ Deposittablename +' Deposit  ';
  REsult := Result + ' Left  join (tblreconciliationdepositlines Reclines  ';
  REsult := Result + ' inner join tblreconciliation Rec on Rec.reconciliationId  = Reclines.reconciliationId and Rec.Deleted ="F" and Rec.Finished ="T") on ';
  REsult := Result + '       ifnull(Deposit.DepositDate,0)	  = ifnull(Reclines.DepositDate ,0)';
  REsult := Result + ' /*and   ifnull(Deposit.ReferenceNo,"")	= ifnull(Reclines.Reference ,"")*/';
  REsult := Result + ' and   ifnull(Deposit.CompanyName,"")	= ifnull(Reclines.Payee ,"")';
  REsult := Result + ' and   ifnull(Deposit.Notes,"")	      = ifnull(Reclines.Notes ,"")';
  REsult := Result + ' and   SameValue(ifnull(Deposit.Amount,0)	      , ifnull(Reclines.Amount,0),5) = 1 ';
  REsult := Result + ' and   ifnull(Deposit.DepositID,0)	    = ifnull(Reclines.PaymentId,0)';
  REsult := Result + ' and   ifnull(Reclines.accountid,0) ='+inttostr(AccountID);
  REsult := Result + ' and   ifnull(Deposit.DepositLineID ,0)= ifnull(Reclines.DepositLineID,0)';
  REsult := Result + ' and   ifnull(Deposit.CusID,0)	        = ifnull(Reclines.ClientID,0)';
  if ShowInvalidsOnly then REsult := Result + ' where ifnull(Deposit.Reconciled,"F")  <>ifnull(Reclines.REconciled , "F")';
  REsult := Result + 'union all';
  REsult := Result + ' Select "Withdrawal" as Category , Withdrawal.* , REc.Deleted , Rec.finished,';
  REsult := result +' if(ifnull(Withdrawal.Reconciled,"F")  <>ifnull(Reclines.REconciled , "F") , "T" , "F") as Mismatch';
  REsult := Result + ' From '+ Withdrawaltablename +' Withdrawal  ';
  REsult := Result + ' Left  join (tblreconciliationwithdrawallines Reclines  ';
  REsult := Result + ' inner join tblreconciliation Rec on Rec.reconciliationId  = Reclines.reconciliationId and Rec.Deleted ="F" and Rec.Finished ="T") on ';
  REsult := Result + '    ifnull(Withdrawal.DepositID,0)		  = ifnull(Reclines.PaymentId,0)';
  REsult := Result + ' and   ifnull(Withdrawal.CompanyName,"")		= ifnull(Reclines.Payee,"")';
  REsult := Result + ' and   ifnull(Reclines.Accountid,0) = '+ inttostr(AccountID);
  REsult := Result + ' and   Samevalue(ifnull(Withdrawal.Amount,0)		      , ifnull(Reclines.Amount,0) , 5) = 1';
  REsult := Result + ' and   ifnull(Withdrawal.Notes,"")		      = ifnull(Reclines.Notes,"")';
  REsult := Result + ' and   ifnull(Withdrawal.DepositLineID,0)	= ifnull(Reclines.DepositLineID,0)';
  REsult := Result + ' and     ifnull(Withdrawal.DepositDate,0)    = ifnull(Reclines.DepositDate,0)';
  REsult := Result + ' /*and   ifnull(Withdrawal.ReferenceNo,"")		= ifnull(Reclines.Reference,"")*/';
  REsult := Result + ' and   ifnull(Withdrawal.CusID,0)		      = ifnull(Reclines.ClientID,0)';
  if ShowInvalidsOnly then REsult := Result + ' where ifnull(Withdrawal.Reconciled ,"F")  <>ifnull(Reclines.REconciled , "F")';
  //REsult := Result + ' Order by CAtegory ,  DepositDate';
end;
initialization
  RegisterClassOnce(TRecMismatchGui);

end.

