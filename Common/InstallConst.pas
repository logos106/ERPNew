unit InstallConst;

interface

(*
  function ERP_SOFTWARE_ROOT : string;
  function ERP_SERVER_ROOT_DIR : string;
  function ERP_BACKUP_DIR : string;
  function ERP_UTILS_SERVICE_CONFIG : string;
  function ERP_UTILITIES_DIR : string;
  function ERP_FILE_UPLOADER_DIR : string;
  function ERP_UTILITIES_LOG_DIR : string;
  function MySQL_ERP_SERVICE : string;
  function MySQL_ERP_DIR : string;
  function MySQL_ERP_DATADIR : string;
  function CONNECTION_INI_FILE_NAME : string;
*)
type
  TERPConfiguration = class
  private
    fERPSoftwareRootDir : string;
    fMySQLRootDir : string;
    fUserRootDir : string;
    fServerModulesDir : string;
//    function getConnectionIniFileName: string;
    function getMySqlDataDir: string;
    function getMySqlDir: string;
    function getServerRootDir: string;
    function getUtilitiesLogDir: string;
    procedure setMySqlDir(const Value: string);
    procedure SetServerRootDir(const Value: string);
    function getErpUpdatesDir: string;
    function getErpServerLog: string;
    function getUserRootDir: string;
    procedure setUserRootDir(const Value: string);
    function GetServerModulesDir: string;
    procedure SetServerModulesDir(const Value: string);
  public
    class function ERP_SOFTWARE_ROOT : string;
    class function ERP_BACKUP_DIR : string;
    class function ERP_UTILS_SERVICE_CONFIG : string;
    class function ERP_UTILITIES_DIR : string;
    class function ERP_FILE_UPLOADER_DIR : string;
    class function MySQL_ERP_SERVICE : string;
    class function CONNECTION_INI_FILE_NAME : string;


    constructor Create;
    destructor Destroy;override;
    procedure Save;

    property ERP_SERVER_ROOT_DIR : string read getServerRootDir write SetServerRootDir;
    property ERP_USER_ROOT_DIR : string read getUserRootDir write setUserRootDir;

    property ERP_UTILITIES_LOG_DIR : string read getUtilitiesLogDir;
    property ERP_UPDATES_DIR : string read getErpUpdatesDir;
    property ERP_SERVER_LOG_DIR : string read getErpServerLog;
    property ERP_SERVER_MODULES_DIR : string read GetServerModulesDir write SetServerModulesDir;

    property MySQL_ERP_DIR : string read getMySqlDir write setMySqlDir;
    property MySQL_ERP_DATADIR : string read getMySqlDataDir;
//    property CONNECTION_INI_FILE_NAME : string read getConnectionIniFileName;
  end;

  function ERP_SERVER_ROOT_DIR : string;
  function ERP_SOFTWARE_ROOT : string;
  function ERP_BACKUP_DIR : string;
  function ERP_UTILS_SERVICE_CONFIG : string;
  function ERP_UTILITIES_DIR : string;
  function ERP_UTILITIES_LOG_DIR : string;
  function ERP_FILE_UPLOADER_DIR : string;
  function MySQL_ERP_DIR : string;
  function MySQL_ERP_SERVICE : string;
  function CONNECTION_INI_FILE_NAME : string;
  function ERP_UPDATES_DIR : string;
  function ERP_SERVER_LOG_DIR : string;
  function ERP_USER_ROOT_DIR : string;
  function ERP_SERVER_MODULES_DIR: string;


  // Service
  procedure SelectERPRootFolder;
  procedure SelectMySQLRootFolder;

//--------
function ERPConfiguration : TERPConfiguration;


implementation
uses
  Windows, Registry, sysutils, Dialogs, strUtils;

const
  // Default values
  _ERP_SOFTWARE_ROOT = 'ERP Software';
  _ERP_SERVER_ROOT_DIR = 'C:\' + _ERP_SOFTWARE_ROOT + '\';
  _ERP_BACKUP_DIR = 'Backup\';
  _ERP_UTILS_SERVICE_CONFIG =  'Utils Service Config\';
  _ERP_UTILITIES_DIR = 'Utilities\';
  _ERP_FILE_UPLOADER_DIR = 'File Uploader\';
  _ERP_UTILITIES_LOG_DIR = _ERP_SERVER_ROOT_DIR + _ERP_UTILITIES_DIR + 'Log\';
  _MySQL_ERP_SERVICE = 'MySQL_ERP';
  _MySQL_ERP_DIR = 'c:\' + _MySQL_ERP_SERVICE + '\';
  _MySQL_ERP_DATADIR = _MySQL_ERP_DIR + 'data\';
  _CONNECTION_INI_FILE_NAME = 'c:\Program Files\' + _ERP_SOFTWARE_ROOT + '\Connection.ini';


var
  OldUserRoot,
  OldERPRoot,
  OldMySQLRoot : string;

  _ERPConfiguration : TERPConfiguration;

function ERPConfiguration : TERPConfiguration;
begin
  if not assigned(_ERPConfiguration) then
  begin
    _ERPConfiguration := TERPConfiguration.Create;
  end;
  Result := _ERPConfiguration;
end;

function DuplicateSlashes(const s : string) : string;
var
  idx : integer;
begin
  result := '';
  for idx := 1 to Length(s) do
    if s[idx] = '\' then
      Result := Result + '\\'
    else
      Result := Result + s[idx];
end;


{ TERPConfiguration }

constructor TERPConfiguration.Create;
var
  reg : TRegistry;
  lKey : string;
begin
  inherited;


  lKey := DuplicateSlashes('Software\' +_ERP_SOFTWARE_ROOT + '\ERP');
  reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE; //HKEY_CURRENT_USER;
    (*
    if not Reg.KeyExists(lKey) then
    begin
      ERP_SERVER_ROOT_DIR := '';
      MySQL_ERP_DIR := '';
      exit;  // use defaults
    end;
    *)
    if not Reg.OpenKey(lKey, true) then
    begin
      MessageDlg('Cannot Create Key In The Registry; Try To Run In Administrator Mode', mtWarning, [mbOK], 0);
      Exit;
    end;
//    ERP_SOFTWARE_ROOT := Reg.ReadString('ERP_SOFTWARE_ROOT');
    ERP_SERVER_ROOT_DIR := Reg.ReadString('ERP_SERVER_ROOT_DIR');
    if ERP_SERVER_ROOT_DIR = '' then
      ERP_SERVER_ROOT_DIR := ERP_SOFTWARE_ROOT;
    Reg.CloseKey;
//    MySQL_ERP_DIR := Reg.ReadString('MySQL_ERP_DIR');
   if not Reg.KeyExists(lKey + '\\MySQL Server') then
      MySQL_ERP_DIR := ''
    else
    begin
      Reg.OpenKey(lKey + '\\MySQL Server', false);
      MySQL_ERP_DIR := Reg.ReadString('InstallPath');
      Reg.CloseKey;
    end;

    if not Reg.KeyExists(lKey + '\\User') then
      //ERP_USER_ROOT_DIR := GetEnvironmentVariable('ProgramFiles')//ERP_SERVER_ROOT_DIR
      ERP_USER_ROOT_DIR := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(GetEnvironmentVariable('ProgramFiles')) + _ERP_SOFTWARE_ROOT)
    else
    begin
      Reg.OpenKey(lKey + '\\User', false);
      if Reg.ReadString('InstallPath') <> '' then
        ERP_USER_ROOT_DIR := Reg.ReadString('InstallPath')
      else
        ERP_USER_ROOT_DIR := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(GetEnvironmentVariable('ProgramFiles')) + _ERP_SOFTWARE_ROOT);
      Reg.CloseKey;
    end;
    if ERP_USER_ROOT_DIR = '' then
      ERP_USER_ROOT_DIR := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(GetEnvironmentVariable('ProgramFiles')) + _ERP_SOFTWARE_ROOT);


    if not Reg.KeyExists(lKey + '\\Utilities\\Modules') then
      ERP_SERVER_MODULES_DIR := ''
    else
    begin
      Reg.OpenKey(lKey + '\\Utilities\\Modules', false);
      ERP_SERVER_MODULES_DIR := Reg.ReadString('InstallPath');
      Reg.CloseKey;
    end;

    OldERPRoot := ERP_SERVER_ROOT_DIR;
    OldMySQLRoot := MySQL_ERP_DIR;
    OldUserRoot := ERP_USER_ROOT_DIR;
  finally
    Reg.Free;
  end;
end;

destructor TERPConfiguration.Destroy;
begin
  Save;
  inherited;
end;

class function TERPConfiguration.ERP_BACKUP_DIR: string;
begin
  Result := _ERP_BACKUP_DIR;
end;

class function TERPConfiguration.ERP_FILE_UPLOADER_DIR: string;
begin
  Result := _ERP_FILE_UPLOADER_DIR;
end;

class function TERPConfiguration.ERP_SOFTWARE_ROOT: string;
begin
  Result := _ERP_SOFTWARE_ROOT;
end;

class function TERPConfiguration.ERP_UTILITIES_DIR: string;
begin
  Result := _ERP_UTILITIES_DIR;
end;

class function TERPConfiguration.ERP_UTILS_SERVICE_CONFIG: string;
begin
  Result := _ERP_UTILS_SERVICE_CONFIG;
end;

class function TERPConfiguration.CONNECTION_INI_FILE_NAME: string;
begin
  Result := 'c:\Program Files\' + ERP_SOFTWARE_ROOT + '\Connection.ini';
end;

function TERPConfiguration.getErpServerLog: string;
begin
  Result := ERP_SERVER_ROOT_DIR + 'Logs\';
end;

function TERPConfiguration.getErpUpdatesDir: string;
begin
  Result := ERP_SERVER_ROOT_DIR + _ERP_UTILITIES_DIR + 'Updates\';
end;

function TERPConfiguration.getMySqlDataDir: string;
begin
  Result := MySQL_ERP_DIR + 'data\';
end;

function TERPConfiguration.getMySqlDir: string;
begin
  if fMySqlRootDir <> '' then
    Result := IncludeTrailingPathDelimiter(fMySqlRootDir)// + MySQL_ERP_SERVICE);
  else
    Result := '';
end;

function TERPConfiguration.GetServerModulesDir: string;
begin
//  Result := fServerModulesDir;
  if (_ERP_SERVER_ROOT_DIR = ERP_SERVER_ROOT_DIR) then
    Result := IncludeTrailingPathDelimiter(fServerModulesDir)
   else
   begin
    Result := ERP_SERVER_ROOT_DIR + _ERP_UTILITIES_DIR + 'Modules';
    fServerModulesDir := Result;
   end;
end;

function TERPConfiguration.getServerRootDir: string;
begin
  if fERPSoftwareRootDir <> '' then
    Result := IncludeTrailingPathDelimiter(fERPSoftwareRootDir)
  else
    Result := '';
end;

function TERPConfiguration.getUserRootDir: string;
begin
  Result := fUserRootDir;
end;

function TERPConfiguration.getUtilitiesLogDir: string;
begin
  Result := ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR + 'Log\';
end;

class function TERPConfiguration.MySQL_ERP_SERVICE: string;
begin
  Result := _MySQL_ERP_SERVICE;
end;

procedure TERPConfiguration.Save;
var
  reg : TRegistry;
  lKey : string;
begin
  // save only if root folders changed

  if (OldERPRoot = ERP_SERVER_ROOT_DIR) and
     (OldUserRoot = ERP_USER_ROOT_DIR) and
    (OldMySQLRoot = MySQL_ERP_DIR) then
    exit;

  reg := TRegistry.Create;
  try
    lKey := DuplicateSlashes('Software\' +_ERP_SOFTWARE_ROOT + '\ERP');
    Reg.RootKey := HKEY_LOCAL_MACHINE; //HKEY_CURRENT_USER;
    Reg.OpenKey(lKey, true);
    Reg.WriteString('ERP_SERVER_ROOT_DIR', ERP_SERVER_ROOT_DIR);
    Reg.CloseKey;
    if Reg.OpenKey(lKey + '\\MySQL Server', false) then
      Reg.WriteString('InstallPath', ExcludeTrailingPathDelimiter(MySQL_ERP_DIR));
    reg.CloseKey;
    if Reg.OpenKey(lKey + '\\User', false) then
      Reg.WriteString('InstallPath', ExcludeTrailingPathDelimiter(ERP_USER_ROOT_DIR));
    Reg.CloseKey;
    if Reg.OpenKey(lKey + '\\Utilities\\Modules', false) then
      Reg.WriteString('InstallPath', ExcludeTrailingPathDelimiter(ERP_SERVER_MODULES_DIR));
    Reg.CloseKey;
  finally
    Reg.Free;
  end;
end;

procedure TERPConfiguration.setMySqlDir(const Value: string);
begin
  if Value = '' then
    fMySQLRootDir := _MySQL_ERP_DIR
  else if ContainsText(Value, _MySQL_ERP_SERVICE)  then
    fMySQLRootDir := IncludeTrailingPathDelimiter(Value)
  else
    fMySQLRootDir  := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(Value));// + _MySQL_ERP_SERVICE);
end;

procedure TERPConfiguration.SetServerModulesDir(const Value: string);
begin
 if Value='' then
   fServerModulesDir := _ERP_SERVER_ROOT_DIR + _ERP_UTILITIES_DIR + 'Modules'
 else if ContainsText(Value, _ERP_SOFTWARE_ROOT)  then
 begin
   if (_ERP_SERVER_ROOT_DIR = ERP_SERVER_ROOT_DIR) then
     fServerModulesDir := IncludeTrailingPathDelimiter(Value)
   else
    fServerModulesDir := ERP_SERVER_ROOT_DIR + _ERP_UTILITIES_DIR + 'Modules'
 end
 else
   fServerModulesDir := IncludeTrailingPathDelimiter(Value) + _ERP_SOFTWARE_ROOT + _ERP_UTILITIES_DIR + 'Modules';
end;

procedure TERPConfiguration.SetServerRootDir(const Value: string);
begin
 if Value='' then
   fERPSoftwareRootDir := _ERP_SERVER_ROOT_DIR
 else if ContainsText(Value, _ERP_SOFTWARE_ROOT)  then
   fERPSoftwareRootDir := IncludeTrailingPathDelimiter(Value)
 else
   fERPSoftwareRootDir := IncludeTrailingPathDelimiter(Value); // + _ERP_SOFTWARE_ROOT + '\';
end;

procedure TERPConfiguration.setUserRootDir(const Value: string);
begin
  fUserRootDir := Value;
end;

//=================
function ERP_SOFTWARE_ROOT : string;
begin
  Result := TERPConfiguration.ERP_SOFTWARE_ROOT;
end;

function ERP_BACKUP_DIR : string;
begin
  Result := TERPConfiguration.ERP_BACKUP_DIR;
end;

function ERP_UTILS_SERVICE_CONFIG : string;
begin
  Result := TERPConfiguration.ERP_UTILS_SERVICE_CONFIG;
end;

function ERP_UTILITIES_DIR : string;
begin
  Result := TERPConfiguration.ERP_UTILITIES_DIR;
end;

function ERP_FILE_UPLOADER_DIR : string;
begin
  Result := TERPConfiguration.ERP_FILE_UPLOADER_DIR;
end;

function MySQL_ERP_SERVICE : string;
begin
  Result := TERPConfiguration.MySQL_ERP_SERVICE;
end;

function MySQL_ERP_DIR : string;
begin
  Result := ERPConfiguration.MySQL_ERP_DIR;
end;

function ERP_UTILITIES_LOG_DIR : string;
begin
  Result := ERPConfiguration.ERP_UTILITIES_LOG_DIR;
end;

function CONNECTION_INI_FILE_NAME : string;
begin
  Result := TERPConfiguration.CONNECTION_INI_FILE_NAME;
end;

function ERP_SERVER_ROOT_DIR : string;
begin
  Result := ERPConfiguration.ERP_SERVER_ROOT_DIR;
end;

function ERP_UPDATES_DIR : string;
begin
  Result := ERPConfiguration.ERP_UPDATES_DIR;
end;

function ERP_SERVER_LOG_DIR : string;
begin
  Result := ERPConfiguration.ERP_SERVER_LOG_DIR;
end;

function ERP_USER_ROOT_DIR : string;
begin
  Result := ERPConfiguration.ERP_USER_ROOT_DIR;
end;

function ERP_SERVER_MODULES_DIR : string;
begin
  Result := ERPConfiguration.ERP_SERVER_MODULES_DIR;
end;

{$WARN SYMBOL_PLATFORM OFF}
procedure SelectERPRootFolder;
var
  lDialog : TFileOpenDialog;
begin
  lDialog := TFileOpenDialog.Create(nil);
  try
    lDialog.Options := [fdoPickFolders];
    if lDialog.Execute then
      ERPConfiguration.ERP_SERVER_ROOT_DIR := IncludeTrailingPathDelimiter(lDialog.Files[0]);
  finally
    lDialog.Free;
  end;
end;

procedure SelectMySQLRootFolder;
var
  lDialog : TFileOpenDialog;
begin
  lDialog := TFileOpenDialog.Create(nil);
  try
    lDialog.Options := [fdoPickFolders];
    if lDialog.Execute then
      ERPConfiguration.MySQL_ERP_DIR := IncludeTrailingPathDelimiter(lDialog.Files[0]);
  finally
    lDialog.Free;
  end;
end;
{$WARN SYMBOL_PLATFORM ON}
initialization
finalization
  _ERPConfiguration.Free;
end.
