unit LogLib;

interface

uses
  Classes, SyncObjs, SysUtils;

type
  TLogLib = class(TComponent)
  private
    fLogListUpdated :Boolean;
    fLogList : TStringList;
    function GetLogListText: String;
    procedure AddLogList(const ActionStr: string);
    procedure AddLogFile(const ActionStr: string);
    Procedure LimitLines(Const MaxLines:Integer);
  public
    constructor Create(AOwner: TComponent); Override;
    destructor Destroy; Override;
    procedure AddLogBoth(const ActionStr: string);
    property LogListUpdated : Boolean Read fLogListUpdated;
    property LogListText : String Read GetLogListText;
  end;

implementation

uses
  EmailFaxServerLib;


var
  LogLock: TCriticalSection;

{ TLogLib }

constructor TLogLib.Create(AOwner: TComponent);
begin
  inherited;
  fLogList := TStringList.Create;
end;

destructor TLogLib.Destroy;
begin
  FreeAndNil(fLogList);
  inherited;
end;

procedure TLogLib.AddLogList(const ActionStr: string);
begin
  LogLock.Acquire;
  try
    fLogList.Add(DateTimeToStr(Now())+ #9 + ActionStr);
    LimitLines(100);
    fLogListUpdated := True;
  finally
    LogLock.Release;
  end;
end;

procedure TLogLib.AddLogFile(const ActionStr: string);
var
  logFile: TextFile;
begin
  LogLock.Acquire;
  try
    ForceDirectories(LOGSPATH);
    {$I-}
    System.CloseFile(logFile);
    {$I+}
    if IOResult = 0 then;
    System.AssignFile(logFile, LOGSPATH + LOGFILENAME+'_'+FormatDateTime('yyyy-mm-dd',Now()) +'.log');
    try
      if FileExists(LOGSPATH + LOGFILENAME+'_'+FormatDateTime('yyyy-mm-dd',Now()) +'.log') then begin
        {$I-}
        System.Append(logFile);
        {$I+}
        if IOResult = 0 then;
      end else begin
        {$I-}
        System.Rewrite(logFile);
        {$I+}
        if IOResult <> 0 then;
      end;
      System.Writeln(logFile, FormatDateTime('yyyy-mm-dd hh:nn ', Now), ActionStr);
      System.Flush(logFile);
    finally
      System.CloseFile(logFile);
    end;
  finally
    LogLock.Release;
  end;
end;

procedure TLogLib.AddLogBoth(const ActionStr: string);
Begin
  AddLogList(ActionStr);
  AddLogFile(ActionStr);
end;

function TLogLib.GetLogListText: String;
begin
  LogLock.Acquire;
  try
    result := fLogList.Text;
    fLogListUpdated := False;
  finally
    LogLock.Release;
  end;
end;

procedure TLogLib.LimitLines(const MaxLines: Integer);
begin
    if fLogList.Text > '' then begin
      while (fLogList.Count > MaxLines) do begin
        fLogList.Delete(0);
      end;
      if fLogList.Count = MaxLines then
        fLogList.Strings[0] := '....Check File Log for Events Before This.....';
    end;
end;

initialization
  LogLock := TCriticalSection.Create;
finalization
  LogLock.Free;
end.



