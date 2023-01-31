unit fraUtilsServerConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fraUtilsConfigBase, UserUtilsClientObj, StdCtrls, ExtCtrls, ComCtrls,
  wwclearbuttongroup, wwradiogroup, DNMSpeedButton, Grids, AdvObj, BaseGrid,
  AdvGrid, JsonObject, DB, DBAccess, MyAccess, ERPdbComponents, MemDS, Wwdbigrd,
  Wwdbgrid;

type
  TfrUtilsServerConfig = class(TfrUtilsConfigBase)
    Bevel1: TBevel;
    Label9: TLabel;
    lblServerVersion: TLabel;
    lvModules: TListView;
    lblSiteIntegrationVersion: TLabel;
    dtUpdateCheckTime: TDateTimePicker;
    Label1: TLabel;
    rgLoggingLevel: TwwRadioGroup;
    btnShowLog: TDNMSpeedButton;
    btnCommsTest: TDNMSpeedButton;
    btnLogFile: TDNMSpeedButton;
    Label5: TLabel;
    tmrServerTasks: TTimer;
    grdTaskList: TwwDBGrid;
    qryTaskList: TERPQuery;
    conTaskList: TERPConnection;
    dsTaskList: TDataSource;
    qryTaskListModuleName: TWideStringField;
    qryTaskListTaskName: TWideStringField;
    qryTaskListStatusMessage: TWideStringField;
    qryTaskListStartTime: TDateTimeField;
    qryTaskListID: TIntegerField;
    qryTaskListTaskId: TWideStringField;
    qryTaskListComplete: TWideStringField;
    procedure dtUpdateCheckTimeExit(Sender: TObject);
    procedure rgLoggingLevelClick(Sender: TObject);
    procedure btnShowLogClick(Sender: TObject);
    procedure btnCommsTestClick(Sender: TObject);
    procedure btnLogFileClick(Sender: TObject);
    procedure tmrServerTasksTimer(Sender: TObject);
  private
    procedure TaskListEventHandler(Sender: TObject; const Event, Value : string);
  protected
    function GetModuleName: string; override;
    procedure SetUtilsClient(const Value: TUserUtilsClient); override;
    procedure AfterGetModuleConfig; override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  frUtilsServerConfig: TfrUtilsServerConfig;

implementation

{$R *.dfm}

uses
  LogMessageTypes, Vista_MessageDlg, frmERPCommsTestSteps, ShellAPI,
  InstallConst;

const
  Col_TaskID = 0;
  Col_ModuleName = 1;
  Col_TaskName = 2;
  Col_TaskStatus = 3;
  Col_Started = 4;
  Col_RunTime = 5;

{ TfrUtilsServerConfig }

procedure TfrUtilsServerConfig.AfterGetModuleConfig;
var
  j: TJsonObject;
  itm: TListItem;
  x: integer;
begin
  lvModules.Clear;
  lblServerVersion.Caption := 'Server Version: ' + Config.S['Version'];
  dtUpdateCheckTime.Time := Config.F['NextUpdateCheckTime'];
  rgLoggingLevel.ItemIndex := Ord(StrToLoggingLevel(Config.S['LoggingLevel']));

  j := JO;
  try
    if UtilsClient.GetModuleList(j.A['modules']) then begin
      for x := 0 to j.A['modules'].Count -1 do begin
        itm:= lvModules.Items.Add;
        itm.Caption := j.A['modules'].Items[x].AsObject.S['ModuleName'];
        itm.SubItems.Add(j.A['modules'].Items[x].AsObject.S['ModuleVersion']);
        itm.SubItems.Add(j.A['modules'].Items[x].AsObject.S['ModuleDescription']);
      end;
    end;
  finally
    j.Free;
  end;
end;

procedure TfrUtilsServerConfig.btnCommsTestClick(Sender: TObject);
var
  form: TfmERPCommsTestSteps;
begin
  inherited;
  form := TfmERPCommsTestSteps.Create(Application);
//  form.ERPServer := self.UtilsClient.Client.ServerName; //
  form.Show;
end;

procedure TfrUtilsServerConfig.btnLogFileClick(Sender: TObject);
var
  fileName: string;
begin
  inherited;
  fileName := ERP_UTILITIES_LOG_DIR  + 'ERPUtilsService_' + FormatDateTime('yyyy_mm_dd',now) + '.log';
  if FileExists(fileName) then
    ShellExecute(0,'open',PChar(fileName),nil,nil,SW_NORMAL)
  else
    MessageDlgXP_Vista('Log file not found.', mtInformation, [mbOK], 0);
end;

procedure TfrUtilsServerConfig.btnShowLogClick(Sender: TObject);
begin
  inherited;
  ShowLog;
end;

constructor TfrUtilsServerConfig.Create(aOwner: TComponent);
begin
  inherited;
end;

destructor TfrUtilsServerConfig.Destroy;
begin
//  UtilsClient.Events.RemoveMultiEvent(TaskListEventHandler);
  inherited;
end;

procedure TfrUtilsServerConfig.dtUpdateCheckTimeExit(Sender: TObject);
begin
  inherited;
  if not UtilsClient.Connected then exit;

  if dtUpdateCheckTime.Time <> Config.F['NextUpdateCheckTime'] then begin
    try
      Config.F['NextUpdateCheckTime'] := dtUpdateCheckTime.Time;
    Except
      on E:Exception do begin
        {Binny : in my machine this was saved as String , instead of Flost. That created an exception.
                 So incase of exception, delete the node and recreate as Float, as the old value is not required  }
        Config.Delete('NextUpdateCheckTime');
        Config.F['NextUpdateCheckTime'] := dtUpdateCheckTime.Time;
      end;
    end;
    if not self.VerifyAndSetModuleConfig then
      MessageDlgXP_Vista('Error sending configuration changes to server.',mtInformation,[mbOk],0);
  end;
end;

function TfrUtilsServerConfig.GetModuleName: string;
begin
  result := ''; { blank for server }
end;

procedure TfrUtilsServerConfig.rgLoggingLevelClick(Sender: TObject);
begin
  inherited;
  if Loading then exit;
  Config.S['LoggingLevel'] := LoggingLevelToStr(TLoggingLevel(rgLoggingLevel.ItemIndex));
    if not self.VerifyAndSetModuleConfig then
      MessageDlgXP_Vista('Error sending configuration changes to server.',mtInformation,[mbOk],0);
end;

procedure TfrUtilsServerConfig.SetUtilsClient(const Value: TUserUtilsClient);
begin
  inherited;
  UtilsClient.Events.AddMultiEvent(TaskListEventHandler);
  conTaskList.Server := Value.Client.ServerName;
  conTaskList.Connect;
  qryTaskList.Open;
end;

procedure TfrUtilsServerConfig.TaskListEventHandler(Sender: TObject;
  const Event, Value: string);
begin
  if tmrServerTasks.Interval > 1000 then begin

    tmrServerTasks.Enabled := false;
    try
  //    if qryTaskList.Active then
  //      qryTaskList.Refresh;
  //    Application.ProcessMessages;
      tmrServerTasks.Interval := 1000;
    finally
      tmrServerTasks.Enabled := true;
    end;
  end;
end;

procedure TfrUtilsServerConfig.tmrServerTasksTimer(Sender: TObject);
begin
  inherited;
  TTimer(Sender).Enabled := false;
  try
    if qryTaskList.Active then
      qryTaskList.Refresh;
    Application.ProcessMessages;
  finally
    TTimer(Sender).Interval := 2000;
    TTimer(Sender).Enabled := true;
  end;
end;

end.
