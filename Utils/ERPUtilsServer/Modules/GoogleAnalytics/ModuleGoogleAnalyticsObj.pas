unit ModuleGoogleAnalyticsObj;

interface

uses
  classes, ModuleBaseServerObj, syncobjs, JsonRpcBase, JsonObject,
  LogThreadBase, forms;

type

  TAnalyticsThread = class;

  TModuleGoogleAnalytics = class(TModuleBaseServer)
  private
    WorkerThread: TAnalyticsThread;
  protected
    function GetLogger: TLoggerBase; override;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
  end;

  TAnalyticsThread = class(TThread)
  private
    fLock: TCriticalSection;
    fNextCheckTime: TDateTime;
    Module: TModuleGoogleAnalytics;
    procedure DoWork;
    procedure GetIsTerminatedEvent(var aIsTerminated: boolean);
  protected
    procedure Execute; override;
  public
    constructor Create(aModule: TModuleGoogleAnalytics); reintroduce;
    destructor Destroy; override;
  end;

  function GetModule(MainAppInst: TApplication): TModuleBaseServer;

implementation

uses
  sysutils, LogMessageTypes, LogThreadDbLib, AnalyticsObj, DbUtils;

const
  OneMinute = 1/26/60;
  CheckInterval = OneMinute * 60;
var
  fModuleGoogleAnalytics: TModuleGoogleAnalytics;


function GetModule(MainAppInst: TApplication): TModuleBaseServer;
begin
  fModuleGoogleAnalytics.AppInst:= MainAppInst;
  result:= fModuleGoogleAnalytics;
end;


{ TModuleGoogleAnalytics }

constructor TModuleGoogleAnalytics.Create;
begin
  inherited;
  try
    ModuleName:= 'GoogleAnalytics';
    ModuleDescription:= 'Module to download Google Analytics data';
    self.LoggingLevel:= llWarning;
    WorkerThread:= TAnalyticsThread.Create(self);
  except
    on e: exception do begin
      if Assigned(Logger) then
        Logger.Log('Error creating TModuleGoogleAnalytics object with message: ' + e.Message, ltError);
    end;
  end;
end;

destructor TModuleGoogleAnalytics.Destroy;
begin
  Logger.Log('Shutting down ..',ltInfo);
  Terminate;
  Logger.Log('  Terminating worker thread',ltInfo);
  //WorkerThread.Terminate;
  while not WorkerThread.Terminated do
    sleep(10);
  Logger.Log('  Freeing worker thread',ltInfo);
  WorkerThread.Free;
  Logger.Log('Done',ltInfo);
  while not Logger.Buffer.Empty do
    Sleep(10);
  inherited;
end;

function TModuleGoogleAnalytics.GetLogger: TLoggerBase;
begin
  result:= TDbLogger.Create(nil);
  result.LogAllTypes;
end;

{ TAnalyticsThread }

constructor TAnalyticsThread.Create(aModule: TModuleGoogleAnalytics);
begin
  fLock:= TCriticalSection.Create;
  Module:= aModule;
  inherited Create(false);
  Priority:= tpLower;
  FreeOnTerminate:= false;
  fNextCheckTime:= now + OneMinute;
end;

destructor TAnalyticsThread.Destroy;
begin
  fLock.Free;
  inherited;
end;

procedure TAnalyticsThread.DoWork;
var
  dbList: TStringList;
  GA: TGoogleAnalytics;
  x: integer;
begin
  if now >= fNextCheckTime then begin
    try
//      if not Module.Active then
//        exit;
      dbList:= TStringList.Create;
      GA:= TGoogleAnalytics.Create;
      try
        GA.OnGetTerminated := GetIsTerminatedEvent;
        dbList.CommaText:= GetDatabaseList('localhost',true);
        GA.Logger:= Module.Logger;
        GA.DbServerName:= 'localhost';
        for x:= 0 to dbList.Count -1 do begin
          if Module.Status <> msRunning then
            exit;
          GA.DbDatabaseName:= dbList[x];
          if GA.AnalyticsEnabled then begin
            Module.LoggingLevel:= GA.LoggingLevel;
            GA.CheckForNewData;
          end;
        end;
      finally
        GA.Free;
        dbList.Free;
      end;
    finally
      fNextCheckTime:= now + CheckInterval;
      Module.LoggingLevel:= llWarning;
    end;
  end;
end;

procedure TAnalyticsThread.Execute;
begin
  try
    try
      inherited;
      while not Terminated do begin
        try
          Sleep(200);
          if Module.Status = msRunning then
            DoWork
          else
            if not Terminated then
              Terminate;
        except
          on e: Exception do begin
            Module.Logger.Log('Exception: ' + e.Message,ltError);
          end;
        end;
      end;
    except
      on e: Exception do begin
        Module.Logger.Log('Exception: ' + e.Message,ltError);
      end;
    end;
  finally
    Module.Status := msStopped;
  end;
end;

procedure TAnalyticsThread.GetIsTerminatedEvent(var aIsTerminated: boolean);
begin
  aIsTerminated := Module.Status <> msRunning;
end;

initialization
  if not Assigned(fModuleGoogleAnalytics) then
    fModuleGoogleAnalytics:= TModuleGoogleAnalytics.Create;

finalization
  fModuleGoogleAnalytics.Free;
  fModuleGoogleAnalytics:= nil;



end.
