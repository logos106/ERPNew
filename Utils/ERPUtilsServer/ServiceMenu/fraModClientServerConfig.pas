unit fraModClientServerConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fraUtilsConfigBase, StdCtrls, ExtCtrls, DNMSpeedButton,
  wwclearbuttongroup, wwradiogroup;

type
  TfrModClientServerConfig = class(TfrUtilsConfigBase)
    lblModuleName: TLabel;
    rgLoggingLevel: TwwRadioGroup;
    btnShowLog: TDNMSpeedButton;
    Bevel1: TBevel;
    Label2: TLabel;
    edtClientServerName: TEdit;
    Label6: TLabel;
    chkActive: TCheckBox;
    procedure rgLoggingLevelClick(Sender: TObject);
    procedure edtClientServerNameExit(Sender: TObject);
    procedure btnShowLogClick(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
  private
  protected
    function GetModuleName: string; override;
    procedure AfterGetModuleConfig; override;
  public
  end;

var
  frModClientServerConfig: TfrModClientServerConfig;

implementation

uses
  LogMessageTypes;

{$R *.dfm}

{ TfrModClientServerConfig }

procedure TfrModClientServerConfig.AfterGetModuleConfig;
begin
  inherited;
  rgLoggingLevel.ItemIndex := Ord(StrToLoggingLevel(Config.S['LoggingLevel']));
  edtClientServerName.Text := Config.S['ClientServerName'];
  chkActive.Checked := Config.B['Active'];
end;

procedure TfrModClientServerConfig.btnShowLogClick(Sender: TObject);
begin
  inherited;
  ShowLog;
end;

procedure TfrModClientServerConfig.chkActiveClick(Sender: TObject);
begin
  inherited;
  if Loading then exit;
  Config.B['Active'] := chkActive.Checked;
  VerifyAndSetModuleConfig;
end;

procedure TfrModClientServerConfig.edtClientServerNameExit(Sender: TObject);
begin
  inherited;
  if Loading then exit;
  if Config.S['ClientServerName'] <> edtClientServerName.Text then begin
    Config.S['ClientServerName'] := edtClientServerName.Text;
    VerifyAndSetModuleConfig;
  end;

end;

function TfrModClientServerConfig.GetModuleName: string;
begin
  result := 'ERPModClientServer';
end;

procedure TfrModClientServerConfig.rgLoggingLevelClick(Sender: TObject);
begin
  if Loading then exit;
  Config.S['LoggingLevel'] := LoggingLevelToStr(TLoggingLevel(rgLoggingLevel.ItemIndex));
  VerifyAndSetModuleConfig;
end;

end.
