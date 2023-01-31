unit frmStockTransferEntryBatch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmStockTransferEntryTree, DB, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, DBCtrls,
  wwdbedit, Shader, wwcheckbox, DNMSpeedButton, wwdblook, Buttons, Wwdbigrd, Grids, Wwdbgrid, DNMPanel, wwdbdatetimepicker, Mask,
  ERPDbLookupCombo;

type
  TfmStockTransferEntryBatch = class(TfmStockTransferEntryTree)
    procedure tblMasterAfterInsert(DataSet: TDataSet);
  private
  Protected
        procedure initStockQtysLocationsReport(Sender: TObject);Override;
  public
  end;

implementation

uses CommonLib, StockLib, FormFactory, StockQtysLocationsReport;

{$R *.dfm}

procedure TfmStockTransferEntryBatch.initStockQtysLocationsReport(Sender: TObject);
begin
  inherited;
  if not(Sender is TStockQtysLocationsReportGUI) then exit;
  TStockQtysLocationsReportGUI(Sender).AddfilterString('Batch = ' +quotedstr('T') +' and Bin = ' +quotedstr('F')+' and SN = ' + Quotedstr('F'));
end;

procedure TfmStockTransferEntryBatch.tblMasterAfterInsert(DataSet: TDataSet);
begin
  inherited;
  StockTransfer.Transfertype := StockTransfertypetoStr(sttBatch);
end;

initialization
    RegisterClassOnce(TfmStockTransferEntryBatch);
    with FormFact do begin
      RegisterMe(TfmStockTransferEntryBatch, 'TStockTransferEntryListBAtchGUI_*=TransferEntryID');
      RegisterMe(TfmStockTransferEntryBatch, 'TStockTransferEntryListBAtchGUI_*_Batch=TransferEntryID');
      RegisterMe(TfmStockTransferEntryBatch, 'TStockTransferEntryListGUI_*_Batch=TransferEntryID');
      RegisterMe(TfmStockTransferEntryBatch, 'TProductQtyOnTransitGUI_*_Batch=TransferEntryID');
      RegisterMe(TfmStockTransferEntryBatch, 'TSalesStockTransferListGUI_*_Batch=TransferEntryID');
      RegisterMe(TfmStockTransferEntryBatch, 'TSerialNumberHistoryGUI_transtype_BatchStockTransferEntry=StockAdjustEntryID');
      RegisterMe(TfmStockTransferEntryBatch, 'TBalTransListGUI_*_BatchStock Transfer=StockTransferEntryID');
      RegisterMe(TfmStockTransferEntryBatch, 'TToBeReconciledGUI_*_BatchStock Transfer=StockTransferEntryID');
      RegisterMe(TfmStockTransferEntryBatch, 'TTransactionListGUI_*_BatchStock Transfer=StockTransferEntryID');
      RegisterMe(TfmStockTransferEntryBatch, 'TBASTransReturnListGUI_*_BatchStock Transfer=StockTransferEntryID');
      RegisterMe(TfmStockTransferEntryBatch, 'TNZTransReturnListGUI_*_BatchStock Transfer=StockTransferEntryID');
      RegisterMe(TfmStockTransferEntryBatch, 'TVATTransReturnListGUI_*_BatchStock Transfer=StockTransferEntryID');
      RegisterMe(TfmStockTransferEntryBatch, 'TTransAccountDetailsGUI_*_BatchStock Transfer=StockTransferEntryID');
      RegisterMe(TfmStockTransferEntryBatch, 'TGeneralLedgerReportGUI_*_Stock Transfer=StockTransferEntryID');
      RegisterMe(TfmStockTransferEntryBatch, 'TExpenseClaimListGUI_*__BatchStockTransfer=StockTransferEntryID');
      RegisterMe(TfmStockTransferEntryBatch, 'TStockStatusReportGUI_*_BatchStock Transfer=StockTransferEntryID');
      RegisterMe(TfmStockTransferEntryBatch, 'TStockStatusRoling_*_BatchStock Transfer=StockTransferEntryID');
    end;

end.

