unit StockAdjustEntryListBatch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StockAdjustEntryListBase, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox, ComCtrls;

type
  TStockAdjustEntryListBatchGUI = class(TStockAdjustEntryListBaseGUI)
    procedure cmdNewClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib, CommonFormLib;

{$R *.dfm}

procedure TStockAdjustEntryListBatchGUI.cmdNewClick(Sender: TObject);
begin
  //inherited;
  OpenERPForm('TfmStockAdjustEntryBatch' , 0);
end;

procedure TStockAdjustEntryListBatchGUI.grdMainDblClick(Sender: TObject);
begin
  //SubsequentID := Chr(95) + '_Batch';
  inherited;

end;

initialization
    RegisterClassOnce(TStockAdjustEntryListBatchGUI);
end.

