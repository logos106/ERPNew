unit eBay_Orders_ShippingDetails;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes, eBayBaseObj , eBay_Orders_ShippingDetails_exsShipTo, eBay_Orders_ShippingDetails_intshipservc, eBay_Orders_ShippingDetails_SalesTax,
        eBay_Orders_ShippingDetails_ShipUptrack,eBay_Orders_ShippingDetails_ShipServ, eBay_Orders_ShippingDetails_Taxable;


type
  Tebay_orders_shippingDetails = class(TeBayObjBase)
  private
    fexsShipto : Tebay_orders_shipping_exsShipto;
    fintshipservc : Tebay_orders_shipping_intshipservc;
    fSalesTax : Tebay_orders_shipping_salestax;
    fTaxable : Tebay_orders_shipping_Taxable;
    fShipUptrack : Tebay_orders_shipping_ShipUptrack;
    fShipServ : Tebay_orders_shipping_shipservc;
    function GetOrderID                                     : Integer   ;
    function GetAllowPaymentEdit                            : Boolean;
    function GetApplyShippingDiscount                       : Boolean;
    function GetGlobalShipping                              : Boolean    ;
    function GetChangePaymentInstructions                   : Boolean   ;
    function GetInsuranceOption                             : string    ;
    function GetInsuranceWanted                             : Boolean;
    function GetPaymentEdited                               : Boolean   ;
    function GetPaymentInstructions                         : string    ;
    function GetShippingRateErrorMessage                    : string    ;
    function GetShippingRateType                            : string    ;
    function GetShippingType                                : string    ;
    function GetSellingManagerSalesRecordNumber             : Integer   ;
    function GetThirdPartyCheckout                          : Boolean   ;
    function GetGetItFast                                   : Boolean   ;
    function GetShippingServiceUsed                         : string    ;
    function GetShippingDiscountProfileID                   : string    ;
    function GetPromotionalShippingDiscount                 : Boolean   ;
    function GetInternationalShippingDiscountProfileID      : string    ;
    function GetInternationalPromotionalShippingDiscount    : Boolean    ;
    function GetSellerexsShiptosPreference                  : Boolean   ;
    procedure SetOrderID                                     (const Value: Integer    );
    procedure SetAllowPaymentEdit                            (const Value: Boolean);
    procedure SetApplyShippingDiscount                       (const Value: Boolean);
    procedure SetGlobalShipping                              (const Value: Boolean);
    procedure SetChangePaymentInstructions                   (const Value: Boolean   );
    procedure SetInsuranceOption                             (const Value: string    );
    procedure SetInsuranceWanted                             (const Value: Boolean);
    procedure SetPaymentEdited                               (const Value: Boolean   );
    procedure SetPaymentInstructions                         (const Value: string    );
    procedure SetShippingRateErrorMessage                    (const Value: string    );
    procedure SetShippingRateType                            (const Value: string    );
    procedure SetShippingType                                (const Value: string    );
    procedure SetSellingManagerSalesRecordNumber             (const Value: Integer   );
    procedure SetThirdPartyCheckout                          (const Value: Boolean   );
    procedure SetGetItFast                                   (const Value: Boolean );
    procedure SetShippingServiceUsed                         (const Value: string    );
    procedure SetShippingDiscountProfileID                   (const Value: string    );
    procedure SetPromotionalShippingDiscount                 (const Value: Boolean    );
    procedure SetInternationalShippingDiscountProfileID      (const Value: string    );
    procedure SetInternationalPromotionalShippingDiscount    (const Value: Boolean    );
    procedure SetSellerexsShiptosPreference                  (const Value: Boolean    );
    function getexsShipto :Tebay_orders_shipping_exsShipto;
    function getintshipservc :Tebay_orders_shipping_intshipservc;
    function getSalesTax :Tebay_orders_shipping_salestax;
    function getTaxable :Tebay_orders_shipping_Taxable;
    function getShipUptrack :Tebay_orders_shipping_ShipUptrack;
    function getShipServ :Tebay_orders_shipping_shipservc;
    (*

    function getOrders_Shipping_TaxTable: Tebay_orders_shippingDetails_TaxTable;*)

  protected
  public
    constructor  Create(AOwner: TComponent);                            override;
    Property exsShipto : Tebay_orders_shipping_exsShipto read getexsShipto;
    Property intshipservc : Tebay_orders_shipping_intshipservc read getintshipservc;
    Property SalesTax : Tebay_orders_shipping_salestax read getSalesTax;
    Property Taxable : Tebay_orders_shipping_Taxable read getTaxable;
    Property ShipUptrack : Tebay_orders_shipping_ShipUptrack read getShipUptrack;
    Property ShipServ : Tebay_orders_shipping_shipservc read getShipServ;
  published
    property OrderID                                      :Integer      read GetOrderID                                    write SetOrderID                                 ;
    property AllowPaymentEdit                             :Boolean     read GetAllowPaymentEdit                           write SetAllowPaymentEdit                        ;
    property ApplyShippingDiscount                        :Boolean     read GetApplyShippingDiscount                      write SetApplyShippingDiscount                   ;
    property GlobalShipping                               :Boolean     read GetGlobalShipping                             write SetGlobalShipping                          ;
    property ChangePaymentInstructions                    :Boolean     read GetChangePaymentInstructions                  write SetChangePaymentInstructions               ;
    property InsuranceOption                              :string      read GetInsuranceOption                            write SetInsuranceOption                         ;
    property InsuranceWanted                              :Boolean     read GetInsuranceWanted                            write SetInsuranceWanted                         ;
    property PaymentEdited                                :Boolean     read GetPaymentEdited                              write SetPaymentEdited                           ;
    property PaymentInstructions                          :string      read GetPaymentInstructions                        write SetPaymentInstructions                     ;
    property ShippingRateErrorMessage                     :string      read GetShippingRateErrorMessage                   write SetShippingRateErrorMessage                ;
    property ShippingRateType                             :string      read GetShippingRateType                           write SetShippingRateType                        ;
    property ShippingType                                 :string      read GetShippingType                               write SetShippingType                            ;
    property SellingManagerSalesRecordNumber              :Integer     read GetSellingManagerSalesRecordNumber            write SetSellingManagerSalesRecordNumber         ;
    property ThirdPartyCheckout                           :Boolean     read GetThirdPartyCheckout                         write SetThirdPartyCheckout                      ;
    property GetItFast                                    :Boolean     read GetGetItFast                                  write SetGetItFast                               ;
    property ShippingServiceUsed                          :string      read GetShippingServiceUsed                        write SetShippingServiceUsed                     ;
    property ShippingDiscountProfileID                    :string      read GetShippingDiscountProfileID                  write SetShippingDiscountProfileID               ;
    property PromotionalShippingDiscount                  :Boolean     read GetPromotionalShippingDiscount                write SetPromotionalShippingDiscount             ;
    property InternationalShippingDiscountProfileID       :string      read GetInternationalShippingDiscountProfileID     write SetInternationalShippingDiscountProfileID  ;
    property InternationalPromotionalShippingDiscount     :Boolean     read GetInternationalPromotionalShippingDiscount   write SetInternationalPromotionalShippingDiscount;
    property SellerexsShiptosPreference                   :Boolean     read GetSellerexsShiptosPreference                  write SetSellerexsShiptosPreference               ;

  end;


implementation

uses Sysutils;





  {Tebay_orders_shippingDetails}

constructor Tebay_orders_shippingDetails.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tablename := 'tblebay_orders_shipping';
end;



{Property Functions}
function  Tebay_orders_shippingDetails.GetOrderID                                 : Integer   ; begin Result := GEtFieldValue('OrderID');end;
function  Tebay_orders_shippingDetails.GetAllowPaymentEdit                        : Boolean   ; begin Result := GEtFieldValue('AllowPaymentEdit');end;
function  Tebay_orders_shippingDetails.GetApplyShippingDiscount                   : Boolean   ; begin Result := GEtFieldValue('ApplyShippingDiscount');end;
function  Tebay_orders_shippingDetails.GetGlobalShipping                          : Boolean   ; begin Result := GEtFieldValue('GlobalShipping');end;
function  Tebay_orders_shippingDetails.GetChangePaymentInstructions               : Boolean   ; begin Result := GEtFieldValue('ChangePaymentInstructions');end;

function  Tebay_orders_shippingDetails.GetInsuranceOption                         : string    ; begin Result := GEtFieldValue('InsuranceOption');end;
function  Tebay_orders_shippingDetails.GetInsuranceWanted                         : Boolean   ; begin Result := GEtFieldValue('InsuranceWanted');end;
function  Tebay_orders_shippingDetails.GetPaymentEdited                           : Boolean   ; begin Result := GEtFieldValue('PaymentEdited');end;
function  Tebay_orders_shippingDetails.GetPaymentInstructions                     : string    ; begin Result := GEtFieldValue('PaymentInstructions');end;
function  Tebay_orders_shippingDetails.GetShippingRateErrorMessage                : string    ; begin Result := GEtFieldValue('ShippingRateErrorMessage');end;
function  Tebay_orders_shippingDetails.GetShippingRateType                        : string    ; begin Result := GEtFieldValue('ShippingRateType');end;
function  Tebay_orders_shippingDetails.GetShippingType                            : string    ; begin Result := GEtFieldValue('ShippingType');end;
function  Tebay_orders_shippingDetails.GetSellingManagerSalesRecordNumber         : Integer   ; begin Result := GEtFieldValue('SellingManagerSalesRecordNumber');end;
function  Tebay_orders_shippingDetails.GetThirdPartyCheckout                      : Boolean   ; begin Result := GEtFieldValue('ThirdPartyCheckout');end;
function  Tebay_orders_shippingDetails.GetGetItFast                               : Boolean   ; begin Result := GEtFieldValue('GetItFast');end;
function  Tebay_orders_shippingDetails.GetShippingServiceUsed                     : string    ; begin Result := GEtFieldValue('ShippingServiceUsed');end;
function  Tebay_orders_shippingDetails.GetShippingDiscountProfileID               : string    ; begin Result := GEtFieldValue('ShippingDiscountProfileID');end;
function  Tebay_orders_shippingDetails.GetPromotionalShippingDiscount             : Boolean   ; begin Result := GEtFieldValue('PromotionalShippingDiscount');end;
function  Tebay_orders_shippingDetails.GetInternationalShippingDiscountProfileID  : string    ; begin Result := GEtFieldValue('InternationalShippingDiscountProfileID');end;
function  Tebay_orders_shippingDetails.GetInternationalPromotionalShippingDiscount: Boolean   ; begin Result := GEtFieldValue('InternationalPromotionalShippingDiscount');end;
function  Tebay_orders_shippingDetails.GetSellerexsShiptosPreference              : Boolean    ; begin Result := GEtFieldValue('SellerexsShiptosPreference');end;
procedure Tebay_orders_shippingDetails.SetOrderID                                 (const Value: Integer    ); begin SEtFieldValue('OrderID'                                  , Value);end;
procedure Tebay_orders_shippingDetails.SetAllowPaymentEdit                        (const Value: Boolean   ); begin SEtFieldValue('AllowPaymentEdit'                         , Value);end;
procedure Tebay_orders_shippingDetails.SetApplyShippingDiscount                   (const Value: Boolean   ); begin SEtFieldValue('ApplyShippingDiscount'                    , Value);end;
procedure Tebay_orders_shippingDetails.SetGlobalShipping                          (const Value: Boolean   ); begin SEtFieldValue('GlobalShipping'                           , Value);end;
procedure Tebay_orders_shippingDetails.SetChangePaymentInstructions               (const Value: Boolean   ); begin SEtFieldValue('ChangePaymentInstructions'                , Value);end;
procedure Tebay_orders_shippingDetails.SetInsuranceOption                         (const Value: string    ); begin SEtFieldValue('InsuranceOption'                          , Value);end;
procedure Tebay_orders_shippingDetails.SetInsuranceWanted                         (const Value: Boolean   ); begin SEtFieldValue('InsuranceWanted'                          , Value);end;
procedure Tebay_orders_shippingDetails.SetPaymentEdited                           (const Value: Boolean   ); begin SEtFieldValue('PaymentEdited'                            , Value);end;
procedure Tebay_orders_shippingDetails.SetPaymentInstructions                     (const Value: string    ); begin SEtFieldValue('PaymentInstructions'                      , Value);end;
procedure Tebay_orders_shippingDetails.SetShippingRateErrorMessage                (const Value: string    ); begin SEtFieldValue('ShippingRateErrorMessage'                 , Value);end;
procedure Tebay_orders_shippingDetails.SetShippingRateType                        (const Value: string    ); begin SEtFieldValue('ShippingRateType'                         , Value);end;
procedure Tebay_orders_shippingDetails.SetShippingType                            (const Value: string    ); begin SEtFieldValue('ShippingType'                             , Value);end;
procedure Tebay_orders_shippingDetails.SetSellingManagerSalesRecordNumber         (const Value: Integer   ); begin SEtFieldValue('SellingManagerSalesRecordNumber'          , Value);end;
procedure Tebay_orders_shippingDetails.SetThirdPartyCheckout                      (const Value: Boolean   ); begin SEtFieldValue('ThirdPartyCheckout'                       , Value);end;
procedure Tebay_orders_shippingDetails.SetGetItFast                               (const Value: Boolean   ); begin SEtFieldValue('GetItFast'                                , Value);end;
procedure Tebay_orders_shippingDetails.SetShippingServiceUsed                     (const Value: string    ); begin SEtFieldValue('ShippingServiceUsed'                      , Value);end;
procedure Tebay_orders_shippingDetails.SetShippingDiscountProfileID               (const Value: string    ); begin SEtFieldValue('ShippingDiscountProfileID'                , Value);end;
procedure Tebay_orders_shippingDetails.SetPromotionalShippingDiscount             (const Value: Boolean   ); begin SEtFieldValue('PromotionalShippingDiscount'              , Value);end;
procedure Tebay_orders_shippingDetails.SetInternationalShippingDiscountProfileID  (const Value: string    ); begin SEtFieldValue('InternationalShippingDiscountProfileID'   , Value);end;
procedure Tebay_orders_shippingDetails.SetInternationalPromotionalShippingDiscount(const Value: Boolean   ); begin SEtFieldValue('InternationalPromotionalShippingDiscount' , Value);end;
procedure Tebay_orders_shippingDetails.SetSellerexsShiptosPreference              (const Value: Boolean   ); begin SEtFieldValue('SellerexsShiptosPreference'                , Value);end;
function Tebay_orders_shippingDetails.getexsShipto: Tebay_orders_shipping_exsShipto;
begin
  if (fexsShipto = nil) then begin
    fexsShipto:= Tebay_orders_shipping_exsShipto.Create(self, 'tblebay_orders_shipping_exsShipto', 'OrderId =' + inttostr(OrderID)+' and  Orders_Shipping_Id = ' + inttostr(ID));
  end;
  fexsShipto.SQLWhere := 'OrderId =' + inttostr(OrderID)+' and  Orders_Shipping_Id = ' + inttostr(ID);
  fexsShipto.Dataset;
  result:= fexsShipto;
end;
function Tebay_orders_shippingDetails.getintshipservc: Tebay_orders_shipping_intshipservc;
begin
  if (fintshipservc = nil) then begin
    fintshipservc:= Tebay_orders_shipping_intshipservc.Create(self, 'tblebay_orders_shipping_intshipservc', 'OrderId =' + inttostr(OrderID)+' and  Orders_Shipping_Id = ' + inttostr(ID));
  end;
  fintshipservc.SQLWhere := 'OrderId =' + inttostr(OrderID)+' and  Orders_Shipping_Id = ' + inttostr(ID);
  fintshipservc.Dataset;
  result:= fintshipservc;
end;
function Tebay_orders_shippingDetails.getSalesTax: Tebay_orders_shipping_salestax;
begin
  if (fSalesTax = nil) then begin
    fSalesTax:= Tebay_orders_shipping_salestax.Create(self, 'tblebay_orders_shipping_SalesTax', 'OrderId =' + inttostr(OrderID)+' and  Orders_Shipping_Id = ' + inttostr(ID));
  end;
  fSalesTax.SQLWhere := 'OrderId =' + inttostr(OrderID)+' and  Orders_Shipping_Id = ' + inttostr(ID);
  fSalesTax.Dataset;
  result:= fSalesTax;
end;
function Tebay_orders_shippingDetails.getTaxable: Tebay_orders_shipping_Taxable;
begin
  if (fTaxable = nil) then begin
    fTaxable:= Tebay_orders_shipping_Taxable.Create(self, 'tblebay_orders_shipping_Taxable', 'OrderId =' + inttostr(OrderID)+' and  Orders_Shipping_Id = ' + inttostr(ID));
  end;
  fTaxable.SQLWhere := 'OrderId =' + inttostr(OrderID)+' and  Orders_Shipping_Id = ' + inttostr(ID);
  fTaxable.Dataset;
  result:= fTaxable;
end;
function Tebay_orders_shippingDetails.getShipUptrack: Tebay_orders_shipping_ShipUptrack;
begin
  if (fShipUptrack = nil) then begin
    fShipUptrack:= Tebay_orders_shipping_ShipUptrack.Create(self, 'tblebay_orders_shipping_ShipUptrack', 'OrderId =' + inttostr(OrderID)+' and  Orders_Shipping_Id = ' + inttostr(ID));
  end;
  fShipUptrack.SQLWhere := 'OrderId =' + inttostr(OrderID)+' and  Orders_Shipping_Id = ' + inttostr(ID);
  fShipUptrack.Dataset;
  result:= fShipUptrack;
end;
function Tebay_orders_shippingDetails.getShipServ: Tebay_orders_shipping_shipservc;
begin
  if (fShipServ = nil) then begin
    fShipServ:= Tebay_orders_shipping_shipservc.Create(self, 'tblebay_orders_shipping_shipservc', 'OrderId =' + inttostr(OrderID)+' and  Orders_Shipping_Id = ' + inttostr(ID));
  end;
  fShipServ.SQLWhere := 'OrderId =' + inttostr(OrderID)+' and  Orders_Shipping_Id = ' + inttostr(ID);
  fShipServ.Dataset;
  result:= fShipServ;
end;

(*

 function Tebay_orders_shippingDetails.getOrders_Shipping_TaxTable: Tebay_orders_shippingDetails_TaxTable;begin       Result := Tebay_orders_shippingDetails_TaxTable(getcontainercomponent(Tebay_orders_shippingDetails_TaxTable , 'Orders_Shipping_ID = ' + IntToStr(ID) , true , true));end;*)

initialization
  RegisterClass(Tebay_orders_shippingDetails);


end.
