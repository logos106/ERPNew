unit StockTakeList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StockAdjustEntryList, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TStockTakeListGUI = class(TStockAdjustEntryListGUI)
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib;

{$R *.dfm}
initialization
  RegisterClassOnce(TStockTakeListGUI);
end.

