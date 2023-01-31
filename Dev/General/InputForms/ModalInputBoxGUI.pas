unit ModalInputBoxGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DNMSpeedButton, StdCtrls;

type
  TfmModalInputBox = class(TForm)
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    edtInput: TEdit;
    lblPrompt: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function ModalInputBox(const aCaption, aPrompt: string; var Input: string): boolean;

implementation

{$R *.dfm}

function ModalInputBox(const aCaption, aPrompt: string; var Input: string): boolean;
var
  dlg: TfmModalInputBox;
begin
  dlg:= TfmModalInputBox.Create(nil);
  try
    dlg.Caption:= aCaption;
    dlg.lblPrompt.Caption:= aPrompt;
    dlg.edtInput.Text:= Input;
    result:= dlg.ShowModal = mrOk;
    Input:= dlg.edtInput.Text;
  finally
    dlg.Release;
  end;

end;


 { TfmModalInputBox }

procedure TfmModalInputBox.FormCreate(Sender: TObject);
begin
  inherited;
  color:= $ADCF9C;
  lblPrompt.Caption:= '';
end;

end.
