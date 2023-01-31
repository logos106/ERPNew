unit ERPSmoothExpanderPanel;
//{$I TMSDEFS.inc}

interface

uses
  Windows, Messages, ExtCtrls, SysUtils, Classes, Graphics, Controls, StdCtrls, forms,
  Comobj, Activex, Math, AdvStyleIF, ImgList,
  GDIPPictureContainer, GDIPFill, AdvSmoothPanel,
  AdvGDIP
  {$IFDEF TMSDOTNET}
  , Types
  {$ENDIF}
  ;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 0; // Minor version nr.
  REL_VER = 2; // Release nr.
  BLD_VER = 8; // Build nr.

type
  TERPSmoothExpanderPanel = class;

  TAdvSmoothExpanderPanelShape = (esRounded, esRoundRect, esRect);

  TERPSmoothExpanderPanel = class(TAdvSmoothPanel)
  private
    DisableLine: Boolean;
    FEnableResize, FDoAnimate: Boolean;
    FOldHeight, FExpHeight, FExpHeightTo: Double;
    FExpTimer: TTimer;
    FDesignTime, FHover, FOldHover, FDown: Boolean;
    FExpanderColor: TColor;
    FExpanded: Boolean;
    FExpanderShape: TAdvSmoothExpanderPanelShape;
    FExpanderHoverColor: TColor;
    FExpanderDownColor: TColor;
    FExpanderSize: integer;
    FExpanderBorderColor: TColor;
    FExpanderLocation: TAdvSmoothPanelLocation;
    FExpanderTop: integer;
    FExpanderLeft: integer;
    FAnimationFactor: integer;
    FMinimumPanelHeight: integer;
    FShowExpander: Boolean;
    FOnExpandPanel: TNotifyEvent;
    procedure SetExpanderColor(const Value: TColor);
    procedure SetExpanderDownColor(const Value: TColor);
    procedure SetExpanderHoverColor(const Value: TColor);
    procedure SetExpanderShape(const Value: TAdvSmoothExpanderPanelShape);
    procedure SetExpanderSize(const Value: integer);
    procedure SetExpanderBorderColor(const Value: TColor);
    procedure SetExpanderLocation(const Value: TAdvSmoothPanelLocation);
    procedure SetExpanderLeft(const Value: integer);
    procedure SetExpanderTop(const Value: integer);
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure SetAnimationFactor(const Value: integer);
    procedure SetMinimumPanelHeight(const Value: integer);
    procedure SetShowExpander(const Value: Boolean);
  protected
    procedure SetExpanded(const Value: Boolean); virtual;
    procedure Changed;
    procedure DrawExpander(g: TGPGraphics; r: TGPRectF; Down, Hover: Boolean);
    function InsideRect: TRect;
    function GetExpanderRect: TGPRectF;
    function GetVersionNr: integer; override;
    procedure GetPosition(var x, y: Double; rectangle: TGPRectF; objectwidth, objectheight: Double; location: TAdvSmoothPanelLocation);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure AnimateExpand(Sender: TObject);
    procedure GDIPPaint(g: TGPGraphics); override;
    function IsResizeEnabled: Boolean;
    procedure SetResizeEnabled(Resize: boolean);
    function PtInGPRect(r: TGPRectF; pt: TPoint): Boolean;
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadCustomProperty(Reader: TReader);
    procedure WriteCustomProperty(Writer: TWriter);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure SetComponentStyle(AStyle: TTMSStyle);
    procedure Resize; override;
    procedure Loaded; override;
    procedure Collapse;
    procedure Expand;
    property ExpandedHeight: Double read FOldHeight write FOldHeight;
  published
    property AnimationFactor: integer read FAnimationFactor write SetAnimationFactor default 4;
    property ShowExpander: Boolean read FShowExpander write SetShowExpander default true;
    property ExpanderBorderColor: TColor read FExpanderBorderColor write SetExpanderBorderColor default clBlack;
    property ExpanderLocation: TAdvSmoothPanelLocation read FExpanderLocation write SetExpanderLocation default plTopRight;
    property ExpanderLeft: integer read FExpanderLeft write SetExpanderLeft default 0;
    property ExpanderTop: integer read FExpanderTop write SetExpanderTop default 0;
    property ExpanderSize: integer read FExpanderSize write SetExpanderSize default 16;
    property Expanded: Boolean read FExpanded write SetExpanded default true;
    property ExpanderColor: TColor read FExpanderColor write SetExpanderColor default clWhite;
    property ExpanderDownColor: TColor read FExpanderDownColor write SetExpanderDownColor default clWhite;
    property ExpanderHoverColor: TColor read FExpanderHoverColor write SetExpanderHoverColor default clWhite;
    property ExpanderShape: TAdvSmoothExpanderPanelShape read FExpanderShape write SetExpanderShape default esRoundRect;
    property MinimumPanelHeight: integer read FMinimumPanelHeight write SetMinimumPanelHeight default 44;
    property OnExpandPanel: TNotifyEvent read FOnExpandPanel write FOnExpandPanel;
  end;

implementation

uses
  CommCtrl, ShellApi;

{$IFNDEF DELPHI7_LVL}

const
  CS_DROPSHADOW = $00020000;

{$ENDIF}
//{$i GDIPHTMLEngine.pas}

function AnimateDouble(var Start: Single; Stop, Delta, Margin: Single): Boolean;
begin
  Result := true;
  if (Start > Stop - Margin) and (Start < Stop + Margin) then
  begin
    Start := Stop;
    Result := false;
  end
  else
  begin
    Delta := Max(1, Delta);
    if Start < Stop then
      Start := Round(Start + Delta)
    else
      Start := Round(Start - Delta);
  end;
end;

function Lighter(Color:TColor; Percent:Byte):TColor;
var
  r, g, b:Byte;
begin
  Color := ColorToRGB(Color);
  r := GetRValue(Color);
  g := GetGValue(Color);
  b := GetBValue(Color);
  r := r + muldiv(255 - r, Percent, 100); //Percent% closer to white
  g := g + muldiv(255 - g, Percent, 100);
  b := b + muldiv(255 - b, Percent, 100);
  result := RGB(r, g, b);
end;

procedure TERPSmoothExpanderPanel.AnimateExpand(Sender: TObject);
var
  hto: Single;
  d: Double;
  a: Boolean;
begin
  if FDoAnimate then
  begin
    d := Abs(FExpHeightTo - FExpHeight) / AnimationFactor;
    hto := FExpHeight;
    a := AnimateDouble(hto, FExpHeightTo, d, 0.1);
    if a then
    begin
      FEnableResize := false;
      Height := Round(hto);
      Changed;
      FExpHeight := Height;
      FEnableResize := true;
    end
    else
    begin
      if Assigned(FOnExpandPanel) then
        FOnExpandPanel(Self);

      if not DisableLine then
        Caption.Line := Expanded;

      FDoAnimate := false;
    end;
  end;
end;

procedure TERPSmoothExpanderPanel.Assign(Source: TPersistent);
begin
  if (Source is TERPSmoothExpanderPanel) then
  begin
    FExpanderShape := (Source as TERPSmoothExpanderPanel).ExpanderShape;
    FExpanderColor := (Source as TERPSmoothExpanderPanel).ExpanderColor;
    FExpanderHoverColor := (Source as TERPSmoothExpanderPanel).ExpanderHoverColor;
    FExpanderDownColor := (Source as TERPSmoothExpanderPanel).ExpanderDownColor;
    FExpanderSize := (Source as TERPSmoothExpanderPanel).ExpanderSize;
    FExpanderBorderColor := (Source as TERPSmoothExpanderPanel).ExpanderBorderColor;
    FExpanded := (Source as TERPSmoothExpanderPanel).Expanded;
    FExpanderLeft := (Source as TERPSmoothExpanderPanel).ExpanderLeft;
    FExpanderTop := (Source as TERPSmoothExpanderPanel).ExpanderTop;
    FMinimumPanelHeight := (Source as TERPSmoothExpanderPanel).MinimumPanelHeight;
    FShowExpander := (Source as TERPSmoothExpanderPanel).ShowExpander;
    Changed;
  end;
end;

procedure TERPSmoothExpanderPanel.Changed;
begin
  inherited;
  Invalidate;
end;

procedure TERPSmoothExpanderPanel.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if FHover or FDown then
  begin
    FDown := false;
    FHover := false;
    Changed;
  end;
end;

procedure TERPSmoothExpanderPanel.Collapse;
begin
  if Expanded then
    Expanded := false;
end;

constructor TERPSmoothExpanderPanel.Create(AOwner: TComponent);
begin
  inherited;
  Height := 44;
  DoubleBuffered := true;
  Cursor := crDefault;
  FMinimumPanelHeight := 44; //32;
  FExpHeight := Height;
  FOldHeight := Height;
  FExpanderColor := clWhite;
  FExpanderShape := esRoundRect;
  FExpanderColor := clGray;
  FExpanderHoverColor := clBlue;
  FExpanderDownColor := clRed;
  FExpanderSize := 16;
  FExpanderBorderColor := clBlack;
  FExpanderLocation := plTopRight;
  FExpanderLeft := 0;
  FExpanderTop := 0;
  FExpanded := false; //true;
  FEnableResize := true;
  FExpTimer := TTimer.Create(Self);
  FExpTimer.Interval := 10;
  FExpTimer.OnTimer := AnimateExpand;
  FAnimationFactor := 4;
  FShowExpander := true;

  FDesignTime := (csDesigning in ComponentState) and not
    ((csReading in Owner.ComponentState) or (csLoading in Owner.ComponentState));

  Width := 276;
  Height := 44; //128;

  if FDesignTime then
    SetComponentStyle(tsOffice2007Luna);

  Caption.ColorStart := $00B0721C;
  Caption.ColorEnd := $009F661A;
  Caption.LineColor := $00B0721C;
  Caption.Line := false;

  ExpanderBorderColor := clBlack;
  ExpanderColor := $00FAF1E9;
  ExpanderDownColor := $00EDD8C7;
  ExpanderHoverColor := $00AAD9FF;

  Fill.Color := 16445929;
  Fill.ColorTo := 15587527;
  Fill.ColorMirror := 15587527;
  Fill.ColorMirrorTo := 16773863;
  Fill.GradientMirrorType := gtVertical;
  Fill.BorderColor := 14922381;
  Fill.Rounding := 6; //10;
  Fill.ShadowOffset := 10;

  Caption.Font.Size := 12;
  Caption.Font.Name := 'Arial';
  Caption.Font.Style := [fsBold];
end;

procedure TERPSmoothExpanderPanel.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('OldHeight', ReadCustomProperty, WriteCustomProperty, True);
end;

destructor TERPSmoothExpanderPanel.Destroy;
begin
  inherited;
end;

procedure TERPSmoothExpanderPanel.DrawExpander(g: TGPGraphics; r: TGPRectF;
  Down, Hover: Boolean);
var
  ct: TColor;
  fl: TGDIPFill;
  p: TGPPen;
begin
  g.SetSmoothingMode(SmoothingModeAntiAlias);
  fl := TGDIPFill.Create;
  fl.GradientType := gtVertical;
  fl.GradientMirrorType := gtVertical;
  case ExpanderShape of
    esRounded:
    begin
      fl.RoundingType := rtBoth;
      fl.Rounding := Round(ExpanderSize / 2);
    end;
    esRoundRect:
    begin
      fl.RoundingType := rtBoth;
      fl.Rounding := Round(ExpanderSize / 4);
    end;
  end;

  fl.BorderColor := ExpanderBorderColor;

  if Down then
  begin
    ct := ExpanderDownColor;
    fl.Color := Lighter(ct, 60);
    fl.ColorTo := ct;
  end
  else if Hover then
  begin
    ct := ExpanderHoverColor;
    fl.Color := Lighter(ct, 60);
    fl.ColorTo := ct;
  end
  else
  begin
    ct := ExpanderColor;
    fl.Color := Lighter(ct, 60);
    fl.ColorTo := ct;
  end;

  if ct <> clNone then
    fl.Fill(g, r);

  //DRAW SIGN
  p := TGPPen.Create(MakeColor(255, clBlack), 1);
  if not FExpanded then
  begin
    g.DrawLine(p, r.X + (r.Width / 2), r.Y + (r.Height / 4 * 2), r.X + (r.Width / 3), r.Y + (r.Height / 4));
    g.DrawLine(p, r.X + (r.Width / 2), r.Y + (r.Height / 4 * 2), r.X + (r.Width / 3 * 2), r.Y + (r.Height / 4));
    g.DrawLine(p, r.X + (r.Width / 2), r.Y + (r.Height / 4 * 3), r.X + (r.Width / 3), r.Y + (r.Height / 4 * 2));
    g.DrawLine(p, r.X + (r.Width / 2), r.Y + (r.Height / 4 * 3), r.X + (r.Width / 3 * 2), r.Y + (r.Height / 4 * 2));
  end
  else
  begin
    g.DrawLine(p, r.X + (r.Width / 2), r.Y + (r.Height / 4), r.X + (r.Width / 3), r.Y + (r.Height / 4 * 2));
    g.DrawLine(p, r.X + (r.Width / 2), r.Y + (r.Height / 4), r.X + (r.Width / 3 * 2), r.Y + (r.Height / 4 * 2));
    g.DrawLine(p, r.X + (r.Width / 2), r.Y + (r.Height / 4 * 2), r.X + (r.Width / 3), r.Y + (r.Height / 4 * 3));
    g.DrawLine(p, r.X + (r.Width / 2), r.Y + (r.Height / 4 * 2), r.X + (r.Width / 3 * 2), r.Y + (r.Height / 4 * 3));
  end;

  p.Free;
  fl.Free;
  g.SetSmoothingMode(SmoothingModeDefault);
end;

procedure TERPSmoothExpanderPanel.Expand;
begin
  if not Expanded then
    Expanded := true;
end;

function Choose(A,B: integer; choice: boolean): integer;
begin
  if choice then
    Result := B
  else
    Result := A;
end;

procedure TERPSmoothExpanderPanel.ReadCustomProperty(Reader: TReader);
begin
  FOldHeight := Reader.ReadFloat;
end;

procedure TERPSmoothExpanderPanel.Resize;
begin
  inherited;
  if (csDesigning in ComponentState) and FEnableResize and Expanded then
    FOldHeight := Height;
end;

procedure TERPSmoothExpanderPanel.GDIPPaint(g: TGPGraphics);
begin
  inherited;
  if ShowExpander then
    DrawExpander(g, GetExpanderRect, FDown, FHover);
end;

function TERPSmoothExpanderPanel.GetExpanderRect: TGPRectF;
var
  x, y: double;
  r: TRect;
begin
  r := InsideRect;
  if ExpanderLocation <> plCustom then
    GetPosition(x, y, MakeRect(r.Left, r.Top, r.Right, r.Bottom), ExpanderSize, ExpanderSize, ExpanderLocation)
  else
  begin
    x := ExpanderLeft;
    y := ExpanderTop;
  end;

  Result := MakeRect(X, y, ExpanderSize, ExpanderSize);
end;

procedure TERPSmoothExpanderPanel.GetPosition(var x, y: Double;
  rectangle: TGPRectF; objectwidth, objectheight: Double;
  location: TAdvSmoothPanelLocation);
var
  w, h, tw, th: Double;
begin
  tw := objectwidth;
  th := objectheight;
  w := rectangle.Width;
  h := rectangle.Height;

  case location of
    plTopLeft:
    begin
      x := rectangle.X;
      y := rectangle.Y;
    end;
    plTopRight:
    begin
      x := Max(rectangle.X, w - tw);
      y := rectangle.Y;
    end;
    plBottomLeft:
    begin
      x := rectangle.X;
      y := h - th;
    end;
    plBottomRight:
    begin
      x := Max(rectangle.X, w - tw);
      y := h - th;
    end;
    plTopCenter:
    begin
      x := Max(rectangle.X, w - tw) / 2;
      y := rectangle.Y;
    end;
    plBottomCenter:
    begin
      x := Max(rectangle.X, w - tw) / 2;
      y := h - th;
    end;
    plCenterCenter:
    begin
      x := Max(rectangle.X, w - tw) / 2;
      y := (h - th) / 2;
    end;
    plCenterLeft:
    begin
      x := rectangle.x;
      y := (h - th) / 2;
    end;
    plCenterRight:
    begin
      x := Max(rectangle.X, w - tw);;
      y := (h - th) / 2;
    end;
  end;
end;

function TERPSmoothExpanderPanel.GetVersionNr: integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

function TERPSmoothExpanderPanel.InsideRect: TRect;
var
  bw: integer;
begin
  Result := ClientRect;
  // adapt width & height for GDI+ drawing rect
  Result.Right := Result.Right - 1;
  Result.Bottom := Result.Bottom - 1;

  if (Fill.BorderColor <> clNone) then
  begin
    if Fill.BorderWidth = 1 then
      bw := 1
    else
      bw := (Fill.BorderWidth + 1) div 2;

    InflateRect(Result, -bw, -bw);
  end;

  if (Fill.ShadowOffset <> 0) and (Fill.ShadowColor <> clNone) then
  begin
    Result.Right := Result.Right -Fill.ShadowOffset;
    Result.Bottom := Result.Bottom -Fill.ShadowOffset;
  end;

  Result.Left := Result.Left + 2;
  Result.Right := Result.Right - 2;
  Result.Top := Result.Top + 2;
  Result.Bottom := Result.Bottom - 2;
end;

function TERPSmoothExpanderPanel.IsResizeEnabled: Boolean;
begin
  Result := FEnableResize;
end;

procedure TERPSmoothExpanderPanel.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_F4 then
    Expanded := not Expanded;
end;

procedure TERPSmoothExpanderPanel.Loaded;
begin
  inherited;
  if not Caption.Line then
    DisableLine := true;

//  if FEnableResize and Expanded then
//    FOldHeight := Height;
end;

procedure TERPSmoothExpanderPanel.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  if ShowExpander then
  begin
    FDown := PtInGPRect(GetExpanderRect, Point(X, Y));
    if FDown then
      Changed;
  end;
end;

procedure TERPSmoothExpanderPanel.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if ShowExpander then
  begin
    FHover := PtInGPRect(GetExpanderRect, Point(X, Y));
    if FHover then
    begin
      if not FOldHover then
      begin
        FOldHover := true;
        Changed;
      end;
    end
    else
    begin
      if FOldHover then
      begin
        FOldHover := false;
        Changed;
      end;
    end;
  end;
end;

procedure TERPSmoothExpanderPanel.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if ShowExpander then
  begin
    FDown := false;
    if PtInGPRect(GetExpanderRect, Point(X, Y)) then
      Expanded := not Expanded;

    Changed;
  end;
end;

function TERPSmoothExpanderPanel.PtInGPRect(r: TGPRectF; pt: TPoint): Boolean;
begin
  result := ((pt.X >= r.X) and (pt.X <= r.X + r.Width)) and
     ((pt.Y >= r.Y) and (pt.Y <= r.Y + r.Height));
end;

procedure TERPSmoothExpanderPanel.SetAnimationFactor(const Value: integer);
begin
  if FAnimationFactor <> value then
  begin
    FAnimationFactor := Max(1, Value);
    Changed;
  end;
end;

procedure TERPSmoothExpanderPanel.SetComponentStyle(AStyle: TTMSStyle);
begin
  inherited;
  ExpanderBorderColor := clBlack;
  ExpanderColor := Fill.Color;
  ExpanderDownColor := Fill.ColorTo;
  ExpanderHoverColor := $AAD9FF;
end;

procedure TERPSmoothExpanderPanel.SetExpanded(const Value: Boolean);
begin
  FExpanded := Value;
  if value and (not Caption.Line) then
    Caption.LineColor := Fill.Color;
  if not DisableLine then
    Caption.Line := Expanded;
  if (csDesigning in ComponentState) then
  begin
    FEnableResize := false;
    if FExpanded then
      Height := Round(FOldHeight)
    else
      Height := FMinimumPanelHeight;

    FExpHeight := Height;
    FExpHeightTo := Height;
    FEnableResize := true;
    if Assigned(FOnExpandPanel) then
      FOnExpandPanel(Self);
  end
  else
  begin
    if (csLoading in ComponentState) then
    begin
      if not FExpanded then
      begin
        FExpHeight := FMinimumPanelHeight;
        FExpHeightTo := FMinimumPanelHeight;
      end
      else
      begin
        FExpHeight := Height;
        FExpHeightTo := Height;
      end;
    end
    else
    begin
      FDoAnimate := true;
      if FExpanded then
        FExpHeightTo := Round(FOldHeight)
      else
        FExpHeightTo := FMinimumPanelHeight;
    end;
  end;

  Changed;
end;

procedure TERPSmoothExpanderPanel.SetExpanderBorderColor(const Value: TColor);
begin
  if FExpanderBorderColor <> value then
  begin
    FExpanderBorderColor := Value;
    Changed;
  end;
end;

procedure TERPSmoothExpanderPanel.SetExpanderColor(const Value: TColor);
begin
  if FExpanderColor <> value then
  begin
    FExpanderColor := Value;
    Changed;
  end;
end;

procedure TERPSmoothExpanderPanel.SetExpanderDownColor(const Value: TColor);
begin
  if FExpanderDownColor <> value then
  begin
    FExpanderDownColor := Value;
    changed;
  end;
end;

procedure TERPSmoothExpanderPanel.SetExpanderHoverColor(const Value: TColor);
begin
  if FExpanderHoverColor <> Value then
  begin
    FExpanderHoverColor := Value;
    Changed;
  end;
end;

procedure TERPSmoothExpanderPanel.SetExpanderLeft(const Value: integer);
begin
  if FExpanderLeft <> value then
  begin
    FExpanderLeft := Value;
    Changed;
  end;
end;

procedure TERPSmoothExpanderPanel.SetExpanderLocation(
  const Value: TAdvSmoothPanelLocation);
begin
  if FExpanderLocation <> value then
  begin
    FExpanderLocation := Value;
    Changed;
  end;
end;

procedure TERPSmoothExpanderPanel.SetExpanderShape(
  const Value: TAdvSmoothExpanderPanelShape);
begin
  if FExpanderShape <> value then
  begin
    FExpanderShape := Value;
    Changed;
  end;
end;

procedure TERPSmoothExpanderPanel.SetExpanderSize(const Value: integer);
begin
  if FExpanderSize <> value then
  begin
    FExpanderSize := Value;
    Changed;
  end;
end;

procedure TERPSmoothExpanderPanel.SetExpanderTop(const Value: integer);
begin
  if FExpanderTop <> value then
  begin
    FExpanderTop := Value;
    Changed;
  end;
end;

procedure TERPSmoothExpanderPanel.SetMinimumPanelHeight(const Value: integer);
begin
  if FMinimumPanelHeight <> value then
  begin
    FMinimumPanelHeight := Value;
//    SetExpanded(Expanded);
    Changed;
  end;
end;

procedure TERPSmoothExpanderPanel.SetResizeEnabled(Resize: boolean);
begin
  FEnableResize := Resize;
end;

procedure TERPSmoothExpanderPanel.SetShowExpander(const Value: Boolean);
begin
  if FShowExpander <> value then
  begin
    FShowExpander := Value;
    Changed;
  end;
end;

procedure TERPSmoothExpanderPanel.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  if TabStop then
    Message.Result := DLGC_WANTALLKEYS or DLGC_WANTARROWS
  else
    Message.Result := 0;
end;

procedure TERPSmoothExpanderPanel.WMWindowPosChanged(
  var Message: TWMWindowPosChanged);
begin
//  if (csDesigning in ComponentState) or FDoAnimate then
//    invalidate
//  else if (Fill.ShadowColor <> clNone) and (Fill.ShadowOffset > 0) then
    Invalidate;

  inherited;
end;

procedure TERPSmoothExpanderPanel.WriteCustomProperty(Writer: TWriter);
begin
  Writer.WriteFloat(FOldHeight);
end;
end.
