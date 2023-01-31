unit ModuleBaseObj;

interface

uses
  classes, LogThreadBase, ModuleConst, JsonRpcBase, JsonObject,
  LogMessageTypes, forms;

type

  TModuleBase = class(TPersistent)
  private
    fLogger: TLoggerBase;
    fAppInst: TApplication;
  protected
    fLoggingLevel: TLoggingLevel;
    fActive: boolean;
    fModuleFileName: string;
    fModuleVersion: string;
    fModuleDescription: string;
    fModuleName: string;
    fOnChange: TNotifyEvent;
    procedure DoChange; virtual;
    function GetActive: boolean; virtual;
    function GetLoggingLevel: TLoggingLevel; virtual;
    procedure SetActive(const Value: boolean); virtual;
    procedure SetLoggingLevel(const Value: TLoggingLevel); virtual;
    procedure SetModuleName(const Value: string); virtual;
    procedure SetModuleFileName(const Value: string); virtual;
    function GetLogger: TLoggerBase; virtual;
  public
    property Logger: TLoggerBase read fLogger;
    constructor Create; virtual;
    destructor Destroy; override;
    procedure DoRequest(Client: TJsonRpcBase; RequestJson: TJsonObject;
      ResponseJson: TJsonObject = nil); virtual;
    procedure DoDisconnect(Client: TJsonRpcBase); virtual;
    procedure DoConnect(Client: TJsonRpcBase); virtual;
    property AppInst: TApplication read fAppInst write fAppInst;
    property OnChange: TNotifyEvent read fOnChange write fOnChange;
    function ModulePath: string;
  published
    property ModuleName: string read fModuleName write SetModuleName;
    property ModuleFileName: string read fModuleFileName write SetModuleFileName;
    property ModuleDescription: string read fModuleDescription write fModuleDescription;
    property ModuleVersion: string read fModuleVersion; // write fModuleVersion;
    property Active: boolean read GetActive write SetActive;
    property LoggingLevel: TLoggingLevel read GetLoggingLevel write SetLoggingLevel;
  end;

implementation

uses
  sysutils, LogThreadLib;

{ TModuleBase }

constructor TModuleBase.Create;
begin
  fLogger:= GetLogger;
  if not Assigned(fLogger) then
    fLogger:= TLogger.Create(nil);
end;

destructor TModuleBase.Destroy;
begin
  try
    fLogger.Free;
  except

  end;
  inherited;
end;

procedure TModuleBase.DoChange;
begin
  if Assigned(fOnChange) then
    fOnChange(self);
end;

procedure TModuleBase.DoConnect(Client: TJsonRpcBase);
begin

end;

procedure TModuleBase.DoDisconnect(Client: TJsonRpcBase);
begin

end;

procedure TModuleBase.DoRequest(Client: TJsonRpcBase; RequestJson: TJsonObject;
      ResponseJson: TJsonObject = nil);
begin

end;

function TModuleBase.GetActive: boolean;
begin
  result:= fActive;
end;

function TModuleBase.GetLogger: TLoggerBase;
begin
  result:= nil;
end;

function TModuleBase.GetLoggingLevel: TLoggingLevel;
begin
  result:= fLoggingLevel;
end;

function TModuleBase.ModulePath: string;
begin
  result:= ExtractFilePath(ModuleFileName);
end;

procedure TModuleBase.SetActive(const Value: boolean);
begin
  if fActive <> Value then begin
    fActive:= Value;
    DoChange;
  end;
end;

procedure TModuleBase.SetLoggingLevel(const Value: TLoggingLevel);
begin
  if fLoggingLevel <> Value then begin
    fLoggingLevel:= Value;
    if Assigned(Logger) then begin
      case LoggingLevel of
        llError:   Logger.LogMessageTypes:= [ltError];
        llWarning: Logger.LogMessageTypes:= [ltError, ltWarning];
        llInfo:    Logger.LogMessageTypes:= [ltError, ltWarning, ltInfo];
        llDetail:  Logger.LogAllTypes;
      end;
    end;
    DoChange;
  end;
end;

procedure TModuleBase.SetModuleFileName(const Value: string);
begin
  fModuleFileName := Value;
end;

procedure TModuleBase.SetModuleName(const Value: string);
begin
  fModuleName := Value;
  fLogger.LogName:= Value;
end;

end.
