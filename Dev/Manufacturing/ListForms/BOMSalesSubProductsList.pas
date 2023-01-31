unit BOMSalesSubProductsList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, DNMPanel , BaseListExpress, GIFImg;

type
  TBOMSalesSubProductsListGUI = class(TBaseListExpressGUI)
    qryMainSaleid: TIntegerField;
    qryMainsaleLineId: TIntegerField;
    qryMainSaleProduct: TWideStringField;
    qryMainInvoiceDocNumber: TWideStringField;
    qryMainUnitofMeasureQtySold: TFloatField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainUnitofMeasureBackorder: TFloatField;
    qryMainSalesUOM: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainBOMComments: TWideStringField;
    qryMainProduct_Description: TWideStringField;
    qryMainFormulaName: TWideStringField;
    qryMainFormula: TWideStringField;
    qryMainUFormula: TWideStringField;
    qryMainQuantity: TFloatField;
    qryMainTotalQty: TFloatField;
    qryMainFormulaQtyValue1: TFloatField;
    qryMainFormulaQtyValue2: TFloatField;
    qryMainFormulaQtyValue3: TFloatField;
    qryMainFormulaQtyValue4: TFloatField;
    qryMainFormulaQtyValue5: TFloatField;
    qryMainFormulaQtyValue: TFloatField;
    qryMainBuildFormulaQtyValue1: TFloatField;
    qryMainBuildFormulaQtyValue2: TFloatField;
    qryMainBuildFormulaQtyValue3: TFloatField;
    qryMainBuildFormulaQtyValue4: TFloatField;
    qryMainBuildFormulaQtyValue5: TFloatField;
    qryMainBuildFormulaQtyValue: TFloatField;
    qryMainPartSource: TWideStringField;
    qryMainselected: TWideStringField;
    qryMainInputType: TWideStringField;
    qryMainPriceinTree: TFloatField;
    qryMainCostinTree: TFloatField;
    qryMainTreeUOM: TWideStringField;
    qryMainInfo: TWideStringField;
    qryMainparentInputType: TWideStringField;
    qryMainrownum: TLargeintField;
    qryMainconverted: TWideStringField;
    qryMainSaletye: TWideStringField;
    qryMainsaleDate: TDateField;
    qryMainCaption: TWideStringField;
    grpExtrafilters: TwwRadioGroup;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
  private
    Procedure makeQrymain;
    procedure InitOptions;
  Protected
    tablename :String;
    procedure PopulateData;Virtual;
    procedure SetGridColumns; Override;
    procedure AdjustDisplayLabels(tmpField :TField; Var s:String); Override;
    Function extraFields:String;Virtual;
    Function ExtraTables:String;Virtual;
    Function ExpressDetailListName:String;Override;
    procedure AfterPopup(Popupform:TComponent);Override;
  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonLib, CommonDbLib, LogLib, ProductQtyLib, AppEnvironment,
  frmSalesOrder , dateutils, tcConst, BOMSalesSubProductsDetailList, MySQLConst;

{$R *.dfm}

{ TBOMSalesSubProductsListGUI }

procedure TBOMSalesSubProductsListGUI.AdjustDisplayLabels(tmpField :TField; Var s:String);
begin
  inherited;
  try if sametext(tmpfield.fieldname , qrymainFormulaQtyValue1.fieldname) or sametext(tmpfield.fieldname , qrymainBuildFormulaQtyValue1.fieldname) then if Appenv.companyPrefs.Fe1Visible then s:= Appenv.companyPrefs.Fe1Name ;Except end;
  try if sametext(tmpfield.fieldname , qrymainFormulaQtyValue2.fieldname) or sametext(tmpfield.fieldname , qrymainBuildFormulaQtyValue2.fieldname) then if Appenv.companyPrefs.Fe2Visible then s:= Appenv.companyPrefs.Fe2Name ;Except end;
  try if sametext(tmpfield.fieldname , qrymainFormulaQtyValue3.fieldname) or sametext(tmpfield.fieldname , qrymainBuildFormulaQtyValue3.fieldname) then if Appenv.companyPrefs.Fe3Visible then s:= Appenv.companyPrefs.Fe3Name ;Except end;
  try if sametext(tmpfield.fieldname , qrymainFormulaQtyValue4.fieldname) or sametext(tmpfield.fieldname , qrymainBuildFormulaQtyValue4.fieldname) then if Appenv.companyPrefs.Fe4Visible then s:= Appenv.companyPrefs.Fe4Name ;Except end;
  try if sametext(tmpfield.fieldname , qrymainFormulaQtyValue5.fieldname) or sametext(tmpfield.fieldname , qrymainBuildFormulaQtyValue5.fieldname) then if Appenv.companyPrefs.Fe5Visible then s:= Appenv.companyPrefs.Fe5Name ;Except end;
end;

procedure TBOMSalesSubProductsListGUI.FormCreate(Sender: TObject);
begin
  InitOptions;
  Tablename := commondblib.GetUserTemporaryTableName('BOMSub');
  MakeQrymain;
  inherited;
  DateRangeSelectionHint := 'Report is filterd on Ship Date';
  DateRangetype := drShort;

end;

procedure TBOMSalesSubProductsListGUI.FormShow(Sender: TObject);
begin
  inherited;
  InitOptions;
end;
Procedure TBOMSalesSubProductsListGUI.InitOptions;
begin
  grpExtrafilters.Width := Self.width - (lblSearchMode.left + lblSearchMode.width +1);
  lblFilter.Anchors := [akTop,akLeft];
  cboFilter.Anchors := [akTop,akLeft];
  lblSearchoptions.Anchors := [akTop,akLeft];
  pnlSearchbuttons.Anchors := [akTop,akLeft];
  edtSearch.Anchors := [akTop,akLeft];
  lblSearchMode.Anchors := [akTop,akLeft];

end;
procedure TBOMSalesSubProductsListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;


  if (grpFilters.itemindex = 2) and
      (not(grpExtrafilters.visible ) or (grpExtrafilters.itemindex <>0)) and
      (BaseIndexFieldNames ='') then
    if Qrymainrownum.asInteger =1 then
      DoGreenhighlight(Afont, abrush)
    else
      if sametext(field.fieldname , qryMainSaleid.fieldname) or
         sametext(field.fieldname , qryMainsaleLineId.fieldname) or
         sametext(field.fieldname , qryMainSaleProduct.fieldname) or
         sametext(field.fieldname , 'ShipDate') or
         sametext(field.fieldname , 'SaleDate') or
         sametext(field.fieldname , 'EmployeeName') or
         sametext(field.fieldname , qryMainUnitofMeasureQtySold.fieldname) or
         sametext(field.fieldname , qryMainUnitofMeasureShipped.fieldname) or
         sametext(field.fieldname , qryMainUnitofMeasureBackorder.fieldname) or
         sametext(field.fieldname , qryMainCustomerName.fieldname) or
         sametext(field.fieldname , qryMainSalesUOM.fieldname) then
       Afont.color := ABrush.color;

  if qrymainrownum.asInteger =1 then
      if sametext(field.fieldname , qryMainFormulaQtyValue1.fieldname) or
         sametext(field.fieldname , qryMainFormulaQtyValue2.fieldname) or
         sametext(field.fieldname , qryMainFormulaQtyValue3.fieldname) or
         sametext(field.fieldname , qryMainFormulaQtyValue4.fieldname) or
         sametext(field.fieldname , qryMainFormulaQtyValue5.fieldname) or
         sametext(field.fieldname , qryMainFormulaQtyValue.fieldname) or
         sametext(field.fieldname , qryMainBuildFormulaQtyValue1.fieldname) or
         sametext(field.fieldname , qryMainBuildFormulaQtyValue2.fieldname) or
         sametext(field.fieldname , qryMainBuildFormulaQtyValue3.fieldname) or
         sametext(field.fieldname , qryMainBuildFormulaQtyValue4.fieldname) or
         sametext(field.fieldname , qryMainBuildFormulaQtyValue5.fieldname) or
         sametext(field.fieldname , qryMainBuildFormulaQtyValue.fieldname) then Afont.color := ABrush.color;
  if Field is TFloatfield then
    if TFloatfield(Field).asFloat =0 then
      Afont.color := ABrush.color;

end;

procedure TBOMSalesSubProductsListGUI.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString(qryMainConverted.fieldname  , ['T','F','']);
  if grpExtrafilters.visible then
      if grpExtrafilters.itemindex =0 then begin
        if groupfilterstring <> '' then groupfilterstring := groupfilterstring + ' AND ';
        groupfilterstring := groupfilterstring + 'Level = MaxLevel';
      end;
  inherited;
end;

procedure TBOMSalesSubProductsListGUI.makeQrymain;
begin
  closedb(Qrymain);
  Qrymain.sql.clear;

  Qrymain.sql.add('Select   ');
  Qrymain.sql.add('convert( @rownum:=if(@SaleLineId <> SaleLineId,  @rownum:= 1 ,  @rownum+1) , Signed INTEGER) as rownum ,  ');
  Qrymain.sql.add(' @SaleLineId := SaleLineId , ');
  Qrymain.sql.add(' T.*');
  Qrymain.sql.add('FROM  ');
  Qrymain.sql.add(' (SELECT @rownum:=0) rno ,  ');
  Qrymain.sql.add(' (SELECT @SaleLineId:=0) slid, ');
  Qrymain.sql.add(Tablename +' as T   ');
end;


procedure TBOMSalesSubProductsListGUI.PopulateData;
begin
  With scriptmain do begin
      sql.add('Drop table if exists '+ Tablename +';');
      sql.add('Create table ' + Tablename +
                                ' Select   ' +
                                ' S.saleId as Saleid,  ' +
                                ' '+SaleType+' as Saletye, ' +
                                ' S.converted as converted,  ' +
                                ' S.CustomerName as CustomerName,  ' +
                                ' SL.BOMComments as BOMComments,  ' +
                                ' SL.Product_Description as Product_Description,  ' +
                                ' Sl.saleLineId as saleLineId,  ' +
                                ' S.saleDate as SaleDate,  ' +
                                ' SL.ProductName as SaleProduct,  ' +
                                ' S.InvoiceDocNumber as InvoiceDocNumber,  ' +
                                ' SL.UnitofMeasureQtySold as UnitofMeasureQtySold,  ' +
                                ' SL.UnitofMeasureShipped as UnitofMeasureShipped,  ' +
                                ' SL.UnitofMeasureBackorder as UnitofMeasureBackorder,  ' +
                                ' concat (SL.UnitofMeasureSaleLines , "(" , SL.UnitofMeasureMultiplier , ")") as SalesUOM,  ' +
                                ' Convert(TreeNodeCaption(PT.Level, PT.caption ) ,char(255)) as Caption,  ' +
                                ' FE.FormulaName as FormulaName,  ' +
                                ' FE.Formula as Formula,  ' +
                                ' DescribeFormula(FE.Formula) as UFormula,  ' +
                                ' PT.TreePartUOMQuantity as Quantity,  ' +
                                ' PT.TreePartUOMTotalQty as TotalQty,  ' +

                                ' if(ifnull(PT.FromStockQty,0)=0 AND ifnull(PT.OnOrderQty,0)=0, NULL ,  PT.FormulaQtyValue1) as FormulaQtyValue1,  ' +
                                ' if(ifnull(PT.FromStockQty,0)=0 AND ifnull(PT.OnOrderQty,0)=0, NULL ,  PT.FormulaQtyValue2) as FormulaQtyValue2,  ' +
                                ' if(ifnull(PT.FromStockQty,0)=0 AND ifnull(PT.OnOrderQty,0)=0, NULL ,  PT.FormulaQtyValue3) as FormulaQtyValue3,  ' +
                                ' if(ifnull(PT.FromStockQty,0)=0 AND ifnull(PT.OnOrderQty,0)=0, NULL ,  PT.FormulaQtyValue4) as FormulaQtyValue4,  ' +
                                ' if(ifnull(PT.FromStockQty,0)=0 AND ifnull(PT.OnOrderQty,0)=0, NULL ,  PT.FormulaQtyValue5) as FormulaQtyValue5,  ' +
                                ' if(ifnull(PT.FromStockQty,0)=0 AND ifnull(PT.OnOrderQty,0)=0, NULL ,  PT.FormulaQtyValue ) as FormulaQtyValue,  ' +

                                {some of Abad foam's products (eg: ML-RANCHO ARM ASSM), don't have a formula but gor default values for the formula fields.
                                these values get populated in to the tree as the 'FormulaQtyValue' not into 'BuildFormulaQtyValue'
                                since these products dont have formula's they cannot double click to change it either

                                Need to fix it where it popultes the tree to have the default value for both  FormulaQtyValue and  BuildFormulaQtyValue
                                }
                                ' if(ifnull(PT.ManufactureQty,0)=0 , NULL ,  if(ifnull(PT.BuildFormulaQtyValue1,0)=0, PT.FormulaQtyValue1 ,PT.BuildFormulaQtyValue1) ) as BuildFormulaQtyValue1,  ' +
                                ' if(ifnull(PT.ManufactureQty,0)=0 , NULL ,  if(ifnull(PT.BuildFormulaQtyValue2,0)=0, PT.FormulaQtyValue2 ,PT.BuildFormulaQtyValue2) )  as BuildFormulaQtyValue2,  ' +
                                ' if(ifnull(PT.ManufactureQty,0)=0 , NULL ,  if(ifnull(PT.BuildFormulaQtyValue3,0)=0, PT.FormulaQtyValue3 ,PT.BuildFormulaQtyValue3) )  as BuildFormulaQtyValue3,  ' +
                                ' if(ifnull(PT.ManufactureQty,0)=0 , NULL ,  if(ifnull(PT.BuildFormulaQtyValue4,0)=0, PT.FormulaQtyValue4 ,PT.BuildFormulaQtyValue4) )  as BuildFormulaQtyValue4,  ' +
                                ' if(ifnull(PT.ManufactureQty,0)=0 , NULL ,  if(ifnull(PT.BuildFormulaQtyValue5,0)=0, PT.FormulaQtyValue5 ,PT.BuildFormulaQtyValue5) )  as BuildFormulaQtyValue5,  ' +
                                ' if(ifnull(PT.ManufactureQty,0)=0 , NULL ,  if(ifnull(PT.BuildFormulaQtyValue ,0)=0, PT.FormulaQtyValue ,PT.BuildFormulaQtyValue) )  as BuildFormulaQtyValue,  ' +

                                ' BOMTypetoStr(PT.PartSource) as PartSource,  ' +
                                ' PT.selected as selected,  ' +
                                ' InputTypetoStr(Pt.InputType) as InputType,  ' +
                                ' PT.Price as PriceinTree,  ' +
                                ' PT.Cost as CostinTree,  ' +
                                ' concat(PT.TreePartUOM,"(", PT.TreePartUOMMultiplier,")") as TreeUOM,  ' +
                                ' convert(PT.info , char(255)) as info,  ' +
                                ' '+extrafields +
                                ' InputTypetoStr(ifnull(ParentPt.InputType,"itNone")) as parentInputType  ' +
                                ' FROM  ' +
                                ' tblsales S  ' +
                                ' inner join tblsaleslines SL on S.saleId = Sl.saleId  ' +
                                ' inner join tblProcTree PT   on PT.MasterId = Sl.saleLineid and PT.Mastertype <> "mtProduct"  ' +
                                ' '+extraTables +
                                ' Left join tblProcTree ParentPt on ParentPt.ProcTreeId = Pt.ParentID  ' +
                                ' Left join tblfeformula FE on FE.FormulaID = PT.formulaid  ' +
                                ' where S.IsSalesOrder ="T" /*and ifnull(pt.parentID,0) <> 0*/ and S.ShipDate Between ' + quotedstr(formatDatetime(mysqlDatetimeformat , filterDatefrom))+' and ' + quotedstr(formatDatetime(mysqlDatetimeformat , Filterdateto))+'  ' +
                                ' Order by S.saleId desc , SL.saleLineId,  SL.Productname ,SL.saleLineId,  PT.sequencedown; ');


      clog(SQL.Text);
        showProgressbar(WAITMSG, SQL.count);
        try
          Execute;
        finally
          HideProgressbar;
        end;
  end;

end;

procedure TBOMSalesSubProductsListGUI.RefreshQuery;
begin
  With scriptmain do SQL.clear;
  PopulateData;

  showProgressbar(WAITMSG, 10);
  try
    stepProgressbar;
    inherited;
    GuiPrefs.DbGridElement[grdmain].FieldGroupname[QrymainBuildFormulaQtyValue1.fieldname] :=Appenv.companyPrefs.Fe1Name;
    GuiPrefs.DbGridElement[grdmain].FieldGroupname[QrymainBuildFormulaQtyValue2.fieldname] :=Appenv.companyPrefs.Fe2Name;
    GuiPrefs.DbGridElement[grdmain].FieldGroupname[QrymainBuildFormulaQtyValue3.fieldname] :=Appenv.companyPrefs.Fe3Name;
    GuiPrefs.DbGridElement[grdmain].FieldGroupname[QrymainBuildFormulaQtyValue4.fieldname] :=Appenv.companyPrefs.Fe4Name;
    GuiPrefs.DbGridElement[grdmain].FieldGroupname[QrymainBuildFormulaQtyValue5.fieldname] :=Appenv.companyPrefs.Fe5Name;

    GuiPrefs.DbGridElement[grdmain].FieldGroupname[qryMainFormulaQtyValue1.fieldname] :=Appenv.companyPrefs.Fe1Name;
    GuiPrefs.DbGridElement[grdmain].FieldGroupname[qryMainFormulaQtyValue2.fieldname] :=Appenv.companyPrefs.Fe2Name;
    GuiPrefs.DbGridElement[grdmain].FieldGroupname[qryMainFormulaQtyValue3.fieldname] :=Appenv.companyPrefs.Fe3Name;
    GuiPrefs.DbGridElement[grdmain].FieldGroupname[qryMainFormulaQtyValue4.fieldname] :=Appenv.companyPrefs.Fe4Name;
    GuiPrefs.DbGridElement[grdmain].FieldGroupname[qryMainFormulaQtyValue5.fieldname] :=Appenv.companyPrefs.Fe5Name;

    stepProgressbar;
  finally
    HideProgressbar;
  end;
  grpFiltersclick(grpFilters);

end;

procedure TBOMSalesSubProductsListGUI.SetGridColumns;
begin
  inherited;
   RemoveFieldfromGrid(qrymaininputtype.fieldname);
   RemoveFieldfromGrid(qrymainRownum.fieldname);
   RemoveFieldfromGrid(qrymainSalelineId.fieldname);

  if Appenv.companyPrefs.Fe1Visible then else RemoveFieldfromGrid(qrymainBuildFormulaQtyValue1.fieldname);
  if Appenv.companyPrefs.Fe2Visible then else RemoveFieldfromGrid(qrymainBuildFormulaQtyValue2.fieldname);
  if Appenv.companyPrefs.Fe3Visible then else RemoveFieldfromGrid(qrymainBuildFormulaQtyValue3.fieldname);
  if Appenv.companyPrefs.Fe4Visible then else RemoveFieldfromGrid(qrymainBuildFormulaQtyValue4.fieldname);
  if Appenv.companyPrefs.Fe5Visible then else RemoveFieldfromGrid(qrymainBuildFormulaQtyValue5.fieldname);
  if Appenv.companyPrefs.FeFieldVisible then else RemoveFieldfromGrid(qrymainBuildFormulaQtyValue.fieldname);

end;

procedure TBOMSalesSubProductsListGUI.AfterPopup(Popupform: TComponent);
begin
  inherited;
end;

function TBOMSalesSubProductsListGUI.ExpressDetailListName: String;
begin
  REsult := 'TBOMSalesSubProductsDetailListGUI';
end;

Function TBOMSalesSubProductsListGUI.extraFields:String;begin result := ''; end;
Function TBOMSalesSubProductsListGUI.ExtraTables:String;begin result := ''; end;

initialization
  RegisterClassOnce(TBOMSalesSubProductsListGUI);

end.
