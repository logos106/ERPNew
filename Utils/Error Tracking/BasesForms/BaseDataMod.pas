unit BaseDataMod;

interface

uses
  SysUtils, Classes, DB, MemDS, DBAccess, MyAccess, ppEndUsr, ppBands,
  ppCache, ppClass, ppProd, ppReport, ppComm, ppRelatv, ppDB, ppDBPipe,
  ImgList, Controls ,MyClasses,ShellAPI,Windows, {TrayNotifyIcon,} Menus,
  ExtCtrls, AdvMenus, AdvMenuStylers, ppParameter;
type
  TBaseDataModule = class(TDataModule)
    imgPopup: TImageList;
    DBPipeline: TppDBPipeline;
    ppReport: TppReport;
    ppDesigner: TppDesigner;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    DSReport: TDataSource;
    DBPipeline1: TppDBPipeline;
    DSReport1: TDataSource;
    DBPipeline2: TppDBPipeline;
    DSReport2: TDataSource;
    DBPipeline3: TppDBPipeline;
    DSReport3: TDataSource;
    NonTransDBConnection: TMyConnection;
    qryReports: TMyQuery;
    PopupMenuTray: TAdvPopupMenu;
    btnOpen: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    AdvMenuFantasyStyler: TAdvMenuFantasyStyler;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure ppReportPageRequest(Sender, aPageRequest: TObject);
  private
    fsDBName:String;
    fsServer:String;
    fsAutoLoginUser:String;
    fsAutoLoginPassword:String;
    procedure TrayIconHide;
    procedure GetServerINI;
    Function GetDbVersion:String;
    procedure TrayIconDblClick(Sender: TObject);
    procedure CheckEmailsOnTimer(Sender: TObject);
  public
    procedure TrayIconShow;
    procedure StartCheckEmailTimer;
    Property AutoLogin_User :String read fsAutoLoginUser;
    Property AutoLogin_Password :String read fsAutoLoginPassword;
  end;

var
  BaseDataModule: TBaseDataModule;
  CheckEmailsTimer: TTimer;

Const
  Database='errormanagement';
  Password='1w$p&LD07';
  Username='P_One';
  ServerINIFile='Server.ini';
  UserVersion = '1.0.0.0';
  Port = 3306;


implementation

Uses Forms,IniFiles,Dialogs, ExceptionEmailsLib,UserInfoObj, FastFuncs;

{$R *.dfm}

var
  TrayIcon: TTrayNotifyIcon;

procedure TBaseDataModule.DataModuleCreate(Sender: TObject);
Var
  DBVersion: String;
begin
  GetServerINI;
// DB Settings
  fsDBName := Database;
  NonTransDBConnection.Disconnect;
  NonTransDBConnection.LoginPrompt := False;
  NonTransDBConnection.Database := fsDBName;
  NonTransDBConnection.Username := Username;
  NonTransDBConnection.Password := Password;
  NonTransDBConnection.Port := Port;
  NonTransDBConnection.Server := fsServer;
  NonTransDBConnection.Options.Compress := False;
  NonTransDBConnection.Options.Protocol := mpDefault;
  NonTransDBConnection.Connect;

  DBVersion := GetDbVersion;
  If not FastFuncs.SameText(DBVersion,UserVersion) then Begin
     MessageDlg(''+#13+#10+'Error Tracking v'+DBVersion+' Required.', mtError, [mbOK], 0);
     Application.Terminate;
  end;
end;

function TBaseDataModule.GetDbVersion: String;
var
  TempQry: TMyQuery;
Begin
  Result := '';
  TempQry := TMyQuery.Create(nil);
  try
    TempQry.Options.FlatBuffers := True;
    TempQry.Connection := NonTransDBConnection;
    TempQry.SQL.Clear;
    TempQry.SQL.Add('SELECT id,version FROM dbversion WHERE ID = 1;');
    TempQry.Open;
    If (TempQry.RecordCount>0) Then Begin
      Result := FastFuncs.Trim(TempQry.FieldByName('Version').asString);
    end;
   finally
    TempQry.Free;
  end;
end;

procedure TBaseDataModule.DataModuleDestroy(Sender: TObject);
begin
  NonTransDBConnection.Disconnect;
  If Assigned(CheckEmailsTimer) then CheckEmailsTimer.Enabled := False;
end;

procedure TBaseDataModule.GetServerINI;
begin
  if FileExists(ServerINIFile) then
    begin
    with TMemIniFile.Create(ServerINIFile) do
      try
        fsServer := ReadString('DevMServer', 'Server', '');
        fsAutoLoginUser := ReadString('AutoLogin', 'User', '');
        fsAutoLoginPassword := ReadString('AutoLogin', 'Password', '');
      finally
        Free;
      end;
    end
  else
    raise Exception.Create(Format('INI file %s not found', [ServerINIFile]));
end;

procedure TBaseDataModule.ppReportPageRequest(Sender, aPageRequest: TObject);
begin
  If Assigned(ppReport.PreviewForm) then begin
    ppReport.PreviewForm.WindowState := wsMaximized;
  end;
end;

procedure TBaseDataModule.TrayIconDblClick(Sender: TObject);
begin
  TrayIconHide;
end;

procedure TBaseDataModule.TrayIconShow;
begin
  with TrayIcon do begin
    Icon.Assign(Application.Icon);
    OnDblClick := TrayIconDblClick;
    TrayIcon.PopupMenu := PopupMenuTray;
    Hint  := Application.MainForm.Caption;
    IconVisible := True;
  end;
  Application.Minimize;
  Application.MainForm.Hide;
  ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TBaseDataModule.TrayIconHide;
begin
  Application.MainForm.Show;
  ShowWindow(Application.Handle, SW_SHOW);
  with TrayIcon do begin
    OnDblClick := nil;
    TrayIcon.PopupMenu := nil;
    IconVisible := False;
  end;
end;

procedure TBaseDataModule.Exit1Click(Sender: TObject);
begin
 Application.Terminate;
end;

procedure TBaseDataModule.btnOpenClick(Sender: TObject);
begin
  TrayIconHide;
end;

procedure TBaseDataModule.StartCheckEmailTimer;
begin
  If Assigned(UserInfo) AND (not UserInfo.CheckExceptionEmails) then Begin
    Exit;
  end;
  If not Assigned(CheckEmailsTimer) then begin
    CheckEmailsTimer := TTimer.Create(Self);
  end;

  CheckEmailsTimer.Enabled := False;
  CheckEmailsTimer.OnTimer := CheckEmailsOnTimer;
  CheckEmailsTimer.Interval := 15000; // 15 sec
  CheckEmailsTimer.Enabled := True;

end;

procedure TBaseDataModule.CheckEmailsOnTimer(Sender: TObject);
begin
  CheckEmailsTimer.Enabled := False;
  try
    Try
      ExceptionEmailsLib.ImportExceptionEmails;
    Except
    end;
  finally
    CheckEmailsTimer.Interval := 60000; // 1 min
    CheckEmailsTimer.Enabled := True;
  end;
end;

initialization
  BaseDataModule := TBaseDataModule.Create(Application);
  TrayIcon := TTrayNotifyIcon.Create(nil);
finalization
  TrayIcon.IconVisible := False;
  FreeAndNil(TrayIcon);
end.
