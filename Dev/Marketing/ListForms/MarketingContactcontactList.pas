unit MarketingContactcontactList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TMarketingContactcontactListGUI = class(TBaseListingGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainContactID: TIntegerField;
    qryMainMarketingContactID: TIntegerField;
    qryMainCompany: TWideStringField;
    qryMainContactTitle: TWideStringField;
    qryMainContactFirstName: TWideStringField;
    qryMainContactSurName: TWideStringField;
    qryMainContactAddress: TWideStringField;
    qryMainContactAddress2: TWideStringField;
    qryMainContactAddress3: TWideStringField;
    qryMainContactCity: TWideStringField;
    qryMainContactState: TWideStringField;
    qryMainContactPcode: TWideStringField;
    qryMainContactCountry: TWideStringField;
    qryMainContactPH: TWideStringField;
    qryMainContactAltPH: TWideStringField;
    qryMainContactMOB: TWideStringField;
    qryMainContactFax: TWideStringField;
    qryMainContactEmail: TWideStringField;
    qryMainNotes: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainCardNumber: TWideStringField;
    qryMainAccountNo: TWideStringField;
    qryMainJobTitle: TWideStringField;
    qryMainIsPrimarycontact: TWideStringField;
    qryMainMarketingContact: TWideStringField;
  private
  Protected
    Procedure SetGridColumns;Override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TMarketingContactcontactListGUI }

procedure TMarketingContactcontactListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('ContactId');
  RemoveFieldfromGrid('globalref');
  RemoveFieldfromGrid('MarketingContactID');
end;

initialization
  RegisterClassOnce(TMarketingContactcontactListGUI);

end.
