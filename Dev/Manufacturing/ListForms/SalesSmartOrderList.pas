unit SalesSmartOrderList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SalesOrderlistBase, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, BaseListingForm, DAScript,
  MyScript, CustomInputBox, wwcheckbox, wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TSalesSmartOrderListGUI = class(TSalesOrderlistBaseGUI)
    btmBOMSOPreference: TDNMSpeedButton;
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure btmBOMSOPreferenceClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Procedure BeforeShowSalesPurchaseOrderList(Sender: TObject);
  Protected

  public
  end;


implementation

uses CommonLib, CommonFormLib, SalesPurchaseOrderList, Preferences,
  AppEnvironment;

{$R *.dfm}



procedure TSalesSmartOrderListGUI.BeforeShowSalesPurchaseOrderList(
  Sender: TObject);
begin
  if not(Sender is TSalesPurchaseOrderListGUI) then exit;
  TSalesPurchaseOrderListGUI(Sender).SOLineId :=qryMainSmartOrderLinesID.asInteger;
end;

procedure TSalesSmartOrderListGUI.btmBOMSOPreferenceClick(Sender: TObject);
begin
  inherited;
  OpenPrefform('Manufacturing',  'chkAutoCreateSmartOrderFromSalesOrderTree' , 1 );
end;

procedure TSalesSmartOrderListGUI.FormShow(Sender: TObject);
begin
  inherited;
  btmBOMSOPreference.Visible :=   AppEnv.AccessLevels.GetEmployeeAccessLevel('TPreferencesGUI')<=3;
end;

procedure TSalesSmartOrderListGUI.grdMainDblClick(Sender: TObject);
begin
  if sameText(ActiveFieldname , 'POUOM') or
    sameText(ActiveFieldname , 'UnitofMeasureShipped') or
    sameText(ActiveFieldname , 'UnitofMeasureBackorder') or
    sameText(ActiveFieldname , 'Shipped') or
    sameText(ActiveFieldname , 'Backorder') then begin
    if ((Activefield is TFloatfield) and (ActiveField.asFloat =0)) or ((Activefield is TWideStringfield) and (ActiveField.asString = '')) then
    else openERPListform('TSalesPurchaseOrderListGUI' , BeforeShowSalesPurchaseOrderList);
  end else if qryMainsmartOrderId.asInteger <> 0 then
    inherited
  else CommonLib.MessageDlgXP_Vista('No further information available on this column. ', mtInformation, [mbOK], 0);

end;

initialization
  RegisterClassOnce(TSalesSmartOrderListGUI);

end.

