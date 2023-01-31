unit frmStockAdjustEntrySN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmStockAdjustEntryBase, DB, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, DBCtrls,
  ComCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwcheckbox, wwdbdatetimepicker, DNMSpeedButton, wwdblook, Mask, Shader, DNMPanel,
  ERPDbLookupCombo;

type
  TfmStockAdjustEntrySN = class(TfmStockAdjustEntryBase)
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
procedure TfmStockAdjustEntrySN.initStockQtysLocationsReport(Sender: TObject);
begin
  inherited;
 TStockQtysLocationsReportGUI(Sender).FilterString := 'Batch =' +QuotedStr('F') + ' and Bin =' +QuotedStr('F')+ ' and SN =' +QuotedStr('T');
end;

procedure TfmStockAdjustEntrySN.qryStockAdjustEntryAfterInsert(DataSet: TDataSet);
begin
  inherited;
  StockAdjust.Adjusttype := StockAdjustmenttypetoStr(satSN);
end;

initialization
  RegisterClassOnce(TfmStockAdjustEntrySN);
  with FormFact do
  begin
    RegisterMe(TfmStockAdjustEntrySN, 'TStockAdjustEntryListSNGUI_*=StockAdjustEntryID');
    RegisterMe(TfmStockAdjustEntrySN, 'TStockAdjustEntryListGUI_*_SN=StockAdjustEntryID');
    RegisterMe(TfmStockAdjustEntrySN, 'TStockAdjustAccountListGUI_*_SN=StockAdjustEntryID');
    RegisterMe(TfmStockAdjustEntrySN, 'TStockAdjustEntryDetailListGUI_*_SN=StockAdjustEntryID');
    RegisterMe(TfmStockAdjustEntrySN, 'TStockAdjustEntryDetailVariaceListGUI_*_SN=StockAdjustEntryID');
    RegisterMe(TfmStockAdjustEntrySN, 'TSerialNumberHistoryGUI_transtype_GenStockAdjustEntry=StockAdjustEntryID');
    RegisterMe(TfmStockAdjustEntrySN, 'TBalTransListGUI_*_SNStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntrySN, 'TTrialBalTransListGUI_*_SNStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntrySN, 'TTransactionListGUI_*_SNStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntrySN, 'TBASTransReturnListGUI_*_SNStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntrySN, 'TNZTransReturnListGUI_*_SNStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntrySN, 'TVATTransReturnListGUI_*_SNStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntrySN, 'TTransAccountDetailsGUI_*_SNStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntrySN, 'TGeneralLedgerReportGUI_*_SNStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntrySN, 'TStockStatusReportGUI_*_SNStock Adjustment=StockAdjustentryID');
    RegisterMe(TfmStockAdjustEntrySN, 'TStockStatusRoling_*_SNStock Adjustment=StockAdjustentryID');
  end;

end.

