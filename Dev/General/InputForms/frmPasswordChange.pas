unit frmPasswordChange;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, Menus, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel;

type
  TfmPasswordChange = class(TfrmBaseGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label3: TLabel;
    edtPassword: TEdit;
    Label1: TLabel;
    edtConfirmation: TEdit;
    procedure btnOkClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    fNewPassword: string;
    fDatabase: string;
    fUser: string;
    fServer: string;
    fExistingPassword: string;
    function DoChangePassword: boolean;
  protected
    function ignorelogInuseform: boolean; override;
  public
    property Server: string read fServer write fServer;
    property Database: string read fDatabase write fDatabase;
    property User: string read fUser write fUser;
    property NewPassword: string read fNewPassword write fNewPassword;
    property ExistingPassword: string read fExistingPassword write fExistingPassword;
  end;

  function ChangePassword(const aServer, aDatabase, aUser: string;
    var aNewPassword: string; aExistingPassword: string = ''): boolean;

implementation

{$R *.dfm}

uses
  CommonLib, ERPDbComponents, DBUtils, SimpleEncrypt, DnMLib, tcConst,
  CommonDbLib, AppEnvironment, PasswordConfigObj;


function ValidateUser(const aServer, aDatabase, aUser, aPass: string): boolean;
var
  conn: TERPConnection;
  qry: TERPQuery;
  pass: string;
  //newPass: string;
begin
  result := true;
  { we need to validate existing password first }
  conn := DBUtils.GetNewDbConnection(aServer,aDatabase);
  qry := TERPQuery.Create(nil);
  try
    conn.Connect;
    qry.Connection := conn;
    qry.SQL.Text := 'select * from tblpassword where Logon_Name = ' + QuotedStr(aUser);
    qry.Open;
    pass := DeCrypt(qry.Fields.FieldByName('Logon_Password').AsString, 'z');

    //if pass <> aPass then begin
    if not(sametext(pass , aPass)) then begin
      MessageDlgXP_Vista('Invalid Logon Name and/or Password.', mtInformation, [mbOK], 0);
      result := false;
    end;
  finally
    qry.Free;
    conn.Free;
  end;
end;

function ChangePassword(const aServer, aDatabase, aUser: string;
  var aNewPassword: string; aExistingPassword: string): boolean;
var
  form: TfmPasswordChange;
begin
  if aExistingPassword <> '' then begin
    if not ValidateUser(aServer, aDatabase, aUser, aExistingPassword) then begin
      result := false;
      exit;
    end;
  end;

  form := TfmPasswordChange.Create(nil);
  try
    form.Database := aDatabase;
    form.Server := aServer;
    form.User := aUser;
    form.ExistingPassword := aExistingPassword;
    result := form.ShowModal = mrOk;
    if result then
      aNewPassword := form.NewPassword;
  finally
    form.Free;
  end;
end;

{ TfmPasswordChange }

procedure TfmPasswordChange.btnOkClick(Sender: TObject);
begin
  inherited;
  if DoChangePassword then
    ModalResult := mrOK;
end;

function TfmPasswordChange.DoChangePassword: boolean;
var
  conn: TERPConnection;
  qry: TERPQuery;
  pass, newPass: string;
  msg: string;
  passConfig: TPasswordConfig;
begin
  result := false;
  if Trim(edtPassword.Text) = '' then begin
    CommonLib.MessageDlgXP_Vista('Please enter a password.',mtInformation,[mbOk],0);
    exit;
  end;
  if Trim(edtConfirmation.Text) = '' then begin
    CommonLib.MessageDlgXP_Vista('Please re-enter your password in the Verify Password box.',mtInformation,[mbOk],0);
    exit;
  end;
  if edtConfirmation.Text <> edtPassword.Text then begin
    CommonLib.MessageDlgXP_Vista('The two passwords do not match.',mtInformation,[mbOk],0);
    exit;
  end;

  newPass := edtPassword.Text;

  conn := DBUtils.GetNewDbConnection(fServer,fDatabase);
  qry := TERPQuery.Create(nil);
  passConfig := TPasswordConfig.Create;
  try
    conn.Connect;
    passConfig.Load(conn);
    if not passConfig.PasswordValid(newPass, msg) then begin
      CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
      exit;
    end;
    qry.Connection := conn;
    qry.SQL.Text := 'select * from tblpassword where Logon_Name = ' + QuotedStr(fUser);
    qry.Open;
    if qry.IsEmpty then raise Exception.Create(Classname + ' Error - User not found.');
    pass := DeCrypt(qry.Fields.FieldByName('Logon_Password').AsString, 'z');
    if SameText(newPass, pass) then begin
      CommonLib.MessageDlgXP_Vista('The new password must be different than your old password.',mtInformation,[mbOk],0);
      exit;
    end;

    { ok now change it }
    NewPassword := newPass;
    qry.Edit;
    qry.Fields.FieldByName('Logon_Password').AsString := EnCrypt(newPass, 'z');
    qry.FieldByName('PasswordDate').AsDateTime := Date;
    qry.Post;
    result := true;
  finally
    qry.Free;
    conn.Free;
    passConfig.Free;
  end;

end;

procedure TfmPasswordChange.FormPaint(Sender: TObject);
begin
  pnlTitle.Color := cDefaultGradientColor;
  TitleShader.FromColor := cDefaultGradientColor;
  TitleShader.ToColorMirror := cDefaultGradientColor;
  inherited;
  PaintGradientColor(Self, True);
end;

function TfmPasswordChange.ignorelogInuseform: boolean;
begin
  result := true;
end;

end.
