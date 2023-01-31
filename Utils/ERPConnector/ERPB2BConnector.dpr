program ERPB2BConnector;

uses
  SvcMgr,
  svcB2BConnector in 'svcB2BConnector.pas' {B2BConnector: TService},
  RosettaNetConectorObj in 'RosettaNet\RosettaNetConectorObj.pas',
  JsonConfigObj in '..\..\Common\JsonConfigObj.pas',
  FileVersion in '..\..\Dev\General\Objects\CommonObjects\FileVersion.pas',
  JsonObjectUtils in '..\..\Common\JsonObjectUtils.pas',
  CipherUtils in '..\..\Common\CipherUtils.pas',
  ModuleFileNameUtils in '..\..\Common\ModuleFileNameUtils.pas',
  WebApiClientObj in '..\..\Common\WebApiClientObj.pas',
  WebApiConst in '..\..\Common\WebApiConst.pas',
  ERPWebApiObj in '..\..\Common\ERPWebApiObj.pas',
  RandomUtils in '..\..\Common\RandomUtils.pas',
  AS2ClientObj in 'RosettaNet\AS2ClientObj.pas',
  CertFileObj in 'RosettaNet\CertFileObj.pas',
  AS2ServerObj in 'RosettaNet\AS2ServerObj.pas',
  JsonXmlMappingObj in '..\..\Common\JsonXmlMappingObj.pas',
  XMLHelperUtils in '..\..\Common\XMLHelperUtils.pas',
  DateTimeUtils in '..\..\Dev\General\Objects\CommonObjects\DateTimeUtils.pas',
  CountryCodeObj in '..\..\Common\CountryCodeObj.pas',
  Mappings in 'RosettaNet\Mappings.pas',
  RosettaNetUtils in 'RosettaNet\RosettaNetUtils.pas',
  StringUtils in '..\..\Common\StringUtils.pas';

{$R *.RES}

begin
  // Windows 2003 Server requires StartServiceCtrlDispatcher to be
  // called before CoRegisterClassObject, which can be called indirectly
  // by Application.Initialize. TServiceApplication.DelayInitialize allows
  // Application.Initialize to be called from TService.Main (after
  // StartServiceCtrlDispatcher has been called).
  //
  // Delayed initialization of the Application object may affect
  // events which then occur prior to initialization, such as
  // TService.OnCreate. It is only recommended if the ServiceApplication
  // registers a class object with OLE and is intended for use with
  // Windows 2003 Server.
  //
  // Application.DelayInitialize := True;
  //
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TB2BConnector, B2BConnector);
  Application.Run;
end.
