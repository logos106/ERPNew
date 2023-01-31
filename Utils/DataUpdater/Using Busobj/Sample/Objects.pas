unit Objects;

interface

uses DataUpdateObj, DLLConnectObj,Classes;

type
  TDLLSalesLines = class(TDataUpdateObj)
    private
    Public
  end;
  TDLLSales =class(TDataUpdateObj)
  Private
    fLines :TDLLSalesLines;
    function getlines: TDLLSalesLines;
  Public
    Constructor Create(AOwner:TComponent);override;
    Property Lines :TDLLSalesLines read getlines;
    Class function AddMiscProduct(var Ntot:Double;var msg:String;const objclassname:String;const AmtInc:Double; DLLConnection: TDLLConnection;  AOwner:Tcomponent; SaleID:Integer): boolean; overload;
    Function AddMiscProduct(Const AmtInc:Double):Boolean;overload;
    Class function RecalTotal(var Ntot:Double;var msg:String;const objclassname:String; const TotalAmtInc:Double; DLLConnection: TDLLConnection;  AOwner:Tcomponent; SaleID:Integer): boolean;
  End;
  TDLLProduct = class(TDataUpdateObj)
  Private
  Public

    Class function CreateProduct(const Productname, Producttype:String ;
                    DLLConnection :TDLLConnection;  AOwner:Tcomponent):TDLLProduct;
  End;

implementation

uses sysutils, typinfo, Fastfuncs, DataUpdaterconfig, tcConst;



{ TProduct }

class function TDLLProduct.CreateProduct(const Productname,
  Producttype: String; DLLConnection: TDLLConnection;  AOwner:Tcomponent): TDLLProduct;
var
    ProductObj:TDLLProduct;
begin
    ProductObj := TDLLProduct.create(DLLConnection, 'TProduct' , AOwner);
    REsult := ProductObj;
    if ProductObj.LoadSelect( 'Partname = '+QuotedStr(Productname)) then begin
      if ProductObj.count = 0 then begin
          ProductObj.new;
          SetStrProp(ProductObj.Obj , 'ProductName' , Productname);
          SetStrProp(ProductObj.obj , 'ProductType' , Producttype);
          ProductObj.Save ;
      end;
    end;

end;

{ TDLLSales }

class function TDLLSales.AddMiscProduct(var Ntot:Double;var msg:String;const objclassname:String;const AmtInc:Double; DLLConnection: TDLLConnection;  AOwner:Tcomponent; SaleID:Integer): boolean;
  var
    InvoiceObj:TDLLSales;
  begin
    result := False;
    InvoiceObj := TDLLSales.create(DLLConnection, (*'TInvoice'*)objclassname , AOwner);
    if InvoiceObj.LoadSelect('SaleID = '+Fastfuncs.intToStr(saleID)) then begin
      if InvoiceObj.Addmiscproduct(Amtinc) then begin
        nTot :=GetFloatProp(InvoiceObj.obj ,'TotalAmountInc' );
        if (AmtInc <0.1) and  (AmtInc> 0-0.1) then msg := '' else
          msg:= LINEADJUSTMENTPRODUCT+' :' +floattoStr(amtInc);
      end;
    end;
end;

function TDLLSales.AddMiscProduct(const AmtInc: Double): Boolean;
begin
  result := true;
  if (AmtInc <0.1) and  (AmtInc> 0-0.1) then exit;

      Self.Lines.New;
      SetStrProp(Self.lines.Obj , 'ProductName' , LINEADJUSTMENTPRODUCT);
      SetStrProp(Self.lines.Obj , 'UnitOfMeasure' , DEFAULT_UOM);
      SetfloatProp(Self.lines.Obj , 'UOMQtySold' , 1);
      SetFloatProp(Self.lines.Obj , 'UOMQtyShipped' , 1);
      SetFloatProp(Self.lines.Obj , 'LinePriceinc' , AmtInc);
      Self.lines.PostDB;
      result := Self.Save;
end;

constructor TDLLSales.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  flines := nil;
end;

function TDLLSales.getlines: TDLLSalesLines;
begin
  if not assigned(fLines) then begin
    flines := TDLLSalesLines.create(connection, '' , Self);
    flines.obj := GetObjectProp(Self.obj, 'Lines');
  end;
   result := flines;
end;

class function TDLLSales.RecalTotal(var Ntot:Double;var msg:String;const objclassname:String; const TotalAmtInc:Double; DLLConnection: TDLLConnection;  AOwner:Tcomponent; SaleID:Integer): boolean;
var
    InvoiceObj:TDLLSales;
    CalcOrdertotals:TGeneralProc;
    amtInc:Double;
begin
    InvoiceObj  := TDLLSales.create(DLLConnection, (*'TInvoice'*)objclassname , AOwner);
      if InvoiceObj.LoadSelect('SaleID = '+Fastfuncs.intToStr(saleID)) then begin
        if GetFloatProp(InvoiceObj.obj ,'TotalAmountInc' ) = TotalAmtInc then begin
            result := True;
            Exit;
        end;

      try
          TMethod(CalcOrdertotals).Data := Pointer(InvoiceObj.Obj) ;
          TMethod(CalcOrdertotals).Code := InvoiceObj.Obj.MethodAddress(FUNC_CALCORDERTOTALS);
          if TMethod(CalcOrdertotals).Code <> nil then begin
            CalcOrdertotals;
            InvoiceObj.PostDB;
          end;
        finally
            CalcOrdertotals := nil;
        end;
      end;
      if GetFloatProp(InvoiceObj.obj ,'TotalAmountInc' ) = TotalAmtInc then begin
          nTot :=GetFloatProp(InvoiceObj.obj ,'TotalAmountInc' );
          msg:= 'CalcOrderTotals';
          result := True;
          Exit;
      end else begin
          amtinc  := GetFloatProp(InvoiceObj.obj ,'TotalAmountInc' ) - TotalAmtInc;
          result  := InvoiceObj.Addmiscproduct(amtInc);
          nTot    :=GetFloatProp(InvoiceObj.obj ,'TotalAmountInc' );
          if (AmtInc <0.1) and  (AmtInc> 0-0.1) then else
            msg:= LINEADJUSTMENTPRODUCT+' :' +floattoStr(amtInc);
      end;

end;

end.
