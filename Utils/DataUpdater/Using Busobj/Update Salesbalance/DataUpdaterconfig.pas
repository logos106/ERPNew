unit DataUpdaterconfig;

interface

const
  USERNAME              = 'Admin';
  DLLNAME               = 'C:\P1\Utils\APIDLL\APIDLL.DLL';
  LINEADJUSTMENTPRODUCT = 'NonInv Misc';
  {DLL function names }
  FUNC_OPENFORUSER      ='OpenForUser';
  FUNC_GETBUSOBJ        ='GetBusobj';
  FUNC_CURCONNECTION    ='CurConnection';
  FUNC_NEW              ='DLLNew';
  FUNC_SAVE             ='DLLSave';
  FUNC_DELETE           ='DLLDelete';
  FUNC_POSTDB           ='DLLPOSTDB';
  FUNC_LOADSELECT       ='DLLLoadselect';
  FUNC_CALCORDERTOTALS  ='DLLCalcOrderTotals';
  

  {busobjnames as they are casesensitive}
  CashSale   ='TCashSale';
  RefundSale ='TRefundSale';
  Quote      ='TQuote';
  SalesOrder ='TSalesOrder';
  Invoice    ='TInvoice';
  (*Voucher
  Layby
  LaybyPOS
  LaybyPayment
  POS*)

implementation

end.
