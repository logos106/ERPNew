
unit SalesOrderlistBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript,
  CustomInputBox, wwcheckbox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TSalesOrderlistBaseGUI = class(TBaseListingGUI)
    qryMainSaleDate: TDateField;
    qryMainshipdate: TDateTimeField;
    qryMainProcTreeId: TIntegerField;
    qryMainSaleId: TIntegerField;
    qryMainSaleLineID: TIntegerField;
    qryMainTreeProduct: TWideStringField;
    qryMainSupplierName: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainTreePartUOMTotalQty: TFloatField;
    qryMainFromStockUOMQty: TFloatField;
    qryMainManufactureUOMQty: TFloatField;
    qryMainOnOrderUOMQty: TFloatField;
    qryMainSOUOM: TWideStringField;
    qryMainOrdered: TFloatField;
    qryMainPOUOM: TWideStringField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainUnitofMeasureBackorder: TFloatField;
    qryMainTotalQty: TFloatField;
    qryMainFromStockQty: TFloatField;
    qryMainManufactureQty: TFloatField;
    qryMainOnOrderQty: TFloatField;
    qryMainQty: TFloatField;
    qryMainshipped: TFloatField;
    qryMainBackorder: TFloatField;
    chkUOMqty: TCheckBox;
    qryMainSmartOrderLinesID: TIntegerField;
    qryMainsmartOrderId: TIntegerField;
    qryMainCaption: TWideStringField;
    procedure chkUOMqtyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
    fiSaleLineId: Integer;
    fiProctreeId:Integer;
    procedure setsaleLineId(const Value: Integer);
    Procedure SetProctreeId(const Value:Integer);
    { Private declarations }
  Protected
    procedure SetGridColumns; Override;
    procedure SetParams(const Value: Integer);virtual;
  public
    Property salelineId :Integer read fiSaleLineId write setsaleLineId;
    Property ProctreeId :Integer read fiProctreeId write setProctreeId;
    Procedure RefreshQuery; override;
  end;

implementation

uses CommonLib;

{$R *.dfm}
procedure TSalesOrderlistBaseGUI.chkUOMqtyClick(Sender: TObject);
begin
  inherited;
  inherited;
  if chkUOMqty.checked then begin
    AddFieldtoGrid(qryMainUOM.fieldname);
    AddFieldtoGrid(qryMainTreePartUOMTotalQty.fieldname);
    AddFieldtoGrid(qryMainFromStockUOMQty.fieldname);
    AddFieldtoGrid(qryMainManufactureUOMQty.fieldname);
    AddFieldtoGrid(qryMainOnOrderUOMQty.fieldname);
    AddFieldtoGrid(qryMainSOUOM.fieldname);
    AddFieldtoGrid(qryMainOrdered.fieldname);
    AddFieldtoGrid(qryMainPOUOM.fieldname);
    AddFieldtoGrid(qryMainUnitofMeasureShipped.fieldname);
    AddFieldtoGrid(qryMainUnitofMeasureBackorder.fieldname);
    RemoveFieldfromGrid(qryMainTotalQty.fieldname);
    RemoveFieldfromGrid(qryMainFromStockQty.fieldname);
    RemoveFieldfromGrid(qryMainManufactureQty.fieldname);
    RemoveFieldfromGrid(qryMainOnOrderQty.fieldname);
    RemoveFieldfromGrid(qryMainQty.fieldname);
    RemoveFieldfromGrid(qryMainshipped.fieldname);
    RemoveFieldfromGrid(qryMainBackorder.fieldname);
  end else begin
    AddFieldtoGrid(qryMainTotalQty.fieldname);
    AddFieldtoGrid(qryMainFromStockQty.fieldname);
    AddFieldtoGrid(qryMainManufactureQty.fieldname);
    AddFieldtoGrid(qryMainOnOrderQty.fieldname);
    AddFieldtoGrid(qryMainQty.fieldname);
    AddFieldtoGrid(qryMainshipped.fieldname);
    AddFieldtoGrid(qryMainBackorder.fieldname);
    RemoveFieldfromGrid(qryMainUOM.fieldname);
    RemoveFieldfromGrid(qryMainTreePartUOMTotalQty.fieldname);
    RemoveFieldfromGrid(qryMainFromStockUOMQty.fieldname);
    RemoveFieldfromGrid(qryMainManufactureUOMQty.fieldname);
    RemoveFieldfromGrid(qryMainOnOrderUOMQty.fieldname);
    RemoveFieldfromGrid(qryMainSOUOM.fieldname);
    RemoveFieldfromGrid(qryMainOrdered.fieldname);
    RemoveFieldfromGrid(qryMainPOUOM.fieldname);
    RemoveFieldfromGrid(qryMainUnitofMeasureShipped.fieldname);
    RemoveFieldfromGrid(qryMainUnitofMeasureBackorder.fieldname);
  end;
    grdmain.columnbyname(qryMainUOM.Fieldname).Groupname                  :='Tree UOM Quantity';
    grdmain.columnbyname(qryMainTreePartUOMTotalQty.Fieldname).Groupname  :='Tree UOM Quantity';
    grdmain.columnbyname(qryMainFromStockUOMQty.Fieldname).Groupname      :='Tree UOM Quantity';
    grdmain.columnbyname(qryMainManufactureUOMQty.Fieldname).Groupname    :='Tree UOM Quantity';
    grdmain.columnbyname(qryMainOnOrderUOMQty.Fieldname).Groupname        :='Tree UOM Quantity';
    grdmain.columnbyname(qryMainSOUOM.Fieldname).Groupname                :='SmartOrder UOM Qty';
    grdmain.columnbyname(qryMainOrdered.Fieldname).Groupname              :='SmartOrder UOM Qty';
    grdmain.columnbyname(qryMainPOUOM.Fieldname).Groupname                :='PO UOM Qty';
    grdmain.columnbyname(qryMainUnitofMeasureShipped.Fieldname).Groupname :='PO UOM Qty';
    grdmain.columnbyname(qryMainUnitofMeasureBackorder.Fieldname).Groupname:='PO UOM Qty';
    grdmain.columnbyname(qryMainTotalQty.Fieldname).Groupname             :='Tree Quantity';
    grdmain.columnbyname(qryMainFromStockQty.Fieldname).Groupname         :='Tree Quantity';
    grdmain.columnbyname(qryMainManufactureQty.Fieldname).Groupname       :='Tree Quantity';
    grdmain.columnbyname(qryMainOnOrderQty.Fieldname).Groupname           :='Tree Quantity';
    grdmain.columnbyname(qryMainshipped.Fieldname).Groupname              :='PO Quantity';
    grdmain.columnbyname(qryMainBackorder.Fieldname).Groupname            :='PO Quantity';
end;

procedure TSalesOrderlistBaseGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fiSaleLineId:=0;
  fiProctreeId :=0;
end;

procedure TSalesOrderlistBaseGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
    if  (field = qryMainTreePartUOMTotalQty) or
        (field = qryMainFromStockUOMQty) or
        (field = qryMainManufactureUOMQty) or
        (field = qryMainOnOrderUOMQty) or
        (field = qryMainOrdered) or
        (field = qryMainUnitofMeasureShipped) or
        (field = qryMainUnitofMeasureBackorder) or
        (field = qryMainTotalQty) or
        (field = qryMainFromStockQty) or
        (field = qryMainManufactureQty) or
        (field = qryMainOnOrderQty) or
        (field = qryMainQty) or
        (field = qryMainshipped) or
        (field = qryMainBackorder) then
        if Field.asfloat =0 then
          AFont.color := Abrush.color;
end;


procedure TSalesOrderlistBaseGUI.RefreshQuery;
begin
  Qrymain.Parambyname('SaleLineID').asInteger := fisaleLineID;
  Qrymain.Parambyname('ProctreeId').asInteger := fiProctreeId;
  Qrymain.Parambyname('FromDate').asDatetime  := FilterDateFrom;
  Qrymain.Parambyname('toDate').asDateTime    := FilterDateto;
  inherited;

end;

procedure TSalesOrderlistBaseGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainProctreeId.fieldname);
  RemoveFieldfromGrid(qryMainSmartOrderLinesID.fieldname);
end;

procedure TSalesOrderlistBaseGUI.SetParams(const Value: Integer);
begin
  if Value <> 0 then begin
    chkIgnoreDates.visible :=False;
    cboDateRange.visible :=False;
    lblFrom.visible :=False;
    dtFrom.visible :=False;
    lblTo.visible :=False;
    dtTo.visible :=False;
  end;
end;

procedure TSalesOrderlistBaseGUI.SetProctreeId(const Value: Integer);
begin
  fiProctreeId := Value;
  SetParams(Value);
end;

procedure TSalesOrderlistBaseGUI.setsaleLineId(const Value: Integer);
begin
  fiSaleLineId := Value;
  SetParams(Value);
end;


end.

