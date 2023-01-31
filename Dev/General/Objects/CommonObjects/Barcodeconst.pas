unit Barcodeconst;

interface
const
  {NOTE: Code39 barcodes can only contain: A-Z (uppercase), space, minus (-),
         plus (+), period (.), dollar sign ($), slash (/), and percent (%)}

  Barcode_SepChar = '-';

  Barcode_Prefix_Employee     = 'EMP';
  Barcode_Prefix_Sale         = 'S'; { S-[sales Id] }
  Barcode_Prefix_SalesLine    = 'SL'; { SL-[Sales Line Id] }
  Barcode_Prefix_UOMSalesLine = 'USL'; {ie: USL-[UOM Id]-[Sales Line Id]}
  Barcode_Prefix_DisPatch     = 'DIS';
  Barcode_StartNew            = 'START-NEW';
  Barcode_Prefix_PQABATCH     = 'PBA';// Partsid - Bachnumber
  Barcode_Prefix_PQASN        = 'PSN';// Partsid - Serialnumber
  Barcode_Prefix_PQACOMB      = 'PCOMB';
  Barcode_Prefix_BXR          = 'BXR'; //Barcode x ref -> tblBarcodexRef
  Barcode_Prefix_SLBatch      = 'SLB'; // SaleslineId - batchno
  Barcode_Prefix_PurchaseOrder = 'P'; { P-[Purchase Order Id] }
  Barcode_Prefix_PurchaseLine = 'PL'; { PL-[Purchase Order Line Id] }
  Barcode_Prefix_Proctree     = 'PT'; {PT-ProctreeID}
  Barcode_Prefix_DeptClass    = 'DEPT';

implementation

end.



