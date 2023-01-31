unit frmLicenceEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBaseEdit, DB, DBAccess, MyAccess, ActnList, StdCtrls,
  ExtCtrls, DBCtrls, wwdbedit, wwdbdatetimepicker, Mask, MemDS, wwcheckbox;

type
  TfmLicenceEdit = class(TfmBaseEdit)
    qryLicence: TMyQuery;
    dsLicence: TDataSource;
    Label1: TLabel;
    edtSoftwareName: TDBEdit;
    DBComboBox1: TDBComboBox;
    Label2: TLabel;
    Label3: TLabel;
    edtStatusReason: TDBEdit;
    dtpStartDate: TwwDBDateTimePicker;
    Label4: TLabel;
    Label5: TLabel;
    dtpExpireDate: TwwDBDateTimePicker;
    edtUsers: TwwDBEdit;
    Label6: TLabel;
    memNotes: TDBMemo;
    Label7: TLabel;
    Label8: TLabel;
    DBMemo1: TDBMemo;
    chkActive: TwwCheckBox;
    procedure actCancelExecute(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
    procedure qryLicenceBeforePost(DataSet: TDataSet);
  private
  protected
    function GetKeyId: integer; override;
    procedure SetKeyId(const Value: integer); override;
  public
    { Public declarations }
  end;

var
  fmLicenceEdit: TfmLicenceEdit;

implementation

{$R *.dfm}

uses
  utils, ComponentLib;

{ TfmLicenceEdit }

function TfmLicenceEdit.GetKeyId: integer;
begin
  result:= qryLicence.ParamByName('KeyID').AsInteger;
end;

procedure TfmLicenceEdit.SetKeyId(const Value: integer);
begin
  inherited;
  if TransConnection.InTransaction then
    TransConnection.Rollback;
  qryLicence.Close;
  qryLicence.ParamByName('KeyID').AsInteger:= Value;
  qryLicence.Open;
  if Value = 0 then
    qryLicence.Insert;
  TransConnection.StartTransaction;
end;

procedure TfmLicenceEdit.actCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmLicenceEdit.actOkExecute(Sender: TObject);
begin
  inherited;
  if Trim(edtSoftwareName.Text) = '' then begin
    MessageDlg('Software Name can not be blank.',mtWarning,[mbOk],0);
    exit;
  end;
  if qryLicence.State in [dsInsert,dsEdit] then
    qryLicence.Post;
  TransConnection.Commit;
  if Dirty then
    RefreshForm('TfmClientEdit');
  Close;
end;

procedure TfmLicenceEdit.qryLicenceBeforePost(DataSet: TDataSet);
begin
  inherited;
  qryLicence.FieldByName('datetime').AsDateTime:= nowUTC;
  qryLicence.FieldByName('user').AsString:= 'ERP';
  Dirty:= true;
end;

initialization
  RegisterClass(TfmLicenceEdit);

end.
