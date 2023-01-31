unit UnInvoicedPOList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TUnInvoicedPOListGUI = class(TBaseListingGUI)
    qryMainPurchaseOrderID: TIntegerField;
    qryMainSupplierName: TWideStringField;
    qryMainInvoiceNumber: TWideStringField;
    qryMaininvoicedate: TDateField;
    qryMainTotalAmountInc: TFloatField;
    qryMainPayment: TFloatField;
    qryMainBalance: TFloatField;
    qryMainorderdate: TDateTimeField;

    qryMainrownum: TLargeintField;
    qryMainProductname: TWideStringField;
    qryMainuom: TWideStringField;
    qryMainUnitofMeasureQtySold: TFloatField;
    qryMainUnitofMeasureShipped: TFloatField;
    qryMainUnitofMeasureBackorder: TFloatField;
    qryMaintotallineamountinc: TFloatField;
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
  private
  Protected
    procedure SetGridColumns; Override;
    Procedure RefreshTotals;Override;
    procedure CalcFooter; Override;
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib;

{$R *.dfm}

procedure TUnInvoicedPOListGUI.CalcFooter;
begin
  if Qrymainrownum.asInteger =1 then begin
    inherited;
  end;
end;

procedure TUnInvoicedPOListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  AddCalcColumn(Qrymaintotalamountinc.FieldName, true);
end;

procedure TUnInvoicedPOListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if Qrymainrownum.asInteger >1 then begin
    if Sametext(field.fieldname , qryMainPurchaseOrderID.fieldname) or
    Sametext(field.fieldname , qryMainSupplierName.fieldname) or
    Sametext(field.fieldname , qryMainInvoiceNumber.fieldname) or
    Sametext(field.fieldname , qryMaininvoicedate.fieldname) or
    Sametext(field.fieldname , qryMainTotalAmountInc.fieldname) or
    Sametext(field.fieldname , qryMainPayment.fieldname) or
    Sametext(field.fieldname , qryMainBalance.fieldname) or
    Sametext(field.fieldname , qryMainorderdate.fieldname) then
      AFont.color := ABrush.color;
  end;
end;

procedure TUnInvoicedPOListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryMainorderdate.DisplayFormat := FormatSettings.ShortDateFormat;
end;

procedure TUnInvoicedPOListGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;

end;

procedure TUnInvoicedPOListGUI.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;

procedure TUnInvoicedPOListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainrownum.fieldname);
end;

initialization
  RegisterClass(TUnInvoicedPOListGUI);

end.
