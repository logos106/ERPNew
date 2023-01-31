unit frmPurchaseOrderChange;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton, Shader, DNMPanel, Mask, DBCtrls,
  Grids, AdvObj, BaseGrid, AdvGrid, wwdbdatetimepicker, JsonObject, AdvEdit,
  wwcheckbox, wwdblook, BusObjTransChange, BusObjBase;

type
  TfmPurchaseOrderChange = class(TBaseInputGUI)
    pnlHeader: TDNMPanel;
    pnlFooter: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnCompleted: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    tblMaster: TERPQuery;
    tblDetail: TERPQuery;
    Label38: TLabel;
    lblClientDetails: TLabel;
    txtClientDetails: TDBMemo;
    Label35: TLabel;
    txtShipTo: TDBMemo;
    edtSupplier: TDBEdit;
    dsMaster: TDataSource;
    tblMasterPurchaseOrderID: TIntegerField;
    tblMasterGlobalRef: TWideStringField;
    tblMasterPurchaseOrderNumber: TWideStringField;
    tblMasterSeqNo: TIntegerField;
    tblMasterOriginalNo: TWideStringField;
    tblMasterBaseNo: TWideStringField;
    tblMasterAccount: TWideStringField;
    tblMasterAccountID: TIntegerField;
    tblMasterBOID: TWideStringField;
    tblMasterSupplierName: TWideStringField;
    tblMasterClientPrintName: TWideStringField;
    tblMasterClientID: TIntegerField;
    tblMasterOrderTo: TWideStringField;
    tblMasterShipTo: TWideStringField;
    tblMasterShipToId: TIntegerField;
    tblMasterOrderDate: TDateTimeField;
    tblMasterTotalTax: TFloatField;
    tblMasterTotalAmount: TFloatField;
    tblMasterTotalAmountInc: TFloatField;
    tblMasterEmployeeName: TWideStringField;
    tblMasterEmployeeID: TIntegerField;
    tblMasterInvoiceNumber: TWideStringField;
    tblMasterRefNo: TWideStringField;
    tblMasterETADate: TDateField;
    tblMasterDueDate: TDateField;
    tblMasterComments: TWideStringField;
    tblMasterSalesComments: TWideStringField;
    tblMasterShipping: TWideStringField;
    tblMasterTerms: TWideStringField;
    tblMasterPrintFlag: TWideStringField;
    tblMasterPrintedBy: TWideStringField;
    tblMasterPaid: TWideStringField;
    tblMasterBalance: TFloatField;
    tblMasterPayment: TFloatField;
    tblMasterApplyFlag: TWideStringField;
    tblMasterAmountDue: TFloatField;
    tblMasterPayMethod: TIntegerField;
    tblMasterIsPO: TWideStringField;
    tblMasterIsRA: TWideStringField;
    tblMasterIsBill: TWideStringField;
    tblMasterIsCredit: TWideStringField;
    tblMasterIsCheque: TWideStringField;
    tblMasterIsRefundCheque: TWideStringField;
    tblMasterRefundGlobalref: TWideStringField;
    tblMasterIsPOCredit: TWideStringField;
    tblMasterDeleted: TWideStringField;
    tblMasterCancelled: TWideStringField;
    tblMasterEditedFlag: TWideStringField;
    tblMasterInvoiceDate: TDateField;
    tblMasterEnteredBy: TWideStringField;
    tblMasterEnteredAt: TWideStringField;
    tblMasterConNote: TWideStringField;
    tblMasterCustPONumber: TWideStringField;
    tblMasterLastUpdated: TDateTimeField;
    tblMasterForeignExchangeCode: TWideStringField;
    tblMasterForeignExchangeRate: TFloatField;
    tblMasterForeignTotalAmount: TFloatField;
    tblMasterForeignPaidAmount: TFloatField;
    tblMasterForeignBalanceAmount: TFloatField;
    tblMastermsTimeStamp: TDateTimeField;
    tblMasterApproved: TWideStringField;
    tblMasterAPNotes: TWideMemoField;
    tblMasterExpenseClaimEmployee: TIntegerField;
    tblMastercontactID: TLargeintField;
    tblMasterContactName: TWideStringField;
    tblMasterSalesGlobalref: TWideStringField;
    tblMasterShipToCustomer: TWideStringField;
    tblMasterRARef: TWideStringField;
    tblMasterTotalDiscount: TFloatField;
    tblMasterSaleLineRef: TWideStringField;
    tblMastermsUpdateSiteCode: TWideStringField;
    tblMasterArea: TWideStringField;
    tblMasterOrderStatus: TWideStringField;
    tblMasterEquipmentId: TIntegerField;
    tblMasterEquipmentName: TWideStringField;
    tblMasterSOApprovedBy: TIntegerField;
    tblMasterCreatedFromSO: TIntegerField;
    tblMasterSignature: TBlobField;
    tblMasterSignatureTime: TDateTimeField;
    tblMasterFuturePO: TWideStringField;
    tblMasterContractorPayment: TWideStringField;
    grdDetails: TAdvStringGrid;
    Label142: TLabel;
    Label54: TLabel;
    Label56: TLabel;
    SaleDate_Label: TLabel;
    cboCreationDate: TwwDBDateTimePicker;
    Label160: TLabel;
    txtCustomID: TDBEdit;
    tblDetailPurchaseLineID: TIntegerField;
    tblDetailSEQNo: TIntegerField;
    tblDetailGlobalRef: TWideStringField;
    tblDetailPurchaseOrderID: TIntegerField;
    tblDetailBaseLineno: TIntegerField;
    tblDetailProductID: TIntegerField;
    tblDetailPARTTYPE: TWideStringField;
    tblDetailINCOMEACCNT: TWideStringField;
    tblDetailASSETACCNT: TWideStringField;
    tblDetailCOGSACCNT: TWideStringField;
    tblDetailProductGroup: TWideStringField;
    tblDetailProductName: TWideStringField;
    tblDetailProductPrintName: TWideStringField;
    tblDetailPartBarcode: TWideStringField;
    tblDetailProduct_Description: TWideStringField;
    tblDetailAccountNumber: TWideStringField;
    tblDetailAccountName: TWideStringField;
    tblDetailAccountGroup: TWideStringField;
    tblDetailLineTaxRate: TFloatField;
    tblDetailLineCost: TFloatField;
    tblDetailAvgCost: TFloatField;
    tblDetailStandardCost: TFloatField;
    tblDetailLineCostInc: TFloatField;
    tblDetailLineTaxCode: TWideStringField;
    tblDetailLineTax: TFloatField;
    tblDetailQtySold: TFloatField;
    tblDetailUnitofMeasureQtySold: TFloatField;
    tblDetailShipped: TFloatField;
    tblDetailUnitofMeasureShipped: TFloatField;
    tblDetailBackOrder: TFloatField;
    tblDetailUnitofMeasureBackorder: TFloatField;
    tblDetailUnitofMeasurePOLines: TWideStringField;
    tblDetailUnitOfMeasureID: TIntegerField;
    tblDetailUnitofMeasureMultiplier: TFloatField;
    tblDetailInvoiced: TWideStringField;
    tblDetailClassID: TIntegerField;
    tblDetailClass: TWideStringField;
    tblDetailCustomerJob: TWideStringField;
    tblDetailCustomerPrintJob: TWideStringField;
    tblDetailCustomerJobID: TIntegerField;
    tblDetailRAQty: TFloatField;
    tblDetailRAstatus: TWideStringField;
    tblDetailBatch: TWideStringField;
    tblDetailUseTimecost: TWideStringField;
    tblDetailSaleID_Timecost: TIntegerField;
    tblDetailTimecostMarkupPer: TFloatField;
    tblDetailTimecostPrice: TFloatField;
    tblDetailTimecostMarkupDol: TFloatField;
    tblDetailserialno: TWideMemoField;
    tblDetailTotalLineAmount: TFloatField;
    tblDetailTotalLineAmountInc: TFloatField;
    tblDetailCOGSTotalLineAmount: TFloatField;
    tblDetailCOGSTotalLineAmountInc: TFloatField;
    tblDetailEditedFlag: TWideStringField;
    tblDetailDeleted: TWideStringField;
    tblDetailRAInvoiceNo: TWideStringField;
    tblDetailAttrib1Purchase: TFloatField;
    tblDetailAttrib2Purchase: TFloatField;
    tblDetailAttrib1PurchaseRate: TFloatField;
    tblDetailAttrib1PurchaseEst: TFloatField;
    tblDetailAttrib2PurchaseEst: TFloatField;
    tblDetailLastLineID: TIntegerField;
    tblDetailRelatedPOIDUsed: TWideStringField;
    tblDetailRelatedPOID: TIntegerField;
    tblDetailLandedCostsPerItem: TFloatField;
    tblDetailLandedCostsPercentage: TFloatField;
    tblDetailLandedCostsTotal: TFloatField;
    tblDetailForeignExchangeRate: TFloatField;
    tblDetailForeignExchangeCode: TWideStringField;
    tblDetailForeignCurrencyLineCost: TFloatField;
    tblDetailForeignTotalLineAmount: TFloatField;
    tblDetailDescAttrib1: TWideStringField;
    tblDetailDescAttrib2: TWideStringField;
    tblDetailDescAttrib3: TWideStringField;
    tblDetailDescAttrib4: TWideStringField;
    tblDetailDescAttrib5: TWideStringField;
    tblDetailSearchFilter: TWideStringField;
    tblDetailSearchFilterCopy: TWideStringField;
    tblDetailReceivedDate: TDateTimeField;
    tblDetailCostCentreId: TIntegerField;
    tblDetailmsTimeStamp: TDateTimeField;
    tblDetailDocketNumber: TWideStringField;
    tblDetailPartSpecID: TIntegerField;
    tblDetailSpecDescription: TWideStringField;
    tblDetailSpecValue: TFloatField;
    tblDetailNewForeignExchangeRate: TFloatField;
    tblDetailETADate: TDateField;
    tblDetailCustomField1: TWideStringField;
    tblDetailCustomField2: TWideStringField;
    tblDetailCustomField3: TWideStringField;
    tblDetailCustomField4: TWideStringField;
    tblDetailCustomField5: TWideStringField;
    tblDetailCustomField6: TWideStringField;
    tblDetailCustomField7: TWideStringField;
    tblDetailCustomField8: TWideStringField;
    tblDetailCustomField9: TWideStringField;
    tblDetailCustomField10: TWideStringField;
    tblDetailLineNotes: TWideMemoField;
    tblDetailINCOMEACCNTID: TIntegerField;
    tblDetailASSETACCNTID: TIntegerField;
    tblDetailCOGSACCNTID: TIntegerField;
    tblDetailSortID: TIntegerField;
    tblDetailMemoLine: TWideMemoField;
    tblDetailSaleLineID: TIntegerField;
    tblDetailRelatedShipContainerID: TIntegerField;
    tblDetailRelatedShipContainerIDUsed: TWideStringField;
    tblDetailRepairId: TIntegerField;
    tblDetailCustomerEquipmentID: TIntegerField;
    tblDetailEquipmentName: TWideStringField;
    tblDetailProcTreeId: TIntegerField;
    tblDetailSupplierProductCode: TWideStringField;
    tblDetailSupplierProductName: TWideStringField;
    tblDetailRALineRef: TWideStringField;
    tblDetailPrintedValue: TFloatField;
    tblDetailDiscountPercent: TFloatField;
    tblDetailDiscountAmount: TFloatField;
    tblDetailOriginalCost: TFloatField;
    tblDetailMatrixDesc: TWideMemoField;
    tblDetailMatrixRef: TWideMemoField;
    tblDetailMatrixPrice: TFloatField;
    tblDetailSmartOrderID: TIntegerField;
    tblDetailSmartOrderLineID: TIntegerField;
    tblDetailmsUpdateSiteCode: TWideStringField;
    tblDetailformulaId: TIntegerField;
    tblDetailFormulaName: TWideStringField;
    tblDetailFormulaQtySoldValue1: TFloatField;
    tblDetailFormulaQtySoldValue2: TFloatField;
    tblDetailFormulaQtySoldValue3: TFloatField;
    tblDetailFormulaQtySoldValue4: TFloatField;
    tblDetailFormulaQtySoldValue5: TFloatField;
    tblDetailFormulaQtySoldValue: TFloatField;
    tblDetailFormulaQtyShippedValue1: TFloatField;
    tblDetailFormulaQtyShippedValue2: TFloatField;
    tblDetailFormulaQtyShippedValue3: TFloatField;
    tblDetailFormulaQtyShippedValue4: TFloatField;
    tblDetailFormulaQtyShippedValue5: TFloatField;
    tblDetailFormulaQtyShippedValue: TFloatField;
    tblDetailEmployeeID: TIntegerField;
    tblDetailEmployeeName: TWideStringField;
    tblDetailAreaCode: TWideStringField;
    tblDetailLinesOrder: TIntegerField;
    tblDetailExpenseProductID: TIntegerField;
    tblDetailExpenseProductName: TWideStringField;
    tblDetailGeneralNotes: TWideMemoField;
    tblDetailLineDescription: TWideStringField;
    tblDetailBoxesReceived: TIntegerField;
    tblDetailBoxesOrdered: TIntegerField;
    qryTransChanges: TERPQuery;
    txtSubTotal: TAdvEdit;
    txtTaxTotal: TAdvEdit;
    txtTotal: TAdvEdit;
    qryApproverLookup: TERPQuery;
    pnlApprover: TDNMPanel;
    Label2: TLabel;
    cboApprover: TwwDBLookupCombo;
    chkSendEmail: TwwCheckBox;
    dsTransChanges: TDataSource;
    qryEmployeeLookup: TERPQuery;
    qryTransChangesID: TIntegerField;
    qryTransChangesTransType: TWideStringField;
    qryTransChangesTransID: TIntegerField;
    qryTransChangesEmployeeID: TIntegerField;
    qryTransChangesApproverEmployeeID: TIntegerField;
    qryTransChangesCreateDate: TDateTimeField;
    qryTransChangesActive: TWideStringField;
    qryTransChangesApproved: TWideStringField;
    qryTransChangesData: TWideMemoField;
    qryTransChangesmstimestamp: TDateTimeField;
    qryTransChangesmsUpdateSiteCode: TWideStringField;
    qryTransChangesEmployeeName: TStringField;
    btnOpenPO: TDNMSpeedButton;
    memComments: TMemo;
    Label6: TLabel;
    memSalesComments: TMemo;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    memConNote: TMemo;
    edtCustPoNumber: TEdit;
    chkApproved: TwwCheckBox;
    chkActive: TwwCheckBox;
    edtEmployeeName: TDBEdit;
    edtCreateDate: TDBEdit;
    Label1: TLabel;
    Label4: TLabel;
    btnNewPO: TDNMSpeedButton;
    popNewPO: TAdvPopupMenu;
    mnuNewPO: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdDetailsCanEditCell(Sender: TObject; ARow, ACol: Integer;
      var CanEdit: Boolean);
    procedure grdDetailsGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdDetailsEditingDone(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnOpenPOClick(Sender: TObject);
    procedure memCommentsChange(Sender: TObject);
    procedure memSalesCommentsChange(Sender: TObject);
    procedure memConNoteChange(Sender: TObject);
    procedure edtCustPoNumberChange(Sender: TObject);
    procedure btnNewPOClick(Sender: TObject);
    procedure tblMasterAfterOpen(DataSet: TDataSet);
    //procedure popNewPOPopup(Sender: TObject);
    //procedure mnuNewPOClick(Sender: TObject);
  private
    Data, CleanData: TJsonObject;
    fPurchaseOrderID: integer;
    CleanApproved: boolean;
    CleanActive: boolean;
    CleanApproverEmployeeID: integer;
    Saved: boolean;
    procedure LoadGrid;
    procedure CalcLineTotal(const aRow: integer);
    procedure CalcTotals;
    function JsonRowForID(const aLineID: integer): TJsonObject;
    function SaveChanges: boolean;
    function UpdatePO: boolean;
    function Dirty: boolean;
    procedure NotifyApproval;
    procedure BeforePOShow(Sender: TObject);
    procedure FlagToDoChangeRequestAsDone;
    procedure MakeNewPOforHeader(Sender: TObject);
    //procedure MakeNewPOforLine(Sender: TObject);
  protected
    TransChange: TTransChange;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    property PurchaseOrderID: integer read fPurchaseOrderID write fPurchaseOrderID;
  end;

implementation

{$R *.dfm}

uses
  CommonLib, AppEnvironment, BusObjApprovals, BusObjOrders, {BusObjToDo,
  BusObjEmployee, CorrespondenceObj,} CommonFormLib, tcConst, CommonDBLib,
  BusObjConst, ApprovalNotificationLib, frmPurchaseOrders, tcDataUtils,
  LookupcomboLib;


type
  TCol = record
    Index: integer;
    Name: string;
    Caption: string;
    FieldName: string;
    Width: integer;
    ReadOnly: boolean;
  end;

const
  Cols: array[0..10] of TCol =
  (
    (Index: 0; Name: 'PurchaseLineID';      Caption: 'PurchaseLineID'; FieldName: 'PurchaseLineID';        Width: 0;   ReadOnly: true),
    (Index: 1; Name: 'Product';             Caption: 'Product';        FieldName: 'ProductPrintName';      Width: 150; ReadOnly: true),
    (Index: 2; Name: 'CostEx';              Caption: 'Cost(Ex)';       FieldName: 'LineCost';              Width: 80;  ReadOnly: true),
    (Index: 3; Name: 'New_CostEx';          Caption: 'New Cost';       FieldName: '';                      Width: 80;  ReadOnly: false),
    (Index: 4; Name: 'Description';         Caption: 'Description';    FieldName: 'Product_Description';   Width: 200; ReadOnly: true),
    (Index: 5; Name: 'New_LineDescription'; Caption: 'New Description';FieldName: '';                      Width: 200; ReadOnly: false),
    (Index: 6; Name: 'Units';               Caption: 'Units';          FieldName: 'UnitOfMeasurePOLines';  Width: 80;  ReadOnly: true),
    (Index: 7; Name: 'TaxCode';             Caption: 'Code';           FieldName: 'LineTaxCode';           Width: 80;  ReadOnly: true),
    (Index: 8; Name: 'UOMQtyOrdered';       Caption: 'Qty';            FieldName: 'UnitOfMeasureQtySold';  Width: 80;  ReadOnly: true),
    (Index: 9; Name: 'New_UOMQtyOrdered';   Caption: 'New Qty';        FieldName: '';                      Width: 80;  ReadOnly: false),
    (Index: 10; Name: 'AmountInc';          Caption: 'Amount(Inc)';    FieldName: '';                      Width: 120; ReadOnly: true)
  );

  {Grid columns}
    cPurchaseLineID =0;
    cProduct        =1;
    cCostEx         =2;
    cnCostEx        =3;
    cDescription    =4;
    cLineDescription=5;
    cUnits          =6;
    cTaxCode        =7;
    cUOMQtyOrdered  =8;
    cnUOMQtyOrdered =9;
    cAmountInc      =10;

function ColByName(const aName: string): TCol;
var
  x: integer;
begin
  for x := Low(Cols) to High(Cols) do begin
    if SameText(Cols[x].Name, aName) then begin
      result := Cols[x];
      exit;
    end;
  end;
end;

function ColByIndex(const aIndex: integer): TCol;
var
  x: integer;
begin
  for x := Low(Cols) to High(Cols) do begin
    if (Cols[x].Index = aIndex) then begin
      result := Cols[x];
      exit;
    end;
  end;
end;

{ TfmPurchaseOrderChange }

procedure TfmPurchaseOrderChange.BeforePOShow(Sender: TObject);
begin
  TBaseInputGUI(Sender).AccessLevel := 5;
end;

procedure TfmPurchaseOrderChange.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmPurchaseOrderChange.btnCompletedClick(Sender: TObject);
begin
  inherited;
  if SaveChanges then begin
    Notify(false);
    Close;
  end;
end;

procedure TfmPurchaseOrderChange.btnNewPOClick(Sender: TObject);
begin
  inherited;
  if not SaveChanges then Exit;

  Notify(false);
  OpenERPForm('TPurchaseGUI',btnNewPO.Tag,MakeNewPOforHeader);
  Close;
end;
procedure TfmPurchaseOrderChange.MakeNewPOforHeader(Sender: TObject);
begin
  if sender is TPurchaseGUI then begin
    TPurchaseGUI(sender).MakeLinkPO(tblMasterglobalref.AsString );
  end;
end;
(*procedure TfmPurchaseOrderChange.MakeNewPOforLine(Sender: TObject);
begin
  if sender is TPurchaseGUI then begin
    if (grdDetails.Cells[cPurchaselineID,grdDetails.Row]<> '0') and (tbldetail.locate('PurchaseLineID' , strtoInt(grdDetails.Cells[cPurchaselineID,grdDetails.Row]), [])) then
         TPurchaseGUI(sender).MakeLinkPO(tblMasterglobalref.AsString , tbldetailglobalref.asString)
    else TPurchaseGUI(sender).MakeLinkPO(tblMasterglobalref.AsString , '');
  end;
end;*)

procedure TfmPurchaseOrderChange.btnOpenPOClick(Sender: TObject);
begin
  inherited;
  OpenERPFormModal('TPurchaseGUI',qryTransChanges.FieldByName('TransID').AsInteger,BeforePOShow);
end;

procedure TfmPurchaseOrderChange.CalcLineTotal(const aRow: integer);
var
  RowJson: TJsonObject;
  LineID: integer;
  UnitOfMeasureQtySold, LineCost, LineCostInc: double;
  LineDescription:String;
begin
  LineID := grdDetails.Ints[0,aRow];
  tblDetail.Locate('PurchaseLineID',LineID,[]);
  RowJson := JsonRowForID(LineID);
  if RowJson.Exists('New_UOMQtyOrdered') then
    UnitOfMeasureQtySold := RowJson.F['New_UOMQtyOrdered']
  else
    UnitOfMeasureQtySold := tblDetailUnitOfMeasureQtySold.AsFloat;

  if RowJson.Exists('New_LineDescription') then
    LineDescription := RowJson.S['New_LineDescription']
  else
    LineDescription := tblDetailLineDescription.asString;

  if RowJson.Exists('New_CostEx') then begin
    LineCost := RowJson.F['New_CostEx'];
    LineCostInc := LineCost * (1 + tblDetailLineTaxRate.AsFloat);
  end
  else begin
    LineCost :=  tblDetailLineCost.AsFloat;
    LineCostInc :=  tblDetailLineCostInc.AsFloat;
  end;
//  if RowJson.Exists('LineCostInc') then
//    LineCostInc := RowJson.F['LineCostInc']
//  else
//    LineCostInc :=  tblDetailLineCostInc.AsFloat;

  RowJson.F['EstTotalLineAmount']     := Round(LineCost * UnitOfMeasureQtySold, CurrencyRoundPlaces);
  RowJson.F['EstTotalLineAmountInc']  := Round(LineCostInc * UnitOfMeasureQtySold, CurrencyRoundPlaces);
  RowJson.F['EstLineTaxTotal']        := RowJson.F['EstTotalLineAmountInc'] - RowJson.F['EstTotalLineAmount'];
  RowJson.S['LineDescription']        := LineDescription;

//  grdDetails.Floats[ColByName('AmountInc').Index, aRow] := RowJson.F['EstTotalLineAmountInc'];
  grdDetails.Cells[ColByName('AmountInc').Index, aRow] := FloatToStrF(RowJson.F['EstTotalLineAmountInc'], ffCurrency, 15, CurrencyRoundPlaces);
end;

procedure TfmPurchaseOrderChange.CalcTotals;
var
  RowJson: TJsonObject;
  x: integer;
begin
  Data.F['EstTotalAmount']     := 0;
  Data.F['EstTotalAmountInc']  := 0;
  Data.F['EstTaxTotal']        := 0;

  for x := 0 to Data.A['Lines'].Count -1 do begin
    RowJson := Data.A['Lines'].Items[x].AsObject;
    Data.F['EstTotalAmount'] := Data.F['EstTotalAmount'] + RowJson.F['EstTotalLineAmount'];
    Data.F['EstTotalAmountInc'] := Data.F['EstTotalAmountInc'] + RowJson.F['EstTotalLineAmountInc'];
    Data.F['EstTaxTotal'] := Data.F['EstTaxTotal'] + RowJson.F['EstLineTaxTotal'];
  end;
  txtSubTotal.FloatValue := Data.F['EstTotalAmount'];
  txtTaxTotal.FloatValue := Data.F['EstTaxTotal'];
  txtTotal.FloatValue := Data.F['EstTotalAmountInc'];

  //qryApproverLookup.ParamByName('ApprovalType').AsString := ApprovalTypePurchaseOrder;
  qryApproverLookup.ParamByName('OrderTotal').AsFloat := Data.F['EstTotalAmountInc'];
  qryApproverLookup.Refresh;
  if qryTransChanges.FieldByName('ApproverEmployeeID').AsInteger > 0 then begin
    qryApproverLookup.Locate('EmployeeID',qryTransChanges.FieldByName('ApproverEmployeeID').AsInteger,[]);
    cboApprover.Text := qryApproverLookup.FieldByName('EmployeeName').AsString;
  end;

end;

function TfmPurchaseOrderChange.Dirty: boolean;
begin
  if Saved then begin
    result := false;
    exit;
  end;
  result :=
//    (Data.A['Lines'].AsString <> CleanData.A['Lines'].AsString) or
    (trim(Data.AsString) <> trim(CleanData.AsString)) or
    (CleanApproved <> qryTransChanges.FieldByName('Approved').AsBoolean) or
    (CleanActive <> qryTransChanges.FieldByName('Active').AsBoolean) or
    (CleanApproverEmployeeID <> qryTransChanges.FieldByName('ApproverEmployeeID').AsInteger);
end;

procedure TfmPurchaseOrderChange.DoBusinessObjectEvent(
  const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
      if Sender is TTransChange then TTransChange(Sender).Dataset := qryTransChanges;
  end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterInsert) and (Sender is TTransChange) then begin
  end;
end;

procedure TfmPurchaseOrderChange.edtCustPoNumberChange(Sender: TObject);
begin
  inherited;
  if not edtCustPONumber.Focused then exit;
  Data.S['CustPONumber'] := edtCustPONumber.Text;
end;

procedure TfmPurchaseOrderChange.FlagToDoChangeRequestAsDone;
var
  cmd: TERPCommand;
begin
  cmd := TERPCommand.Create(nil);
  try
    cmd.Connection := CommonDBLib.GetSharedMyDacConnection;
    cmd.SQL.Add('update tblToDo set Completed = "T"');
    cmd.SQL.Add('where LinkTo = ' + QuotedStr('Purchase Order Change'));
    cmd.SQL.Add('and LinkToID = ' + IntToStr(qryTransChangesID.AsInteger));
    cmd.SQL.Add('and Description like "Purchase Order Change%"');
    try
      cmd.Execute;
    except
      on e: exception do begin
        CommonLib.MessageDlgXP_Vista('Could not Flag the ToDo Items as Done.',mtInformation,[mbOk],0);
      end;
    end;
  finally
    cmd.Free;
  end;
end;

procedure TfmPurchaseOrderChange.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  self.RollbackTransaction;
end;

procedure TfmPurchaseOrderChange.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  If Dirty then begin
    Case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtWarning, [mbYes, mbNo, mbCancel], 0) Of
      mrYes: Begin
          If self.SaveChanges then begin
            CanClose := true;
          End;
        End;
      mrNo: Begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          CanClose := true;
          Notify(true);
        End;
      mrCancel: Begin
          CanClose := False;
        End;
    End;
  End Else Begin
    CanClose := true;
    Notify(false);
  End;
end;

procedure TfmPurchaseOrderChange.FormCreate(Sender: TObject);
begin
  inherited;
  Data := JO;
  CleanData := JO;
  TransChange := TTransChange.CreateWithNewConn(self);
  TransChange.Connection.Connection := MyConnection;
  TransChange.BusObjEvent := DoBusinessObjectEvent;

  txtSubTotal.Precision := AppEnv.RegionalOptions.CurrencyRoundPlaces;
  txtSubTotal.Prefix := AppEnv.RegionalOptions.CurrencySymbol;
  txtTaxTotal.Precision := AppEnv.RegionalOptions.CurrencyRoundPlaces;
  txtTaxTotal.Prefix := AppEnv.RegionalOptions.CurrencySymbol;
  txtTotal.Precision := AppEnv.RegionalOptions.CurrencyRoundPlaces;
  txtTotal.Prefix := AppEnv.RegionalOptions.CurrencySymbol;

  //ApproverLookupQrySQL(qryApproverLookup);
  ApproverCombo.ApproverLookupQrySQL(cboApprover , ApprovalTypePurchaseOrder);
end;

procedure TfmPurchaseOrderChange.FormDestroy(Sender: TObject);
begin
  inherited;
  Data.Free;
  CleanData.Free;
end;

procedure TfmPurchaseOrderChange.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  inherited;
//  PurchaseOrderID := 21;

  Setlength(QueryNamesNotToOpen, 3);
  QueryNamesNotToOpen[0] := 'tblMaster';
  QueryNamesNotToOpen[1] := 'tblDetail';
  QueryNamesNotToOpen[2] := 'qryTransChanges';
  OpenQueries(QueryNamesNotToOpen);

  self.BeginTransaction;
//  qryTransChanges.ParamByName('TransType').AsString := ApprovalTypePurchaseOrder;
//  qryTransChanges.ParamByName('TransID').AsInteger := tblMasterPurchaseOrderID.AsInteger;
  if KeyID > 0 then begin
    TransChange.Load(KeyID);
//    qryTransChanges.SQL.Text := 'select * from tbltranschanges where ID = ' + IntToStr(KeyID);
//    qryTransChanges.Open;
//    PurchaseOrderID := qryTransChanges.FieldByName('TransID').AsInteger;
    PurchaseOrderID := TransChange.TransID;
  end
  else if PurchaseOrderID > 0 then begin
    TransChange.LoadSelect('TransID = ' + IntToStr(PurchaseOrderID) + ' and TransType = ' + QuotedStr(ApprovalTypePurchaseOrder));
//    qryTransChanges.SQL.Text := 'select * from tbltranschanges where TransID = ' + IntToStr(PurchaseOrderID) +
//    ' and TransType = ' + QuotedStr(ApprovalTypePurchaseOrder);
//    qryTransChanges.Open;

//    if qryTransChanges.IsEmpty then begin
//      qryTransChanges.Insert;
//      qryTransChanges.FieldByName('TransType').AsString := ApprovalTypePurchaseOrder;
//      qryTransChanges.FieldByName('TransID').AsInteger := PurchaseOrderID;
//      qryTransChanges.FieldByName('EmployeeID').AsInteger := AppEnv.Employee.EmployeeID;
//      qryTransChanges.FieldByName('CreateDate').AsDateTime := Date;
//      qryTransChanges.FieldByName('Active').AsBoolean := True;
//      qryTransChanges.FieldByName('Approved').AsBoolean := false;
//      qryTransChanges.Post;
//    end;
    if TransChange.ISEmpty then begin
      TransChange.New;
      TransChange.TransType := ApprovalTypePurchaseOrder;
      TransChange.TransID := PurchaseOrderID;
      TransChange.PostDB;
    end;
  end
  else
    raise Exception.Create(ClassName + ' Error - No KeyID or Purchase Order ID Provided');

  tblMaster.ParamByName('POID').AsInteger := PurchaseOrderID;
  tblDetail.ParamByName('POID').AsInteger := PurchaseOrderID;
  tblMaster.Open;
  tblDetail.Open;

  LoadGrid;
  if AccessLevel < 3 then begin
    if TransChange.Approved then
      AccessLevel := 5;
  end;
  memComments.ReadOnly := AccessLevel > 2;
  memSalesComments.ReadOnly := AccessLevel > 2;
  memConNote.ReadOnly := AccessLevel > 2;
  edtCustPONumber.ReadOnly := AccessLevel > 2;
  btnCompleted.Enabled := (AccessLevel < 3);
  chkSendEmail.checked := AppEnv.CompanyPrefs.DefaultNotifyPurchaseOrderChange;
  CleanApproved := TransChange.Approved; //  qryTransChanges.FieldByName('Approved').AsBoolean;
  CleanActive := TransChange.Active; // qryTransChanges.FieldByName('Active').AsBoolean;
  CleanApproverEmployeeID := TransChange.ApproverEmployeeID; //  qryTransChanges.FieldByName('ApproverEmployeeID').AsInteger;
  Saved := false;
end;

procedure TfmPurchaseOrderChange.grdDetailsCanEditCell(Sender: TObject; ARow,
  ACol: Integer; var CanEdit: Boolean);
begin
  inherited;
  CanEdit := (not Cols[ACol].ReadOnly) and (AccessLevel < 3);
end;

procedure TfmPurchaseOrderChange.grdDetailsEditingDone(Sender: TObject);
var
  RowJson: TJsonObject;
  LineID: integer;
begin
  inherited;
  if (grdDetails.Row > 0) and (grdDetails.Row < grdDetails.RowCount) then begin
    LineID := grdDetails.Ints[0,grdDetails.Row];
    RowJson := JsonRowForID(LineID);
    if grdDetails.Cells[grdDetails.Col, grdDetails.Row] = '' then begin
      RowJson.Delete(ColByIndex(grdDetails.Col).Name);
    end
    else begin
      if grdDetails.Col = cLineDescription then
        RowJson.S[ColByIndex(grdDetails.Col).Name] := grdDetails.Cells[grdDetails.Col, grdDetails.Row]
      else RowJson.F[ColByIndex(grdDetails.Col).Name] := grdDetails.Floats[grdDetails.Col, grdDetails.Row];
    end;
    CalcLineTotal(grdDetails.Row);
    CalcTotals;
  end;
end;

procedure TfmPurchaseOrderChange.grdDetailsGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  inherited;
  if acol = cLineDescription then AEditor := AdvObj.edNormal
  else AEditor := AdvObj.edFloat;
end;

function TfmPurchaseOrderChange.JsonRowForID(
  const aLineID: integer): TJsonObject;
var
  x: integer;
begin
  result := nil;
  for x := 0 to Data.A['Lines'].Count -1 do begin
    if Data.A['Lines'][x].AsObject.I['PurchaseLineID'] = aLineID then begin
      result := Data.A['Lines'][x].AsObject;
      break;
    end;
  end;
  if not Assigned(result) then begin
    result := JO;
    result.I['PurchaseLineID'] := aLineID;
    Data.A['Lines'].Add(result);
  end;
end;

procedure TfmPurchaseOrderChange.LoadGrid;
var
  x: integer;
  row: integer;
  field : TField;
  RowJson: TJsonObject;
begin
  Data.AsString := TransChange.Data; // qryTransChanges.FieldByName('Data').AsString;
  CleanData.AsString := TransChange.Data; // qryTransChanges.FieldByName('Data').AsString;

  if Data.Exists('Comments') then
    memComments.Text := Data.S['Comments']
  else
    memComments.Text := tblMasterComments.AsString;
  if Data.Exists('SalesComments') then
    memSalesComments.Text := Data.S['SalesComments']
  else
    memSalesComments.Text := tblMasterSalesComments.AsString;

  if Data.Exists('ConNote') then
    memConNote.Text := Data.S['ConNote']
  else
    memConNote.Text := tblMasterConNote.AsString;
  if Data.Exists('CustPoNumber') then
    edtCustPoNumber.Text := Data.S['CustPoNumber']
  else
    edtCustPoNumber.Text := tblMasterCustPONumber.AsString;

  grdDetails.RowCount := 2;
  grdDetails.ColCount := High(Cols) + 1;
  for x := Low(Cols) to High(Cols) do begin
    grdDetails.ColumnHeaders.Add(Cols[x].Caption);
    grdDetails.ColWidths[x] := Cols[x].Width;
  end;
  tblDetail.First;
  row := 0;
  while not tblDetail.Eof do begin
    Inc(Row);
    if Row > 1 then
      grdDetails.RowCount := grdDetails.RowCount + 1;
    RowJson := JsonRowForID(tblDetail.FieldByName('PurchaseLineID').AsInteger);
    for x := Low(Cols) to High(Cols) do begin
      if Cols[x].FieldName <> '' then begin
        field := tblDetail.FieldByName(Cols[x].FieldName);
        if field is TFloatField then begin
          if TFloatField(Field).currency then
            grdDetails.Cells[x,Row] := FloatToStrF(Field.AsFloat, ffCurrency, 15, CurrencyRoundPlaces)
          else
            //grdDetails.Floats[x,Row] := Field.AsFloat;
            grdDetails.Cells[x,Row] := Field.AsString;
        end
        else if field is TIntegerField then
          grdDetails.Ints[x,Row] := Field.AsInteger
        else
          grdDetails.Cells[x,Row] := Field.AsString;
      end
      else if Assigned(RowJson) and (Pos('New_', Cols[x].Name) = 1) and RowJson.FloatExists(Cols[x].Name) then begin
        if SameText(Cols[x].Name,'New_CostEx') then
          grdDetails.Cells[x,Row] := FloatToStrF(RowJson.F[Cols[x].Name], ffCurrency, 15, CurrencyRoundPlaces)
        else
          grdDetails.Floats[x,Row] := RowJson.F[Cols[x].Name];
      end else if Assigned(RowJson) and (x = cLineDescription) and RowJson.StringExists(Cols[x].Name) then begin
          grdDetails.Cells[x,Row] := RowJson.S[Cols[x].Name];
      end
      else
        grdDetails.Cells[x,Row] := '';
    end;
    CalcLineTotal(Row);
    tblDetail.Next;
  end;
  CalcTotals;
end;

procedure TfmPurchaseOrderChange.memCommentsChange(Sender: TObject);
begin
  inherited;
  if not TMemo(Sender).Focused then exit;
  Data.S['Comments'] := TMemo(Sender).Text;
end;

procedure TfmPurchaseOrderChange.memConNoteChange(Sender: TObject);
begin
  inherited;
  if not TMemo(Sender).Focused then exit;
  Data.S['ConNote'] := TMemo(Sender).Text;
end;

procedure TfmPurchaseOrderChange.memSalesCommentsChange(Sender: TObject);
begin
  inherited;
  if not TMemo(Sender).Focused then exit;
  Data.S['SalesComments'] := TMemo(Sender).Text;
end;

(*procedure TfmPurchaseOrderChange.mnuNewPOClick(Sender: TObject);
begin
  inherited;
  if not SaveChanges then Exit;

  Notify(false);
  OpenERPForm('TPurchaseGUI',0,MakeNewPOforLine);
  Close;
end;*)

procedure TfmPurchaseOrderChange.NotifyApproval;
//var
//  body, subject: string;
//  link: string;
//  email: string;
//  ToDo: TToDo;
begin
  if chkSendEmail.Checked and (TransChange.ApproverEmployeeID > 0) then begin
    TApprovalNotification.Notify(self);

//    if qryApproverLookup.FieldByName('EmployeeID').AsInteger = AppEnv.Employee.EmployeeID then begin
//      { this is the approver .. }
//
//
//      ToDo := TToDo.CreateWithSharedConn(nil);
//      try
//        ToDo.New;
//        ToDo.EmployeeID := qryTransChanges.FieldByName('EmployeeID').AsInteger;
//        ToDo.ToDoByDate := now;
//        if qryTransChanges.FieldByName('Approved').AsBoolean then
//          ToDo.Description := 'Changes to Purchase Order ' + IntToStr(tblMasterPurchaseOrderID.AsInteger) + ' have been approved'
//        else
//          ToDo.Description := 'Changes to Purchase Order ' + IntToStr(tblMasterPurchaseOrderID.AsInteger) + ' have not been approved';
//        ToDo.LinkTo := 'Purchase Order Change';
//        ToDo.LinkToID := qryTransChanges.FieldByName('ID').AsInteger;
//        ToDo.Save;
//      finally
//        ToDo.Free;
//      end;
//
//
//      email := TEmployee.EmailForEmployeeID(qryTransChanges.FieldByName('EmployeeID').AsInteger);
//      if email <> '' then begin
//        if qryTransChanges.FieldByName('Approved').AsBoolean then begin
//          subject := 'Purchase Order Changes ' + IntToStr(qryTransChanges.FieldByName('ID').AsInteger) + ' have been approved';
//          body :=
//            'The following Purchase Order Changes have been approved:' + #13#10 ;
//
//        end
//        else begin
//          subject := 'Purchase Order Changes ' + IntToStr(qryTransChanges.FieldByName('ID').AsInteger) + ' have not been approved';
//          body :=
//            'The following Purchase Order Changes have not been approved:' + #13#10 ;
//        end;
//
//        body := body +
//          'No: ' + IntToStr(qryTransChanges.FieldByName('ID').AsInteger) + #13#10 +
//          'Description: ' + tblMasterClientPrintName.AsString + #13#10;
//        if AppEnv.CompanyPrefs.ErpApiEnabled then begin
//          link := '<a href="http://'+'localhost'+':' +
//            IntToStr(AppEnv.CompanyPrefs.ErpApiPort) +
//            '/trueerp?OpenForm=TfmPurchaseOrderChange&KeyID=' + IntToStr(qryTransChanges.FieldByName('ID').AsInteger) + '">Purchase Order Change '+IntToStr(qryTransChanges.FieldByName('ID').AsInteger)+'</a>';
//          body := body +
//            'Link: ' + link + #13#10;
//            //'(Note: This link will only work if ERP is running on the same computer when opening the link)' + #13#10
//        end;
//
//        body := body +
//          'Creation Date: ' + DateToStr(qryTransChanges.FieldByName('CreateDate').AsDateTime) + #13#10 +
//          'Employee: ' + TEmployee.IDToggle(qryTransChanges.FieldByName('EmployeeID').AsInteger);
//        TCorrespondenceGui.EmailEmployee(
//          email,
//          subject,
//          body,
//          qryTransChanges.FieldByName('EmployeeID').AsInteger,
//          true);
//      end
//      else begin
//       CommonLib.MessageDlgXP_Vista('There is no Email Address configured for Employee ' +
//         TEmployee.EmployeeNameForID(qryTransChanges.FieldByName('EmployeeID').AsInteger) ,mtInformation,[mbOk],0);
//      end;
//    end
//    else begin
//      { this is the creater .. }
//
//      ToDo := TToDo.CreateWithSharedConn(nil);
//      try
//        ToDo.New;
//        ToDo.EmployeeID := qryApproverLookup.FieldByName('EmployeeID').AsInteger;
//        ToDo.ToDoByDate := now;
//        ToDo.Description := 'Purchase Order Change ' + IntToStr(qryTransChanges.FieldByName('ID').AsInteger) + ' '+ APPROVALREQUESTDESC+'.';
//        ToDo.LinkTo := 'Purchase Order Change';
//        ToDo.LinkToID := qryTransChanges.FieldByName('ID').AsInteger;
//        ToDo.Save;
//      finally
//        ToDo.Free;
//      end;
//
//      if qryApproverLookup.FieldByName('Email').AsString <> '' then begin
//        body :=
//          'Purchase Order Change ' +  IntToStr(qryTransChanges.FieldByName('ID').AsInteger) + ' '+ APPROVALREQUESTDESC +'.' + #13#10 +
//          'Description: ' + tblMasterClientPrintName.AsString + #13#10;
//        if AppEnv.CompanyPrefs.ErpApiEnabled then begin
//          link := '<a href="http://'+'localhost'+':' +
//            IntToStr(AppEnv.CompanyPrefs.ErpApiPort) +
//            '/trueerp?OpenForm=TfmPurchaseOrderChange&KeyID=' + IntToStr(qryTransChanges.FieldByName('ID').AsInteger) + '">Purchase Order Change '+IntToStr(qryTransChanges.FieldByName('ID').AsInteger)+'</a>';
//          body := body +
//            'Link: ' + link + #13#10;
//            //'(Note: This link will only work if ERP is running on the same computer when opening the link)' + #13#10
//        end;
//
//        body := body +
//          'Creation Date: ' + DateToStr(qryTransChanges.FieldByName('CreateDate').AsDateTime) + #13#10 +
//          'Employee: ' + TEmployee.IDToggle(qryTransChanges.FieldByName('EmployeeID').AsInteger);
//        TCorrespondenceGui.EmailEmployee(
//          qryApproverLookup.FieldByName('Email').AsString,
//          'Purchase Order Change ' + IntToStr(qryTransChanges.FieldByName('ID').AsInteger) + ' '+ APPROVALREQUESTDESC +'.',
//          body,
//          qryApproverLookup.FieldByName('EmployeeID').AsInteger,
//          true);
//      end
//      else begin
//       CommonLib.MessageDlgXP_Vista('There is no Email Address configured for Employee ' +
//         qryApproverLookup.FieldByName('EmployeeName').AsString,mtInformation,[mbOk],0);
//      end;
//    end;
  end;
end;

(*procedure TfmPurchaseOrderChange.popNewPOPopup(Sender: TObject);
var
  fs:String;
begin
  inherited;
  fs:= POLProductName(strtoint(grdDetails.Cells[cPurchaselineID,grdDetails.Row]));
  if fs <> '' then
    mnuNewPO.caption := 'New PO - Link to ' + quotedstr(fs)
  else
    mnuNewPO.caption := 'New PO - Link to PO # ' + inttostr(tblmasterPurchaseOrderId.asInteger);
end;*)

function TfmPurchaseOrderChange.SaveChanges: boolean;
var
  POUpdated: boolean;
begin
  result := true;
  POUpdated := false;
  if self.AccessLevel < 3 then begin

//    EditDB(qryTransChanges);
    TransChange.Data := Data.AsString;
//    PostDB(qryTransChanges);
    TransChange.PostDB;
    if (not CleanApproved) and TransChange.Approved then begin
      if not self.UpdatePO then begin
        result := false;
//        EditDB(qryTransChanges);
        TransChange.Approved := false;
//        PostDB(qryTransChanges);
        TransChange.PostDb;
        exit;
      end
      else
        POUpdated := true;
    end;
    self.CommitTransaction;
    if POUpdated then
      FlagToDoChangeRequestAsDone;
    NotifyApproval;
    Saved := true;
  end;
end;

procedure TfmPurchaseOrderChange.tblMasterAfterOpen(DataSet: TDataSet);
begin
  inherited;
  btnNewPO.tag:= LinkedPOID(tblmasterPurchaseOrderId.AsInteger);

  if btnNewPO.tag >0 then
        btnNewPO.caption := 'Open Linked'+NL+'PO # ' +inttostr(btnNewPO.tag)
  else  btnNewPO.Caption := 'Make a'+NL+'New PO';
end;

function TfmPurchaseOrderChange.UpdatePO: boolean;
var
  PO: TPurchaseOrder;
  msg: string;
  x: integer;
  RowJson: TJsonObject;
begin
  result := true;
  if AppEnv.Employee.EmployeeID <> TransChange.ApproverEmployeeID then begin
    result := false;
    msg := 'You are not the selected Approver for this PO.';
    CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOK],0);
    exit;
  end;
  PO := TPurchaseOrder.CreateWithNewConn(nil);
  try
    PO.Connection.Connection := MyConnection;
    PO.SilentMode := true;
    PO.Load(TransChange.TransID);
    if not PO.LockTrans(msg) then begin
      result := false;
      CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOK],0);
      exit;
    end;
    { now update it ... }
    for x := 0 to Data.A['Lines'].Count - 1 do begin
      RowJson := Data.A['Lines'][x].AsObject;
      if RowJson.Exists('New_CostEx') or RowJson.Exists('New_UOMQtyOrdered') or RowJson.Exists('New_LineDescription') then begin
        if PO.Lines.LocateId(RowJson.I['PurchaseLineID']) then begin
          if RowJson.Exists('New_UOMQtyOrdered') then
            PO.Lines.UOMOrderQty := RowJson.F['New_UOMQtyOrdered'];
          if RowJson.Exists('New_CostEx') then
            PO.Lines.LineCost := RowJson.F['New_CostEx'];
          if RowJson.Exists('New_LineDescription') then
            PO.Lines.LineDescription := RowJson.S['New_LineDescription'];
        end;
      end;
    end;

    if Data.Exists('Comments') then
      PO.Comments := Data.S['Comments'];
    if Data.Exists('SalesComments') then
      PO.SalesComments := Data.S['SalesComments'];
    if Data.Exists('ConNote') then
      PO.ConNote := Data.S['ConNote'];
    if Data.Exists('CustPoNumber') then
      PO.CustPoNumber := Data.S['CustPoNumber'];

    PO.Approved := true;
    if not PO.Save then begin
      result := false;
      msg := 'Unable to Update and Approve PO. ' + PO.ResultStatus.Messages;
      CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOK],0);
      exit;
    end;
  finally
    PO.Free;
  end;


end;

initialization
  RegisterClass(TfmPurchaseOrderChange);

end.
