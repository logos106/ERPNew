unit MySQLUpdateObj;

interface

uses
  LogThreadLib, LogMessageTypes, Classes, MySQLBackupObj, Types;

type

  TMySqlUpdater = class(TObject)
  private
    fTempDir: string;
    MySQLServiceFile: string;
    MySQLServiceParams: string;
    MySQLBaseDir: string;
    MySQLDataDir: string;
    FNewMySQLInstallerName: string;
    NewMySQLBaseDir: string;
    fDebugMode: boolean;
    sqlBack: TMySQLBackup;
    fClientDetails: string;
    fClientNAme: string;

    function TempDir: string;
    procedure Cleanup(DeleteArchives: boolean);
    function MakeMySQLDirTempCopy: boolean;
    function ReadMySQLInfo: boolean;
    function ReinstallOldMySQLServer: boolean;
    procedure SetNewMySQLInstallerName(const Value: string);
    function StopServerService(aServiceName : string; var msg: string): boolean;
    procedure Log(const msg: string;
      const LogMessageType: TLogMessageType = ltBlank);
    Procedure DeleteFiles(Const sPath, sMask: string);
//    procedure DoOnConsoleWork(Sender: TObject);
    function GetClientDetails: string;
    function GetClientName: string;
    function StartNewServerInConsole: boolean;
    procedure StopNewServerInConsole;
  protected
    property ClientDetails: string read GetClientDetails;
    property ClientName: string read GetClientName;
  public
    constructor Create;
    destructor Destroy; override;
    function DoUpdate: boolean;
    function DoUpdateNew: boolean;
    property NewMySQLInstallerName: string read FNewMySQLInstallerName write SetNewMySQLInstallerName;
    property DebugMode: boolean read fDebugMode write fDebugMode;
  end;


implementation

uses
  sysutils, InstallConst, AppRunUtils, SystemLib, ioutils, MySQLUtils,
  InnoSetupUtils, windows, DbConst, ShellApi, MyAccess, MyScript,
  WinSvc, DateUtils, StrUtils, FileVersion, JsonObject, EmailUtilsSimple,
  MyDump, MyBackup, ModuleFileNameUtils, CipherUtils;


function GetDosOutput(CommandLine: string; Work: string = 'C:\'): string;
var
  SA: TSecurityAttributes;
  SI: TStartupInfo;
  PI: TProcessInformation;
  StdOutPipeRead, StdOutPipeWrite: THandle;
  WasOK: Boolean;
  Buffer: array [0 .. 255] of AnsiChar;
  BytesRead: Cardinal;
  WorkDir: string;
  Handle: Boolean;
begin
  Result := '';
  with SA do
  begin
    nLength := SizeOf(SA);
    bInheritHandle := True;
    lpSecurityDescriptor := nil;
  end;
  CreatePipe(StdOutPipeRead, StdOutPipeWrite, @SA, 0);
  try
    with SI do
    begin
      FillChar(SI, SizeOf(SI), 0);
      cb := SizeOf(SI);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      wShowWindow := SW_HIDE;
      hStdInput := GetStdHandle(STD_INPUT_HANDLE); // don't redirect stdin
      hStdOutput := StdOutPipeWrite;
      hStdError := StdOutPipeWrite;
    end;
    WorkDir := Work;
    Handle := CreateProcess(nil, PChar('cmd.exe /C ' + CommandLine), nil, nil,
      True, 0, nil, PChar(WorkDir), SI, PI);
    CloseHandle(StdOutPipeWrite);
    if Handle then
      try
        repeat
          WasOK := ReadFile(StdOutPipeRead, Buffer, 255, BytesRead, nil);
          if BytesRead > 0 then
          begin
            Buffer[BytesRead] := #0;
            Result := Result + Buffer;
//            Form1.mmoOutput.Lines.Add(Result); // <<<<<<<<<<<<<<<<<<< output
          end;
        until not WasOK or (BytesRead = 0);
        WaitForSingleObject(PI.hProcess, INFINITE);
      finally
        CloseHandle(PI.hThread);
        CloseHandle(PI.hProcess);
      end;
  finally
    CloseHandle(StdOutPipeRead);
  end;
end;


function GetModuleNameStr: String;
var
  szFileName: array[0..MAX_PATH] of Char;
begin
  GetModuleFileName(hInstance, szFileName, MAX_PATH);
  Result := szFileName;
end;

{ TMySqlUpdater }

procedure TMySqlUpdater.Log(const msg: string;
  const LogMessageType: TLogMessageType = ltBlank);
begin
  TLogger.Inst.Log(msg,LogMessageType);
  WriteLn(LogMessageTypeToStr(LogMessageType) + '  ' + msg);
end;


procedure TMySqlUpdater.Cleanup(DeleteArchives: boolean);
begin
  if TempDir <> '' then begin
    if DeleteArchives then
      TDirectory.Delete(TempDir,true)
    else begin
      TDirectory.Delete(TempDir + 'old_install\',true);
      Deletefiles(TempDir,'*.sql');
    end;
  end;
end;

constructor TMySqlUpdater.Create;
begin
  fTempDir:= '';
  FNewMySQLInstallerName:= '';
  sqlBack := TMySQLBackup.Create;
  sqlback.OnLog := Log;
  sqlback.LogPrefix := '    ';
  TLogger.Inst.LogAllTypes;
end;

procedure TMySqlUpdater.DeleteFiles(const sPath, sMask: string);
Var
  SearchRec: TSearchRec;
  Found: Integer;
  sFile: String;
Begin
  Found := FindFirst(sPath + sMask, faAnyFile, SearchRec);
  Try
    While (Found = 0) Do Begin
      If Not (SearchRec.Attr And faDirectory > 0) Then Begin
        sFile := SearchRec.Name;
        SysUtils.DeleteFile(sPath + sFile);
      End;
      Found := FindNext(SearchRec);
    End;
  Finally
    SysUtils.FindClose(SearchRec);
  End;
end;

destructor TMySqlUpdater.Destroy;
begin
  sqlBack.Free;
  inherited;
end;

//procedure TMySqlUpdater.DoOnConsoleWork(Sender: TObject);
//begin
//  if TConsoleApp(Sender).OutStream.DataString <> '' then
//    Log('  ' + TConsoleApp(Sender).OutStream.DataString);
//end;

function TMySqlUpdater.DoUpdate: boolean;
var
  installer: string;
  NewVersionInstalled: boolean;
  OldVersionRemoved: boolean;
  RemoveBackups: boolean;
  s: string;
  msg: string;

const
  InstallWaitTime = 1000 * 60 * 5; { five minutes }
begin
  result := DoUpdateNew;
  exit;


  result:= false;
  Log('  Starting process to upgrade the MySQL_ERP Database Engine at ' + DateTimeToStr(now));
  if not Is64BitWindows then begin
    Log('  Upgrade process aborted, this is not a 64Bit version of Windows.',ltError);
    exit;
  end;
  NewVersionInstalled := false;
  RemoveBackups := true;

  sqlBack.BackupPath := TempDir + 'backup\';
  installer:= self.FNewMySQLInstallerName;
  installer:= ExtractFilePath(GetModuleNameStr) + installer;
  if (not FileExists(installer)) and (not DebugMode) then begin
    Log('  Upgrade process aborted, could not find new installer file: ' + installer,ltError);
    exit;
  end;

  Log('  Step 1 - Getting current MySQL information ...');
  { make sure we can stop and restart MySQL before we go to far ... }
  if not StopServerService(MySQL_ERP_SERVICE, msg) then begin
    Log('  Upgrade process aborted, unable to stop the MySQL Server with message: ' + msg,ltError);
    exit;
  end;
  ServiceStart('',MySQL_ERP_SERVICE);
  if not ReadMySQLInfo then begin
    Log('  Upgrade process aborted, unable to read current MySQL install info',ltError);
    exit;
  end;
  Log('  Step 2 - Stop ERP Utilities Service ...');
  if not StopServerService('ERPUtils', msg) then begin
    Log('  Upgrade process aborted, unable to stop ERP Utilities Service with message: ' + msg,ltError);
    exit;
  end;
  try
    Log('  Step 3 - Backup all existing databases ...');
    if not sqlBack.Backup then begin
      Log('  Upgrade process aborted, unable to backup databasees',ltError);
      exit;
    end;

    Log('  Step 4 - Stop and uninstall MySQL service ...');
    if not StopServerService(MySQL_ERP_SERVICE, msg) then begin
      Log('  Upgrade process aborted, unable to stop the MySQL Server with message: ' + msg,ltError);
      exit;
    end;
    s:= 'sc delete MySQL_ERP';
    if not AppRunUtils.ExecNewProcess(s,true,30000) then begin
      Log('  Upgrade process aborted, unable to remove existing MySQL service',ltError);
      exit;
    end;
    try
      Log('  Step 5 - Making tempory copy of MySQL files ...');
      if not MakeMySQLDirTempCopy then begin
        Log('  Upgrade process aborted, unable to make tempory copy of MySQL directory',ltError);
        exit;
      end;
      Log('  Step 6 - Uninstalling old MySQL version ...');
      { run all inno uninstallers found in directory }
      if (not InnoSetupUtils.UninstallApp(MySQLBaseDir,'',60000 * 5)) then begin  { wait 5 mins }
        Log('  Upgrade process aborted, unable to uninstall old MySQL version',ltError);
        exit;
      end;
      TDirectory.Delete(MySQLBaseDir,true);
      ForceDirectories(MySQL_ERP_DIR);
      OldVersionRemoved:= true;
      try
        Log('  Step 7 - Installing new MySQL version ...');
        { inno installer will install new MySQL version and install/start service }
        if not AppRunUtils.ExecNewProcess(installer + ' /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /PASSWORD=Loaded', true, InstallWaitTime) then begin
          Log('  Upgrade process aborted, unable to install new MySQL version',ltError);
          exit;
        end;
        NewVersionInstalled := true;
        { NOTE: New version will already have correct ERP user and pass }
//        Log('  Step 8 - Initialising new MySQL version ...');
//        s:= Default_MySQLBaseDir + 'bin\mysqladmin --port=3309 -u root password "' +
//          SYSDB_PASS + '"';
//        if not AppRunUtils.ExecNewProcess(s, true, 10000) then begin
//          Log('  Upgrade process aborted, unable to set new MySQL password',ltError);
//          exit;
//        end;
//        Sleep(2000);
//        if not ChangeRootUser then begin
//          Log('  Upgrade process aborted, unable to set new MySQL username',ltError);
//          exit;
//        end;
//        if not StopServerService(MySQL_ERP_SERVICE, msg) then begin
//          Log('  Upgrade process aborted, unable to stop the MySQL Server with message: ' + msg,ltError);
//          exit;
//        end;
        ServiceStart('',MySQL_ERP_SERVICE);
        Sleep(2000);
        Log('  Step 8 - Restoring databases ...');
        if not sqlBack.Restore then begin
          Log('  Upgrade process aborted, unable to restore databases',ltError);
          exit;
        end;
        Log('  Step 9 - Upgrading tables for new MySQL version ...');
        Log('    Getting new MySQL installation info ...');
        if not ReadMySQLInfo then begin
          Log('  Upgrade process aborted, unable to read current MySQL install info',ltError);
          exit;
        end;

        s:= MySQLBaseDir + 'bin\mysql_upgrade --port=3309 -u '+SYSDB_USER+' --password="' +
          SYSDB_PASS + '" > "' + ERP_UTILITIES_LOG_DIR + 'mysql_upgrade.log"';
        if not AppRunUtils.ExecNewProcess(s, true, 60000 * 5) then begin
          Log('  Upgrade process aborted, unable to upgrade tables',ltError);
          exit;
        end;

        s := MySQLBaseDir + 'bin\mysql --user='+SYSDB_USER+' --password="'+SYSDB_PASS+'" --port=3309 -e ' +
          '"GRANT ALL PRIVILEGES ON *.* to ''P_One''@''%'' IDENTIFIED BY ''' +SYSDB_PASS+ ''' WITH GRANT OPTION"';
        if not AppRunUtils.ExecNewProcess(s, true, 60000 * 5) then begin
          Log('  Upgrade process aborted, unable to change user rights',ltError);
          exit;
        end;

        Log('  Step 10 - Stop/Restart MySQL service ...');
        StopServerService(MySQL_ERP_SERVICE, msg);
        ServiceStart('',MySQL_ERP_SERVICE);
        result:= true;
      finally
        if (not Result) and NewVersionInstalled then
          RemoveBackups := false;
        if (not result) and OldVersionRemoved and (not NewVersionInstalled) then begin
          Log('  Update failed, restoring existing MySQL server');
          RemoveBackups := false;
          if not ReinstallOldMySQLServer then begin
            Log('  An error occured during the reinstall of original MySQL version', ltWarning);
          end;
        end;
      end;
    finally
      ServiceStart('',MySQL_ERP_SERVICE);
    end;
  finally
    Log('  Step 11 - Cleanup and restart ERP Utilities Service ...');
    { if we had to reinstall the old version, keep backups just in case }
    Cleanup(RemoveBackups);
    ServiceStart('','ERPUtils');
  end;
end;

function TMySqlUpdater.DoUpdateNew: boolean;
var
  dbList, sl: TStringList;
  OldDbConn: TMyConnection;
//  ConsoleApp: TConsoleApp;
  I: Integer;
  dt: TDateTime;
  cmd: string;
  x: Integer;
  WasError: boolean;
  s: string;
  aBody: TStringList;
  NewVersionInstalled: boolean;
  NewVersionStartedConsole: boolean;
  msg: string;
const
  InstallWaitTime = 1000 * 60 * 5; { five minutes }

  procedure DoErrorCleanup;
  begin
    try
      if NewVersionStartedConsole then
        StopNewServerInConsole;
      if NewVersionInstalled then begin
        if (not InnoSetupUtils.UninstallApp(NewMySQLBaseDir,'',60000 * 5)) then begin  { wait 5 mins }
          Log('  Unable to uninstall new MySQL version',ltError);
          exit;
        end
        else begin
          TDirectory.Delete(NewMySQLBaseDir,true)
        end;


      end;

    except

    end;
  end;

begin
  try
    result := true;
    NewVersionInstalled := false;
    NewVersionStartedConsole := true;
    Log('  Starting process to upgrade the MySQL_ERP Database Engine at ' + DateTimeToStr(now));
    Log('  Client: ' + ClientDetails);
    try
      if not Is64BitWindows then begin
        Log('  Upgrade process aborted, this is not a 64Bit version of Windows.',ltError);
        exit;
      end;

      Log('    Getting MySQL installation info ...');
      if not ReadMySQLInfo then begin
        Log('  Upgrade process aborted, unable to read current MySQL install info',ltError);
        exit;
      end;

      Log('  Step 1 - Stop ERP Utilities Service ...');
      if not StopServerService('ERPUtils', msg) then begin
        Log('  Upgrade process aborted, unable to stop ERP Utilities Service with message: ' + msg,ltError);
        exit;
      end;

      Log('  Step 2 - Backup all existing ERP databases ...');
      sqlBack.BackupPath := ERP_SERVER_ROOT_DIR + ERP_BACKUP_DIR;

      if not sqlBack.Backup(true) then begin
        Log('  Upgrade process aborted, unable to backup databasees',ltError);
        exit;
      end;

      s := FileVersion.GetFileVersion(NewMySQLInstallerName);
      if RightStr(s,2) = '.0' then
        s := Copy(s,1,Length(s)-2);
      if RightStr(s,2) = '.0' then
        s := Copy(s,1,Length(s)-2);

      if s = '' then begin
        Log('  Upgrade process aborted, unable to read version info from new Engine installer',ltError);
        exit;
      end;

      NewMySQLBaseDir := ExtractFileDrive(MySQLBaseDir) +  '\MySQL_' + s + '_ERP';

      Log('  Step 3 - Installing new MySQL version ...');

      if not AppRunUtils.ExecNewProcess(Self.NewMySQLInstallerName + ' /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /PASSWORD=Loaded /Dir=' + NewMySQLBaseDir, true, InstallWaitTime) then begin
        Log('  Upgrade process aborted, unable to install new MySQL version',ltError);
        exit;
      end;
      NewVersionInstalled := true;

      Log('  Step 4 - Starting MySQL version ...');
      if not StartNewServerInConsole then begin
        Log('  Upgrade process aborted, unable to start new MySQL Server',ltError);
        DoErrorCleanup;
        exit;
      end;
      NewVersionStartedConsole := true;

      Log('  Step 5 - Copying existing ERP Databases to new MySQL Server ...');
      Log('  NOTE: This process may take a long time for large databases!');
      OldDbConn := TMyConnection.Create(nil);
      dbList := TStringList.Create;
      sl := TStringList.Create;
      try
        SetConnectionProps(OldDbConn,'MySQL');
        OldDbConn.Connect;

        dbList.CommaText :=  DatabaseList(OldDbConn, true);
        for I := 0 to dbList.Count -1 do begin
          dt := now;
          Log('    Starting copy of database: ' + dbList[I]);
          cmd := MySQLBaseDir + '\bin\mysqldump.exe --database ' + dbList[I] + ' -u P_One --password="1w$p&LD07" --port=3309 | '+ MySQLBaseDir+ '\bin\mysql.exe -u P_One --password="1w$p&LD07" --port=3308';
          sl.Text := GetDosOutput(cmd);
          WasError := false;
          for x := 0 to sl.Count -1 do begin
            if Pos('error',Lowercase(sl[x])) > 0 then begin
              Log('  Error copying database ' + dbList[I] + ': ' + sl[x],ltError);
              WasError := true;
            end;
          end;
          if WasError then begin
            result := false;
            DoErrorCleanup;
            exit;
          end;
          Log('      Done, time taken: ' + FormatDateTime('hh:nn:ss', now - dt));
        end;
      finally
        sl.Free;
        dbList.Free;
        OldDbConn.Free;
      end;

      Log('  Step 6 - Uninstalling old MySQL varsion ...');
      if (not InnoSetupUtils.UninstallApp(MySQLBaseDir,'',60000 * 5)) then begin  { wait 5 mins }
        Log('  Unable to uninstall old MySQL version',ltError);
        DoErrorCleanup;
        exit;
      end;

      Log('  Step 7 - Deleting old MySQL files ...');
      try
        TDirectory.Delete(MySQLBaseDir,true);
      except
        on ex: exception do begin
          Log('  Unable to delete all old MySQL files: ' + ex.Message, ltWarning);
        end;
      end;

      Log('  Step 8 - Stopping new MySQL console ...');
      StopNewServerInConsole;

      Log('  Step 9 - Install new MySQL Service ...');
      if not AppRunUtils.ExecNewProcess(NewMySQLBaseDir + '\bin\mysqld.exe --install MySQL_ERP --defaults-file="'+NewMySQLBaseDir+'\bin\myERP.ini"', true, 1000 * 60 * 3) then begin
        result := false;
        Log('  Unable to install new MySQL service',ltError);
        exit;
      end;
      ServiceStart('','MySQL_ERP');

      Log('  Step 9 - Restarting ERP Utilities Service ...');
      ServiceStart('','ERPUtils');

    except
      on e: exception do begin
        Log('  Upgrade process failed with error: ' + e.Message,ltError);
        result := false;
      end;

    end;
  finally
    aBody := TStringList.Create;
    try
      try
        TLogger.Inst.LogToFile := false;
        TLogger.Inst.Log('');
        aBody.LoadFromFile(TLogger.Inst.LogfileName);
        TLogger.Inst.LogToFile := true;
        if result then begin
          { update worked }
          SendEmail('ian@erpoz.com','MySQL 8.0 Upgrade Succeeded for '  + ClientName, aBody.Text);
        end
        else begin
          { update worked }
          SendEmail('ian@erpoz.com','MySQL 8.0 Upgrade Failed for '  + ClientName, aBody.Text);
        end;
      finally
        aBody.Free;
      end;
    except

    end;

  end;
end;

function TMySqlUpdater.GetClientDetails: string;
var
  Conn: TMyConnection;
  Json: TJsonObject;
  qry: TMyQuery;
begin
  if fClientDetails = '' then begin
    Conn := TMyConnection.Create(nil);
    Json := JO;
    qry := TMyQuery.Create(nil);
    try
      SetConnectionProps(Conn,'services');
      Conn.Connect;
      qry.Connection := Conn;
      qry.SQL.Text := 'select * from  tblconfig where ConfigName = "ClientConfig"';
      qry.Open;
      if qry.IsEmpty then exit;
      Json.AsString := DecryptString(qry.FieldByName('ConfigValue').AsString);
      fClientName := Json.O['clientconfig'].S['Name'];
      fClientDetails :=
        'Client ID: ' + IntToStr(Json.O['clientconfig'].I['Id']) +
        ' Name: ' + Json.O['clientconfig'].S['Name'] +
        ' ERP Client Name: ' + Json.O['clientconfig'].S['ERPClientName'];
    finally
      Json.Free;
      qry.Free;
      Conn.Free;
    end;
  end;
  result := fClientDetails;
end;

function TMySqlUpdater.GetClientName: string;
begin
  if fClientName = '' then
    ClientDetails;
  result :=  fClientName;
end;

function TMySqlUpdater.MakeMySQLDirTempCopy: boolean;
begin
  result:= false;
  try
    if not CopyDir(MySQLBaseDir + '*.*',TempDir + 'old_install\') then begin
      Log('  Error while copying MySQL files',ltError);
      exit;
    end;
  except
    on e: exception do begin
      Log('  Error while copying MySQL base birectory with message: ' + e.Message,ltError);
      exit;
    end;
  end;
  result:= true;
end;

function TMySqlUpdater.ReadMySQLInfo: boolean;
var
  sl: TStringList;
  s: string;
begin
  result:= false;
  sl:= TStringList.Create;
  try
    s:= GetServiceExecutablePath('',MySQL_ERP_SERVICE);
    sl.CommaText:= s;
    if sl.Count > 1 then begin
      MySQLServiceFile:= sl[0];
      MySQLServiceParams:= sl[1];
    end
    else begin
      Log('  Error reading MySQL_ERP service executable path, value returned: ' + s, ltError);
      exit;
    end;
  finally
    sl.Free;
  end;
  MySQLDataDir:= '';
  MySQLBaseDir:= MySQLUtils.GetMySQLBaseDir('localhost');
  if MySQLBaseDir = '' then begin
    Log('  Error reading MySQL_ERP Base Directory, trying alternate method ...', ltWarning);
    s:= Lowercase(GetMySQLConfigFileName);
    if Pos('bin',s) > 0 then begin
      s:= Copy(s,1, Pos('bin',s)-1);
      if s <> '' then begin
        MySQLBaseDir:= s;
        MySQLDataDir:= s + 'data\';
      end;
    end;
    if MySQLBaseDir = '' then begin
      Log('  Error reading MySQL_ERP Base Directory.', ltError);
      exit;
    end;
  end;
  if MySQLDataDir = '' then  begin
    MySQLDataDir:= MySQLUtils.GetMySQLDataDir('localhost');
    if MySQLDataDir = '' then begin
      Log('  Error reading MySQL_ERP Data Directory.', ltError);
      exit;
    end;
  end;
  Log('  MySQL Info:');
  Log('    MySQL service: ' + MySQLServiceFile);
  Log('    MySQL params: ' + MySQLServiceParams);
  Log('    MySQL base directory: ' + MySQLBaseDir);
  Log('    MySQL data directory: ' + MySQLDataDir);
  result:= true;
end;

function TMySqlUpdater.ReinstallOldMySQLServer: boolean;
var
  s: string;
begin
  result:= false;
  try
    Log('  Deleting install directory files');
    TDirectory.Delete(MySQL_ERP_DIR, true);
    ForceDirectories(MySQL_ERP_DIR);
    Log('  Copying old files back');
    if not CopyDir(TempDir + 'old_install\*.*',MySQL_ERP_DIR) then begin
      Log('  Error copying MySQL files back from tempory folder', ltError);
      exit;
    end;
    Log('  Installing MySQL service');
    s:= MySQLServiceFile + ' --install MySQL_ERP ' + MySQLServiceParams;
    if not AppRunUtils.ExecNewProcess(s,true,30000) then begin
      Log('  Error installing service', ltWarning);
    end;
    Log('  Starting MySQL service');
    if not AppRunUtils.ServiceStart('',MySQL_ERP_SERVICE) then begin
      Log('  Error starting service', ltWarning);
    end;
  except
    on e: exception do begin
      Log('  Error reinstalling MySQL with message: ' + e.Message, ltError);
      exit;
    end;
  end;
  result:= true;
end;

procedure TMySqlUpdater.SetNewMySQLInstallerName(const Value: string);
begin
  FNewMySQLInstallerName := Value;
end;

function TMySqlUpdater.StartNewServerInConsole: boolean;
var
  conn: TMyConnection;
  scr: TMyScript;
  dt: TDateTime;
  fileList: TStringDynArray;
  I: Integer;
begin
  result := true;
  try
//    AppRunUtils.ExecNewProcess('start cmd.exe /C ' + NewMySQLBaseDir + '\bin\mysqld.exe --defaults-file=' + NewMySQLBaseDir + '\bin\myERPConsole.ini');
    AppRunUtils.ExecNewProcess(NewMySQLBaseDir + '\bin\mysqld.exe --defaults-file=' + NewMySQLBaseDir + '\bin\myERPConsole.ini');

    conn := TMyConnection.Create(nil);
    try
      SetConnectionProps(Conn,'MySQL');
      Conn.Port := 3308;
      dt := now;
      while not Conn.Connected do begin
        Sleep(5000);
        try
          Conn.Connect;
        except
          if now > (dt + (OneMinute * 3)) then begin
            result := false;
            exit;
          end;
        end;
        fileList := TDirectory.GetFiles(NewMySQLBaseDir + '\sql');
        if Length(fileList) > 0 then begin
          scr := TMyScript.Create(nil);
          try
            scr.Connection := Conn;
            for I := Low(fileList) to High(fileList) do begin
              if SameText(ExtractFileExt(fileList[I]),'.sql') then begin
                Log('    Running initial SQL on new server: ' + fileList[I]);
                scr.SQL.LoadFromFile(fileList[I]);
                scr.Execute
              end;
            end;
          finally
            scr.Free;
          end;
        end;
      end;
    finally
      conn.Free;
    end;
  except
    on e: exception do begin
      Log('  Error Starting New MySQL instance in console mode: ' + e.Message, ltError);
      result := false;
    end;
  end;
end;

procedure TMySqlUpdater.StopNewServerInConsole;
begin
  try
    AppRunUtils.ExecNewProcess(NewMySQLBaseDir + '\bin\mysqladmin.exe - P_One  --password="1w$p&LD07" --port=3308 shutdown');
    Sleep(10000);
  except
  end;
end;

function TMySqlUpdater.StopServerService(aServiceName: string; var msg: string): boolean;
var
  count: integer;
begin
  result:= true;
//  timeStart:= now;
  if not ServiceStop('',aServiceName, 120000) then begin {wait 2 mins}
      Log('Could not stop service ('+aServiceName+') with "ServiceStop", trying "Taskkill" ..',ltWArning);
      count := 30;
      ShellExecute(0,nil,'Taskkill',PWideChar('/F /IM '+ aServiceName),nil,SW_HIDE);

      while (not (ServiceGetStatus('',aServiceName) in [SERVICE_STOPPED])) and (Count > 0) do begin
        Sleep(1000);
        Dec(count);
      end;
  end;
end;

function TMySqlUpdater.TempDir: string;
begin
  if fTempDir = '' then  begin
    fTempDir:= ExtractFileDrive(ModuleFileNameUtils.GetCurrentModulePath) + '\temp\MySQL_ERP_'+FormatDateTime('yymmdd-hhnn',now)+'\';
    if not ForceDirectories(fTempDir) then
      raise exception.Create('Could not create tempory working directory: ' + fTempDir);
  end;
  result:= fTempDir;
end;

initialization

finalization

end.
