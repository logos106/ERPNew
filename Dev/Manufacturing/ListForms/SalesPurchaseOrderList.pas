unit SalesPurchaseOrderList;

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
  TSalesPurchaseOrderListGUI = class(TSalesOrderlistBaseGUI)
    qryMainpurchaseOrderId: TIntegerField;
    procedure grdMainDblClick(Sender: TObject);Override;
  private
    fiSoLineId: Integer;
    //fiProctreeId: Integer;
    //procedure setProctreeId(const Value: Integer);
    procedure setSOLineId(const Value: Integer);

    { Private declarations }
  public
    Property SOLineID:Integer read fiSoLineId write setSOLineId;
    //Property ProctreeId :Integer read fiProctreeId write setProctreeId;
    Procedure RefreshQuery;override;

  end;


implementation

uses CommonLib;

{$R *.dfm}
{ TSalesPurchaseOrderListGUI }

(* procedure TSalesPurchaseOrderListGUI.setProctreeId(const Value: Integer);
begin
  fiProctreeId := Value;
  SetParams(Value);
end; *)
procedure TSalesPurchaseOrderListGUI.grdMainDblClick(Sender: TObject);
begin
  if QrymainPurchaseOrderId.asInteger<> 0 then SubsequentID := ''
  else if QrymainsmartorderId.asInteger <> 0 then SubsequentID := Chr(95) + 'Smart Order'
  else SubsequentID := Chr(95) + 'Sales Order';
  inherited;
end;

procedure TSalesPurchaseOrderListGUI.RefreshQuery;
begin
  //Qrymain.Parambyname('ProctreeID').asInteger := fiProctreeId;
  Qrymain.Parambyname('SOLineID').asInteger := fiSOLineID;
  inherited;
end;


procedure TSalesPurchaseOrderListGUI.setSOLineId(const Value: Integer);
begin
  fiSoLineId := Value;
  SetParams(Value);
end;

initialization
  RegisterClassOnce(TSalesPurchaseOrderListGUI);

end.

