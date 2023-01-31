unit ModuleUpdaterObj;

interface

uses
  ModuleBaseServerObj, forms, classes,
  JsonObject, JsonRpcBase,
  FileDownloadFuncs;

type

  TUpdaterThread = class;
  TModuleUpdater = class(TModuleBaseServer)
  private
    WorkerThread: TUpdaterThread;
    function GetConfigText: string;
    procedure SetConfigText(const Value: string);
    function GetUpdateDetailsText: string;
    procedure SetUpdateDetailsText(const Value: string);
    function getSettingsText: string;
    procedure SetSettingsText(const Value: string);
  protected
    procedure DoChange; override;
    procedure SetActive(const Value: boolean); override;
  public
    Config: TJsonObject;
    constructor Create; override;
    destructor Destroy; override;
    procedure DoRequest(Client: TJsonRpcBase; RequestJson: TJsonObject;
      ResponseJson: TJsonObject = nil); override;
    property UpdateDetailsText: string read GetUpdateDetailsText write SetUpdateDetailsText;
    property SettingsText: string read getSettingsText write SetSettingsText;
    function DownloadPath: string;
  published
    property ConfigText: string read GetConfigText write SetConfigText;
  end;

  TUpdaterConfigSession = class(TModuleSession)
  private
    fUpdatingModule: boolean;
  public
    constructor Create;
    procedure DoRequest(RequestJson: TJsonObject; ResultJson: TJsonObject = nil); override;
    property UpdatingModule: boolean read fUpdatingModule write fUpdatingModule;
  end;

  TUpdaterClientSession = class(TModuleSession)
  private
  public
    constructor Create;
    procedure DoRequest(RequestJson: TJsonObject; ResultJson: TJsonObject = nil); override;
  end;

  TUpdaterThread = class(TThread)
  private
  private
    Module: TModuleUpdater;
    fIsTerminated: boolean;
    NextWebCheckTime: TDateTime;
    NextUpdateCheckTime: TDateTime;
    UpdateDetails: TJsonObject;
    Settings: TJsonObject;
//    DownloadPath: string;
    Downloader: TFileDownloader;
    procedure DoWork;
    function NewUpdateFileDownloaded: boolean;
    procedure DownloadLatestFromWeb;
//    procedure PerformUpdates;
    function ModuleActive: boolean;
    procedure OnDataTransferProgress(percent: integer);
//    function CheckUpdateItem(aItem: TJsonObject; aName: string): boolean;
  protected
    procedure Execute; override;
  public
    constructor Create(aModule: TModuleUpdater); reintroduce;
    destructor Destroy; override;
    property IsTerminated: boolean read fIsTerminated;
  end;

  function GetModule(MainAppInst: TApplication): TModuleBaseServer;


implementation

uses
  sysutils, LogMessageTypes, JsonRPCConst, JsonToObject, ModuleUtils,
  ModuleUpdaterConst, dbUtils;

var
  fModuleUpdater: TModuleUpdater;

function GetModule(MainAppInst: TApplication): TModuleBaseServer;
begin
  fModuleUpdater.AppInst:= MainAppInst;
  result:= fModuleUpdater;
end;

function TimeToCheckForUpdate(LastCheckTime: TDateTime; Schedule: TJsonObject): boolean;
var
  dayname: string;
  timeList: TJSONArray;
  x: integer;
  dt: TDateTime;
begin
  result:= false;
  timeList:= nil;
  if Schedule.ObjectExists('days') then begin
    dayname:= Lowercase(FormatDateTime('dddd',now));
    if Schedule.O['days'].ObjectExists('all') then
      timeList:= Schedule.O['days'].O['all'].A['times']
    else if Schedule.O['days'].ObjectExists(dayname) then
      timeList:= Schedule.O['days'].O[dayname].A['times'];
    if Assigned(timeList) then begin
      for x:= 0 to timeList.Count -1 do begin
        dt:= Date + StrToTime(timeList.Items[x].AsString);
        if (dt > LastCheckTime) and (dt >= now) then begin
          result:= true;
          break;
        end;
      end;
    end;
  end;
end;


{ TModuleUpdater }

constructor TModuleUpdater.Create;
begin
  Config:= TJsonObject.Create;
  { set defaults }
  if not Config.O['settings'].FloatExists('webcheckinterval') then
    Config.O['settings'].F['webcheckinterval']:= 1/24/60; // one min
  if not Config.O['settings'].FloatExists('updatecheckinterval') then
    Config.O['settings'].F['updatecheckinterval']:= 1/24/60; // one min
  if not Config.O['settings'].StringExists('versiontype') then
    Config.O['settings'].S['versiontype']:= 'beta';

  inherited;
  try
    fModuleName:= 'Updater';
    fModuleDescription:= 'Module to update various ERP components';
    LoadConfig;
    WorkerThread:= TUpdaterThread.Create(self);
  except
    on e: exception do begin
      if Assigned(Logger) then
        Logger.Log('Error creating TModuleUpdater object with message: ' + e.Message, ltError);

    end;
  end;
end;

destructor TModuleUpdater.Destroy;
begin
  self.SaveConfig;
  if Assigned(WorkerThread) then begin
    WorkerThread.Terminate;
    while not WorkerThread.IsTerminated do
      sleep(10);
    WorkerThread.Free;
  end;
  Config.Free;
  inherited;
end;

procedure TModuleUpdater.DoChange;
begin
  inherited;

end;

procedure TModuleUpdater.DoRequest(Client: TJsonRpcBase; RequestJson,
  ResponseJson: TJsonObject);
var
  Session: TModuleSession;
  ConfigSession: TUpdaterConfigSession;
  ClientSession: TUpdaterClientSession;
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
          ConfigSession:= TUpdaterConfigSession.Create;
          ConfigSession.SessionType:= mstConfig;
          ConfigSession.Client:= Client;
          SessionList.AddSession(ConfigSession);
          if Assigned(ResponseJson) then
            ResponseJson.S['result']:= 'ok';
        end
        else if RequestJson.O['params'].S['sessiontype'] = 'client' then begin
          ClientSession:= TUpdaterClientSession.Create;
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

    end;
  end;
end;

function TModuleUpdater.DownloadPath: string;
begin
  result:= ExtractFileDrive(ModulePath) + '\' +ServerDownloadPath;

end;

function TModuleUpdater.GetConfigText: string;
begin
  result:= Config.AsString;
end;

function TModuleUpdater.GetSettingsText: string;
begin
  result:= Config.O['settings'].AsString;
end;

function TModuleUpdater.GetUpdateDetailsText: string;
begin
  result:= Config.O['updatedetails'].AsString;
end;

procedure TModuleUpdater.SetActive(const Value: boolean);
begin
  inherited;
  if Value then
    SendStatus('Started')
  else
    SendStatus('Stopped');
end;

procedure TModuleUpdater.SetConfigText(const Value: string);
begin
  Config.AsString:= Value;
  DoChange;
end;

procedure TModuleUpdater.SetSettingsText(const Value: string);
begin
  Config.O['settings'].AsString:= Value;
  DoChange;
end;

procedure TModuleUpdater.SetUpdateDetailsText(const Value: string);
begin
  Config.O['updatedetails'].AsString:= Value;
  DoChange;
end;

{ TUpdaterConfigSession }

constructor TUpdaterConfigSession.Create;
begin

end;

procedure TUpdaterConfigSession.DoRequest(RequestJson,
  ResultJson: TJsonObject);
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
  end
  else if method = 'getfileinfo' then begin
    JsonDoGetFileInfo(RequestJson, ResultJson);
  end
  else if method = 'getfilepart' then begin
    JsonDoGetFilePart(RequestJson, ResultJson);
  end;
end;

{ TUpdaterThread }

constructor TUpdaterThread.Create(aModule: TModuleUpdater);
begin
  fIsTerminated:= false;
  NextWebCheckTime:= now;
  NextUpdateCheckTime:= now;
  Module:= aModule;
  UpdateDetails:= TJsonObject.Create;
  Settings:= TJsonObject.Create;
//  DownloadPath:=   ExtractFileDrive(Module.ModulePath) + '\' +ServerDownloadPath;
  inherited Create(false);
  Priority:= tpLower;
  FreeOnTerminate:= false;
end;

destructor TUpdaterThread.Destroy;
begin
  Settings.Free;
  UpdateDetails.Free;
  inherited;
end;

procedure TUpdaterThread.DoWork;
begin
  Sleep(50);
  if not ModuleActive then exit;

  { check for newer version of master update details file on the web }
  if now >= NextWebCheckTime then begin
    try
      if not ForceDirectories(Module.DownloadPath) then begin
        Module.Logger.Log('Could not create download directory: "' +
        Module.DownloadPath  + '".',ltError);
        exit;
      end;
      if NewUpdateFileDownloaded then begin
        Module.Lock;
        try
          UpdateDetails.LoadFromFile(Module.ModulePath + WebUpdateDataFile);
          Module.UpdateDetailsText:= UpdateDetails.AsString;
        finally
          Module.Unlock;
        end;
      end;
      DownloadLatestFromWeb;
    finally
      Module.Lock;
      try
        NextWebCheckTime:= now + Module.Config.O['settings'].F['webcheckinterval'];
      finally
        Module.Unlock;
      end;
      Module.SendStatus('Waiting ...');
    end;
  end;
//  if now >= NextUpdateCheckTime then begin
//    try
//      PerformUpdates;
//    finally
//      Module.Lock;
//      try
//        NextUpdateCheckTime:= now + Module.Config.O['settings'].F['updatecheckinterval'];
//      finally
//        Module.Unlock;
//      end;
//      Module.SendStatus('Waiting ...');
//    end;
//  end;
end;

procedure TUpdaterThread.Execute;
begin
  inherited;
  Module.Lock;
  try
    UpdateDetails.AsString:= Module.UpdateDetailsText;
  finally
    Module.Unlock;
  end;
  while not Terminated do begin
    try
      DoWork;
    except
      on e: Exception do begin
        Module.Logger.Log('Exception: ' + e.Message,ltError);
      end;
    end;
  end;
  fIsTerminated:= true;
end;

function TUpdaterThread.ModuleActive: boolean;
begin
  Module.Lock;
  try
    result:= Module.Active;
  finally
    Module.Unlock;
  end;
end;

function TUpdaterThread.NewUpdateFileDownloaded: boolean;
begin
  result:= false;
  Module.Logger.Log('Checking for new version of Update Information file ...',ltDetail);
  Downloader:= TFileDownloader.Create;
  try
    Downloader.URL:= WebUpdateSiteURL + '/' + WebUpdateDataFile;
    Downloader.FileName:= Module.ModulePath + WebUpdateDataFile;
    Downloader.FileReplaceOption:= frReplaceIfNewer;
    Downloader.DoDownload;
    case Downloader.DownloadResult of
      drNone:
        begin
          Module.Logger.Log('Could not download file - unknown reason.',ltWarning);
        end;
      drConnectFailed:
        begin
          Module.Logger.Log('Could not download file - connection to download web site failed.',ltWarning);
        end;
      drReplaceNotRequired:
        begin
          Module.Logger.Log('No download required - local file is up to date.',ltDetail);
        end;
      drDownloadFailed:
        begin
          Module.Logger.Log('Could not download file - failed during download.',ltWarning);
        end;
      drFileReplaced:
        begin
          Module.Logger.Log('Newer version of file downloaded ok.',ltDetail);
          result:= true;
        end;
    end;
  finally
    Downloader.Free;
  end;
end;

procedure TUpdaterThread.DownloadLatestFromWeb;
var
  itemIdx, verIdx, fileIdx: integer;
  item, ver: TJsonObject;
  versiontype: string;
  url: string;
  localPath: string;
  filename: string;
begin
  Module.Lock;
  try
    versiontype:= Module.Config.O['settings'].S['versiontype']
  finally
    Module.Unlock;
  end;

  for itemIdx:= 0 to UpdateDetails.O['updates'].Count -1 do begin
    if not ModuleActive then begin
      Module.SendStatus('Stopped');
      break;
    end;
    item:= TJsonObject(UpdateDetails.O['updates'].Items[itemIdx].Value);
    url:= item.S['url'];
    localPath:= Module.DownloadPath + '\' + versiontype + url;
    localPath:= StringReplace(localPath,'/','\',[rfReplaceAll]);
    if not ForceDirectories(localPath) then begin
      Module.Logger.Log('Could not create download directory: "' +
      localPath  + '".',ltError);
      break;
    end;
    for verIdx:= 0 to item.O['versions'].O[versiontype].Count -1 do begin
      ver:= TJsonObject(item.O['versions'].O[versiontype].Items[verIdx].Value);
      for fileIdx:= 0 to ver.A['files'].Count -1 do begin
        filename:= ver.A['files'].Items[fileIdx].AsString;
//        if (not FileExists(localPath + '\' + filename)) and ModuleActive then begin
          Downloader:= TFileDownloader.Create;
          try
            Downloader.URL:= WebUpdateSiteURL + url + '/' + filename;
            Downloader.FileName:= localPath + '\' + filename;
            Downloader.FileReplaceOption:= frReplaceIfNewer;
            Downloader.OnDataTransferProgress:= self.OnDataTransferProgress;
            Module.Logger.Log('Downloading new file : "' + Downloader.URL + '" ... ',ltDetail);
            Downloader.DoDownload;
            case Downloader.DownloadResult of
              drNone:
                begin
                  Module.Logger.Log('Could not download file "' + Downloader.URL + '" - unknown reason.',ltError);
                end;
              drConnectFailed:
                begin
                  Module.Logger.Log('Could not download file "' + Downloader.URL + '" - connection to download web site failed.',ltError);
                end;
              drReplaceNotRequired:
                begin
                  Module.Logger.Log('No download required "' + Downloader.URL + '" - local file is up to date.',ltDetail);
                end;
              drDownloadFailed:
                begin
                  Module.Logger.Log('Could not download file "' + Downloader.URL + '" - failed during download.',ltWarning);
                end;
              drFileReplaced:
                begin
                  Module.Logger.Log('File downloaded ok.',ltDetail);
                end;
            end;
          finally
            Downloader.Free;
            Module.SendStatus('');
          end;
//        end;
      end;
    end;
  end;
end;


procedure TUpdaterThread.OnDataTransferProgress(percent: integer);
begin
  Module.SendStatus('Downloading file ' + IntToStr(percent) + '%');
  if not ModuleActive then begin
    Downloader.Abortdownload;
    Module.SendStatus('Stopped');
  end;
end;

//procedure TUpdaterThread.PerformUpdates;
//var
//  itemIdx, verIdx, fileIdx: integer;
//  item, ver: TJsonObject;
//  versiontype: string;
//  url: string;
//  localPath: string;
//  filename: string;
//
//  function NextUpdateCheckDue(updateItem: TJsonObject; updateName: string): boolean;
//  var
//    timeList: TJSONArray;
//    dayname: string;
//    timeIdx: integer;
//    dt: TDateTime;
//  begin
//    result:= false;
//    timeList:= nil;
//    if updateItem.ObjectExists('updateschedule') then begin
//      dayname:= Lowercase(FormatDateTime('dddd',now));
//      if updateItem.O['updateschedule'].O['days'].ObjectExists('all') then
//        timeList:= updateItem.O['updateschedule'].O['days'].O['all'].A['times']
//      else if updateItem.O['updateschedule'].O['days'].ObjectExists(dayname) then
//        timeList:= updateItem.O['updateschedule'].O['days'].O[dayname].A['times'];
//      if Assigned(timeList) then begin
//        for timeIdx:= 0 to timeList.Count -1 do begin
//          dt:= Date + StrToTime(timeList.Items[timeIdx].AsString);
//          if (dt > Settings.O['updates'].O[updateName].F['lastupdateduecheck']) and
//            (dt >= now) then begin
//            result:= true;
//            break;
//          end;
//        end;
//      end;
//      Settings.O['updates'].O[updateName].F['lastupdateduecheck']:= now;
//    end;
//  end;
//
//
//begin
//  Module.Lock;
//  try
//    Settings.AsString:= Module.SettingsText;
//  finally
//    Module.Unlock;
//  end;
//  try
//    for itemIdx:= 0 to UpdateDetails.O['updates'].Count -1 do begin
//      if not ModuleActive then begin
//        Module.SendStatus('Stopped');
//        break;
//      end;
//      item:= TJsonObject(UpdateDetails.O['updates'].Items[itemIdx].Value);
//      url:= item.S['url'];
//      localPath:= Module.DownloadPath + '\' + Settings.S['versiontype'] + url;
//      localPath:= StringReplace(localPath,'/','\',[rfReplaceAll]);
//      if item.S['updatetype'] = 'auto' then begin
//        if NextUpdateCheckDue(item,UpdateDetails.O['updates'].Items[itemIdx].Name) then begin
//          CheckUpdateItem(item,UpdateDetails.O['updates'].Items[itemIdx].Name);
//        end;
//      end;
//    end;
//  finally
//    Module.Lock;
//    try
//      Module.SettingsText:= Settings.AsString;
//    finally
//      Module.Unlock;
//    end;
//  end;
//end;

//function TUpdaterThread.CheckUpdateItem(aItem: TJsonObject;
//  aName: string): boolean;
//var
//  dbList: TErpDbList;
//  versions: TJsonObject;
//  newestversion: string;
//begin
//  result:= false;
//  Versions:= aItem.O['versions'].O[Settings.S['versiontype']];
//  newestversion:= versions.Items[Versions.Count-1].Name;
//  if versions.Count = 0 then exit;
//  if aName = 'erpdatabase' then begin
//    { get current database versions }
//    dbList:= TErpDbList.Create;
//    try
//      if dbList.ReadDatabaseInfo('localhost') then begin
//        if dbList.AnyNeedUpdating(newestversion) then begin
//          { stop all services accessing db }
//
//          { check no users in db }
//
//          { backup and update each db }
//
//        end;
//      end;
//    finally
//      dbList.Free;
//    end;
//  end;
//end;

{ TUpdaterClientSession }

constructor TUpdaterClientSession.Create;
begin

end;

procedure TUpdaterClientSession.DoRequest(RequestJson,
  ResultJson: TJsonObject);
var
  method: string;
  idx, x: integer;
  aName, aVersion: string;
  Config, item: TJsonObject;
  fversiontype: string;
  localpath: string;
  s: string;

  function UpdateItem(aItemName: string): TJsonObject;
  var ModConfig: TJsonObject;
  begin
    result:= nil;
    SessionList.Module.Lock;
    try
      ModConfig:= TModuleUpdater(SessionList.Module).Config;
      if ModConfig.O['updatedetails'].O['updates'].ObjectExists(aItemName) then begin
        result:= TJsonObject.Create;
        result.Assign(Config.O['updatedetails'].O['updates'].O[aItemName]);
      end;
      fversiontype:= Config.O['settings'].S['versiontype'];
    finally
      SessionList.Module.Unlock;
    end;
  end;

  function versiontype: string;
  var ModConfig: TJsonObject;
  begin
    if fversiontype = '' then begin
      SessionList.Module.Lock;
      try
        ModConfig:= TModuleUpdater(SessionList.Module).Config;
        fversiontype:= ModConfig.O['settings'].S['versiontype'];
      finally
        SessionList.Module.Unlock;
      end;
    end;
    result:= fversiontype;
  end;

begin
  fversiontype:= '';
  { process the request }
  method:= Lowercase(RequestJson.S['method']);
  idx:= Pos('.',method);
  if idx > 0 then
    method:= Copy(method,idx+1,Length(method));
  if method = 'filenameforversion' then begin
    if RequestJson.ObjectExists('params') then begin
      aName:= RequestJson.O['params'].S['name'];
      aVersion:= RequestJson.O['params'].S['version'];
      item:= UpdateItem(aName);
      if Assigned(item) then begin
        try
          if item.O['versions'].O[versiontype].ObjectExists(aVersion) then begin
            localPath:= TModuleUpdater(SessionList.Module).DownloadPath + '\' + versiontype + item.S['url'];
            localPath:= StringReplace(localPath,'/','\',[rfReplaceAll]);
            { build array list of files }
            for x:= 0 to item.O['versions'].O[versiontype].O[aVersion].A['files'].Count -1 do begin
              s:= localpath + '\' + item.O['versions'].O[versiontype].O[aVersion].A['files'].Items[x].AsString;
              if FileExists(s) then
                ResultJson.O['result'].A['files'].Add(s)
              else begin
                ResultJson.Delete('result');
                DoError(ResultJson, 'File not found.');
              end;
            end;
            ResultJson.S['result']:= s;
          end
          else begin
            DoError(ResultJson, 'Version not found for: ' + aName + ' version: ' + aVersion);
          end;
        finally
          item.Free;
        end;
      end
      else begin
        DoError(ResultJson, 'No update details found for ' + aName + ' in update file.');
      end;
    end
    else begin
      DoError(ResultJson, 'Request is missing params.');
    end;
  end
  else if method = 'versioniscurrent' then begin
    if RequestJson.ObjectExists('params') then begin
      aName:= RequestJson.O['params'].S['name'];
      aVersion:= RequestJson.O['params'].S['version'];
      item:= UpdateItem(aName);
      if Assigned(item) then begin
        try
          if item.O['versions'].O[versiontype].ObjectExists(aVersion) then begin
            ResultJson.B['result']:= false;
            for x:= 0 to item.O['versions'].O[versiontype].Count -1 do begin
              if item.O['versions'].O[versiontype].Items[x].Name > aVersion then begin
                ResultJson.B['result']:= true;
                break;
              end;
            end;
          end
          else begin
            DoError(ResultJson, 'Version not found for: ' + aName + ' version: ' + aVersion);
          end;
        finally
          item.Free;
        end;
      end
      else begin
        DoError(ResultJson, 'No update details found for ' + aName + ' in update file.');
      end;
    end
    else begin
      DoError(ResultJson, 'Request is missing params.');
    end;
  end
  else if method = 'getupdateschedule' then begin
    if RequestJson.ObjectExists('params') then begin
      aName:= RequestJson.O['params'].S['name'];
      aVersion:= RequestJson.O['params'].S['version'];
      item:= UpdateItem(aName);
      if Assigned(item) then begin
        try
          ResultJson.O['result'].O['updateschedule'].Assign(item.O['updateschedule']);
        finally
          item.Free;
        end;
      end
      else begin
        DoError(ResultJson, 'No update details found for ' + aName + ' in update file.');
      end;
    end
    else begin
      DoError(ResultJson, 'Request is missing params.');
    end;
  end
  else if method = 'getfileinfo' then begin
    JsonDoGetFileInfo(RequestJson, ResultJson);
  end
  else if method = 'getfilepart' then begin
    JsonDoGetFilePart(RequestJson, ResultJson);
  end
  else begin
    if Assigned(ResultJson) then
      DoError(ResultJson, 'Unrecognised request method: ' + method + '.');
  end;
end;

initialization
  if not Assigned(fModuleUpdater) then
    fModuleUpdater:= TModuleUpdater.Create;


finalization
  fModuleUpdater.Free;
  fModuleUpdater:= nil;

end.
