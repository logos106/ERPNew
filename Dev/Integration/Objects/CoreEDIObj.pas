unit CoreEDIObj;

interface

uses
  SysUtils, IdHttp, JsonObject, LogThreadBase, LogMessageTypes,
  sgcBase_Classes, sgcTCP_Classes, sgcWebSocket_Classes,
  sgcWebSocket_Classes_Indy, sgcWebSocket_Client, sgcWebSocket, ConTnrs,
  utBaseCoreService, Classes;

type
  TBrowserLogonRequired = procedure (Sender: TObject; Msg: string; LogonURL: string) of object;

  TCoreEDI = class(TObject)
  private
//    HTTP: TIdHTTP;
    fCoreEDIServer: string;
    wsClient: TsgcWebSocketClient;
    fBrowserLogonRequired: TBrowserLogonRequired;
    fCoreEDIUser: string;
    fOnLog: TOnLogStrEvent;
    fConnected: boolean;
    ServiceList: TObjectList;
    fCoreEDIPassword: string;
    fsConnectError: String;
    function GetCoreEDIServer: string;
    procedure wsClientMessage(Connection: TsgcWSConnection; const Text: string);
    procedure wsClientConnect(Connection: TsgcWSConnection);
    procedure wsClientDisconnect(Connection: TsgcWSConnection; Code: Integer);
    procedure wsServerError(Connection: TsgcWSConnection; const Error: string);
    procedure wsClientException(Connection: TsgcWSConnection; E: Exception);
    procedure wsClientHandshake(Connection: TsgcWSConnection; var Headers: TStringList);
    function GetConnected: boolean;
    procedure SetConnected(const Value: boolean);
    function GetService(ServiceName: string): TBaseCoreService;
  protected
    procedure Log(msg: string; aType: string = '');
  public
    constructor Create;
    destructor Destroy; override;
    property CoreEDIServer: string read GetCoreEDIServer write fCoreEDIServer;
    property OnBrowserLogonRequired: TBrowserLogonRequired
      read fBrowserLogonRequired write fBrowserLogonRequired;
    property CoreEDIUser: string read fCoreEDIUser write fCoreEDIUser;
    property CoreEDIPassword: string read fCoreEDIPassword write fCoreEDIPassword;
    property OnLog: TOnLogStrEvent read fOnLog write fOnLog;
    function Connect: boolean;
    property Connected: boolean read GetConnected write SetConnected;
    procedure Write(const aService, data: string);
    function WriteAndWait(const aService, data: string; const aTimeout: integer = 10000): string;
    procedure AddService(aService: TBaseCoreService);
    property Service[ServiceName: string]: TBaseCoreService read GetService;
    Property ConnectError :String read fsConnectError;
  end;

implementation

uses
  IdSSLOpenSSL, IdMultipartFormData, URILib, ShellAPI,
  FileDownloadFuncs, SystemLib, DateUtils, sgcWebSocket_Types, tcConst,
  CommonLib, dialogs;

{ TCoreEDI }

procedure TCoreEDI.AddService(aService: TBaseCoreService);
begin
  aService.CoreEDI := self;
  ServiceList.Add(aService);
end;

function TCoreEDI.Connect: boolean;
var
  x: integer;
  s: string;
//  dt: TDateTime;
begin
  result := false;
  wsClient.Authentication.User := CoreEDIUser;
  wsClient.Authentication.Password := CoreEDIPassword;
  s := GetCoreEDIServer;
  x := Pos(':',s);
  if x > 0 then begin
    wsClient.Host := Copy(s,1,x-1);
    wsClient.Port := StrToInt(Copy(s,x+1,Length(s)));
  end
  else begin
    wsClient.Host := s;
  end;
  try

    if wsClient.Connect() then begin
//      if wsClient.ConnectTimeout > 0 then
//        dt := now + (wsClient.ConnectTimeout * OneMilliSecond)
//      else
//        dt := now + (30 * OneSecond);
//      while (not fConnected) and (now <= dt) do
//        Sleep(20);
      fConnected := true;
      result := true;
    end;
  except
    on e: exception do begin
      Log('Failed to connect to CoreEDI Server.', 'Error');
      fsConnectError := 'Failed to connect to CoreEDI Server.' +NL+NL+
                        'User :' + CoreEDIUser +NL+
                        'Password :' +CoreEDIPassword;
      try
        Log(e.ClassName + ' ' +  e.Message, 'Error');

      except

      end;
    end;

  end;
end;

constructor TCoreEDI.Create;
begin
  try
    fsConnectError := '';
    ServiceList := TObjectList.Create;
    fConnected := false;
    fCoreEDIServer := '';
    wsClient := TsgcWebSocketClient.Create(nil);

    wsClient.OnConnect := wsClientConnect;
    wsClient.OnDisconnect := wsClientDisconnect;
    wsClient.TLS := true;
    wsClient.TLSOptions.IOHandler := iohSChannel;

    //wsClient.Authentication.Basic.Enabled := true;
    wsClient.Authentication.Enabled := true;
    wsClient.OnError := wsServerError;
    wsClient.OnException := wsClientException;
    wsClient.OnMessage := wsClientMessage;
    wsClient.OnHandshake := wsClientHandshake;
  Except
    on E:Exception do begin
      MessageDlgXP_vista('Connection to Core EDI Failed.'+NL+E.message, mtWarning, [mbOK], 0);
    end;
  end;
end;

destructor TCoreEDI.Destroy;
begin
//  HTTP.Free;
  wsClient.OnError := nil;
  wsClient.OnException := nil;
  wsClient.OnMessage := nil;
  wsClient.OnHandshake := nil;

  wsClient.Disconnect();
  wsClient.Active := false;
  wsClient.Free;
  ServiceList.Free;
  inherited;
end;

//function TCoreEDI.Get(Vendor, Path: string; Data: TJsonObject;
//  var msg: string): boolean;
//var
//  s: string;
//begin
//  HTTP.Request.BasicAuthentication := true;
//  HTTP.Request.Username := CoreEDIUser;
//  try
//    s := HTTP.Get(CoreEDIServerURL + '/' + Vendor + '/' + Path);
//    Log(s);
//    Log('Status: ' + HTTP.ResponseText);
//  except
//    on e: exception do begin
//      if e is EIdHTTPProtocolException then begin
//        Log(e.Message);
//        Log(EIdHTTPProtocolException(e).ErrorMessage);
//      end
//      else begin
//        Log(e.Message, ltError);
//      end;
//    end;
//
//  end;
//
//end;

function TCoreEDI.GetConnected: boolean;
begin
  result := fConnected;
end;

function TCoreEDI.GetCoreEDIServer: string;
var
  aFile: string;
  json: TJsonObject;
begin
  if fCoreEDIServer = '' then begin
    aFile := WinTempDir + 'core_edi_configuration.json';
    if TFileDownloader.DownloadFile('http://www.trueerp.com/Docs/core_edi_configuration.json',aFile) then begin
      json := JO;
      try
        json.LoadFromFile(aFile);
        fCoreEDIServer := json.S['core_edi_server'];
      finally
        json.Free;
      end;
    end
    else
      raise Exception.Create('Unable to download CoreEDI Configuaration file from the internet.');
    if fCoreEDIServer = '' then
      raise Exception.Create('Unable to locate CoreEDI Server Configuration.');
  end;
  result := fCoreEDIServer;
end;

function TCoreEDI.GetService(ServiceName: string): TBaseCoreService;
var
  I: Integer;
begin
  result := nil;
  for I := 0 to ServiceList.Count -1 do begin
    if SameText(TBaseCoreService(ServiceList[I]).ServiceName, ServiceName) then begin
      result := TBaseCoreService(ServiceList[I]);
      break;
    end;
  end;
end;

procedure TCoreEDI.Log(msg: string; aType: string);
begin
  if Assigned(fOnLog) then
    fOnLog(msg, aType);
end;

procedure TCoreEDI.SetConnected(const Value: boolean);
begin
  if fConnected = Value then exit;
  if Value then
    Connect
  else begin
    wsClient.Disconnect();
    fConnected := false;
  end;
end;

procedure TCoreEDI.Write(const aService, data: string);
var
  json: TJsonObject;
begin
  json := JO;
  try
    json.S['Service'] := aService;
    json.B['Wait'] := false;
    json.S['Data'] := data;
    wsClient.WriteData(json.AsString);
  finally
    json.Free;
  end;
end;

function TCoreEDI.WriteAndWait(const aService, data: string;
  const aTimeout: integer): string;
var
  json: TJsonObject;
begin
  json := JO;
  try
    json.S['Service'] := aService;
    json.B['Wait'] := true;
    json.S['Data'] := data;
    result := wsClient.WriteAndWaitData(json.AsString, aTimeout);
  finally
    json.Free;
  end;
end;

procedure TCoreEDI.wsClientConnect(Connection: TsgcWSConnection);
begin
  fConnected := true;
//  Log('Connected','Info');
end;

procedure TCoreEDI.wsClientDisconnect(Connection: TsgcWSConnection;
  Code: Integer);
begin
  fConnected := false;
//  Log('Disconnected','Info');
end;

procedure TCoreEDI.wsClientException(Connection: TsgcWSConnection;
  E: Exception);
begin
//  Log('Exception Class: ' + E.ClassName);
  try
    Log('Exception: ' + E.Message, 'Error');
  except

  end;
end;

procedure TCoreEDI.wsClientHandshake(Connection: TsgcWSConnection;
  var Headers: TStringList);
begin
//  Log('Handshake:' + #13#10 + Headers.Text, 'Info');
end;

procedure TCoreEDI.wsClientMessage(Connection: TsgcWSConnection;
  const Text: string);
begin
//  Log(Text);
end;

procedure TCoreEDI.wsServerError(Connection: TsgcWSConnection;
  const Error: string);
begin
  try
    if Assigned(Connection) then
      Log('Error: ' + Error, 'Error');
  except

  end;
end;

end.
