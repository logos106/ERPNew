program WebAPITest;

uses
  Forms,
  frmWebAPITestSteps in 'frmWebAPITestSteps.pas' {fmWebApiTestSteps},
  WebUtils in '..\..\..\Common\WebUtils.pas',
  WebApiTEstObj in 'WebApiTestObj.pas',
  JsonRpcTcpClient in '..\JsonRPC\JsonRpcTcpClient.pas',
  JsonRpcBase in '..\JsonRPC\JsonRpcBase.pas',
  JSONObject in '..\..\..\Common\JSONObject.pas',
  JsonRpcConst in '..\JsonRPC\JsonRpcConst.pas',
  MySQLUtils in '..\..\..\Common\MySQLUtils.pas',
  DbConst in '..\..\..\Common\DbConst.pas',
  AppRunUtils in '..\..\..\Dev\General\Objects\CommonObjects\AppRunUtils.pas',
  TesterObj in 'TesterObj.pas',
  TestItemGUI in 'TestItemGUI.pas' {TestItemFrame: TFrame},
  SimpleEncrypt in '..\..\..\Common\SimpleEncrypt.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmWebApiTestSteps, fmWebApiTestSteps);
  Application.Run;
end.
