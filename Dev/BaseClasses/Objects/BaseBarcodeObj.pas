unit BaseBarcodeObj;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 27/10/06  1.00.01 DSP  First version.

}

interface

uses
  Windows, Graphics, Classes, SysUtils, frmBarcode;

type
  TBaseBarcode = class(TComponent)
  private
    FForm: TBarcodeGUI;
    FShowGridLines: Boolean;
    FDisplayMessages: Boolean;
    function GetCaptionColor: TColor;
    procedure SetCaptionColor(const Value: TColor);
    function GetValueColor: TColor;
    procedure SetValueColor(const Value: TColor);
    procedure SetShowGridLines(const Value: Boolean);
    procedure SetFormCaption(const Value: string);
    function GetFormCaption: string;
    procedure SetPanelCaption(const Value: string);
    function GetPanelCaption: string;
    procedure SetColumnWidth(const Value: Integer);
    function GetColumnWidth: Integer;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ShowForm; 
    procedure HideForm; 
    procedure HandleBarcodeEntry(const BarcodeText: string); virtual; abstract;
    procedure AssignCaptions(const Captions: TStrings);
    procedure AssignValue(const Caption: string; const Value: string); 
    procedure SetupDisplay; virtual;
    procedure ExtractPrefixAndValue(const BarcodeText: string; out Prefix: string; out Value: string); 
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreateForm;
    procedure BringToFront;
    procedure EnterBarcode(const BarcodeText: string); 
    property FormCaption: string read GetFormCaption write SetFormCaption;
    property PanelCaption: string read GetPanelCaption write SetPanelCaption;
    property CaptionColor: TColor read GetCaptionColor write SetCaptionColor;
    property ValueColor: TColor read GetValueColor write SetValueColor;
    property ShowGridLines: Boolean read FShowGridLines write SetShowGridLines;
    property ColumnWidth: Integer read GetColumnWidth write SetColumnWidth;
    property DisplayMessages: Boolean read FDisplayMessages write FDisplayMessages;
  end;

implementation

uses
  CommonLib,  AppEnvironment, FastFuncs, Forms;

{ TBaseBarcode }

constructor TBaseBarcode.Create(AOwner: TComponent);
begin
  inherited;
  FShowGridLines := False;
  FDisplayMessages := True;
end;

destructor TBaseBarcode.Destroy;
begin
  if Assigned(FForm) then
    FForm.Release;
  inherited;
end;

procedure TBaseBarcode.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;

  if (AComponent = FForm) and (Operation = opRemove) then begin
    FForm := nil;

    if not (csDestroying in ComponentState) then
      Free;
  end;
end;

procedure TBaseBarcode.CreateForm;
begin
  FForm := TBarcodeGUI(GetComponentByClassName('TBarcodeGUI', False));

  if Assigned(FForm) then begin
    FreeNotification(FForm);
    FForm.OnBarcodeEntry := HandleBarcodeEntry;
  end;
end;

procedure TBaseBarcode.ShowForm;
begin
  if Assigned(FForm) then begin
    FForm.FormStyle := fsMDIChild;
  end;
end;

procedure TBaseBarcode.HideForm;
begin
  if Assigned(FForm) then begin
    ShowWindow(FForm.Handle, SW_HIDE);
  end;
end;

function TBaseBarcode.GetValueColor: TColor;
begin
  if Assigned(FForm) then
    Result := FForm.ValueColor
  else
    Result := clNone;
end;

function TBaseBarcode.GetCaptionColor: TColor;
begin
  if Assigned(FForm) then
    Result := FForm.CaptionColor
  else
    Result := clNone;
end;

procedure TBaseBarcode.SetValueColor(const Value: TColor);
begin
  if Assigned(FForm) and (Value <> FForm.ValueColor) then
    FForm.ValueColor := Value;
end;

procedure TBaseBarcode.SetCaptionColor(const Value: TColor);
begin
  if Assigned(FForm) and (Value <> FForm.CaptionColor) then
    FForm.CaptionColor := Value;
end;

function TBaseBarcode.GetFormCaption: string;
begin
  if Assigned(FForm) then
    Result := FForm.Caption
  else
    Result := '';
end;

function TBaseBarcode.GetPanelCaption: string;
begin
  if Assigned(FForm) then
    Result := FForm.TitleLabel.Caption
  else
    Result := '';
end;

procedure TBaseBarcode.SetFormCaption(const Value: string);
var
  AccessLevel: Integer;
begin
  if Assigned(FForm) then begin
    AccessLevel := AppEnv.AccessLevels.GetEmployeeAccessLevel(ClassName);
    FForm.Caption := Value + AppEnv.AccessLevels.GetAccessLevelDescription(AccessLevel);
  end;
end;

procedure TBaseBarcode.SetPanelCaption(const Value: string);
begin
  if Assigned(FForm) then
    FForm.TitleLabel.Caption := Value;
end;

procedure TBaseBarcode.AssignCaptions(const Captions: TStrings);
var
  Index: Integer;
  Offset: Integer;
begin
  if Assigned(FForm) then begin
    with  FForm.grdBarcodeSteps do begin
      Offset := (Captions.Count - 1) * DefaultRowHeight;
      FForm.Height := FForm.Height + Offset;
      Height := Height + Offset;
      FForm.bvlBarcode.Height := FForm.bvlBarcode.Height + Offset;
      FForm.btnClose.Top := FForm.btnClose.Top + Offset;
      Strings.Assign(Captions);

      for Index := 0 to Strings.Count - 1 do
        Strings[Index] := Strings[Index] + '=';
    end;
  end;
end;

procedure TBaseBarcode.AssignValue(const Caption: string; const Value: string);
begin
  if Assigned(FForm) and (FForm.grdBarcodeSteps.Strings.IndexOfName(Caption) >= 0) then begin
    if Value <> '' then
      FForm.grdBarcodeSteps.Strings.Values[Caption] := Value
    else
      FForm.grdBarcodeSteps.Strings.Values[Caption] := ' ';
  end;
end;

procedure TBaseBarcode.SetShowGridLines(const Value: Boolean);
begin
  if Value <> FShowGridLines then begin
    FShowGridLines := Value;

    if Assigned(FForm) then begin
      if FShowGridLines then
        FForm.grdBarcodeSteps.GridLineWidth := 1
      else
        FForm.grdBarcodeSteps.GridLineWidth := 0;
    end;
  end;
end;

function TBaseBarcode.GetColumnWidth: Integer;
begin
  if Assigned(FForm) then
    Result := FForm.grdBarcodeSteps.DefaultColWidth
  else
    Result := 0;
end;

procedure TBaseBarcode.SetColumnWidth(const Value: Integer);
begin
  if Assigned(FForm) then
    FForm.grdBarcodeSteps.DefaultColWidth := Value;
end;

procedure TBaseBarcode.SetupDisplay;
begin
//
end;

procedure TBaseBarcode.ExtractPrefixAndValue(const BarcodeText: string; out Prefix, Value: string);
var
  DelimiterPos: Integer;
begin
  DelimiterPos := FastFuncs.PosEx('-', BarcodeText);
  Prefix := Copy(BarcodeText, 1, DelimiterPos - 1);
  Value := Copy(BarcodeText, DelimiterPos + 1, char_length(BarcodeText) - DelimiterPos);
end;



procedure TBaseBarcode.BringToFront;
begin
  if Assigned(FForm) then
    FForm.BringToFront;
end;

procedure TBaseBarcode.EnterBarcode(const BarcodeText: string);
begin
  HandleBarcodeEntry(BarcodeText);
end;

end.
