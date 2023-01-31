unit GoogleAuth;

interface

uses
  classes, ibgOAuth;

type
  TGoogleAuthThread = class(TThread)
  private
    FAuthString: string;
    auth: TibgOAuth;
    fRefreshToken: string;
    procedure DoReturnURL(Sender: TObject; const URLPath: String; const QueryString: String;var ResponseHeaders: String;var ResponseBody: String);
  protected
    procedure Execute; override;
  public
    constructor Create(aRefreshToken: string);
    destructor Destroy; override;
    property AuthString: string read FAuthString;
    property RefreshToken: string read fRefreshToken;
  end;

  function GetAuthorization(var aRefreshToken: string): string;

const
  AUTH_WAIT_SECONDS = 60;

implementation

uses
  GoogleConst, SysUtils; //, Dialogs;

const
  OneSec = (1/24/60/60);

function GetAuthorization(var aRefreshToken: string): string;
var
  authThread: TGoogleAuthThread;
  dt: TDateTime;
begin
  result := '';
  authThread := TGoogleAuthThread.Create(aRefreshToken);
  try
    dt := now + (OneSec * AUTH_WAIT_SECONDS) + OneSec;
    while (not authThread.Terminated) and (now < dt) do
      Sleep(1000);

    if authThread.Terminated then begin
      result := authThread.AuthString;
      aRefreshToken := authThread.RefreshToken;
    end;

  finally
    authThread.Free;
  end;
end;


{ TGoogleAuthThread }

constructor TGoogleAuthThread.Create(aRefreshToken: string);
begin
  FAuthString := '';
  FreeOnTerminate:= false;
  fRefreshToken := aRefreshToken;
  inherited Create(false);
end;

destructor TGoogleAuthThread.Destroy;
begin
  try
    auth.Free;
  except

  end;
  inherited;
end;

procedure TGoogleAuthThread.DoReturnURL(Sender: TObject; const URLPath,
  QueryString: String; var ResponseHeaders, ResponseBody: String);
begin
  { this is the default }
//  ResponseBody := '<html><body><h3 style=''color:green;margin:30px''>OAuth Get Authorization Successful!</h3></body></html>';
  ResponseBody := '<html><body><h3 style="color:blue;margin:30px">Authorization Successful!</h3></body></html>';

end;

procedure TGoogleAuthThread.Execute;
begin
  auth := TibgOAuth.Create(nil);
  auth.ClientProfile := cfApplication;
  auth.ClientId := GoogleConst.NATIVE_APP_CLIENT_ID;
  auth.ClientSecret := GoogleConst.NATIVE_APP_CLIENT_SECRET;
  auth.ServerAuthURL := 'https://accounts.google.com/o/oauth2/auth';
  auth.ServerTokenURL := 'https://accounts.google.com/o/oauth2/token';
  auth.AuthorizationScope := 'https://www.googleapis.com/auth/calendar';
  auth.Timeout := AUTH_WAIT_SECONDS;
  auth.OnReturnURL := DoReturnURL;
  try
    if FRefreshToken <> '' then
      auth.RefreshToken := FRefreshToken;
    FAuthString := auth.GetAuthorization;
    if FRefreshToken = '' then
      FRefreshToken := auth.RefreshToken;
  except
    on e: exception  do begin
      FAuthString := '';
    end;
  end;
  Terminate;
end;

end.
