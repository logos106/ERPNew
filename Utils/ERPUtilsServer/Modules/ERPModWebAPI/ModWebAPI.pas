unit ModWebAPI;

interface

uses
  ServerModuleObj, JsonObject, ThreadProperty, SysUtils,
  IdHttpServer, IdContext, IdCustomHttpServer, SyncObjs, WebAPIThreadObj,
  LogThreadBase, Classes , IdComponent , IdSocketHandle , IdGlobal, IdIntercept ;


type

  TModWebAPI = class(TServerModule)
  private
    fDefaultPortProp: TThreadProperty;
    fDefaultSSLPortProp: TThreadProperty;
    fMaxConnectionsProp: TThreadProperty;
    fUseSSLProp: TThreadProperty;
    fWebUserNameProp: TThreadProperty;
    HTTPServer: TIdHttpServer;
    Lock: TCriticalSection;
    ThreadList: TApiThreadList;
    fNextCheckTime: TDateTime;
    fInitialMemSize: Cardinal;
    Started: Boolean;
    fStartTime: TDateTime;
    fLogger: TLoggerBase;
    fbstarted: Boolean;
    fidelctr: Integer;
    fsCertFile, fsKeyFile, fsRootCertFile: String;

    function GetDefaultPort: Integer;
    function GetDefaultSSLPort: Integer;
    function GetMaxConnections: Integer;
    function GetUseSSL: Boolean;
    function GetWebUserName: string;
    procedure SetDefaultPort(const Value: Integer);
    procedure SetDefaultSSLPort(const Value: Integer);
    procedure SetMaxConnections(const Value: Integer);
    procedure SetUseSSL(const Value: Boolean);
    procedure SetWebUserName(const Value: string);
    procedure StartHttpServer;
    procedure DoOnCommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure DoOnCommandOther(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure DoOnConnect(AContext: TIdContext);
    procedure DoServerThreadException(AContext:TIdContext; AException: Exception);
    procedure DoOnParseAuthentication(AContext: TIdContext;
      const AAuthType, AAuthData: String; var VUsername, VPassword: String;
      var VHandled: Boolean);
    (*procedure SSLIOHandlerOnGetPassword(var Password: String);*)
    (*procedure SSLIOHandlerOnGetPasswordEx(ASender: TObject;var VPassword: String; const AIsWrite: Boolean);*)
    (*procedure IdSSLIOHandlerSocketOpenSSL1Status(ASender: TObject;const AStatus: TIdStatus; const AStatusText: string);*)
    (*procedure HTTPServerBeforeBind(AHandle: TIdSocketHandle);*)
    (*procedure HTTPServerConnect(AContext: TIdContext);*)
    (*procedure HTTPServerStatus(ASender: TObject; const AStatus: TIdStatus;      const AStatusText: string);*)
    procedure HTTPServerQuerySSLPort(APort: Word; var VUseSSL: Boolean);
    procedure QuerySSLPort(APort: TIdPort; var VUseSSL: Boolean);
    procedure CheckCertificateConfig;
    procedure LogEventHandler(Sender: TObject; const Event, Value : string);

  protected
    Creating: Boolean;
    function GetModuleDescription: string; override;
//    function GetModuleVersion: string; override;
    procedure AfterLoadConfig; override;

    procedure DoOnMessage(aClientId: Integer; aData: string; ctx: TJsonObject); override;
    procedure DoOnMessage(aClientId: Integer; aData: TJsonObject; ctx: TJsonObject); override;
    procedure DoOnCommandMessage(aData: string; ctx: TJsonObject); override;

    procedure DoOnRequest(aClientId: Integer; aRequest: string; ctx: TJsonObject; var aResponse: string); override;
    procedure DoOnRequest(aClientId: Integer; aRequest: TJsonObject; ctx: TJsonObject; aResponse: TJsonObject = nil); override;

    procedure DoWork; override;
    procedure SetActive(const Value: Boolean); override;

  public
    constructor Create(aLogger: TLoggerBase = nil); override;
    destructor Destroy; override;
//    procedure LoadConfig(encrypt: boolean = false); override;
//    procedure SaveConfig(encrypt: boolean = false); override;
    procedure LoadConfig; override;
    procedure SaveConfig; override;

  published
    property DefaultPort: Integer read GetDefaultPort write SetDefaultPort;
    property DefaultSSLPort: Integer read GetDefaultSSLPort write SetDefaultSSLPort;
    property MaxConnections: Integer read GetMaxConnections write SetMaxConnections;
    property UseSSL: boolean read GetUseSSL write SetUseSSL;
    property WebUserName: string read GetWebUserName write SetWebUserName;
  end;

  TTempFileStream = class(TFileStream)
  public
    destructor Destroy; override;
  end;


implementation

uses
  LogMessageTypes, JsonToObject, IdSSL, types, WebApiConst,
  IdSSLOpenSSL, JsonRPCUtils, JsonRpcConst, SystemLib,
  forms, URILib, AppDatabase, StringUtils, AppEnvironment, AuthUtilsObj,
  ModuleConst, utTokenList, utVS1Const, utCloudconst, idIOHandler, strutils , Dialogs ;


{ TModWebAPI }

procedure TModWebAPI.AfterLoadConfig;
var
  changed: Boolean;
begin
  { check / set config defaults }
  changed := False;
  if DefaultPort = 0 then begin
    DefaultPort := 80;
    changed := True;
  end;

  if DefaultSSLPort = 0 then begin
    DefaultSSLPort := 443;
    changed := True;
  end;

  if WebUserName = '' then begin
    WebUserName := 'WebUser';
    changed := True;
  end;

  if Changed then
    Self.SaveConfig;
end;

procedure TModWebAPI.CheckCertificateConfig;
var
  path: String;
  CustConfig: TJsonObject;
begin
  path := ExtractFilePath(Self.ModuleFileName);
  fsCertFile     := path + 'localhost.cer';
  fsKeyFile      := path + 'localhost.key';
  fsRootCertFile := path + 'localhost.cer';
end;

constructor TModWebAPI.Create(aLogger: TLoggerBase);
begin
  inherited;

  fbstarted := False;
  fidelctr := 1;
  fLogger := aLogger;
  fLogger.Events.AddMultiEvent(LogEventHandler);
  AppEnvList.APIMode := True;
  AppDatabase.MIN_TABLE_VERSION := '2018.0.3.0';
  Creating := True;
  try
    Lock := TCriticalSection.Create;
    Started := False;
    fStartTime := Now + ((1/24/60/60) * 10);
    fDefaultPortProp := TThreadProperty.Create('0');
    fDefaultSSLPortProp := TThreadProperty.Create('0');
    fMaxConnectionsProp := TThreadProperty.Create('0');
    fUseSSLProp := TThreadProperty.Create('True');
    fWebUserNameProp := TThreadProperty.Create('');

    HTTPServer := TIdHttpServer.Create(nil);
    HTTPServer.OnCommandGet := Self.DoOnCommandGet;
    HTTPServer.OnCommandOther := DoOnCommandOther;
    HTTPServer.OnException := Self.DoServerThreadException;
    HTTPServer.OnConnect := Self.DoOnConnect;
    HTTPServer.OnParseAuthentication := DoOnParseAuthentication;
    HTTPServer.MaxConnections := Self.MaxConnections;
    HTTPServer.OnQuerySSLPort := HTTPServerQuerySSLPort;
    HTTPServer.KeepAlive := True;

    LoadConfig;
    ThreadList := TApiThreadList.Create(Self.Logger);
    ThreadList.MySQLServer := MySQLServer;
    fNextCheckTime := Now + 1/24/60/2;
    fInitialMemSize := SystemLib.CurrentMemoryUsage;
  finally
    Creating := False;
  end;

  CheckCertificateConfig;
  StartHttpServer;
end;

destructor TModWebAPI.Destroy;
begin

  HTTPServer.Free;
  fDefaultPortProp.Free;
  fDefaultSSLPortProp.Free;
  fMaxConnectionsProp.Free;
  fUseSSLProp.Free;
  fWebUserNameProp.Free;
  ThreadList.Free;
  Lock.Free;
  inherited;
end;

procedure TModWebAPI.DoOnCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  URIParts: TStringDynArray;
  RequestJson, ResultJson: TJsonObject;
  x, i: integer;
  s: string;
  dt: TDateTime;
//  OutStream: TTempFileStream;
  Stream: TStream;
  aDatabaseDirectory, aUsername, aPassword: string;
begin
  dt := now;
  Stream := nil;
  if ltDetail in Logger.LogMessageTypes then begin
    Log('---------------------------------------------',ltDetail);
    Logger.Log('HTTP Request >>>>>', ltDetail);
    Logger.Log('  Command: ' + ARequestInfo.Command, ltDetail);
    Logger.Log('  URI: ' + ARequestInfo.URI, ltDetail);
    Logger.Log('  Params: ' + ARequestInfo.Params.CommaText, ltDetail);
    Logger.Log('  Form Params: ' + ARequestInfo.FormParams, ltDetail);
    Logger.Log('  Query Params: ' + ARequestInfo.QueryParams, ltDetail);
    Logger.Log('  Version: ' + ARequestInfo.Version, ltDetail);
    Logger.Log('  Accept: ' + ARequestInfo.Accept, ltDetail);
    Logger.Log('  Accept Char Set: ' + ARequestInfo.AcceptCharSet, ltDetail);
    Logger.Log('  Accept Encoding: ' + ARequestInfo.AcceptEncoding, ltDetail);
    Logger.Log('  Accept Language: ' + ARequestInfo.AcceptLanguage, ltDetail);
    Logger.Log('  Host: ' + ARequestInfo.Host, ltDetail);
    Logger.Log('  Content Type: ' + ARequestInfo.ContentType, ltDetail);
    Logger.Log('  Cookies: ' + ARequestInfo.Cookies.ToString, ltDetail);
    Logger.Log('  Auth User Name: ' + ARequestInfo.AuthUsername, ltDetail);
    Logger.Log('  Auth Password: ' + ARequestInfo.AuthPassword, ltDetail);
    Logger.Log('  Database: ' + ARequestInfo.RawHeaders.Values['database'], ltDetail);
    Logger.Log('  Raw headers:', ltDetail);
    for x:= 0 to ARequestInfo.RawHeaders.Count - 1 do begin
      Logger.Log('    [Name] ' + ARequestInfo.RawHeaders.Names[x] + '  [Value] ' +
        ARequestInfo.RawHeaders.Values[ARequestInfo.RawHeaders.Names[x]], ltDetail);
    end;
  end;

  AResponseInfo.ResponseNo := 204; { "No Content" }
  AResponseInfo.ContentType := 'text/plain';
  AResponseInfo.CharSet := 'UTF-8';
  try

    URIParts := SplitURI(Lowercase(ARequestInfo.URI));

    if (High(URIParts) >= 2) then  begin
      if (URIParts[1] = ERP_API_Res) then begin
        { this is an ERP WebAPI request  }
        { We will now turn this into a request that can be passed to the WebAPI module }
        RequestJson := TJsonObject.Create;
        ResultJson := TJsonObject.Create;
        try
          { Add relevent data to Json request object  }
          RequestJson.S[TAG_Method]:= 'webapi.webrequest';
          RequestJson.S['Host']:= ARequestInfo.Host;
          RequestJson.S['URI']:= ARequestInfo.URI;
          for i := 0 to High(URIParts) do begin
            RequestJson.A['URIParts'].Add(URIParts[i]);
          end;
          for i:= 0 to ARequestInfo.Params.Count - 1 do begin
//            RequestJson.O[TAG_CLOUD_Params].S[ARequestInfo.Params.Names[i]]:= ARequestInfo.Params.ValueFromIndex[i];
            s := Trim(ARequestInfo.Params.ValueFromIndex[i]);
            if StringIsQuoted(s) then begin
              RequestJson.O[TAG_CLOUD_Params].S[ARequestInfo.Params.Names[i]]:= StripQuotes(s);
            end
            else if s <> '' then begin
              if SameText(s, 'true') then
                RequestJson.O[TAG_CLOUD_Params].B[ARequestInfo.Params.Names[i]] := true
              else if SameText(s, 'false') then
                RequestJson.O[TAG_CLOUD_Params].B[ARequestInfo.Params.Names[i]] := false
              else if StringContainsLetter(s) then
                RequestJson.O[TAG_CLOUD_Params].S[ARequestInfo.Params.Names[i]]:= s
              else
                RequestJson.O[TAG_CLOUD_Params].F[ARequestInfo.Params.Names[i]] := StrToFloat(s);
            end;
          end;
          RequestJson.S[TAG_ContentType]:= AResponseInfo.ContentType;
          RequestJson.S[TAG_ERPDatabase]:= ARequestInfo.RawHeaders.Values['database'];
          if ARequestInfo.AuthExists then begin
            if SameText(TJsonObject(AContext.Data).S['AuthType'], 'Basic') then begin
              RequestJson.S[TAG_ERPUserName]:= ARequestInfo.AuthUserName;
              RequestJson.S[TAG_ERPPassword]:= ARequestInfo.AuthPassword;
            end
            else if SameText(TJsonObject(AContext.Data).S['AuthType'], 'Bearer') then begin
              if SameText(TJsonObject(AContext.Data).S['AuthData'], ModuleConst.ERP_ADMIN_TOKEN) then begin
                RequestJson.S[TAG_ERPUserName]:= ERP_ADMIN_USER;
                RequestJson.S[TAG_ERPPassword]:= TJsonObject(AContext.Data).S['AuthData'];
              end
              else begin
                case TokenList.Validate(TJsonObject(AContext.Data).S['AuthData'],aDatabaseDirectory,aUsername, aPassword) of
                  tvValid:
                    begin
                      RequestJson.S[TAG_ERPDatabase]:= aDatabaseDirectory;
                      RequestJson.S[TAG_ERPUserName]:= aUsername;
                      RequestJson.S[TAG_ERPPassword]:= aPassword;
                    end;
                  tvExpired:
                    begin
                      AResponseInfo.ResponseNo:= VS1_HTTP_Failed_Code; { "Unauthorized" }
                      AResponseInfo.CustomHeaders.Values['errormessage']:= 'Token expired';
                      exit;
                    end;
                  tvNotFound:
                    begin
                      AResponseInfo.ResponseNo:= VS1_HTTP_Failed_Code; { "Unauthorized" }
                      AResponseInfo.CustomHeaders.Values['errormessage']:= 'Token not found';
                      exit;
                    end;
                end;
              end;
            end
          end
          else begin
            RequestJson.S[TAG_ERPUserName] := ARequestInfo.RawHeaders.Values['username'];
            RequestJson.S[TAG_ERPPassword] := ARequestInfo.RawHeaders.Values['password'];
          end;
          RequestJson.S['ERPWebUserName'] := WebUserName;
          RequestJson.S['ERPFunction'] := ARequestInfo.RawHeaders.Values['erpfunction'];
          RequestJson.I['CommandType'] := Ord(ARequestInfo.CommandType); {(hcUnknown, hcHEAD, hcGET, hcPOST, hcDELETE, hcPUT, hcTRACE, hcOPTION)}
          RequestJson.S['Command'] := ARequestInfo.Command;
          if ARequestInfo.RawHeaders.IndexOfName(TAuthUtils.AuthSystemKey) > -1 then
            RequestJson.S[TAuthUtils.AuthSystemKey] := ARequestInfo.RawHeaders.Values[TAuthUtils.AuthSystemKey]
          else if Assigned(ARequestInfo.Cookies.Cookie[TAuthUtils.AuthSystemKey, '*']) then
            RequestJson.S[TAuthUtils.AuthSystemKey] := ARequestInfo.Cookies.Cookie[TAuthUtils.AuthSystemKey, '*'].Value;

          if Assigned(ARequestInfo.PostStream) then begin
            try
              RequestJson.O['JsonIn'].ReadFromStream(ARequestInfo.PostStream);
            except
              on e: exception do begin
                AResponseInfo.ResponseNo := 400; { "Bad Request" }
                AResponseInfo.CustomHeaders.Values['errormessage']:= 'Bad Request - Error reading JSON data';
                exit;
              end;
            end;
          end;

          Lock.Acquire;
          try
            ThreadList.DoHTTPRequest(RequestJson, ResultJson, Stream);
            if ResultJson.I[TAG_ResponseNo] = 500 then begin
              if ((Pos('MyDAC', ResultJson.S[TAG_ErrorMessage]) > 0) and
                  (Pos('Assertion failure', ResultJson.S[TAG_ErrorMessage]) > 0)) or
                  (Pos('Net packets out of order', ResultJson.S[TAG_ErrorMessage]) > 0) then begin
                { try again }
                ThreadList.DoHTTPRequest(RequestJson, ResultJson, Stream);
              end;
            end;
          finally
            Lock.Release;
          end;

          { Populate HTTP Response with data }
          if ARequestInfo.CommandType = hcOption then begin
            AResponseInfo.CustomHeaders.Values['Access-Control-Allow-Origin'] := '*';
            AResponseInfo.CustomHeaders.Values['Access-Control-Allow-Methods'] := 'GET, POST, OPTIONS';
            AResponseInfo.CustomHeaders.Values['Access-Control-Allow-Headers'] := 'accept, content-type, database, password, username';
            AResponseInfo.CustomHeaders.Values['Access-Control-Max-Age'] := '86400';
          end
          else begin
            AResponseInfo.CustomHeaders.Values['Access-Control-Allow-Origin'] := '*';
            AResponseInfo.CustomHeaders.Values['Access-Control-Expose-Headers'] := 'ErrorMessage';
          end;

          AResponseInfo.ResponseNo:= ResultJson.I[TAG_ResponseNo];
          if ResultJson.StringExists(TAG_ContentType) and (ResultJson.S[TAG_ContentType] <> '') then
            AResponseInfo.ContentType:= ResultJson.S[TAG_ContentType];
          if ResultJson.StringExists('CharSet') and (ResultJson.S['CharSet'] <> '') then
            AResponseInfo.CharSet:= ResultJson.S['CharSet'];

          if ResultJson.StringExists('ErrorMessage') then
            AResponseInfo.CustomHeaders.Values['errormessage']:=
              StringReplace(StringReplace(StringReplace(ResultJson.S[TAG_ErrorMessage], #13#10, ' ', [rfReplaceAll]), #13, ' ', [rfReplaceAll]), #10,' ', [rfReplaceAll])
          else begin
            if Assigned(Stream) then begin
              { content is in stream }
              Stream.Position := 0;
              AResponseInfo.FreeContentStream := true;
              AResponseInfo.ContentStream := Stream;
//              AResponseInfo.WriteContent;
            end
            else begin
              if ResultJson.ObjectExists('JsonOut') then begin
                if ResultJson.S[TAG_ContentType] = 'text/html' then
                  AResponseInfo.ContentText := ResultJson.O['JsonOut'].S['content']
                else
                  AResponseInfo.ContentText:= ResultJson.O['JsonOut'].AsString;
              end;
            end;
          end;
        finally
          RequestJson.Free;
          ResultJson.Free;
        end;
      end
      else begin
        AResponseInfo.ResponseNo:= 400; { "Bad Request" }
        AResponseInfo.CustomHeaders.Values['errormessage']:= 'Bad Request - Unknown URI command';
      end;
    end
    else begin
      AResponseInfo.ResponseNo:= 400; { "Bad Request" }
      AResponseInfo.CustomHeaders.Values['errormessage']:= 'Bad Request - Invalid URI';
    end;


  finally
    if ltDetail in Logger.LogMessageTypes then begin
      Logger.Log('', ltDetail);
      Logger.Log('HTTP Response >>>>', ltDetail);
      Logger.Log('  Code: ' + AResponseInfo.ResponseText, ltDetail);
      Logger.Log('  Content Type: ' + AResponseInfo.ContentType, ltDetail);
    end;
      if (AResponseInfo.CustomHeaders.Values['errormessage'] <> '') then begin
        if (AResponseInfo.ResponseNo = 404) and (Pos('Instance not found', AResponseInfo.CustomHeaders.Values['errormessage']) > 0) then begin
          Logger.Log('HTTP Response ' + IntToStr(AResponseInfo.ResponseNo)+
            ' message: ' + AResponseInfo.CustomHeaders.Values['errormessage'],ltDetail);

        end
        else begin
          Logger.Log('HTTP Response error ' + IntToStr(AResponseInfo.ResponseNo)+
            ' message: ' + AResponseInfo.CustomHeaders.Values['errormessage'],ltError);
        end;
      end;
      if ltDetail in Logger.LogMessageTypes then begin
         Log('  Execution Time: ' + FormatDateTime('hh:nn:ss', now-dt), ltDetail);
         Log('---------------------------------------------',ltDetail);
    end;
  end;
end;

procedure TModWebAPI.DoOnCommandMessage(aData: string; ctx: TJsonObject);
begin
  inherited;

end;

procedure TModWebAPI.DoOnCommandOther(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  if ARequestInfo.CommandType = hcOption then begin
    AResponseInfo.ResponseNo := VS1_HTTP_Success_Code;
    AResponseInfo.CustomHeaders.Values['Access-Control-Allow-Origin'] := '*';
    AResponseInfo.CustomHeaders.Values['Access-Control-Allow-Methods'] := 'GET, POST, OPTIONS';
    AResponseInfo.CustomHeaders.Values['Access-Control-Allow-Headers'] := 'accept, content-type, database, password, username';
    AResponseInfo.CustomHeaders.Values['Access-Control-Max-Age'] := '86400';
  end;
end;

procedure TModWebAPI.DoOnConnect(AContext: TIdContext);
begin
  Logger.Log('Http Server - On Connect', ltInfo);
  AContext.Data := JO;
  if UseSSL then begin
    if AContext.Binding.Port = DefaultSSLPort then
      TIdSSLIOHandlerSocketBase(AContext.Connection.IOHandler).passThrough:= false;
  end;
end;

procedure TModWebAPI.DoOnMessage(aClientId: integer; aData: string;
  ctx: TJsonObject);
begin
  inherited;

end;

procedure TModWebAPI.DoOnMessage(aClientId: integer; aData, ctx: TJsonObject);
begin
  inherited;

end;

procedure TModWebAPI.DoOnParseAuthentication(AContext: TIdContext;
  const AAuthType, AAuthData: String; var VUsername, VPassword: String;
  var VHandled: Boolean);
begin
  VHandled := false;
  if AContext.Data = nil then begin
    AContext.Data := jo;
  end;
  TJsonObject(AContext.Data).S['AuthType'] := AAuthType;
  if SameText(AAuthType, 'Bearer') then begin
    VHandled := true;
    TJsonObject(AContext.Data).S['AuthData'] := AAuthData;
  end;
  Logger.Log('Http Server - On Parse authentication', ltInfo);
end;

procedure TModWebAPI.DoOnRequest(aClientId: integer; aRequest, ctx,
  aResponse: TJsonObject);
var
  methodName: string;
  idx: integer;
begin
  if Terminated then
    Exit;
  methodName := Lowercase(aRequest.S[TAG_Method]);
  Log('Request: ' + methodName, ltDetail);
  try
    inherited;

    if ctx.B['Handled'] = True then
      Exit;

    idx:= Pos('.',methodName);
    if idx > 0 then
      methodName:= Copy(methodName, idx + 1, Length(methodName));

    if SameText(methodName,'GetConfig') then begin
      ObjToJson(self, aResponse.O['result']);
    end
    else if SameText(methodName,'SetConfig') then begin
      if aRequest.ObjectExists(TAG_CLOUD_Params) then begin
        JsonToObj(aRequest.O[TAG_CLOUD_Params],self);
//        self.SaveConfig(false);
        Self.SaveConfig;
        JsonRPCUtils.AddResultOk(aResponse);
      end
      else begin
        JsonRPCUtils.AddResultError(aResponse,'Params object missing from request',RPC_INVALID_PARAMS);
      end;
    end
    else begin
      AddResultError(aResponse,'Request method (' + methodName + ') not found',RPC_METHOD_NOT_FOUND);
    end;

  finally
    if Assigned(aResponse) then begin
      if aResponse.Exists('result') then
        Log('Result: ' + aResponse.ItemByName['result'].Value.AsString,ltDetail);
    end;
  end;
end;

procedure TModWebAPI.DoServerThreadException(AContext: TIdContext;
  AException: Exception);
begin
  if (pos('Connection Closed Gracefully.', AException.message)>=0) and (AException.ClassNameis('EIdConnClosedGracefully')) then
  else Logger.Log('Http Server Thread Exception - ' + AException.ClassName + ' with message: ' + AException.Message, ltError);
end;

procedure TModWebAPI.DoOnRequest(aClientId: integer; aRequest: string;
  ctx: TJsonObject; var aResponse: string);
begin
  inherited;

end;

procedure TModWebAPI.DoWork;
var
  ContextList: TList;
  ContextCount: Integer;
begin
  inherited;
  Sleep(500);

  if (not Started) and (Now >= fStartTime) then begin
    Started := True;
    HTTPServer.Active := Self.Active;
    Log('HTTP Server Started', ltInfo);
    fbstarted := True;
  end else if fbstarted = False then begin
    if not fbstarted then begin
      fidelctr := fidelctr + 1;
      Log(DupeString(' .', fidelctr), ltInfo);
    end;
  end;

  if (Now >= fNextCheckTime) then begin
    ContextList := HTTPServer.Contexts.LockList;
    try
      ContextCount := ContextList.Count;
    finally
      HTTPServer.Contexts.UnlockList;
    end;

    if ContextCount = 0 then begin
      try
        if (SystemLib.CurrentMemoryUsage / aMB) >= MemoryUsageLimit  then begin
          Log('Restarting Web API Module to reduce memory usage.', ltInfo);
          self.SendCommandMessage('RestartMe');
        end;
      finally
        fNextCheckTime := Now + ((1/24/60) * 5);
      end;
    end;
  end;
end;

function TModWebAPI.GetDefaultPort: Integer;
begin
  Result := fDefaultPortProp.AsInteger;
end;

function TModWebAPI.GetDefaultSSLPort: Integer;
begin
  Result := fDefaultSSLPortProp.AsInteger;
end;

function TModWebAPI.GetMaxConnections: integer;
begin
  Result := fMaxConnectionsProp.AsInteger;
end;

function TModWebAPI.GetModuleDescription: string;
begin
  result := 'Web server for ERP API';
end;

//function TModWebAPI.GetModuleVersion: string;
//begin
//  result := '11.0.0.0';
//end;

function TModWebAPI.GetUseSSL: boolean;
begin
  result := fUseSSLProp.AsBoolean;
end;

function TModWebAPI.GetWebUserName: string;
begin
  result := fWebUserNameProp.AsString;
end;

procedure TModWebAPI.LoadConfig;
begin
  inherited;
end;

procedure TModWebAPI.SaveConfig;
begin
  inherited;
end;

procedure TModWebAPI.SetActive(const Value: Boolean);
begin
  inherited;

  if Creating then exit;
  HttpServer.Active := Value;
end;

procedure TModWebAPI.SetDefaultPort(const Value: Integer);
begin
  fDefaultPortProp.AsInteger := Value;
end;

procedure TModWebAPI.SetDefaultSSLPort(const Value: Integer);
begin
  fDefaultSSLPortProp.AsInteger := Value;
end;

procedure TModWebAPI.SetMaxConnections(const Value: Integer);
begin
  fMaxConnectionsProp.AsInteger := Value;
end;

procedure TModWebAPI.SetUseSSL(const Value: Boolean);
begin
  fUseSSLProp.AsBoolean := Value;
end;

procedure TModWebAPI.SetWebUserName(const Value: string);
begin
  fWebUserNameProp.AsString := Value;
end;
(*procedure TModWebAPI.SSLIOHandlerOnGetPasswordEx(ASender: TObject; var VPassword: String; const AIsWrite: Boolean);
begin
  vPassword:= '1w$p&LD07';
end;
procedure TModWebAPI.SSLIOHandlerOnGetPassword(var Password: String);
begin
  Password:= '1w$p&LD07';
end;*)
(*procedure TModWebAPI.IdSSLIOHandlerSocketOpenSSL1Status(ASender: TObject;const AStatus: TIdStatus; const AStatusText: string);
begin
  Log('Status : ' + AStatusText,ltinfo);
end;*)
(*procedure TModWebAPI.HTTPServerBeforeBind(AHandle: TIdSocketHandle);
begin
  Log('Status : ' + 'HTTPServerBeforeBind',ltinfo);
end;
procedure TModWebAPI.HTTPServerConnect(AContext: TIdContext);
begin
  Log('Status : ' + 'HTTPServerConnect',ltinfo);
end;*)
procedure TModWebAPI.QuerySSLPort(APort: TIdPort; var VUseSSL: Boolean);
begin
    vUseSSL := UseSSL;
end;
(*procedure TModWebAPI.HTTPServerStatus(ASender: TObject; const AStatus: TIdStatus;const AStatusText: string);
begin
  Log('============================================= ' ,ltinfo);
       if AStatus = hsResolving     then Log('Status HTTPServerStatus : hsResolving'  ,ltinfo)
  else if AStatus = hsConnecting    then Log('Status HTTPServerStatus : hsConnecting'  ,ltinfo)
  else if AStatus = hsConnected     then Log('Status HTTPServerStatus : hsConnected'  ,ltinfo)
  else if AStatus = hsDisconnecting then Log('Status HTTPServerStatus : hsDisconnecting'  ,ltinfo)
  else if AStatus = hsDisconnected  then Log('Status HTTPServerStatus : hsDisconnected'  ,ltinfo)
  else if AStatus = hsStatusText  then Log('Status HTTPServerStatus : hsStatusText'  ,ltinfo)
  else Log('Status HTTPServerStatus : unknown'  ,ltinfo);
  Log('Status HTTPServerStatus : ' + AStatusText,ltinfo);
  Log('============================================= ' ,ltinfo);
end;*)
procedure TModWebAPI.HTTPServerQuerySSLPort(APort: Word;  var VUseSSL: Boolean);
begin
  inherited;
  Log('============================================= ' ,ltinfo);
  Log('Port : ' + inttostr(aport),ltinfo);
  (*if VUseSSL then Log('UseSSL : true',ltinfo) else begin
    Log('UseSSL : False',ltinfo);
    VUseSSL:= true;
  end;*)
  Log('============================================= ' ,ltinfo);

end;



procedure TModWebAPI.StartHttpServer;
var
  SSLIOHandler: TIdServerIOHandlerSSLOpenSSL;
  path: String;
begin
  try
    HTTPServer.Active := False;
    HTTPServer.Bindings.Clear;

    if UseSSL then begin
      HTTPServer.OnQuerySSLPort := QuerySSLPort;
      Log('Port : ' + IntToStr(Self.DefaultSSLPort), ltInfo);
      HTTPServer.Bindings.Add.Port := Self.DefaultSSLPort;
      HTTPServer.DefaultPort := Self.DefaultSSLPort;
      SSLIOHandler := TIdServerIOHandlerSSLOpenSSL.Create(HTTPServer);
      SSLIOHandler.Name := 'aSSLIOHandler';
      path := ExtractFilePath(Self.ModuleFileName);
      SSLIOHandler.SSLOptions.CertFile    := fsCertFile     ;//path + 'Certificate\localhost.cer';
      SSLIOHandler.SSLOptions.KeyFile     := fsKeyFile      ;//path + 'Certificate\localhost.key';
      SSLIOHandler.SSLOptions.RootCertFile:= fsRootCertFile ;//path + 'Certificate\localhost.cer';
      SSLIOHandler.SSLOptions.SSLVersions := [sslvSSLv3];
      SSLIOHandler.SSLOptions.Method      := sslvSSLv23;
      HTTPServer.IOHandler                := SSLIOHandler;
      Log('CertFile    :' + SSLIOHandler.SSLOptions.CertFile    , ltInfo);
      Log('KeyFile     :' + SSLIOHandler.SSLOptions.KeyFile     , ltInfo);
      Log('RootCertFile:' + SSLIOHandler.SSLOptions.RootCertFile, ltInfo);
    end
    else begin
      Log('Port : ' + IntToStr(Self.DefaultPort), ltInfo);
      HTTPServer.Bindings.Add.Port := Self.DefaultPort;
      if Assigned(HTTPServer.IOHandler) then begin
        HTTPServer.IOHandler.Free;
        HTTPServer.IOHandler := nil;
      end;
    end;
  except
    on e: exception do begin
      Log('Error starting Http Server: ' + e.Message, ltError);
    end;
  end;
end;

procedure TModWebAPI.LogEventHandler(Sender: TObject; const Event, Value: String);
begin
  inherited;
end;


{ TTempFileStream }

destructor TTempFileStream.Destroy;
begin
  TThread.CreateAnonymousThread(
    procedure
    var fn: string;
    begin
      fn := FileName;
      DeleteFile(fn);
    end
  );
  inherited;
end;

end.
