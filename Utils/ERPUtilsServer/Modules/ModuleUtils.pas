unit ModuleUtils;

interface

uses
  JsonObject;

  function GetFileVersion(const FileName: string): string;
  procedure DoError(ResultJson: TJsonObject; aMessage: string; aCode: integer = -1);
  function NowUTC: TDateTime;
  function GetModuleNameStr: String;

implementation

uses
  Types, windows, sysutils, utCloudconst;

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

procedure DoError(ResultJson: TJsonObject; aMessage: string; aCode: integer = -1);
begin
  ResultJson.O[TAG_ResponseError].I['code']:= aCode;
  ResultJson.O[TAG_ResponseError].S['message']:= aMessage;
end;

function NowUTC: TDateTime;
var
  st: TSystemTime;
begin
  Windows.GetSystemTime(st);
  result:= EncodeDate(st.wYear,st.wMonth,st.wDay) +
    EncodeTime(st.wHour,st.wMinute,st.wSecond,st.wMilliseconds);
end;

function GetModuleNameStr: String;
var
  szFileName: array[0..MAX_PATH] of Char;
begin
  GetModuleFileName(hInstance, szFileName, MAX_PATH);
  Result := szFileName;
end;


end.
