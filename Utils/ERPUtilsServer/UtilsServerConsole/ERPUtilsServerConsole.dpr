program ERPUtilsServerConsole;

{$APPTYPE CONSOLE}

uses
  ShareMem,
  SysUtils,
  JsonRpcBase in '..\JsonRPC\JsonRpcBase.pas',
  JsonRpcConst in '..\JsonRPC\JsonRpcConst.pas',
  ModuleFunctions in '..\ModuleFunctions.pas',
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
  SimplePipes in '..\..\..\Common\SimplePipes.pas',
  ThreadProperty in '..\..\..\Common\ThreadProperty.pas',
  ModuleFileNameUtils in '..\..\..\Common\ModuleFileNameUtils.pas',
  IntegerListObj in '..\..\..\Dev\General\Objects\CommonObjects\IntegerListObj.pas',
  ServerModuleConst in '..\..\..\Common\ServerModules\ServerModuleConst.pas',
  ServerModuleStubObj in '..\..\..\Common\ServerModules\ServerModuleStubObj.pas',
  NotificationItem in '..\Modules\NotificationItem.pas',
  JsonRPCUtils in '..\JsonRPC\JsonRPCUtils.pas',
  ClientConfigObj in '..\Modules\UserUtils\ClientConfigObj.pas',
  JsonObjectUtils in '..\..\..\Common\JsonObjectUtils.pas',
  DateTimeUtils in '..\..\..\Dev\General\Objects\CommonObjects\DateTimeUtils.pas',
  ServerModuleList in '..\Modules\ServerModuleList.pas',
  ModuleComms3 in '..\..\..\Common\ModuleComms3.pas',
  DbSharedObjectsObj in '..\..\..\Dev\General\Objects\CommonObjects\DbSharedObjectsObj.pas',
  ModulePortObj in '..\..\..\Common\ModulePortObj.pas',
  DBUtils in '..\..\..\Common\DBUtils.pas',
  DateTimeConvert in '..\..\..\Common\DateTimeConvert.pas',
  HTTPConst in '..\..\..\Common\HTTPConst.pas',
  DbGen in '..\..\..\Common\DbGen.pas',
  ConfigDbObj in '..\..\..\Common\ConfigDbObj.pas',
  utDbServerThreadTaskList in '..\..\..\Common\utDbServerThreadTaskList.pas',
  utVS1Const in '..\Modules\ERPModWebAPI\utVS1Const.pas',
  StSConst in '..\..\..\Dev\SeedTosale\Modules\StSConst.pas',
  utCloudconst in '..\Modules\ERPModWebAPI\utCloudconst.pas',
  ERPLicenseLib in '..\Modules\ERPModUserUtils\ERPLicenseLib.pas',
  ModuleDbUtils in '..\Modules\ModuleDbUtils.pas';

type
  TLogEventHandler = class
  public
    procedure DoLogEvent(Sender: TObject; const Event, Value : string);
  end;

var
  Server: TUtilsServer;
  fLogger: TLogger;
  LogEventHandler: TLogEventHandler;



{ TLogEventHandler }

procedure TLogEventHandler.DoLogEvent(Sender: TObject; const Event,
  Value: string);
begin
  Writeln(Value);
end;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    WriteLn('Starting ERPUtilsServer.');
    WriteLn('Press the ENTER key to stop');

    LogEventHandler:= TLogEventHandler.Create;
    fLogger:= TLogger.Create(nil);
    fLogger.LogAllTypes;
    fLogger.Events.AddMultiEvent(LogEventHandler.DoLogEvent);
    Server:= TUtilsServer.Create(fLogger);
    try
      Server.Active:= true;
      ReadLn;
    finally
      Server.Free;
      fLogger.Free;
      LogEventHandler.Free;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
