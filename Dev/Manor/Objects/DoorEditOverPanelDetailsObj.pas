unit DoorEditOverPanelDetailsObj;

interface

uses
  Classes, NodePropertiesLink, MyAccess,ERPdbComponents, SysUtils,DoorEditBaseObject;

type
  TOverPanelDetails = class(TDoorEditBaseObj)
  private
    FOverPanelType: TNodeProperties;
    FOverPanelOneWidth: TNodeProperties;
    FOverPanelOneHeight: TNodeProperties;
    FOverPanelTwoWidth: TNodeProperties;
    FOverPanelTwoHeight: TNodeProperties;
    FOverPanelCost: TNodeProperties;
  protected
    procedure AssignItemType; override;
  public
    procedure PerformCalculations; override;
    function GetTotalCost: Double; override;
  published
    property OverPanelType: TNodeProperties read FOverPanelType write FOverPanelType;
    property OverPanelOneWidth: TNodeProperties read FOverPanelOneWidth write FOverPanelOneWidth;
    property OverPanelOneHeight: TNodeProperties read FOverPanelOneHeight write FOverPanelOneHeight;
    property OverPanelTwoWidth: TNodeProperties read FOverPanelTwoWidth write FOverPanelTwoWidth;
    property OverPanelTwoHeight: TNodeProperties read FOverPanelTwoHeight write FOverPanelTwoHeight;
    property OverPanelCost: TNodeProperties read FOverPanelCost write FOverPanelCost;
  end;

implementation

uses
  DoorsLib, CommonLib, FastFuncs;

const
  cNoPanel = 0;
  cSingle = 1;
  cPair = 2;
  cEccentricPair = 3;

{ TOverPanelDetails }

procedure TOverPanelDetails.AssignItemType;
begin
  inherited;
  ItemType := 'OverPanelDetails';
end;

function TOverPanelDetails.GetTotalCost: Double;
begin
  Result := inherited GetTotalCost + StrToFloatDef(OverPanelCost.Value, 0);
end;

procedure TOverPanelDetails.PerformCalculations;
var
  Ans: string;
  tmpcost:Double;
//  qryPrice: TERPQuery;
//
//  function GetNewDoorCost(const Width, Height: Double): Double;
//  var
//    CompRef: string;
//    Position: string;
//    HeightMats: Double;
//    WidthMats: Double;
//    Quantity: Double;
//  begin
//    CompRef := qryPrice.FieldByName('CompRef').AsString;
//    Position := qryPrice.FieldByName('Position').AsString;
//    HeightMats := qryPrice.FieldByName('HghtMats').AsFloat;
//    WidthMats := qryPrice.FieldByName('WidMats').AsFloat;
//    Quantity := qryPrice.FieldByName('Quantity').AsFloat;
//    Result := Doors.NewDoorCost(CompRef, Position, HeightMats, WidthMats, Quantity, Width, Height);
//  end;
begin
  inherited;
  Ans := Doors.DoorTypeOpOneQt(StrToIntDef(OverPanelOneWidth.Value, 0), StrToIntDef(OverPanelOneHeight.Value, 0));

  try
    tmpcost:= 0;
    if (StrToIntDef(OverPanelOneWidth.Value, 0) > 0) and (StrToIntDef(OverPanelOneHeight.Value, 0) > 0) then begin
      case StrToIntDef(OverPanelType.Value, 0) of
        cNoPanel:
        begin
          OverPanelCost.Value := '0.00';
        end;

        cSingle:
        begin
          tmpcost:= Doors.GetNewDoorCost(Ans, StrToFloatDef(OverPanelOneWidth.Value, 0),
                                                                 StrToFloatDef(OverPanelOneHeight.Value, 0));

        end;

        cPair:
        begin
          OverPanelTwoWidth.Value := OverPanelOneWidth.Value;
          OverPanelTwoHeight.Value := OverPanelOneHeight.Value;
          tmpcost:= Doors.GetNewDoorCost(Ans, StrToFloatDef(OverPanelOneWidth.Value, 0),
                                                                 StrToFloatDef(OverPanelOneHeight.Value, 0)) * 2;
        end;

        cEccentricPair:
        begin
          tmpcost:= Doors.GetNewDoorCost(Ans, StrToFloatDef(OverPanelOneWidth.Value, 0),
                                                                 StrToFloatDef(OverPanelOneHeight.Value, 0)) +
                                            Doors.GetNewDoorCost(Ans, StrToFloatDef(OverPanelTwoWidth.Value, 0),
                                                                 StrToFloatDef(OverPanelTwoHeight.Value, 0));
        end;
      end;
    end;


//    qryPrice.Close;
  finally
//    FreeAndNil(qryPrice);
  end;
    if Doors.DoorPairing <>  0 then
        tmpcost:= tmpcost*2;

  OverPanelCost.Value := FloatToStr(tmpcost);


  Doors.OverPanelOneWidth   := StrToIntDef(OverPanelOneWidth.Value, 0);
  Doors.OverPanelOneHeight  := StrToIntDef(OverPanelOneHeight.Value, 0);
  Doors.OverPanelTwoWidth   := StrToIntDef(OverPanelTwoWidth.Value, 0);
  Doors.OverPanelTwoHeight  := StrToIntDef(OverPanelTwoHeight.Value, 0);
  Doors.OverPanelType       := FastFuncs.StrToInt(OverPanelType.value);
end;

initialization
  RegisterClassOnce(TOverPanelDetails);
end.

