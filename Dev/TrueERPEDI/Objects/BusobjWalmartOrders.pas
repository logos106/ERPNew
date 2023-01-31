unit BusobjWalmartOrders;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  20/11/18  1.00.00  A.  Initial Version.
  }


interface


uses BusobjWalmartItems, BusObjBase, DB, Classes, XMLDoc, XMLIntf , BusobjERPWalmartCommon , tcConst;


type
  TWalmartOrderLineRefundCharges = class(TMSBusObj)
  private
    function GetOrderId              : Integer   ;
    function GetOrderLineId          : Integer   ;
    function GetRefundID             : Integer   ;
    function GetRefundReason         : string    ;
    function GetChargetype           : string    ;
    function GetChargeName           : string    ;
    function GetChargeAmount         : Double    ;
    function GetChargeCurrency       : string    ;
    function GettaxName              : string    ;
    function GettaxCurrency          : string    ;
    function GetTaxAmount            : Double    ;
    procedure SetOrderId              (const Value: Integer   );
    procedure SetOrderLineId          (const Value: Integer   );
    procedure SetRefundID             (const Value: Integer   );
    procedure SetRefundReason         (const Value: string    );
    procedure SetChargetype           (const Value: string    );
    procedure SetChargeName           (const Value: string    );
    procedure SetChargeAmount         (const Value: Double    );
    procedure SettaxName              (const Value: string    );
    procedure SettaxCurrency          (const Value: string    );
    procedure SetChargeCurrency       (const Value: string    );
    procedure SetTaxAmount           (const Value: Double    );
    function getERPRefundRef: String;
    procedure setERPRefundRef(const Value: String);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Function MakeERPREfund:Boolean;

  published
    property OrderId               :Integer     read GetOrderId             write SetOrderId          ;
    property OrderLineId           :Integer     read GetOrderLineId         write SetOrderLineId      ;
    property RefundID              :Integer     read GetRefundID            write SetRefundID         ;
    property RefundReason          :string      read GetRefundReason        write SetRefundReason     ;
    property Chargetype            :string      read GetChargetype          write SetChargetype       ;
    property ChargeName            :string      read GetChargeName          write SetChargeName       ;
    property ChargeAmount          :Double      read GetChargeAmount        write SetChargeAmount     ;
    property ChargeCurrency        :string      read GetChargeCurrency      write SetChargeCurrency   ;
    property taxName               :string      read GettaxName             write SettaxName          ;
    property taxCurrency           :string      read GettaxCurrency         write SettaxCurrency      ;
    property TaxAmount             :Double      read GetTaxAmount           write SetTaxAmount        ;
    property ERPRefundRef          :String      read getERPRefundRef        write setERPRefundRef;
  end;
  TWalmartOrderLineCharges = class(TMSBusObj)
  private
    function GetOrderId              : Integer   ;
    function GetOrderLineId          : Integer   ;
    function GetChargeType           : string    ;
    function GetChargeName           : string    ;
    function GetChargeCurrency       : string    ;
    function GettaxName              : string    ;
    function GetTaxCurrency          : string    ;
    function GetExchangeRate         : Double    ;
    function GetChargeAmount         : Double    ;
    function GetTaxAmount            : Double    ;
    procedure SetOrderId              (const Value: Integer   );
    procedure SetOrderLineId          (const Value: Integer   );
    procedure SetChargeType           (const Value: string    );
    procedure SetChargeName           (const Value: string    );
    procedure SetChargeCurrency       (const Value: string    );
    procedure SettaxName              (const Value: string    );
    procedure SetTaxCurrency          (const Value: string    );
    procedure SetExchangeRate         (const Value: Double    );
    procedure SetChargeAmount         (const Value: Double    );
    procedure SetTaxAmount            (const Value: Double    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property OrderId               :Integer     read GetOrderId             write SetOrderId          ;
    property OrderLineId           :Integer     read GetOrderLineId         write SetOrderLineId      ;
    property ChargeType            :string      read GetChargeType          write SetChargeType       ;
    property ChargeName            :string      read GetChargeName          write SetChargeName       ;
    property ChargeCurrency        :string      read GetChargeCurrency      write SetChargeName       ;
    property taxName               :string      read GettaxName             write SettaxName          ;
    property TaxCurrency           :string      read GetTaxCurrency         write SetTaxCurrency      ;
    property ExchangeRate          :Double      read GetExchangeRate        write SetExchangeRate     ;
    property ChargeAmount          :Double      read GetChargeAmount        write SetChargeAmount     ;
    property TaxAmount             :Double      read GetTaxAmount           write SetTaxAmount        ;
  end;
TWalmartOrderlineStatus = class(TMSBusObj)
  private
    function GetOrderId                 : Integer   ;
    function GetOrderLineId             : Integer   ;
    function Getorderstatus             : string    ;
    function GetStatusDate              : TDateTime ;
    function GetstatusQuantity          : Double    ;
    function GetUOM                     : string    ;
    function GetCancellationReason      : string    ;
    function GetShipDateTime            : TDateTime ;
    function GetCarrierNameOtherCarrier : string    ;
    function GetCarrierNameCarrier      : string    ;
    function GetCarrierMethodCode       : string    ;
    function GetCarrierTrackingNumber   : string    ;
    function GetCarrierTrackingURL      : string    ;
    procedure SetOrderId                 (const Value: Integer   );
    procedure SetOrderLineId             (const Value: Integer   );
    procedure Setorderstatus             (const Value: string    );
    procedure SetStatusDate              (const Value: TDateTime );
    procedure SetstatusQuantity          (const Value: Double    );
    procedure SetUOM                     (const Value: string    );
    procedure SetCancellationReason      (const Value: string    );
    procedure SetShipDateTime            (const Value: TDateTime );
    procedure SetCarrierNameOtherCarrier (const Value: string    );
    procedure SetCarrierNameCarrier      (const Value: string    );
    procedure SetCarrierMethodCode       (const Value: string    );
    procedure SetCarrierTrackingNumber   (const Value: string    );
    procedure SetCarrierTrackingURL      (const Value: string    );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property OrderId                  :Integer     read GetOrderId                  write SetOrderId             ;
    property OrderLineId              :Integer     read GetOrderLineId              write SetOrderLineId         ;
    property orderstatus              :string      read Getorderstatus              write Setorderstatus         ;
    property StatusDate               :TDateTime   read GetStatusDate               write SetStatusDate          ;
    property statusQuantity           :Double      read GetstatusQuantity           write SetstatusQuantity      ;
    property UOM                      :string      read GetUOM                      write SetUOM                 ;
    property CancellationReason       :string      read GetCancellationReason       write SetCancellationReason  ;
    property ShipDateTime             :TDateTime   read GetShipDateTime             write SetShipDateTime        ;
    property CarrierNameOtherCarrier  :string      read GetCarrierNameOtherCarrier  write SetCarrierNameOtherCarrier  ;
    property CarrierNameCarrier       :string      read GetCarrierNameCarrier       write SetCarrierNameCarrier  ;
    property CarrierMethodCode        :string      read GetCarrierMethodCode        write SetCarrierMethodCode   ;
    property CarrierTrackingNumber    :string      read GetCarrierTrackingNumber    write SetCarrierTrackingNumber   ;
    property CarrierTrackingURL       :string      read GetCarrierTrackingURL       write SetCarrierTrackingURL   ;
  end;
  TWalmartOrderLines = class(TMSBusObj)
  private
    function GetOrderId                  : Integer   ;
    function GetLinenumber               : string    ;
    function GetProductName              : string    ;
    function Getsku                      : string    ;
    function GetCurrency                 : string    ;
    function GetExchangeRate             : Double    ;
    function GetTotalAmount              : Double    ;
    function GetQtySold                  : Double    ;
    function GetUOM                      : string    ;
    function GetUOMMult                  : Double    ;
    function GetstatusDate               : TDateTime ;
    function GetoriginalCarrierMethod    : string    ;
    function GetRefundComments           : string    ;
    function GetReferenceLineId          : string    ;
    function GetFulfillmentOption        : string    ;
    function GetShipMethod               : string    ;
    function GetStoreId                  : string    ;
    function GetOfferId                  : string    ;
    function GetPickUpBy                 : string    ;
    function GetIntentToCancel           : string    ;
    function GetConfigId                 : string    ;
    function GetRefundId                 : Integer;
    function GetPickUpDateTime           : TDateTime ;
    function GetERPSalesLineRef          : string    ;
    function GetValidateOrderStatusCode  : Integer   ;
    procedure SetOrderId                  (const Value: Integer   );
    procedure SetLinenumber               (const Value: string    );
    procedure SetProductName              (const Value: string    );
    procedure Setsku                      (const Value: string    );
    procedure SetCurrency                 (const Value: string    );
    procedure SetExchangeRate             (const Value: Double    );
    procedure SetTotalAmount              (const Value: Double    );
    procedure SetQtySold                  (const Value: Double    );
    procedure SetUOM                      (const Value: string    );
    procedure SetUOMMult                  (const Value: Double    );
    procedure SetstatusDate               (const Value: TDateTime );
    procedure SetoriginalCarrierMethod    (const Value: string    );
    procedure SetRefundComments           (const Value: string    );
    procedure SetReferenceLineId          (const Value: string    );
    procedure SetFulfillmentOption        (const Value: string    );
    procedure SetShipMethod               (const Value: string    );
    procedure SetStoreId                  (const Value: string    );
    procedure SetOfferId                  (const Value: string    );
    procedure SetPickUpBy                 (const Value: string    );
    procedure SetIntentToCancel           (const Value: string    );
    procedure SetConfigId                 (const Value: string    );
    procedure SetRefundId                 (const Value: Integer    );
    procedure SetPickUpDateTime           (const Value: TDateTime );
    procedure SetERPSalesLineRef          (const Value: string    );
    procedure SetValidateOrderStatusCode  (const Value: Integer   );
    function getLineStatuses: TWalmartOrderlineStatus;
    function getLineCharges: TWalmartOrderLineCharges;
    function getRefundCharges: TWalmartOrderLineRefundCharges;
    function getWalmartOrderStatus: TWalmartOrderLineStatus_ERP;
    function getLineStatus: String;
    function getwalmartitem: Twalmartitems;
    function getProductnameforERP: String;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Procedure InitValidateOrderStatusCode(const Value:Integer; UpdateHeaderasWell :boolean = true);
    Property LineStatus :String read getLineStatus;
    Property walmartitem : Twalmartitems read getwalmartitem;
    Property ProductnameforERP :String read getProductnameforERP;
  published
    property OrderId                   :Integer     read GetOrderId                 write SetOrderId              ;
    property Linenumber                :string      read GetLinenumber              write SetLinenumber           ;
    property ProductName               :string      read GetProductName             write SetProductName          ;
    property sku                       :string      read Getsku                     write Setsku                  ;
    property Currency                  :string      read GetCurrency                write SetCurrency             ;
    property ExchangeRate              :Double      read GetExchangeRate            write SetExchangeRate         ;
    property TotalAmount               :Double      read GetTotalAmount             write SetTotalAmount          ;
    property QtySold                   :Double      read GetQtySold                 write SetQtySold              ;
    property UOM                       :string      read GetUOM                     write SetUOM                  ;
    property UOMMult                   :Double      read GetUOMMult                 write SetUOMMult              ;
    property statusDate                :TDateTime   read GetstatusDate              write SetstatusDate           ;
    property originalCarrierMethod     :string      read GetoriginalCarrierMethod   write SetoriginalCarrierMethod;
    property RefundComments            :string      read GetRefundComments          write SetRefundComments;
    property ReferenceLineId           :string      read GetReferenceLineId         write SetReferenceLineId;
    property FulfillmentOption         :string      read GetFulfillmentOption       write SetFulfillmentOption;
    property ShipMethod                :string      read GetShipMethod              write SetShipMethod;
    property StoreId                   :string      read GetStoreId                 write SetStoreId;
    property OfferId                   :string      read GetOfferId                 write SetOfferId;
    property PickUpBy                  :string      read GetPickUpBy                write SetPickUpBy;
    property IntentToCancel            :string      read GetIntentToCancel          write SetIntentToCancel;
    property ConfigId                  :string      read GetConfigId                write SetConfigId;
    property RefundId                  :Integer     read GetRefundId                write SetRefundId;
    property PickUpDateTime            :TDateTime   read GetPickUpDateTime          write SetPickUpDateTime           ;
    property ERPSalesLineRef           :string      read GetERPSalesLineRef         write SetERPSalesLineRef;
    property ValidateOrderStatusCode   :Integer     read GetValidateOrderStatusCode write SetValidateOrderStatusCode;
    Property LineStatuses : TWalmartOrderlineStatus read getLineStatuses;
    Property LineCharges : TWalmartOrderLineCharges read getLineCharges;
    Property RefundCharges  : TWalmartOrderLineRefundCharges read getRefundCharges;
    Property WalmartOrderStatus : TWalmartOrderLineStatus_ERP read getWalmartOrderStatus;

  end;
  TWalmartOrderLinesActive = class(TWalmartOrderLines) // Order items that are not cancelled
  Private
  Protected
    function  GetSQL : string;              override;
  Public
    constructor  Create(AOwner: TComponent);                            override;
  Published
  end;

  TWalmartOrders = class(TMSBusObj)
  private
    SO:TBusobj;
    fsExchangeCode:String;
    fsValidateOrderStatusMsg :String;
    fsMakeWalmartOrderStatus:String;
    fbWalmartOrderStatusSynched:Boolean;
    fbIsAcknowledged:Boolean;
    function GetEmployeeName                : string    ;
    function GetpurchaseOrderId             : string    ;
    function GetcustomerOrderId             : string    ;
    function GetcustomerEmailId             : string    ;
    function GetorderDate                   : TDateTime ;
    Function getBuyerId                     : Integer;
    function GetMart                        : string    ;
    function GetIsGuest                     : Boolean   ;
    function GetShippingphone               : string    ;
    function GetestimatedDeliveryDate       : TDateTime ;
    function GetestimatedShipDate           : TDateTime ;
    function GetShippingMethod              : string    ;
    function GetCustomerName                : string    ;
    function GetPostalAddressName           : string    ;
    function GetPostalAddressAddress1       : string    ;
    function GetPostalAddressAddress2       : string    ;
    function GetPostalAddressCity           : string    ;
    function GetPostalAddressstate          : string    ;
    function GetPostalAddressPostcode       : string    ;
    function GetPostalAddressCountry        : string    ;
    function GetPostalAddressAddresstype    : string    ;
    function GetSalesSource                 : string    ;
    function GetERPSalesRef                 : string    ;
    Function getValidateOrderStatusCode     : Integer;
    procedure SetEmployeeName                (const Value: string    );
    procedure SetpurchaseOrderId             (const Value: string    );
    procedure SetcustomerOrderId             (const Value: string    );
    procedure SetcustomerEmailId             (const Value: string    );
    procedure SetorderDate                   (const Value: TDateTime );
    Procedure SetBuyerId                     (Const Value: Integer   );
    procedure SetMart                        (const Value: string    );
    procedure SetIsGuest                     (const Value: Boolean   );
    procedure SetShippingphone               (const Value: string    );
    procedure SetestimatedDeliveryDate       (const Value: TDateTime );
    procedure SetestimatedShipDate           (const Value: TDateTime );
    procedure SetShippingMethod              (const Value: string    );
    procedure SetCustomerName                (const Value: string    );
    procedure SetPostalAddressName           (const Value: string    );
    procedure SetPostalAddressAddress1       (const Value: string    );
    procedure SetPostalAddressAddress2       (const Value: string    );
    procedure SetPostalAddressCity           (const Value: string    );
    procedure SetPostalAddressstate          (const Value: string    );
    procedure SetPostalAddressPostcode       (const Value: string    );
    procedure SetPostalAddressCountry        (const Value: string    );
    procedure SetPostalAddressAddresstype    (const Value: string    );
    procedure SetSalesSource                 (const Value: string    );
    procedure SetERPSalesRef                 (const Value: string    );
    Procedure SetValidateOrderStatusCode     (Const Value: Integer   );
    function getLines: TWalmartOrderLines;
    procedure CopyWOtoSOCallback(const Sender: TBusObj; var Abort: Boolean);
    Function ValidateOrder:Boolean;
    procedure ValidateOrderCallback(const Sender: TBusObj; var Abort: Boolean);
    Procedure MakeWalmartOrderStatus;
    function getLinesActive: TWalmartOrderLinesActive;
    procedure MakeWalmartOrderStatusCallback(const Sender: TBusObj;var Abort: Boolean);
    function getWalmartOrderStatus: TWalmartOrderLineStatus_ERP;
    function getSalesOrderID: Integer;
    function getIsAcknowledged: Boolean;
    procedure IsAcknowledgedcheckCallback(const Sender: TBusObj;
      var Abort: Boolean);

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    function  DoAfteropen(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Function CopyWOtoSO :Boolean;
    function ValidateOrderStatusMSG :String;
    Property LinesActive : TWalmartOrderLinesActive read getLinesActive;
    Property WalmartOrderStatus : TWalmartOrderLineStatus_ERP read getWalmartOrderStatus;
    Property SalesOrderID:Integer read getSalesOrderID;
    procedure MakeWalmartOrderStatusForLine(const Sender: TBusObj; aStatus :String = WalmartOrderStatus_Created);
    Procedure AcknowledgeWalmartOrder;
    Procedure MakeERPSOForWalmartforWalmartOrder;
    procedure DoEvent(const Sender: TObject; const EventType: integer; const Data: TObject = nil ;  Proc : TProcBusObjBase= nil); override;
    Property IsAcknowledged :Boolean read getIsAcknowledged;

    //Property WalmartOrder :String Write SetWalmartOrder;
    //function AcknowledgeOrder:String;
  published
    property EmployeeName                 :string      read GetEmployeeName               write SetEmployeeName            ;
    property purchaseOrderId              :string      read GetpurchaseOrderId            write SetpurchaseOrderId         ;
    property customerOrderId              :string      read GetcustomerOrderId            write SetcustomerOrderId         ;
    property customerEmailId              :string      read GetcustomerEmailId            write SetcustomerEmailId         ;
    property orderDate                    :TDateTime   read GetorderDate                  write SetorderDate               ;
    Property BuyerId                      :Integer     read getBuyerId                    write SetBuyerId                 ;
    property Mart                         :string      read GetMart                       write SetMart                    ;
    property IsGuest                      :Boolean     read GetIsGuest                    write SetIsGuest                 ;
    property Shippingphone                :string      read GetShippingphone              write SetShippingphone           ;
    property estimatedDeliveryDate        :TDateTime   read GetestimatedDeliveryDate      write SetestimatedDeliveryDate   ;
    property estimatedShipDate            :TDateTime   read GetestimatedShipDate          write SetestimatedShipDate       ;
    property ShippingMethod               :string      read GetShippingMethod             write SetShippingMethod          ;
    property CustomerName                 :string      read GetCustomerName               write SetCustomerName            ;
    property PostalAddressName            :string      read GetPostalAddressName          write SetPostalAddressName       ;
    property PostalAddressAddress1        :string      read GetPostalAddressAddress1      write SetPostalAddressAddress1   ;
    property PostalAddressAddress2        :string      read GetPostalAddressAddress2      write SetPostalAddressAddress2   ;
    property PostalAddressCity            :string      read GetPostalAddressCity          write SetPostalAddressCity       ;
    property PostalAddressstate           :string      read GetPostalAddressstate         write SetPostalAddressstate      ;
    property PostalAddressPostcode        :string      read GetPostalAddressPostcode      write SetPostalAddressPostcode   ;
    property PostalAddressCountry         :string      read GetPostalAddressCountry       write SetPostalAddressCountry    ;
    property PostalAddressAddresstype     :string      read GetPostalAddressAddresstype   write SetPostalAddressAddresstype;
    property SalesSource                  :string      read GetSalesSource                write SetSalesSource             ;
    property ERPSalesRef                  :string      read GetERPSalesRef                write SetERPSalesRef             ;
    Property ValidateOrderStatusCode      :Integer     read getValidateOrderStatusCode    write SetValidateOrderStatusCode ;
    Property Lines : TWalmartOrderLines read getLines;
  end;

implementation


uses BusObjSales, tcDataUtils, CommonLib , PurchaseOrderV33, LogLib,
  AppEnvironment,  sysutils, BusObjCommon, DbSharedObjectsObj,
  ERPdbComponents, BusObjTaxCodes, CommonDbLib, BusobjProduct,
  CK_DLL_WalmartLib, Walmart_Item_Lib, BusObjShippingAddress, BusObjShipment,
  ShipIntegrationUtils , ibxezship, BusobjCash, ShipIntegrationTypes;


  {TWalmartOrderLineCharges}

constructor TWalmartOrderLineCharges.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'EDIOrderLineCharges';
  fSQL := 'SELECT * FROM tblWalmartorderLineCharges';
end;


destructor TWalmartOrderLineCharges.Destroy;
begin
  inherited;
end;


procedure TWalmartOrderLineCharges.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'OrderId');
  SetPropertyFromNode(node,'OrderLineId');
  SetPropertyFromNode(node,'ChargeType');
  SetPropertyFromNode(node,'ChargeName');
  SetPropertyFromNode(node,'ChargeCurrency');
  SetPropertyFromNode(node,'taxName');
  SetPropertyFromNode(node,'TaxCurrency');
  SetPropertyFromNode(node,'ExchangeRate');
  SetPropertyFromNode(node,'ChargeAmount');
  SetPropertyFromNode(node,'TaxAmount');
end;


procedure TWalmartOrderLineCharges.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'OrderId' ,OrderId);
  AddXMLNode(node,'OrderLineId' ,OrderLineId);
  AddXMLNode(node,'ChargeType' ,ChargeType);
  AddXMLNode(node,'ChargeName' ,ChargeName);
  AddXMLNode(node,'ChargeCurrency' ,ChargeCurrency);
  AddXMLNode(node,'taxName' ,taxName);
  AddXMLNode(node,'TaxCurrency' ,TaxCurrency);
  AddXMLNode(node,'ExchangeRate' ,ExchangeRate);
  AddXMLNode(node,'ChargeAmount' ,ChargeAmount);
  AddXMLNode(node,'TaxAmount' ,TaxAmount);
end;


function TWalmartOrderLineCharges.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if OrderId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'OrderId should not be 0' , True);
    Exit;
  end;
  if OrderLineId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'OrderLineId should not be 0' , true);
    Exit;
  end;
  Result := True;
end;


function TWalmartOrderLineCharges.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TWalmartOrderLineCharges.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TWalmartOrderLineCharges.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TWalmartOrderLineCharges.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TWalmartOrderLineCharges.GetIDField: string;
begin
  Result := 'OrderLineChargID'
end;


class function TWalmartOrderLineCharges.GetBusObjectTablename: string;
begin
  Result:= 'tblWalmartorderLineCharges';
end;


function TWalmartOrderLineCharges.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if Owner is TWalmartOrderLines then begin
      OrderId := TWalmartOrderLines(Owner).OrderID;
      OrderLineId := TWalmartOrderLines(Owner).ID;
    end;
end;

function TWalmartOrderLineCharges.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TWalmartOrderLineCharges.GetOrderId          : Integer   ; begin Result := GetIntegerField('OrderId');end;
function  TWalmartOrderLineCharges.GetOrderLineId      : Integer   ; begin Result := GetIntegerField('OrderLineId');end;
function  TWalmartOrderLineCharges.GettaxName          : string    ; begin Result := GetStringField('taxName');end;
function  TWalmartOrderLineCharges.GetChargeType       : string    ; begin Result := GetStringField('ChargeType');end;
function  TWalmartOrderLineCharges.GetChargeName       : string    ; begin Result := GetStringField('ChargeName');end;
function  TWalmartOrderLineCharges.GetChargeCurrency   : string    ; begin Result := GetStringField('ChargeCurrency');end;
function  TWalmartOrderLineCharges.GetTaxCurrency      : string    ; begin Result := GetStringField('TaxCurrency');end;
function  TWalmartOrderLineCharges.GetExchangeRate     : Double    ; begin Result := GetFloatField('ExchangeRate');end;
function  TWalmartOrderLineCharges.GetChargeAmount     : Double    ; begin Result := GetFloatField('ChargeAmount');end;
function  TWalmartOrderLineCharges.GetTaxAmount        : Double    ; begin Result := GetFloatField('TaxAmount');end;
procedure TWalmartOrderLineCharges.SetOrderId          (const Value: Integer   ); begin SetIntegerField('OrderId'           , Value);end;
procedure TWalmartOrderLineCharges.SetOrderLineId      (const Value: Integer   ); begin SetIntegerField('OrderLineId'       , Value);end;
procedure TWalmartOrderLineCharges.SetChargeType       (const Value: string    ); begin SetStringField('ChargeType'            , Value);end;
procedure TWalmartOrderLineCharges.SetChargeName       (const Value: string    ); begin SetStringField('ChargeName'            , Value);end;
procedure TWalmartOrderLineCharges.SetChargeCurrency   (const Value: string    ); begin SetStringField('ChargeCurrency'            , Value);end;
procedure TWalmartOrderLineCharges.SettaxName          (const Value: string    ); begin SetStringField('taxName'           , Value);end;
procedure TWalmartOrderLineCharges.SetTaxCurrency      (const Value: string    ); begin SetStringField('TaxCurrency'      , Value);end;
procedure TWalmartOrderLineCharges.SetExchangeRate     (const Value: Double    ); begin SetFloatField('ExchangeRate'      , Value);end;
procedure TWalmartOrderLineCharges.SetChargeAmount     (const Value: Double    ); begin SetFloatField('ChargeAmount'      , Value);end;
procedure TWalmartOrderLineCharges.SetTaxAmount        (const Value: Double    ); begin SetFloatField('TaxAmount'         , Value);end;


  {TWalmartOrderlineStatus}

constructor TWalmartOrderlineStatus.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'EdiOrderlineStatus';
  fSQL := 'SELECT * FROM tblWalmartorderlinestatus';
end;


destructor TWalmartOrderlineStatus.Destroy;
begin
  inherited;
end;


procedure TWalmartOrderlineStatus.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'OrderId');
  SetPropertyFromNode(node,'OrderLineId');
  SetPropertyFromNode(node,'orderstatus');
  SetDateTimePropertyFromNode(node,'StatusDate');
  SetPropertyFromNode(node,'statusQuantity');
  SetPropertyFromNode(node,'UOM');
  SetPropertyFromNode(node,'CancellationReason');
  SetDateTimePropertyFromNode(node,'ShipDateTime');
  SetPropertyFromNode(node,'CarrierNameOtherCarrier');
  SetPropertyFromNode(node,'CarrierNameCarrier');
  SetPropertyFromNode(node,'CarrierMethodCode');
  SetPropertyFromNode(node,'CarrierTrackingNumber');
  SetPropertyFromNode(node,'CarrierTrackingURL');
end;


procedure TWalmartOrderlineStatus.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'OrderId' ,OrderId);
  AddXMLNode(node,'OrderLineId' ,OrderLineId);
  AddXMLNode(node,'orderstatus' ,orderstatus);
  AddXMLNode(node,'StatusDate' ,StatusDate);
  AddXMLNode(node,'statusQuantity' ,statusQuantity);
  AddXMLNode(node,'UOM' ,UOM);
  AddXMLNode(node,'CancellationReason' ,CancellationReason);
  AddXMLNode(node,'ShipDateTime' ,ShipDateTime);
  AddXMLNode(node,'CarrierNameOtherCarrier' ,CarrierNameOtherCarrier);
  AddXMLNode(node,'CarrierNameCarrier' ,CarrierNameCarrier);
  AddXMLNode(node,'CarrierMethodCode' ,CarrierMethodCode);
  AddXMLNode(node,'CarrierTrackingNumber' ,CarrierTrackingNumber);
  AddXMLNode(node,'CarrierTrackingURL' ,CarrierTrackingURL);
end;


function TWalmartOrderlineStatus.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if OrderId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'OrderId should not be 0' , true);
    Exit;
  end;
  if OrderLineId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'OrderLineId should not be 0' , true );
    Exit;
  end;
  if StatusDate = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'StatusDate should not be blank' , true );
    Exit;
  end;
  if statusQuantity = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'statusQuantity should not be 0' , true );
    Exit;
  end;
  Result := True;
end;


function TWalmartOrderlineStatus.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TWalmartOrderlineStatus.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TWalmartOrderlineStatus.DoFieldOnChange(Sender: TField);
begin
  If (Sender.FieldKind <> FkData) Or Dataset.ControlsDisabled Then
    If Not DoFieldChangewhenDisabled Then Exit; // we are only interested in data fields.

  inherited;
  if Sysutils.SameText(Sender.FieldName, 'Status') then begin
    StatusDate := now;
  end;
end;


function TWalmartOrderlineStatus.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TWalmartOrderlineStatus.GetIDField: string;
begin
  Result := 'OrderLineStatusID'
end;


class function TWalmartOrderlineStatus.GetBusObjectTablename: string;
begin
  Result:= 'tblWalmartorderlinestatus';
end;


function TWalmartOrderlineStatus.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if Owner is TWalmartOrderLines then begin
      OrderId := TWalmartOrderLines(Owner).OrderID;
      OrderLineId := TWalmartOrderLines(Owner).ID;
    end;
end;

function TWalmartOrderlineStatus.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TWalmartOrderlineStatus.GetOrderId             : Integer   ; begin Result := GetIntegerField('OrderId');end;
function  TWalmartOrderlineStatus.GetOrderLineId         : Integer   ; begin Result := GetIntegerField('OrderLineId');end;
function  TWalmartOrderlineStatus.Getorderstatus         : string    ; begin Result := GetStringField('orderstatus');end;
function  TWalmartOrderlineStatus.GetStatusDate          : TDateTime ; begin Result := GetDateTimeField('StatusDate');end;
function  TWalmartOrderlineStatus.GetstatusQuantity      : Double    ; begin Result := GetFloatField('statusQuantity');end;
function  TWalmartOrderlineStatus.GetUOM                 : string    ; begin Result := GetStringField('UOM');end;
function  TWalmartOrderlineStatus.GetCancellationReason  : string    ; begin Result := GetStringField('CancellationReason');end;
function  TWalmartOrderlineStatus.GetShipDateTime        : TDateTime ; begin Result := GetDateTimeField('ShipDateTime');end;
function  TWalmartOrderlineStatus.GetCarrierNameOtherCarrier : string    ; begin Result := GetStringField('CarrierNameOtherCarrier');end;
function  TWalmartOrderlineStatus.GetCarrierNameCarrier  : string    ; begin Result := GetStringField('CarrierNameCarrier');end;
function  TWalmartOrderlineStatus.GetCarrierMethodCode   : string    ; begin Result := GetStringField('CarrierMethodCode');end;
function  TWalmartOrderlineStatus.GetCarrierTrackingNumber: string    ; begin Result := GetStringField('CarrierTrackingNumber');end;
function  TWalmartOrderlineStatus.GetCarrierTrackingURL  : string    ; begin Result := GetStringField('CarrierTrackingURL');end;
procedure TWalmartOrderlineStatus.SetOrderId             (const Value: Integer   ); begin SetIntegerField('OrderId'              , Value);end;
procedure TWalmartOrderlineStatus.SetOrderLineId         (const Value: Integer   ); begin SetIntegerField('OrderLineId'          , Value);end;
procedure TWalmartOrderlineStatus.Setorderstatus         (const Value: string    ); begin SetStringField('orderstatus'          , Value);end;
procedure TWalmartOrderlineStatus.SetStatusDate          (const Value: TDateTime ); begin SetDateTimeField('StatusDate'           , Value);end;
procedure TWalmartOrderlineStatus.SetstatusQuantity      (const Value: Double    ); begin SetFloatField('statusQuantity'       , Value);end;
procedure TWalmartOrderlineStatus.SetUOM                 (const Value: string    ); begin SetStringField('UOM'                  , Value);end;
procedure TWalmartOrderlineStatus.SetCancellationReason  (const Value: string    ); begin SetStringField('CancellationReason'   , Value);end;
procedure TWalmartOrderlineStatus.SetShipDateTime        (const Value: TDateTime ); begin SetDateTimeField('ShipDateTime'         , Value);end;
procedure TWalmartOrderlineStatus.SetCarrierNameOtherCarrier  (const Value: string    ); begin SetStringField('CarrierNameOtherCarrier'   , Value);end;
procedure TWalmartOrderlineStatus.SetCarrierNameCarrier  (const Value: string    ); begin SetStringField('CarrierNameCarrier'   , Value);end;
procedure TWalmartOrderlineStatus.SetCarrierMethodCode   (const Value: string    ); begin SetStringField('CarrierMethodCode'   , Value);end;
procedure TWalmartOrderlineStatus.SetCarrierTrackingNumber(const Value: string    ); begin SetStringField('CarrierTrackingNumber'   , Value);end;
procedure TWalmartOrderlineStatus.SetCarrierTrackingURL  (const Value: string    ); begin SetStringField('CarrierTrackingURL'   , Value);end;


  {TWalmartOrderLines}

constructor TWalmartOrderLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'EDIOrderLines';
  fSQL := 'SELECT * FROM tblWalmartorderlines';
end;


destructor TWalmartOrderLines.Destroy;
begin
  inherited;
end;


procedure TWalmartOrderLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'OrderId');
  SetPropertyFromNode(node,'Linenumber');
  SetPropertyFromNode(node,'ProductName');
  SetPropertyFromNode(node,'sku');
  SetPropertyFromNode(node,'Currency');
  SetPropertyFromNode(node,'ExchangeRate');
  SetPropertyFromNode(node,'TotalAmount');
  SetPropertyFromNode(node,'QtySold');
  SetPropertyFromNode(node,'UOM');
  SetPropertyFromNode(node,'UOMMult');
  SetDateTimePropertyFromNode(node,'statusDate');
  SetPropertyFromNode(node,'originalCarrierMethod');
  SetPropertyFromNode(node,'RefundComments');
  SetPropertyFromNode(node,'ReferenceLineId');
  SetPropertyFromNode(node,'FulfillmentOption');
  SetPropertyFromNode(node,'ShipMethod');
  SetPropertyFromNode(node,'StoreId');
  SetPropertyFromNode(node,'OfferId');
  SetPropertyFromNode(node,'PickUpBy');
  SetPropertyFromNode(node,'IntentToCancel');
  SetPropertyFromNode(node,'ConfigId');
  SetPropertyFromNode(node,'RefundId');
  SetDateTimePropertyFromNode(node,'PickUpDateTime');
  SetPropertyFromNode(node,'ERPSalesLineRef');
  SetPropertyFromNode(node,'ValidateOrderStatusCode');
end;


procedure TWalmartOrderLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'OrderId' ,OrderId);
  AddXMLNode(node,'Linenumber' ,Linenumber);
  AddXMLNode(node,'ProductName' ,ProductName);
  AddXMLNode(node,'sku' ,sku);
  AddXMLNode(node,'Currency' ,Currency);
  AddXMLNode(node,'ExchangeRate' ,ExchangeRate);
  AddXMLNode(node,'TotalAmount' ,TotalAmount);
  AddXMLNode(node,'QtySold' ,QtySold);
  AddXMLNode(node,'UOM' ,UOM);
  AddXMLNode(node,'UOMMult' ,UOMMult);
  AddXMLNode(node,'statusDate' ,statusDate);
  AddXMLNode(node,'originalCarrierMethod' ,originalCarrierMethod);
  AddXMLNode(node,'RefundComments' ,RefundComments);
  AddXMLNode(node,'ReferenceLineId' ,ReferenceLineId);
  AddXMLNode(node,'FulfillmentOption' ,FulfillmentOption);
  AddXMLNode(node,'ShipMethod' ,ShipMethod);
  AddXMLNode(node,'StoreId' ,StoreId);
  AddXMLNode(node,'OfferId' ,OfferId);
  AddXMLNode(node,'PickUpBy' ,PickUpBy);
  AddXMLNode(node,'IntentToCancel' ,IntentToCancel);
  AddXMLNode(node,'ConfigId' ,ConfigId);
  AddXMLNode(node,'RefundId' ,RefundId);
  AddXMLNode(node,'PickUpDateTime' ,PickUpDateTime);
  AddXMLNode(node,'ERPSalesLineRef' ,ERPSalesLineRef);
  AddXMLNode(node,'ValidateOrderStatusCode' ,ValidateOrderStatusCode);
end;


function TWalmartOrderLines.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if OrderId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'OrderId should not be 0' , true );
    Exit;
  end;
  if Linenumber = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'Linenumber should not be blank' , true );
    Exit;
  end;
  Result := True;
end;


function TWalmartOrderLines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TWalmartOrderLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TWalmartOrderLines.DoFieldOnChange(Sender: TField);
begin
  If (Sender.FieldKind <> FkData) Or Dataset.ControlsDisabled Then
    If Not DoFieldChangewhenDisabled Then Exit; // we are only interested in data fields.

  inherited;
  if Sysutils.SameText(Sender.FieldName, 'ValidateOrderStatusCode') then begin
  end;
end;


function TWalmartOrderLines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TWalmartOrderLines.GetIDField: string;
begin
  Result := 'OrderLineId'
end;


class function TWalmartOrderLines.GetBusObjectTablename: string;
begin
  Result:= 'tblWalmartorderlines';
end;


function TWalmartOrderLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if Owner is TWalmartOrders then begin
      OrderId := TWalmartOrders(Owner).ID;
    end;
  ValidateOrderStatusCode := vosNotValidated;
end;

function TWalmartOrderLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function TWalmartOrderLines.getLineStatus: String;
begin
  result := '';
  if LineStatuses.count >0 then begin
    LineStatuses.last;
    result := LineStatuses.orderstatus;
  end;
end;

function TWalmartOrderLines.getLineStatuses: TWalmartOrderlineStatus;
begin
  Result := TWalmartOrderlineStatus(Getcontainercomponent(TWalmartOrderlineStatus , 'OrderLineId = '+ inttostr(ID)));
end;

function TWalmartOrderLines.getLineCharges: TWalmartOrderLineCharges;
begin
  Result := TWalmartOrderLineCharges(Getcontainercomponent(TWalmartOrderLineCharges , 'OrderLineId = '+ inttostr(ID)));
end;
function TWalmartOrderLines.getRefundCharges: TWalmartOrderLineRefundCharges;
begin
  Result := TWalmartOrderLineRefundCharges(Getcontainercomponent(TWalmartOrderLineRefundCharges , 'OrderLineId = '+ inttostr(ID)));
end;
procedure TWalmartOrderLines.InitValidateOrderStatusCode(const Value: Integer; UpdateHeaderasWell :boolean = true);
begin
  ValidateOrderStatusCode := Value;
  PostDB;
  if UpdateHeaderasWell then
    if assigned(Owner) and (owner is  TWalmartOrders) then begin
      TWalmartOrders(Owner).ValidateOrderStatusCode := Value;
      TWalmartOrders(Owner).PostDB;
    end;
end;
function TWalmartOrderLines.getwalmartitem: Twalmartitems;
begin
  Result := Twalmartitems(Getcontainercomponent(Twalmartitems , 'ProductName = '+ quotedstr(ProductName)));
  if (ProductName<> '') and (Result.count =0) then begin
    REsult.New;
    REsult.ProductName := ProductName;
    REsult.SKU := SKU;
(*    REsult.UPC := UPC;
    REsult.GTIN := GTIN;
    REsult.WPID := WPID;*)
    REsult.PostDB;
  end;
  ChecknMakeERPProduct(result , nil);
end;

function TWalmartOrderLines.getWalmartOrderStatus: TWalmartOrderLineStatus_ERP;
begin
  Result := TWalmartOrderLineStatus_ERP(Getcontainercomponent(TWalmartOrderLineStatus_ERP , 'WOID = '+ inttostr(OrderID)+' and WOLineID = ' + inttostr(ID)));
end;
function TWalmartOrderLines.getProductnameforERP: String;
begin
  REsult := walmartitem.ProductnameforERP;
end;

{Property Functions}
function  TWalmartOrderLines.GetOrderId                 : Integer   ; begin Result := GetIntegerField('OrderId');end;
function  TWalmartOrderLines.GetLinenumber              : string    ; begin Result := GetstringField('Linenumber');end;
function  TWalmartOrderLines.GetProductName             : string    ; begin Result := GetStringField('ProductName');end;
function  TWalmartOrderLines.Getsku                     : string    ; begin Result := GetStringField('sku');end;
function  TWalmartOrderLines.GetCurrency                : string    ; begin Result := GetStringField('Currency');end;
function  TWalmartOrderLines.GetExchangeRate            : Double    ; begin Result := GetFloatField('ExchangeRate');end;
function  TWalmartOrderLines.GetTotalAmount             : Double    ; begin Result := GetFloatField('TotalAmount');end;
function  TWalmartOrderLines.GetQtySold                 : Double    ; begin Result := GetFloatField('QtySold');end;
function  TWalmartOrderLines.GetUOM                     : string    ; begin Result := GetStringField('UOM');end;
function  TWalmartOrderLines.GetUOMMult                 : Double    ; begin Result := GetFloatField('UOMMult');end;
function  TWalmartOrderLines.GetstatusDate              : TDateTime ; begin Result := GetDateTimeField('statusDate');end;
function  TWalmartOrderLines.GetoriginalCarrierMethod   : string    ; begin Result := GetStringField('originalCarrierMethod');end;
function  TWalmartOrderLines.GetRefundComments          : string    ; begin Result := GetStringField('RefundComments');end;
function  TWalmartOrderLines.GetReferenceLineId         : string    ; begin Result := GetStringField('ReferenceLineId');end;
function  TWalmartOrderLines.GetFulfillmentOption       : string    ; begin Result := GetStringField('FulfillmentOption');end;
function  TWalmartOrderLines.GetShipMethod              : string    ; begin Result := GetStringField('ShipMethod');end;
function  TWalmartOrderLines.GetStoreId                 : string    ; begin Result := GetStringField('StoreId');end;
function  TWalmartOrderLines.GetOfferId                 : string    ; begin Result := GetStringField('OfferId');end;
function  TWalmartOrderLines.GetPickUpBy                : string    ; begin Result := GetStringField('PickUpBy');end;
function  TWalmartOrderLines.GetIntentToCancel          : string    ; begin Result := GetStringField('IntentToCancel');end;
function  TWalmartOrderLines.GetConfigId                : string    ; begin Result := GetStringField('ConfigId');end;
function  TWalmartOrderLines.GetRefundId                : Integer   ; begin Result := GetIntegerField('RefundId');end;
function  TWalmartOrderLines.GetPickUpDateTime          : TDateTime ; begin Result := GetDateTimeField('PickUpDateTime');end;
function  TWalmartOrderLines.GetERPSalesLineRef         : string    ; begin Result := GetStringField('ERPSalesLineRef');end;
function  TWalmartOrderLines.GetValidateOrderStatusCode : Integer   ; begin Result := GetIntegerField('ValidateOrderStatusCode');end;
procedure TWalmartOrderLines.SetOrderId                 (const Value: Integer   );begin SetIntegerField('OrderId'               , Value);end;
procedure TWalmartOrderLines.SetLinenumber              (const Value: string    );begin SetstringField('Linenumber'            , Value);end;
procedure TWalmartOrderLines.SetProductName             (const Value: string    );begin SetStringField('ProductName'           , Value);end;
procedure TWalmartOrderLines.Setsku                     (const Value: string    );begin SetStringField('sku'                   , Value);end;
procedure TWalmartOrderLines.SetCurrency                (const Value: string    );begin SetStringField('Currency'          , Value);end;
procedure TWalmartOrderLines.SetExchangeRate            (const Value: Double    );begin SetFloatField('ExchangeRate'          , Value);end;
procedure TWalmartOrderLines.SetTotalAmount             (const Value: Double    );begin SetFloatField('TotalAmount'           , Value);end;
procedure TWalmartOrderLines.SetQtySold                 (const Value: Double    );begin SetFloatField('QtySold'               , Value);end;
procedure TWalmartOrderLines.SetUOM                     (const Value: string    );begin SetStringField('UOM'                   , Value);end;
procedure TWalmartOrderLines.SetUOMMult                 (const Value: Double    );begin SetFloatField('UOMMult'               , Value);end;
procedure TWalmartOrderLines.SetstatusDate              (const Value: TDateTime );begin SetDateTimeField('statusDate'            , Value);end;
procedure TWalmartOrderLines.SetoriginalCarrierMethod   (const Value: string    );begin SetStringField('originalCarrierMethod' , Value);end;
procedure TWalmartOrderLines.SetRefundComments          (const Value: string    );begin SetStringField('RefundComments' , Value);end;
procedure TWalmartOrderLines.SetReferenceLineId         (const Value: string    );begin SetStringField('ReferenceLineId' , Value);end;
procedure TWalmartOrderLines.SetFulfillmentOption       (const Value: string    );begin SetStringField('FulfillmentOption' , Value);end;
procedure TWalmartOrderLines.SetShipMethod              (const Value: string    );begin SetStringField('ShipMethod' , Value);end;
procedure TWalmartOrderLines.SetStoreId                 (const Value: string    );begin SetStringField('StoreId' , Value);end;
procedure TWalmartOrderLines.SetOfferId                 (const Value: string    );begin SetStringField('OfferId' , Value);end;
procedure TWalmartOrderLines.SetPickUpBy                (const Value: string    );begin SetStringField('PickUpBy' , Value);end;
procedure TWalmartOrderLines.SetIntentToCancel          (const Value: string    );begin SetStringField('IntentToCancel' , Value);end;
procedure TWalmartOrderLines.SetConfigId                (const Value: string    );begin SetStringField('ConfigId' , Value);end;
procedure TWalmartOrderLines.SetRefundId                (const Value: Integer   );begin SetIntegerField('RefundId' , Value);end;
procedure TWalmartOrderLines.SetPickUpDateTime          (const Value: TDateTime );begin SetDateTimeField('PickUpDateTime'            , Value);end;
procedure TWalmartOrderLines.SetERPSalesLineRef         (const Value: string    );begin SetStringField('ERPSalesLineRef' , Value);end;
procedure TWalmartOrderLines.SetValidateOrderStatusCode (const Value: Integer   );begin SetIntegerField('ValidateOrderStatusCode' , Value);end;

  {TWalmartOrders}

(*function TWalmartOrders.AcknowledgeOrder: String;
var
  errmsg:String;
begin
  REsult := '';
  if count =0 then exit;

  Result:=AcknowledgeWalmartOrder(ID, errmsg , nil, nil);
  if errmsg = '' then begin
      fbWalmartOrderStatusSynched:= True;
      fsMakeWalmartOrderStatus := WalmartOrderStatus_Acknowledged;
      try
        MakeWalmartOrderStatus;
      finally
        fsMakeWalmartOrderStatus := '';
        fbWalmartOrderStatusSynched := False;
      end;
  end else begin
    result := Result + NL +'Error :' + errmsg;
  end;
end;*)
procedure TWalmartOrders.AcknowledgeWalmartOrder;
begin
        fbWalmartOrderStatusSynched:= True;
        fsMakeWalmartOrderStatus := WalmartOrderStatus_Acknowledged;
        try
          MakeWalmartOrderStatus;
        finally
          fsMakeWalmartOrderStatus := '';
          fbWalmartOrderStatusSynched := False;
        end;

end;

function TWalmartOrders.CopyWOtoSO: Boolean;
var
  iShippingAddressID:Integer;
  aPayortype:String;
  function SOObj:TSalesOrder;
  begin
    result := nil;
    if assigned(SO) then
      Result := TsalesOrder(SO);
  end;

  Procedure MakeSalesShipment;
  var
    ShipmentList : TShipmentList;
    ServiceType:TibxezshipServiceTypes;
    ClientShipperAccountNo: string;
    ClientBillCountryCode: string;
    ClientBillPostcode: string;
  begin
    ShipmentList := TShipmentList.Create(nil);
    try
      ShipmentList.Connection:=  SO.Connection;
      ShipmentList.LoadSelect('SaleId = ' + IntToStr(SOObj.ID));
      if ShipmentList.Count >0 then exit;

      ShipmentList.New;
      ShipmentList.SaleId := SOObj.ID;
      ShipmentList.PostDb;

        ShipmentList.Shipments.New;
        ShipmentList.Shipments.Provider := SaleShipProvider(SOObj.Id, ServiceType, ClientShipperAccountNo, ClientBillCountryCode, ClientBillPostcode,aPayortype);
        ShipmentList.Shipments.ServiceType := ServiceType;
        ShipmentList.Shipments.ShipAddressId := iShippingAddressID;
        ShipmentList.Shipments.Payortype := StrToPayorType(aPayortype);
        if ClientShipperAccountNo <> '' then begin
          ShipmentList.Shipments.PayorAccountNumber := ClientShipperAccountNo;
          ShipmentList.Shipments.PayorType := ibxezship.ptRecipient;
          if ShipmentList.Shipments.Provider = TibxezshipProviders.pUPS then
            ShipmentList.Shipments.PayorZipCode := ClientBillPostcode;
        end;
        ShipmentList.Shipments.PostDb;
        { create at least one new package line }
        ShipmentList.Shipments.Packages.New;
        ShipmentList.Shipments.Packages.PackageType := ShipIntegrationUtils.DefaultPackageType(ShipmentList.Shipments.Provider);
        try
          ShipmentList.Shipments.Packages.PostDb;
        except

        end;
      ShipmentList.UpdatePackageReferences(SOObj.CustPONumber);
    finally
      Freeandnil(ShipmentList);
    end;
  end;
begin
  Result := False;
  if count =0 then exit;
  if  Lines.count =0 then exit;

  if ERPSalesRef <> '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'ERP order is already created for this Order.' +NL+
                                                'Walmart Order customerOrderId #' + customerOrderId +NL+
                                                'Walmart Order purchaseOrderId #' + purchaseOrderId +NL+
                                                'ERP Sales Ref #' + ERPSalesRef , true );
    Exit;
  end;
  if not ValidateOrder then begin
    Resultstatus.AddItem(False , rssError , 0,  ValidateOrderStatusMSG , True);
    exit;
  end;

  SO:= TBusobj(TSalesOrder.CreateWithNewConn(nil));
  try
    SOObj.Load(0);
    SOObj.Connection.beginTransaction;
    try
        SOObj.SilentMode := True;
        SOObj.New;
        if SOObj.CustomerName <> Appenv.CompanyPrefs.Walmartcustomer then SOObj.CustomerName := Appenv.CompanyPrefs.Walmartcustomer;
        SOObj.ShipToDesc :=  trim(PostalAddressName+NL)+
                             trim(PostalAddressAddress1+NL)+
                             trim(PostalAddressAddress2+NL)+
                             trim(PostalAddressCity+NL)+
                             trim(PostalAddressstate+NL)+
                             trim(PostalAddressPostcode+NL)+
                             trim(PostalAddressCountry+NL);
        SOObj.saleDate        := OrderDate;
        SOObj.isinternalorder := False;
        SOObj.ShipDate        := estimatedShipDate;
        if TShippingMethod.IDToggle(ShippingMethod, true , TShippingMethod)>0 then
          SOObj.Shipping := ShippingMethod;
        SOObj.PostDB;
        ERPSalesRef := SOObj.Globalref;
        PostDB;

        // make the record - this is required for the shipment
        if SOObj.SalesShippingDetails.count =0 then SOObj.SalesShippingDetails.New;
        SOObj.SalesShippingDetails.ETD                        := EstimatedDeliveryDate;
        SOObj.SalesShippingDetails.PostDB;


        LinesActive.IterateRecords(CopyWOtoSOCallback); // the NOT cancelled lines will be copied into the Salesorder
        if not SOObj.Save then begin
          SOObj.connection.RollbackTransaction;
          Exit;
        end;
        iShippingAddresSId:= TShippingAddress.NewShippingAddress(self,
                                      SOObj.Customername,
                                      PostalAddressName,     // contactname
                                      PostalAddressAddress1, // address1
                                      PostalAddressAddress2, // address 2
                                      '',                    // address 3
                                      PostalAddressCity,
                                      PostalAddressPostcode,
                                      PostalAddressstate,
                                      PostalAddressCountry,
                                      '',//aDocPortOfLanding
                                      '',//aDocPortOfDischarge
                                      '',//aDocFinalDestination
                                      '',//aDocIncoPlace
                                      ShippingPhone,//aDocPhone
                                      CustomerEmailID,//aDocEmail
                                      '',//aDocFax
                                      True);
        MakeSalesShipment;

        SOObj.connection.CommitTransaction;
        Result := True;
    Except
      on E:Exception do begin
        SOObj.connection.RollbackTransaction;
      end;
    end;
  finally
    Freeandnil(SO);
  end;
end;
Procedure TWalmartOrders.CopyWOtoSOCallback(Const Sender: TBusObj; Var Abort: Boolean);
function SOObj:TSalesOrder;
begin
  result := nil;
  if assigned(SO) then
    Result := TsalesOrder(SO);
end;
begin
  if not (Sender is  TWalmartOrderLines) then exit;
  SOObj.Lines.New;
  if isinteger(TWalmartOrderLines(Sender).Linenumber) then SOObj.Lines.Seqno := strtoInt(TWalmartOrderLines(Sender).Linenumber);
  SOObj.Lines.ProductName   := TWalmartOrderLines(Sender).ProductnameforERP;
  SOObj.Lines.UnitOfMeasure := TWalmartOrderLines(Sender).UOM;

  SOObj.Lines.UOMQtySold    := TWalmartOrderLines(Sender).QtySold;
  SOObj.Lines.UOMQtyShipped := SOObj.Lines.UOMQtySold;

  if TWalmartOrderLines(Sender).LineCharges.count >0 then begin
    if SOObj.ForeignExchangeCode ='' then SOObj.ForeignExchangeCode := TWalmartOrderLines(Sender).LineCharges.ChargeCurrency;
    if SOObj.ForeignExchangeCode ='' then SOObj.ForeignExchangeCode := TWalmartOrderLines(Sender).LineCharges.TaxCurrency;
    //if TWalmartOrderLines(Sender).LineCharges.taxName <> '' then
      if TTaxCode.IDToggle(TWalmartOrderLines(Sender).LineCharges.taxName ,True,TTaxCode) >0 then
        SOObj.Lines.LineTaxCode         :=TWalmartOrderLines(Sender).LineCharges.taxName ;

    if sametext(TWalmartOrderLines(Sender).LineCharges.Chargetype, 'PRODUCT') then
          SOObj.Lines.linepriceinc      :=TWalmartOrderLines(Sender).LineCharges.ChargeAmount
    else  SOObj.Lines.TotalLineAmountinc:=TWalmartOrderLines(Sender).LineCharges.ChargeAmount;
    SOObj.Lines.AllowTaxinput           := true;  // the tax is not accepted otherwise , and gets recalculated
    try
    SOObj.Lines.LineTaxTotal            := TWalmartOrderLines(Sender).LineCharges.TaxAmount;
    SOObj.Lines.OriginalLinePrice       := SOObj.Lines.LinePrice;
    finally
      SOObj.Lines.AllowTaxinput         := False;
    end;
  end;
  if Appenv.Companyprefs.WALMART_IgnoreTaxonSale and
    ((SOObj.Lines.LineTaxRate<>0) or (SOObj.Lines.LineTaxTotal<>0) ) then begin
    SOObj.Lines.Product_Description_Memo:= trim(SOObj.Lines.Product_Description_Memo +NL +
                                                 'Tax removed from Walmart Sales based on the Preference : '+NL+
                                                 'Tax Rate : ' + FloatToStrf(SOObj.Lines.LineTaxRate , ffGeneral, 15,2)  +NL+
                                                 'Tax Total : '+ FloatToStrf(SOObj.Lines.LineTaxTotal , ffGeneral, 15,2));

    SOObj.Lines.LineTaxRate :=0;
    SOObj.Lines.LineTaxTotal :=0;
  end;
  SOObj.Lines.PostDB;
  TWalmartOrderLines(Sender).ERPSalesLineRef :=SOObj.Lines.Globalref;
  TWalmartOrderLines(Sender).PostDB;
end;
constructor TWalmartOrders.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'EDIOrders';
  fSQL := 'SELECT * FROM tblWalmartorders';
  fbWalmartOrderStatusSynched := False;
  fsMakeWalmartOrderStatus := '';
end;


destructor TWalmartOrders.Destroy;
begin
  inherited;
end;


procedure TWalmartOrders.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'EmployeeName');
  SetPropertyFromNode(node,'purchaseOrderId');
  SetPropertyFromNode(node,'customerOrderId');
  SetPropertyFromNode(node,'customerEmailId');
  SetDateTimePropertyFromNode(node,'orderDate');
  SetPropertyFromNode(node,'BuyerId');
  SetPropertyFromNode(node,'Mart');
  SetBooleanPropertyFromNode(node,'IsGuest');
  SetPropertyFromNode(node,'Shippingphone');
  SetDateTimePropertyFromNode(node,'estimatedDeliveryDate');
  SetDateTimePropertyFromNode(node,'estimatedShipDate');
  SetPropertyFromNode(node,'ShippingMethod');
  SetPropertyFromNode(node,'CustomerName');
  SetPropertyFromNode(node,'PostalAddressName');
  SetPropertyFromNode(node,'PostalAddressAddress1');
  SetPropertyFromNode(node,'PostalAddressAddress2');
  SetPropertyFromNode(node,'PostalAddressCity');
  SetPropertyFromNode(node,'PostalAddressstate');
  SetPropertyFromNode(node,'PostalAddressPostcode');
  SetPropertyFromNode(node,'PostalAddressCountry');
  SetPropertyFromNode(node,'PostalAddressAddresstype');
  SetPropertyFromNode(node,'SalesSource');
  SetPropertyFromNode(node,'ERPSalesRef');
  SetPropertyFromNode(node,'ValidateOrderStatusCode');
end;

procedure TWalmartOrders.MakeERPSOForWalmartforWalmartOrder;
begin
        fsMakeWalmartOrderStatus := WalmartOrderStatus_ERPSOCreated;
        try
          MakeWalmartOrderStatus;
        finally
          fsMakeWalmartOrderStatus := '';
        end;
end;

procedure TWalmartOrders.MakeWalmartOrderStatus;
begin
  Lines.Refreshdb;// this is to make sure if LINESACTIVE is used to update anything
  Lines.iteraterecords(MakeWalmartOrderStatusCallback);
end;
procedure TWalmartOrders.MakeWalmartOrderStatusCallback(Const Sender: TBusObj; Var Abort: Boolean);
var
  s:String;
begin
  s:= fsMakeWalmartOrderStatus;
  try
    if (sender is TWalmartOrderLines) and (fsMakeWalmartOrderStatus = '') then
      fsMakeWalmartOrderStatus := TWalmartOrderLines(sender).LineStatus;
    MakeWalmartOrderStatusForLine(Sender);
  finally
    fsMakeWalmartOrderStatus:= s;
  end;
end;

procedure TWalmartOrders.MakeWalmartOrderStatusForLine(Const Sender: TBusObj; aStatus :String = WalmartOrderStatus_Created);
function SOObj:TSalesOrder;
begin
  result := nil;
  if assigned(SO) then
    Result := TsalesOrder(SO);
end;
function LineStatus:String;
begin
  if fsMakeWalmartOrderStatus <> '' then result := fsMakeWalmartOrderStatus
  else result := aStatus;
end;
begin
    With TWalmartOrderLineStatus_ERP.create(self) do try
      Connection := self.connection;
      if  sender is TWalmartOrderLines then begin
          LoadSelect('WOID =' + inttostr(self.ID)+' and WOLineID =' + inttostr(TWalmartOrderLines(Sender).ID));
          //if count =0 then begin
          if (count=0) or (locate('Status', LineStatus , [])=false) then begin
            New;
            WOID := self.Id;
            WOLineID := TWalmartOrderLines(Sender).ID;
          end;
          ERPOriginalRef := ERPSalesRef;
          if TWalmartOrderLines(Sender).ERPSalesLineRef <> '' then ERPBaseLineno := TSalesOrderline.idtoggle(TWalmartOrderLines(Sender).ERPSalesLineRef, connection.connection);
          if ERPSalesRef <> '' then ERPID := TSalesOrder.idToggle(ERPSalesRef);
          ERPLineID :=ERPBaseLineno;
          PostDB;
          (*if fsMakeWalmartOrderStatus <> '' then Status :=fsMakeWalmartOrderStatus
          else Status := aStatus;*)
          Status := LineStatus;
          synched := fbWalmartOrderStatusSynched;
          PostDB;
      end else if Sender is TsalesorderLine then begin
          LoadSelect('WOID =' + inttostr(self.ID)+' and WOLineID =' + inttostr(SalesLineWOLineID(ERPBaseLineno)));
          if count =0 then begin
            New;
            if Assigned(TsalesorderLine(Sender).Owner) and (TsalesorderLine(Sender).Owner is TSalesOrder) then ERPOriginalRef :=TSalesOrder(TsalesorderLine(Sender).owner).globalref;
            ERPBaseLineno := TsalesorderLine(Sender).baselineno;
            if ERPBaseLineno =0 then ERPBaseLineno :=TsalesorderLine(Sender).ID;
            ERPLineId:= TsalesorderLine(Sender).ID;
            ERPID := TsalesorderLine(Sender).saleID;
            WOID := self.Id;
            WOLineID := SalesLineWOLineID(ERPBaseLineno);
            (*if fsMakeWalmartOrderStatus <> '' then Status :=fsMakeWalmartOrderStatus
            else Status := aStatus;*)
            Status := linestatus;
            PostDB;
          end;
      end;
    finally
      free;
    end;
end;
procedure TWalmartOrders.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'EmployeeName' ,EmployeeName);
  AddXMLNode(node,'purchaseOrderId' ,purchaseOrderId);
  AddXMLNode(node,'customerOrderId' ,customerOrderId);
  AddXMLNode(node,'customerEmailId' ,customerEmailId);
  AddXMLNode(node,'orderDate' ,orderDate);
  AddXMLNode(node,'BuyerId' ,BuyerId);
  AddXMLNode(node,'Mart' ,Mart);
  AddXMLNode(node,'IsGuest' ,IsGuest);
  AddXMLNode(node,'Shippingphone' ,Shippingphone);
  AddXMLNode(node,'estimatedDeliveryDate' ,estimatedDeliveryDate);
  AddXMLNode(node,'estimatedShipDate' ,estimatedShipDate);
  AddXMLNode(node,'ShippingMethod' ,ShippingMethod);
  AddXMLNode(node,'CustomerName' ,CustomerName);
  AddXMLNode(node,'PostalAddressName' ,PostalAddressName);
  AddXMLNode(node,'PostalAddressAddress1' ,PostalAddressAddress1);
  AddXMLNode(node,'PostalAddressAddress2' ,PostalAddressAddress2);
  AddXMLNode(node,'PostalAddressCity' ,PostalAddressCity);
  AddXMLNode(node,'PostalAddressstate' ,PostalAddressstate);
  AddXMLNode(node,'PostalAddressPostcode' ,PostalAddressPostcode);
  AddXMLNode(node,'PostalAddressCountry' ,PostalAddressCountry);
  AddXMLNode(node,'PostalAddressAddresstype' ,PostalAddressAddresstype);
  AddXMLNode(node,'SalesSource' ,SalesSource);
  AddXMLNode(node,'ERPSalesRef' ,ERPSalesRef);
  AddXMLNode(node,'ValidateOrderStatusCode' ,ValidateOrderStatusCode);
end;


function TWalmartOrders.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TWalmartOrders.ValidateOrder: Boolean;
begin
  Result := False;
  ValidateOrderStatusCode := vosNotValidated;
  fsExchangeCode:= '';
  fsValidateOrderStatusMsg:= '';
  Lines.iteraterecords(ValidateOrderCallback);
  if ValidateOrderStatusCode = vosNotValidated then  ValidateOrderStatusCode :=  vosOk; // this means all lines had valid charges
  Result := ValidateOrderStatusCode =  vosOk;
end;
Procedure TWalmartOrders.ValidateOrderCallback(Const Sender: TBusObj; Var Abort: Boolean);
begin
  if not (Sender is  TWalmartOrderLines) then exit;

  if TWalmartOrderLines(Sender).ProductnameforERP = '' then begin
     fsValidateOrderStatusMsg :=Appenv.comPanyprefs.WALMART_ProductNameFieldNAme + ' from Walmart is Choosen as ERP Prpductname. ' + Appenv.comPanyprefs.WALMART_ProductNameFieldNAme + ' is Blank.';
     Abort := True;
     Exit;
  end;

  if devmode then begin
    TProductSimple.ChecknMakeProduct(TWalmartOrderLines(Sender).ProductnameforERP);
  end;

  if (TWalmartOrderLines(Sender).ProductnameforERP = '') or (TProductSimple.idtoggle(TWalmartOrderLines(Sender).ProductnameforERP)=0) then begin
     TWalmartOrderLines(Sender).InitValidateOrderStatusCode(vosInvalidProduct);
     if TWalmartOrderLines(Sender).ProductnameforERP  ='' then fsValidateOrderStatusMsg :='Product Name is Blank'
     else fsValidateOrderStatusMsg :='Product '+ quotedstr(TWalmartOrderLines(Sender).ProductnameforERP)+' doesn''t exist';
     Abort := True;
     Exit;
  end;
  if TWalmartOrderLines(Sender).LineCharges.count =0 then begin
     fsValidateOrderStatusMsg :='Order #' + inttostr(ID)+' has no Lines';
     TWalmartOrderLines(Sender).InitValidateOrderStatusCode(vosOk);
     Abort := True;
     Exit;
  end;

  if TWalmartOrderLines(Sender).LineCharges.count >1 then begin
     TWalmartOrderLines(Sender).InitValidateOrderStatusCode(vosMultipleFxinLine);
     fsValidateOrderStatusMsg :='Product #' + quotedstr(TWalmartOrderLines(Sender).ProductnameforERP);
     Abort := True;
     Exit;
  end;
  if (fsExchangeCode<> '') and (fsExchangeCode <> TWalmartOrderLines(Sender).LineCharges.ChargeCurrency) and (TWalmartOrderLines(Sender).LineCharges.ChargeCurrency<> '') then begin
     TWalmartOrderLines(Sender).InitValidateOrderStatusCode(vosMultipleFxinOrder);
     //fsValidateOrderStatusMsg :='Product #' + quotedstr(TWalmartOrderLines(Sender).ProductnameforERP);
     fsValidateOrderStatusMsg :=quotedstr(fsExchangeCode) +' and ' + quotedstr(TWalmartOrderLines(Sender).LineCharges.ChargeCurrency);
     Abort := True;
     Exit;
  end;
  if (TWalmartOrderLines(Sender).LineCharges.TaxCurrency<> '') and (TWalmartOrderLines(Sender).LineCharges.ChargeCurrency<>'') and  (TWalmartOrderLines(Sender).LineCharges.TaxCurrency <> TWalmartOrderLines(Sender).LineCharges.ChargeCurrency) then begin
     TWalmartOrderLines(Sender).InitValidateOrderStatusCode(vosFxVarriesinLinenTax);
     Abort := True;
     Exit;
  end;
  if TWalmartOrderLines(Sender).LineCharges.taxName <> '' then
    if TTaxCode.IDToggle(TWalmartOrderLines(Sender).LineCharges.taxName ,True,TTaxCode) =0 then begin
       TWalmartOrderLines(Sender).InitValidateOrderStatusCode(vosInvalidTaxCode);
       Abort := True;
       Exit;
    end;
  if fsExchangeCode = '' then fsExchangeCode :=  TWalmartOrderLines(Sender).LineCharges.ChargeCurrency;
  if fsExchangeCode = '' then fsExchangeCode := TWalmartOrderLines(Sender).LineCharges.TaxCurrency;
  TWalmartOrderLines(Sender).InitValidateOrderStatusCode(vosOk);
end;

function TWalmartOrders.ValidateOrderStatusMSG: String;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    Qry.sql.text :='select vosCodeToMsg(' + inttostr(ValidateOrderStatusCode)+') as ValidateOrderStatusMsg';
    Qry.open;
    REsult := Qry.fieldbyname('ValidateOrderStatusMsg').asString;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
  Result := Trim(result +NL+fsValidateOrderStatusMsg);
end;

function TWalmartOrders.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TWalmartOrders.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TWalmartOrders.DoFieldOnChange(Sender: TField);
begin
  If (Sender.FieldKind <> FkData) Or Dataset.ControlsDisabled Then
    If Not DoFieldChangewhenDisabled Then Exit; // we are only interested in data fields.

  inherited;
  if Sysutils.SameText(Sender.FieldName, 'ValidateOrderStatusCode') then begin

  end;
end;


function TWalmartOrders.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TWalmartOrders.GetIDField: string;
begin
  Result := 'OrderId'
end;


function TWalmartOrders.getIsAcknowledged: Boolean;
begin
  REsult := False;
  If Lines.count=0 then Exit;
  fbIsAcknowledged:= False;
  try
    Lines.Iteraterecords(IsAcknowledgedcheckCallback);
  finally
    result := fbIsAcknowledged;
  end;
end;
Procedure TWalmartOrders.IsAcknowledgedcheckCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if sender is TWalmartOrderLines then begin
    if TWalmartOrderLines(sender).linestatuses.count =0 then exit;
    TWalmartOrderLines(sender).linestatuses.Iteraterecords(IsAcknowledgedcheckCallback);
    if fbIsAcknowledged then begin
      Abort := True;
      Exit;
    end;
  end else if sender is TWalmartOrderlineStatus then begin
    if (TWalmartOrderlineStatus(Sender).orderstatus <> '') and  (TWalmartOrderlineStatus(Sender).orderstatus <> WalmartOrderStatus_Ordered) and (TWalmartOrderlineStatus(Sender).orderstatus <> WalmartOrderStatus_Created)  then
      if  (TWalmartOrderlineStatus(Sender).orderstatus =WalmartOrderStatus_Acknowledged) or
          (TWalmartOrderlineStatus(Sender).orderstatus =WalmartOrderStatus_Cancelled) or
          (TWalmartOrderlineStatus(Sender).orderstatus =WalmartOrderStatus_ERPSOCreated) or
          (TWalmartOrderlineStatus(Sender).orderstatus =WalmartOrderStatus_ERPBO) or
          (TWalmartOrderlineStatus(Sender).orderstatus =WalmartOrderStatus_Scheduled) or
          (TWalmartOrderlineStatus(Sender).orderstatus =WalmartOrderStatus_Built) or
          (TWalmartOrderlineStatus(Sender).orderstatus =WalmartOrderStatus_Shipped) then begin
        fbIsAcknowledged := True;
        Abort := True;
        Exit;
      end;
  end;
end;
function TWalmartOrders.getLines: TWalmartOrderLines;
begin
  Result := TWalmartOrderLines(Getcontainercomponent(TWalmartOrderLines , 'OrderId = '+ inttostr(ID)));
end;

function TWalmartOrders.getLinesActive: TWalmartOrderLinesActive;
begin
  Result := TWalmartOrderLinesActive(Getcontainercomponent(TWalmartOrderLinesActive , 'WOL.OrderId = '+ inttostr(ID)));
end;
function TWalmartOrders.getWalmartOrderStatus: TWalmartOrderLineStatus_ERP;
begin
  Result := TWalmartOrderLineStatus_ERP(Getcontainercomponent(TWalmartOrderLineStatus_ERP , 'WOID = '+ inttostr(ID)));
end;

class function TWalmartOrders.GetBusObjectTablename: string;
begin
  Result:= 'tblWalmartorders';
end;


function TWalmartOrders.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  EmployeeName := AppEnv.Employee.employeename;
  ValidateOrderStatusCode := vosNotValidated;
end;

function TWalmartOrders.DoAfteropen(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfteropen(Sender);
  if not result then exit;
  MakeWalmartOrderStatus;
end;

function TWalmartOrders.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
procedure TWalmartOrders.DoEvent(const Sender: TObject;const EventType: integer; const Data: TObject; Proc: TProcBusObjBase);
begin
  inherited;

end;

function TWalmartOrders.getSalesOrderID: Integer;
begin
  REsult := 0;
  if ERPSalesRef = '' then exit;
  result := TSalesorder.IDToggle(ERPSalesRef);
end;

{Property Functions}
function  TWalmartOrders.GetEmployeeName            : string    ; begin Result := GetStringField('EmployeeName');end;
function  TWalmartOrders.GetpurchaseOrderId         : string    ; begin Result := GetStringField('purchaseOrderId');end;
function  TWalmartOrders.GetcustomerOrderId         : string    ; begin Result := GetStringField('customerOrderId');end;
function  TWalmartOrders.GetcustomerEmailId         : string    ; begin Result := GetStringField('customerEmailId');end;
function  TWalmartOrders.GetorderDate               : TDateTime ; begin Result := GetDateTimeField('orderDate');end;
function  TWalmartOrders.getBuyerId                 : Integer   ; begin Result := Getintegerfield('BuyerId');end;
function  TWalmartOrders.GetMart                    : string    ; begin Result := GetStringField('Mart');end;
function  TWalmartOrders.GetIsGuest                 : Boolean   ; begin Result := GetBooleanField('IsGuest');end;
function  TWalmartOrders.GetShippingphone           : string    ; begin Result := GetStringField('Shippingphone');end;
function  TWalmartOrders.GetestimatedDeliveryDate   : TDateTime ; begin Result := GetDateTimeField('estimatedDeliveryDate');end;
function  TWalmartOrders.GetestimatedShipDate       : TDateTime ; begin Result := GetDateTimeField('estimatedShipDate');end;
function  TWalmartOrders.GetShippingMethod          : string    ; begin Result := GetStringField('ShippingMethod');end;
function  TWalmartOrders.GetCustomerName            : string    ; begin Result := GetStringField('CustomerName');end;
function  TWalmartOrders.GetPostalAddressName       : string    ; begin Result := GetStringField('PostalAddressName');end;
function  TWalmartOrders.GetPostalAddressAddress1   : string    ; begin Result := GetStringField('PostalAddressAddress1');end;
function  TWalmartOrders.GetPostalAddressAddress2   : string    ; begin Result := GetStringField('PostalAddressAddress2');end;
function  TWalmartOrders.GetPostalAddressCity       : string    ; begin Result := GetStringField('PostalAddressCity');end;
function  TWalmartOrders.GetPostalAddressstate      : string    ; begin Result := GetStringField('PostalAddressstate');end;
function  TWalmartOrders.GetPostalAddressPostcode   : string    ; begin Result := GetStringField('PostalAddressPostcode');end;
function  TWalmartOrders.GetPostalAddressCountry    : string    ; begin Result := GetStringField('PostalAddressCountry');end;
function  TWalmartOrders.GetPostalAddressAddresstype: string    ; begin Result := GetStringField('PostalAddressAddresstype');end;
function  TWalmartOrders.GetSalesSource             : string    ; begin Result := GetStringField('SalesSource');end;
function  TWalmartOrders.GetERPSalesRef             : string    ; begin Result := GetStringField('ERPSalesRef');end;
function  TWalmartOrders.getValidateOrderStatusCode : Integer   ; begin Result := Getintegerfield('ValidateOrderStatusCode');end;
procedure TWalmartOrders.SetEmployeeName            (const Value: string    ); begin SetStringField('EmployeeName'             , Value);end;
procedure TWalmartOrders.SetpurchaseOrderId         (const Value: string    ); begin SetStringField('purchaseOrderId'          , Value);end;
procedure TWalmartOrders.SetcustomerOrderId         (const Value: string    ); begin SetStringField('customerOrderId'          , Value);end;
procedure TWalmartOrders.SetcustomerEmailId         (const Value: string    ); begin SetStringField('customerEmailId'          , Value);end;
procedure TWalmartOrders.SetorderDate               (const Value: TDateTime ); begin SetDateTimeField('orderDate'                , Value);end;
procedure TWalmartOrders.SetBuyerId                 (const Value: Integer   ); begin SetIntegerField('BuyerId'                , Value);end;
procedure TWalmartOrders.SetMart                    (const Value: string    ); begin SetStringField('Mart'                   , Value);end;
procedure TWalmartOrders.SetIsGuest                 (const Value: Boolean   ); begin SetBooleanField('IsGuest'                   , Value);end;
procedure TWalmartOrders.SetShippingphone           (const Value: string    ); begin SetStringField('Shippingphone'            , Value);end;
procedure TWalmartOrders.SetestimatedDeliveryDate   (const Value: TDateTime ); begin SetDateTimeField('estimatedDeliveryDate'    , Value);end;
procedure TWalmartOrders.SetestimatedShipDate       (const Value: TDateTime ); begin SetDateTimeField('estimatedShipDate'        , Value);end;
procedure TWalmartOrders.SetShippingMethod          (const Value: string    ); begin SetStringField('ShippingMethod'           , Value);end;
procedure TWalmartOrders.SetCustomerName            (const Value: string    ); begin SetStringField('CustomerName'             , Value);end;
procedure TWalmartOrders.SetPostalAddressName       (const Value: string    ); begin SetStringField('PostalAddressName'        , Value);end;
procedure TWalmartOrders.SetPostalAddressAddress1   (const Value: string    ); begin SetStringField('PostalAddressAddress1'    , Value);end;
procedure TWalmartOrders.SetPostalAddressAddress2   (const Value: string    ); begin SetStringField('PostalAddressAddress2'    , Value);end;
procedure TWalmartOrders.SetPostalAddressCity       (const Value: string    ); begin SetStringField('PostalAddressCity'        , Value);end;
procedure TWalmartOrders.SetPostalAddressstate      (const Value: string    ); begin SetStringField('PostalAddressstate'       , Value);end;
procedure TWalmartOrders.SetPostalAddressPostcode   (const Value: string    ); begin SetStringField('PostalAddressPostcode'    , Value);end;
procedure TWalmartOrders.SetPostalAddressCountry    (const Value: string    ); begin SetStringField('PostalAddressCountry'     , Value);end;
procedure TWalmartOrders.SetPostalAddressAddresstype(const Value: string    ); begin SetStringField('PostalAddressAddresstype' , Value);end;
procedure TWalmartOrders.SetSalesSource             (const Value: string    ); begin SetStringField('SalesSource'              , Value);end;
procedure TWalmartOrders.SetERPSalesRef             (const Value: string    ); begin SetStringField('ERPSalesRef'              , Value);end;
procedure TWalmartOrders.SetValidateOrderStatusCode (const Value: Integer   ); begin SetIntegerField('ValidateOrderStatusCode' , Value);end;

  (*//clog(XMLOrder.XML);
  clog('POID#' +XMLOrder.PurchaseOrderId);
  Logtext('CustomerOrderId #' + XMLOrder.CustomerOrderId);
  Logtext('CustomerEmailId #' + XMLOrder.CustomerEmailId);
  Logtext('OrderDate #' + XMLOrder.OrderDate);
  Logtext('BuyerId #' + XMLOrder.BuyerId);
  Logtext('Mart #' + XMLOrder.Mart);
  Logtext('IsGuest #' + iif(XMLOrder.IsGuest , 'T' , 'F'));
  Logtext('phone #' + XMLOrder.ShippingInfo.Phone);
  Logtext('EstimatedDeliveryDate #' + XMLOrder.ShippingInfo.EstimatedDeliveryDate);
  Logtext('EstimatedShipDate #' + XMLOrder.ShippingInfo.EstimatedShipDate);
  Logtext('MethodCode #' + XMLOrder.ShippingInfo.MethodCode);
  Logtext('Name#' + XMLOrder.ShippingInfo.PostalAddress.Name);
  Logtext('Address1#' + XMLOrder.ShippingInfo.PostalAddress.Address1 );
  Logtext('Address2#' + XMLOrder.ShippingInfo.PostalAddress.Address2 );
  Logtext('City#' + XMLOrder.ShippingInfo.PostalAddress.City );
  Logtext('State#' + XMLOrder.ShippingInfo.PostalAddress.State );
  Logtext('PostalCode#' + XMLOrder.ShippingInfo.PostalAddress.PostalCode );
  Logtext('Country#' + XMLOrder.ShippingInfo.PostalAddress.Country );
  Logtext('AddressType#' + XMLOrder.ShippingInfo.PostalAddress.AddressType );*)



  {TWalmartOrderLineRefundCharges}

constructor TWalmartOrderLineRefundCharges.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'walmartorderlinerefundcharges';
  fSQL := 'SELECT * FROM tblwalmartorderlinerefundcharges';
end;


destructor TWalmartOrderLineRefundCharges.Destroy;
begin
  inherited;
end;


procedure TWalmartOrderLineRefundCharges.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'OrderId');
  SetPropertyFromNode(node,'OrderLineId');
  SetPropertyFromNode(node,'RefundID');
  SetPropertyFromNode(node,'RefundReason');
  SetPropertyFromNode(node,'Chargetype');
  SetPropertyFromNode(node,'ERPRefundRef');
  SetPropertyFromNode(node,'ChargeName');
  SetPropertyFromNode(node,'ChargeAmount');
  SetPropertyFromNode(node,'taxName');
  SetPropertyFromNode(node,'taxCurrency');
  SetPropertyFromNode(node,'TaxAmount');
end;


function TWalmartOrderLineRefundCharges.MakeERPREfund: Boolean;
var
  RefundObj :TRefundSale;
  qry: TERPQuery;
  inv:TInvoice;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    Qry.SQL.text := 'select RF.* , Inv.* , invSL.* from tblwalmartorderlinerefundcharges RF ' +
                    ' inner join tblwalmartorderlines WOL on WOL.OrderLineId = RF.OrderLineId ' +
                    ' inner join tblsaleslines SL on SL.GlobalRef = WOL.ERPSalesLineRef ' +
                    ' inner join tblsales S on SL.SaleID = S.SaleID ' +
                    ' inner join tblsales Inv on S.GlobalRef = Inv.SalesOrderGlobalRef ' +
                    ' inner join tblsaleslines InvSL on InvSL.SaleID = Inv.SaleID and InvSL.ProductID = SL.ProductID and InvSL.SeqNo = SL.SeqNo ' +
                    ' Where RF.OrderLineRefundChargeID = '+ inttostr(ID);
    Qry.Open;
    if Qry.recordcount >0 then begin

        RefundObj := TRefundSale.CreateWithNewConn(nil);
        Inv :=TInvoice.Create(RefundObj);
        try
            Inv.Connection := RefundObj.Connection;
            Inv.Load(Qry.FieldByName('SaleID').AsInteger);
            if (Inv.Count>0) and (Inv.Lines.Locate('SaleLineID' , Qry.FieldByName('SalelineId').AsInteger , [])) then begin
              RefundObj.Connection.beginTransaction;
              RefundObj.Load(0);
              RefundObj.New;
              RefundObj.ClientId := Inv.ClientID;
              if RefundObj.ForeignExchangeCode ='' then RefundObj.ForeignExchangeCode := Qry.fieldByname('ChargeCurrency').AsString;
              if RefundObj.ForeignExchangeCode ='' then RefundObj.ForeignExchangeCode := Qry.fieldByname('TaxCurrency').AsString;
              RefundObj.PostDB;

              RefundObj.Lines.New;
              RefundObj.Lines.productname := Qry.fieldByname('ProductName').AsString;
              if Qry.fieldByname('taxName').asString <> '' then
                if TTaxCode.IDToggle(Qry.fieldByname('taxName').asString ,True,TTaxCode) >0 then
                  RefundObj.Lines.LineTaxCode :=Qry.fieldByname('taxName').asString;


              RefundObj.Lines.UnitOfMeasure    := Qry.fieldByname('UnitofMeasureSaleLines').asString;
              RefundObj.Lines.RefundQty:= Qry.fieldByname('UnitofMeasureShipped').asFloat;

              if sametext(Qry.fieldByname('Chargetype').AsString, 'PRODUCT') then
                    RefundObj.Lines.linepriceinc :=Qry.fieldByname('ChargeAmount').AsFloat
              else  RefundObj.Lines.TotalLineAmountinc:=Qry.fieldByname('ChargeAmount').AsFloat;

              RefundObj.Lines.AllowTaxinput := true;  // the tax is not accepted otherwise , and gets recalculated
              try
                RefundObj.Lines.LineTaxTotal :=Qry.fieldByname('TaxAmount').asFloat;
              finally
                RefundObj.Lines.AllowTaxinput := False;
              end;

              RefundObj.Lines.RefundedSalesLineID := Inv.Lines.ID;
              RefundObj.Lines.PostDB;
              Inv.Lines.PQA.CopyAllocation(RefundObj.Lines.PQA.ID, false);
              RefundObj.Lines.PostDB;
              if RefundObj.Save then begin
                ERPRefundRef :=RefundObj.Globalref;
                PostDB;
                RefundObj.Connection.CommitTransaction;
                result := True;
                Exit;
              end;
            end;
            RefundObj.Connection.RollbackTransaction;
        finally
          Freeandnil(RefundObj);
        end;
      end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TWalmartOrderLineRefundCharges.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'OrderId' ,OrderId);
  AddXMLNode(node,'OrderLineId' ,OrderLineId);
  AddXMLNode(node,'RefundID' ,RefundID);
  AddXMLNode(node,'RefundReason' ,RefundReason);
  AddXMLNode(node,'Chargetype' ,Chargetype);
  AddXMLNode(node,'ERPRefundRef' ,ERPRefundRef);
  AddXMLNode(node,'ChargeName' ,ChargeName);
  AddXMLNode(node,'ChargeAmount' ,ChargeAmount);
  AddXMLNode(node,'taxName' ,taxName);
  AddXMLNode(node,'taxCurrency' ,taxCurrency);
  AddXMLNode(node,'TaxAmount' ,TaxAmount);
end;


function TWalmartOrderLineRefundCharges.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if OrderId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'OrderId should not be 0' , true );
    Exit;
  end;
  if OrderLineId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'OrderLineId should not be 0' , true );
    Exit;
  end;
  Result := True;
end;


function TWalmartOrderLineRefundCharges.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TWalmartOrderLineRefundCharges.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TWalmartOrderLineRefundCharges.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TWalmartOrderLineRefundCharges.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TWalmartOrderLineRefundCharges.GetIDField: string;
begin
  Result := 'OrderLineRefundChargeID'
end;


class function TWalmartOrderLineRefundCharges.GetBusObjectTablename: string;
begin
  Result:= 'tblwalmartorderlinerefundcharges';
end;


function TWalmartOrderLineRefundCharges.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if Owner is TWalmartOrderLines then begin
      OrderId := TWalmartOrderLines(Owner).OrderID;
      OrderLineId := TWalmartOrderLines(Owner).ID;
      RefundId :=TWalmartOrderLines(Owner).RefundID;
    end;
end;

function TWalmartOrderLineRefundCharges.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{Property Functions}
function  TWalmartOrderLineRefundCharges.GetOrderId          : Integer   ; begin Result := GetIntegerField('OrderId');end;
function  TWalmartOrderLineRefundCharges.GetOrderLineId      : Integer   ; begin Result := GetIntegerField('OrderLineId');end;
function  TWalmartOrderLineRefundCharges.GetRefundID         : Integer   ; begin Result := GetIntegerField('RefundID');end;
function  TWalmartOrderLineRefundCharges.GetRefundReason     : string    ; begin Result := GetStringField('RefundReason');end;
function  TWalmartOrderLineRefundCharges.GetChargetype       : string    ; begin Result := GetStringField('Chargetype');end;
function  TWalmartOrderLineRefundCharges.GetERPRefundRef     : string    ; begin Result := GetStringField('ERPRefundRef');end;
function  TWalmartOrderLineRefundCharges.GetChargeName       : string    ; begin Result := GetStringField('ChargeName');end;
function  TWalmartOrderLineRefundCharges.GetChargeAmount     : Double    ; begin Result := GetFloatField('ChargeAmount');end;
function  TWalmartOrderLineRefundCharges.GetChargeCurrency   : string    ; begin Result := GetStringField('ChargeCurrency');end;
function  TWalmartOrderLineRefundCharges.GettaxName          : string    ; begin Result := GetStringField('taxName');end;
function  TWalmartOrderLineRefundCharges.GettaxCurrency      : string    ; begin Result := GetStringField('taxCurrency');end;
function  TWalmartOrderLineRefundCharges.GetTaxAmount        : Double    ; begin Result := GetFloatField('TaxAmount');end;
procedure TWalmartOrderLineRefundCharges.SetOrderId          (const Value: Integer   ); begin SetIntegerField('OrderId'           , Value);end;
procedure TWalmartOrderLineRefundCharges.SetOrderLineId      (const Value: Integer   ); begin SetIntegerField('OrderLineId'       , Value);end;
procedure TWalmartOrderLineRefundCharges.SetRefundID         (const Value: Integer   ); begin SetIntegerField('RefundID'          , Value);end;
procedure TWalmartOrderLineRefundCharges.SetRefundReason     (const Value: string    ); begin SetStringField('RefundReason'      , Value);end;
procedure TWalmartOrderLineRefundCharges.SetChargetype       (const Value: string    ); begin SetStringField('Chargetype'        , Value);end;
procedure TWalmartOrderLineRefundCharges.SetERPRefundRef     (const Value: string    ); begin SetStringField('ERPRefundRef'      , Value);end;
procedure TWalmartOrderLineRefundCharges.SetChargeName       (const Value: string    ); begin SetStringField('ChargeName'        , Value);end;
procedure TWalmartOrderLineRefundCharges.SetChargeAmount     (const Value: Double    ); begin SetFloatField('ChargeAmount'      , Value);end;
procedure TWalmartOrderLineRefundCharges.SetChargeCurrency   (const Value: string    ); begin SetStringField('ChargeCurrency'    , Value);end;
procedure TWalmartOrderLineRefundCharges.SettaxName          (const Value: string    ); begin SetStringField('taxName'           , Value);end;
procedure TWalmartOrderLineRefundCharges.SettaxCurrency      (const Value: string    ); begin SetStringField('taxCurrency'       , Value);end;
procedure TWalmartOrderLineRefundCharges.SetTaxAmount        (const Value: Double    ); begin SetFloatField('TaxAmount'        , Value);end;


{ TWalmartOrderLinesActive }

constructor TWalmartOrderLinesActive.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription:= 'WalmartOrderLinesActive';
  fSQL:= 'SELECT distinct WOL.* ' +
          ' FROM tblWalmartOrderLines WOL left join tblWalmartOrderStatus_ERP WOLS on WOL.OrderLineId = WOLS.WOLineID' +
          ' where (ifnull(WOLS.ID,0) = 0 or ifnull(WOLS.Status  , "")<> '+ quotedstr(WalmartOrderStatus_Cancelled)+')';
end;

function TWalmartOrderLinesActive.GetSQL: string;
begin
  result := inherited  GetSQL;
end;

initialization
  RegisterClass(TWalmartOrderLineRefundCharges);

  RegisterClass(TWalmartOrders);
  RegisterClass(TWalmartOrderLines);
  RegisterClass(TWalmartOrderLinesActive);
  RegisterClass(TWalmartOrderlineStatus);
  RegisterClass(TWalmartOrderLineCharges);


end.
