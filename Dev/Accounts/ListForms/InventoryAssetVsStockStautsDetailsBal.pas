unit InventoryAssetVsStockStautsDetailsBal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel , InventoryAssetVsStockStautsDetailsBase;

type
  TInventoryAssetVsStockStautsDetailsBalGUI = class(TInventoryAssetVsStockStautsDetailsBaseGUI)
    procedure FormShow(Sender: TObject);
  protected
    Procedure MakeQrymain;Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TInventoryAssetVsStockStautsDetailsBalGUI }

procedure TInventoryAssetVsStockStautsDetailsBalGUI.FormShow(Sender: TObject);
begin
  MakeQrymain;
  inherited;
end;

procedure TInventoryAssetVsStockStautsDetailsBalGUI.MakeQrymain;
begin
  Closedb(Qrymain);
  Qrymain.sQL.clear;
  Qrymain.sQL.add('   select Productname, seqno , Date , type, Transactionno, ClientName, `Account name`, notes, `Amount (Ex)`, `Amount (Inc)` ' +
                          ' from   '+tablename + '_bal where ' + TypeWhere('type')+'  and Transactionno =' + inttostr(transID));
  inherited;
end;

procedure TInventoryAssetVsStockStautsDetailsBalGUI.RefreshQuery;
begin
  inherited;

end;

initialization
  RegisterClassOnce(TInventoryAssetVsStockStautsDetailsBalGUI);

end.
