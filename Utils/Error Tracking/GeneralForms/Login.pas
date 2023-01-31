unit Login;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, BaseInputForm, ExtCtrls, DNMPanel, DB, ADODB, Mask, wwdbedit,
  Wwdotdot, Wwdbcomb, wwdblook, MemDS, DBAccess, MyAccess, MyBackup,
  DNMSpeedButton, Shader;

type
  TLoginGUI = class(TBaseInputGUI)
    Label1: TLabel;
    Password: TEdit;
    Label2: TLabel;
    User: TwwDBLookupCombo;
    procedure cmdCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure CancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    WrongPassCount:Integer;
  public
    { Public declarations }
   class function Instance: TBaseInputGUI; override;    
  end;

implementation
  uses FuncLib,BaseDataMod,Messages,UserInfoObj, Dialogs;
{$R *.dfm}

var
  LoginGUI: TLoginGUI;

{ TLoginGUI }

procedure TLoginGUI.cmdCancelClick(Sender: TObject);
begin
 Application.Terminate;
end;

class function TLoginGUI.Instance: TBaseInputGUI;
begin
  if LoginGUI = nil then begin
    LoginGUI := TLoginGUI.Create(Application);
  end;
  result := LoginGUI;
end;

procedure TLoginGUI.FormShow(Sender: TObject);
begin
  inherited;
  qryMaster.Open;
  User.Text := BaseDataModule.AutoLogin_User;
  Password.Text := BaseDataModule.AutoLogin_Password;
  If Save.Enabled And Not Empty(User.Text) Then Save.Click;
end;

procedure TLoginGUI.SaveClick(Sender: TObject);
begin
  If Empty(User.Text) Then Begin
    MessageDlg('No User !', mtConfirmation, [mbOK], 0);
    Exit;
  end;

  If ValidateLogin(User.Text,Password.Text) Then Begin
     qryMaster.Locate('LoginName',User.Text,[loCaseInsensitive]);
     TUserInfoObj.Instance(qryMaster.FieldByName('UserID').AsInteger);
     PostMessage(Self.Handle, WM_CLOSE, 0, 0);
     Exit;
  end else begin
     MessageDlg('Wrong Password !', mtConfirmation, [mbOK], 0);
     If WrongPassCount>2 then begin
      Application.Terminate;
      Exit;
     end;
     Inc(WrongPassCount);
  end;
end;

procedure TLoginGUI.CancelClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TLoginGUI.FormCreate(Sender: TObject);
begin
  inherited;
  WrongPassCount := 0;
end;

procedure TLoginGUI.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  inherited;
end;

end.

