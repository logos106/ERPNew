library GoogleAnalytics;

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
  ModuleGoogleAnalyticsObj in 'ModuleGoogleAnalyticsObj.pas',
  ModuleBaseServerObj in '..\ModuleBaseServerObj.pas',
  JsonRpcBase in '..\..\JsonRPC\JsonRpcBase.pas',
  JSONObject in '..\..\..\..\Common\JSONObject.pas',
  ModuleBaseObj in '..\ModuleBaseObj.pas',
  ModuleConst in '..\ModuleConst.pas',
  JsonRpcConst in '..\..\JsonRPC\JsonRpcConst.pas',
  LogThreadLib in '..\..\..\..\Dev\General\Objects\CommonObjects\LogThreadLib.pas',
  LogThreadBase in '..\..\..\..\Dev\General\Objects\CommonObjects\LogThreadBase.pas',
  JsonToObject in '..\..\..\..\Common\JsonToObject.pas',
  CipherUtils in '..\..\..\..\Common\CipherUtils.pas',
  ModuleUtils in '..\ModuleUtils.pas',
  LogThreadDbLib in '..\..\..\..\Dev\General\Objects\CommonObjects\LogThreadDbLib.pas',
  MySQLUtils in '..\..\..\..\Common\MySQLUtils.pas',
  DbConst in '..\..\..\..\Common\DbConst.pas',
  AppRunUtils in '..\..\..\..\Dev\General\Objects\CommonObjects\AppRunUtils.pas',
  AnalyticsDb in 'AnalyticsDb.pas',
  AnalyticsObj in 'AnalyticsObj.pas',
  LogMessageTypes in '..\..\..\..\Dev\General\Objects\CommonObjects\LogMessageTypes.pas',
  DBUtils in '..\Multisite\DBUtils.pas';

{$R *.res}

exports
  GetModule;

begin
end.
