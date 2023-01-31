program ServerServices;

{%File 'ServerServices.inc'}

uses
  ExcMagic,
  ExcMagicCON,
  SvcMgr,
  SrvService in 'SrvService.pas' {SrvServices: TService},
  SrvServiceFunctionLib in 'SrvServiceFunctionLib.pas',
  PresentListObj in 'PresentListObj.pas',
  SrvThreadUnit in 'SrvThreadUnit.pas',
  SrvServiceGUI in 'SrvServiceGUI.pas' {ServerServicesGUI},
  MemLogLib in 'MemLogLib.pas',
  SrvMessagesLib in 'SrvMessagesLib.pas',
  SrvMultisiteNagLib in 'SrvMultisiteNagLib.pas',
  SrvLockLoginLib in 'SrvLockLoginLib.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'ERP Server Services';
  Application.CreateForm(TSrvServices, SrvServices);
  Application.Run;
end.
