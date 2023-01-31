unit VerifynFixPayments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  BusObjBase,Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, BusObjTrans, DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TVerifynFixPaymentsGUI = class(TBaseListingGUI)
    grdPayments: TwwDBGrid;
    wwIButton1: TwwIButton;
    dsPayments: TDataSource;
    qryMaintotalAmountinc: TFloatField;
    qryMainbalance: TFloatField;
    qryMainPayment: TFloatField;
    qryMainTransId: TIntegerField;
    qryMainTRansPayment: TFloatField;
    QryPayments: TERPQuery;
    QryPaymentsTRansID: TIntegerField;
    QryPaymentsReconciled: TWideStringField;
    QryPaymentsPaymentDate: TDateField;
    QryPaymentsReconciliationID: TIntegerField;
    QryPaymentsPayment: TFloatField;
    QryPaymentsAmountOutstanding: TFloatField;
    QryPaymentsAmountDue: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdMainRowChanged(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    fstablename:String;
    fstablenamefix:String;

    (*Procedure fixsalesBalance;*)
    function Payments:double;
    procedure Updatetrans;
    function CreateTransObj :(*TTransBase;*)TBusobj;
  Protected
    Transactiontablename :String;
    PaymentTablename :String;
    PaymentLineTablename :String;
    IDFieldName:String;
    TransIDFieldName:String;
    TRanstype:String;
  public
    Procedure RefreshQuery; override;
    Class Procedure VerifynFixCustPayments;
    Class Procedure VerifynFixSuppPayments;
    Class Procedure VerifynFixSuppPrePayments;
    Class Procedure VerifynFixCustPrePayments;
    
  end;


implementation

uses CommonLib, CommonDbLib, FastFuncs, BusObjSales,
  busobjOrders, AppEnvironment, EmployeeObj, busobjPrepayments, tcConst,
  ERPErrorEmailUtils;

{$R *.dfm}
{ TIncorrectCustPaymentsGUI }

procedure TVerifynFixPaymentsGUI.RefreshQuery;
begin
  with CommonDbLib.TempMyScript do try

    SQL.add('drop table if exists ' +fsTablename+';');
    SQL.add(' create table  ' +fsTablename+
              '  Select DL.' + TransIDFieldName + ' as TRansID, Round(Sum(if(ifnull(D.Deleted,"F") = "F" , DL.Payment, 0)),'+inttostr(CurrencyRoundPlaces)+')  as Payment  ' +
              ' from  ' + PaymentLineTablename + ' AS DL   ' +
              ' Inner Join ' + PaymentTablename + ' AS D ON DL.PaymentID = D.PaymentID  ' +
              ' WHERE ifnull(DL.' + TransIDFieldName + ',0) <> 0  ' );
    if Sysutils.SameText(TRanstype, 'Sales') then begin
        Sql.Add(' AND D.CustomerPayment="T" AND D.Customer="T" AND D.Deleted="F" AND DL.TrnType<>"Prepayment" ');
    end else if Sysutils.SameText(TRanstype, 'PO') then begin
        Sql.Add(' AND D.SupplierPayment="T" AND D.Supplier="T" AND D.Deleted="F" AND DL.TrnType<>"Prepayment" ');
    end;

    SQL.add('  group by DL.' + TransIDFieldName + ';');
    SQL.add('ALTER TABLE ' +fsTablename+' ADD INDEX `' + TransIDFieldName + '`(TRansID), ADD INDEX `Payment`(`Payment`);');
    EXECUTE;
  finally
      free;
  end;
  closeDB(Qrymain);
  opendb(Qrymain);
  opendb(QryPayments);
 inherited;

end;

procedure TVerifynFixPaymentsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fsTablename := GetUserTemporaryTableName('IncorrectPayments_'+TRanstype);
  fstablenamefix:= GetUserTemporaryTableName('IncorrectPaymentsfix_'+TRanstype);
end;

procedure TVerifynFixPaymentsGUI.FormShow(Sender: TObject);
begin
  CloseDB(qrymain);
  qrymain.Sql.clear;

  if (Sysutils.SameText(TRanstype, 'Sales')) or (Sysutils.SameText(TRanstype, 'PO')) then begin
    qrymain.Sql.Add('select M.' + IDFieldName + ' as TransID, M.totalAmountinc, M.balance, T.Payment, M.Payment as TransPayment ' +
                      ' from ' + Transactiontablename + ' M  ' +
                      ' lEFT  join ' + fstablename +' as T on T.transID = M.' + IDFieldName + '     ' +
                      ' where ((round(IFNULL(T.Payment,0),'+inttostr(CurrencyRoundPlaces)+') <> round(M.Payment,'+inttostr(CurrencyRoundPlaces)+') )    ' +
                      ' OR (round(IFNULL(M.balance,0),'+inttostr(CurrencyRoundPlaces)+') <> round(ifnull(M.totalAmountinc,0) - ifnull(M.Payment,0),'+inttostr(CurrencyRoundPlaces)+')))');
    if Sysutils.SameText(TRanstype, 'Sales') then begin
      qrymain.Sql.Add(' and (M.IsInvoice = "T"  or M.Isrefund = "T")');
    end else begin
      qrymain.Sql.Add(' and (M.Isbill = "T" or M.ISPO = "T")');
    end;
  end else begin
      qrymain.Sql.Add('select M.' + IDFieldName + ' as TransID, M.PayAmount as totalAmountinc, M.balance, 0-T.Payment as Payment, M.Payment as TransPayment ' +
                      ' from ' + Transactiontablename + ' M  ' +
                      ' lEFT  join ' + fstablename +' as T on T.transID = M.' + IDFieldName + '     ' +
                      ' where ((round(0-IFNULL(T.Payment,0),'+inttostr(CurrencyRoundPlaces)+') <> round(M.Payment,'+inttostr(CurrencyRoundPlaces)+') )   ' +
                      ' OR (round(IFNULL(M.balance,0),'+inttostr(CurrencyRoundPlaces)+') <> round(ifnull(M.PayAmount,0) - ifnull(M.Payment,0),'+inttostr(CurrencyRoundPlaces)+')))');
    if Sysutils.SameText(TRanstype, 'CustPRepay') then begin
      qrymain.Sql.Add(' and M.Customer = "T" ');
    end else begin
      qrymain.Sql.Add(' and (M.Supplier = "T")');
    end;
  end;


  QryPayments.SQL.text := StringReplace(QryPayments.SQL.text , 'PaymentTablename' , PaymentTablename , [rfReplaceAll, rfIgnoreCase]);
  QryPayments.SQL.text := StringReplace(QryPayments.SQL.text , 'PaymentLineTablename' , PaymentLineTablename , [rfReplaceAll, rfIgnoreCase]);
  QryPayments.SQL.text := StringReplace(QryPayments.SQL.text , 'TransIDFieldName' , TransIDFieldName , [rfReplaceAll, rfIgnoreCase]);
  RefreshOrignalSQL;
  inherited;
 (* fixsalesbalance;*)
 grdPayments.TitleColor := grdmain.TitleColor;
 grdPayments.FooterColor := grdmain.FooterColor;
 grdPayments.Color := grdmain.Color;
end;

(*procedure TVerifynFixPaymentsGUI.fixsalesBalance;
var
  Progressdialog:TProgressdialog;
  invoice:TInvoice;
  strSQL:string;
  fdPayments:double;
  emailtext:String;
begin
  if Qrymain.recordcount = 0 then exit;
  Qrymain.first;
  ProgressDialog := TProgressDialog.Create(nil);
  Invoice :=  TInvoice.create(Self);
  try
    Invoice.connection :=TMydacDataconnection.create(Invoice);
    Invoice.connection.Connection := commondblib.GetNewMyDacConnection(Self);
    ProgressDialog.Caption := 'Please Wait .......';
    ProgressDialog.MinValue := 0;
    ProgressDialog.MaxValue := qrymain.RecordCount;
    ProgressDialog.Step := 1;
    ProgressDialog.Execute;
    EMAILTEXT := '';
    While Qrymain.eof = False do begin
      ProgressDialog.Stepit;
      Invoice.Load(QrymainTransID.asInteger);
      Invoice.connection.BeginTransaction;
      try
        if Invoice.Lock  then begin
          fdPayments := Payments;
          emailtext :=emailtext + chr(13)+'sale:' +QrymainTransID.asString +chr(13) +
                          'Total amount Inc :' +qrymaintotalamountinc.asString+chr(13) +
                          'Balance :' +qrymainBalance.asString+chr(13) +
                          'Sales.Payment    :' +qrymainPayment.asString+chr(13) +
                          'Custoemr.Payment :' +floattoStr(fdPayments)+CHR(13) +
                          '=================================================';

          strSQL:= 'update ' + Transactiontablename + ' set payment = ' +floatToStr(fdPayments) +' where ' + IDFieldName + ' = ' + IntToStr(QrymainTransID.asInteger)+';'+
                  ' update ' + Transactiontablename + ' set Balance = totalamountinc - payment where ' + IDFieldName + ' = ' + IntToStr(QrymainTransID.asInteger)+';'+
                  ' update ' + Transactiontablename + ' set Paid= "T"  where balance = 0 and ' + IDFieldName + ' = ' + IntToStr(QrymainTransID.asInteger)+';'+
                  ' update ' + Transactiontablename + ' set Paid= "F"  where balance <> 0 and ' + IDFieldName + ' = ' + IntToStr(QrymainTransID.asInteger)+';';
          with Invoice.GetNewDataset(strSQL, true) do try
              // kill the dataset in the finally
          finally
              Free;
          end;
          invoice.Connection.CommitTransaction;
        end;
      except
          on E:Exception do begin
              CommonLib.MessageDlgXP_Vista('Update failed' + chr(13) + E.message, mtwarning, [mbok],0);
          end;
      end;
      Qrymain.next;
    end;
    if EMAILTEXT<> '' then
      SendEmailtoErp('Customer payment fix' ,emailtext);
  finally
      Freeandnil(ProgressDialog);
      Freeandnil(Invoice);
  end;
  RefreshQuery;
end;*)

function TVerifynFixPaymentsGUI.Payments: double;
begin
  result := 0;
  if QryPayments.recordcount = 0 then exit;
  QryPayments.first;
  while QryPayments.eof = False do begin
    if (Sysutils.SameText(TRanstype, 'Sales')) or (Sysutils.SameText(TRanstype, 'PO')) then begin
      result := result + QryPayments.fieldbyname('Payment').asfloat;
    end else begin
      result := result - QryPayments.fieldbyname('Payment').asfloat;
    end;
      QryPayments.Next;
  end;
end;

procedure TVerifynFixPaymentsGUI.Updatetrans;
var
  TransObj :  (*TTransBase;*)TBusobj;
  EMAILTEXT:String;
  fdPayments:Double;
  strSql:String;
begin
  Processingcursor(True);
  try
    TRansObj := CreateTransObj;
    try
      EMAILTEXT := '';
        TransObj.Load(QrymainTransID.asInteger);
        TransObj.connection.BeginTransaction;
        try
          (*if TransObj.Lock  then begin*)
          if TRansObj.UserLock.Lock(TRansobj.BusObjectTableName , TRansObj.ID) then begin 
            EMAILTEXT := 'User      : ' +appenv.Employee.EmployeeName +chr(13) +
                   'Database  : ' + TransObj.Connection.Connection.Database+CHR(13) +
                            '================================================='+chr(13);
            fdPayments := Payments;
            emailtext :=emailtext + chr(13)+TRanstype +':' +QrymainTransID.asString +chr(13) +
                            'Total amount Inc   :' +qrymaintotalamountinc.asString+chr(13) +
                            'Balance            :' +qrymainBalance.asString+chr(13) +
                            'Trans.Payment      :' +qrymainPayment.asString+chr(13) +
                            'Client.Payment     :' +floattoStr(fdPayments)+CHR(13) +
                            'fix Trans.Payments : ' +FloattoStr(fdPayments)+CHR(13) +
                            '=================================================';
        if (Sysutils.SameText(TRanstype, 'Sales')) or (Sysutils.SameText(TRanstype, 'PO')) then begin
            strSQL:= 'update ' + Transactiontablename + ' set payment = ' +floatToStr(fdPayments) +' where ' + IDFieldName + ' = ' + IntToStr(QrymainTransID.asInteger)+';'+
                    ' update ' + Transactiontablename + ' set Balance = totalamountinc - payment where ' + IDFieldName + ' = ' + IntToStr(QrymainTransID.asInteger)+';'+
                    ' update ' + Transactiontablename + ' set Paid= "T"  where balance = 0 and ' + IDFieldName + ' = ' + IntToStr(QrymainTransID.asInteger)+';'+
                    ' update ' + Transactiontablename + ' set Paid= "F"  where balance <> 0 and ' + IDFieldName + ' = ' + IntToStr(QrymainTransID.asInteger)+';';
        end else begin
          strSQL:= 'update ' + Transactiontablename + ' set payment = ' +floatToStr(fdPayments) +' where ' + IDFieldName + ' = ' + IntToStr(QrymainTransID.asInteger)+';'+
                    ' update ' + Transactiontablename + ' set Balance = PayAmount - payment where ' + IDFieldName + ' = ' + IntToStr(QrymainTransID.asInteger)+';'+
                    ' update ' + Transactiontablename + ' set Paid= "T"  where balance = 0 and ' + IDFieldName + ' = ' + IntToStr(QrymainTransID.asInteger)+';'+
                    ' update ' + Transactiontablename + ' set Paid= "F"  where balance <> 0 and ' + IDFieldName + ' = ' + IntToStr(QrymainTransID.asInteger)+';';
        end;
            with TransObj.GetNewDataset(strSQL, true) do try
                // kill the dataset in the finally
            finally
                Free;
            end;
            TransObj.Connection.CommitTransaction;
          end;
        except
            on E:Exception do begin
                CommonLib.MessageDlgXP_Vista('Update failed' + chr(13) + E.message, mtwarning, [mbok],0);
            end;
        end;
      if EMAILTEXT<> '' then
        SendEmailtoErp(TransObj.XMLNodename +': Payment fix' ,emailtext);
    finally
        Freeandnil(TransObj);
    end;
    RefreshQuery;
  finally
    Processingcursor(False);
  end;
end;





procedure TVerifynFixPaymentsGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TVerifynFixPaymentsGUI.grdMainRowChanged(Sender: TObject);
begin
  inherited;
  qrypayments.Filtered := False;
  qrypayments.Filter := 'TransId = ' + IntToStr(qrymainTransId.asinteger);
  qrypayments.Filtered := True;

end;

procedure TVerifynFixPaymentsGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  grdMainRowChanged(grdMain);
end;

function TVerifynFixPaymentsGUI.CreateTransObj: (*TTransBase;*)TBusobj;
begin
    if Sysutils.SameText(TRanstype,'CustPrepay') then result := TCustPrePayments.create(self)
    else if Sysutils.SameText(TRanstype,'SuppPrepay') then result := TSuppPrePayments.create(self)
    else if Sysutils.SameText(TRanstype,'Sales') then result := TInvoice.create(self)
    else REsult := TPurchaseOrder.create(Self);
    Result.connection := tMyDacdataconnection.create(Result);
    Result.connection.connection := commondblib.GetNewMyDacConnection(Self);
end;



procedure TVerifynFixPaymentsGUI.grdMainDblClick(Sender: TObject);
begin
  Updatetrans;
end;
class procedure TVerifynFixPaymentsGUI.VerifynFixCustPayments;
begin
  With TVerifynFixPaymentsGUI(getcomponentbyclassname('TVerifynFixPaymentsGUI')) do begin
      Transactiontablename  :='tblSales';
      PaymentTablename      :='tbldeposits';
      PaymentLineTablename  :='tbldepositline';
      IDFieldName           :='SaleId';
      TransIDFieldName      :='SaleId';
      TRanstype             :='Sales';
      Caption := 'Customer Payment';
      TitleLabel.Caption := Caption;
      showmodal;
  end;
end;

class procedure TVerifynFixPaymentsGUI.VerifynFixSuppPayments;
begin
  With TVerifynFixPaymentsGUI(getcomponentbyclassname('TVerifynFixPaymentsGUI')) do begin
      Transactiontablename  :='tblpurchaseorders';
      IDFieldName           :='PurchaseOrderID';
      PaymentTablename      :='tblwithdrawal';
      PaymentLineTablename  :='tblwithdrawallines';
      TransIDFieldName      :='POID';
      TRanstype             :='PO';
      Caption := 'Supplier Payment';
      TitleLabel.Caption := Caption;
      showmodal;
  end;
end;

class procedure TVerifynFixPaymentsGUI.VerifynFixSuppPrePayments;
begin
  With TVerifynFixPaymentsGUI(getcomponentbyclassname('TVerifynFixPaymentsGUI')) do begin
      Transactiontablename  :='tblPrePayments';
      IDFieldName           :='PrePaymentID';
      PaymentTablename      :='tblwithdrawal';
      PaymentLineTablename  :='tblwithdrawallines';
      TransIDFieldName      :='PrepaymentID';
      TRanstype             :='SuppPrepay';
      Caption := 'Supplier Pre-Payment';
      TitleLabel.Caption := Caption;
      showmodal;
  end;
end;

class procedure TVerifynFixPaymentsGUI.VerifynFixCustPrePayments;
begin
  With TVerifynFixPaymentsGUI(getcomponentbyclassname('TVerifynFixPaymentsGUI')) do begin
      Transactiontablename  :='tblPrePayments';
      IDFieldName           :='PrePaymentID';
      PaymentTablename      :='tbldeposits';
      PaymentLineTablename  :='tbldepositline';
      TransIDFieldName      :='PrepaymentID';
      TRanstype             :='CustPrepay';
      Caption := 'Customer Prepayment';
      TitleLabel.Caption := Caption;
      showmodal;
  end;
end;

initialization
  RegisterClassOnce(TVerifynFixPaymentsGUI);
end.
