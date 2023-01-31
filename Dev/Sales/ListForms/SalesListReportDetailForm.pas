unit SalesListReportDetailForm;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls, AdvOfficeStatusBar, StdCtrls, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, DNMPanel, MemDS, DBAccess, MyAccess, ERPdbComponents, wwdbdatetimepicker, ProgressDialog,
  wwdblook, Shader, kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TSalesListReportDetailGUI = class(TBaseListingGUI)
    qryMainSaleDate: TDateField;
    qryMainTransactionType: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainGlobal: TWideStringField;
    qryMainOriginal: TWideStringField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainPONumber: TWideStringField;
    qryMainEmployeeName: TWideStringField;
    qryMainConsignmentNote: TWideStringField;
    qryMainClassName: TWideStringField;
    qryMainProductType: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainProductDescription: TWideStringField;
    qryMainLinePriceEx: TFloatField;
    qryMainLinePriceInc: TFloatField;
    qryMainLineTotalEx: TFloatField;
    qryMainLineTotalInc: TFloatField;
    qryMainTaxCode: TWideStringField;
    qryMainLineTax: TFloatField;
    qryMainLineCostEx: TFloatField;
    qryMainLineCostInc: TFloatField;
    qryMainShipped: TFloatField;
    qryMainDeleted: TWideStringField;
    qryMainEmployeeID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainSaleID: TIntegerField;
    qryMainAttrib1Sale: TFloatField;
    qryMainAttrib2Sale: TFloatField;
    qryMainAttrib1SaleRate: TFloatField;
    qryMainBackOrder: TFloatField;
    qryMainTimeOfSale: TWideStringField;
    qryMainCustFld1: TWideStringField;
    qryMainCustFld2: TWideStringField;
    qryMainCustFld3: TWideStringField;
    qryMainCustFld4: TWideStringField;
    qryMainCustFld5: TWideStringField;
    qryMainCustFld6: TWideStringField;
    qryMainCustFld7: TWideStringField;
    qryMainCustFld8: TWideStringField;
    qryMainCustFld9: TWideStringField;
    qryMainCustFld10: TWideStringField;
    qryMainCustFld11: TWideStringField;
    qryMainCustFld12: TWideStringField;
    qryMainCustFld13: TWideStringField;
    qryMainCustFld14: TWideStringField;
    qryMainCustFld15: TWideStringField;
    qryMainSalesLinesCustField1: TWideStringField;
    qryMainSalesLinesCustField2: TWideStringField;
    qryMainSalesLinesCustField3: TWideStringField;
    qryMainSalesLinesCustField4: TWideStringField;
    qryMainSalesLinesCustField5: TWideStringField;
    qryMainSalesLinesCustField6: TWideStringField;
    qryMainSalesLinesCustField7: TWideStringField;
    qryMainSalesLinesCustField8: TWideStringField;
    qryMainSalesLinesCustField9: TWideStringField;
    qryMainSalesLinesCustField10: TWideStringField;
    qryMainShipDate: TDateTimeField;
    qryMainLineShipDate: TDateTimeField;
    qryMainDiscounts: TFloatField;
    qryMainDiscountPercent: TFloatField;
    qryMainMarkup: TFloatField;
    qryMainMarkupPercent: TFloatField;
    qryMainWarrantyEndsOn: TDateField;
    qryMainWarrantyPeriod: TWideStringField;
    qryMainSmartOrderCreated: TWideStringField;
    qryMainAttrib1SaleRateShipped: TFloatField;
    qryMainAttrib1SaleRateOrdered: TFloatField;
    qryMainCustomerType: TWideStringField;
    qryMainPreferedSupplier: TWideStringField;
    qryMainSource: TWideStringField;
    btnProductList: TDNMSpeedButton;
    qryMainClientType: TWideStringField;
    qryMainFirstcolumn: TWideStringField;
    qryMainSecondcolumn: TWideStringField;
    qryMainthirdcolumn: TWideStringField;
    qryMainProductPrintName: TWideStringField;
    procedure grpFiltersClick(Sender: TObject); override;
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
    procedure cmdPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure btnProductListClick(Sender: TObject);
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    procedure SetGridColumns; override;
  private
  public
    { Public declarations }
  end;

implementation

uses Forms, AppEnvironment, CommonLib, fastfuncs, tcConst (**) , CommonFormLib;
{$R *.dfm}

procedure TSalesListReportDetailGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('txtfrom').AsDate := dtFrom.DateTime;
  qryMain.Params.ParamByName('txtto').AsDate := dtTo.DateTime;
  inherited;
  RefreshTotals;
end;

procedure TSalesListReportDetailGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0: begin
        GroupFilterString := 'Deleted <> ' + QuotedStr('T');
      end;
    1: begin
        GroupFilterString := 'Deleted = ' + QuotedStr('T');
      end;
  end;
  inherited;
end;

procedure TSalesListReportDetailGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  DoHideProgressbar;
end;

procedure TSalesListReportDetailGUI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  DoShowProgressbar(2, WAITMSG);
  DoStepProgressbar;
end;

procedure TSalesListReportDetailGUI.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;

procedure TSalesListReportDetailGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('ClientID');
  RemoveFieldfromGrid('EmployeeId');
end;

procedure TSalesListReportDetailGUI.FormCreate(Sender: TObject);
begin
  inherited;
  AddCalccolumn('Shipped', True);
  AddCalccolumn('BackOrder', True);
  AddCalccolumn('Line Total (Ex)', True);
  AddCalccolumn('Line Total (Inc)', True);
  AddCalccolumn('Line Tax', True);
  AddCalccolumn('Attrib1SaleRatetotal', True);
  qryMainDiscounts.DisplayLabel := 'Discount ' + AppEnv.RegionalOptions.CurrencySymbol;
  qryMainMarkup.DisplayLabel := 'Markup ' + AppEnv.RegionalOptions.CurrencySymbol;
  qryMainMarkupPercent.DisplayLabel := 'Markup %';
  qryMainDiscountPercent.DisplayLabel := 'Discount %';
end;

procedure TSalesListReportDetailGUI.FormShow(Sender: TObject);
begin
  inherited;

  grdMain.columnbyName('Attrib1SaleRateShipped').DisplayLabel := 'Price For Shipped';
  grdMain.columnbyName('Attrib1SaleRateOrdered').DisplayLabel := 'Price For Ordered';
  grdMain.columnbyName('Attrib1Sale').DisplayLabel := AppEnv.CompanyPrefs.ProductAttrib1Name;
  grdMain.columnbyName('Attrib2Sale').DisplayLabel := AppEnv.CompanyPrefs.ProductAttrib2Name;
  grdMain.columnbyName('Attrib1SaleRate').DisplayLabel := 'Price / ' + AppEnv.CompanyPrefs.ProductAttrib1Name;

  if not AppEnv.CompanyPrefs.ShowMeasurementAttributes then grdMain.RemoveField('Attrib1Sale');
  if not AppEnv.CompanyPrefs.ShowMeasurementAttributes then grdMain.RemoveField('Attrib2Sale');
  if not AppEnv.CompanyPrefs.ShowMeasurementAttributes then grdMain.RemoveField('Attrib1SaleRate');
  if not AppEnv.CompanyPrefs.ShowMeasurementAttributes then grdMain.RemoveField('Attrib1SaleRateShipped');
  if not AppEnv.CompanyPrefs.ShowMeasurementAttributes then grdMain.RemoveField('Attrib1SaleRateOrdered');
  (* grdMain.columnbyName('Product Name').DisplayLabel := AppEnv.DefaultClass.PartColumn;
  grdMain.columnbyName('Department').DisplayLabel := AppEnv.DefaultClass.ThirdColumn;
  grdMain.columnbyName('Type').DisplayLabel := AppEnv.DefaultClass.SecondColumn;
  grdMain.columnbyName('Manufacturer').DisplayLabel := AppEnv.DefaultClass.FirstColumn; *)
  if AppEnv.CompanyPrefs.ShowSalesWarrantyEndsOn then begin
    grdMain.AddField('WarrantyEndsOn');
  end else begin
    RemoveFieldfromGrid('WarrantyEndsOn');
  end;

  if AppEnv.CompanyPrefs.ShowSalesWarrantyPeriod then begin
    grdMain.AddField('WarrantyPeriod');
  end else begin
    RemoveFieldfromGrid('WarrantyPeriod');
  end;

  if Trim(AppEnv.CompanyPrefs.SalesWarrantyEndsOnCaption) <> '' then grdMain.columnbyName('WarrantyEndsOn').DisplayLabel := Trim(AppEnv.CompanyPrefs.SalesWarrantyEndsOnCaption);

  if Trim(AppEnv.CompanyPrefs.SalesWarrantyPeriodCaption) <> '' then grdMain.columnbyName('WarrantyPeriod').DisplayLabel := Trim(AppEnv.CompanyPrefs.SalesWarrantyPeriodCaption);
end;

procedure TSalesListReportDetailGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMain.FieldByName('Transaction Type').AsString;
  inherited;
end;

procedure TSalesListReportDetailGUI.btnProductListClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TSalesListReportGUI');
end;

procedure TSalesListReportDetailGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try inherited;
  finally EnableForm;
  end;
end;

initialization

RegisterClassOnce(TSalesListReportDetailGUI);

end.
