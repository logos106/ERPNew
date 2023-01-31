unit ProductstoExcludeDefaultTaxCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TProductstoExcludeDefaultTaxCodeGUI = class(TBaseListingGUI)
    qryMainProductName: TWideStringField;
    qryMainClientName: TWideStringField;
    qryMainActive: TWideStringField;
    qryMainClientID: TIntegerField;
    qryMainID: TIntegerField;
    qryMainProductTAXCODE: TWideStringField;
    qryMainCustomerDefaultTaxCode: TWideStringField;
  private
  Protected
    procedure SetGridColumns; Override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib;

{$R *.dfm}

{ TProductstoExcludeDefaultTaxCodeGUI }

procedure TProductstoExcludeDefaultTaxCodeGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(Qrymainid.fieldname);
  RemoveFieldfromGrid(QrymainclientID.fieldname);
end;

initialization
  RegisterClassOnce(TProductstoExcludeDefaultTaxCodeGUI);

end.

