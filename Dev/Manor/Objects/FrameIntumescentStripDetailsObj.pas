unit FrameIntumescentStripDetailsObj;

interface

uses
  Classes, NodePropertiesLink, MyAccess,ERPdbComponents, SysUtils, FrameBaseobject;

type
  TFrameIntumescentStripDetails = class(TFrameBaseObj)
  private
    FStripPosition: TNodeProperties;
    FIntumescentStripGroove: TNodeProperties;
    FIncludeGrooveCost: TNodeProperties;
    FIncludeISCost: TNodeProperties;
    FStripCost: TNodePropertiesList;
    FStripLength: TNodePropertiesList;
    FStripTotalCost: TNodePropertiesList;
    FStripDescription: TNodePropertiesList;
    FTotalcost :TNodeProperties;
  protected
    procedure AssignItemType; override;
  public
    procedure PerformCalculations; override;
    function GetTotalCost: Double; override;
  published
    property StripPosition: TNodeProperties read FStripPosition write FStripPosition;
    property IntumescentStripGroove: TNodeProperties read FIntumescentStripGroove write FIntumescentStripGroove;
    property IncludeGrooveCost: TNodeProperties read FIncludeGrooveCost write FIncludeGrooveCost;
    property IncludeISCost: TNodeProperties read FIncludeISCost write FIncludeISCost;
    property StripCost: TNodePropertiesList read FStripCost write FStripCost;
    property StripLength: TNodePropertiesList read FStripLength write FStripLength;
    property StripTotalCost: TNodePropertiesList read FStripTotalCost write FStripTotalCost;
    property StripDescription: TNodePropertiesList read FStripDescription write FStripDescription;
    property totalcost: TNodeProperties read FTotalCost write FTotalcost;
  end;

implementation

uses
  CommonLib, DecimalRounding;

{ TFrameIntumescentStripDetails }

procedure TFrameIntumescentStripDetails.AssignItemType;
begin
  inherited;
  ItemType := 'FrameIntumescentStripDetails';
end;

function TFrameIntumescentStripDetails.GetTotalCost: Double;
begin
  Result := inherited GetTotalCost+ StrtoFloatdef(totalcost.value , 0);
end;

procedure TFrameIntumescentStripDetails.PerformCalculations;
var
  Index: Integer;
  //Tmpcost :Double;
  sTotalCost :Double;
begin
  inherited;
  if Calculating then exit;
  
  tmpcost := 0;
  for Index := 0 to StripLength.NodePropsCount - 1 do begin
    // maureen : 07082008 Pageno 20
      //StripTotalCost[index].Value := FloatToStr(StrToFloatDef(StripLength[Index].Value, 0) * StrToFloatDef(StripCost[Index].Value, 0));
      sTotalCost :=StrToFloatDef(StripCost[Index].Value, 0) *DoorArea;
      sTotalCost         := DecimalRounding.DecimalRoundDbl(sTotalCost , 2, drRndUp);
      StripTotalCost[index].Value := floatToStr(sTotalCost);
      tmpCost := tmpCost + sTotalCost;
  end;
  tmpcost         := DecimalRounding.DecimalRoundDbl(tmpcost , 2, drRndUp);
  totalcost.value := floattoStr(tmpcost);
end;

initialization
  RegisterClassOnce(TFrameIntumescentStripDetails);
end.
