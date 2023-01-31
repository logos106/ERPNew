unit frmEDIConfigMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmStandAloneConfigBase, DNMSpeedButton, StdCtrls,
  EDIConfigObj, EDIMapConfigObj, ExtCtrls, MyAccess, ERPDbComponents, ComCtrls,
  ImgList, ActnList, Menus, JSONObject;

type
  TfmEDIConfigMain = class(TfmStandAloneConfigBase)
    cboDatabase: TComboBox;
    Label1: TLabel;
    lstTriggers: TListView;
    Label2: TLabel;
    Bevel1: TBevel;
    Label3: TLabel;
    edtERPUser: TEdit;
    Label4: TLabel;
    edtERPPass: TEdit;
    chkActive: TCheckBox;
    Label5: TLabel;
    lstMaps: TListView;
    ImageList: TImageList;
    ActionList1: TActionList;
    actEditTrigger: TAction;
    actAddTrigger: TAction;
    actDeleteTrigger: TAction;
    btnAddTrigger: TDNMSpeedButton;
    actDeleteMapping: TAction;
    actEditMapping: TAction;
    actAddMapping: TAction;
    edtAddMapping: TDNMSpeedButton;
    actSaveMappingToFile: TAction;
    actLoadMappingFromFile: TAction;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    popTriggers: TPopupMenu;
    popMaps: TPopupMenu;
    AddMapping1: TMenuItem;
    EditMapping1: TMenuItem;
    SaveMappingtoFile1: TMenuItem;
    LoadMAppingfromFile1: TMenuItem;
    DeleteMapping1: TMenuItem;
    actSaveTriggerToFile: TAction;
    actLoadTriggerFromFile: TAction;
    AddTrigger1: TMenuItem;
    EditTrigger1: TMenuItem;
    SaveTriggertoFile1: TMenuItem;
    LoadTriggerfromFile1: TMenuItem;
    DeleteTrigger1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboDatabaseChange(Sender: TObject);
    procedure lstTriggersColumnClick(Sender: TObject; Column: TListColumn);
    procedure lstMapsColumnClick(Sender: TObject; Column: TListColumn);
    procedure actEditTriggerExecute(Sender: TObject);
    procedure lstTriggersDblClick(Sender: TObject);
    procedure actAddTriggerExecute(Sender: TObject);
    procedure actDeleteTriggerExecute(Sender: TObject);
    procedure actDeleteMappingExecute(Sender: TObject);
    procedure actEditMappingExecute(Sender: TObject);
    procedure actAddMappingExecute(Sender: TObject);
    procedure lstTriggersSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lstMapsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure actSaveMappingToFileExecute(Sender: TObject);
    procedure actLoadMappingFromFileExecute(Sender: TObject);
    procedure actSaveTriggerToFileExecute(Sender: TObject);
    procedure actLoadTriggerFromFileExecute(Sender: TObject);
    procedure lstMapsDblClick(Sender: TObject);
  private
    EDIConfig: TEDIConfig;
    EDIMapConfig: TEDIMapConfig;
    Dirty: boolean;
    TriggerIndex,
    MapIndex: integer;
    procedure Load;
    procedure Save;
    procedure LoadTriggerListItem(LIstItem: TListItem; obj: TJsonObject = nil);
  protected
    function Validate: boolean; override;
  public
    Connection: TERPConnection;
    procedure LoadParams; override;
    procedure SaveParams; override;
  end;

var
  fmEDIConfigMain: TfmEDIConfigMain;

implementation

uses
  MySQLUtils, DbConst, DbSharedObjectsObj, Vista_MessageDlg,
  frmEDITrigger, frmEDIMapper, JsonObjectUtils;

{$R *.dfm}

procedure TfmEDIConfigMain.actAddMappingExecute(Sender: TObject);
var
  li: TListItem;
begin
  inherited;
  self.FormStyle := fsNormal;
  try
    EDIMapConfig.Clear;
    EDIMapConfig.Name := '';
    EDIMapConfig.S['Type'] := 'InputFromFile';
    EDIMapConfig.O['InputFile'].S['DataType'] := 'CSV';
    if frmEDIMapper.DoEDIMapping(self, EDIMapConfig) then begin
      EDIMapConfig.Save(Connection);
      li := lstMaps.Items.Add;
      li.SubItems.Add(EDIMapConfig.Name);
      li.SubItems.Add(EDIMapConfig.S['MapDescription']);
    end;
  finally
    self.FormStyle := fsStayOnTop;
  end;
end;

procedure TfmEDIConfigMain.actAddTriggerExecute(Sender: TObject);
var
  trig: TJsonObject;
  li: TListItem;
begin
  inherited;
  self.FormStyle := fsNormal;
  try
    trig := JO;
    if frmEDITrigger.DoEDITriggerEdit(self,trig) then begin
      EdiConfig.Triggers.Add(trig);
      li := lstTriggers.Items.Add;
      li.Data := trig;
      self.LoadTriggerListItem(li);
    end
    else begin
      trig.Free;
    end;
  finally
    self.FormStyle := fsStayOnTop;
  end;
end;

procedure TfmEDIConfigMain.actDeleteMappingExecute(Sender: TObject);
var
  li: TListItem;
  cmd: TERPCommand;
begin
  if lstMaps.ItemIndex < 0 then exit;

  li := lstMaps.Items[lstMaps.ItemIndex];
  if Connection.Connected then begin
    FormStyle := fsNormal;
    try
      if Vista_MessageDlg.MessageDlgXP_Vista('Are you sure you want to permently delete this Mapping?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin


        cmd := DbSharedObjectsObj.DbSharedObj.GetCommand(Connection);
        try
          cmd.SQL.Add('delete from tbldbpreferences');
          cmd.SQL.Add('where PrefType = ' + QuotedStr(EDIMapConfig.ClassName));
          cmd.SQL.Add('and Name = ' + QuotedStr(li.SubItems[0]));
          cmd.Execute;
        finally
          DbSharedObjectsObj.DbSharedObj.ReleaseObj(cmd);
        end;
        lstMaps.Items.Delete(li.Index);
      end;
    finally
      FormStyle := fsStayOnTop;
    end;
  end;
end;

procedure TfmEDIConfigMain.actDeleteTriggerExecute(Sender: TObject);
var
  li: TListItem;
begin
  if lstTriggers.ItemIndex < 0 then exit;

  li := lstTriggers.Items[lstTriggers.ItemIndex];
  FormStyle := fsNormal;
  try
    if Vista_MessageDlg.MessageDlgXP_Vista('Are you sure you want to permently delete this Trigger?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
      EdiConfig.Triggers.Delete(li.Data);
      lstTriggers.Items.Delete(li.Index);
    end;
  finally
    FormStyle := fsStayOnTop;
  end;
end;

procedure TfmEDIConfigMain.actEditTriggerExecute(Sender: TObject);
var
  li: TListItem;
begin
  inherited;
  li := lstTriggers.Selected;
  if not Assigned(li) then exit;
  self.FormStyle := fsNormal;
  try
    if frmEDITrigger.DoEDITriggerEdit(self,li.Data) then begin
      self.LoadTriggerListItem(li);
    end;
  finally
    self.FormStyle := fsStayOnTop;
  end;
end;

procedure TfmEDIConfigMain.actLoadMappingFromFileExecute(Sender: TObject);
var
  li: TListItem;
begin
  inherited;
  li := lstMaps.Selected;
  if not Assigned(li) then exit;
  if not Connection.Connected then exit;

  self.FormStyle := fsNormal;
  try
    //SaveDialog.Title :=
    if OpenDialog.Execute then begin
      EDIMapConfig.Name := li.SubItems[0];
      EDIMapConfig.Load(Connection);
      EDIMapConfig.LoadFromFile(OpenDialog.FileName);
      EDIMapConfig.Save(Connection);
      li.SubItems.Add(EDIMapConfig.Name);
      li.SubItems[1] := EDIMapConfig.S['MapDescription'];
    end;
  finally
    self.FormStyle := fsStayOnTop;
  end;
end;

procedure TfmEDIConfigMain.actLoadTriggerFromFileExecute(Sender: TObject);
var
  li: TListItem;
begin
  inherited;
  li := lstTriggers.Selected;
  if not Assigned(li) then exit;

  self.FormStyle := fsNormal;
  try
    if SaveDialog.Execute then begin
      TJsonObject(li.Data).LoadFromFile(SaveDialog.FileName);
      self.LoadTriggerListItem(li);
    end;
  finally
    self.FormStyle := fsStayOnTop;
  end;
end;

procedure TfmEDIConfigMain.actSaveMappingToFileExecute(Sender: TObject);
var
  li: TListItem;
begin
  inherited;
  li := lstMaps.Selected;
  if not Assigned(li) then exit;
  if not Connection.Connected then exit;

  self.FormStyle := fsNormal;
  try
    //SaveDialog.Title :=
    if SaveDialog.Execute then begin
      EDIMapConfig.Name := li.SubItems[0];
      EDIMapConfig.Load(Connection);
//      EDIMapConfig.SaveToFile(SaveDialog.FileName);
      JsonToFileFormated(EDIMapConfig,SaveDialog.FileName);
    end;
  finally
    self.FormStyle := fsStayOnTop;
  end;
end;

procedure TfmEDIConfigMain.actSaveTriggerToFileExecute(Sender: TObject);
var
  li: TListItem;
begin
  inherited;
  li := lstTriggers.Selected;
  if not Assigned(li) then exit;

  self.FormStyle := fsNormal;
  try
    if SaveDialog.Execute then begin
//      TJsonObject(li.Data).SaveToFile(SaveDialog.FileName);
      JsonToFileFormated(TJsonObject(li.Data),SaveDialog.FileName);
    end;
  finally
    self.FormStyle := fsStayOnTop;
  end;
end;

procedure TfmEDIConfigMain.cboDatabaseChange(Sender: TObject);
begin
  inherited;
  if Loading then exit;
  Load;

end;

procedure TfmEDIConfigMain.actEditMappingExecute(Sender: TObject);
var
  li: TListItem;
begin
  inherited;
  li := lstMaps.Selected;
  if not Assigned(li) then exit;
  if not Connection.Connected then exit;

  self.FormStyle := fsNormal;
  try
    EDIMapConfig.Name := li.SubItems[0];
    EDIMapConfig.Load(Connection);
    if frmEDIMapper.DoEDIMapping(self, EDIMapConfig) then begin
      EDIMapConfig.Save(Connection);
      li.SubItems[1] := EDIMapConfig.S['MapDescription'];
    end;
  finally
    self.FormStyle := fsStayOnTop;
  end;
end;

procedure TfmEDIConfigMain.FormCreate(Sender: TObject);
begin
  inherited;
  Dirty := false;
  EDIConfig := TEDIConfig.Create;
  EDIMapConfig := TEDIMapConfig.Create;
  Connection := TERPConnection.Create(nil);
  TriggerIndex := -1;
  MapIndex := -1;

end;

procedure TfmEDIConfigMain.FormDestroy(Sender: TObject);
begin
  inherited;
  EDIConfig.Free;
  EDIMapConfig.Free;
  Connection.Free;
end;

procedure TfmEDIConfigMain.FormShow(Sender: TObject);
begin
  inherited;
  Load;
end;

procedure TfmEDIConfigMain.Load;
var
  x: integer;
  o: TJSONObject;
  li: TListItem;
  qry: TERPQuery;
begin
  Loading := true;
  try
    EDIConfig.Clear;
    EDIMapConfig.Clear;
    lstTriggers.Clear;
    lstMaps.Clear;
    Connection.Close;
    if cboDatabase.Text <> '' then begin
      MySQLUtils.SetConnectionProps(Connection,cboDatabase.Text,Params.S['ERPUtilsServer']);
      Connection.Open;
      EDIConfig.Load(Connection);
//      EDIMapConfig.Load(Connection);
    end;

    edtERPUser.Text := EDIConfig.ERPUser;
    edtERPPass.Text := EDIConfig.ERPPass;
    chkActive.Checked := EDIConfig.Active;

    for x := 0 to EdiConfig.Triggers.Count -1 do begin
      o := EdiConfig.Triggers[x].AsObject;
      li := lstTriggers.Items.Add;
      self.LoadTriggerListItem(li,o);
//      li.Data := TObject(x);
//      li.ImageIndex := -1;
//      li.SubItems.Add(o.S['Type']);
//      li.SubItems.Add(o.S['MapName']);
//      li.SubItems.Add(o.o['CheckFrequency'].S['Interval']);
//      li.SubItems.Add('File Path ' + o.S['FilePath'] + '  Mask ' + o.S['FileMask']);
    end;

    if Connection.Connected then begin
      qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Connection);
      try
        qry.SQL.Add('select Name from tbldbpreferences');
        qry.SQL.Add('where PrefType = ' + QuotedStr(EDIMapConfig.ClassName));
        qry.Open;
        while not qry.Eof do begin
          li := lstMaps.Items.Add;
          li.ImageIndex := -1;

          //li.Caption := qry.FieldByName('Name').AsString;
          li.SubItems.Add(qry.FieldByName('Name').AsString);
          EDIMapConfig.Name := qry.FieldByName('Name').AsString;
          EDIMapConfig.Load(Connection);
          li.SubItems.Add(EDIMapConfig.S['MapDescription']);
          qry.Next;
        end;

      finally
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
      end;
    end;

  finally
    Loading := false;
    Dirty := false;
  end;
end;

procedure TfmEDIConfigMain.LoadParams;
var
  conn: TERPConnection;
begin
  inherited;
  cboDatabase.Items.Clear;
  if Params.StringExists('ERPUtilsServer') and (Params.S['ERPUtilsServer'] <> '') then begin
    conn := TERPConnection.Create(nil);
    try
      MySQLUtils.SetConnectionProps(conn, DbConst.MYSQL_DATABASE,Params.S['ERPUtilsServer']);
      conn.Connect;
      cboDatabase.Items.CommaText := MySQLUtils.DatabaseList(conn,true);
    finally
      conn.Free;
    end;
    if Params.StringExists('ERPDatabase') and (Params.S['ERPDatabase'] <> '') then
      cboDatabase.ItemIndex := cboDatabase.Items.IndexOf(Params.S['ERPDatabase']);
  end;

end;

procedure TfmEDIConfigMain.LoadTriggerListItem(ListItem: TListItem;
  obj: TJsonObject);
var
  o: TJsonObject;
begin
  if Assigned(obj) then
    ListItem.Data := obj;
  o := ListItem.Data;
  ListItem.ImageIndex := -1;
  ListItem.SubItems.Clear;
  ListItem.SubItems.Add(o.S['Type']);
  ListItem.SubItems.Add(o.S['MapName']);
  ListItem.SubItems.Add(o.o['CheckFrequency'].S['Interval']);
  ListItem.SubItems.Add('File Path ' + o.S['FilePath'] + '  Mask ' + o.S['FileMask']);

end;

procedure TfmEDIConfigMain.lstMapsColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  if Column.ImageIndex = 0 then begin
    actDeleteMapping.Execute;
  end;
end;

procedure TfmEDIConfigMain.lstMapsDblClick(Sender: TObject);
begin
  inherited;
  actEditMapping.Execute;
end;

procedure TfmEDIConfigMain.lstMapsSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  inherited;
  TriggerIndex := -1;
  MapIndex := Item.Index;
end;

procedure TfmEDIConfigMain.lstTriggersColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  inherited;
  if Column.ImageIndex = 0 then begin
    { delete }
    actDeleteTrigger.Execute;
  end;
end;

procedure TfmEDIConfigMain.lstTriggersDblClick(Sender: TObject);
begin
  inherited;
  self.actEditTrigger.Execute;
end;

procedure TfmEDIConfigMain.lstTriggersSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  inherited;
  TriggerIndex := Item.Index;
  MapIndex := -1;
end;

procedure TfmEDIConfigMain.Save;
begin
  EDIConfig.ERPUser := edtERPUser.Text;
  EDIConfig.ERPPass := edtERPPass.Text;
  EDIConfig.Active := chkActive.Checked;


  EDIConfig.Save(Connection);
//  EDIMapConfig.Save(Connection);


end;

procedure TfmEDIConfigMain.SaveParams;
begin
  Save;
  inherited;
end;

function TfmEDIConfigMain.Validate: boolean;
begin
  result := inherited;
end;

end.
