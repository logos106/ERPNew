unit frmGoodsReceipt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, Shader, AdvEdit, wwcheckbox, DNMSpeedButton,
  DNMPanel, Grids, Wwdbigrd, Wwdbgrid,
  BusObjGoodsReceipt, BusObjBase, Buttons;

type
  TfmGoodsReceipt = class(TBaseInputGUI)
    pnlButtons: TDNMPanel;
    Label7: TLabel;
    btnStartNewPicking: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    btnControlBarCodes: TDNMSpeedButton;
    btnCompleted: TDNMSpeedButton;
    btnDelete: TDNMSpeedButton;
    cmdPrint: TDNMSpeedButton;
    chkAutoPrint: TwwCheckBox;
    pnlMaster: TDNMPanel;
    lblEmployee: TLabel;
    lblEmployeeName: TLabel;
    Label1: TLabel;
    lblPO: TLabel;
    Label3: TLabel;
    lbPickStart: TLabel;
    lblReceiptStart: TLabel;
    lbPickfinish: TLabel;
    lblReceiptFinish: TLabel;
    lblPO2: TLabel;
    imgProduct: TImage;
    Label2: TLabel;
    lblLastProduct: TLabel;
    lblStatus: TLabel;
    edtBarcodeInput: TEdit;
    edtQty: TAdvEdit;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlPOLines: TDNMPanel;
    pnlReceiptLines: TDNMPanel;
    Splitter1: TSplitter;
    grdPoLines: TwwDBGrid;
    grdReceiptLines: TwwDBGrid;
    Label5: TLabel;
    qryPOLines: TERPQuery;
    qryGoodsReceiptLines: TERPQuery;
    qryGoodsReceipt: TERPQuery;
    dsPOLines: TDataSource;
    dsGoodsReceiptLines: TDataSource;
    dsGoodsReceipt: TDataSource;
    qryPOLinesPurchaseLineID: TIntegerField;
    qryPOLinesSEQNo: TIntegerField;
    qryPOLinesGlobalRef: TWideStringField;
    qryPOLinesPurchaseOrderID: TIntegerField;
    qryPOLinesBaseLineno: TIntegerField;
    qryPOLinesProductID: TIntegerField;
    qryPOLinesPARTTYPE: TWideStringField;
    qryPOLinesINCOMEACCNT: TWideStringField;
    qryPOLinesASSETACCNT: TWideStringField;
    qryPOLinesCOGSACCNT: TWideStringField;
    qryPOLinesProductGroup: TWideStringField;
    qryPOLinesProductName: TWideStringField;
    qryPOLinesProductPrintName: TWideStringField;
    qryPOLinesPartBarcode: TWideStringField;
    qryPOLinesProduct_Description: TWideStringField;
    qryPOLinesAccountNumber: TWideStringField;
    qryPOLinesAccountName: TWideStringField;
    qryPOLinesAccountGroup: TWideStringField;
    qryPOLinesLineTaxRate: TFloatField;
    qryPOLinesLineCost: TFloatField;
    qryPOLinesAvgCost: TFloatField;
    qryPOLinesStandardCost: TFloatField;
    qryPOLinesLineCostInc: TFloatField;
    qryPOLinesLineTaxCode: TWideStringField;
    qryPOLinesLineTax: TFloatField;
    qryPOLinesQtySold: TFloatField;
    qryPOLinesUnitofMeasureQtySold: TFloatField;
    qryPOLinesShipped: TFloatField;
    qryPOLinesUnitofMeasureShipped: TFloatField;
    qryPOLinesBackOrder: TFloatField;
    qryPOLinesUnitofMeasureBackorder: TFloatField;
    qryPOLinesUnitofMeasurePOLines: TWideStringField;
    qryPOLinesUnitOfMeasureID: TIntegerField;
    qryPOLinesUnitofMeasureMultiplier: TFloatField;
    qryPOLinesInvoiced: TWideStringField;
    qryPOLinesClassID: TIntegerField;
    qryPOLinesClass: TWideStringField;
    qryPOLinesCustomerJob: TWideStringField;
    qryPOLinesCustomerPrintJob: TWideStringField;
    qryPOLinesCustomerJobID: TIntegerField;
    qryPOLinesRAQty: TFloatField;
    qryPOLinesRAstatus: TWideStringField;
    qryPOLinesBatch: TWideStringField;
    qryPOLinesUseTimecost: TWideStringField;
    qryPOLinesSaleID_Timecost: TIntegerField;
    qryPOLinesTimecostMarkupPer: TFloatField;
    qryPOLinesTimecostPrice: TFloatField;
    qryPOLinesTimecostMarkupDol: TFloatField;
    qryPOLinesserialno: TWideMemoField;
    qryPOLinesTotalLineAmount: TFloatField;
    qryPOLinesTotalLineAmountInc: TFloatField;
    qryPOLinesCOGSTotalLineAmount: TFloatField;
    qryPOLinesCOGSTotalLineAmountInc: TFloatField;
    qryPOLinesEditedFlag: TWideStringField;
    qryPOLinesDeleted: TWideStringField;
    qryPOLinesRAInvoiceNo: TWideStringField;
    qryPOLinesAttrib1Purchase: TFloatField;
    qryPOLinesAttrib2Purchase: TFloatField;
    qryPOLinesAttrib1PurchaseRate: TFloatField;
    qryPOLinesAttrib1PurchaseEst: TFloatField;
    qryPOLinesAttrib2PurchaseEst: TFloatField;
    qryPOLinesLastLineID: TIntegerField;
    qryPOLinesRelatedPOIDUsed: TWideStringField;
    qryPOLinesRelatedPOID: TIntegerField;
    qryPOLinesLandedCostsPerItem: TFloatField;
    qryPOLinesLandedCostsPercentage: TFloatField;
    qryPOLinesLandedCostsTotal: TFloatField;
    qryPOLinesForeignExchangeRate: TFloatField;
    qryPOLinesForeignExchangeCode: TWideStringField;
    qryPOLinesForeignCurrencyLineCost: TFloatField;
    qryPOLinesForeignTotalLineAmount: TFloatField;
    qryPOLinesDescAttrib1: TWideStringField;
    qryPOLinesDescAttrib2: TWideStringField;
    qryPOLinesDescAttrib3: TWideStringField;
    qryPOLinesDescAttrib4: TWideStringField;
    qryPOLinesDescAttrib5: TWideStringField;
    qryPOLinesSearchFilter: TWideStringField;
    qryPOLinesSearchFilterCopy: TWideStringField;
    qryPOLinesReceivedDate: TDateTimeField;
    qryPOLinesCostCentreId: TIntegerField;
    qryPOLinesmsTimeStamp: TDateTimeField;
    qryPOLinesDocketNumber: TWideStringField;
    qryPOLinesPartSpecID: TIntegerField;
    qryPOLinesSpecDescription: TWideStringField;
    qryPOLinesSpecValue: TFloatField;
    qryPOLinesNewForeignExchangeRate: TFloatField;
    qryPOLinesETADate: TDateField;
    qryPOLinesCustomField1: TWideStringField;
    qryPOLinesCustomField2: TWideStringField;
    qryPOLinesCustomField3: TWideStringField;
    qryPOLinesCustomField4: TWideStringField;
    qryPOLinesCustomField5: TWideStringField;
    qryPOLinesCustomField6: TWideStringField;
    qryPOLinesCustomField7: TWideStringField;
    qryPOLinesCustomField8: TWideStringField;
    qryPOLinesCustomField9: TWideStringField;
    qryPOLinesCustomField10: TWideStringField;
    qryPOLinesLineNotes: TWideMemoField;
    qryPOLinesINCOMEACCNTID: TIntegerField;
    qryPOLinesASSETACCNTID: TIntegerField;
    qryPOLinesCOGSACCNTID: TIntegerField;
    qryPOLinesSortID: TIntegerField;
    qryPOLinesMemoLine: TWideMemoField;
    qryPOLinesSaleLineID: TIntegerField;
    qryPOLinesRelatedShipContainerID: TIntegerField;
    qryPOLinesRelatedShipContainerIDUsed: TWideStringField;
    qryPOLinesRepairId: TIntegerField;
    qryPOLinesCustomerEquipmentID: TIntegerField;
    qryPOLinesEquipmentName: TWideStringField;
    qryPOLinesProcTreeId: TIntegerField;
    qryPOLinesSupplierProductCode: TWideStringField;
    qryPOLinesSupplierProductName: TWideStringField;
    qryPOLinesRALineRef: TWideStringField;
    qryPOLinesPrintedValue: TFloatField;
    qryPOLinesDiscountPercent: TFloatField;
    qryPOLinesDiscountAmount: TFloatField;
    qryPOLinesOriginalCost: TFloatField;
    qryPOLinesMatrixDesc: TWideMemoField;
    qryPOLinesMatrixRef: TWideMemoField;
    qryPOLinesMatrixPrice: TFloatField;
    qryPOLinesSmartOrderID: TIntegerField;
    qryPOLinesSmartOrderLineID: TIntegerField;
    qryPOLinesmsUpdateSiteCode: TWideStringField;
    qryPOLinesformulaId: TIntegerField;
    qryPOLinesFormulaName: TWideStringField;
    qryPOLinesFormulaQtySoldValue1: TFloatField;
    qryPOLinesFormulaQtySoldValue2: TFloatField;
    qryPOLinesFormulaQtySoldValue3: TFloatField;
    qryPOLinesFormulaQtySoldValue4: TFloatField;
    qryPOLinesFormulaQtySoldValue5: TFloatField;
    qryPOLinesFormulaQtySoldValue: TFloatField;
    qryPOLinesFormulaQtyShippedValue1: TFloatField;
    qryPOLinesFormulaQtyShippedValue2: TFloatField;
    qryPOLinesFormulaQtyShippedValue3: TFloatField;
    qryPOLinesFormulaQtyShippedValue4: TFloatField;
    qryPOLinesFormulaQtyShippedValue5: TFloatField;
    qryPOLinesFormulaQtyShippedValue: TFloatField;
    qryPOLinesEmployeeID: TIntegerField;
    qryPOLinesEmployeeName: TWideStringField;
    qryPOLinesAreaCode: TWideStringField;
    qryPOLinesLinesOrder: TIntegerField;
    qryPOLinesExpenseProductID: TIntegerField;
    qryPOLinesExpenseProductName: TWideStringField;
    qryPOLinesGeneralNotes: TWideMemoField;
    qryPOLinesBoxesReceived: TIntegerField;
    qryPOLinesBoxesOrdered: TIntegerField;
    qryGoodsReceiptLinesGlobalRef: TWideStringField;
    qryGoodsReceiptLinesID: TIntegerField;
    qryGoodsReceiptLinesMasterID: TIntegerField;
    qryGoodsReceiptLinesPurchaseLineID: TIntegerField;
    qryGoodsReceiptLinesQuantityReceived: TFloatField;
    qryGoodsReceiptLinesSerialNumber: TWideStringField;
    qryGoodsReceiptLinesBatchNumber: TWideStringField;
    qryGoodsReceiptLinesBatchExpiryDate: TDateTimeField;
    qryGoodsReceiptLinesBinID: TIntegerField;
    qryGoodsReceiptLinesDeleted: TWideStringField;
    qryGoodsReceiptLinesmsTimeStamp: TDateTimeField;
    qryGoodsReceiptLinesmsUpdateSiteCode: TWideStringField;
    qryGoodsReceiptGlobalRef: TWideStringField;
    qryGoodsReceiptID: TIntegerField;
    qryGoodsReceiptEmployeeID: TIntegerField;
    qryGoodsReceiptPurchaseOrderID: TIntegerField;
    qryGoodsReceiptReceiptStartTime: TDateTimeField;
    qryGoodsReceiptReceiptEndTime: TDateTimeField;
    qryGoodsReceiptActive: TWideStringField;
    qryGoodsReceiptProcessed: TWideStringField;
    qryGoodsReceiptmsTimeStamp: TDateTimeField;
    qryGoodsReceiptmsUpdateSiteCode: TWideStringField;
    qryProduct: TERPQuery;
    qryPOLinesLookup: TERPQuery;
    WideStringField1: TWideStringField;
    WideStringField2: TWideStringField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    WideStringField3: TWideStringField;
    IntegerField1: TIntegerField;
    FloatField4: TFloatField;
    FloatField5: TFloatField;
    FloatField6: TFloatField;
    IntegerField2: TIntegerField;
    FloatField7: TFloatField;
    WideStringField4: TWideStringField;
    IntegerField3: TIntegerField;
    WideStringField5: TWideStringField;
    WideStringField6: TWideStringField;
    WideStringField7: TWideStringField;
    IntegerField4: TIntegerField;
    FloatField8: TFloatField;
    WideStringField8: TWideStringField;
    WideStringField9: TWideStringField;
    WideStringField10: TWideStringField;
    IntegerField5: TIntegerField;
    FloatField9: TFloatField;
    FloatField10: TFloatField;
    FloatField11: TFloatField;
    WideMemoField1: TWideMemoField;
    FloatField12: TFloatField;
    FloatField13: TFloatField;
    FloatField14: TFloatField;
    FloatField15: TFloatField;
    WideStringField11: TWideStringField;
    WideStringField12: TWideStringField;
    WideStringField13: TWideStringField;
    FloatField16: TFloatField;
    FloatField17: TFloatField;
    FloatField18: TFloatField;
    FloatField19: TFloatField;
    FloatField20: TFloatField;
    IntegerField6: TIntegerField;
    WideStringField14: TWideStringField;
    IntegerField7: TIntegerField;
    FloatField21: TFloatField;
    FloatField22: TFloatField;
    FloatField23: TFloatField;
    FloatField24: TFloatField;
    WideStringField15: TWideStringField;
    FloatField25: TFloatField;
    FloatField26: TFloatField;
    WideStringField16: TWideStringField;
    WideStringField17: TWideStringField;
    WideStringField18: TWideStringField;
    WideStringField19: TWideStringField;
    WideStringField20: TWideStringField;
    WideStringField21: TWideStringField;
    WideStringField22: TWideStringField;
    DateTimeField1: TDateTimeField;
    IntegerField8: TIntegerField;
    DateTimeField2: TDateTimeField;
    WideStringField23: TWideStringField;
    IntegerField9: TIntegerField;
    WideStringField24: TWideStringField;
    FloatField27: TFloatField;
    FloatField28: TFloatField;
    DateField1: TDateField;
    WideStringField25: TWideStringField;
    WideStringField26: TWideStringField;
    WideStringField27: TWideStringField;
    WideStringField28: TWideStringField;
    WideStringField29: TWideStringField;
    WideStringField30: TWideStringField;
    WideStringField31: TWideStringField;
    WideStringField32: TWideStringField;
    WideStringField33: TWideStringField;
    WideStringField34: TWideStringField;
    WideMemoField2: TWideMemoField;
    IntegerField10: TIntegerField;
    IntegerField11: TIntegerField;
    IntegerField12: TIntegerField;
    IntegerField13: TIntegerField;
    WideMemoField3: TWideMemoField;
    IntegerField14: TIntegerField;
    IntegerField15: TIntegerField;
    WideStringField35: TWideStringField;
    IntegerField16: TIntegerField;
    IntegerField17: TIntegerField;
    WideStringField36: TWideStringField;
    IntegerField18: TIntegerField;
    WideStringField37: TWideStringField;
    WideStringField38: TWideStringField;
    WideStringField39: TWideStringField;
    FloatField29: TFloatField;
    FloatField30: TFloatField;
    FloatField31: TFloatField;
    FloatField32: TFloatField;
    WideMemoField4: TWideMemoField;
    WideMemoField5: TWideMemoField;
    FloatField33: TFloatField;
    IntegerField19: TIntegerField;
    IntegerField20: TIntegerField;
    WideStringField40: TWideStringField;
    IntegerField21: TIntegerField;
    WideStringField41: TWideStringField;
    FloatField34: TFloatField;
    FloatField35: TFloatField;
    FloatField36: TFloatField;
    FloatField37: TFloatField;
    FloatField38: TFloatField;
    FloatField39: TFloatField;
    FloatField40: TFloatField;
    FloatField41: TFloatField;
    FloatField42: TFloatField;
    FloatField43: TFloatField;
    FloatField44: TFloatField;
    FloatField45: TFloatField;
    IntegerField22: TIntegerField;
    WideStringField42: TWideStringField;
    WideStringField43: TWideStringField;
    IntegerField23: TIntegerField;
    IntegerField24: TIntegerField;
    WideStringField44: TWideStringField;
    WideMemoField6: TWideMemoField;
    IntegerField25: TIntegerField;
    IntegerField26: TIntegerField;
    FloatField46: TFloatField;
    IntegerField27: TIntegerField;
    IntegerField28: TIntegerField;
    WideStringField45: TWideStringField;
    IntegerField29: TIntegerField;
    IntegerField30: TIntegerField;
    WideStringField46: TWideStringField;
    WideStringField47: TWideStringField;
    WideStringField48: TWideStringField;
    WideStringField49: TWideStringField;
    WideStringField50: TWideStringField;
    WideStringField51: TWideStringField;
    WideStringField52: TWideStringField;
    WideStringField53: TWideStringField;
    WideStringField54: TWideStringField;
    WideStringField55: TWideStringField;
    FloatField47: TFloatField;
    FloatField48: TFloatField;
    FloatField49: TFloatField;
    WideStringField56: TWideStringField;
    FloatField50: TFloatField;
    FloatField51: TFloatField;
    grdReceiptLinesIButton: TwwIButton;
    qryGoodsReceiptLinesProductName: TStringField;
    qryPOLinesReceiptQty: TFloatField;
    qryPOLinesQtyOutstanding: TFloatField;
    btnPrintPO: TDNMSpeedButton;
    chkChooseRpt: TCheckBox;
    procedure edtBarcodeInputKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdPoLinesRowChanged(Sender: TObject);
    procedure qryPOLinesAfterOpen(DataSet: TDataSet);
    procedure btnCancelClick(Sender: TObject);
    procedure edtQtyKeyPress(Sender: TObject; var Key: Char);
    procedure btnControlBarCodesClick(Sender: TObject);
    procedure cmdPrintClick(Sender: TObject);
    procedure btnStartNewPickingClick(Sender: TObject);
    procedure btnCompletedClick(Sender: TObject);
    procedure grdReceiptLinesIButtonClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure qryPOLinesLookupBeforeOpen(DataSet: TDataSet);
    procedure qryGoodsReceiptLinesCalcFields(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure qryPOLinesCalcFields(DataSet: TDataSet);
    procedure grdPoLinesCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnPrintPOClick(Sender: TObject);
  private
    fEmployeeID: integer;
    fEmployeeName: string;
    GoodsReceipt: TGoodsReceipt;
    procedure ProcessBarcode(const aCode: string);
    procedure SetEmployeeID(const Value: integer);
    procedure UpdateDisplay;
    function GetStatus: string;
    procedure LoadPODetails(const aPOID: integer = 0);
    function CheckEmployee: boolean;
    procedure SelectLine;
    function IsSNProduct: boolean;
    function TotalReceivedForPOLine(const POLineID: integer): double;
    procedure ProcessQty;
    procedure StartNew;
    procedure StartNext;
    procedure PrintGoodsReceipt(const DontAsk: boolean = false);
    function CheckComplete(const AskForConfirmation: Boolean = true): boolean;
    procedure AddSerialNumber(const aSN: string);
    procedure AddBarcode(const aPartID: integer; const aUOMID: integer = 0);
    function SaveData: boolean;
    procedure PrintPurchaseOrder;
  protected
    property EmployeeID: integer read fEmployeeID write SetEmployeeID;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string); override;
    property Status: string read GetStatus;
//    Function LoadTemplate(const bPrint, bSave: boolean; const DoClose: boolean = true; const FileName: string = '') :Boolean ; reintroduce;
  public
    { Public declarations }
  end;


implementation

uses
  Types, StrUtils, BarcodeConst, BusObjEmployee, BusObjConst, CommonLib,
  DnMExceptions, CommonDBLib, ImagesLib, AppEnvironment, FormFactory,
  DbSharedObjectsObj, frmGoodsReceiptPrintPO, tcDataUtils, frmPurchaseOrders;

const
  Status_None = '';
  Status_New = 'New';
  Status_Started = 'Started';
  Status_Finished = 'Finished';
  Status_Processed = 'Processed';

{$R *.dfm}

procedure TfmGoodsReceipt.AddBarcode(const aPartID: integer; const aUOMID: integer);
var
  found, AllocFound: boolean;
  POLineID: integer;
begin
  found := false;
  AllocFound := false;
  POLineID := 0;
  qryPOLines.DisableControls;
  try
    qryPOLines.First;
    while not qryPOLines.EOF do begin
      if qryPOLinesProductID.AsInteger = aPartID then begin
        found := true;
        if (qryPOLinesQtyOutstanding.AsFloat > 0) and ((aUOMID = 0) or (aUOMID = qryPOLinesUnitOfMeasureID.AsInteger)) then begin
          { we need more of these .. }
          AllocFound := true;
          POLineID := qryPOLinesPurchaseLineID.AsInteger;
          { find the line on the receipt .. }
          if qryGoodsReceiptLines.Locate('PurchaseLineID',qryPOLinesPurchaseLineID.AsInteger,[]) then begin
            { we already have this line }
          end
          else begin
            { we don't have it yet so add it .. }
            GoodsReceipt.Lines.New;
            GoodsReceipt.Lines.PurchaseLineID := qryPOLines.FieldByName('PurchaseLineID').AsInteger;
            GoodsReceipt.Lines.PostDb;
          end;
          self.FocusControl(edtQty);
          exit;
        end;
      end;
      qryPOLines.Next;
    end;
  finally
    qryPOLines.EnableControls;
    if POLineID > 0 then begin
      if qryPOLines.Locate('PurchaseLineID',POLineID,[]) then begin
//        SelectLine;
      end;
    end;
  end;
  if not found then
    CommonLib.MessageDlgXP_Vista('Product not found on this Order.',mtInformation,[mbOk],0)
  else if not AllocFound then
    CommonLib.MessageDlgXP_Vista('This Product is Fully Allocated.',mtInformation,[mbOk],0);
end;

procedure TfmGoodsReceipt.AddSerialNumber(const aSN: string);
var
  qry: TERPQuery;
begin
  { check for SN's already allocated on th BO PO }
  qry := DbSharedObj.GetQuery(MyConnection);
  try
    qry.SQL.Add('select * from tblpqadetails pqaDetails');
    qry.SQL.Add('inner join tblpqa pqa on pqa.PQAID = pqaDetails.PQAID and pqa.TransType = "TPurchaseOrderLine"');
    qry.SQL.Add('where pqaDetails.PQAType = "SN"');
    qry.SQL.Add('and pqa.TransID = ' + IntToStr(GoodsReceipt.PurchaseOrderID));
    qry.SQL.Add('and pqaDetails.Value not in (select SerialNumber from tblGoodsReceiptLines where ID = '+IntToStr(GoodsReceipt.ID)+')');
    qry.SQL.Add('and pqaDetails.Value = ' + QuotedStr(aSN));

    qry.Open;
    if not qry.IsEmpty then begin
      qryPOLines.Locate('PurchaseLineID',qry.FieldByName('TransLineID').AsInteger,[]);
    end;

  finally
    DbSharedObj.ReleaseObj(qry);
  end;

  { do we need more SN's for this line .. }
  if TotalReceivedForPOLine(qryPOLines.FieldByName('PurchaseLineID').AsInteger) < qryPOLines.FieldByName('BackOrder').AsFloat then begin
    { add the line .. }
    if GoodsReceipt.Lines.PurchaseLineID > 0 then
      GoodsReceipt.Lines.New;
    GoodsReceipt.Lines.PurchaseLineID := qryPOLines.FieldByName('PurchaseLineID').AsInteger;
    GoodsReceipt.Lines.QuantityReceived := 1;
    GoodsReceipt.Lines.SerialNumber := aSN;
    GoodsReceipt.Lines.PostDb;
    qryPOLines.Refresh;

  end
  else begin
    CommonLib.MessageDlgXP_Vista('Purchase Line Serial Numbers are already fully allocated.',mtInformation,[mbOk],0);
    exit;
  end;

end;

procedure TfmGoodsReceipt.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfmGoodsReceipt.btnCompletedClick(Sender: TObject);
begin
  inherited;
  if not GoodsReceipt.Processed then begin
    if GoodsReceipt.Lines.Count > 0 then begin
      if CommonLib.MessageDlgXP_Vista('Do you wish to Save and Process this Goods Receipt?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
        if not SaveData then
          exit;
      end;
    end;
  end;
  Close;
end;

procedure TfmGoodsReceipt.btnControlBarCodesClick(Sender: TObject);
begin
  DisableForm;
  try
    inherited;
    PrintTemplateReport('Goods Receipt Control Barcodes', '', not(appEnv.Employee.PreviewAllreport), 1);
  finally
    EnableForm;
  end;
end;

procedure TfmGoodsReceipt.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if GoodsReceipt.Processed then begin
    CommonLib.MessageDlgXP_Vista('Can not delete a Processed Goods Receipt.',mtInformation,[mbOk],0);
    exit;
  end;
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this Goods Receipt?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
    GoodsReceipt.Active := false;
    if GoodsReceipt.Save then begin
      GoodsReceipt.Connection.CommitTransaction;
      GoodsReceipt.Connection.BeginTransaction;
      StartNew;
    end;
  end;
end;

procedure TfmGoodsReceipt.btnPrintPOClick(Sender: TObject);
var
  POID: integer;
begin
  inherited;
  if not CheckEmployee then exit;
  POID := GoodsReceipt.PurchaseOrderID;
  if frmGoodsReceiptPrintPO.SelectPurchaseOrder(POID) then begin
    if GoodsReceipt.PurchaseOrderID = 0 then begin
      LoadPODetails(POID);
      exit;
    end
    else if GoodsReceipt.PurchaseOrderID <> POID then begin
      if GoodsReceipt.Lines.Count > 0 then begin
        if CommonLib.MessageDlgXP_Vista('Do you wish to Save and Process the Current Goods Receipt?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
          if SaveData then begin
            if CheckComplete then begin
              // PrintGoodsReceipt(true)
            end
            else
              exit;
          end
          else
            exit;
        end;
      end;

    end;
    GoodsReceipt.Load(0);
    qryGoodsReceiptLines.Close;
    StartNext;
    LoadPODetails(POID);
    GoodsReceipt.EmployeeID := fEmployeeID;
    PrintPurchaseOrder;
  end;

end;

procedure TfmGoodsReceipt.btnStartNewPickingClick(Sender: TObject);
begin
  inherited;
  StartNext;
end;

function TfmGoodsReceipt.CheckComplete(const AskForConfirmation: Boolean): boolean;
var
  msg: string;
begin
  result := GoodsReceipt.Processed;
  if (not result) and (GoodsReceipt.Lines.Count > 0) then begin
    if (not AskForConfirmation) or
       (CommonLib.MessageDlgXP_Vista('Do you wish to complete and Process this Goods Receipt?',mtConfirmation,[mbYes,mbNo],0) = mrYes) then begin
      if not GoodsReceipt.Process(msg) then begin
        if msg <> '' then
          CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);
        exit;
      end;
      if GoodsReceipt.Save then begin
        result := true;
        GoodsReceipt.Connection.CommitTransaction;
        GoodsReceipt.Connection.BeginTransaction;
      end;
    end;
  end;
end;

function TfmGoodsReceipt.CheckEmployee: boolean;
begin
  result := true;
  if GoodsReceipt.EmployeeID = 0 then begin
    result := false;
    CommonLib.MessageDlgXP_Vista('Please select an employee first.',mtInformation,[mbOk],0);
    exit;
  end;
end;

procedure TfmGoodsReceipt.cmdPrintClick(Sender: TObject);
begin
  inherited;
  if CheckComplete then
    PrintGoodsReceipt(true);
end;

procedure TfmGoodsReceipt.DoBusinessObjectEvent(const Sender: TDatasetBusObj;
  const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TGoodsReceipt then TGoodsReceipt(Sender).DataSet := qryGoodsReceipt;
    if Sender is TGoodsReceiptLine  then TGoodsReceiptLine(Sender).DataSet := qryGoodsReceiptLines;
  end
end;

procedure TfmGoodsReceipt.edtBarcodeInputKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = Chr(VK_RETURN)) or (Key = Chr(VK_TAB)) then begin
    Key := #0;   // eat VK_RETURN
    ProcessBarcode(edtBarcodeInput.Text);
    edtBarcodeInput.Text := '';
  end;
end;

procedure TfmGoodsReceipt.edtQtyKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = Chr(VK_RETURN)) or (Key = Chr(VK_TAB)) then begin
    ProcessQty;
    Key := #0;
    edtQty.FloatValue := 0;
    self.FocusControl(edtBarcodeInput);
  end;
end;

procedure TfmGoodsReceipt.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  GuiPrefs.Node['AutoPrint'].AsBoolean := chkAutoPrint.Checked;
  inherited;
  Action := caFree;
end;

procedure TfmGoodsReceipt.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := true;
  if not GoodsReceipt.Processed then begin
    if GoodsReceipt.Lines.Count > 0 then begin
      if CommonLib.MessageDlgXP_Vista('Do you wish to Save and Process this Goods Receipt?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
        CanClose := SaveData;
      end;
    end;
  end;
end;

procedure TfmGoodsReceipt.FormCreate(Sender: TObject);
begin
  inherited;
  GoodsReceipt := TGoodsReceipt.Create(self);
  GoodsReceipt.Connection := TMyDacDataConnection.Create(GoodsReceipt);
  TMyDacDataConnection(GoodsReceipt.Connection).MyDacConnection := MyConnection;
  GoodsReceipt.BusObjEvent := DoBusinessObjectEvent;
  lblPO.Caption := '';
  lblPO2.Caption := '';
  lblLastProduct.Caption := '';
end;

procedure TfmGoodsReceipt.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_RETURN) and (Shift = [ssCtrl]) and (btnStartNewPicking.Enabled) then begin
    btnStartNewPickingClick(btnStartNewPicking);
  end;

end;

procedure TfmGoodsReceipt.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: Array of String;
begin
  inherited;
//  EmployeeID := 0;
  DisableForm;
  try
    try
      inherited;
      Setlength(QueryNamesNotToOpen, 3);
      QueryNamesNotToOpen[0] := qryPOLines.Name; // 'qryPOLines';
      QueryNamesNotToOpen[1] := qryPOLinesLookup.Name; // 'qryPOLinesLookup';
      QueryNamesNotToOpen[2] := qryProduct.Name; // 'qryProduct';
      OpenQueries(QueryNamesNotToOpen);

      RollbackTransaction;

      BeginTransaction;
      GoodsReceipt.Load(KeyId);

      if KeyID = 0 then begin
        GoodsReceipt.New;
        qryGoodsReceiptLines.Close;
        GoodsReceipt.Lines;
        GoodsReceipt.PostDB;
      end
      else begin
        LoadPODetails;
        qryGoodsReceiptLines.Refresh;

        if GoodsReceipt.Processed then
          AccessLevel := 5; // read only


      end;
      GoodsReceipt.Lines;
      EmployeeID := GoodsReceipt.EmployeeID;
      UpdateDisplay;
      chkAutoPrint.Checked := GuiPrefs.Node['AutoPrint'].AsBoolean;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;
end;

function TfmGoodsReceipt.GetStatus: string;
begin
  result := Status_None;
  if GoodsReceipt.Processed then
    result := Status_Processed
  else if GoodsReceipt.ReceiptEndTime > 0 then
    result := Status_Finished
  else if GoodsReceipt.ReceiptStartTime > 0 then
    result := Status_Started
  else
    result := Status_New;
end;

procedure TfmGoodsReceipt.grdPoLinesCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if (qryPOLinesUnitofMeasureBackorder.AsFloat = 0) or
     (qryPOLinesUnitofMeasureBackorder.AsFloat = qryPOLinesReceiptQty.AsFloat) then
      Abrush.Color := $00A8FFA8;
end;

procedure TfmGoodsReceipt.grdPoLinesRowChanged(Sender: TObject);
begin
  inherited;
  SelectLine;
end;

procedure TfmGoodsReceipt.grdReceiptLinesIButtonClick(Sender: TObject);
var
  msgOption: word;
begin
  inherited;
  if GoodsReceipt.Processed then begin
    CommonLib.MessageDlgXP_Vista('Can not delete lines from a Processed Goods Receipt.',mtInformation,[mbOk],0);
    exit;
  end;
  msgOption:= MessageDlgXP_Vista('Do You Wish To Delete This Line or Delete all Lines?', mtConfirmation,[] , 0 ,nil , '' , '' , False, nil , 'This Line,All Lines,Cancel' );
  case msgOption of
    100:
      begin
        GoodsReceipt.Lines.Delete;
        qryPOLines.Close;
        qryPOLines.Open;
      end;
    101:
      begin
        GoodsReceipt.Lines.DeleteAll();
        qryPOLines.Close;
        qryPOLines.Open;
      end;
    102:
      begin
        exit;
      end;
  end;

end;

function TfmGoodsReceipt.IsSNProduct: boolean;
begin
  result := false;
  if qryProduct.Active then begin
    result := qryProduct.FieldByName('SNTracking').AsBoolean;
  end;
end;

procedure TfmGoodsReceipt.LoadPODetails(const aPOID: integer);
var
  aID: integer;
  qry: TERPQuery;
begin
  aID := aPOID;
  if aID = 0 then aID := GoodsReceipt.PurchaseOrderID;
  if aID = 0 then begin
    lblPO.Caption := '';
    lblPO2.Caption := '';
    exit;
  end;
  if qryPOLines.ParamByName('PurchaseOrderID').AsInteger = aID then exit;
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDBLib.GetSharedMyDacConnection;
    qry.SQL.Text := 'select * from tblPurchaseOrders where PurchaseOrderID = ' + IntToStr(aID);
    qry.Open;
    if qry.IsEmpty then begin
      CommonLib.MessageDlgXP_Vista('Purchase Order not found.',mtInformation,[mbOk],0);
      exit;
    end;
    if not qry.FieldByName('IsPo').AsBoolean then begin
      CommonLib.MessageDlgXP_Vista('Purchase Order not found.',mtInformation,[mbOk],0);
      exit;
    end;
    { all good }
    if GoodsReceipt.PurchaseOrderID <> qry.FieldByName('PurchaseOrderID').AsInteger then begin
      GoodsReceipt.New;
      qryGoodsReceiptLines.Close;
      GoodsReceipt.Lines;
      GoodsReceipt.EmployeeID := fEmployeeID;
      GoodsReceipt.PurchaseOrderID := qry.FieldByName('PurchaseOrderID').AsInteger;
      GoodsReceipt.ReceiptStartTime := now;
    end;
    CloseDB(qryPOLines);
    qryPOLines.ParamByName('PurchaseOrderID').AsInteger := qry.FieldByName('PurchaseOrderID').AsInteger;
    OpenDB(qryPOLines);
    CloseDB(qryPOLinesLookup);
    qryPOLinesLookup.ParamByName('PurchaseOrderID').AsInteger := qry.FieldByName('PurchaseOrderID').AsInteger;
    OpenDB(qryPOLinesLookup);
    lblPO.Caption := qry.FieldByName('ClientPrintName').AsString;
    lblPO2.Caption := 'PO ' + IntToStr(aID);
  finally
    qry.Free;
  end;
end;

//function TfmGoodsReceipt.LoadTemplate(const bPrint, bSave, DoClose: boolean;
//  const FileName: string): Boolean;
//begin
//
//end;

procedure TfmGoodsReceipt.PrintGoodsReceipt(const DontAsk: boolean);
var
  sql: string;
  DoPrint: boolean;
begin
  DoPrint := chkAutoPrint.Checked or DontAsk;
  if not DoPrint then begin
    if CommonLib.MessageDlgXP_Vista('Print Goods Receipt?',mtConfirmation,[mbYEs,mbNo],0) = mrYes then
      DoPrint := true;
  end;
  if DoPrint then begin
    sql := '~|||~ where R.ID = ' + IntToStr(GoodsReceipt.ID);
    PrintTemplateReport('Goods Receipt', sql, not(appEnv.Employee.PreviewAllreport) and not(devmode), 1);
  end;
end;

procedure TfmGoodsReceipt.PrintPurchaseOrder;
var
//  qry: TERPQuery;
  POForm: TPurchaseGUI;
begin
  POForm := TPurchaseGUI.Create(nil);
  POForm.KeyId := GoodsReceipt.PurchaseOrderID;
  POForm.FormStyle := fsMDIChild;
  POForm.BringToFront;
  POForm.AccessLevel := 5;
  POForm.chkChooseRpt.Checked := self.chkChooseRpt.Checked;
  POForm.actPrintExecute(POForm.actPrint);
  POForm.Close;
  (*
  ReportToPrint := '';
  if chkChooseRpt.checked = False then begin
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
    try
      qry.SQL.Add('select DefaultPurchaseOrderTemplateID from tblclients C');
      qry.SQL.Add('inner join tblPurchaseOrders PO on PO.ClientID = C.ClientID');
      qry.SQL.Add('where PO.PurchaseOrderID = ' + IntToStr(GoodsReceipt.PurchaseOrderID));
      qry.Open;
      if not qry.IsEmpty then
        ReportToPrint := tcDataUtils.GetTemplate(qry.FieldByName('DefaultPurchaseOrderTemplateID').AsInteger);
    finally
      DbSharedObj.ReleaseObj(qry);
    end;
  end;
  LoadTemplate(not AppEnv.Employee.ShowPreview, false);
  if not Empty(ReportToPrint) then begin
    ReportToPrint := TemplateNameToTemplateClassName(trim(ReportToPrint));
  end
  else begin
    ReportToPrint := tcDataUtils.GetDefaultReport(GetReportTypeID);
  end;
  TransBase.Printdoc.Printdoc(TransBase.ClassName, TransBase.ID, dtmain, Self.Classname ,dotPrint , ReportToPrint);
  TransBase.Dirty:= false;
  ReportToPrint:= '';
  *)
end;

procedure TfmGoodsReceipt.ProcessBarcode(const aCode: string);
var
//  s: string;
  arr: TStringDynArray;
  ID: integer;
  qry: TERPQuery;
begin
//  s := Uppercase(aCode);
  arr := SplitString(aCode, '-');
  if Length(arr) > 1 then begin
    if SameText(arr[0],Barcode_Prefix_Employee) then begin
      if GoodsReceipt.EmployeeID = 0 then begin
        EmployeeID := StrToIntDef(arr[1],0);
        GoodsReceipt.EmployeeID := EmployeeID;
      end
      else begin
        if GoodsReceipt.EmployeeID <> StrToIntDef(arr[1],0) then begin
          if Status = Status_Processed then begin
            CommonLib.MessageDlgXP_Vista('Can not change the Employee as this Goods Receipt has already been Processed.',mtInformation,[mbOk],0);
            exit;
          end;
          if CommonLib.MessageDlgXP_Vista('An Employee has already been selected, change Employee?',mtConfirmation,[mbYes,mbNo],0) = mrYes then begin
            EmployeeID := StrToIntDef(arr[1],0);
            GoodsReceipt.EmployeeID := EmployeeID;
          end;
        end;
      end;
    end
    else if SameText(arr[0],Barcode_Prefix_PurchaseOrder) then begin
      ID := StrToIntDef(arr[1],0);
      if ID = 0 then
        CommonLib.MessageDlgXP_Vista('Invalid Purchase Order Number.',mtInformation,[mbOk],0)
      else
        LoadPODetails(ID);
    end
    else if SameText(arr[0],Barcode_Prefix_PurchaseLine) then begin
      { a purchase line we wish to scan }
      if not CheckEmployee then exit;
      if (not qryPOLines.Active) then begin
        qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
        try
          qry.SQL.Text := 'select * from tblpurchaselines where PurchaseLineID = ' + arr[1];
          qry.Open;
          if not qry.IsEmpty then begin
            LoadPODetails(qry.FieldByName('PurchaseOrderID').AsInteger);
          end
          else begin
            CommonLib.MessageDlgXP_Vista('Purchase Order Number not found for this Purchase Line Number.',mtInformation,[mbOk],0);
            exit;
          end;
        finally
          DbSharedObj.ReleaseObj(qry);
        end;
      end;
      ID := StrToIntDef(arr[1],0);
      if ID  = 0 then begin
        CommonLib.MessageDlgXP_Vista('Invalid Purchase Line Number.',mtInformation,[mbOk],0);
        exit;
      end;
      if not qryPOLines.Locate('PurchaseLineID',ID,[]) then begin
        CommonLib.MessageDlgXP_Vista('Purchase Line Number not found for this Purchase Order.',mtInformation,[mbOk],0);
        exit;
      end;

    end
    else begin
      if not CheckEmployee then exit;

      if self.IsSNProduct then begin
        AddSerialNumber(aCode);
      end;
    end;

  end
  else if SameText(arr[0],'RECEIPT') and (Length(arr) = 2) and SameText(arr[1],'PROCESS') then begin
    CheckComplete(false);
    PrintGoodsReceipt;
  end
  else if SameText(arr[0],'RECEIPT') and (Length(arr) = 2) and SameText(arr[1],'NEW') then begin
    StartNext;
  end
  else begin
    if not CheckEmployee then exit;

    if Status = Status_Started then begin
//      CommonLib.MessageDlgXP_Vista('Please complete this Goods Receipt before scanning a new Purchase Order.',mtInformation,[mbOk],0);
//      exit;
      { is this a Serial Number }
      if self.IsSNProduct then begin
        AddSerialNumber(aCode);
      end
      else begin
        { not a serial number product .. }
        { is it a barcode .. }
        qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
        try
          qry.SQL.Text := 'select * from tblpartbarcodes where Barcode = ' + QuotedStr(arr[0]);
          qry.Open;
          if not qry.IsEmpty then begin
            AddBarcode(qry.FieldByName('PartsID').AsInteger, qry.FieldByName('UnitOfMeasureID').AsInteger);
          end
          else begin
            CommonLib.MessageDlgXP_Vista('Unknown Scan Code.',mtInformation,[mbOk],0);
            exit;
          end;
        finally
          DbSharedObj.ReleaseObj(qry);
        end;
      end;
    end
    else begin
      { assume user has scanned a purchase order number }
      ID := StrToIntDef(aCode,0);
      if ID = 0 then begin
        CommonLib.MessageDlgXP_Vista('Invalid Purchase Order Number.',mtInformation,[mbOk],0);
        exit;
      end;
      LoadPODetails(ID);
    end;
  end;
  UpdateDisplay;
end;

procedure TfmGoodsReceipt.ProcessQty;
var
  POLineID: integer;
begin
  if IsSNProduct then begin
    { do nothing }

  end
  else begin
    if not qryGoodsReceiptLines.Locate('PurchaseLineID',qryPOLinesPurchaseLineID.AsInteger,[]) then begin
      GoodsReceipt.Lines.New;
      GoodsReceipt.Lines.PurchaseLineID := qryPOLines.FieldByName('PurchaseLineID').AsInteger;
    end;
    if edtQty.FloatValue <= (qryPOLines.FieldByName('BackOrder').AsFloat - GoodsReceipt.Lines.QuantityReceived) then begin
      GoodsReceipt.Lines.QuantityReceived := GoodsReceipt.Lines.QuantityReceived + edtQty.FloatValue;
      GoodsReceipt.Lines.PostDB;
      { force refresh .. }
      POLineID := qryPOLinesPurchaseLineID.AsInteger;
      qryPOLines.Refresh;
      if qryPOLinesPurchaseLineID.AsInteger <> POLIneID then
        qryPOLines.Locate('PurchaseLineID', POLineID, []);

    end
    else begin
      CommonLib.MessageDlgXP_Vista('Can not add '+FloatToStr(edtQty.FloatValue)+' to this line, this is more than the outstanding quantity.',mtInformation,[mbOk],0);
    end;
  end;
end;

procedure TfmGoodsReceipt.qryGoodsReceiptLinesCalcFields(DataSet: TDataSet);
begin
  inherited;
  if qryPOLinesLookup.Active and qryPOLinesLookup.Locate('PurchaseLineID',qryGoodsReceiptLinesPurchaseLineID.AsInteger,[]) then
    self.qryGoodsReceiptLinesProductName.AsString := qryPOLinesLookup.FieldByName('ProductPrintName').AsString;
end;

procedure TfmGoodsReceipt.qryPOLinesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  SelectLine;
end;

procedure TfmGoodsReceipt.qryPOLinesCalcFields(DataSet: TDataSet);
var
  bm: TBookmark;
  qty: double;
begin
  inherited;
  qty := 0;
  qryGoodsReceiptLines.DisableControls;
  try
    bm := qryGoodsReceiptLines.GetBookmark;
    try
      qryGoodsReceiptLines.First;
      while not qryGoodsReceiptLines.EOF  do begin
        if qryGoodsReceiptLinesPurchaseLineID.AsInteger = qryPOLinesPurchaseLineID.AsInteger then
          qty := qty + qryGoodsReceiptLinesQuantityReceived.AsFloat;

        qryGoodsReceiptLines.Next;
      end;
      qryGoodsReceiptLines.GotoBookmark(bm);
    finally
      qryGoodsReceiptLines.FreeBookmark(bm);
    end;
  finally
    qryGoodsReceiptLines.EnableControls;
  end;
  qryPOLinesReceiptQty.AsFloat := qty;
  qryPOLinesQtyOutstanding.AsFloat := qryPOLinesUnitofMeasureBackorder.AsFloat - qty;
end;

procedure TfmGoodsReceipt.qryPOLinesLookupBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryPOLinesLookup.ParamByName('PurchaseOrderID').AsInteger := GoodsReceipt.PurchaseOrderID;
end;

function TfmGoodsReceipt.SaveData: boolean;
begin
  result := false;
  if not CheckComplete(false) then exit;
  if GoodsReceipt.Save then begin
    GoodsReceipt.Connection.CommitTransaction;
    GoodsReceipt.Connection.BeginTransaction;
    self.PrintGoodsReceipt;
  end
  else
    exit;
  GoodsReceipt.Dirty := false;
  result := true;
end;

procedure TfmGoodsReceipt.SelectLine;
begin
  if qryPOLines.IsEmpty then begin
    imgProduct.Picture:= nil;
    exit;
  end;

  lblLastProduct.Caption := qryPOLines.FieldByName('ProductPrintName').AsString;
  CloseDB(qryProduct);
  qryProduct.ParamByName('ProductID').AsInteger := qryPOLines.FieldByName('ProductId').AsInteger;
  OpenDB(qryProduct);
  if qryProduct.FieldByName('PartPic').IsNull then begin
    imgProduct.Picture:= nil;
  end
  else begin
    ImagesLib.RefreshDsImage(qryProduct,'PartPic','PicType',imgProduct,nil,nil);

  end;
end;

procedure TfmGoodsReceipt.SetEmployeeID(const Value: integer);
begin
  fEmployeeID := Value;
  fEmployeeName := TEmployee.IDToggle(Value);
  lblEmployeeName.Caption := fEmployeeName;
end;

procedure TfmGoodsReceipt.StartNew;
begin
  GoodsReceipt.Load(0);
  qryGoodsReceiptLines.Close;
  GoodsReceipt.New;
  GoodsReceipt.Lines;
  CloseDB(qryPOLines);
  qryPOLines.ParamByName('PurchaseOrderID').AsInteger := 0;
  OpenDB(qryPOLines);
  CloseDB(qryPOLinesLookup);
  qryPOLinesLookup.ParamByName('PurchaseOrderID').AsInteger := 0;
  OpenDB(qryPOLinesLookup);
  SelectLine;
  UpdateDisplay;
end;

procedure TfmGoodsReceipt.StartNext;
begin
  if not CheckComplete then exit;
  self.PrintGoodsReceipt;
  StartNew;
end;

function TfmGoodsReceipt.TotalReceivedForPOLine(
  const POLineID: integer): double;
var
  bm: TBookmark;
begin
  result := 0;
  if GoodsReceipt.Lines.Count = 0 then exit;

  bm := GoodsReceipt.Lines.Dataset.GetBookmark;
  try
    qryGoodsReceiptLines.DisableControls;
    try
      GoodsReceipt.Lines.First;
      while not GoodsReceipt.Lines.EOF do begin
        if GoodsReceipt.Lines.PurchaseLineID = POLineID then
          result := result + GoodsReceipt.Lines.QuantityReceived;
        GoodsReceipt.Lines.Next;
      end;

      GoodsReceipt.Lines.Dataset.GotoBookmark(bm);
    finally
      qryGoodsReceiptLines.EnableControls;
    end;

  finally
    GoodsReceipt.Lines.Dataset.FreeBookmark(bm);
  end;
end;

procedure TfmGoodsReceipt.UpdateDisplay;
begin
  lblStatus.Caption := Status;

  lblEmployeeName.Caption := fEmployeeName;
  //lblPO.Caption := '';
  //lblPO2.Caption := '';
  LoadPODetails;
//  lblCountSummary.Caption := '';
  if GoodsReceipt.ReceiptStartTime > 0 then
    lblReceiptStart.Caption := FormatDateTime(FormatSettings.ShortDateFormat, GoodsReceipt.ReceiptStartTime)
  else
    lblReceiptStart.Caption := '';

  if GoodsReceipt.ReceiptEndTime > 0 then
    lblReceiptFinish.Caption := FormatDateTime(FormatSettings.ShortDateFormat, GoodsReceipt.ReceiptEndTime)
  else
    lblReceiptFinish.Caption := '';

//  lblLAstProduct.Caption := '';
end;

initialization
  RegisterClass(TfmGoodsReceipt);

  with FormFact do begin
    RegisterMe(TfmGoodsReceipt, 'TGoodsReceiptListGUI_*=ReceiptId');
  end;
end.
