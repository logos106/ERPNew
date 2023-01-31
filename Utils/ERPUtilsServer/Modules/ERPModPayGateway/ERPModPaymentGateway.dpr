program ERPModPaymentGateway;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  ShareMem,
  Sysutils,
  StrUtils,
  ModPaymentGateway in 'ModPaymentGateway.pas',
  ServerModuleObj in '..\..\..\..\Common\ServerModules\ServerModuleObj.pas',
  LogThreadBase in '..\..\..\..\Dev\General\Objects\CommonObjects\LogThreadBase.pas',
  LogMessageTypes in '..\..\..\..\Dev\General\Objects\CommonObjects\LogMessageTypes.pas',
  MultiEventObj in '..\..\..\..\Dev\General\Objects\CommonObjects\MultiEventObj.pas',
  LogThreadLib in '..\..\..\..\Dev\General\Objects\CommonObjects\LogThreadLib.pas',
  ModuleComms3 in '..\..\..\..\Common\ModuleComms3.pas',
  ThreadProperty in '..\..\..\..\Common\ThreadProperty.pas',
  ServerModuleConst in '..\..\..\..\Common\ServerModules\ServerModuleConst.pas',
  IntegerListObj in '..\..\..\..\Dev\General\Objects\CommonObjects\IntegerListObj.pas',
  ModulePortObj in '..\..\..\..\Common\ModulePortObj.pas',
  DbGen in '..\..\..\..\Common\DbGen.pas',
  DbConst in '..\..\..\..\Common\DbConst.pas',
  JSONObject in '..\..\..\..\Common\JSONObject.pas',
  ServerModuleThreadTask in '..\..\..\..\Common\ServerModules\ServerModuleThreadTask.pas',
  ModuleFileNameUtils in '..\..\..\..\Common\ModuleFileNameUtils.pas',
  JsonToObject in '..\..\..\..\Common\JsonToObject.pas',
  SystemLib in '..\..\..\..\Dev\General\Objects\CommonObjects\SystemLib.pas',
  JsonRPCUtils in '..\..\JsonRPC\JsonRPCUtils.pas',
  NotificationItem in '..\NotificationItem.pas',
  FileVersion in '..\..\..\..\Dev\General\Objects\CommonObjects\FileVersion.pas',
  ConsoleLogObj in '..\..\..\..\Common\ConsoleLogObj.pas',
  JsonRpcConst in '..\..\JsonRPC\JsonRpcConst.pas',
  LogThreadDbLib in '..\..\..\..\Dev\General\Objects\CommonObjects\LogThreadDbLib.pas',
  GatewayBase in 'GatewayBase.pas',
  GatewayStripe in 'Stripe\GatewayStripe.pas',
  CreditCardObj in '..\..\..\..\Common\CreditCardObj.pas',
  EncryptFix in '..\..\..\..\Common\EncryptFix.pas',
  URILib in '..\..\..\..\Common\URILib.pas',
  CardPaymentObj in '..\..\..\..\Common\CardPaymentObj.pas',
  ObjectStorer in '..\..\..\..\Common\ObjectStorer.pas',
  PXWS in 'PaymentExpress\PXWS.pas',
  TrueErpLib_Import in '..\..\TrueERPLibDll\TrueErpLib_Import.pas',
  PaymentGatewayConst in 'PaymentGatewayConst.pas',
  GatewayPaymentExpress in 'PaymentExpress\GatewayPaymentExpress.pas',
  PayeezySOAP in 'PayEezy\PayeezySOAP.pas',
  GatewayPayeezy in 'PayEezy\GatewayPayeezy.pas',
  MerchantWebServices_v1_Cert in 'TransactionExpress\MerchantWebServices_v1_Cert.pas',
  MerchantWebServices_v1_Prod in 'TransactionExpress\MerchantWebServices_v1_Prod.pas',
  GatewayTransactionExpress in 'TransactionExpress\GatewayTransactionExpress.pas',
  TransactionExpressUtils in 'TransactionExpress\TransactionExpressUtils.pas',
  CipherUtils in '..\..\..\..\Common\CipherUtils.pas',
  MySQLUtils in '..\..\..\..\Common\MySQLUtils.pas',
  AppRunUtils in '..\..\..\..\Dev\General\Objects\CommonObjects\AppRunUtils.pas',
  DbSharedObjectsObj in '..\..\..\..\Dev\General\Objects\CommonObjects\DbSharedObjectsObj.pas',
  InstallConst in '..\..\..\..\Common\InstallConst.pas',
  AppEnvironmentVirtual in '..\UserUtils\AppEnvironmentVirtual.pas',
  AppEnvVirtualObj in '..\..\..\..\Common\AppEnvVirtualObj.pas',
  ProgressInfoObj in '..\..\..\..\Common\ProgressInfoObj.pas',
  MachineSignature in '..\UserUtils\MachineSignature.pas',
  ModuleConst in '..\ModuleConst.pas',
  DecimalRounding in '..\..\..\..\Dev\General\Objects\CommonObjects\DecimalRounding.pas',
  DateTimeUtils in '..\..\..\..\Dev\General\Objects\CommonObjects\DateTimeUtils.pas',
  DateTimeConvert in '..\..\..\..\Common\DateTimeConvert.pas',
  ConfigDbObj in '..\..\..\..\Common\ConfigDbObj.pas',
  ClientConfigObj in '..\UserUtils\ClientConfigObj.pas',
  utDbServerThreadTaskList in '..\..\..\..\Common\utDbServerThreadTaskList.pas';

var
  ServerModule1: TModPaymentGateway;
  ConsoleLogger: TConsoleLogger;
  Logger: TLogger;
  s: string;
{$R *.res}

begin
  Logger := TLogger.Create(nil);
  try
    s := Lowercase(Logger.LogPath);
    if System.Pos('modules\log',s) > 0 then begin
      s := StrUtils.ReplaceStr(s,'modules\log','log');
      Logger.LogPath := s;
      Logger.LogAllTypes;
    end;
    try

      ServerModule1 := TModPaymentGateway.Create(Logger);
      ConsoleLogger := TConsoleLogger.Create(ServerModule1);
      try
        ServerModule1.Execute;
      finally
        ServerModule1.Free;
        ConsoleLogger.Free;
      end;
    except
      on e: exception do begin
        Logger.Log('Exception Creating Module: ' + e.Message,ltError);
      end;
    end;
  finally
    Logger.Free;
  end;
end.
