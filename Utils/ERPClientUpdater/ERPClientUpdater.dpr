program ERPClientUpdater;

uses
  Forms,
  SysUtils,
  LogMessageTypes in '..\..\Dev\General\Objects\CommonObjects\LogMessageTypes.pas',
  LogThreadLib in '..\..\Dev\General\Objects\CommonObjects\LogThreadLib.pas',
  JsonRpcTcpClient in '..\ERPUtilsServer\JsonRPC\JsonRpcTcpClient.pas',
  JsonRpcBase in '..\ERPUtilsServer\JsonRPC\JsonRpcBase.pas',
  JsonRpcConst in '..\ERPUtilsServer\JsonRPC\JsonRpcConst.pas',
  ModuleConst in '..\ERPUtilsServer\Modules\ModuleConst.pas',
  ModuleUtils in '..\ERPUtilsServer\Modules\ModuleUtils.pas',
  frmMain in 'frmMain.pas' {fmMain},
  JSONObject in '..\..\Common\JSONObject.pas',
  CipherUtils in '..\..\Common\CipherUtils.pas',
  UpdateStoreObj in '..\ERPUtilsServer\Modules\UpdateStoreObj.pas',
  ModuleDbUtils in '..\ERPUtilsServer\Modules\ModuleDbUtils.pas',
  InstallConst in '..\..\Common\InstallConst.pas',
  DbConst in '..\..\Common\DbConst.pas',
  ThreadDataset in '..\..\Dev\General\Objects\CommonObjects\ThreadDataset.pas',
  SystemLib in '..\..\Dev\General\Objects\CommonObjects\SystemLib.pas';

{$R *.res}
//{$R 'Win7UAC.res'}

begin
  Application.Initialize;
  Application.Title := 'ERP User Updater';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
