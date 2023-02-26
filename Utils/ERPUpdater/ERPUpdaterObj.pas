unit ERPUpdaterObj;

interface

uses
  LogThreadLib, JsonObject, contnrs;

type

  TERPUpdater = class
  private
    fPath: string;
    fConfig,
//    fDebugConfig: TJsonObject;
    fUpdateData: TJsonObject;
//    fControlFileFound: boolean;
    fControlFileName: string;
    fUpdateSourceType: string;
    fDisplayProgress: Boolean;
    fUpdateOk: Boolean;
    fUpdateMessage: string;
    function GetUpdateData: TJsonObject;
    function UninstallApp(const aDir, aAppName: string): boolean; overload;
    function UninstallApp(const aFileName: string): boolean; overload;
    procedure MakeSureServiceRunning(AServiceName: String);

  public
    constructor Create;
    destructor Destroy; override;
    property Path: string read fPath;
    property DownloadPath: string read fPath;
    property Config: TJsonObject read fConfig;
    property UpdateData: TJsonObject read GetUpdateData;
//    property ControlFileFound: boolean read fControlFileFound;
    procedure DoUpdate{(aConfigFile: string = '')};
    property UpdateSourceType: string read fUpdateSourceType;
    property DisplayProgress: Boolean read fDisplayProgress;
    property UpdateOk: Boolean read fUpdateOk;
    property UpdateMessage: string read fUpdateMessage;
  end;

  TAppRestartItemType = (ritExe, ritService);

  TAppRestartItem = class
  public
    ProcessName: string;
    ProcessType: TAppRestartItemType;
  end;

  TAppRestartList = class
  private
    fList: TObjectList;
    function Exists(aProcessName: string; aProcessType: TAppRestartItemType): boolean;
    procedure StartItem(Item: TAppRestartItem);
  public
    constructor Create;
    destructor Destroy; override;
    function CloseApp(fileName: string; AddToRestartList: boolean = true): boolean;
    function StopService(serviceName: string): boolean;
    procedure RestartAll;
  end;

var
  Updater: TERPUpdater;

implementation

uses
  sysutils, forms, UpdaterConst, LogMessageTypes, FileDownloadFuncs,
  JsonToObject, FileVersion, AppRunUtils, WinSvc, types, CipherUtils,
  classes, ShellAPI, windows, JsonRpcTcpClient, VersionUtils, InstallConst;

{Example Usage
 Path = c:\Temp\  Mask=*.tmp}
procedure DeleteFiles(const Path, Mask: string);
var
  lpFileOp: TSHFileOpStruct;
begin
  FillChar(lpFileOp, SizeOf(lpFileOp), #0);
  lpFileOp.wFunc := FO_DELETE;
  // The + #0 is required
  lpFileOp.pFrom := PChar(Path + Mask + #0);
  lpFileOp.pTo := PChar(Path);
  lpFileOp.fFlags := FOF_NOCONFIRMATION or FOF_FILESONLY or FOF_SILENT;
  //Perform Operation
  if (SHFileOperation(lpFileOp) <> 0) then Exit;
end;


function GetInnoLogAppName(aInnoLogFile: string): string;
var
  stream: TFileStream;
  ch: Char;
  x: integer;
begin
  result:= '';
  stream:= TFileStream.Create(aInnoLogFile,fmOpenRead);
  try
    stream.Position:= 64;
    for x:= 0 to 63 do begin
      stream.Read(ch,1);
      if Ord(ch) <> 0 then
        result:= result + ch;
    end;
  finally
    stream.Free;
  end;
  result:= Trim(result);
end;

function StripVersionText(s: string): string;
var
  x: integer;
begin
  Result:= '';
  for x := 1 to Length(s) do begin
    if CharInset(s[x], ['.','0','1','2','3','4','5','6','7','8','9']) then
      Result := Result + s[x];
  end;
end;


{ TERPUpdater }

constructor TERPUpdater.Create;
begin
  fUpdateOk := True;
  fUpdateMessage := '';
  fUpdateSourceType := 'web';
  fDisplayProgress := False;
  fPath := ExtractFilePath(Application.ExeName);
  fConfig := TJsonObject.Create;
  fControlFileName := Path + UpdateControllFileName;
  if FileExists(fControlFileName) then begin
    fConfig.LoadFromFile(fControlFileName);
    if fConfig.StringExists('updatesourcetype') then
      fUpdateSourceType := fConfig.S['updatesourcetype'];
    if fConfig.BooleanExists('displayprogress') then
      fDisplayProgress := fConfig.B['displayprogress'];
  end
  else begin
    fUpdateOk := False;
    fUpdateMessage:= 'No update controll file found.';
    Exit;
  end;
end;

destructor TERPUpdater.Destroy;
begin

  fConfig.Free;
  fUpdateData.Free;
  inherited;
end;

function ExtractFilePathEx(const FileName: string): string;
var
  I: Integer;
begin
  I := LastDelimiter('/' + PathDelim + DriveDelim, FileName);
  Result := Copy(FileName, 1, I);
end;

function ExtractFileNameEx(const FileName: string): string;
var
  I: Integer;
begin
  I := LastDelimiter('/' + PathDelim + DriveDelim, FileName);
  Result := Copy(FileName, I + 1, MaxInt);
end;

procedure TERPUpdater.DoUpdate{(aConfigFile: string = '')};
var
  x, y: Integer;
  currentVersion, latestVersion: String;
  item, updateInfo, versionList: TJsonObject;
  itemName: String;
  SoftwareReleaseType: String;
  RestartList: TAppRestartList;
  UpdateProcessed: Boolean;
const
  ThreeMins = 1000 * 60 * 3;

  function ProcessUpdateVersion(ver: TJsonObject): boolean;
  var
    updatePart: TJsonObject;
    partCount: integer;
    installFileName: string;
    installRunName: string;
    installRunParams: string;
    stopBeforeUpdate: Boolean;
    WaitMilliseconds: Integer;
  begin
    Result := True;
    for partCount := 0 to ver.O['parts'].Count - 1 do begin
      updatePart := ver.O['parts'].Items[partCount].Value.AsObject;
      if updatePart.S['type'] = 'innosetup' then begin
        if updatePart.BooleanExists('stopbeforeupdate') then
          stopBeforeUpdate := updatePart.B['stopbeforeupdate']
        else
          stopBeforeUpdate := true;
        { download file }
        installFileName := ExtractFileNameEx(updatePart.S['file']);
        if not TFileDownloader.DownloadFile(WebUpdatesURL + updatePart.S['file'],
          DownloadPath + installFileName,frReplaceAlways,DisplayProgress) then begin
          fUpdateOk := False;
          fUpdateMessage := 'Could not download new file version from the internet, file: "'+
            updatePart.S['file'] + '".';
          Result := False;
          Exit;
        end;
        try
          { decrypt file }
          installRunName := ChangeFileExt(DownloadPath + installFileName, '.exe');
          CipherUtils.Decrypt(DownloadPath + installFileName, installRunName);

          { close program / stop service }
            { Note: We are relying on the inno setup to manage
                    stopping, starting and installing of services.
                    Same for services associated with dll updates. }
          if stopBeforeUpdate and
            (Lowercase(ExtractFileExt(item.S['modulefilename'])) = '.exe') then begin
            if not RestartList.CloseApp(item.S['modulefilename']) then begin
              Result := False;
              fUpdateOk := false;
              fUpdateMessage := 'Could not stop running application to update it: "' +
                item.S['modulefilename'] + '".';
              Exit;
            end;
          end;

          { run new install and wait }
          WaitMilliseconds := ThreeMins;
          installRunParams := '  /VERYSILENT';
          if updatePart.StringExists('installpassword') then
            installRunParams := installRunParams + ' /PASSWORD=' + updatePart.S['installpassword'];
          installRunParams := installRunParams + ' /NOCANCEL /NORESTART';
          if updatePart.IntegerExists('waitmilliseconds') then
            WaitMilliseconds := updatePart.I['waitmilliseconds'];
          if not ExecNewProcess(installRunName + installRunParams, True, WaitMilliseconds) then begin
            result := False;
            fUpdateOk := False;
            fUpdateMessage := 'Timed out waiting for installer to run: (' +
              installRunName + '), attempting to close installer ..';
            TLogger.Inst.Log(fUpdateMessage,ltWarning);
            { try and kill process }
            RestartList.CloseApp(ChangeFileExt(installRunName,'.tmp'), False);
          end;
        finally
          { delete downloaded file }
          sysutils.DeleteFile(DownloadPath + installFileName);

          { delete install file }
          sysutils.DeleteFile(installRunName);
        end;
      end
      else if updatePart.S['type'] = 'file' then begin
        //TLogger.Inst.Log('File type update, about to download ..',ltDetail);
        { download file }
        installFileName := ExtractFileNameEx(updatePart.S['file']);
        ForceDirectories(DownloadPath + 'downloads\');
        if not TFileDownloader.DownloadFile(WebUpdatesURL + updatePart.S['file'],
          DownloadPath + 'downloads\' + installFileName,frReplaceAlways,DisplayProgress) then begin
          fUpdateOk:= false;
          fUpdateMessage:= 'Could not download new file version from the internet, file: "'+
            updatePart.S['file'] + '".';
          Result := false;
          Exit;
        end;
        try
          { decrypt file }
          installRunName:= ChangeFileExt(DownloadPath + 'downloads\' + installFileName, '.exe');
          //TLogger.Inst.Log('installRunName: '  + installRunName ,ltDetail);
          CipherUtils.Decrypt(DownloadPath + 'downloads\' + installFileName, installRunName);
//          TLogger.Inst.Log('installRunName: '  + installRunName ,ltDetail);

          if item.StringExists('ServiceName') then begin
            if not RestartList.StopService(item.S['ServiceName']) then begin
              result:= false;
              fUpdateOk:= false;
              fUpdateMessage:= 'Could not stop running service to update it: "'+
                item.S['modulefilename'] + '".';
              Exit;
            end;
            if not SysUtils.DeleteFile(item.S['modulefilename']) then begin
              TLogger.Inst.Log('Could not delete existing version of file, will try to copy new version over: "' + item.S['modulefilename'] + '".', ltWarning);
            end;
            if not copyFile(PWideChar(installRunName), PWideChar(item.S['modulefilename']), False) then begin
              Result := False;
              fUpdateOk := false;
              fUpdateMessage := 'Could not copy over new version of service: "'+
                item.S['modulefilename'] + '".';
              exit;
            end;
          end;
        finally
          { delete downloaded file }
          sysutils.DeleteFile(DownloadPath + 'downloads\' + installFileName);
          { delete install file }
          sysutils.DeleteFile(installRunName);
        end;
      end;
    end;
  end;

begin
  RestartList := TAppRestartList.Create;
  try
    if UpdateOk then begin
      SoftwareReleaseType := Lowercase(config.S['softwarereleasetype']);
      TLogger.Inst.Log('Software release type: ' + config.S['softwarereleasetype'], ltDetail);
      for x := 0 to Config.O['updatelist'].Count - 1 do begin
        item := Config.O['updatelist'].Items[x].Value.AsObject;
        itemName := Config.O['updatelist'].Items[x].Name;
        if Assigned(item) then begin
          // Get current version
          currentVersion := '';
          if Item.StringExists('version') then
            currentVersion := StripVersionText(item.S['version'])
          else if Item.StringExists('modulefilename') then
            currentVersion := StripVersionText(GetFileVersion(item.S['modulefilename']));
          if (currentVersion = '') and (item.B['installifnotfound'] <> True) then begin
            fUpdateOk := False;
            fUpdateMessage := 'Unable to read file version information for item "' +
              Config.O['updatelist'].Items[x].Name + '".';
            Exit;
          end;

          TLogger.Inst.Log('Checking updates for: ' + itemName + '  (Ver ' + currentVersion + ')', ltDetail);

          { find update info }
          UpdateProcessed := False;
          try
            if UpdateData.O['updates'].ObjectExists(Lowercase(itemName)) then begin
              updateInfo := UpdateData.O['updates'].O[Lowercase(itemName)];
              { get Beta or Production version list }
              if updateInfo.O['versions'].ObjectExists(SoftwareReleaseType) then begin
                versionList := updateInfo.O['versions'].O[SoftwareReleaseType];
                if versionList.Count = 0 then
                  Continue;
                if updateInfo.S['actiontype'] = 'latest' then begin
                  { apply the most current update (if newer than current version) }
                  latestVersion := '';
                  {get latest}
                  y := versionList.Count - 1;
                  latestVersion := StripVersionText(versionList.Items[y].Name);
                  if latestVersion > currentVersion then begin
                    TLogger.Inst.Log('   Updating to version: ' + latestVersion + ' ...', ltDetail);
                    if not ProcessUpdateVersion(versionList.Items[y].Value.AsObject) then
                      Exit
                    else
                      UpdateProcessed := True;
                    TLogger.Inst.Log('   Update complete.', ltDetail);
                  end
                  else begin
                    { already up to date }
                    TLogger.Inst.Log('   No newer version found.', ltDetail);
                  end;
                end
                else if updateInfo.S['actiontype'] = 'progresive' then begin
                  { need to process versions in sequence }
                end;
              end;
            end;
          except
            on e: exception do begin
              TLogger.Inst.Log('Error checking update: ' + e.Message, ltError);
              Exit;
            end;
          end;

          if (not UpdateProcessed) then begin
            if item.BooleanExists('ForceRestart') and item.B['ForceRestart'] and
              (Lowercase(ExtractFileExt(item.S['modulefilename'])) = '.exe') then begin

              TLogger.Inst.Log('   Forcing restart.', ltDetail);

              if item.StringExists('ServiceName') then begin
                if not RestartList.StopService(item.S['ServiceName']) then begin
                  TLogger.Inst.Log('   Could not stop running service: "' + item.S['ServiceName'] + '"', ltWarning);
                end;
              end
              else begin
                if not RestartList.CloseApp(item.S['modulefilename']) then begin
                  TLogger.Inst.Log('   Could not stop running application: "' + item.S['modulefilename'] + '"', ltWarning);
                end;
              end;
            end;
          end;
        end;
      end; { for loop}
    end;
  finally
    RestartList.RestartAll;
    RestartList.Free;
    if not UpdateOk then
      TLogger.Inst.Log(UpdateMessage,ltError);
  end;

  if not FileExists(ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR + 'ERPUtilsService.exe') then
    Exit;

  { tempory code to remove old version of User Utils Config }
  if not UninstallApp('C:\ERP Software\Utils Service Config\','ERP Utilities Service Configuration') then begin
    TLogger.Inst.Log('Unable to remove old application: "ERP Utilities Service Configuration"',ltError);
  end;
  if DirectoryExists('C:\ERP Software\Utils Service Config\Log') then begin
    DeleteFiles('C:\ERP Software\Utils Service Config\Log\','*.*');
    RemoveDir('C:\ERP Software\Utils Service Config\Log');
  end;
  if DirectoryExists('C:\ERP Software\Utils Service Config') then begin
    DeleteFiles('C:\ERP Software\Utils Service Config\','*.*');
    RemoveDir('C:\ERP Software\Utils Service Config');
  end;


  { tempory code to remove old server dll modules .. only if new modules are installed }
  if FileExists('C:\ERP Software\Utilities\Modules\GoogleAnalytics.dll') and FileExists('C:\ERP Software\Utilities\Modules\ERPModGoogle.exe') then begin
    SysUtils.DeleteFile('C:\ERP Software\Utilities\Modules\GoogleAnalytics.dll');
  end;
  if FileExists('C:\ERP Software\Utilities\Modules\SiteIntegration.dll') and FileExists('C:\ERP Software\Utilities\Modules\ERPModSiteIntegration.exe') then begin
    SysUtils.DeleteFile('C:\ERP Software\Utilities\Modules\SiteIntegration.dll');
  end;
  if FileExists('C:\ERP Software\Utilities\Modules\UserUtils.dll') and FileExists('C:\ERP Software\Utilities\Modules\ERPModUserUtils.exe') then begin
    SysUtils.DeleteFile('C:\ERP Software\Utilities\Modules\UserUtils.dll');
  end;
  if FileExists('C:\ERP Software\Utilities\Modules\WebAPI.dll') and FileExists('C:\ERP Software\Utilities\Modules\ERPModWebAPI.exe') then begin
    SysUtils.DeleteFile('C:\ERP Software\Utilities\Modules\WebAPI.dll');
  end;

  { more temporary code to remove old erp services }
//  if GetFileVersion('C:\ERP Software\Utilities\modules\UserUtils.dll') >= '1.0.1.8' then begin
  if VersionUtils.VersionComp(GetFileVersion('C:\ERP Software\Utilities\modules\UserUtils.dll'), '1.0.1.8') >= 0 then begin
    if FileExists('C:\ERP Software\Execs\BackupManager.exe') or
        FileExists('C:\ERP Software\Services\ServerServices.exe') then begin
      TLogger.Inst.Log('Removing old ERP Server Utilities ...',ltInfo);
      if not UninstallApp('C:\ERP Software\','ERP Software Server Utilities') then begin
        TLogger.Inst.Log('Unable to remove old application: "ERP Software Server Utilities"',ltError);
      end;
    end;
    if DirectoryExists('C:\ERP Software\Execs') then begin
      DeleteFiles('C:\ERP Software\Execs\','*.*');
      RemoveDir('C:\ERP Software\Execs');
    end;
    if DirectoryExists('C:\ERP Software\ServerConfig') then begin
      DeleteFiles('C:\ERP Software\ServerConfig\','*.*');
      RemoveDir('C:\ERP Software\ServerConfig');
    end;
    if DirectoryExists('C:\ERP Software\Services') then begin
      DeleteFiles('C:\ERP Software\Services\','*.*');
      RemoveDir('C:\ERP Software\Services');
    end;
    if FileExists('C:\ERP Software\Server Updater\SrvUpdater.exe') then begin
      TLogger.Inst.Log('Removing old ERP Server Updater ...',ltInfo);
      if not UninstallApp('C:\ERP Software\Server Updater\','ERP Software Server Updater') then begin
        TLogger.Inst.Log('Unable to remove old application: "ERP Software Server Updater"',ltError);
      end;
      if DirectoryExists('C:\ERP Software\Server Updater') then begin
        DeleteFiles('C:\ERP Software\Server Updater\Log\','*.*');
        RemoveDir('C:\ERP Software\Server Updater\Log');
        DeleteFiles('C:\ERP Software\Server Updater\temp_backup_files\','*.*');
        RemoveDir('C:\ERP Software\Server Updater\temp_backup_files');
        DeleteFiles('C:\ERP Software\Server Updater\','*.*');
        RemoveDir('C:\ERP Software\Server Updater');
      end;
    end;
    if DirectoryExists('C:\ERP Software\Server Updater') then begin
      DeleteFiles('C:\ERP Software\Server Updater\Log\','*.*');
      RemoveDir('C:\ERP Software\Server Updater\Log');
      DeleteFiles('C:\ERP Software\Server Updater\temp_backup_files\','*.*');
      RemoveDir('C:\ERP Software\Server Updater\temp_backup_files');
      DeleteFiles('C:\ERP Software\Server Updater\','*.*');
      RemoveDir('C:\ERP Software\Server Updater');
    end;
    if FileExists('C:\ERP Software\Email Fax\EmailFaxSrv.exe') then begin
      TLogger.Inst.Log('Removing old ERP Email Fax Server ...',ltInfo);
      if not UninstallApp('C:\ERP Software\Email Fax\','ERP Software Email Fax Server') then begin
        TLogger.Inst.Log('Unable to remove old application: "ERP Software Email Fax Server"',ltError);
      end;
      if DirectoryExists('C:\ERP Software\Email Fax') then begin
        DeleteFiles('C:\ERP Software\Email Fax\','*.*');
        RemoveDir('C:\ERP Software\Email Fax');
      end;
    end;
    if (not FileExists('C:\ERP Software\Email Fax\EmailFaxSrv.exe')) and
        DirectoryExists('C:\ERP Software\Email Fax') then begin
      DeleteFiles('C:\ERP Software\Email Fax\','*.*');
      RemoveDir('C:\ERP Software\Email Fax');
    end;
    if DirectoryExists('C:\ERP Software\Updates') then begin
      TLogger.Inst.Log('Removing old ERP Updates ...',ltInfo);
      DeleteFiles('C:\ERP Software\Updates\client\user\','*.*');
      RemoveDir('C:\ERP Software\Updates\client\user');

      DeleteFiles('C:\ERP Software\Updates\client\user_updater\','*.*');
      RemoveDir('C:\ERP Software\Updates\client\user_updater');

      DeleteFiles('C:\ERP Software\Updates\Logs\','*.*');
      RemoveDir('C:\ERP Software\Updates\Logs');

      DeleteFiles('C:\ERP Software\Updates\server\db\','*.*');
      RemoveDir('C:\ERP Software\Updates\server\db');

      DeleteFiles('C:\ERP Software\Updates\server\file_uploader\','*.*');
      RemoveDir('C:\ERP Software\Updates\server\file_uploader');

      DeleteFiles('C:\ERP Software\Updates\server\email_fax_server\','*.*');
      RemoveDir('C:\ERP Software\Updates\server\email_fax_server');

      DeleteFiles('C:\ERP Software\Updates\server\mysql_server\','*.*');
      RemoveDir('C:\ERP Software\Updates\server\mysql_server');

      DeleteFiles('C:\ERP Software\Updates\server\help\','*.*');
      RemoveDir('C:\ERP Software\Updates\server\help');

      DeleteFiles('C:\ERP Software\Updates\server\server_updater\','*.*');
      RemoveDir('C:\ERP Software\Updates\server\server_updater');

      DeleteFiles('C:\ERP Software\Updates\server\server_updater\','*.*');
      RemoveDir('C:\ERP Software\Updates\server\server_updater');

      DeleteFiles('C:\ERP Software\Updates\User Updater\','*.*');
      RemoveDir('C:\ERP Software\Updates\User Updater');

      RemoveDir('C:\ERP Software\Updates\client');
      RemoveDir('C:\ERP Software\Updates\server');
      DeleteFiles('C:\ERP Software\Updates\','*.*');
      RemoveDir('C:\ERP Software\Updates');

    end;
    if DirectoryExists('C:\ERP Software\Logs') then begin
      DeleteFiles('C:\ERP Software\Logs\','*.*');
      RemoveDir('C:\ERP Software\Logs');
    end;
    if FileExists('C:\ERP Software\File Uploader\ClientUploads.exe') and
       FileExists('C:\ERP Software\Utilities\ClientUploads.exe') then begin
      TLogger.Inst.Log('Removing old ERP Client Uploader ...',ltInfo);
      if not UninstallApp('C:\ERP Software\File Uploader\','ERP Software File Uploader') then begin
        TLogger.Inst.Log('Unable to remove old application: "ERP Software File Uploader"',ltError);
      end;
      DeleteFiles('C:\ERP Software\File Uploader\','*.*');
      RemoveDir('C:\ERP Software\File Uploader');
    end;
    if FileExists('C:\ERP Software\Utilities\modules\SiteIntergration.dll') then begin
      TLogger.Inst.Log('Removing old ERP Site Intergration Module ...',ltInfo);

      if not UninstallApp('C:\ERP Software\Utilities\modules\','ERP Site Intergration Module') then begin
        TLogger.Inst.Log('Unable to remove old application: "ERP Site Intergration Module"',ltError);
      end;
    end;
  end;
  if FileExists('C:\ERP Software\Utilities\modules\ERPModSiteIntegration.exe') then begin
    TLogger.Inst.Log('Removing old ERP Site Intergration Module ...',ltInfo);

    if not UninstallApp('C:\ERP Software\Utilities\modules\ERPModSiteIntegration.exe') then
      TLogger.Inst.Log('Unable to remove old application: "ERP Site Intergration Module"',ltError);
  end;
//  if FileExists('C:\ERP Software\Utilities\modules\ERPModEbay.exe') then begin
//    TLogger.Inst.Log('Removing old ERP Ebay Module ...',ltInfo);
//
//    if not UninstallApp('C:\ERP Software\Utilities\modules\ERPModEbay.exe') then
//      TLogger.Inst.Log('Unable to remove old application: "ERP Ebay Module"',ltError);
//  end;

  MakeSureServiceRunning('ERPUtils');
  Sleep(5000);
  MakeSureServiceRunning('ERPWeb');
end;

function TERPUpdater.GetUpdateData: TJsonObject;
var
  UpdateDetailsFile: string;
begin
  if not Assigned(fUpdateData) then begin
    fUpdateData := TJsonObject.Create;
    UpdateDetailsFile := 'erpupdatedetails.dat';
//    if Assigned(fDebugConfig) and (fDebugConfig.S['UpdateFile'] <> '') then
//      UpdateDetailsFile := fDebugConfig.S['UpdateFile'];
    if UpdateSourceType = 'web' then begin
      if not TFileDownloader.DownloadFile(WebUpdatesURL + UpdateDetailsFile,
        Path + 'erpupdatedetails.dat', frReplaceAlways, DisplayProgress) then begin
        fUpdateOk := False;
        fUpdateMessage := 'Could not download update information file from the internet.';
      end;
    end;
    if UpdateOk then begin
      EncryptedFileToJson(fUpdateData, Path + 'erpupdatedetails.dat');
      sysutils.DeleteFile(Path + 'erpupdatedetails.dat');
    end;
  end;
  Result := fUpdateData;
end;

procedure TERPUpdater.MakeSureServiceRunning(AServiceName: String);
var
  status: DWord;

  procedure RestartService;
  var
    dt: TDateTime;
  const
    OneSec = 1/24/60/60;
  begin
    dt := now;
    while status in [SERVICE_STOP_PENDING, SERVICE_PAUSE_PENDING] do begin
      if now > (dt + (OneSec * 60)) then begin
        TLogger.Inst.Log('Timed out waiting for ' + AServiceName + ' Service.', ltError);
        Exit;
      end;
      Sleep(1000);
      status := ServiceGetStatus('', AServiceName);
    end;

    status := ServiceGetStatus('', AServiceName);
    if status in [SERVICE_STOPPED, SERVICE_PAUSED] then begin
      if not ServiceStart('', AServiceName) then
        TLogger.Inst.Log('Could not start the ' + AServiceName + ' Service.', ltError)
      else
        TLogger.Inst.Log(AServiceName + ' Service started.', ltInfo);
    end;
  end;

begin
  status := ServiceGetStatus('', AServiceName);
  case status of
    SERVICE_RUNNING:
      begin
        TLogger.Inst.Log(AServiceName + ' Service - Running.', ltInfo);
        Exit;
      end;
    SERVICE_START_PENDING:
      begin
        TLogger.Inst.Log(AServiceName + ' Service - Start Pending.', ltInfo);
        Exit;
      end;
    SERVICE_CONTINUE_PENDING:
      begin
        TLogger.Inst.Log(AServiceName + ' Service - Continue Pending.', ltInfo);
        Exit;
      end;
    SERVICE_STOPPED:
      begin
        TLogger.Inst.Log(AServiceName + ' Service - Stopped, attempting start ..', ltInfo);
        RestartService;
      end;
    SERVICE_PAUSED:
      begin
        TLogger.Inst.Log(AServiceName + ' Service - Paused, attempting start ..', ltInfo);
        RestartService;
      end;
    SERVICE_STOP_PENDING:
      begin
        TLogger.Inst.Log(AServiceName + ' Service - Stop Pending, attempting start ..', ltInfo);
        RestartService;
      end;
    SERVICE_PAUSE_PENDING:
      begin
        TLogger.Inst.Log(AServiceName + ' Service - Pause Pending, attempting start ..', ltInfo);
        RestartService;
      end;
  end;
end;

{ will search aDir for innosetup log files (eg unins000.dat) and
  find the one that contains aFilenName then if found
  run the coresponding uninstaller (eg unins000.exe) }
function TERPUpdater.UninstallApp(const aFileName: string): boolean;
var
  sr: TSearchRec;
  uninstFile: string;
  dir: string;

  function ContainsFileName(aFile: string): boolean;
  var
    stream: TFileStream;
    ch: Char;
    x: integer;
    s: string;
  begin
    result:= false;
    s:= '';
    stream:= TFileStream.Create(aFile,fmOpenRead);
    try
      stream.Position:= 0;
      x:= 1;
      while stream.Read(ch,1) = 1 do begin
        if CharInSet(ch,['a'..'z','A'..'Z','0'..'9',':','\','"','_','-',' ','.']) then
          s:= s + LowerCase(ch);
        inc(x);
        if x >= 1000 then begin
          x:= 1;
          if Pos(Lowercase(aFileName),s) > 0 then begin
            result:= true;
            exit;
          end;
        end;
      end;
    finally
      stream.Free;
    end;
  end;

const
  FiveMins = 1000 * 60 * 5;
begin
  result:= true;
  dir := ExtractFilePath(aFileName);
  if DirectoryExists(dir) then begin
    uninstFile:= '';
    if FindFirst(dir + 'unins???.dat', faAnyFile, sr) = 0 then begin
      repeat
        if ContainsFileName(dir + sr.Name) then begin
          uninstFile:= sr.Name;
          Break;
        end;
      until FindNext(sr) <> 0;
    end;
    if uninstFile <> '' then begin
      uninstFile:= ChangeFileExt(uninstFile,'.exe');
      { run the uninstaller and wait }
      result:= ExecNewProcess(dir + uninstFile + ' /VERYSILENT /SUPPRESSMSGBOXES /NORESTART', true, FiveMins);
    end;
  end;

end;

{ will search aDir for innosetup log files (eg unins000.dat) and
  find the one that belongs to aAppName then if found
  run the coresponding uninstaller (eg unins000.exe) }
function TERPUpdater.UninstallApp(const aDir, aAppName: string): boolean;
var
  sr: TSearchRec;
  uninstFile: string;
const
  FiveMins = 1000 * 60 * 5;
begin
  result:= true;
  if DirectoryExists(aDir) then begin
    uninstFile:= '';
    if FindFirst(aDir + 'unins???.dat', faAnyFile, sr) = 0 then begin
      repeat
        if GetInnoLogAppName(aDir + sr.Name) = aAppName then begin
          uninstFile:= sr.Name;
          Break;
        end;
      until FindNext(sr) <> 0;
    end;
    if uninstFile <> '' then begin
      uninstFile:= ChangeFileExt(uninstFile,'.exe');
      { run the uninstaller and wait }
      result:= ExecNewProcess(aDir + uninstFile + ' /VERYSILENT /SUPPRESSMSGBOXES /NORESTART', true, FiveMins);
    end;
  end;
end;

{ TAppRestartList }

constructor TAppRestartList.Create;
begin
  fList := TObjectList.Create(true);
end;

destructor TAppRestartList.Destroy;
begin
  fList.Free;
  inherited;
end;

function TAppRestartList.Exists(aProcessName: string;
  aProcessType: TAppRestartItemType): boolean;
var
  x: integer;
begin
  Result := False;
  for x:= 0 to fList.Count-1 do begin
    if (TAppRestartItem(fList[x]).ProcessName = aProcessName) and
       (TAppRestartItem(fList[x]).ProcessType = aProcessType) then begin
      Result := true;
      Break;
    end;
  end;
end;

procedure TAppRestartList.RestartAll;
var
  x: integer;
begin
  for x := 0 to fList.Count - 1 do
    StartItem(TAppRestartItem(fList[x]));
end;

function TAppRestartList.CloseApp(fileName: string; AddToRestartList: Boolean = True): boolean;
var
  item: TAppRestartItem;
  name: string;
  count: integer;
begin
  result:= true;
  if (not Exists(fileName,ritExe)) or (not AddToRestartList) then begin
    name:= ExtractFileName(fileName);
    if processExists(name) and (KillTask(name) > 0) then begin
      Sleep(100);
      Application.ProcessMessages;
      if not processExists(name) then begin
        { closed ok }
        if AddToRestartList then begin
          item:= TAppRestartItem.Create;
          item.ProcessName:= fileName;
          item.ProcessType:= ritExe;
          fList.Add(item);
        end;
        TLogger.Inst.Log('Process ('+Name+') stopped ok.',ltInfo);
      end
      else begin
        TLogger.Inst.Log('Could not stop process (' + Name + ') with "KillTask", trying "Taskkill" ..', ltWarning);
        count := 30;
        ShellExecute(0,nil,'Taskkill',PWideChar('/F /IM '+ name),nil,SW_HIDE);

        while processExists(name) and (Count > 0) do begin
          Sleep(1000);
          Dec(count);
        end;

        Application.ProcessMessages;
        if not processExists(name) then begin
          { closed ok }
          if AddToRestartList then begin
            item:= TAppRestartItem.Create;
            item.ProcessName:= fileName;
            item.ProcessType:= ritExe;
            fList.Add(item);
          end;
          TLogger.Inst.Log('Process ('+Name+') stopped ok.',ltInfo);
        end
        else begin
          TLogger.Inst.Log('Could not stop process ('+Name+').',ltWarning);
          result:= false;
        end;
      end;
    end;
  end;
end;

function TAppRestartList.StopService(serviceName: string): boolean;
var
  item: TAppRestartItem;
  count: integer;
begin
  result:= true;
  if not Exists(serviceName,ritService) then begin
    if ServiceStop('',ServiceName, 1000 * 30) then begin
      { closed ok }
      item := TAppRestartItem.Create;
      item.ProcessName := serviceName;
      item.ProcessType := ritService;
      fList.Add(item);
    end
    else begin
      TLogger.Inst.Log('Could not stop service (' + serviceName + ') with "ServiceStop", trying "Taskkill" ..', ltWArning);
      count := 30;
      ShellExecute(0,nil,'Taskkill',PWideChar('/F /IM '+ serviceName),nil,SW_HIDE);

      while (not (ServiceGetStatus('',ServiceName) in [SERVICE_STOPPED])) and (Count > 0) do begin
        Sleep(1000);
        Dec(count);
      end;

      if ServiceGetStatus('', ServiceName) in [SERVICE_STOPPED] then begin
        { closed ok }
        item := TAppRestartItem.Create;
        item.ProcessName := serviceName;
        item.ProcessType := ritService;
        TLogger.Inst.Log('Service (' + serviceName+') stopped ok.', ltWArning);
        fList.Add(item);
        TLogger.Inst.Log('Service: ' + ServiceName, ltWArning);
      end
      else begin
        result := false;
        TLogger.Inst.Log('Could not stop service ('+serviceName+')',ltWArning);
      end;
    end;
  end;
end;

procedure TAppRestartList.StartItem(Item: TAppRestartItem);
begin
  TLogger.Inst.Log('Item: ' + Item.ProcessName, ltWArning);
  try
    case Item.ProcessType of
      ritExe:
        ExecNewProcess(Item.ProcessName);
      ritService:
        ServiceStart('', Item.ProcessName);
    end;
  except
    on e: exception do begin
      TLogger.Inst.Log('An error occurred while restarting ' + Item.ProcessName +
        ' with message: ' + e.Message, ltWarning);
    end;

  end;
end;


end.
