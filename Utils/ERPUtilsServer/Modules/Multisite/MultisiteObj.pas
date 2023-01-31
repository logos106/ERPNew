unit MultisiteObj;

interface

uses
  MultisiteConfigObj, JsonObject, syncobjs, classes, LogThreadLib,
  SynchronizerObj, MultisiteConst, ModuleConst;

type

  TWorkerThread = class;
  TMultisite = class(TPersistent)
  private
    fLock: TCriticalSection;
    WorkerThread: TWorkerThread;
    fConfig: TServerConfig;
    fSchema: TJsonObject;
    fStatus: TMultisiteStatus;
    fLogger: TLogger;
    fActive: boolean;
    function GetConfig: TServerConfig;
    function GetSchema: TJsonObject;
    procedure SetActive(const Value: boolean);
    function GetConfigText: string;
    procedure SetConfigText(const Value: string);
    procedure SetStatus(const Value: TMultisiteStatus);
    procedure SaveConfig;
    procedure LoadConfig;
    function GetActive: boolean;
    procedure SetLoggingLevel(const Value: TLoggingLevel);
    procedure SetLoggingTypes;
    function GetLoggingLevel: TLoggingLevel;
  public
    property Logger: TLogger read fLogger write fLogger;
    constructor Create(aLogger: TLogger = nil);
    destructor Destroy; override;
    property Config: TServerConfig read GetConfig;
    property Schema: TJsonObject read GetSchema;
    procedure Lock;
    procedure Unlock;
  published
    property Active: boolean read GetActive write SetActive;
    property ConfigText: string read GetConfigText write SetConfigText;
    property Status: TMultisiteStatus read fStatus write SetStatus;
    property LoggingLevel: TLoggingLevel read GetLoggingLevel write SetLoggingLevel;
  end;

  TWorkerThread = class(TThread)
  private
    function GetMainStatus: TMultisiteStatus;
    procedure SetMainStatus(const Value: TMultisiteStatus);
  private
    fMS: TMultisite;
    fIsTerminated: boolean;
    SyncObj: TDataSynchronizer;
    DoingRestart: boolean;
    procedure DoOnBeforeGetActive(Sender: TObject);
    procedure DoWork;
    property MainStatus: TMultisiteStatus read GetMainStatus write SetMainStatus;
  protected
    procedure Execute; override;
  public
    constructor Create(Multisite: TMultisite); reintroduce;
    destructor Destroy; override;
    property IsTerminated: boolean read fIsTerminated;
  end;

var
  Logger: TLogger;
  MS: TMultisite;

implementation

uses
  sysutils, windows, JsonToObject, LogMessageTypes, ConfigSessions, frmMultisiteSchema;

function GetModuleName: string;
var
  szFileName: array[0..MAX_PATH] of Char;
begin
  FillChar(szFileName, SizeOf(szFileName), #0);
  GetModuleFileName(hInstance, szFileName, MAX_PATH);
  Result := szFileName;
end;

{ TMultisite }

constructor TMultisite.Create(aLogger: TLogger = nil);
begin
  try
    fLock:= TCriticalSection.Create;
    fLogger:= aLogger;
    fStatus:= msInactive;
    fConfig:= TServerConfig.Create;
    LoadConfig;

    SetLoggingTypes;
    fSchema:= JO(TMultisiteSchema.SchemaText);
    WorkerThread:= TWorkerThread.Create(self);
  except
    on e: exception do begin
      if Assigned(Logger) then
        Logger.Log('Error creating TMultisite object with message: ' + e.Message, ltError);

    end;
  end;
end;

destructor TMultisite.Destroy;
begin
  { save config before changing status so when service is restarted
    mutisite (if was active) will restart }
  self.SaveConfig;
  if not (Status in [msInactive, msStopping]) then
    Status:= msStopping;
  if Assigned(WorkerThread) then begin
    WorkerThread.Terminate;
    while not WorkerThread.IsTerminated do
      sleep(10);
    WorkerThread.Free;
  end;
  fConfig.Free;
  fSchema.Free;
  fLock.Free;
  inherited;
end;

function TMultisite.GetActive: boolean;
begin
  result:=  fActive; //fConfig.Active;   //fStatus = msActive;
end;

function TMultisite.GetConfig: TServerConfig;
begin
  result:= fConfig;
end;

function TMultisite.GetConfigText: string;
begin
  result:= ObjToStr(Config);
end;

function TMultisite.GetLoggingLevel: TLoggingLevel;
begin
//  result:= Config.LoggingLevel;
end;

function TMultisite.GetSchema: TJsonObject;
begin
  result:= fSchema;
end;

procedure TMultisite.LoadConfig;
var
  configFileName: string;
begin
    configFileName:= ChangeFileExt(GetModuleName, '_Config.cfg');
    FileToObj(configFileName, self);
end;

procedure TMultisite.Lock;
begin
  fLock.Acquire;
end;

procedure TMultisite.SaveConfig;
var
  configFileName: string;
begin
    configFileName:= ChangeFileExt(GetModuleName, '_Config.cfg');
    ObjToFile(self, configFileName);
end;

procedure TMultisite.SetActive(const Value: boolean);
begin
  if Value then begin
    { make active }
    case fStatus of
      msInactive: Status:= msStarting;
      msActive,
      msStarting,
      msRestarting: ; {do nothing}
      msStopping: Status:= msRestarting;
    end;
  end
  else begin
    { make inactive }
    case fStatus of
      msStopping,
      msInactive:; {do nothing}
      msActive,
      msStarting,
      msRestarting:
        begin
          Status:= msStopping;
          //SyncObj.
        end;

    end;
  end;
  fActive:= Value;
  SaveConfig;
  if Assigned(Logger) then
    Logger.Events.FireEvent(self,'onchange','status');
end;

procedure TMultisite.SetConfigText(const Value: string);
begin
  if ObjToStr(Config) <> Value then begin
    if not (fStatus in [msInactive, msStopping]) then begin
      Status:= msStopping;
    end;
    StrToObj(Value, Config);
    SaveConfig;
    if Assigned(Logger) then
      Logger.Events.FireEvent(self,'onchange','config');
  end;
end;

procedure TMultisite.SetLoggingLevel(const Value: TLoggingLevel);
begin
//  if Config.LoggingLevel <> Value then begin
//    Config.LoggingLevel := Value;
//    SaveConfig;
//    if Assigned(Logger) then begin
//      Logger.Events.FireEvent(self,'onchange','config');
//      SetLoggingTypes;
//    end;
//  end;
end;

procedure TMultisite.SetLoggingTypes;
begin
  if Assigned(Logger) then begin
    case LoggingLevel of
      llError:   Logger.LogMessageTypes:= [ltError];
      llWarning: Logger.LogMessageTypes:= [ltError, ltWarning];
      llDetail:  Logger.LogMessageTypes:= [ltNone, ltError, ltWarning, ltInfo, ltDetail, ltBlank, ltDebug];
    end;
  end;
end;

procedure TMultisite.SetStatus(const Value: TMultisiteStatus);
begin
  if fStatus <> Value then begin
    fStatus := Value;
    if Assigned(Logger) then
      Logger.Events.FireEvent(self,'onchange','status');
  end;
end;

procedure TMultisite.Unlock;
begin
  fLock.Release;
end;

{ TWorkerThread }

constructor TWorkerThread.Create(Multisite: TMultisite);
begin
  fIsTerminated:= false;
  fMS:= Multisite;
  DoingRestart:= false;
  SyncObj:= TDataSynchronizer.create;
  SyncObj.Logger:= fMS.Logger;
  SyncObj.OnBeforeGetActive:= DoOnBeforeGetActive;
  inherited Create(false);
  Priority:= tpLower;
  FreeOnTerminate:= false;
end;

destructor TWorkerThread.Destroy;
begin
  SyncObj.Free;
  inherited;
end;

procedure TWorkerThread.Execute;
begin
  inherited;
  while not Terminated do begin
    try
      DoWork;
    except
      on e: Exception do begin
        Logger.Log('Exception: ' + e.Message,ltError);
      end;
    end;
  end;
  fIsTerminated:= true;
end;

procedure TWorkerThread.DoWork;
var
  idxDatabase, idxRemote: integer;
  Database: TDatabase;
  RemoteDatabase: TRemoteDatabase;
  status: TMultisiteStatus;
const
  OneSec = 1/24/60/60;

  function TimeToSync: boolean;
  begin
    Randomize;
    result:= Database.LastSyncTime + Database.CheckInterval + (Random(10) * OneSec) <= now;
  end;

begin
  sleep(10);
  status:= MainStatus;
  case status of
    msActive,
    msStarting:
      begin
        if SyncObj.Active then begin
          if SyncObj.Config.DatabaseList.Count = 0 then begin
            fMS.Logger.Log('Thre are no databases specified in the config, stopping multisite.',ltWarning);
            MainStatus:= msStopping;
            exit;
          end;
          for idxDatabase:= 0 to SyncObj.Config.DatabaseList.Count -1 do begin
             if Status <> msActive then break;
             Database:= SyncObj.Config.DatabaseList[idxDatabase];
             if not Database.SynchronizationActive then
               Continue;
             if not TimeToSync then
               Continue;
             Database.LastSyncTime:= now;
             for idxRemote:= 0 to Database.RemoteDatabaseList.Count -1 do begin
               if Status <> msActive then break;
               RemoteDatabase:= Database.RemoteDatabaseList[idxRemote];
               SyncObj.DoSyncSite(RemoteDatabase,SyncObj.Config.MySqlServer,Database.DatabaseName);
             end;
          end;
        end
        else begin
          SyncObj.Schema.Assign(fMS.Schema);
          fMS.Lock;
          try
            ObjToObj(fMS.Config,SyncObj.Config);
          finally
            fMS.Unlock;
          end;
          SyncObj.Active:= true;
        end;
        if status = msStarting then begin
          MainStatus:= msActive;
          fMS.Logger.Log('Multisite started.',ltInfo);
        end;
      end;
    msInactive,
    msStopping:
      begin
        if SyncObj.Active then begin
          SyncObj.Active:= false;
        end;
        if status = msStopping then begin
          MainStatus:= msInactive;
          fMS.Logger.Log('Multisite stopped.',ltInfo);
        end;
      end;
    msRestarting:
      begin
        if SyncObj.Active then begin
          SyncObj.Active:= false;
        end;
        MainStatus:= msStarting;
        fMS.Logger.Log('Multisite restarting.',ltInfo);
      end;
  end;
end;

function TWorkerThread.GetMainStatus: TMultisiteStatus;
begin
  result:= fMS.Status;
end;

procedure TWorkerThread.SetMainStatus(const Value: TMultisiteStatus);
begin
  fMS.Lock;
  try
    fMS.Status:= Value;
  finally
    fMS.Unlock;
  end;
end;

procedure TWorkerThread.DoOnBeforeGetActive(Sender: TObject);
begin
  case MainStatus of
    msActive,
    msStarting,
    msRestarting: ;
    msInactive,
    msStopping: TDataSynchronizer(Sender).Active:= false;
  end;
end;

initialization
  Logger:= TLogger.Create(nil);
  Logger.LogName:= 'Multisite';
  Logger.LogMessageTypes:= [ltNone, ltError, ltWarning, ltInfo, ltDetail, ltBlank, ltDebug];
  MS:= TMultisite.Create(Logger);
  MultisiteConfigSessionList:= TMultisiteConfigSessionList.Create(Logger);

finalization
  Logger.Active:= false;
  FreeAndNil(MS);
  try
    FreeAndNil(MultisiteConfigSessionList);
  except
  end;
  FreeAndNil(Logger);
end.
