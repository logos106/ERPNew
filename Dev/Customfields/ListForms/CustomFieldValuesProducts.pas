unit CustomFieldValuesProducts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CustomFieldValuesBase, DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TCustomFieldValuesProductsGUI = class(TCustomFieldValuesBaseGUI)
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
    function ExtraFeilds: String;Override;
  public
  end;


implementation

uses CommonLib, Busobjcustomfields, ProductQtyLib;

{$R *.dfm}

{ TCustomFieldValuesProductsGUI }

function TCustomFieldValuesProductsGUI.ExtraFeilds: String;
begin
  FieldList := TStringlist.create;
  try
    FieldList.Add('ProductPrintName as ProductPrintName,');
    FieldList.Add(ProductQtylib.Firstcolumn('M') + ' AS FirstColumn,');
    FieldList.Add(ProductQtylib.Secondcolumn('M') +' AS SecondColumn,');
    FieldList.Add(ProductQtylib.Thirdcolumn('M') +' AS ThirdColumn,');
    FieldList.Add('PARTSDESCRIPTION as SalesDescription,');
    FieldList.Add('PURCHASEDESC as PURCHASEDESC,');
    FieldList.Add('PRICEINC1 AS PriceInc,');
    FieldList.Add('Discontinued as Discontinued,');
    FieldList.Add('PartType as PartType,');
    FieldList.Add('M.BARCODE as BARCODE,');
    FieldList.Add('M.active as Active,');
    FieldList.Add('M.ProductionNotes as ProductionNotes,');
    FieldList.Add('M.GeneralNotes as GeneralNotes,');
    FieldList.Add('M.IsSystemProduct as IsSystemProduct,');
    FieldList.Add('M.Batch,');
    FieldList.Add('M.Multiplebins,');
    FieldList.Add('M.SNtracking,');
    FieldList.Add('M.Area as Area,');
    FieldList.Add('M.PREFEREDSUPP as PreferedSupp,');
  finally
    REsult := FieldList.text;
    Freeandnil(FieldList);
  end;
end;

initialization
  RegisterClassOnce(TCustomFieldValuesProductsGUI);

end.
