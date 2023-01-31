unit IntegrationPrefsSPS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DNMSpeedButton, StdCtrls, wwcheckbox, ExtCtrls, DNMPanel;

type
  TIntegrationPrefsSPSGUI = class(TForm)
    pnlSPSConfig: TDNMPanel;
    Bevel8: TBevel;
    Label7: TLabel;
    lblAmazonEnabled: TLabel;
    GroupBox1: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label5: TLabel;
    edtFTPUsername: TEdit;
    edtFTPPassword: TEdit;
    edtFTPSite: TEdit;
    chkSPSEnabled: TwwCheckBox;
    btnUPSTest: TDNMSpeedButton;
    btnTestAccount: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure edtChange(Sender: TObject);
    procedure chkSPSEnabledClick(Sender: TObject);
  private
    procedure LoadGUI;
  public
    procedure Save;
  end;

var
  IntegrationPrefsSPSGUI: TIntegrationPrefsSPSGUI;

implementation

{$R *.dfm}

uses
  AppEnvironment, CommonDbLib, DialogUtils;

{ TIntegrationPrefsSPSGUI }

procedure TIntegrationPrefsSPSGUI.chkSPSEnabledClick(Sender: TObject);
begin
  if not chkSPSEnabled.Focused then exit;
  if TwwCheckBox(Sender).Checked then begin
    if not AppEnv.UtilsClient.LicenceOptionEnabled('SPS') then begin
      TwwCheckBox(Sender).Checked := false;
      DialogLicenceOptionNotEnabled;
    end;
  end;
  AppEnv.CompanyPrefs.SPSConfig.Active := chkSPSEnabled.Checked;
end;

procedure TIntegrationPrefsSPSGUI.edtChange(Sender: TObject);
begin
  if (Sender is TEdit) then begin
    if not TEdit(Sender).Focused then exit;
    if Sender = edtFTPUsername then
      AppEnv.CompanyPrefs.SPSConfig.FTPUserName := TEdit(Sender).Text
    else if Sender = edtFTPPassword then
      AppEnv.CompanyPrefs.SPSConfig.FTPPassword := TEdit(Sender).Text
    else if Sender = edtFTPSite then
      AppEnv.CompanyPrefs.SPSConfig.FTPSite := TEdit(Sender).Text;
  end;
end;

procedure TIntegrationPrefsSPSGUI.FormCreate(Sender: TObject);
begin
  LoadGUI;
end;

procedure TIntegrationPrefsSPSGUI.LoadGUI;
begin
  chkSPSEnabled.Checked := AppEnv.CompanyPrefs.SPSConfig.Active;
  edtFTPUsername.Text := AppEnv.CompanyPrefs.SPSConfig.FTPUserName;
  edtFTPPassword.Text := AppEnv.CompanyPrefs.SPSConfig.FTPPassword;
  edtFTPSite.Text := AppEnv.CompanyPrefs.SPSConfig.FTPSite;
end;

procedure TIntegrationPrefsSPSGUI.Save;
begin
  AppEnv.CompanyPrefs.SPSConfig.Save(CommonDbLib.GetSharedMyDacConnection);
end;

end.
