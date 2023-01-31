unit FrameThresholdDetailsObj;

interface

uses
  Classes, NodePropertiesLink, MyAccess,ERPdbComponents, SysUtils, FrameBaseobject;

type
  TFrameThresholdDetails = class(TFrameBaseObj)
  private
    FDescription    : TNodeProperties;
    FWidthInches    : TNodeProperties;
    FWidthMills     : TNodeProperties;
    FHeightInches   : TNodeProperties;
    FHeightMills    : TNodeProperties;
    FTimberCost     : TNodeProperties;
    FCost           : TNodeProperties;
    fTotalCost      : TNodeProperties;
  protected
    procedure AssignItemType; override;
    Function GetDoorArea :Double; override;
  public
    procedure PerformCalculations; override;
    function GetTotalCost: Double; override;
  published
    property Description    : TNodeProperties read FDescription  write FDescription;
    property WidthInches    : TNodeProperties read FWidthInches  write FWidthInches;
    property WidthMills     : TNodeProperties read FWidthMills   write FWidthMills;
    property HeightInches   : TNodeProperties read FHeightInches write FHeightInches;
    property HeightMills    : TNodeProperties read FHeightMills  write FHeightMills;
    property TimberCost     : TNodeProperties read FTimberCost   write FTimberCost;
    property Cost           : TNodeProperties read FCost         write FCost;
    Property TotalCost      : TNodeProperties Read fTotalCost    Write fTotalCost;
  end;

implementation

uses
  CommonLib, EditFrameQuotationDetailsObj;

{ TFrameThresholdDetails }

procedure TFrameThresholdDetails.AssignItemType;
begin
  inherited;
  ItemType := 'FrameThresholdDetails';
end;

function TFrameThresholdDetails.GetTotalCost: Double;
begin
  Result := inherited GetTotalCost+ StrtoFloatdef(TotalCost.value , 0);
end;
procedure TFrameThresholdDetails.PerformCalculations;
(*var
    tmpcost :Double;
    DoorFrame : TEditFrameQuotationDetails;    *)
begin
  inherited;

    if SameText(CurNodename , 'WidthInches')        then begin
        if EmptyNumber(WidthMills.Value) then
            WidthMills.Value  :=FloatToStr(InchTomm(StrToFloatDef(WidthInches.Value,0)));
    end else if SameText(CurNodename , 'HeightInches')  then begin
        if EmptyNumber(HeightMills.Value) then
            HeightMills.Value :=FloatToStr(InchTomm(StrToFloatDef(HeightInches.Value,0)));
    end;
    CalcCost(WidthInches , HeightInches ,TimberCost , Cost , totalcost);
    (*tmpcost :=  StrToFloatDef(WidthInches.Value, 0) * StrToFloatDef(HeightInches.Value,0)*39.96 *
                StrToFloatDef(TimberCost.Value,0)/1728;
    Cost.Value := FloatToStr(TmpCost);
    if (Assigned(Self.Owner)) and (Self.Owner is TEditFrameQuotationDetails) then
        DoorFrame := TEditFrameQuotationDetails(Self.Owner)
    else Exit;
    TmpCost := DoorFrame.DoorArea *TmpCost;
    totalcost.value :=  FloatToStr(TmpCost);*)
end;
Function TFrameThresholdDetails.GetDoorArea :Double;
var
    DoorFrame : TEditFrameQuotationDetails;
begin
    {maureen 7/3/2008: this is only cost calculation doesn't include the height }
    Result := 0;
    if (Assigned(Self.Owner)) and (Self.Owner is TEditFrameQuotationDetails) then
        DoorFrame := TEditFrameQuotationDetails(Self.Owner)
    else Exit;
    Result := StrToFloatDef(DoorFrame.TotalDoorWidth.Value , 0)/1000;
end;
initialization
  RegisterClassOnce(TFrameThresholdDetails);
end.

