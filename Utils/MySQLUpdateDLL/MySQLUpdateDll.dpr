library MySQLUpdateDll;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  Classes,
  utDllFunc in 'utDllFunc.pas',
  AppRunUtils in '..\..\Dev\General\Objects\CommonObjects\AppRunUtils.pas',
  InstallConst in '..\..\Common\InstallConst.pas',
  MySQLUtils in '..\..\Common\MySQLUtils.pas',
  DbConst in '..\..\Common\DbConst.pas',
  DbSharedObjectsObj in '..\..\Dev\General\Objects\CommonObjects\DbSharedObjectsObj.pas',
  EmailUtilsSimple in '..\ERPUtilsServer\Modules\ERPModUserUtils\EmailUtilsSimple.pas',
  MailServerConst in '..\..\Common\MailServerConst.pas',
  ERPServerDetailsObj in '..\..\Dev\General\Objects\CommonObjects\ERPServerDetailsObj.pas',
  ModuleFileNameUtils in '..\..\Common\ModuleFileNameUtils.pas',
  FileDownloadFuncs in '..\..\Dev\General\Objects\CommonObjects\FileDownloadFuncs.pas',
  HTTPConst in '..\..\Common\HTTPConst.pas',
  SystemLib in '..\..\Dev\General\Objects\CommonObjects\SystemLib.pas',
  UpdaterConst in '..\ERPUpdater\UpdaterConst.pas',
  JsonToObject in '..\..\Common\JsonToObject.pas',
  CipherUtils in '..\..\Common\CipherUtils.pas',
  RandomUtils in '..\..\Common\RandomUtils.pas',
  MySQLBackupObj in '..\MySQLEngineUpdate\MySQLBackupObj.pas',
  DbBackupUtils in '..\ERPUtilsServer\Modules\DbBackupUtils.pas',
  InnoSetupUtils in '..\..\Common\InnoSetupUtils.pas';

{$R *.res}

var
  str: string;


function GetMySQLRootDir: PAnsiChar; stdcall;
begin
  str := TUpdateFunc.GetMySqlRootDir;
  result := PAnsiChar(AnsiString(str));
end;

procedure SendSupportEmail(Subject, Body: PAnsiChar; EmailTo: PAnsiChar); stdcall;
begin
  TUpdateFunc.SendSupportEmail(String(Subject), string(Body), string(EmailTo));
end;

function GetClientName: PAnsiChar; stdcall;
begin
  str := TUpdateFunc.GetClientName;
  result := PAnsiChar(AnsiString(str));
end;

function GetClientDetails: PAnsiChar; stdcall;
begin
  str := TUpdateFunc.GetClientDetails;
  result := PAnsiChar(AnsiString(str));
end;

function GetLastError: PansiChar; stdcall;
begin
  str := TUpdateFunc.GetLastError;
  result := PAnsiChar(AnsiString(str));
end;

function BackupAllDatabases: boolean; stdcall;
begin
  result := TUpdateFunc.BackupAllDatabases;
end;

function GetLog: PAnsiChar; stdcall;
begin
  str := TUpdateFunc.GetLog;
  result := PAnsiChar(AnsiString(str));
end;

//function ServiceStop(aServiceName: PAnsiChar): boolean;
//begin
//  result := TUpdateFunc.ServiceStop(String(aServiceName));
//end;
//
//function ServiceStart(aServiceName: PAnsiChar): boolean;
//begin
//  result := TUpdateFunc.ServiceStart(String(aServiceName));
//end;

function RunPostInstallSQL: boolean;  stdcall;
begin
  result := TUpdateFunc.RunPostInstallSQL;
end;

function UninstallMySQL: boolean;  stdcall;
begin
  result := TUpdateFunc.UninstallMySQL;
end;

function RestoreAllDatabases: boolean;  stdcall;
begin
  result := TUpdateFunc.RestoreAllDatabases;
end;

function CheckMySQLRunning(WaitSeconds: integer): boolean;  stdcall;
begin
  result := TUpdateFunc.CheckMySQLRunning(WaitSeconds);
end;

procedure SetInstallTempDir(aDir: PAnsiChar); stdcall;
begin
  TUpdateFunc.SetInstallTempDir(String(aDir));
end;

procedure WriteLogFile(aName, aData: PAnsiChar); stdcall;
begin
  TUpdateFunc.WriteLogFile(string(aName), string(aData));
end;

exports
  GetMySQLRootDir,
  SendSupportEmail,
  GetClientName,
  GetClientDetails,
  GetLastError,
  BackupAllDatabases,
  GetLog,
//  ServiceStop,
//  ServiceStart,
  UninstallMySQL,
  RunPostInstallSQL,
  RestoreAllDatabases,
  CheckMySQLRunning,
  SetInstallTempDir,
  WriteLogFile;

begin
end.
