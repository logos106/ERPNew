unit CustomFieldValuesListCustomer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustomFieldValuesListBase, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TCustomFieldValuesListCustomerGUI = class(TCustomFieldValuesListBaseGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainCompany: TWideStringField;
    qryMainCompanyName: TWideStringField;
    qryMainPrintname: TWideStringField;
    qryMainJobName: TWideStringField;
    qryMainJobNumber: TIntegerField;
    qryMainARBalance: TFloatField;
    qryMainAPBalance: TFloatField;
    qryMainBalance: TFloatField;
    qryMainFirstname: TWideStringField;
    qryMainLastName: TWideStringField;
    qryMainEmail: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainIsJob: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainClientID: TIntegerField;
    qryMainCreditLimit: TFloatField;
    qryMainDefaultClass: TWideStringField;
    qryMainArea: TWideStringField;
    qryMainclientcode: TWideStringField;
  private
  Protected
    procedure MakeQrymain;Overload;Override;
    procedure MakeQrymain(const Fields : String; Tables: String);Overload;Override;
  public
  end;


implementation

uses CommonLib, CustomFieldListLib;

{$R *.dfm}

{ TCustomFieldValuesListCustomerGUI }
procedure TCustomFieldValuesListCustomerGUI.MakeQrymain;
begin
    CustomfieldlistSQL(Listtype, qrymain, 'C.clientId' , MakeQrymain , 0);
end;

procedure TCustomFieldValuesListCustomerGUI.MakeQrymain(const Fields: String;Tables: String);
begin
  With Scriptmain do try
    SQL.clear;
    SQL.add('Drop table if exists ' + fstablename +';');
    SQL.add('Create table ' + fstablename );
    SQL.add('SELECT C.GlobalRef as GlobalRef,');
    SQL.add('C.Company as Company,');
    SQL.add('SUBSTRING_INDEX(C.Company,"^",1) as CompanyName,');
    SQL.add('C.Printname as Printname,');
    SQL.add('C.JobName AS JobName,');
    SQL.add('C.JobNumber AS JobNumber,');
    SQL.add('C.ARBalance AS "AR Balance",');
    SQL.add('C.APBalance AS "AP Balance",');
    SQL.add('C.Balance AS Balance,');
    SQL.add('C.FirstName as Firstname,');
    SQL.add('C.LastName as LastName,     ');
    SQL.add('C.Email AS Email,');
    SQL.add('C.Phone AS Phone,');
    SQL.add('C.Mobile AS Mobile, ');
    SQL.add('C.IsJob AS IsJob,');
    SQL.add('C.Active AS Active,');
    SQL.add('C.ClientID AS ClientID,');
    SQL.add('C.CreditLimit AS CreditLimit,');
    SQL.add('C.DefaultClass AS DefaultClass,');
    SQL.add('C.Area as Area,');
    SQL.add(Fields);
    SQL.add('C.clientcode');
    SQL.add('FROM tblClients C');
    SQL.add(Tables);
    SQL.add('WHERE (C.Customer="T" and isjob = "F") AND (char_length(C.Company) > 0)');
  finally
    Execute;
    SQL.clear;
  end;
end;
initialization
  RegisterClassOnce(TCustomFieldValuesListCustomerGUI);

end.
