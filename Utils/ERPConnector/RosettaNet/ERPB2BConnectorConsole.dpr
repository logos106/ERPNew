program ERPB2BConnectorConsole;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  LogMessageTypes in '..\..\..\Dev\General\Objects\CommonObjects\LogMessageTypes.pas',
  LogThreadBase in '..\..\..\Dev\General\Objects\CommonObjects\LogThreadBase.pas',
  LogThreadLib in '..\..\..\Dev\General\Objects\CommonObjects\LogThreadLib.pas',
  MultiEventObj in '..\..\..\Dev\General\Objects\CommonObjects\MultiEventObj.pas',
  ConnectorBaseObj in '..\ConnectorBaseObj.pas',
  RosettaNetConectorObj in 'RosettaNetConectorObj.pas',
  JsonConfigObj in '..\..\..\Common\JsonConfigObj.pas',
  FileVersion in '..\..\..\Dev\General\Objects\CommonObjects\FileVersion.pas',
  JsonObjectUtils in '..\..\..\Common\JsonObjectUtils.pas',
  CipherUtils in '..\..\..\Common\CipherUtils.pas',
  WebApiClientObj in '..\..\..\Common\WebApiClientObj.pas',
  WebApiConst in '..\..\..\Common\WebApiConst.pas',
  ModuleFileNameUtils in '..\..\..\Common\ModuleFileNameUtils.pas',
  XMLHelperUtils in '..\..\..\Common\XMLHelperUtils.pas',
  JsonXmlMappingObj in '..\..\..\Common\JsonXmlMappingObj.pas',
  JSONObject in '..\..\..\Common\JSONObject.pas',
  Mappings in 'Mappings.pas',
  DateTimeUtils in '..\..\..\Dev\General\Objects\CommonObjects\DateTimeUtils.pas',
  CountryCodeObj in '..\..\..\Common\CountryCodeObj.pas',
  RandomUtils in '..\..\..\Common\RandomUtils.pas',
  ERPWebApiObj in '..\..\..\Common\ERPWebApiObj.pas',
  RosettaNetConst in 'RosettaNetConst.pas',
  MessageInfoObj in '..\MessageInfoObj.pas',
  AS2ClientObj in 'AS2ClientObj.pas',
  AS2ServerObj in 'AS2ServerObj.pas',
  StringUtils in '..\..\..\Common\StringUtils.pas',
  SecureBBox11RegoKey in '..\..\..\Common\SecureBBox11RegoKey.pas',
  windows,
  CertFileObj in 'CertFileObj.pas';

type
  TLogEventHandler = class
  private
    fLogger: TLogger;
  public
    procedure DoLogEvent(Sender: TObject; const Event, Value : string);
    constructor Create;
    destructor Destroy; override;
    property Logger: TLogger read fLogger;
  end;

var
  Connector: TRosettaNetConnector;
  LogEventHandler: TLogEventHandler;



{ TLogEventHandler }

constructor TLogEventHandler.Create;
var
  Stdout: THandle;
begin
  fLogger := TLogger.Create(nil);
  fLogger.LogAllTypes;
  Stdout := GetStdHandle(Std_Output_Handle);
  {$WARNINGS OFF}
  Win32Check(Stdout <> Invalid_Handle_Value);
  {$WARNINGS ON}
  if (Stdout <> 0) then begin
    fLogger.Events.AddMultiEvent(DoLogEvent);
  end;

end;

destructor TLogEventHandler.Destroy;
begin
  while not fLogger.Buffer.Empty do
    Sleep(50);
  fLogger.Free;
  inherited;
end;

procedure TLogEventHandler.DoLogEvent(Sender: TObject; const Event,
  Value: string);
begin
  Writeln(Value);
end;


begin
  try

    LogEventHandler:= TLogEventHandler.Create;

    WriteLn('Starting ' + LogEventHandler.UnitName + '.');
    WriteLn('Press the ENTER key to stop');

//    fLogger:= TLogger.Create(nil);
//    fLogger.LogAllTypes;
//    fLogger.Events.AddMultiEvent(LogEventHandler.DoLogEvent);

    Connector:= TRosettaNetConnector.Create(LogEventHandler.Logger);
    try
      ReadLn;
    finally
      Connector.Free;
//      while not fLogger.Buffer.Empty do
//        Sleep(50);
//      fLogger.Free;
      LogEventHandler.Free;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
