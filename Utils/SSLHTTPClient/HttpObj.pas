unit HttpObj;

interface

uses
  SysUtils, IdHttp, IdMultipartFormData;

type
  THTTPSSL = class
  private
    HTTP: TIdHttp;
    FormDataStream: TIdMultiPartFormDataStream;
    fDebugMode: boolean;
    fLastError: string;
    function GetAccept: string;
    procedure SetAccept(const Value: string);
    function GetContentType: string;
    procedure SetContentType(const Value: string);
    function GetCustomeHeader(aName: string): string;
    procedure SetCustomHeader(aName: string; const Value: string);
    procedure ProcessError(e: Exception);
    procedure SetDebugMode(const Value: boolean);
    function GetConnectTimeout: integer;
    procedure SetConnectTimeout(const Value: integer);
    function GetReadTimeout: integer;
    procedure SetReadTimeout(const Value: integer);
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
    property DebugMode: boolean read fDebugMode write SetDebugMode;
    property ConnectTimeout: integer read GetConnectTimeout write SetConnectTimeout;
    property ReadTimeout: integer read GetReadTimeout write SetReadTimeout;
    function Delete(aURL: string): string;
    property LastError: string read fLastError;
    class function Inst: THTTPSSL;
  end;

implementation

uses
  IdSSLOpenSSL, Classes, JsonObject, HTTPConst, LogThreadLib, LogMessageTypes,
  IdSSLOpenSSLHeaders, ModuleFileNameUtils;

var
  fTHTTPSSL: THTTPSSL;


//    TIdSSLVersion = (sslvSSLv2, sslvSSLv23, sslvSSLv3, sslvTLSv1,sslvTLSv1_1,sslvTLSv1_2);


{ THTTPSSL }

procedure THTTPSSL.AddFormField(aName, aValue: string);
begin
  FormDataStream.AddFormField(aName, aValue);
end;

procedure THTTPSSL.AddSSLVersion(aVersion: string);
begin
  if SameText(aVersion, '2') then TIdSSLIOHandlerSocketOpenSSL(HTTP.IOHandler).SSLOptions.SSLVersions :=
    TIdSSLIOHandlerSocketOpenSSL(HTTP.IOHandler).SSLOptions.SSLVersions + [sslvSSLv2]
  else if SameText(aVersion, '2.3') then TIdSSLIOHandlerSocketOpenSSL(HTTP.IOHandler).SSLOptions.SSLVersions :=
    TIdSSLIOHandlerSocketOpenSSL(HTTP.IOHandler).SSLOptions.SSLVersions + [sslvSSLv23]
  else if SameText(aVersion, '3') then TIdSSLIOHandlerSocketOpenSSL(HTTP.IOHandler).SSLOptions.SSLVersions :=
    TIdSSLIOHandlerSocketOpenSSL(HTTP.IOHandler).SSLOptions.SSLVersions + [sslvSSLv3]
  else if SameText(aVersion, '1') then TIdSSLIOHandlerSocketOpenSSL(HTTP.IOHandler).SSLOptions.SSLVersions :=
    TIdSSLIOHandlerSocketOpenSSL(HTTP.IOHandler).SSLOptions.SSLVersions + [sslvTLSv1]
  else if SameText(aVersion, '1.1') then TIdSSLIOHandlerSocketOpenSSL(HTTP.IOHandler).SSLOptions.SSLVersions :=
    TIdSSLIOHandlerSocketOpenSSL(HTTP.IOHandler).SSLOptions.SSLVersions + [sslvTLSv1_1]
  else if SameText(aVersion, '1.2') then TIdSSLIOHandlerSocketOpenSSL(HTTP.IOHandler).SSLOptions.SSLVersions :=
    TIdSSLIOHandlerSocketOpenSSL(HTTP.IOHandler).SSLOptions.SSLVersions + [sslvTLSv1_2]
  else begin
    TLogger.Inst.Log('Invalid SSL Version ' + aVersion, ltError);
    raise Exception.Create('Invalid SSL Version ' + aVersion);
  end;
  if DebugMode then begin
    TLogger.Inst.Log('Added SSL Version: ' + aVersion, ltInfo);
  end;
end;

procedure THTTPSSL.BasicAuthentication(aUserName, aPassword: string);
begin
  if DebugMode then begin
    TLogger.Inst.Log('BasicAuthentication - User: ' + aUserName + ' Pass: ' + aPassword, ltInfo);
  end;
  try
    fLastError := '';
    HTTP.Request.BasicAuthentication := true;
    HTTP.Request.Username := aUserName;
    HTTP.Request.Password := aPassword;
  except
    on e: exception do
      ProcessError(e);
  end;
end;

procedure THTTPSSL.ClearFormData;
begin
  if DebugMode then begin
    TLogger.Inst.Log('Clear Form Data', ltInfo);
  end;
  FormDataStream.Clear;
end;

procedure THTTPSSL.ClearSSLVersions;
begin
  if DebugMode then begin
    TLogger.Inst.Log('Clear SSL Versions', ltInfo);
  end;
  TIdSSLIOHandlerSocketOpenSSL(HTTP.IOHandler).SSLOptions.SSLVersions := [];
end;

constructor THTTPSSL.Create;
var
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
begin
  TLogger.Inst.LogName := ClassName;
  fDebugMode := false;
  TLogger.Inst.LogAllTypes;
  { use the SSL dll files located in this directory }
  IdOpenSSLSetLibPath(GetCurrentModulePath);
  HTTP := TIdHttp.Create(nil);
  SSLHandler:= TIdSSLIOHandlerSocketOpenSSL.Create(HTTP);
  HTTP.IOHandler:= SSLHandler;

  HTTP.Request.UserAgent := TrueERPUserAgent;
  FormDataStream := TIdMultiPartFormDataStream.Create;
end;

function THTTPSSL.Delete(aURL: string): string;
begin
  fLastError := '';
  if DebugMode then begin
    TLogger.Inst.Log('Processing DELETE', ltInfo);
    TLogger.Inst.Log('URL: ' + aURL, ltInfo);
  end;
  try
    result := HTTP.Delete(aURL);
  except
    on e: exception do
      ProcessError(e);
  end;
end;

procedure THTTPSSL.DeleteCustomHeader(aName: string);
var
  idx: integer;
begin
  if DebugMode then begin
    TLogger.Inst.Log('Delete header: ' + aName, ltInfo);
  end;
  idx := HTTP.Request.CustomHeaders.IndexOfName(aName);
  if idx > -1 then
    HTTP.Request.CustomHeaders.Delete(idx);
end;

destructor THTTPSSL.Destroy;
begin
  HTTP.Free;
  inherited;
end;

function THTTPSSL.Get(aURL: string): string;
begin
  fLastError := '';
  try
    if DebugMode then begin
      TLogger.Inst.Log('Processing GET', ltInfo);
      if HTTP.Request.CustomHeaders.Text <> '' then begin
        TLogger.Inst.Log('Headders:', ltInfo);
        TLogger.Inst.Log(HTTP.Request.CustomHeaders.Text, ltInfo);
      end;
      TLogger.Inst.Log('URL: ' + aURL, ltInfo);
    end;
    result := HTTP.Get(aURL);
    if DebugMode then begin
      TLogger.Inst.Log('Rsult:', ltInfo);
      TLogger.Inst.Log(result, ltInfo);
    end;
  except
    on e: exception do
      ProcessError(e);
  end;
end;

function THTTPSSL.GetAccept: string;
begin
  result := HTTP.Request.Accept;
end;

function THTTPSSL.GetConnectTimeout: integer;
begin
  result := HTTP.ConnectTimeout;
end;

function THTTPSSL.GetContentType: string;
begin
  result := HTTP.Request.ContentType;
end;

function THTTPSSL.GetCustomeHeader(aName: string): string;
begin
  result := HTTP.Request.CustomHeaders.Values[aName];
end;

procedure THTTPSSL.GetFile(aURL, aFileName: string);
var
  stream: TFileStream;
begin
  fLastError := '';
  if DebugMode then begin
    TLogger.Inst.Log('Processing PostFile - URL: ' + aURL + ' File Name: ' + aFileName, ltInfo);
  end;
  try
    stream := TFileStream.Create(aFileName, fmCreate);
    try
      Http.Get(aURL,stream);
    finally
      stream.Free;
    end;
  except
    on e: exception do
      ProcessError(e);
  end;
end;

function THTTPSSL.GetReadTimeout: integer;
begin
  result := HTTP.ReadTimeout;
end;

class function THTTPSSL.Inst: THTTPSSL;
begin
  if not Assigned(fTHTTPSSL) then
    fTHTTPSSL := THTTPSSL.Create;

  result := fTHTTPSSL;
end;

function THTTPSSL.Post(aURL, Data: string): string;
var
  stream: TStringStream;
begin
  fLastError := '';
  if DebugMode then begin
    TLogger.Inst.Log('Processing POST', ltInfo);
    if HTTP.Request.CustomHeaders.Text <> '' then begin
      TLogger.Inst.Log('Headers:', ltInfo);
      TLogger.Inst.Log(HTTP.Request.CustomHeaders.Text, ltInfo);
    end;
    TLogger.Inst.Log('URL: ' + aURL, ltInfo);
    TLogger.Inst.Log('Data:', ltInfo);
    TLogger.Inst.Log(Data, ltInfo);
  end;
  try
    stream := TStringStream.Create;
    try
      stream.WriteString(Data);
      stream.Position := 0;
      result := HTTP.Post(aURL, stream);
      if DebugMode then begin
        TLogger.Inst.Log('Rsult:', ltInfo);
        TLogger.Inst.Log(result, ltInfo);
      end;
    finally
      stream.Free;
    end;
  except
    on e: exception do
      ProcessError(e);
  end;
end;

function THTTPSSL.PostFile(aURL, aFileName: string): string;
var
  stream: TFileStream;
begin
  fLastError := '';
  if DebugMode then begin
    TLogger.Inst.Log('Processing PostFile - URL: ' + aURL + ' File Name: ' + aFileName, ltInfo);
  end;
  stream := TFileStream.Create(aFileName, fmOpenRead);
  try
    try
      result := HTTP.Post(aURL, stream);
    except
      on e: exception do
        ProcessError(e);
    end;
  finally
    stream.Free;
  end;
end;

function THTTPSSL.PostFormData(aURL: string): string;
var
  stream: TStringStream;
begin
  fLastError := '';
  if DebugMode then begin
    TLogger.Inst.Log('Processing POST:', ltInfo);
    TLogger.Inst.Log('Headers:', ltInfo);
    TLogger.Inst.Log(HTTP.Request.CustomHeaders.Text, ltInfo);
    TLogger.Inst.Log('URL:', ltInfo);
    TLogger.Inst.Log(aURL, ltInfo);
    TLogger.Inst.Log('Form Data:', ltInfo);
    stream := TStringStream.Create;
    try
      stream.LoadFromStream(FormDataStream);
      TLogger.Inst.Log(stream.DataString, ltInfo);
    finally
      stream.Free;
    end;
  end;
  try
    FormDataStream.Position := 0;
    result := HTTP.Post(aURL, FormDataStream);
    if DebugMode then begin
      TLogger.Inst.Log('Rsult:', ltInfo);
      TLogger.Inst.Log(result, ltInfo);
    end;
  except
    on e: exception do
      ProcessError(e);
  end;
end;

procedure THTTPSSL.ProcessError(e: Exception);
var
  pe: EIdHTTPProtocolException;
  json, err: TJsonObject;
  x: integer;
  s: string;
  ErrorList: TStringList;
begin
  ErrorList := TStringList.Create;
  try
    if e is EIdHTTPProtocolException then begin
      pe := EIdHTTPProtocolException(e);
      try
        TLogger.Inst.Log(pe.Message, ltError);
        TLogger.Inst.Log(pe.ErrorMessage, ltError);
        json := JO;
        try
          json.AsString := pe.ErrorMessage;
          if json.ArrayExists('errors') then begin
            for x := 0 to json.A['errors'].Count -1 do begin
              err := json.A['errors'][x].AsObject;
              s := err.S['message'];
              if err.StringExists('path') then
                s := s + ' ' + err.S['path'];
              if err.Exists('code') then
                ErrorList.Add(err.ItemByName['code'].Value.AsString + ' ' + s);
            end;
          end
          else begin
            if json.Exists('code') then
              ErrorList.Add(json.ItemByName['code'].Value.AsString + ' ' + json.S['message'])
            else
              ErrorList.Add(json.S['message']);
          end;
        finally
          json.Free;
        end;
      except
        on ex: exception do
          ErrorList.Add('Error' + ' ' + e.Message);
      end;
    end
    else begin
      TLogger.Inst.Log(e.Message, ltError);
      ErrorList.Add('Error' + ' ' + e.Message);
    end;
    if ErrorList.Text <> '' then begin
      fLastError := ErrorList.Text;
      TLogger.Inst.Log(ErrorList.Text, ltError);
    end;
    raise Exception.Create(ErrorList.Text);
  finally
    ErrorList.Free;
  end;
end;

procedure THTTPSSL.SetAccept(const Value: string);
begin
  if DebugMode then begin
    TLogger.Inst.Log('Set Accept: ' +Value, ltInfo);
  end;
  HTTP.Request.Accept := Value;
end;

procedure THTTPSSL.SetConnectTimeout(const Value: integer);
begin
  HTTP.ConnectTimeout := Value;
end;

procedure THTTPSSL.SetContentType(const Value: string);
begin
  if DebugMode then begin
    TLogger.Inst.Log('Set Content Type: ' + Value, ltInfo);
  end;
  HTTP.Request.ContentType := Value;
end;

procedure THTTPSSL.SetCustomHeader(aName: string; const Value: string);
begin
  if DebugMode then begin
    TLogger.Inst.Log('Set Custom Header: ' + aName + ' Value: ' + Value, ltInfo);
  end;
  HTTP.Request.CustomHeaders.Values[aName] := Value;
end;

procedure THTTPSSL.SetDebugMode(const Value: boolean);
begin
  fDebugMode := Value;
  if VAlue then begin
    TLogger.Inst.Log('DebugMode Enabled', ltInfo);
  end;
end;

procedure THTTPSSL.SetReadTimeout(const Value: integer);
begin
  HTTP.ReadTimeout := Value;
end;

initialization
  fTHTTPSSL := nil;

finalization
  fTHTTPSSL.Free;
end.
