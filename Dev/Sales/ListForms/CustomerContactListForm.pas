unit CustomerContactListForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TCustomerContactListGui = class(TBaseListingGUI)
    qryMainClientId: TIntegerField;
    qryMainContactId: TIntegerField;
    qryMainCompany: TWideStringField;
    qryMainClientName: TWideStringField;
    qryMainContactTitle: TWideStringField;
    qryMainContactFirstName: TWideStringField;
    qryMainContactSurName: TWideStringField;
    qryMainJobTitle: TWideStringField;
    qryMainContactAddress: TWideStringField;
    qryMainContactAddress2: TWideStringField;
    qryMainContactAddress3: TWideStringField;
    qryMainContactCity: TWideStringField;
    qryMainContactState: TWideStringField;
    qryMainContactPCode: TWideStringField;
    qryMainContactCountry: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainAltPhone: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainFax: TWideStringField;
    qryMainEMail: TWideStringField;
    qryMainPrimaryContact: TWideStringField;
    qryMainCardNumber: TWideStringField;
    qryMainAccountNo: TWideStringField;
    qryMainTeamViewerId: TWideStringField;
    qryMainActive: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure grpFiltersClick(Sender: TObject);override;
  private
    fTransConnection: TERPConnection;
    procedure MakeQrymain(const Fields : String; Tables: String);Overload;
    procedure MakeQrymain;Overload;
    Function MasterID:Integer;
  Protected
    Function Listconnection:TERPConnection; Override;
    procedure SetGridColumns; Override;
  public
    property TransConnection: TERPConnection read fTransConnection write fTransConnection;
    Procedure RefreshQuery;Override;
  end;


implementation

uses CustomFieldListLib, Busobjcustomfields, CommonLib, LogLib, frmCustomerFrm;

{$R *.dfm}

procedure TCustomerContactListGui.FormCreate(Sender: TObject);
begin
  MakeQrymain;
  inherited;
  HaveDateRangeSelection := False;

end;
procedure TCustomerContactListGui.grpFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('Active' , ['T','F','']);
  inherited;

end;

function TCustomerContactListGui.Listconnection: TERPConnection;
begin
  if assigned(fTransConnection) then Result := fTransConnection
  else result := inherited Listconnection;
end;
Procedure TCustomerContactListGui.MakeQrymain;
begin
    CustomfieldlistSQL(ltContact, qrymain, 'CON.ContactId' , MakeQrymain , MasterID);
end;

function TCustomerContactListGui.MasterID: Integer;
begin
  result := 0;
  if not(Assigned(Owner)) then exit;
  if owner is TfrmCustomer then begin result := TfrmCustomer(Owner).qryCustomersClientID.asInteger; exit;end;
end;

Procedure TCustomerContactListGui.MakeQrymain(const Fields : String; Tables: String);
begin
    closedb(Qrymain);
    Qrymain.sql.clear;
    Qrymain.sql.Add('select ');
    Qrymain.sql.Add('C.ClientId           as ClientId, ');
    Qrymain.sql.Add('CON.ContactId        as ContactId, ');
    Qrymain.sql.Add('CON.ClientName       as Company, ');
    Qrymain.sql.Add('CON.Company          as ClientName, ');
    Qrymain.sql.Add('CON.ContactTitle     as ContactTitle, ');
    Qrymain.sql.Add('CON.ContactFirstName as ContactFirstName, ');
    Qrymain.sql.Add('CON.ContactSurName   as ContactSurName, ');
    Qrymain.sql.Add('CON.JobTitle         as JobTitle, ');
    Qrymain.sql.Add('CON.ContactAddress   as ContactAddress, ');
    Qrymain.sql.Add('CON.ContactAddress2  as ContactAddress2, ');
    Qrymain.sql.Add('CON.ContactAddress3  as ContactAddress3, ');
    Qrymain.sql.Add('CON.ContactCity      as ContactCity, ');
    Qrymain.sql.Add('CON.ContactState     as ContactState,   ');
    Qrymain.sql.Add('ContactPCode         as ContactPCode, ');
    Qrymain.sql.Add('ContactCountry       as ContactCountry, ');
    Qrymain.sql.Add('CON.ContactPH        as Phone, ');
    Qrymain.sql.Add('CON.ContactAltPh     as AltPhone, ');
    Qrymain.sql.Add('CON.ContactMOB       as Mobile, ');
    Qrymain.sql.Add('CON.ContactFax       as Fax, ');
    Qrymain.sql.Add('CON.ContactEMail     as EMail, ');
    Qrymain.sql.Add('CON.IsPrimaryContact as PrimaryContact, ');
    Qrymain.sql.Add('CON.CardNumber       as CardNumber, ');
    Qrymain.sql.Add('CON.AccountNo        as AccountNo, ');
    Qrymain.sql.Add('CON.TeamViewerId     as TeamViewerId, ');
    Qrymain.sql.Add(Fields);
    Qrymain.sql.Add('CON.Active           as Active ');
    Qrymain.sql.Add('FROM tblcontacts CON ');
    Qrymain.sql.Add('inner join tblclients C  on CON.ClientID = C.ClientID ');
    Qrymain.sql.Add(Tables);
    Qrymain.sql.Add('where C.Customer = "T" ');
    Qrymain.sql.Add('Order by Company');
end;

procedure TCustomerContactListGui.RefreshQuery;
begin
  clog(qrymain.sql.text);
  inherited;

end;
procedure TCustomerContactListGui.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainclientid.fieldname);
  RemoveFieldfromGrid(qrymaincontactId.fieldname);
end;

initialization

  RegisterClassOnce(TCustomerContactListGui);

end.
