unit ModuleClientServerGuiObj;

interface
uses
  ModuleBaseClientObj, forms, 
  JsonRpcBase, JsonObject;

type
  TModuleClientServerGui = class(TModuleBaseClient)
  private
    fUpdatingModule: boolean;
//    FERPServerName: string;
//    FERPDatabaseName: string;
    FClientServerName: string;
//    procedure DoServerConfigOnChange(Sender: TObject);
    procedure GetServer;
  protected
    function GetGuiForm: TForm; override;
    procedure DoChange; override;
    property UpdatingModule: boolean read fUpdatingModule write fUpdatingModule;
    procedure SetConnected(const Value: boolean); override;
    procedure SetActive(const Value: boolean); override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure DoRequest(Client: TJsonRpcBase; RequestJson: TJsonObject;
      ResponseJson: TJsonObject = nil); override;
  published
//    property ERPServerName: string read FERPServerName write FERPServerName;
//    property ERPDatabaseName: string read FERPDatabaseName write FERPDatabaseName;
    property ClientServerName: string read FClientServerName write FClientServerName;
  end;

  function GetModule(MainAppInst: TApplication): TModuleBaseClient;

implementation

uses
  frmClientServerConfigGui, ModuleBaseObj, JsonToObject, sysutils;

var
  fModuleClientServerGui: TModuleClientServerGui;



function GetModule(MainAppInst: TApplication): TModuleBaseClient;
begin
  fModuleClientServerGui.AppInst:= MainAppInst;
  result:= fModuleClientServerGui;
end;


{ TModuleMultisiteGui }

constructor TModuleClientServerGui.Create;
begin
  inherited;
  ServerModuleClassName:= 'TModuleClientServer';
  fUpdatingModule:= false;
end;

destructor TModuleClientServerGui.Destroy;
begin

  inherited;
end;

procedure TModuleClientServerGui.DoChange;
var
  o: TJsonObject;
begin
  inherited;
  if self.UpdatingModule or (not Connected) then
    exit;

  {  GUI form has update properties ... send to server }
  o:= JO('{"classname":"'+ServerModuleClassName+'"}');
  ObjToJson(self,o.O['object']);
  Client.SendNotification('ClientServer.setobject',O);

  Sleep(100);
  Application.ProcessMessages;

  { read back the congig from server }
  GetServer;
end;

procedure TModuleClientServerGui.DoRequest(Client: TJsonRpcBase; RequestJson,
  ResponseJson: TJsonObject);
var
  method, eventname, value: string;
  form: TfmClientServerConfigGui;
begin
  form:= TfmClientServerConfigGui(self.GuiForm);
  method:= RequestJson.S['method'];
  if method = 'event' then begin
    eventname:= RequestJson.O['params'].S['eventname'];
    if eventname = 'Log' then begin
      value:= RequestJson.O['params'].S['value'];
      form.Log(value);
    end
    else if (eventname = 'onchange') and (RequestJson.O['params'].S['senderclassname'] = ServerModuleClassName) then begin
      GetServer;
    end
    else if eventname = 'Status' then begin
      value:= RequestJson.O['params'].S['value'];
      form.sbStatus.Panels[1].Text:= ' ' + Value;
    end;
  end
  else begin
    form.Log('Unknown method: ' + method);

  end;
end;

//procedure TModuleClientServerGui.DoServerConfigOnChange(Sender: TObject);
//begin
//  self.DoChange;
//end;

function TModuleClientServerGui.GetGuiForm: TForm;
begin
  if not Assigned(fGuiForm) then begin
    fGuiForm:= TfmClientServerConfigGui.Create(nil);
    TfmClientServerConfigGui(fGuiForm).Module:= self;
    TfmClientServerConfigGui(fGuiForm).lblTitle.Caption:= 'Client Server'; //self.ModuleName;
    fGuiForm.OnDestroy:= self.DoGuiFormDestroy;
  end;
  result:= fGuiForm;
end;

procedure TModuleClientServerGui.GetServer;
var
  o, resp: TJsonObject;
  form: TfmClientServerConfigGui;
begin
  form:= TfmClientServerConfigGui(self.GuiForm);
  o:= JO('{"classname":"'+ServerModuleClassName+'"}');
  resp:= Client.SendRequest('ClientServer.getobject',O);
  try
    if Assigned(resp) then begin
      if resp.Exists('result') then begin
        if resp.O['result'].S['classname'] = ServerModuleClassName then begin
          self.UpdatingModule:= true;
          try
            JsonToObj(resp.O['result'].O['object'], self);
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

procedure TModuleClientServerGui.SetActive(const Value: boolean);
begin
  if fActive <> Value then begin
    fActive:= Value;
    DoChange;
  end;
end;

procedure TModuleClientServerGui.SetConnected(const Value: boolean);
begin
  inherited;
  if Client.Connected then
    GetServer;
end;

initialization
  if not Assigned(fModuleClientServerGui) then
    fModuleClientServerGui:= TModuleClientServerGui.Create;


finalization
  fModuleClientServerGui.Free;
  fModuleClientServerGui:= nil;

end.
