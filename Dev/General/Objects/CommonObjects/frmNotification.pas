unit frmNotification;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfmNotification = class(TForm)
    tmrFade: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fFadeOutMS: integer;
    fFadeInMS: integer;
    procedure FadeTimerFadeIn(Sender: TObject);
    procedure FadeIn;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMActivate(Var msg:tMessage); message WM_ACTIVATE;
  public
    Lines: TStrings;
    class procedure ShowNotification(const Position: TPoint; const msg: string; OnClick: TNotifyEvent = nil); overload;
    class procedure ShowNotification(const Position: TPoint; const MessageList: TStrings; OnClick: TNotifyEvent = nil); overload;
    procedure AddLines(List: TStrings; OnClick: TNotifyEvent = nil);
  published
    property FadeInMS: integer read fFadeInMS write fFadeInMS;
    property FadeOutMS: integer read fFadeOutMS write fFadeOutMS;
  end;

var
  fmNotification: TfmNotification;

implementation

{$R *.dfm}

{ TfmNotification }

procedure TfmNotification.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style := WS_POPUP or WS_THICKFRAME;
end;

procedure TfmNotification.FadeIn;
begin
  tmrFade.Enabled := false;
  AlphaBlend := true;
  AlphaBlendValue := 0;
  tmrFade.OnTimer := FadeTimerFadeIn;
  if FadeInMS > 0 then begin
    tmrFade.Interval := Round(FadeInMS / 50);
    if tmrFade.Interval < 1 then
      tmrFade.Interval := 1;
  end
  else
    tmrFade.Interval := 1;
  tmrFade.Enabled := true;
end;

procedure TfmNotification.FadeTimerFadeIn(Sender: TObject);
begin
  if (FadeInMS =0) or ((AlphaBlendValue + 5) >= 255) then begin
    TTimer(Sender).Enabled := false;
    AlphaBlendValue := 255;
  end
  else
    AlphaBlendValue := AlphaBlendValue + 5;
end;

procedure TfmNotification.FormActivate(Sender: TObject);
begin
  FadeIn;

end;

procedure TfmNotification.FormClose(Sender: TObject; var Action: TCloseAction);
var
  delayMS: integer;
begin
  if FadeOutMS > 0 then begin
    AlphaBlend := true;
    AlphaBlendValue := 255;
    delayMS := Round(FadeOutMS / 50);
    while AlphaBlendValue > 0 do begin
      Sleep(delayMS);
      if (AlphaBlendValue - 5) <= 0 then
        AlphaBlendValue := 0
      else
        AlphaBlendValue := AlphaBlendValue -5;
    end;
  end;


  Action := caFree;
end;

procedure TfmNotification.FormCreate(Sender: TObject);
begin
  Lines := nil;
  AlphaBlend := true;
  AlphaBlendValue := 0;
  fFadeOutMS := 250;
  fFadeInMS := 750;
end;

procedure TfmNotification.FormDestroy(Sender: TObject);
begin
  if Assigned(Lines) then begin
    while Lines.Count > 0 do begin
      Lines.Objects[0].Free;
      Lines.Delete(0);
    end;
  end;
end;

class procedure TfmNotification.ShowNotification(const Position: TPoint;
  const MessageList: TStrings; OnClick: TNotifyEvent);
var
  form: TfmNotification;
begin
  form := TfmNotification.Create(Application);
  form.Lines := MessageList;
  form.AddLines(MessageList,OnClick);
  form.Left := Position.X;
  form.Top := Position.Y - (form.ClientHeight - form.BorderWidth - 15);
  form.Show;
end;

class procedure TfmNotification.ShowNotification(const Position: TPoint;
  const msg: string; OnClick: TNotifyEvent);
var
  form: TfmNotification;
  sl: TStringList;
begin
  form := TfmNotification.Create(Application);
  form.OnClick := OnClick;
  sl := TStringList.Create;
  try
    sl.Text := msg;
    form.AddLines(sl,OnClick);
  finally
    sl.Free;
  end;
  form.Left := Position.X;
  form.Top := Position.Y - (form.ClientHeight - form.BorderWidth - 15);
  form.Show;
end;

procedure TfmNotification.AddLines(List: TStrings; OnClick: TNotifyEvent);
var
  maxWidth, textWidth: integer;
  x: integer;
  lbl: TLabel;
  aTop: integer;
begin
    maxWidth := 0;
    for x := 0 to List.Count -1 do begin
      if List[x] <> '' then begin
        textWidth := self.Canvas.TextWidth(List[x]);
        if textWidth > maxWidth then
          maxWidth := textWidth;
      end;
    end;
    if (maxWidth + 30) > self.Width then
      self.Width := (maxWidth + 30);

    lbl := nil;
    aTop := 0;
    for x := 0 to List.Count -1 do begin
      if Assigned(lbl) then
        aTop := lbl.Top + lbl.Height + 5
      else
        aTop := 10;
      lbl := TLabel.Create(self);
      lbl.Name := 'Label_' + IntToStr(x);
      lbl.Parent := self;
      lbl.Top := aTop;
      lbl.Left := 0;
      lbl.AutoSize := false;
      lbl.Width := self.ClientWidth;
      lbl.Alignment := taCenter;
      lbl.Caption:= List[x];
      lbl.Tag := Integer(List.Objects[x]);
      lbl.OnClick := OnClick;
    end;
    if Assigned(lbl) and ((aTop + lbl.Height + 20) > self.ClientHeight) then
      self.ClientHeight := (aTop + lbl.Height + 20);

end;

procedure TfmNotification.WMActivate(var msg: tMessage);
begin
  if Msg.WParam = WA_INACTIVE then
    Close; // or Hide
end;

end.
