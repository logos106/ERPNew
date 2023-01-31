unit eBay_Orders_Trans_item_AttribSet;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses DB, Classes, eBayBaseObj ;


type
  Tebay_orders_trans_item_attribsetarr = class(TeBayObjBase)
  private
    function GetOrderID             : Integer   ;
    function GetOrders_Trans_Id     : Integer   ;
    function GetOrders_Trans_Item_Id: Integer   ;
    function GetattributeSetID      : Integer   ;
    function GetValueID             : Integer   ;
    function GetattributeID         : Integer   ;
    function GetattributeSetVersion : string    ;
    function GetValueLiteral        : string    ;
    function GetattributeLabel      : string    ;
    procedure SetOrderID             (const Value: Integer    );
    procedure SetOrders_Trans_Id     (const Value: Integer   );
    procedure SetOrders_Trans_Item_Id(const Value: Integer   );
    procedure SetattributeSetID      (const Value: Integer   );
    procedure SetValueID             (const Value: Integer   );
    procedure SetattributeID         (const Value: Integer   );
    procedure SetattributeSetVersion (const Value: string    );
    procedure SetValueLiteral        (const Value: string    );
    procedure SetattributeLabel      (const Value: string    );
  protected
  public
    constructor  Create(AOwner: TComponent); override;
  published
    property OrderID              :Integer     read GetOrderID                write SetOrderID         ;
    property Orders_Trans_Id      :Integer     read GetOrders_Trans_Id        write SetOrders_Trans_Id ;
    property Orders_Trans_Item_Id :Integer     read GetOrders_Trans_Item_Id   write SetOrders_Trans_Item_Id                    ;
    property attributeSetID       :Integer     read GetattributeSetID         write SetattributeSetID  ;
    property ValueID              :Integer     read GetValueID                write SetValueID  ;
    property attributeID          :Integer     read GetattributeID            write SetattributeID  ;
    property AttributeSetVersion  :string      read GetattributeSetVersion    write SetattributeSetVersion                     ;
    property ValueLiteral         :string      read GetValueLiteral           write SetValueLiteral                     ;
    property attributeLabel       :string      read GetattributeLabel         write SetattributeLabel                     ;
  end;


implementation






  {Tebay_orders_trans_item_attribsetarr}

constructor Tebay_orders_trans_item_attribsetarr.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Tablename := 'tblebay_orders_trans_item_attributeset';
end;

{Property Functions}
function  Tebay_orders_trans_item_attribsetarr.GetOrderID                                 : Integer   ; begin Result := GetFieldValue('OrderID');end;
function  Tebay_orders_trans_item_attribsetarr.GetOrders_Trans_Id                         : Integer   ; begin Result := GetFieldValue('Orders_Trans_Id');end;
function  Tebay_orders_trans_item_attribsetarr.GetOrders_Trans_Item_Id                    : Integer   ; begin Result := GetFieldValue('Orders_Trans_Item_Id');end;
function  Tebay_orders_trans_item_attribsetarr.GetattributeSetID                          : Integer   ; begin Result := GetFieldValue('attributeSetID');end;
function  Tebay_orders_trans_item_attribsetarr.GetValueID                                 : Integer   ; begin Result := GetFieldValue('ValueID');end;
function  Tebay_orders_trans_item_attribsetarr.GetattributeID                             : Integer   ; begin Result := GetFieldValue('attributeID');end;
function  Tebay_orders_trans_item_attribsetarr.GetattributeSetVersion                     : string    ; begin Result := GetFieldValue('attributeSetVersion');end;
function  Tebay_orders_trans_item_attribsetarr.GetValueLiteral                            : string    ; begin Result := GetFieldValue('ValueLiteral');end;
function  Tebay_orders_trans_item_attribsetarr.GetattributeLabel                          : string    ; begin Result := GetFieldValue('attributeLabel');end;
procedure Tebay_orders_trans_item_attribsetarr.SetOrderID                                 (const Value: Integer    ); begin SetFieldValue('OrderID'             , Value);end;
procedure Tebay_orders_trans_item_attribsetarr.SetOrders_Trans_Id                         (const Value: Integer   ); begin SetFieldValue('Orders_Trans_Id'      , Value);end;
procedure Tebay_orders_trans_item_attribsetarr.SetOrders_Trans_Item_Id                    (const Value: Integer   ); begin SetFieldValue('Orders_Trans_Item_Id' , Value);end;
procedure Tebay_orders_trans_item_attribsetarr.SetattributeSetID                          (const Value: Integer   ); begin SetFieldValue('attributeSetID'       , Value);end;
procedure Tebay_orders_trans_item_attribsetarr.SetValueID                                 (const Value: Integer   ); begin SetFieldValue('ValueID'              , Value);end;
procedure Tebay_orders_trans_item_attribsetarr.SetattributeID                             (const Value: Integer   ); begin SetFieldValue('attributeID'          , Value);end;
procedure Tebay_orders_trans_item_attribsetarr.SetattributeSetVersion                     (const Value: string    ); begin SetFieldValue('attributeSetVersion'  , Value);end;
procedure Tebay_orders_trans_item_attribsetarr.SetValueLiteral                            (const Value: string    ); begin SetFieldValue('ValueLiteral'         , Value);end;
procedure Tebay_orders_trans_item_attribsetarr.SetattributeLabel                          (const Value: string    ); begin SetFieldValue('attributeLabel'       , Value);end;


initialization
  RegisterClass(Tebay_orders_trans_item_attribsetarr);


end.
