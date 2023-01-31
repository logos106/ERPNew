program OffsiteBackupConfig;

uses
  Forms,
  frmOffsiteBAckupMain in 'frmOffsiteBAckupMain.pas' {fmOffsiteBackupConfig},
  frmStandAloneConfigBase in '..\frmStandAloneConfigBase.pas',
  UserUtilsClientObj in '..\..\..\..\Dev\General\Objects\CommonObjects\UserUtilsClientObj.pas',
  JsonRpcBase in '..\..\JsonRPC\JsonRpcBase.pas',
  JsonRpcConst in '..\..\JsonRPC\JsonRpcConst.pas',
  JsonRpcTcpClient in '..\..\JsonRPC\JsonRpcTcpClient.pas',
  OpProgressObj in '..\..\..\..\Dev\General\Objects\CommonObjects\OpProgressObj.pas',
  JsonToObject in '..\..\..\..\Common\JsonToObject.pas',
  CipherUtils in '..\..\..\..\Common\CipherUtils.pas',
  ModuleConst in '..\..\Modules\ModuleConst.pas',
  UtilsLib in '..\..\..\..\Common\UtilsLib.pas',
  AppEnvironmentVirtual in '..\..\Modules\UserUtils\AppEnvironmentVirtual.pas',
  AppEnvVirtualObj in '..\..\..\..\Common\AppEnvVirtualObj.pas',
  ProgressInfoObj in '..\..\..\..\Common\ProgressInfoObj.pas',
  MachineSignature in '..\..\Modules\UserUtils\MachineSignature.pas',
  DecimalRounding in '..\..\..\..\Dev\General\Objects\CommonObjects\DecimalRounding.pas',
  DbSharedObjectsObj in '..\..\..\..\Dev\General\Objects\CommonObjects\DbSharedObjectsObj.pas',
  VersionUtils in '..\..\..\..\Common\VersionUtils.pas',
  InstallConst in '..\..\..\..\Common\InstallConst.pas',
  TempTableUtils in '..\..\..\..\Dev\General\Objects\CommonObjects\TempTableUtils.pas',
  RandomUtils in '..\..\..\..\Common\RandomUtils.pas',
  MySQLUtils in '..\..\..\..\Common\MySQLUtils.pas',
  DbConst in '..\..\..\..\Common\DbConst.pas',
  AppRunUtils in '..\..\..\..\Dev\General\Objects\CommonObjects\AppRunUtils.pas',
  MySQLConst in '..\..\..\..\Common\MySQLConst.pas',
  FileVersion in '..\..\..\..\Dev\General\Objects\CommonObjects\FileVersion.pas',
  OffsiteBackupConfigObj in '..\..\Modules\ERPModUserUtils\OffsiteBackupConfigObj.pas',
  OffsiteRestoreConfigObj in '..\..\Modules\ERPModUserUtils\OffsiteRestoreConfigObj.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'ERP Offsite Backup Configuration';
  Application.CreateForm(TfmOffsiteBackupConfig, fmOffsiteBackupConfig);
  Application.Run;
end.
