unit frmERPEbayConfigurationSteps;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmEbayConfigurationSteps, Menus, AdvMenus, StdCtrls, ComCtrls,
  DNMSpeedButton, Shader, ExtCtrls, DNMPanel;

type
  TfmERPEbayConfigurationSteps = class(TfmEbayConfigurationSteps)
    btnHelpDoc: TDNMSpeedButton;
    procedure btnHelpDocClick(Sender: TObject);
  private
    procedure DoHowtoDeveloperAccountconfig(sender: TObject);
    procedure DoHowtoERPconfig(sender: TObject);
    procedure DoShowpopupmenu(sender: TObject);
  public
    { Public declarations }
  end;


implementation

uses DocReaderObj,commonGuiLib, MainformLib;
{$R *.dfm}

procedure TfmERPEbayConfigurationSteps.DoShowpopupmenu(sender:TObject);
begin
  mnuHelpDoc.Popup(controlLeft(btnHelpDoc)+Self.left+50 , ClientFormTop+controlTop(btnHelpDoc)+self.top );
end;
procedure TfmERPEbayConfigurationSteps.DoHowtoDeveloperAccountconfig(sender:TObject);
begin
  TDocReaderObj.ShowERPHelp(nil, Self, true, 'Ebay Registration.pdf');
end;
procedure TfmERPEbayConfigurationSteps.DoHowtoERPconfig(sender:TObject);
begin
  TDocReaderObj.ShowERPHelp(nil, Self, true, 'Ebay on ERP');
end;
procedure TfmERPEbayConfigurationSteps.btnHelpDocClick(Sender: TObject);
var
  mnu : TMenuItem;
begin
  inherited;
  //mnuNewOptions.Popup(Mouse.CursorPos.x, Mouse.CursorPos.Y);
  mnuHelpDoc.Items.Clear;

  mnu := TMenuItem.Create(self);
  mnu.Caption := 'Developer account Configuration on the https://developer.ebay.com';
  mnu.OnClick := DoHowtoDeveloperAccountconfig;
  mnuHelpDoc.Items.Add(mnu);


  mnu := TMenuItem.Create(self);
  mnu.Caption := 'Configuration within ERP';
  mnu.OnClick := DoHowtoERPconfig;
  mnuHelpDoc.Items.Add(mnu);

  DoShowpopupmenu(btnHelpDoc);
end;

end.
