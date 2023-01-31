unit PaymentDepartmentMismatch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, kbmMemTable,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  DAScript, MyScript, wwcheckbox;

type
  TPaymentDepartmentMismatchGUI = class(TBaseListingGUI)
    qryMainPaymentClass: TWideStringField;
    qryMainSalesClass: TWideStringField;
    qryMainCustomerName: TWideStringField;
    qryMainSaleDate: TDateField;
    qryMainTotalAmountInc: TFloatField;
    qryMainPaymentDate: TDateField;
    qryMainPayment: TFloatField;
    qryMainPaymentID: TIntegerField;
    qryMainCategory: TWideStringField;
    qryMainTransactionID: TIntegerField;
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses CommonLib, CommonFormLib, FastFuncs;

{$R *.dfm}
procedure TPaymentDepartmentMismatchGUI.grdMainDblClick(Sender: TObject);
var
  fsFieldname :String;
begin
  fsfieldname := grdmain.getactivefield.fieldname;

  if (Sysutils.SameText(fsFieldname , 'TransactionID')) or
      (Sysutils.SameText(fsFieldname , 'SalesClass')) or
      (Sysutils.SameText(fsFieldname , 'TotalAmountInc')) or
      (Sysutils.SameText(fsFieldname , 'SaleDate')) then begin
      if Sysutils.SameText(qryMainCategory.asString , 'Invoice') then begin
        OpenERPForm('TInvoiceGUI' , qryMainTransactionID.asInteger );
      end else begin
        OpenERPForm('TfmCustPrepayments' , qryMainTransactionID.asInteger );
      end;
  end else if (Sysutils.SameText(fsFieldname , 'PaymentClass')) or
      (Sysutils.SameText(fsFieldname , 'PaymentDate')) or
      (Sysutils.SameText(fsFieldname , 'Payment')) or
      (Sysutils.SameText(fsFieldname , 'PaymentID')) then begin
      OpenERPForm('TfmCustPayments' , qryMainPaymentID.asInteger );
  end else inherited;
end;

initialization
  RegisterClassOnce(TPaymentDepartmentMismatchGUI);

end.
