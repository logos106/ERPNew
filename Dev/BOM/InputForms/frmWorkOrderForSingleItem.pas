unit frmWorkOrderForSingleItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmWorkOrder, DB, ProgressDialog, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, Mask, wwdbedit, DBCtrls, wwdbdatetimepicker,
  Shader, Grids, Wwdbigrd, Wwdbgrid, DNMSpeedButton, DNMPanel;

type
  TfmWorkOrderForSingleItem = class(TfmWorkOrder)
    wwDBEdit3: TwwDBEdit;
    Label10: TLabel;
    DNMSpeedButton4: TDNMSpeedButton;
    procedure DNMSpeedButton4Click(Sender: TObject);
  private

    procedure intBOMSalesPieceRateConf(Sender: TObject);
  Protected
    Procedure RefreshQuery;Override;
  public
  end;

implementation

uses  CommonLib, CommonFormLib;

{$R *.dfm}

procedure TfmWorkOrderForSingleItem.DNMSpeedButton4Click(Sender: TObject);
begin
  if Accesslevel > 3 then begin
  end else begin
    if not SaveRecord then exit;
    BOMSalesPieceRateConf.Connection.CommitTransaction;
  end;
  OpenERPFormModal('TfmWorkOrder' , 0 , intBOMSalesPieceRateConf);
  Self.closewait;
end;
procedure TfmWorkOrderForSingleItem.intBOMSalesPieceRateConf(Sender: TObject);
begin
  TfmWorkOrderForSingleItem(Sender).SalesLineId := SalesLineId;
  TfmWorkOrderForSingleItem(Sender).saleId := saleId;
  TfmWorkOrderForSingleItem(Sender).ProctreeId := ProctreeId;
  FreeandNil(BOMSalesPieceRateConf);
  Self.Hide;
end;
procedure TfmWorkOrderForSingleItem.RefreshQuery;
begin
  BOMSalesPieceRateConf.LoadForSaleLine(SalesLineId , ProctreeId);
end;
initialization
  RegisterClassOnce(TfmWorkOrderForSingleItem);

end.
