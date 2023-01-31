unit IntegrationPrefsUSPS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwcheckbox, ExtCtrls, DNMPanel, DNMSpeedButton, AdvEdit,
  ObjGuiBindingObj;

type
  TIntegrationPrefsUSPSGUI = class(TForm)
    pnlUSPSConfig: TDNMPanel;
    Bevel8: TBevel;
    Label7: TLabel;
    Label8: TLabel;
    USPSEnabled: TwwCheckBox;
    GroupBox1: TGroupBox;
    Label11: TLabel;
    USPSPassword: TEdit;
    Label81: TLabel;
    USPSUserID: TEdit;
    Label5: TLabel;
    ShipServer: TEdit;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    DefaultService: TComboBox;
    DefaultPackage: TComboBox;
    Label2: TLabel;
    DefaultWeight: TAdvEdit;
    GroupBox3: TGroupBox;
    Label6: TLabel;
    Label9: TLabel;
    EndiciaAccountNumber: TEdit;
    EndiciaPassword: TEdit;
    btnTestAccount: TDNMSpeedButton;
    Label1: TLabel;
    cboEndiciaTestMode: TComboBox;
    btnUSPSTest: TDNMSpeedButton;
    lblUSPSEnabled: TLabel;
    cboTestType: TComboBox;
    GroupBox4: TGroupBox;
    Label10: TLabel;
    Label12: TLabel;
    StampsAccountNumber: TEdit;
    StampsServer: TEdit;
    StampsUserID: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    StampsPassword: TEdit;
    Label15: TLabel;
    USPSAccountNumber: TEdit;
    Label16: TLabel;
    cboStampsTestMode: TComboBox;
    GroupBox5: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    EndiciaDefaultService: TComboBox;
    EndiciaDefaultPackage: TComboBox;
    EndiciaDefaultWeight: TAdvEdit;
    GroupBox6: TGroupBox;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    StampsDefaultService: TComboBox;
    StampsDefaultPackage: TComboBox;
    StampsDefaultWeight: TAdvEdit;
    Label23: TLabel;
    DefaultLength: TAdvEdit;
    DefaultHeight: TAdvEdit;
    DefaultWidth: TAdvEdit;
    Label24: TLabel;
    EndiciaDefaultLength: TAdvEdit;
    EndiciaDefaultWidth: TAdvEdit;
    EndiciaDefaultHeight: TAdvEdit;
    Label25: TLabel;
    StampsDefaultLength: TAdvEdit;
    StampsDefaultWidth: TAdvEdit;
    StampsDefaultHeight: TAdvEdit;
    procedure FormCreate(Sender: TObject);
    procedure USPSEnabledClick(Sender: TObject);
    procedure btnUSPSTestClick(Sender: TObject);
    procedure DefaultServiceChange(Sender: TObject);
    procedure DefaultPackageChange(Sender: TObject);
    procedure btnTestAccountClick(Sender: TObject);
    procedure cboEndiciaTestModeChange(Sender: TObject);
    procedure cboStampsTestModeChange(Sender: TObject);
    procedure EndiciaDefaultServiceChange(Sender: TObject);
    procedure EndiciaDefaultPackageChange(Sender: TObject);
    procedure StampsDefaultServiceChange(Sender: TObject);
    procedure StampsDefaultPackageChange(Sender: TObject);
  private
    Bindings: TObjGuiBindings;
    function CheckUSPSComms(ShowOkMessage: boolean = false): boolean;
  public
    procedure Save;
  end;

implementation

{$R *.dfm}

uses
  AppEnvironment, CommonDbLib, CommonLib, ProgressDialog, ShipIntegrationUtils,
  ShipIntegrationTypes, DialogUtils, IntegrationPrefsLib;

{ TIntegrationPrefsUSPSGUI }

procedure TIntegrationPrefsUSPSGUI.btnTestAccountClick(Sender: TObject);
var
  msg: string;
begin
  msg := 'This will delete any existing account settings and replace them with '+
    'settings for a test account for USPS.' + #13#10 + #13#10 +
    'Is this what you want to do?';
  if CommonLib.MessageDlgXP_Vista(msg,mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
    AppEnv.CompanyPrefs.USPSConfig.USPSUserID   := TestUSPSUserID;
    AppEnv.CompanyPrefs.USPSConfig.USPSPassword := TestUSPSPassword;
    AppEnv.CompanyPrefs.USPSConfig.ShipServer   := TestShipServer;
    AppEnv.CompanyPrefs.USPSConfig.Save(CommonDbLib.GetSharedMyDacConnection);
    Bindings.PopulateGUI;
  end;
end;

procedure TIntegrationPrefsUSPSGUI.btnUSPSTestClick(Sender: TObject);
begin
  if CheckUSPSComms(true) then begin

    if USPSEnabled.Checked and (AppEnv.ServerID <> '') and (AppEnv.CompanyPrefs.USPSConfig.LastServerId <> AppEnv.ServerID) then begin
      if MessageDlgXP_Vista('This company file seems to have been restored from a server with a different ID.' +
        ' Do you wish to continue and enable USPS integration anyway?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
        AppEnv.CompanyPrefs.USPSConfig.LastServerID := AppEnv.ServerID;
        AppEnv.CompanyPrefs.USPSConfig.Save(CommonDbLib.GetSharedMyDacConnection);
      end
      else
        USPSEnabled.Checked := false;
    end;

    AppEnv.CompanyPrefs.USPSConfig.USPSEnabled := USPSEnabled.Checked;

    if USPSEnabled.Checked then
      lblUSPSEnabled.Caption := 'Enabled'
    else
      lblUSPSEnabled.Caption := 'Disabled';

  end;
end;

procedure TIntegrationPrefsUSPSGUI.DefaultPackageChange(Sender: TObject);
begin
  if not TComboBox(Sender).Focused then exit;
  AppEnv.CompanyPrefs.USPSConfig.DefaultPackage := TComboBox(Sender).Text;
end;

procedure TIntegrationPrefsUSPSGUI.DefaultServiceChange(Sender: TObject);
begin
  if not TComboBox(Sender).Focused then exit;
  AppEnv.CompanyPrefs.USPSConfig.DefaultService := TComboBox(Sender).Text;
end;

procedure TIntegrationPrefsUSPSGUI.EndiciaDefaultPackageChange(Sender: TObject);
begin
  if not TComboBox(Sender).Focused then exit;
  AppEnv.CompanyPrefs.USPSConfig.EndiciaDefaultPackage := TComboBox(Sender).Text;
end;

procedure TIntegrationPrefsUSPSGUI.EndiciaDefaultServiceChange(
  Sender: TObject);
begin
  if not TComboBox(Sender).Focused then exit;
  AppEnv.CompanyPrefs.USPSConfig.EndiciaDefaultService := TComboBox(Sender).Text;
end;

procedure TIntegrationPrefsUSPSGUI.cboEndiciaTestModeChange(Sender: TObject);
begin
  if not TComboBox(Sender).Focused then exit;
  AppEnv.CompanyPrefs.USPSConfig.EndiciaTestMode := TComboBox(Sender).ItemIndex;
end;

procedure TIntegrationPrefsUSPSGUI.cboStampsTestModeChange(Sender: TObject);
begin
  if not TComboBox(Sender).Focused then exit;
  AppEnv.CompanyPrefs.USPSConfig.StampsTestMode := TComboBox(Sender).ItemIndex;
end;

function TIntegrationPrefsUSPSGUI.CheckUSPSComms(ShowOkMessage: boolean = false): boolean;
var
  msg: string;
  ok: boolean;
  prog: TProgressDialog;
begin
  result := true;
  CheckShippingMethods(spUSPS, []);
  prog := TProgressDialog.Create(nil);
  try
    prog.Caption := 'Checking communications with USPS';
    prog.Message := 'Please wait ..';
    prog.MaxValue := 100;
    prog.TimerUpdate := true;
    prog.Execute;
    ok := AppEnv.CompanyPrefs.USPSConfig.CheckComms(cboTestType.ItemIndex,msg);
  finally
    prog.Free;
  end;
  if not ok then begin
    result := false;
    msg := 'An error occurred while attempting to communicate with the USPS server, please check your settings.' +
      #13#10 +  #13#10 + 'The USPS server returned the following message:' +
      #13#10 + msg + #13#10 + #13#10 +
      'Please check with your USPS representative for your correct account details.';
    CommonLib.MessageDlgXP_Vista(msg,mtWarning,[mbOk],0);
  end
  else begin
    if ShowOkMessage then
      CommonLib.MessageDlgXP_Vista('Communications with the USPS server are ok.',mtInformation,[mbOk],0);
  end;
end;

procedure TIntegrationPrefsUSPSGUI.USPSEnabledClick(Sender: TObject);
begin
  if not USPSEnabled.Focused then exit;
//  if USPSEnabled.Checked then begin
//    USPSEnabled.Checked := CheckUSPSComms(false);;
//  end;

  if TwwCheckBox(Sender).Checked then begin
    if not AppEnv.UtilsClient.LicenceOptionEnabled('USPS') then begin
      TwwCheckBox(Sender).Checked := false;
      DialogLicenceOptionNotEnabled;
    end;
  end;


  if USPSEnabled.Checked and (AppEnv.ServerID <> '') and (AppEnv.CompanyPrefs.USPSConfig.LastServerId <> AppEnv.ServerID) then begin
    if MessageDlgXP_Vista('This company file seems to have been restored from a server with a different ID.' +
      ' Do you wish to continue and enable USPS integration anyway?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
      AppEnv.CompanyPrefs.USPSConfig.LastServerID := AppEnv.ServerID;
      AppEnv.CompanyPrefs.USPSConfig.Save(CommonDbLib.GetSharedMyDacConnection);
    end
    else
      USPSEnabled.Checked := false;
  end;

  AppEnv.CompanyPrefs.USPSConfig.USPSEnabled := USPSEnabled.Checked;

  if USPSEnabled.Checked then
    lblUSPSEnabled.Caption := 'Enabled'
  else
    lblUSPSEnabled.Caption := 'Disabled';

end;


procedure TIntegrationPrefsUSPSGUI.FormCreate(Sender: TObject);
var
  x: integer;
begin
  Bindings := TObjGuiBindings.Create(self);
  btnTestAccount.Visible := devmode;

  if AppEnv.CompanyPrefs.USPSConfig.LastServerID = '' then begin
    AppEnv.CompanyPrefs.USPSConfig.LastServerID := AppEnv.ServerID;
    AppEnv.CompanyPrefs.USPSConfig.Save(CommonDbLib.GetSharedMyDacConnection);
  end;

  Bindings.Obj := AppEnv.CompanyPrefs.USPSConfig;
  Bindings.AutoLoad;
  if AppEnv.CompanyPrefs.USPSConfig.USPSEnabled then begin
    if (AppEnv.CompanyPrefs.USPSConfig.LastServerID = AppEnv.ServerID) or (AppEnv.ServerID = '') then begin
      USPSEnabled.Checked := true;
      lblUSPSEnabled.Caption := 'Enabled';
    end
    else if (AppEnv.CompanyPrefs.USPSConfig.LastServerID <> AppEnv.ServerID) then begin
      USPSEnabled.Checked := false;
      lblUSPSEnabled.Caption := 'Disabled - Server ID does not match';
    end;
  end
  else begin
    USPSEnabled.Checked := false;
    lblUSPSEnabled.Caption := 'Disabled';
  end;



  DefaultService.Items.Add('');
  EndiciaDefaultService.Items.Add('');
  StampsDefaultService.Items.Add('');
  for x := Low(ShipServiceTypeList) to High(ShipServiceTypeList) do begin
    if (ppUSPS in ShipServiceTypeList[x].Providers) then
      DefaultService.Items.Add(ShipServiceTypeList[x].Name);
    if (ppUSPSEndicia in ShipServiceTypeList[x].Providers) then
      EndiciaDefaultService.Items.Add(ShipServiceTypeList[x].Name);
    if (ppUSPSStamps in ShipServiceTypeList[x].Providers) then
      StampsDefaultService.Items.Add(ShipServiceTypeList[x].Name);
  end;

  DefaultPackage.Items.Add('');
  EndiciaDefaultPackage.Items.Add('');
  StampsDefaultPackage.Items.Add('');
  for x := Low(PackageTypeList) to High(PackageTypeList) do begin
    if ppUSPS in PackageTypeList[x].Providers then
      DefaultPackage.Items.Add(PackageTypeList[x].Name);
    if ppUSPSEndicia in PackageTypeList[x].Providers then
      EndiciaDefaultPackage.Items.Add(PackageTypeList[x].Name);
    if ppUSPSStamps in PackageTypeList[x].Providers then
      StampsDefaultPackage.Items.Add(PackageTypeList[x].Name);
  end;

  Bindings.PopulateGUI;
  cboEndiciaTestMode.ItemIndex := AppEnv.CompanyPrefs.USPSConfig.EndiciaTestMode;
  cboStampsTestMode.ItemIndex := AppEnv.CompanyPrefs.USPSConfig.StampsTestMode;

end;

procedure TIntegrationPrefsUSPSGUI.Save;
begin
  AppEnv.CompanyPrefs.USPSConfig.Save(CommonDbLib.GetSharedMyDacConnection);
end;

procedure TIntegrationPrefsUSPSGUI.StampsDefaultPackageChange(Sender: TObject);
begin
  if not TComboBox(Sender).Focused then exit;
  AppEnv.CompanyPrefs.USPSConfig.StampsDefaultPackage := TComboBox(Sender).Text;
end;

procedure TIntegrationPrefsUSPSGUI.StampsDefaultServiceChange(Sender: TObject);
begin
  if not TComboBox(Sender).Focused then exit;
  AppEnv.CompanyPrefs.USPSConfig.StampsDefaultService := TComboBox(Sender).Text;
end;

end.
