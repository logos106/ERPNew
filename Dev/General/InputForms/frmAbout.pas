unit frmAbout;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, DNMSpeedButton, ExtCtrls, ShellAPI, DNMPanel, DB, wwcheckbox,  MemDS,
  DBAccess, MyAccess,ERPdbComponents, ComCtrls,AdvOfficeStatusBar, wwriched, AdvPicture,
  frmBase, Menus;
{$I ERP.inc}
type
  TAboutBox = class(TfrmBaseGUI)
    OKButton: TDNMSpeedButton;
    Label4: TLabel;
    RegToGo: TLabel;
    AdvPicture1: TAdvPicture;
    AdvPicture2: TAdvPicture;
    Label2: TLabel;
    lbUserTitle: TLabel;
    txtUsers: TLabel;
    Version: TLabel;
    txtClientVer: TLabel;
    Label1: TLabel;
    txtServerVer: TLabel;
    Label3: TLabel;
    txtMySqlServerVer: TLabel;
    procedure OKButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label3MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure Label4DblClick(Sender: TObject);
    procedure Label4MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
    procedure chkAutoUpdatesClick(Sender: TObject);
    procedure AdvPicture1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    LineToGoTo: integer;
    ServerVersion: string;
    ClientVersion: string;
    (*KeyPressed, KeyPressed2: boolean;*)
    procedure CenterForm;
  public
    { Public declarations }
  end;

implementation
   
uses FastFuncs,DnmLib,systemlib, DateUtils, MAIN,
     Messages, dmMainGUI, CommonLib,AppDatabase, AppEnvironment, FileVersion,
     ERPVersionConst;

{$R *.dfm}

procedure TAboutBox.OKButtonClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TAboutBox.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := cafree;
end;

procedure TAboutBox.FormCreate(Sender: TObject);
begin
  inherited;
  RegToGo.Visible := true;
  (*KeyPressed := false;*)
  ServerVersion := TABLE_VERSION;
  ClientVersion := GetFileVersion(Application.ExeName);

  If FileExists(ExeDir + 'Splash.jpg') then
    Self.AdvPicture2.Picture.LoadFromFile(ExeDir + 'Splash.jpg');
end;


procedure TAboutBox.FormShow(Sender: TObject);
var
  ConcurrentUsersStr: string;
begin
  inherited;
  ConcurrentUsersStr := '---';
  lbUserTitle.Caption := 'ServerID :';
//  txtUserID.Caption := MainForm.theServerID;

  with AppEnv.UtilsClient.GetLicense('ERP') do begin
    ConcurrentUsersStr:= IntToStr(I['ConcurrentUsers']);
    Free;
  end;

  RegToGo.Caption := IntToStr(DaysBetween(DateUTC, mainForm.theExpiryDate)) + ' Days Until Registration Expires (Max users: ' + ConcurrentUsersStr + ')';
  txtClientVer.Caption := ClientVersion;
  txtServerVer.Caption := ServerVersion;
  txtMySqlServerVer.Caption := GetMySqlServerVersion;
//  ScrollTimer.Enabled := true;
  LineToGoTo := 0;
end;

procedure TAboutBox.Label3MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
(*  if (Shift = [ssShift, ssAlt, ssCtrl, ssLeft]) then begin
    KeyPressed := true;
  end else begin
    KeyPressed := false;
  end;*)
end;

procedure TAboutBox.Label4DblClick(Sender: TObject);
begin
(*  if KeyPressed2 then begin
    dtmMainGUI.mnuRegister.Enabled := true;
    dtmMainGUI.mnuRegister.Visible := true;
    dtmMainGUI.n7.Visible := true;
    Self.Close;
  end;*)
end;

procedure TAboutBox.Label4MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
(*  if (Shift = [ssShift, ssCtrl, ssLeft]) then begin
    KeyPressed2 := true;
  end else begin
    KeyPressed2 := false;
  end;*)
end;

procedure TAboutBox.chkAutoUpdatesClick(Sender: TObject);
begin
  if not TwwCheckBox(Sender).DataSource.DataSet.Active then Exit;
  TwwCheckBox(Sender).DataSource.DataSet.Edit;
  if TwwCheckBox(Sender).Checked then TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsString :=
      'T'
  else TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsString := 'F';
end;

procedure TAboutBox.AdvPicture1Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'http://www.adobe.com/products/acrobat/readstep2.html', nil, nil, sw_shownormal);
end;

procedure TAboutBox.CenterForm;
var 
  comp: TComponent;
  StatusAndToolbarHeight, NewTop: integer;
begin
  StatusAndToolbarHeight := 0;
  comp := CommonLib.FindControlClass(Application.MainForm, 'TToolBar');
  if Assigned(comp) then
    StatusAndToolbarHeight := TToolBar(comp).Height;
  comp := CommonLib.FindControlClass(Application.MainForm, 'TAdvOfficeStatusBar');
  if Assigned(comp) then
    StatusAndToolbarHeight := StatusAndToolbarHeight + TAdvOfficeStatusBar(comp).Height;
  if (Self.FormStyle <> fsMDIChild) then begin
    NewTop := ((Application.MainForm.ClientHeight + StatusAndToolbarHeight) - Self.Height) div 2;
  end else begin
    NewTop := ((Application.MainForm.ClientHeight - StatusAndToolbarHeight) - Self.Height) div 2;
  end;
  if NewTop < 0 then
    NewTop := 0;
  Top          := NewTop;//Left := (MainForm.ClientWidth shr 1) - (Self.Width shr 1);
  Left         := ((Application.MainForm.ClientWidth - Self.Width) div 2);
  if Left < 0 then Left := 0;
end;

procedure TAboutBox.FormActivate(Sender: TObject);
begin
  CenterForm;
end;

initialization
  RegisterClassOnce(TAboutBox);
end.

