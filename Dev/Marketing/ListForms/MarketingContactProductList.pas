unit MarketingContactProductList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  DAScript, MyScript, wwcheckbox;

type
  TMarketingContactProductListGUI = class(TBaseListingGUI)
    qryMainCOMPANY: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainStreet: TWideStringField;
    qryMainStreet2: TWideStringField;
    qryMainCompanyTypeName: TWideStringField;
    qryMainStreet3: TWideStringField;
    qryMainFaxNumber: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainAltPhone: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainSUBURB: TWideStringField;
    qryMainSTATE: TWideStringField;
    qryMainPOSTCODE: TWideStringField;
    qryMainURL: TWideStringField;
    qryMainEmployeeSize: TWideStringField;
    qryMainNotes: TWideMemoField;
    qryMainJobTitle: TWideStringField;
    qryMainTitle: TWideStringField;
    qryMainFirstName: TWideStringField;
    qryMainMiddleName: TWideStringField;
    qryMainLastName: TWideStringField;
    qryMainEmail: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainDateOfBirth: TDateField;
    qryMainDuration: TDateTimeField;
    qryMainSource: TWideStringField;
    qryMainBillStreet: TWideStringField;
    qryMainBillStreet2: TWideStringField;
    qryMainBillStreet3: TWideStringField;
    qryMainBillSuburb: TWideStringField;
    qryMainBillState: TWideStringField;
    qryMainBillPostcode: TWideStringField;
    qryMainBillCountry: TWideStringField;
    qryMainREpName: TWideStringField;
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
    qryMainCUSTDATE1: TDateTimeField;
    qryMainCUSTDATE2: TDateTimeField;
    qryMainCUSTDATE3: TDateTimeField;
    qryMainProductActive: TWideStringField;
    qryMainMCActive: TWideStringField;
    qryMainMCID: TIntegerField;
    qryMainID: TLargeintField;
  private
    { Private declarations }
  Protected
    Procedure SetGridColumns;Override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TMarketingContactProductListGUI }

procedure TMarketingContactProductListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('ID');
end;

initialization
  RegisterClassOnce(TMarketingContactProductListGUI);
end.
