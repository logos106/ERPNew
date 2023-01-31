unit InventoryAssetVsStockStautsDetailsSummary;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel , InventoryAssetVsStockStautsDetailsBase;

type
  TInventoryAssetVsStockStautsDetailsSummaryGUI = class(TInventoryAssetVsStockStautsDetailsBaseGUI)
    procedure FormShow(Sender: TObject);
  protected
    Procedure MakeQrymain;Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TInventoryAssetVsStockStautsDetailsSummaryGUI }

procedure TInventoryAssetVsStockStautsDetailsSummaryGUI.FormShow(  Sender: TObject);
begin
  MakeQrymain;
  inherited;

end;

procedure TInventoryAssetVsStockStautsDetailsSummaryGUI.MakeQrymain;
begin
  Closedb(qrymain);
  qrymain.sQL.clear;
  qrymain.sQL.add('Select');
  qrymain.sQL.add('T.* ,');
  qrymain.sQL.add(' round((ifnull(Balancesheet,0)-ifnull(stockValue,0)) ,2) as diff ');
  qrymain.sQL.add('from '+tablename + ' T');
  qrymain.sQL.add(' where  ' + TypeWhere('transtype')+'  and Transactionno =' + inttostr(transID));
  inherited;
end;

procedure TInventoryAssetVsStockStautsDetailsSummaryGUI.RefreshQuery;
begin
  inherited;
end;

initialization
  RegisterClassOnce(TInventoryAssetVsStockStautsDetailsSummaryGUI);

end.
