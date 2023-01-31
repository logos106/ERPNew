unit POSCreditGUI;

interface
{$I ERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,  StdCtrls,
  ExtCtrls, DNMPanel, Buttons, DNMSpeedButton, wwdblook, DBAccess, MyAccess,ERPdbComponents, DataState,
  Menus, AdvMenus, MemDS, Shader, ImgList, ProgressDialog;

type
  TPOSCreditPopUp = class(TBaseInputGUI)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblCredit: TLabel;
    lblPrevBal: TLabel;
    lblNewBal: TLabel;
    lblDiff: TLabel;
    cboUser: TwwDBLookupCombo;
    edtPwd: TEdit;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryUsers: TERPQuery;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtPwdDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    fiEmployeeID: integer;
  end;



implementation

uses FastFuncs,Forms, DnmLib, CommonLib, tcDataUtils;

{$R *.dfm}

procedure TPOSCreditPopUp.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
end;

procedure TPOSCreditPopUp.btnSaveClick(Sender: TObject);
begin
  inherited;
  if Encrypt(edtPwd.Text, 'z') <> qryUsers.FieldByName('Logon_Password').AsString then begin
    CommonLib.MessageDlgXP_Vista('Password Does Not Match', mtWarning, [mbOK], 0);
    Self.ModalResult := mrNone;
    Exit;
  end;
  fiEmployeeID := qryUsers.FieldByName('EmployeeID').AsInteger;
end;

procedure TPOSCreditPopUp.FormShow(Sender: TObject);
begin
  inherited;
  edtPwd.Text := '';
  OpenQueries;
end;
procedure TPOSCreditPopUp.edtPwdDblClick(Sender: TObject);
begin
  inherited;
  {$IFDEF DevMode}
  edtPwd.text := getPassword(cboUser.Text)
  {$ENDIF}
end;

initialization
  RegisterClassOnce(TPOSCreditPopUp);

end.
