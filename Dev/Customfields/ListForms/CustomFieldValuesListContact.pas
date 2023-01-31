unit CustomFieldValuesListContact;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustomFieldValuesListBase, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TCustomFieldValuesListContactGUI = class(TCustomFieldValuesListBaseGUI)
    grpExtraFilters: TwwRadioGroup;
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
    qryMainCustomer: TWideStringField;
    qryMainSupplier: TWideStringField;
    qryMainOtherContact: TWideStringField;
    qryMainIsJob: TWideStringField;
    qryMainActive: TWideStringField;
    qryMaintype: TWideStringField;
    procedure grpExtraFiltersClick(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
  private
  Protected
    procedure MakeQrymain;Overload;Override;
    procedure MakeQrymain(const Fields : String; Tables: String);Overload;Override;
    procedure SetGridColumns; Override;
  public
    procedure DoRefreshQuery; override;
  end;

implementation

uses CommonLib, CustomFieldListLib, CommonDbLib, AppEnvironment, LogLib;

{$R *.dfm}

{ TCustomFieldValuesListContactGUIS }
procedure TCustomFieldValuesListContactGUI.MakeQrymain;
begin
    CustomfieldlistSQL(Listtype, qrymain, 'CON.ContactId' , MakeQrymain , 0);
end;

procedure TCustomFieldValuesListContactGUI.MakeQrymain(const Fields: String;Tables: String);
(*var
  SQL1, SQL2, filename:String;
begin
            filename :='';
            InsertInToTemporaryTableusingfile(TERpconnection(Qrymain.connection), fstablename ,
                  '  select '+
                  '  C.ClientId           as ClientId, '+
                  '  CON.ContactId        as ContactId, '+
                  '  CON.ClientName       as Company, '+
                  '  CON.Company          as ClientName, '+
                  '  CON.ContactTitle     as ContactTitle, '+
                  '  CON.ContactFirstName as ContactFirstName, '+
                  '  CON.ContactSurName   as ContactSurName, '+
                  '  CON.JobTitle         as JobTitle, '+
                  '  CON.ContactAddress   as ContactAddress, '+
                  '  CON.ContactAddress2  as ContactAddress2, '+
                  '  CON.ContactAddress3  as ContactAddress3, '+
                  '  CON.ContactCity      as ContactCity, '+
                  '  CON.ContactState     as ContactState,   '+
                  '  ContactPCode         as ContactPCode, '+
                  '  ContactCountry       as ContactCountry, '+
                  '  CON.ContactPH        as Phone, '+
                  '  CON.ContactAltPh     as AltPhone, '+
                  '  CON.ContactMOB       as Mobile, '+
                  '  CON.ContactFax       as Fax, '+
                  '  CON.ContactEMail     as EMail, '+
                  '  CON.IsPrimaryContact as PrimaryContact, '+
                  '  CON.CardNumber       as CardNumber, '+
                  '  CON.AccountNo        as AccountNo, '+
                  '  CON.TeamViewerId     as TeamViewerId, '+
                  '  C.Customer           as Customer,'+
                  '  C.Supplier           as Supplier,'+
                  '  C.OtherContact       as OtherContact,'+
                  '  C.IsJob              as IsJob,'+
                  '  if(C.Supplier ="T" , "Supplier", if(C.Customer ="T" , "Customer", if(C.OtherContact ="T" , "Prospect", if(C.IsJob ="T" , "Job","" )))) as type,'+
                  Fields +' '+
                  '  CON.Active           as Active '+
                  '  FROM tblcontacts CON '+
                  '  inner join tblclients C  on CON.ClientID = C.ClientID '+
                  Tables+' '+
                  '  where C.Customer = "T" '+
                  '  Order by Company' ,
                  'ClientId,ContactId,Company,ClientName,ContactTitle,ContactFirstName,ContactSurName,JobTitle,ContactAddress,ContactAddress2,ContactAddress3,ContactCity, '+
                  'ContactState,ContactPCode,ContactCountry,Phone,AltPhone,Mobile,Fax,EMail,PrimaryContact,CardNumber,AccountNo,TeamViewerId,Customer,Supplier,'+
                  'OtherContact,IsJob,type,'+Fields +'Active ',
                  SQL1, SQL2,filename);

            With Scriptmain do try
              SQL.clear;
              SQL.add(sql1);
              SQL.add(sql2);
              clog(SQL.text);
              Execute;
              SQL.clear;
            finally
              if filename <> '' then AppEnv.UtilsClient.DeleteServerFiles(replaceStr(filename, '.tmp' , '*.tmp'));
            end;*)
begin

  With Scriptmain do try
    SQL.clear;
    SQL.add('Drop table if exists ' + fstablename +';');
    SQL.add('Create table ' + fstablename );
    SQL.add('select ');
    SQL.add('C.ClientId           as ClientId, ');
    SQL.add('CON.ContactId        as ContactId, ');
    SQL.add('CON.ClientName       as Company, ');
    SQL.add('CON.Company          as ClientName, ');
    SQL.add('CON.ContactTitle     as ContactTitle, ');
    SQL.add('CON.ContactFirstName as ContactFirstName, ');
    SQL.add('CON.ContactSurName   as ContactSurName, ');
    SQL.add('CON.JobTitle         as JobTitle, ');
    SQL.add('CON.ContactAddress   as ContactAddress, ');
    SQL.add('CON.ContactAddress2  as ContactAddress2, ');
    SQL.add('CON.ContactAddress3  as ContactAddress3, ');
    SQL.add('CON.ContactCity      as ContactCity, ');
    SQL.add('CON.ContactState     as ContactState,   ');
    SQL.add('ContactPCode         as ContactPCode, ');
    SQL.add('ContactCountry       as ContactCountry, ');
    SQL.add('CON.ContactPH        as Phone, ');
    SQL.add('CON.ContactAltPh     as AltPhone, ');
    SQL.add('CON.ContactMOB       as Mobile, ');
    SQL.add('CON.ContactFax       as Fax, ');
    SQL.add('CON.ContactEMail     as EMail, ');
    SQL.add('CON.IsPrimaryContact as PrimaryContact, ');
    SQL.add('CON.CardNumber       as CardNumber, ');
    SQL.add('CON.AccountNo        as AccountNo, ');
    SQL.add('CON.TeamViewerId     as TeamViewerId, ');
    SQL.add('C.Customer           as Customer,');
    SQL.add('C.Supplier           as Supplier,');
    SQL.add('C.OtherContact       as OtherContact,');
    SQL.add('C.IsJob              as IsJob,');
    SQL.add('if(C.Supplier ="T" , "Supplier", if(C.Customer ="T" , "Customer", if(C.OtherContact ="T" , "Prospect", if(C.IsJob ="T" , "Job","" )))) as type,');
    SQL.add(Fields);
    SQL.add('CON.Active           as Active ');
    SQL.add('FROM tblcontacts CON ');
    SQL.add('inner join tblclients C  on CON.ClientID = C.ClientID ');
    SQL.add(Tables);
    SQL.add('where C.Customer = "T" ');
    SQL.add('Order by Company');
  finally
    clog(SQL.text);
    Execute;
    SQL.clear;
  end;
end;

procedure TCustomFieldValuesListContactGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainclientID.fieldname);
  RemoveFieldfromGrid(qryMaincontactID.fieldname);

end;

procedure TCustomFieldValuesListContactGUI.DoRefreshQuery;
begin
  MakeQryMain;
  inherited;

end;

procedure TCustomFieldValuesListContactGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMain.FieldByName('Type').AsString;
  inherited;
end;

procedure TCustomFieldValuesListContactGUI.grpExtraFiltersClick(Sender: TObject);
begin
  InitGroupfilterString('type' , ['Customer','Supplier','Prospect','Job'], False ,grpExtraFilters );
  inherited grpFiltersClick(Sender);
end;
initialization
  RegisterClassOnce(TCustomFieldValuesListContactGUI);

end.
