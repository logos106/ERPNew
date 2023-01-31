unit BusobjAttribProduct;

  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  17/06/08  1.00.00  A  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TProductAttributes = class(TMSBusObj)
  private
    function GetPAG_ID: Integer;
    function GetGroupName: string;
    function GetProductID: Integer;
    function GetProductName: string;
    function GetAttribName: string;
    function GetattribValue: string;
    function GetActive: Boolean;
    procedure SetPAG_ID(const Value: Integer);
    procedure SetGroupName(const Value: string);
    procedure SetProductID(const Value: Integer);
    procedure SetProductName(const Value: string);
    procedure SetAttribName(const Value: string);
    procedure SetattribValue(const Value: string);
    procedure SetActive(const Value: Boolean);
    procedure UniqueProductNames( const Sender: Tbusobj; var Abort: Boolean);
    function getProductAtive: Boolean;
    (*function getProdDEscription: STring;*)
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    function GetProductNames(Const GroupName: string):TStringList;
    Property ProductAtive : Boolean read getProductAtive;
    (*Property ProdDEscription :STring Read getProdDEscription;*)

  published
    property PAG_ID: Integer read GetPAG_ID write SetPAG_ID;
    property GroupName: string read GetGroupName write SetGroupName;
    property ProductID: Integer read GetProductID write SetProductID;
    property ProductName: string read GetProductName write SetProductName;
    property AttribName: string read GetAttribName write SetAttribName;
    property attribValue: string read GetattribValue write SetattribValue;
    property Active: Boolean read GetActive write SetActive;

  end;


implementation


uses SysUtils,  BusobjProdAttribGroup, BusObjStock;

var
  tmpStringList: TStringList;

{TProductAttributes}

constructor TProductAttributes.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'productattributeproducts';
  fSQL := 'SELECT * FROM tblproductattributeproducts';
end;


destructor TProductAttributes.Destroy;
begin
  inherited;
end;


procedure TProductAttributes.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'PAG_ID');
  SetPropertyFromNode(node, 'GroupName');
  SetPropertyFromNode(node, 'ProductID');
  SetPropertyFromNode(node, 'ProductName');
  SetPropertyFromNode(node, 'AttribName');
  SetPropertyFromNode(node, 'attribValue');
  SetBooleanPropertyFromNode(node, 'Active');
end;


procedure TProductAttributes.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'PAG_ID', PAG_ID);
  AddXMLNode(node, 'GroupName', GroupName);
  AddXMLNode(node, 'ProductID', ProductID);
  AddXMLNode(node, 'ProductName', ProductName);
  AddXMLNode(node, 'AttribName', AttribName);
  AddXMLNode(node, 'attribValue', attribValue);
  AddXMLNode(node, 'Active', Active);
end;


function TProductAttributes.ValidateData: Boolean;
begin
//  Result := false;
  Resultstatus.Clear;
  Result := true;
end;


function TProductAttributes.Save: Boolean;
begin
  Result := false;
  if Not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TProductAttributes.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TProductAttributes.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if Sysutils.SameText(Sender.fieldName , 'ProductName') then Begin
    ProductID := Tproduct.IDToggle(ProductName, Self.Connection.Connection);
  end else if Sysutils.SameText(Sender.fieldName , 'groupName') then Begin
    PAG_ID := TProdAttribGroups.IDToggle(GroupName, Self.Connection.Connection);
  end;
end;

function TProductAttributes.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TProductAttributes.GetIDField: string;
begin
  Result := 'PAP_ID'
end;

class function TProductAttributes.GetBusObjectTablename: string;
begin
  Result := 'tblproductattributeproducts';
end;


function TProductAttributes.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
end;


{Property Functions}
function TProductAttributes.GetPAG_ID: Integer; 
begin 
  Result := GetIntegerField('PAG_ID');
end;

function TProductAttributes.GetGroupName: string; 
begin 
  Result := GetStringField('GroupName');
end;

function TProductAttributes.GetProductID: Integer;
begin 
  Result := GetIntegerField('ProductID');
end;

function TProductAttributes.GetProductName: string; 
begin 
  Result := GetStringField('ProductName');
end;

function TProductAttributes.GetAttribName: string; 
begin 
  Result := GetStringField('AttribName');
end;

function TProductAttributes.GetattribValue: string; 
begin 
  Result := GetStringField('attribValue');
end;

function TProductAttributes.GetActive: Boolean; 
begin 
  Result := GetBooleanField('Active');
end;

procedure TProductAttributes.SetPAG_ID(const Value: Integer);
begin 
  SetIntegerField('PAG_ID', Value);
end;

procedure TProductAttributes.SetGroupName(const Value: string); 
begin 
  SetStringField('GroupName', Value);
end;

procedure TProductAttributes.SetProductID(const Value: Integer);
begin 
  SetIntegerField('ProductID', Value);
end;

procedure TProductAttributes.SetProductName(const Value: string);
begin 
  SetStringField('ProductName', Value);
end;

procedure TProductAttributes.SetAttribName(const Value: string); 
begin 
  SetStringField('AttribName', Value);
end;

procedure TProductAttributes.SetattribValue(const Value: string);
begin 
  SetStringField('attribValue', Value);
end;

procedure TProductAttributes.SetActive(const Value: Boolean); 
begin 
  SetBooleanField('Active', Value);
end;

procedure TProductAttributes.UniqueProductNames( const Sender: Tbusobj; var Abort: Boolean);
begin
  If Assigned(tmpStringList) then Begin
    tmpStringList.Add(Self.ProductName);
  end;
end;

function TProductAttributes.GetProductNames(const GroupName: string): TStringList;
begin
  tmpStringList := TStringList.Create;
  Dataset.DisableControls;
  Try
    Dataset.Close;
    Dataset.Open;
    Dataset.Filter := 'GroupName = '+ QuotedStr(GroupName);
    Dataset.Filtered := True;
    tmpStringList.Duplicates := dupIgnore;
    tmpStringList.Sorted    := true;
    Iteraterecords(UniqueProductNames);
  Finally
    Dataset.Filtered := False;
    Dataset.EnableControls;
  end;
  Result := tmpStringList;
  tmpStringList := nil;
end;

function TProductAttributes.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
end;

function TProductAttributes.getProductAtive: Boolean;
begin
  Result := TProduct.IsProductActive(ProductID, Self.Connection.connection);
end;

(*function TProductAttributes.getProdDEscription: STring;
begin
  result := '';
  if assigned(Self.Owner) then
    if Self.Owner is TProdAttribGroups then
      Result := TProdAttribGroups(Self.Owner).ProdDesc;
  
end;*)

initialization
  RegisterClass(TProductAttributes);
end.




