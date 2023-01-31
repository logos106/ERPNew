unit frmSvcGuiConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DNMSpeedButton, AdvEdit, StdCtrls, wwcheckbox, ExtCtrls,
  datSvcControlClient, DNMPanel, frmBase;

type
  TfmSvcGuiConfig = class(TfmBase)
    pnlBottom: TDNMPanel;
    btnOk: TDNMSpeedButton;
    cmdClose: TDNMSpeedButton;
    DNMPanel1: TDNMPanel;
    Label1: TLabel;
    chkMinimizeOnClose: TwwCheckBox;
    edtControlPort: TAdvEdit;
    edtControlServer: TEdit;
    Label5: TLabel;
    Label6: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function DoClientConfig(Client: TSvcControlClient): boolean;

var
  fmSvcGuiConfig: TfmSvcGuiConfig;

implementation

{$R *.dfm}

uses
  AppVarsObj;

function DoClientConfig(Client: TSvcControlClient): boolean;
var
  form: TfmSvcGuiConfig;
begin
  form:= TfmSvcGuiConfig.Create(nil);
  try
    form.chkMinimizeOnClose.Checked:= AppVars.BoolVar['MinimizeOnClose'];
    form.edtControlServer.Text:= Client.ServerIP;
    form.edtControlPort.IntValue:= Client.ServerPort;

    result:= form.ShowModal = mrOk;
    if result then begin
      AppVars.BoolVar['MinimizeOnClose']:= form.chkMinimizeOnClose.Checked;
      Client.ServerIP:= form.edtControlServer.Text;
      Client.ServerPort:= form.edtControlPort.IntValue;
    end;
  finally
    form.Release;
  end;
end;

end.
