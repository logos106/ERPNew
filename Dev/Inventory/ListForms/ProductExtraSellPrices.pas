unit ProductExtraSellPrices;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TProductExtraSellPriceGUI = class(TBaseListingGUI)
    qryMainPARTNAME: TWideStringField;
    qryMainTypeName: TWideStringField;
    qryMainPriceID: TIntegerField;
    qryMainQtyPercent1: TFloatField;
    qryMainDateFrom: TDateField;
    qryMainDateTo: TDateField;
    qryMainAllClients: TWideStringField;
    qryMainExtraSellDesc: TWideStringField;
    qryMainPrice1: TFloatField;
    qryMainActive: TWideStringField;
    qryMainUOM: TWideStringField;
    qryMainPartsID: TIntegerField;
  private
  Protected
    Procedure SetGridColumns;Override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TProductExtraSellPriceGUI }

procedure TProductExtraSellPriceGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('PriceId');
  RemoveFieldfromGrid('PartsId');
end;

initialization
  RegisterClassOnce(TProductExtraSellPriceGUI);

end.
