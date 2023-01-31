unit BusObjPickingAssemblyLine;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  15/05/08  1.00.00  A  Initial Version.
  }


interface


uses
  BusObjBase, DB, Classes, XMLDoc, XMLIntf, BusObjStock;


type
  TPickingAssemblyLine2 = class(TMSBusObj)
  private
    function GetPickingAssemblyID         : Integer   ;
    function GetPickingAssemblyentrylinesID: Integer   ;
    function GetProductID                 : Integer   ;
    function GetProductName               : string    ;
    function GetDescription               : string    ;
    function GetQty                       : double    ;
    function GetQtyMultiplier             : double    ;
    function GetUOM                       : string    ;
    function GetUOMID                     : Integer   ;
    function GetPackNumber                : Integer   ;
    procedure SetPickingAssemblyID         (const Value: Integer   );
    procedure SetPickingAssemblyentrylinesID(const Value: Integer   );
    procedure SetProductID                 (const Value: Integer   );
    procedure SetProductName               (const Value: string    );
    procedure SetDescription               (const Value: string    );
    procedure SetQty                       (const Value: double    );
    procedure SetQtyMultiplier             (const Value: double    );
    procedure SetUOM                       (const Value: string    );
    procedure SetUOMID                     (const Value: Integer   );
    procedure SetPackNumber                (const Value: Integer   );
    function GetProduct: TProduct;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    property Product: TProduct read GetProduct;
    procedure New; override;
  published
    property PickingAssemblyID          :Integer     read GetPickingAssemblyID        write SetPickingAssemblyID     ;
    property PickingAssemblyentrylinesID          :Integer     read GetPickingAssemblyentrylinesID        write SetPickingAssemblyentrylinesID     ;
    property ProductID                  :Integer     read GetProductID                write SetProductID             ;
    property ProductName                :string      read GetProductName              write SetProductName           ;
    property Description                :string      read GetDescription              write SetDescription           ;
    property Qty                        :double      read GetQty                      write SetQty                   ;
    property QtyMultiplier              :double      read GetQtyMultiplier            write SetQtyMultiplier         ;
    property UOM                        :string      read GetUOM                      write SetUOM                   ;
    property UOMID                      :Integer     read GetUOMID                    write SetUOMID                 ;
    property PackNumber                 :Integer     read GetPackNumber               write SetPackNumber            ;
  end;


implementation


uses
  Sysutils,tcDataUtils, CommonLib, FastFuncs, BusObjPickingAssembly ,BusObjPickingAssembly2;



  {TPickingAssemblyLines}

constructor TPickingAssemblyLine2.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'PickingAssemblyLine';
  fSQL := 'SELECT * FROM tblpickingassemblylines';
end;


destructor TPickingAssemblyLine2.Destroy;
begin
  inherited;
end;


procedure TPickingAssemblyLine2.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'PickingAssemblyID');
  SetPropertyFromNode(node,'PickingAssemblyentrylinesID');
  SetPropertyFromNode(node,'ProductID');
  SetPropertyFromNode(node,'ProductName');
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'Qty');
  SetPropertyFromNode(node,'UOM');
  SetPropertyFromNode(node,'UOMID');
  SetPropertyFromNode(node,'PackNumber');
end;


procedure TPickingAssemblyLine2.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'PickingAssemblyID' ,PickingAssemblyID);
  AddXMLNode(node,'PickingAssemblyentrylinesID' ,PickingAssemblyentrylinesID);
  AddXMLNode(node,'ProductID' ,ProductID);
  AddXMLNode(node,'ProductName' ,ProductName);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'Qty' ,Qty);
  AddXMLNode(node,'UOM' ,UOM);
  AddXMLNode(node,'UOMID' ,UOMID);
  AddXMLNode(node,'PackNumber' ,PackNumber);
end;


function TPickingAssemblyLine2.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if PickingAssemblyID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'PickingAssemblyID should not be 0' , True);
    Exit;
  end;
  if ProductID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'ProductID should not be 0' , True);
    Exit;
  end;
  if Qty = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Qty should not be 0' , True);
    Exit;
  end;
  if UOMID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'UOMID should not be 0' , True);
    Exit;
  end;
  if UOM = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'UOM should not be blank' , True);
    Exit;
  end;
  if PackNumber = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'PackNumber should not be 0' , True);
    Exit;
  end;
  Result := True;
end;


function TPickingAssemblyLine2.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TPickingAssemblyLine2.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TPickingAssemblyLine2.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.

  if Sysutils.SameText(Sender.FieldName , 'ProductID') then begin
    ProductName:= TProduct.IDToggle(Sender.AsInteger, self.Connection.Connection);
    Description:= GetProductDescription(ProductId);
  end
  else if Sysutils.SameText(Sender.FieldName , 'ProductName') then begin
    ProductId:= TProduct.IDToggle(Sender.AsString, self.Connection.Connection);
    Description:= GetProductDescription(ProductId);
  end
  else if Sysutils.SameText(Sender.FieldName , 'UOMID') then begin
    if ProductId > 0 then begin
      if Product.UOMList.LocateByID(sender.AsInteger) then begin
        UOM:= Product.UOMList.UOMName;
        QtyMultiplier:= Product.UOMList.Multiplier;
      end;
    end;
  end
  else if Sysutils.SameText(Sender.FieldName , 'UOM') then begin
    if ProductId > 0 then begin
      if Product.UOMList.LocateByName(Sender.AsString) then begin
        UOMID:= Product.UOMList.UnitId;
        QtyMultiplier:= Product.UOMList.Multiplier;
      end
      else begin
        UOMID:= 0;
        QtyMultiplier:= 1;
      end;
    end
    else begin
      UOMID:= 0;
      QtyMultiplier:= 1;
    end;
  end;
end;


function TPickingAssemblyLine2.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TPickingAssemblyLine2.GetIDField: string;
begin
  Result := 'PickingAssemblylinesID'
end;


class function TPickingAssemblyLine2.GetBusObjectTablename: string;
begin
  Result:= 'tblpickingassemblylines';
end;


function TPickingAssemblyLine2.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TPickingAssemblyLine2.GetPickingAssemblyID     : Integer   ; begin Result := GetIntegerField('PickingAssemblyID');end;
function  TPickingAssemblyLine2.GetPickingAssemblyentrylinesID     : Integer   ; begin Result := GetIntegerField('PickingAssemblyentrylinesID');end;
function  TPickingAssemblyLine2.GetProductID             : Integer   ; begin Result := GetIntegerField('ProductID');end;
function  TPickingAssemblyLine2.GetProductName           : string    ; begin Result := GetStringField('ProductName');end;
function  TPickingAssemblyLine2.GetDescription           : string    ; begin Result := GetStringField('Description');end;
function  TPickingAssemblyLine2.GetQty                   : double    ; begin Result := GetFloatField('Qty');end;
function  TPickingAssemblyLine2.GetQtyMultiplier         : double    ; begin Result := GetFloatField('QtyMultiplier');end;
function  TPickingAssemblyLine2.GetUOM                   : string    ; begin Result := GetStringField('UOM');end;
function  TPickingAssemblyLine2.GetUOMID                 : Integer   ; begin Result := GetIntegerField('UOMID');end;
function  TPickingAssemblyLine2.GetPackNumber            : Integer   ; begin Result := GetIntegerField('PackNumber');end;
procedure TPickingAssemblyLine2.SetPickingAssemblyID     (const Value: Integer   ); begin SetIntegerField('PickingAssemblyID'      , Value);end;
procedure TPickingAssemblyLine2.SetPickingAssemblyentrylinesID     (const Value: Integer   ); begin SetIntegerField('PickingAssemblyentrylinesID'      , Value);end;
procedure TPickingAssemblyLine2.SetProductID             (const Value: Integer   ); begin SetIntegerField('ProductID'              , Value);end;
procedure TPickingAssemblyLine2.SetProductName           (const Value: string    ); begin SetStringField('ProductName'            , Value);end;
procedure TPickingAssemblyLine2.SetDescription           (const Value: string    ); begin SetStringField('Description'            , Value);end;
procedure TPickingAssemblyLine2.SetQty                   (const Value: double    ); begin SetFloatField('Qty'                    , Value);end;
procedure TPickingAssemblyLine2.SetQtyMultiplier         (const Value: double    ); begin SetFloatField('QtyMultiplier'            , Value);end;
procedure TPickingAssemblyLine2.SetUOM                   (const Value: string    ); begin SetStringField('UOM'                    , Value);end;
procedure TPickingAssemblyLine2.SetUOMID                 (const Value: Integer   ); begin SetIntegerField('UOMID'                  , Value);end;
procedure TPickingAssemblyLine2.SetPackNumber            (const Value: Integer   ); begin SetIntegerField('PackNumber'             , Value);end;


function TPickingAssemblyLine2.GetProduct: TProduct;
begin
  if self.ProductID > 0 then begin
    //Result:= TProduct(getContainerComponent(TProduct, 'PartsID = 0'));
    Result := TProduct(getContainerComponent(TProduct, ProductID,'PartsID' ));
    if result.Id <> self.ProductID then
      result.Load(ProductID);
  end
  else begin
    result:= nil;
  end;
end;

procedure TPickingAssemblyLine2.New;
begin
  inherited;
  if Assigned(Owner) and (Owner is TPickingAssembly2) then
    PickingAssemblyID:= TPickingAssembly2(Owner).Id;
end;

initialization
  RegisterClassOnce(TPickingAssemblyLine2);


end.
