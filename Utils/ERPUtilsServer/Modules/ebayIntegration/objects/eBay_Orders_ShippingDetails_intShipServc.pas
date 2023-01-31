unit eBay_Orders_ShippingDetails_intShipServc;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes, eBayBaseObj , eBay_Orders_ShippingDetails_intShipServc_shiptoLoc;


type
  Tebay_orders_shipping_intshipservc = class(TeBayObjBase)
  private
    fShipToLoc : Tebay_orders_shipping_intshipservc_shiptoloc;
    function GetOrderID                                     : Integer   ;
    function GetOrders_Shipping_Id                          : Integer   ;
    function GetShippingService                             : string    ;
    function GetShippingServicePriority                     : Integer   ;
    function getShippingServiceCost                        :Double;
    function getShippingServiceAdditionalCost              :Double;
    function getShippingInsuranceCost                      :Double;
    function getImportCharge                               :double;
    function getShippingServiceCostcurcode                 :String;
    function getShippingServiceAdditionalCostcurcode       :String;
    function getShippingInsuranceCostcurcode               :String;
    function getImportChargecurcode                        :String;
    procedure setShippingServiceCost(const Value: Double  );
    procedure setShippingServiceAdditionalCost(const Value: Double  );
    procedure setShippingInsuranceCost(const Value: Double  );
    procedure setImportCharge(const Value: Double  );
    procedure setShippingServiceCostcurcode(const Value: String );
    procedure setShippingServiceAdditionalCostcurcode(const Value: String );
    procedure setShippingInsuranceCostcurcode(const Value: String );
    procedure setImportChargecurcode(const Value: String );
    procedure SetOrderID                                     (const Value: Integer    );
    procedure SetOrders_Shipping_Id                          (const Value: Integer   );
    procedure SetShippingService                             (const Value: string    );
    procedure SetShippingServicePriority                     (const Value: Integer   );
    function  getShiptoLoc :Tebay_orders_shipping_intshipservc_shiptoloc;
  protected
  public
    constructor  Create(AOwner: TComponent);                            override;
    Property ShipToLoc :Tebay_orders_shipping_intshipservc_shiptoloc Read getshipToLoc;
  published
    property OrderID                                      :Integer      read GetOrderID                                    write SetOrderID                                 ;
    property Orders_Shipping_Id                           :Integer     read GetOrders_Shipping_Id                         write SetOrders_Shipping_Id                      ;
    property ShippingService                              :string      read GetShippingService                            write SetShippingService                         ;
    property ShippingServicePriority                      :Integer     read GetShippingServicePriority                    write SetShippingServicePriority                 ;
    property ShippingServiceCost                          :double      read getShippingServiceCost                        write setShippingServiceCost;
    property ShippingServiceAdditionalCost                :double     read getShippingServiceAdditionalCost               write setShippingServiceAdditionalCost;
    property ShippingInsuranceCost                        :double     read getShippingInsuranceCost                       write setShippingInsuranceCost;
    property ImportCharge                                 :double     read getImportCharge                                write setImportCharge;
    property ShippingServiceCostcurcode                   :String      read getShippingServiceCostcurcode                 write setShippingServiceCostcurcode;
    property ShippingServiceAdditionalCostcurcode         :String     read getShippingServiceAdditionalCostcurcode        write setShippingServiceAdditionalCostcurcode;
    property ShippingInsuranceCostcurcode                 :String     read getShippingInsuranceCostcurcode                write setShippingInsuranceCostcurcode;
    property ImportChargecurcode                          :String     read getImportChargecurcode                         write setImportChargecurcode;

  end;


implementation

uses Sysutils;


  {Tebay_orders_shipping_intshipservc}

constructor Tebay_orders_shipping_intshipservc.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tablename := 'tblebay_orders_shipping_intshipservc';
end;

{Property Functions}
function  Tebay_orders_shipping_intshipservc.GetOrderID                                 : Integer   ; begin Result := GEtFieldValue('OrderID');end;
function  Tebay_orders_shipping_intshipservc.GetOrders_Shipping_Id                      : Integer   ; begin Result := GEtFieldValue('Orders_Shipping_Id');end;
Function Tebay_orders_shipping_intshipservc.getShippingServiceCost                        :Double;begin Result := GEtFieldValue('ShippingServiceCost');end;
Function Tebay_orders_shipping_intshipservc.getShippingServiceAdditionalCost              :Double;begin Result := GEtFieldValue('ShippingServiceAdditionalCost');end;
Function Tebay_orders_shipping_intshipservc.getShippingInsuranceCost                      :Double;begin Result := GEtFieldValue('ShippingInsuranceCost');end;
Function Tebay_orders_shipping_intshipservc.getImportCharge                               :double;begin Result := GEtFieldValue('ImportCharge');end;
Function Tebay_orders_shipping_intshipservc.getShippingServiceCostcurcode                 :String;begin Result := GEtFieldValue('ShippingServiceCostcurcode');end;
Function Tebay_orders_shipping_intshipservc.getShippingServiceAdditionalCostcurcode       :String;begin Result := GEtFieldValue('ShippingServiceAdditionalCostcurcode');end;
Function Tebay_orders_shipping_intshipservc.getShippingInsuranceCostcurcode               :String;begin Result := GEtFieldValue('ShippingInsuranceCostcurcode');end;
Function Tebay_orders_shipping_intshipservc.getImportChargecurcode                        :String;begin Result := GEtFieldValue('ImportChargecurcode');end;
Procedure Tebay_orders_shipping_intshipservc.setShippingServiceCost                 (const Value: Double  ); begin SEtFieldValue('ShippingServiceCost',value ); end;
Procedure Tebay_orders_shipping_intshipservc.setShippingServiceAdditionalCost       (const Value: Double  );begin SEtFieldValue('ShippingServiceAdditionalCost',value ); end;
Procedure Tebay_orders_shipping_intshipservc.setShippingInsuranceCost               (const Value: Double  );begin SEtFieldValue('ShippingInsuranceCost',value ); end;
Procedure Tebay_orders_shipping_intshipservc.setImportCharge                        (const Value: Double  );begin SEtFieldValue('ImportCharge',value ); end;
Procedure Tebay_orders_shipping_intshipservc.setShippingServiceCostcurcode          (const Value: String );begin SEtFieldValue('ShippingServiceCostcurcode' , Value);end;
Procedure Tebay_orders_shipping_intshipservc.setShippingServiceAdditionalCostcurcode(const Value: String );begin SEtFieldValue('ShippingServiceAdditionalCostcurcode' , Value);end;
Procedure Tebay_orders_shipping_intshipservc.setShippingInsuranceCostcurcode        (const Value: String );begin SEtFieldValue('ShippingInsuranceCostcurcode' , Value);end;
Procedure Tebay_orders_shipping_intshipservc.setImportChargecurcode                 (const Value: String );begin SEtFieldValue('ImportChargecurcode' , Value);end;
function  Tebay_orders_shipping_intshipservc.GetShippingService                         : string    ; begin Result := GEtFieldValue('ShippingService');end;
function  Tebay_orders_shipping_intshipservc.GetShippingServicePriority                 : Integer   ; begin Result := GEtFieldValue('ShippingServicePriority');end;
procedure Tebay_orders_shipping_intshipservc.SetOrderID                                 (const Value: Integer    ); begin SEtFieldValue('OrderID'                                  , Value);end;
procedure Tebay_orders_shipping_intshipservc.SetOrders_Shipping_Id                      (const Value: Integer   ); begin SEtFieldValue('Orders_Shipping_Id'                       , Value);end;
procedure Tebay_orders_shipping_intshipservc.SetShippingService                         (const Value: string    ); begin SEtFieldValue('ShippingService'                          , Value);end;
procedure Tebay_orders_shipping_intshipservc.SetShippingServicePriority                 (const Value: Integer   ); begin SEtFieldValue('ShippingServicePriority'                  , Value);end;

function Tebay_orders_shipping_intshipservc.getShiptoLoc: Tebay_orders_shipping_intshipservc_shiptoloc;
begin
  if (fShipToLoc = nil) then begin
    fShipToLoc:= Tebay_orders_shipping_intshipservc_shiptoloc.Create(self, 'tblebay_orders_shipping_intshipservc_shiptoloc',
                            'Orders_Shipping_intServ_Id =' + inttostr(ID)+' and Orders_Shipping_Id =' + inttostr(Orders_Shipping_Id) +' and OrderID = ' +inttostr(OrderID));
  end;
  fShipToLoc.SQLWhere := 'Orders_Shipping_intServ_Id =' + inttostr(ID)+' and Orders_Shipping_Id =' + inttostr(Orders_Shipping_Id) +' and OrderID = ' +inttostr(OrderID);
  fShipToLoc.Dataset;
  result:= fShipToLoc;
end;


initialization
  RegisterClass(Tebay_orders_shipping_intshipservc);


end.
