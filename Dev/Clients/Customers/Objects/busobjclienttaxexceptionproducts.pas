unit busobjclienttaxexceptionproducts;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  02/08/13  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TClientTaxExceptionProducts = class(TMSBusObj)
  private
    function GetClientID            : Integer   ;
    function GetClientName          : string    ;
    function GetProductId           : Integer   ;
    function GetProductName         : string    ;
    function GetActive              : Boolean   ;
    procedure SetClientID            (const Value: Integer   );
    procedure SetClientName          (const Value: string    );
    procedure SetProductID           (const Value: Integer   );
    procedure SetProductName         (const Value: string    );
    procedure SetActive              (const Value: Boolean   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    procedure DoFieldOnChange(Sender: TField);                          override;
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property ClientID             :Integer     read GetClientID           write SetClientID        ;
    property ClientName           :string      read GetClientName         write SetClientName      ;
    property ProductId            :Integer     read GetProductId          write SetProductID       ;
    property ProductName          :string      read GetProductName        write SetProductName     ;
    property Active               :Boolean     read GetActive             write SetActive          ;
  end;


implementation


uses tcDataUtils, CommonLib, BusObjectListObj;



  {TClientTaxExceptionProducts}

constructor TClientTaxExceptionProducts.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'clienttaxexceptionproducts';
  fSQL := 'SELECT * FROM tblclienttaxexceptionproducts';
end;


destructor TClientTaxExceptionProducts.Destroy;
begin
  inherited;
end;


procedure TClientTaxExceptionProducts.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ClientID');
  SetPropertyFromNode(node,'ClientName');
  SetPropertyFromNode(node,'ProductId');
  SetPropertyFromNode(node,'ProductName');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TClientTaxExceptionProducts.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ClientID' ,ClientID);
  AddXMLNode(node,'ClientName' ,ClientName);
  AddXMLNode(node,'ProductId' ,ProductId);
  AddXMLNode(node,'ProductName' ,ProductName);
  AddXMLNode(node,'Active' ,Active);
end;


function TClientTaxExceptionProducts.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if clientID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Customer should not be blank' , False );
    Exit;
  end;
  if ProductId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Product should not be blank' , False );
    Exit;
  end;
  Result := True;
end;


function TClientTaxExceptionProducts.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TClientTaxExceptionProducts.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TClientTaxExceptionProducts.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TClientTaxExceptionProducts.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TClientTaxExceptionProducts.GetIDField: string;
begin
  Result := 'ID'
end;


class function TClientTaxExceptionProducts.GetBusObjectTablename: string;
begin
  Result:= 'tblclienttaxexceptionproducts';
end;


function TClientTaxExceptionProducts.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TClientTaxExceptionProducts.GetClientID        : Integer   ; begin Result := GetIntegerField('ClientID');end;
function  TClientTaxExceptionProducts.GetClientName      : string    ; begin Result := GetStringField('ClientName');end;
function  TClientTaxExceptionProducts.GetProductId       : Integer   ; begin Result := GetIntegerField('ProductId');end;
function  TClientTaxExceptionProducts.GetProductName     : string    ; begin Result := GetStringField('ProductName');end;
function  TClientTaxExceptionProducts.GetActive          : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TClientTaxExceptionProducts.SetClientID        (const Value: Integer   ); begin SetIntegerField('ClientID'         , Value);end;
procedure TClientTaxExceptionProducts.SetClientName      (const Value: string    ); begin SetStringField('ClientName'       , Value);end;
procedure TClientTaxExceptionProducts.SetProductID       (const Value: Integer   ); begin SetIntegerField('ProductId'        , Value);end;
procedure TClientTaxExceptionProducts.SetProductName     (const Value: string    ); begin SetStringField('ProductName'      , Value);end;
procedure TClientTaxExceptionProducts.SetActive          (const Value: Boolean   ); begin SetBooleanField('Active'           , Value);end;


initialization
  RegisterClass(TClientTaxExceptionProducts);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Products to Exclude Default TaxCode', 'TClientTaxExceptionProducts','TProductstoExcludeDefaultTaxCodeGUI');
end.
