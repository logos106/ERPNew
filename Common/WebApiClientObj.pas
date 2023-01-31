unit WebApiClientObj;

interface

uses
  Classes, JsonObject;

type

  TWebApiClient = class
  private
    fURL: string;
    fDatabase: string;
    fPassword: string;
    fUserName: string;
    fErrorMessage: string;
    fResponseCode: integer;
    fIsSSL: boolean;
    procedure SetURL(const Value: string);
    procedure Reset;
  public
    constructor Create;
    destructor Destroy; override;
    property URL: string read fURL write SetURL;
    property UserName: string read fUserName write fUserName;
    property Password: string read fPassword write fPassword;
    property Database: string read fDatabase write fDatabase;
    property ResponseCode: integer read fResponseCode;
    property ErrorMessage: string read fErrorMessage;
    function Get(aPath: string; var ResultStr: string): boolean; overload;
    function Get(aPath: string; var ResultJson: TJsonObject): boolean; overload;
    function Get(aClassName, aGlobalRef: string; var ResultJson: TJsonObject): boolean; overload;
    function Get(aClassName: string; aId: integer; var ResultJson: TJsonObject): boolean; overload;
    function Post(aPath: string; stream: TStream; var ResultStr: string): boolean; overload;
    function Post(aPath: string; stream: TStream; var ResultJson: TJsonObject): boolean; overload;
    function Post(aPath: string; Json: TJsonObject; var ResultJson: TJsonObject): boolean; overload;
    function ResponseOk: boolean;
    function NotFound: boolean;
  end;

const
  RetryCount = 3;
  RetryDelaySeconds = 3;

implementation

uses
  WebApiConst, StrUtils, IdHttp, IdSSLOpenSSL, SysUtils, HTTPConst;

{ TWebApiClient }

constructor TWebApiClient.Create;
begin
  fIsSSL:= false;
  Reset;
end;

destructor TWebApiClient.Destroy;
begin

  inherited;
end;

function TWebApiClient.Get(aClassName: string; aId: integer;
  var ResultJson: TJsonObject): boolean;
begin
  result:= Get(aClassName + '/'+ IntToStr(aID),ResultJson);
end;

function TWebApiClient.NotFound: boolean;
begin
  result:= self.fResponseCode = 404;
end;

function TWebApiClient.Get(aClassName, aGlobalRef: string;
  var ResultJson: TJsonObject): boolean;
begin
  if aGlobalRef <> '' then
    result:= Get(aClassName + '?GlobalRef='+ aGlobalRef,ResultJson)
  else
    result:= false;
end;

function TWebApiClient.Get(aPath: string; var ResultJson: TJsonObject): boolean;
var
  s: string;
begin
  result:= true;
  if Assigned(ResultJson) then
    ResultJson.Free;
  ResultJson:= nil;
  if Get(aPath, s) then begin
    ResultJson:= JO;
    try
      ResultJson.AsString:= s;
    except
      on e: exception do begin
        result:= false;
        ResultJson.Free;
        ResultJson:= nil;
        fResponseCode:= 0;
        fErrorMessage:= 'Error reading JSON from response: ' + e.Message;
      end;
    end;
  end
  else
    result:= false;
end;

function TWebApiClient.Post(aPath: string; Json: TJsonObject;
  var ResultJson: TJsonObject): boolean;
var
  stream: TMemoryStream;
begin
  stream:= TMemoryStream.Create;
  try
    Json.SaveToStream(stream);
    stream.Position:= 0;
    result:= Post(aPath,stream,ResultJson);
  finally
    stream.Free;
  end;
end;

function TWebApiClient.Post(aPath: string; stream: TStream;
  var ResultJson: TJsonObject): boolean;
var
  s: string;
begin
  result:= true;
  ResultJson:= nil;
  if Post(aPath, stream, s) then begin
    ResultJson:= JO;
    try
      ResultJson.AsString:= s;
    except
      on e: exception do begin
        result:= false;
        ResultJson.Free;
        ResultJson:= nil;
        fResponseCode:= 0;
        fErrorMessage:= 'Error reading JSON from response: ' + e.Message;
      end;
    end;
  end
  else
    result:= false;
end;

function TWebApiClient.Post(aPath: string; stream: TStream;
  var ResultStr: string): boolean;
var
  HTTPClient: TIdHTTP;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  TryNumber: integer;
begin
  Reset;
  HTTPClient:= TIdHTTP.Create(nil);
  try
    HttpClient.Request.UserAgent := HTTPConst.TrueERPUserAgent;
    if fIsSSL then begin
      SSLHandler:= TIdSSLIOHandlerSocketOpenSSL.Create(HTTPClient);
      HTTPClient.IOHandler:= SSLHandler;
      HTTPClient.Request.BasicAuthentication:= true;
      HTTPClient.Request.Username:= UserName;
      HTTPClient.Request.Password:= Password;
    end
    else begin
      HTTPClient.Request.CustomHeaders.AddValue('username', UserName);
      HTTPClient.Request.CustomHeaders.AddValue('password', Password);
    end;
    HTTPClient.ReadTimeout:= 1000 * 30;
    HTTPClient.Request.CustomHeaders.AddValue('database', Database);
    TryNumber := 1;

    while true do begin
      try
        ResultStr:= HTTPClient.Post(URL + aPath, stream);
        break;
      except
        on e: exception do begin
          Inc(TryNumber);
          if TryNumber < RetryCount then
            sleep(RetryDelaySeconds * 1000)
          else begin
            result:= false;
            ResultStr:= '';
            fResponseCode:= HTTPClient.ResponseCode;
            if fResponseCode = 200 then
              fResponseCode:= 0;
            if HTTPClient.Response.RawHeaders.Values['errormessage'] <> '' then
              fErrorMessage:= HTTPClient.Response.RawHeaders.Values['errormessage']
            else
              fErrorMessage:= e.Message;
            exit;
          end;
        end;
      end;
    end;

    fResponseCode:= HTTPClient.ResponseCode;
    fErrorMessage:= HTTPClient.Response.RawHeaders.Values['errormessage'];
  finally
    result:= ResponseOk;
    HTTPClient.Free;
  end;
end;

function TWebApiClient.Get(aPath: string; var ResultStr: string): boolean;
var
  HTTPClient: TIdHTTP;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  TryNumber: integer;
  SS: TStringStream;
begin
  Reset;
  ResultStr := '';
  HTTPClient:= TIdHTTP.Create(nil);
  SS := TStringStream.Create;
  try
    try
      HttpClient.Request.UserAgent := HTTPConst.TrueERPUserAgent;
      if fIsSSL then begin
        SSLHandler:= TIdSSLIOHandlerSocketOpenSSL.Create(HTTPClient);
        HTTPClient.IOHandler:= SSLHandler;
        HTTPClient.Request.BasicAuthentication:= true;
        HTTPClient.Request.Username:= UserName;
        HTTPClient.Request.Password:= Password;
      end
      else begin
        HTTPClient.Request.CustomHeaders.AddValue('username', UserName);
        HTTPClient.Request.CustomHeaders.AddValue('password', Password);
      end;
      HTTPClient.ReadTimeout:= 1000 * 30;
      HTTPClient.Request.CustomHeaders.AddValue('database', Database);
      TryNumber := 1;

      while true do begin
        try
          HTTPClient.Get(URL + aPath,SS);
          if SS.Size <> HTTPClient.Response.ContentLength then begin
            result:= false;
            fResponseCode := 500;
            fErrorMessage := 'Content lenth error - recived ' + IntToStr(ss.Size) + ', header content length ' + IntToStr(HTTPClient.Response.ContentLength);
            exit;
          end;
          ResultStr := SS.DataString;
          break;
        except
          on e: exception do begin
            Inc(TryNumber);
            if (HTTPClient.ResponseCode <> 404) and (TryNumber < RetryCount) and (Pos('Connection refused',e.Message) < 1) then
              sleep(RetryDelaySeconds * 1000)
            else begin
              result:= false;
              ResultStr:= '';
              fResponseCode:= HTTPClient.ResponseCode;
              if fResponseCode = 200 then
                fResponseCode:= 0;
              if HTTPClient.Response.RawHeaders.Values['errormessage'] <> '' then
                fErrorMessage:= HTTPClient.Response.RawHeaders.Values['errormessage'] +
                  ' ' + e.Message
              else
                fErrorMessage:= e.Message;
              exit;
            end;
          end;
        end;
      end;

      fResponseCode:= HTTPClient.ResponseCode;
      fErrorMessage:= HTTPClient.Response.RawHeaders.Values['errormessage'];
    except
      on e: exception do begin
        result:= false;
        fErrorMessage := 'TWebApiClient.Get - Exception while getting ' + aPath + ': ' + e.Message;
        exit;
      end;
    end;
  finally
    result:= ResponseOk;
    HTTPClient.Free;
    SS.Free;
  end;
end;

procedure TWebApiClient.Reset;
begin
  fErrorMessage:= '';
  fResponseCode:= 0;
end;

function TWebApiClient.ResponseOk: boolean;
begin
  result:= ResponseCode = 200;
end;

procedure TWebApiClient.SetURL(const Value: string);
begin
  { make sure url contains erpapi bit and ends in / }
  fURL := Value;
  if Copy(fURL,Length(fURL),1) = '/' then
    fURL:= Copy(fURL,1,Length(fURL)-1);
  if not ContainsText(fURL,WebApiConst.ERP_API_Res) then
    fURL:= fURL + '/' + WebApiConst.ERP_API_Res;
  fURL:= fURL + '/';
  fIsSSL:= ContainsText(fURL,'HTTPS');
end;

end.
