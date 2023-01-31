unit InventoryTypes;

interface

type
  TStockCostSystem = (scsFIFO, scsLast, scsAvg);
  TStockCostSystemInfo = array [ low(TStockCostSystem) .. high(TStockCostSystem)] of integer;


implementation

end.
