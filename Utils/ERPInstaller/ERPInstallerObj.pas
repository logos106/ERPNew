unit ERPInstallerObj;

interface

uses
  contnrs, AbBase, AbBrowse, AbZBrows, AbUnzper, JsonObject;

type

  TInstallProgressEvent = procedure (const aCaption, aMessage: string;
                                     StepNo, StepCount: integer) of object;

  TUserInputRequired = procedure (const msg: string; var AbortInstall: boolean) of object;

  TERPInstaller = class(TObject)
  private
    fRunPath: string;
    fPath: string;
    fZipFile: string;
    InstallList: TJsonObject;
    UnZip: TAbUnZipper;
    fOnProgress: TInstallProgressEvent;
    fERPServerName: string;
    fOnUserInputRequired: TUserInputRequired;
    property ZipFile: string read fZipFile;
    procedure FindAndReadZip;
    function FilePosInZip(const aFileName: string): integer;
    function ERPMySQLAccessOk(var msg: string): boolean;
    procedure DoProgress(const aCaption, aMessage: string; StepNo, StepCount: integer);
    function CanReadWriteDirectory(aDirectory: string): boolean;
    function UpdateERPConnectionCofig(var msg: string): boolean;
    property RunPath: string read fRunPath;
    function DirToInstall(const aInstallType, aName, aFileName : string) : string;
    procedure UpdateMySQLIniFile;
  public
    constructor Create;
    destructor Destroy; override;
    function DoInstall(const aInstallType: string; var msg: string): boolean;
    property OnProgress: TInstallProgressEvent read fOnProgress write fOnProgress;
    property ERPServerName: string read fERPServerName write fERPServerName;
    property Path: string read fPath;
    property OnUserInputRequired: TUserInputRequired read fOnUserInputRequired write fOnUserInputRequired;
  end;

implementation

uses
  windows, sysutils, forms, classes, MyAccess, DbConst, IniFiles,
  InternetConnectivityUtils, JsonRpcConst, LogThreadLib, LogMessageTypes,
  AppRunUtils, InstallConst, strUtils;

const
  ERPInstallInfoFile = 'InstallInfo.txt';
  ThreeMins = 1000 * 60 * 3;


function ExecAndWait(const Filename, Params: string;
                     WindowState: word): boolean;
var
  SUInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CmdLine: string;
  WaitResult: integer;
begin
  { Enclose filename in quotes to take care of
    long filenames with spaces. }
  CmdLine := '"' + Filename + '" ' + Params;
  FillChar(SUInfo, SizeOf(SUInfo), #0);
  with SUInfo do begin
    cb := SizeOf(SUInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := WindowState;
  end;
  Result := CreateProcess(NIL, PChar(CmdLine), NIL, NIL, FALSE,
                          CREATE_NEW_CONSOLE or
                          NORMAL_PRIORITY_CLASS, NIL,
                          PChar(ExtractFilePath(Filename)),
                          SUInfo, ProcInfo);
  { Wait for it to finish. }
  if Result then begin
    repeat
      Application.ProcessMessages;
      WaitResult:= WaitForSingleObject(ProcInfo.hProcess, 200);
    until WaitResult <> WAIT_TIMEOUT;
  end;
end;

function GetWindowsTempDirectory: String;
var
  tempFolder: array[0..MAX_PATH] of Char;
begin
  GetTempPath(MAX_PATH, @tempFolder);
  result := StrPas(tempFolder);
end;


{ TERPInstaller }

constructor TERPInstaller.Create;
begin
  fPath:= GetWindowsTempDirectory + 'ERPInstallTemp\';
  ForceDirectories(fPath);
  fRunPath:= ExtractFilePath(Application.ExeName);
  InstallList:= TJsonObject.Create;
  UnZip:= TAbUnZipper.Create(nil);
  UnZip.BaseDirectory:= Path;
  UnZip.TempDirectory:= Path;
  FindAndReadZip;
end;

destructor TERPInstaller.Destroy;
begin
  UnZip.Free;
  InstallList.Free;
  inherited;
end;

function TERPInstaller.DirToInstall(const aInstallType, aName,
  aFileName: string): string;
var
  lLong,
  lShort : string;
  idx : integer;
//  f : text;
begin
  Result := '';
  lShort := '';
  lLong := '';
  // Videos - no idea where they are installed
  (*
  assignFile(f,'dirtoinstall.txt');
  if not FileExists('dirtoinstall.txt') then
    Rewrite(f)
  else
    Append(f);
  writeln(f, Format('Type %s, Name %s, FileName %s', [aInstallType, aName, aFileName]));
  closefile(f);
  *)
  try
    idx := pos('_', aFileName);
    if idx > 0  then
    begin
      lShort := UpperCase(Copy(aFileName, 1, idx - 1));
      lLong := Copy(aFileName, idx + 1, length(aFileName));
    end
    else
      exit;

    idx := pos('_', lLong);
    if idx > 0 then
      lLong := UpperCase(copy(lLong, 1, idx-1))
    else
      lLong := '';

    if lShort='SERVER' then
//      Result := ERP_SERVER_ROOT_DIR
      Result := MySQL_ERP_DIR
    else if (lShort = 'FILE') and (lLong='UPLOADER') then
      Result := ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR
    else if lShort = 'ERPUTILS' then
      Result := ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR
    else if lShort='USERUTILSMODULE' then
      Result := ERP_SERVER_MODULES_DIR // ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR + 'Modules\'
    else if lShort = 'USER' then
      Result := ERP_USER_ROOT_DIR
    else if lShort = 'MULTISITEMODULE' then
      Result := ERP_SERVER_MODULES_DIR
    else if lShort = 'ERPSERVICEMENU' then
      Result := ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR
    else if (lShort = 'MYSQL') or (lLong='MYSQL') then
      Result := MySQL_ERP_DIR;
  finally
    if Result = '' then
    begin
      if ContainsText(aName, 'ERP MYSQL') then
        Result := MySQL_ERP_DIR
      else if ContainsText(aName, 'uploader') then
        Result := ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR
      else if ContainsText(aName, 'Utilities service') then
      Result := ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR
      else if ContainsText(aName, 'Module') then   // User utils module, multisite module
        Result := ERP_SERVER_MODULES_DIR
      else if ContainsTExt(aNAme, 'Application') then
        Result := ERP_USER_ROOT_DIR
      else if ContainsText(aName, 'Menu') then
        Result := ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR;
    end;
    if Result <> '' then
    begin
      Result := ExcludeTrailingPathDelimiter(Result);
      Result := ' /DIR="' + Result + '"';
    end;
  (*
  assignFile(f,'dirtoinstall.txt');
  Append(f);
  writeln(f, 'Result: ' + Result);
  closefile(f);
  *)
  end;

end;

function TERPInstaller.FilePosInZip(const aFileName: string): integer;
var
  x: integer;
begin
  result:= -1;
  for x:= 0 to UnZip.Count -1 do begin
    if UnZip.Items[x].FileName = aFileName then begin
      result:= x;
      Break;
    end;
  end;
end;

procedure TERPInstaller.FindAndReadZip;
var
  sr: TSearchRec;
  FileAttrs: integer;
  idx: integer;
begin
  InstallList.Clear;
  FileAttrs:= faAnyFile;
  if FindFirst(RunPath + '*.zip',FileAttrs,sr) = 0 then begin
    try
      repeat
        UnZip.FileName:= (RunPath + sr.Name);
        idx:= FilePosInZip(ERPInstallInfoFile);
        if idx >= 0 then begin
          UnZip.ExtractAt(Idx, '');
          try
            InstallList.LoadFromFile(Path + ERPInstallInfoFile);
          finally
            DeleteFile(Path + ERPInstallInfoFile);
          end;
          fZipFile:= sr.Name;
          Break;
        end;
      until FindNext(sr) <> 0;
    finally
      FindClose(sr);
    end;
  end;
end;

function TERPInstaller.ERPMySQLAccessOk(var msg: string): boolean;
var
  conn: TMyConnection;
begin
  result:= true;
  conn:= TMyConnection.Create(nil);
  try
    conn.LoginPrompt:= false;
    conn.Port:= SERVER_PORT;
    conn.Options.Compress:= MYDAC_OPTIONS_COMPRESS;
    conn.Options.Protocol:= MYDAC_OPTIONS_PROTOCOL;
    conn.Username:= SYSDB_USER;
    conn.Password:= SYSDB_PASS;
    conn.Server:= self.ERPServerName;
    conn.Database:= MYSQL_DATABASE;
    try
      conn.Connect;
      if not conn.Connected then begin
        result:= false;
        msg:= 'Could not connect to ERP MySQL server: ' + self.ERPServerName;
      end;
    except
      on e: exception do begin
        result:= false;
        msg:= 'Could not connect to ERP MySQL server: ' + self.ERPServerName;
      end;
    end;
  finally
    conn.Free;
  end;
end;

procedure TERPInstaller.DoProgress(const aCaption, aMessage: string;
  StepNo, StepCount: integer);
begin
  if Assigned(fOnProgress) then
    fOnProgress(aCaption, aMessage, StepNo, StepCount);
  TLogger.Inst.Log(aCaption +' - ' + aMessage + '  Step ' + IntToStr(StepNo) + ' of ' + IntToStr(StepCount));
end;

function TERPInstaller.CanReadWriteDirectory(aDirectory: string): boolean;
var
  ini: TIniFile;
  filename, s, val, sect, idt: string;
begin
  result:= true;
  ini:= nil;
  filename:= 'testreadwritefile_' + FormatDateTime('dd-mm-yyy_hh-nn-ss',now) + '.ini';
  if aDirectory <> '' then
    filename:= aDirectory + filename;
  try
    try
      ini:= TIniFile.Create(FileName);
      sect:= '_Test_File_Read-Write_Section_';
      idt:= '_Test_Read-Write_Ident_';
      val:= '_Test_Value_' + FormatDateTime('dd-mm-yy_hh-nn-ss-zzz',now);
      ini.WriteString(sect,idt,val);
      s:= ini.ReadString(sect,idt,'');
      if s <> val then
        raise Exception.Create('Error writing and reading value to file.');
      ini.EraseSection(sect);
    except
      on E: exception do begin
        result:= false;
      end;
    end;
  finally
    try
      ini.Free;
      DeleteFile(FileName);
    except;
    end;
  end;
end;

function TERPInstaller.DoInstall(const aInstallType: string;
  var msg: string): boolean;
var
  InstallCount: integer;
  StepNo: integer;
  x: integer;
  s: string;
  params: string;
  item: TJsonObject;
  itemName: string;
  idxZip: integer;
  fileName: string;
  AbortInstall: boolean;
  lDir : string;
begin
  result:= true;
  InstallCount:= InstallList.O[aInstallType].O['items'].Count;
  if InstallCount = 0 then begin
    result:= false;
    msg:= 'Nothing found to intall for: ' + aInstallType;
    exit;
  end;
  InstallCount:= InstallCount + 2;
  TLogger.Inst.Log('Starting Install for Install Type: ' +  aInstallType + ' ...');
  if not CanReadWriteDirectory(Path) then begin
    result:= false;
    msg:= 'Your Windows Security permissions are insufficent for this task.' +
      #13#10 + #13#10 +
      'Please log into Windows with full administrator rights before running this install.';
    exit;
  end;
  StepNo:= 1;
  DoProgress('Installing ' + aInstallType,'Checking Requirements ...',StepNo,InstallCount);
  Sleep(200);
  Application.ProcessMessages;

  { pre reqs for install }
  if (aInstallType = 'User') or (aInstallType = 'User And Videos') then begin
    if self.fERPServerName = '' then begin
      result:= false;
      msg:= 'ERP Server Name or Server Machine IP not specified';
      exit;
    end;
    if not ERPMySQLAccessOk(msg) then begin
      result:= false;
      exit;
    end;
  end
  else if (aInstallType = 'Server') or (aInstallType = 'Services') then begin
    TLogger.Inst.Log('Checking internet access ...');
    DoProgress('Installing ' + aInstallType,'Checking internet access ...',StepNo,InstallCount);
    Application.ProcessMessages;
    if not InternetAccessOk(false) then begin
      msg:= 'This computer does not seem to have access to the internet.' +
        #13#10 + #13#10 +
        'ERP Server components require internet access to operate, ' +
        'please ensure this computer has internet access.';

      if Assigned(fOnUserInputRequired) then begin
        AbortInstall := false;
        msg := msg + #13#10 + #13#10 +
          'Do you wish to continue with the install anyway?';
        fOnUserInputRequired(msg, AbortInstall);
        if AbortInstall then begin
          result := false;
          exit;
        end;
      end
      else begin
        result:= false;
        exit;
      end;
    end;
    TLogger.Inst.Log('Checking head office access ...');
    DoProgress('Installing ' + aInstallType,'Checking head office access ...',StepNo,InstallCount);
    Application.ProcessMessages;
    if not ERPHeadOfficeAccessOk(false) then begin
      msg:= 'Can not get access through your firewall and/or your router on port ' +
        IntToStr(DEFAULT_TCP_PORT) +
        #13#10 + #13#10 +
        'ERP Server components require access to operate, ' +
        'please ensure this computer has internet access on this port.';


      if Assigned(fOnUserInputRequired) then begin
        AbortInstall := false;
        msg := msg + #13#10 + #13#10 +
          'Do you wish to continue with the install anyway?';
        fOnUserInputRequired(msg, AbortInstall);
        if AbortInstall then begin
          result := false;
          exit;
        end;
      end
      else begin
        result:= false;
        exit;
      end;
    end;
  end
  else if (aInstallType = 'Services') and not (ERPMySQLAccessOk(s)) then begin
    msg:= 'This computer does not have ERP MySQL installed.' +
      #13#10 + #13#10 +
      'This installation type is only to be run on a Server.';
    result:= false;
    exit;
  end;

  TLogger.Inst.Log('About to start installing files ...');
  { now run then innosetup installs from zip file }
  for x:= 0 to InstallList.O[aInstallType].O['items'].Count -1 do begin
    item:= InstallList.O[aInstallType].O['items'].Items[x].Value.AsObject;
    itemName:= InstallList.O[aInstallType].O['items'].Items[x].Name;
    TLogger.Inst.Log('Installing: ' + itemName + ', item ' + IntToStr(x + 1) + ' of ' +
      IntToStr(InstallList.O[aInstallType].O['items'].Count));
    Inc(StepNo);
    if itemName = 'Videos' then
      DoProgress('Installing ' + aInstallType,'Installing ' + itemName + ' (Install Time 20mins +)',StepNo,InstallCount)
    else
      DoProgress('Installing ' + aInstallType,'Installing ' + itemName,StepNo,InstallCount);
    Application.ProcessMessages;
    if not item.B['external'] then begin
      fileName:= path + item.S['file'];
      idxZip:= FilePosInZip(item.S['file']);
      if idxZip < 0 then begin
        result:= false;
        TLogger.Inst.Log('Unable to find the installation file in Zip file: ' + item.S['file'],ltError);
        msg:= 'Unable to find the installation file in zip file: ' + item.S['file'];
        exit;
      end;
      try
        UnZip.ExtractAt(idxZip,'');
      except
        on e: exception do begin
          result:= false;
          TLogger.Inst.Log('Error while extracting file: ' + fileName +
            ' Message: ' + e.Message,ltError);
          msg:= 'Error while extracting file: ' + fileName + #13#10 + #13#10 +
            'Message: ' + e.Message;
          exit;
        end;
      end;
    end
    else begin
      fileName:= ExtractFilePath(Application.ExeName) + item.S['file']
    end;
    { if it is not an inno setup exe don't try and run it eg video avi }
    if Lowercase(ExtractFileExt(fileName)) <> '.exe' then
      continue;
    try
      if FileExists(fileName) then begin
        Application.ProcessMessages;
        if item.StringExists('params') then begin
          params:= ' ' + item.S['params'];
        end
        else begin
          params:= ' /VERYSILENT';
          if item.S['password'] <> '' then
            params:= params + ' /PASSWORD=' + item.S['password'];
          params:= params + ' /NOCANCEL /NORESTART';
        end;

        lDir := DirToInstall(aInstallType, itemName, Item.S['file']);
        params := params + lDir;

        if TLogger.Inst.Active then begin
          params:= params + ' /LOG="' + ChangeFileExt(path + 'Log\' + item.S['file'],'.log') + '"';
        end;
        TLogger.Inst.Log('Installing: ' + item.S['file'] + ' Install Params: ' + params);
        if not ExecAndWait(fileName, params, SW_HIDE) then begin
//        if not ExecNewProcess(fileName + params, true) then begin
          TLogger.Inst.Log('    Failed!');
          result:= false;
          msg:= 'Install failed while installing component: ' + itemName;
          exit;
        end
        else begin
          TLogger.Inst.Log('    Ok!');
          Application.ProcessMessages;
          Sleep(500);
        end;
      end
      else begin
        result:= false;
        TLogger.Inst.Log('Unable to find the installation file: ' + fileName,ltError);
        msg:= 'Unable to find the installation file: ' + fileName;
        exit;
      end;
    finally
      if not item.B['external'] then
        DeleteFile(fileName);
    end;
  end;
  { change ERP connection file to point to server }
  if (aInstallType = 'User') or (aInstallType = 'User And Videos') then begin
    UpdateERPConnectionCofig(s);
  end
  else if SameTExt(aInstallType, 'Server') then
    UpdateMySQLIniFile;
end;

function TERPInstaller.UpdateERPConnectionCofig(var msg: string): boolean;
var
  ini: TIniFile;
  x: integer;
  s: string;
begin
  result:= true;
  if not FileExists(CONNECTION_INI_FILE_NAME) then begin
    result:= false;
    msg:= 'Could not find the ERP connection file.';
    exit;
  end;

  ini:= TIniFile.Create(CONNECTION_INI_FILE_NAME);
  try
    ini.WriteString('Last_Database','Database','sample_company');
    ini.WriteString('Last_Database','Server',fERPServerName);
    ini.WriteString('Last_Database','UserName','Admin');
    ini.WriteString('Last_Database','LastConnectServer',fERPServerName);

    { make sure the server is in the list }
    x:= 0;
    s:= '';
    repeat
      s:= ini.ReadString('Servers', 'Server' + IntToStr(x), '');
      if s = fERPServerName then
        break;
      Inc(x);
    until s = '';
    if s <> fERPServerName then begin
      ini.WriteString('Servers', 'Server' + IntToStr(x), fERPServerName);
    end;
  finally
    ini.Free;
  end;
end;

procedure TERPInstaller.UpdateMySQLIniFile;
var
  lIni : TIniFile;
  lFileName : string;
begin
  lFileName := MySQL_ERP_DIR + 'bin\myERP.Ini';
  TLogger.Inst.Log('Updating MyERP ini file ' + lFileName);
  lIni := TIniFile.Create(lFileName);
  try
    lIni.WriteString('mysqld', 'basedir', '"' + ExcludeTrailingPathDelimiter(MySQL_ERP_DIR) + '"');
    lIni.WriteString('mysqld', 'datadir', '"' + MySQL_ERP_DIR + 'data' + '"');
    lIni.WriteString('mysqld', 'innodb_data_home_dir', '"' + MySQL_ERP_DIR + 'data/' + '"');
    lIni.WriteString('mysqld', 'innodb_log_group_home_dir', '"' + MySQL_ERP_DIR + 'data/' + '"');
    TLogger.Inst.Log('BaseDir=' + lIni.ReadString('mysqld', 'basedir','??'));
    TLogger.Inst.Log('datadir=' + lIni.ReadString('mysqld', 'datadir', '??'));
    TLogger.Inst.Log('innodb_data_home_dir=' + lIni.ReadString('mysqld', 'innodb_data_home_dir', '???'));
    TLogger.Inst.Log('innodb_log_group_home_dir=' + lIni.ReadString('mysqld', 'innodb_log_group_home_dir', '??'));
  finally
    lIni.Free;
  end;

end;

end.
