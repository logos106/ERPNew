unit frmBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TfmBase = class(TForm)
    procedure FormPaint(Sender: TObject);
  private
    fbPainting: boolean;
  public
    { Public declarations }
  end;

var
  fmBase: TfmBase;

implementation

{$R *.dfm}

uses
  GraphUtil, Math,DNMSpeedButton, StdCtrls;

const
  cDefaultGradientColor = $ADCF9C;
  cAdjustLuma = 50;
  cMaxColorMap = 17;

type

  TColorMapRec = record
    Name: string;
    Color: TColor;
    AdjLuma: Integer;
  end;

procedure InvalidateComponents(const RootComponent: TComponent;
  const IncludedLabels: boolean= false);
Var
  I:Integer;
begin
  for I := 0 to RootComponent.ComponentCount - 1 do begin
    if (RootComponent.Components[I] is TDNMSpeedButton) then begin
      TDNMSpeedButton(RootComponent.Components[I]).Update;
      TDNMSpeedButton(RootComponent.Components[I]).Invalidate;
    end;
//    if (RootComponent.Components[I] is TwwDBGrid) then begin
//      TwwDBGrid(RootComponent.Components[I]).Update;
//      TwwDBGrid(RootComponent.Components[I]).Invalidate;
//    end;
    if IncludedLabels AND (RootComponent.Components[I] is TLabel) then begin
      TLabel(RootComponent.Components[I]).Update;
      TLabel(RootComponent.Components[I]).Invalidate;
    end;
  end;
end;

procedure PaintGradientColor(const Form: TForm);
var
  Y: Integer;
  dr,dg,db: Extended;
  C1,C2: TColor;
  R1,R2,G1,G2,B1,B2: Byte;
  R,G,B: Byte;
  cnt: Integer;
  ColorMapRec: TColorMapRec;
begin

  ColorMapRec.Color := cDefaultGradientColor;
  ColorMapRec.AdjLuma := cAdjustLuma;

  C1 := ColorAdjustLuma(ColorMapRec.Color, ColorMapRec.AdjLuma, False);
  R1 := GetRValue(C1);
  G1 := GetGValue(C1);
  B1 := GetBValue(C1);

  C2 := ColorMapRec.Color;
  R2 := GetRValue(C2);
  G2 := GetGValue(C2);
  B2 := GetBValue(C2);

  dr := (R2 - R1) / Form.ClientRect.Bottom-Form.ClientRect.Top;
  dg := (G2 - G1) / Form.ClientRect.Bottom-Form.ClientRect.Top;
  db := (B2 - B1) / Form.ClientRect.Bottom-Form.ClientRect.Top;

  cnt := 0;

  for Y := Form.ClientRect.Top to Form.ClientRect.Bottom - 1 do begin
    R := R1+Ceil(dr*cnt);
    G := G1+Ceil(dg*cnt);
    B := B1+Ceil(db*cnt);

    Form.Canvas.Pen.Color := RGB(R, G, B);
    Form.Canvas.MoveTo(Form.ClientRect.Left, Y);
    Form.Canvas.LineTo(Form.ClientRect.Right, Y);
    Inc(cnt);
  end;
end;



procedure TfmBase.FormPaint(Sender: TObject);
begin
  inherited;
  If not fbPainting then Try  // Attempt to Stop InvalidateComponents force Paint Loop
    fbPainting := True;
    PaintGradientColor(Self);
    InvalidateComponents(Self);
  finally
    fbPainting := False;
  end;
end;

end.
