unit frmRosterBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, Shader, DNMPanel, DNMSpeedButton, DBPlanner,
  wwdbdatetimepicker, Planner, ComCtrls , frmRosterDatePicker, DataSourcePrefs , BOMColoursObj;

type
  TfmRosterBaseGUI = class(TBaseInputGUI)
    pnltop: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    pnlMain: TDNMPanel;
    Planner: TDBPlanner;
    pgeRosters: TPageControl;
    tabDaily: TTabSheet;
    RosterSource: TDBDaySource;
    dsRoster: TDataSourcePrefs;
    QryRoster: TERPQuery;
    pnlright: TDNMPanel;
    Memo1: TMemo;

    procedure FormCreate(Sender: TObject);
    procedure PlannerItemRightClick(Sender: TObject; Item: TPlannerItem);
    procedure PlannerPlannerRightClick(Sender: TObject; Position, FromSel,
      FromSelPrecise, ToSel, ToSelPrecise: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure pgeRostersChange(Sender: TObject);
    procedure pgeRostersResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    fBOMColours :TBOMColours;
    //Procedure initcolours;
  Protected
    //Colours :Array of Tcolor;
    //LightColours :Array of Tcolor;
    iRightClickedObject :Integer;
    RosterDatePicker : TfmRosterDatePicker;
    Dtfrom,dtTo :TDateTime;


    Procedure PopupMenuHandler(Sender:TObject); virtual;
    Procedure OnCellPopup(Sender: TObject); virtual;
    Procedure OnItemPopup(Sender: TObject); virtual;
    //function StrtoColor(const Value: String): TColor;
    //function IndextoColor(Index:Integer; Dark:Boolean):TColor;
    function Darkcolor(Index:Integer):TColor;
    function Lightcolor(Index:Integer):TColor;
    Procedure OnDatechange (Sender:TObject);Virtual;
    Function BOMColours : TBOMColours;
  public
    constructor Create(AOwner:TComponent);Override;
  end;


implementation

uses RosterLib, GraphUtil, DNMLib, CommonLib;

{$R *.dfm}

function TfmRosterBaseGUI.BOMColours: TBOMColours;
begin
  if fBOMColours =nil then fBOMColours := TBOMColours.create(Self);
  REsult := fBOMColours;
end;

constructor TfmRosterBaseGUI.Create(AOwner: TComponent);
begin
  inherited;
  //initcolours;
end;

procedure TfmRosterBaseGUI.FormCreate(Sender: TObject);
begin
  inherited;
  iRightClickedObject := IS_NONE;
  tabDaily.TabVisible := pgeRosters.PageCount>1;
  tabDaily.Visible := True;
  RosterDatePicker := TfmRosterDatePicker.MakeRosterDatePicker(Self, pnlright , onDateChange , altop ,
                                                               Self.classnameis('TfmEmpResProcScheduleVsRoster') or(Self.classnameis('TfmEmpResProcRoster') and Commonlib.devmode ));
end;

procedure TfmRosterBaseGUI.FormDestroy(Sender: TObject);
begin
   (*Finalize(Colours);
   Finalize(LightColours);*)
//   Finalize(fBOMColours);
  fBOMColours.Free;
  inherited;

end;

procedure TfmRosterBaseGUI.FormResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(pgeRosters, 1);
end;

procedure TfmRosterBaseGUI.FormShow(Sender: TObject);
begin
  inherited;
  RealignTabControl(pgeRosters, 1);
  pgeRosters.ActivePage := tabDaily;
  pgeRostersChange(pgeRosters);
end;

(*function TfmRosterBaseGUI.IndextoColor(Index: Integer; Dark:Boolean): TColor;
begin
  While index > Length(Colours) do index := index - Length(Colours);
  if Dark then
    result := Colours[index-1]
  else
    result := LightColours[index-1]
end;*)
function TfmRosterBaseGUI.Darkcolor(Index:Integer):TColor;
begin
  Result := BOMColours.Darkcolor(Index);
  //REsult := IndextoColor(Index,true);
  //Result := ColorAdjustLuma(Result, 10 Div 2, False);
end;
function TfmRosterBaseGUI.Lightcolor(Index:Integer):TColor;
begin
  Result := BOMColours.Lightcolor(Index);
  //REsult := IndextoColor(Index, false);
  //Result := ColorAdjustLuma(Result, 100 Div 2, False);
end;

{procedure TfmRosterBaseGUI.initcolours;
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
    (*Colours[ 0]:= $0080FFFF;
    Colours[ 1]:= clYellow;
    Colours[ 2]:= $0080FF80;
    Colours[ 3]:= $0040FF00;
    Colours[ 4]:= $00808040;
    Colours[ 5]:= $00FFFF80;
    Colours[ 6]:= clAqua;
    Colours[ 7]:= $00FF8000;
    Colours[ 8]:= clBlue;
    Colours[ 9]:= clNavy;
    Colours[10]:= $00800040;
    Colours[11]:= $008000FF;
    Colours[12]:= $000063C6;
    Colours[13]:= $004080FF;
    Colours[14]:= $008080FF;
    Colours[15]:= clPurple;
    Colours[16]:= $00FF0080;*)
    //Colours[18] := $00400080;
    //Colours[19] := $00004000;
    //Colours[20] := clGreen;

(*const
  nos : Array[1..3] of Integer =(20,115,220);
var
  i1,i2,i3:Integer;
begin
  SetLength(Colours,0);
  for i1:= low(nos) to high(nos) do
    for i2:= low(nos) to high(nos) do
      for i3:= low(nos) to high(nos) do
        if (i1=high(nos)) and (i2=high(nos)) and (i3=high(nos)) then
        else if (i1=low(nos)) and (i2=low(nos)) and (i3=low(nos)) then
        else begin
          SetLength(Colours,Length(Colours)+1);
          Colours[high(Colours)] := rgb(nos[i2],nos[i1],nos[i3]);
        end;*)
end;   }

procedure TfmRosterBaseGUI.OnCellPopup(Sender: TObject);
begin

end;
procedure TfmRosterBaseGUI.OnDatechange(Sender: TObject);
begin
  inherited;
  RosterSource.Day := RosterDatePicker.StartDate;
  Dtfrom := RosterDatePicker.StartDate;
  DtTo   := RosterDatePicker.StartDate;
end;

procedure TfmRosterBaseGUI.OnItemPopup(Sender: TObject);
begin

end;

procedure TfmRosterBaseGUI.pgeRostersChange(Sender: TObject);
begin
  inherited;
  if pgeRosters.ActivePage = tabDaily then begin
    RosterDatePicker.DateMode := tdmDaily;
  end;
end;

procedure TfmRosterBaseGUI.pgeRostersResize(Sender: TObject);
begin
  inherited;
  RealignTabControl(pgeRosters, 1);
end;

procedure TfmRosterBaseGUI.PlannerItemRightClick(Sender: TObject;
  Item: TPlannerItem);
begin
  inherited;
  iRightClickedObject := IS_ITEM;
end;

procedure TfmRosterBaseGUI.PlannerPlannerRightClick(Sender: TObject; Position,
  FromSel, FromSelPrecise, ToSel, ToSelPrecise: Integer);
begin
  inherited;
  iRightClickedObject := IS_CELL;

end;

procedure TfmRosterBaseGUI.PopupMenuHandler(Sender: TObject);
begin
try
  if iRightClickedObject = IS_CELL then begin
    OnCellPopup(sender);
  end else if iRightClickedObject = IS_ITEM then begin
    OnItemPopup(sender);
  end;

finally
  iRightClickedObject := IS_NONE;
end;

end;


(*function TfmRosterBaseGUI.StrtoColor(const Value: String): TColor;
begin
       if Sametext(Value , 'clRed'        ) then result := clRed
  else if Sametext(Value , 'clBlue'       ) then result := clBlue
  else if Sametext(Value , 'clBlack'      ) then result := clBlack
  else if Sametext(Value , '$0000C6FF'    ) then result := $0000C6FF
  else if Sametext(Value , '$0044C100'    ) then result := $0044C100
  else if Sametext(Value , '$00C400C4'    ) then result := $00C400C4
  else if Sametext(Value , 'clMaroon'     ) then result := clMaroon
  else if Sametext(Value , 'clMoneyGreen' ) then result := clMoneyGreen
  else if Sametext(Value , '$007D7DFF'    ) then result := $007D7DFF
  else if Sametext(Value , '$00FFA4A4'    ) then result := $00FFA4A4
  else if Sametext(Value , '$00AAECFF'    ) then result := $00AAECFF
  else if Sametext(Value , '$00A4A444'    ) then result := $00A4A444
  else if Sametext(Value , 'clOlive'      ) then result := clOlive
  else if Sametext(Value , 'clNavy'       ) then result := clNavy
  else if Sametext(Value , 'clPurple'     ) then result := clPurple
  else if Sametext(Value , 'clSilver'     ) then result := clSilver
  else if Sametext(Value , '$00D28B6C'    ) then result := $00D28B6C
  else if Sametext(Value , '$00DDDDAC'    ) then result := $00DDDDAC
  else if Sametext(Value , 'clTeal'       ) then result := clTeal
  else if Sametext(Value , 'clGreen'      ) then result := clGreen
  else if Sametext(Value , 'clGray'       ) then result := clGray
  else if Sametext(Value , 'clAqua'       ) then result := clAqua
  else if Sametext(Value , 'clLime'       ) then result := clLime
  else if Sametext(Value , 'clYellow'     ) then result := clYellow
  else result := clWhite;
end;*)

end.
