unit DoorEditVeneerDetailsObj;

interface

uses
  Classes, NodePropertiesLink, MyAccess,ERPdbComponents, SysUtils,DoorEditBaseObject;

type
  TVeneerDetails = class(TDoorEditBaseObj)
  private
    FVeneerRequired: TNodeProperties;
    FVeneeredOver: TNodeProperties;
    FCutDescription: TNodeProperties;
    FVeneerOne: TNodeProperties;
    FVeneerOneCost: TNodeProperties;
    FVeneerTwo: TNodeProperties;
    FVeneerTwoCost: TNodeProperties;
    FTotalVeneerCost: TNodeProperties;
    function GetVeneerCost(const VeneerName: string): string;
  protected
    procedure AssignItemType; override;
  public
    procedure PerformCalculations; override;
    function GetTotalCost: Double; override;
  published
    property VeneerRequired: TNodeProperties read FVeneerRequired write FVeneerRequired;
    property VeneeredOver: TNodeProperties read FVeneeredOver write FVeneeredOver;
    property CutDescription: TNodeProperties read FCutDescription write FCutDescription;
    property VeneerOne: TNodeProperties read FVeneerOne write FVeneerOne;
    property VeneerOneCost: TNodeProperties read FVeneerOneCost write FVeneerOneCost;
    property VeneerTwo: TNodeProperties read FVeneerTwo write FVeneerTwo;
    property VeneerTwoCost: TNodeProperties read FVeneerTwoCost write FVeneerTwoCost;
    property TotalVeneerCost: TNodeProperties read FTotalVeneerCost write FTotalVeneerCost;
  end;

implementation

uses
  CommonDbLib, DoorsLib, FastFuncs, CommonLib, DecimalRounding;

{ TVeneerDetails }

procedure TVeneerDetails.AssignItemType;
begin
  inherited;
  ItemType := 'VeneerDetails';
end;

function TVeneerDetails.GetTotalCost: Double;
begin
  Result := inherited GetTotalCost + StrToFloatDef(TotalVeneerCost.Value, 0);
end;

function TVeneerDetails.GetVeneerCost(const VeneerName: string): string;
var
  qryVeneer: TERPQuery;
begin
  Result := '0.00';
  qryVeneer := TERPQuery.Create(nil);

  try
    qryVeneer.Connection := GetSharedMyDacConnection;
    qryVeneer.SQL.Text := 'SELECT * FROM vwDoorveneerList WHERE VeneerName = ' + QuotedStr(VeneerName);
    qryVeneer.Open;

    if not qryVeneer.IsEmpty then
      Result := qryVeneer.FieldByName('CostPerSq').AsString;

    qryVeneer.Close;
  finally
    FreeAndNil(qryVeneer);
  end;
end;

procedure TVeneerDetails.PerformCalculations;
var
    VeneeredOverCost: Double;
    tmpCost :Double;
begin
    inherited;
    (*if Doors.doorpairing <> 0 then begin*)
        if FastFuncs.SameText(Curnodename , 'VeneerOne') then
            if Veneertwo.value = '' then
                Veneertwo.value := Veneerone.value;

        if FastFuncs.SameText(curnodename , 'VeneerRequired') then
            if FastFuncs.SameText(VeneerRequired.Value, 'F') then begin
                VeneerOne.Value := '';
                VeneerTwo.Value := '';
            end;
    (*end;*)
    VeneeredOverCost := 0;
    if FastFuncs.SameText(curnodename , 'VeneeredOver') then
        if FastFuncs.SameText(VeneeredOver.Value, 'T') then
            VeneeredOverCost := Doors.GetSundryCost('V4');

    VeneerOneCost.Value := GetVeneerCost(VeneerOne.Value);
    VeneerTwoCost.Value := GetVeneerCost(VeneerTwo.Value);


    (*if Doors.doorpairing <> 0 then*)
        if (VeneerOneCost.value <> '') and ((FastFuncs.Trim(VeneerTwoCost.Value) = '') or
                (FastFuncs.Trim(VeneerTwoCost.Value) = '0.00')) then
            VeneerTwoCost.Value := VeneerOneCost.value;

    (*tmpCost :=((Doors.DoorOneWidth+20)/1000)*
              ((Doors.DoorOneHeight+20)/1000) *
              StrToFloatDef(VeneerOneCost.Value, 0) ;
    if Doors.doorpairing <> 0 then
        tmpCost := tmpCost +((Doors.DoortwoWidth+20)/1000)*
                        ((Doors.DoortwoHeight+20)/1000) *
                        StrToFloatDef(VeneertwoCost.Value, 0);*)
    (*{maureen  - 070308}
    tmpCost := StrToFloatDef(VeneerOneCost.Value, 0) ;
    if Doors.doorpairing <> 0 then
        tmpCost := tmpCost +StrToFloatDef(VeneertwoCost.Value, 0);*)

    {maureen  - 010408}
    tmpCost :=((Doors.DoorOneWidth+20)/1000)*
              ((Doors.DoorOneHeight+20)/1000) *
              StrToFloatDef(VeneerOneCost.Value, 0) ;
    tmpCost := DecimalRounding.DecimalRoundDbl(tmpcost, 2, drRndUp);
    tmpCost := tmpCost +((Doors.DoorOneWidth+20)/1000)*
              ((Doors.DoorOneHeight+20)/1000) *
              StrToFloatDef(VeneertwoCost.Value, 0);
    tmpCost := DecimalRounding.DecimalRoundDbl(tmpcost, 2, drRndUp);
    tmpCost :=tmpCost +((Doors.DoorTwoWidth+20)/1000)*
              ((Doors.DoorTwoHeight+20)/1000) *
              StrToFloatDef(VeneerOneCost.Value, 0) ;
    tmpCost := DecimalRounding.DecimalRoundDbl(tmpcost, 2, drRndUp);
    tmpCost := tmpCost +((Doors.DoortwoWidth+20)/1000)*
              ((Doors.DoorTwoHeight+20)/1000) *
              StrToFloatDef(VeneertwoCost.Value, 0);
    tmpCost := DecimalRounding.DecimalRoundDbl(tmpcost, 2, drRndUp);
    
    tmpCost :=  tmpCost  + VeneeredOverCost;
    TotalVeneerCost.Value := FloatToStr(tmpCost);
end;

initialization
  RegisterClassOnce(TVeneerDetails);
end.

