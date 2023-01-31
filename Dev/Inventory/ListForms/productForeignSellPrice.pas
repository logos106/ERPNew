unit productForeignSellPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TproductForeignSellPriceGUI = class(TBaseListingGUI)
    qryMainCompany: TWideStringField;
    qryMainForeignPriceID: TIntegerField;
    qryMainPartName: TWideStringField;
    qryMainBuy1: TIntegerField;
    qryMainPrice1: TFloatField;
    qryMainSupplierProductCode: TWideStringField;
    qryMainSupplierProductName: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainCurrency: TWideStringField;
    qryMainCountry: TWideStringField;
    qryMainPartsId: TIntegerField;
  private
  Protected
    Procedure SetGridColumns;Override;
  public
    { Public declarations }
  end;
implementation

uses CommonLib;
{$R *.dfm}
{ TproductForeignSellPriceGUI }

procedure TproductForeignSellPriceGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('ForeignPriceId');
  RemoveFieldfromGrid('PartsId');
end;

initialization
  RegisterClassOnce(TproductForeignSellPriceGUI);
end.
