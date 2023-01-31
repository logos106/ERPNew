program MySQLEngineUpdate;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  MySQLUpdateObj in 'MySQLUpdateObj.pas',
  LogThreadLib in '..\..\Dev\General\Objects\CommonObjects\LogThreadLib.pas',
  SystemLib in '..\..\Dev\General\Objects\CommonObjects\SystemLib.pas',
  MySQLUtils in '..\..\Common\MySQLUtils.pas',
  InstallConst in '..\..\Common\InstallConst.pas',
  DbConst in '..\..\Common\DbConst.pas',
  LogMessageTypes in '..\..\Dev\General\Objects\CommonObjects\LogMessageTypes.pas',
  OpProgressObj in '..\..\Dev\General\Objects\CommonObjects\OpProgressObj.pas',
  AppRunUtils in '..\..\Dev\General\Objects\CommonObjects\AppRunUtils.pas',
  InnoSetupUtils in '..\..\Common\InnoSetupUtils.pas',
  DbBackupUtils in '..\ERPUtilsServer\Modules\DbBackupUtils.pas',
  DbSharedObjectsObj in '..\..\Dev\General\Objects\CommonObjects\DbSharedObjectsObj.pas',
  LogThreadBase in '..\..\Dev\General\Objects\CommonObjects\LogThreadBase.pas',
  MySQLBackupObj in 'MySQLBackupObj.pas',
  ModuleFileNameUtils in '..\..\Common\ModuleFileNameUtils.pas',
  FileVersion in '..\..\Dev\General\Objects\CommonObjects\FileVersion.pas',
  CipherUtils in '..\..\Common\CipherUtils.pas',
  EmailUtilsSimple in '..\ERPUtilsServer\Modules\ERPModUserUtils\EmailUtilsSimple.pas',
  MailServerConst in '..\..\Common\MailServerConst.pas',
  ERPServerDetailsObj in '..\..\Dev\General\Objects\CommonObjects\ERPServerDetailsObj.pas',
  FileDownloadFuncs in '..\..\Dev\General\Objects\CommonObjects\FileDownloadFuncs.pas',
  HTTPConst in '..\..\Common\HTTPConst.pas',
  UpdaterConst in '..\ERPUpdater\UpdaterConst.pas',
  JsonToObject in '..\..\Common\JsonToObject.pas';

var
  s: string;
  Updater: TMySqlUpdater;

begin
  try
    TLogger.Inst.LogPath := ERP_UTILITIES_LOG_DIR;
    TLogger.Inst.LogAllTypes;
    TLogger.Inst.Log('');
    TLogger.Inst.Log('MySQL Update ---------- Started');
    if ParamStr(1) <> '' then begin
      Updater:= TMySqlUpdater.Create;
      try
        Updater.NewMySQLInstallerName:= ParamStr(1);
        Updater.DebugMode := SameText(ParamStr(2),'DebugMode');
        Updater.DoUpdate;
      finally
        Updater.Free;
      end;
    end
    else begin
      TLogger.Inst.Log('  Can not process update, install parameter missing',ltError);
    end;
    TLogger.Inst.Log('MySQL Update ---------- Finished');
    Sleep(2000);
  except
    on e: exception do begin
      TLogger.Inst.Log('Exception: ' + e.Message, ltError);
      Sleep(5000);
    end;
  end;
end.
