unit UserGUI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, StdCtrls, Buttons,
  ExtCtrls, DNMPanel, Mask, DBCtrls, wwdbedit, wwdblook, wwcheckbox,
  DNMSpeedButton, Shader;

type
  TUser = class(TBaseInputGUI)
    qryMasterUserID: TLargeintField;
    qryMasterUserName: TStringField;
    qryMasterUserTypeID: TIntegerField;
    qryMasterLoginName: TStringField;
    qryMasterLoginPassword: TStringField;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    qryUserTypes: TMyQuery;
    UserType: TwwDBLookupCombo;
    UserName: TwwDBEdit;
    LoginName: TwwDBEdit;
    LoginPassword: TwwDBEdit;
    Bevel1: TBevel;
    Bevel2: TBevel;
    pnlCheckExceptionEmails: TDNMPanel;
    Label29: TLabel;
    wwCheckBox2: TwwCheckBox;
    qryMasterCheckExceptionEmails: TStringField;
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PrintClick(Sender: TObject);
    procedure pnlTitleMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    class function Instance: TBaseInputGUI; override;    
  end;

implementation

uses FormFactory;

{$R *.dfm}
var
  User: TUser;

{ TUser }

class function TUser.Instance: TBaseInputGUI;
begin
  if User = nil then begin
    User := TUser.Create(Application);
  end;
  result := User;
end;

procedure TUser.FormDestroy(Sender: TObject);
begin
  inherited;
  User := Nil;
end;

procedure TUser.FormShow(Sender: TObject);
begin
  qryMaster.Params.ParseSQL(qryMaster.SQL.Text, True);
  qryMaster.Params.ParamByName('xID').asInteger := KeyID;
  inherited;
  qryUserTypes.Open;
end;

procedure TUser.PrintClick(Sender: TObject);
begin
  ReportName:='User Details';
  Preview:=True;
  Dataset:=qryMaster;
  inherited;
end;

procedure TUser.pnlTitleMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if (Shift=[ssCtrl,ssShift,ssAlt]) then begin
     pnlCheckExceptionEmails.Visible := True;
  end;
end;

Initialization
  with FormFact do begin
    RegisterMe(TUser, 'TUsersList_*=UserID');
  end;
end.
