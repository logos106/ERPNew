unit ProductNegativeStock;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, DNMPanel, ReportSQLProductNegativeStock, GIFImg;

type
  TProductNegativeStockGUI = class(TBaseListingGUI)
    qryMainPartname: TWideStringField;
    qryMainPartType: TWideStringField;
    qryMainOnBuildQty: TFloatField;
    qryMainBuildingQty: TFloatField;
    qryMainBuiltQty: TFloatField;
    qryMainSubBuiltQty: TFloatField;
    qryMainUSedForBuildQty: TFloatField;
    qryMainInStockQty: TFloatField;
    qryMainInStocknOnOrderQty: TFloatField;
    qryMainActStockwithManQty: TFloatField;
    qryMainActStockQty: TFloatField;
    qryMainStockQtyQty: TFloatField;
    qryMainAvailableQty: TFloatField;
    qryMainAvailablenOnOrderQty: TFloatField;
    qryMainSOQty: TFloatField;
    qryMainInvBOQty: TFloatField;
    qryMainTotSalesQty: TFloatField;
    qryMainPOBOQty: TFloatField;
    qryMainSOBOQty: TFloatField;
    qryMainTransQtyQty: TFloatField;
    qryMainInStockMovementQty: TFloatField;
    qryMainOUTsQty: TFloatField;
    qryMainINsQty: TFloatField;
    qryMainOnTransitQty: TFloatField;
    qryMainPrintName: TWideStringField;
    qryMainStockValue: TFloatField;
    qryMainStockValueonLandedCost: TFloatField;
    qryMainValueAvg: TFloatField;
    qryMainSalesValue: TFloatField;
    qryMainOnOrderQty: TFloatField;
    qryMainPreferredSupplier: TWideStringField;
    qryMainPurchaseDescription: TWideStringField;
    qryMainIncomeAccount: TWideStringField;
    qryMainAssetAccount: TWideStringField;
    qryMainCostofGoodsSoldAccount: TWideStringField;
    qryMainBarcode: TWideStringField;
    qryMainProductCode: TWideStringField;
    qryMainFirstColumn: TWideStringField;
    qryMainSecondColumn: TWideStringField;
    qryMainThirdColumn: TWideStringField;
    qryMainSalesDescription: TWideStringField;
    qryMainSellQtyA: TIntegerField;
    qryMainSellQtyB: TIntegerField;
    qryMainSellQtyC: TIntegerField;
    qryMainPriceExA: TFloatField;
    qryMainPriceExB: TFloatField;
    qryMainPriceExC: TFloatField;
    qryMainPriceIncB: TFloatField;
    qryMainPriceIncA: TFloatField;
    qryMainPriceIncC: TFloatField;
    qryMainWholesalePrice: TFloatField;
    qryMainBuyQtyA: TIntegerField;
    qryMainBuyQtyB: TIntegerField;
    qryMainBuyQtyC: TIntegerField;
    qryMainCostExA: TFloatField;
    qryMainCostExB: TFloatField;
    qryMainCostExC: TFloatField;
    qryMainCostIncA: TFloatField;
    qryMainCostIncB: TFloatField;
    qryMainCostIncC: TFloatField;
    qryMainSupplierProductCode: TWideStringField;
    qryMainTaxcode: TWideStringField;
    qryMainPurchaseTaxcode: TWideStringField;
    qryMainDateCreated: TDateField;
    qryMainDateUpdated: TDateField;
    qryMainArea: TWideStringField;
    qryMainDiscontinued: TWideStringField;
    qryMainOnSpecial: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
  private
  protected
    function GetReportTypeID: integer; override;
    Function DoEmailIfToBeEmailed: boolean; override;
  public
    Procedure RefreshQuery; Override;
  end;


implementation

{$R *.dfm}


{ TProductNegativeStockGUI }

procedure TProductNegativeStockGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    ReportSQLSupplied   := true;
    UseStringListForSQL := true;
    try
      ReportSQLobj.DateTo := dtTo.Date;
      StringListForSQL.Text :=  ReportSQLobj.TemplateSQL;
      inherited;
    finally
      ReportSQLSupplied   := false;
      UseStringListForSQL := false;
    end;
  finally
    EnableForm;
  end;
end;

function TProductNegativeStockGUI.DoEmailIfToBeEmailed: boolean;
begin
  DisableForm;
  try
    ReportSQLSupplied   := true;
    UseStringListForSQL := true;
    try
      ReportSQLobj.DateTo := dtTo.Date;
      StringListForSQL.Text :=  ReportSQLobj.TemplateSQL;
      result:= inherited DoEmailIfToBeEmailed;
    finally
      ReportSQLSupplied   := false;
      UseStringListForSQL := false;
    end;
  finally
    EnableForm;
  end;
end;

procedure TProductNegativeStockGUI.FormCreate(Sender: TObject);
begin
  qryMain.SQL.Text := TReportSQLProductNegativeStock.ReportSQL + #13#10 +
    'where PQA.TransDate <= :DateTo' + #13#10 +
    'group by p.partsID' + #13#10 +
    'having AvailableQty < 0' + #13#10 +
    'Order by PartName';
  inherited;
  fReportSQLobj := TReportSQLProductNegativeStock.Create(self);
  SearchMode:= smFullList;
  StringListForSQL := TStringList.create;
end;

function TProductNegativeStockGUI.GetReportTypeID: integer;
begin
  Result := ReportSQLobj.ReportTypeID ;
end;

procedure TProductNegativeStockGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
(*  qryMainStockValue.asfloat := qryMainInStock.asfloat * qryMainCostExA.asFloat;
  qryMainStockValueonLandedCost.asfloat := qryMainInStock.asfloat * qryMainLandedCost.asFloat;
  qryMainValueAvg.asfloat   := qryMainInStock.asfloat * qryMainAvgCost.asFloat;
  qryMainSalesValue.asfloat := qryMainInStock.asfloat * qryMainPriceIncA.asfloat;*)
end;

procedure TProductNegativeStockGUI.RefreshQuery;
begin
  qryMain.Close;
  qryMain.ParamByName('DateTo').AsDate := dtTo.Date;
  inherited;

end;

initialization
  RegisterClass(TProductNegativeStockGUI);

end.
