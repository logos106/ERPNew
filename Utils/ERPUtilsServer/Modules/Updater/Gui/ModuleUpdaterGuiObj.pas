unit ModuleUpdaterGuiObj;

interface

uses
  ModuleBaseClientObj, forms,
  JsonRpcBase, JsonObject;

type
  TModuleUpdaterGui = class(TModuleBaseClient)
  private
    fUpdatingModule: boolean;
    procedure GetServer;
    function GetConfigText: string;
    procedure SetConfigText(const Value: string);
  protected
    function GetGuiForm: TForm; override;
    procedure DoChange; override;
    property UpdatingModule: boolean read fUpdatingModule write fUpdatingModule;
  public
    Config: TJsonObject;
    constructor Create; override;
    destructor Destroy; override;
    procedure DoRequest(Client: TJsonRpcBase; RequestJson: TJsonObject;
      ResponseJson: TJsonObject = nil); override;
    procedure GetFile(aFileName: string);
  published
    property ConfigText: string read GetConfigText write SetConfigText;
  end;

implementation

uses
  frmUpdaterConfigGui, JsonToObject, classes, ModuleClientUtils, sysutils;


{ TModuleUpdaterGui }

constructor TModuleUpdaterGui.Create;
begin
  inherited;
  Config:= TJsonObject.Create;
  fUpdatingModule:= false;
  ServerModuleClassName:= 'TModuleUpdater';
end;

destructor TModuleUpdaterGui.Destroy;
begin
  Config.Free;
  inherited;
end;

procedure TModuleUpdaterGui.DoChange;
var
  o: TJsonObject;
begin
  inherited;
  if self.UpdatingModule or (not Connected) then
    exit;

  {  GUI form has update properties ... send to server }
  o:= JO('{"classname":"'+ServerModuleClassName+'"}');
  ObjToJson(self,o.O['object']);
  Client.SendNotification('Updater.setobject',O);

  Sleep(100);
//  Application.ProcessMessages;

  { read back the congig from server }
  GetServer;
end;

procedure TModuleUpdaterGui.DoRequest(Client: TJsonRpcBase; RequestJson,
  ResponseJson: TJsonObject);
var
  method, eventname, value: string;
  form: TfmUpdaterConfigGui;
begin
  form:= TfmUpdaterConfigGui(self.GuiForm);
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

function TModuleUpdaterGui.GetConfigText: string;
begin
  result:= Config.AsString;
end;

procedure TModuleUpdaterGui.GetFile(aFileName: string);
var
  msg: string;
const
  DestFileName  = 'c:\temp\erp.exe';
begin
  JsonGetFile('updater',aFileName, DestFileName, Client, nil, msg);

end;

function TModuleUpdaterGui.GetGuiForm: TForm;
begin
  if not Assigned(fGuiForm) then begin
    fGuiForm:= TfmUpdaterConfigGui.Create(nil);
    TfmUpdaterConfigGui(fGuiForm).Module:= self;
    TfmUpdaterConfigGui(fGuiForm).lblTitle.Caption:= self.ModuleName;
    fGuiForm.OnDestroy:= self.DoGuiFormDestroy;
  end;
  result:= fGuiForm;
end;

procedure TModuleUpdaterGui.GetServer;
var
  o, resp: TJsonObject;
  form: TfmUpdaterConfigGui;
begin
  form:= TfmUpdaterConfigGui(self.GuiForm);
  o:= JO('{"classname":"'+ServerModuleClassName+'"}');
  resp:= Client.SendRequest('Updater.getobject',O);
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

procedure TModuleUpdaterGui.SetConfigText(const Value: string);
begin
  Config.AsString:= Value;
  DoChange;
end;

end.
