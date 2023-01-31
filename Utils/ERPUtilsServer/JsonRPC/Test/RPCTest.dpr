program RPCTest;

uses
  Forms,
  frmRPCTest in 'frmRPCTest.pas' {fmRPCTest},
  JsonRpcBase in '..\JsonRpcBase.pas',
  JsonRpcConst in '..\JsonRpcConst.pas',
  JsonRpcTcpServer in '..\JsonRpcTcpServer.pas',
  JsonRpcTcpClient in '..\JsonRpcTcpClient.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmRPCTest, fmRPCTest);
  Application.Run;
end.
