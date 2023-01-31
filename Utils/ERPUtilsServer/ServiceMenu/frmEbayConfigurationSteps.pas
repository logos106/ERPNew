unit frmEbayConfigurationSteps;

interface
{$I ERP.inc}
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Shader, ExtCtrls, DNMPanel, DNMSpeedButton,
  Menus, AdvMenus;

type
  TfmEbayConfigurationSteps = class(TForm)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnCancel: TDNMSpeedButton;
    Details: TRichEdit;
    mnuHelpDoc: TAdvPopupMenu;
    CustomiseGrid: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation


{$R *.dfm}

procedure TfmEbayConfigurationSteps.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TfmEbayConfigurationSteps.FormCreate(Sender: TObject);
var
  Linecount:Integer;
  Procedure AddLine(Const Value:String; uselineno:Boolean=True);
  var
    s:String;
  begin
    s:= '';
    if uselineno then s:= inttostr(Linecount)+'.   ';
    s:= s + Value;
    Details.Lines.Add(s);
    if uselineno then Linecount := Linecount+1;
  end;
begin
  Details.lines.clear;
  Linecount :=1;
  {$IFDEF DevMode}
    AddLine('====================NOTE FOR ERP DEVELOPER ======================',False);
    AddLine('',False);
    AddLine('Open page :https://developer.ebay.com/join/default.aspx');
    AddLine('	and select ''Join the eBay Developers Program (or login)''', false);
    AddLine('Details of account already created',False);
    (*AddLine('           1.    Username	                        binnysaji',False);
    AddLine('                   Password	                        Palak&%10',False);
    AddLine('                   Developer	                        TESTUSER_Binny',False);
    AddLine('                   Developer Password	palak123',False);
    AddLine('',False);
    AddLine('           2.    Username	                        True ERP',False);
    AddLine('                   password	                        1w$p&LD07',False);
    AddLine('                   Developer	                        TestUser_TRueERP',False);
    AddLine('                   Developer Password	erp123',False);
    AddLine('',False);
    AddLine('           3.    Username	                        SuppsRUs',False);
    AddLine('                   Password	                        Palak&%10',False);
    AddLine('                   Developer	                        TestUser_SuppsRUs',False);
    AddLine('                   Developer Password	Palak7510',False);
    AddLine('',False);
    AddLine('           4.    Username	                        TrueERPonE_Bay',False);
    AddLine('                   Password	                        Natarsha2001!',False);
    AddLine('                   Developer	                        TrueERP',False);
    AddLine('                   Developer Password	palak123',False);*)
    AddLine('ERP registration',False);
    AddLine('           Username	                        TrueERPonE_Bay',False);
    AddLine('           Password	                        Natarsha2001!',False);
    AddLine('           Developer	                        TrueERP',False);
    AddLine('           Developer Password	palak123',False);
    AddLine('',False);
    AddLine('=================================================================',False);
    AddLine('ERP Test Account',False);
    AddLine('           Username	                        TrueERPTest',False);
    AddLine('           Password	                        Natarsha2001!',False);
    AddLine('',False);
    AddLine('=================================================================',False);

    AddLine('For SUPPSRUS(customer) ',False);
    AddLine('Open page : https://go.developer.ebay.com/developers/ebay/documentation-tools/quick-start-guide');
    AddLine('and Select ''Login'' from the ''1st step'' under ''Quick Start Guide''', false);
    AddLine('This will prompt to give the username and password.');
    AddLine('The userName is ''SuppsRUs'' and password is ''Palak&%10''(Both username and password  are case sensitive).', false);
    AddLine('',False);
    AddLine('',False);
  {$ENDIF}
    AddLine('Open page : https://go.developer.ebay.com/developers/ebay/documentation-tools/quick-start-guide');
    AddLine('and Select ''Join the eBay Developers Program'' from the ''1st step'' under ''Quick Start Guide''', false);
    AddLine('Choose ''Register Tab''.');
    AddLine('Follow the steps and Create the Developer Login.');
    AddLine('',False);
    AddLine('An Email will be Sent to the Nominated Email Address.');
    AddLine('Choose the link in the email to Login into the Site with the new developer username and password created.');
    AddLine('',False);
    AddLine('If you login Successfully, Access to your new account will be pending approval, which takes at least one business day from first login.');
    AddLine('',False);
    AddLine('Once the account is approved, Log back in again.  Under ''Get Started'', Select ''Get your Keys''');
    AddLine('Go to ''Application Settings'' page. you have to select the environment (Sandbox for testing/ Production for Real) and key (Key set 1).');
    AddLine('',False);
    AddLine('Select ''User tokens'' and ''Generate Token''. Please provide your ebay username and password when prompted.');
(*    AddLine('',False);
    AddLine('Let ERP know the user name to add to the developer account.');
    AddLine('',False);
    AddLine('You will be prompted to ''Grant application access'' to ''TrueERPonE_Bay''.');
    AddLine('',False);
    AddLine('Please do it by selecting ''I agree''', false);
    AddLine('The ''Tokens will be generated and displayed with an option to save. Please select ''Save Token'' to save it.');
    AddLine('A confirmation will be taken to overwrite the existing token and select ''Yes'' to confirm', false);
    AddLine('Sign out');*)
end;

end.

