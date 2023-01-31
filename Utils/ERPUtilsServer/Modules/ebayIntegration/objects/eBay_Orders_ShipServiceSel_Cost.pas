unit eBay_Orders_ShipServiceSel_Cost;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes,  eBayBaseObj ;


type
  Tebay_orders_shipservcsel_shipservccost = class(TeBayObjBase)
  private
    function GetOrderID                                     : Integer   ;
    function GetOrders_ShipServcSel_Id                      : Integer   ;
    function GetText                                        : Double    ;
    function GetcurrencyID                                  : string    ;
    procedure SetOrderID                                     (const Value: Integer    );
    procedure SetOrders_ShipServcSel_Id                      (const Value: Integer   );
    procedure SetText                                        (const Value: Double    );
    procedure SetcurrencyID                                  (const Value: string    );
  protected
  public
    constructor  Create(AOwner: TComponent);                            override;
  published
    property OrderID                                      :Integer      read GetOrderID                                    write SetOrderID                                 ;
    property Orders_ShipServcSel_Id                       :Integer     read GetOrders_ShipServcSel_Id                     write SetOrders_ShipServcSel_Id                  ;
    property Text                                         :Double      read GetText                                       write SetText                                    ;
    property currencyID                                   :string      read GetcurrencyID                                 write SetcurrencyID                              ;
  end;


implementation


 {Tebay_orders_shipservcsel_shipservccost}

constructor Tebay_orders_shipservcsel_shipservccost.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tablename := 'tblebay_orders_shipservcsel_shipservccost';
end;

{Property Functions}
function  Tebay_orders_shipservcsel_shipservccost.GetOrderID                                 : Integer   ; begin Result := GetfieldValue('OrderID');end;
function  Tebay_orders_shipservcsel_shipservccost.GetOrders_ShipServcSel_Id                  : Integer   ; begin Result := GetfieldValue('Orders_ShipServcSel_Id');end;
function  Tebay_orders_shipservcsel_shipservccost.GetText                                    : Double    ; begin Result := GetfieldValue('Text');end;
function  Tebay_orders_shipservcsel_shipservccost.GetcurrencyID                              : string    ; begin Result := GetfieldValue('currencyID');end;
procedure Tebay_orders_shipservcsel_shipservccost.SetOrderID                                 (const Value: Integer    ); begin SetfieldValue('OrderID'                                  , Value);end;
procedure Tebay_orders_shipservcsel_shipservccost.SetOrders_ShipServcSel_Id                  (const Value: Integer   ); begin SetfieldValue('Orders_ShipServcSel_Id'                   , Value);end;
procedure Tebay_orders_shipservcsel_shipservccost.SetText                                    (const Value: Double    ); begin SetfieldValue('Text'                                     , Value);end;
procedure Tebay_orders_shipservcsel_shipservccost.SetcurrencyID                              (const Value: string    ); begin SetfieldValue('currencyID'                               , Value);end;


initialization
  RegisterClass(Tebay_orders_shipservcsel_shipservccost);


end.
