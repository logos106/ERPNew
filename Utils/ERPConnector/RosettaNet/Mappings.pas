unit Mappings;

interface

uses
  JsonXmlMappingObj;

procedure AddSOHeadderMappings(aMapper: TJsonXmlMapper);
procedure AddSOLineMappings(aMapper: TJsonXmlMapper);

implementation

procedure AddSOHeadderMappings(aMapper: TJsonXmlMapper);
begin
  { customer }
//  aMapper.AddMapping('fields.ClientName','fromRole.PartnerRoleDescription.PartnerDescription.BusinessDescription.businessName.FreeFormText');

  { billTo }
  aMapper.AddMapping('fields.InvoiceToDesc','PurchaseOrder.AccountDescription.billTo.PartnerRoleDescription.ContactInformation.contactName.FreeFormText');
  aMapper.AddMapping('fields.InvoiceToDesc','PurchaseOrder.AccountDescription.billTo.PartnerRoleDescription.ContactInformation.PhysicalAddress');
//  aMapper.AddMapping('fields.InvoiceToDesc','PurchaseOrder.AccountDescription.billTo.PartnerRoleDescription.ContactInformation.PhysicalAddress.addressLine1.FreeFormText');
//  aMapper.AddMapping('fields.InvoiceToDesc','PurchaseOrder.AccountDescription.billTo.PartnerRoleDescription.ContactInformation.PhysicalAddress.addressLine2.FreeFormText');
//  aMapper.AddMapping('fields.InvoiceToDesc','PurchaseOrder.AccountDescription.billTo.PartnerRoleDescription.ContactInformation.PhysicalAddress.addressLine3.FreeFormText');
//  aMapper.AddMapping('fields.InvoiceToDesc','PurchaseOrder.AccountDescription.billTo.PartnerRoleDescription.ContactInformation.PhysicalAddress.cityName.FreeFormText');
//  aMapper.AddMapping('fields.InvoiceToDesc','PurchaseOrder.AccountDescription.billTo.PartnerRoleDescription.ContactInformation.PhysicalAddress.regionName.FreeFormText');
//  aMapper.AddMapping('fields.InvoiceToDesc','PurchaseOrder.AccountDescription.billTo.PartnerRoleDescription.ContactInformation.PhysicalAddress.NationalPostalCode');

  { shipTo }
  aMapper.AddMapping('fields.ShipToDesc','PurchaseOrder.shipTo.PartnerDescription.ContactInformation.contactName.FreeFormText');
  aMapper.AddMapping('fields.ShipToDesc','PurchaseOrder.shipTo.PartnerDescription.PhysicalAddress');
//  aMapper.AddMapping('fields.ShipToDesc','PurchaseOrder.shipTo.PartnerDescription.PhysicalAddress.addressLine1.FreeFormText');
//  aMapper.AddMapping('fields.ShipToDesc','PurchaseOrder.shipTo.PartnerDescription.PhysicalAddress.addressLine2.FreeFormText');
//  aMapper.AddMapping('fields.ShipToDesc','PurchaseOrder.shipTo.PartnerDescription.PhysicalAddress.addressLine3.FreeFormText');
//  aMapper.AddMapping('fields.ShipToDesc','PurchaseOrder.shipTo.PartnerDescription.PhysicalAddress.cityName.FreeFormText');
//  aMapper.AddMapping('fields.ShipToDesc','PurchaseOrder.shipTo.PartnerDescription.PhysicalAddress.regionName.FreeFormText');
//  aMapper.AddMapping('fields.ShipToDesc','PurchaseOrder.shipTo.PartnerDescription.PhysicalAddress.NationalPostalCode');

  aMapper.AddMapping('fields.CustPONumber','thisDocumentIdentifier.ProprietaryDocumentIdentifier');

end;

procedure AddSOLineMappings(aMapper: TJsonXmlMapper);
begin
//  aMapper.AddMapping('fields.ProductName','ProductIdentification.PartnerProductIdentification.ProprietaryProductIdentifier');
  aMapper.AddMapping('fields.UnitOfMeasure','GlobalProductUnitOfMeasureCode');
//  aMapper.AddMapping('fields.LinePriceInc','requestedUnitPrice.FinancialAmount.MonetaryAmount');
  aMapper.AddMapping('fields.UOMQtySold','OrderQuantity.requestedQuantity.ProductQuantity');
  aMapper.AddMapping('fields.UOMQtyShipped','OrderQuantity.requestedQuantity.ProductQuantity');

  { NOTE: Set amount last as qty changes will revert to product card prices }
  aMapper.AddMapping('fields.LinePrice','requestedUnitPrice.FinancialAmount.MonetaryAmount');

  aMapper.AddMapping('fields.ShipDate','requestedEvent.TransportationEvent.DateStamp');
  { add optional notes }
  aMapper.AddMapping('fields.Product_Description_Memo','ProductSubLineItem.comments.FreeFormText',true);
  aMapper.AddMapping('fields.Product_Description_Memo','ProductSubLineItem.expediteReferenceIdendifier.ProprietaryReferenceIdentifier',true);
  aMapper.AddMapping('fields.Product_Description_Memo','proprietaryInformation.FreeFormText',true);
  aMapper.AddMapping('fields.MemoLine','DocumentLineReference.ProprietaryDocumentIdentifier',true);

end;

end.
