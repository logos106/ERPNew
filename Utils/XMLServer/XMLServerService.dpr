program XMLServerService;

uses
  ShareMem,
  ExcMagic,
  ExcMagicCON,
  SvcMgr,
  svcXMLServer in 'svcXMLServer.pas' {XMLServer: TService},
  datXMLServer in 'datXMLServer.pas' {dmXMLServer: TDataModule},
  MultiEventObj in '..\..\Dev\General\Objects\CommonObjects\MultiEventObj.pas',
  XMLRequestUtils in '..\..\Dev\General\Objects\CommonObjects\XMLRequestUtils.pas',
  XMLRequestConst in '..\..\Dev\General\Objects\CommonObjects\XMLRequestConst.pas',
  LogMessageTypes in '..\..\Dev\General\Objects\CommonObjects\LogMessageTypes.pas',
  LogThreadLib in '..\..\Dev\General\Objects\CommonObjects\LogThreadLib.pas',
  AppVarsObj in '..\..\Dev\General\Objects\CommonObjects\AppVarsObj.pas',
  datSvcControlServer in '..\Common\datSvcControlServer.pas' {SvcControlServer: TDataModule},
  ServiceGuiCommon in '..\Common\ServiceGuiCommon.pas',
  ServiceCommon in '..\Common\ServiceCommon.pas',
  XMLServerControlConst in 'XMLServerControlConst.pas',
  ExMagicUnit in '..\Common\ExMagicUnit.pas',
  XMLCmdSrvObj in 'XMLCmdSrvObj.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'XML Server';
  Application.CreateForm(TXMLServer, XMLServer);
  Application.Run;
end.
