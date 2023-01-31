unit frmConfigMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DNMSpeedButton, ExtCtrls, Menus, ActnList,
  JsonObject, JsonRpcTcpClient, contnrs, ComCtrls, StdCtrls, AdvPageControl,
  Grids, BaseGrid, AdvGrid, JsonRpcBase, ToolWin, ImgList, Shader, DNMPanel,
  Buttons, AdvObj, UtilsServerConfigObj, ProgressDialog;

type
  TfmConfigMain = class(TForm)
    pnlDock: TPanel;
    pnlServer: TPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    lblTitle: TLabel;
    lblServer: TLabel;
    btnClose: TDNMSpeedButton;
    pnlModuleButtons: TPanel;
    btnModule: TSpeedButton;
    pcMain: TAdvPageControl;
    tabModules: TAdvTabSheet;
    tabLog: TAdvTabSheet;
    memLog: TMemo;
    alMain: TActionList;
    actClose: TAction;
    actOk: TAction;
    actApply: TAction;
    actConnect: TAction;
    actDisconnect: TAction;
    grdModules: TAdvStringGrid;
    pnlLogBottom: TPanel;
    Label1: TLabel;
    cboLoggingLevel: TComboBox;
    Label2: TLabel;
    edtNextUpdateCheckTime: TDateTimePicker;
    procedure actCloseExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdModulesResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnModuleClick(Sender: TObject);
    procedure lblServerMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cboLoggingLevelChange(Sender: TObject);
    procedure edtNextUpdateCheckTimeChange(Sender: TObject);
  private
    Config: TJsonObject;
    Client: TJsonRpcTcpClient;
    ModGuiList: TObjectList;
    UtilsServerConfig: TUtilsServerConfig;
    UpdatingUtilsServerConfig: boolean;
    Progress: TProgressDialog;
    function Connect: boolean;
    procedure LoadModules;
    procedure UnloadModules;
    procedure DoOnConnect(aClient: TJsonRpcBase);
    procedure DoOnDisconnect(aClient: TJsonRpcBase);
    procedure DoOnRequest(Client: TJsonRpcBase; ReqJson: TJSONObject; ResJson: TJSONObject = nil);
    procedure Log(msg: string);
    procedure GetUtilsServerConfig;
    procedure DoOnUtilsServerConfigChange(Sender: TObject);
    procedure DoNoConnect;
  public
    { Public declarations }
  end;

var
  fmConfigMain: TfmConfigMain;

implementation

{$R *.dfm}

uses
  frmServerConnect, JsonRpcConst,
  JsonToObject, ModuleUtils, ModuleInfoObj, ModuleBaseClientObj, LogMessageTypes,
  frmModuleConfigBase,
  ModuleMultisiteGuiObj,
  ModuleUpdaterGuiObj,
  ModuleClientServerGuiObj,
  ModuleUserUtilsGuiObj,
  ModuleWebAPIGuiObj;

procedure TfmConfigMain.FormCreate(Sender: TObject);
var
  cfgFile: string;
begin
  inherited;
//  TLogger.Inst.Log('Form Create ----------------------------------------------------------');
  UpdatingUtilsServerConfig:= false;
  Caption:= Caption + '  [' + ModuleUtils.GetFileVersion(Application.ExeName) + ']';
  lblServer.Caption:= 'Not Connected';
  UtilsServerConfig:= TUtilsServerConfig.Create;
  UtilsServerConfig.OnChange:= DoOnUtilsServerConfigChange;
  ModGuiList:= TObjectList.Create;
  cfgFile:= ChangeFileExt(Application.ExeName,'_config.cfg');
  Config:= TJsonObject.Create;
  Config.LoadFromFile(cfgFile);
  if not Config.StringExists('Server') then Config.S['Server']:= 'localhost';
  if not Config.StringExists('Port') then Config.I['Port']:= DEFAULT_TCP_PORT;
  Client:= TJsonRpcTcpClient.Create;
  Client.RequestWaitSecs:= 15;
  Client.OnConnect:= DoOnConnect;
  Client.OnDisconnect:= DoOnDisconnect;
  Client.OnRequest:= DoOnRequest;

  grdModules.Cells[0,0]:= 'Name';
  grdModules.Cells[1,0]:= 'Version';
  grdModules.Cells[2,0]:= 'Description';
end;

procedure TfmConfigMain.FormShow(Sender: TObject);
begin
  inherited;
  Application.ProcessMessages;
  Sleep(100);
  Config.S['Server']:= 'localhost';
  Config.I['Port']:= DEFAULT_TCP_PORT;
  Connect;
end;

procedure TfmConfigMain.GetUtilsServerConfig;
var
  o, resp: TJsonObject;
begin
  if Client.Connected then begin
    o:= JO('{"classname":"TUtilsServerConfig"}');
    resp:= Client.SendRequest('getobject',O);
    try
      if Assigned(resp) then begin
        if resp.Exists('result') then begin
          if resp.O['result'].S['classname'] = 'TUtilsServerConfig' then begin
            UpdatingUtilsServerConfig:= true;
            try
              JsonToObj(resp.O['result'].O['object'], UtilsServerConfig);
              cboLoggingLevel.ItemIndex:= Ord(UtilsServerConfig.LoggingLevel);
              edtNextUpdateCheckTime.Time := UtilsServerConfig.NextUpdateCheckTime;
            finally
              UpdatingUtilsServerConfig:= false;
            end;
          end;
        end;
      end;
    finally
      resp.Free;
    end;
  end;
end;

procedure TfmConfigMain.FormDestroy(Sender: TObject);
begin
  UnloadModules;
  ModGuiList.Free;
  Client.Free;
  Config.SaveToFile(ChangeFileExt(Application.ExeName,'_config.cfg'));
  Config.Free;
  UtilsServerConfig.Free;
  inherited;
end;

procedure TfmConfigMain.actCloseExecute(Sender: TObject);
begin
  Close;
end;

function TfmConfigMain.Connect: boolean;
var
  json: TJsonObject;
begin
  Progress:= TProgressDialog.Create(nil);
  try
    Progress.Caption:= 'Connecting to server ...';
    Progress.TimerUpdate:= true;
    Progress.Execute;
//    TLogger.Inst.Log('Connect Start');
    Client.Connected:= false;
    Client.ServerName:= Config.S['Server'];
    Client.Port:= Config.I['Port'];
    UnloadModules;
    try
      Client.Connected:= true;
      json:= Client.SendRequestRetry('startconfigsession',nil);
      if Assigned(Json) then begin
        try
          if json.StringExists('result') and (json.S['result'] = 'ok') then begin
            { all good }
          end
          else begin
            //MessageDlg('No responce received from ERP Server while trying to connect.', mtInformation, [mbOk],0);
            Client.Connected:= false;
            DoNoConnect;
          end;
        finally
          json.Free;
        end;
      end
      else begin

      end;
    except
      on e: exception do begin
        Progress.Free;
        Progress:= nil;
        MessageDlg('Error while trying to connect to ERP Server: ' + #13#10 + #13#10 +
          e.Message, mtInformation, [mbOk],0);
        Close;
      end
    end;
    result:= Client.Connected;
//    TLogger.Inst.Log('    Connected: ' + BoolToStr(result,true));
//    TLogger.Inst.Log('    Getting server config');
    GetUtilsServerConfig;
//    TLogger.Inst.Log('    Done');
//    TLogger.Inst.Log('    Loading modules');
    LoadModules;
//    TLogger.Inst.Log('    Done');
//    TLogger.Inst.Log('Connect End');
  finally
    Progress.Free;
  end;
end;

{ NOTE
  Icons are from: DevServer/icons/icons-business/BMP/regular/24x24
}

procedure TfmConfigMain.LoadModules;
var
  obj, mdl: TJsonObject;
  x: integer;
  GuiForm: TfmModuleConfigBase;
  Module: TModuleBaseClient;
  btnLeft: integer;
  UserUtilsPanel: TPanel;
begin
//  TLogger.Inst.Log('    Load Modules Start');
  UserUtilsPanel:= nil;
  { get module list from server }
  UnloadModules;
//  TLogger.Inst.Log('    Getting version');
  obj:= Client.SendRequestRetry('getversion',nil);
  if Assigned(obj) then begin
    try
      lblServer.Caption:=
        'Connected To Utilities Server: ' + Client.ServerName +
        ' (Ver ' + obj.S['result'] + ')';

//      TLogger.Inst.Log('    Version: ' + Client.ServerName +
//        ' (Ver ' + obj.S['result'] + ')');
    finally
      obj.Free;
    end;
  end
  else begin
//    TLogger.Inst.Log('    Failed to get version');
    DoNoConnect;
  end;
  obj:= Client.SendRequestRetry('GetModules',nil);
//  TLogger.Inst.Log('    Getting module list');
  if Assigned(obj) and obj.ObjectExists('result') then begin
    try
//      TLogger.Inst.Log('    Done');
//      TLogger.Inst.Log('    Checking module list');
      if obj.O['result'].ObjectExists('ModuleList') then begin
        for x:= 0 to obj.O['result'].O['ModuleList'].A['Items'].Count -1 do begin
          mdl:= TJsonObject(obj.O['result'].O['ModuleList'].A['Items'].Items[x]);

          if x > 0 then
            grdModules.RowCount:= grdModules.RowCount +1;
          grdModules.Cells[0,x+1]:= mdl.O['Module'].S['ModuleName'];
          grdModules.Cells[1,x+1]:= mdl.O['Module'].S['ModuleVersion'];
          grdModules.Cells[2,x+1]:= mdl.O['Module'].S['ModuleDescription'];

          Module:= nil;
          if mdl.O['Module'].S['ModuleName'] = 'Multisite' then
            Module:= TModuleMultisiteGui.Create
//          else if mdl.O['Module'].S['ModuleName'] = 'Updater' then
//            Module:= TModuleUpdaterGui.Create
          else if mdl.O['Module'].S['ModuleName'] = 'ClientServer' then
            Module:= TModuleClientServerGui.Create
          else if mdl.O['Module'].S['ModuleName'] = 'WebAPI' then
            Module:= TModuleWebAPIGui.Create
          else if (mdl.O['Module'].S['ModuleName'] = 'UserUtils') or (mdl.O['Module'].S['ModuleName'] = 'ERPModUserUtils') then begin
            Module:= TModuleUserUtilsGui.Create;
            UserUtilsPanel:= TfmModuleConfigBase(TModuleBaseClient(Module).GuiForm).pnlMain;
          end;


          if Assigned(Module) then begin
//            TLogger.Inst.Log('    Configuring module: ' + Module.ClassName);
            grdModules.Objects[0,x+1]:= Module;
            JsonToObj(mdl.O['Module'] ,Module);
            GuiForm:= TfmModuleConfigBase(TModuleBaseClient(Module).GuiForm);
            if Assigned(GuiForm) then begin
              GuiForm.pnlMain.Parent:= self.pnlDock;
              GuiForm.btnModule.Parent:= self.pnlModuleButtons;
            end;
            TModuleBaseClient(Module).ServerConfig:= Config;
            TModuleBaseClient(Module).Connected:= true;
//            TLogger.Inst.Log('    Done.');
          end;

        end;
        btnLeft:= 0;
        for x:= 0 to pnlModuleButtons.ControlCount -1 do begin
          if pnlModuleButtons.Controls[x] is TSpeedButton then begin
            TSpeedButton(pnlModuleButtons.Controls[x]).Top:= 0;
            TSpeedButton(pnlModuleButtons.Controls[x]).Left:= btnLeft;
            btnLeft:= btnLeft + TSpeedButton(pnlModuleButtons.Controls[x]).Width;
          end;
        end;
        if Assigned(UserUtilsPanel) then
          UserUtilsPanel.BringToFront;
      end;
//      TLogger.Inst.Log('    Done');
    finally
      obj.Free;
    end;
  end
  else begin
//    TLogger.Inst.Log('    Failed to get module list');
    DoNoConnect;
  end;
//  pnlServer.BringToFront;
//  TLogger.Inst.Log('    Load Modules End');
end;

procedure TfmConfigMain.Log(msg: string);
begin
  while memLog.Lines.Count > 1000 do
    memLog.Lines.Delete(0);
  memLog.Lines.Add(msg);
end;

procedure TfmConfigMain.UnloadModules;
var
  x: integer;
begin
  for x:= 1 to grdModules.RowCount -1 do begin
    grdModules.Objects[0,x].Free;
    grdModules.Objects[0,x]:= nil;
  end;
  grdModules.ClearRows(1,grdModules.RowCount-2);
  grdModules.RowCount:= 2;
  for x:= 0 to grdModules.ColCount -1 do
    grdModules.Cells[x,1]:= '';
end;

procedure TfmConfigMain.grdModulesResize(Sender: TObject);
var
  descWidth: integer;
begin
  descWidth:= grdModules.Width - grdModules.ColWidths[0] - grdModules.ColWidths[1];
  if descWidth < 20 then
    descWidth:= 20;
  grdModules.ColWidths[2]:= descWidth;
end;

procedure TfmConfigMain.FormResize(Sender: TObject);
begin
  self.Invalidate;
end;

procedure TfmConfigMain.DoNoConnect;
begin
  if Assigned(Progress) then begin
    Progress.Free;
    Progress:= nil;
  end;
  MessageDlg('Unable to connect to the ERP Server, please try again shortly.', mtInformation, [mbOk],0);
  Close;
end;

procedure TfmConfigMain.DoOnConnect(aClient: TJsonRpcBase);
begin
  lblServer.Caption:= 'Connected To Utilities Server: ' + Client.ServerName;
end;

procedure TfmConfigMain.DoOnDisconnect(aClient: TJsonRpcBase);
begin
  lblServer.Caption:= 'Not Connected';
  UnloadModules;
  pnlServer.BringToFront;
  memLog.Clear;
end;

procedure TfmConfigMain.DoOnRequest(Client: TJsonRpcBase; ReqJson,
  ResJson: TJSONObject);
var
  method, eventname, value: string;
begin
  method:= ReqJson.S['method'];
  if method = 'event' then begin
    eventname:= ReqJson.O['params'].S['eventname'];
    if eventname = 'Log' then begin
      value:= ReqJson.O['params'].S['value'];
      Log(value);
    end
    else if (eventname = 'onchange') then begin
      if ReqJson.O['params'].S['value'] = 'TUtilsServerConfig' then begin
        GetUtilsServerConfig;
      end;

//      if (RequestJson.O['params'].S['senderclassname'] = ServerModuleClassName) then begin
//      if (ReqJson.O['params'].S['value'] = 'THTTPServerConfig') then begin
//        GetServer;
//      end
//      else begin
//
//      end;
    end
    else
      Log('Unknown event type: ' + eventname);

  end
  else begin
    Log('Unknown method: ' + method);

  end;
end;

procedure TfmConfigMain.DoOnUtilsServerConfigChange(Sender: TObject);
var
  o: TJsonObject;
begin
  if UpdatingUtilsServerConfig then exit;
  if Client.Connected then begin
    o:= JO('{"classname":"TUtilsServerConfig"}');
    ObjToJson(UtilsServerConfig,o.O['object']);
    Client.SendNotification('setobject',O);
  end;
end;

procedure TfmConfigMain.edtNextUpdateCheckTimeChange(Sender: TObject);
begin
  if (Trunc(now) + Frac(edtNextUpdateCheckTime.Time)) > now then
    UtilsServerConfig.NextUpdateCheckTime := (Trunc(now) + Frac(edtNextUpdateCheckTime.Time))
  else
    UtilsServerConfig.NextUpdateCheckTime := (Trunc(now) + 1 + Frac(edtNextUpdateCheckTime.Time));
end;

procedure TfmConfigMain.btnModuleClick(Sender: TObject);
begin
  pnlServer.BringToFront;
end;

procedure TfmConfigMain.cboLoggingLevelChange(Sender: TObject);
begin
  UtilsServerConfig.LoggingLevel:= TLoggingLevel(cboLoggingLevel.ItemIndex);
end;

procedure TfmConfigMain.lblServerMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  aServer: string;
  aPort: integer;
begin
  if ssCtrl in Shift then begin
    aServer:= Config.S['Server'];
    aPort:= Config.I['Port'];
    if GetUserConnectInfo(aServer, aPort) then begin
      Config.S['Server']:= aServer;
      Config.I['Port']:= aPort;
      Connect;
    end;
  end;
end;

end.
