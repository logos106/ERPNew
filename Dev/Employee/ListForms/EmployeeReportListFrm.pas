unit EmployeeReportListFrm;

{
   Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   08/04/05  1.00.01 IJB  Changed to read commission from new SalesCommission,
                          added filtering for commission paid/ not paid,
                          added commission rep.
   07/09/05  1.00.## ISB	Modified To Work With New Filtering on Baselisting.
   25/10/05  1.00.03  MV  Added CustomerName and additional fields to support the
                          addition of GrossProfit.
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  wwdblook, wwcheckbox, SelectionDialog, DNMPanel, wwDialog, Wwlocate,
  MemDS, DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog,
   Shader, kbmMemTable, DAScript, MyScript, CustomInputBox;

type
  TEmployeeReportGUI = class(TBaseListingGUI)
    qryMainEmployeeName: TWideStringField;
    qryMainType: TWideStringField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainTotalAmountEx: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    qryMainDetails: TLargeIntField;
    qryMainPaid: TWideStringField;
    qryMainSaleProfit: TCurrencyField;
    qryMainLineCostInc: TFloatField;
    qryMainCommissionPaid: TWideStringField;
    qryMainName: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainDueDate: TDateField;
    qryMainProfit: TFloatField;
    qryMainSaleID: TLargeIntField;
    qryMainEmployeeID: TIntegerField;
    qryMainSaleProfitEx: TFloatField;
    qryMainLineCost: TFloatField;
    qryMainCommissionDue: TFloatField;
    grpCommPaid: TRadioGroup;
    qryMainCommissionRep: TWideStringField;
    qryMainGrossProfit: TCurrencyField;
    qryMainCustomerName: TWideStringField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
      Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure qryPersonalPrefsCalcFields(DataSet: TDataSet);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure grdMainCalcTitleImage(Sender: TObject; Field: TField; var TitleImageAttributes: TwwTitleImageAttributes);
    procedure grpCommPaidClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    procedure SetupFormInPanel; override;
  public
    { Public declarations }
    sSaleID: string;
  end;

var
  EmployeeReportGUI: TEmployeeReportGUI;

implementation
  
uses CommissPopUp, CommonLib, FastFuncs, MySQLConst;
{$R *.dfm}

{ TEmployeeReportGUI }

procedure TEmployeeReportGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  EmployeeReportGUI := nil;
end;

procedure TEmployeeReportGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin {Summary}
        GroupFilterString := '(Details = 0)';
      end;
    1: 
      begin {Details}
        GroupFilterString := '(Details <> 2)';
      end;
    2: 
      begin  {Extra Details}
        GroupFilterString := '(Details <> 1)';
      end;
  end;
  inherited;
end;

procedure TEmployeeReportGUI.RefreshQuery;
begin
  qryMain.Close;
  qryMain.Params.ParamByName('txtfrom').AsString := FormatDateTime(MysqlDateFormat, dtfrom.DateTime);
  qryMain.Params.ParamByName('txtto').AsString := FormatDateTime(MysqlDateFormat, dtto.DateTime);
  qryMain.Params.ParamByName('CommPaid').AsString := grpCommPaid.Items[grpCommPaid.ItemIndex];

  inherited;

  RefreshTotals;
end;


procedure TEmployeeReportGUI.RefreshTotals;
var
  TotalCostInc, TotalEx, TotalInc, TotalCost: double;
  Profit, ProfitEx, Commission, TotalGrossProfit: double;
begin
  Profit := 0;
  ProfitEx := 0;
  Commission := 0;
  TotalEx := 0;
  TotalInc := 0;
  TotalCostInc := 0;
  TotalCost := 0;
  TotalGrossProfit := 0;

  with qryMain do begin
    First;
    while not Eof do begin
      if ((qryMainDetails.AsInteger = 0) and ((grpFilters.ItemIndex = 0) or (grpFilters.ItemIndex = 1))) or
        ((qryMainDetails.AsInteger = 2) and (grpFilters.ItemIndex = 2)) then begin
        TotalEx := TotalEx + qryMainTotalAmountEx.AsCurrency;
        TotalInc := TotalInc + qryMainTotalAmountInc.AsCurrency;
        Profit := Profit + qryMainSaleProfit.AsCurrency;
        ProfitEx := ProfitEx + qryMainSaleProfitEx.AsCurrency;
        Commission := Commission + qryMainCommissionDue.AsCurrency;
        TotalCostInc := TotalCostInc + qryMainLineCostInc.AsCurrency;
        TotalCost := TotalCost + qryMainLineCost.AsCurrency;
        TotalGrossProfit := TotalGrossProfit + RoundCurrency(qryMainGrossProfit.AsCurrency);
      end;

      Next;
    end;
  end;

  grdMain.ColumnByName('LineCost').FooterValue := FloatToStrF(TotalCost, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('LineCostInc').FooterValue := FloatToStrF(TotalCostInc, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Total Amount (Ex)').FooterValue := FloatToStrF(TotalEx, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Total Amount (Inc)').FooterValue := FloatToStrF(TotalInc, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SaleProfit').FooterValue := FloatToStrF(Profit, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('SaleProfitEx').FooterValue := FloatToStrF(ProfitEx, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('CommissionDue').FooterValue := FloatToStrF(Commission, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('GrossProfit').FooterValue := FloatToStrF(TotalGrossProfit, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TEmployeeReportGUI.SetupFormInPanel;
begin
  inherited;
  grpCommPaid.itemindex := 2;
  grpCommPaid.visible := False;
end;

procedure TEmployeeReportGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if not Empty(qryMainEmployeeName.AsString) then begin
    AFont.Style := AFont.Style + [fsBold];
  end;
end;

procedure TEmployeeReportGUI.grdMainDblClick(Sender: TObject);
var
  i: integer;
  FieldName: string;
begin
  if qryMainSaleID.AsInteger > 0 then begin
    SubsequentID := Chr(95) + qryMain.FieldByName('Type').AsString;

    sSaleID   := IntToStr(qryMain.FieldByName('SaleID').asInteger);
    i         := grdMain.GetActiveCol;
    FieldName := grdMain.FieldName(i);
    if FieldName = 'CommissionPaid' then begin
      with TfrmCommissPopUp.Create(Self) do try
          if ShowModal = mrOk then begin
          end;
        finally
          Free;
        end;

      Application.ProcessMessages;
      qryMain.Close;
      qryMain.Open;
    end else begin
      inherited;
    end;
  end;
end;

procedure TEmployeeReportGUI.qryPersonalPrefsCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMain.FieldByName('SaleProfit').AsFloat := qryMain.FieldByName('Total Amount (Inc)').AsFloat -
    qryMain.FieldByName('TotalLineAmount').AsFloat;
end;

procedure TEmployeeReportGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMain.FieldByName('SaleProfit').AsFloat := qryMain.FieldByName('Total Amount (Inc)').AsFloat -
    qryMain.FieldByName('LineCostInc').AsFloat;
  qryMain.FieldByName('SaleProfitEx').AsFloat := qryMain.FieldByName('Total Amount (Ex)').AsFloat -
    qryMain.FieldByName('LineCost').AsFloat;
  qryMain.FieldByName('Profit (%)').AsFloat := DivZer(qryMain.FieldByName('SaleProfit').AsFloat,
    qryMain.FieldByName('Total Amount (Inc)').AsFloat) * 100;
  qryMain.FieldByName('GrossProfit').AsFloat := qryMain.FieldByName('Total Amount (Ex)').AsFloat -
    qryMain.FieldByName('LineCost').AsFloat;
end;

procedure TEmployeeReportGUI.grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
begin
  if not (Self.Parent is TDNMPanel) then begin
    inherited;
  end;
end;

procedure TEmployeeReportGUI.grdMainCalcTitleImage(Sender: TObject; Field: TField;
  var TitleImageAttributes: TwwTitleImageAttributes);
begin
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if not (Self.Parent is TDNMPanel) then begin
    inherited;
  end;
end;

procedure TEmployeeReportGUI.grpCommPaidClick(Sender: TObject);
begin
  inherited;
  Self.RefreshQuery;
end;

procedure TEmployeeReportGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ShowChartViewOnPopup := True;
end;

procedure TEmployeeReportGUI.btnCustomizeClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TEmployeeReportGUI.cmdExportClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TEmployeeReportGUI.cmdNewClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

procedure TEmployeeReportGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;

initialization
  RegisterClassOnce(TEmployeeReportGUI);
end.

