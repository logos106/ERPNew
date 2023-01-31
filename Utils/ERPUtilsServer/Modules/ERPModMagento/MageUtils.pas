unit MageUtils;

interface

type

  TMagePaymentType = record
    MageCode: string;
    ERPCashCode: string;
    ERPCode: string;
    Desc: string;
  end;

const

  MagePayMethods: array [0..5] of TMagePaymentType =
  (
    (MageCode: 'ccsave';          ERPCashCode: 'Credit Card';     ERPCode: '';      Desc: 'Saved CC'),
    (MageCode: 'checkmo';         ERPCashCode: 'Cheque';          ERPCode: '';      Desc: 'Check / Money Order'),
    (MageCode: 'free';            ERPCashCode: 'Cash';            ERPCode: '';      Desc: 'Zero Subtotal Checkout'),
    (MageCode: 'purchaseorder';   ERPCashCode: '';                ERPCode: '';      Desc: 'Purchase Order'),
    (MageCode: 'banktransfer';    ERPCashCode: 'Direct Deposit';  ERPCode: '';      Desc: 'Bank Transfer Payment'),
    (MageCode: 'cashondelivery';  ERPCashCode: '';                ERPCode: '';      Desc: 'Cash On Delivery Payment')
  );

  function MagePaymentMethodToCashSalePaymentMethod(s: string): string;

implementation

uses
  sysutils;

function MagePaymentMethodToCashSalePaymentMethod(s: string): string;
var
  x: integer;
begin
  result := '';
  for x := Low(MagePayMethods) to High(MagePayMethods) do begin
    if SameText(MagePayMethods[x].MageCode,s) then begin
      result := MagePayMethods[x].ERPCashCode;
      break;
    end;
  end;
end;


end.
