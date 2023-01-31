                                         unit ImageDLLLib;

interface

uses
Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  DNMPanel, Dialogs, StdCtrls, Buttons, AdvGlowButton, ERPDrawUtils, ExtCtrls, ActnList, Types;

type
  TPointPosArray = array[0..7] of integer;
  TButtonState = (stNone, stSelected, stMoving, stResizing);
  TButtonStates = set of TButtonState;

const
  csPointPos : TPointPosArray = (HTTOPLEFT, HTTOP, HTTOPRIGHT, HTRIGHT, HTBOTTOMRIGHT, HTBOTTOM, HTBOTTOMLEFT, HTLEFT);

type
  TERPMainSwitchButtonColors = Array of Tcolor;

  TERPMainSwitchButton = class(TAdvGlowButton)
    Private
    fDnMAction: TAction;
    fbUseLargeIcon: boolean;
    fSinglecolor: TColor;
    fBorderColor: TColor;
    fGradientColor: TColor;
    fGradientColorTo: TColor;
    fColors: TERPMainSwitchButtonColors;
    function GetImageIndex: Integer;
    procedure SetDnMAction(const Value: TAction);
    procedure SetSinglecolor(const Value: TColor);
    procedure SetBorderColor(const Value: TColor);
    procedure SetGradientColor(const Value: TColor);
    procedure SetGradientColorTo(const Value: TColor);
    procedure SetColors(const Value: TERPMainSwitchButtonColors);

    Public
      constructor Create(AOwner :TComponent);override;
      Destructor Destroy;Override;
      Property ImageIndex:Integer read GetImageIndex;
      Property DnMAction :TAction read fDnMAction write setDnMAction;
      Property UseLargeIcon :boolean read fbUseLargeIcon write fbUseLargeIcon;
      Property Singlecolor : TColor read fSinglecolor write SetSinglecolor;
      Property BorderColor : TColor read fBorderColor write SetBorderColor;
      Property GradientColor : TColor read fGradientColor write SetGradientColor;
      Property GradientColorTo : TColor read fGradientColorTo write SetGradientColorTo;
      Property Colors : TERPMainSwitchButtonColors read fColors write setColors;
      Procedure ButtonBoarderColour(AColor:TColor);


  end;

  TERPMainSwitchMovingButton = class(TERPMainSwitchButton)
  private
    fState: TButtonStates;
    fOnExitSizeMove: TNotifyEvent;
    fSelectedColor: TColor;
    fMarkSize: integer;
    fPointPos: integer;
    fMouseY: integer;
    fMouseX: integer;
    fOnEnterSizeMove: TNotifyEvent;
    fClickSender: TObject;
    fAllowMoving: boolean;
    FOldTop: integer;
    FOldHeight: integer;
    FOldLeft: integer;
    FOldWidth: integer;
    fOnSelected: TNotifyEvent;
    procedure SetSelected(const Value: boolean);
    function GetSelected: boolean;
    function GetEditMove: boolean;
    procedure SetOldHeight(const Value: integer);
    procedure SetOldLeft(const Value: integer);
    procedure SetOldTop(const Value: integer);
    procedure SetOldWidth(const Value: integer);
  protected
    procedure Paint;override;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMExitSizeMove(var Msg: TMessage) ;  message WM_EXITSIZEMOVE ;
    procedure WMEnterSizeMove(var Msg: TMessage) ;  message WM_ENTERSIZEMOVE ;
    procedure WMCAPTURECHANGED(var Msg : TMessage); message WM_CAPTURECHANGED;
    procedure WMWindowPosChanging(var Message: TWMWindowPosChanging); message WM_WINDOWPOSCHANGING;
//    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
//    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;

    procedure DoExitSizeMove;
    procedure DoEnterSizeMove;
//    procedure DoMouseDownEvent(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    procedure PaintSelected;
    function MarkRect(No : integer) : TRect;

    function MyPoint(X, y : integer) : boolean;
    function RoughlyMyPoint(x,y : integer) : boolean;

    procedure DoSelected(X, Y : integer);

//    property Selected : boolean read GetSelected write SetSelected;
    property EditMode : boolean read GetEditMove;
    property PointPos : integer read fPointPos write fPointPos;
    property MouseX : integer read fMouseX write fMouseX;
    property MouseY : integer read fMouseY write fMouseY;
    property ClickSender : TObject read fClickSender write fClickSender;
    property AllowMoving : boolean read fAllowMoving write fAllowMoving;
    property OldTop : integer read FOldTop write SetOldTop;
    property OldLeft : integer read FOldLeft write SetOldLeft;
    property OldWidth : integer read FOldWidth write SetOldWidth;
    property OldHeight : integer read FOldHeight write SetOldHeight;
  public
    constructor Create(AOwner : TComponent);override;
    procedure Click; override;
    procedure StartMoving;
    procedure StopMoving;
    procedure CancelMoving;
    procedure Highlight(Edge : TButtonEdge; HighlightColor : TColor);
    property State : TButtonStates read fState write fState;
    property Selected : boolean read GetSelected write SetSelected;
  published
    property MarkSize : integer read fMarkSize write fMarkSize;
    property SelectedColor : TColor read fSelectedColor write fSelectedColor;

    property OnExitSizeMove : TNotifyEvent read fOnExitSizeMove write fOnExitSizeMove;
    property OnEnterSizeMove : TNotifyEvent read fOnEnterSizeMove write fOnEnterSizeMove;

    // Is Sent when the button receives Selected state
    property OnSelected : TNotifyEvent read fOnSelected write fOnSelected;
  end;

const
  TotalImages = 767;

Function btnSize(form :Tform; pnl:TDnmPanel; btnwidth:Boolean ; btnheight:boolean):Integer;
Procedure AlignbuttonTopnHeight(form :Tform; pnl:TDnmPanel; CalcEqual:boolean = False);
Procedure AlignbuttonLeftnWidth(form :Tform; pnl:TDnmPanel; CalcEqual:boolean = False);

implementation

uses
  DnMAction, AdvGDIP , pngimage, CommonLib ,
  ImagesDataModule, LogLib;

Function btnSize(form :Tform; pnl:TDnmPanel; btnwidth:Boolean ; btnheight:boolean):Integer;
var
  ctr:Integer;
  icount:Integer;
  imargins:Integer;
begin
  result := 0;
  icount:=0;
  imargins:=0;

  for ctr:= 0 to form.componentcount-1 do
    if (form.components[ctr] is TERPMainSwitchButton)and (TERPMainSwitchButton(form.components[ctr]).Parent =pnl) then
      if (TERPMainSwitchButton(form.components[ctr]).visible) and ((Assigned(TERPMainSwitchButton(form.components[ctr]).action)) and (TDnmaction(TERPMainSwitchButton(form.components[ctr]).action).visible)) then begin
        icount := icount +1;
        if TERPMainSwitchButton(form.components[ctr]).align <> alnone then
          if TERPMainSwitchButton(form.components[ctr]).alignwithmargins then
            if btnwidth then imargins := imargins + TERPMainSwitchButton(form.components[ctr]).margins.left + TERPMainSwitchButton(form.components[ctr]).Margins.right
                        else imargins := imargins + TERPMainSwitchButton(form.components[ctr]).margins.top  + TERPMainSwitchButton(form.components[ctr]).Margins.bottom;
      end;

  if icount >0 then
    if btnwidth then result := trunc((pnl.width - imargins) / icount)
    else result := trunc((pnl.height-imargins) / icount);


end;

Procedure AlignbuttonTopnHeight(form :Tform; pnl:TDnmPanel; CalcEqual:boolean = False);
var
  ctr:Integer;
  itop,iheight:Integer;
begin
  itop:= -1;

  if CalcEqual then iheight:=btnSize(form, pnl , false , true) else iheight:=-1;

  for ctr:= 0 to form.componentcount-1 do
    if (form.components[ctr] is TERPMainSwitchButton)and (TERPMainSwitchButton(form.components[ctr]).Parent =pnl) then begin
        if itop= -1 then itop := TERPMainSwitchButton(form.components[ctr]).top;
        if iheight= -1 then iheight := TERPMainSwitchButton(form.components[ctr]).height;

        TERPMainSwitchButton(form.components[ctr]).top:= itop;
        TERPMainSwitchButton(form.components[ctr]).height := iheight;
    end;


end;

Procedure AlignbuttonLeftnWidth(form :Tform; pnl:TDnmPanel; CalcEqual:boolean = False);
var
  ctr:Integer;
  ileft,iWidth:Integer;
begin
  ileft:= -1;
  if CalcEqual then iWidth:=btnSize(form , pnl , true , false) else iWidth:= -1;

  for ctr:= 0 to form.componentcount-1 do
    if (form.components[ctr] is TERPMainSwitchButton)and (TERPMainSwitchButton(form.components[ctr]).Parent =pnl) then begin
        if ileft= -1 then ileft := TERPMainSwitchButton(form.components[ctr]).left;
        if iWidth= -1 then iWidth := TERPMainSwitchButton(form.components[ctr]).Width;

        TERPMainSwitchButton(form.components[ctr]).left:= ileft;
        TERPMainSwitchButton(form.components[ctr]).Width := iWidth;
    end;
end;

{ TERPMainSwitchButton }

constructor TERPMainSwitchButton.Create(AOwner: TComponent);
begin
  inherited;
  UseLargeIcon := True;
  Layout := blGlyphTop;
  Font.Color := clBlack;
  Font.Name := 'Arial';
  Font.Style := Font.Style - [fsBold];
  Font.Size := 8;


  NotesFont.Charset := DEFAULT_CHARSET;
  NotesFont.Color := clWindowText;
  NotesFont.Height := -12;
  NotesFont.Name := 'Arial';
  NotesFont.Style := [];
  ParentFont := False;

  Focustype := ftBorder;

  Appearance.BorderColor := clBlack;
  Appearance.BorderColorHot := clBlack;
  Appearance.BorderColorDown := clBlack;
  Appearance.BorderColorChecked := clBlack;
  Appearance.BorderColorDisabled := clBlack;

  // 1st color : ColorTO
  // 2nd color : color
  // 3rd color : color Mirror
  // 4th color : ColorMirrorto

  Appearance.ColorChecked   := clMoneyGreen; Appearance.ColorMirrorChecked  := clMoneyGreen;
  Appearance.ColorCheckedTo := clAqua      ; Appearance.ColorMirrorCheckedTo:= clAqua;

  Appearance.ColorDisabled    := clSilver; Appearance.ColorMirrorDisabled   := clSilver;
  Appearance.ColorDisabledTo  := clSilver; Appearance.ColorMirrorDisabledTo := clSilver;

  Appearance.ColorDown    := clMoneyGreen; Appearance.ColorMirrorDown   := clMoneyGreen;
  Appearance.ColorDownTo  := clAqua      ; Appearance.ColorMirrorDownTo := clAqua;

  Appearance.ColorHot   := clSkyBlue; Appearance.ColorMirrorHot   := clSkyBlue;
  Appearance.ColorHotTo := clWhite  ; Appearance.ColorMirrorHotTo := clWhite;

  Appearance.Color    := clwhite;  Appearance.Colormirror   := clwhite;
  Appearance.ColorTo  := clwhite;  Appearance.ColormirrorTo := clwhite;

  AntiAlias := aaNone;

  Rounded := False;

  Picture := nil;
end;

destructor TERPMainSwitchButton.Destroy;
begin
  Picture := nil;
  DNMAction := nil;
  inherited;
end;

function TERPMainSwitchButton.GetImageIndex: Integer;
begin
  Result := -1;
  if Assigned(Action) then
    if action is TDnMAction then
      Result := (Action as TDnMAction).ImageIndex;
end;

procedure TERPMainSwitchButton.ButtonBoarderColour(AColor:TColor);
begin
	Appearance.BorderColor := AColor ;
  Appearance.BorderColorHot := AColor ;
  Appearance.BorderColorDown := AColor ;
  Appearance.BorderColorChecked := AColor ;
  Appearance.BorderColorDisabled := AColor ;
end;

procedure TERPMainSwitchButton.SetColors(const Value: TERPMainSwitchButtonColors);
begin
  fColors := Value;
  if Length(fColors)<=0 then exit;
  if Length(fColors) >= 1 then Singlecolor := fColors[0];
  if Length(fColors) >= 2 then BorderColor := fColors[1];
  if Length(fColors) >= 3 then GradientColor := fColors[2];
  if Length(fColors) >= 4 then GradientColorTo := fColors[3];

end;

procedure TERPMainSwitchButton.SetDnMAction(const Value: TAction);
var
  lBitmap : TBitmap;
  lImages : TImageList;
begin
  fDnMAction := Value;
  Action :=Value;
  try
    if Assigned(Value) then begin
      if ImageIndex >=0 then
      begin
        lBitmap := TBitmap.Create;
        if UseLargeIcon then
          lImages := ImgDataModule.ImageList//.GetBitmap(ImageIndex, lBitmap)
        else
          lImages := ImgDataModule.ImageListSmlIcons;//.GetBitmap(ImageIndex, lBitmap);
        lImages.GetBitmap(ImageIndex-1, lBitmap);
        Picture.Assign(lBitmap);
        lBitmap.Free;      //  Assign() makes a copy of the bitmap....
      end;
      if Value.hint <> '' then begin
        hint := Value.hint+ chr(13);
        ShowHint := True;
      end else if devmode then begin
        hint := Value.Caption + chr(13) + Value.name+ chr(13);
        ShowHint := True;
      end else begin
        hint := Value.Caption+ chr(13);
        ShowHint := True;
      end;
    end;
  Except
    on E:Exception do begin
      messagebox(0, PChar(e.Message), 'ttt', mb_ok);
    end;
  end;
end;

procedure TERPMainSwitchButton.SetBorderColor(const Value: TColor);
begin
  Appearance.BorderColor := Value;
  Appearance.BorderColorHot := Value;
  Appearance.BorderColorDown := Value;
  Appearance.BorderColorChecked := Value;
  Appearance.BorderColorDisabled := Value;
end;

procedure TERPMainSwitchButton.SetGradientColorTo(const Value: TColor);
begin
  Appearance.ColorDownTo := Value;
  Appearance.ColorHotTo := Value;
  Appearance.ColorMirrorHotTo := Value;
  Appearance.ColorMirrorDownTo := Value;

end;

procedure TERPMainSwitchButton.SetGradientColor(const Value: TColor);
begin
  Appearance.ColorDown := Value;
  Appearance.ColorHot := Value;
  Appearance.ColorMirrorHot := Value;
  Appearance.ColorMirrorDown := Value;
end;

procedure TERPMainSwitchButton.SetSinglecolor(const Value: TColor);
begin
  fSinglecolor := Value;
  Appearance.Color := Value;
  Appearance.ColorTo := Value;
  Appearance.ColorChecked := Value;
  Appearance.ColorCheckedTo := Value;
  Appearance.ColorDisabled := Value;
  Appearance.ColorDisabledTo := Value;
  Appearance.ColorMirror := Value;
  Appearance.ColorMirrorTo := Value;
  Appearance.ColorMirrorChecked := Value;
  Appearance.ColorMirrorCheckedTo := Value;
  Appearance.ColorMirrorDisabled := Value;
  Appearance.ColorMirrorDisabledTo := Value;end;

{ TERPMainSwitchMovingButton }

procedure TERPMainSwitchMovingButton.CancelMoving;
begin
  AllowMoving := false;
  Top := OldTop;
  Left := OldLeft;
  Width := OldWidth;
  Height := OldHeight;
end;

procedure TERPMainSwitchMovingButton.Click;
begin
  // Do not Click - will check in MouseUp
//  inherited;
  if AllowMoving then
    ClickSender := Self
  else
    inherited;
end;
(*
procedure TERPMainSwitchMovingButton.CMMouseEnter(var Msg: TMessage);
begin

end;

procedure TERPMainSwitchMovingButton.CMMouseLeave(var Msg: TMessage);
begin
end;
*)
constructor TERPMainSwitchMovingButton.Create(AOwner: TComponent);
begin
  inherited;
//  OnMouseDown := DoMouseDownEvent;
  SelectedColor := clGreen;
  MarkSize := 4; //csMarkSize;
//  AllowMoving := true;
end;

procedure TERPMainSwitchMovingButton.DoEnterSizeMove;
begin
  if assigned(OnEnterSizeMove) then
    OnEnterSizeMove(Self);
end;

procedure TERPMainSwitchMovingButton.DoExitSizeMove;
begin
  if assigned(OnExitSizeMove) then
    OnExitSizeMove(Self);
end;

procedure TERPMainSwitchMovingButton.DoSelected;
begin
  if Assigned(OnSelected) then
    OnSelected(Self); //, X, Y);
end;

(*
procedure TERPMainSwitchMovingButton.DoMouseDownEvent(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

end;
*)
function TERPMainSwitchMovingButton.GetEditMove: boolean;
begin
  Result := State * [stMoving, stResizing] <> [];
end;

function TERPMainSwitchMovingButton.GetSelected: boolean;
begin
  Result := stSelected in State;
end;

procedure TERPMainSwitchMovingButton.Highlight(Edge: TButtonEdge;
  HighlightColor: TColor);

var
  HalfSize : integer;
  idx : integer;
  r : TRect;
  s : set of Byte;
begin

  HalfSize := MarkSize div 2;
  with Canvas do
  begin
    // "Line of Interest" is red, three pixels wide
    // Draw Borders
    Pen.Color := HighlightColor;
    Pen.Width := 2; //Width;
    case Edge of
      beLeft: begin
        MoveTo(HalfSize, HalfSize);
        LineTo(HalfSize, Height - HalfSize);
      end;
      beTop: begin
        MoveTo(HalfSize, HalfSize);
        LineTo(Width - HalfSize, HalfSize);
      end;
      beRight: begin
        MoveTo(Width - HalfSize, HalfSize);
        LineTo(Width - HalfSize, Height - HalfSize);
      end;
      beBottom: begin
        MoveTo(Width - HalfSize, Height - HalfSize);
        LineTo(HalfSize, Height - HalfSize);
      end;
    end;

    // Draw "Handles" on endpoints of line of interest
    Brush.Color := SelectedColor; //clLime;  // internal color
    Pen.Color := clBlack;   // border color
    Pen.Width := 1;         // border width
    case Edge of
      beLeft: s := [0,6,7];
      beTop: s := [0,1,2];
      beRight: s := [2,3,4];
      beBottom: s := [4,5,6];
    end;

    for idx := 0 to 7 do
    begin
      if idx in s then
      begin
        r := MarkRect(idx);
        Rectangle(r.Left, r.Top, r.right, r.bottom);
      end;
    end;
  end;
end;

function TERPMainSwitchMovingButton.MarkRect(No: integer): TRect;
var
  HalfSize : integer;
  HalfWidth,
  HalfHeight : integer;
begin
  if No < 0 then
    No := 0
  else if No > 7 then
    No := 7;

  HalfSize := MarkSize div 2;
  HalfWidth := Width div 2;
  HalfHeight := Height div 2;
  case No of
   0 : Result := Rect(0, 0, MarkSize, MarkSize);  // Top Left
   1 : Result := Rect(HalfWidth - HalfSize, 0, HalfWidth + HalfSize, MarkSize); // Top Middle
   2 : Result := Rect(Width - MarkSize, 0, Width, MarkSize);  // Top right
   3 : Result := Rect(Width - MarkSize, HalfHeight-HalfSize, Width, HalfHeight + HalfSize);  // Right middle
   4 : Result := Rect(Width - MarkSize, Height - MarkSize, Width, Height);  // Bottom right
   5 : Result := Rect(HalfWidth - HalfSize, Height - MarkSize, HalfWidth + HalfSize, Height);
   6 : Result := Rect(0, Height - MarkSize, MarkSize, Height);
   7 : Result := Rect(0, HalfHeight-HalfSize, MarkSize, HalfHeight + HalfSize);  // Left middle
  end;
end;

procedure TERPMainSwitchMovingButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  pt : TPoint;
begin
//  inherited; NO WAY
  if not AllowMoving then
  begin
    inherited;
    exit;
  end;

  if not PtInRect(Self.ClientRect, Point(x,y)) then
    exit;
  if assigned(OnMouseDown) then
    OnMouseDown(Self, Button, Shift, X, Y);

  if Selected then
  begin
    Screen.Cursor := crDrag;
    State := State + [stMoving];
    pt := ClientToScreen(Point(X,Y));
    MouseX := Pt.X;
    MouseY := Pt.Y;
  end;
end;

procedure TERPMainSwitchMovingButton.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  pt : TPoint;
begin
//  inherited;
  if not AllowMoving then
  begin
    inherited;
    exit;
  end;

  if not Selected then
    exit;


  if (State * [stMoving, stResizing] = []) then // and None then
      exit;

  if (State * [stMoving] <> []) then
  begin
    pt := ClientToScreen(Point(x,y));
    Left := Left + pt.x - MouseX;
    Top := Top + pt.y - MouseY;
    MouseX := pt.X;
    MouseY := pt.Y;
    invalidate;
  end;

  if assigned(OnMouseMove) then
    OnMouseMove(Self, Shift, X, Y);
end;

procedure TERPMainSwitchMovingButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  OldSelected : boolean;
begin
//  inherited;
  if not AllowMoving then
  begin
    inherited;
    exit;
  end;
  if not PtInRect(Self.ClientRect, Point(x,y)) then
    exit;
  OldSelected := Selected;
  Selected := not Selected;
  State := State - [stMoving, stResizing];
  if not Selected then
  begin
    Cursor := crDefault;
    if assigned(ClickSender) and not OldSelected then
    begin
      inherited Click;
      ClickSender := nil;
    end;
  end
  else
  begin
    DoSelected(X,Y);
  end;
  Screen.Cursor := Cursor;
  Repaint;

  if assigned(OnMouseUp) then
    OnMouseUp(Self, Button, Shift, X, Y);

end;

function TERPMainSwitchMovingButton.MyPoint(x, y: integer): boolean;
begin
  Result := PtInRect(Self.ClientRect, Point(x,y));
end;

procedure TERPMainSwitchMovingButton.Paint;
begin
  inherited;
  if Selected then
  begin
    PaintSelected;
  end;
(*
  if EditMode then
    DrawGripCorner(Rect(Left + Width - 15, Top + Height - 15, Left + Width, Top + Height), Canvas);
*)
end;

procedure TERPMainSwitchMovingButton.PaintSelected;
var
  HalfSize : integer;
  idx : integer;
  r : TRect;
begin

  HalfSize := MarkSize div 2;
  with Canvas do
  begin
    // "Line of Interest" is red, three pixels wide
    // Draw Borders
    Pen.Color := SelectedColor;
    Pen.Width := 2; //Width;
    MoveTo(HalfSize, HalfSize); //StartPoint.X, StartPoint.Y);
    LineTo(HalfSize, Height - HalfSize); //EndPoint.X, EndPoint.Y);
    LineTo(Width-HalfSize, Height-HalfSize);
    LineTo(Width-HalfSize, HalfSize);
    LineTo(HalfSize, HalfSize);

    // Draw "Handles" on endpoints of line of interest
    Brush.Color := SelectedColor; //clLime;  // internal color
    Pen.Color := clBlack;   // border color
    Pen.Width := 1;         // border width
    for idx := 0 to 7 do
    begin
      r := MarkRect(idx);
      Rectangle(r.Left, r.Top, r.right, r.bottom);
    end;
  end;
end;

function TERPMainSwitchMovingButton.RoughlyMyPoint(x, y: integer): boolean;
var
  r : TRect;
begin
  r := Rect(Self.Left, Self.Top, Self.Left + Self.Width, Self.Top + Self.Height);
//  r := Self.ClientRect;
  InflateRect(r, 8, 8);
  Result := PtInRect(r, Point(x,y));
end;

procedure TERPMainSwitchMovingButton.SetOldHeight(const Value: integer);
begin
  FOldHeight := Value;
end;

procedure TERPMainSwitchMovingButton.SetOldLeft(const Value: integer);
begin
  FOldLeft := Value;
end;

procedure TERPMainSwitchMovingButton.SetOldTop(const Value: integer);
begin
  FOldTop := Value;
end;

procedure TERPMainSwitchMovingButton.SetOldWidth(const Value: integer);
begin
  FOldWidth := Value;
end;

procedure TERPMainSwitchMovingButton.SetSelected(const Value: boolean);
begin
  if Value = Selected then
    exit;

  if Value then
    State := State + [stSelected]
  else
    State := []; //State - [stSelected];
  Invalidate;
end;

procedure TERPMainSwitchMovingButton.StartMoving;
begin
  OldTop := Top;
  OldLeft := Left;
  OldHeight := Height;
  OldWidth := Width;
  AllowMoving := true;
end;

procedure TERPMainSwitchMovingButton.StopMoving;
begin
  AllowMoving := false;
end;

procedure TERPMainSwitchMovingButton.WMCAPTURECHANGED(var Msg: TMessage);
begin
  inherited;
end;

procedure TERPMainSwitchMovingButton.WMEnterSizeMove(var Msg: TMessage);
begin
  if not AllowMoving then
  begin
    inherited;
    exit;
  end;

  State := State + [stResizing];
  DoEnterSizeMove;
end;

procedure TERPMainSwitchMovingButton.WMExitSizeMove(var Msg: TMessage);
begin
  if not AllowMoving then
  begin
    inherited;
    exit;
  end;
  State := State - [stSelected, stMoving, stResizing];
  Invalidate;
  DoExitSizeMove;
end;

procedure TERPMainSwitchMovingButton.WMNCHitTest(var Msg: TWMNCHitTest);
var
  idx : integer;
  pt : TPoint;
  r : TRect;
begin
//?????  SetCaptureControl(Self);

  inherited;
  if not AllowMoving then
  begin
    exit;
  end;

  Pt := ScreenToClient(Point(Msg.Xpos, Msg.Ypos));
  try
    if not Selected then
      exit;
    for idx := 0 to 7 do
    begin
      r := MarkRect(idx);
      if PtInRect(r, Point(Pt.X, Pt.y)) then
      begin
        msg.Result := csPointPos[idx];
        exit;
      end;
    end;
    msg.Result := HTCLIENT;
  finally
    PointPos := msg.Result;
  end;
end;

procedure TERPMainSwitchMovingButton.WMWindowPosChanging(var Message: TWMWindowPosChanging);
//var
//  WindowPos: PWindowPos;
begin
  if not AllowMoving then
  begin
    inherited;
    exit;
  end;
(*
  if (ComponentState * [csReading, csDestroying] = []) and (State * [stMoving, stResizing] <> []) then
  begin
    WindowPos := Message.WindowPos;
    with WindowPos^ do
    begin
      // if AllowMove then inherited stuff will check sizes, no worries
      if State * [stResizing] <> [] then
      begin
      end;
    end;
  end;
  *)
  inherited;
end;

end.
