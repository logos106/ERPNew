library ClientServer;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  ShareMem,
  SysUtils,
  Classes,
  JsonRpcBase in '..\..\JsonRPC\JsonRpcBase.pas',
  ModuleUtils in '..\ModuleUtils.pas',
  JsonRpcConst in '..\..\JsonRPC\JsonRpcConst.pas',
  ModuleConfigObj in '..\ModuleConfigObj.pas',
  LogThreadLib in '..\..\..\..\Dev\General\Objects\CommonObjects\LogThreadLib.pas',
  JsonRpcTcpClient in '..\..\JsonRPC\JsonRpcTcpClient.pas',
  ModuleBaseServerObj in '..\ModuleBaseServerObj.pas',
  ModuleBaseObj in '..\ModuleBaseObj.pas',
  ModuleConst in '..\ModuleConst.pas',
  ModuleClientServerObj in 'ModuleClientServerObj.pas',
  ClientConfigObj in '..\UserUtils\ClientConfigObj.pas',
  ObjUpdateLib in '..\ObjUpdateLib.pas',
  JSONObject in '..\..\..\..\Common\JSONObject.pas',
  JsonObjectUtils in '..\..\..\..\Common\JsonObjectUtils.pas',
  JsonToObject in '..\..\..\..\Common\JsonToObject.pas',
  DbConst in '..\..\..\..\Common\DbConst.pas',
  ClientServerDbUtils in 'ClientServerDbUtils.pas',
  IntegerListObj in '..\..\..\..\Dev\General\Objects\CommonObjects\IntegerListObj.pas',
  CipherUtils in '..\..\..\..\Common\CipherUtils.pas',
  FastFuncs in '..\..\..\..\Dev\General\Objects\CommonObjects\FastFuncs\FastFuncs.pas',
  PosExUnit in '..\..\..\..\Dev\General\Objects\CommonObjects\FastFuncs\PosExUnit.pas',
  FastStringFuncs in '..\..\..\..\Dev\General\Objects\CommonObjects\FastFuncs\FastStringFuncs.pas',
  FillCharUnit in '..\..\..\..\Dev\General\Objects\CommonObjects\FastFuncs\FillCharUnit.pas',
  StrLenUnit in '..\..\..\..\Dev\General\Objects\CommonObjects\FastFuncs\StrLenUnit.pas',
  FastStrings in '..\..\..\..\Dev\General\Objects\CommonObjects\FastFuncs\FastStrings.pas',
  LogThreadBase in '..\..\..\..\Dev\General\Objects\CommonObjects\LogThreadBase.pas',
  LogMessageTypes in '..\..\..\..\Dev\General\Objects\CommonObjects\LogMessageTypes.pas',
  InstallConst in '..\..\..\..\Common\InstallConst.pas';

{$R *.res}


exports
  GetModule;

begin
end.
