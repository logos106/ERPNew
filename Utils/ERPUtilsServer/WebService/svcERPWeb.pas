unit svcERPWeb;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  Sockets, Registry, IdBaseComponent, IdComponent, IdCustomTCPServer, Idcontext,
  IdCustomHTTPServer, IdHTTPServer, Sparky, LogThreadLib, LogMessageTypes, ServerModuleObj;

type
  TERPWeb = class(TService)
    procedure ServiceExecute(Sender: TService);
    procedure ServiceContinue(Sender: TService; var Continued: Boolean);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceAfterInstall(Sender: TService);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceDestroy(Sender: TObject);

  private
    MyThread: TSparky;

    fLogger: TLogger;
    ServerModule1: TServerModule;
    procedure Log(msg: string; msgType: TLogMessageType = ltDetail);

  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  ERPWeb: TERPWeb;

implementation

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  ERPWeb.Controller(CtrlCode);
end;

function TERPWeb.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TERPWeb.Log(msg: string; msgType: TLogMessageType = ltDetail);
begin
  if Assigned(Logger) then
    Logger.Log(msg, msgType);
end;

procedure TERPWeb.ServiceAfterInstall(Sender: TService);
var
   Reg: TRegistry; //declared in System.Win.Registry;
begin
  Reg := TRegistry.Create(KEY_READ or KEY_WRITE);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('\SYSTEM\CurrentControlSet\Services\' + name, False {do not create if not exists}) then
    begin
      Reg.WriteString('Description', 'ERP Web API Service');
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TERPWeb.ServiceCreate(Sender: TObject);
begin
  fLogger := TLogger.Create(nil);
  fLogger.LogAllTypes;
  Log(Self.DisplayName + ' Created');
end;

procedure TERPWeb.ServiceDestroy(Sender: TObject);
begin
  Log(Self.DisplayName + ' Destroyed');
  FreeAndNil(fLogger);
end;

procedure TERPWeb.ServiceExecute(Sender: TService);
begin
  while not Terminated do
  begin
    ServiceThread.ProcessRequests(False);
    TThread.Sleep(1000);
  end;
end;

procedure TERPWeb.ServiceStart(Sender: TService; var Started: Boolean);
begin
  Log(self.DisplayName + ' Starting');

  MyThread := TSparky.Create();
  MyThread.Logger := fLogger;

  Started := True;
end;

procedure TERPWeb.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  Log(self.DisplayName + ' Stopping');

//  MyThread.Terminate;
  MyThread.MyTerminate;
  TThread.Sleep(500);

  Log(Self.DisplayName + ' Stopped');

  Stopped := True;
end;

procedure TERPWeb.ServicePause(Sender: TService; var Paused: Boolean);
begin
  MyThread.Suspend;;
  Paused := True;
end;

procedure TERPWeb.ServiceContinue(Sender: TService;
  var Continued: Boolean);
begin
  MyThread.Resume;
  Continued := True;
end;

end.
