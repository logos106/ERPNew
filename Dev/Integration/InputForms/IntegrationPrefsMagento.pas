unit IntegrationPrefsMagento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, wwcheckbox, ExtCtrls, DNMPanel, DNMSpeedButton,
  AdvGroupBox, AdvOfficeButtons, Mask, AdvSpin;

type
  TIntegrationPrefsMagentoGUI = class(TForm)
    pnlMagentoConfig: TDNMPanel;
    Bevel1: TBevel;
    lblTitle: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtConsumer_Secret: TEdit;
    edtConsumer_Key: TEdit;
    chkShowMagentoOnMainMenu: TwwCheckBox;
    dtAuthTokenGeneratedAt: TDateTimePicker;
    edtAccess_Token: TEdit;
    edtAccess_Token_Secret: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    dtTokenExpireTime: TDateTimePicker;
    Bevel2: TBevel;
    Label3: TLabel;
    edtAPI_Base_URL: TEdit;
    Label9: TLabel;
    edtAdminUserName: TEdit;
    Label10: TLabel;
    edtAdminPassword: TEdit;
    btnHelp: TDNMSpeedButton;
    Optsalestype: TAdvOfficeRadioGroup;
    Label11: TLabel;
    Label12: TLabel;
    edtSynchPageSize: TAdvSpinEdit;
    Label13: TLabel;
    Label14: TLabel;
    edtCompanyId: TEdit;
    chkEnableMagento: TwwCheckBox;
    OptProductnameMaping: TAdvOfficeRadioGroup;
    Label15: TLabel;
    Label16: TLabel;
    chkPrintNameToShortDes: TwwCheckBox;
    Bevel3: TBevel;
    chkCopyProductinfoToERP: TwwCheckBox;
    lblPrintNameToShortDes: TLabel;
    lblCopyProductinfoToERP: TLabel;
    Label17: TLabel;
    OptCustomerIDType: TAdvOfficeRadioGroup;
    lbMagento: TLabel;
    chkAutosynchList: TwwCheckBox;
    procedure chkEnableMagentoClick(Sender: TObject);
    procedure chkShowMagentoOnMainMenuClick(Sender: TObject);
    procedure edtAPI_Base_URLChange(Sender: TObject);
    procedure edtConsumer_KeyChange(Sender: TObject);
    procedure edtconsumer_secretChange(Sender: TObject);
    procedure edtAccess_TokenChange(Sender: TObject);
    procedure edtAccess_Token_SecretChange(Sender: TObject);
    procedure edtAdminUserNameChange(Sender: TObject);
    procedure edtAdminPasswordChange(Sender: TObject);
    procedure chkAutosynchListClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OptsalestypeClick(Sender: TObject);
    procedure edtSynchPageSizeChange(Sender: TObject);
    procedure edtCompanyIdChange(Sender: TObject);
    procedure edtConsumer_SecretMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edtConsumer_SecretMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edtAccess_Token_SecretMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure edtAccess_Token_SecretMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure edtAdminPasswordMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edtAdminPasswordMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OptProductnameMapingClick(Sender: TObject);
    procedure chkPrintNameToShortDesClick(Sender: TObject);
    procedure chkCopyProductinfoToERPClick(Sender: TObject);
    procedure OptCustomerIDTypeClick(Sender: TObject);
  private
    function MagetoHelpString: String;
    { Private declarations }
  public
    procedure Load;
    procedure Save;
  end;

implementation

uses AppEnvironment, CommonDbLib, tcConst, CommonLib;

{$R *.dfm}

{ TIntegrationPrefsMagentoGUI }

Function TIntegrationPrefsMagentoGUI.MagetoHelpString:String;
begin
  result := 'Login to the Magento Admin Page.'+NL+
            'Choose Settings->Integeration-> Add New Integeration.'+NL+
            'Provide the Details and Choose the Modules for API(Preferably All).'+NL+NL+
            'This Will Produce The Magento API Credentials.';
  if devmode then
    result := result + NL+NL+
              'http://192.168.1.115:8080/trueerpmagento/admin_1tujdw/' +NL+
              'Username: erpadmin'+NL+
              'Password: trueerpmag12345';
end;
procedure TIntegrationPrefsMagentoGUI.OptCustomerIDTypeClick(Sender: TObject);
begin
  if OptCustomerIDType.itemindex =0 then AppEnv.CompanyPrefs.MagentoConfig.Magento_CustomerID  := 'CustomerName'
                               else AppEnv.CompanyPrefs.MagentoConfig.Magento_CustomerID  := 'Email';

end;

procedure TIntegrationPrefsMagentoGUI.OptProductnameMapingClick(
  Sender: TObject);
begin
  if OptProductnameMaping.itemindex =0 then AppEnv.CompanyPrefs.MagentoConfig.Magento_ProductName  := 'ProductName'
                                       else AppEnv.CompanyPrefs.MagentoConfig.Magento_ProductName  := 'PrintName';

end;

procedure TIntegrationPrefsMagentoGUI.OptsalestypeClick(Sender: TObject);
begin
  if Optsalestype.itemindex =0 then AppEnv.CompanyPrefs.MagentoConfig.Magento_SalesType  := 'Sales Order'
                               else AppEnv.CompanyPrefs.MagentoConfig.Magento_SalesType  := 'Invoice';
end;

procedure TIntegrationPrefsMagentoGUI.btnHelpClick(Sender: TObject);
begin
  MessageDlgXP_Vista(MagetoHelpString, mtInformation, [mbOK], 0);
end;
procedure TIntegrationPrefsMagentoGUI.FormCreate(Sender: TObject);
begin
  inherited;
  btnHelp.hint := MagetoHelpString;
  btnHelp.Showhint := True;
  OptProductnameMaping.items[0]   := AppEnv.DefaultClass.PartColumn;
  OptProductnameMaping.items[1]   := AppEnv.CompanyPrefs.ProductPrintNameHeading;
  chkCopyProductinfoToERP.caption := lblCopyProductinfoToERP.caption;
  chkPrintNameToShortDes.caption  := lblPrintNameToShortDes.caption;
end;

procedure TIntegrationPrefsMagentoGUI.chkAutosynchListClick         (Sender: TObject);begin  if not chkAutosynchList.Focused         then exit;  AppEnv.CompanyPrefs.MagentoConfig.AutosynchList          := chkAutosynchList.Checked      ;end;
procedure TIntegrationPrefsMagentoGUI.chkCopyProductinfoToERPClick  (Sender: TObject);begin  if not chkCopyProductinfoToERP.Focused   then exit;  AppEnv.CompanyPrefs.MagentoConfig.Magento_CopyProductinfoToERP:= chkCopyProductinfoToERP.Checked;end;
procedure TIntegrationPrefsMagentoGUI.chkEnableMagentoClick         (Sender: TObject);begin  if not chkEnableMagento.Focused         then exit;  AppEnv.CompanyPrefs.MagentoConfig.EnableMagento          := chkEnableMagento.Checked      ;end;
procedure TIntegrationPrefsMagentoGUI.chkPrintNameToShortDesClick   (Sender: TObject);begin  if not chkPrintNameToShortDes.Focused   then exit;  AppEnv.CompanyPrefs.MagentoConfig.Magento_PrintNameToShortDesc:= chkPrintNameToShortDes.Checked;end;
procedure TIntegrationPrefsMagentoGUI.chkShowMagentoOnMainMenuClick (Sender: TObject);begin  if not chkShowMagentoOnMainMenu.Focused then exit;  AppEnv.CompanyPrefs.MagentoConfig.ShowMagentoOnMainMenu  := chkShowMagentoOnMainMenu.Checked;end;
procedure TIntegrationPrefsMagentoGUI.edtAPI_Base_URLChange         (Sender: TObject);begin  AppEnv.CompanyPrefs.MagentoConfig.API_Base_URL         := edtAPI_Base_URL.Text       ; end;
procedure TIntegrationPrefsMagentoGUI.edtCompanyIdChange            (Sender: TObject);begin  AppEnv.CompanyPrefs.MagentoConfig.Companyid            := edtCompanyid.Text          ; end;
procedure TIntegrationPrefsMagentoGUI.edtConsumer_KeyChange         (Sender: TObject);begin  AppEnv.CompanyPrefs.MagentoConfig.Consumer_Key         := edtConsumer_Key.Text       ; end;
procedure TIntegrationPrefsMagentoGUI.edtconsumer_secretChange      (Sender: TObject);begin  AppEnv.CompanyPrefs.MagentoConfig.consumer_secret      := edtconsumer_secret.Text    ; end;

procedure TIntegrationPrefsMagentoGUI.edtAccess_TokenChange         (Sender: TObject);begin  AppEnv.CompanyPrefs.MagentoConfig.Access_Token         := edtAccess_Token.Text       ; end;
procedure TIntegrationPrefsMagentoGUI.edtAccess_Token_SecretChange  (Sender: TObject);begin  AppEnv.CompanyPrefs.MagentoConfig.Access_Token_Secret  := edtAccess_Token_Secret.Text; end;
procedure TIntegrationPrefsMagentoGUI.edtAdminUserNameChange        (Sender: TObject);begin  AppEnv.CompanyPrefs.MagentoConfig.AdminUserName        := edtAdminUserName.Text      ; end;
procedure TIntegrationPrefsMagentoGUI.edtAdminPasswordChange        (Sender: TObject);begin  AppEnv.CompanyPrefs.MagentoConfig.AdminPassword        := edtAdminPassword.Text      ; end;
procedure TIntegrationPrefsMagentoGUI.edtSynchPageSizeChange        (Sender: TObject);begin  AppEnv.CompanyPrefs.MagentoConfig.Magento_SynchPageSize:= edtSynchPageSize.Value     ; end;

procedure TIntegrationPrefsMagentoGUI.edtConsumer_SecretMouseDown    (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);begin  if not devmode then exit; edtConsumer_Secret.Passwordchar    := chr(0);end;
procedure TIntegrationPrefsMagentoGUI.edtAccess_Token_SecretMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);begin  if not devmode then exit; edtAccess_Token_Secret.Passwordchar:= chr(0);end;
procedure TIntegrationPrefsMagentoGUI.edtAdminPasswordMouseDown      (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);begin  if not devmode then exit; edtAdminPassword.Passwordchar    := chr(0);end;
procedure TIntegrationPrefsMagentoGUI.edtConsumer_SecretMouseUp      (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);begin  if not devmode then exit; edtConsumer_Secret.Passwordchar    := '*'   ;end;
procedure TIntegrationPrefsMagentoGUI.edtAccess_Token_SecretMouseUp  (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);begin  if not devmode then exit; edtAccess_Token_Secret.Passwordchar:= '*'   ;end;
procedure TIntegrationPrefsMagentoGUI.edtAdminPasswordMouseUp        (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);begin  if not devmode then exit; edtAdminPassword.Passwordchar    := '*'   ;end;

procedure TIntegrationPrefsMagentoGUI.Load;
begin
  chkEnableMagento.checked        := AppEnv.CompanyPrefs.MagentoConfig.EnableMagento        ;
  chkShowMagentoOnMainMenu.checked:= AppEnv.CompanyPrefs.MagentoConfig.ShowMagentoOnMainMenu;
  chkCopyProductinfoToERP.checked := AppEnv.CompanyPrefs.MagentoConfig.Magento_CopyProductinfoToERP;
  chkAutosynchList.checked        := AppEnv.CompanyPrefs.MagentoConfig.AutosynchList        ;
  chkPrintNameToShortDes.checked  := AppEnv.CompanyPrefs.MagentoConfig.Magento_PrintNameToShortDesc;
  edtAPI_Base_URL.Text            := AppEnv.CompanyPrefs.MagentoConfig.API_Base_URL         ;
  edtConsumer_Key.Text            := AppEnv.CompanyPrefs.MagentoConfig.Consumer_Key         ;
  edtConsumer_Secret.Text         := AppEnv.CompanyPrefs.MagentoConfig.Consumer_Secret      ;
  edtAccess_Token.Text            := AppEnv.CompanyPrefs.MagentoConfig.Access_Token         ;
  edtAccess_Token_Secret.Text     := AppEnv.CompanyPrefs.MagentoConfig.Access_Token_Secret  ;
  edtAdminUserName.Text           := AppEnv.CompanyPrefs.MagentoConfig.AdminUserName        ;
  edtCompanyid.Text               := AppEnv.CompanyPrefs.MagentoConfig.Companyid        ;
  edtAdminPassword.Text           := AppEnv.CompanyPrefs.MagentoConfig.AdminPassword        ;
  edtSynchPageSize.Value          := AppEnv.CompanyPrefs.MagentoConfig.Magento_SynchPageSize;
  dtAuthTokenGeneratedAt.Datetime := AppEnv.CompanyPrefs.MagentoConfig.AuthTokenGeneratedAt ;
  dtTokenExpireTime.Datetime   := AppEnv.CompanyPrefs.MagentoConfig.TokenExpireTime    ;
  if AppEnv.CompanyPrefs.MagentoConfig.Magento_SalesType  = 'Sales Order' then   Optsalestype.itemindex := 0 else Optsalestype.itemindex := 1;
  if AppEnv.CompanyPrefs.MagentoConfig.Magento_ProductName= 'PrintName' then   OptProductnameMaping.itemindex := 1 else OptProductnameMaping.itemindex := 0;
  if AppEnv.CompanyPrefs.MagentoConfig.Magento_CustomerID  = 'CustomerName' then   OptCustomerIDType.itemindex := 0 else OptCustomerIDType.itemindex := 1;
end;

procedure TIntegrationPrefsMagentoGUI.Save;
begin
  AppEnv.CompanyPrefs.MagentoConfig.Save(CommonDbLib.GetSharedMyDacConnection);
end;
{
Auth Token

POST /trueerpmagento/index.php/rest/V1/integration/admin/token?Consumer Key=4l6vp2segovppvx6s0c4jkwvttzaw7ba&amp; Consumer Secret=59ppt4jtxmoy7jlfe5pwve1swvzm10nl&amp; Access Token=ycr9hoy488pfwjbu3rm6c43da90ejy25&amp; Access Token Secret=j3i2qlptvitcc36lsm1va327y4vmaxew&amp; username=erpadmin&amp; password=trueerpadminroot123 HTTP/1.1
Host: 192.168.1.122
Authorization: OAuth oauth_consumer_key="4l6vp2segovppvx6s0c4jkwvttzaw7ba",oauth_token="ycr9hoy488pfwjbu3rm6c43da90ejy25",oauth_signature_method="HMAC-SHA1",oauth_timestamp="1576299323",oauth_nonce="hk1iaWuinBy",oauth_version="1.0",oauth_signature="pKdYQBXx6ekociWKH7f9WQlZ1ww%3D"
User-Agent: PostmanRuntime/7.20.1
Accept: */*
Cache-Control: no-cache
Postman-Token: 7e1cbb16-b01a-4b0f-bc0d-5144af910fcc,2174fc2f-08ae-4d25-8042-c98df604c9c2
Host: 192.168.1.122
Accept-Encoding: gzip, deflate
Cookie: private_content_version=5ef1d9b9313f0264fabbfd8e693f9700; mage-messages=%5B%7B%22type%22%3A%22error%22%2C%22text%22%3A%22Invalid+Form+Key.+Please+refresh+the+page.%22%7D%2C%7B%22type%22%3A%22error%22%2C%22text%22%3A%22Invalid+Form+Key.+Please+refresh+the+page.%22%7D%5D
Content-Length: 0
Connection: keep-alive
cache-control: no-cache

}
end.
