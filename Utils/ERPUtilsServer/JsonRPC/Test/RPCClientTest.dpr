program RPCClientTest;

uses
  Forms,
  frmRpcClientTest in 'frmRpcClientTest.pas' {fmRpcClientTest},
  JsonRpcTcpClient in '..\JsonRpcTcpClient.pas',
  JsonRpcBase in '..\JsonRpcBase.pas',
  JsonRpcConst in '..\JsonRpcConst.pas',
  JSONObject in '..\..\..\Dev\General\Objects\CommonObjects\JSONObject.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmRpcClientTest, fmRpcClientTest);
  Application.Run;
end.
