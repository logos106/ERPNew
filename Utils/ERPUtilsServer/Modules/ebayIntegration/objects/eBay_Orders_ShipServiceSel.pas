unit eBay_Orders_ShipServiceSel;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes,  eBayBaseObj ,eBay_Orders_ShipServiceSel_Cost;


type
  Tebay_orders_shipservcsel = class(TeBayObjBase)
  private
    fShipServiceCost:Tebay_orders_shipservcsel_shipservccost;
    function GetOrderID                                     : Integer   ;
    function GetShippingService                             : string    ;
    function GetShippingServicePriority                     : Integer   ;
    function GetExpeditedService                            : Boolean   ;
    function GetShippingTimeMin                             : Integer   ;
    function GetShippingTimeMax                             : Integer   ;
    function GetFreeShipping                                : Boolean   ;
    function GetLocalPickup                                 : Boolean   ;
    function getShippingServiceCost                        :Double;
    function getShippingServiceAdditionalCost              :Double;
    function getShippingInsuranceCost                      :Double;
    function getImportCharge                               :double;
    function getShippingSurcharge                          :double;
    function getShippingServiceCostcurcode                 :String;
    function getShippingServiceAdditionalCostcurcode       :String;
    function getShippingInsuranceCostcurcode               :String;
    function getImportChargecurcode                        :String;
    function getShippingSurchargecurcode                   :String;
    procedure SetOrderID                                     (const Value: Integer    );
    procedure SetShippingService                             (const Value: string    );
    procedure SetShippingServicePriority                     (const Value: Integer   );
    procedure SetExpeditedService                            (const Value: Boolean   );
    procedure SetShippingTimeMin                             (const Value: Integer   );
    procedure SetShippingTimeMax                             (const Value: Integer   );
    procedure SetFreeShipping                                (const Value: Boolean   );
    procedure SetLocalPickup                                 (const Value: Boolean   );
    procedure setShippingServiceCost(const Value: Double  );
    procedure setShippingServiceAdditionalCost(const Value: Double  );
    procedure setShippingInsuranceCost(const Value: Double  );
    procedure setImportCharge(const Value: Double  );
    procedure setShippingSurcharge(const Value: Double  );
    procedure setShippingServiceCostcurcode(const Value: String );
    procedure setShippingServiceAdditionalCostcurcode(const Value: String );
    procedure setShippingInsuranceCostcurcode(const Value: String );
    procedure setImportChargecurcode(const Value: String );
    procedure setShippingSurchargecurcode(const Value: String );
    Function getShipServicecost:Tebay_orders_shipservcsel_shipservccost;
  protected
  public
    constructor  Create(AOwner: TComponent);                            override;
  published
    property OrderID                                      :Integer      read GetOrderID                                    write SetOrderID                                 ;
    property ShippingService                              :string      read GetShippingService                            write SetShippingService                         ;
    property ShippingServicePriority                      :Integer     read GetShippingServicePriority                    write SetShippingServicePriority                 ;
    property ExpeditedService                             :Boolean     read GetExpeditedService                           write SetExpeditedService                        ;
    property ShippingTimeMin                              :Integer     read GetShippingTimeMin                            write SetShippingTimeMin                         ;
    property ShippingTimeMax                              :Integer     read GetShippingTimeMax                            write SetShippingTimeMax                         ;
    property FreeShipping                                 :Boolean     read GetFreeShipping                               write SetFreeShipping                            ;
    property LocalPickup                                  :Boolean     read GetLocalPickup                                write SetLocalPickup                             ;

    property ShippingServiceCost                          :double      read getShippingServiceCost                        write setShippingServiceCost;
    property ShippingServiceAdditionalCost                :double     read getShippingServiceAdditionalCost               write setShippingServiceAdditionalCost;
    property ShippingInsuranceCost                        :double     read getShippingInsuranceCost                       write setShippingInsuranceCost;
    property ImportCharge                                 :double     read getImportCharge                                write setImportCharge;
    property ShippingSurcharge                            :double     read getShippingSurcharge                           write setShippingSurcharge;
    property ShippingServiceCostcurcode                   :String      read getShippingServiceCostcurcode                 write setShippingServiceCostcurcode;
    property ShippingServiceAdditionalCostcurcode         :String     read getShippingServiceAdditionalCostcurcode        write setShippingServiceAdditionalCostcurcode;
    property ShippingInsuranceCostcurcode                 :String     read getShippingInsuranceCostcurcode                write setShippingInsuranceCostcurcode;
    property ImportChargecurcode                          :String     read getImportChargecurcode                         write setImportChargecurcode;
    property ShippingSurchargecurcode                     :String     read getShippingSurchargecurcode                    write setShippingSurchargecurcode;
    Property ShipServicecost : Tebay_orders_shipservcsel_shipservccost Read getShipServiceCost;
  end;


implementation

uses sysutils;



  {Tebay_orders_shipservcsel}

constructor Tebay_orders_shipservcsel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tablename := 'tblebay_orders_shipservcsel';
end;

{Property Functions}
function  Tebay_orders_shipservcsel.GetOrderID                             : Integer   ; begin Result := GetFieldValue('OrderID');end;
function  Tebay_orders_shipservcsel.GetShippingService                     : string    ; begin Result := GetFieldValue('ShippingService');end;
function  Tebay_orders_shipservcsel.GetShippingServicePriority             : Integer   ; begin Result := GetFieldValue('ShippingServicePriority');end;
function  Tebay_orders_shipservcsel.GetExpeditedService                    : Boolean   ; begin Result := GetFieldValue('ExpeditedService');end;
function  Tebay_orders_shipservcsel.GetShippingTimeMin                     : Integer   ; begin Result := GetFieldValue('ShippingTimeMin');end;
function  Tebay_orders_shipservcsel.GetShippingTimeMax                     : Integer   ; begin Result := GetFieldValue('ShippingTimeMax');end;
function  Tebay_orders_shipservcsel.GetFreeShipping                        : Boolean   ; begin Result := GetFieldValue('FreeShipping');end;
function  Tebay_orders_shipservcsel.GetLocalPickup                         : Boolean   ; begin Result := GetFieldValue('LocalPickup');end;
Function Tebay_orders_shipservcsel.getShippingServiceCost                  : Double    ; begin Result := GEtFieldValue('ShippingServiceCost');end;
Function Tebay_orders_shipservcsel.getShippingServiceAdditionalCost        : Double    ; begin Result := GEtFieldValue('ShippingServiceAdditionalCost');end;
Function Tebay_orders_shipservcsel.getShippingInsuranceCost                : Double    ; begin Result := GEtFieldValue('ShippingInsuranceCost');end;
Function Tebay_orders_shipservcsel.getImportCharge                         : double    ; begin Result := GEtFieldValue('ImportCharge');end;
Function Tebay_orders_shipservcsel.getShippingSurcharge                    : double    ; begin Result := GEtFieldValue('ShippingSurcharge');end;
Function Tebay_orders_shipservcsel.getShippingServiceCostcurcode           : String    ; begin Result := GEtFieldValue('ShippingServiceCostcurcode');end;
Function Tebay_orders_shipservcsel.getShippingServiceAdditionalCostcurcode : String    ; begin Result := GEtFieldValue('ShippingServiceAdditionalCostcurcode');end;
Function Tebay_orders_shipservcsel.getShippingInsuranceCostcurcode         : String    ; begin Result := GEtFieldValue('ShippingInsuranceCostcurcode');end;
Function Tebay_orders_shipservcsel.getImportChargecurcode                  : String    ; begin Result := GEtFieldValue('ImportChargecurcode');end;
Function Tebay_orders_shipservcsel.getShippingSurchargecurcode             : String    ; begin Result := GEtFieldValue('ShippingSurchargecurcode');end;
procedure Tebay_orders_shipservcsel.SetOrderID                             (const Value: Integer    ); begin SetFieldValue('OrderID'               , Value);end;
procedure Tebay_orders_shipservcsel.SetShippingService                     (const Value: string    ); begin SetFieldValue('ShippingService'        , Value);end;
procedure Tebay_orders_shipservcsel.SetShippingServicePriority             (const Value: Integer   ); begin SetFieldValue('ShippingServicePriority', Value);end;
procedure Tebay_orders_shipservcsel.SetExpeditedService                    (const Value: Boolean   ); begin SetFieldValue('ExpeditedService'       , Value);end;
procedure Tebay_orders_shipservcsel.SetShippingTimeMin                     (const Value: Integer   ); begin SetFieldValue('ShippingTimeMin'        , Value);end;
procedure Tebay_orders_shipservcsel.SetShippingTimeMax                     (const Value: Integer   ); begin SetFieldValue('ShippingTimeMax'        , Value);end;
procedure Tebay_orders_shipservcsel.SetFreeShipping                        (const Value: Boolean   ); begin SetFieldValue('FreeShipping'           , Value);end;
procedure Tebay_orders_shipservcsel.SetLocalPickup                         (const Value: Boolean   ); begin SetFieldValue('LocalPickup'            , Value);end;
Procedure Tebay_orders_shipservcsel.setShippingServiceCost                 (const Value: Double  ); begin SEtFieldValue('ShippingServiceCost'       ,value ); end;
Procedure Tebay_orders_shipservcsel.setShippingServiceAdditionalCost       (const Value: Double  );begin SEtFieldValue('ShippingServiceAdditionalCost',value ); end;
Procedure Tebay_orders_shipservcsel.setShippingInsuranceCost               (const Value: Double  );begin SEtFieldValue('ShippingInsuranceCost',value ); end;
Procedure Tebay_orders_shipservcsel.setImportCharge                        (const Value: Double  );begin SEtFieldValue('ImportCharge',value ); end;
Procedure Tebay_orders_shipservcsel.setShippingSurcharge                   (const Value: Double  );begin SEtFieldValue('ShippingSurcharge',value ); end;
Procedure Tebay_orders_shipservcsel.setShippingServiceCostcurcode          (const Value: String );begin SEtFieldValue('ShippingServiceCostcurcode' , Value);end;
Procedure Tebay_orders_shipservcsel.setShippingServiceAdditionalCostcurcode(const Value: String );begin SEtFieldValue('ShippingServiceAdditionalCostcurcode' , Value);end;
Procedure Tebay_orders_shipservcsel.setShippingInsuranceCostcurcode        (const Value: String );begin SEtFieldValue('ShippingInsuranceCostcurcode' , Value);end;
Procedure Tebay_orders_shipservcsel.setImportChargecurcode                 (const Value: String );begin SEtFieldValue('ImportChargecurcode' , Value);end;
Procedure Tebay_orders_shipservcsel.setShippingSurchargecurcode            (const Value: String );begin SEtFieldValue('ShippingSurchargecurcode' , Value);end;

function Tebay_orders_shipservcsel.getShipServicecost: Tebay_orders_shipservcsel_shipservccost;
begin
  if (fShipServiceCost = nil) then begin
    fShipServiceCost:= Tebay_orders_shipservcsel_shipservccost.Create(self, 'tblebay_orders_shipservcsel_shipservccost', 'OrderId =' + inttostr(OrderID)+' and Orders_ShipServcSel_Id = ' + inttostr(ID));
  end;
  fShipServiceCost.SQLWhere := 'OrderId  =' + inttostr(ID);
  fShipServiceCost.Dataset;
  result:= fShipServiceCost;
end;


initialization
  RegisterClass(Tebay_orders_shipservcsel);


end.
