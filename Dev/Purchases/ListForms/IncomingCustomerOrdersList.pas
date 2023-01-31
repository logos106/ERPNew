unit IncomingCustomerOrdersList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TIncomingCustomerOrdersListGUI = class(TBaseListingGUI)
    qryMainCustomerName: TWideStringField;
    qryMainSaleType: TWideStringField;
    qryMainCustomerPrintName: TWideStringField;
    qryMainDocNumber: TWideStringField;
    qryMainSaleID: TIntegerField;
    qryMainSaleDate: TDateField;
    qryMainPurchaseOrderNumber: TWideStringField;
    qryMainOrderDate: TDateTimeField;
    qryMainSupplierName: TWideStringField;
    qryMainSupplierPrintName: TWideStringField;
    qryMainProductID: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainProductPrintName: TWideStringField;
    qryMainProductDescription: TWideStringField;
    qryMainUOMQtyOrdered: TFloatField;
    qryMainUOMQtyReceived: TFloatField;
    qryMainUOMQtyBackorder: TFloatField;
    qryMainReceivedDate: TDateField;
    qryMainSaleLinePriceInc: TFloatField;
    qryMainSaleLinePriceEx: TFloatField;
    qryMainSupplierProductCode: TWideStringField;
    qryMainProductGeneralNotes: TWideMemoField;
    qryMainSmartOrderLineNotes: TWideMemoField;
    qryMainSaleRep: TWideStringField;
    qryMainPurchaseRep: TWideStringField;
    qryMainSaleMemoLine: TWideMemoField;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainSmartOrderID: TIntegerField;
    qryMainCustomerPhone: TWideStringField;
    qryMainCustomerMobile: TWideStringField;
    qryMaincustomerEmail: TWideStringField;
    qryMainSaleaUnitofMeasureQtySold: TFloatField;
    qryMainSalesUnitofMeasureShipped: TFloatField;
    qryMainSalesUnitofMeasureBackorder: TFloatField;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure grpFiltersClick(Sender: TObject);Override;
  private
  Protected
    procedure SetGridColumns; Override;
  public
    procedure RefreshQuery; override;
  end;

implementation

{$R *.dfm}

uses
  CommonFormLib;

{ TIncomingCustomerOrdersListGUI }

procedure TIncomingCustomerOrdersListGUI.grdMainDblClick(Sender: TObject);
begin
  if grdMain.GetActiveField = nil then
    exit;
  if ((grdMain.GetActiveField = qryMainProductGeneralNotes) or
//      (grdMain.GetActiveField = qryMainSmartOrderLineNotes) or
      (grdMain.GetActiveField = qryMainSaleMemoLine)) then begin
   { do nothing .. grid will show memo edit }
  end
  else if (grdMain.GetActiveField = qryMainSmartOrderLineNotes) then begin
   { open smart order .. }
   OpenERPForm('TSmartOrderGUI',qryMainSmartOrderID.AsInteger);
  end
  else if (grdMain.GetActiveField = qryMainCustomerName) or
    (grdMain.GetActiveField = qryMainSaleType) or
    (grdMain.GetActiveField = qryMainCustomerPrintName) or
    (grdMain.GetActiveField = qryMainDocNumber) or
    (grdMain.GetActiveField = qryMainSaleID) or
    (grdMain.GetActiveField = qryMainSaleDate) or
    (grdMain.GetActiveField = qryMainOrderDate) or
    (grdMain.GetActiveField = qryMainSaleLinePriceInc) or
    (grdMain.GetActiveField = qryMainSaleLinePriceEx) or
    (grdMain.GetActiveField = qryMainSaleRep) or
    (grdMain.GetActiveField = qryMainSaleMemoLine) then begin
   { open sale .. }
   if SameText(qryMainSaleType.AsString,'Invoice') then
      OpenERPForm('TInvoiceGUI',qryMainSaleID.AsInteger)
   else if SameText(qryMainSaleType.AsString,'Sales Order') then
      OpenERPForm('TSalesOrderGUI',qryMainSaleID.AsInteger)
   else
     inherited;
 end
 else begin
   { open purchase order .. }
   OpenERPForm('TPurchaseGUI',qryMainPurchaseOrderID.AsInteger);
 end;

end;

procedure TIncomingCustomerOrdersListGUI.grpFiltersClick(Sender: TObject);
begin
  //inherited;
  RefreshQuery;

end;

procedure TIncomingCustomerOrdersListGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  Qrymain.parambyname('filterindex').asInteger :=grpFilters.itemindex;
  inherited;
end;

procedure TIncomingCustomerOrdersListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainproductId.fieldname);
end;

(*initialization
  RegisterClass(TIncomingCustomerOrdersListGUI);*)

end.
