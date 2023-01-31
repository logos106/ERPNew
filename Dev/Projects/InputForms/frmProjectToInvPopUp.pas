unit frmProjectToInvPopUp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DNMSpeedButton, ExtCtrls, DNMPanel, Shader,
  frmBase;

type
  TProgressPaymentPopUp = class(TfrmBaseGUI)
    pnlConvert: TDNMPanel;
    Label2: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    chkConvertAll: TCheckBox;
    edtPercent: TEdit;
    edtBalance: TEdit;
    edtTotal: TEdit;
    Label1: TLabel;
    edtAmount: TEdit;
    Label3: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    edtDesc: TEdit;
    Label5: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure edtPercentChange(Sender: TObject);
    procedure edtAmountChange(Sender: TObject);
    procedure chkConvertAllClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure edtAmountExit(Sender: TObject);
    procedure edtAmountEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    //class function Instance: TProgressPaymentPopUp;
  end;

//var
//  ProgressPaymentPopUp: TProgressPaymentPopUp;

implementation

{$R *.dfm}
uses
  CommonLib;

procedure TProgressPaymentPopUp.FormShow(Sender: TObject);
begin
  inherited;
  edtPercent.Text := '';
  edtAmount.Text := '';
  edtDesc.Text := '';
end;

procedure TProgressPaymentPopUp.edtPercentChange(Sender: TObject);
begin
  if not Empty(edtPercent.Text) then begin
    edtAmount.Text        := '';
    chkConvertAll.Checked := false;
  end;
end;

procedure TProgressPaymentPopUp.edtAmountChange(Sender: TObject);
begin
  if not Empty(edtAmount.Text) then begin
    edtPercent.Text       := '';
    chkConvertAll.Checked := false;
  end;
end;

procedure TProgressPaymentPopUp.chkConvertAllClick(Sender: TObject);
begin
  if chkConvertAll.Checked then begin
    edtPercent.Text := '';
    edtAmount.Text  := '';
  end;
end;

procedure TProgressPaymentPopUp.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if (ModalResult <> mrCancel) then begin
    if not (chkConvertAll.Checked) and (Empty(edtPercent.Text)) and (Empty(edtAmount.Text)) then begin
      CommonLib.MessageDlgXP_Vista('You Must provide a Percent or Amount to Convert OR Select All', mtError, [mbOK], 0);
      SetControlFocus(edtPercent);
      CanClose := false;
    end;
  end;
end;

procedure TProgressPaymentPopUp.edtAmountExit(Sender: TObject);
var
  rAmount: currency;
begin
  if Empty(edtPercent.Text) then begin
    rAmount        := StrValue(edtAmount.Text);
    edtAmount.Text := CurrToStrF(rAmount, ffCurrency, 2);
  end;
end;

procedure TProgressPaymentPopUp.edtAmountEnter(Sender: TObject);
var
  rAmount: currency;
begin
  rAmount := StrValue(edtAmount.Text);
  if rAmount = 0 then begin
    edtAmount.Text := '';
  end else begin
    edtAmount.Text := CurrToStr(rAmount);
  end;
end;

Initialization
  RegisterClassOnce(TProgressPaymentPopUp);

end.
