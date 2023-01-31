unit eBay_Orders_ShippingDetails_intShipServc_shiptoLoc;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  01/07/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes, eBayBaseObj;


type
  Tebay_orders_shipping_intshipservc_shiptoloc = class(TeBayObjBase)
  private
    function GetOrderID                       : Integer   ;
    function GetOrders_Shipping_Id            : Integer   ;
    function GetOrders_Shipping_intServ_Id    : Integer   ;
    function GetLocation                      : string    ;
    procedure SetOrderID                       (const Value: Integer   );
    procedure SetOrders_Shipping_Id            (const Value: Integer   );
    procedure SetOrders_Shipping_intServ_Id    (const Value: Integer   );
    procedure SetLocation                      (const Value: string    );
  protected
  public
    constructor  Create(AOwner: TComponent);                            override;
  published
    property OrderID                        :Integer     read GetOrderID                      write SetOrderID                   ;
    property Orders_Shipping_Id             :Integer     read GetOrders_Shipping_Id           write SetOrders_Shipping_Id        ;
    property Orders_Shipping_intServ_Id     :Integer     read GetOrders_Shipping_intServ_Id   write SetOrders_Shipping_intServ_Id;
    property Location                       :string      read GetLocation                     write SetLocation                  ;
  end;


implementation


  {Tebay_orders_shipping_intshipservc_shiptoloc}

constructor Tebay_orders_shipping_intshipservc_shiptoloc.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tablename := 'tblebay_orders_shipping_intshipservc_shiptoloc';
end;

{Property Functions}
function  Tebay_orders_shipping_intshipservc_shiptoloc.GetOrderID                   : Integer   ; begin Result := GEtFieldValue('OrderID');end;
function  Tebay_orders_shipping_intshipservc_shiptoloc.GetOrders_Shipping_Id        : Integer   ; begin Result := GEtFieldValue('Orders_Shipping_Id');end;
function  Tebay_orders_shipping_intshipservc_shiptoloc.GetOrders_Shipping_intServ_Id: Integer   ; begin Result := GEtFieldValue('Orders_Shipping_intServ_Id');end;
function  Tebay_orders_shipping_intshipservc_shiptoloc.GetLocation                  : string    ; begin Result := GEtFieldValue('Location');end;
procedure Tebay_orders_shipping_intshipservc_shiptoloc.SetOrderID                   (const Value: Integer   ); begin SEtFieldValue('OrderID'                    , Value);end;
procedure Tebay_orders_shipping_intshipservc_shiptoloc.SetOrders_Shipping_Id        (const Value: Integer   ); begin SEtFieldValue('Orders_Shipping_Id'         , Value);end;
procedure Tebay_orders_shipping_intshipservc_shiptoloc.SetOrders_Shipping_intServ_Id(const Value: Integer   ); begin SEtFieldValue('Orders_Shipping_intServ_Id' , Value);end;
procedure Tebay_orders_shipping_intshipservc_shiptoloc.SetLocation                  (const Value: string    ); begin SEtFieldValue('Location'                   , Value);end;


initialization
  RegisterClass(Tebay_orders_shipping_intshipservc_shiptoloc);


end.
