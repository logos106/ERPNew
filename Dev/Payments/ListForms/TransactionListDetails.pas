unit TransactionListDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TTransactionListDetailsGUI = class(TBaseListingGUI)
    qryMainDate: TDateField;
    qryMainGlobalRef: TWideStringField;
    qryMainType: TWideStringField;
    qryMainClassID: TIntegerField;
    qryMainSaleID: TIntegerField;
    qryMainSeqno: TFloatfield;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainPaymentID: TIntegerField;
    qryMainAccountName: TWideStringField;
    qryMainAccountID: TIntegerField;
    qryMainDebitsEx: TFloatField;
    qryMainEXDiff: TFloatField;
    qryMainIncDiff: TFloatField;
    qryMainCreditsEx: TFloatField;
    qryMainDebitsInc: TFloatField;
    qryMainCreditsInc: TFloatField;
    qryMainClientName: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainProductDesc: TWideStringField;
    qryMainTaxCode: TWideStringField;
    qryMainAccountType: TWideStringField;
    qryMainAccountNumber: TWideStringField;
    qryMainPrepaymentID: TIntegerField;
    qryMainFixedAssetId: TIntegerField;
    procedure FormCreate(Sender: TObject);
  private
    Procedure MakeQrymain(Tablename, transtype:String;globalref:String);
  Protected
    procedure RefreshTotals; override;
    Procedure SetGridColumns;Override;
  public
    class Procedure DoTransactionListDetails(Tablename, transtype:String;globalref:String);
    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonLib;

{$R *.dfm}

{ TTransactionListDetailsGUI }

class procedure TTransactionListDetailsGUI.DoTransactionListDetails(Tablename, transtype,globalref: String);
begin
  with TTransactionListDetailsGUI.create(nil) do try
    MakeQrymain(Tablename, transtype, globalref);
    showmodal;
  finally
    Free;
  end;
end;

procedure TTransactionListDetailsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  Addcalccolumn(Qrymain.fieldbyname('debitsex').FieldName , true);
  Addcalccolumn(Qrymain.fieldbyname('creditsEx').FieldName , true);
  Addcalccolumn(Qrymain.fieldbyname('debitsinc').FieldName , true);
  Addcalccolumn(Qrymain.fieldbyname('creditsinc').FieldName , true);
  Addcalccolumn(Qrymain.fieldbyname('EXDiff').FieldName , true);
  Addcalccolumn(Qrymain.fieldbyname('IncDiff').FieldName , true);

end;

procedure TTransactionListDetailsGUI.MakeQrymain(Tablename, transtype, globalref: String);
begin
  With Scriptmain do begin
      SQL.clear;
      SQL.add('Drop table if exists '+ Tablename+'Details'+';');
      SQL.add('create table ' + Tablename+'Details ' + ' like '+Tablename +';');
            SQL.Add('insert into ' + Tablename+'Details' );
            SQL.Add('(Category , Date,');
            SQL.Add('GlobalRef,');
            SQL.Add('Type,');
            SQL.Add('`Client Name`,');
            SQL.Add('ClassID,');
            SQL.Add('SaleID,');
            SQL.Add('PurchaseOrderID,');
            SQL.Add('PaymentID,');
            SQL.Add('PrepaymentID,');
            SQL.Add('FixedAssetID,');
            SQL.Add('AccountName,');
            SQL.Add('AccountID,');
            SQL.Add('`Account Type` ,');
            SQL.Add('DebitsEx,');
            SQL.Add('CreditsEx,');
            SQL.Add('DebitsInc,');
            SQL.Add('CreditsInc,');
            SQL.Add('CashDebitsEx,');
            SQL.Add('CashCreditsEx,');
            SQL.Add('CashDebitsInc,');
            SQL.Add('CashCreditsInc,');
            SQL.Add('ProductName,');
            SQL.Add('ProductGroup,');
            SQL.Add('ProductDesc,');
            SQL.Add('TaxCode,');
            SQL.Add('Account, AccountNumber, EmployeeID, Seqno, transId ');
            SQL.Add(')');
            SQL.add('SELECT 1, ');
            SQL.add('Trans.Date ,');
            SQL.add('Trans.GlobalRef ,');
            SQL.add('Trans.Type ,');
            SQL.add('ClientName ,');
            SQL.add('Trans.ClassID ,');
            SQL.add('Trans.SaleID ,');
            SQL.add('Trans.PurchaseOrderID ,');
            SQL.add('Trans.PaymentID ,');
            SQL.add('Trans.PrepaymentID ,');
            SQL.add('Trans.FixedAssetID ,');
            SQL.add('SUBSTRING(If((char_length(AccountGroup)>0),');
            SQL.add('Concat(Replace(AccountGroup,"^"," - ") ," - ",');
            SQL.add('Trans.AccountName),Trans.AccountName),1,255) ,');
            SQL.add('Trans.AccountID ,');
            SQL.add('tblacctypedesc.AccDesc ,');
            SQL.add('DebitsEx ,');
            SQL.add('CreditsEx ,');
            SQL.add('DebitsInc ,');
            SQL.add('CreditsInc ,');
            SQL.add('Cash_DebitsEx ,');
            SQL.add('Cash_CreditsEx ,');
            SQL.add('Cash_DebitsInc ,');
            SQL.add('Cash_CreditsInc ,');
            SQL.add('ProductName ,');
            SQL.add('ProductGroup ,');
            SQL.add('ProductDesc ,');
            SQL.add('Trans.TaxCode ,');
            SQL.add('Trans.AccountName ,');
            SQL.add('tblchartofaccounts.AccountNumber ,');
            SQL.add('Trans.EmployeeID, trans.Seqno , trans.transId  ');
            SQL.add('FROM tbltransactions as Trans');
            SQL.add('INNER JOIN tblchartofaccounts Using(AccountID)');
            SQL.add('LEFT JOIN tblacctypedesc On tblacctypedesc.AccType=Trans.AccountType ');
            SQL.add('Where trans.type = ' +quotedstr(transtype));
            SQL.add('and trans.globalref = ' +  quotedstr(globalref));
            Execute;
            SQL.clear;
  end;

    closedb(Qrymain);
    Qrymain.SQL.clear;
      Qrymain.SQL.add('select ');
      Qrymain.SQL.add('Seqno as Seqno,');
      Qrymain.SQL.add('`DATE` as `DATE` ,');
      Qrymain.SQL.add('GLOBALREF as GLOBALREF ,');
      Qrymain.SQL.add('`TYPE` as `TYPE` ,');
      Qrymain.SQL.add('`CLIENT NAME` as `CLIENT NAME` ,');
      Qrymain.SQL.add('CLASSID as CLASSID ,');
      Qrymain.SQL.add('SALEID as SALEID ,');
      Qrymain.SQL.add('PURCHASEORDERID as PURCHASEORDERID ,');
      Qrymain.SQL.add('PAYMENTID as PAYMENTID ,');
      Qrymain.SQL.add('PREPAYMENTID as PREPAYMENTID ,');
      Qrymain.SQL.add('FIXEDASSETID as FIXEDASSETID ,');
      Qrymain.SQL.add('ACCOUNTNAME as ACCOUNTNAME ,');
      Qrymain.SQL.add('ACCOUNTID as ACCOUNTID ,');
      Qrymain.SQL.add('`ACCOUNT TYPE` as `ACCOUNT TYPE` ,');
      Qrymain.SQL.add('(DEBITSEX) as DEBITSEX ,');
      Qrymain.SQL.add('(CREDITSEX) as CREDITSEX ,');
      Qrymain.SQL.add('(DEBITSINC) as DEBITSINC ,');
      Qrymain.SQL.add('(CREDITSINC) as CREDITSINC ,');
      Qrymain.SQL.add('(CREDITSEX- DEBITSEX )  as EXDiff,');
      Qrymain.SQL.add('(CREDITSINC - DEBITSINC ) as IncDiff ,');
      Qrymain.SQL.add('(CASHDEBITSEX) as CASHDEBITSEX ,');
      Qrymain.SQL.add('(CASHCREDITSEX) as CASHCREDITSEX ,');
      Qrymain.SQL.add('(CASHDEBITSINC) as CASHDEBITSINC ,');
      Qrymain.SQL.add('(CASHCREDITSINC) as CASHCREDITSINC ,');
      Qrymain.SQL.add('PRODUCTNAME as PRODUCTNAME ,');
      Qrymain.SQL.add('PRODUCTGROUP as PRODUCTGROUP ,');
      Qrymain.SQL.add('PRODUCTDESC as PRODUCTDESC ,');
      Qrymain.SQL.add('TAXCODE as TAXCODE ,');
      Qrymain.SQL.add('ACCOUNT as ACCOUNT ,');
      Qrymain.SQL.add('Seqno as Seqno ,');
      Qrymain.SQL.add('ACCOUNTNUMBER as ACCOUNTNUMBER ,');
      Qrymain.SQL.add('EMPLOYEEID       as EMPLOYEEID ');
      Qrymain.SQL.add('from ' + tablename +'Details' );
      RefreshOrignalSQL;
end;

procedure TTransactionListDetailsGUI.RefreshQuery;
begin

  inherited;

end;

procedure TTransactionListDetailsGUI.RefreshTotals;
begin
  inherited;
  Calcnshowfooter;
end;

procedure TTransactionListDetailsGUI.SetGridColumns;
begin
  inherited;
    RemoveFieldfromGrid('ClassID');
    RemoveFieldfromGrid('SaleID');
    RemoveFieldfromGrid('PurchaseOrderID');
    RemoveFieldfromGrid('PaymentID');
    RemoveFieldfromGrid('AccountID');
    RemoveFieldfromGrid('PrepaymentID');
    if not devmode then begin
      RemoveFieldfromGrid('Seqno');
      RemoveFieldfromGrid('exdiff');
      RemoveFieldfromGrid('incdiff');
    end;
end;

end.
