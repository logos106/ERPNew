unit BusObjERPSales;

interface

uses
  BusObjSales, Classes, BusObjBase;

type
  ERPInvoice = class(TInvoice)
  private
    fWarrantyPeriod: double;
    fWarrantyPeriodSet: boolean;
    fBeforePostHandlerAssigned: boolean;
    function GetWarrantyPeriod: Double;
    procedure SetWarrantyPeriod(const Value: Double);
    procedure DoPostListBeforeExecute(Sender: TObject;  const Event, Value : string);
  protected
    function GetInvoiceLines: TInvoiceLine; override;
    function GetObjectUserName: string; override;
    procedure OnBeforeDataIdChange; override;
    Function  DoAfterOpen(Sender: TDatasetBusObj): Boolean; override;
  public
    Constructor Create(AOwner: TComponent); Override;
  published
    property WarrantyPeriod: Double read GetWarrantyPeriod write SetWarrantyPeriod;
  end;

  ERPInvoiceLine = class(TInvoiceLine)
  private
    procedure SetTotalDiscountedLineAmountInc(const Value: double);
  published
  public
    Constructor Create(AOwner: TComponent); Override;
  published
    property TotalDiscountedLineAmountInc: double write SetTotalDiscountedLineAmountInc;
  end;

implementation

uses
  SysUtils, CommonLib;

{ ERPInvoice }

constructor ERPInvoice.Create(AOwner: TComponent);
begin
  inherited;
  fWarrantyPeriod := 0;
  fWarrantyPeriodSet := false;
  fBeforePostHandlerAssigned := false;

  ExportExcludeList.Add('AddToManifest');
  ExportExcludeList.Add('AmountDue');
  ExportExcludeList.Add('ApplyFlag');
  ExportExcludeList.Add('Area');
  ExportExcludeList.Add('ARNotes');
  ExportExcludeList.Add('AutoSmartOrderRef');
  ExportExcludeList.Add('BackOrderGlobalRef');
  ExportExcludeList.Add('BarcodePickingDone');
  ExportExcludeList.Add('BaseNo');
  ExportExcludeList.Add('BlindBalancePeriodID');
  ExportExcludeList.Add('ChequeNumber');
  ExportExcludeList.Add('CleanContributionAmount');
  ExportExcludeList.Add('CleanConverted');
  ExportExcludeList.Add('CleanSaleDate');
  ExportExcludeList.Add('ClientId');
  ExportExcludeList.Add('CommissionPaid');
  ExportExcludeList.Add('ContributionAmount');
  ExportExcludeList.Add('Deposited');
  ExportExcludeList.Add('DisableCalcOrderTotals');
  ExportExcludeList.Add('EarlyPaymentDiscountAmount');
  ExportExcludeList.Add('EditedFlag');
  ExportExcludeList.Add('EOP_POS');
  ExportExcludeList.Add('EnteredAt');
  ExportExcludeList.Add('EnteredBy');
  ExportExcludeList.Add('ExportExcludeList');
  ExportExcludeList.Add('ForeignBalanceAmount');
  ExportExcludeList.Add('ForeignPaidAmount');
  ExportExcludeList.Add('IncompleteAllocationLine');
  ExportExcludeList.Add('InvalidAllocationLine');
  ExportExcludeList.Add('InvoiceCountry');
  ExportExcludeList.Add('InvoicePostcode');
  ExportExcludeList.Add('InvoicePrintDesc');
  ExportExcludeList.Add('InvoiceState');
  ExportExcludeList.Add('InvoiceStreet1');
  ExportExcludeList.Add('InvoiceStreet2');
  ExportExcludeList.Add('InvoiceStreet3');
  ExportExcludeList.Add('InvoiceSuburb');
  ExportExcludeList.Add('IsBarcodePicking');
  ExportExcludeList.Add('IsCashSale');
  ExportExcludeList.Add('IsCustomerreturn');
  ExportExcludeList.Add('ISEmpty');
  ExportExcludeList.Add('IsGeneratedFromHire');
  ExportExcludeList.Add('IsInternalOrder');
  ExportExcludeList.Add('IsInvoice');
  ExportExcludeList.Add('IsLayby');
  ExportExcludeList.Add('IsLaybyPayment');
  ExportExcludeList.Add('IsLaybyTOS');
  ExportExcludeList.Add('IsManifest');
  ExportExcludeList.Add('IsPaid');
  ExportExcludeList.Add('IsPOS');
  ExportExcludeList.Add('IsQuote');
  ExportExcludeList.Add('IsRefund');
  ExportExcludeList.Add('IsSalesOrder');
  ExportExcludeList.Add('IsVoucher');
  ExportExcludeList.Add('OriginalDocNumber');
  ExportExcludeList.Add('PayDueDate');
  ExportExcludeList.Add('PayMethod');
  ExportExcludeList.Add('PickupFromClientName');
  ExportExcludeList.Add('PickupFromDesc');
  ExportExcludeList.Add('PlannedDeliveryFrom');
  ExportExcludeList.Add('PlannedDeliveryTo');
  ExportExcludeList.Add('POCreated');
  ExportExcludeList.Add('POSPostCode');
  ExportExcludeList.Add('PrintedAt');
  ExportExcludeList.Add('PrintedBy');
  ExportExcludeList.Add('PrintedOn');
  ExportExcludeList.Add('PrintFlag');
  ExportExcludeList.Add('PrintHold');
  ExportExcludeList.Add('QuoteGlobalRef');
  ExportExcludeList.Add('RepairEquipment');
  ExportExcludeList.Add('RepairGlobalRef');
  ExportExcludeList.Add('RepairID');
  ExportExcludeList.Add('SalesOrderGlobalRef');
  ExportExcludeList.Add('ShipCountry');
  ExportExcludeList.Add('ShipDate');
  ExportExcludeList.Add('Shipping');
  ExportExcludeList.Add('ShippingCost');
  ExportExcludeList.Add('ShipPostcode');
  ExportExcludeList.Add('ShipState');
  ExportExcludeList.Add('ShipStreet1');
  ExportExcludeList.Add('ShipStreet2');
  ExportExcludeList.Add('ShipStreet3');
  ExportExcludeList.Add('ShipSuburb');
  ExportExcludeList.Add('ShipTocontactID');
  ExportExcludeList.Add('ShipToID');
  ExportExcludeList.Add('SOInvoiced');
  ExportExcludeList.Add('SOInvoiceRef');
  ExportExcludeList.Add('SOProgressPaymentGlobalRef');
  ExportExcludeList.Add('SOProgressPaymentOriginalRef');
  ExportExcludeList.Add('Tag');
  ExportExcludeList.Add('TillID');
  ExportExcludeList.Add('TillName');
  //ExportExcludeList.Add('TimeOfSale');
  ExportExcludeList.Add('totalAmountclean');
  ExportExcludeList.Add('totalAmountincclean');
  ExportExcludeList.Add('TotalAttrib1Sale');
  ExportExcludeList.Add('TotalAttrib1SaleEst');
  ExportExcludeList.Add('TotalAttrib1SaleRate');
  ExportExcludeList.Add('TotalAttrib2Sale');
  ExportExcludeList.Add('TotalAttrib2SaleEst');
  ExportExcludeList.Add('TotalBalance');
  ExportExcludeList.Add('TotalPaid');
  ExportExcludeList.Add('TotalQtyBackOrdered');
  ExportExcludeList.Add('TotalQuoteAmount');
  ExportExcludeList.Add('TotalQuoteAmtInc');
  ExportExcludeList.Add('TotalTaxclean');
  ExportExcludeList.Add('TotalWEGTax');
  ExportExcludeList.Add('TotalWETTax');
  ExportExcludeList.Add('UsedOnManifest');
  ExportExcludeList.Add('UseWholesalePrice');
  ExportExcludeList.Add('Name');
  ExportExcludeList.Add('NoOfBoxes');
//    ExportExcludeList.Add('');

end;

function ERPInvoice.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterOpen(Sender);
  if not fBeforePostHandlerAssigned then begin
    fBeforePostHandlerAssigned := true;
    PostList.Events.AddMultiEvent(DoPostListBeforeExecute);
  end;
end;

procedure ERPInvoice.DoPostListBeforeExecute(Sender: TObject; const Event,
  Value: string);
var
  StrSQL: string;
begin
  if SameText(Event,'BeforeExecute') then begin
    if fWarrantyPeriodSet then begin
      StrSQL := 'Update tblClients Set WarrantyPeriod = ' + FloatToStr(fWarrantyPeriod) + ' where clientId = ' + IntToStr(Customer.ID);
      PostList.AddQuery(StrSQL, Customer.ID, Customer.BusObjectTableName, True);
    end;
  end;
end;

function ERPInvoice.GetInvoiceLines: TInvoiceLine;
begin
  Result := TInvoiceLine(GetContainerComponent(ERPInvoiceLine, 'SaleID = ' + IntToStr(Self.Id)));
end;

function ERPInvoice.GetObjectUserName: string;
begin
  result := ClassName;
end;

function ERPInvoice.GetWarrantyPeriod: Double;
begin
  result := 0;
  if fWarrantyPeriodSet then
    result := fWarrantyPeriod
  else begin
    if ClientId > 0 then begin
      result :=  Customer.WarrantyPeriod;
    end;
  end;
end;

procedure ERPInvoice.OnBeforeDataIdChange;
begin
  inherited;
  fWarrantyPeriodSet := false;
  fWarrantyPeriod := 0;
end;

procedure ERPInvoice.SetWarrantyPeriod(const Value: Double);
begin
  fWarrantyPeriodSet := true;
  fWarrantyPeriod := Value;
end;

{ ERPInvoiceLine }

constructor ERPInvoiceLine.Create(AOwner: TComponent);
begin
  inherited;
    ExportExcludeList.Add('Active');
    ExportExcludeList.Add('AreaCode');
    ExportExcludeList.Add('AreaQty');
    ExportExcludeList.Add('Assembled');
    ExportExcludeList.Add('Attrib1Sale');
    ExportExcludeList.Add('Attrib1SaleEst');
    ExportExcludeList.Add('Attrib1SaleRate');
    ExportExcludeList.Add('Attrib2Sale');
    ExportExcludeList.Add('Attrib2SaleEst');
    ExportExcludeList.Add('AutoSmartOrder');
    ExportExcludeList.Add('BaseLineGlobalRef');
    ExportExcludeList.Add('BaseLineNo');
    ExportExcludeList.Add('BatchAllocated');
    ExportExcludeList.Add('BOMGroupedLine');
    ExportExcludeList.Add('BOMProductionLine');
    ExportExcludeList.Add('CleanProductName');
    ExportExcludeList.Add('CleanQtyShipped');
    ExportExcludeList.Add('CleanSoldSerials');
    ExportExcludeList.Add('CleanUOMQtyShipped');
    ExportExcludeList.Add('convertingQuote');
    ExportExcludeList.Add('ConvertingRepairs');
    ExportExcludeList.Add('convertingSO');
    ExportExcludeList.Add('CustomData');
    ExportExcludeList.Add('CustomerEquipmentID');
    ExportExcludeList.Add('Deleted');
    ExportExcludeList.Add('DetailsCust1Total');
    ExportExcludeList.Add('Equipment');
    ExportExcludeList.Add('ExportExcludeList');
    ExportExcludeList.Add('FESalesLines');
    ExportExcludeList.Add('ForeignHedgingUsed');
    ExportExcludeList.Add('FormulaQtyShippedValue');
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
    ExportExcludeList.Add('ISContainer');
    ExportExcludeList.Add('ISEmpty');
    ExportExcludeList.Add('IsFormulaRElatedProduct');
    ExportExcludeList.Add('IsPallet');
    ExportExcludeList.Add('IsQuote');
    ExportExcludeList.Add('IsRelatedProduct');
    ExportExcludeList.Add('Isvoucher');
    ExportExcludeList.Add('LaybyId');
    ExportExcludeList.Add('linepriceincclean');
    ExportExcludeList.Add('lineTaxclean');
    ExportExcludeList.Add('MatrixDesc');
    ExportExcludeList.Add('MatrixPrice');
    ExportExcludeList.Add('MatrixRef');
    ExportExcludeList.Add('ParentProductID');
    ExportExcludeList.Add('ParentProductName');
    ExportExcludeList.Add('PartSpecID');
    ExportExcludeList.Add('PQA');
    ExportExcludeList.Add('ProgressPaymentRef');
    ExportExcludeList.Add('QtyCalcFormulaDetails');
    ExportExcludeList.Add('RefundedSalesLineID');
    ExportExcludeList.Add('RefundQty');
    ExportExcludeList.Add('RelatedParentLineRef');
    ExportExcludeList.Add('RelatedProductQty');
    ExportExcludeList.Add('RequiresAssembly');
    ExportExcludeList.Add('SalesAutoSplitQty');
    ExportExcludeList.Add('SalesAutoSplitQtyLines');
    ExportExcludeList.Add('SearchFilter');
    ExportExcludeList.Add('SearchFilterCopy');
    ExportExcludeList.Add('SmartOrderCreated');
    ExportExcludeList.Add('SOInvoiceLineRef');
    ExportExcludeList.Add('SoldSerials');
    ExportExcludeList.Add('SpecDescription');
    ExportExcludeList.Add('SpecValue');
    ExportExcludeList.Add('Tag');
    ExportExcludeList.Add('TimeCostUsed');
    ExportExcludeList.Add('Totallineamountclean');
    ExportExcludeList.Add('TotallineAmountincclean');
    ExportExcludeList.Add('VoucherNo');
    ExportExcludeList.Add('WarrantyEndsOn');
    ExportExcludeList.Add('WarrantyPeriod');
//    ExportExcludeList.Add('');


end;

procedure ERPInvoiceLine.SetTotalDiscountedLineAmountInc(const Value: double);
begin
  if TotalLineAmountInc > 0 then
    self.DiscountAmount := Round((TotalLineAmountInc - Value), RoundPlacesGeneral);

end;

initialization

  RegisterClass(ERPInvoice);
  RegisterClass(ERPInvoiceLine);

end.
