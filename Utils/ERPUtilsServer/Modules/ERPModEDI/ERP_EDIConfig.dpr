program ERP_EDIConfig;

uses
  Forms,
  frmEDIConfigMain in 'frmEDIConfigMain.pas' {fmEDIConfigMain},
  frmStandAloneConfigBase in '..\..\ServiceMenu\frmStandAloneConfigBase.pas',
  UserUtilsClientObj in '..\..\..\..\Dev\General\Objects\CommonObjects\UserUtilsClientObj.pas',
  OpProgressObj in '..\..\..\..\Dev\General\Objects\CommonObjects\OpProgressObj.pas',
  JsonRpcBase in '..\..\JsonRPC\JsonRpcBase.pas',
  JsonRpcConst in '..\..\JsonRPC\JsonRpcConst.pas',
  JsonRpcTcpClient in '..\..\JsonRPC\JsonRpcTcpClient.pas',
  JsonToObject in '..\..\..\..\Common\JsonToObject.pas',
  CipherUtils in '..\..\..\..\Common\CipherUtils.pas',
  ModuleConst in '..\ModuleConst.pas',
  UtilsLib in '..\..\..\..\Common\UtilsLib.pas',
  AppEnvVirtualObj in '..\..\..\..\Common\AppEnvVirtualObj.pas',
  DbSharedObjectsObj in '..\..\..\..\Dev\General\Objects\CommonObjects\DbSharedObjectsObj.pas',
  AppEnvironmentVirtual in '..\UserUtils\AppEnvironmentVirtual.pas',
  ProgressInfoObj in '..\..\..\..\Common\ProgressInfoObj.pas',
  MachineSignature in '..\UserUtils\MachineSignature.pas',
  DecimalRounding in '..\..\..\..\Dev\General\Objects\CommonObjects\DecimalRounding.pas',
  VersionUtils in '..\..\..\..\Common\VersionUtils.pas',
  InstallConst in '..\..\..\..\Common\InstallConst.pas',
  TempTableUtils in '..\..\..\..\Dev\General\Objects\CommonObjects\TempTableUtils.pas',
  RandomUtils in '..\..\..\..\Common\RandomUtils.pas',
  MySQLConst in '..\..\..\..\Common\MySQLConst.pas',
  MySQLUtils in '..\..\..\..\Common\MySQLUtils.pas',
  AppRunUtils in '..\..\..\..\Dev\General\Objects\CommonObjects\AppRunUtils.pas',
  DbConst in '..\..\..\..\Common\DbConst.pas',
  FileVersion in '..\..\..\..\Dev\General\Objects\CommonObjects\FileVersion.pas',
  ModEDIConfigObj in 'ModEDIConfigObj.pas',
  EDIMapConfigObj in 'EDIMapConfigObj.pas',
  JsonDbPrefsConfigObj in '..\..\..\..\Common\JsonDbPrefsConfigObj.pas',
  JSONObject in '..\..\..\..\Common\JSONObject.pas',
  frmEDITrigger in 'frmEDITrigger.pas' {fmEDITrigger},
  frmEDIMapper in 'frmEDIMapper.pas' {fmEDIMapper},
  fraEDIFileCSV in 'fraEDIFileCSV.pas' {frEDIFileCSV: TFrame},
  StringUtils in '..\..\..\..\Common\StringUtils.pas',
  frmEDIColumnEdit in 'frmEDIColumnEdit.pas' {fmEDIColumnEdit},
  fraEDIMap in 'fraEDIMap.pas' {frEDIMap: TFrame},
  frmEDIMapEdit in 'frmEDIMapEdit.pas' {fmEDIMapEdit},
  frmEDIDataFilter in 'frmEDIDataFilter.pas' {fmEDIDataFilter},
  JsonObjectUtils in '..\..\..\..\Common\JsonObjectUtils.pas',
  EDIUtils in 'EDIUtils.pas',
  EmailUtilsSimple in '..\ERPModUserUtils\EmailUtilsSimple.pas',
  MailServerConst in '..\..\..\..\Common\MailServerConst.pas',
  CreditCardObj in '..\..\..\..\Common\CreditCardObj.pas',
  DbGen in '..\..\..\..\Common\DbGen.pas',
  EncryptFix in '..\..\..\..\Common\EncryptFix.pas',
  DateTimeUtils in '..\..\..\..\Dev\General\Objects\CommonObjects\DateTimeUtils.pas',
  DateTimeConvert in '..\..\..\..\Common\DateTimeConvert.pas',
  ERPServerDetailsObj in '..\..\..\..\Dev\General\Objects\CommonObjects\ERPServerDetailsObj.pas',
  ModuleFileNameUtils in '..\..\..\..\Common\ModuleFileNameUtils.pas',
  FileDownloadFuncs in '..\..\..\..\Dev\General\Objects\CommonObjects\FileDownloadFuncs.pas',
  HTTPConst in '..\..\..\..\Common\HTTPConst.pas',
  SystemLib in '..\..\..\..\Dev\General\Objects\CommonObjects\SystemLib.pas',
  UpdaterConst in '..\..\..\ERPUpdater\UpdaterConst.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'ERP EDI Configuration';
  Application.CreateForm(TfmEDIConfigMain, fmEDIConfigMain);
  Application.Run;
end.
