unit ShippingMethods;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TShippingMethodsGUI = class(TBaseListingGUI)
    qryMainShippingMethodID: TIntegerField;
    qryMainShippingMethod: TWideStringField;
    qryMainActive: TWideStringField;
  private
  Protected
    Procedure SetGridColumns;Override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TShippingMethodsGUI }

procedure TShippingMethodsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('ShippingmethodID');
end;

initialization
  RegisterClassOnce(TShippingMethodsGUI);

end.
