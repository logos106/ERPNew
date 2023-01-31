unit ExMagicUnit;

interface

uses Forms, Classes, Types, Windows, ExcMagic;

implementation

Uses SysUtils,IdException;

type
  TDefaultExcFilter = class(TInterfacedObject, IExcMagicFilter)
    function ShowException(ExceptionObject: TObject; Title: string; ExceptionMessage: string; CallStack: TStrings; Registers: TStrings; CustomInfo: TStrings): integer;
    function LogException(ExceptionObject: TObject; Buffer: PChar; BufferSize: integer; CallStack: TStrings; Registers: TStrings; CustomInfo: TStrings): integer;
    function ExceptionMessage(ExceptionObject: TObject; MessageInfo: TExceptionMessageInfo; Buffer: PChar; BufferSize: integer; CustomInfo: TStrings): integer;
  end;


var
  DefaultExcFilter: TDefaultExcFilter;

{ TDefaultExcFilter }

function TDefaultExcFilter.ExceptionMessage(ExceptionObject: TObject; MessageInfo: TExceptionMessageInfo; Buffer: PChar; BufferSize: integer; CustomInfo: TStrings): integer;
const
  DEFAULT_EXCEPTION_MSG_BRIEF: PChar =
    'Exception ''%s'' in module %s at %p'#13#10'%s';
  DEFAULT_EXCEPTION_MSG_FULL: PChar  =
    'Exception ''%s'' in module %s at %p'#13#10 +
    '%s'#13#10#13#10 +
    'Module: %s, Source: %s, Line %s'#13#10 +
    'Procedure: %s';
  UNKNOWN: string = 'UNKNOWN';
begin
  with MessageInfo do
    if excDlgLocation in ExceptionHook.Options then
      StrLFmt(Buffer, BufferSize, DEFAULT_EXCEPTION_MSG_FULL,
        [ExceptionObject.ClassName,
        miModuleName,
        miModuleAddress,
        miMessage,
        ExtractFileName(miSrcModule),
        ExtractFileName(miSrcFile),
        miSrcLine,
        miSrcProc])
  else
    StrLFmt(Buffer, BufferSize, DEFAULT_EXCEPTION_MSG_BRIEF,
      [ExceptionObject.ClassName,
      miModuleName,
      miModuleAddress,
      miMessage]);

  Result := EXC_FILTER_CONTINUE;
end;

function TDefaultExcFilter.LogException(ExceptionObject: TObject; Buffer: PChar; BufferSize: integer; CallStack, Registers, CustomInfo: TStrings): integer;
const
  CRLF: word = $0A0D;
  HDRLINE    = '---------------------------';
  ADDITIONAL_TITLE: string = 'Additional info:'#13#10;
var
  HLog: THandle;
  S: string;
  Written: DWORD;
begin
  if ExceptionHook.LogFile <> '' then begin
    HLog := CreateFile(PChar(ExceptionHook.LogFile), GENERIC_READ or GENERIC_WRITE, 0, nil, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
    if HLog <> INVALID_HANDLE_VALUE then begin
      SetFilePointer(HLog, 0, nil, FILE_END);
      {S := HDRLINE + LocalTimeStr + HDRLINE + #13#10;}
      S := HDRLINE + DateTimeToStr(Now) + HDRLINE + #13#10;
      WriteFile(HLog, S[1], Length(S), Written, nil);
      WriteFile(HLog, Buffer^, BufferSize, Written, nil);
      WriteFile(HLog, CRLF, SizeOf(CRLF), Written, nil);
      // write call stack
      WriteFile(HLog, CRLF, SizeOf(CRLF), Written, nil);
      WriteFile(HLog, PChar(CallStack.Text)^, Length(CallStack.Text), Written, nil);
      // write registers
      WriteFile(HLog, CRLF, SizeOf(CRLF), Written, nil);
      WriteFile(HLog, PChar(Registers.Text)^, Length(Registers.Text), Written, nil);
      // write custom info
      if Length(CustomInfo.Text) > 0 then begin
        WriteFile(HLog, CRLF, SizeOf(CRLF), Written, nil);
        WriteFile(HLog, ADDITIONAL_TITLE[1], Length(ADDITIONAL_TITLE), Written, nil);
        WriteFile(HLog, PChar(CustomInfo.Text)^, Length(CustomInfo.Text), Written, nil);
      end;

      WriteFile(HLog, CRLF, SizeOf(CRLF), Written, nil);
      CloseHandle(HLog);
    end;
  end;

  Result := EXC_FILTER_CONTINUE;
end;

function TDefaultExcFilter.ShowException(ExceptionObject: TObject; Title, ExceptionMessage: string; CallStack, Registers, CustomInfo: TStrings): integer;
begin
  Writeln(ExceptionMessage);
  Writeln;
  if excDlgCallStack in ExceptionHook.Options then
    Writeln(CallStack.Text);
  if excDlgRegisters in ExceptionHook.Options then
    Writeln(Registers.Text);
  if excDlgCustomInfo in ExceptionHook.Options then
    Writeln(CustomInfo.Text);
  Result := EXC_FILTER_CONTINUE;
end;

initialization
  DefaultExcFilter := TDefaultExcFilter.Create;
  ExcMagic.ExceptionHook.Enabled := True;
  ExcMagic.ExceptionHook.LogFile := ExtractFilePath(Application.ExeName) + 'Exceptions.log';
  ExcMagic.ExceptionHook.LogHandled := False;
  ExcMagic.ExceptionHook.LogEnabled := True;
  ExcMagic.ExceptionHook.Options := ExcMagic.ExceptionHook.Options - [excShowDialog];
  ExcMagic.ExceptionHook.RegisterExceptionFilter(Exception, DefaultExcFilter, false);
  ExcMagic.ExceptionHook.EnableExceptionFilter(DefaultExcFilter, true);
end.
