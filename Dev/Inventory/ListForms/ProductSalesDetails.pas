{
   Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   05/05/05 1.00.01  BJ(1)Used the hidden columns- HProductName and HType
                          To implement the sorting. These columns are populated with
                          values for all the rows unlike the 'ProductName' and 'Type'
                          field which are nullified for the 'detail rows'.
                          Not possible to sort on the 'ProductName' field  when the form
                          is in 'Detail' or 'Extra Detail' mode and not possible
                          to sorton 'Type' field when the form is in 'extra detail'
                          mode.
                       (2)new variable 'FilterField' introduced which gets intiialised
                          when 'Apply filter' is fired with the active column name
                          This variable is used in the 'Refreshtotal's to calculate the
                          total.
                       (3)Filtering on a 'Summary Field' for the 'Group record' is
                          disabled becuase calculating the total is a problem.
   07/09/05 1.00.##  ISB	Modified To Work With New Filtering on Baselisting.
   25/10/05 1.00.03  MV   Added CustomerName and additional fields to support the
                          addition of GrossProfit.
   26/10/05 1.00.04  MV   Added Product Descriptions of Manufacturer, Size, Type
                          and custom fields.
   28/10/05 1.00.05  MV   Fixed error in GrossProfit, added GrossProfitTotal to SQL
   04/01/06 1.00.06  DSP  Changed the GrossProfitTotal field to be displayed
                          as dollars.
   30/01/06 1.00.07  IJB  Added drill down on InvoiceNo, added UnitOfMeasure.
   28/02/06 1.00.08  DSP  The fields HType and HProductName are now hidden.

}

unit ProductSalesDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DBCtrls,
  wwdblook, wwcheckbox, wwDialog, Wwlocate, SelectionDialog, DNMPanel,
  MemDS, DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog,
   Shader, kbmMemTable, DAScript, MyScript, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TProductDetailsGUI = class(TBaseListingGUI)
    Panel4: TPanel;
    lblClassTitle: TLabel;
    Label4: TLabel;
    chkAllClass: TwwCheckBox;
    cboClass: TwwDBLookupCombo;
    cboClassQry: TERPQuery;
    chkincludemanProducts: TwwCheckBox;
    lblincludemanProducts: TLabel;
    QrycF: TERPQuery;
    QrycFCFLabel1: TWideStringField;
    QrycFCFLabel2: TWideStringField;
    QrycFCFLabel3: TWideStringField;
    QrycFCFLabel4: TWideStringField;
    QrycFCFLabel5: TWideStringField;
    QrycFCFLabel6: TWideStringField;
    QrycFCFLabel7: TWideStringField;
    QrycFCFLabel8: TWideStringField;
    QrycFCFLabel9: TWideStringField;
    QrycFCFLabel10: TWideStringField;
    QrycFCFLabel11: TWideStringField;
    QrycFCFLabel12: TWideStringField;
    QrycFCFLabel13: TWideStringField;
    QrycFCFLabel14: TWideStringField;
    QrycFCFLabel15: TWideStringField;
    QrycFCFLabel16: TWideStringField;
    QrycFCFLabel17: TWideStringField;
    QrycFCFLabel18: TWideStringField;
    QrycFCFCust1: TWideStringField;
    QrycFCFCust2: TWideStringField;
    QrycFCFCust3: TWideStringField;
    QrycFCFCust4: TWideStringField;
    QrycFCFCust5: TWideStringField;
    QrycFCFCust6: TWideStringField;
    QrycFCFCust7: TWideStringField;
    QrycFCFCust8: TWideStringField;
    QrycFCFCust9: TWideStringField;
    QrycFCFCust10: TWideStringField;
    QrycFCFCust11: TWideStringField;
    QrycFCFCust12: TWideStringField;
    QrycFCFCust13: TWideStringField;
    QrycFCFCust14: TWideStringField;
    QrycFCFCust15: TWideStringField;
    QrycFCFCust16: TWideStringField;
    QrycFCFCust17: TWideStringField;
    QrycFCFCust18: TWideStringField;
    qryMainCategory: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainfirstColumn: TWideStringField;
    qryMainSecondcolumn: TWideStringField;
    qryMainThirdcolumn: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainTransactionType: TWideStringField;
    qryMainFormName: TWideStringField;
    qryMainInvoiceNo: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainQty: TFloatField;
    qryMainUnitOfMeasure: TWideStringField;
    qryMainFXCode: TWideStringField;
    qryMainForeignTotalLineAmount: TFloatField;
    qryMainTotalAmountEx: TFloatField;
    qryMainTotalProfitEx: TFloatField;
    qryMainTotalProfitInc: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    qryMainGrossProfitTotal: TFloatField;
    qryMainLineCostEx: TFloatField;
    qryMainTransactionNo: TIntegerField;
    qryMainProductID: TIntegerField;
    qryMainEmployeeName: TWideStringField;
    qryMainAttrib1Sale: TFloatField;
    qryMainAttrib2Sale: TFloatField;
    qryMainAttrib1SaleRate: TFloatField;
    qryMainProductDescription: TWideStringField;
    qryMainIsSpecial: TWideStringField;
    qryMainDetails: TLargeintField;
    qryMainSaleLineID: TIntegerField;
    qryMainTypeName: TWideStringField;
    qryMainconverted: TWideStringField;
    qryMainEmail: TWideStringField;
    qryMainStreet: TWideStringField;
    qryMainStreet2: TWideStringField;
    qryMainSuburb: TWideStringField;
    qryMainState: TWideStringField;
    qryMainPostcode: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainCommodityCode: TWideStringField;
    qryMainNetWeightKg: TFloatField;
    qryMainProductUOM: TWideStringField;
    qryMainCountryOfOrigin: TWideStringField;
    qryMainExWorks: TFloatField;
    qryMainFormulaQtyShippedValue1: TFloatField;
    qryMainFormulaQtyShippedValue2: TFloatField;
    qryMainFormulaQtyShippedValue3: TFloatField;
    qryMainFormulaQtyShippedValue4: TFloatField;
    qryMainFormulaQtyShippedValue5: TFloatField;
    qryMainFormulaQtyShippedValue: TFloatField;
    qryMainPartCalcformula: TWideStringField;
    qryMainFormulaDEtails: TWideStringField;
    qryMainFormula: TWideStringField;
    qryMainCustomerCUSTFLD1: TWideStringField;
    qryMainCustomerCUSTFLD2: TWideStringField;
    qryMainCustomerCUSTFLD3: TWideStringField;
    qryMainCustomerCUSTFLD4: TWideStringField;
    qryMainCustomerCUSTFLD5: TWideStringField;
    qryMainCustomerCUSTFLD6: TWideStringField;
    qryMainCustomerCUSTFLD7: TWideStringField;
    qryMainCustomerCUSTFLD8: TWideStringField;
    qryMainCustomerCUSTFLD9: TWideStringField;
    qryMainCustomerCUSTFLD10: TWideStringField;
    qryMainCustomerCUSTFLD11: TWideStringField;
    qryMainCustomerCUSTFLD12: TWideStringField;
    qryMainCustomerCUSTFLD13: TWideStringField;
    qryMainCustomerCUSTFLD14: TWideStringField;
    qryMainCustomerCUSTFLD15: TWideStringField;
    qryMainCustomerCUSTDATE1: TDateTimeField;
    qryMainCustomerCUSTDATE2: TDateTimeField;
    qryMainCustomerCUSTDATE3: TDateTimeField;
    qryMainFirstName: TWideStringField;
    qryMainLastName: TWideStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboClassChange(Sender: TObject);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure chkAllClassClick(Sender: TObject);
    procedure grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure actRefreshQryExecute(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure chkincludemanProductsClick(Sender: TObject);
    procedure chkIgnoreDatesClick(Sender: TObject);
    procedure cboDateRangeCloseUp(Sender: TObject);
    procedure qryMainBeforeOpen(DataSet: TDataSet);

  private
    { Private declarations }
    SavedFilterSales:string;
    strSelectedFieldData: string;
    fiProductId: Integer;
    fiClassId:Integer;
    fsFirstcolumn: String;
    fsSecondcolumn: String;
    fsThirdcolumn: String;
    procedure MakeQrymain;
    procedure SetProductID(const Value: Integer);
    procedure setClassId(const Value: Integer);
    procedure SetFirstcolumn(const Value: String);
    procedure SetSecondcolumn(const Value: String);
    procedure SetThirdcolumn(const Value: String);
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    Procedure SetGridColumns;override;
    procedure setDashboardDetail(const Value: Boolean);override;
    Procedure AdjustDisplayLabels; override;
  public
    Property ProductId :Integer read fiProductId write SetProductID;
    Property ClassId :Integer write setClassId;
    Property Firstcolumn  : String read fsFirstcolumn   write SetFirstcolumn;
    Property Secondcolumn : String read fsSecondcolumn  write SetSecondcolumn;
    Property Thirdcolumn  : String read fsThirdcolumn   write SetThirdcolumn;
  end;

implementation

uses FastFuncs, CommonDbLib,CommonLib, AppEnvironment, tcConst,
  ProductQtyLib, tcDataUtils, PQALib, DbSharedObjectsObj, ProductSalesDetailsSQL;

{$R *.dfm}
Procedure TProductDetailsGUI.MakeQrymain;
var
  Report: TProductSalesDetailsReport;
  msg: string;
begin
  if Qrymain.active then Qrymain.close;
  Report := TProductSalesDetailsReport.Create;
  try
    Report.ProductID := fiProductID;
    Report.IncludeProductsUsedInManufacture := chkincludemanProducts.Checked;
    if chkAllClass.Checked then Report.DepartmentID := 0
    else Report.DepartmentID := cboClassQry.FieldByName('ClassID').AsInteger;
    Report.FirstColumn := FirstColumn;
    Report.SecondColumn := SecondColumn;
    Report.ThirdColumn := ThirdColumn;
    Report.DateFrom := FilterDateFrom;
    Report.DateTo := FilterDateTo;
    Report.PopulateReportSQL(qryMain.SQL, msg);
  finally
    Report.Free;
  end;
//    Qrymain.SQL.clear;
//      Qrymain.SQL.Add('SELECT "S" as Category,  ');
//      Qrymain.SQL.Add('S.SaleDate as SaleDate,');
//      Qrymain.SQL.Add(ProductQtyLib.firstcolumn   + ' as firstColumn,');
//      Qrymain.SQL.Add(ProductQtyLib.Secondcolumn  + ' as Secondcolumn,');
//      Qrymain.SQL.Add(ProductQtyLib.Thirdcolumn   + ' as Thirdcolumn,');
//      Qrymain.SQL.Add(' Trim(SL.ProductName) as ProductName , ');
//      Qrymain.SQL.Add(' ifnull(TT.Description , if(S.IsInvoice="T" , "Invoice" , if(issalesorder = "T" , "Sales Order" , if(iscashSale="T" , "Cash Sale" , if(isRefund = "T" , "Refund" , if(isLayby="T", "Layby" , "")))))) as TransactionType,');
//      Qrymain.SQL.Add(' ifnull(TT.FormName , if(S.IsInvoice="T" , "TInvoiceGUI" , if(issalesorder = "T" , "TSalesOrderGUI" , if(iscashSale="T" , "TCashSaleGUI" , if(isRefund = "T" , "TRefundGUI" , if(isLayby="T", "TSalesOrderGUI" , "")))))) as FormName,');
//      Qrymain.SQL.Add(' S.InvoiceDocNumber as InvoiceNo, ');
//      Qrymain.SQL.Add(' S.CustomerName as CustomerName, ');
//      Qrymain.SQL.Add(' Round(Sum(SL.Shipped), ' + IntToStr((*appEnv.CompanyPrefs.QtyRoundTo*)tcConst.GeneralRoundPlaces) + ') as Qty, ');
//      Qrymain.SQL.Add(' SL.UnitOfMeasureSaleLines as UnitOfMeasure, ');
//      Qrymain.SQL.Add(' Convert(FXCode( S.ForeignExchangeCode ,ifnull(SL.ForeignExchangeSellRate ,S.ForeignExchangeRate) ,' +quotedstr(Appenv.RegionalOptions.ForeignExDefault) +'), char(100)) as FXCode,');
//      Qrymain.SQL.Add(' Sum(SL.ForeignTotalLineAmount) as ForeignTotalLineAmount,');
//      Qrymain.SQL.Add(' Sum(SL.TotalLineAmount) as `Total Amount (Ex)`, ');
//      Qrymain.SQL.Add(' Round(Sum(SL.TotalLineAmount) - SUM(SL.LineCost*SL.Shipped),'+intToStr(CurrencyRoundPlaces) +') as `Total Profit (Ex)`, ');
//      Qrymain.SQL.Add(' Round(Sum(SL.TotalLineAmountInc) - SUM(SL.LineCostInc*SL.Shipped),'+intToStr(CurrencyRoundPlaces) +') as `Total Profit (Inc)`, ');
//      Qrymain.SQL.Add(' Sum(SL.TotalLineAmountInc) as `Total Amount (Inc)`, ');
//      Qrymain.SQL.Add(' SL.TotalLineAmount as GrossProfitTotal, ');
//      Qrymain.SQL.Add(' Round(SL.LineCost*SL.Shipped,'+intToStr(CurrencyRoundPlaces) +') as `Line Cost (Ex)`,');
//      Qrymain.SQL.Add(' S.SaleID as TransactionNo, ');
//      Qrymain.SQL.Add(' SL.ProductID as ProductID, ');
//      Qrymain.SQL.Add(' S.EmployeeName as EmployeeName, ');
//      Qrymain.SQL.Add(' Sum(SL.Attrib1Sale) as Attrib1Sale, ');
//      Qrymain.SQL.add('Sum(SL.Attrib2Sale) as Attrib2Sale,  ');
//      Qrymain.SQL.Add(' Sum(SL.Attrib1SaleRate) as Attrib1SaleRate, ');
//      Qrymain.SQL.Add(' SL.Product_Description as ProductDescription, ');
//      Qrymain.SQL.Add(' IF(INSTR(SL.CustomData, "PriceScheme"),"T","F") as IsSpecial, ');
//      Qrymain.SQL.Add(' 2 as Details , ');
//      Qrymain.SQL.Add(' SL.SaleLineID as SaleLineID, ');
//      Qrymain.SQL.add('CT.TypeName as TypeName,');
//      Qrymain.SQL.Add(' S.converted as converted,');
//      Qrymain.SQL.Add(' C.Email , ');
//      Qrymain.SQL.Add(' C.Street , ');
//      Qrymain.SQL.Add(' C.Street2 , ');
//      Qrymain.SQL.Add(' C.Suburb , ');
//      Qrymain.SQL.Add(' C.State , ');
//      Qrymain.SQL.Add(' C.Postcode,');
//      Qrymain.SQL.Add(' C.Country,');
//      Qrymain.SQL.Add('P.CommodityCode,');
//      Qrymain.SQL.Add('P.NetWeightKg,');
//      Qrymain.SQL.Add('P.ProductUOM,');
//      Qrymain.SQL.Add('CTRY.Country as CountryOfOrigin,');
//      Qrymain.SQL.Add('P.Ex_Works as ExWorks,');
//      Qrymain.SQL.Add('C.CUSTFLD1 as CustomerCUSTFLD1,');
//      Qrymain.SQL.Add('C.CUSTFLD2 as CustomerCUSTFLD2,');
//      Qrymain.SQL.Add('C.CUSTFLD3 as CustomerCUSTFLD3,');
//      Qrymain.SQL.Add('C.CUSTFLD4 as CustomerCUSTFLD4,');
//      Qrymain.SQL.Add('C.CUSTFLD5 as CustomerCUSTFLD5,');
//      Qrymain.SQL.Add('C.CUSTFLD6 as CustomerCUSTFLD6,');
//      Qrymain.SQL.Add('C.CUSTFLD7 as CustomerCUSTFLD7,');
//      Qrymain.SQL.Add('C.CUSTFLD8 as CustomerCUSTFLD8,');
//      Qrymain.SQL.Add('C.CUSTFLD9 as CustomerCUSTFLD9,');
//      Qrymain.SQL.Add('C.CUSTFLD10 as CustomerCUSTFLD10,');
//      Qrymain.SQL.Add('C.CUSTFLD11 as CustomerCUSTFLD11,');
//      Qrymain.SQL.Add('C.CUSTFLD12 as CustomerCUSTFLD12,');
//      Qrymain.SQL.Add('C.CUSTFLD13 as CustomerCUSTFLD13,');
//      Qrymain.SQL.Add('C.CUSTFLD14 as CustomerCUSTFLD14,');
//      Qrymain.SQL.Add('C.CUSTFLD15 as CustomerCUSTFLD15,');
//      Qrymain.SQL.Add('convert(C.CUSTDATE1, dateTime)  as CustomerCUSTDATE1,');
//      Qrymain.SQL.Add('convert(C.CUSTDATE2, dateTime)  as CustomerCUSTDATE2,');
//      Qrymain.SQL.Add('convert(C.CUSTDATE3, dateTime)  as CustomerCUSTDATE3,');
//      Qrymain.SQL.Add('SL.FormulaQtyShippedValue1 as FormulaQtyShippedValue1,');
//      Qrymain.SQL.Add('SL.FormulaQtyShippedValue2 as FormulaQtyShippedValue2,');
//      Qrymain.SQL.Add('SL.FormulaQtyShippedValue3 as FormulaQtyShippedValue3,');
//      Qrymain.SQL.Add('SL.FormulaQtyShippedValue4 as FormulaQtyShippedValue4,');
//      Qrymain.SQL.Add('SL.FormulaQtyShippedValue5 as FormulaQtyShippedValue5,');
//      Qrymain.SQL.Add('SL.FormulaQtyShippedValue as FormulaQtyShippedValue,');
//      Qrymain.SQL.Add('F.formulaNAme as PartCalcformula,');
//      Qrymain.SQL.Add('F.formula as formula,');
//      Qrymain.SQL.Add('DescribeFormula(F.Formula) as formulaDetails');
//      Qrymain.SQL.Add('FROM ');
//      Qrymain.SQL.Add('tblsales AS S');
//      Qrymain.SQL.Add(' INNER JOIN tblSalesLines as SL USING(SaleID) ');
//      Qrymain.SQL.Add('LEft  join (tblfesaleslines FE inner join tblfeformula F on FE.FormulaId = F.formulaID) on FE.salelineId = SL.saleLineId');
//      Qrymain.SQL.Add(' INNER JOIN tblparts      as P ON PARTSID = SL.ProductID ');
//      Qrymain.SQL.Add(' Left JOIN tblcountries as CTRY on CTRY.CountryId = P.CountryofOriginID');
//      Qrymain.SQL.Add(' Left  JOIN tblPQA        as PQA on PQA.TransID = S.SaleId and PQA.TransLineID =SL.SaleLineId and PQA.TransType in (' + SalesTransTypes+')');
//      Qrymain.SQL.Add(' Left JOIN tblpqatranstypes as TT ON TT.TRansType  = PQA.TransType ');
//      Qrymain.SQL.Add(' INNER JOIN tblclients C ON C.ClientID=S.ClientID ');
//      Qrymain.SQL.Add(' LEFT JOIN tblClientType CT ON C.ClientTypeID=CT.ClientTypeID ');
//      Qrymain.SQL.Add('Where  ((S.IsPOS ="T" or S.IsRefund ="T"  ' +
//                ' or S.IsCashSale="T" or S.IsInvoice="T" '+
//                ' or S.IsSalesOrder="T" or S.IsLayby ="T") '+
//                ' AND SL.Invoiced="T" AND S.Deleted ="F"  AND S.IsQuote="F"  AND S.converted = "F" '+
//                ' AND S.SaleDate Between   :FromDate  AND   :ToDate AND S.ClassID Like :ClassId)');
//
//      if fiProductID<> 0 then begin
//        Qrymain.SQL.Add(' and SL.ProductID = ' +inttostr(fiProductID));
//      end else if firstcolumn <> '' then  begin
//        Qrymain.SQL.Add(' and '+ProductQtyLib.firstcolumn('P')   + ' = ' +Quotedstr(Firstcolumn));
//      end else if Secondcolumn <> '' then  begin
//        Qrymain.SQL.Add(' and '+ProductQtyLib.secondcolumn('P')   + ' = ' +Quotedstr(Secondcolumn));
//      end else if Thirdcolumn <> '' then  begin
//        Qrymain.SQL.Add(' and '+ProductQtyLib.thirdcolumn('P')   + ' = ' +Quotedstr(Thirdcolumn));
//      end;
//
//      Qrymain.SQL.Add(' GROUP BY SL.ProductID, SL.UnitOfMeasureSaleLines, S.SaleID ');
//
//      {manufaturing products}
//      if chkincludemanProducts.checked then begin
//        Qrymain.SQL.add('union all');
//        Qrymain.SQL.Add('SELECT "M" as Category, ');
//        Qrymain.SQL.Add('S.SaleDate as SaleDate,');
//        Qrymain.SQL.Add(ProductQtyLib.firstcolumn   + ' as firstColumn,');
//        Qrymain.SQL.Add(ProductQtyLib.Secondcolumn  + ' as Secondcolumn,');
//        Qrymain.SQL.Add(ProductQtyLib.Thirdcolumn   + ' as Thirdcolumn,');
//        Qrymain.SQL.Add('PTP.ProductName as ProductName, ');
//        Qrymain.SQL.Add('"Manufacturing" as TransactionType,');
//        Qrymain.SQL.Add(' ifnull(TT.FormName , if(S.IsInvoice="T" , "TInvoiceGUI" , if(issalesorder = "T" , "TSalesOrderGUI" , if(iscashSale="T" , "TCashSaleGUI" , if(isRefund = "T" , "TRefundGUI" , if(isLayby="T", "TSalesOrderGUI" , "")))))) as FormName,');
//        Qrymain.SQL.Add(' S.InvoiceDocNumber as InvoiceNo,');
//        Qrymain.SQL.Add('S.CustomerName as Customername,');
//        Qrymain.SQL.Add('Sum(PTP.Qty) as Qty,');
//        Qrymain.SQL.Add('PTP.UnitOfMeasure as UnitOfMeasure,');
//        Qrymain.SQL.Add(' Convert(FXCode( S.ForeignExchangeCode ,ifnull(SL.ForeignExchangeSellRate ,S.ForeignExchangeRate) ,' +quotedstr(Appenv.RegionalOptions.ForeignExDefault) +'), char(100)) as FXCode,');
//        Qrymain.SQL.Add('Sum(PTP.Qty*PT.Price*ifnull(SL.ForeignExchangeSellRate ,ifnull(S.ForeignExchangeRate,1))) as ForeignTotalLineAmount,');
//        Qrymain.SQL.Add('Sum(PTP.Qty*PT.Price)  as `Total Amount (Ex)`,');
//        Qrymain.SQL.Add('Sum(PTP.Qty*PT.Price) - Sum(PTP.Qty * PT.Cost) as `Total Profit (Ex)`,');
//        Qrymain.SQL.Add('Sum(PTP.Qty*PT.Price) - Sum(PTP.Qty * PT.Cost)  as `Total Profit (Inc)`,');
//        Qrymain.SQL.Add('Sum(PTP.Qty*PT.Price)  as `Total Amount (Inc)`,');
//        Qrymain.SQL.Add('Sum(PTP.Qty*PT.Price)  as GrossProfitTotal, ');
//        Qrymain.SQL.Add('Sum(PTP.Qty * PT.Cost)  as `Line Cost (Ex)`,');
//        Qrymain.SQL.Add('S.SaleID as TransactionNo,');
//        Qrymain.SQL.Add('PTP.ProductId as ProductId,');
//        Qrymain.SQL.Add('S.EmployeeName as EmployeeName,');
//        Qrymain.SQL.Add('Sum(PTP.Qty * P.Attrib1Sale) as Attrib1Sale,');
//        Qrymain.SQL.Add('Sum(PTP.Qty * P.Attrib2Sale) as Attrib2Sale,');
//        Qrymain.SQL.Add('P.Attrib1SaleRate as Attrib1SaleRate,');
//        Qrymain.SQL.Add('P.PARTSDESCRIPTION as ProductDescription,');
//        Qrymain.SQL.Add('"F" as IsSpecial,');
//        Qrymain.SQL.Add('2 as Details ,');
//        Qrymain.SQL.Add('PTP.ProcTreePartId as SaleLineID, ');
//        Qrymain.SQL.add('CT.TypeName as TypeName,');
//        Qrymain.SQL.Add('S.Converted as Converted,');
//        Qrymain.SQL.Add(' C.Email , ');
//        Qrymain.SQL.Add(' C.Street , ');
//        Qrymain.SQL.Add(' C.Street2 , ');
//        Qrymain.SQL.Add(' C.Suburb , ');
//        Qrymain.SQL.Add(' C.State , ');
//        Qrymain.SQL.Add(' C.Postcode,');
//        Qrymain.SQL.Add(' C.Country,');
//        Qrymain.SQL.Add('P.CommodityCode,');
//        Qrymain.SQL.Add('P.NetWeightKg,');
//        Qrymain.SQL.Add('P.ProductUOM,');
//        Qrymain.SQL.Add('CTRY.Country as CountryOfOrigin,');
//      Qrymain.SQL.Add('P.Ex_Works as ExWorks,');
//      Qrymain.SQL.Add('C.CUSTFLD1 as CustomerCUSTFLD1,');
//      Qrymain.SQL.Add('C.CUSTFLD2 as CustomerCUSTFLD2,');
//      Qrymain.SQL.Add('C.CUSTFLD3 as CustomerCUSTFLD3,');
//      Qrymain.SQL.Add('C.CUSTFLD4 as CustomerCUSTFLD4,');
//      Qrymain.SQL.Add('C.CUSTFLD5 as CustomerCUSTFLD5,');
//      Qrymain.SQL.Add('C.CUSTFLD6 as CustomerCUSTFLD6,');
//      Qrymain.SQL.Add('C.CUSTFLD7 as CustomerCUSTFLD7,');
//      Qrymain.SQL.Add('C.CUSTFLD8 as CustomerCUSTFLD8,');
//      Qrymain.SQL.Add('C.CUSTFLD9 as CustomerCUSTFLD9,');
//      Qrymain.SQL.Add('C.CUSTFLD10 as CustomerCUSTFLD10,');
//      Qrymain.SQL.Add('C.CUSTFLD11 as CustomerCUSTFLD11,');
//      Qrymain.SQL.Add('C.CUSTFLD12 as CustomerCUSTFLD12,');
//      Qrymain.SQL.Add('C.CUSTFLD13 as CustomerCUSTFLD13,');
//      Qrymain.SQL.Add('C.CUSTFLD14 as CustomerCUSTFLD14,');
//      Qrymain.SQL.Add('C.CUSTFLD15 as CustomerCUSTFLD15,');
//      Qrymain.SQL.Add('C.CUSTDATE1 as CustomerCUSTDATE1,');
//      Qrymain.SQL.Add('C.CUSTDATE2 as CustomerCUSTDATE2,');
//      Qrymain.SQL.Add('C.CUSTDATE3 as CustomerCUSTDATE3,');
//      Qrymain.SQL.Add('SL.FormulaQtyShippedValue1 as FormulaQtyShippedValue1,');
//      Qrymain.SQL.Add('SL.FormulaQtyShippedValue2 as FormulaQtyShippedValue2,');
//      Qrymain.SQL.Add('SL.FormulaQtyShippedValue3 as FormulaQtyShippedValue3,');
//      Qrymain.SQL.Add('SL.FormulaQtyShippedValue4 as FormulaQtyShippedValue4,');
//      Qrymain.SQL.Add('SL.FormulaQtyShippedValue5 as FormulaQtyShippedValue5,');
//      Qrymain.SQL.Add('SL.FormulaQtyShippedValue as FormulaQtyShippedValue,');
//      Qrymain.SQL.Add('F.formulaNAme as PartCalcformula,');
//      Qrymain.SQL.Add('F.formula as formula,');
//      Qrymain.SQL.Add('DescribeFormula(F.Formula) as formulaDetails');
//
//
//        Qrymain.SQL.Add('FROM ');
//        Qrymain.SQL.Add('tblsales AS S');
//        Qrymain.SQL.Add('Inner Join tblsaleslines AS SL ON S.SaleID = SL.SaleID');
//        Qrymain.SQL.Add('Left join (tblfesaleslines FE inner join tblfeformula F on FE.FormulaId = F.formulaID) on FE.salelineId = SL.saleLineId');
//        Qrymain.SQL.Add('Inner Join tblproctreepart AS PTP ON SL.SaleID = PTP.SaleId AND SL.SaleLineID = PTP.SaleLineId');
//        Qrymain.SQL.Add('Inner Join tblproctree AS PT ON PTP.ProcTreeId = PT.ProcTreeId AND PT.ParentId <> 0');
//        Qrymain.SQL.Add('Inner Join tblparts AS P ON PTP.ProductId = P.PARTSID');
//        Qrymain.SQL.Add(' Left JOIN tblcountries as CTRY on CTRY.CountryId = P.CountryofOriginID');
//        Qrymain.SQL.Add('LEFT  Join tblpqa AS PQA ON PTP.SaleId = PQA.TransID AND PTP.ProcTreePartId = PQA.TransLineID AND PQA.TransType in(' + ManufactureTypes +')');
//        Qrymain.SQL.Add('LEFT Join tblpqatranstypes AS TT ON PQA.TransType = TT.Transtype');
//        Qrymain.SQL.Add(' INNER JOIN tblclients C ON C.ClientID=S.ClientID');
//        Qrymain.SQL.Add(' LEFT JOIN tblClientType CT ON C.ClientTypeID=CT.ClientTypeID ');
//        Qrymain.SQL.Add(' Where S.SaleDate Between   :FromDate  AND   :ToDate');
//
//      if fiProductID<> 0 then begin
//          Qrymain.SQL.Add(' and PTP.ProductID = ' +inttostr(fiProductID));
//      end else if firstcolumn <> '' then  begin
//        Qrymain.SQL.Add(' and '+ProductQtyLib.firstcolumn('PTP')   + ' = ' +Quotedstr(Firstcolumn));
//      end else if Secondcolumn <> '' then  begin
//        Qrymain.SQL.Add(' and '+ProductQtyLib.secondcolumn('PTP')   + ' = ' +Quotedstr(Secondcolumn));
//      end else if Thirdcolumn <> '' then  begin
//        Qrymain.SQL.Add(' and '+ProductQtyLib.thirdcolumn('PTP')   + ' = ' +Quotedstr(Thirdcolumn));
//      end;
//        Qrymain.SQL.Add(' GROUP BY PTP.ProductID, PTP.UnitOfMeasure, S.SaleID;');
//      end;
  if assigned(QueryManipulationObj) then RefreshOrignalSQL;
end;

procedure TProductDetailsGUI.RefreshQuery;
//var
//  SelectedClassID:String;
begin
//  if not chkAllClass.Checked then SelectedClassID := cboClass.LookupValue else SelectedClassID := '%';
//
//  if qryMain.active then qryMain.close;
//  qryMain.Params.ParamByName('FromDate').AsDate :=  FilterDateFrom;
//  qryMain.Params.ParamByName('ToDate').AsDate :=  FilterDateTo;
//  qryMain.Params.ParamByName('ClassId').asString:=  SelectedClassID;
  if not Searching then
    MakeQrymain;
  inherited;
end;

procedure TProductDetailsGUI.RefreshTotals;
var
  TotalEx, TotalInc, TotalGrossProfit, TotalPercentProfit, TotalLineCostEx, totalQty: double;
  Bookmark: TBookmark;
begin
  TotalEx := 0;
  TotalInc := 0;
  TotalLineCostEx := 0;
  TotalGrossProfit := 0;
  totalQty :=0;

  qryMain.DisableControls;
  Bookmark := qryMain.GetBookmark;
  Try
    with qryMain do begin
      First;
      while not Eof do begin
          TotalEx := TotalEx + qryMainTotalAmountEx.AsCurrency;
          TotalInc := TotalInc + qryMainTotalAmountInc.AsCurrency;
          TotalLineCostEx := TotalLineCostEx + RoundCurrency(qryMainLineCostEx.AsCurrency);
          TotalGrossProfit := TotalGrossProfit + RoundCurrency(qryMainGrossProfitTotal.AsCurrency);
          totalQty := totalQty + qryMainQty.asFloat;
        Next;
      end;
    end;
  finally
    qryMain.GotoBookmark(Bookmark);
    qryMain.FreeBookmark(Bookmark);
    qryMain.EnableControls;
  end;

  TotalPercentProfit := DivZer((TotalEx - TotalLineCostEx), TotalEx) * 100;

  grdMain.ColumnByName('Total Amount (Ex)').FooterValue := FloatToStrF(TotalEx, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Total Amount (Inc)').FooterValue := FloatToStrF(TotalInc, ffCurrency, 15, CurrencyRoundPlaces);

  grdMain.ColumnByName('GrossProfit').FooterValue := FloatToStrF(TotalGrossProfit, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('PercentProfit').FooterValue := FormatFloat('#.00%', TotalPercentProfit);
  //if fiProductID<> 0 then
  grdMain.ColumnByName('Qty').FooterValue := FloatToStrF(TotalQty, ffFixed, 15, 2);

end;

procedure TProductDetailsGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  ProductSummaryGUI := nil;
end;

procedure TProductDetailsGUI.FormCreate(Sender: TObject);
begin
  fiProductId:=0;
  fiClassId:=0;
//  MakeQrymain;
  inherited;
  ShowChartViewOnPopup := True;
  cboClassQry.Connection := qryMain.Connection;
(*  grdMain.ColumnByName('FirstColumn').DisplayLabel := AppEnv.DefaultClass.FirstColumn;
  grdMain.ColumnByName('SecondColumn').DisplayLabel := AppEnv.DefaultClass.SecondColumn;
  grdMain.ColumnByName('ThirdColumn').DisplayLabel := AppEnv.DefaultClass.ThirdColumn;*)
end;

procedure TProductDetailsGUI.FormShow(Sender: TObject);
begin
  if FirstColumn <> '' then begin
    //edtSearch.Text := firstColumn;
    SearchMode := smFullList;
    RefreshQuery;
  end;
//    MakeQrymain;
    if cboClassQry.active= false then cboClassQry.Open;
    if fiClassId = 0 then begin
      cboClassQry.Locate('ClassName', AppEnv.DefaultClass.DefaultClassName, [loCaseInsensitive]);
      cboClass.Text        := AppEnv.DefaultClass.DefaultClassName;
      cboClass.LookupValue := cboClassQry.FieldByName('ClassID').AsString;
    end;

  inherited;
  SavedFilterSales := '';
  if self.ErrorOccurred then
    exit;
//  RefreshQuery;
  if ProductID <> 0 then begin
    TitleLabel.caption := 'Product Sales Details';
    TimerMsg(lblNote , 'Product Sales Details of ' + quotedstr(tcdatautils.getProduct(ProductID)));
  end else begin
    TitleLabel.caption := 'Product Sales Details' ;
  end;
end;

procedure TProductDetailsGUI.AdjustDisplayLabels;
begin
  QrycF.Connection := CommonDbLib.GetSharedMyDacConnection;
  OpenDb(QrycF);
  if QrycFCFLabel1.asString <> '' then QrymainCustomerCustFLD1.DisplayLabel := QrycFCFLabel1.asString;//else RemoveFieldfromGrid(QrymainCustomerCustFLD1.fieldName);//.visible := QrycFCFCust1.AsBoolean;
  if QrycFCFLabel2.asString <> '' then QrymainCustomerCustFLD2.DisplayLabel := QrycFCFLabel2.asString;//else RemoveFieldfromGrid(QrymainCustomerCustFLD2.fieldName);//.visible := QrycFCFCust2.AsBoolean;
  if QrycFCFLabel3.asString <> '' then QrymainCustomerCustFLD3.DisplayLabel := QrycFCFLabel3.asString;//else RemoveFieldfromGrid(QrymainCustomerCustFLD3.fieldName);//.visible := QrycFCFCust3.AsBoolean;
  if QrycFCFLabel4.asString <> '' then QrymainCustomerCustFLD4.DisplayLabel := QrycFCFLabel4.asString;//else RemoveFieldfromGrid(QrymainCustomerCustFLD4.fieldName);//.visible := QrycFCFCust4.AsBoolean;
  if QrycFCFLabel5.asString <> '' then QrymainCustomerCustFLD5.DisplayLabel := QrycFCFLabel5.asString;//else RemoveFieldfromGrid(QrymainCustomerCustFLD5.fieldName);//.visible := QrycFCFCust5.AsBoolean;
  if QrycFCFLabel6.asString <> '' then QrymainCustomerCustFLD6.DisplayLabel := QrycFCFLabel6.asString;//else RemoveFieldfromGrid(QrymainCustomerCustFLD6.fieldName);//.visible := QrycFCFCust6.AsBoolean;
  if QrycFCFLabel7.asString <> '' then QrymainCustomerCustFLD7.DisplayLabel := QrycFCFLabel7.asString;//else RemoveFieldfromGrid(QrymainCustomerCustFLD7.fieldName);//.visible := QrycFCFCust7.AsBoolean;
  if QrycFCFLabel8.asString <> '' then QrymainCustomerCustFLD8.DisplayLabel := QrycFCFLabel8.asString;//else RemoveFieldfromGrid(QrymainCustomerCustFLD8.fieldName);//.visible := QrycFCFCust8.AsBoolean;
  if QrycFCFLabel9.asString <> '' then QrymainCustomerCustFLD9.DisplayLabel := QrycFCFLabel9.asString;//else RemoveFieldfromGrid(QrymainCustomerCustFLD9.fieldName);//.visible := QrycFCFCust9.AsBoolean;
  if QrycFCFLabel10.asString <> '' then QrymainCustomerCustFLD10.DisplayLabel := QrycFCFLabel10.asString;//else RemoveFieldfromGrid(QrymainCustomerCustFLD10.fieldName);//.visible := QrycFCFCust10.AsBoolean;
  if QrycFCFLabel11.asString <> '' then QrymainCustomerCustFLD11.DisplayLabel := QrycFCFLabel11.asString;//else RemoveFieldfromGrid(QrymainCustomerCustFLD11.fieldName);//.visible := QrycFCFCust11.AsBoolean;
  if QrycFCFLabel12.asString <> '' then QrymainCustomerCustFLD12.DisplayLabel := QrycFCFLabel12.asString;//else RemoveFieldfromGrid(QrymainCustomerCustFLD12.fieldName);//.visible := QrycFCFCust12.AsBoolean;
  if QrycFCFLabel13.asString <> '' then QrymainCustomerCustFLD13.DisplayLabel := QrycFCFLabel13.asString;//else RemoveFieldfromGrid(QrymainCustomerCustFLD13.fieldName);//.visible := QrycFCFCust13.AsBoolean;
  if QrycFCFLabel14.asString <> '' then QrymainCustomerCustFLD14.DisplayLabel := QrycFCFLabel14.asString;//else RemoveFieldfromGrid(QrymainCustomerCustFLD14.fieldName);//.visible := QrycFCFCust14.AsBoolean;
  if QrycFCFLabel15.asString <> '' then QrymainCustomerCustFLD15.DisplayLabel := QrycFCFLabel15.asString;//else RemoveFieldfromGrid(QrymainCustomerCustFLD15.fieldName);//.visible := QrycFCFCust15.AsBoolean;
  if QrycFCFLabel16.asString <> '' then QrymainCustomerCustDATE1.DisplayLabel := QrycFCFLabel16.asString;//else RemoveFieldfromGrid(QrymainCustomerCustDATE1.fieldName);//.visible := QrycFCFCust16.AsBoolean;
  if QrycFCFLabel17.asString <> '' then QrymainCustomerCustDATE2.DisplayLabel := QrycFCFLabel17.asString;//else RemoveFieldfromGrid(QrymainCustomerCustDATE2.fieldName);//.visible := QrycFCFCust17.AsBoolean;
  QrymainFormulaQtyShippedValue1.DisplayLabel:= Appenv.CompanyPrefs.Fe1Name;
  QrymainFormulaQtyShippedValue2.DisplayLabel:= Appenv.CompanyPrefs.Fe2Name;
  QrymainFormulaQtyShippedValue3.DisplayLabel:= Appenv.CompanyPrefs.Fe3Name;
  QrymainFormulaQtyShippedValue4.DisplayLabel:= Appenv.CompanyPrefs.Fe4Name;
  QrymainFormulaQtyShippedValue5.DisplayLabel:= Appenv.CompanyPrefs.Fe5Name;
  inherited;
end;

procedure TProductDetailsGUI.cboClassChange(Sender: TObject);
begin
  inherited;
  TProductDetailsGUI(FindExistingComponent('TProductDetailsGUI')).RefreshQuery;
//  ProductSummaryGUI.RefreshQuery;
end;

procedure TProductDetailsGUI.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  if not fbFormOpenedOk then exit;
  inherited;
  RefreshQuery;
end;

procedure TProductDetailsGUI.chkAllClassClick(Sender: TObject);
begin
  inherited;
  if not fbFormOpenedOk then exit;
  if chkAllClass.Checked = true then begin
    cboClass.Enabled := false;
  end else begin
    cboClass.Enabled := true;
  end;
  RefreshQuery;
end;

procedure TProductDetailsGUI.grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
begin
  // sorting on company is not possible when the form is in detail mode
  // and sorting on the type is not possible when the form is in extra detail mode
  inherited;
end;

procedure TProductDetailsGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  doHideProgressbar;
end;

procedure TProductDetailsGUI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  DoShowProgressbar(2, 'Opening List - ' + WAITMSG);
  DoStepProgressbar;
end;

procedure TProductDetailsGUI.actRefreshQryExecute(Sender: TObject);
begin
  strSelectedFieldData := '';
  inherited;
end;

procedure TProductDetailsGUI.qryMainCalcFields(DataSet: TDataSet);
var
  difference: double;
  Income: double;
begin
  inherited;
  difference := qryMain.FieldByName('GrossProfitTotal').AsFloat - qryMain.FieldByName('Line Cost (Ex)').AsFloat;
  Income := qryMain.FieldByName('GrossProfitTotal').AsFloat;
  qryMain.FieldByName('PercentProfit').AsFloat := DivZer(difference, Income) * 100;
  qryMain.FieldByName('GrossProfit').AsFloat := qryMain.FieldByName('GrossProfitTotal').AsFloat -
    qryMain.FieldByName('Line Cost (Ex)').AsFloat;
end;

procedure TProductDetailsGUI.chkincludemanProductsClick(Sender: TObject);
begin
  if not fbFormOpenedOk then exit;
//  MakeQrymain;
  RefreshQuery;
end;

procedure TProductDetailsGUI.SetFirstcolumn(const Value: String);
begin
  fsFirstcolumn := Value;
  Self.Caption := 'Product Sales of all products of  ' + AppEnv.DefaultClass.FirstColumn +' : ' +  Quotedstr(Value);
end;

procedure TProductDetailsGUI.SetGridColumns;
var
  Qryfenames:TERPQuery;
begin
  inherited;
  RemoveFieldfromGrid('formname');
  RemoveFieldfromGrid('invoiceno');
  RemoveFieldfromGrid('ProductId');
  RemoveFieldfromGrid('Details');
  RemoveFieldfromGrid('SaleLineID');
  RemoveFieldfromGrid('converted');
  RemoveFieldfromGrid('Category');
  RemoveFieldfromGrid('GrossProfitTotal');
  SetUpcustomFields('cust');

  QrycF.Connection := CommonDbLib.GetSharedMyDacConnection;
  OpenDb(QrycF);
  if QrycFCFLabel1.asString <> '' then else RemoveFieldfromGrid(QrymainCustomerCustFLD1.fieldName);
  if QrycFCFLabel2.asString <> '' then else RemoveFieldfromGrid(QrymainCustomerCustFLD2.fieldName);
  if QrycFCFLabel3.asString <> '' then else RemoveFieldfromGrid(QrymainCustomerCustFLD3.fieldName);
  if QrycFCFLabel4.asString <> '' then else RemoveFieldfromGrid(QrymainCustomerCustFLD4.fieldName);
  if QrycFCFLabel5.asString <> '' then else RemoveFieldfromGrid(QrymainCustomerCustFLD5.fieldName);
  if QrycFCFLabel6.asString <> '' then else RemoveFieldfromGrid(QrymainCustomerCustFLD6.fieldName);
  if QrycFCFLabel7.asString <> '' then else RemoveFieldfromGrid(QrymainCustomerCustFLD7.fieldName);
  if QrycFCFLabel8.asString <> '' then else RemoveFieldfromGrid(QrymainCustomerCustFLD8.fieldName);
  if QrycFCFLabel9.asString <> '' then else RemoveFieldfromGrid(QrymainCustomerCustFLD9.fieldName);
  if QrycFCFLabel10.asString <> '' then else RemoveFieldfromGrid(QrymainCustomerCustFLD10.fieldName);
  if QrycFCFLabel11.asString <> '' then else RemoveFieldfromGrid(QrymainCustomerCustFLD11.fieldName);
  if QrycFCFLabel12.asString <> '' then else RemoveFieldfromGrid(QrymainCustomerCustFLD12.fieldName);
  if QrycFCFLabel13.asString <> '' then else RemoveFieldfromGrid(QrymainCustomerCustFLD13.fieldName);
  if QrycFCFLabel14.asString <> '' then else RemoveFieldfromGrid(QrymainCustomerCustFLD14.fieldName);
  if QrycFCFLabel15.asString <> '' then else RemoveFieldfromGrid(QrymainCustomerCustFLD15.fieldName);
  if QrycFCFLabel16.asString <> '' then else RemoveFieldfromGrid(QrymainCustomerCustDATE1.fieldName);
  if QrycFCFLabel17.asString <> '' then else RemoveFieldfromGrid(QrymainCustomerCustDATE2.fieldName);
  Qryfenames := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    closedb(Qryfenames);
    Qryfenames.SQL.Text := 'select * from tblfenames';
    OpenDb(Qryfenames);
    if Qryfenames.recordcount <1 then begin
      RemoveFieldfromGrid(QrymainFormulaQtyShippedValue1.fieldName);
      RemoveFieldfromGrid(QrymainPartCalcformula.fieldName);
      RemoveFieldfromGrid(Qrymainformula.fieldName);
      RemoveFieldfromGrid(QrymainformulaDetails.fieldName);
      RemoveFieldfromGrid(qrymainFormulaQtyShippedValue.fieldName);
    end;
    if Qryfenames.recordcount < 2 then RemoveFieldfromGrid(QrymainFormulaQtyShippedValue2.fieldName);
    if Qryfenames.recordcount < 3 then RemoveFieldfromGrid(QrymainFormulaQtyShippedValue3.fieldName);
    if Qryfenames.recordcount < 4 then RemoveFieldfromGrid(QrymainFormulaQtyShippedValue4.fieldName);
    if Qryfenames.recordcount < 5 then RemoveFieldfromGrid(QrymainFormulaQtyShippedValue5.fieldName);
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(Qryfenames);
  end;

end;

procedure TProductDetailsGUI.SetProductID(const Value: Integer);
begin
  fiProductId := Value;
  Self.Caption := 'Product Sales : ' + tcdatautils.getProduct(Value);
end;

procedure TProductDetailsGUI.SetSecondcolumn(const Value: String);
begin
  fsSecondcolumn := Value;
  Self.Caption := 'Product Sales of all products of  ' + AppEnv.DefaultClass.SecondColumn +' : ' +  Quotedstr(Value);
end;

procedure TProductDetailsGUI.SetThirdcolumn(const Value: String);
begin
  fsThirdcolumn := Value;
  Self.Caption := 'Product Sales of all products of  ' + AppEnv.DefaultClass.ThirdColumn +' : ' +  Quotedstr(Value);
end;

procedure TProductDetailsGUI.setClassId(const Value: Integer);
begin
  fiClassId := Value;
  if Value = 0 then begin
    chkAllClass.checked := True;
  end else begin
    if cboClassQry.active = False then cboClassQry.Open;
    if cboClassQry.Locate('ClassId' , Value , []) then begin
      chkAllClass.checked := False;
      cboClass.text := cboClassQry.fieldbyname('Classname').asString;
      cboClass.enabled := true;
      cboClass.LookupValue:=cboClassQry.fieldbyname('ClassID').asString;
    end;
  end;
end;

procedure TProductDetailsGUI.setDashboardDetail(const Value: Boolean);
begin
  inherited;
  if Value then begin
    chkincludemanProducts.checked := false;
    grdMainTitleButtonClick(grdMain, 'Total Amount (Ex)');
    qryMain.First;
  end;
end;


procedure TProductDetailsGUI.chkIgnoreDatesClick(Sender: TObject);
begin
  if not fbFormOpenedOk then exit;
  inherited;
end;

procedure TProductDetailsGUI.cboDateRangeCloseUp(Sender: TObject);
begin
  if not fbFormOpenedOk then exit;
  inherited;
end;

initialization
  RegisterClassOnce(TProductDetailsGUI);
end.
