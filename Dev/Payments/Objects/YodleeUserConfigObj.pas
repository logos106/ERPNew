unit YodleeUserConfigObj;

interface

uses
  JsonDbPrefsConfigObj;

type

  {$M+}
  TYodleeUserConfig = class(TJsonDbPefConfig)
  private
    function GetDecodedPassword: string;
    function GetEmail: string;
    function GetLoginName: string;
    function GetPassword: string;
    procedure SetDecodedPassword(const Value: string);
    procedure SetEmail(const Value: string);
    procedure SetLoginName(const Value: string);
    procedure SetPassword(const Value: string);
  public
    property DecodedPassword: string read GetDecodedPassword write SetDecodedPassword;
  published
    property LoginName: string read GetLoginName write SetLoginName;
    property Password: string read GetPassword write SetPassword;
    property Email: string read GetEmail write SetEmail;
  end;
  {$M-}


implementation

uses
  CipherUtils;

{ TYodleeUserConfig }

function TYodleeUserConfig.GetDecodedPassword: string;
begin
  result := Password;
  if result <> '' then
    password := CipherUtils.DecryptString(result);
end;

function TYodleeUserConfig.GetEmail: string;
begin
  result := S['Email'];
end;

function TYodleeUserConfig.GetLoginName: string;
begin
  result := S['LoginName'];
end;

function TYodleeUserConfig.GetPassword: string;
begin
  result := S['Password'];
end;

procedure TYodleeUserConfig.SetDecodedPassword(const Value: string);
begin
  if Value = '' then
    Password := Value
  else
    Password := CipherUtils.EncryptString(Value);
end;

procedure TYodleeUserConfig.SetEmail(const Value: string);
begin
  S['Email'] := Value;
end;

procedure TYodleeUserConfig.SetLoginName(const Value: string);
begin
  S['LoginName'] := Value;
end;

procedure TYodleeUserConfig.SetPassword(const Value: string);
begin
  S['Password'] := Value;
end;

end.
