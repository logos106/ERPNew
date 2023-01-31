unit LaybyPayments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, DAScript, MyScript,
  CustomInputBox, wwcheckbox;

type
  TLaybyPaymentsGUI = class(TBaseListingGUI)
    qryMaindetails: TLargeintField;
    qryMainSaleId: TIntegerField;
    qryMainInvoiceDocNumber: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainTotalAmountInc: TFloatField;
    qryMainBalance: TFloatField;
    qryMainsaleDate: TDateField;
    qryMainPayAmount: TFloatField;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormShow(Sender: TObject);
  private
    fSaleId: integer;
    procedure SetSaleId(const Value: integer);
  Protected
    procedure SetGridColumns; Override;
  public
    Property SaleId : integer read fSaleId write SetSaleId;
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TLaybyPaymentsGUI }

procedure TLaybyPaymentsGUI.FormShow(Sender: TObject);
begin
  inherited;
  DisableSortoncolumtitleclick:= True;
end;

procedure TLaybyPaymentsGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if QrymainDetails.asInteger = 2 then
    if  //sameText(field.fieldname , QrymainInvoiceDocNumber.fieldname) or
        SameText(Field.FieldName,  qryMainSaleId.FieldName) or
        sametext(Field.FieldName , Qrymainbalance.FieldName) or
        sameText(field.fieldname , Qrymaincustomername.fieldname) or
        sameText(field.fieldname , QrymainTotalAmountinc.fieldname) then
          Afont.Color := Abrush.Color;
end;

procedure TLaybyPaymentsGUI.grdMainDblClick(Sender: TObject);
begin
  if QrymainDetails.asInteger = 1 then
  begin
    MessageDlgXP_Vista('No More Details On This Sales Order.'#13#10'You Have Came Here From The Sales Order Form',
        mtInformation, [mbOk], 0);
    exit;
  end;
  inherited;
end;

procedure TLaybyPaymentsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainDetails.fieldname);
end;

procedure TLaybyPaymentsGUI.SetSaleId(const Value: integer);
begin
  fSaleId := Value;
  qrymain.ParamByName('SaleId').AsInteger := Value;
end;

initialization
  RegisterClassOnce(TLaybyPaymentsGUI);

end.
