unit ForeignBackorderPurchaseOrderExpress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BackorderPurchaseOrderExpress, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog,
  Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel;

type
  TForeignBackorderPurchaseOrderExpressGUI = class(TBackorderPurchaseOrderExpressGUI)
    qryMainForeignExchangeCode: TWideStringField;
    qryMainForeignExchangeRate: TFloatField;
    qryMainForeignCurrencyLineCost: TFloatField;
    qryMainForeignLineCostAmount: TFloatField;
    procedure btnPOListClick(Sender: TObject);
  private
    { Private declarations }
  public
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonFormLib, AppEnvironment, CommonLib;

{$R *.dfm}
{ TForeignBackorderPurchaseOrderExpressGUI }

procedure TForeignBackorderPurchaseOrderExpressGUI.btnPOListClick(Sender: TObject);
begin
  if OpenERPListForm('TForeignPurchaseOrderListExpressGUI') then
    Close;
end;

procedure TForeignBackorderPurchaseOrderExpressGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('Defaultcurrcode').AsString := Appenv.RegionalOptions.ForeignExDefault;
  inherited;
end;

initialization
  RegisterClassOnce(TForeignBackorderPurchaseOrderExpressGUI);

end.

