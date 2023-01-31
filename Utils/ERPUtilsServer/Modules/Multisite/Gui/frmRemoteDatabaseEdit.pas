unit frmRemoteDatabaseEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBaseEdit, DNMSpeedButton, ExtCtrls, DNMPanel, MultisiteConfigObj,
  StdCtrls, Shader;

type
  TfmRemoteDatabaseEdit = class(TfmBaseEdit)
    Label1: TLabel;
    edtDatabaseName: TEdit;
    Label2: TLabel;
    edtServer: TEdit;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    function Validate: boolean;
  public
    { Public declarations }
  end;

  function DoRemoteDatabaseEdit(config: TRemoteDatabase): boolean;

implementation

{$R *.dfm}

function DoRemoteDatabaseEdit(config: TRemoteDatabase): boolean;
var
  form: TfmRemoteDatabaseEdit;
begin
  form:= TfmRemoteDatabaseEdit.Create(Application);
  try
    form.edtDatabaseName.Text:= Config.DatabaseName;
    form.edtServer.Text:= Config.MySQLServer;
    result:= form.ShowModal = mrOk;
    if result then begin
      Config.DatabaseName:= form.edtDatabaseName.Text;
      Config.MySQLServer:= form.edtServer.Text;
    end;
  finally
    form.Free;
  end;
end;


{ TfmSiteItemEdit }

function TfmRemoteDatabaseEdit.Validate: boolean;
begin
  result:= false;
  if Trim(edtServer.Text) = '' then begin
    MessageDlg('Server can not be blank',mtInformation, [mbOk],0);
    exit;
  end;
  if Trim(edtDatabaseName.Text) = '' then begin
    MessageDlg('Database Name can not be blank',mtInformation, [mbOk],0);
    exit;
  end;
  result:= true;
end;

procedure TfmRemoteDatabaseEdit.btnOKClick(Sender: TObject);
begin
  inherited;
  if Validate then
    ModalResult:= mrOk;
end;

procedure TfmRemoteDatabaseEdit.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult:= MrCancel;
end;

end.
