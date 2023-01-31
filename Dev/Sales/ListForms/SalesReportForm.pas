unit SalesReportForm;

{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 07/06/05  1.00.01 IJB  Changed anchors of chkBasedOnShipped and its label for
                        correct positioning when form maximised.
 18/07/05  1.00.02 BJ   Warranty ends on and Warranty period fields are added to
                        this report. The caption of the field is changed based
                        on the preference.
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  Mask, wwdbedit, DBCtrls, wwDialog, Wwlocate,
  SelectionDialog, DNMPanel, Math, MemDS, DBAccess, MyAccess,ERPdbComponents, wwdblook,
  wwcheckbox, wwdbdatetimepicker,  Shader,
  kbmMemTable, ProgressDialog, DAScript, MyScript, CustomInputBox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TSalesReportGUI = class(TBaseListingGUI)
    chkBaseOnShipped: TCheckBox;
    Label46: TLabel;
    qryMainID: TIntegerField;
    qryMainSALELINEID: TIntegerField;
    qryMainSALEID: TIntegerField;
    qryMainPRODUCTID: TIntegerField;
    qryMainEMPLOYEEID: TIntegerField;
    qryMainCLIENTID: TIntegerField;
    qryMainCLASSID: TIntegerField;
    qryMainDueDate: TDateField;
    qryMainTIMEOFSALE: TWideStringField;
    qryMainTRANSACTIONTYPE: TWideStringField;
    qryMainCUSTOMERNAME: TWideStringField;
    qryMainSalesReferenceNo: TWideStringField;
    qryMainShipTo: TWideStringField;
    qryMainGLOBALREF: TWideStringField;
    qryMainCUSTOMERTYPE: TWideStringField;
    qryMainMEMO: TWideMemoField;
    qryMainCOMMENTS: TWideMemoField;
    qryMainORIGINALNO: TWideStringField;
    qryMainINVOICENUMBER: TWideStringField;
    qryMainPONUMBER: TWideStringField;
    qryMainTOTALAMOUNTEX: TFloatField;
    qryMainTOTALTAX: TFloatField;
    qryMainTOTALAMOUNTINC: TFloatField;
    qryMainEMPLOYEENAME: TWideStringField;
    qryMainCONSIGNMENTNOTE: TWideStringField;
    qryMainCLASSNAME: TWideStringField;
    qryMainPRODUCTTYPE: TWideStringField;
    qryMainMANUFACTURER: TWideStringField;
    qryMainTYPE: TWideStringField;
    qryMainDEPARTMENT: TWideStringField;
    qryMainPRODUCTNAME: TWideStringField;
    qryMainLinesReferenceNo: TWideStringField;
    qryMainPRODUCTDESCRIPTION: TWideStringField;
    qryMainITEMPRICEEX: TFloatField;
    qryMainITEMPRICEINC: TFloatField;
    qryMainITEMCOSTEX: TFloatField;
    qryMainLINECOSTINC: TFloatField;
    qryMainLINECOSTEX: TFloatField;
    qryMainTAXCODE: TWideStringField;
    qryMainLINETAX: TFloatField;
    qryMainSHIPPED: TFloatField;
    qryMainLINETOTALEX: TFloatField;
    qryMainLINETOTALINC: TFloatField;
    qryMainPREFEREDSUPPLIER: TWideStringField;
    QrymainSupplierProductCode: TWideStringField;
    qryMainDELETED: TWideStringField;
    qryMainUNITOFMEASURESALELINES: TWideStringField;
    qryMainUNITOFMEASURESHIPPED: TFloatField;
    qryMainTILL: TWideStringField;
    qryMainAREA: TWideStringField;
    qryMainSHIPDATE: TDateField;
    qryMainSOURCE: TWideStringField;
    qryMainPOSSOURCE: TWideStringField;
    qryMainWARRANTYENDSON: TDateField;
    qryMainWARRANTYPERIOD: TWideStringField;
    qryMainGROSSPROFIT: TFloatField;
    qryMainPERCENTPROFIT: TFloatField;
    qryMainPOSPOSTCODE: TWideStringField;
    qryMainLINESHIPDATE: TDateTimeField;
    qryMainDISCOUNTPERCENT: TFloatField;
    qryMainDISCOUNTS: TFloatField;
    qryMainMARKUP: TFloatField;
    qryMainMARKUPPERCENTAGE: TFloatField;
    qryMainRUNNAME: TWideStringField;
    qryMainATTRIB1SALERATE: TFloatField;
    qryMainATTRIB1SALE: TFloatField;
    qryMainATTRIB2SALE: TFloatField;
    btnProductList: TDNMSpeedButton;
    popCustomFields: TPopupMenu;
    Product1: TMenuItem;
    salesLines1: TMenuItem;
    Customer1: TMenuItem;
    mnuNone: TMenuItem;
    qryMainProductPrintName: TWideStringField;

    procedure grpFiltersClick(Sender: TObject);Override;
    procedure grdMainDblClick(Sender: TObject);Override; 
    procedure FormShow(Sender: TObject);
    procedure grdMainColEnter(Sender: TObject);
    procedure HeaderPanelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure FooterPanelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
    procedure FormCreate(Sender: TObject);
    procedure chkBaseOnShippedClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MyScriptError(Sender: TObject; E: Exception; SQL: String; var Action: TErrorAction);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
    procedure btnProductListClick(Sender: TObject);
    procedure Product1Click(Sender: TObject);
    procedure salesLines1Click(Sender: TObject);
    procedure Customer1Click(Sender: TObject);
    procedure mnuNoneClick(Sender: TObject);
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    procedure SetupFormInPanel; override;
    Procedure SetGridColumns; override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  private
    fiProductID: Integer;
    grdmainhint:String;
    procedure MakeQry;
    Procedure initform(Sender:TObject);
    Procedure initformAftershow(Sender:TObject);
    procedure CreateTemporaryTable;
  Protected
    fsTablename :String;
    Function Extrafields:String;Virtual;
    Function SaleLinescustomfields(Const Tablealias:String) :String;Virtual;
    Function ProductcustomFields(Const Tablealias:String)  :String;Virtual;
    Function CustomercustomFields(Const Tablealias:String)  :String;Virtual;
    function Customfields:String;virtual;
    Function TablenameSufix:String;virtual;
//    procedure initqrymainsql;Override;
  public
    Property ProductID:Integer read fiProductID write fiProductID;
  end;

implementation

uses
    CommonDbLib, DNMLib, Forms, tcConst,
  AppEnvironment, CommonLib, MySQLConst, FastFuncs, tcDataUtils, ProductQtyLib,
  CommonFormLib, TempTableUtils, ERPErrorEmailUtils, SystemLib;

{$R *.dfm}

procedure TSalesReportGUI.grpFiltersClick(Sender: TObject);
begin
  GroupFilterString := '';
  case grpFilters.ItemIndex of
    0:GroupFilterString := 'Deleted <> ' + QuotedStr('T');
    1:GroupFilterString := 'Deleted = ' + QuotedStr('T');
  end;
  inherited;
end;

procedure TSalesReportGUI.RefreshQuery;
begin
  Disableform;
  try
    if not Searching then
      MakeQry;
    inherited;
    Qrymain.fieldbyname('PreferedSupplier').DisplayLabel:= 'Preferred Supplier';
    Qrymain.fieldbyname('SupplierProductCode').DisplayLabel:= 'Supplier Product code';
    QrymainDiscounts.DisplayLabel := 'Discount ' + appenv.RegionalOptions.CurrencySymbol;
    QrymainMarkup.DisplayLabel := 'Markup ' + appenv.RegionalOptions.CurrencySymbol;
    QrymainMarkupPercentage.DisplayLabel := 'Markup %' ;
    QrymainDiscountPercent.DisplayLabel := 'Discount %' ;
    PopulateFilterCombo;
    cboFilter.ItemIndex := 0;
  finally
    Enableform;
  end;
end;

procedure TSalesReportGUI.grdMainDblClick(Sender: TObject);
var
  Col: integer;
  FieldName: string;
begin
  { when double clicking on grid:
    allow qualification of row type depending on content of field 'Transaction Type'
  }
  SubsequentID := Chr(95) + Qrymain.FieldByName('TransactionType').AsString;
  Col := grdMain.GetActiveCol;
  FieldName := grdMain.FieldName(Col);
  if FieldName <> 'Memo' then begin
    inherited;
  end;
end;


procedure TSalesReportGUI.FormShow(Sender: TObject);
begin
  grdMain.ShowHint := true;
  inherited;
  grdMain.columnbyName('Attrib1Sale').DisplayLabel := AppEnv.CompanyPrefs.ProductAttrib1Name;
  grdMain.columnbyName('Attrib2Sale').DisplayLabel := AppEnv.CompanyPrefs.ProductAttrib2Name;
  grdMain.columnbyName('Attrib1SaleRate').DisplayLabel := 'Price / ' + AppEnv.CompanyPrefs.ProductAttrib1Name;
  if not AppEnv.CompanyPrefs.ShowMeasurementAttributes then grdMain.RemoveField('Attrib1Sale');
  if not AppEnv.CompanyPrefs.ShowMeasurementAttributes then grdMain.RemoveField('Attrib2Sale');
  if not AppEnv.CompanyPrefs.ShowMeasurementAttributes then grdMain.RemoveField('Attrib1SaleRate');
  if not AppEnv.CompanyPrefs.ShowSalesWarrantyEndsOn then grdMain.RemoveField('WarrantyEndsOn');
  if not AppEnv.CompanyPrefs.ShowSalesWarrantyPeriod then grdMain.RemoveField('WarrantyPeriod');

  if Trim(AppEnv.CompanyPrefs.SalesWarrantyEndsOnCaption) <> '' then
    grdmain.ColumnByName('WarrantyEndsOn').DisplayLabel :=
      Trim(AppEnv.CompanyPrefs.SalesWarrantyEndsOnCaption);

  if Trim(AppEnv.CompanyPrefs.SalesWarrantyPeriodCaption) <> '' then
    grdmain.ColumnByName('WarrantyPeriod').DisplayLabel :=
      Trim(AppEnv.CompanyPrefs.SalesWarrantyPeriodCaption);

  grdMain.columnbyName('Product Name').DisplayLabel := AppEnv.DefaultClass.PartColumn;
  grdMain.columnbyName('Department').DisplayLabel := AppEnv.DefaultClass.ThirdColumn;
  grdMain.columnbyName('Type').DisplayLabel := AppEnv.DefaultClass.SecondColumn;
  grdMain.columnbyName('Manufacturer').DisplayLabel := AppEnv.DefaultClass.FirstColumn;
end;

procedure TSalesReportGUI.grdMainColEnter(Sender: TObject);
var
  i: integer;
  HintFieldName: string;
begin
  inherited;
  if grdmainhint = '' then grdmainhint := grdmain.hint;
  grdMain.Hint := '';
  i := grdMain.GetActiveCol;
  HintFieldName := grdMain.FieldName(i);
  if HintFieldName =QrymainItemPriceEx.fieldname then begin
    grdMain.Hint := 'Sale price of one item excluding tax';
  end else if HintFieldName = QrymainlineTax.Fieldname then begin
    grdMain.Hint := 'Tax due on one item';
  end else if HintFieldName = qryMainITEMPRICEINC.Fieldname then begin
    grdMain.Hint := 'Sale price of one item including tax';
  end else if HintFieldName = QrymainItemcostEx.Fieldname  then begin
    grdMain.Hint := 'Cost price of one item excluding tax';
  end else if HintFieldName = QrymainShipped.Fieldname  then begin
    grdMain.Hint := 'The number of items shipped';
  end else if HintFieldName = QrymainLineCostInc.Fieldname  then begin
    grdMain.Hint := 'Cost of all items including tax';
  end else if HintFieldName = QrymainLinecostEx.Fieldname  then begin
    grdMain.Hint := 'Cost of all items excluding tax';
  end else if HintFieldName = QrymainLineTotalEx.Fieldname  then begin
    grdMain.Hint := 'Sale price of all items excluding tax';
  end else if HintFieldName = QrymainLineTotalInc.Fieldname  then begin
    grdMain.Hint := 'Sale price of all items including tax';
  end else if HintFieldName = QrymainGrossProfit.Fieldname  then begin
    grdMain.Hint := 'Profit before tax';
  end else begin
    grdmain.hint := grdmainhint;
  end;
  grdMain.ShowHint := true;
end;

procedure TSalesReportGUI.HeaderPanelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
  inherited;
  grdMain.Hint := '';
end;

procedure TSalesReportGUI.initform(Sender: TObject);
begin
  if not(Sender is TSalesReportGUI) then exit;

  TSalesReportGUI(Sender).Dtto.Date             := DtTo.Date;
  TSalesReportGUI(Sender).Dtfrom.Date           := Dtfrom.date;
  TSalesReportGUI(Sender).chkIgnoreDates.Checked:=chkIgnoreDates.Checked ;
  TSalesReportGUI(Sender).fbDateRangeSupplied   := True;
  TSalesReportGUI(Sender).grpFilters.itemindex  := grpFilters.itemindex ;
  TSalesReportGUI(Sender).SelectedClassId       := SelectedClassID;
end;

procedure TSalesReportGUI.initformAftershow(Sender: TObject);
begin
  try
    if not(Sender is TSalesReportGUI) then exit;
    TSalesReportGUI(Sender).Qrymain.Locate(QrymainsalelineID.FieldName , QrymainsalelineID.AsInteger, []);
  Except

  end;
end;

//procedure TSalesReportGUI.initqrymainsql;
//begin
//  CreateTemporaryTable;
//end;

procedure TSalesReportGUI.FooterPanelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: integer);
begin
  inherited;
  grdMain.Hint := '';
end;

procedure TSalesReportGUI.btnProductListClick(Sender: TObject);
begin
  inherited;
  popCustomFields.Popup(Mouse.CursorPos.x, Mouse.CursorPos.Y);
end;

Procedure TSalesReportGUI.CreateTemporaryTable;
var
  st:TStringlist;
begin
  fsTablename := commondbLib.CreateUserTemporaryTable('tmp_salesreport' , TablenameSufix);
  st:= tStringlist.create;
  try
    st.add(Customfields);
  finally
    if st.count>0 then executeSQL(st.text);
    Freeandnil(st);
  end;

  Qrymain.SQL.clear;
  Qrymain.SQL.add('Select  ');
  Qrymain.SQL.add('ID                      as   ID , ');
  Qrymain.SQL.add('SALELINEID              as   SALELINEID , ');
  Qrymain.SQL.add('SALEID                  as   SALEID , ');
  Qrymain.SQL.add('PRODUCTID               as   PRODUCTID , ');
  Qrymain.SQL.add('EMPLOYEEID              as   EMPLOYEEID , ');
  Qrymain.SQL.add('CLIENTID                as   CLIENTID , ');
  Qrymain.SQL.add('CLASSID                 as   CLASSID , ');
  Qrymain.SQL.add('SALEDATE                as   SALEDATE , ');
  Qrymain.SQL.add('DueDate                 as   DueDate , ');
  Qrymain.SQL.add('TIMEOFSALE              as   TIMEOFSALE , ');
  Qrymain.SQL.add('TRANSACTIONTYPE         as   TRANSACTIONTYPE , ');
  Qrymain.SQL.add('CUSTOMERNAME            as   CUSTOMERNAME , ');
  Qrymain.SQL.add('SalesReferenceNo        as   SalesReferenceNo , ');
  Qrymain.SQL.add('ShipTo                  as   ShipTo , ');
  Qrymain.SQL.add('GLOBALREF               as   GLOBALREF , ');
  Qrymain.SQL.add('CUSTOMERTYPE            as   CUSTOMERTYPE , ');
  Qrymain.SQL.add('MEMO                    as   MEMO , ');
  Qrymain.SQL.add('COMMENTS                as   COMMENTS , ');
  Qrymain.SQL.add('ORIGINALNO              as   ORIGINALNO , ');
  Qrymain.SQL.add('INVOICENUMBER           as   INVOICENUMBER , ');
  Qrymain.SQL.add('PONUMBER                as   PONUMBER , ');
  Qrymain.SQL.add('TOTALAMOUNTEX           as   TOTALAMOUNTEX , ');
  Qrymain.SQL.add('TOTALTAX                as   TOTALTAX , ');
  Qrymain.SQL.add('TOTALAMOUNTINC          as   TOTALAMOUNTINC , ');
  Qrymain.SQL.add('EMPLOYEENAME            as   EMPLOYEENAME , ');
  Qrymain.SQL.add('CONSIGNMENTNOTE         as   CONSIGNMENTNOTE , ');
  Qrymain.SQL.add('CLASSNAME               as   CLASSNAME , ');
  Qrymain.SQL.add('PRODUCTTYPE             as   PRODUCTTYPE , ');
  Qrymain.SQL.add('MANUFACTURER            as   MANUFACTURER , ');
  Qrymain.SQL.add('TYPE                    as   TYPE , ');
  Qrymain.SQL.add('DEPARTMENT              as   DEPARTMENT , ');
  Qrymain.SQL.add('PRODUCTNAME             as   PRODUCTNAME , ');
  Qrymain.SQL.add('LinesReferenceNo        as   LinesReferenceNo , ');
  Qrymain.SQL.add('ProductPrintName        as   ProductPrintName , ');
  Qrymain.SQL.add('PRODUCTDESCRIPTION      as   PRODUCTDESCRIPTION , ');
  Qrymain.SQL.add('ITEMPRICEEX             as   ITEMPRICEEX , ');
  Qrymain.SQL.add('ITEMPRICEINC            as   ITEMPRICEINC , ');
  Qrymain.SQL.add('ITEMCOSTEX              as   ITEMCOSTEX , ');
  Qrymain.SQL.add('LINECOSTINC             as   LINECOSTINC , ');
  Qrymain.SQL.add('LINECOSTEX              as   LINECOSTEX , ');
  Qrymain.SQL.add('TAXCODE                 as   TAXCODE , ');
  Qrymain.SQL.add('LINETAX                 as   LINETAX , ');
  Qrymain.SQL.add('SHIPPED                 as   SHIPPED , ');
  Qrymain.SQL.add('LINETOTALEX             as   LINETOTALEX , ');
  Qrymain.SQL.add('LINETOTALINC            as   LINETOTALINC , ');
  Qrymain.SQL.add('PREFEREDSUPPLIER        as   PREFEREDSUPPLIER , ');
  Qrymain.SQL.add('SupplierProductCode     as   SupplierProductCode ,');
  Qrymain.SQL.add('DELETED                 as   DELETED , ');
  Qrymain.SQL.add('UNITOFMEASURESALELINES  as   UNITOFMEASURESALELINES , ');
  Qrymain.SQL.add('UNITOFMEASURESHIPPED    as   UNITOFMEASURESHIPPED , ');
  Qrymain.SQL.add('TILL                    as   TILL , ');
  Qrymain.SQL.add('AREA                    as   AREA , ');
  Qrymain.SQL.add('SHIPDATE                as   SHIPDATE , ');
  Qrymain.SQL.add('SOURCE                  as   SOURCE , ');
  Qrymain.SQL.add('POSSOURCE               as   POSSOURCE , ');
  Qrymain.SQL.add('WARRANTYENDSON          as   WARRANTYENDSON , ');
  Qrymain.SQL.add('WARRANTYPERIOD          as   WARRANTYPERIOD , ');
  Qrymain.SQL.add('GROSSPROFIT             as   GROSSPROFIT , ');
  Qrymain.SQL.add('PERCENTPROFIT           as   PERCENTPROFIT , ');
  Qrymain.SQL.add('POSPOSTCODE             as   POSPOSTCODE , ');
  Qrymain.SQL.add('LINESHIPDATE            as   LINESHIPDATE , ');
  Qrymain.SQL.add('DISCOUNTPERCENT         as   DISCOUNTPERCENT , ');
  Qrymain.SQL.add('DISCOUNTS               as   DISCOUNTS , ');
  Qrymain.SQL.add('MARKUP                  as   MARKUP , ');
  Qrymain.SQL.add('MARKUPPERCENTAGE        as   MARKUPPERCENTAGE , ');
  Qrymain.SQL.add('RUNNAME                 as   RUNNAME , ');
  Qrymain.SQL.add(Extrafields);
  Qrymain.SQL.add('ATTRIB1SALERATE         as  ATTRIB1SALERATE , ');
  Qrymain.SQL.add('ATTRIB1SALE             as  ATTRIB1SALE , ');
  Qrymain.SQL.add('ATTRIB2SALE             as  ATTRIB2SALE  ');
  Qrymain.SQL.add('from '+fstablename);
  RefreshOrignalSQL;
end;

procedure TSalesReportGUI.FormCreate(Sender: TObject);
begin
  mnuNone.Visible     := not(Self.ClassNameIs('TSalesReportGUI'));
  Product1.Visible    := not(Self.ClassNameIs('TSalesReportProductcustomFieldListGUI'));
  salesLines1.Visible := not(Self.ClassNameIs('TSalesReportSaleslinescustomFieldListGUI'));
  Customer1.Visible   := not(Self.ClassNameIs('TSalesReportCustomercustomFieldListGUI'));
  grdmainhint:= '';
  fbEnableWebSearch := true;
  ReportonForeignCurrency := true;
  fiProductID := 0;
  inherited;
  SelectionOption :=soClass;
  CreateTemporaryTable;
  ShowChartViewOnPopup := True;
  showFCFooters := true;
  AddCalccolumn('Shipped',False);
  AddCalccolumn('ITEMPRICEEX',true);
  AddCalccolumn('ITEMPRICEINC',true);
  AddCalccolumn('ITEMCOSTEX',true);
  AddCalccolumn('LINECOSTINC',true);
  AddCalccolumn('LINECOSTEX',true);
  AddCalccolumn('LINETAX',true);
  AddCalccolumn('LINETOTALEX',true);
  AddCalccolumn('LINETOTALINC',true);
  AddCalccolumn('GROSSPROFIT',true);
  AddCalccolumn('DISCOUNTS',true);
  AddCalccolumn('MARKUP',true);
end;

procedure TSalesReportGUI.chkBaseOnShippedClick(Sender: TObject);
begin
  inherited;
  //MakeQry;
  RefreshQuery;
end;


function TSalesReportGUI.CustomercustomFields(Const Tablealias:String) : String;
begin
  result:= '';
end;

function TSalesReportGUI.Customfields: String;
begin
  REsult:= '';
end;

function TSalesReportGUI.Extrafields: String;
begin
  result:= '';
end;

procedure TSalesReportGUI.MakeQry;
var
    sSQL,Fieldlist,tmpfilename,tmpfilename1, tmpfilename2, tmpfilename3:String;
    tmptablename1,tmptablename2,tmptablename3:String;
begin
    if Qrymain.active then Qrymain.close;
    With scriptmain do begin
        SQL.clear;
        SQL.add('/*1*/truncate '+ fstablename +';');
//        CreateTemporaryTable;

        FieldList:= ' SaleDate,DueDate,SaleLineId, TimeOfSale,TransactionType,CustomerName,SalesReferenceNo,ShipTo,' +
        ' GlobalRef,' +
        ' Memo,Comments,OriginalNo,InvoiceNumber,' +
        ' PONumber,TotalAmountEx,TotalTax,TotalAmountInc,' +
        ' EmployeeName,' +
        ' ConsignmentNote,' +
        ' ClassName,' +
        ' ProductName,' +
        ' LinesReferenceNo,' +
        ' ProductPrintName,' +
        ' ProductDescription,ItemPriceEx,ItemPriceInc,ItemCostEx,LineCostInc,' +
        ' LineCostEx,TaxCode,LineTax,Shipped,LineTotalEx,LineTotalInc,' +
        ' Deleted,EmployeeID,ClientID,' +
        ' SaleID,' +
        ' RunName,' +
        ' ProductID,Attrib1Sale,Attrib2Sale,Attrib1SaleRate,' +
        ' UnitOfMeasureSaleLines,UnitOfMeasureShipped,ClassID,Till,Area,' +
        ' ShipDate,' +
        ' POSSource , WarrantyEndsOn,WarrantyPeriod, POSPostCode,LineShipDate, ' +
        ' DiscountPercent,Discounts,' +
        SaleLinescustomfields('') +
        ProductcustomFields('') +
        CustomercustomFields('') +
        'Markup,MarkupPercentage ' ;

        ssql:= ' SELECT ' +
        ' S.SaleDate as SaleDate,' +
        ' S.DueDate as DueDate,' +
        ' SL.SaleLineId as SaleLineId,' +
        ' S.TimeOfSale as TimeOfSale,' +
        ' If(S.IsCashSale="T" And S.IsPOS="F", "Cash Sale",' +
        ' If(S.IsRefund="T","Refund",' +
        ' If(S.IsCashSale="T" And S.IsPOS="T","POS",' +
        ' If(S.IsInvoice="T","Invoice","Unknown")))) as TransactionType,' +
        ' S.CustomerName as CustomerName,' +
        ' S.ReferenceNo as SalesReferenceNo,' +
        'S.ShipTo as ShipTo,' +
        ' S.GlobalRef as GlobalRef,' +
        ' Memo as Memo,' +
        ' Comments as Comments,' +
        ' S.OriginalNo as OriginalNo,' +
        ' S.InvoiceDocNumber as InvoiceNumber ,' +
        ' S.PONumber as PONumber,' +
        ' S.TotalAmount as TotalAmountEx,' +
        ' S.TotalTax as TotalTax,' +
        ' S.TotalAmountInc as TotalAmountInc,' +
        ' S.EmployeeName AS EmployeeName,' +
        ' S.ConNote as ConsignmentNote,' +
        ' S.Class as ClassName,' +
        ' SL.ProductName as ProductName,' +
        ' SL.ReferenceNo as LinesReferenceNo,' +
        ' P.ProductPrintName as ProductPrintName,' +
        ' SL.Product_Description as ProductDescription,' +
        ' SL.LinePrice as ItemPriceEx,' +
        ' SL.LinePriceInc as ItemPriceInc,' +
        ' SL.LineCost as ItemCostEx,' +
        ' Round(SL.LineCostInc*SL.Shipped,'+inttostr(CurrencyRoundPlaces)+') as LineCostInc,' +
        ' Round(SL.LineCost*SL.Shipped,'+inttostr(CurrencyRoundPlaces)+') as LineCostEx,' +
        ' SL.LineTaxCode as TaxCode,' +
        ' SL.LineTax as LineTax,' +
        ' SL.Shipped as Shipped,' +
        ' SL.TotalLineAmount as LineTotalEx,' +
        ' SL.TotalLineAmountInc as LineTotalInc,' +
        ' S.Deleted as Deleted,' +
        ' S.EmployeeID as EmployeeID,' +
        ' S.ClientID as ClientID,' +
        ' S.SaleID as SaleID,' +
        ' S.RunName as RunName,' +
        ' SL.ProductID as ProductID,' +
        ' SL.Attrib1Sale as Attrib1Sale,' +
        ' SL.Attrib2Sale as Attrib2Sale,' +
        ' SL.Attrib1SaleRate as Attrib1SaleRate,' +
        ' SL.UnitOfMeasureSaleLines as UnitOfMeasureSaleLines,' +
        ' SL.UnitOfMeasureShipped as UnitOfMeasureShipped,' +
        ' S.ClassID as ClassID,' +
        ' tblPosTills.TillName as Till,' +
        ' SL.Area as Area,' +
        ' S.ShipDate as ShipDate,' +
        ' S.Medtype as POSSource,' +
        ' SL.WarrantyEndsOn as WarrantyEndsOn ,' +
        ' SL.WarrantyPeriod as WarrantyPeriod, S.POSPostCode,SL.ShipDate ,' +
        ' SL.DiscountPercent,SL.Discounts,' +
        SaleLinescustomfields('SL') +
        ProductcustomFields('P') +
        CustomercustomFields('C') +
        ' SL.Markup,SL.MarkupPercent ' +
        ' FROM tblSales S ' +
        ' inner join tblclients C on s.clientID = C.clientID ' +
        ' INNER JOIN tblSalesLines SL ON  S.SaleID = SL.SaleID ' +
        ' inner join tblparts  P on P.PartsID = Sl.productId' +
        ' left join tblPosTills on tblPosTills.TillId = S.TillId ' +
        ' WHERE (S.IsRefund ="T" OR S.IsCashSale="T" OR ' +
        ' S.IsInvoice="T" OR S.IsPOS="T") ' +
        ' AND S.IsQuote="F" AND S.IsLayby="F" ';
        if fiProductID <> 0 then ssql:= ssql+ ' AND SL.ProductID = ' +inttostr(fiProductID);

        if SelectedClassID <> 0 then ssql:= ssql+ ' AND S.ClassID = ' + IntToStr(SelectedClassID);
        if not chkBaseOnShipped.Checked then ssql:= ssql +' AND S.SaleDate Between ' + quotedstr(FormatDateTime(MysqlDateFormat, FilterDateFrom)) +
                            ' AND ' + quotedstr(FormatDateTime(MysqlDateFormat, filterDateto))
        else ssql:= ssql+' AND S.ShipDate Between ' +quotedstr(FormatDateTime(MysqlDateFormat, filterDateFrom)) +
                            ' AND ' + quotedstr(FormatDateTime(MysqlDateFormat, FilterDateTo)) ;

        ssql:= ssql +' GROUP BY SL.SaleLineID';
        ssql:= ssql +' Order BY SL.SaleID Desc ';
        SQL.add('/*2*/'+CreateTemporaryTableusingfile(GetSharedMyDacConnection, '' , ssql , FieldList ,fstablename , tmpfilename));


        tmptablename1:= fsTablename+'1';
        tmptablename2:= fsTablename+'2';
        tmptablename3:= fsTablename+'3';
        SQL.add('/*3*/'+SQLfortemptable('tblClients', 'CT.TypeName','' ,
                                      ' inner join '+fsTablename + ' T on  M.ClientID = T.ClientID inner join tblclienttype CT on Ct.ClientTypeID = M.ClientTypeID', tmptablename1,tmpfilename1,GetSharedMyDacConnection));
        SQL.add('/*4*/'+SQLfortemptable('tblClients', 'S.MediaType','' ,
                                    ' inner join '+fsTablename + ' T on  M.ClientID = T.ClientID inner join tblsource S on S.MedTypeID=M.MedTypeID', tmptablename2,tmpfilename2, GetSharedMyDacConnection));
        SQL.add('/*5*/'+SQLfortemptable('tblparts','PT.TypeDesc ,PRODUCTGROUP , PREFEREDSUPP , SupplierProductCode ','' ,
                                      ' inner join '+fsTablename + ' T on  M.PartsId = T.ProductId inner join tblparttypes PT on M.PARTTYPE = PT.TypeCode', tmptablename3,tmpfilename3, GetSharedMyDacConnection));

        SQL.add('/*6*/'+'update '+fstablename +' T ' +
                    ' inner join ' + tmptablename1+' as T1 on T.ClientId = T1.ClientID' +
                    ' Set  T.CustomerType = T1.TypeName; ');


        SQL.add('/*7*/'+'update '+fstablename +' T ' +
                    ' inner join ' + tmptablename2+' as T1 on T.ClientId = T1.ClientID' +
                    ' Set  T.Source = T1.MediaType; ');

				SQL.add('/*8*/'+'update '+fstablename +' T  ' +
                    ' inner join ' + tmptablename3+' as T1 on T.ProductID = T1.PartsId' +
                    ' Set T.ProductType = T1.TypeDesc , '+
                    ' T.Manufacturer = ' + Firstcolumn('T1') +',' +
                    ' T.Type = ' + Secondcolumn('T1') +',' +
                    ' T.Department = ' + Thirdcolumn('T1') +',' +
                    ' T.SupplierProductCode = T1.SupplierProductCode , '+
                    ' T.PreferedSupplier = T1.PREFEREDSUPP; ');

        SQL.add('/*9*/'+'update ' + fsTablename + ' set  PercentProfit = 0;');
        SQL.add('/*10*/'+'update ' + fsTablename + ' set  PercentProfit = Round(((LineTotalEx - LineCostEx) /LineTotalEx) * 100,'+inttostr(CurrencyRoundPlaces)+') where LineTotalEx <> 0;');
        SQL.add('/*11*/'+'update ' + fsTablename + ' set  GrossProfit = LineTotalEx - LineCostEx;');
        DoshowProgressbar(StringCount(';' , SQL.text) +1, WAITMSG);
      try
        Execute;
      finally
        DoHideProgressbar;
        try
          DoshowProgressbar(4, 'Deleting Report Temproray Files');
          try
            AppEnv.UtilsClient.DeleteServerFiles(replaceStr(tmpfilename , '.tmp' , '*.tmp')); DoStepProgressbar('1 of 4');
            AppEnv.UtilsClient.DeleteServerFiles(replaceStr(tmpfilename1, '.tmp' , '*.tmp')); DoStepProgressbar('2 of 4');
            AppEnv.UtilsClient.DeleteServerFiles(replaceStr(tmpfilename2, '.tmp' , '*.tmp')); DoStepProgressbar('3 of 4');
            AppEnv.UtilsClient.DeleteServerFiles(replaceStr(tmpfilename3, '.tmp' , '*.tmp')); DoStepProgressbar('4 of 4');
          finally
            DoHideProgressbar;
          end;
        except
          on E:Exception do begin
            MessageDlgXP_Vista('Failed to Delete Temproray files Created While Populating the Report.'+NL+E.message, mtWarning, [mbOK], 0);
            SendExceptionEmail(E, classname +':  ' + NL+
                                  'Failed to Delete Temproray files Created While Populating the Report.'+NL+
                                  'Files :' +NL+
                                  '    tmpfilename  - '+ tmpfilename   + ': ' +Booleantostr(fileExists(tmpfilename)) +NL+
                                  '    tmpfilename1 - '+ tmpfilename1  + ': ' +Booleantostr(fileExists(tmpfilename1)) +NL+
                                  '    tmpfilename2 - '+ tmpfilename2  + ': ' +Booleantostr(fileExists(tmpfilename2)) +NL+
                                  '    tmpfilename3 - '+ tmpfilename3  + ': ' +Booleantostr(fileExists(tmpfilename3)) );

          end;
        end;
      end;
  end;
end;


procedure TSalesReportGUI.FormDestroy(Sender: TObject);
begin
  DeleteTable(fstablename);
  DeleteTable(fstablename+'1');
  DeleteTable(fstablename+'2');
  DeleteTable(fstablename+'3');
  inherited;
end;

procedure TSalesReportGUI.MyScriptError(Sender: TObject; E: Exception; SQL: String; var Action: TErrorAction);
begin
  Action := eaContinue;
end;

function TSalesReportGUI.ProductcustomFields(Const Tablealias:String) : String;
begin
  result:= '';
end;

procedure TSalesReportGUI.QrymainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  DoHideProgressbar;
end;


procedure TSalesReportGUI.QrymainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  doshowProgressbar(3, WAITMSG);
  DoStepProgressbar;
end;

procedure TSalesReportGUI.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;
function TSalesReportGUI.SaleLinescustomfields(Const Tablealias:String) : String;
begin
  result:= '';
end;

procedure TSalesReportGUI.SetGridColumns;
begin
  inherited;
  if not AppEnv.CompanyPrefs.ShowMeasurementAttributes then RemoveFieldfromGrid(QrymainAttrib1Sale.fieldname);
  if not AppEnv.CompanyPrefs.ShowMeasurementAttributes then RemoveFieldfromGrid(QrymainAttrib2Sale.fieldname);
  if not AppEnv.CompanyPrefs.ShowMeasurementAttributes then RemoveFieldfromGrid(QrymainAttrib1SaleRate.fieldname);
  RemoveFieldfromGrid(qryMainID.fieldname);
  RemoveFieldfromGrid(qryMainSALELINEID.fieldname);
  RemoveFieldfromGrid(qryMainPRODUCTID.fieldname);
  RemoveFieldfromGrid(qryMainEMPLOYEEID.fieldname);
  RemoveFieldfromGrid(qryMainCLIENTID.fieldname);
  RemoveFieldfromGrid(qryMainCLASSID.fieldname);
  RemoveFieldfromGrid(qryMainSHIPPED.fieldname);
  RemoveFieldfromGrid(qrymaindeleted.fieldname);
end;

procedure TSalesReportGUI.SetupFormInPanel;
begin
  btnProductList.Visible:= false;
  inherited;
end;

function TSalesReportGUI.TablenameSufix: String;
begin
  REsult := 'tmp';
end;

procedure TSalesReportGUI.salesLines1Click(Sender: TObject);begin  OpenERPListForm('TSalesReportSaleslinescustomFieldListGUI',initform, initformAftershow); Self.close;end;
procedure TSalesReportGUI.Product1Click   (Sender: TObject);begin  OpenERPListForm('TSalesReportProductcustomFieldListGUI'   ,initform, initformAftershow); Self.close;end;
procedure TSalesReportGUI.Customer1Click  (Sender: TObject);begin  OpenERPListForm('TSalesReportCustomercustomFieldListGUI'  ,initform, initformAftershow); Self.close;end;
procedure TSalesReportGUI.mnuNoneClick    (Sender: TObject);begin  OpenERPListForm('TSalesReportGUI'  ,initform, initformAftershow);Self.Close;end;
procedure TSalesReportGUI.ReadnApplyGuiPrefExtra;
begin
    inherited;
end;
Procedure TSalesReportGUI.WriteGuiPrefExtra;
begin
    inherited;
end;

initialization
  RegisterClassOnce(TSalesReportGUI);
end.





