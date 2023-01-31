unit CustomerSalesOnProductList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid,
  ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls, DNMPanel, MemDS, DBAccess, MyAccess,ERPdbComponents,
  wwdbdatetimepicker, ProgressDialog,  wwdblook, Shader,
  kbmMemTable, DAScript, MyScript, wwcheckbox, CustomInputBox;

type
  TCustomerSalesOnProductListGUI = class(TBaseListingGUI)
    lblCustomer: TLabel;
    qryMainSaleID: TAutoIncField;
    qryMainSaleLineID: TAutoIncField;
    qryMainProductID: TIntegerField;
    qryMainClientID: TIntegerField;
    qryMainSaleDate: TDateField;
    qryMainQty: TFloatField;
    qryMainProductName: TWideStringField;
    qryMainPriceInc: TFloatField;
    qryMainClass: TWideStringField;
    qryMainEmployee: TWideStringField;
    qryMainTransType: TWideStringField;
    qryMainBoQty: TFloatField;
    qryMainProductPrintName: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdMainDblClick(Sender: TObject);Override; 
  private
    { Private declarations }
  protected
    procedure RefreshQuery; override;
  public
    { Public declarations }
    fiProductID: integer;
    fiClientID: integer;
  end;

//var
//  CustomerSalesOnProductListGUI: TCustomerSalesOnProductListGUI;

implementation
   
uses CommonLib, MySQLConst, AppEnvironment, BusObjSaleBase, SalesConst;
{$R *.dfm}

{ TCustomerSalesOnProductListGUI }

procedure TCustomerSalesOnProductListGUI.RefreshQuery;
begin
  qryMain.Close;
  if fiProductID = 0 then qryMain.SQL.Text := ReplaceStr(qryMain.SQL.Text, 'AND ProductID = :xProductID', '');
  if fiProductID <> 0 then qryMain.Params.ParamByName('xProductID').AsInteger := fiProductID;
  qryMain.Params.ParamByName('xClientID').AsInteger := fiClientID;
  qryMain.Params.ParamByName('xFrom').AsString := FormatDateTime(MysqlDateFormat, dtfrom.DateTime);
  qryMain.Params.ParamByName('xTo').AsString := FormatDateTime(MysqlDateFormat, dtto.DateTime);
  inherited;
end;

procedure TCustomerSalesOnProductListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  if (not Assigned(Owner)) or (not (Owner is TForm)) then begin
    {only do this if the list not owned by another form, ie embeded}
    fbEnableWebSearch := true;
  end;
  ShowChartViewOnPopup := True;
end;

procedure TCustomerSalesOnProductListGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  CustomerSalesOnProductListGUI := nil;
end;
procedure TCustomerSalesOnProductListGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMain.FieldByName('TransType').AsString;
  if SameText(qryMain.FieldByName('Transtype').AsString,'CashSale') then begin
    case TSalesBase.GetSaleType(qryMain.FieldByName('SaleID').AsInteger) of
      stPOS,
      stPOSLayby,
      stPOSLaybyPayment,
      stPOSCashSale: SubsequentID := Chr(95) + 'POS';
    end;
  end;
  inherited;
end;

initialization
  RegisterClassOnce(TCustomerSalesOnProductListGUI);

end.
