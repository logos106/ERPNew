unit frmActionApproved;
       //Authorisation form for Loading Rosters, Timesheets and doing Pays
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,  StdCtrls,
  ExtCtrls, DNMPanel, Buttons, DNMSpeedButton, wwdblook, DBAccess, MyAccess,ERPdbComponents, DataState,
  MemDS, Menus, AdvMenus, Shader, ImgList, ProgressDialog;

type
  TfrmActionApproved = class(TBaseInputGUI)
    cboUser: TwwDBLookupCombo;
    edtPwd: TEdit;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    qryUsers: TERPQuery;
    Bevel2: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    Label1: TLabel;
    lblAction: TLabel;
    Bevel1: TBevel;
    qryActionAuthorisation: TERPQuery;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtPwdDblClick(Sender: TObject);
  private
    { Private declarations }
    fiEmployeeID: integer;
    fsType: String;
    fsSuccess: String;
    function getPassword(const User: string): String;
  public
    { Public declarations }
    property AuthorisingEmpID: integer read fiEmployeeID;
    property ActionType: String read fsType write fsType;
    property Success: String read fsSuccess write fsSuccess;
    procedure SetActionSuccess(const sResult: String);
  end;

implementation

uses
  DnmLib, CommonLib, FastFuncs, CommonDbLib, SimpleEncrypt;

{$R *.dfm}

procedure TfrmActionApproved.FormCreate(Sender: TObject);
begin
  fbIgnoreAccessLevels := true;
  inherited;
end;

procedure TfrmActionApproved.btnSaveClick(Sender: TObject);
begin
  inherited;
  if Encrypt(edtPwd.Text, 'z') <> qryUsers.FieldByName('Logon_Password').AsString then begin
    CommonLib.MessageDlgXP_Vista('Password Does Not Match', mtWarning, [mbOK], 0);
    Self.ModalResult := mrNone;
    Exit;
  end;
  fiEmployeeID := qryUsers.FieldByName('EmployeeID').AsInteger;
  with qryActionAuthorisation do try
    Insert;
    FieldByName('Type').AsString :=  fsType;
    FieldByName('Who').AsString  := cboUser.Text;
    FieldByName('Date').AsDateTime := Now;
    Post;
  except

  end;
end;

procedure TfrmActionApproved.SetActionSuccess(const sResult: String);
begin
  with qryActionAuthorisation do try
    Open;
    Last;
    Edit;
    FieldByName('ActionSuccess').AsString := sResult;
    Post;
  except

  end;
end;

procedure TfrmActionApproved.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    edtPwd.Text := '';
    OpenQueries;
  finally
    EnableForm;
  end;
end;
procedure TfrmActionApproved.edtPwdDblClick(Sender: TObject);
begin
  inherited;
  if devmode then begin
       edtPwd.text:= getPassword(cboUser.Text);
  end;
end;
function TfrmActionApproved.getPassword(const User: string): String;
begin
  REsult := '';
  With tempMyQuery do try
      SQL.Text:= 'SELECT Logon_Password' +
                          ' FROM  tblPassword p ' +
                          ' WHERE Logon_Name =  ' +QuotedStr(User) ;
      Open;
      if recordcount > 0 then
        result := DeCrypt(Fields.FieldByName('Logon_Password').AsString, 'z');
  finally
    closenfree;
  end;
end;

procedure TfrmActionApproved.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

initialization
  RegisterClassOnce(TfrmActionApproved);

end.


