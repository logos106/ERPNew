unit frmPOSCancelDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DNMSpeedButton, ExtCtrls, DNMPanel,BaseInputForm;

type
  TPosMsgButtons = (bYesno=1, bOk=2);
  TfrmPOSDialog = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    lblmsg: TLabel;
    btnYes: TDNMSpeedButton;
    btnNo: TDNMSpeedButton;
    btnOk: TDNMSpeedButton;
  private
    procedure setDialogMsg(const Value: String);
    procedure setPosMsgButtons(const Value: TPosMsgButtons);
    { Private declarations }
  public
    Property DialogMsg:String write setDialogMsg;
    Property PosMsgButtons :TPosMsgButtons write setPosMsgButtons;
  end;

var
  frmPOSDialog: TfrmPOSDialog;

implementation

{$R *.dfm}

{ TfrmPOSDialog }

procedure TfrmPOSDialog.setPosMsgButtons(const Value: TPosMsgButtons);
begin
  btnYes.Visible := (Value = bYesno);
  btnNo.Visible := (Value = bYesno);
  btnok.Visible := (Value = bOk);
end;

procedure TfrmPOSDialog.setDialogMsg(const Value: String);
begin
  lblmsg.Caption := Value;
end;

end.
