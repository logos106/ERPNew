unit ProductExtrabuyPrices;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  DAScript, MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TProductExtrabuyPricesGUI = class(TBaseListingGUI)
    qryMainCompany: TWideStringField;
    qryMainGlobalRef: TWideStringField;
    qryMainExtraPartPriceID: TIntegerField;
    qryMainPartsID: TIntegerField;
    qryMainSupplierID: TIntegerField;
    qryMainPrice: TFloatField;
    qryMainPartName: TWideStringField;
    qryMainBuy1: TIntegerField;
    qryMainSupplierProductCode: TWideStringField;
    qryMainSupplierProductName: TWideStringField;
    qryMainUsePrice: TWideStringField;
    qryMainPrintedValue1: TFloatField;
    qryMainmsTimeStamp: TDateTimeField;
    qryMainUOM: TWideStringField;
    qryMainUOMID: TIntegerField;
    qryMainUOMMultiplier: TFloatField;
    procedure grpFiltersClick(Sender: TObject);
  private
  Protected
    Procedure SetGridColumns;Override;
  public
    Procedure RefreshQuery;Override;
  end;
implementation
uses CommonLib;
{$R *.dfm}
{ TProductExtrabuyPricesGUI }

procedure TProductExtrabuyPricesGUI.grpFiltersClick(Sender: TObject);
begin
//  inherited;
  RefreshQuery;

end;

procedure TProductExtrabuyPricesGUI.RefreshQuery;
begin
  Closedb(Qrymain);
  if grpfilters.itemindex =0 then Qrymain.parambyname('AllProducts').asString :='T' else Qrymain.parambyname('AllProducts').asString :='F';
  inherited;
end;

procedure TProductExtrabuyPricesGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('ExtraPartPriceId');
  RemoveFieldfromGrid('PartsId');
  RemoveFieldfromGrid('supplierId');
  RemoveFieldfromGrid('UOMID');
  RemoveFieldfromGrid('msTimeStamp');
  RemoveFieldfromGrid('globalref');
end;

initialization
  RegisterClassOnce(TProductExtrabuyPricesGUI);
end.
