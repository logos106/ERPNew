unit FrameExtensionDetailsObj;

interface

uses
  Classes, NodePropertiesLink, MyAccess,ERPdbComponents, SysUtils, FrameBaseobject;

type
  TFrameExtensionDetails = class(TFrameBaseObj)
  private
    FWidthInches: TNodeProperties;
    FWidthMills: TNodeProperties;
    FHeightInches: TNodeProperties;
    FHeightMills: TNodeProperties;
    FTimberCost: TNodeProperties;
    FCost: TNodeProperties;
    FTotalcost: TNodeProperties;
  protected
    procedure AssignItemType; override;
  public
    procedure PerformCalculations; override;
    function GetTotalCost: Double; override;
  published
    property WidthInches: TNodeProperties read FWidthInches write FWidthInches;
    property WidthMills: TNodeProperties read FWidthMills write FWidthMills;
    property HeightInches: TNodeProperties read FHeightInches write FHeightInches;
    property HeightMills: TNodeProperties read FHeightMills write FHeightMills;
    property TimberCost: TNodeProperties read FTimberCost write FTimberCost;
    property Cost: TNodeProperties read FCost write FCost;
    Property TotalCost : TNodeProperties Read fTotalCost Write fTotalCost;
  end;

implementation

uses
  CommonLib;

{ TFrameExtensionDetails }

procedure TFrameExtensionDetails.AssignItemType;
begin
  inherited;
  ItemType := 'FrameExtensionDetails';
end;

function TFrameExtensionDetails.GetTotalCost: Double;
begin
  Result := inherited GetTotalCost + StrtoFloatdef(totalCost.value , 0);
end;

procedure TFrameExtensionDetails.PerformCalculations;
(*var
    tmpcost :Double;*)
begin
  inherited;
    if SameText(CurNodename , 'WidthInches')        then begin
        if EmptyNumber(WidthMills.Value) then
            WidthMills.Value  :=FloatToStr(InchTomm(StrToFloatDef(WidthInches.Value,0)));
    end else if SameText(CurNodename , 'HeightInches')  then begin
        if emptyNumber(HeightMills.Value) then
            HeightMills.Value :=FloatToStr(InchTomm(StrToFloatDef(HeightInches.Value,0)));
    end;
    CalcCost(WidthInches , HeightInches ,TimberCost , Cost , TotalCost);
end;

initialization
  RegisterClassOnce(TFrameExtensionDetails);
end.
 
