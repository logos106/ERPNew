unit CashProfitandLoss;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox;

type
  TCashProfitandLossGUI = class(TBaseListingGUI)
    qryMainSeqno: TLargeintField;
    qryMainAccountType: TWideStringField;
    qryMainSAleId: TIntegerField;
    qryMainPurchaseOrderId: TIntegerField;
    qryMainAccountTypedesc: TWideStringField;
    qryMainaccountname: TWideStringField;
    qryMainaccountno: TWideStringField;
    qryMainTaxableAmountEx: TFloatField;
    qryMainTaxableAmountInc: TFloatField;
    qryMainTaxAmount: TFloatField;
    qryMaindetailseqno: TLargeintField;
    qryMainPaymentId: TIntegerField;
    qryMainCashtype: TWideStringField;
    qryMainTranstype: TWideStringField;
    qryMainTransID: TIntegerField;
    qryMainPayTransID: TIntegerField;
    qryMainDate: TDateField;
    btnCashPnl: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grpFiltersClick(Sender: TObject);override;
    procedure grdMainDblClick(Sender: TObject);override;
    procedure btnCashPnlClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Tablename :String;
    procedure OnShowPnLByPeriodGUI(Sender: TObject);
    Procedure MakeQrymain;
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonLib, CashBasis, CommonDbLib, MySQLConst,  CommonFormLib, ProfitandLossReportForm;

{$R *.dfm}

procedure TCashProfitandLossGUI.btnCashPnlClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TProfitandLossGUI' , OnShowPnLByPeriodGUI);
  Self.Close;
end;
procedure TCashProfitandLossGUI.OnShowPnLByPeriodGUI(Sender:TObject);
begin
        if TProfitandLossGUI(Sender).dtTo.DateTime <> self.dtTo.DateTime then TProfitandLossGUI(Sender).dtTo.DateTime := self.dtTo.DateTime;
        if TProfitandLossGUI(Sender).dtFrom.DateTime <> self.dtFrom.DateTime then TProfitandLossGUI(Sender).dtFrom.DateTime := self.dtFrom.DateTime;
        TProfitandLossGUI(Sender).fbDateRangeSupplied := true;
end;

procedure TCashProfitandLossGUI.FormCreate(Sender: TObject);
begin
  fbIncludehistory:= True;
  Tablename := CashBasisReturnTempTableName('CashPnl') (*+'_Sum'*);
  MakeQrymain;
  inherited;
  DisableSortoncolumtitleclick:= TRue;
end;

procedure TCashProfitandLossGUI.FormDestroy(Sender: TObject);
begin
  commondblib.DestroyUserTemporaryTable(CashBasisReturnTempTableName('CashPnl'));
  commondblib.DestroyUserTemporaryTable(CashBasisReturnTempTableName('CashPnl')+'_Sum');
  inherited;
end;

procedure TCashProfitandLossGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if (QrymainDetailSeqno.asInteger = 5) then AFont.style := Afont.style - [fsbold];

  if (QrymainDetailSeqno.asInteger = 6) then begin
    AFont.style := Afont.style + [fsbold];
    AFont.color := clmaroon;
    AFont.size := 12;
    Abrush.color := clLtGray;
  end;

  if (QrymainDetailSeqno.asInteger = 4) then Abrush.color := $00EAEAEA;

  if (SameText(Field.fieldName , QrymainAccounttypeDesc.fieldname))  then
    if (QrymainDetailSeqno.asInteger =2 ) or  (QrymainDetailSeqno.asInteger =3)   then Afont.color := aBrush.color
    else if grpfilters.itemindex >0 then AFont.style := Afont.style + [fsbold]
    else AFont.style := Afont.style - [fsbold];

  if (SameText(Field.fieldName , QrymainAccountNo.fieldname)) or (SameText(Field.fieldName , QrymainAccountName.fieldname))  then
    if (QrymainDetailSeqno.asInteger <>2) and (QrymainDetailSeqno.asInteger <>6) then Afont.color := aBrush.color
    else if grpfilters.itemindex >1 then AFont.style := Afont.style + [fsbold]
    else AFont.style := Afont.style - [fsbold];

  if (SameText(Field.fieldName , qryMainTaxableAmountEx.fieldname)) or (SameText(Field.fieldName , qryMainTaxableAmountInc.fieldname)) or (SameText(Field.fieldName , qryMainTaxAmount.fieldname))  then begin
    if (QrymainDetailSeqno.asInteger =1) or (QrymainDetailSeqno.asInteger =4) then if grpfilters.itemindex >0  then AFont.style := Afont.style + [fsbold] else AFont.style := Afont.style - [fsbold];
    if (QrymainDetailSeqno.asInteger =2) then if grpfilters.itemindex >1  then AFont.style := Afont.style + [fsbold] else AFont.style := Afont.style - [fsbold];
    if (QrymainDetailSeqno.asInteger =3) then  AFont.style := Afont.style - [fsbold];
    if Field.asFloat =0 then   Afont.color := aBrush.color;
  end;

  if (SameText(Field.fieldName , qryMaintransID.fieldname)) then begin
    if Field.asInteger =0 then   Afont.color := aBrush.color;
  end;

end;

procedure TCashProfitandLossGUI.grdMainDblClick(Sender: TObject);
begin
  if (Sametext(ActiveFieldName , Qrymaintranstype.fieldname)) or (Sametext(ActiveFieldName , QrymaintransID.fieldname)) then
       SubsequentID := Chr(95) + qryMainTransType.asString
  else SubsequentID := Chr(95) + qryMainCashType.asString;

  inherited;
end;

procedure TCashProfitandLossGUI.grpFiltersClick(Sender: TObject);
begin
  if Grpfilters.itemindex = 0 then GroupFilterString := 'detailseqno = 5 or detailseqno = 6'
  else if Grpfilters.itemindex = 1 then GroupFilterString := 'detailseqno = 1 or detailseqno = 2 or detailseqno = 4 or detailseqno = 6'
  else GroupFilterString := 'detailseqno <> 5 or detailseqno = 6';
  inherited;

end;

procedure TCashProfitandLossGUI.MakeQrymain;
Function AmountFld(FldType:Integer):String;
var
  fldName:String;
begin
  if FldType =1 then fldName := 'TaxableAmountEx' else if FldType =2 then fldName := 'TaxableAmountInc' else fldName := 'TaxAmount';
  REsult := 'if(accounttype in ("EXP" , "OCLIAB" , "COGS") , 0-' + fldName +', if(ifnull(TaxType,"")="INPUT" /*and ifnull(TransType,"") = "Journal Entry" */, 0-' + fldName +' , ' + fldName +'))';
  //Result := 'if(accounttype in ("EXP" , "OCLIAB" , "COGS") , 0-' + fldName +',' + fldName +')';
end;
begin
Qrymain.SQL.clear;

    Qrymain.SQL.Add('select distinct ');
    Qrymain.SQL.Add('1              as Seqno, ');
    Qrymain.SQL.Add('1              as detailseqno, ');
    Qrymain.SQL.Add('Null           as Cashtype, ');
    Qrymain.SQL.Add('Null           as TRanstype, ');
    Qrymain.SQL.Add('Null           as Date, ');
    Qrymain.SQL.Add('AccountType    as AccountType, ');
    Qrymain.SQL.Add('Null           as SaleId, ');
    Qrymain.SQL.Add('Null           as PurchaseOrderId, ');
    Qrymain.SQL.Add('NULL           as PaymentId,');
    Qrymain.SQL.Add('NULL           as TransID, ');
    Qrymain.SQL.Add('NULL           as PayTransID, ');
    Qrymain.SQL.Add('NULL           as accountname, ');
    Qrymain.SQL.Add('NULL           as accountno, ');
    Qrymain.SQL.Add('NULL           as TaxableAmountEx, ');
    Qrymain.SQL.Add('NULL           as TaxableAmountInc, ');
    Qrymain.SQL.Add('NULL           as TaxAmount , ');
    Qrymain.SQL.Add('AT.AccDEsc     as AccountTypedesc ');
    Qrymain.SQL.Add('from tblAccTypeDesc AT  INNER  join ' + Tablename +' T on AT.AccType = T.accountType');
    Qrymain.SQL.Add(' and Date between :DAteFrom and :DaetTo');
    Qrymain.SQL.Add(' Where AT.Acctype in ("COGS","EXP","INC","EXEXP","EXINC")');
    Qrymain.SQL.Add('group by AT.AccDEsc  ');

    Qrymain.SQL.Add('union all');
    Qrymain.SQL.Add('select distinct ');
    Qrymain.SQL.Add('2                      as Seqno, ');
    Qrymain.SQL.Add('2                      as detailseqno, ');
    Qrymain.SQL.Add('Null                   as Cashtype, ');
    Qrymain.SQL.Add('Null                   as TransType, ');
    Qrymain.SQL.Add('Null                   as Date, ');
    Qrymain.SQL.Add('AccountType            as AccountType, ');
    Qrymain.SQL.Add('Null                   as SAleId, ');
    Qrymain.SQL.Add('Null                   as PurchaseOrderId, ');
    Qrymain.SQL.Add('NULL                   as PaymentId,');
    Qrymain.SQL.Add('NULL                   as TransID,   ');
    Qrymain.SQL.Add('NULL                   as PayTransID,   ');
    Qrymain.SQL.Add('accountname            as accountname, ');
    Qrymain.SQL.Add('accountno              as accountno, ');
    Qrymain.SQL.Add('Sum('+AmountFld(1)+')  as TaxableAmountEx, ');
    Qrymain.SQL.Add('sum('+AmountFld(2)+')  as TaxableAmountInc, ');
    Qrymain.SQL.Add('Sum('+AmountFld(3)+')  as TaxAmount,  ');
    Qrymain.SQL.Add('AT.AccDEsc             as AccountTypedesc  ');
    Qrymain.SQL.Add('from tblAccTypeDesc AT  INNER  join ' + Tablename +' T on AT.AccType = T.accountType');
    Qrymain.SQL.Add(' and Date between :DAteFrom and :DaetTo');
    Qrymain.SQL.Add(' Where AT.Acctype in ("COGS","EXP","INC","EXEXP","EXINC")');
    Qrymain.SQL.Add('Group by AT.AccDEsc  ,accountname, accountno');

    Qrymain.SQL.Add('union all');
    Qrymain.SQL.Add('select distinct ');
    Qrymain.SQL.Add('2                      as Seqno, ');
    Qrymain.SQL.Add('3                      as detailseqno, ');
    Qrymain.SQL.Add('Cashtype               as Cashtype, ');
    Qrymain.SQL.Add('TransType              as TransType, ');
    Qrymain.SQL.Add('Date                   as Date, ');
    Qrymain.SQL.Add('AccountType            as AccountType, ');
    Qrymain.SQL.Add('SAleId                 as SAleId, ');
    Qrymain.SQL.Add('PurchaseOrderId        as PurchaseOrderId, ');
    Qrymain.SQL.Add('PaymentId              as PaymentId,  ');
    Qrymain.SQL.Add('ifnull(PurchaseOrderId,SAleId ) as TransID,   ');
    Qrymain.SQL.Add('PaymentId as PayTransID,   ');
    Qrymain.SQL.Add('accountname            as accountname, ');
    Qrymain.SQL.Add('accountno              as accountno, ');
    Qrymain.SQL.Add('Sum('+AmountFld(1)+')  as TaxableAmountEx, ');
    Qrymain.SQL.Add('sum('+AmountFld(2)+')  as TaxableAmountInc, ');
    Qrymain.SQL.Add('Sum('+AmountFld(3)+')  as TaxAmount,  ');
    Qrymain.SQL.Add('AT.AccDEsc             as AccountTypedesc  ');
    Qrymain.SQL.Add('from tblAccTypeDesc AT  INNER  join ' + Tablename +' T on AT.AccType = T.accountType');
    Qrymain.SQL.Add(' and Date between :DAteFrom and :DaetTo');
    Qrymain.SQL.Add(' Where AT.Acctype in ("COGS","EXP","INC","EXEXP","EXINC")');
    Qrymain.SQL.Add('Group by AT.AccDEsc  ,accountname, accountno, SAleId, PurchaseOrderId, PaymentId');

    Qrymain.SQL.Add('union all');
    Qrymain.SQL.Add('select distinct ');
    Qrymain.SQL.Add('4                      as Seqno, ');
    Qrymain.SQL.Add('4                      as detailseqno,');
    Qrymain.SQL.Add('Null                   as Cashtype, ');
    Qrymain.SQL.Add('Null                   as TransType, ');
    Qrymain.SQL.Add('Null                   as Date, ');
    Qrymain.SQL.Add('AccountType            as AccountType, ');
    Qrymain.SQL.Add('Null                   as SAleId, ');
    Qrymain.SQL.Add('Null                   as PurchaseOrderId, ');
    Qrymain.SQL.Add('NULL                   as PaymentId,');
    Qrymain.SQL.Add('NULL                   as TransID, ');
    Qrymain.SQL.Add('NULL                   as PayTransID, ');
    Qrymain.SQL.Add('NULL                   as accountname, ');
    Qrymain.SQL.Add('NULL                   as accountno, ');
    Qrymain.SQL.Add('Sum('+AmountFld(1)+')  as TaxableAmountEx, ');
    Qrymain.SQL.Add('sum('+AmountFld(2)+')  as TaxableAmountInc, ');
    Qrymain.SQL.Add('Sum('+AmountFld(3)+')  as TaxAmount,  ');
    Qrymain.SQL.Add('concat ("Total " ,  AT.AccDEsc  ) as AccountTypedesc');
    Qrymain.SQL.Add('from tblAccTypeDesc AT  INNER  join ' + Tablename +' T on AT.AccType = T.accountType');
    Qrymain.SQL.Add(' and Date between :DAteFrom and :DaetTo');
    Qrymain.SQL.Add(' Where AT.Acctype in ("COGS","EXP","INC","EXEXP","EXINC")');
    Qrymain.SQL.Add('Group by AT.AccDEsc  ');

    Qrymain.SQL.Add('union all');
    Qrymain.SQL.Add('select distinct ');
    Qrymain.SQL.Add('5                      as Seqno, ');
    Qrymain.SQL.Add('5                      as detailseqno,');
    Qrymain.SQL.Add('Null                   as Cashtype, ');
    Qrymain.SQL.Add('Null                   as TransType, ');
    Qrymain.SQL.Add('Null                   as Date, ');
    Qrymain.SQL.Add('AccountType            as AccountType, ');
    Qrymain.SQL.Add('Null                   as SAleId, ');
    Qrymain.SQL.Add('Null                   as PurchaseOrderId, ');
    Qrymain.SQL.Add('NULL                   as PaymentId,');
    Qrymain.SQL.Add('NULL                   as TransID, ');
    Qrymain.SQL.Add('NULL                   as PayTransID, ');
    Qrymain.SQL.Add('NULL                   as accountname, ');
    Qrymain.SQL.Add('NULL                   as accountno, ');
    Qrymain.SQL.Add('Sum('+AmountFld(1)+')  as TaxableAmountEx, ');
    Qrymain.SQL.Add('sum('+AmountFld(2)+')  as TaxableAmountInc, ');
    Qrymain.SQL.Add('Sum('+AmountFld(3)+')  as TaxAmount,  ');
    Qrymain.SQL.Add('AT.AccDEsc             as AccountTypedesc  ');
    Qrymain.SQL.Add('from tblAccTypeDesc AT  INNER  join ' + Tablename +' T on AT.AccType = T.accountType');
    Qrymain.SQL.Add(' and Date between :DAteFrom and :DaetTo');
    Qrymain.SQL.Add(' Where AT.Acctype in ("COGS","EXP","INC","EXEXP","EXINC")');
    Qrymain.SQL.Add('Group by AT.AccDEsc  ');

    Qrymain.SQL.Add('union all');
    Qrymain.SQL.Add('select distinct ');
    Qrymain.SQL.Add('6                      as Seqno, ');
    Qrymain.SQL.Add('6                      as detailseqno,');
    Qrymain.SQL.Add('Null                   as Cashtype, ');
    Qrymain.SQL.Add('Null                   as TransType, ');
    Qrymain.SQL.Add('Null                   as Date, ');
    Qrymain.SQL.Add('"zzz "                 as AccountType, ');
    Qrymain.SQL.Add('Null                   as SAleId, ');
    Qrymain.SQL.Add('Null                   as PurchaseOrderId, ');
    Qrymain.SQL.Add('NULL                   as PaymentId,');
    Qrymain.SQL.Add('NULL                   as TransID, ');
    Qrymain.SQL.Add('NULL                   as PayTransID, ');
    Qrymain.SQL.Add('NULL                   as accountname, ');
    Qrymain.SQL.Add('NULL                   as accountno, ');
    Qrymain.SQL.Add('Sum('+AmountFld(1)+')  as TaxableAmountEx, ');
    Qrymain.SQL.Add('sum('+AmountFld(2)+')  as TaxableAmountInc, ');
    Qrymain.SQL.Add('Sum('+AmountFld(3)+')  as TaxAmount,  ');
    Qrymain.SQL.Add('"Net Income"           as AccountTypedesc  ');
    Qrymain.SQL.Add('from tblAccTypeDesc AT  INNER  join ' + Tablename +' T on AT.AccType = T.accountType');
    Qrymain.SQL.Add(' and Date between :DAteFrom and :DaetTo');
    Qrymain.SQL.Add(' Where AT.Acctype in ("COGS","EXP","INC","EXEXP","EXINC")');
    Qrymain.SQL.Add('order by if(AccountType="INC",1 , if(AccountType="EXINC",2 , if(AccountType="COGS",3 , if(AccountType="EXP",4 ,if(AccountType="EXEXP", 5,6))))), Accounttype,  Seqno, accountname, accountno , detailseqno');
end;

procedure TCashProfitandLossGUI.RefreshQuery;
begin
    CashBasis.PrepareCashBasisDetails(0,0, 'CashPnL', chkIncludehistory.Checked, true);

    //Tablename := CashBasisReturnTempTableName('CashPnl');
    //if chkIncludehistory.checked then Tablename := Tablename + '_Sum';

    MakeQrymain;
    try
      ExecuteSQLwithProgress('Alter table ' + Tablename +
                                         ' add column accountname varchar(100), '+
                                         ' add column accountType varchar(50),  '+
                                         ' add column accountno   varchar(50),  '+
                                         ' add column Level1      varchar(50),  '+
                                         ' add column Level2      varchar(50),  '+
                                         ' add column Level3      varchar(50),  '+
                                         ' add column Level4      varchar(50); ' +

              'update ' + Tablename +'  T inner join tblchartofaccounts COA on T.AccountID = COA.AccountID  '+
                                         ' Set T.accountname= COA.accountname,  '+
                                         ' T.accountType    = COA.AccountType,  '+
                                         ' T.accountno      = COA.AccountNumber, '+
                                         ' T.Level1         = COA.Level1, '+
                                         ' T.Level2         = COA.Level2, '+
                                         ' T.Level3         = COA.Level3, '+
                                         ' T.Level4         = COA.Level4;'+

              'update ' + Tablename +'  Set Level4 = null where ifnull(Level4, "")="";' +
              'update ' + Tablename +'  Set Level3 = null where ifnull(Level3, "")="";' +
              'update ' + Tablename +'  Set Level2 = null where ifnull(Level2, "")="";' +
              'update ' + Tablename +'  Set Level1 = null where ifnull(Level1, "")="";' +

              'ALTER TABLE ' + Tablename +'  CHANGE COLUMN `PaymentID`        `PaymentID` INT(11) NULL DEFAULT 0 , ' +
                                            'CHANGE COLUMN `SaleID`           `SaleID` INT(11) NULL DEFAULT 0 , ' +
                                            'CHANGE COLUMN `PurchaseOrderID`  `PurchaseOrderID` INT(11) NULL DEFAULT 0 ;' +

              'update ' + Tablename +'  Set PurchaseOrderID   = null where ifnull(PurchaseOrderID, 0)=0;' +
              'update ' + Tablename +'  Set SaleID            = null where ifnull(SaleID         , 0)=0;' +
              'update ' + Tablename +'  Set PaymentID         = null where ifnull(PaymentID      , 0)=0;');
  except
    on E:Exception do begin
      if devmode then MessageDlgXP_vista(E.message, mtWarning, [mbOK], 0);
    end;
  end;

  Qrymain.ParamByName('Datefrom').AsDatetime := FilterDateFrom;
  Qrymain.ParamByName('DaetTo').AsDateTime   := FilterDateTo;
  try
    inherited;
  except
    on E:Exception do begin
      if devmode then MessageDlgXP_vista(E.message, mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TCashProfitandLossGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainAccounttype.fieldname);
  RemoveFieldfromGrid(QrymainDetailSeqno.fieldname);
  RemoveFieldfromGrid(QrymainSeqno.fieldname);
  RemoveFieldfromGrid(qryMainSaleId.fieldname);
  RemoveFieldfromGrid(qryMainPurchaseOrderId.fieldname);
  RemoveFieldfromGrid(qryMainPaymentId.fieldname);
end;

initialization
  RegisterClassOnce(TCashProfitandLossGUI);

end.

