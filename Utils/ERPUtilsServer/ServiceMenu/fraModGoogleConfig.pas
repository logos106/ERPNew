unit fraModGoogleConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fraUtilsConfigBase, ExtCtrls, DNMSpeedButton, StdCtrls,
  wwclearbuttongroup, wwradiogroup, wwcheckbox ;

type
  TfrModGoogleConfig = class(TfrUtilsConfigBase)
    Label9: TLabel;
    rgLoggingLevel: TwwRadioGroup;
    btnShowLog: TDNMSpeedButton;
    Bevel1: TBevel;
    chkActive: TwwCheckBox;
    procedure rgLoggingLevelClick(Sender: TObject);
    procedure btnShowLogClick(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
  private
  protected
    function GetModuleName: string; override;
    procedure AfterGetModuleConfig; override;
  public
  end;

var
  frModGoogleConfig: TfrModGoogleConfig;

implementation

{$R *.dfm}

uses
  LogMessageTypes, DialogUtils, Vista_MessageDlg;

{ TfrModGoogleConfig }

procedure TfrModGoogleConfig.AfterGetModuleConfig;
begin
  inherited;
  rgLoggingLevel.ItemIndex := Ord(StrToLoggingLevel(Config.S['LoggingLevel']));
  chkActive.Checked := Config.B['Active'];
end;

procedure TfrModGoogleConfig.btnShowLogClick(Sender: TObject);
begin
  inherited;
  ShowLog;
end;

procedure TfrModGoogleConfig.chkActiveClick(Sender: TObject);
var
  msg: string;
begin
  inherited;
  if Loading then exit;

  if TwwCheckBox(Sender).Checked then begin
    if not UtilsClient.LicenceOptionEnabled('Google') then begin
      TwwCheckBox(Sender).Checked := false;
      DialogLicenceOptionNotEnabled;
    end;
  end;

  if not self.SetModuleProperty('Active',chkActive.Checked,msg) then
    Vista_MessageDlg.MessageDlgXP_Vista('Could not set "Active" property on server, received error: ' + msg, mtInformation,[mbOk],0);
  self.GetModuleConfig;
end;

function TfrModGoogleConfig.GetModuleName: string;
begin
  result := 'ERPModGoogle';
end;

procedure TfrModGoogleConfig.rgLoggingLevelClick(Sender: TObject);
begin
  inherited;
  if Loading then exit;
  Config.S['LoggingLevel'] := LoggingLevelToStr(TLoggingLevel(rgLoggingLevel.ItemIndex));
  VerifyAndSetModuleConfig;
end;


end.
