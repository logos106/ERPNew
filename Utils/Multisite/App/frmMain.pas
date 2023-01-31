unit frmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, DNMPanel,
  StdCtrls, DNMSpeedButton, MyAccess, Contnrs, LogThreadLib,
  SynchronizerObj, MultisiteConfigObj;

type
  TfmMain = class(TForm)
    pnlBottom: TDNMPanel;
    PageControl1: TPageControl;
    tsConfig: TTabSheet;
    pnlServer: TDNMPanel;
    Label1: TLabel;
    edtServer: TEdit;
    tvConfig: TTreeView;
    DNMPanel1: TDNMPanel;
    btnAdd: TDNMSpeedButton;
    btnEdit: TDNMSpeedButton;
    btnDelete: TDNMSpeedButton;
    btnTest: TDNMSpeedButton;
    btnStart: TDNMSpeedButton;
    btnStop: TDNMSpeedButton;
    tsLog: TTabSheet;
    memLog: TMemo;
    lblStatus: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtServerChange(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure tvConfigDblClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
  private
    fActive: boolean;
    slLog: TStringList;
    procedure SetActive(const Value: boolean);
    procedure LogHandler(Sender: TObject; const Event, Value : string);
    procedure SetButtons;
  private
    Config: TServerConfig;
    SyncObj: TDataSynchronizer;
    Logger: Tlogger;
    procedure LoadConfig;
    procedure SaveConfig;
    procedure PopulateTree;
    property Active: boolean read fActive write SetActive;
    function TestConfig(var msg: string): boolean;
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

uses
  DbConst, DBUtils, frmDatabaseEdit, frmSiteItemEdit, LogMessageTypes,
  SchemaObj, SystemLib, JsonObject, JsonToObject;

{$R *.dfm}

procedure TfmMain.FormCreate(Sender: TObject);
begin
  slLog:= TStringList.Create;
  Logger:= Tlogger.Create(self);
  Logger.Events.AddMultiEvent(LogHandler);
  Logger.LogMessageTypes:= [ltNone, ltError, ltWarning, ltInfo, ltDetail, ltBlank, ltDebug];
  Logger.LogToFile:= true;
  Logger.LogToEvent:= true;
  SyncObj:= TDataSynchronizer.Create;
  SyncObj.Logger:= Logger;
  Config:= TServerConfig.Create;
  LoadConfig;
  SetButtons;
  Caption:= Caption + '  [' + GetFileVersion(Application.ExeName) + ']';
  Active:= false;
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  Active:= false;
  SyncObj.Free;
  SaveConfig;
  Logger.Active:= false;
  Sleep(500);
  slLog.Free;
  inherited;
end;

procedure TfmMain.FormShow(Sender: TObject);
begin
  tvConfig.Items.Clear;
  PopulateTree;
  tvConfig.FullExpand;
end;

procedure TfmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//
end;

procedure TfmMain.SaveConfig;
var
  configFileName: string;
  o: TJsonObject;
begin
  o:= JO;
  try
    ObjToJson(Config,o);
    configFileName:= ChangeFileExt(Application.ExeName, '_Config.cfg');
    o.SavetoFile(configFileName);
  finally
    o.Free;
  end;
end;

procedure TfmMain.LoadConfig;
var
  configFileName: string;
  o: TJsonObject;
begin
  configFileName:= ChangeFileExt(Application.ExeName, '_Config.cfg');
  o:= JO;
  try
    o.LoadFromFile(configFileName);
    JsonToObj(o,Config);
  finally
    o.Free;
  end;

  edtServer.Text:= Config.MySQLServer;  
end;

procedure TfmMain.edtServerChange(Sender: TObject);
begin
  Config.MySQLServer:= edtServer.Text;
end;

procedure TfmMain.PopulateTree;
var
  x, y: integer;
  root, dbNode, siteNode: TTreeNode;
begin
  tvConfig.Items.Clear;
  root:= tvConfig.Items.AddChild(nil,'Server - [' + Config.MySQLServer + ']');
  root.Data:= config;
  for x:= 0 to Config.DatabaseList.Count -1 do begin
    dbNode:= tvConfig.Items.AddChild(root, Config.DatabaseList[x].Caption);
    dbNode.Data:= Config.DatabaseList[x];
    for y:= 0 to Config.DatabaseList[x].RemoteDatabaseList.Count -1 do begin
      siteNode:= tvConfig.Items.AddChildFirst(dbNode,Config.DatabaseLIst[x].RemoteDatabaseList[y].Caption);
      siteNode.Data:= Config.DatabaseList[x].RemoteDatabaseList[y];
    end;
  end;
end;

procedure TfmMain.btnAddClick(Sender: TObject);
var
  node, newNode: TTreeNode;
  newDb: TDatabase;
  newSiteItem: TRemoteDatabase;
begin
  node:= tvConfig.Selected;
  if not Assigned(node) then exit;
  if node.Data = Config then begin

    newDb:= Config.DatabaseList.Add;
    if DoDatabaseEdit(newDb) then begin
      newNode:= tvConfig.Items.AddChild(node,newDb.Caption);
      newNode.Data:= newDb;
    end;
  end
  else if TObject(node.Data).ClassNameIs('TDatabase') then begin
    newSiteItem:= TDatabase(node.Data).RemoteDatabaseList.Add;
    if DoSiteItemEdit(newSiteItem) then begin
      newNode:= tvConfig.Items.AddChild(node,newSiteItem.Caption);
      newNode.Data:= newSiteItem;
    end;
  end;
//  SaveConfig;
end;

procedure TfmMain.btnEditClick(Sender: TObject);
var
  node: TTreeNode;
begin
  node:= tvConfig.Selected;
  if not Assigned(node) then exit;
  if TObject(node.Data).ClassNameIs('TSyncDatabaseConfig') then begin
    if DoDatabaseEdit(TDatabase(Node.Data)) then begin
      node.Text:= TDatabase(Node.Data).Caption;
    end;
  end
  else if TObject(node.Data).ClassNameIs('TRemoteDatabase') then begin
    if DoSiteItemEdit(TRemoteDatabase(Node.Data)) then begin
      node.Text:= TRemoteDatabase(Node.Data).Caption;
    end;
  end;
//  SaveConfig;
end;

procedure TfmMain.btnDeleteClick(Sender: TObject);
var
  node: TTreeNode;
begin
  node:= tvConfig.Selected;
  if not Assigned(node) then exit;
  if TObject(node.Data).ClassNameIs('TDatabase') then begin
    TDatabase(Node.Data).Collection.Delete(TDatabase(Node.Data).Index);
    PopulateTree;
  end
  else if TObject(node.Data).ClassNameIs('TRemoteDatabase') then begin
    TRemoteDatabase(Node.Data).Collection.Delete(TRemoteDatabase(Node.Data).Index);
    PopulateTree;
  end;
//  SaveConfig;
end;

procedure TfmMain.tvConfigDblClick(Sender: TObject);
begin
  btnEdit.Click;
end;

procedure TfmMain.SetActive(const Value: boolean);
var
  s: string;
  o: TJsonObject;
begin
  if fActive = Value then exit;
  fActive := Value;
  if Value then
    Logger.Log('Synchronization Started',ltInfo)
  else
    Logger.Log('Synchronization Stopped',ltInfo);

  if Value then begin
    SyncObj.Active:= false;
    o:= JO;
    try
      ObjToJson(Config,o);
      JsonToObj(o,syncObj.Config);
    finally
      o.Free;
    end;

    SyncObj.Schema.AsString:= TSchema.Inst.Root.AsString;
    SyncObj.Active:= true;
  end
  else begin
    SyncObj.Active:= false;
  end;
  SetButtons;
end;

procedure TfmMain.btnStartClick(Sender: TObject);
begin
  Active:= true;
end;

procedure TfmMain.btnStopClick(Sender: TObject);
begin
  Active:= false;
end;

function TfmMain.TestConfig(var msg: string): boolean;
var
  conn: TMyConnection;
  x, y: integer;
  dbConfig: TDatabase;
  siteConfig: TRemoteDatabase;
  siteCode: string;
  qry: TMyQuery;
  found: boolean;

  function msBackendIds: TMyQuery;
  begin
    result:= TMyQuery.Create(nil);
    result.Connection:= conn;
    result.SQL.Text:= 'select * from tblmsbackendid';
    result.Open;
  end;

begin
  result:= true;
  conn:= dbUtils.GetNewDbConnection();
  try
    { first check local server }
    conn.Server:= Config.MySQLServer;
    conn.Database:= 'mysql';
    try
      conn.Connect;
    except
      result:= false;
      msg:= 'Could not connect to local server: "' + Config.MySQLServer + '"';
      exit;
    end;
    conn.Disconnect;
    { cycle through databases }
    for x:= 0 to Config.DatabaseList.Count -1 do begin
      conn.Disconnect;
      dbConfig:= Config.DatabaseList[x];
      conn.Database:= dbConfig.DatabaseName;
      try
        conn.Connect;
      except
        result:= false;
        msg:= 'Could not connect to local database: "' + dbConfig.DatabaseName + '"';
        exit;
      end;
      qry:= msBackendIds;
      try
        siteCode:= '';
        while not qry.Eof do begin
          if qry.FieldByName('BEDefault').AsBoolean then begin
            siteCode:= qry.FieldByName('SiteCode').AsString;
            break;
          end;
          qry.Next;
        end;
        qry.Close;
        if siteCode = '' then begin
          if msg <> '' then msg:= msg + #13#10;
          msg:= msg + 'No default site code set for local database: ' + dbConfig.DatabaseName;
        end;
        for y:= 0 to dbConfig.RemoteDatabaseList.Count -1 do begin
          conn.Disconnect;
          siteConfig:= dbConfig.RemoteDatabaseList[y];
          conn.Database:= siteConfig.DatabaseName;
          conn.Server:= siteConfig.MySQLServer;
          try
            conn.Connect;
          except
            result:= false;
            msg:= 'Could not connect to remote server/database: "' + siteConfig.DatabaseName + '@' + siteConfig.MySQLServer + '"';
            exit;
          end;
          found:= false;
          if siteCode <> '' then begin
            qry.Open;
            while not qry.Eof do begin
              if qry.FieldByName('SiteCode').AsString = siteCode then begin
                found:= true;
                break;
              end;
              qry.Next;
            end;
            qry.Close;
          end;
          if not found then begin
            if msg <> '' then msg:= msg + #13#10;
            msg:= msg + 'Remote database: "' +
              siteConfig.DatabaseName + '@' + siteConfig.MySQLServer +
              '" does not have an entry for site code: "' + siteCode + '"';
          end;
        end;
      finally
        qry.Free;
      end;
    end;
  finally
    conn.Free;
  end;
end;

procedure TfmMain.btnTestClick(Sender: TObject);
var
  s: string;
  SavedCursor: TCursor;
begin
  self.Enabled:= false;
  SavedCursor := Screen.Cursor;
  try
    Screen.Cursor := crHourGlass;
    if not self.TestConfig(s) then
      MessageDlg('Test Failed:' + #13#10 + s,mtInformation,[mbOk],0)
    else begin
      if s = '' then
        MessageDlg('Test Successful!',mtInformation,[mbOk],0)
      else
        MessageDlg('Test Successful with warnings:' + #13#10 + s,mtInformation,[mbOk],0);
    end;
  finally
    Self.Enabled:= true;
    Screen.Cursor := SavedCursor;
  end;
end;

procedure TfmMain.LogHandler(Sender: TObject; const Event, Value: string);
begin
  if Event = 'Log' then begin
    if memLog.Lines.Count > 2500 then begin
      //memLog.Lines.Delete(0);

      slLog.Text:= memLog.Text;
      while slLog.Count > 2000 do
        slLog.Delete(0);
      memLog.Lines.Text:= slLog.Text;  
    end;
    memLog.Lines.Add(Value);
  end
  else if Event = 'Status' then begin
    lblStatus.Caption:= 'Status: ' + Value;
    lblStatus.Refresh;
  end;
  Application.ProcessMessages;
end;

procedure TfmMain.SetButtons;
begin
  btnStart.Enabled:= not fActive;
  btnStop.Enabled:= fActive;
  btnStart.Refresh;
  btnStop.Refresh;
end;

end.
