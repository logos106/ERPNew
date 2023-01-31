unit SoldnRefundQtyofSales;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TSoldnRefundQtyofSalesGUI = class(TBaseListingGUI)
    qryMainSAleLineID: TIntegerField;
    qryMainProductname: TWideStringField;
    qryMainProduct_Description: TWideStringField;
    qryMainLinePrice: TFloatField;
    qryMainuom: TWideStringField;
    qryMainUnitofMeasureQtySold: TFloatField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainUnitofMeasureBackorder: TFloatField;
    qryMainshipped: TFloatField;
    qryMainrefundedqty: TFloatField;
    qryMainUnitofMeasureMultiplier: TFloatField;
    qryMainuomRefundQty: TFloatField;
    qryMainSaleId: TIntegerField;
    qryMainInfo: TStringField;
    sptrGrdmain: TSplitter;
    qryRefund: TERPQuery;
    qryRefundDetailID: TLargeintField;
    qryRefundSaleId: TIntegerField;
    qryRefunduom: TWideStringField;
    qryRefundrefundedqty: TFloatField;
    qryRefundUnitofMeasureMultiplier: TFloatField;
    qryRefundInfo: TWideStringField;
    dsRefund: TDataSource;
    grdRefunds: TwwDBGrid;
    wwIButton1: TwwIButton;
    qryMainProductID: TIntegerField;
    qryMainUnitOfMeasureID: TIntegerField;
    qryMainClientID: TIntegerField;
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qryMainAfterScroll(DataSet: TDataSet);
  private
    fiSAleID:Integer;
    Procedure ReadGuipref;
    Procedure WriteGuiPref;
    procedure ReOpenRefundQry;
  Protected
    procedure SetGridColumns; Override;
  public
    Property SaleID :Integer read fiSaleId write fiSAleID;
    Procedure RefreshQuery;Override;
  end;


implementation

uses DNMLib, CommonLib;

{$R *.dfm}
{ TSoldnRefundQtyofSalesGUI }

procedure TSoldnRefundQtyofSalesGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  WriteGuiPref;
end;

procedure TSoldnRefundQtyofSalesGUI.FormShow(Sender: TObject);
begin
  inherited;
  ReadGuipref;
  grdRefunds.FooterColor := grdmain.FooterColor;
  grdRefunds.TitleColor := grdmain.TitleColor;
  grdRefunds.Color := grdmain.Color;
end;

procedure TSoldnRefundQtyofSalesGUI.grdMainCalcCellColors(Sender: TObject; Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
  //if qryMainDetailID.AsInteger=2 then afont.Color := clInactiveCaptionText;
  if Qrymainshipped.asfloat < qryMainrefundedqty.asfloat then
    if Sametext(field.FieldName ,Qrymainshipped.fieldname)              or SameText(field.FieldName ,qryMainrefundedqty.fieldname) or
       SameText(field.FieldName ,qryMainUnitofMeasureShipped.fieldname) or SameText(field.FieldName ,qryMainuomRefundQty.fieldname)  then
      Abrush.color := $0075A2FF;
end;

procedure TSoldnRefundQtyofSalesGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  ReOpenRefundQry;
end;

procedure TSoldnRefundQtyofSalesGUI.qryMainAfterScroll(DataSet: TDataSet);
begin
  inherited;
  ReOpenRefundQry;
end;

Procedure TSoldnRefundQtyofSalesGUI.ReOpenRefundQry;
begin
  closedb(qryRefund);
  qryRefund.Connection := Qrymain.Connection;
  qryRefund.ParamByName('SaleLineId').AsInteger := Qrymain.fieldbyname('SaleLineId').AsInteger;
  opendb(qryRefund);
end;


procedure TSoldnRefundQtyofSalesGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryMainuomRefundQty.AsFloat :=divzer(Qrymainrefundedqty.AsFloat ,  QrymainUnitofMeasureMultiplier.AsFloat);
(*  if qryMainDetailID.AsInteger =3 then qryMainInfo.AsString := 'POS Refund - EOP is not performed'
  else if qryMainDetailID.AsInteger =2 then qryMainInfo.AsString := 'Refund'
  else qryMainInfo.AsString := 'Sale';*)
  //qryMainUOMToRefundQty.AsFloat :=divzer((Qrymainshipped.asFloat - Qrymainrefundedqty.AsFloat) ,  QrymainUnitofMeasureMultiplier.AsFloat);
end;

procedure TSoldnRefundQtyofSalesGUI.ReadGuipref;
begin
  inherited;
  if GuiPrefs.Node.Exists('Refund') then
    grdRefunds.Width := GuiPrefs.Node['Refund.PanelWidth'].asInteger;
  if sptrGrdmain.left > grdRefunds.left then
    grdRefunds.left :=sptrGrdmain.left;
end;

procedure TSoldnRefundQtyofSalesGUI.RefreshQuery;
begin
  Qrymain.ParamByName('SAleID').AsInteger := saleId;
  inherited;
end;

procedure TSoldnRefundQtyofSalesGUI.SetGridColumns;
begin
  inherited;
    RemoveFieldfromGrid(QrymainSAleLineID.FieldName);
    RemoveFieldfromGrid(QrymainProductID.FieldName);
    RemoveFieldfromGrid(Qrymainshipped.FieldName);
    RemoveFieldfromGrid(qryMainUnitOfMeasureID.FieldName);
    RemoveFieldfromGrid(Qrymainrefundedqty.FieldName);
    RemoveFieldfromGrid(QrymainUnitofMeasureMultiplier.FieldName);
    RemoveFieldfromGrid(QrymainClientID.FieldName);
end;

procedure TSoldnRefundQtyofSalesGUI.WriteGuiPref;
begin
  inherited;
  GuiPrefs.Node['Refund.PanelWidth'].asInteger := grdRefunds.Width;
end;

initialization
  RegisterClassOnce(TSoldnRefundQtyofSalesGUI);

end.

