unit IntegrationPrefsUPS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwcheckbox, ExtCtrls, DNMPanel, DNMSpeedButton, AdvEdit;

type
  TIntegrationPrefsUPSGUI = class(TForm)
    pnlUPSConfig: TDNMPanel;
    Bevel8: TBevel;
    Label7: TLabel;
    chkUPSEnabled: TwwCheckBox;
    btnUPSTest: TDNMSpeedButton;
    GroupBox1: TGroupBox;
    Label10: TLabel;
    edtUserID: TEdit;
    Label11: TLabel;
    edtPassword: TEdit;
    Label81: TLabel;
    edtAccountNumber: TEdit;
    Label1: TLabel;
    edtAccessKey: TEdit;
    Label5: TLabel;
    edtServerURL: TEdit;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    cboServiceType: TComboBox;
    cboPackage: TComboBox;
    Label2: TLabel;
    edtDefaultWeight: TAdvEdit;
    lblUPSEnabled: TLabel;
    btnTestAccount: TDNMSpeedButton;
    Label23: TLabel;
    DefaultLength: TAdvEdit;
    DefaultWidth: TAdvEdit;
    DefaultHeight: TAdvEdit;
    chkTestMode: TwwCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure edtChange(Sender: TObject);
    procedure chkUPSEnabledClick(Sender: TObject);
    procedure btnUPSTestClick(Sender: TObject);
    procedure cboServiceTypeChange(Sender: TObject);
    procedure cboPackageChange(Sender: TObject);
    procedure chkTestModeClick(Sender: TObject);
//    procedure btnTestAccountClick(Sender: TObject);
  private
    function CheckUPSComms(ShowOkMessage: boolean = false): boolean;
    procedure LoadGUI;
  public
    procedure Save;
  end;

implementation

{$R *.dfm}

uses
  AppEnvironment, CommonDbLib, CommonLib, ProgressDialog, ShipIntegrationUtils,
  ShipIntegrationTypes, DialogUtils;

{ TIntegrationPrefsUPSGUI }

(*
procedure TIntegrationPrefsUPSGUI.btnTestAccountClick(Sender: TObject);
var
  msg: string;
begin
  msg := 'This will delete any existing account settings and replace them with '+
    'settings for a test account for UPS.' + #13#10 + #13#10 +
    'Is this what you want to do?';
  if CommonLib.MessageDlgXP_Vista(msg,mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
    AppEnv.CompanyPrefs.UPSConfig.UPSServer := 'https://wwwcie.ups.com/webservices';


    AppEnv.CompanyPrefs.UPSConfig.Save(CommonDbLib.GetSharedMyDacConnection);
    LoadGUI;
  end;
end;
*)

procedure TIntegrationPrefsUPSGUI.btnUPSTestClick(Sender: TObject);
begin
  if CheckUPSComms(true) then begin
    if chkUPSEnabled.Checked and (AppEnv.ServerID <> '') and (AppEnv.CompanyPrefs.UPSConfig.LastServerId <> AppEnv.ServerID) then begin
      if MessageDlgXP_Vista('This company file seems to have been restored from a server with a different ID.' +
        ' Do you wish to continue and enable UPS integration anyway?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
        AppEnv.CompanyPrefs.UPSConfig.LastServerID := AppEnv.ServerID;
        AppEnv.CompanyPrefs.UPSConfig.Save(CommonDbLib.GetSharedMyDacConnection);
      end
      else
        chkUPSEnabled.Checked := false;
    end;

    AppEnv.CompanyPrefs.UPSConfig.UPSEnabled := chkUPSEnabled.Checked;

    if chkUPSEnabled.Checked then
      lblUPSEnabled.Caption := 'Enabled'
    else
      lblUPSEnabled.Caption := 'Disabled';
    end;
end;


procedure TIntegrationPrefsUPSGUI.cboPackageChange(Sender: TObject);
begin
  if not TComboBox(Sender).Focused then exit;
  AppEnv.CompanyPrefs.UPSConfig.DefaultPackage := TComboBox(Sender).Text;
end;

procedure TIntegrationPrefsUPSGUI.cboServiceTypeChange(Sender: TObject);
begin
  if not TComboBox(Sender).Focused then exit;
  AppEnv.CompanyPrefs.UPSConfig.DefaultService := TComboBox(Sender).Text;
end;

function TIntegrationPrefsUPSGUI.CheckUPSComms(ShowOkMessage: boolean = false): boolean;
var
  msg: string;
  ok: boolean;
  prog: TProgressDialog;
begin
  result := true;
//  CheckShippingMethods(spUPS, [ssoUSDomestic]);
//  prog := TProgressDialog.Create(nil);
//  try
//    prog.Caption := 'Checking communications with UPS';
//    prog.Message := 'Please wait ..';
//    prog.MaxValue := 100;
//    prog.TimerUpdate := true;
//    prog.Execute;
////    ok := AppEnv.CompanyPrefs.UPSConfig.CheckComms(msg);
//  finally
//    prog.Free;
//  end;
//  if not ok then begin
//    result := false;
//    msg := 'An error occured while attempting to communicate with the UPS server, please check your settings.' +
//      #13#10 +  #13#10 + 'The UPS server returned the following message:' +
//      #13#10 + msg + #13#10 + #13#10 +
//      'Please check with your UPS representative for your correct account details.';
//    CommonLib.MessageDlgXP_Vista(msg,mtWarning,[mbOk],0);
//  end
//  else begin
//    if ShowOkMessage then
//      CommonLib.MessageDlgXP_Vista('Communications with the UPS server are ok.',mtInformation,[mbOk],0);
//  end;
end;

procedure TIntegrationPrefsUPSGUI.chkTestModeClick(Sender: TObject);
begin
  if not chkTestMode.Focused then exit;
  AppEnv.CompanyPrefs.UPSConfig.TestMode := chkTestMode.Checked;
end;

procedure TIntegrationPrefsUPSGUI.chkUPSEnabledClick(Sender: TObject);
begin
  if not chkUPSEnabled.Focused then exit;
  if chkUPSEnabled.Checked then begin
    chkUPSEnabled.Checked := CheckUPSComms(false);;
  end;

  if TwwCheckBox(Sender).Checked then begin
    if not AppEnv.UtilsClient.LicenceOptionEnabled('UPS') then begin
      TwwCheckBox(Sender).Checked := false;
      DialogLicenceOptionNotEnabled;
    end;
  end;

  if chkUPSEnabled.Checked and (AppEnv.ServerID <> '') and (AppEnv.CompanyPrefs.UPSConfig.LastServerId <> AppEnv.ServerID) then begin
    if MessageDlgXP_Vista('This company file seems to have been restored from a server with a different ID.' +
      ' Do you wish to continue and enable UPS integration anyway?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
      AppEnv.CompanyPrefs.UPSConfig.LastServerID := AppEnv.ServerID;
      AppEnv.CompanyPrefs.UPSConfig.Save(CommonDbLib.GetSharedMyDacConnection);
    end
    else
      chkUPSEnabled.Checked := false;
  end;

  AppEnv.CompanyPrefs.UPSConfig.UPSEnabled := chkUPSEnabled.Checked;

  if chkUPSEnabled.Checked then
    lblUPSEnabled.Caption := 'Enabled'
  else
    lblUPSEnabled.Caption := 'Disabled';



end;

procedure TIntegrationPrefsUPSGUI.edtChange(Sender: TObject);
begin
  if (Sender is TEdit) then begin
    if not TEdit(Sender).Focused then exit;
    if Sender = edtUserID then
      AppEnv.CompanyPrefs.UPSConfig.UPSUserID := TEdit(Sender).Text
    else if Sender = edtPassword then
      AppEnv.CompanyPrefs.UPSConfig.UPSPassword := TEdit(Sender).Text
    else if Sender = edtAccountNumber then
      AppEnv.CompanyPrefs.UPSConfig.UPSAccountNumber := TEdit(Sender).Text
    else if Sender = edtAccessKey then
      AppEnv.CompanyPrefs.UPSConfig.UPSAccessKey := TEdit(Sender).Text
    else if Sender = edtServerURL then
      AppEnv.CompanyPrefs.UPSConfig.UPSServer := TEdit(Sender).Text;
    { disable untill access to API checked }
    AppEnv.CompanyPrefs.UPSConfig.UPSEnabled := false;
    chkUPSEnabled.Checked := false;
  end
  else if (Sender is TAdvEdit) then begin
    if not TAdvEdit(Sender).Focused then exit;
    AppEnv.CompanyPrefs.UPSConfig.DefaultWeight := TAdvEdit(Sender).FloatValue;
  end;


end;

procedure TIntegrationPrefsUPSGUI.FormCreate(Sender: TObject);
var
  x: integer;
begin
  LoadGUI;
//  btnTestAccount.Visible := devmode;

  if AppEnv.CompanyPrefs.UPSConfig.LastServerID = '' then begin
    AppEnv.CompanyPrefs.UPSConfig.LastServerID := AppEnv.ServerID;
    AppEnv.CompanyPrefs.UPSConfig.Save(CommonDbLib.GetSharedMyDacConnection);
  end;

  chkUPSEnabled.Checked := AppEnv.CompanyPrefs.UPSConfig.UPSEnabled;
  if AppEnv.CompanyPrefs.UPSConfig.UPSEnabled then begin
    if (AppEnv.CompanyPrefs.UPSConfig.LastServerID = AppEnv.ServerID) or (AppEnv.ServerID = '') then begin
      chkUPSEnabled.Checked := true;
      lblUPSEnabled.Caption := 'Enabled';
    end
    else if (AppEnv.CompanyPrefs.UPSConfig.LastServerID <> AppEnv.ServerID) then begin
      chkUPSEnabled.Checked := false;
      lblUPSEnabled.Caption := 'Disabled - Server ID does not match';
    end;
  end
  else begin
    chkUPSEnabled.Checked := false;
    lblUPSEnabled.Caption := 'Disabled';
  end;




  for x := Low(ShipServiceTypeList) to High(ShipServiceTypeList) do
    if (ppUPS in ShipServiceTypeList[x].Providers) and (ssoUSDomestic in ShipServiceTypeList[x].Options) then
      cboServiceType.Items.Add(ShipServiceTypeList[x].Name);
  cboServiceType.ItemIndex := cboServiceType.Items.IndexOf(AppEnv.CompanyPrefs.UPSConfig.DefaultService);
  for x := Low(PackageTypeList) to High(PackageTypeList) do
    if ppUPS in PackageTypeList[x].Providers then
      cboPackage.Items.Add(PackageTypeList[x].Name);
  cboPackage.ItemIndex := cboPackage.Items.IndexOf(AppEnv.CompanyPrefs.UPSConfig.DefaultPackage);

end;

procedure TIntegrationPrefsUPSGUI.LoadGUI;
begin
  edtUserID.Text := AppEnv.CompanyPrefs.UPSConfig.UPSUserID;
  edtPassword.Text := AppEnv.CompanyPrefs.UPSConfig.UPSPassword;
  edtAccountNumber.Text := AppEnv.CompanyPrefs.UPSConfig.UPSAccountNumber;
  edtAccessKey.Text := AppEnv.CompanyPrefs.UPSConfig.UPSAccessKey;
  edtServerURL.Text := AppEnv.CompanyPrefs.UPSConfig.UPSServer;
  edtDefaultWeight.FloatValue := AppEnv.CompanyPrefs.UPSConfig.DefaultWeight;
  chkTestMode.Checked := AppEnv.CompanyPrefs.UPSConfig.TestMode;
end;

procedure TIntegrationPrefsUPSGUI.Save;
begin
  AppEnv.CompanyPrefs.UPSConfig.Save(CommonDbLib.GetSharedMyDacConnection);
end;

end.
