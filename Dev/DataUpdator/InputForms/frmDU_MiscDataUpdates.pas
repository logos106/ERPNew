unit frmDU_MiscDataUpdates;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDU_base, Menus, ExtCtrls, Shader, DNMPanel, StdCtrls;

type
  TfmDU_MiscDataUpdates = class(TfmDU_base)
    pnlMakePrimaryContacts: TDNMPanel;
    chkfixUOM: TCheckBox;
  private
  Protected
    Class function MakeInstance(AOwner:TComponent): TfmDU_base;overload; override;
  public
    Class Function  MakeInstance(AOwner:TComponent; ParentPanel:TDNMPanel) :TfmDU_base ;overload;Override;
  end;


implementation

{$R *.dfm}

{ TfmDU_MiscDataUpdates }

class function TfmDU_MiscDataUpdates.MakeInstance(AOwner: TComponent): TfmDU_base;
begin
  Result:= TfmDU_MiscDataUpdates.create(AOwner);
  inherited;
end;

class function TfmDU_MiscDataUpdates.MakeInstance(AOwner: TComponent;ParentPanel: TDNMPanel): TfmDU_base;
begin
  result:= inherited MakeInstance(AOwner,ParentPanel);
end;

end.
