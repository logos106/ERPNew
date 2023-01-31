{***************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
***************************************************************************}

unit sgcWebSocket_Client;

interface

{$I sgcVer.inc}

uses
  Classes, SysUtils, Math, StrUtils,
  {$IFNDEF MACOS}
  ExtCtrls,
  {$ENDIF}
  // indy
  IdTCPClient, IdThread, IdTCPConnection, IdGlobal, IdComponent, IdHeaderList,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  IdConnectThroughHttpProxy, IdHTTP,
  // websocket
  sgcWebSocket_Classes, sgcWebSocket_CustomClient;

type

// TsgcWSHandShakeClient //

  TsgcWSHandShakeClient = class(TsgcWSHandshake)

  { fields properties }
  private
    FAccept: string;
  public
    property Accept: string read FAccept;

  { decode }
  protected
    procedure DoDecodeConnection(const aHeader: String);
    procedure DoDecodeHeader(const aConnection: TIdTCPConnection; aHeaders:
        TIdHeaderList);
    procedure DoDecodeHTTP(const aHeader: String);
    procedure DoDecodeAccept(const aHeader: String);
    procedure DoDecodeProtocol(const aHeader: String);
    procedure DoDecodeUpgrade(const aHeader: String);
    procedure DoDecodeExtensions(const aHeader: String);

  { constructor }
  public
    constructor Create(aConnection: TIdTCPConnection; aHeaders: TIdHeaderList);
        override;
  End;


// TsgcWSConnectionClient //

  TsgcWSOptionsClient = class(TPersistent)
  private
    FOrigin: String;
    FParameters: String;
    FValidateUTF8: Boolean;
    function GetParameters: String;
  public
    procedure Assign(aSource: TPersistent); override;
  published
    property Origin: String read FOrigin write FOrigin;
    property Parameters: String read GetParameters write FParameters;
    property ValidateUTF8: Boolean read FValidateUTF8 write FValidateUTF8;
  end;



// TsgcWSConnectionClient //

  TsgcWSConnectionClient = class(TsgcWSConnection)

  { properties }
  private
    FHost: String;
    FPort: Integer;
    FOptions: TsgcWSOptionsClient;
  protected
    procedure SetOptions(const Value: TsgcWSOptionsClient);
  public
    property Host: String read FHost write FHost;
    property Options: TsgcWSOptionsClient read FOptions write SetOptions;
    property Port: Integer read FPort write FPort;
  { properties }

  { validate }
  private
    procedure DoValidateProtocols;
  { validate }

  { handshake }
  private
    FKey: String;
    FHandshake: TsgcWSHandShakeClient;
    FOnEnabled: TNotifyEvent;
  protected
    procedure DoHandShakeExtensions; virtual;
    procedure DoHandshake; override;
  protected
    function GetWSKey: String;
    procedure SendHanshake;
  { handshake }

  { initialize }
  public
    procedure DoInitialize(aConnection: TIdTCPConnection);
  { initialize }

  { events }
  public
    property OnEnabled: TNotifyEvent read FOnEnabled write FOnEnabled;
  { events }

  { constructor }
  public
    constructor Create; override;
  { constructor }

  { destructor }
  public
    destructor Destroy; override;
  { destructor }
  End;

// TsgcWSProxy_Options //

  TsgcWSProxy_Options = class(TPersistent)
  private
    FEnabled: Boolean;
    FHost: String;
    FPassword: String;
    FPort: Integer;
    FUsername: String;
  public
    procedure Assign(aSource: TPersistent); override;
  published
    property Enabled: Boolean read FEnabled write FEnabled;
    property Host: String read FHost write FHost;
    property Password: String read FPassword write FPassword;
    property Port: Integer read FPort write FPort;
    property Username: String read FUsername write FUsername;
  end;


// TsgcWSHeartBeat_Options //

  TsgcWSHeartBeat_Options = class(TPersistent)
  private
    FEnabled: Boolean;
    FInterval: Integer;
    FTimeout: Integer;
  public
    procedure Assign(aSource: TPersistent); override;
  published
    property Enabled: Boolean read FEnabled write FEnabled;
    property Interval: Integer read FInterval write FInterval;
    property Timeout: Integer read FTimeout write FTimeout;
  end;


// TsgcWSAuthenticationServer_Session //

  TsgcWSAuthenticationClient_Session = class(TsgcWSAuthentication_Session)
  private
    FExtensions: String;
    FProtocols: String;
    FID: String;
  public
    property Extensions: String read FExtensions write FExtensions;
    property Protocols: String read FProtocols write FProtocols;
    property ID: String read FID write FID;
  end;


// TsgcWSAuthenticationServer_URL //

  TsgcWSAuthenticationClient_URL = class(TsgcWSAuthentication_URL)

  end;

  // TsgcWSAuthenticationClient_Options //
  TsgcWSAuthenticationClient_Options = class(TsgcWSAuthentication_Options)
  private
    FURL: TsgcWSAuthenticationClient_URL;
    FPassword: String;
    FSession: TsgcWSAuthenticationClient_Session;
    FUser: String;
  protected
    procedure SetURL(const Value: TsgcWSAuthenticationClient_URL);
    procedure SetSession(const Value: TsgcWSAuthenticationClient_Session);
  public
    constructor Create; virtual;
    destructor Destroy; override;
  public
    procedure Assign(aSource: TPersistent); override;
  published
    property URL: TsgcWSAuthenticationClient_URL read FURL write SetURL;
    property Password: String read FPassword write FPassword;
    property Session: TsgcWSAuthenticationClient_Session read FSession write
        SetSession;
    property User: String read FUser write FUser;
  end;



// TsgcWSClient //

  TsgcWSClient = class(TsgcWSComponent_Client)

  { from TComponent }
  protected
    procedure Loaded; override;
  { from TComponent }

  { from TsgcWSComponent }
  protected
    function GetSpecifications: TsgcWSSpecifications; override;
  { from TsgcWSComponent }

  { tcp client }
  private
    FTCPClient: TsgcWSCustomClient;
    FHandlerSSL: TIdSSLIOHandlerSocketOpenSSL;
    FWSConnection: TsgcWSConnectionClient;
    function GetTCPClient: TsgcWSCustomClient;
  protected
    property TCPClient: TsgcWSCustomClient read GetTCPClient write FTCPClient;
  { tcp client }

  { proxy }
  private
    FProxy: TsgcWSProxy_Options;
    FProxyIOHandler: TIdIOHandlerStack;
    FProxyHTTP: TIdConnectThroughHttpProxy;
  private
    function GetProxyIOHandler: TIdIOHandlerStack;
    function GetProxyHTTP: TIdConnectThroughHttpProxy;
  protected
    procedure SetProxy(const Value: TsgcWSProxy_Options); virtual;
  public
    property Proxy: TsgcWSProxy_Options read FProxy write SetProxy;
  { proxy }

  { heartbeat }
  private
    FHeartBeat: TsgcWSHeartBeat_Options;
    {$IFNDEF MACOS}
    FHeartBeatTimeoutTimer: TTimer;
    FHeartBeatTimer: TTimer;
    {$ENDIF}
  private
    procedure OnHeartBeatTimeoutEvent(Sender: TObject);
    procedure DoStartHeartBeatTimeout;
    procedure DoStopHeartBeatTimeout;
  private
    procedure OnHeartBeatEvent(Sender: TObject);
    procedure DoStartHeartBeat;
    procedure DoStopHeartBeat;
  private
    procedure SetHeartBeat(const Value: TsgcWSHeartBeat_Options);
  public
    property HeartBeat: TsgcWSHeartBeat_Options read FHeartBeat write SetHeartBeat;
  { heartbeat }

  { authentication }
  private
    FAuthentication: TsgcWSAuthenticationClient_Options;
  private
    procedure SetAuthentication(const Value: TsgcWSAuthenticationClient_Options);
  protected
    function DoGetSession: Boolean; virtual;
    function DoGetSessionURL: string; virtual;
    function DoSessionResponse(aStream: TStringStream): Boolean; virtual;
  public
    property Authentication: TsgcWSAuthenticationClient_Options read
        FAuthentication write SetAuthentication;
  { authentication }

  { properties }
  private
    FActive: Boolean;
    FHost: String;
    FPort: Integer;
    FOptions: TsgcWSOptionsClient;
    FTLS: Boolean;
  protected
    function GetActive: Boolean; virtual;
    function GetProtocol: String; virtual;
    procedure SetActive(const Value: Boolean); virtual;
    procedure SetOptions(const Value: TsgcWSOptionsClient); virtual;
    procedure SetTLS(const Value: Boolean); virtual;
  public
    property Host: String read FHost write FHost;
    property Port: Integer read FPort write FPort;
    property Protocol: String read GetProtocol;
    property Active: Boolean read GetActive write SetActive default False;
    property Options: TsgcWSOptionsClient read FOptions write SetOptions;
    property TLS: Boolean read FTLS write SetTLS;
  { properties }

  { events }
  protected
    procedure OnClientConnectEvent(Sender: TObject); virtual;
    procedure OnClientMessageEvent(aConnection: TsgcWSConnection; const Text:
        string); virtual;
    procedure OnClientBinaryEvent(aConnection: TsgcWSConnection; const aStream:
        TMemoryStream); virtual;
    procedure OnClientDisconnectEvent(Sender: TObject); virtual;
    procedure OnClientEnabledEvent(Sender: TObject); virtual;
  protected
    procedure OnClientHandShakeEvent(aConnection: TsgcWSConnection; var Headers:
        TStringList); virtual;
  protected
  { events }

  { from thread }
  protected
    procedure OnReadEvent(Sender: TObject);
    procedure OnReadExceptionEvent(aException: Exception);
  public
  { from thread }

  { constructor }
  private
    procedure DoClear;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  { constructor }

  { WriteData }
  public
    procedure Ping;
    procedure WriteData(const aText: String);  override;
    procedure WriteData(const aStream: TMemoryStream); override;
  { WriteData }

  property Connection : TsgcWSConnectionClient read FWSConnection write FWSConnection;
  end;



implementation

uses
  sgcWebSocket_Helpers, sgcWebSocket_Types, sgcWebSocket_Const;

{ TWSHandShakeServer }

constructor TsgcWSHandShakeClient.Create(aConnection: TIdTCPConnection;
    aHeaders: TIdHeaderList);
begin
  DoDecodeHeader(aConnection, aHeaders);
end;

procedure TsgcWSHandShakeClient.DoDecodeConnection(const aHeader: String);
begin
 if not sgcMatchesMask(aHeader, '*Upgrade*') then
   raise TsgcWSException.Create(S_ERROR_DECODING_UPGRADE);
end;

procedure TsgcWSHandShakeClient.DoDecodeHeader(const aConnection:
    TIdTCPConnection; aHeaders: TIdHeaderList);
var
  vText: String;
  i: integer;
begin
  for i := 0 to aHeaders.Count - 1 do
  begin
    vText := aHeaders[i];

    if sgcMatchesMask(vText, 'HTTP/*') then
      DoDecodeHTTP(vText)
    else if sgcMatchesMask(vText, 'Upgrade: *') then
      DoDecodeUpgrade(vText)
    else if sgcMatchesMask(vText, 'Connection: *') then
      DoDecodeConnection(vText)
    else if sgcMatchesMask(vText, 'Sec-WebSocket-Accept: *') then
      DoDecodeAccept(vText)
    else if sgcMatchesMask(vText, 'Sec-WebSocket-Protocol: *') then
      DoDecodeProtocol(vText)
    else if sgcMatchesMask(vText, 'Sec-WebSocket-Extensions: *') then
      DoDecodeExtensions(vText);
  end;
end;

procedure TsgcWSHandShakeClient.DoDecodeHTTP(const aHeader: String);
var
  vText: String;
begin
  vText := Copy(aHeader, 10, Length(aHeader) - 9);
  if not sgcMatchesMask(vText, '*101*') then
    raise TsgcWSException.Create(S_ERROR_DECODING_SWITCHING_PROTOCOLS);
end;

procedure TsgcWSHandShakeClient.DoDecodeAccept(const aHeader: String);
begin
  if not sgcMatchesMask(aHeader, 'Sec-WebSocket-Accept: *') then
    raise TsgcWSException.Create('');
  FAccept := Copy(aHeader, 23, Length(aHeader) - 22);
end;

procedure TsgcWSHandShakeClient.DoDecodeProtocol(const aHeader: String);
begin
  if sgcMatchesMask(aHeader, 'Sec-WebSocket-Protocol: *') then
    FProtocols := Copy(aHeader, 25, Length(aHeader) - 24);
end;

procedure TsgcWSHandShakeClient.DoDecodeUpgrade(const aHeader: String);
begin
 if not sgcMatchesMask(aHeader, '* websocket') then
   raise TsgcWSException.Create(S_ERROR_DECODING_UPGRADE);
end;

procedure TsgcWSHandShakeClient.DoDecodeExtensions(const aHeader: String);
begin
  if sgcMatchesMask(aHeader, 'Sec-WebSocket-Extensions: *') then
    FExtensions := Copy(aHeader, 27, Length(aHeader) - 26);
end;

constructor TsgcWSClient.Create(aOwner: TComponent);
begin
  inherited;
  FOptions := TsgcWSOptionsClient.Create;
  FProxy := TsgcWSProxy_Options.Create;
  FProxy.Enabled := False;
  FProxy.Port := 8080;
  FHeartBeat := TsgcWSHeartBeat_Options.Create;
  FHeartBeat.Enabled := False;
  FHeartBeat.Interval := 300;
  FHeartBeat.Timeout := 0;
  FAuthentication := TsgcWSAuthenticationClient_Options.Create;
  FAuthentication.URL.Enabled := True;
  FAuthentication.Session.Enabled := True;
  Port := CS_DEFAULT_PORT;
  TLS := False;
end;

destructor TsgcWSClient.Destroy;
begin
  if Active then
  begin
    Active := False;
    FreeAndNil(FWSConnection);
  end;
  FreeAndNil(FAuthentication);
  FreeAndNil(FOptions);
  FreeAndNil(FHeartBeat);
  FreeAndNil(FProxy);
  DoClear;
  inherited;
end;

function TsgcWSClient.DoGetSession: Boolean;
var
  oHTTP: TIdHTTP;
  oStream: TStringStream;
  oSSL: TIdSSLIOHandlerSocketOpenSSL;
begin
  oHTTP := TIdHTTP.Create(nil);
  oStream := TStringStream.Create('');
  Try
    // ... proxy
    if Proxy.Enabled then
    begin
      oHTTP.ProxyParams.ProxyServer := Proxy.Host;
      oHTTP.ProxyParams.ProxyPort := Proxy.Port;
      oHTTP.ProxyParams.ProxyUsername := Proxy.UserName;
      oHTTP.ProxyParams.ProxyPassword := Proxy.Password;
    end;

    if TLS then
    begin
      oSSL := TIdSSLIOHandlerSocketOpenSSL.Create(oHTTP);
      oHTTP.IOHandler := oSSL;
      oSSL.SSLOptions.Method := sslvTLSv1;
      oSSL.SSLOptions.Mode := sslmClient;
    end;

    oHTTP.Get(DoGetSessionURL, oStream);

    result := DoSessionResponse(oStream);

  Finally
    FreeAndNil(oStream);
    FreeAndNil(oHTTP);
  End;
end;

procedure TsgcWSClient.DoClear;
begin
  // ... destroy FTCPClient
  if Assigned(FTCPClient) then
    FreeAndNil(FTCPClient);
  // ... destroy ssl
  if Assigned(FHandlerSSL) then
    FreeAndNil(FHandlerSSL);
  // ... destroy proxy
  FreeAndNil(FProxyHTTP);
  FreeAndNil(FProxyIOHandler);
end;

function TsgcWSClient.DoSessionResponse(aStream: TStringStream): Boolean;
var
  oList: TStringList;
begin
  result := False;

  oList := TStringList.Create;
  Try
    oList.Text := aStream.DataString;
    if oList.count > 2 then
    begin
      Authentication.Session.ID := oList[0];
      Authentication.Session.Extensions := oList[1];
      Authentication.Session.Protocols := oList[2];
      result := Authentication.Session.ID <> '';
    end;
  Finally
    FreeAndNil(oList);
  End;
end;

function TsgcWSClient.DoGetSessionURL: string;
begin
  if TLS then
    result := 'https://'
  else
    result := 'http://';
  result := result + Host + ':' + IntToStr(Port) + CS_REQ_AUTH_SESSION +
    Authentication.User + '/' + Authentication.Password;
end;

procedure TsgcWSClient.DoStartHeartBeat;
begin
  {$IFNDEF MACOS}
  if HeartBeat.Enabled then
  begin
    if not Assigned(FHeartBeatTimer) then
    begin
      FHeartBeatTimer := TTimer.Create(self);
      FHeartBeatTimer.OnTimer := OnHeartBeatEvent;
      FHeartBeatTimer.Enabled := False;
    end;
    FHeartBeatTimer.Interval := HeartBeat.Interval * 1000;

    if FHeartBeatTimer.Interval > 0 then
      FHeartBeatTimer.Enabled := True;
  end;
  {$ENDIF}
end;

procedure TsgcWSClient.DoStartHeartBeatTimeout;
begin
  {$IFNDEF MACOS}
  if HeartBeat.Timeout > 0 then
  begin
    if not Assigned(FHeartBeatTimeoutTimer) then
    begin
      FHeartBeatTimeoutTimer := TTimer.Create(self);
      FHeartBeatTimeoutTimer.OnTimer := OnHeartBeatTimeoutEvent;
      FHeartBeatTimeoutTimer.Interval := HeartBeat.Timeout * 1000;
    end;
    FHeartBeatTimeoutTimer.Enabled := True;
  end;
  {$ENDIF}
end;

procedure TsgcWSClient.DoStopHeartBeat;
begin
  {$IFNDEF MACOS}
  FreeAndNil(FHeartBeatTimer);
  {$ENDIF}
end;

procedure TsgcWSClient.DoStopHeartBeatTimeout;
begin
  {$IFNDEF MACOS}
  FreeAndNil(FHeartBeatTimeoutTimer);
  {$ENDIF}
end;

function TsgcWSClient.GetActive: Boolean;
begin
  if not IsDesigning and not IsLoading then
    Result := TCPClient.Connected
  else
    Result := FActive;
end;

function TsgcWSClient.GetProtocol: String;
begin
  Result := GetProtocols;
end;

function TsgcWSClient.GetProxyHTTP: TIdConnectThroughHttpProxy;
begin
  if not Assigned(FProxyHTTP) then
  begin
    FProxyHTTP := TIdConnectThroughHttpProxy.Create(self);
    FProxyHTTP.Host := Proxy.Host;
    FProxyHTTP.Port := Proxy.Port;
    FProxyHTTP.Username := Proxy.Username;
    FProxyHTTP.Password := Proxy.Password;
    FProxyHTTP.Enabled := Proxy.Enabled;
  end;
  Result := FProxyHTTP;
end;

function TsgcWSClient.GetProxyIOHandler: TIdIOHandlerStack;
begin
  if not TLS then
  begin
    if not Assigned(FProxyIOHandler) then
      FProxyIOHandler := TIdIOHandlerStack.Create(self);
    Result := FProxyIOHandler;
  end
  else
    Result := FHandlerSSL;
end;

function TsgcWSClient.GetSpecifications: TsgcWSSpecifications;
begin
  Result := inherited GetSpecifications;
  Result.Drafts.Hixie76 := False;
end;

function TsgcWSClient.GetTCPClient: TsgcWSCustomClient;
begin
  if not Assigned(FTCPClient) then
  begin
    FTCPClient := TsgcWSCustomClient.Create(self);

    FTCPClient.OnConnected := OnClientConnectEvent;
    FTCPClient.OnDisconnected := OnClientDisconnectEvent;

    FTCPClient.OnRead := OnReadEvent;
    FTCPClient.OnReadException := OnReadExceptionEvent;
  end;
  Result := FTCPClient;
end;

procedure TsgcWSClient.Loaded;
begin
  inherited;
  if Active <> FActive then
    Active := FActive;
end;

procedure TsgcWSClient.OnClientBinaryEvent(aConnection: TsgcWSConnection; const
    aStream: TMemoryStream);
begin
  if IsDestroying then exit;

  Try
    aConnection.MsgBinaryReceived.LoadFromStream(aStream);
    DoNotifyBinary(aConnection);
  Except
    On E: Exception do
      DoError(aConnection, E);
  end;
end;

procedure TsgcWSClient.OnClientConnectEvent(Sender: TObject);
begin
  if IsDestroying then exit;

  Try
    FWSConnection := TsgcWSConnectionClient.Create;
    FWSConnection.Specification := spRFC6455;
    FWSConnection.Extensions := Extensions;
    FWSConnection.Masked := True;
    FWSConnection.Protocol := Protocol;
    FWSConnection.Host := TCPClient.Host;
    FWSConnection.Port := TCPClient.Port;
    FWSConnection.Options := Options;
    FWSConnection.OnHandshake := OnClientHandShakeEvent;
    FWSConnection.DoInitialize(TCPClient);
    FWSConnection.OnMessage := OnClientMessageEvent;
    FWSConnection.OnBinary := OnClientBinaryEvent;
    FWSConnection.OnEnabled := OnClientEnabledEvent;

    DoStartHeartBeat;

  Except
    On E: Exception do
      DoError(FWSConnection, E);
  end;
end;

procedure TsgcWSClient.OnClientDisconnectEvent(Sender: TObject);
begin
  if IsDestroying then exit;

  Try
    if not (csDestroying in ComponentState) then
    begin
      DoNotifyDisconnect(FWSConnection);
      DoStopHeartBeat;
      FWSConnection := nil;
    end;

  Except
    On E: Exception do
      DoError(FWSConnection, E);
  end;
end;

procedure TsgcWSClient.OnClientEnabledEvent(Sender: TObject);
begin
  if IsDestroying then exit;

  DoNotifyConnect(FWSConnection);
end;

procedure TsgcWSClient.OnClientHandShakeEvent(aConnection: TsgcWSConnection;
    var Headers: TStringList);
begin
  Try
    if not (csDestroying in ComponentState) then
      DoNotifyHandshake(aConnection);
  Except
    On E: Exception do
      DoError(aConnection, E);
  end;
end;

procedure TsgcWSClient.OnClientMessageEvent(aConnection: TsgcWSConnection;
    const Text: string);
begin
  if IsDestroying then exit;

  Try
    aConnection.MsgReceived := Text;
    DoNotifyMessage(aConnection);
  Except
    On E: Exception do
      DoError(aConnection, E);
  end;
end;

procedure TsgcWSClient.OnHeartBeatEvent(Sender: TObject);
begin
  if Active then
  begin
    Ping;
    DoStartHeartBeatTimeout;
  end;
end;

procedure TsgcWSClient.OnHeartBeatTimeoutEvent(Sender: TObject);
begin
  if (((Now - FWSConnection.LastPong) * 86400) > HeartBeat.Timeout * 1000) then
    DoException(FWSConnection, TsgcWSException.Create(S_HEARTBEAT_TIMEOUT_EXCEEDED))
  else
    DoStopHeartBeatTimeout;
end;

procedure TsgcWSClient.OnReadExceptionEvent(aException: Exception);
begin
  if IsDestroying then exit;

  DoException(FWSConnection, aException);

  if Assigned(FWSConnection) then
  begin
    if Assigned(TCPClient) then
    begin
      TCPClient.IOHandler.InputBuffer.Clear;
      if Assigned(TCPClient.IOHandler) then
      begin
        if TCPClient.IOHandler.Opened then
          TCPClient.IOHandler.Close;
      end;
    end;
    DoNotifyDisconnect(FWSConnection);
  end;
end;

procedure TsgcWSClient.OnReadEvent(Sender: TObject);
begin
  Try
    if Assigned(FWSConnection) then
      FWSConnection.ReadData;
  Except
    On E: Exception do
      DoError(FWSConnection, E);
  end;
end;

procedure TsgcWSClient.Ping;
begin
  Try
    if Assigned(FWSConnection) then    
      FWSConnection.Ping(FormatDateTime('yyyymmddhhnnsszzz', Now));
  Except
    On E: Exception do
      DoError(FWSConnection, E);
  end;
end;

procedure TsgcWSClient.WriteData(const aText: String);
begin
  Try
    if Assigned(FWSConnection) then
      FWSConnection.WriteData(aText);
  Except
    On E: Exception do
      DoError(FWSConnection, E);
  end;
end;

procedure TsgcWSClient.SetActive(const Value: Boolean);
begin
  Try
    if not IsDesigning and not IsLoading then
    begin
      if Value then
      begin
        if not TCPClient.Connected then
        begin
          // ... clear
          DoClear;
          // ... TLS
          TLS := FTLS;
          // ... properties
          TCPClient.Host := Host;
          TCPClient.Port := Port;
          // ... proxy
          if Proxy.Enabled then
          begin
            TCPClient.IOHandler := GetProxyIOHandler;
            GetProxyIOHandler.TransparentProxy := GetProxyHTTP;
          end;
          // ... connect
          if Authentication.Enabled then
          begin
            if Authentication.Session.Enabled then
            begin
              if DoGetSession then
                Options.Parameters := CS_AUTH_SESSION + Authentication.Session.ID;
            end
            else
            if Authentication.URL.Enabled then
              Options.Parameters := CS_AUTH_URL +
                Authentication.User + '/' +
                Authentication.Password;
            TCPClient.Connect;
          end
          else
            TCPClient.Connect;
        end;
      end
      else
      begin
        // ... disconnect
        if TCPClient.Connected then
          TCPClient.Disconnect;
      end;
    end
    else
      FActive := Value;
  Except
    On E: Exception do
      DoException(FWSConnection, E);
  End;
end;

procedure TsgcWSClient.SetAuthentication(const Value:
    TsgcWSAuthenticationClient_Options);
begin
  FAuthentication.Assign(Value);
end;

procedure TsgcWSClient.SetHeartBeat(const Value: TsgcWSHeartBeat_Options);
begin
  FHeartBeat.Assign(Value);
end;

procedure TsgcWSClient.SetOptions(const Value: TsgcWSOptionsClient);
begin
  FOptions.Assign(Value);
end;

procedure TsgcWSClient.SetProxy(const Value: TsgcWSProxy_Options);
begin
  FProxy.Assign(Value);
end;

procedure TsgcWSClient.SetTLS(const Value: Boolean);
begin
  FTLS := Value;
  if FTLS then
  begin
    if IsDesigning then
      Port := 443
    else
    begin
      if not Assigned(FHandlerSSL) then
      begin
        FHandlerSSL := TIdSSLIOHandlerSocketOpenSSL.Create(self);
        TCPClient.IOHandler := FHandlerSSL;
        FHandlerSSL.SSLOptions.Method := sslvTLSv1;
        FHandlerSSL.SSLOptions.Mode := sslmClient;
      end;
    end;
  end
  else
  begin
    if not IsDesigning then
    begin
      if Assigned(FHandlerSSL) then
      begin
        TCPClient.IOHandler := nil;
        FreeAndNil(FHandlerSSL);
      end;
    end;
  end;
end;

procedure TsgcWSClient.WriteData(const aStream: TMemoryStream);
begin
  Try
    if Assigned(FWSConnection) then
      FWSConnection.WriteData(aStream);
  Except
    On E: Exception do
      DoError(FWSConnection, E);
  end;
end;

constructor TsgcWSConnectionClient.Create;
begin
  inherited;
  FOptions := TsgcWSOptionsClient.Create;
end;

destructor TsgcWSConnectionClient.Destroy;
begin
  FreeAndNil(FOptions);
  FreeAndNil(FHandshake);
  inherited;
end;

procedure TsgcWSConnectionClient.DoHandShakeExtensions;
begin
  Extensions.DecodeExtensions(FHandShake.Extensions);
end;


procedure TsgcWSConnectionClient.DoHandshake;
begin
  Assert(not Enabled);

  HeadersRequest.Clear;
  TCPConnection.IOHandler.Capture(HeadersRequest, '');
  FHandShake := TsgcWSHandShakeClient.Create(TCPConnection, HeadersRequest);
  if FHandShake.GetWSAccept(FKey) <> FHandShake.Accept then
    raise TsgcWSException.Create(S_INVALID_ACCEPT_KEY);

  DoValidateProtocols;
  DoHandShakeExtensions;

  FEnabled := True;

  if Assigned(FOnEnabled) then FOnEnabled(self);
    
end;

procedure TsgcWSConnectionClient.DoInitialize(aConnection: TIdTCPConnection);
begin
  TCPConnection := aConnection;
  SendHanshake;
end;

procedure TsgcWSConnectionClient.DoValidateProtocols;
var
  oList: TsgcDelimitedStringList;
begin
  if Protocol <> '' then
  begin
    oList := TsgcDelimitedStringList.Create;
    Try
      oList.DelimitedText := Protocol;

      if oList.IndexOf(FHandShake.Protocols) = -1 then
        raise TsgcWSException.Create(S_PROTOCOL_NOT_SUPPORTED);

    Finally
      FreeAndNil(oList);
    End;
  end;
end;

function TsgcWSConnectionClient.GetWSKey: String;
var
  oBytes: TIdBytes;
  i: Integer;
begin
  SetLength(oBytes, 16);
  Randomize;
  for i := 0 to Length(oBytes) - 1 do
    oBytes[i] := RandomRange(0, 255);
  Result := HexToBase64(ToHex(oBytes));

  FKey := result;
end;

procedure TsgcWSConnectionClient.SendHanshake;
var
  i: Integer;
begin
  HeadersResponse.Clear;
  HeadersResponse.Add('GET ' + Options.Parameters + ' HTTP/1.1');
  if (Port = 80) or (Port = 443) then
    HeadersResponse.Add('Host: ' + Host)
  else
    HeadersResponse.Add('Host: ' + Host + ':' + IntToStr(Port));
  HeadersResponse.Add('Upgrade: websocket');
  HeadersResponse.Add('Connection: Upgrade');
  HeadersResponse.Add('Sec-WebSocket-Key: ' + GetWSKey);
  if Options.Origin <> '' then
    HeadersResponse.Add('Origin: ' + Options.Origin)
  else
    HeadersResponse.Add('Origin: ' + Host);
  if Protocol <> '' then
    HeadersResponse.Add('Sec-WebSocket-Protocol: ' + Protocol);
  // ... extensions
  Extensions.WriteHeader(HeadersResponse);

  HeadersResponse.Add('Sec-WebSocket-Version: 13');

  if Assigned(FOnHandshake) then
    FOnHandshake(self, FHeadersResponse);

  TCPConnection.IOHandler.WriteBufferOpen;
  Try
    for i := 0 to HeadersResponse.Count - 1 do
      TCPConnection.IOHandler.WriteLn(HeadersResponse[i]);
    TCPConnection.IOHandler.WriteLn;
    TCPConnection.IOHandler.WriteBufferFlush;
  Finally
    TCPConnection.IOHandler.WriteBufferClose;
  End;

end;

procedure TsgcWSConnectionClient.SetOptions(const Value: TsgcWSOptionsClient);
begin
  FOptions.Assign(Value);
  ValidateUTF8 := FOptions.ValidateUTF8;
end;

procedure TsgcWSOptionsClient.Assign(aSource: TPersistent);
begin
  if aSource is TsgcWSOptionsClient then
  begin
    FParameters := TsgcWSOptionsClient(aSource).Parameters;
    FOrigin := TsgcWSOptionsClient(aSource).Origin;
    FValidateUTF8 := TsgcWSOptionsClient(aSource).ValidateUTF8;
  end
  else
    inherited Assign(aSource);
end;

function TsgcWSOptionsClient.GetParameters: String;
begin
  if LeftStr(FParameters, 1) <> '/' then
    FParameters := '/' + FParameters;
  Result := FParameters;
end;

procedure TsgcWSProxy_Options.Assign(aSource: TPersistent);
begin
  if aSource is TsgcWSProxy_Options then
  begin
    Enabled := TsgcWSProxy_Options(aSource).Enabled;
    Host := TsgcWSProxy_Options(aSource).Host;
    Port := TsgcWSProxy_Options(aSource).Port;
    Username := TsgcWSProxy_Options(aSource).Username;
    Password := TsgcWSProxy_Options(aSource).Password;
  end
  else
    inherited Assign(aSource);
end;

procedure TsgcWSHeartBeat_Options.Assign(aSource: TPersistent);
begin
  if aSource is TsgcWSHeartBeat_Options then
  begin
    Enabled := TsgcWSHeartBeat_Options(aSource).Enabled;
    Interval := TsgcWSHeartBeat_Options(aSource).Interval;
    Timeout := TsgcWSHeartBeat_Options(aSource).Timeout;
  end
  else
    inherited Assign(aSource);
end;

constructor TsgcWSAuthenticationClient_Options.Create;
begin
  FURL := TsgcWSAuthenticationClient_URL.Create;
  FSession := TsgcWSAuthenticationClient_Session.Create;
end;

destructor TsgcWSAuthenticationClient_Options.Destroy;
begin
  FreeAndNil(FURL);
  FreeAndNil(FSession);
  inherited;
end;

procedure TsgcWSAuthenticationClient_Options.Assign(aSource: TPersistent);
begin
  inherited Assign(aSource);
  if aSource is TsgcWSAuthenticationClient_Options then
  begin
    User := TsgcWSAuthenticationClient_Options(aSource).User;
    Password := TsgcWSAuthenticationClient_Options(aSource).Password;

    FSession.Assign(TsgcWSAuthenticationClient_Options(aSource).Session);
    FURL.Assign(TsgcWSAuthenticationClient_Options(aSource).URL);
  end
end;

procedure TsgcWSAuthenticationClient_Options.SetURL(const Value:
    TsgcWSAuthenticationClient_URL);
begin
  FURL.Assign(Value);
end;

procedure TsgcWSAuthenticationClient_Options.SetSession(const Value:
    TsgcWSAuthenticationClient_Session);
begin
  FSession.Assign(Value);
end;

end.
