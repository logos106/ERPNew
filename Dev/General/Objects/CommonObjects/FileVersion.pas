unit FileVersion;

interface

function GetFileVersion(const FileName: string): string; overload;
function GetFileVersion(): string; overload;

implementation

uses
  {$IfDef VER220}
  SysUtils,
  Windows
  {$Else}
  System.SysUtils,
  WinApi.Windows
  {$EndIf}
  ;

function GetFileVersion(const FileName: string): string;
var
  VersionInfoSize, VersionInfoValueSize, Zero: DWord;
  VersionInfo, VersionInfoValue: Pointer;
begin
  Result := '';
  VersionInfoSize := GetFileVersionInfoSize(PChar(FileName), Zero);
  if VersionInfoSize = 0 then Exit;
  GetMem(VersionInfo, VersionInfoSize);
  try
    if GetFileVersionInfo(PChar(FileName), 0, VersionInfoSize, VersionInfo) and VerQueryValue(VersionInfo,
      '\', VersionInfoValue,
      VersionInfoValueSize) and (0 <> longint(VersionInfoValueSize)) then begin
      with TVSFixedFileInfo(VersionInfoValue^) do begin
        Result := IntToStr(HiWord(dwFileVersionMS));
        Result := Result + '.' + IntToStr(LoWord(dwFileVersionMS));
        Result := Result + '.' + IntToStr(HiWord(dwFileVersionLS));
        Result := Result + '.' + IntToStr(LoWord(dwFileVersionLS));
      end;
    end;
  finally
    FreeMem(VersionInfo);
  end;
end;

function GetModuleName: string;
var
  szFileName: array[0..MAX_PATH] of Char;
begin
  FillChar(szFileName, SizeOf(szFileName), #0);
  GetModuleFileName(hInstance, szFileName, MAX_PATH);
  Result := szFileName;
end;

function GetFileVersion(): string;
begin
  result := GetFileVersion(GetModuleName);
end;

end.
