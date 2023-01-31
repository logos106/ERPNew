unit ModuleUserUtilsObj;

interface
uses
  ModuleBaseServerObj, forms, classes,
  JsonObject, JsonRpcBase, ClientConfigObj, JsonRpcTcpClient,
  SharedAppUserListObj, syncobjs, ErpDbUpdaterObj, ThreadTaskObj, MailReaderObj;

type

  TUserUtilsThread = class;
  TModuleUserUtils = class(TModuleBaseServer)
  private
    WorkerThread: TUserUtilsThread;
    fClientConfig: TClientConfig;
    FERPServerPort: integer;
    FERPServerName: string;
    function GetConfigText: string;
    procedure SetConfigText(const Value: string);
    procedure SetERPServerName(const Value: string);
    procedure SetERPServerPort(const Value: integer);
    function getSoftwareReleaseType: string;
//    procedure DecryptOldConfigFile;
  protected
    procedure DoChange; override;
    procedure SetActive(const Value: boolean); override;
  public
    Config: TJsonObject;
//    AppUserList: TAppUserList;
    AppUserList: TSharedAppUserList;
    TaskList: TThreadTaskList;
    constructor Create; override;
    destructor Destroy; override;
    procedure DoRequest(Client: TJsonRpcBase; RequestJson: TJsonObject;
      ResponseJson: TJsonObject = nil); override;
    property ClientConfig: TClientConfig read fClientConfig;
    procedure LoadConfig(encrypt: boolean = false); override;
    procedure SaveConfig(encrypt: boolean = false); override;
    procedure ForceLicenceCheck;
    procedure ForceUpdateCheck;
    procedure ForceUpdate(DbListJsonText: string);
    procedure Terminate; override;
  published
    property ConfigText: string read GetConfigText write SetConfigText;
    property ERPServerName: string read FERPServerName write SetERPServerName;
    property ERPServerPort: integer read FERPServerPort write SetERPServerPort;
    property SoftwareReleaseType: string read getSoftwareReleaseType;
  end;

  TUserUtilsConfigSession = class(TModuleSession)
  private
  public
    constructor Create;
    procedure DoRequest(RequestJson: TJsonObject; ResultJson: TJsonObject = nil); override;
  end;

  TUserUtilsClientSession = class(TModuleSession)
  private
    function CommsOkWithHeadOffice: boolean;
//    procedure DoOnBackupProgress(Sender: TObject);
//    procedure DoOnRestoreProgress(Sender: TObject);
//    procedure DoOnCopyProgress(Sender: TObject);
//    procedure DoOnRemoveProgress(Sender: TObject);
    procedure RemoveUserLocks;
  public
    constructor Create;
    destructor Destroy; override;
    procedure DoRequest(RequestJson: TJsonObject; ResultJson: TJsonObject = nil); override;
  end;

  TUserUtilsThread = class(TThread)
  private
    fLock: TCriticalSection;
    fNextValidateTime: TDateTime;
    Module: TModuleUserUtils;
    ERPClient: TJsonRpcTcpClient;
    NextPingCheckTime: TDateTime;
    fNextUpdateCheckTime: TDateTime;
    fNextInactiveUserCheckTime: TDateTime;
    fNextTaskListCheckTime: TDateTime;
    fNextEmailCheckTime: TDateTime;
    fDbListJsonText: string;
    MailReader: TMailReader;
    procedure DoOnRequest(Client: TJsonRpcBase; ReqJson: TJSONObject; ResJson: TJSONObject = nil);
    procedure DoOnConnect(Client: TJsonRpcBase);
    procedure DoOnDisconnect(Client: TJsonRpcBase);
    procedure DoWork;
    function StartERPServerSession(var msg: string): boolean;
    function GetNextValidateTime: TDateTime;
    procedure SetNextValidateTime(const Value: TDateTime);
    function GetNextUpdateCheckTime: TDateTime;
    procedure SetNextUpdateCheckTime(const Value: TDateTime);
    procedure DoOnEmailProgress(const msg: string; var Continue: boolean);
  protected
    procedure Execute; override;
  public
    constructor Create(aModule: TModuleUserUtils); reintroduce;
    destructor Destroy; override;
    property NextValidateTime: TDateTime read GetNextValidateTime write SetNextValidateTime;
    property NextUpdateCheckTime: TDateTime read GetNextUpdateCheckTime write SetNextUpdateCheckTime;
    procedure ForceUpdate(DbListJsonText: string);
  end;

  function GetModule(MainAppInst: TApplication): TModuleBaseServer;

implementation

uses
  sysutils, LogMessageTypes, JsonRPCConst, JsonToObject, ModuleUtils,
  MachineSignature, {OldLicenceInfo,} ModuleConst, ModuleDbUtils,
  ErpDbInfo, DBBackupObj, InstallConst, InternetConnectivityUtils,
  MyAccess, DbConst, windows, EncryptFix, ErpDbMaintObj, SystemLib,
  IntegerListObj, ERPDbListObj, ERPDbComponents, ModuleServerUtils;

var
  fModuleUserUtils: TModuleUserUtils;

const
//  ERP_SERVER_NAME_DEFAULT = 'localhost';
  UPDATE_USER = 'Client';
  OneMinute = 1/24/60;
  PERIOD_NO_CONNECT_CANCEL = 7;
  PERIOD_VALIDATION_CHECK = OneMinute * 240;  // four hours
//  PERIOD_VALIDATION_CHECK = OneMinute / 20;  // four hours
  PERIOD_REVALIDATION_CHECK = OneMinute * 30; // half hour
//  PERIOD_REVALIDATION_CHECK = OneMinute / 20; // half hour
  MAX_USER_INACTIVITY_TIME = OneMinute * 30;
  USER_INACTIVITY_CHECK_INTERVAL = OneMinute;
  EmailCheckInterval = OneMinute * 30;


function GetModule(MainAppInst: TApplication): TModuleBaseServer;
begin
  fModuleUserUtils.AppInst:= MainAppInst;
  result:= fModuleUserUtils;
end;

{ TModuleUserUtils }

constructor TModuleUserUtils.Create;
begin
  inherited;
  try
    FERPServerPort:= 0;
    FERPServerName:= '';
    fClientConfig:= TClientConfig.Create;
    ModuleName:= 'UserUtils';
    ModuleDescription:= 'Module to provide various user utilities for ERP';
//    AppUserList:= TAppUserList.Create;
    AppUserList:= TSharedAppUserList.Create;
    AppUserList.InitialiseDatabase;
    Config:= TJsonObject.Create;
    LoadConfig(true);
    self.fLoggingLevel:= llDetail;
    Logger.LogAllTypes;
//    AppUserList.Logger:= Logger;
    TaskList:= TThreadTaskList.Create(self);
    WorkerThread:= TUserUtilsThread.Create(self);
  except
    on e: exception do begin
      if Assigned(Logger) then
        Logger.Log('Error creating TModuleUserUtils object with message: ' + e.Message, ltError);
    end;
  end;
end;

//procedure TModuleUserUtils.DecryptOldConfigFile;
//type
//  TDecryptFile = function(InFileName, OutFileName: PAnsiChar): boolean; stdcall;
//var
//  configFileName: AnsiString;
//  tmpFileName: AnsiString;
//  json: TJsonObject;
//  libFile: string;
//  Handle: THandle;
//  DecryptFile: TDecryptFile;
//begin
//  configFileName:= ChangeFileExt(self.ModuleFileName, '_Config.cfg');
//  tmpFileName:= ChangeFileExt(self.ModuleFileName, '_Config.tmp');
//  libFile:= ExtractFilePath(self.ModuleFileName) + 'ConfigLib.dll';
//  Handle:= LoadLibrary(PChar(libFile));
//  if Handle <> 0 then begin
//    @DecryptFile := GetProcAddress(Handle,'DecryptFile');
//    if @DecryptFile <> nil then begin
//      if DecryptFile(PAnsiChar(configFileName),PAnsiChar(tmpFileName)) then begin
//        json:= TJsonObject.Create;
//        try
//          json.LoadFromFile(tmpFileName);
//          JsonToEncryptedFile(json,configFileName);
//          SysUtils.DeleteFile(tmpFileName);
//        finally
//          json.Free;
//        end;
//      end;
//    end;
//    FreeLibrary(Handle);
//  end;
//end;

destructor TModuleUserUtils.Destroy;
var
  dt: TDateTime;
const
  OneSec = 1/24/60/60;
begin
  Logger.Log('Shutting down ..',ltInfo);
  Self.Terminate;
  Logger.Log('  Saving config',ltInfo);
  self.SaveConfig(true);
  if Assigned(WorkerThread) then begin
    Logger.Log('  Terminating worker thread',ltInfo);
    //WorkerThread.Terminate;
//    while not WorkerThread.Terminated do
    dt := now + (30 * OneSec);
    while Status <> msStopped do begin
      if now > dt then begin
        Logger.Log('  Worker thread status not "stopped"',ltWarning);
        WorkerThread.Terminate;
        Sleep(50);
        break;
      end;
      sleep(10);
    end;
    Logger.Log('  Freeing worker thread',ltInfo);
    WorkerThread.Free;
  end;
  Logger.Log('  Freeing ClientConfig',ltInfo);
  fClientConfig.Free;
  Logger.Log('  Freeing Config',ltInfo);
  Config.Free;
  Logger.Log('  Freeing AppUserList',ltInfo);
  AppUserList.Free;
  Logger.Log('  Freeing TaskList',ltInfo);
  TaskList.Free;
  Logger.Log('Done',ltInfo);
  while not Logger.Buffer.Empty do
    Sleep(10);
  inherited;
end;

procedure TModuleUserUtils.DoChange;
begin
  inherited;

end;

procedure TModuleUserUtils.DoRequest(Client: TJsonRpcBase; RequestJson,
  ResponseJson: TJsonObject);
var
  Session: TModuleSession;
  ConfigSession: TUserUtilsConfigSession;
  ClientSession: TUserUtilsClientSession;
  methodName: string;
  idx: integer;
begin
  inherited;
  if self.Status <> msRunning then
    exit;
  self.RequestCount.Inc;
  try
    Session:= self.SessionList.Session(Client);
    if Assigned(Session) then
      Session.DoRequest(RequestJson, ResponseJson)
    else begin
  //    self.Logger.Log('TModuleUserUtils.DoRequest - Request:' + #13#10 + RequestJson.AsString);
      { process the request }
      methodName:= Lowercase(RequestJson.S['method']);
  //    Logger.Log('TModuleUserUtils.DoRequest - method name: ' + methodname,ltNone);
      idx:= Pos('.',methodName);
      if idx > 0 then
        methodName:= Copy(methodName,idx+1,Length(methodName));
      if methodName = 'startsession' then begin
  //      Logger.Log('TModuleUserUtils.DoRequest - start session',ltNone);
        { now look at params to see what sort of session this is ... }
        if RequestJson.ObjectExists('params') then begin
          if RequestJson.O['params'].S['sessiontype'] = 'config' then begin
  //          Logger.Log('TModuleUserUtils.DoRequest - config session',ltNone);
            ConfigSession:= TUserUtilsConfigSession.Create;
            ConfigSession.SessionType:= mstConfig;
            ConfigSession.Client:= Client;
            SessionList.AddSession(ConfigSession);
            if Assigned(ResponseJson) then
              ResponseJson.S['result']:= 'ok';
          end
          else if RequestJson.O['params'].S['sessiontype'] = 'client' then begin
  //          Logger.Log('TModuleUserUtils.DoRequest - config session',ltNone);
            ClientSession:= TUserUtilsClientSession.Create;
            ClientSession.SessionType:= mstClient;
            ClientSession.Client:= Client;
            SessionList.AddSession(ClientSession);
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

      end
      else if SameText(methodName,'BatchUpdate') then begin
  //      SessionList.Module.Lock;
        Lock;
        try
          ResponseJson.O['result'].I['TaskID']:=
  //          TModuleUserUtils(SessionList.Module).TaskList.StartTask(BATCH_UPDATE_TASK,RequestJson.O['params'].AsString,self);
            TaskList.StartTask(BATCH_UPDATE_TASK,RequestJson.O['params'].AsString);
        finally
  //        SessionList.Module.Unlock;
          Unlock;
        end;
      end;

  //    self.Logger.Log('TModuleUserUtils.DoRequest - Response:' + #13#10 + ResponseJson.AsString);
    end;
  finally
    self.RequestCount.Dec;
  end;
end;

procedure TModuleUserUtils.ForceLicenceCheck;
begin
  if Assigned(self.WorkerThread) then
    self.WorkerThread.NextValidateTime:= now;
end;

procedure TModuleUserUtils.ForceUpdate(DbListJsonText: string);
begin
  self.WorkerThread.ForceUpdate(DbListJsonText);
end;

procedure TModuleUserUtils.ForceUpdateCheck;
begin
  if Assigned(self.WorkerThread) then
    self.WorkerThread.NextUpdateCheckTime:= now;
end;

function TModuleUserUtils.GetConfigText: string;
begin
  result:= Config.AsString;
end;

function TModuleUserUtils.getSoftwareReleaseType: string;
begin
  self.Lock;
  try
    result:= Trim(self.ClientConfig.SoftwareReleaseType);
    if result = '' then
      result:= 'Production';
  finally
    self.Unlock;
  end;
end;

procedure TModuleUserUtils.LoadConfig(encrypt: boolean = false);
var
  msg: string;
  saveconfig: boolean;
begin
  saveconfig:= false;
  try
    inherited LoadConfig(encrypt);
  except
    on e: exception do begin
      if not ReencryptFile(AnsiString(ChangeFileExt(self.ModuleFileName, '_Config.cfg')),msg) then
        raise exception.Create('Error decrypting file: ' + msg);
      inherited LoadConfig(encrypt);
      saveconfig:= true;
    end;
  end;
  JsonToObj(Config.O['clientconfig'],ClientConfig);
  if self.ERPServerName = '' then
    self.ERPServerName:= ERP_HEAD_OFFICE_SERVER_NAME_DEFAULT;
  if self.ERPServerPort = 0 then
    self.ERPServerPort:= DEFAULT_TCP_PORT;
  if saveconfig then
    self.SaveConfig(encrypt);
end;

procedure TModuleUserUtils.SaveConfig(encrypt: boolean = false);
begin
  ObjToJson(ClientConfig,Config.O['clientconfig']);
  inherited SaveConfig(encrypt);
end;

procedure TModuleUserUtils.SetActive(const Value: boolean);
begin
  inherited;

end;

procedure TModuleUserUtils.SetConfigText(const Value: string);
begin
  Config.AsString:= Value;
end;

procedure TModuleUserUtils.SetERPServerName(const Value: string);
begin
  if FERPServerName <> Value then begin
    FERPServerName := Value;
    DoChange;
  end;
end;

procedure TModuleUserUtils.SetERPServerPort(const Value: integer);
begin
  if FERPServerPort <> Value then begin
    FERPServerPort := Value;
    DoChange;
  end;
end;

procedure TModuleUserUtils.Terminate;
begin
  Logger.Log(ClassName + '  Terminating',ltInfo);
  inherited;
  TaskList.TerminateTasks;
end;

{ TUserUtilsConfigSession }

constructor TUserUtilsConfigSession.Create;
begin

end;

procedure TUserUtilsConfigSession.DoRequest(RequestJson, ResultJson: TJsonObject);
var
  idx: integer;
  method: string;
begin
  method:= Lowercase(RequestJson.S['method']);
  idx:= Pos('.',method);
  if idx > 0 then
    method:= Copy(method,idx+1,Length(method));
  if method = 'forcelicencecheck' then begin
    SessionList.Module.Lock;
    try
      TModuleUserUtils(SessionList.Module).ForceLicenceCheck;
      ResultJson.B['result']:= true;
    finally
      SessionList.Module.Unlock;
    end;
  end
  else if method = 'forceupdatecheck' then begin
    SessionList.Module.Lock;
    try
      TModuleUserUtils(SessionList.Module).ForceUpdateCheck;
      ResultJson.B['result']:= true;
    finally
      SessionList.Module.Unlock;
    end;
  end
  else begin
    if Assigned(ResultJson) then begin
      ResultJson.O['error'].I['code']:= RPC_METHOD_NOT_FOUND;
      ResultJson.O['error'].S['message']:= 'Request method "' + method + '" not found.';
    end;
  end;
end;

{ TUserUtilsClientSession }

function TUserUtilsClientSession.CommsOkWithHeadOffice: boolean;
var
  lastCommsTime: TDateTime;
begin
  result:= true;
  SessionList.Module.Lock;
  try
    lastCommsTime:= TModuleUserUtils(SessionList.Module).Config.F['lastmastervalidationtime'];
  finally
    SessionList.Module.Unlock;
  end;
  if (lastCommsTime = 0) or ((lastCommsTime + PERIOD_NO_CONNECT_CANCEL) < now) then
      result:= false;
end;

constructor TUserUtilsClientSession.Create;
begin

end;

destructor TUserUtilsClientSession.Destroy;
begin
  RemoveUserLocks;
  { if this is an app user, delete from list }
  SessionList.Module.Lock;
  try
    TModuleUserUtils(SessionList.Module).AppUserList.RemoveUser(Integer(self));
  finally
    SessionList.Module.Unlock;
  end;
  inherited;
end;

procedure TUserUtilsClientSession.RemoveUserLocks;
var
//  Item: TAppUserItem;
  dbName, userName: string;
  conn: TMyConnection;
  cmd: TMyCommand;
  dbUserCount: integer;
begin
  SessionList.Module.Lock;
  try
//    Item:= TModuleUserUtils(SessionList.Module).AppUserList.ItemBySession[self];
//    if Assigned(Item) and (Item.DatabaseName <> '') then begin
//      userName:= Item.UserName;
//      dbName:= Item.DatabaseName;
//    end
//    else
//      exit;

    if not TModuleUserUtils(SessionList.Module).AppUserList.ItemByObjectRef(Integer(self),userName,dbName) then
      exit;
    dbUserCount := TModuleUserUtils(SessionList.Module).AppUserList.DatabaseUserCount(dbName,false);
    conn:= TMyConnection.Create(nil);
    cmd:= TMyCommand.Create(nil);
    try
      try
        cmd.Connection:= conn;
        conn.LoginPrompt:= false;
        conn.Port:= SERVER_PORT;
        conn.Options.Compress:= MYDAC_OPTIONS_COMPRESS;
        conn.Options.Protocol:= MYDAC_OPTIONS_PROTOCOL;
        conn.Username:= SYSDB_USER;
        conn.Password:= SYSDB_PASS;
        conn.Server:= 'localhost';
        conn.Database:= dbName;
        conn.Connect;
        if not conn.Connected then exit;
        { if noby else using this db clear out tblInUse to get rid of entries from crashed connections }
        if dbUserCount <= 1 then
          cmd.SQL.Text:=
            'truncate table tblInUse'
        else
          { just remove this user }
          cmd.SQL.Text:=
            'delete from tblInUse where Username = ' + QuotedStr(userName);
        cmd.Execute;
      except
      end;
    finally
      conn.Free;
      cmd.Free;
    end;
  finally
    SessionList.Module.Unlock;
  end;
end;

procedure DoDeleteFiles(const aFileNameMask: string);
var
  SearchRec: TSearchRec;
  Found: integer;
  sFile: string;
  sPath: string;
Begin
  { path may me in MySQL (linex) format so change to windows }
  sPath:= ExtractFilePath(StringReplace(aFileNameMask,'/','\',[rfReplaceAll]));
  Found := FindFirst(aFileNameMask, faAnyFile, SearchRec);
  try
    while (Found = 0) do begin
      if not (SearchRec.Attr and faDirectory > 0) then begin
        sFile := SearchRec.Name;
        SysUtils.DeleteFile(sPath + sFile);
      end;
      Found := SysUtils.FindNext(SearchRec);
    end;
  finally
    SysUtils.FindClose(SearchRec);
  end;
end;


procedure TUserUtilsClientSession.DoRequest(RequestJson,
  ResultJson: TJsonObject);
var
  method: string;
  idx: integer;
  FreeSpaceGigaBytes: double;
  reason: string;
  Licence: TSoftwareLicence;
  msg: string;
//  x: integer;
//  Json: TJsonObject;
  softwarename: string;
  DBBackup: TDBBackup;
  UpdateBaseDir: string;
  UpdateInfo, verList:TJsonObject;
  SoftwareReleaseType: string;
  TaskFinished, WasTaskError: boolean;
  TaskStart,TaskFinish: TDateTime;
  TaskMessage: string;
//  Mem1, Mem2: Cardinal;

begin
  { process the request }
//  self.SessionList.Module.Logger.Log('TUserUtilsClientSession.DoRequest - Request:' + #13#10 + RequestJson.AsString);
  method:= Lowercase(RequestJson.S['method']);
  idx:= Pos('.',method);
  if idx > 0 then
    method:= Copy(method,idx+1,Length(method));
  if method = 'ping' then begin
    ResultJson.S['result']:= 'ok';
    SessionList.Module.Lock;
    try
      TModuleUserUtils(SessionList.Module).AppUserList.UpdateItemLastTime(Integer(self));
    finally
      SessionList.Module.Unlock;
    end;
  end
  else if method = 'log' then begin
    { log somthing to the modules log file }
    if RequestJson.ObjectExists('params') and RequestJson.O['params'].StringExists('message') then begin
      try
        if RequestJson.O['params'].StringExists('type') then
          self.SessionList.Module.Logger.Log(RequestJson.O['params'].S['message'],
            StrToLogMessageType(RequestJson.O['params'].S['type']))
        else
          self.SessionList.Module.Logger.Log(RequestJson.O['params'].S['message']);
      except
      end;
    end;
  end
  else if method = 'validate' then begin
    { grant this user access to ERP? ... }
//    Mem1:= SystemLib.CurrentMemoryUsage;
//    SessionList.Module.Logger.Log('Begin "validate" Request',ltDetail);
    try
      if RequestJson.ObjectExists('params') then begin
//        self.SessionList.Module.Logger.Log('    Getting free disk space ...',ltDetail);
        FreeSpaceGigaBytes:= MySQLDriveFreeSpaceGigaBytes;
//        Mem2:= SystemLib.CurrentMemoryUsage;
//        self.SessionList.Module.Logger.Log('Validate Stage 1 Usage: ' + IntToStr(Mem2-Mem1),ltError);
 //       Mem1:= Mem2;
//        self.SessionList.Module.Logger.Log('    Free disk space = ' + FloatToStr(FreeSpaceGigaBytes) + 'Gb',ltDetail);
//        self.SessionList.Module.Logger.Log('    Checking communications with head office ...',ltDetail);
        if not CommsOkWithHeadOffice then begin
          ResultJson.O['result'].B['valid']:= false;
          ResultJson.O['result'].S['reason']:=
            'ERP Server Menu has been unable to communicate ' +
            'with ERP Head Office Server to validate your ERP licence information.' +
            #13#10 + #13#10 +
            'Please ensure that Ports 3309 (MySQL), 3310 (ERP) and 49500 (Server Menu)' +
            ' are open for communication both ways on your router, firewalls and ' +
            'virus scanner before contacting ERP';
//          self.SessionList.Module.Logger.Log('    No communication with head office',ltDetail);
        end
        else if (FreeSpaceGigaBytes <> -1) and (FreeSpaceGigaBytes < 2.0) then begin
          ResultJson.O['result'].B['valid']:= false;
          ResultJson.O['result'].S['reason']:=
            'There is less than 2Gb of free disk space available on the server where MySQL is installed, ' +
            'please free up at least 2Gb of space.';
//          self.SessionList.Module.Logger.Log('    Free disk space less than 2Gb',ltDetail);
        end
        else begin
//          self.SessionList.Module.Logger.Log('    Locking module ...',ltDetail);
//          Mem2:= SystemLib.CurrentMemoryUsage;
//          self.SessionList.Module.Logger.Log('Validate Stage 2 Usage: ' + IntToStr(Mem2-Mem1),ltError);
//          Mem1:= Mem2;
          SessionList.Module.Lock;
          try
            softwarename:= RequestJson.O['params'].S['softwarename'];
//            self.SessionList.Module.Logger.Log('    Reading licence information for software: "' + softwarename + '" ...',ltDetail);
            Licence:= TModuleUserUtils(SessionList.Module).ClientConfig.LicenceByName(GetPcName,softwarename);
//            Mem2:= SystemLib.CurrentMemoryUsage;
//            self.SessionList.Module.Logger.Log('Validate Stage 3 Usage: ' + IntToStr(Mem2-Mem1),ltError);
//            Mem1:= Mem2;
            if Assigned(Licence) then begin
              if not Licence.IsLicenced(reason) then begin
                ResultJson.O['result'].B['valid']:= false;
                ResultJson.O['result'].S['reason']:= reason;
//                SessionList.Module.Logger.Log('    Not licenced',ltDetail);
              end
              else begin
//                Mem2:= SystemLib.CurrentMemoryUsage;
//                self.SessionList.Module.Logger.Log('Validate Stage 4 Usage: ' + IntToStr(Mem2-Mem1),ltError);
//                Mem1:= Mem2;
                if TModuleUserUtils(SessionList.Module).AppUserList.DatabaseUserCount('') >= Licence.ConcurrentUsers then begin
                  ResultJson.O['result'].B['valid']:= false;
                  ResultJson.O['result'].S['reason']:=
                    'Maximum number of licensed users reached.';
//                  SessionList.Module.Logger.Log('    Max users exceeded',ltDetail);
                end
                else begin
//                  Mem2:= SystemLib.CurrentMemoryUsage;
//                  self.SessionList.Module.Logger.Log('Validate Stage 5 Usage: ' + IntToStr(Mem2-Mem1),ltError);
//                  Mem1:= Mem2;
//                  SessionList.Module.Logger.Log('    Adding user to list of logged in users ...',ltDetail);
                  if TModuleUserUtils(SessionList.Module).AppUserList.AddUser(
                      msg,
                      RequestJson.O['params'].S['user'],
                      RequestJson.O['params'].S['databasename'],
                      Integer(self),
                      RequestJson.O['params'].S['firstname'],
                      RequestJson.O['params'].S['lastname'],
                      RequestJson.O['params'].B['multilogon']) then begin
                    { all ok }
                    ResultJson.O['result'].B['valid']:= true;
                    ResultJson.O['result'].S['serverversion']:= GetFileVersion(Application.ExeName);
                    if ResultJson.O['result'].S['serverversion'] = '' then
                      ResultJson.O['result'].S['serverversion'] := '10.0.0.0';
                    ResultJson.O['result'].S['moduleversion']:= self.SessionList.Module.ModuleVersion;
  //                  { send notification to all other user sessions with new user list count }
  //                  for x:= 0 to TModuleUserUtils(SessionList.Module).AppUserList.Count -1 do begin
  //                    { dont send to session we are currently processing }
  //                    if TModuleUserUtils(SessionList.Module).AppUserList.Item[x].UserSession <> self then begin
  //                      Json:= JO;
  //                      Json.I['usercount']:=
  //                        TModuleUserUtils(SessionList.Module).AppUserList.Count;
  //                      TUserUtilsClientSession(TModuleUserUtils(SessionList.Module).AppUserList.Item[x].UserSession).Client.SendNotification('usercountchange',Json);
  //                    end;
  //                  end;
//                    Mem2:= SystemLib.CurrentMemoryUsage;
//                    self.SessionList.Module.Logger.Log('Validate Stage 6 Usage: ' + IntToStr(Mem2-Mem1),ltError);
//                    Mem1:= Mem2;
                  end
                  else begin
                    ResultJson.O['result'].B['valid']:= false;
                    ResultJson.O['result'].S['reason']:= msg;
//                    SessionList.Module.Logger.Log('    Could not add user',ltDetail);
                  end;
                end;
              end;
            end
            else begin
              { this is mainly to cater for older version of erp client ... so they can still log in  }
              if softwarename = '' then begin
                ResultJson.O['result'].B['valid']:= true;
                ResultJson.O['result'].S['serverversion']:= GetFileVersion(Application.ExeName);
                ResultJson.O['result'].S['moduleversion']:= self.SessionList.Module.ModuleVersion;
              end
              else begin
                ResultJson.O['result'].B['valid']:= false;
                ResultJson.O['result'].S['reason']:=
                  'No Licence information found for "' + RequestJson.O['params'].S['software'] +
                  '" on the server "' + GetPcName + '".';
//                self.SessionList.Module.Logger.Log('    No Licence information found',ltDetail);
              end;
            end;
          finally
//            self.SessionList.Module.Logger.Log('    Unlocking module ...',ltDetail);
            SessionList.Module.Unlock;
          end;

        end;
      end
      else begin
//        self.SessionList.Module.Logger.Log('    Params missing from request',ltDetail);
      end;
    finally
//      self.SessionList.Module.Logger.Log('End "validate" Request',ltDetail);
    end;
  end
  else if method = 'adduser' then begin
    { grant this user access to ERP? ... }
    if RequestJson.ObjectExists('params') then begin
      SessionList.Module.Lock;
      try
        if TModuleUserUtils(SessionList.Module).AppUserList.AddUser(
          msg,
          RequestJson.O['params'].S['user'],
          RequestJson.O['params'].S['databasename'],
          Integer(self),
          RequestJson.O['params'].S['firstname'],
          RequestJson.O['params'].S['lastname'],
          RequestJson.O['params'].B['multilogon']) then begin
          { all ok }
          ResultJson.O['result'].B['ok']:= true;
          ResultJson.O['result'].S['serverversion']:= GetFileVersion(Application.ExeName);
          ResultJson.O['result'].S['moduleversion']:= self.SessionList.Module.ModuleVersion;
        end;
      finally
        SessionList.Module.Unlock;
      end;
    end;
  end
  else if method = 'getlicence' then begin
    if RequestJson.ObjectExists('params') and RequestJson.O['params'].StringExists('softwarename') then begin
      SessionList.Module.Lock;
      try
        Licence:= TModuleUserUtils(SessionList.Module).ClientConfig.LicenceByName(GetPcName,RequestJson.O['params'].S['softwarename']);
      finally
        SessionList.Module.Unlock;
      end;
      if Assigned(Licence) then begin
        ObjToJson(Licence, ResultJson.O['result'].O['licence']);
      end
      else begin
        ResultJson.O['error']:= JO('{"code": '+ IntToStr(-1) +
          ', "message": "No licence info found for ' + RequestJson.O['params'].S['softwarename'] + '"}');
      end;
    end
    else begin
      ResultJson.O['error']:= JO('{"code": '+ IntToStr(-1) +
        ', "message": "Invalid params for getlicence request."}');
    end;
  end
//  else if method = 'getusercount' then begin
//    SessionList.Module.Lock;
//    try
//      ResultJson.O['result'].I['usercount']:=
//        TModuleUserUtils(SessionList.Module).AppUserList.Count;
//    finally
//      SessionList.Module.Unlock;
//    end;
//  end
  else if method = 'getdatabaseusercount' then begin
    SessionList.Module.Lock;
    try
      if RequestJson.O['params'].BooleanExists('ExcludeMultiLogonUsers') then
        ResultJson.O['result'].I['usercount']:=
          TModuleUserUtils(SessionList.Module).AppUserList.DatabaseUserCount(RequestJson.O['params'].S['databasename'],RequestJson.O['params'].B['ExcludeMultiLogonUsers'])
      else
        ResultJson.O['result'].I['usercount']:=
          TModuleUserUtils(SessionList.Module).AppUserList.DatabaseUserCount(RequestJson.O['params'].S['databasename']);
    finally
      SessionList.Module.Unlock;
    end;
  end
  else if method = 'locklogon' then begin
//    SessionList.Module.Logger.Log('Begin "locklogon" Request',ltDetail);
    if RequestJson.O['params'].S['lockreason'] <> '' then begin
//      SessionList.Module.Logger.Log('    Locking Module ...',ltDetail);
      SessionList.Module.Lock;
      try
//        SessionList.Module.Logger.Log('    Attempting to lock logon for:',ltDetail);
//        SessionList.Module.Logger.Log('        Database Name: ' + RequestJson.O['params'].S['databasename'],ltDetail);
//        SessionList.Module.Logger.Log('        Lock Reason: ' + RequestJson.O['params'].S['lockreason'],ltDetail);
        if TModuleUserUtils(SessionList.Module).AppUserList.LockLogon(msg,Integer(self),RequestJson.O['params'].S['databasename'],RequestJson.O['params'].S['lockreason']) then begin
          ResultJson.O['result'].B['ok']:= true;
          ResultJson.O['result'].S['reason']:= '';
//          SessionList.Module.Logger.Log('    Locked OK',ltDetail);
        end
        else begin
          ResultJson.O['result'].B['ok']:= false;
          ResultJson.O['result'].S['reason']:= msg;
//          SessionList.Module.Logger.Log('    Lock failed for reason: ' + msg,ltDetail);
//          SessionList.Module.Logger.Log('    User list: ' + TModuleUserUtils(SessionList.Module).AppUserList.UserNameList(''),ltDetail);
        end;
      finally
//        SessionList.Module.Logger.Log('    Unlocking Module ...',ltDetail);
        SessionList.Module.Unlock;
      end;
    end
    else begin
      ResultJson.O['error']:= JO('{"code": '+ IntToStr(-1) +
        ', "message": "Invalid params for locklogon request, lockreason missing."}');
//      SessionList.Module.Logger.Log('    Invalid request parameters',ltDetail);
    end;
//    SessionList.Module.Logger.Log('End "locklogon" Request',ltDetail);
  end
  else if method = 'unlocklogon' then begin
    SessionList.Module.Lock;
    try
      TModuleUserUtils(SessionList.Module).AppUserList.UnlockLogon(Integer(self));
    finally
      SessionList.Module.Unlock;
    end;
  end
  else if method = 'getuserlist' then begin
    SessionList.Module.Lock;
    try
      ResultJson.O['result'].S['userlist']:=
        TModuleUserUtils(SessionList.Module).AppUserList.UserNameList(RequestJson.O['params'].S['databasename']);
    finally
      SessionList.Module.Unlock;
    end;
  end
  else if method = 'getfulluserlist' then begin
    SessionList.Module.Lock;
    try
      ResultJson.O['result'].O['userlist'].Assign(
        TModuleUserUtils(SessionList.Module).AppUserList.ListAsJson);
    finally
      SessionList.Module.Unlock;
    end;
  end
  else if method = 'getbackuparchivelist' then begin
    DBBackup:= TDBBackup.Create;
    try
      ResultJson.S['result']:= DBBackup.ArchiveList;
    finally
      DBBackup.Free;
    end;
  end
  else if method = 'getdatabaselist' then begin
    DBBackup:= TDBBackup.Create;
    try
//      DBBackup.OnProgress:= DoOnBackupProgress;
      DBBackup.ServerName:= RequestJson.O['params'].S['servername'];
      ResultJson.S['result']:= DBBackup.DatabaseList(true);
    finally
      DBBackup.Free;
    end;
  end
  else if (method = 'dbbackup') then begin
    SessionList.Module.Lock;
    try
      ResultJson.O['result'].I['TaskID']:=
        TModuleUserUtils(SessionList.Module).TaskList.StartTask(DB_BACKUP_TASK,RequestJson.O['params'].AsString,self);
    finally
      SessionList.Module.Unlock;
    end;
  end
  else if (method = 'gettaskstatus') then begin
    SessionList.Module.Lock;
    try
      if TModuleUserUtils(SessionList.Module).TaskList.GetTaskStatus(RequestJson.O['params'].I['TaskID'],TaskFinished,WasTaskError,TaskStart,TaskFinish,TaskMessage) then begin
        ResultJson.O['result'].B['TaskFound']:= true;
        ResultJson.O['result'].B['TaskFinished']:= TaskFinished;
        ResultJson.O['result'].B['WasTaskError']:= WasTaskError;
        ResultJson.O['result'].DT['TaskStart']:= TaskStart;
        ResultJson.O['result'].DT['TaskFinish']:= TaskFinish;
        ResultJson.O['result'].S['TaskMessage']:= TaskMessage;
      end
      else begin
        ResultJson.O['result'].B['TaskFound']:= false;
      end;
    finally
      SessionList.Module.Unlock;
    end;
  end
  else if (method = 'removetask') then begin
    SessionList.Module.Lock;
    try
      TModuleUserUtils(SessionList.Module).TaskList.RemoveTask(RequestJson.O['params'].I['TaskID']);
      ResultJson.O['result'].S['Result']:= 'ok';
    finally
      SessionList.Module.Unlock;
    end;
  end
  else if method = 'forceupdatecheck' then begin
    SessionList.Module.Lock;
    try
      if RequestJson.O['params'].Count > 0 then
        TModuleUserUtils(SessionList.Module).ForceUpdate(RequestJson.O['params'].AsString)
      else
        TModuleUserUtils(SessionList.Module).ForceUpdateCheck;
      ResultJson.B['result']:= true;
    finally
      SessionList.Module.Unlock;
    end;
  end
  else if method = 'getuserupdateinfo' then begin
    UpdateBaseDir:= ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR + 'Updates\';
    SoftwareReleaseType:= Lowercase(TModuleUserUtils(SessionList.Module).SoftwareReleaseType);
    UpdateInfo:= TJsonObject.Create;
    try
      EncryptedFileToJson(UpdateInfo,UpdateBaseDir + 'erpupdatedetails.dat');
      verList:= UpdateInfo.O['updates'].O['erp'].O['versions'].O[SoftwareReleaseType];
      if verList.ObjectExists(RequestJson.O['params'].S['version']) then begin
        ResultJson.O['result'].S['module']:= 'erp';
        ResultJson.O['result'].S['softwarereleasetype']:= SoftwareReleaseType;
        ResultJson.O['result'].O['update'].Assign(verList.O[RequestJson.O['params'].S['version']]);
      end
      else begin
        ResultJson.O['error'].I['code']:= -1;
        ResultJson.O['error'].S['message']:= 'Update information not found.';
      end;
    finally
      UpdateInfo.Free;
    end;
  end
  else if method = 'getfileinfo' then begin
    JsonDoGetFileInfo(RequestJson, ResultJson);
  end
  else if method = 'getfilepart' then begin
    JsonDoGetFilePart(RequestJson, ResultJson);
  end
  else if method = 'deletefile' then begin
    if (not FileExists(RequestJson.O['params'].S['filename'])) or
       SysUtils.DeleteFile(RequestJson.O['params'].S['filename']) then
      ResultJson.B['result']:= true
    else
      ResultJson.B['result']:= false;
  end
  else if method = 'deletefiles' then begin
    DoDeleteFiles(RequestJson.O['params'].S['filename']);
  end
  else begin
    if Assigned(ResultJson) then begin
      ResultJson.O['error'].I['code']:= RPC_METHOD_NOT_FOUND;
      ResultJson.O['error'].S['message']:= 'Request method "' + method + '" not found.';
    end;
  end;
//  self.SessionList.Module.Logger.Log('TUserUtilsClientSession.DoRequest - Response:' + #13#10 + ResultJson.AsString);
end;

//procedure TUserUtilsClientSession.DoOnBackupProgress(Sender: TObject);
//var
//  DBBackup: TDBBackup;
//  json: TJsonObject;
//begin
//  DBBackup:= TDBBackup(Sender);
//  json:= JO;
//  json.S['taskname']:= 'backup';
//  ObjToJson(DBBackup.Progress,Json.O['progress']);
//  Client.SendNotification('progress',json);
//end;

//procedure TUserUtilsClientSession.DoOnRestoreProgress(Sender: TObject);
//var
//  DBBackup: TDBBackup;
//  json: TJsonObject;
//begin
//  DBBackup:= TDBBackup(Sender);
//  json:= JO;
//  json.S['taskname']:= 'restore';
//  ObjToJson(DBBackup.Progress,Json.O['progress']);
//  Client.SendNotification('progress',json);
//end;

//procedure TUserUtilsClientSession.DoOnCopyProgress(Sender: TObject);
//var
//  DBBackup: TDBBackup;
//  json: TJsonObject;
//begin
//  DBBackup:= TDBBackup(Sender);
//  json:= JO;
//  json.S['taskname']:= 'copy';
//  ObjToJson(DBBackup.Progress,Json.O['progress']);
//  Client.SendNotification('progress',json);
//end;

//procedure TUserUtilsClientSession.DoOnRemoveProgress(Sender: TObject);
//var
//  DBBackup: TDBBackup;
//  json: TJsonObject;
//begin
//  DBBackup:= TDBBackup(Sender);
//  json:= JO;
//  json.S['taskname']:= 'remove';
//  ObjToJson(DBBackup.Progress,Json.O['progress']);
//  Client.SendNotification('progress',json);
//end;

{ TUserUtilsThread }

constructor TUserUtilsThread.Create(aModule: TModuleUserUtils);
begin
  fDbListJsonText:= '';
  fLock:= TCriticalSection.Create;
  Module:= aModule;
  inherited Create(false);
  Priority:= tpLower;
  FreeOnTerminate:= false;
  ERPClient:= TJsonRpcTcpClient.Create;
  ERPClient.OnConnect:= DoOnConnect;
  ERPClient.OnDisconnect:= DoOnDisconnect;
  ERPClient.OnRequest:= DoOnRequest;
  NextValidateTime:= now + OneMinute;
  NextUpdateCheckTime:= now + (OneMinute * 10);
  NextPingCheckTime:= now + (OneMinute * 15);
  fNextInactiveUserCheckTime:= now + USER_INACTIVITY_CHECK_INTERVAL;
  fNextTaskListCheckTime := now + OneMinute;
  fNextEmailCheckTime := now + EmailCheckInterval; //(OneMinute / 2);
end;

destructor TUserUtilsThread.Destroy;
begin
  fLock.Free;
  inherited;
end;

procedure TUserUtilsThread.DoOnConnect(Client: TJsonRpcBase);
begin

end;

procedure TUserUtilsThread.DoOnDisconnect(Client: TJsonRpcBase);
begin

end;

procedure TUserUtilsThread.DoOnEmailProgress(const msg: string;
  var Continue: boolean);
begin
  Continue := (Module.Status = msRunning);
  if Continue then begin
    Module.Logger.Log(MailReader.Connection.Database + ' ' + MailReader.EmailAddress + ' ' + msg, ltDetail);
  end
  else begin
    Module.Logger.Log(ClassName + ' terminated, aborting email check during OnProgress event.',ltDetail);
  end;
end;

procedure TUserUtilsThread.DoOnRequest(Client: TJsonRpcBase; ReqJson,
  ResJson: TJSONObject);
begin

end;

{ assumes 2009-08-20 format }
function MySQLDateStrToDateTime(s: string): TDateTime;
begin
  result:= 0;
  if Length(s) = 10 then begin
    try
      result:= EncodeDate(StrToInt(Copy(s,1,4)),StrToInt(Copy(s,6,2)),StrToInt(Copy(s,9,2)));
    except
      result:= 0;
    end;
  end;
end;

procedure TUserUtilsThread.DoWork;
var
  StoredConfig: TClientConfig;
  configChanged: boolean;
  Sig: TJsonObject;
//  OldLicence: TJsonObject;
  pcName: string;
  thisPc: TComputer;
  ComputerConfig: TComputerConfig;
  SoftwareLicence: TSoftwareLicence;
  LastMasterValidationTime: TDateTime;
  msg: string;
  req, resp: TJsonObject;
  ErpInfo: TJsonObject;
  Updater: TErpDbUpdater;
  ErpMaint: TErpMaint;
  x: integer;
  Lst: TList;
  item: TThreadTaskBase;
  idList: TIntegerList;
  dbList: TERPDbList;
  qry: TERPQuery;
begin
  { this is to keep server network card awake }
  if NextPingCheckTime <= now then begin
    NextPingCheckTime:= now + (OneMinute * 15);
    InternetAccessOk(false);
  end;

  if fNextEmailCheckTime <= now then begin
    try
      Module.Logger.Log('Starting email check ...',ltDetail);
      dbList := TERPDbList.Create('localhost');
      try
       if dbList.First then begin
         qry := TERPQuery.Create(nil);
         MailReader := TMailReader.Create;
         MailReader.OnProgress := DoOnEmailProgress;
         try
           qry.SQL.Text := 'select * from tblEmailConfig where ConfigValid = "T"';
           repeat
             if (Module.Status <> msRunning) then begin
               Module.Logger.Log(ClassName + ' terminated, aborting email check.',ltDetail);
               exit;
             end;
             qry.Connection := dbList.Connection;
             qry.Open;
             try
               while not qry.Eof do begin
                 if (Module.Status <> msRunning) then begin
                   Module.Logger.Log(ClassName + ' terminated, aborting email check.',ltDetail);
                   exit;
                 end;
                 MailReader.Connection := dbList.Connection;
                 MailReader.Config.AsString := qry.FieldByName('ConfigJSON').AsString;
                 MailReader.EmailAddress := qry.FieldByName('EmailAddress').AsString;

                 if not MailReader.GetMail(msg) then
                   Module.Logger.Log('Error checking emails for ' + MailReader.Connection.Database + ' ' + MailReader.EmailAddress + ': ' + msg,ltError);
                 qry.Next;
               end;

             finally
               qry.Close;
             end;
           until not dbList.Next;
         finally
           qry.Free;
           MailReader.Free;
         end;
       end;
      finally
        dbList.Free;
        fNextEmailCheckTime := now + EmailCheckInterval;
        Module.Logger.Log('Finished email check.',ltDetail);
      end;
    except
      on e: exception do begin
        Module.Logger.Log('Error checking emails: ' + e.Message,ltError);
      end;
    end;
  end;

  if (Module.Status <> msRunning) then begin
    Module.Logger.Log(ClassName + ' terminated, aborting all checks.',ltDetail);
    exit;
  end;

  if NextValidateTime <= now then begin
    NextValidateTime:= now + PERIOD_VALIDATION_CHECK;
    configChanged:= false;

    { if we dont have erp databasees on this machine we dont need to
      check licence of do updates }
    if not GetERPDatabaseInfo(ErpInfo) then begin
      if Assigned(ErpInfo) then begin
        Module.Logger.Log('Error checking ERP databases on this computer: ' + #13#10 +
          '          "' + ErpInfo.S['error'] + '"' + #13#10 +
          '          ' + 'Aborting licence check.',ltError);
        ErpInfo.Free;
      end
      else begin
        Module.Logger.Log('No ERP database found on this computer, aborting licence check.',ltError);
      end;
      exit;
    end;

    { have a look at the current stored licence config info }
    StoredConfig:= TClientConfig.Create;
    try

      Module.Lock;
      try
        ObjToObj(Module.ClientConfig,StoredConfig);
        LastMasterValidationTime:= Module.Config.F['lastmastervalidationtime'];
      finally
        Module.Unlock;
      end;

      { first check for changes aginst current machine config }
      if StoredConfig.ServerList.Count = 0 then begin
        { we don't have any info so create new }
        configChanged:= true;
        StoredConfig.Name:= 'UNKNOWN';
        StoredConfig.SoftwareReleaseType:= 'Production';
        StoredConfig.Active:= true;
        StoredConfig.Id:= 0;
        StoredConfig.User:= UPDATE_USER;
        StoredConfig.DateTime:= NowUTC;
      end
      else begin
        { we have an existing config so we don't need to check so frequently }
        NextValidateTime:= now + PERIOD_VALIDATION_CHECK;
      end;

      { we have a list of computers }
      pcName:= GetPCName;
      thisPc:= StoredConfig.ServerList.ByName(pcName);
      if not Assigned(thisPc) then begin
        { get pc info }
        configChanged:= true;
        thisPc:= StoredConfig.ServerList.Add;
        thisPc.ComputerName:= pcName;
        thisPc.Id:= 0;
        thisPc.Active:= true;
        thisPc.ClientId:= 0;
        thisPc.User:= UPDATE_USER;
        thisPc.DateTime:= NowUTC;
      end;
      if thisPc.ConfigList.Count = 0 then begin
        configChanged:= true;
        ComputerConfig:= thisPc.ConfigList.Add;
        ComputerConfig.Id:= 0;
        ComputerConfig.ComputerId:= thisPc.Id;
        ComputerConfig.Active:= true;
        ComputerConfig.User:= UPDATE_USER;
        ComputerConfig.DateTime:= NowUTC;
      end
      else
        ComputerConfig:= TComputerConfig(thisPc.ConfigList.Items[thisPc.ConfigList.Count-1]);

      { now signature }
      sig:= GetMachineSignature;
      try
        if ComputerConfig.Id < 1 then begin
          ComputerConfig.Text:= sig.AsString;
        end
        else begin
          if ComputerConfig.Text <> sig.AsString then begin
            { add a new config record }
            configChanged:= true;
            ComputerConfig:= thisPc.ConfigList.Add;
            ComputerConfig.Id:= 0;
            ComputerConfig.ComputerId:= thisPc.Id;
            ComputerConfig.Active:= true;
            ComputerConfig.Text:= sig.AsString;
            ComputerConfig.User:= UPDATE_USER;
            ComputerConfig.DateTime:= NowUTC;
          end;
        end;
      finally
        sig.Free;
      end;

      { now licence info }
      SoftwareLicence:= thisPc.LicenceList.ByName('ERP');
      if not Assigned(SoftwareLicence) then begin
        configChanged:= true;
        SoftwareLicence:= thisPc.LicenceList.Add;
        SoftwareLicence.SoftwareName:= 'ERP';
        SoftwareLicence.Status:= lsUnknown;
        SoftwareLicence.StatusReason:= 'Unknown licence status';
        SoftwareLicence.Active:= false;
        SoftwareLicence.Id:= 0;
        SoftwareLicence.ComputerId:= thisPc.Id;
        SoftwareLicence.User:= UPDATE_USER;
        SoftwareLicence.DateTime:= NowUTC;
      end;

      if SoftwareLicence.Data.O['erpinfo'].AsString <> ErpInfo.AsString then begin
        SoftwareLicence.Data.O['erpinfo'].AsString:= ErpInfo.AsString;
        SoftwareLicence.User:= UPDATE_USER;
        SoftwareLicence.DateTime:= NowUTC;
        configChanged:= true;
      end;

      if StartERPServerSession(msg) then begin
        try
          Module.Logger.Log('Communicating with ERP server.',ltDetail);
          req:= JO;
          ObjToJson(StoredConfig,req);
          resp:= ERPClient.SendRequest('ClientServer.clientconfig',req);
          if Assigned(resp) then begin
            try
              if resp.ObjectExists('result') then begin

                if ConfigChanged or
                   (resp.O['result'].AsString <> ObjToStr(StoredConfig)) then begin


                  if ConfigChanged then
                    Module.Logger.Log('    Sent updated config information to ERP server.',ltDetail)
                  else
                    Module.Logger.Log('    Updated config information received from ERP server.',ltDetail);


                  { need to update config }
                  JsonToObj(resp.O['result'],StoredConfig);

                  { write config info back }
                  Module.Lock;
                  try
                    ObjToObj(StoredConfig,Module.ClientConfig);
                    LastMasterValidationTime:= now;
                    Module.Config.F['lastmastervalidationtime']:= LastMasterValidationTime;
                    Module.SaveConfig(true);
                  finally
                    Module.Unlock;
                  end;
                end
                else begin
                  { update the time }
                  Module.Lock;
                  try
                    LastMasterValidationTime:= now;
                    Module.Config.F['lastmastervalidationtime']:= LastMasterValidationTime;
                    Module.SaveConfig(true);
                  finally
                    Module.Unlock;
                  end;
                end;
              end
              else begin
                if resp.ObjectExists('error') then begin
                  Module.Logger.Log('    Error respone received while sending' +
                    ' client config with message: ' + resp.O['error'].S['message'],ltWarning);
                end
                else begin
                  Module.Logger.Log('    Unrecognised response received from ERP Head Office server when sending registration data.',ltWarning);
                end;
              end;
            finally
              resp.Free;
            end;
          end
          else begin
            Module.Logger.Log('    No response received from ERP Head Office server when sending registration data.',ltWarning);
          end;
        finally
          ERPClient.Connected:= false;
          Module.Logger.Log('Finished communicating with ERP server.',ltDetail);
        end;
      end
      else begin
        Module.Logger.Log('Could not establish a connection with ERP Head Office server with message: ' + msg,ltWarning);
      end;

      if Assigned(SoftwareLicence) then begin
        case SoftwareLicence.Status of
          lsUnknown, lsPending, lsHold, lsReview:
            NextValidateTime:= now + PERIOD_REVALIDATION_CHECK;
          lsLicenced, lsCancelled: ;  { default to normal check interval }
        end;
      end;


      if (LastMasterValidationTime > 0) and
        ((now - LastMasterValidationTime) >= PERIOD_NO_CONNECT_CANCEL) then begin
        { been trying to send info back to ERP head office for too long ...
          invalidate licence and give reason }
        Module.Logger.Log('Could not establish a connection with ERP Head Office ' +
          'server after trying for a number of days.',ltError);
      end;


    finally
      StoredConfig.Free;
      ErpInfo.Free;
    end;
  end;

  if now > fNextInactiveUserCheckTime then begin
//    Module.AppUserList.Lock;
    try
      Module.AppUserList.RemoveInactiveUsers(MAX_USER_INACTIVITY_TIME);
    finally
//      Module.AppUserList.Unlock;
    end;

    fNextInactiveUserCheckTime:= now + USER_INACTIVITY_CHECK_INTERVAL;
  end;

  if now >= NextUpdateCheckTime then begin
    try
      ErpMaint:= TErpMaint.Create;
      try
       ErpMaint.Logger:= Module.Logger;
       ErpMaint.DatabaseList.AsString:= self.fDbListJsonText;
       ErpMaint.DoMaint;
      finally
        ErpMaint.Free;
      end;

      Updater:= TErpDbUpdater.Create(Module.getSoftwareReleaseType,Module.Logger);
      try
        Updater.DatabaseList.AsString:= self.fDbListJsonText;
        Updater.CheckForUpdates;
      finally
        Updater.Free;
      end;
    finally
      fDbListJsonText:= '';
      { set next check to be between 1 and 2 am.
        ERPUtilsService will check for service/module updates between
        midnight and 00:45 }
      NextUpdateCheckTime:= Trunc(now) + 1 + (1/24);  { 1am next day}
      Randomize;
      { add 0 to 60 random minutes }
      NextUpdateCheckTime:= NextUpdateCheckTime + (Random(60) * (1/24/60));
    end;
  end;

  if now > fNextTaskListCheckTime then begin
    Module.Lock;
    try
      Lst := Module.TaskList.ThreadList.LockList;
      idList := TIntegerList.Create;
      try
        for x := 0 to Lst.Count -1 do begin
          item := TThreadTaskBase(Lst[x]);
//          Module.Logger.Log('Task found: ' + item.ClassName +
//          ' Start Time: ' + DateTimeToStr(item.StartTime) +
//          ' Finish Time: ' + DateTimeToStr(item.FinishTime) +
//          ' Finished: ' + BoolToStr(item.Finished,true) +
//          ' Status: ' + item.StatusMessage
//          ,ltWarning);
          if item.Finished and (item.FinishTime > 0) and (now > (item.FinishTime + OneMinute)) then begin
            { task finished more than one minute ago so we can remov it }
            idList.Add(item.TaskId);
          end;
        end;
      finally
        Module.TaskList.ThreadList.UnlockList;
        if idList.Count > 0 then begin
          for x:= 0 to idList.Count -1 do
            Module.TaskList.RemoveTask(idList[x]);
        end;
        idList.Free;
      end;
    finally
      Module.Unlock;
    end;
    fNextTaskListCheckTime := now + OneMinute;
  end;
end;

procedure TUserUtilsThread.Execute;
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


procedure TUserUtilsThread.ForceUpdate(DbListJsonText: string);
begin
  fLock.Acquire;
  try
    fDbListJsonText:= DbListJsonText;
    fNextUpdateCheckTime:= now + (1/24/60/60) * 10; { wait 10 seconds }
  finally
    fLock.Release;
  end;

end;

function TUserUtilsThread.GetNextUpdateCheckTime: TDateTime;
begin
  fLock.Acquire;
  try
    result:= fNextUpdateCheckTime
  finally
    fLock.Release;
  end;
end;

function TUserUtilsThread.GetNextValidateTime: TDateTime;
begin
  fLock.Acquire;
  try
    result:= fNextValidateTime
  finally
    fLock.Release;
  end;
end;

procedure TUserUtilsThread.SetNextUpdateCheckTime(const Value: TDateTime);
begin
  fLock.Acquire;
  try
    fNextUpdateCheckTime:= Value;
  finally
    fLock.Release;
  end;
end;

procedure TUserUtilsThread.SetNextValidateTime(const Value: TDateTime);
begin
  fLock.Acquire;
  try
    fNextValidateTime:= Value;
  finally
    fLock.Release;
  end;
end;

function TUserUtilsThread.StartERPServerSession(var msg: string): boolean;
var
  o, resp: TJsonObject;
begin
  msg:= '';
  result:= ERPClient.Connected;
  if result then
    exit;
  Module.Lock;
  try
    ERPClient.ServerName:= Module.ERPServerName;
//    ERPClient.ServerName:= 'localhost';
    ERPClient.Port:= Module.ERPServerPort;
  finally
    Module.Unlock;
  end;
  try
    ERPClient.Connected:= true;
  except
    on ex: exception do begin
      try
        ERPClient.ServerName:= 'ERPServer1';
        ERPClient.Connected:= true;
      except
        try
          ERPClient.ServerName:= 'Server1';
          ERPClient.Connected:= true;
        except
          on e: exception do begin
            msg:= e.Message;
          end;
        end;
      end;
    end;
  end;
  if ERPClient.Connected then begin
    o:= JO;
    o.S['sessiontype']:= 'client';
    //o.S['clientname']:= '';
    resp:= ERPClient.SendRequest('ClientServer.StartSession',o);
    if Assigned(resp) then begin
      try
        if resp.StringExists('result') and (resp.S['result'] = 'ok') then begin
          //
        end
        else begin
          { failed to establisg a session }
          ERPClient.Connected:= false;
          msg:= 'Could not establish a session with the ERP server.';
        end;
      finally
        resp.Free;
      end;
    end
    else begin
      ERPClient.Connected:= false;
      msg:= 'No response received from ERP server.';
    end;
  end;
  result:= ERPClient.Connected;
end;

initialization
  if not Assigned(fModuleUserUtils) then
    fModuleUserUtils:= TModuleUserUtils.Create;

finalization
  fModuleUserUtils.Free;
  fModuleUserUtils:= nil;

end.
