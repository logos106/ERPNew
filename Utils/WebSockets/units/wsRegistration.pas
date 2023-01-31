unit wsRegistration;

interface
{$I sgcVer.inc}
uses
  Classes,
  wsServer,
  wsRemoteRPCClient,
  wsLocalRPCClient,
  ERPwsServer;

procedure Register;

implementation

procedure Register;
begin
  Classes.RegisterComponents('ERP WebSockets',[TwsRemoteRPCClient]);
  Classes.RegisterComponents('ERP WebSockets',[TwsLocalRPCClient]);
  Classes.RegisterComponents('ERP WebSockets', [TwsServer]);
  RegisterComponents('ERP WebSockets', [TERPwsServer]);
end;

end.
