unit frmNonERPSales;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmNonERPBase, DB, ProgressDialog, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, DBCtrls, wwdbdatetimepicker, StdCtrls, Mask, wwdbedit,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, DNMSpeedButton, Shader, DNMPanel, BusObjNonERPSales;

type
  TfmNonERPSales = class(TfmNonERPBase)
    qryMasterSaleID: TIntegerField;
    qryMasterInvoiceDocNumber: TWideStringField;
    qryMasterCustomerName: TWideStringField;
    qryMasterSaleDate: TDateField;
    qryMasterClassID: TIntegerField;
    qryMasterClass: TWideStringField;
    qryMasterIsPOS: TWideStringField;
    qryMasterIsRefund: TWideStringField;
    qryMasterIsCashSale: TWideStringField;
    qryMasterIsInvoice: TWideStringField;
    qryMasterIsQuote: TWideStringField;
    qryMasterIsSalesOrder: TWideStringField;
    qryMasterIsVoucher: TWideStringField;
    qryMasterIsLayby: TWideStringField;
    qryMasterIsCustomerReturn: TWideStringField;
    qryMasterERPSaleID: TIntegerField;
    procedure qryMasterAfterOpen(DataSet: TDataSet);
  private
    NonERPSalesObj: TNonERPSales;
  Protected
    procedure NewBusObjinstance;Override;
  public
    { Public declarations }
  end;

implementation

uses CommonLib, FormFactory;

{$R *.dfm}
procedure TfmNonERPSales.NewBusObjinstance;
begin
  {$WARNINGS OFF}
  NonERPSalesObj := TNonERPSales.CreateWithNewConn(Self);
  NonERPSalesObj.Connection.connection := Self.MyConnection;
  NonERPSalesObj.BusObjEvent := DoBusinessObjectEvent;
  NonERPTransObj := NonERPSalesObj;
  {$WARNINGS ON}
  inherited
end;

procedure TfmNonERPSales.qryMasterAfterOpen(DataSet: TDataSet);
begin
  inherited;
       if qryMasterIsPOS.AsBoolean            then TitleLabel.caption := 'Non ERP Sales - POS'
  else if qryMasterIsRefund.AsBoolean         then TitleLabel.caption := 'Non ERP Sales - Refund'
  else if qryMasterIsCashSale.AsBoolean       then TitleLabel.caption := 'Non ERP Sales - Cash Sale'
  else if qryMasterIsInvoice.AsBoolean        then TitleLabel.caption := 'Non ERP Sales - Invoice'
  else if qryMasterIsQuote.AsBoolean          then TitleLabel.caption := 'Non ERP Sales - Quote'
  else if qryMasterIsSalesOrder.AsBoolean     then TitleLabel.caption := 'Non ERP Sales - Sales Order'
  else if qryMasterIsVoucher.AsBoolean        then TitleLabel.caption := 'Non ERP Sales - Vocher'
  else if qryMasterIsLayby.AsBoolean          then TitleLabel.caption := 'Non ERP Sales - Layby'
  else if qryMasterIsCustomerReturn.AsBoolean then TitleLabel.caption := 'Non ERP Sales - Customer Return'
  else TitleLabel.caption := 'Non ERP Sales';
end;

initialization
  RegisterClassOnce(TfmNonERPSales);
  with FormFact do begin
    RegisterMe(TfmNonERPSales, 'TNonERPSalesListGUI_*=transid');
    RegisterMe(TfmNonERPSales, 'TCustomerProductsaleshistoryGUI_NonERPSales=SaleID');
  end;

end.
