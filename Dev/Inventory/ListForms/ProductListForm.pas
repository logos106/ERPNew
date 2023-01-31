unit ProductListForm;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 07/04/05  1.00.01 IJB  Added functionality to set product commissions.
 12/04/05  1.00.02 DJH  Added Column called LandedCost from tblparts.
 18/04/05  1.00.03 IJB  Added functionality to set product reward points.
 20/04/05  1.00.04 IJB  Added functionality to show message if no products
                        selected for seting commission, points etc.
 26/04/05  1.00.05 IJB  Added $/% symbol in front of edtRate TEdit control.
 17/05/05  1.00.06 BJ   Globalref Field is added to the Grid as the first column
 20/06/05  1.00.07 IJB  Added "Allocated Job" column to query/grid (this uses
                        two left joins so will impact on list speed).
 19/08/05  1.00.08 BJ   The list is of all active products. Option to filter the
                        Active and inactive products is disabled. Implemented a link
                        to open another list of the inactive products.
 07/09/05  1.00.09 ISB	Modified To Work With New Filtering on Baselisting.
 23/09/05  1.00.10 DSP  Added company preference ProductClassDefaultAll.
 26/09/05  1.00.11 DSP  Changed name of 'PDA LandedCost' heading to
                        'LandedCost'.
 26/09/05  1.00.12 MV   Modified MakeQRYmain by replacing block for multiple lines
                        and adding [as title] for DateUpdated, Area, Discontinued,
                        OnSpecial and "".
 27/09/05  1.00.13 MV   Modified FormShow to validate no error has occured before
                        displaying the form.
 27/10/05  1.00.14 MV   Added Average Cost to details selection.
 16/02/06  1.00.15 DSP  Added AppEnv.DefaultClass.PartColumn assignments to RefreshQuery.
 19/04/06  1.00.16 DSP  Fixed bug with field 'AllocatedJob' in qryMain SQL.
 18/09/06  1.00.17 DSP  Fixed bug in search functionality. Also removed the use
                        of DeletedProducts to display inactive products. They
                        are now displayed using this form.
 12/01/22  2022.0.2     Added prompt to deactivate unused products when out of memory
                        error occurs on loading products
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, StdCtrls, ExtCtrls, ComCtrls,AdvOfficeStatusBar,
  wwcheckbox, wwdblook, DNMPanel, SelectionDialog,
  wwDialog, Wwlocate, MyAccess,ERPdbComponents, MemDS, DBAccess, wwdbdatetimepicker, Mask,
 ProductQtyLib,  wwdbedit, ProgressDialog,  Shader, kbmMemTable, busobjProductcommission, DNMAction,
  DAScript, MyScript,BaseListDetails, CustomInputBox, ProductQtylist,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TProductlistmode = (tNormalList=1 , tCommissionList=2, tSetPoints = 3, tMultiplecommission=4);
  TProductListGUI = class(TProductQtylistGUI)
    btnBarCodes: TDNMSpeedButton;
    actBarCodes: TAction;
    qryMainBuyQtyA: TIntegerField;
    qryMainBuyQtyB: TIntegerField;
    qryMainBuyQtyC: TIntegerField;
    qryMainCostExB: TFloatField;
    qryMainCostExC: TFloatField;
    qryMainCostIncB: TFloatField;
    qryMainCostIncC: TFloatField;
    qryMainSellQtyA: TIntegerField;
    qryMainSellQtyB: TIntegerField;
    qryMainSellQtyC: TIntegerField;
    qryMainPriceIncB: TFloatField;
    qryMainPriceIncC: TFloatField;
    qryMainWholesalePrice: TFloatField;
    qryMainBarcode: TWideStringField;
    qryMainStockValue: TFloatField;
    qryMainStockValueonLandedCost: TFloatField;
    qryMainCost: TFloatField;
    DataSource1: TDataSource;
    qryMainProductType: TWideStringField;
    qryMainSupplierProductCode: TWideStringField;
    qryMainPriceExB: TFloatField;
    qryMainPriceExC: TFloatField;
    N1: TMenuItem;
    Merge1: TMenuItem;
    qryMainArea: TWideStringField;
    qryMainDiscontinued: TWideStringField;
    qryMainOnSpecial: TWideStringField;
    lblMsg1: TLabel;
    qryPartTypes: TERPQuery;
    qryMainDateCreated: TDateField;
    qryMainDateUpdated: TDateField;
    qryMainGlobalRef: TWideStringField;
    qryMainValueAvg: TFloatField;
    btnActiveState: TDNMSpeedButton;
    qryMainMarkupPercentage: TFloatField;
    qryMainMarginMode: TWideStringField;
    actSelectAll: TDNMAction;
    btnSelect: TDNMSpeedButton;
    qryMainHasFormulaAttached: TWideStringField;
    qryMainIncludeInAnalysis: TWideStringField;
    qryMainSpecialDiscount: TWideStringField;
    btnListWithDept: TDNMSpeedButton;
    qryMainSalesValue: TFloatField;
    qryMainIsSystemProduct: TWideStringField;
    qryMainEnablePackWeight: TWideStringField;
    qryMainAttrib1Sale: TFloatField;
    qryMainAttrib2Sale: TFloatField;
    qryMainAttrib1SaleRate: TFloatField;
    qryMainAttrib1Purchase: TFloatField;
    qryMainAttrib2Purchase: TFloatField;
    qryMainAttrib1PurchaseRate: TFloatField;
    DNMSpeedButton3: TDNMSpeedButton;
    qryMainPRODUCTCOMMENT: TWideStringField;
    qryMainVariancePriceInc: TFloatField;
    pnlOptions: TDNMPanel;
    DNMPanel1: TDNMPanel;
    lblSetPoints: TLabel;
    chkBarCodes: TCheckBox;
    chkSetCommission: TCheckBox;
    chkSetPoints: TCheckBox;
    pnlBarCode: TDNMPanel;
    lblBarCode: TLabel;
    chkBarInStock: TCheckBox;
    edtBarQty: TEdit;
    udBarQty: TUpDown;
    pnlCommission: TDNMPanel;
    Label8: TLabel;
    Label9: TLabel;
    lblRateType: TLabel;
    chkIsPercentage: TwwCheckBox;
    edtRate: TEdit;
    btnProductcommissionList: TDNMSpeedButton;
    qryMainHire: TWideStringField;
    btnReorderLevels: TDNMSpeedButton;
    qryMainRA: TFloatField;
    qryMainPreferredSupplier: TWideStringField;
    qryMainRA_AwaitingRANo: TFloatField;
    qryMainRA_InTransit: TFloatField;
    qryMainRA_Returned: TFloatField;
    qryMainRA_SendToSupplier: TFloatField;
    qryMainRA_Testing: TFloatField;
    qryMainRA_WithSupplier: TFloatField;
    qryMainCUSTFLD1: TWideStringField;
    qryMainCUSTFLD2: TWideStringField;
    qryMainCUSTFLD3: TWideStringField;
    qryMainCUSTFLD4: TWideStringField;
    qryMainCUSTFLD5: TWideStringField;
    qryMainCUSTFLD6: TWideStringField;
    qryMainCUSTFLD7: TWideStringField;
    qryMainCUSTFLD8: TWideStringField;
    qryMainCUSTFLD9: TWideStringField;
    qryMainCUSTFLD10: TWideStringField;
    qryMainCUSTFLD11: TWideStringField;
    qryMainCUSTFLD12: TWideStringField;
    qryMainCUSTFLD13: TWideStringField;
    qryMainCUSTFLD14: TWideStringField;
    qryMainCUSTFLD15: TWideStringField;
    qryMainCUSTDATE1: TDateTimeField;
    qryMainCUSTDATE2: TDateTimeField;
    qryMainCUSTDATE3: TDateTimeField;
    procedure FormShow(Sender: TObject);
    procedure chkAllClassClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkBarCodesClick(Sender: TObject);
    procedure actBarCodesUpdate(Sender: TObject);
    procedure actBarCodesExecute(Sender: TObject);
    procedure chkBarInStockClick(Sender: TObject);
    procedure actExecuteFilterExecute(Sender: TObject);
    procedure actClearFilterExecute(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure edtSearchKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure edtSearchExit(Sender: TObject);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: boolean; var Accept: boolean);
    procedure actMergeExecute(Sender: TObject);
    procedure chkSetCommissionClick(Sender: TObject);
    procedure edtRateKeyPress(Sender: TObject; var Key: char);
    procedure chkIsPercentageClick(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure btnProductcommissionListClick(Sender: TObject);
    procedure actSelectAllUpdate(Sender: TObject);
    procedure actSelectAllExecute(Sender: TObject);
    procedure btnListWithDeptClick(Sender: TObject);
    procedure DNMSpeedButton3Click(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormDestroy(Sender: TObject);
    procedure btnReorderLevelsClick(Sender: TObject);
    procedure dtToChange(Sender: TObject);
    procedure SctMainError(Sender: TObject; E: Exception; SQL: string;
      var Action: TErrorAction);
  private
    { Private declarations }
    FirstStart: boolean;
    fProgressdialog :TProgressdialog;
    fProductlistmode: TProductlistmode;
    fProductGridDataSelect: TNotifyEvent;
    fiProductcommissionEmployeeID: Integer;
    fProductCommission: TProductCommission;
    LastSelectedID: integer;
    PrincipleProductforMergeName: string;
    PrincipleProductforMergeID: integer;
    PrincipleProductforMergeType: string;
    PrincipleProductforMergebin, PrincipleProductforMergebatch, PrincipleProductforMergesrno :boolean;
    PrintingBarCode:Boolean;
    Tablename:STring;
    fbHasSQLError :Boolean;
    printingBarcodes : boolean;
    procedure SetCommissions;
    procedure SetProductcommission;
    procedure SetPoints;
    Procedure PrintBarCodes;
    Procedure Setbuttons(const Value:Boolean; DetailPanel:TDnMPanel);
    procedure setProductlistmode(const Value: TProductlistmode);
    Procedure KillProgressdialog;
    Procedure NewProgressdialog(const Msg:String; const Count:Integer);
    Procedure StepProgressdialog;
    function Progressdialog :TProgressdialog;
    function ProductHasPQA(const ProductId: Integer): boolean;
    procedure initPQAMovement(Sender: TObject);
    procedure MakeQrymainSQL;
  protected
    procedure MakeQrymain;Override;
    procedure RefreshTotals; override;
    Procedure SetGridColumns;override;
    procedure IterateselectedRecordsCallback(var Abort: boolean;SelIndex:Integer);Override;
    procedure BeforePopup(Popupform: TComponent);Override;
    function GetReportTypeID: integer; Override;
    Function DefaultAllClasses :Integer;Override;
    procedure ReadnApplyGuiPrefExtra; override;
    Procedure WriteGuiPrefExtra; override;
    procedure OnRefreshQueryOutOfMemoryError(Sender: TObject);Override;
    procedure DeactivateUnusedProducts();
  public
    procedure RefreshQuery; override;
    Property Productlistmode :TProductlistmode Read fProductlistmode Write setProductlistmode;
    Property ProductcommissionEmployeeID :Integer read fiProductcommissionEmployeeID Write fiProductcommissionEmployeeID;
    Property ProductGridDataSelect :TNotifyEvent read fProductGridDataSelect Write fProductGridDataSelect;
    Property ProductCommission :TProductCommission read fProductCommission Write fProductCommission;
  end;

implementation

uses
   Dnmlib, CommonDbLib,
  MergeObj, AppContextObj, CommonLib,
  {tcMessaging,} MAIN,  ProductListExpressForm, AppEnvironment,
  FastFuncs, ReportTemplates, dmMainGUI, ProductMovementList,
  BusObjBase, ProductCommissionList, tcConst, CommonFormLib,
  UserUtilsClientObj,  frmProductSOInfo, SystemLib,
  PQAMovement, LogLib, MySQLConst , StrUtils, tcDataUtils,
  GuiPrefsObj, PQALib, DateUtils, frmDateInputBox, SharedObjs;

{$R *.dfm}

procedure TProductListGUI.FormShow(Sender: TObject);
begin
  grdMain.UseTFields := True;
  FirstStart := true;
  qryPartTypes.Open;
  inherited;

  if EmployeeHasAccess('CanViewInactiveProducts') = False then begin
     if grpFilters.itemindex <> 0 then grpFilters.itemindex := 0;
     grpFilters.visible := False;
  end;

  if self.ErrorOccurred then Exit;


  pnlOptions.top := pnlAdvPrinting.top;
  pnlOptions.height := pnlAdvPrinting.height;
  pnlOptions.Left :=Label3.Left;
  Showcontrolhint(grdmain , quotedstr(QrymainOnOrder.displaylabel)+ ' Excludes Purchase Back Orders (Future)' +NL+
                        quotedstr(QrymainAvailable.displaylabel)+ ' Includes Quantity on non Credited Return Authority');
  Qrymain.First;
  if Appenv.CompanyPrefs.AutoLocateproductinList then
    if GuiPrefs.Node.Exists('Options.PartsID') then
      Qrymain.locate('PartsId',  GuiPrefs.Node['Options.PartsID'].asInteger , []);
end;

function TProductListGUI.GetReportTypeID: integer;
begin
  if Printingbarcode then
    REsult:= 3
  else
    REsult:= 0;
end;

procedure TProductListGUI.chkAllClassClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;
Procedure TProductListGUI.MakeQrymainSQL;
begin
    Qrymain.SQL.clear;
    Qrymain.sql.add('SELECT');
    Qrymain.sql.add('GlobalRef as GlobalRef,');
    Qrymain.sql.add('ProductName as ProductName,');
    Qrymain.sql.add('PreferedSupplier as PreferedSupplier,');
    Qrymain.sql.add('ProductPrintName as ProductPrintName,');
    Qrymain.sql.add('HasFormulaAttached as HasFormulaAttached,');
    Qrymain.sql.add('IncludeInAnalysis as IncludeInAnalysis,');
    Qrymain.sql.add('MultipleBins as MultipleBins,');
    Qrymain.sql.add('batch as batch,');
    Qrymain.sql.add('SNTracking as SNTracking,');
    Qrymain.sql.add('LandedCost as LandedCost,');
    Qrymain.sql.add('ProductTypeCode as ProductTypeCode,');
    Qrymain.sql.add('FirstColumn as FirstColumn,');
    Qrymain.sql.add('SecondColumn as SecondColumn,');
    Qrymain.sql.add('ThirdColumn as ThirdColumn,');
    Qrymain.sql.add('SalesDescription as SalesDescription,');
(*    Qrymain.sql.add('PARTSDESCRIPTION_Memo as PARTSDESCRIPTION_Memo,');
    Qrymain.sql.add('PURCHASEDESC_Memo as PURCHASEDESC_Memo,');*)
    Qrymain.sql.add('PRODUCTCOMMENT as PRODUCTCOMMENT,');
    Qrymain.sql.add('CostIncA as CostIncA,');
    Qrymain.sql.add('PriceIncA as PriceIncA,');
    Qrymain.sql.add('MarkupPercentage as MarkupPercentage,');
    Qrymain.sql.add('MarginMode as MarginMode,');
    Qrymain.sql.add('InStock as InStock,');
    Qrymain.sql.add('(T.Available - ifnull(OnTransit, 0.0))  as Available,');
    Qrymain.sql.add('AllocatedSO as AllocatedSO,');
    Qrymain.sql.add('AllocatedBO as AllocatedBO,');
    //Qrymain.sql.add('AllocatedSOBO as AllocatedSOBO,');
    Qrymain.sql.add('OnOrder as OnOrder,');
    Qrymain.sql.add('SOBackOrders as SOBackOrders,');
    Qrymain.sql.add('OnBuild as OnBuild,');
    QryMain.sql.Add('RA as RA,');
    Qrymain.sql.add('Building as Building,');
    Qrymain.sql.add('VariancePriceInc as VariancePriceInc,');
    Qrymain.sql.add('OnTransit as OnTransit,');
    Qrymain.sql.add('ProductType as ProductType,');
    Qrymain.sql.add('BuyQtyA as BuyQtyA,');
    Qrymain.sql.add('BuyQtyB as BuyQtyB,');
    Qrymain.sql.add('BuyQtyC as BuyQtyC,');
    Qrymain.sql.add('CostExA as CostExA,');
    Qrymain.sql.add('CostExB as CostExB,');
    Qrymain.sql.add('CostExC as CostExC,');
    Qrymain.sql.add('CostIncB as CostIncB,');
    Qrymain.sql.add('CostIncC as CostIncC,');
    Qrymain.sql.add('SellQtyA as SellQtyA,');
    Qrymain.sql.add('SellQtyB as SellQtyB,');
    Qrymain.sql.add('SellQtyC as SellQtyC,');
    Qrymain.sql.add('PriceExA as PriceExA,');
    Qrymain.sql.add('PriceExB as PriceExB,');
    Qrymain.sql.add('PriceExC as PriceExC,');
    Qrymain.sql.add('PriceIncB as PriceIncB,');
    Qrymain.sql.add('PriceIncC as PriceIncC,');
    Qrymain.sql.add('WholesalePrice as WholesalePrice,');
    Qrymain.sql.add('PurchaseDescription as PurchaseDescription,');
    Qrymain.sql.add('IncomeAccount as IncomeAccount,');
    Qrymain.sql.add('AssetAccount as AssetAccount,');
    Qrymain.sql.add('CostofGoodsSoldAccount as CostofGoodsSoldAccount,');
    Qrymain.sql.add('Barcode as Barcode,');
    Qrymain.sql.add('ProductCode as ProductCode,');
    Qrymain.sql.add('Taxcode as Taxcode,');
    Qrymain.sql.add('PurchaseTaxcode as PurchaseTaxcode,');
    Qrymain.sql.add('PreferredSupplier as PreferredSupplier,');
    Qrymain.sql.add('SpecialDiscount as SpecialDiscount,');
    Qrymain.sql.add('PercentCost as PercentCost,');
    Qrymain.sql.add('Active as Active,');
    Qrymain.sql.add('PARTSID as PARTSID,');
    Qrymain.sql.add('SupplierProductCode as SupplierProductCode,');
    Qrymain.sql.add('DateCreated as DateCreated,');
    Qrymain.sql.add('DateUpdated as DateUpdated,');
    Qrymain.sql.add('Area as Area,');
    Qrymain.sql.add('Discontinued as Discontinued,');
    Qrymain.sql.add('OnSpecial as OnSpecial,');
    Qrymain.sql.add('AvgCost as AvgCost,');
    Qrymain.sql.add('CUSTFLD1 as CUSTFLD1,');
    Qrymain.sql.add('CUSTFLD2 as CUSTFLD2,');
    Qrymain.sql.add('CUSTFLD3 as CUSTFLD3,');
    Qrymain.sql.add('CUSTFLD4 as CUSTFLD4,');
    Qrymain.sql.add('CUSTFLD5 as CUSTFLD5,');
    Qrymain.sql.add('CUSTFLD6 as CUSTFLD6,');
    Qrymain.sql.add('CUSTFLD7 as CUSTFLD7,');
    Qrymain.sql.add('CUSTFLD8 as CUSTFLD8,');
    Qrymain.sql.add('CUSTFLD9 as CUSTFLD9,');
    Qrymain.sql.add('CUSTFLD10 as CUSTFLD10,');
    Qrymain.sql.add('CUSTFLD11 as CUSTFLD11,');
    Qrymain.sql.add('CUSTFLD12 as CUSTFLD12,');
    Qrymain.sql.add('CUSTFLD13 as CUSTFLD13,');
    Qrymain.sql.add('CUSTFLD14 as CUSTFLD14,');
    Qrymain.sql.add('CUSTFLD15 as CUSTFLD15,');
    Qrymain.sql.add(' CUSTDATE1 as  CUSTDATE1,');
    Qrymain.sql.add('CUSTDATE2 as CUSTDATE2,');
    Qrymain.sql.add('CUSTDATE3 as CUSTDATE3,');
    Qrymain.sql.add('IsSystemProduct as IsSystemProduct,');
    Qrymain.sql.add('EnablePackWeight as EnablePackWeight,');
    Qrymain.sql.add('Attrib1Sale as Attrib1Sale,');
    Qrymain.sql.add('Attrib2Sale as Attrib2Sale,');
    Qrymain.sql.add('Attrib1SaleRate as Attrib1SaleRate,');
    Qrymain.sql.add('Attrib1Purchase as Attrib1Purchase,');
    Qrymain.sql.add('Attrib2Purchase as Attrib2Purchase,');
    Qrymain.sql.add(' Attrib1PurchaseRate as  Attrib1PurchaseRate,');
    Qrymain.sql.add('Hire as Hire, ');
    Qrymain.sql.add('RA_AwaitingRANo    as RA_AwaitingRANo,');
    Qrymain.sql.add('RA_InTransit       as RA_InTransit,');
    Qrymain.sql.add('RA_Returned        as RA_Returned,');
    Qrymain.sql.add('RA_SendToSupplier  as RA_SendToSupplier,');
    Qrymain.sql.add('RA_Testing         as RA_Testing,');
    Qrymain.sql.add('RA_WithSupplier    as RA_WithSupplier');
    Qrymain.sql.add('from ' + tablename +' T');
    clog(Qrymain.sql.text);
end;
procedure TProductListGUI.FormCreate(Sender: TObject);
begin
  HaveOnlyToDate['as On'] := True;
  dtFrom.date := 0;
  tablename := GetUserTemporaryTableName('ProductList');
  MakeQrymainSQL;
  //NoDateRange := true;
  fiProductcommissionEmployeeID := 0;
  fProductCommission := nil;
  inherited;
  //AddCalcColumn(qryMainValueAvg.FieldName     ,true);
  //AddCalcColumn(qryMainInStock.FieldName      ,False);
  //AddCalcColumn(qryMainSOBackOrders.FieldName ,False);
  //AddCalcColumn(qryMainAvailable.FieldName    ,False);
  AddCalcColumn(qryMainStockValue.FieldName   ,true);
  //AddCalcColumn(qryMainStockValueonLandedCost.FieldName   ,true);
  //AddCalcColumn(qryMainAllocatedSO.FieldName  ,False);
  //AddCalcColumn(qryMainAllocatedBO.FieldName  ,False);
  //AddCalcColumn(qryMainAllocatedSOBO.FieldName, False);
  //AddCalcColumn(qryMainOnOrder.FieldName      ,False);
  //AddCalcColumn(qryMainOnBuild.FieldName      ,False);
  //AddCalcColumn(qryMainBuilding.FieldName     ,False);
  //AddCalcColumn(qryMainOnTransit.FieldName     ,False);
  AddCalcColumn(qryMainSalesValue.FieldName   ,true);
  //AddCalcColumn(qryMainRA.FieldName   ,False);
  //AddCalcColumn(qryMainRA_AwaitingRANo.FieldName   ,False);
  //AddCalcColumn(qryMainRA_InTransit.FieldName      ,False);
  //AddCalcColumn(qryMainRA_Returned.FieldName       ,False);
  //AddCalcColumn(qryMainRA_SendToSupplier.FieldName ,False);
  //AddCalcColumn(qryMainRA_Testing.FieldName        ,False);
  //AddCalcColumn(qryMainRA_WithSupplier.FieldName   ,False);


  if  Assigned(Owner)  and not (AppEnv.CompanyPrefs.FastProductList) then begin
    // Since we are using product filtering, set the
    // flag to indicate that we want the search engine
    // and not the full list.
    fbEnableWebSearch      := true;
    fbStartinWebSearchMode := true;
  end else begin
    fbEnableWebSearch := not (AppEnv.CompanyPrefs.FastProductList);
  end;

  qryPartTypes.Connection := qryMain.Connection;
  ShowChartViewOnPopup := True;
  fProductlistmode := tNormalList;
  fProductGridDataSelect := nil;
  LastSelectedID:= 0;
  ShowControlhint(chkQtyOnTransit , 'Please Note that the List can be very slow with a big database when this option is choosen.'+NL+NL+'ERP stores the status of this option for the list.'+NL);
end;


procedure TProductListGUI.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(Tablename);
  inherited;
end;

procedure TProductListGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  if GuiPrefs.Node.Exists('Options') then begin
     chkBarCodes.Checked := GuiPrefs.Node['Options.BarCodes'].asBoolean;
     chkSetCommission.Checked := GuiPrefs.Node['Options.SetCommission'].asBoolean;
     chkBarInStock.Checked := GuiPrefs.Node['Options.BarInStock'].asBoolean;
     chkIsPercentage.Checked := GuiPrefs.Node['Options.IsPercentage'].asBoolean;
     edtBarQty.text := GuiPrefs.Node['Options.BarQty'].asString;
     edtRate.text := GuiPrefs.Node['Options.Rate'].asString;
  end;
end;
procedure TProductListGUI.WriteGuiPrefExtra;
begin
  inherited;
     GuiPrefs.Node['Options.BarCodes'].asBoolean        := chkBarCodes.Checked ;
     GuiPrefs.Node['Options.SetCommission'].asBoolean   := chkSetCommission.Checked ;
     GuiPrefs.Node['Options.BarInStock'].asBoolean      := chkBarInStock.Checked ;
     GuiPrefs.Node['Options.IsPercentage'].asBoolean    := chkIsPercentage.Checked ;
     GuiPrefs.Node['Options.BarQty'].asString           := edtBarQty.text ;
     GuiPrefs.Node['Options.Rate'].asString             := edtRate.text ;
     GuiPrefs.Node['Options.PartsID'].asInteger         := QrymainpartsID.asInteger;
end;

procedure TProductListGUI.OnRefreshQueryOutOfMemoryError(Sender: TObject);
begin
  if MessageDlgXP_Vista('The amount of data returned by this report is greater than the amount of memory Available, would you like to deactivate unused products.',mtInformation, [mbOK, mbCancel], 0) = mrOk then begin
    DeactivateUnusedProducts();
  end else begin
    MessageDlgXP_Vista('Please narrow down your selection by choosing active products only.',mtInformation, [mbOK], 0);
    if chkIgnoreDates.checked then chkIgnoreDates.checked  := False;
  end;
end;

procedure TProductListGUI.DeactivateUnusedProducts();
var
  fstableName : string;
  deactiveateDate : TDateTime;
begin
  fstableName := GetUserTemporaryTableName('TBLPARTS');
  deactiveateDate := Trunc(IncYear(Now, -4));
  if TfmDateInputBox.InputValue('Deactivation Date','Choose Deactivation Date',deactiveateDate, Self.Color) then begin
    With ScriptMain do try
      SQL.Clear;
      SQL.Add('DROP TABLE if EXISTS ' + fstableName + ';');
      SQL.Add('CREATE TABLE ' + fstableName);
      SQL.Add('SELECT P.PartsID, MAX(PQA.TransDate) TransDate');
      SQL.Add('FROM tblParts P INNER JOIN tblpqa PQA ON P.PartsID =PQA.ProductID');
      SQL.Add('GROUP BY P.PartsID HAVING TransDate<= "' + FormatDateTime('yyyy/mm/dd', deactiveateDate) + '"');
      SQL.Add('ORDER BY TransDate;');
      SQL.Add('ALTER TABLE '+ fstableName+' 	ADD INDEX `PartsID` (`PartsID`);');
      SQL.Add('UPDATE tblParts P INNER JOIN ' + fstableName + ' t ON P.PartsID = T.PartsID SET P.Active ="F";');
      SQL.Add('DROP TABLE IF EXISTS ' + fstableName + ';');
      DoShowProgressbar(3 , WAITMSG);
      try
        DoStepProgressbar;
        execute;
        DoStepProgressbar;
      finally
        DoHideProgressbar;
      end;
      grpfilters.itemindex:= 0;
    finally
      SQL.clear;
    end;
  end;
  MessageDlgXP_Vista('Before running this selection, please update and synchronize the report table using Batch Update.',mtInformation, [mbOK], 0);
end;

procedure TProductListGUI.RefreshQuery;
var
  TempcboFilterItemIndex: integer;
begin
  DoShowProgressbar(5 , WAITMSG);
  try
    TempcboFilterItemIndex := cboFilter.ItemIndex;
    cboFilter.Enabled := false;
    cboFilter.ItemIndex := TempcboFilterItemIndex;
    closedb(QryMain);
    inherited;
    if AppEnv.CompanyPrefs.ProductClassDefaultAll then begin
      qryMainVariancePriceInc.DisplayLabel := 'No Variance Price (Inc)';
    end else begin
      qryMainVariancePriceInc.DisplayLabel := appenv.Employee.DefaultClassName + DoTranslate(' Price (Inc)');
    end;

    PopulateFilterCombo;
    cboFilter.Enabled := true;
    cboFilter.ItemIndex := TempcboFilterItemIndex;
  finally
    DoHideProgressbar;
  end;
end;


function TProductListGUI.DefaultAllClasses: Integer;
begin
  result := inherited DefaultAllClasses;
  if result <0 then
    if not Appenv.CompanyPrefs.ProductClassDefaultAll then result := 2 ;
end;

procedure TProductListGUI.DNMSpeedButton3Click(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TPQAMovementGUI' , initPQAMovement);
end;
procedure TProductListGUI.dtToChange(Sender: TObject);
begin
  dtFrom.date := 0;
  inherited;
end;

procedure TProductListGUI.initPQAMovement(Sender:TObject);
begin
  if not(Sender is TPQAMovementGUI) then exit;
  TPQAMovementGUI(Sender).ProductId := qryMainPARTSID.AsInteger;
end;

procedure TProductListGUI.MakeQRYmain;
var
  s:String;
begin
with ScriptMain do begin
    with SQL do begin
      Clear;
      Add('/*1*/Drop table if exists ' + tablename +'; ');
      Add('/*2*/CREATE TABLE ' + tablename +'(  ' +
                ' GlobalRef             VARCHAR(255) DEFAULT NULL,  ' +
                ' ProductName           VARCHAR(60) DEFAULT NULL,  ' +
                ' PreferedSupplier      VARCHAR(60) DEFAULT NULL,  ' +
                ' ProductPrintName      VARCHAR(255) DEFAULT NULL,  ' +
                ' HasFormulaAttached    ENUM("T","F") DEFAULT "F",  ' +
                ' IncludeInAnalysis     ENUM("T","F") DEFAULT "F",  ' +
                ' MultipleBins          ENUM("T","F") DEFAULT "F",  ' +
                ' batch                 enum("F","T") DEFAULT "F",  ' +
                ' SNTracking            ENUM("T","F") DEFAULT "F",  ' +
                ' LandedCost            DOUBLE NOT NULL DEFAULT 0,  ' +
                ' ProductTypeCode       VARCHAR(13) DEFAULT NULL,  ' +
                ' FirstColumn           VARCHAR(255) DEFAULT NULL,  ' +
                ' SecondColumn          VARCHAR(255) DEFAULT NULL,  ' +
                ' ThirdColumn           VARCHAR(255) DEFAULT NULL,  ' +
                ' SalesDescription      VARCHAR(255) DEFAULT NULL,  ' +
(*                ' PARTSDESCRIPTION_Memo LONGTEXT,  ' +
                ' PURCHASEDESC_Memo     LONGTEXT,  ' +*)
                ' PRODUCTCOMMENT        VARCHAR(1000) DEFAULT NULL,  ' +
                ' CostIncA              DOUBLE NOT NULL DEFAULT 0,  ' +
                ' PriceIncA             DOUBLE NOT NULL DEFAULT 0,  ' +
                ' MarkupPercentage      DOUBLE NOT NULL DEFAULT 0,  ' +
                ' MarginMode            VARCHAR(12) NOT NULL DEFAULT "",  ' +
                ' InStock               DOUBLE  DEFAULT NULL,  ' +
                ' Available             DOUBLE  DEFAULT NULL,  ' +
                ' AllocatedSO           DOUBLE  DEFAULT NULL,  ' +
                ' AllocatedBO           DOUBLE  DEFAULT NULL,  ' +
                //' AllocatedSOBO         DOUBLE  DEFAULT NULL,  ' + // @@@
                ' OnOrder               DOUBLE  DEFAULT NULL,  ' +
                ' SOBackOrders          DOUBLE  DEFAULT NULL,  ' +
                ' OnBuild               DOUBLE  DEFAULT NULL,  ' +
                ' RA                    DOUBLE  DEFAULT NULL,  ' +
                ' Building              DOUBLE  DEFAULT NULL,  ' +
                ' VariancePriceInc      DOUBLE  DEFAULT NULL,  ' +
                ' OnTransit             DOUBLE  DEFAULT NULL,  ' +
                ' ProductType           VARCHAR(30) DEFAULT NULL,  ' +
                ' BuyQtyA               int(11) DEFAULT NULL,  ' +
                ' BuyQtyB               int(11) DEFAULT NULL,  ' +
                ' BuyQtyC               int(11) DEFAULT NULL,  ' +
                ' CostExA               DOUBLE NOT NULL DEFAULT 0,  ' +
                ' CostExB               DOUBLE NOT NULL DEFAULT 0,  ' +
                ' CostExC               DOUBLE NOT NULL DEFAULT 0,  ' +
                ' CostIncB              DOUBLE NOT NULL DEFAULT 0,  ' +
                ' CostIncC              DOUBLE NOT NULL DEFAULT 0,  ' +
                ' SellQtyA              INT(11) DEFAULT NULL,  ' +
                ' SellQtyB              INT(11) DEFAULT NULL,  ' +
                ' SellQtyC              INT(11) DEFAULT NULL,  ' +
                ' PriceExA              DOUBLE NOT NULL DEFAULT 0,  ' +
                ' PriceExB              DOUBLE NOT NULL DEFAULT 0,  ' +
                ' PriceExC              DOUBLE NOT NULL DEFAULT 0,  ' +
                ' PriceIncB             DOUBLE NOT NULL DEFAULT 0,  ' +
                ' PriceIncC             DOUBLE NOT NULL DEFAULT 0,  ' +
                ' WholesalePrice        DOUBLE NOT NULL DEFAULT 0,  ' +
                ' PurchaseDescription   VARCHAR(255) DEFAULT NULL,  ' +
                ' IncomeAccount         VARCHAR(50) DEFAULT NULL,  ' +
                ' AssetAccount          VARCHAR(50) DEFAULT NULL,  ' +
                ' CostofGoodsSoldAccount  VARCHAR(50) DEFAULT NULL,  ' +
                ' Barcode               VARCHAR(35) DEFAULT NULL,  ' +
                ' ProductCode           VARCHAR(255) DEFAULT NULL,  ' +
                ' Taxcode               VARCHAR(15) DEFAULT NULL,  ' +
                ' PurchaseTaxcode       VARCHAR(15) DEFAULT NULL,  ' +
                ' PreferredSupplier     VARCHAR(55) DEFAULT NULL,  ' +
                ' SpecialDiscount       ENUM("T","F") DEFAULT "F",  ' +
                ' PercentCost           DOUBLE DEFAULT NULL,  ' +
                ' Active                ENUM("T","F") DEFAULT "T",  ' +
                ' PARTSID               INT(11) NOT NULL DEFAULT 0,  ' +
                ' SalesTaxRate          DOUBLE default 0,  ' +
                ' PurchaseTaxRate       DOUBLE default 0,  ' +
                ' SupplierProductCode   VARCHAR(50) DEFAULT NULL,  ' +
                ' DateCreated           DATE DEFAULT NULL,  ' +
                ' DateUpdated           DATE DEFAULT NULL,  ' +
                ' Area                  VARCHAR(50) DEFAULT NULL,  ' +
                ' Discontinued          ENUM("T","F") DEFAULT "F",  ' +
                ' OnSpecial             ENUM("T","F") DEFAULT "F",  ' +
                ' AvgCost               DOUBLE  NOT NULL DEFAULT 0,  ' +
                ' CUSTFLD1              VARCHAR(255) DEFAULT NULL,  ' +
                ' CUSTFLD2              VARCHAR(255) DEFAULT NULL,  ' +
                ' CUSTFLD3              VARCHAR(255) DEFAULT NULL,  ' +
                ' CUSTFLD4              VARCHAR(255) DEFAULT NULL,  ' +
                ' CUSTFLD5              VARCHAR(255) DEFAULT NULL,  ' +
                ' CUSTFLD6              VARCHAR(255) DEFAULT NULL,  ' +
                ' CUSTFLD7              VARCHAR(255) DEFAULT NULL,  ' +
                ' CUSTFLD8              VARCHAR(255) DEFAULT NULL,  ' +
                ' CUSTFLD9              VARCHAR(255) DEFAULT NULL,  ' +
                ' CUSTFLD10             VARCHAR(255) DEFAULT NULL,  ' +
                ' CUSTFLD11             VARCHAR(255) DEFAULT NULL,  ' +
                ' CUSTFLD12             VARCHAR(255) DEFAULT NULL,  ' +
                ' CUSTFLD13             VARCHAR(255) DEFAULT NULL,  ' +
                ' CUSTFLD14             VARCHAR(255) DEFAULT NULL,  ' +
                ' CUSTFLD15             VARCHAR(255) DEFAULT NULL,  ' +
                ' CUSTDATE1             DATETIME DEFAULT NULL,  ' +
                ' CUSTDATE2             DATETIME DEFAULT NULL,  ' +
                ' CUSTDATE3             DATETIME DEFAULT NULL,  ' +
                ' IsSystemProduct       ENUM("T","F") DEFAULT "F",  ' +
                ' EnablePackWeight      ENUM("T","F") DEFAULT "F",  ' +
                ' Attrib1Sale           DOUBLE  DEFAULT "0.0000",  ' +
                ' Attrib2Sale           DOUBLE  DEFAULT "0.0000",  ' +
                ' Attrib1SaleRate       DOUBLE  DEFAULT "0.0000",  ' +
                ' Attrib1Purchase       DOUBLE  DEFAULT "0.0000",  ' +
                ' Attrib2Purchase       DOUBLE  DEFAULT "0.0000",  ' +
                ' Attrib1PurchaseRate   DOUBLE  DEFAULT "0.0000",  ' +
                ' Hire                  VARCHAR(1) NOT NULL DEFAULT "",  ' +
                ' ClassPriceVariance    Double,  ' +
                ' RA_AwaitingRANo       DOUBLE  DEFAULT "0.0000",  ' +
                ' RA_InTransit          DOUBLE  DEFAULT "0.0000",  ' +
                ' RA_Returned           DOUBLE  DEFAULT "0.0000",  ' +
                ' RA_SendToSupplier     DOUBLE  DEFAULT "0.0000",  ' +
                ' RA_Testing            DOUBLE  DEFAULT "0.0000",  ' +
                ' RA_WithSupplier       DOUBLE  DEFAULT "0.0000",  ' +
                ' PRIMARY KEY (PARTSID) ,  ' +
                ' index ProductTypeCode (ProductTypeCode)  ' +
                ' ) ENGINE=Myisam DEFAULT CHARSET=utf8; ');

      Add('/*3*/insert ignore into  ' + tablename +' (GlobalRef,ProductName,PreferedSupplier,ProductPrintName,HasFormulaAttached,IncludeInAnalysis,MultipleBins,batch,SNTracking, ');
      Add('LandedCost,ProductTypeCode,FirstColumn,SecondColumn,ThirdColumn,SalesDescription,');
      //Add('PARTSDESCRIPTION_Memo,PURCHASEDESC_Memo,');
      Add('PRODUCTCOMMENT, ');
      Add('CostIncA,PriceIncA,MarkupPercentage,MarginMode, ');
      Add('BuyQtyA,BuyQtyB,BuyQtyC,CostExA,CostExB,CostExC,CostIncB,CostIncC,SellQtyA,SellQtyB,SellQtyC,PriceExA,PriceExB,PriceExC, ');
      Add('PriceIncB,PriceIncC,WholesalePrice,PurchaseDescription,IncomeAccount,AssetAccount,CostofGoodsSoldAccount,Barcode,ProductCode,Taxcode,PurchaseTaxcode, ');
      Add('PreferredSupplier,SpecialDiscount,PercentCost,Active,PARTSID,SupplierProductCode,DateCreated,DateUpdated,Area,Discontinued,OnSpecial,AvgCost, ');
      Add('CUSTFLD1,CUSTFLD2,CUSTFLD3,CUSTFLD4,CUSTFLD5,CUSTFLD6,CUSTFLD7,CUSTFLD8,CUSTFLD9,CUSTFLD10,CUSTFLD11,CUSTFLD12,CUSTFLD13,CUSTFLD14,CUSTFLD15,CUSTDATE1,CUSTDATE2,CUSTDATE3, ');
      Add('IsSystemProduct,EnablePackWeight,Attrib1Sale,Attrib2Sale,Attrib1SaleRate,Attrib1Purchase,Attrib2Purchase,Attrib1PurchaseRate,Hire) ');
      Add('SELECT P.GlobalRef  as GlobalRef, ');
      Add('P.PARTNAME  as ProductName, ');
      Add('P.PREFEREDSUPP  as PreferedSupplier, ');
      Add('P.ProductPrintName  as ProductPrintName, ');
      //Add('P.HasFormulaAttached, ');
      Add('if(ifnull(P.FormulaID,0)>0,"T","F") as HasFormulaAttached, ');
      Add('P.IncludeInAnalysis, ');
      Add('P.MultipleBins MultipleBins, ');
      Add('P.batch batch, ');
      Add('P.SNTracking SNTracking, ');
      Add('P.LandedCost  as "LandedCost", ');
      Add('P.PARTTYPE  as ProductTypeCode, ');
      Add(Firstcolumn + '  as FirstColumn, ');
      Add(Secondcolumn+ '  as SecondColumn, ');
      Add(Thirdcolumn + '  as ThirdColumn, ');
      Add('P.PARTSDESCRIPTION  as SalesDescription, ');
(*      Add('P.PARTSDESCRIPTION_Memo  as PARTSDESCRIPTION_Memo, ');
      Add('P.PURCHASEDESC_Memo  as PURCHASEDESC_Memo, ');*)
      Add('P.PRODUCTCOMMENT  as PRODUCTCOMMENT, ');
      Add('P.COSTINC1   as "CostIncA", ');
      Add('P.PRICEINC1  as "PriceIncA", ');
      Add('P.Sell_Cost_Percentage  as MarkupPercentage, ');
      Add('if(P.GrossMarginMode="T","Markup" , "Gross Margin")  as MarginMode,  ');
      Add('P.BuyQTY1  as "BuyQtyA", ');
      Add('P.BuyQTY2  as "BuyQtyB", ');
      Add('P.BuyQTY3  as "BuyQtyC", ');
      Add('P.COST1  as "CostExA", ');
      Add('P.COST2  as "CostExB", ');
      Add('P.COST3  as "CostExC", ');
      Add('P.COSTINC2  as "CostIncB", ');
      Add('P.COSTINC3  as "CostIncC", ');
      Add('P.SellQTY1  as "SellQtyA", ');
      Add('P.SellQTY2  as "SellQtyB", ');
      Add('P.SellQTY3  as "SellQtyC", ');
      Add('P.PRICE1  as "PriceExA", ');
      Add('P.PRICE2  as "PriceExB", ');
      Add('P.PRICE3  as "PriceExC", ');
      Add('P.PRICEINC2  as "PriceIncB", ');
      Add('P.PRICEINC3  as "PriceIncC", ');
      Add('P.WHOLESALEPRICE  as "WholesalePrice", ');
      Add('P.PURCHASEDESC  as "PurchaseDescription", ');
      Add('P.INCOMEACCNT  as "IncomeAccount", ');
      Add('P.ASSETACCNT  as "AssetAccount", ');
      Add('P.COGSACCNT  as "CostofGoodsSoldAccount", ');
      Add('P.BARCODE  as "Barcode", ');
      Add('P.PRODUCTCODE  as "ProductCode", ');
      Add('P.TAXCODE  as "Taxcode", ');
      Add('P.PURCHTAXCODE  as "PurchaseTaxcode", ');
      Add('P.PREFEREDSUPP  as "PreferredSupplier", ');
      Add('P.SpecialDiscount  as "SpecialDiscount", ');
      Add('((P.PRICE1 - P.COST1)/P.COST1)*100  as "PercentCost", ');
      Add('P.Active  as Active, ');
      Add('P.PARTSID  as PARTSID, ');
      Add('P.SupplierProductCode  as SupplierProductCode, ');
      Add('P.DateCreated  as DateCreated, ');
      Add('P.DateUpdated  as DateUpdated, ');
      Add('P.Area  as Area, ');
      Add('P.Discontinued  as Discontinued, ');
      Add('P.OnSpecial  as OnSpecial, ');
      Add('P.AvgCost  as AvgCost, ');
      Add('P.CUSTFLD1  as CUSTFLD1, ');
      Add('P.CUSTFLD2  as CUSTFLD2, ');
      Add('P.CUSTFLD3  as CUSTFLD3, ');
      Add('P.CUSTFLD4  as CUSTFLD4, ');
      Add('P.CUSTFLD5  as CUSTFLD5, ');
      Add('P.CUSTFLD6  as CUSTFLD6, ');
      Add('P.CUSTFLD7  as CUSTFLD7, ');
      Add('P.CUSTFLD8  as CUSTFLD8, ');
      Add('P.CUSTFLD9  as CUSTFLD9, ');
      Add('P.CUSTFLD10  as CUSTFLD10, ');
      Add('P.CUSTFLD11  as CUSTFLD11, ');
      Add('P.CUSTFLD12  as CUSTFLD12, ');
      Add('P.CUSTFLD13  as CUSTFLD13, ');
      Add('P.CUSTFLD14  as CUSTFLD14, ');
      Add('P.CUSTFLD15  as CUSTFLD15, ');
      Add('P.CUSTDATE1  as CUSTDATE1, ');
      Add('P.CUSTDATE2  as CUSTDATE2, ');
      Add('P.CUSTDATE3  as CUSTDATE3, ');
      Add('P.IsSystemProduct  as IsSystemProduct, ');
      Add('P.EnablePackWeight  as EnablePackWeight, ');
      Add('P.Attrib1Sale  as Attrib1Sale, ');
      Add('P.Attrib2Sale  as Attrib2Sale, ');
      Add('P.Attrib1SaleRate  as Attrib1SaleRate, ');
      Add('P.Attrib1Purchase  as Attrib1Purchase, ');
      Add('P.Attrib2Purchase  as Attrib2Purchase, ');
      Add('P.Attrib1PurchaseRate  as Attrib1PurchaseRate, ');
      Add('"F"  as Hire ');
      Add('FROM tblParts  as P ');
      if SelectedClassID <> 0 then Add('inner join tblproductclasses PC on P.partsId = PC.productid and PC.ClassID = ' + inttostr(SelectedClassID ));

      Add('WHERE char_length(P.PARTNAME)>0 AND not IsNull(P.PARTNAME)  ');

      if grpfilters.itemindex =0 then add('And P.Active ="T"')
      else if grpfilters.itemindex =1 then add('And P.Active ="F"');

      Add('GROUP BY P.PARTSID ');
      if QueryManipulationObj.Searchcondition <> '' then Add('having ' + QueryManipulationObj.Searchcondition);
      if IsLimit0selection  then Add('LIMIT 0');
      Add('; ');

      { 14 Nov 2017 IJB - removed the following because we seem to be adding tax to a Inc price / cost?
                          also PriceIncC calc is adding CostInc tax ?? }
//      Add('/*4*/update ' + tablename +' P Inner JOIN tbltaxcodes  as Tax ON Tax.Name = P.TAXCODE AND Tax.RegionID         = ' + IntToStr(AppEnv.RegionalOptions.ID)+' Set SalesTaxRate = Tax.Rate , '+
//                                                    ' PriceIncA =  PriceIncA + (PriceIncA * ifnull(Tax.Rate,0)) , ' +
//                                                    ' PriceIncB =  PriceIncB + (PriceIncB * ifnull(Tax.Rate,0)) , ' +
//                                                    ' PriceIncC =  PriceIncC + (CostIncC * ifnull(Tax.Rate,0)); ');
//
//      Add('/*5*/update ' + tablename +' P Inner JOIN tbltaxcodes  as Tax ON Tax.Name = P.PurchaseTaxcode AND Tax.RegionID = ' + IntToStr(AppEnv.RegionalOptions.ID)+' Set PurchaseTaxRate = Tax.Rate , '+
//                                                    ' CostIncA =  CostIncA + (CostIncA * ifnull(Tax.Rate,0)) , ' +
//                                                    ' CostIncB =  CostIncB + (CostIncB * ifnull(Tax.Rate,0)) , ' +
//                                                    ' CostIncC =  CostIncC + (CostIncC * ifnull(Tax.Rate,0)); ');

      Add('/*6*/update ' + tablename +' P inner join tblProductClasses PC on P.partsId = Pc.productId set P.ClassPriceVariance = PC.ClassPriceVariance; ');

      Add('/*7*/update ' + tablename +' P inner join tblparttypes PT on PT.TypeCode = P.ProductTypeCode  Set P.ProductType = PT.TypeDesc;');


      if not AppEnv.CompanyPrefs.FastProductList then begin
          Add('/*8*/Drop table if exists ' + tablename +'1; ');

          Add('/*9*/CREATE TABLE ' + tablename +'1 (   ' +
               ' ID               INT(11) NOT NULL AUTO_INCREMENT,  ' +
               ' partsId          INT(11) DEFAULT NULL, ' +
               ' InStock          DOUBLE  DEFAULT NULL, ' +
               ' Available        DOUBLE  DEFAULT NULL, ' +
               ' AllocatedSO      DOUBLE  DEFAULT NULL, ' +
               ' AllocatedBO      DOUBLE  DEFAULT NULL, ' +
               //' AllocatedSOBO    DOUBLE  DEFAULT NULL, ' + // @@@
               ' OnOrder          DOUBLE  DEFAULT NULL, ' +
               ' SOBackOrders     DOUBLE  DEFAULT NULL, ' +
               ' OnBuild          DOUBLE  DEFAULT NULL, ' +
               ' Building         DOUBLE  DEFAULT NULL, ' +
               ' VariancePriceInc DOUBLE  DEFAULT NULL,  ' +
               ' OnTransit        DOUBLE  DEFAULT NULL,  ' +
               ' RA               DOUBLE  DEFAULT NULL, ' +
               ' PRIMARY KEY (ID) ,  ' +
               ' Index PartsId (PartsID)  ' +
               ' ) ENGINE=MyIsam DEFAULT CHARSET=utf8; ');


          Add('/*10*/insert into ' + tablename +'1 (PartsID , InStock,Available,AllocatedSO,AllocatedBO,OnOrder,SOBackOrders,OnBuild,Building,VariancePriceInc,OnTransit,RA) ');
          Add('select ');
          Add('P.partsId , ');
          Add( 'Round(IF(P.ProductTypeCode = "INV",' +ProductQtylib.SQL4Qty(tInstock   ) +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')  as "InStock",');
          if AppEnv.CompanyPrefs.CountSOBOInAvailable  then begin
                   Add( 'Round(IF(P.ProductTypeCode = "INV",' +ProductQtylib.SQL4Qty(tAvailable ) +' - ' +
                                                        ProductQtylib.SQL4Qty(tsobo ) +',0.0), ' + IntToStr(tcConst.GeneralRoundPlaces)+')  as "Available",');
          end else Add( 'Round(IF(P.ProductTypeCode = "INV",' +ProductQtylib.SQL4Qty(tAvailable ) +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')  as "Available",');

          Add( 'Round(IF(P.ProductTypeCode = "INV",' +ProductQtylib.SQL4Qty(tSO        ) +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')  as "AllocatedSO",');
          Add( 'Round(IF(P.ProductTypeCode = "INV",' +ProductQtylib.SQL4Qty(tInvBO     ) +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')  as "AllocatedBO",');
          Add( 'Round(IF(P.ProductTypeCode = "INV",' +ProductQtylib.SQL4Qty(tPOBO      ) +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')  as "OnOrder",');
          Add( 'Round(IF(P.ProductTypeCode = "INV",' +ProductQtylib.SQL4Qty(tSOBO      ) +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')  as "SOBackOrders",');
          Add( 'Round(IF(P.ProductTypeCode = "INV",' +ProductQtylib.SQL4Qty(tOnBuild   ) +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')  as "OnBuild",');
          Add( 'Round(IF(P.ProductTypeCode = "INV",' +ProductQtylib.SQL4Qty(tBuilding  ) +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')  as "Building",');
          Add('if(' +Quotedstr(BooleanToStr(AppEnv.CompanyPrefs.ProductClassDefaultAll and AllClasses))+'= "T" , PriceExA + (PriceExA* ifnull(salesTaxRate,0)) , (PriceExA + (PriceExA * (ClassPriceVariance/100))) + ((PriceExA + (PriceExA * (ClassPriceVariance/100)))* ifnull(salesTaxRate,0)))  as VariancePriceInc,');
          Add('if(' +Quotedstr(BooleanToStr(ShowQtyOnTransit))+'<>"T" ,0.0 ,  Round(ifnull(IF(P.ProductTypeCode = "INV",' + pqalib.SQL4QtyField(tOnTransitOUT, 'STPQA' , 'STPQA.QTY') +',0.0),0),' + IntToStr(tcConst.GeneralRoundPlaces)+'))  as "OnTransit", ');
          Add( 'Round(IF(P.ProductTypeCode = "INV",' +ProductQtylib.SQL4Qty(tRA_All   ) +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')  as "RA"');
          Add('from ' + tablename +' P ');
          Add('left join tblPQA  as PQA on P.partsId = PQA.ProductID and PQA.transdate <=' + Quotedstr(formatdatetime( MysqlDateTimeFormat , FilterdateTo)));
          if SelectedClassID <> 0 then Add(' and PQA.DepartmentID = ' + inttostr(SelectedClassID ));
          Add('group by p.partsId; ');

          Add('/*11*/update ' + tablename +' t1 inner join ' + tablename +'1 t2 on t1.partsId = t2.partsId ');
          Add('Set ');
          Add('T1.InStock = t2.InStock, ');
          Add('T1.Available = t2.Available, ');
          Add('T1.AllocatedSO = t2.AllocatedSO, ');
          Add('T1.AllocatedBO = t2.AllocatedBO, ');
          //Add('T1.AllocatedSOBO = T2.AllocatedSOBO, ');
          Add('T1.OnOrder = t2.OnOrder, ');
          Add('T1.SOBackOrders = t2.SOBackOrders, ');
          Add('T1.OnBuild = t2.OnBuild , ');
          Add('T1.Building = t2.Building, ');
          Add('T1.VariancePriceInc = t2.VariancePriceInc, ');
          Add('T1.RA = t2.RA, ');
          Add('T1.OnTransit = t2.OnTransit; ');
          Add('Drop table if exists ' + tablename +'1; ');

      end;
      // Remove Qtys from OnOrder for FuturePOs
      Add('/*12*/Drop table if exists ' + tablename +'1; ');

      Add('/*13*/Create table ' + tablename +'1  ');
          Add('select ');
          Add('P.partsId , ');
          Add( 'Round(IF(P.ProductTypeCode = "INV",' +ProductQtylib.SQL4Qty(tPOBO      ) +',0.0),' + IntToStr(tcConst.GeneralRoundPlaces)+')  as "OnOrder"');
          Add('from ' + tablename +' P ');
          Add('inner join tblPQA  as PQA on P.partsId = PQA.ProductID and PQA.TransType="TPurchaseOrderLine" and PQA.transdate <=' + Quotedstr(formatdatetime( MysqlDateTimeFormat , FilterdateTo)));
          Add('inner join tblPurchaseOrders PO on PO.PurchaseOrderId=PQA.transId and PO.FuturePO="T"  ');
          if SelectedClassID <> 0 then Add(' and PQA.DepartmentID = ' + inttostr(SelectedClassID ));
          Add('group by p.partsId; ');

      Add('/*14*/update ' + tablename +' t1 inner join ' + tablename +'1 t2 on t1.partsId = t2.partsId ');
      Add('Set  T1.OnOrder = T1.OnOrder - t2.OnOrder; ');


      // remove from Available Return Authorities that are not yet in tblPQA
      s:=   'Drop table if exists ' + tablename +'1; ' +
            'Create table ' + tablename +'1  ' +
            ' select RAL.productId, sum(RAL.Shipped)  as Shipped  ' +
            ' from '+tablename +' T ' +
            ' inner join tblPurchaseLines RAL on RAL.productId = T.partsID and RAL.RAStatus =:RAStatus ' +
             iif(SelectedClassID <> 0 , ' and RAL.ClassID = ' + inttostr(SelectedClassID ) , '')  +
            ' inner join tblPurchaseOrders RA on RA.PurchaseOrderId=RAL.PurchaseOrderId  and RA.isRA ="T" ' +
            ' Left join tblPurchaseOrders PO on PO.RaRef = RA.globalref ' +
            ' where ifnull(PO.PurchaseOrderId,0)=0 ' +
            ' group by ProductId; ' +
            ' update ' + tablename +' t1 inner join ' + tablename +'1 t2 on t1.partsId = t2.ProductId  ' +
            ' Set  T1.:RACountfield = 0-T2.Shipped ;  ' ;

      Add('/*15-1*/ '+ ReplaceStr(ReplaceStr(s ,':RAStatus' , quotedstr(RALineStatus_Awaiting_RA_No  )), ':RACountfield' , 'RA_AwaitingRANo'   )+'');

      Add('/*15-2*/ '+ ReplaceStr(ReplaceStr(s ,':RAStatus' , quotedstr(RALineStatus_In_Transit      )), ':RACountfield' , 'RA_InTransit'      )+'');

      Add('/*15-3*/ '+ ReplaceStr(ReplaceStr(s ,':RAStatus' , quotedstr(RALineStatus_Returned        )), ':RACountfield' , 'RA_Returned'       )+'');

      Add('/*15-4*/ '+ ReplaceStr(ReplaceStr(s ,':RAStatus' , quotedstr(RALineStatus_Send_To_Supplier)), ':RACountfield' , 'RA_SendToSupplier' )+'');

      Add('/*15-5*/ '+ ReplaceStr(ReplaceStr(s ,':RAStatus' , quotedstr(RALineStatus_Testing         )), ':RACountfield' , 'RA_Testing'        )+'');

      Add('/*15-6*/ '+ ReplaceStr(ReplaceStr(s ,':RAStatus' , quotedstr(RALineStatus_With_Supplier   )), ':RACountfield' , 'RA_WithSupplier'   )+'');

      Add('/*16  */Drop table if exists ' + tablename +'1; ');

    end;

    SQL.text := ChangeQuery(SQL.text);
    clog(SQLText);
    fbHasSQLError := False;
    ShowProgressbar(WAITMSG, SQL.Count);
    try
      Execute;
      if fbHasSQLError then
        MessageDlgXP_Vista('Please Run Update Batch To Update the Report Tables', mtWarning, [mbOK], 0);
    finally
      HideProgressbar;
      fbHasSQLError := False;
    end;

end;
end;


procedure TProductListGUI.chkBarCodesClick(Sender: TObject);
begin
  inherited;
  Setbuttons(chkBarCodes.checked , pnlBarCode);
  pnlAdvPrinting.visible :=chkBarCodes.checked;
  if chkBarCodes.checked then
    chkSetCommission.checked:= False;
end;

procedure TProductListGUI.actBarCodesUpdate(Sender: TObject);
begin
  inherited;
  actBarCodes.Enabled := true; //chkBarCodes.Checked or chkSetCommission.Checked or chkSetPoints.Checked;
end;

procedure TProductListGUI.actBarCodesExecute(Sender: TObject);
begin
  inherited;
  if not printingBarcodes then begin
    DeactivateUnusedProducts();
  end else begin
    if grdMain.SelectedList.Count = 0 then begin
      CommonLib.MessageDlgXP_Vista('No products have been selected.  Please Hold Down Ctrl to Select Multiple Entries.', mtInformation, [mbOK], 0);
      Exit;
    end;

    if chkSetCommission.Checked then begin
      SetCommissions;
    end else if chkSetPoints.Checked then begin
      SetPoints;
    end else begin
      PrintBarCodes;
    end;
  end;
end;

procedure TProductListGUI.chkBarInStockClick(Sender: TObject);
begin
  inherited;
  edtBarQty.Text := '1';
  edtBarQty.Enabled := not chkBarInStock.Checked;
  udBarQty.Enabled := not chkBarInStock.Checked;
end;

procedure TProductListGUI.actExecuteFilterExecute(Sender: TObject);
begin
  inherited;
  grpFiltersClick(nil);
  if AppEnv.CompanyPrefs.FastProductList then begin
    RefreshQuery;
  end;
end;

procedure TProductListGUI.actClearFilterExecute(Sender: TObject);
begin
  inherited;
  qryMain.Filter := '';
  grpFiltersClick(nil);
  if AppEnv.CompanyPrefs.FastProductList then begin
    RefreshQuery;
  end;
end;

procedure TProductListGUI.edtSearchChange(Sender: TObject);
begin
  if not AppEnv.CompanyPrefs.FastProductList then begin
    inherited;
  end else begin
    RefreshQuery;
    qryMain.IndexFieldNames := TField(cboFilter.Items.Objects[cboFilter.ItemIndex]).FieldName + ' ASC CIS';
  end;
end;

procedure TProductListGUI.edtSearchKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_TAB then begin
    if edtSearch.Text <> '' then begin
      // Perform Search.
      GoSearch;

      // Was there any records found?
      if qryMain.RecordCount > 0 then begin
        // Yes, set the first record active.
        SetControlFocus(grdMain);
        grdMain.SetActiveRow(0);
      end;
    end;

    // Clear Keycode.
    Key := 0;
    Exit;
  end;
end;


procedure TProductListGUI.edtSearchExit(Sender: TObject);
begin
  inherited;
  //
end;
procedure TProductListGUI.BeforePopup(Popupform:TComponent);
begin
    if Popupform is TfrmProductSOInfoGUI then begin
      if Sametext(ActiveFieldName, qryMainAllocatedSO.fieldName ) then
        TfrmProductSOInfoGUI(Popupform).IsBO:= False
      else if  Sametext(ActiveFieldName, qryMainSOBackOrders.fieldName ) then
        TfrmProductSOInfoGUI(Popupform).IsBO:= True;
    end;
end;
procedure TProductListGUI.grdMainCalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
      if AppEnv.CompanyPrefs.FastProductList and (Sametext(Field.fieldname , Qrymaininstock.fieldname            ) or
                                                  Sametext(Field.fieldname , QrymainAvailable.fieldname          ) or
                                                  Sametext(Field.fieldname , QrymainAllocatedSO.fieldname        ) or
                                                  Sametext(Field.fieldname , QrymainAllocatedBO.fieldname        ) or
                                                  //Sametext(Field.fieldname , QrymainAllocatedSOBO.fieldname    ) or
                                                  Sametext(Field.fieldname , QrymainOnOrder.fieldname            ) or
                                                  Sametext(Field.fieldname , QrymainSOBackOrders.fieldname       ) or
                                                  Sametext(Field.fieldname , QrymainOnBuild.fieldname            ) or
                                                  Sametext(Field.fieldname , QrymainBuilding.fieldname           ) or
                                                  Sametext(Field.fieldname , QrymainVariancePriceInc.fieldname   ) or
                                                  Sametext(Field.fieldname , QrymainRA.fieldname                 ) or
                                                  Sametext(Field.fieldname , QrymainOnTransit.fieldname          ) or
                                                  Sametext(Field.fieldname , QrymainRA_AwaitingRANo.fieldname    ) or
                                                  Sametext(Field.fieldname , QrymainRA_InTransit.fieldname       ) or
                                                  Sametext(Field.fieldname , QrymainRA_Returned.fieldname        ) or
                                                  Sametext(Field.fieldname , QrymainRA_SendToSupplier.fieldname  ) or
                                                  Sametext(Field.fieldname , QrymainRA_Testing.fieldname         ) or
                                                  Sametext(Field.fieldname , QrymainRA_WithSupplier.fieldname)) then begin
        ABrush.Color := Inactivefontcolor ;
        AFont.Color := Inactivefontcolor;
      end;
end;

procedure TProductListGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: boolean; var Accept: boolean);
begin
  inherited;
  LastSelectedID:= qryMain.FieldByName('PARTSID').AsInteger;
  if chkBarCodes.Checked or chkSetCommission.Checked or chkSetPoints.Checked then Exit;
end;
Function TProductListGUI.ProductHasPQA(const ProductId:Integer):boolean;
begin
  with tempmyQuery do try
    SQL.add('select * from tblPQa where ProductId = ' + inttostr(PRoductID) +' limit 1');
    open;
    result := recordcount >0;
  finally
    ClosenFree;
  end;
end;
procedure TProductListGUI.actMergeExecute(Sender: TObject);
var
  i: integer;
  MergeObj: TMergeObj;
  SecordaryName: string;
  SecordaryID: integer;
  msg: string;
begin
  inherited;
  if grdMain.SelectedList.Count = 1 then begin
    CommonLib.MessageDlgXP_Vista('Please select at least two (2) Product.' + #13 + #10 +
      '(Hold down ''CTRL'' and click on row to toggle selection.)',
      mtInformation, [mbOK], 0);
    exit;
  end;

    qryMain.Locate('PARTSID', LastSelectedID, [loCaseInsensitive]);
    PrincipleProductforMergeName := GetPartName(QrymainPArtsID.AsInteger);
    PrincipleProductforMergeID   := QrymainPArtsID.AsInteger;
    PrincipleProductforMergeType := qryMain.FieldByName('ProductTypeCode').AsString;

    PrincipleProductforMergebin  := qryMainMultipleBins.asBoolean;
    PrincipleProductforMergebatch:= qryMainBatch.asBoolean;
    PrincipleProductforMergesrno := qryMainSNTracking.asBoolean;

    IterateProcNo := 1;
    IterateselectedRecordsReverse(true, WaitMsg);

    if grdMain.SelectedList.Count = 1 then exit;
    if CommonLib.MessageDlgXP_Vista('Are you sure want to merge these Products into ' + PrincipleProductforMergeName, mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
      for i := 0 to grdMain.SelectedList.Count - 1 do begin
        qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
        if QrymainPArtsID.AsInteger = PrincipleProductforMergeID then
          continue;
        SecordaryName := GetPartName(QrymainPArtsID.AsInteger);
        SecordaryID := QrymainPArtsID.AsInteger;
        // Ensure there is only one user connected to the database.  That is You only!
        if AppEnv.UtilsClient.LockLogon(msg,AppEnv.AppDb.Database, 'Performing a Merge Product') then begin
          try
            MergeObj := TMergeObj.Create;
            try
              MergeObj.Merge(mProduct, PrincipleProductforMergeName, PrincipleProductforMergeID, SecordaryName, SecordaryID);
            finally
              MergeObj.Free;
            end;
          finally
            AppEnv.UtilsClient.UnlockLogon;
          end;
        end
        else begin
          if msg = USERS_IN_SYSTEM_MESSAGE then begin
            MainForm.GetCurrentUserCount;
            dtmMainGUI.dlgCurrentUsers.Caption := qryMain.Connection.Database + ' Merge Product';
            dtmMainGUI.dlgCurrentUsers.Color := pnlHeader.Color;
            dtmMainGUI.dlgCurrentUsers.Message := 'The following user(s) must exit the system.';
            dtmMainGUI.dlgCurrentUsers.Execute;
          end
          else begin
            MessageDlgXP_Vista('Unable to merge Products, Unable to Lock User Logon: ' + msg, mtInformation, [mbOk], 0);
          end;
        end;
      end;
    end;
    grdMain.SelectedList.Clear;

    UpdateMe;
end;
procedure TProductListGUI.IterateselectedRecordsCallback(var Abort: boolean;SelIndex:Integer);
begin
  if IterateProcNo = 1 then begin
    if QrymainPArtsID.AsInteger <> PrincipleProductforMergeID then begin
        if PrincipleProductforMergeType <> qryMain.FieldByName('ProductTypeCode').AsString then begin
           grdmain.UnselectRecord;
           CommonLib.MessageDlgXP_Vista('Can''t merge ' +Quotedstr(qryMainProductName.asString) +' to ' + quotedstr(PrincipleProductforMergeName) +' as the Product Type is different!', mtInformation, [mbOK], 0);
        end;
        if (PrincipleProductforMergebin <> qryMainMultipleBins.asBoolean) or (PrincipleProductforMergebatch <> qryMainBatch.asBoolean) or (PrincipleProductforMergesrno <> qryMainSNTracking.asBoolean) then begin
           if ProductHasPQA(QrymainPArtsID.asInteger) then begin
              grdmain.UnselectRecord;
              CommonLib.MessageDlgXP_Vista('Can''t merge ' +Quotedstr(qryMainProductName.asString) +' to ' + quotedstr(PrincipleProductforMergeName) +' as the Allocation Paramater(s) are different!', mtInformation, [mbOK], 0);
           end;
        end;
      end;
      Exit;
  end;
  inherited;
end;

procedure TProductListGUI.chkSetCommissionClick(Sender: TObject);
begin
  inherited;
  if Productlistmode = tCommissionList then
  Setbuttons(chkSetCommission.checked, pnlCommission)
  else if Productlistmode = tMultiplecommission then
  Setbuttons(chkSetCommission.checked, nil);
  Setbuttons(chkBarCodes.checked , pnlBarCode);
  pnlAdvPrinting.visible :=chkBarCodes.checked;
  if chkSetCommission.checked then
    chkBarCodes.checked := False;
end;

procedure TProductListGUI.edtRateKeyPress(Sender: TObject; var Key: char);
begin
  inherited;
  Key := CommonLib.NumCharOnly(Key);
end;

procedure TProductListGUI.SetCommissions;
begin
  if Assigned(fProductGridDataSelect) then begin
    fProductGridDataSelect(grdmain);
    Self.close;
  end else begin
    SetProductcommission;
  end;
end;
procedure TProductListGUI.SetProductcommission;
var
  i: integer;
  PC:TProductCommission;
  Procedure createProductCommission;
  begin

  end;
begin
  PC := TProductCommission.create(Self);
  try
    PC.connection := TMyDacDataConnection.Create(PC);
    PC.Connection.Connection := CommonDbLib.GetNewMyDacConnection(PC);
    PC.Connection.BeginTransaction;
    NewProgressdialog(' Setting Commissions' ,grdMain.SelectedList.Count);
    try
    for i := 0 to grdMain.SelectedList.Count - 1 do begin
      StepProgressdialog;
      qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
      PC.LoadSelect('PartsID = ' +IntToStr(QrymainPartsID.asInteger)+' and employeeId = ' +IntToStr(ProductcommissionEmployeeID));
      if PC.count > 0 then begin
        if PC.Lock = False then begin
            PC.ResultStatus.addItem(False, rssWarning , 0 , StringReplace(PC.UserLock.LockMessage , 'Unable to update data.' , 'Unable to update the Commission Rate of ' +qryMainProductName.asString +'.', [rfIgnoreCase]));
            Continue;
        end;
      end else begin
        PC.New;
        PC.PartsId    := qryMainPARTSID.asInteger;
        PC.employeeID := ProductcommissionEmployeeID;
        PC.Partname   := qryMainProductName.asString;
        PC.ForAllEmployees := False;
      end;
      PC.CommissionRate := StrToFloat(edtRate.text);
      PC.IsPercentage := chkIsPercentage.checked;
      PC.PostDB;
    end;
    finally
      KillProgressdialog;
    end;
    PC.Connection.CommitTransaction;
    MessageDlgXP_Vista(IntToStr(grdMain.SelectedList.Count)+' Products updated.', mtInformation , [mbok], 0 );
    PC.UserLock.Unlock(PC.BusObjectTypeDescription);
  finally
    freeandNil(PC);
    grdmain.UnselectAll;
    if fProductCommission <> nil then fProductCommission.refreshDB;
  end;
end;

procedure TProductListGUI.SetPoints;
begin
  if Assigned(fProductGridDataSelect) then begin
    fProductGridDataSelect(grdmain);
    Self.close;
  end;
end;


// -----------------------------------------------------------------------------

procedure TProductListGUI.chkIsPercentageClick(Sender: TObject);
begin
  inherited;
  if chkIsPercentage.Checked then lblRateType.Caption := '%'
  else lblRateType.Caption := AppEnv.RegionalOptions.CurrencySymbol;
end;
procedure TProductListGUI.RefreshTotals;
begin
  inherited;
  CalcnShowfooter;
end;

procedure TProductListGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainStockValue.asfloat := qryMainInStock.asfloat * qryMainCostExA.asFloat;
  qryMainStockValueonLandedCost.asfloat := qryMainInStock.asfloat * qryMainLandedCost.asFloat;
  qryMainValueAvg.asfloat   := qryMainInStock.asfloat * qryMainAvgCost.asFloat;
  qryMainSalesValue.asfloat := qryMainInStock.asfloat * qryMainPriceIncA.asfloat;
end;


procedure TProductListGUI.btnProductcommissionListClick(Sender: TObject);
var
  form :TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TProductCommissionListGUI');
  if not assigned(Form) then Exit;
  TProductCommissionListGUI(form).FormStyle := fsmdichild;
  TProductCommissionListGUI(form).BringToFront;
end;

procedure TProductListGUI.btnReorderLevelsClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TfmReorderLevels');
end;

procedure TProductListGUI.SetGridColumns;
begin
  inherited;
  SetUpcustomFields('Product');
  RemoveFieldfromGrid(QrymainpartsId.fieldname);
  RemoveFieldfromGrid(QrymainHire.fieldname);
end;

procedure TProductListGUI.setProductlistmode(
  const Value: TProductlistmode);
begin
  fProductlistmode := Value;

  if fProductlistmode = tNormalList     then btnBarCodes.Caption := 'Print &Barcodes';
  if fProductlistmode in [ tCommissionList, tMultiplecommission] then btnBarCodes.Caption := 'Set Commsn';
  if fProductlistmode = tSetPoints      then btnBarCodes.Caption := 'Set Points';

  chkBarCodes.enabled   :=fProductlistmode = tNormalList;
  //lblchkbarcode.enabled :=fProductlistmode = tNormalList;

  chkSetCommission.enabled :=fProductlistmode = tCommissionList;
  chkSetCommission.checked :=fProductlistmode in [tCommissionList, tMultiplecommission];
  //lblSetCommission.enabled :=fProductlistmode = tCommissionList;


  chkSetPoints.enabled :=fProductlistmode = tSetPoints;
  chkSetPoints.checked :=fProductlistmode = tSetPoints;
  lblSetPoints.enabled :=fProductlistmode = tSetPoints;
  chkSetPoints.checked :=fProductlistmode = tSetPoints;
  if fProductlistmode = tSetPoints then   Setbuttons(True , nil);
  if fProductlistmode = tSetPoints then
        FilterString := 'Productname  <> ' +quotedStr(REDEEM_POINTS);

end;

procedure TProductListGUI.SctMainError(Sender: TObject; E: Exception;SQL: string; var Action: TErrorAction);
begin
  inherited;
  Action :=eaContinue ;
  fbHasSQLError := TRue;
end;

procedure TProductListGUI.Setbuttons(const Value: Boolean; DetailPanel:TDnMPanel);
begin
  btnCustomize.Enabled  := not Value;
  cmdExport.Enabled     := not Value;
  cmdNew.Enabled        := not value;
  cmdPrint.Enabled      := not value;
  LblNote.Visible      := not value;  // "Double click on any field to get more info..."
  lblMsg1.Visible      := not value;
  //btnBarCodes.Visible   := not value;
  if DetailPanel <> nil then DetailPanel.Visible   := value;

  if Value then begin
    grdMain.MultiSelectOptions := grdMain.MultiSelectOptions + [msoShiftSelect];
    btnBarCodes.Enabled        := true;
    btnBarCodes.Caption := 'Print Bar&Codes';
    printingBarcodes := true;
  end else begin
    grdMain.MultiSelectOptions := grdMain.MultiSelectOptions - [msoShiftSelect];
    btnBarCodes.Enabled := true;
    btnBarCodes.Caption := 'Deactive prods';
    printingBarcodes := false;
  end;
end;

procedure TProductListGUI.PrintBarCodes;
var
  strSQL:TStringList;
  iclassID:Integer;
  ctr, i:Integer;
  s:String;
  DefTemplate: string;
begin
  if grdMain.SelectedList.Count = 0 then Exit;

  ProcessingCursor;
  try
    strSQL:=TStringList.create;
    try
      DoShowProgressbar(grdMain.SelectedList.Count , WAITMSG);
      try
        iclassID := 0;
        strSQL.Add('Truncate tblbarcodestoprint;');
        if not chkBarInStock.Checked then begin
             if (not isinteger(edtBarQty.Text)) and (strToInt(edtBarQty.Text) <=0) then begin
              CommonLib.MessageDlgXP_Vista('Number of Barcodes to Print is Invalid', mtWarning, [mbOK], 0);
              Exit;
             end;
             if not AppEnv.CompanyPrefs.ProductClassDefaultAll then iclassID := appenv.Employee.DefaultClassID;
             if iclassID =0 then iclassID := Appenv.DefaultClass.ClassID;
             for i := 0 to grdMain.SelectedList.Count - 1 do begin
                qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
                for ctr:= 1 to    strToInt(edtBarQty.Text) do
                  strSQL.add('insert into  tblbarcodestoprint (ProductId, classId) Values(' +inttostr(QrymainPArtsID.asInteger) +',' + inttostr(iclassID) +');' );
                DoStepProgressbar;
             end;
        end else begin
          for i := 0 to grdMain.SelectedList.Count - 1 do begin
              qryMain.GotoBookmark(grdMain.SelectedList.Items[i]);
              if qryMain.FieldByName('InStock').AsInteger <= 0 then
              else begin
                  s:= 		' Select distinct  PQA.DepartmentID, '+
                        ' Round(' +ProductQtyLib.SQL4Qty(tInStock)+ ', ' + IntToStr(tcConst.GeneralRoundPlaces)+')  as InstockQty '+
                        ' from tblPQA  as PQA where PQA.ProductID = ' + IntToStr(QrymainPArtsID.asInteger);
                  if not AppEnv.CompanyPrefs.ProductClassDefaultAll then s:= s + ' and    PQA.DepartmentID = ' + inttostr(appenv.Employee.DefaultClassID);
                  s:= s + ' group by PQA.ProductID, PQA.DepartmentID';
                  With TempMyQuery do try
                    SQL.add(s);
                    open;
                    if recordcount =0 then exit;
                    First;
                    While eof=false do begin
                      if fieldbyname('InstockQty').asInteger > 0 then begin
                        for ctr:= 1 to    fieldbyname('InstockQty').asInteger do
                          strSQL.add('insert into  tblbarcodestoprint (ProductId, classId) Values(' +inttostr(QrymainPArtsID.asInteger) +',' + inttostr(FieldByname('DepartmentID').asInteger) +');' );
                      end;
                      Next;
                    end;
                  finally
                    if active then close;
                    Free;
                  end;
              end;
              DoStepProgressbar;
          end;
        end;
        if strSQL.count =0 then exit;
        ExecuteSQL(strSQL.text);
        if GetTableRecordCount('tblbarcodestoprint') <> 0 then begin
            Printingbarcode:= True;
            Try
              DefTemplate := ReportName;
              if Empty(DefTemplate) then DefTemplate:= 'Barcode Labels';
              ReportSQLSupplied:= true;
              PrintTemplateReport(DefTemplate, ReportSQLforBarCodeLabels, not (chkPreview.checked), 0);
              ReportSQLSupplied:= False;
            Finally
              PrintingBarcode:= False;
            End;
        end;
      finally
        DoHideProgressbar;
      end;
    finally
      Freeandnil(strSQL);
    end;
  finally
    ProcessingCursor(False);
  end;
end;

procedure TProductListGUI.actSelectAllUpdate(Sender: TObject);
begin
  inherited;
    actSelectAll.enabled := chkBarCodes.Checked or chkSetCommission.Checked or chkSetPoints.Checked;
end;

procedure TProductListGUI.actSelectAllExecute(Sender: TObject);
begin
  inherited;
  if Sysutils.SameText(actSelectAll.caption , 'Select All') then begin
    grdmain.SelectAll;
    actSelectAll.caption := 'UnSelect All';
  end else begin
    grdmain.UnselectAll;
    actSelectAll.caption := 'Select All';
  end;
end;

procedure TProductListGUI.KillProgressdialog;
begin
   FreeAndNil(fProgressDialog);
end;

procedure TProductListGUI.NewProgressdialog(const Msg: String;
  const Count: Integer);
begin
  ProgressDialog.Caption := 'Please Wait .......'+MSG;
  ProgressDialog.MinValue := 0;
  ProgressDialog.Step := 1;
  ProgressDialog.MaxValue := count;
  ProgressDialog.Execute;
end;

function TProductListGUI.Progressdialog: TProgressdialog;
begin
  if not assigned(fprogressdialog) then
    fProgressdialog :=TProgressdialog.create(nil);
  result := fProgressdialog;
end;

//procedure TProductListGUI.Showhints;
//begin
//  grdmain.hint :=
//            qryMainValueAvg.displayLabel +' = ' +qryMainInStock.DisplayLabel +' * ' + qryMainAvgCost.DisplayLabel + chr(13) +
//            qryMainstockvalue.displayLabel +' = ' +qryMainInStock.DisplayLabel +' * ' + qryMainCostIncA.DisplayLabel + chr(13) +
//            qryMainSalesValue.displayLabel +' = ' +qryMainInStock.DisplayLabel +' * ' + qryMainPriceIncA.DisplayLabel;
//  if not(grdmain.showhint) then grdmain.showhint := True;
//end;



procedure TProductListGUI.StepProgressdialog;
begin
  ProgressDialog.StepIt;
end;

procedure TProductListGUI.btnListWithDeptClick(Sender: TObject);
begin
  inherited;
  OpenERPListForm('TProductListReorderGUI');
  Self.Close;
end;



initialization
  RegisterClassOnce(TProductListGUI);

finalization
  UnRegisterClass(TProductListGUI);
end.


