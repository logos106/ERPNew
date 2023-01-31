unit frmSalesPackWeight;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmPackWeightBase, DB, ProgressDialog, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, DNMSpeedButton, Shader, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  DNMPanel, StdCtrls, busobjtrans;

type
  TfmSlaesPackWeight = class(TfmPackWeightBase)
    tblPackWeightLinesSaleLineID: TIntegerField;
  private
  Protected
    //procedure NewBusObjinstance;Override;
  public
    Class function DoPackWeight(AOwner:TComponent; aLine : TTransLineBase):boolean;
  end;


implementation

uses BusObjSales, CommonDbLib;

{$R *.dfm}

{ TfmSlaesPackWeight }


class function TfmSlaesPackWeight.DoPackWeight(AOwner: TComponent;  aLine: TTransLineBase): boolean;
var
  form :TfmSlaesPackWeight;
begin
 form := TfmSlaesPackWeight.create(Aowner);
 try
  REsult := Form.DoPackWeightform(aLine);
(*  if result and (aline is TSalesLine) then begin
        commondblib.closedb(TERPQuery(TSalesLine(Aline).SalesLinePackWeightSum.Dataset));
        TSalesLine(Aline).SalesLinePackWeightSum;
  end;*)
 finally
   Freeandnil(form);
 end;
end;

(*procedure TfmSlaesPackWeight.NewBusObjinstance;
begin
  if PackWeightObj = nil then begin
    PackWeightObj := TSalesLinePackWeightLines.CreateWithNewConn(Self);
    inherited;
  end;
end;*)

end.
