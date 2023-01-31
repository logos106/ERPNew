unit BusobjProductProperties;
interface
{
TForeignPrice
	|---------TProductForeignSellPrice
	|---------TProductForeignBuyPrice
TProductSpecs
TProductExtraBuyPrice
TProductExtraSellPrice
TProductProcessPart
TPartsClassPreferences
TDeletedItem
	|--------TDeletedPartsClassPreferences
TProductType
TAlternateProduct
}
uses ProgressDialog, Busobjbase, DB, SysUtils, Classes, XMLDoc, MyAccess,
  XMLIntf, BusObjDeletedItem;

type

  TUOMDefaulttype = (tUOMdefaultNone = 0, tUOMSalesDefault = 1, tUOMPODefault = 2);

  TForeignPrice = class(TMSBusObj)
  private
    function GetClientId: Integer;
    function GetCurrencyId: Integer;
    function GetForeignPriceId: Integer;
    function GetIsSellPrice: Boolean;
    function GetPrice1: Double;
    function GetProductID: Integer;
    function GetQty1: Integer;
    procedure setClientId(const Value: Integer);
    procedure setCurrencyId(const Value: Integer);
    procedure setIsSellPrice(const Value: Boolean);
    procedure setPrice1(const Value: Double);
    procedure SetProductID(const Value: Integer);
    procedure setQty1(const Value: Integer);
    function GetCurrencyCode: string;
    procedure SetCurrencyCode(const Value: string);
    function GetProductName: string;
    procedure SetProductName(const Value: string);
    function GetClientName: string;
    procedure SetClientName(const Value: string);
    function GetUOMID: Integer;
    function GetUOMMultiplier: Double;
    function GetUOMName: string;
    procedure SetUOMID(const Value: Integer);
    procedure SetUOMMultiplier(const Value: Double);
    procedure SetUOMName(const Value: string);
    function GetUOMNameProductKey: string;
    procedure SetUOMNameProductKey(const Value: string);
    function getForeignPriceDescription: String;
    function getSupplierProductName: String;
    function getSupplierProductCode: String;
    procedure setForeignPriceDescription(const Value: String);
    procedure setSupplierProductName(const Value: String);
    procedure setSupplierProductCode(const Value: String);
  protected
    function GetSQL: string; override;
    function ValidateXMLData(const node: IXMLNode): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetIsList: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetId: Integer; override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    function LocateBuyPrice(const SupplierId, CurrencyID, fuomid: Integer): Boolean;
    function LocateSellPriceForCurrencyCode(const CurrencyCode: string; UnitOfMeasureID: Integer): Boolean;
    function GetBuyPrice(const SupplierId, CurrencyID: Integer; const Qty: Double; fUOMID:Integer): Double;
    function GetSellPriceForCurrencyCode(const CurrencyCode: string; const Qty: Double; UnitOfMeasureID: Integer): Double;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
  published
    property ForeignPriceId: Integer read GetForeignPriceId;
    property ProductId: Integer read GetProductID write SetProductID;
    property ProductName: string read GetProductName write SetProductName;
    property ClientId: Integer read GetClientId write setClientId;
    property ClientName: string read GetClientName write SetClientName;
    property CurrencyID: Integer read GetCurrencyId write setCurrencyId;
    property CurrencyCode: string read GetCurrencyCode write SetCurrencyCode;
    property IsSellPrice: Boolean read GetIsSellPrice write setIsSellPrice;
    property Qty1: Integer read GetQty1 write setQty1;
    property Price1: Double read GetPrice1 write setPrice1;
    property UOMName: string read GetUOMName write SetUOMName;
    property UOMID: Integer read GetUOMID write SetUOMID;
    property UOMNameProductKey: string read GetUOMNameProductKey write SetUOMNameProductKey;
    property UOMMultiplier: Double read GetUOMMultiplier write SetUOMMultiplier;
    Property ForeignPriceDescription :String read getForeignPriceDescription write setForeignPriceDescription;
    Property SupplierProductName :String read getSupplierProductName write setSupplierProductName;
    Property SupplierProductCode :String read getSupplierProductCode write setSupplierProductCode;
  end;

  TProductForeignSellPrice = class(TForeignPrice)
  private
  protected
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    class function _Schema: string; override;
  published
  end;

  TProductForeignBuyPrice = class(TForeignPrice)
  private
  protected
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    class function _Schema: string; override;
  published
  end;

  TProductSpecs = class(TMSBusObj)
  private
    function GetPartSpecID: Integer;
    procedure setPartSpecID(const Value: Integer);
    function GetProductID: Integer;
    procedure SetProductID(const Value: Integer);
    function GetSpecDescription: string;
    procedure setSpecDescription(const Value: string);
    function GetSpecValue: string;
    procedure setSpecValue(const Value: string);
    function GetIsMultiplier: Boolean;
    procedure setIsMultiplier(const Value: Boolean);
    function GetOnPrintOut: Boolean;
    procedure setOnPrintOut(const Value: Boolean);
    function GetProductName: string;
    procedure SetProductName(const Value: string);
    // function 	GetUOMID: Integer;
    // procedure	setUOMID(const Value: Integer);
  protected
    function GetSQL: string; override;
    function ValidateXMLData(const node: IXMLNode): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function GetIsList: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetId: Integer; override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    function LocateSpecID(const aSpecID: Integer): Boolean;
    function LocateSpecDescription(const aSpecDescription: string): Boolean;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    property PartSpecID: Integer read GetPartSpecID write setPartSpecID;
    function Save: Boolean; override;
    function ValidateData: Boolean; override;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
  published
    property ProductId: Integer read GetProductID write SetProductID;
    property ProductName: string read GetProductName write SetProductName;
    property SpecDescription: string read GetSpecDescription write setSpecDescription;
    property SpecValue: string read GetSpecValue write setSpecValue;
    property IsMultiplier: Boolean read GetIsMultiplier write setIsMultiplier;
    property OnPrintOut: Boolean read GetOnPrintOut write setOnPrintOut;
    // property UOMID          : Integer   Read GetUOMID           Write SetUOMID;
  end;

  TProductExtraBuyPrice = class(TMSBusObj)
  private
    function GetBuyQty1: Integer;
    function GetBuyQty1Price: Double;
    function GetPrintedValue1: Double;
    function GetProductID: Integer;
    function GetUsePrice: Boolean;
    procedure setBuyQty1(const Value: Integer);
    procedure setBuyQty1Price(const Value: Double);
    procedure setPrintedValue1(const Value: Double);
    procedure setUsePrice(const Value: Boolean);
    function GetExtraBuyPriceID: Integer;
    function GetSupplierID: Integer;
    procedure setSupplierID(const Value: Integer);
    procedure SetProductID(const Value: Integer);
    function GetSupplierProductCode: string;
    function GetSupplierProductName: string;
    function GetSupplierBarCode: string;
    procedure setSupplierProductCode(const Value: string);
    procedure setSupplierProductName(const Value: string);
    procedure setSupplierBarCode(const Value: string);
    function GetUOMID: Integer;
    function GetUOMMultiplier: Double;
    function GetUOMName: string;
    procedure SetUOMID(const Value: Integer);
    procedure SetUOMMultiplier(const Value: Double);
    procedure SetUOMName(const Value: string);
    procedure SetSupplierName(const Value: string);
    function GetSupplierName: string;
    function GetProductName: string;
    procedure SetProductName(const Value: string);
    function GetMinimumOrderQty: Double;
    procedure SetMinimumOrderQty(const Value: Double);
    function GetUOMNameProductKey: string;
    procedure SetUOMNameProductKey(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function ValidateXMLData(const node: IXMLNode): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function GetIsList: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetId: Integer; override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    property ExtraBuyPriceID: Integer read GetExtraBuyPriceID;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
  published
    property ProductId: Integer read GetProductID write SetProductID;
    property ProductName: string read GetProductName write SetProductName;
    property SupplierId: Integer read GetSupplierID write setSupplierID;
    property SupplierName: string read GetSupplierName write SetSupplierName;
    property BuyQty1: Integer read GetBuyQty1 write setBuyQty1;
    property BuyQty1Price: Double read GetBuyQty1Price write setBuyQty1Price;
    property SupplierProductCode: string read GetSupplierProductCode write setSupplierProductCode;
    property SupplierProductName: string read GetSupplierProductName write setSupplierProductName;
    property SupplierBarCode: string read GetSupplierBarCode write setSupplierBarCode;
    property UsePrice: Boolean read GetUsePrice write setUsePrice;
    property PrintedValue1: Double read GetPrintedValue1 write setPrintedValue1;
    function LocateSupplier(const fSupplierID: Integer; UOMID: Integer; const CreateifMissing: Boolean = False): Boolean;
    function GetCostForUOM(const SupplierId, UOMID: Integer; var SuppProdCode, SuppProdName, suppbarcode: string; var PrintedValue: Double): Double;
    property UOMID: Integer read GetUOMID write SetUOMID;
    property UOMName: string read GetUOMName write SetUOMName;
    property UOMNameProductKey: string read GetUOMNameProductKey write SetUOMNameProductKey;
    property UOMMultiplier: Double read GetUOMMultiplier write SetUOMMultiplier;
    property MinimumOrderQty: Double read GetMinimumOrderQty write SetMinimumOrderQty;
  end;

  TProductExtraSellPrice = class(TMSBusObj)
  private
(*    ispricechanging :Boolean;
    bUpdatingSellPrice:Boolean;
    bIsChangingPercent:Boolean;*)
    function GetAllClients: Boolean;
    function GetClientTypeID: Integer;
    function GetDateFrom: TDateTime;
    function GetDateTo: TDateTime;
    function GetExtraSellDescription: string;
    function GetExtraSellPriceID: Integer;
    function GetPrice1: Double;
    function GetProductID: Integer;
    function GetQtyPercent1: Double;
    function GetQtyLimitforDiscount: Double;
    procedure setAllClients(const Value: Boolean);
    procedure setClientTypeID(const Value: Integer);
    procedure setDateFrom(const Value: TDateTime);
    procedure setDateTo(const Value: TDateTime);
    procedure setExtraSellDescription(const Value: string);
    procedure setPrice1(const Value: Double);
    procedure SetProductID(const Value: Integer);
    procedure setQtyPercent1(const Value: Double);
    procedure setQtyLimitforDiscount(const Value: Double);
    function GetUOMID: Integer;
    function GetUOMMultiplier: Double;
    function GetUOMName: string;
    procedure SetUOMID(const Value: Integer);
    procedure SetUOMMultiplier(const Value: Double);
    procedure SetUOMName(const Value: string);
    function GetProductName: string;
    procedure SetProductName(const Value: string);
    function GetClientTypeName: string;
    function GetTerms: string;
    procedure SetClientTypeName(const Value: string);
    procedure SetTerms(const Value: string);
    function getExtraSellPriceOverridesAllDiscounts: Boolean;
    procedure setExtraSellPriceOverridesAllDiscounts(const Value: Boolean);
    function GetUOMNameProductKey: string;
    procedure SetUOMNameProductKey(const Value: string);
    function ProductPRICE1: Double;
    (*function ProductCost1: Double;*)


  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function ValidateXMLData(const node: IXMLNode): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
    function GetIsList: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetId: Integer; override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    class function DateRangeExists(const aTerms :STring;const aExtaSellPriceID, aClientTypeId, aProductId, aUOMId: Integer; aDateFrom, aDateTo: TDateTime; Conn: TCustomMyConnection = nil): Boolean;
    class function ExtraSellExists(const aTerms :STring;const aExtaSellPriceID, aClientTypeId, aProductId, aUOMId: Integer; aDateFrom, aDateTo: TDateTime; aAllClients: Boolean;
      Conn: TCustomMyConnection = nil): Boolean;
    class function ExtraSellID(const aTerms :STring;const aExtaSellPriceID, aClientTypeId,aProductId, aUOMId: Integer; aDateFrom,aDateTo: TDateTime; aAllClients: Boolean;
      Conn: TCustomMyConnection): Integer; static;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    procedure UpdatePrices;
    property ExtraSellPriceID: Integer read GetExtraSellPriceID;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
    Class Procedure ValidatediscountnCalcPrice(var Discount:double;(* Productcost:Double; ProductPrice: double; var ESPrice :Double; *)var Msg:String(*;aProductId:Integer*));Overload;
    Procedure ValidatediscountnCalcPrice;Overload;
    Procedure ReCalcPrice;
    property ExtraSellPriceOverridesAllDiscounts: Boolean read getExtraSellPriceOverridesAllDiscounts write setExtraSellPriceOverridesAllDiscounts;

  published
    property ProductId: Integer read GetProductID write SetProductID;
    property ProductName: string read GetProductName write SetProductName;
    property ClientTypeID: Integer read GetClientTypeID write setClientTypeID;
    property ClientTypeName: string read GetClientTypeName write SetClientTypeName;
    property Terms: string read GetTerms write SetTerms;
    property QtyPercent1: Double read GetQtyPercent1 write setQtyPercent1;
    property QtyLimitforDiscount: Double read GetQtyLimitforDiscount write setQtyLimitforDiscount;
    property Price1: Double read GetPrice1 write setPrice1;
    property ExtraSellDescription: string read GetExtraSellDescription write setExtraSellDescription;
    property AllClients: Boolean read GetAllClients write setAllClients;
    property DateFrom: TDateTime read GetDateFrom write setDateFrom;
    property DateTo: TDateTime read GetDateTo write setDateTo;
    property UOMID: Integer read GetUOMID write SetUOMID;
    property UOMName: string read GetUOMName write SetUOMName;
    property UOMNameProductKey: string read GetUOMNameProductKey write SetUOMNameProductKey;
    property UOMMultiplier: Double read GetUOMMultiplier write SetUOMMultiplier;
    Property RRP :Double read ProductPRICE1;

  end;

  TProductProcessPart = class(TMSBusObj)
  private
    function GetProductID: Integer;
    function GetProcessstepId: Integer;
    function GetProcessStepSeq: Integer;
    procedure SetProductID(const Value: Integer);
    procedure SetProcessstepId(const Value: Integer);
    procedure SetProcessStepSeq(const Value: Integer);
    function GetProductName: string;
    procedure SetProductName(const Value: string);
    function GetProcessStepName: string;
    procedure SetProcessStepName(const Value: string);
  protected
    function GetSQL: string; override;
    procedure DoFieldOnChange(Sender: TField); override;
    function ValidateXMLData(const node: IXMLNode): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function GetIsList: Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    constructor Create(AOwner: TComponent); override;
    function Save: Boolean; override;
    function ValidateData: Boolean; override;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
  published
    property ProductId: Integer read GetProductID write SetProductID;
    property ProductName: string read GetProductName write SetProductName;
    property ProcessStepId: Integer read GetProcessstepId write SetProcessstepId;
    property ProcessStepName: string read GetProcessStepName write SetProcessStepName;
    property ProcessStepSeq: Integer read GetProcessStepSeq write SetProcessStepSeq;

  end;
  {The preferenace to populate this table is disabled for the time being }
  (*TPartsClassPreferences = class(TMSBusObj)
  private
    function GetClassID: Integer;
    function getClassName: string;
    procedure setClassID(const Value: Integer);
    procedure SetclassName(const Value: string);
  protected
    function ValidateXMLData(const node: IXMLNode): Boolean; override;
    function GetSQL: string; override;
    procedure DoFieldOnChange(Sender: TField); override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    constructor Create(AOwner: TComponent); override;
    class function _Schema: string; override;
  published
    property DeptId: Integer read GetClassID write setClassID;
    property DeptName: string read getClassName write SetclassName;
  end;*)

//  TDeletedPartsClassPreferences = class(TDeletedItem)
//  public
//    class function GetDeletedTablename: string; override;
//  end;

  TProductType = class(TMSBusObj)
  private
    function GetTypeCode: string;
    function GetTypeDescription: string;
    procedure SetTypeCode(const Value: string);
    procedure SetTypeDescription(const Value: string);
  protected
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    class function IsValidTypeCode(const aTypeCode: string): Boolean;
    constructor Create(AOwner: TComponent); override;
  published
    property TypeCode: string read GetTypeCode write SetTypeCode;
    property TypeDescription: string read GetTypeDescription write SetTypeDescription;
  end;

  TAlternateProduct = class(TMSBusObj)
  private
    function GetProductID: Integer;
    function GetProductName: string;
    function GetAlternateProductID: Integer;
    function GetAlternateProductName: string;
    function GetAlternateProductPrintName: string;
    function GetIsDefault: Boolean;
    procedure SetProductID(const Value: Integer);
    procedure SetProductName(const Value: string);
    procedure SetAlternateProductID(const Value: Integer);
    procedure SetAlternateProductName(const Value: string);
    procedure SetAlternateProductPrintName(const Value: string);
    procedure SetIsDefault(const Value: Boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function GetIsList: Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
  published
    property ProductId: Integer read GetProductID write SetProductID;
    property ProductName: string read GetProductName write SetProductName;
    property AlternateProductID: Integer read GetAlternateProductID write SetAlternateProductID;
    property AlternateProductName: string read GetAlternateProductName write SetAlternateProductName;
    property AlternateProductPrintName: string read GetAlternateProductPrintName write SetAlternateProductPrintName;
    property IsDefault: Boolean read GetIsDefault write SetIsDefault;
  end;

implementation

uses BusObjUtils, tcDataUtils, Variants, BusObjStock, BusObjClient, CommonLib, AppEnvironment, BusObjCurrency, CommonDbLib, MySQLConst, BusObjCommon, BusObjProcessStep, ProductQtyLib, BusobjUOM,
  BusObjectListObj, BusObjSchemaLib, math, BusObjClass, tcConst,
  SalesDiscountValidationObj;

{ TForeignPrice }

constructor TForeignPrice.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ExportExcludeList.Add('foreignpriceid');
  ExportExcludeList.Add('currencyid');
  ExportExcludeList.Add('clientid');
  ExportExcludeList.Add('productid');
  ExportExcludeList.Add('issellprice');
  ExportExcludeList.Add('uomid');
  fSQL := 'SELECT FP.*,' + ' CASE' + '   WHEN IsSellPrice = "F" THEN  C.ForeignExchangeSellCode' + '   WHEN IsSellPrice = "T" THEN  CC.Code' + ' END as CurrencyCode' + ' FROM tblForeignPrice FP' +
      ' LEFT JOIN tblClients C on FP.ClientId = C.ClientId' + ' LEFT JOIN tblCurrencyConversion CC on FP.CurrencyId = CC.CurrencyId';
end;

destructor TForeignPrice.Destroy;
begin

  inherited;
end;

function TForeignPrice.LocateBuyPrice(const SupplierId, CurrencyID, fuomid: Integer): Boolean;
var
  VarClientId, VarIsSellPrice, VarCurrencyID, varuomid: variant;
begin
  Result := False;
  if DatasetAssigned and Dataset.Active then begin
    VarClientId := SupplierId;
    VarIsSellPrice := 'F';
    VarCurrencyID := CurrencyID;
    varuomid := fuomid;
    Result := Dataset.Locate('ClientId;IsSellPrice;CurrencyID;uomid', VarArrayOf([VarClientId, VarIsSellPrice, VarCurrencyID, varuomid]), []);
  end;
end;

function TForeignPrice.LocateSellPriceForCurrencyCode(const CurrencyCode: string; UnitOfMeasureID: Integer): Boolean;
var
  VarCurrencyCode, VarIsSellPrice: variant;
begin
  Result := False;
  if DatasetAssigned and Dataset.Active then begin
    VarCurrencyCode := CurrencyCode;
    VarIsSellPrice := 'T';
    Result := Dataset.Locate('CurrencyCode;IsSellPrice;UOMID', VarArrayOf([VarCurrencyCode, VarIsSellPrice, UnitOfMeasureID]), []);
  end;
end;

function TForeignPrice.GetBuyPrice(const SupplierId, CurrencyID: Integer; const Qty: Double; fUOMID:Integer): Double;
begin
  Result := 0;
  if LocateBuyPrice(SupplierId, CurrencyID, fUOMID) then begin
    Result := Price1;
    (* if (Qty2 <> 0) and (Qty >= Qty2) then Result:= Price2;
      if (Qty3 <> 0) and (Qty >= Qty3) then Result:= Price3; *)
  end;
end;

function TForeignPrice.GetSellPriceForCurrencyCode(const CurrencyCode: string; const Qty: Double; UnitOfMeasureID: Integer): Double;
begin
  Result := 0;
  if LocateSellPriceForCurrencyCode(CurrencyCode, UnitOfMeasureID) then begin
    Result := Price1;
    (* if (Qty2 <> 0) and (Qty >= Qty2) then Result:= Price2;
      if (Qty3 <> 0) and (Qty >= Qty3) then Result:= Price3; *)
  end;
end;

function TForeignPrice.GetClientId: Integer;
begin
  Result := GetIntegerField('ClientId');
end;

function TForeignPrice.GetCurrencyCode: string;
begin
  Result := TCurrency.IDToggle(self.CurrencyID, self.Connection.Connection);
end;

procedure TForeignPrice.SetCurrencyCode(const Value: string);
begin
  CurrencyID := TCurrency.IDToggle(Value, self.Connection.Connection);
end;

function TForeignPrice.GetCurrencyId: Integer;
begin
  Result := GetIntegerField('CurrencyId');
end;

function TForeignPrice.getForeignPriceDescription: String;
begin
  Result := GetStringField('ForeignPriceDescription');
end;
function TForeignPrice.getSupplierProductName: String;
begin
  Result := GetStringField('SupplierProductName');
end;
function TForeignPrice.getSupplierProductCode: String;
begin
  Result := GetStringField('SupplierProductCode');
end;

function TForeignPrice.GetForeignPriceId: Integer;
begin
  Result := GetIntegerField('ForeignPriceId');
end;

function TForeignPrice.GetId: Integer;
begin
  Result := ForeignPriceId;
end;

class function TForeignPrice.GetIDField: string;
begin
  Result := 'ForeignPriceId';
end;

class function TForeignPrice.GetBusObjectTablename: string;
begin
  Result := 'tblForeignPrice';
end;

function TForeignPrice.GetIsList: Boolean;
begin
  Result := true;
end;

function TForeignPrice.GetIsSellPrice: Boolean;
begin
  Result := GetBooleanField('IsSellPrice');
end;

class function TForeignPrice.GetKeyStringProperty: string;
begin
  Result := '';
end;

function TForeignPrice.GetPrice1: Double;
begin
  Result := GetFloatField('Price1');
end;

function TForeignPrice.GetProductID: Integer;
begin
  Result := GetIntegerField('PartsId');
end;

function TForeignPrice.GetQty1: Integer;
begin
  Result := GetIntegerField('Buy1');
end;

function TForeignPrice.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

procedure TForeignPrice.setClientId(const Value: Integer);
begin
  SetIntegerField('ClientId', Value);
end;

procedure TForeignPrice.setCurrencyId(const Value: Integer);
begin
  SetIntegerField('CurrencyId', Value);
end;

procedure TForeignPrice.setForeignPriceDescription(const Value: String);
begin
  SetStringField('ForeignPriceDescription', Value);
end;
procedure TForeignPrice.setSupplierProductName(const Value: String);
begin
  SetStringField('SupplierProductName', Value);
end;
procedure TForeignPrice.setSupplierProductCode(const Value: String);
begin
  SetStringField('SupplierProductCode', Value);
end;

procedure TForeignPrice.setIsSellPrice(const Value: Boolean);
begin
  SetBooleanField('IsSellPrice', Value);
end;

procedure TForeignPrice.setPrice1(const Value: Double);
begin
  SetFloatField('Price1', Value);
end;

procedure TForeignPrice.SetProductID(const Value: Integer);
begin
  SetIntegerField('PartsId', Value);
end;

procedure TForeignPrice.setQty1(const Value: Integer);
begin
  SetIntegerField('Buy1', Value);
end;

function TForeignPrice.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  if IsOwnerProduct(self) then ProductId := TProduct(self.Owner).ID;
  UOMMultiplier := 1;
  UOMName := AppEnv.DefaultClass.DefaultUOM;
  Result := true;
end;

function TForeignPrice.ValidateXMLData(const node: IXMLNode): Boolean;
var
  iProductId, icurrencyID, iclientId: Integer;
begin
  Result := inherited ValidateXMLData(node);
  if not Result then Exit;
  if not ImportingFromXMLFile then Exit;
  XMLSearchRecordDesc := 'Product  = ' + GetXMLProductName(self, node, 'ProductName') + ' and Client = ' + GetXMLNodeStringValue(node, 'ClientName') + ' and Currency = ' +
    GetXMLNodeStringValue(node, 'Currency');
  Result := False;

  iProductId := checkProduct(self, node, 'ProductName');
  if iProductId = 0 then begin
    ErrRecordNotfound('Product Name', GetXMLNodeStringValue(node, 'ProductName'));
    Exit;
  end;

  icurrencyID := tcDataUtils.GetCurrencyId(GetXMLNodeStringValue(node, 'Currency'));
  if icurrencyID = 0 then begin
    ErrRecordNotfound('Currency', GetXMLNodeStringValue(node, 'Currency'));
    Exit;
  end;

  iclientId := 0;
  if GetXMLNodeStringValue(node, 'ClientName') <> '' then begin
    iclientId := TClient.IDToggle(GetXMLNodeStringValue(Node, 'ClientName'), Connection.Connection);
    if iclientId = 0 then begin
      ErrRecordNotfound('Client', GetXMLNodeStringValue(node, 'ClientName'));
      Exit;
    end;
  end;

  Result := true;

  XMLSearchRecord := 'FP.PartsID = ' + IntToStr(iProductId) + ' and FP.ClientID = ' + IntToStr(iclientId) + ' and FP.CurrencyId = ' + IntToStr(icurrencyID);
  LocateXMLRecord;

end;

class function TForeignPrice._Schema: string;
begin
  Result := inherited;
//  TBOSchema.AddRefType(Result, 'TProductWeb', 'ProductObj', 'ProductID', 'ID');
//  TBOSchema.AddRefType(Result, 'TProductWeb', 'ProductObj', 'ProductName', 'ProductName');
  TBOSchema.AddRefType(Result, 'TCurrency', 'CurrencyObj', 'CurrencyID', 'ID');
  TBOSchema.AddRefType(Result, 'TCurrency', 'CurrencyObj', 'CurrencyCode', 'Code');
  TBOSchema.AddRefType(Result, 'TUnitOfMeasure', 'UOMObj', 'UOMID', 'ID');
  TBOSchema.AddRefType(Result, 'TUnitOfMeasure', 'UOMObj', 'UOMNameProductKey', 'UnitProductKeyName');

end;

procedure TForeignPrice.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  ProductId := checkProduct(self, node, 'ProductName');
  if not ImportingFromXMLFile then begin
    SetPropertyFromNode(node, 'ClientId');
    SetPropertyFromNode(node, 'CurrencyId');
  end else begin
    ClientId := TClient.IDToggle(GetXMLNodeStringValue(Node, 'ClientName'), Connection.Connection);
    CurrencyID := tcDataUtils.GetCurrencyId(GetXMLNodeStringValue(node, 'Currency'));
  end;
  SetBooleanPropertyFromNode(node, 'IsSellPrice');
  SetPropertyFromNode(node, 'Qty1');
  SetPropertyFromNode(node, 'Price1');
  SetPropertyFromNode(node, 'ForeignPriceDescription');
  SetPropertyFromNode(node, 'SupplierProductName');
  SetPropertyFromNode(node, 'SupplierProductCode');
end;

procedure TForeignPrice.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;

  if not SavingXMLTofile then begin
    AddXMLNode(node, 'ProductId', ProductId);
    AddXMLNode(node, 'ClientId', ClientId);
    AddXMLNode(node, 'CurrencyId', CurrencyID);
    AddXMLNode(node, 'UOMID', UOMID);
  end else begin
    AddXMLNode(node, 'ClientName', ClientName);
    AddXMLNode(node, 'Currency', getCurrencyName(CurrencyID));
    if not IsOwnerProduct(self) then AddXMLNode(node, 'ProductName', getProduct(ProductId));
  end;
  AddXMLNode(node, 'CurrencyCode', CurrencyCode);
  AddXMLNode(node, 'IsSellPrice', IsSellPrice);
  AddXMLNode(node, 'Qty1', Qty1);
  AddXMLNode(node, 'Price1', Price1);
  AddXMLNode(node, 'UOMName', UOMName);
  AddXMLNode(node, 'UOMMultiplier', UOMMultiplier);
  AddXMLNode(node, 'ForeignPriceDescription', ForeignPriceDescription);
  AddXMLNode(node, 'SupplierProductName', SupplierProductName);
  AddXMLNode(node, 'SupplierProductCode', SupplierProductCode);
end;

procedure TForeignPrice.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if SysUtils.SameText(Sender.fieldName, 'PartsID') then begin
    if Assigned(Owner) and (Owner is TProduct) then ProductName := TProduct(Owner).ProductName
    else ProductName := TProduct.IDToggle(Sender.AsInteger, Connection.Connection);
  end
  else if SysUtils.SameText(Sender.fieldName, 'PartName') then begin
    ProductId := TProduct.IDToggle(Sender.AsString, Connection.Connection);
  end
  else if SysUtils.SameText(Sender.fieldName, 'UOM') then begin
    if (self.UOMName <> '') and (self.UOMMultiplier <> 0) then begin
      self.UOMID := TUnitOfMeasure.IdForNameAndMult(UOMName, UOMMultiplier, ProductId);
    end;
  end
  else if SysUtils.SameText(Sender.fieldName, 'UOMMultiplier') then begin
    if (self.UOMName <> '') and (self.UOMMultiplier <> 0) then begin
      self.UOMID := TUnitOfMeasure.IdForNameAndMult(UOMName, UOMMultiplier, ProductId);
    end;
  end
  else if SysUtils.SameText(Sender.fieldName, 'UOMID') then begin
    //UOMName := TUnitOfMeasure.IDToggle(UOMID, self.Connection.Connection);
    UOMName := tcdatautils.GetUOMName(UOMID, self.connection.connection);
    UOMMultiplier := TUnitOfMeasure.MultiplierForUnitID(UOMID, self.Connection.Connection);
  end;
end;

function TForeignPrice.GetProductName: string;
begin
  Result := GetStringField('PartName');
end;

procedure TForeignPrice.SetProductName(const Value: string);
begin
  SetStringField('PartName', Value);
end;

function TForeignPrice.GetClientName: string;
begin
  Result := TClient.IDToggle(ClientId, Connection.Connection);
end;

procedure TForeignPrice.SetClientName(const Value: string);
begin
  ClientId := TClient.IDToggle(Value, Connection.Connection);
end;

function TForeignPrice.GetUOMID: Integer;
begin
  Result := GetIntegerField('UOMID');
end;

function TForeignPrice.GetUOMMultiplier: Double;
begin
  Result := GetFloatField('UOMMultiplier');
end;

function TForeignPrice.GetUOMName: string;
begin
  Result := GetStringField('UOM');
end;

function TForeignPrice.GetUOMNameProductKey: string;
begin
  Result := TUnitOfMeasure.IDToggle(UOMID, Connection.Connection);
end;

procedure TForeignPrice.SetUOMID(const Value: Integer);
begin
  SetIntegerField('UOMID', Value);
end;

procedure TForeignPrice.SetUOMMultiplier(const Value: Double);
begin
  SetFloatField('UOMMultiplier', Value);
end;

procedure TForeignPrice.SetUOMName(const Value: string);
begin
  SetStringField('UOM', Value);
end;

procedure TForeignPrice.SetUOMNameProductKey(const Value: string);
begin
  UOMID := TUnitOfMeasure.IDToggle(Value, Connection.Connection);
end;

function TForeignPrice.ValidateData: Boolean;
begin
  Result := inherited ValidateData;
  if not Result then Exit;

  if ProductId < 1 then begin
    Result := False;
    AddResult(False, rssWarning, 0, 'Product should not be blank');
    Exit;
  end;
  if (CurrencyID = 0) then begin
    Result := False;
    AddResult(False, rssWarning, 0, 'No Currency specified');
    Exit;
  end;
  if (UOMID = 0) then begin
    Result := False;
    AddResult(False, rssWarning, 0, 'No UOM specified');
    Exit;
  end;
  if (UOMName <> '') and (UOMMultiplier <> 0) then begin
    if self.UOMID = 0 then begin
      Result := False;
      AddResult(False, rssWarning, 0, 'Could not find a matching UOM record for the UOM Name (' + UOMName + ') and Multiplier (' + FloatToStr(UOMMultiplier) + ') specified');
      Exit;
    end;
  end;
  if Assigned(Owner) and (Owner is TProduct) and (TProduct(Owner).ID <> ProductId) then begin
    Result := False;
    AddResult(False, rssWarning, 0, 'Product ID does not match ID of the parent Product');
    Exit;
  end;
end;

function TForeignPrice.Save: Boolean;
begin
  Result := ValidateData;
  if Result then Result := inherited Save;
end;

{ TProductSpecs }

constructor TProductSpecs.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblpartsspecifications';
  ExportExcludeList.Add('productid');
end;

destructor TProductSpecs.Destroy;
begin

  inherited;
end;

function TProductSpecs.GetId: Integer;
begin
  Result := PartSpecID;
end;

class function TProductSpecs.GetIDField: string;
begin
  Result := 'PartSpecID';
end;

class function TProductSpecs.GetBusObjectTablename: string;
begin
  Result := 'tblpartsspecifications';
end;

function TProductSpecs.GetOnPrintOut: Boolean;
begin
  Result := GetBooleanField('OnPrintOut');
end;

function TProductSpecs.GetIsList: Boolean;
begin
  Result := true;
end;

function TProductSpecs.GetIsMultiplier: Boolean;
begin
  Result := GetBooleanField('IsMultiplier');
end;

class function TProductSpecs.GetKeyStringProperty: string;
begin
  Result := '';
end;

function TProductSpecs.GetPartSpecID: Integer;
begin
  Result := GetIntegerField('PartSpecID');
end;

function TProductSpecs.GetProductID: Integer;
begin
  Result := GetIntegerField('PartsID');
end;

function TProductSpecs.GetSpecDescription: string;
begin
  Result := GetStringField('SpecDescription');
end;

function TProductSpecs.GetSpecValue: string;
begin
  Result := GetStringField('SpecValue');
end;

function TProductSpecs.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

function TProductSpecs.LocateSpecDescription(const aSpecDescription: string): Boolean;
begin
  Result := Dataset.Locate('SpecDescription', aSpecDescription, [loCaseInsensitive]);
end;

function TProductSpecs.LocateSpecID(const aSpecID: Integer): Boolean;
begin
  Result := self.Dataset.Locate('PartSpecID', aSpecID, []);
end;

procedure TProductSpecs.setOnPrintOut(const Value: Boolean);
begin
  SetBooleanField('OnPrintOut', Value);
end;

procedure TProductSpecs.setIsMultiplier(const Value: Boolean);
begin
  SetBooleanField('IsMultiplier', Value);
end;

procedure TProductSpecs.setPartSpecID(const Value: Integer);
begin
  SetIntegerField('PartSpecID', Value);
end;

procedure TProductSpecs.SetProductID(const Value: Integer);
begin
  SetIntegerField('PartsId', Value);
end;

procedure TProductSpecs.setSpecDescription(const Value: string);
begin
  SetStringField('SpecDescription', Value);
end;

procedure TProductSpecs.setSpecValue(const Value: string);
begin
  SetStringField('SpecValue', Value);
end;

// function TProductSpecs.GetUOMID: Integer;
// begin
// Result := GetIntegerField('UOMID');
// end;

// procedure TProductSpecs.SetUOMID(const Value: Integer);
// begin
// SetIntegerField('UOMID',Value);
// end;

function TProductSpecs.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  if IsOwnerProduct(self) then ProductId := TProduct(self.Owner).ID;
  Result := true;
end;

function TProductSpecs.ValidateXMLData(const node: IXMLNode): Boolean;
var
  iProductId: Integer;
begin
  Result := inherited ValidateXMLData(node);
  if not Result then Exit;
  if not ImportingFromXMLFile then Exit;
  XMLSearchRecordDesc := 'Product = ' + GetXMLProductName(self, node, 'ProductName') + ' and SpecDescription = ' + GetXMLNodeStringValue(node, 'SpecDescription');
  Result := False;

  iProductId := checkProduct(self, node, 'ProductName');
  if iProductId = 0 then begin
    ErrRecordNotfound('ProductName', GetXMLNodeStringValue(node, 'ProductName'));
    Exit;
  end;

  XMLSearchRecord := 'PartsID = ' + IntToStr(iProductId) + ' and SpecDescription = ' + QuotedStr(GetXMLNodeStringValue(node, 'SpecDescription'));

  Result := true;
  LocateXMLRecord;
end;

class function TProductSpecs._Schema: string;
begin
  Result := inherited;
end;

procedure TProductSpecs.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  ProductId := checkProduct(self, node, 'SpecProductName');
  // if not ImportingFromXMLFile then begin
  // SetPropertyFromNode(Node,'UOMID');
  // end else begin
  // if GetXMLNodeStringValue(Node, 'UnitOfMeasure') <> '' then
  // if GetXMLNodeStringValue(Node, 'UnitProductName') <> '' then
  // if tcdataUtils.GetUnitOfMeasureID(GetXMLNodeStringValue(Node, 'UnitOfMeasure') , tcDatautils.getproduct(GetXMLNodeStringValue(Node, 'UnitProductName'))) = 0 then Exit;
  // end;
  SetPropertyFromNode(node, 'SpecDescription');
  SetPropertyFromNode(node, 'SpecValue');
  SetBooleanPropertyFromNode(node, 'IsMultiplier');
  SetBooleanPropertyFromNode(node, 'OnPrintOut');
end;

procedure TProductSpecs.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;

  if not SavingXMLTofile then begin
    AddXMLNode(node, 'ProductId', ProductId);
    // AddXMLNode(node , 'UOMID', 		 UOMID);
  end else begin
    // AddXMLNode(node , 'UnitProductName',  getUnitProductName(UOMID));
    // AddXMLNode(node , 'UnitOfMeassure',  GetUOMName(UOMID));
    AddXMLNode(node, 'SpecProductName', tcDataUtils.getProduct(ProductId));
    AddXMLNode(node, 'ProductName', OwnerProductname(self));
  end;
  AddXMLNode(node, 'SpecDescription', SpecDescription);
  AddXMLNode(node, 'SpecValue', SpecValue);
  AddXMLNode(node, 'IsMultiplier', IsMultiplier);
  AddXMLNode(node, 'OnPrintOut', OnPrintOut);
end;

function TProductSpecs.GetProductName: string;
begin
  if Assigned(Owner) and (Owner is TProduct) then Result := TProduct(Owner).ProductName
  else Result := TProduct.IDToggle(ProductId, Connection.Connection);
end;

procedure TProductSpecs.SetProductName(const Value: string);
begin
  ProductId := TProduct.IDToggle(Value, Connection.Connection);
end;

function TProductSpecs.ValidateData: Boolean;
begin
  Result := inherited ValidateData;
  if not Result then Exit;

  if ProductId < 1 then begin
    Result := False;
    AddResult(False, rssWarning, 0, 'Product should not be blank');
    Exit;
  end;
  if SpecDescription = '' then begin
    Result := False;
    AddResult(False, rssWarning, 0, 'Spec Description should not be blank');
    Exit;
  end;
  if SpecValue = '' then begin
    Result := False;
    AddResult(False, rssWarning, 0, 'Spec Value should not be blank');
    Exit;
  end;
  if Assigned(Owner) and (Owner is TProduct) and (TProduct(Owner).ID <> ProductId) then begin
    Result := False;
    AddResult(False, rssWarning, 0, 'Product ID does not match ID of the parent Product');
    Exit;
  end;
end;

function TProductSpecs.Save: Boolean;
begin
  Result := ValidateData;
  if Result then Result := inherited Save;
end;

{ TProductExtraBuyPrice }

constructor TProductExtraBuyPrice.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblExtraPrice';
  ExportExcludeList.Add('supplierid');
  ExportExcludeList.Add('extrabuypriceid');
  ExportExcludeList.Add('uomid');
  ExportExcludeList.Add('productid');
end;

destructor TProductExtraBuyPrice.Destroy;
begin

  inherited;
end;

procedure TProductExtraBuyPrice.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if SysUtils.SameText(Sender.fieldName, 'UOM') then begin
    if (self.UOMName <> '') and (self.UOMMultiplier <> 0) then begin
      self.UOMID := TUnitOfMeasure.IdForNameAndMult(UOMName, UOMMultiplier, ProductId);
    end;
  end
  else if SysUtils.SameText(Sender.fieldName, 'Multiplier') then begin
    if (self.UOMName <> '') and (self.UOMMultiplier <> 0) then begin
      self.UOMID := TUnitOfMeasure.IdForNameAndMult(UOMName, UOMMultiplier, ProductId);
    end;
  end
  else if SysUtils.SameText(Sender.fieldName, 'UOMID') then begin
    //UOMName := TUnitOfMeasure.IDToggle(UOMID, self.Connection.Connection);
    UOMName := tcdatautils.GetUOMName(UOMID, self.connection.connection);
    UOMMultiplier := TUnitOfMeasure.MultiplierForUnitID(UOMID, self.Connection.Connection);
  end
  else if SysUtils.SameText(Sender.fieldName, 'PartName') then begin
    if Assigned(Owner) and (Owner is TProduct) then begin
      if Sender.AsString <> TProduct(Owner).ProductName then
        ProductId := TProduct.IDToggle(Sender.AsString, Connection.connection);
    end
    else
      ProductId := TProduct.IDToggle(Sender.AsString, Connection.connection);
  end
  else if SysUtils.SameText(Sender.fieldName, 'PartsID') then begin
    if Assigned(Owner) and (Owner is TProduct) then begin
      if Sender.AsInteger <> TProduct(Owner).ID then
        ProductName := TProduct.IDToggle(Sender.AsInteger, Connection.connection);
    end
    else
      ProductName := TProduct.IDToggle(Sender.AsInteger, Connection.connection);
  end;
end;

procedure TProductExtraBuyPrice.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;

end;

function TProductExtraBuyPrice.GetBuyQty1: Integer;
begin
  Result := GetIntegerField('Buy1');
end;

function TProductExtraBuyPrice.GetBuyQty1Price: Double;
begin
  Result := GetFloatField('Price');
end;

(* function TProductExtraBuyPrice.GetBuyQty2: Integer;
  begin
  Result:= GetIntegerField('Buy2');
  end;

  function TProductExtraBuyPrice.GetBuyQty2Price: Double;
  begin
  Result:= GetFloatField('Price2');
  end;

  function TProductExtraBuyPrice.GetBuyQty3: Integer;
  begin
  Result:= GetIntegerField('Buy3');
  end;

  function TProductExtraBuyPrice.GetBuyQty3Price: Double;
  begin
  Result:= GetFloatField('Price3');
  end; *)

function TProductExtraBuyPrice.GetId: Integer;
begin
  Result := self.ExtraBuyPriceID;
end;

class function TProductExtraBuyPrice.GetIDField: string;
begin
  Result := 'ExtraPartPriceID';
end;

function TProductExtraBuyPrice.GetIsList: Boolean;
begin
  Result := true;
end;

class function TProductExtraBuyPrice.GetKeyStringProperty: string;
begin
  Result := '';
end;

function TProductExtraBuyPrice.GetMinimumOrderQty: Double;
begin
  Result := GetFloatField('MinimumOrderQty');
end;

class function TProductExtraBuyPrice.GetBusObjectTablename: string;
begin
  Result := 'tblExtraPrice';
end;

function TProductExtraBuyPrice.GetPrintedValue1: Double;
begin
  Result := GetFloatField('PrintedValue1');
end;

(* function TProductExtraBuyPrice.GetPrintedValue2: Double;
  begin
  Result:= GetFloatField('PrintedValue2');
  end;

  function TProductExtraBuyPrice.GetPrintedValue3: Double;
  begin
  Result:= GetFloatField('PrintedValue3');
  end; *)

function TProductExtraBuyPrice.GetProductID: Integer;
begin
  Result := GetIntegerField('PartsID');
end;

function TProductExtraBuyPrice.GetUsePrice: Boolean;
begin
  Result := GetBooleanField('UsePrice');
end;

procedure TProductExtraBuyPrice.setBuyQty1(const Value: Integer);
begin
  SetIntegerField('Buy1', Value);
end;

procedure TProductExtraBuyPrice.setBuyQty1Price(const Value: Double);
begin
  SetFloatField('Price', Value);
end;

procedure TProductExtraBuyPrice.SetMinimumOrderQty(const Value: Double);
begin
  SetFloatField('MinimumOrderQty', Value);
end;

(* procedure TProductExtraBuyPrice.SetBuyQty2(const Value: Integer);
  begin
  SetIntegerField('Buy2', Value);
  end;

  procedure TProductExtraBuyPrice.SetBuyQty2Price(const Value: Double);
  begin
  SetFloatField('Price2', Value);
  end;

  procedure TProductExtraBuyPrice.SetBuyQty3(const Value: Integer);
  begin
  SetIntegerField('Buy3', Value);
  end;

  procedure TProductExtraBuyPrice.SetBuyQty3Price(const Value: Double);
  begin
  SetFloatField('Price3', Value);
  end; *)

procedure TProductExtraBuyPrice.setPrintedValue1(const Value: Double);
begin
  SetFloatField('PrintedValue1', Value);
end;

(* procedure TProductExtraBuyPrice.SetPrintedValue2(const Value: Double);
  begin
  SetFloatField('PrintedValue2', Value);
  end;

  procedure TProductExtraBuyPrice.SetPrintedValue3(const Value: Double);
  begin
  SetFloatField('PrintedValue3', Value);
  end; *)

procedure TProductExtraBuyPrice.setUsePrice(const Value: Boolean);
begin
  SetBooleanField('UsePrice', Value);
end;

function TProductExtraBuyPrice.GetExtraBuyPriceID: Integer;
begin
  Result := GetIntegerField('ExtraPartPriceID');
end;

function TProductExtraBuyPrice.GetSupplierID: Integer;
begin
  Result := GetIntegerField('SupplierID');
end;

procedure TProductExtraBuyPrice.setSupplierID(const Value: Integer);
begin
  SetIntegerField('SupplierID', Value);
end;

procedure TProductExtraBuyPrice.SetProductID(const Value: Integer);
begin
  SetIntegerField('PartsID', Value);
end;

function TProductExtraBuyPrice.GetSupplierProductCode: string;
begin
  Result := GetStringField('SupplierProductCode');
end;

function TProductExtraBuyPrice.GetSupplierProductName: string;
begin
  Result := GetStringField('SupplierProductName');
end;
function TProductExtraBuyPrice.GetSupplierBarCode: string;
begin
  Result := GetStringField('SupplierBarCode');
end;
procedure TProductExtraBuyPrice.setSupplierProductCode(const Value: string);
begin
  SetStringField('SupplierProductCode', Value);
end;

procedure TProductExtraBuyPrice.setSupplierProductName(const Value: string);
begin
  SetStringField('SupplierProductName', Value);
end;
procedure TProductExtraBuyPrice.setSupplierBarCode(const Value: string);
begin
  SetStringField('SupplierBarCode', Value);
end;

function TProductExtraBuyPrice.GetCostForUOM(const SupplierId, UOMID: Integer; var SuppProdCode, SuppProdName, suppbarcode: string; var PrintedValue: Double): Double;
begin

  Result := 0;
  SuppProdCode := '';
  SuppProdName := '';
  suppbarcode := '';
  PrintedValue := 0;
  if (SupplierId = 0) or (UOMID = 0) then Exit;

  if LocateSupplier(SupplierId, UOMID) then begin
    Result := BuyQty1Price;
    SuppProdCode := SupplierProductCode;
    SuppProdName := SupplierProductName;
    suppbarcode  := SupplierBarCode;
    PrintedValue := PrintedValue1;
    Exit;
  end;
  if LocateSupplier(SupplierId, 0) then begin
    Result := BuyQty1Price;
    SuppProdCode := SupplierProductCode;
    SuppProdName := SupplierProductName;
    suppbarcode  := SupplierBarCode;
    PrintedValue := PrintedValue1;
    Exit;
  end;
end;

function TProductExtraBuyPrice.LocateSupplier(const fSupplierID: Integer; UOMID: Integer; const CreateifMissing: Boolean = False): Boolean;
begin
  Result := False;
  if DSReadOk then begin
    Result := self.Dataset.Locate('SupplierID;UOMID', VarArrayOf([fSupplierID, UOMID]), []);
    if not Result then Result := self.Dataset.Locate('SupplierID;UOMID', VarArrayOf([fSupplierID, 0]), []);
    if not Result then Result := self.Dataset.Locate('SupplierID;UOMID', VarArrayOf([0, UOMID]), []);
    if not Result then
      if CreateifMissing then begin
        New;
        SupplierId := fSupplierID;
        BuyQty1 := 1;
        (* BuyQty2 := 1;
          BuyQty3 := 1; *)
        self.UOMID := UOMID;
        PostDB;
        Result := true;
      end;

  end;

end;

function TProductExtraBuyPrice.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  if IsOwnerProduct(self) then begin
    ProductId := TProduct(self.Owner).ID;
    ProductName:= TProduct(self.Owner).ProductName;
  end;
  Result := true;
end;

function TProductExtraBuyPrice.ValidateXMLData(const node: IXMLNode): Boolean;
var
  iProductId, iSupplierId: Integer;
begin
  Result := inherited ValidateXMLData(node);
  if not Result then Exit;
  if not ImportingFromXMLFile then Exit;
  XMLSearchRecordDesc := 'Product = ' + GetXMLProductName(self, node, 'ProductName') + ' and Supplier = ' + GetXMLClientNAme(self, node, 'Supplier');
  Result := False;

  iProductId := checkProduct(self, node, 'ProductName');
  if iProductId = 0 then begin
    ErrRecordNotfound('Product Name', GetXMLNodeStringValue(node, 'ProductName'));
    Exit;
  end;

  iSupplierId := 0;
  if (Assigned(self.Owner)) and (self.Owner is TSupplier) then begin
    if TSupplier(self.Owner).ClientName <> GetXMLNodeStringValue(node, 'Supplier') then iSupplierId := TSupplier(self.Owner).ID;
  end
  else iSupplierId := TClient.IDToggle(GetXMLNodeStringValue(Node, 'Supplier'), Connection.Connection);

  if iSupplierId = 0 then begin
    ErrRecordNotfound('Supplier Name', GetXMLNodeStringValue(node, 'Supplier'));
    Exit;
  end;
  Result := true;
  XMLSearchRecord := 'PartsID = ' + IntToStr(iProductId) + ' and SupplierID = ' + IntToStr(iSupplierId);
  LocateXMLRecord;
end;

class function TProductExtraBuyPrice._Schema: string;
begin
  Result := inherited;
//  TBOSchema.AddRefType(Result, 'TProductWeb', 'ProductObj', 'ProductID', 'ID');
//  TBOSchema.AddRefType(Result, 'TProductWeb', 'ProductObj', 'ProductName', 'ProductName');
  TBOSchema.AddRefType(Result, 'TSupplier', 'SupplierObj', 'SupplierID', 'ID');
  TBOSchema.AddRefType(Result, 'TSupplier', 'SupplierObj', 'SupplierName', 'ClientName');
  TBOSchema.AddRefType(Result, 'TUnitOfMeasure', 'UOMObj', 'UOMID', 'ID');
  TBOSchema.AddRefType(Result, 'TUnitOfMeasure', 'UOMObj', 'UOMNameProductKey', 'UnitProductKeyName');

end;

procedure TProductExtraBuyPrice.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited LoadFromXMLNode(node);
  ProductId := checkProduct(self, node, 'ProductName');
  if not ImportingFromXMLFile then begin
    SetPropertyFromNode(node, 'SupplierID');
  end else begin
    SupplierId := TClient.IDToggle(GetXMLNodeStringValue(Node, 'Supplier'), Connection.Connection);
  end;
  SetPropertyFromNode(node, 'BuyQty1');
  SetPropertyFromNode(node, 'BuyQty1Price');
  SetPropertyFromNode(node, 'BuyQty2');
  SetPropertyFromNode(node, 'BuyQty2Price');
  SetPropertyFromNode(node, 'BuyQty3');
  SetPropertyFromNode(node, 'BuyQty3Price');
  SetPropertyFromNode(node, 'SupplierProductCode');
  SetPropertyFromNode(node, 'SupplierProductName');
  SetPropertyFromNode(node, 'SupplierBarCode');
  SetBooleanPropertyFromNode(node, 'UsePrice');
  SetPropertyFromNode(node, 'PrintedValue1');
  SetPropertyFromNode(node, 'PrintedValue2');
  SetPropertyFromNode(node, 'PrintedValue3');
  SetPropertyFromNode(node, 'UOMID');
  SetPropertyFromNode(node, 'UOMName');
  SetPropertyFromNode(node, 'UOMMultiplier');
end;

procedure TProductExtraBuyPrice.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;

  if not SavingXMLTofile then begin
    AddXMLNode(node, 'ProductId', ProductId);
    AddXMLNode(node, 'SupplierID', SupplierId);
  end else begin
    if not IsOwnerProduct(self) then AddXMLNode(node, 'ProductName', getProduct(ProductId));
    AddXMLNode(node, 'Supplier', GetClientName(SupplierId));
  end;
  AddXMLNode(node, 'SupplierProductCode', SupplierProductCode);
  AddXMLNode(node, 'SupplierProductName', SupplierProductName);
  AddXMLNode(node, 'SupplierBarCode', SupplierBarCode);
  AddXMLNode(node, 'BuyQty1', BuyQty1);
  AddXMLNode(node, 'BuyQty1Price', BuyQty1Price);
  (* AddXMLNode(node , 'BuyQty2', 			 BuyQty2);
    AddXMLNode(node , 'BuyQty2Price', 	 BuyQty2Price);
    AddXMLNode(node , 'BuyQty3', 			 BuyQty3);
    AddXMLNode(node , 'BuyQty3Price', 	 BuyQty3Price); *)
  AddXMLNode(node, 'UsePrice', UsePrice);
  AddXMLNode(node, 'PrintedValue1', PrintedValue1);
  (* AddXMLNode(node , 'PrintedValue2', 	 PrintedValue2);
    AddXMLNode(node , 'PrintedValue3', 	 PrintedValue3); *)
  AddXMLNode(node, 'UOMID', UOMID);
  AddXMLNode(node, 'UOMName', UOMName);
  AddXMLNode(node, 'UOMMultiplier', UOMMultiplier);
end;

procedure TProductExtraBuyPrice.SetSupplierName(const Value: string);
begin
  SupplierId := TClient.IDToggle(Value);
end;

function TProductExtraBuyPrice.GetSupplierName: string;
begin
  Result := TClient.IDToggle(SupplierId);
end;

function TProductExtraBuyPrice.ValidateData: Boolean;
begin
  Result := inherited ValidateData;
  if not Result then Exit;

  if ProductId < 1 then begin
    Result := False;
    AddResult(False, rssWarning, 0, 'Product ID should not be blank');
    Exit;
  end;
  if ProductName = '' then begin
    Result := False;
    AddResult(False, rssWarning, 0, 'Product Name should not be blank');
    Exit;
  end;
  if Assigned(Owner) and (Owner is TProduct) then begin
    if ProductID <> TProduct(Owner).ID then begin
      Result := False;
      AddResult(False, rssWarning, 0, 'Product ID does not match parent Product ID');
      Exit;
    end;
    if ProductName <> TProduct(Owner).ProductName then begin
      Result := False;
      AddResult(False, rssWarning, 0, 'Product Name does not match parent Product Name');
      Exit;
    end;
  end;
  if (SupplierId = 0) and (UOMID = 0) then begin
    Result := False;
    AddResult(False, rssWarning, 0, 'No Supplier or UOM, Extra Buy Price requires one (or both) of these');
    Exit;
  end;
  if (UOMName <> '') and (UOMMultiplier <> 0) then begin
    if self.UOMID = 0 then begin
      Result := False;
      AddResult(False, rssWarning, 0, 'Could not find a matching UOM record for the UOM Name (' + UOMName + ') and Multiplier (' + FloatToStr(UOMMultiplier) + ') specified');
      Exit;
    end;
  end;
  if Assigned(Owner) and (Owner is TProduct) and (TProduct(Owner).ID <> ProductId) then begin
    Result := False;
    AddResult(False, rssWarning, 0, 'Product ID does not match ID of the parent Product');
    Exit;
  end;
end;

function TProductExtraBuyPrice.GetProductName: string;
begin
  Result := GetStringField('PartName');
end;

procedure TProductExtraBuyPrice.SetProductName(const Value: string);
begin
  SetStringField('PartName', Value);
end;

function TProductExtraBuyPrice.Save: Boolean;
begin
  Result := ValidateData;
  if Result then Result := inherited Save;
end;

{ TProductExtraSellPrice }

constructor TProductExtraSellPrice.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblExtraPriceSell';
  ExportExcludeList.Add('productid');
  ExportExcludeList.Add('clienttypeid');
  ExportExcludeList.Add('extrasellpriceid');
  ExportExcludeList.Add('uomid');
  (*ispricechanging:=False;
  bUpdatingSellPrice:= False;
  bIsChangingPercent:= False;*)
end;

destructor TProductExtraSellPrice.Destroy;
begin

  inherited;
end;
Function TProductExtraSellPrice.ProductPRICE1 :Double;
begin
  result:=0;
  if Assigned(Owner) then
    if owner is TProduct then
      if TProduct(Owner).Id = ProductId then begin
        REsult := TProduct(Owner).SellQty1Price;
        Exit;
      end;

  if ProductId>0 then
    With TProduct.Create(Self) do try
      connection := Self.connection;
      Load(Self.ProductId);
      REsult := SellQty1Price;
    finally
      Free;
    end;
end;

procedure TProductExtraSellPrice.ReCalcPrice;
begin
  if (Assigned(Owner)) and (Owner is TProduct) then begin
      Price1 := CommonLib.Round((1 - DivZer(QtyPercent1, 100)) * TProduct(Owner).SellQty1Price , tcConst.GeneralRoundPlaces);
      PostDB;
  end;
end;

procedure TProductExtraSellPrice.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if SysUtils.SameText(Sender.fieldName, 'UOM') then begin
    if (self.UOMName <> '') and (self.UOMMultiplier <> 0) then begin
      self.UOMID := TUnitOfMeasure.IdForNameAndMult(UOMName, UOMMultiplier, ProductId);
    end;
  end else if SysUtils.SameText(Sender.fieldName, 'Multiplier') then begin
    if (self.UOMName <> '') and (self.UOMMultiplier <> 0) then begin
      self.UOMID := TUnitOfMeasure.IdForNameAndMult(UOMName, UOMMultiplier, ProductId);
    end;
  end else if SysUtils.SameText(Sender.fieldName, 'UOMID') then begin
    //UOMName := TUnitOfMeasure.IDToggle(UOMID, self.Connection.Connection);
    UOMName := tcdatautils.GetUOMName(UOMID, self.connection.connection);
    UOMMultiplier := TUnitOfMeasure.MultiplierForUnitID(UOMID, self.Connection.Connection);
  end else if SysUtils.SameText(Sender.fieldName, 'Price1') then begin
    if not RawMode then begin
      if ProductPRICE1 =0 then
      else begin
        QtyPercent1 := Round((DivZer(Price1, ProductPRICE1) - 1) * -100, tcConst.GeneralRoundPlaces);
        DoFieldOnChange(dataset.findfield('QtyPercent1'));
      end;
    end;
  end else if SysUtils.SameText(Sender.fieldName, 'QtyPercent1') then begin
    if not RawMode then begin
      ValidatediscountnCalcPrice;
      Price1:= CommonLib.Round((1 - DivZer(QtyPercent1, 100)) * ProductPRICE1, tcConst.GeneralRoundPlaces);
    end;
  end else if SysUtils.SameText(Sender.fieldName, 'PartName') then begin
    if Sender.AsString = '' then begin
      ProductId := 0;
    end else begin
      ProductId := TProduct.IDToggle(Sender.AsString);
      if ProductId = 0 then begin
        ProductID:= -1;
      end;
    end;
  end else if SysUtils.SameText(Sender.fieldName, 'PartsID') then begin

  end;
end;

class function TProductExtraSellPrice.ExtraSellExists(const aTerms :STring;const aExtaSellPriceID, aClientTypeId, aProductId, aUOMId: Integer; aDateFrom, aDateTo: TDateTime; aAllClients: Boolean;
  Conn: TCustomMyConnection): Boolean;
begin
  result:=  TProductExtraSellPrice.ExtraSellID(aTerms,aExtaSellPriceID, aClientTypeId, aProductId, aUOMId,aDateFrom, aDateTo,aAllClients,Conn)<>0;
end;

class function TProductExtraSellPrice.ExtraSellID(const aTerms :STring;const aExtaSellPriceID, aClientTypeId, aProductId, aUOMId: Integer; aDateFrom, aDateTo: TDateTime; aAllClients: Boolean;
  Conn: TCustomMyConnection):Integer;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    if Assigned(Conn) then qry.Connection := Conn
    else qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('Select * from tblExtraPriceSell');
    qry.SQL.Add('where PriceID <> ' + IntToStr(aExtaSellPriceID));
    qry.SQL.Add('and PartsID = ' + IntToStr(aProductId));

    if aAllClients        then qry.SQL.Add('and AllClients = "T"') else qry.SQL.Add('and AllClients = "F"');
    if aClientTypeId > 0  then qry.SQL.Add('and ClientTypeID = ' + IntToStr(aClientTypeId));
    if aUOMId > 0         then qry.SQL.Add('and UOMID = ' + IntToStr(aUOMId));
    if aDateFrom > 0      then qry.SQL.Add('and DateFrom = ' + QuotedStr(FormatDateTime(MysqlDateFormat, aDateFrom))) else qry.SQL.Add('and IsNull(DateFrom)');
    if aDateTo > 0        then qry.SQL.Add('and DateTo = ' + QuotedStr(FormatDateTime(MysqlDateFormat, aDateTo))) else qry.SQL.Add('and IsNull(DateTo)');
    if aTerms <> ''       then qry.SQL.Add('and Terms = ' + QuotedStr(aTerms)) else qry.SQL.Add('and IfNull(Terms,"")=""');
    qry.Open;
    Result := qry.fieldbyname('PriceId').AsInteger;
  finally qry.Free;
  end;
end;
function TProductExtraSellPrice.GetAllClients: Boolean;
begin
  Result := GetBooleanField('AllClients');
end;

function TProductExtraSellPrice.GetClientTypeID: Integer;
begin
  Result := GetIntegerField('ClientTypeID');
end;

function TProductExtraSellPrice.GetDateFrom: TDateTime;
begin
  Result := GeTDateTimeField('DateFrom');
end;

function TProductExtraSellPrice.GetDateTo: TDateTime;
begin
  Result := GeTDateTimeField('DateTo');
end;

function TProductExtraSellPrice.GetExtraSellDescription: string;
begin
  Result := GetStringField('ExtraSellDesc');
end;

function TProductExtraSellPrice.GetExtraSellPriceID: Integer;
begin
  Result := GetIntegerField('PriceId');
end;

function TProductExtraSellPrice.GetId: Integer;
begin
  Result := ExtraSellPriceID;
end;

class function TProductExtraSellPrice.GetIDField: string;
begin
  Result := 'PriceId';
end;

function TProductExtraSellPrice.GetIsList: Boolean;
begin
  Result := true;
end;

class function TProductExtraSellPrice.GetKeyStringProperty: string;
begin
  Result := '';
end;

function TProductExtraSellPrice.getExtraSellPriceOverridesAllDiscounts: Boolean;
begin
  Result := GetBooleanField('ExtraSellPriceOverridesAllDiscounts');
end;

class function TProductExtraSellPrice.GetBusObjectTablename: string;
begin
  Result := 'tblExtraPriceSell';
end;

function TProductExtraSellPrice.GetPrice1: Double;
begin
  Result := GetFloatField('Price1');
end;

(*function TProductExtraSellPrice.ProductCost1: Double;
begin
  result:=0;
  if Assigned(Owner) then
    if owner is TProduct then
      if TProduct(Owner).Id = ProductId then begin
        REsult := TProduct(Owner).BuyQty1Cost;
        Exit;
      end;

  if ProductId>0 then
    With TProduct.Create(Self) do try
      connection := Self.connection;
      Load(Self.ProductId);
      REsult := BuyQty1Cost;
    finally
      Free;
    end;
end;*)

(* function TProductExtraSellPrice.GetPrice2: Double;
  begin
  Result:= GetFloatField('Price2');
  end;

  function TProductExtraSellPrice.GetPrice3: Double;
  begin
  Result:= GetFloatField('Price3');
  end; *)

function TProductExtraSellPrice.GetProductID: Integer;
begin
  Result := GetIntegerField('PartsID');
end;

function TProductExtraSellPrice.GetQtyPercent1: Double;
begin
  Result := GetFloatField('QtyPercent1');
end;
function TProductExtraSellPrice.GetQtyLimitforDiscount: Double;
begin
  Result := GetFloatField('QtyLimitforDiscount');
end;

(* function TProductExtraSellPrice.GetQtyPercent2: Double;
  begin
  Result:= GetFloatField('QtyPercent2');
  end;

  function TProductExtraSellPrice.GetQtyPercent3: Double;
  begin
  Result:= GetFloatField('QtyPercent3');
  end; *)

procedure TProductExtraSellPrice.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;

end;

procedure TProductExtraSellPrice.setAllClients(const Value: Boolean);
begin
  SetBooleanField('AllClients', Value);
end;

procedure TProductExtraSellPrice.setClientTypeID(const Value: Integer);
begin
  SetIntegerField('ClientTypeID', Value);
end;

procedure TProductExtraSellPrice.setDateFrom(const Value: TDateTime);
begin
  SeTDateTimeField('DateFrom', Value);
end;

procedure TProductExtraSellPrice.setDateTo(const Value: TDateTime);
begin
  SeTDateTimeField('DateTo', Value);
end;

procedure TProductExtraSellPrice.setExtraSellDescription(const Value: string);
begin
  SetStringField('ExtraSellDesc', Value);
end;

procedure TProductExtraSellPrice.setExtraSellPriceOverridesAllDiscounts(const Value: Boolean);
begin
  SetBooleanField('ExtraSellPriceOverridesAllDiscounts', Value);
end;

procedure TProductExtraSellPrice.setPrice1(const Value: Double);
begin
  SetFloatField('Price1', Value);
end;

(* procedure TProductExtraSellPrice.SetPrice2(const Value: Double);
  begin
  SetFloatField('Price2', Value);
  end;

  procedure TProductExtraSellPrice.SetPrice3(const Value: Double);
  begin
  SetFloatField('Price3', Value);
  end; *)

procedure TProductExtraSellPrice.SetProductID(const Value: Integer);
begin
  SetIntegerField('PartsID', Value);
end;

procedure TProductExtraSellPrice.setQtyPercent1(const Value: Double);
begin
  SetFloatField('QtyPercent1', Value);
end;
procedure TProductExtraSellPrice.setQtyLimitforDiscount(const Value: Double);
begin
  SetFloatField('QtyLimitforDiscount', Value);
end;

(* procedure TProductExtraSellPrice.SetQtyPercent2(const Value: Double);
  begin
  SetFloatField('QtyPercent2', Value);
  end;

  procedure TProductExtraSellPrice.SetQtyPercent3(const Value: Double);
  begin
  SetFloatField('QtyPercent3', Value);
  end; *)

function TProductExtraSellPrice.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  if IsOwnerProduct(self) then ProductId := TProduct(self.Owner).ID;
  Result := true;
end;

function TProductExtraSellPrice.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforePost(Sender);
  if not result then exit;
  AllClients := ClientTypeID =0;
end;

function TProductExtraSellPrice.ValidateXMLData(const node: IXMLNode): Boolean;
var
  iProductId, iClientType: Integer;
begin
  Result := inherited ValidateXMLData(node);
  if not Result then Exit;
  if not ImportingFromXMLFile then Exit;
  XMLSearchRecordDesc := 'ClientType = ' + GetXMLNodeStringValue(node, 'ClientType') + ' and PartsID = ' + GetXMLProductName(self, node, 'ProductName');
  Result := False;

  iProductId := checkProduct(self, node, 'ProductName');
  if iProductId = 0 then begin
    ErrRecordNotfound('Product Name', GetXMLNodeStringValue(node, 'ProductName'));
    Exit;
  end;

  iClientType := tcDataUtils.GetClientTypeID(GetXMLNodeStringValue(node, 'ClientType'));
  if iClientType = 0 then begin
    ErrRecordNotfound('Client Type', GetXMLNodeStringValue(node, 'ClientType'));
    Exit;
  end;

  Result := true;
  XMLSearchRecord := 'ClientTypeID = ' + IntToStr(iClientType) + ' and PartsID = ' + IntToStr(iProductId);
  LocateXMLRecord;
end;

class function TProductExtraSellPrice._Schema: string;
begin
  Result := inherited;
//  TBOSchema.AddRefType(Result, 'TProductWeb', 'ProductObj', 'ProductID', 'ID');
//  TBOSchema.AddRefType(Result, 'TProductWeb', 'ProductObj', 'ProductName', 'ProductName');
  TBOSchema.AddRefType(Result, 'TClientType', 'ClientTypeObj', 'ClientTypeID', 'ID');
  TBOSchema.AddRefType(Result, 'TClientType', 'ClientTypeObj', 'ClientTypeName', 'TypeName');
  TBOSchema.AddRefType(Result, 'TTerms', 'Termsobj', 'Terms', 'Terms');
  TBOSchema.AddRefType(Result, 'TUnitOfMeasure', 'UOMObj', 'UOMID', 'ID');
  TBOSchema.AddRefType(Result, 'TUnitOfMeasure', 'UOMObj', 'UOMNameProductKey', 'UnitProductKeyName');
end;

procedure TProductExtraSellPrice.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  ProductId := checkProduct(self, node, 'ProductName');
  if not ImportingFromXMLFile then begin
    SetPropertyFromNode(node, 'ClientTypeID');
  end else begin
    ClientTypeID := tcDataUtils.GetClientTypeID(GetXMLNodeStringValue(node, 'ClientType'));
  end;
  SetPropertyFromNode(node, 'Price1');
  SetPropertyFromNode(node, 'QtyPercent1');
  SetPropertyFromNode(node, 'QtyLimitforDiscount');
  (* SetPropertyFromNode(Node,'QtyPercent2');
    SetPropertyFromNode(Node,'QtyPercent3'); *)
  (* SetPropertyFromNode(Node,'Price2');
    SetPropertyFromNode(Node,'Price3'); *)
  SetPropertyFromNode(node, 'ExtraSellDescription');
  SetBooleanPropertyFromNode(node, 'AllClients');
  SetDateTimePropertyFromNode(node, 'DateFrom');
  SetDateTimePropertyFromNode(node, 'DateTo');
  SetPropertyFromNode(node, 'UOMID');
  SetPropertyFromNode(node, 'UOMName');
  SetPropertyFromNode(node, 'UOMMultiplier');
  //SetBooleanPropertyFromNode(node, 'ExtraSellPriceOverridesAllDiscounts');
end;

procedure TProductExtraSellPrice.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  if not SavingXMLTofile then begin
    AddXMLNode(node, 'ProductId', ProductId);
    AddXMLNode(node, 'ClientTypeID', ClientTypeID);
  end else begin
    AddXMLNode(node, 'ClientType', ClientTypeName);
    if not IsOwnerProduct(self) then AddXMLNode(node, 'ProductName', getProduct(ProductId));
  end;
  AddXMLNode(node, 'Terms', Terms);
  AddXMLNode(node, 'ExtraSellDescription', ExtraSellDescription);
  AddXMLNode(node, 'AllClients', AllClients);
  AddXMLNode(node, 'QtyPercent1', QtyPercent1);
  AddXMLNode(node, 'QtyLimitforDiscount', QtyLimitforDiscount);
  (* AddXMLNode(node , 'QtyPercent2', 		 QtyPercent2);
    AddXMLNode(node , 'QtyPercent3', 		 QtyPercent3); *)
  AddXMLNode(node, 'Price1', Price1);
  (* AddXMLNode(node , 'Price2', 			 Price2);
    AddXMLNode(node , 'Price3', 			 Price3); *)
  AddXMLNode(node, 'DateFrom', DateFrom);
  AddXMLNode(node, 'DateTo', DateTo);
  AddXMLNode(node, 'UOMID', UOMID);
  AddXMLNode(node, 'UOMName', UOMName);
  AddXMLNode(node, 'UOMMultiplier', UOMMultiplier);
  //AddXMLNode(node, 'ExtraSellPriceOverridesAllDiscounts', ExtraSellPriceOverridesAllDiscounts);
end;

function TProductExtraSellPrice.ValidateData: Boolean;
begin
  Result := inherited ValidateData;
  if not Result then Exit;

  if ProductId < 1 then begin
    Result := False;
    AddResult(False, rssWarning, 0, 'Product should not be blank');
    Exit;
  end;
  if Assigned(Owner) and (Owner is TProduct) then begin
    if ProductID <> TProduct(Owner).ID then begin
      Result := False;
      AddResult(False, rssWarning, 0, 'Product ID does not match parent Product ID');
      Exit;
    end;
  end;
  if (Terms = '') and  (ClientTypeID = 0) and (UOMID = 0) and (not AllClients) then begin
    Result := False;
    AddResult(False, rssWarning, 0, 'No Client Type ,UOM and Terms, Extra Sell Price requires a Terms, UOM or Client Type or All Clients to be selected');
    Exit;
  end;

  if (UOMName <> '') and (UOMMultiplier <> 0) then begin
    if self.UOMID = 0 then begin
      Result := False;
      AddResult(False, rssWarning, 0, 'Could not find a matching UOM record for the UOM Name (' + UOMName + ') and Multiplier (' + FloatToStr(UOMMultiplier) + ') specified');
      Exit;
    end
    else if DateRangeExists(Terms, ExtraSellPriceID, ClientTypeID, ProductId, UOMID, DateFrom, DateTo, Connection.Connection) then begin
      Result := False;
      AddResult(False, rssWarning, 0, 'The selected date range is ' + 'overlapping the date range of another Extra Sell Price for this product');
      Exit;
    end;
  end;
  if ExtraSellExists(Terms, ID, ClientTypeID, ProductId, UOMID, DateFrom, DateTo, AllClients, Connection.Connection) then begin
    Result := False;
    AddResult(False, rssWarning, 0, 'An Extra Sell Price already exists for this product with these settings');
    Exit;
  end;
  if Assigned(Owner) and (Owner is TProduct) and (TProduct(Owner).ID <> ProductId) then begin
    Result := False;
    AddResult(False, rssWarning, 0, 'Product ID does not match ID of the parent Product');
    Exit;
  end;
end;

procedure TProductExtraSellPrice.ValidatediscountnCalcPrice;
begin
  if QtyPercent1 >100 then begin
      Resultstatus.additem(false, rsswarning,0 , 'Discount cannot be more than 100%');
      QtyPercent1 := 100;
  end;
(*var
  Msg:String;
  fdQtyPercent1 ,fdPrice1:double;
begin
  fdQtyPercent1 := QtyPercent1;
  fdPrice1 := Price1;
  ValidatediscountnCalcPrice(fdQtyPercent1 ,ProductCost1,  ProductPRICE1,fdPrice1 , Msg, ProductId);
  QtyPercent1:= fdQtyPercent1;
  Price1:= fdPrice1;
  PostDB;
  if Msg <> '' then
    REsultstatus.additem(false, rsswarning,0 , Msg);*)
end;

class procedure TProductExtraSellPrice.ValidatediscountnCalcPrice(var Discount:double;(* Productcost:Double; ProductPrice: double; var ESPrice :Double; *)var Msg:String(*;aProductId:Integer*));
begin
   if Discount >100 then begin
      Msg := 'Discount cannot be more than 100%';
      Discount := 100;
   end;
end;

function TProductExtraSellPrice.GetProductName: string;
begin
  if Assigned(Owner) and (Owner is TProduct) then Result := TProduct(Owner).ProductName
  else Result := TProduct.IDToggle(self.ProductId);
end;

procedure TProductExtraSellPrice.SetProductName(const Value: string);
begin
  if Assigned(Owner) and (owner is TProduct) then begin
    if Value <> TProduct(Owner).ProductName then
      ProductId := TProduct.IDToggle(Value, Connection.Connection);
  end
  else
    ProductId := TProduct.IDToggle(Value, Connection.Connection);
end;

class function TProductExtraSellPrice.DateRangeExists(const aTerms :STring;const aExtaSellPriceID, aClientTypeId, aProductId, aUOMId: Integer; aDateFrom, aDateTo: TDateTime; Conn: TCustomMyConnection = nil): Boolean;
var
  qry: TMyQuery;
  s: string;
begin
  Result := False;
  if (aDateFrom = 0) and (aDateTo = 0) then Exit;
  qry := TMyQuery.Create(nil);
  try
    if Assigned(Conn) then qry.Connection := Conn
    else qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('Select * from tblExtraPriceSell');
    qry.SQL.Add('where ifnull(UOMID,0)      = ' + IntToStr(aUOMId));
    qry.SQL.Add('and ifnull(ClienttypeID,0) = ' + IntToStr(aClientTypeId));
    qry.SQL.Add('and ifnull(PartsID,0)      = ' + IntToStr(aProductId));
    qry.SQL.Add('and ifnull(priceID,0)     <> ' + IntToStr(aExtaSellPriceID));
    qry.SQL.Add('and ifnull(Terms,"")     <> ' + Quotedstr(aTerms));
    s := '';
    if aDateFrom > 0 then begin
      s := ' (not IsNull(DateFrom) and not IsNull(DateTo) and DateFrom <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, aDateFrom)) + ' and ' + QuotedStr(FormatDateTime(MysqlDateFormat, aDateFrom)) +
        ' <= DateTo)';
    end;
    if aDateTo > 0 then begin
      if s <> '' then s := s + ' or ';
      s := s + ' (not IsNull(DateFrom) and not IsNull(DateTo) and DateFrom <= ' + QuotedStr(FormatDateTime(MysqlDateFormat, aDateTo)) + ' and ' + QuotedStr(FormatDateTime(MysqlDateFormat, aDateTo)) +
        ' <= DateTo)';
    end;
    if s <> '' then qry.SQL.Add(' and (' + s + ')');
    qry.Open;
    Result := qry.RecordCount > 0;
  finally qry.Free;
  end;
end;

function TProductExtraSellPrice.GetClientTypeName: string;
begin
  Result := TClientType.IDToggle(ClientTypeID);
end;
function TProductExtraSellPrice.GetTerms: string;
begin
  Result := GetStringField('Terms');
end;
procedure TProductExtraSellPrice.SetClientTypeName(const Value: string);
begin
  ClientTypeID := TClientType.IDToggle(Value);
end;
procedure TProductExtraSellPrice.SetTerms(const Value: string);
begin
  SetStringField('Terms' , Value);
end;
function TProductExtraSellPrice.Save: Boolean;
begin
  Result := ValidateData;
  if Result then Result := inherited Save;
end;

{ TProductProcessPart }

function TProductProcessPart.GetProductID: Integer;
begin
  Result := GetIntegerField('PartId');
end;

function TProductProcessPart.GetProcessstepId: Integer;
begin
  Result := GetIntegerField('ProcessstepId');
end;

function TProductProcessPart.GetProcessStepSeq: Integer;
begin
  Result := GetIntegerField('ProcessStepSeq');
end;

procedure TProductProcessPart.SetProductID(const Value: Integer);
begin
  SetIntegerField('PartId', Value);
end;

procedure TProductProcessPart.SetProcessstepId(const Value: Integer);
begin
  SetIntegerField('ProcessstepId', Value);
end;

procedure TProductProcessPart.SetProcessStepSeq(const Value: Integer);
begin
  SetIntegerField('ProcessStepSeq', Value);
end;

function TProductProcessPart.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TProductProcessPart.GetIDField: string;
begin
  Result := 'ID';
end;

function TProductProcessPart.GetIsList: Boolean;
begin
  Result := true;
end;

class function TProductProcessPart.GetKeyStringProperty: string;
begin
  Result := '';
end;

class function TProductProcessPart.GetBusObjectTablename: string;
begin
  Result := 'tblProcessPart';
end;

procedure TProductProcessPart.DoFieldOnChange(Sender: TField);
begin

end;

function TProductProcessPart.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  if IsOwnerProduct(self) then ProductId := TProduct(self.Owner).ID;
  Result := true;
end;

function TProductProcessPart.ValidateXMLData(const node: IXMLNode): Boolean;
var
  iProductId, IprocessStepId: Integer;
begin
  Result := inherited ValidateXMLData(node);
  if not Result then Exit;
  if not ImportingFromXMLFile then Exit;
  XMLSearchRecordDesc := 'Product = ' + GetXMLProductName(self, node, 'ProductName') + ' and ProcessStep = ' + GetXMLNodeStringValue(node, 'ProcessStep') + ' and ProcessStepSeq = ' +
    IntToStr(getXMLNodeIntegerValue(node, 'ProcessStepSequence'));
  Result := False;

  iProductId := checkProduct(self, node, 'ProductName');
  if iProductId = 0 then begin
    ErrRecordNotfound('ProductName', GetXMLNodeStringValue(node, 'ProductName'));
    Exit;
  end;
  IprocessStepId := getProcessStep(GetXMLNodeStringValue(node, 'ProcessStep'));
  if IprocessStepId = 0 then begin
    ErrRecordNotfound('ProcessStep', GetXMLNodeStringValue(node, 'ProcessStep'));
    Exit;
  end;
  if getXMLNodeIntegerValue(node, 'ProcessStepSequence') = 0 then begin
    ErrRecordNotfound('Process Step Sequence', GetXMLNodeStringValue(node, 'ProcessStepSequence'));
    Exit;
  end;
  XMLSearchRecord := 'PartId = ' + IntToStr(iProductId) + ' and ProcessStepID = ' + IntToStr(IprocessStepId) + ' and ProcessStepSeq = ' + IntToStr(getXMLNodeIntegerValue(node, 'ProcessStepSequence'));
  Result := true;

  LocateXMLRecord;
end;

class function TProductProcessPart._Schema: string;
begin
  Result := inherited;
  TBOSchema.AddRefType(Result, 'TProcessStep', 'ProcessStepObj', 'ProcessStepID', 'ID');
  TBOSchema.AddRefType(Result, 'TProcessStep', 'ProcessStepObj', 'ProcessStepName', 'Description');
end;

procedure TProductProcessPart.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  ProductId := checkProduct(self, node, 'ProductName');
  if not ImportingFromXMLFile then begin
    SetPropertyFromNode(node, 'ProcessStepID');
  end else begin
    ProcessStepId := tcDataUtils.getProcessStep(GetXMLNodeStringValue(node, 'ProcessStep'));
  end;
  SetPropertyFromNode(node, 'ProcessStepSeq');

end;

procedure TProductProcessPart.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  if not SavingXMLTofile then begin
    AddXMLNode(node, 'PartId', ProductId);
    AddXMLNode(node, 'ProcessStepID', ProcessStepId);
  end else begin
    if not IsOwnerProduct(self) then AddXMLNode(node, 'ProductName', tcDataUtils.getProduct(ProductId));
    AddXMLNode(node, 'ProcessStep', getProcessStep(ProcessStepId));
  end;
  AddXMLNode(node, 'ProcessStepSeq', ProcessStepSeq);
end;

function TProductProcessPart.GetProductName: string;
begin
  Result := TProduct.IDToggle(ProductId, Connection.Connection);
end;

procedure TProductProcessPart.SetProductName(const Value: string);
begin
  ProductId := TProduct.IDToggle(Value, Connection.Connection);
end;

function TProductProcessPart.GetProcessStepName: string;
begin
  Result := TProcessStep.IDToggle(ProcessStepId, Connection.Connection);
end;

procedure TProductProcessPart.SetProcessStepName(const Value: string);
begin
  ProcessStepId := TProcessStep.IDToggle(Value, Connection.Connection);
end;

function TProductProcessPart.ValidateData: Boolean;
begin
  Result := inherited ValidateData;
  if not Result then Exit;

  if ProductId < 1 then begin
    Result := False;
    AddResult(False, rssWarning, 0, 'Product should not be blank');
    Exit;
  end;
  if ProcessStepId < 1 then begin
    Result := False;
    AddResult(False, rssWarning, 0, 'Process Step is missing');
    Exit;
  end;

  Result := true;
end;

function TProductProcessPart.Save: Boolean;
begin
  Result := ValidateData;
  if Result then Result := inherited Save;
end;

{ Tpartsclasspreferences }

(*constructor Tpartsclasspreferences.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'Select * from tblpartsclasspreferences';
  self.ExportExcludeList.Add('deptid');
end;

function Tpartsclasspreferences.GetClassID: Integer;
begin
  Result := GetIntegerField('classID');
end;

function Tpartsclasspreferences.getClassName: string;
begin
  Result := GetStringField('ClassName');
end;

procedure Tpartsclasspreferences.setClassID(const Value: Integer);
begin
  SetIntegerField('ClassId', Value);
end;

procedure Tpartsclasspreferences.SetclassName(const Value: string);
begin
  SetStringField('ClassNAme', Value);
end;

class function Tpartsclasspreferences.GetIDField: string;
begin
  Result := 'ID';
end;

procedure TPartsClassPreferences.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if SysUtils.SameText(Sender.fieldName, 'DeptId') then begin
    DeptName:= TDeptClass.IDToggle(DeptID,Connection.Connection);
  end
  else if SysUtils.SameText(Sender.fieldName, 'DeptName') then begin
    DeptId:= TDeptClass.IDToggle(DeptName,Connection.Connection);
  end;
end;

class function Tpartsclasspreferences.GetBusObjectTablename: string;
begin
  Result := 'tblpartsclasspreferences';
end;

function Tpartsclasspreferences.GetSQL: string;
begin

  Result := inherited GetSQL;
end;

procedure Tpartsclasspreferences.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'DeptName');
  SetPropertyFromNode(node, 'DeptId');
end;

procedure Tpartsclasspreferences.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;

  AddXMLNode(node, 'DeptId', DeptId);
  AddXMLNode(node, 'DeptName', DeptName);
end;

function Tpartsclasspreferences.ValidateXMLData(const node: IXMLNode): Boolean;
begin
  Result := true;
end;

class function TPartsClassPreferences._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(Result, 'TDeptClass', 'DeptClassObj', 'DeptID', 'ID');
  TBOSchema.AddRefType(Result, 'TDeptClass', 'DeptClassObj', 'DeptName', 'DeptClassName');
end;*)

constructor TProductProcessPart.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ExportExcludeList.Add('productid');
  ExportExcludeList.Add('processstepid');
  fSQL := 'Select * from tblProcessPart where IfNull(PartID,0) <> 0';
end;





function TProductExtraBuyPrice.GetUOMID: Integer;
begin
  Result := GetIntegerField('UOMID');
end;

function TProductExtraBuyPrice.GetUOMMultiplier: Double;
begin
  Result := GetFloatField('UOMMultiplier');
end;

function TProductExtraBuyPrice.GetUOMName: string;
begin
  Result := GetStringField('UOM');
end;

function TProductExtraBuyPrice.GetUOMNameProductKey: string;
begin
  Result := TUnitOfMeasure.IDToggle(UOMID, Connection.Connection);
end;

procedure TProductExtraBuyPrice.SetUOMID(const Value: Integer);
begin
  SetIntegerField('UOMID', Value);
end;

procedure TProductExtraBuyPrice.SetUOMMultiplier(const Value: Double);
begin
  SetFloatField('UOMMultiplier', Value)
end;

procedure TProductExtraBuyPrice.SetUOMName(const Value: string);
begin
  SetStringField('UOM', Value);
end;

procedure TProductExtraBuyPrice.SetUOMNameProductKey(const Value: string);
begin
  UOMID := TUnitOfMeasure.IDToggle(Value, Connection.Connection);
end;

function TProductExtraSellPrice.GetUOMID: Integer;
begin
  Result := GetIntegerField('UOMID');
end;

function TProductExtraSellPrice.GetUOMMultiplier: Double;
begin
  Result := GetFloatField('UOMMultiplier');
end;

function TProductExtraSellPrice.GetUOMName: string;
begin
  Result := GetStringField('UOM');
end;

function TProductExtraSellPrice.GetUOMNameProductKey: string;
begin
  Result := TUnitOfMeasure.IDToggle(UOMID, Connection.Connection);
end;

procedure TProductExtraSellPrice.SetUOMID(const Value: Integer);
begin
  SetIntegerField('UOMID', Value);
end;

procedure TProductExtraSellPrice.SetUOMMultiplier(const Value: Double);
begin
  SetFloatField('UOMMultiplier', Value)
end;

procedure TProductExtraSellPrice.SetUOMName(const Value: string);
begin
  SetStringField('UOM', Value);
end;

procedure TProductExtraSellPrice.SetUOMNameProductKey(const Value: string);
begin
  UOMID := TUnitOfMeasure.IDToggle(Value, Connection.Connection);
end;

procedure TProductExtraSellPrice.UpdatePrices;
var
  bm: TBookmark;
  SaveDoFieldChange: boolean;
begin
  if (Count > 0) and Assigned(Owner) and (Owner is TProduct) then begin
    bm := Dataset.GetBookmark;
    try
      Dataset.First;
      while not Dataset.Eof do begin
        if TProduct(Owner).LockExtraSell then begin
          if QtyPercent1 <> 0 then begin
            if (TProduct(Owner).SellQty1Price <> 0) then begin
              SaveDoFieldChange := self.DoFieldChange;
              try
                self.DoFieldChange := false;
                Self.QtyPercent1 := Round(DivZer((TProduct(Owner).SellQty1Price - Price1), TProduct(Owner).SellQty1Price), 2) * 100;
                PostDb;
              finally
                self.DoFieldChange := SaveDoFieldChange;
              end;
            end;
          end;
        end
        else begin
          Price1 := Round((1 - DivZer(QtyPercent1, 100)) * TProduct(Owner).SellQty1Price, GeneralRoundPlaces);
          PostDB;
        end;
        Dataset.Next;
      end;
      Dataset.GotoBookmark(bm);
    finally Dataset.FreeBookmark(bm);
    end;
  end;
end;

{ TProductType }

constructor TProductType.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

end;

class function TProductType.GetBusObjectTablename: string;
begin
  Result := 'tblPartTypes'
end;

class function TProductType.GetIDField: string;
begin
  Result := 'ID';
end;

function TProductType.GetTypeCode: string;
begin
  Result := GetStringField('TypeCode');
end;

function TProductType.GetTypeDescription: string;
begin
  Result := GetStringField('TypeDesc');
end;

class function TProductType.IsValidTypeCode(const aTypeCode: string): Boolean;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text := 'Select * from tblPartTypes where TypeCode = ' + QuotedStr(aTypeCode);
    qry.Open;
    Result := qry.RecordCount = 1;
  finally qry.Free;
  end;
end;

procedure TProductType.SetTypeCode(const Value: string);
begin
  SetStringField('TypeCode', Value)
end;

procedure TProductType.SetTypeDescription(const Value: string);
begin
  SetStringField('TypeDesc', Value);
end;

{ TProductForeignSellPrice }

constructor TProductForeignSellPrice.Create(AOwner: TComponent);
begin
  inherited;
  ExportExcludeList.Add('issellprice');
end;

function TProductForeignSellPrice.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  IsSellPrice := true;
  Result := inherited DoAfterInsert(Sender);
end;

class function TProductForeignSellPrice._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(Result, 'TCustomer', 'CustomerObj', 'ClientID', 'ID');
  TBOSchema.AddRefType(Result, 'TCustomer', 'CustomerObj', 'ClientName', 'ClientName');
end;

{ TProductForeignBuyPrice }

constructor TProductForeignBuyPrice.Create(AOwner: TComponent);
begin
  inherited;
  ExportExcludeList.Add('issellprice');
end;

function TProductForeignBuyPrice.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  IsSellPrice := False;
  Result := inherited DoAfterInsert(Sender);
end;

class function TProductForeignBuyPrice._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(Result, 'TSupplier', 'SupplierObj', 'ClientID', 'ID');
  TBOSchema.AddRefType(Result, 'TSupplier', 'SupplierObj', 'ClientName', 'ClientName');
end;

{ TAlternateProduct }

constructor TAlternateProduct.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'AlternateProduct';
  fSQL := 'SELECT * FROM tblpartsalternate';
  ExportExcludeList.Add('productid');
  ExportExcludeList.Add('alternateproductid');
end;

destructor TAlternateProduct.Destroy;
begin
  inherited;
end;

procedure TAlternateProduct.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'ProductID');
  SetPropertyFromNode(node, 'ProductName');
  SetPropertyFromNode(node, 'AlternateProductID');
  SetPropertyFromNode(node, 'AlternateProductName');
  SetPropertyFromNode(node, 'AlternateProductPrintName');
  SetBooleanPropertyFromNode(node, 'IsDefault');
end;

procedure TAlternateProduct.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'ProductID', ProductId);
  AddXMLNode(node, 'ProductName', ProductName);
  AddXMLNode(node, 'AlternateProductID', AlternateProductID);
  AddXMLNode(node, 'AlternateProductName', AlternateProductName);
  AddXMLNode(node, 'AlternateProductPrintName', AlternateProductPrintName);
  AddXMLNode(node, 'IsDefault', IsDefault);
end;

function TAlternateProduct.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if ProductName = '' then begin
    Resultstatus.AddItem(False, rssError, 0, 'Product Name should not be Blank', False);
    Exit;
  end;
  if ProductId = 0 then begin
    if ProductName <> '' then Resultstatus.AddItem(False, rssError, 0, 'Product ID not found for product "' + ProductName + '"', False)
    else Resultstatus.AddItem(False, rssError, 0, 'Product ID should not be Blank', False);
    Exit;
  end;
  if AlternateProductName = '' then begin
    Resultstatus.AddItem(False, rssError, 0, 'Alternate Product Name should not be Blank', False);
    Exit;
  end;
  if AlternateProductID = 0 then begin
    if ProductName <> '' then Resultstatus.AddItem(False, rssError, 0, 'Alternate Product ID not found for product "' + AlternateProductName + '"', False)
    else Resultstatus.AddItem(False, rssError, 0, 'Alternate Product ID should not be Blank', False);
    Exit;
  end;
  Result := true;
end;

class function TAlternateProduct._Schema: string;
begin
  Result := inherited;
//  TBOSchema.AddRefType(Result, 'TProductWeb', 'AlternateProductObj', 'AlternateProductID', 'ID');
//  TBOSchema.AddRefType(Result, 'TProductWeb', 'AlternateProductObj', 'AlternateProductName', 'ProductName');
end;

function TAlternateProduct.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TAlternateProduct.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TAlternateProduct.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if SysUtils.SameText(Sender.fieldName, 'ProductName') then begin
    ProductId := TProduct.IDToggle(Sender.AsString, Connection.Connection);
  end
  else if SysUtils.SameText(Sender.fieldName, 'ProductID') then begin
    ProductName := TProduct.IDToggle(Sender.AsInteger, Connection.Connection);
  end
  else if SysUtils.SameText(Sender.fieldName, 'AlternateProductName') then begin
    AlternateProductID := TProduct.IDToggle(Sender.AsString, Connection.Connection);
  end
  else if SysUtils.SameText(Sender.fieldName, 'AlternateProductID') then begin
    AlternateProductName := TProduct.IDToggle(Sender.AsInteger, Connection.Connection);
  end;
end;

function TAlternateProduct.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TAlternateProduct.GetIDField: string;
begin
  Result := 'ID'
end;

class function TAlternateProduct.GetBusObjectTablename: string;
begin
  Result := 'tblpartsalternate';
end;

function TAlternateProduct.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TAlternateProduct.GetProductID: Integer;
begin
  Result := GetIntegerField('ProductID');
end;

function TAlternateProduct.GetProductName: string;
begin
  Result := GetStringField('ProductName');
end;

function TAlternateProduct.GetAlternateProductID: Integer;
begin
  Result := GetIntegerField('AlternateProductID');
end;

function TAlternateProduct.GetAlternateProductName: string;
begin
  Result := GetStringField('AlternateProductName');
end;
function TAlternateProduct.GetAlternateProductPrintName: string;
begin
  Result := GetStringField('AlternateProductPrintName');
end;

function TAlternateProduct.GetIsDefault: Boolean;
begin
  Result := GetBooleanField('IsDefault');
end;

function TAlternateProduct.GetIsList: Boolean;
begin
  Result := true;
end;

class function TAlternateProduct.GetKeyStringProperty: string;
begin
  Result := '';
end;

procedure TAlternateProduct.SetProductID(const Value: Integer);
begin
  SetIntegerField('ProductID', Value);
end;

procedure TAlternateProduct.SetProductName(const Value: string);
begin
  SetStringField('ProductName', Value);
end;

procedure TAlternateProduct.SetAlternateProductID(const Value: Integer);
begin
  SetIntegerField('AlternateProductID', Value);
end;

procedure TAlternateProduct.SetAlternateProductName(const Value: string);
begin
  SetStringField('AlternateProductName', Value);
end;
procedure TAlternateProduct.SetAlternateProductPrintName(const Value: string);
begin
  SetStringField('AlternateProductPrintName', Value);
end;

procedure TAlternateProduct.SetIsDefault(const Value: Boolean);
begin
  SetBooleanField('IsDefault', Value);
end;

//{ TDeletedPartsClassPreferences }
//
//class function TDeletedPartsClassPreferences.GetDeletedTablename: string;
//begin
//  result := 'tblpartsclasspreferences';
//end;

initialization

RegisterClass(TAlternateProduct);
RegisterClassOnce(TForeignPrice);
///RegisterClassOnce(Tpartsclasspreferences);
RegisterClassOnce(TProductExtraBuyPrice);
BusObjectListObj.TBusObjInfoList.Inst.Add('Product Extra Buy', 'TProductExtraBuyPrice', 'TProductExtrabuyPricesGUI');
RegisterClassOnce(TProductExtraSellPrice);
BusObjectListObj.TBusObjInfoList.Inst.Add('Product Extra Sell', 'TProductExtraSellPrice', 'TProductExtraSellPriceGUI');
//RegisterClassOnce(TProductProcessPart);
//BusObjectListObj.TBusObjInfoList.Inst.Add('Product Process', 'TProductProcessPart', 'TProductProcessListGUI');
RegisterClassOnce(TProductSpecs);
BusObjectListObj.TBusObjInfoList.Inst.Add('Product Specification', 'TProductSpecs', 'TProductSpecificationListGUI');
RegisterClassOnce(TProductType);
RegisterClassOnce(TProductForeignSellPrice);
BusObjectListObj.TBusObjInfoList.Inst.Add('Product Foreign Sell', 'TProductForeignSellPrice', 'TproductForeignSellPriceGUI');
RegisterClassOnce(TProductForeignBuyPrice);
BusObjectListObj.TBusObjInfoList.Inst.Add('Product Foreign Buy', 'TProductForeignBuyPrice', 'TProductforeignBuyPriceGUI');
BusObjectListObj.TBusObjInfoList.Inst.Add('Product Alternate', 'TAlternateProduct', 'TAlternateProductListGUI');
//RegisterClass(TDeletedPartsClassPreferences);

end.
