unit SupplierCreditList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus, AdvMenus,
  ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls, wwdblook, Shader,
  AdvOfficeStatusBar, DNMPanel, DNMSpeedButton;

type
  TSupplierCreditListGUI = class(TBaseListingGUI)
    qryMainTranstype: TWideStringField;
    qryMainID: TIntegerField;
    qryMainTransDate: TDateTimeField;
    qryMainbalance: TFloatField;
    qryMainTransamont: TFloatField;
    qryMainPayment: TFloatField;
    cboClientLookup: TERPQuery;
    cboClientLookupCompany: TWideStringField;
    cboClientLookupClientID: TIntegerField;
    cboClientLookupForeignExchangeSellCode: TWideStringField;
    pnlsupplier: TDNMPanel;
    Label79: TLabel;
    cboSupplier: TwwDBLookupCombo;
    procedure FormCreate(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure cboSupplierCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
  private
    fiSupplierId: Integer;
    fiPurchaseOrderId: Integer;
    flistconnection: TERPConnection;
    procedure openclientLookup;
  Protected
    Procedure RefreshTotals;Override;
  public
    Property SupplierId :Integer read fiSupplierId write fiSupplierId;
    Property PurchaseOrderId :Integer read fiPurchaseOrderId write fiPurchaseOrderId;
    Property listconnection :TERPConnection read flistconnection write flistconnection;
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, AppEnvironment;

{$R *.dfm}


procedure TSupplierCreditListGUI.cboSupplierCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  SupplierId := cboClientLookupClientID.AsInteger;
  RefreshQuery;
end;

procedure TSupplierCreditListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fiSupplierId:= 0;
  fiPurchaseOrderId:= 0;
  flistconnection:= nil;
  AddCalcColumn('Balance', true);
  qryMainTransDate.DisplayFormat := FormatSettings.shortDateformat;
  FilterString := 'ID <> 0 and balance <> 0';
end;

procedure TSupplierCreditListGUI.FormShow(Sender: TObject);
begin
  inherited;
  openclientLookup;
end;
procedure TSupplierCreditListGUI.openclientLookup;
begin
  if cboClientLookup.Active = False then begin
    cboClientLookup.connection := Qrymain.Connection;
    cboClientLookup.Open;
  end;
  if fiSupplierId <>cboClientLookupClientID.AsInteger then begin
    if cboClientLookup.Locate('ClientID' , fiSupplierId , []) then begin
      cboSupplier.Text :=cboClientLookupCompany.AsString;
    end;
  end;
end;

procedure TSupplierCreditListGUI.grdMainCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if (fiPurchaseOrderId <>0) and (QrymainID.asInteger = fiPurchaseOrderId) and (not(sametext(Qrymaintranstype.asString ,'Prepayment')) and (not(sametext(field.fieldname  , qrymaintranstype.fieldname))) ) then
    AFont.Color := clred;
end;

procedure TSupplierCreditListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  BaseIndexFieldNames := QuotedStr('Transtype') + ' ASC CIS';
end;

procedure TSupplierCreditListGUI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  if flistconnection <> nil then
    Qrymain.Connection := flistconnection;

end;

procedure TSupplierCreditListGUI.RefreshQuery;
begin
  openclientLookup;
  Qrymain.Parambyname('clientID').AsInteger := fiSupplierId;
  Qrymain.Parambyname('showPOBo').asBoolean := appenv.CompanyPrefs.CreditcheckPOIncludeBO;
  Qrymain.Parambyname('POID').AsInteger :=  PurchaseOrderId;
  inherited;
end;

procedure TSupplierCreditListGUI.RefreshTotals;
begin
  inherited;
  CalcnShowFooter;
end;

Initialization
  RegisterClassOnce(TSupplierCreditListGUI);

end.

