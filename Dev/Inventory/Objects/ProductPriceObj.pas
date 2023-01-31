unit ProductPriceObj;

{
 15/05/06  1.00.08  AL  moved pSubProductRec to tcTypes
}

interface

uses
  MyAccess,ERPdbComponents, tcTypes;

const

  {
   Pricing Types:

   1. VOLUME PRICES    Also each product can have a different price according to the quantity sold,
                       Price1, Price2, Price3.  This is known in POS as a volume discount.
  }
  VOLUME_PRICES   = 0;
  PRICE_MATRIX    = 1;

type
  TProductPriceObj = class(TObject)
  private
    fqryProducts: TERPQuery;
    function MatrixPrice(const ProductID: Integer; MatrixRef: String): double;
  public
    constructor Create;
    destructor Destroy; override;
    function ProductPrice(const ProductID, ClassID: integer; const OrderedQty: double;
                          var PriceEx: double; const WholeSale: boolean;MatrixRef:String=''): boolean;

    function GetProductIDFromBarcode(const Barcode: string; const ClassID, CustClientID: integer): TSubProductRec;

  end;

implementation

uses
  CommonDbLib, SysUtils, DNMLib, BusObjStock, BusObjConst,
  tcConst, tcDataUtils, BusObjPartsPriceMatrix, BusObjUOM,
  AppEnvironmentVirtual;

{ TProductPriceObj }

constructor TProductPriceObj.Create;
begin
  inherited;
  fqryProducts := TERPQuery.Create(nil);
  fqryProducts.Connection := CommonDbLib.GetSharedMyDacConnection;
  fqryProducts.ParamCheck := false;
end;

destructor TProductPriceObj.Destroy;
begin
  FreeAndNil(fqryProducts);
  inherited;
end;
Function TProductPriceObj.MatrixPrice(const ProductID:Integer;MatrixRef:String):double;
var
  PartsPriceEntry :TPartsPriceEntry;
begin
  REsult := 0;
  PartsPriceEntry :=TPartsPriceEntry.CreateWithNewConn(nil);
  try
    PartsPriceEntry.LoadSelect('productId = ' +inttostr(ProductID));
    if PartsPriceEntry.Locate('EntryValueRef' , MatrixRef, []) then begin
      REsult := PartsPriceEntry.Price;
    end;
  finally
    FreeandNil(PartsPriceEntry);
  end;
end;
function TProductPriceObj.ProductPrice(const ProductID, ClassID: integer; const OrderedQty: double;
                                        var PriceEx: double; const WholeSale: boolean;MatrixRef:String=''): boolean;
var
  VolPriceEx: double;
  Ordered: double;
begin
  Ordered := OrderedQty;
  if (OrderedQty < 0.00) then Ordered := (OrderedQty * (-1));
  // VOLUME PRICES
  VolPriceEx:=0;
  if MatrixRef <> '' then VolPriceEx := MatrixPrice(ProductID,MatrixREf);

  if VolPriceEx =0 then
    with fqryProducts do begin
      Connection := CommonDbLib.GetSharedMyDacConnection;
      Sql.Clear;
      Sql.Add('Select PARTSID,SellQTY1,SellQTY2,SellQTY3,PRICE1,PRICE2,PRICE3,WHOLESALEPRICE From tblparts ');
      Sql.Add('Where PARTSID = ' + IntToStr(ProductID) + ' ');
      Open;

      if (FieldByName('SellQTY3').AsFloat <> 0.0) and (Ordered >= FieldByName('SellQTY3').AsFloat) and
        (FieldByName('PRICE3').AsFloat <> 0.00) then begin
        VolPriceEx := FieldByName('PRICE3').AsFloat;
      end else if (FieldByName('SellQTY2').AsFloat <> 0.0) and (Ordered >= FieldByName('SellQTY2').AsFloat)
        and (Ordered < FieldByName('SellQTY3').AsFloat) and (FieldByName('PRICE3').AsFloat <> 0.00) then begin
        VolPriceEx := FieldByName('PRICE2').AsFloat;
      end else begin
        VolPriceEx := FieldByName('PRICE1').AsFloat;
      end;

      //Whole Sale Price
      if WholeSale then begin
        VolPriceEx := FieldByName('WHOLESALEPRICE').AsFloat;
      end;
    end;

    //Apply Class Variance
  VolPriceEx := VolPriceEx + (VolPriceEx * GetClassVariancePercentage(ClassID, ProductID));

    //Final Var's Volume Prices
  PriceEx := VolPriceEx;
  Result := true;
  fqryProducts.Close;
end;

function TProductPriceObj.GetProductIDFromBarcode(const Barcode: string;
  const ClassID, CustClientID: integer): TSubProductRec;
var
  PartsID: integer;
  UOMId: integer;
  UOMInfo: TUnitOfMeasureInfo;
begin
  PartsId := TProduct.ProductIdForBarcode(Barcode,UOMId);
  if partsID = 0 then begin
    Result.ProductID       := 0;
    Result.Units           := '';
    Result.UnitsID         := 1;
    Result.UnitsMultiplier := 0;
    Result.SubProductDesc  := '';
    Result.PriceEx         := 0;
    Result.Valid           := false;
  end else begin
    Result.ProductID := PartsId;
    if UOMId > 0 then begin

    end
    else begin
      UOMId := TUnitOfMeasure.CreateNewUOM(nil, PartsId, AppEnvVirt.Str['DefaultClass.DefaultUOM']);
    end;
    Result.UnitsID := UOMId;
    UOMInfo := TUnitOfMeasure.GetUOMInfo(UOMId);
    Result.Units := UOMInfo.Name;
    result.UnitsMultiplier := UOMInfo.Multiplier;
    Result.SubProductDesc := '';
    Result.PriceEx := 0;
    Result.Valid := true;
  end;
end;

end.

