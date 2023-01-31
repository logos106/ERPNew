unit frmStockTransferEntryBin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmStockTransferEntryTree, DB, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, DBCtrls,
  wwdbedit, Shader, wwcheckbox, DNMSpeedButton, wwdblook, Buttons, Wwdbigrd, Grids, Wwdbgrid, DNMPanel, wwdbdatetimepicker, Mask,
  ERPDbLookupCombo;

type
  TfmStockTransferEntryBin = class(TfmStockTransferEntryTree)
    procedure tblMasterAfterInsert(DataSet: TDataSet);
  private
  Protected
        procedure initStockQtysLocationsReport(Sender: TObject);Override;
  public
  end;


implementation

uses CommonLib, StockLib, FormFactory, StockQtysLocationsReport;

{$R *.dfm}

procedure TfmStockTransferEntryBin.initStockQtysLocationsReport(Sender: TObject);
begin
  inherited;
  if not(Sender is TStockQtysLocationsReportGUI) then exit;
  TStockQtysLocationsReportGUI(Sender).AddfilterString('Batch = ' +quotedstr('F') +' and Bin = ' +quotedstr('T')+' and SN = ' + Quotedstr('F'));

end;

procedure TfmStockTransferEntryBin.tblMasterAfterInsert(DataSet: TDataSet);
begin
  inherited;
  StockTransfer.Transfertype := StockTransfertypetoStr(sttBin);
end;

initialization
    RegisterClassOnce(TfmStockTransferEntryBin);
  with FormFact do begin
    RegisterMe(TfmStockTransferEntryBin, 'TStockTransferEntryListBinGUI_*=TransferEntryID');
    RegisterMe(TfmStockTransferEntryBin, 'TStockTransferEntryListBinGUI_*_Bin=TransferEntryID');
    RegisterMe(TfmStockTransferEntryBin, 'TStockTransferEntryListGUI_*_Bin=TransferEntryID');
    RegisterMe(TfmStockTransferEntryBin, 'TProductQtyOnTransitGUI_*_Bin=TransferEntryID');
    RegisterMe(TfmStockTransferEntryBin, 'TSalesStockTransferListGUI_*_Bin=TransferEntryID');
    RegisterMe(TfmStockTransferEntryBin, 'TSerialNumberHistoryGUI_transtype_BinStockTransferEntry=StockAdjustEntryID');
    RegisterMe(TfmStockTransferEntryBin, 'TBalTransListGUI_*_BinStock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntryBin, 'TToBeReconciledGUI_*_BinStock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntryBin, 'TTransactionListGUI_*_BinStock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntryBin, 'TBASTransReturnListGUI_*_BinStock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntryBin, 'TNZTransReturnListGUI_*_BinStock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntryBin, 'TVATTransReturnListGUI_*_BinStock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntryBin, 'TTransAccountDetailsGUI_*_BinStock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntryBin, 'TGeneralLedgerReportGUI_*_Stock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntryBin, 'TExpenseClaimListGUI_*__BinStockTransfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntryBin, 'TStockStatusReportGUI_*_BinStock Transfer=StockTransferEntryID');
    RegisterMe(TfmStockTransferEntryBin, 'TStockStatusRoling_*_BinStock Transfer=StockTransferEntryID');
  end;
end.

