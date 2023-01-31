{CompanyInfo}
SELECT   
CO.CompanyName, 
CO.Address, 
CO.Address2, 
CO.City, 
CO.State,   
CO.Postcode, 
CO.PhoneNumber AS PhoneNumber, 
CO.FaxNumber AS FaxNumber, 
CO.ABN     
FROM tblCompanyInformation AS CO  
~|||~{Receipt}
select
R.ID as ReceiptID,
R.GlobalRef as ReceiptGlobalRef,
R.PurchaseOrderID,
R.ReceiptStartTime,
R.ReceiptEndTime,
R.Active as ReceiptActive,
R.Processed,
PO.ClientPrintName,
PO.PurchaseOrderNumber,
PO.OrderDate,
RL.ID as ReceiptLineID,
RL.PurchaseLineID,
RL.QuantityReceived,
RL.SerialNumber,
RL.BatchNumber,
RL.BatchExpiryDate,
RL.BinID,
RL.Deleted,
PL.ProductPrintName,
PL.Product_Description as ProductDescription,
PL.Class as Department,
PL.QtySold,
PL.Shipped as QtyShipped,
PL.BackOrder as QtyBackOrder,
PL.UnitOfMeasurePOLines as UOM,
PL.UnitofMeasureQtySold as UOMQtySold,
PL.UnitofMeasureShipped as UOMQtyShipped,
PL.UnitofMeasureBackOrder as UOMQtyBackorder,
P.SNTracking,
P.CUSTFLD1,
P.CUSTFLD2,
P.CUSTFLD3,
P.CUSTFLD4,
P.CUSTFLD5,
P.CUSTFLD6,
P.CUSTFLD7,
P.CUSTFLD8,
P.CUSTFLD9,
P.CUSTFLD10,
P.CUSTFLD11,
P.CUSTFLD12,
P.CUSTFLD13,
P.CUSTFLD14,
P.CUSTFLD15,
P.CUSTDATE1,
P.CUSTDATE2,
P.CUSTDATE3
from
tblGoodsReceipt as R
inner join tblGoodsReceiptLines as RL on RL.MasterID = R.ID
inner join tblpurchaseOrders as PO on PO.PurchaseOrderID = R.PurchaseOrderID
inner join tblPurchaseLines as PL on PL.PurchaseLineID = RL.PurchaseLineID
inner join tblparts P on P.PARTSID = PL.ProductID
