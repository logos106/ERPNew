unit BusObjStock;

{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 28/04/05  1.00.00 IJB  Initial version.
 19/05/05  1.00.01 DJH  Added TRelatedProduct Class Object and merged with TProduct.
                        Added THireProduct which inherits from TProduct.
                        Added THirePrices which is merged with THireProduct.
 25/05/05  1.00.02 IJB  Added LandedCost property to TProduct.
 26/06/05  1.00.03 BJ   Added new property for TRelatedProduct called RelatedRecordProductID
                        There was already a similar property called RelatedRecordID, Write
                        of this properfrmty searches for 'RelatedID' and sets the
                        record pointer.
                        RelatedRecordProductID : Instead of the 'RelatedID'
                        the 'ProductID' is being searched. ProductId is unique .
                        Property required for 'Hireform' at the moment.
 28/07/05  1.00.02 IJB  Added function LocateByName to TUnitOfMeasure.
 28/09/05  1.00.05 AL   Added Class THireIncurrence
 03/10/05  1.00.06 IJB  Added fields to TProduct.
 04/10/05  1.00.07 IJB  Various changes and additions as Result of creating
                        sales business object.
 22/11/05  1.00.07 BJ   autobin and autoBatch propertied added to TProduct Class.
 13/12/05  1.00.08 IJB  Added LatestCost and LatestCostDate to Product.
 09/01/06  1.00.09 IJB  Added TProductExtraBuyPrice and TProductExtraSellPrice.
 30/01/06  1.00.10 BJ   Added 'Volume' in TProduct
 15/02/06  1.00.11  AL  Added properties UOMPurchasesID and UOMSalesID to TProduct object
 18/04/06  1.00.12 BJ  UOM fields removed from TProduct Object
 25/05/06  1.00.13 BJ   new properties. Function to calculate and update the average cost
 08/06/06  1.00.14 BJ   Defined more classes for the product sub properties eg: TProductProcessSteps etc.
                        Overriden functions created for all the classes to implement the XML importing
 15/08/06  1.00.15 BJ   Dataset.. procedures are changed to normal private procedures , the
                        descendants are supposed to override the Do... procedures
 19/09/06  1.00.15 BJ   Spliting the unit - bot too big to manage
                        Product property classes moved to BusobjProductProperties
                        Hire classes into Busobjhire.
 23/01/07 1.00.16  BJ   properies for OnbuildQty and BuildingQty.
                        OnbuildQty : Qty clocked for a 'started' build group/variable build
                        BuildingQty : Qty of a groupproduct of a 'Started' Buildgroup/variable buidl group.

}
interface

uses
  classes, BusObjBase, BusObjTaxCodes, DB, wwDBLook,
  Dialogs,  MyAccess,ERPdbComponents,
  BusobjProductProperties, BusObjClient, XMLDoc, XMLIntf, BusObjClass,
  BusobjAttribProduct, BusObjEquipment, BusObjProductPicture,
  busobjProductcommission, BusObjProductBarcode, BusObjProductbin, BusobjUOM,
  BusObjProductRewardPoints , BusobjProduct, BusObjProductClass,TypesLib, JSONObject;


const
  ppctNone            =0;
  ppctLatestcost      =1;
  ppctProductcost     =2;
  ppctAverageCost     =3;
  ppctLandedcost      =4;
  ppctManCost         =5;
  ppctManLatestcost   =6;
  ppctManAverageCost  =7;
  ppctStandard        =8;
  ppctTotalLandedcost =9;



type
  TDoubleDimensionArray = array of Array of string;
  TRelatedProduct  = Class;


  TProduct = class(TProductSimple)
  private
    fUOMList              : TUnitOfMeasure;
    fProductGroupJoin     : TGeneralStringFunc;
    fbLockedAvgCost       : Boolean;
    fsPurchasesUOM        : String;
    fdPurchaseUOMMultiplier: double;
    fsSalesUOM            : String;
    fiSalesUOM            : Integer;
    fdSalesUOMMultiplier  : double;
    fiPurchaseUOM         : Integer;
    fXMLTemplateProduct   : TXMLDocument;
    fTemplateProductProps : TDoubleDimensionArray;
    fTemplateDetailstocopy: TStrings;
    fbRecalculatingBOMcostnPrice :Boolean;
    fbCalculatingMarkupPercentage :Boolean;
    function GetPreferedSupplier: TSupplier;
    function getProductAttributeProduct: TProductAttributes;
    function getCleanBuyQty1Cost: Double;
    function getcleanMarkupPercentage: double;
    function getcleanGrossMarginMode: boolean;
    function getTemplateProductDetails: String;
    procedure setTemplateProductDetails(const Value: String);
    function getEquipment: TEquipment;
    function getEquipmentId: Integer;
    function getUOMIDforManufacture: Integer;
    function getFormulaID: Integer;
    procedure setFormulaID(const Value: Integer);
    function    GetProductID				: Integer;
    function 	GetUOMPurchasesID			: Integer;
    function 	GetUOMSalesID				: Integer;
    function 	GetHasRelatedProducts		: Boolean;
    function    GetUOMPurchases				: String;
    function GetUOMPurchasesMultiplier: double;
    function    GetUOMSales					: String;
    function GetUOMSalesMultiplier: double;
    function 	GetTotalQtyInStock			: Double;
    function 	GetTotalQtyAvailable			: Double;
    function 	GetTotalQtyOnOrder			: Double;

    function GetUOMList					: TUnitOfMeasure; overload;
    function GetUOMList(IncludeInactive:Boolean): TUnitOfMeasure;overload;
    Procedure Pricechange(Sender: TField);
    Procedure Costchange(Sender: TField);
    Procedure UpdatePreferedSuppBuyPrice(const Sender: TBusObj; var Abort: Boolean);
    Procedure getdefaultUOMs;
    Procedure ProductUOMS(const Sender: TBusObj; var Abort: Boolean);
    Procedure ProductDefaultUOMs(const Sender: TBusObj; var Abort: Boolean);
    Function Qrycustomfields:TCustomMyDataset;
    function getFormulaName: String;
    procedure setFormulaName(const Value: String);

    function GetCountryOfOriginName: string;
    procedure SetCountryOfOriginName(const Value: string);
    Procedure RecalcExtraSellPrice(const Sender: TBusObj; var Abort: Boolean);
    function  GeTRelatedProduct			: TRelatedProduct;
    (*function Cost1ToCalcPrice: Double;
    function Cost2ToCalcPrice: Double;
    function Cost3ToCalcPrice: Double;*)
    function    UpdateAvgCosts: Double;Overload;
    function    UpdateManAvgCosts: Double;Overload;
  protected
    function 	GetSQL: String; override;
    procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean; override;
    Function  DoAfterOpen(Sender :TDatasetBusObj ):Boolean; override;
    Function  DoBeforeClose(Sender :TDatasetBusObj ):Boolean; override;
    Function  DoBeforeOpen(Sender :TDatasetBusObj ):Boolean; override;
    Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;  Override;
    Function  ValidateXMLData(Const node :IXMLNode) :Boolean ; override;
    Function  ImportsubClasses(const node: IXMLNode):Boolean; Override;
    Function ExportsubClasses(Const node: IXMLNode):Boolean; Override;
    procedure CustomiseauditInfo(sl:TStringlist);Override;
    procedure	SetSell_Cost_Percentage(const Value: Double);Override;
  public
    function isOktoSet(const TagName:String):Boolean;Override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    Class function isAttribProduct(const ProductID:Integer; Var GroupID:Integer):Boolean; overload;
    constructor Create(AOwner: TComponent); override;
    Procedure   New;Override;
    destructor  Destroy; override;
    Function    Save:Boolean; override;
    function    GetId: Integer; override;
    Function    ValidateData :Boolean; Override;
    procedure   SaveToXMLNode(Const node: IXMLNode); override;
    procedure   LoadFromXMLNode(Const node: IXMLNode); override;
    procedure   SetNewDefaults;
    function    AvgCost: Double;overload;
    function    ManAvgCost: Double;

    Class function    UpdateAvgCosts(AOwner:Tcomponent; Conn : TMyDacDataConnection; ProductID:Integer): Double; Overload;
    class function UpdateAvgCosts(AOwner: TComponent; Conn : TMyDacDataConnection; ProductID: Integer; StandardCost: double): Double; Overload;
    Class function    UpdateManAvgCosts(AOwner:Tcomponent; Conn : TMyDacDataConnection; ProductID:Integer): Double; Overload;
    Procedure DoUpdateAvgCosts;
    Procedure DoUpdateManAvgCosts;
    Class Procedure UpdateManLatestCosts(AOwner:Tcomponent; Cost:Double;CostDate:TDateTime; Conn : TMyDacDataConnection; ProductID:Integer);

    function    GetAutoBarcode: string;
    function    GetAutoProdCode: string;
    function    GetCostForQty(const Qty: Double): Double;overload;
    function    GetPriceForQty(const Qty: Double): Double;
    function ProductUOMLocate(const fUnitName:String):Boolean;
    class function CalcAvgCost(const ProductId: integer): Double;
    class function AvgCost(const ProductId: integer; Connection: TCustomMyConnection = nil): Double; overload;
    class function CostForQty(const ProductId: integer; Qty: Double; Connection: TCustomMyConnection = nil): Double;
    class function Cost(const ProductId: integer; Connection: TCustomMyConnection = nil): Double;
    class function PriceForQty(const ProductId: integer; Qty: Double; Connection: TCustomMyConnection = nil): Double;
    Class Procedure checkAllocation(Var batch,Multiplebins, SNTracking:Boolean);Overload;
    class procedure checkAllocation(fProductID:Integer; var fbbatch,fbMultiplebins, fbSNTracking: Boolean);Overload;
    Class function IsProductActive(const fProductID:Integer ; fconnection :TCustomMyConnection=nil):Boolean;
    Class Procedure SetProductActive(const fProductID :Integer;Value:Boolean ; fconnection :TCustomMyConnection=nil);
    class function IdForProductCode(const aProductCode: string; Connection: TCustomMyConnection = nil): integer;
    class procedure UpdateLandedCost(aProdId: integer; Value: double; fconnection :TCustomMyConnection=nil);
    property PreferedSupplier: TSupplier read GetPreferedSupplier;
    Property ProductAttributeProduct :TProductAttributes REad getProductAttributeProduct;
    Property CleanBuyQty1Cost :Double REad getCleanBuyQty1Cost;
    Property cleanMarkupPercentage :double read getcleanMarkupPercentage;
    Property cleanGrossMarginMode :boolean read getcleanGrossMarginMode;
    { Note: the following was added so TProduct.AvgCost could be used to replace
      TTransactionTableObj.AvgCost }
    property LockedAvgCost: Boolean read fbLockedAvgCost;
    class function ProductIdForBarcode(const aBarCode: string; conn: TCustomMyConnection = nil): integer; overload;
    class function ProductIdForBarcode(const aBarCode: string; var UnitOfMeasureId: integer; conn: TCustomMyConnection = nil): integer; overload;
    class Procedure SeTProductBarcode(const iProductID:Integer; const aBarCode:String; const isPrimary:Boolean ;fDBConnection: TERPConnection);
    class function ProductNameForBarcode(const aBarCode: string; conn: TCustomMyConnection = nil): String;
    function isAttribProduct:Boolean;Overload;
    Property TemplateProductDetails :String Read getTemplateProductDetails Write setTemplateProductDetails;
    Property TemplateDetailstocopy :TStrings read fTemplateDetailstocopy Write fTemplateDetailstocopy;
    function TemplateProductProps: TDoubleDimensionArray;
    Property Equipment :TEquipment REad getEquipment;
    Property EquipmentID:Integer read getEquipmentId;
    Property RecalculatingBOMcostnPrice :Boolean read fbRecalculatingBOMcostnPrice write fbRecalculatingBOMcostnPrice;
    Procedure callDoFieldOnChange(Sender: TField);
    Procedure CalcmarkupforPrice;
    procedure CalPriceCostPercent(calcfield: Integer);
    procedure CalcPriceformarkup;
    Procedure CalcCostformarkup;
    Procedure CostPriceMarkupCalc(Sender: TField);
    Class function calcMarkupPercent(fCost, fPrice:double):Double;
    Class function CalcGrossMarginPerc(fcost, fPrice:Double):Double;
    Class function CalcPricefromGross(fCost,fGrossMargin:Double):Double;
    Class function CalccostfromGross(fPrice,fGrossMargin:Double):Double;
    Class function calcPricefromMarkup(fCost, fMarkupPercent:double):Double;
    Class function calccostfromMarkup(fprice, fMarkupPercent:double):Double;
    Class function Productquery(const fsProductname :String):TERPQuery;
    Class function InTRansSQL(Const fProductID:Integer):String;
    Class function CalcTotalQtyInStock(Const fProductID:Integer):Double;
    Class Function AssignBarCode(const fproductID:Integer; fBarcode:String):Boolean;
    class Procedure SetDefaultUOM(Const PartsID:Integer;Var UOMID:Integer; var UOM:String; Var UOMMultiplier:double);
    class function ProductGroupForId(const aProductId: integer; Conn: TCustomMyConnection = nil): string;
    Property UOMIDforManufacture:Integer read getUOMIDforManufacture;
    property UOMList				: TUnitOfMeasure            Read GetUOMList;
    Property FormulaID :Integer read getFormulaID Write setFormulaID;
    property ProductId          	: Integer   Read GetProductID;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
    function IsSelectedToCopy(const TagName: String): Boolean;
    Class function    GetCostForQty(const PartsID:Integer; const Qty: Double): Double; overload;
    class function ProductAssetAccount(const aProductName: string; Conn: TCustomMyConnection = nil): string;
    class function ProductCOGSAccount(const aProductName: string; Conn: TCustomMyConnection = nil): string;
    procedure LoadSelect(Const SelectStatement: string;const fIsReadonly:boolean =False);Override;
    procedure Load(Const aId: integer;const fIsReadonly:boolean =False); Overload;override;
    Procedure   Load(const fIsReadonly:boolean =False); Overload;Override;
    Class Function MakeMagentoProduct(Data: TJsonObject; conn :TMyDacDataConnection; aSource:String):Integer;

  Published
    property UOMPurchasesID			    : Integer   Read GetUOMPurchasesID;
    property UOMSalesID				      : Integer   Read GetUOMSalesID;
    property HasRelatedProducts	    : Boolean   Read GetHasRelatedProducts;
    property UOMPurchases			      : String    Read GetUOMPurchases;
    property UOMPurchasesMultiplier : double    read GetUOMPurchasesMultiplier;
    property UOMSales				        : String    Read GetUOMSales;
    property UOMSalesMultiplier     : double    read GetUOMSalesMultiplier;
    property TotalQtyInStock		    : Double    Read GetTotalQtyInStock;
    property TotalQtyAvailable	    : Double    Read GetTotalQtyAvailable;
    property TotalQtyOnOrder		    : Double    Read GetTotalQtyOnOrder;


    Property FormulaName            : String    read getFormulaName         write setFormulaName;
    property CountryOfOriginName    : string    read GetCountryOfOriginName write SetCountryOfOriginName;
    property RelatedProducts		:  TRelatedProduct           Read GeTRelatedProduct;

    property ExtraBuyPrice			;
    property ExtraSellPrice			;
    property AlternateProducts  ;
    Property ProductProcessPart ;
    property TaxSales				    ;
    property TaxPurchase			  ;
    property ForeignPriceSell		;
    property ForeignPriceBuy		;
    property ProductSpecs			  ;
    Property ProductBarcodes    ;
    Property Pictures           ;
    Property ProductCommission  ;
    property ProductRewardPoints;
    Function DLLUpdateAvgCosts: Double;
    property PRODUCTGROUP;

  end;

  TProductWeb = class(TProduct)
  protected
    function GetPictures: TProductPicture; override;
  public
    class function GetKeyStringProperty: string; override;
  end;

  TRelatedProduct = class(TMSBusObj)
  private
    function 	GetQty              : Double;
    function 	GetParentQty        : Double;
    function 	GetHideRelated      : Boolean;
    function 	GetISContainer      : Boolean;
    function 	GetIsPallet         : Boolean;
    function 	GetRoundtoNextNum   : Boolean;
    function 	GetZeroWhenLessthan1: Boolean;
    function 	GetUseIncur         : Boolean;
    function 	GetIncurAfterTax    : Boolean;
    function 	GetIsHidden         : Boolean;
    function 	GetCanDelete        : Boolean;
    function 	GetParentProductID  : Integer;
    function 	GetProductID        : Integer;
    Function  getProductName      : String;
    function  GetParentProductName: string;
    function  GetProductPrintName : string;
    function  getIncurAmount      : Double;
    function  getExtraQty         : Double;

    procedure	setQty              (const Value: Double);
    procedure	setParentQty        (const Value: Double);
    procedure	setHideRelated      (const Value: Boolean);
    procedure	setISContainer      (const Value: Boolean);
    procedure	setIsPallet         (const Value: Boolean);
    procedure	setRoundtoNextNum   (const Value: Boolean);
    procedure	setZeroWhenLessthan1(const Value: Boolean);
    procedure	setUseIncur         (const Value: Boolean);
    procedure	setIncurAfterTax    (const Value: Boolean);
    procedure	setIsHidden         (const Value: Boolean);
    procedure	setCanDelete        (const Value: Boolean);
    procedure	setParentProductID  (const Value: Integer);
    procedure	SetProductID        (const Value: Integer);
    Procedure SetProductName      (Const Value: String);
    procedure SetParentProductName(const Value: string);
    procedure SetProductPrintName (const Value: string);
    Procedure SetIncurAmount      (Const Value :Double);
    Procedure SetExtraQty         (Const Value :Double);
  protected
    function 	GetSQL: String; override;
    procedure DoFieldOnChange(Sender: TField); override;
    Function  ValidateXMLData(Const node :IXMLNode) :Boolean ; override;
    Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean; Override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(Const node: IXMLNode); override;
    procedure SaveToXMLNode(Const node: IXMLNode); override;
    function ValidateData: boolean; override;
    function Save: Boolean; override;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
  Published
    property ParentProductID    : Integer   Read GetParentProductID   Write SetParentProductID;
    property ParentProductName  : string    read GetParentProductName write SetParentProductName;
    property ProductPrintName   : string    read GetProductPrintName  write SetProductPrintName;
    Property IncurAmount        : Double    read getIncurAmount       Write setIncurAmount;
    Property ExtraQty           : Double    read getExtraQty          Write setExtraQty;
    property ProductID          : Integer   Read GetProductID         Write SetProductID;
    property ProductName        : string    Read GetProductName       Write SetProductName;
    property HideRelated        : Boolean   Read GetHideRelated       Write SetHideRelated;
    property ISContainer        : Boolean   Read GetISContainer       Write SetISContainer;
    property IsPallet           : Boolean   Read GetIsPallet          Write SetIsPallet;
    property RoundtoNextNum     : Boolean   Read GetRoundtoNextNum    Write SetRoundtoNextNum;
    property ZeroWhenLessthan1  : Boolean   Read GetZeroWhenLessthan1 Write SetZeroWhenLessthan1;
    property UseIncur           : Boolean   Read GetUseIncur          Write SetUseIncur;
    property IncurAfterTax      : Boolean   Read GetIncurAfterTax     Write SetIncurAfterTax;
    property IsHidden           : Boolean   Read GetIsHidden          Write SetIsHidden;
    property CanDelete          : Boolean   Read GetCanDelete         Write SetCanDelete;
    property Quantity           : Double    Read GetQty               Write SetQty;
    property ParentQty          : Double    Read GetParentQty         Write SetParentQty;
  end;

implementation

uses
  SysUtils, Variants, CommonLib, tcDataUtils,
  CommonDbLib, DateUtils, DNMLib, BusObjConst,
  tcConst,
  BusObjUtils,
  AppEnvironment, ProductQtyLib, BusObjProcTreePart,
  BusobjStockAdjustEntry, BusobjProdAttribGroup, BusObjGLAccount, TypInfo,
  CompanyPrefObj, math, BusObjCountries, Types, StrUtils, BusobjProductFormula,
  BusObjectListObj, BusObjSchemaLib, ParserObj, InventoryTypes,
  PQALib, DbSharedObjectsObj, MySQLConst, LogLib;



 { TRelatedProduct }

constructor TRelatedProduct.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL:= 'SELECT * FROM tblRelatedParts';
  fIsList:= true;
  ExportExcludeList.Add('productid');
  ExportExcludeList.Add('parentproductid');
  if Assigned(Owner) and (Owner is TProduct) then
    ExportExcludeList.Add('parentproductname');
end;

destructor TRelatedProduct.Destroy;
begin
  inherited;
end;

procedure TRelatedProduct.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.fieldName, 'ProductID') then begin
    ProductName:= TProduct.IDToggle(Sender.AsInteger, Connection.Connection);
  end
  else if Sysutils.SameText(Sender.fieldName, 'PartName') then begin
    ProductID:= TProduct.IDToggle(Sender.AsString, Connection.Connection);
  end
  else if Sysutils.SameText(Sender.fieldName, 'ParentPartName') then begin
    ParentProductID:= TProduct.IDToggle(Sender.AsString, Connection.Connection);
  end;
end;

function TRelatedProduct.GetHideRelated       : Boolean ;begin  Result:= GetBooleanField('HideRelated');end;
function TRelatedProduct.GetISContainer       : Boolean ;begin  Result:= GetBooleanField('ISContainer');end;
function TRelatedProduct.GetIsPallet          : Boolean ;begin  Result:= GetBooleanField('IsPallet');end;
function TRelatedProduct.GetRoundtoNextNum    : Boolean ;begin  Result:= GetBooleanField('IsToRoundtoNextNumberinSales');end;
function TRelatedProduct.GetZeroWhenLessthan1 : Boolean ;begin  Result:= GetBooleanField('ZeroWhenLessthan1');end;
function TRelatedProduct.GetUseIncur          : Boolean ;begin  Result:= GetBooleanField('UseIncur');end;
function TRelatedProduct.GetIncurAfterTax     : Boolean ;begin  Result:= GetBooleanField('IncurAfterTax');end;
function TRelatedProduct.GetIsHidden          : Boolean ;begin  Result:= GetBooleanField('IsHidden');end;
function TRelatedProduct.GetCanDelete         : Boolean ;begin  Result:= GetBooleanField('CanDelete');end;
function TRelatedProduct.GetQty               : Double  ;begin  Result:= GetFloatField('Qty');end;
function TRelatedProduct.GetParentQty         : Double  ;begin  Result:= GetFloatField('ParentQty');end;
function TRelatedProduct.GetParentProductID   : Integer ;begin  Result:= GetIntegerField('ParentID');end;
function TRelatedProduct.GetProductID         : Integer ;begin  Result:= GetIntegerField('ProductID');end;
function TRelatedProduct.getProductName       : String  ;begin  result:= GetStringField('PartName');end;
function TRelatedProduct.GetParentProductName : string  ;begin  result:= TProduct.IDToggle(ParentProductID, Connection.Connection);end;
function TRelatedProduct.GetProductPrintName  : string  ;begin  result:= GetSTringfield('ProductPrintName');;end;
function TRelatedProduct.getIncurAmount       : double  ;begin  result:= getfloatfield('IncurAmount'); end;
function TRelatedProduct.GetSQL               : String  ;begin  Result:= Inherited GetSQL;end;
function TRelatedProduct.getExtraQty          : double  ;begin  result:= getfloatfield('ExtraQty'); end;

procedure TRelatedProduct.SetProductName      (const Value: String);begin  SetStringField('PartName', Value);end;
procedure TRelatedProduct.SetHideRelated      (const Value: Boolean);begin  SetBooleanField('HideRelated', Value);end;
procedure TRelatedProduct.SetISContainer      (const Value: Boolean);begin  SetBooleanField('ISContainer', Value);end;
procedure TRelatedProduct.SetIsPallet         (const Value: Boolean);begin  SetBooleanField('IsPallet', Value);end;
procedure TRelatedProduct.SetRoundtoNextNum   (const Value: Boolean);begin  SetBooleanField('IsToRoundtoNextNumberinSales', Value);end;
procedure TRelatedProduct.SetZeroWhenLessthan1(const Value: Boolean);begin  SetBooleanField('ZeroWhenLessthan1', Value);end;
procedure TRelatedProduct.SetUseIncur         (const Value: Boolean);begin  SetBooleanField('UseIncur', Value);end;
procedure TRelatedProduct.SetIncurAfterTax    (const Value: Boolean);begin  SetBooleanField('IncurAfterTax', Value);end;
procedure TRelatedProduct.SetIsHidden         (const Value: Boolean);begin  SetBooleanField('IsHidden', Value);end;
procedure TRelatedProduct.SetCanDelete        (const Value: Boolean);begin  SetBooleanField('CanDelete', Value);end;
procedure TRelatedProduct.SetQty              (const Value: Double);begin   SetFloatField('Qty', Value);end;
procedure TRelatedProduct.SetParentQty        (const Value: Double);begin   SetFloatField('ParentQty', Value);end;
procedure TRelatedProduct.SetParentProductID  (const Value: Integer);begin  SetIntegerField('ParentID', Value);end;
procedure TRelatedProduct.SetProductID        (const Value: Integer);begin  SetIntegerField('ProductID', Value);end;
Procedure TRelatedProduct.SetIncurAmount      (const Value: Double );begin  SetFloatField('IncurAmount' , Value);end;
Procedure TRelatedProduct.SetExtraQty         (const Value: Double );begin  SetFloatField('ExtraQty' , Value);end;
class Function TRelatedProduct.GetIDField :String ;begin    Result :='RelatedID';end;
class function TRelatedProduct.GetKeyStringProperty: string;begin  result:= '';end;
class function TRelatedProduct.GetBusObjectTablename: string;begin  Result := 'tblRelatedParts';end;


Function TRelatedProduct.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    if IsOwnerProduct(Self) then ParentProductID := TProduct(Self.Owner).ID;
    ParentQty := 1;
    Result := True;
end;

Function TRelatedProduct.ValidateXMLData(Const node :IXMLNode) :Boolean ;
var
    iParentProduct :Integer;
    iProductId :Integer;
begin
    Result := inherited ValidateXMLData(node);
    if not Result then Exit;
    if not ImportingFromXMLFile then Exit;
    XMLSearchRecordDesc :='Parent Product = ' + getXMLProductName(Self, node,'ParentProduct') +
                        ' and RelatedProduct = ' + GetXMLNodeStringValue(Node, 'RelatedProduct');

    Result := False;

    iParentProduct := CheckProduct(Self, node,'ParentProduct');
    if iParentProduct = 0 then begin
        ErrRecordNotfound('Parent Product' , GetXMLNodeStringValue(Node, 'ParentProduct'));
        Exit;
    end;

    iProductId := tcdatautils.GetProduct(GetXMLNodeStringValue(Node, 'RelatedProduct'));
    if iProductId = 0 then begin
        ErrRecordNotfound('Product' , GetXMLNodeStringValue(Node, 'RelatedProduct'));
        Exit;
    end;

    Result := True;

    XMLSearchRecord :='ParentID = ' + IntToStr(iParentProduct) + ' and ProductID = ' + IntToStr(iProductId);
    LocateXMLRecord;

end;
class function TRelatedProduct._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TProductWeb','ProductObj','ProductID','ID');
  TBOSchema.AddRefType(result,'TProductWeb','ProductObj','ProductName','ProductName');
end;

procedure TRelatedProduct.LoadFromXMLNode(Const node: IXMLNode);
begin
    inherited;
    if not ImportingFromXMLFile then begin
      SetPropertyFromNode(Node,'ParentProductID');
      SetPropertyFromNode(Node,'ProductID');
    end else begin
      ParentProductID := CheckProduct(Self,Node, 'ParentProduct');
	    ProductID	    := tcDatautils.getproduct(GetXMLNODEStringValue(Node,'RelatedProduct'));
    end;
    SetBooleanPropertyFromNode(Node,'HideRelated');
    SetBooleanPropertyFromNode(Node,'ISContainer');
    SetBooleanPropertyFromNode(Node,'IsPallet');
    SetBooleanPropertyFromNode(Node,'RoundtoNextNum');
    SetBooleanPropertyFromNode(Node,'ZeroWhenLessthan1');
    SetBooleanPropertyFromNode(Node,'UseIncur');
    SetBooleanPropertyFromNode(Node,'IncurAfterTax');
    SetBooleanPropertyFromNode(Node,'IsHidden');
    SetBooleanPropertyFromNode(Node,'CanDelete');
    SetPropertyFromNode(Node,'IncurAmount');
    SetPropertyFromNode(Node,'ExtraQty');
    SetPropertyFromNode(Node,'Quantity');
    SetPropertyFromNode(Node,'ParentQty');
    SetPropertyFromNode(Node,'ProductName');
end;
procedure TRelatedProduct.SaveToXMLNode(Const node: IXMLNode);
begin
    inherited;

    if not SavingXMLTofile then begin
	    AddXMLNode(node , 'ParentProductID',  ParentProductID);
    	AddXMLNode(node , 'ProductID', 	 ProductID);
    end else begin
        AddXMLNode(node , 'RelatedProduct', 	 tcdataUtils.GetProduct(ProductID));
        if not IsOwnerProduct(self) then
            AddXMLNode(node , 'ParentProduct', 	 tcdataUtils.GetProduct(ParentProductID));
    end;
	AddXMLNode(node , 'HideRelated', 	    HideRelated);
  AddXMLNode(node , 'ISContainer', 	    ISContainer);
  AddXMLNode(node , 'IsPallet', 	      IsPallet);
  AddXMLNode(node , 'RoundtoNextNum', 	RoundtoNextNum);
  AddXMLNode(node , 'ZeroWhenLessthan1',ZeroWhenLessthan1);
  AddXMLNode(node , 'UseIncur', 	      UseIncur);
  AddXMLNode(node , 'IncurAfterTax',    IncurAfterTax);
  AddXMLNode(node , 'IsHidden', 	      IsHidden);
  AddXMLNode(node , 'CanDelete', 	      CanDelete);
	AddXMLNode(node , 'Quantity', 	      Quantity);
  AddXMLNode(node , 'ParentQty', 	      ParentQty);
  AddXMLNode(node , 'ProductName', 	    ProductName);
  AddXMLNode(node , 'IncurAmount',      IncurAmount);
  AddXMLNode(node , 'ExtraQty',         ExtraQty);
end;

procedure TRelatedProduct.SetProductPrintName(const Value: string);begin setStringfield('ProductPrintName' , Value);end;
procedure TRelatedProduct.SetParentProductName(const Value: string);
begin
  if Value <> '' then begin
    ParentProductID:= TProduct.IDToggle(Value, Connection.Connection);
    if ParentProductID = 0 then
      ParentProductID:= -1;
  end
  else
    ParentProductID:= 0;
end;



function TRelatedProduct.ValidateData: boolean;
begin
  Result:= inherited ValidateData;
  if not Result then exit;

  if ProductId < 1 then begin
    Result:= false;
    AddResult(false, rssWarning, 0,'Product should not be blank');
    exit;
  end;
  if ParentProductID < 0 then begin
    Result:= false;
    AddResult(false, rssWarning, 0,'Parent Product not found');
    exit;
  end;
  if ParentProductId < 1 then begin
    Result:= false;
    AddResult(false, rssWarning, 0,'Parent Product should not be blank');
    exit;
  end;
  if self.Quantity = 0 then begin
    Result:= false;
    AddResult(false, rssWarning, 0,'Quantity can not be 0');
    exit;
  end;
  result:= true;
end;

function TRelatedProduct.Save: Boolean;
begin
  result:= self.ValidateData;
  if not Result then Exit;
  Result := inherited Save;
end;

{ TProduct }


constructor TProduct.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL:= 'SELECT * FROM TblParts';
  fUOMList:= nil;
  fBusObjectTypeDescription:= 'Product Object';
  SilentMode := False;
  fTemplateProductProps := nil;
  fTemplateDetailstocopy := nil;
  ExportExcludeList.Add('countryoforiginid');
  ExportExcludeList.Add('uompurchasesid');
  ExportExcludeList.Add('uomsalesid');
  ExportExcludeList.Add('productid');
  ExportExcludeList.Add('markuppercentage');
  ExportExcludeList.Add('taxpurchase');
  ExportExcludeList.Add('taxsales');
  ExportExcludeList.Add('pictures');
  ExportExcludeList.Add('lastupdated');
  ExportExcludeList.Add('datecreated');
  ExportExcludeList.Add('totalqtyavailable');
  fbRecalculatingBOMcostnPrice:=False;
  fbCalculatingMarkupPercentage := False;
end;

procedure TProduct.CustomiseauditInfo(sl: TStringlist);
begin
  inherited;
  if RecalculatingBOMcostnPrice then
    if sl[0] = Self.XMLNodename then
      sl[0] := self.XMLNodeName +' - BOM : Cost/Price Recalculated';
end;

destructor TProduct.Destroy;
begin
  FreeAndNil(fXMLTemplateProduct);
  inherited;
end;

class Function TProduct.GetIDField :String ;begin    Result :='PartsId';end;
Procedure TProduct.DoUpdateAvgCosts;
begin
  UpdateAvgCosts;
end;

Class function TProduct.UpdateAvgCosts(AOwner:Tcomponent; Conn : TMyDacDataConnection; ProductID:Integer): Double;
var
  Product :TProduct;
begin
  REsult := 0;
  Product := TProduct.create(AOwner);
  try
    Product.connection := conn;
    Product.load(ProductID);
    if Product.count =1 then
      Result := Product.UpdateAvgCosts;
  finally
    FreeandNil(Product);
  end;
end;

class procedure TProduct.UpdateLandedCost(aProdId: integer; Value: double;
  fconnection: TCustomMyConnection);
var
  cmd: TERPCommand;
begin
  if Assigned(fConnection) then
    cmd := DbSharedObj.GetCommand(fConnection)
  else
    cmd := DbSharedObj.GetCommand(CommonDbLib.GetSharedMyDacConnection);
  try
    cmd.SQL.Add('update ' + self.GetBusObjectTablename);
    cmd.SQL.Add('set LandedCost = :LandedCost');
    cmd.SQL.Add('where PartsId = :PartsId');
    cmd.ParamByName('LandedCost').AsFloat := Value;
    cmd.ParamByName('PartsId').AsInteger := aProdId;
    cmd.Execute;
  finally
    DbSharedObj.ReleaseObj(cmd);
  end;
end;

function TProduct.UpdateAvgCosts: Double;
var
  TempValue: Double;
begin
    TempValue := AvgCost;

    if (TempValue = 0) then TempValue := Self.BuyQty1Cost;
    if not fbLockedAvgCost then begin
      if not math.SameValue(AverageCost,TempValue,0.000001) then begin
        if not isreadonly then begin
          AverageCost := TempValue;
          PostDB;
        end else begin
         ExecuteSQL(*GetNewDataSet*)('update tblParts set Avgcost = ' +FloattoStr(TempValue) +' where partsId =' + intToStr(ID) , true);
        end;
      end;
    end;
    Result := TempValue;
end;
Procedure TProduct.DoUpdateManAvgCosts;
begin
   UpdateManAvgCosts;
end;
Class function    TProduct.UpdateManAvgCosts(AOwner:Tcomponent; Conn : TMyDacDataConnection; ProductID:Integer): Double;
var
  Product :TProduct;
begin
  REsult := 0;
  Product := TProduct.create(AOwner);
  try
    Product.connection := conn;
    Product.load(ProductID);
    if Product.count =1 then
      Result := Product.UpdateManAvgCosts;
  finally
    FreeandNil(Product);
  end;
end;
Class Procedure TProduct.UpdateManLatestCosts(AOwner:Tcomponent; Cost:Double;CostDate:TDateTime; Conn : TMyDacDataConnection; ProductID:Integer);
var
  Product :TProduct;
begin
  Product := TProduct.create(AOwner);
  try
    Product.connection := conn;
    Product.load(ProductID);
    if Product.count =1 then begin
      if Product.ManLatestCostDate <= CostDate then begin
        Product.ManLatestCostDate :=  Costdate;
        Product.ManLatestCost     := Cost;
        Product.PostDB;
      end;
    end;
  finally
    FreeandNil(Product);
  end;
end;
function TProduct.UpdateManAvgCosts: Double;
var
  TempValue: Double;
begin
    TempValue := ManAvgCost;

    if not fbLockedAvgCost then begin
      if not math.SameValue(ManAverageCost,TempValue,0.000001) then begin
        if not isreadonly then begin
          ManAverageCost := TempValue;
          PostDB;
        end else begin
         ExecuteSQL(*GetNewDataSet*)('update tblParts set ManAvgcost = ' +FloattoStr(TempValue) +' where partsId =' + intToStr(ID) , true);
        end;
      end;
    end;
    Result := TempValue;
end;
class function TProduct.MakeMagentoProduct(Data: TJsonObject;  conn: TMyDacDataConnection; aSource: String): Integer;
var
  Product :TProduct;
  fbnewproduct:Boolean;
  fi1:Integer;
begin
  logtext('===============================================================');
  try
        result := 0;
        Product := TProduct.Create(nil);
        try
          Product.connection := conn;
          if sametext(AppEnv.CompanyPrefs.MagentoConfig.Magento_ProductName ,'PrintName') then
               Product.loadselect('PRODUCTPRINTNAME = ' +quotedstr(Data.S['name']))
          else Product.loadselect('Partname = ' +quotedstr(Data.S['name']));
          logtext(Product.SQL);
          logtext(inttostr(Product.ID));
          fbnewproduct:=Product.count =0;
          TProductSimple.MakeProduct(Data.S['name'], nil, false, false, false , sametext(AppEnv.CompanyPrefs.MagentoConfig.Magento_ProductName ,'PrintName') );
          Product.Closedb;
          Product.OpenDb;
          logtext(inttostr(Product.ID));
          if Product.count >0 then begin
              Product.Connection.beginnestedTransaction;
              try
                  Product.PublishOnWeb := True; // this is magento product
                    {Product description from magento
                    as its a compulsory field in magento}
                    if Data.Exists('custom_attributes') then
                      if data.A['custom_attributes'].count >0 then begin
                        for fi1 := 0 to data.A['custom_attributes'].count-1 do begin
                          if TJsonobject(data.A['custom_attributes'].items[fi1]).exists('attribute_code') then
                            if sametext(TJsonobject(data.A['custom_attributes'].items[fi1]).S['attribute_code'] , 'description') then begin
                              Product.SalesDescriptionMemo := TJsonobject(data.A['custom_attributes'].items[fi1]).S['Value'];
                              (*if length(trim(TJsonobject(data.A['custom_attributes'].items[fi1]).S['Value']))> 255 then
                                  Product.SalesDescriptionMemo := TJsonobject(data.A['custom_attributes'].items[fi1]).S['Value']
                              else Product.SalesDescription := TJsonobject(data.A['custom_attributes'].items[fi1]).S['Value'];*)
                              break;
                            end;
                        end;
                      end;

                    if AppEnv.CompanyPrefs.MagentoConfig.Magento_CopyProductinfoToERP or fbnewproduct then begin
                        if Data.Exists('price') then begin
                          Product.SellQty1PriceInc :=Data.F['price'];
                          Product.SellQty2PriceInc :=Data.F['price'];
                          Product.SellQty3PriceInc :=Data.F['price'];
                        end;
                    end;
                    Product.PostDB;
                    Product.Connection.CommitnestedTransaction;
                    Result :=Product.ID;
              Except
                on E:Exception do begin
                    result := 0;
                    Product.Connection.RollbacknestedTransaction;
                end;
              end;
          end;
        finally
          Freeandnil(Product);
        end;
  finally
      logtext('===============================================================');
  end;
end;

function TProduct.ManAvgCost: Double;
var
  QtyOnHand: Double;
  AvgTotal: Double;
  AvgCount: Double;
  BuyQty: Double;
  BuyPrice: Double;
  strSql :String;
begin
  result :=ManAverageCost;
  AvgTotal := 0;
  fbLockedAvgCost := false;

  strSQL:=  ' SELECT ' +
            ' pt.PartsId  as ProductID, ' +
            ' pqa.transdate, ' +
            ' "MANUF", ' +
            ' pt.ProcTreeId TransID, ' +
            ' round(pt.cost /pt.TreePartUOMQuantity/pt.TreePartUOMMultiplier,5) as LineCost , ' +
            ' pqa.Qty Shipped ' +
            ' FROM tblproctree pt '+
            ' inner join tblproctreepart PTP on PTP.ProcTreeId= PT.ProcTreeId'+
            ' inner join  tblPQA pqa   ' +
            ' ON PTP.ProcTreePartId = PQA.TransLineID AND pqa.Active = "T"  ' +
            ' AND pqa.Alloctype = "IN" and pqa.Qty >0 ' +
            ' AND PQA.Transtype =' + quotedStr(TProcTreePart.ClassName) +
            ' AND pt.PartsId = ' + IntToStr(ProductID)  +
            ' AND pt.Complete = "T" AND ParentId = 0 '+
            ' Order by ProductID , transdate desc,transID desc; ';


  With getNewDataset(strSql,true) do Try
    if RecordCount > 0 then begin
      First;
      QtyOnHand := TotalQtyInStock;
      AvgCount := QtyOnHand;
//      LastCost := FieldByName('LineCost').AsFloat;
//      BuyPrice:= FieldByName('LineCost').AsFloat;
      if QtyOnHand > 0 then begin
        while (AvgCount > 0) and (not Eof) do begin
          BuyQty := FieldByName('Shipped').AsFloat;
          BuyPrice := FieldByName('LineCost').AsFloat;
          if BuyQty > 0 then begin
            if (AvgCount > BuyQty) then begin
              AvgTotal := AvgTotal + (BuyQty * (BuyPrice ));
              AvgCount := AvgCount - BuyQty;
            end else begin
              AvgTotal := AvgTotal + (AvgCount * (BuyPrice ));
              AvgCount := AvgCount - AvgCount;
            end;
          end;
          Next;
        end;
        Result := Divzer(AvgTotal,QtyOnHand);
      end;
    end;
  Finally
    if Active then Close;
    Free;
  end;
end;

function TProduct.AvgCost: Double;
var
  QtyOnHand: Double;
  AvgTotal: Double;
  AvgCount: Double;
  BuyQty: Double;
  BuyPrice: Double;
  LandedCostsPerItem: Double;
  LastCost: Double;
  qry: TERPQuery;
begin
  BuyPrice := 0;
  AvgTotal := 0;
  LastCost := 0.00;
  fbLockedAvgCost := false;


  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Connection.Connection);
  try
    With qry do begin
      commondblib.closedb(Qry);
      sql.text := InTransSQL(ProductID);
      commondblib.opendb(Qry);
      if RecordCount > 0 then begin
        First;
        QtyOnHand := TotalQtyInStock;
        AvgCount := QtyOnHand;
        if AppEnv.CompanyPrefs.IncludeLandedCostsinAvgCost then begin
          LastCost := FieldByName('LineCost').AsFloat + FieldByName('LandedCostsPerItem').AsFloat;
        end else begin
          LastCost := FieldByName('LineCost').AsFloat;
        end;
        BuyPrice:= FieldByName('LineCost').AsFloat;
        if QtyOnHand > 0 then begin
          while (AvgCount > 0) and (not Eof) do begin
            BuyQty := FieldByName('Shipped').AsFloat;
            BuyPrice := FieldByName('LineCost').AsFloat;
            if AppEnv.CompanyPrefs.IncludeLandedCostsinAvgCost then begin
              LandedCostsPerItem := FieldByName('LandedCostsPerItem').AsFloat;
            end else begin
              LandedCostsPerItem := 0;
            end;
            if BuyQty > 0 then begin
              if (AvgCount > BuyQty) then begin
                AvgTotal := AvgTotal + (BuyQty * (BuyPrice + LandedCostsPerItem));
                AvgCount := AvgCount - BuyQty;
              end else begin
                AvgTotal := AvgTotal + (AvgCount * (BuyPrice + LandedCostsPerItem));
                AvgCount := AvgCount - AvgCount;
              end;
            end;
            Next;
          end;
        end else begin
          if not (QtyOnHand = 0) then begin
            fbLockedAvgCost := true;
          end;
          AvgTotal := AvgCost(ID);
          QtyOnHand := 1;
        end;
      end else begin
        AvgTotal := 0;
        QtyOnHand := 1;
      end;
      case AppEnv.CompanyPrefs.StockCostSystem of
        scsFIFO:begin
          Result := BuyPrice;
          if (result =0) and (recordcount=0) then   result:=  Self.BuyQty1Cost;
        end;
        scsLast:begin
          Result := LastCost;
          if (result =0) and (recordcount=0) then   result:=  Self.BuyQty1Cost;
        end;
        scsAvg :begin
          Result := Divzer(AvgTotal,QtyOnHand);
          if (result=0) and (AvgTotal=0)   then  Result:= Self.BuyQty1Cost;
        end else     Result := Self.BuyQty1Cost;//0.00;
      end;
    end;

  Finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TProduct.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  if Assigned(fUOMList)                 then    FreeAndNil(fUOMList);
  fsSalesUOM := '';
  fsPurchasesUOM := '';
  fiSalesUOM := 0;
  fiPurchaseUOM := 0;
  fdPurchaseUOMMultiplier := 1;
  fdSalesUOMMultiplier := 1;
end;


function TProduct.ProductUOMLocate(const fUnitName:String):Boolean;
var
  fuomid:Integer;
  SCR:TERPScript;
begin
  REsult := False;
  if UOMList.Locate('UnitName;PartID', varArrayof([funitname,self.ID]), []) then begin
        Result := True;
        Exit;
  end;
  With GetUOMList(true) do begin
    try
      if Locate('UnitName;PartID', varArrayof([funitname,self.ID]), []) then begin
        Result := True;
      end else  if Locate('UnitName;PartID', varArrayof([funitname,0]), []) or Locate('UnitName;PartID', varArrayof([funitname,NULL]), []) then begin
          if BaseUnitName <> '' then begin
            fuomid := Id;
            ProductUOMLocate(BaseUnitName);
            Locate(IDfieldname , fuomid, []);
          end;
          if TUnitOfMeasure.CreateNewUOM(XML , self.Id) then begin
            closeDB;
            OpenDB;
            result := Dataset.Locate('UnitName;PartID', varArrayof([funitname,self.ID]), []);
          end;
(*      end else begin
        TUnitOfMeasure.CreateNewUOM(Self, ID, fsUnitname, 1 , fsUnitname, '');
        closeDB;
        OpenDB;
        result := Dataset.Locate('UnitName;PartID', varArrayof([funitname,self.ID]), []);
        REsult := True;*)
      end;
    finally
      if result then begin
        if  not Active then begin
          if userlock.lock('tblunitsofmeasure' , ID) then begin
            try
              //With SharedScript('Update tblunitsofmeasure Set Active ="T" where UnitID = ' + inttostr(ID)) do
              scr:= DbSharedObj.GetScript(CommonDBLib.GetSharedMyDacConnection);
              try
                scr.SQL.Text :='Update tblunitsofmeasure Set Active ="T" where UnitID = ' + inttostr(ID);
                scr.Execute;
              finally
                DbSharedObj.ReleaseObj(scr);
              end;
            finally
              userlock.unlock('tblunitsofmeasure' , ID);
            end;
          end else begin
            ResultStatus.AddItem(False, rssWarning, 0, 'The UOM ' +quotedstr(funitname) +' for Product ' + Quotedstr(Self.productName) +' is Inactive.' + NL+
                                    replacestr(Userlock.lockmessage , 'Unable to update data.' , 'Unable to re-activate it automatically.')+NL +
                                    'You need to goto the ''Unit of Measure List'' and manually activate it to use it.');
            Result := false;
          end;
        end;
        uomlist.Locate('UnitName;PartID', varArrayof([funitname,self.ID]), []) ;
      end;
    end;
  end;
end;
function TProduct.GetUOMList: TUnitOfMeasure;
begin
  result :=  GetUOMList(False);
end;
function    TProduct.GetUOMList(IncludeInactive:Boolean): TUnitOfMeasure;
var
  s:String;
begin
      s:=  'SELECT  ' +
           ' U.UnitID, '+
           ' U.UnitName, '+
           ' U.UnitDescription, '+
           ' U.Multiplier, '+
           ' U.BaseUnitName, '+
           ' U.BaseUnitID, '+
           ' U.Active, '+
           ' U.PartID, '+
           ' U.SalesDefault, '+
           ' U.PurchasesDefault, '+
           ' U.Weight ' +
           ' FROM tblunitsofmeasure U  ' +
           ' WHERE  U.PartID = ' + IntToStr(Self.ID) ;
      if IncludeInactive =false then s:= s + ' AND U.ACTIVE = "T"  ';
      s:= s +' union all  ' +
           ' SELECT  ' +
           ' U.UnitID, '+
           ' U.UnitName, '+
           ' U.UnitDescription, '+
           ' U.Multiplier, '+
           ' U.BaseUnitName, '+
           ' U.BaseUnitID, '+
           ' U.Active, '+
           ' U.PartID, '+
           ' U.SalesDefault, '+
           ' U.PurchasesDefault, '+
           ' U.Weight ' +
           ' FROM tblunitsofmeasure U  ' +
           ' WHERE ifnull(U.PartID,0) = 0 ' ;
      if IncludeInactive =false then s:= s + ' AND U.ACTIVE = "T"  ';
      s:= s + ' AND  Unitname not  in (Select unitname from  tblunitsofmeasure where PartID = ' + IntToStr(Self.ID)  ;
      if Includeinactive =false then s:= s+' and active ="T" ';
      s:= s + ' )  ' ;
      s:= s + ' Order By UnitID desc ,UnitName;';
  if not Assigned(fUOMList) then begin
    fUOMList:= TUnitOfMeasure.Create(Self);
    if Assigned(self.Connection) then fUOMList.connection := Self.Connection;
  end;
  if not SameTExt(s ,fUOMList.SQL ) then begin
    fUOMList.Closedb;
    fUOMList.SQL  := s;
    fUOMList.Load;
  end;
  Result:= fUOMList;
end;


Procedure TProduct.Pricechange(Sender: TField);
begin
  if (SellQty2 < SellQty1) and (SellQty2 <> 0 ) then  begin
      SellQty2 := SellQty1;
      SellQty2Price := SellQty1Price;
  end;
  if (SellQty3 < SellQty2) and (SellQty3 <> 0) then  begin
      SellQty3 := SellQty2;
      SellQty3Price := SellQty2Price;
  end;
  if (SellQty3 < SellQty1) and (SellQty3 <> 0) then  begin
      SellQty3 := SellQty1;
      SellQty3Price := SellQty1Price;
  end;

  if (SellQty2Price <> SellQty1Price) and (Sellqty2 = Sellqty1) then SellQty2Price := SellQty1Price;
  if (SellQty3Price <> SellQty2Price) and (SellQTY3 = SellQTY2) then SellQty3Price := SellQty2Price;
  if (SellQty3Price <> SellQty1Price) and (SellQTY3 = SellQTY1) then SellQty3Price := SellQty1Price;
end;
Procedure TProduct.Costchange(Sender: TField);
begin
  if (buyqty2 < buyqty1) and (buyQty2 <> 0 ) then  begin
      BuyQTY2 := BuyQTY1;
      BuyQty2Cost := BuyQty1Cost;
  end;
  if (buyqty3 < buyqty2) and (buyqty3 <> 0) then  begin
      BuyQTY3 := BuyQTY2;
      BuyQty3Cost := BuyQty2Cost;
  end;
  if (buyqty3 < buyqty1) and (buyqty3 <> 0) then  begin
      BuyQTY3 := BuyQTY1;
      BuyQty3Cost := BuyQty1Cost;
  end;

  if (BuyQty2Cost <> BuyQty1Cost) and (Buyqty2 = Buyqty1) then BuyQty2Cost := BuyQty1Cost;
  if (BuyQty3Cost <> BuyQty2Cost) and (BuyQTY3 = BuyQTY2) then BuyQty3Cost := BuyQty2Cost;
  if (BuyQty3Cost <> BuyQty1Cost) and (BuyQTY3 = BuyQTY1) then BuyQty3Cost := BuyQty1Cost;
end;
Procedure TProduct.RecalcExtraSellPrice(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TProductExtraSellPrice) then exit;
  TProductExtraSellPrice(Sender).ReCalcPrice;
end;
procedure TProduct.DoFieldOnChange(Sender: TField);
var
    fs, s :String;
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  fs := uppercase(Sender.FieldName);
{---} if (fs = 'COST1') or (fs = 'COST2') or (fs = 'COST3') or
        (fs = 'BUYQTY1') or (fs = 'BUYQTY2') or (fs = 'BUYQTY3')  then begin
        if not RawMode then begin
          CostChange(Sender);
          if fs = 'COST1' then begin
            if not silentmode then
              if BuyQty1cost <> 0 then
                  if Attrib1Purchase <>0 then
                      Attrib1PurchaseRate :=DivZer(BuyQty1cost, Attrib1Purchase);
              BuyQty1costInc := Round(GetAmountInc(BuyQty1cost, GetTaxRate(TaxCodePurchase)), RoundPlacesGeneral);
              BuyQty2costInc := Round(GetAmountInc(BuyQty2cost, GetTaxRate(TaxCodePurchase)), RoundPlacesGeneral);
              BuyQty3costInc := Round(GetAmountInc(BuyQty3cost, GetTaxRate(TaxCodePurchase)), RoundPlacesGeneral);
          end else if fs = 'COST2' then begin
              BuyQty2costInc := Round(GetAmountInc(BuyQty2cost, GetTaxRate(TaxCodePurchase)), RoundPlacesGeneral);
              BuyQty3costInc := Round(GetAmountInc(BuyQty3cost, GetTaxRate(TaxCodePurchase)), RoundPlacesGeneral);
          end else if fs = 'COST3' then
              BuyQty3costInc := Round(GetAmountInc(BuyQty3cost, GetTaxRate(TaxCodePurchase)), RoundPlacesGeneral);
        end;
{---} end else if (fs = 'PRICE1') or (fs = 'PRICE2') or (fs = 'PRICE3') or
        (fs = 'SELLQTY1') or (fs = 'SELLQTY2') or (fs = 'SELLQTY3')  then begin
        if not RawMode then begin
          PriceChange(Sender);
          if fs = 'PRICE1' then begin
            if not silentmode then
              if SellQty1Price <> 0 then
                  if Attrib1Sale <> 0 then Attrib1SaleRate :=DivZer(SellQty1Price, Attrib1Sale);
            SellQty1PriceInc := Round(GetAmountInc(SellQty1Price, GetTaxRate(TaxCodeSales)), RoundPlacesGeneral) ;
            SellQty2PriceInc := Round(GetAmountInc(SellQty2Price, GetTaxRate(TaxCodeSales)), RoundPlacesGeneral);
            SellQty3PriceInc := Round(GetAmountInc(SellQty3Price, GetTaxRate(TaxCodeSales)), RoundPlacesGeneral);
            ExtraSellPrice.IterateRecords(RecalcExtraSellPrice);
          end else if fs = 'PRICE2' then begin
              SellQty2PriceInc := Round(GetAmountInc(SellQty2Price, GetTaxRate(TaxCodeSales)), RoundPlacesGeneral);
              SellQty3PriceInc := Round(GetAmountInc(SellQty3Price, GetTaxRate(TaxCodeSales)), RoundPlacesGeneral);
          end else if fs = 'PRICE3' then
              SellQty3PriceInc := Round(GetAmountInc(SellQty3Price, GetTaxRate(TaxCodeSales)), RoundPlacesGeneral);
        end;

{---} end else if fs = 'ACTIVE' then begin
        if not RawMode then begin
          if Self.Active = False then
              if Self.TotalStockQty <> 0 then begin
                  Active := true;
                  self.AddResult(false, rssWarning, BOR_Product_Err_Main,
                          Self.Productname+' Can''t Be Made Inactive.  There is Stock or Transactions Outstanding !', true);
              end;
        end;
{---} end else if (fs = 'PREFEREDSUPP' ) or (fs = 'SUPPLIERPRODUCTCODE') then begin
        if not RawMode then begin
          ExtraBuyPrice.IterateRecords(UpdatePreferedSuppBuyPrice);
        end;
{---} end else if fs = 'COSTINC1' then begin
        if not RawMode then begin
          BuyQty1cost := Round(GetAmountEx(BuyQty1costInc, GetTaxRate(TaxCodePurchase)),RoundPlacesGeneral);
        end;
{---} end else if fs = 'COSTINC2' then begin
        if not RawMode then begin
          BuyQty2cost := Round(GetAmountEx(BuyQty2costInc, GetTaxRate(TaxCodePurchase)),RoundPlacesGeneral);
        end;
{---} end else if fs = 'COSTINC3' then begin
        if not RawMode then begin
          BuyQty3cost := Round(GetAmountEx(BuyQty3costInc, GetTaxRate(TaxCodePurchase)),RoundPlacesGeneral);
        end;
{---} end else if fs = 'PRICEINC1' then begin
        if not RawMode then begin
          SellQty1Price := Round(GetAmountEx(SellQty1PriceInc, GetTaxRate(TaxCodeSales)),RoundPlacesGeneral);
          if not silentmode then
            if SellQty1Price <> 0 then
                  if Attrib1Sale <> 0 then Attrib1SaleRate :=DivZer(SellQty1Price, Attrib1Sale);
        end;
{---} end else if fs = 'PRICEINC2' then begin
        if not RawMode then begin
          SellQty2Price := Round(GetAmountEx(SellQty2PriceInc, GetTaxRate(TaxCodeSales)),RoundPlacesGeneral);
        end;
{---} end else if fs = 'PRICEINC3' then begin
        if not RawMode then begin
          SellQty3Price := Round(GetAmountEx(SellQty3PriceInc, GetTaxRate(TaxCodeSales)),RoundPlacesGeneral);
        end;
{---} end else if fs = 'SELL_COST_PERCENTAGE' then begin
        if not RawMode then begin
          Sender.AsFloat := Round(Sender.AsFloat,2);
        end;
{---} end else if fs = 'ISVARIABLE' then begin
{---} end else if fs = 'BARCODE' then begin
        if not RawMode then begin
          if Sender.AsString <> '' then begin
            s := ProductNameForBarcode(Barcode, self.Connection.Connection);
            if s = '' then  begin
              { new barcode ok so need to add to barcode list }
              if self.ID < 1 then
                self.PostDb;
              if not ProductBarcodes.Locate('Barcode',Barcode,[loCaseInsensitive]) then begin
                ProductBarcodes.New;
                ProductBarcodes.BarCode:= Barcode;
                ProductBarcodes.ProductID:= self.ID;
                ProductBarcodes.IsprimaryBarcode:= true;
                ProductBarcodes.Active:= true;
                ProductBarcodes.PostDb;
                Exit;
              end;
            end
            else if s = ProductName then begin
              { make sure this is primary product barcode }
              if ProductBarcodes.Locate('Barcode',Barcode,[loCaseInsensitive]) then begin
                ProductBarcodes.Active:= true;
                ProductBarcodes.PostDb;
              end
              else begin
                { not in list so add it }
                ProductBarcodes.New;
                ProductBarcodes.BarCode:= Barcode;
                ProductBarcodes.ProductID:= self.ID;
                ProductBarcodes.IsprimaryBarcode:= true;
                ProductBarcodes.Active:= true;
                ProductBarcodes.PostDb;
              end;
            end
            else begin
              { this barcode is used by a different product }
              BarCode := '';
              self.AddResult(false, rssWarning, BOR_Product_Err_Misc,
                'This barcode has already been used with Part Name ' + Trim(s) + '.  Barcode should be unique');
            end;
          end;
        end;
{---} end else if fs = 'ATTRIB1PURCHASE' then begin
        if not RawMode then begin
          if Attrib1Purchase <> 0 then
              if BuyQty1cost <>0 then
                  Attrib1PurchaseRate :=DivZer(BuyQty1cost , Attrib1Purchase);
        end;
{---} end else if fs = 'ATTRIB1SALE' then begin
        if not RawMode then begin
          if Attrib1Sale <> 0 then
              if SellQty1Price <> 0 then
                  Attrib1saleRate := divZer(SellQty1Price , Attrib1Sale);
        end;
{---} end else  if fs = 'ATTRIB2SALE' then begin
        if not RawMode then begin
          if Attrib2Sale <> Attrib2Purchase then Attrib2Purchase := Attrib2Sale;
        end;
{---} end else  if fs = 'ATTRIB2PURCHASE' then begin
        if not RawMode then begin
          if Attrib2Purchase <> Attrib2sale then Attrib2sale := Attrib2Purchase;
        end;
{---} end;
      if not RawMode then begin
        if fbCostPriceMarkupCalc then  CostPriceMarkupCalc(Sender);
      end;
end;

Function TProduct.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    Result := True;
    CogsAccount     := TAccount.IDToggle(AppEnv.CompanyPrefs.DefPartsCOGSAccount);
    AssetAccount    := TAccount.IDToggle(AppEnv.CompanyPrefs.DefPartsAssetAccount);
    IncomeAccount   := TAccount.IDToggle(AppEnv.CompanyPrefs.DefPartsIncomeAccount);
    TaxCodePurchase := appenv.CompanyPrefs.DefaultPurchaseTaxCode;
    TaxCodeSales    := appenv.CompanyPrefs.DefaultSalesTaxCode;
    DocumentPath    := Appenv.DocPath.DocumentPath;
end;
Function  TProduct.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
    result := inherited;
end;

function TProduct.DoBeforeClose(Sender: TDatasetBusObj): Boolean;
begin
     result := inherited DoBeforeClose(sender);
     if not result then exit;
end;

function TProduct.DoBeforeOpen(Sender: TDatasetBusObj): Boolean;
begin
     result := inherited DoBeforeOpen(sender);
     if not result then exit;
end;

Procedure TProduct.Load(const fIsReadonly:boolean =False);
begin
    inherited;
    if dataset.Active = False then Exit;
end;

Procedure TProduct.New;
begin
    Self.Dataset.Append;
    SetNewDefaults;
end;

procedure TProduct.SetNewDefaults;
begin
    CogsAccount := 'Cost of Goods Sold';
    if AppEnv.CompanyPrefs.DefPartsCOGSAccount <> 0 then
      CogsAccount := GetAccountName(AppEnv.CompanyPrefs.DefPartsCOGSAccount);

    IncomeAccount := 'Sales';
    if AppEnv.CompanyPrefs.DefPartsIncomeAccount <> 0 then
      IncomeAccount := GetAccountName(AppEnv.CompanyPrefs.DefPartsIncomeAccount);

    AssetAccount:= 'Inventory Asset';
    if AppEnv.CompanyPrefs.DefPartsAssetAccount <> 0 then
      AssetAccount:= GetAccountName(AppEnv.CompanyPrefs.DefPartsAssetAccount);

    DateCreated     := Now;
    Active          := True;
    TaxCodePurchase := appenv.CompanyPrefs.DefaultPurchaseTaxCode;
    TaxCodeSales    := appenv.CompanyPrefs.DefaultSalesTaxCode;
    BuyQTY1         := 1;
    BuyQTY2         := 1;
    BuyQTY3         := 1;
    BuyQTY1Cost     := 0.00;
    BuyQTY2cost     := 0.00;
    BuyQTY3COST     := 0.00;
    SellQTY3        := 1;
    SellQTY2        := 1;
    SellQTY1        := 1;
    SellQty1Price    := 0.00;
    SellQty2Price    := 0.00;
    SellQty3Price    := 0.00;
    Batch           := False;
    MultipleBins    := False;

    if AppEnv.CompanyPrefs.AutoAddBarcodes then BARCODE := Self.GetAutoBarcode;
    if AppEnv.CompanyPrefs.AutoAddProdcode then PRODUCTCODE := Self.GetAutoProdcode;
end ;
function TProduct.GetAutoBarcode: string;
begin
  result := tcdatautils.GetAutoBarcode(connection.connection);
  (*    Result := '1';
    With GetNewDataset('SELECT MAX(Truncate(P.Barcode, 0)) + 1 AS PBarcode  FROM tblparts P ORDER BY PBarcode  DESC LIMIT 1' , True) do try
        if recordcount > 0 then
            Result := FieldByName('PBarcode').AsString;
        Close;
        SQL.text := ' SELECT Barcode AS PBarcode  FROM tblpartbarcodes WHERE Barcode = :Barcode ';
        Repeat
            if active then close;
            Parambyname('Barcode').AsString := Result;
            open;
            if recordcount >0 then Result := Floattostr(trunc(Strtofloat(REsult)+1));
        Until recordcount =0;
    Finally
      Close;
      Free;
    end;*)
end;

function TProduct.GetAutoProdCode: string;
begin
  With getNewDataset('SELECT MAX(Truncate(Productcode, 0)) + 1 as Productcode FROM tblparts' , True) do Try
    Result := fieldByname('Productcode').asString;
  finally
    Close;
    Free;
  end;
end ;

function TProduct.GetUOMPurchasesID: Integer;
begin
  if fiPurchaseUOM = 0 then getdefaultUOMs;
  Result := fiPurchaseUOM;
end;

function TProduct.GetUOMPurchasesMultiplier: double;
begin
  if fsPurchasesUOM = '' then getdefaultUOMs;
  Result := fdSalesUomMultiplier;
end;

function TProduct.GetUOMSalesID: Integer;
begin
  if fiSalesUOM = 0 then getdefaultUOMs;
  Result := fiSalesUOM;
end;

function TProduct.GetUOMSalesMultiplier: double;
begin
  if fsSalesUOM = '' then getdefaultUOMs;
  Result := fdSalesUomMultiplier;
end;

function TProduct.GetCostForQty(const Qty: Double): Double;
begin
  Result:= BuyQty1Cost;
  if (BuyQty2 <> 0) and (Qty >= BuyQty2) then Result:= BuyQty2Cost;
  if (BuyQty3 <> 0) and (Qty >= BuyQty3) then Result:= BuyQty3Cost;
end;

function TProduct.GetPriceForQty(const Qty: Double): Double;
begin
    Result:= self.SellQty1Price;
    if SalesTaxBasedonProductPrice then exit; // Qty price discount not applicable when the Sales tax based on Prouct Price
    if (SellQty2 <> 0) and (Qty >= SellQty2) then Result:= SellQty2Price;
    if (SellQty3 <> 0) and (Qty >= SellQty3) then Result:= SellQty3Price;
end;




function TProduct.GetSQL: String;
begin
  Result:= inherited GetSQL;
end;

Procedure  TProduct.getdefaultUOMs;
var
  SaveIsReadOnly:Boolean;
begin
  fsPurchasesUOM := '';
  fsSalesUOM := '';
  fiPurchaseUOM := 0;
  fiSalesUOM := 0;
  UOMList.IterateRecords(ProductUOMS);
  if (fsPurchasesUOM = '') or (fsSalesUOM = '' ) then UOMList.IterateRecords(ProductDefaultUOMs);
  if fsPurchasesUOM = '' then begin
    SaveIsReadOnly:= IsReadonly;
    IsReadonly:= false;
    try
      fiPurchaseUOM := TUnitOfMeasure.CreateNewUOM(self, ID, AppEnv.DefaultClass.DefaultUOM);
    finally
      IsReadonly:= SaveIsReadOnly;
    end;
    fsPurchasesUOM := AppEnv.DefaultClass.DefaultUOM;
  End;
  if fsSalesUOM = '' then begin
    SaveIsReadOnly:= IsReadonly;
    IsReadonly:= false;
    try
      fiSalesUOM := TUnitOfMeasure.CreateNewUOM(self, ID, AppEnv.DefaultClass.DefaultUOM);
    finally
      IsReadonly:= SaveIsReadOnly;
    end;

    fsSalesUOM := AppEnv.DefaultClass.DefaultUOM;
  end;
end;

function TProduct.GetUOMPurchases: String;
begin
  if fsPurchasesUOM =  '' then  getdefaultUOMs;
  REsult :=fsPurchasesUOM;
end;


function TProduct.GetUOMSales: String;
begin
  if fsSalesUOM = '' then getdefaultUOMs;
  Result := fsSalesUom;
end;

(*Function TProduct.Cost1ToCalcPrice :Double;
begin
  result := BuyQty1Cost;
       if  ProductPriceCalctype = ppctLatestcost     Then result := LatestCost
  else if  ProductPriceCalctype = ppctAverageCost    Then result := AvgCost
  else if  ProductPriceCalctype = ppctLandedcost     Then result := LandedCost
  else if  ProductPriceCalctype = ppctManCost        Then result := MancostWithLabour
  else if  ProductPriceCalctype = ppctManLatestcost  Then result := ManLatestCost
  else if  ProductPriceCalctype = ppctManAverageCost Then result := ManAverageCost;
end;
Function TProduct.Cost2ToCalcPrice :Double;
begin
  result := BuyQty2Cost;
       if  ProductPriceCalctype = ppctLatestcost     Then result := LatestCost
  else if  ProductPriceCalctype = ppctAverageCost    Then result := AvgCost
  else if  ProductPriceCalctype = ppctLandedcost     Then result := LandedCost
  else if  ProductPriceCalctype = ppctManCost        Then result := MancostWithLabour
  else if  ProductPriceCalctype = ppctManLatestcost  Then result := ManLatestCost
  else if  ProductPriceCalctype = ppctManAverageCost Then result := ManAverageCost;

end;
Function TProduct.Cost3ToCalcPrice :Double;
begin
  result := BuyQty3Cost;
       if  ProductPriceCalctype = ppctLatestcost     Then result := LatestCost
  else if  ProductPriceCalctype = ppctAverageCost    Then result := AvgCost
  else if  ProductPriceCalctype = ppctLandedcost     Then result := LandedCost
  else if  ProductPriceCalctype = ppctManCost        Then result := MancostWithLabour
  else if  ProductPriceCalctype = ppctManLatestcost  Then result := ManLatestCost
  else if  ProductPriceCalctype = ppctManAverageCost Then result := ManAverageCost;

end;*)
procedure TProduct.SetSell_Cost_Percentage(const Value: Double);
begin
  inherited SetSell_Cost_Percentage(Value);

  if fbCalculatingMarkupPercentage then exit;

  if GrossMarginMode = true then begin {price from markup}
      if BuyQty1Cost <> 0 then SellQty1Price := CommonLib.Round(calcPricefromMarkup(BuyQty1Cost, (MarkupPercentage)), tcConst.GeneralRoundPlaces);
      if BuyQty2Cost <> 0 then SellQty2Price := CommonLib.Round(calcPricefromMarkup(BuyQty2Cost, (MarkupPercentage)), tcConst.GeneralRoundPlaces);
      if BuyQty3Cost <> 0 then SellQty3Price := CommonLib.Round(calcPricefromMarkup(BuyQty3Cost, (MarkupPercentage)), tcConst.GeneralRoundPlaces);
  end else begin {price from gross}
      if BuyQty1Cost <> 0 then SellQty1Price := CommonLib.Round(CalcPricefromGross(BuyQty1Cost, (MarkupPercentage)), tcConst.GeneralRoundPlaces);
      if BuyQty2Cost <> 0 then SellQty2Price := CommonLib.Round(CalcPricefromGross(BuyQty2Cost, (MarkupPercentage)), tcConst.GeneralRoundPlaces);
      if BuyQty3Cost <> 0 then SellQty3Price := CommonLib.Round(CalcPricefromGross(BuyQty3Cost, (MarkupPercentage)), tcConst.GeneralRoundPlaces);
  end;
  (*if BuyQty1Cost <> 0 then *)SellQty1Priceinc :=Round(GetAmountInc(SellQty1Price, GetTaxRate(TaxCodeSales)), RoundPlacesGeneral) ;
  (*if BuyQty2Cost <> 0 then *)SellQty2Priceinc :=Round(GetAmountInc(SellQty2Price, GetTaxRate(TaxCodeSales)), RoundPlacesGeneral) ;
  (*if BuyQty3Cost <> 0 then *)SellQty3Priceinc :=Round(GetAmountInc(SellQty3Price, GetTaxRate(TaxCodeSales)), RoundPlacesGeneral) ;
end;

function TProduct.GetTotalQtyOnOrder: Double;
var
  strSQL:String;
begin
    strSQL:=  'Select ' +SQL4Qty(tPOBO) + ' as Qty' +
              ' FROM ' + ProductTables(tSummary) +
              ' Where P.PartsId = ' + intToStr(ID);
    With getNewDataset(strSQL,true) do try
       result := fieldbyname('Qty').Asfloat;
    finally
      if active then Close;
      Free;
    end;
end;

function TProduct.GetTotalQtyAvailable: Double;
var
  strSQL:String;
begin
    strSQL:=  'Select ' +SQL4Qty(tAvailable) + ' as Qty' +
              ' FROM ' + ProductTables(tSummary) +
              ' Where P.PartsId = ' + intToStr(ID);
    With getNewDataset(strSQL,true) do try
       result := fieldbyname('Qty').Asfloat;
    finally
      if active then Close;
      Free;
    end;
end;

function TProduct.GetTotalQtyInStock: Double;
var
  strSQL:String;
begin
    strSQL:=  'Select ' +SQL4Qty(tInStock) + ' as Qty' +
              ' FROM ' + ProductTables(tSummary) +
              ' Where P.PartsId = ' + intToStr(ID);
    With getNewDataset(strSQL,true) do try
       result := fieldbyname('Qty').Asfloat;
    finally
      if active then Close;
      Free;
    end;
end;


Function TProduct.ValidateData :Boolean;
var
  s:String;
begin
  result := inherited ValidateData;
  if not result then exit;
    if ProductGroup <> '' then begin
      if (ProductGroup1 = '') and ((ProductGroup2 <> '') or (ProductGroup3 <> '')) then begin
        s:= 'ProductGroup1 can not be blank when ProductGroup2 or ProductGroup3 contain a value';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
      end;
      if (ProductGroup2 = '') and (ProductGroup3 <> '') then begin
        s:= 'ProductGroup2 can not be blank when ProductGroup3 contains a value';
        self.AddResult(false, rssWarning, BOR_Product_Err_Main, s);
        Exit;
      end;
    end;
    if not ValidateSubObject(ProductClass) then exit;
    if not ValidateSubObject(RelatedProducts) then exit;

end;


Procedure TProduct.ProductDefaultUOMs(Const Sender: TBusObj; var Abort: Boolean);
begin
  if not (Sender is TUnitOfMeasure) then Exit;
  if TUnitOfMeasure(Sender).UOMName = AppEnv.DefaultClass.DefaultUOM then begin
    if fsPurchasesUOM = '' then begin
            fsPurchasesUOM := TUnitOfMeasure(Sender).UOMName;
            fiPurchaseUOM := TUnitOfMeasure.CreateNewUOM(nil, ID, TUnitOfMeasure(Sender).UOMName, self.connection);//TUnitOfMeasure(Sender).ID;
            fdPurchaseUOMMultiplier := TUnitOfMeasure(Sender).Multiplier;
    end;
    if fsSalesUOM = '' then begin
            fsSalesUOM := TUnitOfMeasure(Sender).UOMName;
            fiSalesUOM := TUnitOfMeasure.CreateNewUOM(nil, ID, TUnitOfMeasure(Sender).UOMName,  self.connection);//TUnitOfMeasure(Sender).ID;
            fdSalesUOMMultiplier := TUnitOfMeasure(Sender).Multiplier;
    end;
    abort := TRue;
  end;
end;
Procedure TProduct.ProductUOMS(Const Sender: TBusObj; var Abort: Boolean);
begin
    if not (Sender is TUnitOfMeasure) then Exit;
    if TUnitOfMeasure(Sender).PartId = Self.Id then begin
        if TUnitOfMeasure(Sender).PurchasesDefault then begin
            fsPurchasesUOM := TUnitOfMeasure(Sender).UOMName;
            fiPurchaseUOM := TUnitOfMeasure(Sender).ID;
            fdPurchaseUOMMultiplier := TUnitOfMeasure(Sender).Multiplier;
        end;
        if TUnitOfMeasure(Sender).SalesDefault then begin
            fsSalesUOM := TUnitOfMeasure(Sender).UOMName;
            fiSalesUOM := TUnitOfMeasure(Sender).ID;
            fdSalesUOMMultiplier := TUnitOfMeasure(Sender).Multiplier;
        end;
    end;
  abort := (fiPurchaseUOM <>0) and (fiSalesUOM <>0)

end;

function TProduct.Qrycustomfields: TCustomMyDataset;
begin
  result := getNewDataset('SELECT CFLabel1,CFLabel2,CFLabel3,CFLabel4,CFLabel5,CFLabel6,CFLabel7,CFLabel8,CFLabel9,'+
  'CFLabel10,CFLabel11,CFLabel12,CFLabel13,CFLabel14,CFLabel15,CFLabel16,CFLabel17,CFLabel18,'+
  'CFProduct1,CFProduct2,CFProduct3,CFProduct4,CFProduct5,CFProduct6,CFProduct7,CFProduct8,CFProduct9,'+
  'CFProduct10,CFProduct11,CFProduct12,CFProduct13,CFProduct14,CFProduct15,CFProduct16,CFProduct17,CFProduct18'+
  ' FROM tblcustomfields AS CF');
end;

Procedure TProduct.UpdatePreferedSuppBuyPrice(Const Sender: TBusObj; var Abort: Boolean);
begin
    if not (Sender is TProductExtraBuyPrice) then Exit;
    if Assigned(PreferedSupplier) and (PreferedSupplier.Id = TProductExtraBuyPrice(Sender).SupplierID) then begin
        TProductExtraBuyPrice(Sender).BuyQty1 := Self.BuyQty1;
        TProductExtraBuyPrice(Sender).BuyQty1Price := Self.BuyQty1Cost;
    end;
end;

function TProduct.Save: Boolean;
var
  s:String;
begin
  result:= self.ValidateData;
  if not Result then Exit;
  Result := inherited Save;
  if not Result then Exit;

  if Assigned(fProductGroupJoin) then ProductGroup := fProductGroupJoin;
  Duration := Ordertime +Manufacturetime + OverrunTime;

  s:= ' Insert Ignore into tblProductGroup (GroupName) '+
                   ' select distinct '+ Firstcolumn  + ' from tblParts P  where IfNull(ProductGroup,"") <> ""  and '+ firstcolumn  + ' <> ""  and PartsId = '+ inttostr(ID)+ ' and '+ firstcolumn  +' not in (select GroupName from tblProductGroup  ) ' +
        ' union all  select distinct '+ secondcolumn + ' from tblParts P  where IfNull(ProductGroup,"") <> ""  and '+ secondcolumn + ' <> ""  and PartsId = '+ inttostr(ID)+ ' and '+ secondcolumn +' not in (select GroupName from tblProductGroup  ) ' +
        ' union all  select distinct '+ Thirdcolumn  + ' from tblParts P  where IfNull(ProductGroup,"") <> ""  and '+ Thirdcolumn  + ' <> ""  and PartsId = '+ inttostr(ID)+ ' and '+ Thirdcolumn  +' not in (select GroupName from tblProductGroup  ) ' ;
  executeSQL(s , true);

  LastUpdated := Now;
  Result := true;
end;
Function TProduct.ExportsubClasses(Const node: IXMLNode):Boolean;
begin
    self.ExtraBuyPrice.XMLPropertyNode := node.AddChild('SpecialBuyPrices');
    self.ExtraBuyPrice.XMLPropertyName:= 'BuyPrice';
    self.ExtraBuyPrice.IterateRecords(GetPropertyXMLCallback);

    self.ExtraSellPrice.XMLPropertyNode := node.AddChild('SpecialSellPrices');
    self.ExtraSellPrice.XMLPropertyName:= 'SellPrice';
    self.ExtraSellPrice.IterateRecords(GetPropertyXMLCallback);

    self.RelatedProducts.XMLPropertyNode := node.AddChild('RelatedProducts');
    self.RelatedProducts.XMLPropertyName:= 'Product';
    self.RelatedProducts.IterateRecords(GetPropertyXMLCallback);

    self.ForeignPriceSell.XMLPropertyNode := node.AddChild('ForeignCurrencySellPrice');
    self.ForeignPriceSell.XMLPropertyName:= 'Price';
    self.ForeignPriceSell.IterateRecords(GetPropertyXMLCallback);

    self.ForeignPriceBuy.XMLPropertyNode := node.AddChild('ForeignCurrencyBuyPrice');
    self.ForeignPriceBuy.XMLPropertyName:= 'Price';
    self.ForeignPriceBuy.IterateRecords(GetPropertyXMLCallback);


    self.ProductClass.XMLPropertyNode := node.AddChild('ProductClass');
    self.ProductClass.XMLPropertyName:= 'Department' ;
    self.ProductClass.IterateRecords(GetPropertyXMLCallback);


    self.ProductSpecs.XMLPropertyNode := node.AddChild('Specifications');
    self.ProductSpecs.XMLPropertyName:= 'ProductSpec';
    self.ProductSpecs.IterateRecords(GetPropertyXMLCallback);

    self.ProductProcessPart.XMLPropertyNode := node.AddChild('ProcessSteps');
    self.ProductProcessPart.XMLPropertyName:= 'ProcessStep';
    self.ProductProcessPart.IterateRecords(GetPropertyXMLCallback);

    Result := True;
end;
class function TProduct.GetKeyStringProperty: string;
begin
  result:= 'ProductName';
end;

class function TProduct.GetBusObjectTablename: string;
begin
    REsult := 'tblParts';
end;
class function TProduct.IdForProductCode(const aProductCode: string;
  Connection: TCustomMyConnection): integer;
var
  qry: TERPQuery;
begin
  if Assigned(Connection) then
    qry := DbSharedObj.GetQuery(Connection)
  else
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('select PartsID from tblparts');
    qry.SQL.Add('where ProductCode = ' + QuotedStr(aProductCode));
    qry.Open;
    result := qry.FieldByName('PartsID').AsInteger;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

Function TProduct.ImportsubClasses(const node: IXMLNode):Boolean;
var
    x:Integer;
    Singlerec :IXMLNode;
begin
    Result := False;

    if isOktoSet('SpecialBuyPrices') then begin
      ImportFailed := False;
      XMLPropertyName :='SpecialBuyPrices';
      XMLPropertyNode := node.ChildNodes.FindNode(XMLPropertyName);
      if Assigned(XMLPropertyNode) then begin
        ExtraBuyPrice.DeleteAll;
          for x := 0 to XMLPropertyNode.ChildNodes.Count - 1 do begin
              ExtraBuyPrice.ImportingFromXMLFile := False;
              Singlerec:= XMLPropertyNode.ChildNodes[x];
              ExtraBuyPrice.New;
              ExtraBuyPrice.ImportFromXML(SingleRec);
              ExtraBuyPrice.postDB;
              ImportFailed :=ExtraBuyPrice.ImportFailed;
              if Error then Exit;
          end;

      end;
    end;

    if isOktoSet('SpecialSellPrices') then begin
      ImportFailed := False;
      XMLPropertyName :='SpecialSellPrices';
      XMLPropertyNode := node.ChildNodes.FindNode(XMLPropertyName);
      if Assigned(XMLPropertyNode) then begin
        ExtraSellPrice.DeleteAll;
          for x := 0 to XMLPropertyNode.ChildNodes.Count - 1 do begin
              ExtraSellPrice.ImportingFromXMLFile := False;
              Singlerec:= XMLPropertyNode.ChildNodes[x];
              ExtraSellPrice.New;
              ExtraSellPrice.ImportFromXML(SingleRec);
              ExtraSellPrice.PostDB;
              ImportFailed :=ExtraSellPrice.ImportFailed;
              if Error then Exit;
          end;
      end;
    end;

    if isOktoSet('RelatedProducts') then begin
      ImportFailed := False;
      XMLPropertyName :='RelatedProducts';
      XMLPropertyNode := node.ChildNodes.FindNode(XMLPropertyName);
      if Assigned(XMLPropertyNode) then begin
        RelatedProducts.DeleteAll;
          for x := 0 to XMLPropertyNode.ChildNodes.Count - 1 do begin
              RelatedProducts.ImportingFromXMLFile := False;
              Singlerec:= XMLPropertyNode.ChildNodes[x];
              RelatedProducts.New;
              RelatedProducts.ImportFromXML(SingleRec);
              RelatedProducts.PostDB;
              ImportFailed :=RelatedProducts.ImportFailed;
              if Error then Exit;
          end;
      end;
    end;

    if isOktoSet('ForeignCurrencySellPrice') then begin
      ImportFailed := False;
      XMLPropertyName :='ForeignCurrencySellPrice';
      XMLPropertyNode := node.ChildNodes.FindNode(XMLPropertyName);
      if Assigned(XMLPropertyNode) then begin
        ForeignPriceSell.DeleteAll;
          for x := 0 to XMLPropertyNode.ChildNodes.Count - 1 do begin
              ForeignPriceSell.ImportingFromXMLFile := False;
              Singlerec:= XMLPropertyNode.ChildNodes[x];
              ForeignPriceSell.New;
              ForeignPriceSell.ImportFromXML(SingleRec);
              ForeignPriceSell.PostDB;
              ImportFailed :=ForeignPriceSell.ImportFailed;
              if Error then Exit;
          end;
      end;
    end;

    if isOktoSet('ForeignCurrencyBuyPrice') then begin
      ImportFailed := False;
      XMLPropertyName :='ForeignCurrencyBuyPrice';
      XMLPropertyNode := node.ChildNodes.FindNode(XMLPropertyName);
      if Assigned(XMLPropertyNode) then begin
        ForeignPriceBuy.DeleteAll;
          for x := 0 to XMLPropertyNode.ChildNodes.Count - 1 do begin
              ForeignPriceBuy.ImportingFromXMLFile := False;
              Singlerec:= XMLPropertyNode.ChildNodes[x];
              ForeignPriceBuy.NEw;
              ForeignPriceBuy.ImportFromXML(SingleRec);
              ForeignPriceBuy.PostDB;
              ImportFailed :=ForeignPriceBuy.ImportFailed;
              if Error then Exit;
          end;
      end;
    end;

    if isOktoSet('ProductClass') then begin
      ImportFailed := False;
      XMLPropertyName :='ProductClass';
      XMLPropertyNode := node.ChildNodes.FindNode(XMLPropertyName);
      if Assigned(XMLPropertyNode) then begin
          for x := 0 to XMLPropertyNode.ChildNodes.Count - 1 do begin
              ProductClass.ImportingFromXMLFile := False;
              Singlerec:= XMLPropertyNode.ChildNodes[x];
              ProductClass.ImportFromXML(SingleRec);
              ProductClass.PostDB;
              ImportFailed :=ProductClass.ImportFailed;
              if Error then Exit;
          end;
      end;
    end;

    if isOktoSet('Specifications') then begin
      ImportFailed := False;
      XMLPropertyName :='Specifications';
      XMLPropertyNode := node.ChildNodes.FindNode(XMLPropertyName);
      if Assigned(XMLPropertyNode) then begin
        ProductSpecs.DeleteAll;
          for x := 0 to XMLPropertyNode.ChildNodes.Count - 1 do begin
              ProductSpecs.ImportingFromXMLFile := False;
              Singlerec:= XMLPropertyNode.ChildNodes[x];
              ProductSpecs.new;
              ProductSpecs.ImportFromXML(SingleRec);
              ProductSpecs.PostDB;
              ImportFailed :=ProductSpecs.ImportFailed;
              if Error then Exit;
          end;
      end;
    end;

    if isOktoSet('ProcessSteps') then begin
      ImportFailed := False;
      XMLPropertyName :='ProcessSteps';
      XMLPropertyNode := node.ChildNodes.FindNode(XMLPropertyName);
      if Assigned(XMLPropertyNode) then begin
        ProductProcessPart.DeleteAll;
          for x := 0 to XMLPropertyNode.ChildNodes.Count - 1 do begin
              ProductProcessPart.ImportingFromXMLFile := False;
              Singlerec:= XMLPropertyNode.ChildNodes[x];
              ProductProcessPart.New;
              ProductProcessPart.ImportFromXML(SingleRec);
              ProductProcessPart.PostDB;
              ImportFailed :=ProductProcessPart.ImportFailed;
              if Error then Exit;
          end;
      end;
    end;

    ImportFailed := False;
    Result := True;
end;
Function TProduct.ValidateXMLData(Const node :IXMLNode) :Boolean ;
begin
    Result := inherited ValidateXMLData(node);
    if not Result then Exit;
    if not ImportingFromXMLFile then Exit;

    XMLSearchRecordDesc := 'Product ='  + quotedstr(GetXMLNodeStringValue(Node, 'ProductName'));
    Result := False;
    if GetXMLNodeStringValue(Node, 'IncomeAccount') <> '' then
    if GetAccountID(GetXMLNodeStringValue(Node, 'IncomeAccount')) = 0 then begin
            ErrRecordNotfound('Income Account' , GetXMLNodeStringValue(Node, 'IncomeAccount'));
            Exit;
    end;
    if GetXMLNodeStringValue(Node, 'AssetAccount') = '' then
    if GetAccountID(GetXMLNodeStringValue(Node, 'AssetAccount')) = 0 then begin
            ErrRecordNotfound('Asset Account' , GetXMLNodeStringValue(Node, 'AssetAccount'));
            Exit;
    end;
    if GetXMLNodeStringValue(Node, 'CogsAccount') <> '' then
    if GetAccountID(GetXMLNodeStringValue(Node, 'CogsAccount')) = 0 then begin
            ErrRecordNotfound('Cogs Account' , GetXMLNodeStringValue(Node, 'CogsAccount'));
            Exit;
    end;
    if GetXMLNodeStringValue(Node, 'PreferedSupplierName') <> '' then
    if getSupplierID(GetXMLNodeStringValue(Node, 'PreferedSupplierName'))  = 0 then begin
            ErrRecordNotfound('Preferred Supplier' , GetXMLNodeStringValue(Node, 'PreferedSupplierName'));
            Exit;
    end;
    if GetXMLNodeStringValue(Node, 'TaxCodeSales') <> '' then
    if GetGLTaxCodeIDForName(GetXMLNodeStringValue(Node, 'TaxCodeSales'))  = 0 then begin
            ErrRecordNotfound('TaxCode Sales' , GetXMLNodeStringValue(Node, 'TaxCodeSales'));
            Exit;
    end;
    if GetXMLNodeStringValue(Node, 'TaxCodePurchase') <> '' then
    if GetGLTaxCodeIDForName(GetXMLNodeStringValue(Node, 'TaxCodePurchase'))  = 0 then begin
            ErrRecordNotfound('TaxCode Purchase' , GetXMLNodeStringValue(Node, 'TaxCodePurchase'));
            Exit;
        end;
    if getXMLNodeFloatValue(Node , 'TotalQty') <> 0 then begin
        if getXMLNodeStringValue(node, 'TotalQtyUOMProduct' ) <> '' then begin
            if getXMLNodeStringValue(node, 'TotalQtyUOMProduct' ) <> self.ProductName then begin
                ErrRecordNotfound('Unit of Measure' , getXMLNodeStringValue(node, 'TotalQtyUOM' ) + '(' + getXMLNodeStringValue(node, 'TotalQtyUOMProduct' ) +')');
                Exit;
            end;
        end;
        if GetUnitOfMeasureID(getXMLNodeStringValue(node, 'TotalQtyUOM' ) , Self.ID) = 0 then begin
            ErrRecordNotfound('Unit of Measure' , getXMLNodeStringValue(node, 'TotalQtyUOM'));
            Exit;
        end;
    end;
    XMLSearchRecord := 'PARTNAME ='  + quotedstr(GetXMLNodeStringValue(Node, 'ProductName'));
    Result := True;
    LocateXMLRecord;
end;
class function TProduct._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TAccount','IncomeAccountObj','IncomeAccount','AccountName');
  TBOSchema.AddRefType(result,'TAccount','AssetAccountObj','AssetAccount','AccountName');
  TBOSchema.AddRefType(result,'TAccount','COGSAccountObj','COGSAccount','AccountName');
  TBOSchema.AddRefType(result,'TTaxCode','TaxCodePurchaseObj','TaxCodePurchase','CodeName');
  TBOSchema.AddRefType(result,'TTaxCode','TaxCodeSalesObj','TaxCodeSales','CodeName');
  TBOSchema.AddRefType(result,'TCountries','CountryOfOriginObj','CountryofOriginID','ID');
  TBOSchema.AddRefType(result,'TCountries','CountryOfOriginObj','CountryOfOriginName','Country');
  TBOSchema.AddRefType(result,'TSupplier','PreferedSupplierObj','PreferedSupplierName','ClientName');
  TBOSchema.AddRefType(result,'TFormula','FormulaObj','FormulaName','FormulaName');
end;
procedure TProduct.Load(const aId: integer; const fIsReadonly: boolean);
begin
  inherited Load(aId,fIsReadonly);
end;

procedure TProduct.LoadFromXMLNode(Const node: IXMLNode);
begin
    if DetaislFromAttribtempproduct then TemplateProductProps;
    inherited;


    if DetaislFromAttribtempproduct then ImportsubClasses(node);
end;
procedure TProduct.LoadSelect(const SelectStatement: string;  const fIsReadonly: boolean);
begin
  inherited LoadSelect(SelectStatement , fisreadonly);
end;

function TProduct.getTemplateProductDetails: String;
begin
  DetaislFromAttribtempproduct := True;
  try
    REsult := XML;
  finally
    DetaislFromAttribtempproduct:= False;
  end;

end;

procedure TProduct.setTemplateProductDetails(const Value: String);
begin
  DetaislFromAttribtempproduct := True;
  try
    XML := Value;
  finally
    DetaislFromAttribtempproduct := False;
  end;

end;


procedure TProduct.SaveToXMLNode(Const node: IXMLNode);
begin
    inherited SaveToXMLNode(node);
    AddXMLNode(node , 'HasRelatedProducts'  , HasRelatedProducts);
    AddXMLNode(node , 'TotalQtyInStock'     , TotalQtyInStock);
    {sub properties should be created only when exporting}
    if DetaislFromAttribtempproduct or SavingXMLTofile then
        ExportsubClasses(Node);
end;

function TProduct.GetPreferedSupplier: TSupplier;
begin
  result:= TSupplier(Container.ItemByClass(TSupplier, false));
  if self.PreferedSupplierName <> '' then begin
    if not Assigned(result) then begin
      result:= TSupplier.Create(nil);
      Container.Add(result);
      result.Connection:= GetSharedDataConnection; // use out-of-transaction connection
    end;
    if result.ClientName <> self.PreferedSupplierName then
      result.LoadSelect('Company = '+ QuotedStr(self.PreferedSupplierName));

  end
  else begin
    { PreferedSupplierName not set so free supplier if assigned }
    if Assigned(result) then
      Container.FreeAndDelete(result);
    result:= nil;
  end;
end;

class function TProduct.ProductIdForBarcode(const aBarcode: string;
  conn: TCustomMyConnection): integer;
var
  UOMId: integer;
begin
  result := TProduct.ProductIdForBarcode(aBarcode, UOMId, conn);
end;

class function TProduct.ProductNameForBarcode(const aBarCode: string;  conn: TCustomMyConnection): String;
var qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    if Assigned(conn) then qry.Connection:= conn
    else qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('SELECT P.PartsId, P.PartName FROM tblParts P '+
              ' inner join tblPartBarCodes PB on PB.PartsID = P.PartsId' +
              ' WHERE PB.Active = "T" AND PB.Barcode = ' + QuotedStr(aBarcode));
    qry.Open;
    result:= qry.FieldByName('PartName').AsString;
  finally
    qry.Free;
  end;

end;

class function TProduct.AvgCost(const ProductId: integer;Connection: TCustomMyConnection): Double;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.CReate(nil);
  try
    if Assigned(Connection) then qry.Connection:= Connection
    else qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select AvgCost ');
    qry.SQL.Add('from tblParts where PartsId = ' + IntToStr(ProductId));
    qry.Open;
    Result:= qry.FieldByName('AvgCost').AsFloat;
  finally
    qry.Free;
  end;
end;

class function TProduct.CostForQty(const ProductId: integer; Qty: Double;Connection: TCustomMyConnection): Double;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.CReate(nil);
  try
    if Assigned(Connection) then
      qry.Connection:= Connection
    else
      qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select Cost1, Cost2, Cost3, BuyQty1, BuyQty2, BuyQty3 ');
    qry.SQL.Add('from tblParts where PartsId = ' + IntToStr(ProductId));
    qry.Open;
    Result:= qry.FieldByName('Cost1').AsFloat;
    if (qry.FieldByName('BuyQty2').AsFloat <> 0) and (Qty >= qry.FieldByName('BuyQty2').AsFloat) then
      Result:= qry.FieldByName('Cost2').AsFloat;
    if (qry.FieldByName('BuyQty3').AsFloat <> 0) and (Qty >= qry.FieldByName('BuyQty3').AsFloat) then
      Result:= qry.FieldByName('Cost3').AsFloat;
  finally
    qry.Free;
  end;
end;

class function TProduct.Cost(const ProductId: integer;
  Connection: TCustomMyConnection): Double;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.CReate(nil);
  try
    if Assigned(Connection) then
      qry.Connection:= Connection
    else
      qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select Cost1, Cost2, Cost3, BuyQty1, BuyQty2, BuyQty3 ');
    qry.SQL.Add('from tblParts where PartsId = ' + IntToStr(ProductId));
    qry.Open;
    Result:= qry.FieldByName('Cost1').AsFloat;
  finally
    qry.Free;
  end;
end;


class function TProduct.PriceForQty(const ProductId: integer; Qty: Double;
  Connection: TCustomMyConnection): Double;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.CReate(nil);
  try
    if Assigned(Connection) then
      qry.Connection:= Connection
    else
      qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select Price1, Price2, Price3, SellQty1, SellQty2, SellQty3 ');
    qry.SQL.Add('from tblParts where PartsId = ' + IntToStr(ProductId));
    qry.Open;
    Result:= qry.FieldByName('Price1').AsFloat;
    if (qry.FieldByName('SellQty2').AsFloat <> 0) and (Qty >= qry.FieldByName('SellQty2').AsFloat) then
      Result:= qry.FieldByName('Price2').AsFloat;
    if (qry.FieldByName('SellQty3').AsFloat <> 0) and (Qty >= qry.FieldByName('SellQty3').AsFloat) then
      Result:= qry.FieldByName('Price3').AsFloat;
  finally
    qry.Free;
  end;
end;

class procedure TProduct.checkAllocation(var batch,Multiplebins, SNTracking: Boolean);
begin
  With CommonDBLib.TempMyQuery do try
      SQL.add('Select PartsId from tblParts where ifnull(Batch,"F")="T" limit 1');
      open;
      batch := recordcount > 0;
      close;
      SQL.clear;
      SQL.add('Select PartsId from tblParts where ifnull(MultipleBins,"F")="T" limit 1');
      open;
      Multiplebins := recordcount > 0;
      close;
      SQL.clear;
      SQL.add('Select PartsId from tblParts where ifnull(SnTracking,"F")="T" limit 1');
      open;
      SNTracking := recordcount > 0;
      close;
  finally
    if active then close;
    Free;
  end;
end;
class procedure TProduct.checkAllocation(fProductID:Integer; var fbbatch,fbMultiplebins, fbSNTracking: Boolean);
begin
  With TProduct.CreateWithNewConn(nil) do try
    Load(fProductID);
    fbbatch :=Batch;
    fbMultiplebins :=Multiplebins;
    fbSNTracking := SNTracking;
  finally
    Free;
  end;
end;

function TProduct.getProductAttributeProduct: TProductAttributes;
begin
  REsult := TProductAttributes(getContainerComponent(TProductAttributes , 'ProductID = ' + InttoStr(ID)));
end;

Class function TProduct.isAttribProduct(const ProductID:Integer; Var GroupID:Integer):Boolean;
begin
  REsult := False;
  With CommonDbLib.TempMyQuery do try
    SQL.add('SELECT * FROM tblproductattributeproducts ');
    SQL.add('Where ProductID = ' + InttoStr(ProductID));
    Open;
    if recordcount > 0 then begin
      GroupID := fieldByname('Pag_ID').asInteger;
      REsult := True;
    end;
  finally
    if active then close;
    Free;
  end;
end;

function TProduct.isAttribProduct: Boolean;
begin
  REsult := False;
  if ProductAttributeProduct.count= 0 then exit;
  result := true;
end;


function TProduct.TemplateProductProps: TDoubleDimensionArray;
var
  ctr, i:Integer;
  Procedure AddItem(propname, PropCaption :STring);begin
    Setlength(fTemplateProductProps[0] , ctr+1);
    Setlength(fTemplateProductProps[1] , ctr+1);
    fTemplateProductProps[0,ctr] :=PropName;
    fTemplateProductProps[1,ctr] :=PropCaption;
    inc(ctr);
  end;
begin
  if (fTemplateProductProps = nil) or (High(fTemplateProductProps) <1) then begin
    Setlength(fTemplateProductProps , 2);
    Setlength(fTemplateProductProps[0] ,0);
    Setlength(fTemplateProductProps[1] ,0);
    ctr:= 0;
    AddItem('active'               		,'active'              	    );
    AddItem('Area'                		,'Area'                	    );
    AddItem('AssetAccount'        		,'Asset Account'        	  );
    AddItem('AutoReorder'         		,'Auto Reorder?'         	  );
    AddItem('AutoSmartOrder'      		,'Auto SmartOrder?'      	  );
    AddItem('RequiresAssembly'    		,'Requires Assembly?'    	  );
    AddItem('ExcludeFromSmartOrder'  ,'Exclude From SmartOrders?');   // @@@
    AddItem('HideWastage'             ,'Exclude From SmartOrders?');   // @@@
    AddItem('BOM'                     ,'BOM'                      );
    AddItem('BuyQty1'               	,'Buy Qty and Cost'         );
    AddItem('BuyQty1Cost'           	,'Buy Qty and Cost'         );
    AddItem('BuyQty2'               	,'Buy Qty and Cost'         );
    AddItem('BuyQty2Cost'         		,'Buy Qty and Cost'         );
    AddItem('BuyQty3'             		,'Buy Qty and Cost'         );
    AddItem('BuyQty3Cost'         		,'Buy Qty and Cost'         );
    AddItem('CogsAccount'         		,'Cogs Account'         	  );
    AddItem('EquipmentName'           ,'Equipment Name'       	  );
    AddItem('ForeignCurrencyBuyPrice' ,'Foreign Currency(Buy)'    );
    AddItem('ForeignCurrencySellPrice','Foreign Currency(Sell)'   );
    AddItem('GeneralNotes'      		  ,'General Notes'      	  );
    AddItem('HideOnPrint'         		,'Hide On Print?'         	);
    AddItem('HideonPickSlip'         	,'Hide On Picking Slip?'   	);
    AddItem('HideonDelDocket'         ,'Hide On Delivery Docket?'	);
    AddItem('IncludeInAnalysis'   		,'Include In Analysis?'   	);
    AddItem('IncomeAccount'       		,'Income Account'       	  );
    AddItem('LandedCost'          		,'Landed Cost'          	  );
    AddItem('LatestCost'          		,'Latest Cost'          	  );
    AddItem('LatestCostDate'      		,'Latest Cost Date'      	  );
    AddItem('LockExtraSell'         	,'Lock Extra Sell Price'	  );
    AddItem('MancostWithLabour'    		,'Man Cost'             	  );
    AddItem('GrossMarginMode'    		  ,'Margin Mode'    	        );
    AddItem('MarkupPercentage'    		,'Margin Percentage'    	  );
    AddItem('NormalDeliveryTime'  		,'Normal Delivery Time'  	  );
    AddItem('OnSpecial'           		,'On Special?'           	  );
    AddItem('PDAMinSellQty'       		,'PDA Min Sell Qty'       	);
    AddItem('PreferedSupplierName'  	,'Preferred Supplier' 	      );
    AddItem('ProcessSteps'      	    ,'Process Steps'      	    );
    AddItem('ProductClass'      	    ,'Product Classes'        	);
    AddItem('ProductComment'      		,'Product Comment'      	  );
    AddItem('ProductionNotes'      		,'Production Notes'      	  );
    AddItem('ProductGroup'          	,'Product Group'         	  );
    AddItem('ShowProductPopUp'    		,'Product Sales PopUp'    	);
    AddItem('ShowPurchaseProductPopUp','Product Purchase PopUp'   );
    AddItem('Pictures'   		          ,'Pictures'  	              );
    AddItem('IsDiscontinued'       		,'Product Discontinued'     );
    AddItem('ProductPopUpNotes'   		,'Product Sales PopUp'   	        );
    AddItem('ProductPurchasePopUpNotes','Product Purcahse PopUp'  );
    AddItem('PublishOnWeb'            ,'Publish on Website'       );
    AddItem('TaxCodePurchase'     		,'Purchase Taxcode'     	  );
    AddItem('RelatedProducts'      	  ,'Related Products'       	);
    AddItem('TaxCodeSales'        		,'Sales Taxcode'        	  );
    AddItem('SellQty1'            		,'Sell Qty and Price'       );
    AddItem('SellQty1Price'       		,'Sell Qty and Price'       );
    AddItem('SellQty2'            		,'Sell Qty and Price'       );
    AddItem('SellQty2Price'       		,'Sell Qty and Price'       );
    AddItem('SellQty3'            		,'Sell Qty and Price'       );
    AddItem('SellQty3Price'       		,'Sell Qty and Price'       );
    AddItem('SpecialDiscount'     		,'Special Discount?'     	  );
    AddItem('SpecialBuyPrices'   	    ,'Special Prices(Buy)'    	);
    AddItem('SpecialSellPrices'      	,'Special Prices(Sell)'     );
    AddItem('Specifications'      	  ,'Specifications'      	    );
    AddItem('SupplierProductCode'   	,'Supplier Product Code'  	);
    AddItem('SnTracking'          		,'Use SN?'          	      );
    AddItem('UpdPriceOnCostDec'   		,'Update Price On Cost Dec?');
    AddItem('UpdPriceOnCostInc'   		,'Update Price On Cost Inc?');
    AddItem('CostUpdateFromPurchase'	,'Update Cost On Purchase?');
    AddItem('Multiplebins'     	    	,'Use Bins?'     	          );
    AddItem('Batch'            	    	,'Use Batch?'            	  );
    AddItem('Autoallocbin'   	      	,'Use Bins?'   	            );
    AddItem('AutoAllocBatch' 	      	,'Use Batch?' 	            );
    AddItem('UseHedgingFormula'     	,'Use Hedging Formula?'    	);
    AddItem('UOMtobeUsedinManufacture','UOM to be used in Manufacutre'    	  );
    AddItem('Volume'              		,'Volume'              	    );
    with Qrycustomfields do try
      for i := 1 to 18 do
        if fieldbyname('CFProduct'+inttostr(i)).asBoolean then
          AddItem('CUSTFLD'+inttostr(i) , fieldbyname('CFLabel'+inttostr(i)).asString);
    finally
      close;
      free;
    end;
  end;
  REsult := fTemplateProductProps;
end;



class function TProduct.IsProductActive( const fProductID: Integer ; fconnection :TCustomMyConnection=nil): Boolean;
begin
  REsult := False;
  With CommonDBLib.TempMyQuery do try
      if fconnection <> nil then Connection := fConnection;
      SQL.add('Select Active from tblParts where PartsId = ' +IntToStr(fProductID));
      open;
      if recordcount > 0 then result := Fieldbyname('Active').asBoolean;
  finally
      if Active then close;
      Free;
  end;

end;

class procedure TProduct.SetProductActive(const fProductID: Integer;  Value: Boolean;fconnection :TCustomMyConnection=nil);
begin
  With CommonDBLib.TempMyQuery do try
    if fconnection <> nil then Connection := fConnection;
    if value then
      SQL.add('update tblParts  set Active = ''T'' where PartsId = ' +IntToStr(fProductID))
    else SQL.add('update tblParts  set Active = ''F'' where PartsId = ' +IntToStr(fProductID));
      execute;
  finally
      if Active then close;
      Free;
  end;


end;

function TProduct.isOktoSet(const TagName:String): Boolean;
begin
  if not DetaislFromAttribtempproduct then REsult := True
  else begin
    result:=IsSelectedToCopy(tagname);
  end;
end;

function TProduct.IsSelectedToCopy(const TagName:String): Boolean;
var
  i:Integer;
begin
  result := False;
  i := searchArray(fTemplateProductProps[0] , tagname);
  if i<>-1 then
      REsult := fTemplateDetailstocopy.IndexOf(fTemplateProductProps[1,i])<> -1;
end;


class procedure TProduct.SeTProductBarcode(const iProductID:Integer; const aBarCode: String;  const isPrimary: Boolean;fDBConnection: TERPConnection);
var
  strSQL:String;
begin
  if TProduct.ProductIdForBarcode(aBarcode) = 0 then begin
    strSQL:= 'update tblPArts set BarCode = ' +quotedStr(aBarCode) +' where PartsID = ' + IntToStr(iproductID)+';';
    strSQL := strSQL + ' insert into tblPartBarCodes (PartsId, Barcode, IsPrimaryBarCode, Active) '+
                  ' Values ' +
                  ' (' + intTostr(iProductID) + ',' +
                   QuotedStr(Abarcode) +',' ;
    if isPrimary then strSQL := strSQL + '"T",' else strSQL := strSQL + '"F",';
    strSQL := strSQL +'"T")';
    if fDBConnection = nil then fDBConnection := GetSharedMyDacConnection;
    with CommonDbLib.TempMyQuery do try
      connection := fDBConnection;
      SQL.add(strSQL);
      execute;
    finally
        if active then close;
        free;
    end;
  end;
end;



function TProduct.getEquipment: TEquipment;
begin
    REsult := TEquipment(getcontainercomponent(TEquipment , 'ProductId = ' +  IntToStr(ID)));
end;

function TProduct.getEquipmentId: Integer;
begin
  result := 0;
  if isEquipment = false then exit;
  if Equipment.count = 0 then begin
      Equipment.new;
      Equipment.Equipmentname := ProductName;
      Equipment.ProductID := Self.ID;
      Equipment.postdb;
  end;
  Result := Equipment.ID;
end;


procedure TProduct.callDoFieldOnChange(Sender: TField);
begin
  DoFieldOnChange(Sender);
end;

function TProduct.getFormulaID: Integer;
begin
  REsult := GetIntegerfield('formulaID');
end;

function TProduct.getFormulaName: String;
begin
  result:= TFormula.IDToggle(FormulaID, Connection.Connection);
end;

Procedure TProduct.CostPriceMarkupCalc(Sender: TField);
var
  Old_Value:Double;
  New_Value:Double;
begin
  Try
    if (Sysutils.SameText(Sender.fieldname, 'Sell_Cost_Percentage')) then begin
        if BuyQty1Cost <> 0 then begin
          CalcPriceformarkup;
        end else if SellQty1Price <> 0 then begin
          CalcCostformarkup;
        end;
    end else if (Sysutils.SameText(Sender.fieldname, 'PRICEINC1')) or
        (Sysutils.SameText(Sender.fieldname, 'PRICE1')) then begin
        if BuyQty1Cost <> 0 then begin
          CalcmarkupforPrice;
        end else begin
          CalcCostformarkup;
        end;
    end else if (Sysutils.SameText(Sender.fieldname, 'COST1')) or
        (Sysutils.SameText(Sender.fieldname, 'COSTINC1')) then begin
        if VarIsNull(Sender.OldValue) then
          Old_Value:= 0
        else
          Old_Value:= Sender.OldValue;
        New_Value := Sender.Value;
        if (Old_Value <= NEw_Value) then if  UpdPriceOnCostInc then CalcPriceformarkup else   CalcmarkupforPrice;
        if (Old_Value > NEw_Value) then if  UpdPriceOnCostDec then CalcPriceformarkup else   CalcmarkupforPrice;
    end;
  Except
      //kill the exception if any
  end;
end;
Procedure TProduct.CalcmarkupforPrice;
begin
  if SellQty1Price = 0 then begin
     CalcPriceformarkup;
  end else if  BuyQty1Cost = 0 then begin
     Calccostformarkup;
  end else begin
    CalPriceCostPercent(3);
  end;
end;
Procedure TProduct.CalcCostformarkup;
begin
  if MarkupPercentage = 0 then Exit;
  CalPriceCostPercent(1);
end;


procedure TProduct.CalcPriceformarkup;
begin
  if MarkupPercentage = 0 then Exit;
  CalPriceCostPercent(2);
end;

procedure TProduct.CalPriceCostPercent(calcfield: Integer);
begin
Try
  if calcfield = 1 then begin
    if GrossMarginMode = true then begin{cost from markup}
      BuyQty1Cost := CommonLib.Round(calccostfromMarkup(SellQty1Price, (MarkupPercentage)), tcConst.GeneralRoundPlaces);
      BuyQty2Cost := CommonLib.Round(calccostfromMarkup(SellQty2Price, (MarkupPercentage)), tcConst.GeneralRoundPlaces);
      BuyQty3Cost := CommonLib.Round(calccostfromMarkup(SellQty3Price, (MarkupPercentage)), tcConst.GeneralRoundPlaces);
    end else begin {cost from gross}
      BuyQty1Cost := CommonLib.Round(CalccostfromGross(SellQty1Price, (MarkupPercentage)), tcConst.GeneralRoundPlaces);
      BuyQty2Cost := CommonLib.Round(CalccostfromGross(SellQty2Price, (MarkupPercentage)), tcConst.GeneralRoundPlaces);
      BuyQty3Cost := CommonLib.Round(CalccostfromGross(SellQty3Price, (MarkupPercentage)), tcConst.GeneralRoundPlaces);
    end;
    BuyQty1Costinc := CommonLib.Round(GetAmountinc(BuyQty1Cost, GetTaxRate(TaxCodePurchase)), tcConst.GeneralRoundPlaces);
    BuyQty2Costinc := CommonLib.Round(GetAmountinc(BuyQty2Cost, GetTaxRate(TaxCodePurchase)), tcConst.GeneralRoundPlaces);
    BuyQty3Costinc := CommonLib.Round(GetAmountinc(BuyQty3Cost, GetTaxRate(TaxCodePurchase)), tcConst.GeneralRoundPlaces);
  end else if calcfield =2 then begin
    if GrossMarginMode = true then begin {price from markup}
      SellQty1Price := CommonLib.Round(calcPricefromMarkup(BuyQty1Cost, (MarkupPercentage)), tcConst.GeneralRoundPlaces);
      SellQty2Price := CommonLib.Round(calcPricefromMarkup(BuyQty2Cost, (MarkupPercentage)), tcConst.GeneralRoundPlaces);
      SellQty3Price := CommonLib.Round(calcPricefromMarkup(BuyQty3Cost, (MarkupPercentage)), tcConst.GeneralRoundPlaces);
    end else begin {price from gross}
      SellQty1Price := CommonLib.Round(CalcPricefromGross(BuyQty1Cost, (MarkupPercentage)), tcConst.GeneralRoundPlaces);
      SellQty2Price := CommonLib.Round(CalcPricefromGross(BuyQty2Cost, (MarkupPercentage)), tcConst.GeneralRoundPlaces);
      SellQty3Price := CommonLib.Round(CalcPricefromGross(BuyQty3Cost, (MarkupPercentage)), tcConst.GeneralRoundPlaces);
    end;
    SellQty1Priceinc := CommonLib.Round(GetAmountinc(SellQty1Price, GetTaxRate(TaxCodeSales)), tcConst.GeneralRoundPlaces);
    SellQty2Priceinc := CommonLib.Round(GetAmountinc(SellQty2Price, GetTaxRate(TaxCodeSales)), tcConst.GeneralRoundPlaces);
    SellQty3Priceinc := CommonLib.Round(GetAmountinc(SellQty3Price, GetTaxRate(TaxCodeSales)), tcConst.GeneralRoundPlaces);
    ExtraSellPrice.UpdatePrices;
  end else if calcfield = 3 then begin
    fbCalculatingMarkupPercentage := True;
    try
      if GrossMarginMode = false then begin {markup}
        MarkupPercentage := CommonLib.Round(CalcGrossMarginPerc(BuyQty1Cost,SellQty1Price), tcConst.GeneralRoundPlaces);
      end else begin {gross}
        MarkupPercentage := CommonLib.Round(calcMarkupPercent( BuyQty1Cost,SellQty1Price), tcConst.GeneralRoundPlaces);
      end;
    finally
      fbCalculatingMarkupPercentage := False;
    end;
  end;

  PostDB;
  EditDB;
except
  on E:Exception do begin
      if Pos('Duplicate entry',E.Message) > 0 then begin
          self.AddResult(false, rssWarning, 0,'A matching record already exists in the database. ' +
          'If you intended to update an existing record please provide the correct recored ID in the Id field, ' +
          'or when adding new records the ID field must be blank and the record must be unique.');
      end
      else begin
        if calcfield =1 then
          self.AddResult(false, rssWarning, 0,'Cost calculation failed with error: ' +chr(13) + E.message)
        else if calcfield =2 then
          self.AddResult(false, rssWarning, 0,'Price calculation failed with error: ' +chr(13) + E.message)
        else if calcfield =3 then
          self.AddResult(false, rssWarning, 0,'Markup/Gross Margin Percentage calculation failed with error: ' +chr(13) + E.message)
      end;
    end;
  end;
end;

class function TProduct.calcPricefromMarkup (fCost , fMarkupPercent: double): Double;begin
  Result := fcost  *(1 +  (fMarkupPercent/100));
end;

class function TProduct.CalccostfromGross   (fPrice, fGrossMargin  : Double): Double;begin
  Result := fPrice *(1 -   (fGrossMargin/100))
end;

class function TProduct.calcMarkupPercent   (fCost , fPrice        : double): Double;begin
  Result := DivZer((fprice-fCost),fCOST)*100;
end;

class function TProduct.CalcGrossMarginPerc (fCost , fPrice        : Double): Double;begin
  Result := DivZer((FPrice-fCost),fPrice)*100;
end;

class function TProduct.CalcPricefromGross  (fCost , fGrossMargin  : Double): Double;begin
  Result := DivZer(fcost,(1-(fGrossMargin/100)));
end;

class function TProduct.calccostfromMarkup  (fprice, fMarkupPercent: double): Double;begin
  result := DivZer(fprice,(1 +  (fMarkupPercent/100)));
end;

function TProduct.getCleanBuyQty1Cost: Double;
begin
    result:= GetXMLNodeFloatValue(CleanXMLNode, 'BuyQty1Cost');
end;

function TProduct.getcleanGrossMarginMode: boolean;
begin
    result:= GetXMLNodeBooleanValue(CleanXMLNode, 'GrossMarginMode');
end;

function TProduct.getcleanMarkupPercentage: double;
begin
 result:= GetXMLNodeFloatValue(CleanXMLNode, 'MarkupPercentage');
end;



class function TProduct.Productquery(const fsProductname: String): TERPQuery;
begin
  REsult := CommonDbLib.TempMyQuery;
  REsult.SQL.add('select  P.PartsId ,  P.Partname , P.PARTTYPE , P.IncomeAccnt, P.AssetAccnt, P.CogsAccnt, P.ProductGroup, P.TAXCODE , T.Rate TaxRate '+
                 ' from tblparts   P  '+
                 ' Left join tbltaxcodes T on T.Name = P.TAXCODE and T.RegionID = '+ inttostr(AppEnv.RegionalOptions.ID) +
                 ' where partname = ' +QuotedStr(fsProductname));
  Result.Open;
end;


class function TProduct.InTRansSQL(const fProductID: Integer): String;
function Productfilter(fieldname:String):String;
begin
  Result := '';
  if fProductID =0 then exit;
  result :=   ' AND '+ fieldname +' = ' + IntToStr(fProductID) ;
end;
begin
  {PO}
  result:= ' SELECT ' +
            ' ProductID as ProductID, ' +
            ' convert(IF(IsNull(InvoiceDate),ReceivedDate,InvoiceDate), Datetime) as OrderedDates, ' +
            ' "PO" as Type,  ' +
            ' tblPurchaseOrders.PurchaseOrderID TransID,' +
            ' LineCost ,' +
            ' Shipped Shipped,' +
            ' LandedCostsPerItem , 0 as acutallinecost ' +
            ' FROM tblPurchaseOrders  ' +
            ' INNER JOIN tblPurchaseLines ON  tblPurchaseOrders.PurchaseOrderID = tblPurchaseLines.PurchaseOrderID  ' +
            ' WHERE tblPurchaseLines.Invoiced="T"  ' +
            ' AND tblPurchaseOrders.IsPO="T" AND tblPurchaseOrders.Deleted="F"  ' +
            Productfilter('ProductID')+
            ' AND Shipped <> 0  ' ;

  {StockAdjustment}
  result := result +  ' Union All ' +
            ' SELECT  ' +
            ' ProductID  as ProductID, ' +
            ' CreationDate as OrderedDates,  ' +
            ' "ST" as Type,  ' +
            ' tblStockMovementlines.StockMovementID TransID,  ' +
            ' Cost as LineCost,  ' +
            ' Qty Shipped,  ' +
            ' 0.00 as NA , 0 as acutallinecost  ' +
            ' FROM tblStockMovement  ' +
            ' INNER JOIN tblStockMovementlines ON tblStockMovementlines.StockMovementID = tblStockMovement.StockMovementID  ' +
            ' WHERE tblStockMovement.Deleted<>"T"  ' +
            ' AND tblStockMovement.StockmovementEntryType = ' +QuotedStr(TStockAdjustEntry.XMLNodeName)  +
            Productfilter('ProductID')+
            ' AND qty > 0   ' ;

  {Manufacturing}
  result := result +  ' Union All ' +
            ' SELECT ' +
            ' pt.PartsId  as ProductID, ' +
            ' pqa.transdate, ' +
            ' "MANUF" as Type, ' +
            ' pt.ProcTreeId TransID, ' +
            ' round(pt.cost /pt.TreePartUOMQuantity/pt.TreePartUOMMultiplier,5) as LineCost , ' +
            ' pqa.Qty Shipped, ' +
            ' 0 , Tpqa.Actualtotalcost/pqa.Qty  as acutallinecost' +
            ' FROM tblproctree pt '+
            ' inner join tblproctreepart PTP on PTP.ProcTreeId= PT.ProcTreeId'+
            ' inner join  tblPQA pqa  ON PTP.ProcTreePartId = PQA.TransLineID AND pqa.Active = "T"  ' +
            ' AND pqa.Alloctype = "IN" and pqa.Qty >0 ' +
            ' AND PQA.Transtype =' + quotedStr(TProcTreePart.ClassName) +
            Productfilter('pt.PartsId')+
            ' AND pt.Complete = "T" AND ParentId = 0 ' +
            ' Left join tblprocprogress PPG on PPG.procTreePartId = PTP.procTreePartId' +
            ' left join tbltransactionpqas Tpqa on pqa.pqaid = tpqa.pqaid'+
            ' where ifnull(PPG.ProcProgressID,0)=0 ';

  {Progress Build}
  result := result +  ' Union All ' +
            ' Select ' +
            ' PPG.ProductID as ProductID, ' +
            ' PPG.Progressdate  as transdate, ' +
            ' "PROCPROG"  as Type, ' +
            ' PPG.ProcTreeId as TransID, ' +
            ' PPG.ProductUnitCost as Linecost, ' +
            ' PPG.Qty as Shipped, ' +
            ' 0 as LandedCostsPerItem, ' +
            ' PPG.ProductUnitCost  as acutallinecost ' +
            ' from tblprocprogress PPG ' +
            ' where PPG.Alloctype ="IN" ' +
            Productfilter('PPG.ProductID');

  result := result +  ' Order by ProductID , OrderedDates desc,transID desc,Type; ';
end;

class function TProduct.CalcAvgCost(const ProductId: integer): Double;
var
  fProduct: TProduct;
begin
  fProduct:= TProduct.Create(nil);
  try
    fProduct.connection := TMyDacDataConnection.create(fProduct);
    fProduct.connection.Connection := GetNewMyDacConnection(fProduct);
    fProduct.Load(ProductID);
    result := fProduct.AvgCost;
  finally
      Freeandnil(fProduct);
  end;
end;

class function TProduct.CalcTotalQtyInStock(
  const fProductID: Integer): double;
var
  fProduct: TProduct;
begin
  fProduct:= TProduct.Create(nil);
  try
    fProduct.connection := TMyDacDataConnection.create(fProduct);
    fProduct.connection.Connection := GetNewMyDacConnection(fProduct);
    fProduct.Load(fProductID);
    result := fProduct.TotalQtyInStock;
  finally
      Freeandnil(fProduct);
  end;

end;

function TProduct.DLLUpdateAvgCosts: Double;
begin
  REsult := UpdateAvgCosts;
end;

class function TProduct.AssignBarCode(const fproductID: Integer;
  fBarcode: String): Boolean;
var
  Product :Tproduct;
begin
  Result := false;
  if (fproductID =0) or (fBarcode = '') then exit;
  Product := TProduct.Create(nil);
  try
    Product.connection := TMyDacDataConnection.create(Product);
    Product.connection.connection :=GetNewMyDacConnection(Product);
    Product.connection.BeginTransaction;
    try
      Product.Load(fProductID);
      if Product.count = 0 then exit;
      if not (Product.ProductBarcodes.Locate('barcode' , fbarcode , [])) then begin
          Product.ProductBarcodes.New;
          Product.ProductBarcodes.ProductID := Product.ID;
          Product.ProductBarcodes.BarCode := fbarcode;
          Product.ProductBarcodes.Active := true;
          Product.ProductBarcodes.IsPrimarybarcode :=(Product.Barcode = '' );
          Product.ProductBarcodes.PostDb;
          Product.ProductBarcodes.Save;
          Result := true;
          if Product.Barcode = '' then begin
            Product.Barcode := fbarcode;
            Product.PostDB;
          end;
      end;
      Product.connection.CommitTransaction;
    except
      on E:Exception do begin
        Product.connection.RollbackTransaction;
      end;
    end;
  finally
    FreeandNil(Product);
  end;
end;


function TProduct.getUOMIDforManufacture: Integer;
begin
  if UOMtobeUsedinManufacture = 'S' then result := UOMSalesID else result := UOMPurchasesID;
end;

class procedure TProduct.SetDefaultUOM(Const PartsID:Integer;var UOMID: Integer; var UOM: String; var UOMMultiplier:double);
var
  strSQL:String;
begin
  strSQL:= 'SELECT U.PartID, U.UnitName,U.UnitID,U.Multiplier ' +
            ' FROM tblunitsofmeasure U inner join tblParts P on P.PartsId = U.PartID' +
            ' Where ifnull(PartID,0)=' +intToStr(PartsId)+
            ' and (((ifnull(UOMtobeUsedinManufacture,"P")="P" and U.PurchasesDefault ="T"))  or '+
            '((ifnull(UOMtobeUsedinManufacture,"P")="S" and U.Salesdefault ="T")))'+
            ' and U.Active = "T"'+
            ' union '+
            ' Select  PartID, UnitName,UnitID,Multiplier  ' +
            ' FROM tblunitsofmeasure  ' +
            ' Where ifnull(PartID,0)=0 and  Multiplier =1   ' +
            ' and UnitName = '+ QuotedStr(AppEnv.DefaultClass.DefaultUOM)  +
            ' and (ifnull(BaseunitID,UnitID) = 0 or ifnull(BaseunitID,UnitID) = UnitID) ' +
            ' order by PartID Desc Limit 1';
  With CommonDbLib.TempMyQuery do try
    SQL.add(strSQL);
    open;
    if recordcount > 0 then begin
      UOMID := FieldByname('UnitId').asInteger;
      UOM:= FieldByname('UnitName').asString;
      UOMMultiplier:= FieldByname('Multiplier').asfloat;
      if UOMMultiplier =0 then UOMMultiplier := 1;
    end;
  finally
    if active then close;
    free;
  end;

end;


procedure TProduct.setFormulaName(const Value: String);
begin
  if Value <> '' then begin
    FormulaID:= TFormula.IDToggle(Value, Connection.Connection);
    if FormulaID = 0 then
      FormulaID:= -1;
  end
  else
    FormulaID:= 0;
end;

function TProduct.GetCountryOfOriginName: string;
begin
  if self.CountryofOriginID > 0 then
    result:= TCountries.IDToggle(CountryofOriginID)
  else
    result:= '';
end;

procedure TProduct.SetCountryOfOriginName(const Value: string);
begin
  if Value <> '' then
    self.CountryofOriginID:= TCountries.IDToggle(Value)
  else
    self.CountryofOriginID:= 0;
end;

class function TProduct.ProductAssetAccount(const aProductName: string;
  Conn: TCustomMyConnection): string;
var
  qry: TERPQuery;
begin
  if Assigned(Conn) then
    qry := DbSharedObj.GetQuery(Conn)
  else
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Text := 'select AssetAccnt from tblparts where PartName = ' + QuotedStr(aProductName);
    qry.Open;
    result := qry.Fields[0].AsString;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

class function TProduct.ProductCOGSAccount(const aProductName: string;
  Conn: TCustomMyConnection): string;
var
  qry: TERPQuery;
begin
  if Assigned(Conn) then
    qry := DbSharedObj.GetQuery(Conn)
  else
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Text := 'select COGSAccnt from tblparts where PartName = ' + QuotedStr(aProductName);
    qry.Open;
    result := qry.Fields[0].AsString;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

class function TProduct.ProductGroupForId(const aProductId: integer;
  Conn: TCustomMyConnection): string;
var
  qry: TMyQuery;
begin
  result:= '';
  qry:= TMyQuery.Create(nil);
  try
    if Assigned(Conn) then
      qry.Connection:= Conn
    else
      qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text:= 'select ProductGroup from tblParts where PartsID = ' + IntToStr(aProductID);
    qry.Open;
    result:= qry.FieldByName('ProductGroup').AsString;
  finally
    qry.Free;
  end;
end;

class function TProduct.ProductIdForBarcode(const aBarCode: string;
  var UnitOfMeasureId: integer; conn: TCustomMyConnection): integer;
var qry: TERPQuery;
begin
  if Assigned(conn) then qry := DbSharedObj.GetQuery(conn)
  else qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('SELECT PartsId, UnitOfMeasureId FROM tblPartBarCodes WHERE Active = "T" AND Barcode = ' + QuotedStr(aBarcode));
    qry.Open;
    result:= qry.FieldByName('PartsId').AsInteger;
    UnitOfMeasureId := qry.FieldByName('UnitOfMeasureId').AsInteger;
    if result = 0 then begin
      if qry.Active then qry.Close;
      qry.SQL.clear;
      qry.SQL.add('select PartsId from tblParts WHERE Barcode = ' + QuotedStr(aBarcode));
      qry.Open;
      result:= qry.FieldByName('PartsId').AsInteger;
    end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

function TProduct.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
     result := inherited DoAfterOpen(sender);
     if not result then exit;
end;
class function TProduct.GetCostForQty(const PartsID: Integer; const Qty: Double): Double;
begin
  With TProduct.CreateWithNewConn(nil) do try
    Load(PartsID);
    Result:= BuyQty1Cost;
    if (BuyQty2 <> 0) and (Qty >= BuyQty2) then Result:= BuyQty2Cost;
    if (BuyQty3 <> 0) and (Qty >= BuyQty3) then Result:= BuyQty3Cost;
  finally
    Free;
  end;
end;
procedure TProduct.setFormulaID             (const Value: Integer)    ;begin  SetIntegerField('FormulaID'              , Value);end;
function TProduct.GetProductID              : Integer  ;begin  Result := GetIntegerField('PartsId')                       ;end;
function TProduct.GetHasRelatedProducts     : Boolean  ;begin  Result := self.RelatedProducts.Count > 0                   ;end;
function TProduct.GetId                     : Integer  ;begin  Result := Self.ProductId                                   ;end;

class function TProduct.UpdateAvgCosts(AOwner: TComponent;
  Conn: TMyDacDataConnection; ProductID: Integer; StandardCost: double): Double;
var
  Product :TProduct;
begin
  REsult := 0;
  Product := TProduct.create(AOwner);
  try
    Product.connection := conn;
    Product.load(ProductID);
    if Product.count =1 then
      Result := Product.UpdateAvgCosts;
      Product.BuyQty1Cost := StandardCost;
  finally
    FreeandNil(Product);
  end;
end;

{ TProductWeb }

class function TProductWeb.GetKeyStringProperty: string;
begin
  result:= 'ProductName';
end;

function TProductWeb.GetPictures: TProductPicture;
begin
  result:= nil;
end;

function TProduct.GeTRelatedProduct: TRelatedProduct;
begin
  Result := TRelatedProduct(getcontainercomponent(TRelatedProduct , 'ParentID = ' + IntToStr(self.Id)));
end;

initialization
  RegisterClassOnce(TProduct);
  RegisterClassOnce(TProductWeb);
  RegisterClassOnce(TProductExtraBuyPrice);
  RegisterClassOnce(TProductExtraSellPrice);
  RegisterClassOnce(TForeignPrice);
  RegisterClassOnce(TForeignPrice);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Product Department and Bin','TProductClass','TProductClassListGUI');
  RegisterClassOnce(TRelatedProduct);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Related Product','TRelatedProduct','TRelatedProductsGUI');
  RegisterClassOnce(TProductSpecs);
  RegisterClassOnce(TProductSpecs);
  RegisterClassOnce(TTaxCode);
  RegisterClassOnce(TProductExtraBuyPrice);
  RegisterClassOnce(TProductExtraSellPrice);
end.



