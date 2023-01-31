unit NonRelatedCustomer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, CustomerListForm, wwcheckbox;

type
  TNonRelatedCustomerGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainCompanyName: TWideStringField;
    qryMainCustomerType: TWideStringField;
    qryMainARBalance: TFloatField;
    qryMainAPBalance: TFloatField;
    qryMainBalance: TFloatField;
    qryMainFirstname: TWideStringField;
    qryMainLastName: TWideStringField;
    qryMainContactName: TWideStringField;
    qryMainContactdetails: TWideStringField;
    qryMainEmail: TWideStringField;
    qryMainStreet: TWideStringField;
    qryMainStreet2: TWideStringField;
    qryMainStreet3: TWideStringField;
    qryMainSuburb: TWideStringField;
    qryMainState: TWideStringField;
    qryMainPostcode: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainFaxNumber: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainAltContact: TWideStringField;
    qryMainAltPhone: TWideStringField;
    qryMainBillStreet: TWideStringField;
    qryMainBillStreet2: TWideStringField;
    qryMainBillStreet3: TWideStringField;
    qryMainBillSuburb: TWideStringField;
    qryMainBillState: TWideStringField;
    qryMainBillPostcode: TWideStringField;
    qryMainBillCountry: TWideStringField;
    qryMainAccountNo: TWideStringField;
    qryMainCUSTFLD1: TWideStringField;
    qryMainCUSTFLD2: TWideStringField;
    qryMainCUSTFLD3: TWideStringField;
    qryMainCUSTFLD4: TWideStringField;
    qryMainCUSTFLD5: TWideStringField;
    qryMainCUSTFLD6: TWideStringField;
    qryMainCUSTFLD7: TWideStringField;
    qryMainCUSTFLD8: TWideStringField;
    qryMainCUSTFLD9: TWideStringField;
    qryMainCUSTFLD10: TWideStringField;
    qryMainCUSTFLD11: TWideStringField;
    qryMainCUSTFLD12: TWideStringField;
    qryMainCUSTFLD13: TWideStringField;
    qryMainCUSTFLD14: TWideStringField;
    qryMainCUSTFLD15: TWideStringField;
    qryMainCUSTDATE1: TDateField;
    qryMainCUSTDATE2: TDateField;
    qryMainCUSTDATE3: TDateField;
    qryMainCardNumber: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainClientID: TIntegerField;
    qryMainParentClientID: TIntegerField;
    qryMainParentRelatedClientID: TIntegerField;
    qryMainCreditLimit: TFloatField;
    qryMainTermsID: TIntegerField;
    qryMainGracePeriod: TWordField;
    qryMainPickingPriority: TIntegerField;
    qryMainDefaultClass: TWideStringField;
    qryMainArea: TWideStringField;
    qryMainDischargeDate: TDateField;
    qryMainCreationDate: TDateField;
    qryMainCreditCardType: TWideStringField;
    qryMainCreditCardNumber: TWideStringField;
    qryMainCreditCardExpiryDate: TWideStringField;
    qryMainCreditCardNotes: TWideStringField;
    qryMainABN: TWideStringField;
    qryMainSOBalance: TFloatField;
  private
  Protected
    procedure SetGridColumns;override;
  public
  end;


implementation

uses CommonLib;
procedure TNonRelatedCustomerGUI.SetGridColumns;
begin
  RemoveFieldfromGrid('ClientID');
  RemoveFieldfromGrid('ParentClientID');
  RemoveFieldfromGrid('ParentRelatedClientID');
  RemoveFieldfromGrid('TermsID');
end;

{$R *.dfm}
initialization
  RegisterClassOnce(TNonRelatedCustomerGUI);

end.
