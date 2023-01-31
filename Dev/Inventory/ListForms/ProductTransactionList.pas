unit ProductTransactionList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel , PQALib, DBCtrls;

type
  TProductTransactionListGUI = class(TBaseListingGUI)
    qryMainTransID: TLargeintField;
    qryMainTranstype: TWideStringField;
    qryMainQty: TFloatField;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainSaleId: TIntegerField;
    qryMainPODeleted: TWideStringField;
    qryMainSalesDeleted: TWideStringField;
    qryMainPOCancelled: TWideStringField;
    qryMainSalesCancelled: TWideStringField;
    qryMainProductName: TWideStringField;
    DNMPanel1: TDNMPanel;
    Label2: TLabel;
    DBText1: TDBText;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    fQtytype: TQtytype;
    fiProductID: Integer;
    procedure setQtytype(const Value: TQtytype);
  Protected
    Procedure SetGridColumns;override;

  public
    Property Qtytype: TQtytype read fQtytype write setQtytype;
    Property ProductID :Integer read fiProductID write fiProductID;
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib , ProductQtyLib, tcConst;

{$R *.dfm}
{ TProductTransactionListGUI }

procedure TProductTransactionListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if qryMainPurchaseOrderID.asInteger =0 then
    if Sametext(field.fieldname , qryMainPurchaseOrderID.fieldname) or
    Sametext(field.fieldname , qryMainPODeleted.fieldname) or
    Sametext(field.fieldname , qryMainPOCancelled.fieldname) then ABrush.color := GridcolInactive;

  if qryMainSaleId.asInteger =0 then
    if Sametext(field.fieldname , qryMainSaleId.fieldname) or
    Sametext(field.fieldname , qryMainSalesDeleted.fieldname) or
    Sametext(field.fieldname , qryMainSalesCancelled.fieldname) then ABrush.color := GridcolInactive;
end;

procedure TProductTransactionListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMainTranstype.assTring ;
  inherited;
end;

procedure TProductTransactionListGUI.RefreshQuery;
begin
  closeDb(Qrymain);
  Qrymain.SQL.clear;
  Qrymain.SQL.add('Select ');
  Qrymain.SQL.add('PQA.transID as TransID,');
  Qrymain.SQL.add('PQA.ProductName as ProductName,');
  Qrymain.SQL.add('PQAT.Description as Transtype,');
  Qrymain.SQL.add(SQL4Qty(Qtytype)        +' as   Qty,');
  Qrymain.SQL.add('PO.PurchaseOrderID as PurchaseOrderID,');
  Qrymain.SQL.add('s.saleID as SaleId ,');
  Qrymain.SQL.add('PO.Deleted as PODeleted,');
  Qrymain.SQL.add('S.Deleted as SalesDeleted,');
  Qrymain.SQL.add('PO.Cancelled as POCancelled,');
  Qrymain.SQL.add('S.Cancelled as SalesCancelled');
  Qrymain.SQL.add('FROM ' + ProductTables(tSummary));
  Qrymain.SQL.add('inner join tblpqatranstypes PQAT on PQAT.TransType = PQa.Transtype ');
  Qrymain.SQL.add('Left join tblpurchaseorders PO on PQa.transId = PO.PurchaseOrderID and PQA.transtype ="TPurchaseOrderLine"');
  Qrymain.SQL.add('Left join tblsales S on PQa.transId = S.SaleID and PQA.transtype  in ("TInvoiceLine" , "TSalesOrderline")');
  Qrymain.SQL.add('WHERE PC.ProductID= ' + IntToStr(ProductID));
  Qrymain.SQL.add('group by PQA.transID');
  Qrymain.SQL.add('having Qty <> 0');
  RefreshOrignalSQL;

  inherited;
end;

procedure TProductTransactionListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainProductName.fieldname);
  RemoveFieldfromGrid(QrymainTransID.fieldname);
end;

procedure TProductTransactionListGUI.setQtytype(const Value: TQtytype);
begin
  fQtytype := Value;
       if value = tSO     then TitleLabel.caption := 'Sales Orders '
  else if value = tSOBO   then TitleLabel.caption := 'Sales Order - BOs '
  else if value = tInvBO  then TitleLabel.caption := 'Invoice - BOs '
  else if value = tPOBO   then TitleLabel.caption := 'Sales Orders ';
end;

initialization
  RegisterClassOnce(TProductTransactionListGUI);

end.
