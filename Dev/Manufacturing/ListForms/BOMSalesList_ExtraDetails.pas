unit BOMSalesList_ExtraDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BOMSalesList_Base, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, DNMPanel;

type
  TBOMSalesList_ExtraDetailsGUI = class(TBOMSalesList_BaseGUI)
    qryMaincCaption: TWideStringField;
    qryMaincUOM: TWideStringField;
    qryMaincFromStockUOMQty: TFloatField;
    qryMaincManufactureUOMQty: TFloatField;
    qryMaincOnOrderUOMQty: TFloatField;
    qryMaincBuiltQty: TFloatField;
    qryMaincToBeBuildQty: TFloatField;
    qryMaincFormulaName: TWideStringField;
    qryMaincdescFormula: TWideStringField;
    qryMaincFormulaQtyValue1: TFloatField;
    qryMaincFormulaQtyValue2: TFloatField;
    qryMaincFormulaQtyValue3: TFloatField;
    qryMaincFormulaQtyValue4: TFloatField;
    qryMaincFormulaQtyValue5: TFloatField;
    qryMainiCaption: TWideStringField;
    qryMainiUOM: TWideStringField;
    qryMainiFromStockUOMQty: TFloatField;
    qryMainiManufactureUOMQty: TFloatField;
    qryMainiOnOrderUOMQty: TFloatField;
    qryMainiBuiltQty: TFloatField;
    qryMainiToBeBuildQty: TFloatField;
    qryMainiFormulaName: TWideStringField;
    qryMainidescFormula: TWideStringField;
    qryMainiFormulaQtyValue1: TFloatField;
    qryMainiFormulaQtyValue2: TFloatField;
    qryMainiFormulaQtyValue3: TFloatField;
    qryMainiFormulaQtyValue4: TFloatField;
    qryMainiFormulaQtyValue5: TFloatField;
    qryMainCQuantity: TFloatField;
    qryMainCTotalQty: TFloatField;
    qryMainCProductUnitPrice: TFloatField;
    qryMainCProductUnitCost: TFloatField;
    qryMainCTotalPrice: TFloatField;
    qryMainCTotalcost: TFloatField;
    qryMainCPrice: TFloatField;
    qryMainCcost: TFloatField;
    qryMainIQuantity: TFloatField;
    qryMainITotalQty: TFloatField;
    qryMainIProductUnitPrice: TFloatField;
    qryMainIProductUnitCost: TFloatField;
    qryMainITotalPrice: TFloatField;
    qryMainITotalcost: TFloatField;
    qryMainIPrice: TFloatField;
    qryMainIcost: TFloatField;
    procedure chkHideTreeQtysClick(Sender: TObject);
    procedure chkHideformulaAttribsClick(Sender: TObject);
    procedure chkHideformulaDetailsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  Protected
    function GrpfiltersItemidex :Integer ; Override;
    procedure AdjustDisplayLabels(tmpField :TField; Var s:String); Override;
    procedure ApplyDisplayLabelFrompreference;Override;
    Procedure CalcFooter; Override;
  public
  end;


implementation

uses CommonLib, AppEnvironment;

{$R *.dfm}

{ TBOMSalesList_ExtraDetailsGUI }
procedure TBOMSalesList_ExtraDetailsGUI.ApplyDisplayLabelFrompreference;
begin
  inherited;
  qryMaincFormulaQtyValue1.Displaylabel := Appenv.companyPrefs.Fe1Name ;
  qryMaincFormulaQtyValue2.Displaylabel := Appenv.companyPrefs.Fe2Name ;
  qryMaincFormulaQtyValue3.Displaylabel := Appenv.companyPrefs.Fe3Name ;
  qryMaincFormulaQtyValue4.Displaylabel := Appenv.companyPrefs.Fe4Name ;
  qryMaincFormulaQtyValue5.Displaylabel := Appenv.companyPrefs.Fe5Name ;

  qryMainiFormulaQtyValue1.Displaylabel := Appenv.companyPrefs.Fe1Name ;
  qryMainiFormulaQtyValue2.Displaylabel := Appenv.companyPrefs.Fe2Name ;
  qryMainiFormulaQtyValue3.Displaylabel := Appenv.companyPrefs.Fe3Name ;
  qryMainiFormulaQtyValue4.Displaylabel := Appenv.companyPrefs.Fe4Name ;
  qryMainiFormulaQtyValue5.Displaylabel := Appenv.companyPrefs.Fe5Name ;

end;
procedure TBOMSalesList_ExtraDetailsGUI.CalcFooter;
begin

  inherited;

end;

procedure TBOMSalesList_ExtraDetailsGUI.AdjustDisplayLabels(tmpField: TField;var s: String);
begin
  inherited;
  try if sametext(tmpfield.fieldname , qryMaincFormulaQtyValue1.fieldname) then if Appenv.companyPrefs.Fe1Visible then s:= Appenv.companyPrefs.Fe1Name ;Except end;
  try if sametext(tmpfield.fieldname , qryMaincFormulaQtyValue2.fieldname) then if Appenv.companyPrefs.Fe2Visible then s:= Appenv.companyPrefs.Fe2Name ;Except end;
  try if sametext(tmpfield.fieldname , qryMaincFormulaQtyValue3.fieldname) then if Appenv.companyPrefs.Fe3Visible then s:= Appenv.companyPrefs.Fe3Name ;Except end;
  try if sametext(tmpfield.fieldname , qryMaincFormulaQtyValue4.fieldname) then if Appenv.companyPrefs.Fe4Visible then s:= Appenv.companyPrefs.Fe4Name ;Except end;
  try if sametext(tmpfield.fieldname , qryMaincFormulaQtyValue5.fieldname) then if Appenv.companyPrefs.Fe5Visible then s:= Appenv.companyPrefs.Fe5Name ;Except end;

  try if sametext(tmpfield.fieldname , qryMainiFormulaQtyValue1.fieldname) then if Appenv.companyPrefs.Fe1Visible then s:= Appenv.companyPrefs.Fe1Name ;Except end;
  try if sametext(tmpfield.fieldname , qryMainiFormulaQtyValue2.fieldname) then if Appenv.companyPrefs.Fe2Visible then s:= Appenv.companyPrefs.Fe2Name ;Except end;
  try if sametext(tmpfield.fieldname , qryMainiFormulaQtyValue3.fieldname) then if Appenv.companyPrefs.Fe3Visible then s:= Appenv.companyPrefs.Fe3Name ;Except end;
  try if sametext(tmpfield.fieldname , qryMainiFormulaQtyValue4.fieldname) then if Appenv.companyPrefs.Fe4Visible then s:= Appenv.companyPrefs.Fe4Name ;Except end;
  try if sametext(tmpfield.fieldname , qryMainiFormulaQtyValue5.fieldname) then if Appenv.companyPrefs.Fe5Visible then s:= Appenv.companyPrefs.Fe5Name ;Except end;

end;

function TBOMSalesList_ExtraDetailsGUI.GrpfiltersItemidex: Integer;
begin
  Result := 4;
end;

procedure TBOMSalesList_ExtraDetailsGUI.chkHideformulaAttribsClick(    Sender: TObject);
begin
  if not IsFormshown then exit;
  inherited;
  if chkHideformulaAttribs.checked then begin
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMaincFormulaQtyValue1.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMaincFormulaQtyValue2.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMaincFormulaQtyValue3.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMaincFormulaQtyValue4.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMaincFormulaQtyValue5.fieldname);

      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainiFormulaQtyValue1.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainiFormulaQtyValue2.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainiFormulaQtyValue3.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainiFormulaQtyValue4.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainiFormulaQtyValue5.fieldname);

  end else begin
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMaincFormulaQtyValue1.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMaincFormulaQtyValue2.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMaincFormulaQtyValue3.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMaincFormulaQtyValue4.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMaincFormulaQtyValue5.fieldname);

      GuiPrefs.DbGridElement[grdMain].AddFields(qryMainiFormulaQtyValue1.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMainiFormulaQtyValue2.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMainiFormulaQtyValue3.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMainiFormulaQtyValue4.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMainiFormulaQtyValue5.fieldname);
  end;

end;

procedure TBOMSalesList_ExtraDetailsGUI.chkHideformulaDetailsClick(Sender: TObject);
begin
  if not IsFormshown then exit;
  inherited;
  if chkHideformulaDetails.checked then begin
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMaincFormulaName.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMaincdescFormula.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainiFormulaName.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainidescFormula.fieldname);
  end else begin
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMaincFormulaName.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMaincdescFormula.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMainiFormulaName.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMainidescFormula.fieldname);
  end;

end;

procedure TBOMSalesList_ExtraDetailsGUI.chkHideTreeQtysClick(Sender: TObject);
begin
  if not IsFormshown then exit;
  inherited;
  if chkHideTreeQtys.checked then begin
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMaincFromStockUOMQty.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMaincManufactureUOMQty.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMaincOnOrderUOMQty.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMaincBuiltQty.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMaincToBeBuildQty.fieldname);

      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainiFromStockUOMQty.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainiManufactureUOMQty.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainiOnOrderUOMQty.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainiBuiltQty.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainiToBeBuildQty.fieldname);

  end else begin
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMaincFromStockUOMQty.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMaincManufactureUOMQty.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMaincOnOrderUOMQty.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMaincBuiltQty.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMaincToBeBuildQty.fieldname);

      GuiPrefs.DbGridElement[grdMain].AddFields(qryMainiFromStockUOMQty.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMainiManufactureUOMQty.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMainiOnOrderUOMQty.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMainiBuiltQty.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMainiToBeBuildQty.fieldname);

  end;

end;

procedure TBOMSalesList_ExtraDetailsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  // can't show totals on the product and item level as it can have duplicates based on the number of sub components underneath on each node
  AddCalcColumn(qryMaincTotalPrice.fieldname , true);
  AddCalcColumn(qryMaincTotalcost.fieldname , true);
(*  AddCalcColumn(qryMainiTotalPrice.fieldname , true);
  AddCalcColumn(qryMainiTotalcost.fieldname , true);*)
end;
(*
Select
 @Productno:=if(@PTProctreeId <> PT.ProctreeId,  @Productno:= 1 ,  @Productno+1) Productno ,
 @PTProctreeId := PT.ProctreeId,

 @Itemno:=if(@ItemProctreeId <> PTI.ProctreeId,  @Itemno:= 1 ,  @Itemno+1) Itemno ,
 @ItemProctreeId := PTI.ProctreeId,
s.SaleID as SaleID	,
SL.saleLineId as saleLineId	,
SL.ProductName as ProductName 	,
S.CustomerName as CustomerName 	,
S.SaleDate as SaleDate	,
S.sAleDatetime as sAleDatetime	,
S.converted as converted 	,
if(S.IsInternalOrder='T' ,if(S.Converted='T' , "Finished Internal Order" , "InternalOrder") ,"Sales Order" )	as	Category	,
PT.Caption as Caption	,
concat(PT.TreePartUOM , '(' , PT.TreePartUOMMultiplier , ')') as UOM	,
PT.FromStockUOMQty as FromStockUOMQty 	,
PT.ManufactureUOMQty as ManufactureUOMQty 	,
PT.OnOrderUOMQty as OnOrderUOMQty	,
PT.ManufacturedQty	as	BuiltQty	,
PT.TotalQty - PT.ManufacturedQty	as	ToBeBuildQty 	,
PT.Quantity as Quantity,
PT.TotalQty as  TotalQty,
PT.ProductUnitPrice as ProductUnitPrice ,
PT.ProductUnitCost as ProductUnitCost,
PT.ProductUnitPrice  as TotalPrice,
PT.ProductUnitCost  as Totalcost,
PT.ProductUnitPrice  as Price,
PT.ProductUnitCost  as cost,
fe.FormulaName as FormulaName	,
DescribeFormula(fe.Formula)	as	descFormula	,
PT.FormulaQtyValue1 as FormulaQtyValue1	,
PT.FormulaQtyValue2 as FormulaQtyValue2	,
PT.FormulaQtyValue3 as FormulaQtyValue3	,
PT.FormulaQtyValue4 as FormulaQtyValue4	,
PT.FormulaQtyValue5 as FormulaQtyValue5	,
PTC.Caption as  cCaption ,
concat(PTC.TreePartUOM , '(' , PTC.TreePartUOMMultiplier , ')') as  cUOM,
PTC.FromStockUOMQty as  cFromStockUOMQty ,
PTC.ManufactureUOMQty as  cManufactureUOMQty ,
PTC.OnOrderUOMQty as  cOnOrderUOMQty,
PTC.ManufacturedQty as  cBuiltQty,
PTC.TotalQty - PTC.ManufacturedQty as  cToBeBuildQty,
PTC.Quantity as CQuantity,
PTC.TotalQty as  CTotalQty,
PTC.ProductUnitPrice as CProductUnitPrice ,
PTC.ProductUnitCost as CProductUnitCost,
PTC.TotalQty *PTC.ProductUnitPrice  as CTotalPrice,
PTC.TotalQty *PTC.ProductUnitCost  as CTotalcost,
PTC.Quantity *PTC.ProductUnitPrice  as CPrice,
PTC.Quantity *PTC.ProductUnitCost  as Ccost,

fe.FormulaName as  cFormulaName,
DescribeFormula(fe.Formula) as  cdescFormula,
PTC.FormulaQtyValue1 as  cFormulaQtyValue1,
PTC.FormulaQtyValue2 as  cFormulaQtyValue2,
PTC.FormulaQtyValue3 as  cFormulaQtyValue3,
PTC.FormulaQtyValue4 as  cFormulaQtyValue4,
PTC.FormulaQtyValue5 as  cFormulaQtyValue5,
PTI.Caption as iCaption ,
concat(PTI.TreePartUOM , '(' , PTI.TreePartUOMMultiplier , ')') as iUOM,
PTI.FromStockUOMQty as  iFromStockUOMQty ,
PTI.ManufactureUOMQty as  iManufactureUOMQty ,
PTI.OnOrderUOMQty as  iOnOrderUOMQty,
PTI.ManufacturedQty as iBuiltQty,
PTI.TotalQty - PTI.ManufacturedQty as iToBeBuildQty,
PTI.Quantity as IQuantity,
PTI.TotalQty as  ITotalQty,
PTI.ProductUnitPrice as IProductUnitPrice ,
PTI.ProductUnitCost as IProductUnitCost,
PTI.TotalQty *PTI.ProductUnitPrice  as ITotalPrice,
PTI.TotalQty *PTI.ProductUnitCost  as ITotalcost,
PTI.Quantity *PTI.ProductUnitPrice  as IPrice,
PTI.Quantity *PTI.ProductUnitCost  as Icost,
fe.FormulaName as  iFormulaName,
DescribeFormula(fe.Formula) AS idescFormula,
PTI.FormulaQtyValue1 as  iFormulaQtyValue1,
PTI.FormulaQtyValue2 as  iFormulaQtyValue2,
PTI.FormulaQtyValue3 as  iFormulaQtyValue3,
PTI.FormulaQtyValue4 as  iFormulaQtyValue4,
PTI.FormulaQtyValue5 as  iFormulaQtyValue5,
convert(concat_WS('->',PT.caption , PTI.caption, PT.caption), char(255)) as Detailedcaption
from
 (SELECT @Productno:=0) r1 ,
 (SELECT @PTProctreeId:=0) s1,
 (SELECT @Itemno:=0) r2 ,
 (SELECT @ItemProctreeId:=0) s2,

tblsales S
inner join tblsaleslines SL on S.SAleId = SL.SaleID
inner join tblproctree PT on PT.MasterId = SL.SaleLineId and PT.MasterType <> 'mtProduct' and parentId =0
Left join tblproctree PTI on PT.ProcTreeId = PTI.ParentId
Left join tblproctree PTC on PTI.ProcTreeId = PTC.ParentId
lEFT JOIN tblfeformula fe ON PTC.Formulaid = fe.FormulaID
where (S.Converted ='F' or S.IsInternalOrder = 'T') and S.IsSalesorder = 'T'
and S.SaleDate between :dateFrom and :dateTo
order by SaleId desc , saleLineId , PT.sequencedown , PTI.sequencedown , PTC.sequencedown
*)


initialization
  RegisterClassOnce(TBOMSalesList_ExtraDetailsGUI);

end.
