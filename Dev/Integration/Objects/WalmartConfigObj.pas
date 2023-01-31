unit WalmartConfigObj;

interface

uses
  JsonDbPrefsConfigObj, MyAccess, DB;

{WMR = Walmart
API Explorer : https://developer.walmart.com/#/apicenter/marketPlace/latest#introduction}

const
(*    WMR_SKU_Filter 						=  'sku={sku}';
    WMR_CustID_Filter 				=  'customerOrderId={customerOrderId}';
    WMR_POID_Filter 					=  'purchaseOrderId={purchaseOrderId}';
    WMR_Status_Filter 				=  'status={status}';
    WMR_CreateStartDate_Filter=  'createdStartDate={createdStartDate}';
    WMR_CreateEndDate_Filter 	=  'createdEndDate={createdEndDate}';
    WMR_ExpShipdateFrom_Filter=  'fromExpectedShipDate={fromExpectedShipDate}';
    WMR_ExpShipdateTo_Filter 	=  'toExpectedShipDate={toExpectedShipDate}';
    WMR_Limit_Filter 					=  'limit={limit}';
    WMR_ShipProgType_Filter 	=  'shippingProgramType={shippingProgramType}';
    WMR_shipNodetype_Filter 	=  'shipNodeType={shipNodeType}';
    WMR_NextCursor            =  '{nextCursor}';
    WMR_FeedID                =  '{feedId}';*)

    {Production URLs}
    {POST} WMR_Prod_Token_URL             = 'https://marketplace.walmartapis.com/v3/token';
    {GET}  WMR_Prod_Order_Released_URL       = 'https://marketplace.walmartapis.com/v3/orders/released'(*+'?'+ WMR_CreateStartDate_Filter +
                                                                                                  '&' + WMR_Limit_Filter +
                                                                                                  '&' + WMR_ShipProgType_Filter +
                                                                                                  '&'+ WMR_shipNodetype_Filter *);
    {GET}  WMR_Prod_Order_Released_Cont_URL  = 'https://marketplace.walmartapis.com/v3/orders/released'(*+'?'+ WMR_NextCursor *);
    {GET}  WMR_Prod_Order_All_URL            = 'https://marketplace.walmartapis.com/v3/orders'(*+'?'+WMR_SKU_Filter+
                                                                                        '&'+WMR_CustID_Filter+
                                                                                        '&'+WMR_POID_Filter+
                                                                                        '&'+WMR_Status_Filter+
                                                                                        '&'+ WMR_CreateStartDate_Filter +
                                                                                        '&'+ WMR_CreateEndDate_Filter +
                                                                                        '&'+ WMR_ExpShipdateFrom_Filter +
                                                                                        '&'+ WMR_ExpShipdateTo_Filter +
                                                                                        '&' + WMR_Limit_Filter +
                                                                                        '&' + WMR_ShipProgType_Filter +
                                                                                        '&'+ WMR_shipNodetype_Filter *);

    {GET}  WMR_Prod_Order_All_cont_URL              = 'https://marketplace.walmartapis.com/v3/orders'(*+'?'+ WMR_NextCursor *);
    {GET}  WMR_Prod_Order_Single_URL                = 'https://marketplace.walmartapis.com/v3/orders/{purchaseOrderId}';
    {POST} WMR_Prod_Order_Ack_URL                   = 'https://marketplace.walmartapis.com/v3/orders/{purchaseOrderId}/acknowledge';
    {POST} WMR_Prod_Order_Cancel_URL                = 'https://marketplace.walmartapis.com/v3/orders/{purchaseOrderId}/cancel';
    {POST} WMR_Prod_Order_Refund_URL                = 'https://marketplace.walmartapis.com/v3/orders/{purchaseOrderId}/refund';
    {POST} WMR_Prod_Order_Shipping_URL              = 'https://marketplace.walmartapis.com/v3/orders/{purchaseOrderId}/shipping';
    {GET}  WMR_Prod_FeedStatus_URL                  = 'https://marketplace.walmartapis.com/v3/feeds/'(*+ WMR_FeedID*);

    {sandfox URLS}
    {POST} WMR_Sandbox_Token_URL                    = 'https://sandbox.walmartapis.com/v3/token'    ;
    {GET}  WMR_Sandbox_Order_Released_URL           = 'https://sandbox.walmartapis.com/v3/orders/released'(*+'?'+ WMR_CreateStartDate_Filter +
                                                                                                   '&' + WMR_Limit_Filter *);
    {GET}  WMR_Sandbox_Order_Released_Cont_URL      = 'https://sandbox.walmartapis.com/v3/orders/released'(*+'?'+ WMR_NextCursor *);
    {GET}  WMR_Sandbox_Order_All_URL                = 'https://sandbox.walmartapis.com/v3/orders'(*+'?'+WMR_SKU_Filter+
                                                                                          '&'+WMR_CustID_Filter+
                                                                                          '&'+WMR_POID_Filter+
                                                                                          '&'+WMR_Status_Filter+
                                                                                          '&'+ WMR_CreateStartDate_Filter +
                                                                                          '&'+ WMR_CreateEndDate_Filter +
                                                                                          '&'+ WMR_ExpShipdateFrom_Filter +
                                                                                          '&'+ WMR_ExpShipdateTo_Filter +
                                                                                          '&' + WMR_Limit_Filter *);
    {GET}  WMR_Sandbox_Order_All_cont_URL           = 'https://sandbox.walmartapis.com/v3/orders'(*+'?'+ WMR_NextCursor *);
    {GET}  WMR_Sandbox_Order_Single_URL             = 'https://sandbox.walmartapis.com/v3/orders/{purchaseOrderId}';
    {GET}  WMR_Sandbox_Order_Ack_URL                = 'https://sandbox.walmartapis.com/v3/orders/{purchaseOrderId}/acknowledge';
    {POST} WMR_Sandbox_Order_Cancel_URL             = 'https://sandbox.walmartapis.com/v3/orders/{purchaseOrderId}/cancel';
    {POST} WMR_Sandbox_Order_Refund_URL             = 'https://sandbox.walmartapis.com/v3/orders/{purchaseOrderId}/refund';
    {POST} WMR_Sandbox_Order_Shipping_URL           = 'https://sandbox.walmartapis.com/v3/orders/{purchaseOrderId}/shipping';
    {GET}  WMR_SandBox_FeedStatus_URL               = 'https://sandbox.marketplace.walmartapis.com/v3/feeds/'(*+ WMR_FeedID*);

type
  TWalmartConfig =  class(TJsonDbPefConfig)
    Private
    Function GetEnableWalmart           : Boolean;
    Function GetShowWalmartOnMainMenu   : Boolean;
    Function GetAutosynchList           : Boolean;
    Function GetUseSandbox              : Boolean;
    Function GetUseProduction           : Boolean;
    function getClientID                : String;
    function getSandBoxClientID         : String;
    function getProductionClientID      : String;
    function getClientSecret            : String;
    function getSandBoxClientSecret     : String;
    function getProductionClientSecret  : String;
    function getAuth_token              : String;
    function getsynchAccount            : String;
    function getsynchAccountDescription : String;

    Procedure SetEnableWalmart          (Const Value: Boolean);
    Procedure SetShowWalmartOnMainMenu  (Const Value: Boolean);
    Procedure SetAutosynchList          (Const Value: Boolean);
    Procedure SetUseSandbox             (Const Value: Boolean);
    Procedure SetUseProduction          (Const Value: Boolean);
    procedure SetClientID               (const Value: String);
    procedure SetSandBoxClientID        (const Value: String);
    procedure SetProductionClientID     (const Value: String);
    procedure SetClientSecret           (const Value: String);
    procedure SetSandBoxClientSecret    (const Value: String);
    procedure SetProductionClientSecret (const Value: String);
    procedure SetAuth_token             (const Value: String);
    procedure SetsynchAccount           (const Value: String);
    function getOrdersSynchedUntil: TDatetime;
    procedure SetOrdersSynchedUntil(const Value: TDateTime);

    Protected
    Public
      constructor Create; override;
      procedure Load(connection: TMyConnection); overload; override;
      procedure Load(ds: TDataset); overload; override;

      Property EnableWalmart          : Boolean   read getEnableWalmart           Write SetEnableWalmart;
      Property ShowWalmartOnMainMenu  : Boolean   read getShowWalmartOnMainMenu   Write SetShowWalmartOnMainMenu;
      Property AutosynchList          : Boolean   read getAutosynchList           Write SetAutosynchList;
      Property UseSandbox             : Boolean   read getUseSandbox              Write SetUseSandbox;
      Property UseProduction          : Boolean   read getUseProduction           Write SetUseProduction;
      Property ClientID               : String    read getClientID                write SetClientID;
      Property SandBoxClientID        : String    read getSandBoxClientID         write SetSandBoxClientID;
      Property ProductionClientID     : String    read getProductionClientID      write SetProductionClientID;
      Property ClientSecret           : String    read getClientSecret            write SetClientSecret;
      Property SandBoxClientSecret    : String    read getSandBoxClientSecret     write SetSandBoxClientSecret;
      Property ProductionClientSecret : String    read getProductionClientSecret  write SetProductionClientSecret;
      Property Auth_token             : String    read getAuth_token              write SetAuth_token;
      Property synchAccount           : String    read getsynchAccount            write SetsynchAccount;
      Property synchAccountDescription: String    read getsynchAccountDescription ;
      Property OrdersSynchedUntil     : TDateTime read getOrdersSynchedUntil       write SetOrdersSynchedUntil;
    Published

  end;

implementation

{ TWalmartConfig }

procedure TWalmartConfig.Load(connection: TMyConnection);
begin
  inherited;

end;


procedure TWalmartConfig.Load(ds: TDataset);
begin
  inherited;
end;
constructor TWalmartConfig.Create;
begin
  inherited;
end;

Function TWalmartConfig.GetEnableWalmart          : Boolean   ;begin result := B['EnableWalmart']         ;end;
Function TWalmartConfig.GetShowWalmartOnMainMenu  : Boolean   ;begin result := B['ShowWalmartOnMainMenu'] ;end;
Function TWalmartConfig.GetAutosynchList          : Boolean   ;begin result := B['AutosynchList']         ;end;
Function TWalmartConfig.GetUseSandbox             : Boolean   ;begin Result := synchAccount ='S'          ;end;
Function TWalmartConfig.GetUseProduction          : Boolean   ;begin Result := synchAccount ='P'          ;end;
function TWalmartConfig.getClientID               : String    ;begin result := S['ClientID']              ;end;
function TWalmartConfig.getSandBoxClientID        : String    ;begin result := S['SandBoxClientID']       ;end;
function TWalmartConfig.getProductionClientID     : String    ;begin result := S['ProductionClientID']    ;end;
function TWalmartConfig.getClientSecret           : String    ;begin result := S['ClientSecret']          ;end;
function TWalmartConfig.getSandBoxClientSecret    : String    ;begin result := S['SandBoxClientSecret']   ;end;
function TWalmartConfig.getProductionClientSecret : String    ;begin result := S['ProductionClientSecret'];end;
function TWalmartConfig.getAuth_token             : String    ;begin result := S['Auth_token']            ;end;
function TWalmartConfig.getsynchAccount           : String    ;begin result := S['synchAccount']          ;end;
function TWalmartConfig.getsynchAccountDescription: String    ;begin if SynchAccount = 'S' then Result := 'Sandbox' else Result := 'Production'; end;
function TWalmartConfig.getOrdersSynchedUntil     : TDatetime ;begin result := DT['OrdersSynchedUntil']   ;end;

Procedure TWalmartConfig.SetEnableWalmart         (Const Value: Boolean   ); begin B['EnableWalmart']          := Value ; end;
Procedure TWalmartConfig.SetShowWalmartOnMainMenu (Const Value: Boolean   ); begin B['ShowWalmartOnMainMenu']  := Value ; end;
Procedure TWalmartConfig.SetAutosynchList         (Const Value: Boolean   ); begin B['AutosynchList']          := Value ; end;
Procedure TWalmartConfig.SetUseSandbox            (Const Value: Boolean   ); begin if value then synchAccount := 'S' else synchAccount :='P'; end;
Procedure TWalmartConfig.SetUseProduction         (Const Value: Boolean   ); begin if value then synchAccount := 'P' else synchAccount :='S'; end;
procedure TWalmartConfig.SetClientID              (const Value: String    ); begin S['ClientID']               := Value ; end;
procedure TWalmartConfig.SetSandBoxClientID       (const Value: String    ); begin S['SandBoxClientID']        := Value ; end;
procedure TWalmartConfig.SetProductionClientID    (const Value: String    ); begin S['ProductionClientID']     := Value ; end;
procedure TWalmartConfig.SetClientSecret          (const Value: String    ); begin S['ClientSecret']           := Value ; end;
procedure TWalmartConfig.SetSandBoxClientSecret   (const Value: String    ); begin S['SandBoxClientSecret']    := Value ; end;
procedure TWalmartConfig.SetProductionClientSecret(const Value: String    ); begin S['ProductionClientSecret'] := Value ; end;
procedure TWalmartConfig.SetAuth_token            (const Value: String    ); begin S['Auth_token']             := Value ; end;
procedure TWalmartConfig.SetsynchAccount          (const Value: String    ); begin S['synchAccount']           := Value ; end;
procedure TWalmartConfig.SetOrdersSynchedUntil    (Const Value: TDateTime ); begin DT['OrdersSynchedUntil']    := Value ; end;


end.
