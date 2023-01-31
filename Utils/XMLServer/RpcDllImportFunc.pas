unit RpcDllImportFunc;

interface

uses
  RpcDllExportFuncType;

  function RpcDllLibLoaded: boolean;
  procedure FreeRpcDllLib;
  function LoadRpcDllLib(const FileName: string = ''): boolean;

var
  OpenCompany: TOpenCompany;
  CloseCompany: TCloseCompany;
  ProcessXML: TProcessXML;
  ProcessXMLRequestNode: TProcessXMLRequestNode;
  GetClassPropertyList: TGetClassPropertyList;

implementation

uses
  windows, SysUtils;

var
  RpcDllHandle: THandle;

function RpcDllLibLoaded: boolean;
begin
  result:= RpcDllHandle <> 0;
end;

procedure FreeRpcDllLib;
begin
  if RpcDllHandle <> 0 then begin
    @OpenCompany:= nil;
    @CloseCompany:= nil;
    @ProcessXML:= nil;
    @ProcessXMLRequestNode:= nil;
    @GetClassPropertyList:= nil;
    FreeLibrary(RpcDllHandle);
    RpcDllHandle:= 0;
  end;
end;

function LoadRpcDllLib(const FileName: string = ''): boolean;
var
  s: string;
  initialFilePath: string;
  initialBuffer: array[0..260] of char;
begin
  FreeRpcDllLib;
  s:= FileName;
  if s = '' then begin
    SetString(initialFilePath, initialBuffer, GetModuleFileName(0, initialBuffer, SizeOf(initialBuffer)));
    s:= ExtractFilePath(initialFilePath)+'Rpcdll.dll';
  end;
  RpcDllHandle:= LoadLibrary(PChar(s));
  if RpcDllHandle <> 0 then begin
    @OpenCompany:= GetProcAddress(RpcDllHandle, 'OpenCompany');
    @CloseCompany:= GetProcAddress(RpcDllHandle, 'CloseCompany');
    @ProcessXML:= GetProcAddress(RpcDllHandle, 'ProcessXML');
    @ProcessXMLRequestNode:= GetProcAddress(RpcDllHandle, 'ProcessXMLRequestNode');
    @GetClassPropertyList:= GetProcAddress(RpcDllHandle, 'GetClassPropertyList');
  end;
  result:= RpcDllHandle <> 0;
end;

initialization
  RpcDllHandle:= 0;

finalization
  FreeRpcDllLib;
  
end.
