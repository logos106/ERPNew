unit SpecialProducts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TSpecialProductsGUI = class(TBaseListingGUI)
    qryMainCustomerLinesID: TIntegerField;
    qryMainName: TWideStringField;
    qryMainDescription: TWideStringField;
    qryMainOrigPrice: TFloatField;
    qryMainLinePrice: TFloatField;
    qryMainCompany: TWideStringField;
    qryMainCustomerId: TIntegerField;
  private
  Protected
    Procedure SetGridColumns;Override;
  public
    { Public declarations }
  end;

implementation

uses CommonLib;

{$R *.dfm}

{ TSpecialProductsGUI }

procedure TSpecialProductsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('CustomerID');
  RemoveFieldfromGrid('CustomerLineID');
end;

initialization
  RegisterClassOnce(TSpecialProductsGUI);

end.
