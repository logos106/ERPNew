unit TimedHint;

interface
  uses controls,ExtCtrls, classes, graphics, frmBase;

type
  TDnMHintWindow = class(THintWindow)
    Private
    Protected
    Public
      destructor Destroy; override;
  end;
  TTimedHint = class(TComponent)
    Private
      ftimer :TTimer;
      fHintWindow :TDnMHintWindow;
      fHintControl :TWincontrol;
      fbHighlightcontrol: Boolean;
      fFont :TFont;
      strHint :String;
      Procedure Hidehint(Sender:TObject);
      Procedure ShowTimedHint(fcontrol: TWincontrol; fshint: String;Highlightcontrol:boolean =true;  Interval: Integer=20000; hintwidth:Integer =0; hintheight :Integer =0;hintcolor:Tcolor =0;fontcolor:Tcolor =0);
    Protected

    Public
      constructor Create(AOwner:TComponent);override;
      destructor Destroy; override;
      Procedure HidehintformForm(curForm :TfrmBaseGUI);

  end;

var
  fTimedHint :TTimedHint;

Procedure ShowTimedHint(fcontrol: TWincontrol; fshint: String;Highlightcontrol:boolean =true;  Interval: Integer=20000; hintwidth:Integer =0; hintheight :Integer =0;hintcolor:Tcolor =0;fontcolor:Tcolor =0);
Procedure Hidehint(Sender:TObject);

implementation

uses sysutils, types, commonGuiLib, tcConst, CommonLib, LogLib;

{ TTimedHint }

constructor TTimedHint.Create(AOwner: TComponent);
begin
  inherited;
  ftimer := TTimer.Create(Self);
  ftimer.Interval := 20000;
  ftimer.OnTimer := Hidehint;
  ftimer.Enabled:= false;
  fFont := TFont.Create;
  fHintWindow := nil;
end;

procedure TTimedHint.ShowTimedHint(fcontrol: TWincontrol; fshint: String;Highlightcontrol:boolean =true;  Interval: Integer=20000; hintwidth:Integer =0; hintheight :Integer =0;hintcolor:Tcolor =0;fontcolor:Tcolor =0);
var
  r: Trect;
  p: TPoint;
  Procedure TextWidthnHeight;
  var
    st:TStringlist;
    ctr:Integer;
    s:String;
  begin
    st:= TStringlist.Create;
    try
      s:=fsHint;
      while s<> '' do
        if pos(NL , s)>0 then begin
          st.Add(trim(copy(s,1,pos(NL, s)))); s:= Trim(copy(s, pos(NL,s), length(s)));
        end else begin
          st.Add(s); s:= '';
        end;

      s:= '';
      for ctr:= 0 to st.Count-1 do
        if length(s) < length(st[ctr]) then s:= st[ctr];
      if hintwidth  <> 0 then r.Right   := r.Left + hintwidth  else r.Right   := r.Left + fHintWindow.Canvas.TextWidth(s)+10;
      if hintheight <> 0 then r.Bottom  := r.Top  + hintheight else r.Bottom  := r.Top  + fHintWindow.Canvas.TextHeight(fsHint) * (st.Count)+5;

    finally
      Freeandnil(st);
    end;
  end;
begin
  ftimer.Interval := Interval;
  fHintControl :=fcontrol;
  fbHighlightcontrol:= Highlightcontrol;

  p := MDIPosition(fcontrol);
  r.Left := p.X ;
  r.Top := p.Y + fcontrol.Height;
  if fHintWindow = nil then begin
    fHintWindow := TDnMHintWindow.Create(fcontrol.Owner);
    fFont.color := fHintWindow.font.color;
    fFont.size  := fHintWindow.font.size;
    fHintWindow.Font := fFont;
  end;

  TextWidthnHeight;
  if hintcolor <> 0 then fHintWindow.Color := hintcolor;
  if fontcolor <> 0 then begin
    fFont.Color := fontcolor;
    fHintWindow.Font := fFont;
  end;


  fHintWindow.Anchors := fHintControl.Anchors;
  fHintWindow.ActivateHint(r,fsHint );
  strHint :=fsHint;

  if Highlightcontrol then
    if assigned(fcontrol.Owner) then
      if fcontrol.Owner is TfrmBaseGUI then
        TfrmBaseGUI(fcontrol.Owner).HighlightControl(fcontrol);



  ftimer.Enabled := True;
end;

destructor TTimedHint.Destroy;
begin
  freeandnil(fFont);
  inherited;
end;

procedure TTimedHint.Hidehint(Sender: TObject);
begin
    try
        FreeandNil(fHintWindow);
        if fbHighlightcontrol then
            if assigned(fhintcontrol.Owner) then
              if fhintcontrol.Owner is TfrmBaseGUI then
              TfrmBaseGUI(fhintcontrol.Owner).HideHighlightControl;
        fhintcontrol:= nil;
        ftimer.Enabled := False;
    Except
      // kill the exception if the form is destroyed
    end;
end;
procedure TTimedHint.HidehintformForm(curForm: TfrmBaseGUI);
begin
  if Assigned(fhintcontrol) then
    if Assigned(fhintcontrol.owner) and (fhintcontrol.Owner  = curform) then begin
      logtext( fhintcontrol.Name +': hint closed');
      Hidehint(fhintcontrol);
    end;
end;

Procedure Hidehint(Sender:TObject);
begin
  try
    if sender =fTimedHint.fhintcontrol then
      fTimedHint.Hidehint(nil);
  except
  end;
end;
Procedure ShowTimedHint(fcontrol: TWincontrol; fshint: String;Highlightcontrol:boolean =true;  Interval: Integer=20000; hintwidth:Integer =0; hintheight :Integer =0;hintcolor:Tcolor =0;fontcolor:Tcolor =0);
begin
  if not assigned(fcontrol.Owner) then exit;
  if not  (fcontrol.Owner is TfrmBaseGUI) then Exit;

  fTimedHint.ShowTimedHint(fControl, fsHint, Highlightcontrol, Interval, hintwidth, hintheight,hintcolor,fontcolor);
end;
{ TDnMHintWindow }

destructor TDnMHintWindow.Destroy;
begin

  inherited;
end;

initialization
  fTimedHint := TTimedHint.Create(nil);
finalization
  Freeandnil(fTimedHint);

end.
