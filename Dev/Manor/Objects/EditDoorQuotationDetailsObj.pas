unit EditDoorQuotationDetailsObj;

interface

uses
  Classes, NodePropertiesLink, MyAccess,ERPdbComponents, SysUtils,
  DoorEditOverPanelDetailsObj, DoorEditLippingsStilesDetailsObj, DoorEditLaminatedFacesDetailsObj,
  DoorEditVeneerDetailsObj, DoorEditGlazingDetailsObj, DoorEditFireRatingDetailsObj, DoorEditJoineryDetailsObj,
  TypInfo;

type
  TEditDoorQuotationDetails = class(TNodePropertiesLink)
  private
    FDoorType: TNodeProperties;
    FFacing: TNodeProperties;
    FDoorPairing: TNodeProperties;
    FDoorOneWidth: TNodeProperties;
    FDoorOneHeight: TNodeProperties;
    FDoorTwoWidth: TNodeProperties;
    FDoorTwoHeight: TNodeProperties;
    FDoorThickness: TNodeProperties;
    FBasicDoorCost: TNodeProperties;
    FDoorCost: TNodeProperties;
    FSimilarDoorsNum: TNodeProperties;
    FSpecialFinish: TNodeProperties;
    FWrapDoors: TNodeProperties;
    FFinishCostExtra: TNodeProperties;
    Fspecialfinishcost: TNodeProperties;
    FManualPrice: TNodeProperties;
    FPlysealCoatsNum: TNodeProperties;
    FPlysealCoatsCost: TNodeProperties;
    FDeliveryCharge: TNodeProperties;
    FProfitAdded: TNodeProperties;
    FWrapDoorsCost: TNodeProperties;
    FFireRating:  TNodeProperties;
    FThickerDoorsAddCost: TNodeProperties;
    FDoorTypesRefs: TNodeProperties;
    FDoorPlacement: TNodeProperties;
    FSummaryCost: TNodeProperties;
    FTotalCost: TNodeProperties;
    FOverPanelDetails: TOverPanelDetails;
    FLippingsStilesDetails: TLippingsStilesDetails;
    FLaminatedFacesDetails: TLaminatedFacesDetails;
    FVeneerDetails: TVeneerDetails;
    FGlazingDetails: TGlazingDetails;
    FFireRatingDetails: TFireRatingDetails;
    FJoineryDetails: TJoineryDetails;
  protected
    procedure AssignItemType; override;
    function GetFinishCost(const FinishType: string): Double;
    function getDoorPair :Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure PerformCalculations; override;
    function GetTotalCost: Double; override;
    procedure SetDoorsProps;
    Property DoorPair :Integer  Read getDoorPair;
  published
    property DoorType: TNodeProperties read FDoorType write FDoorType;
    property Facing: TNodeProperties read FFacing write FFacing;
    property DoorPairing: TNodeProperties read FDoorPairing write FDoorPairing;
    property DoorOneWidth: TNodeProperties read FDoorOneWidth write FDoorOneWidth;
    property DoorOneHeight: TNodeProperties read FDoorOneHeight write FDoorOneHeight;
    property DoorTwoWidth: TNodeProperties read FDoorTwoWidth write FDoorTwoWidth;
    property DoorTwoHeight: TNodeProperties read FDoorTwoHeight write FDoorTwoHeight;
    property DoorThickness: TNodeProperties read FDoorThickness write FDoorThickness;
    property BasicDoorCost: TNodeProperties read FBasicDoorCost write FBasicDoorCost;
    property DoorCost: TNodeProperties read FDoorCost write FDoorCost;
    property SimilarDoorsNum: TNodeProperties read FSimilarDoorsNum write FSimilarDoorsNum;
    property SpecialFinish: TNodeProperties read FSpecialFinish write FSpecialFinish;
    property WrapDoors: TNodeProperties read FWrapDoors write FWrapDoors;
    property FinishCostExtra: TNodeProperties read FFinishCostExtra write FFinishCostExtra;
    property specialfinishcost: TNodeProperties read Fspecialfinishcost write Fspecialfinishcost;
    property ManualPrice: TNodeProperties read FManualPrice write FManualPrice;
    property PlysealCoatsNum: TNodeProperties read FPlysealCoatsNum write FPlysealCoatsNum;
    property PlysealCoatsCost: TNodeProperties read FPlysealCoatsCost write FPlysealCoatsCost;
    property DeliveryCharge: TNodeProperties read FDeliveryCharge write FDeliveryCharge;
    property ProfitAdded: TNodeProperties read FProfitAdded write FProfitAdded;
    property WrapDoorsCost: TNodeProperties read FWrapDoorsCost write FWrapDoorsCost;
    property FireRating: TNodeProperties read FFireRating write FFireRating;
    property ThickerDoorsAddCost: TNodeProperties read FThickerDoorsAddCost write FThickerDoorsAddCost;
    property DoorTypesRefs: TNodeProperties read FDoorTypesRefs write FDoorTypesRefs;
    property DoorPlacement: TNodeProperties read FDoorPlacement write FDoorPlacement;
    property SummaryCost: TNodeProperties read FSummaryCost write FSummaryCost;
    property TotalCost: TNodeProperties read FTotalCost write FTotalCost;
    property OverPanelDetails: TOverPanelDetails read FOverPanelDetails write FOverPanelDetails;
    property LippingsStilesDetails: TLippingsStilesDetails read FLippingsStilesDetails write FLippingsStilesDetails;
    property LaminatedFacesDetails: TLaminatedFacesDetails read FLaminatedFacesDetails write FLaminatedFacesDetails;
    property VeneerDetails: TVeneerDetails read FVeneerDetails write FVeneerDetails;
    property GlazingDetails: TGlazingDetails read FGlazingDetails write FGlazingDetails;
    property FireRatingDetails: TFireRatingDetails read FFireRatingDetails write FFireRatingDetails;
    property JoineryDetails: TJoineryDetails read FJoineryDetails write FJoineryDetails;
  end;

implementation

uses
  DoorsLib, CommonDbLib, FastFuncs, CommonLib;

{ TEditDoorQuotationDetails }

constructor TEditDoorQuotationDetails.Create(AOwner: TComponent);
begin
  inherited;
  Doors := TDoors.Create;
  FOverPanelDetails := TOverPanelDetails.Create(self);
  FLippingsStilesDetails := TLippingsStilesDetails.Create(self);
  FLaminatedFacesDetails := TLaminatedFacesDetails.Create(self);
  FVeneerDetails := TVeneerDetails.Create(self);
  FGlazingDetails := TGlazingDetails.Create(self);
  FFireRatingDetails := TFireRatingDetails.Create(self);
  FJoineryDetails := TJoineryDetails.Create(self);
end;

destructor TEditDoorQuotationDetails.Destroy;
begin
  FreeAndNil(FOverPanelDetails);
  FreeAndNil(FLippingsStilesDetails);
  FreeAndNil(FLaminatedFacesDetails);
  FreeAndNil(FVeneerDetails);
  FreeAndNil(FGlazingDetails);
  FreeAndNil(FFireRatingDetails);
  FreeAndNil(FJoineryDetails);
  FreeAndNil(Doors);
  inherited;
end;

function TEditDoorQuotationDetails.getDoorPair :Integer;
begin
    REsult := StrToIntDef(DoorPairing.Value, -1);
end;
function TEditDoorQuotationDetails.GetFinishCost(const FinishType: string): Double;
var
  qryFinish: TERPQuery;
begin
  Result := 0;
  qryFinish := TERPQuery.Create(nil);

  try
    qryFinish.Connection := GetSharedMyDacConnection;
    qryFinish.SQL.Text := 'SELECT * FROM vwDoorFinishList WHERE FinishName = ' + QuotedStr(FinishType);
    qryFinish.Open;

    if not qryFinish.IsEmpty then
      Result := qryFinish.FieldByName('Cost').AsFloat;
  finally
    FreeAndNil(qryFinish);
  end;
end;

procedure TEditDoorQuotationDetails.AssignItemType;
begin
  inherited;
  ItemType := 'EditDoorQuotationDetails';
end;

procedure TEditDoorQuotationDetails.PerformCalculations;
var
  Ans: string;
  TmpCost: Double;
  DoorWidth: Integer;
  DoorHeight: Integer;
  BasicCost: Double;
  PlysealCost: Double;
  ThicknessCost: Double;
  WrapCost: Double;
  SpecialCost : Double;
  DelCharge: Double;
  DoorFactor: Integer;
begin
  inherited;
  SetDoorsProps;
  TmpCost := StrToFloatDef(SummaryCost.Value, 0);
  DoorWidth := StrToIntDef(DoorOneWidth.Value, 0);
  DoorHeight := StrToIntDef(DoorOneHeight.Value, 0);
  Ans := Doors.DoorTypeQueryQt(DoorWidth, DoorHeight);
  if FastFuncs.SameText(Curnodename , 'WrapDoors') then
    if WrapDoors.Value = 'T' then
         WrapDoorsCost.Value :=  FloattoStr(doors.GetSundryCost('B1'))
    else WrapDoorsCost.Value :=  '0';

  if FastFuncs.SameText(ManualPrice.Value, 'F') and (DoorWidth > 0) and (DoorHeight > 0) then begin
    BasicCost := 0;

    case StrToIntDef(DoorPairing.Value, -1) of
      0:
      begin
        BasicCost := Doors.GetNewDoorCost(Ans, DoorWidth, DoorHeight);
        BasicCost := BasicCost + Doors.LabourCost + Doors.SundriesCost;
      end;
      1:
      begin
        if Empty(DoorTwoWidth.Value)    then  DoorTwoWidth.Value := DoorOneWidth.Value;
        if Empty(DoorTwoHeight.Value)   then  DoorTwoHeight.Value := DoorOneHeight.Value;
        BasicCost := Doors.GetNewDoorCost(Ans, DoorWidth, DoorHeight);
        BasicCost := (BasicCost + Doors.LabourCost + Doors.SundriesCost) * 2;
      end;
      2:
      begin
        if (DoorWidth > 0) and (DoorHeight > 0) then begin
          BasicCost := Doors.GetNewDoorCost(Ans, DoorWidth, DoorHeight);
          DoorWidth := StrToIntDef(DoorTwoWidth.Value, 0);
          DoorHeight := StrToIntDef(DoorTwoHeight.Value, 0);
          BasicCost := BasicCost + Doors.GetNewDoorCost(Ans, DoorWidth, DoorHeight);
        end;
      end;
    end;

    Doorthickness.value := Fastfuncs.IntToStr(doors.doorthickness);
    if FastFuncs.SameText(DoorPairing.Value, '0') then
      DoorFactor := 1
    else
      DoorFactor := 2;
    if FastFuncs.SameText(curnodename , 'DoorPairing') then begin
        if DoorFactor = 2 then begin
            ThickerDoorsAddCost.Value   := Format('%.2f',[StrToFloatDef(ThickerDoorsAddCost.Value,0) *2]);
            WrapDoorsCost.Value         := Format('%.2f',[StrToFloatDef(WrapDoorsCost.Value,0) *2]);
            DeliveryCharge.Value        := Format('%.2f',[StrToFloatDef(DeliveryCharge.Value,0) *2]);
            ProfitAdded.Value           := Format('%.2f',[StrToFloatDef(ProfitAdded.Value,0) *2]);
        end else begin
            ThickerDoorsAddCost.Value   := Format('%.2f',[StrToFloatDef(ThickerDoorsAddCost.Value,0) /2]);
            WrapDoorsCost.Value         := Format('%.2f',[StrToFloatDef(WrapDoorsCost.Value,0) /2]);
            DeliveryCharge.Value        := Format('%.2f',[StrToFloatDef(DeliveryCharge.Value,0) /2]);
            ProfitAdded.Value           := Format('%.2f',[StrToFloatDef(ProfitAdded.Value,0) /2]);
        end;
    end;
    //PlysealCoatsCost.Value := Format('%.2f', [GetFinishCost(SpecialFinish.Value) * StrToFloatDef(PlysealCoatsNum.Value, 0) * DoorFactor]);
    DoorCost.Value      := FloatToStr(BasicCost);
    PlysealCost         := StrToFloatDef(PlysealCoatsCost.Value, 0) * StrToFloatDef(PlysealCoatsNum.Value, 0);
    ThicknessCost       := StrToFloatDef(ThickerDoorsAddCost.Value, 0);
    WrapCost            := StrToFloatDef(WrapDoorsCost.Value, 0);
    SpecialCost         := StrtofloatDEf(specialfinishcost.Value , 0);
    BasicCost           := BasicCost + TmpCost + PlysealCost + ThicknessCost + WrapCost + specialcost;
    BasicDoorCost.Value := FloatToStr(BasicCost);
  end else BasicCost    := StrToFloatDef(DoorCost.Value, 0);

  DelCharge           := StrToFloatDef(DeliveryCharge.Value, 0);
  BasicCost             := Basiccost+ DelCharge;
  BasicCost             := Basiccost * (1 + StrToFloatDef(ProfitAdded.Value, 0) / 100);
  TotalCost.Value       := FloatToStr(Basiccost);
end;

procedure TEditDoorQuotationDetails.SetDoorsProps;
begin
  Doors.DoorType := DoorType.Value;
  Doors.Facing := Facing.Value;
  Doors.DoorOneWidth := StrToIntDef(DoorOneWidth.Value, 0);
  Doors.DoorOneHeight := StrToIntDef(DoorOneHeight.Value, 0);
  Doors.DoorTwoWidth := StrToIntDef(DoorTwoWidth.Value, 0);
  Doors.DoorTwoHeight := StrToIntDef(DoorTwoHeight.Value, 0);
  Doors.DoorPairing := StrToIntDef(DoorPairing.Value, 0);
  Doors.DoorThickness := StrToIntDef(DoorThickness.Value, 0);
  Doors.DoorPlacement := StrToIntDef(DoorPlacement.Value, 0);
end;

function TEditDoorQuotationDetails.GetTotalCost: Double;
begin
  Result := inherited GetTotalCost + StrToFloatDef(TotalCost.Value, 0);
end;

initialization
  RegisterClassOnce(TEditDoorQuotationDetails);
end.
