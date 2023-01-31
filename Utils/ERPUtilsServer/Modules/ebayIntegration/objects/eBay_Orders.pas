Unit eBay_Orders;
{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
}

Interface

Uses
  DB, Classes, EBayBaseObj, EBay_Orders_CheckoutStatus, EBay_Orders_ShippingDetails, EBay_Orders_Paymethods, EBay_Orders_ShippingAddress, EBay_Orders_ShipServiceSel, EBay_Orders_ExternalTransaction,
  EBay_Orders_Trans;

Type
  TeBay_Orders = Class(TeBayObjBase)
  Private
    (* fadjustmentamount                                  : Tebay_orders_adjustmentamount;
      fAmountPaid   : Tebay_orders_amountpaid; *)
    (* fAmountSaved   : Tebay_orders_AmountSaved; *)
    Fcheckoutstatus     : Tebay_orders_checkoutstatus;
    FShippingDetails    : Tebay_orders_ShippingDetails;
    FPaymethods         : Tebay_orders_paymentmethods;
    FShippingAddress    : Tebay_orders_shippingaddress;
    FShipServiceSel     : Tebay_orders_shipservcsel;
    FExternalTransaction: Tebay_orders_externaltransaction;
    FTransactions       : Tebay_orders_trans;
    Function GetOrderID: String;
    Function GetSalesOrderID: Integer;
    Function GetOrderResponse_Id: Integer;
    Function GetOrderStatus: String;
    Function GetCreatingUserRole: String;
    Function GetCreatedTime: TDateTime;
    Function GetSellerEmail: String;
    Function GetBuyerUserID: String;
    Function GetPaidTime: TDateTime;
    Function GetShippedTime: TDateTime;
    Function GetIntegratedMerchantCreditCardEnabled: Boolean;
    Function GetBundlePurchase: Boolean;
    Function GetBuyerCheckoutMessage: String;
    Function GetEIASToken: String;
    Function GetPaymentHoldStatus: String;
    Function GetRefundStatus: String;
    Function GetIsMultiLegShipping: Boolean;
    Procedure SetOrderID(Const Value: String);
    Procedure SetSalesOrderID(Const Value: Integer);
    Procedure SetOrderResponse_Id(Const Value: Integer);
    Procedure SetOrderStatus(Const Value: String);
    Procedure SetCreatingUserRole(Const Value: String);
    Procedure SetCreatedTime(Const Value: TDateTime);
    Procedure SetSellerEmail(Const Value: String);
    Procedure SetBuyerUserID(Const Value: String);
    Procedure SetPaidTime(Const Value: TDateTime);
    Procedure SetShippedTime(Const Value: TDateTime);
    Procedure SetIntegratedMerchantCreditCardEnabled(Const Value: Boolean);
    Procedure SetBundlePurchase(Const Value: Boolean);
    Procedure SetBuyerCheckoutMessage(Const Value: String);
    Procedure SetEIASToken(Const Value: String);
    Procedure SetPaymentHoldStatus(Const Value: String);
    Procedure SetRefundStatus(Const Value: String);
    Procedure SetIsMultiLegShipping(Const Value: Boolean);
    (* function getAdjustmentAmount :Tebay_orders_adjustmentamount;
      function getAmountPaid :Tebay_orders_amountpaid; *)
    (* function getAmountSaved :Tebay_orders_AmountSaved; *)
    Function GetCheckoutStatus: Tebay_orders_checkoutstatus;
    Function GetShippingDetails: Tebay_orders_ShippingDetails;
    Function GetPaymethods: Tebay_orders_paymentmethods;
    Function GetShippingAddress: Tebay_orders_shippingaddress;
    Function GetShipServiceSel: Tebay_orders_shipservcsel;
    Function GetExternalTransaction: Tebay_orders_externaltransaction;
    Function GetTransactions: Tebay_orders_trans;
    Function GetSubtotalAmt: Double;
    Function GetAmountSavedAmt: Double;
    Function GetAdjustmentamt: Double;
    Function GetPaidamt: Double;
    Function GettotalAmt: Double;
    Function GetRefundAmt: Double;
    Function GetSubTotalcurcode: String;
    Function GetAmountSavedcurcode: String;
    Function GetAdjustmentAmtCurcode: String;
    Function GetPaidAmtCurcode: String;
    Function GetTotalcurcode: String;
    Function GetRefundcurcode: String;
    Function GetEbayAccountName: String;
    Procedure SetSubtotalAmt(Const Value: Double);
    Procedure SetAmountSavedAmt(Const Value: Double);
    Procedure SetAdjustmentamt(Const Value: Double);
    Procedure SetPaidamt(Const Value: Double);
    Procedure SettotalAmt(Const Value: Double);
    Procedure SetRefundAmt(Const Value: Double);
    Procedure SetSubTotalcurcode(Const Value: String);
    Procedure SetAmountSavedcurcode(Const Value: String);
    Procedure SetAdjustmentAmtCurcode(Const Value: String);
    Procedure SetPaidAmtCurcode(Const Value: String);
    Procedure SetTotalcurcode(Const Value: String);
    Procedure SetRefundcurcode(Const Value: String);
    Procedure SetEbayAccountName(Const Value: String);
    (*
      function getOrders_PaymentMethods: TeBay_Orders_PaymentMethods;
      function getOrders_RefundArray: TeBay_Orders_RefundArray;
      function getOrders_Shipping: TeBay_Orders_Shipping;
      function getOrders_Subtotal: TeBay_Orders_Subtotal;
      function getOrders_Total: TeBay_Orders_Total;
      function getOrders_Trans: TeBay_Orders_Trans; *)
  Protected
  Public
    Constructor Create(AOwner: TComponent); Overload; Override;
    (* Property AdjustmentAmount :Tebay_orders_adjustmentamount read getAdjustmentAmount;
      Property AmountPaid :Tebay_orders_amountpaid Read getAmountPaid; *)
    (* Property AmountSaved :Tebay_orders_AmountSaved Read getAmountSaved; *)
    Property CheckoutStatus: Tebay_orders_checkoutstatus Read GetCheckOutstatus;
    Property ShippingDetails: Tebay_orders_ShippingDetails Read GetShippingDetails;
    Property Paymethods: Tebay_orders_paymentmethods Read GetPaymethods;
    Property ShippingAddress: Tebay_orders_shippingaddress Read GetShippingAddress;
    Property ShipServiceSel: Tebay_orders_shipservcsel Read GetShipServiceSel;
    Property ExternalTransaction: Tebay_orders_externaltransaction Read GetExternalTransaction;
    Property Transactions: Tebay_orders_trans Read GetTransactions;
  Published
    Property OrderID                            : String Read GetOrderID Write SetOrderID;
    Property SalesOrderID                       : Integer Read GetSalesOrderID Write SetSalesOrderID;
    Property OrderResponse_Id                   : Integer Read GetOrderResponse_Id Write SetOrderResponse_Id;
    Property OrderStatus                        : String Read GetOrderStatus Write SetOrderStatus;
    Property CreatingUserRole                   : String Read GetCreatingUserRole Write SetCreatingUserRole;
    Property CreatedTime                        : TDateTime Read GetCreatedTime Write SetCreatedTime;
    Property SellerEmail                        : String Read GetSellerEmail Write SetSellerEmail;
    Property BuyerUserID                        : String Read GetBuyerUserID Write SetBuyerUserID;
    Property PaidTime                           : TDateTime Read GetPaidTime Write SetPaidTime;
    Property ShippedTime                        : TDateTime Read GetShippedTime Write SetShippedTime;
    Property IntegratedMerchantCreditCardEnabled: Boolean Read GetIntegratedMerchantCreditCardEnabled Write SetIntegratedMerchantCreditCardEnabled;
    Property BundlePurchase                     : Boolean Read GetBundlePurchase Write SetBundlePurchase;
    Property BuyerCheckoutMessage               : String Read GetBuyerCheckoutMessage Write SetBuyerCheckoutMessage;
    Property EIASToken                          : String Read GetEIASToken Write SetEIASToken;
    Property PaymentHoldStatus                  : String Read GetPaymentHoldStatus Write SetPaymentHoldStatus;
    Property RefundStatus                       : String Read GetRefundStatus Write SetRefundStatus;
    Property IsMultiLegShipping                 : Boolean Read GetIsMultiLegShipping Write SetIsMultiLegShipping;
    Property SubtotalAmt                        : Double Read GetSubtotalAmt Write SetSubtotalAmt;
    Property AmountSavedAmt                     : Double Read GetAmountSavedAmt Write SetAmountSavedAmt;
    Property Adjustmentamt                      : Double Read GetAdjustmentamt Write SetAdjustmentamt;
    Property Paidamt                            : Double Read GetPaidamt Write SetPaidamt;
    Property TotalAmt                           : Double Read GettotalAmt Write SettotalAmt;
    Property RefundAmt                          : Double Read GetRefundAmt Write SetRefundAmt;
    Property SubTotalcurcode                    : String Read GetSubTotalcurcode Write SetSubTotalcurcode;
    Property AmountSavedcurcode                 : String Read GetAmountSavedcurcode Write SetAmountSavedcurcode;
    Property AdjustmentAmtCurcode               : String Read GetAdjustmentAmtCurcode Write SetAdjustmentAmtCurcode;
    Property PaidAmtCurcode                     : String Read GetPaidAmtCurcode Write SetPaidAmtCurcode;
    Property Totalcurcode                       : String Read GetTotalcurcode Write SetTotalcurcode;
    Property Refundcurcode                      : String Read GetRefundcurcode Write SetRefundcurcode;
    Property EbayAccountName                    : String Read GetEbayAccountName Write SetEbayAccountName;

    (*


      Property Orders_PaymentMethods:TeBay_Orders_PaymentMethods read getOrders_PaymentMethods;
      Property Orders_RefundArray:TeBay_Orders_RefundArray read getOrders_RefundArray;
      Property Orders_Subtotal:TeBay_Orders_Subtotal read getOrders_Subtotal;
      Property Orders_Total:TeBay_Orders_Total read getOrders_Total;
      Property Orders_Trans:TeBay_Orders_Trans read getOrders_Trans;
      Property Orders_Shipping:TeBay_Orders_Shipping read getOrders_Shipping; *)
  End;

Implementation

Uses
  Sysutils;

{ TeBay_Orders }

Constructor TeBay_Orders.Create(AOwner: TComponent);
Begin
  Inherited Create(AOwner);
  Tablename := 'tblebay_orders';
End;

{ Property Functions }
Function TeBay_Orders.GetOrderID: String;
Begin
  Result := GetfieldValue('OrderID');
End;

Function TeBay_Orders.GetSalesOrderID: Integer;
Begin
  Result := GetfieldValue('SalesOrderID');
End;

Function TeBay_Orders.GetOrderResponse_Id: Integer;
Begin
  Result := GetfieldValue('OrderResponseID');
End;

Function TeBay_Orders.GetOrderStatus: String;
Begin
  Result := GetfieldValue('OrderStatus');
End;

Function TeBay_Orders.GetCreatingUserRole: String;
Begin
  Result := GetfieldValue('CreatingUserRole');
End;

Function TeBay_Orders.GetCreatedTime: TDateTime;
Begin
  Result := GetfieldValue('CreatedTime');
End;

Function TeBay_Orders.GetSellerEmail: String;
Begin
  Result := GetfieldValue('SellerEmail');
End;

Function TeBay_Orders.GetBuyerUserID: String;
Begin
  Result := GetfieldValue('BuyerUserID');
End;

Function TeBay_Orders.GetPaidTime: TDateTime;
Begin
  Result := GetfieldValue('PaidTime');
End;

Function TeBay_Orders.GetShippedTime: TDateTime;
Begin
  Result := GetfieldValue('ShippedTime');
End;

Function TeBay_Orders.GetIntegratedMerchantCreditCardEnabled: Boolean;
Begin
  Result := GetfieldValue('IntegratedMerchantCreditCardEnabled');
End;

Function TeBay_Orders.GetBundlePurchase: Boolean;
Begin
  Result := GetfieldValue('BundlePurchase');
End;

Function TeBay_Orders.GetBuyerCheckoutMessage: String;
Begin
  Result := GetfieldValue('BuyerCheckoutMessage');
End;

Function TeBay_Orders.GetEIASToken: String;
Begin
  Result := GetfieldValue('EIASToken');
End;

Function TeBay_Orders.GetPaymentHoldStatus: String;
Begin
  Result := GetfieldValue('PaymentHoldStatus');
End;

Function TeBay_Orders.GetRefundStatus: String;
Begin
  Result := GetfieldValue('RefundStatus');
End;

Function TeBay_Orders.GetIsMultiLegShipping: Boolean;
Begin
  Result := GetfieldValue('IsMultiLegShipping');
End;

Procedure TeBay_Orders.SetOrderID(Const Value: String);
Begin
  SetfieldValue('OrderID', Value);
End;

Procedure TeBay_Orders.SetSalesOrderID(Const Value: Integer);
Begin
  SetfieldValue('SalesOrderID', Value);
End;

Procedure TeBay_Orders.SetOrderResponse_Id(Const Value: Integer);
Begin
  SetfieldValue('OrderResponseID', Value);
End;

Procedure TeBay_Orders.SetOrderStatus(Const Value: String);
Begin
  SetfieldValue('OrderStatus', Value);
End;

Procedure TeBay_Orders.SetCreatingUserRole(Const Value: String);
Begin
  SetfieldValue('CreatingUserRole', Value);
End;

Procedure TeBay_Orders.SetCreatedTime(Const Value: TDateTime);
Begin
  SetfieldValue('CreatedTime', Value);
End;

Procedure TeBay_Orders.SetSellerEmail(Const Value: String);
Begin
  SetfieldValue('SellerEmail', Value);
End;

Procedure TeBay_Orders.SetBuyerUserID(Const Value: String);
Begin
  SetfieldValue('BuyerUserID', Value);
End;

Procedure TeBay_Orders.SetPaidTime(Const Value: TDateTime);
Begin
  SetfieldValue('PaidTime', Value);
End;

Procedure TeBay_Orders.SetShippedTime(Const Value: TDateTime);
Begin
  SetfieldValue('ShippedTime', Value);
End;

Procedure TeBay_Orders.SetIntegratedMerchantCreditCardEnabled(Const Value: Boolean);
Begin
  SetfieldValue('IntegratedMerchantCreditCardEnabled', Value);
End;

Procedure TeBay_Orders.SetBundlePurchase(Const Value: Boolean);
Begin
  SetfieldValue('BundlePurchase', Value);
End;

Procedure TeBay_Orders.SetBuyerCheckoutMessage(Const Value: String);
Begin
  SetfieldValue('BuyerCheckoutMessage', Value);
End;

Procedure TeBay_Orders.SetEIASToken(Const Value: String);
Begin
  SetfieldValue('EIASToken', Value);
End;

Procedure TeBay_Orders.SetPaymentHoldStatus(Const Value: String);
Begin
  SetfieldValue('PaymentHoldStatus', Value);
End;

Procedure TeBay_Orders.SetRefundStatus(Const Value: String);
Begin
  SetfieldValue('RefundStatus', Value);
End;

Procedure TeBay_Orders.SetIsMultiLegShipping(Const Value: Boolean);
Begin
  SetfieldValue('IsMultiLegShipping', Value);
End;

Function TeBay_Orders.GetSubtotalAmt: Double;
Begin
  Result := GEtFieldValue('SubtotalAmt');
End;

Function TeBay_Orders.GetAmountSavedAmt: Double;
Begin
  Result := GEtFieldValue('AmountSavedAmt');
End;

Function TeBay_Orders.GetAdjustmentamt: Double;
Begin
  Result := GEtFieldValue('Adjustmentamt');
End;

Function TeBay_Orders.GetPaidamt: Double;
Begin
  Result := GEtFieldValue('Paidamt');
End;

Function TeBay_Orders.GettotalAmt: Double;
Begin
  Result := GEtFieldValue('totalAmt');
End;

Function TeBay_Orders.GetRefundAmt: Double;
Begin
  Result := GEtFieldValue('RefundAmt');
End;

Function TeBay_Orders.GetSubTotalcurcode: String;
Begin
  Result := GEtFieldValue('SubTotalcurcode');
End;

Function TeBay_Orders.GetAmountSavedcurcode: String;
Begin
  Result := GEtFieldValue('AmountSavedcurcode');
End;

Function TeBay_Orders.GetAdjustmentAmtCurcode: String;
Begin
  Result := GEtFieldValue('AdjustmentAmtCurcode');
End;

Function TeBay_Orders.GetPaidAmtCurcode: String;
Begin
  Result := GEtFieldValue('PaidAmtCurcode');
End;

Function TeBay_Orders.GetTotalcurcode: String;
Begin
  Result := GEtFieldValue('Totalcurcode');
End;

Function TeBay_Orders.GetRefundcurcode: String;
Begin
  Result := GEtFieldValue('Refundcurcode');
End;
Function TeBay_Orders.GetEbayAccountName: String;
Begin
  Result := GEtFieldValue('EbayAccountName');
End;

Procedure TeBay_Orders.SetSubtotalAmt(Const Value: Double);
Begin
  SEtFieldValue('SubtotalAmt', Value);
End;

Procedure TeBay_Orders.SetAmountSavedAmt(Const Value: Double);
Begin
  SEtFieldValue('AmountSavedAmt', Value);
End;

Procedure TeBay_Orders.SetAdjustmentamt(Const Value: Double);
Begin
  SEtFieldValue('Adjustmentamt', Value);
End;

Procedure TeBay_Orders.SetPaidamt(Const Value: Double);
Begin
  SEtFieldValue('Paidamt', Value);
End;

Procedure TeBay_Orders.SettotalAmt(Const Value: Double);
Begin
  SEtFieldValue('totalAmt', Value);
End;

Procedure TeBay_Orders.SetRefundAmt(Const Value: Double);
Begin
  SEtFieldValue('RefundAmt', Value);
End;

Procedure TeBay_Orders.SetSubTotalcurcode(Const Value: String);
Begin
  SEtFieldValue('SubTotalcurcode', Value);
End;

Procedure TeBay_Orders.SetAmountSavedcurcode(Const Value: String);
Begin
  SEtFieldValue('AmountSavedcurcode', Value);
End;

Procedure TeBay_Orders.SetAdjustmentAmtCurcode(Const Value: String);
Begin
  SEtFieldValue('AdjustmentAmtCurcode', Value);
End;

Procedure TeBay_Orders.SetPaidAmtCurcode(Const Value: String);
Begin
  SEtFieldValue('PaidAmtCurcode', Value);
End;

Procedure TeBay_Orders.SetTotalcurcode(Const Value: String);
Begin
  SEtFieldValue('Totalcurcode', Value);
End;

Procedure TeBay_Orders.SetRefundcurcode(Const Value: String);
Begin
  SEtFieldValue('Refundcurcode', Value);
End;
Procedure TeBay_Orders.SetEbayAccountName(Const Value: String);
Begin
  SEtFieldValue('EbayAccountName', Value);
End;

(* function TeBay_Orders.getAdjustmentAmount: Tebay_orders_adjustmentamount;
  begin
  if (fAdjustmentamount = nil) then begin
  fAdjustmentamount:= Tebay_orders_adjustmentamount.Create(self, 'tblebay_orders_adjustmentamount', 'OrderId =' + inttostr(ID));
  end;
  fAdjustmentamount.SQLWhere := 'OrderId  =' + inttostr(ID);
  fAdjustmentamount.Dataset;
  result:= fAdjustmentamount;
  end;
  function TeBay_Orders.getAmountPaid: Tebay_orders_amountpaid;
  begin
  if (fAmountPaid = nil) then begin
  fAmountPaid:= Tebay_orders_amountpaid.Create(self, 'tblebay_orders_amountpaid', 'OrderId =' + inttostr(ID));
  end;
  fAmountPaid.SQLWhere := 'OrderId  =' + inttostr(ID);
  fAmountPaid.Dataset;
  result:= fAmountPaid;
  end; *)
(* function TeBay_Orders.getAmountSaved: Tebay_orders_AmountSaved;
  begin
  if (fAmountSaved = nil) then begin
  fAmountSaved:= Tebay_orders_AmountSaved.Create(self, 'tblebay_orders_amountsaved', 'OrderId =' + inttostr(ID));
  end;
  fAmountSaved.SQLWhere := 'OrderId  =' + inttostr(ID);
  fAmountSaved.Dataset;
  result:= fAmountSaved;
  end; *)
Function TeBay_Orders.Getcheckoutstatus: Tebay_orders_checkoutstatus;
Begin
  If (Fcheckoutstatus = Nil) Then Begin
    Fcheckoutstatus := Tebay_orders_checkoutstatus.Create(Self, 'tblebay_orders_checkoutstatus', 'OrderId =' + Inttostr(ID));
  End;
  Fcheckoutstatus.SQLWhere := 'OrderId  =' + Inttostr(ID);
  Fcheckoutstatus.Dataset;
  Result := Fcheckoutstatus;
End;

Function TeBay_Orders.GetShippingDetails: Tebay_orders_ShippingDetails;
Begin
  If (FShippingDetails = Nil) Then Begin
    FShippingDetails := Tebay_orders_ShippingDetails.Create(Self, 'tblebay_orders_shipping', 'OrderId =' + Inttostr(ID));
  End;
  FShippingDetails.SQLWhere := 'OrderId  =' + Inttostr(ID);
  FShippingDetails.Dataset;
  Result := FShippingDetails;
End;

Function TeBay_Orders.GetPaymethods: Tebay_orders_paymentmethods;
Begin
  If (FPaymethods = Nil) Then Begin
    FPaymethods := Tebay_orders_paymentmethods.Create(Self, 'tblebay_orders_paymentmethods', '');
  End;
  FPaymethods.SQLWhere := '';
  FPaymethods.Dataset;
  Result := FPaymethods;
End;

Function TeBay_Orders.GetShippingAddress: Tebay_orders_shippingaddress;
Begin
  If (FShippingAddress = Nil) Then Begin
    FShippingAddress := Tebay_orders_shippingaddress.Create(Self, 'tblebay_orders_shippingaddress', 'OrderId =' + Inttostr(ID));
  End;
  FShippingAddress.SQLWhere := 'OrderId  =' + Inttostr(ID);
  FShippingAddress.Dataset;
  Result := FShippingAddress;
End;

Function TeBay_Orders.GetShipServiceSel: Tebay_orders_shipservcsel;
Begin
  If (FShipServiceSel = Nil) Then Begin
    FShipServiceSel := Tebay_orders_shipservcsel.Create(Self, 'tblebay_orders_shipservcsel', 'OrderId =' + Inttostr(ID));
  End;
  FShipServiceSel.SQLWhere := 'OrderId  =' + Inttostr(ID);
  FShipServiceSel.Dataset;
  Result := FShipServiceSel;
End;

Function TeBay_Orders.GetExternalTransaction: Tebay_orders_externaltransaction;
Begin
  If (FExternalTransaction = Nil) Then Begin
    FExternalTransaction := Tebay_orders_externaltransaction.Create(Self, 'tblebay_orders_externaltransaction', 'OrderId =' + Inttostr(ID));
  End;
  FExternalTransaction.SQLWhere := 'OrderId  =' + Inttostr(ID);
  FExternalTransaction.Dataset;
  Result := FExternalTransaction;
End;

Function TeBay_Orders.GetTransactions: Tebay_orders_trans;
Begin
  If (FTransactions = Nil) Then Begin
    FTransactions := Tebay_orders_trans.Create(Self, 'tblebay_orders_trans', 'OrderId =' + Inttostr(ID));
  End;
  FTransactions.SQLWhere := 'OrderId  =' + Inttostr(ID);
  FTransactions.Dataset;
  Result := FTransactions;
End; (*
  function TeBay_Orders.getOrders_ExternalTransaction: TeBay_Orders_ExternalTransaction;begin       Result := TeBay_Orders_ExternalTransaction(getcontainercomponent(TeBay_Orders_ExternalTransaction , 'Orders_ID =  ' +IntToStr(ID) , true , true));end;
  function TeBay_Orders.getOrders_PaymentMethods: TeBay_Orders_PaymentMethods;begin       Result := TeBay_Orders_PaymentMethods(getcontainercomponent(TeBay_Orders_PaymentMethods , 'Orders_ID =  ' +IntToStr(ID) , true , true));end;
  function TeBay_Orders.getOrders_RefundArray: TeBay_Orders_RefundArray;begin       Result := TeBay_Orders_RefundArray(getcontainercomponent(TeBay_Orders_RefundArray , 'Orders_ID =  ' +IntToStr(ID) , true , true));end;

  function TeBay_Orders.getOrders_Shipping: TeBay_Orders_Shipping;begin       Result := TeBay_Orders_Shipping(getcontainercomponent(TeBay_Orders_Shipping , 'Orders_ID =  ' +IntToStr(ID) , true , true));end;
  function TeBay_Orders.getOrders_ShipServcSel: TeBay_Orders_ShipServcSel;begin       Result := TeBay_Orders_ShipServcSel(getcontainercomponent(TeBay_Orders_ShipServcSel , 'Orders_ID =  ' +IntToStr(ID) , true , true));end;
  function TeBay_Orders.getOrders_Trans: TeBay_Orders_Trans;begin       Result := TeBay_Orders_Trans(getcontainercomponent(TeBay_Orders_Trans , 'Orders_ID =  ' +IntToStr(ID) , true , true));end; *)

Initialization

RegisterClass(TeBay_Orders);

End.
