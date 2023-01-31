{ ***************************************************************************
  sgcWebSocket component

  written by eSeGeCe
  copyright © 2013
  Email : info@esegece.com
  Web : http://www.esegece.com
  *************************************************************************** }

unit sgcWebSocket_Server;

interface

{$I sgcVer.inc}

uses
  Classes, SysUtils, Contnrs, StrUtils,
{$IFNDEF MACOS} Windows, {$ENDIF}
  // indy
  IdContext, IdTCPConnection, IdTCPServer, IdGlobal, IdHeaderList,
  IdCustomHTTPServer, IdSocketHandle, IdSSLOpenSSL, IdSSL, IdCustomTCPServer,
  IdSchedulerOfThreadPool, IdGlobalProtocols,
  // websocket
  sgcWebSocket_Classes, sgcWebSocket_Types, sgcWebSocket_CustomServer,
  sgcWebSocket_Helpers;

type

  TsgcWSAuthenticationEvent = procedure(Connection: TsgcWSConnection; aUser,
      aPassword: String; var Authenticated: Boolean) of object;

  // TsgcWSHandShakeServer //

  TsgcWSHandShakeServer = class(TsgcWSHandshake)
    { fields }
  private
    FGet: String;
    FHost: string;
    FOrigin: string;
    FKey: string;
    FVersion: string;
  public
    property Get: string read FGet;
    property Host: string read FHost;
    property Origin: string read FOrigin;
    property Key: string read FKey;
    property Version: string read FVersion;
    { fields }

    { protocol }
  private
    function GetSpecification: TwsSpecification;
  protected
    property Specification: TwsSpecification read GetSpecification;
    { protocol }

    { decode }
  private
    procedure DoDecodeHeaders(const aConnection: TIdTCPConnection;
      aHeaders: TIdHeaderList);
    procedure DoDecodeConnection(const aHeader: String);
    procedure DoDecodeGET(const aHeader: String);
    procedure DoDecodeHost(const aHeader: String);
    procedure DoDecodeKey(const aHeader: String);
    procedure DoDecodeOrigin(const aHeader: String);
    procedure DoDecodeProtocols(const aHeader: String);
    procedure DoDecodeUpgrade(const aHeader: String);
    procedure DoDecodeVersion(const aHeader: String);
    procedure DoDecodeExtensions(const aHeader: String);
    { decode }

    { draft hixie76 }
  private
    FKey1: string;
    FKey2: string;
    FKey3: String;
    procedure DoDecodeKey1(const aHeader: String);
    procedure DoDecodeKey2(const aHeader: String);
    { draft hixie76 }

    { constructor }
  public
    constructor Create(aConnection: TIdTCPConnection; aHeaders: TIdHeaderList);
      override;
    { constructor }

  end;

  TsgcWSConnectionAuthentication = class(TPersistent)
  private
    FAuthenticated: Boolean;
    FPassword: String;
    FUser: String;
    FSessionID: string;
    function GetSessionID: string;
  public
    constructor Create;
  public
    property Authenticated: Boolean read FAuthenticated;
    property SessionID: string read GetSessionID;
    property Password: String read FPassword;
    property User: String read FUser;
  end;

  // TsgcWSConnectionServer //

  TsgcWSConnectionServer = class(TsgcWSConnection)

    { client properties }
  private
    function GetClientIP: string;
  public
    property ClientIP: string read GetClientIP;
    { client properties }

    { server properties }
  private
    FServerHost: String;
    FServerPort: Integer;
    FServerOriginsAllowed: String;
    FServerSSL: Boolean;
  public
    property ServerHost: String read FServerHost write FServerHost;
    property ServerOriginsAllowed
      : String read FServerOriginsAllowed write FServerOriginsAllowed;
    property ServerPort: Integer read FServerPort write FServerPort;
    property ServerSSL: Boolean read FServerSSL write FServerSSL;
    { server properties }

    { get protocol }
  private
    function DoGetProtocol: string;
    { get protocol }

    { handshake }
  private
    FHandshake: TsgcWSHandShakeServer;
    procedure DoHandShake_RFC6455;
    procedure DoHandShake_Hixie76;
  private
    procedure DoOriginsAllowed;
  protected
    procedure DoHandShakeSecurity; virtual;
    procedure DoHandShakeExtensions; virtual;
  protected
    procedure DoHandshake; override;
    { handshake }

    { authentication }
  private
    FAuthentication: TsgcWSConnectionAuthentication;
    FOnAuthentication: TsgcWSAuthenticationEvent;
  protected
    function GetAuthentication: TsgcWSConnectionAuthentication;
  protected
    procedure DoOnAuthenticationEvent; virtual;
  public
    property Authentication
      : TsgcWSConnectionAuthentication read GetAuthentication write
      FAuthentication;
  public
    property OnAuthentication
      : TsgcWSAuthenticationEvent read FOnAuthentication write
      FOnAuthentication;
  public

    { http }
  private
    procedure DoHTTPResponse(const aContent, aContentType: String);
    procedure DoHTTPError;
  private
    function DoHTTPFileResponse(const aFileName, aContentType: String;
      aDisconnect: Boolean): Boolean;
  private
    procedure DoAuthSessionResponse(const aParams: String);
  protected
    function DoAuthenticationURL(const aParams: STring): Boolean;
    { http }

    { destructor }
  public
    destructor Destroy; override;
    { destructor }
  end;


  TsgcWSOptionsServer = class(TPersistent)
  private
    FHTMLFiles: Boolean;
    FJavascriptFiles: Boolean;
    FValidateUTF8: Boolean;
  public
    constructor Create; virtual;
  public
    procedure Assign(aSource: TPersistent); override;
  published
    property HTMLFiles: Boolean read FHTMLFiles write FHTMLFiles;
    property JavascriptFiles: Boolean read FJavascriptFiles write FJavascriptFiles;
    property ValidateUTF8: Boolean read FValidateUTF8 write FValidateUTF8;
  end;

  // TsgcWSSecurity_Options //

  TsgcWSSecurity_Options = class(TPersistent)
  private
    FOriginsAllowed: String;
  public
    procedure Assign(aSource: TPersistent); override;
  published
    property OriginsAllowed: String read FOriginsAllowed write FOriginsAllowed;
  end;

  // TsgcWSSSL_Options //
  TsgcWSSSL_Options = class(TPersistent)
  private
    FCertFile: String;
    FKeyFile: String;
    FPassword: AnsiString;
    FPort: Integer;
    FRootCertFile: String;
  published
    property CertFile: String read FCertFile write FCertFile;
    property KeyFile: String read FKeyFile write FKeyFile;
    property Password: AnsiString read FPassword write FPassword;
    property Port: Integer read FPort write FPort;
    property RootCertFile: String read FRootCertFile write FRootCertFile;
  end;

  // TsgcWThreadPool_Options //
  TsgcWSThreadPool_Options = class(TPersistent)
  private
    FMaxThreads: Integer;
    FPoolSize: Integer;
  public
    procedure Assign(aSource: TPersistent); override;
  published
    property MaxThreads: Integer read FMaxThreads write FMaxThreads;
    property PoolSize: Integer read FPoolSize write FPoolSize;
  end;

// TsgcWSAuthenticationServer_Session //

  TsgcWSAuthenticationServer_Session = class(TsgcWSAuthentication_Session)

  end;

// TsgcWSAuthenticationServer_URL //

  TsgcWSAuthenticationServer_URL = class(TsgcWSAuthentication_URL)

  end;

  // TsgcWSAuthenticationServer_Options //
  TsgcWSAuthenticationServer_Options = class(TsgcWSAuthentication_Options)
  private
    FAuthUsers: TStringList;
    FURL: TsgcWSAuthenticationServer_URL;
    FSession: TsgcWSAuthenticationServer_Session;
  protected
    procedure SetAuthUsers(const Value: TStringList);
    procedure SetURL(const Value: TsgcWSAuthenticationServer_URL);
    procedure SetSession(const Value: TsgcWSAuthenticationServer_Session);
  public
    constructor Create; virtual;
    destructor Destroy; override;
  public
    procedure Assign(aSource: TPersistent); override;
  published
    property AuthUsers: TStringList read FAuthUsers write SetAuthUsers;
    property URL: TsgcWSAuthenticationServer_URL read FURL write SetURL;
    property Session: TsgcWSAuthenticationServer_Session read FSession write
        SetSession;
  end;


  // TsgcWSServer_Base //

  TsgcWSServer_Base = class(TsgcWSComponent_Server)

    { from TComponent }
  protected
    procedure Loaded; override;
    { from TComponent }

    { tcp server }
  protected
    function GetCustomServer: TIdCustomTCPServer; virtual; abstract;
  protected
    property CustomServer: TIdCustomTCPServer read GetCustomServer;
    { tcp server }

    { events }
  protected
    procedure OnClientUpdateEvent(aConnection: TsgcWSConnection;
      aType: Integer);
  protected
    procedure OnServerConnectEvent(AContext: TIdContext); virtual;
    procedure OnServerMessageEvent(Connection: TsgcWSConnection;
      const Text: string); virtual;
    procedure OnServerBinaryEvent(Connection: TsgcWSConnection;
      const aStream: TMemoryStream); virtual;
    procedure OnServerDisconnectEvent(AContext: TIdContext); virtual;
    procedure OnServerExecuteEvent(AContext: TIdContext); virtual; abstract;
  public
    { events }

    { properties fields }
  private
    FOptions: TsgcWSOptionsServer;
    FServerType: TwsServerType;
    FSecurityOptions: TsgcWSSecurity_Options;
    function GetMaxConnections: Integer;
    procedure SetMaxConnections(const Value: Integer);
    function GetBindings: TIdSocketHandles;
    function GetPort: Integer;
    procedure SetBindings(const Value: TIdSocketHandles);
    procedure SetPort(const Value: Integer);
    procedure SetSecurityOptions(const Value: TsgcWSSecurity_Options);
    procedure SetOptions(const Value: TsgcWSOptionsServer);
  public
    property Port: Integer read GetPort write SetPort;
    property Bindings: TIdSocketHandles read GetBindings write SetBindings;
    property MaxConnections: Integer read GetMaxConnections write
      SetMaxConnections;
    property Options: TsgcWSOptionsServer read FOptions write SetOptions;
    property SecurityOptions
      : TsgcWSSecurity_Options read FSecurityOptions
      write SetSecurityOptions;
    { properties fields }

    { SSL }
  private
    FSSL: Boolean;
    FSSLOptions: TsgcWSSSL_Options;
    FHandlerSSL: TIdServerIOHandlerSSLOpenSSL;
  protected
    function GetSSL: Boolean;
    procedure OnGetPasswordSSLEvent(var Password: AnsiString); virtual;
    procedure OnGetSSLPortEvent(aPort: Integer; var aSSL: Boolean); virtual;
    procedure SetSSL(const Value: Boolean); virtual;
    procedure SetSSLOptions(const Value: TsgcWSSSL_Options); virtual;
  public
    property SSLOptions: TsgcWSSSL_Options read FSSLOptions write SetSSLOptions;
    property SSL: Boolean read GetSSL write SetSSL default False;
    { SSL }

    { ThreadPoolOptions }
  private
    FThreadPool: Boolean;
    FThreadPoolOptions: TsgcWSThreadPool_Options;
    FSchedulerThreadPool: TIdSchedulerOfThreadPool;
  protected
    procedure SetThreadPoolOptions(const Value: TsgcWSThreadPool_Options);
      virtual;
    function GetThreadPool: Boolean; virtual;
    procedure SetThreadPool(const Value: Boolean); virtual;
  public
    property ThreadPoolOptions
      : TsgcWSThreadPool_Options read FThreadPoolOptions
      write SetThreadPoolOptions;
    property ThreadPool: Boolean read GetThreadPool write SetThreadPool;
    { ThreadPoolOptions }

    { authentication }
  private
    FOnAuthentication: TsgcWSAuthenticationEvent;
    FSessionIDList: TsgcDelimitedStringList;
    FAuthentication: TsgcWSAuthenticationServer_Options;
  protected
    function GetSessionIDList: TsgcDelimitedStringList;
    procedure DoAddSessionID(const aSessionID, aUser, aPassword: String);
    procedure DoDelSessionID(const aSessionID: String);
    function GetSessionID(const aSessionID: String): Boolean;
    function GetSessionUserPassword(const aSessionID: String; var User, Password:
        string): Boolean;
  protected
    procedure SetAuthentication(const Value: TsgcWSAuthenticationServer_Options);
  protected
    function DoAuthenticationSession(aConnection: TsgcWSConnectionServer; const
        aParams: String): Boolean;
  public
    procedure OnServerAuthenticationEvent(Connection: TsgcWSConnection; aUser,
        aPassword: String; var Authenticated: Boolean);
  public
    property Authentication: TsgcWSAuthenticationServer_Options read
        FAuthentication write SetAuthentication;
    { authentication }

    { built-in libraries}
  protected
    function DoBuiltInLibraries(aConnection: TsgcWSConnectionServer; const aText:
        String; aDisconnect: Boolean): Boolean;
    { built-in libraries}

    { connections }
  private
    FConnections: TList;
    function GetCount: Integer;
    function GetConnections(Index: Integer): TsgcWSConnectionServer;
  public
    property Connections[Index: Integer]
      : TsgcWSConnectionServer read GetConnections; default;
    property Count: Integer read GetCount;
    { connections }

    { enable / disable }
  private
    FActive: Boolean;
  private
    function GetActive: Boolean;
    procedure SetActive(const Value: Boolean);
  public
    property Active: Boolean read GetActive write SetActive default False;
    { enable / disable }

    { constructor / destructor }
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    { constructor / destructor }

    { broadcast }
  private
    procedure DoBroadCast(const aMessage: string; aStream: TMemoryStream;
      aOpCode: TOpCode; const aChannel: String = '';
      const aProtocol: string = ''; const Exclude: String = '';
      const Include: String = ''); overload;
  public
    procedure Broadcast(const aMessage: string; const aChannel: string = '';
      const aProtocol: string = ''; const Exclude: String = '';
      const Include: String = ''); override;
    procedure Broadcast(aStream: TMemoryStream; const aChannel: string = '';
      const aProtocol: string = ''; const Exclude: String = '';
      const Include: String = ''); override;
    { broadcast }

    { send }
  private
    function DoWriteData(const aGuid, aMessage: string): Boolean; overload;
    function DoWriteData(const aGuid: string; const aStream: TMemoryStream)
      : Boolean; overload;
  public
    function WriteData(const aGuid, aMessage: string): Boolean; override;
    function WriteData(const aGuid: String; aStream: TMemoryStream): Boolean;
      override;
    { send }

    { ping }
  public
    procedure Ping;
    { ping }

  public
    property OnAuthentication
      : TsgcWSAuthenticationEvent read FOnAuthentication write
      FOnAuthentication;
  end;




  // TsgcWSServer //

  TsgcWSServer = Class(TsgcWSServer_Base)
    { tcp server }
  private
    FTCPServer: TsgcWSCustomServer;
  private
    function GetTCPServer: TsgcWSCustomServer;
  protected
    property TCPServer: TsgcWSCustomServer read GetTCPServer;
    { tcp server }

    { from TsgcWSServer_Base }
  protected
    function GetCustomServer: TIdCustomTCPServer; override;
    procedure OnServerExecuteEvent(AContext: TIdContext); override;
    procedure OnServerDisconnectEvent(AContext: TIdContext); override;
    { from TsgcWSServer_Base }

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  End;



  // TsgcWSServerHTTP //

  TsgcWSHTTPServer = class(TsgcWSServer_Base)
    { server http }
  private
    FHTTPServer: TsgcWSHTTPCustomServer;
    function GetHTTPServer: TsgcWSHTTPCustomServer;
  protected
    property HTTPServer: TsgcWSHTTPCustomServer read GetHTTPServer;

    { server http }

    { events http }
  private
    FDocumentRoot: String;
    FOnCommandGet: TIdHTTPCommandEvent;
    FOnCommandOther: TIdHTTPCommandEvent;
    FOnSessionEnd: {$IFDEF INDY10_5_7} TIdHTTPSessionEndEvent
    {$ELSE} TOnSessionEndEvent {$ENDIF};
    FOnSessionStart: {$IFDEF INDY10_5_7} TIdHTTPSessionStartEvent
    {$ELSE} TOnSessionStartEvent {$ENDIF};
  protected
    procedure OnCommandGetEvent(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
      virtual;
    procedure OnCommandOtherEvent(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
      virtual;
    procedure OnSessionStartEvent(Sender: TIdHTTPSession); virtual;
    procedure OnSessionEndEvent(Sender: TIdHTTPSession); virtual;
    procedure OnExceptionEvent(AContext: TIdContext; AException: Exception);
      virtual;
  protected
    function DoResponseHTTP(aContext: TIdContext; aRequestInfo: TIdHTTPRequestInfo;
        aResponseInfo: TIdHTTPResponseInfo): Boolean; virtual;
  public
    property OnCommandGet
      : TIdHTTPCommandEvent read FOnCommandGet write FOnCommandGet;
    property OnCommandOther
      : TIdHTTPCommandEvent read FOnCommandOther write FOnCommandOther;
    property OnSessionEnd: {$IFDEF INDY10_5_7} TIdHTTPSessionEndEvent
    {$ELSE} TOnSessionEndEvent {$ENDIF} read FOnSessionEnd write FOnSessionEnd;
    property OnSessionStart: {$IFDEF INDY10_5_7} TIdHTTPSessionStartEvent
    {$ELSE} TOnSessionStartEvent
    {$ENDIF} read FOnSessionStart write FOnSessionStart;
    { events http }

    { properties http }
  private
    function GetAutoStartSession: Boolean;
    function GetDocumentRoot: String;
    function GetKeepAlive: Boolean;
    function GetSessionTimeOut: Integer;
    procedure SetAutoStartSession(const Value: Boolean);
    procedure SetKeepAlive(const Value: Boolean);
    procedure SetSessionTimeOut(const Value: Integer);
  public
    property AutoStartSession: Boolean read GetAutoStartSession write
      SetAutoStartSession;
    property DocumentRoot: String read GetDocumentRoot write FDocumentRoot;
    property KeepAlive: Boolean read GetKeepAlive write SetKeepAlive;
    property SessionTimeOut: Integer read GetSessionTimeOut write
      SetSessionTimeOut;

    { properties http }

    { from TsgcWSServer_Base }
  protected
    function GetCustomServer: TIdCustomTCPServer; override;
    procedure OnServerExecuteEvent(AContext: TIdContext); override;
    procedure OnServerDisconnectEvent(AContext: TIdContext); override;
    { from TsgcWSServer_Base }

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  End;

implementation

uses sgcWebSocket_CS, sgcWebSocket_HTTPResponse, sgcWebSocket_Const,
  sgcWebSocket_Protocol_Base_Server;

{ TsgcWSHandShakeServer }

constructor TsgcWSHandShakeServer.Create(aConnection: TIdTCPConnection;
  aHeaders: TIdHeaderList);
begin
  DoDecodeHeaders(aConnection, aHeaders);
end;

procedure TsgcWSHandShakeServer.DoDecodeConnection(const aHeader: String);
begin
  if not sgcMatchesMask(aHeader, '*Upgrade*') then
    raise TsgcWSException.Create(S_ERROR_DECODING_UPGRADE);
end;

procedure TsgcWSHandShakeServer.DoDecodeExtensions(const aHeader: String);
begin
  if sgcMatchesMask(aHeader, 'Sec-WebSocket-Extensions: *') then
    FExtensions := Copy(aHeader, 27, Length(aHeader) - 26);
end;

procedure TsgcWSHandShakeServer.DoDecodeGET(const aHeader: String);
var
  i: Integer;
  vVersion: String;
begin
  i := AnsiPos('HTTP', aHeader);
  if i <> -1 then
  begin
    vVersion := MidStr(aHeader, i + 5, Length(aHeader));
    if vVersion = '1.0' then
      raise TsgcWSException.Create(S_ERROR_DECODING_GET);
    FGet := MidStr(aHeader, 5, i - 6);
  end
  else
    raise TsgcWSException.Create(S_ERROR_DECODING_GET);
end;

procedure TsgcWSHandShakeServer.DoDecodeHeaders
  (const aConnection: TIdTCPConnection; aHeaders: TIdHeaderList);
var
  i: Integer;
  vText: String;
  vBytes: TIdBytes;
begin
  for i := 0 to aHeaders.Count - 1 do
  begin
    vText := aHeaders[i];

    if sgcMatchesMask(vText, 'GET /* HTTP/*') then
      DoDecodeGET(vText)
    else if sgcMatchesMask(vText, 'Upgrade: *') then
      DoDecodeUpgrade(vText)
    else if sgcMatchesMask(vText, 'Connection: *') then
      DoDecodeConnection(vText)
    else if sgcMatchesMask(vText, 'Host: *') then
      DoDecodeHost(vText)
    else if sgcMatchesMask(vText, 'Sec-WebSocket-Key: *') then
      DoDecodeKey(vText)
    else if sgcMatchesMask(vText, 'Origin: *') then
      DoDecodeOrigin(vText)
    else if sgcMatchesMask(vText, 'Sec-WebSocket-Protocol: *') then
      DoDecodeProtocols(vText)
    else if sgcMatchesMask(vText, 'Sec-WebSocket-Version: *') then
      DoDecodeVersion(vText)
    else if sgcMatchesMask(vText, 'Sec-WebSocket-Extensions: *') then
      DoDecodeExtensions(vText)
      // hixie
    else if sgcMatchesMask(vText, 'Sec-WebSocket-Key1: *') then
      DoDecodeKey1(vText)
    else if sgcMatchesMask(vText, 'Sec-WebSocket-Key2: *') then
      DoDecodeKey2(vText);
  end;

  if not aConnection.IOHandler.InputBufferIsEmpty then
  begin
    if (FKey1 <> '') and (FKey2 <> '') then
    begin
      aConnection.IOHandler.ReadBytes(vBytes, 8);
      FKey3 := IdGlobal.ToHex(vBytes);
    end;
  end;
end;

procedure TsgcWSHandShakeServer.DoDecodeHost(const aHeader: String);
begin
  if not sgcMatchesMask(aHeader, 'Host: *') then
    raise TsgcWSException.Create(S_ERROR_DECODING_HOST);
  FHost := Copy(aHeader, 7, Length(aHeader) - 6);
end;

procedure TsgcWSHandShakeServer.DoDecodeKey(const aHeader: String);
begin
  if not sgcMatchesMask(aHeader, 'Sec-WebSocket-Key: *') then
    raise TsgcWSException.Create(S_ERROR_DECODING_WEBSOCKET_KEY);
  FKey := Copy(aHeader, 20, Length(aHeader) - 19);
end;

procedure TsgcWSHandShakeServer.DoDecodeKey1(const aHeader: String);
begin
  if not sgcMatchesMask(aHeader, 'Sec-WebSocket-Key1: *') then
    raise TsgcWSException.Create(S_ERROR_DECODING_WEBSOCKET_KEY1);
  FKey1 := Copy(aHeader, 21, Length(aHeader) - 20);
end;

procedure TsgcWSHandShakeServer.DoDecodeKey2(const aHeader: String);
begin
  if not sgcMatchesMask(aHeader, 'Sec-WebSocket-Key2: *') then
    raise TsgcWSException.Create(S_ERROR_DECODING_WEBSOCKET_KEY2);
  FKey2 := Copy(aHeader, 21, Length(aHeader) - 20);
end;

procedure TsgcWSHandShakeServer.DoDecodeOrigin(const aHeader: String);
begin
  if not sgcMatchesMask(aHeader, 'Origin: *') then
    raise TsgcWSException.Create(S_ERROR_DECODING_ORIGIN);
  FOrigin := Copy(aHeader, 9, Length(aHeader) - 8);
end;

procedure TsgcWSHandShakeServer.DoDecodeProtocols(const aHeader: String);
begin
  if sgcMatchesMask(aHeader, 'Sec-WebSocket-Protocol: *') then
    FProtocols := Copy(aHeader, 25, Length(aHeader) - 24);
end;

procedure TsgcWSHandShakeServer.DoDecodeUpgrade(const aHeader: String);
begin
  if not sgcMatchesMask(aHeader, '*websocket') then
    raise TsgcWSException.Create(S_ERROR_DECODING_WEBSOCKET);
end;

procedure TsgcWSHandShakeServer.DoDecodeVersion(const aHeader: String);
begin
  if not sgcMatchesMask(aHeader, 'Sec-WebSocket-Version: *') then
    raise TsgcWSException.Create(S_ERROR_DECODING_WEBSOCKET_VERSION);
  FVersion := Copy(aHeader, 24, Length(aHeader) - 23);
end;

function TsgcWSHandShakeServer.GetSpecification: TwsSpecification;
begin
  Result := spRFC6455;
  if FKey1 <> '' then
    Result := spHixie76;
end;

destructor TsgcWSConnectionServer.Destroy;
begin
  FreeAndNil(FAuthentication);
  FreeAndNil(FHandshake);
  inherited;
end;

function TsgcWSConnectionServer.DoAuthenticationURL(const aParams: STring):
    Boolean;
var
  oParams: TsgcDelimitedStringList;
begin
  Result := False;

  oParams := TsgcDelimitedStringList.Create;
  Try
    oParams.Delimiter := '/';
    oParams.DelimitedText := aParams;
    if oParams.Count > 5 then
    begin
      // ... read authentication
      Authentication.FUser := oParams[4];
      Authentication.FPassword := oParams[5];
      // ... request authentication
      DoOnAuthenticationEvent;
      // ... result
      result := Authentication.Authenticated;
    end;
  Finally
    FreeAndNil(oParams);
  End;
end;

procedure TsgcWSConnectionServer.DoHandshake;
var
  i: Integer;
begin
  Assert(not Enabled);
  Try
    FHandshake := TsgcWSHandShakeServer.Create(TCPConnection, HeadersRequest);
    Specification := FHandshake.Specification;

    Protocol := DoGetProtocol;

    HeadersResponse.Clear;

    DoHandShakeSecurity;
    DoHandShakeExtensions;

    case Specification of
      spRFC6455:
        DoHandShake_RFC6455;
      spHixie76:
        DoHandShake_Hixie76;
    end;

    if Assigned(FOnHandshake) then
      FOnHandshake(self, FHeadersResponse);

    TCPConnection.IOHandler.WriteBufferOpen;
    Try
      for i := 0 to HeadersResponse.Count - 1 do
        TCPConnection.IOHandler.WriteLn(HeadersResponse[i]);
      TCPConnection.IOHandler.WriteLn;
      if FHandshake.Specification = spHixie76 then
        TCPConnection.IOHandler.write(FHandshake.GetWSAccept(FHandshake.FKey1,
            FHandshake.FKey2, FHandshake.FKey3));

      TCPConnection.IOHandler.WriteBufferFlush;
    Finally
      TCPConnection.IOHandler.WriteBufferClose;
    End;

    FEnabled := True;
    if Assigned(FOnUpdate) then
      FOnUpdate(self, 1);

  except
    on E: TsgcWSException do
    begin
      TCPConnection.Disconnect;
      TCPConnection.IOHandler.InputBuffer.Clear;
    end
    else
      raise;
  end;
end;

function TsgcWSConnectionServer.DoGetProtocol: string;
var
  i: Integer;
  oSProtocols, oCProtocols: TsgcDelimitedStringList;
begin
  if FHandshake.Protocols <> '' then
  begin
    oSProtocols := TsgcDelimitedStringList.Create;
    oCProtocols := TsgcDelimitedStringList.Create;
    Try
      oSProtocols.DelimitedText := Protocol;

      oCProtocols.DelimitedText := FHandshake.Protocols;

      for i := 0 to oCProtocols.Count - 1 do
      begin
        if oSProtocols.IndexOf(oCProtocols[i]) > -1 then
        begin
          Result := oCProtocols[i];
          break;
        end;
      end;

      if Result = '' then
        raise TsgcWSException.CreateFmt(S_PROTOCOL_UNSUPPORTED,
          [oCProtocols.Text]);

    Finally
      FreeAndNil(oCProtocols);
      FreeAndNil(oSProtocols);
    End;
  end;
end;

procedure TsgcWSConnectionServer.DoHandShakeExtensions;
begin
  Extensions.DecodeExtensions(FHandshake.Extensions);
end;

procedure TsgcWSConnectionServer.DoHandShakeSecurity;
begin
  if ServerOriginsAllowed <> '' then
    DoOriginsAllowed;
end;

procedure TsgcWSConnectionServer.DoHandShake_Hixie76;
begin
  HeadersResponse.Add('HTTP/1.1 101 WebSocket Protocol Handshake');
  HeadersResponse.Add('Upgrade: WebSocket');
  HeadersResponse.Add('Connection: Upgrade');
  HeadersResponse.Add('Sec-WebSocket-Origin: ' + FHandshake.Origin);
  HeadersResponse.Add('Sec-WebSocket-Location: ws://' + FHandshake.Host +
      FHandshake.Get);
  if Protocol <> '' then
    HeadersResponse.Add('Sec-WebSocket-Protocol: ' + Protocol)
  else
    HeadersResponse.Add('Sec-WebSocket-Protocol: *');
end;

procedure TsgcWSConnectionServer.DoHandShake_RFC6455;
begin
  HeadersResponse.Add('HTTP/1.1 101 Switching Protocols');
  HeadersResponse.Add('Upgrade: websocket');
  HeadersResponse.Add('Connection: Upgrade');
  if Protocol <> '' then
    HeadersResponse.Add('Sec-WebSocket-Protocol: ' + Protocol);
  HeadersResponse.Add('Sec-WebSocket-Accept: ' + FHandshake.GetWSAccept
      (FHandshake.Key));
  // ... extensions
  Extensions.WriteHeader(HeadersResponse);
end;

procedure TsgcWSConnectionServer.DoAuthSessionResponse(const aParams: String);
var
  oParams: TsgcDelimitedStringList;
begin
  oParams := TsgcDelimitedStringList.Create;
  Try
    oParams.Delimiter := '/';
    oParams.DelimitedText := aParams;
    if oParams.Count > 5 then
    begin
      // ... read authentication
      Authentication.FUser := oParams[5];
      if oParams.Count > 6 then
        Authentication.FPassword := oParams[6];
      // ... request authentication
      DoOnAuthenticationEvent;
      // ... authentication response
      if Authentication.Authenticated then
        DoHTTPResponse(
          Trim(Authentication.SessionID) + #13#10 +
          Trim(Extensions.List.Text) + #13#10 +
          Trim(Protocol)+ #13#10,
          'text/plain')
      else
        DoHTTPError;
    end;
  Finally
    FreeAndNil(oParams);
  End;
end;

procedure TsgcWSConnectionServer.DoHTTPError;
begin
  TCPConnection.IOHandler.WriteBufferOpen;
  Try
    TCPConnection.IOHandler.WriteLn('HTTP/1.1 404 Not Found');

    TCPConnection.IOHandler.WriteBufferFlush;
  Finally
    TCPConnection.IOHandler.WriteBufferClose;
  End;
end;

function TsgcWSConnectionServer.GetClientIP: string;
begin
  Result := TCPConnection.Socket.Binding.PeerIP;
end;

function TsgcWSConnectionServer.DoHTTPFileResponse(const aFileName,
  aContentType: String; aDisconnect: Boolean): Boolean;
var
{$IFDEF D2006}
  oResponse: TsgcWSHTTPResponse;
{$ENDIF}
  vText: String;
begin
  Result := False;
  // ... get file content
{$IFDEF D2006}
  oResponse := TsgcWSHTTPResponse.Create;
  Try
    vText := oResponse.GetResponseMessage(aFileName);
  Finally
    FreeAndNil(oResponse);
  End;
{$ELSE}
  vText := TsgcWSHTTPResponse.GetResponseMessage(aFileName);
{$ENDIF}
  // ... replace sys vars
  vText := StringReplace(vText, '{%host%}', ServerHost, [rfReplaceAll,
    rfIgnoreCase]);
  vText := StringReplace(vText, '{%port%}', IntToStr(ServerPort),
    [rfReplaceAll, rfIgnoreCase]);
  if ServerSSL then
    vText := StringReplace(vText, '{%ssl%}', 's',
      [rfReplaceAll, rfIgnoreCase])
  else
    vText := StringReplace(vText, '{%ssl%}', '',
      [rfReplaceAll, rfIgnoreCase]);

  // ... send http response
  if vText <> '' then
  begin
    DoHTTPResponse(vText, aContentType);
    TCPConnection.Disconnect(False); // close if get response
    Result := True;
  end
  else if aDisconnect then // send error if must disconnect
  begin
    DoHTTPError;
    TCPConnection.Disconnect(False);
    Result := True;
  end;
end;

procedure TsgcWSConnectionServer.DoHTTPResponse(const aContent,
  aContentType: String);
begin
  TCPConnection.IOHandler.WriteBufferOpen;
  Try
    TCPConnection.IOHandler.WriteLn('HTTP/1.1 200 OK');
    TCPConnection.IOHandler.WriteLn('Cache-Control: no-cache');
    TCPConnection.IOHandler.WriteLn('Content-Type: ' + aContentType);
    TCPConnection.IOHandler.WriteLn('Server: esegece.com');

    TCPConnection.IOHandler.WriteLn;

    TCPConnection.IOHandler.Write(aContent);

    TCPConnection.IOHandler.WriteBufferFlush;
  Finally
    TCPConnection.IOHandler.WriteBufferClose;
  End;
end;

procedure TsgcWSConnectionServer.DoOnAuthenticationEvent;
begin
  if Assigned(FOnAuthentication) then
    FOnAuthentication(self,
        Authentication.User,
        Authentication.Password,
        Authentication.FAuthenticated);
end;

procedure TsgcWSConnectionServer.DoOriginsAllowed;
var
  oList: TsgcDelimitedStringList;
  i: Integer;
begin
  if FHandshake.Origin <> '' then
  begin
    // ... find origin if allowed
    oList := TsgcDelimitedStringList.Create;
    Try
      oList.DelimitedText := ServerOriginsAllowed;
      for i := 0 to oList.Count - 1 do
      begin
        if sgcContainsText(FHandshake.Origin, oList[i]) then
          exit;
      end;
    Finally
      FreeAndNil(oList);
    End;

    // ... if not allowed raise exception
    raise TsgcWSException.CreateFmt(S_ORIGIN_NOT_ALLOWED,
      [FHandshake.Origin]);
  end;
end;

function TsgcWSConnectionServer.GetAuthentication
  : TsgcWSConnectionAuthentication;
begin
  if not Assigned(FAuthentication) then
    FAuthentication := TsgcWSConnectionAuthentication.Create;
  Result := FAuthentication;
end;

constructor TsgcWSServer_Base.Create(aOwner: TComponent);
begin
  inherited;
  Port := CS_DEFAULT_PORT;
  FConnections := TList.Create;
  FOptions := TsgcWSOptionsServer.Create;
  FSecurityOptions := TsgcWSSecurity_Options.Create;
  FSSLOptions := TsgcWSSSL_Options.Create;
  FThreadPoolOptions := TsgcWSThreadPool_Options.Create;
  FThreadPoolOptions.PoolSize := 32;
  FAuthentication := TsgcWSAuthenticationServer_Options.Create;
  FAuthentication.URL.Enabled := True;
  FAuthentication.Session.Enabled := True;
end;

{ TsgcWSServer_Base }

procedure TsgcWSServer_Base.OnServerMessageEvent
  (Connection: TsgcWSConnection; const Text: string);
begin
  if IsDestroying then
    exit;

  DoEnterCS;
  Try
    Try
      Connection.MsgReceived := Text;
      DoNotifyMessage(Connection);
    Except
      On E: Exception do
        DoError(Connection, E);
    end;
  Finally
    DoLeaveCS;
  End;
end;

destructor TsgcWSServer_Base.Destroy;
begin
  FreeAndNil(FAuthentication);
  FreeAndNil(FSessionIDList);
  FreeAndNil(FThreadPoolOptions);
  FreeAndNil(FSSLOptions);
  FreeAndNil(FSecurityOptions);
  FreeAndNil(FConnections);
  FreeAndNil(FOptions);
  inherited;
end;

procedure TsgcWSServer_Base.Broadcast(aStream: TMemoryStream;
  const aChannel: string = ''; const aProtocol: string = '';
  const Exclude: String = ''; const Include: String = '');
begin
  DoBroadCast('', aStream, opBinary, aChannel, aProtocol);
end;

procedure TsgcWSServer_Base.Broadcast(const aMessage: string;
  const aChannel: string = ''; const aProtocol: string = '';
  const Exclude: String = ''; const Include: String = '');
begin
  DoBroadCast(aMessage, nil, opText, aChannel, aProtocol);
end;

procedure TsgcWSServer_Base.DoAddSessionID(const aSessionID, aUser, aPassword:
    String);
begin
  DoEnterCS;
  Try
    if GetSessionIDList.IndexOfName(aSessionID) = -1 then
      GetSessionIDList.Add(aSessionID + '=' + aUser + ':' + aPassword);
  Finally
    DoLeaveCS;
  End;
end;

function TsgcWSServer_Base.DoAuthenticationSession(aConnection:
    TsgcWSConnectionServer; const aParams: String): Boolean;
var
  oParams: TsgcDelimitedStringList;
  vSessionID: String;
begin
  Result := False;

  oParams := TsgcDelimitedStringList.Create;
  Try
    oParams.Delimiter := '/';
    oParams.DelimitedText := aParams;
    if oParams.Count > 4 then
    begin
      // ... read authentication
      vSessionID := oParams[4];
      if vSessionID <> '' then
        Result := GetSessionID(vSessionID);
      if Result then
      begin
        // ... assign values to session fields
        aConnection.Authentication.FSessionID := vSessionID;
        GetSessionUserPassword(vSessionID,
          aConnection.Authentication.FUser,
          aConnection.Authentication.FPassword);
        // ... delete session id
        DoDelSessionID(vSessionID);
      end;
    end;
  Finally
    FreeAndNil(oParams);
  End;
end;

procedure TsgcWSServer_Base.DoBroadCast(const aMessage: string;
  aStream: TMemoryStream; aOpCode: TOpCode; const aChannel: String = '';
  const aProtocol: string = ''; const Exclude: String = '';
  const Include: String = '');

var
  i: Integer;
  oList: TList;
  oExclude: TsgcDelimitedStringList;
  oInclude: TsgcDelimitedStringList;
  vExclude, vInclude: Boolean;
  oConnection: TsgcWSConnectionServer;
begin
  oConnection := nil;

  oExclude := nil;
  oInclude := nil;

  DoEnterCS;

  // ... exclude list
  if Exclude <> '' then
  begin
    oExclude := TsgcDelimitedStringList.Create;
    oExclude.DelimitedText := Exclude;
  end;
  // ... include list
  if Include <> '' then
  begin
    oInclude := TsgcDelimitedStringList.Create;
    oInclude.DelimitedText := Exclude;
  end;
  // ... broadcast
  Try
    oList := CustomServer.Contexts.LockList;
    Try
      for i := 0 to oList.Count - 1 do
      begin
        Try
          oConnection := TsgcWSConnectionServer(TIdContext(oList[i]).Data);
          if Assigned(oConnection) then
          begin
            if oConnection.Enabled then
            begin
              // ... exclude
              vExclude := False;
              if Exclude <> '' then
                vExclude := oExclude.IndexOf(oConnection.Guid) <> -1;
              // ... include
              vInclude := True;
              if Include <> '' then
                vInclude := oInclude.IndexOf(oConnection.Guid) <> -1;
              // ... broadcast
              if not vExclude then
              begin
                if (aProtocol = '') or (UpperCase(oConnection.Protocol)
                    = UpperCase(aProtocol)) or (vInclude = True) then
                begin
                  case aOpCode of
                    opText:
                      if oConnection.Subscribed(aChannel) then
                        oConnection.WriteData(aMessage);
                    opBinary:
                      if oConnection.Subscribed(aChannel) then
                        oConnection.WriteData(aStream);
                    opPing:
                      oConnection.Ping(aMessage);
                  end;
                end;
              end;
            end;
          end;
        Except
          On E: Exception do
            DoError(oConnection, E);
        end;
      end;
    Finally
      CustomServer.Contexts.UnlockList;
    End;
  Finally
    FreeAndNil(oExclude);
    FreeAndNil(oInclude);
    DoLeaveCS;
  End;
end;

procedure TsgcWSServer_Base.DoDelSessionID(const aSessionID: String);
var
  vId: Integer;
begin
  DoEnterCS;
  Try
    vId := GetSessionIDList.IndexOfName(aSessionID);
    if vId > -1 then
      GetSessionIDList.Delete(vId);
  Finally
    DoLeaveCS;
  End;
end;

function TsgcWSServer_Base.DoBuiltInLibraries(aConnection:
    TsgcWSConnectionServer; const aText: String; aDisconnect: Boolean): Boolean;
begin
  Result := False;
    // ... javascript request
  if sgcMatchesMask(aText, 'GET *.js *') then
  begin
    if Options.JavascriptFiles then
      Result := aConnection.DoHTTPFileResponse(DecodeGETFileName(aText), 'text/javascript',
        aDisconnect);
  end
    // ... html request
  else if sgcMatchesMask(aText, 'GET *.html *') then
  begin
    if Options.HTMLFiles then
      Result := aConnection.DoHTTPFileResponse(DecodeGETFileName(aText), 'text/html',
        aDisconnect);
  end
    // ... favicon request
  else if sgcMatchesMask(aText, 'GET *favicon*') then
  begin
    if aDisconnect then
      Result := True;
  end;
end;

function TsgcWSServer_Base.DoWriteData(const aGuid, aMessage: string)
  : Boolean;
var
  i: Integer;
  oList: TList;
  oConnection: TsgcWSConnectionServer;
begin
  Result := False;
  oConnection := nil;

  DoEnterCS;
  Try
    oList := CustomServer.Contexts.LockList;
    Try
      for i := 0 to oList.Count - 1 do
      begin
        Try
          oConnection := TsgcWSConnectionServer(TIdContext(oList[i]).Data);
          if Assigned(oConnection) then
          begin
            if oConnection.Guid = aGuid then
            begin
              if oConnection.Enabled then
              begin
                oConnection.WriteData(aMessage);
                Result := True;
              end;
              break;
            end;
          end;
        Except
          On E: Exception do
            DoError(oConnection, E);
        end;
      end;
    Finally
      CustomServer.Contexts.UnlockList;
    End;
  Finally
    DoLeaveCS;
  End;
end;

function TsgcWSServer_Base.DoWriteData(const aGuid: string;
  const aStream: TMemoryStream): Boolean;
var
  i: Integer;
  oList: TList;
  oConnection: TsgcWSConnectionServer;
begin
  Result := False;
  oConnection := nil;

  DoEnterCS;
  Try
    oList := CustomServer.Contexts.LockList;
    Try
      for i := 0 to oList.Count - 1 do
      begin
        Try
          oConnection := TsgcWSConnectionServer(TIdContext(oList[i]).Data);
          if Assigned(oConnection) then
          begin
            if oConnection.Guid = aGuid then
            begin
              if oConnection.Enabled then
              begin
                oConnection.WriteData(aStream);
                Result := True;
              end;
              break;
            end;
          end;
        Except
          On E: Exception do
            DoError(oConnection, E);
        end;
      end;
    Finally
      CustomServer.Contexts.UnlockList;
    End;
  Finally
    DoLeaveCS;
  End;
end;

function TsgcWSServer_Base.GetActive: Boolean;
begin
  if not IsDesigning and not IsLoading then
    Result := CustomServer.Active
  else
    Result := FActive;
end;

function TsgcWSServer_Base.GetSessionID(const aSessionID: String): Boolean;
begin
  DoEnterCS;
  Try
    Result := GetSessionIDList.IndexOfName(aSessionID) <> -1;
  Finally
    DoLeaveCS;
  End;
end;

function TsgcWSServer_Base.GetSessionIDList: TsgcDelimitedStringList;
begin
  if not Assigned(FSessionIDList) then
    FSessionIDList := TsgcDelimitedStringList.Create;
  Result := FSessionIDList;
end;

function TsgcWSServer_Base.GetBindings: TIdSocketHandles;
begin
  Result := CustomServer.Bindings;
end;

function TsgcWSServer_Base.GetConnections(Index: Integer)
  : TsgcWSConnectionServer;
var
  oList: TList;
begin
  Result := nil;

  DoEnterCS;
  Try
    oList := CustomServer.Contexts.LockList;
    Try
      if Index < oList.Count then
        Result := TsgcWSConnectionServer(TIdContext(oList[Index]).Data);
    Finally
      CustomServer.Contexts.UnlockList;
    End;
  Finally
    DoLeaveCS;
  End;
end;

function TsgcWSServer_Base.GetCount: Integer;
var
  oList: TList;
begin
  DoEnterCS;
  Try
    oList := CustomServer.Contexts.LockList;
    Try
      Result := oList.Count;
    Finally
      CustomServer.Contexts.UnlockList;
    End;
  Finally
    DoLeaveCS;
  End;
end;

function TsgcWSServer_Base.GetMaxConnections: Integer;
begin
  Result := CustomServer.MaxConnections;
end;

function TsgcWSServer_Base.GetPort: Integer;
begin
  Result := CustomServer.DefaultPort;
end;

function TsgcWSServer_Base.GetSessionUserPassword(const aSessionID: String; var
    User, Password: string): Boolean;
var
  oList: TsgcDelimitedStringList;
begin
  result := False;

  DoEnterCS;
  Try
    oList := TsgcDelimitedStringList.Create;
    Try
      oList.Delimiter := ':';
      oList.DelimitedText := GetSessionIDList.Values[aSessionID];
      if oList.Count > 0 then
      begin
        User := oList[0];
        result := True;
      end;
      if oList.Count > 1 then
        Password := MidStr(oList.DelimitedText, Length(User) + 2, Length(oList.DelimitedText));
    Finally
      FreeAndNil(oList);
    End;
  Finally
    DoLeaveCS;
  End;
end;

function TsgcWSServer_Base.GetSSL: Boolean;
begin
  if not IsLoading and not IsDesigning then
    Result := GetCustomServer.IOHandler is TIdServerIOHandlerSSLOpenSSL
  else
    Result := FSSL;
end;

function TsgcWSServer_Base.GetThreadPool: Boolean;
begin
  if not IsLoading and not IsDesigning then
    Result := GetCustomServer.Scheduler is TIdSchedulerOfThreadPool
  else
    Result := FThreadPool;
end;

procedure TsgcWSServer_Base.Loaded;
begin
  inherited;
  if SSL <> FSSL then
    SSL := FSSL;
  if ThreadPool <> FThreadPool then
    ThreadPool := FThreadPool;
  if Active <> FActive then
    Active := FActive;
end;

procedure TsgcWSServer_Base.SetActive(const Value: Boolean);
begin
  if not IsLoading and not IsDesigning then
  begin
    CustomServer.DefaultPort := Port;
    CustomServer.Active := Value;
  end
  else
    FActive := Value;
end;

procedure TsgcWSServer_Base.OnServerConnectEvent(AContext: TIdContext);
var
  oConnection: TsgcWSConnectionServer;
begin
  if IsDestroying then
    exit;

  oConnection := nil;

  DoEnterCS;
  Try
    Try
      oConnection := TsgcWSConnectionServer.Create;
      oConnection.ServerHost := AContext.Connection.Socket.Binding.IP;
      oConnection.ServerPort := AContext.Connection.Socket.Binding.Port;
      oConnection.ServerSSL := SSL;
      oConnection.ServerOriginsAllowed := SecurityOptions.OriginsAllowed;
      oConnection.ValidateUTF8 := Options.ValidateUTF8;
      oConnection.Extensions := Extensions;
      oConnection.Masked := False;
      oConnection.Protocol := GetProtocols;
      oConnection.TCPConnection := AContext.Connection;
      oConnection.OnMessage := OnServerMessageEvent;
      oConnection.OnBinary := OnServerBinaryEvent;
      oConnection.OnUpdate := OnClientUpdateEvent;
      oConnection.OnHandshake := OnHandshake;;
      if Authentication.Enabled then
        oConnection.OnAuthentication := OnServerAuthenticationEvent;
      AContext.Data := oConnection;

    Except
      On E: Exception do
        DoError(oConnection, E);
    end;
  Finally
    DoLeaveCS;
  End;
end;

procedure TsgcWSServer_Base.OnClientUpdateEvent(aConnection: TsgcWSConnection;
    aType: Integer);
var
  i: Integer;
  oList: TList;
  oConnection: TsgcWSConnectionServer;
begin
  DoEnterCS;
  Try
    oList := CustomServer.Contexts.LockList;
    for i := 0 to oList.Count - 1 do
    begin
      oConnection := TsgcWSConnectionServer(TIdContext(oList[i]).Data);
      if oConnection.Guid = TsgcWSConnectionServer(aConnection).Guid then
      begin
        Case aType of
        // ... open connection
           1: begin
                case oConnection.Specification of
                  spRFC6455:
                    if not Specifications.RFC6455 then
                      TIdContext(oList[i]).Connection.Disconnect;
                  spHixie76:
                    if not Specifications.Drafts.Hixie76 then
                      TIdContext(oList[i]).Connection.Disconnect;
                end;
                // ... notify websocket connection
                if oConnection.FEnabled then
                  DoNotifyConnect(oConnection);
              end;
        // ... close connection
          -1: // nothing
        End;
        break;
      end;
    end;
    CustomServer.Contexts.UnlockList;
  Finally
    DoLeaveCS;
  End;
end;

procedure TsgcWSServer_Base.OnGetPasswordSSLEvent(var Password: AnsiString);
begin
  Password := SSLOptions.Password;
end;

procedure TsgcWSServer_Base.OnServerBinaryEvent(Connection: TsgcWSConnection;
    const aStream: TMemoryStream);
begin
  if IsDestroying then exit;

  DoEnterCS;
  Try
    Try
      Connection.MsgBinaryReceived.LoadFromStream(aStream);
      DoNotifyBinary(Connection);
    Except
      On E: Exception do
        DoError(Connection, E);
    end;
  Finally
    DoLeaveCS;
  End;
end;

procedure TsgcWSServer_Base.OnServerDisconnectEvent
  (AContext: TIdContext);
var
  oConnection: TsgcWSConnectionServer;
begin
  oConnection := nil;

  if Assigned(AContext.Data) then
  begin
    DoEnterCS;
    Try
      Try
        oConnection := AContext.Data as TsgcWSConnectionServer;

        // ... notify ONLY websocket connections
        if Assigned(oConnection) then
        begin
          if Assigned(oConnection.FHandshake) then
          begin
            if IsDestroying then // ... free connection on destroy
            begin
              oConnection.Free;
              AContext.Data := nil;
              exit;
            end
            else
              DoNotifyDisconnect(oConnection);
          end;
        end;
      Except
        On E: Exception do
          DoError(oConnection, E);
      end;
    Finally
      DoLeaveCS;
    End;
  end;
end;

procedure TsgcWSServer_Base.OnGetSSLPortEvent(aPort: Integer;
  var aSSL: Boolean);
begin
  if (SSLOptions.Port = 0) or (SSLOptions.Port = aPort) then
    aSSL := True;
end;

procedure TsgcWSServer_Base.OnServerAuthenticationEvent(Connection:
    TsgcWSConnection; aUser, aPassword: String; var Authenticated: Boolean);
begin
  // ... authlist
  if Authentication.AuthUsers.Count > 0 then
    if Authentication.AuthUsers.IndexOfName(aUser) <> -1 then
      if Authentication.AuthUsers.Values[aUser] = aPassword then
        Authenticated := True;

  // ... event
  if Assigned(FOnAuthentication) then
    FOnAuthentication(Connection, aUser, aPassword, Authenticated);

  // ... save session if authenticated
  if Authenticated then
    DoAddSessionID(TsgcWSConnectionServer(Connection).Authentication.SessionID,
      aUser, aPassword);
end;

procedure TsgcWSServer_Base.Ping;
begin
  DoBroadCast(FormatDateTime('yyyymmddhhnnsszzz', Now), nil, opPing);
end;

procedure TsgcWSServer_Base.SetAuthentication(const Value:
    TsgcWSAuthenticationServer_Options);
begin
  FAuthentication.Assign(Value);
end;

procedure TsgcWSServer_Base.SetBindings(const Value: TIdSocketHandles);
begin
  CustomServer.Bindings := Value;
end;

procedure TsgcWSServer_Base.SetSecurityOptions
  (const Value: TsgcWSSecurity_Options);
begin
  FSecurityOptions.Assign(Value);
end;

procedure TsgcWSServer_Base.SetMaxConnections(const Value: Integer);
begin
  CustomServer.MaxConnections := Value;
end;

procedure TsgcWSServer_Base.SetOptions(const Value: TsgcWSOptionsServer);
begin
  FOptions.Assign(Value);
end;

procedure TsgcWSServer_Base.SetPort(const Value: Integer);
begin
  CustomServer.DefaultPort := Value;
end;

procedure TsgcWSServer_Base.SetSSL(const Value: Boolean);
begin
  FSSL := Value;

  if IsLoading then
    exit;

  if FSSL then
  begin
    if IsDesigning then
      Port := 443
    else
    begin
      if not Assigned(FHandlerSSL) then
      begin
        FHandlerSSL := TIdServerIOHandlerSSLOpenSSL.Create(self);
        FHandlerSSL.OnGetPassword := OnGetPasswordSSLEvent;
        GetCustomServer.IOHandler := FHandlerSSL;
      end;
      FHandlerSSL.SSLOptions.Method := sslvSSLv23;
      FHandlerSSL.SSLOptions.Mode := sslmServer;
      FHandlerSSL.SSLOptions.CertFile := SSLOptions.CertFile;
      FHandlerSSL.SSLOptions.KeyFile := SSLOptions.KeyFile;
      FHandlerSSL.SSLOptions.RootCertFile := SSLOptions.RootCertFile;
    end;
  end
  else
  begin
    if not IsDesigning then
    begin
      if Assigned(FHandlerSSL) then
      begin
        GetCustomServer.IOHandler := nil;
        FreeAndNil(FHandlerSSL);
      end;
    end;
  end;
end;

procedure TsgcWSServer_Base.SetSSLOptions
  (const Value: TsgcWSSSL_Options);
begin
  FSSLOptions.Assign(Value);
end;

procedure TsgcWSServer_Base.SetThreadPool(const Value: Boolean);
begin
  FThreadPool := Value;

  if IsLoading then
    exit;

  if FThreadPool then
  begin
    if not IsDesigning then
    begin
      if not Assigned(FSchedulerThreadPool) then
      begin
        FSchedulerThreadPool := TIdSchedulerOfThreadPool.Create(self);
        GetCustomServer.Scheduler := FSchedulerThreadPool;
      end;
      FSchedulerThreadPool.MaxThreads := ThreadPoolOptions.MaxThreads;
      FSchedulerThreadPool.PoolSize := ThreadPoolOptions.PoolSize;
    end;
  end
  else
  begin
    if not IsDesigning then
    begin
      if Assigned(FSchedulerThreadPool) then
      begin
        GetCustomServer.Scheduler := nil;
        FreeAndNil(FSchedulerThreadPool);
      end;
    end;
  end;
end;

procedure TsgcWSServer_Base.SetThreadPoolOptions
  (const Value: TsgcWSThreadPool_Options);
begin
  FThreadPoolOptions.Assign(Value);
end;

function TsgcWSServer_Base.WriteData(const aGuid, aMessage: string)
  : Boolean;
begin
  Result := DoWriteData(aGuid, aMessage);
end;

function TsgcWSServer_Base.WriteData(const aGuid: String;
  aStream: TMemoryStream): Boolean;
begin
  Result := DoWriteData(aGuid, aStream);
end;

constructor TsgcWSServer.Create(aOwner: TComponent);
begin
  inherited;
  FServerType := wsTCP;
end;

destructor TsgcWSServer.Destroy;
begin
  if Assigned(FTCPServer) then
  begin
    if FTCPServer.Active then
    begin
      Try
        FTCPServer.Active := False;
        FTCPServer.Bindings.Clear;
      Finally
        FreeAndNil(FTCPServer);
      End;
    end;
  end;
  inherited;
end;

function TsgcWSServer.GetCustomServer: TIdCustomTCPServer;
begin
  if not Assigned(FTCPServer) then
  begin
    FTCPServer := TsgcWSCustomServer.Create(nil);
    FTCPServer.DefaultPort := Port;

    // Events
    FTCPServer.OnConnect := OnServerConnectEvent;
    FTCPServer.OnDisconnect := OnServerDisconnectEvent;
    FTCPServer.OnExecute := OnServerExecuteEvent;
    FTCPServer.OnQuerySSLPort := OnGetSSLPortEvent;
  end;

  Result := FTCPServer;
end;

function TsgcWSServer.GetTCPServer: TsgcWSCustomServer;
begin
  Result := CustomServer as TsgcWSCustomServer;
end;

procedure TsgcWSServer.OnServerDisconnectEvent(AContext: TIdContext);
begin
  inherited;
  AContext.Data := nil;
end;

procedure TsgcWSServer.OnServerExecuteEvent(AContext: TIdContext);
var
  oConnection: TsgcWSConnectionServer;
begin
  if IsDestroying then
    exit;

  if AContext.Connection.IOHandler.InputBufferIsEmpty then
    AContext.Connection.IOHandler.CheckForDataOnSource(10);

  if AContext.Connection.IOHandler.InputBuffer.Size > 0 then
  begin
    oConnection := TsgcWSConnectionServer(AContext.Data);
    With oConnection do
    begin
      DoEnterCS;
      Try
        Try
          if not Assigned(oConnection) or not oConnection.Enabled then
          begin
            // ... capture headers
            HeadersRequest.Clear;
            TCPConnection.IOHandler.Capture(HeadersRequest, '');

            // ... response authentication
            if IsRequestAuthenticationSessionHeader(HeadersRequest) then
            begin
              if self.Authentication.Enabled and Self.Authentication.Session.Enabled then
                DoAuthSessionResponse(DecodeGETFullPath(HeadersRequest));
              // ... free connection
              AContext.Data := nil;
              FreeAndNil(oConnection);
              DoLeaveCS;
              exit;
            end
            // ... built-in libraries
            else if DoBuiltInLibraries(oConnection, DecodeGETHeader(HeadersRequest), True) then
            begin
              AContext.Data := nil;
              FreeAndNil(oConnection);
              DoLeaveCS;
              exit;
            end
          end;
          // ... authenticate websocket
          if self.Authentication.Enabled then
          begin
            if not Authentication.Authenticated then
            begin
              // ... authenticate url
              if IsAuthenticationURLHeader(HeadersRequest) then
              begin
                if self.Authentication.URL.Enabled then
                  DoAuthenticationURL(DecodeGetFullPath(HeadersRequest));
              end
              // ... authenticate http
              else if IsAuthenticationSessionHeader(HeadersRequest) then
              begin
                if self.Authentication.Session.Enabled then
                  Authentication.FAuthenticated :=
                    DoAuthenticationSession(oConnection, DecodeGetFullPath(HeadersRequest));
              end;
              // ... if not authenticated then close
              if not Authentication.Authenticated then
              begin
                AContext.Data := nil;
                FreeAndNil(oConnection);
                DoLeaveCS;
                exit;
              end;
            end;
          end;
          // ... read data
          ReadData(True);
        Except
          On E: Exception do
            DoError(TsgcWSConnectionServer(AContext.Data), E);
        end;
      Finally
        DoLeaveCS;
      End;
    end;
  end
  else
    sleep(10);
end;

constructor TsgcWSHTTPServer.Create(aOwner: TComponent);
begin
  inherited;
  FServerType := wsHTTP;
end;

destructor TsgcWSHTTPServer.Destroy;
begin
  if Assigned(FHTTPServer) then
  begin
    if FHTTPServer.Active then
    begin
      FHTTPServer.Active := False;
      FHTTPServer.Bindings.Clear;
    end;
    FreeAndNil(FHTTPServer);
  end;
  inherited;
end;

function TsgcWSHTTPServer.DoResponseHTTP(aContext: TIdContext; aRequestInfo:
    TIdHTTPRequestInfo; aResponseInfo: TIdHTTPResponseInfo): Boolean;
var
  vDocument: String;
begin
  result := False;

  if DocumentRoot <> '' then
  begin
    vDocument := DocumentRoot + aRequestInfo.Document;
    if FileExists(vDocument) then
    begin
      aResponseInfo.ContentType := GetMIMETypeFromFile(vDocument);
      aResponseInfo.ServeFile(AContext, vDocument);
      result := True;
    end;
  end;
end;

function TsgcWSHTTPServer.GetAutoStartSession: Boolean;
begin
  Result := GetHTTPServer.AutoStartSession;
end;

function TsgcWSHTTPServer.GetCustomServer: TIdCustomTCPServer;
begin
  if not Assigned(FHTTPServer) then
  begin
    FHTTPServer := TsgcWSHTTPCustomServer.Create(nil);
    FHTTPServer.DefaultPort := Port;

    // Events
    FHTTPServer.OnConnect := OnServerConnectEvent;
    FHTTPServer.OnDisconnect := OnServerDisconnectEvent;
    FHTTPServer.OnExecute := OnServerExecuteEvent;
    FHTTPServer.OnQuerySSLPort := OnGetSSLPortEvent;

    // Events HTTP
    FHTTPServer.OnCommandGet := OnCommandGetEvent;
    FHTTPServer.OnCommandOther := OnCommandOtherEvent;
    FHTTPServer.OnSessionStart := OnSessionStartEvent;
    FHTTPServer.OnSessionEnd := OnSessionEndEvent;
    FHTTPServer.OnException := OnExceptionEvent;
  end;

  Result := FHTTPServer;

end;

function TsgcWSHTTPServer.GetDocumentRoot: String;
begin
  if RightStr(FDocumentRoot, 1) = '/' then
    FDocumentRoot := MidStr(FDocumentRoot, 1, Length(FDocumentRoot) - 1);
  Result := FDocumentRoot;
end;

function TsgcWSHTTPServer.GetHTTPServer: TsgcWSHTTPCustomServer;
begin
  Result := CustomServer as TsgcWSHTTPCustomServer;
end;

function TsgcWSHTTPServer.GetKeepAlive: Boolean;
begin
  Result := GetHTTPServer.KeepAlive;
end;

function TsgcWSHTTPServer.GetSessionTimeOut: Integer;
begin
  Result := GetHTTPServer.SessionTimeOut;
end;

procedure TsgcWSHTTPServer.OnCommandGetEvent(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  if not DoResponseHTTP(aContext, aRequestInfo, aResponseInfo) then
    if Assigned(FOnCommandGet) then
      FOnCommandGet(AContext, ARequestInfo, AResponseInfo);
end;

procedure TsgcWSHTTPServer.OnCommandOtherEvent(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  if Assigned(FOnCommandOther) then
    FOnCommandOther(AContext, ARequestInfo, AResponseInfo);
end;

procedure TsgcWSHTTPServer.OnExceptionEvent(AContext: TIdContext;
  AException: Exception);
begin
  DoException(TsgcWSConnection(AContext.Data), AException);
end;

procedure TsgcWSHTTPServer.OnServerDisconnectEvent
  (AContext: TIdContext);
var
  oConnection: TsgcWSConnectionServer;
begin
  inherited;
  if Assigned(AContext.Data) then
  begin
    oConnection := AContext.Data as TsgcWSConnectionServer;
    if Assigned(oConnection) then
    begin
      if not oConnection.Enabled then
        FreeAndNil(oConnection);
    end;

    AContext.Data := nil;
  end;
end;

procedure TsgcWSHTTPServer.OnServerExecuteEvent(AContext: TIdContext);
var
  oConnection: TsgcWSConnectionServer;
begin
  if IsDestroying then
    exit;

  if AContext.Connection.IOHandler.InputBufferIsEmpty then
    AContext.Connection.IOHandler.CheckForDataOnSource(10);

  if AContext.Connection.IOHandler.InputBuffer.Size > 0 then
  begin
    oConnection := TsgcWSConnectionServer(AContext.Data);

    // ssl open connection
    if not oConnection.Enabled then
      if SSL then
        if AContext.Connection.IOHandler.InputBuffer.Size = 1 then
          exit;

    With oConnection do
    begin
      DoEnterCS;
      Try
        Try
          if not Enabled then
          begin
            // ... capture headers
            HeadersRequest.Clear;
            HeadersRequest.Text :=
              AContext.Connection.IOHandler.InputBuffer.AsString;

            if IsWebSocketHeader(HeadersRequest) then
            begin
              // ... authentication
              if self.Authentication.Enabled then
              begin
                // ... authenticate URL
                if IsAuthenticationURLHeader(HeadersRequest) then
                begin
                  if self.Authentication.URL.Enabled then
                    DoAuthenticationURL(DecodeGetFullPath(HeadersRequest));
                end
                // ... authenticate http
                else if IsAuthenticationSessionHeader(HeadersRequest) then
                begin
                  if self.Authentication.Session.Enabled then
                    Authentication.FAuthenticated :=
                      DoAuthenticationSession(oConnection, DecodeGetFullPath(HeadersRequest));
                end;
                // ... if not authenticated then close
                if not Authentication.Authenticated then
                begin
                  HeadersRequest.Clear;
                  TCPConnection.IOHandler.InputBuffer.Clear;
                  raise TsgcWSException.Create(S_AUTHENTICATION_DENIED);
                end;
              end;
              // ... read websocket
              HeadersRequest.Clear;
              TCPConnection.IOHandler.Capture(HeadersRequest, '');
              ReadData(True);
            end
            else
            begin
              // ... response built-in authentication
              if IsRequestAuthenticationSessionHeader(HeadersRequest) and
                self.Authentication.Enabled and Self.Authentication.Session.Enabled then
              begin
                DoAuthSessionResponse(DecodeGETFullPath(HeadersRequest));
                HeadersRequest.Clear;
                TCPConnection.IOHandler.Capture(HeadersRequest, '');
                TCPConnection.Disconnect(False);
                if Assigned(oConnection) then
                begin
                  AContext.Data := nil;
                  FreeAndNil(oConnection);
                end;
              end
              else
              // ... response built-in javascript libraries
              if DoBuiltInLibraries(oConnection, DecodeGETHeader(HeadersRequest),
                False) then
              begin
                HeadersRequest.Clear;
                TCPConnection.IOHandler.Capture(HeadersRequest, '');
                TCPConnection.Disconnect(False);
                if Assigned(oConnection) then
                begin
                  AContext.Data := nil;
                  FreeAndNil(oConnection);
                end;
              end
              // ... response other http
              else
              begin
                GetHTTPServer.DoExecuteHTTP(AContext);
                if Assigned(oConnection) then
                begin
                  AContext.Data := nil;
                  FreeAndNil(oConnection);
                end;
              end;
            end;
          end
          // ... websocket data
          else
            ReadData(True);

        Except
          On E: Exception do
            DoError(oConnection, E);
        end;
      Finally
        DoLeaveCS;
      End;
    end;
  end
  else
    sleep(10);
end;

procedure TsgcWSHTTPServer.OnSessionEndEvent(Sender: TIdHTTPSession);
begin
  if Assigned(FOnSessionEnd) then
    FOnSessionEnd(Sender);
end;

procedure TsgcWSHTTPServer.OnSessionStartEvent(Sender: TIdHTTPSession);
begin
  if Assigned(FOnSessionStart) then
    FOnSessionStart(Sender);
end;

procedure TsgcWSHTTPServer.SetAutoStartSession(const Value: Boolean);
begin
  GetHTTPServer.AutoStartSession := Value;
end;

procedure TsgcWSHTTPServer.SetKeepAlive(const Value: Boolean);
begin
  GetHTTPServer.KeepAlive := Value;
end;

procedure TsgcWSHTTPServer.SetSessionTimeOut(const Value: Integer);
begin
  GetHTTPServer.SessionTimeOut := Value;
end;

procedure TsgcWSSecurity_Options.Assign(aSource: TPersistent);
begin
  if aSource is TsgcWSSecurity_Options then
  begin
    FOriginsAllowed := TsgcWSSecurity_Options(aSource).OriginsAllowed;
  end
  else
    inherited Assign(aSource);
end;

procedure TsgcWSThreadPool_Options.Assign(aSource: TPersistent);
begin
  if aSource is TsgcWSThreadPool_Options then
  begin
    MaxThreads := TsgcWSThreadPool_Options(aSource).MaxThreads;
    PoolSize := TsgcWSThreadPool_Options(aSource).PoolSize;
  end
  else
    inherited Assign(aSource);
end;

constructor TsgcWSConnectionAuthentication.Create;
begin
  inherited;
  FAuthenticated := False;
end;

function TsgcWSConnectionAuthentication.GetSessionID: string;
begin
  if FSessionID = '' then
    FSessionID := NewGuid;
  Result := FSessionID;
end;

constructor TsgcWSAuthenticationServer_Options.Create;
begin
  FAuthUsers := TStringList.Create;
  FURL := TsgcWSAuthenticationServer_URL.Create;
  FSession := TsgcWSAuthenticationServer_Session.Create;
end;

destructor TsgcWSAuthenticationServer_Options.Destroy;
begin
  FreeAndNil(FAuthUsers);
  FreeAndNil(FURL);
  FreeAndNil(FSession);
  inherited;
end;

procedure TsgcWSAuthenticationServer_Options.Assign(aSource: TPersistent);
begin
  inherited Assign(aSource);
  if aSource is TsgcWSAuthenticationServer_Options then
  begin
    FSession.Assign(TsgcWSAuthenticationServer_Options(aSource).Session);
    FURL.Assign(TsgcWSAuthenticationServer_Options(aSource).URL);
  end
end;

procedure TsgcWSAuthenticationServer_Options.SetAuthUsers(const Value:
    TStringList);
begin
  FAuthUsers.Assign(Value);
end;

procedure TsgcWSAuthenticationServer_Options.SetURL(const Value:
    TsgcWSAuthenticationServer_URL);
begin
  FURL.Assign(Value);
end;

procedure TsgcWSAuthenticationServer_Options.SetSession(const Value:
    TsgcWSAuthenticationServer_Session);
begin
  FSession.Assign(Value);
end;

constructor TsgcWSOptionsServer.Create;
begin
  inherited;
  FValidateUTF8 := False;
  FJavascriptFiles := True;
  FHTMLFiles := True;
end;

procedure TsgcWSOptionsServer.Assign(aSource: TPersistent);
begin
  if aSource is TsgcWSOptionsServer then
  begin
    FValidateUTF8 := TsgcWSOptionsServer(aSource).ValidateUTF8;
    FJavascriptFiles := TsgcWSOptionsServer(aSource).JavascriptFiles;
    FHTMLFiles := TsgcWSOptionsServer(aSource).HTMLFiles;
  end
  else
    inherited Assign(aSource);
end;

end.
