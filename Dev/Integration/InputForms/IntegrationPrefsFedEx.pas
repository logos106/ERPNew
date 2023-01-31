unit IntegrationPrefsFedEx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwcheckbox, ExtCtrls, DNMPanel, DNMSpeedButton, AdvEdit,
  ObjGuiBindingObj;

type
  TIntegrationPrefsFedExGUI = class(TForm)
    pnlFedExConfig: TDNMPanel;
    Bevel8: TBevel;
    Label7: TLabel;
    FedExEnabled: TwwCheckBox;
    btnFedExTest: TDNMSpeedButton;
    GroupBox1: TGroupBox;
    Label11: TLabel;
    Password: TEdit;
    Label81: TLabel;
    AccountNumber: TEdit;
    Label1: TLabel;
    AccessKey: TEdit;
    Label5: TLabel;
    Server: TEdit;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    DefaultService: TComboBox;
    DefaultPackage: TComboBox;
    Label2: TLabel;
    DefaultWeight: TAdvEdit;
    lblFedExEnabled: TLabel;
    btnTestAccount: TDNMSpeedButton;
    Label6: TLabel;
    MeterNumber: TEdit;
    Label23: TLabel;
    DefaultLength: TAdvEdit;
    DefaultWidth: TAdvEdit;
    DefaultHeight: TAdvEdit;
    procedure FormCreate(Sender: TObject);
    procedure edtChange(Sender: TObject);
    procedure FedExEnabledClick(Sender: TObject);
    procedure btnFedExTestClick(Sender: TObject);
    procedure DefaultServiceChange(Sender: TObject);
    procedure DefaultPackageChange(Sender: TObject);
    procedure btnTestAccountClick(Sender: TObject);
  private
    Bindings: TObjGuiBindings;
    function CheckFedExComms(ShowOkMessage: boolean = false): boolean;
  public
    procedure Save;
  end;

implementation

{$R *.dfm}

uses
  AppEnvironment, CommonDbLib, CommonLib, ProgressDialog, ShipIntegrationUtils,
  ShipIntegrationTypes, DialogUtils;

{ TIntegrationPrefsFedExGUI }

procedure TIntegrationPrefsFedExGUI.btnFedExTestClick(Sender: TObject);
begin
  if CheckFedExComms(true) then begin
    if FedExEnabled.Checked and (AppEnv.ServerID <> '') and (AppEnv.CompanyPrefs.FedExConfig.LastServerId <> AppEnv.ServerID) then begin
      if MessageDlgXP_Vista('This company file seems to have been restored from a server with a different ID.' +
        ' Do you wish to continue and enable FedEx integration anyway?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
        AppEnv.CompanyPrefs.FedExConfig.LastServerID := AppEnv.ServerID;
        AppEnv.CompanyPrefs.FedExConfig.Save(CommonDbLib.GetSharedMyDacConnection);
      end
      else
        FedExEnabled.Checked := false;
    end;

    AppEnv.CompanyPrefs.FedExConfig.FedExEnabled := FedExEnabled.Checked;

    if FedExEnabled.Checked then
      lblFedExEnabled.Caption := 'Enabled'
    else
      lblFedExEnabled.Caption := 'Disabled';

  end;
end;

procedure TIntegrationPrefsFedExGUI.DefaultPackageChange(Sender: TObject);
begin
  if not TComboBox(Sender).Focused then exit;
  AppEnv.CompanyPrefs.FedExConfig.DefaultPackage := TComboBox(Sender).Text;
end;

procedure TIntegrationPrefsFedExGUI.DefaultServiceChange(Sender: TObject);
begin
  if not TComboBox(Sender).Focused then exit;
  AppEnv.CompanyPrefs.FedExConfig.DefaultService := TComboBox(Sender).Text;
end;

procedure TIntegrationPrefsFedExGUI.btnTestAccountClick(Sender: TObject);
var
  msg: string;
begin
  msg := 'This will delete any existing account settings and replace them with '+
    'settings for a test account for FedEx.' + #13#10 + #13#10 +
    'Is this what you want to do?';
  if CommonLib.MessageDlgXP_Vista(msg,mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
    AppEnv.CompanyPrefs.FedExConfig.AccessKey := 'cLpTXKEQEqOXkpDb';
    AppEnv.CompanyPrefs.FedExConfig.Password := '7HvkJOZdHpQX2ihPxZNHstRrq';
    AppEnv.CompanyPrefs.FedExConfig.AccountNumber := '510087860';
    AppEnv.CompanyPrefs.FedExConfig.MeterNumber := '118682029';
    AppEnv.CompanyPrefs.FedExConfig.Server := 'https://gatewaybeta.fedex.com:443/web-services';
    AppEnv.CompanyPrefs.FedExConfig.Save(CommonDbLib.GetSharedMyDacConnection);
    Bindings.PopulateGUI;
  end;
end;

function TIntegrationPrefsFedExGUI.CheckFedExComms(ShowOkMessage: boolean = false): boolean;
var
  msg: string;
  ok: boolean;
  prog: TProgressDialog;
begin
  result := true;
  msg := '';
  ok := True;
  try
    CheckShippingMethods(spFedEx, []);
    if trim(Password.text)      ='' then begin ok := False; msg := 'Please Provide the FedEx Password';       exit; end;
    if trim(AccountNumber.text) ='' then begin ok := False; msg := 'Please Provide the FedEx Account Number'; exit; end;
    if trim(MeterNumber.text)   ='' then begin ok := False; msg := 'Please Provide the FedEx Meter Number';   exit; end;
    if trim(AccessKey.text)     ='' then begin ok := False; msg := 'Please Provide the FedEx Access Key';     exit; end;
    if trim(Server.text)        ='' then begin ok := False; msg := 'Please Provide the FedEx Server';         exit; end;
    if trim(DefaultService.text)='' then begin ok := False; msg := 'Please Choose the FedEx Default Service'; exit; end;
    if trim(DefaultPackage.text)='' then begin ok := False; msg := 'Please Choose the FedEx Default Package'; exit; end;
    prog := TProgressDialog.Create(nil);
    try
      prog.Caption := 'Checking communications with FedEx';
      prog.Message := 'Please wait ..';
      prog.MaxValue := 100;
      prog.TimerUpdate := true;
      prog.Execute;
//      ok := AppEnv.CompanyPrefs.FedExConfig.CheckComms(msg);
    finally
      prog.Free;
    end;
  finally
    if not ok then begin
      result := false;
      if msg = '' then msg := 'An error occurred while attempting to communicate with the FedEx server, please check your settings.' +
        #13#10 +  #13#10 + 'The FedEx server returned the following message:' +
        #13#10 + msg + #13#10 + #13#10 +
        'Please check with your FedEx representative for your correct account details.';
      CommonLib.MessageDlgXP_Vista(msg,mtWarning,[mbOk],0);
    end
    else begin
      if ShowOkMessage then
        CommonLib.MessageDlgXP_Vista('Communications with the FedEx server are ok.',mtInformation,[mbOk],0);
    end;
  end;
end;

procedure TIntegrationPrefsFedExGUI.FedExEnabledClick(Sender: TObject);
begin
  if not FedExEnabled.Focused then exit;
  if FedExEnabled.Checked then begin
    FedExEnabled.Checked := CheckFedExComms(false);;
  end;

  if TwwCheckBox(Sender).Checked then begin
    if not AppEnv.UtilsClient.LicenceOptionEnabled('Fedex') then begin
      TwwCheckBox(Sender).Checked := false;
      DialogLicenceOptionNotEnabled;
    end;
  end;

  if FedExEnabled.Checked and (AppEnv.ServerID <> '') and (AppEnv.CompanyPrefs.FedExConfig.LastServerId <> AppEnv.ServerID) then begin
    if MessageDlgXP_Vista('This company file seems to have been restored from a server with a different ID.' +
      ' Do you wish to continue and enable FedEx integration anyway?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
      AppEnv.CompanyPrefs.FedExConfig.LastServerID := AppEnv.ServerID;
      AppEnv.CompanyPrefs.FedExConfig.Save(CommonDbLib.GetSharedMyDacConnection);
    end
    else
      FedExEnabled.Checked := false;
  end;

  AppEnv.CompanyPrefs.FedExConfig.FedExEnabled := FedExEnabled.Checked;

  if FedExEnabled.Checked then
    lblFedExEnabled.Caption := 'Enabled'
  else
    lblFedExEnabled.Caption := 'Disabled';
end;

procedure TIntegrationPrefsFedExGUI.edtChange(Sender: TObject);
begin
(*
  if (Sender is TEdit) then begin
    if not TEdit(Sender).Focused then exit;
//    if Sender = edtUserID then
//      AppEnv.CompanyPrefs.FedExConfig.UserID := TEdit(Sender).Text
    if Sender = Password then
      AppEnv.CompanyPrefs.FedExConfig.Password := TEdit(Sender).Text
    else if Sender = AccountNumber then
      AppEnv.CompanyPrefs.FedExConfig.AccountNumber := TEdit(Sender).Text
    else if Sender = AccessKey then
      AppEnv.CompanyPrefs.FedExConfig.AccessKey := TEdit(Sender).Text
    else if Sender = Server then
      AppEnv.CompanyPrefs.FedExConfig.Server := TEdit(Sender).Text;
    { disable untill access to API checked }
    AppEnv.CompanyPrefs.FedExConfig.FedExEnabled := false;
    FedExEnabled.Checked := false;
  end
  else if (Sender is TAdvEdit) then begin
    if not TAdvEdit(Sender).Focused then exit;
    AppEnv.CompanyPrefs.FedExConfig.DefaultWeight := TAdvEdit(Sender).FloatValue;
  end;
*)


end;

procedure TIntegrationPrefsFedExGUI.FormCreate(Sender: TObject);
var
  x: integer;
begin
  Bindings := TObjGuiBindings.Create(self);
  //btnTestAccount.Visible := devmode;
(*
  Password.Text := AppEnv.CompanyPrefs.FedExConfig.Password;
  AccountNumber.Text := AppEnv.CompanyPrefs.FedExConfig.AccountNumber;
  AccessKey.Text := AppEnv.CompanyPrefs.FedExConfig.AccessKey;
  Server.Text := AppEnv.CompanyPrefs.FedExConfig.Server;
  DefaultWeight.FloatValue := AppEnv.CompanyPrefs.FedExConfig.DefaultWeight;
*)

  if AppEnv.CompanyPrefs.FedExConfig.LastServerID = '' then begin
    AppEnv.CompanyPrefs.FedExConfig.LastServerID := AppEnv.ServerID;
    AppEnv.CompanyPrefs.FedExConfig.Save(CommonDbLib.GetSharedMyDacConnection);
  end;

//  FedExEnabled.Checked := AppEnv.CompanyPrefs.FedExConfig.FedExEnabled;
  Bindings.Obj := AppEnv.CompanyPrefs.FedExConfig;
  Bindings.AutoLoad;
  if AppEnv.CompanyPrefs.FedExConfig.FedExEnabled then begin
    if (AppEnv.CompanyPrefs.FedExConfig.LastServerID = AppEnv.ServerID) or (AppEnv.ServerID = '') then begin
      FedExEnabled.Checked := true;
      lblFedExEnabled.Caption := 'Enabled';
    end
    else if (AppEnv.CompanyPrefs.FedExConfig.LastServerID <> AppEnv.ServerID) then begin
      FedExEnabled.Checked := false;
      lblFedExEnabled.Caption := 'Disabled - Server ID does not match';
    end;
  end
  else begin
    FedExEnabled.Checked := false;
    lblFedExEnabled.Caption := 'Disabled';
  end;



  DefaultService.Items.Add('');
  for x := Low(ShipServiceTypeList) to High(ShipServiceTypeList) do
    if (ppFedEx in ShipServiceTypeList[x].Providers) then
      DefaultService.Items.Add(ShipServiceTypeList[x].Name);
//  DefaultService.ItemIndex := DefaultService.Items.IndexOf(AppEnv.CompanyPrefs.FedExConfig.DefaultService);
  DefaultPackage.Items.Add('');
  for x := Low(PackageTypeList) to High(PackageTypeList) do
    if ppFedEx in PackageTypeList[x].Providers then
      DefaultPackage.Items.Add(PackageTypeList[x].Name);
//  DefaultPackage.ItemIndex := DefaultPackage.Items.IndexOf(AppEnv.CompanyPrefs.FedExConfig.DefaultPackage);
  Bindings.PopulateGUI;

end;

procedure TIntegrationPrefsFedExGUI.Save;
begin
  AppEnv.CompanyPrefs.FedExConfig.Save(CommonDbLib.GetSharedMyDacConnection);
end;

end.
