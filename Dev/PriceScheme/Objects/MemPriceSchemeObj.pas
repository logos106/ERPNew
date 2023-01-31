unit MemPriceSchemeObj;

interface

uses
  Classes, contnrs, BusObjPriceScheme, IntegerListObj;

type

  TMemSchemePriceList = class(TObject)
  private
    FActive: boolean;
    FQuantityThreshold: double;
    FPriceListId: integer;
    FPriceListName: string;
    FPriceListNumber: string;
    procedure SetActive(const Value: boolean);
    procedure SetPriceListId(const Value: integer);
    procedure SetPriceListName(const Value: string);
    procedure SetPriceListNumber(const Value: string);
    procedure SetQuantityThreshold(const Value: double);
  public
    property PriceListId: integer read FPriceListId write SetPriceListId;
    property PriceListNumber: string read FPriceListNumber write SetPriceListNumber;
    property PriceListName: string read FPriceListName write SetPriceListName;
    property Active: boolean read FActive write SetActive;
    property QuantityThreshold: double read FQuantityThreshold write SetQuantityThreshold;
  end;

  TMemSchemePriceListList = class(TObject)
  private
    fList: TObjectList;
    function GetCount: integer;
    function GetItem(const index: integer): TMemSchemePriceList;
  public
    constructor Create;
    destructor Destroy; override;
    property Count: integer read GetCount;
    procedure Clear;
    procedure Add(const aItem: TMemSchemePriceList);
    property Item[const index: integer]: TMemSchemePriceList read GetItem; default;
  end;

  TMemPriceScheme = class(TObject)
  private
    FActive: boolean;
    FCredit: double;
    FDiscountOrQtyFree: double;
    FPrice: double;
    FPriceSchemeId: integer;
    FRelatedSchemeId: integer;
    FSchemeName: string;
    FSchemeNumber: string;
    FDateFrom: TDateTime;
    FDateTo: TDateTime;
    FSchemeType: TPriceSchemeType;
    fPriceLists: TMemSchemePriceListList;
    procedure SetActive(const Value: boolean);
    procedure SetCredit(const Value: double);
    procedure SetDateFrom(const Value: TDateTime);
    procedure SetDateTo(const Value: TDateTime);
    procedure SetDiscountOrQtyFree(const Value: double);
    procedure SetPrice(const Value: double);
    procedure SetPriceSchemeId(const Value: integer);
    procedure SetRelatedSchemeId(const Value: integer);
    procedure SetSchemeName(const Value: string);
    procedure SetSchemeNumber(const Value: string);
    procedure SetSchemeType(const Value: TPriceSchemeType);
    function GetPriceLists: TMemSchemePriceListList;
  public
    constructor Create;
    destructor Destroy; override;
    property PriceLists: TMemSchemePriceListList read GetPriceLists;
    property PriceSchemeId: integer read FPriceSchemeId write SetPriceSchemeId;
    property SchemeNumber: string read FSchemeNumber write SetSchemeNumber;
    property SchemeName: string read FSchemeName write SetSchemeName;
    property SchemeType: TPriceSchemeType read FSchemeType write SetSchemeType;
    property Price: double read FPrice write SetPrice;
    property DateFrom: TDateTime read FDateFrom write SetDateFrom;
    property DateTo: TDateTime read FDateTo write SetDateTo;
    property Credit: double read FCredit write SetCredit;
    property RelatedSchemeId: integer read FRelatedSchemeId write SetRelatedSchemeId;
    property DiscountOrQtyFree: double read FDiscountOrQtyFree write SetDiscountOrQtyFree;
    property Active: boolean read FActive write SetActive;
    function IsCombo: boolean;
    function PriceSchemeIdAsStr: string;                      
  end;

  TMemPriceSchemeList = class(TObject)
  private
    fList: TObjectList;
    function GetCount: integer;
    function GetScheme(const index: integer): TMemPriceScheme;
    function GetSchemeById(const aPriceSchemeId: integer): TMemPriceScheme;
  public
    constructor Create;
    destructor Destroy; override;
    property Count: integer read GetCount;
    procedure Clear;
    procedure Add(const aItem: TMemPriceScheme);
    property Scheme[const index: integer]: TMemPriceScheme read GetScheme;
    property SchemeById[const aPriceSchemeId: integer]: TMemPriceScheme read GetSchemeById;
    procedure LoadSchemes(const ActiveOnly: boolean = true; const aDate: TDateTime = 0);
  end;

  TMemSchemeProductRec = class(TObject)
  private
    FListPrice: double;
    FPriceListId: integer;
    FPriceSchemeId: integer;
    FProductId: integer;
    FQuantityThreshold: double;
    procedure SetListPrice(const Value: double);
    procedure SetPriceListId(const Value: integer);
    procedure SetPriceSchemeId(const Value: integer);
    procedure SetProductID(const Value: integer);
    procedure SetQuantityThreshold(const Value: double);
  public
    property ProductId: integer read FProductId write SetProductID;
    property ListPrice: double read FListPrice write SetListPrice;
    property PriceListId: integer read FPriceListId write SetPriceListId;
    property PriceSchemeId: integer read FPriceSchemeId write SetPriceSchemeId;
    property QuantityThreshold: double read FQuantityThreshold write SetQuantityThreshold;
  end;

  TMemSchemeProductRecList = class(TObject)
  private
    fList: TObjectList;
    fProductIdList: TIntegerList;
    function GetCount: integer;
    function GetProductIdList: TIntegerList;
    function GetItem(const index: integer): TMemSchemeProductRec;
  public
    constructor Create;
    destructor Destroy; override;
    property Count: integer read GetCount;
    procedure Clear;
    procedure Add(const aItem: TMemSchemeProductRec); overload;
    procedure Add(const aProductId, aPriceListId, aPriceSchemeId: integer;
                  const aListPrice, aQuantityThreshold: double); overload;
    property Item[const index: integer]: TMemSchemeProductRec read GetItem; default;
    property ProductIdList: TIntegerList read GetProductIdList;
    function ContainsPriceListId(const aPriceListId: integer): boolean;
    function ItemForPriceList(const aPriceListId: integer; const FindCheapest: boolean = false): TMemSchemeProductRec;
  end;


implementation

uses
  sysutils, MyAccess,ERPdbComponents, CommonDbLib, FastFuncs, MySQLConst;

{ TMemSchemePriceList }

procedure TMemSchemePriceList.SetActive(const Value: boolean);
begin
  FActive := Value;
end;

procedure TMemSchemePriceList.SetPriceListId(const Value: integer);
begin
  FPriceListId := Value;
end;

procedure TMemSchemePriceList.SetPriceListName(const Value: string);
begin
  FPriceListName := Value;
end;

procedure TMemSchemePriceList.SetPriceListNumber(const Value: string);
begin
  FPriceListNumber := Value;
end;

procedure TMemSchemePriceList.SetQuantityThreshold(const Value: double);
begin
  FQuantityThreshold := Value;
end;

{ TMemSchemePriceListList }

procedure TMemSchemePriceListList.Add(const aItem: TMemSchemePriceList);
begin
  fList.Add(aItem);
end;

procedure TMemSchemePriceListList.Clear;
begin
  fList.Clear;
end;

constructor TMemSchemePriceListList.Create;
begin
  inherited;
  fList:= TObjectList.Create;
end;

destructor TMemSchemePriceListList.Destroy;
begin
  fList.Free;
  inherited;
end;

function TMemSchemePriceListList.GetCount: integer;
begin
  result:= fList.Count;
end;

function TMemSchemePriceListList.GetItem(const index: integer): TMemSchemePriceList;
begin
  result:= TMemSchemePriceList(fList[index]);
end;

{ TMemPriceScheme }

constructor TMemPriceScheme.Create;
begin
  inherited;
  fPriceLists:= TMemSchemePriceListList.Create;
end;

destructor TMemPriceScheme.Destroy;
begin
  fPriceLists.Free;
  inherited;
end;

function TMemPriceScheme.GetPriceLists: TMemSchemePriceListList;
begin
  result:= fPriceLists;
end;

procedure TMemPriceScheme.SetActive(const Value: boolean);
begin
  FActive := Value;
end;

procedure TMemPriceScheme.SetCredit(const Value: double);
begin
  FCredit := Value;
end;

procedure TMemPriceScheme.SetDateFrom(const Value: TDateTime);
begin
  FDateFrom := Value;
end;

procedure TMemPriceScheme.SetDateTo(const Value: TDateTime);
begin
  FDateTo := Value;
end;

procedure TMemPriceScheme.SetDiscountOrQtyFree(const Value: double);
begin
  FDiscountOrQtyFree := Value;
end;

procedure TMemPriceScheme.SetPrice(const Value: double);
begin
  FPrice := Value;
end;

procedure TMemPriceScheme.SetPriceSchemeId(const Value: integer);
begin
  FPriceSchemeId := Value;
end;

procedure TMemPriceScheme.SetRelatedSchemeId(const Value: integer);
begin
  FRelatedSchemeId := Value;
end;

procedure TMemPriceScheme.SetSchemeName(const Value: string);
begin
  FSchemeName := Value;
end;

procedure TMemPriceScheme.SetSchemeNumber(const Value: string);
begin
  FSchemeNumber := Value;
end;

procedure TMemPriceScheme.SetSchemeType(const Value: TPriceSchemeType);
begin
  FSchemeType := Value;
end;

function TMemPriceScheme.IsCombo: boolean;
begin
  result:= SchemeType = pstCombo;
end;

function TMemPriceScheme.PriceSchemeIdAsStr: string;
begin
  result:= 'ID_' + IntToStr(self.FPriceSchemeId);
end;

{ TMemPriceSchemeList }

procedure TMemPriceSchemeList.Add(const aItem: TMemPriceScheme);
begin
  fList.Add(aItem);
end;

procedure TMemPriceSchemeList.Clear;
begin
  fList.Clear;
end;

constructor TMemPriceSchemeList.Create;
begin
  inherited;
  fList:= TObjectList.Create;
end;

destructor TMemPriceSchemeList.Destroy;
begin
  fList.Free;
  inherited;
end;

function TMemPriceSchemeList.GetCount: integer;
begin
  result:= fList.Count;
end;

function TMemPriceSchemeList.GetScheme(const index: integer): TMemPriceScheme;
begin
  result:= TMemPriceScheme(fList[index]);
end;

function TMemPriceSchemeList.GetSchemeById(const aPriceSchemeId: integer): TMemPriceScheme;
var x: integer;
begin
  result:= nil;
  for x:= 0 to Count-1 do begin
    if Scheme[x].PriceSchemeId = aPriceSchemeId then begin
      result:= Scheme[x];
      break;
    end;
  end;
end;

procedure TMemPriceSchemeList.LoadSchemes(const ActiveOnly: boolean; const aDate: TDateTime);
var
  qry: TERPQuery;
  lastPriceSchemeId: integer;
  scheme: TMemPriceScheme;
  schemeItem: TMemSchemePriceList;
begin
  Clear;
  qry:= CommonDbLib.TempMyQuery;
  try
    qry.SQL.Add('SELECT DISTINCT s.PriceSchemeId, s.SchemeNumber, s.SchemeName,');
    qry.SQL.Add('s.SchemeType, s.Price, s.DateFrom, s.DateTo, s.Credit,');
    qry.SQL.Add('s.RelatedSchemeId, s.DiscountOrQtyFree, s.Active as SchemeActive,');
    qry.SQL.Add('si.QuantityThreshold,');
    qry.SQL.Add('pl.PriceListId, pl.ListNumber, pl.ListName, pl.Active as ListActive');
    qry.SQL.Add('FROM tblPriceScheme s, tblSchemePriceListItem si, tblPriceList pl');
    qry.SQL.Add('WHERE s.PriceSchemeId = si.PriceSchemeId');
    qry.SQL.Add('AND si.PriceListId = pl.PriceListId');
    if ActiveOnly then
      qry.SQL.Add('AND s.Active = "T" AND pl.Active = "T"');
    if aDate > 0 then begin
      qry.SQL.Add('AND ((s.DateFrom IS NULL) OR (s.DateFrom <= ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + '))');
      qry.SQL.Add('AND ((s.DateTo IS NULL) OR (s.DateTo >= ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + '))');
    end;
    qry.SQL.Add('order by s.PriceSchemeId');
    qry.Open;
    lastPriceSchemeId:= 0;
    scheme:= nil;
    while not qry.Eof do begin
      if lastPriceSchemeId <> qry.FieldByName('PriceSchemeId').AsInteger then begin
        { add the new scheme to the list }
        scheme:= TMemPriceScheme.Create;
        scheme.PriceSchemeId:= qry.FieldByName('PriceSchemeId').AsInteger;
        scheme.SchemeNumber:= qry.FieldByName('SchemeNumber').AsString;
        scheme.SchemeName:= qry.FieldByName('SchemeName').AsString;
        scheme.SchemeType:= TPriceSchemeType(qry.FieldByName('SchemeType').AsInteger);
        scheme.Price:= qry.FieldByName('Price').AsFloat;
        scheme.DateFrom:= qry.FieldByName('DateFrom').AsDateTime;
        scheme.DateTo:= qry.FieldByName('DateTo').AsDateTime;
        scheme.Credit:= qry.FieldByName('Credit').AsFloat;
        scheme.RelatedSchemeId:= qry.FieldByName('RelatedSchemeID').AsInteger;
        scheme.DiscountOrQtyFree:= qry.FieldByName('DiscountOrQtyFree').AsFloat;
        scheme.Active:= qry.FieldByName('SchemeActive').AsBoolean;
        self.Add(scheme);
        lastPriceSchemeId:= qry.FieldByName('PriceSchemeId').AsInteger;
      end;
      schemeItem:= TMemSchemePriceList.Create;
      schemeItem.PriceListId:= qry.FieldByName('PriceListId').AsInteger;
      schemeItem.PriceListNumber:= qry.FieldByName('ListNumber').AsString;
      schemeItem.PriceListName:= qry.FieldByName('ListName').AsString;
      schemeItem.QuantityThreshold:= qry.FieldByName('QuantityThreshold').AsFloat;
      schemeItem.Active:= qry.FieldByName('ListActive').asBoolean;
      scheme.PriceLists.Add(schemeItem);
      qry.Next;
    end;
  finally
    qry.Free;
  end;
end;

{ TMemSchemeProductRec }

procedure TMemSchemeProductRec.SetListPrice(const Value: double);
begin
  FListPrice := Value;
end;

procedure TMemSchemeProductRec.SetPriceListId(const Value: integer);
begin
  FPriceListId := Value;
end;

procedure TMemSchemeProductRec.SetPriceSchemeId(const Value: integer);
begin
  FPriceSchemeId := Value;
end;

procedure TMemSchemeProductRec.SetProductID(const Value: integer);
begin
  FProductId := Value;
end;

procedure TMemSchemeProductRec.SetQuantityThreshold(const Value: double);
begin
  FQuantityThreshold := Value;
end;

{ TMemSchemeProductRecList }

constructor TMemSchemeProductRecList.Create;
begin
  inherited;
  fList:= TObjectList.Create;
  fProductIdList:= TIntegerList.Create;
end;

destructor TMemSchemeProductRecList.Destroy;
begin
  fList.Free;
  fProductIdList.Free;
  inherited;
end;

procedure TMemSchemeProductRecList.Add(const aItem: TMemSchemeProductRec);
begin
  fList.Add(aItem);
end;

procedure TMemSchemeProductRecList.Add(const aProductId, aPriceListId,aPriceSchemeId: integer;
                                       const aListPrice, aQuantityThreshold: double);
var
  rec: TMemSchemeProductRec;
begin
  rec:= TMemSchemeProductRec.Create;
  rec.ProductId:= aProductId;
  rec.PriceListId:= aPriceListId;
  rec.FPriceSchemeId:= aPriceSchemeId;
  rec.ListPrice:= aListPrice;
  rec.QuantityThreshold:= aQuantityThreshold;
  Add(rec);
end;

procedure TMemSchemeProductRecList.Clear;
begin
  fList.Clear;
end;

function TMemSchemeProductRecList.GetCount: integer;
begin
  result:= fList.Count;
end;

function TMemSchemeProductRecList.GetProductIdList: TIntegerList;
begin
  result:= fProductIdList;
end;

function TMemSchemeProductRecList.GetItem(const index: integer): TMemSchemeProductRec;
begin
  result:= TMemSchemeProductRec(fList[index]);
end;

function TMemSchemeProductRecList.ContainsPriceListId(const aPriceListId: integer): boolean;
var
  x: integer;
begin
  result:= false;
  for x:= 0 to count -1 do begin
    if Item[x].PriceListId = aPriceListId then begin
      result:= true;
      break;
    end;
  end;
end;

function TMemSchemeProductRecList.ItemForPriceList(const aPriceListId: integer;
  const FindCheapest: boolean = false): TMemSchemeProductRec;
var
  x: integer;
begin
  result:= nil;
  for x:= 0 to count -1 do begin
    if Item[x].PriceListId = aPriceListId then begin
      if not Assigned(result) then
        result:= Item[x]
      else begin
        if FindCheapest then begin
          if Item[x].ListPrice < result.ListPrice then
            result:= Item[x];
        end;
      end;
      if not FindCheapest then
        break;
    end;
  end;
end;

end.
