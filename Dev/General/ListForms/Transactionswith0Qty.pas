unit Transactionswith0Qty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, BaseInputForm,
  DAScript, MyScript;

type
  TTransactionswith0QtyGUI = class(TBaseListingGUI)
    qryMaintype: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainTrasnsId: TIntegerField;
    qryMainclientName: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainUnitofMeasureSaleLines: TWideStringField;
    qryMainUnitofMeasureQtySold: TFloatField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainUnitofMeasureBackorder: TFloatField;
    cmddelete: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure cmddeleteClick(Sender: TObject);
  private
    deleteBtnclicked:Boolean;
  Protected
    Procedure AssignKeyId(Popupform :TBaseInputGUI); Override;
    Procedure SetGridColumns;Override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, ProductQtyLib, BusObjSales, BusobjCash, busobjOrders,
  FastFuncs, BaseTransForm;

{$R *.dfm}
procedure TTransactionswith0QtyGUI.FormCreate(Sender: TObject);
begin
  deleteBtnclicked := False;
  closeDB(Qrymain);
  Qrymain.SQL.clear;
  Qrymain.SQL.add('SELECT');
  Qrymain.SQL.add(ProductQtyLib.Saletype('S') +' as type,');
  Qrymain.SQL.add('`S`.`GlobalRef`,');
  Qrymain.SQL.add('`S`.`SaleID` as TrasnsId,');
  Qrymain.SQL.add('`S`.`CustomerName` as clientName,');
  Qrymain.SQL.add('`SL`.`ProductName`,');
  Qrymain.SQL.add('`SL`.`UnitofMeasureSaleLines`,');
  Qrymain.SQL.add('`SL`.`UnitofMeasureQtySold`,');
  Qrymain.SQL.add('`SL`.`UnitofMeasureShipped`,');
  Qrymain.SQL.add('`SL`.`UnitofMeasureBackorder` ');
  Qrymain.SQL.add('FROM');
  Qrymain.SQL.add('`tblsales` AS `S`');
  Qrymain.SQL.add('inner join tblSaleslines SL on S.SaleId = Sl.SaleID and ifnull(Sl.shipped,0) = 0  and ifnull(Sl.Qtysold,0) = 0 and ifnull(BackOrder,0) = 0');
  Qrymain.SQL.add('inner join tblParts P on P.PartsID = ifnull(Sl.ProductId,0) and ifnull(P.PartType , "") ="INV"');
  Qrymain.SQL.add('Where S.SaleId not in ');
  Qrymain.SQL.add('(Select S2.saleId From tblsales S1 ');
  Qrymain.SQL.add('Inner join tblSales S2 on S2.globalref = S1.BOID ');
  Qrymain.SQL.add('Where S2.Originalno = S.Globalref ');
  Qrymain.SQL.add('and S1.globalref = S.BOID ');
  Qrymain.SQL.add('and S1.Originalno = S.Globalref)');
  Qrymain.SQL.add('union');
  Qrymain.SQL.add('SELECT');
  Qrymain.SQL.add(ProductQtyLib.POType('PO') +' as type,');
  Qrymain.SQL.add('`PO`.`GlobalRef`,');
  Qrymain.SQL.add('`PO`.`PurchaseOrderID`,');
  Qrymain.SQL.add('`PO`.`Suppliername`,');
  Qrymain.SQL.add('`PL`.`ProductName`,');
  Qrymain.SQL.add('`PL`.`UnitofMeasurePOLines`,');
  Qrymain.SQL.add('`PL`.`UnitofMeasureQtySold`,');
  Qrymain.SQL.add('`PL`.`UnitofMeasureShipped`,');
  Qrymain.SQL.add('`PL`.`UnitofMeasureBackorder`');
  Qrymain.SQL.add('FROM');
  Qrymain.SQL.add('tblPurchaseOrders AS `PO`');
  Qrymain.SQL.add('inner join tblPurchaseLines PL on PO.PurchaseOrderId = PL.PurchaseOrderId and ifnull(pl.shipped,0) = 0  and ifnull(pl.Qtysold,0) = 0 and ifnull(Pl.BackOrder,0) = 0');
  Qrymain.SQL.add('inner join tblParts P on P.PartsID = ifnull(Pl.ProductId,0) and ifnull(P.PartType , "") ="INV"');
  Qrymain.SQL.add('Where `PO`.`PurchaseOrderID` not in (');
  Qrymain.SQL.add('Select `PO2`.`PurchaseOrderID` ');
  Qrymain.SQL.add('From tblPurchaseOrders PO1 ');
  Qrymain.SQL.add('Inner join tblPurchaseOrders PO2 on PO2.globalref = PO1.BOID ');
  Qrymain.SQL.add('Where PO2.Originalno = PO.Globalref ');
  Qrymain.SQL.add('and PO1.globalref    = PO.BOID ');
  Qrymain.SQL.add('and PO1.Originalno   = PO.Globalref)');
  Qrymain.SQL.add('Order by type, TrasnsId, Productname');
  inherited;
end;

procedure TTransactionswith0QtyGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMain.Fields.FieldByName('Type').AsString;
  inherited;

end;

procedure TTransactionswith0QtyGUI.cmddeleteClick(Sender: TObject);
begin
  inherited;
  (*if qryMainBOID2.asInteger <> 0 then begin
      CommonLib.MessageDlgXP_Vista(qryMaintype.asString +'#' +qryMainTrasnsId.asString +' is Read-Only.' +chr(13) +'It Has Shipped Back-Order - ' + qryMaintype.asString +'#' + qryMainBOID1.asString ,MtInformation, [mbok],0 );
      Exit;
  end;*)
  deleteBtnclicked:= true;
  try
    grdMainDblClick(cmddelete);
  finally
      deleteBtnclicked := False;
  end;
end;

procedure TTransactionswith0QtyGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin
  inherited;
  if Assigned(Popupform) then
    if Popupform is TBaseTransGUI then
      TBaseTransGUI(Popupform).DeleteEmptyLinesAftershow := deleteBtnclicked;
end;

procedure TTransactionswith0QtyGUI.SetGridColumns;
begin
  inherited;
end;

initialization
  RegisterClassOnce(TTransactionswith0QtyGUI);

end.
