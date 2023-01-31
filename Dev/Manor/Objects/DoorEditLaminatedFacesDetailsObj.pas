unit DoorEditLaminatedFacesDetailsObj;

interface

uses
  Classes, NodePropertiesLink, MyAccess,ERPdbComponents, SysUtils,DoorEditBaseObject;

type
  TLaminatedFacesDetails = class(TDoorEditBaseObj)
  private
    FLaminateOne: TNodeProperties;
    FLaminateTwo: TNodeProperties;
    FLumpSumCostOne: TNodeProperties;
    FLumpSumCostTwo: TNodeProperties;
    FLabourCharge: TNodeProperties;
    FTotalVeneerCost: TNodeProperties;
  protected
    procedure AssignItemType; override;
  public
    procedure PerformCalculations; override;
    function GetTotalCost: Double; override;
  published
    property LaminateOne: TNodeProperties read FLaminateOne write FLaminateOne;
    property LaminateTwo: TNodeProperties read FLaminateTwo write FLaminateTwo;
    property LumpSumCostOne: TNodeProperties read FLumpSumCostOne write FLumpSumCostOne;
    property LumpSumCostTwo: TNodeProperties read FLumpSumCostTwo write FLumpSumCostTwo;
    property LabourCharge: TNodeProperties read FLabourCharge write FLabourCharge;
    property TotalVeneerCost: TNodeProperties read FTotalVeneerCost write FTotalVeneerCost;
  end;

implementation

uses
  DoorsLib, CommonLib, FastFuncs;

{ TLaminatedFacesDetails }

procedure TLaminatedFacesDetails.AssignItemType;
begin
  inherited;
  ItemType := 'LaminatedFacesDetails';
end;

function TLaminatedFacesDetails.GetTotalCost: Double;
begin
  Result := inherited GetTotalCost + StrToFloatDef(TotalVeneerCost.Value, 0);
end;

procedure TLaminatedFacesDetails.PerformCalculations;
var
  LamLabCost: Double;
begin
  inherited;
  LamLabCost := 0;

  if (Laminateone.value     <> '' ) and ( LaminateTwo.value     = '') then LaminateTwo.value    := Laminateone.value;
  if (LumpSumCostOne.Value  <> '' ) and ( (LumpSumCosttwo.Value  = '0.00') or (LumpSumCosttwo.Value  = '')) then LumpSumCosttwo.Value := LumpSumCostOne.Value;

  if Doors.DoorPairing = 0 then begin
    if FastFuncs.Trim(LaminateOne.Value) <> '' then
      LamLabCost := Doors.GetSundryCost('LF' + Doors.DoorType);
  end
  else begin
    if (FastFuncs.Trim(LaminateOne.Value) <> '') and (FastFuncs.Trim(LaminateTwo.Value) <> '') then
      LamLabCost := Doors.GetSundryCost('LF' + Doors.DoorType) * 2;
  end;

  LabourCharge.Value := FloatToStr(LamLabCost);
  TotalVeneerCost.Value := FloatToStr(StrToFloatDef(LumpSumCostOne.Value, 0) + StrToFloatDef(LumpSumCostTwo.Value, 0) +
                                      StrToFloatDef(LabourCharge.Value, 0));
end;

initialization
  RegisterClassOnce(TLaminatedFacesDetails);
end.
 
 
