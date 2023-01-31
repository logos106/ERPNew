unit eBay_orderresponse;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes,  eBayBaseObj, ebay_orderresponse_ordererrors, eBay_orderresponse_PaginationResult, eBay_Orders;


type
  Tebay_orderresponse = class(TeBayObjBase)
  private
    fOrderResponse_OrderErrors      : TeBay_OrderResponse_OrderErrors;
    fOrderResponse_PaginationResult : Tebay_orderresponse_paginationresult;
    febay_orders                    : TeBay_Orders;
    function GetTimestamp                   : TDateTime ;
    function GetAck                         : string    ;
    function GetCorrelationID               : string    ;
    function GetMessage_                    : string    ;
    function GetVersion                     : string    ;
    function GetBuild                       : string    ;
    function GetNotificationEventName       : string    ;
    function GetRecipientUserID             : string    ;
    function GetEIASToken                   : string    ;
    function GetNotificationSignature       : string    ;
    function GetHardExpirationWarning       : string    ;
    function GetExternalUserData            : string    ;
    function GetHasMoreOrders               : string    ;
    function GetOrdersPerPage               : Integer   ;
    function GetPageNumber                  : Integer   ;
    function GetReturnedOrderCountActual    : Integer   ;
    procedure SetTimestamp                   (const Value: TDateTime );
    procedure SetAck                         (const Value: string    );
    procedure SetCorrelationID               (const Value: string    );
    procedure SetMessage_                    (const Value: string    );
    procedure SetVersion                     (const Value: string    );
    procedure SetBuild                       (const Value: string    );
    procedure SetNotificationEventName       (const Value: string    );
    procedure SetRecipientUserID             (const Value: string    );
    procedure SetEIASToken                   (const Value: string    );
    procedure SetNotificationSignature       (const Value: string    );
    procedure SetHardExpirationWarning       (const Value: string    );
    procedure SetExternalUserData            (const Value: string    );
    procedure SetHasMoreOrders               (const Value: string    );
    procedure SetOrdersPerPage               (const Value: Integer   );
    procedure SetPageNumber                  (const Value: Integer   );
    procedure SetReturnedOrderCountActual    (const Value: Integer   );
    function getOrderResponse_OrderErrors: TeBay_OrderResponse_OrderErrors;
    function getOrderResponse_PaginationResult: Tebay_orderresponse_paginationresult;
    function geTeBay_Orders :TeBay_Orders;
  public
    constructor Create(AOwner: TComponent); overload; override;
    destructor Destroy; override;
    Property OrderResponse_OrderErrors    :TeBay_OrderResponse_OrderErrors read getOrderResponse_OrderErrors;
    Property ebay_orders                  :TeBay_Orders   read geTeBay_Orders;
    Property OrderResponse_PaginationResult:Tebay_orderresponse_paginationresult read getOrderResponse_PaginationResult;
    (*Function getOrderResponse_Orders : TeBay_Orders;*)
  published

    property Timestamp                    :TDateTime   read GetTimestamp                  write SetTimestamp               ;
    property Ack                          :string      read GetAck                        write SetAck                     ;
    property CorrelationID                :string      read GetCorrelationID              write SetCorrelationID           ;
    property Message_                     :string      read GetMessage_                   write SetMessage_                ;
    property Version                      :string      read GetVersion                    write SetVersion                 ;
    property Build                        :string      read GetBuild                      write SetBuild                   ;
    property NotificationEventName        :string      read GetNotificationEventName      write SetNotificationEventName   ;
    property RecipientUserID              :string      read GetRecipientUserID            write SetRecipientUserID         ;
    property EIASToken                    :string      read GetEIASToken                  write SetEIASToken               ;
    property NotificationSignature        :string      read GetNotificationSignature      write SetNotificationSignature   ;
    property HardExpirationWarning        :string      read GetHardExpirationWarning      write SetHardExpirationWarning   ;
    property ExternalUserData             :string      read GetExternalUserData           write SetExternalUserData        ;
    property HasMoreOrders                :string      read GetHasMoreOrders              write SetHasMoreOrders           ;
    property OrdersPerPage                :Integer     read GetOrdersPerPage              write SetOrdersPerPage           ;
    property PageNumber                   :Integer     read GetPageNumber                 write SetPageNumber              ;
    property ReturnedOrderCountActual     :Integer     read GetReturnedOrderCountActual   write SetReturnedOrderCountActual;
    (*Property OrderResponse_Orders : TeBay_Orders read getOrderResponse_Orders;*)
   end;


implementation


uses sysutils;



  {Tebay_orderresponse}

constructor Tebay_orderresponse.Create(AOwner: TComponent);
begin
  inherited;
  fOrderResponse_OrderErrors:=nil;
  fOrderResponse_PaginationResult :=nil;
  Tablename := 'tblebay_orderresponse';
end;

destructor Tebay_orderresponse.Destroy;
begin
  inherited;
end;

{Property Functions}
function  Tebay_orderresponse.GetTimestamp               : TDateTime ; begin Result := Getfieldvalue('Timestamp');end;
function  Tebay_orderresponse.GetAck                     : string    ; begin Result := Getfieldvalue('Ack');end;
function  Tebay_orderresponse.GetCorrelationID           : string    ; begin Result := Getfieldvalue('CorrelationID');end;
function  Tebay_orderresponse.GetMessage_                : string    ; begin Result := Getfieldvalue('Message_');end;
function  Tebay_orderresponse.GetVersion                 : string    ; begin Result := Getfieldvalue('Version');end;
function  Tebay_orderresponse.GetBuild                   : string    ; begin Result := Getfieldvalue('Build');end;
function  Tebay_orderresponse.GetNotificationEventName   : string    ; begin Result := Getfieldvalue('NotificationEventName');end;
function  Tebay_orderresponse.GetRecipientUserID         : string    ; begin Result := Getfieldvalue('RecipientUserID');end;
function  Tebay_orderresponse.GetEIASToken               : string    ; begin Result := Getfieldvalue('EIASToken');end;
function  Tebay_orderresponse.GetNotificationSignature   : string    ; begin Result := Getfieldvalue('NotificationSignature');end;
function  Tebay_orderresponse.GetHardExpirationWarning   : string    ; begin Result := Getfieldvalue('HardExpirationWarning');end;
function  Tebay_orderresponse.GetExternalUserData        : string    ; begin Result := Getfieldvalue('ExternalUserData');end;
function  Tebay_orderresponse.GetHasMoreOrders           : string    ; begin Result := Getfieldvalue('HasMoreOrders');end;
function  Tebay_orderresponse.GetOrdersPerPage           : Integer   ; begin Result := Getfieldvalue('OrdersPerPage');end;
function  Tebay_orderresponse.GetPageNumber              : Integer   ; begin Result := Getfieldvalue('PageNumber');end;
function  Tebay_orderresponse.GetReturnedOrderCountActual: Integer   ; begin Result := Getfieldvalue('ReturnedOrderCountActual');end;
procedure Tebay_orderresponse.SetTimestamp               (const Value: TDateTime ); begin Setfieldvalue('Timestamp'                , Value);end;
procedure Tebay_orderresponse.SetAck                     (const Value: string    ); begin Setfieldvalue('Ack'                      , Value);end;
procedure Tebay_orderresponse.SetCorrelationID           (const Value: string    ); begin Setfieldvalue('CorrelationID'            , Value);end;
procedure Tebay_orderresponse.SetMessage_                (const Value: string    ); begin Setfieldvalue('Message_'                 , Value);end;
procedure Tebay_orderresponse.SetVersion                 (const Value: string    ); begin Setfieldvalue('Version'                  , Value);end;
procedure Tebay_orderresponse.SetBuild                   (const Value: string    ); begin Setfieldvalue('Build'                    , Value);end;
procedure Tebay_orderresponse.SetNotificationEventName   (const Value: string    ); begin Setfieldvalue('NotificationEventName'    , Value);end;
procedure Tebay_orderresponse.SetRecipientUserID         (const Value: string    ); begin Setfieldvalue('RecipientUserID'          , Value);end;
procedure Tebay_orderresponse.SetEIASToken               (const Value: string    ); begin Setfieldvalue('EIASToken'                , Value);end;
procedure Tebay_orderresponse.SetNotificationSignature   (const Value: string    ); begin Setfieldvalue('NotificationSignature'    , Value);end;
procedure Tebay_orderresponse.SetHardExpirationWarning   (const Value: string    ); begin Setfieldvalue('HardExpirationWarning'    , Value);end;
procedure Tebay_orderresponse.SetExternalUserData        (const Value: string    ); begin Setfieldvalue('ExternalUserData'         , Value);end;
procedure Tebay_orderresponse.SetHasMoreOrders           (const Value: string    ); begin Setfieldvalue('HasMoreOrders'            , Value);end;
procedure Tebay_orderresponse.SetOrdersPerPage           (const Value: Integer   ); begin Setfieldvalue('OrdersPerPage'            , Value);end;
procedure Tebay_orderresponse.SetPageNumber              (const Value: Integer   ); begin Setfieldvalue('PageNumber'               , Value);end;
procedure Tebay_orderresponse.SetReturnedOrderCountActual(const Value: Integer   ); begin Setfieldvalue('ReturnedOrderCountActual' , Value);end;

function Tebay_orderresponse.getOrderResponse_OrderErrors: TeBay_OrderResponse_OrderErrors;
begin
  if (fOrderResponse_OrderErrors = nil) then begin
    fOrderResponse_OrderErrors:= TeBay_OrderResponse_OrderErrors.Create(self, 'tbleBay_OrderResponse_OrderErrors', 'OrderResponse_Id =' + inttostr(ID));
  end;
  fOrderResponse_OrderErrors.SQLWhere := 'OrderResponse_Id =' + inttostr(ID);
  fOrderResponse_OrderErrors.Dataset;
  result:= fOrderResponse_OrderErrors;
end;

function TeBay_OrderResponse.getOrderResponse_PaginationResult: Tebay_orderresponse_paginationresult;
begin
  if (fOrderResponse_PaginationResult = nil) then begin
    fOrderResponse_PaginationResult:= Tebay_orderresponse_paginationresult.Create(self, 'tblebay_orderresponse_paginationresult', 'OrderResponse_Id =' + inttostr(ID));
  end;
  fOrderResponse_PaginationResult.SQLWhere := 'OrderResponse_Id =' + inttostr(ID);
  fOrderResponse_PaginationResult.Dataset;
  result:= fOrderResponse_PaginationResult;
end;
function TeBay_OrderResponse.geTeBay_Orders: TeBay_Orders;
begin
  if (febay_orders = nil) then begin
    febay_orders:= TeBay_Orders.Create(self, 'tblebay_orders', 'OrderResponseID =' + inttostr(ID));
  end;
  febay_orders.SQLWhere := 'OrderResponseID =' + inttostr(ID);
  febay_orders.Dataset;
  result:= febay_orders;
end;

(*function TeBay_OrderResponse.getOrderResponse_OrderErrors: TeBay_OrderResponse_OrderErrors;begin       Result := TeBay_OrderResponse_OrderErrors(getcontainercomponent(TeBay_OrderResponse_OrderErrors , 'OrderResponse_ID = ' + IntToStr(ID) , true , true));end;

function TeBay_OrderResponse.getOrderResponse_Orders : TeBay_Orders; begin       Result := TeBay_Orders(getcontainercomponent(TeBay_Orders , 'OrderResponse_ID = ' + IntToStr(ID) , true , true));end;*)


end.
