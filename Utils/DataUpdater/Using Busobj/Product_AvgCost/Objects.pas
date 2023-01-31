unit Objects;

interface


uses DataUpdateObj, DLLConnectObj,Classes;

const
  FUNC_UpdateAvgCosts = 'DLLUpdateAvgCosts';

type
    TUpdateAvgCost = Function :Double of Object;

  TDLLProduct = class(TDataUpdateObj)
  Private
    (*ProductObj:TDLLProduct;*)
    UpdateAvgCost:TUpdateAvgCost;
  Public
    Procedure RecalculateAvgcost(const PartsID:Integer;  var AvgCostbeforecalc: double ; var AvgCostAftercalc:Double);
    constructor Create(const oConnection : TDLLConnection;const objname :String; AOwner:TComponent);Override;
    Destructor Destroy;override;
  End;

implementation

uses sysutils, typinfo, Fastfuncs, DataUpdaterconfig, tcConst;



{ TProduct }

{ TDLLProduct }

constructor TDLLProduct.Create(const oConnection: TDLLConnection; const objname: String; AOwner: TComponent);
begin
  inherited Create(oConnection, 'TProduct' , AOwner);
  TMethod(UpdateAvgCost).Data := Pointer(obj) ;
  TMethod(UpdateAvgCost).Code := obj.MethodAddress(FUNC_UpdateAvgCosts);
end;

destructor TDLLProduct.Destroy;
begin
  TMethod(UpdateAvgCost).Data := nil;
  TMethod(UpdateAvgCost).Code := nil;
  FreeandNil(UpdateAvgCost);
  inherited;
end;

Procedure TDLLProduct.RecalculateAvgcost(const PartsID:Integer;  var AvgCostbeforecalc: double ; var AvgCostAftercalc:Double);
(*var
    AvgCostbeforecalc:Double;
    AvgCostAftercalc:Double;*)
begin
(*  result := '';*)
  if TMethod(UpdateAvgCost).Code = nil then exit;

  if LoadSelect( 'PartsID = '+FastFuncs.IntToStr(PartsID)) then begin
      if count = 0 then begin
        (*result:= result +'Not found';*)
        exit;
      end;
      AvgCostbeforecalc := GetFloatProp(Obj , 'AverageCost');
      AvgCostAftercalc := UpdateAvgcost;
      (*if AvgCostAftercalc = AvgCostbeforecalc then
      else
      Result := result + FloatToStrF(AvgCostbeforecalc , ffCurrency , 15, 2) +#9 +':' +#9 +FloatToStrF(AvgCostAftercalc , ffCurrency , 15, 2);*)
  end;
end;


end.
