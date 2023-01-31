program RPCServerTest;

uses
  Forms,
  frmRPCServerTest in 'frmRPCServerTest.pas' {fmRPCServerTest},
  JsonRpcTcpServer in '..\JsonRpcTcpServer.pas',
  JsonRpcBase in '..\JsonRpcBase.pas',
  superobject in '..\..\..\Lib\Superobject\superobject.pas',
  JsonRpcConst in '..\JsonRpcConst.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmRPCServerTest, fmRPCServerTest);
  Application.Run;
end.
