unit frmClientEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBaseEdit, DB, DBAccess, MyAccess, ActnList, DNMSpeedButton,
  ExtCtrls, StdCtrls, Mask, DBCtrls, MemDS, wwcheckbox, Grids, Wwdbigrd,
  Wwdbgrid, wwdbedit, Wwdotdot, Wwdbcomb, Buttons;

type
  TfmClientEdit = class(TfmBaseEdit)
    qryClient: TMyQuery;
    dsClient: TDataSource;
    pnlClient: TPanel;
    Label1: TLabel;
    edtName: TDBEdit;
    chkActive: TwwCheckBox;
    pnlServer: TPanel;
    Splitter1: TSplitter;
    pnlLicence: TPanel;
    Splitter2: TSplitter;
    pnlConfig: TPanel;
    grdServers: TwwDBGrid;
    grdLicence: TwwDBGrid;
    Panel1: TPanel;
    Label2: TLabel;
    Panel2: TPanel;
    Label3: TLabel;
    Panel3: TPanel;
    Label4: TLabel;
    grdConfig: TwwDBGrid;
    qryServers: TMyQuery;
    dsServers: TDataSource;
    dsLicence: TDataSource;
    qryLicence: TMyQuery;
    qryConfig: TMyQuery;
    dsConfig: TDataSource;
    edtConfigNotes: TwwDBEdit;
    cboReleaseType: TwwDBComboBox;
    Label5: TLabel;
    grdServersIButton: TwwIButton;
    grdLicenceIButton: TwwIButton;
    grdConfigIButton: TwwIButton;
    procedure actCancelExecute(Sender: TObject);
    procedure grdServersRowChanged(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
    procedure qryClientBeforePost(DataSet: TDataSet);
    procedure grdLicenceDblClick(Sender: TObject);
    procedure grdServersIButtonClick(Sender: TObject);
    procedure grdLicenceIButtonClick(Sender: TObject);
    procedure grdConfigIButtonClick(Sender: TObject);
  private
  protected
    function GetKeyId: integer; override;
    procedure SetKeyId(const Value: integer); override;
    procedure LoadConfig; override;
    procedure SaveConfig; override;
  public
    procedure RefreshData; override;
  end;

var
  fmClientEdit: TfmClientEdit;

implementation

{$R *.dfm}

uses
  Utils, AppConfigObj, GridFieldsObj, ComponentLib, MyScript;

{ TfmClientEdit }

function TfmClientEdit.GetKeyId: integer;
begin
  result:= qryClient.ParamByName('KeyID').AsInteger;
end;

procedure TfmClientEdit.SetKeyId(const Value: integer);
begin
  inherited;
  if TransConnection.InTransaction then
    TransConnection.Rollback;
  qryConfig.Close;
  qryClient.Close;
  qryClient.ParamByName('KeyID').AsInteger:= Value;
  qryClient.Open;
  if Value = 0 then
    qryClient.Insert;
  qryServers.ParamByName('clientid').AsInteger:= qryClient.FieldByName('id').AsInteger;
  qryServers.Open;
  TransConnection.StartTransaction;
end;

procedure TfmClientEdit.actCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmClientEdit.grdServersRowChanged(Sender: TObject);
begin
  inherited;
  if qryLicence.ParamByName('computerid').AsInteger <> qryServers.FieldByName('id').AsInteger then begin
    qryLicence.Close;
    qryLicence.ParamByName('computerid').AsInteger:= qryServers.FieldByName('id').AsInteger;
    qryLicence.Open;
  end;
  if qryConfig.ParamByName('computerid').AsInteger <> qryServers.FieldByName('id').AsInteger then begin
    qryConfig.Close;
    qryConfig.ParamByName('computerid').AsInteger:= qryServers.FieldByName('id').AsInteger;
    qryConfig.Open;
  end;
end;

procedure TfmClientEdit.actOkExecute(Sender: TObject);
begin
  inherited;
  if Trim(edtName.Text) = '' then begin
    MessageDlg('Client Name can not be blank.',mtWarning,[mbOk],0);
    exit;
  end;
  if qryClient.State in [dsInsert,dsEdit] then
    qryClient.Post;
  TransConnection.Commit;
  if Dirty then
    RefreshForm('TfmClientList');
  Close;
end;

procedure TfmClientEdit.qryClientBeforePost(DataSet: TDataSet);
begin
  inherited;
  qryClient.FieldByName('datetime').AsDateTime:= nowUTC;
  qryClient.FieldByName('user').AsString:= 'ERP';
  Dirty:= true;
end;

procedure TfmClientEdit.LoadConfig;
begin
  inherited;
  Inc(LoadingConfig);
  try
    if AppConfig.Data.O[ClassName].S['grdservers_selected'] <> '' then
      grdServers.Selected.Text:= AppConfig.Data.O[ClassName].S['grdservers_selected'];
    if AppConfig.Data.O[ClassName].S['grdlicence_selected'] <> '' then
      grdLicence.Selected.Text:= AppConfig.Data.O[ClassName].S['grdlicence_selected'];
    if AppConfig.Data.O[ClassName].S['grdconfig_selected'] <> '' then
      grdConfig.Selected.Text:= AppConfig.Data.O[ClassName].S['grdconfig_selected'];

  finally
    Dec(LoadingConfig);
  end;
end;

procedure TfmClientEdit.SaveConfig;
begin
  inherited;
  AppConfig.Data.O[ClassName].S['grdservers_selected']:= GetGridSelectedText(grdServers);
  AppConfig.Data.O[ClassName].S['grdlicence_selected']:= GetGridSelectedText(grdLicence);
  AppConfig.Data.O[ClassName].S['grdconfig_selected']:= GetGridSelectedText(grdConfig);
end;

procedure TfmClientEdit.grdLicenceDblClick(Sender: TObject);
var
  EditForm: TfmBaseEdit;
begin
  inherited;
  if (grdLicence.SelectedField.FieldName = 'notes') or
    (grdLicence.SelectedField.FieldName = 'datatext') then
    exit;
  EditForm:= TfmBaseEdit(CreateComponentInst('TfmLicenceEdit'));
  if Assigned(EditForm) then begin
    EditForm.KeyID:= qryLicence.FieldByName('id').AsInteger;
  end;
end;

procedure TfmClientEdit.RefreshData;
begin
  inherited;
  qryServers.Refresh;
  qryLicence.Refresh;
  qryConfig.Refresh;
end;

procedure TfmClientEdit.grdServersIButtonClick(Sender: TObject);
var
  script: TMyScript;
  sId: string;
begin
  inherited;
  if MessageDlg('This will permently delete this Server (' +
    qryServers.FieldByName('computername').AsString  +
    '), its Config records and all of its Licence records from the database, ' +
    'is that what you want to do?',mtWarning, [mbNo,mbYes],0) = mrYes then begin
    script:= TMyScript.Create(nil);
    try
      script.Connection := TransConnection;
      sId:= qryServers.FieldByName('id').AsString;
      script.SQL.Add('delete from tcomputer where id = ' + sId + ';');
      script.SQL.Add('delete from tsoftwarelicence where computerid = ' + sId + ';');
      script.SQL.Add('delete from tcomputerconfig where computerid = ' + sId + ';');
      script.Execute;
    finally
      script.Free;
    end;
    qryServers.Refresh;
    qryLicence.Refresh;
    qryConfig.Refresh;
  end;
end;

procedure TfmClientEdit.grdLicenceIButtonClick(Sender: TObject);
var
  script: TMyScript;
  sId: string;
begin
  inherited;
  if MessageDlg('This will permently delete this Licence record, ' +
    'is that what you want to do?',mtWarning, [mbNo,mbYes],0) = mrYes then begin
    script:= TMyScript.Create(nil);
    try
      script.Connection := TransConnection;
      sId:= qryLicence.FieldByName('id').AsString;
      script.SQL.Add('delete from tsoftwarelicence where id = ' + sId + ';');
      script.Execute;
    finally
      script.Free;
    end;
    qryLicence.Refresh;
  end;
end;

procedure TfmClientEdit.grdConfigIButtonClick(Sender: TObject);
var
  script: TMyScript;
  sId: string;
begin
  inherited;
  if MessageDlg('This will permently delete this Config record, ' +
    'is that what you want to do?',mtWarning, [mbNo,mbYes],0) = mrYes then begin
    script:= TMyScript.Create(nil);
    try
      script.Connection := TransConnection;
      sId:= qryConfig.FieldByName('id').AsString;
      script.SQL.Add('delete from tcomputerconfig where id = ' + sId + ';');
      script.Execute;
    finally
      script.Free;
    end;
    qryConfig.Refresh;
  end;
end;

initialization
  RegisterClass(TfmClientEdit);

end.
