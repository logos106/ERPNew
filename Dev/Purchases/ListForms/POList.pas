unit POList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PurchaseOrderListExpress, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, StdCtrls,
  wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton, BaseInputForm;

type
  TPOListGUI = class(TPurchaseOrderListExpressGUI)
  private
    fiProctreeId: Integer;
    procedure SetProctreeId(const Value: Integer);
  Protected
    procedure AssignKeyId(Popupform: TBaseInputGUI); Override;
  public
    Property ProctreeId :Integer read fiProctreeId write SetProctreeId;
  end;


implementation

uses CommonLib, frmPurchaseOrders, CommonDbLib;

{$R *.dfm}
{ TPOListGUI }

procedure TPOListGUI.AssignKeyId(Popupform: TBaseInputGUI);
begin
  inherited;
  if popupform is TPurchaseGUI then
    TPurchaseGUI(popupform).ProctreeId :=ProctreeId ;
end;

procedure TPOListGUI.SetProctreeId(const Value: Integer);
var
  POIds:String;
begin
  fiProctreeId := Value;
  with tempMyQuery do try
    SQL.add(' SELECT purchaseorderid FROM tblpurchaselines AS POL where ProcTreeId = ' +inttostr(Value));
    open;
    POIds := Groupconcat('PurchaseOrderID');
  finally
    closenFree;
  end;
  if POIds <> '' then begin
    POIds := 'purchaseorderid  = ' + replacestr(POIds , ',' ,' or purchaseorderid  = ');
    filterString := POIDs;
  end;
end;

initialization
  RegisterClassOnce(TPOListGUI);

end.

