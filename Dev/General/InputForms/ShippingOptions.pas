unit ShippingOptions;

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 15/07/05  1.00.01 DMS  Added color to the form.
  // 26/08/05  1.00.02 DSP  Changed radio button caption from 'Ship in stock' to
  //                        'Ship available stock'.

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DNMSpeedButton, tcTypes, Shader, ExtCtrls,
  DNMPanel, frmBase;

type
  TfrmShippingOption = class(TfrmBaseGUI)
    Label1: TLabel;
    GroupBox1: TGroupBox;
    rbShipInStock: TRadioButton;
    rbShipAnyway: TRadioButton;
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


function GetShippingOption: TShippingOption;

implementation

uses CommonDbLib, CommonLib;

{$R *.dfm}

function GetShippingOption: TShippingOption;  
begin
  with TfrmShippingOption.Create(nil) do try
      Result := sonone;
      if (ShowModal = mrOk) then
        if rbShipAnyway.Checked then Result := soShipAnyway
        else if rbShipInStock.checked then result := soShipInStock;
    finally
      Free;
    end;
end;
procedure TfrmShippingOption.FormPaint(Sender: TObject);
var
  ColorMapRec: TColorMapRec;
begin
  ColorMapRec := GetGradientColor(Self.Classname);
  pnlTitle.Color := ColorMapRec.Color;
(*  TitleShader.FromColor := pnlTitle.Color;
  TitleShader.ToColorMirror := pnlTitle.Color;*)
  inherited;
  PaintGradientColor(Self);
  GroupBox1.Color := pnlTitle.color;
end;

initialization
  RegisterClassOnce(TfrmShippingOption);

end.
