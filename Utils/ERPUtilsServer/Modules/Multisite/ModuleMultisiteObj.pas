unit ModuleMultisiteObj;

interface

uses
  ModuleBaseServerObj, forms, classes,
  MultisiteConst, SynchronizerObj, MultisiteConfigObj,
  JsonObject, JsonRpcBase;

type

  TMultisiteThread = class;
  TModuleMultisite = class(TModuleBaseServer)
  private
    fSiteConfig: TServerConfig;
    fSchema: TJsonObject;
    fStatus: TMultisiteStatus;
    WorkerThread: TMultisiteThread;
    procedure SetStatus(const Value: TMultisiteStatus);
    procedure DoSubOnChange(Sender: TObject);
  protected
    procedure DoChange; override;
    procedure SetActive(const Value: boolean); override;
    function GetTerminated: boolean; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    property Schema: TJsonObject read fSchema;
    procedure DoRequest(Client: TJsonRpcBase; RequestJson: TJsonObject;
      ResponseJson: TJsonObject = nil); override;
    procedure Terminate; override;
  published
    property SiteConfig: TServerConfig read fSiteConfig;
    property Status: TMultisiteStatus read fStatus write SetStatus;
  end;

  TMultisiteThread = class(TThread)
  private
    function GetMainStatus: TMultisiteStatus;
    procedure SetMainStatus(const Value: TMultisiteStatus);
  private
    MsModule: TModuleMultisite;
    fIsTerminated: boolean;
    SyncObj: TDataSynchronizer;
    DoingRestart: boolean;
    procedure DoOnBeforeGetActive(Sender: TObject);
    procedure DoWork;
    property MainStatus: TMultisiteStatus read GetMainStatus write SetMainStatus;
  protected
    procedure Execute; override;
  public
    constructor Create(Module: TModuleMultisite); reintroduce;
    destructor Destroy; override;
    property IsTerminated: boolean read fIsTerminated;
  end;


  TMSConfigSession = class(TModuleSession)
  private
    fUpdatingModule: boolean;
  public
    constructor Create;
    procedure DoRequest(RequestJson: TJsonObject; ResultJson: TJsonObject = nil); override;
    property UpdatingModule: boolean read fUpdatingModule write fUpdatingModule;
  end;


  function GetModule(MainAppInst: TApplication): TModuleBaseServer;

implementation

uses
  sysutils, LogMessageTypes, frmMultisiteSchema, JsonToObject, JsonRpcConst,
  MultisiteUtils;

var
  fModuleMultisite: TModuleMultisite;

function GetModule(MainAppInst: TApplication): TModuleBaseServer;
begin
  fModuleMultisite.AppInst:= MainAppInst;
  result:= fModuleMultisite;
end;


{ TModuleMultisite }

constructor TModuleMultisite.Create;
begin
  inherited;
  try
    fModuleName:= 'Multisite';
    fModuleDescription:= 'Module to synchronise data between ERP database''s';
    fSiteConfig:= TServerConfig.Create;
    fSiteConfig.OnChange:= self.DoSubOnChange;
    fSchema:= JO(TMultisiteSchema.SchemaText);
    fStatus:= msInactive;
    LoadConfig;
    if fActive then
      Active:= true;
    WorkerThread:= TMultisiteThread.Create(self);
  except
    on e: exception do begin
      if Assigned(Logger) then
        Logger.Log('Error creating TModuleMultisite object with message: ' + e.Message, ltError);

    end;
  end;
end;

destructor TModuleMultisite.Destroy;
var
  dt: TDateTime;
const
  OneSecond = 1/24/60/60;
begin
  { save config before changing status so when service is restarted
    mutisite (if was active) will restart }
  self.SaveConfig;
  if not (Status in [msInactive, msStopping]) then
    Status:= msStopping;
  dt:= now + (30 * OneSecond);
  while (Status <> msInactive) and (now <= dt) do
    Sleep(50);


  if Assigned(WorkerThread) then begin
    WorkerThread.Terminate;
    while not WorkerThread.IsTerminated do
      sleep(10);
    WorkerThread.Free;
  end;
  fSchema.Free;
  fSiteConfig.Free;
  inherited;
end;

procedure TModuleMultisite.DoChange;
var
  x: integer;
  list: TList;
  ses: TMSConfigSession;
begin
  inherited;
  if LoadingConfig then
    exit;
  list:= SessionList.LockList;
  try
    for x:= 0 to list.Count - 1 do begin
      ses:= TMSConfigSession(list[x]);
      if (ses.SessionType = mstConfig) and (not ses.UpdatingModule) then begin
        ses.Client.SendNotification('event',JO('{"eventname":"onchange","senderclassname":"' + self.ClassName +'"}'));
      end;
    end;
  finally
    SessionList.UnlockList;
  end;
end;

procedure TModuleMultisite.DoRequest(Client: TJsonRpcBase; RequestJson,
  ResponseJson: TJsonObject);
var
  Session: TModuleSession;
  MSConfigSession: TMSConfigSession;
  methodName: string;
  idx: integer;
begin
  inherited;
  Session:= self.SessionList.Session(Client);
  if Assigned(Session) then
    Session.DoRequest(RequestJson, ResponseJson)
  else begin
    { process the request }
    methodName:= Lowercase(RequestJson.S['method']);
    idx:= Pos('.',methodName);
    if idx > 0 then
      methodName:= Copy(methodName,idx+1,Length(methodName));
    if methodName = 'startsession' then begin
      { now look at params to see what sort of session this is ... }
      if RequestJson.ObjectExists('params') then begin
        if RequestJson.O['params'].S['sessiontype'] = 'config' then begin
          MSConfigSession:= TMSConfigSession.Create;
          MSConfigSession.SessionType:= mstConfig;
          MSConfigSession.Client:= Client;
          SessionList.AddSession(MSConfigSession);
          if Assigned(ResponseJson) then
            ResponseJson.S['result']:= 'ok';
        end
        else begin
          if Assigned(ResponseJson) then begin
            ResponseJson.O['error']:=
              JO('{"code": '+ IntToStr(-1) +
              ', "message": "Invalid session type"}');
          end;
        end;
      end
      else begin
        if Assigned(ResponseJson) then begin
            ResponseJson.O['error']:=
              JO('{"code": '+ IntToStr(RPC_INVALID_REQUEST) +
            ', "message": "Invalid request format - params object not found"}');
        end;
      end;

    end;
  end;
end;

procedure TModuleMultisite.DoSubOnChange(Sender: TObject);
begin
  DoChange;
end;

function TModuleMultisite.GetTerminated: boolean;
begin
  result:= Status = msInactive;
end;

procedure TModuleMultisite.SetActive(const Value: boolean);
begin
//  if fActive <> Value then begin
    fActive:= Value;
    if fActive and (not (fStatus in [msActive, msStarting, msRestarting])) then
      fStatus:= msStarting
    else if (not fActive) and (not (fStatus in [msInactive, msStopping])) then
      fStatus:= msStopping;
    DoChange;
//  end;
end;

procedure TModuleMultisite.SetStatus(const Value: TMultisiteStatus);
begin
  if fStatus <> Value then begin
    fStatus := Value;
//    if fStatus in [msInactive, msStopping] then
//      self.fActive:= false
//    else if fStatus in [msActive, msStarting, msRestarting] then
//      self.fActive:= true;
    DoChange;
  end;
end;

procedure TModuleMultisite.Terminate;
begin
  inherited;
  if not (Status in [msInactive, msStopping]) then
    Status:= msStopping;
end;

{ TMultisiteThread }

constructor TMultisiteThread.Create(Module: TModuleMultisite);
begin
  fIsTerminated:= false;
  MsModule:= Module;
  DoingRestart:= false;
  SyncObj:= TDataSynchronizer.create;
  SyncObj.Logger:= MsModule.Logger;
  SyncObj.OnBeforeGetActive:= DoOnBeforeGetActive;
  inherited Create(false);
  Priority:= tpLower;
  FreeOnTerminate:= false;
end;

destructor TMultisiteThread.Destroy;
begin
  SyncObj.Free;
  inherited;
end;

procedure TMultisiteThread.DoOnBeforeGetActive(Sender: TObject);
begin
  case MainStatus of
    msActive,
    msStarting,
    msRestarting: ;
    msInactive,
    msStopping: TDataSynchronizer(Sender).Active:= false;
  end;
end;

procedure TMultisiteThread.DoWork;
var
  idxDatabase, idxRemote: integer;
  Database: TDatabase;
  RemoteDatabase: TRemoteDatabase;
  status: TMultisiteStatus;
  msg: string;
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
            MsModule.Logger.Log('Thre are no databases specified in the config, stopping multisite.',ltWarning);
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
             if not Database.DbPreCheckDone then begin
               if not (CreateMSChangeLogTable('localhost',Database.DatabaseName,msg) and
                       CheckCreateMSTriggers('localhost',Database.DatabaseName,msg)) then begin
                 MsModule.Logger.Log('Failed to prepare local database with error: ' + msg,ltWarning);
                 continue;
//                 MainStatus:= msStopping;
//                 exit;
               end
               else
                 Database.DbPreCheckDone:= true;
             end;
             Database.LastSyncTime:= now;
             for idxRemote:= 0 to Database.RemoteDatabaseList.Count -1 do begin
               if Status <> msActive then break;
               RemoteDatabase:= Database.RemoteDatabaseList[idxRemote];
               SyncObj.SyncSite(RemoteDatabase,SyncObj.Config.MySqlServer,Database.DatabaseName);
             end;
          end;
        end
        else begin
          SyncObj.Schema.Assign(MsModule.Schema);
          MsModule.Lock;
          try
            ObjToObj(MsModule.SiteConfig,SyncObj.Config);
          finally
            MsModule.Unlock;
          end;
          SyncObj.Active:= true;
        end;
        if status = msStarting then begin
          MainStatus:= msActive;
          MsModule.Logger.Log('Multisite started.',ltInfo);
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
          MsModule.Logger.Log('Multisite stopped.',ltInfo);
        end;
      end;
    msRestarting:
      begin
        if SyncObj.Active then begin
          SyncObj.Active:= false;
        end;
        MainStatus:= msStarting;
        MsModule.Logger.Log('Multisite restarting.',ltInfo);
      end;
  end;
end;

procedure TMultisiteThread.Execute;
begin
  inherited;
  while not Terminated do begin
    try
      DoWork;
    except
      on e: Exception do begin
        MsModule.Logger.Log('Exception: ' + e.Message,ltError);
      end;
    end;
  end;
  fIsTerminated:= true;
end;

function TMultisiteThread.GetMainStatus: TMultisiteStatus;
begin
  result:= MsModule.Status;
end;

procedure TMultisiteThread.SetMainStatus(const Value: TMultisiteStatus);
begin
  MsModule.Lock;
  try
    MsModule.Status:= Value;
  finally
    MsModule.Unlock;
  end;
end;

{ TMSConfigSession }

constructor TMSConfigSession.Create;
begin
  fUpdatingModule:= false;
end;

procedure TMSConfigSession.DoRequest(RequestJson, ResultJson: TJsonObject);
var
  method: string;
  idx: integer;
begin
  { process the request }
  method:= Lowercase(RequestJson.S['method']);
  idx:= Pos('.',method);
  if idx > 0 then
    method:= Copy(method,idx+1,Length(method));
  if method = 'getobject' then begin
    { now look at params to see which object ... }
    if RequestJson.ObjectExists('params') then begin
      if RequestJson.O['params'].S['classname'] = self.SessionList.Module.ClassName then begin
        self.SessionList.Module.Lock;
        try
          ResultJson.O['result'].S['classname']:= self.SessionList.Module.ClassName;
          ObjToJson(self.SessionList.Module,ResultJson.O['result'].O['object']);
        finally
          self.SessionList.Module.Unlock;
        end;
      end;
    end;
  end
  else if method = 'setobject' then begin
    if RequestJson.ObjectExists('params') then begin
      if RequestJson.O['params'].S['classname'] = self.SessionList.Module.ClassName then begin
        self.SessionList.Module.Lock;
        try
          self.UpdatingModule:= true;
          JsonToObj(RequestJson.O['params'].O['object'],self.SessionList.Module);
          self.SessionList.Module.SaveConfig;
        finally
          self.UpdatingModule:= false;
          self.SessionList.Module.Unlock;
        end;
        if Assigned(ResultJson) then
          ResultJson.S['result']:= 'ok';
      end;
    end;
  end;
end;

initialization
  if not Assigned(fModuleMultisite) then
    fModuleMultisite:= TModuleMultisite.Create;


finalization
  fModuleMultisite.Free;
  fModuleMultisite:= nil;


end.
