unit eBay_Orders_ShippingDetails_ShipupTrack;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes, eBayBaseObj, eBay_Orders_ShippingDetails_ShipupTrack_Shipline;


type
  Tebay_orders_shipping_ShipUptrack = class(TeBayObjBase)
  private
    fShipline : Tebay_orders_shipping_ShipUptrack_shipline;
    function GetOrderID                                     : Integer   ;
    function GetOrders_Shipping_Id                          : Integer   ;
    function GetShippingCarrierUsed                         : string    ;
    function GetShipmentTrackingNumber                      : string    ;
    procedure SetOrderID                                     (const Value: Integer    );
    procedure SetOrders_Shipping_Id                          (const Value: Integer   );
    procedure SetShippingCarrierUsed                         (const Value: string    );
    procedure SetShipmentTrackingNumber                      (const Value: string    );
    function getShipLine:Tebay_orders_shipping_ShipUptrack_shipline;

  protected
  public
    constructor  Create(AOwner: TComponent);                            override;
    Property Shipline :Tebay_orders_shipping_ShipUptrack_shipline read getShipLine;
  published
    property OrderID                                      :Integer      read GetOrderID                                    write SetOrderID                                 ;
    property Orders_Shipping_Id                           :Integer     read GetOrders_Shipping_Id                         write SetOrders_Shipping_Id                      ;
    property ShippingCarrierUsed                          :string      read GetShippingCarrierUsed                        write SetShippingCarrierUsed                     ;
    property ShipmentTrackingNumber                       :string      read GetShipmentTrackingNumber                     write SetShipmentTrackingNumber                  ;
  end;


implementation


uses Sysutils;



  {Tebay_orders_shipping_ShipUptrack}

constructor Tebay_orders_shipping_ShipUptrack.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tablename := 'tblebay_orders_shipping_shiuptrack';
end;

{Property Functions}
function  Tebay_orders_shipping_ShipUptrack.GetOrderID                                 : Integer   ; begin Result := GetFieldValue('OrderID');end;
function  Tebay_orders_shipping_ShipUptrack.GetOrders_Shipping_Id                      : Integer   ; begin Result := GetFieldValue('Orders_Shipping_Id');end;

function Tebay_orders_shipping_ShipUptrack.getShipLine: Tebay_orders_shipping_ShipUptrack_shipline;
begin
  if (fShipLine = nil) then begin
    fShipLine:= Tebay_orders_shipping_ShipUptrack_shipline.Create(self, 'tblebay_orders_shipping_shiuptrack_shipline', 'OrderId =' + inttostr(OrderID)+' and  Orders_Shipping_Id = ' + inttostr(Orders_Shipping_Id) + ' and Orders_Shipping_ShiupTrack_Id =' + inttostr(ID));
  end;
  fShipLine.SQLWhere := 'OrderId =' + inttostr(OrderID)+' and  Orders_Shipping_Id = ' + inttostr(Orders_Shipping_Id)+ ' and Orders_Shipping_ShiupTrack_Id =' + inttostr(ID);
  fShipLine.Dataset;
  result:= fShipLine;

end;
function  Tebay_orders_shipping_ShipUptrack.GetShippingCarrierUsed                     : string    ; begin Result := GetFieldValue('ShippingCarrierUsed');end;
function  Tebay_orders_shipping_ShipUptrack.GetShipmentTrackingNumber                  : string    ; begin Result := GetFieldValue('ShipmentTrackingNumber');end;
procedure Tebay_orders_shipping_ShipUptrack.SetOrderID                                 (const Value: Integer    ); begin SetFieldValue('OrderID'                                  , Value);end;
procedure Tebay_orders_shipping_ShipUptrack.SetOrders_Shipping_Id                      (const Value: Integer   ); begin SetFieldValue('Orders_Shipping_Id'                       , Value);end;
procedure Tebay_orders_shipping_ShipUptrack.SetShippingCarrierUsed                     (const Value: string    ); begin SetFieldValue('ShippingCarrierUsed'                      , Value);end;
procedure Tebay_orders_shipping_ShipUptrack.SetShipmentTrackingNumber                  (const Value: string    ); begin SetFieldValue('ShipmentTrackingNumber'                   , Value);end;


initialization
  RegisterClass(Tebay_orders_shipping_ShipUptrack);


end.
