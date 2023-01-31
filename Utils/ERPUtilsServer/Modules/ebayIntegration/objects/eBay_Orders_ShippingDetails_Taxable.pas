unit eBay_Orders_ShippingDetails_Taxable;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes, eBayBaseObj;


type
  Tebay_orders_shipping_Taxable = class(TeBayObjBase)
  private
    function GetOrderID                                     : Integer   ;
    function GetOrders_Shipping_Id                          : Integer   ;
    function GetJurisdictionID                              : string    ;
    function GetSalesTaxPercent                             : Double    ;
    function GetShippingIncludedInTax                       : Boolean   ;
    function GetJurisdictionName                            : string    ;
    function GetDetailVersion                               : string    ;
    procedure SetOrderID                                     (const Value: Integer    );
    procedure SetOrders_Shipping_Id                          (const Value: Integer   );
    procedure SetJurisdictionID                              (const Value: string    );
    procedure SetSalesTaxPercent                             (const Value: Double    );
    procedure SetShippingIncludedInTax                       (const Value: Boolean   );
    procedure SetJurisdictionName                            (const Value: string    );
    procedure SetDetailVersion                               (const Value: string    );
  protected
  public
    constructor  Create(AOwner: TComponent);                            override;
  published
    property OrderID                                      :Integer      read GetOrderID                                    write SetOrderID                                 ;
    property Orders_Shipping_Id                           :Integer     read GetOrders_Shipping_Id                         write SetOrders_Shipping_Id                      ;
    property JurisdictionID                               :string      read GetJurisdictionID                             write SetJurisdictionID                          ;
    property SalesTaxPercent                              :Double      read GetSalesTaxPercent                            write SetSalesTaxPercent                         ;
    property ShippingIncludedInTax                        :Boolean     read GetShippingIncludedInTax                      write SetShippingIncludedInTax                   ;
    property JurisdictionName                             :string      read GetJurisdictionName                           write SetJurisdictionName                        ;
    property DetailVersion                                :string      read GetDetailVersion                              write SetDetailVersion                           ;
  end;


implementation

 {Tebay_orders_shipping_Taxable}

constructor Tebay_orders_shipping_Taxable.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tablename := 'tblebay_orders_shipping_taxtable';
end;

{Property Functions}
function  Tebay_orders_shipping_Taxable.GetOrderID                                 : Integer   ; begin Result := GetFieldValue('OrderID');end;
function  Tebay_orders_shipping_Taxable.GetOrders_Shipping_Id                      : Integer   ; begin Result := GetFieldValue('Orders_Shipping_Id');end;
function  Tebay_orders_shipping_Taxable.GetJurisdictionID                          : string    ; begin Result := GetFieldValue('JurisdictionID');end;
function  Tebay_orders_shipping_Taxable.GetSalesTaxPercent                         : Double    ; begin Result := GetFieldValue('SalesTaxPercent');end;
function  Tebay_orders_shipping_Taxable.GetShippingIncludedInTax                   : Boolean   ; begin Result := GetFieldValue('ShippingIncludedInTax');end;
function  Tebay_orders_shipping_Taxable.GetJurisdictionName                        : string    ; begin Result := GetFieldValue('JurisdictionName');end;
function  Tebay_orders_shipping_Taxable.GetDetailVersion                           : string    ; begin Result := GetFieldValue('DetailVersion');end;
procedure Tebay_orders_shipping_Taxable.SetOrderID                                 (const Value: Integer    ); begin SetFieldValue('OrderID'                                  , Value);end;
procedure Tebay_orders_shipping_Taxable.SetOrders_Shipping_Id                      (const Value: Integer   ); begin SetFieldValue('Orders_Shipping_Id'                       , Value);end;
procedure Tebay_orders_shipping_Taxable.SetJurisdictionID                          (const Value: string    ); begin SetFieldValue('JurisdictionID'                           , Value);end;
procedure Tebay_orders_shipping_Taxable.SetSalesTaxPercent                         (const Value: Double    ); begin SetFieldValue('SalesTaxPercent'                          , Value);end;
procedure Tebay_orders_shipping_Taxable.SetShippingIncludedInTax                   (const Value: Boolean   ); begin SetFieldValue('ShippingIncludedInTax'                    , Value);end;
procedure Tebay_orders_shipping_Taxable.SetJurisdictionName                        (const Value: string    ); begin SetFieldValue('JurisdictionName'                         , Value);end;
procedure Tebay_orders_shipping_Taxable.SetDetailVersion                           (const Value: string    ); begin SetFieldValue('DetailVersion'                            , Value);end;


initialization
  RegisterClass(Tebay_orders_shipping_Taxable);


end.
