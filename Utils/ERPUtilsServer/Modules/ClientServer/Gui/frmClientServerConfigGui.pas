unit frmClientServerConfigGui;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmModuleConfigBase, Buttons, StdCtrls, Shader, DNMPanel,
  ExtCtrls, DNMSpeedButton, AdvPageControl, ComCtrls, ModuleBaseClientObj;

type
  TfmClientServerConfigGui = class(TfmModuleConfigBase)
    pcMultisite: TAdvPageControl;
    tabConfig: TAdvTabSheet;
    Label1: TLabel;
    btnStart: TDNMSpeedButton;
    btnStop: TDNMSpeedButton;
    cboLoggingLevel: TComboBox;
    tabLog: TAdvTabSheet;
    memLog: TMemo;
    sbStatus: TStatusBar;
    edtERPServerName: TEdit;
    edtERPDatabaseName: TEdit;
    edtClientServerName: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure cboLoggingLevelChange(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure edtClientServerNameExit(Sender: TObject);
    procedure edtERPServerNameExit(Sender: TObject);
    procedure edtERPDatabaseNameExit(Sender: TObject);
  private
  protected
    procedure SetModule(const Value: TModuleBaseClient); override;
  public
    procedure Log(msg: string);
    procedure DoOnModuleChange; override;
  end;

var
  fmClientServerConfigGui: TfmClientServerConfigGui;

implementation

{$R *.dfm}

uses
  ModuleClientServerGuiObj, LogMessageTypes;

{ TfmClientServerConfigGui }

procedure TfmClientServerConfigGui.DoOnModuleChange;
begin
  inherited;
  btnStart.Enabled:= not TModuleClientServerGui(Module).Active;
  btnStop.Enabled:= TModuleClientServerGui(Module).Active;
  if TModuleClientServerGui(Module).Active then
    sbStatus.Panels[0].Text:= ' Active'
  else
    sbStatus.Panels[0].Text:= ' Inactive';

  cboLoggingLevel.ItemIndex:= Integer(TModuleClientServerGui(Module).LoggingLevel);
  edtClientServerName.Text:= TModuleClientServerGui(Module).ClientServerName;
//  edtERPServerName.Text:= TModuleClientServerGui(Module).ERPServerName;
//  edtERPDatabaseName.Text:= TModuleClientServerGui(Module).ERPDatabaseName;
end;

procedure TfmClientServerConfigGui.Log(msg: string);
begin
  while memLog.Lines.Count > 1000 do
    memLog.Lines.Delete(0);
  memLog.Lines.Add(msg);
end;

procedure TfmClientServerConfigGui.SetModule(
  const Value: TModuleBaseClient);
begin
  inherited;

end;

procedure TfmClientServerConfigGui.cboLoggingLevelChange(Sender: TObject);
begin
  inherited;
  TModuleClientServerGui(Module).LoggingLevel:=
    TLoggingLevel(cboLoggingLevel.ItemIndex);
end;

procedure TfmClientServerConfigGui.btnStartClick(Sender: TObject);
begin
  inherited;
  TModuleClientServerGui(Module).Active:= true;
end;

procedure TfmClientServerConfigGui.btnStopClick(Sender: TObject);
begin
  inherited;
  TModuleClientServerGui(Module).Active:= false;
end;

procedure TfmClientServerConfigGui.edtClientServerNameExit(
  Sender: TObject);
begin
  inherited;
  TModuleClientServerGui(Module).ClientServerName:= edtClientServerName.Text;
end;

procedure TfmClientServerConfigGui.edtERPServerNameExit(Sender: TObject);
begin
  inherited;
//  TModuleClientServerGui(Module).ERPServerName:= edtERPServerName.Text;
end;

procedure TfmClientServerConfigGui.edtERPDatabaseNameExit(Sender: TObject);
begin
  inherited;
//  TModuleClientServerGui(Module).ERPDatabaseName:= edtERPDatabaseName.Text;
end;

initialization
  RegisterClass(TfmClientServerConfigGui);


end.
