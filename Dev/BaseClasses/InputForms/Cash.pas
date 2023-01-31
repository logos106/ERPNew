{ TODO : Add foreign Currency }
unit Cash;


{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 22/04/05  1.00.01 IJB  Added Barcode entry of products.
 14/06/05  1.01.03 BJ   Added code to consider the customer's special price if
                        any available for the selected cutomer and product.
 08/07/05  1.01.04 BJ   Serial form invoked using the SerialNoObj for both
                        Refund and CashSale as both of them are inherited from here
 12/08/05  1.00.05 BJ   Serialno object inroduced. Serialno field type is changed to
                        MediumText
 16/11/05  1.00.07 DSP  Added check for [Alt] key not being down before
                        displaying the barcode form.
 04/12/06  1.00.08 AL   comented Sender.ClassName <> Self.Class name in FilterExit,
                        becouse it does not make a sense and creates access violations
 04/01/06  1.00.09 AL   Added new Search mode (like)
 10/01/06  1.00.10 AL   Changed Search engine to use SearchEngineObj
 15/02/06  1.00.11 DSP  Added UpdateSelectedProp to FormCreate.
 04/04/06  1.00.12 AL   Changed UpdateRelatedParts,
                        1 chaged QtySold to QtyShipped,
                          because fist of all QtyShipped is changed in the grid of CashSale
                        2 added RefundQty as RefundQty is changed in Qty column in Refund grid
 12/04/06  1.00.13 DSP  Removed references to tblAdvMatrix and associated code.
 29/05/06  1.00.14 BJ   chkDisableCalcs is made invisible in the template and is no more applciable
                        the calculations are done always.
 15/08/06  1.00.15 BJ   CheckMatrixItems: check for the accesslevel when editing the tbldetails
 18/09/06  1.00.16 BJ   Business object created for Cashsale and REfund. Dataset related code is
                        moved into the object unit.

}

interface

uses
  Windows, DateUtils, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseTransForm,  DB, wwdbdatetimepicker, wwdblook, StdCtrls, DBCtrls,
  Mask, ExtCtrls, wwcheckbox, Buttons, DNMSpeedButton, DNMPanel, Wwdbigrd, Grids,
  Wwdbgrid, ActnList, Menus, AdvMenus, ClientDiscountObj, BatchObj, ImgList,
  SelectionDialog, AppEvnts, ReceiptPrinterObj, wwdbedit, MyAccess,ERPdbComponents, MemDS, BaseInputForm,
  DBAccess, DataState, BusObjBase, BusobjCash,
  CustomfieldonGrid,Shader, ProgressDialog, Commonlib, ERPDbLookupCombo, DNMAction, types;

const
  //SX_CalcTotalsMsg      = WM_USER + 100;
  SX_RequestComboRedrop = WM_USER + 102;

(*
type
  pRelatedRec = ^TRelatedRec;
  TRelatedRec = record
    ParentLineID: integer;
    LineID: integer;
    Multiplier: double;
  end;*)

type
  TBaseCashGUI = class(TBaseTransGUI)
    cboClass: TwwDBLookupCombo;
    ClassLabel: TLabel;
    txtPONumber: TDBEdit;
    Label43: TLabel;
    cboAccount: TwwDBLookupCombo;
    lblAccount: TLabel;
    qryPayMethod: TERPQuery;
    Label122: TLabel;
    txtTotalDiscount: TDBEdit;
    txtTotalMarkup: TDBEdit;
    cboPaymentMethod: TwwDBLookupCombo;
    lblPaymentMethod: TLabel;
    tblDetailsSaleLineID: TAutoIncField;
    tblDetailsGlobalRef: TWideStringField;
    tblDetailsSaleID: TIntegerField;
    tblDetailsProductID: TIntegerField;
    tblDetailsProductGroup: TWideStringField;
    tblDetailsProductName: TWideStringField;
    tblDetailsProduct_Description: TWideStringField;
    tblDetailsPartType: TWideStringField;
    tblDetailsIncomeAccnt: TWideStringField;
    tblDetailsAssetAccnt: TWideStringField;
    tblDetailsCogsAccnt: TWideStringField;
    tblDetailsLinePrice: TFloatField;
    tblDetailsLinePriceInc: TFloatField;
    tblDetailsDiscountedPrice: TFloatField;
    tblDetailsDiscountedPriceInc: TFloatField;
    tblDetailsTotalDiscountedPrice: TFloatField;
    tblDetailsTotalDiscountedPriceInc: TFloatField;
    tblDetailsLineWholesalePrice: TFloatField;
    tblDetailsLineTaxRate: TFloatField;
    tblDetailsLineCost: TFloatField;
    tblDetailsLineCostInc: TFloatField;
    tblDetailsLineTaxCode: TWideStringField;
    tblDetailsLineTax: TFloatField;
    tblDetailsQtySold: TFloatField;
    tblDetailsShipped: TFloatField;
    tblDetailsBackOrder: TFloatField;
    tblDetailsInvoiced: TWideStringField;
    tblDetailsDiscounts: TFloatField;
    tblDetailsMarkup: TFloatField;
    tbldetailsMargin: TFloatField;
    tblDetailsTotalLineAmount: TFloatField;
    tblDetailsTotalLineAmountInc: TFloatField;
    tblDetailsEditedFlag: TWideStringField;
    tblDetailsDeleted: TWideStringField;
    tblDetailsRefundQty: TFloatField;
    tblDetailsLaybyID: TWideStringField;
    tblMasterSaleID: TAutoIncField;
    tblMasterGlobalRef: TWideStringField;
    tblMasterInvoiceDocNumber: TWideStringField;
    tblMasterOriginalNo: TWideStringField;
    tblMasterAccount: TWideStringField;
    tblMasterAccountID: TIntegerField;
    tblMasterBOID: TWideStringField;
    tblMasterCustomerName: TWideStringField;
    tblMasterClientID: TIntegerField;
    tblMasterInvoiceTo: TWideStringField;
    tblMasterShipTo: TWideStringField;
    tblMasterSaleDate: TDateField;
    tblMasterTotalTax: TFloatField;
    tblMasterTotalAmount: TFloatField;
    tblMasterTotalAmountInc: TFloatField;
    tblMasterTotalMarkup: TFloatField;
    tblMasterTotalDiscount: TFloatField;
    tblMasterEmployeeName: TWideStringField;
    tblMasterClassID: TIntegerField;
    tblMasterEmployeeID: TIntegerField;
    tblMasterClass: TWideStringField;
    tblMasterOrderNumber: TWideStringField;
    tblMasterPONumber: TWideStringField;
    tblMasterChequeNo: TWideStringField;
    tblMasterShipDate: TDateField;
    tblMasterDueDate: TDateField;
    tblMasterConNote: TWideStringField;
    tblMasterInvoicePrintDesc: TWideStringField;
    tblMasterPickMemo: TWideMemoField;
    tblMasterPrintHold: TWideStringField;
    tblMasterShipping: TWideStringField;
    tblMasterTerms: TWideStringField;
    tblMasterPayMethod: TWideStringField;
    tblMasterPayDueDate: TWideStringField;
    tblMasterPaid: TWideStringField;
    tblMasterBalance: TFloatField;
    tblMasterPayment: TFloatField;
    tblMasterApplyFlag: TWideStringField;
    tblMasterAmountDue: TFloatField;
    tblMasterTimeOfSale: TWideStringField;
    tblMasterPOS: TWideStringField;
    tblMasterIsRefund: TWideStringField;
    tblMasterIsCashSale: TWideStringField;
    tblMasterIsInvoice: TWideStringField;
    tblMasterIsQuote: TWideStringField;
    tblMasterIsSalesOrder: TWideStringField;
    tblMasterIsLayby: TWideStringField;
    tblMasterDeleted: TWideStringField;
    tblMasterEditedFlag: TWideStringField;
    tblMasterTotalQuoteAmount: TFloatField;
    tblMasterLaybyID: TWideStringField;
    tblDetailsCalcPriceInc: TCurrencyField;
    tblDetailsCalcTotalInc: TCurrencyField;
    tblDetailsCalcTotalEx: TCurrencyField;
    tblDetailsCalcTax: TCurrencyField;
    tblDetailsCalcBackOrder: TCurrencyField;
    tblDetailsOrgLinePrice: TFloatField;
    tblDetailsMarkupPercent: TFloatField;
    tbldetailsMarginPercent: TFloatField;
    tblDetailsDiscountPercent: TFloatField;
    tblDetailsCalcLinePriceEx: TCurrencyField;
    tblMasterMemo: TWideMemoField;
    tblMasterComments: TWideMemoField;
    qryPayments: TERPQuery;
    qryPaymentsPayMethod: TWideStringField;
    qryPaymentsRef: TWideStringField;
    qryPaymentsAmount: TFloatField;
    qryPaymentsSaleID: TIntegerField;
    btnSplit: TDNMSpeedButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    actSplitPay: TAction;
    chkInvoice: TCheckBox;
    lblInvoice: TLabel;
    Label3: TLabel;
    tblMasterEnteredBy: TWideStringField;
    tblMasterEnteredAt: TWideStringField;
    tblDetailsCalcTotalIncB4Discount: TCurrencyField;
    qryPaymentsPaymentID: TAutoIncField;
    qryPaymentsEditedFlag: TWideStringField;
    tblDetailsAttrib1Sale: TFloatField;
    tblDetailsAttrib2Sale: TFloatField;
    tblDetailsAttrib1SaleRate: TFloatField;
    tblDetailsLastLineID: TIntegerField;
    tblDetailsUnitofMeasureQtySold: TFloatField;
    tblDetailsUnitofMeasureShipped: TFloatField;
    tblDetailsUnitofMeasureBackorder: TFloatField;
    tblDetailsUnitofMeasureMultiplier: TFloatField;
    tblMasterSOBalance: TFloatField;
    tblMasterIsPOS: TWideStringField;
    tblMasterIsVoucher: TWideStringField;
    tblMasterIsLaybyTOS: TWideStringField;
    tblMasterIsLaybyPayment: TWideStringField;
    tblMasterDeposited: TWideStringField;
    tblMasterTillID: TSmallintField;
    tblMasterHoldSale: TWideStringField;
    tblMasterFreezeQuoteAmount: TWideStringField;
    tblMasterConverted: TWideStringField;
    tblMasterCommissionPaid: TWideStringField;
    qryUnitOfMeasure: TERPQuery;
    qryUnitOfMeasureUnitName: TWideStringField;
    qryUnitOfMeasureUnitDescription: TWideStringField;
    qryUnitOfMeasureMultiplier: TFloatField;
    cboUnitOfMeasure: TwwDBLookupCombo;
    tblDetailsUnitofMeasureSaleLines: TWideStringField;
    tblMasterPickupFrom: TWideStringField;
    tblMasterIsManifest: TWideStringField;
    tblMasterUsedOnManifest: TWideStringField;
    tblMasterAddToManifest: TWideStringField;
    tblMasterQuoteGlobalRef: TWideStringField;
    tblMasterSalesOrderGlobalRef: TWideStringField;
    tblDetailsSupplierContact: TWideStringField;
    tblMasterIsBarcodePicking: TWideStringField;
    tblMasterBarcodePickingDone: TWideStringField;
    tblMasterARNotes: TWideMemoField;
    cboTermsQry: TERPQuery;
    cboTermsQryTermsAmount: TSmallintField;
    cboTermsQryTerms: TWideStringField;
    cboTermsQryTermsID: TAutoIncField;
    cboTermsQryEOM: TWideStringField;
    cboTermsQryEOMPlus: TWideStringField;
    cboTermsQryActive: TWideStringField;
    Label79: TLabel;
    cboTerms: TwwDBLookupCombo;
    Label45: TLabel;
    cboDueDate: TwwDBDateTimePicker;
    btnCashDrawer: TDNMSpeedButton;
    tblMasterOriginalCreationDate: TDateField;
    tblMasterQuoteStatus: TWideStringField;
    tblDetailsArea: TWideStringField;
    txtSearchFilter: TwwDBEdit;
    tblDetailsSearchFilter: TWideStringField;
    tblDetailsSearchFilterCopy: TWideStringField;
    tblDetailsIsRelatedProduct: TWideStringField;
    cboProductQry: TERPQuery;
    cboAccountQry: TERPQuery;
    DSPayments: TDataSource;
    cboProductQryDept: TWideStringField;
    cboProductQryType: TWideStringField;
    cboProductQryManuf: TWideStringField;
    cboProductQryPARTSID: TIntegerField;
    cboProductQryPARTTYPE: TWideStringField;
    cboProductQryPRODUCTGROUP: TWideStringField;
    cboProductQryPARTNAME: TWideStringField;
    cboProductQryINCOMEACCNT: TWideStringField;
    cboProductQryASSETACCNT: TWideStringField;
    cboProductQryCOGSACCNT: TWideStringField;
    cboProductQryBARCODE: TWideStringField;
    cboProductQryPRODUCTCODE: TWideStringField;
    cboProductQryTAXCODE: TWideStringField;
    cboProductQryBatch: TWideStringField;
    cboProductQryAutoBatch: TWideStringField;
    cboProductQryMultipleBins: TWideStringField;
    cboProductQrySpecialDiscount: TWideStringField;
    cboProductQrySNTracking: TWideStringField;
    cboProductQryBuyQTY1: TIntegerField;
    cboProductQryBuyQTY2: TIntegerField;
    cboProductQryBuyQTY3: TIntegerField;
    cboProductQryCOST1: TFloatField;
    cboProductQryCOST2: TFloatField;
    cboProductQryCOST3: TFloatField;
    cboProductQrySellQTY1: TIntegerField;
    cboProductQrySellQTY2: TIntegerField;
    cboProductQrySellQTY3: TIntegerField;
    cboProductQryPRICE1: TFloatField;
    cboProductQryPRICE2: TFloatField;
    cboProductQryPRICE3: TFloatField;
    cboProductQryWHOLESALEPRICE: TFloatField;
    cboProductQryActive: TWideStringField;
    cboProductQryEditedFlag: TWideStringField;
    cboProductQryAvgCost: TFloatField;
    cboProductQryDiscontinued: TWideStringField;
    tblDetailsRelatedParentProductID: TIntegerField;
    tblDetailsLatestCostPrice: TFloatField;
    tblDetailsLatestCostPriceInc: TFloatField;
    tblDetailsCalcGrossProfitPercentInc: TFloatField;
    cboProductQryLatestCost: TFloatField;
    tblMasterTotalWETTax: TFloatField;
    tblMasterTotalWEGTax: TFloatField;
    tblMasterLastUpdated: TDateTimeField;
    tblDetailsSoldSerials: TWideMemoField;
    tblDetailsUnitOfMeasureID: TIntegerField;
    tblDetailsSortId: TIntegerField;
    tblDetailsLinesOrder: TIntegerField;
    tblDetailsSeqNo: TIntegerField;
    tblDetailsRelatedParentLineRef: TWideStringField;
    tblDetailsCustomData: TWideMemoField;
    tblDetailsLastUpdated: TDateTimeField;
    tblDetailsForeignTotalLineAmount: TFloatField;
    tblMasterForeignExchangeCode: TWideStringField;
    tblMasterForeignExchangeRate: TFloatField;
    tblMasterForeignTotalAmount: TFloatField;
    tblMasterForeignPaidAmount: TFloatField;
    tblMasterForeignBalanceAmount: TFloatField;
    qryPaymentsGlobalRef: TWideStringField;
    qryPaymentsDeleted: TWideStringField;
    tblMasterBaseNo: TWideStringField;
    tblDetailsRelatedProductQty: TFloatField;
    tblDetailsIsFormulaRElatedProduct: TWideStringField;
    tblDetailsFormulaID: TIntegerField;
    qryUnitOfMeasureUnitID: TIntegerField;
    btnDeposit: TDNMSpeedButton;
    tblDetailsPQA: TWideStringField;
    tblmastercontactID: TLargeintField ;
    tblMasterContactName:TWideStringField;
    cboProductR: TERPDbLookupCombo;
    tblDetailsPartBarcode: TWideStringField;
    tblDetailsMatrixDesc: TWideMemoField;
    tblDetailsMatrixRef: TWideMemoField;
    tblDetailsMatrixPrice: TFloatField;
    lblEnteredAtHead: TLabel;
    lblEnteredAt: TDBText;
    checkDiscount1: TMenuItem;
    actcheckdiscount: TDNMAction;
    Label4: TLabel;
    wwDBDateTimePicker1: TwwDBDateTimePicker;
    tblDetailsFormulaQtySoldValue1: TFloatField;
    tblDetailsFormulaQtySoldValue2: TFloatField;
    tblDetailsFormulaQtySoldValue3: TFloatField;
    tblDetailsFormulaQtySoldValue4: TFloatField;
    tblDetailsFormulaQtySoldValue5: TFloatField;
    tblDetailsFormulaQtyShippedValue1: TFloatField;
    tblDetailsFormulaQtyShippedValue2: TFloatField;
    tblDetailsFormulaQtyShippedValue3: TFloatField;
    tblDetailsFormulaQtyShippedValue4: TFloatField;
    tblDetailsFormulaQtyShippedValue5: TFloatField;
    tblDetailsFormulaQtySoldValue: TFloatField;
    tblDetailsFormulaQtyShippedValue: TFloatField;
    tblDetailsISVoucher: TWideStringField;
    tblDetailsVoucherNo: TWideStringField;
    tblDetailsISContainer: TWideStringField;
    tblDetailsIsPallet: TWideStringField;
    tblMasterEnteredAtShort: TStringField;
    cboProductQrySupplierProductCode: TWideStringField;
    tblDetailsAreaQty: TFloatField;
    qryPayMethodPayMethodID: TIntegerField;
    qryPayMethodName: TWideStringField;
    qryPayMethodIsCreditCard: TWideStringField;
    cboProductQryPARTSDESCRIPTION: TWideStringField;
    tblDetailsProductPrintName: TWideStringField;
    tblMasterClientPrintName: TWideStringField;
    cboPrintProductR: TERPDbLookupCombo;
    tblDetailsUOMQtyInStock: TFloatField;
    tblDetailsUOMQtyAvailable: TFloatField;
    tblDetailsSalesTaxBasedon: TWideStringField;
    tblMasterSaleCustField1: TWideStringField;
    tblMasterSaleCustField2: TWideStringField;
    tblMasterSaleCustField3: TWideStringField;
    tblMasterSaleCustField4: TWideStringField;
    tblMasterSaleCustField5: TWideStringField;
    tblMasterSaleCustField6: TWideStringField;
    tblMasterSaleCustField7: TWideStringField;
    tblMasterSaleCustField8: TWideStringField;
    tblMasterSaleCustField9: TWideStringField;
    tblMasterSaleCustField10: TWideStringField;
    tblDetailsSalesLinesCustField1: TWideStringField;
    tblDetailsSalesLinesCustField2: TWideStringField;
    tblDetailsSalesLinesCustField3: TWideStringField;
    tblDetailsSalesLinesCustField4: TWideStringField;
    tblDetailsSalesLinesCustField5: TWideStringField;
    tblDetailsSalesLinesCustField6: TWideStringField;
    tblDetailsSalesLinesCustField7: TWideStringField;
    tblDetailsSalesLinesCustField8: TWideStringField;
    tblDetailsSalesLinesCustField9: TWideStringField;
    tblDetailsSalesLinesCustField10: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdPaymentsExit(Sender: TObject);
    procedure cboEmployeeNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure actSplitPayExecute(Sender: TObject);
    procedure actSplitPayUpdate(Sender: TObject);
    procedure cboPaymentMethodChange(Sender: TObject);
    procedure grdTransactionsEnter(Sender: TObject);
    procedure grdTransactionsRowChanged(Sender: TObject);
    procedure btnCashDrawerClick(Sender: TObject);
    procedure grdTransactionsCalcTitleAttributes(Sender: TObject; const AFieldName: string;
      const AFont: TFont; const ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure grdTransactionsTitleButtonClick(Sender: TObject; AFieldName: string);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure grdTransactionsExit(Sender: TObject);
    procedure cboProductRChange(Sender: TObject);
    procedure cboProductRKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cboProductRNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: String; var Accept: Boolean);
    procedure tblDetailsCalcFields(DataSet: TDataSet);
    procedure cboProductQryAfterOpen(DataSet: TDataSet);
    (*procedure cboBarcodeNotInList(Sender: TObject; LookupTable: TDataSet;
      NewValue: String; var Accept: Boolean);*)
    procedure cboUnitOfMeasureDropDown(Sender: TObject);
    procedure cboTaxCodeDropDown(Sender: TObject);
    procedure grdTransactionsDblClick(Sender: TObject);
    procedure grdTransactionsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actcheckdiscountUpdate(Sender: TObject);
    procedure actcheckdiscountExecute(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure cboUnitOfMeasureCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
    procedure qryUnitOfMeasureBeforeOpen(DataSet: TDataSet);
    procedure tblMasterCalcFields(DataSet: TDataSet);
    procedure grdTransactionsColEnter(Sender: TObject);
    procedure cboProductRAfterchange(Sender: TObject);

  private
    { Private declarations }
    ClientDiscountObj: TClientDiscountObj;
    BatchObj: TBatchObj;
    bIsCalcStarted: boolean;
    oRcptPrn: TReceiptPrinter;
    barCodeCreated:Boolean;
    Newbarcode:String;
    fbAutoSplitQty:Boolean;
    fbCalcQtyForAre:Boolean;
    fProductLookupSQL:string;
    fLockLineFields: boolean;
    fISSalesLineLocked: Boolean;

    procedure PerformComboRedrop(var Msg: TMessage); message SX_RequestComboRedrop;
    procedure CreateReceiptPrinter;

    procedure SetComboFocus(var Msg: TMessage); message TX_SetFocus;
    procedure RefreshUnitsQry;
    Procedure ApplyPreferences;
    procedure SetMatrixDetails(sMatrixDesc, sMatrixRef: String;dMatrixPrice: double);
    procedure ShowPriceCalc;
    procedure AddDynamicMenuItems;
    procedure ProductPricesClick(Sender: TObject);
    procedure CustomFields1Click(Sender: TObject);
    procedure mnuSaleCustomFieldsClick(Sender: TObject);
    procedure BeforeShowSaleCustomFieldList(Sender: TObject);
    procedure beforeshowCustomfieldList(Sender: TObject);
    procedure InitSalesAutoSplitQty(Sender: TObject);
    procedure ApplyAutoSplitQty(Sender: TObject);
    procedure DoAutoSplitQty;
    procedure SetLockLineFields(const Value: boolean);
    procedure ShowAccountCbo(const Value: Boolean);
    procedure CheckForSalesTaxBasedon(const aISSalesLocked: Boolean);


  protected
    CashBase: TCashBase;
    fLockSalesInitialized:boolean;
    fSalesLocked:boolean;
    CustomfieldonGrid: TCustomFieldonGrid;
    procedure CompleteComboNotInList(const aObserver: TObject); override;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string); override;
    function getcontactType:  TContactType; override;
    Procedure DoOnProductchange;Override;
    //procedure UpdateFromContact(const Value: TDataSet); override;
    function IssalesLocked: Boolean;Virtual;
    procedure Locksales;Virtual;
//    Procedure LockLinefieldsonAccessLevel(const DoLock:Boolean);
    property LockLineFields: boolean read fLockLineFields write SetLockLineFields;
    procedure TranslockComponents(var lockComponents: TStringDynArray);Override;
    function ShowNoCustomerWarning : boolean;
    function GetOrAddMobileNumber: string;
    procedure PopulateMessageSubstituteList(SL: TStringList); override;
    procedure NewTransBusObjinstance;override;
    function TransStatustype:String ;override;
    function ClientState:String; Override;
    function Clientcountry:String; Override;
    function clientLocation:String; Override;
    function ClientPostcode:String; Override;
    Procedure InitERPLookupCombonFields; Override;
    function DisfieldstoRemove: String;Override;
    procedure ShowFormulafields;Override;
    procedure ApplyCustomFieldsSettings;
    //procedure AddProductOptionsProduct(const OldProductId, newProductID:Integer);

  public
    { Public declarations }
    fbUpdateNow: boolean;
    fbDontRefreshCalcs: boolean;
    fbSkipInherit: boolean;
    procedure UpdateMe(const Cancelled: boolean; const aObject: TObject = nil); override;
  end;

implementation

uses
    DNMExceptions,
  frmCashPay,   DNMLib,
  frmProductQtyBinGUI, frmPartsFrm,
  (*frmBarcodePopUp,*)
  BusObjConst, tcDataUtils, AppEnvironment, FastFuncs,
  tcTypes, StrUtils, ProductListExpressForm, BusObjStock,
  frmpartsPriceMatrixInput, PartsPriceMatrixLib, frmproductPrices, CommonDbLib,
  BusObjContact, BusObjClient, frmMobileNumberInput, SMSUtils, BusobjSalesQtySplit , frmSalesAutoSplitQty, CommonFormLib, tcconst,
  frmDelayMessageDlg, EmployeeAccesses, BusObjTrans, saleslib , frmCustomfieldList,
  Busobjcustomfields;

{$R *.dfm}

function TBaseCashGUI.IssalesLocked: Boolean;
begin
  Result := accessLevel>3;
end;
procedure TBaseCashGUI.Locksales;
var
  intX: Integer;
  ctr:Integer;
begin
  if fLockSalesInitialized and (fSalesLocked = IssalesLocked) then Exit;
  fLockSalesInitialized := true;
  fSalesLocked := IssalesLocked;
  if fSalesLocked then begin
    AccessLevel := 5;
    Exit;
  end;

  for intX := 0 to Self.ComponentCount - 1 do begin

    if Self.Components[intX] is TwwDBDateTimePicker then TwwDBDateTimePicker(Self.Components[intX]).Readonly := fSalesLocked
    else if Self.Components[intX] is TwwDBLookupCombo then TwwDBLookupCombo(Self.Components[intX]).Readonly := fSalesLocked
    else if Self.Components[intX] is TDBMemo then TDBMemo(Self.Components[intX]).Readonly := fSalesLocked
    else if Self.Components[intX] is TDBEdit then TDBEdit(Self.Components[intX]).Readonly := fSalesLocked
    else if Self.Components[intX] is TEdit then TEdit(Self.Components[intX]).Readonly := fSalesLocked
    else if Self.Components[intX] is twwIButton then twwIButton(Self.Components[intX]).Enabled := not(fSalesLocked);
    if Self.Components[intX] is TwwDbGrid then
      if not fSalesLocked then begin
        if not(dgEditing in grdTransactions.Options) then TwwDbGrid(Self.Components[intX]).Options := TwwDbGrid(Self.Components[intX]).Options + [dgEditing]
      end
      else if fSalesLocked then
        if dgEditing in grdTransactions.Options then TwwDbGrid(Self.Components[intX]).Options := TwwDbGrid(Self.Components[intX]).Options - [dgEditing];
  end;
  fISSalesLineLocked:= False;
  for ctr:= 0 to tbldetails.Fields.Count-1 do
    try
      Readonlyfield(tbldetails.Fields[ctr].fieldname           , fISSalesLineLocked);
    Except
      // kill exception if the column doesn't exists
    end;
  if not fSalesLocked then begin
    if KeyId <> 0 then begin
      fISSalesLineLocked := IstransLineLocked or (AccessLevel>3) ;
      tblDetailsUnitofMeasureShipped.Readonly := fISSalesLineLocked;
      tblDetailsUnitofMeasureQtySold.Readonly := fISSalesLineLocked;
      fISSalesLineLocked := IstransLineLocked;
      tblDetailsUnitofMeasureSaleLines.Readonly := fISSalesLineLocked;
      tblDetailsProductName.Readonly := fISSalesLineLocked;
      tblDetailsProductID.Readonly := fISSalesLineLocked;
      tbldetailsVoucherNo.Readonly := fISSalesLineLocked;
      tbldetailstotallineAmountinc.Readonly := fISSalesLineLocked;
      tbldetailstotallineamount.Readonly := fISSalesLineLocked;
      tbldetailslineprice.Readonly := fISSalesLineLocked;
      tbldetailslinepriceinc.Readonly := fISSalesLineLocked;
      tbldetailsproductname.Readonly := fISSalesLineLocked;
      tbldetailslinetax.Readonly := fISSalesLineLocked;
    end;
  end;
//  LockLinefieldsonAccessLevel(true);
  LockLineFields := true;

  ApplyTransAccesslevel(fSalesLocked , fISSalesLineLocked);
  grdtransactions.ColumnByName(tblDetailsLinesOrder.FieldName).ReadOnly := true;

  if not (Appenv.companyprefs.CostEditableinSales) then begin
    grdtransactions.ColumnByName(tblDetailsLinecost.FieldName).ReadOnly := true;
    grdtransactions.ColumnByName(tblDetailsLinecostInc.FieldName).ReadOnly := true;
  end;

  CheckForSalesTaxBasedon( (fISSalesLineLocked) or (fSalesLocked) );

  { total fields are always readonly as they are calculated and displayed }
  txtSubTotal.Readonly := true;
  txtTotalTax.Readonly := true;
  txtTotalAmount.Readonly := true;
end;
procedure TBaseCashGUI.CheckForSalesTaxBasedon(Const  aISSalesLocked:Boolean);
begin
  saleslib.CheckForSalesTaxBasedon(Self, aISSalesLocked,cashbase);
  (*if (cashbase.Lines.ProductId>0) then begin
    if not(aISSalesLocked) then begin
      if cashbase.Lines.SalesTaxBasedonProductPrice then begin
        grdtransactions.ColumnByName(tblDetailsLinePrice.FieldName).ReadOnly := true;
        grdtransactions.ColumnByName(tblDetailsLinePriceInc.FieldName).ReadOnly := true;

        grdtransactions.ColumnByName(tblDetailsDiscountedPrice.FieldName).ReadOnly := False;
        grdtransactions.ColumnByName(tblDetailsDiscountedPriceInc.FieldName).ReadOnly := False;


        grdtransactions.ColumnByName(tblDetailsTotalLineamount.FieldName).ReadOnly := true;
        grdtransactions.ColumnByName(tblDetailsTotalLineamountInc.FieldName).ReadOnly := true;

        grdtransactions.ColumnByName(tblDetailsTotalDiscountedPrice.FieldName).ReadOnly := False;
        grdtransactions.ColumnByName(tblDetailsTotalDiscountedPriceInc.FieldName).ReadOnly := False;

        if tblDetailsLinePrice.visible then begin
            if not tblDetailsDiscountedPrice.visible then tblDetailsDiscountedPrice.index := tblDetailsLinePrice.index+1;
            grdTransactions.AddField(tblDetailsDiscountedPrice.FieldName);
            guiprefs.DbGridElement[grdTransactions].UnHideField(tblDetailsDiscountedPrice.FieldName);

            if not tblDetailsTotalDiscountedPrice.visible then tblDetailsTotalDiscountedPrice.index := tblDetailsLinePrice.index+1;
            grdTransactions.AddField(tblDetailsTotalDiscountedPrice.FieldName);
            guiprefs.DbGridElement[grdTransactions].UnHideField(tblDetailsTotalDiscountedPrice.FieldName);

        end;

        if tblDetailsLinePriceinc.visible then begin
            if not tblDetailsDiscountedPriceinc.visible then tblDetailsDiscountedPriceinc.index := tblDetailsLinePriceinc.index+1;
            grdTransactions.AddField(tblDetailsDiscountedPriceinc.FieldName);
            guiprefs.DbGridElement[grdTransactions].UnHideField(tblDetailsDiscountedPriceinc.FieldName);

            if not tblDetailsTotalDiscountedPriceinc.visible then tblDetailsTotalDiscountedPriceinc.index := tblDetailsLinePriceinc.index+1;
            grdTransactions.AddField(tblDetailsTotalDiscountedPriceinc.FieldName);
            guiprefs.DbGridElement[grdTransactions].UnHideField(tblDetailsTotalDiscountedPriceinc.FieldName);

        end;
      end else begin
        grdtransactions.ColumnByName(tblDetailsLinePrice.FieldName).ReadOnly := False;
        grdtransactions.ColumnByName(tblDetailsLinePriceInc.FieldName).ReadOnly := False;
        grdtransactions.ColumnByName(tblDetailsTotalLineamount.FieldName).ReadOnly := False;
        grdtransactions.ColumnByName(tblDetailsTotalLineamountInc.FieldName).ReadOnly := False;
      end;
    end;
  end;*)
end;
//procedure TBaseCashGUI.LockLinefieldsonAccessLevel(const DoLock:Boolean);
//begin
//  if AccessLevel <=3 then begin
//    if not DoLock then begin
//      Readonlyfield(tblDetailsLineTaxCode.FieldName  , False);
//    end else begin
//      if AllowChangingProdutTaxCodeinSales = False then
//        if tbldetailslinetaxcode.readonly = false then
//          if tbldetailslinetaxcode.asString <> '' then
//            Readonlyfield(tblDetailsLineTaxCode.FieldName  , true);
//    end;
//
//    if AllowChangingProdutUOMinSales = False then
//      if tblDetailsUnitofMeasureSaleLines.readonly = false then
//        if tblDetailsUnitOfMeasureID.asInteger <> 0 then
//          Readonlyfield(tblDetailsUnitofMeasureSaleLines.FieldName  , true);
//  end;
//end;

procedure TBaseCashGUI.NewTransBusObjinstance;
begin
  TransBase := Cashbase;
  inherited;
(*  TransBase.Connection := TMyDacDataConnection.Create(TransBase);
  TMyDacDataConnection(TransBase.Connection).MyDacConnection := MyConnection;*)
end;

Procedure TBaseCashGUI.ApplyPreferences;
begin
      grdTransactions.ColumnByName('Attrib1Sale').DisplayLabel := AppEnv.CompanyPrefs.ProductAttrib1Name;
      grdTransactions.ColumnByName('Attrib2Sale').DisplayLabel := AppEnv.CompanyPrefs.ProductAttrib2Name;
      grdTransactions.ColumnByName('Attrib1SaleRate').DisplayLabel := 'Price / ' + AppEnv.CompanyPrefs.ProductAttrib1Name;

    Setcolumn(Appenv.CompanyPrefs.ShowMeasurementAttributes, 'Attrib1Sale');
    Setcolumn(Appenv.CompanyPrefs.ShowMeasurementAttributes, 'Attrib2Sale');
    Setcolumn(Appenv.CompanyPrefs.ShowMeasurementAttributes, 'Attrib1SaleRate');
    Setcolumn(Appenv.CompanyPrefs.ShowSalesUnits, 'UnitofMeasureSaleLines');
    Setcolumn(Appenv.CompanyPrefs.ShowSalesDescription, 'Product_Description');
    Setcolumn(Appenv.CompanyPrefs.ShowSalesTaxCode, 'LineTaxCode');
    Setcolumn(Appenv.CompanyPrefs.ShowSalesTaxAmount, 'LineTax');
    Setcolumn(Appenv.CompanyPrefs.ShowSalesDiscount, 'Discounts');
    Setcolumn(Appenv.CompanyPrefs.ShowSalesDiscount, 'DiscountPercent');
    Setcolumn(Appenv.CompanyPrefs.ShowLatestCost, 'LatestCostPrice');
    Setcolumn(Appenv.CompanyPrefs.ShowLatestCost, 'LatestCostPriceInc');
    Setcolumn(Appenv.CompanyPrefs.ShowGrossProfitPercent, 'CalcGrossProfitPercentInc');
    Setcolumn(False, tblDetailsSalesTaxBasedon.FieldName);

    (*if not AppEnv.CompanyPrefs.ShowMeasurementAttributes then  begin
      grdTransactions.RemoveField('Attrib1Sale');
      GuiPrefs.DbGridElement[grdTransactions].HideField('Attrib1Sale');
      grdTransactions.RemoveField('Attrib2Sale');
      GuiPrefs.DbGridElement[grdTransactions].HideField('Attrib2Sale');
      grdTransactions.RemoveField('Attrib1SaleRate');
      GuiPrefs.DbGridElement[grdTransactions].HideField('Attrib1SaleRate');
    end  else begin
      grdTransactions.AddField('Attrib1Sale');
      grdTransactions.AddField('Attrib2Sale');
      grdTransactions.AddField('Attrib1SaleRate');
      grdTransactions.ColumnByName('Attrib1Sale').DisplayLabel := AppEnv.CompanyPrefs.ProductAttrib1Name;
      grdTransactions.ColumnByName('Attrib2Sale').DisplayLabel := AppEnv.CompanyPrefs.ProductAttrib2Name;
      grdTransactions.ColumnByName('Attrib1SaleRate').DisplayLabel := 'Price / ' + AppEnv.CompanyPrefs.ProductAttrib1Name;
    end;

    if not AppEnv.CompanyPrefs.ShowSalesUnits then begin
        grdTransactions.RemoveField('UnitofMeasureSaleLines');
        GuiPrefs.DbGridElement[grdTransactions].HideField('UnitofMeasureSaleLines');
    end else
        grdTransactions.AddField('UnitofMeasureSaleLines');

    if not AppEnv.CompanyPrefs.ShowSalesDescription then begin
        grdTransactions.RemoveField('Product_Description');
        GuiPrefs.DbGridElement[grdTransactions].HideField('Product_Description');
    end else grdTransactions.AddField('Product_Description');

    if not AppEnv.CompanyPrefs.ShowSalesTaxCode then begin
        grdTransactions.RemoveField('LineTaxCode');
        GuiPrefs.DbGridElement[grdTransactions].HideField('LineTaxCode');
    end  else grdTransactions.AddField('LineTaxCode');
    if not AppEnv.CompanyPrefs.ShowSalesTaxAmount then begin
        grdTransactions.RemoveField('LineTax');
        GuiPrefs.DbGridElement[grdTransactions].HideField('LineTax');
    end else grdTransactions.AddField('LineTax');

    if not AppEnv.CompanyPrefs.ShowSalesDiscount then begin
        grdTransactions.RemoveField('Discounts');
        GuiPrefs.DbGridElement[grdTransactions].HideField('Discounts');
    end else begin
        grdTransactions.AddField('Discounts');
        grdTransactions.SetActiveField('DiscountPercent');
        grdTransactions.SetActiveField('Discounts');
    end;   *)

    grdTransactions.SetActiveField('ProductPrintName');
    SetControlFocus(cboClientR);

  (*if not AppEnv.CompanyPrefs.ShowLatestCost then begin
      grdTransactions.RemoveField('LatestCostPrice');
      GuiPrefs.DbGridElement[grdTransactions].HideField('LatestCostPrice');
      grdTransactions.RemoveField('LatestCostPriceInc');
      GuiPrefs.DbGridElement[grdTransactions].HideField('LatestCostPriceInc');
  end;

    if not AppEnv.CompanyPrefs.ShowGrossProfitPercent then begin
      grdTransactions.RemoveField('CalcGrossProfitPercentInc');
      GuiPrefs.DbGridElement[grdTransactions].HideField('CalcGrossProfitPercentInc');
    end;*)
end;
function TBaseCashGUI.DisfieldstoRemove: String;
Procedure addresult (const value:String);
begin
  if value = '' then exit;
  if result <> '' then result := result +',';
  REsult := result + value;
end;
begin
  Result := '';
(*  if not Sametext(Appenv.CompanyPrefs.DefaultDiscountMarkup , 'Margin'          ) then addResult('Margin');
  if not Sametext(Appenv.CompanyPrefs.DefaultDiscountMarkup , 'MarginPercent'   ) then addResult('MarginPercent');*)
  if not Sametext(Appenv.CompanyPrefs.DefaultDiscountMarkup , 'Discount'        ) then addResult('Discount');
  if not Sametext(Appenv.CompanyPrefs.DefaultDiscountMarkup , 'DiscountPercent' ) then addResult('DiscountPercent');
  if not Sametext(Appenv.CompanyPrefs.DefaultDiscountMarkup , 'MarkupPercent'   ) then addResult('MarkupPercent');
  if not Sametext(Appenv.CompanyPrefs.DefaultDiscountMarkup , 'Markup'          ) then addResult('Markup');
end;
procedure TBaseCashGUI.ShowAccountCbo(const Value: Boolean);
begin
  cboAccount.Visible := Value;
  lblAccount.Visible := Value;
end;

procedure TBaseCashGUI.ShowFormulafields;
begin
  inherited;
  Setcolumn(Appenv.CompanyPrefs.Fe1Visible,tblDetailsFormulaQtyShippedValue1.fieldname,Appenv.CompanyPrefs.Fe1Name);
  Setcolumn(Appenv.CompanyPrefs.Fe2Visible,tblDetailsFormulaQtyShippedValue2.fieldname,Appenv.CompanyPrefs.Fe2Name);
  Setcolumn(Appenv.CompanyPrefs.Fe3Visible,tblDetailsFormulaQtyShippedValue3.fieldname,Appenv.CompanyPrefs.Fe3Name);
  Setcolumn(Appenv.CompanyPrefs.Fe4Visible,tblDetailsFormulaQtyShippedValue4.fieldname,Appenv.CompanyPrefs.Fe4Name);
  Setcolumn(Appenv.CompanyPrefs.Fe5Visible,tblDetailsFormulaQtyShippedValue5.fieldname,Appenv.CompanyPrefs.Fe5Name);

  Setcolumn(Appenv.CompanyPrefs.Fe1Visible or
            Appenv.CompanyPrefs.Fe2Visible or
            Appenv.CompanyPrefs.Fe3Visible or
            Appenv.CompanyPrefs.Fe4Visible or
            Appenv.CompanyPrefs.Fe5Visible ,tblDetailsFormulaQtyShippedValue.fieldname , 'Formula ' + tbldetailsUnitofMeasureShipped.displaylabel );

end;

procedure TBaseCashGUI.FormShow(Sender: TObject);
var
  s,TempStr, OriginalProdSQL: string;
begin
  stepProgressbar;
  GuiPrefs.DbGridElement[grdTransactions].RemoveFields(
    'IsQuote,SaleLineID,GlobalRef,SaleID,ProductID,ProductGroup,PartType,'+
    'IncomeAccnt,AssetAccnt,CogsAccnt,LineWholesalePrice,LineTaxRate,'+
    //'LineCost,LineCostInc,'+
    'QtySold,BackOrder,Invoiced,Markup,MarkupPercent,'+
    'DiscountPercent,EditedFlag,Deleted,'+
    'LaybyID,CalcPriceInc,CalcTotalInc,CalcTotalEx,CalcTax,CalcBackOrder,'+
    'CalcLinePriceEx,OrgLinePrice,CalcTotalIncB4Discount,Attrib1Sale,'+
    'Attrib2Sale,Attrib1SaleRate,LastLineID,UnitofMeasureQtySold,'+
    'UnitofMeasureBackorder,UnitofMeasureMultiplier,SupplierContact,'+
    'ForeignCurrencyLinePrice,ForeignExchangeSellRate,'+
    'ForeignExchangeSellCode,SearchFilter,SearchFilterCopy,'+
    'IsRelatedProduct,RelatedParentProductID,SoldSerials,UnitOfMeasureID,'+
    'SortId,LinesOrder,SeqNo,RelatedParentLineRef,CustomData,LastUpdated,MatrixRef,'+
    'ForeignTotalLineAmount,RelatedProductQty,IsFormulaRElatedProduct,FormulaID,'+
    'FormulaQtySoldValue,FormulaQtySoldValue1,FormulaQtySoldValue2,FormulaQtySoldValue3,'+
    'FormulaQtySoldValue4,FormulaQtySoldValue5');

  bIsCalcStarted := false;
  try

    OriginalProdSQL := cboProductQry.SQL.Text;

    inherited;
    if appenv.CompanyPrefs.EnableAutoSplitQtyintoUOMinSales then  begin
    s:=tblDetailsUnitofMeasureSaleLines.DisplayLabel;
    if pos(' (F8)', s) = 0 then begin
      s:=s+' (F8)';
      tblDetailsUnitofMeasureSaleLines.DisplayLabel := s;
      UpdateSelectedProp(grdtransactions.Selected, tblDetailsUnitofMeasureSaleLines.fieldname, s, sptUpdateLabel);
    end;
  end;


    ApplyCustomFieldsSettings;
    CashBase.Lines.Dataset.filter := CashBase.TranslineFilter;
    CashBase.Lines.Dataset.Filtered:= true;
    CashBase.SalesPayments.Dataset.filter := 'Deleted <> ' + QuotedStr('T');
    CashBase.SalesPayments.Dataset.Filtered := true;

    lblBaseForeignCurrencyCode.Visible := false;
    cboBaseForeignCurrencyCode.Visible := false;
    lblBaseExchangeRate.Visible        := false;
    edtBaseExchangeRate.Visible        := false;

    if KeyID = 0 then begin
    end else begin
        cboPaymentMethod.Enabled := Cashbase.SalesPayments.Dataset.Recordcount <= 1;
    end;

    //Product Combo Product Name Width Set
    TempStr := ExtractStrPortion(cboProductR.Selected[0], #9, 2);
    //cboProductR.Selected[0] := ReplaceStr(cboProductR.Selected[0], TempStr, IntToStr(AppEnv.CompanyPrefs.ProductNameDropdownWidth));
    //FormatProductCombo(cboProductR);

    ClassLabel.Caption := AppEnv.DefaultClass.ClassHeading;
    ShowAccountCbo(cboAccountQry.RecordCount > 1);
    //PriceChange        := false;

    // hide columns according to company prefs and access levels
    //if not AppEnv.CompanyPrefs.ShowSalesUnits then grdTransactions.RemoveField('UnitofMeasureSaleLines');
    ApplyPreferences;

    SetControlFocus(cboClientR);
    if tblDetails.IndExFieldNames ='' then tblDetails.IndexFieldNames := 'LinesOrder ASC';

    SetControlFocus(cboClientR);

    btnDeposit.Visible := (ftLockType = ltDeposited);
    btnPayments.Visible := (ftLockType = ltPaymentApplied);

    cboProductR.AutoDropDown := True;
    cboProductqry.Open;

    fProductLookupSQL := cboProductqry.sql.text;
    AddDynamicMenuItems;

  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do begin
      HandleNoAccessException(e);
      Exit;
    end;
    else raise;
  end;
  fLockSalesInitialized:= False;
  LockSales;
  stepProgressbar;

end;
Procedure TBAseCashGUI.AddDynamicMenuItems;
var
  mnu : TMenuItem;
begin
  NewMenuForTransGrid('Product Prices' , ProductPricesClick , FAlse);
  NewMenuForTransGrid('Sale Custom Fields' , mnuSaleCustomFieldsClick , FAlse);
  NewMenuForTransGrid('Line Custom Fields' , CustomFields1Click , FAlse);
(*
begin
  if Assigned(grdTransactions.Popupmenu) then begin
    mnu := TMenuItem.Create(self);
    mnu.Caption := 'Product Prices';
    mnu.OnClick := ProductPricesClick;
    grdTransactions.Popupmenu.Items.Add(mnu);
  end;*)

  if Assigned(pnlHeader.Popupmenu) then begin
    mnu := TMenuItem.Create(self);
    mnu.Caption := 'Product Prices';
    mnu.OnClick := ProductPricesClick;
    mnu.hint := 'This will open the Product Prices for the product of the selected line in the grid below';
    pnlHeader.Popupmenu.Items.Add(mnu);
  end;

end;
procedure TBaseCashGUI.CustomFields1Click(Sender:TObject);
begin
  if OpenERPFormModal('TfmCustomfieldList', 0, beforeshowCustomfieldList)>=0  then begin
    CustomfieldonGrid.ApplyCustomFieldsSettings;
  end;
end;
procedure TBaseCashGUI.beforeshowCustomfieldList(Sender: TObject);
begin
  if not(Sender is TfmCustomfieldList) then Exit;
  TfmCustomfieldList(Sender).ListType := ltCashlines;
end;

procedure TBaseCashGUI.mnuSaleCustomFieldsClick(Sender:TObject);
begin
  if OpenERPFormModal('TfmCustomfieldList', 0, BeforeShowSaleCustomFieldList) >= 0  then begin
  end;
end;
procedure TBaseCashGUI.BeforeShowSaleCustomFieldList(Sender: TObject);
begin
  if not(Sender is TfmCustomfieldList) then Exit;
  TfmCustomfieldList(Sender).ListType := ltCash;
end;

procedure TBaseCashGUI.ProductPricesClick(Sender:TObject);
begin
  if accesslevel = 1 then CashBase.PostDb;
  if CashBase.count =0 then exit;
  if accesslevel = 1 then CashBase.Lines.PostDb;
  if CashBase.Lines.Count =0 then exit;
  setcontrolfocus(grdtransactions);
  if  not(Iscolvisible(tbldetailsLinePrice.FieldName)) and not(Iscolvisible(tbldetailsLinePriceinc.FieldName)) then begin
        grdTransactions.AddField(tbldetailsLinePrice.FieldName);
        guiprefs.DbGridElement[grdTransactions].UnHideField(tbldetailsLinePrice.FieldName);
  end;
       if  (Iscolvisible(tbldetailsLinePrice.FieldName))    then grdtransactions.SetActiveField(tbldetailsLinePrice.FieldName)
  else if  (Iscolvisible(tbldetailsLinePriceinc.FieldName)) then grdtransactions.SetActiveField(tbldetailsLinePriceinc.FieldName)
  else exit;
  grdTransactionsDblClick(grdTransactions);
end;
procedure TBaseCashGUI.qryUnitOfMeasureBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryUnitOfMeasure.ParamByName('xPartID').AsInteger := tblDetails.FieldByName('ProductID').AsInteger;
end;

procedure TBaseCashGUI.cboEmployeeNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
begin
  Accept := false;//  NotInListWarning(Sender);; // stop not in list processing for this combo, for now
end;

procedure TBaseCashGUI.FormDestroy(Sender: TObject);
begin
  tblDetails.Close;
  tblMaster.Close;
  MyConnection.Close;
  FreeandNil(ClientDiscountObj);
  FreeandNil(batchObj);
  ReceiptPrinterList.FreePrinter(oRcptPrn);
  Freeandnil(CustomFieldonGrid);
  inherited;
end;
Procedure TBaseCashGUI.SetMatrixDetails(  sMatrixDesc:String;  sMatrixRef:String;  dMatrixPrice:double);
begin
  CashBase.lines.MatrixDesc := sMatrixDesc;
    CashBase.lines.MatrixRef  := sMatrixRef;
    CashBase.lines.MatrixPrice:= dMatrixPrice;
    if CashBase.lines.MatrixPrice <> 0 then  begin
      CashBase.lines.ignoreCheckSaveSpecialPrice:= true;
      Try
        CashBase.lines.LinePrice :=CashBase.lines.MatrixPrice;
        CashBase.lines.CallDoFieldOnChange(tblDetailsLinePrice);
      Finally
        CashBase.lines.ignoreCheckSaveSpecialPrice:= False;
      End;
    end;
    CashBase.lines.PostDB;
end;

procedure TBaseCashGUI.DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
var
  MatrixDesc:String;
  MatrixRef:String;
  MatrixPrice:double;
begin
{-->} if (EventType = BusobjEvent_ToDo) and (Value = BusobjEvent_AutosplitQty ) then begin
      if (Screen.activecontrol = grdtransactions) and (Sametext(ActiveFieldname , tblDetailsUnitofMeasureQtySold.FieldName)) then
          //DoAutoSplitQty;
{-->} end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_SpecialPrice) then begin
        if (fbAutoSplitQty =False) and (fbCalcQtyForAre=False) then begin
          if (CommonLib.MessageDlgXP_Vista('Do You Wish To Add This Product To' + #13 + #10 +
              'Customers Special Price List ?',mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
              ClientDiscountObj.Client_Add_SpecialPrice(CashBase.ClientId,
                                                        TCashLineBase(Sender).ProductID,
                                                        TCashLineBase(Sender).LinePrice);
          end;
        end;
{-->} end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_OnProductChange) then begin
//        LockLinefieldsonAccessLevel(False);
        LockLineFields := false;
{-->} end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_ProductChanged) then begin
        if TCashLineBase(Sender).Product.ShowProductPopUp then
          DelayMessageDlg(TCashLineBase(Sender).Product.ProductPopUpNotes, mtInformation, [mbOK], 0);
        CashBase.Lines.IsRelatedProduct := False;
        CashBase.Lines.ParentProductID := 0;
        CashBase.Lines.RelatedProductQty := 0;
        CashBase.Lines.RelatedParentLineRef :='';

            //CommonLib.MessageDlgXP_Vista(TCashLineBase(Sender).Product.ProductPopUpNotes, mtInformation, [mbOK], 0);
        DoOnProductchange;
        if not CashBase.Lines.deleted then begin
          ReadSalesDefaultPriceMethod(CashBase.Lines.ProductID,MatrixDesc, MatrixRef,MatrixPrice);
          SetMatrixDetails(MatrixDesc,MatrixRef ,MatrixPrice);
        end;
{-->} end else if (EventType = BusObjEvent_Change) and (Value = BusObjEventVal_QtySold) then begin
        Cashbase.Lines.updaterelatedPartsQty;
{-->} end else if (EventType = BusObjEvent_Change) And (value = BusObjEventVal_ClientID) then begin
          InitClientLookupCombonFields;
          Opendb(qryClientLookup);
          DoDelayObjectProcedure(DoOnClientchange,10 , Self.classname +'.DoOnClientchange');
{-->} end else if (EventType = BusObjEvent_Change) And (value = BusObjEventVal_uomChanged) then begin
        if qryUnitOfMeasureUnitID.AsInteger <> CashBase.Lines.UnitOfMeasureID then begin
           closedb(qryUnitOfMeasure);
           opendb(qryUnitOfMeasure);
           qryUnitOfMeasure.locate('unitID' , CashBase.Lines.UnitOfMeasureID , []);
        end;
{-->} end else  if (EventType = BusObjEvent_Change) And (value = BusObjEventVal_SalesLineCost) then begin
          TransTimerMsg(Appenv.CompanyPrefs.SalesLineLatestCostBasedOnMsg, 20);
{-->} end else if (EventType = BusobjEvent_ToDo) and (Value = BusObjEvent_BlankAccount) and (Sender is TTransBase) then begin
        ShowAccountCbo((Cashbase.GLAccountId =0) or (Cashbase.GLAccountname = ''));
  end ;
  inherited;
end;

procedure TBaseCashGUI.DoOnProductchange;
begin
  if Matrixshown then Exit;

  fLastComboAccessed := cboProductR;
  inherited;
  Cashbase.Lines.updaterelatedPartsQty;
  EditDb(tblDetails);
  RefreshUnitsQry;
  Cashbase.Lines.updaterelatedPartsQty;
//    LockLinefieldsonAccessLevel(true);
  CheckForSalesTaxBasedon( (fISSalesLineLocked) or (fSalesLocked) );
  LockLineFields := true;
end;

procedure TBaseCashGUI.PerformComboRedrop(var Msg: TMessage);
begin
  SetControlFocus(cboProductR);
  cboProductR.DropDown;
  fbUpdateNow := true;
end;


procedure TBaseCashGUI.PopulateMessageSubstituteList(SL: TStringList);
begin
  inherited;
  self.CashBase.PopulateMessageSubstituteList(SL);
end;

procedure TBaseCashGUI.FormCreate(Sender: TObject);
begin

  fbAutoSplitQty:= false;
  fbCalcQtyForAre:= False;

  DefaultValueForAreaFromHint(Appenv.CompanyPrefs.SalesDefaultValueForAreaFrom);
  fLastComboAccessed := nil;
  barCodeCreated :=  false;
  Newbarcode:= '';
  inherited;
  fbUpdateNow := false;
  qryPayments.Connection := MyConnection;  // want this query in transaction mode
  ClientDiscountObj := TClientDiscountObj.Create;

  btnCashDrawer.Visible := AppEnv.CompanyPrefs.OpenCashDrawerFromCashSale;
  if AppEnv.CompanyPrefs.OpenCashDrawerFromCashSale then begin
    CreateReceiptPrinter;
  end;

  fbDontRefreshCalcs := false;
  fbSkipInherit := false;

end;

procedure TBaseCashGUI.grdPaymentsExit(Sender: TObject);
begin
  inherited;
  //  check totals
end;


procedure TBaseCashGUI.actcheckdiscountExecute(Sender: TObject);
begin
  inherited;
      ShowPriceCalc;
end;

procedure TBaseCashGUI.actcheckdiscountUpdate(Sender: TObject);
begin
  inherited;
  actcheckdiscount.enabled := (Cashbase.customerid<>0) and (Cashbase.Lines.count >0 )
                              and (Cashbase.Lines.ProductID>0) and (Cashbase.lines.UnitOfMeasureID<>0)
                              and (Cashbase.lines.QtySold<> 0) ;

end;

procedure TBaseCashGUI.actSplitPayExecute(Sender: TObject);
begin
  inherited;
  if Cashbase.TotalAmountInc <> 0 then begin
      Cashbase.PostDB;
      if not fbPaymentLock then begin
        chkInvoice.Enabled := false;
        lblInvoice.Enabled := false;
        CashBase.SalesPayments; // this enforces opening the query for the current salesID
        with TCashPayGUI.Create(Self) do try
            Salespayments := Self.CashBase.Salespayments;
            IsRefundTrans := Self.CashBase is TRefundSale;
            if ShowModal = mrOk then begin
              CashBase.SalesPayments.PostDB;
            end;
          finally
            Free;
          end;
      end;
  End;
end;

procedure TBaseCashGUI.actSplitPayUpdate(Sender: TObject);
begin
  inherited;

  if fbPaymentLock then begin
    chkInvoice.Enabled       := false;
    lblInvoice.Enabled       := false;
    cboPaymentMethod.Enabled := false;
    actSplitPay.Enabled      := false;
  end else begin
    actSplitPay.Enabled      := (CashBase.Lines.count > 0) and not chkInvoice.Checked and not(Cashbase.InvoiceRefund);//and  IsOkToSave;
    cboPaymentMethod.Enabled := not chkInvoice.Checked;
    (*txtPONumber.Enabled      := not chkInvoice.Checked;*)
  end;
end;

procedure TBaseCashGUI.cboPaymentMethodChange(Sender: TObject);
begin
  inherited;
  chkInvoice.Enabled := Empty(cboPaymentMethod.Text);
  lblInvoice.Enabled := Empty(cboPaymentMethod.Text);
end;



procedure TBaseCashGUI.grdTransactionsEnter(Sender: TObject);
begin
    ShowNoCustomerWarning;
    if Cashbase.lines.Dataset.REcordcount = 0 then
        if Cashbase.lines.Dataset.State <> dsInsert then begin
            Cashbase.lines.PostDB;
            Cashbase.lines.New;
        End;
    inherited;
    fLockSalesInitialized:= False;
    LockSales;
end;
function TBaseCashGUI.ShowNoCustomerWarning : boolean;
begin
  result := false;
  if Empty(cboClientR.Text) then
  begin
    result := true;
    CommonLib.MessageDlgXP_Vista('Select Customer First.', mtWarning, [mbOk], 0);
    if cboClientR.Visible and cboClientR.Enabled then
      SetControlFocus(cboClientR);
//    if edtCompanySearchFilter.Visible and edtCompanySearchFilter.Enabled then
//      SetControlFocus(edtCompanySearchFilter);
  end;
end;

procedure TBaseCashGUI.grdTransactionsRowChanged(Sender: TObject);
begin
  inherited;
  if CashBase.lines.ProductId = 0 then Exit;
  RefreshUnitsQry;
  fLockSalesInitialized:= False;
  LockSales;
end;

procedure TBaseCashGUI.CreateReceiptPrinter;
var
  sPrnType: string;
begin
  sPrnType := AppEnv.CompanyPrefs.ReceiptPrinterType;
  // perhaps if we leave this here we should get smater and develop a CreatePrinter
  // .. function to be used in conjuntion with POS
  oRcptPrn := ReceiptPrinterList.CreatePrinter(sPrnType, appEnv.CompanyPrefs.USBPrinterName);
  oRcptPrn.SetDevice(AppEnv.CompanyPrefs.ReceiptPrinterPort);
  oRcptPrn.Initialize;
end;

procedure TBaseCashGUI.btnCashDrawerClick(Sender: TObject);
begin
  inherited;
  oRcptPrn.OpenCashDrawer;
end;

procedure TBaseCashGUI.btnNextClick(Sender: TObject);
begin
  inherited;
end;

//procedure TBaseCashGUI.RequeryFilteredProducts;
//var
//  iX: integer;
//  A: integer;
//begin
//  with cboProductQry do begin
//    Close;
//    for iX := 0 to SQL.Count - 1 do begin
//      // Test to see if this SQL line is the WHERE clause.
//      A := FastFuncs.PosExIgnoreCase('WHERE ',SQL.Strings[iX]);
//      if A >0 then Break;
//    end;
//
//    // Test to see if a search filter has been provided?
//    if tblDetailsSearchFilter.AsString <> '' then begin
//      // Yes, then setup query to get only filtered matched products.
////      if SearchMode = smSearchEngineLike then
//        SQL.Strings[iX] := 'WHERE (Active = ' + QuotedStr('T') + ' AND PARTNAME LIKE ' +
//          QuotedStr('%' + tblDetailsSearchFilter.AsString + '%') + ')';
////      if SearchMode = smSearchEngine then
////        SQL.Strings[iX] := 'WHERE (Active = ' + QuotedStr('T') + ' AND PARTNAME LIKE ' +
////          QuotedStr(tblDetailsSearchFilter.AsString + '%') + ')';
//    end else begin
//      // Otherwise, hit us with every product.
//      SQL.Strings[iX] := 'WHERE (Active = ' + QuotedStr('T') + ')';
//    end;
//
//    // We need to get rid of this to ensure we get an appropriate list.
//    if SQL.Strings[SQL.Count - 1] = 'LIMIT 0' then SQL.Delete(SQL.Count - 1);
//    Open;
//  end;
//end;

// This one requires you to pass a part ID.
//procedure TBaseCashGUI.RequeryFilteredProducts(const FilterString: string);
//var
//  iX: integer;
//  A: integer;
//begin
//  with cboProductQry do begin
//    Close;
//    for iX := 0 to SQL.Count - 1 do begin
//      // Test to see if this SQL line is the WHERE clause.
//      A := FastFuncs.PosExIgnoreCase('WHERE ',SQL.Strings[iX]);
//      if A >0 then Break;
//    end;
//
//    // Yes, then setup query to get only filtered matched products.
//    SQL.Strings[iX] := 'WHERE (Active = ' + QuotedStr('T') + ' AND PARTSID = ' + QuotedStr(FilterString + '%') + ')';
//    // We need to get rid of this to ensure we get an appropriate list.
//    if SQL.Strings[SQL.Count - 1] = 'LIMIT 0' then SQL.Delete(SQL.Count - 1);
//    Open;
//  end;
//end;

procedure TBaseCashGUI.grdTransactionsCalcTitleAttributes(Sender: TObject; const AFieldName: string;
  const AFont: TFont; const ABrush: TBrush; var ATitleAlignment: TAlignment);
begin
  inherited;

  if AppEnv.CompanyPrefs.ShowLatestCost then begin
    if (AFieldName = 'LatestCostPrice') or (AFieldName = 'LatestCostPriceInc') then begin
      ABrush.Color := clBtnFace;
      Exit;
    end;
  end;
end;


procedure TBaseCashGUI.grdTransactionsColEnter(Sender: TObject);
var
  Field: TField;
  AFieldName: string;
begin
  inherited;
  Field := grdTransactions.GetActiveField;
  AFieldName := Field.Name;
  if (AFieldName = 'tblDetailsLinePriceInc') or (AFieldName = 'tblDetailsLinePrice') then begin
    CheckForSalesTaxBasedon( (fISSalesLineLocked) or (fSalesLocked) );
  end;
end;

procedure TBaseCashGUI.grdTransactionsDblClick(Sender: TObject);
var
  sMatrixRef:String;
  dMatrixPrice:double;
  sMatrixDesc:String;
begin
  if (TField(grdTransactions.GetActiveField).FieldName = 'MatrixDesc') or (TField(grdTransactions.GetActiveField).FieldName = 'MatrixPrice') then begin
    if (TField(grdTransactions.GetActiveField).FieldName = 'MatrixDesc') or (TField(grdTransactions.GetActiveField).FieldName = 'MatrixPrice') then begin
      sMatrixDesc:=CashBase.Lines.MatrixDesc;
      sMatrixRef := CashBase.Lines.MatrixRef;
      dMatrixPrice:= CashBase.Lines.MatrixPrice;
      TfmpartsPriceMatrixInput.PriceMAtrix(Self, sMatrixRef, sMatrixDesc ,  dMatrixPrice, CashBase.lines.ProductId, Myconnection);
      SetMatrixDetails(sMatrixDesc,sMatrixRef ,dMatrixPrice);
      Abort;// this is to cancel the memodialag popup for this field
    end;
  end else if (SameText(TField(grdTransactions.GetActiveField).FieldName , 'LinePrice')) or (SameText(TField(grdTransactions.GetActiveField).FieldName , 'LinePriceinc')) then begin
    ShowPricecalc;
  end;
  inherited;
end;
Procedure TBaseCashGUI.ShowPriceCalc;
begin
  TfmproductPrices.showProduct(CashBase.Lines.productId, CashBase.customerid, '' , CashBase.lines.UnitOfMeasureID , CashBase.lines. QtySold  , CashBase.lines.LineTaxRate ,CashBase.Lines.MatrixRef , CashBase.Lines.MArginAmount, CashBase.Lines.MarginPErcent);
end;
procedure TBaseCashGUI.grdTransactionsTitleButtonClick(Sender: TObject; AFieldName: string);
begin
  inherited grdTransactionsTitleButtonClick(Sender, AFieldName);
  if (Sametext(AFieldName,'Discounts')) or (Sametext(AFieldName,'Markup')) or (Sametext(AFieldName,'DiscountPercent')) or (Sametext(AFieldName,'MarkupPercent')) (*or (Sametext(AFieldName,'Margin')) or (Sametext(AFieldName,'MarginPercent'))*) then begin
      popDscntMrkup.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
      Invalidate;
  end else if (Sametext(AFieldName,'Margin')) then begin
    ChangeCurfield('MarginPercent');
  end else if (Sametext(AFieldName,'MarginPercent')) then begin
    ChangeCurfield('Margin');
  end else begin
    if AppEnv.CompanyPrefs.ShowLatestCost then begin
             if (AFieldName = 'LatestCostPrice')    then GuiPrefs.SwapPairdfield('LatestCostPrice'    ,'LatestCostPriceInc')
        else if (AFieldName = 'LatestCostPriceInc') then GuiPrefs.SwapPairdfield('LatestCostPriceInc' ,'LatestCostPrice');
    end;
  end;
end;

procedure TBaseCashGUI.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
(*var
  ProductId: integer;
  ProductName: string;
  OriginalSearchText:string;
  OriginalKey:Word;*)
begin
  inherited;
  if Screen.Activecontrol = grdTransactions then
    if SameText(Activefieldname, tblDetailsUnitofMeasureShipped.FieldName) then begin
        (*If (Key = VK_F9) then begin
            if Cashbase.lines.product.AreaCoverageofsingleQty <> 0 then begin
              CAshbase.lines.PostDB;
              if (CAshbase.lines.UOMQtyShipped<>0) then begin
                fbCalcQtyForAre := True;
                try
                  CAshbase.lines.UOMQtyShipped := divzer(CAshbase.lines.UOMQtyShipped , Cashbase.lines.product.AreaCoverageofsingleQty);
                  CAshbase.lines.PostDB;
                  Key := vk_f8;
                  FormKeyDown(Sender, Key,Shift);
                finally
                  fbCalcQtyForAre:= False;
                end;
              end;
            end;
        end;*)
        If (Key = VK_F8) and (accesslevel =1 ) then
          if Appenv.CompanyPrefs.EnableAutoSplitQtyintoUOMinSales then
            if CAshbase.lines.product.EnableAutoSplitQtyintoUOMinSales then begin
              CAshbase.lines.PostDB;
              if   (CAshbase.lines.UOMQtyShipped <> 0) and
                  ((trunc(divzer(CAshbase.lines.UOMQtyShipped, CAshbase.lines.UOMMultiplier)) <> divzer(CAshbase.lines.UOMQtyShipped, CAshbase.lines.UOMMultiplier)) or (CAshbase.lines.UOMMultiplier=1)) then begin
                Key :=0;
                DoAutoSplitQty;
                Exit;
              end;
            end;
        end;
  if tblMasterClientID.AsInteger < 1 then Exit;
end;

procedure TBaseCashGUI.FormKeyPress(Sender: TObject; var Key: char);
begin
  // used to signal beginning of a barcode
  //if Key = '~' then Key := Chr(0);
  inherited;
end;

(*procedure TBaseCashGUI.UpdateFromContact(const Value: TDataSet);
Var
  strTemp: String;
Begin
  Inherited;
  if AccessLevel > 3 then
    exit;
  If Not Value.FieldByName('contacttitle').IsNull Then strTemp := Value.FieldByName('contacttitle').AsString;

  If Not Value.FieldByName('contactfirstname').IsNull Then
    If strTemp = '' Then strTemp := Value.FieldByName('contactfirstname').AsString
    Else strTemp                 := strTemp + ' ' + Value.FieldByName('contactfirstname').AsString;

  If Not Value.FieldByName('contactsurname').IsNull Then
    If strTemp = '' Then strTemp := Value.FieldByName('contactsurname').AsString
    Else strTemp                 := strTemp + ' ' + Value.FieldByName('contactsurname').AsString;

  CashBase.InvoiceToDesc := CashBase.ClientName + #13#10 + strTemp + #13 + #10 +
  // Contact Name
    Value.FieldByName('ContactAddress').AsString + #13 + #10 + Value.FieldByName('ContactAddress2').AsString + #13 + #10 + Value.FieldByName('ContactAddress3').AsString + #13 + #10 +
    Value.FieldByName('ContactCity').AsString + ' ' + Value.FieldByName('ContactState').AsString + ' ' + Value.FieldByName('ContactPcode').AsString;
  CashBase.ContactId := Value.FieldByName('ContactID').AsInteger;
  CashBase.PostDB;
  EmailContactID := Value.FieldByName('ContactID').AsInteger;
end;*)

procedure TBaseCashGUI.UpdateMe(const Cancelled: boolean; const aObject: TObject = nil);
begin
  if Cancelled then Exit;
    (*if Assigned(fLastComboAccessed) then begin
      fLastComboAccessed.Text := '';
      if Sysutils.SameText(fLastComboAccessed.Name, 'cboProductR') then begin
        fLastComboAccessed.LookupTable.Close;
        fLastComboAccessed.LookupTable.Open;
      end;
    end;
    end;*)
  if (Assigned(aObject) and (aObject is TBaseInputGUI) and Assigned(fLastComboAccessed)) then begin
    if Sysutils.SameText(fLastComboAccessed.Name, 'cboProductR') then begin
      with fLastComboAccessed do begin
        LookupTable.Close;
        LookupTable.Open;
        if LookupTable.Locate('PartsId', TBaseInputGUI(aObject).KeyID, []) then begin
          if not (tblDetails.State in [dsEdit, dsInsert]) then tblDetails.Edit;
//          tblDetails.FieldByName('ProductName').AsString := LookupTable.FieldByName('PartName').AsString;
          tblDetails.FieldByName('ProductId').AsInteger := LookupTable.FieldByName('PartsId').AsInteger;
          DoOnProductchange;
        end;
      end
    end;
  end;
  inherited UpdateMe(cancelled, aObject);
end;

function TBaseCashGUI.ClientState: String   ;begin  REsult:= Cashbase.Customer.state    ;end;
function TBaseCashGUI.Clientcountry:String  ;begin  REsult:= Cashbase.Customer.country  ;end;
function TBaseCashGUI.clientLocation:String ;begin  REsult:= Cashbase.Customer.suburb   ;end;
function TBaseCashGUI.ClientPostcode:String ;begin  REsult:= Cashbase.Customer.PostCode ;end;


procedure TBaseCashGUI.CompleteComboNotInList(const aObserver: TObject);
begin
  if Assigned(fLastComboAccessed) then SetControlFocus(fLastComboAccessed);
  InComboNotinList := False;
end;

procedure TBaseCashGUI.SetComboFocus(var Msg: TMessage);
begin
  if Assigned(fLastComboAccessed) then SetControlFocus(fLastComboAccessed);
end;

procedure TBaseCashGUI.SetLockLineFields(const Value: boolean);
begin
  if AccessLevel <=3 then begin
    fLockLineFields := Value;
    if not Value then begin
      Readonlyfield(tblDetailsLineTaxCode.FieldName  , False);
    end else begin
      if AllowChangingProdutTaxCodeinSales = False then
        if tbldetailslinetaxcode.readonly = false then
          if tbldetailslinetaxcode.asString <> '' then
            Readonlyfield(tblDetailsLineTaxCode.FieldName  , true);
    end;

    if not Value then begin
      Readonlyfield(tblDetailsUnitofMeasureSaleLines.FieldName  , False);
    end else begin
      if AllowChangingProdutUOMinSales = False then
        if tblDetailsUnitofMeasureSaleLines.readonly = false then
          if tblDetailsUnitOfMeasureID.asInteger <> 0 then
            Readonlyfield(tblDetailsUnitofMeasureSaleLines.FieldName  , true);
    end;
  end;
end;

procedure TBaseCashGUI.grdTransactionsExit(Sender: TObject);
begin
  inherited;
  fLastComboAccessed := nil;
end;

procedure TBaseCashGUI.grdTransactionsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((SameText(ActiveField(Sender).FieldName , 'MatrixDesc')) or (SameText(ActiveField(Sender).FieldName , 'MatrixPrice'))) and (key <> vk_return) and (Key <> vk_tab) then begin
    Key:=0;
    Exit;;
  end;
  inherited;
end;

//procedure TBaseCashGUI.AddProductOptionsProduct(const OldProductId, newProductID:Integer);
//begin
//  inherited;
//  if OldProductId =0 then Exit;
//  if NewProductId =0  then Exit;
//
//  if Cashbase.Lines.ProductID = OldProductId then Cashbase.Lines.Deleted := true
//  else if Cashbase.Lines.Locate('ProductId', OldProductId, []) then Cashbase.Lines.Deleted := true;
//  Cashbase.Lines.PostDb;
//
//
//  if newProductID <> -1 then begin
//    Cashbase.Lines.New;
//    Cashbase.Lines.ProductID := newProductID;
//    Cashbase.Lines.Qtysold := 1;
//    Cashbase.Lines.PostDB;
//  end;
//end;


procedure TBaseCashGUI.RefreshUnitsQry;
begin
  qryUnitOfMeasure.Close;
  qryUnitOfMeasure.ParamByName('xPartID').AsInteger := tblDetailsProductID.AsInteger;
  qryUnitOfMeasure.Open;
end;

procedure TBaseCashGUI.cboProductRAfterchange(Sender: TObject);
var
  NewProductId : Integer;
begin
  NewProductId := ProductOptionsShown;
  if NewProductId <> -1 then begin
    cboProductR.LookupTable.Refresh;
    cboProductR.LookupTable.Locate('PartsId', NewProductId, []);
  end;
end;

procedure TBaseCashGUI.cboProductRChange(Sender: TObject);
begin
  inherited;
  SaveLastComboAccessed(fLastComboAccessed ,Sender);
end;

procedure TBaseCashGUI.cboProductRKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
end;

(*function TBaseCashGUI.DoSameProductSearch(SearchText: string): Boolean;
begin
  Result := False;
  if SearchText = '' then exit;
  if cboProductqry.Active then cboProductqry.Close;
  cboProductqry.SQL.Text := fProductLookupSQL;
  cboProductqry.sql.Text := AnsiReplaceText(cboProductqry.sql.Text,'AND PartsID = 0','AND PartName = "' + SearchText + '"');

  cboProductqry.Open;
  cboProductR.LookupTable.Refresh;
  if cboProductqry.RecordCount > 0 then begin
    Application.ProcessMessages;
    cboProductR.DropDown;
    Result := True;
  end;
end;*)

(*function TBaseCashGUI.IsProductInList(sProductName: string): Boolean;
var
  frm:TComponent;
  SavedCursor:TCursor;
begin
  Result := True;
  if sProductName <> '' then begin
    if not cboProductqry.Locate('PartName',sProductName,[]) then begin
      Result := False;
      if (CommonLib.MessageDlgXP_Vista('Product name not in list. Do you wish to create it?', mtConfirmation , [mbYes, mbNo], 0) = mrYes) then begin
        Processingcursor(True);
        try
          frm := TfrmParts(GetComponentByClassName('TfrmParts'));
          TfrmParts(frm).fsPartName := sProductName;
          TfrmParts(frm).ShowModal;
          if TfrmParts(frm).ModalResult = mrOK then begin
            Result := True;
            cboProductQry.Close;
            cboProductQry.Open;
            cboProductR.LookupTable.Refresh;
          end else if TfrmParts(frm).ModalResult = mrCancel then Result := False;

        finally
          Processingcursor(False);
        end;
      end;
    end;
  end else Result := False;
end;*)

(*function TBaseCashGUI.DoProductSearch(SearchText: string): Boolean;
begin
  Result := False;
  fProductSearched := True;
  if SearchText = '' then exit;
  if cboProductqry.Active then cboProductqry.Close;
    cboProductqry.SQL.Text := fProductLookupSQL;
  cboProductqry.sql.Text := AnsiReplaceText(cboProductqry.sql.Text,'AND PartsID = 0','AND PartName LIKE "' + SearchText + '%"');

  cboProductqry.Open;
  cboProductR.LookupTable.Refresh;
  if cboProductqry.RecordCount > 0 then begin
    Application.ProcessMessages;
    cboProductR.DropDown;
    Result := True;
  end;
end;*)

procedure TBaseCashGUI.cboProductRNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
  if Trim(cboProductR.Text) = '~' then begin
    Accept := false;
    Exit;
  end;
  if cboProductR.LookupTable.RecordCount <> 0 then begin
    frmToPopup := TfrmParts(GetComponentByClassName('TfrmParts'));
    OnComboNotInList(Sender, LookupTable, NewValue, Accept);
    frmToPopup := nil;
  end;
end;

procedure TBaseCashGUI.tblDetailsCalcFields(DataSet: TDataSet);
begin
  inherited;
  tblDetailsUOMQtyInStock.AsFloat := CashBase.Lines.InStockUOMQty;
  tblDetailsUOMQtyAvailable.AsFloat := CashBase.Lines.AvailableUOMQty;
end;

procedure TBaseCashGUI.tblMasterCalcFields(DataSet: TDataSet);
var
  dt: TDateTime;
begin
  inherited;
  if tblMasterEnteredAt.AsString <> '' then begin
    try
      dt := StrToTime(tblMasterEnteredAt.AsString);
      tblMasterEnteredAtShort.AsString := FormatDateTime(FormatSettings.ShortTimeFormat,dt);
    except
      tblMasterEnteredAtShort.AsString := tblMasterEnteredAt.AsString;
      exit;
    end;
  end
  else begin
    tblMasterEnteredAtShort.AsString := '';
  end;
end;

function TBaseCashGUI.getcontactType: TContactType;
begin
  Result := tcustomercontact;
end;

function TBaseCashGUI.GetOrAddMobileNumber: string;
var
  aContact: TContact;
  aCustomer : TCustomer;
begin
  result := CashBase.ContactMobile;
  if result = '' then
    result := CashBase.Customer.Mobile;
  if result = '' then begin
    if CashBase.ContactID > 0 then begin
      { contact mobile }
      result := frmMobileNumberInput.GetMobileNumberFromUser('Contact (' + CashBase.ContactName +
        ') does not have a mobile number.' +#13#10 + 'Please enter a number.');
      if result <> '' then begin
        aContact := TContact.Create(nil);
        try
          aContact.Connection := TMyDacDataConnection.Create(aContact);
          aContact.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
          aContact.Load(CashBase.ContactID);
          if aContact.Lock then begin  { only update if we can lock }
            try
              aContact.ContactMOB := result;
              aContact.PostDb;
            finally
              aContact.UnLock;
            end;
          end;
        finally
          aContact.Free;
        end;
      end;
    end
    else begin
      { customer mobile }
      result := GetMobileNumberFromUser('Customer (' + CashBase.CustomerName +
        ') does not have a mobile number.' + #13#10 + 'Please enter a number.');
      if result <> '' then begin
        aCustomer := TCustomer.Create(nil);
        try
          aCustomer.Connection := TMyDacDataConnection.Create(aCustomer);
          aCustomer.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
          aCustomer.Load(CashBase.CustomerID);
          if aCustomer.Lock then begin  { only update if we can lock }
            try
              aCustomer.Mobile := result;
              aCustomer.PostDb;
              CashBase.Customer.RefreshDB;
            finally
              aCustomer.UnLock;
            end;
          end;
        finally
          aCustomer.Free;
        end;
      end;
    end;
  end
  else begin
    if (not SMSUtils.NumberHasPlusPrefix(result)) or (not SMSUtils.NumberHasCountryCode(result,MyConnection)) then begin
      if CashBase.ContactID > 0 then begin
        { contact mobile }
        result := GetMobileNumberFromUser('Contact (' + CashBase.ContactName +
          ') number format is incorrect.' +#13#10 + 'Please prefix number with "+" and country code.', result, MyConnection);
        if result <> '' then begin
          aContact := TContact.Create(nil);
          try
            aContact.Connection := TMyDacDataConnection.Create(aContact);
            aContact.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
            aContact.Load(CashBase.ContactID);
            if aContact.Lock then begin  { only update if we can lock }
              try
                aContact.ContactMOB := result;
                aContact.PostDb;
              finally
                aContact.UnLock;
              end;
            end;
          finally
            aContact.Free;
          end;
        end;
      end
      else begin
        { customer mobile }
        result := GetMobileNumberFromUser('Customer (' + CashBase.CustomerName +
          ') number format is incorrect.' +#13#10 + 'Please prefix number with "+" and country code.', result, MyConnection);
        if result <> '' then begin
          aCustomer := TCustomer.Create(nil);
          try
            aCustomer.Connection := TMyDacDataConnection.Create(aCustomer);
            aCustomer.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
            aCustomer.Load(CashBase.CustomerID);
            if aCustomer.Lock then begin  { only update if we can lock }
              try
                aCustomer.Mobile := result;
                aCustomer.PostDb;
                CashBase.Customer.RefreshDB;
              finally
                aCustomer.UnLock;
              end;
            end;
          finally
            aCustomer.Free;
          end;
        end;
      end;
    end;
  end;
end;

procedure TBaseCashGUI.cboProductQryAfterOpen(DataSet: TDataSet);
begin
  inherited;
  cboProductQry.IndExFieldNames := QuotedStr('PartName') + ' ASC CIS ; ' + QuotedStr('PartType') + ' ASC CIS';
end;

(*procedure TBaseCashGUI.cboBarcodeNotInList(Sender: TObject;
  LookupTable: TDataSet; NewValue: String; var Accept: Boolean);
begin
  inherited;
Newbarcode := NewValue;
  if CommonLib.MessageDlgXP_Vista('No product has the Barcode of ' + Newvalue +
              #10#13'Do you wish to assign this Barcode to a Product?', mtWarning, [mbYes, mbNo], 0) = mrno then begin
    Accept := false;
  end;
  with TProductListExpressGUI(GetComponentByClassName('TProductListExpressGUI', true)) do begin
        ExpresslistPopup('Choose Product' , CreateBarCode, False);
        Showmodal;
        Accept := false;
        if barCodeCreated then begin
            Qrybarcode.refresh;
            if Qrybarcode.locate('barcode' , newValue, []) then begin
              Accept := true;
              CashBase.Lines.PartBarcode := newvalue;
            end;
        end;
  end;
end;*)

(*procedure TBaseCashGUI.CreateBarCode(Sender: TObject);
begin
  with TwwDBGrid(Sender).Datasource.dataset do begin
    if active      = False then exit;
    if RecordCount = 0 then exit;
    if findfield('PartsId') = nil then exit;
    if fieldByname('PartsID').asInteger = 0 then exit;
    barCodeCreated:=  TProduct.AssignBarCode(fieldByname('PartsID').asInteger, Newbarcode);
  end;

end;
*)
procedure TBaseCashGUI.cboUnitOfMeasureCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not(modified) then exit;
  inherited;
  Cashbase.Lines.PostDb;
end;

procedure TBaseCashGUI.cboUnitOfMeasureDropDown(Sender: TObject);
begin
  inherited;
  if cashbase.Lines.ProductId = 0 then abort;
end;

procedure TBaseCashGUI.cboTaxCodeDropDown(Sender: TObject);
begin
  inherited;
  if cashbase.Lines.ProductId = 0 then abort;
end;
procedure TBaseCashGUI.TranslockComponents(var lockComponents: TStringDynArray);
begin
  inherited TranslockComponents(lockComponents);
  AddTranslockComponent(lockComponents, cboClass);
end;
function TBaseCashGUI.TransStatustype: String;
begin
  result := SimpleTypes_LeadStatusType;
end;

procedure TBaseCashGUI.InitSalesAutoSplitQty(Sender:TObject);
begin
  if not (Sender is TfmSalesAutoSplitQty) then exit;
  TfmSalesAutoSplitQty(Sender).SalesLineobj := CAshbase.Lines;
  TfmSalesAutoSplitQty(Sender).TransConnection := Self.Myconnection;
end;
procedure TBaseCashGUI.ApplyAutoSplitQty(Sender:TObject);
var
  SalesAutoSplitQty :TSalesAutoSplitQty;
  sXML:String;

  Procedure InitSaleLinefromSalesAutoSplitQtyLine;
  begin
          CAshbase.Lines.XML := sXML;
          CAshbase.Lines.UnitOfMeasureID  := SalesAutoSplitQty.SLLines.UOMID;
          CAshbase.Lines.UnitOfMeasure    := SalesAutoSplitQty.SLLines.UOM;
          CAshbase.Lines.UOMMultiplier    := SalesAutoSplitQty.SLLines.UOMMultiplier;
          CAshbase.Lines.UOMQtyShipped    := SalesAutoSplitQty.SLLines.Qty;
          CAshbase.Lines.PostDB;
          SalesAutoSplitQty.SLLines.SaleLineref :=CAshbase.Lines.Globalref;
          SalesAutoSplitQty.SLLines.PostDB;
  end;
begin
  if not (Sender is TfmSalesAutoSplitQty) then exit;

  try
    SalesAutoSplitQty := TSalesAutoSplitQty.Create(Self);
    try
      SalesAutoSplitQty.connection := CAshbase.Connection;
      SalesAutoSplitQty.LoadSelect('SaleLineref = ' + Quotedstr(CAshbase.Lines.Globalref));

      if SalesAutoSplitQty.count =0 then exit;

      {delete all where the qty is not selected}
      SalesAutoSplitQty.SLLines.filter := 'Qty =0';
      SalesAutoSplitQty.SLLines.filtered := TRue;
      SalesAutoSplitQty.SLLines.DeleteAll;

      SalesAutoSplitQty.SLLines.filter := '';
      SalesAutoSplitQty.SLLines.filtered :=False;

      if SalesAutoSplitQty.SLLines.count =0 then exit;

      if CAshbase.Lines.AreaQty <> 0 then
        CAshbase.Lines.ProductDescription := CAshbase.Lines.ProductDescription +
                                          ' Requested Qty was to Cover an area of ' + floatToStr(CAshbase.Lines.AreaQty )+'  = ' +
                                          floatToStr(SalesAutoSplitQty.Qty)+' ' + SalesAutoSplitQty.UOM +'(' +floattostr(SalesAutoSplitQty.UOMMultiplier)+')'
      else
        CAshbase.Lines.ProductDescription := CAshbase.Lines.ProductDescription +
                                          ' Requested Qty was ' + floatToStr(SalesAutoSplitQty.Qty)+' ' + SalesAutoSplitQty.UOM +'(' +floattostr(SalesAutoSplitQty.UOMMultiplier)+')';


      sXML:= CAshbase.Lines.XML;

      {overwrite the currenct sales line for the first record}
      SalesAutoSplitQty.SLLines.First;
      InitSaleLinefromSalesAutoSplitQtyLine;
      SalesAutoSplitQty.SLLines.NExt;

      {add new for the following records}
      while SalesAutoSplitQty.SLLines.Eof = False do begin
        try
          CAshbase.Lines.New;
          InitSaleLinefromSalesAutoSplitQtyLine;
        Except
          on E:Exception do begin
            if devmode then
              MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
          end;
        end;
        SalesAutoSplitQty.SLLines.NExt;
      end;
    finally
(*      SalesAutoSplitQty.SLLines.filtered := False;
      SalesAutoSplitQty.SLLines.deleteall;
      SalesAutoSplitQty.Deleteall;*)
      freeandnil(SalesAutoSplitQty );
    end;
  Except
    on E:Exception do begin
      if devmode then
         MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
    end;
  end;
end;
procedure TBaseCashGUI.DoAutoSplitQty;
begin
  if fbAutoSplitQty then exit;
  try
    fbAutoSplitQty := True;
    try
      CAshbase.InternalQuantityChange:= True;
      try
        OpenERPFormModal('TfmSalesAutoSplitQty' ,0 , InitSalesAutoSplitQty , False,ApplyAutoSplitQty )
      finally
        CAshbase.InternalQuantityChange:= False;
      end;
    finally
      fbAutoSplitQty:= False;
    end;
  Except
    on E:Exception do begin
      if devmode then
        MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
    end;
  end;
end;
procedure TBaseCashGUI.InitERPLookupCombonFields;
begin
  inherited;
  SetupProductNamenPrintNameinGrid(cboProductR ,cboPrintProductR ,'ProductName' , 'ProductPrintName' , 'PARTSDESCRIPTION' , grdTransactions );
end;
procedure TBaseCashGUI.ApplyCustomFieldsSettings;
begin
  CustomfieldonGrid := TCustomFieldonGrid.Create(Self,
    'SalesLinesCustField1,SalesLinesCustField2,SalesLinesCustField3,SalesLinesCustField4,SalesLinesCustField5,SalesLinesCustField6,SalesLinesCustField7,SalesLinesCustField8,SalesLinesCustField9,SalesLinesCustField10',
    ltCashlines, grdTransactions, guiprefs, Cashbase);
  CustomfieldonGrid.ApplyCustomFieldsSettings;
end;

end.














