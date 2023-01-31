unit LogThreadBase;

interface

uses
  LogMessageTypes, SyncObjs, MultiEventObj, Classes;

type
  TOnLogEvent = procedure (const msg: string; const LogMessageType: TLogMessageType = ltBlank) of object;
  TOnLogStrEvent = procedure (const msg: string; const aType: string = '') of object;

  TLogStringBuffer = class(TObject)
  private
    fList: TStringList;
    fLock :TCriticalSection;
    function GetEmpty: boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(const str: string);
    function Remove: string;
    property Empty: boolean read GetEmpty;
    procedure Clear;
  end;

//  TLogEvent = procedure(const msg: string; const LogMessageType: TLogMessageType = ltBlank) of object;

  TLoggerThreadBase = class;

  TLoggerBase = class(TComponent)
  private
    fLogName: string;
    fEvents: TQueuedMultiEventClass;
    fBuffer: TLogStringBuffer;
    fActive: Boolean;
    fLogToEvent: Boolean;
    fLogMessageTypes: TLogMessageTypes;
    fLogTimeFormat: String;
    fLogTime: Boolean;
    function GetLogMessageTypesCommaText: string;
    procedure SetLogMessageTypesCommaText(const Value: string);
    procedure SetLogMessageTypes(const Value: TLogMessageTypes);
    function GetLogMessageTypes: TLogMessageTypes;

  protected
    fLock: TCriticalSection;
    fLoggerThread: TLoggerThreadBase;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property LogMessageTypes: TLogMessageTypes read GetLogMessageTypes write SetLogMessageTypes;
    property LogName: string read fLogName write fLogName;
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank); virtual;
    procedure LogStr(const msg: string; const aType: string = ''); virtual;
    property Buffer: TLogStringBuffer read fBuffer;
    property Events: TQueuedMultiEventClass read fEvents;
    property Active: boolean read fActive write fActive;
    property LogTimeFormat: string read fLogTimeFormat write fLogTimeFormat;
    property LogTime: Boolean read fLogTime write fLogTime;
    property LogToEvent: boolean read fLogToEvent write fLogToEvent;
    property LogMessageTypesCommaText: string read GetLogMessageTypesCommaText
                                              write SetLogMessageTypesCommaText;
    procedure LogAllTypes;
    procedure SetLoggingLevel(aLevel: TLoggingLevel);

    function HistoryLines(const LineCount: integer): string; overload; virtual;
    procedure HistoryLines(const LineCount: integer; strings: TStrings); overload; virtual;
  end;

  TLoggerThreadBase = class(TThread)
  private
  protected
    fLogger: TLoggerBase;
    IsExecuting: Boolean;
    constructor Create(Logger: TLoggerBase);
    procedure Process; virtual;
    procedure Execute; override;
  public
  end;


implementation

uses
  {$IfDef VER220}
  Windows,
  Forms,
  SysUtils
  {$Else}
  Vcl.Forms,
  System.SysUtils,
  WinApi.Windows
  {$EndIf}
  (*, LogLib, CommonLib, tcConst*);

{ TLogStringBuffer }

Const

  WEBAPILOGFILE = 'd:\webapilog.log';

procedure TLogStringBuffer.Add(const str: string);
begin
  fLock.Acquire;
  try
    fList.Add(str);
  finally
    fLock.Release;
  end;
end;

procedure TLogStringBuffer.Clear;
begin
  fLock.Acquire;
  try
    fList.Clear;
  finally
    fLock.Release;
  end;
end;

constructor TLogStringBuffer.Create;
begin
  inherited;
  fList:= TStringList.Create;
  fLock:= TCriticalSection.Create;
end;

destructor TLogStringBuffer.Destroy;
begin
  fList.Free;
  fLock.Free;
  inherited;
end;

function TLogStringBuffer.GetEmpty: boolean;
begin
  result:= fList.Count = 0;
end;

function TLogStringBuffer.Remove: string;
begin
  result:= '';
  fLock.Acquire;
  try
    if fList.Count > 0 then begin
      result:= fList[0];
      fList.Delete(0);
    end;
  finally
    fLock.Release;
  end;
end;

{ TLoggerBase }

constructor TLoggerBase.Create(AOwner: TComponent);
var
  initialFilePath: string;
  initialBuffer: array[0..260] of char;
begin
  inherited;
  fLock := TCriticalSection.Create;
  fLogTimeFormat := 'dd/mm/yy hh:nn:ss:zzz';
  fLogTime:= True;

  { default to logging to event }
  fLogToEvent:= True;

  fBuffer := TLogStringBuffer.Create;
  fEvents := TQueuedMultiEventClass.Create;

  SetString(initialFilePath, initialBuffer, GetModuleFileName(0, initialBuffer, SizeOf(initialBuffer)));
  fLogName := ChangeFileExt(ExtractFileName(initialFilePath), '');

  fActive := True;

  LogMessageTypes := [ltNone,ltInfo, ltError, ltWarning, ltBlank, ltDebug, ltDetail];
end;

destructor TLoggerBase.Destroy;
begin
  fActive := False;
  Buffer.Clear;
  Sleep(10);
  if Assigned(fLoggerThread) then begin
    fLoggerThread.Terminate;
    while fLoggerThread.IsExecuting do begin
      Sleep(10);
    end;
    fLoggerThread.Free;
  end;
  try
    fEvents.Free;
  except

  end;
  fBuffer.Free;
  fLock.Free;
  inherited;
end;

function TLoggerBase.GetLogMessageTypes: TLogMessageTypes;
begin
  result:= fLogMessageTypes;
end;

function TLoggerBase.GetLogMessageTypesCommaText: string;
begin
  result:= LogMessageTypesToStr(self.LogMessageTypes);
end;

function TLoggerBase.HistoryLines(const LineCount: integer): string;
begin
  result := '';
end;

procedure TLoggerBase.HistoryLines(const LineCount: integer; strings: TStrings);
begin

end;

procedure TLoggerBase.Log(const msg: string;  const LogMessageType: TLogMessageType);
begin
//  Logtext(FormatDateTime(LogTimeFormat,now) + '  '  + LogMessageTypeToStr(LogMessageType) + ' > ' + replacestr(replacestr(replacestr(msg, NL,' '), NLnLF, ' '), '  ', ' '), WEBAPILOGFILE);
  //Logtext(FormatDateTime(LogTimeFormat,now) + '  '  + LogMessageTypeToStr(LogMessageType) + ' > ' + msg,replacestr(WEBAPILOGFILE, '.log', '_'+trim(inttostr(integer(Self)))+'.log'));
end;

procedure TLoggerBase.LogStr(const msg, aType: string);
begin

end;

procedure TLoggerBase.LogAllTypes;
begin
  Self.LogMessageTypes := [Low(TLogMessageType)..High(TLogMessageType)];
end;

procedure TLoggerBase.SetLoggingLevel(aLevel: TLoggingLevel);
begin
  case aLevel of
    llError:   LogMessageTypes:= [ltError];
    llWarning: LogMessageTypes:= [ltError, ltWarning];
    llInfo:    LogMessageTypes:= [ltError, ltWarning, ltInfo];
    //llDebug:   LogMessageTypes:= [ltDebug];
    llDetail:  LogAllTypes;
  end;
end;

procedure TLoggerBase.SetLogMessageTypes(const Value: TLogMessageTypes);
begin
  fLogMessageTypes := Value;
//  if Assigned(AppVars) then
//    AppVars['LogMessageTypes']:= LogMessageTypesToStr(Value);
end;

procedure TLoggerBase.SetLogMessageTypesCommaText(const Value: string);
begin
  self.LogMessageTypes:= StrToLogMessageTypes(Value);
end;

{ TLoggerThreadBase }

constructor TLoggerThreadBase.Create(Logger: TLoggerBase);
begin
  inherited Create(False);
  IsExecuting := False;
  fLogger := Logger;
  Self.FreeOnTerminate := False;
end;

procedure TLoggerThreadBase.Execute;
begin
  IsExecuting := True;
  inherited;
  while not Terminated do begin
    try
      Application.ProcessMessages;
      if ( Terminated) then
//        sleep(10)
      else
        if (not fLogger.Buffer.Empty) or (not fLogger.Active) then
          Process
        else
          Sleep(10);
    except
    end;
  end;
  IsExecuting := False;
end;

procedure TLoggerThreadBase.Process;
begin

end;

end.
