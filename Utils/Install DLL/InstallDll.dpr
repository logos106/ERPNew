library InstallDll;

uses
  SysUtils,
  Classes,
  DllFunc in 'DllFunc.pas',
  AppRunUtils in '..\..\Dev\General\Objects\CommonObjects\AppRunUtils.pas';

{$R *.res}

exports
  MysqlConnectionOK,
//  ServerServicesConnectionOk,
  SetConnectionINI,
  SetDefaultCompanyRegion,
  GetCurrentServer,
  GetSysCountryName,
  WinServiceIsInstalled,
  WinServiceStart,
  WinServiceStop,
  StopOrKillService;

begin
end.
