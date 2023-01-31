unit frmUnInvoicedPurchasesList;

{ Date     Version Who What
 -------- -------- --- ------------------------------------------------------
 25/07/05  1.00.01 IJB Removed HandleUnknownException (now handled by new
                       ExceptionalMagic code).

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DB, DBAccess, MyAccess,ERPdbComponents, MemDS, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT, ImgList, Menus, AdvMenus,
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, StdCtrls,
  DNMPanel, ComCtrls,AdvOfficeStatusBar, ProgressDialog, kbmMemTable, 
  wwdblook, Shader, DAScript, MyScript, CustomInputBox, wwcheckbox;

type
  TfmUnInvoicedPurchasesList = class(TBaseListingGUI)
    qryMainSupplierName: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainQtySold: TFloatField;
    qryMainShipped: TFloatField;
    qryMainBackOrder: TFloatField;
    qryMainLineCostInc: TFloatField;
    qryMainOrderedValue: TFloatField;
    qryMainCustomerJobId: TIntegerField;
    qryMainCompany: TWideStringField;
    qryMainPurchaseOrderId: TIntegerField;
    qryMainPurchaseOrderNumber: TWideStringField;
    qryMainOrderDate: TDateTimeField;
    qryMainSalesGlobalref: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdMainUpdateFooter(Sender: TObject);
    procedure dtFromCloseUp(Sender: TObject);
    procedure dtToCloseUp(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override; 

  private
    { Private declarations }
    bFooterCalcInProgress: boolean;

  protected
    procedure RefreshQuery; override;
    //    procedure RefreshTotals; override;

  public
    { Public declarations }
  end;

//var
//  fmUnInvoicedPurchasesList: TfmUnInvoicedPurchasesList;

implementation

{$R *.dfm}

uses
  frmPurchaseOrders, DNMExceptions, CommonLib, tcConst, tcDataUtils,
  CommonFormLib;

procedure TfmUnInvoicedPurchasesList.FormCreate(Sender: TObject);
begin
  inherited;
  if ErrorOccurred then Exit;
  bFooterCalcInProgress := false;
end;

procedure TfmUnInvoicedPurchasesList.FormShow(Sender: TObject);
begin
  try
    inherited;
    if ErrorOccurred then Exit;
    RefreshQuery;
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do begin
      HandleNoAccessException(e);
      Exit;
    end;
    on e: Exception do raise;
  end;
end;

procedure TfmUnInvoicedPurchasesList.RefreshQuery;
begin
  if ErrorOccurred then Exit;
  qryMain.Close;
  qryMain.ParamByName('DateStart').AsDateTime := filterdatefrom;
  qryMain.ParamByName('DateEnd').AsDateTime := filterdateto;

  inherited;

  (*grdMain.ColumnByName('PurchaseOrderNumber').DisplayWidth := 10;
  grdMain.ColumnByName('PurchaseOrderNumber').DisplayLabel := 'PO Number';
  grdMain.ColumnByName('OrderDate').DisplayWidth := 10;
  grdMain.ColumnByName('OrderDate').DisplayLabel := 'PO Date';
  grdMain.ColumnByName('SupplierName').DisplayWidth := 26;
  grdMain.ColumnByName('SupplierName').DisplayLabel := 'Supplier Name';
  grdMain.ColumnByName('ProductName').DisplayWidth := 26;
  grdMain.ColumnByName('ProductName').DisplayLabel := 'Product Name';
  grdMain.ColumnByName('QtySold').DisplayWidth := 10;
  grdMain.ColumnByName('QtySold').DisplayLabel := 'Qty Ordered';
  grdMain.ColumnByName('Shipped').DisplayWidth := 10;
  grdMain.ColumnByName('Shipped').DisplayLabel := 'Qty Shipped';
  grdMain.ColumnByName('OrderedValue').DisplayWidth := 13;
  grdMain.ColumnByName('OrderedValue').DisplayLabel := 'Line Value';
  grdMain.ColumnByName('Company').DisplayWidth := 27;
  grdMain.ColumnByName('Company').DisplayLabel := 'Ordered For';*)
end;

  //procedure TfmUnInvoicedPurchasesList.RefreshTotals;
  //begin
  //
  //end;

procedure TfmUnInvoicedPurchasesList.grdMainUpdateFooter(Sender: TObject);
var
  dValue: double;
  oRecPointer: TBookmark;
begin
  inherited;
  if not bFooterCalcInProgress then begin
    bFooterCalcInProgress := true;
    qryMain.DisableControls;
    oRecPointer := qryMain.GetBookmark;
    try
      dValue := 0.00;
      qryMain.First;
      while not qryMain.Eof do begin
        dValue := dValue + qryMainOrderedValue.AsFloat;
        qryMain.Next;
      end;
      grdMain.ColumnByName('OrderedValue').FooterValue := FloatToStrF(dValue, ffCurrency, 15, CurrencyRoundPlaces);
    finally
      qryMain.GoToBookmark(oRecPointer);
      qryMain.FreeBookmark(oRecPointer);      
      qryMain.EnableControls;
      bFooterCalcInProgress := false;
    end;
  end;
end;

procedure TfmUnInvoicedPurchasesList.dtFromCloseUp(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfmUnInvoicedPurchasesList.dtToCloseUp(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfmUnInvoicedPurchasesList.grdMainDblClick(Sender: TObject);
begin
  if (SameText(ActiveFieldNAme , qryMainSalesGlobalref.Fieldname))  then begin
    if IsSaleSO(qryMainSalesGlobalref.asString) then
      OpenERPForm('TSalesOrderGUI' , GetSaleIDForGlobalRef(qryMainSalesGlobalref.asString));
  end else inherited;
end;

initialization
  RegisterClassOnce(TfmUnInvoicedPurchasesList);
end.
