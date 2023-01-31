unit ModuleFileNameUtils;

interface

  function GetCurrentModuleName: string;
  function GetCurrentModulePath: string;

implementation

uses
  {$IfDef VER220}
  Windows,
  SysUtils
  {$Else}
  WinApi.Windows,
  System.SysUtils
  {$EndIf}
  ;

function GetCurrentModuleName: string;
var
  szFileName: array[0..MAX_PATH] of Char;
begin
  FillChar(szFileName, SizeOf(szFileName), #0);
  GetModuleFileName(hInstance, szFileName, MAX_PATH);
  Result := szFileName;
end;

function GetCurrentModulePath: string;
begin
  Result := ExtractFilePath(GetCurrentModuleName);
end;


end.
