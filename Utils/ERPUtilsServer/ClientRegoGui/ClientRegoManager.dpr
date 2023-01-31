program ClientRegoManager;

uses
  Forms,
  frmMainMenu in 'frmMainMenu.pas' {fmMainMenu},
  AppDatabaseObj in 'AppDatabaseObj.pas',
  frmBase in 'frmBase.pas' {fmBase},
  AppConfigObj in 'AppConfigObj.pas',
  frmBaseList in 'frmBaseList.pas' {fmBaseList},
  frmBaseEdit in 'frmBaseEdit.pas' {fmBaseEdit},
  frmLogin in 'frmLogin.pas' {fmLogin},
  frmClientList in 'frmClientList.pas' {fmClientList},
  frmLicenceList in 'frmLicenceList.pas' {fmLicenceList},
  GridFieldsObj in '..\..\..\Dev\General\Objects\CommonObjects\GridFieldsObj.pas',
  frmClientEdit in 'frmClientEdit.pas' {fmClientEdit},
  ComponentLib in 'ComponentLib.pas',
  Utils in 'Utils.pas',
  frmLicenceEdit in 'frmLicenceEdit.pas' {fmLicenceEdit},
  frmServerLog in 'frmServerLog.pas' {fmServerLog},
  JSONObject in '..\..\..\Common\JSONObject.pas',
  JsonToObject in '..\..\..\Common\JsonToObject.pas',
  CipherUtils in '..\..\..\Common\CipherUtils.pas',
  DbConst in '..\..\..\Common\DbConst.pas',
  JsonObjectUtils in '..\..\..\Common\JsonObjectUtils.pas',
  JsonRpcConst in '..\JsonRPC\JsonRpcConst.pas',
  JsonRpcTcpClient in '..\JsonRPC\JsonRpcTcpClient.pas',
  JsonRpcBase in '..\JsonRPC\JsonRpcBase.pas',
  PanelTreeObj in 'PanelTreeObj.pas',
  frmNewClientEdit in 'frmNewClientEdit.pas' {fmNewClientEdit},
  JsonToDatasetFuncs in '..\..\..\Common\JsonToDatasetFuncs.pas',
  ClientUtils in 'ClientUtils.pas',
  fraTreeFrameBase in 'fraTreeFrameBase.pas' {frTreeFrameBase: TFrame},
  fraClient in 'fraClient.pas' {frClient: TFrame},
  JSONBinding in '..\..\..\Common\JSONBinding.pas',
  fraServer in 'fraServer.pas' {frServer: TFrame},
  fraLicence in 'fraLicence.pas' {frLicence: TFrame},
  fraHeading in 'fraHeading.pas' {frHeading: TFrame},
  fraServerConfig in 'fraServerConfig.pas' {frServerConfig: TFrame},
  MemoSaveDialog in '..\..\..\Common\MemoSaveDialog.pas' {fmMemoDialog},
  fraCompanyDatabase in 'fraCompanyDatabase.pas' {frCompanyDatabase: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Client Rego Manager';
  Application.CreateForm(TfmMainMenu, fmMainMenu);
  Application.Run;
end.
