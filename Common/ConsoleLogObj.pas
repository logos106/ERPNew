unit ConsoleLogObj;

interface

uses
  LogThreadBase;

type

  TConsoleLogger = class
  private
    fLogger: TLoggerBase;
    fServerModule: TObject;
    fPrefix: string;
    procedure DoLogEvent(Sender: TObject; const Event, Value : string);
  public
    constructor Create(aServerModule: TObject);
    destructor Destroy; override;
  end;

implementation

uses
  {$IfDef VER220}
  Windows,
  {$Else}
  WinApi.Windows,
  {$EndIf}
  SysUtils, ServerModuleObj;

{ TConsoleLogger }

constructor TConsoleLogger.Create(aServerModule: TObject);
var
  Stdout: THandle;
begin
  fLogger := nil;
  fServerModule := nil;
  fPrefix := '';
  if aServerModule is TServerModule then begin
    fServerModule := aServerModule;
    fLogger := TServerModule(fServerModule).Logger;
    fPrefix := TServerModule(fServerModule).ModuleName + ' ';
  end;
  Stdout := GetStdHandle(Std_Output_Handle);
  {$WARNINGS OFF}
  Win32Check(Stdout <> Invalid_Handle_Value);
  {$WARNINGS ON}
  if (Stdout <> 0) and Assigned(fLogger) then begin
    fLogger.Events.AddMultiEvent(DoLogEvent);
  end;
end;

destructor TConsoleLogger.Destroy;
begin
  if Assigned(fLogger) then
    fLogger.Events.RemoveMultiEvent(DoLogEvent);
  inherited;
end;

procedure TConsoleLogger.DoLogEvent(Sender: TObject; const Event,
  Value: string);
begin
  Writeln(fPrefix + Value);
end;

end.
