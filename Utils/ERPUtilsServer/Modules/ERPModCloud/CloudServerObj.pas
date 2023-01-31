unit CloudServerObj;

interface

uses
  IdHttpServer, IdContext, IdCustomHTTPServer,
  IdSSLOpenSSL, IdSSL, IdGlobal,
  LogMessageTypes;

type
  TCloudServer = class(TObject)
  private
    HTTPServer: TIdHttpServer;
    FSSLPort: integer;
    FERPDatabaseServer: string;
    FPort: integer;
    procedure DoOnCommandGet(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure DoOnCommandOther(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure DoOnConnect(AContext: TIdContext);
    procedure DoOnQuerySSLPort(APort: TIdPort; var VUseSSL: Boolean);
    procedure Log(const msg: string; aType: TLogMessageType = ltBlank);
    procedure SetActive(const Value: boolean);
    procedure SetERPDatabaseServer(const Value: string);
    procedure SetPort(const Value: integer);
    procedure SetSSLPort(const Value: integer);
    function GetActive: boolean;
  public
    constructor Create;
    destructor Destroy; override;
    property Active: boolean read GetActive write SetActive;
  published
    property Port: integer read FPort write SetPort;
    property SSLPort: integer read FSSLPort write SetSSLPort;
    property ERPDatabaseServer: string read FERPDatabaseServer write SetERPDatabaseServer;
  end;

implementation

uses
  Types, URILib, SysUtils,
  {DataItem,}
  utObjBase,
  JsonObjectUtils, LogThreadLib,
  ModuleFileNameUtils, DateUtils,
  MyAccess, MySQLUtils, classes;

//const
//  UseSSL = true;



{ TCloudServer }

constructor TCloudServer.Create;
var
  SSLIOHandler: TIdServerIOHandlerSSLOpenSSL;
  path: string;
begin
  FSSLPort := 443;
  FERPDatabaseServer := 'localhost';
  FPort := 80;
  HTTPServer := TIdHttpServer.Create(nil);
  HTTPServer.OnCommandGet := DoOnCommandGet;
  HTTPServer.OnCommandOther := DoOnCommandOther;
  //HTTPServer.OnConnect := DoOnConnect;
  HTTPServer.OnQuerySSLPort := DoOnQuerySSLPort;
  HTTPServer.Bindings.Clear;
end;

destructor TCloudServer.Destroy;
var
  dt: TDateTime;
  NumClients: integer;
begin
  try
    if HTTPServer.Active then begin
      dt := now;
      HTTPServer.Active := false;
      while (now < (dt + (60 * OneSecond))) do begin
        with HTTPServer.Contexts.LockList do try
          NumClients := Count;
        finally
          HTTPServer.Contexts.UnlockList;
        end;
        if NumClients > 0 then
          Sleep(1000)
        else
          break;
      end;
    end;
    HTTPServer.Free;
  except

  end;
  inherited;
end;

procedure TCloudServer.DoOnCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  URIParts: TStringDynArray;
//  s: string;
  x: integer;
  part1, part2: string;
  dt: TDateTime;
  DatabaseName: string;
  UserName: string;
  Password: string;
  obj: ObjBase;
  objClass: ObjBaseClass;
  conn: TMyConnection;

  function IsApiRequest: boolean;
  begin
    result := (High(URIParts) > 1) and SameText(URIParts[1],'api');
  end;

begin
  dt := now;
  try
    Log('-------------------------------------',ltDetail);
    Log('Remote IP: ' + ARequestInfo.RemoteIP);
    AResponseInfo.ResponseNo:= 405; { "Method Not Allowed" }
  //  AResponseInfo.ResponseNo:= 200; { "Ok" }
    AResponseInfo.ContentType:= 'text/plain';
    AResponseInfo.CharSet := 'UTF-8';

    URIParts:= SplitURI(Lowercase(ARequestInfo.URI));

    Log('Received URI: ' + ARequestInfo.URI,ltDetail);
    for x := Low(URIParts) to High(URIParts) do
      Log('URI Part ' + IntToStr(x) + ': ' + URIParts[x],ltDetail);
    Log('Headers:',ltDetail);
    Log(ARequestInfo.RawHeaders.Text,ltDetail);


//      AResponseInfo.ResponseNo:= 200; { "Ok" }
//      AResponseInfo.ContentType:= 'application/json';
//      AResponseInfo.ContentText := '{"Prop1":"Value1","Prop2":"Value2"}';


    { URIParts[0] will always be blank .. }
    if High(URIParts) < 1 then exit;

    if IsApiRequest then begin
      if SameText(ARequestInfo.Command,'GET') then begin
        AResponseInfo.ResponseNo:= 200; { "Ok" }
        AResponseInfo.ContentType:= 'application/json';
        DatabaseName := ARequestInfo.RawHeaders.Values['database'];
        UserName := ARequestInfo.RawHeaders.Values['username'];
        Password := ARequestInfo.RawHeaders.Values['password'];
        if DatabaseName = '' then begin
//          AResponseInfo.ResponseNo:= 400; { "Bad Request" }
//          AResponseInfo.CustomHeaders.Values['ErrorMessage'] := 'Database not specified';
//          exit;
        end;
        conn := TMyConnection.Create(nil);
        try
          MySQLUtils.SetConnectionProps(conn,'aus_sample_company');
          conn.Connect;
          objClass := ObjBaseClass(findClass(URIParts[2]));
          obj := objClass.Create;
          obj.Load(StrToInt(URIParts[3]),conn);
          //AResponseInfo.ContentStream
          AResponseInfo.ContentText := JsonToStrFormat(obj.Data.AsString);

        finally
          obj.Free;
          conn.Free;
        end;
      end
      else begin
        { not a get command }

      end;
    end
    else begin
      exit;


    end;





    part2 := '';
    part1 := URIParts[1];
//    if not Assigned(TMappingList.GetMapping(part1)) then exit;


    if High(URIParts) > 1 then
      part2 := URIParts[2];
    (*
    if part2 = '' then begin
      AResponseInfo.ResponseNo:= 200; { "Ok" }
      AResponseInfo.ContentType:= 'application/json';
      with TDataItem.List(part1) do begin
        AResponseInfo.ContentText := JsonToStrFormat(AsString);
        free;
      end;
    end
    else if SameText(part2,'new') then begin
      AResponseInfo.ResponseNo:= 200; { "Ok" }
      AResponseInfo.ContentType:= 'application/json';
      with TDataItem.NewData(part1) do begin
        AResponseInfo.ContentText := JsonToStrFormat(AsString);
        free;
      end;
    end;
    *)
  finally
    Log('Execution Time: ' +
        FormatDateTime('hh:nn:ss.zzz',now - dt),ltDetail);
    Log('-------------------------------------',ltDetail);
    Log('',ltDetail);
  end;
end;

procedure TCloudServer.DoOnCommandOther(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin

end;

procedure TCloudServer.DoOnConnect(AContext: TIdContext);
begin


//  if UseSSL and (AContext.Binding.Port = 999) then begin
//      TIdSSLIOHandlerSocketBase(AContext.Connection.IOHandler).passThrough:= false;
//  end;
end;

procedure TCloudServer.DoOnQuerySSLPort(APort: TIdPort; var VUseSSL: Boolean);
begin
  VUseSSL := (APort = SSLPort);
end;

function TCloudServer.GetActive: boolean;
begin
  result := HTTPServer.Active;
end;

procedure TCloudServer.Log(const msg: string; aType: TLogMessageType);
begin
  Logger.Log(msg, aType);
end;


procedure TCloudServer.SetActive(const Value: boolean);
var
  SSLIOHandler: TIdServerIOHandlerSSLOpenSSL;
  path: string;
begin
  if Value then begin
    { avtive .. }
    if HTTPServer.Active then exit;
    HTTPServer.Bindings.Clear;
    if Port > 0 then
      HTTPServer.Bindings.Add.Port := Port;
    if SSLPort > 0 then begin
      HTTPServer.Bindings.Add.Port := SSLPort;
      SSLIOHandler:= TIdServerIOHandlerSSLOpenSSL.Create(HTTPServer);
      HTTPServer.IOHandler:= SSLIOHandler;
      path := GetCurrentModulePath;
      SSLIOHandler.SSLOptions.CertFile:= path + 'localhost.cer';
      SSLIOHandler.SSLOptions.KeyFile:= path + 'localhost.key';
      SSLIOHandler.SSLOptions.RootCertFile:= path + 'localhost.cer';
    end
    else begin
      if Assigned(HTTPServer.IOHandler) then begin
        HTTPServer.IOHandler.Free;
        HTTPServer.IOHandler:= nil;
      end;
    end;

    HTTPServer.Active := true;
  end
  else begin
    { not active }
    HTTPServer.Active := false;
  end;
end;

procedure TCloudServer.SetERPDatabaseServer(const Value: string);
begin
  FERPDatabaseServer := Value;
end;

procedure TCloudServer.SetPort(const Value: integer);
begin
  Active := false;
  FPort := Value;
end;

procedure TCloudServer.SetSSLPort(const Value: integer);
begin
  Active := false;
  FSSLPort := Value;
end;

end.
