program ERPModGoogle;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  ModGoogle in 'ModGoogle.pas',
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
  AnalyticsObj in 'AnalyticsObj.pas',
  AnalyticsDb in 'AnalyticsDb.pas',
  MySQLUtils in '..\..\..\..\Common\MySQLUtils.pas',
  DbConst in '..\..\..\..\Common\DbConst.pas',
  AppRunUtils in '..\..\..\..\Dev\General\Objects\CommonObjects\AppRunUtils.pas',
  ConsoleLogObj in '..\..\..\..\Common\ConsoleLogObj.pas',
  DBUtils in '..\..\..\..\Common\DBUtils.pas',
  SharedAppUserListObj in '..\SharedAppUserListObj.pas',
  MySQLConst in '..\..\..\..\Common\MySQLConst.pas',
  DateTimeUtils in '..\..\..\..\Dev\General\Objects\CommonObjects\DateTimeUtils.pas',
  ModuleConst in '..\ModuleConst.pas',
  ERPDbListObj in '..\..\..\..\Common\ERPDbListObj.pas',
  ModuleDbUtils in '..\ModuleDbUtils.pas',
  DbSharedObjectsObj in '..\..\..\..\Dev\General\Objects\CommonObjects\DbSharedObjectsObj.pas',
  ModulePortObj in '..\..\..\..\Common\ModulePortObj.pas',
  InstallConst in '..\..\..\..\Common\InstallConst.pas',
  DateTimeConvert in '..\..\..\..\Common\DateTimeConvert.pas',
  DbGen in '..\..\..\..\Common\DbGen.pas',
  FileVersion in '..\..\..\..\Dev\General\Objects\CommonObjects\FileVersion.pas',
  HTTPConst in '..\..\..\..\Common\HTTPConst.pas',
  AppEnvironmentVirtual in '..\UserUtils\AppEnvironmentVirtual.pas',
  AppEnvVirtualObj in '..\..\..\..\Common\AppEnvVirtualObj.pas',
  ProgressInfoObj in '..\..\..\..\Common\ProgressInfoObj.pas',
  MachineSignature in '..\UserUtils\MachineSignature.pas',
  DecimalRounding in '..\..\..\..\Dev\General\Objects\CommonObjects\DecimalRounding.pas',
  ConfigDbObj in '..\..\..\..\Common\ConfigDbObj.pas',
  utDbServerThreadTaskList in '..\..\..\..\Common\utDbServerThreadTaskList.pas';

var
  ServerModule1: TModGoogle;
  ConsoleLogger: TConsoleLogger;

{$R *.res}

begin
  ServerModule1 := TModGoogle.Create;
  ConsoleLogger := TConsoleLogger.Create(ServerModule1);
  try
    ServerModule1.Execute;
  finally
    ServerModule1.Free;
    ConsoleLogger.Free;
  end;
end.
