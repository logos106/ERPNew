unit IntegrationPrefsWalmart;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, wwcheckbox, ExtCtrls, DNMPanel,
  wwclearbuttongroup, wwradiogroup, DNMSpeedButton;

type
  TIntegrationPrefsWalmartGUI = class(TForm)
    pnlWalmartConfig: TDNMPanel;
    Bevel1: TBevel;
    lblTitle: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edtSandBoxclientSecret: TEdit;
    edtSandBoxclientID: TEdit;
    chkEnableWalmart: TwwCheckBox;
    chkShowWalmartOnMainMenu: TwwCheckBox;
    chkAutosynchList: TwwCheckBox;
    optsynchAccount: TwwRadioGroup;
    Label5: TLabel;
    Label6: TLabel;
    edtProductionClientID: TEdit;
    edtProductionclientSecret: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Label3: TLabel;
    Bevel5: TBevel;
    cmdExport: TDNMSpeedButton;
    Label11: TLabel;
    dtOrdersSynchedUntil: TDateTimePicker;
    procedure chkEnableWalmartClick(Sender: TObject);
    procedure chkShowWalmartOnMainMenuClick(Sender: TObject);
    procedure edtSandBoxclientIDChange(Sender: TObject);
    procedure edtSandBoxclientSecretChange(Sender: TObject);
    procedure chkAutosynchListClick(Sender: TObject);
    procedure edtProductionClientIDChange(Sender: TObject);
    procedure edtProductionclientSecretChange(Sender: TObject);
    procedure optsynchAccountClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Load;
    procedure Save;
  end;


implementation

uses AppEnvironment, CommonDbLib,ShellAPI ;

{$R *.dfm}

procedure TIntegrationPrefsWalmartGUI.chkAutosynchListClick           (Sender: TObject);begin if not chkAutosynchList.Focused         then exit;  AppEnv.CompanyPrefs.WalmartConfig.AutosynchList         := chkAutosynchList.Checked                       ;end;
procedure TIntegrationPrefsWalmartGUI.chkEnableWalmartClick           (Sender: TObject);begin if not chkEnableWalmart.Focused         then exit;  AppEnv.CompanyPrefs.WalmartConfig.EnableWalmart         := chkEnableWalmart.Checked                       ; end;
procedure TIntegrationPrefsWalmartGUI.chkShowWalmartOnMainMenuClick   (Sender: TObject);begin if not chkShowWalmartOnMainMenu.Focused then exit;  AppEnv.CompanyPrefs.WalmartConfig.ShowWalmartOnMainMenu := chkShowWalmartOnMainMenu.Checked; end;
procedure TIntegrationPrefsWalmartGUI.optsynchAccountClick            (Sender: TObject);begin AppEnv.CompanyPrefs.WalmartConfig.synchAccount          := optsynchAccount.Values[optsynchAccount.itemindex];end;
procedure TIntegrationPrefsWalmartGUI.edtProductionClientIDChange     (Sender: TObject);begin AppEnv.CompanyPrefs.WalmartConfig.ProductionClientID    := edtProductionClientID.Text       ; end;
procedure TIntegrationPrefsWalmartGUI.edtProductionclientSecretChange (Sender: TObject);begin AppEnv.CompanyPrefs.WalmartConfig.Productionclientsecret:= edtProductionclientSecret.Text   ; end;
procedure TIntegrationPrefsWalmartGUI.edtSandBoxclientIDChange        (Sender: TObject);begin AppEnv.CompanyPrefs.WalmartConfig.SandBoxClientID       := edtSandBoxclientID.Text       ; end;
procedure TIntegrationPrefsWalmartGUI.edtSandBoxclientSecretChange    (Sender: TObject);begin AppEnv.CompanyPrefs.WalmartConfig.SandBoxclientsecret   := edtSandBoxclientSecret.Text   ; end;

procedure TIntegrationPrefsWalmartGUI.Load;
begin
  chkEnableWalmart.checked        := AppEnv.CompanyPrefs.WalmartConfig.EnableWalmart        ;
  chkShowWalmartOnMainMenu.checked:= AppEnv.CompanyPrefs.WalmartConfig.ShowWalmartOnMainMenu;
  chkAutosynchList.checked        := AppEnv.CompanyPrefs.WalmartConfig.AutosynchList        ;
  edtProductionClientID.Text      := AppEnv.CompanyPrefs.WalmartConfig.ProductionClientID         ;
  edtProductionclientSecret.Text  := AppEnv.CompanyPrefs.WalmartConfig.Productionclientsecret ;
  edtSandBoxClientID.Text         := AppEnv.CompanyPrefs.WalmartConfig.SandBoxClientID         ;
  edtSandBoxclientSecret.Text     := AppEnv.CompanyPrefs.WalmartConfig.SandBoxclientsecret ;
  dtOrdersSynchedUntil.Datetime      := AppEnv.CompanyPrefs.WalmartConfig.OrdersSynchedUntil    ;
 if AppEnv.CompanyPrefs.WalmartConfig.synchAccount = 'S' then optsynchAccount.itemindex :=0 else optsynchAccount.itemindex := 1;
end;


procedure TIntegrationPrefsWalmartGUI.Save;
begin
  AppEnv.CompanyPrefs.WalmartConfig.Save(CommonDbLib.GetSharedMyDacConnection);
end;
procedure TIntegrationPrefsWalmartGUI.cmdExportClick(Sender: TObject);
begin
  ShellExecute(0,'open',PChar('https://developer.walmart.com/#/generateKey'),nil,nil,SW_NORMAL)
end;

end.
