program ERPApiTestServerConsole;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  ApiTestServerObj in 'ApiTestServerObj.pas',
  LogThreadBase in '..\..\..\Dev\General\Objects\CommonObjects\LogThreadBase.pas',
  LogThreadLib in '..\..\..\Dev\General\Objects\CommonObjects\LogThreadLib.pas',
  URILib in '..\..\..\Common\URILib.pas';

type
  TLogEventHandler = class
  public
    procedure DoLogEvent(Sender: TObject; const Event, Value : string);
  end;

var
  Server: TApiTestServer;
  fLogger: TLogger;
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
    WriteLn('Starting ErpUtilsServer.');
    WriteLn('Press the ENTER key to stop');

    LogEventHandler:= TLogEventHandler.Create;
    fLogger:= TLogger.Create(nil);
    fLogger.LogAllTypes;
    fLogger.Events.AddMultiEvent(LogEventHandler.DoLogEvent);
    Server:= TApiTestServer.Create;
    try
//      Server.Active:= true;
      ReadLn;
    finally
      Server.Free;
      fLogger.Free;
      LogEventHandler.Free;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
