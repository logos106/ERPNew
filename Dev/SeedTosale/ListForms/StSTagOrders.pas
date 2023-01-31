unit StSTagOrders;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, GIFImg, DNMPanel;

type
  TStSTagOrdersGUI = class(TBaseListingGUI)
    qryMainSupplierName: TWideStringField;
    qryMainProductname: TWideStringField;
    qryMainlineNotes: TWideMemoField;
    qryMainQtysold: TFloatField;
    qryMainQtyshipped: TFloatField;
    qryMainbackorder: TFloatField;
    qryMainUnitofMeasurePOLines: TWideStringField;
    qryMainPurchaseLineID: TIntegerField;
    qryMainOrderDate: TDateField;
    qryMainEmployeeName: TWideStringField;
    qryMainProductID: TIntegerField;
    qryMainComments: TWideStringField;
    qryMainLineCost: TFloatField;
    qryMainEstimatedCost: TFloatField;
    qryMainETADate: TDateField;
    qryMainPurchaseOrderID: TIntegerField;
    qryMainClass: TWideStringField;
    qryMainApproved: TWideStringField;
    qryMainConNote: TWideStringField;
    qryMainOrderStatus: TWideStringField;
    qryMainSmartOrderId: TIntegerField;
    qryMainFuturePo: TWideStringField;
    qryMainLeadDays: TLargeintField;
    qryMainOrderLineCustomField1: TWideStringField;
    qryMainOrderLineCustomField2: TWideStringField;
    qryMainOrderLineCustomField3: TWideStringField;
    qryMainOrderLineCustomField4: TWideStringField;
    qryMainOrderLineCustomField5: TWideStringField;
    qryMainOrderLineCustomField6: TWideStringField;
    qryMainOrderLineCustomField7: TWideStringField;
    qryMainOrderLineCustomField8: TWideStringField;
    qryMainOrderLineCustomField9: TWideStringField;
    qryMainOrderLineCustomField10: TWideStringField;
    qryMainMemoLine: TWideMemoField;
    qryMainPONum: TWideStringField;
    btnPrintBarCode: TDNMSpeedButton;
    qryMainSNCount: TLargeintField;
    procedure btnPrintBarCodeClick(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
  private
    procedure MakeaStSOrder(Sender: TObject);
    { Private declarations }
  Protected
    procedure SetGridColumns; Override;
    function GetReportTypeID: integer; Override;
  public
    Procedure RefreshQuery; Override;
  end;


implementation

uses AppEnvironment, CommonLib, Busobjcustomfields, TemplateReportsLib,
  Barcodeconst, LogLib, ProductQtyLib, BusobjTemplateOptions, CommonFormLib,
  frmPurchaseOrders;

{$R *.dfm}

{ TStSTagOrdersGUI }

procedure TStSTagOrdersGUI.btnPrintBarCodeClick(Sender: TObject);
begin
  inherited;
  if qryMainQtyshipped.AsFloat =0 then Exit;
  if qryMainSNCount.asinteger =0 then begin
    MessageDlgXP_vista('Serail Numbers are not Assigned.', mtWarning, [mbOK], 0);
    Exit;
  end;
  if ReportName = '' then exit;

  TemplateSQL := companyInfoSQL +
            ' ~|||~{Details}SELECT    P.GlobalRef,P.PARTSID,P.PARTTYPE,P.PRODUCTGROUP,P.PARTNAME, '+
            ' P.PURCHASEDESC,P.INCOMEACCNT,P.ASSETACCNT,P.COGSACCNT,P.BARCODE,P.PRODUCTCODE,   '+
            ' P.TAXCODE,P.PURCHTAXCODE,P.PREFEREDSUPP,P.SpecialDiscount,P.SNTracking,  P.MultipleBins,P.batch, '+
            ' P.AutoBatch,P.AutoReorder,P.BuyQTY1,P.BuyQTY2,  P.BuyQTY3,P.COST1,P.COST2,P.COST3,P.AvgCost, '+
            ' P.SellQTY1,P.SellQTY2,  P.SellQTY3,P.PRICE1,P.PRICE2,P.PRICE3,P.WHOLESALEPRICE,P.Active,  P.productcomment, '+
            ' PRICE1 + TC.Rate* P.PRICE1 as priceinc1,    '+
            ' PRICE2 + TC.Rate* P.PRICE2 as priceinc2,     '+
            ' PRICE3 + TC.Rate* P.PRICE3 as priceinc3,   '+
            ' ((P.PRICE1 + TC.Rate* P.PRICE1 )*1.5) as retail1,   '+
            ' ((P.PRICE2 + TC.Rate* P.PRICE2 )*1.5) as retail2,   '+
            ' ((P.PRICE3 + TC.Rate* P.PRICE3 )*1.5) as retail3    , '+
            ' concat(PL.UnitofMeasurePOLines, " (" , PL.UnitofMeasureMultiplier, " )" ) as UOM,  '+
            ' P.partname as Productname,  '+
            Firstcolumn +' as Productcolumn1, '+
            Secondcolumn +' as Productcolumn2, '+
            Thirdcolumn +' as Productcolumn3,  '+
            ' P.PARTSDESCRIPTION as PartsDescription,  '+
            ' C.Classname as Classname , PQABatch.Value batchnumber,PQABatch.TruckLoadNo,PQABatch.ExpiryDate as BatchExpiryDate, PBin.binlocation,  '+
            ' PBin.binnumber, PQASN.Value as Serialnumber, P.description, PQA.Alloctype , ' +
            'concat(' +Quotedstr(Barcode_Prefix_PQASN)+',''-'' ,PQA.ProductID,''-'' ,PQASN.Value) as BOMSerialnumber  '+
            ' FROM tblPurchaseLines PL ' +
            ' INNER JOIN tblPurchaseOrders PO ON PO.PurchaseOrderID=PL.PurchaseOrderID ' +
            TransTables(tDetailswithSno , 'PL' , 'PurchaseOrderID' , 'PurchaselineId' , POTranstypes)+
            ' Inner Join tbltaxcodes TC ON PL.LineTaxCode = TC.Name    and TC.regionID =  '+ inttostr(AppEnv.RegionalOptions.ID) + ' ' +
            'inner join tblclass C on C.classId = PL.classid '+
            ' WHERE PL.purchaselineId = ' + inttostr(qrymainpurchaselineId.asInteger);
  try
    clog(TemplateSQL);
    PrintTemplate.ReportSQLSupplied := TRue;
    PrintTemplate.PrintTemplateReport(ReportName, TemplateSQL, not(devmode) and not (AppEnv.Employee.ShowPreview), 1 );
  finally
    TemplateSQL := '';
  end;
end;

procedure TStSTagOrdersGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  OpenERPForm('TPurchaseGUI' , 0, MakeaStSOrder);
end;
procedure TStSTagOrdersGUI.MakeaStSOrder(Sender: TObject);
begin
  if sender is TPurchaseGUI then
    TPurchaseGUI(Sender).MakeaStSOrder;
end;

function TStSTagOrdersGUI.GetReportTypeID: integer;
begin
  REsult := TtemplateType.Serial_Number_Barcode;
end;

procedure TStSTagOrdersGUI.RefreshQuery;
begin
  InitDateFromnDateto('txtfrom' , 'txtto');
  qrymain.parambyname('StSPackageTagProduct').asString:= Appenv.companyprefs.StSPackageTagProduct;
  qrymain.parambyname('StSPlantTagProduct').asString:= Appenv.companyprefs.StSPlantTagProduct;
  inherited;
end;


procedure TStSTagOrdersGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainPurchaseLineID.fieldname);
  RemoveFieldfromGrid(qryMainProductID.fieldname);
  RemoveFieldfromGrid(qryMainSmartOrderId.fieldname);
  RemoveFieldfromGrid(qryMainSNCount.fieldname);
  SetUpcustomFields(
    'OrderLineCustomField1,' +
    'OrderLineCustomField2,' +
    'OrderLineCustomField3,' +
    'OrderLineCustomField4,' +
    'OrderLineCustomField5,' +
    'OrderLineCustomField6,' +
    'OrderLineCustomField7,' +
    'OrderLineCustomField8,' +
    'OrderLineCustomField9,' +
    'OrderLineCustomField10', ltOrderLines);
end;

Initialization
  RegisterClassOnce(TStSTagOrdersGUI);
end.
