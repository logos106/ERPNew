unit CustomerReportForm;

{ Date     Version Who  What
 -------- -------- ---  --------------------------------------------------------
 07/09/05  1.00.01 IJB  Modified to use new filtering on base listing.
 01/12/05  1.00.02 DSP  Added 'Gross Profit' and 'Margin' fields.
 25/01/06  1.00.03 IJB  Removed margin from query and replaced it with a
                        calculated field to correctly handle negative amounts.
 27/01/06  1.00.04 IJB  Modified order of 'UNION ALL' blocks in main sql so
                        dates are returned as dates rather than strings.
                        Added 'Type' to ORDER BY clause. 

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TCustomerSummaryListingGUI = class(TBaseListingGUI)
    qryMainCompany: TWideStringField;
    qryMainType: TWideStringField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainTotalAmountEx: TFloatField;
    qryMainTotalAmountInc: TFloatField;
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
    qryMainGrossProfit: TFloatField;
    qryMainMargin: TFloatField;
    qryMainTotalCost: TFloatField;
    qryMainDueDate: TDateField;
    qryMainSaleID: TLargeIntField;
    qryMainAddress3: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainLastSaleDate: TDateField;
    qryMainGrossProfitEx: TFloatField;
    qryMainMarkup: TFloatField;
    qryMainClientType: TWideStringField;
    Label46: TLabel;
    chkBaseOnShipped: TCheckBox;
    Shape1: TShape;
    Shape2: TShape;
    Label4: TLabel;
    chkShowAllcustomers: TCheckBox;
    qryMainEmail: TWideStringField;
    qryMainSaleDate: TDateField;
    procedure grpFiltersClick(Sender: TObject);Override; 
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
      Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure chkBaseOnShippedClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure MakeQrymain;
    { Private declarations }
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
  public
    { Public declarations }
  end;

implementation

uses Commonlib,systemlib, FastFuncs, tcConst, CustomerSummaryReportSQL;

{$R *.dfm}

procedure TCustomerSummaryListingGUI.grpFiltersClick(Sender: TObject);
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

procedure TCustomerSummaryListingGUI.chkBaseOnShippedClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TCustomerSummaryListingGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  CustomerSummaryListingGUI := nil;
end;

procedure TCustomerSummaryListingGUI.FormCreate(Sender: TObject);
begin
  MakeQrymain;
  inherited;
end;

Procedure TCustomerSummaryListingGUI.MakeQrymain;
var
  CustomerSummaryReport: TCustomerSummaryReport;
  msg: string;
begin
  CustomerSummaryReport := TCustomerSummaryReport.Create;
  try
    CustomerSummaryReport.APIMode := False;
    if not CustomerSummaryReport.PopulateReportSQL(qryMain.SQL,msg) then begin
      CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
    end;
  finally
    CustomerSummaryReport.Free;
  end;
end;

procedure TCustomerSummaryListingGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('DateFrom').AsDateTime := filterDateFrom;
  qryMain.Params.ParamByName('DateTo').AsDateTime := filterdateto;
  qryMain.Params.ParamByName('UseShipDate').AsString := BooleanToStr(chkBaseOnShipped.Checked);
  qryMain.Params.ParamByName('ShowAllcustomers').AsString := BooleanToStr(chkShowAllcustomers.Checked);

  inherited;
end;

procedure TCustomerSummaryListingGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit; { just in case user switches off all fields in gui prefs }

  if not Empty(qryMainCompany.AsString) and (grpfilters.itemindex <> 0) then begin
    AFont.Style := AFont.Style + [fsBold];
  end ;
  if Sysutils.SameText(Field.fieldName , 'LastSaleDate') then begin
    if qryMainDetails.asInteger <> 0 then
      Afont.color := ABrush.color;
  end;
end;

procedure TCustomerSummaryListingGUI.RefreshTotals;
var
  TotalEx, TotalInc: double;
  bm: TBookmark;
begin
  TotalEx := 0;
  TotalInc := 0;

  with qryMain do begin
    bm := GetBookmark;
    DisableControls;
    First;
    while not Eof do begin
      if qryMainDetails.AsInteger = 0 then begin
        TotalEx := TotalEx + qryMainTotalAmountEx.AsCurrency;
        TotalInc := TotalInc + qryMainTotalAmountInc.AsCurrency;
      end;

      Next;
    end;
    EnableControls;
    GotoBookmark(bm);
    FreeBookmark(bm);
  end;
  grdMain.ColumnByName('Total Amount (Ex)').FooterValue := FloatToStrF(TotalEx, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Total Amount (Inc)').FooterValue := FloatToStrF(TotalInc, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TCustomerSummaryListingGUI.grdMainDblClick(Sender: TObject);
begin
  if qryMainSaleID.AsInteger > 0 then begin
    SubsequentID := Chr(95) + qryMain.FieldByName('Type').AsString;
    inherited;
  end;
end;

procedure TCustomerSummaryListingGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  if qryMainTotalAmountEx.AsFloat <> 0 then
    self.qryMainMargin.AsFloat :=
      CommonLib.Round((((qryMainTotalAmountEx.AsFloat - qryMainTotalCost.AsFloat) / qryMainTotalAmountEx.AsFloat)) * 100, CurrencyRoundPlaces)
  else
    self.qryMainMargin.AsFloat := 0;

  if qryMainTotalCost.AsFloat <> 0 then
    self.qryMainMarkup.AsFloat :=
      CommonLib.Round((((qryMainTotalAmountEx.AsFloat - qryMainTotalCost.AsFloat) / qryMainTotalCost.AsFloat)) * 100, CurrencyRoundPlaces)
  else
    self.qryMainMarkup.AsFloat := 0;
end;

initialization
  RegisterClassOnce(TCustomerSummaryListingGUI);
end.
