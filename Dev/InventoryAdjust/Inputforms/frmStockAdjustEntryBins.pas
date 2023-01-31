unit frmStockAdjustEntryBins;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmStockAdjustEntryBase, DB, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, DBCtrls,
  ComCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwcheckbox, wwdbdatetimepicker, DNMSpeedButton, wwdblook, Mask, Shader, DNMPanel,
  ERPDbLookupCombo;

type
  TfmStockAdjustEntryBins = class(TfmStockAdjustEntryBase)
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
procedure TfmStockAdjustEntryBins.initStockQtysLocationsReport(Sender: TObject);
begin
  inherited;
  TStockQtysLocationsReportGUI(Sender).FilterString := 'Batch =' +QuotedStr('F') + ' and Bin =' +QuotedStr('T')+ ' and SN =' +QuotedStr('F');
end;

procedure TfmStockAdjustEntryBins.qryStockAdjustEntryAfterInsert(DataSet: TDataSet);
begin
  inherited;
  StockAdjust.Adjusttype := StockAdjustmenttypetoStr(satBin);
end;

initialization
  RegisterClassOnce(TfmStockAdjustEntryBins);
  with FormFact do
  begin
    RegisterMe(TfmStockAdjustEntryBins, 'TStockAdjustEntryListBinGUI_*=StockAdjustEntryID');
    RegisterMe(TfmStockAdjustEntryBins, 'TStockAdjustEntryListGUI_*_Bin=StockAdjustEntryID');
    RegisterMe(TfmStockAdjustEntryBins, 'TStockAdjustAccountListGUI_*_Bin=StockAdjustEntryID');
    RegisterMe(TfmStockAdjustEntryBins, 'TStockAdjustEntryDetailListGUI_*_Bin=StockAdjustEntryID');
    RegisterMe(TfmStockAdjustEntryBins, 'TStockAdjustEntryDetailVariaceListGUI_*_Bin=StockAdjustEntryID');
    RegisterMe(TfmStockAdjustEntryBins, 'TSerialNumberHistoryGUI_transtype_GenStockAdjustEntry=StockAdjustEntryID');
    RegisterMe(TfmStockAdjustEntryBins, 'TBalTransListGUI_*_BinStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryBins, 'TTrialBalTransListGUI_*_BinStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryBins, 'TTransactionListGUI_*_BinStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryBins, 'TBASTransReturnListGUI_*_BinStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryBins, 'TNZTransReturnListGUI_*_BinStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryBins, 'TVATTransReturnListGUI_*_BinStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryBins, 'TTransAccountDetailsGUI_*_BinStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryBins, 'TGeneralLedgerReportGUI_*_BinStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryBins, 'TStockStatusReportGUI_*_BinStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntryBins, 'TStockStatusRoling_*_BinStock Adjustment=StockAdjustentryID');
  end;
end.

