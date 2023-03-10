program ERPServiceMenu;

uses
  Forms,
  frmMain in 'frmMain.pas' {fmMain},
  UserUtilsClientObj in '..\..\..\Dev\General\Objects\CommonObjects\UserUtilsClientObj.pas',
  JsonRpcBase in '..\JsonRPC\JsonRpcBase.pas',
  JsonRpcConst in '..\JsonRPC\JsonRpcConst.pas',
  JsonRpcTcpClient in '..\JsonRPC\JsonRpcTcpClient.pas',
  OpProgressObj in '..\..\..\Dev\General\Objects\CommonObjects\OpProgressObj.pas',
  JSONObject in '..\..\..\Common\JSONObject.pas',
  JsonToObject in '..\..\..\Common\JsonToObject.pas',
  CipherUtils in '..\..\..\Common\CipherUtils.pas',
  ModuleConst in '..\Modules\ModuleConst.pas',
  UtilsLib in '..\..\..\Common\UtilsLib.pas',
  fraUtilsConfigBase in 'fraUtilsConfigBase.pas' {frUtilsConfigBase: TFrame},
  fraUtilsServerConfig in 'fraUtilsServerConfig.pas' {frUtilsServerConfig: TFrame},
  fraModUserUtilsConfig in 'fraModUserUtilsConfig.pas' {frModUserUtilsConfig: TFrame},
  frmModuleLog in 'frmModuleLog.pas' {fmModuleLog},
  frmDatabaseBackup in '..\..\..\Dev\General\InputForms\frmDatabaseBackup.pas',
  frmArchiveSelect in 'frmArchiveSelect.pas' {fmArchiveSelect},
  ModalInputBoxGUI in '..\..\..\Dev\General\InputForms\ModalInputBoxGUI.pas',
  fraModWebAPIConfig in 'fraModWebAPIConfig.pas' {frModWebAPIConfig: TFrame},
  fraModGoogleConfig in 'fraModGoogleConfig.pas' {frModGoogleConfig: TFrame},
  fraModSiteIntegrationConfig in 'fraModSiteIntegrationConfig.pas' {frModSiteIntegrationConfig: TFrame},
  fraModGenericConfig in 'fraModGenericConfig.pas' {frModGenericConfig: TFrame},
  fraModClientServerConfig in 'fraModClientServerConfig.pas' {frModClientServerConfig: TFrame},
  frmWebAPITestSteps in '..\Tester\frmWebAPITestSteps.pas',
  WebApiTestObj in '..\Tester\WebApiTestObj.pas',
  TesterObj in '..\Tester\TesterObj.pas',
  MySQLUtils in '..\..\..\Common\MySQLUtils.pas',
  DbConst in '..\..\..\Common\DbConst.pas',
  AppRunUtils in '..\..\..\Dev\General\Objects\CommonObjects\AppRunUtils.pas',
  SimpleEncrypt in '..\..\..\Common\SimpleEncrypt.pas',
  UtilsTestObj in '..\Tester\UtilsTestObj.pas',
  frmBaseTestSteps in '..\Tester\frmBaseTestSteps.pas',
  TestItemGUI in '..\Tester\TestItemGUI.pas',
  FileVersion in '..\..\..\Dev\General\Objects\CommonObjects\FileVersion.pas',
  fraModEBay in 'fraModEBay.pas' {frModEbay: TFrame},
  frmConfigBase in 'frmConfigBase.pas' {fmConfigBase},
  frmIntegrationEbayConfig in 'frmIntegrationEbayConfig.pas' {fmIntegrationEbayConfig},
  ConfigDbObj in '..\..\..\Common\ConfigDbObj.pas',
  frmEbayConfigurationSteps in 'frmEbayConfigurationSteps.pas' {fmEbayConfigurationSteps},
  frmERPCommsTestSteps in '..\Tester\frmERPCommsTestSteps.pas' {fmERPCommsTestSteps},
  ERPCommsTestObj in '..\Tester\ERPCommsTestObj.pas',
  InternetConnectivityUtils in '..\..\..\Dev\General\Objects\CommonObjects\InternetConnectivityUtils.pas',
  AppEnvironmentVirtual in '..\Modules\UserUtils\AppEnvironmentVirtual.pas',
  AppEnvVirtualObj in '..\..\..\Common\AppEnvVirtualObj.pas',
  ProgressInfoObj in '..\..\..\Common\ProgressInfoObj.pas',
  MachineSignature in '..\Modules\UserUtils\MachineSignature.pas',
  VersionUtils in '..\..\..\Common\VersionUtils.pas',
  InstallConst in '..\..\..\Common\InstallConst.pas',
  RandomUtils in '..\..\..\Common\RandomUtils.pas',
  DbSharedObjectsObj in '..\..\..\Dev\General\Objects\CommonObjects\DbSharedObjectsObj.pas',
  MySQLConst in '..\..\..\Common\MySQLConst.pas',
  DecimalRounding in '..\..\..\Dev\General\Objects\CommonObjects\DecimalRounding.pas',
  fraModCustomConfig in 'fraModCustomConfig.pas' {frModCustomConfig: TFrame},
  LogThreadDbLib in '..\..\..\Dev\General\Objects\CommonObjects\LogThreadDbLib.pas',
  UpdateStoreObj in '..\Modules\UpdateStoreObj.pas',
  ModuleDbUtils in '..\Modules\ModuleDbUtils.pas',
  ThreadDataset in '..\..\..\Dev\General\Objects\CommonObjects\ThreadDataset.pas',
  SystemLib in '..\..\..\Dev\General\Objects\CommonObjects\SystemLib.pas',
  frmStandAloneConfigBase in 'frmStandAloneConfigBase.pas' {fmStandAloneConfigBase},
  OffsiteBackupConfigObj in '..\Modules\ERPModUserUtils\OffsiteBackupConfigObj.pas',
  frmServerLogList in '..\Modules\frmServerLogList.pas',
  HTTPConst in '..\..\..\Common\HTTPConst.pas',
  DateTimeUtils in '..\..\..\Dev\General\Objects\CommonObjects\DateTimeUtils.pas',
  DateTimeConvert in '..\..\..\Common\DateTimeConvert.pas',
  DbGen in '..\..\..\Common\DbGen.pas',
  CreditCardObj in '..\..\..\Common\CreditCardObj.pas',
  EncryptFix in '..\..\..\Common\EncryptFix.pas',
  HTTPUtils in '..\..\..\Common\HTTPUtils.pas',
  PreferancesLib in '..\..\..\Dev\Utilities\Modules\PreferancesLib.pas',
  eBayConfig in '..\Modules\ebayIntegration\eBayConfig.pas',
  DialogUtils in '..\..\..\Common\DialogUtils.pas',
  utDbServerThreadTaskList in '..\..\..\Common\utDbServerThreadTaskList.pas' {$R *.res},
  IntegerListObj in '..\..\..\Dev\General\Objects\CommonObjects\IntegerListObj.pas',
  ServiceMenuLib in 'ServiceMenuLib.pas',
  LogMessageTypes in '..\..\..\Dev\General\Objects\CommonObjects\LogMessageTypes.pas',
  LogThreadLib in '..\..\..\Dev\General\Objects\CommonObjects\LogThreadLib.pas',
  LogThreadBase in '..\..\..\Dev\General\Objects\CommonObjects\LogThreadBase.pas',
  utCloudconst in '..\Modules\ERPModWebAPI\utCloudconst.pas',
  utVS1Const in '..\Modules\ERPModWebAPI\utVS1Const.pas',
  StSConst in '..\..\..\Dev\SeedTosale\Modules\StSConst.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'ERP Service Menu';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
