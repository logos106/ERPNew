unit PanelBtnObj;

interface

uses
  Classes, Graphics, Controls, Dialogs, ExtCtrls, StdCtrls,AdvPanel;

const
  // Colours
  CL_NICEBLUE = $00EFE8CF;

type
  TPanelBtn = class(TObject)
   private
     function UniqueName(aComponent: TComponent): string;
   public
    Panel: TAdvPanel;
    Line1: TLabel;
    Line2: TLabel;
    HotKey: TLabel;
    constructor Create(ParentPnl: TPanel; iTop, iLeft, iWidth, iHeight: integer); virtual;
    destructor Destroy; override;
    procedure ResetBtn(DefFont: TFont); virtual;
    procedure BtnUp;
    procedure BtnDown;
    procedure ResizeLines;
    function ArrangeText(const Position: integer): integer;
    procedure SetHint(const sHint: string);
    function GetHint: string;
  end;


implementation

uses
  Forms, SysUtils;


constructor TPanelBtn.Create(ParentPnl: TPanel; iTop, iLeft, iWidth, iHeight: integer);
begin
  inherited Create;
  // We create a button and initialize all the non-changeable attributes
try
  // Create a panel for the button
  Panel := TAdvPanel.Create(ParentPnl);
  with Panel do begin
    Top         := iTop;
    Left        := iLeft;
    Width       := iWidth;
    Height      := iHeight;
    BevelOuter  := bvRaised;
    BevelInner  := bvRaised;
    BorderStyle := bsNone;
    Panel.Color := clWhite;
    Panel.ColorMirror := clWhite;
    Panel.ColorMirrorTo := clWhite;
    Panel.ColorTo := clWhite;
    Panel.GradientDirection := gdVertical;//gdHorizontal
    ShowHint    := true;
    Parent      := ParentPnl;
    OnClick     := ParentPnl.OnClick;
  end;

  // Create Hot Key Label

  if Assigned(ParentPnl.Owner) and (ParentPnl.Owner is TForm) then
    HotKey := TLabel.Create(ParentPnl.Owner)
  else
    HotKey := TLabel.Create(ParentPnl);
  with HotKey do begin
    Name := UniqueName(HotKey);
    Caption := '';
    Font.Name   := 'Arial';
    Font.Style  := Font.Style + [fsBold];
    Font.Color  := clWindowText;
    Top         := 2;
    Left        := 4;
    Alignment   := taLeftJustify;
    ShowHint    := false;
    Transparent := true;
    Parent      := Panel;
    OnClick     := ParentPnl.OnClick;
  end;

  // Create the Label for Line1

  if Assigned(ParentPnl.Owner) and (ParentPnl.Owner is TForm) then
    Line1 := TLabel.Create(ParentPnl.Owner)
  else
    Line1 := TLabel.Create(ParentPnl);
  with Line1 do begin
    Name := UniqueName(Line1);
    Caption := '';
    Alignment   := taCenter;
    ShowHint    := true;
    Transparent := true;
    WordWrap    := false;
    Parent      := Panel;
    OnClick     := ParentPnl.OnClick;
  end;

  // Create the Label for line 2

  if Assigned(ParentPnl.Owner) and (ParentPnl.Owner is TForm) then
    Line2 := TLabel.Create(ParentPnl.Owner)
  else
    Line2 := TLabel.Create(ParentPnl);
  with Line2 do begin
    Name := UniqueName(Line1);
    Caption := '';
    Alignment   := taCenter;
    ShowHint    := true;
    Transparent := true;
    WordWrap    := false;
    Parent      := Panel;
    OnClick     := ParentPnl.OnClick;
  end;
except
  on E:Exception do begin

  end;

end;

end;

procedure TPanelBtn.SetHint(const sHint: string);
begin
  Panel.Hint := sHint;
  HotKey.Hint := sHint;
  Line1.Hint := sHint;
  Line2.Hint := sHint;
end;

function TPanelBtn.UniqueName(aComponent: TComponent): string;
var
  I:Integer;
  Fmt:string;
begin
   Fmt:= Copy(aComponent.ClassName,2,255)+'%d';
   for I:=1 to High(Integer) do
   begin
      Result:=Format(Fmt,[I]);
      if aComponent.Owner.FindComponent(Result)= nil then Exit;
   end;
end;

function TPanelBtn.GetHint: string;
begin
  Result := Panel.Hint;
end;

procedure TPanelBtn.ResetBtn(DefFont: TFont);
begin
  Panel.Color := CL_NICEBLUE;

  // Reset Hot Key
  with HotKey do begin
    Caption    := '*';
    Font.Color := clWindowText;
  end;

  // Create the Label for Line1
  with Line1 do begin
    Caption := 'Preset';
    Font.Assign(DefFont);
    Top := 15;
  end;

  // Create the Label for line 2
  with Line2 do begin
    Caption := 'Not Used';
    Font.Assign(DefFont);
    Top := Line1.Top + Line1.Height;
  end;

  SetHint('');

  ResizeLines;         // Line up the text
end;


destructor TPanelBtn.Destroy;
begin
  FreeAndNil(Line1);
  FreeAndNil(Line2);
  FreeAndNil(HotKey);
  FreeAndNil(Panel);
  inherited;  
end;

procedure TPanelBtn.BtnUp;
begin
  Panel.BevelInner := bvRaised;
  Panel.BevelOuter := bvRaised;
  Panel.BorderStyle := bsNone;
  Panel.Update;
end;

procedure TPanelBtn.BtnDown;
begin
  Panel.BevelInner := bvLowered;
  Panel.BevelOuter := bvRaised;
  Panel.BorderStyle := bsSingle;
  Panel.Update;  
end;

procedure TPanelBtn.ResizeLines;
begin
  Line1.Left := 2;
  Line1.Width := Panel.Width - 4;
  Line2.Left := Line1.Left;
  Line2.Width := Line1.Width;
end;

function TPanelBtn.ArrangeText(const Position: integer): integer;
begin
  if Line1.Top + Line1.Height < Panel.Height - 2 then begin
    Line1.Top := Position;
    Result    := Position;
  end else begin
    Line1.Top := Line1.Top - 1;
    Result    := Position - 1;
  end;
  Line2.Top := Line1.Top + Line1.Height;
  Line2.Height := Panel.Height - Line2.Top;
end;


end.
