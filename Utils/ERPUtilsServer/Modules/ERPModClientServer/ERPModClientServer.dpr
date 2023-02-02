program ERPModClientServer;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  ConsoleLogObj in '..\..\..\..\Common\ConsoleLogObj.pas',
  ModClientServer in 'ModClientServer.pas',
  ServerModuleObj in '..\..\..\..\Common\ServerModules\ServerModuleObj.pas',
  ModuleComms3 in '..\..\..\..\Common\ModuleComms3.pas',
  SimplePipes in '..\..\..\..\Common\SimplePipes.pas',
  ThreadProperty in '..\..\..\..\Common\ThreadProperty.pas',
  ServerModuleConst in '..\..\..\..\Common\ServerModules\ServerModuleConst.pas',
  ServerModuleThreadTask in '..\..\..\..\Common\ServerModules\ServerModuleThreadTask.pas',
  ModuleFileNameUtils in '..\..\..\..\Common\ModuleFileNameUtils.pas',
  JsonToObject in '..\..\..\..\Common\JsonToObject.pas',
  CipherUtils in '..\..\..\..\Common\CipherUtils.pas',
  IntegerListObj in '..\..\..\..\Dev\General\Objects\CommonObjects\IntegerListObj.pas',
  SystemLib in '..\..\..\..\Dev\General\Objects\CommonObjects\SystemLib.pas',
  JsonRPCUtils in '..\..\JsonRPC\JsonRPCUtils.pas',
  NotificationItem in '..\NotificationItem.pas',
  JsonRpcConst in '..\..\JsonRPC\JsonRpcConst.pas',
  ClientConfigObj in '..\UserUtils\ClientConfigObj.pas',
  DateTimeUtils in '..\..\..\..\Dev\General\Objects\CommonObjects\DateTimeUtils.pas',
  DbConst in '..\..\..\..\Common\DbConst.pas',
  ClientServerDbUtils in '..\ClientServer\ClientServerDbUtils.pas',
  InstallConst in '..\..\..\..\Common\InstallConst.pas',
  MySQLConst in '..\..\..\..\Common\MySQLConst.pas',
  ModulePortObj in '..\..\..\..\Common\ModulePortObj.pas',
  DBUtils in '..\..\..\..\Common\DBUtils.pas',
  DateTimeConvert in '..\..\..\..\Common\DateTimeConvert.pas',
  DbGen in '..\..\..\..\Common\DbGen.pas',
  MySQLUtils in '..\..\..\..\Common\MySQLUtils.pas',
  AppRunUtils in '..\..\..\..\Dev\General\Objects\CommonObjects\AppRunUtils.pas',
  DbSharedObjectsObj in '..\..\..\..\Dev\General\Objects\CommonObjects\DbSharedObjectsObj.pas',
  FileVersion in '..\..\..\..\Dev\General\Objects\CommonObjects\FileVersion.pas',
  AppEnvironmentVirtual in '..\UserUtils\AppEnvironmentVirtual.pas',
  AppEnvVirtualObj in '..\..\..\..\Common\AppEnvVirtualObj.pas',
  ProgressInfoObj in '..\..\..\..\Common\ProgressInfoObj.pas',
  MachineSignature in '..\UserUtils\MachineSignature.pas',
  ModuleConst in '..\ModuleConst.pas',
  DecimalRounding in '..\..\..\..\Dev\General\Objects\CommonObjects\DecimalRounding.pas',
  ConfigDbObj in '..\..\..\..\Common\ConfigDbObj.pas',
  LogThreadBase in '..\..\..\..\Dev\General\Objects\CommonObjects\LogThreadBase.pas',
  LogThreadLib in '..\..\..\..\Dev\General\Objects\CommonObjects\LogThreadLib.pas',
  JsonObjectUtils in '..\..\..\..\Common\JsonObjectUtils.pas',
  utDbServerThreadTaskList in '..\..\..\..\Common\utDbServerThreadTaskList.pas',
  utCloudconst in '..\ERPModWebAPI\utCloudconst.pas',
  ERPLicenseLib in '..\ERPModUserUtils\ERPLicenseLib.pas',
  ModuleDbUtils in '..\ModuleDbUtils.pas',
  JSONObject in '..\..\..\..\Common\JSONObject.pas',
  LogMessageTypes in '..\..\..\..\Dev\General\Objects\CommonObjects\LogMessageTypes.pas';

{$R *.RES}

var
  ServerModule1: TModClientServer;
  ConsoleLogger: TConsoleLogger;

begin
  ServerModule1 := TModClientServer.Create;
  ConsoleLogger := TConsoleLogger.Create(ServerModule1);
  try
    ServerModule1.Execute;
  finally
    ServerModule1.Free;
    ConsoleLogger.Free;
  end;
end.
