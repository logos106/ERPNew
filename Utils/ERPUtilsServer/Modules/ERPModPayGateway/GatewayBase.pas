unit GatewayBase;

interface

uses
  IdHTTP, LogThreadBase, LogMessageTypes, CreditCardObj, JSONObject;

type

  TBaseGateway = class
  private
    fOnLogEvent: TOnLogEvent;
    fTestMode: boolean;
  protected
    function NewNTTPClient: TidHTTP; virtual;
    procedure Log(const msg: string; const LogMessageType: TLogMessageType = ltBlank);
    function GetCard(JsonIn: TJsonObject): TCreditCard;
  public
    constructor Craeate;
    destructor Destroy; override;
    property OnLogEvent: TOnLogEvent read fOnLogEvent write fOnLogEvent;
    property TestMode: boolean read fTestMode write fTestMode;
//    function ChargeCard(JsonIn, JsonOut: TJSONObject): boolean; virtual;
  end;

implementation

uses
  IdSSLOpenSSL, DbGen,
  {$IfDef VER220}
  Sysutils,
  {$Else}
  System.Sysutils,
  {$EndIf}
  EncryptFix, JsonToObject;

{ TGatewayBase }

function TBaseGateway.GetCard(JsonIn: TJsonObject): TCreditCard;
var
  svr: string;
  msg: string;
begin
  result := TCreditCard.Create;
  if JsonIn.ObjectExists('Card') then
    JsonToObj(JsonIn.O['Card'],result)
  else begin
    if JsonIn.IntegerExists('ClientID') and JsonIn.StringExists('Database') then begin
      svr := '127.0.0.1';
      if JsonIn.StringExists('Server') then
        svr := JsonIn.S['Server'];
      result.LoadFromErpClient(JsonIn.I['ClientID'],JsonIn.S['Database'],svr,msg);
    end;
  end;
end;

//function TBaseGateway.ChargeCard(JsonIn, JsonOut: TJSONObject): boolean;
//begin
//
//end;

constructor TBaseGateway.Craeate;
begin
  fTestMode := false;
end;

destructor TBaseGateway.Destroy;
begin

  inherited;
end;

procedure TBaseGateway.Log(const msg: string;
  const LogMessageType: TLogMessageType);
begin
  if Assigned(fOnLogEvent) then
    fOnLogEvent(msg, LogMessageType);
end;

function TBaseGateway.NewNTTPClient: TidHTTP;
var
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
begin
  result := TIdHTTP.Create(nil);
  result.Request.BasicAuthentication := true;
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(result);
  result.IOHandler := SSLHandler;
  SSLHandler.SSLOptions.SSLVersions := [sslvTLSv1_2];
  result.Request.ContentType := 'application/json';
  result.Request.CharSet := 'utf-8';
end;

end.
