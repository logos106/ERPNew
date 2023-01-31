unit frmSvcGuiBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CoolTrayIcon, StdCtrls,
  datSvcControlClient, ActnList, Menus, ComCtrls, frmBase,
  AdvOfficeStatusBar, AdvMenus;

type
  TfmSvcGuiBase = class(TfmBase)
    TrayIcon: TCoolTrayIcon;
    ActionList: TActionList;
    actClose: TAction;
    actShow: TAction;
    actShowLog: TAction;
    actConfigureControlClient: TAction;
    StatusBar: TAdvOfficeStatusBar;
    popTray: TAdvPopupMenu;
    ShowWindow1: TMenuItem;
    ShowLog1: TMenuItem;
    Close1: TMenuItem;
    procedure TrayIconDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actCloseExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actShowExecute(Sender: TObject);
    procedure actShowLogExecute(Sender: TObject);
    procedure actConfigureControlClientExecute(Sender: TObject);
  private
    fSessionEnding: Boolean;
    fAllowClose: boolean;
    function GetMinimizeOnClose: boolean;
    procedure SetMinimizeOnClose(const Value: boolean);
    procedure WMQueryEndSession(var Message: TMessage); message WM_QUERYENDSESSION;
  protected
    Client: TSvcControlClient;
    procedure UpdateConnectionStatusDisplay;
    procedure DoOnConnect(Sender: TObject); virtual;
    procedure DoOnDisconnect(Sender: TObject); virtual;
  public
    property MinimizeOnClose: boolean read GetMinimizeOnClose write SetMinimizeOnClose;
  end;

var
  fmSvcGuiBase: TfmSvcGuiBase;

implementation

{$R *.dfm}

uses
  AppVarsObj, frmLog, frmSvcGuiConfig;


procedure TfmSvcGuiBase.FormCreate(Sender: TObject);
begin
  fAllowClose:= false;
  AppVars:= TAppVars.Create;
  AppVars.EncryptFile:= true;
  AppVars.SaveOnChange:= true;
  AppVars.LoadFromFile();
  AppVars.SetDefault('MinimizeOnClose','True');

  client:= TSvcControlClient.Create(self);
  Client.OnConnect:= self.DoOnConnect;
  client.OnDisconnect:= self.DoOnDisconnect;
end;

procedure TfmSvcGuiBase.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := (fAllowClose or ((not self.MinimizeOnClose) or fSessionEnding));
  if not CanClose then
  begin
    TrayIcon.HideMainForm;
    TrayIcon.IconVisible := True;
  end;
end;

procedure TfmSvcGuiBase.FormDestroy(Sender: TObject);
begin
  Client.Free;
end;

procedure TfmSvcGuiBase.FormShow(Sender: TObject);
begin
  TrayIcon.HideTaskbarIcon;
  UpdateConnectionStatusDisplay;
end;

procedure TfmSvcGuiBase.TrayIconDblClick(Sender: TObject);
begin
  TrayIcon.ShowMainForm;    // ALWAYS use this method to restore!!!
end;

function TfmSvcGuiBase.GetMinimizeOnClose: boolean;
begin
  result:= AppVars.BoolVar['MinimizeOnClose'];
end;

procedure TfmSvcGuiBase.SetMinimizeOnClose(const Value: boolean);
begin
  AppVars.BoolVar['MinimizeOnClose']:= Value;
end;

procedure TfmSvcGuiBase.WMQueryEndSession(var Message: TMessage);
{ This method is a hack. It intercepts the WM_QUERYENDSESSION message.
  This way we can decide if we want to ignore the "Close to tray" option.
  Otherwise, when selected, the option would make Windows unable to shut down. }
begin
  fSessionEnding := True;
  Message.Result := 1;
end;

procedure TfmSvcGuiBase.actCloseExecute(Sender: TObject);
begin
  fAllowClose:= true;
  Close;
end;

procedure TfmSvcGuiBase.actShowExecute(Sender: TObject);
begin
  TrayIcon.ShowMainForm;    // ALWAYS use this method to restore!!!
end;

procedure TfmSvcGuiBase.UpdateConnectionStatusDisplay;
begin
  if Client.Active then
    StatusBar.Panels[0].Text:= 'Connected'
  else
    StatusBar.Panels[0].Text:= 'Disconnected'
end;

procedure TfmSvcGuiBase.DoOnConnect(Sender: TObject);
begin
  UpdateConnectionStatusDisplay;
end;

procedure TfmSvcGuiBase.DoOnDisconnect(Sender: TObject);
begin
  UpdateConnectionStatusDisplay;
end;

procedure TfmSvcGuiBase.actShowLogExecute(Sender: TObject);
begin
  TfmLog.Inst.Show;
end;

procedure TfmSvcGuiBase.actConfigureControlClientExecute(Sender: TObject);
begin
  frmSvcGuiConfig.DoClientConfig(Client);
end;

end.
