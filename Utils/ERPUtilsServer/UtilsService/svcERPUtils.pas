unit svcERPUtils;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  UtilsServerObj, LogThreadLib, LogMessageTypes;

type
  TERPUtils = class(TService)
    procedure ServiceExecute(Sender: TService);
    procedure ServiceAfterInstall(Sender: TService);
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceDestroy(Sender: TObject);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);

  private
    Server: TUtilsServer;
    Logger: TLogger;
    procedure Log(msg: string; msgType: TLogMessageType = ltDetail);

  public
    function GetServiceController: TServiceController; override;
  end;

var
  ERPUtils: TERPUtils;

implementation

{$R *.DFM}

uses
  registry, Forms, JsonObject;

const
  OneMin = 1/24/60;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  ERPUtils.Controller(CtrlCode);
end;

function TERPUtils.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TERPUtils.ServiceExecute(Sender: TService);
begin
  while not Terminated do begin
    ServiceThread.ProcessRequests(False);
    Sleep(50);
    Application.ProcessMessages;
//    CheckForUpdates;
  end;
end;

procedure TERPUtils.Log(msg: string; msgType: TLogMessageType = ltDetail);
begin
  if Assigned(Logger) then
    Logger.Log(msg, msgType);
end;

procedure TERPUtils.ServiceAfterInstall(Sender: TService);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('\SYSTEM\CurrentControlSet\Services\ERPUtils', False) then begin
       Reg.WriteString('Description', 'ERP Utilities Service');
       Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TERPUtils.ServiceCreate(Sender: TObject);
begin
  Logger := TLogger.Create(nil);
  Logger.LogAllTypes;
  Log(Self.DisplayName + ' Created');
end;

procedure TERPUtils.ServiceDestroy(Sender: TObject);
begin
  Log(Self.DisplayName + ' Destroyed');
  FreeAndNil(Logger);
end;

procedure TERPUtils.ServiceStart(Sender: TService; var Started: Boolean);
begin
  Log(self.DisplayName + ' Starting');
  try
    Server := TUtilsServer.Create(Logger);
    Server.Active := True;
  except
    on e: exception do begin
      Log('Exception starting server: ' + e.Message);
    end;
  end;
  Log(Self.DisplayName + ' Started');
end;

procedure TERPUtils.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  Log(self.DisplayName + ' Stopping');
  try
    Server.Active := False;
    Sleep(50);
    FreeAndNil(Server);
  except
    on e: exception do begin
      Log('Exception stopping server: ' + e.Message);
    end;
  end;
  Log(Self.DisplayName + ' Stopped');
end;

end.
