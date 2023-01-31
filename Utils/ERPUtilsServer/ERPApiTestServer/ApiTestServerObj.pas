unit ApiTestServerObj;

interface

uses
  IdBaseComponent, IdComponent, IdCustomTCPServer, IdCustomHTTPServer,
  IdHTTPServer, IDContext;


type

  TApiTestServer = class(TObject)
  private
    Http: TIdHttpServer;
    procedure HTTPServerCommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  SysUtils, URILib, types, Dialogs;

{ TApiTestServer }

constructor TApiTestServer.Create;
begin
  Http := TIdHttpServer.Create(nil);
  Http.DefaultPort := 8080;
  Http.OnCommandGet := HTTPServerCommandGet;
  Http.Active := true;
end;

destructor TApiTestServer.Destroy;
begin
  Http.Free;
  inherited;
end;

procedure TApiTestServer.HTTPServerCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  URIParts: TStringDynArray;
  s: string;
begin
  if ARequestInfo.CommandType <> hcGET then exit;
  URIParts := URILib.SplitURI(ARequestInfo.URI);
  if High(URIParts) < 0 then exit;

  if SameText(URIParts[0],'apitest') then begin


  end;


  showmessage(ARequestInfo.Document);
end;

end.
