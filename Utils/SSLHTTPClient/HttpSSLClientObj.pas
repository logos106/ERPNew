unit HttpSSLClientObj;

interface

type

  THttpSSLClient = class
  private
    Handle: THandle;
    function GetAccept: string;
    function GetContentType: string;
    function GetCustomeHeader(aName: string): string;
    procedure SetAccept(const Value: string);
    procedure SetContentType(const Value: string);
    procedure SetCustomHeader(aName: string; const Value: string);
    procedure SetDebugMode(const Value: boolean);
    function GetDebugMode: boolean;
    function GetConnectTimeout: integer;
    function GetReadTimeout: integer;
    procedure SetConnectTimeout(const Value: integer);
    procedure SetReadTimeout(const Value: integer);
    function GetLastError: string;
    function GetDLLVersion: string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddSSLVersion(aVersion: string);
    procedure ClearSSLVersions;
    property Accept: string read GetAccept write SetAccept;
    property ContentType: string read GetContentType write SetContentType;
    property CustomHeaders[aName: string]: string read GetCustomeHeader write SetCustomHeader;
    procedure DeleteCustomHeader(aName: string);
    procedure AddFormField(aName, aValue: string);
    procedure BasicAuthentication(aUserName, aPassword: string);
    procedure ClearFormData;
    function Get(aURL: string): string;
    procedure GetFile(aURL, aFileName: string);
    function Post(aURL, Data: string): string;
    function PostFile(aURL, aFileName: string): string;
    function PostFormData(aURL: string): string;
    property DebugMode: boolean read GetDebugMode write SetDebugMode;
    property ConnectTimeout: integer read GetConnectTimeout write SetConnectTimeout;
    property ReadTimeout: integer read GetReadTimeout write SetReadTimeout;
    function Delete(aURL: string): string;
    property LastError: string read GetLastError;
    property DLLVersion: string read GetDLLVersion;
  end;

implementation

uses
  Windows, ModuleFileNameUtils, SysUtils, FileVersion{, CommonLib, Dialogs};

const
  dll_sub_dir = 'HttpSSLClient';


{ THttpSSLClient }

procedure THttpSSLClient.AddFormField(aName, aValue: string);
var
  ExAddFormField: procedure(aName, aValue: PChar);
begin
  @ExAddFormField := GetProcAddress(Handle, 'AddFormField');
  ExAddFormField(PChar(aName), PChar(aValue));
end;

procedure THttpSSLClient.AddSSLVersion(aVersion: string);
var
  ExAddSSLVersion: procedure(aVersion: PChar);
begin
  @ExAddSSLVersion := GetProcAddress(Handle, 'AddSSLVersion');
  ExAddSSLVersion(PChar(aVersion));
end;

procedure THttpSSLClient.BasicAuthentication(aUserName, aPassword: string);
var
  ExBasicAuthentication: procedure(aUserName, aPassword: PChar);
begin
  @ExBasicAuthentication := GetProcAddress(Handle, 'BasicAuthentication');
  ExBasicAuthentication(PChar(aUserName), PChar(aPassword));
end;

procedure THttpSSLClient.ClearFormData;
var
  ExClearFormData: procedure();
begin
  @ExClearFormData := GetProcAddress(Handle, 'ClearFormData');
  ExClearFormData;
end;

procedure THttpSSLClient.ClearSSLVersions;
var
  ExClearSSLVersions: procedure;
begin
  @ExClearSSLVersions := GetProcAddress(Handle, 'ClearSSLVersions');
  ExClearSSLVersions;
end;

constructor THttpSSLClient.Create;
var
  libFile, msg: string;
begin
  libFile := GetCurrentModulePath + dll_sub_dir + '\ssl_http_client.dll';
  Handle := LoadLibrary(PChar(libFile));
  if Handle = 0 then begin
    msg:= 'Could not load dll file: ' + libFile;
    raise Exception.Create(msg);
    //CommonLib.MessageDlgXP_Vista(msg, mtWarning, [mbOk], 0);
  end;
end;

function THttpSSLClient.Delete(aURL: string): string;
var
  ExDElete: function(aURL: PChar): PChar;
begin
  @ExDelete := GetProcAddress(Handle, 'Delete');
  result := ExDelete(PChar(aURL));
end;

procedure THttpSSLClient.DeleteCustomHeader(aName: string);
var
  ExDeleteCustomHeader: Procedure(aName: PChar);
begin
  @ExDeleteCustomHeader := GetProcAddress(Handle, 'DeleteCustomHeader');
  ExDeleteCustomHeader(PChar(aName));
end;

destructor THttpSSLClient.Destroy;
begin
  FreeLibrary(Handle);
  inherited;
end;

function THttpSSLClient.Get(aURL: string): string;
var
  ExGet: function(aURL: PChar): PChar;
begin
  @ExGet := GetProcAddress(Handle, 'Get');
  result := ExGet(PChar(aURL));
end;

function THttpSSLClient.GetAccept: string;
var
  ExGetAccept: function: PChar;
begin
  @ExGetAccept := GetProcAddress(Handle, 'GetAccept');
  result := ExGetAccept;
end;

function THttpSSLClient.GetConnectTimeout: integer;
var
  ExGetConnectTimeout: function: integer;
begin
  @ExGetConnectTimeout := GetProcAddress(Handle, 'GetConnectTimeout');
  result := ExGetConnectTimeout;
end;

function THttpSSLClient.GetContentType: string;
var
  ExGetContentType: function: PChar;
begin
  @ExGetContentType := GetProcAddress(Handle, 'GetContentType');
  result := ExGetContentType;
end;

function THttpSSLClient.GetCustomeHeader(aName: string): string;
var
  ExGetCustomHeader: function(aName: PChar): PChar;
begin
  @ExGetCustomHeader := GetProcAddress(Handle, 'GetCustomHeader');
  result := ExGetCustomHeader(PChar(aName));
end;

function THttpSSLClient.GetDebugMode: boolean;
var
  ExGetDebubMode: function: boolean;
begin
  @ExGetDebubMode := GetProcAddress(Handle, 'GetDebugMode');
  result := ExGetDebubMode;
end;

function THttpSSLClient.GetDLLVersion: string;
var
  libFile: string;
begin
  libFile := GetCurrentModulePath + dll_sub_dir + '\ssl_http_client.dll';
  result := GetFileVersion(libFile);
end;

procedure THttpSSLClient.GetFile(aURL, aFileName: string);
var
  ExGetFile: procedure(aURL, aFileName: PChar);
begin
  @ExGetFile := GetProcAddress(Handle, 'GetFile');
  ExGetFile(PChar(aURL), PChar(aFileName));
end;

function THttpSSLClient.GetLastError: string;
var
  ExGetLastError: function: PChar;
begin
  @ExGetLastError := GetProcAddress(Handle, 'GetLastError');
  result := ExGetLastError;
end;

function THttpSSLClient.GetReadTimeout: integer;
var
  ExGetReadTimeout: function: integer;
begin
  @ExGetReadTimeout := GetProcAddress(Handle, 'GetReadTimeout');
  result := ExGetReadTimeout;
end;

function THttpSSLClient.Post(aURL, Data: string): string;
var
  ExPost: function(aURL, Data: PChar): PChar;
begin
  @ExPost := GetProcAddress(Handle, 'Post');
  result := ExPost(PChar(aURL), PChar(Data));
end;

function THttpSSLClient.PostFile(aURL, aFileName: string): string;
var
  ExPostFile: function(aURL, aFileName: PChar): PChar;
begin
  @ExPostFile := GetProcAddress(Handle, 'PostFile');
  result := ExPostFile(PChar(aURL), PChar(aFileName));
end;

function THttpSSLClient.PostFormData(aURL: string): string;
var
  ExPostFormData: function(aURL: PChar): PChar;
begin
  @ExPostFormData := GetProcAddress(Handle, 'PostFormData');
  result := ExPostFormData(PChar(aURL));
end;

procedure THttpSSLClient.SetAccept(const Value: string);
var
  ExSetAccept: procedure(Value: PChar);
begin
  @ExSetAccept := GetProcAddress(Handle, 'SetAccept');
  ExSetAccept(PChar(Value));
end;

procedure THttpSSLClient.SetConnectTimeout(const Value: integer);
var
  ExSetConnectTimeout: Procedure(Value: integer);
begin
  @ExSetConnectTimeout := GetProcAddress(Handle, 'SetConnectTimeout');
  ExSetConnectTimeout(Value);
end;

procedure THttpSSLClient.SetContentType(const Value: string);
var
  ExSetContentType: procedure(Value: PChar);
begin
  @ExSetContentType := GetProcAddress(Handle, 'SetContentType');
  ExSetContentType(PChar(Value));
end;

procedure THttpSSLClient.SetCustomHeader(aName: string; const Value: string);
var
  ExSetCustomHeader: procedure(aName, Value: PChar);
begin
  @ExSetCustomHeader := GetProcAddress(Handle, 'SetCustomHeader');
  ExSetCustomHeader(PChar(aName), PChar(Value));
end;

procedure THttpSSLClient.SetDebugMode(const Value: boolean);
var
  ExSetDebugMode: procedure(Value: boolean);
begin
  @ExSetDebugMode := GetProcAddress(Handle, 'SetDebugMode');
  ExSetDebugMode(Value);
end;

procedure THttpSSLClient.SetReadTimeout(const Value: integer);
var
  ExSetReadTimeout: Procedure(Value: integer);
begin
  @ExSetReadTimeout := GetProcAddress(Handle, 'SetReadTimeout');
  ExSetReadTimeout(Value);
end;

end.
