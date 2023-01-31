unit SupplierProductReportForm;
  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 03/06/05  1.00.01 BJ  Amount Ex was displayed under TotalTax too -Fixed
  // 08/07/05  1.00.02 IJN Added "Docket Number" column to report.

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList, Menus, AdvMenus, DB, 
  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls, ExtCtrls,
  wwDialog, Wwlocate, SelectionDialog, DNMPanel, MemDS,
  DBAccess, MyAccess,ERPdbComponents, wwdbdatetimepicker, ProgressDialog, 
  wwdblook, Shader, kbmMemTable, DAScript, MyScript, CustomInputBox, wwcheckbox,
  wwclearbuttongroup, wwradiogroup, GIFImg;

type
  TSupplierProductReportGUI = class(TBaseListingGUI)
    qryMainOrderDate: TDateTimeField;
    qryMainTransactionType: TWideStringField;
    qryMainSupplierName: TWideStringField;
    qryMainGlobal: TWideStringField;
    qryMainOriginal: TWideStringField;
    qryMainPurchaseOrderNumber: TWideStringField;
    qryMainInvoiceNumber: TWideStringField;
    qryMainTotalAmountEx: TFloatField;
    qryMainTotalTax: TFloatField;
    qryMainTotalAmountInc: TFloatField;
    qryMainEmployeeName: TWideStringField;
    qryMainComments: TWideStringField;
    qryMainSalesComments: TWideStringField;
    qryMainClassName: TWideStringField;
    qryMainAccountName: TWideStringField;
    qryMainProductType: TWideStringField;
    qryMainDepartment: TWideStringField;
    qryMainType: TWideStringField;
    qryMainManufacturer: TWideStringField;
    qryMainProductName: TWideStringField;
    qryMainProductDescription: TWideStringField;
    qryMainLineCostEx: TFloatField;
    qryMainLineCostInc: TFloatField;
    qryMainTaxCode: TWideStringField;
    qryMainLineTax: TFloatField;
    qryMainShipped: TFloatField;
    qryMainDeleted: TWideStringField;
    qryMainEmployeeID: TAutoIncField;
    qryMainClientID: TAutoIncField;
    qryMainPurchaseOrderID: TAutoIncField;
    qryMainLineCostTotalEx: TFloatField;
    qryMainLineCostTotalInc: TFloatField;
    qryMainAttrib1Purchase: TFloatField;
    qryMainAttrib2Purchase: TFloatField;
    qryMainAttrib1PurchaseRate: TFloatField;
    qryMainProductID: TIntegerField;
    qryMainReceivedDate: TDateTimeField;
    qryMainDocketNumber: TWideStringField;
    qryMainOrdered: TFloatField;
    qryMainETADate: TDateField;
    qryMainBackOrder: TFloatField;
    qryMainBarcode: TWideStringField;
    qryMainBOLineCostTotalInc: TFloatField;
    qryMainBOLineCostTotalEx: TFloatField;
    qryMainAccountNumber: TWideStringField;
    qryMainCOGSAccountNumber: TWideStringField;
    qryMainAssetAccountNumber: TWideStringField;
    qryMainIncomeAccountNumber: TWideStringField;
    qryMainCOGSAccountName: TWideStringField;
    qryMainAssetAccountName: TWideStringField;
    qryMainIncomeAccountName: TWideStringField;
    btnReclculate: TDNMSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure FormCreate(Sender: TObject);
    procedure cmdNewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure closePOform;
    procedure initPOForm(Sender: TObject);
    procedure REcalcualtePO(const POID: Integer);
    { Private declarations }
  protected
    procedure RefreshQuery; override;
    procedure RefreshTotals; override;
    procedure SetGridColumns; override;
    procedure IterateselectedRecordsCallback(var Abort: boolean;SelIndex: Integer);override;

  public
    constructor Create(AOwner: TComponent); override;
  end;

  //var
  //  SupplierProductReportGUI: TSupplierProductReportGUI;

implementation

uses AppEnvironment, CommonLib, MySQLConst, frmPurchaseOrders, CommonFormLib;

{$R *.dfm}

{ TSupplierReportGUI }

procedure TSupplierProductReportGUI.RefreshQuery;
begin
  if chkIgnoreDates.Checked then begin
    qryMain.Params.ParamByName('txtfrom').AsDate := 0;
    qryMain.Params.ParamByName('txtto').AsDate := MaxDateTime;
  end
  else begin
    qryMain.Params.ParamByName('txtfrom').AsDate := dtfrom.Date;
    qryMain.Params.ParamByName('txtto').AsDate := dtto.Date;
  end;
  inherited;
  qryMainShipped.DisplayLabel := 'Received';
end;

procedure TSupplierProductReportGUI.RefreshTotals;
var
  dShipped: double;
  dCostTotalEx, dCostTotalInc: double;
  dBOCostTotalEx, dBOCostTotalInc: double;
begin
  dShipped := 0.00;
  dCostTotalEx := 0.00;
  dCostTotalInc := 0.00;
  dBOCostTotalEx := 0.00;
  dBOCostTotalInc := 0.00;
  with qryMain do begin
    DisableControls;
    First;
    while not Eof do begin
      dShipped := dShipped + qryMainShipped.AsFloat;
      dCostTotalEx := dCostTotalEx + qryMainLineCostTotalEx.AsFloat;
      dCostTotalInc := dCostTotalInc + qryMainLineCostTotalInc.AsFloat;
      dBOCostTotalEx := dBOCostTotalEx + qryMainBOLineCostTotalEx.AsFloat;
      dBOCostTotalInc := dBOCostTotalInc + qryMainBOLineCostTotalInc.AsFloat;
      Next;
    end;
    EnableControls;
  end;
  grdMain.ColumnByName('Shipped').FooterValue := FloatToStrF(dShipped, ffGeneral, 15, 2);
  grdMain.ColumnByName('Line Cost Total(Ex)').FooterValue := FloatToStrF(dCostTotalEx, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName('Line Cost Total(Inc)').FooterValue := FloatToStrF(dCostTotalInc, ffCurrency, 15, CurrencyRoundPlaces);

  grdMain.ColumnByName(qryMainBOLineCostTotalEx.FieldName).FooterValue := FloatToStrF(dBOCostTotalEx, ffCurrency, 15, CurrencyRoundPlaces);
  grdMain.ColumnByName(qryMainBOLineCostTotalInc.FieldName).FooterValue := FloatToStrF(dBOCostTotalInc, ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TSupplierProductReportGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainProductId.fieldname);
  RemoveFieldfromGrid(qrymainClientId.fieldname);
  RemoveFieldfromGrid(qrymainEmployeeId.fieldname);
end;

procedure TSupplierProductReportGUI.cmdNewClick(Sender: TObject);
begin
  inherited;
  if FormStillOpen('TPurchaseGUI') then TForm(FindExistingComponent('TPurchaseGUI')).Close;
  IterateProcno := 1;
  IterateSelectedRecords;
  closePOform;
end;
constructor TSupplierProductReportGUI.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TSupplierProductReportGUI.closePOform;
var
  fr: TForm;
begin
    if FormStillOpen('TPurchaseGUI')  then begin
        fr := TForm(FindExistingComponent('TPurchaseGUI'));
        try Freeandnil(fr); except end;
    end;
end;
procedure TSupplierProductReportGUI.IterateselectedRecordsCallback(var Abort: boolean;  SelIndex: Integer);
begin
  inherited;
  if (IterateProcno = 1) then begin
    REcalcualtePO(QrymainpurchaseorderId.asInteger);
    closePOform;
  end;
end;
procedure TSupplierProductReportGUI.initPOForm(Sender:TObject);
begin
  if Sender is  TPurchaseGUI then begin
    if IterateProcno = 1 then TPurchaseGUI(Sender).doSavenclosinOpen := true;
  end;
end;
procedure TSupplierProductReportGUI.REcalcualtePO(const POID:Integer);
begin
 OpenERPForm('TPurchaseGUI' , POID , nil, initPOForm);
end;

procedure TSupplierProductReportGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  //  SupplierProductReportGUI := nil;
end;

procedure TSupplierProductReportGUI.grdMainDblClick(Sender: TObject);
begin
  SubsequentID := Chr(95) + qryMain.FieldByName('Transaction Type').AsString;
  inherited;
end;

procedure TSupplierProductReportGUI.FormCreate(Sender: TObject);
begin
  inherited;
  ShowChartViewOnPopup := True;
  qryMainETADate.DisplayFormat := AppEnv.RegionalOptions.ShortDateformat;
  qryMainOrderDate.DisplayFormat := AppEnv.RegionalOptions.ShortDateformat;
  qryMainReceivedDate.DisplayFormat := AppEnv.RegionalOptions.ShortDateformat;
end;


procedure TSupplierProductReportGUI.FormShow(Sender: TObject);
begin
  inherited;
  EnableMultiSelect('Select Sales to reclculate');
end;

initialization
  RegisterClassOnce(TSupplierProductReportGUI);
end.
