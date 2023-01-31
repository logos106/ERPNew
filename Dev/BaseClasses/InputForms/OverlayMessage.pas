unit OverlayMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DNMSpeedButton, ExtCtrls;

type
  TOverlayMessageGUI = class(TForm)
    btnClose: TDNMSpeedButton;
    lblMsg: TLabel;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure DoShowMsg(const msg: string; PosRefForm: TForm; DisplaySecs: integer);
    class procedure ShowMsg(const msg: string; PosRefForm: TForm = nil; DisplaySecs: integer = 8);
  end;

implementation

{$R *.dfm}

procedure TOverlayMessageGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TOverlayMessageGUI.FormCreate(Sender: TObject);
begin
  AlphaBlend := true;
  AlphaBlendValue := 150;
end;

class procedure TOverlayMessageGUI.ShowMsg(const msg: string; PosRefForm: TForm;
  DisplaySecs: integer);
var
  form: TOverlayMessageGUI;
begin
  form := TOverlayMessageGUI.Create(nil);
  form.DoShowMsg(msg,PosRefForm,DisplaySecs);
  form.ShowModal;
end;

procedure TOverlayMessageGUI.btnCloseClick(Sender: TObject);
begin
  Timer1.Enabled := false;
  if fsModal in self.FormState then
    ModalResult := mrOk
  else
    Close;
end;

procedure TOverlayMessageGUI.DoShowMsg(const msg: string;
  PosRefForm: TForm; DisplaySecs: integer);
begin
  lblMsg.Caption := msg;
  if Assigned(PosRefForm) then begin
    self.Left := (PosRefForm.Left + ((PosRefForm.Width - self.Width) Div 2));
    self.Top := (PosRefForm.Top + ((PosRefForm.Height - self.Height) Div 2));
  end;
  if DisplaySecs > 0 then begin
    Timer1.Interval := DisplaySecs * 1000;
    Timer1.Enabled := true;
  end;
end;

procedure TOverlayMessageGUI.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := false;
  if fsModal in self.FormState then
    ModalResult := mrOk
  else
    Close;
end;

end.
