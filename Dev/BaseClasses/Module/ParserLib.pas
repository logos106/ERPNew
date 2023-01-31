unit ParserLib;

interface

uses  SysUtils, Messages, Classes, Graphics, Controls, Dialogs, parserobj , BusobjBaseProdTrans;

function ParserValue(AOwner:TComponent; GetVarEvent:TGetVarEvent; formula:String;var errMSG:String):Double;
function ProductQtyParseValue(AOwner:TComponent; getVarEvent:TGetVarEvent;var ErrMsg:String; Transline:TProdTrans ; Qty:Double):double;Overload;
function ProductQtyParseValue(AOwner:TComponent; getVarEvent:TGetVarEvent;var ErrMsg:String; Qty:Double;PartCalcformula:String;PartCalcFormulaMult, transUnitOfMeasureID ,TRansUOMMultiplier, PartCalcformulaUOMID,PartCalcformulaUOMMult:Double):double;Overload;


implementation

uses DNMLib, tcConst, busobjOrders, BusObjBase, CommonLib;

function ProductQtyParseValue(AOwner:TComponent; getVarEvent:TGetVarEvent;var ErrMsg:String; Transline:TProdTrans ; Qty:Double):double;
begin
  With Transline do begin
    Result := ProductQtyParseValue(AOwner , getVarEvent ,  errMsg , Qty , QtyCalcFormulaDetails.PartCalcformula, Product.PartCalcFormulaMult , UnitOfMeasureID , UOMMultiplier , Product.PartCalcformulaUOMID, Product.PartCalcformulaUOMMult);
  end;
end;

function ProductQtyParseValue(AOwner:TComponent; getVarEvent:TGetVarEvent;var ErrMsg:String; Qty:Double;PartCalcformula:String;PartCalcFormulaMult, transUnitOfMeasureID , TRansUOMMultiplier, PartCalcformulaUOMID,PartCalcformulaUOMMult:Double):double;
begin
    Result := ParserValue(AOwner , getVarEvent ,  PartCalcformula, errMsg);
    if errMsg<>'' then
    else begin
        Result := Result *Qty;
        if PartCalcFormulaMult =0 then PartCalcFormulaMult := 1;
        Result := Result *PartCalcFormulaMult;
        if transUnitOfMeasureID = PartCalcformulaUOMID then begin
        end else begin
          if PartCalcformulaUOMMult =0 then PartCalcformulaUOMMult := 1;
          Result := Result *PartCalcformulaUOMMult;
          Result := DivZer(Result ,TRansUOMMultiplier );
        end;
        Result := commonlib.round(Result , GeneralRoundPlaces);
    end;
end;

function ParserValue(AOwner:TComponent; GetVarEvent:TGetVarEvent; formula:String;var errMSG:String):Double;
var
  Parser: TMathParser;
begin
  Result := 0;
  ErrMsg:= '';
    Parser := TMathParser.Create(AOwner);
    try
      Parser.OnGetVar := GetVarEvent;
      Parser.ParseString := Formula;
      try Parser.Parse;
      except
        on E: Exception do begin
          ErrMsg:= E.message
        end;
        // kill the exception
        // parser can create mathmatical exceptions like devide by 0 etc, when the field is wrong value
      end;
      if Parser.ParseError then ErrMsg:= errMsg+ Parser.ErrorMessage
      else REsult := Parser.ParseValue;
    finally FreeAndNil(Parser);

    end;
end;

end.

