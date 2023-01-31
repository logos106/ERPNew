library SiteIntegration;

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
  SysUtils,
  Classes,
  APIDataSyncObj in 'APIDataSyncObj.pas',
  ApiObjectListObj in 'ApiObjectListObj.pas',
  LogThreadBase in '..\..\..\..\Dev\General\Objects\CommonObjects\LogThreadBase.pas',
  JsonRpcBase in '..\..\JsonRPC\JsonRpcBase.pas',
  ModuleBaseServerObj in '..\ModuleBaseServerObj.pas',
  ModuleBaseObj in '..\ModuleBaseObj.pas',
  ModuleConst in '..\ModuleConst.pas',
  JSONObject in '..\..\..\..\Common\JSONObject.pas',
  JsonRpcConst in '..\..\JsonRPC\JsonRpcConst.pas',
  LogMessageTypes in '..\..\..\..\Dev\General\Objects\CommonObjects\LogMessageTypes.pas',
  LogThreadLib in '..\..\..\..\Dev\General\Objects\CommonObjects\LogThreadLib.pas',
  JsonToObject in '..\..\..\..\Common\JsonToObject.pas',
  CipherUtils in '..\..\..\..\Common\CipherUtils.pas',
  ModuleUtils in '..\ModuleUtils.pas',
  BusObjSchemaLib in '..\..\..\..\Dev\BusinessObjects\BusObjSchemaLib.pas',
  WebApiClientObj in '..\..\..\..\Common\WebApiClientObj.pas',
  WebApiConst in '..\..\..\..\Common\WebApiConst.pas',
  ConfigDbObj in '..\..\..\..\Common\ConfigDbObj.pas',
  MySQLUtils in '..\..\..\..\Common\MySQLUtils.pas',
  DbConst in '..\..\..\..\Common\DbConst.pas',
  AppRunUtils in '..\..\..\..\Dev\General\Objects\CommonObjects\AppRunUtils.pas',
  JsonObjectUtils in '..\..\..\..\Common\JsonObjectUtils.pas',
  LogThreadDbLib in '..\..\..\..\Dev\General\Objects\CommonObjects\LogThreadDbLib.pas',
  ModuleSiteIntegrationObj in 'ModuleSiteIntegrationObj.pas',
  URILib in '..\..\..\..\Common\URILib.pas',
  SystemLib in '..\..\..\..\Dev\General\Objects\CommonObjects\SystemLib.pas',
  UURIEncode in '..\..\..\..\Common\UURIEncode.pas',
  SynchReportObj in 'SynchReportObj.pas',
  MySQLConst in '..\..\..\..\Common\MySQLConst.pas';

{$R *.res}

exports
  GetModule;

begin
end.
