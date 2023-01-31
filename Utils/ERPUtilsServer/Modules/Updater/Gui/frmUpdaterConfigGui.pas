unit frmUpdaterConfigGui;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmModuleConfigBase, Buttons, StdCtrls, Shader, DNMPanel,
  ExtCtrls, VirtualTrees, DNMSpeedButton, AdvPageControl, ComCtrls;

type
  TfmUpdaterConfigGui = class(TfmModuleConfigBase)
    pcMultisite: TAdvPageControl;
    tabConfig: TAdvTabSheet;
    Label1: TLabel;
    btnStart: TDNMSpeedButton;
    btnStop: TDNMSpeedButton;
    cboLoggingLevel: TComboBox;
    tabLog: TAdvTabSheet;
    memLog: TMemo;
    sbStatus: TStatusBar;
    tabUpdates: TAdvTabSheet;
    memConfig: TMemo;
    procedure cboLoggingLevelChange(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
  private
    { Private declarations }
  protected
  public
    procedure Log(msg: string);
    procedure DoOnModuleChange; override;
  end;

var
  fmUpdaterConfigGui: TfmUpdaterConfigGui;

implementation

{$R *.dfm}

uses
  ModuleUpdaterGuiObj, ModuleConst, LogMessageTypes;

{ TfmUpdaterConfigGui }

procedure TfmUpdaterConfigGui.DoOnModuleChange;
begin
  inherited;
  btnStart.Enabled:= not TModuleUpdaterGui(Module).Active;
  btnStop.Enabled:= TModuleUpdaterGui(Module).Active;
  if TModuleUpdaterGui(Module).Active then
    sbStatus.Panels[0].Text:= ' Active'
  else
    sbStatus.Panels[0].Text:= ' Inactive';

  cboLoggingLevel.ItemIndex:= Integer(TModuleUpdaterGui(Module).LoggingLevel);
  memConfig.Lines.Text:= TModuleUpdaterGui(Module).Config.O['settings'].AsString;
end;

procedure TfmUpdaterConfigGui.Log(msg: string);
begin
  while memLog.Lines.Count > 1000 do
    memLog.Lines.Delete(0);
  memLog.Lines.Add(msg);
end;

procedure TfmUpdaterConfigGui.cboLoggingLevelChange(Sender: TObject);
begin
  TModuleUpdaterGui(Module).LoggingLevel:=
    TLoggingLevel(cboLoggingLevel.ItemIndex);
end;

procedure TfmUpdaterConfigGui.btnStartClick(Sender: TObject);
begin
  TModuleUpdaterGui(Module).Active:= true;
end;

procedure TfmUpdaterConfigGui.btnStopClick(Sender: TObject);
begin
  TModuleUpdaterGui(Module).Active:= false;
end;

end.
