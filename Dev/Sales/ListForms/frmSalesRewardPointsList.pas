unit frmSalesRewardPointsList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls,AdvOfficeStatusBar, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox;

type
  TfmSalesRewardPointsList = class(TBaseListingGUI)
    qryMainSaleId: TIntegerField;
    qryMainSaleDate: TDateField;
    qryMainCustomerName: TWideStringField;
    qryMainInvoiceDocNumber: TWideStringField;
    qryMainPaid: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainShipped: TFloatField;
    qryMainTotalLineAmountInc: TFloatField;
    qryMainLinePoints: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override; 
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
  end;

implementation

uses CommonLib, tcConst;

{$R *.dfm}

procedure TfmSalesRewardPointsList.FormCreate(Sender: TObject);
begin
  inherited;
  Self.DefaultMaxGridColumnWidth := 35;
end;

procedure TfmSalesRewardPointsList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmSalesRewardPointsList.FormShow(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfmSalesRewardPointsList.RefreshQuery;
begin
  inherited;
  grdMain.DataSource.DataSet.DisableControls;
  try
    qryMain.Close;
    qryMain.ParamByName('PaidStatus').AsString := grpFilters.Items[grpFilters.ItemIndex];
    qryMain.ParamByName('DateFrom').AsDateTime := FilterDateFrom;
    qryMain.ParamByName('DateTo').AsDateTime   := FilterDateTo;
    qryMain.Open;
  finally
    grdMain.DataSource.DataSet.EnableControls;
  end;
end;

procedure TfmSalesRewardPointsList.grpFiltersClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfmSalesRewardPointsList.RefreshTotals;
var
  LineTotal, PointTotal: double;
begin
  qryMain.DisableControls;
  qryMain.First;
  LineTotal := 0;
  PointTotal := 0;
  while not qryMain.Eof do begin
    LineTotal  := LineTotal + qryMainTotalLineAmountInc.AsFloat;
    PointTotal := PointTotal + qryMainLinePoints.AsFloat;

    // Fetch next record.
    qryMain.Next;
  end;

  grdMain.ColumnByName('TotalLineAmountInc').FooterValue := FloatToStrF(LineTotal, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('LinePoints').FooterValue := FloatToStr(PointTotal);
  qryMain.EnableControls;
end;

initialization
  RegisterClassOnce(TfmSalesRewardPointsList);
end.
