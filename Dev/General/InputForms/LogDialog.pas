unit LogDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, Menus, ExtCtrls, StdCtrls, DNMSpeedButton, GuiPrefsObj;

type
  TLogDialogGUI = class(TfrmBaseGUI)
    memLog: TMemo;
    btnOK: TDNMSpeedButton;
    btnSaveAs: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    sdSaveMemo: TSaveDialog;
    btnClear: TDNMSpeedButton;
    procedure btnSaveAsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
    GuiPrefs: TFormGuiPrefs;
  public
    { Public declarations }
  end;

  procedure LogToDialog(aMsg: string; aCaption: string = 'Log');
  procedure CleanLog;
  procedure CloseLogToDialog;

implementation

var
  LogDialogGUI: TLogDialogGUI;
procedure CloseLogToDialog;
begin
  if Assigned(LogDialogGUI) then
    LogDialogGUI.Close;

end;
procedure CleanLog;
begin
  if not Assigned(LogDialogGUI) then begin
    LogDialogGUI := TLogDialogGUI.Create(Application.MainForm);
    LogDialogGUI.FormStyle := fsMDIChild;
    LogDialogGUI.BringToFront;
  end;
  LogDialogGUI.memLog.Lines.clear;
end;
procedure LogToDialog(aMsg: string; aCaption: string = 'Log');
begin
  if not Assigned(LogDialogGUI) then begin
    if aMsg = '' then
      exit;
    LogDialogGUI := TLogDialogGUI.Create(Application.MainForm);
    LogDialogGUI.FormStyle := fsMDIChild;
    LogDialogGUI.BringToFront;
  end;
  LogDialogGUI.Caption := aCaption;
  LogDialogGUI.memLog.Lines.Add(aMsg);
  Application.ProcessMessages;
end;

{$R *.dfm}

{ TLogDialogGUI }

procedure TLogDialogGUI.FormShow(Sender: TObject);
var
  x, y: integer;
begin
  inherited;
  if GuiPrefs.Node.Exists('Position.Left') then begin
    x := GuiPrefs.Node['Position.Left'].AsInteger;
    y := GuiPrefs.Node['Position.Top'].AsInteger;
    if y < 0 then
      y := 0;
    if y > (Screen.Height - 20) then
      y := (Screen.Height - 20);
    if x > Screen.Width then
      x := Screen.Width - 20;
    if x < -(self.Width -20) then
      x := 0;
    self.Top := y;
    self.Left := x;
    self.Width := GuiPrefs.Node['Position.Width'].AsInteger;
    self.Height := GuiPrefs.Node['Position.Height'].AsInteger;
  end
  else begin


  end;
end;


procedure TLogDialogGUI.btnClearClick(Sender: TObject);
begin
  inherited;
  memLog.Clear;
end;

procedure TLogDialogGUI.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TLogDialogGUI.btnSaveAsClick(Sender: TObject);
begin
  inherited;
  if sdSaveMemo.Execute then begin
    memLog.Lines.SaveToFile(sdSaveMemo.FileName);
  end;
end;

procedure TLogDialogGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  GuiPrefs.Node['Position.Left'].AsInteger := self.Left;
  GuiPrefs.Node['Position.Top'].AsInteger := self.Top;
  GuiPrefs.Node['Position.Width'].AsInteger := self.Width;
  GuiPrefs.Node['Position.Height'].AsInteger := self.Height;
  GuiPrefs.SavePrefs;
end;

procedure TLogDialogGUI.FormCreate(Sender: TObject);
begin
  inherited;
  // position
  GuiPrefs := TFormGuiPrefs.Create(self);
  GuiPrefs.Active := true;
end;

procedure TLogDialogGUI.FormDestroy(Sender: TObject);
begin
  inherited;
  LogDialogGUI := nil;
end;

end.
