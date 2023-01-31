unit utOzEDI;

interface

uses
  IdHTTP;

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
    function GetClientID: string;
    procedure SetClientID(const Value: string);
    function GetABN: string;
    procedure SetABN(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    property SandpitMode: boolean read fSandpitMode write fSandpitMode;
    property UserLive: string read fUserLive write fUserLive;
    property PassLive: string read fPassLive write fPassLive;
    property UserSandpit: string read fUserSandpit write fUserSandpit;
    property PassSandpit: string read fPassSandpit write fPassSandpit;
    property ClientID: string read GetClientID write SetClientID;
    property ABN: string read GetABN write SetABN;
    class function Inst: TOzEDI;
    function GetToken: string;
    { type: 0 = Submit, 1 = Update }
    function Upload(aMessageType: integer; aFileName: string): string;
    function GetMessageStatus(aMessageUuid: string): string;
    function GetResponseHeader(aMessageUuid: string): string;
    { returns the file name of the response }
    function GetResponsePayload(aMessageUuid: string): string;
  end;

  procedure Log(msg: string);

implementation

uses
  IdSSLOpenSSL, Classes, JsonObject, UpdaterConst, CipherUtils, Windows,
  SysUtils, ModuleFileNameUtils, IdSSLOpenSSLHeaders;

const

  Base_URL_Sandpit = 'https://dashboard-api.sandpit.ozedi.com.au/api/';
  Base_URL_Live = '';

//  URL_Auth_Sandpit = 'https://dashboard-api.sandpit.ozedi.com.au/api/authenticate';
//  URL_Auth_Live = '';

//  URL_Upload_Sandpit = 'https://dashboard-api.sandpit.ozedi.com.au/api/message';
//  URL_Upload_Live = '';

var
  AppTempDir: string;
  fOzEDI: TOzEDI;


procedure Log(msg: string);
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    if fileExists('TempLog.txt') then
      sl.LoadFromFile('TempLog.txt');
    sl.Add(msg);
    sl.SaveToFile('TempLog.txt');
  finally
    sl.Free;;
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

constructor TOzEDI.Create;
var
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  Json: TJsonObject;
  InFileName, OutFileName: string;
  stream: TFileStream;
begin
  Log('Create - Start');
  fLastToken := '';
  if not FileExists(GetCurrentModulePath + 'libeay32.dll') then begin
    if DirectoryExists(GetCurrentModulePath + 'ssllib\') then
      IdOpenSSLSetLibPath(GetCurrentModulePath + 'ssllib\');

  end;


  fSandpitMode := true;
  Http := TIdHTTP.Create(nil);

  { Get main user and password details from encryped file }
  InFileName := GetTempFileName();
  OutFileName := GetTempFileName();
  Json := JO;
  try
    stream := TFileStream.Create(InFileName,fmCreate);
    try
      Http.Get(WebUpdatesURL + 'erpserverdetails.dat', stream);
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
    DeleteFile(InFileName);
    DeleteFile(OutFileName);
    Json.Free;
  end;

  { all oz edi requests are SSL }
  SSLHandler:= TIdSSLIOHandlerSocketOpenSSL.Create(Http);
  Http.IOHandler:= SSLHandler;
  SSLHandler.SSLOptions.Method := sslvTLSv1_2;
  Log('Create - End');
end;

destructor TOzEDI.Destroy;
begin
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
begin
  Auth := GetToken;
  Http.Request.ContentType := 'application/json';
  if SandpitMode then begin
    URL := Base_URL_Sandpit;
  end
  else begin
    URL := Base_URL_Live;
  end;
  URL := URL + 'message/status/' + ClientID + '/' + aMessageUuid;
  Http.Request.CustomHeaders.FoldLines := False;
  Http.Request.CustomHeaders.Add('Authorization:Bearer ' + Auth);
  result := Http.Get(URL);
end;

function TOzEDI.GetResponseHeader(aMessageUuid: string): string;
var
  URL: string;
  Auth: string;
begin
  Auth := GetToken;
  Http.Request.ContentType := 'application/json';
  if SandpitMode then begin
    URL := Base_URL_Sandpit;
  end
  else begin
    URL := Base_URL_Live;
  end;
  URL := URL + 'message/' + ClientID + '/' + aMessageUuid;
  Http.Request.CustomHeaders.FoldLines := False;
  Http.Request.CustomHeaders.Add('Authorization:Bearer ' + Auth);
  result := Http.Get(URL);
end;

function TOzEDI.GetResponsePayload(aMessageUuid: string): string;
var
  Auth: string;
  URL: string;
  stream: TFileStream;
begin
  Auth := GetToken;
  result := GetTempFileName;
//  Http.Request.ContentType := 'multipart/form-data';
  if SandpitMode then begin
    URL := Base_URL_Sandpit;
  end
  else begin
    URL := Base_URL_Live;
  end;
  URL := URL + 'message/payload/' + ClientID + '/' + aMessageUuid;
  Http.Request.CustomHeaders.FoldLines := False;
  Http.Request.CustomHeaders.Add('Authorization:Bearer ' + Auth);
  stream := TFileStream.Create(result, fmCreate);
  try
    Http.Get(URL,stream);
  finally
    stream.Free;
  end;
end;

function TOzEDI.GetToken: string;
var
  URL: string;
  stream: TStringStream;
  Json: TJsonObject;
  s: string;
begin
  stream := TStringStream.Create;
  Json := JO;
  try
    Http.Request.ContentType := 'application/json';
    if SandpitMode then begin
      URL := Base_URL_Sandpit;
      stream.WriteString('{"username":"'+UserSandpit+'","password":"'+PassSandpit+'"}');
    end
    else begin
      URL := Base_URL_Live;
      stream.WriteString('{"username":"'+UserLive+'","password":"'+PassLive+'"}');
    end;
    stream.Position := 0;
    URL := URL + 'authenticate';
    try
      s := Http.Post(URL,stream);
      Json.AsString := s;
      result := Json.S['id_token'];
      fLastToken := result;
    except
      on e: exception do begin
        //showmessage(e.Message + ' ' + IntToStr(Http.ResponseCode));
        raise;
      end;
    end;
  finally
    Json.Free;
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
  Log('SetABN - Start');
  fABN := Value;
  Log('SetABN - End');
end;

procedure TOzEDI.SetClientID(const Value: string);
begin
  Log('SetClientID - Start');
  fClientID := Value;
  Log('SetClientID - End');
end;

function TOzEDI.Upload(aMessageType: integer; aFileName: string): string;
var
  Auth: string;
  URL: string;
  Params: TStringList;
begin
  Log('Upload - Start');
  Auth := GetToken;
  Log('Upload - Got Auth');
  Http.Request.ContentType := 'multipart/form-data';
  if SandpitMode then begin
    URL := Base_URL_Sandpit;
  end
  else begin
    URL := Base_URL_Live;
  end;
  URL := URL + 'message';
  Http.Request.CustomHeaders.FoldLines := False;
  Http.Request.CustomHeaders.Add('Authorization:Bearer ' + Auth);
  Params := TStringList.Create;
  try
    Params.Add('abn=' + ABN);
    Params.Add('clientId=' + ClientID);
    if aMessageType = 0 then
      Params.Add('messageType=Submit.003.00')
    else
      Params.Add('messageType=Update.003.00');
    Params.Add('payloadFile="' + aFileName +'"');
    Log('Upload - Before Post');
    result := Http.Post(URL,Params);
    Log('Upload - After Post');
  finally
    Params.Free;
  end;
end;

initialization
  AppTempDir := '';
  fOzEDI.Free;

end.
