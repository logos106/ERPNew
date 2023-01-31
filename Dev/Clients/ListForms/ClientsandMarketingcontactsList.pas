unit ClientsandMarketingcontactsList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MarketingContactList, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, ExtCtrls, MemDS, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  CustomInputBox;

type
  TClientsandMarketingcontactsListGUI = class(TMarketingContactListGUI)
    qryMainType: TWideStringField;
    qryMainTitle: TWideStringField;
    qryMainMiddleName: TWideStringField;
    qryMainStreet: TWideStringField;
    qryMainStreet2: TWideStringField;
    qryMainStreet3: TWideStringField;
    qryMainFaxNumber: TWideStringField;
    qryMainIsMc: TWideStringField;
    procedure grdMainDblClick(Sender: TObject);override;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  Protected
    Procedure MakeQry; override;
    procedure SetGridColumns; Override;
    function FilterBasedOnselection:String;Override;
    Procedure InitQrymainparams;Override;
    procedure InitformForSearchValue(const Value: String);Override;

  public
    { Public declarations }
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TClientsandMarketingcontactsListGUI }

function TClientsandMarketingcontactsListGUI.FilterBasedOnselection: String;
begin
       if grpFilters.itemindex =0 then  REsult :=  'IsMc     =' +quotedstr('T')
  else if grpFilters.itemindex =1 then  REsult :=  'Isothercontact =' +quotedstr('T')
  else if grpFilters.itemindex =2 then  REsult :=  'ISCustomer     =' +quotedstr('T')
  else if grpFilters.itemindex =3 then  REsult :=  'ISSupplier     =' +quotedstr('T')
  else REsult :=  '';

end;

procedure TClientsandMarketingcontactsListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  SearchWhenNotInlistfield:= Qrymaincompany.fieldname;
end;

procedure TClientsandMarketingcontactsListGUI.grdMainDblClick(Sender: TObject);
begin
(*       if sametext(qryMainIssupplier.FieldName )      and (qryMainIssupplier.asBoolean)     then SubsequentID := Chr(95) + 'Supp
  else if sametext(qryMainIsCustomer.FieldName )      and (qryMainIsCustomer.asBoolean)     then SubsequentID := Chr(95) + 'Cust'
  else if sametext(qryMainIsothercontact.FieldName )  and (qryMainIsothercontact.asBoolean) then SubsequentID := Chr(95) + 'OC'
  else if sametext(qryMainIsMc.FieldName )            and (qryMainIsMc.asBoolean)           then SubsequentID := Chr(95) + 'MC'
  else if qryMainIssupplier.asBoolean     then SubsequentID := Chr(95) + 'Supp
  else if qryMainIsCustomer.asBoolean     then SubsequentID := Chr(95) + 'Cust'
  else if qryMainIsothercontact.asBoolean then SubsequentID := Chr(95) + 'OC'
  else if qryMainIsMc.asBoolean           then SubsequentID := Chr(95) + 'MC'
  else exit;*)

  inherited;

end;

procedure TClientsandMarketingcontactsListGUI.InitQrymainparams;
begin
  //inherited;

end;

procedure TClientsandMarketingcontactsListGUI.MakeQry;
begin
  //inherited;
  // don't inherit - SQL already in qrymain

end;

procedure TClientsandMarketingcontactsListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainclientId.fieldname);
  RemoveFieldfromGrid(qrymainGlobalref.fieldname);
  RemoveFieldfromGrid(qrymainLeadId.fieldname);
  RemoveFieldfromGrid(qrymainId.fieldname);

end;


procedure TClientsandMarketingcontactsListGUI.InitformForSearchValue(const Value: String);
begin
  inherited;
  grpExtrafilter.ItemIndex := 2;
  grpFilters.ItemIndex := 4;
end;

initialization
  RegisterClassOnce(TClientsandMarketingcontactsListGUI);

end.

