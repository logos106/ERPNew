unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmSvcGuiBase, ActnList, Menus, CoolTrayIcon, ComCtrls,
  DNMSpeedButton, ServiceGuiCommon, StdCtrls, AdvOfficeStatusBar, AdvMenus;

type
  TfmMain = class(TfmSvcGuiBase)
    btnLog: TDNMSpeedButton;
    btnStartServer: TDNMSpeedButton;
    lblSessionCount: TLabel;
    actConfig: TAction;
    btnConfig: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnStartServerClick(Sender: TObject);
    procedure actConfigExecute(Sender: TObject);
  private
    fXMLServerActive: boolean;
    fCaption: string;
    procedure DoOnReceiveMessage(msg: TRemoteMessageItem);
    procedure Log(const msg: string);
    procedure UpdateServerStatus(const ServerActive: boolean);
    procedure UpdateSessionCount;
  protected
    procedure DoOnConnect(Sender: TObject); override;
    procedure DoOnDisconnect(Sender: TObject); override;
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

uses
  AppVarsObj, ControlPortsConst, frmLog, XMLServerControlConst, frmConfig;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  inherited;
  fCaption:= Caption;
  fXMLServerActive:= false;
  AppVars.SetDefault('ServerIP','127.0.0.1');
  AppVars.SetDefault('ServerPort',XMLServerControlPort);
  Client.OnReceiveMessage:= DoOnReceiveMessage;
  Client.Active:= true;
end;

procedure TfmMain.DoOnReceiveMessage(msg: TRemoteMessageItem);
begin
//  Log('Message: ' + #13#10 +  msg.XML);
  if msg.Values['command'] = CommandLog then begin
    Log(msg.Values['value']);
  end
  else if msg.Values['command'] = CommandEvent then begin
    if msg.Values['event'] = 'eventActive' then begin
      UpdateServerStatus(msg.Values['value'] = 'true');
    end
    else if (msg.Values['event'] = eventThreadAdded) or (msg.Values['event'] = eventThreadRemoved) then begin
      UpdateSessionCount;
    end;
  end
  else begin
    Log('Unhandled message: ' + msg.XML);
  end;
  msg.Status:= msDelete;
end;

procedure TfmMain.Log(const msg: string);
begin
  if TfmLog.Inst.LogOpen then
    TfmLog.Inst.Log(msg);
end;

procedure TfmMain.UpdateServerStatus(const ServerActive: boolean);
begin
  fXMLServerActive:= ServerActive;
  if fXMLServerActive then begin
    StatusBar.Panels[1].Text:= 'XML Server - Running';
    btnStartServer.Caption:= 'Stop Server';
  end
  else begin
    StatusBar.Panels[1].Text:= 'XML Server - Stopped';
    btnStartServer.Caption:= 'Start Server';
  end;
  UpdateSessionCount;
end;

procedure TfmMain.btnStartServerClick(Sender: TObject);
begin
  inherited;
  try
    if fXMLServerActive then
      Client.RemotePropertyStr['Active']:= 'False'
    else
      Client.RemotePropertyStr['Active']:= 'True';
  except
  end;
end;

procedure TfmMain.UpdateSessionCount;
begin
  try
    lblSessionCount.Caption:= 'Active Session Count: ' + Client.RemotePropertyStr['SessionCount'];
  except
  end;
end;

procedure TfmMain.actConfigExecute(Sender: TObject);
begin
  inherited;
  frmConfig.DoConfig(Client);
end;

procedure TfmMain.DoOnConnect(Sender: TObject);
begin
  inherited;
  try
    UpdateServerStatus(Client.RemotePropertyStr['Active'] = 'True');
  except
  end;
end;

procedure TfmMain.DoOnDisconnect(Sender: TObject);
begin
  inherited;
end;

end.
