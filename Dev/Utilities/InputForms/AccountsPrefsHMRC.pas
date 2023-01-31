unit AccountsPrefsHMRC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwcheckbox, HTMLabel, ExtCtrls, DNMPanel;

type
  TAccountsPrefsHMRCGUI = class(TForm)
    pnlHMRC: TDNMPanel;
    Bevel4: TBevel;
    lblPanelCaption_HMRC: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    HTMLabel1: THTMLabel;
    chkHMRCActive: TwwCheckBox;
    chkTestMode: TwwCheckBox;
    edtHMRCSandboxClientID: TEdit;
    edtHMRCSandboxClientSecret: TEdit;
    edtVATRegistrationNumber: TEdit;
    edtHMRCProductionClientID: TEdit;
    edtHMRCProductionClientSecret: TEdit;
  private
    { Private declarations }
  public
    procedure Load;
    procedure Save;
  end;

var
  AccountsPrefsHMRCGUI: TAccountsPrefsHMRCGUI;

implementation

uses
  AppEnvironment, CommonDbLib;

{$R *.dfm}

{ TAccountsPrefsHMRCGUI }

procedure TAccountsPrefsHMRCGUI.Load;
begin
  chkHMRCActive.Checked := AppEnv.CompanyPrefs.HMRC_APIConfig.Active;
  chkTestMode.Checked := AppEnv.CompanyPrefs.HMRC_APIConfig.TestMode;
  edtHMRCSandboxClientID.Text := AppEnv.CompanyPrefs.HMRC_APIConfig.SandboxClientID;
  edtHMRCSandboxClientSecret.Text := AppEnv.CompanyPrefs.HMRC_APIConfig.SandboxClientSecret;

  edtHMRCProductionClientID.Text := AppEnv.CompanyPrefs.HMRC_APIConfig.ProductionClientID;
  edtHMRCProductionClientSecret.Text := AppEnv.CompanyPrefs.HMRC_APIConfig.ProductionClientSecret;

  edtVATRegistrationNumber.Text := AppEnv.CompanyPrefs.HMRC_APIConfig.VATRegistrationNumber;
end;

procedure TAccountsPrefsHMRCGUI.Save;
begin
  AppEnv.CompanyPrefs.HMRC_APIConfig.Active := chkHMRCActive.Checked;
  AppEnv.CompanyPrefs.HMRC_APIConfig.TestMode := chkTestMode.Checked;
  AppEnv.CompanyPrefs.HMRC_APIConfig.SandboxClientID := edtHMRCSandboxClientID.Text;
  AppEnv.CompanyPrefs.HMRC_APIConfig.SandboxClientSecret := edtHMRCSandboxClientSecret.Text;

  AppEnv.CompanyPrefs.HMRC_APIConfig.ProductionClientID := edtHMRCProductionClientID.Text;
  AppEnv.CompanyPrefs.HMRC_APIConfig.ProductionClientSecret := edtHMRCProductionClientSecret.Text;

  AppEnv.CompanyPrefs.HMRC_APIConfig.VATRegistrationNumber := edtVATRegistrationNumber.Text;
  AppEnv.CompanyPrefs.HMRC_APIConfig.Save(CommonDbLib.GetSharedMyDacConnection);
end;

end.
