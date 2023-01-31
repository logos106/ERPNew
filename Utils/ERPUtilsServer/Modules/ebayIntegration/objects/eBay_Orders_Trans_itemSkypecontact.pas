unit eBay_Orders_Trans_itemSkypecontact;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  28/06/13  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  Tebay_orders_trans_item_skypecontactoption = class(TMSBusObj)
  private
    function GetOrderID                                     : Integer   ;
    function GetOrders_Trans_Id                             : Integer   ;
    function GetOrders_Trans_Item_Id                        : Integer   ;
    function GetSkypeContactOption                          : string    ;
    procedure SetOrderID                                     (const Value: Integer    );
    procedure SetOrders_Trans_Id                             (const Value: Integer   );
    procedure SetOrders_Trans_Item_Id                        (const Value: Integer   );
    procedure SetSkypeContactOption                          (const Value: string    );
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
    property OrderID                                      :Integer      read GetOrderID                                    write SetOrderID                                 ;
    property Orders_Trans_Id                              :Integer     read GetOrders_Trans_Id                            write SetOrders_Trans_Id                         ;
    property Orders_Trans_Item_Id                         :Integer     read GetOrders_Trans_Item_Id                       write SetOrders_Trans_Item_Id                    ;
    property SkypeContactOption                           :string      read GetSkypeContactOption                         write SetSkypeContactOption                      ;
  end;


implementation


uses CommonLib, busobjebay_orders_trans_item;



  {Tebay_orders_trans_item_skypecontactoption}

constructor Tebay_orders_trans_item_skypecontactoption.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ebay_orders_trans_item_skypecontactoption';
  fSQL := 'SELECT * FROM tblebay_orders_trans_item_skypecontactoption';
end;


destructor Tebay_orders_trans_item_skypecontactoption.Destroy;
begin
  inherited;
end;


procedure Tebay_orders_trans_item_skypecontactoption.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'OrderID');
  SetPropertyFromNode(node,'Orders_Trans_Id');
  SetPropertyFromNode(node,'Orders_Trans_Item_Id');
  SetPropertyFromNode(node,'SkypeContactOption');
end;


procedure Tebay_orders_trans_item_skypecontactoption.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'OrderID' ,OrderID);
  AddXMLNode(node,'Orders_Trans_Id' ,Orders_Trans_Id);
  AddXMLNode(node,'Orders_Trans_Item_Id' ,Orders_Trans_Item_Id);
  AddXMLNode(node,'SkypeContactOption' ,SkypeContactOption);
end;


function Tebay_orders_trans_item_skypecontactoption.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Tebay_orders_trans_item_skypecontactoption.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tebay_orders_trans_item_skypecontactoption.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tebay_orders_trans_item_skypecontactoption.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tebay_orders_trans_item_skypecontactoption.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tebay_orders_trans_item_skypecontactoption.GetIDField: string;
begin
  Result := 'ID'
end;


class function Tebay_orders_trans_item_skypecontactoption.GetBusObjectTablename: string;
begin
  Result:= 'tblebay_orders_trans_item_skypecontactoption';
end;


function Tebay_orders_trans_item_skypecontactoption.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
    Result := inherited DoAfterInsert(Sender);
    if not result then exit;
    if Assigned(Owner) then
      if Owner is Tebay_orders_trans_item then begin
        OrderId :=Tebay_orders_trans_item(Owner).OrderId;
        Orders_Trans_Item_Id :=Tebay_orders_trans_item(Owner).ID;
      end;
end;

function Tebay_orders_trans_item_skypecontactoption.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Tebay_orders_trans_item_skypecontactoption.GetOrderID                                 : Integer   ; begin Result := GetIntegerField('OrderID');end;
function  Tebay_orders_trans_item_skypecontactoption.GetOrders_Trans_Id                         : Integer   ; begin Result := GetIntegerField('Orders_Trans_Id');end;
function  Tebay_orders_trans_item_skypecontactoption.GetOrders_Trans_Item_Id                    : Integer   ; begin Result := GetIntegerField('Orders_Trans_Item_Id');end;
function  Tebay_orders_trans_item_skypecontactoption.GetSkypeContactOption                      : string    ; begin Result := GetStringField('SkypeContactOption');end;
procedure Tebay_orders_trans_item_skypecontactoption.SetOrderID                                 (const Value: Integer    ); begin SetIntegerField('OrderID'                                  , Value);end;
procedure Tebay_orders_trans_item_skypecontactoption.SetOrders_Trans_Id                         (const Value: Integer   ); begin SetIntegerField('Orders_Trans_Id'                          , Value);end;
procedure Tebay_orders_trans_item_skypecontactoption.SetOrders_Trans_Item_Id                    (const Value: Integer   ); begin SetIntegerField('Orders_Trans_Item_Id'                     , Value);end;
procedure Tebay_orders_trans_item_skypecontactoption.SetSkypeContactOption                      (const Value: string    ); begin SetStringField('SkypeContactOption'                       , Value);end;


initialization
  RegisterClass(Tebay_orders_trans_item_skypecontactoption);


end.
