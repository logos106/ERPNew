unit frmPaymentSurchargePercentInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, ExtCtrls, StdCtrls, AdvEdit, DNMSpeedButton, Shader,
  DNMPanel, Menus;

type
  TfmPaymentSurchargePercentInput = class(TfrmBaseGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnSave: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    edtPercent: TAdvEdit;
    Label1: TLabel;
    lblMessage: TLabel;
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function GetSurchargePercentage(const PayMethodName: string; var aPercent: double): boolean;


implementation

{$R *.dfm}

uses
  CommonLib;

function GetSurchargePercentage(const PayMethodName: string; var aPercent: double): boolean;
var
  form: TfmPaymentSurchargePercentInput;
begin
  result := false;
  form := TfmPaymentSurchargePercentInput.Create(nil);
  try
    form.lblMessage.Caption:= 'Enter the percentage surcharge to use for ' + PayMethodName;
    form.edtPercent.FloatValue := aPercent;
    if form.ShowModal = mrOk then begin
      result := true;
      aPercent := form.edtPercent.FloatValue;
    end;
  finally
    form.Free;
  end;

end;



procedure TfmPaymentSurchargePercentInput.btnSaveClick(Sender: TObject);
begin
  inherited;
  if edtPercent.FloatValue <= 0 then begin
    CommonLib.MessageDlgXP_Vista('The surcharge percentage must be greater than 0',mtInformation,[mbOk],0);
    exit;
  end
  else if edtPercent.FloatValue > 99.99 then begin
    CommonLib.MessageDlgXP_Vista('The surcharge percentage must be less than 100',mtInformation,[mbOk],0);
    exit;
  end
  else
    ModalResult := mrOk;
end;

end.
