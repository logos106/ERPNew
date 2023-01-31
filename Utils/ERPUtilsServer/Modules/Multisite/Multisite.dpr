library Multisite;

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
  ModuleInfoObj in '..\..\ModuleInfoObj.pas',
  ModuleFunctions in '..\..\ModuleFunctions.pas',
  ModuleControl in '..\..\ModuleControl.pas',
  ModuleUtils in '..\ModuleUtils.pas',
  SessionListObj in '..\SessionListObj.pas',
  JsonRpcConst in '..\..\JsonRPC\JsonRpcConst.pas',
  ModuleConfigObj in '..\ModuleConfigObj.pas',
  JsonRpcTcpClient in '..\..\JsonRPC\JsonRpcTcpClient.pas',
  SyncObj in 'SyncObj.pas',
  ValueFields in 'ValueFields.pas',
  SynchronizerObj in 'SynchronizerObj.pas',
  DBUtils in 'DBUtils.pas',
  MultisiteConfigObj in 'MultisiteConfigObj.pas',
  ObjDataSync in 'ObjDataSync.pas',
  MultisiteConst in 'MultisiteConst.pas',
  frmMultisiteSchema in 'frmMultisiteSchema.pas' {MultisiteSchema},
  ModuleBaseObj in '..\ModuleBaseObj.pas',
  ModuleConst in '..\ModuleConst.pas',
  ModuleBaseServerObj in '..\ModuleBaseServerObj.pas',
  ModuleMultisiteObj in 'ModuleMultisiteObj.pas',
  JSONObject in '..\..\..\..\Common\JSONObject.pas',
  JsonObjectUtils in '..\..\..\..\Common\JsonObjectUtils.pas',
  CipherUtils in '..\..\..\..\Common\CipherUtils.pas',
  JsonToObject in '..\..\..\..\Common\JsonToObject.pas',
  StreamUtils in '..\..\..\..\Dev\General\Objects\CommonObjects\StreamUtils.pas',
  DbConst in '..\..\..\..\Common\DbConst.pas',
  UserLockBaseObj in '..\..\..\..\Dev\General\Objects\CommonObjects\UserLockBaseObj.pas',
  tcConst in '..\..\..\..\Dev\General\Objects\CommonObjects\tcConst.pas',
  tcTypes in '..\..\..\..\Dev\General\Objects\CommonObjects\tcTypes.pas',
  DecimalRounding in '..\..\..\..\Dev\General\Objects\CommonObjects\DecimalRounding.pas',
  MultisiteUtils in 'MultisiteUtils.pas',
  SystemLib in '..\..\..\..\Dev\General\Objects\CommonObjects\SystemLib.pas',
  LogThreadLib in '..\..\..\..\Dev\General\Objects\CommonObjects\LogThreadLib.pas',
  LogThreadBase in '..\..\..\..\Dev\General\Objects\CommonObjects\LogThreadBase.pas',
  LogMessageTypes in '..\..\..\..\Dev\General\Objects\CommonObjects\LogMessageTypes.pas';

{$R *.res}



exports
  GetModule;

begin
end.
