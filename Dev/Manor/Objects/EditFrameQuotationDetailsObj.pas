unit EditFrameQuotationDetailsObj;

interface

uses
  Classes, NodePropertiesLink, MyAccess,ERPdbComponents, SysUtils,
  TypInfo, FrameArchitraveDetailsObj, FrameFanLightDetailsObj,
  FrameThresholdDetailsObj, FrameExtensionDetailsObj,
  FrameIntumescentStripDetailsObj, FrameLooseStopDetail;

type
  TEditFrameQuotationDetails = class(TNodePropertiesLink)
  private
    FFrameType: TNodeProperties;
    FStopType: TNodeProperties;
    FFrames: TNodeProperties;
    FDoorOverPanel: TNodeProperties;
    FTotalDoorWidth: TNodeProperties;
    FDoorHeight: TNodeProperties;
    FDoorThickness: TNodeProperties;
    FOverallHeight: TNodeProperties;
    FMaterial: TNodeProperties;
    FWebThicknessInches: TNodeProperties;
    FWebThicknessMills: TNodeProperties;
    FWidthInches: TNodeProperties;
    FWidthMills: TNodeProperties;
    FTimberCost: TNodeProperties;
    FCostLinearMetre: TNodeProperties;
    fCost :TNodeProperties;
    FTolerance: TNodeProperties;
    FUnassembled: TNodeProperties;
    FWrapped: TNodeProperties;
    FIdentified: TNodeProperties;
    FCarpetGap: TNodeProperties;
    FSpecialFinish: TNodeProperties;
    FSpecialfinishcost: TNodeProperties;
    FComments: TNodeProperties;
    FProfitAdded: TNodeProperties;
    FDeliveryCharge: TNodeProperties;
    FSummaryCost: TNodeProperties;
    FTotalCost: TNodeProperties;
    FBasicFramecost: TNodeProperties;
    FDoorArea: double;
    FFrameArchitraveDetails: TFrameArchitraveDetails;
    FFrameFanLightDetails: TFrameFanLightDetails;
    FFrameThresholdDetails: TFrameThresholdDetails;
    FFrameExtensionDetails: TFrameExtensionDetails;
    FFrameIntumescentStripDetails: TFrameIntumescentStripDetails;
    FFrameLooseStopDetails : TFrameLooseStopDetails;
    function getDoorArea : double;
  protected
    procedure AssignItemType; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure PerformCalculations; override;
    function GetTotalCost: Double; override;
    property DoorArea: double read getDoorArea;
  published
    property FrameType: TNodeProperties read FFrameType write FFrameType;
    property StopType: TNodeProperties read FStopType write FStopType;
    property Frames: TNodeProperties read FFrames write FFrames;
    property DoorOverPanel: TNodeProperties read FDoorOverPanel write FDoorOverPanel;
    property TotalDoorWidth: TNodeProperties read FTotalDoorWidth write FTotalDoorWidth;
    property DoorHeight: TNodeProperties read FDoorHeight write FDoorHeight;
    property DoorThickness: TNodeProperties read FDoorThickness write FDoorThickness;
    property OverallHeight: TNodeProperties read FOverallHeight write FOverallHeight;
    property Material: TNodeProperties read FMaterial write FMaterial;
    property WebThicknessInches: TNodeProperties read FWebThicknessInches write FWebThicknessInches;
    property WebThicknessMills: TNodeProperties read FWebThicknessMills write FWebThicknessMills;
    property WidthInches: TNodeProperties read FWidthInches write FWidthInches;
    property WidthMills: TNodeProperties read FWidthMills write FWidthMills;
    property TimberCost: TNodeProperties read FTimberCost write FTimberCost;
    property CostLinearMetre: TNodeProperties read FCostLinearMetre write FCostLinearMetre;
    property Cost: TNodeProperties read FCost write FCost;
    property Tolerance: TNodeProperties read FTolerance write FTolerance;
    property Unassembled: TNodeProperties read FUnassembled write FUnassembled;
    property Wrapped: TNodeProperties read FWrapped write FWrapped;
    property Identified: TNodeProperties read FIdentified write FIdentified;
    property CarpetGap: TNodeProperties read FCarpetGap write FCarpetGap;
    property SpecialFinish: TNodeProperties read FSpecialFinish write FSpecialFinish;
    property Specialfinishcost: TNodeProperties read FSpecialfinishcost write FSpecialfinishcost;
    property Comments: TNodeProperties read FComments write FComments;
    property ProfitAdded: TNodeProperties read FProfitAdded write FProfitAdded;
    property DeliveryCharge: TNodeProperties read FDeliveryCharge write FDeliveryCharge;
    property SummaryCost: TNodeProperties read FSummaryCost write FSummaryCost;
    property TotalCost: TNodeProperties read FTotalCost write FTotalCost;
    property BasicFrameCost: TNodeProperties read FBasicFrameCost write FBasicFrameCost;
    property FrameArchitraveDetails: TFrameArchitraveDetails read FFrameArchitraveDetails write FFrameArchitraveDetails;
    property FrameFanLightDetails: TFrameFanLightDetails read FFrameFanLightDetails write FFrameFanLightDetails;
    property FrameThresholdDetails: TFrameThresholdDetails read FFrameThresholdDetails write FFrameThresholdDetails;
    property FrameExtensionDetails: TFrameExtensionDetails read FFrameExtensionDetails write FFrameExtensionDetails;
    property FrameIntumescentStripDetails: TFrameIntumescentStripDetails read FFrameIntumescentStripDetails write FFrameIntumescentStripDetails;
    Property FrameLooseStopDetails  : TFrameLooseStopDetails    Read fFrameLooseStopDetails Write fFrameLooseStopDetails;
  end;

implementation

uses
  DoorsLib, CommonLib, DecimalRounding;

procedure TEditFrameQuotationDetails.AssignItemType;
begin
  inherited;
  ItemType := 'EditFrameQuotationDetails';
end;
function TEditFrameQuotationDetails.getDoorArea : double;
begin
    FDoorArea := (StrToFloatDef(DoorHeight.Value ,0)*2 +
                StrToFloatDef(TotalDoorWidth.Value , 0))/1000;
    Result := FDoorArea;
end;
constructor TEditFrameQuotationDetails.Create(AOwner: TComponent);
begin
  inherited;
  Doors := TDoors.Create;
  FFrameArchitraveDetails := TFrameArchitraveDetails.Create(self);
  FFrameFanLightDetails := TFrameFanLightDetails.Create(self);
  FFrameThresholdDetails := TFrameThresholdDetails.Create(self);
  FFrameExtensionDetails := TFrameExtensionDetails.Create(self);
  FFrameIntumescentStripDetails := TFrameIntumescentStripDetails.Create(self);
  FFrameLooseStopDetails    := TFrameLooseStopDetails.Create(Self);
end;

destructor TEditFrameQuotationDetails.Destroy;
begin
  FreeAndNil(FFrameArchitraveDetails);
  FreeAndNil(FFrameFanLightDetails);
  FreeAndNil(FFrameThresholdDetails);
  FreeAndNil(FFrameExtensionDetails);
  FreeAndNil(FFrameIntumescentStripDetails);
  FreeAndNil(FFrameLooseStopDetails);
  FreeAndNil(Doors);
  inherited;
end;

function TEditFrameQuotationDetails.GetTotalCost: Double;
begin
  Result := inherited GetTotalCost + StrToFloatDef(TotalCost.Value, 0);
end;

procedure TEditFrameQuotationDetails.PerformCalculations;
var
    tmpcost :Double;
begin
  inherited;

    if SameText(CurNodename , 'WidthInches')        then begin
        if emptyNumber(WidthMills.Value) then
            WidthMills.Value          :=FloatToStr(inchtomm(StrToFloatDef(WidthInches.Value,0)));
    end else if SameText(CurNodename , 'WebThicknessInches') then begin
        if EmptyNumber(WebThicknessMills.Value) then
            WebThicknessMills.Value   :=FloatToStr(inchtomm(StrToFloatDef(WebThicknessInches.Value,0)));
    end else if SameText(CurnodeName , 'DoorHeight')         then begin
        if StrToFloatDef(OverallHeight.Value,0) = 0 then
            OverallHeight.Value := DoorHeight.Value;
    end;

    tmpcost     := StrToFloatDef(WidthInches.Value, 0) * StrToFloatDef(WebThicknessInches.Value,0)*39.96 *
                (StrToFloatDef(TimberCost.Value,0)/1728);
    TmpCost := DecimalRounding.DecimalRoundDbl(TmpCost , 2, drRndUp);
    CostLinearMetre.Value := floatToStr(Tmpcost);

    Tmpcost     := DoorArea * Tmpcost;
    TmpCost     := DecimalRounding.DecimalRoundDbl(TmpCost , 2, drRndUp);
    Cost.Value  := FloattoStr(Tmpcost);

    TmpCost         := tmpCost + StrToFloatDef(SummaryCost.Value, 0) +StrToFloatDef(Specialfinishcost.Value,0);
    BasicFrameCost.Value :=floatToStr(Tmpcost);

    tmpcost         := tmpCost + StrToFloatDef(DeliveryCharge.Value, 0);
    tmpCost         := tmpCost * (1 + StrToFloatDef(ProfitAdded.Value, 0) / 100);
    TmpCost         := DecimalRounding.DecimalRoundDbl(TmpCost , 2, drRndUp);
    TotalCost.Value := floatToStr(Tmpcost);

end;

initialization
  RegisterClassOnce(TEditFrameQuotationDetails);
end.
