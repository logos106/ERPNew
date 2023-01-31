program LeadSync;

uses
  Forms,
  frmMain in 'frmMain.pas' {fmMain},
  frmSiteConfig in 'frmSiteConfig.pas' {fmSiteConfig},
  JSONObject in '..\..\Common\JSONObject.pas',
  frameSite in 'frameSite.pas' {frSite: TFrame},
  BusObjSchemaLib in '..\..\Dev\BusinessObjects\BusObjSchemaLib.pas',
  DbConst in '..\..\Common\DbConst.pas',
  LogThreadLib in '..\..\Dev\General\Objects\CommonObjects\LogThreadLib.pas',
  LogMessageTypes in '..\..\Dev\General\Objects\CommonObjects\LogMessageTypes.pas',
  WebApiClientObj in '..\..\Common\WebApiClientObj.pas',
  WebApiConst in '..\..\Common\WebApiConst.pas',
  MultiEventObj in '..\..\Dev\General\Objects\CommonObjects\MultiEventObj.pas',
  LogMemoObj in '..\..\Common\LogMemoObj.pas',
  LogThreadBase in '..\..\Dev\General\Objects\CommonObjects\LogThreadBase.pas',
  JsonObjectUtils in '..\..\Common\JsonObjectUtils.pas',
  CipherUtils in '..\..\Common\CipherUtils.pas',
  ConfigDbObj in '..\..\Common\ConfigDbObj.pas',
  MySQLUtils in '..\..\Common\MySQLUtils.pas',
  AppRunUtils in '..\..\Dev\General\Objects\CommonObjects\AppRunUtils.pas',
  APIDataSyncObj in '..\ERPUtilsServer\Modules\SiteIntergration\APIDataSyncObj.pas',
  ApiObjectListObj in '..\ERPUtilsServer\Modules\SiteIntergration\ApiObjectListObj.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
