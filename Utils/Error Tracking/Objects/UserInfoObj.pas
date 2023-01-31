unit UserInfoObj;

interface

Uses
  Classes,MyAccess;

Type
  TUserInfoObj = class(TObject)
  private
    fiUserID: Integer;
    fsUserName: String;
    fsUserType: String;
    fbCheckExceptionEmails: Boolean;
    constructor Create(Const UserID:Integer); 
  public
    class procedure Instance(Const UserID:Integer);
    procedure PopulateMe(Const UserID:Integer);
    property UserID: Integer read fiUserID;
    property UserName: String read fsUserName;
    property UserType: String read fsUserType;
    property CheckExceptionEmails: Boolean read fbCheckExceptionEmails;
  end;

var
  UserInfo: TUserInfoObj;

implementation

Uses
  SysUtils,Forms,BaseDataMod, FastFuncs;

class procedure TUserInfoObj.Instance(Const UserID:Integer);
begin
  if not Assigned(UserInfo) then begin
    UserInfo := TUserInfoObj.Create(UserID);
  end;
end;

constructor TUserInfoObj.Create(Const UserID:Integer);
begin
  inherited Create;
  PopulateMe(UserID);
end;

procedure TUserInfoObj.PopulateMe(Const UserID:Integer);
var
  TempQry: TMyQuery;
begin
  TempQry := TMyQuery.Create(nil);
  try
    TempQry.Options.FlatBuffers := True;
    TempQry.Connection := BaseDataModule.NonTransDBConnection;
    TempQry.SQL.Clear;
    TempQry.SQL.Add('SELECT users.userid, users.username, usertypes.usertype, users.loginName, users.loginpassword, ');
    TempQry.SQL.Add('users.checkexceptionemails ');
    TempQry.SQL.Add('FROM users ');
    TempQry.SQL.Add('INNER JOIN usertypes ON users.usertypeid = usertypes.usertypeid ');
    TempQry.SQL.Add('WHERE users.userid= '+ FastFuncs.IntToStr(UserID)+';');
    TempQry.Open;
    If (TempQry.RecordCount>0) Then Begin
      fiUserID := TempQry.FieldByName('userid').asInteger;
      fsUserName := TempQry.FieldByName('username').asString;
      fsUserType := TempQry.FieldByName('usertype').asString;
      fbCheckExceptionEmails := (TempQry.FieldByName('checkexceptionemails').asString='True');
    end;
   finally
    TempQry.Free;
  end;
end;

Initialization
finalization
  if Assigned(UserInfo) then begin
    UserInfo.free;
  end;
end.
