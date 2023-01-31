unit FrameBaseobject;
interface

uses
  Classes, NodePropertiesLink, MyAccess,ERPdbComponents, SysUtils;

type
  TFrameBaseObj = class(TNodePropertiesLink)
  private
  Protected
    tmpcost :double;
    calculatingcost :Boolean;
    Procedure CalcCost(width , Height ,TimberCost , Cost , Totalcost :TNodeProperties);// Virtual;
    Procedure ApplyExtraCalc; virtual;
    Function GetDoorArea :Double; virtual;
  Public
    constructor Create(AOwner: TComponent); override;
    Property DoorArea :Double REad getDoorArea;
  end;

implementation

uses EditFrameQuotationDetailsObj, DecimalRounding;

constructor TFrameBaseObj.Create(AOwner: TComponent);
begin
    inherited;
    calculatingcost := false;
end;
Procedure TFrameBaseObj.ApplyExtraCalc;
begin
    //descendants will override 
end;
Function TFrameBaseObj.GetDoorArea :Double;
var
    DoorFrame : TEditFrameQuotationDetails;
begin
    REsult := 0;
    if (Assigned(Self.Owner)) and (Self.Owner is TEditFrameQuotationDetails) then
        DoorFrame := TEditFrameQuotationDetails(Self.Owner)
    else Exit;
    Result := DoorFrame.DoorArea;
end;
Procedure TFrameBaseObj.CalcCost(width , Height ,TimberCost , Cost , Totalcost :TNodeProperties);
var
    fwidth, fHeight, ftimbercost  :double;
begin
    if calculatingcost then Exit;
    calculatingcost := True;
    try
        fWidth      := 1;
        fHeight     := 1;
        fTimberCost := 1;

        if Assigned(Width)      then fWidth     := StrToFloatDef(width.Value, 0);
        if Assigned(Height)     then fHeight    := StrToFloatDef(Height.Value, 0);
        if Assigned(TimberCost) then fTimberCost:= StrToFloatDef(TimberCost.Value, 0);

        tmpcost :=  fWidth * fHeight*39.96 *fTimberCost/1728;
        ApplyExtraCalc;
        TmpCost := DecimalRounding.DecimalRoundDbl(TmpCost , 2, drRndUp);
        Cost.Value := FloatToStr(TmpCost);


        TmpCost := DoorArea *TmpCost;
        TmpCost := DecimalRounding.DecimalRoundDbl(TmpCost , 2, drRndUp);
        totalcost.value :=  FloatToStr(TmpCost);
    finally
        calculatingcost := False;
    end;
end;

end.
