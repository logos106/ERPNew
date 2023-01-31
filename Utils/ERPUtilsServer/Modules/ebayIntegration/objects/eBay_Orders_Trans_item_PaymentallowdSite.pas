unit eBay_Orders_Trans_item_PaymentallowdSite;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes, eBayBaseObj ;


type
  Tebay_orders_trans_item_paymentallowedsite = class(TeBayObjBase)
  private
    function GetOrderID                                     : Integer   ;
    function GetOrders_Trans_Id                             : Integer   ;
    function GetOrders_Trans_Item_Id                        : Integer   ;
    function GetPaymentAllowedSite                          : string    ;
    procedure SetOrderID                                     (const Value: Integer    );
    procedure SetOrders_Trans_Id                             (const Value: Integer   );
    procedure SetOrders_Trans_Item_Id                        (const Value: Integer   );
    procedure SetPaymentAllowedSite                          (const Value: string    );
  protected
  public
    constructor  Create(AOwner: TComponent);                            override;
  published
    property OrderID                                      :Integer      read GetOrderID                                    write SetOrderID                                 ;
    property Orders_Trans_Id                              :Integer     read GetOrders_Trans_Id                            write SetOrders_Trans_Id                         ;
    property Orders_Trans_Item_Id                         :Integer     read GetOrders_Trans_Item_Id                       write SetOrders_Trans_Item_Id                    ;
    property PaymentAllowedSite                           :string      read GetPaymentAllowedSite                         write SetPaymentAllowedSite                      ;
  end;


implementation






  {Tebay_orders_trans_item_paymentallowedsite}

constructor Tebay_orders_trans_item_paymentallowedsite.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tablename := 'tblebay_orders_trans_item_paymentallowedsite';
end;


{Property Functions}
function  Tebay_orders_trans_item_paymentallowedsite.GetOrderID                                 : Integer   ; begin Result := GetFieldValue('OrderID');end;
function  Tebay_orders_trans_item_paymentallowedsite.GetOrders_Trans_Id                         : Integer   ; begin Result := GetFieldValue('Orders_Trans_Id');end;
function  Tebay_orders_trans_item_paymentallowedsite.GetOrders_Trans_Item_Id                    : Integer   ; begin Result := GetFieldValue('Orders_Trans_Item_Id');end;
function  Tebay_orders_trans_item_paymentallowedsite.GetPaymentAllowedSite                      : string    ; begin Result := GetFieldValue('PaymentAllowedSite');end;
procedure Tebay_orders_trans_item_paymentallowedsite.SetOrderID                                 (const Value: Integer    ); begin SetFieldValue('OrderID'                                  , Value);end;
procedure Tebay_orders_trans_item_paymentallowedsite.SetOrders_Trans_Id                         (const Value: Integer   ); begin SetFieldValue('Orders_Trans_Id'                          , Value);end;
procedure Tebay_orders_trans_item_paymentallowedsite.SetOrders_Trans_Item_Id                    (const Value: Integer   ); begin SetFieldValue('Orders_Trans_Item_Id'                     , Value);end;
procedure Tebay_orders_trans_item_paymentallowedsite.SetPaymentAllowedSite                      (const Value: string    ); begin SetFieldValue('PaymentAllowedSite'                       , Value);end;


initialization
  RegisterClass(Tebay_orders_trans_item_paymentallowedsite);


end.
