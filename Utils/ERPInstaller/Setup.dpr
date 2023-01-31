program Setup;

uses
  Forms,
  frmMain in 'frmMain.pas' {fmMain},
  InternetConnectivityUtils in '..\..\Dev\General\Objects\CommonObjects\InternetConnectivityUtils.pas',
  ModuleConst in '..\ERPUtilsServer\Modules\ModuleConst.pas',
  ERPInstallerObj in 'ERPInstallerObj.pas',
  frmVideoPlayer in '..\..\Dev\General\InputForms\frmVideoPlayer.pas' {fmVideo},
  frmInstallVideoChoice in 'frmInstallVideoChoice.pas' {fmInstallVideoChoice},
  JSONObject in '..\..\Common\JSONObject.pas',
  DbConst in '..\..\Common\DbConst.pas',
  JsonRpcBase in '..\ERPUtilsServer\JsonRPC\JsonRpcBase.pas',
  JsonRpcConst in '..\ERPUtilsServer\JsonRPC\JsonRpcConst.pas',
  JsonRpcTcpClient in '..\ERPUtilsServer\JsonRPC\JsonRpcTcpClient.pas',
  AppRunUtils in '..\..\Dev\General\Objects\CommonObjects\AppRunUtils.pas',
  frmSoftwareLicence in 'frmSoftwareLicence.pas' {fmSoftwareLicence},
  frm_InstallPath in 'frm_InstallPath.pas' {frmInstallPath},
  InstallConst in '..\..\Common\InstallConst.pas',
  HTTPConst in '..\..\Common\HTTPConst.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ERP Installer';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
