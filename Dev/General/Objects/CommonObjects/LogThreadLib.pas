unit LogThreadLib;

interface

uses
  LogMessageTypes, SyncObjs, MultiEventObj, Classes, LogThreadBase;


type

  TLoggerThread = class;

  TLogger = class(TLoggerBase)
  private
    fLogPath: string;
    fLogToFile: Boolean;
    function GetLogFileName: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    Property LogfileName: String read GetLogFileName;
    property LogPath: string read fLogPath write fLogPath;
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank); override;
    procedure LogStr(const msg: string; const aType: string = ''); override;
    property LogToFile: Boolean read fLogToFile write fLogToFile;
    class function Inst: TLogger;
    function HistoryLines(const LineCount: integer): string; override;
    procedure HistoryLines(const LineCount: integer; strings: TStrings); override;
  end;

  TLoggerThread = class(TLoggerThreadBase)
  private
    fLogDate: TDateTime;
    fFileOpen: boolean;
    fFile: TextFile;
    fFileName: string;
    fCurrentLogName,
    fCurrentLogPath: string;
    function RemoveOldFile: boolean;
    function GetFileName: string;
  protected
    constructor Create(Logger: TLoggerBase);
    procedure Process; override;
  public
    property FileName: string read GetFileName;
  end;

var
  Logger: TLogger;

implementation

uses
  {$IfDef VER220}
  Forms,
  Dialogs,
  Windows,
  {$Else}
  Vcl.Forms,
  Vcl.Dialogs,
  WinApi.Windows,
  {$EndIf}
  sysutils, DateUtils;

 { IsFileInUse will return true if the file is locked for exclusive access.
   It would fail if the file doesn't exist at all. }
function IsFileInUse(Const fName : string; Const CheckFileExists: boolean = true) : boolean;
var
  HFileRes : HFILE;
begin
  Result := false;
  if CheckFileExists and (not FileExists(fName)) then exit;
  HFileRes :=
    CreateFile(pchar(fName),
               GENERIC_READ or GENERIC_WRITE,
               0, nil, OPEN_EXISTING,
               FILE_ATTRIBUTE_NORMAL,
               0) ;
  Result := (HFileRes = INVALID_HANDLE_VALUE) ;
  if not Result then
    CloseHandle(HFileRes);
end;



{ TLogger }

constructor TLogger.Create(AOwner: TComponent);
var
  initialFilePath: string;
  initialBuffer: array[0..260] of char;
begin
  inherited;

  { default to logging to file and to event }
  fLogToFile := True;

  SetString(initialFilePath, initialBuffer, GetModuleFileName(0, initialBuffer, SizeOf(initialBuffer)));
  fLogPath := ExtractFilePath(initialFilePath) + 'Log';
  ForceDirectories(fLogPath);

  {kick off the thread}
  fLoggerThread := TLoggerThread.Create(Self);
end;

destructor TLogger.Destroy;
begin
  inherited;
end;

function TLogger.GetLogFileName: String;
begin
  Result := TLoggerThread(fLoggerThread).FileName;
end;

function TLogger.HistoryLines(const LineCount: Integer): String;
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    HistoryLines(LineCount);
    result := sl.Text;
  finally
    sl.Free;
  end;
end;

procedure TLogger.HistoryLines(const LineCount: integer; strings: TStrings);
var
  buff: TStringList;
  x: integer;
  count: integer;
begin
  inherited;
  buff := TStringList.Create;
  try
    if FileExists(self.LogfileName) then begin
      buff.LoadFromFile(self.LogfileName);
      if buff.Count < LineCount then
        count := buff.Count
      else
        count := LineCount;
      for x := 0 to count -1 do
        strings.Add(buff[x]);
    end;
  finally
    buff.Free;
  end;
end;

class function TLogger.Inst: TLogger;
begin
  if not Assigned(Logger) then begin
    { NOTE: Logger must be created with application as owner so DLL's that
            use the logger can get a reference to the global instance }
    Logger:= TLogger.Create(Application);
  end;
  result:= Logger;
end;

procedure TLogger.LogStr(const msg, aType: string);
var
 s: string;
begin
  fLock.Acquire;
  try
    if Active then begin
      s:= aType + ' > ' + msg;
      if LogTime then
        s:= FormatDateTime(LogTimeFormat,now) + '  '  + s;

      Buffer.Add(s);
    end;
  finally
    fLock.Release;
  end;
end;

procedure TLogger.Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);
var
  s: string;
begin
  inherited;
  fLock.Acquire;
  try
    if Active and (LogMessageType in LogMessageTypes) then begin
      s := LogMessageTypeToStr(LogMessageType) + ' > ' + msg;
      if LogTime then
        s := FormatDateTime(LogTimeFormat,now) + '  '  + s;
      Buffer.Add(s);
    end;
  finally
    fLock.Release;
  end;
end;


{ TLoggerThread }

constructor TLoggerThread.Create(Logger: TLoggerBase);
begin
  inherited Create(Logger);
  fFileOpen:= False;
end;


{ files will stored as:
    logDir\logFile_yyyy_mm_dd.log }
function TLoggerThread.GetFileName: string;
begin
  if fFileName = '' then
    fFileName:=  TLogger(fLogger).LogPath + '\'+ fLogger.LogName + '_' + FormatDateTime('yyyy_mm_dd', Now) + '.log';
  Result := fFileName;
end;

procedure TLoggerThread.Process;
var
  msg: string;

  procedure CloseLog;
  begin
    if fFileOpen then begin
      try
        CloseFile(fFile);
      except
      end;
      fFileOpen := False;
    end;
  end;

begin
  if Terminated then
    Exit;

  msg := fLogger.Buffer.Remove;
  if not fLogger.Active then begin
    Exit;
  end;

  if TLogger(fLogger).LogToFile then begin
    if (fCurrentLogName <> fLogger.LogName) or (fCurrentLogPath <> TLogger(fLogger).LogPath) then begin
      CloseLog;
      fCurrentLogName := fLogger.LogName;
      fCurrentLogPath := TLogger(fLogger).LogPath;
    end;

    if fLogDate <> Trunc(now) then begin
      { we have changed to a new day, need to log to a different file }
      CloseLog;
      fFileName :=  TLogger(fLogger).LogPath + '\'+ fLogger.LogName + '_' + FormatDateTime('yyyy_mm_dd',now) + '.log';
      fLogDate := Trunc(now);
    end;

    if not fFileOpen then begin
      if not DirectoryExists(TLogger(fLogger).LogPath) then begin
        if not CreateDir(TLogger(fLogger).fLogPath) then begin
          fLogger.Active:= False;
          exit;
        end;
      end
      else begin
        { directory already exists ... do we need to delete old file }
        if not RemoveOldFile then begin
          fLogger.Active:= False;
          Exit;
        end;
      end;
      { now open the log file }
      AssignFile(fFile, fFileName);
      try
        if FileExists(fFileName) then
          Append(fFile)
        else
          Rewrite(fFile);
        fFileOpen:= True;
      except
        fFileOpen:= False;
        try
          CloseFile(fFile);
        except
        end;
        exit;
      end;
    end;

    if fFileOpen then begin
      try
        WriteLn(fFile, msg);
        Flush(fFile);
      except
      end;
    end;
  end
  else begin
    CloseLog;
  end;

  if fLogger.LogToEvent then begin
    try
      fLogger.Events.FireEvent(fLogger, 'Log', msg);
    except
    end;
  end;
end;

function TLoggerThread.RemoveOldFile: boolean;
var
  day,month,year,fday,fmonth: word;
  sr: TSearchRec;
begin
  result:= true;
  DecodeDate(now,year,month,day);
  SetCurrentDir(TLogger(fLogger).fLogPath);

  if FindFirst(fLogger.LogName + '*.log', faAnyFile, sr) = 0  then begin
    repeat
      //fyear:= StrToIntDef(Copy(sr.Name, length(fLogger.fLogName) + 2,4),0);
      fmonth:= StrToIntDef(Copy(sr.Name, Length(fLogger.LogName) + 7,2),0);
      fday:= StrToIntDef(Copy(sr.Name, Length(fLogger.LogName) + 10,2),0);
      if (fday = day) and (fmonth <> month) then begin
        result:= SysUtils.DeleteFile(sr.Name);
        break;
      end;
    until FindNext(sr) <> 0;
  end;
end;

end.
