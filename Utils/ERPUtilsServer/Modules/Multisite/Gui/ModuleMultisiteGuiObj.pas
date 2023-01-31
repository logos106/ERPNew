unit ModuleMultisiteGuiObj;

interface

uses
  ModuleBaseClientObj, forms, MultisiteConst, MultisiteConfigObj,
  JsonRpcBase, JsonObject;

type
  TModuleMultisiteGui = class(TModuleBaseClient)
  private
    fStatus: TMultisiteStatus;
    fSiteConfig: TServerConfig;
    fUpdatingModule: boolean;
    procedure SetStatus(const Value: TMultisiteStatus);
    procedure DoServerConfigOnChange(Sender: TObject);
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
    property SiteConfig: TServerConfig read fSiteConfig;
    property Status: TMultisiteStatus read fStatus write SetStatus;
  end;

  function GetModule(MainAppInst: TApplication): TModuleBaseClient;

implementation

uses
  frmMultisiteConfigGui, ModuleBaseObj, JsonToObject, sysutils;

var
  fModuleMultisiteGui: TModuleMultisiteGui;



function GetModule(MainAppInst: TApplication): TModuleBaseClient;
begin
  fModuleMultisiteGui.AppInst:= MainAppInst;
  result:= fModuleMultisiteGui;
end;


{ TModuleMultisiteGui }

constructor TModuleMultisiteGui.Create;
begin
  inherited;
  ServerModuleClassName:= 'TModuleMultisite';
  fUpdatingModule:= false;
  fSiteConfig:= TServerConfig.Create;
  fSiteConfig.OnChange:= self.DoServerConfigOnChange;
end;

destructor TModuleMultisiteGui.Destroy;
begin
  inherited;
  fSiteConfig.Free;
end;

procedure TModuleMultisiteGui.DoChange;
var
  o: TJsonObject;
begin
  inherited;
  if self.UpdatingModule or (not Connected) then
    exit;

  {  GUI form has update properties ... send to server }
  o:= JO('{"classname":"'+ServerModuleClassName+'"}');
  ObjToJson(self,o.O['object']);
  Client.SendNotification('Multisite.setobject',O);

  Sleep(100);
  Application.ProcessMessages;

  { read back the congig from server }
  GetServer;
end;

procedure TModuleMultisiteGui.DoRequest(Client: TJsonRpcBase; RequestJson,
  ResponseJson: TJsonObject);
var
  method, eventname, value: string;
  form: TfmMultisiteConfigGui;
begin
  form:= TfmMultisiteConfigGui(self.GuiForm);
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

procedure TModuleMultisiteGui.DoServerConfigOnChange(Sender: TObject);
begin
  self.DoChange;
end;

function TModuleMultisiteGui.GetGuiForm: TForm;
begin
  if not Assigned(fGuiForm) then begin
    fGuiForm:= TfmMultisiteConfigGui.Create(Application);
    TfmMultisiteConfigGui(fGuiForm).Module:= self;
    TfmMultisiteConfigGui(fGuiForm).lblTitle.Caption:= self.ModuleName;
    fGuiForm.OnDestroy:= self.DoGuiFormDestroy;
  end;
  result:= fGuiForm;
end;

procedure TModuleMultisiteGui.GetServer;
var
  o, resp: TJsonObject;
  form: TfmMultisiteConfigGui;
begin
  form:= TfmMultisiteConfigGui(self.GuiForm);
  o:= JO('{"classname":"'+ServerModuleClassName+'"}');
  resp:= Client.SendRequest('Multisite.getobject',O);
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

procedure TModuleMultisiteGui.SetActive(const Value: boolean);
begin
  if fActive <> Value then begin
    fActive:= Value;
    if fActive then begin
      if not (fStatus in [msActive, msStarting, msRestarting]) then
        fStatus:= msStarting;
    end
    else begin
      if not (fStatus in [msInactive, msStopping]) then
        fStatus:= msStopping;
    end;
    DoChange;
  end;
end;

procedure TModuleMultisiteGui.SetConnected(const Value: boolean);
begin
  inherited;
  if Client.Connected then
    GetServer;
end;

procedure TModuleMultisiteGui.SetStatus(const Value: TMultisiteStatus);
begin
  if fStatus <> Value then begin
    fStatus := Value;
    case fStatus of
      msInactive: fActive:= false;
      msActive: fActive:= true;
      msStarting: fActive:= true;
      msStopping: fActive:= false;
      msRestarting: fActive:= true;
    end;
    DoChange;
  end;
end;

initialization
  if not Assigned(fModuleMultisiteGui) then
    fModuleMultisiteGui:= TModuleMultisiteGui.Create;


finalization
  fModuleMultisiteGui.Free;
  fModuleMultisiteGui:= nil;

end.
