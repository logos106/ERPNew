unit svcXMLServer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  datXMLServer, datSvcControlServer, ServiceGuiCommon;

type
  TXMLServer = class(TService)
    procedure ServiceDestroy(Sender: TObject);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceAfterInstall(Sender: TService);
    procedure ServiceExecute(Sender: TService);
    procedure ServiceBeforeInstall(Sender: TService);
    procedure ServiceBeforeUninstall(Sender: TService);
    procedure ServiceAfterUninstall(Sender: TService);
  private
    XMLServer: TdmXMLServer;
    GuiControl: TSvcControlServer;
    fServerControlPortParam: integer;
    procedure CreateServer;
    procedure DestryServer;
    procedure DoMultiEvent(Sender: TObject; const Event, Value : string);
    procedure SetServiceFailureActions;
    procedure SetServiceDescription;
    procedure DoReceiveMessage(msg: TRemoteMessageItem);
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  XMLServer: TXMLServer;

implementation

{$R *.DFM}

uses
  AppVarsObj, ExcMagic, WinSvc, ServiceCommon, LogThreadLib, LogMessageTypes,
  XMLServerControlConst;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  XMLServer.Controller(CtrlCode);
end;

procedure TXMLServer.ServiceDestroy(Sender: TObject);
begin
  DestryServer;
  inherited;
end;

function TXMLServer.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TXMLServer.ServiceStart(Sender: TService;
  var Started: Boolean);
begin
  TLogger.Inst.Log('TXMLServer.ServiceStart - Starting',ltDetail);
  SetServiceFailureActions;
  { user can optionally set control port on command line }
  if self.ParamCount > 1 then
    fServerControlPortParam:= StrToIntDef(self.Param[1] ,0)
  else
    fServerControlPortParam:= 0;
  CreateServer;
  if fServerControlPortParam > 0 then begin
    { use the port passed in from run parameter }
    GuiControl.Active:= false;
    GuiControl.Port:= fServerControlPortParam;
  end;
  GuiControl.Active:= true;
  XMLServer.Active:= true;
end;

procedure TXMLServer.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  TLogger.Inst.Log('TXMLServer.ServiceStop - Stopping',ltDetail);
  XMLServer.Active:= false;
end;

procedure TXMLServer.CreateServer;
begin

  if not Assigned(XMLServer) then begin
   { first sort out AppVars, shared by other units }
    AppVars:= TAppVars.Create;
    AppVars.EncryptFile:= true;
    AppVars.SaveOnChange:= true;
    AppVars.LoadFromFile();

    AppVars.SetDefault('ServerControlPort','9011');
    GuiControl:= TSvcControlServer.Create(nil);
    GuiControl.OnReceiveMessage:= self.DoReceiveMessage;

    AppVars.SetDefault('ServerPort','9009');
    XMLServer:= TdmXMLServer.Create(nil);
    GuiControl.ObjectToControl:= XMLServer;

    TLogger.Inst.Events.AddMultiEvent(DoMultiEvent);
    XMLServer.EventQueue.AddMultiEvent(DoMultiEvent);
  end;

end;

procedure TXMLServer.DestryServer;
begin
  if Assigned(XMLServer) then begin
    XMLServer.Active:= false;
    TLogger.Inst.Events.RemoveMultiEvent(DoMultiEvent);
    XMLServer.EventQueue.RemoveMultiEvent(DoMultiEvent);

    FreeAndNil(GuiControl);
    FreeAndNil(XMLServer);
    FreeAndNil(AppVars);
  end;  
end;

procedure TXMLServer.DoMultiEvent(Sender: TObject; const Event, Value: string);
var
  msg: TRemoteMessageItem;
begin
  msg:= TRemoteMessageItem.Create;
  msg.Direction:= mdOut;
  if sender is TLogger then begin
    msg.Values['command']:= CommandLog;
    msg.Values['value']:= Value;
  end
  else begin
    msg.Values['command']:= CommandEvent;
    msg.Values['event']:= Event;
    msg.Values['value']:= Value;
  end;
  GuiControl.SendMessage(msg);
end;

procedure TXMLServer.SetServiceDescription;
const
  AdvApiDLL   = 'advapi32.dll';
  SERVICE_CONFIG_DESCRIPTION = 1;
  Description = 'XML API Server';
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
        WinSvc.StartService(Svc, 0, lpServiceArgVectors);
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

procedure TXMLServer.SetServiceFailureActions;
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
      try
        @ChangeServiceConfig2 := GetProcAddress(hLibModule, 'ChangeServiceConfig2A');
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

procedure TXMLServer.ServiceAfterInstall(Sender: TService);
begin
  SetServiceDescription;
  ExcMagic.ExceptionHook.LogEnabled := True;
end;

procedure TXMLServer.DoReceiveMessage(msg: TRemoteMessageItem);
begin
  msg.Free;
end;

procedure TXMLServer.ServiceExecute(Sender: TService);
begin
  while not Terminated do begin
    ServiceThread.ProcessRequests(True);
  end;
end;

procedure TXMLServer.ServiceBeforeInstall(Sender: TService);
begin
  ExcMagic.ExceptionHook.LogEnabled := False;
end;

procedure TXMLServer.ServiceBeforeUninstall(Sender: TService);
begin
  ExcMagic.ExceptionHook.LogEnabled := False;
end;

procedure TXMLServer.ServiceAfterUninstall(Sender: TService);
begin
  ExcMagic.ExceptionHook.LogEnabled := True;
end;

end.
