unit StockTransferEntryListBin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StockTransferEntryList, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox;

type
  TStockTransferEntryListBinGUI = class(TStockTransferEntryListGUI)
    procedure FormCreate(Sender: TObject);
  private
  Protected

  public
  end;


implementation

uses CommonLib;

{$R *.dfm}

procedure TStockTransferEntryListBinGUI.FormCreate(Sender: TObject);
begin
  inherited;
  inputformName := 'TfmStockTransferEntryBin';
end;

initialization
  RegisterClassOnce(TStockTransferEntryListBinGUI);

end.

