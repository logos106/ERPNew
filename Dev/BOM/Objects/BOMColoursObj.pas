unit BOMColoursObj;

interface

Uses Graphics,Classes;

Type
  TBOMColours = Class(TComponent)
    Private
      procedure initcolours;
    function IndextoColor(Index: Integer; Dark: Boolean): TColor;
    Public
      Colours :Array of Tcolor;
      LightColours :Array of Tcolor;
      Constructor Create(AOwner:TComponent);Override;
      Destructor Destroy; Override;
      function Darkcolor(Index: Integer): TColor;
      function Lightcolor(Index: Integer): TColor;
  End;

implementation

constructor TBOMColours.Create(AOwner:TComponent);
begin
   initcolours;
end;

destructor TBOMColours.Destroy;
begin
   Finalize(Colours);
   Finalize(LightColours);
  inherited;
end;
function TBOMColours.Darkcolor(Index:Integer):TColor;
begin
  REsult := IndextoColor(Index,true);
end;
function TBOMColours.Lightcolor(Index:Integer):TColor;
begin
  REsult := IndextoColor(Index, false);
end;

function TBOMColours.IndextoColor(Index: Integer; Dark:Boolean): TColor;
begin
  While index > Length(Colours) do index := index - Length(Colours);
  if Dark then
    result := Colours[index-1]
  else
    result := LightColours[index-1]
end;

procedure TBOMColours.initcolours;
begin
    SetLength(Colours,24)              ;SetLength(LightColours,24);
    Colours	[0]	 := clWebPlum 	       ;LightColours	[0]	:= clWebThistle;
    Colours	[1]	 := clWebLightPink 	   ;LightColours	[1]	:= clWebMoccasin;
    Colours	[2]	 := clWebCornFlowerBlue;LightColours	[2]	:= clWebPowderBlue 	;
    Colours	[3]	 := clWebSpringGreen   ;LightColours	[3]	:= clWebPaleGreen 	;
    Colours	[4]	 := clWebLightSalmon   ;LightColours	[4]	:= clWebDarkKhaki 	;
    Colours	[5]	 := clAqua             ;LightColours	[5]	:= clWebMediumSpringGreen 	;
    Colours	[6]	 := clWebBurlywood     ;LightColours	[6]	:= clWebLightSalmon 	;
    Colours	[7]	 := clWebYellow        ;LightColours	[7]	:= clWebKhaki 	;
    Colours	[8]	 := clActiveBorder     ;LightColours	[8]	:= clMedGray 	;
    Colours	[9]	 := clWebDarkOrange    ;LightColours	[9]	:= clWebWheat 	;
    Colours	[10] := clWebIndianRed     ;LightColours	[10]:= clWebPaleVioletRed 	;
    Colours	[11] := clFuchsia          ;LightColours	[11]:= clWebMediumOrchid 	;
    Colours	[12] := clLime             ;LightColours	[12]:= clWebSpringGreen 	;
    Colours	[13] := clTeal             ;LightColours	[13]:= clWebPaleTurquoise 	;
    Colours	[14] := clPurple           ;LightColours	[14]:= clWebHotPink 	;
    Colours	[15] := clWebRoyalBlue     ;LightColours	[15]:= clWebLightSteelBlue 	;
    Colours	[16] := clGreen            ;LightColours	[16]:= clWebLawnGreen 	;
    Colours	[17] := clWebSlateBlue     ;LightColours	[17]:= clWebMediumSlateBlue 	;
    Colours	[18] := clBackground       ;LightColours	[18]:= clWebCornFlowerBlue 	;
    Colours	[19] := clWebOrchid 	     ;LightColours	[19]:= clWebPlum;
    Colours	[20] := clWebNavajoWhite   ;LightColours	[20]:= clWebBeige;
    Colours	[21] := clWebBurlywood 	   ;LightColours	[21]:= clWebMoccasin;
    Colours	[22] := clWebPink          ;LightColours	[22]:= clWebTan 	;
    Colours	[23] := clWebDarkRed       ;LightColours	[23]:= clWebDarkOrange 	;
end;

end.
