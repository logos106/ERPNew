program ERPUpdater;

{.$APPTYPE CONSOLE}
//{$R 'Win7UAC.res'}


uses
  SysUtils,
  ERPUpdaterObj in 'ERPUpdaterObj.pas',
  LogThreadLib in '..\..\Dev\General\Objects\CommonObjects\LogThreadLib.pas',
  LogMessageTypes in '..\..\Dev\General\Objects\CommonObjects\LogMessageTypes.pas',
  UpdaterConst in 'UpdaterConst.pas',
  UpdaterCallUtils in 'UpdaterCallUtils.pas',
  AppRunUtils in '..\..\Dev\General\Objects\CommonObjects\AppRunUtils.pas',
  FileVersion in '..\..\Dev\General\Objects\CommonObjects\FileVersion.pas',
  CipherUtils in '..\..\Common\CipherUtils.pas',
  JsonToObject in '..\..\Common\JsonToObject.pas',
  JSONObject in '..\..\Common\JSONObject.pas',
  JsonObjectUtils in '..\..\Common\JsonObjectUtils.pas',
  FileDownloadFuncs in '..\..\Dev\General\Objects\CommonObjects\FileDownloadFuncs.pas',
  SystemLib in '..\..\Dev\General\Objects\CommonObjects\SystemLib.pas',
  InternetConnectivityUtils in '..\..\Dev\General\Objects\CommonObjects\InternetConnectivityUtils.pas',
  JsonRpcBase in '..\ERPUtilsServer\JsonRPC\JsonRpcBase.pas',
  JsonRpcConst in '..\ERPUtilsServer\JsonRPC\JsonRpcConst.pas',
  JsonRpcTcpClient in '..\ERPUtilsServer\JsonRPC\JsonRpcTcpClient.pas',
  ModuleConst in '..\ERPUtilsServer\Modules\ModuleConst.pas',
  LogThreadBase in '..\..\Dev\General\Objects\CommonObjects\LogThreadBase.pas',
  VersionUtils in '..\..\Common\VersionUtils.pas',
  InstallConst in '..\..\Common\InstallConst.pas',
  HTTPConst in '..\..\Common\HTTPConst.pas',
  utCloudconst in '..\ERPUtilsServer\Modules\ERPModWebAPI\utCloudconst.pas';

begin
  try
    TLogger.Inst.LogAllTypes;
    TLogger.Inst.Log('',ltInfo);
    TLogger.Inst.Log('ERP Updater ---------- Started',ltInfo);
    Updater := TERPUpdater.Create;
    TLogger.Inst.Log('Path: ' + Updater.Path,ltDetail);
    try
      Updater.DoUpdate;
    finally
      Updater.Free;
    end;
    TLogger.Inst.Log('ERP Updater ---------- Finished',ltInfo);
    Sleep(1000);
  except

  end;
end.
