unit frmMySQLServerSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DNMSpeedButton, StdCtrls, BaseFormForm;

type
  TfmMySQLServerSelect = class(TForm)
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    edtServerName: TEdit;
    DNMSpeedButton1: TDNMSpeedButton;
    Label1: TLabel;
    lblLastGoodServer: TLabel;
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function GetMySQLServerFromUser(var ServerName: string; LastGoodServer: string): boolean;

implementation

{$R *.dfm}

uses
  MyAccess,ERPdbComponents, tcConst, AppDatabase, CommonLib;


function GetMySQLServerFromUser(var ServerName: string; LastGoodServer: string): boolean;
var
  frm: TfmMySQLServerSelect;
begin
  frm:= TfmMySQLServerSelect.Create(nil);
  try
    frm.edtServerName.Text:= ServerName;
    if LastGoodServer <> '' then
      frm.lblLastGoodServer.Caption:= 'Last connected server: ' + LastGoodServer
    else
      frm.lblLastGoodServer.Caption:= '';
    if frm.ShowModal = mrOk then begin
      result:= true;
      ServerName:= frm.edtServerName.Text;
    end
    else
      result:= false;
  finally
    frm.Free;
  end;
end;

procedure TfmMySQLServerSelect.DNMSpeedButton1Click(Sender: TObject);
var
  conn: TERPConnection;
begin
  inherited;
  if Trim(edtServerName.Text)  <> '' then begin
    conn:= TERPConnection.Create(nil);
    try
      conn.Server:= edtServerName.Text;
      conn.Database:= MYSQL_DATABASE;
      conn.Username:= SYSDB_USER;
      conn.Password:= SYSDB_PASS;
      conn.Options.Compress := MYDAC_OPTIONS_COMPRESS;
      conn.Options.Protocol := MYDAC_OPTIONS_PROTOCOL;
      conn.Port := MYSQL_PORT;
      conn.LoginPrompt:= false;
      try
        conn.Connected:= true;
        CommonLib.MessageDlgXP_Vista('Connected Ok!',mtInformation,[mbOk],0);
      except
        on E:Exception do begin
          CommonLib.MessageDlgXP_Vista('Unable to connect to server.'+NL+e.message,mtInformation,[mbOk],0);
        end;
      end;
    finally
      conn.Free;
    end;
  end; 
end;

procedure TfmMySQLServerSelect.FormCreate(Sender: TObject);
begin
  inherited;
  Color:= tcConst.cDefaultGradientColor;
end;

end.
