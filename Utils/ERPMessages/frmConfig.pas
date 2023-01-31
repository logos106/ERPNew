unit frmConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JsonObject, DNMSpeedButton, ExtCtrls, StdCtrls, AdvEdit;

type

  TfmConfig = class(TForm)
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label1: TLabel;
    Bevel1: TBevel;
    rbMessages: TRadioButton;
    rbDeleted: TRadioButton;
    Label2: TLabel;
    Bevel2: TBevel;
    edtListSize: TAdvEdit;
    Label3: TLabel;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rbMessagesClick(Sender: TObject);
    procedure rbDeletedClick(Sender: TObject);
    procedure edtListSizeChange(Sender: TObject);
  private
    { Private declarations }
  public
    Config: TJsonObject;
  end;

  function DoConfig(Config: TJsonObject): boolean;

implementation

uses
  Vista_MessageDlg;

{$R *.dfm}

function DoConfig(Config: TJsonObject): boolean;
var
  form: TfmConfig;
begin
  result := false;
  form := TfmConfig.Create(nil);
  try
    form.Config.Assign(Config);
    form.Left := Application.MainForm.Left + ((Application.MainForm.Width - form.Width) div 2);
    form.Top := Application.MainForm.Top + ((Application.MainForm.Height - form.Height) div 2);

    if form.ShowModal = mrOk then begin
      result := true;
      Config.Assign(form.Config);
    end;
  finally
    form.Free;
  end;
end;

procedure TfmConfig.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfmConfig.btnOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfmConfig.edtListSizeChange(Sender: TObject);
begin
  if not edtListSize.Focused then exit;
  if edtListSize.IntValue < 1 then begin
    Vista_MessageDlg.MessageDlgXP_Vista('Minimum list size is 1',mtInformation,[mbOk],0);
    edtListSize.IntValue := 1;
  end
  else if edtListSize.IntValue > 500 then begin
    Vista_MessageDlg.MessageDlgXP_Vista('Maximum list size is 500',mtInformation,[mbOk],0);
    edtListSize.IntValue := 500;
  end;
  Config.I['ListSize'] := edtListSize.IntValue;
end;

procedure TfmConfig.FormCreate(Sender: TObject);
begin
  Config := JO;
end;

procedure TfmConfig.FormDestroy(Sender: TObject);
begin
  Config.Free;
end;

procedure TfmConfig.FormShow(Sender: TObject);
begin
  rbDeleted.Checked := SameText(Config.S['ListType'], 'Deleted');
  rbMessages.Checked := not rbDeleted.Checked;
  edtListSize.IntValue := Config.I['ListSize'];
end;

procedure TfmConfig.rbDeletedClick(Sender: TObject);
begin
  if not rbDeleted.Focused then exit;
  rbMessages.Checked := not rbDeleted.Checked;
  if rbDeleted.Checked then Config.S['ListType'] := 'Deleted'
  else Config.S['ListType'] := 'Normal';
end;

procedure TfmConfig.rbMessagesClick(Sender: TObject);
begin
  if not rbMessages.Focused then exit;
  rbDeleted.Checked := not rbMessages.Checked;
  if rbDeleted.Checked then Config.S['ListType'] := 'Deleted'
  else Config.S['ListType'] := 'Normal';
end;

end.
