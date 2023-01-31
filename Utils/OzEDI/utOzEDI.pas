unit utOzEDI;

interface

uses
  IdHTTP, IdSSLOpenSSL, LogMessageTypes;

type

  TUploadMessageType = (mtSubmit = 0, mtUpdate = 1);
  TOzEDI = class(TObject)
  private
    Http: TIdHTTP;
    fSandpitMode: boolean;
    fClientID: string;
    fPassLive: string;
    fUserSandpit: string;
    fUserLive: string;
    fPassSandpit: string;
    fLastToken: string;
    fABN: string;
    fLastErrorMessage: string;
    SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
    fTestMode: boolean;
    fDebugMode: boolean;
    function GetClientID: string;
    procedure SetClientID(const Value: string);
    function GetABN: string;
    procedure SetABN(const Value: string);
    function BaseURL: string;
    procedure SetDebugMode(const Value: boolean);
    procedure SetSandpitMode(const Value: boolean);
    procedure SetTestMode(const Value: boolean);
    procedure SetUserLive(const Value: string);
    procedure SetUserSandpit(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    property SandpitMode: boolean read fSandpitMode write SetSandpitMode;
    property TestMode: boolean read fTestMode write SetTestMode;
    property UserLive: string read fUserLive write SetUserLive;
    property PassLive: string read fPassLive write fPassLive;
    property UserSandpit: string read fUserSandpit write SetUserSandpit;
    property PassSandpit: string read fPassSandpit write fPassSandpit;
    property ClientID: string read GetClientID write SetClientID;
    property LastErrorMessage: string read fLastErrorMessage write fLastErrorMessage;
    property ABN: string read GetABN write SetABN;
    class function Inst: TOzEDI;
    function GetToken: string;
    { type: 0 = Submit, 1 = Update }
    function Upload(aMessageType: integer; aFileName: string): string;
    function GetMessageStatus(aMessageUuid: string): string;
    function GetResponseHeader(aMessageUuid: string): string;
    { returns the file name of the response }
    function GetResponsePayload(aMessageUuid: string): string;
    property DebugMode: boolean read fDebugMode write SetDebugMode;
  end;

  procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);

  var OzEDIInst: TOzEDI;


implementation

uses
  Classes, JsonObject, UpdaterConst, CipherUtils, IdAuthenticationDigest,
  SysUtils, ModuleFileNameUtils, IdSSLOpenSSLHeaders, IdMultipartFormData,
  IdGlobalProtocols, Winapi.Windows, LogThreadLib,
  HTTPConst;

const

  Base_URL_Sandpit = 'https://dashboard-api.sandpit.ozedi.com.au/api/';
//  Base_URL_Sandpit = 'https://localhost:444/api/';
  Base_URL_Live = 'https://dashboard-api.ozedi.com.au/api/';

//  URL_Auth_Sandpit = 'https://dashboard-api.sandpit.ozedi.com.au/api/authenticate';
//  URL_Auth_Live = '';

//  URL_Upload_Sandpit = 'https://dashboard-api.sandpit.ozedi.com.au/api/message';
//  URL_Upload_Live = '';

var
  AppTempDir: string;
  fOzEDI: TOzEDI;

procedure Log(const msg: string; const LogMessageType: TLogMessageType);
var
  aFileName: string;
  sl: TStringList;
  s: string;
begin
  try
    TLogger.Inst.Log(msg, LogMessageType);
    exit;
  except
  end;
  s := GetCurrentModulePath;
  s := StringReplace(s, 'Lib\', 'Log\', [rfIgnoreCase]);

  aFileName := s + 'OzEDI_' + FormatDateTime('yyyy_mm_dd',now) + '.log';
  ForceDirectories(ExtractFilePath(aFileName));
  sl := TStringList.Create;
  try
    if FileExists(aFileName) then
      sl.LoadFromFile(aFileName);
    sl.Add(FormatDateTime('yyyy-mm-dd hh:nn:ss', now) + ' ' + LogMessageTypeToStr(LogMessageType) + ' > ' + msg);
    sl.SaveToFile(aFileName);
  finally
    sl.Free;
  end;
end;


function RandomStr(const aLength: longint): string;
var
  X: longint;
begin
  if aLength <= 0 then Exit;
  Setlength(Result, aLength);
  for X := 1 to aLength do Result[X] := Chr(Random(26) + 65);
end;

function WinTempDir: string;
var
  Buffer: array[0..MAX_PATH] of char;
begin
  GetTempPath(Length(Buffer), Buffer);
  Result := StrPas(Buffer);
end;


function GetAppTempDir: string;
begin
  if AppTempDir = '' then begin
    AppTempDir := WinTempDir;
    AppTempDir := AppTempDir + ChangeFileExt(ExtractFileName(GetCurrentModuleName), '');
    if not DirectoryExists(AppTempDir) then CreateDir(AppTempDir);
  end;
  Result := AppTempDir;
end;

function GetTempFileName(): string;
begin
  Result := GetAppTempDir + '\Temp_' + RandomStr(6);
  Result := Result + '.tmp';
  while FileExists(Result) do begin
    Result := GetAppTempDir + '\Temp_' + RandomStr(6);
    Result := Result + '.tmp';
  end;
end;



{ TOzEDI }

function TOzEDI.BaseURL: string;
begin
  if TestMode then begin
    result := 'https://localhost:444/api/';
  end
  else if SandpitMode then begin
    result := Base_URL_Sandpit;
  end
  else begin
    result := Base_URL_Live;
  end;
end;

constructor TOzEDI.Create;
var
//  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  Json: TJsonObject;
  InFileName, OutFileName: string;
  stream: TFileStream;
  HttpConfig: TIdHTTP;
  s: string;
begin
  try
    TLogger.Inst.LogAllTypes;
  except
  end;
  Log('TOzEDI.Create', ltInfo);
  fTestMode := false;
  fDebugMode := false;
  fLastToken := '';
  s := GetCurrentModulePath;
  s := StringReplace(s, 'Lib\', 'ssllib\', [rfIgnoreCase]);
  if DirectoryExists(s) then
    IdOpenSSLSetLibPath(s)
  else
    Log('SSL library path not found: ' + s, ltWarning);

//  fSandpitMode := true;

  { Get main user and password details from encryped file }
  try
    InFileName := GetTempFileName();
    OutFileName := GetTempFileName();
    Json := JO;
    HttpConfig := TIdHTTP.Create(nil);
    try
      HttpConfig.Request.UserAgent := HTTPConst.TrueERPUserAgent;
      stream := TFileStream.Create(InFileName,fmCreate);
      try
        HttpConfig.Get(WebUpdatesURL + 'erpserverdetails2.dat', stream);
      finally
        stream.Free;
      end;
      CipherUtils.Decrypt(InFileName, OutFileName);
      Json.LoadFromFile(OutFileName);
      fPassLive := Json.O['ozedi'].S['PassLive'];
      fUserSandpit := Json.O['ozedi'].S['UserSandpit'];
      fUserLive := Json.O['ozedi'].S['UserLive'];
      fPassSandpit := Json.O['ozedi'].S['PassSandpit'];
    finally
      SysUtils.DeleteFile(InFileName);
      SysUtils.DeleteFile(OutFileName);
      Json.Free;
      HttpConfig.Free;
    end;

  except
    on e: exception do begin
      s := 'Error reading from URL: ' + WebUpdatesURL + 'erpserverdetails2.dat ' + e.Message;
      Log(s, ltError);
      raise;
    end;
  end;

  try
    { all oz edi requests are SSL }
    Http := TIdHTTP.Create(nil);
    Http.Request.ContentType := 'application/json';
    Http.Request.UserAgent := HTTPConst.TrueERPUserAgent;
    SSLHandler:= TIdSSLIOHandlerSocketOpenSSL.Create(Http);
    SSLHandler.SSLOptions.Method := sslvTLSv1_2;  //sslvTLSv1;
    Http.IOHandler:= SSLHandler;
  except
    on e: exception do begin
      Log('Error creating HTTP Client: ' + e.Message, ltError);
      raise
    end;
  end;
//  Log('Create - End', ltInfo);
end;

destructor TOzEDI.Destroy;
begin
  Log('TOzEDI.Destroy', ltInfo);
  Http.Free;
  inherited;
end;

function TOzEDI.GetABN: string;
begin
  result := fABN;
end;

function TOzEDI.GetClientID: string;
begin
  result := fClientID;
end;

function TOzEDI.GetMessageStatus(aMessageUuid: string): string;
var
  URL: string;
  Auth: string;
  errJson: TJsonObject;
begin
  Auth := GetToken;
  Http.Request.Clear;
  Http.Request.CustomHeaders.Clear;
  Http.Request.ContentType := 'application/json';
  URL := BaseURL;
  URL := URL + 'message/status/' + ClientID + '/' + aMessageUuid;
  Http.Request.CustomHeaders.FoldLines := False;
  Http.Request.CustomHeaders.Add('Authorization:Bearer ' + Auth);
  if fDebugMode then begin
    Log('Function GetMessageStatus:', ltInfo);
    Log('Headers:', ltInfo);
    Log(Http.Request.CustomHeaders.Text, ltInfo);
    Log('URL: ' + URL, ltInfo);
  end;
  try
    result := Http.Get(URL);
    if fDebugMode then begin
      Log('Result:', ltInfo);
      Log(result, ltInfo);
    end;
  except
    on e: exception do begin
      Log(e.Message, ltError);
      if e is EIdHTTPProtocolException then begin
        errJson := JO;
        try
          errJson.AsString := EIdHTTPProtocolException(e).ErrorMessage;
          Log(EIdHTTPProtocolException(e).ErrorMessage, ltError);
          raise Exception.Create(errJson.S['detail']);
        finally
          errJson.Free;
        end;
      end
      else
        raise;
    end;
  end;
end;

function TOzEDI.GetResponseHeader(aMessageUuid: string): string;
var
  URL: string;
  Auth: string;
  errJson: TJsonObject;
begin
  Auth := GetToken;
  Http.Request.Clear;
  Http.Request.CustomHeaders.Clear;
  Http.Request.ContentType := 'application/json';
  URL := BaseURL;
  URL := URL + 'message/' + ClientID + '/' + aMessageUuid;
  Http.Request.CustomHeaders.FoldLines := False;
  Http.Request.CustomHeaders.Add('Authorization:Bearer ' + Auth);
  if fDebugMode then begin
    Log('Function GetResponseHeader:', ltInfo);
    Log('Message UUID: ' + aMessageUuid, ltInfo);
    Log('Headers:', ltInfo);
    Log(Http.Request.CustomHeaders.Text, ltInfo);
    Log('URL: ' + URL, ltInfo);
  end;
  try
    result := Http.Get(URL);
    if fDebugMode then begin
      Log('Result:', ltInfo);
      Log(result, ltInfo);
    end;
  except
    on e: exception do begin
      Log(e.Message, ltError);
      if e is EIdHTTPProtocolException then begin
        errJson := JO;
        try
          errJson.AsString := EIdHTTPProtocolException(e).ErrorMessage;
          Log(EIdHTTPProtocolException(e).ErrorMessage, ltError);
          raise Exception.Create(errJson.S['detail']);
        finally
          errJson.Free;
        end;
      end
      else
        raise;
    end;
  end;
end;

function TOzEDI.GetResponsePayload(aMessageUuid: string): string;
var
  Auth: string;
  URL: string;
  stream: TFileStream;
  errJson: TJsonObject;
begin
  Auth := GetToken;
  Http.Request.Clear;
  Http.Request.CustomHeaders.Clear;
  result := GetTempFileName;
  URL := BaseURL;
  URL := URL + 'message/payload/' + ClientID + '/' + aMessageUuid;
  Http.Request.CustomHeaders.FoldLines := False;
  Http.Request.CustomHeaders.Add('Authorization:Bearer ' + Auth);
  if fDebugMode then begin
    Log('Function GetResponsePayload:', ltInfo);
    Log('Message UUID: ' + aMessageUuid, ltInfo);
    Log('Headers:', ltInfo);
    Log(Http.Request.CustomHeaders.Text, ltInfo);
    Log('URL: ' + URL, ltInfo);
  end;
  stream := TFileStream.Create(result, fmCreate);
  try
    try
      Http.Get(URL,stream);
    except
      on e: exception do begin
        Log(e.Message, ltError);
        if e is EIdHTTPProtocolException then begin
          Log(EIdHTTPProtocolException(e).ErrorMessage, ltError);
          errJson := JO;
          try
            try
              errJson.AsString := EIdHTTPProtocolException(e).ErrorMessage;
              raise Exception.Create(errJson.S['detail']);
            except
              raise Exception.Create(EIdHTTPProtocolException(e).ErrorMessage);
            end;
          finally
            errJson.Free;
          end;
        end
        else
          raise;
      end;
    end;
  finally
    stream.Free;
  end;
end;

function TOzEDI.GetToken: string;
var
  URL: string;
  stream: TStringStream;
  Json, Req: TJsonObject;
  s: string;
begin
  stream := TStringStream.Create;
  Json := JO;
  Req := JO;
  try
    Http.Request.Clear;
    Http.Request.CustomHeaders.Clear;
    Http.Request.ContentType := 'application/json';
    if SandpitMode then begin
      req.S['username'] := UserSandpit;
      req.S['password'] := PassSandpit;
    end
    else begin
      req.S['username'] := UserLive;
      req.S['password'] := PassLive;
    end;
    req.SaveToStream(stream);
    URL := BaseURL;
    URL := URL + 'authenticate';
    if fDebugMode then begin
      Log('Function GetToken (POST):', ltInfo);
      Log('Data: ', ltInfo);
      Log(stream.DataString, ltInfo);
      Log('Headers:', ltInfo);
      Log(Http.Request.CustomHeaders.Text, ltInfo);
      Log('URL: ' + URL, ltInfo);
    end;
    stream.Position := 0;
    try
      s := Http.Post(URL,stream);
      if fDebugMode then begin
        Log('Result:', ltInfo);
        Log(s, ltInfo);
      end;
      Json.AsString := s;
      result := Json.S['id_token'];
      fLastToken := result;
    except
      on e: exception do begin
        Log(e.Message, ltError);
        raise;
      end;
    end;
  finally
    Json.Free;
    Req.Free;
    stream.Free;
  end;
end;

class function TOzEDI.Inst: TOzEDI;
begin
  if not Assigned(fOzEDI) then
    fOzEDI := TOzEDI.Create;
  result := fOzEDI;
end;

procedure TOzEDI.SetABN(const Value: string);
begin
  fABN := Value;
end;

procedure TOzEDI.SetClientID(const Value: string);
begin
  if fDebugMode then begin
    Log('SetClientID: ' + Value, ltInfo);
  end;
  fClientID := Value;
end;

procedure TOzEDI.SetDebugMode(const Value: boolean);
begin
  if Value then begin
    try
      TLogger.Inst.LogAllTypes;
    except
    end;
    Log('Debug mode enabled.', ltInfo);
  end;
  try
    fDebugMode := Value;
    Log('Debug mode enabled - Value Set', ltInfo);
  except
    on e: exception do
      Log('SetDebugMode: ' + e.Message, ltError);
  end;
end;

procedure TOzEDI.SetSandpitMode(const Value: boolean);
begin
  if fDebugMode then begin
    if Value then
      Log('SetSandpitMode: true', ltInfo)
    else
      Log('SetSandpitMode: false', ltInfo);
  end;
  fSandpitMode := Value;
end;

procedure TOzEDI.SetTestMode(const Value: boolean);
begin
  if fDebugMode then begin
    if Value then
      Log('SetTestMode: true', ltInfo)
    else
      Log('SetTestMode: false', ltInfo);
  end;
  fTestMode := Value;
end;

procedure TOzEDI.SetUserLive(const Value: string);
begin
  if fDebugMode then begin
    Log('SetUserLive: ' + Value, ltInfo);
  end;
  fUserLive := Value;
end;

procedure TOzEDI.SetUserSandpit(const Value: string);
begin
  if fDebugMode then begin
    Log('SetUserSandpit: ' + Value, ltInfo);
  end;
  fUserSandpit := Value;
end;

function TOzEDI.Upload(aMessageType: integer; aFileName: string): string;
var
  Token: string;
  URL: string;
  FormParams: TIdMultipartFormDataStream;
  s: string;
  errJson: TJsonObject;
  stm: TStringStream;
begin
  LastErrorMessage := '';
  Token := GetToken;
  Http.Request.Clear;
  Http.Request.CustomHeaders.Clear;
  //Http.Request.ContentType  { this is automatically set by TIdMultipartFormDataStream }
  URL := BaseURL;
  URL := URL + 'message';
  Http.Request.CustomHeaders.FoldLines := False;
  Http.Request.CustomHeaders.Values['Authorization'] := 'Bearer ' + Token;

  FormParams := TIdMultipartFormDataStream.Create;
  try
    FormParams.AddFormField('abn',ABN,'','',''); // ('abn=' + ABN);
    FormParams.AddFormField('clientId',ClientID,'','',''); //  ('clientId=' + ClientID);
    if aMessageType = 0 then
      FormParams.AddFormField('messageType','Submit.003.00','','','') // ('messageType=Submit.003.00')
    else
      FormParams.AddFormField('messageType','Update.003.00','','',''); //('messageType=Update.003.00');
    FormParams.AddFile('payloadFile',aFileName,'application/xml'); //.ContentTransfer := '';  //GetMIMETypeFromFile(aFileName)); //  ('payloadFile=filename="' + aFileName +'"');
    if fDebugMode then begin
      Log('Function Upload (POST):', ltInfo);
      Log('MessageType: ' + IntToStr(aMessageType) + ' FileName: ' + aFileName, ltInfo);
      stm := TStringStream.Create;
      try
        stm.LoadFromStream(FormParams);
        Log('Form Params:', ltInfo);
        Log(stm.DataString, ltInfo);
        FormParams.Position := 0;
      finally
        stm.Free;
      end;
      Log('Headers:', ltInfo);
      Log(Http.Request.CustomHeaders.Text, ltInfo);
      Log('URL: ' + URL, ltInfo);
    end;
    try
      s := Http.Post(URL,FormParams);
      result := s;
      if fDebugMode then begin
        Log('Result:', ltInfo);
        Log(s, ltInfo);
      end;
    except
      on e: exception do begin
        Log(e.Message, ltError);
        if e is EIdHTTPProtocolException then begin
          Log(EIdHTTPProtocolException(e).ErrorMessage, ltError);
          errJson := JO;
          try
            errJson.AsString := EIdHTTPProtocolException(e).ErrorMessage;
            raise Exception.Create(errJson.S['detail']);
          finally
            errJson.Free;
          end;
        end
        else
          raise;
      end;
    end;
  finally
    FormParams.Free;
  end;
end;

initialization
  AppTempDir := '';
  fOzEDI := nil;
  OzEDIInst := TOzEDI.Create;

finalization
  FreeAndNil(fOzEDI);
  FreeAndNil(OzEDIInst);

end.
