program XMLServer;

uses
  ShareMem,
  ExcMagic,
  ExcMagicCON,
  Forms,
  frmServer in 'frmServer.pas' {fmServer},
  datXMLServer in 'datXMLServer.pas' {dmXMLServer: TDataModule},
  XMLCmdSrvObj in 'XMLCmdSrvObj.pas',
  XMLRequestUtils in '..\..\Dev\General\Objects\CommonObjects\XMLRequestUtils.pas',
  LogThreadLib in '..\..\Dev\General\Objects\CommonObjects\LogThreadLib.pas',
  LogMessageTypes in '..\..\Dev\General\Objects\CommonObjects\LogMessageTypes.pas',
  AppVarsObj in '..\..\Dev\General\Objects\CommonObjects\AppVarsObj.pas',
  MultiEventObj in '..\..\Dev\General\Objects\CommonObjects\MultiEventObj.pas',
  DllMgrObj in 'DllMgrObj.pas',
  XMLRequestConst in '..\..\Dev\General\Objects\CommonObjects\XMLRequestConst.pas',
  ExMagicUnit in '..\Common\ExMagicUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmServer, fmServer);
  Application.Run;
end.
