
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

unit ProductSalesSummary;

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
  TProductSummaryGUI = class(TBaseListingGUI)
    cboClassQry: TERPQuery;
    qryMainGrossProfit: TCurrencyField;
    qryMainPercentProfit: TFloatField;
    qryMainAvgCost: TFloatField;
    qryMainCategory: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainfirstColumn: TWideStringField;
    qryMainSecondcolumn: TWideStringField;
    qryMainThirdcolumn: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainClassname: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainQty: TFloatField;
    qryMainTotalAmountEx: TFloatField;
    qryMainTotalProfitEx: TFloatField;
    qryMainTotalProfitInc: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    qryMainGrossProfitTotal: TFloatField;
    qryMainLineCostEx: TFloatField;
    qryMainAvailableQty: TFloatField;
    qryMaininstockQty: TFloatField;
    qryMainProductID: TIntegerField;
    qryMainLastSoldDays: TIntegerField;
    qryMainTypeName: TWideStringField;
    qryMainPreferredSupplier: TWideStringField;
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
    qryMainProduct_Description: TWideStringField;
    qryMainProduct_Description_Memo: TWideMemoField;
    qryMainSalesCategory: TWideStringField;
    DNMPanel2: TDNMPanel;
    chkincludemanProducts: TwwCheckBox;
    lblincludemanProducts: TLabel;
    lblREfreshInfo: TLabel;
    DNMPanel1: TDNMPanel;
    Label1: TLabel;
    chkExcludeSystemProducts: TwwCheckBox;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
      Highlight: boolean; AFont: TFont; ABrush: TBrush);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboClassChange(Sender: TObject);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure chkAllClassClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure actRefreshQryExecute(Sender: TObject);
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure chkincludemanProductsClick(Sender: TObject);
    procedure chkIgnoreDatesClick(Sender: TObject);
    procedure cboDateRangeCloseUp(Sender: TObject);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure chkExcludeSystemProductsClick(Sender: TObject);
    procedure btnCustomizeClick(Sender: TObject);



  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    Procedure SetGridColumns;override;
    procedure setDashboardDetail(const Value: Boolean);override;
    procedure readGridfooterValue(columnname: String; Value: Double);override;
    procedure ReadnApplyGuiPrefExtra; override;
    Procedure WriteGuiPrefExtra; override;

  private
    { Private declarations }
    SavedFilterSales:string;
    strSelectedFieldData: string;
    TotalLineCostEx:Double;
    TotalEx:double;
    xDateFrom : TDateTime;
    xdateTo   : TDateTime;
    Procedure MakeTemptable;
    Procedure initialiseProductDetails(Sender:TObject);
    function ExcludeSystemProducts :Boolean;
    procedure RefreshAll;
    Procedure ToBeRefreshed;
  Protected
    tablename :String;
    fiSqno:Integer;
    function NextSeqno: Integer;
    Procedure ExtraTablejoins4Parts(SQL: TStrings;Const PartsTablealias :String ='P'); Virtual;
    Procedure Extrafields(SQL:TStrings);Virtual;
    Procedure ExtraFieldForQrymain(SQL:TStrings);Virtual;
    Procedure ExtraSQLForQrymain;Virtual;
    Procedure ExtraUpdate(SQL:TStrings);Virtual;
    procedure MakeQrymain;Virtual;


  public
    { Public declarations }

  end;

implementation

uses pqalib, FastFuncs, CommonDbLib,CommonLib, AppEnvironment, tcConst,
  ProductQtyLib, CommonFormLib, ProductSalesDetails,  MySQLConst, LogLib;
{$R *.dfm}

procedure TProductSummaryGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
    if GuiPrefs.Node.Exists('Options.ExcludeSystemProducts') then
      chkExcludeSystemProducts.checked :=  GuiPrefs.Node['Options.ExcludeSystemProducts'].asBoolean;

end;

procedure TProductSummaryGUI.RefreshAll;
begin
  DoShowProgressbar(7,WAITMSG);
  try
    Processingcursor(True);
    try
      DoShowProgressbar(30, WAITMSG);
      try
        MakeTemptable;
      finally
        DoHideProgressbar;
      end;
    finally
      Processingcursor(False);
    end;
    inherited RefreshQuery;
    xDateFrom := filterDatefrom;
    xdateTo   := FilterDateto;
    ToBeRefreshed;
  finally
    DoHideProgressbar;
  end;

end;

procedure TProductSummaryGUI.RefreshQuery;
begin
  //inherited;
  ToBeRefreshed;
end;

procedure TProductSummaryGUI.RefreshTotals;
var
  TotalPercentProfit:Double;
begin
  CalcnshowFooter;
  readGridfooterValues;
  TotalPercentProfit := DivZer((TotalEx - TotalLineCostEx), TotalEx) * 100;
  grdMain.ColumnByName('PercentProfit').FooterValue := FormatFloat('###.00%', TotalPercentProfit);
end;

procedure TProductSummaryGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  if not Assigned(field) then exit;
  if sametext(qryMainPercentProfit.fieldname , field.fieldname) then
    if qryMain.FieldByName('PercentProfit').AsFloat =0 then
      Afont.color := ABrush.color;
end;

procedure TProductSummaryGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  ProductSummaryGUI := nil;
end;

procedure TProductSummaryGUI.FormCreate(Sender: TObject);
begin
  tablename := commondblib.GetUserTemporaryTableName('ps');
  MakeQrymain;
  inherited;
  SelectionOption := soClass;
  Addcalccolumn(qryMainTotalAmountEx.FieldName  , true);
  Addcalccolumn(qryMainTotalAmountInc.FieldName , true);
  Addcalccolumn(qryMainGrossProfit.FieldName    , true);
  Addcalccolumn(qrymainLineCostEx.FieldName     , true);
  ShowChartViewOnPopup := True;
  //cboClassQry.Connection := qryMain.Connection;
  grdMain.ColumnByName('FirstColumn').DisplayLabel := AppEnv.DefaultClass.FirstColumn;
  grdMain.ColumnByName('SecondColumn').DisplayLabel := AppEnv.DefaultClass.SecondColumn;
  grdMain.ColumnByName('ThirdColumn').DisplayLabel := AppEnv.DefaultClass.ThirdColumn;
end;
Function TProductSummaryGUI.NextSeqno:Integer;
begin
 fiSqno := fiSqno+1;
 result := fiSqno;
end;
procedure TProductSummaryGUI.MakeQrymain;
begin
  fiSqno := 0;

  Qrymain.SQL.Clear;
  ExtraSQLForQrymain;
  Qrymain.SQL.add('Select');
  Qrymain.SQL.add(inttostr(NextSeqno)+' as Seqno,');
  Qrymain.SQL.add('NULL	as	Category	,');
  Qrymain.SQL.add('NULL	as	SaleDate	,');
  Qrymain.SQL.add('Product_Description	as	Product_Description	,');
  Qrymain.SQL.add('NULL	as	Product_Description_Memo	,');
  ExtraFieldForQrymain(Qrymain.SQL);
  Qrymain.SQL.add('firstColumn	as	firstColumn	,');
  Qrymain.SQL.add('Secondcolumn	as	Secondcolumn	,');
  Qrymain.SQL.add('Thirdcolumn	as	Thirdcolumn	,');
  Qrymain.SQL.add('ProductName	as	ProductName	,');
  Qrymain.SQL.add('Classname	  as	Classname	,');
  Qrymain.SQL.add('NULL	as	CustomerName	,');
  Qrymain.SQL.add('Sum(Qty)	as	Qty	,');
  Qrymain.SQL.add('Sum(TotalAmountEx)	as	TotalAmountEx,');
  Qrymain.SQL.add('Sum(TotalProfitEx)	as	TotalProfitEx,');
  Qrymain.SQL.add('Sum(TotalProfitInc)	as	TotalProfitInc,');
  Qrymain.SQL.add('Sum(TotalAmountInc)	as	TotalAmountInc	,');
  Qrymain.SQL.add('Sum(GrossProfitTotal)	as	GrossProfitTotal	,');
  Qrymain.SQL.add('Sum(LineCostEx)	as	LineCostEx	,');
  Qrymain.SQL.add('ProductId	as	ProductId	,');
  Qrymain.SQL.add('IsSpecial	as	IsSpecial	,');
  qrymain.SQL.Add('SalesCategory as SalesCategory,');
  Qrymain.SQL.add('TypeName	as	TypeName	,');
  Qrymain.SQL.add('CUSTFLD1	as	CUSTFLD1	,');
  Qrymain.SQL.add('CUSTFLD2	as	CUSTFLD2	,');
  Qrymain.SQL.add('CUSTFLD3	as	CUSTFLD3	,');
  Qrymain.SQL.add('CUSTFLD4	as	CUSTFLD4	,');
  Qrymain.SQL.add('CUSTFLD5	as	CUSTFLD5	,');
  Qrymain.SQL.add('CUSTFLD6	as	CUSTFLD6	,');
  Qrymain.SQL.add('CUSTFLD7	as	CUSTFLD7	,');
  Qrymain.SQL.add('CUSTFLD8	as	CUSTFLD8	,');
  Qrymain.SQL.add('CUSTFLD9	as	CUSTFLD9	,');
  Qrymain.SQL.add('CUSTFLD10	as	CUSTFLD10	,');
  Qrymain.SQL.add('CUSTFLD11	as	CUSTFLD11	,');
  Qrymain.SQL.add('CUSTFLD12	as	CUSTFLD12	,');
  Qrymain.SQL.add('CUSTFLD13	as	CUSTFLD13	,');
  Qrymain.SQL.add('CUSTFLD14	as	CUSTFLD14	,');
  Qrymain.SQL.add('CUSTFLD15	as	CUSTFLD15	,');
  Qrymain.SQL.add('CUSTDATE1	as	CUSTDATE1	,');
  Qrymain.SQL.add('CUSTDATE2	as	CUSTDATE2	,');
  Qrymain.SQL.add('CUSTDATE3	as	CUSTDATE3	,');
  Qrymain.SQL.add('Avgcost	as	Avgcost	,');
  Qrymain.SQL.add('PreferredSupplier	as	PreferredSupplier	,');
  Qrymain.SQL.add('instockQty	as	instockQty	,');
  Qrymain.SQL.add('AvailableQty	as	AvailableQty	,');
  Qrymain.SQL.add('LastSoldDays	as	LastSoldDays');
  Qrymain.SQL.add('from ' +tablename +'');
  Qrymain.SQL.add('Group by ProductId');

  Qrymain.SQL.add('union all');
  Qrymain.SQL.add('Select');
  Qrymain.SQL.add(inttostr(NextSeqno)+' as Seqno,');
  Qrymain.SQL.add('NULL	as	Category	,');
  Qrymain.SQL.add('SaleDate	as	SaleDate	,');
  Qrymain.SQL.add('Product_Description	as	Product_Description	,');
  Qrymain.SQL.add('NULL	as	Product_Description_Memo	,');
  ExtraFieldForQrymain(Qrymain.SQL);
  Qrymain.SQL.add('firstColumn	as	firstColumn	,');
  Qrymain.SQL.add('Secondcolumn	as	Secondcolumn	,');
  Qrymain.SQL.add('Thirdcolumn	as	Thirdcolumn	,');
  Qrymain.SQL.add('ProductName	as	ProductName	,');
  Qrymain.SQL.add('Classname	  as	Classname	,');
  Qrymain.SQL.add('NULL	as	CustomerName	,');
  Qrymain.SQL.add('Sum(Qty)	as	Qty	,');
  Qrymain.SQL.add('Sum(TotalAmountEx)	as	TotalAmountEx,');
  Qrymain.SQL.add('Sum(TotalProfitEx)	as	TotalProfitEx,');
  Qrymain.SQL.add('Sum(TotalProfitInc)	as	TotalProfitInc,');
  Qrymain.SQL.add('Sum(TotalAmountInc)	as	TotalAmountInc	,');
  Qrymain.SQL.add('Sum(GrossProfitTotal)	as	GrossProfitTotal	,');
  Qrymain.SQL.add('Sum(LineCostEx)	as	LineCostEx	,');
  Qrymain.SQL.add('ProductId	as	ProductId	,');
  Qrymain.SQL.add('IsSpecial	as	IsSpecial	,');
  Qrymain.SQL.Add('SalesCategory as SalesCategory,');
  Qrymain.SQL.add('TypeName	as	TypeName	,');
  Qrymain.SQL.add('CUSTFLD1	as	CUSTFLD1	,');
  Qrymain.SQL.add('CUSTFLD2	as	CUSTFLD2	,');
  Qrymain.SQL.add('CUSTFLD3	as	CUSTFLD3	,');
  Qrymain.SQL.add('CUSTFLD4	as	CUSTFLD4	,');
  Qrymain.SQL.add('CUSTFLD5	as	CUSTFLD5	,');
  Qrymain.SQL.add('CUSTFLD6	as	CUSTFLD6	,');
  Qrymain.SQL.add('CUSTFLD7	as	CUSTFLD7	,');
  Qrymain.SQL.add('CUSTFLD8	as	CUSTFLD8	,');
  Qrymain.SQL.add('CUSTFLD9	as	CUSTFLD9	,');
  Qrymain.SQL.add('CUSTFLD10	as	CUSTFLD10	,');
  Qrymain.SQL.add('CUSTFLD11	as	CUSTFLD11	,');
  Qrymain.SQL.add('CUSTFLD12	as	CUSTFLD12	,');
  Qrymain.SQL.add('CUSTFLD13	as	CUSTFLD13	,');
  Qrymain.SQL.add('CUSTFLD14	as	CUSTFLD14	,');
  Qrymain.SQL.add('CUSTFLD15	as	CUSTFLD15	,');
  Qrymain.SQL.add('CUSTDATE1	as	CUSTDATE1	,');
  Qrymain.SQL.add('CUSTDATE2	as	CUSTDATE2	,');
  Qrymain.SQL.add('CUSTDATE3	as	CUSTDATE3	,');
  Qrymain.SQL.add('Avgcost	as	Avgcost	,');
  Qrymain.SQL.add('PreferredSupplier	as	PreferredSupplier	,');
  Qrymain.SQL.add('instockQty	as	instockQty	,');
  Qrymain.SQL.add('AvailableQty	as	AvailableQty	,');
  Qrymain.SQL.add('LastSoldDays	as	LastSoldDays');
  Qrymain.SQL.add('from ' +tablename +'');
  Qrymain.SQL.add('Group by ProductId, SaleDate');

  Qrymain.SQL.add('union all');
  Qrymain.SQL.add('Select');
  Qrymain.SQL.add(inttostr(NextSeqno)+' as Seqno,');
  Qrymain.SQL.add('Category	as	Category	,');
  Qrymain.SQL.add('SaleDate	as	SaleDate	,');
  Qrymain.SQL.add('Product_Description	as	Product_Description	,');
  Qrymain.SQL.add('Product_Description_Memo	as	Product_Description_Memo	,');
  ExtraFieldForQrymain(Qrymain.SQL);
  Qrymain.SQL.add('firstColumn	as	firstColumn	,');
  Qrymain.SQL.add('Secondcolumn	as	Secondcolumn	,');
  Qrymain.SQL.add('Thirdcolumn	as	Thirdcolumn	,');
  Qrymain.SQL.add('ProductName	as	ProductName	,');
  Qrymain.SQL.add('Classname	  as	Classname	,');
  Qrymain.SQL.add('CustomerName	as	CustomerName	,');
  Qrymain.SQL.add('Qty	as	Qty	,');
  Qrymain.SQL.add('TotalAmountEx	as	TotalAmountEx,');
  Qrymain.SQL.add('TotalProfitEx	as	TotalProfitEx,');
  Qrymain.SQL.add('TotalProfitInc	as	TotalProfitInc,');
  Qrymain.SQL.add('TotalAmountInc	as	TotalAmountInc	,');
  Qrymain.SQL.add('GrossProfitTotal	as	GrossProfitTotal	,');
  Qrymain.SQL.add('LineCostEx	as	LineCostEx	,');
  Qrymain.SQL.add('ProductId	as	ProductId	,');
  Qrymain.SQL.add('IsSpecial	as	IsSpecial	,');
  QryMain.SQL.Add('SalesCategory as SalesCategory,');
  Qrymain.SQL.add('TypeName	as	TypeName	,');
  Qrymain.SQL.add('CUSTFLD1	as	CUSTFLD1	,');
  Qrymain.SQL.add('CUSTFLD2	as	CUSTFLD2	,');
  Qrymain.SQL.add('CUSTFLD3	as	CUSTFLD3	,');
  Qrymain.SQL.add('CUSTFLD4	as	CUSTFLD4	,');
  Qrymain.SQL.add('CUSTFLD5	as	CUSTFLD5	,');
  Qrymain.SQL.add('CUSTFLD6	as	CUSTFLD6	,');
  Qrymain.SQL.add('CUSTFLD7	as	CUSTFLD7	,');
  Qrymain.SQL.add('CUSTFLD8	as	CUSTFLD8	,');
  Qrymain.SQL.add('CUSTFLD9	as	CUSTFLD9	,');
  Qrymain.SQL.add('CUSTFLD10	as	CUSTFLD10	,');
  Qrymain.SQL.add('CUSTFLD11	as	CUSTFLD11	,');
  Qrymain.SQL.add('CUSTFLD12	as	CUSTFLD12	,');
  Qrymain.SQL.add('CUSTFLD13	as	CUSTFLD13	,');
  Qrymain.SQL.add('CUSTFLD14	as	CUSTFLD14	,');
  Qrymain.SQL.add('CUSTFLD15	as	CUSTFLD15	,');
  Qrymain.SQL.add('CUSTDATE1	as	CUSTDATE1	,');
  Qrymain.SQL.add('CUSTDATE2	as	CUSTDATE2	,');
  Qrymain.SQL.add('CUSTDATE3	as	CUSTDATE3	,');
  Qrymain.SQL.add('Avgcost	as	Avgcost	,');
  Qrymain.SQL.add('PreferredSupplier	as	PreferredSupplier	,');
  Qrymain.SQL.add('instockQty	as	instockQty	,');
  Qrymain.SQL.add('AvailableQty	as	AvailableQty	,');
  Qrymain.SQL.add('LastSoldDays	as	LastSoldDays');
  Qrymain.SQL.add('from ' +tablename +'');


  Qrymain.SQL.add('Order by  ProductId, SaleDate, customerName, Seqno');
  grpFilters.hint := 'Summary : Grouped for the Product'+NL+
                     'Details : Grouped for the Product, SaleDate'+NL+
                     'Extra Details : Grouped for the Product, SaleDate, Customer Name'+NL;
end;

procedure TProductSummaryGUI.FormDestroy(Sender: TObject);
begin
  CommonDbLib.DestroyUserTemporaryTable(tablename);
  CommonDbLib.DestroyUserTemporaryTable(tablename+'1');
  inherited;

end;

procedure TProductSummaryGUI.FormShow(Sender: TObject);
begin
    (*cboClassQry.Open;
    cboClassQry.Locate('ClassName', AppEnv.DefaultClass.DefaultClassName, [loCaseInsensitive]);
    cboClass.Text        := AppEnv.DefaultClass.DefaultClassName;
    cboClass.LookupValue := cboClassQry.FieldByName('ClassID').AsString;*)

  inherited;
  RefreshAll;
  SavedFilterSales := '';
  if self.ErrorOccurred then
    exit;
end;

procedure TProductSummaryGUI.btnCustomizeClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TProductSummaryGUI.cboClassChange(Sender: TObject);
begin
  inherited;
  TProductSummaryGUI(FindExistingComponent('TProductSummaryGUI')).toberefreshed;//RefreshQuery;
//  ProductSummaryGUI.RefreshQuery;
end;

procedure TProductSummaryGUI.cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  if not fbFormOpenedOk then exit;
  inherited;
  toberefreshed;//RefreshQuery;
end;

procedure TProductSummaryGUI.chkAllClassClick(Sender: TObject);
begin
  inherited;
  if not fbFormOpenedOk then exit;
(*  if chkAllClass.Checked = true then begin
    cboClass.Enabled := false;
  end else begin
    cboClass.Enabled := true;
  end;*)
  toberefreshed;//RefreshQuery;
end;

procedure TProductSummaryGUI.chkExcludeSystemProductsClick(Sender: TObject);
begin
  inherited;
  if Screen.activecontrol = chkExcludeSystemProducts then
    toberefreshed;//RefreshQuery;
end;

procedure TProductSummaryGUI.grdMainDblClick(Sender: TObject);
begin
if MessageDlgXP_Vista('Do You Wish To See the Sales Details of Product :' + QrymainProductName.asString +'?' , mtconfirmation , [mbyes,mbno], 0) = mrno then exit;
OpenERPListForm('TProductDetailsGUI' , initialiseProductDetails);
Self.close;
end;

procedure TProductSummaryGUI.grdMainTitleButtonClick(Sender: TObject; AFieldName: string);
begin
  // sorting on company is not possible when the form is in detail mode
  // and sorting on the type is not possible when the form is in extra detail mode
  inherited;
end;

procedure TProductSummaryGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Seqno' , ['1','2','3','4']);
  inherited;
end;

procedure TProductSummaryGUI.initialiseProductDetails(Sender: TObject);
begin
  if not(Sender is TProductDetailsGUI) then exit;
  //if not chkAllClass.Checked then SelectedClassID := cboClassQry.fieldByname('classid').asInteger else SelectedClassID :=0;
  TProductDetailsGUI(Sender).ProductId  := QrymainProductID.asInteger;
  TProductDetailsGUI(Sender).classId    := SelectedClassID;
  TProductDetailsGUI(Sender).dtFrom.Date:= dtFrom.Date;
  TProductDetailsGUI(Sender).dtTo.Date  := dtto.Date;
  TProductDetailsGUI(Sender).fbDateRangeSupplied:=true;
end;
Procedure TProductSummaryGUI.ExtraTablejoins4Parts(SQL: TStrings;Const PartsTablealias :String ='P');
begin
  // descendants will override
end;
procedure TProductSummaryGUI.ExtraUpdate(SQL: TStrings);
begin
  // descendants will override
end;

procedure TProductSummaryGUI.Extrafields(SQL: TStrings);
begin
  // descendants will override
end;
procedure TProductSummaryGUI.ExtraFieldForQrymain(SQL: TStrings);
begin
  // descendants will override
end;
procedure TProductSummaryGUI.ExtraSQLForQrymain;
begin
  // descendants will override
end;


procedure TProductSummaryGUI.MakeTemptable;
begin
(*  if not chkAllClass.Checked then
    SelectedClassID := cboClassQry.FieldByName('classId').AsInteger
  else SelectedClassID := 0;*)

  With ScriptMain do begin
    SQL.clear;
    SQL.Add(' drop table if exists ' +tablename +'1;');
    SQL.Add(' Create table  ' +tablename+'1' );
    SQL.Add(' SELECT Distinct ');
    SQL.Add('"S" as Category, ');
    SQL.Add('S.SaleDate as SaleDate,');
    SQL.Add('SL.Product_Description as Product_Description,');
    SQL.Add('SL.Product_Description_Memo as Product_Description_Memo,');
    Extrafields(SQL);
    SQL.Add(firstcolumn   + ' as firstColumn,');
    SQL.Add(Secondcolumn  + ' as Secondcolumn,');
    SQL.Add(Thirdcolumn   + ' as Thirdcolumn,');
    SQL.Add(' Trim(SL.ProductName) as ProductName , ');
    SQL.Add(' S.Class as Classname, ');
    SQL.Add(' S.CustomerName as CustomerName, ');
    SQL.Add(' SL.saleLineId as saleLineId, ');
    SQL.Add(' (SL.Shipped) as Qty, ');
    SQL.Add(' (SL.TotalLineAmount) as `TotalAmountEx`, ');
    SQL.Add(' (SL.TotalLineAmount) - (SL.LineCost*SL.Shipped) as `TotalProfitEx`, ');
    SQL.Add(' (SL.TotalLineAmountInc) - (SL.LineCostInc*SL.Shipped) as `TotalProfitInc`, ');
    SQL.Add(' (SL.TotalLineAmountInc) as `TotalAmountInc`, ');
    SQL.Add(' (SL.TotalLineAmount) as GrossProfitTotal, ');
    SQL.Add(' SL.LineCost*SL.Shipped as `LineCostEx`,');
    SQL.Add(' SL.ProductID as ProductId, ');
    SQL.Add(' "F" as IsSpecial, ');
    SQL.Add('S.SalesCategory, ');
    SQL.add('CT.TypeName as TypeName,');
    SQL.Add('P.CUSTFLD1 as CUSTFLD1,');
    SQL.Add('P.CUSTFLD2 as CUSTFLD2,');
    SQL.Add('P.CUSTFLD3 as CUSTFLD3,');
    SQL.Add('P.CUSTFLD4 as CUSTFLD4,');
    SQL.Add('P.CUSTFLD5 as CUSTFLD5,');
    SQL.Add('P.CUSTFLD6 as CUSTFLD6,');
    SQL.Add('P.CUSTFLD7 as CUSTFLD7,');
    SQL.Add('P.CUSTFLD8 as CUSTFLD8,');
    SQL.Add('P.CUSTFLD9 as CUSTFLD9,');
    SQL.Add('P.CUSTFLD10 as CUSTFLD10,');
    SQL.Add('P.CUSTFLD11 as CUSTFLD11,');
    SQL.Add('P.CUSTFLD12 as CUSTFLD12,');
    SQL.Add('P.CUSTFLD13 as CUSTFLD13,');
    SQL.Add('P.CUSTFLD14 as CUSTFLD14,');
    SQL.Add('P.CUSTFLD15 as CUSTFLD15,');
    SQL.Add('P.CUSTDATE1 as CUSTDATE1,');
    SQL.Add('P.CUSTDATE2 as CUSTDATE2,');
    SQL.Add('P.CUSTDATE3 as CUSTDATE3');
    SQL.Add('FROM tblSales as S');
    SQL.Add(' INNER   JOIN tblSalesLines  as SL USING(SaleID) ');
    SQL.Add(' INNER   JOIN tblparts       as P ON PARTSID = ProductID ');
    ExtraTablejoins4Parts(SQL,'P');
    if ExcludeSystemProducts then SQL.Add(' and P.IsSystemProduct <> "T"');
    SQL.Add(' INNER   JOIN tblclients     as C ON C.ClientID=S.ClientID ');
    SQL.Add(' LEFT JOIN tblClientType CT ON C.ClientTypeID=CT.ClientTypeID ');
    SQL.Add('Where  (S.IsPOS ="T" or S.IsRefund ="T"  ' +
              ' or S.IsCashSale="T" or S.IsInvoice="T" '+
              ' or S.IsSalesOrder="T" or S.IsLayby ="T") '+
              ' AND SL.Invoiced="T" AND S.Deleted ="F"  AND S.IsQuote="F"  AND S.converted = "F" '+
              ' AND S.SaleDate Between   ' + Quotedstr(formatDatetime(MysqlDateFormat , filterdatefrom))+' AND   ' + Quotedstr(formatDatetime(MysqlDateFormat , filterdateto)));
    if selectedClassId<> 0 then SQL.add(' AND S.ClassID Like ' +inttostr(SelectedClassID));
    {manufaturing products}
    if chkincludemanProducts.checked then begin
      SQL.Add('UNION ALL');
      SQL.Add('SELECT  Distinct ');
      SQL.Add('"M" as Category,');
      SQL.Add('S.SaleDate as SaleDate,');
      SQL.Add('SL.Product_Description as Product_Description,');
      SQL.Add('SL.Product_Description_Memo as Product_Description_Memo ,');
      Extrafields(SQL);
      SQL.Add(firstcolumn   + ' as firstColumn,');
      SQL.Add(Secondcolumn  + ' as Secondcolumn,');
      SQL.Add(Thirdcolumn   + ' as Thirdcolumn,');
      SQL.Add('PTP.ProductName as ProductName,');
      SQL.Add(' S.Class as Classname, ');
      SQL.Add('S.CustomerName as CustomerName,');
      SQL.Add(' SL.saleLineId as saleLineId, ');
      SQL.Add('(PTP.Qty)as Qty,');
      SQL.Add('(PTP.Qty*PT.Price) as `TotalAmountEx`, ');
      SQL.Add('(PTP.Qty*PT.Price) - (PTP.Qty * PT.Cost) as `TotalProfitEx`, ');
      SQL.Add('(PTP.Qty*PT.Price) as `TotalProfitInc`, ');
      SQL.Add('(PTP.Qty*PT.Price) as `TotalAmountInc`, ');
      SQL.Add(' null as GrossProfitTotal, ');
      SQL.Add('(PTP.Qty * PT.Cost) as `LineCostEx`,');
      SQL.Add('PTP.ProductId as ProductID, ');
      SQL.Add('"F" as IsSpecial, ');
      SQL.Add('S.SalesCategory as SalesCategory,');
      SQL.add('CT.TypeName as TypeName,');
      SQL.Add('P.CUSTFLD1 as CUSTFLD1,');
      SQL.Add('P.CUSTFLD2 as CUSTFLD2,');
      SQL.Add('P.CUSTFLD3 as CUSTFLD3,');
      SQL.Add('P.CUSTFLD4 as CUSTFLD4,');
      SQL.Add('P.CUSTFLD5 as CUSTFLD5,');
      SQL.Add('P.CUSTFLD6 as CUSTFLD6,');
      SQL.Add('P.CUSTFLD7 as CUSTFLD7,');
      SQL.Add('P.CUSTFLD8 as CUSTFLD8,');
      SQL.Add('P.CUSTFLD9 as CUSTFLD9,');
      SQL.Add('P.CUSTFLD10 as CUSTFLD10,');
      SQL.Add('P.CUSTFLD11 as CUSTFLD11,');
      SQL.Add('P.CUSTFLD12 as CUSTFLD12,');
      SQL.Add('P.CUSTFLD13 as CUSTFLD13,');
      SQL.Add('P.CUSTFLD14 as CUSTFLD14,');
      SQL.Add('P.CUSTFLD15 as CUSTFLD15,');
      SQL.Add('P.CUSTDATE1 as CUSTDATE1,');
      SQL.Add('P.CUSTDATE2 as CUSTDATE2,');
      SQL.Add('P.CUSTDATE3 as CUSTDATE3');
      SQL.Add('FROM');
      SQL.Add('tblsales AS S');
      SQL.Add('Inner Join tblsaleslines AS SL ON S.SaleID = SL.SaleID');
      SQL.Add('Inner Join tblproctreepart AS PTP ON SL.SaleID = PTP.SaleId AND SL.SaleLineID = PTP.SaleLineId');
      SQL.Add('Inner Join tblproctree AS PT ON PTP.ProcTreeId = PT.ProcTreeId AND PT.ParentId <> 0');
      SQL.Add('Inner Join tblparts AS P ON PTP.ProductId = P.PARTSID');
      ExtraTablejoins4Parts(SQL, 'P');
      if ExcludeSystemProducts then SQL.Add(' and P.IsSystemProduct <> "T"');
      SQL.Add('INNER JOIN tblclients C ON C.ClientID=S.ClientID');
      SQL.Add(' LEFT JOIN tblClientType CT ON C.ClientTypeID=CT.ClientTypeID ');
      SQL.Add(' Where S.SaleDate Between   ' + Quotedstr(formatDatetime(MysqlDateFormat , filterdatefrom))+' AND   ' + Quotedstr(formatDatetime(MysqlDateFormat , filterdateto)));
      if selectedClassId<> 0 then SQL.add(' AND S.ClassID Like ' +inttostr(SelectedClassID));
    end;
    SQL.Add(';');
    SQL.Add(' drop table if exists ' +tablename +';');
    SQL.Add(' Create table  ' +tablename );
    SQL.Add(' SELECT ');
    SQL.Add('Category, ');
    SQL.Add('SaleDate,');
    SQL.Add('Product_Description,');
    SQL.Add('Product_Description_Memo,');
    SQL.Add('firstColumn,');
    SQL.Add('Secondcolumn,');
    SQL.Add('Thirdcolumn,');
    SQL.Add('ProductName , ');
    SQL.Add(' Classname, ');
    SQL.Add('CustomerName, ');
    SQL.Add(' Round(Sum(Qty), ' + IntToStr((*appEnv.CompanyPrefs.QtyRoundTo*)tcConst.GeneralRoundPlaces) + ') as Qty, ');
    SQL.Add(' Sum(`TotalAmountEx`) as `TotalAmountEx`, ');
    SQL.Add(' Round(Sum(`TotalProfitEx`),'+intToStr(CurrencyRoundPlaces) +') as `TotalProfitEx`, ');
    SQL.Add(' Round(Sum(`TotalProfitInc`),'+intToStr(CurrencyRoundPlaces) +') as `TotalProfitInc`, ');
    SQL.Add(' Sum(`TotalAmountInc`) as `TotalAmountInc`, ');
    SQL.Add(' Sum(GrossProfitTotal) as GrossProfitTotal, ');
    SQL.Add(' Round(sum(`LineCostEx`),'+intToStr(CurrencyRoundPlaces) +') as `LineCostEx`,');
    SQL.Add(' ProductId, ');
    SQL.Add(' IsSpecial, ');
    SQL.Add(' SalesCategory, ');
    SQL.add('TypeName,');
    SQL.Add('CUSTFLD1,');
    SQL.Add('CUSTFLD2,');
    SQL.Add('CUSTFLD3,');
    SQL.Add('CUSTFLD4,');
    SQL.Add('CUSTFLD5,');
    SQL.Add('CUSTFLD6,');
    SQL.Add('CUSTFLD7,');
    SQL.Add('CUSTFLD8,');
    SQL.Add('CUSTFLD9,');
    SQL.Add('CUSTFLD10,');
    SQL.Add('CUSTFLD11,');
    SQL.Add('CUSTFLD12,');
    SQL.Add('CUSTFLD13,');
    SQL.Add('CUSTFLD14,');
    SQL.Add('CUSTFLD15,');
    SQL.Add('CUSTDATE1,');
    SQL.Add('CUSTDATE2,');
    SQL.Add('CUSTDATE3');
    SQL.Add('FROM ' +tablename +'1 ');
    SQL.Add('GROUP BY ProductID, CustomerName;');
    ExtraUpdate(SQL);

    SQL.Add('Alter table '+tablename +' add column Avgcost double;');
    SQL.Add('Alter table '+tablename +' add column PreferredSupplier varchar(100);');
    SQL.Add('update '+tablename +' T inner join tblParts P on T.productId = P.partsID '+
                                  ' Set T.Avgcost =P.Avgcost ,  '+
                                  ' T.PreferredSupplier = P.PREFEREDSUPP ;');
    SQL.Add('Alter table '+tablename +' add column instockQty double;');
    SQL.Add('Alter table '+tablename +' add column AvailableQty double;');
    SQL.Add('update ' +Tablename +  ' as tmp ' +
                  ' Set instockQty = (select ' + SQL4Qty(tInstock,'PQA' , 'PQA.Qty') +
                  ' from tblPQa as PQA where  PQA.ProductID = tmp.productId); ' );
    SQL.Add('update ' +Tablename +  ' as tmp ' +
                  ' Set AvailableQty = (select ' + SQL4Qty(tAvailable,'PQA' , 'PQA.Qty') +
                  ' from tblPQa as PQA where  PQA.ProductID = tmp.productId); ' );
    SQL.Add('Alter table '+tablename +' add column LastSoldDays int(11);');
    SQL.add('Drop table if exists '+Tablename +'2;');
    SQL.add('Create table '+Tablename +'2 Select ProductID, CustomerName , Max(Shipdate) shipdate from (Select ' +
              ' CustomerName, SL.productId , Max(SL.ShipDate) shipdate ' +
              ' from tblsales s inner join tblsaleslines SL on s.saleId = sl.saleId ' );
    SQL.Add('Where  (S.IsPOS ="T" or S.IsRefund ="T"  ' +
              ' or S.IsCashSale="T" or S.IsInvoice="T" '+
              ' or S.IsSalesOrder="T" or S.IsLayby ="T") '+
              ' AND SL.Invoiced="T" AND S.Deleted ="F"  AND S.IsQuote="F"  AND S.converted = "F" '+
              ' AND S.SaleDate Between   ' + Quotedstr(formatDatetime(MysqlDateFormat , filterdatefrom))+' AND   ' + Quotedstr(formatDatetime(MysqlDateFormat , filterdateto)));
    if selectedClassId<> 0 then SQL.add(' AND S.ClassID Like ' +inttostr(SelectedClassID));
    SQL.add(' group by productId , CustomerName');
    if chkincludemanProducts.checked then begin
      SQL.add('union all ' +
            ' Select ' +
            ' S.CustomerName , PTP.productId , Max(SL.ShipDate) shipdate ' +
            ' from tblsales s inner join tblsaleslines SL on s.saleId = sl.saleId ' +
            ' inner join tblproctreepart AS PTP ON SL.SaleID = PTP.SaleId AND SL.SaleLineID = PTP.SaleLineId ' );
      SQL.Add(' Where S.SaleDate Between   ' + Quotedstr(formatDatetime(MysqlDateFormat , filterdatefrom))+' AND   ' + Quotedstr(formatDatetime(MysqlDateFormat , filterdateto)));
      if selectedClassId<> 0 then SQL.add(' AND S.ClassID Like ' +inttostr(SelectedClassID));
      SQL.Add(' group by PTP.productId, S.CustomerName');
    end;
    SQL.add(') Productsales group by productID;');
    SQL.add('update '+tablename +' tmp inner join '+tablename+'2 tmp_1 on tmp.productId = tmp_1.productId set  tmp.LastSoldDays = DATEDIFF(' +quotedstr(FormatDateTime(Mysqldatetimeformat , now))+' , Shipdate);');

    SQL.Add(' drop table if exists ' +tablename +'1;');
    SQL.Add(' drop table if exists ' +tablename +'2;');
    Sql.text := ChangeQuery(SQL.text);
    clog(SQL.text);
    Execute;
  end;
end;

procedure TProductSummaryGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  doHideProgressbar;
end;

procedure TProductSummaryGUI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  DoShowProgressbar(2, WAITMSG);
  DoStepProgressbar;
end;

procedure TProductSummaryGUI.actRefreshQryExecute(Sender: TObject);
begin
  strSelectedFieldData := '';
//  inherited;
    RefreshAll;
end;

procedure TProductSummaryGUI.qryMainCalcFields(DataSet: TDataSet);
var
  difference: double;
  Income: double;
begin
  inherited;
  difference := qryMain.FieldByName('GrossProfitTotal').AsFloat - qryMain.FieldByName('LineCostEx').AsFloat;
  Income := qryMain.FieldByName('GrossProfitTotal').AsFloat;
  qryMain.FieldByName('PercentProfit').AsFloat := DivZer(difference, Income) * 100;
  qryMain.FieldByName('GrossProfit').AsFloat := difference;
end;

procedure TProductSummaryGUI.readGridfooterValue(columnname: String;
  Value: Double);
begin
  inherited;
  if sameText(columnname , qrymainLineCostEx.FieldName    ) then TotalLineCostEx := Value;
  if sameText(columnname , qryMainTotalAmountEx.FieldName ) then TotalEx := Value;
end;

procedure TProductSummaryGUI.chkincludemanProductsClick(Sender: TObject);
begin
  if not fbFormOpenedOk then exit;
  toberefreshed;//RefreshQuery;
end;

function TProductSummaryGUI.ExcludeSystemProducts: Boolean;
begin
  Result := chkExcludeSystemProducts.checked;
end;
procedure TProductSummaryGUI.SetGridColumns;
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
  RemoveFieldfromGrid(qryMainTotalProfitEx.fieldname);
  RemoveFieldfromGrid(qryMainTotalProfitInc.fieldname);
  SetUpcustomFields('Product');
  grdmain.hint := qrymaingrossprofit.displaylabel   + '    = (' +qryMainTotalAmountEx.DisplayLabel + ' - '+ qryMainLineCostEx.DisplayLabel +') '+NL+
                  qryMainPercentProfit.DisplayLabel + ' = (' +qryMainTotalAmountEx.DisplayLabel + ' - '+ qryMainLineCostEx.DisplayLabel +') / ' +qryMainTotalAmountEx.DisplayLabel + NL;
end;

procedure TProductSummaryGUI.ToBeRefreshed;
begin
   lblREfreshInfo.visible :=
      (xDateFrom<>filterDatefrom) or
      (xdateTo<> FilterDateto) ;

end;

procedure TProductSummaryGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['Options.ExcludeSystemProducts'].asBoolean := chkExcludeSystemProducts.checked ;
end;

procedure TProductSummaryGUI.setDashboardDetail(const Value: Boolean);
begin
  inherited;
  if Value then begin
    chkincludemanProducts.checked := false;
    grdMainTitleButtonClick(grdMain, 'TotalAmountEx');
    qryMain.First;
  end;
end;


procedure TProductSummaryGUI.chkIgnoreDatesClick(Sender: TObject);
begin
  if not fbFormOpenedOk then exit;

  inherited;

end;

procedure TProductSummaryGUI.cboDateRangeCloseUp(Sender: TObject);
begin
  if not fbFormOpenedOk then exit;

  inherited;

end;

initialization
  RegisterClassOnce(TProductSummaryGUI);
end.
