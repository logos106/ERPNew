unit FormSwitchObj;

{

 Date     Version Who What
 -------- ------- --- ---------------------------------------------------------
 14/10/05 1.00.01 DSP First version. This object displays a list of active
                      windows within an application using bitmaps and a
                      descriptive caption of the highlighted bitmap. A window
                      can be selected by calling the 'ActivateSelected' method.

 18/11/05 1.00.02 DSP Reduced the width of the display form.

}


interface

uses
  Classes, Forms, Windows, ExtCtrls, Controls, Graphics, Contnrs, Types;

type
{$M+}
  TFormSwitchObj = class(TObject)
  private
    FImageLeft: integer;
    FImageTop: integer;
    FFormIndex: integer;
    FContourPanel: TPanel;
    FCaptionPanel: TPanel;
    FFormList: TList;
    FImageList: TComponentList;
    FListDisplay: TForm;
    procedure FormShow(Sender: TObject);
    procedure DrawRectangle(const Canvas: TCanvas; const Color: TColor; const Width, Height: integer);
  public
    constructor Create;
    destructor Destroy; override;
  published
    procedure AddForm(const Form: TForm; const Bitmap: TBitmap);
    procedure ClearForms;
    procedure ShowFormList;
    procedure ActivateSelected;
    procedure NextForm;
  end;
{$M-}

implementation

uses
  SysUtils;

const
  cImagesPerRow = 5;

  { TFormSwitchObj }

procedure TFormSwitchObj.ActivateSelected;
begin
  if FFormIndex >= 0 then begin
    ShowWindow(TForm(FFormList[FFormIndex]).Handle, SW_RESTORE);
    TForm(FFormList[FFormIndex]).BringToFront;
  end;
end;

procedure TFormSwitchObj.AddForm(const Form: TForm; const Bitmap: TBitmap);
var
  Image: TImage;
begin
  if Assigned(Form) and Assigned(Bitmap) then begin
    FFormList.Add(Form);
    Image := TImage.Create(nil);

    with Image do begin
      Parent := FContourPanel;
      Left := FImageLeft;
      Top := FImageTop;
      Width := Bitmap.Width + 4;
      Height := Bitmap.Height + 4;
      Canvas.Draw(2, 2, Bitmap);
      DrawRectangle(Canvas, FContourPanel.Color, Width, Height);
    end;

    FImageList.Add(Image);

    if (FImageList.Count mod cImagesPerRow) = 0 then begin
      FImageLeft := 25;
      FImageTop := FImageTop + Image.Height + 10;
    end else FImageLeft := FImageLeft + Image.Width + 10;

    if (FImageList.Count mod cImagesPerRow) = 1 then FListDisplay.Height := FListDisplay.Height + Image.Height + 10;

    if FImageList.Count <= cImagesPerRow then FListDisplay.Width := FListDisplay.Width + Image.Width + 10;
  end;
end;

procedure TFormSwitchObj.ClearForms;
begin
  FFormList.Clear;
  FImageList.Clear;
  FFormIndex := -1;
end;

constructor TFormSwitchObj.Create;
begin
  inherited;
  FImageLeft := 25;
  FImageTop := 10;
  FFormIndex := -1;
  FFormList := TList.Create;
  FImageList := TComponentList.Create;
  FListDisplay := TForm.Create(nil);

  with FListDisplay do begin
    Position    := poScreenCenter;
    Width       := 40;
    BorderStyle := bsNone;
    OnShow      := FormShow;
  end;

  FContourPanel := TPanel.Create(FListDisplay);
  FContourPanel.Parent := FListDisplay;
  FContourPanel.Align := alClient;

  FCaptionPanel := TPanel.Create(FListDisplay);

  with FCaptionPanel do begin
    Parent     := FContourPanel;
    BevelOuter := bvLowered;
    Alignment  := taLeftJustify;
    Font.Style := [fsBold];
    Left       := 5;
    Height     := 20;
    Top        := FContourPanel.Height - Height - 5;
    Width      := FContourPanel.Width - 10;
    Anchors    := [akLeft, akRight, akBottom];
  end;

  FListDisplay.Height := FCaptionPanel.Height + 15;
end;

destructor TFormSwitchObj.Destroy;
begin
  FListDisplay.Release;
  FreeAndNil(FImageList);
  FreeAndNil(FFormList);
  inherited;
end;

procedure TFormSwitchObj.FormShow(Sender: TObject);
begin
  inherited;

  if FFormList.Count > 1 then begin
    FFormIndex := 1;

    with TImage(FImageList[FFormIndex]) do begin
      DrawRectangle(Canvas, clHighlight, Width, Height);
      FCaptionPanel.Caption := TForm(FFormList[FFormIndex]).Caption;
    end;
  end;
end;

procedure TFormSwitchObj.DrawRectangle(const Canvas: TCanvas; const Color: TColor; const Width, Height: integer);
begin
  Canvas.Pen.Color := Color;
  Canvas.Pen.Width := 2;
  Canvas.Brush.Style := bsClear;
  Canvas.Rectangle(1, 1, Width, Height);
end;

procedure TFormSwitchObj.NextForm;
begin
  if FFormList.Count > 1 then begin
    with TImage(FImageList[FFormIndex]) do begin
      DrawRectangle(Canvas, FContourPanel.Color, Width, Height);
      Inc(FFormIndex);
    end;

    if FFormIndex >= FFormList.Count then FFormIndex := 0;

    with TImage(FImageList[FFormIndex]) do begin
      DrawRectangle(Canvas, clHighlight, Width, Height);
      FCaptionPanel.Caption := TForm(FFormList[FFormIndex]).Caption;
    end;
  end;
end;

procedure TFormSwitchObj.ShowFormList;
begin
  if FFormList.Count > 1 then FListDisplay.Show;
end;

end.
