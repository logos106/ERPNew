unit ERPClientListTree;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseTreeView, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, VirtualTrees, Shader, StdCtrls, wwdbdatetimepicker,
  DNMSpeedButton, DNMPanel;

type
  TERPClientListTreeGUI = class(TBaseTreeViewGUI)
    chkActiveClients: TCheckBox;
    cboLicenceStatus: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    cboRelease: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure chkActiveClientsClick(Sender: TObject);
    procedure cboLicenceStatusChange(Sender: TObject);
    procedure TreeDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
  protected
    procedure RefreshTree; override;
  end;

var
  ERPClientListTreeGUI: TERPClientListTreeGUI;

implementation

{$R *.dfm}

uses
  frmERPClientEdit;

{ TERPClientListTreeGUI }

procedure TERPClientListTreeGUI.cboLicenceStatusChange(Sender: TObject);
begin
  inherited;
  if TComboBox(Sender).Focused then
    RefreshTree;
end;

procedure TERPClientListTreeGUI.chkActiveClientsClick(Sender: TObject);
begin
  inherited;
  if TCheckBox(Sender).Focused then
    RefreshTree;
end;

procedure TERPClientListTreeGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TERPClientListTreeGUI.FormCreate(Sender: TObject);
begin
  Self.fbIgnoreAccessLevels := true;
//  FirstRefresh := true;
  inherited;
  MyConnection.Database := 'services';
//  qryMain.Connection:= MyConnection;

  // turn on full row selection
  Tree.TreeOptions.SelectionOptions := Tree.TreeOptions.SelectionOptions + [toFullRowSelect];

  Self.Columns.HeaderColor := Self.color;

  // Add columns to the Tree
  AddColumn('Name', vtString, 240);
  AddColumn('ID', vtInteger, 90);
  AddColumn('Active', vtBoolean, 70);
  AddColumn('DateTime', vtString, 130);
  AddColumn('Type', vtString, 90);
  AddColumn('Status', vtString, 90);
  AddColumn('Status Reason', vtString, 150);
  AddColumn('Start Date', vtString, 90);
  AddColumn('Expire Date', vtString, 90);
  AddColumn('Users', vtInteger, 80);
  AddColumn('Notes', vtString, 300);

  Columns.Header.Background := Self.color;
end;

procedure TERPClientListTreeGUI.RefreshTree;
var
  qry: TERPQuery;
  ClientNode, ComputerNode, LicenceNode: PVirtualNode;
  Rec: PNodeRec;
  ClientId, ComputerId, LicenceId: integer;
begin
  inherited;
  Tree.Clear;
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := MyConnection;
    qry.SQL.Add('select');
    qry.SQL.Add('tclientconfig.id as ClientId,');
    qry.SQL.Add('tclientconfig.name as ClientName,');
    qry.SQL.Add('tclientconfig.active as ClientActive,');
    qry.SQL.Add('tclientconfig.datetime as ClientDateTime,');
    qry.SQL.Add('tclientconfig.softwarereleasetype as ClientReleaseType,');

    qry.SQL.Add('tcomputer.id as ComputerId,');
    qry.SQL.Add('tcomputer.clientid as ComputerClientId,');
    qry.SQL.Add('tcomputer.active as ComputerActive,');
    qry.SQL.Add('tcomputer.computername as ComputerName,');
    qry.SQL.Add('tcomputer.notes as ComputerNotes,');
    qry.SQL.Add('tcomputer.datetime as ComputerDateTime,');

    qry.SQL.Add('tsoftwarelicence.id as LicenceId,');
    qry.SQL.Add('tsoftwarelicence.computerid as LicenceComputerId,');
    qry.SQL.Add('tsoftwarelicence.active as LicenceActive,');
    qry.SQL.Add('tsoftwarelicence.softwarename as LicenceName,');
    qry.SQL.Add('tsoftwarelicence.startdate as LicenceStartDate,');
    qry.SQL.Add('tsoftwarelicence.expiredate as LicenceExpireDate,');
    qry.SQL.Add('tsoftwarelicence.concurrentusers as LicenceUsers,');
    qry.SQL.Add('tsoftwarelicence.status as LicenceStatus,');
    qry.SQL.Add('tsoftwarelicence.statusreason as LicenceStatusReason,');
    qry.SQL.Add('tsoftwarelicence.datatext as LicenceDataText,');
    qry.SQL.Add('tsoftwarelicence.notes as LicenceNotes,');
    qry.SQL.Add('tsoftwarelicence.datetime as LicenceDateTime');

    qry.SQL.Add('from tclientconfig, tcomputer, tsoftwarelicence');
    qry.SQL.Add('where tclientconfig.id = tcomputer.clientid');
    qry.SQL.Add('and tcomputer.id = tsoftwarelicence.computerid');
    if chkActiveClients.Checked then
      qry.SQL.Add('and tclientconfig.active = "T"')
    else
      qry.SQL.Add('and tclientconfig.active = "F"');
    if cboLicenceStatus.Text <> 'All' then
      qry.SQL.Add('and tsoftwarelicence.status = '+ QuotedStr('ls' + cboLicenceStatus.Text));
    if cboRelease.Text <> 'All' then
      qry.SQL.Add('and tclientconfig.softwarereleasetype = '+ QuotedStr(cboRelease.Text));

    qry.SQL.Add('order by tclientconfig.name, tcomputer.computername');
    qry.Open;
//    ComputerNode := nil;
    ClientId := 0;
    ComputerId:= 0;
    LicenceId := 0;
    ClientNode:= nil;
    ComputerNode := nil;
    while not qry.Eof do begin
      if ClientID <> qry.FieldByName('ClientId').AsInteger then begin
        { new client }
        ClientID := qry.FieldByName('ClientId').AsInteger;
        ClientNode:= Tree.AddChild(nil);
        Rec := Tree.GetNodeData(ClientNode);
        Rec^.Data := TNodeData.Create(Self.Columns);
        Rec^.Data.Id := ClientID;
        Rec^.Data.KeyStr := 'Client';
        Rec^.Data.ByName['Name'].AsString := qry.FieldByName('ClientName').AsString;
        Rec^.Data.ByName['ID'].Value := IntToStr(qry.FieldByName('ClientId').AsInteger);
        Rec^.Data.ByName['Active'].Value := qry.FieldByName('ClientActive').AsString;
        Rec^.Data.ByName['DateTime'].Value := FormatDateTime('dd/mm/yy hh:nn:ss', qry.FieldByName('ClientDateTime').AsDAteTime);
        Rec^.Data.ByName['Type'].Value := qry.FieldByName('ClientReleaseType').AsString;

      end;
      if ComputerId <> qry.FieldByName('ComputerId').AsInteger then begin
        { new computer }
        ComputerId := qry.FieldByName('ComputerId').AsInteger;
        ComputerNode := Tree.AddChild(ClientNode);
        Rec := Tree.GetNodeData(ComputerNode);
        Rec^.Data := TNodeData.Create(Self.Columns);
        Rec^.Data.Id := ComputerID;
        Rec^.Data.KeyStr := 'Computer';

        Rec^.Data.ByName['Name'].AsString := qry.FieldByName('ComputerName').AsString;
        Rec^.Data.ByName['ID'].Value := IntToStr(qry.FieldByName('ComputerId').AsInteger);
        Rec^.Data.ByName['Active'].Value := qry.FieldByName('ComputerActive').AsString;
        Rec^.Data.ByName['DateTime'].Value := FormatDateTime('dd/mm/yy hh:nn:ss', qry.FieldByName('ComputerDateTime').AsDateTime);

      end;
      if LicenceId <> qry.FieldByName('LicenceId').AsInteger then begin
        { new Licence }
        LicenceId := qry.FieldByName('LicenceId').AsInteger;
        LicenceNode := Tree.AddChild(ComputerNode);
        Rec := Tree.GetNodeData(LicenceNode);
        Rec^.Data := TNodeData.Create(Self.Columns);
        Rec^.Data.Id := LicenceID;
        Rec^.Data.KeyStr := 'Licence';

        Rec^.Data.ByName['Name'].AsString := qry.FieldByName('LicenceName').AsString;
        Rec^.Data.ByName['ID'].Value := IntToStr(qry.FieldByName('LicenceId').AsInteger);
        Rec^.Data.ByName['Active'].Value := qry.FieldByName('LicenceActive').AsString;
        Rec^.Data.ByName['DateTime'].Value := FormatDateTime('dd/mm/yy hh:nn:ss', qry.FieldByName('LicenceDateTime').AsDateTime);
        Rec^.Data.ByName['Status'].Value := qry.FieldByName('LicenceStatus').AsString;
        Rec^.Data.ByName['Status Reason'].Value := qry.FieldByName('LicenceStatusReason').AsString;
        Rec^.Data.ByName['Start Date'].Value := FormatDateTime('dd/mm/yy', qry.FieldByName('LicenceStartDate').AsDateTime);
        Rec^.Data.ByName['Expire Date'].Value := FormatDateTime('dd/mm/yy', qry.FieldByName('LicenceExpireDate').AsDateTime);
        Rec^.Data.ByName['Notes'].Value := qry.FieldByName('LicenceNotes').AsString;

      end;
      qry.Next;
    end;

  finally
    qry.Free;
  end;
end;

procedure TERPClientListTreeGUI.TreeDblClick(Sender: TObject);
var
  rec: PNodeRec;
  form: TfmERPClientEdit;
begin
  if Tree.GetFirstSelected = nil then exit;
  rec := Tree.GetNodeData(Tree.GetFirstSelected);
  if SameText(rec^.Data.KeyStr,'Client') then begin
    form := TfmERPClientEdit.Create(Application);
    form.KeyID := rec.Data.Id;
    form.FormStyle := fsMDIChild;
    form.BringToFront;
  end;
end;

initialization
  RegisterClass(TERPClientListTreeGUI);

end.
