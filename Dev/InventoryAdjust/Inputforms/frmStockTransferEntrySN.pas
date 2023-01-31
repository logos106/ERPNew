unit frmStockTransferEntrySN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmStockTransferEntryTree, DB, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, DBCtrls,
  wwdbedit, Shader, wwcheckbox, DNMSpeedButton, wwdblook, Buttons, Wwdbigrd, Grids, Wwdbgrid, DNMPanel, wwdbdatetimepicker, Mask,
  ERPDbLookupCombo;

type
  TfmStockTransferEntrySN = class(TfmStockTransferEntryTree)
    procedure tblMasterAfterInsert(DataSet: TDataSet);
  private
  Protected
        procedure initStockQtysLocationsReport(Sender: TObject);Override;
  public
  end;


implementation

uses CommonLib, StockLib, FormFactory, StockQtysLocationsReport;

{$R *.dfm}

procedure TfmStockTransferEntrySN.initStockQtysLocationsReport(Sender: TObject);
begin
  inherited;
  if not(Sender is TStockQtysLocationsReportGUI) then exit;
  TStockQtysLocationsReportGUI(Sender).AddfilterString('Batch = ' +quotedstr('F') +' and Bin = ' +quotedstr('F')+' and SN = ' + Quotedstr('T'));
end;

procedure TfmStockTransferEntrySN.tblMasterAfterInsert(DataSet: TDataSet);
begin
  inherited;
  StockTransfer.Transfertype := StockTransfertypetoStr(sttsn);
end;

initialization
    RegisterClassOnce(TfmStockTransferEntrySN);
    with FormFact do begin
      RegisterMe(TfmStockTransferEntrySN, 'TStockTransferEntryListSNGUI_*=TransferEntryID');
      RegisterMe(TfmStockTransferEntrySN, 'TStockTransferEntryListSNGUI_*_SN=TransferEntryID');
      RegisterMe(TfmStockTransferEntrySN, 'TStockTransferEntryListGUI_*_SN=TransferEntryID');
      RegisterMe(TfmStockTransferEntrySN, 'TProductQtyOnTransitGUI_*_SN=TransferEntryID');
      RegisterMe(TfmStockTransferEntrySN, 'TSalesStockTransferListGUI_*_SN=TransferEntryID');
      RegisterMe(TfmStockTransferEntrySN, 'TSerialNumberHistoryGUI_transtype_SNStockTransferEntry=StockAdjustEntryID');
      RegisterMe(TfmStockTransferEntrySN, 'TBalTransListGUI_*_SNStock Transfer=StockTransferEntryID');
      RegisterMe(TfmStockTransferEntrySN, 'TToBeReconciledGUI_*_SNStock Transfer=StockTransferEntryID');
      RegisterMe(TfmStockTransferEntrySN, 'TTransactionListGUI_*_SNStock Transfer=StockTransferEntryID');
      RegisterMe(TfmStockTransferEntrySN, 'TBASTransReturnListGUI_*_SNStock Transfer=StockTransferEntryID');
      RegisterMe(TfmStockTransferEntrySN, 'TNZTransReturnListGUI_*_SNStock Transfer=StockTransferEntryID');
      RegisterMe(TfmStockTransferEntrySN, 'TVATTransReturnListGUI_*_SNStock Transfer=StockTransferEntryID');
      RegisterMe(TfmStockTransferEntrySN, 'TTransAccountDetailsGUI_*_SNStock Transfer=StockTransferEntryID');
      RegisterMe(TfmStockTransferEntrySN, 'TGeneralLedgerReportGUI_*_Stock Transfer=StockTransferEntryID');
      RegisterMe(TfmStockTransferEntrySN, 'TExpenseClaimListGUI_*__SNStockTransfer=StockTransferEntryID');
      RegisterMe(TfmStockTransferEntrySN, 'TStockStatusReportGUI_*_SNStock Transfer=StockTransferEntryID');
      RegisterMe(TfmStockTransferEntrySN, 'TStockStatusRoling_*_SNStock Transfer=StockTransferEntryID');
    end;
end.

