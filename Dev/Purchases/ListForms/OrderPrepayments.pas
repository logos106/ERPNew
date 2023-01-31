unit OrderPrepayments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TOrderPrepaymentsGUI = class(TBaseListingGUI)
    qryMaindetails: TLargeintField;
    qryMainPurchaseOrderId: TIntegerField;
    qryMainSupplierName: TWideStringField;
    qryMainTotalAmountInc: TFloatField;
    qryMainPrePaymentDate: TDateField;
    qryMainPayAmount: TFloatField;
    qryMainBalance: TFloatField;
    qryMainPrePaymentID: TLargeintField;
    qryMainPurchaseOrderNumber: TWideStringField;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure grdMainDblClick(Sender: TObject); Override;
  private
    fOriginalNo: string;
    procedure SetOriginalNo(const Value: string);
    { Private declarations }
  public
    property OriginalNo: string read fOriginalNo write SetOriginalNo;
  end;


implementation

{$R *.dfm}

{ TOrderPrepaymentsGUI }

procedure TOrderPrepaymentsGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if QrymainDetails.asInteger = 1 then
    if (*sametext(Field.FieldName , Qrymainbalance.FieldName) or*)
      sameText(field.fieldname , QrymainPrepaymentID.fieldname) or
      sametext(Field.FieldName , QrymainPrepaymentdate.FieldName) then
      Afont.Color := Abrush.Color;
  if QrymainDetails.asInteger = 2 then
    if  sameText(field.fieldname , QrymainPurchaseOrderNumber.fieldname) or
        sametext(Field.FieldName , Qrymainbalance.FieldName) or
        sameText(field.fieldname , QrymainSupplierName.fieldname) or
        sameText(field.fieldname , QrymainTotalAmountinc.fieldname) then
          Afont.Color := Abrush.Color;

end;

procedure TOrderPrepaymentsGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + 'Supplier Prepayment';
  if (qryMainPrePaymentID.AsInteger = 0) then exit;
  inherited;
  //
end;

procedure TOrderPrepaymentsGUI.SetOriginalNo(const Value: string);
begin
  fOriginalNo := Value;
  Qrymain.Parambyname('OrderOriginalRef').asString := Value;
end;

initialization
  RegisterClass(TOrderPrepaymentsGUI);

end.
