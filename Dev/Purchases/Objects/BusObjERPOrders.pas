unit BusObjERPOrders;

interface

uses
  Classes, BusObjOrders;

type

  ERPPurchaseOrder = class(TPurchaseOrder)
  protected
    function GetPOLines: TPurchaseOrderLine; override;
    function GetObjectUserName: string; override;
  public
    Constructor Create(AOwner: TComponent); Override;
  end;

  ERPPurchaseOrderLine = class(TPurchaseOrderLine)
  protected
  public
    Constructor Create(AOwner: TComponent); Override;
  end;



implementation

uses
  SysUtils;




{ ERPPurchaseOrder }

constructor ERPPurchaseOrder.Create(AOwner: TComponent);
begin
  inherited;
  ExportExcludeList.Add('AmountDue');
  ExportExcludeList.Add('ApplyFlag');
  ExportExcludeList.Add('Approved');
  ExportExcludeList.Add('Area');
  ExportExcludeList.Add('CleanOrderDate');
  ExportExcludeList.Add('EquipmentId');
  ExportExcludeList.Add('Equipmentname');
  ExportExcludeList.Add('ExportExcludeList');
  ExportExcludeList.Add('ForeignBalanceAmount');
  ExportExcludeList.Add('ForeignPaidAmount');
  ExportExcludeList.Add('Invoiced');
  ExportExcludeList.Add('IsPaid');
  ExportExcludeList.Add('OrderCountry');
  ExportExcludeList.Add('OrderPostcode');
  ExportExcludeList.Add('OrderState');
  ExportExcludeList.Add('OrderStreet1');
  ExportExcludeList.Add('OrderStreet2');
  ExportExcludeList.Add('OrderStreet3');
  ExportExcludeList.Add('OrderSuburb');
  ExportExcludeList.Add('OrgPurchaseOrderNumber');
  ExportExcludeList.Add('OriginalDocNumber');
  ExportExcludeList.Add('PrintFlag');
  ExportExcludeList.Add('SaleLineRef');
  ExportExcludeList.Add('SalesComments');
  ExportExcludeList.Add('SalesGlobalref');
  ExportExcludeList.Add('ShipCountry');
  ExportExcludeList.Add('ShipPostcode');
  ExportExcludeList.Add('ShipState');
  ExportExcludeList.Add('ShipStreet1');
  ExportExcludeList.Add('ShipStreet2');
  ExportExcludeList.Add('ShipStreet3');
  ExportExcludeList.Add('ShipSuburb');
  ExportExcludeList.Add('ShipToCustomer');
  ExportExcludeList.Add('ShipToId');
  ExportExcludeList.Add('TotalBalance');
end;

function ERPPurchaseOrder.GetObjectUserName: string;
begin
  result := ClassName;
end;

function ERPPurchaseOrder.GetPOLines: TPurchaseOrderLine;
begin
  result := TPurchaseOrderLine(Getcontainercomponent(ERPPurchaseOrderLine ,'PurchaseOrderId = ' + IntToStr(Self.ID)));
end;

{ ERPPurchaseOrderLine }

constructor ERPPurchaseOrderLine.Create(AOwner: TComponent);
begin
  inherited;
  ExportExcludeList.Add('Active');
  ExportExcludeList.Add('AreaCode');
  ExportExcludeList.Add('Attrib1Purchase');
  ExportExcludeList.Add('Attrib1PurchaseEst');
  ExportExcludeList.Add('Attrib1PurchaseRate');
  ExportExcludeList.Add('Attrib2Purchase');
  ExportExcludeList.Add('Attrib2PurchaseEst');
  ExportExcludeList.Add('BaseLineGlobalRef');
  ExportExcludeList.Add('CustomerEquipmentID');
  ExportExcludeList.Add('Deleted');
  ExportExcludeList.Add('EquipmentName');
  ExportExcludeList.Add('ExportExcludeList');
  ExportExcludeList.Add('FormulaQtyShippedValue1');
  ExportExcludeList.Add('FormulaQtyShippedValue2');
  ExportExcludeList.Add('FormulaQtyShippedValue3');
  ExportExcludeList.Add('FormulaQtyShippedValue4');
  ExportExcludeList.Add('FormulaQtyShippedValue5');
  ExportExcludeList.Add('FormulaQtySoldValue');
  ExportExcludeList.Add('FormulaQtySoldValue1');
  ExportExcludeList.Add('FormulaQtySoldValue2');
  ExportExcludeList.Add('FormulaQtySoldValue3');
  ExportExcludeList.Add('FormulaQtySoldValue4');
  ExportExcludeList.Add('FormulaQtySoldValue5');
  ExportExcludeList.Add('Invoiced');
  ExportExcludeList.Add('LastLineID');
  ExportExcludeList.Add('MatrixDesc');
  ExportExcludeList.Add('MatrixPrice');
  ExportExcludeList.Add('MatrixRef');
  ExportExcludeList.Add('NewForeignExchangeRate');
  ExportExcludeList.Add('PartSpecID');
  ExportExcludeList.Add('PQA');
  ExportExcludeList.Add('PrintedValue');
  ExportExcludeList.Add('ProcTreeId');
  ExportExcludeList.Add('QtyCalcFormulaDetails');
  ExportExcludeList.Add('RepairDocNo');
  ExportExcludeList.Add('RepairId');
  ExportExcludeList.Add('SaleID_Timecost');
  ExportExcludeList.Add('SaleLineID');
  ExportExcludeList.Add('SmartOrderID');
  ExportExcludeList.Add('SmartOrderLineID');
  ExportExcludeList.Add('SpecDescription');
  ExportExcludeList.Add('SpecValue');
  ExportExcludeList.Add('TimecostMarkupPer');
  ExportExcludeList.Add('TimecostPrice');
end;

initialization
  RegisterClass(ERPPurchaseOrder);
  RegisterClass(ERPPurchaseOrderLine);

end.
