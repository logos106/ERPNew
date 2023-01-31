unit DoorEditJoineryDetailsObj;

interface

uses
  Classes, NodePropertiesLink, MyAccess,ERPdbComponents, SysUtils,DoorEditBaseObject;

type
  TJoineryDetails = class(TDoorEditBaseObj)
  private
    FTotalJoineryCost: TNodeProperties;
    FQuantity: TNodePropertiesList;
    FDescription: TNodePropertiesList;
    FCost: TNodePropertiesList;
    FUnitOfCharge: TNodePropertiesList;
  protected
    procedure AssignItemType; override;
  public
    procedure PerformCalculations; override;
    function GetTotalCost: Double; override;
  published
    property TotalJoineryCost: TNodeProperties read FTotalJoineryCost write FTotalJoineryCost;
    property Quantity: TNodePropertiesList read FQuantity write FQuantity;
    property Description: TNodePropertiesList read FDescription write FDescription;
    property Cost: TNodePropertiesList read FCost write FCost;
    property UnitOfCharge: TNodePropertiesList read FUnitOfCharge write FUnitOfCharge;
  end;

implementation

uses
  DoorsLib, CommonLib;

{ TJoineryDetails }

procedure TJoineryDetails.AssignItemType;
begin
  inherited;
  ItemType := 'JoineryDetails';
end;

function TJoineryDetails.GetTotalCost: Double;
begin
  Result := inherited GetTotalCost + StrToFloatDef(TotalJoineryCost.Value, 0);
end;

procedure TJoineryDetails.PerformCalculations;
var
  Index: Integer;
  TmpCost: Double;
  TmpCharge: string;
  TotalCost: Double;
begin
  inherited;
  TotalCost := 0;

  for Index := 0 to Description.NodePropsCount - 1 do begin
    TmpCost := Doors.GetJoineryCost(Description.NodeProps[Index].Value, TmpCharge);
    Tmpcost := (TmpCost * StrToFloatDef(Quantity.NodeProps[Index].Value, 0));
    TotalCost := TotalCost + tmpCost;
    Cost.NodeProps[Index].Value := FloatToStr(TmpCost);
    UnitOfCharge.NodeProps[Index].Value := TmpCharge;
  end;

  TotalJoineryCost.Value := FloatToStr(TotalCost);
end;

initialization
  RegisterClassOnce(TJoineryDetails);
end.


