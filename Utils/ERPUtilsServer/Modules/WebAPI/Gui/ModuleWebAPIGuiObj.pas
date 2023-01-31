unit ModuleWebAPIGuiObj;

interface
uses
  ModuleBaseClientObj, forms, MultisiteConst, MultisiteConfigObj,
  JsonRpcBase, JsonObject, HTTPServerConfigObj;

type
  TModuleWebAPIGui = class(TModuleBaseClient)
  private
//    fDefaultPort: integer;
//    fMaxConnections: integer;
//    fWebUserName: string;
//    fConfigExists: boolean;
//    fDefaultSSLPort: integer;
//    fUseSSL: boolean;
    fUpdatingModule: boolean;
    procedure Log(msg: string);
    procedure GetServer;
//    procedure SetDefaultPort(const Value: integer);
//    procedure SetDefaultSSLPort(const Value: integer);
//    procedure SetMaxConnections(const Value: integer);
//    procedure SetUseSSL(const Value: boolean);
//    procedure SetWebUserName(const Value: string);
    procedure DoOnHTTPServerConfigChange(Sender: TObject);
  protected
    function GetGuiForm: TForm; override;
    procedure DoChange; override;
    procedure SetConnected(const Value: boolean); override;
  public
    HTTPServerConfig: THTTPServerConfig;
    constructor Create; override;
    destructor Destroy; override;
    procedure DoRequest(Client: TJsonRpcBase; RequestJson: TJsonObject;
      ResponseJson: TJsonObject = nil); override;
    property UpdatingModule: boolean read fUpdatingModule write fUpdatingModule;
  published
//     property DefaultPort: integer read fDefaultPort write SetDefaultPort;
//     property DefaultSSLPort: integer read fDefaultSSLPort write SetDefaultSSLPort;
//     property MaxConnections: integer read fMaxConnections write SetMaxConnections;
//     property UseSSL: boolean read fUseSSL write SetUseSSL;
//     property WebUserName: string read fWebUserName write SetWebUserName;
//     property ConfigExists: boolean read fConfigExists write fConfigExists;
  end;

  function GetModule(MainAppInst: TApplication): TModuleBaseClient;

implementation

uses
  frmWebAPIConfigGui, ModuleBaseObj, JsonToObject, sysutils;

var
  fModuleWebAPIGui: TModuleWebAPIGui;



function GetModule(MainAppInst: TApplication): TModuleBaseClient;
begin
  fModuleWebAPIGui.AppInst:= MainAppInst;
  result:= fModuleWebAPIGui;
end;

{ TModuleWebAPIGui }

constructor TModuleWebAPIGui.Create;
begin
  inherited;
  ServerModuleClassName:= 'TModuleWebAPI';
  fUpdatingModule:= false;
  HTTPServerConfig:= THTTPServerConfig.Create;
  HTTPServerConfig.OnChange:=  DoOnHTTPServerConfigChange;
end;

destructor TModuleWebAPIGui.Destroy;
begin
  HTTPServerConfig.Free;
  inherited;
end;

procedure TModuleWebAPIGui.DoChange;
var
  o: TJsonObject;
begin
  inherited;
  if self.UpdatingModule or (not Connected) then
    exit;

  {  GUI form has update properties ... send to server }
  o:= JO('{"classname":"THTTPServerConfig"}');
  ObjToJson(HTTPServerConfig,o.O['object']);
  Client.SendNotification('setobject',O);

  Sleep(100);
  Application.ProcessMessages;

  { read back the congig from server }
  GetServer;
end;

procedure TModuleWebAPIGui.DoOnHTTPServerConfigChange(Sender: TObject);
begin
  DoChange;
end;

procedure TModuleWebAPIGui.DoRequest(Client: TJsonRpcBase; RequestJson,
  ResponseJson: TJsonObject);
var
  method, eventname, value: string;
begin
  method:= RequestJson.S['method'];
  if method = 'event' then begin
    eventname:= RequestJson.O['params'].S['eventname'];
    if eventname = 'Log' then begin
      value:= RequestJson.O['params'].S['value'];
      Log(value);
    end
    else if (eventname = 'onchange') then begin
//      if (RequestJson.O['params'].S['senderclassname'] = ServerModuleClassName) then begin
      if (RequestJson.O['params'].S['value'] = 'THTTPServerConfig') then begin
        GetServer;
      end
      else begin

      end;
    end;
  end
  else begin
    Log('Unknown method: ' + method);

  end;
end;

function TModuleWebAPIGui.GetGuiForm: TForm;
begin
  if not Assigned(fGuiForm) then begin
    fGuiForm:= TfmWebAPIConfigGui.Create(nil);
    TfmWebAPIConfigGui(fGuiForm).Module:= self;
    TfmWebAPIConfigGui(fGuiForm).lblTitle.Caption:= 'Web API'; //self.ModuleName;
    fGuiForm.OnDestroy:= self.DoGuiFormDestroy;
  end;
  result:= fGuiForm;
end;

procedure TModuleWebAPIGui.GetServer;
var
  o, resp: TJsonObject;
  form: TfmWebAPIConfigGui;
begin
  form:= TfmWebAPIConfigGui(self.GuiForm);
  o:= JO('{"classname":"THTTPServerConfig"}');
  resp:= Client.SendRequest('getobject',O);
  try
    if Assigned(resp) then begin
      if resp.Exists('result') then begin
        if resp.O['result'].S['classname'] = 'THTTPServerConfig' then begin
          self.UpdatingModule:= true;
          try
            JsonToObj(resp.O['result'].O['object'], HTTPServerConfig);
            form.DoOnModuleChange;
          finally
            self.UpdatingModule:= false;
          end;
        end;
      end;
    end;
  finally
    resp.Free;
  end;
end;

procedure TModuleWebAPIGui.Log(msg: string);
begin
  TfmWebAPIConfigGui(fGuiForm).Log(msg);
end;

procedure TModuleWebAPIGui.SetConnected(const Value: boolean);
begin
  inherited;
  if Client.Connected then
    GetServer;
end;

//procedure TModuleWebAPIGui.SetDefaultPort(const Value: integer);
//begin
//  if fDefaultPort <> Value then begin
//    fDefaultPort := Value;
//    DoChange
//  end;
//end;
//
//procedure TModuleWebAPIGui.SetDefaultSSLPort(const Value: integer);
//begin
//  if fDefaultSSLPort <> Value then begin
//    fDefaultSSLPort := Value;
//    DoChange
//  end;
//end;
//
//procedure TModuleWebAPIGui.SetMaxConnections(const Value: integer);
//begin
//  if fMaxConnections <> Value then begin
//    fMaxConnections := Value;
//    DoChange;
//  end;
//end;
//
//procedure TModuleWebAPIGui.SetUseSSL(const Value: boolean);
//begin
//  if fUseSSL <> Value then begin
//    fUseSSL := Value;
//    DoChange;
//  end;
//end;
//
//procedure TModuleWebAPIGui.SetWebUserName(const Value: string);
//begin
//  if fWebUserName <> Value then begin
//    fWebUserName := Value;
//    DoChange;
//  end;
//end;

initialization
  if not Assigned(fModuleWebAPIGui) then
    fModuleWebAPIGui:= TModuleWebAPIGui.Create;


finalization
  fModuleWebAPIGui.Free;
  fModuleWebAPIGui:= nil;

end.
