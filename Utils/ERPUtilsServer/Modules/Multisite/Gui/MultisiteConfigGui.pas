unit MultisiteConfigGui;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmModuleConfigBase, StdCtrls, Buttons, Shader, DNMPanel,
  ExtCtrls, ComCtrls, AdvPageControl, MultisiteConst, DNMSpeedButton,
  VirtualTrees, MultisiteConfigObj, ActnList, Menus;

type
  TfmMultisiteConfigGui = class(TfmModuleConfigBase)
    pcMultisite: TAdvPageControl;
    tabConfig: TAdvTabSheet;
    tabLog: TAdvTabSheet;
    memLog: TMemo;
    btnStart: TDNMSpeedButton;
    btnStop: TDNMSpeedButton;
    vtConfig: TVirtualStringTree;
    alTree: TActionList;
    actAdd: TAction;
    actDelete: TAction;
    actEdit: TAction;
    popTree: TPopupMenu;
    Add1: TMenuItem;
    Edit1: TMenuItem;
    Delete1: TMenuItem;
    sbStatus: TStatusBar;
    btnEdit: TDNMSpeedButton;
    btnAdd: TDNMSpeedButton;
    btnDelete: TDNMSpeedButton;
    cboLoggingLevel: TComboBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure vtConfigGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure actAddExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure popTreePopup(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure vtConfigDblClick(Sender: TObject);
    procedure cboLoggingLevelChange(Sender: TObject);
    procedure pcMultisiteResize(Sender: TObject);
  private
    MSConfig: TServerConfig;
    function GetServerConfigText: string;
    procedure SetServerConfigText(const Value: string);
    procedure BuildTree;
    procedure SendConfig;
    function ValidateData: boolean;
  public
    procedure Log(msg: string);
    property ServerConfigText: string read GetServerConfigText write SetServerConfigText;
  end;

  rTreeData = record
    item: TObject;
  end;

var
  fmMultisiteConfigGui: TfmMultisiteConfigGui;

implementation

{$R *.dfm}

uses
  JsonObject, MultisiteModuleConfigObj, JsonToObject,
  frmServerEdit, frmDatabaseEdit, frmRemoteDatabaseEdit, Vista_MessageDlg;

{ TfmMultisiteConfigGui }

procedure TfmMultisiteConfigGui.Log(msg: string);
begin
  while memLog.Lines.Count > 1000 do
    memLog.Lines.Delete(0);
  memLog.Lines.Add(msg);
end;

procedure TfmMultisiteConfigGui.FormCreate(Sender: TObject);
begin
  inherited;
  MSConfig:= TServerConfig.Create;
  MSConfig.MySqlServer:= '';
  vtConfig.NodeDataSize:= SizeOf(rTreeData);
//  lblStatus.Caption:= '';
end;

procedure TfmMultisiteConfigGui.FormDestroy(Sender: TObject);
begin
  MsConfig.Free;
  inherited;
end;

function TfmMultisiteConfigGui.GetServerConfigText: string;
begin
  result:= ObjToStr(MsConfig);
end;

procedure TfmMultisiteConfigGui.SetServerConfigText(const Value: string);
var
  s: string;
begin
  s:= ObjToStr(MsConfig);
  if s <> Value then begin
    StrToObj(Value,MsConfig);
    BuildTree;


  end;
end;

procedure TfmMultisiteConfigGui.BuildTree;
var
  rootNode, dbNode, node: PVirtualNode;
  nodeData: ^rTreeData;
  idxDb, idxRmtDb: integer;
  Db: TDatabase;
  RmtDb: TRemoteDatabase;
begin
  vtConfig.Clear;
  rootNode:= vtConfig.AddChild(nil);
  nodeData:= vtConfig.GetNodeData(rootNode);
  nodeData.item:= MsConfig;
  for idxDb:= 0 to MsConfig.DatabaseList.Count -1 do begin
    Db:= MsConfig.DatabaseList[idxDb];
    dbNode:= vtConfig.AddChild(rootNode);
    nodeData:= vtConfig.GetNodeData(dbNode);
    nodeData.item:= Db;
    for idxRmtDb:= 0 to Db.RemoteDatabaseList.Count -1 do begin
      RmtDb:= Db.RemoteDatabaseList[idxRmtDb];
      node:= vtConfig.AddChild(dbNode);
      nodeData:= vtConfig.GetNodeData(node);
      nodeData.item:= RmtDb;
    end;
  end;
  vtConfig.FullExpand;
end;

procedure TfmMultisiteConfigGui.vtConfigGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  nodeData: ^rTreeData;

  function BoolAsStr(val: boolean): string;
  begin
    if Val then result:= 'Yes'
    else result:= 'No';
  end;

begin
  inherited;
  nodeData:= vtConfig.GetNodeData(node);
  if nodeData.item is TServerConfig then begin
    case Column of
      0: CellText:= 'Local Server';
      1: CellText:= TServerConfig(nodeData.item).MySqlServer;
      else CellText:= '';
    end;
  end
  else if nodeData.item is TDatabase then begin
    case Column of
      0: CellText:= 'Local Database';
      1: CellText:= '';
      2: CellText:= TDatabase(nodeData.item).DatabaseName;
      3: CellText:= BoolAsStr(TDatabase(nodeData.item).SynchronizationActive);
      4: CellText:= FormatDateTime('hh:nn:ss',TDatabase(nodeData.item).CheckInterval);
      else CellText:= '';
    end;
  end
  else if nodeData.item is TRemoteDatabase then begin
    case Column of
      0: CellText:= 'Remote Database';
      1: CellText:= TRemoteDatabase(nodeData.item).MySQLServer;
      2: CellText:= TRemoteDatabase(nodeData.item).DatabaseName;
      3: CellText:= '';
      4: CellText:= '';
      else CellText:= '';
    end;
  end;
end;

procedure TfmMultisiteConfigGui.actAddExecute(Sender: TObject);
var
  node: PVirtualNode;
  nodeData: ^rTreeData;
  newDb: TDatabase;
  newRmtDb: TRemoteDatabase;
begin
  inherited;
  node:= vtConfig.GetFirstSelected;
  if Assigned(node) then begin
    nodeData:= vtConfig.GetNodeData(Node);
    if nodeData.item is TServerConfig then begin
      newDb:= TServerConfig(nodeData.item).DatabaseList.Add;
      if DoDatabaseEdit(newDb) then begin
        BuildTree;
        SendConfig;
      end
      else
        TServerConfig(nodeData.item).DatabaseList.Delete(newDb.Index);
    end
    else if nodeData.item is TDatabase then begin
      newRmtDb:= TDatabase(nodeData.item).RemoteDatabaseList.Add;
      if DoRemoteDatabaseEdit(newRmtDb) then begin
        BuildTree;
        SendConfig;
      end
      else
        TDatabase(nodeData.item).RemoteDatabaseList.Delete(newRmtDb.Index);
    end
    else if nodeData.item is TRemoteDatabase then begin
      { nothing to add }
    end;
  end;
end;

procedure TfmMultisiteConfigGui.actDeleteExecute(Sender: TObject);
var
  node: PVirtualNode;
  nodeData: ^rTreeData;
begin
  inherited;
  node:= vtConfig.GetFirstSelected;
  if Assigned(node) then begin
    nodeData:= vtConfig.GetNodeData(Node);
    if nodeData.item is TServerConfig then begin
      { cant delete root node }
    end
    else if nodeData.item is TDatabase then begin
      TDatabase(nodeData.item).Collection.Delete(TDatabase(nodeData.item).Index);
      BuildTree;
      SendConfig;
    end
    else if nodeData.item is TRemoteDatabase then begin
      TRemoteDatabase(nodeData.item).Collection.Delete(TRemoteDatabase(nodeData.item).Index);
      BuildTree;
      SendConfig;
    end;
  end;
end;

procedure TfmMultisiteConfigGui.actEditExecute(Sender: TObject);
var
  node: PVirtualNode;
  nodeData: ^rTreeData;
begin
  inherited;
  node:= vtConfig.GetFirstSelected;
  if Assigned(node) then begin
    nodeData:= vtConfig.GetNodeData(Node);
    if nodeData.item is TServerConfig then begin
      if DoServerEdit(TServerConfig(nodeData.item)) then
        SendConfig;
    end
    else if nodeData.item is TDatabase then begin
      if DoDatabaseEdit(TDatabase(nodeData.item)) then
        SendConfig;
    end
    else if nodeData.item is TRemoteDatabase then begin
      if DoRemoteDatabaseEdit(TRemoteDatabase(nodeData.item)) then
        SendConfig;
    end;
  end;
end;

procedure TfmMultisiteConfigGui.SendConfig;
begin
  TMultisiteModuleConfig(ModuleConfig).Multisite.ConfigText:= self.ServerConfigText;
end;

procedure TfmMultisiteConfigGui.popTreePopup(Sender: TObject);
var
  node: PVirtualNode;
  nodeData: ^rTreeData;
begin
  inherited;
  node:= vtConfig.GetFirstSelected;
  if Assigned(node) then begin
    nodeData:= vtConfig.GetNodeData(Node);
    if nodeData.item is TServerConfig then begin
      actAdd.Enabled:= true;
      actEdit.Enabled:= true;
      actDelete.Enabled:= false;
    end
    else if nodeData.item is TDatabase then begin
      actAdd.Enabled:= true;
      actEdit.Enabled:= true;
      actDelete.Enabled:= true;
    end
    else if nodeData.item is TRemoteDatabase then begin
      actAdd.Enabled:= false;
      actEdit.Enabled:= true;
      actDelete.Enabled:= true;
    end;
  end;
end;

procedure TfmMultisiteConfigGui.btnStartClick(Sender: TObject);
begin
  inherited;
  if ValidateData then
    TMultisiteModuleConfig(ModuleConfig).Multisite.Active:= true;
end;

procedure TfmMultisiteConfigGui.btnStopClick(Sender: TObject);
begin
  inherited;
  TMultisiteModuleConfig(ModuleConfig).Multisite.Active:= false;
end;

procedure TfmMultisiteConfigGui.vtConfigDblClick(Sender: TObject);
begin
  inherited;
  actEdit.Execute;
  Application.ProcessMessages;
  vtConfig.FullExpand;
end;

procedure TfmMultisiteConfigGui.cboLoggingLevelChange(Sender: TObject);
begin
  TMultisiteModuleConfig(ModuleConfig).Multisite.LoggingLevel:=
    TLoggingLevel(cboLoggingLevel.ItemIndex);
end;

procedure TfmMultisiteConfigGui.pcMultisiteResize(Sender: TObject);
begin
  pcMultisite.TabWidth:= Trunc((pcMultisite.Width -20) / pcMultisite.PageCount);
end;

function TfmMultisiteConfigGui.ValidateData: boolean;
var
  dBcount: integer;
  localDb: TDatabase;
begin
  result:= false;
  if MSConfig.MySqlServer = '' then begin
    MessageDlgXP_Vista('Please Specify the Server Name (eg Server1) or Server IP (eg 127.0.0.1) for your local ERP Database Server.',mtInformation,[mbOk],0);
    exit;
  end
  else if MSConfig.DatabaseList.Count = 0 then begin
    MessageDlgXP_Vista('Please Specify a Local Database (Company File).',mtInformation,[mbOk],0);
    exit;
  end;
  for dBCount:= 0 to MSConfig.DatabaseList.Count - 1 do begin
    localDb:= MSConfig.DatabaseList[dBCount];
    if localDb.RemoteDatabaseList.Count = 0 then begin
      MessageDlgXP_Vista('Please Specify a Remote Database, to Synchronize from for Local Database "' + localDb.DatabaseName + '".',mtInformation,[mbOk],0);
      exit;
    end
  end;

  result:= true;
end;

initialization
  RegisterClass(TfmMultisiteConfigGui);

end.
