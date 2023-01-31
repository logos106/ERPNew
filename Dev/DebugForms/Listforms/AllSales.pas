unit AllSales;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel,BusObjBase, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TAllSalesGUI = class(TBaseListingGUI)
    btnCalc: TDNMSpeedButton;
    qryMainSaleId: TIntegerField;
    qryMaincustomername: TWideStringField;
    qryMaintotalamount: TFloatField;
    qryMaintotalamountinc: TFloatField;
    qryMainTotaltax: TFloatField;
    qryMainIsSalesOrder: TWideStringField;
    qryMainIsinvoice: TWideStringField;
    qryMainIsCashSAle: TWideStringField;
    qryMainIsRefund: TWideStringField;
    qryMainIsPOS: TWideStringField;
    procedure btnCalcClick(Sender: TObject);
    procedure SctMainError(Sender: TObject; E: Exception; SQL: string;
      var Action: TErrorAction);
  private
    procedure CalcLineTotalsCallback(const Sender: TBusObj; var Abort: boolean);
  Protected
    procedure IterateselectedRecordsCallback(var Abort: boolean; SelIndex:Integer); Override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, BusObjSales, BusobjCash, BusObjSaleBase , BusObjPOSSale,
  tcConst, LogLib, Math;

{$R *.dfm}

procedure TAllSalesGUI.btnCalcClick(Sender: TObject);
begin
  inherited;
  With Scriptmain do begin
    SQL.Clear;
    SQL.Add('Alter table tblsaleslines Add column lineTaxclean double;');
    SQL.Add('alter table tblsaleslines Add column linepriceincclean double;');
    SQL.Add('alter table tblsaleslines Add column Totallineamountclean double;');
    SQL.Add('alter table tblsaleslines Add column TotallineAmountincclean double;');
    SQL.Add('alter table tblsales Add column totalAmountclean double;');
    SQL.Add('alter table tblsales Add column totalAmountincclean double;');
    SQL.Add('alter table tblsales Add column TotalTaxclean double;');
    SQL.Add('alter table tblsales Add column Paymentclean double;');
    SQL.Add('alter table tblsales Add column Balanceclean double;');

    SQL.Add('update tblsaleslines Set lineTaxclean            = lineTax             Where ifnull(lineTaxclean,0)=0;');
    SQL.Add('update tblsaleslines Set linepriceincclean       = linepriceinc        Where ifnull(linepriceincclean,0)=0;');
    SQL.Add('update tblsaleslines Set Totallineamountclean    = Totallineamount     Where ifnull(Totallineamountclean,0)=0;');
    SQL.Add('update tblsaleslines Set TotallineAmountincclean = TotallineAmountinc  Where ifnull(TotallineAmountincclean,0)=0;');
    SQL.Add('update tblsales Set totalAmountclean             = totalAmount         Where ifnull(totalAmountclean,0)=0;');
    SQL.Add('update tblsales Set totalAmountincclean          = totalAmountinc      Where ifnull(totalAmountincclean,0)=0;');
    SQL.Add('update tblsales Set TotalTaxclean                = TotalTax            Where ifnull(TotalTaxclean,0)=0;');
    SQL.Add('update tblsales Set Paymentclean                 = Payment             Where ifnull(Paymentclean,0)=0;');
    SQL.Add('update tblsales Set Balanceclean                 = Balance             Where ifnull(Balanceclean,0)=0;');

    DoShowProgressbar(14,WAITMSG);
    try
      Execute;
    finally
      DoHideProgressbar;
    end;
  end;
  IterateProcNo := 1;
  IterateSelectedRecords(true);
end;
procedure TAllSalesGUI.CalcLineTotalsCallback(Const Sender: TBusObj; var Abort: boolean) ;
begin
  if not(Sender is TSalesLineBase) then exit;
  TSalesLineBase(Sender).CalcLineTotals;
  TSalesLineBase(Sender).PostDB;
end;
procedure TAllSalesGUI.IterateselectedRecordsCallback(var Abort: boolean; SelIndex: Integer);
var
  salesobj :TSalesBase;
begin
  inherited;
  SalesObj:= nil;
  try
    try
      if IterateProcNo = 1 then begin
             if Qrymainisinvoice.AsBoolean    then salesobj :=  TInvoice.CreateWithNewConn(Self)
        else if qryMainIsSalesOrder.AsBoolean then salesobj :=  TSalesorder.CreateWithNewConn(Self)
        else if qryMainIsCashSAle.AsBoolean   then salesobj :=  TCashsAle.CreateWithNewConn(Self)
        else if qryMainIsRefund.AsBoolean     then salesobj :=  TRefundSale.CreateWithNewConn(Self)
        else if qryMainIsPOS.AsBoolean        then salesobj :=  TPosCashSale.CreateWithNewConn(Self)
        else exit;
        salesobj.Load(QrymainsaleId.asInteger);
        if salesobj.count=0 then exit;
        salesobj.Connection.BeginTransaction;
        try
          salesobj.Lines.IterateRecords(CalcLineTotalsCallback);
          salesobj.CalcOrderTotals;
          salesobj.PostDB;
          if salesobj.IsPaid and (salesobj.TotalBalance(*AmountDue*) =0) then
            if not SameValue( round(salesobj.TotalPaid  -salesobj.Totalamountinc ,CurrencyRoundPlaces) , 0 , 0.01) then begin
              salesobj.Lines.new;
              salesobj.Lines.ProductName := PART_MISC;
              salesobj.Lines.ProductDescription :='Total Adjustment';
              salesobj.Lines.qtysold:= 1;
              salesobj.Lines.qtyshipped:= 1;
              salesobj.Lines.lineprice := round((salesobj.TotalPaid + salesobj.TotalBalance(*AmountDue*)) -salesobj.Totalamountinc ,CurrencyRoundPlaces);
              salesobj.Lines.linepriceinc := salesobj.Lines.lineprice;
              salesobj.Lines.LineTaxTotal:= 0;
              salesobj.Lines.PostDB;
              salesobj.Lines.CalcLineTotals;
              salesobj.Lines.PostDB;
            end;
          salesobj.Connection.CommitTransaction;
        Except
          on E:Exception do begin
            salesobj.Connection.RollbackTransaction;
          end;
        end;
      end;
    finally
      if assigned(SalesObj) then Freeandnil(SalesObj);
    end;
  Except
    on E:Exception do begin
      logtext(E.Message);
    end;
  end;

end;

procedure TAllSalesGUI.SctMainError(Sender: TObject; E: Exception; SQL: string;
  var Action: TErrorAction);
begin
  inherited;
  action   := eaContinue;
end;

initialization
  RegisterClassOnce(TAllSalesGUI);

end.
