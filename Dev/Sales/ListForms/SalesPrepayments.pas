unit SalesPrepayments;

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
  TSalesPrepaymentsGUI = class(TBaseListingGUI)
    qryMainSaleID: TIntegerField;
    qryMainInvoiceDocNumber: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainTotalAmountInc: TFloatField;
    qryMainIsInvoice: TWideStringField;
    qryMainIsQuote: TWideStringField;
    qryMainIsSalesOrder: TWideStringField;
    qryMainPrePaymentDate: TDateField;
    qryMainPayAmount: TFloatField;
    qryMainBalance: TFloatField;
    qryMaindetails: TLargeintField;
    qryMainPrePaymentID: TLargeintField;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormShow(Sender: TObject);
  private
    fsOriginalno: String;
    procedure SetOriginalno(const Value: String);
  Protected
    procedure SetGridColumns; Override;
  public
    Property Originalno :String read fsOriginalno write SetOriginalno;
  end;


implementation

uses CommonLib, tcDataUtils;

{$R *.dfm}
{ TSalesPrepaymentsGUI }

procedure TSalesPrepaymentsGUI.FormShow(Sender: TObject);
begin
  inherited;
  DisableSortoncolumtitleclick:= True;
end;

procedure TSalesPrepaymentsGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
(*  if (QrymainDetails.asInteger = 1) and (qryMainPayAmount.AsFloat <> 0) then
    ABrush.Color := clInfoBk;*)
  if QrymainDetails.asInteger = 1 then begin
    DoGreenhighlight(Afont,ABrush );
    if (*sametext(Field.FieldName , Qrymainbalance.FieldName) or*)
      sameText(field.fieldname , QrymainPrepaymentID.fieldname) or
      sametext(Field.FieldName , QrymainPrepaymentdate.FieldName) then
      Afont.Color := Abrush.Color;
  end;
  if QrymainDetails.asInteger = 2 then
    if  sameText(field.fieldname , QrymainInvoiceDocNumber.fieldname) or
        sametext(Field.FieldName , Qrymainbalance.FieldName) or
        sameText(field.fieldname , Qrymaincustomername.fieldname) or
        sameText(field.fieldname , QrymainTotalAmountinc.fieldname) or
        sameText(field.fieldname , Qrymainisinvoice.fieldname) or
        sameText(field.fieldname , QrymainIsSalesorder.fieldname) or
        sameText(field.fieldname , QrymainisQuote.fieldname) then
          Afont.Color := Abrush.Color;
end;

procedure TSalesPrepaymentsGUI.grdMainDblClick(Sender: TObject);
begin
  if SameText(ActiveFieldname,'SaleID') then begin
         if QrymainIsSalesorder.asboolean then SubsequentID := Chr(95) + 'SalesOrder'
    else if QrymainIsQuote.asboolean then SubsequentID := Chr(95) + 'Quote'
    else if QrymainIsInvoice.asboolean then SubsequentID := Chr(95) + 'Invoice'
    else SubsequentID := Chr(95) + 'Customer Prepayment';
  end else SubsequentID := Chr(95) + 'Customer Prepayment';
  if (SubsequentID = Chr(95) + 'Customer Prepayment') and (qryMainPrePaymentID.AsInteger=0) then exit
  else if QrymainsaleId.AsInteger=0 then exit;
  inherited;
end;

procedure TSalesPrepaymentsGUI.SetOriginalno(const Value: String);
begin
  fsOriginalno := Value;
  Qrymain.Parambyname('SalesOriginalRef').asString:=Value;
  if Value <> '' then begin
    ListtimerMSg('List of Sales Prepayments of ' + saletype(GetSaleIDForGlobalRef(Value))+' # ' + inttostr(GetSaleIDForGlobalRef(Value))+' and all it''s Back Orders');
  end;

end;

procedure TSalesPrepaymentsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(QrymainDetails.fieldname);
end;

initialization
  RegisterClassOnce(TSalesPrepaymentsGUI);

end.
