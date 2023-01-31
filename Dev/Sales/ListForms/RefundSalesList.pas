unit RefundSalesList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TRefundSalesListGUI = class(TBaseListingGUI)
    qryMainSaleID: TIntegerField;
    qryMainConverted: TWideStringField;
    qryMainrefundDate: TDateField;
    qryMainProductName: TWideStringField;
    qryMainRefundUOM: TWideStringField;
    qryMainUnitofMeasureQtySold: TFloatField;
    qryMainUnitofMeasureBackorder: TFloatField;
    qryMainSalesUOM: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainREfundQty: TFloatField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainRefundID: TIntegerField;
    qryMainRefundType: TWideStringField;
    qryMainSaleType: TWideStringField;
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    { Private declarations }
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib;

{$R *.dfm}
procedure TRefundSalesListGUI.grdMainDblClick(Sender: TObject);
var
  s:String;
begin
  s:=ActiveFieldName;
  if  sametext(s, QrymainProductName.fieldname) or
      sametext(s, QrymainRefundID.fieldname) or
      sametext(s, QrymainRefundType.fieldname) or
      sametext(s, QrymainConverted.fieldname) or
      sametext(s, QrymainrefundDate.fieldname) or
      sametext(s, QrymainREfundQty.fieldname) or
      sametext(s, QrymainRefundUOM.fieldname)  then
      SubsequentID := Chr(95) + qryMainRefundType.AsString
  else if sametext(s, QrymainSaleID.fieldname) or
      sametext(s, QrymainSaleType.fieldname) or
      sametext(s, QrymainSaleDate.fieldname) or
      sametext(s, QrymainUnitofMeasureShipped.fieldname) or
      sametext(s, QrymainUnitofMeasureQtySold.fieldname) or
      sametext(s, QrymainUnitofMeasureBackorder.fieldname) or
      sametext(s, QrymainSalesUOM.FieldName) then
      SubsequentID := Chr(95) + qryMainSaleType.AsString;
  inherited;

end;

procedure TRefundSalesListGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;
end;

initialization
  RegisterClassOnce(TRefundSalesListGUI);

end.

