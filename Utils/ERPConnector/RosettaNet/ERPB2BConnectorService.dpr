program ERPB2BConnectorService;

uses
  SvcMgr,
  svcB2BConnector in '..\svcB2BConnector.pas' {ERPB2BConnector: TService},
  RosettaNetConectorObj in 'RosettaNetConectorObj.pas',
  JsonConfigObj in '..\..\..\Common\JsonConfigObj.pas',
  FileVersion in '..\..\..\Dev\General\Objects\CommonObjects\FileVersion.pas',
  JsonObjectUtils in '..\..\..\Common\JsonObjectUtils.pas',
  CipherUtils in '..\..\..\Common\CipherUtils.pas',
  ModuleFileNameUtils in '..\..\..\Common\ModuleFileNameUtils.pas',
  WebApiClientObj in '..\..\..\Common\WebApiClientObj.pas',
  WebApiConst in '..\..\..\Common\WebApiConst.pas',
  ERPWebApiObj in '..\..\..\Common\ERPWebApiObj.pas',
  RandomUtils in '..\..\..\Common\RandomUtils.pas',
  AS2ClientObj in 'AS2ClientObj.pas',
  CertFileObj in 'CertFileObj.pas',
  AS2ServerObj in 'AS2ServerObj.pas',
  JsonXmlMappingObj in '..\..\..\Common\JsonXmlMappingObj.pas',
  XMLHelperUtils in '..\..\..\Common\XMLHelperUtils.pas',
  DateTimeUtils in '..\..\..\Dev\General\Objects\CommonObjects\DateTimeUtils.pas',
  CountryCodeObj in '..\..\..\Common\CountryCodeObj.pas',
  Mappings in 'Mappings.pas',
  RosettaNetUtils in 'RosettaNetUtils.pas',
  StringUtils in '..\..\..\Common\StringUtils.pas',
  ConnectorBaseObj in '..\ConnectorBaseObj.pas',
  MessageInfoObj in '..\MessageInfoObj.pas',
  LogThreadBase in '..\..\..\Dev\General\Objects\CommonObjects\LogThreadBase.pas',
  SecureBBox11RegoKey in '..\..\..\Common\SecureBBox11RegoKey.pas';

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
  Application.CreateForm(TERPB2BConnector, ERPB2BConnector);
  Application.Run;
end.
