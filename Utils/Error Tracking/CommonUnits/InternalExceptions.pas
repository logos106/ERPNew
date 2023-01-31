unit InternalExceptions;

interface

uses
   Windows, Classes, Forms, SysUtils, ExcMagic, ExcMagicDlg;

type
  TDefaultExcFilter = class(TInterfacedObject, IExcMagicFilter)
    function ShowException(
      ExceptionObject: TObject;
      Title: string;
      ExceptionMessage: string;
      CallStack: TStrings;
      Registers: TStrings;
      CustomInfo: TStrings): Integer;
    function LogException(
      ExceptionObject: TObject;
      Buffer: PChar;
      BufferSize: Integer;
      CallStack: TStrings;
      Registers: TStrings;
      CustomInfo: TStrings): Integer;
    function ExceptionMessage(
      ExceptionObject: TObject;
      MessageInfo: TExceptionMessageInfo;
      Buffer: PChar;
      BufferSize: Integer;
      CustomInfo: TStrings): Integer;
  end;


implementation

uses
  FastFuncs;

var
  DefaultExcFilter: TDefaultExcFilter;

{ TDefaultExcFilter }

function TDefaultExcFilter.ExceptionMessage(ExceptionObject: TObject;
  MessageInfo: TExceptionMessageInfo; Buffer: PChar; BufferSize: Integer;
  CustomInfo: TStrings): Integer;
const
  DEFAULT_EXCEPTION_MSG_BRIEF: PChar =
    'Exception ''%s'' in module %s at %p'#13#10'%s';
  DEFAULT_EXCEPTION_MSG_FULL: PChar =
    'Exception ''%s'' in module %s at %p'#13#10 +
    '%s'#13#10#13#10 +
    'Module: %s, Source: %s, Line %s'#13#10 +
    'Procedure: %s';
  UNKNOWN: String = 'UNKNOWN';
begin
  with MessageInfo do
    if excDlgLocation in ExceptionHook.Options then
      StrLFmt( Buffer, BufferSize, DEFAULT_EXCEPTION_MSG_FULL,
        [ ExceptionObject.ClassName,
          miModuleName,
          miModuleAddress,
          miMessage,
          ExtractFileName(miSrcModule),
          ExtractFileName(miSrcFile),
          miSrcLine,
          miSrcProc ] )
    else
      StrLFmt( Buffer, BufferSize, DEFAULT_EXCEPTION_MSG_BRIEF,
        [ ExceptionObject.ClassName,
          miModuleName,
          miModuleAddress,
          miMessage ] );

  Result := EXC_FILTER_CONTINUE;
end;

function TDefaultExcFilter.LogException(ExceptionObject: TObject;
  Buffer: PChar; BufferSize: Integer; CallStack, Registers,
  CustomInfo: TStrings): Integer;
const
  CRLF: Word = $0A0D;
  HDRLINE = '---------------------------';
  ADDITIONAL_TITLE: String = 'Additional info:'#13#10;
var
  HLog: THandle;
  S: String;
  Written: DWORD;
begin
  if ExceptionHook.LogFile <> '' then
    begin
      HLog := CreateFile( PChar(ExceptionHook.LogFile), GENERIC_READ or GENERIC_WRITE, 0, nil, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
      if HLog <> INVALID_HANDLE_VALUE then
        begin
          SetFilePointer( HLog, 0, nil, FILE_END );
          {S := HDRLINE + LocalTimeStr + HDRLINE + #13#10;}
          S := HDRLINE + DateTimeToStr(Now) + HDRLINE + #13#10;
          WriteFile( HLog, S[1], FastFuncs.StrLength(S), Written, nil);
          WriteFile( HLog, Buffer^, BufferSize, Written, nil);
          WriteFile( HLog, CRLF, SizeOf(CRLF), Written, nil);
          // write call stack
          WriteFile( HLog, CRLF, SizeOf(CRLF), Written, nil);
          WriteFile( HLog, PChar(CallStack.Text)^, FastFuncs.StrLength(CallStack.Text), Written, nil );
          // write registers
          WriteFile( HLog, CRLF, SizeOf(CRLF), Written, nil);
          WriteFile( HLog, PChar(Registers.Text)^, FastFuncs.StrLength(Registers.Text), Written, nil );
          // write custom info
          if FastFuncs.StrLength(CustomInfo.Text) > 0 then
            begin
              WriteFile( HLog, CRLF, SizeOf(CRLF), Written, nil);
              WriteFile( HLog, ADDITIONAL_TITLE[1], FastFuncs.StrLength(ADDITIONAL_TITLE), Written, nil);
              WriteFile( HLog, PChar(CustomInfo.Text)^, FastFuncs.StrLength(CustomInfo.Text), Written, nil );
            end;

          WriteFile( HLog, CRLF, SizeOf(CRLF), Written, nil);
          CloseHandle( HLog );
        end;
    end;

  Result := EXC_FILTER_CONTINUE;
end;

function TDefaultExcFilter.ShowException(ExceptionObject: TObject; Title,
  ExceptionMessage: string; CallStack, Registers,
  CustomInfo: TStrings): Integer;
var
  DlgResult: Integer;
begin
  if excShowDialog in ExceptionHook.Options then begin
    DlgResult := ExceptionHook.DefaultErrorDialog(
        ExceptionHook.ErrorDialogTitle,
        ExceptionMessage,
        CallStack,
        Registers,
        CustomInfo );

    if DlgResult = EM_DLG_BTN_TERMINATE then
      if Assigned(ExceptionHook.OnTerminate) then
        ExceptionHook.OnTerminate()
      else
        TerminateProcess( GetCurrentProcess, 0 );
  end;
  Result := EXC_FILTER_CONTINUE;
end;

initialization
  // Add New
  DefaultExcFilter := TDefaultExcFilter.Create;
  ExcMagic.ExceptionHook.Enabled := True;
  // set the hook properties
  ExcMagic.ExceptionHook.LogFile := ExtractFilePath(Application.ExeName)+'Exceptions.log';
  ExcMagic.ExceptionHook.LogHandled := False;
  ExcMagic.ExceptionHook.LogEnabled := True;
  ExcMagic.ExceptionHook.Options := ExcMagic.ExceptionHook.Options + [excShowDialog];

  // register 'our' default filter
  ExcMagic.ExceptionHook.RegisterExceptionFilter(Exception,DefaultExcFilter, False);
  ExcMagic.ExceptionHook.EnableExceptionFilter(DefaultExcFilter, True);
end.

