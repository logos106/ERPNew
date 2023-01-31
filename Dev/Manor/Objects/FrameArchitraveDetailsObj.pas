unit FrameArchitraveDetailsObj;

interface

uses
  Classes, NodePropertiesLink, MyAccess,ERPdbComponents, SysUtils, FrameBaseobject;

type
  TFrameArchitraveDetails = class(TFrameBaseObj)
  private
    FDescription: TNodeProperties;
    FWidthInches: TNodeProperties;
    FWidthMills: TNodeProperties;
    FHeightInches: TNodeProperties;
    FHeightMills: TNodeProperties;
    FArchitrave: TNodeProperties;
    FFrameTopArchitrave: TNodeProperties;
    FTimberCost: TNodeProperties;
    FCost: TNodeProperties;
    FtotalCost: TNodeProperties;
  protected
    procedure AssignItemType; override;
    Procedure ApplyExtraCalc; override;
  public
    procedure PerformCalculations; override;
    function GetTotalCost: Double; override;
  published
    property Description: TNodeProperties read FDescription write FDescription;
    property WidthInches: TNodeProperties read FWidthInches write FWidthInches;
    property WidthMills: TNodeProperties read FWidthMills write FWidthMills;
    property HeightInches: TNodeProperties read FHeightInches write FHeightInches;
    property HeightMills: TNodeProperties read FHeightMills write FHeightMills;
    property Architrave: TNodeProperties read FArchitrave write FArchitrave;
    property FrameTopArchitrave: TNodeProperties read FFrameTopArchitrave write FFrameTopArchitrave;
    property TimberCost: TNodeProperties read FTimberCost write FTimberCost;
    property Cost: TNodeProperties read FCost write FCost;
    property totalCost: TNodeProperties read FTotalCost write FtotalCost;

  end;

implementation

uses
  CommonLib, DecimalRounding(*, EditFrameQuotationDetailsObj*);

{ TFrameArchitraveDetails }

procedure TFrameArchitraveDetails.AssignItemType;
begin
  inherited;
  ItemType := 'FrameArchitraveDetails';
end;

function TFrameArchitraveDetails.GetTotalCost: Double;
begin
  Result := inherited GetTotalCost + StrtoFloatdef(totalcost.value , 0);
end;
Procedure TFrameArchitraveDetails.ApplyExtraCalc;
begin
    TmpCost := DecimalRounding.DecimalRoundDbl(TmpCost , 2, drRndUp);
    if StrToFloatDef(Architrave.Value,0) = 1 then tmpcost := tmpcost*2;
end;
procedure TFrameArchitraveDetails.PerformCalculations;
begin
  inherited;
    if SameText(CurNodename      , 'WidthInches')   then begin
        if EmptyNumber(WidthMills.Value) then
            WidthMills.Value  :=FloatToStr(InchTomm(StrToFloatDef(WidthInches.Value,0)));
    end else if SameText(CurNodename , 'HeightInches')  then begin
        if EmptyNumber(HeightMills.Value) then
            HeightMills.Value :=FloatToStr(InchTomm(StrToFloatDef(HeightInches.Value,0)));
    end;
    CalcCost(WidthInches , HeightInches ,TimberCost , Cost , totalcost);
end;

initialization
  RegisterClassOnce(TFrameArchitraveDetails);
end.
