unit frmBaselistingSelectionPopup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, Menus, ExtCtrls, StdCtrls, DNMSpeedButton, DNMPanel, Shader, BaseListingForm;

type
  TfmBaselistingSelectionPopup = class(TfrmBaseGUI)
    pnlDetails: TDnMPanel;
    pnlBottom: TDNMPanel;
    pnltop: TDNMPanel;
    cmdClose: TDNMSpeedButton;
    pnlHeader: TDnMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    fListform: TBaseListingGUI;
    fiSelectioncount: Integer;
    procedure SetListform(const Value: TBaseListingGUI);
  public
    Property ListForm : TBaseListingGUI read fListform write SetListform;
    Class Procedure ShowSelectionOptions(aListForm : TBaseListingGUI );
  end;


implementation


{$R *.dfm}

procedure TfmBaselistingSelectionPopup.cmdCloseClick(Sender: TObject);
begin
  inherited;
//  fListform.ChangeSelectionPanel(fListform.HeaderPanel );
  Self.close;
end;

procedure TfmBaselistingSelectionPopup.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  { do this here in case user clicks on X to close form .. }
  if Assigned(fListform) then
    fListform.ChangeSelectionPanel(fListform.HeaderPanel );
end;

procedure TfmBaselistingSelectionPopup.FormCreate(Sender: TObject);
begin
  inherited;
  fListform := nil;
end;

procedure TfmBaselistingSelectionPopup.FormShow(Sender: TObject);
begin
  inherited;
    TitleShader.FromColor := Self.Color;
    TitleShader.ToColorMirror := TitleShader.FromColor;
end;

procedure TfmBaselistingSelectionPopup.SetListform(
  const Value: TBaseListingGUI);
begin
  fListform := Value;
  color := fListform.color;
  fListform.ChangeSelectionPanel(pnlDetails , altop);
end;

class procedure TfmBaselistingSelectionPopup.ShowSelectionOptions(aListForm: TBaseListingGUI);
var
  form : TfmBaselistingSelectionPopup;
begin
  form := TfmBaselistingSelectionPopup.create(nil);
  try
    With Form do begin
      ClientHeight := pnltop.height +pnlbottom.height +pnlDetails.margins.Top + pnlDetails.margins.Bottom;
      listform := aListform;
      Caption :='Selection Options';
      TitleLabel.Caption :=aListform.Listcaption;
      Showmodal;
    end;
  finally
    Freeandnil(Form);
  end;
end;

end.
