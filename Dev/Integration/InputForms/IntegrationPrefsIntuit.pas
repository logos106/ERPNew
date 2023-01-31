unit IntegrationPrefsIntuit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DNMPanel, wwcheckbox, ComCtrls;

type
  TItegrationPrefsIntuitGUI = class(TForm)
    pnlIntuitConfig: TDNMPanel;
    Bevel8: TBevel;
    lblTitle: TLabel;
    edtSandboxClientSecret: TEdit;
    Label11: TLabel;
    edtSandboxClientID: TEdit;
    Label10: TLabel;
    Label2: TLabel;
    edtCompanyId: TEdit;
    chkSandboxMode: TwwCheckBox;
    chkEnableQuickbooks: TwwCheckBox;
    chkShowQuickbooksonMainmenubyDefault: TwwCheckBox;
    chkAutoSynchFromList: TwwCheckBox;
    Label4: TLabel;
    dtSynchFromDate: TDateTimePicker;
    Label5: TLabel;
    Label6: TLabel;
    edtProductionClientID: TEdit;
    edtProductionClientSecret: TEdit;
    procedure edtChange(Sender: TObject);
    procedure chkSandboxModeClick(Sender: TObject);
    procedure chkEnableQuickbooksClick(Sender: TObject);
    procedure chkShowQuickbooksonMainmenubyDefaultClick(Sender: TObject);
    procedure chkAutoSynchFromListClick(Sender: TObject);
    procedure dtSynchFromDateChange(Sender: TObject);
    procedure dtSynchFromDateCloseUp(Sender: TObject);
  private
  public
    procedure Load;
    procedure Save;
  end;

implementation

uses
  AppEnvironment, CommonDbLib, DialogUtils;

{$R *.dfm}

{ TItegrationPrefsIntuitGUI }

procedure TItegrationPrefsIntuitGUI.chkAutoSynchFromListClick(Sender: TObject);
begin
  if not chkAutoSynchFromList.Focused then exit;
  AppEnv.CompanyPrefs.IntuitConfig.AutoSynchFromList := chkAutoSynchFromList.Checked;
end;

procedure TItegrationPrefsIntuitGUI.chkSandboxModeClick(Sender: TObject);
begin
  if not chkSandboxMode.Focused then exit;
  AppEnv.CompanyPrefs.IntuitConfig.SandboxMode := chkSandboxMode.Checked;
end;
procedure TItegrationPrefsIntuitGUI.chkEnableQuickbooksClick(Sender: TObject);
begin
  if not chkEnableQuickbooks.Focused then exit;
  if TwwCheckBox(Sender).Checked then begin
    if not AppEnv.UtilsClient.LicenceOptionEnabled('Quickbooks') then begin
      TwwCheckBox(Sender).Checked := false;
      DialogLicenceOptionNotEnabled;
    end;
  end;
  AppEnv.CompanyPrefs.IntuitConfig.EnableQuickbooks := TwwCheckBox(Sender).Checked;
end;
procedure TItegrationPrefsIntuitGUI.chkShowQuickbooksonMainmenubyDefaultClick(Sender: TObject);
begin
  if not chkShowQuickbooksonMainmenubyDefault.Focused then exit;
  AppEnv.CompanyPrefs.IntuitConfig.ShowQuickbooksonMainmenubyDefault := chkShowQuickbooksonMainmenubyDefault.Checked;
end;

procedure TItegrationPrefsIntuitGUI.dtSynchFromDateChange(Sender: TObject);
begin
  AppEnv.CompanyPrefs.IntuitConfig.SynchFromDate := dtSynchFromDate.Date;
end;

procedure TItegrationPrefsIntuitGUI.dtSynchFromDateCloseUp(Sender: TObject);
begin
  AppEnv.CompanyPrefs.IntuitConfig.SynchFromDate := dtSynchFromDate.Date;
end;

procedure TItegrationPrefsIntuitGUI.edtChange(Sender: TObject);
begin
  if (Sender is TEdit) then begin
    if not TEdit(Sender).Focused then exit;

    if Sender = edtSandboxClientID then
      AppEnv.CompanyPrefs.IntuitConfig.SandboxClientID := TEdit(Sender).Text
    else if Sender = edtSandboxClientSecret then
      AppEnv.CompanyPrefs.IntuitConfig.SandboxClientSecret := TEdit(Sender).Text
    else if Sender = edtProductionClientID then
      AppEnv.CompanyPrefs.IntuitConfig.ProductionClientID := TEdit(Sender).Text
    else if Sender = edtProductionClientSecret then
      AppEnv.CompanyPrefs.IntuitConfig.ProductionClientSecret := TEdit(Sender).Text

(*    else if Sender = edtCoreEDIUser then
      AppEnv.CompanyPrefs.CoreEDIUSerName := TEdit(Sender).Text
    else if Sender = edtCoreEDIPassword then
      AppEnv.CompanyPrefs.CoreEDIPassword := TEdit(Sender).Text*)
    else if Sender = edtCompanyId then begin
      if TEdit(Sender).Text <> '' then
        TEdit(Sender).Text := StringReplace(TEdit(Sender).Text, ' ', '', [rfReplaceAll]);
      AppEnv.CompanyPrefs.IntuitConfig.CompanyId := TEdit(Sender).Text;
    end;
  end;
end;

procedure TItegrationPrefsIntuitGUI.Load;
begin
  edtSandboxClientID.Text := AppEnv.CompanyPrefs.IntuitConfig.SandboxClientID;
  edtSandboxClientSecret.Text := AppEnv.CompanyPrefs.IntuitConfig.SandboxClientSecret;
  edtProductionClientID.Text := AppEnv.CompanyPrefs.IntuitConfig.ProductionClientID;
  edtProductionClientSecret.Text := AppEnv.CompanyPrefs.IntuitConfig.ProductionClientSecret;

(*  edtCoreEDIUser.Text := AppEnv.CompanyPrefs.CoreEDIUSerName;
  edtCoreEDIPassword.Text := AppEnv.CompanyPrefs.CoreEDIPassword;*)
  edtCompanyID.Text := AppEnv.CompanyPrefs.IntuitConfig.CompanyID;
  chkSandboxMode.Checked := AppEnv.CompanyPrefs.IntuitConfig.SandboxMode;
  chkEnableQuickbooks.Checked := AppEnv.CompanyPrefs.IntuitConfig.EnableQuickbooks;
  chkShowQuickbooksonMainmenubyDefault.Checked := AppEnv.CompanyPrefs.IntuitConfig.ShowQuickbooksonMainmenubyDefault;
  chkAutoSynchFromList.Checked := AppEnv.CompanyPrefs.IntuitConfig.AutoSynchFromList;
  dtSynchFromDate.Date := AppEnv.CompanyPrefs.IntuitConfig.SynchFromDate;
end;

procedure TItegrationPrefsIntuitGUI.Save;
begin
  AppEnv.CompanyPrefs.IntuitConfig.Save(CommonDbLib.GetSharedMyDacConnection);
end;

end.
