unit SalesDiscountValidationObj;

interface

Uses ERPdbComponents, classes,BusobjProduct;

Type
  TSalesDiscountValidationObj = Class(TComponent)
    Private
      fdDiscountAmount: Double;
      fdDiscountPercent: Double;
      fdProductcost: Double;
      fdProductPrice: Double;
      fdDiscountedPrice: Double;
      fdQuantity: Double;
      fiProductID: Integer;
      fProduct:TProductSimple;
      fConnection :TERPConnection;
      fsMsg: String;
      fbUseAvgCost: boolean;
      fbRecalculatediscount: boolean;

      function Product : TProductSimple;
      function getConnection: TERPConnection;
      procedure setConnection(const Value: TERPConnection);

    Protected
    Public
      Property ProductID:Integer read fiProductID write fiProductID;
      Property Productcost :Double read fdProductcost write fdProductcost;
      Property ProductPrice :Double read fdProductPrice write fdProductPrice;
      Property DiscountedPrice :Double read fdDiscountedPrice write fdDiscountedPrice;
      Property DiscountPercent :Double read fdDiscountPercent write fdDiscountPercent;
      Property DiscountAmount :Double read fdDiscountAmount write fdDiscountAmount;
      Property Quantity :Double read fdQuantity write fdQuantity;
      Property Connection :TERPConnection read getConnection  write setConnection ;
      Property Msg:String read fsMsg Write fsMsg;
      Property UseAvgCost :boolean read fbUseAvgCost write fbUseAvgCost;
      Property Recalculatediscount :boolean read fbRecalculatediscount write fbRecalculatediscount;


      constructor Create(AOwner:TComponent);Override;
      Class Function ValidateDiscount(AOwner:TComponent; var adDiscountAmount: Double;var adDiscountPercent: Double;adProductcost: Double;var adProductPrice: Double;var adDiscountedPrice: Double;adQuantity: Double;aiProductID: Integer;abUseAvgCost :Boolean; abRecalculatediscount :Boolean; var aMsg:String; aConnection :TERPConnection = nil):Boolean;
      function DoValidateDiscount:Boolean; Overload;
      function DoValidateDiscount(var adDiscountAmount: Double;var adDiscountPercent: Double;adProductcost: Double;var adProductPrice: Double;var adDiscountedPrice: Double;adQuantity: Double;aiProductID: Integer; abUseAvgCost :Boolean; abRecalculatediscount :Boolean; var aMsg:String; aConnection :TERPConnection = nil):Boolean;Overload;




  End;

implementation

uses sysutils, CommonDbLib, BusObjBase, CommonLib, AppEnvironment, tcConst;


{ TSalesDiscountValidationObj }
function TSalesDiscountValidationObj.Product: TProductSimple;
begin
  if fProduct = nil then begin
    fProduct := TProductsimple.Create(Self);
    fProduct.Connection := TMyDAcDataconnection.Create(fProduct);
    fProduct.Connection.Connection := self.Connection;
    fProduct.Load(ProductID);
  end;
  if fProduct.Id <> productId then fProduct.Load(ProductID);
  Result := fProduct;
end;
procedure TSalesDiscountValidationObj.setConnection(const Value: TERPConnection);
begin
  if Assigned(FConnection) and (Fconnection<> Value) and (Fconnection.Owner = self) then FreeandNil(Fconnection);
  fconnection := Value;
end;

function TSalesDiscountValidationObj.DoValidateDiscount(var adDiscountAmount: Double;var adDiscountPercent: Double;adProductcost: Double;var adProductPrice: Double;var adDiscountedPrice: Double;adQuantity: Double;aiProductID: Integer; abUseAvgCost :Boolean; abRecalculatediscount :Boolean; var aMsg:String; aConnection :TERPConnection = nil):Boolean;
begin
    Self.DiscountAmount := adDiscountAmount;
    Self.DiscountPercent:= adDiscountPercent;
    Self.Productcost    := adProductcost;
    Self.ProductPrice   := adProductPrice;
    Self.DiscountedPrice  := adDiscountedPrice;
    Self.Quantity       := adQuantity;
    Self.ProductID      := aiProductID;
    Self.Msg            := aMsg;
    Self.UseAvgCost     := abUseAvgCost;
    Self.Recalculatediscount     := abRecalculatediscount;
    Self.Connection     := aConnection;
    try
      result := Self.DoValidateDiscount;
    finally
      adDiscountAmount := Self.DiscountAmount ;
      adDiscountPercent := Self.DiscountPercent;
      adProductPrice := Self.ProductPrice   ;
      adDiscountedPrice := Self.DiscountedPrice   ;
      aMsg := Self.Msg            ;
    end;

end;
function TSalesDiscountValidationObj.getConnection: TERPConnection;
begin
  if fconnection = nil then
    fconnection := commondblib.GetSharedMyDacConnection;
  Result := fConnection;

end;

Class Function TSalesDiscountValidationObj.ValidateDiscount(AOwner:TComponent; var adDiscountAmount: Double;var adDiscountPercent: Double;adProductcost: Double;var adProductPrice: Double;var adDiscountedPrice: Double;adQuantity: Double;aiProductID: Integer; abUseAvgCost :Boolean; abRecalculatediscount :Boolean; var aMsg:String; aConnection :TERPConnection = nil):Boolean;
var
  SalesDiscountValidationObj : TSalesDiscountValidationObj;
begin
  SalesDiscountValidationObj := TSalesDiscountValidationObj.Create(AOwner);
  try
    Result := SalesDiscountValidationObj.DoValidateDiscount(adDiscountAmount,adDiscountPercent,adProductcost,adProductPrice,adDiscountedPrice,adQuantity,aiProductID,abUseAvgCost, abRecalculatediscount, aMsg,aConnection);
  finally
     FreeandNil(SalesDiscountValidationObj);
  end;
end;

constructor TSalesDiscountValidationObj.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fdDiscountAmount:=0;
  fdDiscountPercent:=0;
  fdProductcost:=0;
  fdProductPrice:=0;
  fdDiscountedPrice:=0;
  fdQuantity:=0;
  fiProductID:=0;
  fProduct := nil;
  fConnection := nil;
  fbUseAvgCost := False;
  fbRecalculatediscount := False;
end;
function TSalesDiscountValidationObj.DoValidateDiscount: Boolean;
var
  MinimumPrice:Double;
begin
  Result := True;
  try
    if (DiscountPercent =0) and (DiscountAmount =0) then begin
        Result := True;
        Exit;
    end;

    if(Appenv.Employee.MaximumDiscountPercentage=0) and (Appenv.Employee.MinimumMarkupPercentage=0) then begin
      Result := True;
      Exit;
    end;

    if Quantity =0 then Quantity :=1;

    if (DiscountedPrice<>0) and (ProductPrice=0) then
      if DiscountPercent <> 0 then begin
        ProductPrice := commonlib.GetAmountInc(DiscountedPrice ,DiscountPercent/100 );
        DiscountAmount := ProductPrice -DiscountedPrice;
      end else if DiscountAmount <> 0 then begin
        ProductPrice := DiscountedPrice +DiscountAmount;
        DiscountPercent := DiscountAmount/ProductPrice *100;
      end;

    if ProductPrice =0 then begin
      if quantity >= Product.SellQTY3 then ProductPrice := Product.SellQTY3
      else if quantity >= Product.SellQTY2 then ProductPrice := Product.SellQTY2
      else ProductPrice := Product.SellQTY1;
    end;

    if (Productcost =0) and (ProductID <>0) then begin
      if UseAvgCost then Productcost := Product.AverageCost
      else if quantity >= Product.BuyQTY3 then ProductCost := Product.BuyQTY3
      else if quantity >= Product.BuyQTY2 then ProductCost := Product.BuyQTY2
      else ProductCost := Product.BuyQTY1;
    end;

    if (DiscountAmount =0) and (DiscountPercent <> 0) then
      DiscountAmount := ProductPrice * DiscountPercent/100
    else if (DiscountAmount <> 0) and (DiscountPercent = 0) then
      DiscountPercent := DiscountAmount/ProductPrice *100;

    if (DiscountedPrice =0) and ( DiscountPercent<>0) and (ProductPrice<>0) then DiscountedPrice  := GetAmountex( ProductPrice ,DiscountPercent/100)
    else if (DiscountedPrice =0) and ( DiscountAmount<>0) and (ProductPrice<>0) then DiscountedPrice  :=  ProductPrice -DiscountAmount;

    if Appenv.Employee.MaximumDiscountPercentage >0 then
      if Round(DiscountPercent ,2)> Round(Appenv.Employee.MaximumDiscountPercentage*100,2) then begin
          REsult := False;
          Msg :=  'Max Percentage Discount ( ' + FloatToStrf(Appenv.Employee.MaximumDiscountPercentage * 100, ffGeneral , 15,2) +'% ) Exceeded' ;
          if Recalculatediscount then begin
              Msg := Msg + NL+NL + 'Percentage Discount of ' + FloatToStr(AppEnv.CompanyPrefs.MaxDiscountPercentage * 100) +'% was Given';
              DiscountPercent :=Appenv.Employee.MaximumDiscountPercentage *100;
              DiscountedPrice := Commonlib.GetAmountEx(ProductPrice , DiscountPercent/100);
          end;
      end;

    if Appenv.Employee.MinimumMarkupPercentage >0 then begin
      MinimumPrice := commonlib.GetAmountInc(Productcost , Appenv.Employee.MinimumMarkupPercentage);
      if MinimumPrice >  DiscountedPrice then begin
          REsult := False;
          Msg :=  'Min Required Markup ( ' + FloatToStrf(Appenv.Employee.MinimumMarkupPercentage * 100, ffGeneral , 15,2) +'% ) Exceeded' ;
          if Recalculatediscount then begin
              Msg := Msg + NL+NL + 'Percentage Discount Given based on the Min Required Markup of ' + FloatToStr(Appenv.Employee.MinimumMarkupPercentage * 100) +'%';
              Discountamount := ProductPrice - MinimumPrice;
              DiscountPercent := DiscountAmount/ProductPrice *100;
          end;
      end;
    end;

  finally
    if Msg <> '' then
      Msg := MSg + NL + NL+
              'Both "Max Percentage Discount" and "Min Required Markup" can be Set For the Whole Database on the Company Level in the "Sales" page in Preference.' + NL+
              'An Employee Specific Levels are Set in "Employee" Page';;
  end;
end;
end.
