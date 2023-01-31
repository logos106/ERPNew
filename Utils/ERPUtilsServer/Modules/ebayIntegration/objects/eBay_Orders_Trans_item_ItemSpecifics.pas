unit eBay_Orders_Trans_item_ItemSpecifics;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes, eBayBaseObj ;


type
  Tebay_orders_trans_item_itemspecifics = class(TeBayObjBase)
  private
    function GetOrderID                                     : Integer   ;
    function GetOrders_Trans_Id                             : Integer   ;
    function GetOrders_Trans_Item_Id                        : Integer   ;
    function GetName_                                       : string    ;
    function GetSource                                      : string    ;
    procedure SetOrderID                                     (const Value: Integer    );
    procedure SetOrders_Trans_Id                             (const Value: Integer   );
    procedure SetOrders_Trans_Item_Id                        (const Value: Integer   );
    procedure SetName_                                       (const Value: string    );
    procedure SetSource                                      (const Value: string    );
  protected
  public
    constructor  Create(AOwner: TComponent);                            override;
  published
    property OrderID                                      :Integer      read GetOrderID                                    write SetOrderID                                 ;
    property Orders_Trans_Id                              :Integer     read GetOrders_Trans_Id                            write SetOrders_Trans_Id                         ;
    property Orders_Trans_Item_Id                         :Integer     read GetOrders_Trans_Item_Id                       write SetOrders_Trans_Item_Id                    ;
    property Name_                                        :string      read GetName_                                      write SetName_                                   ;
    property Source                                       :string      read GetSource                                     write SetSource                                  ;
  end;


implementation






  {Tebay_orders_trans_item_itemspecifics}

constructor Tebay_orders_trans_item_itemspecifics.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tablename := 'tblebay_orders_trans_item_itemspecifics';
end;

{Property Functions}
function  Tebay_orders_trans_item_itemspecifics.GetOrderID                                 : Integer   ; begin Result := GetFieldValue('OrderID');end;
function  Tebay_orders_trans_item_itemspecifics.GetOrders_Trans_Id                         : Integer   ; begin Result := GetFieldValue('Orders_Trans_Id');end;
function  Tebay_orders_trans_item_itemspecifics.GetOrders_Trans_Item_Id                    : Integer   ; begin Result := GetFieldValue('Orders_Trans_Item_Id');end;
function  Tebay_orders_trans_item_itemspecifics.GetName_                                   : string    ; begin Result := GetFieldValue('Name_');end;
function  Tebay_orders_trans_item_itemspecifics.GetSource                                  : string    ; begin Result := GetFieldValue('Source');end;
procedure Tebay_orders_trans_item_itemspecifics.SetOrderID                                 (const Value: Integer    ); begin SetFieldValue('OrderID'                                  , Value);end;
procedure Tebay_orders_trans_item_itemspecifics.SetOrders_Trans_Id                         (const Value: Integer   ); begin SetFieldValue('Orders_Trans_Id'                          , Value);end;
procedure Tebay_orders_trans_item_itemspecifics.SetOrders_Trans_Item_Id                    (const Value: Integer   ); begin SetFieldValue('Orders_Trans_Item_Id'                     , Value);end;
procedure Tebay_orders_trans_item_itemspecifics.SetName_                                   (const Value: string    ); begin SetFieldValue('Name_'                                    , Value);end;
procedure Tebay_orders_trans_item_itemspecifics.SetSource                                  (const Value: string    ); begin SetFieldValue('Source'                                   , Value);end;


initialization
  RegisterClass(Tebay_orders_trans_item_itemspecifics);


end.
