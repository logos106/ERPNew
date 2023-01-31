unit SalesConst;

interface

uses
  tcConst;

type

   TsaleType = (stNone= 0,
                stInvoice=1,
                stCashsale=2,
                stSalesOrder=3,
                stPOS = 4,
                stPOSLayby=5,
                stPOSLaybyPayment=6,
                stQuote=7,
                stPOSCashSale=8,
                stCustomerReturn=9);


const

  {  event constants }
  evSaleShipDateChange = faSales + 0;

  evSalesLineProductChange        = faSales + 100;
  evSalesAfterGetBaseLinePrice    = faSales + 101;
  evSalesLineAfterGetBaseLineCost = faSales + 102;
  evSalesLineQtyChange            = faSales + 103;
  evSalesDateChange               = faSales + 104;

  evSalesLineUOMQtySoldChange     = faSales + 105;
  evSalesLineClonePropertyObjects = faSales + 106;
  evSalesLineDeletedChange        = faSales + 107;
  evSalesLineShipDateChange       = faSales + 108;
  evSalesLinePartsourceChange     = faSales + 109;
  evSalesLinecheckForTree         = faSales + 110;
  evSalesLineUOMChange            = faSales + 111;
  evSalesBuildWhole               = faSales + 112;
  evSalesLineMakeCleanTree        = faSales + 113;
  evSalesLineCalcTreePrice        = faSales + 114;
  evProductSelected               = faSales + 115;
  evBOMMergingLine                = faSales + 116;
  evBOMProductionLine             = faSales + 117;
  evSalesLineCalcTreecost         = faSales + 118;
  evSalesLineFixTreecost          = faSales + 119;
  evupdateCustomerEquipQty        = faSales + 120;
  evSalesReadBOMPrice             = faSales + 121;
(*  evuBuildaQty =faSales+ 120;
  evuBatchInput=faSales+ 121;*)

  {Walmart Event constants}
    { TODO : Walmart - Backorders }
    evSalesBOLineSave = faSales + 201;

implementation

end.
