unit LogMemoObj;

interface

uses
  Forms, classes;

type
  TLogMemo = class(TScrollBox)
  private
    SL: TStringList;
    fMaxLines: integer;
    fCount: integer;
    procedure SetMaxLines(const Value: integer);
    procedure DoAddLine(str: string);
  published
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property MaxLines: integer read fMaxLines write SetMaxLines;
    procedure AddLine(str: string);
    property Count: integer read fCount;
  end;

//  TLogMemLine = class(TPanel)

//  end;

implementation

uses
  stdctrls, controls, Graphics;

{ TLogMemo }

procedure TLogMemo.AddLine(str: string);
var
  x: integer;
begin
  SL.Text:= str;
  for x := 0 to SL.Count -1 do
    DoAddLine(SL[x]);
end;

constructor TLogMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SL:= TStringList.Create;
  self.VertScrollBar.Visible:= true;
  fMaxLines:= 250;
  fCount:= 0;
  Color:= clWindow;
end;

destructor TLogMemo.Destroy;
begin
  SL.Free;
  inherited;
end;

procedure TLogMemo.DoAddLine(str: string);
var
  x: integer;
  lbl: TLabel;
begin
  if Count >= MaxLines then begin
    self.DisableAlign;
    try
      for x := 0 to ControlCount -1 do begin
        Controls[x].Width:= ClientWidth;
        if x > 0 then begin
          TLabel(Controls[x-1]).Caption:= TLabel(Controls[x]).Caption;
        end;
      end;
      TLabel(Controls[ControlCount-1]).Caption:= str;
    finally
      self.EnableAlign;
    end;
  end
  else begin
    lbl:= TLabel.Create(self);
    lbl.Parent:= self;
    lbl.Left:= 0;
    lbl.Width:= ClientWidth;
    if ControlCount = 1 then
      lbl.Top:= 0
    else
      lbl.Top:= Controls[ControlCount-2].Top + Controls[ControlCount-2].Height;
    lbl.Caption:= str;
    self.VertScrollBar.Position:= self.VertScrollBar.Range;
    Inc(fCount);
  end;
end;

procedure TLogMemo.SetMaxLines(const Value: integer);
begin
  fMaxLines := Value;
end;

end.
