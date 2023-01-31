program ERPModSiteIntegration;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  ConsoleLogObj in '..\..\..\..\Common\ConsoleLogObj.pas',
  ModSiteIntegration in 'ModSiteIntegration.pas',
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
  BusObjSchemaLib in '..\..\..\..\Dev\BusinessObjects\BusObjSchemaLib.pas',
  ApiObjectListObj in '..\SiteIntegration\ApiObjectListObj.pas',
  WebApiClientObj in '..\..\..\..\Common\WebApiClientObj.pas',
  WebApiConst in '..\..\..\..\Common\WebApiConst.pas',
  ConfigDbObj in '..\..\..\..\Common\ConfigDbObj.pas',
  MySQLUtils in '..\..\..\..\Common\MySQLUtils.pas',
  DbConst in '..\..\..\..\Common\DbConst.pas',
  AppRunUtils in '..\..\..\..\Dev\General\Objects\CommonObjects\AppRunUtils.pas',
  SynchReportObj in '..\SiteIntegration\SynchReportObj.pas',
  MySQLConst in '..\..\..\..\Common\MySQLConst.pas',
  JsonObjectUtils in '..\..\..\..\Common\JsonObjectUtils.pas',
  URILib in '..\..\..\..\Common\URILib.pas',
  UURIEncode in '..\..\..\..\Common\UURIEncode.pas',
  ModuleUtils in '..\ModuleUtils.pas',
  LogThreadDbLib in '..\..\..\..\Dev\General\Objects\CommonObjects\LogThreadDbLib.pas',
  JSONObject in '..\..\..\..\Common\JSONObject.pas',
  DbSharedObjectsObj in '..\..\..\..\Dev\General\Objects\CommonObjects\DbSharedObjectsObj.pas',
  ModulePortObj in '..\..\..\..\Common\ModulePortObj.pas',
  DBUtils in '..\..\..\..\Common\DBUtils.pas';

var
  ServerModule1: TModSiteIntegration;
  ConsoleLogger: TConsoleLogger;

{$R *.res}

begin
  ServerModule1 := TModSiteIntegration.Create;
  ConsoleLogger := TConsoleLogger.Create(ServerModule1);
  try
    ServerModule1.Execute;
  finally
    ServerModule1.Free;
    ConsoleLogger.Free;
  end;
end.
