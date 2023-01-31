unit utOzEDIStub;

interface

//uses
//  IdHTTP;

type

  TOzEDI = class(TObject)
  private
    dllHandle : cardinal;
    function GetSandpitMode: boolean;
    procedure SetSandpitMode(const Value: boolean);
    function GetClientID: string;
    procedure SetClientID(const Value: string);
    function GetABN: string;
    procedure SetABN(const Value: string);
    function GetLAstErrorMessage: string;
    function GetDebugMode: boolean;
    procedure SetDebugMode(const Value: boolean);
  public
    constructor Create;
    destructor Destroy; override;
    property SandpitMode: boolean read GetSandpitMode write SetSandpitMode;
    property ClientID: string read GetClientID write SetClientID;
    property ABN: string read GetABN write SetABN;
    property LastErrorMessage: string read GetLAstErrorMessage;
    function GetToken: string;
    { type: 0 = Submit, 1 = Update }
    function Upload(aMessageType: integer; aFileName: string): string;
    function GetMessageStatus(aMessageUuid: string): string;
    function GetResponseHeader(aMessageUuid: string): string;
    { returns the file name of the response }
    function GetResponsePayload(aMessageUuid: string): string;
    property DebugMode: boolean read GetDebugMode write SetDebugMode;
  end;

implementation

uses
  Windows, SysUtils, ModuleFileNameUtils, JsonObject;


type
  TGetStringFunc = function: PChar;
  TSetStringProc = procedure(Value: PChar);

  TGetBooleanFunc = function: Boolean;
  TSetBooleanProc = procedure(Value: boolean);

  TExUploadFunc = function(aMessageType: integer; aFileName: PChar): PChar;
  TGetMessageFunc = function(aID: PChar): PChar;

{ TOzODI }

constructor TOzEDI.Create;
var
  fileName: string;
  json: TJsonObject;
begin
  fileName := GetCurrentModulePath + 'Lib\ozedi.dll';
//  dllHandle := LoadLibrary('ozedi.dll') ;
  dllHandle := LoadLibrary(PChar(fileName));
  if dllHandle = 0 then
    raise Exception.Create(ClassName + ' - ozedi.dll not found.');
  if FileExists(GetCurrentModulePath + 'CustomOzEDI_Config.json') then begin
    json := JO;
    try
      self.DebugMode := Json.B['DebugMode'];
    finally
      json.Free;
    end;
  end;
end;

destructor TOzEDI.Destroy;
begin
  FreeLibrary(dllHandle);
  inherited;
end;

function TOzEDI.GetABN: string;
var
  ExGetABN: TGetStringFunc;
begin
  @ExGetABN := GetProcAddress(dllHandle, 'ExGetABN');
  result := ExGetABN;
end;

function TOzEDI.GetClientID: string;
var
  ExGetClientID: TGetStringFunc;
begin
  @ExGetClientID := GetProcAddress(dllHandle, 'ExGetClientID');
  result := ExGetClientID;
end;

function TOzEDI.GetDebugMode: boolean;
var
  ExGetDebugMode: function: boolean;
begin
  @ExGetDebugMode := GetProcAddress(dllHandle, 'ExGetDebugMode');
  result := ExGetDebugMode;
end;

function TOzEDI.GetLAstErrorMessage: string;
var
  ExGetLastErrorMessage: TGetStringFunc;
begin
  @ExGetLastErrorMessage := GetProcAddress(dllHandle, 'ExGetLastErrorMessage');
  result := ExGetLastErrorMessage;
end;

function TOzEDI.GetMessageStatus(aMessageUuid: string): string;
var
  ExGetMessageStatus: TGetMessageFunc;
begin
  @ExGetMessageStatus := GetProcAddress(dllHandle, 'ExGetMessageStatus');
  result := ExGetMessageStatus(PChar(aMessageUuid));
end;

function TOzEDI.GetResponseHeader(aMessageUuid: string): string;
var
  ExGetResponseHeader: TGetMessageFunc;
begin
  @ExGetResponseHeader := GetProcAddress(dllHandle, 'ExGetResponseHeader');
  result := ExGetResponseHeader(PChar(aMessageUuid));
end;

function TOzEDI.GetResponsePayload(aMessageUuid: string): string;
var
  ExGetResponsePayload: TGetMessageFunc;
begin
  @ExGetResponsePayload := GetProcAddress(dllHandle, 'ExGetResponsePayload');
  result := ExGetResponsePayload(PChar(aMessageUuid));
end;

function TOzEDI.GetSandpitMode: boolean;
var
  ExGetSandpitMode: TGetBooleanFunc;
begin
  @ExGetSandpitMode := GetProcAddress(dllHandle, 'ExGetSandpitMode');
  result := ExGetSandpitMode;
end;

function TOzEDI.GetToken: string;
var
  ExGetTokenFunc: TGetStringFunc;
begin
  @ExGetTokenFunc := GetProcAddress(dllHandle, 'ExGetToken');
  result := ExGetTokenFunc;
end;

procedure TOzEDI.SetABN(const Value: string);
var
  ExSetABN: TSetStringProc;
begin
  @ExSetABN := GetProcAddress(dllHandle, 'ExSetABN');
  ExSetABN(PChar(Value));
end;

procedure TOzEDI.SetClientID(const Value: string);
var
  ExSetClientID: TSetStringProc;
begin
  @ExSetClientID := GetProcAddress(dllHandle, 'ExSetClientID');
  ExSetClientID(PChar(Value));
end;

procedure TOzEDI.SetDebugMode(const Value: boolean);
var
  ExSetDebugMode: procedure(Value: boolean);
begin
//  try
    @ExSetDebugMode := GetProcAddress(dllHandle, 'ExSetDebugMode');
    ExSetDebugMode(Value);
//  except
//    on e: exception do begin
//      raise;
//    end;
//  end;
end;

procedure TOzEDI.SetSandpitMode(const Value: boolean);
var
  ExSetSandpitMode: TSetBooleanProc;
begin
  @ExSetSandpitMode := GetProcAddress(dllHandle, 'ExSetSandpitMode');
  ExSetSandpitMode(Value);
end;

function TOzEDI.Upload(aMessageType: integer; aFileName: string): string;
var
  ExUpload: TExUploadFunc;
begin
  @ExUpload := GetProcAddress(dllHandle, 'ExUpload');
  result := ExUpload(aMessageType, PChar(aFileName));
end;

end.
