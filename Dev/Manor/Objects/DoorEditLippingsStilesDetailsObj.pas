unit DoorEditLippingsStilesDetailsObj;

interface

uses
  Classes, NodePropertiesLink, MyAccess,ERPdbComponents, SysUtils,DoorEditBaseObject,
  Dialogs;

type
  TLippingsStilesDetails = class(TDoorEditBaseObj)
  private
    FEdgeNumber: TNodeProperties;
    FStileType: TNodeProperties;
    FLippingThickness: TNodeProperties;
    FLippingType: TNodeProperties;
    FLippingCost: TNodeProperties;
    FHanding: TNodeProperties;
    FSpecialLippingInstructions: TNodeProperties;
    FLippingMaterialCost: TNodeProperties;
    FMaterialLabourCost: TNodeProperties;
    FTotalLippingStileCost: TNodeProperties;
    FAllStiles: TNodeProperties;
    FRebateSize: TNodeProperties;
    FStileLippingThickness: TNodeProperties;
    FStileLippingType: TNodeProperties;
    FStileLippingCost: TNodeProperties;
    FOPStileHeight: Boolean;
    FMeetHanging: Boolean;
    (*function RoundRun(const Value: Double): Double;*)
    procedure CalcLippingMaterialcost;
    procedure CalcMaterialLabourCost;
  protected
    procedure AssignItemType; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure PerformCalculations; override;
    function GetTotalCost: Double; override;
  published
    property EdgeNumber: TNodeProperties read FEdgeNumber write FEdgeNumber;
    property StileType: TNodeProperties read FStileType write FStileType;
    property LippingThickness: TNodeProperties read FLippingThickness write FLippingThickness;
    property LippingType: TNodeProperties read FLippingType write FLippingType;
    property LippingCost: TNodeProperties read FLippingCost write FLippingCost;
    property Handing: TNodeProperties read FHanding write FHanding;
    property SpecialLippingInstructions: TNodeProperties read FSpecialLippingInstructions write FSpecialLippingInstructions;
    property LippingMaterialCost: TNodeProperties read FLippingMaterialCost write FLippingMaterialCost;
    property MaterialLabourCost: TNodeProperties read FMaterialLabourCost write FMaterialLabourCost;
    property TotalLippingStileCost: TNodeProperties read FTotalLippingStileCost write FTotalLippingStileCost;
    property AllStiles: TNodeProperties read FAllStiles write FAllStiles;
    property RebateSize: TNodeProperties read FRebateSize write FRebateSize;
    property StileLippingThickness: TNodeProperties read FStileLippingThickness write FStileLippingThickness;
    property StileLippingType: TNodeProperties read FStileLippingType write FStileLippingType;
    property StileLippingCost: TNodeProperties read FStileLippingCost write FStileLippingCost;
  end;

implementation

uses
  DoorsLib, FastFuncs, CommonLib;

{ TLippingsStilesDetails }

constructor TLippingsStilesDetails.Create(AOwner: TComponent);
begin
  inherited;
  FOPStileHeight := False;
  FMeetHanging := False;
end;

procedure TLippingsStilesDetails.AssignItemType;
begin
  inherited;
  ItemType := 'LippingsStilesDetails';
end;

(*function TLippingsStilesDetails.RoundRun(const Value: Double): Double;
var
  TmpRun: Double;
begin
  TmpRun := Value / 2135.0;
  Result := Trunc(TmpRun);

  if (TmpRun - Result) > 0 then begin
    if (TmpRun - Result) <= 0.5 then
      Result := Result + 0.5
    else
      Result := Result + 1;
  end;
end;*)

procedure TLippingsStilesDetails.CalcLippingMaterialcost;
var
    iEdgeNumber :Integer;
    tmpcost :Double;
begin

    {maureen 07-03-2008
    got just 1 formula for 'Lipping material Cost' for 'Edges 3 or 4'.
    assuming that this means the Door pairing is irrelevant for this calculation,
    And also the 'Lipping material cost' is 0 if edges are 1 or 2 }

    TmpCost     := 0;
    iEdgeNumber := StrTointDef(EdgeNumber.Value , -1);
    if iEdgeNumber in [2,3] then Tmpcost := strTofloatDef(LippingCost.value , 0) * 3;
    LippingMaterialCost.Value := FloatToStr(Tmpcost);
(*var
  RunHeight: Double;
  RunWidth: Double;
  OPRunHeight: Double;
  OPRunWidth: Double;
  LongEdge: Double;
  ShortEdge: Double;
  TotalCost: Double;
begin
  RunWidth := 0;
  LongEdge := 0;
  ShortEdge := 0;


  RunHeight := RoundRun(Doors.DoorOneHeight);

  if StrToIntDef(EdgeNumber.Value, 0) > 1 then
    RunWidth := RoundRun(Doors.DoorOneWidth + Doors.DoorTwoWidth);

  case StrToIntDef(EdgeNumber.Value, 0) of
    0:
    begin
      if Doors.DoorPairing = 0 then
        TotalCost := RunHeight * StrToFloatDef(LippingCost.Value, 0)
      else
        TotalCost := RunHeight * StrToFloatDef(LippingCost.Value, 0) * 2;
    end;

    1:
    begin
      case StrToIntDef(StileType.Value, 0) of
        1:
        begin
          if Doors.DoorPairing = 0 then
            TotalCost := RunHeight * (StrToFloatDef(LippingCost.Value, 0) + StrToFloatDef(StileLippingCost.Value, 0))
          else
            TotalCost := RunHeight * (StrToFloatDef(LippingCost.Value, 0) + StrToFloatDef(StileLippingCost.Value, 0)) * 2;
        end;

        2:
        begin
          if Doors.DoorPairing = 0 then begin
            if FastFuncs.SameText(AllStiles.Value, 'T') then
              TotalCost := RunHeight * StrToFloatDef(StileLippingCost.Value, 0) * 2
            else
              TotalCost := (RunHeight * StrToFloatDef(LippingCost.Value, 0)) + (StrToFloatDef(StileLippingCost.Value, 0) * 2);
          end
          else begin
            if FastFuncs.SameText(AllStiles.Value, 'T') then
              TotalCost := RunHeight * StrToFloatDef(StileLippingCost.Value, 0) * 4
            else
              TotalCost := ((RunHeight * StrToFloatDef(LippingCost.Value, 0)) + StrToFloatDef(StileLippingCost.Value, 0)) * 2;
          end;
        end;

        else begin
          if Doors.DoorPairing = 0 then
            TotalCost := RunHeight * StrToFloatDef(LippingCost.Value, 0) * 2
          else
            TotalCost := RunHeight * StrToFloatDef(LippingCost.Value, 0) * 4;
        end;
      end;
    end;

    else
    begin
      case StrToIntDef(StileType.Value, 0) of
        1:
        begin
          if Doors.DoorPairing = 0 then
            TotalCost := (RunHeight + RunWidth) * (StrToFloatDef(LippingCost.Value, 0) + (RunHeight * StrToFloatDef(StileLippingCost.Value, 0)))
          else
            TotalCost := (((RunHeight * 2) + RunWidth) * StrToFloatDef(LippingCost.Value, 0)) + (RunHeight * StrToFloatDef(StileLippingCost.Value, 0) * 2);
        end;

        2:
        begin
          if Doors.DoorPairing = 0 then begin
            if FastFuncs.SameText(AllStiles.Value, 'T') then
              TotalCost := (RunHeight * StrToFloatDef(StileLippingCost.Value, 0) * 2) + (RunWidth * StrToFloatDef(LippingCost.Value, 0))
            else
              TotalCost := ((RunHeight + RunWidth) * StrToFloatDef(LippingCost.Value, 0)) + (RunWidth * StrToFloatDef(StileLippingCost.Value, 0));
          end
          else begin
            if FastFuncs.SameText(AllStiles.Value, 'T') then
              TotalCost := (RunHeight * StrToFloatDef(StileLippingCost.Value, 0) * 4) + (RunWidth * StrToFloatDef(LippingCost.Value, 0))
            else
              TotalCost := ((RunHeight * 2) + RunWidth) * StrToFloatDef(LippingCost.Value, 0);
          end;
        end;

        else begin
          if Doors.DoorPairing = 0 then
            TotalCost := ((RunHeight * 2) + RunWidth) * StrToFloatDef(LippingCost.Value, 0)
          else
            TotalCost := ((RunHeight * 4) + RunWidth) * StrToFloatDef(LippingCost.Value, 0);
        end;
      end;
    end;

  end;

  if Doors.OverPanelOneWidth > 0 then begin
    OPRunHeight := RoundRun(Doors.OverPanelOneHeight);
    OPRunWidth := RoundRun(Doors.OverPanelOneWidth);

    case StrToIntDef(EdgeNumber.Value, 0) of
      0:
      begin
        if Doors.OverPanelTwoWidth <= 0 then
          LongEdge := LongEdge + 1
        else
          LongEdge := LongEdge + 2;

        TotalCost := TotalCost + (OPRunHeight * StrToFloatDef(LippingCost.Value, 0));
      end;

      1:
      begin
        if Doors.OverPanelTwoWidth <= 0 then
          LongEdge := LongEdge + 2
        else
          LongEdge := LongEdge + 4;

        if not FOPStileHeight then
          TotalCost := TotalCost + (OPRunHeight * LongEdge * StrToFloatDef(LippingCost.Value, 0))
        else
          TotalCost := TotalCost + (OPRunHeight * LongEdge * StrToFloatDef(LippingCost.Value, 0) / 2);
      end;

      2:
      begin
        if Doors.OverPanelTwoWidth <= 0 then begin
          LongEdge := LongEdge + 2;
          ShortEdge := ShortEdge + 1;
        end
        else begin
          LongEdge := LongEdge + 4;
          ShortEdge := ShortEdge + 1;
        end;

        if not FOPStileHeight then
          TotalCost := TotalCost + (((OPRunHeight * LongEdge) + (OPRunWidth * ShortEdge)) * StrToFloatDef(LippingCost.Value, 0))
        else
          TotalCost := TotalCost + (((OPRunHeight * LongEdge / 2.0) + (OPRunWidth * ShortEdge)) * StrToFloatDef(LippingCost.Value, 0))
      end;

      3:
      begin
        if Doors.OverPanelTwoWidth <= 0 then begin
          LongEdge := LongEdge + 2;
          ShortEdge := ShortEdge + 2;
        end
        else begin
          LongEdge := LongEdge + 4;
          ShortEdge := ShortEdge + 2;
        end;

        if not FOPStileHeight then
          TotalCost := TotalCost + (((OPRunHeight * LongEdge) + (OPRunWidth * ShortEdge)) * StrToFloatDef(LippingCost.Value, 0))
        else
          TotalCost := TotalCost + (((OPRunHeight * LongEdge / 2.0) + (OPRunWidth * ShortEdge)) * StrToFloatDef(LippingCost.Value, 0))
      end;
    end;
  end;

  if Doors.DoorOneWidth > 2135 then begin
    if not Doors.OverPanel then
      TotalCost := TotalCost + (LongEdge * StrToFloatDef(LippingCost.Value, 0) * 0.3)
    else begin
      if Doors.DoorPairing = 0 then
        TotalCost := TotalCost + ((LongEdge - 2) * StrToFloatDef(LippingCost.Value, 0) * 0.3)
      else
        TotalCost := TotalCost + ((LongEdge - 4) * StrToFloatDef(LippingCost.Value, 0) * 0.3);
    end;
  end;

  LippingMaterialCost.Value := FloatToStr(TotalCost);*)
end;

procedure TLippingsStilesDetails.PerformCalculations;
var
    S:String;
begin
  inherited;
    if (FastFuncs.SameText(curnodename , 'LippingType')) or (FastFuncs.SameText(Curnodename , 'LippingThickness')) then begin
        s:=' SELECT LipCost FROM vwdoorlippingslist Where LipSize = ' +  Quotedstr(LippingThickness.value)  +
                        ' and LipType = '+quotedstr(LippingType.Value);
        LippingCost.value := '0';
        with TERPQuery(GetNewDataset(s)) do try
            if recordcount = 0 then exit;
            LippingCost.Value := floatToStr(FieldByname('Lipcost').AsFloat);
        finally
            if active then close;
            free;
        end;

    end else if (FastFuncs.SameText(curnodename , 'StileLippingThickness')) or (FastFuncs.SameText(Curnodename , 'StileLippingType')) then begin
        s:=' SELECT LipCost FROM vwdoorlippingslist Where LipSize = ' +  Quotedstr(StileLippingThickness.value)  +
                        ' and LipType = '+quotedstr(StileLippingType.Value);
        StileLippingCost.value := '0';
        with TERPQuery(GetNewDataset(s)) do try
            if recordcount = 0 then exit;
            StileLippingCost.Value := floatToStr(FieldByname('Lipcost').AsFloat);
        finally
            if active then close;
            free;
        end;

    end  ;
  CalcLippingMaterialcost;
  CalcMaterialLabourCost;
  TotalLippingStileCost.Value := FloatToStr(StrToFloatDef(LippingMaterialCost.Value, 0) +
                                            StrToFloatDef(StileLippingCost.Value,0) +
                                            StrToFloatDef(MaterialLabourCost.Value, 0));
end;

procedure TLippingsStilesDetails.CalcMaterialLabourCost;
var
    iEdgeNumber :Integer;
    tmpcost :Double;
begin
    TmpCost     := 0;
    iEdgeNumber := StrTointDef(EdgeNumber.Value , -1);
     if iEdgeNumber =   0    then tmpcost := Doors.GetSundryCost('LIP16')
    else if iEdgeNumber =   1    then tmpcost := Doors.GetSundryCost('LIP16')*2
    else if iEdgeNumber in [2,3] then tmpcost := Doors.GetSundryCost('LIP16')*2 + Doors.GetSundryCost('LIP2');

    if DoorPairing in [1,2] then tmpcost := tmpcost * 2;
    MaterialLabourCost.Value := FloatToStr(TmpCost);

(*var
  TmpCost: Double;
  LabLong: Double;
  LabShort: Double;
  StilesPrice: Double;
begin
  TmpCost := 0;

  case StrToIntDef(StileType.Value, 0) of
    0:
    begin
      if FastFuncs.SameText(LippingThickness.Value, '6 & 8 mm') then
        LabLong := Doors.GetSundryCost('LIP16')
      else
        LabLong := Doors.GetSundryCost('LIP1');

      LabShort := Doors.GetSundryCost('LIP2');

      case StrToIntDef(EdgeNumber.Value, 0) of
        0:
        begin
          TmpCost := LabLong;

          if Doors.DoorPairing = 0 then
            TmpCost := TmpCost * 2;

          if Doors.OverPanelOneWidth > 0 then
            TmpCost := TmpCost + LabLong;

          if Doors.OverPanelTwoWidth > 0 then
            TmpCost := TmpCost + LabLong;
        end;

        1:
        begin
          TmpCost := LabLong * 2;

          if Doors.DoorPairing = 0 then
            TmpCost := TmpCost * 2;

          if Doors.OverPanelOneWidth > 0 then
            TmpCost := TmpCost + (LabLong * 2);

          if Doors.OverPanelTwoWidth > 0 then
            TmpCost := TmpCost + (LabLong * 2);
        end;

        2, 3:
        begin
          TmpCost := (LabLong * 2) + LabShort;

          if Doors.DoorPairing = 1 then
            TmpCost := TmpCost * 2;

          if Doors.OverPanelOneWidth > 0 then
            TmpCost := TmpCost + (LabLong * 2) + LabShort;

          if Doors.OverPanelTwoWidth > 0 then
            TmpCost := TmpCost + ((LabLong  + LabShort) * 2);
        end;
      end;
      
      StilesPrice := Doors.GetStilesCost('S1');

      if DisplayDialogs and (StilesPrice = 0) then
        MessageDlgXP_Vista('No price found for rebated stiles.', mtInformation, [mbOK], 0);

      if Doors.OverpanelOneWidth > 0 then begin
        if FMeetHanging then begin
          TmpCost := TmpCost + ((Doors.OverPanelOneWidth + Doors.OverPanelTwoWidth) / 1000.0) +
                     ((Doors.DoorOneWidth * 2) / 1000.0 * StilesPrice)
        end;

        if Doors.DoorPairing = 0 then begin

        end;
      end;
    end;

    1:
    begin
    end;

    2:
    begin
    end;

    3:
    begin
    end;
  end;

  MaterialLabourCost.Value := FloatToStr(TmpCost);*)
end;

function TLippingsStilesDetails.GetTotalCost: Double;
begin
    inherited GetTotalCost ;
    REsult := StrtofloatDef(TotalLippingStileCost.Value,0);
end;

initialization
  RegisterClassOnce(TLippingsStilesDetails);
end.

