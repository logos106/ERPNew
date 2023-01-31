unit ModuleBaseClientObj;

interface

uses
  ModuleBaseObj, JsonRpcBase, JSONObject, JsonRpcTcpClient, forms;

type
  TModuleBaseClient = class(TModuleBase)
  private
    fServerConfig: TJsonObject;
    procedure DoOnRequest(Client: TJsonRpcBase; ReqJson: TJSONObject; ResJson: TJSONObject = nil);
    procedure DoOnConnect(Client: TJsonRpcBase);
    procedure DoOnDisconnect(Client: TJsonRpcBase);
    procedure SetServerConfig(const Value: TJsonObject);
    function GetConnected: boolean;
  protected
    Client: TJsonRpcTcpClient;
    fGuiForm: TForm;
    ServerModuleClassName: string;
    function GetGuiForm: TForm; virtual;
    procedure SetConnected(const Value: boolean); virtual;
    procedure DoGuiFormDestroy(Sender: TObject);
  public
    constructor Create; override;
    destructor Destroy; override;
    property ServerConfig: TJsonObject read fServerConfig write SetServerConfig;
    property Connected: boolean read GetConnected write SetConnected;
    property GuiForm: TForm read GetGuiForm;
  published
  end;

implementation

uses
  frmModuleConfigBase;

{ TModuleBaseClient }

constructor TModuleBaseClient.Create;
begin
  inherited;
  fGuiForm:= nil;
  Client:= TJsonRpcTcpClient.Create;
  Client.OnRequest:= DoOnRequest;
  Client.OnConnect:= DoOnConnect;
  Client.OnDisconnect:= DoOnDisconnect;
end;

destructor TModuleBaseClient.Destroy;
begin
  if Assigned(fGuiForm) then begin
    fGuiForm.Close;
  end;
  Connected:= false;
  Client.Free;
  inherited;
end;

procedure TModuleBaseClient.DoGuiFormDestroy(Sender: TObject);
begin
  fGuiForm:= nil;
end;

procedure TModuleBaseClient.DoOnConnect(Client: TJsonRpcBase);
begin
  self.DoConnect(Client);
end;

procedure TModuleBaseClient.DoOnDisconnect(Client: TJsonRpcBase);
begin
  self.DoDisconnect(Client);
end;

procedure TModuleBaseClient.DoOnRequest(Client: TJsonRpcBase; ReqJson,
  ResJson: TJSONObject);
begin
  self.DoRequest(Client,ReqJson,ResJson);
end;

function TModuleBaseClient.GetConnected: boolean;
begin
  result:= Client.Connected;
end;

function TModuleBaseClient.GetGuiForm: TForm;
begin
  result:= nil;
end;

procedure TModuleBaseClient.SetConnected(const Value: boolean);
var
  o, resp: TJsonObject;
begin
  if Value = false then
    Client.Connected:= false
  else begin
    Client.Connected:= false;
    Client.ServerName:= ServerConfig.S['Server'];
    Client.Port:= ServerConfig.I['Port'];
    try
      Client.Connected:= true;
    except
    end;
    if Client.Connected then begin
      o:= JO;
      o.S['sessiontype']:= 'config';
      //o.S['username']:= AppEnv.AppDb.UserName;

      resp:= Client.SendRequest(self.ModuleName + '.StartSession',o);
      if Assigned(resp) then begin
        try
          if resp.StringExists('result') and (resp.S['result'] = 'ok') then begin
            TfmModuleConfigBase(GuiForm).DoOnModuleChange;


          end
          else begin
            { failed to establisg a session }
            Client.Connected:= false;


          end;
        finally
          resp.Free;
        end;
      end
      else begin
        Client.Connected:= false;
      end;
    end;
  end;
end;

procedure TModuleBaseClient.SetServerConfig(const Value: TJsonObject);
begin
  fServerConfig := Value;
end;

end.
