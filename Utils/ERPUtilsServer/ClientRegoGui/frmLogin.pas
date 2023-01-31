unit frmLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBaseEdit, DB, DBAccess, MyAccess, ActnList,
  ExtCtrls, StdCtrls;

type
  TfmLogin = class(TfmBaseEdit)
    Label1: TLabel;
    edtDatabase: TEdit;
    Label2: TLabel;
    edtServer: TEdit;
    procedure actCancelExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmLogin: TfmLogin;

implementation

{$R *.dfm}

uses
  AppDatabaseObj;

procedure TfmLogin.FormCreate(Sender: TObject);
begin
  inherited;
  edtDatabase.Text:= AppDatabase.DatabaseName;
  edtServer.Text:= AppDatabase.ServerName;
end;

procedure TfmLogin.actCancelExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmLogin.actOkExecute(Sender: TObject);
begin
  inherited;
  if Trim(edtDatabase.Text) = '' then begin
    MessageDlg('Database name is missing.',mtWarning,[mbOk],0);
    exit;
  end
  else if Trim(edtServer.Text) = '' then begin
    MessageDlg('Database name is missing.',mtWarning,[mbOk],0);
    exit;
  end;
  AppDatabase.Connection.Disconnect;
  AppDatabase.DatabaseName:= edtDatabase.Text;
  AppDatabase.ServerName:= edtServer.Text;
  AppDatabase.Connection.Connect;
  if not AppDatabase.Connection.Connected then begin
    MessageDlg('Unabe to connect to this Server/Database.',mtWarning,[mbOk],0);
    exit;
  end;
  Close;
end;

procedure TfmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:= caFree;
end;

initialization
  RegisterClass(TfmLogin);

end.
