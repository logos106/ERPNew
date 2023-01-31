unit frmSchemaObjectList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, DNMPanel, GIFImg;

type
  TfmSchemaObjectList = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainERPVersion: TWideStringField;
    qryMainVisible: TWideStringField;
    qryMainDescription: TWideMemoField;
    qryMainObjectName: TWideStringField;
    qryMainTableName: TWideStringField;
    qryMainTableFilter: TWideStringField;
    qryMainmsTimeStamp: TDateTimeField;
    lblVersion: TLabel;
    cboVersion: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboVersionChange(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure cmdNewClick(Sender: TObject);
  private
    fERPEditMode: boolean;
    VersionStr: string;
  protected
    procedure SetConnectionString; override;
    property ERPEditMode: boolean read fERPEditMode write fERPEditMode;
    procedure RefreshQuery; override;
  public
    { Public declarations }
  end;

var
  fmSchemaObjectList: TfmSchemaObjectList;

implementation

{$R *.dfm}

uses
  MySQLUtils, CommonDbLib, DbConst, ERPLib, JSONObject, AppDatabase, StrUtils,
  Types, VersionUtils, CommonFormLib, ERPVersionConst;


procedure TfmSchemaObjectList.cboVersionChange(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfmSchemaObjectList.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TfmSchemaObjectEdit',0);
end;

procedure TfmSchemaObjectList.FormCreate(Sender: TObject);
var
  json: TJsonObject;
begin
  fERPEditMode := false;
  json := ERPLib.GetERPCustomConfig;
  try
    ERPEditMode := json.B['AllowSchemaEdit'];
  finally
    json.Free;
  end;
  VersionStr := VersionUtils.VersionToSortString(TABLE_VERSION);

  lblVersion.Visible := ERPEditMode;
  cboVersion.Visible := ERPEditMode;

  if ERPEditMode then begin
    qryMain.SQL.Text :=
      'select * from tblERPSchemaObject_Master' +
      ' where (:Version = "All") or' +
      '   (ID = (select max(ID) from tblerpschemaobject_master m where m.ObjectName = tblerpschemaobject_master.ObjectName and m.ERPVersion <= :Version))' +
      ' order by ObjectName, ERPVersion';
  end
  else begin
    qryMain.SQL.Text :=
      'select * from tblERPSchemaObject where Visible = "T"' +
      ' and ID = (select max(ID) from tblerpschemaobject_master m where m.ObjectName = tblerpschemaobject_master.ObjectName and m.ERPVersion <= :Version)' +
      ' order by ObjectName';
  end;

  inherited;

  SetConnectionProps(myConnection1,ErpDocumentationDBName,CommonDbLib.GetSharedMyDacConnection.Server);
  myConnection1.Connect;
end;

procedure TfmSchemaObjectList.FormShow(Sender: TObject);
var
  qry: TERPQuery;
begin
  inherited;
  if ERPEditMode then begin
    cboVersion.Items.Clear;
    cboVersion.Items.Add('All');
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := myConnection1;
      qry.Sql.Text := 'select distinct ERPVersion from tblerpschemaobject_master order by ERPVersion DESC';
      qry.Open;
      while not qry.Eof do begin
        cboVersion.Items.Add(qry.FieldByName('ERPVersion').AsString);
        qry.Next;
      end;
    finally
      qry.Free;
    end;
    if cboVersion.Items.Count >= 2 then
      cboVersion.ItemIndex := 1
    else
      cboVersion.ItemIndex := 0;
  end
  else begin
    GuiPrefs.DbGridElement[grdMain].RemoveFields('Visible,TableName,TableFilter,ERPVersion');
  end;
  RefreshQuery;
end;

procedure TfmSchemaObjectList.grdMainDblClick(Sender: TObject);
begin
//  inherited;
  if {Assigned(grdMain.GetActiveField) and} (grdMain.GetActiveField = qryMainDescription) then exit;

  if qryMainObjectName.AsString <> ''  then begin
    OpenERPForm('TfmSchemaObjectEdit',qryMainID.AsInteger);
  end;
end;

procedure TfmSchemaObjectList.RefreshQuery;
begin
  qryMain.Close;
  if ERPEditMode then
    qryMain.ParamByName('Version').AsString := cboVersion.Text
  else
    qryMain.ParamByName('Version').AsString := VersionStr;
  inherited;

end;

procedure TfmSchemaObjectList.SetConnectionString;
begin
  inherited;
  qryMain.Connection := MyConnection1;
end;

initialization
  RegisterClass(TfmSchemaObjectList);

end.
