unit frmServerConnect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit, DNMSpeedButton, ExtCtrls, frmBaseEdit,
  Shader, DNMPanel;

type
  TfmServerConnect = class(TfmBaseEdit)
    edtServer: TEdit;
    edtPort: TAdvEdit;
    Label1: TLabel;
    Label2: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetUserConnectInfo(var aServer: string; var aPort: integer): boolean;


implementation

{$R *.dfm}

function GetUserConnectInfo(var aServer: string; var aPort: integer): boolean;
var
  form: TfmServerConnect;
begin
  result:= false;
  form:= TfmServerConnect.Create(Application);
  try
    form.edtServer.Text:= aServer;
    form.edtPort.IntValue:= aPort;
    if form.ShowModal = mrOk then begin
      aServer:= form.edtServer.Text;
      aPort:= form.edtPort.IntValue;
      result:= true;
    end;
  finally
    form.Free;
  end;
end;

end.
