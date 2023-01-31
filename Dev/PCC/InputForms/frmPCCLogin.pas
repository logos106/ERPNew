unit frmPCCLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DBAccess, MyAccess,
  SelectionDialog, AppEvnts, DB,  ExtCtrls, StdCtrls, DNMSpeedButton,
  DNMPanel, Shader;

type
  TPCCLogin = class(TBaseInputGUI)
    Attendant: TLabel;
    Password: TLabel;
    edtAttendant: TEdit;
    edtPassword: TEdit;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Bevel1: TBevel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure edtAttendantKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PCCLogin: TPCCLogin;

implementation

uses
  CommonLib;

{$R *.dfm}

procedure TPCCLogin.edtAttendantKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not (Key in ['0','1','2','3','4','5','6','7','8','9',#8]) then
    Key := #0;
end;

initialization
  RegisterClassOnce(TPCCLogin);

end.
