unit fraModWebAPIConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fraUtilsConfigBase, ExtCtrls, StdCtrls, wwclearbuttongroup,
  wwradiogroup, DNMSpeedButton, AdvEdit, DBAdvEd;

type
  TfrModWebAPIConfig = class(TfrUtilsConfigBase)
    Label9: TLabel;
    btnShowLog: TDNMSpeedButton;
    rgLoggingLevel: TwwRadioGroup;
    Bevel1: TBevel;
    Label2: TLabel;
    edtWebUserName: TEdit;
    btnTest: TDNMSpeedButton;
    Label3: TLabel;
    edtMaxConnections: TDBAdvEdit;
    Label7: TLabel;
    Label4: TLabel;
    edtServerPort: TDBAdvEdit;
    Label5: TLabel;
    edtServerSSLPort: TDBAdvEdit;
    chkUseSSL: TCheckBox;
    chkActive: TCheckBox;
    btnRESTClient: TDNMSpeedButton;
    lblRestartMessage: TLabel;
    btnLogFile: TDNMSpeedButton;
    procedure rgLoggingLevelClick(Sender: TObject);
    procedure edtWebUserNameExit(Sender: TObject);
    procedure chkUseSSLClick(Sender: TObject);
    procedure btnShowLogClick(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure btnRESTClientClick(Sender: TObject);
    procedure btnLogFileClick(Sender: TObject);
    procedure edtMaxConnectionsExit(Sender: TObject);
    procedure edtServerPortExit(Sender: TObject);
    procedure edtServerSSLPortExit(Sender: TObject);
  private
    procedure TellUserToRestart;
  protected
    function GetModuleName: string; override;
    procedure AfterGetModuleConfig; override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  frModWebAPIConfig: TfrModWebAPIConfig;

implementation

{$R *.dfm}

uses
  LogMessageTypes, frmWebAPITestSteps, ShellAPI, InstallConst, Vista_MessageDlg,
  wwCheckBox, DialogUtils;

{ TfrModWebAPIConfig }

procedure TfrModWebAPIConfig.AfterGetModuleConfig;
begin
  inherited;
  rgLoggingLevel.ItemIndex := Ord(StrToLoggingLevel(Config.S['LoggingLevel']));
  edtWebUserName.Text := Config.S['WebUserName'];
  edtMaxConnections.IntValue := Config.I['MaxConnections'];
  edtServerPort.IntValue := Config.I['DefaultPort'];
  edtServerSSLPort.IntValue := Config.I['DefaultSSLPort'];
  chkUseSSL.Checked := Config.B['UseSSL'];
  chkActive.Checked := Config.B['Active'];
end;

procedure TfrModWebAPIConfig.btnLogFileClick(Sender: TObject);
var
  fileName: string;
begin
  inherited;
  fileName := ERP_UTILITIES_LOG_DIR  + 'ERPWebService_' + FormatDateTime('yyyy_mm_dd',now) + '.log';
  if FileExists(fileName) then
    ShellExecute(0, 'open', PChar(fileName), nil, nil, SW_NORMAL)
  else
    MessageDlgXP_Vista('Log file not found.', mtInformation, [mbOK], 0);
end;

procedure TfrModWebAPIConfig.btnRESTClientClick(Sender: TObject);
begin
  inherited;
  ShellExecute(0,'open',PChar('https://chrome.google.com/webstore/detail/advanced-rest-client/hgmloofddffdnphfgcellkdfbfbjeloo'),nil,nil,SW_NORMAL)
end;

procedure TfrModWebAPIConfig.btnShowLogClick(Sender: TObject);
begin
  inherited;
  ShowLog;
end;

procedure TfrModWebAPIConfig.btnTestClick(Sender: TObject);
var
  form: TfmWebApiTestSteps;
begin
  inherited;
  form := TfmWebApiTestSteps.Create(Application);
  form.ERPServer := Self.UtilsClient.Client.ServerName; //   TModuleWebAPIGui(Module).ServerConfig.S['Server'];
  //form.ShowPublicIP:= false;
  form.PublicIP := '';
  form.Show;
end;

procedure TfrModWebAPIConfig.chkActiveClick(Sender: TObject);
var
  msg: string;
begin
  inherited;
  if Loading then exit;

  if TwwCheckBox(Sender).Checked then begin
    if not UtilsClient.LicenceOptionEnabled('ERPApi') then begin
      TwwCheckBox(Sender).Checked := false;
      DialogLicenceOptionNotEnabled;
    end;
  end;

  if not self.SetModuleProperty('Active',chkActive.Checked,msg) then
    Vista_MessageDlg.MessageDlgXP_Vista('Could not set "Api Server Active" property on server, received error: ' + msg, mtInformation,[mbOk],0);
  self.GetModuleConfig;
end;

procedure TfrModWebAPIConfig.chkUseSSLClick(Sender: TObject);
var
  msg: string;
begin
  inherited;
  if Loading then exit;
  //Config.B['UseSSL'] := chkUseSSL.Checked;
  TellUserToRestart;
  //VerifyAndSetModuleConfig;
  if not self.SetModuleProperty('UseSSL',chkUseSSL.Checked,msg) then
    Vista_MessageDlg.MessageDlgXP_Vista('Could not set "Use SSL" property on server, received error: ' + msg, mtInformation,[mbOk],0);
  self.GetModuleConfig;
end;

constructor TfrModWebAPIConfig.Create(aOwner: TComponent);
begin
  inherited;
  lblRestartMessage.Caption := '';
end;

procedure TfrModWebAPIConfig.edtMaxConnectionsExit(Sender: TObject);
var
  msg: string;
begin
  inherited;
  if Loading then exit;
  if not self.SetModuleProperty('MaxConnections',edtMaxConnections.IntValue,msg) then
    Vista_MessageDlg.MessageDlgXP_Vista('Could not set "Max Connections" property on server, received error: ' + msg, mtInformation,[mbOk],0);
  self.GetModuleConfig;
end;

procedure TfrModWebAPIConfig.edtServerPortExit(Sender: TObject);
var
  msg: string;
begin
  inherited;
  if Loading then exit;
  TellUserToRestart;
  if not self.SetModuleProperty('DefaultPort',edtServerPort.IntValue,msg) then
    Vista_MessageDlg.MessageDlgXP_Vista('Could not set "Server Port" property on server, received error: ' + msg, mtInformation,[mbOk],0);
  self.GetModuleConfig;
end;

procedure TfrModWebAPIConfig.edtServerSSLPortExit(Sender: TObject);
var
  msg: string;
begin
  inherited;
  if Loading then exit;
  TellUserToRestart;
  if not self.SetModuleProperty('DefaultSSLPort',edtServerSSLPort.IntValue,msg) then
    Vista_MessageDlg.MessageDlgXP_Vista('Could not set "Server SSL Port" property on server, received error: ' + msg, mtInformation,[mbOk],0);
  self.GetModuleConfig;
end;

procedure TfrModWebAPIConfig.edtWebUserNameExit(Sender: TObject);
var
  msg: string;
begin
  inherited;
  if Loading then exit;
  if Config.S['WebUserName'] <> edtWebUserName.Text then begin
    //Config.S['WebUserName'] := edtWebUserName.Text;
    //VerifyAndSetModuleConfig;
    if not self.SetModuleProperty('WebUserName',edtWebUserName.Text,msg) then
      Vista_MessageDlg.MessageDlgXP_Vista('Could not set "Web User Name" property on server, received error: ' + msg, mtInformation,[mbOk],0);
    self.GetModuleConfig;
  end;
end;

function TfrModWebAPIConfig.GetModuleName: string;
begin
  Result := 'ERPWebService';
end;

procedure TfrModWebAPIConfig.rgLoggingLevelClick(Sender: TObject);
begin
  inherited;
  if Loading then exit;
  Config.S['LoggingLevel'] := LoggingLevelToStr(TLoggingLevel(rgLoggingLevel.ItemIndex));
  VerifyAndSetModuleConfig;
end;

procedure TfrModWebAPIConfig.TellUserToRestart;
begin
  lblRestartMessage.Caption := 'You have changed your Port and/ or SSL settings, ' +
  'please restart your ERP Utilities Service in Windows Control Panel for these changes to take effect.';
end;

end.
