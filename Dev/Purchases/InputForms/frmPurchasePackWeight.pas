unit frmPurchasePackWeight;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmPackWeightBase, DB, ProgressDialog, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, DNMSpeedButton, Shader, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  DNMPanel, StdCtrls, busobjtrans;

type
  TfmPurchasePackWeight = class(TfmPackWeightBase)
    tblPackWeightLinesPurchaseLineID: TIntegerField;
  private
  Protected
    //procedure NewBusObjinstance;Override;
  public
    Class function DoPackWeight(AOwner:TComponent; aLine : TTransLineBase):boolean;
  end;


implementation

uses busobjOrders, CommonDbLib;

{$R *.dfm}

{ TfmPurchasePackWeight }


class function TfmPurchasePackWeight.DoPackWeight(AOwner: TComponent;aLine: TTransLineBase): boolean;
var
  Form : TfmPurchasePackWeight;
begin
  form := TfmPurchasePackWeight.create(Aowner);
  try
    REsult := Form.DoPackWeightform(aLine);
(*  if result and (aline is TPurchaseOrderLine) then begin
        commondblib.closedb(TERPQuery(TPurchaseOrderLine(Aline).PurchaseLinePackWeightSum.Dataset));
        TPurchaseOrderLine(Aline).PurchaseLinePackWeightSum;
  end;*)
  finally
    Freeandnil(form);
  end;

end;

(*procedure TfmPurchasePackWeight.NewBusObjinstance;
begin
  if PackWeightObj = nil then begin
    PackWeightObj := TPurchaseLinePackWeightLines.CreateWithNewConn(Self);
    inherited;
  end;
end;*)

end.
