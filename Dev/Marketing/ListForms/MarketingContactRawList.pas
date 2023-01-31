unit MarketingContactRawList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook,
  Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TMarketingContactRawListGUI = class(TBaseListingGUI)
    qryMainID: TIntegerField;
    qryMainCOMPANY: TWideStringField;
    qryMainTitle: TWideStringField;
    qryMainFirstName: TWideStringField;
    qryMainMiddleName: TWideStringField;
    qryMainLastName: TWideStringField;
    qryMainStreet: TWideStringField;
    qryMainStreet2: TWideStringField;
    qryMainStreet3: TWideStringField;
    qryMainFaxNumber: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainAltPhone: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainSUBURB: TWideStringField;
    qryMainSTATE: TWideStringField;
    qryMainPOSTCODE: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainEmployeeSize: TWideStringField;
    qryMainNotes: TWideMemoField;
    qryMainJobTitle: TWideStringField;
    qryMainDateOfBirth: TDateField;
    qryMainDuration: TDateTimeField;
    qryMainSource: TWideStringField;
    qryMainActive: TWideStringField;
    procedure cmdNewClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses CommonLib, frmMarketingContact;

{$R *.dfm}
procedure TMarketingContactRawListGUI.cmdNewClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
  Form := GetComponentByClassName('TfmMarketingContact');
  if Assigned(Form) then begin
    with TfmMarketingContact(Form) do begin
      KeyId := 0;
      AttachObserver(Self);
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

initialization
  RegisterClassOnce(TMarketingContactRawListGUI);

end.
