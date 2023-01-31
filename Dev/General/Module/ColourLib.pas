unit ColourLib;

interface

Uses AdvOfficeSelectors,AdvTrackBar,Graphics, db, controls , DNMSpeedButton ;

var
  colours :Array[1..25] of TColor;

Procedure Initcolours;
procedure SetButtonProperties(const Control: TWinControl; aButtonToExcludeFromFormating:String);
function ButtoninNotToformatList(btn:TDnmSpeedbutton; ButtonToExcludeFromFormating :String): boolean;
function colorforIndex(Index:Integer):Tcolor;
function AlternateColor(Index:Integer):Tcolor;
procedure GradIntensityChange(GradIntensity: TAdvTrackBar;ColorSelector: TAdvOfficeColorSelector);
procedure SetcolorComp(TrackBar:TAdvTrackBar;colorSelector :TAdvOfficeColorSelector; ds:TDataset; colorField,GradientField:String);
Function DarkColor(acolor:TColor):Tcolor;
Function LightColor(acolor:TColor):Tcolor;
procedure DnmButton(btn :TDnmSpeedbutton; LightColor , HotTrackColor, fontcolor:Tcolor);

implementation

uses tcConst,GraphUtil, forms , classes, AppEnvironment, shader, StdCtrls, SysUtils;

procedure SetcolorComp(TrackBar:TAdvTrackBar;colorSelector :TAdvOfficeColorSelector; ds:TDataset; colorField,GradientField:String);
begin
  colorSelector.SelectedColor  := TColor(ds.FieldByName(colorField).AsInteger);
  TrackBar.Position            := ds.FieldByName(GradientField).AsInteger;
  TrackBar.Color               := colorSelector.SelectedColor;
  TrackBar.ColorTo             := ColorAdjustLuma(TrackBar.Color,TrackBar.Position, False);
end;
Function DarkColor(acolor:TColor):Tcolor;
begin
  result := ColorAdjustLuma(aColor,1, False);
end;
Function LightColor(acolor:TColor):Tcolor;
begin
  result := ColorAdjustLuma(aColor,100, False);
end;
procedure GradIntensityChange(GradIntensity: TAdvTrackBar;ColorSelector: TAdvOfficeColorSelector);
begin
        TAdvTrackBar(GradIntensity).Color := TAdvOfficeColorSelector(ColorSelector).SelectedColor;
        TAdvTrackBar(GradIntensity).ColorTo := ColorAdjustLuma(TAdvTrackBar(GradIntensity).Color,TAdvTrackBar(GradIntensity).Position, False);
end;

function colorforIndex(Index:Integer):Tcolor;
begin
  While Index>24 do index := index -24;
  Result := colours[index];
end;
function AlternateColor(Index:Integer):Tcolor;
begin
  if trunc(index/2)*2 = index then result :=  GridColhighLightGreen else result := GridColhighLightYellow1;
end;
Procedure Initcolours;
begin
    colours[1]:= clRed;
    colours[2]:= clBlue;
    colours[3]:= clBlack;
    colours[4]:= $0000C6FF;
    colours[5]:= $0044C100;
    colours[6]:= $00C400C4;
    colours[7]:= clMaroon;
    colours[8]:= clMoneyGreen;
    colours[9]:= $007D7DFF;
    colours[10]:= $00FFA4A4;
    colours[11]:= $00AAECFF;
    colours[12]:= $00A4A444;
    colours[13]:= clOlive;
    colours[14]:= clNavy;
    colours[15]:= clPurple;
    colours[16]:= clSilver;
    colours[17]:= $00D28B6C;
    colours[18]:= $00DDDDAC;
    colours[19]:= clTeal;
    colours[20]:= clGreen;
    colours[21]:= clGray;
    colours[22]:= clAqua;
    colours[23]:= clLime;
    colours[24]:= clYellow;
    colours[25]:= $00FFFFC6;
end;
procedure DnmButton(btn :TDnmSpeedbutton; LightColor , HotTrackColor, fontcolor:Tcolor);
begin
  btn.Color := LightColor ;
  btn.LightColor := LightColor ;
  btn.HotTrackColor := HotTrackColor;
  btn.Font.Color := fontcolor;
end;
procedure SetButtonProperties(const Control: TWinControl; aButtonToExcludeFromFormating:String);
var
  Index: integer;
begin
  for Index := 0 to Control.ComponentCount - 1 do begin
    if (Control.Components[Index] is TForm) or
       (Control.Components[Index] is TFrame) then
      SetButtonProperties(TWinControl(Control.Components[Index]), aButtonToExcludeFromFormating)
    else if Control.Components[Index] is TDNMSpeedButton then begin
      with TDNMSpeedButton(Control.Components[Index]) do begin
        Alignment := taCenter;
        SlowDecease := true;
        Style := bsModern;
        if not ButtoninNotToformatList(TDNMSpeedButton(Control.Components[Index]), aButtonToExcludeFromFormating) then begin
            Color := clWhite;
            HotTrackColor := clBtnShadow;
            if Appenv.IsDBConnected and  Appenv.Employee.UseERPButtonColor then begin
              DnmButton( TDNMSpeedButton(Control.Components[Index]) ,
                         Appenv.Employee.ERPButtonColor ,
                         Appenv.Employee.ERPButtonHTColor ,
                         Appenv.Employee.ERPButtonFontColor);
              (*Color := Appenv.Employee.ERPButtonColor;
              LightColor := Appenv.Employee.ERPButtonColor;
              HotTrackColor := Appenv.Employee.ERPButtonHTColor;
              Font.Color := Appenv.Employee.ERPButtonFontColor;*)
            end else begin
              DnmButton( TDNMSpeedButton(Control.Components[Index]) ,
                         Default_ColourERPButton ,
                         Default_ColourERPButtonHT,
                         Default_ColourERPButtonFont);
              (*Color := Default_ColourERPButton;
              LightColor := Default_ColourERPButton;
              HotTrackColor := Default_ColourERPButtonHT;
              Font.Color := Default_ColourERPButtonFont;*)
            end;
        end;
      end;
    (*end else if  (Control.Components[Index] is TLabel) and Assigned(TLabel(Control.Components[Index]).parent) and (TLabel(Control.Components[Index]).parent is TShader) then begin
        if Appenv.IsDBConnected and Appenv.Employee.UseERPButtonColor then begin
              TShader(TLabel(Control.Components[Index]).parent).FromColor := Appenv.Employee.ERPButtonColor;
              TShader(TLabel(Control.Components[Index]).parent).ToColorMirror := Appenv.Employee.ERPButtonColor;
              TShader(TLabel(Control.Components[Index]).parent).ToColor := Appenv.Employee.ERPButtonColor;
              TShader(TLabel(Control.Components[Index]).parent).FromColorMirror := Appenv.Employee.ERPButtonColor;
              TLabel(Control.Components[Index]).Font.Color :=Appenv.Employee.ERPButtonFontColor;
        end else begin
              TShader(TLabel(Control.Components[Index]).parent).FromColor := Default_ColourERPButton;
              TShader(TLabel(Control.Components[Index]).parent).ToColorMirror := Default_ColourERPButton;
              TShader(TLabel(Control.Components[Index]).parent).ToColor := Default_ColourERPButton;
              TShader(TLabel(Control.Components[Index]).parent).FromColorMirror := Default_ColourERPButton;
              TLabel(Control.Components[Index]).Font.Color :=Default_ColourERPButtonFont;

        end;*)
    end;
  end;
end;
function ButtoninNotToformatList(btn:TDnmSpeedbutton; ButtonToExcludeFromFormating :String): boolean;
begin
  result := pos(uppercase(trim(btn.Name)), uppercase(ButtonToExcludeFromFormating)) <> 0;
  if not result then
    result := pos(uppercase(trim(btn.Caption)), uppercase(ButtonToExcludeFromFormating)) <> 0;

end;
initialization
  Initcolours;

end.
