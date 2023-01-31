unit GoogleConfigObj;

interface

uses
  JsonDbPrefsConfigObj;

type

  TGoogleConfig = class(TJsonDbPefConfig)
  private
    function GetEmail: string;
    function GetPassword: string;
    procedure SetEmail(const Value: string);
    procedure SetPassword(const Value: string);
    function GetSynchWithGoogle: boolean;
    procedure SetSynchWithGoogle(const Value: boolean);
    function GetRefreshToken: string;
    procedure SetRefreshToken(const Value: string);
  public
    property Email: string read GetEmail write SetEmail;
    property Password: string read GetPassword write SetPassword;
    property RefreshToken: string read GetRefreshToken write SetRefreshToken;
    property SynchWithGoogle: boolean read GetSynchWithGoogle write SetSynchWithGoogle;
  end;


implementation

{ TGoogleConfig }

function TGoogleConfig.GetEmail: string;
begin
  result := S['Email'];
end;

function TGoogleConfig.GetPassword: string;
begin
  result := S['Password'];
end;

function TGoogleConfig.GetRefreshToken: string;
begin
  result := S['RefreshToken'];
end;

function TGoogleConfig.GetSynchWithGoogle: boolean;
begin
  result := B['SynchWithGoogle'];
end;

procedure TGoogleConfig.SetEmail(const Value: string);
begin
  S['Email'] := Value;
end;

procedure TGoogleConfig.SetPassword(const Value: string);
begin
  S['Password'] := Value;
end;

procedure TGoogleConfig.SetRefreshToken(const Value: string);
begin
  S['RefreshToken'] := Value;
end;

procedure TGoogleConfig.SetSynchWithGoogle(const Value: boolean);
begin
  B['SynchWithGoogle'] := Value;
end;

end.
