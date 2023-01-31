unit ForeignPurchaseOrderListExpress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PurchaseOrderListExpress, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TForeignPurchaseOrderListExpressGUI = class(TPurchaseOrderListExpressGUI)
    qryMainForeignExchangeCode: TWideStringField;
    qryMainForeignExchangeRate: TFloatField;
    qryMainForeignTotalAmount: TFloatField;
    qryMainForeignPaidAmount: TFloatField;
    qryMainForeignBalanceAmount: TFloatField;
    procedure btnBOListClick(Sender: TObject);
  private
    { Private declarations }
  public
    Procedure RefreshQuery;Override;
  end;

implementation

uses CommonLib, AppEnvironment, CommonFormLib;

{$R *.dfm}
{ TForeignPurchaseOrderListExpressGUI }

procedure TForeignPurchaseOrderListExpressGUI.btnBOListClick(Sender: TObject);
begin
  if OpenERPListForm('TForeignBackorderPurchaseOrderExpressGUI') then
    Close;
end;

procedure TForeignPurchaseOrderListExpressGUI.RefreshQuery;
begin
  qryMain.Params.ParamByName('Defaultcurrcode').AsString := Appenv.RegionalOptions.ForeignExDefault;
  inherited;
end;

initialization
  RegisterClassOnce(TForeignPurchaseOrderListExpressGUI);

end.

