unit frmHttp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton;

type
  TfmHttp = class(TForm)
    btnHttp1: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    Memo1: TMemo;
    DNMSpeedButton2: TDNMSpeedButton;
    DNMSpeedButton3: TDNMSpeedButton;
    DNMSpeedButton4: TDNMSpeedButton;
    btnHttp2: TDNMSpeedButton;
    btnHttp3: TDNMSpeedButton;
    btnHttp4: TDNMSpeedButton;
    DNMSpeedButton5: TDNMSpeedButton;
    DNMSpeedButton6: TDNMSpeedButton;
    DNMSpeedButton7: TDNMSpeedButton;
    DNMSpeedButton8: TDNMSpeedButton;
    DNMSpeedButton9: TDNMSpeedButton;
    DNMSpeedButton10: TDNMSpeedButton;
    DNMSpeedButton11: TDNMSpeedButton;
    DNMSpeedButton12: TDNMSpeedButton;
    procedure btnHttp1Click(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure DNMSpeedButton2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DNMSpeedButton3Click(Sender: TObject);
    procedure DNMSpeedButton4Click(Sender: TObject);
    procedure DNMSpeedButton5Click(Sender: TObject);
    procedure DNMSpeedButton6Click(Sender: TObject);
    procedure DNMSpeedButton7Click(Sender: TObject);
    procedure DNMSpeedButton8Click(Sender: TObject);
    procedure DNMSpeedButton10Click(Sender: TObject);
    procedure DNMSpeedButton11Click(Sender: TObject);
    procedure DNMSpeedButton12Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses IdHTTP, HTTPConst, LogLib , IdSSLOpenSSL, idglobal ,
CK_DLL_Const, Http, Rest , StringBuilder, AppEnvironment, Global , OAuth1,
dateutils, CK_JsonObject, HttpResponse,
    tcConst, CK_DLL_HTTPLogreaderObj, CkString,
    HttpRequest,
    CkDateTime, XML, authUtil, TypesLib;


{$R *.dfm}
procedure TfmHttp.btnHttp1Click(Sender: TObject);
var
  fClient: TIdHttp;
  sl:TStringlist;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
begin
  inherited;
  fClient := TIdHttp.Create(nil);
  fClient.Request.UserAgent := HTTPConst.TrueERPUserAgent;
  fClient.ConnectTimeout:= 1000 * 10;
  fClient.ReadTimeout:= 1000 * 30;
      SSLHandler:= TIdSSLIOHandlerSocketOpenSSL.Create(fClient);
      //SSLHandler.MaxLineAction := maException;
(*           if sender = btnHttp1 then SSLHandler.SSLOptions.Method := sslvTLSv1
      else if sender = btnHttp2 then SSLHandler.SSLOptions.Method := sslvSSLv2
      else if sender = btnHttp3 then SSLHandler.SSLOptions.Method := sslvSSLv3
      else if sender = btnHttp2 then SSLHandler.SSLOptions.Method := sslvSSLv23;*)

(*      SSLHandler.SSLOptions.Mode := sslmBoth;
      SSLHandler.SSLOptions.VerifyMode := [];
      SSLHandler.SSLOptions.VerifyDepth := 0;*)


      //SSLHandler.SSLOptions.SSLVersions := [sslvSSLv3];

(*  SSLHandler.SSLOptions.Method:= sslvSSLv3;
  SSLHandler.SSLOptions.Mode:= sslmUnassigned;
  SSLHandler.SSLOptions.VerifyMode:= [];
  SSLHandler.SSLOptions.VerifyDepth:= 2;
  Client.ProxyParams.BasicAuthentication:= false;
  Client.Request.UserAgent := UserAgent;
  Client.Request.ContentType := 'application/x-www-form-urlencoded';
  Client.Request.host := 'www.google.com/analytics';
  Client.Request.connection := 'keep-alive';
  Client.Request.Accept := 'text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2';*)



  fClient.IOHandler:= SSLHandler;
  //fClient.Request.ContentType := 'application/json';
  //fClient.Request.Accept := 'text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2';
  sl:= TStringlist.create;
  try
    try
      sl.Text := fClient.get('https://www.service.transport.qld.gov.au/checkrego/application/TermAndConditions.xhtml?windowId=d5d');
      //sl.Text := fClient.get('http://www.service.transport.qld.gov.au');
      clog(sl.Text);
      memo1.lines.text := SL.text;
    except
      on E:Exception do begin
        clog(E.Message);
        memo1.lines.text := e.message;

      end;
    end;
  finally
    freeandnil(sl);
  end;

end;

procedure TfmHttp.DNMSpeedButton10Click(Sender: TObject);
var
  MemoryStream:TMemoryStream;
  IdHTTP1: TIdHttp;
begin
    Memo1.Lines.clear;
    MemoryStream:=TMemoryStream.Create;
    IdHTTP1 := TIdHttp.Create(nil);
    IdHTTP1.Request.UserAgent := HTTPConst.TrueERPUserAgent;
    (*IdHTTP1.ConnectTimeout:= 1000 * 10;
    IdHTTP1.ReadTimeout:= 1000 * 30;*)

    IdHTTP1.get('http://localhost:8080',memorystream);
    MemoryStream.Position:=0;
    Memorystream.SaveToFile('zzz.txt');
    Memo1.Lines.LoadFromStream(MemoryStream);
    MemoryStream.Free;
    Memo1.Lines.LoadFromFile('zzz.txt');
end;

procedure TfmHttp.DNMSpeedButton11Click(Sender: TObject);
//var
//    fsUrl      : PWideChar;
//    sbUrl      : HCkStringBuilder;
//    dtStartDate: HCkDateTime;
//
//    jsonSignature: PWideChar;
//    json         : HCkJsonObject;
//    Http         : HCkHttp;
//    xmlStr       : PWideChar;
//    authUtil     : HCkAuthUtil;
//    requestMethod :String ;
//    (*success    : Boolean;*)
//    (*numReplaced: Integer;*)
begin
//    dtStartDate := nil;
//    xmlStr := '';
//    try
//        fsUrl := 'http://localhost:8080/wordpress/index.php/wp-json/wc/v3/orders';
//        Logtext(fsUrl);
//
//        sbUrl   := CkStringBuilder_Create();
//        CkStringBuilder_Append(sbUrl, fsUrl);
//
//      authUtil := CkAuthUtil_Create();
//
//      CkGlobal_UnlockBundle( authUtil, CHILCAT_UNLOCK_KEY);
//       requestMethod :='GET';
//      jsonSignature := CkAuthUtil__walmartSignature(authUtil,
//                                                    CkStringBuilder__getAsString(sbUrl),
//                                                    pwidechar(Appenv.CompanyPrefs.WooCommerce_consumerKey),
//                                                    pwidechar(Appenv.CompanyPrefs.WooCommerce_consumerSecretKey),
//                                                    pwidechar(requestMethod));
//
//
//  if (CkAuthUtil_getLastMethodSuccess(authUtil) <> True) then
//  begin
//    Logtext(CkAuthUtil__lastErrorText(authUtil));
//    Exit;
//  end;
//
//    json := CkJsonObject_Create();
//   CkJsonObject_Load(json, jsonSignature);
//
//      //Http := getthttp(json, LogProc);
//  Http := CkHttp_Create();
//  CkHttp_SetRequestHeader(http,'WM_SVC.NAME','Woocommerce');
//  CkHttp_SetRequestHeader(http,'WM_QOS.CORRELATION_ID',CkJsonObject__stringOf(json,'correlation_id'));
//  CkHttp_SetRequestHeader(http,'WM_SEC.TIMESTAMP',CkJsonObject__stringOf(json,'timestamp'));
//  CkHttp_SetRequestHeader(http,'WM_SEC.AUTH_SIGNATURE',CkJsonObject__stringOf(json,'signature'));
//  CkHttp_SetRequestHeader(http,'WM_CONSUMER.ID',PWidechar(Appenv.CompanyPrefs.WooCommerce_consumerKey));
//  CkHttp_SetRequestHeader(http,'WM_CONSUMER.CHANNEL.TYPE',PWidechar(Appenv.CompanyPrefs.WooCommerce_consumerSecretKey));
//  CkHttp_SetRequestHeader(http,'Accept','application/json');
//
//
//
//      Logtext(CkStringBuilder__getAsString(sbUrl));
//
//      xmlStr := CkHttp__quickGetStr(Http, CkStringBuilder__getAsString(sbUrl));
//      if (CkHttp_getLastMethodSuccess(http) <> True) then
//        begin
//          Logtext(CkHttp__lastErrorText(http));
//          Logtext('=============================================================');
//          Logtext(CkHttp__lastStatusText(http));
//        end;
//
//
//    finally
//      Logtext(xmlStr);
//    end;
//
//    CkStringBuilder_Dispose(sbUrl);
//    CkDateTime_Dispose(dtStartDate);
//    CkAuthUtil_Dispose(authUtil);
//    CkJsonObject_Dispose(json);
//    CkHttp_Dispose(Http);
end;

procedure TfmHttp.DNMSpeedButton12Click(Sender: TObject);
var
  myObject: HCkOAuth1;
  outPropVal: HCkStringBuilder;

begin
myObject := CkOAuth1_Create();
try
  outPropVal       := CkStringBuilder_Create();
  CkStringBuilder_Append(outPropVal, 'GET');
  CkOAuth1_getSignatureMethod(myObject, outPropVal) ;


finally
CkOAuth1_Dispose(myObject);
end;




end;

procedure TfmHttp.DNMSpeedButton1Click(Sender: TObject);
var
  MemoryStream:TMemoryStream;
  IdHTTP1: TIdHttp;
begin
    Memo1.Lines.clear;
    MemoryStream:=TMemoryStream.Create;
    IdHTTP1 := TIdHttp.Create(nil);
    IdHTTP1.Request.UserAgent := HTTPConst.TrueERPUserAgent;
    (*IdHTTP1.ConnectTimeout:= 1000 * 10;
    IdHTTP1.ReadTimeout:= 1000 * 30;*)

    IdHTTP1.get('https://www.service.transport.qld.gov.au/checkrego/application/TermAndConditions.xhtml?windowId=d5d',memorystream);
    MemoryStream.Position:=0;
    Memorystream.SaveToFile('zzz.txt');
    Memo1.Lines.LoadFromStream(MemoryStream);
    MemoryStream.Free;
    Memo1.Lines.LoadFromFile('zzz.txt');
end;

procedure TfmHttp.DNMSpeedButton2Click(Sender: TObject);
var
  Client: TIdHTTP;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  InStream: TStringStream;
  s: string;
begin
  inherited;
  Memo1.Lines.clear;
  Client:= TIdHTTP.Create(nil);
  InStream:= TStringStream.Create(s, TEncoding.UTF8);
  try
  Client.Request.UserAgent := HTTPConst.TrueERPUserAgent;
      SSLHandler:= TIdSSLIOHandlerSocketOpenSSL.Create(client);
      SSLHandler.SSLOptions.Method := sslvSSLv3;
      SSLHandler.SSLOptions.SSLVersions := [sslvSSLv3];
      client.IOHandler:= SSLHandler;
      client.Request.BasicAuthentication:= true;

      //Client.Get('https://www.service.transport.qld.gov.au/checkrego/application/TermAndConditions.xhtml?windowId=d5d',InStream);
      //Client.Get('https://www.service.transport.qld.gov.au/checkrego/application/TermAndConditions.xhtml?dswid=6076',InStream);
      Client.Get('https://www.service.transport.qld.gov.au/checkrego/application/VehicleSearch.xhtml?dswid=-469',InStream);
      InStream.Position := 0;
      Memo1.Lines.LoadFromStream(InStream);
  finally
    Client.Free;
    InStream.Free;
  end;


end;

procedure TfmHttp.DNMSpeedButton3Click(Sender: TObject);
var
  IdSSLIOHandlerSocket1 : TIdSSLIOHandlerSocketOpenSSL;
  IdHTTP : TIdHTTP;
begin
  inherited;
IdSSLIOHandlerSocket1 := TIdSSLIOHandlerSocketOpenSSL.create(nil);
IdSSLIOHandlerSocket1.PassThrough := True;
IdHTTP := TIdHTTP.create(nil);
IdHTTP.reusesocket := rsTrue;
IdSSLIOHandlerSocket1.reusesocket := rsTrue;
idhttp.handleredirects := True;
with IdSSLIOHandlerSocket1 do begin
  SSLOptions.Method := sslvSSLv3;
  SSLOptions.SSLVersions := [sslvSSLv3];
  SSLOptions.VerifyMode := [];
  SSLOptions.VerifyDepth := 2;
end;
with IdHTTP do begin
  IOHandler := IdSSLIOHandlerSocket1;
  ProxyParams.BasicAuthentication := False;
  Request.UserAgent := 'EmbeddedAnalytics API Interface';
  Request.ContentType := 'text/html';
  request.connection := 'close';
  Request.Accept := 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8';
  Request.BasicAuthentication := False;
  Request.UserAgent := 'Mozilla/3.0 (compatible; Indy Library)';
  HTTPOptions := [hoForceEncodeParams];
  Request.AcceptEncoding := 'gzip,deflate';
  Request.CustomHeaders.Add('Accept-Language: en-us,en;q=0.5');
  //idhttp.Request.CustomHeaders.Add('Authorization: Bearer '+FToken);
end;
idhttp.get(':https://www.googleapis.com/analytics/v3/data/realtime?ids=..........');
end;

procedure TfmHttp.DNMSpeedButton4Click(Sender: TObject);
const
  ServerAddress = 'http://en.wikipedia.org';

var
  HTTP: TIdHTTP;
  Query: String;
  Buffer: String;

begin
  try
    HTTP := TIdHTTP.Create;

    Query := ServerAddress + '/w' + '/api.php?' +
      'action=query&prop=revisions&rvprop=content&format=xml&titles=Main Page';
      //String(HTTPEncode('Main Page'));

    // HTTP GET request
    Buffer := HTTP.Get(Query);
    clog(buffer);

    HTTP.Destroy;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end;

procedure TfmHttp.DNMSpeedButton5Click(Sender: TObject);
var
  MemoryStream:TMemoryStream;
  IdHTTP1: TIdHttp;
begin
    Memo1.Lines.clear;
    MemoryStream:=TMemoryStream.Create;
    IdHTTP1 := TIdHttp.Create(nil);
    IdHTTP1.Request.UserAgent := HTTPConst.TrueERPUserAgent;
    (*IdHTTP1.ConnectTimeout:= 1000 * 10;
    IdHTTP1.ReadTimeout:= 1000 * 30;*)

    IdHTTP1.get('http://localhost:8080/wordpress/index.php/wp-json/wc/v3/orders -u ck_a928e5957f681264ab25f9b8ddc695ba88bb3189:cs_14abad5a7bbee6da84c2340412d04ab5f5be439d',memorystream);
    MemoryStream.Position:=0;
    Memorystream.SaveToFile('zzz.txt');
    Memo1.Lines.LoadFromStream(MemoryStream);
    MemoryStream.Free;
    Memo1.Lines.LoadFromFile('zzz.txt');
end;

procedure TfmHttp.DNMSpeedButton6Click(Sender: TObject);

var
  MemoryStream:TMemoryStream;
  IdHTTP1: TIdHttp;
begin
  Memo1.Lines.clear;
    MemoryStream:=TMemoryStream.Create;
    IdHTTP1 := TIdHttp.Create(nil);
    IdHTTP1.Request.UserAgent := HTTPConst.TrueERPUserAgent;
    (*IdHTTP1.ConnectTimeout:= 1000 * 10;
    IdHTTP1.ReadTimeout:= 1000 * 30;*)

    IdHTTP1.get('http://localhost:8080/wordpress/index.php/wp-json/wc/v3/orders \-u ck_a928e5957f681264ab25f9b8ddc695ba88bb3189:cs_14abad5a7bbee6da84c2340412d04ab5f5be439d',memorystream);
    MemoryStream.Position:=0;
    Memorystream.SaveToFile('zzz.txt');
    Memo1.Lines.LoadFromStream(MemoryStream);
    MemoryStream.Free;
    Memo1.Lines.LoadFromFile('zzz.txt');

end;

procedure TfmHttp.DNMSpeedButton7Click(Sender: TObject);
var
  MemoryStream:TMemoryStream;
  IdHTTP1: TIdHttp;
begin
Memo1.Lines.clear;
    MemoryStream:=TMemoryStream.Create;
    IdHTTP1 := TIdHttp.Create(nil);
    IdHTTP1.Request.UserAgent := HTTPConst.TrueERPUserAgent;
    (*IdHTTP1.ConnectTimeout:= 1000 * 10;
    IdHTTP1.ReadTimeout:= 1000 * 30;*)

    IdHTTP1.get('http://localhost:8080/wordpress/index.php/wp-json/wc/v3/orders',memorystream);
    MemoryStream.Position:=0;
    Memorystream.SaveToFile('zzz.txt');
    Memo1.Lines.LoadFromStream(MemoryStream);
    MemoryStream.Free;
    Memo1.Lines.LoadFromFile('zzz.txt');


end;

procedure TfmHttp.DNMSpeedButton8Click(Sender: TObject);
var
  MemoryStream:TMemoryStream;
  IdHTTP1: TIdHttp;
begin
Memo1.Lines.clear;
    MemoryStream:=TMemoryStream.Create;
    IdHTTP1 := TIdHttp.Create(nil);
    IdHTTP1.Request.UserAgent := HTTPConst.TrueERPUserAgent;
    (*IdHTTP1.ConnectTimeout:= 1000 * 10;
    IdHTTP1.ReadTimeout:= 1000 * 30;*)

    IdHTTP1.get('http://localhost:8080/wordpress/index.php',memorystream);
    MemoryStream.Position:=0;
    Memorystream.SaveToFile('zzz.txt');
    Memo1.Lines.LoadFromStream(MemoryStream);
    MemoryStream.Free;
    Memo1.Lines.LoadFromFile('zzz.txt');


end;

procedure TfmHttp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;


end.
