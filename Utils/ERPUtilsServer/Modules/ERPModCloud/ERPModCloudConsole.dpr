program ERPModCloudConsole;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  LogThreadLib in '..\..\..\..\Dev\General\Objects\CommonObjects\LogThreadLib.pas',
  CloudServerObj in 'CloudServerObj.pas',
  URILib in '..\..\..\..\Common\URILib.pas',
  DataItem in 'DataItem.pas',
  JSONObject in '..\..\..\..\Common\JSONObject.pas',
  MySQLUtils in '..\..\..\..\Common\MySQLUtils.pas',
  DbConst in '..\..\..\..\Common\DbConst.pas',
  AppRunUtils in '..\..\..\..\Dev\General\Objects\CommonObjects\AppRunUtils.pas',
  DbSharedObjectsObj in '..\..\..\..\Dev\General\Objects\CommonObjects\DbSharedObjectsObj.pas',
  InstallConst in '..\..\..\..\Common\InstallConst.pas',
  JsonObjectUtils in '..\..\..\..\Common\JsonObjectUtils.pas',
  CipherUtils in '..\..\..\..\Common\CipherUtils.pas',
  ModuleFileNameUtils in '..\..\..\..\Common\ModuleFileNameUtils.pas',
  DbUtils in 'DbUtils.pas',
  ServerSession in 'ServerSession.pas',
  RandomUtils in '..\..\..\..\Common\RandomUtils.pas',
  ErpApiDbObj in 'ErpApiDbObj.pas',
  StringUtils in '..\..\..\..\Common\StringUtils.pas',
  utSchema in 'utSchema.pas',
  utObjBase in 'utObjBase.pas',
  utObjSale in 'utObjSale.pas';

type
  TLogEventHandler = class
  public
    procedure DoLogEvent(Sender: TObject; const Event, Value : string);
  end;

var
  Server: TCloudServer;
  LogEventHandler: TLogEventHandler;



{ TLogEventHandler }

procedure TLogEventHandler.DoLogEvent(Sender: TObject; const Event,
  Value: string);
begin
  Writeln(Value);
end;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    WriteLn('Starting ERPModCloudConsole.');
    WriteLn('Press the ENTER key to stop');

    LogEventHandler:= TLogEventHandler.Create;
    Logger:= TLogger.Create(nil);
    Logger.LogAllTypes;
    Logger.Events.AddMultiEvent(LogEventHandler.DoLogEvent);
    Server:= TCloudServer.Create;
    Server.Port := 888;
    Server.SSLPort := 999;
    Server.Active := true;
    try
//      Server.Active:= true;
      ReadLn;
    finally
      Server.Free;
      Logger.Free;
      LogEventHandler.Free;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
