unit StockAdjustEntryListBin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StockAdjustEntryListBase, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TStockAdjustEntryListBinGUI = class(TStockAdjustEntryListBaseGUI)
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
procedure TStockAdjustEntryListBinGUI.cmdNewClick(Sender: TObject);
begin
  //inherited;
  OpenERPForm('TfmStockAdjustEntryBins' , 0);
end;

procedure TStockAdjustEntryListBinGUI.grdMainDblClick(Sender: TObject);
begin
  //SubsequentID := Chr(95) + '_Bin';
  inherited;

end;

initialization
    RegisterClassOnce(TStockAdjustEntryListBinGUI);

end.

