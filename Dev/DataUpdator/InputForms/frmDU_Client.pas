unit frmDU_Client;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDU_base, ExtCtrls, Shader, DNMPanel, StdCtrls, Menus;

type
  TfmDU_Client = class(TfmDU_base)
    pnlUpdatecontacts: TDNMPanel;
    chkUpdatecontacts: TCheckBox;
    pnlClient: TDNMPanel;
    chkClient: TCheckBox;
    optclient: TRadioGroup;
    chkUseRegionCountry: TCheckBox;
    chkUseRegionCountryforFax: TCheckBox;
    pnlMakePrimaryContacts: TDNMPanel;
    chkMakecontact: TCheckBox;
    procedure optclientClick(Sender: TObject);
    procedure ValidateSelection(Sender: TObject);
  private
  Protected
    Class function MakeInstance(AOwner:TComponent): TfmDU_base;overload; override;
  public
    Class Function  MakeInstance(AOwner:TComponent; ParentPanel:TDNMPanel) :TfmDU_base ;overload;Override;
  end;


implementation

{$R *.dfm}

{ TfmDU_base1 }

class function TfmDU_Client.MakeInstance(AOwner: TComponent): TfmDU_base;
begin
  Result:= TfmDU_Client.create(AOwner);
  inherited;
end;

procedure TfmDU_Client.ValidateSelection(Sender: TObject);
begin
  inherited;
  if chkUpdatecontacts.checked and chkClient.checked then
    if Screen.activecontrol = chkUpdatecontacts then chkClient.checked := False else chkUpdatecontacts.checked := False;
end;

class function TfmDU_Client.MakeInstance(AOwner: TComponent; ParentPanel: TDNMPanel): TfmDU_base;
begin
  result:= inherited MakeInstance(AOwner,ParentPanel);
end;

procedure TfmDU_Client.optclientClick(Sender: TObject);
begin
  inherited;
  if (sender = Optclient)  then chkClient.Checked       := true;
end;

end.

