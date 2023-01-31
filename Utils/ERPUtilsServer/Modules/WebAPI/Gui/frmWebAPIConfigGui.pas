unit frmWebAPIConfigGui;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmModuleConfigBase, Buttons, StdCtrls, Shader, DNMPanel, ExtCtrls,
  ModuleBaseClientObj, AdvPageControl, ComCtrls, DNMSpeedButton, AdvEdit,
  DBAdvEd;

type
  TfmWebAPIConfigGui = class(TfmModuleConfigBase)
    pcWebAPI: TAdvPageControl;
    AdvTabSheet1: TAdvTabSheet;
    tabLog: TAdvTabSheet;
    memLog: TMemo;
    btnStart: TDNMSpeedButton;
    btnStop: TDNMSpeedButton;
    Label1: TLabel;
    cboLoggingLevel: TComboBox;
    edtWebUserName: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtMaxConnections: TDBAdvEdit;
    sbStatus: TStatusBar;
    Label4: TLabel;
    edtServerPort: TDBAdvEdit;
    edtServerSSLPort: TDBAdvEdit;
    Label5: TLabel;
    Label6: TLabel;
    chkUseSSL: TCheckBox;
    Label7: TLabel;
    btnTest: TDNMSpeedButton;
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure cboLoggingLevelChange(Sender: TObject);
    procedure edtWebUserNameExit(Sender: TObject);
    procedure edtMaxConnectionsExit(Sender: TObject);
    procedure edtServerPortExit(Sender: TObject);
    procedure edtServerSSLPortExit(Sender: TObject);
    procedure chkUseSSLClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
  private
  protected
//    procedure SetModule(const Value: TModuleBaseClient); override;
  public
    procedure Log(msg: string);
    procedure DoOnModuleChange; override;
  end;

var
  fmWebAPIConfigGui: TfmWebAPIConfigGui;

implementation

uses
  ModuleWebAPIGuiObj, LogMessageTypes, frmWebAPITestSteps;

{$R *.dfm}

{ TfmModuleConfigBase1 }

//procedure TfmModuleConfigBase1.SetModule(const Value: TModuleBaseClient);
//begin
//  inherited;
//
//end;

{ TfmWebAPIConfigGui }

procedure TfmWebAPIConfigGui.btnStartClick(Sender: TObject);
begin
  inherited;
  TModuleWebAPIGui(Module).HTTPServerConfig.Active:= true;
end;

procedure TfmWebAPIConfigGui.btnStopClick(Sender: TObject);
begin
  inherited;
  TModuleWebAPIGui(Module).HTTPServerConfig.Active:= false;
end;

procedure TfmWebAPIConfigGui.btnTestClick(Sender: TObject);
var
  form: TfmWebApiTestSteps;
begin
  inherited;
  form := TfmWebApiTestSteps.Create(Application);
  form.ERPServer := TModuleWebAPIGui(Module).ServerConfig.S['Server'];
  //form.ShowPublicIP:= false;
  form.PublicIP := '';
  form.Show;

end;

procedure TfmWebAPIConfigGui.cboLoggingLevelChange(Sender: TObject);
begin
  TModuleWebAPIGui(Module).HTTPServerConfig.LoggingLevel:=
    TLoggingLevel(cboLoggingLevel.ItemIndex);
end;

procedure TfmWebAPIConfigGui.chkUseSSLClick(Sender: TObject);
begin
  TModuleWebAPIGui(Module).HTTPServerConfig.UseSSL:= chkUseSSL.Checked;
end;

procedure TfmWebAPIConfigGui.DoOnModuleChange;
begin
  inherited;
  btnStart.Enabled:= not TModuleWebAPIGui(Module).HTTPServerConfig.Active;
  btnStop.Enabled:= TModuleWebAPIGui(Module).HTTPServerConfig.Active;
  if TModuleWebAPIGui(Module).HTTPServerConfig.Active then
    sbStatus.Panels[0].Text:= ' Active'
  else
    sbStatus.Panels[0].Text:= ' Inactive';

  cboLoggingLevel.ItemIndex:= Integer(TModuleWebAPIGui(Module).HTTPServerConfig.LoggingLevel);
  edtWebUserName.Text:= TModuleWebAPIGui(Module).HTTPServerConfig.WebUserName;
  edtMaxConnections.IntValue:= TModuleWebAPIGui(Module).HTTPServerConfig.MaxConnections;
  edtServerPort.IntValue:= TModuleWebAPIGui(Module).HTTPServerConfig.DefaultPort;
  edtServerSSLPort.IntValue:= TModuleWebAPIGui(Module).HTTPServerConfig.DefaultSSLPort;
  chkUseSSL.Checked:= TModuleWebAPIGui(Module).HTTPServerConfig.UseSSL;
end;

procedure TfmWebAPIConfigGui.edtMaxConnectionsExit(Sender: TObject);
begin
  TModuleWebAPIGui(Module).HTTPServerConfig.MaxConnections:= edtMaxConnections.IntValue;
end;

procedure TfmWebAPIConfigGui.edtServerPortExit(Sender: TObject);
begin
  TModuleWebAPIGui(Module).HTTPServerConfig.DefaultPort:= edtServerPort.IntValue;
end;

procedure TfmWebAPIConfigGui.edtServerSSLPortExit(Sender: TObject);
begin
  TModuleWebAPIGui(Module).HTTPServerConfig.DefaultSSLPort:= edtServerSSLPort.IntValue;
end;

procedure TfmWebAPIConfigGui.edtWebUserNameExit(Sender: TObject);
begin
  TModuleWebAPIGui(Module).HTTPServerConfig.WebUserName:= edtWebUserName.Text;
end;

procedure TfmWebAPIConfigGui.Log(msg: string);
begin
  while memLog.Lines.Count > 1000 do
    memLog.Lines.Delete(0);
  memLog.Lines.Add(msg);
end;

end.
