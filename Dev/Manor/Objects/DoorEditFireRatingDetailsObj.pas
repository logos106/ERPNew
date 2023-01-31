unit DoorEditFireRatingDetailsObj;

interface

uses
  Classes, NodePropertiesLink, MyAccess,ERPdbComponents, SysUtils,DoorEditBaseObject;

const
  cMaxStripPosList = 4;
  cStripPositionList: array[0..cMaxStripPosList] of string = ('All Door Edges',
                                                              'Door Width',
                                                              'Door Height',
                                                              'Door Mtg Stile',
                                                              'Door Hanging Stile');

type
  TFireRatingDetails = class(TDoorEditBaseObj)
  private
    FGroovePlacement: TNodeProperties;
    FGrooveLocation: TNodeProperties;
    FGrooveDoorMeetingStile: TNodeProperties;
    FGrooveOverPanelRail: TNodeProperties;
    FGrooveOverPanelTopRail: TNodeProperties;
    FGrooveOverPanelStile: TNodeProperties;
    FGrooveCostDoorPrice: TNodeProperties;
    FIntumStripProvided: TNodeProperties;
    FIntumStripDoorPrice: TNodeProperties;
    FGrooveCost: TNodeProperties;
    FFireRatingCost: TNodeProperties;
    FStripPosition: TNodePropertiesList;
    FOverPanelRail: TNodePropertiesList;
    FOverPanelTopRail: TNodePropertiesList;
    FOverPanelStile: TNodePropertiesList;
    FStripConcealed: TNodePropertiesList;
    FStripConcealedCost: TNodePropertiesList;
    FStripLength: TNodePropertiesList;
    FStripCost: TNodePropertiesList;
    FStripTotalCost: TNodePropertiesList;
    FStripQuantity: TNodePropertiesList;
    FMeetingStileNumber: TNodePropertiesList;
    FStripDescription: TNodePropertiesList;
    procedure ItumStripLength(const ListIndex: Integer);
    function ItumStripLengthCalc(const ISLength, ISLengthRequired: Double): Double;
  protected
    procedure AssignItemType; override;
  public
    procedure PerformCalculations; override;
    function GetTotalCost: Double; override;
  published
    property GroovePlacement: TNodeProperties read FGroovePlacement write FGroovePlacement;
    property GrooveLocation: TNodeProperties read FGrooveLocation write FGrooveLocation;
    property GrooveDoorMeetingStile: TNodeProperties read FGrooveDoorMeetingStile write FGrooveDoorMeetingStile;
    property GrooveOverPanelRail: TNodeProperties read FGrooveOverPanelRail write FGrooveOverPanelRail;
    property GrooveOverPanelTopRail: TNodeProperties read FGrooveOverPanelTopRail write FGrooveOverPanelTopRail;
    property GrooveOverPanelStile: TNodeProperties read FGrooveOverPanelStile write FGrooveOverPanelStile;
    property GrooveCostDoorPrice: TNodeProperties read FGrooveCostDoorPrice write FGrooveCostDoorPrice;
    property IntumStripProvided: TNodeProperties read FIntumStripProvided write FIntumStripProvided;
    property IntumStripDoorPrice: TNodeProperties read FIntumStripDoorPrice write FIntumStripDoorPrice;
    property GrooveCost: TNodeProperties read FGrooveCost write FGrooveCost;
    property FireRatingCost: TNodeProperties read FFireRatingCost write FFireRatingCost;
    property StripPosition: TNodePropertiesList read FStripPosition write FStripPosition;
    property OverPanelRail: TNodePropertiesList read FOverPanelRail write FOverPanelRail;
    property OverPanelTopRail: TNodePropertiesList read FOverPanelTopRail write FOverPanelTopRail;
    property OverPanelStile: TNodePropertiesList read FOverPanelStile write FOverPanelStile;

    property StripConcealed: TNodePropertiesList read FStripConcealed write FStripConcealed;
    property StripConcealedCost: TNodePropertiesList read FStripConcealedCost write FStripConcealedCost;
    property StripLength: TNodePropertiesList read FStripLength write FStripLength;
    property StripCost: TNodePropertiesList read FStripCost write FStripCost;
    property StripTotalCost: TNodePropertiesList read FStripTotalCost write FStripTotalCost;
    property StripQuantity: TNodePropertiesList read FStripQuantity write FStripQuantity;
    property MeetingStileNumber: TNodePropertiesList read FMeetingStileNumber write FMeetingStileNumber;
    property StripDescription: TNodePropertiesList read FStripDescription write FStripDescription;
  end;

implementation

uses
  DoorsLib, CommonLib, FastFuncs;

{ TFireRatingDetails }

procedure TFireRatingDetails.AssignItemType;
begin
  inherited;
  ItemType := 'FireRatingDetails';
end;

procedure TFireRatingDetails.ItumStripLength(const ListIndex: Integer);
var
  StripPosIndex: Integer;
  ISLength: Double;
  TmpAmount: Double;
  ConcealedCost: Double;
  MSNumber: Integer;
  totalCost :Double;
begin
    StripPosIndex := 0;
    ISLength := 0;
    MSNumber := StrToIntDef(MeetingStileNumber[ListIndex].Value, 0);
    if MSNumber = 0 then MSNumber := 1;

    if StripConcealed[ListIndex].Value = 'T' then begin
        TmpAmount := Doors.GetSundryCost('CO1');
        ConcealedCost := TmpAmount;
        if Doors.OverPanelType = 1 then
            ConcealedCost := TmpAmount * 2;
        StripConcealedCost[ListIndex].Value := FloatToStr(ConcealedCost);
  end  else
        StripConcealedCost[ListIndex].Value := '0.00';

  while (StripPosIndex <= cMaxStripPosList) and (cStripPositionList[StripPosIndex] <> StripPosition[ListIndex].Value) do
    Inc(StripPosIndex);
    case StripPosIndex of
        0:begin
            ISLength :=(Doors.DoorOneHeight * 2) + Doors.DoorOneWidth;
            if Doors.DoorPairing = 1 then
                ISLength :=ISLength +(Doors.DoortwoHeight * 2) + Doors.DoortwoWidth;
          end;
        1:begin
            ISLength :=Doors.DoorOneWidth ;
            if Doors.DoorPairing = 1 then
                ISLength :=ISLength +Doors.DoortwoWidth;
          end;
        3:begin
            ISLength :=Doors.DoorOneHeight ;
            if Doors.DoorPairing = 1 then
                ISLength :=ISLength +Doors.DoortwoHeight;
            ISLength := ISLength * MSNumber;
          end;
        4, 2:begin
            ISLength :=Doors.DoorOneHeight ;
            if Doors.DoorPairing = 1 then
                ISLength :=ISLength +Doors.DoortwoHeight;
          end;
        end;
    ISLength := ISLength / 1000;
    totalCost := ISLength *StrToFloatDef(StripCost[ListIndex].Value, 0);

    if (OverPanelTopRail[ListIndex].Value = 'T') or (OverPanelRail[ListIndex].Value = 'T') then begin
        ISLength :=Doors.OverPanelOneWidth;
        if Doors.OverPanelType > 1 then
            ISLength :=ISLength+Doors.OverPanelTwoWidth;
        ISLength := ISLength / 1000;
        totalCost := totalCost + ISLength*StrToFloatDef(StripCost[ListIndex].Value, 0);
    end;

    if OverPanelStile[ListIndex].Value = 'T' then begin
        ISLength :=Doors.OverPanelOneHeight*2;
        if Doors.OverPanelType > 1 then
            ISLength :=ISLength+Doors.OverPaneltwoHeight*2;
        ISLength := ISLength / 1000;
        totalCost := totalCost + ISLength*StrToFloatDef(StripCost[ListIndex].Value, 0);
    end;
    if StripConcealed[ListIndex].Value = 'T' then
        totalCost := totalCost + StrToFloatDef(StripConcealedCost[ListIndex].Value,0);
    StripTotalCost[ListIndex].Value := FloatToStr(totalCost);

  StripQuantity[ListIndex].Value := FloatToStr(ItumStripLengthCalc(StrToFloatDef(StripLength[ListIndex].Value, 0), ISLength));
end;

function TFireRatingDetails.ItumStripLengthCalc(const ISLength, ISLengthRequired: Double): Double;
var
  TmpLength: Double;
  TmpAmount: Double;
  ChkAmount: Double;
begin
  TmpLength := ISLengthRequired * 1000 / 2100;
  TmpAmount := Trunc(TmpLength);
  ChkAmount := TmpLength - TmpAmount;

  if ChkAmount = 0 then
    Result := TmpAmount
  else if ChkAmount <= 0.5 then
    Result := TmpAmount + 0.5
  else
    Result := TmpAmount + 1;
end;

procedure TFireRatingDetails.PerformCalculations;
var
  Index: Integer;
  TotalCost:  Double;
  tmpcost:  Double;
begin
  inherited;
  if FastFuncs.SameText(curnodename , 'GrooveCostDoorPrice') then begin
        if GrooveCostDoorPrice.value='T' then begin
            tmpcost := doors.getSundrycost('GR1');
            tmpcost := tmpcost *(doors.dooroneheight/1000)*2 + (doors.dooronewidth/1000) ;
            if Doors.DoorPairing <> 0 then
                tmpcost := tmpcost + (doors.doortwoheight/1000)*2 + (doors.doortwowidth/1000) ;
        end else tmpCost := 0;
        groovecost.Value := FloatToStr(tmpcost);
  end;
  TotalCost := 0;

  if (IntumStripProvided.Value = 'T') and (IntumStripDoorPrice.Value = 'T') then begin
    for Index := 0 to StripTotalCost.NodePropsCount - 1 do begin
      ItumStripLength(Index);
      TotalCost := TotalCost + StrToFloatDef(StripTotalCost[Index].Value, 0) ;
    end;
  end;
  if GrooveCostDoorPrice.value = 'T' then
    TotalCost := TotalCost + StrToFloatDef(GrooveCost.Value, 0);
  FireRatingCost.Value := FloatToStr(TotalCost);
end;

function TFireRatingDetails.GetTotalCost: Double;
begin
  Result := inherited GetTotalCost + StrToFloatDef(FireRatingCost.Value, 0);
end;

initialization
  RegisterClassOnce(TFireRatingDetails);
end.

