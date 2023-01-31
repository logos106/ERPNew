unit FrameFanLightDetailsObj;

interface

uses
  Classes, NodePropertiesLink, MyAccess,ERPdbComponents, SysUtils, FrameBaseobject;

type
  TFrameFanLightDetails = class(TFrameBaseObj)
  private
    FBeads: TNodeProperties;
    FSupplyAndFit: TNodeProperties;
    FBeadWidth: TNodeProperties;
    FWebThickness: TNodeProperties;
    FTimberCost: TNodeProperties;
    FBeadingCost: TNodeProperties;
    FPanelCost: TNodeProperties;
    FPanelDescription: TNodeProperties;
  protected
    procedure AssignItemType; override;
  public
    procedure PerformCalculations; override;
    function GetTotalCost: Double; override;
  published
    property Beads: TNodeProperties read FBeads write FBeads;
    property SupplyAndFit: TNodeProperties read FSupplyAndFit write FSupplyAndFit;
    property BeadWidth: TNodeProperties read FBeadWidth write FBeadWidth;
    property WebThickness: TNodeProperties read FWebThickness write FWebThickness;
    property TimberCost: TNodeProperties read FTimberCost write FTimberCost;
    property BeadingCost: TNodeProperties read FBeadingCost write FBeadingCost;
    property PanelCost: TNodeProperties read FPanelCost write FPanelCost;
    property PanelDescription: TNodeProperties read FPanelDescription write FPanelDescription;
  end;

implementation

uses
  CommonLib, EditFrameQuotationDetailsObj(*, EditFrameQuotationDetailsObj*);

{ TFrameFanLightDetails }

procedure TFrameFanLightDetails.AssignItemType;
begin
  inherited;
  ItemType := 'FrameFanLightDetails';
end;

function TFrameFanLightDetails.GetTotalCost: Double;
begin
  Result := inherited GetTotalCost+ StrtoFloatdef(PanelCost.value , 0);
end;

procedure TFrameFanLightDetails.PerformCalculations;
var
    tmpcost :Double;
    DoorFrame : TEditFrameQuotationDetails;
begin
  inherited;
    if SameText(curnodename , 'BeadingCost') then
        Timbercost.Value := FloatToStr(lmtrtosqm(StrToFloatDef(BeadingCost.Value,0), inchtom(StrToFloatDef(BeadWidth.Value,0))));
    BeadingCost.Value        :=FloatToStr(sqmtolmtr(StrToFloatDef(Timbercost.Value,0) , inchtom(StrToFloatDef(BeadWidth.Value,0))));

    tmpCost := 0;
    try
        if Beads.Value ='0' then Exit;
        if (Assigned(Self.Owner)) and (Self.Owner is TEditFrameQuotationDetails) then
            DoorFrame := TEditFrameQuotationDetails(Self.Owner)
        else Exit;

        Tmpcost := (StrToFloatDef(DoorFrame.TotalDoorWidth.Value,0)+9)+
                (StrToFloatDef(DoorFrame.OverallHeight.value,0) -StrToFloatDef(DoorFrame.DoorHeight.value,0)+9);
        if Beads.Value = '1' then
            Tmpcost := Tmpcost *2
        else if Beads.Value = '2' then
            Tmpcost := Tmpcost*4;
            Tmpcost := Tmpcost*StrToFloatDef(BeadingCost.Value,0);
    finally
        PanelCost.value := FloatToStr(tmpcost);
    end;
end;

initialization
  RegisterClassOnce(TFrameFanLightDetails);
end.

