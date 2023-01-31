unit CustomFieldValuesListLeads;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustomFieldValuesListBase, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup;

type
  TCustomFieldValuesListLeadsGUI = class(TCustomFieldValuesListBaseGUI)
    qryMainID: TIntegerField;
    qryMainGlobalRef: TWideStringField;
    qryMainLeadID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainCompany: TWideStringField;
    qryMainRepID: TIntegerField;
    qryMainEnteredByEmployeeID: TIntegerField;
    qryMainStreet: TWideStringField;
    qryMainStreet2: TWideStringField;
    qryMainStreet3: TWideStringField;
    qryMainSUBURB: TWideStringField;
    qryMainSTATE: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainPOSTCODE: TWideStringField;
    qryMainFaxNumber: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainAltPhone: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainSource: TWideStringField;
    qryMainCreatedOn: TDateTimeField;
    qryMainContactName: TWideStringField;
    qryMainLeadStatus: TWideStringField;
    procedure FormCreate(Sender: TObject);
  private
  Protected
    procedure MakeQrymain;Overload;Override;
    procedure MakeQrymain(const Fields : String; Tables: String);Overload;Override;
    procedure SetGridColumns; Override;
  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonLib , customfieldlistlib;

{$R *.dfm}

{ TCustomFieldValuesListLeadsGUI }
procedure TCustomFieldValuesListLeadsGUI.MakeQrymain;
begin
    CustomfieldlistSQL(Listtype, qrymain, 'ML.LeadID' , MakeQrymain , 0);
end;

procedure TCustomFieldValuesListLeadsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  HaveDateRangeSelection := True;
end;

procedure TCustomFieldValuesListLeadsGUI.MakeQrymain(const Fields: String;Tables: String);
begin
  With Scriptmain do try
    SQL.clear;
    SQL.add('Drop table if exists ' + fstablename +';');
    SQL.add('Create table ' + fstablename );
    SQL.add('SELECT');
    SQL.add('MC.ID,');
    SQL.add('ML.GlobalRef as GlobalRef,');
    SQL.add('ML.LeadID as LeadID,');
    SQL.add('ML.ClientID as ClientID,');
    SQL.add('MC.COMPANY as Company,');
    SQL.add('ML.RepID as RepID,');
    SQL.add('ML.EnteredByEmployeeID as EnteredByEmployeeID,');
    SQL.add('MC.Street as Street,');
    SQL.add('MC.Street2 as Street2,');
    SQL.add('MC.Street3 as Street3,');
    SQL.add('MC.SUBURB as SUBURB,');
    SQL.add('MC.STATE as STATE,');
    SQL.add('MC.Country as Country,');
    SQL.add('MC.POSTCODE as POSTCODE,');
    SQL.add('MC.FaxNumber as FaxNumber, ');
    SQL.add('MC.Phone as Phone,');
    SQL.add('MC.AltPhone as AltPhone,');
    SQL.add('MC.Mobile as Mobile,');
    SQL.add('MC.Source as Source,');
    SQL.add('ML.CreatedOn as CreatedOn,');
    SQL.add('CONCAT(MC.FirstName," ",MC.LastName) as ContactName,');
    SQL.add(Fields);
    SQL.add('ML.LeadStatus as LeadStatus');
    SQL.add('FROM tblMarketingLeads ML ');
    SQL.add('inner join tblmarketingcontacts  MC on (MC.ID = ML.MarketingContactID)');
    SQL.add(Tables);
    SQL.add('Where ML.IsLead <> "F"');
    SQL.add('and IfNull(ML.CreatedOn,"1899/12/31") between :DateFrom and :Dateto');
    SQL.add('AND  MC.Active = "T"');
  finally
    Execute;
    SQL.clear;
  end;
end;

procedure TCustomFieldValuesListLeadsGUI.RefreshQuery;
begin
  InitDateFromnDateto;
  inherited;
end;
procedure TCustomFieldValuesListLeadsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainID.fieldname);
  RemoveFieldfromGrid(qryMainLeadID.fieldname);
  RemoveFieldfromGrid(qryMainClientID.fieldname);
  RemoveFieldfromGrid(qryMainRepID.fieldname);
  RemoveFieldfromGrid(qryMainEnteredByEmployeeID.fieldname);
end;

initialization
  RegisterClassOnce(TCustomFieldValuesListLeadsGUI);

end.
