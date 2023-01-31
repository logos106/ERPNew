unit ERPMessageExpander;

interface

uses
  Classes, StdCtrls, ERPSmoothExpanderPanel, Controls, Messages;

type

  TMessageSortType = (msSeq, msDate, msVersion);

  TOnSortTypeChange = procedure (Sender: TObject; SortType: TMessageSortType) of object;

  TERPMessageExpander = class(TERPSmoothExpanderPanel)
  private
    FBodyText: string;
    FSubjectText: string;
    fOldWidth: integer;
    fBobyLabel: TLabel;
    fDateLabel: TLabel;
    fVersionLabel: TLabel;
    fId: integer;
    fSortId: integer;
    FNewMessage: boolean;
    FActive: boolean;
    FVersion: string;
    FCreatedOn: TDateTime;
    FShowVersion: boolean;
    FShowDate: boolean;
    FSortType: TMessageSortType;
    fOnSortChange: TOnSortTypeChange;
    procedure SetBodyText(const Value: string);
    procedure SetSubjectText(const Value: string);
    procedure CMMouseEnter(var Msg: TMessage); message CM_MouseEnter;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MouseLeave;
    procedure SetNewMessage(const Value: boolean);
    procedure SetActive(const Value: boolean);
    procedure SetCreatedOn(const Value: TDateTime);
    procedure SetVersion(const Value: string);
    procedure SetShowDate(const Value: boolean);
    procedure SetShowVersion(const Value: boolean);
    procedure SetSortType(const Value: TMessageSortType);
    function GetSubjectText: string;
    procedure SetSortId(const Value: integer);
//    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
  protected
    procedure SetExpanded(const Value: Boolean); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure AlignColumns;
    procedure LabelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LabelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property SubjectText: string read GetSubjectText write SetSubjectText;
    property BodyText: string read FBodyText write SetBodyText;
    procedure Resize; override;
    property Id: integer read fId write fId;
    property SortId: integer read fSortId write SetSortId;
    property NewMessage: boolean read FNewMessage write SetNewMessage;
    property Active: boolean read FActive write SetActive;
    property CreatedOn: TDateTime read FCreatedOn write SetCreatedOn;
    property Version: string read FVersion write SetVersion;
    property ShowDate: boolean read FShowDate write SetShowDate;
    property ShowVersion: boolean read FShowVersion write SetShowVersion;
    property SortType: TMessageSortType read FSortType write SetSortType;
    property OnSortChange: TOnSortTypeChange read fOnSortChange write fOnSortChange;
  published
  end;



implementation

uses
  Graphics, Types, SysUtils;

{ TERPMessageExpander }

procedure TERPMessageExpander.AlignColumns;
begin
  fDateLabel.Visible := ShowDate;
  fVersionLabel.Visible := ShowVersion;
  if fShowDate  then begin
    fDateLabel.Left := self.Width - (fDateLabel.Width + 37);
    if fShowVersion then
      fVErsionLabel.Left := fDateLabel.Left - (fVersionLabel.Width + 3);
  end
  else if fShowVersion then begin
    fVersionLabel.Left := self.Width - (fVersionLabel.Width + 37);
  end;
end;

procedure TERPMessageExpander.CMMouseEnter(var Msg: TMessage);
//var
//  pt: TPoint;
begin
//  pt := Mouse.CursorPos;
//  pt := ScreenToClient(pt);
//  if pt.X > (Width - 20) then
//    Expanded := true;
  if Assigned(OnMouseEnter) then
    OnMouseEnter(Self);
end;

procedure TERPMessageExpander.CMMouseLeave(var Msg: TMessage);
begin

//  Expanded := false;
  if Assigned(OnMouseLeave) then
    OnMouseLeave(Self);
end;

constructor TERPMessageExpander.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSortType := msSeq;
//  self.Align := alTop;
  fOldWidth := self.Width;
  fBobyLabel := TLabel.Create(self);
  fBobyLabel.Font.Name := 'Arial';
  fBobyLabel.Font.Size := 11;
  fBobyLabel.Parent := self;
  fBobyLabel.Align := alTop;
  fBobyLabel.AutoSize := true;
  fBobyLabel.WordWrap := true;
  fBobyLabel.AlignWithMargins := true;
  fBobyLabel.Margins.Top := 24;
  fBobyLabel.Margins.Right := 24;
  fBobyLabel.Margins.Left := 10;
  fBobyLabel.Margins.Bottom := 10;
  fBobyLabel.Visible := Expanded;

  fShowDate := true;
  fShowVErsion := true;

  fDateLabel := TLabel.Create(self);
  fDateLabel.Font.Name := 'Arial';
  fDateLabel.Font.Size := 10;
  fDateLabel.Parent := self;
  fDateLabel.AutoSize := false;
  fDateLabel.Width := 70;
  fDateLabel.Height := 20;
  fDateLabel.Layout:= tlCenter;
  fDateLabel.Top := 1;
  fDateLabel.Anchors := [akTop, akRight];
  fDateLabel.OnMouseDown := LabelMouseDown;
  fDateLabel.OnMouseUp := LabelMouseUp;

  fVersionLabel := TLabel.Create(self);
  fVersionLabel.Font.Name := 'Arial';
  fVersionLabel.Font.Size := 10;
  fVersionLabel.Parent := self;
  fVersionLabel.AutoSize := false;
  fVersionLabel.Width := 70;
  fVersionLabel.Height := 20;
  fVersionLabel.Layout:= tlCenter;
  fVersionLabel.Top := 1;
  fVersionLabel.Anchors := [akTop, akRight];
  fVersionLabel.OnMouseDown := LabelMouseDown;
  fVersionLabel.OnMouseUp := LabelMouseUp;

  AlignColumns;

  Caption.Line := false;

  self.Canvas.Font.Assign(Caption.Font);

//  self.ShowExpander := false;
//  self.DragMode := dmAutomatic;
end;

destructor TERPMessageExpander.Destroy;
begin

  inherited;
end;

function TERPMessageExpander.GetSubjectText: string;
begin
  result := FSubjectText
end;

procedure TERPMessageExpander.LabelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Sender = fDateLabel then begin
    if SortType = msDate then
      SortType := msSeq
    else
      SortType := msDate;
  end
  else if Sender = fVersionLabel then begin
    if SortType = msVersion then
      SortType := msSeq
    else
      SortType := msVersion;
  end;
  if Assigned(fOnSortChange) then
    fOnSortChange(self, SortType);
//    TLabel(Sender).Font.Style := [fsBold];

end;

procedure TERPMessageExpander.LabelMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
//  if Sender is TLabel then
//    TLabel(Sender).Font.Style := [];
end;

procedure TERPMessageExpander.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;

//  Expanded := not Expanded;
end;

procedure TERPMessageExpander.Resize;
begin
  inherited;
  if not (csDesigning in ComponentState) then begin
//    AlignColumns;
    if fOldWidth <> self.Width then begin
      BodyText := fBodyText;
    end;
    self.SubjectText := fSubjectText;
//    Caption.Text := IntToStr(self.Caption.Font.Size);

  end;
  fOldWidth := self.Width;
end;

procedure TERPMessageExpander.SetActive(const Value: boolean);
begin
  FActive := Value;
end;

procedure TERPMessageExpander.SetBodyText(const Value: string);
begin
  FBodyText := Value;
  fBobyLabel.Caption := '';
  fBobyLabel.HEight := 0;
  fBobyLabel.Width := self.Width;
  fBobyLabel.Caption := Value;
  fBobyLabel.Width := self.Width;
  self.ExpandedHeight := fBobyLabel.Height + 40;
end;

procedure TERPMessageExpander.SetCreatedOn(const Value: TDateTime);
begin
  FCreatedOn := Value;
  fDateLabel.Caption := DateToStr(fCreatedOn);
end;

procedure TERPMessageExpander.SetExpanded(const Value: Boolean);
begin
  fBobyLabel.Visible := Value;
  inherited;

end;

procedure TERPMessageExpander.SetNewMessage(const Value: boolean);
begin
  FNewMessage := Value;
  if Value then begin
    Caption.ColorEnd := $0000A400;
    Caption.ColorStart := $0011B000;
  end
  else begin
    Caption.ColorEnd := $009F661A;
    Caption.ColorStart := $00B0721C;
  end;
end;

procedure TERPMessageExpander.SetShowDate(const Value: boolean);
begin
  FShowDate := Value;
end;

procedure TERPMessageExpander.SetShowVersion(const Value: boolean);
begin
  FShowVersion := Value;
end;

procedure TERPMessageExpander.SetSortId(const Value: integer);
begin
  fSortId := Value;
  SubjectText := FSubjectText;
end;

procedure TERPMessageExpander.SetSortType(const Value: TMessageSortType);
begin
  FSortType := Value;
  case FSortType of
    msSeq:
      begin
        fDateLabel.Font.Style := [];
        fVersionLabel.Font.Style := [];
      end;
    msDate:
      begin
        fDateLabel.Font.Style := [fsBold];
        fVersionLabel.Font.Style := [];
      end;
    msVersion:
      begin
        fDateLabel.Font.Style := [];
        fVersionLabel.Font.Style := [fsBold];
      end;
  end;
end;

procedure TERPMessageExpander.SetSubjectText(const Value: string);
var
  maxWidth: integer;
  s: string;
begin
  FSubjectText := Value;
  if fVersionLabel.Visible then
    maxWidth := fVersionLabel.Left - 5
  else if fDateLabel.Visible then
    maxWidth := fDateLabel.Left - 5
  else
    maxWidth := self.Width - 40;
  s:= ' ' + '[' + IntToStr(SortId)+ '] ' +  FSubjectText;
  if Assigned(Parent) then begin
    if Canvas.TextWidth(s) > maxWidth then begin
      while (Length(s) > 2) and (Canvas.TextWidth(s + '..') > maxWidth) do
        s:= Copy(s,1,Length(s)-1);

      s:= s + '..';
    end;
  end;
  self.Caption.Text := s;
end;

procedure TERPMessageExpander.SetVersion(const Value: string);
begin
  FVersion := Value;
  fVersionLabel.Caption := FVersion;
end;

//procedure TERPMessageExpander.WMMouseMove(var Message: TWMMouseMove);
//var
//  pt: TPoint;
//begin
//  pt := Mouse.CursorPos;
//  pt := ScreenToClient(pt);
//  Expanded :=  pt.X > (Width -20);
//
//
//end;

end.
