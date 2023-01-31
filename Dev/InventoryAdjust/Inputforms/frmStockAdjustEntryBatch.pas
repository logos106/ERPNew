unit frmStockAdjustEntryBatch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmStockAdjustEntryBase, DB, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, DBCtrls,
  ComCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwcheckbox, wwdbdatetimepicker, DNMSpeedButton, wwdblook, Mask, Shader, DNMPanel,
  ERPDbLookupCombo;

type
  TfmStockAdjustEntryBatch = class(TfmStockAdjustEntryBase)
    procedure qryStockAdjustEntryAfterInsert(DataSet: TDataSet);
  private
  Protected
    procedure initStockQtysLocationsReport(Sender: TObject);Override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, StockLib, FormFactory, StockQtysLocationsReport;

{$R *.dfm}
procedure TfmStockAdjustEntryBatch.initStockQtysLocationsReport(Sender: TObject);
begin
  inherited;
  TStockQtysLocationsReportGUI(Sender).FilterString := 'Batch =' +QuotedStr('T') + ' and Bin =' +QuotedStr('F')+ ' and SN =' +QuotedStr('F');
end;

procedure TfmStockAdjustEntryBatch.qryStockAdjustEntryAfterInsert(DataSet: TDataSet);
begin
  inherited;
  StockAdjust.Adjusttype := StockAdjustmenttypetoStr(satBatch);
end;

initialization
  RegisterClassOnce(TfmStockAdjustEntryBatch);
  with FormFact do
  begin
    RegisterMe(TfmStockAdjustEntryBatch, 'TStockAdjustEntryListBatchGUI_*=StockAdjustEntryID');
    RegisterMe(TfmStockAdjustEntryBatch, 'TStockAdjustEntryListGUI_*_Batch=StockAdjustEntryID');
    RegisterMe(TfmStockAdjustEntryBatch, 'TStockAdjustAccountListGUI_*_Batch=StockAdjustEntryID');
    RegisterMe(TfmStockAdjustEntryBatch, 'TStockAdjustEntryDetailListGUI_*_Batch=StockAdjustEntryID');
    RegisterMe(TfmStockAdjustEntryBatch, 'TStockAdjustEntryDetailVariaceListGUI_*_Batch=StockAdjustEntryID');
    RegisterMe(TfmStockAdjustEntryBatch, 'TSerialNumberHistoryGUI_transtype_GenStockAdjustEntry=StockAdjustEntryID');
    RegisterMe(TfmStockAdjustEntryBatch, 'TBalTransListGUI_*_BatchStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryBatch, 'TTrialBalTransListGUI_*_BatchStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryBatch, 'TTransactionListGUI_*_BatchStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryBatch, 'TBASTransReturnListGUI_*_BatchStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryBatch, 'TNZTransReturnListGUI_*_BatchStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryBatch, 'TVATTransReturnListGUI_*_BatchStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryBatch, 'TTransAccountDetailsGUI_*_BatchStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryBatch, 'TGeneralLedgerReportGUI_*_BatchStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryBatch, 'TStockStatusReportGUI_*_BatchStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryBatch, 'TStockStatusRoling_*_BatchStock Adjustment=StockAdjustentryID');
  end;
end.

