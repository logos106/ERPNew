unit SupplierOrderShipments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel;

type
  TSupplierOrderShipmentsGUI = class(TBaseListingGUI)
    qryMainpurchaseOrderID: TIntegerField;
    qryMainPurchaseLineID: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainUnitofMeasureQtySold: TFloatField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainUOM: TWideStringField;
    qryMainTotalLineAmount: TFloatField;
    qryMainTotalLineAmountInc: TFloatField;
    qryMainPOLDate: TDateTimeField;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormCreate(Sender: TObject);
  private
    fiSmartOrderLinesID: Integer;
  Protected
    procedure SetGridColumns; Override;
    Procedure RefreshTotals;Override;
  public
    Procedure RefreshQuery; override;
    Property SmartOrderLinesID  :Integer read fiSmartOrderLinesID  write fiSmartOrderLinesID ;
  end;


implementation

uses CommonLib;

{$R *.dfm}

{ TPurchase_smart_OrderlistGUI }

procedure TSupplierOrderShipmentsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  Addcalccolumn(qryMaintotalLineAmount.fieldname , true);
  Addcalccolumn(qryMainTotalLineAmountinc.fieldname , true);
end;

procedure TSupplierOrderShipmentsGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if qryMainUnitofMeasureShipped.AsFloat =0 then
    ABrush.color := $00F7FDC6;

  if SameText(field.FieldName , qryMainUnitofMeasureQtySold.fieldname) or
      SameText(field.FieldName , qryMainUnitofMeasureShipped.fieldname) then
      if field.AsFloat = 0 then Afont.Color := Abrush.Color;
end;

procedure TSupplierOrderShipmentsGUI.RefreshQuery;
begin
  Qrymain.ParamByName('SmartOrderLinesID').asInteger := fiSmartOrderLinesID;
  inherited;
end;

procedure TSupplierOrderShipmentsGUI.RefreshTotals;
begin
  inherited;
  CalcnshowFooter;
end;

procedure TSupplierOrderShipmentsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainPurchaseLineID.fieldname);
end;

initialization
  RegisterClassOnce(TSupplierOrderShipmentsGUI);
end.

