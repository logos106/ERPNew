unit frmServerEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBaseEdit, DNMSpeedButton, ExtCtrls, DNMPanel, MultisiteConfigObj,
  StdCtrls, Shader;

type
  TfmServerEdit = class(TfmBaseEdit)
    Label2: TLabel;
    edtServer: TEdit;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    function Validate: boolean;
  public
    { Public declarations }
  end;

  function DoServerEdit(config: TServerConfig): boolean;

implementation

{$R *.dfm}

function DoServerEdit(config: TServerConfig): boolean;
var
  form: TfmServerEdit;
begin
  form:= TfmServerEdit.Create(Application);
  try
    form.edtServer.Text:= Config.MySQLServer;
    result:= form.ShowModal = mrOk;
    if result then begin
      Config.MySQLServer:= form.edtServer.Text;
    end;
  finally
    form.Free;
  end;
end;


{ TfmSiteItemEdit }

function TfmServerEdit.Validate: boolean;
begin
  result:= false;
  if Trim(edtServer.Text) = '' then begin
    MessageDlg('Server can not be blank',mtInformation, [mbOk],0);
    exit;
  end;
  result:= true;
end;

procedure TfmServerEdit.btnOKClick(Sender: TObject);
begin
  inherited;
  if Validate then
    ModalResult:= mrOk;
end;

procedure TfmServerEdit.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult:= MrCancel;
end;

end.
