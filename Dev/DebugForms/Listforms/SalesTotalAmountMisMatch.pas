unit SalesTotalAmountMisMatch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TSalesTotalAmountMisMatchGUI = class(TBaseListingGUI)
    grdsub: TwwDBGrid;
    wwIButton1: TwwIButton;
    qrysub: TERPQuery;
    dsSub: TDataSource;
    qryMainSaleId: TIntegerField;
    qryMainTotalAmount: TFloatField;
    qryMaintotalamountinc: TFloatField;
    qryMainlineTotalAmount: TFloatField;
    qryMainPayment: TFloatField;
    qryMainBalance: TFloatField;
    qryMainPaid:TWideStringField;
    qryMainlineTotalAmountinc: TFloatField;
    qryMainDiffEx: TFloatField;
    qryMainDiffInc: TFloatField;
    qryMainSaleDate: TDateField;
    qryMainmsTimeStamp: TDateTimeField;
    qrysubSaleID: TIntegerField;
    qrysubProductID: TIntegerField;
    qrysubPARTTYPE: TWideStringField;
    qrysubProductName: TWideStringField;
    qrysubLinePrice: TFloatField;
    qrysubLinePriceInc: TFloatField;
    qrysubQtySold: TFloatField;
    QrysubmsTimeStamp: TDateTimeField;
    qrysubUnitofMeasureQtySold: TFloatField;
    qrysubShipped: TFloatField;
    qrysubUnitofMeasureShipped: TFloatField;
    qrysubBackOrder: TFloatField;
    qrysubUnitofMeasureBackorder: TFloatField;
    qrysubMarkup: TFloatField;
    qrysubMarkupPercent: TFloatField;
    qrysubDiscountPercent: TFloatField;
    qrysubDiscounts: TFloatField;
    qrysubTotalLineAmount: TFloatField;
    qrysubTotalLineAmountInc: TFloatField;
    qrysubDeleted: TWideStringField;
    qryMainSaletype: TWideStringField;
    qrysubSaleLineID: TIntegerField;
    btndelete: TDNMSpeedButton;
    btnRecalculate: TDNMSpeedButton;
    EdtDiff: TEdit;
    btnMiscProduct: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btndeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdsubDblClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormDestroy(Sender: TObject);
    procedure grdsubCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure btnMiscProductClick(Sender: TObject);
  private
      Tablename1, tablename2, Erpfix_salesmismatch, erpfix_sl, erpfix_s:String;
  refreshed:Boolean;
    Function DeletesaleLine(SilentMode: Boolean;ActionOption:Word):boolean;
    Procedure backupSalesline;
    procedure Progressshow(Sender: TObject; var SQL: String;
      var Omit: Boolean);
    Procedure Readonlymode;
    procedure OnScriptError(Sender: TObject; E: Exception; SQL: String;
      var Action: TErrorAction);
    Procedure RefreshQrySub;
    function Diffvalue: String;
  public
    Procedure RefreshQuery; override;
  end;


implementation

uses CommonLib, CommonDbLib, ProductQtyLib, FastFuncs, BusObjSales,
  BusObjBase, AppEnvironment, DNMLib, BaseFormForm, BusobjCash,
  BusObjSaleBase, DebugLib, tcConst;

{$R *.dfm}
{ TSalesTotalAmountMisMatchGUI }
  function TSalesTotalAmountMisMatchGUI.Diffvalue:String;
  begin
      if IsNumeric(EdtDiff.text) then result := EdtDiff.Text else result := '1';
  end;

procedure TSalesTotalAmountMisMatchGUI.RefreshQuery;
var
  strSQL:String;
begin

  closeDB(Qrymain);
  closeDb(qrysub);
  strSQL:=  'drop table if exists ' + Tablename1 +' ;' +
            ' create table ' + Tablename1 +'' +
            ' Select S.SaleId, S.TotalAmount, S.totalamountinc ,' +
            ' sum(Sl.TotalLineAmount) lineTotalAmount, sum(Sl.TotalLineAmountInc) lineTotalAmountinc' +
            ' from tblsales S inner join tblsaleslines SL on S.SaleId = Sl.SaleID' +
            ' Group by S.SaleID;' +
            ' drop table if exists ' + Tablename2 +' ;' +
            ' create table ' + Tablename2 +'' +
            ' select *, abs(ifnull(TotalAmount,0) -ifnull(LineTotalAmount,0)) DiffEx ,abs(ifnull(TotalAmountinc,0)-ifnull(LineTotalAmountinc,0)) DiffInc  from ' + Tablename1 +'' +
            ' where abs(ifnull(TotalAmount,0) -ifnull(LineTotalAmount,0))>=' + Diffvalue+' or' +
            ' abs(ifnull(TotalAmountinc,0)-ifnull(LineTotalAmountinc,0))>=' + Diffvalue+' ;' ;
  showProgressbar('Please wait' , 4);
  try
    try
      ExecuteSQL(strSQL, nil , Progressshow, OnScriptError);
  Except
      on E:Exception do begin
          CommonLib.MessageDlgXP_Vista('Error Saving Records To Backup Table. This Form Will Be Opened in Read Only Mode. Please contact ERP Support' ,mtWarning, [mbOk] , 0);
          REadonlymode;
      end;
  end;
    Finally
      HideProgressbar;
    end;
  inherited;
  OpenDB(Qrysub);
  if Qrymain.recordcount > 0 then
    if not refreshed then begin
      backupsalesline;
      refreshed := true;
    end;

end;

procedure TSalesTotalAmountMisMatchGUI.FormCreate(Sender: TObject);
begin
  inherited;
   IgnoreQuerySpeed := TRue;
  refreshed:= False;
  Tablename1:= GetUserTemporaryTableName('SalesTotalAmountMisMatch1');
  Tablename2:= GetUserTemporaryTableName('SalesTotalAmountMisMatch2');
  Erpfix_salesmismatch := 'erpfix_TAM_DeletedDuplicateSalesLines';
  erpfix_sl := 'erpfix_TAM_sl7500';
  erpfix_s := 'erpfix_TAM_s7500S';

  closeDB(Qrymain);
  Qrymain.SQL.clear;
  Qrymain.SQL.add('Select T.*,  s.SAleDate , s.msTimestamp, s.Payment, S.Balance, s.Paid, ' + SaleType+' as Saletype ' +
              ' from ' +Tablename2+ ' T ' +
              ' inner join tblsales s on S.SaleId = T.SaleId  ' +
              ' order by SAleId');
  RefreshOrignalSQL;
  RefreshQrySub;
end;

Function  TSalesTotalAmountMisMatchGUI.DeletesaleLine(SilentMode:Boolean;ActionOption:Word):Boolean;
var
  SalesObj :TSalesBase;
  strSQL:String;
  MsgOption :  Word;

begin
  //inherited;
    Result := False;
    if Sysutils.SameText(qryMainSaletype.asString , 'Invoice') then begin
      SalesObj :=TInvoice.create(Self);
    end else if Sysutils.SameText(qryMainSaletype.asString , 'Cash Sale') then begin
      SalesObj :=TCashSale.create(Self);
    end else if Sysutils.SameText(qryMainSaletype.asString , 'Refund') then begin
      SalesObj :=TRefundSale.create(Self);
    end else if Sysutils.SameText(qryMainSaletype.asString , 'Sales Order') then begin
      SalesObj :=TSalesOrder.create(Self);
    end else if Sysutils.SameText(qryMainSaletype.asString , 'Quote') then begin
      SalesObj :=TQuote.create(Self);
    end else Exit;
    try
      SalesObj.SilentMode:= true;
      SalesObj.Connection := TMyDacDataConnection.create(SalesObj);
      SalesObj.Connection.Connection := GetNewMyDacConnection(SalesObj);
      SalesObj.Load(QrymainsaleID.asInteger);
      if SalesObj.count = 0 then exit;
      if not(SalesObj.Lock) then exit;
      if SalesObj is TSales then TSales(SalesObj).InstantiateAllTrees; // load the trees to copy

      (*invoice refund*)
      if Salesobj is TRefundSale then
        if TRefundSale(SalesObj).PayMethod = '' then
          TRefundSale(SalesObj).InvoiceRefund:= true;

      if  SilentMode then begin
        MsgOption := ActionOption;
        if not (SalesObj.Lines.locate('SaleLineId' , qrysubSaleLineID.asInteger , [])) then MsgOption := 101;
      end else begin
        if not (SalesObj.Lines.locate('SaleLineId' , qrysubSaleLineID.asInteger , [])) then MsgOption := 101
        else
        MsgOption :=  CommonLib.MessageDlgXP_Vista('If You Delete This Line From The Sale, The Details Will Be As Follows.' + chr(13) +
                      '                             Header                 Lines' +chr(13) +
                      'Amount(ex)       : ' +FloatToStrF(qryMainTotalAmount.asfloat, ffCurrency, 15, CurrencyRoundPlaces) +'          ' +FloatToStrF(qryMainlineTotalAmount.asfloat - qrysubTotalLineAmount.asFloat, ffCurrency, 15, CurrencyRoundPlaces)+ chr(13) +
                      'Amount(Inc)      : ' +FloatToStrF(qryMainTotalAmountInc.asfloat, ffCurrency, 15, CurrencyRoundPlaces) +'          ' +FloatToStrF(qryMainlineTotalAmountInc.asfloat- qrysubTotalLineAmountInc.asFloat, ffCurrency, 15, CurrencyRoundPlaces) + chr(13) +
                      'Total Payment    : ' + FloatToStrF(qryMainPayment.asfloat, ffCurrency, 15, CurrencyRoundPlaces)+chr(13) +
                      'Balance: ' + FloatToStrF(qryMainBalance.asfloat, ffCurrency, 15, CurrencyRoundPlaces)+chr(13) +chr(13) +
                      'It Is Not Possible To Restore Once Deleted.' , mtconfirmation , [], 0 , nil , '' , '' , False , nil, 'Delete Line, Recalculate Total,Cancel');
                      (*'It Is Not Possible To Restore Once Deleted.' +chr(13) +'Are You Sure You Want To Delete It? ' , mtconfirmation , [mbyes,mbno], 0) = mrno then exit;*)
      end;

      SalesObj.Connection.BeginTransaction;
      try
        if MsgOption = 100 then begin
          strSQL:= 'insert into ' + Erpfix_salesmismatch+' Select * from tblsaleslines where saleLineId = ' + IntToStr(SalesObj.Lines.ID);
          try
            SalesObj.GetNewDataSet(strSQL,true);
          Except
            on E:Exception do begin
                CommonLib.MessageDlgXP_Vista('Error:' +E.Message ,mtWarning, [mbOk] , 0);
                SalesObj.Connection.RollbackTransaction;
                exit;
            end;
          end;
            StrSQL:= 'update tblSaleslines Set ' +
                  ' Shipped=0 , ' +
                  ' UnitofMeasureShipped=0 , ' +
                  ' UnitofMeasureQtySold = UnitofMeasureQtySold - ' + FloattoStr(SalesObj.Lines.UOMQtyShipped) +', ' +
                  ' QtySold = QtySold - '+FloatToStr(SalesObj.Lines.QtyShipped) +', ' +
                  ' Discounts=0, ' +
                  ' Markup=0, ' +
                  ' MarkupPercent=0, ' +
                  ' DiscountPercent=0, ' +
                  ' TotalLineAmount=0, ' +
                  ' TotalLineAmountInc=0, ' +
                  ' LineTax = 0 , ' +
                  ' RefundQty=0 ,Invoiced="F" ' +
                  ' Where SaleLineId = ' +IntToStr(SalesObj.Lines.ID);
           SalesObj.GetNewDataSet(strSQL,true);
           SalesObj.Connection.CommitTransaction;
           Result := true;
          (*SalesObj.Lines.Deleted := true;
          SalesObj.Lines.PostDB;*)

        end else if MsgOption = 101 then begin
          SalesObj.CalcOrderTotals;
          SalesObj.PostDB;
          SalesObj.Connection.CommitTransaction;
          (*if not SalesObj.Save then begin
             SalesObj.Connection.RollbackTransaction;
          end else begin
            SalesObj.Connection.CommitTransaction;
            Result := true;
          end;*)
        end else begin
          salesObj.Connection.RollbackTransaction;
          exit;
        end;
      Except
        SalesObj.Connection.RollbackTransaction;
      end;
    finally
        FreeandNil(SalesObj);
    end;
end;     

procedure TSalesTotalAmountMisMatchGUI.btndeleteClick(
  Sender: TObject);
begin
  inherited;
  if sender = btnRecalculate then begin
    if CommonLib.MessageDlgXP_Vista('This Will Recalculate Sales Total of All Listed Sales Records.' +chr(13) + Chr(13)+ 'Its Not Possible To Cancel Once Recalculated.' +chr(13) + Chr(13)+ 'Are You Sure You Want To Continue? ' , mtconfirmation , [mbyes,mbno] , 0) = mrNo then exit;
  end else if CommonLib.MessageDlgXP_Vista('This Will Delete The Last Line From Each Sales Record If The Line Amount Is Equal To The Difference Between Sales Amount And Lines Total Amount.' +chr(13) + Chr(13)+ 'Its Not Possible To Restore Those Records Once Deleted.' +chr(13) + Chr(13)+ 'Are You Sure You Want To continue? ' , mtconfirmation , [mbyes,mbno] , 0) = mrNo then exit;
  
  if Qrymain.Recordcount= 0 then exit;
  Qrymain.first;
  showProgressbar('Deleting Extra Salesline' , qrymain.RecordCount);
  try
    while Qrymain.Eof = False do begin
       QrySub.Last;
       if sender = btndelete then begin
         if (round(qrysubTotalLineAmountInc.asFloat,CurrencyRoundPlaces) = round(qryMainDiffInc.asFloat,CurrencyRoundPlaces)) and
            (round(qrysubTotalLineAmount.asFloat,CurrencyRoundPlaces) = round(qryMainDiffEx.asFloat,CurrencyRoundPlaces)) then begin
            DeletesaleLine(true, 100);
          end else if  (Sysutils.SameText(qryMainSaletype.asString , 'Refund')) and
                (0-round(qrysubTotalLineAmountInc.asFloat,CurrencyRoundPlaces) = round(qryMainDiffInc.asFloat,CurrencyRoundPlaces)) and
                (0-round(qrysubTotalLineAmount.asFloat,CurrencyRoundPlaces) = round(qryMainDiffEx.asFloat,CurrencyRoundPlaces)) then begin
            DeletesaleLine(true, 100);
          end;
       end else if sender = btnRecalculate then DeletesaleLine(true, 101) ; 
       stepProgressbar;
       Qrymain.Next;
    end;
  finally
      HideProgressbar;
      RefreshQuery;
  end;
end;

procedure TSalesTotalAmountMisMatchGUI.btnMiscProductClick(Sender: TObject);
var
  SalesObj :TSalesBase;
  oldtotalamountinc, newtotalamountinc:Double;
  oldAmount, newamount :Double;
  oldTax, newTax:double;
  msgoption:word;

begin
  inherited;

  msgoption := 100;
  if tableexists('erpfix_sales20120615') or TableExists('erpfix_saleslines20120615') then
    msgoption := MessageDlgXP_Vista('The tables are backed up already.', mtConfirmation, [], 0 , nil , '' , '' , False , nil, 'Delete n Backup,Keep Bakcup, Cancel');
  if msgoption = 102 then exit;
  if msgoption = 100 then
    ExecuteSQL('Drop table if exists erpfix_sales20120615;' +
                ' Drop table if exists  erpfix_saleslines20120615;'+
                ' create table erpfix_sales20120615 like tblsales;'+
                ' insert into erpfix_sales20120615 select * from tblsales;'+
                ' create table erpfix_saleslines20120615 like tblsaleslines;'+
                ' insert into erpfix_saleslines20120615 select * from tblsaleslines;');
  if Qrymain.RecordCount =0 then exit;
  showProgressbar(WaitMSg);
  try
    while Qrymain.Eof = False do begin
      if Sysutils.SameText(qryMainSaletype.asString , 'Invoice') then begin
        SalesObj :=TInvoice.create(Self);
      end else if Sysutils.SameText(qryMainSaletype.asString , 'Cash Sale') then begin
        SalesObj :=TCashSale.create(Self);
      end else if Sysutils.SameText(qryMainSaletype.asString , 'Refund') then begin
        SalesObj :=TRefundSale.create(Self);
      end else if Sysutils.SameText(qryMainSaletype.asString , 'Sales Order') then begin
        SalesObj :=TSalesOrder.create(Self);
      end else if Sysutils.SameText(qryMainSaletype.asString , 'Quote') then begin
        SalesObj :=TQuote.create(Self);
      end else Exit;
      TRy
        SalesObj.SilentMode:= true;
        SalesObj.Connection := TMyDacDataConnection.create(SalesObj);
        SalesObj.Connection.Connection := GetNewMyDacConnection(SalesObj);
        SalesObj.Load(QrymainsaleID.asInteger);
        if SalesObj.count = 0 then exit;
        if not(SalesObj.Lock) then exit;
        //if SalesObj is TSales then TSales(SalesObj).InstantiateAllTrees; // load the trees to copy
        stepProgressbar(SalesObj.Classname +' # ' + QrymainsaleId.AsString + '      : ' +inttostr(Qrymain.recno)+' of ' + inttostr(Qrymain.recordcount));
        oldtotalamountinc :=SalesObj.TotalAmountInc;
        OldAmount := SalesObj.TotalAmount;
        oldTax := salesObj.TotalTax;
        SalesObj.Connection.BeginTransaction;
        SalesObj.CalcOrderTotals;
        if SalesObj.TotalAmountInc <>oldtotalamountinc then begin
          if SalesObj.TotalAmountInc = SalesObj.TotalPaid then begin
            SalesObj.PostDB;
            SalesObj.Save;
          end else begin
            Newtotalamountinc :=SalesObj.TotalAmountInc;
            NewAmount := SalesObj.TotalAmount;
            NewTax := salesObj.TotalTax;
            SalesObj.Lines.Last;
            SalesObj.Lines.New;
            SalesObj.Lines.Productname := 'Misc';
            SalesObj.Lines.Product_Description_Memo := 'Payment fix';
            SalesObj.Lines.UOMQtySold := 1;
            SalesObj.Lines.UOMQtyShipped := 1;
            (*SalesObj.Lines.TotalLineAmount    := qryMainDiffEx.asFloat;
            SalesObj.Lines.TotalLineAmountInc := qryMainDiffInc.AsFloat;
            SalesObj.Lines.LineTaxTotal :=qryMainDiffInc.AsFloat-qryMainDiffEx.asFloat;*)
            saleSObj.lines.TotalLineAmount := OldAmount - NewAmount;
            SalesObj.Lines.TotalLineAmountInc := oldtotalamountinc- Newtotalamountinc;
            SalesObj.Lines.LineTaxTotal := oldTax - NewTax;
            SalesObj.Lines.PostDB;
            SalesObj.Lines.CalcLineTotals;
            SalesObj.Lines.PostDB;
            SalesObj.CalcOrderTotals;
            SalesObj.PostDB;
            SalesObj.Save;
          end;
        end;
        SalesObj.Connection.CommitTransaction;
      Finally
        Freeandnil(SalesObj);
      End;
      Qrymain.Next;
    end;
  finally
    HideProgressbar;
  end;
end;

procedure TSalesTotalAmountMisMatchGUI.backupSalesline;
var
  strSQL:String;
begin
  strSQL:= DuplicateTable('tblsaleslines' ,  erpfix_sl , true);
  strSQL:= strSQL+chr(13);
  strSQL:= strSQL +DuplicateTable('tblsaleslines' ,  Erpfix_salesmismatch , false);
  strSQL:= strSQL+chr(13);
  strSQL:= strSQL +DuplicateTable('tblsales',  erpfix_s , true);
  showProgressbar('Please wait' , 5);
  try
    try
      ExecuteSQL(strSQL, nil , Progressshow, OnScriptError);
  Except
      on E:Exception do begin
          CommonLib.MessageDlgXP_Vista('Error Saving Records To Backup Table. This Form Will Be Opened in Read Only Mode. Please contact ERP Support' ,mtWarning, [mbOk] , 0);
          REadonlymode;
      end;
  end;
    Finally
      HideProgressbar;
    end;
end;

procedure TSalesTotalAmountMisMatchGUI.Progressshow(Sender: TObject;var SQL: String; var Omit: Boolean);
begin
  inherited;
  stepProgressbar;
end;

procedure TSalesTotalAmountMisMatchGUI.FormShow(Sender: TObject);
begin
  inherited;
  grdsub.Footercolor := grdmain.footercolor;
  grdsub.Titlecolor := grdmain.titlecolor;
end;

procedure TSalesTotalAmountMisMatchGUI.grdsubDblClick(Sender: TObject);
var
  SaleID:Integer;
begin
    if DeletesaleLine(False,0) then begin
        SaleID := qryMainSaleId.asInteger;
        RefreshQuery;
        Qrymain.Locate('SaleId' , SaleID , []);
    end;

end;

procedure TSalesTotalAmountMisMatchGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMainSaletype.asString;
  inherited;

end;


procedure TSalesTotalAmountMisMatchGUI.FormDestroy(Sender: TObject);
begin
  DeleteTable(tablename1);
  DeleteTable(tablename2);
  inherited;

end;

procedure TSalesTotalAmountMisMatchGUI.grdsubCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if (round(qrysubTotalLineAmount.asfloat,0) = round(qryMainDiffEx.asfloat,0)) or
      (round(qrysubTotalLineAmountInc.asfloat,0) = round(qryMainDiffInc.asfloat,0)) then
        AFont.Color := clred;
end;

procedure TSalesTotalAmountMisMatchGUI.Readonlymode;
begin
  grdmain.enabled:= False;
  grdsub.Enabled:= False;
  btnRecalculate.Enabled:= False;
  btndelete.Enabled:= False;
  accessLevel := 5;
end;

procedure TSalesTotalAmountMisMatchGUI.OnScriptError(Sender: TObject;
  E: Exception; SQL: String; var Action: TErrorAction);
begin
  Readonlymode;
end;

procedure TSalesTotalAmountMisMatchGUI.RefreshQrySub;
begin
  closeDb(qrysub);
  qrysub.SQL.clear;
  qrysub.SQL.Add('Select SL.SaleID, ' +
              ' SL.ProductID, ' +
              ' SL.SaleLineID, ' +
              ' SL.PARTTYPE, ' +
              ' SL.ProductName, ' +
              ' SL.LinePrice, ' +
              ' SL.LinePriceInc, ' +
              ' SL.QtySold, ' +
              ' SL.UnitofMeasureQtySold, ' +
              ' SL.Shipped, ' +
              ' SL.UnitofMeasureShipped, ' +
              ' SL.BackOrder, ' +
              ' SL.UnitofMeasureBackorder, ' +
              ' SL.Markup, ' +
              ' SL.MarkupPercent, ' +
              ' SL.DiscountPercent, ' +
              ' SL.Discounts, ' +
              ' SL.TotalLineAmount, ' +
              ' SL.TotalLineAmountInc, ' +
              ' SL.Deleted , SL.msTimestamp' +
              ' from tblsaleslines SL where Sl.SAleId in (Select SaleId from ' +Tablename2+' T where abs(DiffInc) >' +diffValue+' or abs(DiffEx) >' +diffValue+' ) ' +
              ' Order by SL.saleId, Seqno ' );


end;

initialization
  RegisterClassOnce(TSalesTotalAmountMisMatchGUI);

end.
