library Updater;

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
  ModuleUpdaterObj in 'ModuleUpdaterObj.pas',
  ModuleBaseServerObj in '..\ModuleBaseServerObj.pas',
  ModuleBaseObj in '..\ModuleBaseObj.pas',
  ModuleConst in '..\ModuleConst.pas',
  JsonRpcBase in '..\..\JsonRPC\JsonRpcBase.pas',
  JsonRpcConst in '..\..\JsonRPC\JsonRpcConst.pas',
  ModuleUtils in '..\ModuleUtils.pas',
  FileDownloadFuncs in '..\..\..\..\Dev\General\Objects\CommonObjects\FileDownloadFuncs.pas',
  ModuleUpdaterConst in 'ModuleUpdaterConst.pas',
  dbUtils in 'dbUtils.pas',
  dbAccessControlObj in '..\dbAccessControlObj.pas',
  DbConst in '..\DbConst.pas',
  DbSchemaObj in '..\DbSchemaObj.pas';

{$R *.res}

exports
  GetModule;

begin
end.
