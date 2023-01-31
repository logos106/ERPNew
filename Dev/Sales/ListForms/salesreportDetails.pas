unit salesreportDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel, ReportSQLsalesreportDetails, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TsalesreportDetailsGUI = class(TBaseListingGUI)
    qryMainSaleType: TWideStringField;
    qryMainDocNumber: TWideStringField;
    qryMainDepartment: TWideStringField;
    qryMainProduct_Description: TWideStringField;
    qryMainTotalLineAmountInc: TFloatField;
    qryMainTotalLineAmount: TFloatField;
    qryMainTotalAmount: TFloatField;
    qryMainSaleDate: TDateField;
    qryMainSaleLineId: TIntegerField;
    qryMainTimeOfSale: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainShipTo: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainMemo: TWideMemoField;
    qryMainComments: TWideMemoField;
    qryMainOriginalNo: TWideStringField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainPONumber: TWideStringField;
    qryMainTotalAmountEx: TFloatField;
    qryMainTotalTax: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    qryMainEmployeeName: TWideStringField;
    qryMainConsignmentNote: TWideStringField;
    qryMainClassName: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainProductDescription: TWideStringField;
    qryMainItemPriceEx: TFloatField;
    qryMainItemPriceInc: TFloatField;
    qryMainItemCostEx: TFloatField;
    qryMainLineCostInc: TFloatField;
    qryMainLineCostEx: TFloatField;
    qryMainTaxCode: TWideStringField;
    qryMainLineTax: TFloatField;
    qryMainShipped: TFloatField;
    qryMainLineTotalEx: TFloatField;
    qryMainLineTotalInc: TFloatField;
    qryMainDeleted: TWideStringField;
    qryMainEmployeeID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainSaleID: TIntegerField;
    qryMainRunName: TWideStringField;
    qryMainProductID: TIntegerField;
    qryMainAttrib1Sale: TFloatField;
    qryMainAttrib2Sale: TFloatField;
    qryMainAttrib1SaleRate: TFloatField;
    qryMainUnitOfMeasureSaleLines: TWideStringField;
    qryMainUnitOfMeasureShipped: TFloatField;
    qryMainClassID: TIntegerField;
    qryMainTill: TWideStringField;
    qryMainArea: TWideStringField;
    qryMainShipDate: TDateField;
    qryMainPOSSource: TWideStringField;
    qryMainWarrantyEndsOn: TDateField;
    qryMainWarrantyPeriod: TWideStringField;
    qryMainPOSPostCode: TWideStringField;
    qryMainLineShipDate: TDateTimeField;
    qryMainDiscountPercent: TFloatField;
    qryMainDiscounts: TFloatField;
    qryMainMarkup: TFloatField;
    qryMainMarkupPercent: TFloatField;
    qryMainCustomerType: TWideStringField;
    qryMainProductFld7: TWideStringField;
    qryMainSalesReferenceNo: TWideStringField;
    qryMainLinesReferenceNo: TWideStringField;
    qryMainTotalProductFld7: TFloatField;
    grpcustomfields: TwwRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);override;
    procedure grpFiltersClick(Sender: TObject);override;
    procedure FormDestroy(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure grpcustomfieldsChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    ReportSQLobj :TReportSQLsalesreportDetails;
    fField7Caption :String;
    procedure setISOnlyPOS(const Value: Boolean);
    procedure setDateFrom(const Value: TDateTime);
    procedure setDateto(const Value: TdateTime);
    Procedure initformAftershow(Sender:TObject);
    Procedure MakeQrymain;
    procedure Populategrpcustomfields;
  Protected
    Procedure RefreshTotals;override;
    function GetReportTypeID: integer; override;
    Function DoEmailIfToBeEmailed:boolean;override;
    procedure SetGridColumns; Override;
    procedure OnSetUpcustomFields(CustfieldVisible:Boolean;fieldno :Integer;  FlagFieldname , fieldname, DisplayLabel:String );Override;
    procedure Extrafields;Virtual;
    procedure ExtraTables;Virtual;

  public
    Procedure RefreshQuery; override;
    Property  ISOnlyPOS :Boolean write setISOnlyPOS;
    Property DateFrom :TDateTime write setDateFrom;
    Property Dateto :TdateTime Write setDateto;
  end;


implementation

uses CommonLib, AppEnvironment, CommonFormLib, BusObjProcPrefs ;

{$R *.dfm}

{ TSalesReporDEtailsGUI }

procedure TsalesreportDetailsGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    ReportSQLSupplied   := true;
    UseStringListForSQL := False;
    try
      ReportSQLobj.Datefrom := dtFrom.Datetime;
      ReportSQLobj.dateTo := DtTo.Datetime;
      ReportSQLobj.ISOnlyPOS := grpFilters.ItemIndex =0;
      TemplateSQL :=  ReportSQLobj.TemplateSQL;
      inherited;
    finally
      ReportSQLSupplied   := false;
      UseStringListForSQL := false;
    end;
  finally
    EnableForm;
  end;

end;

function TsalesreportDetailsGUI.DoEmailIfToBeEmailed: boolean;
begin
  DisableForm;
  try
    ReportSQLSupplied   := true;
    UseStringListForSQL := False;
    try
      ReportSQLobj.Datefrom := dtFrom.Datetime;
      ReportSQLobj.dateTo := DtTo.Datetime;
      ReportSQLobj.ISOnlyPOS := grpFilters.ItemIndex =0;
      TemplateSQL :=  ReportSQLobj.TemplateSQL;
      result:= inherited DoEmailIfToBeEmailed;
    finally
      ReportSQLSupplied   := false;
      UseStringListForSQL := false;
    end;
  finally
    EnableForm;
  end;

end;
procedure TsalesreportDetailsGUI.OnSetUpcustomFields(CustfieldVisible: Boolean;fieldno: Integer; FlagFieldname, fieldname, DisplayLabel: String);
begin
  inherited;
  if fieldno = 7 then
    if ProcPrefs.UseFld7AsSteelWeight then begin
      fField7Caption :=   DisplayLabel;
    end else begin
      fField7Caption :=   '';
    end;

end;

procedure TsalesreportDetailsGUI.FormCreate(Sender: TObject);
begin
  MakeQrymain;
  ReportSQLobj := TReportSQLsalesreportDetails.Create(Self);
  ReportSQLobj.employeeID := Appenv.Employee.EmployeeID;
  inherited;
  populategrpcustomfields;
  AddCalcColumn(QrymainTotalLineAmountInc.FieldName, true);
  AddCalcColumn(QrymainTotalLineAmount.FieldName, true);
end;
Procedure TsalesreportDetailsGUI.Populategrpcustomfields;
begin
grpcustomfields.items.clear;
grpcustomfields.items.add('With Product'+chr(13)+'Custom Fields');
grpcustomfields.items.add('With Sales'+chr(13)+'Custom Fields');
grpcustomfields.items.add('With Customer'+chr(13)+'Custom Fields');
grpcustomfields.items.add('Without Any'+chr(13)+'Custom Fields');

end;
procedure TsalesreportDetailsGUI.FormDestroy(Sender: TObject);
begin
  FreeAndNil(ReportSQLobj);
  inherited;
end;

procedure TsalesreportDetailsGUI.FormShow(Sender: TObject);
begin
  inherited;
           if self.ClassNameIs( 'TSalesReportDetailsProductcustomFieldListGUI'    ) then grpcustomfields.itemindex :=0
      else if self.ClassNameIs( 'TSalesReportDetailsSaleslinescustomFieldListGUI' ) then grpcustomfields.itemindex :=1
      else if self.ClassNameIs( 'TSalesReportDetailsCustomercustomFieldListGUI'   ) then grpcustomfields.itemindex :=2
      else if self.ClassNameIs( 'TsalesreportDetailsGUI'                          ) then grpcustomfields.itemindex :=3;
end;

function TsalesreportDetailsGUI.GetReportTypeID: integer;
begin
  Result := ReportSQLobj.ReportTypeID ;
end;

procedure TsalesreportDetailsGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMainSaleType.AsString;
  inherited;
end;

procedure TsalesreportDetailsGUI.grpFiltersClick(Sender: TObject);
begin
  inherited;
  if isformshown then RefreshQuery;
end;

procedure TsalesreportDetailsGUI.MakeQrymain;
begin
  CloseDb(Qrymain);
  Qrymain.SQL.clear;
  Qrymain.SQL.add('SELECT');
  Qrymain.SQL.add('if(s.IsPOS = "T", "POS", if(s.IsCashSale = "T" ,  "Cash Sale", if(s.IsInvoice = "T" , "Invoice" ,"")))  as "SaleType",');
  Qrymain.SQL.add('s.InvoiceDocNumber   as DocNumber,');
  Qrymain.SQL.add('s.Class            as Department,');
  Qrymain.SQL.add('sl.Product_Description  as Product_Description,');
  Qrymain.SQL.add('sl.TotalLineAmountInc as TotalLineAmountInc,');
  Qrymain.SQL.add('SL.TotalLineAmount as TotalLineAmount,');
  Qrymain.SQL.add('S.TotalAmount as TotalAmount,');
  Qrymain.SQL.add('CT.TypeName as CustomerType,');
  Qrymain.SQL.add('S.SaleDate as SaleDate,');
  Qrymain.SQL.add('SL.SaleLineId as SaleLineId,');
  Qrymain.SQL.add('S.TimeOfSale as TimeOfSale,');
  Qrymain.SQL.add('S.CustomerName as CustomerName,');
  Qrymain.SQL.add('Replace(S.ShipTo,"\r\n"," ") as ShipTo,');
  Qrymain.SQL.add('S.GlobalRef as GlobalRef,');
  Qrymain.SQL.add('Memo as Memo,');
  Qrymain.SQL.add('Comments as Comments,');
  Qrymain.SQL.add('S.OriginalNo as OriginalNo,');
  Qrymain.SQL.add('S.InvoiceDocNumber as InvoiceNumber ,');
  Qrymain.SQL.add('S.PONumber as PONumber,');
  Qrymain.SQL.add('S.TotalAmount as TotalAmountEx,');
  Qrymain.SQL.add('S.TotalTax as TotalTax,');
  Qrymain.SQL.add('S.TotalAmountInc as TotalAmountInc,');
  Qrymain.SQL.add('S.EmployeeName AS EmployeeName,');
  Qrymain.SQL.add('S.ConNote as ConsignmentNote,');
  Qrymain.SQL.add('S.Class as ClassName,');
  Qrymain.SQL.add('SL.ProductName as ProductName,');
  Qrymain.SQL.add('SL.Product_Description as ProductDescription,');
  Qrymain.SQL.add('SL.LinePrice as ItemPriceEx,');
  Qrymain.SQL.add('SL.LinePriceInc as ItemPriceInc,');
  Qrymain.SQL.add('SL.LineCost as ItemCostEx,');
  Qrymain.SQL.add('Round(SL.LineCostInc*SL.Shipped,5) as LineCostInc,');
  Qrymain.SQL.add('Round(SL.LineCost*SL.Shipped,5) as LineCostEx,');
  Qrymain.SQL.add('SL.LineTaxCode as TaxCode,');
  Qrymain.SQL.add('SL.LineTax as LineTax,');
  Qrymain.SQL.add('SL.Shipped as Shipped,');
  Qrymain.SQL.add('SL.TotalLineAmount as LineTotalEx,');
  Qrymain.SQL.add('SL.TotalLineAmountInc as LineTotalInc,');
  Qrymain.SQL.add('S.Deleted as Deleted,');
  Qrymain.SQL.add('S.EmployeeID as EmployeeID,');
  Qrymain.SQL.add('S.ClientID as ClientID,');
  Qrymain.SQL.add('S.SaleID as SaleID,');
  Qrymain.SQL.add('S.RunName as RunName,');
  Qrymain.SQL.add('SL.ProductID as ProductID,');
  Qrymain.SQL.add('SL.Attrib1Sale as Attrib1Sale,');
  Qrymain.SQL.add('SL.Attrib2Sale as Attrib2Sale,');
  Qrymain.SQL.add('SL.Attrib1SaleRate as Attrib1SaleRate,');
  Qrymain.SQL.add('SL.UnitOfMeasureSaleLines as UnitOfMeasureSaleLines,');
  Qrymain.SQL.add('SL.UnitOfMeasureShipped as UnitOfMeasureShipped,');
  Qrymain.SQL.add('S.ClassID as ClassID,');
  Qrymain.SQL.add('tblPosTills.TillName as Till,');
  Qrymain.SQL.add('SL.Area as Area,');
  Qrymain.SQL.add('S.ShipDate as ShipDate,');
  Qrymain.SQL.add('S.Medtype as POSSource,');
  Qrymain.SQL.add('SL.WarrantyEndsOn as WarrantyEndsOn ,');
  Qrymain.SQL.add('SL.WarrantyPeriod as WarrantyPeriod, S.POSPostCode,');
  Qrymain.SQL.add('SL.ShipDate as LineShipDate,');
  Qrymain.SQL.add('SL.DiscountPercent,SL.Discounts,');
  Qrymain.SQL.add('SL.Markup,SL.MarkupPercent,');
  Qrymain.SQL.add('S.ReferenceNo as SalesReferenceNo,');
  Qrymain.SQL.add('SL.ReferenceNo as LinesReferenceNo,');
  Extrafields;
  if ProcPrefs.UseFld7AsSteelWeight then qryMain.SQL.Add('P.CUSTFLD7 AS ProductFld7, (cast(P.Custfld7 as unsigned) * SL.UnitofMeasureShipped) as TotalProductFld7')
  else qryMain.SQL.Add('null as ProductFld7, 0.0 as TotalProductFld7');
  Qrymain.SQL.add('FROM tblSales S');
  Qrymain.SQL.add('inner join tblclients C   on s.clientID = C.clientID');
  Qrymain.SQL.add('left join tblclienttype CT on C.ClientTypeID = CT.ClientTypeID');
  Qrymain.SQL.add('INNER JOIN tblSalesLines sl USING(SaleId)');
  if ProcPrefs.UseFld7AsSteelWeight then Qrymain.SQL.add('INNER JOIN tblparts P on P.partsId = SL.productId');
  Qrymain.SQL.add('left join tblPosTills on tblPosTills.TillId = S.TillId');
  ExtraTables;
  Qrymain.SQL.add('WHERE S.Cancelled = "F" and S.Deleted ="F"');
  Qrymain.SQL.add('AND ((:ISOnlyPOS ="T" and  s.IsPos = "T") or ((:ISOnlyPOS ="F" and (s.IsPos = "T" OR s.IsCashSAle = "T" OR s.IsInvoice = "T"))))');
  Qrymain.SQL.add('AND s.SaleDateTime >= :DateFrom');
  Qrymain.SQL.add('AND s.SaleDateTime < :Dateto');
  Qrymain.SQL.add('ORDER BY s.SaleDateTime, SAleID, Productname');

end;

procedure TsalesreportDetailsGUI.RefreshQuery;
begin
  ReportSQLobj.Datefrom := FilterDatefrom;
  ReportSQLobj.dateTo := filterdateTo;
  ReportSQLobj.ISOnlyPOS := grpFilters.ItemIndex =0;
  InitDateFromnDateto;
  if grpFilters.ItemIndex =0 then   Qrymain.PArambyname('ISOnlyPOS').asString := 'T' else   Qrymain.PArambyname('ISOnlyPOS').asString := 'F';
  inherited;
  qryMainProductFld7.DisplayLabel := fField7Caption;
  qryMainTotalProductFld7.DisplayLabel := 'Total ' + fField7Caption;
end;

procedure TsalesreportDetailsGUI.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;

procedure TsalesreportDetailsGUI.setDateFrom(const Value: TDateTime);
begin
  Dtfrom.Datetime := Value;
end;

procedure TsalesreportDetailsGUI.setDateto(const Value: TdateTime);
begin
  Dtto.DateTime := Value;
end;

procedure TsalesreportDetailsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymaindeleted.fieldname);
  RemoveFieldfromGrid(qrymainEmployeeID.fieldname);
  RemoveFieldfromGrid(qrymainClientID.fieldname);
  RemoveFieldfromGrid(qrymainProductID.fieldname);
  RemoveFieldfromGrid(qrymainclassId.fieldname);
  RemoveFieldfromGrid(qryMainSALELINEID.fieldname);
  RemoveFieldfromGrid(qryMainSHIPPED.fieldname);
  SetUpcustomFields('Product');
end;

procedure TsalesreportDetailsGUI.setISOnlyPOS(const Value: Boolean);
begin
  if Value then grpfilters.Itemindex := 0 else grpfilters.Itemindex := 1;
end;
procedure TsalesreportDetailsGUI.grpcustomfieldsChange(Sender: TObject);
var
  fs:String;
begin
  inherited;
  if (Assigned(screen.activecontrol.owner)) and (screen.activecontrol.owner =  grpcustomfields) then else exit;

       if (grpcustomfields.itemindex =0) then  fs:= 'TSalesReportDetailsProductcustomFieldListGUI'
  else if (grpcustomfields.itemindex =1) then  fs:= 'TSalesReportDetailsSaleslinescustomFieldListGUI'
  else if (grpcustomfields.itemindex =2) then  fs:= 'TSalesReportDetailsCustomercustomFieldListGUI'
  else if (grpcustomfields.itemindex =3) then  fs:= 'TsalesreportDetailsGUI'
  else exit;

  if not sametext(self.classname, fs) then begin
    OpenERPListForm(fs ,CopyParamsto, initformAftershow);
    Self.close;
  end;
end;

procedure TsalesreportDetailsGUI.initformAftershow(Sender: TObject);
begin
  try
    if not(Sender is TsalesreportDetailsGUI) then exit;
    TsalesreportDetailsGUI(Sender).Qrymain.Locate(QrymainsalelineID.FieldName , QrymainsalelineID.AsInteger, []);

  Except
  end;
end;
procedure TsalesreportDetailsGUI.Extrafields;begin  end;
procedure TsalesreportDetailsGUI.ExtraTables;begin end;

initialization
  RegisterClassOnce(TsalesreportDetailsGUI);

end.

