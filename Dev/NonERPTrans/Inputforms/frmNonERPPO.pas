unit frmNonERPPO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmNonERPBase, DB, ProgressDialog, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, DBCtrls, wwdbdatetimepicker, StdCtrls, Mask, wwdbedit,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, DNMSpeedButton, Shader, DNMPanel, BusObjNonERPPO;

type
  TfmNonERPPO = class(TfmNonERPBase)
    qryMasterPurchaseOrderID: TIntegerField;
    qryMasterPurchaseOrderNumber: TWideStringField;
    qryMasterSupplierName: TWideStringField;
    qryMasterOrderTo: TWideStringField;
    qryMasterShipTo: TWideStringField;
    qryMasterOrderDate: TDateTimeField;
    qryMasterIsPO: TWideStringField;
    qryMasterIsRA: TWideStringField;
    qryMasterIsBill: TWideStringField;
    qryMasterIsCredit: TWideStringField;
    qryMasterIsCheque: TWideStringField;
    qryMasterConNote: TWideStringField;
    qryMasterERPPOID: TIntegerField;
    qrydetailsPurchaseOrderID: TIntegerField;
    qrydetailsPurchaseLineID: TIntegerField;
    qrydetailsClassID: TIntegerField;
    qrydetailsClass: TWideStringField;
    qrydetailsERPPOLineID: TIntegerField;
    qrydetailsAccountID: TIntegerField;
    qrydetailsAccountName: TWideStringField;
    qrydetailsCustomerName: TWideStringField;
    qrydetailsJobname: TWideStringField;
    qrydetailsJobNumber: TIntegerField;
    procedure qryMasterAfterOpen(DataSet: TDataSet);
  private
    NonERPPurchaseObj :TNonERPPurchase;
  Protected
    procedure NewBusObjinstance;Override;
  public
  end;


implementation

uses CommonLib, FormFactory;

{$R *.dfm}
procedure TfmNonERPPO.NewBusObjinstance;
begin
  {$WARNINGS OFF}
  NonERPPurchaseObj := TNonERPPurchase.CreateWithNewConn(Self);
  NonERPPurchaseObj.Connection.connection := Self.MyConnection;
  NonERPPurchaseObj.BusObjEvent := DoBusinessObjectEvent;
  NonERPTransObj :=NonERPPurchaseObj;
  {$WARNINGS ON}
  inherited;

end;

procedure TfmNonERPPO.qryMasterAfterOpen(DataSet: TDataSet);
begin
  inherited;
       if qryMasterIsPO.AsBoolean            then TitleLabel.caption := 'Non ERP Purchase Order'
  else if qryMasterIsRA.AsBoolean            then TitleLabel.caption := 'Non ERP Return Authority'
  else if qryMasterIsBill.AsBoolean            then TitleLabel.caption := 'Non ERP Bill'
  else if qryMasterIsCredit.AsBoolean            then TitleLabel.caption := 'Non ERP Credit'
  else if qryMasterIsCheque.AsBoolean            then TitleLabel.caption := 'Non ERP Cheque'
  else TitleLabel.caption := 'Non ERP Purchase Order';
end;

initialization
  RegisterClassOnce(TfmNonERPPO);
  with FormFact do begin
    RegisterMe(TfmNonERPPO, 'TNonERPPOListGUI_*=TransID');
  end;

end.
