unit CustomFieldValuesListEquipment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustomFieldValuesListBase, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TCustomFieldValuesListEquipmentGUI = class(TCustomFieldValuesListBaseGUI)
    qryMainGlobalRef: TWideStringField;
    qryMainEquipmentID: TIntegerField;
    qryMainProductId: TLargeintField;
    qryMainEquipmentName: TWideStringField;
    qryMainEquipmentDescription: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainISProduct: TWideStringField;
    qryMainManufacture: TWideStringField;
    qryMainModel: TWideStringField;
    qryMainSerialnumber: TWideStringField;
    qryMainOnhire: TWideStringField;
  private
  Protected
    procedure MakeQrymain;Overload;Override;
    procedure MakeQrymain(const Fields : String; Tables: String);Overload;Override;
    procedure SetGridColumns; Override;
  public
  end;


implementation

uses CommonLib, CustomFieldListLib;

{$R *.dfm}

{ TCustomFieldValuesListEquipmentGUI }
procedure TCustomFieldValuesListEquipmentGUI.MakeQrymain;
begin
    CustomfieldlistSQL(Listtype, qrymain, 'E.EquipmentID' , MakeQrymain , 0);
end;

procedure TCustomFieldValuesListEquipmentGUI.MakeQrymain(const Fields: String;Tables: String);
begin
  With Scriptmain do try
    SQL.clear;
    SQL.add('Drop table if exists ' + fstablename +';');
    SQL.add('Create table ' + fstablename );
    SQL.add('Select');
    SQL.add('E.GlobalRef as GlobalRef,');
    SQL.add('E.EquipmentID as EquipmentID,');
    SQL.add('E.ProductId as ProductId,');
    SQL.add('E.EquipmentName as EquipmentName,');
    SQL.add('E.EquipmentDescription as EquipmentDescription,');
    SQL.add('E.Active as Active,');
    SQL.add('if(ifNull(E.ProductID,0)=0 , "F" , "T") as ISProduct  ,');
    SQL.add('E.Manufacture as Manufacture,');
    SQL.add('E.Model as Model,');
    SQL.add('E.Serialnumber as Serialnumber,');
    SQL.add(Fields);
    SQL.add('E.Onhire as Onhire');
    SQL.add('from tblEquipment e');
    SQL.add(Tables);
  finally
    Execute;
    SQL.clear;
  end;
end;
procedure TCustomFieldValuesListEquipmentGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainEquipmentID.fieldname);
  RemoveFieldfromGrid(qryMainGlobalref.fieldname);
  RemoveFieldfromGrid(qryMainProductId.fieldname);

end;

initialization
  RegisterClassOnce(TCustomFieldValuesListEquipmentGUI);

end.
