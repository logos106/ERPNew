unit CustomerSalesOrdersReport;

{ Date     Version Who  What
 -------- -------- ---  --------------------------------------------------------
 07/09/05  1.00.01 IJB  Modified to use new filtering on base listing.
 }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, Mask, wwdbedit, Wwdotdot,
  Wwdbcomb, MemDS, DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog,
   wwdblook, Shader, kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TCustSalesOrdersReportGUI = class(TBaseListingGUI)
    qryMainCompany: TWideStringField;
    qryMainType: TWideStringField;
    qryMainSaleDate: TWideStringField;
    qryMainDueDate: TWideStringField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainTotalAmountEx: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    qryMainSaleID: TLargeIntField;
    qryMainClientID: TIntegerField;
    qryMainDetails: TLargeIntField;
    qryMainName: TWideStringField;
    qryMainAddress: TWideStringField;
    qryMainAddress2: TWideStringField;
    qryMainSuburb: TWideStringField;
    qryMainPostcode: TWideStringField;
    qryMainState: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainFaxNumber: TWideStringField;
    qryMainREP: TWideStringField;
    qryMainTotalCostEx: TFloatField;
    qryMainTotalCostInc: TFloatField;
    qryMainGrossProfit: TFloatField;
    qryMainPercentProfit: TFloatField;
    Panel4: TPanel;
    cboConverted: TwwDBComboBox;
    qryMainConverted: TWideStringField;
    Label4: TLabel;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
      Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure cboConvertedChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
  public
    { Public declarations }
  end;

implementation

uses CommonLib, tcConst;

{$R *.dfm}

procedure TCustSalesOrdersReportGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: 
      begin {Summary}
        GroupFilterString := '(Details = 0)';
        if cboConverted.ItemIndex = 1 then begin
          GroupFilterString := GroupFilterString + ' AND (Converted <>' + QuotedStr('F') + ')';
        end else if cboConverted.ItemIndex = 2 then begin
          GroupFilterString := GroupFilterString + ' AND (Converted <>' + QuotedStr('T') + ')';
        end;
      end;
    1: 
      begin  {Details}
        GroupFilterString := '(Details <> 1)';
        if cboConverted.ItemIndex = 1 then begin
          GroupFilterString := GroupFilterString + ' AND (Converted <>' + QuotedStr('F') + ')';
        end else if cboConverted.ItemIndex = 2 then begin
          GroupFilterString := GroupFilterString + ' AND (Converted <>' + QuotedStr('T') + ')';
        end;
      end;
  end;
  inherited;
end;

procedure TCustSalesOrdersReportGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  CustomerSummaryListingGUI := nil;
end;

procedure TCustSalesOrdersReportGUI.RefreshQuery;
begin
  if chkIgnoreDates.Checked then begin
    qryMain.Params.ParamByName('txtfrom1').AsDate := 0;
    qryMain.Params.ParamByName('txtto1').AsDate := MaxDateTime;
    qryMain.Params.ParamByName('txtfrom2').AsDate := 0;
    qryMain.Params.ParamByName('txtto2').AsDate := MaxDateTime;
  end
  else begin
    qryMain.Params.ParamByName('txtfrom1').AsDate := dtFrom.DateTime;
    qryMain.Params.ParamByName('txtto1').AsDate := dtTo.DateTime;
    qryMain.Params.ParamByName('txtfrom2').AsDate := dtFrom.DateTime;
    qryMain.Params.ParamByName('txtto2').AsDate := dtTo.DateTime;
  end;
  inherited;
end;

procedure TCustSalesOrdersReportGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }
  if not Empty(qryMainCompany.AsString) then begin
    AFont.Style := AFont.Style + [fsBold];
  end;
end;

procedure TCustSalesOrdersReportGUI.RefreshTotals;
var
  TotalEx, TotalInc: double;
  CostEx, CostInc: double;
  bm: TBookmark;
begin
  TotalEx := 0;
  TotalInc := 0;
  CostEx := 0;
  CostInc := 0;

  with qryMain do begin
    bm := GetBookmark;
    DisableControls;
    First;
    while not Eof do begin
      if qryMainDetails.AsInteger = 0 then begin
        CostEx := CostEx + qryMainTotalCostEx.AsCurrency;
        CostInc := CostInc + qryMainTotalCostInc.AsCurrency;
        TotalEx := TotalEx + qryMainTotalAmountEx.AsCurrency;
        TotalInc := TotalInc + qryMainTotalAmountInc.AsCurrency;
      end;
      Next;
    end;
    EnableControls;
    GotoBookmark(bm);
    FreeBookmark(bm);
  end;
  grdMain.ColumnByName('PercentProfit').FooterValue := FloatToStrF((Divzer((TotalInc - CostInc), TotalInc) * 100),
    ffFixed, 18, 2) + '%';
  grdMain.ColumnByName('GrossProfit').FooterValue := FloatToStrF(TotalInc - CostInc, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Total Cost (Ex)').FooterValue := FloatToStrF(CostEx, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Total Cost (Inc)').FooterValue := FloatToStrF(CostInc, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Total Amount (Ex)').FooterValue := FloatToStrF(TotalEx, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Total Amount (Inc)').FooterValue := FloatToStrF(TotalInc, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TCustSalesOrdersReportGUI.grdMainDblClick(Sender: TObject);
begin
  if qryMainSaleID.AsInteger > 0 then begin
    SubsequentID := Chr(95) + qryMain.FieldByName('Type').AsString;
    inherited;
  end;
end;

procedure TCustSalesOrdersReportGUI.qryMainCalcFields(DataSet: TDataSet);
var
  difference: double;
  Income: double;
begin
  inherited;
  difference := qryMain.FieldByName('Total Amount (Inc)').AsFloat - qryMain.FieldByName('Total Cost (Inc)').AsFloat;
  Income := qryMain.FieldByName('Total Amount (Inc)').AsFloat;
  qryMain.FieldByName('PercentProfit').AsFloat := DivZer(difference, Income) * 100;
  qryMain.FieldByName('GrossProfit').AsFloat := qryMain.FieldByName('Total Amount (Inc)').AsFloat -
    qryMain.FieldByName('Total Cost (Inc)').AsFloat;
end;
    
procedure TCustSalesOrdersReportGUI.cboConvertedChange(Sender: TObject);
begin
  inherited;
  grpFiltersClick(nil);
end;

procedure TCustSalesOrdersReportGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ShowChartViewOnPopup := True;

end;

procedure TCustSalesOrdersReportGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end; 
end;

initialization
  RegisterClassOnce(TCustSalesOrdersReportGUI);
end.
