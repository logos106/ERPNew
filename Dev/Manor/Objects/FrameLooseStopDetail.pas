unit FrameLooseStopDetail;

interface

uses NodePropertiesLink, FrameBaseobject;

type
    TFrameLooseStopDetails = class(TFrameBaseObj)
    Private
        fDescription    : TNodeProperties;
        fTimbercost     : TNodeProperties;
        fWidthinch      : TNodeProperties;
        fThicknessinch  : TNodeProperties;
        fWidthmm        : TNodeProperties;
        fThicknessmm    : TNodeProperties;
        fCostPlm        : TNodeProperties;
        fshadowGap      : TNodeProperties;
        fTotalcost      : TNodeProperties;

    public
        procedure PerformCalculations; override;
        function GetTotalCost: Double; override;
    Protected
        procedure AssignItemType; override;
    Published
        Property Description    : TNodeProperties Read fDescription   Write fDescription;
        Property Timbercost     : TNodeProperties Read fTimbercost    Write fTimbercost;
        Property Widthinch      : TNodeProperties Read fWidthinch     Write fWidthinch;
        Property Thicknessinch  : TNodeProperties Read fThicknessinch Write fThicknessinch;
        Property Widthmm        : TNodeProperties Read fWidthmm       Write fWidthmm;
        Property Thicknessmm    : TNodeProperties Read fThicknessmm   Write fThicknessmm;
        Property CostPlm        : TNodeProperties Read fCostPlm       Write fCostPlm;
        Property shadowGap      : TNodeProperties Read fshadowGap     Write fshadowGap;
        Property TotalCost      : TNodeProperties Read fTotalCost     Write fTotalCost;

    End;
implementation

uses sysutils, (*EditFrameQuotationDetailsObj,*) CommonLib,
  EditFrameQuotationDetailsObj;

procedure TFrameLooseStopDetails.AssignItemType;
begin
    inherited;
    ItemType := 'FrameLooseStopDetails';
end;
procedure TFrameLooseStopDetails.PerformCalculations;
begin
    {set the value back in the calling frame as the edit frame form also has these components
    Otherwsie need to make these disabled here and only refresh the value from the header form}
    (*if assigned(Owner) and (Owner is TEditFrameQuotationDetails) then begin
        if sameText(CurNodename , 'Timbercost')         then TEditFrameQuotationDetails(owner).TimberCost.Value := Timbercost.value
        else if sameText(CurNodename , 'CostPlm')       then TEditFrameQuotationDetails(owner).CostLinearMetre.Value := CostPlm.value
        else if SameText(curnodename , 'Widthinch')     then TEditFrameQuotationDetails(owner).WidthInches.Value := Widthinch.value
        else if SameText(curnodename , 'Widthmm')       then TEditFrameQuotationDetails(owner).WidthMills.Value := Widthmm.value
        else if SameText(curnodename , 'Thicknessinch') then TEditFrameQuotationDetails(owner).WebThicknessInches.Value := Thicknessinch.value
        else if SameText(curnodename , 'Thicknessmm')   then TEditFrameQuotationDetails(owner).WebThicknessMills.Value:= Thicknessmm.value;
    end;*)
    if SameText(CurNodename , 'WidthInch')     then begin
        if Emptynumber(WidthMM.Value) then
            WidthMM.Value      :=FloatToStr(inchtomm(StrToFloatDef(WidthInch.Value,0)));
    end else if SameText(CurNodename , 'Thicknessinch') then begin
        if EmptyNumber(Thicknessmm.Value) then
            Thicknessmm.Value  :=FloatToStr(inchtomm(StrToFloatDef(Thicknessinch.Value,0)));
    end;

    CalcCost(Widthinch , Thicknessinch ,Timbercost , CostPlm , Totalcost);
end;

function TFrameLooseStopDetails.GetTotalCost: Double;
begin
    if assigned(Owner) and (Owner is TEditFrameQuotationDetails) then begin
        if TEditFrameQuotationDetails(owner).TimberCost.Value        <> Timbercost.value    then
            TEditFrameQuotationDetails(owner).TimberCost.Value := Timbercost.value;
        if TEditFrameQuotationDetails(owner).CostLinearMetre.Value   <> CostPlm.value       then
            TEditFrameQuotationDetails(owner).CostLinearMetre.Value := CostPlm.value;
        if TEditFrameQuotationDetails(owner).WidthInches.Value       <> Widthinch.value     then
            TEditFrameQuotationDetails(owner).WidthInches.Value := Widthinch.value;
        if TEditFrameQuotationDetails(owner).WidthMills.Value        <> Widthmm.value       then
            TEditFrameQuotationDetails(owner).WidthMills.Value := Widthmm.value;
        if TEditFrameQuotationDetails(owner).WebThicknessInches.Value<> Thicknessinch.value then
            TEditFrameQuotationDetails(owner).WebThicknessInches.Value := Thicknessinch.value;
        if TEditFrameQuotationDetails(owner).WebThicknessMills.Value <> Thicknessmm.value   then
            TEditFrameQuotationDetails(owner).WebThicknessMills.Value:= Thicknessmm.value;
    end;
    Result := inherited GetTotalCost ;//+ StrToFloatDef(TotalCost.Value, 0);
  //as all the values from this form is passed onto the main form, we don;t need to pass this value

end;

end.

