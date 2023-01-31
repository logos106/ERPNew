unit eBay_Orders_ShippingDetails_ShipServ;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes, eBayBaseObj ;


type
  Tebay_orders_shipping_shipservc = class(TeBayObjBase)
  private
    function GetOrderID                                     : Integer   ;
    function GetOrders_Shipping_Id                          : Integer   ;
    function GetShippingService                             : string    ;
    function GetShippingServicePriority                     : Integer   ;
    function GetExpeditedService                            : Boolean;
    function GetShippingTimeMin                             : Integer   ;
    function GetShippingTimeMax                             : Integer   ;
    function GetFreeShipping                                : Boolean   ;
    function GetLocalPickup                                 : Boolean   ;
    function getShippingInsuranceCostamt                    : double;
    function getShippingSurchargeamt                        : double;
    function getImportChargeamt                             : double;
    function getShippingServiceCostamt                  : double;
    function getShippingServiceAdditionalCostamt            : double;
    function getShippingInsuranceCostCurcode:String;
    function getShippingServiceAdditionalCostCurcode:String;
    function getShippingServiceCostCurcode:String;
    function getShippingSurchargeCurcode:String;
    function getImportChargeCurcode:String;
    procedure SetOrderID                                     (const Value: Integer    );
    procedure SetOrders_Shipping_Id                          (const Value: Integer   );
    procedure SetShippingService                             (const Value: string    );
    procedure SetShippingServicePriority                     (const Value: Integer   );
    procedure SetExpeditedService                            (const Value: Boolean);
    procedure SetShippingTimeMin                             (const Value: Integer   );
    procedure SetShippingTimeMax                             (const Value: Integer   );
    procedure SetFreeShipping                                (const Value: Boolean   );
    procedure SetLocalPickup                                 (const Value: Boolean   );
    Procedure SetShippingInsuranceCostamt                    (const Value: double);
    Procedure SetShippingSurchargeamt                        (const Value: double);
    Procedure SetImportChargeamt                             (const Value: double);
    Procedure SetShippingServiceCostamt                  (const Value: double);
    Procedure SetShippingServiceAdditionalCostamt            (const Value: double);
    Procedure SetShippingInsuranceCostCurcode(Const Value:string);
    Procedure SetShippingServiceAdditionalCostCurcode(Const Value:string);
    Procedure SetShippingServiceCostCurcode(Const Value:string);
    Procedure SetShippingSurchargeCurcode(Const Value:string);
    Procedure SetImportChargeCurcode(Const Value:string);

  protected
  public
    constructor  Create(AOwner: TComponent);                            override;
  published
    property OrderID                                      :Integer      read GetOrderID                                    write SetOrderID                                 ;
    property Orders_Shipping_Id                           :Integer     read GetOrders_Shipping_Id                         write SetOrders_Shipping_Id                      ;
    property ShippingService                              :string      read GetShippingService                            write SetShippingService                         ;
    property ShippingServicePriority                      :Integer     read GetShippingServicePriority                    write SetShippingServicePriority                 ;
    property ExpeditedService                             :Boolean     read GetExpeditedService                           write SetExpeditedService                        ;
    property ShippingTimeMin                              :Integer     read GetShippingTimeMin                            write SetShippingTimeMin                         ;
    property ShippingTimeMax                              :Integer     read GetShippingTimeMax                            write SetShippingTimeMax                         ;
    property FreeShipping                                 :Boolean     read GetFreeShipping                               write SetFreeShipping                            ;
    property LocalPickup                                  :Boolean     read GetLocalPickup                                write SetLocalPickup                             ;
    Property ShippingInsuranceCostamt                     :double      read getShippingInsuranceCostamt                   write SetShippingInsuranceCostamt;
    Property ShippingSurchargeamt                         :double      read getShippingSurchargeamt                       write SetShippingSurchargeamt;
    Property ImportChargeamt                              :double      read getImportChargeamt                            write SetImportChargeamt;
    Property ShippingServiceCostamt                       :double      read getShippingServiceCostamt                 write SetShippingServiceCostamt;
    Property ShippingServiceAdditionalCostamt             :double      read getShippingServiceAdditionalCostamt           write SetShippingServiceAdditionalCostamt;
    Property ShippingInsuranceCostCurcode                 :String read getShippingInsuranceCostCurcode          Write setShippingInsuranceCostCurcode;
    Property ShippingServiceAdditionalCostCurcode         :String read getShippingServiceAdditionalCostCurcode  Write setShippingServiceAdditionalCostCurcode;
    Property ShippingServiceCostCurcode                   :String read getShippingServiceCostCurcode            Write setShippingServiceCostCurcode;
    Property ShippingSurchargeCurcode                     :String read getShippingSurchargeCurcode              Write setShippingSurchargeCurcode;
    Property ImportChargeCurcode                          :String read getImportChargeCurcode                   Write setImportChargeCurcode;
  end;


implementation

uses Sysutils;





  {Tebay_orders_shipping_shipservc}

constructor Tebay_orders_shipping_shipservc.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tablename :='tblebay_orders_shipping_shipservc';
end;


{Property Functions}
function  Tebay_orders_shipping_shipservc.GetOrderID                                 : Integer   ; begin Result := GetFieldValue('OrderID');end;
function  Tebay_orders_shipping_shipservc.GetOrders_Shipping_Id                      : Integer   ; begin Result := GetFieldValue('Orders_Shipping_Id');end;
function  Tebay_orders_shipping_shipservc.GetShippingService                         : string    ; begin Result := GetFieldValue('ShippingService');end;
function  Tebay_orders_shipping_shipservc.GetShippingServicePriority                 : Integer   ; begin Result := GetFieldValue('ShippingServicePriority');end;
function  Tebay_orders_shipping_shipservc.GetExpeditedService                        : Boolean   ; begin Result := GetFieldValue('ExpeditedService');end;
function  Tebay_orders_shipping_shipservc.GetShippingTimeMin                         : Integer   ; begin Result := GetFieldValue('ShippingTimeMin');end;
function  Tebay_orders_shipping_shipservc.GetShippingTimeMax                         : Integer   ; begin Result := GetFieldValue('ShippingTimeMax');end;
function  Tebay_orders_shipping_shipservc.GetFreeShipping                            : Boolean   ; begin Result := GetFieldValue('FreeShipping');end;
function  Tebay_orders_shipping_shipservc.GetLocalPickup                             : Boolean   ; begin Result := GetFieldValue('LocalPickup');end;
function  Tebay_orders_shipping_shipservc.getShippingInsuranceCostamt                : double    ; begin result := GetFieldValue('ShippingInsuranceCostamt');end;
function  Tebay_orders_shipping_shipservc.getShippingSurchargeamt                    : double    ; begin result := GetFieldValue('ShippingSurchargeamt');end;
function  Tebay_orders_shipping_shipservc.getImportChargeamt                         : double    ; begin result := GetFieldValue('ImportChargeamt');end;
function  Tebay_orders_shipping_shipservc.getShippingServiceCostamt              : double    ; begin result := GetFieldValue('ShippingServiceCostamt');end;
function  Tebay_orders_shipping_shipservc.getShippingServiceAdditionalCostamt        : double    ; begin result := GetFieldValue('ShippingServiceAdditionalCostamt');end;
function  Tebay_orders_shipping_shipservc.getShippingInsuranceCostCurcode            : String    ; begin getFieldValue('ShippingInsuranceCostCurcode');end;
function  Tebay_orders_shipping_shipservc.getShippingServiceAdditionalCostCurcode    : String    ; begin getFieldValue('ShippingServiceAdditionalCostCurcode');end;
function  Tebay_orders_shipping_shipservc.getShippingServiceCostCurcode          : String    ; begin getFieldValue('ShippingServiceCostCurcode');end;
function  Tebay_orders_shipping_shipservc.getShippingSurchargeCurcode                : String    ; begin getFieldValue('ShippingSurchargeCurcode');end;
function  Tebay_orders_shipping_shipservc.getImportChargeCurcode                     : String    ; begin getFieldValue('ImportChargeCurcode');end;
procedure Tebay_orders_shipping_shipservc.SetOrderID                                 (const Value: Integer    ); begin SetFieldValue('OrderID'                                  , Value);end;
procedure Tebay_orders_shipping_shipservc.SetOrders_Shipping_Id                      (const Value: Integer   ); begin SetFieldValue('Orders_Shipping_Id'                       , Value);end;
procedure Tebay_orders_shipping_shipservc.SetShippingService                         (const Value: string    ); begin SetFieldValue('ShippingService'                          , Value);end;
procedure Tebay_orders_shipping_shipservc.SetShippingServicePriority                 (const Value: Integer   ); begin SetFieldValue('ShippingServicePriority'                  , Value);end;
procedure Tebay_orders_shipping_shipservc.SetExpeditedService                        (const Value: Boolean   ); begin SetFieldValue('ExpeditedService'                         , Value);end;
procedure Tebay_orders_shipping_shipservc.SetShippingTimeMin                         (const Value: Integer   ); begin SetFieldValue('ShippingTimeMin'                          , Value);end;
procedure Tebay_orders_shipping_shipservc.SetShippingTimeMax                         (const Value: Integer   ); begin SetFieldValue('ShippingTimeMax'                          , Value);end;
procedure Tebay_orders_shipping_shipservc.SetFreeShipping                            (const Value: Boolean   ); begin SetFieldValue('FreeShipping'                             , Value);end;
procedure Tebay_orders_shipping_shipservc.SetLocalPickup                             (const Value: Boolean   ); begin SetFieldValue('LocalPickup'                              , Value);end;
Procedure Tebay_orders_shipping_shipservc.SetShippingInsuranceCostamt                (Const Value: Double    ); begin SetFieldValue('ShippingInsuranceCostamt'                 , Value);end;
Procedure Tebay_orders_shipping_shipservc.SetShippingSurchargeamt                    (Const Value: Double    ); begin SetFieldValue('ShippingSurchargeamt'                     , Value);end;
Procedure Tebay_orders_shipping_shipservc.SetImportChargeamt                         (Const Value: Double    ); begin SetFieldValue('ImportChargeamt'                          , Value);end;
Procedure Tebay_orders_shipping_shipservc.SetShippingServiceCostamt              (Const Value: Double    ); begin SetFieldValue('ShippingServiceCostamt'               , Value);end;
Procedure Tebay_orders_shipping_shipservc.SetShippingServiceAdditionalCostamt        (Const Value: Double    ); begin SetFieldValue('ShippingServiceAdditionalCostamt'         , Value);end;
Procedure Tebay_orders_shipping_shipservc.SetShippingInsuranceCostCurcode            (Const Value:string); begin SetFieldValue('ShippingInsuranceCostCurcode', Value); end;
Procedure Tebay_orders_shipping_shipservc.SetShippingServiceAdditionalCostCurcode    (Const Value:string);begin SetFieldValue('ShippingServiceAdditionalCostCurcode', Value); end;
Procedure Tebay_orders_shipping_shipservc.SetShippingServiceCostCurcode          (Const Value:string);begin SetFieldValue('ShippingServiceCostCurcode', Value); end;
Procedure Tebay_orders_shipping_shipservc.SetShippingSurchargeCurcode                (Const Value:string);begin SetFieldValue('ShippingSurchargeCurcode', Value); end;
Procedure Tebay_orders_shipping_shipservc.SetImportChargeCurcode                     (Const Value:string);begin SetFieldValue('ImportChargeCurcode', Value); end;

initialization
  RegisterClass(Tebay_orders_shipping_shipservc);


end.
