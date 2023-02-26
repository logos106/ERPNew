unit BusObjProductClass;

interface

uses
  classes, BusObjBase, BusObjProductBin, DB, XMLIntf, MyAccess, ERPDbComponents;


type
  TProductClass = class(TMSBusObj)
  private
    fsbinLocation, fsBinNumber:String;
    fbAddNewinLoadFromXML: Boolean;
    function GetProductID             : Integer   ;
    function GetProductName           : string    ;
    function GetProductGroup          : string    ;
    function GetDeptID                : Integer   ;
    function GetDeptName              : string    ;
    function GetReOrderPoint          : Double    ;
    function GetPreferredLevel        : Double    ;
    function GetReOrderAmount         : Double    ;
    function GetClassPriceVariance    : Double    ;
    function GetVariantPrice          : Double    ;
    function GetWastagePercentage     : Double    ;
    function GetNextStocktakeDate     : TDateTime ;
    function GetActive                : Boolean   ;
    function GetIsDefaultStockClass   : Boolean   ;
    function GetUseproductforecastformula: Boolean   ;
    procedure SetProductID             (const Value: Integer   );
    procedure SetProductName           (const Value: string    );
    procedure SetProductGroup          (const Value: string    );
    procedure SetDeptID                (const Value: Integer   );
    procedure SetDeptName              (const Value: string    );
    procedure SetReOrderPoint          (const Value: Double    );
    procedure SetPreferredLevel        (const Value: Double    );
    procedure SetReOrderAmount         (const Value: Double    );
    procedure SetClassPriceVariance    (const Value: Double    );
    procedure SetVariantPrice          (const Value: Double    );
    procedure SetWastagePercentage     (const Value: Double    );
    procedure SetNextStocktakeDate     (const Value: TDateTime );
    procedure SetActive                (const Value: Boolean   );
    procedure SetIsDefaultStockClass   (const Value: Boolean   );
    procedure SetUseproductforecastformula(const Value: Boolean   );
    function getPurchaseDescription: String;
    function getSalesDescription: String;
    function getDefaultbinLocation: String;
    function getDefaultbinNumber: String;
    procedure setDefaultbinLocation(const Value: String);
    procedure setDefaultbinNumber(const Value: String);
    function getDefaultbinId: Integer;
    procedure SetDefaultbinId(const Value: Integer);
    function getProductBin: TProductBin;
    function GetETADate: TDateTime;
    function GetOnOrderQuantity: double;

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    function GetAvailableQuantity: double; virtual;

  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    class function  GetKeyStringField: string; Override;
    class function  GetKeyStringProperty: string; Override;
    constructor     Create(AOwner: TComponent);                            override;
    destructor      Destroy;                                               override;
    procedure       LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure       SaveToXMLNode(const node: IXMLNode);                   override;
    function        ValidateData: Boolean ;                                override;
    function        Save: Boolean ;                                        override;
    Class function  QtyInStock(ProductID, ClassID:Integer): double;
    class function  DefaultbinId(ProductID, ClassID:Integer): Integer;
    Class function  AvailableQty(ProductID, ClassID:Integer;Connection: TCustomMyConnection = nil): double;
    Class function  ProductInstockQty(ProductID, ClassID:Integer;Connection: TCustomMyConnection = nil): double;
    Class function  OnOrderQty(ProductID, ClassID:Integer): double;
    Class Procedure LinkProduct(fProductID, fClassID:Integer; fConnection :TcustomMyConnection=nil);
    Property        ProductBin :TProductBin Read getProductBin;
    Property        Defaultbin_Id :Integer read getDefaultbinId write SetDefaultbinId;
    class function  _Schema: string; override;
    Property        AddNewinLoadFromXML :Boolean read fbAddNewinLoadFromXML write fbAddNewinLoadFromXML;

  published
    property ProductID              :Integer     read GetProductID            write SetProductID         ;
    property ProductName            :string      read GetProductName          write SetProductName       ;
    property ProductGroup           :string      read GetProductGroup;
    property DeptID                 :Integer     read GetDeptID               write SetDeptID           ;
    property DeptName               :string      read GetDeptName             write SetDeptName          ;
    property ReOrderPoint           :Double      read GetReOrderPoint         write SetReOrderPoint      ;
    property PreferredLevel         :Double      read GetPreferredLevel       write SetPreferredLevel    ;
    property ReOrderAmount          :Double      read GetReOrderAmount        write SetReOrderAmount     ;
    property ClassPriceVariance     :Double      read GetClassPriceVariance   write SetClassPriceVariance;
    property VariantPrice           :Double      read GetVariantPrice         write SetVariantPrice      ;
    property WastagePercentage      :Double      read GetWastagePercentage    write SetWastagePercentage ;
    property NextStocktakeDate      :TDateTime   read GetNextStocktakeDate    write SetNextStocktakeDate ;
    property Active                 :Boolean     read GetActive               write SetActive            ;
    property IsDefaultStockClass    :Boolean     read GetIsDefaultStockClass  write SetIsDefaultStockClass;
    property UseProductForecastFormula:Boolean   read GetUseproductforecastformula write SetUseproductforecastformula;
    property SalesDescription :String read getSalesDescription;
    property PurchaseDescription :String read getPurchaseDescription;
    Property DefaultbinLocation :String read getDefaultbinLocation Write setDefaultbinLocation;
    Property DefaultbinNumber :String read getDefaultbinNumber write setDefaultbinNumber;
    property AvailableQuantity: double read GetAvailableQuantity;
    property OnOrderQuantity: double read GetOnOrderQuantity;
    property ETADate: TDateTime read GetETADate;
  end;

  TProductClassEx = class(TProductClass)
  private
    fQuery: TERPQuery;
    function GetAllocatedBOQty: double;
    function GetInStockQty: double;
    function GetPOBOQty: double;
    function GetSOBOQty: double;
    function GetSOQty: double;
    function GetQuery: TERPQuery;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    property Query: TERPQuery read GetQuery;
  public
    constructor  Create(AOwner: TComponent);                            override;
    function GetAvailableQuantity: double; override;
  published
    property AllocatedBOQty: double read GetAllocatedBOQty;
    property SOQty: double read GetSOQty;
    property SOBOQty: double read GetSOBOQty;
    property InStockQty: double read GetInStockQty;
    property POBOQty: double read GetPOBOQty;
  end;

  TProductClassQuantity = class(TMSBusObj)
  private
    fFirstLoad: boolean;
    function GetAllocatedBOQty: double;
    function GetAvailableQty: double;
    function GetDepartmentID: integer;
    function GetDepartmentName: string;
    function GetInStockQty: double;
    function GetOnOrderQty: double;
    function GetPOBOQty: double;
    function GetProductID: integer;
    function GetProductName: string;
    function GetSOBOQty: double;
    function GetSOQty: double;
    procedure SetAllocatedBOQty(const Value: double);
    procedure SetAvailableQty(const Value: double);
    procedure SetDepartmentID(const Value: integer);
    procedure SetDepartmentName(const Value: string);
    procedure SetInStockQty(const Value: double);
    procedure SetOnOrderQty(const Value: double);
    procedure SetPOBOQty(const Value: double);
    procedure SetProductID(const Value: integer);
    procedure SetProductName(const Value: string);
    procedure SetSOBOQty(const Value: double);
    procedure SetSOQty(const Value: double);
  published
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class procedure UpdateTableData;
    procedure Load(const fIsReadonly: boolean = False); override;
  published
    property ProductID: integer read GetProductID write SetProductID;
    property ProductName: string read GetProductName write SetProductName;
    property DepartmentID: integer read GetDepartmentID write SetDepartmentID;
    property DepartmentName: string read GetDepartmentName write SetDepartmentName;
    property AvailableQty: double read GetAvailableQty write SetAvailableQty;
    property OnOrderQty: double read GetOnOrderQty write SetOnOrderQty;
    property AllocatedBOQty: double read GetAllocatedBOQty write SetAllocatedBOQty;
    property SOQty: double read GetSOQty write SetSOQty;
    property SOBOQty: double read GetSOBOQty write SetSOBOQty;
    property InStockQty: double read GetInStockQty write SetInStockQty;
    property POBOQty: double read GetPOBOQty write SetPOBOQty;
  end;




implementation

uses
  BusObjUtils, BusObjStock, SysUtils, AppEnvironment, BusObjSchemaLib,
  BusObjClass, CommonDbLib, ProductQtyLib, PQALib, CommonLib,
  tcConst, DbSharedObjectsObj;

 {TProductClass}

constructor TProductClass.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AddNewinLoadFromXML := True;
  fBusObjectTypeDescription:= 'ProductClasses';
  fSQL := 'SELECT * FROM tblproductclasses';
  fIsList:= true;
//  ExportExcludeList.Add('deptid');
//  ExportExcludeList.Add('productid');
  fsbinlocation :='';
  fsBinNumber:= '';

end;


destructor TProductClass.Destroy;
begin
  inherited;
end;


procedure TProductClass.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  if AddNewinLoadFromXML then begin
      if not Dataset.Locate('ClassId' , GetXMLNodeIntegerValue(node, 'DeptID') , []) then begin
        New;
        ProductId := CheckProduct(Self,Node, 'ProductName');
        SetPropertyFromNode(node,'DeptID');
        SetPropertyFromNode(node,'DeptName');
      end;
  end else begin
        ProductId := CheckProduct(Self,Node, 'ProductName');
        SetPropertyFromNode(node,'DeptID');
        SetPropertyFromNode(node,'DeptName');
  end;
  SetPropertyFromNode(node,'ReOrderPoint');
  SetPropertyFromNode(node,'PreferredLevel');
  SetPropertyFromNode(node,'ReOrderAmount');
  SetPropertyFromNode(node,'ClassPriceVariance');
  SetPropertyFromNode(node,'VariantPrice');
  SetPropertyFromNode(node,'WastagePercentage');
  SetDateTimePropertyFromNode(node,'NextStocktakeDate');
  SetBooleanPropertyFromNode(node,'Active');
  SetBooleanPropertyFromNode(node,'IsDefaultStockClass');
  SetBooleanPropertyFromNode(node,'Useproductforecastformula');
end;


procedure TProductClass.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  if not IsOwnerProduct(self) then begin
    AddXMLNode(node,'ProductID' ,ProductID);
    AddXMLNode(node,'ProductName' ,ProductName);
  end;
  AddXMLNode(node,'ProductGroup' ,ProductGroup);
  AddXMLNode(node,'DeptID' ,DeptID);
  AddXMLNode(node,'DeptName' ,DeptName);
  AddXMLNode(node,'ReOrderPoint' ,ReOrderPoint);
  AddXMLNode(node,'PreferredLevel' ,PreferredLevel);
  AddXMLNode(node,'ReOrderAmount' ,ReOrderAmount);
  AddXMLNode(node,'ClassPriceVariance' ,ClassPriceVariance);
  AddXMLNode(node,'VariantPrice' ,VariantPrice);
  AddXMLNode(node,'WastagePercentage' ,WastagePercentage);
  AddXMLNode(node,'NextStocktakeDate' ,NextStocktakeDate);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'IsDefaultStockClass' ,IsDefaultStockClass);
  AddXMLNode(node,'Useproductforecastformula' ,Useproductforecastformula);
end;


function TProductClass.ValidateData: Boolean ;
var
  CleanProductId, CleanDeptID: integer;
begin
  Resultstatus.Clear;
  result:= inherited ValidateData;
  if not result then exit;
  if Assigned(Owner) and (Owner is TProduct) and (TProduct(Owner).ID <> ProductID) then begin
    if ProductID = 0 then begin
      ProductID:= TProduct(Owner).ID;
    end;
    if (TProduct(Owner).ID <> ProductID) then begin
      Result:= false;
      AddResult(false, rssWarning, 0,'Product ID (' + IntToStr(ProductID) + ') does not match ID ('+ IntToStr(TProduct(Owner).ID) +') of the parent Product');
      exit;
    end;
  end;
  if (Productname = '') and (ProductID<> 0) then begin
    ProductName := TProduct.IDToggle(ProductId,Connection.Connection);
    PostDB;
  end;
  if self.DeptID = 0 then begin
    Result:= false;
    AddResult(false, rssWarning, 0, AppEnv.DefaultClass.ClassHeading + ' can not be blank');
    exit;
  end;
  if (Defaultbin_Id=0) and ((fsbinlocation <>'') or (fsbinnumber<> '')) then begin
    AddResult(false, rssWarning, 0, 'Product Bin not Found for Bin Location: ' + quotedstr(fsbinlocation) +' and Bin Number :' + quotedStr(fsbinnumber) + ' in ' +AppEnv.DefaultClass.ClassHeading + ':' + DeptName);
  end;
  CleanProductId:= GetXMLNodeIntegerValue(CleanXMLNode, 'ProductId');
  CleanDeptID:= GetXMLNodeIntegerValue(CleanXMLNode, 'DeptId');
  if (CleanProductId > 0) and (CleanDeptID > 0) then begin
    if ProductId <> CleanProductID then begin
      Result:= false;
      AddResult(false, rssWarning, 0, 'Product can not be changed for an existing record');
      exit;
    end
    else if DeptID <> CleanDeptID then begin
      Result:= false;
      AddResult(false, rssWarning, 0, AppEnv.DefaultClass.ClassHeading + ' can not be changed for an existing record');
      exit;
    end;
  end;
end;


class function TProductClass._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TDeptClass','DepartmentObj','DeptID','ID');
  TBOSchema.AddRefType(result,'TDeptClass','DepartmentObj','DeptName','DeptClassName');
end;

function TProductClass.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TProductClass.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  if (changetype = dcNew) or (defaultbin_id =0) then begin
    fsbinlocation := '';
    fsBinNumber   := '';
  end else begin
    fsbinlocation := ProductBin.binlocation;
    fsBinNumber   := ProductBin.binnumber;
  end;
end;


procedure TProductClass.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.fieldName, 'ProductID') then begin
    ProductName := TProduct.IDToggle(Sender.AsInteger,Connection.Connection);
    if not RawMode then begin
      SetProductGroup(TProduct.ProductGroupForId(Sender.AsInteger,Connection.Connection));
    end;
  end else if Sysutils.SameText(Sender.fieldName, 'ClassID') then begin
    DeptName:= TDeptClass.IDToggle(Sender.AsInteger, Connection.Connection);
  end else if Sysutils.SameText(Sender.fieldName, 'ProductName') then begin
    ProductID := TProduct.IDToggle(ProductName, Connection.Connection);
    if not RawMode then begin
      SetProductGroup(TProduct.ProductGroupForId(ProductID,Connection.Connection));
    end;
  end else if Sysutils.SameText(Sender.fieldName, 'ClassName') then begin
    DeptID:= TDeptClass.IDToggle(DeptName, Self.connection.connection);
  end else if Sysutils.SameText(Sender.fieldName, 'IsDefaultStockClass') then begin
    if Sender.asBoolean then
      executeSQL('update tblproductclasses Set IsDefaultStockClass ="F" where ID <> ' + inttostr(ID)+' and ProductID =' + inttostr(ProductID) , true);
  end;
end;


function TProductClass.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TProductClass.GetIDField: string;
begin
  Result := 'ID'
end;


class function TProductClass.GetKeyStringField: string;
begin
  result := 'ProductName,ClassName';
end;

class function TProductClass.GetKeyStringProperty: string;
begin
  result:= 'ProductName,DeptName';
end;

class function TProductClass.GetBusObjectTablename: string;
begin
  Result:= 'tblproductclasses';
end;


function TProductClass.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TProductClass.GetProductID         : Integer   ; begin Result := GetIntegerField('ProductID');end;
function  TProductClass.GetProductName       : string    ; begin Result := GetStringField('ProductName');end;
function  TProductClass.GetProductGroup      : string    ; begin Result := GetStringField('ProductGroup');end;
function  TProductClass.GetDeptID            : Integer   ; begin Result := GetIntegerField('ClassID');end;
function  TProductClass.GetDeptName          : string    ; begin Result := GetStringField('ClassName');end;
function  TProductClass.GetReOrderPoint      : Double    ; begin Result := GetFloatField('ReOrderPoint');end;
function  TProductClass.GetPreferredLevel    : Double    ; begin Result := GetFloatField('PreferredLevel');end;
function  TProductClass.GetReOrderAmount     : Double    ; begin Result := GetFloatField('ReOrderAmount');end;
function  TProductClass.GetClassPriceVariance: Double    ; begin Result := GetFloatField('ClassPriceVariance');end;
function TProductClass.getDefaultbinId: Integer;begin Result := getIntegerfield('DefaultbinId');  end;
function  TProductClass.GetVariantPrice      : Double    ; begin Result := GetFloatField('VariantPrice');end;
function  TProductClass.GetWastagePercentage : Double    ; begin Result := GetFloatField('WastagePercentage');end;
function  TProductClass.GetNextStocktakeDate : TDateTime ; begin Result := GetDateTimeField('NextStocktakeDate');end;
function TProductClass.GetOnOrderQuantity: double;begin  result := self.OnOrderQty(self.ProductID, self.DeptID);end;
function  TProductClass.GetActive            : Boolean   ; begin Result := GetBooleanField('Active');end;
function  TProductClass.GetIsDefaultStockClass: Boolean   ; begin Result := GetBooleanField('IsDefaultStockClass');end;
function  TProductClass.GetUseproductforecastformula            : Boolean   ; begin Result := GetBooleanField('Useproductforecastformula');end;
function TProductClass.GetAvailableQuantity: double;begin  result := self.AvailableQty(self.ProductID, self.DeptID);end;
procedure TProductClass.SetProductID         (const Value: Integer   ); begin SetIntegerField('ProductID'          , Value);end;
procedure TProductClass.SetProductName       (const Value: string    ); begin if Value = '' then exit; SetStringField('ProductName'        , Value);end;
procedure TProductClass.SetProductGroup      (const Value: string    ); begin SetStringField('ProductGroup'       , Value);end;
procedure TProductClass.SetDeptName          (const Value: string    ); begin SetStringField('ClassName'          , Value);end;
procedure TProductClass.SetReOrderPoint      (const Value: Double    ); begin SetFloatField('ReOrderPoint'       , Value);end;
procedure TProductClass.SetPreferredLevel    (const Value: Double    ); begin SetFloatField('PreferredLevel'     , Value);end;
procedure TProductClass.SetReOrderAmount     (const Value: Double    ); begin SetFloatField('ReOrderAmount'      , Value);end;
procedure TProductClass.SetClassPriceVariance(const Value: Double    ); begin SetFloatField('ClassPriceVariance'     , Value);end;
procedure TProductClass.SetDefaultbinId(const Value: Integer);begin  SetIntegerfield('DefaultbinId' , Value);end;
procedure TProductClass.SetVariantPrice      (const Value: Double    ); begin SetFloatField('VariantPrice'       , Value);end;
procedure TProductClass.SetWastagePercentage (const Value: Double    ); begin SetFloatField('WastagePercentage'  , Value);end;
procedure TProductClass.SetNextStocktakeDate (const Value: TDateTime ); begin SetDateTimeField('NextStocktakeDate'       , Value);end;
procedure TProductClass.SetActive            (const Value: Boolean   ); begin SetBooleanField('Active'             , Value);end;
procedure TProductClass.SetIsDefaultStockClass(const Value: Boolean   ); begin SetBooleanField('IsDefaultStockClass', Value);end;
procedure TProductClass.SetUseproductforecastformula            (const Value: Boolean   ); begin SetBooleanField('Useproductforecastformula'             , Value);end;

function TProductClass.getPurchaseDescription: String;
begin
  With TERPQuery(getNewDataset('Select PURCHASEDESC from tblParts where partsId = ' +inttostr(ProductID))) do try
    result := fieldbyname('PURCHASEDESC').asString;
  finally
    closenFree;
  end;
end;

function TProductClass.GetETADate: TDateTime;
var
  strSQL:String;
begin
    strSQL:=  'Select Min(POL.ETADate) as ETADate' +
              ' FROM tblPQA PQA, tblpurchaselines pol' +
              ' Where PQA.TransLineId = POL.PurchaseLineID' +
              ' and PQA.TransType = "TPurchaseOrderLine" and PQA.IsBO ="T"' +
              ' and PQA.Active = "T"' +
              ' and PQA.DepartmentId = ' + IntTOstr(self.DeptID) +
              ' AND PQA.ProductId = ' + intToStr(self.ProductID);
    With TERPQuery.create(nil) do try
      connection := GetsharedMydacconnection;
      SQL.add(strSQL);
      open;
      result := fieldbyname('ETADate').AsDateTime;
    finally
      Free;
    end;
end;
function TProductClass.getDefaultbinLocation: String;
begin
  result := ProductBin.binlocation;
end;

function TProductClass.getDefaultbinNumber: String;
begin
  result:= ProductBin.binnumber;
end;
function TProductClass.getSalesDescription: String;
begin
  With TERPQuery(getNewDataset('Select PARTSDESCRIPTION from tblParts where partsId = ' +inttostr(ProductID))) do try
    result := fieldbyname('PARTSDESCRIPTION').asString;
  finally
    closenFree;
  end;
end;
function TProductClass.getProductBin: TProductBin;
begin
  REsult := TProductBin(getcontainercomponent(TProductBin , 'binID = ' +  IntToStr(Defaultbin_Id)));
end;
procedure TProductClass.SetDeptID            (const Value: Integer   );
begin
  SetIntegerField('ClassID'            , Value);
  Defaultbin_Id := TProductBin.Idtoggle(DeptId, fsbinlocation  , fsBinnumber);
end;
procedure TProductClass.setDefaultbinLocation(const Value: String);
begin
  fsbinlocation := Value;
  Defaultbin_Id := TProductBin.Idtoggle(DeptId, fsbinlocation  , fsBinnumber);
end;

procedure TProductClass.setDefaultbinNumber(const Value: String);
begin
  fsbinnumber := Value;
  Defaultbin_Id := TProductBin.Idtoggle(DeptId, fsbinlocation  , fsBinnumber);
end;


Class function TProductClass.QtyInStock(ProductID, ClassID:Integer): Double;
var
  strSQL:String;
begin
    strSQL:=  'Select ' +SQL4Qty(tInStock) + ' as Qty' +
              ' FROM ' + ProductTables(tSummary) +
              ' Where PC.classId = ' +IntTOstr(ClassID) +
              ' AND P.PartsId = ' + intToStr(ProductID);
    With commonDBLib.TempMyQuery do try
      SQL.add(strSQL);
      open;
      result := Round(fieldbyname('Qty').Asfloat, tcConst.GeneralRoundPlaces);
    finally
      if active then Close;
      Free;
    end;
end;
class function TProductClass.ProductInstockQty(ProductID,  ClassID: Integer;Connection: TCustomMyConnection = nil): double;
var
  strSQL:String;
begin
    strSQL:=  'Select ' +SQL4Qty(tInstock) + ' as Qty' +
              ' FROM ' + ProductTables(tSummary) +
              ' Where PC.classId = ' +IntTOstr(ClassID) +
              ' AND P.PartsId = ' + intToStr(ProductID);
    With tempMyQuery(TERPConnection(Connection)) do try
      SQL.add(strSQL);
      open;
      result := Round(fieldbyname('Qty').Asfloat, tcConst.GeneralRoundPlaces);
    finally
      if active then Close;
      Free;
    end;
end;

class function TProductClass.AvailableQty(ProductID,  ClassID: Integer;Connection: TCustomMyConnection = nil): double;
var
  strSQL:String;
begin
    strSQL:=  'Select ' +SQL4Qty(tAvailable) + ' as Qty' +
              ' FROM ' + ProductTables(tSummary) +
              ' Where PC.classId = ' +IntTOstr(ClassID) +
              ' AND P.PartsId = ' + intToStr(ProductID);
    With tempMyQuery(TERPConnection(Connection)) do try
      SQL.add(strSQL);
      open;
      result := Round(fieldbyname('Qty').Asfloat, tcConst.GeneralRoundPlaces);
    finally
      if active then Close;
      Free;
    end;
end;
class procedure TProductClass.LinkProduct(fProductID, fClassID: Integer;fConnection :TcustomMyConnection=nil);
var
  PC :TProductClass;
begin
  if fProductID = 0 then exit;
  if  fClassID = 0 then exit;

  Pc :=TProductClass.Create(nil);
  try
    PC.connection := TMyDacDataConnection.Create(PC);
    if fConnection  = nil then fConnection := GetSharedMyDacConnection;
    if fconnection <> nil then PC.Connection.Connection := fConnection; // to keep withing transaction if required;
    PC.LoadSelect('ProductID = ' + IntToStr(fProductID) + ' and ClassID = ' +IntToStr(fClassID));
    PC.DoFieldChange := False;
    if PC.count = 0 then begin
      PC.New;
      PC.ProductID := fProductID;
      PC.DeptID := fClassID;
      PC.PostDB;
    end;
  finally
    FreeAndNil(PC);
  end;

end;

class function TProductClass.OnOrderQty(ProductID,ClassID: Integer): double;
var
  strSQL:String;
begin
    strSQL:=  'Select ' +SQL4Qty(tPOBO) + ' as Qty' +
              ' FROM ' + ProductTables(tSummary) +
              ' Where PC.classId = ' +IntTOstr(ClassID) +
              ' AND P.PartsId = ' + intToStr(ProductID);
    With TERPQuery.create(nil) do try
      connection := GetsharedMydacconnection;
      SQL.add(strSQL);
      open;
      result := Round(fieldbyname('Qty').Asfloat, tcConst.GeneralRoundPlaces);
    finally
      if active then Close;
      Free;
    end;
end;

function TProductClass.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  Active := True;
  if Assigned(Owner) and (Owner is TProduct)  then begin
    ProductID:= TProduct(Owner).ID;
    if ProductName <> TProduct(Owner).ProductName then
      ProductName:= TProduct(Owner).ProductName;
  end;
end;

class function TProductClass.DefaultbinId(ProductID,ClassID: Integer): Integer;
var
  strSQL:String;
begin
    strSQL:=  'Select DefaultbinId ' +
              ' FROM tblproductclasses' +
              ' Where classId = ' +IntTOstr(ClassID) +
              ' AND ProductID = ' + intToStr(ProductID);
    With commonDBLib.TempMyQuery do try
      SQL.add(strSQL);
      open;
      result := fieldbyname('DefaultbinId').AsInteger;
    finally
      if active then Close;
      Free;
    end;
end;

{ TProductClassEx }

constructor TProductClassEx.Create(AOwner: TComponent);
begin
  inherited;
end;

function TProductClassEx.GetAllocatedBOQty: double;
begin
  result := Query.FieldByName('AllocatedBOQty').AsFloat;
end;

function TProductClassEx.GetAvailableQuantity: double;
begin
  result := Query.FieldByName('AvailableQty').AsFloat;
end;

function TProductClassEx.GetInStockQty: double;
begin
  result := Query.FieldByName('InstockQty').AsFloat;
end;

function TProductClassEx.GetPOBOQty: double;
begin
  result := Query.FieldByName('POBOQty').AsFloat;
end;

function TProductClassEx.GetQuery: TERPQuery;
begin
  if not Assigned(fQuery) then begin
    fQuery := TERPQuery.Create(self);
    fQuery.Connection := self.Connection.Connection;
    fQuery.SQL.add('Select distinct PQA.ProductID, PQA.DepartmentID, ');
    fQuery.SQL.add('Round(' + ProductQtyLib.SQL4Qty(tAvailable) + ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as AvailableQty, ');
    fQuery.SQL.add('Round(' +ProductQtyLib.SQL4Qty(tInvBO)+ ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as AllocatedBOQty, ');
    fQuery.SQL.add('Round(' +ProductQtyLib.SQL4Qty(tSO)+ ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as SOQty, ');
    fQuery.SQL.add('Round(' +ProductQtyLib.SQL4Qty(tSOBO)+ ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as SOBOQty, ');
    fQuery.SQL.add('Round(' +ProductQtyLib.SQL4Qty(tInStock)+ ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as InstockQty, ');
    fQuery.SQL.add('Round(Round(Sum(if(PQA.Active ="F" , 0,');
    fQuery.SQL.add('  if(PQA.TransType="TPurchaseOrderLine" and ifnull(PQA.IsBO , "F") ="T",');
    fQuery.SQL.add('ifnull((select QtySold from tblPurchaseLines PL inner join tblPurchaseOrders PO on PO.PurchaseOrderId=PL.PurchaseOrderId where PL.PurchaseLineId=PQA.TransLineId and PO.FuturePo="F"), 0),');
    fQuery.SQL.add('0))),5), 5) as POBOQty');
    fQuery.SQL.add('from tblPQA as PQA where PQA.ProductID = :ProductID and PQA.DepartmentID = :DepartmentID');
    fQuery.SQL.add('group by PQA.ProductID, PQA.DepartmentID');
  end;
  if not fQuery.Active then begin
    fQuery.ParamByName('ProductID').AsInteger := self.ProductID;
    fQuery.ParamByName('DepartmentID').AsInteger := self.DeptID;
    fQuery.Open;
  end;
  result := fQuery;
end;

function TProductClassEx.GetSOBOQty: double;
begin
  result := Query.FieldByName('SOBOQty').AsFloat;
end;

function TProductClassEx.GetSOQty: double;
begin
  result := Query.FieldByName('SOQty').AsFloat;
end;

procedure TProductClassEx.OnDataIdChange(
  const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  if Assigned(fQuery) and fQuery.Active then
    fQuery.Close;
end;

{ TProductClassQuantity }

constructor TProductClassQuantity.Create(AOwner: TComponent);
begin
  inherited;
  fSql := 'select * from tblProductClassQuantity';
  fFirstLoad := true;
end;

destructor TProductClassQuantity.Destroy;
begin

  inherited;
end;

function TProductClassQuantity.GetAllocatedBOQty: double;
begin
  result := GetFloatField('AllocatedBOQty');
end;

function TProductClassQuantity.GetAvailableQty: double;
begin
  result := GetFloatField('AvailableQty');
end;

class function TProductClassQuantity.GetBusObjectTablename: string;
begin
  result := 'tblProductClassQuantity';
end;

function TProductClassQuantity.GetDepartmentID: integer;
begin
  result := GetIntegerField('DepartmentID');
end;

function TProductClassQuantity.GetDepartmentName: string;
begin
  result := GetStringField('DepartmentName');
end;

class function TProductClassQuantity.GetIDField: string;
begin
  result := 'ID';
end;

function TProductClassQuantity.GetInStockQty: double;
begin
  result := GetFloatField('InStockQty');
end;

function TProductClassQuantity.GetOnOrderQty: double;
begin
  result := GetFloatField('OnOrderQty');
end;

function TProductClassQuantity.GetPOBOQty: double;
begin
  result := GetFloatField('POBOQty');
end;

function TProductClassQuantity.GetProductID: integer;
begin
  result := GetIntegerField('ProductID');
end;

function TProductClassQuantity.GetProductName: string;
begin
  result := GetStringField('ProductName');
end;

function TProductClassQuantity.GetSOBOQty: double;
begin
  result := GetFloatField('SOBOQty');
end;

function TProductClassQuantity.GetSOQty: double;
begin
  result := GetFloatField('SOQty');
end;

procedure TProductClassQuantity.Load(const fIsReadonly: boolean);
begin
  { if we are opening the whole list, update the data first .. only first time }
  if fFirstLoad then begin
    fFirstLoad := false;
    self.UpdateTableData;
  end;
  inherited;
end;

procedure TProductClassQuantity.SetAllocatedBOQty(const Value: double);
begin
  SetFloatField('AllocatedBOQty',Value);
end;

procedure TProductClassQuantity.SetAvailableQty(const Value: double);
begin
  SetFloatField('AllocatedQty',Value);
end;

procedure TProductClassQuantity.SetDepartmentID(const Value: integer);
begin
  SetIntegerField('DepartmentID',Value);
end;

procedure TProductClassQuantity.SetDepartmentName(const Value: string);
begin
  SetStringField('DepartmentName',Value);
end;

procedure TProductClassQuantity.SetInStockQty(const Value: double);
begin
  SetFloatField('InStockQty',Value);
end;

procedure TProductClassQuantity.SetOnOrderQty(const Value: double);
begin
  SetFloatField('OnOrderQty',Value);
end;

procedure TProductClassQuantity.SetPOBOQty(const Value: double);
begin
  SetFloatField('POBOQty',Value);
end;

procedure TProductClassQuantity.SetProductID(const Value: integer);
begin
  SetIntegerField('ProductID',Value);
end;

procedure TProductClassQuantity.SetProductName(const Value: string);
begin
  SetStringField('ProductName',Value);
end;

procedure TProductClassQuantity.SetSOBOQty(const Value: double);
begin
  SetFloatField('SOBOQty',Value);
end;

procedure TProductClassQuantity.SetSOQty(const Value: double);
begin
  SetFloatField('SOQty',Value);
end;

class procedure TProductClassQuantity.UpdateTableData;
var
  cmd: TERPCommand;
begin
  cmd := DbSharedObj.GetCommand(CommonDbLib.GetSharedMyDacConnection);
  try
    cmd.SQL.Add('insert into tblProductClassQuantity');
    cmd.SQL.Add('(ProductName,ProductID,DepartmentName,DepartmentID,AvailableQty,OnOrderQty,AllocatedBOQty,SOQty,SOBOQty,InStockQty,POBOQty,msTimeStamp)');
    cmd.SQL.Add('select ProductName,ProductID,DepartmentName,DepartmentID,AvailableQty,OnOrderQty,AllocatedBOQty,SOQty,SOBOQty,InStockQty,POBOQty,msTimeStamp');
    cmd.SQL.Add('from');
    cmd.SQL.add('(Select distinct PQA.ProductID, PQA.ProductName, PQA.DepartmentID, C.ClassName as DepartmentName, Max(PQA.msTimeStamp) as msTimeStamp, ');
    cmd.SQL.add('Round(' + ProductQtyLib.SQL4Qty(tAvailable) + ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as AvailableQty, ');
    cmd.SQL.add('Round(' +ProductQtyLib.SQL4Qty(tInvBO)+ ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as AllocatedBOQty, ');
    cmd.SQL.add('Round(' +ProductQtyLib.SQL4Qty(tSO)+ ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as SOQty, ');
    cmd.SQL.add('Round(' +ProductQtyLib.SQL4Qty(tSOBO)+ ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as SOBOQty, ');
    cmd.SQL.add('Round(' +ProductQtyLib.SQL4Qty(tInStock)+ ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as InstockQty, ');
    cmd.SQL.add('Round(' +ProductQtyLib.SQL4Qty(tPOBO) + ', ' + IntToStr(tcConst.GeneralRoundPlaces)+') as OnOrderQty, ');
    cmd.SQL.add('Round(Round(Sum(if(PQA.Active ="F" , 0,');
    cmd.SQL.add('  if(PQA.TransType="TPurchaseOrderLine" and ifnull(PQA.IsBO , "F") ="T",');
    cmd.SQL.add('ifnull((select QtySold from tblPurchaseLines PL inner join tblPurchaseOrders PO on PO.PurchaseOrderId=PL.PurchaseOrderId where PL.PurchaseLineId=PQA.TransLineId and PO.FuturePo="F"), 0),');
    cmd.SQL.add('0))),5), 5) as POBOQty');
    //cmd.SQL.add('
    cmd.SQL.add('from tblPQA as PQA');
    cmd.SQL.add('inner join tblClass C on C.ClassID = PQA.DepartmentID');
    cmd.SQL.add('group by PQA.ProductID, PQA.DepartmentID) as T');
    cmd.SQL.Add('on duplicate key update');
    cmd.SQL.Add('tblProductClassQuantity.AvailableQty = T.AvailableQty,');
    cmd.SQL.Add('tblProductClassQuantity.OnOrderQty = T.OnOrderQty,');
    cmd.SQL.Add('tblProductClassQuantity.AllocatedBOQty = T.AllocatedBOQty,');
    cmd.SQL.Add('tblProductClassQuantity.SOQty = T.SOQty,');
    cmd.SQL.Add('tblProductClassQuantity.SOBOQty = T.SOBOQty,');
    cmd.SQL.Add('tblProductClassQuantity.InStockQty = T.InStockQty,');
    cmd.SQL.Add('tblProductClassQuantity.POBOQty = T.POBOQty,');
    cmd.SQL.Add('tblProductClassQuantity.msTimeStamp = T.msTimeStamp;');
    cmd.Execute;
  finally
    DbSharedObj.ReleaseObj(cmd);
  end;
end;

initialization
  RegisterClass(TProductClass);
  RegisterClass(TProductClassEx);
  RegisterClass(TProductClassQuantity);

end.
