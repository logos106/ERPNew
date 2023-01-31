unit UKGovTalkClient;

{$I ERP.inc}

interface

type
  TUKGovTalkClientObj = class(TObject)
  private
    fXML:string;
    fResponse:string;
    fIsLive:Boolean;
    fURL:string;
    function HasRequiredData:boolean;
    procedure SetIsLive(Const Value :Boolean );
    procedure DoOnGetPassword(var Password: AnsiString);
  public
    constructor Create;
    function Send:Boolean;
    property XML :string read fXML write fXML;
    property Response :string read fResponse;
    property IsLive :Boolean read fIsLive write SetIsLive;
    property URL:string read fURL write fURL ;
  end;


implementation

uses
  IdHTTP,IdIOHandlerSocket,IdIOHandler,IdSSLOpenSSL,CommonLib,Classes
  {$ifdef COMPILER_22_UP}
  ,idSSL
  {$endif}
  , HTTPConst;

constructor TUKGovTalkClientObj.Create;
begin
  inherited;
end;

function TUKGovTalkClientObj.HasRequiredData:boolean;
begin
  Result := True;
  if XML = '' then Result := False;
end;

Function  TUKGovTalkClientObj.Send:Boolean;
var
  snd: TMemoryStream;
  FSession : TIdHttp;
  {$ifdef COMPILER_22_UP}
  SSLIOHandler: TIdSSLIOHandlerSocketOpenSSL;
  {$else}
  SSLIOHandler: TIdSSLIOHandlerSocket;
  {$endif}
begin
  Result := False;
  if not HasRequiredData then begin

    exit;
  end;

  SSLIOHandler := nil;
  snd := TMemoryStream.Create;
  FSession := TIdHTTP.Create(nil);
  try
    FSession.Request.UserAgent := HTTPConst.TrueERPUserAgent;
    StringToStream(XML,snd);
    snd.Seek ( 0, soFromBeginning );

    {$ifdef COMPILER_22_UP}
    SSLIOHandler:= TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    {$else}
    SSLIOHandler := TIdSSLIOHandlerSocket.Create(nil);
    {$endif}
    SSLIOHandler.OnGetPassword:= self.DoOnGetPassword;

    SSLIOHandler.SSLOptions.Method :=  sslvSSLv23;
    SSLIOHandler.SSLOptions.RootCertFile :=  'sampleRoot.pem'; //exe directory OK?
    SSLIOHandler.SSLOptions.CertFile := 'sample.crt';
    SSLIOHandler.SSLOptions.KeyFile :=  'sample.key';
    SSLIOHandler.SSLOptions.VerifyDepth := 2;
    FSession.IOHandler := SSLIOHandler;

//    FSession.Port := 443;
    { proxy setup }
//    if (FProxyName <> '') then
//      begin
//        {proxy basic auth}
//        if(FProxyBasicAuth) then
//          FSession.ProxyParams.BasicAuthentication := true;
//
//        FSession.ProxyParams.ProxyServer := FProxyName;
//        FSession.ProxyParams.ProxyPort := FProxyPort;
//        FSession.ProxyParams.ProxyUsername := FProxyUserName;
//        FSession.ProxyParams.ProxyPassword := FProxyPassword;
//      end;

    FSession.Request.Accept := '*/*';
    FSession.Request.ContentType := 'text/xml';
    FSession.Request.Connection :=   'close';

    FSession.Request.ContentLength := snd.Size;

    try
      fResponse := FSession.Post(fURL ,snd);
      Result := True;
    except
      Result := False;
    end;
  Finally
    FSession.Disconnect;
    FSession.Free;
    snd.Free;
    if Assigned(SSLIOHandler) then
      SSLIOHandler.Free;
  end;
end;

procedure TUKGovTalkClientObj.DoOnGetPassword(var Password: AnsiString);
begin
  password:= 'aaaa';
end;

procedure TUKGovTalkClientObj.SetIsLive(Const Value :Boolean);
begin
  fIsLive := Value;
end;

end.
