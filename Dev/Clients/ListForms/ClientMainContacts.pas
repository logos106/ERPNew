unit ClientMainContacts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TClientMainContactsGUI = class(TBaseListingGUI)
    qryMainclientId: TIntegerField;
    qryMainCompany: TWideStringField;
    qryMainEmail: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainIsJob: TWideStringField;
    qryMainIsCustomer: TWideStringField;
    qryMainIsSupplier: TWideStringField;
    qryMainIsOtherContact: TWideStringField;
    qryMainMainContactforCashSale: TWideStringField;
    qryMainMainContactforVoucher: TWideStringField;
    qryMainMainContactforPOS: TWideStringField;
    qryMainMainContactforRefund: TWideStringField;
    qryMainMainContactforInvoice: TWideStringField;
    qryMainMainContactforSalesOrder: TWideStringField;
    qryMainMainContactforStatements: TWideStringField;
    qryMainMainContactforQuote: TWideStringField;
    qryMainMainContactforCheque: TWideStringField;
    qryMainMainContactforCredit: TWideStringField;
    qryMainMainContactforBill: TWideStringField;
    qryMainMainContactforPO: TWideStringField;
    qryMainMainContactforRA: TWideStringField;
    qryMainMainContactforRepair: TWideStringField;
    qryMainMainContactforSupplierPayment: TWideStringField;
    procedure grdMainDblClick(Sender: TObject);Override;
  private
  Protected
    procedure SetGridColumns; Override;
    //procedure AfterPopup(Popupform:TComponent);Override;
  public
  end;


implementation

uses frmCustomerFrm;

{$R *.dfm}

{ TClientMainContactsGUI }

(*procedure TClientMainContactsGUI.AfterPopup(Popupform: TComponent);
var
  i :Integer;
  function IDSelected  :Integer;
  begin

  end;
begin
  inherited;
  i :=IDSelected ;
  if i <> 0 then begin
    if Popupform is TfrmCustomer then begin
      FocuscompOnform(Popupform ,TfrmCustomer(Popupform).TabCtl20 ,TfrmCustomer(Popupform).Customer_Info , TfrmCustomer(Popupform).grdContact , qryContacts , 'contactID' , i)
    end;
  end;
end;*)

procedure TClientMainContactsGUI.grdMainDblClick(Sender: TObject);
begin
       if Sametext(Activefieldname , qrymainiscustomer.FieldName    ) and QrymainIsCustomer.asBoolean     then SubsequentID := Chr(95) + 'Customer'
  else if Sametext(Activefieldname , qrymainisSupplier.FieldName    ) and QrymainIsSupplier.asBoolean     then SubsequentID := Chr(95) + 'Supplier'
  else if Sametext(Activefieldname , qrymainisJob.FieldName         ) and QrymainIsJob.asBoolean          then SubsequentID := Chr(95) + 'Job'
  else if Sametext(Activefieldname , qrymainisOthercontact.FieldName) and QrymainIsOthercontact.asBoolean then SubsequentID := Chr(95) + 'Othercontact'
  else if QrymainIscustomer.asBoolean     then SubsequentID := Chr(95) + 'Customer'
  else if QrymainIsSupplier.asBoolean     then SubsequentID := Chr(95) + 'Supplier'
  else if QrymainIsJob.asBoolean          then SubsequentID := Chr(95) + 'Job'
  else if QrymainIsOthercontact.asBoolean then SubsequentID := Chr(95) + 'Othercontact'
  else exit;
  inherited;
end;

procedure TClientMainContactsGUI.SetGridColumns;
begin
  RemoveFieldfromGrid(QrymainclientID.FieldName);
(*  RemoveFieldfromGrid(qryMainMainContactforCashSaleID.FieldName);
  RemoveFieldfromGrid(qryMainMainContactforVoucherID.FieldName);
  RemoveFieldfromGrid(qryMainMainContactforPOSID.FieldName);
  RemoveFieldfromGrid(qryMainMainContactforRefundID.FieldName);
  RemoveFieldfromGrid(qryMainMainContactforInvoiceID.FieldName);
  RemoveFieldfromGrid(qryMainMainContactforSalesOrderID.FieldName);
  RemoveFieldfromGrid(qryMainMainContactforStatementsID.FieldName);
  RemoveFieldfromGrid(qryMainMainContactforQuoteID.FieldName);
  RemoveFieldfromGrid(qryMainMainContactforChequeID.FieldName);
  RemoveFieldfromGrid(qryMainMainContactforCreditID.FieldName);
  RemoveFieldfromGrid(qryMainMainContactforBillID.FieldName);
  RemoveFieldfromGrid(qryMainMainContactforPOID.FieldName);
  RemoveFieldfromGrid(qryMainMainContactforRAID.FieldName);
  RemoveFieldfromGrid(qryMainMainContactforRepairID.FieldName);*)
  inherited;
end;

initialization
  RegisterClass(TClientMainContactsGUI);

end.

