unit frmSchemaObjectEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel, wwcheckbox,
  DBCtrls, Mask, wwdbedit, Grids, Wwdbigrd, Wwdbgrid, Wwdotdot, Wwdbcomb;

type
  TfmSchemaObjectEdit = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryMain: TERPQuery;
    qryDetail: TERPQuery;
    qryMainID: TIntegerField;
    qryMainERPVersion: TWideStringField;
    qryMainVisible: TWideStringField;
    qryMainDescription: TWideMemoField;
    qryMainObjectName: TWideStringField;
    qryMainTableName: TWideStringField;
    qryMainTableFilter: TWideStringField;
    qryMainmsTimeStamp: TDateTimeField;
    qryDetailID: TIntegerField;
    qryDetailERPVersion: TWideStringField;
    qryDetailVisible: TWideStringField;
    qryDetailDescription: TWideMemoField;
    qryDetailObjectName: TWideStringField;
    qryDetailPropertyType: TIntegerField;
    qryDetailPropertyName: TWideStringField;
    qryDetailFieldName: TWideStringField;
    qryDetailFieldType: TWideStringField;
    qryDetailFieldDefault: TWideStringField;
    qryDetailFieldAllowNull: TWideStringField;
    qryDetailFieldFilter: TWideStringField;
    Label3: TLabel;
    edtObjectName: TwwDBEdit;
    dsMain: TDataSource;
    dsDetail: TDataSource;
    memDescription: TDBMemo;
    Label1: TLabel;
    lblTableName: TLabel;
    lblTableFilter: TLabel;
    edtTableFilter: TwwDBEdit;
    lblERPVersion: TLabel;
    edtErpVersion: TwwDBEdit;
    chkVisible: TwwCheckBox;
    grdDetails: TwwDBGrid;
    qryDetailPropertyTypeName: TStringField;
    Label2: TLabel;
    btnUpdateFields: TDNMSpeedButton;
    chkMaxVersion: TwwCheckBox;
    chkVisibleOnly: TwwCheckBox;
    cboTableName: TComboBox;
    cboPropertyType: TwwDBComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryDetailCalcFields(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnUpdateFieldsClick(Sender: TObject);
    procedure chkMaxVersionClick(Sender: TObject);
    procedure chkVisibleOnlyClick(Sender: TObject);
    procedure cboTableNameChange(Sender: TObject);
    procedure qryDetailAfterInsert(DataSet: TDataSet);
    procedure grdDetailsDblClick(Sender: TObject);
  private
    fERPEditMode: boolean;
    VersionStr, NextVersionStr: string;
    function ValidateData: boolean;
    procedure LoadDetail;
  protected
    property ERPEditMode: boolean read fERPEditMode write fERPEditMode;
  public
    { Public declarations }
  end;

var
  fmSchemaObjectEdit: TfmSchemaObjectEdit;

implementation

{$R *.dfm}

uses
  JsonObject, VersionUtils, ERPLib, AppDatabase, Types, StrUtils, MySQLUtils,
  DbConst, CommonDbLib, utSchema, CommonLib, CommonFormLib, ERPVersionConst;

procedure TfmSchemaObjectEdit.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmSchemaObjectEdit.btnOKClick(Sender: TObject);
begin
  inherited;
  if ERPEditMode then begin
    PostDb(qryMain);
    if not ValidateData then exit;
    self.CommitTransaction;
    self.Notify;
  end;
  Close;
end;

procedure TfmSchemaObjectEdit.btnUpdateFieldsClick(Sender: TObject);
begin
  inherited;
  if TSchemaObject.UpdateProperties(VersionStr,NextVersionStr,qryMainObjectName.AsString,qryMainTableName.AsString,MyConnection) then begin
    LoadDetail;
  end;
end;

procedure TfmSchemaObjectEdit.cboTableNameChange(Sender: TObject);
begin
  inherited;
  if not cboTableName.Focused then exit;
  EditDb(qryMain);
  qryMainTableName.AsString := cboTableName.Text;
  PostDb(qryMain);
end;

procedure TfmSchemaObjectEdit.chkMaxVersionClick(Sender: TObject);
begin
  inherited;
  LoadDetail;
end;

procedure TfmSchemaObjectEdit.chkVisibleOnlyClick(Sender: TObject);
begin
  inherited;
  LoadDetail;
end;

procedure TfmSchemaObjectEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  RollbackTransaction;
end;

procedure TfmSchemaObjectEdit.FormCreate(Sender: TObject);
var
  json: TJsonObject;
  arr: TStringDynArray;
  sl: TStringList;
  x: integer;
begin
  fERPEditMode := false;
  json := ERPLib.GetERPCustomConfig;
  try
    ERPEditMode := json.B['AllowSchemaEdit'];
  finally
    json.Free;
  end;
  VersionStr := VersionUtils.VersionToSortString(TABLE_VERSION);

  { increment to next version .. }
  arr := SplitString(VersionStr,'.');
  arr[2] := IntToStr((StrToInt(arr[2]) + 1));
  while Length(arr[2]) < 4 do
    arr[2] := '0' + arr[2];
  NextVersionStr := arr[0] + '.' + arr[1] + '.' + arr[2] + '.' + arr[3];

  inherited;

  sl := TStringList.Create;
  try
    CommonDbLib.GetSharedMyDacConnection.GetTableNames(sl);
    for x := 0 to sl.Count -1 do begin
      if Pos('erpfix_',Lowercase(sl[x])) = 1 then continue;
      if Pos('rpt_',Lowercase(sl[x])) = 1 then continue;
      if Pos('tmp_',Lowercase(sl[x])) = 1 then continue;
      cboTableName.Items.Add(sl[x]);
    end;
  finally
    sl.Free;
  end;

  SetConnectionProps(myConnection,ErpDocumentationDBName,CommonDbLib.GetSharedMyDacConnection.Server);
  myConnection.Connect;

end;

procedure TfmSchemaObjectEdit.FormShow(Sender: TObject);
begin
  inherited;

  if ERPEditMode then begin


  end
  else begin
    GuiPrefs.DbGridElement[grdDetails].RemoveFields(
      'ERPVersion,FieldName,FieldDefault,FieldAllowNull,FieldFilter,Visible');
  end;
  lblTableName.Visible := ERPEditMode;
  cboTableName.Visible := ERPEditMode;
  lblTableFilter.Visible := ERPEditMode;
  edtTableFilter.Visible := ERPEditMode;
  edtErpVersion.Visible := ERPEditMode;
  edtErpVersion.Visible := ERPEditMode;
  chkVisible.Visible := ERPEditMode;
  btnUpdateFields.Visible := ERPEditMode;
  chkMaxVersion.Visible := ERPEditMode;
  chkVisibleOnly.Visible := ERPEditMode;
  btnUpdateFields.Visible := ERPEditMode;

  edtObjectName.ReadOnly := not ERPEditMode;
  memDescription.ReadOnly := not ERPEditMode;


  self.BeginTransaction;

  if ERPEditMode then
    qryMain.SQL.Text := 'select * from tblerpschemaobject_master where ID = ' + IntToStr(KeyID)
  else
    qryMain.SQL.Text := 'select * from tblerpschemaobject where ID = ' + IntToStr(KeyID);

  qryMain.Open;

  if KeyID > 1 then begin
    edtObjectName.ReadOnly := true;
    cboTableName.ItemIndex := cboTableName.Items.IndexOf(qryMainTableName.AsString);
    cboTableName.Enabled := false;
    edtErpVersion.ReadOnly := true;
  end
  else begin
    qryMain.Insert;
    qryMainERPVersion.AsString := NextVersionStr;
    PostDb(qryMain);

  end;
  LoadDetail;


  //
end;

procedure TfmSchemaObjectEdit.grdDetailsDblClick(Sender: TObject);
var
  qry: TERPQuery;
  ID: integer;
begin
  inherited;
  if qryDetailPropertyType.AsInteger > 0 then begin
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := MyConnection;
      if ErpEditMode then begin
        qry.SQL.Add('select ID from tblerpschemaobject_master sc where sc.ObjectName = ' + QuotedStr(qryDetailFieldName.AsString));
        qry.SQL.Add('and sc.ID = (select max(ID) from tblerpschemaobject_master m where m.ObjectName = sc.ObjectName)');
        qry.Open;
        ID := qry.FieldByName('ID').AsInteger;
      end
      else begin
        qry.SQL.Add('select ID from tblerpschemaobject sc where sc.ObjectName = ' + QuotedStr(qryDetailFieldName.AsString));
        qry.SQL.Add('and sc.ID = (select max(ID) from tblerpschemaobject_master m where m.ObjectName = sc.ObjectName');
        qry.SQL.Add(' and m.ErpVersion <= "'+ VersionStr +'")');
        qry.Open;
        ID := qry.FieldByName('ID').AsInteger;
        if ID = 0 then
          exit;
      end;
    finally
      qry.Free;
    end;
    OpenERPForm('TfmSchemaObjectEdit',ID,nil,nil,false,false);
  end;

end;

procedure TfmSchemaObjectEdit.LoadDetail;
//var
//  qry: TERPQuery;
//  IsMaxVersion: boolean;
begin
  closeDb(qryDetail);
  qryDetail.SQL.Clear;



  if ERPEditMode then begin

//    qry := TERPQuery.Create(nil);
//    try
//      qry.Connection := myConnection;
//      qry.SQL.Text := 'select Max(ERPVersion) as Version from tblerpschemaobject_master' +
//       ' where ObjectName = ' + QuotedStr(qryMainObjectName.AsString);
//      qry.Open;
//      IsMaxVersion
//
//    finally
//      qry.Free;
//    end;

    qryDetail.SQL.Add('select * from tblerpschemaproperty_master');
    qryDetail.SQL.Add('where ObjectName = ' + QuotedStr(qryMainObjectName.AsString));
    if chkMaxVersion.Checked then
      qryDetail.SQL.Add('and ID = (select max(ID) from tblerpschemaproperty_master m' +
        ' where m.ObjectName = tblerpschemaproperty_master.ObjectName' +
        ' and m.PropertyName = tblerpschemaproperty_master.PropertyName)')
    else
      qryDetail.SQL.Add('and ID = (select max(ID) from tblerpschemaproperty_master m' +
        ' where m.ObjectName = tblerpschemaproperty_master.ObjectName' +
        ' and m.PropertyName = tblerpschemaproperty_master.PropertyName' +
        ' and m.ERPVersion <= :Version)');
    if chkVisibleOnly.Checked then
      qryDetail.SQL.Add('and Visible = "T"');
    qryDetail.SQL.Add('order by PropertyName');
    if not chkMaxVersion.Checked then begin
      qryDetail.ParamByName('Version').AsString := VersionStr; //qryMainERPVersion.AsString;
    end;
  end
  else begin
    qryDetail.SQL.Add('select * from tblerpschemaproperty');
    qryDetail.SQL.Add('where ObjectName = ' + QuotedStr(qryMainObjectName.AsString));
    qryDetail.SQL.Add('and Visible = "T"');
    qryDetail.SQL.Add('and ID = (select max(ID) from tblerpschemaproperty m' +
      ' where m.ObjectName = tblerpschemaproperty.ObjectName' +
      ' and m.PropertyName = tblerpschemaproperty_master.PropertyName' +
      ' and m.ERPVersion <= :Version)');
    qryDetail.SQL.Add('order by PropertyName');
    qryDetail.ParamByName('Version').AsString := VersionStr; //qryMainERPVersion.AsString;
  end;
  OpenDb(qryDetail);
end;

procedure TfmSchemaObjectEdit.qryDetailAfterInsert(DataSet: TDataSet);
begin
  inherited;
  if not ErpEditMode then
    Dataset.Cancel
  else begin
    Dataset.FieldByName('ObjectName').AsString := qryMainObjectName.AsString;
    Dataset.FieldByName('ErpVersion').AsString := NextVersionStr;

  end;


end;

procedure TfmSchemaObjectEdit.qryDetailCalcFields(DataSet: TDataSet);
begin
  inherited;
  case qryDetailPropertyType.AsInteger of
    0: qryDetailPropertyTypeName.AsString := 'Field';
    1: qryDetailPropertyTypeName.AsString := 'Object';
    2: qryDetailPropertyTypeName.AsString := 'Object List';
  end;

end;

function TfmSchemaObjectEdit.ValidateData: boolean;
begin
  result := false;
  if edtObjectName.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('Object Name missing.',mtInformation,[mbOk],0);
    exit;
  end;
  if cboTableName.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('Table Name missing.',mtInformation,[mbOk],0);
    exit;
  end;
  if edtErpVersion.Text = '' then begin
    CommonLib.MessageDlgXP_Vista('Version missing.',mtInformation,[mbOk],0);
    exit;
  end;
  result := true;
end;

initialization
  RegisterClass(TfmSchemaObjectEdit);

end.
