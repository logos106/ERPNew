library UserUtils;

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
  ShareMem,
  SysUtils,
  Classes,
  JsonRpcBase in '..\..\JsonRPC\JsonRpcBase.pas',
  ModuleUtils in '..\ModuleUtils.pas',
  JsonRpcConst in '..\..\JsonRPC\JsonRpcConst.pas',
  UserUtilsLib in 'UserUtilsLib.pas',
  JsonObjectUtils in '..\..\..\..\Common\JsonObjectUtils.pas',
  ModuleConfigObj in '..\ModuleConfigObj.pas',
  ClientConfigObj in 'ClientConfigObj.pas',
  MachineSignature in 'MachineSignature.pas',
  LogThreadLib in '..\..\..\..\Dev\General\Objects\CommonObjects\LogThreadLib.pas',
  JsonRpcTcpClient in '..\..\JsonRPC\JsonRpcTcpClient.pas',
  ModuleUserUtilsObj in 'ModuleUserUtilsObj.pas',
  ModuleBaseServerObj in '..\ModuleBaseServerObj.pas',
  ModuleBaseObj in '..\ModuleBaseObj.pas',
  ModuleConst in '..\ModuleConst.pas',
  ObjUpdateLib in '..\ObjUpdateLib.pas',
  ModuleDbUtils in '..\ModuleDbUtils.pas',
  ErpDbInfo in 'ErpDbInfo.pas',
  AppUserListObj in 'AppUserListObj.pas',
  DBBackupObj in '..\DBBackupObj.pas',
  OpProgressObj in '..\..\..\..\Dev\General\Objects\CommonObjects\OpProgressObj.pas',
  ErpDbUpdaterObj in '..\ErpDbUpdaterObj.pas',
  UpdaterConst in '..\..\..\ERPUpdater\UpdaterConst.pas',
  JsonToObject in '..\..\..\..\Common\JsonToObject.pas',
  JSONObject in '..\..\..\..\Common\JSONObject.pas',
  FileDownloadFuncs in '..\..\..\..\Dev\General\Objects\CommonObjects\FileDownloadFuncs.pas',
  CipherUtils in '..\..\..\..\Common\CipherUtils.pas',
  InternetConnectivityUtils in '..\..\..\..\Dev\General\Objects\CommonObjects\InternetConnectivityUtils.pas',
  SystemLib in '..\..\..\..\Dev\General\Objects\CommonObjects\SystemLib.pas',
  EncryptFix in '..\..\..\..\Common\EncryptFix.pas',
  UpdateStoreObj in '..\UpdateStoreObj.pas',
  DbConst in '..\..\..\..\Common\DbConst.pas',
  InstallConst in '..\..\..\..\Common\InstallConst.pas',
  AppRunUtils in '..\..\..\..\Dev\General\Objects\CommonObjects\AppRunUtils.pas',
  MySQLUtils in '..\..\..\..\Common\MySQLUtils.pas',
  MySQLIniFile in '..\..\..\..\Common\MySQLIniFile.pas',
  ThreadDataset in '..\..\..\..\Dev\General\Objects\CommonObjects\ThreadDataset.pas',
  DataFixLib in '..\..\..\Fixes\DataFixLib.pas',
  ErpDbMaintObj in 'ErpDbMaintObj.pas',
  UtilsLib in '..\..\..\..\Common\UtilsLib.pas',
  DBUtils in '..\Multisite\DBUtils.pas',
  DatafixObj in '..\..\..\Fixes\DatafixObj.pas',
  LogThreadBase in '..\..\..\..\Dev\General\Objects\CommonObjects\LogThreadBase.pas',
  LogMessageTypes in '..\..\..\..\Dev\General\Objects\CommonObjects\LogMessageTypes.pas',
  ThreadTaskObj in 'ThreadTaskObj.pas',
  BackupThreadTaskObj in 'BackupThreadTaskObj.pas',
  MultiEventObj in '..\..\..\..\Dev\General\Objects\CommonObjects\MultiEventObj.pas',
  DateTimeUtils in '..\..\..\..\Dev\General\Objects\CommonObjects\DateTimeUtils.pas',
  IntegerListObj in '..\..\..\..\Dev\General\Objects\CommonObjects\IntegerListObj.pas',
  AppEnvironmentVirtual in 'AppEnvironmentVirtual.pas',
  AppEnvVirtualObj in '..\..\..\..\Common\AppEnvVirtualObj.pas',
  ProgressInfoObj in '..\..\..\..\Common\ProgressInfoObj.pas',
  TransactionsTable in '..\..\..\..\Dev\Accounts\Objects\TransactionsTable.pas',
  TableFunctionsObj in '..\..\..\..\Dev\Utilities\Objects\TableFunctionsObj.pas',
  UserLockObj in '..\..\..\..\Dev\General\Objects\CommonObjects\UserLockObj.pas',
  UserLockBaseObj in '..\..\..\..\Dev\General\Objects\CommonObjects\UserLockBaseObj.pas',
  MySQLConst in '..\..\..\..\Common\MySQLConst.pas',
  DNMExceptions in '..\..\..\..\Dev\General\Objects\DNMExceptions.pas',
  StockCostSystemsObj in '..\..\..\..\Dev\Inventory\Objects\StockCostSystemsObj.pas',
  Rounding in '..\..\..\..\Dev\General\Objects\CommonObjects\Rounding.pas',
  DecimalRounding in '..\..\..\..\Dev\General\Objects\CommonObjects\DecimalRounding.pas',
  ProductRewardPointsLib in '..\..\..\..\Dev\Clients\Customers\Objects\ProductRewardPointsLib.pas',
  AccruedLeaveLiabilitiesAdj in '..\..\..\..\Dev\Payroll\Objects\AccruedLeaveLiabilitiesAdj.pas',
  SyncReportTableObj in '..\..\..\..\Dev\Utilities\Objects\SyncReportTableObj.pas',
  TempTableUtils in '..\..\..\..\Dev\General\Objects\CommonObjects\TempTableUtils.pas',
  InventoryTypes in '..\..\..\..\Dev\Inventory\Objects\InventoryTypes.pas',
  MergeObj in '..\..\..\..\Dev\General\Objects\MergeObj.pas',
  BatchUpdateThreadTaskObj in 'BatchUpdateThreadTaskObj.pas',
  EmailThreadTaskObj in 'EmailThreadTaskObj.pas',
  EmailConst in '..\..\..\..\Common\EmailConst.pas',
  MailReaderObj in '..\..\..\..\Common\MailReaderObj.pas',
  SimpleEncrypt in '..\..\..\..\Common\SimpleEncrypt.pas',
  ERPDbListObj in '..\..\..\..\Common\ERPDbListObj.pas',
  RandomUtils in '..\..\..\..\Common\RandomUtils.pas',
  ProductQtyLib in '..\..\..\..\Dev\Inventory\Module\ProductQtyLib.pas',
  SharedAppUserListObj in '..\SharedAppUserListObj.pas',
  ModuleServerUtils in '..\ModuleServerUtils.pas';

{$R *.res}

exports
  GetModule;

begin
end.
