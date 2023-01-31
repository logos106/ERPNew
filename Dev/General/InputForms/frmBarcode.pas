unit frmBarcode;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 27/10/06  1.00.01 DSP  First version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DNMSpeedButton, ExtCtrls, DNMPanel, StdCtrls, Grids, ValEdit,
  BaseFormForm, AppEvnts, GraphUtil, Shader, SelectionDialog, Menus;

type
  THandleBarcodeEntry = procedure (const BarcodeText: string) of object;

  TBarcodeGUI = class(TBaseForm)
    btnClose: TDNMSpeedButton;
    grdBarcodeSteps: TValueListEditor;
    edtBarcode: TEdit;
    bvlBarcode: TBevel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure grdBarcodeStepsDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure edtBarcodeKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    FOnBarcodeEntry: THandleBarcodeEntry;
    FCaptionColor: TColor;
    FValueColor: TColor;
    FValueListColor: TColor;
  public
    property OnBarcodeEntry: THandleBarcodeEntry read FOnBarcodeEntry write FOnBarcodeEntry;
    property CaptionColor: TColor read FCaptionColor write FCaptionColor;
    property ValueColor: TColor read FValueColor write FValueColor;
  end;

implementation

{$R *.dfm}

uses
  CommonDbLib, CommonLib;

const
  cCaptionColumn = 0;

procedure TBarcodeGUI.grdBarcodeStepsDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  TextFlags: Integer;
  TextPrefix: string;
  TextSuffix: string;
begin
  with grdBarcodeSteps do begin

    if Assigned(Self.Brush.Bitmap) and (Self.Brush.Bitmap.Width > 0) then
      Canvas.Brush.Bitmap := Self.Brush.Bitmap
    else
      Canvas.Brush.Color := FValueListColor;

    Canvas.FillRect(Rect);

    if Assigned(Canvas.Brush.Bitmap) and (Canvas.Brush.Bitmap.Width > 0) then
      Canvas.Brush.Style := bsClear
    else
      Canvas.Brush.Style := bsSolid;

    Canvas.Font := grdBarcodeSteps.Font;

    if ACol = cCaptionColumn then begin
      TextPrefix := '';

      if TValueListEditor(Sender).GridLineWidth > 0 then
        TextSuffix := ' '
      else
        TextSuffix := ':';

      Canvas.Font.Color := CaptionColor;
      TextFlags := DT_RIGHT or DT_VCENTER or DT_SINGLELINE;
    end
    else begin
      TextPrefix := '  ';
      TextSuffix := '';
      Canvas.Font.Color := ValueColor;
      TextFlags := DT_LEFT or DT_VCENTER or DT_SINGLELINE;
    end;

    DrawText(Canvas.Handle, PChar(TextPrefix + Cells[ACol, ARow] + TextSuffix), -1, Rect, TextFlags);
  end;
end;

procedure TBarcodeGUI.FormCreate(Sender: TObject);
begin
  inherited;
  FOnBarcodeEntry := nil;
  FCaptionColor := clBlack;
  FValueColor := clNavy;
  FValueListColor := Self.color; //ColorAdjustLuma(GetGradientColor(Self.ClassName).Color, GetGradientColor(Self.ClassName).AdjLuma div 2, False);
  (*TitleShader.FromColor := GetGradientColor(Self.ClassName).Color;
  TitleShader.ToColorMirror := TitleShader.FromColor;*)
end;

procedure TBarcodeGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if fsModal in FormState then
    ModalResult := mrCancel
  else
    Action := caFree;
end;

procedure TBarcodeGUI.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TBarcodeGUI.edtBarcodeKeyPress(Sender: TObject; var Key: Char);
var
  BarcodeText: string;
begin
  if Key = Chr(VK_RETURN) then begin
    if Assigned(FOnBarcodeEntry) then begin
      BarcodeText := edtBarcode.Text;
      edtBarcode.Text := '';
      edtBarcode.Update;
      FOnBarcodeEntry(BarcodeText);
    end
    else
      edtBarcode.Text := '';

    Key := #0;
  end;
end;

initialization
  RegisterClassOnce(TBarcodeGUI);
finalization
  UnRegisterClass(TBarcodeGUI);
end.
