unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Grids, AdvObj, BaseGrid, AdvGrid, StdCtrls, JsonObject,
  APIDataSyncObj, Mask, IdBaseComponent, IdAntiFreezeBase, IdAntiFreeze,
  ExtCtrls, LogMemoObj, ConfigDbObj;

type
  TfmMain = class(TForm)
    sbMain: TStatusBar;
    pcMain: TPageControl;
    tabMain: TTabSheet;
    tabLog: TTabSheet;
    grdSites: TAdvStringGrid;
    btnAddSite: TButton;
    btnDeleteSite: TButton;
    btnStart: TButton;
    btnStop: TButton;
    btnEdit: TButton;
    memLog: TMemo;
    Timer1: TTimer;
    procedure sbMainDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdSitesGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure btnAddSiteClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure grdSitesDblClick(Sender: TObject);
    procedure btnDeleteSiteClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
  private
    Config: TJsonObject;
//    DataSync: TAPIDataSync;
    SyncThread: TAPIDataSyncThread;
    fStatusText: string;
    fLoadingValues: boolean;
    LogMemo: TLogMemo;
    ConfigDb: TConfigDb;
    procedure LoadConfig;
    procedure SaveConfig;
    procedure LoadGrid;
    function SelectedSiteIndex: integer;
    procedure SetStatusText(const Value: string);
    function GetActive: boolean;
    procedure SetActive(const Value: boolean);
    property StatusText: string read fStatusText write SetStatusText;
    procedure DoOnSiteProgress(SiteName, Status, MessageText: string);
    procedure DoLogEvent(Sender: TObject; const Event, Value : string);
    property Active: boolean read GetActive write SetActive;
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

uses frmSiteConfig, StrUtils, Types, LogThreadLib, LogMessageTypes;

{$R *.dfm}

const
  Col_Name = 0;
  Col_Status = 1;
  Col_Message = 2;
  Col_Active = 3;

procedure TfmMain.btnAddSiteClick(Sender: TObject);
var
  NewSite: TJsonObject;
begin
  NewSite:= TJsonObject.Create;
  if not NewSite.Exists('NextSyncTime') then begin
    NewSite.DT['NextSyncTime']:= now + ((1/24/60) * 5);
    config.O['Interval'].I['Hours']:= 0;
    config.O['Interval'].I['Mins']:= 15;
    config.O['Interval'].O['DayOfTheWeek'].B['1']:= true;
    config.O['Interval'].O['DayOfTheWeek'].B['2']:= true;
    config.O['Interval'].O['DayOfTheWeek'].B['3']:= true;
    config.O['Interval'].O['DayOfTheWeek'].B['4']:= true;
    config.O['Interval'].O['DayOfTheWeek'].B['5']:= true;

    SaveConfig;
  end;

  if frmSiteConfig.DoConfig(NewSite) then begin
    Config.A['Sites'].Add(NewSite);
    SaveConfig;
    LoadGrid;
  end
  else
    NewSite.Free;
end;

procedure TfmMain.btnDeleteSiteClick(Sender: TObject);
var
  obj: TJsonObject;
  idx: integer;
begin
  idx:= SelectedSiteIndex;
  if idx > -1 then begin
    obj:= Config.A['Sites'].Items[idx].AsObject;
    if MessageDlg('Are you sure you want to delete "' + obj.S['Name'] + '"',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
      Config.A['Sites'].Delete(idx);
      LoadGrid;
    end;
  end;
end;

procedure TfmMain.btnEditClick(Sender: TObject);
var
  obj: TJsonObject;
  idx: integer;
begin
  if grdSites.Row > 0 then begin
    idx:= SelectedSiteIndex;
    if idx > -1 then begin
      obj:= Config.A['Sites'].Items[idx].AsObject;
      if frmSiteConfig.DoConfig(obj) then begin
        SaveConfig;
        LoadGrid;
      end
    end;
  end;
end;

procedure TfmMain.btnStartClick(Sender: TObject);
begin
//  DataSync.Active:= true;
  Active:= true;
  sbMain.Refresh;
  SaveConfig;
end;

procedure TfmMain.btnStopClick(Sender: TObject);
begin
//  DataSync.Active:= false;
  Active:= false;
  sbMain.Refresh;
  SaveConfig;
end;

procedure TfmMain.DoLogEvent(Sender: TObject; const Event, Value: string);
var
  Json: TJsonObject;
//  x: integer;
begin
  if Event = Event_SiteStatus then begin
    Json:= JO;
    try
      Json.AsString:= Value;
      DoOnSiteProgress(Json.S['SiteName'],Json.S['Status'],Json.S['Message']);
    finally
      Json.Free;
    end;
  end
  else if Event = Event_IdleStatus then begin
    if StatusText <> Value then
      StatusText:= Value;
  end
  else begin
//    if memLog.Lines.Count > 300 then begin
//      memLog.Enabled:= false;
//      try
//        while memLog.Lines.Count > 200 do
//          memLog.Lines.Delete(0);
//      finally
//        memLog.Enabled:= true;
//      end;
//    end;
//    memLog.Lines.Add(Value);
    LogMemo.AddLine(Value);
  end;
//  Application.ProcessMessages;
end;

procedure TfmMain.DoOnSiteProgress(SiteName, Status, MessageText: string);
var
  row: integer;
begin
  for row := 1 to grdSites.RowCount -1 do begin
    if grdSites.Cells[Col_Name,row] = SiteName then begin
      grdSites.Cells[Col_Status,row]:= Status;
      grdSites.Cells[Col_Message,row]:= MessageText;
      if Status = 'Ok' then
        grdSites.RowColor[row]:= clWhite
      else if Status = 'Sync' then
        grdSites.RowColor[row]:= clYellow
      else
        grdSites.RowColor[row]:= clSilver;

      break;
    end;

  end;
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  DataSync.Active:= false;
  SyncThread.Active:= false;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  ConfigDb:= TConfigDb.Create('SiteIntergration','localhost');
  LogMemo:= TLogMemo.Create(self);
  LogMemo.Parent:= tabLog;
  LogMemo.Align:= alClient;
  TLogger.Inst.Events.AddMultiEvent(DoLogEvent);
  TLogger.Inst.LogAllTypes;
  TLogger.Inst.LogMessageTypes:= [ltError,ltWarning,ltInfo];
  TLogger.Inst.LogTimeFormat:= 'dd/mm hh:nn:ss';
  fLoadingValues:= false;
  Config:= TJsonObject.Create;
  LoadConfig;
  LoadGrid;

  SyncThread:= TApiDataSyncThread.Create(true);
  SyncThread.Logger:= TLogger.Inst;
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  SyncThread.Active:= false;
  SyncThread.Terminate;
  SyncThread.Logger:= nil;
  while not SyncThread.Idle do
    Sleep(50);
  SyncThread.Free;
  Config.Free;
  ConfigDb.Free;
end;

function TfmMain.GetActive: boolean;
begin
  result:= Config.B['Active'];
end;

procedure TfmMain.grdSitesDblClick(Sender: TObject);
begin
  btnEdit.Click;
end;

procedure TfmMain.grdSitesGetEditorType(Sender: TObject; ACol, ARow: Integer;
  var AEditor: TEditorType);
begin
//  if ACol = 3 then
//    AEditor:= edtCheckBox;
end;

procedure TfmMain.LoadConfig;
var
  fileName: string;
begin
  fileName:= ChangeFileExt(Application.ExeName,'.cfg');
  if FileExists(fileName) then begin
    Config.LoadFromFile(fileName);
    DeleteFile(fileName);
  end
  else begin
    Config.AsString:= ConfigDb.Value;
  end;
  if not Config.Exists('Interval') then begin
    Config.F['Interval']:= 1/24/60;
    SaveConfig;
  end;
end;

procedure TfmMain.LoadGrid;
var
  x: integer;
  obj: TJsonObject;
begin
  grdSites.RowCount:= 2;
  grdSites.ClearRows(1,1);
//  grdSites.AddCheckBoxColumn(Col_Active);
  for x := 0 to Config.A['Sites'].Count -1 do begin
    obj:= Config.A['Sites'].Items[x].AsObject;
    if x > 0 then
      grdSites.RowCount:= grdSites.RowCount + 1;
    grdSites.Cells[Col_Name,x+1]:= obj.S['Name'];
    grdSites.Cells[Col_Status,x+1]:= 'Unknown';
    grdSites.Cells[Col_Message,x+1]:= '';
    if obj.B['Active'] then
      grdSites.Cells[Col_Active,x+1]:= 'Yes'
    else
      grdSites.Cells[Col_Active,x+1]:= 'No';

//    grdSites.SetCheckBoxState(Col_Active,x+1,obj.B['Active']);

  end;
end;

procedure TfmMain.SaveConfig;
//var
//  fileName: string;
begin
//  fileName:= ChangeFileExt(Application.ExeName,'.cfg');
//  Config.SaveToFile(fileName);
  ConfigDb.Value:= Config.AsString;
end;

procedure TfmMain.sbMainDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
  const Rect: TRect);
begin
  if Active then begin
    StatusBar.Canvas.Brush.Color:= clLime;
    StatusBar.Canvas.FillRect(Rect);
    StatusBar.Canvas.Font.Style:= [fsBold];
  end
  else begin
    StatusBar.Canvas.Brush.Color:= clRed;
    StatusBar.Canvas.FillRect(Rect);
    StatusBar.Canvas.Font.Style:= [fsBold];
  end;


  if Panel.Index = 0 then begin
    if Active then begin
      StatusBar.Canvas.TextOut(5,4,'Active');
    end
    else begin
      StatusBar.Canvas.TextOut(5,4,'Inactive');
    end;
  end
  else if Panel.Index = 1 then begin
    if Active then begin
      StatusBar.Canvas.TextOut(5,4,fStatusText);
    end
    else begin
      StatusBar.Canvas.TextOut(5,4,fStatusText);
    end;
  end;
end;

function TfmMain.SelectedSiteIndex: integer;
var
  SiteName: string;
  x: integer;
  obj: TJsonObject;
begin
  result:= -1;
  if grdSites.Row > 0 then begin
    SiteName:= grdSites.Cells[Col_Name,grdSites.Row];
    for x := 0 to Config.A['Sites'].Count -1 do begin
      obj:= Config.A['Sites'].Items[x].AsObject;
      if obj.S['Name'] = SiteName then begin
        result:= x;
        exit;
      end;
    end;
  end;
end;

procedure TfmMain.SetActive(const Value: boolean);
begin
  Config.B['Active']:= Value;
  SaveConfig;
end;

procedure TfmMain.SetStatusText(const Value: string);
begin
  fStatusText := Value;
  sbMain.Refresh;
end;

procedure TfmMain.Timer1Timer(Sender: TObject);
begin
//  Application.ProcessMessages;
end;

end.
