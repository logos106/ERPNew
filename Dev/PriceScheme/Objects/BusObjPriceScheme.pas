unit BusObjPriceScheme;

interface

uses
  Classes, BusObjBase,  DB, MyAccess,ERPdbComponents, XMLDoc, XMLIntf;

type

  TPriceListItem = class;
  TPriceList = class(TMSBusobj)
  private
    function GetActive: boolean;
    function GetItems: TPriceListItem;
    function GetListName: string;
    function GetListNumber: string;
    function GetPriceListId: integer;
    procedure SetActive(const Value: boolean);
    procedure SetListName(const Value: string);
    procedure SetListNumber(const Value: string);
  protected
    function GetId: integer; override;
    procedure DoFieldOnChange(Sender: TField); override;
    procedure InitializeNewObject; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    class function GetKeyStringField: string; override;
    procedure SaveToXMLNode(const node: IXMLNode);  override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    function ValidateData: boolean; override;
    property Items: TPriceListItem read GetItems;
    class function IdNameSwitch(const Value: integer; const Connection: TERPConnection = nil): string; overload;
    class function IdNameSwitch(const Value: string; const Connection: TERPConnection = nil): integer; overload;
    function ProductPrice(const aProductId: integer; var aListPrice: double): boolean;
  published
             { primary key field }
    property PriceListId: integer read GetPriceListId;
    property ListNumber: string read GetListNumber write SetListNumber;
    property ListName: string read GetListName write SetListName;
    property Active: boolean read GetActive write SetActive;
  end;

  TPriceListItem = class(TMSBusobj)
  private
    function GetPriceListId: integer;
    function GetPriceListItemId: integer;
    function GetPriceListNumber: string;
    function GetProductID: integer;
    function GetProductName: string;
    procedure SetPriceListId(const Value: integer);
    procedure SetPriceListNumber(const Value: string);
    procedure SetProductID(const Value: integer);
    procedure SetProductName(const Value: string);
    function GetCost: double;
    function GetListPrice: double;
    function GetSellPrice: double;
    procedure SetCost(const Value: double);
    procedure SetSellPrice(const Value: double);
    procedure SetListPrice(const Value: double);
    procedure PopulateProductInfo(const aProductId: integer; const aProductName: string);
  protected
    function GetId: integer; override;
    procedure InitializeNewObject; override;
    procedure DoFieldOnChange(Sender: TField); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    class function GetKeyStringField: string; override;
    procedure SaveToXMLNode(const node: IXMLNode);  override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    function ValidateData: boolean; override;
  published
             { primary key field }
    property PriceListItemId: integer read GetPriceListItemId;
             { linked price list }
    property PriceListId: integer read GetPriceListId write SetPriceListId;
    property PriceListNumber: string read GetPriceListNumber write SetPriceListNumber;
             { product to include in price list }
    property ProductId: integer read GetProductID write SetProductID;
    property ProductName: string read GetProductName write SetProductName;
    property Cost: double read GetCost write SetCost;
    property SellPrice: double read GetSellPrice write SetSellPrice;
    property ListPrice: double read GetListPrice write SetListPrice;
  end;

  TPriceSchemeType = (pstPriceList,   // Get price from list
                      pstQtyFree,     // Buy qty x and get qty y free
                      pstDiscount,    // Buy qty x and get discount y
                      pstQtyDiscount, // Buy qty x and get one discounted by y
                      pstPrice,       // Buy qty x for total price y
                      pstCredit,      // buy qty x or value x and get credit y to other scheme
                      pstCombo);      // buy combination of products/qty for price x
  TPriceSchemeTypeName = array[Low(TPriceSchemeType)..High(TPriceSchemeType)] of string;

  TPriceSchemeTypeSet = set of TPriceSchemeType;


  TSchemePriceListItem = class;
  TPriceScheme = class(TMSBusobj)
  private
    function GetActive: boolean;
    function GetCredit: double;
    function GetDateFrom: TDateTime;
    function GetDateTo: TDateTime;
    function GetDiscountOrQtyFree: double;
    function GetPriceListItems: TSchemePriceListItem;
    function GetPriceSchemeId: integer;
    function GetRelatedSchemeId: integer;
    function GetRelatedSchemeNumber: string;
    function GetSchemeName: string;
    function GetSchemeNumber: string;
    function GetSchemeType: TPriceSchemeType;
    function GetSchemeTypeName: string;
    function GetThreshold: double;
    procedure SetActive(const Value: boolean);
    procedure SetCredit(const Value: double);
    procedure SetDateFrom(const Value: TDateTime);
    procedure SetDateTo(const Value: TDateTime);
    procedure SetDiscountOrQtyFree(const Value: double);
    procedure SetRelatedSchemeId(const Value: integer);
    procedure SetRelatedSchemeNumber(const Value: string);
    procedure SetSchemeName(const Value: string);
    procedure SetSchemeNumber(const Value: string);
    procedure SetSchemeType(const Value: TPriceSchemeType);
    procedure SetSchemeTypeName(const Value: string);
    procedure SetThreshold(const Value: double);
    function GetPrice: double;
    procedure SetPrice(const Value: double);
    function GetSchemeTypeDescription: string;
  protected
    function GetId: integer; override;
    function SchemeTypeToUserStr(const Value: TPriceSchemeType): string;
    function StrToSchemeType(const Value: string): TPriceSchemeType;
    procedure DoFieldOnChange(Sender: TField); override;
    { do a load select of scheems that contain aProductId with
      aQty > QuantityThreshold and are valid for aDate }
    function LoadSchemesForProduct(aProductId: integer; aQty: double; aDate: TDateTime): boolean;
    procedure InitializeNewObject; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    class function GetKeyStringField: string; override;
    class function PriceForSchemeId(const aPriceSchemeId: integer): double;
    procedure SaveToXMLNode(const node: IXMLNode);  override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    function ValidateData: boolean; override;
    property PriceListItems: TSchemePriceListItem read GetPriceListItems;
    function ValidatePriceListItems: boolean;
    function LoadSchemesForDate(aDate: TDateTime): boolean;
    class function SchemeTypeToStr(const aSchemeType: TPriceSchemeType): string;
    function SchemeNumberExists: boolean;
    property SchemeTypeDescription: string read GetSchemeTypeDescription;
  published
             { primary key field }
    property PriceSchemeId: integer read GetPriceSchemeId;
             { number and name for user to identify scheme by }
    property SchemeNumber: string read GetSchemeNumber write SetSchemeNumber;
    property SchemeName: string read GetSchemeName write SetSchemeName;
             { optional price }
    property Price: double read GetPrice write SetPrice;
             { unused schemes should be made inactive rather than deleting }
    property Active: boolean read GetActive write SetActive;
             { scheme type determins how a sceme calculates prices }
    property SchemeType: TPriceSchemeType read GetSchemeType write SetSchemeType;
             { user friendly scheme type name }
    property SchemeTypeName: string read GetSchemeTypeName write SetSchemeTypeName;
             { date range for which this scheme is active }
    property DateFrom: TDateTime read GetDateFrom write SetDateFrom;
    property DateTo: TDateTime read GetDateTo write SetDateTo;
             { quantity discount threshold }
    property Threshold: double read GetThreshold write SetThreshold;
             { optional credit to be applied to related scheme }
    property Credit: double read GetCredit write SetCredit;
    property RelatedSchemeId: integer read GetRelatedSchemeId write SetRelatedSchemeId;
    property RelatedSchemeNumber: string read GetRelatedSchemeNumber write SetRelatedSchemeNumber;
             { Discount or quantity free }
    property DiscountOrQtyFree: double read GetDiscountOrQtyFree write SetDiscountOrQtyFree;
  end;

  TSchemePriceListItem = class(TMSBusobj)
  private
    function GetPriceListId: integer;
    function GetPriceListNumber: string;
    function GetPriceSchemeId: integer;
    function GetPriceSchemeNumber: string;
    function GetSchemePriceListItemId: integer;
    procedure SetPriceListNumber(const Value: string);
    procedure SetPriceSchemeId(const Value: integer);
    procedure SetPriceSchemeNumber(const Value: string);
    procedure SetPriceListId(const Value: integer);
    function GetPriceListName: string;
    procedure SetPriceListName(const Value: string);
    function GetPriceList: TPriceList;
    function GetQuantityThreshold: double;
    procedure SetQuantityThreshold(const Value: double);
  protected
    function GetId: integer; override;
    procedure DoFieldOnChange(Sender: TField); override;
    procedure InitializeNewObject; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    class function GetKeyStringField: string; override;
    procedure SaveToXMLNode(const node: IXMLNode);  override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    function ValidateData: boolean; override;
    property PriceList: TPriceList read GetPriceList;
  published
             { primary key field }
    property SchemePriceListItemId: integer read GetSchemePriceListItemId;
             { the PriceScheme this item belongs to }
    property PriceSchemeId: integer read GetPriceSchemeId write SetPriceSchemeId;
    property PriceSchemeNumber: string read GetPriceSchemeNumber write SetPriceSchemeNumber;
             { Linked Price List }
    property PriceListId: integer read GetPriceListId write SetPriceListId;
    property PriceListNumber: string read GetPriceListNumber write SetPriceListNumber;
    property PriceListName: string read GetPriceListName write SetPriceListName;
             { the quantity of items from linked price list }
    property QuantityThreshold: double read GetQuantityThreshold write SetQuantityThreshold;
  end;

const
  PriceSchemeTypeName: TPriceSchemeTypeName = (
    'Price List',
    'Buy Qty for free Qty',
    'Buy Qty for Discount',
    'Buy Qty for Discount on One',
    'Buy Qty for Price',
    'Buy For Credit',
    'Buy Combination for Price');

  PriceSchemeTypeDesc: TPriceSchemeTypeName = (
    'Use price directly from specified Price List.',
    'Buy Price List Threshold Quantity to receive Qty Free.',
    'Buy Price List Threshold Quantity to receive Discount on total of Threshold Quantity.',
    'Buy Price List Threshold Quantity to receive Discount on one item.',
    'Buy Price List Threshold Quantity for fixed specified Price.',
    'Buy Price List Threshold Quantity to receive Credit amount when Related Scheme included in sale.',
    'Buy Combination of products from specified Price Lists and Thresholds for specified fixed Price.');

implementation

uses
  BusObjStock, FastFuncs, SysUtils, CommonLib, CommonDbLib, MySQLConst;

{ TPriceList }

constructor TPriceList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL:= 'SELECT * FROM tblPriceList';
end;

destructor TPriceList.Destroy;
begin

  inherited;
end;

procedure TPriceList.DoFieldOnChange(Sender: TField);
begin
  inherited;
  InitializeNewObject
end;

function TPriceList.GetActive: boolean;
begin
  result:= GetBooleanField('Active');
end;

class function TPriceList.GetBusObjectTablename: string;
begin
  result:= 'tblPriceList';
end;

function TPriceList.GetId: integer;
begin
  result:= PriceListId;
end;

class function TPriceList.GetIDField: string;
begin
  result:= 'PriceListID';
end;

function TPriceList.GetItems: TPriceListItem;
begin
  result:= TPriceListItem(Container.ItemByClass(TPriceListItem, false));
  if not Assigned(result) then begin
    result:= TPriceListItem.Create(nil);
    Container.Add(result);
    result.Connection:= self.Connection;
    result.LoadSelect('PriceListID = ' + IntToStr(ID));
  end;
end;

class function TPriceList.GetKeyStringField: string;
begin
  result:= 'ListNumber';
end;

function TPriceList.GetListName: string;
begin
  result:= GetStringField('ListName');
end;

function TPriceList.GetListNumber: string;
begin
  result:= GetStringField('ListNumber');
end;

function TPriceList.GetPriceListId: integer;
begin
  result:= GetIntegerField('PriceListId');
end;

class function TPriceList.IdNameSwitch(const Value: integer; const Connection: TERPConnection = nil): string;
var
  lQuery: TERPQuery;
begin
  Result := '';
  if Value = 0 then
    Exit;
  lQuery := TERPQuery.Create(nil);
  try
    lQuery.Options.FlatBuffers := True;
    if Assigned(Connection) then
      lQuery.Connection := Connection
    else
      lQuery.Connection := CommonDBLib.GetSharedMyDacConnection;
    lQuery.SQL.Text := Format('SELECT %s FROM %s WHERE %s = %d', ['ListName', GetBusObjectTablename, GetIDField, Value]);
    lQuery.Open;
    if not lQuery.Eof then
      Result := lQuery.FieldByName('ListName').AsString;
  finally
    lQuery.Free;
  end;
end;

class function TPriceList.IdNameSwitch(const Value: string; const Connection: TERPConnection = nil): integer;
var
  lQuery: TERPQuery;
begin
  Result := 0;
  if Value = '' then
    Exit;
  lQuery := TERPQuery.Create(nil);
  try
    lQuery.Options.FlatBuffers := True;
    if Assigned(Connection) then
      lQuery.Connection := Connection
    else
      lQuery.Connection := CommonDBLib.GetSharedMyDacConnection;
    lQuery.SQL.Text := Format('SELECT %s FROM %s WHERE %s = %s', [GetIDField, GetBusObjectTablename, 'ListName', QuotedStr(Value)]);
    lQuery.Open;
    if not lQuery.Eof then
      Result := lQuery.FieldByName(GetIDField).AsInteger;
  finally
    lQuery.Free;
  end;
end;

procedure TPriceList.InitializeNewObject;
begin
  inherited;
  if self.Id < 1 then
    self.PostDb;
end;

procedure TPriceList.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

end;

function TPriceList.ProductPrice(const aProductId: integer;
  var aListPrice: double): boolean;
begin
  result:= Items.Dataset.Locate('ProductID',aProductId,[]);
  if result then
    aListPrice:= Items.ListPrice
  else
    aListPrice:= 0;
end;

procedure TPriceList.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure TPriceList.SetActive(const Value: boolean);
begin
  SetBooleanField('Active', Active);
end;

procedure TPriceList.SetListName(const Value: string);
begin
  SetStringField('ListName',Value);
end;

procedure TPriceList.SetListNumber(const Value: string);
begin
  SetStringField('ListNumber',Value);
end;

function TPriceList.ValidateData: boolean;
begin
  ResultStatus.Clear;
  result:= inherited ValidateData;
  if not result then exit;
  if ListName = '' then begin
    ResultStatus.AddItem(false,rssInfo,0,'No name specified for this price list');
  end
  else if ListNumber = '' then begin
    ResultStatus.AddItem(false,rssInfo,0,'No number specified for this price list');
  end
  else if Items.Count < 1 then begin
    ResultStatus.AddItem(false,rssInfo,0,'No products specified for this price list');
  end;

  result:= ResultStatus.OperationOk;
end;

{ TPriceListItem }

constructor TPriceListItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL:= 'SELECT * FROM tblPriceListItem';
end;

destructor TPriceListItem.Destroy;
begin

  inherited;
end;

procedure TPriceListItem.DoFieldOnChange(Sender: TField);
begin
  inherited;
  InitializeNewObject;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName ,'ProductName') then begin
    PopulateProductInfo(0,Sender.AsString);
  end
  else if Sysutils.SameText(Sender.FieldName ,'ProductID') then begin
    PopulateProductInfo(Sender.AsInteger,'');
  end;
end;

class function TPriceListItem.GetBusObjectTablename: string;
begin
  result:= 'tblPriceListItem';
end;

function TPriceListItem.GetCost: double;
begin
  result:= GetFloatField('Cost');
end;

function TPriceListItem.GetId: integer;
begin
  result:= PriceListItemId;
end;

class function TPriceListItem.GetIDField: string;
begin
  result:= 'PriceListItemId';
end;

class function TPriceListItem.GetKeyStringField: string;
begin
  result:= '';
end;

function TPriceListItem.GetListPrice: double;
begin
  result:= GetFloatField('ListPrice');
end;

function TPriceListItem.GetPriceListId: integer;
begin
  result:= GetIntegerField('PriceListId');
end;

function TPriceListItem.GetPriceListItemId: integer;
begin
  result:= GetIntegerField('PriceListItemId');
end;

function TPriceListItem.GetPriceListNumber: string;
begin
  result:= GetStringField('PriceListnumber');
end;

function TPriceListItem.GetProductID: integer;
begin
  result:= GetIntegerField('ProductId');
end;

function TPriceListItem.GetProductName: string;
begin
  result:= GetStringField('ProductName');
end;

function TPriceListItem.GetSellPrice: double;
begin
  result:= GetFloatField('SellPrice');
end;

procedure TPriceListItem.InitializeNewObject;
begin
  inherited;
  if (PriceListId < 1) and Assigned(Owner) and (Owner is TPriceList) then
    self.PriceListId:= TPriceList(Owner).Id;
end;

procedure TPriceListItem.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure TPriceListItem.PopulateProductInfo(const aProductId: integer; const aProductName: string);
var
  Product: TProduct;
begin
  Product:= TProduct.Create(nil);
  try
    if aProductId > 0 then begin
      Product.Load(aProductId);
      ProductName:= Product.ProductName;
    end
    else begin
      Product.LoadSelect('PartName = ' + QuotedStr(aProductName));
      self.ProductId:= Product.Id;
    end;
    Cost:= CommonLib.Round(Product.BuyQty1CostInc,CurrencyRoundPlaces); // inc cost
    SellPrice:= CommonLib.Round(Product.SellQty1PriceInc,CurrencyRoundPlaces);
    ListPrice:= SellPrice;
  finally
    Product.Free;
  end;
end;

procedure TPriceListItem.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure TPriceListItem.SetCost(const Value: double);
begin
  SetFloatField('Cost', Value);
end;

procedure TPriceListItem.SetListPrice(const Value: double);
begin
  SetFloatField('ListPrice', Value);
end;

procedure TPriceListItem.SetPriceListId(const Value: integer);
begin
  SetIntegerField('PriceListID', Value);
end;

procedure TPriceListItem.SetPriceListNumber(const Value: string);
begin
  SetStringField('PriceListNumber', Value);
end;

procedure TPriceListItem.SetProductID(const Value: integer);
begin
  SetIntegerField('ProductID', Value);
end;

procedure TPriceListItem.SetProductName(const Value: string);
begin
  SetStringField('ProductName', Value);
end;

procedure TPriceListItem.SetSellPrice(const Value: double);
begin
  SetFloatField('SellPrice', Value);
end;

function TPriceListItem.ValidateData: boolean;
begin
  result:= inherited ValidateData;

end;

{ TPriceScheme }

constructor TPriceScheme.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL:= 'SELECT * FROM tblPriceScheme';
end;

destructor TPriceScheme.Destroy;
begin

  inherited;
end;

procedure TPriceScheme.DoFieldOnChange(Sender: TField);
var
  bm: TBookMark;
begin
  inherited;
  InitializeNewObject;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName ,'SchemeType') then begin
    if (self.SchemeType = pstPriceList) and (PriceListItems.Count > 0) then begin
      PriceListItems.Dataset.DisableControls;
      try
        bm:= PriceListItems.Dataset.GetBookmark;
        try
          PriceListItems.Dataset.First;
          while not PriceListItems.Dataset.Eof do begin
            PriceListItems.QuantityThreshold:= 1;
            PriceListItems.Dataset.Next;
          end;
          PriceListItems.Dataset.GotoBookmark(bm);
        finally
          PriceListItems.Dataset.FreeBookmark(bm);
        end;
      finally
        PriceListItems.Dataset.EnableControls;
      end;
    end
  end
end;

function TPriceScheme.GetActive: boolean;
begin
  result:= GetBooleanField('Active');
end;

class function TPriceScheme.GetBusObjectTablename: string;
begin
  result:= 'tblPriceScheme';
end;

function TPriceScheme.GetCredit: double;
begin
  result:= GetFloatField('Credit');
end;

function TPriceScheme.GetDateFrom: TDateTime;
begin
  result:= GetDateTimeField('DateFrom');
end;

function TPriceScheme.GetDateTo: TDateTime;
begin
  result:= GetDateTimeField('DateTo');
end;

function TPriceScheme.GetDiscountOrQtyFree: double;
begin
  result:= GetFloatField('DiscountOrQtyFree');
end;

function TPriceScheme.GetPriceListItems: TSchemePriceListItem;
begin
  result:= TSchemePriceListItem(Container.ItemByClass(TSchemePriceListItem, false));
  if not Assigned(result) then begin
    result:= TSchemePriceListItem.Create(nil);
    Container.Add(result);
    result.Connection:= self.Connection;
    result.LoadSelect('PriceSchemeID = ' + IntToStr(ID));
  end;
end;

function TPriceScheme.GetId: integer;
begin
  result:= PriceSchemeId;
end;

class function TPriceScheme.GetIDField: string;
begin
  result:= 'PriceSchemeId';
end;

class function TPriceScheme.GetKeyStringField: string;
begin
  result:= 'SchemeNumber';
end;

function TPriceScheme.GetPrice: double;
begin
  result:= GetFloatField('Price');
end;

function TPriceScheme.GetPriceSchemeId: integer;
begin
  result:= GetIntegerField('PriceSchemeID');
end;

function TPriceScheme.GetRelatedSchemeId: integer;
begin
  result:= GetIntegerField('RelatedSchemeID');
end;

function TPriceScheme.GetRelatedSchemeNumber: string;
begin
  result:= TPriceScheme.IDToggle(RelatedSchemeID);
end;

function TPriceScheme.GetSchemeName: string;
begin
  result:= GetStringField('SchemeName');
end;

function TPriceScheme.GetSchemeNumber: string;
begin
  result:= GetStringField('SchemeNumber');
end;

function TPriceScheme.GetSchemeType: TPriceSchemeType;
begin
  result:= TPriceSchemeType(GetIntegerField('SchemeType'));
end;

function TPriceScheme.GetSchemeTypeName: string;
begin
  result:= SchemeTypeToUserStr(SchemeType);
end;

function TPriceScheme.GetThreshold: double;
begin
  result:= GetFloatField('Threshold');
end;

procedure TPriceScheme.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

end;

function TPriceScheme.LoadSchemesForDate(aDate: TDateTime): boolean;
begin
  self.LoadSelect(
    'Active = "T"' +
    ' AND ((DateFrom IS NULL) OR (' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ' >= DateFrom))' +
    ' AND ((DateTo IS NULL) OR (' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ' <= DateFrom))');
  result:= self.Count > 0;
end;

procedure TPriceScheme.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;

end;

function TPriceScheme.SchemeTypeToUserStr(const Value: TPriceSchemeType): string;
begin
  result:= PriceSchemeTypeName[Value];
end;

procedure TPriceScheme.SetActive(const Value: boolean);
begin
  SetBooleanField('Active', Active);
end;

procedure TPriceScheme.SetCredit(const Value: double);
begin
  SetFloatField('Credit', Value);
end;

procedure TPriceScheme.SetDateFrom(const Value: TDateTime);
begin
  SetDateTimeField('DateFrom', Value);
end;

procedure TPriceScheme.SetDateTo(const Value: TDateTime);
begin
  SetDateTimeField('DateTo', Value);
end;

procedure TPriceScheme.SetDiscountOrQtyFree(const Value: double);
begin
  SetFloatField('DiscountOfFreeQty', Value);
end;

procedure TPriceScheme.SetPrice(const Value: double);
begin
  SetFloatField('Price', Value);
end;

procedure TPriceScheme.SetRelatedSchemeId(const Value: integer);
begin
  SetIntegerField('RelatedSchemeID', Value);
end;

procedure TPriceScheme.SetRelatedSchemeNumber(const Value: string);
begin
  RelatedSchemeId:= TPriceScheme.IDToggle(Value);
end;

procedure TPriceScheme.SetSchemeName(const Value: string);
begin
  SetStringField('SchemeName', Value);
end;

procedure TPriceScheme.SetSchemeNumber(const Value: string);
begin
  SetStringField('SchemeNumber', Value);
end;

procedure TPriceScheme.SetSchemeType(const Value: TPriceSchemeType);
begin
  SetIntegerField('SchemeType', Ord(Value));
end;

procedure TPriceScheme.SetSchemeTypeName(const Value: string);
begin
  SchemeType:= StrToSchemeType(Value);
end;

procedure TPriceScheme.SetThreshold(const Value: double);
begin
  SetFloatField('Threshold', Value);
end;

function TPriceScheme.StrToSchemeType(const Value: string): TPriceSchemeType;
var
  x: TPriceSchemeType;
  found: boolean;
begin
  result:= Low(TPriceSchemeType);
  found:= false;
  for x:= Low(TPriceSchemeType) to High(TPriceSchemeType) do begin
    if Sysutils.SameText(Value, PriceSchemeTypeName[x]) then begin
      Result := x;
      found:= true;
      Break;
    end;
  end;
  if not found then
    raise Exception.Create(
      'TPriceScheme.StrToSchemeType - Invalid Price Scheme Type "' + Value + '"');
end;

function TPriceScheme.ValidateData: boolean;

  function PriceListsOk: boolean;
  begin
    result:= true;
    if PriceListItems.Count = 0 then begin
      ResultStatus.AddItem(false,rssInfo,0,'No Price List specified for this price scheme');
      result:= false;
    end
    else if (PriceListItems.Count > 1) and (SchemeType <> pstCombo) then begin
      ResultStatus.AddItem(false,rssInfo,0,'This Scheme Type can only apply to one Price List');
      result:= false;
    end
    else if not ValidatePriceListItems then begin
      result:= false;
    end;
  end;

begin
  ResultStatus.Clear;
  result:= inherited ValidateData;
  if not result then exit;
  if SchemeName = '' then begin
    ResultStatus.AddItem(false,rssInfo,0,'No name specified for this price scheme');
  end
  else if SchemeNumber = '' then begin
    ResultStatus.AddItem(false,rssInfo,0,'No number specified for this price scheme');
  end
  else if SchemeNumberExists then begin
    ResultStatus.AddItem(false,rssInfo,0,'Another Scheme already exists with this Scheme Number');
  end
  else if Ord(SchemeType) < 0 then begin
    ResultStatus.AddItem(false,rssInfo,0,'No scheme type specified');
  end;

  result:= ResultStatus.OperationOk;
  if result and PriceListsOk then begin
    { check scheme type specific data }
    case SchemeType of
      pstPriceList:
        begin
        end;
      pstQtyFree:
        begin
          if DiscountOrQtyFree = 0 then begin
            ResultStatus.AddItem(false,rssInfo,0,'Qty Free not specified');
          end
        end;
      pstDiscount:
        begin
          if DiscountOrQtyFree = 0 then begin
            ResultStatus.AddItem(false,rssInfo,0,'Discount not specified');
          end
        end;
      pstQtyDiscount:
        begin
          if DiscountOrQtyFree = 0 then begin
            ResultStatus.AddItem(false,rssInfo,0,'Discount not specified');
          end
        end;
      pstPrice:
        begin
          if Price = 0 then begin
            ResultStatus.AddItem(false,rssInfo,0,'Price not specified');
          end
        end;
      pstCredit:
        begin
          if RelatedSchemeId < 1 then begin
            ResultStatus.AddItem(false,rssInfo,0,'No Related Scheme specified');
          end
          else if Credit = 0 then begin
            ResultStatus.AddItem(false,rssInfo,0,'No Credit amount specified');
          end
        end;
      pstCombo:
        begin
        end;
    end;
  end;

  result:= ResultStatus.OperationOk;
end;

function TPriceScheme.SchemeNumberExists: boolean;
var
  qry: TERPQuery;
begin
  result:= false;
  qry:= CommonDbLib.TempMyQuery;
  try
    qry.SQL.Text:= 'SELECT * FROM tblPriceScheme WHERE SchemeNumber = ' +
      QuotedStr(self.SchemeNumber);
    qry.Open;
    while not qry.Eof do begin
      if qry.FieldByName('PriceSchemeID').AsInteger <> self.Id then
        result:= true;
      qry.Next;
    end;
  finally
    qry.Free;
  end;
end;

function TPriceScheme.ValidatePriceListItems: boolean;
var
  bm: TBookmark;
begin
  result:= true;
  if PriceListItems.Count > 0 then begin
    bm:= PriceListItems.Dataset.GetBookmark;
    PriceListItems.Dataset.DisableControls;
    try
      PriceListItems.First;
      while not PriceListItems.EOF do begin
        if not PriceListItems.ValidateData then begin
          result:= false;
          break;
        end;
        PriceListItems.Next;
      end;  
    finally
      PriceListItems.Dataset.GotoBookmark(bm);
      PriceListItems.Dataset.FreeBookmark(bm);
      PriceListItems.Dataset.EnableControls;
    end;
  end;
end;

function TPriceScheme.GetSchemeTypeDescription: string;
begin
  result:= PriceSchemeTypeDesc[SchemeType];
end;

class function TPriceScheme.PriceForSchemeId(
  const aPriceSchemeId: integer): double;
var
  qry: TERPQuery;
begin
  qry:= CommonDbLib.TempMyQuery;
  try
    qry.SQL.Text:= 'SELECT Price FROM tblPriceScheme WHERE PriceSchemeId = ' + IntToStr(aPriceSchemeId);
    qry.Open;
    result:= qry.Fields[0].AsFloat;
  finally
    qry.Free;
  end;
end;

{ TSchemePriceListItem }

constructor TSchemePriceListItem.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL:= 'SELECT * FROM tblSchemePriceListItem';
end;

destructor TSchemePriceListItem.Destroy;
begin

  inherited;
end;

procedure TSchemePriceListItem.DoFieldOnChange(Sender: TField);
begin
  InitializeNewObject;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName ,'PriceListID') then begin
    PriceListNumber:= TPriceList.IDToggle(Sender.AsInteger, TERPConnection(Connection.Connection));
    PriceListName:= TPriceList.IdNameSwitch(Sender.AsInteger, TERPConnection(Connection.Connection));
  end
  else if Sysutils.SameText(Sender.FieldName ,'PriceListNumber') then begin
    PriceListId:= TPriceList.IDToggle(Sender.AsString, TERPConnection(Connection.Connection));
    PriceListName:= TPriceList.IdNameSwitch(PriceListId, TERPConnection(Connection.Connection));
  end
  else if Sysutils.SameText(Sender.FieldName ,'PriceListName') then begin
    PriceListId:= TPriceList.IdNameSwitch(Sender.AsString, TERPConnection(Connection.Connection));
    PriceListNumber:= TPriceList.IDToggle(PriceListId, TERPConnection(Connection.Connection));
  end
end;

class function TSchemePriceListItem.GetBusObjectTablename: string;
begin
  result:= 'tblSchemePriceListItem';
end;

function TSchemePriceListItem.GetId: integer;
begin
  result:= SchemePriceListItemID;
end;

class function TSchemePriceListItem.GetIDField: string;
begin
  result:= 'SchemePriceListItemID';
end;

class function TSchemePriceListItem.GetKeyStringField: string;
begin
  result:= inherited GetKeyStringField;
end;

function TSchemePriceListItem.GetPriceList: TPriceList;
begin
  result:= TPriceList(Container.ItemByClass(TPriceList, false));
  if not Assigned(result) then begin
    result:= TPriceList.Create(nil);
    Container.Add(result);
    result.Connection:= self.Connection;
    result.LoadSelect('PriceListID = ' + IntToStr(self.PriceListId));
  end;
  if result.Id <> self.PriceListId then
    result.LoadSelect('PriceListID = ' + IntToStr(self.PriceListId));
end;

function TSchemePriceListItem.GetPriceListId: integer;
begin
  result:= GetIntegerField('PriceListId');
end;

function TSchemePriceListItem.GetPriceListName: string;
begin
  result:= GetStringField('PriceListName');
end;

function TSchemePriceListItem.GetPriceListNumber: string;
begin
  result:= GetStringField('PriceListNumber');
end;

function TSchemePriceListItem.GetPriceSchemeId: integer;
begin
  result:= GetIntegerField('PriceSchemeID');
end;

function TSchemePriceListItem.GetPriceSchemeNumber: string;
begin
  result:= TPriceScheme.IDToggle(PriceSchemeId);
end;

function TSchemePriceListItem.GetQuantityThreshold: double;
begin
  result:= GetFloatField('QuantityThreshold');
end;

function TSchemePriceListItem.GetSchemePriceListItemId: integer;
begin
  result:= GetIntegerField('PriceListItemId');
end;

procedure TSchemePriceListItem.InitializeNewObject;
begin
  inherited;
  if self.PriceSchemeId < 1 then begin
    if Assigned(Owner) and (Owner is TPriceScheme) then
      PriceSchemeID:= TPriceScheme(Owner).Id;
    QuantityThreshold:= 1;  
  end;
end;

procedure TSchemePriceListItem.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure TSchemePriceListItem.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure TSchemePriceListItem.SetPriceListId(const Value: integer);
begin
  SetIntegerField('PriceListId', value);
end;

procedure TSchemePriceListItem.SetPriceListName(const Value: string);
begin
  SetStringField('PriceListName', Value);
end;

procedure TSchemePriceListItem.SetPriceListNumber(
  const Value: string);
begin
  SetStringField('PriceListNumber', Value);
end;

procedure TSchemePriceListItem.SetPriceSchemeId(
  const Value: integer);
begin
  SetIntegerField('PriceSchemeId', Value);
end;

procedure TSchemePriceListItem.SetPriceSchemeNumber(
  const Value: string);
begin
  PriceSchemeId:= TPriceScheme.IDToggle(Value);
end;

procedure TSchemePriceListItem.SetQuantityThreshold(const Value: double);
begin
  SetFloatField('QuantityThreshold', Value);
end;

function TSchemePriceListItem.ValidateData: boolean;
begin
  result:= inherited ValidateData;
  if not result then exit;
  if not (QuantityThreshold > 0) then begin
    ResultStatus.AddItem(false,rssInfo,0,'Threshold Quantity must be greater than 0');
  end;
  result:= ResultStatus.OperationOk;
end;

function TPriceScheme.LoadSchemesForProduct(aProductId: integer;
  aQty: double; aDate: TDateTime): boolean;
var
  s: string;
begin
  s:=
    'PriceSchemeId IN' +
    '(SELECT s.PriceSchemId'+
    ' FROM tblPriceScheme s, tblSchemePriceListItem si, tblPriceList pl, tblPriceListItem pli'+
    ' WHERE s.PriceSchemeId = si.PriceSchemeId' +
    ' AND si.PriceListId = pl.PriceListID' +
    ' AND pl.PriceListID = pli.PriceListId' +
    ' AND pl.Active = "T" AND s.Active = "T"' +
    ' AND pli.ProductId = ' + IntToStr(aProductId) +
    ' AND ' + FloatToStr(aQty) + ' > si.QuantityThreshold';
  if aDate > 0 then
    s:= s + ' AND ((IS NULL s.DateFrom) OR (' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ' >= s.DateFrom))' +
      ' AND ((IS NULL s.DateTo) OR (' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ' <= s.DateFrom))';
  s:= s + ')';
  self.LoadSelect(s);
  result:= self.Count > 0;
end;

procedure TPriceScheme.InitializeNewObject;
begin
  inherited;
  if self.Id < 1 then
    self.PostDb;
end;

class function TPriceScheme.SchemeTypeToStr(const aSchemeType: TPriceSchemeType): string;
begin
  case aSchemeType of
    pstPriceList: result:= 'pstPriceList';
    pstQtyFree: result:= 'pstQtyFree';
    pstDiscount: result:= 'pstDiscount';
    pstPrice: result:= 'pstPrice';
    pstCredit: result:= 'pstCredit';
    pstCombo: result:= 'pstCombo';
  end;
end;

end.
