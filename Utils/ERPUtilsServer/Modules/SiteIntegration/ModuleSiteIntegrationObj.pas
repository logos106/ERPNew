unit ModuleSiteIntegrationObj;

interface

uses
  classes, ModuleBaseServerObj, JsonRpcBase, JsonObject,
  LogThreadBase, APIDataSyncObj, forms;

type

  TModuleSiteIntegration = class(TModuleBaseServer)
  private
    WorkerThread: TAPIDataSyncThread;
  protected
    function GetLogger: TLoggerBase; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Terminate; override;
  published
  end;

  function GetModule(MainAppInst: TApplication): TModuleBaseServer;

implementation

uses
  sysutils, LogMessageTypes, LogThreadDbLib, LogThreadLib;


var
  fModuleSiteIntegration: TModuleSiteIntegration;


function GetModule(MainAppInst: TApplication): TModuleBaseServer;
begin
  fModuleSiteIntegration.AppInst:= MainAppInst;
  result:= fModuleSiteIntegration;
end;


{ TModuleSiteIntegration }

constructor TModuleSiteIntegration.Create;
begin
  inherited;
  try
    ModuleName:= 'SiteIntegration';
    ModuleDescription:= 'Module to integrate different ERP sites';
    WorkerThread:= TApiDataSyncThread.Create(self);
  except
    on e: exception do begin
      if Assigned(Logger) then
        Logger.Log('Error creating TModuleSiteIntegration object with message: ' + e.Message, ltError);
    end;
  end;
end;

destructor TModuleSiteIntegration.Destroy;
var
  dt: TDateTime;
const
  OneSec = 1/24/60/60;
begin
  Logger.Log('Shutting down ..',ltInfo);
  Terminate;
//  while not WorkerThread.Terminated do
  dt := now + (30 * OneSec);
  while Status <> msStopped do begin
    if now > dt then begin
      Logger.Log('  Worker Thread took longer than 30 Secs to stop',ltWarning);
      WorkerThread.Terminate;
      Sleep(50);
      break;
    end;
    Sleep(20);
  end;
  Logger.Log('  Freeing Worker Thread',ltInfo);
  WorkerThread.Free;
  Logger.Log('Done.',ltInfo);
  while not Logger.Buffer.Empty do
    Sleep(10);
  Logger.Active := false;
  inherited;
end;

function TModuleSiteIntegration.GetLogger: TLoggerBase;
begin
  result:= TDbLogger.Create(nil);
//  result:= TLogger.Create(nil);
  self.LoggingLevel:= llInfo;
end;

procedure TModuleSiteIntegration.Terminate;
begin
  Logger.Log('Terminating Worker Thread',ltInfo);
  inherited;
end;

initialization
  if not Assigned(fModuleSiteIntegration) then
    fModuleSiteIntegration:= TModuleSiteIntegration.Create;

finalization
  fModuleSiteIntegration.Free;
  fModuleSiteIntegration:= nil;


end.
