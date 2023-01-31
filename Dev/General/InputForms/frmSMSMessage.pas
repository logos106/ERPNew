unit frmSMSMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls,
  DNMSpeedButton, Shader, DNMPanel, CorrespondenceObj;

type
  TfmSMSMessage = class(TBaseForm)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnSend: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label1: TLabel;
    edtTo: TEdit;
    Label3: TLabel;
    memMessage: TMemo;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function EditSMSMessage(corres: TCorrespondenceGui): boolean;

implementation

uses
  Vista_MessageDlg;

{$R *.dfm}

function EditSMSMessage(corres: TCorrespondenceGui): boolean;
var
  form: TfmSMSMessage;
begin
  result := false;
  form := TfmSMSMessage.Create(nil);
  try
    form.edtTo.Text := corres.RecipientList;
    form.memMessage.Lines.Text := corres.MessageText;
    if form.ShowModal = mrOk then begin
      corres.RecipientList := form.edtTo.Text;
      corres.MessageText := form.memMessage.Lines.Text;
      result := true;
    end;

  finally
    form.Release;
  end;
end;

procedure TfmSMSMessage.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfmSMSMessage.btnSendClick(Sender: TObject);
begin
  inherited;
  if Trim(edtTo.Text) = ''  then begin
    MessageDlgXP_Vista('Please enter a valid SMS Number', mtInformation,[mbOk], 0);
    exit;
  end;
  if Trim(self.memMessage.Lines.Text) = '' then begin
    MessageDlgXP_Vista('Please enter a memmage to send', mtInformation,[mbOk], 0);
    exit;
  end;
  ModalResult := mrOk;
end;

end.
