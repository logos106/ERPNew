unit eBay_Orders_ShippingDetails_ShipupTrack_Shipline;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes, eBayBaseObj;


type
  Tebay_orders_shipping_ShipUptrack_shipline = class(TeBayObjBase)
  private
    function GetOrderID                                     : Integer   ;
    function GetOrders_Shipping_Id                          : Integer   ;
    function GetOrders_Shipping_ShiupTrack_Id               : Integer   ;
    function GetQuantity                                    : Integer   ;
    function GetCountryOfOrigin                             : string    ;
    function GetDescription                                 : string    ;
    function GetItemID                                      : string    ;
    function GetTransactionID                               : string    ;
    procedure SetOrderID                                     (const Value: Integer    );
    procedure SetOrders_Shipping_Id                          (const Value: Integer   );
    procedure SetOrders_Shipping_ShiupTrack_Id               (const Value: Integer   );
    procedure SetQuantity                                    (const Value: Integer   );
    procedure SetCountryOfOrigin                             (const Value: string    );
    procedure SetDescription                                 (const Value: string    );
    procedure SetItemID                                      (const Value: string    );
    procedure SetTransactionID                               (const Value: string    );
  protected
  public
    constructor  Create(AOwner: TComponent);                            override;
  published
    property OrderID                                      :Integer      read GetOrderID                                    write SetOrderID                                 ;
    property Orders_Shipping_Id                           :Integer     read GetOrders_Shipping_Id                         write SetOrders_Shipping_Id                      ;
    property Orders_Shipping_ShiupTrack_Id                :Integer     read GetOrders_Shipping_ShiupTrack_Id              write SetOrders_Shipping_ShiupTrack_Id           ;
    property Quantity                                     :Integer     read GetQuantity                                   write SetQuantity                                ;
    property CountryOfOrigin                              :string      read GetCountryOfOrigin                            write SetCountryOfOrigin                         ;
    property Description                                  :string      read GetDescription                                write SetDescription                             ;
    property ItemID                                       :string      read GetItemID                                     write SetItemID                                  ;
    property TransactionID                                :string      read GetTransactionID                              write SetTransactionID                           ;
  end;


implementation


  {Tebay_orders_shipping_ShipUptrack_shipline}

constructor Tebay_orders_shipping_ShipUptrack_shipline.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tablename := 'tblebay_orders_shipping_shiuptrack_shipline';
end;

{Property Functions}
function  Tebay_orders_shipping_ShipUptrack_shipline.GetOrderID                                 : Integer   ; begin Result := GetFieldValue('OrderID');end;
function  Tebay_orders_shipping_ShipUptrack_shipline.GetOrders_Shipping_Id                      : Integer   ; begin Result := GetFieldValue('Orders_Shipping_Id');end;
function  Tebay_orders_shipping_ShipUptrack_shipline.GetOrders_Shipping_ShiupTrack_Id           : Integer   ; begin Result := GetFieldValue('Orders_Shipping_ShiupTrack_Id');end;
function  Tebay_orders_shipping_ShipUptrack_shipline.GetQuantity                                : Integer   ; begin Result := GetFieldValue('Quantity');end;
function  Tebay_orders_shipping_ShipUptrack_shipline.GetCountryOfOrigin                         : string    ; begin Result := GetFieldValue('CountryOfOrigin');end;
function  Tebay_orders_shipping_ShipUptrack_shipline.GetDescription                             : string    ; begin Result := GetFieldValue('Description');end;
function  Tebay_orders_shipping_ShipUptrack_shipline.GetItemID                                  : string    ; begin Result := GetFieldValue('ItemID');end;
function  Tebay_orders_shipping_ShipUptrack_shipline.GetTransactionID                           : string    ; begin Result := GetFieldValue('TransactionID');end;
procedure Tebay_orders_shipping_ShipUptrack_shipline.SetOrderID                                 (const Value: Integer    ); begin SetFieldValue('OrderID'                                  , Value);end;
procedure Tebay_orders_shipping_ShipUptrack_shipline.SetOrders_Shipping_Id                      (const Value: Integer   ); begin SetFieldValue('Orders_Shipping_Id'                       , Value);end;
procedure Tebay_orders_shipping_ShipUptrack_shipline.SetOrders_Shipping_ShiupTrack_Id           (const Value: Integer   ); begin SetFieldValue('Orders_Shipping_ShiupTrack_Id'            , Value);end;
procedure Tebay_orders_shipping_ShipUptrack_shipline.SetQuantity                                (const Value: Integer   ); begin SetFieldValue('Quantity'                                 , Value);end;
procedure Tebay_orders_shipping_ShipUptrack_shipline.SetCountryOfOrigin                         (const Value: string    ); begin SetFieldValue('CountryOfOrigin'                          , Value);end;
procedure Tebay_orders_shipping_ShipUptrack_shipline.SetDescription                             (const Value: string    ); begin SetFieldValue('Description'                              , Value);end;
procedure Tebay_orders_shipping_ShipUptrack_shipline.SetItemID                                  (const Value: string    ); begin SetFieldValue('ItemID'                                   , Value);end;
procedure Tebay_orders_shipping_ShipUptrack_shipline.SetTransactionID                           (const Value: string    ); begin SetFieldValue('TransactionID'                            , Value);end;


initialization
  RegisterClass(Tebay_orders_shipping_ShipUptrack_shipline);


end.
