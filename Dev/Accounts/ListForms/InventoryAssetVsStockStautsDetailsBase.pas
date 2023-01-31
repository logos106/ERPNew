unit InventoryAssetVsStockStautsDetailsBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup;

type
  TInventoryAssetVsStockStautsDetailsBaseGUI = class(TBaseListingGUI)
    procedure FormCreate(Sender: TObject);
  private
  Protected
    fsTableName: String;
    fiTransID: Integer;
    fsTranstype: String;
    function TypeWhere(const fieldname: String): String;
    Procedure MakeQrymain;virtual;
  public
    Property TableName :String read fsTableName write fsTableName;
    Property Transtype :String read fsTranstype write fsTranstype;
    Property TransID   :Integer read fiTransID write fiTransID;
  end;


implementation

{$R *.dfm}

procedure TInventoryAssetVsStockStautsDetailsBaseGUI.FormCreate(
  Sender: TObject);
begin
  inherited;
  SearchMode:= smFullList;
end;

procedure TInventoryAssetVsStockStautsDetailsBaseGUI.MakeQrymain;
begin
  RefreshOrignalSQL(False);
end;

Function TInventoryAssetVsStockStautsDetailsBaseGUI.TypeWhere(const fieldname :String):String;
begin
  REsult :='(' + fieldname + '=' +Quotedstr(transtype) + ' or ' +
          '( ' + Quotedstr(transtype) +' = ' + Quotedstr('Stock Adjustment') +' and (' + fieldname +' ="StockAdjustEntry"))  or ' +
          '( ' + Quotedstr(transtype) +' = ' + Quotedstr('Manufacturing'   ) +' and (' + fieldname +' ="TProcTreePart" or ' + fieldname +' ="TProcTreePartIN"   or ' + fieldname +' ="TProcProgressOut" or ' + fieldname +' ="TProcProgressIn" ))  or ' +
          '( ' + Quotedstr(transtype) +' = ' + Quotedstr('Purchase Order'  ) +' and (' + fieldname +' ="PO"            or ' + fieldname +' ="Un-Invoiced PO"))  or ' +
          '( ' + Quotedstr(transtype) +' = ' + Quotedstr('Cash Sale'       ) +' and (' + fieldname +' ="Cash Sale"     or ' + fieldname +' ="POS")) )';
end;


end.
