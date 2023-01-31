program ErpUtilsServer;

uses
  ShareMem,
  Forms,
  frmErpUtilsServer in 'frmErpUtilsServer.pas' {fmErpUtilsServer},
  JsonRpcBase in '..\JsonRPC\JsonRpcBase.pas',
  JsonRpcConst in '..\JsonRPC\JsonRpcConst.pas',
  ModuleControl in '..\ModuleControl.pas',
  ModuleFunctions in '..\ModuleFunctions.pas',
  ModuleInfoObj in '..\ModuleInfoObj.pas',
  JsonRpcTcpServer in '..\JsonRPC\JsonRpcTcpServer.pas',
  ModuleUtils in '..\Modules\ModuleUtils.pas',
  UtilsServerObj in '..\UtilsServerObj.pas',
  ModuleBaseServerObj in '..\Modules\ModuleBaseServerObj.pas',
  ModuleConst in '..\Modules\ModuleConst.pas',
  ModuleBaseObj in '..\Modules\ModuleBaseObj.pas',
  frmModuleConfigBase in '..\Modules\frmModuleConfigBase.pas' {fmModuleConfigBase},
  ModuleBaseClientObj in '..\Modules\ModuleBaseClientObj.pas',
  JsonRpcTcpClient in '..\JsonRPC\JsonRpcTcpClient.pas',
  UpdaterCallUtils in '..\..\ERPUpdater\UpdaterCallUtils.pas',
  UpdaterConst in '..\..\ERPUpdater\UpdaterConst.pas',
  IpRangeListObj in '..\IpRangeListObj.pas',
  JSONObject in '..\..\..\Common\JSONObject.pas',
  JsonToObject in '..\..\..\Common\JsonToObject.pas',
  InternetConnectivityUtils in '..\..\..\Dev\General\Objects\CommonObjects\InternetConnectivityUtils.pas',
  FileDownloadFuncs in '..\..\..\Dev\General\Objects\CommonObjects\FileDownloadFuncs.pas',
  AppRunUtils in '..\..\..\Dev\General\Objects\CommonObjects\AppRunUtils.pas',
  SystemLib in '..\..\..\Dev\General\Objects\CommonObjects\SystemLib.pas',
  CipherUtils in '..\..\..\Common\CipherUtils.pas',
  MySQLUtils in '..\..\..\Common\MySQLUtils.pas',
  DbConst in '..\..\..\Common\DbConst.pas',
  InstallConst in '..\..\..\Common\InstallConst.pas',
  LogThreadLib in '..\..\..\Dev\General\Objects\CommonObjects\LogThreadLib.pas',
  MultiEventObj in '..\..\..\Dev\General\Objects\CommonObjects\MultiEventObj.pas',
  HTTPServerConfigObj in '..\HTTPServerConfigObj.pas',
  UtilsServerConfigObj in '..\UtilsServerConfigObj.pas',
  WebApiConst in '..\..\..\Common\WebApiConst.pas',
  LogThreadBase in '..\..\..\Dev\General\Objects\CommonObjects\LogThreadBase.pas',
  LogMessageTypes in '..\..\..\Dev\General\Objects\CommonObjects\LogMessageTypes.pas',
  SimplePipes in '..\..\..\Common\SimplePipes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmErpUtilsServer, fmErpUtilsServer);
  Application.Run;
end.
