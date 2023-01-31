unit frmDU_CustomerSpecialPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmDU_base, Menus, ExtCtrls, Shader, DNMPanel, StdCtrls;

type
  TfmDU_CustomerSpecialPrice = class(TfmDU_base)
    DNMPanel1: TDNMPanel;
    edtupdateSpecialPrice: TLabeledEdit;
    OptupdateSpecialPricetype: TRadioGroup;
    OptupdateSpecialPriceOption: TRadioGroup;
    chkupdateSpecialPrice: TCheckBox;
  private
  Protected
    class function MakeInstance(AOwner:TComponent): TfmDU_base;Overload;Override;
  public
    Class Function  MakeInstance(AOwner:TComponent; ParentPanel:TDNMPanel) :TfmDU_base ;overload;Override;
  end;

implementation

{$R *.dfm}

{ TfmDU_CustomerSpecialPrice }

class function TfmDU_CustomerSpecialPrice.MakeInstance(
  AOwner: TComponent): TfmDU_base;
begin
  Result:= TfmDU_CustomerSpecialPrice.create(AOwner);
  inherited;

end;

class function TfmDU_CustomerSpecialPrice.MakeInstance(AOwner: TComponent;ParentPanel: TDNMPanel): TfmDU_base;
begin
  result:= inherited MakeInstance(AOwner,ParentPanel);
end;

end.
