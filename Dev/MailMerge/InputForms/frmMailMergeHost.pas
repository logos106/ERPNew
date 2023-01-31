unit frmMailMergeHost;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess,
  MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, ExtCtrls, MemDS, DNMSpeedButton,
  StdCtrls, wwcheckbox, Mask, wwdbedit, DNMPanel, ImgList, ProgressDialog;

type
  TfrmMMHostSetup = class(TBaseInputGUI)
    DNMPanel6: TDNMPanel;
    Label38: TLabel;
    pnlEmailFaxServerOptions: TDNMPanel;
    Bevel9: TBevel;
    Bevel8: TBevel;
    Label39: TLabel;
    Label41: TLabel;
    Label44: TLabel;
    Label46: TLabel;
    Label49: TLabel;
    lblUserID: TLabel;
    lblPassword: TLabel;
    Label52: TLabel;
    edAddress: TwwDBEdit;
    edFrom: TwwDBEdit;
    edSMTPHost: TwwDBEdit;
    edSMTPPort: TwwDBEdit;
    wwDBEdit10: TwwDBEdit;
    edtUserID: TwwDBEdit;
    edtPassword: TwwDBEdit;
    chkUseAuthentication: TwwCheckBox;
    cmdClose: TDNMSpeedButton;
    btnOK: TDNMSpeedButton;
    DSMMHost: TDataSource;
    qryMMHost: TERPQuery;
    btnLoadSystem: TDNMSpeedButton;
    procedure cmdCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure chkUseAuthenticationClick(Sender: TObject);
    procedure btnLoadSystemClick(Sender: TObject);
  private
    function Validate:Boolean;
  public
    { Public declarations }
  end;



implementation

{$R *.dfm}
uses
  CommonLib,AppEnvironment;
  
procedure TfrmMMHostSetup.cmdCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;


procedure TfrmMMHostSetup.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfrmMMHostSetup.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    qryMMHost.Open;
    if qryMMHost.RecordCount = 0 then qryMMHost.Insert
    else begin
      qryMMHost.First;
      qryMMHost.Edit;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmMMHostSetup.btnOKClick(Sender: TObject);
begin
  qryMMHost.Post;
  if not Validate then begin
    if CommonLib.MessageDlgXP_Vista('The host information is not complete, do you wish to enter the missing data?', mtConfirmation,
       [mbYes, mbNo], 0) = mrYes then exit;
  end;
  Close;
  inherited;
end;

function TfrmMMHostSetup.Validate:Boolean;
begin
  Result := True;
  if qryMMHost.fieldByName('EmailAddress').AsString = '' then Result := False;
  if qryMMHost.fieldByName('FromContact').AsString = '' then Result := False;
  if qryMMHost.fieldByName('SMTPHost').AsString = '' then Result := False;
  if qryMMHost.fieldByName('SMTPPort').AsInteger = 0 then Result := False;
  if qryMMHost.fieldByName('UseAuthentication').AsString = 'T' then begin
    if qryMMHost.fieldByName('UserID').AsString = '' then Result := False;
    if qryMMHost.fieldByName('UserPassword').AsString = '' then Result := False;
  end;
end;

procedure TfrmMMHostSetup.chkUseAuthenticationClick(Sender: TObject);
begin
  inherited;
  if TwwCheckBox(Sender).Checked then begin
    lblUserID.Enabled   := True;
    lblPassword.Enabled := True;
    edtUserID.Enabled   := True;
    edtPassword.Enabled := True;
  end else begin
    lblUserID.Enabled   := False;
    lblPassword.Enabled := False;
    edtUserID.Enabled   := False;
    edtPassword.Enabled := False;
  end;
end;

procedure TfrmMMHostSetup.btnLoadSystemClick(Sender: TObject);
begin
  inherited;
//  qryMMHost.FieldByName('EmailAddress').AsString := AppEnv.CompanyPrefs.EmailSystemAddress;
//  qryMMHost.FieldByName('FromContact').AsString := AppEnv.CompanyPrefs.EmailFromName;
//  qryMMHost.FieldByName('SMTPHost').AsString := AppEnv.CompanyPrefs.EmailSMTPHost;
//  qryMMHost.FieldByName('SMTPPort').AsInteger := AppEnv.CompanyPrefs.EmailSMTPPort;
//  if AppEnv.CompanyPrefs.EmailUseAuthentication then begin
//    qryMMHost.FieldByName('UseAuthentication').AsBoolean := True;
//    qryMMHost.FieldByName('UserID').AsString := AppEnv.CompanyPrefs.EmailAuthUserID;
//    qryMMHost.FieldByName('UserPassword').AsString := AppEnv.CompanyPrefs.EmailAuthPassword;
//  end else chkUseAuthentication.Checked := False;
end;

initialization
  RegisterClassOnce(TfrmMMHostSetup);
end.
