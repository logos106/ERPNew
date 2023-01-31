unit EmailFaxServerUnit;

interface

uses
  Types,Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  ExtCtrls, MyAccess, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP,
  AdvMenus, AdvMenuStylers, Menus, ImgList, CoolTrayIcon, LogLib,
  INIFileObj;

type
  TEmailFaxServer = class(TService)
    Timer: TTimer;
    IconImages: TImageList;
    PopupMenu: TAdvPopupMenu;
    mnuSendNow: TMenuItem;
    mnuSpace: TMenuItem;
    mnuViewLog: TMenuItem;
    N1: TMenuItem;
    mnuStopService: TMenuItem;
    PopupMenuStyler: TAdvMenuOfficeStyler;
    N2: TMenuItem;
    mnuSettings: TMenuItem;
    procedure ServiceAfterInstall(Sender: TService);
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceExecute(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure TimerTimer(Sender: TObject);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure mnuSendNowClick(Sender: TObject);
    procedure ServiceDestroy(Sender: TObject);
    procedure mnuStopServiceClick(Sender: TObject);
    procedure mnuViewLogClick(Sender: TObject);
    procedure ServiceAfterUninstall(Sender: TService);
    procedure ServiceBeforeInstall(Sender: TService);
    procedure ServiceBeforeUninstall(Sender: TService);
    procedure mnuSettingsClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetServiceFailureActions;
    procedure SetServiceDescription;
  public
    { Public declarations }
    SendRunning:Boolean;
    TrayImages: TImageList;
    INI_Options: TinifileObj;
    function GetServiceController: TServiceController; override;
  end;

var
  EmailFaxServer: TEmailFaxServer;
  TrayIcon : TCoolTrayIcon;
  LogsLib :TLogLib;  

implementation

Uses IniFiles, WinSvc, EmailFaxServerLib, SendEmailsThread, SendFaxesThread,
  Vista_MessageDlg, LogGUI, Forms, ExcMagic, ConfigGUI, FastFuncs;

 {$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  EmailFaxServer.Controller(CtrlCode);
end;

function TEmailFaxServer.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TEmailFaxServer.ServiceAfterInstall(Sender: TService);
begin
  SetServiceDescription;
  ExcMagic.ExceptionHook.LogEnabled := True;  
end;

procedure TEmailFaxServer.ServiceCreate(Sender: TObject);
begin
  Application.Title := 'Email Fax Server';
end;

procedure TEmailFaxServer.ServiceExecute(Sender: TService);
begin
  While Assigned(Config) do begin
    Forms.Application.ProcessMessages;
    Sleep(10);
  end;
  while not Terminated do begin
    EmailFaxServer.ServiceThread.ProcessRequests(false);
    Sleep(1000);
  end;
end;

procedure TEmailFaxServer.ServiceStart(Sender: TService; var Started: Boolean);
begin
  SetServiceFailureActions;
  TrayImages := IconImages;
  Timer.Enabled := false;
  TrayIcon.PopupMenu := PopupMenu;
  TrayIcon.IconList := TrayImages;
  TrayIcon.IconIndex := 0;
  TrayIcon.Hint := 'Email Fax Server';
  TrayIcon.Behavior := bhWin2000;
  TrayIcon.IconVisible := True;
  INI_Options := TinifileObj.Create(Self);
  RefreshMemoryUsage;
  Timer.Interval := 60000;
  Timer.Enabled := True;
  LogsLib.AddLogBoth('Email Fax Server Started');  
end;

procedure TEmailFaxServer.SetServiceDescription;
const
  AdvApiDLL   = 'advapi32.dll';
  SERVICE_CONFIG_DESCRIPTION = 1;
  Description = 'Email Fax Server';
type
  TChangeServiceConfig2 = function(hService: SC_HANDLE; dwInfoLevel: DWORD; lpInfo: Pointer): BOOL;
  stdcall;
  TServiceDescription = record
    lpDescription: string;
  end;
var
  SvcMgr: integer;
  Svc: integer;
  ServiceDescription: TServiceDescription;
  hLibModule: THandle;
  ChangeServiceConfig2: TChangeServiceConfig2;
  lpServiceArgVectors: LPCTSTR;
begin
  SvcMgr := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  if (Win32MajorVersion > 4) and (Win32Platform = VER_PLATFORM_WIN32_NT) then begin
    hLibModule := GetModuleHandle(PChar(advapi32));
    if hLibModule <> 0 then begin
      Svc := OpenService(SvcMgr, PChar(Self.Name), SERVICE_ALL_ACCESS);
      try
        if not WinSvc.StartService(Svc, 0, lpServiceArgVectors) then
          RaiseLastOSError;
        @ChangeServiceConfig2 := GetProcAddress(hLibModule, 'ChangeServiceConfig2A');
        if @ChangeServiceConfig2 <> nil then begin
          ServiceDescription.lpDescription := PChar(Description);
          ChangeServiceConfig2(Svc, SERVICE_CONFIG_DESCRIPTION, @ServiceDescription);
        end;
      finally
        CloseServiceHandle(Svc);
      end;
    end;
  end;
end;

procedure TEmailFaxServer.SetServiceFailureActions;
var
  SA: SC_ACTION;
  SFA: SERVICE_FAILURE_ACTIONS;
  SvcMgr: integer;
  Svc: integer;
  hLibModule: THandle;
  ChangeServiceConfig2: TChangeServiceConfig2;
begin
  SvcMgr := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  if (Win32MajorVersion > 4) and (Win32Platform = VER_PLATFORM_WIN32_NT) then begin
    hLibModule := GetModuleHandle(PChar(advapi32));
    if hLibModule <> 0 then begin
      Svc := OpenService(SvcMgr, PChar(Self.Name), SERVICE_ALL_ACCESS);
      try @ChangeServiceConfig2 := GetProcAddress(hLibModule, 'ChangeServiceConfig2A');
        if @ChangeServiceConfig2 <> nil then begin
          SA.aType := SC_ACTION_RESTART;
          SA.Delay := 0;
          SFA.dwResetPeriod := 0;
          SFA.lpRebootMsg := nil;
          SFA.lpCommand := nil;
          SFA.cActions := 1;
          SFA.lpsaActions := @SA;
          SFA.lpsaActions.aType := SC_ACTION_RESTART;
          SFA.lpsaActions.Delay := 0;
          ChangeServiceConfig2(Svc, SERVICE_CONFIG_FAILURE_ACTIONS, @SFA);
        end;
      finally
        CloseServiceHandle(Svc);
      end;
    end;
  end;
end;

procedure TEmailFaxServer.TimerTimer(Sender: TObject);
begin
  If SendRunning then Exit;
  Timer.Enabled := False;
  Try
     If Assigned(TrayIcon.PopupMenu) then Begin
          If mnuSendNow.Enabled then mnuSendNow.Click;
     end;
  finally
    Timer.Enabled := True;
  end;
end;

procedure TEmailFaxServer.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  Timer.Enabled := false;
end;

procedure TEmailFaxServer.mnuSendNowClick(Sender: TObject);
var
  SendEmailProcess: TSendEmailsThread;
  SendFaxProcess: TSendFaxesThread;
  DBConnection: TMyConnection;
  DBList,TblList :TStringList;
  CheckTbl,I :Integer;
begin
  If Assigned(Config) then Exit;
  Timer.Enabled := False;
  SendRunning := True;

  TrayIcon.IconVisible := False;
  TrayImages := IconImages;
  TrayIcon.IconList := TrayImages;
  TrayIcon.CycleInterval := 150;
  TrayIcon.CycleIcons := True;
  TrayIcon.IconVisible := True;
  mnuSendNow.Enabled := False;
  mnuSettings.Enabled := False;
  mnuStopService.Enabled := False;

  DBList := TStringList.Create;
  TblList := TStringList.Create;
  DBConnection := CreateDBConnection(Self, '');
  Try
    if not Assigned(DBConnection) then Begin
      LogsLib.AddLogBoth('Mysql Server Not Found on "'+INI_Options.MySQLServer+'" !');
      Exit;
    end;
    LogsLib.AddLogBoth('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
    DBConnection.GetDatabaseNames(DBList);
    If (INI_Options.Mode = 'Email') OR (INI_Options.Mode = 'Both') then LogsLib.AddLogBoth('# Process Emails #');
    for I := 0 to DBList.Count-1 do Begin
      DBConnection.Disconnect;
      DBConnection.Database := Trim(DBList[I]);
      If FastFuncs.SameText(DBConnection.Database,'erpnewdb') Then Continue;
      DBConnection.Connect;
      TblList.Clear;
      DBConnection.GetTableNames(TblList);
      If (INI_Options.Mode = 'Email') OR (INI_Options.Mode = 'Both') then Begin
        // Create Send Email Thread For Each Db
        If TblList.Find('tblemailqueue',CheckTbl) then begin
          SendEmailProcess := TSendEmailsThread.Create(True);
          Try
            SendEmailProcess.Priority := tpNormal;
            SendEmailProcess.Database := DBConnection.Database;
            LogsLib.AddLogBoth('Begin Email Send on Database - '+DBConnection.Database);
            SendEmailProcess.Resume;
            SendEmailProcess.WaitFor;
            LogsLib.AddLogBoth('Completed Email Send on Database - '+DBConnection.Database);
          Finally
            SysUtils.FreeAndNil(SendEmailProcess);
          end;
        end;
      end;
    end;
    If (INI_Options.Mode = 'Fax') OR (INI_Options.Mode = 'Both') then LogsLib.AddLogBoth('# Process Faxes #');
    for I := 0 to DBList.Count-1 do Begin
      DBConnection.Disconnect;
      DBConnection.Database := Trim(DBList[I]);
      If FastFuncs.SameText(DBConnection.Database,'erpnewdb') Then Continue;
      DBConnection.Connect;
      TblList.Clear;
      DBConnection.GetTableNames(TblList);
      If (INI_Options.Mode = 'Fax') OR (INI_Options.Mode = 'Both') then Begin
        //Create Send Fax Thread For Each Db
        If TblList.Find('tblfaxspool',CheckTbl) then begin
          SendFaxProcess := TSendFaxesThread.Create(True);
          Try
            SendFaxProcess.Priority := tpNormal;
            SendFaxProcess.Database := DBConnection.Database;
            LogsLib.AddLogBoth('Begin Fax Send on Database - '+DBConnection.Database);
            SendFaxProcess.Resume;
            SendFaxProcess.WaitFor;
            LogsLib.AddLogBoth('Completed Fax Send on Database - '+DBConnection.Database);
          Finally
            SysUtils.FreeAndNil(SendFaxProcess);
          end;
        end;          
      end;
    end;
  Finally
    If Assigned(DBConnection) then begin
      DBConnection.Disconnect;
      FreeAndNil(DBConnection);
    end;      
    FreeAndNil(DBList);
    FreeAndNil(TblList);
    TrayIcon.IconVisible := False;
    TrayIcon.CycleIcons := False;
    TrayIcon.IconList := EmailFaxServer.TrayImages;
    TrayIcon.IconIndex := 0;
    TrayIcon.IconVisible := True;
    EmailFaxServer.SendRunning := False;
    EmailFaxServer.mnuSettings.Enabled := True;
    EmailFaxServer.mnuSendNow.Enabled := True;
    EmailFaxServer.mnuStopService.Enabled := True;
    Timer.Enabled := True;    
    RefreshMemoryUsage;
  end;
end;

procedure TEmailFaxServer.ServiceDestroy(Sender: TObject);
begin
  LogsLib.AddLogBoth('Email Fax Server Stopped');
  If Assigned(TrayIcon) then TrayIcon.IconVisible := False;
  FreeAndNil(INI_Options);  
end;

procedure TEmailFaxServer.mnuStopServiceClick(Sender: TObject);
begin
  If Vista_MessageDlg.MessageDlgXP_Vista('Stop Email Fax Server ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    Self.ServiceThread.Terminate;
end;

procedure TEmailFaxServer.mnuViewLogClick(Sender: TObject);
begin
  If not Assigned(LogView) then
    LogView := TLogView.Create(self);
  LogView.WindowState := wsNormal;
  LogView.Show;
end;

procedure TEmailFaxServer.ServiceAfterUninstall(Sender: TService);
begin
  ExcMagic.ExceptionHook.LogEnabled := True;
end;

procedure TEmailFaxServer.ServiceBeforeInstall(Sender: TService);
begin
  ExcMagic.ExceptionHook.LogEnabled := False;
end;

procedure TEmailFaxServer.ServiceBeforeUninstall(Sender: TService);
begin
  ExcMagic.ExceptionHook.LogEnabled := False;
end;

procedure TEmailFaxServer.mnuSettingsClick(Sender: TObject);
begin
  Config := TConfig.Create(self);
  Config.Show;
end;

initialization
  TrayIcon := TCoolTrayIcon.Create(nil);
  LogsLib := TLogLib.Create(nil);
finalization
  FreeAndNil(LogsLib);
  FreeAndNil(TrayIcon);
end.

