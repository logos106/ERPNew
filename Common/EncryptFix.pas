unit EncryptFix;

interface

function ReencryptFile(const aFileName: AnsiString; var msg: string): boolean;
function DecryptString(const InString: string): string;

implementation

uses
  {$IfDef VER220}
  SysUtils,
  Windows,
  {$Else}
  System.SysUtils,
  WinApi.Windows,
  {$EndIf}
  CipherUtils, AnsiStrings, Character;

type
  TDecryptFile = function(InFileName, OutFileName: PAnsiChar): boolean; stdcall;
  TDecryptString = function(const Instring: PAnsiChar): PAnsiChar; stdcall;

function GetModuleNameStr: String;
var
  szFileName: array[0..MAX_PATH] of Char;
begin
  GetModuleFileName(hInstance, szFileName, MAX_PATH);
  Result := szFileName;
end;

function ReencryptFile(const aFileName: AnsiString; var msg: string): boolean;
var
  tmpFileName: AnsiString;
  libFile: string;
  Handle: THandle;
  DecryptFile: TDecryptFile;
begin
  result:= false;
  tmpFileName:= AnsiStrings.ChangeFileExt(aFileName, '_tmp.tmp');
  libFile:= ExtractFilePath(GetModuleNameStr) + 'ConfigLib.dll';
  try
    Handle:= LoadLibrary(PChar(libFile));
    if Handle <> 0 then begin
      try
        @DecryptFile := GetProcAddress(Handle,'DecryptFile');
        if @DecryptFile <> nil then begin
          if DecryptFile(PAnsiChar(aFileName),PAnsiChar(tmpFileName)) then begin
            Encrypt(string(tmpFileName),string(aFileName));
           {$IfDef VER220}
            SysUtils.DeleteFile(string(tmpFileName));
            {$Else}
            System.SysUtils.DeleteFile(string(tmpFileName));
            {$EndIf}
            result:= true;
          end
          else
            msg:= 'File decryption failed.';
        end
        else
          msg:= 'File encryption/decryption failed, dll function not found.';
      finally
        FreeLibrary(Handle);
      end;
    end
    else
      msg:= 'File encryption/decryption failed, could not load dll: ' + libFile;
  except
    on e: exception do begin
      result:= false;
      msg:= 'File encryption/decryption failed with message: ' + e.Message;
    end;
  end;
end;

function IsValisString(const InStr: string): boolean;
var
  x: integer;
begin
  result:= true;
  for x:= 1 to Length(InStr) do begin
    if Character.IsControl(InStr[x]) then begin
      result:= false;
      Break;
    end;
    if not (Character.IsLetterOrDigit(InStr[x]) or
            Character.IsPunctuation(InStr[x])) then  begin
      result:= false;
      Break;
    end;
  end;
end;

function DecryptString(const InString: string): string;
var
  libFile: string;
  Handle: THandle;
  DecryptString: TDecryptString;
begin
  result:= CipherUtils.DecryptString(InString);
  if not IsValisString(result) then begin
    { invalid string so try the old decryption method }
    libFile:= ExtractFilePath(GetModuleNameStr) + 'ConfigLib.dll';
    try
      Handle:= LoadLibrary(PChar(libFile));
      if Handle <> 0 then begin
        try
          @DecryptString := GetProcAddress(Handle,'DecryptString');
          if @DecryptString <> nil then begin
            result:= string(DecryptString(PAnsiChar(AnsiString(InString))));
          end
          else
            raise exception.Create('DecryptString - String decryption failed, dll function not found.');
        finally
          FreeLibrary(Handle);
        end;
      end
      else
        raise exception.Create('DecryptString - String decryption failed, could not load dll: ' + libFile);
    except
      on e: exception do begin
        raise exception.Create('DecryptString - String decryption failed with message: ' + e.Message);
      end;
    end;
  end;
end;

end.
