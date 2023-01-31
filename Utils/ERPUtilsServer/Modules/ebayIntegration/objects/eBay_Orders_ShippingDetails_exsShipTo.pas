unit eBay_Orders_ShippingDetails_exsShipTo;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes, eBayBaseObj;


type
  Tebay_orders_shipping_exsShipto = class(TeBayObjBase)
  private
    function GetOrderID                                     : Integer   ;
    function GetOrders_Shipping_Id                          : Integer   ;
    function GetexsShipto                                    : string    ;
    procedure SetOrderID                                     (const Value: Integer    );
    procedure SetOrders_Shipping_Id                          (const Value: Integer   );
    procedure SetexsShipto                                    (const Value: string    );
  protected
  public
    constructor  Create(AOwner: TComponent);                            override;
  published
    property OrderID                                      :Integer      read GetOrderID                                    write SetOrderID                                 ;
    property Orders_Shipping_Id                           :Integer     read GetOrders_Shipping_Id                         write SetOrders_Shipping_Id                      ;
    property exsShipto                                     :string      read GetexsShipto                                   write SetexsShipto                                ;
  end;


implementation





  {Tebay_orders_shipping_exsShipto}

constructor Tebay_orders_shipping_exsShipto.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tablename := 'tblebay_orders_shipping_exsShipto';
end;

{Property Functions}
function  Tebay_orders_shipping_exsShipto.GetOrderID                                 : Integer   ; begin Result := GEtFieldValue('OrderID');end;
function  Tebay_orders_shipping_exsShipto.GetOrders_Shipping_Id                      : Integer   ; begin Result := GEtFieldValue('Orders_Shipping_Id');end;
function  Tebay_orders_shipping_exsShipto.GetexsShipto                                : string    ; begin Result := GEtFieldValue('exsShipto');end;
procedure Tebay_orders_shipping_exsShipto.SetOrderID                                 (const Value: Integer    ); begin SEtFieldValue('OrderID'                                  , Value);end;
procedure Tebay_orders_shipping_exsShipto.SetOrders_Shipping_Id                      (const Value: Integer   ); begin SEtFieldValue('Orders_Shipping_Id'                       , Value);end;
procedure Tebay_orders_shipping_exsShipto.SetexsShipto                                (const Value: string    ); begin SEtFieldValue('exsShipto'                                 , Value);end;


initialization
  RegisterClass(Tebay_orders_shipping_exsShipto);


end.
