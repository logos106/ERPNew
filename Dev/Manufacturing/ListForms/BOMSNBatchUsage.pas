unit BOMSNBatchUsage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel, SNBatchUsageSQL;

type
  TBOMSNBatchUsageUGI = class(TBaseListingGUI)
    qryMainSaleID: TIntegerField;
    qryMainInvoiceDocNumber: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainCustomerName: TWideStringField;
    qryMainSaleType: TWideStringField;
    qryMainCustomerPrintName: TWideStringField;
    qryMainCustomerID: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainProductPrintName: TWideStringField;
    qryMainProductID: TIntegerField;
    qryMainMemoLine: TWideMemoField;
    qryMainSerialNumber: TWideStringField;
    qryMainBatchNumber: TWideStringField;
    qryMainBatchProductName: TWideStringField;
    qryMainBatchProductID: TIntegerField;
    qryMainBatchQty: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
  private
    SNBatchUsageReport : TSNBatchUsageReport;
  Protected
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, LogLib;

{$R *.dfm}

procedure TBOMSNBatchUsageUGI.FormCreate(Sender: TObject);
begin
  inherited;
  SNBatchUsageReport := TSNBatchUsageReport.Create;
  SNBatchUsageReport.APIMode := false;
  SNBatchUsageReport.ReportClassName := self.ClassName;
end;

procedure TBOMSNBatchUsageUGI.FormDestroy(Sender: TObject);
begin
  SNBatchUsageReport.Free;
  inherited;

end;

procedure TBOMSNBatchUsageUGI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  clog(Qrymain.SQL.Text);
end;

procedure TBOMSNBatchUsageUGI.RefreshQuery;
var
  msg:String;
begin
  SNBatchUsageReport.DateFrom := FilterDateFrom;
  SNBatchUsageReport.DateTo := FilterDateTo;
  SNBatchUsageReport.UsedateRange := not(chkIgnoreDates.checked);
  if not SNBatchUsageReport.PopulateReportSQL(qryMain.SQL,msg) then begin
    MessageDlgXP_Vista(msg, mtWarning, [mbOK], 0);
    exit;
  end;
  RefreshOrignalSQL;
  inherited;
end;

procedure TBOMSNBatchUsageUGI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainproductId.fieldname);
  RemoveFieldfromGrid(qrymainbatchproductId.fieldname);
  RemoveFieldfromGrid(qrymainCustomerID.fieldname);
end;

initialization
  RegisterClassOnce(TBOMSNBatchUsageUGI);

end.

