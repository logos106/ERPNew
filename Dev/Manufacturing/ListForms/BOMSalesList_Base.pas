unit BOMSalesList_Base;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, wwclearbuttongroup,
  wwradiogroup, Shader, DNMPanel;

type
  TBOMSalesList_BaseGUI = class(TBaseListingGUI)
    qryMainSaleID: TIntegerField;
    qryMainsaleLineId: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainSaleDatetime: TDateTimeField;
    qryMainconverted: TWideStringField;
    qryMainCategory: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainFromStockUOMQty: TFloatField;
    qryMainManufactureUOMQty: TFloatField;
    qryMainOnOrderUOMQty: TFloatField;
    qryMainBuiltQty: TFloatField;
    qryMainToBeBuildQty: TFloatField;
    qryMainFormulaName: TWideStringField;
    qryMaindescFormula: TWideStringField;
    qryMainFormulaQtyValue1: TFloatField;
    qryMainFormulaQtyValue2: TFloatField;
    qryMainFormulaQtyValue3: TFloatField;
    qryMainFormulaQtyValue4: TFloatField;
    qryMainFormulaQtyValue5: TFloatField;
    qryMaincaption: TWideStringField;
    qryMainDetailedcaption: TWideStringField;
    qryMainInfo: TWideStringField;
    DNMPanel1: TDNMPanel;
    chkHideformulaDetails: TCheckBox;
    chkHideformulaAttribs: TCheckBox;
    chkHideTreeQtys: TCheckBox;
    qryMainQuantity: TFloatField;
    qryMainTotalQty: TFloatField;
    qryMainProductUnitPrice: TFloatField;
    qryMainProductUnitCost: TFloatField;
    qryMainTotalPrice: TFloatField;
    qryMainTotalcost: TFloatField;
    qryMainPrice: TFloatField;
    qryMaincost: TFloatField;
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkHideTreeQtysClick(Sender: TObject);
    procedure chkHideformulaAttribsClick(Sender: TObject);
    procedure chkHideformulaDetailsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  Protected
    function GrpfiltersItemidex :Integer ; virtual; abstract;
    Function GrpfiltersItemClassname :String;virtual;
    procedure SetGridColumns; Override;
    procedure AdjustDisplayLabels(tmpField :TField; Var s:String); Override;
    Procedure ApplyDisplayLabelFrompreference;override;
    procedure ReadnApplyGuiPrefExtra; override;
    Procedure WriteGuiPrefExtra; override;
    Procedure CopyParamsto(Sender:TObject);override;
    Procedure RefreshTotals;Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonFormLib, BOMSalesList_Details, BOMSalesList_Level1,
  BOMSalesList_Level2, BOMSalesList_Product, AppEnvironment,
  BOMSalesList_ExtraDetails;


{$R *.dfm}

{ TBOMSalesList_BaseGUI }

Procedure TBOMSalesList_BaseGUI.ApplyDisplayLabelFrompreference;
begin
  inherited;
  qryMainFormulaQtyValue1.Displaylabel := Appenv.companyPrefs.Fe1Name ;
  qryMainFormulaQtyValue2.Displaylabel := Appenv.companyPrefs.Fe2Name ;
  qryMainFormulaQtyValue3.Displaylabel := Appenv.companyPrefs.Fe3Name ;
  qryMainFormulaQtyValue4.Displaylabel := Appenv.companyPrefs.Fe4Name ;
  qryMainFormulaQtyValue5.Displaylabel := Appenv.companyPrefs.Fe5Name ;
end;


procedure TBOMSalesList_BaseGUI.AdjustDisplayLabels(tmpField: TField;  var s: String);
begin
  inherited;
  try if sametext(tmpfield.fieldname , qryMainFormulaQtyValue1.fieldname) then if Appenv.companyPrefs.Fe1Visible then s:= Appenv.companyPrefs.Fe1Name ;Except end;
  try if sametext(tmpfield.fieldname , qryMainFormulaQtyValue2.fieldname) then if Appenv.companyPrefs.Fe2Visible then s:= Appenv.companyPrefs.Fe2Name ;Except end;
  try if sametext(tmpfield.fieldname , qryMainFormulaQtyValue3.fieldname) then if Appenv.companyPrefs.Fe3Visible then s:= Appenv.companyPrefs.Fe3Name ;Except end;
  try if sametext(tmpfield.fieldname , qryMainFormulaQtyValue4.fieldname) then if Appenv.companyPrefs.Fe4Visible then s:= Appenv.companyPrefs.Fe4Name ;Except end;
  try if sametext(tmpfield.fieldname , qryMainFormulaQtyValue5.fieldname) then if Appenv.companyPrefs.Fe5Visible then s:= Appenv.companyPrefs.Fe5Name ;Except end;
end;

procedure TBOMSalesList_BaseGUI.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  AppEnv.Employee.BOMSalesList := Self.classname;
end;

procedure TBOMSalesList_BaseGUI.FormCreate(Sender: TObject);
begin
  inherited;
  if not (self is TBOMSalesList_ExtraDetailsGUI) then begin
    AddCalcColumn(qryMainTotalPrice.fieldname , true);
    AddCalcColumn(qryMainTotalcost.fieldname , true);
  end;
end;

procedure TBOMSalesList_BaseGUI.FormShow(Sender: TObject);
begin
  inherited;
       if Self is TBOMSalesList_ProductGUI      then Grpfilters.ItemIndex  :=0
  else if Self is TBOMSalesList_Level1GUI       then Grpfilters.ItemIndex  :=1
  else if Self is TBOMSalesList_Level2GUI       then Grpfilters.ItemIndex  :=2
  else if Self is TBOMSalesList_DetailsGUI      then Grpfilters.ItemIndex  :=3
  else if Self is TBOMSalesList_ExtraDetailsGUI then Grpfilters.ItemIndex  :=4;

end;

procedure TBOMSalesList_BaseGUI.grpFiltersClick(Sender: TObject);
begin
//  inherited;
if not isformshown then exit;
 if GrpfiltersItemidex = Grpfilters.ItemIndex then exit;
 if GrpfiltersItemClassname = '' then exit;

  OpenERpListForm(GrpfiltersItemClassname, CopyParamsto);
  CloseWait;

end;

function TBOMSalesList_BaseGUI.GrpfiltersItemClassname: String;
begin
       if Grpfilters.ItemIndex  =0 then result := TBOMSalesList_ProductGUI.classname
  else if Grpfilters.ItemIndex  =1 then result := TBOMSalesList_Level1GUI.classname
  else if Grpfilters.ItemIndex  =2 then result := TBOMSalesList_Level2GUI.classname
  else if Grpfilters.ItemIndex  =3 then result := TBOMSalesList_DetailsGUI.classname
  else if Grpfilters.ItemIndex  =4 then result := TBOMSalesList_ExtraDetailsGUI.classname
  else Result := '';

end;

procedure TBOMSalesList_BaseGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  chkHideformulaDetails.checked :=  GuiPrefs.Node['Options.HideformulaDetails'].AsBoolean;
  chkHideformulaAttribs.checked :=  GuiPrefs.Node['Options.HideformulaAttribs'].AsBoolean;
  chkHideTreeQtys.checked :=  GuiPrefs.Node['Options.HideTreeQtys'].AsBoolean;
end;

procedure TBOMSalesList_BaseGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;
end;

procedure TBOMSalesList_BaseGUI.Refreshtotals;
begin
  inherited;
  CalcnShowFooter;
end;

procedure TBOMSalesList_BaseGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainsalelineId.fieldname);
end;

procedure TBOMSalesList_BaseGUI.WriteGuiPrefExtra;
begin
  inherited;

end;
procedure TBOMSalesList_BaseGUI.chkHideformulaAttribsClick(Sender: TObject);
begin
  inherited;
  if not IsFormshown then exit;
  if chkHideformulaAttribs.checked then begin
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainFormulaQtyValue1.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainFormulaQtyValue2.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainFormulaQtyValue3.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainFormulaQtyValue4.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainFormulaQtyValue5.fieldname);
  end else begin
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMainFormulaQtyValue1.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMainFormulaQtyValue2.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMainFormulaQtyValue3.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMainFormulaQtyValue4.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMainFormulaQtyValue5.fieldname);
  end;
end;

procedure TBOMSalesList_BaseGUI.chkHideformulaDetailsClick(Sender: TObject);
begin
  inherited;
  if not IsFormshown then exit;
  if chkHideformulaDetails.checked then begin
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainFormulaName.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMaindescFormula.fieldname);
  end else begin
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMainFormulaName.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMaindescFormula.fieldname);
  end;
end;

procedure TBOMSalesList_BaseGUI.chkHideTreeQtysClick(Sender: TObject);
begin
  inherited;
  if not IsFormshown then exit;
  if chkHideTreeQtys.checked then begin
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainFromStockUOMQty.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainManufactureUOMQty.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainOnOrderUOMQty.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainBuiltQty.fieldname);
      GuiPrefs.DbGridElement[grdMain].RemoveField(qryMainToBeBuildQty.fieldname);
  end else begin
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMainFromStockUOMQty.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMainManufactureUOMQty.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMainOnOrderUOMQty.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMainBuiltQty.fieldname);
      GuiPrefs.DbGridElement[grdMain].AddFields(qryMainToBeBuildQty.fieldname);
  end;
end;


procedure TBOMSalesList_BaseGUI.CopyParamsto(Sender: TObject);
begin
  inherited;
  if sender is TBOMSalesList_BaseGUI then begin
    TBOMSalesList_BaseGUI(Sender).chkHideTreeQtys.Checked :=chkHideTreeQtys.Checked;
    TBOMSalesList_BaseGUI(Sender).chkHideformulaAttribs.Checked :=chkHideformulaAttribs.Checked;
    TBOMSalesList_BaseGUI(Sender).chkHideformulaDetails.Checked :=chkHideformulaDetails.Checked;
  end;
end;

end.
