unit SalesListReportForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, MemDS,
  DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog, 
  wwdblook, Shader, kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TSalesListReportGUI = class(TBaseListingGUI)
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
    qryMainShipDate: TDateField;
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
    btnProductList: TDNMSpeedButton;
    qryMainClientType: TWideStringField;
    qryMainUnitofMeasureQtySold: TFloatField;
    qryMainQtySold: TFloatField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainUnitofMeasureBackorder: TFloatField;
    qryMainUnitofMeasureSaleLines: TWideStringField;
    qryMainUnitofMeasureMultiplier: TFloatField;
    qryMainUOM: TWideStringField;
    qryMainFirstcolumn: TWideStringField;
    qryMainSecondcolumn: TWideStringField;
    qryMainThirdcolumn: TWideStringField;
    qryMainSalesCategory: TWideStringField;
    qryMainBinLocation: TWideStringField;
    qryMainBinNumber: TWideStringField;
    qryMainProductPrintName: TWideStringField;
    qryMainProductFld7: TWideStringField;
    qryMainTotalProductFld7: TFloatField;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure cmdPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure btnProductListClick(Sender: TObject);
  private
    fField7Caption: string;
    //property Field7Caption : string read fField7Caption write fField7Caption;
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    procedure SetGridColumns; override;
    procedure OnSetUpcustomFields(CustfieldVisible:Boolean;fieldno :Integer;  FlagFieldname , fieldname, DisplayLabel:String );Override;
    procedure PopulateSQL;Virtual;
  public
    { Public declarations }
  end;

implementation

uses Forms,  AppEnvironment, CommonLib, fastfuncs, tcConst(**),
  CommonFormLib, Busobjcustomfields, PQALib, ProductQtyLib,
  SalesListOutstanding, BusObjProcPrefs;
{$R *.dfm}

procedure TSalesListReportGUI.RefreshQuery;
begin
  InitDateFromnDateto('DateStart','DateEnd');
  inherited;
(*  qryMain.FieldByName('ProductName').DisplayLabel := AppEnv.DefaultClass.PartColumn;
  qryMainThirdColumn.DisplayLabel := AppEnv.DefaultClass.ThirdColumn;
  qryMainSecondColumn.DisplayLabel := AppEnv.DefaultClass.SecondColumn;
  qryMainFirstColumn.DisplayLabel := AppEnv.DefaultClass.FirstColumn;*)
  qryMainDiscounts.DisplayLabel := 'Discount ' + appenv.RegionalOptions.CurrencySymbol;
  qryMainMarkup.DisplayLabel := 'Markup ' + appenv.RegionalOptions.CurrencySymbol;
  qryMainMarkupPercent.DisplayLabel := 'Markup %' ;
  qryMainDiscountPercent.DisplayLabel := 'Discount %' ;
  if ProcPrefs.UseFld7AsSteelWeight then
  begin
    qryMainProductFld7.DisplayLabel := fField7Caption;
    qryMainTotalProductFld7.DisplayLabel := 'Total ' + fField7Caption;
  end;

  RefreshTotals;
end;

procedure TSalesListReportGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  self.PopulateSQL;
  if grpFilters.ItemIndex = 0 then begin
    self.RemoveFieldsfromGrid('BinLocation,BinNumber');
  end
  else begin
    { extra detail }
    self.AddFieldstoGrid('BinLocation,BinNumber');
  end;

  self.RefreshOrignalSQL();
  self.RefreshQuery;
  inherited;
end;

procedure TSalesListReportGUI.PopulateSQL;
begin
  qryMain.Close;
  qryMain.SQL.Clear;
  qryMain.SQL.Add('SELECT');
  qryMain.SQL.Add('S.SaleDate                             AS  SaleDate,');
  qryMain.SQL.Add('s.ClassId                              AS  ClassId,');
  qryMain.SQL.Add('S.TimeOfSale                           AS  TimeOfSale,');
  qryMain.SQL.Add(SaleType('S')+ '                        AS  TransactionType,');
  qryMain.SQL.Add('S.CustomerName                         AS  CustomerName ,');
  qryMain.SQL.Add('S.GlobalRef                            AS  Globalref ,');
  qryMain.SQL.Add('S.OriginalNo                           AS  OriginalRef,');
  qryMain.SQL.Add('S.InvoiceDocNumber                     AS  InvoiceNumber ,');
  qryMain.SQL.Add('S.PONumber                             AS  PONumber,');
  qryMain.SQL.Add('S.EmployeeName                         AS  EmployeeName,');
  qryMain.SQL.Add('S.ConNote                              AS  ConsignmentNote,');
  qryMain.SQL.Add('S.Class                                AS  ClassName,');
  qryMain.SQL.Add('SL.PARTTYPE                            AS  ProductType,');
  qryMain.SQL.Add(ProductQtyLib.FirstColumn('SL') + '     AS  FirstColumn,');
  qryMain.SQL.Add(ProductQtyLib.SecondColumn('SL') + '    AS  SecondColumn,');
  qryMain.SQL.Add(ProductQtyLib.ThirdColumn('SL') + '     AS  ThirdColumn,');
  qryMain.SQL.Add('SL.ProductName                         AS  ProductName,');
  qryMain.SQL.Add('P.ProductPrintName                     AS  ProductPrintName ,');
  qryMain.SQL.Add('SL.Product_Description                 AS  ProductDescription ,');
  qryMain.SQL.Add('SL.LinePrice                           AS  LinePriceEx,');
  qryMain.SQL.Add('SL.LinePriceInc                        AS  LinePriceInc,');
  qryMain.SQL.Add('SL.LineTaxCode                         AS  TaxCode,');
  qryMain.SQL.Add('SL.LineTax                             AS  LineTax,');
  qryMain.SQL.Add('SL.LineCost                            AS  LineCostEx,');
  qryMain.SQL.Add('SL.LineCostInc                         AS  LineCostInc,');
  qryMain.SQL.Add('SL.UnitofMeasureQtySold                AS  UnitofMeasureQtySold,');
  qryMain.SQL.Add('SL.QtySold                             AS  QtySold,');
  qryMain.SQL.Add('SL.UnitofMeasureShipped                AS  UnitofMeasureShipped,');
  qryMain.SQL.Add('SL.UnitofMeasureSaleLines              AS  UnitofMeasureSaleLines,');
  qryMain.SQL.Add('SL.UnitofMeasureMultiplier             AS  UnitofMeasureMultiplier,');
  qryMain.SQL.Add('concat(SL.UnitofMeasureSaleLines," (" , SL.UnitofMeasureMultiplier, ")") AS  UOM,');
  qryMain.SQL.Add('SL.Shipped                             AS  Shipped,');
  qryMain.SQL.Add('If(SL.Shipped<>0.00,0.00,SL.BackOrder) AS  BackOrder,');
  qryMain.SQL.Add('SL.Attrib1Sale                         AS  Attrib1Sale,');
  qryMain.SQL.Add('SL.Attrib2Sale                         AS  Attrib2Sale,');
  qryMain.SQL.Add('SL.Attrib1SaleRate                     AS  Attrib1SaleRate,');
  qryMain.SQL.Add('SL.Attrib1SaleRate* SL.Shipped         AS  Attrib1SaleRateShipped,');
  qryMain.SQL.Add('SL.Attrib1SaleRate* SL.QtySold         AS  Attrib1SaleRateOrdered,');
  qryMain.SQL.Add('SL.WarrantyEndsOn                      AS  WarrantyEndsOn,');
  qryMain.SQL.Add('SL.WarrantyPeriod                      AS  WarrantyPeriod,');
  qryMain.SQL.Add('SL.ShipDate                            AS  LineShipDate,');
  qryMain.SQL.Add('S.Deleted                              AS  Deleted,');
  qryMain.SQL.Add('S.EmployeeID                           AS  EmployeeID,');
  qryMain.SQL.Add('s.IsSalesOrder                         AS  IsSalesOrder,');
  qryMain.SQL.Add('S.IsInvoice                            AS  IsInvoice,');
  qryMain.SQL.Add('SL.SaleLineId                          AS  SaleLineId,');
  qryMain.SQL.Add('replace(S.ShipTo, "\r\n" , ",")        AS  ShipTo,');
  qryMain.SQL.Add('replace(S.InvoiceTo, "\r\n" , ",")     AS  InvoiceTo,');
  qryMain.SQL.Add('S.Quotestatus                          AS  SalesCategory,');
  qryMain.SQL.Add('C.ClientID                             AS  ClientID,');
  qryMain.SQL.Add('S.SaleID                               AS  SaleID,');
  qryMain.SQL.Add('S.SalesCategory                        AS  SalesCategory,');
  qryMain.SQL.Add('C.CustFld1                             AS  CustFld1,');
  qryMain.SQL.Add('C.CustFld2                             AS  CustFld2,');
  qryMain.SQL.Add('C.CustFld3                             AS  CustFld3,');
  qryMain.SQL.Add('C.CustFld4                             AS  CustFld4,');
  qryMain.SQL.Add('C.CustFld5                             AS  CustFld5,');
  qryMain.SQL.Add('C.CustFld6                             AS  CustFld6,');
  qryMain.SQL.Add('C.CustFld7                             AS  CustFld7,');
  qryMain.SQL.Add('C.CustFld8                             AS  CustFld8,');
  qryMain.SQL.Add('C.CustFld9                             AS  CustFld9,');
  qryMain.SQL.Add('C.CustFld10                            AS  CustFld10,');
  qryMain.SQL.Add('C.CustFld11                            AS  CustFld11,');
  qryMain.SQL.Add('C.CustFld12                            AS  CustFld12,');
  qryMain.SQL.Add('C.CustFld13                            AS  CustFld13,');
  qryMain.SQL.Add('C.CustFld14                            AS  CustFld14,');
  qryMain.SQL.Add('C.CustFld15                            AS  CustFld15,');
  qryMain.SQL.Add('SL.SalesLinesCustField1                AS  SalesLinesCustField1,');
  qryMain.SQL.Add('SL.SalesLinesCustField2                AS  SalesLinesCustField2,');
  qryMain.SQL.Add('SL.SalesLinesCustField3                AS  SalesLinesCustField3,');
  qryMain.SQL.Add('SL.SalesLinesCustField4                AS  SalesLinesCustField4,');
  qryMain.SQL.Add('SL.SalesLinesCustField5                AS  SalesLinesCustField5,');
  qryMain.SQL.Add('SL.SalesLinesCustField6                AS  SalesLinesCustField6,');
  qryMain.SQL.Add('SL.SalesLinesCustField7                AS  SalesLinesCustField7,');
  qryMain.SQL.Add('SL.SalesLinesCustField8                AS  SalesLinesCustField8,');
  qryMain.SQL.Add('SL.SalesLinesCustField9                AS  SalesLinesCustField9,');
  qryMain.SQL.Add('SL.SalesLinesCustField10               AS  SalesLinesCustField10,');
  qryMain.SQL.Add('S.ShipDate                             AS  ShipDate,');
  qryMain.SQL.Add('SL.Discounts                           AS  Discounts,');
  qryMain.SQL.Add('SL.DiscountPercent                     AS  DiscountPercent,');
  qryMain.SQL.Add('SL.Markup                              AS  Markup,');
  qryMain.SQL.Add('SL.MarkupPercent                       AS  MarkupPercent,');
  qryMain.SQL.Add('SL.SmartOrderCreated                   AS  SmartOrderCreated,');
  qryMain.SQL.Add('CT.TypeName                            AS  ClientType,');
  if (grpFilters.ItemIndex = 1) and (not(self is TSalesListOutstandingGUI)) then begin
    { extra detail }
    qryMain.SQL.Add('pb.BinLocation                       AS  BinLocation,');
    qryMain.SQL.Add('pb.BinNumber                         AS  BinNumber');
  end
  else begin
    qryMain.SQL.Add('null                                 AS  BinLocation,');
    qryMain.SQL.Add('null                                 AS  BinNumber');
  end;
  if ProcPrefs.UseFld7AsSteelWeight then begin
    qryMain.SQL.Add(',P.CUSTFLD7                          AS  ProductFld7, ');
    qryMain.SQL.Add('(cast(P.Custfld7 AS  unsigned) * SL.UnitofMeasureShipped) AS  TotalProductFld7,')
  end else begin
    qryMain.SQL.Add(',null                                AS  ProductFld7, ');
    qryMain.SQL.Add('0.0                                  AS  TotalProductFld7,');
  end;
  qryMain.SQL.Add('If(SL.Shipped<>0.00,SL.TotalLineAmount,SL.BackOrder * SL.LinePrice)        AS  LineTotalEx,');
  qryMain.SQL.Add('If(SL.Shipped<>0.00,SL.TotalLineAmountInc,SL.BackOrder * SL.LinePriceInc)  AS  LineTotalInc,');
  qryMain.SQL.Add('if(SL.UnitofMeasureShipped<> 0.00 , 0.00 , SL.UnitofMeasureBackorder)      AS UnitofMeasureBackorder');
  qryMain.SQL.Add('FROM tblSalesLines SL');
  qryMain.SQL.Add('inner join tblparts P on P.partsId = SL.ProductId');
  qryMain.SQL.Add('INNER JOIN tblSales S ON  S.SaleID = SL.SaleID and ((S.IsRefund ="T" OR S.IsCashSale="T" OR S.IsInvoice="T" OR (S.Converted<>"T" AND S.IsSalesOrder="T") OR S.IsPOS="T")');
  qryMain.SQL.Add('AND S.IsQuote="F"  AND S.IsLayby="F" ) AND S.SaleDate Between :DateStart  AND :DateEnd');
  qryMain.SQL.Add('INNER JOIN tblClients C ON S.ClientID = C.ClientID');
  qryMain.SQL.Add('LEFT JOIN tblclienttype CT on CT.ClientTypeID = C.ClientTypeID');
  if (grpFilters.ItemIndex = 1) and (not(self is TSalesListOutstandingGUI)) then begin
    qryMain.SQL.Add('left join tblpqa pqa on pqa.TransLineID = SL.SaleLineId and pqa.TransType in (' + PQALib.SalesTransTypes + ')'); //    "TInvoiceLine","TSalesOrderline","TRefundSaleLine","TPOSCashSaleline","TPOSLaybylines","TCashSaleLine")');
    qryMain.SQL.Add('left join tblpqadetails pqad on pqad.PQAID = pqa.PQAID and pqad.PQAType = "Bin"');
    qryMain.SQL.Add('left join tblproductbin pb on pb.BinID = pqad.Value');
  end;
  if self is TSalesListOutstandingGUI then qryMain.SQL.Add('Where ((ifnull(Qtysold,0)<>0 and ifnull(SL.Shipped,0)=0 and ifnull(S.BOID,"")="") or (S.IsSalesOrder="T"))');
  qryMain.SQL.Add('Order BY SL.SaleID Desc');

end;

procedure TSalesListReportGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  DoHideProgressbar;
end;

procedure TSalesListReportGUI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  DoShowProgressbar(2 , WAITMSG);
  DoStepProgressbar;
end;

procedure TSalesListReportGUI.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;

procedure TSalesListReportGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainClientID.fieldname);
  RemoveFieldfromGrid(QrymainEmployeeId.fieldname);
  RemoveFieldfromGrid(QrymainUnitofMeasureSaleLines.fieldname);
  RemoveFieldfromGrid(QrymainUnitofMeasureMultiplier.fieldname);
  SetUpcustomFields('Cust');
  SetUpcustomFields('SalesLinesCustField1,SalesLinesCustField2,SalesLinesCustField3,SalesLinesCustField4,SalesLinesCustField5,SalesLinesCustField6,SalesLinesCustField7,SalesLinesCustField8,SalesLinesCustField9,SalesLinesCustField10',
    ltSaleslines);

end;


procedure TSalesListReportGUI.FormCreate(Sender: TObject);
begin
  self.PopulateSQL;
  self.RefreshOrignalSQL();
  inherited;
  AddCalccolumn('Shipped', false);
  AddCalccolumn('BackOrder', True);
  AddCalccolumn('LineTotalEx', True);
  AddCalccolumn('LineTotalInc', True);
  AddCalccolumn('LineTax', True);
  AddCalccolumn('Attrib1SaleRatetotal', True);
end;

procedure TSalesListReportGUI.FormShow(Sender: TObject);
(*var
  qry : TERPQuery;*)
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
(*  grdMain.columnbyName('ProductName').DisplayLabel := AppEnv.DefaultClass.PartColumn;
//  grdMain.columnbyName('Department').DisplayLabel := AppEnv.DefaultClass.ThirdColumn;
//  grdMain.columnbyName('Type').DisplayLabel := AppEnv.DefaultClass.SecondColumn;
//  grdMain.columnbyName('Manufacturer').DisplayLabel := AppEnv.DefaultClass.FirstColumn;
  grdMain.columnbyName('ThirdColumn').DisplayLabel := AppEnv.DefaultClass.ThirdColumn;
  grdMain.columnbyName('SecondColumn').DisplayLabel := AppEnv.DefaultClass.SecondColumn;
  grdMain.columnbyName('FirstColumn').DisplayLabel := AppEnv.DefaultClass.FirstColumn;*)
  if  AppEnv.CompanyPrefs.ShowSalesWarrantyEndsOn then begin
    grdmain.AddField('WarrantyEndsOn');
  end else begin
    RemoveFieldfromGrid('WarrantyEndsOn');
  end;

  if  AppEnv.CompanyPrefs.ShowSalesWarrantyPeriod then begin
    grdmain.AddField('WarrantyPeriod');
  end else begin
    RemoveFieldfromGrid('WarrantyPeriod');
  end;

  if Trim(AppEnv.CompanyPrefs.SalesWarrantyEndsOnCaption) <> '' then
    grdmain.ColumnByName('WarrantyEndsOn').DisplayLabel :=
      Trim(AppEnv.CompanyPrefs.SalesWarrantyEndsOnCaption);

  (*if Trim(AppEnv.CompanyPrefs.SalesWarrantyPeriodCaption) <> '' then
    grdmain.ColumnByName('WarrantyPeriod').DisplayLabel :=
      Trim(AppEnv.CompanyPrefs.SalesWarrantyPeriodCaption);
    if ProcPrefs.UseFld7AsSteelWeight then
  begin
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := qryMain.Connection;
      qry.SQL.Text := 'select CFLabel7 from tblcustomfields';
      qry.Open;
      Field7Caption := qry.Fields[0].AsString;
    finally
      qry.Free;
    end;

    grdMain.AddField('ProductFLD7');
    qryMainProductFld7.DisplayLabel := Field7Caption;
  end;*)

end;

procedure TSalesListReportGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMain.FieldByName('TransactionType').AsString;
  inherited;
end;


procedure TSalesListReportGUI.btnProductListClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TSalesListReportDetailGUI');
end;
procedure TSalesListReportGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
  finally
    EnableForm;
  end;
end;
procedure TSalesListReportGUI.OnSetUpcustomFields(CustfieldVisible: Boolean;fieldno: Integer; FlagFieldname, fieldname, DisplayLabel: String);
begin
  inherited;
  if fieldno = 7 then
    if ProcPrefs.UseFld7AsSteelWeight then begin
      fField7Caption :=   DisplayLabel;
    end else begin
      fField7Caption :=   '';
    end;

end;


initialization
  RegisterClassOnce(TSalesListReportGUI);
end.
