unit utGovUK_API;

interface

uses
  JsonObject, IdHTTP, SystemLib, URILib, ShellAPI, IdHttpServer, IdContext,
  IdCustomHTTPServer, ConTnrs, SysUtils, Classes, HttpSSLClientObj;

type
  TGovUK_API  = class;
  TOnNewToken = procedure (Sender: TGovUK_API; Scope, Token: string) of object;
  TOnLog = procedure (msg: string) of object;
  TGovUKErrorList = class;

  TGovUK_API  = class(TObject)
  private
    fOnNewToken: TOnNewToken;
    HttpServer: TIdHttpServer;
    HttpClient: THttpSSLClient; //TIdHTTP;
    ServerPort: integer;
    LastScope: string;
    fSandboxMode: boolean;
    fSandboxClientID: string;
    fSandboxClientSecret: string;
    fOnLog: TOnLog;
    fAuthSuccessMessage: string;
    fVATRegistrationNumber: string;
    fTokenList: TJsonObject;
    fProductionClientID: string;
    fProductionClientSecret: string;
    fOnError: TNotifyEvent;
    fDoOnError: boolean;
    function GetBearerToken(scope: string): string;
    procedure DoOnGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponceInfo: TIdHTTPResponseInfo);
    function GetServerActive: boolean;
    procedure SetServerActive(const Value: boolean);
    procedure ProcessNewAuthCode;
    function DoGetToken(Scope, GrantType, AuthCode: string): boolean;
    procedure SaveTokenList;
    procedure LoadTokenList;
    procedure Log(msg: string);
    procedure ProcessError(e: Exception);
    procedure DoOnNewToken;
    procedure VATJsonToStream(Json: TJsonObject; stream: TStringStream);
    procedure AddFraudHeaders;
    function GetTokenList: TJsonObject;
    procedure CreateHttpSSLClient;
  protected
    property ServerActive: boolean read GetServerActive write SetServerActive;
  public
    ErrorList: TGovUKErrorList;
    property TokenList: TJsonObject read GetTokenList;
    constructor Create;
    destructor Destroy; override;
    property BearerToken[scope: string]: string read GetBearerToken;
    function RefreshToken(scope: string): boolean;
    function CheckToken(scope: string; var RequiresUserRefresh: boolean): boolean;
    property OnNewToken: TOnNewToken read fOnNewToken write fOnNewToken;
    property SandboxMode: boolean read fSandboxMode write fSandboxMode;
    property SandboxClientID: string read fSandboxClientID write fSandboxClientID;
    property SandboxClientSecret: string read fSandboxClientSecret write fSandboxClientSecret;
    property ProductionClientID: string read fProductionClientID write fProductionClientID;
    property ProductionClientSecret: string read fProductionClientSecret write fProductionClientSecret;
    property VATRegistrationNumber: string read fVATRegistrationNumber write fVATRegistrationNumber;
    function SubmitVATReturn(aVATReturn, ResultJson: TJsonObject;
      var ScopeRequiringUserRefresh: string): boolean;
    function GetVATObligations(DateFrom, DateTo: TDateTime; aStatus: string;
      ResultJson: TJsonObject;
      var ScopeRequiringUserRefresh: string): boolean;
    function CreateTestOrganisation(aServiceNames, ResultJson: TJsonObject;
      var ScopeRequiringUserRefresh: string): boolean;
    property OnLog: TOnLog read fOnLog write fOnLog;
    property OnError: TNotifyEvent read fOnError write fOnError;
    property AuthSuccessMessage: string read fAuthSuccessMessage write fAuthSuccessMessage;
    property EnableOnError: boolean read fDoOnError write fDoOnError;
    class function Inst: TGovUK_API;
  end;

  TGovUKError = class(TObject)
  public
    Code: string;
    ErrorMessage: String;
  end;

  TGovUKErrorList = class(TObject)
  private
    List: TObjectList;
    function GetCount: integer;
    function GetItem(idx: integer): TGovUKError;
    function GetFormattedErrors: string;
  public
    constructor Create;
    destructor Destroy; override;
    property Count: integer read GetCount;
    property Item[idx: integer]: TGovUKError read GetItem;
    procedure Clear;
    procedure Add(aCode, aMessage: string);
    property FormattedErrors: string read GetFormattedErrors;
  end;


const
  Scope_ReadVAT = 'read:vat';
  Scope_WriteVAT = 'write:vat';
  Scope_VAT = Scope_ReadVAT + '+' + Scope_WriteVAT;

implementation

uses
  Windows, IdSSLOpenSSL, DateUtils, ModuleFileNameUtils,
  Dialogs, IdMultipartFormData, JsonObjectUtils, Registry, InstallConst,
  AppEnvironment, DateTimeUtils, IdStack, Forms, ERPVersionConst,
  MachineSignature
  //CK_JsonObject, CK_DLL_Const, {CK_DLL_HTTPLogreaderObj,} CkString, authUtil,
  //global
  ;

const
  BaseURL_Sandbox = 'https://test-api.service.hmrc.gov.uk';
  BaseURL_Production = 'https://api.service.hmrc.gov.uk';

  GrantType_Refresh_Token = 'refresh_token';
  GrantType_Authorization_Code = 'authorization_code';

  HMRC_Version = '1.0';

var
  fGovUK_API: TGovUK_API;


function DuplicateSlashes(const s : string) : string;
var
  idx : integer;
begin
  result := '';
  for idx := 1 to Length(s) do
    if s[idx] = '\' then
      Result := Result + '\\'
    else
      Result := Result + s[idx];
end;



{ TGovUK_API }

procedure TGovUK_API.AddFraudHeaders;
var
  reg : TRegistry;
  lKey : string;
  DeviceID, IPList: string;
  I: integer;
  Guid: TGUID;
  UserAgent: string;
begin
//  if DeviceID <> '' then
//    HttpClient.Request.CustomHeaders.Values['Gov-Client-Device-ID'] := PercentEncode(DeviceID);
//  HttpClient.Request.CustomHeaders.Values['Gov-Client-User-IDs'] := PercentEncode('os=' + AppEnv.Employee.LogonName);
//  HttpClient.Request.CustomHeaders.Values['Gov-Client-Timezone'] := PercentEncode('UTC' + TimezoneToStr);

  HttpClient.CustomHeaders['Gov-Client-Connection-Method'] := 'DESKTOP_APP_DIRECT';

  if DeviceID <> '' then
    HttpClient.CustomHeaders['Gov-Client-Device-ID'] := PercentEncode(DeviceID);
  HttpClient.CustomHeaders['Gov-Client-User-IDs'] := PercentEncode('os=' + AppEnv.Employee.LogonName);
  HttpClient.CustomHeaders['Gov-Client-Timezone'] := PercentEncode('UTC' + TimezoneToStr);

  IPList := '';
  TIdStack.IncUsage;
  try
    IPList := GStack.LocalAddresses.CommaText;
  finally
    TIdStack.DecUsage;
  end;
//  if IPList <> '' then
//    HttpClient.Request.CustomHeaders.Values['Gov-Client-Local-IPs'] := PercentEncode(IPList);
//  HttpClient.Request.CustomHeaders.Values['Gov-Client-Screens'] :=
//    PercentEncode('width=' + IntToStr(Screen.Width) + '&height=' + IntToStr(Screen.Height));
//  HttpClient.Request.CustomHeaders.Values['Gov-Client-Window-Size'] :=
//    PercentEncode('width=' + IntToStr(Application.MainForm.Width) + '&height=' + IntToStr(Application.MainForm.Height));

  if IPList <> '' then
    HttpClient.CustomHeaders['Gov-Client-Local-IPs'] := PercentEncode(IPList);
  HttpClient.CustomHeaders['Gov-Client-Screens'] :=
    PercentEncode('width=' + IntToStr(Screen.Width) + '&height=' + IntToStr(Screen.Height));
  HttpClient.CustomHeaders['Gov-Client-Window-Size'] :=
    PercentEncode('width=' + IntToStr(Application.MainForm.Width) + '&height=' + IntToStr(Application.MainForm.Height));

  UserAgent := '';
  reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion', false) then begin
      try
        UserAgent := Reg.ReadString('ProductName');
      finally
        Reg.CloseKey;
      end;
    end;
  finally
    reg.Free;
  end;
//  if UserAgent <> '' then
//    HttpClient.Request.CustomHeaders.Values['Gov-Client-User-Agent'] := PercentEncode('Windows/' + UserAgent + ' (/)');
//  { NOTE: omitting Gov-Client-Multi-Factor for now. }
//
//  HttpClient.Request.CustomHeaders.Values['Gov-Vendor-Version'] := PercentEncode('ERP=' + TABLE_VERSION);
//  { Note: omitting Gov-Vendor-License-IDs }
//  HttpClient.Request.CustomHeaders.Values['Gov-Client-MAC-Addresses'] := PercentEncode(GetAllMACAddresses);

  if UserAgent <> '' then
    HttpClient.CustomHeaders['Gov-Client-User-Agent'] := PercentEncode('Windows/' + UserAgent + ' (/)');
  { NOTE: omitting Gov-Client-Multi-Factor for now. }

  HttpClient.CustomHeaders['Gov-Vendor-Version'] := PercentEncode('ERP=' + TABLE_VERSION);
  { Note: omitting Gov-Vendor-License-IDs }
  HttpClient.CustomHeaders['Gov-Client-MAC-Addresses'] := PercentEncode(GetAllMACAddresses);

end;

function TGovUK_API.CheckToken(scope: string;
  var RequiresUserRefresh: boolean): boolean;
begin
  result := true;
  ErrorList.Clear;
  RequiresUserRefresh := false;
  if not TokenList.ObjectExists(scope) then begin
    RequiresUserRefresh := true;
    exit;
  end;
  if now > TokenList.O[scope].DT['ExpireTime'] then begin
    { expired }
    if TokenList.O[scope].S['RefreshToken'] = '' then begin
      RequiresUserRefresh := true;
      exit;
    end;
    result := DoGetToken(scope,GrantType_Refresh_Token,TokenList.O[scope].S['RefreshToken']);
  end;
end;

constructor TGovUK_API.Create;
var
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
begin
  fDoOnError := true;
  fAuthSuccessMessage := '';
  ErrorList := TGovUKErrorList.Create;
  fSandboxMode := true;
  ServerPort := 8080;
  HttpServer := TIdHttpServer.Create(nil);
  HttpServer.OnCommandGet := DoOnGet;
//  HttpClient := TIdHTTP.Create(nil);
//  SSLHandler:= TIdSSLIOHandlerSocketOpenSSL.Create(HTTPClient);
//  HTTPClient.IOHandler:= SSLHandler;
  CreateHttpSSLClient;
end;

procedure TGovUK_API.CreateHttpSSLClient;
begin
  HttpClient := THttpSSLClient.Create;
//  HttpClient.DebugMode := true;
  HttpClient.ClearSSLVersions;
  HttpClient.AddSSLVersion('1');
  HttpClient.AddSSLVersion('1.2');
  AddFraudHeaders;

end;

function TGovUK_API.CreateTestOrganisation(aServiceNames,
  ResultJson: TJsonObject;
  var ScopeRequiringUserRefresh: string): boolean;
var
  url, s: string;
  stream: TStringStream;
  RefreshRequired: boolean;
begin
  result := true;
  ScopeRequiringUserRefresh := '';
  ErrorList.Clear;
  if SandboxMode then
    url := BaseURL_Sandbox
  else
    url := BaseURL_Production;
  url := url + '/create-test-user/organisations';
  if not CheckToken(Scope_VAT,RefreshRequired) then begin
    result := false;
    exit;
  end;
  if RefreshRequired then begin
    ScopeRequiringUserRefresh := Scope_VAT;
    result := false;
    exit;
  end;

//  HttpClient.Request.Accept := 'application/vnd.hmrc.' + HMRC_Version + '+json';
//  HttpClient.Request.ContentType := 'application/json';
//  HttpClient.Request.CustomHeaders.Values['Authorization'] := 'Bearer ' + TokenList.O[Scope_VAT].S['Token'];
  HttpClient.Accept := 'application/vnd.hmrc.' + HMRC_Version + '+json';
  HttpClient.ContentType := 'application/json';
  HttpClient.CustomHeaders['Authorization'] := 'Bearer ' + TokenList.O[Scope_VAT].S['Token'];

  stream := TStringStream.Create;
  try
    VATJsonToStream(aServiceNames, stream);
    stream.Position := 0;
    try
//      s := HttpClient.Post(url, stream);
      s := HttpClient.Post(url, stream.DataString);
      ResultJson.AsString := s;
    except
      on e: exception do begin
        result := false;
        self.ProcessError(e);
//        try
//          HttpClient.Free;
//        except
//        end;
//        CreateHttpSSLClient;
      end;
    end;
  finally
    stream.Free;
  end;
end;

destructor TGovUK_API.Destroy;
begin
  ServerActive := false;
  fTokenList.Free;
  HttpServer.Free;
  ErrorList.Free;
  inherited;
end;

function TGovUK_API.DoGetToken(Scope, GrantType, AuthCode: string): boolean;
var
//  FormDataStream: TIdMultiPartFormDataStream;
  url: string;
  s: string;
  res: TJsonObject;
  idx: integer;
begin
  result := true;
//  FormDataStream := TIdMultiPartFormDataStream.Create;
  HttpClient.ClearFormData;
  try
    if SandboxMode then begin
//      FormDataStream.AddFormField('client_secret', SandboxClientSecret);
//      FormDataStream.AddFormField('client_id', SandboxClientID);
      HttpClient.AddFormField('client_secret', SandboxClientSecret);
      HttpClient.AddFormField('client_id', SandboxClientID);
    end
    else begin
//      FormDataStream.AddFormField('client_secret', ProductionClientSecret);
//      FormDataStream.AddFormField('client_id', ProductionClientID);
      HttpClient.AddFormField('client_secret', ProductionClientSecret);
      HttpClient.AddFormField('client_id', ProductionClientID);
    end;
//    FormDataStream.AddFormField('grant_type', GrantType);
    HttpClient.AddFormField('grant_type', GrantType);
    if SameText(GrantType, GrantType_Authorization_Code) then begin
//      FormDataStream.AddFormField('redirect_uri', 'http://localhost:' + IntToStr(ServerPort));
//      FormDataStream.AddFormField('code', AuthCode);
      HttpClient.AddFormField('redirect_uri', 'http://localhost:' + IntToStr(ServerPort));
      HttpClient.AddFormField('code', AuthCode);
    end
    else begin
//      FormDataStream.AddFormField('refresh_token', AuthCode);
      HttpClient.AddFormField('refresh_token', AuthCode);
    end;


    if SandboxMode then
      url := BaseURL_Sandbox
    else
      url := BaseURL_Production;
    url := url + '/oauth/token';

//    HttpClient.Request.Accept := 'application/vnd.hmrc.' + HMRC_Version + '+json';
//    HttpClient.Request.ContentType := 'application/x-www-form-urlencoded'; //  'application/json';
//    idx := HttpClient.Request.CustomHeaders.IndexOfName('Authorization');
//    if idx > -1 then
//      HttpClient.Request.CustomHeaders.Delete(idx);
    HttpClient.Accept := 'application/vnd.hmrc.' + HMRC_Version + '+json';
    HttpClient.ContentType := 'application/x-www-form-urlencoded'; //  'application/json';
    HttpClient.DeleteCustomHeader('Authorization');

    try
//      s := HttpClient.Post(url, FormDataStream);
      s := HttpClient.PostFormData(url);
//      Log('OK!');
    except
      on e: exception do begin
        result := false;
        ProcessError(e);
//        try
//          HttpClient.Free;
//        except
//        end;
//        CreateHttpSSLClient;
      end;
    end;
    HttpClient.ClearFormData;

    res := JO;
    try
      res.AsString := s;
      TokenList.O[Scope].DT['ExpireTime'] := now + ((res.I['expires_in'] - 10) * OneSecond);
      TokenList.O[Scope].S['Token'] := res.S['access_token'];
      TokenList.O[Scope].S['RefreshToken'] := res.S['refresh_token'];
      SaveTokenList;
    finally
      res.Free;
    end;
  finally
//    FormDataStream.Free;
  end;
end;

procedure TGovUK_API.DoOnGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponceInfo: TIdHTTPResponseInfo);
var
  ContentText: string;
  AuthOK: boolean;
  s: string;
begin
  AuthOk := true;
  if ARequestInfo.Params.Values['code'] <> '' then begin
    TokenList.O[LastScope].S['AuthCode'] := ARequestInfo.Params.Values['code'];
    SaveTokenList;
    Log('Auth Code: ' + ARequestInfo.Params.Values['code']);
    { triger event }
    TThread.CreateAnonymousThread(
      procedure()
      begin
        Sleep(50);
        TThread.Synchronize(TThread.CurrentThread, ProcessNewAuthCode);
      end
    ).Start;
  end
  else begin
    AuthOk := false;
  end;

  if AuthOk then begin
    s :=
      '<html><body><h3 style="color:blue;margin:30px">Authorization Successful!';
    if AuthSuccessMessage <> '' then
      s := s + '<p>' + AuthSuccessMessage + '</p>';

    s := s + '</h3></body></html>';

    ContentText := s;
  end
  else begin
    ContentText := '<html><body><h3 style="color:blue;margin:30px">Authorization Failed!</h3></body></html>';
  end;
  AResponceInfo.ResponseNo := 200;
  AResponceInfo.ContentText := ContentText;

end;

procedure TGovUK_API.DoOnNewToken;
begin
  TThread.CreateAnonymousThread(
    procedure()
    begin
      Sleep(50);
      TThread.Synchronize(TThread.CurrentThread,
        procedure ()
        begin
          if Assigned(fOnNewToken) then
            fOnNewToken(self, LastScope, TokenList.O[LastScope].S['Token']);
        end
      );
    end
  ).Start;
end;

function TGovUK_API.GetBearerToken(scope: string): string;
begin
  result := '';
  if TokenList.O[scope].DT['ExpireTime'] > now then
    result := TokenList.O[scope].S['Token'];
end;

function TGovUK_API.GetServerActive: boolean;
begin
  result := HttpServer.Active;
end;

function TGovUK_API.GetTokenList: TJsonObject;
begin
  if not Assigned(fTokenList) then begin
    fTokenList := JO;
    LoadTokenList;
  end;
  if fTokenList.S['VRN'] <> VATRegistrationNumber then begin
    fTokenList.Clear;
    fTokenList.S['VRN'] := VATRegistrationNumber;
  end;
  result := fTokenList;
end;

function TGovUK_API.GetVATObligations(DateFrom, DateTo: TDateTime; aStatus: string;
  ResultJson: TJsonObject;
  var ScopeRequiringUserRefresh: string): boolean;
var
  url, query, s: string;
//  stream: TStringStream;
  RefreshRequired: boolean;
begin
  result := true;
  ScopeRequiringUserRefresh := '';
  ErrorList.Clear;
  if SandboxMode then
    url := BaseURL_Sandbox
  else
    url := BaseURL_Production;
  url := url + '/organisations/vat/'+VATRegistrationNumber+'/obligations';
  query := '';
  if DateFrom > 0 then begin
    query :=
      '?from=' + FormatDateTime('yyyy-mm-dd', DateFrom) +
      '&to=' + FormatDateTime('yyyy-mm-dd', DateTo);
  end;
  if aStatus <> '' then begin
    if query = '' then query := '?'
    else query := query + '&';
    query := query + 'status=' + aStatus;
  end;
//  url := url +
//    '?from=' + FormatDateTime('yyyy-mm-dd', DateFrom) +
//    '&to=' + FormatDateTime('yyyy-mm-dd', DateTo);
  url := url + query;
  if not CheckToken(Scope_VAT,RefreshRequired) then begin
    result := false;
    exit;
  end;
  if RefreshRequired then begin
    ScopeRequiringUserRefresh := Scope_VAT;
    result := false;
    exit;
  end;

//  HttpClient.Request.Accept := 'application/vnd.hmrc.' + HMRC_Version + '+json';
//  HttpClient.Request.ContentType := 'application/json';
//  HttpClient.Request.CustomHeaders.Values['Authorization'] := 'Bearer ' + TokenList.O[Scope_VAT].S['Token'];
  HttpClient.Accept := 'application/vnd.hmrc.' + HMRC_Version + '+json';
  HttpClient.ContentType := 'application/json';
  HttpClient.CustomHeaders['Authorization'] := 'Bearer ' + TokenList.O[Scope_VAT].S['Token'];
  try
    s := HttpClient.Get(url);
    ResultJson.AsString := s;
  except
    on e: exception do begin
      result := false;
      self.ProcessError(e);
//      try
//        HttpClient.Free;
//      except
//      end;
//      CreateHttpSSLClient;
    end;
  end;
end;

class function TGovUK_API.Inst: TGovUK_API;
begin
  if not Assigned(fGovUK_API) then
    fGovUK_API := TGovUK_API.Create;
  result := fGovUK_API;
end;

procedure TGovUK_API.LoadTokenList;
begin
  try
    if FileExists(GetMyDocumentsDir + 'GovUK_TokenData.dat') then begin
      LoadFromEncrypedFile(TokenList, GetMyDocumentsDir + 'GovUK_TokenData.dat');
    end;
  except

  end;
end;

procedure TGovUK_API.Log(msg: string);
begin
  if Assigned(fOnLog) then
    fOnLog(msg);
end;

procedure TGovUK_API.ProcessError(e: Exception);
var
  pe: EIdHTTPProtocolException;
  json, err: TJsonObject;
  x: integer;
  s: string;
begin
  if e is EIdHTTPProtocolException then begin
    pe := EIdHTTPProtocolException(e);
    try
      json := JO;
      try
        json.AsString := pe.ErrorMessage;
        if json.ArrayExists('errors') then begin
          for x := 0 to json.A['errors'].Count -1 do begin
            err := json.A['errors'][x].AsObject;
            s := err.S['message'];
            if err.StringExists('path') then
              s := s + ' ' + err.S['path'];
            ErrorList.Add(err.S['code'], Trim(s));
          end;
        end
        else begin
          ErrorList.Add(json.S['code'], Trim(json.S['message']));
        end;
      finally
        json.Free;
      end;
    except
      on ex: exception do
        ErrorList.Add('Error', Trim(e.Message));
    end;
  end
  else begin
    ErrorList.Add('Error', Trim(e.Message));
  end;
  if Assigned(fOnError) and fDoOnError then
    fOnError(self);
end;

procedure TGovUK_API.ProcessNewAuthCode;
begin
  if DoGetToken(LastScope, GrantType_Authorization_Code, TokenList.O[LastScope].S['AuthCode']) then begin
    DoOnNewToken;
  end;
end;

function TGovUK_API.RefreshToken(scope: string): boolean;
var
  url: string;
  ClientID: string;
begin
  result := true;
  try
    LastScope := scope;
    if TokenList.O[scope].S['RefreshToken'] <> '' then begin
      if self.DoGetToken(scope,GrantType_Refresh_Token,TokenList.O[scope].S['RefreshToken']) then begin
        DoOnNewToken;
      end
      else begin
        result := false;
      end;
      exit;
    end;

    if SandboxMode then begin
      url := BaseURL_Sandbox;
      ClientID := SandboxClientID;
    end
    else begin
      url := BaseURL_Production;
      ClientID := ProductionClientID;
    end;
    url := url +
      '/oauth/authorize?response_type=code' +
      '&client_id=' + ClientID +
      '&scope=' + scope +
//      '&scope=' + URLEncode(scope) +
  //    '&state=[STATE] +
      '&redirect_uri=' + URLEncode('http://localhost:' + IntToStr(ServerPort));
    ServerActive := true;
    ShellExecute(0, 'OPEN', PChar(url), '', '', SW_SHOWNORMAL);
  except
    on e: exception do begin
      result := false;
      self.ProcessError(e);
    end;
  end;
end;

procedure TGovUK_API.SaveTokenList;
begin
//  TokenList.SaveToFile(GetCurrentModulePath + 'GovUK_TokenData.dat');
//  SaveToEncrypedFile(TokenList, GetCurrentModulePath + 'GovUK_TokenData.dat');
  SaveToEncrypedFile(TokenList, GetMyDocumentsDir + 'GovUK_TokenData.dat');
end;

procedure TGovUK_API.SetServerActive(const Value: boolean);
begin
  if Value = HttpServer.Active then exit;

  HttpServer.Active := false;
  if not Value then exit;
  ServerPort := 8080;
  while ServerPort < 8085 do begin
    HttpServer.Bindings.Clear;
    HttpServer.Bindings.Add.Port := ServerPort;
    try
      HttpServer.Active := true;
      break;
    except
      ServerPort := ServerPort + 1;
    end;
  end;
  if ServerPort > 8084 then
    raise Exception.Create(ClassName + ' - No local Server Port available in the 8080 to 8084 range.');
end;

function TGovUK_API.SubmitVATReturn(aVATReturn, ResultJson: TJsonObject;
  var ScopeRequiringUserRefresh: string): boolean;
var
  url, s: string;
  stream: TStringStream;
  RefreshRequired: boolean;
begin
  result := true;
  ScopeRequiringUserRefresh := '';
  ErrorList.Clear;
  if SandboxMode then
    url := BaseURL_Sandbox
  else
    url := BaseURL_Production;
  url := url + '/organisations/vat/'+VATRegistrationNumber+'/returns';
  if not CheckToken(Scope_VAT,RefreshRequired) then begin
    result := false;
    exit;
  end;
  if RefreshRequired then begin
    ScopeRequiringUserRefresh := Scope_VAT;
    result := false;
    exit;
  end;

//  HttpClient.Request.Accept := 'application/vnd.hmrc.' + HMRC_Version + '+json';
//  HttpClient.Request.ContentType := 'application/json';
//  HttpClient.Request.CustomHeaders.Values['Authorization'] := 'Bearer ' + TokenList.O[Scope_VAT].S['Token'];
  HttpClient.Accept := 'application/vnd.hmrc.' + HMRC_Version + '+json';
  HttpClient.ContentType := 'application/json';
  HttpClient.CustomHeaders['Authorization'] := 'Bearer ' + TokenList.O[Scope_VAT].S['Token'];

  stream := TStringStream.Create;
  try
//    aVATReturn.SaveToStream(stream);
    VATJsonToStream(aVATReturn, stream);
    stream.Position := 0;
    try
      s := HttpClient.Post(url, stream.DataString);
      ResultJson.AsString := s;
    except
      on e: exception do begin
        result := false;
        self.ProcessError(e);
//        try
//          HttpClient.Free;
//        except
//        end;
//        CreateHttpSSLClient;
      end;
    end;
  finally
    stream.Free;
  end;
end;

procedure TGovUK_API.VATJsonToStream(Json: TJsonObject; stream: TStringStream);
var
  I: integer;
  pair: TJsonValuePair;
begin
  stream.WriteString('{');
  for I := 0 to Json.Count -1 do begin
    pair := Json.Items[I];
    case pair.ValueType of
      TJSONValueType.valNone: ;
      TJSONValueType.valString:
        begin
          if I > 0 then stream.WriteString(',');
          stream.WriteString('"'+pair.Name+'": ');
          stream.WriteString('"'+pair.Value.AsString+'"');
        end;
      TJSONValueType.valNumber:
        begin
          if I > 0 then stream.WriteString(',');
          stream.WriteString('"'+pair.Name+'": ');
          if SameText(pair.Name,'vatDueSales') or
              SameText(pair.Name,'vatDueAcquisitions') or
              SameText(pair.Name,'totalVatDue') or
              SameText(pair.Name,'vatReclaimedCurrPeriod') or
              SameText(pair.Name,'netVatDue') then
            stream.WriteString(FormatFloat('#0.00;-#0.00', pair.Value.AsFloat))
//          else if SameText(pair.Name,'netVatDue') then
//            stream.WriteString(FormatFloat('#0.00;-#0.00', Abs(pair.Value.AsFloat)))
          else
            stream.WriteString(FormatFloat('#0;-#0', Round(pair.Value.AsFloat)));
        end;
      TJSONValueType.valObject: ;
      TJSONValueType.valArray: ;
      TJSONValueType.valNull: ;
      TJSONValueType.valBoolean:
        begin
          if I > 0 then stream.WriteString(',');
          stream.WriteString('"'+pair.Name+'": ');
          if pair.Value.AsBoolean then stream.WriteString('true')
          else stream.WriteString('false')
        end;
    end;
  end;
  stream.WriteString('}');
end;

{ TGovUKErrorList }

procedure TGovUKErrorList.Add(aCode, aMessage: string);
var
  err: TGovUKError;
begin
  err := TGovUKError.Create;
  err.Code := aCode;
  err.ErrorMessage := aMessage;
  List.Add(err);
end;

procedure TGovUKErrorList.Clear;
begin
  List.Clear;
end;

constructor TGovUKErrorList.Create;
begin
  List := TObjectList.Create;
end;

destructor TGovUKErrorList.Destroy;
begin
  List.Free;
  inherited;
end;

function TGovUKErrorList.GetCount: integer;
begin
  result := List.Count;
end;

function TGovUKErrorList.GetFormattedErrors: string;
var
  I: Integer;
begin
  result := '';
  for I := 0 to Count-1 do begin
    if I  > 0 then result := result + #13#10 + #13#10;
    result := result + Item[I].ErrorMessage;
  end;
end;

function TGovUKErrorList.GetItem(idx: integer): TGovUKError;
begin
  result := TGovUKError(List[idx]);
end;

initialization
  fGovUK_API := nil;


finalization
  fGovUK_API.Free;

end.
