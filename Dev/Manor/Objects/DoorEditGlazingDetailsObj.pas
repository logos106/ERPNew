unit DoorEditGlazingDetailsObj;

interface

uses
  Classes, NodePropertiesLink, MyAccess,ERPdbComponents, SysUtils,DoorEditBaseObject;

type
  TGlazingDetails = class(TDoorEditBaseObj)
  private
    FOpeningType: TNodeProperties;
    FPanelNumberLeafOne: TNodeProperties;
    FPanelNumberLeafTwo: TNodeProperties;
    FGlassRequired: TNodeProperties;
    FGlazingBeads: TNodeProperties;
    FBrassCapsAndScrews: TNodeProperties;
    FGlazingExtraOver: TNodeProperties;
    FGlazingSystem: TNodeProperties;
    FStainAndVarnish: TNodeProperties;
    FAdditionalInstructions: TNodeProperties;
    FBeading: TNodeProperties;
    FBeadingCost: TNodeProperties;
    FSpecialDescription: TNodeProperties;
    FGlassDetails :TNodeProperties;
    FLumpSumCost: TNodeProperties;
    FTotalCost: TNodeProperties;
    FLeafNumber: TNodePropertiesList;
    FVisionPanelNumber: TNodePropertiesList;
    FWidth: TNodePropertiesList;
    FHeight: TNodePropertiesList;
    FSideMargin: TNodePropertiesList;
    FTopMargin: TNodePropertiesList;
    FBottomMargin: TNodePropertiesList;
    FVerticalMargin: TNodePropertiesList;
    FGlazingPosition: TNodePropertiesList;
    FComments: TNodePropertiesList;
  protected
    procedure AssignItemType; override;
  public
    procedure PerformCalculations; override;
    function GetTotalCost: Double; override;
  published
    property OpeningType: TNodeProperties read FOpeningType write FOpeningType;
    property PanelNumberLeafOne: TNodeProperties read FPanelNumberLeafOne write FPanelNumberLeafOne;
    property PanelNumberLeafTwo: TNodeProperties read FPanelNumberLeafTwo write FPanelNumberLeafTwo;
    property GlassRequired: TNodeProperties read FGlassRequired write FGlassRequired;
    property GlazingBeads: TNodeProperties read FGlazingBeads write FGlazingBeads;
    property BrassCapsAndScrews: TNodeProperties read FBrassCapsAndScrews write FBrassCapsAndScrews;
    property GlazingExtraOver: TNodeProperties read FGlazingExtraOver write FGlazingExtraOver;
    property GlazingSystem: TNodeProperties read FGlazingSystem write FGlazingSystem;
    property StainAndVarnish: TNodeProperties read FStainAndVarnish write FStainAndVarnish;
    property AdditionalInstructions: TNodeProperties read FAdditionalInstructions write FAdditionalInstructions;
    property Beading: TNodeProperties read FBeading write FBeading;
    property BeadingCost: TNodeProperties read FBeadingCost write FBeadingCost;
    property SpecialDescription: TNodeProperties read FSpecialDescription write FSpecialDescription;
    Property GlassDetails      : TnodeProperties Read fGlassDetails Write fGlassDetails;
    property LumpSumCost: TNodeProperties read FLumpSumCost write FLumpSumCost;
    property TotalCost: TNodeProperties read FTotalCost write FTotalCost;
    property LeafNumber: TNodePropertiesList read FLeafNumber write FLeafNumber;
    property VisionPanelNumber: TNodePropertiesList read FVisionPanelNumber write FVisionPanelNumber;
    property Width: TNodePropertiesList read FWidth write FWidth;
    property Height: TNodePropertiesList read FHeight write FHeight;
    property SideMargin: TNodePropertiesList read FSideMargin write FSideMargin;
    property TopMargin: TNodePropertiesList read FTopMargin write FTopMargin;
    property BottomMargin: TNodePropertiesList read FBottomMargin write FBottomMargin;
    property VerticalMargin: TNodePropertiesList read FVerticalMargin write FVerticalMargin;
    property GlazingPosition: TNodePropertiesList read FGlazingPosition write FGlazingPosition;
    property Comments: TNodePropertiesList read FComments write FComments;
  end;

implementation

uses
  DoorsLib, CommonLib, FastFuncs;

const
  cCircular = 0;
  cRectangle = 1;
  cSpecial = 2;

{ TGlazingDetails }

procedure TGlazingDetails.AssignItemType;
begin
  inherited;
  ItemType := 'GlazingDetails';
end;

function TGlazingDetails.GetTotalCost: Double;
begin
  Result := inherited GetTotalCost + StrToFloatDef(TotalCost.Value, 0);
end;

procedure TGlazingDetails.PerformCalculations;
var
    Tmpcost :Double;
  i:Integer;
  s:String;
begin

(*var
  Index: Integer;
  PanelNumber: Integer;
  PanelCost: Double;
  SumCost: Double;
  BrassCapsScrewsCost: Double;
  StainAndVarnishCost: Double;
  TmpCost: Double;
  LabCost: Double;
  BlocCost: Double;
  i:Integer;
  s:String;
  CutOutCost : double;
begin
  inherited;

    SumCost               :=0;
    BrassCapsScrewsCost   :=0;
    StainAndVarnishCost   :=0;
    TmpCost               :=0;
    LabCost               :=0;
    BlocCost              :=0;

    {beading cost}
    if (FastFuncs.SameText(curnodename , 'OpeningType')) or
        (FastFuncs.SameText(curnodename , 'GlazingSystem')) or
        (FastFuncs.SameText(curnodename , 'GlazingBeads')) or
        (FastFuncs.SameText(curnodename , 'Beading')) then begin

        s :='SELECT min(GlazingCost) as GlazingCost FROM vwdoorglazinglist' +
            ' where GlazingType = ' + QuotedStr(GlazingSystem.Value) ;
                  if OpeningType.value = '0' then s := s + ' and GlazingShape = "Circular"'
             else if OpeningType.value = '1' then s := s + ' and GlazingShape = "Square"'
             else if OpeningType.value = '2' then s := s + ' and GlazingShape = "Special"';

             if GlazingBeads.value = 'T'     then
                    s := s + ' and GlazingMats  = '+quotedstr(Beading.value)
             else   s := s + ' and GlazingMats = ""';

        With TERPQuery(getnewDataset(s)) do try
            BeadingCost.value  := fieldByname('GlazingCost').asString;
        finally
            if Active then close;
            Free;
        end;
    end;

    {cutoutcost}
    CutOutCost := Doors.GetSundryCost('G2'+doors.doortype);

    if Doors.DoorPairing = 0 then
        PanelNumber := StrToIntDef(PanelNumberLeafOne.Value, 0)
    else
        PanelNumber := StrToIntDef(PanelNumberLeafOne.Value, 0) + StrToIntDef(PanelNumberLeafTwo.Value, 0);
    CutOutCost := CutOutCost *PanelNumber;

    {StainAndVarnishCost}
    if StainAndVarnish.Value = 'T' then
        StainAndVarnishCost := Doors.GetSundryCost('GC2');

    {BrassCapsScrewsCost}
    if PanelNumber > 0 then begin
        if BrassCapsAndScrews.Value = 'T' then
            BrassCapsScrewsCost := Doors.GetSundryCost('GC3');

    case StrToIntDef(OpeningType.Value, 0) of
        cCircular: begin
            if GlazingBeads.Value = 'T' then begin
                for Index := 1 to PanelNumber do begin
                    PanelCost := Doors.GetGlazingCost('Circular', Width[Index - 1].Value);
                    SumCost := SumCost + PanelCost;
                end;
            end;

            LabCost := Doors.GetSundryCost('GC1');

            if Doors.DoorThickness <= 40 then
                BlocCost := Doors.GetSundryCost('GC3');
        end;

      cRectangle: begin
        end;

      cSpecial: begin
        end;
    end;

    TmpCost := ((LabCost + BrassCapsScrewsCost + StainAndVarnishCost + BlocCost) * PanelNumber) +
                   StrToFloatDef(LumpSumCost.Value, 0) + SumCost + StrToFloatDef(BeadingCost.Value, 0) +CutOutCost;

    for i := 0 to LeafNumber.NodePropsCount-1 do begin
        TmpCost := TmpCost + ((StrToFloatDef(width.NodeProps[i].Value ,0)/1000) + 0.05 +
                              (StrToFloatDef(Height.NodeProps[i].Value,0)/1000) + 0.05) * 4 * StrToFloatDef(BeadingCost.value,0);
    end;
  end;*)

   {beading cost}
    if (SameTExt(curnodename , 'OpeningType')) or
        (Sametext(curnodename , 'GlazingSystem')) or
        (Sametext(curnodename , 'GlazingBeads')) or
        (SameText(curnodename , 'Beading')) then begin

        s :='SELECT min(GlazingCost) as GlazingCost FROM vwdoorglazinglist' +
            ' where GlazingType = ' + QuotedStr(GlazingSystem.Value) ;
                  if OpeningType.value = '0' then s := s + ' and GlazingShape = "Circular"'
             else if OpeningType.value = '1' then s := s + ' and GlazingShape = "Square"'
             else if OpeningType.value = '2' then s := s + ' and GlazingShape = "Special"';

             if GlazingBeads.value = 'T'     then
                    s := s + ' and GlazingMats  = '+quotedstr(Beading.value)
             else   s := s + ' and GlazingMats = ""';

        With TERPQuery(getnewDataset(s)) do try
            BeadingCost.value  := fieldByname('GlazingCost').asString;
        finally
            if Active then close;
            Free;
        end;
    end;
    Tmpcost := 0;
    for i := 0 to LeafNumber.NodePropsCount-1 do begin
        TmpCost := TmpCost + (((StrToFloatDef(width.NodeProps[i].Value ,0) + StrToFloatDef(Height.NodeProps[i].Value,0))*2));
    end;
    TmpCost := TmpCost /1000 ;
    TmpCost := TmpCost * StrToFloatDef(BeadingCost.value,0);

    TmpCost := TmpCost + (Doors.GetSundryCost('G2'+doors.doortype)*LeafNumber.NodePropsCount);
    TmpCost := TmpCost + StrToFloatDef(LumpSumCost.Value, 0);
  TotalCost.Value := FloatToStr(TmpCost);
end;

initialization
  RegisterClassOnce(TGlazingDetails);
end.

