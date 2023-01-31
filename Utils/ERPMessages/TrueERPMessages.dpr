program TrueERPMessages;

uses
  Forms,
  frmMain in 'frmMain.pas' {fmMain},
  SystemLib in '..\..\Dev\General\Objects\CommonObjects\SystemLib.pas',
  ERPMessagesDb in 'ERPMessagesDb.pas',
  DbConst in '..\..\Common\DbConst.pas',
  MySQLUtils in '..\..\Common\MySQLUtils.pas',
  AppRunUtils in '..\..\Dev\General\Objects\CommonObjects\AppRunUtils.pas',
  DbSharedObjectsObj in '..\..\Dev\General\Objects\CommonObjects\DbSharedObjectsObj.pas',
  ConfigDbObj in '..\..\Common\ConfigDbObj.pas',
  ERPSmoothExpanderPanel in 'ERPSmoothExpanderPanel.pas',
  ERPMessageExpander in 'ERPMessageExpander.pas',
  frmConfig in 'frmConfig.pas' {fmConfig},
  UpdaterCallUtils in '..\ERPUpdater\UpdaterCallUtils.pas',
  UpdaterConst in '..\ERPUpdater\UpdaterConst.pas',
  InternetConnectivityUtils in '..\..\Dev\General\Objects\CommonObjects\InternetConnectivityUtils.pas',
  JsonRpcBase in '..\ERPUtilsServer\JsonRPC\JsonRpcBase.pas',
  JsonRpcConst in '..\ERPUtilsServer\JsonRPC\JsonRpcConst.pas',
  JsonRpcTcpClient in '..\ERPUtilsServer\JsonRPC\JsonRpcTcpClient.pas',
  ModuleConst in '..\ERPUtilsServer\Modules\ModuleConst.pas',
  FileDownloadFuncs in '..\..\Dev\General\Objects\CommonObjects\FileDownloadFuncs.pas',
  FileVersion in '..\..\Dev\General\Objects\CommonObjects\FileVersion.pas',
  VersionUtils in '..\..\Common\VersionUtils.pas',
  InstallConst in '..\..\Common\InstallConst.pas',
  UpdateStoreObj in '..\ERPUtilsServer\Modules\UpdateStoreObj.pas',
  ModuleDbUtils in '..\ERPUtilsServer\Modules\ModuleDbUtils.pas',
  ThreadDataset in '..\..\Dev\General\Objects\CommonObjects\ThreadDataset.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := false;
  Application.ShowMainForm := false;
  Application.Title := 'True ERP Messages';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
