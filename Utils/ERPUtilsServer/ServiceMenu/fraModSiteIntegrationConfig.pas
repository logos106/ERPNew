unit fraModSiteIntegrationConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fraUtilsConfigBase, ExtCtrls, DNMSpeedButton, StdCtrls,
  wwclearbuttongroup, wwradiogroup;

type
  TfrModSiteIntegrationConfig = class(TfrUtilsConfigBase)
    Label9: TLabel;
    rgLoggingLevel: TwwRadioGroup;
    btnShowLog: TDNMSpeedButton;
    Bevel1: TBevel;
    Label6: TLabel;
    chkActive: TCheckBox;
    procedure rgLoggingLevelClick(Sender: TObject);
    procedure btnShowLogClick(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
  private
  protected
    function GetModuleName: string; override;
    procedure AfterGetModuleConfig; override;
  public
    { Public declarations }
  end;

var
  frModSiteIntegrationConfig: TfrModSiteIntegrationConfig;

implementation

{$R *.dfm}

uses
  LogMessageTypes;

{ TfrModSiteIntegrationConfig }

procedure TfrModSiteIntegrationConfig.AfterGetModuleConfig;
begin
  inherited;
  rgLoggingLevel.ItemIndex := Ord(StrToLoggingLevel(Config.S['LoggingLevel']));
  chkActive.Checked := Config.B['Active'];
end;

procedure TfrModSiteIntegrationConfig.btnShowLogClick(Sender: TObject);
begin
  inherited;
  ShowLog;
end;

procedure TfrModSiteIntegrationConfig.chkActiveClick(Sender: TObject);
begin
  inherited;
  if Loading then exit;
  Config.B['Active'] := chkActive.Checked;
  VerifyAndSetModuleConfig;
end;

function TfrModSiteIntegrationConfig.GetModuleName: string;
begin
  result := 'ERPModSiteIntegration';
end;

procedure TfrModSiteIntegrationConfig.rgLoggingLevelClick(Sender: TObject);
begin
  if Loading then exit;
  Config.S['LoggingLevel'] := LoggingLevelToStr(TLoggingLevel(rgLoggingLevel.ItemIndex));
  VerifyAndSetModuleConfig;
end;

end.
