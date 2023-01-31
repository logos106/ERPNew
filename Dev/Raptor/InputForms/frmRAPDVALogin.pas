unit frmRAPDVALogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseWebBrowser, OleCtrls, SHDocVw, AppEvnts, ExtCtrls;

type
  TfmRAPDVALogin = class(TBaseWebBrowserGUI)
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses AppEnvironment, CommonLib;

{$R *.dfm}

procedure TfmRAPDVALogin.FormShow(Sender: TObject);
begin
  inherited;

    if (AppEnv.companyinfo.loginPage = '') then begin
        CommonLib.MessageDlgXP_Vista('DAV login web address is not provided', mtWarning, [mbok] , 0);
        Exit;
    end;
    WebBrowser.Navigate(AppEnv.companyinfo.LoginPage);
end;
procedure TfmRAPDVALogin.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
  inherited;

end;

initialization
  RegisterClassOnce(TfmRAPDVALogin);

end.
