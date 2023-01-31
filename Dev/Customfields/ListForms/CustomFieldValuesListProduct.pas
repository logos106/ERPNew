unit CustomFieldValuesListProduct;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustomFieldValuesListBase, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TCustomFieldValuesListProductGUI = class(TCustomFieldValuesListBaseGUI)
    qryMainPARTSID: TIntegerField;
    qryMainProductName: TWideStringField;
    qryMainProductPrintName: TWideStringField;
    qryMainFirstColumn: TWideStringField;
    qryMainSecondColumn: TWideStringField;
    qryMainThirdColumn: TWideStringField;
    qryMainSalesDescription: TWideStringField;
    qryMainPURCHASEDESC: TWideStringField;
    qryMainPriceInc: TFloatField;
    qryMainDiscontinued: TWideStringField;
    qryMainPartType: TWideStringField;
    qryMainBARCODE: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainProductionNotes: TWideMemoField;
    qryMainGeneralNotes: TWideMemoField;
    qryMainIsSystemProduct: TWideStringField;
    qryMainBatch: TWideStringField;
    qryMainMultiplebins: TWideStringField;
    qryMainSNtracking: TWideStringField;
    qryMainArea: TWideStringField;
    qryMainPreferedSupp: TWideStringField;
  private
  Protected
    procedure MakeQrymain;Overload;Override;
    procedure MakeQrymain(const Fields : String; Tables: String);Overload;Override;
    procedure SetGridColumns; Override;
  public
  end;

implementation

uses ProductQtyLib, CommonLib, customfieldlistlib;

{$R *.dfm}

{ TCustomFieldValuesListProductGUI }
procedure TCustomFieldValuesListProductGUI.MakeQrymain;
begin
    CustomfieldlistSQL(Listtype, qrymain, 'P.PARTSID' , MakeQrymain , 0);
end;

procedure TCustomFieldValuesListProductGUI.MakeQrymain(const Fields: String;  Tables: String);
begin
  With Scriptmain do try
    SQL.clear;
    SQL.add('Drop table if exists ' + fstablename +';');
    SQL.add('Create table ' + fstablename );
    SQL.add('SELECT distinct');
    SQL.add('PARTSID as PARTSID,');
    SQL.add('PARTNAME as ProductName,');
    SQL.add('ProductPrintName as ProductPrintName,');
    SQL.add(Firstcolumn + ' AS FirstColumn,');
    SQL.add(Secondcolumn +' AS SecondColumn,');
    SQL.add(Thirdcolumn +' AS ThirdColumn,');
    SQL.add('PARTSDESCRIPTION as SalesDescription,');
    SQL.add('PURCHASEDESC as PURCHASEDESC,');
    SQL.add('PRICEINC1 AS PriceInc,');
    SQL.add('Discontinued as Discontinued,');
    SQL.add('PartType as PartType,');
    SQL.add('P.BARCODE as BARCODE,');
    SQL.add('P.active as Active,');
    SQL.add('P.ProductionNotes as ProductionNotes,');
    SQL.add('P.GeneralNotes as GeneralNotes,');
    SQL.add('P.IsSystemProduct as IsSystemProduct,');
    SQL.add('P.Batch,');
    SQL.add('P.Multiplebins,');
    SQL.add('P.SNtracking,');
    SQL.add('P.Area as Area,');
    SQL.add(Fields);
    SQL.add('p.PREFEREDSUPP as PreferedSupp');
    SQL.add('FROM tblparts p');
    SQL.add(Tables);
    SQL.add('Where   char_length(p.PARTNAME) > 0 AND not IsNull(p.PARTNAME)');
  finally
    Execute;
    SQL.clear;
  end;
end;
procedure TCustomFieldValuesListProductGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qryMainPartsID.fieldname);
end;

initialization
  RegisterClassOnce(TCustomFieldValuesListProductGUI);

end.
