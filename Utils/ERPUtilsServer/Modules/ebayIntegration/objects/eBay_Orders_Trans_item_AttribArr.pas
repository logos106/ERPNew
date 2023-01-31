unit eBay_Orders_Trans_item_AttribArr;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes, eBayBaseObj ;


type
  Tebay_orders_trans_item_attribarr = class(TeBayObjBase)
  private
    function GetOrderID                                     : Integer   ;
    function GetOrders_Trans_Id                             : Integer   ;
    function GetOrders_Trans_Item_Id                        : Integer   ;
    function GetattributeID                                 : Integer   ;
    function GetattributeLabel                              : string    ;
    procedure SetOrderID                                     (const Value: Integer    );
    procedure SetOrders_Trans_Id                             (const Value: Integer   );
    procedure SetOrders_Trans_Item_Id                        (const Value: Integer   );
    procedure SetattributeID                                 (const Value: Integer   );
    procedure SetattributeLabel                              (const Value: string    );
  protected
  public
    constructor  Create(AOwner: TComponent);                            override;
  published
    property OrderID                                      :Integer      read GetOrderID                                    write SetOrderID                                 ;
    property Orders_Trans_Id                              :Integer     read GetOrders_Trans_Id                            write SetOrders_Trans_Id                         ;
    property Orders_Trans_Item_Id                         :Integer     read GetOrders_Trans_Item_Id                       write SetOrders_Trans_Item_Id                    ;
    property attributeID                                  :Integer     read GetattributeID                                write SetattributeID                             ;
    property attributeLabel                               :string      read GetattributeLabel                             write SetattributeLabel                          ;
  end;


implementation






  {Tebay_orders_trans_item_attribarr}

constructor Tebay_orders_trans_item_attribarr.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tablename := 'tblebay_orders_trans_item_attribarr';
end;



{Property Functions}
function  Tebay_orders_trans_item_attribarr.GetOrderID                                 : Integer   ; begin Result := GetFieldValue('OrderID');end;
function  Tebay_orders_trans_item_attribarr.GetOrders_Trans_Id                         : Integer   ; begin Result := GetFieldValue('Orders_Trans_Id');end;
function  Tebay_orders_trans_item_attribarr.GetOrders_Trans_Item_Id                    : Integer   ; begin Result := GetFieldValue('Orders_Trans_Item_Id');end;
function  Tebay_orders_trans_item_attribarr.GetattributeID                             : Integer   ; begin Result := GetFieldValue('attributeID');end;
function  Tebay_orders_trans_item_attribarr.GetattributeLabel                          : string    ; begin Result := GetFieldValue('attributeLabel');end;
procedure Tebay_orders_trans_item_attribarr.SetOrderID                                 (const Value: Integer    ); begin SetFieldValue('OrderID'                                  , Value);end;
procedure Tebay_orders_trans_item_attribarr.SetOrders_Trans_Id                         (const Value: Integer   ); begin SetFieldValue('Orders_Trans_Id'                          , Value);end;
procedure Tebay_orders_trans_item_attribarr.SetOrders_Trans_Item_Id                    (const Value: Integer   ); begin SetFieldValue('Orders_Trans_Item_Id'                     , Value);end;
procedure Tebay_orders_trans_item_attribarr.SetattributeID                             (const Value: Integer   ); begin SetFieldValue('attributeID'                              , Value);end;
procedure Tebay_orders_trans_item_attribarr.SetattributeLabel                          (const Value: string    ); begin SetFieldValue('attributeLabel'                           , Value);end;


initialization
  RegisterClass(Tebay_orders_trans_item_attribarr);


end.

