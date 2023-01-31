unit StockTransferEntryListSN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StockTransferEntryList, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TStockTransferEntryListSNGUI = class(TStockTransferEntryListGUI)
    procedure FormCreate(Sender: TObject);
  private
  Protected
    procedure SetGridColumns; Override;
  public
  end;


implementation

uses CommonLib;

{$R *.dfm}

procedure TStockTransferEntryListSNGUI.FormCreate(Sender: TObject);
begin
  inherited;
  inputformName := 'TfmStockTransferEntrySN';
end;

procedure TStockTransferEntryListSNGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(Qrymainbatchnumber.fieldname);
  RemoveFieldfromGrid(QrymainExpirydate.fieldname);
  RemoveFieldfromGrid(QrymainBatchqty.fieldname);
end;

initialization
  RegisterClassOnce(TStockTransferEntryListSNGUI);

end.

