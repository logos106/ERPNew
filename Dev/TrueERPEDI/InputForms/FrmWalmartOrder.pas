unit FrmWalmartOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FrmWalmartBase, ExtCtrls, StdCtrls, DBCtrls, DB, Shader, DNMPanel, ProgressDialog, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts,
  DNMSpeedButton ,   ActnList, wwdbedit,
  wwcheckbox, Mask, wwdblook, wwdbdatetimepicker, Grids, Wwdbigrd, Wwdbgrid,
  BaseInputForm;

type
  TFmWalmartOrder = class(TFmWalmartBase)
    Actionlist: TActionList;
    qrywalmartorders: TERPQuery;
    dsediorders: TDataSource;
    qrywalmartordersOrderId: TIntegerField;
    qrywalmartordersGlobalRef: TWideStringField;
    qrywalmartordersEmployeeName: TWideStringField;
    qrywalmartorderspurchaseOrderId: TWideStringField;
    qrywalmartorderscustomerOrderId: TWideStringField;
    qrywalmartorderscustomerEmailId: TWideStringField;
    qrywalmartordersorderDate: TDateTimeField;
    qrywalmartordersBuyerId: TIntegerField;
    qrywalmartordersMart: TWideStringField;
    qrywalmartordersIsGuest: TWideStringField;
    qrywalmartordersShippingphone: TWideStringField;
    qrywalmartordersestimatedDeliveryDate: TDateTimeField;
    qrywalmartordersestimatedShipDate: TDateTimeField;
    qrywalmartordersShippingMethod: TWideStringField;
    qrywalmartordersPostalAddressName: TWideStringField;
    qrywalmartordersPostalAddressAddress1: TWideStringField;
    qrywalmartordersPostalAddressAddress2: TWideStringField;
    qrywalmartordersPostalAddressCity: TWideStringField;
    qrywalmartordersPostalAddressstate: TWideStringField;
    qrywalmartordersPostalAddressPostcode: TWideStringField;
    qrywalmartordersPostalAddressCountry: TWideStringField;
    qrywalmartordersPostalAddressAddresstype: TWideStringField;
    qrywalmartordersSalesSource: TWideStringField;
    qrywalmartordersERPSalesRef: TWideStringField;
    qrywalmartordersPostalAddress: TWideStringField;
    qryWalmartOrderStatus: TERPQuery;
    dsWalmartOrderStatus: TDataSource;
    qrywalmartordersValidateOrderStatusCode: TIntegerField;
    Label3: TLabel;
    txtCustomID: TDBEdit;
    cmdClose: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    pnlChooseRpt: TDNMPanel;
    chkChooseRpt: TCheckBox;
    DNMPanel1: TDNMPanel;
    pnlHeader: TDNMPanel;
    Bvlshipto: TBevel;
    SaleDate_Label: TLabel;
    Label8: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    txtShipTo: TDBMemo;
    edtEmployeename: TDBEdit;
    edtERPSalesRef: TDBEdit;
    edtorderDate: TDBEdit;
    DNMPanel2: TDNMPanel;
    pnlWalmartOrderStatus: TDNMPanel;
    Label7: TLabel;
    grdWalmartOrderStatus: TwwDBGrid;
    qryWalmartOrderStatusOrderLineId: TIntegerField;
    qryWalmartOrderStatusGlobalRef: TWideStringField;
    qryWalmartOrderStatusOrderId: TIntegerField;
    qryWalmartOrderStatusLinenumber: TWideStringField;
    qryWalmartOrderStatusProductName: TWideStringField;
    qryWalmartOrderStatussku: TWideStringField;
    qryWalmartOrderStatusQtySold: TFloatField;
    qryWalmartOrderStatusUOM: TWideStringField;
    qryWalmartOrderStatusstatusDate: TDateTimeField;
    qryWalmartOrderStatusOriginalCarrierMethod: TWideStringField;
    qryWalmartOrderStatusReferenceLineId: TWideStringField;
    qryWalmartOrderStatusFulfillmentOption: TWideStringField;
    qryWalmartOrderStatusShipMethod: TWideStringField;
    qryWalmartOrderStatusStoreId: TWideStringField;
    qryWalmartOrderStatusOfferId: TWideStringField;
    qryWalmartOrderStatusPickUpDateTime: TDateTimeField;
    qryWalmartOrderStatusPickUpBy: TWideStringField;
    qryWalmartOrderStatusIntentToCancel: TWideStringField;
    qryWalmartOrderStatusConfigId: TWideStringField;
    qryWalmartOrderStatusRefundId: TIntegerField;
    qryWalmartOrderStatusRefundComments: TWideStringField;
    qryWalmartOrderStatusERPSalesLineRef: TWideStringField;
    qryWalmartOrderStatusValidateOrderStatusCode: TIntegerField;
    qryWalmartOrderStatusmstimeStamp: TDateTimeField;
    qryWalmartOrderStatusmsUpdatesitecode: TWideStringField;
    qryWalmartOrderStatusstatus: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure cmdCloseClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure edtERPSalesRefDblClick(Sender: TObject);
    procedure qrywalmartordersCalcFields(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Procedure Openrec;
  Protected
    procedure CommitAndNotify;override;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, AppEnvironment, FormFactory, CommonFormLib,
  tcConst, CommonDbLib, BusObjSales;

{$R *.dfm}

procedure TFmWalmartOrder.cmdCancelClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TFmWalmartOrder.cmdCloseClick(Sender: TObject);
begin
  inherited;
  Self.CloseWait;
end;

procedure TFmWalmartOrder.CommitAndNotify;
begin
  inherited;
  CommitTransaction;
  Notify;

end;

procedure TFmWalmartOrder.edtERPSalesRefDblClick(Sender: TObject);
var
  soID:Integer;
begin
  inherited;
  if qryWalmartOrdersERPSalesRef.asString ='' then exit;
  soID := TSalesOrder.IDtoggle(qryWalmartOrdersERPSalesRef.asString);
  if soID =0 then exit;
  OpenERPForm('TSalesOrderGUI', soID);
end;


procedure TFmWalmartOrder.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TFmWalmartOrder.FormShow(Sender: TObject);
begin
  inherited;
  OpenRec;
  Widerform;
  cmdClose.Enabled := qrywalmartordersERPSalesRef.asString= '';
end;


procedure TFmWalmartOrder.Openrec;
begin
  closedb(qrywalmartorders);
  qrywalmartorders.SQL.Text := 'SELECT *  FROM tblWalmartOrders where OrderID = '+ inttostr(KeyID);
  Opendb(qrywalmartorders);

  closedb(qryWalmartOrderStatus);
  qryWalmartOrderStatus.SQL.Text := 'SELECT WOL.* , WOL_ERP.status '+
                              ' from  tblwalmartorderlines WOL '+
                              ' inner join  tblWalmartOrderStatus_ERP WOL_ERP on WOL.OrderId = WOL_ERP.woId and WOL.OrderLineId = WOL_ERP.wolineid '+
                              ' where WOL.OrderId= '+ inttostr(KeyID)+' '+
                              ' and WOL_ERP.ID in  (Select Max(S.ID) as maxid from tblWalmartOrderStatus_ERP S where S.WOID = WOL_ERP.WOID and S.WOLineId = WOL_ERP.WOLineID)';
  Opendb(qryWalmartOrderStatus);

  openQueries;
end;

procedure TFmWalmartOrder.qrywalmartordersCalcFields(DataSet: TDataSet);
begin
  inherited;
  qrywalmartordersPostalAddress.asString := '';
  if qrywalmartordersPostalAddressName.asString      <> '' then qrywalmartordersPostalAddress.asString := trim(qrywalmartordersPostalAddress.asString  +NL+qrywalmartordersPostalAddressName.asString);
  if qrywalmartordersPostalAddressAddress1.asString  <> '' then qrywalmartordersPostalAddress.asString := trim(qrywalmartordersPostalAddress.asString  +NL+qrywalmartordersPostalAddressAddress1.asString);
  if qrywalmartordersPostalAddressAddress2.asString  <> '' then qrywalmartordersPostalAddress.asString := trim(qrywalmartordersPostalAddress.asString  +NL+qrywalmartordersPostalAddressAddress2.asString);
  if qrywalmartordersPostalAddressCity.asString      <> '' then qrywalmartordersPostalAddress.asString := trim(qrywalmartordersPostalAddress.asString  +NL+qrywalmartordersPostalAddressCity.asString);
  if qrywalmartordersPostalAddressstate.asString     <> '' then qrywalmartordersPostalAddress.asString := trim(qrywalmartordersPostalAddress.asString  +NL+qrywalmartordersPostalAddressstate.asString);
  if qrywalmartordersPostalAddressPostcode.asString  <> '' then qrywalmartordersPostalAddress.asString := trim(qrywalmartordersPostalAddress.asString  +NL+qrywalmartordersPostalAddressPostcode.asString);
  if qrywalmartordersPostalAddressCountry.asString   <> '' then qrywalmartordersPostalAddress.asString := trim(qrywalmartordersPostalAddress.asString  +NL+qrywalmartordersPostalAddressCountry.asString);
end;

initialization
  RegisterClassOnce(TFmWalmartOrder);
  with FormFact do begin
    RegisterMe(TFmWalmartOrder, 'TWalmartOrdersGUI_*=OrderID');
    RegisterMe(TFmWalmartOrder, 'TWalmartOrderLinesGUI_*=OrderID');
  end;

end.

