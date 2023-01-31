unit CustomFieldValuesListSupplier;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustomFieldValuesListBase, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TCustomFieldValuesListSupplierGUI = class(TCustomFieldValuesListBaseGUI)
    qryMainClientID: TIntegerField;
    qryMainSupplierName: TWideStringField;
    qryMainPrintName: TWideStringField;
    qryMainARBalance: TFloatField;
    qryMainAPBalance: TFloatField;
    qryMainBalance: TFloatField;
    qryMainFirstname: TWideStringField;
    qryMainLastname: TWideStringField;
    qryMainPhone: TWideStringField;
    qryMainMobile: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainArea: TWideStringField;
    qryMainForeignExchangeSellCode: TWideStringField;
  private
  Protected
    procedure MakeQrymain;Overload;Override;
    procedure MakeQrymain(const Fields : String; Tables: String);Overload;Override;
    procedure SetGridColumns; Override;
  public
  end;


implementation

uses CommonLib, customfieldlistlib;

{$R *.dfm}

{ TCustomFieldValuesListSupplierGUI }
procedure TCustomFieldValuesListSupplierGUI.MakeQrymain;
begin
    CustomfieldlistSQL(Listtype, qrymain, 'CL.ClientID' , MakeQrymain , 0);
end;

procedure TCustomFieldValuesListSupplierGUI.MakeQrymain(const Fields: String;  Tables: String);
begin
  With Scriptmain do try
    SQL.clear;
    SQL.add('Drop table if exists ' + fstablename +';');
    SQL.add('Create table ' + fstablename );
    SQL.add('SELECT');
    SQL.add('CL.ClientID as ClientID,');
    SQL.add('CL.Company AS SupplierName,');
    SQL.add('CL.PrintName as PrintName,');
    SQL.add('CL.ARBalance AS "AR Balance",');
    SQL.add('CL.APBalance AS "AP Balance",');
    SQL.add('CL.Balance as Balance,');
    SQL.add('CL.FirstName as Firstname,');
    SQL.add('CL.LastName as Lastname,');
    SQL.add('CL.Phone as Phone,');
    SQL.add('CL.Mobile as Mobile,');
    SQL.add('CL.Active as Active,');
    SQL.add('CL.Area as Area,');
    SQL.add(Fields);
    SQL.add('CL.ForeignExchangeSellCode as ForeignExchangeSellCode');
    SQL.add('FROM tblClients CL');
    SQL.add(Tables);
    SQL.add('WHERE Supplier="T"');
    SQL.add('and Active = "T"');
    SQL.add('order by CL.Company');
  finally
    Execute;
    SQL.clear;
  end;
end;
procedure TCustomFieldValuesListSupplierGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainclientid.fieldname);
end;

initialization
  RegisterClassOnce(TCustomFieldValuesListSupplierGUI);

end.
