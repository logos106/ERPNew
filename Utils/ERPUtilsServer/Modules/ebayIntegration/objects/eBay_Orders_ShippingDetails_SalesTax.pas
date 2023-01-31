unit eBay_Orders_ShippingDetails_SalesTax;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes, eBayBaseObj;


type
  Tebay_orders_shipping_salestax = class(TeBayObjBase)
  private
    function GetOrderID                                     : Integer   ;
    function GetOrders_Shipping_Id                          : Integer   ;
    function GetSalesTaxPercent                             : Double    ;
    function GetSalesTaxState                               : string    ;
    function GetShippingIncludedInTax                       : Boolean ;
    procedure SetOrderID                                     (const Value: Integer    );
    procedure SetOrders_Shipping_Id                          (const Value: Integer   );
    procedure SetSalesTaxPercent                             (const Value: Double    );
    procedure SetSalesTaxState                               (const Value: string    );
    procedure SetShippingIncludedInTax                       (const Value: Boolean);
    function getSalesTaxAmount :double;
    function getSalesTaxAmountCurrCode:String;
    procedure SetSalesTaxAmount(const Value :Double);
    procedure setSalesTaxAmountCurrCode(const Value:String);

  protected
  public
    constructor  Create(AOwner: TComponent);                            override;
  published
    property OrderID                                      :Integer      read GetOrderID                                    write SetOrderID                                 ;
    property Orders_Shipping_Id                           :Integer     read GetOrders_Shipping_Id                         write SetOrders_Shipping_Id                      ;
    property SalesTaxPercent                              :Double      read GetSalesTaxPercent                            write SetSalesTaxPercent                         ;
    property SalesTaxState                                :string      read GetSalesTaxState                              write SetSalesTaxState                           ;
    property ShippingIncludedInTax                        :Boolean     read GetShippingIncludedInTax                      write SetShippingIncludedInTax                   ;
    Property SalesTaxAmount                               :double      read getSalesTaxAmount                             Write SetSalesTaxAmount;
    Property SalesTaxAmountCurrCode                       :String      read getSalesTaxAmountCurrCode                     write setSalesTaxAmountCurrCode;
  end;


implementation


uses sysutils;



  {Tebay_orders_shipping_salestax}

constructor Tebay_orders_shipping_salestax.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tablename := 'tblebay_orders_shipping_salestax';
end;

{Property Functions}
function  Tebay_orders_shipping_salestax.GetOrderID                                 : Integer   ; begin Result := GetFieldValue('OrderID');end;
function  Tebay_orders_shipping_salestax.GetOrders_Shipping_Id                      : Integer   ; begin Result := GetFieldValue('Orders_Shipping_Id');end;
function  Tebay_orders_shipping_salestax.GetSalesTaxPercent                         : Double    ; begin Result := GetFieldValue('SalesTaxPercent');end;
function  Tebay_orders_shipping_salestax.GetSalesTaxState                           : string    ; begin Result := GetFieldValue('SalesTaxState');end;
function  Tebay_orders_shipping_salestax.GetShippingIncludedInTax                   : Boolean   ; begin Result := GetFieldValue('ShippingIncludedInTax');end;
procedure Tebay_orders_shipping_salestax.SetOrderID                                 (const Value: Integer    ); begin SetFieldValue('OrderID'                                  , Value);end;
procedure Tebay_orders_shipping_salestax.SetOrders_Shipping_Id                      (const Value: Integer   ); begin SetFieldValue('Orders_Shipping_Id'                       , Value);end;
procedure Tebay_orders_shipping_salestax.SetSalesTaxPercent                         (const Value: Double    ); begin SetFieldValue('SalesTaxPercent'                          , Value);end;
procedure Tebay_orders_shipping_salestax.SetSalesTaxState                           (const Value: string    ); begin SetFieldValue('SalesTaxState'                            , Value);end;
procedure Tebay_orders_shipping_salestax.SetShippingIncludedInTax                   (const Value: Boolean   ); begin SetFieldValue('ShippingIncludedInTax'                    , Value);end;
function Tebay_orders_shipping_salestax.getSalesTaxAmount :double; begin result := GetFieldValue('SalesTaxAmount'); end;
function Tebay_orders_shipping_salestax.getSalesTaxAmountCurrCode:String; begin result := GetFieldValue('SalesTaxAmountCurrCode'); end;
procedure Tebay_orders_shipping_salestax.SetSalesTaxAmount(const Value :Double);begin SetFieldValue('SalesTaxAmount' , Value);end;
procedure Tebay_orders_shipping_salestax.setSalesTaxAmountCurrCode(const Value:String);begin SetFieldValue('SalesTaxAmountCurrCode' , Value); end;

initialization
  RegisterClass(Tebay_orders_shipping_salestax);


end.
